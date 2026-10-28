#!/usr/bin/env python3
"""欣淇AI网 发文自检脚本。

按 CLAUDE.md 和 docs/framework/ 的标准检查中文文章（跳过 .en.md，英文由英文分支负责）。

用法：
  python3 scripts/lint_posts.py                 # 检查相对 origin/main 新增或改动的文章
  python3 scripts/lint_posts.py a.md b.md       # 检查指定文章
  python3 scripts/lint_posts.py --all --summary # 全站体检，只输出汇总

ERROR 是硬规则，必须改；WARN 是建议。检查指定或改动的文章时，有 ERROR 则退出码为 1。
存量文章（不是本次新增的）不检查 slug 年份规则，因为已发布网址不改。
"""
import argparse
import datetime as dt
import pathlib
import re
import subprocess
import sys
from collections import Counter

import yaml

ROOT = pathlib.Path(__file__).resolve().parent.parent
POSTS = ROOT / "content" / "posts"
TAX = yaml.safe_load((ROOT / "data" / "taxonomy.yaml").read_text(encoding="utf-8"))

CATEGORIES = set(TAX["categories"])
TYPE_TAGS = set(TAX["type_tags"])
TOPIC_TAGS = set(TAX["topic_tags"])
ENTITY_TAGS = set(TAX["entity_tags"])
ALL_TAGS = TYPE_TAGS | TOPIC_TAGS | ENTITY_TAGS
SYNONYMS = TAX.get("synonyms") or {}

# 类型标签 → 最低正文字数（CLAUDE.md「文章完整度标准」与 04-content-system.md）
MIN_LEN = {"快讯": 800, "档案": 1500, "教程": 2000, "评测": 2500, "对比": 2500,
           "合集": 2500, "指南": 2000, "复盘": 2000, "科普": 1500}

YEAR_SLUG = re.compile(r"(^\d{4}-\d{2}-\d{2}-)|(-20\d\d$)|(-20\d\d-)")
INTERNAL_LINK = re.compile(r"\]\((/(?:posts|categories|start|about|tags)/[^)\s]*)\)|\{\{<\s*ref")
EXTERNAL_LINK = re.compile(r"\]\((https?://[^)\s]+)\)")
IMAGE = re.compile(r"!\[([^\]]*)\]\(([^)\s]+)\)")


def text_len(body: str) -> int:
    """正文长度：中文按字、英文按词计。去掉代码块、链接地址和 Markdown 符号。"""
    body = re.sub(r"```.*?```", "", body, flags=re.S)
    body = re.sub(r"<!--.*?-->", "", body, flags=re.S)
    body = re.sub(r"\]\([^)]*\)", "]", body)
    cjk = len(re.findall(r"[一-鿿]", body))
    words = len(re.findall(r"[A-Za-z0-9][A-Za-z0-9.\-+]*", body))
    return cjk + words


def split_front_matter(raw: str):
    if not raw.startswith("---"):
        return None, raw
    end = raw.find("\n---", 3)
    if end == -1:
        return None, raw
    try:
        fm = yaml.safe_load(raw[3:end]) or {}
    except yaml.YAMLError:
        return None, raw
    return fm, raw[end + 4:]


def section(body: str, heading: str) -> str:
    m = re.search(rf"^##\s*{heading}.*?$(.*?)(?=^##\s|\Z)", body, flags=re.M | re.S)
    return m.group(1) if m else ""


def as_datetime(v):
    if isinstance(v, dt.datetime):
        return v
    if isinstance(v, dt.date):
        return dt.datetime(v.year, v.month, v.day, tzinfo=dt.timezone.utc)
    if isinstance(v, str):
        try:
            return dt.datetime.fromisoformat(v.replace("Z", "+00:00"))
        except ValueError:
            return None
    return None


def lint(path: pathlib.Path, is_new: bool):
    errors, warns = [], []
    raw = path.read_text(encoding="utf-8")
    fm, body = split_front_matter(raw)
    if fm is None:
        return ["front matter 缺失或格式错误"], []
    if not re.search(r"[\u4e00-\u9fff]", str(fm.get("title") or "")):
        return [], ["英文标题的文章，跳过（英文内容由英文分支负责）"]
    slug = path.stem

    if fm.get("draft"):
        warns.append("draft: true，不会发布")

    title = str(fm.get("title") or "")
    if not title:
        errors.append("缺 title")
    elif len(title) > 40:
        warns.append(f"title {len(title)} 字，建议 30 字以内")
    for bad in ("无限白嫖", "白嫖", "震惊"):
        if bad in title:
            errors.append(f"title 含禁用措辞「{bad}」")
    if "包过" in title:
        warns.append("title 含「包过」，除非是在辟谣，否则不要用")

    desc = str(fm.get("description") or "")
    if not desc:
        errors.append("缺 description")
    elif not 70 <= len(desc) <= 120:
        warns.append(f"description {len(desc)} 字，标准 70–120")

    date = as_datetime(fm.get("date"))
    if date is None:
        errors.append("缺 date 或格式无法识别")
    else:
        if date.tzinfo is None:
            warns.append("date 没有时区，建议写 +08:00")
        else:
            now = dt.datetime.now(dt.timezone.utc)
            if date > now and not fm.get("draft"):
                errors.append("date 晚于现在，Hugo 不会生成页面")
    if not fm.get("lastmod"):
        warns.append("缺 lastmod")

    cats = fm.get("categories") or []
    if len(cats) != 1:
        errors.append(f"categories 必须恰好 1 个，现在是 {cats}")
    elif cats[0] not in CATEGORIES:
        errors.append(f"分类「{cats[0]}」不在六个支柱里")

    tags = fm.get("tags") or []
    if not 3 <= len(tags) <= 5:
        errors.append(f"tags 应为 3–5 个，现在 {len(tags)} 个")
    old = [t for t in tags if t in SYNONYMS]
    unknown = [t for t in tags if t not in ALL_TAGS and t not in SYNONYMS]
    if old:
        hint = "，".join(f"{t}→{SYNONYMS[t] or '删除'}" for t in old)
        errors.append(f"使用了已归并的旧标签：{hint}")
    if unknown:
        errors.append(f"标签不在词表 data/taxonomy.yaml：{unknown}")
    types = [t for t in tags if t in TYPE_TAGS]
    if len(types) != 1:
        errors.append(f"类型标签应恰好 1 个（{'/'.join(sorted(TYPE_TAGS))}），现在 {types}")
    if not any(t in TOPIC_TAGS for t in tags):
        errors.append("至少要有 1 个主题标签")

    if is_new and YEAR_SLUG.search(slug):
        errors.append("新文章的 slug 不能带年份或日期")
    if is_new and not re.fullmatch(r"[a-z0-9]+(-[a-z0-9]+)*", slug):
        errors.append("slug 只能用小写英文、数字和短横线")

    n = text_len(body)
    kind = types[0] if len(types) == 1 else None
    if kind and n < MIN_LEN[kind]:
        errors.append(f"{kind}正文约 {n} 字，标准 ≥ {MIN_LEN[kind]}")

    h2 = len(re.findall(r"^##\s", body, flags=re.M))
    if n > 800 and n / (h2 + 1) > 800:
        warns.append(f"小标题偏少：约 {n} 字只有 {h2} 个 ##，标准每 400–600 字一个")

    internal = set(INTERNAL_LINK.findall(body))
    if len(internal) < 3:
        errors.append(f"站内链接 {len(internal)} 个，标准 ≥ 3")

    if kind == "快讯":
        src = EXTERNAL_LINK.findall(section(body, "参考来源"))
        if len(src) < 2:
            errors.append(f"快讯「参考来源」外链 {len(src)} 个，标准 ≥ 2")
    if kind in ("教程", "评测", "对比", "合集"):
        if not section(body, "常见问题"):
            errors.append("缺「## 常见问题」")
        if not section(body, "更新记录"):
            warns.append("缺「## 更新记录」")
    if kind in ("教程", "评测", "对比") and not IMAGE.search(body):
        warns.append("没有截图或图片")

    for alt, src in IMAGE.findall(body):
        if not alt.strip():
            warns.append(f"图片缺 alt：{src}")
        if src.startswith("/") and not (ROOT / "static" / src.lstrip("/")).exists():
            errors.append(f"图片不存在：{src}")
        if src.startswith("/images/") and not src.endswith(".webp"):
            warns.append(f"图片建议用 webp：{src}")

    lead = re.sub(r"<!--.*?-->|[#>*`\-\s]", "", body, flags=re.S)[:100]
    if len(lead) < 30:
        warns.append("开头 100 字内容太少，应先给结论")

    # 以下规则来自 docs/framework/12-pitfalls.md（2026-10 全站审计）
    prose = re.sub(r"```.*?```", "", section_free(body), flags=re.S)
    for m in sorted(set(FAKE_EXPERIENCE.findall(prose))):
        warns.append(f"疑似无法核实的个人经历「{m}」：没有真实测试就改成客观写法，见 12-pitfalls.md")
    stale = sorted(set(STALE_MODEL.findall(prose)))
    if stale:
        warns.append(f"出现过时模型名 {'、'.join(stale)}：确认是否已标明过时，见 12-pitfalls.md")
    if "Sora" in prose and not re.search(r"Sora[^。\n]{0,40}(停|关闭|下线)|(停|关闭|下线)[^。\n]{0,40}Sora", prose):
        warns.append("提到 Sora 但没说明已停止服务（2026-03 宣布）")
    if AFF_CLAIM.search(prose) and not AFF_LINK.search(body):
        warns.append("写了联盟链接 / 佣金声明，但文中找不到联盟或推荐链接")

    return errors, warns


def section_free(body: str) -> str:
    """去掉「更新记录」一节，避免记录里描述旧问题时被重复报警。"""
    return re.sub(r"^##\s*更新记录.*?(?=^##\s|\Z)", "", body, flags=re.S | re.M)


FAKE_EXPERIENCE = re.compile(
    r"用了(?:[一两三四五六七八九十半几]|\d+)(?:个)?(?:多)?(?:月|年|周|星期)"
    r"|花了(?:[一两三四五六七八九十半几]|\d+)(?:个)?(?:多)?(?:月|周|星期|天)(?:时间)?(?:实测|测试|试)"
    r"|我(?:实测|亲测|测试了|每天用|自己用|拿真实)"
    r"|作为(?:一[个名]\S{0,8}(?:用户|程序员|开发者|博主|站长|工程师)|深度用户)|关于作者|笔者"
)
STALE_MODEL = re.compile(r"GPT-4o(?:-mini)?|4o-mini|Claude 3(?:\.5|\.7)?(?=\s|[^\d.])|DALL[-·]E ?3")
AFF_CLAIM = re.compile(r"(?:我|本站)(?:可能)?会?获得(?:少量)?佣金|链接(?:是|为)(?:本站)?联盟链接")
AFF_LINK = re.compile(r"[?&](?:aff|ref|via|affiliate)=|/aff\.php|/go/")


def changed_files():
    def git(*args):
        r = subprocess.run(["git", *args], cwd=ROOT, capture_output=True, text=True)
        return r.stdout.split()
    base = "origin/main"
    added = set(git("diff", "--name-only", "--diff-filter=A", f"{base}...HEAD", "--", "content/posts"))
    added |= set(git("ls-files", "--others", "--exclude-standard", "--", "content/posts"))
    touched = set(git("diff", "--name-only", "--diff-filter=AM", f"{base}...HEAD", "--", "content/posts"))
    touched |= set(git("diff", "--name-only", "--diff-filter=AM", "--", "content/posts"))
    touched |= added
    return [(ROOT / f, f in added) for f in sorted(touched) if f.endswith(".md")]


def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("files", nargs="*")
    ap.add_argument("--all", action="store_true", help="检查全部中文文章")
    ap.add_argument("--summary", action="store_true", help="只输出汇总")
    a = ap.parse_args()

    if a.all:
        targets = [(p, False) for p in sorted(POSTS.glob("*.md"))
                   if not re.search(r"^draft:\s*true", p.read_text(encoding="utf-8"), flags=re.M)]
    elif a.files:
        tracked = subprocess.run(["git", "ls-files", "--", *a.files], cwd=ROOT,
                                 capture_output=True, text=True).stdout.split()
        def rel(f):
            try:
                return str(pathlib.Path(f).resolve().relative_to(ROOT))
            except ValueError:
                return f
        targets = [(pathlib.Path(f).resolve(), rel(f) not in tracked) for f in a.files]
    else:
        targets = changed_files()
    targets = [(p, new) for p, new in targets
               if p.exists() and not p.name.endswith(".en.md") and p.name != "_index.md"]
    if not targets:
        print("没有需要检查的中文文章。")
        return 0

    total_err = 0
    counter = Counter()
    for p, new in targets:
        errors, warns = lint(p, new)
        total_err += len(errors)
        for e in errors:
            counter[re.sub(r"[：:].*|\d+", "#", e)] += 1
        if a.summary:
            continue
        if errors or warns:
            print(f"\n{p.relative_to(ROOT)}{'（新文章）' if new else ''}")
            for e in errors:
                print(f"  ERROR {e}")
            for w in warns:
                print(f"  WARN  {w}")
    clean = sum(1 for p, new in targets if not lint(p, new)[0])
    print(f"\n检查 {len(targets)} 篇，{clean} 篇无 ERROR，共 {total_err} 个 ERROR。")
    if a.summary and counter:
        print("\n最常见的问题：")
        for k, v in counter.most_common(15):
            print(f"  {v:4d}  {k}")
    return 1 if total_err and not a.all else 0


if __name__ == "__main__":
    sys.exit(main())

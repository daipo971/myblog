#!/usr/bin/env python3
"""构建后的站内死链检查。

用法：
  hugo -d /tmp/pub && python3 scripts/check_links.py /tmp/pub

扫描构建产物里所有 href="/..." 的站内链接，找出指向不存在页面的链接。
static/_redirects 里登记过 301 的旧网址不算死链。
"""
import pathlib
import re
import sys
from urllib.parse import unquote, urlsplit

ROOT = pathlib.Path(__file__).resolve().parent.parent


def redirects():
    f = ROOT / "static" / "_redirects"
    if not f.exists():
        return set()
    out = set()
    for line in f.read_text(encoding="utf-8").splitlines():
        parts = line.split()
        if len(parts) >= 2 and not line.startswith("#"):
            out.add(parts[0].rstrip("/") + "/")
    return out


def exists(pub: pathlib.Path, path: str) -> bool:
    p = pub / path.lstrip("/")
    return p.is_file() or (p / "index.html").is_file()


def main():
    if len(sys.argv) != 2:
        print(__doc__)
        return 2
    pub = pathlib.Path(sys.argv[1])
    redir = redirects()
    href = re.compile(r'href="(/[^"#?]*)')
    broken = {}
    for html in pub.rglob("*.html"):
        for link in href.findall(html.read_text(encoding="utf-8", errors="ignore")):
            path = unquote(urlsplit(link).path)
            if path.startswith("//") or exists(pub, path):
                continue
            if path.rstrip("/") + "/" in redir:
                continue
            broken.setdefault(path, set()).add(str(html.relative_to(pub)))
    for path, pages in sorted(broken.items()):
        print(f"{path}  ←  {', '.join(sorted(pages)[:3])}{' …' if len(pages) > 3 else ''}")
    print(f"\n死链 {len(broken)} 个。")
    return 1 if broken else 0


if __name__ == "__main__":
    sys.exit(main())

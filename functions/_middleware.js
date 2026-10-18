// 老域名中转页：不自动跳转，只显示迁移提示，用户手动点击前往新站。
// 这样微信侧看不到老域名→新域名的自动跳转链。
// 文章深链：非首页路径额外显示"在新站阅读本文"按钮（同路径指向新域名），老链接可找回对应文章。
export async function onRequest(context) {
  const url = new URL(context.request.url);
  if (url.hostname === 'xinqiai.dpdns.org') {
    const esc = (s) => s.replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/"/g, '&quot;');
    const articleBtn = url.pathname !== '/'
      ? `<a class="link link-article" href="${esc('https://xinqai.com' + url.pathname + url.search)}">在新站阅读本文</a>`
      : '';
    const html = `<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>本站已迁移至新域名</title>
<style>
  * { margin: 0; padding: 0; box-sizing: border-box; }
  body { font-family: "PingFang SC", "Microsoft YaHei", sans-serif; background: #0a0a12; color: #e8e8e8;
         display: flex; align-items: center; justify-content: center; min-height: 100vh; padding: 20px; }
  .card { background: rgba(255,255,255,0.04); border: 1px solid rgba(0,212,255,0.12); border-radius: 16px;
          padding: 48px 40px; text-align: center; max-width: 480px; width: 100%; }
  .icon { font-size: 56px; margin-bottom: 16px; }
  h1 { font-size: 22px; margin-bottom: 12px; }
  p { color: #999; font-size: 14px; line-height: 1.8; margin-bottom: 8px; }
  .link { display: inline-block; margin: 20px 8px 8px; padding: 14px 44px; font-size: 18px; font-weight: 700;
          color: #0a0a12; background: linear-gradient(135deg, #00d4ff, #7c3aed); border-radius: 10px;
          text-decoration: none; }
  .link-article { color: #00d4ff; background: transparent; border: 1px solid rgba(0,212,255,0.45); }
  .tip { font-size: 12px; color: #666; margin-top: 16px; }
</style>
</head>
<body>
  <div class="card">
    <div class="icon">📦</div>
    <h1>本站已迁移至新域名</h1>
    <p>欣淇AI网现已启用新地址，老域名不再直接提供内容。</p>
    <a class="link" href="https://xinqai.com/">前往 xinqai.com</a>${articleBtn}
    <p class="tip">如果在微信中无法打开，请复制链接到浏览器访问</p>
  </div>
</body>
</html>`;
    return new Response(html, {
      headers: { 'Content-Type': 'text/html; charset=utf-8', 'Cache-Control': 'no-store' }
    });
  }
  return await context.next();
}

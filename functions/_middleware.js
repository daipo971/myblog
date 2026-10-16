// 老域名 301 跳转到新域名
// Cloudflare Pages 的 _redirects 不支持按 hostname 匹配（跨域规则会被静默忽略），
// 所以用 Pages Functions 中间件实现：所有来自老域名的请求 301 到新域名（保留路径和参数）。
export async function onRequest(context) {
  const url = new URL(context.request.url);
  if (url.hostname === 'xinqiai.dpdns.org') {
    return Response.redirect(`https://xinqai.com${url.pathname}${url.search}`, 301);
  }
  return await context.next();
}

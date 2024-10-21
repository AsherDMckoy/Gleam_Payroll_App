import wisp.{type Request, type Response}

pub type Context {
  Context(static_directory: String, items: List(String))
}

pub fn middleware(
  req: Request,
  ctx: Context,
  handle_request: fn(Request) -> Response,
) -> Response {
  let req = wisp.method_override(req)
  use <- wisp.serve_static(req, under: "/static", from: ctx.static_directory)
  use <- wisp.log_request(req)
  use <- wisp.rescue_crashes
  use req <- wisp.handle_head(req)

  handle_request(req)
}

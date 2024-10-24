import app/pages
import app/pages/layout.{layout}
import app/web.{type Context}
import lustre/element

// import gleam/string_builder
import lustre/element/html
import wisp.{type Request, type Response}

pub fn handle_request(req: Request, ctx: Context) -> Response {
  use _req <- web.middleware(req, ctx)
  case wisp.path_segments(req) {
    // Homepage
    [] -> {
      // wisp.html_response(string_builder.from_string("Home"), 200)
      [pages.home()]
      |> layout
      |> element.to_document_string_builder
      |> wisp.html_response(200)
    }
    ["hello", "dimitri"] -> {
      [html.h1([], [html.text("Hello, Dimitri Maximoff")])]
      |> layout
      |> element.to_document_string_builder
      |> wisp.html_response(200)
    }

    // All the empty responses
    ["internal-server-error"] -> wisp.internal_server_error()
    ["unprocessable-entity"] -> wisp.unprocessable_entity()
    ["method-not-allowed"] -> wisp.method_not_allowed([])
    ["entity-too-large"] -> wisp.entity_too_large()
    ["bad-request"] -> wisp.bad_request()
    _ -> wisp.not_found()
  }
}

import lustre/attribute
import lustre/element.{type Element, text}
import lustre/element/html.{h1}

pub fn root() -> Element(t) {
  h1([attribute.class("peoples-title")], [text("Homepage")])
}

// True only while the lists of figures and tables are laid out.
#let in-outline = state("in-outline", false)

// Typst has no short caption. The caption is rendered once in the figure and
// again in the list, so the state decides which of the two texts appears.
#let flex-caption(long, short) = context if in-outline.get() { short } else { long }

// The label lets `#show <todo>: none` hide the boxes where inputs can't be
// passed, such as the web app.
#let todo(body) = if sys.inputs.at("show-todos", default: "true") != "false" {
  [#block(width: 100%, radius: 3pt, stroke: 0.5pt, fill: yellow, inset: 10pt, body)<todo>]
}

// The sans font is not embedded in Typst, so fall back to the serif one.
#let sans = ("New Computer Modern Sans", "New Computer Modern")

#let centered(size, weight: 400, body) = align(center, text(font: sans, size, weight: weight, body))

// Everything above the title is identical on the cover and the title page.
#let masthead(identity, gap) = {
  v(1cm)
  align(center, identity.logo)
  v(5mm)
  centered(2em, weight: 700, identity.university)
  v(5mm)
  centered(1.5em)[#identity.school \ #identity.department]
  v(15mm)
  centered(1.3em, identity.thesis-type)
  v(gap)
}

#let cover(identity, title: none, author: none) = {
  masthead(identity, 15mm)
  centered(2em, weight: 700, title)
  v(10mm)
  centered(2em, author)
}

#let title-page(identity, title: none, title-secondary: none, secondary-lang: none, fields: ()) = page(
  margin: (x: 20mm, y: 30mm),
  {
    set par(leading: 0.5em)
    masthead(identity, 8mm)
    centered(2em, weight: 700, title)
    text(lang: secondary-lang, centered(2em, title-secondary))
    v(1cm)
    align(center, grid(
      columns: 2,
      gutter: 1em,
      align: left,
      ..for (term, value) in fields { ([*#term:*], value) },
    ))
  },
)

#let declaration-page(body, place-and-date: none, author: none) = {
  v(75%)
  body
  v(15mm)
  grid(columns: 2, gutter: 1fr, place-and-date, author)
}

#let acknowledgements-page(title, body) = {
  set par(justify: true)
  text(font: sans, 2em, weight: 700, title)
  v(15mm)
  body
}

#let abstract-page(title, lang: "en", body) = {
  set text(lang: lang)
  set par(justify: true)
  v(1fr)
  align(center, text(weight: 700, title))
  body
  v(1fr)
}

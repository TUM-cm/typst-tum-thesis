#import "front-matter.typ": abstract-page, acknowledgements-page, cover, declaration-page, title-page
#import "helpers.typ": in-outline
#import "i18n.typ": translations

#let thesis(
  title: none,
  title-secondary: none,
  author: none,
  degree: none,
  program: none,
  school: none,
  department: none,
  examiner: none,
  supervisors: (),
  start-date: none,
  submission-date: none,
  lang: "en",
  abstracts: (:),
  acknowledgements: none,
  appendix: none,
  references: none,
  university: auto,
  logo: image("../figures/tum_logo.png", width: 26%, alt: "Logo of the Technical University of Munich"),
  city: auto,
  citation-style: "alphanumeric",
  two-sided: sys.inputs.at("two-sided", default: none) == "true",
  show-todos: true,
  declaration: auto,
  body,
) = {
  assert(type(author) in (str, array), message: "author must be a string or an array of strings")
  assert(degree in ("Bachelor", "Master"), message: "degree must be either \"Bachelor\" or \"Master\"")
  assert(lang in translations, message: "lang must be either \"en\" or \"de\"")
  // ("Name") without a trailing comma is a string, not an array.
  assert(type(supervisors) == array, message: "supervisors must be an array, e.g. (\"Name\",)")
  for (name, value) in (
    title: title,
    title-secondary: title-secondary,
    program: program,
    school: school,
    department: department,
    examiner: examiner,
    start-date: start-date,
    submission-date: submission-date,
  ) {
    assert(value != none, message: name + " is required")
  }

  // Has to stay ahead of all content in this function: further down, Typst
  // rejects it as a set rule inside a container.
  set document(title: title, author: author)

  let phrases = translations.at(lang)
  let author-names = (author,).flatten().join(", ")
  let format-date(date) = date.display("[day].[month].[year]")

  // Only the citation style can be "alphanumeric": it is not a valid
  // bibliography style, so the bibliography keeps its default in that case.
  set cite(style: citation-style)
  set bibliography(title: phrases.bibliography)
  set bibliography(style: citation-style) if citation-style != "alphanumeric"

  set page(margin: (x: 30mm, y: 40mm))
  set text(font: "New Computer Modern", size: 12pt, lang: lang)
  set par(leading: 1em)
  set heading(numbering: "1.1")
  show heading: set block(below: 0.85em, above: 1.75em)
  show heading.where(level: 1): set heading(supplement: phrases.chapter)
  show math.equation: set text(weight: 400)
  show figure: set text(size: 0.85em)
  show figure.caption: set text(size: 9.2pt)
  show figure.caption: set par(leading: 0.5em)
  show <todo>: it => if show-todos { it }

  // Blank parity pages take the page style of their break, so this keeps them
  // free of page numbers.
  let next-page(weak: false) = {
    set page(numbering: none)
    pagebreak(weak: weak, to: if two-sided { "odd" })
  }
  let chapter-break(it) = {
    next-page(weak: true)
    it
  }

  let identity = (
    logo: logo,
    university: if university == auto { phrases.university } else { university },
    school: school,
    department: department,
    thesis-type: (phrases.thesis-type)(degree, program),
  )

  cover(identity, title: title, author: author-names)
  next-page()

  title-page(
    identity,
    title: title,
    title-secondary: title-secondary,
    secondary-lang: if lang == "en" { "de" } else { "en" },
    fields: (
      (phrases.author, author-names),
      (phrases.examiner, examiner),
      ..if supervisors.len() > 0 {
        let label = if supervisors.len() > 1 { phrases.supervisors } else { phrases.supervisor }
        ((label, supervisors.join(", ")),)
      },
      (phrases.start-date, format-date(start-date)),
      (phrases.submission-date, format-date(submission-date)),
    ),
  )
  next-page()

  declaration-page(
    if declaration == auto { (phrases.declaration)(degree) } else { declaration },
    place-and-date: [#if city == auto { phrases.city } else { city }, #format-date(submission-date)],
    author: author-names,
  )
  next-page()

  if acknowledgements != none {
    acknowledgements-page(phrases.acknowledgements, acknowledgements)
    next-page()
  }

  for (key, abstract) in abstracts {
    abstract-page(translations.at(key).abstract, lang: key, abstract)
    next-page()
  }

  {
    // Scoped because level 1 also matches the entries of the figure and table
    // lists. Show-set instead of strong(it), which fails PDF/UA.
    show outline.entry.where(level: 1): set text(weight: "bold")
    show outline.entry.where(level: 1): set block(above: 15pt)
    outline(
      title: {
        text(1.5em, phrases.contents)
        v(15mm)
      },
      indent: 2em,
    )
  }
  next-page()

  // After the break: otherwise the parity page of a two-sided build is counted
  // and chapter 1 ends up with number 2.
  set page(numbering: "1")
  counter(page).update(1)
  set par(justify: true, first-line-indent: 2em)

  {
    show heading.where(level: 1): chapter-break
    body
  }

  {
    let figure-list(kind, title) = context if query(figure.where(kind: kind)).len() > 0 {
      next-page()
      heading(numbering: none, title)
      outline(title: none, target: figure.where(kind: kind))
    }
    show outline: it => {
      in-outline.update(true)
      it
      in-outline.update(false)
    }
    figure-list(image, phrases.list-of-figures)
    figure-list(table, phrases.list-of-tables)
  }

  if appendix != none {
    set heading(numbering: "A.1")
    show heading.where(level: 1): set heading(supplement: phrases.appendix)
    show heading.where(level: 1): chapter-break
    counter(heading).update(0)
    next-page()
    appendix
  }

  if references != none {
    next-page()
    references
  }
}

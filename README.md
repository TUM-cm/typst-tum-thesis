# Typst thesis template

A Typst template for Bachelor's and Master's theses at the Technical University of Munich. The defaults are TUM-wide, and a chair can adapt them in a few lines. It is only a template: agree on the structure of your thesis with your supervisors.

[View the example PDF](https://tum-cm.github.io/typst-tum-thesis/thesis.pdf) to see what the template looks like. This link always shows the template's sample, not your own thesis, so remove it from your copy.

Requires Typst 0.15 or newer.

## Quick start

1. Click "Use this template" on GitHub and create your own repository.
2. Edit the `#show: thesis.with(...)` block in `thesis.typ` (title, author, degree, program, examiner, dates, and so on).
3. Write your chapters in `chapters/` and add or remove `#include` lines in `thesis.typ`.

```sh
typst compile --font-path fonts thesis.typ   # creates thesis.pdf
typst watch --font-path fonts thesis.typ     # recompiles on every change
```

The title pages use New Computer Modern Sans. Typst doesn't include this font, so it's in `fonts/`. If you leave out `--font-path fonts`, you get a warning and serif title pages. To avoid typing the flag, set `TYPST_FONT_PATHS=fonts` or install the fonts.

## Adapting it for your chair

`university`, `logo`, `city`, `citation-style`, `two-sided`, `show-todos` and `declaration` are optional and have defaults. `school` and `department` are required, so students have to fill them in unless you set them for everyone. To do that, edit `lib/thesis.typ` or wrap `thesis` in your own function.

The code is in `lib/`:

- `lib/thesis.typ`: page, text and heading rules, and the order of the sections
- `lib/front-matter.typ`: cover, title page, declaration, abstracts, acknowledgements
- `lib/i18n.typ`: English and German phrases
- `lib/helpers.typ`: `todo` and `flex-caption`
- `lib/colors.typ`: `tum-colors`, the TUM corporate design palette, for use in figures and diagrams

## Bibliography

Pass any format Typst reads, BibTeX or Hayagriva YAML:

```typst
references: bibliography("references.bib"),
```

Cite with `@key`, or `@key1 @key2` for several sources. The style is set with `citation-style` (default `"alphanumeric"`).

## Language

Set `lang: "de"` for a German thesis. This also switches the declaration and labels like "Contents" to German. `title-secondary` is the title in the other language.

## Two-sided printing

`two-sided: true` starts front matter and chapters on odd pages for double-sided printing. To get it for a single build, pass `--input two-sided=true` instead.

## TODO hints

`#todo[...]` boxes show until you remove them or set `show-todos: false`.

## PDF/UA export

```sh
typst compile --font-path fonts --pdf-standard ua-1 thesis.typ
```

PDF/UA requires alt text on every image (`image(..., alt: "...")`) and on block equations (`math.equation(block: true, alt: "...", $ ... $)`), and tables should use `table.header`. `chapters/04-approach.typ` has an example of each.

## Watch out for

- Put no text above `#show: thesis.with(...)` in `thesis.typ`. You won't get a warning, but it ends up on an extra page before the cover.
- Rules after `#show: thesis.with(...)` only apply to the chapters below them. The abstracts, acknowledgements and appendix are passed in as arguments, so they aren't affected. Put those rules in the files themselves or in `lib/`.

## Web app and editor

To use the [Typst web app](https://typst.app), upload the repository, including `fonts/`. In VS Code, install the [Tinymist](https://marketplace.visualstudio.com/items?itemName=myriad-dreamin.tinymist) extension and add `fonts` to its `tinymist.fontPaths` setting.

## License

MIT.

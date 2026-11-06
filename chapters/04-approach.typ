#import "/lib/helpers.typ": flex-caption, todo

= Approach <chap:approach>

#todo[
  Describe the approach you developed to reach your objectives and why you chose it over the alternatives. The sections below are examples. Delete them once you have your own.
]

== Figures

Figures need alternative text so that the PDF stays accessible. @fig:logo shows a figure with a short caption in the list of figures and a longer caption in the text.

#figure(
  image("/figures/tum_logo.png", width: 12%, alt: "Logo of the Technical University of Munich"),
  caption: flex-caption(
    [The university logo as a placeholder. This longer caption only appears here.],
    [University logo],
  ),
) <fig:logo>

== Tables

Tables need a header row (`table.header`) for screen readers, as in @tab:example.

#figure(
  table(
    columns: 3,
    table.header[Method][Accuracy][Runtime],
    [Baseline], [0.71], [12 s],
    [Our approach], [0.84], [15 s],
  ),
  caption: [Example comparison of two methods. The values are made up.],
) <tab:example>

== Equations

Block equations need an `alt` description for accessibility. @eq:mean defines the mean of a series of values.

#math.equation(
  block: true,
  numbering: "(1)",
  alt: "x bar equals one over n times the sum of x i for i from 1 to n",
  $ overline(x) = 1 / n sum_(i=1)^n x_i $,
) <eq:mean>

== Citations and References

Cite a source with its key from `references.bib`, for example @musterfrau2022example. Reference a chapter by its label, for example @chap:background.

// Don't put text above `#show: thesis`. There's no warning, but it ends up on
// an extra page before the cover.
//
// Rules after `#show: thesis` only apply to the chapters below, not to the
// abstracts, acknowledgements or appendix.

#import "/lib/thesis.typ": thesis

#show: thesis.with(
  title: [Title of Your Thesis],
  title-secondary: [Titel Ihrer Arbeit],
  author: "Your Name",
  degree: "Master",
  program: "Your Study Program",
  school: [Your School],
  department: [Your Department],
  examiner: "Prof. Dr. Examiner Name",
  supervisors: ("Supervisor Name, M.Sc.",),
  start-date: datetime(day: 1, month: 1, year: 2026),
  submission-date: datetime(day: 1, month: 7, year: 2026),
  lang: "en",
  abstracts: (
    en: include "chapters/abstract-en.typ",
    de: include "chapters/abstract-de.typ",
  ),
  acknowledgements: include "chapters/acknowledgements.typ",
  appendix: include "chapters/appendix.typ",
  references: bibliography("references.bib"),
)

#include "chapters/01-introduction.typ"
#include "chapters/02-background.typ"
#include "chapters/03-related-work.typ"
#include "chapters/04-approach.typ"
#include "chapters/05-evaluation.typ"
#include "chapters/06-conclusion.typ"

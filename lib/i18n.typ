// Whole phrases, because "Bachelor's Thesis in X" does not translate word by
// word. A new language only needs another entry with the same keys.
#let translations = (
  en: (
    university: "Technical University of Munich",
    city: "Munich",
    thesis-type: (degree, program) => [#degree’s Thesis in #program],
    declaration: degree => [
      I confirm that this #degree’s thesis is my own work and I have documented
      all sources and material used.
    ],
    author: "Author",
    examiner: "Examiner",
    supervisor: "Supervisor",
    supervisors: "Supervisors",
    start-date: "Start Date",
    submission-date: "Submission Date",
    abstract: "Abstract",
    acknowledgements: "Acknowledgements",
    contents: "Contents",
    list-of-figures: "List of Figures",
    list-of-tables: "List of Tables",
    chapter: "Chapter",
    appendix: "Appendix",
    bibliography: "Bibliography",
  ),
  de: (
    university: "Technische Universität München",
    city: "München",
    thesis-type: (degree, program) => [#(degree)arbeit im Studiengang #program],
    declaration: degree => [
      Ich versichere, dass ich diese #(degree)arbeit selbstständig verfasst und
      alle verwendeten Quellen und Hilfsmittel angegeben habe.
    ],
    author: "Autor",
    examiner: "Prüfer",
    supervisor: "Betreuer",
    supervisors: "Betreuer",
    start-date: "Beginn",
    submission-date: "Abgabe",
    abstract: "Zusammenfassung",
    acknowledgements: "Danksagung",
    contents: "Inhaltsverzeichnis",
    list-of-figures: "Abbildungsverzeichnis",
    list-of-tables: "Tabellenverzeichnis",
    chapter: "Kapitel",
    appendix: "Anhang",
    bibliography: "Literaturverzeichnis",
  ),
)

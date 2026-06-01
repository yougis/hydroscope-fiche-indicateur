#import "@preview/book:0.2.5": *

#let project(title: "", subtitle: "", author: "", date: "", body) = {
  set document(title: title, author: author)
  set text(lang: "fr", font: "Calibri", size: 11pt)
  set page(margin: 1in)
  
  align(center, text(size: 2em, weight: "bold", title))
  align(center, text(size: 1.5em, subtitle))
  align(center, text(size: 1em, author))
  align(center, text(size: 0.9em, date))
  
  v(2em)
  
  body
}

#show heading.where(level: 1): it => {
  set text(fill: rgb(227, 108, 10))
  block(it)
}

#show heading.where(level: 2): it => {
  set text(fill: rgb(128, 128, 128))
  block(it)
}

#project(
  title: "Fiches indicateurs HydroScope",
  subtitle: "Catalogue des indicateurs de suivi et de comparaison des unités de gestion AEP",
  author: "Hugo Roussaffa",
  date: today().display(),
  [

== Enjeu

#include "fiches_typst/1.typ"

#include "fiches_typst/2.typ"

#include "fiches_typst/3.typ"

#include "fiches_typst/4.typ"

#include "fiches_typst/5.typ"

#include "fiches_typst/6.typ"

#include "fiches_typst/7.typ"

#include "fiches_typst/8.typ"

#include "fiches_typst/9.typ"

#include "fiches_typst/10.typ"

#include "fiches_typst/100.typ"

#include "fiches_typst/101.typ"

#include "fiches_typst/102.typ"

#include "fiches_typst/103.typ"

#include "fiches_typst/104.typ"

#include "fiches_typst/105.typ"

#include "fiches_typst/106.typ"

#include "fiches_typst/107.typ"


== Pression

#include "fiches_typst/200.typ"

#include "fiches_typst/201.typ"

#include "fiches_typst/202.typ"

#include "fiches_typst/203.typ"

#include "fiches_typst/204.typ"

#include "fiches_typst/300.typ"

#include "fiches_typst/301.typ"

#include "fiches_typst/302.typ"

#include "fiches_typst/304.typ"

#include "fiches_typst/305.typ"

#include "fiches_typst/306.typ"

#include "fiches_typst/500.typ"

#include "fiches_typst/501.typ"

#include "fiches_typst/502.typ"

#include "fiches_typst/503.typ"

#include "fiches_typst/504.typ"

#include "fiches_typst/505.typ"


== Vulnérabilité

#include "fiches_typst/400.typ"

#include "fiches_typst/401.typ"

#include "fiches_typst/402.typ"


  ]
)

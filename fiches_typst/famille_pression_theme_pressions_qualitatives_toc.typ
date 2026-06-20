#import "../template_typst.typ": *

// ─── TOC THÈME : Pressions Qualitatives ───────────────────────────────
#block(width: 100%, fill: rgb("#2E7D32"), radius: 4pt,
  inset: (x: 14pt, y: 12pt),
  text(size: 1.2em, weight: "bold", fill: white)[Pressions Qualitatives]
)
#block(
  width: 100%,
  inset: (x: 2pt, top: 6pt, bottom: 4pt),
  grid(
    columns: 1,
    row-gutter: 4pt,
    text(size: 0.82em, fill: rgb("#475569"), style: "italic")[Caractérise l’état de qualité de l’eau et les facteurs susceptibles de l’altérer \(physico\-chimiques, bactériologiques ou réglementaires\).],
  )
)
#v(0.8em)
#block(
  width: 100%,
  fill: luma(252),
  stroke: (left: 5pt + rgb("#2E7D32")),
  radius: (right: 6pt),
  inset: (left: 12pt, right: 10pt, top: 8pt, bottom: 8pt),
  grid(
    columns: (1fr, auto),
    column-gutter: 8pt,
    align: horizon,
    grid(
      columns: 1,
      row-gutter: 3pt,
      text(size: 1em, weight: "bold")[Apports naturels],
      text(size: 0.85em, fill: rgb("#333333"))[Suivre les conditions hydrologiques influençant la disponibilité de la ressource],
      text(size: 0.8em, fill: rgb("#666666"), style: "italic")[Relève de la veille : observation du contexte climatique pour la gestion de crise.],
    ),
    box(fill: rgb("#2E7D32"), radius: 999pt,
      inset: (x: 10pt, y: 5pt),
      text(size: 0.75em, weight: "bold", fill: white)[SURVEILLER]
    ),
  )
)
#v(0.4em)
#block(
  width: 100%,
  inset: (left: 17pt),
  grid(
    columns: (40pt, 1fr),
    row-gutter: 4pt,
    column-gutter: 6pt,
    text(size: 0.78em, weight: "bold", fill: rgb("#2E7D32"))[Fiche n°],
    text(size: 0.78em, weight: "bold", fill: rgb("#2E7D32"))[Indicateur],
    text(size: 0.8em, fill: rgb("#555555"))[#link(<ind-34>)[34]],
    text(size: 0.8em)[#link(<ind-34>)[Pluviométrie]],
    text(size: 0.8em, fill: rgb("#555555"))[#link(<ind-35>)[35]],
    text(size: 0.8em)[#link(<ind-35>)[Niveau nappes]],
  )
)
#v(0.7em)
#block(
  width: 100%,
  fill: luma(252),
  stroke: (left: 5pt + rgb("#005596")),
  radius: (right: 6pt),
  inset: (left: 12pt, right: 10pt, top: 8pt, bottom: 8pt),
  grid(
    columns: (1fr, auto),
    column-gutter: 8pt,
    align: horizon,
    grid(
      columns: 1,
      row-gutter: 3pt,
      text(size: 1em, weight: "bold")[État sanitaire et suivi de la qualité],
      text(size: 0.85em, fill: rgb("#333333"))[Identifier les captages présentant une dégradation de la qualité de l’eau],
      text(size: 0.8em, fill: rgb("#666666"), style: "italic")[Sert de diagnostic de confirmation pour valider l'impact réel des pressions sur la ressource.],
    ),
    box(fill: rgb("#005596"), radius: 999pt,
      inset: (x: 10pt, y: 5pt),
      text(size: 0.75em, weight: "bold", fill: white)[AGIR]
    ),
  )
)
#v(0.4em)
#block(
  width: 100%,
  inset: (left: 17pt),
  grid(
    columns: (40pt, 1fr),
    row-gutter: 4pt,
    column-gutter: 6pt,
    text(size: 0.78em, weight: "bold", fill: rgb("#005596"))[Fiche n°],
    text(size: 0.78em, weight: "bold", fill: rgb("#005596"))[Indicateur],
    text(size: 0.8em, fill: rgb("#555555"))[#link(<ind-38>)[38]],
    text(size: 0.8em)[#link(<ind-38>)[Qualité eau]],
  )
)
#v(0.7em)
#pagebreak()

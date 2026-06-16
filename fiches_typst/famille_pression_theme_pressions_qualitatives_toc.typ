#import "../template_typst.typ": *

// ─── TOC THÈME : Pressions Qualitatives ────────────────────────────────
#block(
  width: 100%,
  fill: rgb("#005596"),
  radius: 4pt,
  inset: (x: 14pt, y: 10pt),
  text(size: 1.15em, weight: "bold", fill: white)[Pressions Qualitatives]
)
#v(0.6em)
#block(
  width: 100%,
  stroke: (left: 5pt + rgb("#005596")),
  fill: luma(252),
  radius: (right: 6pt),
  inset: (left: 12pt, right: 10pt, top: 8pt, bottom: 8pt),
  grid(
    columns: (1fr, auto),
    column-gutter: 8pt,
    stack(dir: ttb, spacing: 0.3em,
      text(size: 1em, weight: "bold")[État sanitaire et suivi de la qualité],
      text(size: 0.85em, fill: rgb("#333333"))[Identifier les captages dont la qualité de l'eau est dégradée afin de prioriser les actions de gestion ou de protection.],
      text(size: 0.8em, style: "italic", fill: rgb("#666666"))[Sert de diagnostic de confirmation pour valider l'impact réel des pressions sur la ressource.],
    ),
    box(fill: rgb("#005596"), radius: 999pt,
      inset: (x: 10pt, y: 5pt),
      text(size: 0.75em, weight: "bold", fill: white)[PILOTAGE]
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

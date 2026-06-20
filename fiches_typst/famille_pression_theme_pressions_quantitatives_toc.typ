#import "../template_typst.typ": *

// ─── TOC THÈME : Pressions Quantitatives ───────────────────────────────
#block(width: 100%, fill: rgb("#005596"), radius: 4pt,
  inset: (x: 14pt, y: 12pt),
  text(size: 1.2em, weight: "bold", fill: white)[Pressions Quantitatives]
)
#block(
  width: 100%,
  inset: (x: 2pt, top: 6pt, bottom: 4pt),
  grid(
    columns: 1,
    row-gutter: 4pt,
    text(size: 0.82em, fill: rgb("#475569"), style: "italic")[Caractérise les déséquilibres entre la disponibilité de la ressource en eau et les usages humains, notamment à travers l’intensité des prélèvements.],
  )
)
#v(0.8em)
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
      text(size: 1em, weight: "bold")[Tension des usages],
      text(size: 0.85em, fill: rgb("#333333"))[Identifier les situations de déséquilibre entre prélèvements et ressource disponible],
      text(size: 0.8em, fill: rgb("#666666"), style: "italic")[Relève du pilotage : déclenche les restrictions ou les limitations de nouvelles autorisations.],
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
    text(size: 0.8em, fill: rgb("#555555"))[#link(<ind-33>)[33]],
    text(size: 0.8em)[#link(<ind-33>)[BBR]],
    text(size: 0.8em, fill: rgb("#555555"))[#link(<ind-36>)[36]],
    text(size: 0.8em)[#link(<ind-36>)[Nombre de prélèvement AODPE]],
    text(size: 0.8em, fill: rgb("#555555"))[#link(<ind-37>)[37]],
    text(size: 0.8em)[#link(<ind-37>)[Volume des prélèvements AODPE]],
  )
)
#v(0.7em)
#pagebreak()

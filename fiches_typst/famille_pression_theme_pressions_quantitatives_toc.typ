#import "../template_typst.typ": *

// ─── TOC THÈME : Pressions Quantitatives ────────────────────────────────
#block(
  width: 100%,
  fill: rgb("#005596"),
  radius: 4pt,
  inset: (x: 14pt, y: 10pt),
  text(size: 1.15em, weight: "bold", fill: white)[Pressions Quantitatives]
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
      text(size: 1em, weight: "bold")[Tension des usages],
      text(size: 0.85em, fill: rgb("#333333"))[Identifier les situations de déséquilibre entre les besoins humains et l'eau disponible en croisant les prélèvements réels et le diagnostic de déficit.],
      text(size: 0.8em, style: "italic", fill: rgb("#666666"))[Relève du pilotage : déclenche les restrictions ou les limitations de nouvelles autorisations.],
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
    text(size: 0.8em, fill: rgb("#555555"))[33],
    text(size: 0.8em)[BBR],
    text(size: 0.8em, fill: rgb("#555555"))[36],
    text(size: 0.8em)[AODPE nombre],
    text(size: 0.8em, fill: rgb("#555555"))[37],
    text(size: 0.8em)[AODPE volume],
  )
)
#v(0.7em)
#block(
  width: 100%,
  stroke: (left: 5pt + rgb("#2E7D32")),
  fill: luma(252),
  radius: (right: 6pt),
  inset: (left: 12pt, right: 10pt, top: 8pt, bottom: 8pt),
  grid(
    columns: (1fr, auto),
    column-gutter: 8pt,
    stack(dir: ttb, spacing: 0.3em,
      text(size: 1em, weight: "bold")[Apports naturels],
      text(size: 0.85em, fill: rgb("#333333"))[Contextualiser la ressource disponible (pluie, nappes).],
      text(size: 0.8em, style: "italic", fill: rgb("#666666"))[Relève de la veille : observation du contexte climatique pour la gestion de crise.],
    ),
    box(fill: rgb("#2E7D32"), radius: 999pt,
      inset: (x: 10pt, y: 5pt),
      text(size: 0.75em, weight: "bold", fill: white)[VEILLE]
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
    text(size: 0.8em, fill: rgb("#555555"))[34],
    text(size: 0.8em)[Pluviométrie],
    text(size: 0.8em, fill: rgb("#555555"))[35],
    text(size: 0.8em)[Niveau nappes],
  )
)
#v(0.7em)
#pagebreak()

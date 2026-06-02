#import "../template_typst.typ": *

// ─── PAGE DE GARDE FAMILLE ───────────────────────────────────
= Vulnérabilité

#block(
  width: 100%,
  stroke: (top: 4pt + rgb("#546E7A")),
  inset: (top: 10pt, bottom: 8pt, left: 0pt, right: 0pt),
  stack(dir: ttb, spacing: 0.4em,
    text(size: 1.5em, weight: "bold", tracking: 1pt)[VULNÉRABILITÉ],
  )
)
#v(0.6em)
== Vulnérabilité Intrinsèque

#block(
  width: 100%,
  fill: rgb("#546E7A"),
  radius: 4pt,
  inset: (x: 12pt, y: 8pt),
  text(size: 1.1em, weight: "bold", fill: white)[Vulnérabilité Intrinsèque]
)
#v(0.5em)
#block(
  width: 100%,
  stroke: (left: 5pt + rgb("#546E7A")),
  fill: luma(252),
  radius: (right: 6pt),
  inset: (left: 12pt, right: 10pt, top: 8pt, bottom: 8pt),
  grid(
    columns: (1fr, auto),
    column-gutter: 8pt,
    stack(dir: ttb, spacing: 0.3em,
      text(size: 1em, weight: "bold")[Sensibilité naturelle],
      text(size: 0.85em, fill: rgb("#333333"))[Qualifier la propension naturelle du terrain à laisser circuler les polluants vers les eaux souterraines ou superficielles selon ses propriétés géologiques.],
      text(size: 0.8em, style: "italic", fill: rgb("#666666"))[Définit le socle physique immuable qui module (amplifie ou réduit) l'impact des pressions.],
    ),
    box(fill: rgb("#546E7A"), radius: 999pt,
      inset: (x: 10pt, y: 5pt),
      text(size: 0.75em, weight: "bold", fill: white)[DIAGNOSTIC & MODULATION]
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
    text(size: 0.78em, weight: "bold", fill: rgb("#546E7A"))[Fiche n°],
    text(size: 0.78em, weight: "bold", fill: rgb("#546E7A"))[Indicateur],
    text(size: 0.8em, fill: rgb("#555555"))[31],
    text(size: 0.8em)[Géologie],
    text(size: 0.8em, fill: rgb("#555555"))[32],
    text(size: 0.8em)[Vulnérabilité intrinsèque des eaux souterraines],
  )
)
#v(0.7em)
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
      text(size: 1em, weight: "bold")[Sans groupe],
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
    text(size: 0.8em, fill: rgb("#555555"))[400],
    text(size: 0.8em)[IDPR],
  )
)
#v(0.7em)
#pagebreak()

#import "../template_typst.typ": *

// ─── TOC THÈME : Pressions Environnementales ────────────────────────────────
#block(
  width: 100%,
  fill: rgb("#2E7D32"),
  radius: 4pt,
  inset: (x: 14pt, y: 10pt),
  text(size: 1.15em, weight: "bold", fill: white)[Pressions Environnementales]
)
#v(0.6em)
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
      text(size: 1em, weight: "bold")[Perturbations majeures du milieu (Aléa)],
      text(size: 0.85em, fill: rgb("#333333"))[Identifier les bassins dont l'équilibre écologique a été rompu par des événements destructeurs comme les incendies.],
      text(size: 0.8em, style: "italic", fill: rgb("#666666"))[Permet une réaction rapide face aux chocs brutaux impactant le bassin versant.],
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
    text(size: 0.8em, fill: rgb("#555555"))[19],
    text(size: 0.8em)[Incendies cumulés],
    text(size: 0.8em, fill: rgb("#555555"))[23],
    text(size: 0.8em)[Espèces exotiques envahissantes (EEE)],
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
      text(size: 1em, weight: "bold")[Fragilité des sols et transferts (chronique)],
      text(size: 0.85em, fill: rgb("#333333"))[Détecter les zones de sols nus ou instables qui favorisent le transport de sédiments et de polluants vers les points de captage.],
      text(size: 0.8em, style: "italic", fill: rgb("#666666"))[Assure la surveillance de la dégradation structurelle et lente des sols.],
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
    text(size: 0.8em, fill: rgb("#555555"))[20],
    text(size: 0.8em)[Surface érosion],
    text(size: 0.8em, fill: rgb("#555555"))[21],
    text(size: 0.8em)[Terrain nu],
    text(size: 0.8em, fill: rgb("#555555"))[22],
    text(size: 0.8em)[Glissement terrain],
  )
)
#v(0.7em)
#pagebreak()

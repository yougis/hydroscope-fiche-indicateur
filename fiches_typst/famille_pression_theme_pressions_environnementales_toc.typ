#import "../template_typst.typ": *

// ─── TOC THÈME : Pressions Environnementales ───────────────────────────────
#block(width: 100%, fill: rgb("#2E7D32"), radius: 4pt,
  inset: (x: 14pt, y: 12pt),
  text(size: 1.2em, weight: "bold", fill: white)[Pressions Environnementales]
)
#block(
  width: 100%,
  inset: (x: 2pt, top: 6pt, bottom: 4pt),
  grid(
    columns: 1,
    row-gutter: 4pt,
    text(size: 0.82em, fill: rgb("#475569"), style: "italic")[Caractérise les phénomènes naturels susceptibles d’altérer les milieux et d’impacter la qualité et la pérennité de la ressource en eau.],
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
      text(size: 1em, weight: "bold")[Perturbations majeures du milieu \(Aléa\)],
      text(size: 0.85em, fill: rgb("#333333"))[Identifier les bassins dont l'équilibre écologique a été rompu par des événements destructeurs comme les incendies.],
      text(size: 0.8em, fill: rgb("#666666"), style: "italic")[Permet une réaction rapide face aux chocs brutaux impactant le bassin versant.],
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
    text(size: 0.8em, fill: rgb("#555555"))[#link(<ind-19>)[19]],
    text(size: 0.8em)[#link(<ind-19>)[Incendies cumulés]],
    text(size: 0.8em, fill: rgb("#555555"))[#link(<ind-23>)[23]],
    text(size: 0.8em)[#link(<ind-23>)[Espèces exotiques envahissantes \(EEE\)]],
  )
)
#v(0.7em)
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
      text(size: 1em, weight: "bold")[Fragilité des sols et transferts \(chronique\)],
      text(size: 0.85em, fill: rgb("#333333"))[Détecter les zones de sols nus ou instables qui favorisent le transport de sédiments et de polluants vers les points de captage.],
      text(size: 0.8em, fill: rgb("#666666"), style: "italic")[Assure la surveillance de la dégradation structurelle et lente des sols.],
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
    text(size: 0.8em, fill: rgb("#555555"))[#link(<ind-20>)[20]],
    text(size: 0.8em)[#link(<ind-20>)[Surface érosion]],
    text(size: 0.8em, fill: rgb("#555555"))[#link(<ind-21>)[21]],
    text(size: 0.8em)[#link(<ind-21>)[Terrain nu]],
    text(size: 0.8em, fill: rgb("#555555"))[#link(<ind-22>)[22]],
    text(size: 0.8em)[#link(<ind-22>)[Glissement terrain]],
  )
)
#v(0.7em)
#pagebreak()

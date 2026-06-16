#import "../template_typst.typ": *

// ─── TOC THÈME : Enjeux Environnementaux ────────────────────────────────
#block(
  width: 100%,
  fill: rgb("#2E7D32"),
  radius: 4pt,
  inset: (x: 14pt, y: 10pt),
  text(size: 1.15em, weight: "bold", fill: white)[Enjeux Environnementaux]
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
      text(size: 1em, weight: "bold")[Valeur patrimoniale et réglementaire],
      text(size: 0.85em, fill: rgb("#333333"))[Repérer les bassins versants inscrits dans des périmètres de reconnaissance mondiale ou locale \(UNESCO, aires protégées\) nécessitant une gestion exemplaire.],
      text(size: 0.8em, style: "italic", fill: rgb("#666666"))[Assure le suivi des engagements de conservation et des contraintes réglementaires associées.],
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
    text(size: 0.8em, fill: rgb("#555555"))[#link(<ind-11>)[11]],
    text(size: 0.8em)[#link(<ind-11>)[Zones UNESCO]],
    text(size: 0.8em, fill: rgb("#555555"))[#link(<ind-12>)[12]],
    text(size: 0.8em)[#link(<ind-12>)[Zones protégées provinciales]],
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
      text(size: 1em, weight: "bold")[Richesse biologique et rareté],
      text(size: 0.85em, fill: rgb("#333333"))[Localiser les zones de biodiversité critique \(KBA, espèces menacées\) qui dépendent du maintien de la qualité de la ressource en eau.],
      text(size: 0.8em, style: "italic", fill: rgb("#666666"))[Surveille l'état des écosystèmes sensibles dépendants de la ressource en eau.],
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
    text(size: 0.8em, fill: rgb("#555555"))[#link(<ind-13>)[13]],
    text(size: 0.8em)[#link(<ind-13>)[KBA \/ ZICO]],
    text(size: 0.8em, fill: rgb("#555555"))[#link(<ind-14>)[14]],
    text(size: 0.8em)[#link(<ind-14>)[Espèces menacées]],
    text(size: 0.8em, fill: rgb("#555555"))[#link(<ind-15>)[15]],
    text(size: 0.8em)[#link(<ind-15>)[Forêt sèche]],
  )
)
#v(0.7em)
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
      text(size: 1em, weight: "bold")[État écologique et rôle protecteur],
      text(size: 0.85em, fill: rgb("#333333"))[Qualifier l'intégrité de la couverture végétale naturelle agissant comme un filtre et un régulateur naturel contre le ruissellement.],
      text(size: 0.8em, style: "italic", fill: rgb("#666666"))[Mesure la capacité naturelle du milieu à protéger la ressource par filtration.],
    ),
    box(fill: rgb("#546E7A"), radius: 999pt,
      inset: (x: 10pt, y: 5pt),
      text(size: 0.75em, weight: "bold", fill: white)[DIAGNOSTIC]
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
    text(size: 0.8em, fill: rgb("#555555"))[#link(<ind-16>)[16]],
    text(size: 0.8em)[#link(<ind-16>)[Occupation sol \(couvert végétal\)]],
    text(size: 0.8em, fill: rgb("#555555"))[#link(<ind-17>)[17]],
    text(size: 0.8em)[#link(<ind-17>)[Occupation sol \(couvert forestier\)]],
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
      text(size: 1em, weight: "bold")[Fragilité des sols et transferts \(chronique\)],
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
    text(size: 0.8em, fill: rgb("#555555"))[#link(<ind-18>)[18]],
    text(size: 0.8em)[#link(<ind-18>)[Occupation sol \(surfaces agricoles\)]],
  )
)
#v(0.7em)
#pagebreak()

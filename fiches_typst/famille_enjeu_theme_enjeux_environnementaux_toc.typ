#import "../template_typst.typ": *

// ─── TOC THÈME : Enjeux Environnementaux ───────────────────────────────
#block(width: 100%, fill: rgb("#2E7D32"), radius: 4pt,
  inset: (x: 14pt, y: 12pt),
  text(size: 1.2em, weight: "bold", fill: white)[Enjeux Environnementaux]
)
#block(
  width: 100%,
  inset: (x: 2pt, top: 6pt, bottom: 4pt),
  grid(
    columns: 1,
    row-gutter: 4pt,
    text(size: 0.82em, fill: rgb("#475569"), style: "italic")[Caractérise la valeur écologique, patrimoniale et réglementaire des milieux naturels autour des captages, ainsi que leur rôle de protection \(filtration, limitation de l’érosion\) et leur niveau de reconnaissance et de préservation.],
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
      text(size: 1em, weight: "bold")[Valeur patrimoniale et réglementaire],
      text(size: 0.85em, fill: rgb("#333333"))[Repérer les bassins versants inscrits dans des périmètres de reconnaissance mondiale ou locale \(UNESCO, aires protégées\) nécessitant une gestion exemplaire.],
      text(size: 0.8em, fill: rgb("#666666"), style: "italic")[Assure le suivi des engagements de conservation et des contraintes réglementaires associées.],
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
    text(size: 0.8em, fill: rgb("#555555"))[#link(<ind-11>)[11]],
    text(size: 0.8em)[#link(<ind-11>)[Zones UNESCO]],
    text(size: 0.8em, fill: rgb("#555555"))[#link(<ind-12>)[12]],
    text(size: 0.8em)[#link(<ind-12>)[Zones protégées provinciales]],
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
      text(size: 1em, weight: "bold")[Richesse biologique et rareté],
      text(size: 0.85em, fill: rgb("#333333"))[Localiser les zones de biodiversité critique \(KBA, espèces menacées\) qui dépendent du maintien de la qualité de la ressource en eau.],
      text(size: 0.8em, fill: rgb("#666666"), style: "italic")[Surveille l'état des écosystèmes sensibles dépendants de la ressource en eau.],
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
  fill: luma(252),
  stroke: (left: 5pt + rgb("#546E7A")),
  radius: (right: 6pt),
  inset: (left: 12pt, right: 10pt, top: 8pt, bottom: 8pt),
  grid(
    columns: (1fr, auto),
    column-gutter: 8pt,
    align: horizon,
    grid(
      columns: 1,
      row-gutter: 3pt,
      text(size: 1em, weight: "bold")[État écologique et rôle protecteur],
      text(size: 0.85em, fill: rgb("#333333"))[Qualifier l'intégrité de la couverture végétale naturelle agissant comme un filtre et un régulateur naturel contre le ruissellement.],
      text(size: 0.8em, fill: rgb("#666666"), style: "italic")[Mesure la capacité naturelle du milieu à protéger la ressource par filtration.],
    ),
    box(fill: rgb("#546E7A"), radius: 999pt,
      inset: (x: 10pt, y: 5pt),
      text(size: 0.75em, weight: "bold", fill: white)[COMPRENDRE]
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
#pagebreak()

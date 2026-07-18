#import "../template_typst.typ": *

// ─── TOC THÈME : Enjeux Environnementaux ───────────────────────────────
#block(width: 100%, fill: rgb("2b5e8c"), radius: 4pt, inset: (x: 14pt, y: 12pt),
  text(size: 1.2em, weight: "bold", fill: white)[Enjeux Environnementaux]
)
#block(
  width: 100%,
  inset: (x: 2pt, top: 6pt, bottom: 4pt),
  grid(
    columns: 1,
    row-gutter: 4pt,
    text(size: 0.82em, style: "italic", fill: rgb("#475569"))[Caractérise la valeur écologique, patrimoniale et réglementaire des milieux naturels autour des captages, ainsi que leur rôle de protection \(filtration, limitation de l’érosion\) et leur niveau de reconnaissance et de préservation.],
  )
)
#v(0.8em)
#block(
  width: 100%,
  stroke: (left: 5pt + rgb("3bc29f")),
  fill: luma(252),
  radius: (right: 6pt),
  inset: (left: 12pt, right: 10pt, top: 8pt, bottom: 8pt),
  grid(
    columns: (1fr, auto),
    column-gutter: 8pt,
    align: horizon,
    grid(
      columns: 1,
      row-gutter: 3pt,
      text(size: 1em, weight: "bold")[Zone naturelle],
      text(size: 0.85em, fill: rgb("#333333"))[Repérer les bassins versants inscrits dans des périmètres de reconnaissance mondiale ou locale \(UNESCO, aires protégées\) nécessitant une gestion exemplaire.],
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
    text(size: 0.78em, weight: "bold", fill: rgb("3bc29f"))[Fiche n°],
    text(size: 0.78em, weight: "bold", fill: rgb("3bc29f"))[Indicateur],
    text(size: 0.8em, fill: rgb("#555555"))[#link(<ind-13>)[13]],
    text(size: 0.8em)[#link(<ind-13>)[Occupation sol \(couvert végétal\)]],
    text(size: 0.8em, fill: rgb("#555555"))[#link(<ind-14>)[14]],
    text(size: 0.8em)[#link(<ind-14>)[Occupation sol \(couvert forestier\)]],
  )
)
#v(0.7em)
#block(
  width: 100%,
  stroke: (left: 5pt + rgb("3bc29f")),
  fill: luma(252),
  radius: (right: 6pt),
  inset: (left: 12pt, right: 10pt, top: 8pt, bottom: 8pt),
  grid(
    columns: (1fr, auto),
    column-gutter: 8pt,
    align: horizon,
    grid(
      columns: 1,
      row-gutter: 3pt,
      text(size: 1em, weight: "bold")[Zones protégés],
      text(size: 0.85em, fill: rgb("#333333"))[Permettre aux gestionnaire de solliciter des fonds pour la restauration de zone à haute valeur environnementales reconnues et réglementés],
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
    text(size: 0.78em, weight: "bold", fill: rgb("3bc29f"))[Fiche n°],
    text(size: 0.78em, weight: "bold", fill: rgb("3bc29f"))[Indicateur],
    text(size: 0.8em, fill: rgb("#555555"))[#link(<ind-15>)[15]],
    text(size: 0.8em)[#link(<ind-15>)[Zones UNESCO]],
    text(size: 0.8em, fill: rgb("#555555"))[#link(<ind-16>)[16]],
    text(size: 0.8em)[#link(<ind-16>)[Zones protégées provinciales]],
    text(size: 0.8em, fill: rgb("#555555"))[#link(<ind-17>)[17]],
    text(size: 0.8em)[#link(<ind-17>)[KBA \/ ZICO]],
    text(size: 0.8em, fill: rgb("#555555"))[#link(<ind-18>)[18]],
    text(size: 0.8em)[#link(<ind-18>)[Espèces rares et menacées dont forêt sèche]],
  )
)
#v(0.7em)
#pagebreak()

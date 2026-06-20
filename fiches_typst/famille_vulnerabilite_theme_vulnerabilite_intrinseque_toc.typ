#import "../template_typst.typ": *

// ─── TOC THÈME : Vulnérabilité Intrinsèque ───────────────────────────────
#block(width: 100%, fill: rgb("#546E7A"), radius: 4pt,
  inset: (x: 14pt, y: 12pt),
  text(size: 1.2em, weight: "bold", fill: white)[Vulnérabilité Intrinsèque]
)
#block(
  width: 100%,
  inset: (x: 2pt, top: 6pt, bottom: 4pt),
  grid(
    columns: 1,
    row-gutter: 4pt,
    text(size: 0.82em, fill: rgb("#475569"), style: "italic")[Caractérise la sensibilité naturelle des milieux aux transferts d’eau et de polluants, en fonction de leurs propriétés physiques indépendantes des pressions externes.],
  )
)
#v(0.8em)
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
      text(size: 1em, weight: "bold")[Sensibilité naturelle],
      text(size: 0.85em, fill: rgb("#333333"))[Qualifier la propension naturelle du terrain à laisser circuler les polluants vers les eaux souterraines ou superficielles selon ses propriétés géologiques.],
      text(size: 0.8em, fill: rgb("#666666"), style: "italic")[Définit le socle physique immuable qui module \(amplifie ou réduit\) l'impact des pressions.],
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
    text(size: 0.8em, fill: rgb("#555555"))[#link(<ind-31>)[31]],
    text(size: 0.8em)[#link(<ind-31>)[Géologie]],
    text(size: 0.8em, fill: rgb("#555555"))[#link(<ind-32>)[32]],
    text(size: 0.8em)[#link(<ind-32>)[Vulnérabilité intrinsèque des eaux souterraines]],
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
      text(size: 1em, weight: "bold")[Vulnérabilité technique],
      text(size: 0.85em, fill: rgb("#333333"))[Différencier les ressources selon leur nature \(ouvrage\) et leur usage actuel pour affiner la comparaison entre les points d'eau.],
      text(size: 0.8em, fill: rgb("#666666"), style: "italic")[Caractérise la sensibilité propre de l'ouvrage \(ex: forage vs captage superficiel\).],
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
    text(size: 0.8em, fill: rgb("#555555"))[#link(<ind-9>)[9]],
    text(size: 0.8em)[#link(<ind-9>)[Type ouvrage]],
    text(size: 0.8em, fill: rgb("#555555"))[#link(<ind-10>)[10]],
    text(size: 0.8em)[#link(<ind-10>)[Statut captage]],
  )
)
#v(0.7em)
#pagebreak()

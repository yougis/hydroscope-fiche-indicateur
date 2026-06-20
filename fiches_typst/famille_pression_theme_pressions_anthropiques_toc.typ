#import "../template_typst.typ": *

// ─── TOC THÈME : Pressions Anthropiques ───────────────────────────────
#block(width: 100%, fill: rgb("#005596"), radius: 4pt,
  inset: (x: 14pt, y: 12pt),
  text(size: 1.2em, weight: "bold", fill: white)[Pressions Anthropiques]
)
#block(
  width: 100%,
  inset: (x: 2pt, top: 6pt, bottom: 4pt),
  grid(
    columns: 1,
    row-gutter: 4pt,
    text(size: 0.82em, fill: rgb("#475569"), style: "italic")[Caractérise les pressions exercées par les activités humaines, l’occupation du sol et les infrastructures sur les ressources en eau.],
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
      text(size: 1em, weight: "bold")[Activités à risque],
      text(size: 0.85em, fill: rgb("#333333"))[Recenser les implantations industrielles \(ICPE\) ou minières pouvant générer des pollutions accidentelles ou chroniques.],
      text(size: 0.8em, fill: rgb("#666666"), style: "italic")[Oriente les contrôles de la police de l'eau et la surveillance des sites industriels.],
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
    text(size: 0.8em, fill: rgb("#555555"))[#link(<ind-18>)[18]],
    text(size: 0.8em)[#link(<ind-18>)[Occupation sol \(surfaces agricoles\)]],
    text(size: 0.8em, fill: rgb("#555555"))[#link(<ind-24>)[24]],
    text(size: 0.8em)[#link(<ind-24>)[ICPE]],
    text(size: 0.8em, fill: rgb("#555555"))[#link(<ind-25>)[25]],
    text(size: 0.8em)[#link(<ind-25>)[Activité minière]],
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
      text(size: 1em, weight: "bold")[Niveau d'artificialisation et densité],
      text(size: 0.85em, fill: rgb("#333333"))[Quantifier l'emprise du bâti et de l'habitat pour évaluer la pression directe exercée par l'occupation humaine sur le milieu.],
      text(size: 0.8em, fill: rgb("#666666"), style: "italic")[Suit l'évolution de l'empreinte humaine et de l'imperméabilisation des sols.],
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
    text(size: 0.8em, fill: rgb("#555555"))[#link(<ind-26>)[26]],
    text(size: 0.8em)[#link(<ind-26>)[Urbanisation]],
    text(size: 0.8em, fill: rgb("#555555"))[#link(<ind-28>)[28]],
    text(size: 0.8em)[#link(<ind-28>)[Habitations]],
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
      text(size: 1em, weight: "bold")[Infrastructures et risques de dégradation des eaux],
      text(size: 0.85em, fill: rgb("#333333"))[Identifier les points de contact entre les réseaux de transport et le milieu hydrographique pour localiser les zones à risque de pollution \(ruissellement routier, accidents\) et de dégradation de la qualité des cours d'eau \(sédimentation, modification des écoulements\)],
      text(size: 0.8em, fill: rgb("#666666"), style: "italic")[Cible les points de vigilance pour prévenir les pollutions liées au ruissellement routier.],
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
    text(size: 0.8em, fill: rgb("#555555"))[#link(<ind-29>)[29]],
    text(size: 0.8em)[#link(<ind-29>)[Franchissements]],
    text(size: 0.8em, fill: rgb("#555555"))[#link(<ind-30>)[30]],
    text(size: 0.8em)[#link(<ind-30>)[Linéaire routes]],
  )
)
#v(0.7em)
#pagebreak()

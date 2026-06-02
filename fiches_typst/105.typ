#import "../template_typst.typ": *

#let brand = rgb("#546E7A")

#text(size: 1.6em, weight: "bold", fill: brand)[Occupation sol (couvert végétal)]
#v(0.3em)
#text(size: 0.85em, fill: rgb("#666"))[Fiche n°16]
#v(0.5em)
#line(length: 100%, stroke: 0.5pt + rgb("#d9e2ea"))
#v(0.5em)
#box(
  width: 100%,
  fill: fiche_vision_bg,
  stroke: (left: 6pt + brand),
  radius: 3pt,
  inset: 8pt,
  stack(dir: ttb, spacing: 0.3em,
    text(size: 0.85em, weight: "bold")[Vision stratégique],
    text(size: 0.85em)[🔬 #h(0.3em) #text(weight: "bold")[Diagnostic & Modulation]],
    text(size: 0.75em)[Mesure la capacité naturelle du milieu à protéger la ressource par filtration.],
    badge("Groupe", "État écologique et rôle protecteur"),
    badge("Objectif groupe", "Qualifier l'intégrité de la couverture végétale naturelle agissant comme un filtre et un régulateur naturel contre le ruissellement."),
  )
)
#v(0.7em)
#grid(
  columns: (1.65fr, 1fr),
  column-gutter: 15pt,
  box(
    width: 100%,
    fill: fiche_bg,
    stroke: 0.5pt + fiche_border,
    radius: 3pt,
    inset: 8pt,
    stack(dir: ttb, spacing: 0.35em,
      text(size: 0.85em, weight: "bold")[Analyse & criticité],
      stack(dir: ttb, spacing: 0.1em,
        text(size: 0.75em, weight: "bold")[Objectif],
        text(size: 0.71em)[Caractériser la présence de couvert végétal comme indicateur de bon état écologique du milieu.],
      ),
      stack(dir: ttb, spacing: 0.1em,
        text(size: 0.75em, weight: "bold")[Normalisation],
        text(size: 0.71em)[Classes 3 niveaux],
      ),
      stack(dir: ttb, spacing: 0.1em,
        text(size: 0.75em, weight: "bold")[Sens de l'indicateur],
        text(size: 0.71em)[Positif (plus = mieux) #h(0.2em) #text(fill: rgb("#2e7d32"), size: 0.95em)[↑]],
      ),
      stack(dir: ttb, spacing: 0.1em,
        text(size: 0.75em, weight: "bold")[Définition de la criticité],
        text(size: 0.71em)[Fort couvert végétal = faible criticité],
      ),
    )
  ),
  box(
    width: 100%,
    fill: fiche_bg,
    stroke: 0.5pt + fiche_border,
    radius: 3pt,
    inset: 8pt,
    stack(dir: ttb, spacing: 0.4em,
      text(size: 0.85em, weight: "bold")[Contexte technique],
      badge("Support spatial", "maille"),
      badge("Pondération", "Oui"),
      badge("Spatialisation H3", "Oui"),
      badge("Nature des données", "Quantitatif"),
    )
  ),
)
#v(0.7em)
#box(
  width: 100%,
  fill: rgb(255, 250, 240),
  stroke: 1.5pt + rgb("#c62828"),
  radius: 3pt,
  inset: 8pt,
  stack(dir: ttb, spacing: 0.3em,
    text(size: 0.85em, weight: "bold", fill: rgb("#c62828"))[Point de vigilance],
    stack(dir: ttb, spacing: 0.1em,
      text(size: 0.75em, weight: "bold")[Redondance (R7)],
      text(size: 0.71em)[Utilisation concurrente de plusieurs sources (MOS, TMF, Dynamic World) pour le couvert végétal et le sol nu ,  risque de doublons techniques.],
    ),
  )
)
#v(0.7em)
#text(size: 0.85em, weight: "bold")[Sources & fiabilité]
#v(0.4em)
#box(
  width: 100%,
  fill: fiche_bg,
  stroke: 0.5pt + rgb("#dce4eb"),
  radius: 3pt,
  inset: 8pt,
  stack(dir: ttb, spacing: 0.25em,
    text(size: 0.71em, style: "italic")[Aucune source de donnée identifiée.]
  )
)
#v(0.5em)
#pagebreak()

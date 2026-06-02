#import "../template_typst.typ": *

#let brand = rgb("#2E7D32")

#text(size: 1.6em, weight: "bold", fill: brand)[Espèces menacées]
#v(0.3em)
#text(size: 0.85em, fill: rgb("#666"))[Fiche n°14]
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
    text(size: 0.85em)[👁 #h(0.3em) #text(weight: "bold")[Veille]],
    text(size: 0.75em)[Surveille l'état des écosystèmes sensibles dépendants de la ressource en eau.],
    badge("Groupe", "Richesse biologique et rareté"),
    badge("Objectif groupe", "Localiser les zones de biodiversité critique (KBA, espèces menacées) qui dépendent du maintien de la qualité de la ressource en eau."),
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
        text(size: 0.71em)[Mesurer la richesse spécifique menacée dépendante de la ressource en eau.],
      ),
      stack(dir: ttb, spacing: 0.1em,
        text(size: 0.75em, weight: "bold")[Normalisation],
        text(size: 0.71em)[Classes 3 niveaux],
      ),
      stack(dir: ttb, spacing: 0.1em,
        text(size: 0.75em, weight: "bold")[Sens de l'indicateur],
        text(size: 0.71em)[Positif (absence = critique / plus = mieux) #h(0.2em) #text(fill: rgb("#2e7d32"), size: 0.95em)[↑]],
      ),
      stack(dir: ttb, spacing: 0.1em,
        text(size: 0.75em, weight: "bold")[Définition de la criticité],
        text(size: 0.71em)[Forte richesse en espèces menacées = criticité faible bien que enjeu fort (à confirmer)],
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
      badge("Pondération", "Non"),
      badge("Spatialisation H3", "Oui"),
      badge("Nature des données", "Quantitatif"),
    )
  ),
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
    text(size: 0.8em, weight: "bold")[Espèces rares et menacées (nom à vérifier)],
    text(size: 0.75em)[#text(weight: "bold")[Origine :] Endemia],
    text(size: 0.75em)[#text(weight: "bold")[Distributeur :] ENDEMIA],
    text(size: 0.75em)[#text(weight: "bold")[Couverture spatiale :] Nouvelle-calédonie],
    text(size: 0.75em)[#text(weight: "bold")[Actualisation :] inconnu],
    text(size: 0.75em)[#text(weight: "bold")[Disponibilité :] Disponible],
    text(size: 0.71em, style: "italic")[Couche espèces menacées non publiée sur GéoRep – consulter directement ENDEMIA],
  )
)
#v(0.5em)
#pagebreak()

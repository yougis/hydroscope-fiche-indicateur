#import "../template_typst.typ": *

#let brand = rgb("#2E7D32")

#text(size: 1.6em, weight: "bold", fill: brand)[Espèces exotiques envahissantes (EEE)]
#v(0.3em)
#text(size: 0.85em, fill: rgb("#666"))[Fiche n°23]
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
    text(size: 0.75em)[Permet une réaction rapide face aux chocs brutaux impactant le bassin versant.],
    badge("Groupe", "Perturbations majeures du milieu (Aléa)"),
    badge("Objectif groupe", "Identifier les bassins dont l'équilibre écologique a été rompu par des événements destructeurs comme les incendies."),
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
        text(size: 0.71em)[Comparer les bassins versants selon la présence d’espèces envahissantes afin d’identifier des pressions écologiques potentielles.],
      ),
      stack(dir: ttb, spacing: 0.1em,
        text(size: 0.75em, weight: "bold")[Normalisation],
        text(size: 0.71em)[Classes 3 niveaux],
      ),
      stack(dir: ttb, spacing: 0.1em,
        text(size: 0.75em, weight: "bold")[Sens de l'indicateur],
        text(size: 0.71em)[Négatif (plus = critique) #h(0.2em) #text(fill: rgb("#c62828"), size: 0.95em)[↓]],
      ),
      stack(dir: ttb, spacing: 0.1em,
        text(size: 0.75em, weight: "bold")[Définition de la criticité],
        text(size: 0.71em)[Présence forte = pression écologique élevée],
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
      badge("Support spatial", "BV"),
      badge("Pondération", "Non"),
      badge("Spatialisation H3", "Non"),
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
    text(size: 0.8em, weight: "bold")[Espèces envahissantes],
    text(size: 0.75em)[#text(weight: "bold")[Origine :] ANCB],
    text(size: 0.75em)[#text(weight: "bold")[Distributeur :] patrick Barrière ANCB],
    text(size: 0.75em)[#text(weight: "bold")[Couverture spatiale :] Nouvelle-calédonie],
    text(size: 0.75em)[#text(weight: "bold")[Actualisation :] inconnu],
    text(size: 0.75em)[#text(weight: "bold")[Disponibilité :] Disponible],
    text(size: 0.71em, style: "italic")[données régionalisées par communes, avec des bilans et des résultats de chasse],
  )
)
#v(0.5em)
#pagebreak()

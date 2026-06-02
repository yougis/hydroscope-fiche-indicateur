#import "../template_typst.typ": *

#let brand = rgb("#005596")

#text(size: 1.6em, weight: "bold", fill: brand)[Capacité réservoir]
#v(0.3em)
#text(size: 0.85em, fill: rgb("#666"))[Fiche n°3]
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
    text(size: 0.75em)[Guide la mise en conformité légale et les actions de protection réglementaire.],
    badge("Groupe", "Robustesse et résilience technique"),
    badge("Objectif groupe", "Évaluer la capacité de production en période sèche et la présence de dispositifs de secours (stockage, interconnexion) pour garantir la continuité du service."),
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
        text(size: 0.71em)[Comparer la capacité de stockage associée aux captages afin d’identifier les systèmes les plus résilients face aux aléas.],
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
        text(size: 0.71em)[Faible stockage = forte criticité (manque résilience), fort stockage = faible criticité],
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
      badge("Support spatial", "UD"),
      badge("Pondération", "Oui"),
      badge("Spatialisation H3", "Non"),
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
      text(size: 0.75em, weight: "bold")[Incohérence (R8)],
      text(size: 0.71em)[Risque de doublons ou de sur-comptage si plusieurs captages sont rattachés à une même Unité de Distribution (UD) pour le réseau, les réservoirs ou la population.],
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
    text(size: 0.8em, weight: "bold")[unité de distribution (nom à vérifier)],
    text(size: 0.75em)[#text(weight: "bold")[Origine :] DASS],
    text(size: 0.75em)[#text(weight: "bold")[Actualisation :] inconnu],
    text(size: 0.75em)[#text(weight: "bold")[Disponibilité :] Interne],
    text(size: 0.71em, style: "italic")[Données DASS à vocation administrative interne – contacter DASS],
  )
)
#v(0.5em)
#pagebreak()

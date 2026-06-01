#import "../template_typst.typ": *

#let brand = rgb("#005596")

#text(size: 1.6em, weight: "bold", fill: brand)[Longueur réseau]
#v(0.4em)
#grid(
  columns: (1fr, auto),
  column-gutter: 10pt,
  stack(dir: ttb, spacing: 0.2em,
    text(size: 0.9em)[#text(weight: "bold")[Thème :] Enjeux AEP],
    text(size: 0.9em)[#text(weight: "bold")[Famille :] Enjeu],
  ),
  box(
    width: auto,
    fill: brand,
    radius: 999pt,
    inset: (x: 12pt, y: 8pt),
    text(size: 0.9em, weight: "bold", fill: white)[Fiche n°2]
  ),
)
#line(length: 100%, stroke: 0.5pt + rgb("#d9e2ea"))
#v(0.7em)
#box(
  width: 100%,
  fill: fiche_vision_bg,
  stroke: (left: 6pt + brand),
  radius: 8pt,
  inset: 10pt,
  stack(dir: ttb, spacing: 0.3em,
    text(size: 1em, weight: "bold")[Vision stratégique],
    text(size: 1.05em)[🎯 #h(0.3em) #text(weight: "bold")[Pilotage]],
    text(size: 0.9em)[Définit les priorités d'investissement et l'importance socio-économique de la ressource.],
    badge("Groupe", "Poids stratégique de la desserte"),
    badge("Objectif groupe", "Identifier les ressources dont la défaillance impacterait le plus grand nombre d'habitants ou le plus important linéaire d'infrastructures de distribution."),
  )
)
#v(0.7em)
#grid(
  columns: (1.65fr, 1fr),
  column-gutter: 10pt,
  box(
    width: 100%,
    fill: fiche_bg,
    stroke: 0.5pt + fiche_border,
    radius: 8pt,
    inset: 10pt,
    stack(dir: ttb, spacing: 0.35em,
      text(size: 1em, weight: "bold")[Analyse & criticité],
      stack(dir: ttb, spacing: 0.1em,
        text(size: 0.85em, weight: "bold")[Objectif],
        text(size: 0.85em)[Comparer l’importance des infrastructures dépendantes de chaque captage afin d’identifier ceux dont la défaillance aurait le plus d’impact.],
      ),
      stack(dir: ttb, spacing: 0.1em,
        text(size: 0.85em, weight: "bold")[Normalisation],
        text(size: 0.85em)[Classes 3 niveaux],
      ),
      stack(dir: ttb, spacing: 0.1em,
        text(size: 0.85em, weight: "bold")[Sens de l'indicateur],
        text(size: 0.85em)[Positif (absence = critique / plus = mieux) #h(0.2em) #text(fill: rgb("#2e7d32"), size: 1.1em)[↑]],
      ),
      stack(dir: ttb, spacing: 0.1em,
        text(size: 0.85em, weight: "bold")[Définition de la criticité],
        text(size: 0.85em)[Plus le réseau est long, plus les enjeux sont élevés → criticité stratégique élevée],
      ),
    )
  ),
  box(
    width: 100%,
    fill: fiche_bg,
    stroke: 0.5pt + fiche_border,
    radius: 8pt,
    inset: 10pt,
    stack(dir: ttb, spacing: 0.4em,
      text(size: 1em, weight: "bold")[Contexte technique],
      badge("Support spatial", "UD"),
      badge("Pondération", "Oui"),
      badge("Spatialisation H3", "Non"),
      badge("Nature des données", "Quantitatif"),
    )
  ),
)
#v(0.7em)
#fiche_alert_box[
  #stack(dir: ttb, spacing: 0.3em,
    text(size: 1em, weight: "bold")[Vigilance expert],
    stack(dir: ttb, spacing: 0.1em,
      text(size: 0.85em, weight: "bold")[Incohérence (R8)],
      text(size: 0.85em)[Risque de doublons ou de sur-comptage si plusieurs captages sont rattachés à une même Unité de Distribution (UD) pour le réseau, les réservoirs ou la population \[10, 11\].],
    ),
  )
]
#v(0.7em)
#text(size: 1em, weight: "bold")[Sources & fiabilité]
#v(0.4em)
#box(
  width: 100%,
  fill: fiche_bg,
  stroke: 0.5pt + rgb("#dce4eb"),
  radius: 8pt,
  inset: 10pt,
  stack(dir: ttb, spacing: 0.25em,
    text(size: 0.95em, weight: "bold")[unité de distribution (nom à vérifier)],
    text(size: 0.85em)[#text(weight: "bold")[Origine :] DASS],
    text(size: 0.85em)[#text(weight: "bold")[Actualisation :] inconnu],
    text(size: 0.85em)[#text(weight: "bold")[Disponibilité :] Interne],
    text(size: 0.85em, style: "italic")[Données DASS à vocation administrative interne – contacter DASS],
  )
)
#v(0.5em)
#pagebreak()

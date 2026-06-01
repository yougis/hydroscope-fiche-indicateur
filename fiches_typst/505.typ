#import "../template_typst.typ": *

#let brand = rgb("#005596")

#text(size: 1.6em, weight: "bold", fill: brand)[Qualité eau]
#v(0.4em)
#grid(
  columns: (1fr, auto),
  column-gutter: 10pt,
  stack(dir: ttb, spacing: 0.2em,
    text(size: 0.9em)[#text(weight: "bold")[Thème :] Pressions Qualitatives],
    text(size: 0.9em)[#text(weight: "bold")[Famille :] Pression],
  ),
  box(
    width: auto,
    fill: brand,
    radius: 999pt,
    inset: (x: 12pt, y: 8pt),
    text(size: 0.9em, weight: "bold", fill: white)[Fiche n°505]
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
    text(size: 0.9em)[Sert de diagnostic de confirmation pour valider l'impact réel des pressions sur la ressource.],
    badge("Groupe", "État sanitaire et suivi de la qualité"),
    badge("Objectif groupe", "Identifier les captages dont la qualité de l'eau est dégradée afin de prioriser les actions de gestion ou de protection."),
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
        text(size: 0.85em)[Comparer les captages selon leur qualité afin d’identifier ceux nécessitant des actions de gestion ou de protection.],
      ),
      stack(dir: ttb, spacing: 0.1em,
        text(size: 0.85em, weight: "bold")[Normalisation],
        text(size: 0.85em)[Catégoriel mappé (1-3)],
      ),
      stack(dir: ttb, spacing: 0.1em,
        text(size: 0.85em, weight: "bold")[Sens de l'indicateur],
        text(size: 0.85em)[Croissant #h(0.2em) #text(fill: rgb("#555555"), size: 1.1em)[↔]],
      ),
      stack(dir: ttb, spacing: 0.1em,
        text(size: 0.85em, weight: "bold")[Définition de la criticité],
        text(size: 0.85em)[Classe dégradée = criticité élevée],
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
      badge("Support spatial", "Captage"),
      badge("Pondération", "Oui"),
      badge("Spatialisation H3", "Non"),
      badge("Nature des données", "Qualitatif"),
    )
  ),
)
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
    text(size: 0.95em, weight: "bold")[Base de données ATYA (nom à vérifier)],
    text(size: 0.85em)[#text(weight: "bold")[Origine :] DASS],
    text(size: 0.85em)[#text(weight: "bold")[Actualisation :] inconnu],
    text(size: 0.85em)[#text(weight: "bold")[Disponibilité :] Interne],
    text(size: 0.85em, style: "italic")[Données DASS/ATYA diffusion interne – contacter DASS],
  )
)
#v(0.5em)
#pagebreak()

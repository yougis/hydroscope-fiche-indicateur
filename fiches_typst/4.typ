#import "../template_typst.typ": *

#let brand = rgb("#005596")

#text(size: 1.6em, weight: "bold", fill: brand)[Traitement]
#v(0.3em)
#text(size: 0.85em, fill: rgb("#666"))[Fiche n°4]
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
    text(size: 0.85em)[🎯 #h(0.3em) #text(weight: "bold")[Pilotage]],
    text(size: 0.75em)[Mesurer le niveau de conformité administrative (AODPE) et de protection physique (PPE/Traitement) afin d'identifier les risques d'exposition aux pollutions],
    badge("Groupe", "Sécurisation sanitaire et réglementaire"),
    badge("Objectif groupe", "Mesurer le niveau de conformité administrative (AODPE) et de protection physique (PPE/Traitement) pour identifier les risques d'exposition aux pollutions."),
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
        text(size: 0.71em)[Comparer le niveau de sécurisation sanitaire des captages afin d’identifier ceux présentant des risques pour l’alimentation en eau potable.],
      ),
      stack(dir: ttb, spacing: 0.1em,
        text(size: 0.75em, weight: "bold")[Normalisation],
        text(size: 0.71em)[Catégoriel mappé (1-3)],
      ),
      stack(dir: ttb, spacing: 0.1em,
        text(size: 0.75em, weight: "bold")[Sens de l'indicateur],
        text(size: 0.71em)[Positif (absence = critique / plus = mieux) #h(0.2em) #text(fill: rgb("#2e7d32"), size: 0.95em)[↑]],
      ),
      stack(dir: ttb, spacing: 0.1em,
        text(size: 0.75em, weight: "bold")[Définition de la criticité],
        text(size: 0.71em)[Absence de traitement = criticité forte (bien que si des traitements sont fait c’est que la ressource est déjà impactée par des polluants), traitement complet = criticité faible],
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
      badge("Nature des données", "Qualitatif"),
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
    text(size: 0.8em, weight: "bold")[unité de distribution (nom à vérifier)],
    text(size: 0.75em)[#text(weight: "bold")[Origine :] DASS],
    text(size: 0.75em)[#text(weight: "bold")[Actualisation :] inconnu],
    text(size: 0.75em)[#text(weight: "bold")[Disponibilité :] Interne],
    text(size: 0.71em, style: "italic")[Données DASS à vocation administrative interne – contacter DASS],
  )
)
#v(0.5em)
#pagebreak()

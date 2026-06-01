#import "../template_typst.typ": *

#let brand = rgb("#2E7D32")

#text(size: 1.6em, weight: "bold", fill: brand)[Espèces menacées (Forêt sèche)]
#v(0.4em)
#grid(
  columns: (1fr, auto),
  column-gutter: 10pt,
  stack(dir: ttb, spacing: 0.2em,
    text(size: 0.9em)[#text(weight: "bold")[Thème :] Enjeux Environnementaux],
    text(size: 0.9em)[#text(weight: "bold")[Famille :] Enjeu],
  ),
  box(
    width: auto,
    fill: brand,
    radius: 999pt,
    inset: (x: 12pt, y: 8pt),
    text(size: 0.9em, weight: "bold", fill: white)[Fiche n°104]
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
    text(size: 1.05em)[👁 #h(0.3em) #text(weight: "bold")[Veille]],
    text(size: 0.9em)[Surveille l'état des écosystèmes sensibles dépendants de la ressource en eau.],
    badge("Groupe", "Richesse biologique et rareté"),
    badge("Objectif groupe", "Localiser les zones de biodiversité critique (KBA, espèces menacées) qui dépendent du maintien de la qualité de la ressource en eau."),
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
        text(size: 0.85em)[Identifier la présence de forêt sèche, écosystème endémique parmi les plus menacés de Nouvelle-Calédonie.],
      ),
      stack(dir: ttb, spacing: 0.1em,
        text(size: 0.85em, weight: "bold")[Normalisation],
        text(size: 0.85em)[Classes 3 niveaux],
      ),
      stack(dir: ttb, spacing: 0.1em,
        text(size: 0.85em, weight: "bold")[Sens de l'indicateur],
        text(size: 0.85em)[Négatif (absence = critique) ? #h(0.2em) #text(fill: rgb("#c62828"), size: 1.1em)[↓]],
      ),
      stack(dir: ttb, spacing: 0.1em,
        text(size: 0.85em, weight: "bold")[Définition de la criticité],
        text(size: 0.85em)[Présence de forêt sèche  = criticité faible bien que enjeu fort (à confirmer)],
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
      badge("Support spatial", "maille"),
      badge("Pondération", "Non"),
      badge("Spatialisation H3", "Oui"),
      badge("Nature des données", "Quantitatif"),
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
    text(size: 0.95em, weight: "bold")[Forêt sèche – Indices de vulnérabilité],
    text(size: 0.85em)[#text(weight: "bold")[Origine :] CEN],
    text(size: 0.85em)[#text(weight: "bold")[Distributeur :] GEOREP],
    text(size: 0.85em)[#text(weight: "bold")[Couverture spatiale :] Nouvelle-calédonie],
    text(size: 0.85em)[#text(weight: "bold")[Actualisation :] inconnu],
    text(size: 0.85em)[#text(weight: "bold")[Disponibilité :] Disponible],
    link("https://georep-dtsi-sgt.opendata.arcgis.com/maps/b9304b72009f45e6aa4fc2fab702e98b")[#text(size: 0.85em, fill: brand)[Accéder à la ressource]],
    text(size: 0.85em, style: "italic")[Cartographie partielle selon les provinces.],
  )
)
#v(0.5em)
#pagebreak()

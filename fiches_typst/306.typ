#import "../template_typst.typ": *

#let brand = rgb("#2E7D32")

#text(size: 1.6em, weight: "bold", fill: brand)[Linéaire routes]
#v(0.4em)
#grid(
  columns: (1fr, auto),
  column-gutter: 10pt,
  stack(dir: ttb, spacing: 0.2em,
    text(size: 0.9em)[#text(weight: "bold")[Thème :] Pressions Anthropiques],
    text(size: 0.9em)[#text(weight: "bold")[Famille :] Pression],
  ),
  box(
    width: auto,
    fill: brand,
    radius: 999pt,
    inset: (x: 12pt, y: 8pt),
    text(size: 0.9em, weight: "bold", fill: white)[Fiche n°306]
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
    text(size: 0.9em)[Cible les points de vigilance pour prévenir les pollutions liées au ruissellement routier.],
    badge("Groupe", "Infrastructures et risques de dégradation des eaux"),
    badge("Objectif groupe", "Identifier les points de contact entre les réseaux de transport et le milieu hydrographique pour localiser les zones à risque de pollution (ruissellement routier, accidents) et de dégradation de la qualité des cours d'eau (sédimentation, modification des écoulements)"),
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
        text(size: 0.85em)[Mesurer la densité du réseau routier comme indicateur de pression sur les milieux naturels et la ressource en eau. Une forte densité de routes et de pistes (souvent non classées et plus érosives) augmente l'apport de sédiments dans les cours d'eau (turbidité, engrangement) et donne l'accès à des zones sensibles et peut potentiellement provoquer des pollutions.],
      ),
      stack(dir: ttb, spacing: 0.1em,
        text(size: 0.85em, weight: "bold")[Normalisation],
        text(size: 0.85em)[Classes 3 niveaux],
      ),
      stack(dir: ttb, spacing: 0.1em,
        text(size: 0.85em, weight: "bold")[Sens de l'indicateur],
        text(size: 0.85em)[Négatif (plus = critique) #h(0.2em) #text(fill: rgb("#c62828"), size: 1.1em)[↓]],
      ),
      stack(dir: ttb, spacing: 0.1em,
        text(size: 0.85em, weight: "bold")[Définition de la criticité],
        text(size: 0.85em)[Fort linéaire routier = fragmentation et imperméabilisation élevées],
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
      badge("Pondération", "Oui"),
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
    text(size: 0.95em, weight: "bold")[Réseau routier BDROUTE-NC],
    text(size: 0.85em)[#text(weight: "bold")[Origine :] DITTT],
    text(size: 0.85em)[#text(weight: "bold")[Distributeur :] GEOREP],
    text(size: 0.85em)[#text(weight: "bold")[Couverture spatiale :] Nouvelle-calédonie],
    text(size: 0.85em)[#text(weight: "bold")[Actualisation :] inconnu],
    text(size: 0.85em)[#text(weight: "bold")[Disponibilité :] Disponible],
    link("https://georep-dtsi-sgt.opendata.arcgis.com/maps/d3915082450a4405bb30dda99e19bc61")[#text(size: 0.85em, fill: brand)[Accéder à la ressource]],
    text(size: 0.85em, style: "italic")[Base de données voies du territoire NC – ouvrages franchissant l'hydrographie],
  )
)
#v(0.5em)
#pagebreak()

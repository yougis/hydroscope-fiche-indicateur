#import "../template_typst.typ": *

#let brand = rgb("#2E7D32")

#text(size: 1.6em, weight: "bold", fill: brand)[Franchissements]
#v(0.3em)
#text(size: 0.85em, fill: rgb("#666"))[Fiche n°29]
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
    text(size: 0.75em)[Cible les points de vigilance pour prévenir les pollutions liées au ruissellement routier.],
    badge("Groupe", "Infrastructures et risques de dégradation des eaux"),
    badge("Objectif groupe", "Identifier les points de contact entre les réseaux de transport et le milieu hydrographique pour localiser les zones à risque de pollution (ruissellement routier, accidents) et de dégradation de la qualité des cours d'eau (sédimentation, modification des écoulements)"),
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
        text(size: 0.71em)[Identifier les points de franchissement (ponts, buses, gués) comme facteurs de perturbation du réseau hydrographique. Chaque pont, buse ou gué est un point où une pollution routière (hydrocarbures, transport de matières dangereuses) peut entrer directement dans le cours d'eau en amont d'un captage],
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
        text(size: 0.71em)[Nombre élevé de franchissements = pression sur continuité écologique],
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
#text(size: 0.85em, weight: "bold")[Sources & fiabilité]
#v(0.4em)
#box(
  width: 100%,
  fill: fiche_bg,
  stroke: 0.5pt + rgb("#dce4eb"),
  radius: 3pt,
  inset: 8pt,
  stack(dir: ttb, spacing: 0.25em,
    text(size: 0.8em, weight: "bold")[Réseau routier BDROUTE-NC],
    text(size: 0.75em)[#text(weight: "bold")[Origine :] DITTT],
    text(size: 0.75em)[#text(weight: "bold")[Distributeur :] GEOREP],
    text(size: 0.75em)[#text(weight: "bold")[Couverture spatiale :] Nouvelle-calédonie],
    text(size: 0.75em)[#text(weight: "bold")[Actualisation :] inconnu],
    text(size: 0.75em)[#text(weight: "bold")[Disponibilité :] Disponible],
    text(size: 0.75em)[#link("https://georep-dtsi-sgt.opendata.arcgis.com/maps/d3915082450a4405bb30dda99e19bc61")[🔗 Ressource]],
    text(size: 0.71em, style: "italic")[Base de données voies du territoire NC – ouvrages franchissant l'hydrographie],
    text(size: 0.8em, weight: "bold")[Franchissement du réseau hydrographique des BVAEP (nom à vérifier)],
    text(size: 0.75em)[#text(weight: "bold")[Origine :] DAVAR],
    text(size: 0.75em)[#text(weight: "bold")[Actualisation :] inconnu],
    text(size: 0.75em)[#text(weight: "bold")[Disponibilité :] A vérifier],
    text(size: 0.71em, style: "italic")[Base de données de la DAVAR identifiant les franchissements sur le réseau hydrographique],
  )
)
#v(0.5em)
#pagebreak()

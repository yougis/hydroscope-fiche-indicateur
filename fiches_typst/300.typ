#import "../template_typst.typ": *

#let brand = rgb("#005596")

#text(size: 1.6em, weight: "bold", fill: brand)[ICPE]
#v(0.3em)
#text(size: 0.85em, fill: rgb("#666"))[Fiche n°24]
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
    text(size: 0.75em)[Oriente les contrôles de la police de l'eau et la surveillance des sites industriels.],
    badge("Groupe", "Activités à risque"),
    badge("Objectif groupe", "Recenser les implantations industrielles (ICPE) ou minières pouvant générer des pollutions accidentelles ou chroniques."),
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
        text(size: 0.71em)[Comparer les bassins versants selon la densité d’activités à risque afin d’identifier les sources potentielles de pollution.],
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
        text(size: 0.71em)[Plus d’ICPE = risque pollution → criticité élevée],
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
    text(size: 0.8em, weight: "bold")[Installations Classées pour la Protection de l'Environnement],
    text(size: 0.75em)[#text(weight: "bold")[Origine :] DIMENC],
    text(size: 0.75em)[#text(weight: "bold")[Distributeur :] GEOREP],
    text(size: 0.75em)[#text(weight: "bold")[Couverture spatiale :] Nouvelle-calédonie],
    text(size: 0.75em)[#text(weight: "bold")[Actualisation :] inconnu],
    text(size: 0.75em)[#text(weight: "bold")[Disponibilité :] Disponible],
    text(size: 0.75em)[#link("https://georep-dtsi-sgt.opendata.arcgis.com/maps/c2e17ea9c2e84b158ff02c7b0f46fdc7")[🔗 Ressource]],
    text(size: 0.71em, style: "italic")[Peut être une compilation nécessaire avec les données des Provinces],
    text(size: 0.8em, weight: "bold")[Installations Classées pour la Protection de l'Environnement de la Province Sud],
    text(size: 0.75em)[#text(weight: "bold")[Origine :] PSUD],
    text(size: 0.75em)[#text(weight: "bold")[Distributeur :] PSUD],
    text(size: 0.75em)[#text(weight: "bold")[Couverture spatiale :] Province Sud],
    text(size: 0.75em)[#text(weight: "bold")[Actualisation :] inconnu],
    text(size: 0.75em)[#text(weight: "bold")[Disponibilité :] A vérifier],
    text(size: 0.71em, style: "italic")[Peut être une compilation nécessaire avec les données de la DIMENC],
    text(size: 0.8em, weight: "bold")[Installations Classées pour la Protection de l'Environnement de la Province Nord],
    text(size: 0.75em)[#text(weight: "bold")[Origine :] PNORD],
    text(size: 0.75em)[#text(weight: "bold")[Distributeur :] PNORD],
    text(size: 0.75em)[#text(weight: "bold")[Couverture spatiale :] Province Nord],
    text(size: 0.75em)[#text(weight: "bold")[Actualisation :] inconnu],
    text(size: 0.75em)[#text(weight: "bold")[Disponibilité :] A vérifier],
    text(size: 0.71em, style: "italic")[Peut être une compilation nécessaire avec les données de la DIMENC],
    text(size: 0.8em, weight: "bold")[Installations Classées pour la Protection de l'Environnement de la Province des Iles],
    text(size: 0.75em)[#text(weight: "bold")[Origine :] PIL],
    text(size: 0.75em)[#text(weight: "bold")[Distributeur :] PIL],
    text(size: 0.75em)[#text(weight: "bold")[Couverture spatiale :] Province des Iles],
    text(size: 0.75em)[#text(weight: "bold")[Actualisation :] inconnu],
    text(size: 0.75em)[#text(weight: "bold")[Disponibilité :] A vérifier],
    text(size: 0.71em, style: "italic")[Peut être une compilation nécessaire avec les données de la DIMENC],
  )
)
#v(0.5em)
#pagebreak()

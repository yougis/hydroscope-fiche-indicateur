#import "../template_typst.typ": *

#let brand = rgb("#546E7A")

#text(size: 1.6em, weight: "bold", fill: brand)[Statut captage]
#v(0.3em)
#text(size: 0.85em, fill: rgb("#666"))[Fiche n°10]
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
    text(size: 0.75em)[Caractérise la sensibilité propre de l'ouvrage (ex: forage vs captage superficiel).],
    badge("Groupe", "Vulnérabilité technique et contexte"),
    badge("Objectif groupe", "Différencier les ressources selon leur nature (ouvrage) et leur usage actuel pour affiner la comparaison entre les points d'eau."),
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
        text(size: 0.71em)[Distinguer les captages selon leur statut afin de contextualiser leur valeur dans la comparaison.],
      ),
      stack(dir: ttb, spacing: 0.1em,
        text(size: 0.75em, weight: "bold")[Normalisation],
        text(size: 0.71em)[Catégoriel mappé (1-3)],
      ),
      stack(dir: ttb, spacing: 0.1em,
        text(size: 0.75em, weight: "bold")[Sens de l'indicateur],
        text(size: 0.71em)[Neutre (info) #h(0.2em) #text(fill: rgb("#555555"), size: 0.95em)[↔]],
      ),
      stack(dir: ttb, spacing: 0.1em,
        text(size: 0.75em, weight: "bold")[Définition de la criticité],
        text(size: 0.71em)[Captage actif = enjeu, secours/inactif = criticité moindre],
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
      badge("Support spatial", "Captage"),
      badge("Pondération", "Non"),
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
    text(size: 0.8em, weight: "bold")[Captages d'eau],
    text(size: 0.75em)[#text(weight: "bold")[Origine :] DAVAR],
    text(size: 0.75em)[#text(weight: "bold")[Distributeur :] GEOREP],
    text(size: 0.75em)[#text(weight: "bold")[Couverture spatiale :] Nouvelle-calédonie],
    text(size: 0.75em)[#text(weight: "bold")[Actualisation :] inconnu],
    text(size: 0.75em)[#text(weight: "bold")[Disponibilité :] Disponible],
    text(size: 0.75em)[#link("https://georep-dtsi-sgt.opendata.arcgis.com/maps/89e23d7a430b4e49b67fbd6f8a79bb7b/about")[🔗 Ressource]],
    text(size: 0.71em, style: "italic")[Données administratives DAVAR],
  )
)
#v(0.5em)
#pagebreak()

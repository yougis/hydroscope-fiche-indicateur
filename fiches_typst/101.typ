#import "../template_typst.typ": *

#let brand = rgb("#2E7D32")

#text(size: 1.6em, weight: "bold", fill: brand)[Zones protégées provinciales]
#v(0.3em)
#text(size: 0.85em, fill: rgb("#666"))[Fiche n°12]
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
    text(size: 0.75em)[Assure le suivi des engagements de conservation et des contraintes réglementaires associées.],
    badge("Groupe", "Valeur patrimoniale et réglementaire"),
    badge("Objectif groupe", "Repérer les bassins versants inscrits dans des périmètres de reconnaissance mondiale ou locale (UNESCO, aires protégées) nécessitant une gestion exemplaire."),
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
        text(size: 0.71em)[Caractériser le niveau de protection réglementaire du milieu naturel autour des ressources en eau.],
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
        text(size: 0.71em)[Présence en zone protégée = criticité faible bien que  enjeu fort],
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
      badge("Pondération", "Non"),
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
    text(size: 0.8em, weight: "bold")[Aires protégées de la Province Sud],
    text(size: 0.75em)[#text(weight: "bold")[Origine :] PSUD],
    text(size: 0.75em)[#text(weight: "bold")[Distributeur :] PSUD],
    text(size: 0.75em)[#text(weight: "bold")[Couverture spatiale :] Province Sud],
    text(size: 0.75em)[#text(weight: "bold")[Actualisation :] inconnu],
    text(size: 0.75em)[#text(weight: "bold")[Disponibilité :] Disponible],
    text(size: 0.71em, style: "italic")[Aires terrestres protégées à compiler depuis les sources des 3 provinces],
    text(size: 0.8em, weight: "bold")[Aires protégées de la Province Nord],
    text(size: 0.75em)[#text(weight: "bold")[Origine :] PNORD],
    text(size: 0.75em)[#text(weight: "bold")[Distributeur :] PNORD],
    text(size: 0.75em)[#text(weight: "bold")[Couverture spatiale :] Province Nord],
    text(size: 0.75em)[#text(weight: "bold")[Actualisation :] inconnu],
    text(size: 0.75em)[#text(weight: "bold")[Disponibilité :] Disponible],
    text(size: 0.71em, style: "italic")[Aires terrestres protégées à compiler depuis les sources des 3 provinces],
    text(size: 0.8em, weight: "bold")[Aires protégées de la Province des Iles],
    text(size: 0.75em)[#text(weight: "bold")[Origine :] PIL],
    text(size: 0.75em)[#text(weight: "bold")[Distributeur :] PIL],
    text(size: 0.75em)[#text(weight: "bold")[Couverture spatiale :] Province des Iles],
    text(size: 0.75em)[#text(weight: "bold")[Actualisation :] inconnu],
    text(size: 0.75em)[#text(weight: "bold")[Disponibilité :] A vérifier],
    text(size: 0.71em, style: "italic")[Aires terrestres protégées à compiler depuis les sources des 3 provinces],
  )
)
#v(0.5em)
#pagebreak()

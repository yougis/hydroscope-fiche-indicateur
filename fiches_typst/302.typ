#import "../template_typst.typ": *

#let brand = rgb("#2E7D32")

#text(size: 1.6em, weight: "bold", fill: brand)[Urbanisation]
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
    text(size: 0.9em, weight: "bold", fill: white)[Fiche n°302]
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
    text(size: 0.9em)[Suit l'évolution de l'empreinte humaine et de l'imperméabilisation des sols.],
    badge("Groupe", "Niveau d'artificialisation et densité"),
    badge("Objectif groupe", "Quantifier l'emprise du bâti et de l'habitat pour évaluer la pression directe exercée par l'occupation humaine sur le milieu."),
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
        text(size: 0.85em)[Comparer les bassins versants selon leur niveau d’artificialisation afin d’identifier les pressions liées aux activités humaines.],
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
        text(size: 0.85em)[Plus de bâti = pression → criticité élevée],
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
#fiche_alert_box[
  #stack(dir: ttb, spacing: 0.3em,
    text(size: 1em, weight: "bold")[Vigilance expert],
    stack(dir: ttb, spacing: 0.1em,
      text(size: 0.85em, weight: "bold")[Redondance (R4)],
      text(size: 0.85em)[Les Habitations (données ISEE) sont un complément du bâti (Urbanisation)],
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
    text(size: 0.95em, weight: "bold")[Localités et zones bâties],
    text(size: 0.85em)[#text(weight: "bold")[Origine :] DITTT],
    text(size: 0.85em)[#text(weight: "bold")[Distributeur :] GEOREP],
    text(size: 0.85em)[#text(weight: "bold")[Couverture spatiale :] Nouvelle-calédonie],
    text(size: 0.85em)[#text(weight: "bold")[Actualisation :] inconnu],
    text(size: 0.85em)[#text(weight: "bold")[Disponibilité :] Disponible],
    link("https://georep-dtsi-sgt.opendata.arcgis.com/maps/10e4a961853245a38e6fb3e109f2b7d5")[#text(size: 0.85em, fill: brand)[Accéder à la ressource]],
    text(size: 0.85em, style: "italic")[Couche des  localités et zones bâties : Villes, lieux-dits, tribus – échelle 1/50 000 – mise à jour 2022. possibilité d’obtenir la surface du bâti associé et d’un nombre d’habitant (approximatif)],
  )
)
#v(0.5em)
#box(
  width: 100%,
  fill: fiche_bg,
  stroke: 0.5pt + rgb("#dce4eb"),
  radius: 8pt,
  inset: 10pt,
  stack(dir: ttb, spacing: 0.25em,
    text(size: 0.95em, weight: "bold")[BDTOPO-NC],
    text(size: 0.85em)[#text(weight: "bold")[Origine :] DITTT],
    text(size: 0.85em)[#text(weight: "bold")[Distributeur :] DITTT],
    text(size: 0.85em)[#text(weight: "bold")[Couverture spatiale :] Nouvelle-calédonie],
    text(size: 0.85em)[#text(weight: "bold")[Actualisation :] annuelle],
    text(size: 0.85em)[#text(weight: "bold")[Disponibilité :] Disponible],
    text(size: 0.85em, style: "italic")[Données brutes de la BDTOPO. Superficie par typologie de bâti. Disponible de la données sur commande.],
  )
)
#v(0.5em)
#pagebreak()

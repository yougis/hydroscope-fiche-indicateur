#import "../template_typst.typ": *

#let brand = rgb("#2E7D32")

#text(size: 1.6em, weight: "bold", fill: brand)[Terrain nu]
#v(0.4em)
#grid(
  columns: (1fr, auto),
  column-gutter: 10pt,
  stack(dir: ttb, spacing: 0.2em,
    text(size: 0.9em)[#text(weight: "bold")[Thème :] Pressions Environnementales],
    text(size: 0.9em)[#text(weight: "bold")[Famille :] Pression],
  ),
  box(
    width: auto,
    fill: brand,
    radius: 999pt,
    inset: (x: 12pt, y: 8pt),
    text(size: 0.9em, weight: "bold", fill: white)[Fiche n°202]
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
    text(size: 0.9em)[Assure la surveillance de la dégradation structurelle et lente des sols.],
    badge("Groupe", "Fragilité des sols et transferts (chronique)"),
    badge("Objectif groupe", "Détecter les zones de sols nus ou instables qui favorisent le transport de sédiments et de polluants vers les points de captage."),
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
        text(size: 0.85em)[Comparer les bassins versants selon l’étendue des surfaces dégradées afin d’identifier les zones les plus sensibles aux ruissellementau et aux transferts de polluants.],
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
        text(size: 0.85em)[Plus de sol nu = plus d’érosion → criticité élevée],
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
      text(size: 0.85em, weight: "bold")[Redondance (R3)],
      text(size: 0.85em)[L'Activité minière (identifiée via le MOS) peut faire doublon avec l'indicateur Terrain nu, sur-représentant ainsi la pression physique sur le sol \[5\].],
    ),
    stack(dir: ttb, spacing: 0.1em,
      text(size: 0.85em, weight: "bold")[Redondance (R7)],
      text(size: 0.85em)[Utilisation concurrente de plusieurs sources (MOS, TMF, Dynamic World) pour le couvert végétal et le sol nu],
    ),
    stack(dir: ttb, spacing: 0.1em,
      text(size: 0.85em, weight: "bold")[Redondance (R9)],
      text(size: 0.85em)[Risque de données non homogènes si l'on croise la \"Surface érosion\" de l'OEIL avec le \"Terrain nu\" issu du MOS],
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
    text(size: 0.95em, weight: "bold")[Occupation du sol (dynamique world v1)],
    text(size: 0.85em)[#text(weight: "bold")[Origine :] Dynamic World V1],
    text(size: 0.85em)[#text(weight: "bold")[Distributeur :] GEE],
    text(size: 0.85em)[#text(weight: "bold")[Couverture spatiale :] Nouvelle-calédonie],
    text(size: 0.85em)[#text(weight: "bold")[Actualisation :] 5 jours],
    text(size: 0.85em)[#text(weight: "bold")[Disponibilité :] Disponible],
    text(size: 0.85em, style: "italic")[Identifier la classe correspondante sur la source et nécessite l’utilisation d’une carte de synthèse annuelle ou saisonnière],
  )
)
#v(0.5em)
#pagebreak()

#import "../template_typst.typ": *

#let brand = rgb("#005596")

#text(size: 1.6em, weight: "bold", fill: brand)[Activité minière]
#v(0.3em)
#text(size: 0.85em, fill: rgb("#666"))[Fiche n°25]
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
        text(size: 0.71em)[Comparer les bassins versants selon l’emprise minière afin d’identifier les pressions fortes sur la ressource.],
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
        text(size: 0.71em)[Surface minière élevée = pression forte → criticité élevée],
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
#box(
  width: 100%,
  fill: rgb(255, 250, 240),
  stroke: 1.5pt + rgb("#c62828"),
  radius: 3pt,
  inset: 8pt,
  stack(dir: ttb, spacing: 0.3em,
    text(size: 0.85em, weight: "bold", fill: rgb("#c62828"))[Point de vigilance],
    stack(dir: ttb, spacing: 0.1em,
      text(size: 0.75em, weight: "bold")[Redondance (R3)],
      text(size: 0.71em)[L'Activité minière (identifiée via le MOS) peut faire doublon avec l'indicateur Terrain nu, sur-représentant ainsi la pression physique sur le sol.],
    ),
  )
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
    text(size: 0.8em, weight: "bold")[CARTOGRAPHIE – OCCUPATION DES SOLS (MOS 2014 – classes végétation)],
    text(size: 0.75em)[#text(weight: "bold")[Origine :] OEIL/GOUV],
    text(size: 0.75em)[#text(weight: "bold")[Distributeur :] GEOREP],
    text(size: 0.75em)[#text(weight: "bold")[Couverture spatiale :] Nouvelle-calédonie],
    text(size: 0.75em)[#text(weight: "bold")[Actualisation :] jamais],
    text(size: 0.75em)[#text(weight: "bold")[Disponibilité :] Disponible],
    text(size: 0.75em)[#link("https://georep-dtsi-sgt.opendata.arcgis.com/documents/b1efecab06904c9996127a3ff5bdc586/about")[🔗 Ressource]],
    text(size: 0.71em, style: "italic")[MOS 2014 (24 classes niv.3) + évolution provinces Nord et Îles Loyauté],
    text(size: 0.8em, weight: "bold")[Exploitation minière en Nouvelle-Calédonie : centres miniers et usines métallurgiques],
    text(size: 0.75em)[#text(weight: "bold")[Origine :] DIMENC],
    text(size: 0.75em)[#text(weight: "bold")[Distributeur :] GEOREP],
    text(size: 0.75em)[#text(weight: "bold")[Couverture spatiale :] Nouvelle-calédonie],
    text(size: 0.75em)[#text(weight: "bold")[Actualisation :] inconnu],
    text(size: 0.75em)[#text(weight: "bold")[Disponibilité :] Disponible],
    text(size: 0.75em)[#link("https://dtsi-sgt.maps.arcgis.com/home/item.html?id=4e485fd6879142d9b52fe1bcea0c2cb1")[🔗 Ressource]],
    text(size: 0.71em, style: "italic")[Centre minier et usine métallurgique (peut être fusionner avec les ICPE aussi ?)],
    text(size: 0.8em, weight: "bold")[cadastre minier actif (concessions, permis de recherches et réserves techniques provinciales) et échu],
    text(size: 0.75em)[#text(weight: "bold")[Origine :] DIMENC],
    text(size: 0.75em)[#text(weight: "bold")[Distributeur :] GEOREP],
    text(size: 0.75em)[#text(weight: "bold")[Couverture spatiale :] Nouvelle-calédonie],
    text(size: 0.75em)[#text(weight: "bold")[Actualisation :] inconnu],
    text(size: 0.75em)[#text(weight: "bold")[Disponibilité :] Disponible],
    text(size: 0.75em)[#link("https://dtsi-sgt.maps.arcgis.com/home/item.html?id=e70295d0f4994702ad2d64e6c4156377")[🔗 Ressource]],
    text(size: 0.71em, style: "italic")[Cadastre des exploitations minière avec statu réglementaire],
  )
)
#v(0.5em)
#pagebreak()

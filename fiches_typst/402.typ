#import "../template_typst.typ": *

#let brand = rgb("#546E7A")

#text(size: 1.6em, weight: "bold", fill: brand)[Vulnérabilité intrinsèque des eaux souterraines]
#v(0.4em)
#grid(
  columns: (1fr, auto),
  column-gutter: 10pt,
  stack(dir: ttb, spacing: 0.2em,
    text(size: 0.9em)[#text(weight: "bold")[Thème :] Vulnérabilité Intrinsèque],
    text(size: 0.9em)[#text(weight: "bold")[Famille :] Vulnérabilité],
  ),
  box(
    width: auto,
    fill: brand,
    radius: 999pt,
    inset: (x: 12pt, y: 8pt),
    text(size: 0.9em, weight: "bold", fill: white)[Fiche n°402]
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
    text(size: 1.05em)[🔬 #h(0.3em) #text(weight: "bold")[Diagnostic & Modulation]],
    text(size: 0.9em)[Définit le socle physique immuable qui module (amplifie ou réduit) l'impact des pressions.],
    badge("Groupe", "Sensibilité naturelle"),
    badge("Objectif groupe", "Qualifier la propension naturelle du terrain à laisser circuler les polluants vers les eaux souterraines ou superficielles selon ses propriétés géologiques."),
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
        text(size: 0.85em)[Comparer les bassins versants selon leur vulnérabilité intrinsèque afin d’identifier les zones les plus sensibles aux transferts.],
      ),
      stack(dir: ttb, spacing: 0.1em,
        text(size: 0.85em, weight: "bold")[Normalisation],
        text(size: 0.85em)[Déjà normalisé (1-5)],
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
      badge("Nature des données", "Qualitatif"),
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
    text(size: 0.95em, weight: "bold")[BDLISA-NC - Vulnérabilité intrinsèque des eaux souterraines (gdb)],
    text(size: 0.85em)[#text(weight: "bold")[Origine :] DIMENC],
    text(size: 0.85em)[#text(weight: "bold")[Distributeur :] GEOREP],
    text(size: 0.85em)[#text(weight: "bold")[Couverture spatiale :] Nouvelle-calédonie],
    text(size: 0.85em)[#text(weight: "bold")[Actualisation :] inconnu],
    text(size: 0.85em)[#text(weight: "bold")[Disponibilité :] Disponible],
    link("https://georep-dtsi-sgt.opendata.arcgis.com/documents/d7ab36bb69954aea882a63993428357a/about")[#text(size: 0.85em, fill: brand)[Accéder à la ressource]],
    text(size: 0.85em, style: "italic")[Base de Données des Limites Aquifères de Nouvelle-Calédonie pour la cartographie et la caractérisation hydrogéologiques des formations à l’échelle du territoire.  Cette donnée traduit la vulnérabilité, elle intègre différentes pressions et caractéristiques physiques et peut servir de synthèse pour évaluer le superficiel et le souterrain.],
  )
)
#v(0.5em)
#pagebreak()

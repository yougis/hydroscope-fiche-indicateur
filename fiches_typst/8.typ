#import "../template_typst.typ": *

#show heading.where(level: 1): it => {}
#show heading.where(level: 2): it => {}
#show heading.where(level: 3): it => {}

#let brand = rgb("#005596")

#grid(
  columns: (1fr, auto),
  column-gutter: 1cm,
  align: (left + horizon, right + horizon),
  [
    #text(size: 1.6em, weight: "bold", fill: brand)[Statut PPE]
  ],
  [
    #box(
      fill: rgb("#f1f5f9"),
      inset: (x: 10pt, y: 6pt),
      radius: 4pt,
      stroke: 1.2pt + brand,
      [
        #text(size: 0.85em, weight: "bold", fill: brand)[FICHE 8 <ind-8>]
      ]
    )
  ]
)
#v(0.5em)
#line(length: 100%, stroke: 0.5pt + rgb("#d9e2ea"))
#v(0.5em)
#stack(dir: ltr, spacing: 0.6em,
  box(
    fill: brand.lighten(90%),
    stroke: 0.5pt + brand,
    inset: (x: 6pt, y: 4pt),
    radius: 3pt,
    text(size: 0.78em, weight: "bold", fill: brand)[🎯 Pilotage]
  ),
  box(
    fill: rgb("#f1f5f9"),
    stroke: 0.5pt + rgb("#cbd5e1"),
    inset: (x: 6pt, y: 4pt),
    radius: 3pt,
    text(size: 0.75em, weight: "medium", fill: rgb("#475569"))[Sécurisation sanitaire et réglementaire]
  )
)
#v(0.6em)
#box(
  width: 100%,
  fill: rgb("#f8fafc"),
  stroke: (left: 4pt + rgb("#64748b")),
  radius: 2pt,
  inset: (x: 10pt, y: 8pt),
  stack(dir: ttb, spacing: 0.4em,
    text(size: 0.73em, style: "italic", fill: rgb("#334155"))[Statut de protection légal et spatial autour de la ressource d’eau potable.],
    1em,
    text(size: 0.71em, weight: "bold", fill: rgb("#1a365d"))[Objectif :],
    text(size: 0.71em, fill: rgb("#1a202c"))[Comparer les captages selon leur niveau de protection afin d’identifier ceux les plus exposés aux pressions.],
    0.5em,
    stack(dir: ttb, spacing: 0.1em,
      text(size: 0.71em, weight: "bold", fill: rgb("#1a365d"))[Prioritaire : oui],
    ),
  )
)
#v(0.5em)
#grid(
  columns: (1.65fr, 1fr),
  column-gutter: 10pt,
  align: (top, top),
  box(
    width: 100%,
    fill: fiche_bg,
    stroke: 0.5pt + fiche_border,
    radius: 3pt,
    inset: 8pt,
    stack(dir: ttb, spacing: 0.35em,
      text(size: 0.85em, weight: "bold")[Analyse multicritère et mesure de criticité],
      0.7em,
      stack(dir: ttb, spacing: 0.4em,
        text(size: 0.75em, weight: "bold")[Modalités de traitement],
        text(size: 0.71em)[Attribution directe au captage, sans transformation.],
      ),
      0.7em,
      stack(dir: ttb, spacing: 0.4em,
        text(size: 0.75em, weight: "bold")[Normalisation],
        text(size: 0.71em)[Catégoriel mappé \(1\-3\)],
      ),
      0.7em,
      stack(dir: ttb, spacing: 0.4em,
        text(size: 0.75em, weight: "bold")[Définition de la criticité],
        text(size: 0.71em)[Captage non protégé = forte criticité],
      ),
      0.7em,
      stack(dir: ttb, spacing: 0.4em,
        text(size: 0.75em, weight: "bold")[Sens de l'indicateur],
        text(size: 0.71em)[Valeur de classe non ordonnée et donc appliquée arbitrairement #h(0.2em) #text(fill: rgb("#555555"), size: 0.95em)[↔]],
      ),
    )
  ),
  stack(dir: ttb, spacing: 0pt,
   block(breakable: true,
      width: 100%,
      fill: fiche_bg,
      stroke: 0.5pt + fiche_border,
      radius: (top-left: 3pt, top-right: 3pt, bottom-left: 0pt, bottom-right: 0pt),
      inset: 8pt,
      stack(dir: ttb, spacing: 0.4em,
        text(size: 0.85em, weight: "bold")[Critère technique],
        v(0.4em),
        text(size: 0.72em)[#text(fill: rgb("#475569"), weight: "medium")[Unité :] Oui \/ En cours \/ Non \/ historique \(Etat\)],
        text(size: 0.72em)[#text(fill: rgb("#475569"), weight: "medium")[Support spatial :] Captage],
        text(size: 0.72em)[#text(fill: rgb("#475569"), weight: "medium")[Pondération :] Oui],
        text(size: 0.72em)[#text(fill: rgb("#475569"), weight: "medium")[Spatialisation H3 :] Non],
        text(size: 0.72em)[#text(fill: rgb("#475569"), weight: "medium")[Nature des données :] Qualitatif],
      )
    ),
v(0.7em),
    box(
      width: 100%,
      fill: fiche_bg,
      stroke: (top: 0pt, bottom: 0.5pt + fiche_border, left: 0.5pt + fiche_border, right: 0.5pt + fiche_border),
      radius: (top-left: 0pt, top-right: 0pt, bottom-left: 3pt, bottom-right: 3pt),
      inset: 8pt,
      stack(dir: ttb, spacing: 0.5em,
        text(size: 0.85em, weight: "bold")[Modalités de visualisation],
        v(0.4em),
        text(size: 0.72em)[#text(fill: rgb("#475569"), weight: "medium")[Nature des données :] Qualitatif],
        text(size: 0.72em)[#text(fill: rgb("#475569"), weight: "medium")[Discret ou continu :] Discrète],
        text(size: 0.72em)[#text(fill: rgb("#475569"), weight: "medium")[Relatif ou absolu :] Absolu],
        text(size: 0.72em)[#text(fill: rgb("#475569"), weight: "medium")[Représentation cartographique :] Couleur],
        text(size: 0.72em)[#text(fill: rgb("#475569"), weight: "medium")[Implantation :] Ponctuelle],
      )
    )
  )
)
#v(0.7em)
#text(size: 0.85em, weight: "bold")[Sources & fiabilité]
#v(0.4em)
#block(breakable: true,
  width: 100%,
  fill: fiche_bg,
  stroke: 0.5pt + rgb("#dce4eb"),
  radius: 3pt,
  inset: 8pt,
  stack(dir: ttb, spacing: 0.25em,
    text(size: 0.8em, weight: "bold")[Nom de la base de donnée : Périmètres de protection des eaux],
 0.7em,
    text(size: 0.75em)[Données administratives DAVAR],
 0.5em,
    text(size: 0.75em)[#text(weight: "bold")[Origine :] DAVAR],
 0.5em,
    text(size: 0.75em)[#text(weight: "bold")[Distributeur :] GEOREP],
 0.5em,
    text(size: 0.75em)[#text(weight: "bold")[Couverture spatiale :] Nouvelle\-calédonie],
 0.5em,
    text(size: 0.75em)[#text(weight: "bold")[Actualisation :] inconnu],
 0.5em,
    text(size: 0.75em)[#text(weight: "bold")[Type de source :] vecteur],
 0.5em,
    text(size: 0.75em)[#text(weight: "bold")[Disponibilité :] Disponible],
 0.5em,
    text(size: 0.75em)[#link("https:\/\/georep\-dtsi\-sgt.opendata.arcgis.com\/maps\/b5a303d89f2f407e8c194983c86418a7\/about")[🔗 Accès à la ressource]],
 0.5em,
    text(size: 0.75em)[#text(weight: "bold")[Contraintes :] Processus d’instruction long avec état intermédiaire.],
 0.5em,
 0.7em,
  )
)
#v(0.5em)
#pagebreak()

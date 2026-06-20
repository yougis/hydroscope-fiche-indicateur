#import "../template_typst.typ": *


#let brand = rgb("#2E7D32")

#grid(
  columns: (1fr, auto),
  column-gutter: 1cm,
  align: (left + horizon, right + horizon),
  [#text(size: 1.6em, weight: "bold", fill: brand)[Incendies cumulés]],
  [#box(fill: rgb("#f1f5f9"), inset: (x: 10pt, y: 6pt), radius: 4pt,
    stroke: 1.2pt + brand,
    [#text(size: 0.85em, weight: "bold", fill: brand)[FICHE 19 <ind-19>]]
  )],
)
#v(0.5em)
#line(length: 100%, stroke: 0.5pt + rgb("#d9e2ea"))
#v(0.5em)
#stack(dir: ltr, spacing: 0.6em,
  box(fill: brand.lighten(90%), stroke: 0.5pt + brand,
    inset: (x: 6pt, y: 4pt), radius: 3pt,
    text(size: 0.78em, weight: "bold", fill: brand)[👁 Surveiller]
  ),
  box(fill: rgb("#f1f5f9"), stroke: 0.5pt + rgb("#cbd5e1"),
    inset: (x: 6pt, y: 4pt), radius: 3pt,
    text(size: 0.75em, fill: rgb("#475569"))[Perturbations majeures du milieu \(Aléa\)]
  ),
)
#v(0.6em)
#block(
  width: 100%,
  fill: rgb("#f8fafc"),
  stroke: (left: 4pt + rgb("#64748b")),
  radius: 2pt,
  inset: (x: 10pt, y: 8pt),
  stack(dir: ttb, spacing: 0.4em,
    text(size: 0.73em, style: "italic", fill: rgb("#334155"))[Surface totale touchée par les incendies.],
    1em,
    text(size: 0.71em, weight: "bold", fill: rgb("#1a365d"))[Objectif :],
    text(size: 0.71em, fill: rgb("#1a202c"))[Comparer les bassins versants selon leur historique d’incendies afin d’identifier les milieux les perturbés.],
    0.5em,
    text(size: 0.71em, weight: "bold", fill: rgb("#1a365d"))[Prioritaire : oui],
  )
)
#v(0.5em)
#grid(
  columns: (1.65fr, 1fr),
  column-gutter: 10pt,
  align: (top, top),
  box(width: 100%, fill: fiche_bg, stroke: 0.5pt + fiche_border,
    radius: 3pt, inset: 8pt,
    stack(dir: ttb, spacing: 0.35em,
      text(size: 0.85em, weight: "bold")[Analyse multicritère et mesure de criticité],
      0.7em,
      stack(dir: ttb, spacing: 0.4em,
        text(size: 0.75em, weight: "bold")[Modalités de traitement],
        text(size: 0.71em)[Cumul des surfaces brûlées sur une année et agrégation par bassin versant.],
      ),
      0.7em,
      stack(dir: ttb, spacing: 0.4em,
        text(size: 0.75em, weight: "bold")[Normalisation],
        text(size: 0.71em)[Classes 3 niveaux],
      ),
      0.7em,
      stack(dir: ttb, spacing: 0.4em,
        text(size: 0.75em, weight: "bold")[Définition de la criticité],
        text(size: 0.71em)[Forte surface brûlée = forte pression → criticité élevée],
      ),
      0.7em,
      stack(dir: ttb, spacing: 0.4em,
        text(size: 0.75em, weight: "bold")[Sens de l\'indicateur],
        text(size: 0.71em)[Négatif \(plus = critique\) #h(0.2em) #text(fill: rgb("#c62828"), size: 0.95em)[↓]],
      ),
    )
  ),
  stack(dir: ttb, spacing: 0pt,
    block(breakable: true, width: 100%, fill: fiche_bg,
      stroke: 0.5pt + fiche_border,
      radius: (top-left: 3pt, top-right: 3pt, bottom-left: 0pt, bottom-right: 0pt),
      inset: 8pt,
      stack(dir: ttb, spacing: 0.4em,
        text(size: 0.85em, weight: "bold")[Critère technique], v(0.4em),
        text(size: 0.72em)[#text(fill: rgb("#475569"), weight: "medium")[Unité :] ha],
        text(size: 0.72em)[#text(fill: rgb("#475569"), weight: "medium")[Support spatial :] maille],
        text(size: 0.72em)[#text(fill: rgb("#475569"), weight: "medium")[Pondération :] Oui],
        text(size: 0.72em)[#text(fill: rgb("#475569"), weight: "medium")[Spatialisation H3 :] Oui],
        text(size: 0.72em)[#text(fill: rgb("#475569"), weight: "medium")[Nature des données :] Quantitatif],
      )
    ),
    v(0.7em),
    box(width: 100%, fill: fiche_bg,
      stroke: (top: 0pt, bottom: 0.5pt + fiche_border, left: 0.5pt + fiche_border, right: 0.5pt + fiche_border),
      radius: (top-left: 0pt, top-right: 0pt, bottom-left: 3pt, bottom-right: 3pt),
      inset: 8pt,
      stack(dir: ttb, spacing: 0.5em,
        text(size: 0.85em, weight: "bold")[Modalités de visualisation], v(0.4em),
        text(size: 0.72em)[#text(fill: rgb("#475569"), weight: "medium")[Nature des données :] Quantitatif],
        text(size: 0.72em)[#text(fill: rgb("#475569"), weight: "medium")[Discret ou continu :] Continue],
        text(size: 0.72em)[#text(fill: rgb("#475569"), weight: "medium")[Relatif ou absolu :] Absolu],
        text(size: 0.72em)[#text(fill: rgb("#475569"), weight: "medium")[Représentation cartographique :] Carte choroplèthe],
        text(size: 0.72em)[#text(fill: rgb("#475569"), weight: "medium")[Implantation :] Zonal],
      )
    ),
  ),
)
#v(0.7em)
#text(size: 0.85em, weight: "bold")[Sources & fiabilité]
#v(0.4em)
#block(breakable: true, width: 100%, fill: fiche_bg,
  stroke: 0.5pt + rgb("#dce4eb"), radius: 3pt, inset: 8pt,
  stack(dir: ttb, spacing: 0.25em,
    text(size: 0.8em, weight: "bold")[Zones potentiellement brulées \(VIIRS\)],
    0.7em,
    text(size: 0.75em)[#text(weight: "bold")[Description :] Surfaces potentiellement brûlées VIIRS depuis 2012. Il n’existe pas de source officielle qui fusionne les 2 capteurs VIIRS \(SUOMI et JPSS\)],
    0.5em,
    text(size: 0.75em)[#text(weight: "bold")[Origine :] OEIL],
    0.5em,
    text(size: 0.75em)[#text(weight: "bold")[Distributeur :] OEIL],
    0.5em,
    text(size: 0.75em)[#text(weight: "bold")[Couverture spatiale :] Nouvelle\-calédonie],
    0.5em,
    text(size: 0.75em)[#text(weight: "bold")[Actualisation :] Tous les jours],
    0.5em,
    text(size: 0.75em)[#text(weight: "bold")[Type de source :] vecteur],
    0.5em,
    text(size: 0.75em)[#text(weight: "bold")[Disponibilité :] Disponible],
    0.5em,
    text(size: 0.75em)[#text(weight: "bold")[Contraintes :] Résolution des données variable selon les capteurs, pouvant affecter la précision.],
    0.5em,
    text(size: 0.75em)[#link("https:\/\/geoportail.oeil.nc\/geoportal\/catalog\/search\/resource\/details.page\?uuid=%7B5D28AFE1\-541C\-4102\-84F0\-6959F769FA78%7D")[🔗 Accès à la ressource]],
    0.5em,
    0.7em,
  )
)
#v(0.5em)
#pagebreak()

#import "../template_typst.typ": *

#show heading.where(level: 1): it => {}
#show heading.where(level: 2): it => {}
#show heading.where(level: 3): it => {}

#let brand = rgb("3bc29f")

#grid(
  columns: (1fr, auto),
  column-gutter: 1cm,
  align: (left + horizon, right + horizon),
  [
    #text(size: 1.6em, weight: "bold", fill: brand)[Zones protégées provinciales]
  ],
  [
    #box(
      fill: rgb("#f1f5f9"),
      inset: (x: 10pt, y: 6pt),
      radius: 4pt,
      stroke: 1.2pt + brand,
      [
        #text(size: 0.85em, weight: "bold", fill: brand)[FICHE 16 <ind-16>]
      ]
    )
  ]
)
#v(0.5em)
#line(length: 100%, stroke: 0.5pt + rgb("#d9e2ea"))
#v(0.5em)
#stack(dir: ltr, spacing: 0.6em,
  box(
  ),
  box(
    fill: rgb("#f1f5f9"),
    stroke: 0.5pt + rgb("#cbd5e1"),
    inset: (x: 6pt, y: 4pt),
    radius: 3pt,
    text(size: 0.75em, weight: "medium", fill: rgb("#475569"))[Zones protégés]
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
    text(size: 0.73em, style: "italic", fill: rgb("#334155"))[Mesure la superficie des intersections avec les parcs et réserves provinciales en Nouvelle\-Calédonie. La donnée compile les fichiers des Aires Protégées produits par les trois provinces \(Sud, Nord, Îles\) pour identifier les périmètres de conservation du milieu naturel.],
    1em,
    text(size: 0.71em, weight: "bold", fill: rgb("#1a365d"))[Objectif :],
    text(size: 0.71em, fill: rgb("#1a202c"))[Informer sur la présence de zones protégées provinciales afin de caractériser le niveau de protection environnementale du bassin versant ainsi que les opportunités de gestion et de financement associées.],
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
    1em,
    text(size: 0.71em, weight: "bold", fill: rgb("#1a365d"))[Objectif de l'indicateur dans l'analyse:],
    text(size: 0.71em, fill: rgb("#1a202c"))[Évaluer l’effet des dispositifs de protection réglementaire sur la préservation de la ressource en eau et sur le potentiel de mobilisation de financements, une forte présence contribuant à réduire la criticité liée aux pressions et à renforcer l’intérêt stratégique du territoire.],
      0.7em,
      stack(dir: ttb, spacing: 0.4em,
        text(size: 0.75em, weight: "bold")[Modalités de traitement],
        text(size: 0.71em)[Calcul surfacique par unité spatiale régulière puis agrégation au bassin versant.],
      ),
      0.7em,
      stack(dir: ttb, spacing: 0.4em,
        text(size: 0.75em, weight: "bold")[Normalisation],
        text(size: 0.71em)[Classes 3 niveaux],
      ),
      0.7em,
      stack(dir: ttb, spacing: 0.4em,
        text(size: 0.75em, weight: "bold")[Définition de la criticité],
        text(size: 0.71em)[Présence en zone protégée = criticité faible bien que  enjeu fort],
      ),
      0.7em,
      stack(dir: ttb, spacing: 0.4em,
        text(size: 0.75em, weight: "bold")[Sens de l'indicateur],
        text(size: 0.71em)[Positif \(absence = critique \/ plus = mieux\) #h(0.2em) #text(fill: rgb("#2e7d32"), size: 0.95em)[↑]],
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
        text(size: 0.72em)[#text(fill: rgb("#475569"), weight: "medium")[Unité :] ha],
        text(size: 0.72em)[#text(fill: rgb("#475569"), weight: "medium")[Support spatial :] maille],
        text(size: 0.72em)[#text(fill: rgb("#475569"), weight: "medium")[Spatialisation H3 :] Oui],
        text(size: 0.72em)[#text(fill: rgb("#475569"), weight: "medium")[Nature des données :] Quantitatif],
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
        text(size: 0.72em)[#text(fill: rgb("#475569"), weight: "medium")[Nature des données :] Quantitatif],
        text(size: 0.72em)[#text(fill: rgb("#475569"), weight: "medium")[Discret ou continu :] Continue],
        text(size: 0.72em)[#text(fill: rgb("#475569"), weight: "medium")[Relatif ou absolu :] Absolu],
        text(size: 0.72em)[#text(fill: rgb("#475569"), weight: "medium")[Représentation cartographique :] Carte choroplèthe],
        text(size: 0.72em)[#text(fill: rgb("#475569"), weight: "medium")[Implantation :] Zonal],
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
    text(size: 0.8em, weight: "bold")[Nom de la base de donnée : Aires protégées de la Province Sud],
 0.7em,
    text(size: 0.75em)[Aires terrestres protégées à compiler depuis les sources des 3 provinces],
 0.5em,
    text(size: 0.75em)[#text(weight: "bold")[Origine :] PSUD],
 0.5em,
    text(size: 0.75em)[#text(weight: "bold")[Distributeur :] PSUD],
 0.5em,
    text(size: 0.75em)[#text(weight: "bold")[Couverture spatiale :] Province Sud],
 0.5em,
    text(size: 0.75em)[#text(weight: "bold")[Actualisation :] inconnu],
 0.5em,
    text(size: 0.75em)[#text(weight: "bold")[Type de source :] vecteur],
 0.5em,
    text(size: 0.75em)[#text(weight: "bold")[Disponibilité :] Disponible],
 0.5em,
    text(size: 0.75em)[#link("https:\/\/www.province\-sud.nc\/open\/metadonnees\/8a8186dd9816d2da019c8d998c7700a0")[🔗 Accès à la ressource]],
 0.5em,
    text(size: 0.75em)[#text(weight: "bold")[Contraintes :] Hétérogénéité des périmètres selon les provinces.],
 0.5em,
 0.7em,
    text(size: 0.8em, weight: "bold")[Nom de la base de donnée : Aires protégées de la Province Nord],
 0.7em,
    text(size: 0.75em)[Aires terrestres protégées à compiler depuis les sources des 3 provinces],
 0.5em,
    text(size: 0.75em)[#text(weight: "bold")[Origine :] PNORD],
 0.5em,
    text(size: 0.75em)[#text(weight: "bold")[Distributeur :] PNORD],
 0.5em,
    text(size: 0.75em)[#text(weight: "bold")[Couverture spatiale :] Province Nord],
 0.5em,
    text(size: 0.75em)[#text(weight: "bold")[Actualisation :] inconnu],
 0.5em,
    text(size: 0.75em)[#text(weight: "bold")[Type de source :] vecteur],
 0.5em,
    text(size: 0.75em)[#text(weight: "bold")[Disponibilité :] Disponible],
 0.5em,
    text(size: 0.75em)[#text(weight: "bold")[Contraintes :] Hétérogénéité des périmètres selon les provinces.],
 0.5em,
 0.7em,
    text(size: 0.8em, weight: "bold")[Nom de la base de donnée : Aires protégées de la Province des Iles],
 0.7em,
    text(size: 0.75em)[Aires terrestres protégées à compiler depuis les sources des 3 provinces],
 0.5em,
    text(size: 0.75em)[#text(weight: "bold")[Origine :] PIL],
 0.5em,
    text(size: 0.75em)[#text(weight: "bold")[Distributeur :] PIL],
 0.5em,
    text(size: 0.75em)[#text(weight: "bold")[Couverture spatiale :] Province des Iles],
 0.5em,
    text(size: 0.75em)[#text(weight: "bold")[Actualisation :] inconnu],
 0.5em,
    text(size: 0.75em)[#text(weight: "bold")[Type de source :] vecteur],
 0.5em,
    text(size: 0.75em)[#text(weight: "bold")[Disponibilité :] A vérifier],
 0.5em,
    text(size: 0.75em)[#text(weight: "bold")[Contraintes :] Hétérogénéité des périmètres selon les provinces.],
 0.5em,
 0.7em,
  )
)
#v(0.5em)
#pagebreak()

#import "../template_typst.typ": *


#let brand = rgb("#005596")

#grid(
  columns: (1fr, auto),
  column-gutter: 1cm,
  align: (left + horizon, right + horizon),
  [#text(size: 1.6em, weight: "bold", fill: brand)[Qualité eau]],
  [#box(fill: rgb("#f1f5f9"), inset: (x: 10pt, y: 6pt), radius: 4pt,
    stroke: 1.2pt + brand,
    [#text(size: 0.85em, weight: "bold", fill: brand)[FICHE 38 <ind-38>]]
  )],
)
#v(0.5em)
#line(length: 100%, stroke: 0.5pt + rgb("#d9e2ea"))
#v(0.5em)
#stack(dir: ltr, spacing: 0.6em,
  box(fill: brand.lighten(90%), stroke: 0.5pt + brand,
    inset: (x: 6pt, y: 4pt), radius: 3pt,
    text(size: 0.78em, weight: "bold", fill: brand)[🎯 Agir]
  ),
  box(fill: rgb("#f1f5f9"), stroke: 0.5pt + rgb("#cbd5e1"),
    inset: (x: 6pt, y: 4pt), radius: 3pt,
    text(size: 0.75em, fill: rgb("#475569"))[État sanitaire et suivi de la qualité]
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
    text(size: 0.73em, style: "italic", fill: rgb("#334155"))[Qualité de l’eau \(bonne à mauvaise\).],
    1em,
    text(size: 0.71em, weight: "bold", fill: rgb("#1a365d"))[Objectif :],
    text(size: 0.71em, fill: rgb("#1a202c"))[Comparer les captages selon leur qualité afin d’identifier ceux nécessitant des actions de gestion ou de protection.],
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
        text(size: 0.71em)[Attribution d’une classe par captage selon les données disponibles.],
      ),
      0.7em,
      stack(dir: ttb, spacing: 0.4em,
        text(size: 0.75em, weight: "bold")[Normalisation],
        text(size: 0.71em)[Catégoriel mappé \(1\-3\)],
      ),
      0.7em,
      stack(dir: ttb, spacing: 0.4em,
        text(size: 0.75em, weight: "bold")[Définition de la criticité],
        text(size: 0.71em)[Classe dégradée = criticité élevée],
      ),
      0.7em,
      stack(dir: ttb, spacing: 0.4em,
        text(size: 0.75em, weight: "bold")[Sens de l\'indicateur],
        text(size: 0.71em)[Positif \(valeur ordonnée si valeur haute = mieux\) #h(0.2em) #text(fill: rgb("#2e7d32"), size: 0.95em)[↑]],
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
        text(size: 0.72em)[#text(fill: rgb("#475569"), weight: "medium")[Unité :] Classe \(A1 \/ A2 \/ A3\)],
        text(size: 0.72em)[#text(fill: rgb("#475569"), weight: "medium")[Support spatial :] Captage],
        text(size: 0.72em)[#text(fill: rgb("#475569"), weight: "medium")[Pondération :] Oui],
        text(size: 0.72em)[#text(fill: rgb("#475569"), weight: "medium")[Spatialisation H3 :] Non],
        text(size: 0.72em)[#text(fill: rgb("#475569"), weight: "medium")[Nature des données :] Qualitatif],
      )
    ),
    v(0.7em),
    box(width: 100%, fill: fiche_bg,
      stroke: (top: 0pt, bottom: 0.5pt + fiche_border, left: 0.5pt + fiche_border, right: 0.5pt + fiche_border),
      radius: (top-left: 0pt, top-right: 0pt, bottom-left: 3pt, bottom-right: 3pt),
      inset: 8pt,
      stack(dir: ttb, spacing: 0.5em,
        text(size: 0.85em, weight: "bold")[Modalités de visualisation], v(0.4em),
        text(size: 0.72em)[#text(fill: rgb("#475569"), weight: "medium")[Nature des données :] Qualitatif],
        text(size: 0.72em)[#text(fill: rgb("#475569"), weight: "medium")[Discret ou continu :] Discrète],
        text(size: 0.72em)[#text(fill: rgb("#475569"), weight: "medium")[Relatif ou absolu :] Absolu],
        text(size: 0.72em)[#text(fill: rgb("#475569"), weight: "medium")[Représentation cartographique :] Couleur],
        text(size: 0.72em)[#text(fill: rgb("#475569"), weight: "medium")[Implantation :] Ponctuelle],
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
    text(size: 0.8em, weight: "bold")[Base de données ATYA],
    0.7em,
    text(size: 0.75em)[#text(weight: "bold")[Description :] Données DASS\/ATYA diffusion interne – contacter DASS],
    0.5em,
    text(size: 0.75em)[#text(weight: "bold")[Origine :] DAVAR],
    0.5em,
    text(size: 0.75em)[#text(weight: "bold")[Actualisation :] inconnu],
    0.5em,
    text(size: 0.75em)[#text(weight: "bold")[Type de source :] inconnu],
    0.5em,
    text(size: 0.75em)[#text(weight: "bold")[Disponibilité :] Interne],
    0.5em,
    text(size: 0.75em)[#text(weight: "bold")[Contraintes :] Disponibilité limitée et complexité d’interprétation des données.],
    0.5em,
    0.7em,
  )
)
#v(0.5em)
#pagebreak()

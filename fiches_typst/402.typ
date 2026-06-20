#import "../template_typst.typ": *


#let brand = rgb("#546E7A")

#grid(
  columns: (1fr, auto),
  column-gutter: 1cm,
  align: (left + horizon, right + horizon),
  [#text(size: 1.6em, weight: "bold", fill: brand)[Vulnérabilité intrinsèque des eaux souterraines]],
  [#box(fill: rgb("#f1f5f9"), inset: (x: 10pt, y: 6pt), radius: 4pt,
    stroke: 1.2pt + brand,
    [#text(size: 0.85em, weight: "bold", fill: brand)[FICHE 32 <ind-32>]]
  )],
)
#v(0.5em)
#line(length: 100%, stroke: 0.5pt + rgb("#d9e2ea"))
#v(0.5em)
#stack(dir: ltr, spacing: 0.6em,
  box(fill: brand.lighten(90%), stroke: 0.5pt + brand,
    inset: (x: 6pt, y: 4pt), radius: 3pt,
    text(size: 0.78em, weight: "bold", fill: brand)[🔬 Comprendre]
  ),
  box(fill: rgb("#f1f5f9"), stroke: 0.5pt + rgb("#cbd5e1"),
    inset: (x: 6pt, y: 4pt), radius: 3pt,
    text(size: 0.75em, fill: rgb("#475569"))[Sensibilité naturelle]
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
    text(size: 0.73em, style: "italic", fill: rgb("#334155"))[Niveau de sensibilité naturelle du terrain à laisser passer l’eau.],
    1em,
    text(size: 0.71em, weight: "bold", fill: rgb("#1a365d"))[Objectif :],
    text(size: 0.71em, fill: rgb("#1a202c"))[Comparer les bassins versants selon leur vulnérabilité intrinsèque afin d’identifier les zones les plus sensibles aux transferts.],
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
        text(size: 0.71em)[Étude à réaliser pour définir les modalités de production de l’indicateur],
      ),
      0.7em,
      stack(dir: ttb, spacing: 0.4em,
        text(size: 0.75em, weight: "bold")[Normalisation],
        text(size: 0.71em)[Déjà normalisé \(1\-5\)],
      ),
      0.7em,
      stack(dir: ttb, spacing: 0.4em,
        text(size: 0.75em, weight: "bold")[Définition de la criticité],
        text(size: 0.71em)[Sols infiltrant = moins critique, ruisselants = plus critique],
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
        text(size: 0.72em)[#text(fill: rgb("#475569"), weight: "medium")[Unité :] Indice \(1 à 5\)],
        text(size: 0.72em)[#text(fill: rgb("#475569"), weight: "medium")[Support spatial :] maille],
        text(size: 0.72em)[#text(fill: rgb("#475569"), weight: "medium")[Pondération :] Oui],
        text(size: 0.72em)[#text(fill: rgb("#475569"), weight: "medium")[Spatialisation H3 :] Oui],
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
    text(size: 0.8em, weight: "bold")[BDLISA\-NC \- Vulnérabilité intrinsèque des eaux souterraines \(gdb\)],
    0.7em,
    text(size: 0.75em)[#text(weight: "bold")[Description :] Base de Données des Limites Aquifères de Nouvelle\-Calédonie pour la cartographie et la caractérisation hydrogéologiques des formations à l’échelle du territoire.  Cette donnée traduit la vulnérabilité, elle intègre différentes pressions et caractéristiques physiques et peut servir de synthèse pour évaluer le superficiel et le souterrain.],
    0.5em,
    text(size: 0.75em)[#text(weight: "bold")[Origine :] DIMENC],
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
    text(size: 0.75em)[#text(weight: "bold")[Contraintes :] Selon le rapport de production la donnée intègre certaines pressions \(MOS\). Voir avec la DIMENC pour confirmer.],
    0.5em,
    text(size: 0.75em)[#link("https:\/\/georep\-dtsi\-sgt.opendata.arcgis.com\/documents\/d7ab36bb69954aea882a63993428357a\/about")[🔗 Accès à la ressource]],
    0.5em,
    0.7em,
  )
)
#v(0.5em)
#pagebreak()

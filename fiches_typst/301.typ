#import "../template_typst.typ": *


#let brand = rgb("#005596")

#grid(
  columns: (1fr, auto),
  column-gutter: 1cm,
  align: (left + horizon, right + horizon),
  [#text(size: 1.6em, weight: "bold", fill: brand)[Activité minière]],
  [#box(fill: rgb("#f1f5f9"), inset: (x: 10pt, y: 6pt), radius: 4pt,
    stroke: 1.2pt + brand,
    [#text(size: 0.85em, weight: "bold", fill: brand)[FICHE 25 <ind-25>]]
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
    text(size: 0.75em, fill: rgb("#475569"))[Activités à risque]
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
    text(size: 0.73em, style: "italic", fill: rgb("#334155"))[Surface occupée par les activités minières.],
    1em,
    text(size: 0.71em, weight: "bold", fill: rgb("#1a365d"))[Objectif :],
    text(size: 0.71em, fill: rgb("#1a202c"))[Comparer les bassins versants selon l’emprise minière afin d’identifier les pressions fortes sur la ressource.],
    0.5em,
    text(size: 0.71em, weight: "bold", fill: rgb("#1a365d"))[Prioritaire : non],
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
        text(size: 0.71em)[Calcul des surfaces d’emprise puis agrégation par bassin versant.],
      ),
      0.7em,
      stack(dir: ttb, spacing: 0.4em,
        text(size: 0.75em, weight: "bold")[Normalisation],
        text(size: 0.71em)[Classes 3 niveaux],
      ),
      0.7em,
      stack(dir: ttb, spacing: 0.4em,
        text(size: 0.75em, weight: "bold")[Définition de la criticité],
        text(size: 0.71em)[Surface minière élevée = pression forte → criticité élevée],
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
#block(
  width: 100%,
  fill: rgb(255, 250, 240),
  stroke: 1.5pt + rgb("#c62828"),
  radius: 3pt,
  inset: 8pt,
  stack(dir: ttb, spacing: 0.3em,
    text(size: 0.85em, weight: "bold", fill: rgb("#c62828"))[Point de vigilance],
    0.7em,
    stack(dir: ttb, spacing: 0.1em,
      text(size: 0.75em, weight: "bold")[Redondance],
      text(size: 0.71em)[L'Activité minière \(identifiée via le MOS\) peut faire doublon avec l'indicateur Terrain nu, sur\-représentant ainsi la pression physique sur le sol.],
    ),
  )
)
#v(0.7em)
#text(size: 0.85em, weight: "bold")[Sources & fiabilité]
#v(0.4em)
#block(breakable: true, width: 100%, fill: fiche_bg,
  stroke: 0.5pt + rgb("#dce4eb"), radius: 3pt, inset: 8pt,
  stack(dir: ttb, spacing: 0.25em,
    text(size: 0.8em, weight: "bold")[CARTOGRAPHIE – OCCUPATION DES SOLS \(MOS 2014 – classes végétation\)],
    0.7em,
    text(size: 0.75em)[#text(weight: "bold")[Description :] MOS 2014 \(24 classes niv.3\) + évolution provinces Nord et Îles Loyauté],
    0.5em,
    text(size: 0.75em)[#text(weight: "bold")[Origine :] OEIL\/GOUV],
    0.5em,
    text(size: 0.75em)[#text(weight: "bold")[Distributeur :] GEOREP],
    0.5em,
    text(size: 0.75em)[#text(weight: "bold")[Couverture spatiale :] Nouvelle\-calédonie],
    0.5em,
    text(size: 0.75em)[#text(weight: "bold")[Actualisation :] ponctuelle],
    0.5em,
    text(size: 0.75em)[#text(weight: "bold")[Type de source :] vecteur],
    0.5em,
    text(size: 0.75em)[#text(weight: "bold")[Disponibilité :] Disponible],
    0.5em,
    text(size: 0.75em)[#text(weight: "bold")[Contraintes :] Résolution et nomenclature variables selon les millésimes, limitant la comparabilité temporelle. L'indicateur repose sur une source unique \(MOS\) nécessitant une validation de la qualité et de la mise à jour ; l'accès aux données peut être limité selon les usages \(données sensibles\).],
    0.5em,
    text(size: 0.75em)[#link("https:\/\/georep\-dtsi\-sgt.opendata.arcgis.com\/documents\/b1efecab06904c9996127a3ff5bdc586\/about")[🔗 Accès à la ressource]],
    0.5em,
    0.7em,
    text(size: 0.8em, weight: "bold")[Exploitation minière en Nouvelle\-Calédonie : centres miniers et usines métallurgiques],
    0.7em,
    text(size: 0.75em)[#text(weight: "bold")[Description :] Centre minier et usine métallurgique \(peut être fusionner avec les ICPE aussi \?\)],
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
    text(size: 0.75em)[#text(weight: "bold")[Contraintes :] Accès aux données limité \(données sensibles ou non publiques\).],
    0.5em,
    text(size: 0.75em)[#link("https:\/\/dtsi\-sgt.maps.arcgis.com\/home\/item.html\?id=4e485fd6879142d9b52fe1bcea0c2cb1")[🔗 Accès à la ressource]],
    0.5em,
    0.7em,
  )
)
#v(0.5em)
#pagebreak()

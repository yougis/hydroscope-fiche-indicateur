#import "../template_typst.typ": *

#show heading.where(level: 1): it => {}
#show heading.where(level: 2): it => {}
#show heading.where(level: 3): it => {}

#let brand = rgb("4472C4")

#grid(
  columns: (1fr, auto),
  column-gutter: 1cm,
  align: (left + horizon, right + horizon),
  [
    #text(size: 1.6em, weight: "bold", fill: brand)[Statut captage]
  ],
  [
    #box(
      fill: rgb("#f1f5f9"),
      inset: (x: 10pt, y: 6pt),
      radius: 4pt,
      stroke: 1.2pt + brand,
      [
        #text(size: 0.85em, weight: "bold", fill: brand)[FICHE 3 <ind-3>]
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
    text(size: 0.75em, weight: "medium", fill: rgb("#475569"))[Importance captage]
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
    text(size: 0.73em, style: "italic", fill: rgb("#334155"))[Établit s'il s'agit d'une ressource principale \(actif\), d'une ressource utilisée occasionnellement \(secours\) ou d'une ressource abandonnée. Cette donnée mobilise la ressource \"Captages d'eau\" produite par la DAVAR décrivant l'état d'utilisation opérationnelle de chaque point d'eau.],
    1em,
    text(size: 0.71em, weight: "bold", fill: rgb("#1a365d"))[Objectif :],
    text(size: 0.71em, fill: rgb("#1a202c"))[Informer sur le rôle opérationnel du captage \(actif, secours, abandonné\) afin de contextualiser son utilisation.],
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
    text(size: 0.71em, fill: rgb("#1a202c"))[Évaluer l’importance fonctionnelle du captage dans le système d’alimentation en eau, un captage principal augmentant la criticité.],
      0.7em,
      stack(dir: ttb, spacing: 0.4em,
        text(size: 0.75em, weight: "bold")[Modalités de traitement],
        text(size: 0.71em)[Attribution directe au captage, sans transformation. Utilisation à titre informatif],
      ),
      0.7em,
      stack(dir: ttb, spacing: 0.4em,
        text(size: 0.75em, weight: "bold")[Normalisation],
        text(size: 0.71em)[Catégoriel mappé \(1\-3\)],
      ),
      0.7em,
      stack(dir: ttb, spacing: 0.4em,
        text(size: 0.75em, weight: "bold")[Définition de la criticité],
        text(size: 0.71em)[Captage actif = enjeu, secours\/inactif = criticité moindre],
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
        text(size: 0.72em)[#text(fill: rgb("#475569"), weight: "medium")[Unité :] Classe \(actif, secours, inactif, abandonné\).],
        text(size: 0.72em)[#text(fill: rgb("#475569"), weight: "medium")[Support spatial :] Captage],
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
        text(size: 0.72em)[#text(fill: rgb("#475569"), weight: "medium")[Représentation cartographique :] Texte],
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
    text(size: 0.8em, weight: "bold")[Nom de la base de donnée : Captages d'eau],
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
    text(size: 0.75em)[#link("https:\/\/georep\-dtsi\-sgt.opendata.arcgis.com\/maps\/89e23d7a430b4e49b67fbd6f8a79bb7b\/about")[🔗 Accès à la ressource]],
 0.5em,
    text(size: 0.75em)[#text(weight: "bold")[Contraintes :] Les typologies de captages doivent être standardisées pour assurer une comparaison cohérente ; certaines informations sont descriptives et susceptibles d'évoluer sans impact direct sur la criticité. Verifier que la données est bien à jour du GEOREP.],
 0.5em,
 0.7em,
  )
)
#v(0.5em)
#pagebreak()

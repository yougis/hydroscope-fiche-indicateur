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
    #text(size: 1.6em, weight: "bold", fill: brand)[ICPE]
  ],
  [
    #box(
      fill: rgb("#f1f5f9"),
      inset: (x: 10pt, y: 6pt),
      radius: 4pt,
      stroke: 1.2pt + brand,
      [
        #text(size: 0.85em, weight: "bold", fill: brand)[FICHE 24 <ind-24>]
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
    text(size: 0.75em, weight: "medium", fill: rgb("#475569"))[Activités à risque]
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
    text(size: 0.73em, style: "italic", fill: rgb("#334155"))[Nombre de sites industriels à risque.],
    1em,
    text(size: 0.71em, weight: "bold", fill: rgb("#1a365d"))[Objectif :],
    text(size: 0.71em, fill: rgb("#1a202c"))[Comparer les bassins versants selon la densité d’activités à risque afin d’identifier les sources potentielles de pollution.],
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
        text(size: 0.71em)[Comptage des installations par unité spatiale avec possibilité de typologie.],
      ),
      0.7em,
      stack(dir: ttb, spacing: 0.4em,
        text(size: 0.75em, weight: "bold")[Normalisation],
        text(size: 0.71em)[Classes 3 niveaux],
      ),
      0.7em,
      stack(dir: ttb, spacing: 0.4em,
        text(size: 0.75em, weight: "bold")[Définition de la criticité],
        text(size: 0.71em)[Plus d’ICPE = risque pollution → criticité élevée],
      ),
      0.7em,
      stack(dir: ttb, spacing: 0.4em,
        text(size: 0.75em, weight: "bold")[Sens de l'indicateur],
        text(size: 0.71em)[Négatif (plus = critique) #h(0.2em) #text(fill: rgb("#c62828"), size: 0.95em)[↓]],
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
        text(size: 0.72em)[#text(fill: rgb("#475569"), weight: "medium")[Unité :] Nombre],
        text(size: 0.72em)[#text(fill: rgb("#475569"), weight: "medium")[Support spatial :] maille],
        text(size: 0.72em)[#text(fill: rgb("#475569"), weight: "medium")[Pondération :] Oui],
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
        text(size: 0.72em)[#text(fill: rgb("#475569"), weight: "medium")[Discret ou continu :] Discrète],
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
    text(size: 0.8em, weight: "bold")[Nom de la base de donnée : Installations Classées pour la Protection de l'Environnement de la Province Sud],
 0.7em,
    text(size: 0.75em)[Une Installation Classée pour la Protection de l’Environnement (ICPE) est une activité fixe à caractère industriel ou agricole susceptible de provoquer des pollutions, des nuisances ou des risques, notamment pour la sécurité, la santé des riverains et/ou l’environnement.],
 0.5em,
    text(size: 0.75em)[#text(weight: "bold")[Origine :] PSUD],
 0.5em,
    text(size: 0.75em)[#text(weight: "bold")[Distributeur :] PSUD],
 0.5em,
    text(size: 0.75em)[#text(weight: "bold")[Couverture spatiale :] Province Sud],
 0.5em,
    text(size: 0.75em)[#text(weight: "bold")[Actualisation :] Quotidienne],
 0.5em,
    text(size: 0.75em)[#text(weight: "bold")[Type de source :] vecteur],
 0.5em,
    text(size: 0.75em)[#text(weight: "bold")[Disponibilité :] Disponible],
 0.5em,
    text(size: 0.75em)[#link("https://www.province-sud.nc/open/metadonnees/8a8186dd9816d2da019c8d998c7d00a5")[🔗 Accès à la ressource]],
 0.5em,
    text(size: 0.75em)[#text(weight: "bold")[Contraintes :] Données dispersées entre plusieurs acteurs, absence de base consolidée et typologie homogène.],
 0.5em,
 0.7em,
    text(size: 0.8em, weight: "bold")[Nom de la base de donnée : Installations Classées pour la Protection de l'Environnement de la Province Nord],
 0.7em,
    text(size: 0.75em)[Une Installation Classée pour la Protection de l’Environnement (ICPE) est une activité fixe à caractère industriel ou agricole susceptible de provoquer des pollutions, des nuisances ou des risques, notamment pour la sécurité, la santé des riverains et/ou l’environnement.],
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
    text(size: 0.75em)[#text(weight: "bold")[Disponibilité :] A vérifier],
 0.5em,
    text(size: 0.75em)[#text(weight: "bold")[Contraintes :] Données dispersées entre plusieurs acteurs, absence de base consolidée et typologie homogène.],
 0.5em,
 0.7em,
    text(size: 0.8em, weight: "bold")[Nom de la base de donnée : Installations Classées pour la Protection de l'Environnement de la Province des Iles],
 0.7em,
    text(size: 0.75em)[Une Installation Classée pour la Protection de l’Environnement (ICPE) est une activité fixe à caractère industriel ou agricole susceptible de provoquer des pollutions, des nuisances ou des risques, notamment pour la sécurité, la santé des riverains et/ou l’environnement.],
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
    text(size: 0.75em)[#text(weight: "bold")[Contraintes :] Données dispersées entre plusieurs acteurs, absence de base consolidée et typologie homogène.],
 0.5em,
 0.7em,
  )
)
#v(0.5em)
#pagebreak()

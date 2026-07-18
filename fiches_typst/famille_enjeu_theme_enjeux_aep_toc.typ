#import "../template_typst.typ": *

// ─── TOC THÈME : Enjeux AEP ───────────────────────────────
#block(width: 100%, fill: rgb("2b5e8c"), radius: 4pt, inset: (x: 14pt, y: 12pt),
  text(size: 1.2em, weight: "bold", fill: white)[Enjeux AEP]
)
#block(
  width: 100%,
  inset: (x: 2pt, top: 6pt, bottom: 4pt),
  grid(
    columns: 1,
    row-gutter: 4pt,
    text(size: 0.82em, style: "italic", fill: rgb("#475569"))[Caractérise l’importance stratégique des ressources en eau potable en termes de disponibilité, de capacité et de résilience technique et réglementaire pour l’alimentation de la population.],
  )
)
#v(0.8em)
#block(
  width: 100%,
  stroke: (left: 5pt + rgb("4472C4")),
  fill: luma(252),
  radius: (right: 6pt),
  inset: (left: 12pt, right: 10pt, top: 8pt, bottom: 8pt),
  grid(
    columns: (1fr, auto),
    column-gutter: 8pt,
    align: horizon,
    grid(
      columns: 1,
      row-gutter: 3pt,
      text(size: 1em, weight: "bold")[Importance captage],
      text(size: 0.85em, fill: rgb("#333333"))[Évaluer la capacité du système AEP à assurer la continuité du service \(production, stockage, interconnexion\)],
    ),
  )
)
#v(0.4em)
#block(
  width: 100%,
  inset: (left: 17pt),
  grid(
    columns: (40pt, 1fr),
    row-gutter: 4pt,
    column-gutter: 6pt,
    text(size: 0.78em, weight: "bold", fill: rgb("4472C4"))[Fiche n°],
    text(size: 0.78em, weight: "bold", fill: rgb("4472C4"))[Indicateur],
    text(size: 0.8em, fill: rgb("#555555"))[#link(<ind-1>)[1]],
    text(size: 0.8em)[#link(<ind-1>)[Capacité de production]],
    text(size: 0.8em, fill: rgb("#555555"))[#link(<ind-2>)[2]],
    text(size: 0.8em)[#link(<ind-2>)[Population desservie]],
    text(size: 0.8em, fill: rgb("#555555"))[#link(<ind-3>)[3]],
    text(size: 0.8em)[#link(<ind-3>)[Statut captage]],
    text(size: 0.8em, fill: rgb("#555555"))[#link(<ind-4>)[4]],
    text(size: 0.8em)[#link(<ind-4>)[Établissements public sensibles]],
  )
)
#v(0.7em)
#block(
  width: 100%,
  stroke: (left: 5pt + rgb("4472C4")),
  fill: luma(252),
  radius: (right: 6pt),
  inset: (left: 12pt, right: 10pt, top: 8pt, bottom: 8pt),
  grid(
    columns: (1fr, auto),
    column-gutter: 8pt,
    align: horizon,
    grid(
      columns: 1,
      row-gutter: 3pt,
      text(size: 1em, weight: "bold")[Niveau infrastructures],
      text(size: 0.85em, fill: rgb("#333333"))[Identifier les ressources dont la défaillance impacterait le plus grand nombre d'habitants ou le plus important linéaire d'infrastructures de distribution.],
    ),
  )
)
#v(0.4em)
#block(
  width: 100%,
  inset: (left: 17pt),
  grid(
    columns: (40pt, 1fr),
    row-gutter: 4pt,
    column-gutter: 6pt,
    text(size: 0.78em, weight: "bold", fill: rgb("4472C4"))[Fiche n°],
    text(size: 0.78em, weight: "bold", fill: rgb("4472C4"))[Indicateur],
    text(size: 0.8em, fill: rgb("#555555"))[#link(<ind-5>)[5]],
    text(size: 0.8em)[#link(<ind-5>)[Longueur réseau]],
    text(size: 0.8em, fill: rgb("#555555"))[#link(<ind-6>)[6]],
    text(size: 0.8em)[#link(<ind-6>)[Capacité réservoir]],
  )
)
#v(0.7em)
#block(
  width: 100%,
  stroke: (left: 5pt + rgb("4472C4")),
  fill: luma(252),
  radius: (right: 6pt),
  inset: (left: 12pt, right: 10pt, top: 8pt, bottom: 8pt),
  grid(
    columns: (1fr, auto),
    column-gutter: 8pt,
    align: horizon,
    grid(
      columns: 1,
      row-gutter: 3pt,
      text(size: 1em, weight: "bold")[Vulnérabilité structurelle],
      text(size: 0.85em, fill: rgb("#333333"))[Différencier les ressources selon leur nature \(ouvrage\) et leur usage actuel pour affiner la comparaison entre les points d'eau.],
    ),
  )
)
#v(0.4em)
#block(
  width: 100%,
  inset: (left: 17pt),
  grid(
    columns: (40pt, 1fr),
    row-gutter: 4pt,
    column-gutter: 6pt,
    text(size: 0.78em, weight: "bold", fill: rgb("4472C4"))[Fiche n°],
    text(size: 0.78em, weight: "bold", fill: rgb("4472C4"))[Indicateur],
    text(size: 0.8em, fill: rgb("#555555"))[#link(<ind-11>)[11]],
    text(size: 0.8em)[#link(<ind-11>)[Interconnexion]],
    text(size: 0.8em, fill: rgb("#555555"))[#link(<ind-12>)[12]],
    text(size: 0.8em)[#link(<ind-12>)[Type ouvrage]],
  )
)
#v(0.7em)
#block(
  width: 100%,
  stroke: (left: 5pt + rgb("4472C4")),
  fill: luma(252),
  radius: (right: 6pt),
  inset: (left: 12pt, right: 10pt, top: 8pt, bottom: 8pt),
  grid(
    columns: (1fr, auto),
    column-gutter: 8pt,
    align: horizon,
    grid(
      columns: 1,
      row-gutter: 3pt,
      text(size: 1em, weight: "bold")[Sécurité sanitaire et règlementaire],
      text(size: 0.85em, fill: rgb("#333333"))[Évaluer le niveau de conformité réglementaire et de protection sanitaire des captages],
    ),
  )
)
#v(0.4em)
#block(
  width: 100%,
  inset: (left: 17pt),
  grid(
    columns: (40pt, 1fr),
    row-gutter: 4pt,
    column-gutter: 6pt,
    text(size: 0.78em, weight: "bold", fill: rgb("4472C4"))[Fiche n°],
    text(size: 0.78em, weight: "bold", fill: rgb("4472C4"))[Indicateur],
    text(size: 0.8em, fill: rgb("#555555"))[#link(<ind-7>)[7]],
    text(size: 0.8em)[#link(<ind-7>)[Traitement]],
    text(size: 0.8em, fill: rgb("#555555"))[#link(<ind-8>)[8]],
    text(size: 0.8em)[#link(<ind-8>)[Statut AODPE]],
    text(size: 0.8em, fill: rgb("#555555"))[#link(<ind-9>)[9]],
    text(size: 0.8em)[#link(<ind-9>)[Statut PPE]],
    text(size: 0.8em, fill: rgb("#555555"))[#link(<ind-10>)[10]],
    text(size: 0.8em)[#link(<ind-10>)[Statut du foncier]],
  )
)
#v(0.7em)
#pagebreak()

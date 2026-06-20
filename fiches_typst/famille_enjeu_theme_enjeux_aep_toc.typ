#import "../template_typst.typ": *

// ─── TOC THÈME : Enjeux AEP ───────────────────────────────
#block(width: 100%, fill: rgb("#546E7A"), radius: 4pt,
  inset: (x: 14pt, y: 12pt),
  text(size: 1.2em, weight: "bold", fill: white)[Enjeux AEP]
)
#block(
  width: 100%,
  inset: (x: 2pt, top: 6pt, bottom: 4pt),
  grid(
    columns: 1,
    row-gutter: 4pt,
    text(size: 0.82em, fill: rgb("#475569"), style: "italic")[Caractérise l’importance stratégique des ressources en eau potable en termes de disponibilité, de capacité et de résilience technique et réglementaire pour l’alimentation de la population.],
  )
)
#v(0.8em)
#block(
  width: 100%,
  fill: luma(252),
  stroke: (left: 5pt + rgb("#546E7A")),
  radius: (right: 6pt),
  inset: (left: 12pt, right: 10pt, top: 8pt, bottom: 8pt),
  grid(
    columns: (1fr, auto),
    column-gutter: 8pt,
    align: horizon,
    grid(
      columns: 1,
      row-gutter: 3pt,
      text(size: 1em, weight: "bold")[Robustesse et résilience technique],
      text(size: 0.85em, fill: rgb("#333333"))[Évaluer la capacité du système AEP à assurer la continuité du service \(production, stockage, interconnexion\)],
      text(size: 0.8em, fill: rgb("#666666"), style: "italic")[Guide la mise en conformité légale et les actions de protection réglementaire.],
    ),
    box(fill: rgb("#546E7A"), radius: 999pt,
      inset: (x: 10pt, y: 5pt),
      text(size: 0.75em, weight: "bold", fill: white)[COMPRENDRE]
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
    text(size: 0.78em, weight: "bold", fill: rgb("#546E7A"))[Fiche n°],
    text(size: 0.78em, weight: "bold", fill: rgb("#546E7A"))[Indicateur],
    text(size: 0.8em, fill: rgb("#555555"))[#link(<ind-1>)[1]],
    text(size: 0.8em)[#link(<ind-1>)[Capacité de production]],
    text(size: 0.8em, fill: rgb("#555555"))[#link(<ind-3>)[3]],
    text(size: 0.8em)[#link(<ind-3>)[Capacité réservoir]],
    text(size: 0.8em, fill: rgb("#555555"))[#link(<ind-5>)[5]],
    text(size: 0.8em)[#link(<ind-5>)[Interconnexion]],
  )
)
#v(0.7em)
#block(
  width: 100%,
  fill: luma(252),
  stroke: (left: 5pt + rgb("#005596")),
  radius: (right: 6pt),
  inset: (left: 12pt, right: 10pt, top: 8pt, bottom: 8pt),
  grid(
    columns: (1fr, auto),
    column-gutter: 8pt,
    align: horizon,
    grid(
      columns: 1,
      row-gutter: 3pt,
      text(size: 1em, weight: "bold")[Poids stratégique de la desserte],
      text(size: 0.85em, fill: rgb("#333333"))[Identifier les ressources dont la défaillance impacterait le plus grand nombre d'habitants ou le plus important linéaire d'infrastructures de distribution.],
      text(size: 0.8em, fill: rgb("#666666"), style: "italic")[Définit les priorités d'investissement et l'importance socio\-économique de la ressource.],
    ),
    box(fill: rgb("#005596"), radius: 999pt,
      inset: (x: 10pt, y: 5pt),
      text(size: 0.75em, weight: "bold", fill: white)[AGIR]
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
    text(size: 0.78em, weight: "bold", fill: rgb("#005596"))[Fiche n°],
    text(size: 0.78em, weight: "bold", fill: rgb("#005596"))[Indicateur],
    text(size: 0.8em, fill: rgb("#555555"))[#link(<ind-2>)[2]],
    text(size: 0.8em)[#link(<ind-2>)[Longueur réseau]],
    text(size: 0.8em, fill: rgb("#555555"))[#link(<ind-6>)[6]],
    text(size: 0.8em)[#link(<ind-6>)[Population desservie]],
  )
)
#v(0.7em)
#block(
  width: 100%,
  fill: luma(252),
  stroke: (left: 5pt + rgb("#005596")),
  radius: (right: 6pt),
  inset: (left: 12pt, right: 10pt, top: 8pt, bottom: 8pt),
  grid(
    columns: (1fr, auto),
    column-gutter: 8pt,
    align: horizon,
    grid(
      columns: 1,
      row-gutter: 3pt,
      text(size: 1em, weight: "bold")[Sécurisation sanitaire et réglementaire],
      text(size: 0.85em, fill: rgb("#333333"))[Évaluer le niveau de conformité réglementaire et de protection sanitaire des captages],
      text(size: 0.8em, fill: rgb("#666666"), style: "italic")[Mesurer le niveau de conformité administrative \(AODPE\) et de protection physique \(PPE\/Traitement\) afin d'identifier les risques d'exposition aux pollutions],
    ),
    box(fill: rgb("#005596"), radius: 999pt,
      inset: (x: 10pt, y: 5pt),
      text(size: 0.75em, weight: "bold", fill: white)[AGIR]
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
    text(size: 0.78em, weight: "bold", fill: rgb("#005596"))[Fiche n°],
    text(size: 0.78em, weight: "bold", fill: rgb("#005596"))[Indicateur],
    text(size: 0.8em, fill: rgb("#555555"))[#link(<ind-4>)[4]],
    text(size: 0.8em)[#link(<ind-4>)[Traitement]],
    text(size: 0.8em, fill: rgb("#555555"))[#link(<ind-7>)[7]],
    text(size: 0.8em)[#link(<ind-7>)[Statut AODPE]],
    text(size: 0.8em, fill: rgb("#555555"))[#link(<ind-8>)[8]],
    text(size: 0.8em)[#link(<ind-8>)[Statut PPE]],
  )
)
#v(0.7em)
#pagebreak()

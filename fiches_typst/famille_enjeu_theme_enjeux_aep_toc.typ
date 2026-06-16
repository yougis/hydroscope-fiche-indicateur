#import "../template_typst.typ": *

// ─── TOC THÈME : Enjeux AEP ────────────────────────────────
#block(
  width: 100%,
  fill: rgb("#546E7A"),
  radius: 4pt,
  inset: (x: 14pt, y: 10pt),
  text(size: 1.15em, weight: "bold", fill: white)[Enjeux AEP]
)
#v(0.6em)
#block(
  width: 100%,
  stroke: (left: 5pt + rgb("#546E7A")),
  fill: luma(252),
  radius: (right: 6pt),
  inset: (left: 12pt, right: 10pt, top: 8pt, bottom: 8pt),
  grid(
    columns: (1fr, auto),
    column-gutter: 8pt,
    stack(dir: ttb, spacing: 0.3em,
      text(size: 1em, weight: "bold")[Robustesse et résilience technique],
      text(size: 0.85em, fill: rgb("#333333"))[Évaluer la capacité de production en période sèche et la présence de dispositifs de secours (stockage, interconnexion) pour garantir la continuité du service.],
      text(size: 0.8em, style: "italic", fill: rgb("#666666"))[Guide la mise en conformité légale et les actions de protection réglementaire.],
    ),
    box(fill: rgb("#546E7A"), radius: 999pt,
      inset: (x: 10pt, y: 5pt),
      text(size: 0.75em, weight: "bold", fill: white)[DIAGNOSTIC]
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
  stroke: (left: 5pt + rgb("#005596")),
  fill: luma(252),
  radius: (right: 6pt),
  inset: (left: 12pt, right: 10pt, top: 8pt, bottom: 8pt),
  grid(
    columns: (1fr, auto),
    column-gutter: 8pt,
    stack(dir: ttb, spacing: 0.3em,
      text(size: 1em, weight: "bold")[Poids stratégique de la desserte],
      text(size: 0.85em, fill: rgb("#333333"))[Identifier les ressources dont la défaillance impacterait le plus grand nombre d'habitants ou le plus important linéaire d'infrastructures de distribution.],
      text(size: 0.8em, style: "italic", fill: rgb("#666666"))[Définit les priorités d'investissement et l'importance socio-économique de la ressource.],
    ),
    box(fill: rgb("#005596"), radius: 999pt,
      inset: (x: 10pt, y: 5pt),
      text(size: 0.75em, weight: "bold", fill: white)[PILOTAGE]
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
  stroke: (left: 5pt + rgb("#005596")),
  fill: luma(252),
  radius: (right: 6pt),
  inset: (left: 12pt, right: 10pt, top: 8pt, bottom: 8pt),
  grid(
    columns: (1fr, auto),
    column-gutter: 8pt,
    stack(dir: ttb, spacing: 0.3em,
      text(size: 1em, weight: "bold")[Sécurisation sanitaire et réglementaire],
      text(size: 0.85em, fill: rgb("#333333"))[Mesurer le niveau de conformité administrative (AODPE) et de protection physique (PPE/Traitement) pour identifier les risques d'exposition aux pollutions.],
      text(size: 0.8em, style: "italic", fill: rgb("#666666"))[Mesurer le niveau de conformité administrative (AODPE) et de protection physique (PPE/Traitement) afin d'identifier les risques d'exposition aux pollutions],
    ),
    box(fill: rgb("#005596"), radius: 999pt,
      inset: (x: 10pt, y: 5pt),
      text(size: 0.75em, weight: "bold", fill: white)[PILOTAGE]
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
#block(
  width: 100%,
  stroke: (left: 5pt + rgb("#546E7A")),
  fill: luma(252),
  radius: (right: 6pt),
  inset: (left: 12pt, right: 10pt, top: 8pt, bottom: 8pt),
  grid(
    columns: (1fr, auto),
    column-gutter: 8pt,
    stack(dir: ttb, spacing: 0.3em,
      text(size: 1em, weight: "bold")[Vulnérabilité technique et contexte],
      text(size: 0.85em, fill: rgb("#333333"))[Différencier les ressources selon leur nature (ouvrage) et leur usage actuel pour affiner la comparaison entre les points d'eau.],
      text(size: 0.8em, style: "italic", fill: rgb("#666666"))[Caractérise la sensibilité propre de l'ouvrage (ex: forage vs captage superficiel).],
    ),
    box(fill: rgb("#546E7A"), radius: 999pt,
      inset: (x: 10pt, y: 5pt),
      text(size: 0.75em, weight: "bold", fill: white)[DIAGNOSTIC]
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
    text(size: 0.8em, fill: rgb("#555555"))[#link(<ind-9>)[9]],
    text(size: 0.8em)[#link(<ind-9>)[Type ouvrage]],
    text(size: 0.8em, fill: rgb("#555555"))[#link(<ind-10>)[10]],
    text(size: 0.8em)[#link(<ind-10>)[Statut captage]],
  )
)
#v(0.7em)
#pagebreak()

#import "../template_typst.typ": *

// ─── PAGE DE GARDE FAMILLE ───────────────────────────────────
= Pression

#block(
  width: 100%,
  stroke: (top: 4pt + rgb("#005596")),
  inset: (top: 10pt, bottom: 8pt, left: 0pt, right: 0pt),
  stack(dir: ttb, spacing: 0.4em,
    text(size: 1.5em, weight: "bold", tracking: 1pt)[PRESSION],
  )
)
#v(0.6em)
#block(
  width: 100%,
  fill: luma(245),
  radius: 6pt,
  inset: 12pt,
  text(size: 0.95em, style: "italic", fill: rgb("#333333"))[Comparer les bassins versants selon leur historique d’incendies afin d’identifier les milieux les perturbés.]
)
#v(0.9em)
== Pressions Anthropiques

#block(
  width: 100%,
  fill: rgb("#005596"),
  radius: 4pt,
  inset: (x: 12pt, y: 8pt),
  text(size: 1.1em, weight: "bold", fill: white)[Pressions Anthropiques]
)
#v(0.5em)
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
      text(size: 1em, weight: "bold")[Activités à risque],
      text(size: 0.85em, fill: rgb("#333333"))[Recenser les implantations industrielles (ICPE) ou minières pouvant générer des pollutions accidentelles ou chroniques.],
      text(size: 0.8em, style: "italic", fill: rgb("#666666"))[Oriente les contrôles de la police de l'eau et la surveillance des sites industriels.],
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
    text(size: 0.8em, fill: rgb("#555555"))[24],
    text(size: 0.8em)[ICPE],
    text(size: 0.8em, fill: rgb("#555555"))[25],
    text(size: 0.8em)[Activité minière],
  )
)
#v(0.7em)
#block(
  width: 100%,
  stroke: (left: 5pt + rgb("#2E7D32")),
  fill: luma(252),
  radius: (right: 6pt),
  inset: (left: 12pt, right: 10pt, top: 8pt, bottom: 8pt),
  grid(
    columns: (1fr, auto),
    column-gutter: 8pt,
    stack(dir: ttb, spacing: 0.3em,
      text(size: 1em, weight: "bold")[Niveau d'artificialisation et densité],
      text(size: 0.85em, fill: rgb("#333333"))[Quantifier l'emprise du bâti et de l'habitat pour évaluer la pression directe exercée par l'occupation humaine sur le milieu.],
      text(size: 0.8em, style: "italic", fill: rgb("#666666"))[Suit l'évolution de l'empreinte humaine et de l'imperméabilisation des sols.],
    ),
    box(fill: rgb("#2E7D32"), radius: 999pt,
      inset: (x: 10pt, y: 5pt),
      text(size: 0.75em, weight: "bold", fill: white)[VEILLE]
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
    text(size: 0.78em, weight: "bold", fill: rgb("#2E7D32"))[Fiche n°],
    text(size: 0.78em, weight: "bold", fill: rgb("#2E7D32"))[Indicateur],
    text(size: 0.8em, fill: rgb("#555555"))[26],
    text(size: 0.8em)[Urbanisation],
    text(size: 0.8em, fill: rgb("#555555"))[28],
    text(size: 0.8em)[Habitations],
  )
)
#v(0.7em)
#block(
  width: 100%,
  stroke: (left: 5pt + rgb("#2E7D32")),
  fill: luma(252),
  radius: (right: 6pt),
  inset: (left: 12pt, right: 10pt, top: 8pt, bottom: 8pt),
  grid(
    columns: (1fr, auto),
    column-gutter: 8pt,
    stack(dir: ttb, spacing: 0.3em,
      text(size: 1em, weight: "bold")[Infrastructures et risques de dégradation des eaux],
      text(size: 0.85em, fill: rgb("#333333"))[Identifier les points de contact entre les réseaux de transport et le milieu hydrographique pour localiser les zones à risque de pollution (ruissellement routier, accidents) et de dégradation de la qualité des cours d'eau (sédimentation, modification des écoulements)],
      text(size: 0.8em, style: "italic", fill: rgb("#666666"))[Cible les points de vigilance pour prévenir les pollutions liées au ruissellement routier.],
    ),
    box(fill: rgb("#2E7D32"), radius: 999pt,
      inset: (x: 10pt, y: 5pt),
      text(size: 0.75em, weight: "bold", fill: white)[VEILLE]
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
    text(size: 0.78em, weight: "bold", fill: rgb("#2E7D32"))[Fiche n°],
    text(size: 0.78em, weight: "bold", fill: rgb("#2E7D32"))[Indicateur],
    text(size: 0.8em, fill: rgb("#555555"))[29],
    text(size: 0.8em)[Franchissements],
    text(size: 0.8em, fill: rgb("#555555"))[30],
    text(size: 0.8em)[Linéaire routes],
  )
)
#v(0.7em)
== Pressions Environnementales

#block(
  width: 100%,
  fill: rgb("#005596"),
  radius: 4pt,
  inset: (x: 12pt, y: 8pt),
  text(size: 1.1em, weight: "bold", fill: white)[Pressions Environnementales]
)
#v(0.5em)
#block(
  width: 100%,
  stroke: (left: 5pt + rgb("#2E7D32")),
  fill: luma(252),
  radius: (right: 6pt),
  inset: (left: 12pt, right: 10pt, top: 8pt, bottom: 8pt),
  grid(
    columns: (1fr, auto),
    column-gutter: 8pt,
    stack(dir: ttb, spacing: 0.3em,
      text(size: 1em, weight: "bold")[Perturbations majeures du milieu (Aléa)],
      text(size: 0.85em, fill: rgb("#333333"))[Identifier les bassins dont l'équilibre écologique a été rompu par des événements destructeurs comme les incendies.],
      text(size: 0.8em, style: "italic", fill: rgb("#666666"))[Permet une réaction rapide face aux chocs brutaux impactant le bassin versant.],
    ),
    box(fill: rgb("#2E7D32"), radius: 999pt,
      inset: (x: 10pt, y: 5pt),
      text(size: 0.75em, weight: "bold", fill: white)[VEILLE]
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
    text(size: 0.78em, weight: "bold", fill: rgb("#2E7D32"))[Fiche n°],
    text(size: 0.78em, weight: "bold", fill: rgb("#2E7D32"))[Indicateur],
    text(size: 0.8em, fill: rgb("#555555"))[19],
    text(size: 0.8em)[Incendies cumulés],
    text(size: 0.8em, fill: rgb("#555555"))[23],
    text(size: 0.8em)[Espèces exotiques envahissantes (EEE)],
  )
)
#v(0.7em)
#block(
  width: 100%,
  stroke: (left: 5pt + rgb("#2E7D32")),
  fill: luma(252),
  radius: (right: 6pt),
  inset: (left: 12pt, right: 10pt, top: 8pt, bottom: 8pt),
  grid(
    columns: (1fr, auto),
    column-gutter: 8pt,
    stack(dir: ttb, spacing: 0.3em,
      text(size: 1em, weight: "bold")[Fragilité des sols et transferts (chronique)],
      text(size: 0.85em, fill: rgb("#333333"))[Détecter les zones de sols nus ou instables qui favorisent le transport de sédiments et de polluants vers les points de captage.],
      text(size: 0.8em, style: "italic", fill: rgb("#666666"))[Assure la surveillance de la dégradation structurelle et lente des sols.],
    ),
    box(fill: rgb("#2E7D32"), radius: 999pt,
      inset: (x: 10pt, y: 5pt),
      text(size: 0.75em, weight: "bold", fill: white)[VEILLE]
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
    text(size: 0.78em, weight: "bold", fill: rgb("#2E7D32"))[Fiche n°],
    text(size: 0.78em, weight: "bold", fill: rgb("#2E7D32"))[Indicateur],
    text(size: 0.8em, fill: rgb("#555555"))[20],
    text(size: 0.8em)[Surface érosion],
    text(size: 0.8em, fill: rgb("#555555"))[21],
    text(size: 0.8em)[Terrain nu],
    text(size: 0.8em, fill: rgb("#555555"))[22],
    text(size: 0.8em)[Glissement terrain],
  )
)
#v(0.7em)
== Pressions Qualitatives

#block(
  width: 100%,
  fill: rgb("#005596"),
  radius: 4pt,
  inset: (x: 12pt, y: 8pt),
  text(size: 1.1em, weight: "bold", fill: white)[Pressions Qualitatives]
)
#v(0.5em)
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
      text(size: 1em, weight: "bold")[État sanitaire et suivi de la qualité],
      text(size: 0.85em, fill: rgb("#333333"))[Identifier les captages dont la qualité de l'eau est dégradée afin de prioriser les actions de gestion ou de protection.],
      text(size: 0.8em, style: "italic", fill: rgb("#666666"))[Sert de diagnostic de confirmation pour valider l'impact réel des pressions sur la ressource.],
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
    text(size: 0.8em, fill: rgb("#555555"))[38],
    text(size: 0.8em)[Qualité eau],
  )
)
#v(0.7em)
== Pressions Quantitatives

#block(
  width: 100%,
  fill: rgb("#005596"),
  radius: 4pt,
  inset: (x: 12pt, y: 8pt),
  text(size: 1.1em, weight: "bold", fill: white)[Pressions Quantitatives]
)
#v(0.5em)
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
      text(size: 1em, weight: "bold")[Tension des usages],
      text(size: 0.85em, fill: rgb("#333333"))[Identifier les situations de déséquilibre entre les besoins humains et l'eau disponible en croisant les prélèvements réels et le diagnostic de déficit.],
      text(size: 0.8em, style: "italic", fill: rgb("#666666"))[Relève du pilotage : déclenche les restrictions ou les limitations de nouvelles autorisations.],
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
    text(size: 0.8em, fill: rgb("#555555"))[33],
    text(size: 0.8em)[BBR],
    text(size: 0.8em, fill: rgb("#555555"))[36],
    text(size: 0.8em)[AODPE nombre],
    text(size: 0.8em, fill: rgb("#555555"))[37],
    text(size: 0.8em)[AODPE volume],
  )
)
#v(0.7em)
#block(
  width: 100%,
  stroke: (left: 5pt + rgb("#2E7D32")),
  fill: luma(252),
  radius: (right: 6pt),
  inset: (left: 12pt, right: 10pt, top: 8pt, bottom: 8pt),
  grid(
    columns: (1fr, auto),
    column-gutter: 8pt,
    stack(dir: ttb, spacing: 0.3em,
      text(size: 1em, weight: "bold")[Apports naturels],
      text(size: 0.85em, fill: rgb("#333333"))[Contextualiser la ressource disponible (pluie, nappes).],
      text(size: 0.8em, style: "italic", fill: rgb("#666666"))[Relève de la veille : observation du contexte climatique pour la gestion de crise.],
    ),
    box(fill: rgb("#2E7D32"), radius: 999pt,
      inset: (x: 10pt, y: 5pt),
      text(size: 0.75em, weight: "bold", fill: white)[VEILLE]
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
    text(size: 0.78em, weight: "bold", fill: rgb("#2E7D32"))[Fiche n°],
    text(size: 0.78em, weight: "bold", fill: rgb("#2E7D32"))[Indicateur],
    text(size: 0.8em, fill: rgb("#555555"))[34],
    text(size: 0.8em)[Pluviométrie],
    text(size: 0.8em, fill: rgb("#555555"))[35],
    text(size: 0.8em)[Niveau nappes],
  )
)
#v(0.7em)
#pagebreak()

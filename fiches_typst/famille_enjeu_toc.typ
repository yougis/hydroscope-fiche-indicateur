#import "../template_typst.typ": *

// ─── PAGE DE GARDE FAMILLE ───────────────────────────────────
= Enjeu

#block(
  width: 100%,
  stroke: (top: 4pt + rgb("#546E7A")),
  inset: (top: 10pt, bottom: 8pt, left: 0pt, right: 0pt),
  stack(dir: ttb, spacing: 0.4em,
    text(size: 1.5em, weight: "bold", tracking: 1pt)[ENJEU],
  )
)
#v(0.6em)
#block(
  width: 100%,
  fill: luma(245),
  radius: 6pt,
  inset: 12pt,
  text(size: 0.95em, style: "italic", fill: rgb("#333333"))[Comparer la capacité des captages à fournir de l’eau en période contrainte (sécheresse, inondation, glissement de terrain) afin d’identifier les ressources les plus robustes ou les plus limitées.]
)
#v(0.9em)
== Enjeux AEP

#block(
  width: 100%,
  fill: rgb("#546E7A"),
  radius: 4pt,
  inset: (x: 12pt, y: 8pt),
  text(size: 1.1em, weight: "bold", fill: white)[Enjeux AEP]
)
#v(0.5em)
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
      text(size: 0.75em, weight: "bold", fill: white)[DIAGNOSTIC & MODULATION]
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
    text(size: 0.8em, fill: rgb("#555555"))[1],
    text(size: 0.8em)[Capacité de production],
    text(size: 0.8em, fill: rgb("#555555"))[3],
    text(size: 0.8em)[Capacité réservoir],
    text(size: 0.8em, fill: rgb("#555555"))[5],
    text(size: 0.8em)[Interconnexion],
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
    text(size: 0.8em, fill: rgb("#555555"))[2],
    text(size: 0.8em)[Longueur réseau],
    text(size: 0.8em, fill: rgb("#555555"))[6],
    text(size: 0.8em)[Population desservie],
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
    text(size: 0.8em, fill: rgb("#555555"))[4],
    text(size: 0.8em)[Traitement],
    text(size: 0.8em, fill: rgb("#555555"))[7],
    text(size: 0.8em)[Statut AODPE],
    text(size: 0.8em, fill: rgb("#555555"))[8],
    text(size: 0.8em)[Statut PPE],
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
      text(size: 0.75em, weight: "bold", fill: white)[DIAGNOSTIC & MODULATION]
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
    text(size: 0.8em, fill: rgb("#555555"))[9],
    text(size: 0.8em)[Type ouvrage],
    text(size: 0.8em, fill: rgb("#555555"))[10],
    text(size: 0.8em)[Statut captage],
  )
)
#v(0.7em)
== Enjeux Environnementaux

#block(
  width: 100%,
  fill: rgb("#546E7A"),
  radius: 4pt,
  inset: (x: 12pt, y: 8pt),
  text(size: 1.1em, weight: "bold", fill: white)[Enjeux Environnementaux]
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
      text(size: 1em, weight: "bold")[Valeur patrimoniale et réglementaire],
      text(size: 0.85em, fill: rgb("#333333"))[Repérer les bassins versants inscrits dans des périmètres de reconnaissance mondiale ou locale (UNESCO, aires protégées) nécessitant une gestion exemplaire.],
      text(size: 0.8em, style: "italic", fill: rgb("#666666"))[Assure le suivi des engagements de conservation et des contraintes réglementaires associées.],
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
    text(size: 0.8em, fill: rgb("#555555"))[11],
    text(size: 0.8em)[Zones UNESCO],
    text(size: 0.8em, fill: rgb("#555555"))[12],
    text(size: 0.8em)[Zones protégées provinciales],
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
      text(size: 1em, weight: "bold")[Richesse biologique et rareté],
      text(size: 0.85em, fill: rgb("#333333"))[Localiser les zones de biodiversité critique (KBA, espèces menacées) qui dépendent du maintien de la qualité de la ressource en eau.],
      text(size: 0.8em, style: "italic", fill: rgb("#666666"))[Surveille l'état des écosystèmes sensibles dépendants de la ressource en eau.],
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
    text(size: 0.8em, fill: rgb("#555555"))[13],
    text(size: 0.8em)[KBA / ZICO],
    text(size: 0.8em, fill: rgb("#555555"))[14],
    text(size: 0.8em)[Espèces menacées],
    text(size: 0.8em, fill: rgb("#555555"))[15],
    text(size: 0.8em)[Espèces menacées (Forêt sèche)],
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
      text(size: 1em, weight: "bold")[État écologique et rôle protecteur],
      text(size: 0.85em, fill: rgb("#333333"))[Qualifier l'intégrité de la couverture végétale naturelle agissant comme un filtre et un régulateur naturel contre le ruissellement.],
      text(size: 0.8em, style: "italic", fill: rgb("#666666"))[Mesure la capacité naturelle du milieu à protéger la ressource par filtration.],
    ),
    box(fill: rgb("#546E7A"), radius: 999pt,
      inset: (x: 10pt, y: 5pt),
      text(size: 0.75em, weight: "bold", fill: white)[DIAGNOSTIC & MODULATION]
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
    text(size: 0.8em, fill: rgb("#555555"))[16],
    text(size: 0.8em)[Occupation sol (couvert végétal)],
    text(size: 0.8em, fill: rgb("#555555"))[17],
    text(size: 0.8em)[Occupation sol (couvert forestier)],
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
    text(size: 0.8em, fill: rgb("#555555"))[18],
    text(size: 0.8em)[Occupation sol (surfaces agricoles)],
  )
)
#v(0.7em)
#pagebreak()

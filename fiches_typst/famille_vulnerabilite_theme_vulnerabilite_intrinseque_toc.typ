#import "../template_typst.typ": *

// ─── TOC THÈME : Vulnérabilité Intrinsèque ────────────────────────────────
#block(
  width: 100%,
  fill: rgb("#546E7A"),
  radius: 4pt,
  inset: (x: 14pt, y: 10pt),
  text(size: 1.15em, weight: "bold", fill: white)[Vulnérabilité Intrinsèque]
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
      text(size: 1em, weight: "bold")[Sensibilité naturelle],
      text(size: 0.85em, fill: rgb("#333333"))[Qualifier la propension naturelle du terrain à laisser circuler les polluants vers les eaux souterraines ou superficielles selon ses propriétés géologiques.],
      text(size: 0.8em, style: "italic", fill: rgb("#666666"))[Définit le socle physique immuable qui module (amplifie ou réduit) l'impact des pressions.],
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
    text(size: 0.8em, fill: rgb("#555555"))[#link(<ind-31>)[31]],
    text(size: 0.8em)[#link(<ind-31>)[Géologie]],
    text(size: 0.8em, fill: rgb("#555555"))[#link(<ind-32>)[32]],
    text(size: 0.8em)[#link(<ind-32>)[Vulnérabilité intrinsèque des eaux souterraines]],
  )
)
#v(0.7em)
#pagebreak()

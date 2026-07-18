#import "../template_typst.typ": *

// ─── ENTÊTE FAMILLE ──────────────────────────────────────────
#block(
  width: 100%,
  stroke: (top: 4pt + rgb("2b5e8c")),
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
  text(size: 0.95em, style: "italic", fill: rgb("#333333"))[Qu'est\-ce qu'on protège \?]
)
#v(0.6em)

#import "../template_typst.typ": *

// ─── ENTÊTE FAMILLE ──────────────────────────────────────────
#block(
  width: 100%,
  stroke: (top: 4pt + rgb("#546E7A")),
  inset: (top: 10pt, bottom: 8pt, left: 0pt, right: 0pt),
  stack(dir: ttb, spacing: 0.4em,
    text(size: 1.5em, weight: "bold", tracking: 1pt)[VULNÉRABILITÉ],
  )
)
#v(0.6em)

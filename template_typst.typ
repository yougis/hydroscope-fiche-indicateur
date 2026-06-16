// ═══════════════════════════════════════════════════════════════
// TEMPLATE TYPST — OEIL Nouvelle-Calédonie
// ═══════════════════════════════════════════════════════════════

// ── Couleurs ─────────────────────────────────────────────────────
#let color_orange  = rgb(227, 108, 10)
#let color_grey    = rgb(128, 128, 128)
#let color_purple  = rgb(102, 0, 102)
#let color_black   = rgb(0, 0, 0)
#let head_color    = rgb(250, 192, 144)
#let version-color = rgb(102, 0, 102)
#let titre-color   = rgb(227, 108, 10)
#let grey-color    = rgb(128, 128, 128)
#let date-color    = rgb(227, 150, 70)

// ── Couleurs fiches indicateurs ───────────────────────────────────
#let pilotage_color     = rgb("#005596")
#let veille_color       = rgb("#2E7D32")
#let diag_color         = rgb("#546E7A")
#let fiche_vision_bg    = rgb(244, 249, 255)
#let fiche_alert_bg     = rgb(255, 247, 214)
#let fiche_alert_border = rgb(217, 165, 0)
#let fiche_bg           = rgb(251, 251, 251)
#let fiche_border       = rgb(219, 228, 235)
#let badge_bg           = rgb(238, 244, 251)
#let badge_color        = rgb(31, 59, 90)

// ── Chemins ressources ────────────────────────────────────────────
#let image_font_1   = "ressources/MJunckerOEIL.png"
#let image_font_2   = "ressources/eau-monitoring.png"
#let logo_partenaire = "ressources/logo_yapuka.png"
#let logo           = "ressources/OEIL_logo.png"

// ── Variables page de garde ───────────────────────────────────────
#let subtitle   = ""
#let title      = ""
#let author     = ""
#let date       = ""
#let publisher  = ""
#let diffusion  = ""
#let version    = ""

// ── Typographie de base ───────────────────────────────────────────
#set text(
  font: "Liberation Sans",
  size: 11pt,
  lang: "fr",
)

#set par(justify: true, leading: 0.65em)

// ── Configuration page courante ───────────────────────────────────
#set page(
  paper: "a4",
  margin: (top: 25.4mm, bottom: 25.4mm, left: 25.4mm, right: 25.4mm),
)

// ── Page de garde ─────────────────────────────────────────────────
// ── Page de garde (fonction à appeler) ───────────────────────────
#let page_garde(
  title: "",
  subtitle: "",
  author: "",
  publisher: "",
  date: "",
  version: "",
  diffusion: "",
) = {
  page(
    margin: 0pt,
    background: [
      #place(top + left, dx: -5.7cm, dy: -18.18cm,
        block(
          width: 23.5cm, height: 16cm,
          clip: true, radius: 60pt,
          image(image_font_1, width: 27cm, height: 16cm, fit: "cover"),
        )
      )
      #place(top + left, dx: -0.5cm, dy: -2.5cm,
        block(
          width: 9cm, height: 5.5cm,
          clip: true, radius: 30pt,
          stroke: 3pt + white,
          image(image_font_2, width: 10.5cm, height: 6.5cm, fit: "cover"),
        )
      )
      #place(top + left, dx: 10.25cm, dy: -4.8cm,
        image(logo, width: 4.5cm, height: 5.5cm),
      )
      #place(top + left, dx: 9cm, dy: -5cm,
        image(logo_partenaire, width: 7cm, height: 1.5cm),
      )
    ],
  )[
    #pad(left: 12cm, right: 1cm, top: 0.5cm,
      text(size: 10pt, fill: version-color)[#version]
    )
    #pad(left: 0.5cm, right: 1cm, top: 2.2cm,
      stack(dir: ttb, spacing: 0.4em,
        text(size: 16pt, fill: titre-color)[#title],
        text(size: 10pt, fill: titre-color)[#subtitle],
        text(size: 12pt, fill: grey-color)[#author \ #publisher],
        text(size: 12pt, fill: date-color)[#date],
      )
    )
    #pad(left: -0.4cm, right: 1cm, top: 3.4cm,
      text(size: 11pt, fill: version-color)[
        #diffusion \ Nouvelle-Calédonie
      ]
    )
  ]
}

// ── Fonctions utilitaires fiches ──────────────────────────────────

#let fiche_box(content, bg_color: fiche_bg, border_left: fiche_border) = {
  box(
    width: 100%,
    fill: bg_color,
    stroke: (left: 6pt + border_left),
    inset: 10pt,
    radius: (right: 6pt),
    content
  )
}

#let fiche_alert_box(content) = {
  box(
    width: 100%,
    fill: fiche_alert_bg,
    stroke: (left: 6pt + fiche_alert_border),
    inset: 10pt,
    radius: (right: 6pt),
    content
  )
}

#let badge(label, value) = {
  box(
    fill: badge_bg,
    stroke: 0.5pt + rgb("#c8d4e0"),
    radius: 999pt,
    inset: (x: 8pt, y: 4pt),
    text(size: 0.85em, weight: "bold", fill: badge_color)[#label : ] +
    text(size: 0.85em, fill: badge_color)[#value]
  )
}

#let role_icon(role) = {
  let r = lower(role)
  if r.contains("pilotage")     { "🎯" }
  else if r.contains("veille")  { "👁" }
  else if r.contains("diagnostic") or r.contains("modulation") { "🔬" }
  else                          { "📌" }
}

// ── Page de titre catalogue ───────────────────────────────────────
#let page_titre(title, subtitle, author, date: none, logo: none) = {
  page(
    margin: (top: 40mm, bottom: 30mm, left: 30mm, right: 30mm),
    header: none,
    footer: none,
  )[
    #if logo != none {
      align(right, image(logo, width: 40mm))
      v(1em)
    }

    #block(width: 100%, height: 4pt, fill: color_orange)
    #v(3em)

    #align(left)[
      #text(size: 2.4em, weight: "bold", fill: color_orange)[#title]
      #v(0.6em)
      #text(size: 1.3em, fill: color_grey)[#subtitle]
      #v(0.4em)
      #line(length: 60%, stroke: 1pt + color_orange)
      #v(1.2em)
      #text(size: 1em, fill: color_grey)[#author]
      #if date != none {
        v(0.2em)
        text(size: 0.9em, fill: color_grey)[#date]
      }
    ]

    #align(bottom)[
      #block(width: 100%, height: 3pt, fill: color_grey)
      #v(0.5em)
      #text(size: 8pt, fill: color_grey)[
        Observatoire de l'environnement en Nouvelle-Calédonie. OEIL \
        12 rue Tourville 98800 Nouméa — Tél. / Fax : 23 69 69 —
        #link("http://www.oeil.nc")[www.oeil.nc]
      ]
    ]
  ]
}
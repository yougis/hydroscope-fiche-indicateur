// ═══════════════════════════════════════════════════════════════
// TEMPLATE TYPST — OEIL Nouvelle-Calédonie
// Reproduction du design LaTeX in-header.tex
// ═══════════════════════════════════════════════════════════════

// ── Couleurs (identiques au LaTeX) ───────────────────────────────
#let color_orange = rgb(227, 108, 10)   // titres section
#let color_grey   = rgb(128, 128, 128)  // titres subsection + footer
#let color_purple = rgb(102, 0, 102)    // titres subsubsection
#let color_black  = rgb(0, 0, 0)
#let head_color   = rgb(250, 192, 144)  // en-tête orange clair

// ── Couleurs fiches indicateurs ───────────────────────────────────
#let pilotage_color   = rgb("#005596")
#let veille_color     = rgb("#2E7D32")
#let diag_color       = rgb("#546E7A")
#let fiche_vision_bg  = rgb(244, 249, 255)
#let fiche_alert_bg   = rgb(255, 247, 214)
#let fiche_alert_border = rgb(217, 165, 0)
#let fiche_bg         = rgb(251, 251, 251)
#let fiche_border     = rgb(219, 228, 235)
#let badge_bg         = rgb(238, 244, 251)
#let badge_color      = rgb(31, 59, 90)

// ── Configuration page (= geometry a4paper, margin=1in) ───────────
#set page(
  paper: "a4",
  margin: (top: 25.4mm, bottom: 25.4mm, left: 25.4mm, right: 25.4mm),

  // En-tête : aligné à droite, orange clair, 8pt (= \ohead + head_color)
  header: [
    #set text(size: 8pt, fill: head_color)
    #align(right)[OEIL — Fiches indicateurs HydroScope]
  ],

  // Pied de page : gauche = adresse, droite = numéro (= \ifoot + \ofoot*)
  footer: context [
    #set text(size: 8pt, fill: color_grey)
    #grid(
      columns: (1fr, auto),
      column-gutter: 1em,
      [
        Observatoire de l'environnement en Nouvelle-Calédonie. OEIL \
        12 rue Tourville 98800 Nouméa — Tél. / Fax : 23 69 69 \
        #link("http://www.oeil.nc")[www.oeil.nc]
      ],
      [
        #align(right, counter(page).display())
      ]
    )
  ]
)

// ── Typographie de base (= fontspec Arial) ────────────────────────
#set text(
  font: "Liberation Sans",  // équivalent métrique Arial sous Linux
  size: 11pt,
  lang: "fr",
)

#set par(justify: true, leading: 0.65em)

// ── Styles des titres (= \titleformat dans LaTeX) ─────────────────

// Section → \section : 14pt, orange, romain (I, II, III…)
#set heading(numbering: "I.1.a.")

#show heading.where(level: 1): it => {
  set text(size: 14pt, fill: color_orange, weight: "regular")
  block(above: 1.2em, below: 0.5em)[
    #counter(heading).display("I.") #it.body
  ]
}

// Subsection → \subsection : 12pt, gris
#show heading.where(level: 2): it => {
  set text(size: 12pt, fill: color_grey, weight: "regular")
  block(above: 0.9em, below: 0.4em)[
    #counter(heading).display("I.1.") #it.body
  ]
}

// Subsubsection → \subsubsection : 11pt, mauve, gras italique
#show heading.where(level: 3): it => {
  set text(size: 11pt, fill: color_purple, weight: "bold", style: "italic")
  block(above: 0.7em, below: 0.3em)[
    #counter(heading).display("I.1.a.") #it.body
  ]
}

// Paragraph → \paragraph : 11pt, noir, gras italique
#show heading.where(level: 4): it => {
  set text(size: 11pt, fill: color_black, weight: "bold", style: "italic")
  block(above: 0.6em, below: 0.25em, it.body)
}

// Subparagraph → \subparagraph : 11pt, noir, italique, indenté 2em
#show heading.where(level: 5): it => {
  set text(size: 11pt, fill: color_black, weight: "regular", style: "italic")
  block(above: 0.5em, below: 0.2em)[
    #h(2em) #it.body
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
  if r.contains("pilotage")   { "🎯" }
  else if r.contains("veille") { "👁" }
  else if r.contains("diagnostic") or r.contains("modulation") { "🔬" }
  else { "📌" }
}

// ── Page de titre catalogue ───────────────────────────────────────
#let page_titre(title, subtitle, author, date: none, logo: none) = {
  page(
    margin: (top: 40mm, bottom: 30mm, left: 30mm, right: 30mm),
    header: none,
    footer: none,
  )[
    // Logo optionnel
    #if logo != none {
      align(right, image(logo, width: 40mm))
      v(1em)
    }

    // Bande de couleur supérieure
    #block(
      width: 100%,
      height: 4pt,
      fill: color_orange,
    )
    #v(3em)

    // Titre principal
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

    // Bande de couleur inférieure
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
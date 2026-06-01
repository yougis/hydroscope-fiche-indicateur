#import "@preview/book:0.2.5": *

// Couleurs reprises de in-header.tex
#let color_orange = rgb(227, 108, 10)
#let color_grey = rgb(128, 128, 128)
#let color_purple = rgb(102, 0, 102)
#let color_black = rgb(0, 0, 0)
#let head_color = rgb(250, 192, 144)

// Couleurs fiches
#let fiche_vision_bg = rgb(244, 249, 255)
#let fiche_alert_bg = rgb(255, 247, 214)
#let fiche_alert_border = rgb(217, 165, 0)
#let fiche_bg = rgb(251, 251, 251)
#let fiche_border = rgb(231, 231, 231)
#let badge_bg = rgb(238, 244, 251)
#let badge_color = rgb(31, 59, 90)

// Configuration document
#set document(
  title: "Fiches indicateurs HydroScope",
  author: "Hugo Roussaffa"
)

#set page(
  paper: "a4",
  margin: (top: 25mm, bottom: 25mm, left: 20mm, right: 20mm),
  header: [
    #align(right, text(size: 8pt, fill: head_color, "OEIL - Fiches indicateurs"))
  ],
  footer: [
    #set align(bottom)
    #grid(
      columns: (1fr, auto),
      [
        #text(size: 8pt, fill: color_grey)[
          Observatoire de l'environnement en Nouvelle-Calédonie. OEIL \
          12 rue Tourville 98800 Nouméa - Tél. / Fax : 23 69 69 \
          #link("http://www.oeil.nc")[www.oeil.nc]
        ]
      ],
      [
        #text(size: 8pt, fill: color_grey, counter(page).display())
      ]
    )
  ]
)

#set text(font: "Calibri", size: 11pt, lang: "fr")

// Styles des titres
#show heading.where(level: 1): it => {
  set text(fill: color_orange, size: 1.8em, weight: "bold")
  block(above: 1em, below: 0.5em, it.body)
}

#show heading.where(level: 2): it => {
  set text(fill: color_grey, size: 1.3em, weight: "bold")
  block(above: 0.8em, below: 0.4em, it.body)
}

#show heading.where(level: 3): it => {
  set text(fill: color_black, size: 1.1em, weight: "bold")
  block(above: 0.6em, below: 0.3em, it.body)
}

// Fonctions utilitaires
#let fiche_box(content, bg_color: fiche_bg, border_left: fiche_border) = {
  box(
    width: 100%,
    fill: bg_color,
    stroke: (left: 6pt + border_left),
    inset: 10pt,
    radius: 6pt,
    content
  )
}

#let fiche_alert_box(content) = {
  box(
    width: 100%,
    fill: fiche_alert_bg,
    stroke: 2pt + fiche_alert_border,
    inset: 10pt,
    radius: 6pt,
    content
  )
}

#let badge(label, value) = {
  box(
    fill: badge_bg,
    stroke: 0.5pt + rgb(200, 200, 200),
    radius: 4pt,
    inset: (x: 8pt, y: 4pt),
    text(size: 0.9em, weight: "bold", fill: badge_color, label + ": ") +
    text(size: 0.9em, fill: badge_color, value)
  )
}

#let role_icon(role) = {
  if role.contains("pilotage") or role.contains("Pilotage") {
    "🎯"
  } else if role.contains("veille") or role.contains("Veille") {
    "👁"
  } else if role.contains("diagnostic") or role.contains("modulation") {
    "⚙"
  } else {
    "•"
  }
}

// Tableau de contenu
#outline(title: "Table des matières", depth: 2, indent: true)

#pagebreak()

// Les fiches seront incluses après ce template

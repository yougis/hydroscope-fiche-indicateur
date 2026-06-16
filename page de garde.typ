// ── Couleurs ────────────────────────────────────────────────────────
#let titre-color   = rgb(227, 108, 10)   // orange titre
#let grey-color    = rgb(128, 128, 128)  // gris auteur / éditeur
#let date-color    = rgb(227, 150, 70)   // orange clair date
#let version-color = rgb(102, 0, 102)    // mauve versioning

// ── Page de garde ────────────────────────────────────────────────────
#page(
  margin: 0pt,
  background: [

    // ── Image de fond (pleine page, coins arrondis) ──────────────────
    #place(top + left,
      block(
        width: 23.5cm,
        height: 16cm,
        clip: true,
        radius: 60pt,
        dx: -5.7cm,
        dy: -18.18cm,
        image(image_font_1, width: 27cm, height: 16cm, fit: "cover"),
      )
    )

    // ── Image secondaire (coin supérieur gauche, cadre blanc) ─────────
    #place(top + left,
      dx: -0.5cm,
      dy: -2.5cm,
      block(
        width: 9cm,
        height: 5.5cm,
        clip: true,
        radius: 30pt,
        stroke: 3pt + white,
        image(image_font_2, width: 10.5cm, height: 6.5cm, fit: "cover"),
      )
    )

    // ── Logo principal ────────────────────────────────────────────────
    #place(top + left,
      dx: 12.5cm - 2.25cm,   // centré sur 12.5cm (width/2 = 2.25cm)
      dy: -4.8cm,
      image(logo, width: 4.5cm, height: 5.5cm),
    )

    // ── Logo partenaire ───────────────────────────────────────────────
    #place(top + left,
      dx: 12.5cm - 3.5cm,    // centré sur 12.5cm (width/2 = 3.5cm)
      dy: -5cm,
      image(logo_partenaire, width: 7cm, height: 1.5cm),
    )
  ],
)[

  // ── Versioning (aligné à droite) ────────────────────────────────────
  #pad(left: 12cm, right: 1cm, top: 0.5cm,
    text(size: 10pt, fill: version-color)[#version]
  )

  // ── Titre, sous-titre, auteur, date ─────────────────────────────────
  #pad(left: 0.5cm, right: 1cm, top: 2.2cm,
    stack(dir: ttb, spacing: 0pt,
      text(size: 16pt, fill: titre-color)[#title \ ],
      text(size: 10pt, fill: titre-color)[#subtitle \ ],
      text(size: 12pt, fill: grey-color)[#author \ #publisher \ ],
      text(size: 12pt, fill: date-color)[#date \ ],
    )
  )

  // ── Diffusion ────────────────────────────────────────────────────────
  #pad(left: -0.4cm, right: 1cm, top: 3.4cm,
    text(size: 11pt, fill: version-color)[
      \ #diffusion \ Nouvelle-Calédonie \
    ]
  )
]
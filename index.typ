// Chapter-based numbering for books with appendix support
#let equation-numbering = it => {
  let pattern = if state("appendix-state", none).get() != none { "(A.1)" } else { "(1.1)" }
  numbering(pattern, counter(heading).get().first(), it)
}
#let callout-numbering = it => {
  let pattern = if state("appendix-state", none).get() != none { "A.1" } else { "1.1" }
  numbering(pattern, counter(heading).get().first(), it)
}
#let subfloat-numbering(n-super, subfloat-idx) = {
  let chapter = counter(heading).get().first()
  let pattern = if state("appendix-state", none).get() != none { "A.1a" } else { "1.1a" }
  numbering(pattern, chapter, n-super, subfloat-idx)
}
// Theorem configuration for theorion
// Chapter-based numbering (H1 = chapters)
#let theorem-inherited-levels = 1

// Appendix-aware theorem numbering
#let theorem-numbering(loc) = {
  if state("appendix-state", none).at(loc) != none { "A.1" } else { "1.1" }
}

// Theorem render function
// Note: brand-color is not available at this point in template processing
#let theorem-render(prefix: none, title: "", full-title: auto, body) = {
  block(
    width: 100%,
    inset: (left: 1em),
    stroke: (left: 2pt + black),
  )[
    #if full-title != "" and full-title != auto and full-title != none {
      strong[#full-title]
      linebreak()
    }
    #body
  ]
}
// Some definitions presupposed by pandoc's typst output.
#let content-to-string(content) = {
  if content.has("text") {
    content.text
  } else if content.has("children") {
    content.children.map(content-to-string).join("")
  } else if content.has("body") {
    content-to-string(content.body)
  } else if content == [ ] {
    " "
  }
}

#let horizontalrule = line(start: (25%,0%), end: (75%,0%))

#let endnote(num, contents) = [
  #stack(dir: ltr, spacing: 3pt, super[#num], contents)
]

#show terms.item: it => block(breakable: false)[
  #text(weight: "bold")[#it.term]
  #block(inset: (left: 1.5em, top: -0.4em))[#it.description]
]

// Some quarto-specific definitions.

#show raw.where(block: true): set block(
    fill: luma(230),
    width: 100%,
    inset: 8pt,
    radius: 2pt
  )

#let block_with_new_content(old_block, new_content) = {
  let fields = old_block.fields()
  let _ = fields.remove("body")
  if fields.at("below", default: none) != none {
    // TODO: this is a hack because below is a "synthesized element"
    // according to the experts in the typst discord...
    fields.below = fields.below.abs
  }
  block.with(..fields)(new_content)
}

#let empty(v) = {
  if type(v) == str {
    // two dollar signs here because we're technically inside
    // a Pandoc template :grimace:
    v.matches(regex("^\\s*$")).at(0, default: none) != none
  } else if type(v) == content {
    if v.at("text", default: none) != none {
      return empty(v.text)
    }
    for child in v.at("children", default: ()) {
      if not empty(child) {
        return false
      }
    }
    return true
  }

}

// Subfloats
// This is a technique that we adapted from https://github.com/tingerrr/subpar/
#let quartosubfloatcounter = counter("quartosubfloatcounter")

#let quarto_super(
  kind: str,
  caption: none,
  label: none,
  supplement: str,
  position: none,
  subcapnumbering: "(a)",
  body,
) = {
  context {
    let figcounter = counter(figure.where(kind: kind))
    let n-super = figcounter.get().first() + 1
    set figure.caption(position: position)
    [#figure(
      kind: kind,
      supplement: supplement,
      caption: caption,
      {
        show figure.where(kind: kind): set figure(numbering: _ => {
          let subfloat-idx = quartosubfloatcounter.get().first() + 1
          subfloat-numbering(n-super, subfloat-idx)
        })
        show figure.where(kind: kind): set figure.caption(position: position)

        show figure: it => {
          let num = numbering(subcapnumbering, n-super, quartosubfloatcounter.get().first() + 1)
          show figure.caption: it => block({
            num.slice(2) // I don't understand why the numbering contains output that it really shouldn't, but this fixes it shrug?
            [ ]
            it.body
          })

          quartosubfloatcounter.step()
          it
          counter(figure.where(kind: it.kind)).update(n => n - 1)
        }

        quartosubfloatcounter.update(0)
        body
      }
    )#label]
  }
}

// callout rendering
// this is a figure show rule because callouts are crossreferenceable
#show figure: it => {
  if type(it.kind) != str {
    return it
  }
  let kind_match = it.kind.matches(regex("^quarto-callout-(.*)")).at(0, default: none)
  if kind_match == none {
    return it
  }
  let kind = kind_match.captures.at(0, default: "other")
  kind = upper(kind.first()) + kind.slice(1)
  // now we pull apart the callout and reassemble it with the crossref name and counter

  // when we cleanup pandoc's emitted code to avoid spaces this will have to change
  let old_callout = it.body.children.at(1).body.children.at(1)
  let old_title_block = old_callout.body.children.at(0)
  let children = old_title_block.body.body.children
  let old_title = if children.len() == 1 {
    children.at(0)  // no icon: title at index 0
  } else {
    children.at(1)  // with icon: title at index 1
  }

  // TODO use custom separator if available
  // Use the figure's counter display which handles chapter-based numbering
  // (when numbering is a function that includes the heading counter)
  let callout_num = it.counter.display(it.numbering)
  let new_title = if empty(old_title) {
    [#kind #callout_num]
  } else {
    [#kind #callout_num: #old_title]
  }

  let new_title_block = block_with_new_content(
    old_title_block,
    block_with_new_content(
      old_title_block.body,
      if children.len() == 1 {
        new_title  // no icon: just the title
      } else {
        children.at(0) + new_title  // with icon: preserve icon block + new title
      }))

  align(left, block_with_new_content(old_callout,
    block(below: 0pt, new_title_block) +
    old_callout.body.children.at(1)))
}

// 2023-10-09: #fa-icon("fa-info") is not working, so we'll eval "#fa-info()" instead
#let callout(body: [], title: "Callout", background_color: rgb("#dddddd"), icon: none, icon_color: black, body_background_color: white) = {
  block(
    breakable: false, 
    fill: background_color, 
    stroke: (paint: icon_color, thickness: 0.5pt, cap: "round"), 
    width: 100%, 
    radius: 2pt,
    block(
      inset: 1pt,
      width: 100%, 
      below: 0pt, 
      block(
        fill: background_color,
        width: 100%,
        inset: 8pt)[#if icon != none [#text(icon_color, weight: 900)[#icon] ]#title]) +
      if(body != []){
        block(
          inset: 1pt, 
          width: 100%, 
          block(fill: body_background_color, width: 100%, inset: 8pt, body))
      }
    )
}

// Margin layout support using marginalia package
#import "@preview/marginalia:0.3.1" as marginalia: note, notefigure, wideblock

// Render footnote as margin note using standard footnote counter
// Used via show rule: #show footnote: it => column-sidenote(it.body)
// The footnote element already steps the counter, so we just display it
#let column-sidenote(body) = {
  context {
    let num = counter(footnote).display("1")
    // Superscript mark in text
    super(num)
    // Content in margin with matching number
    note(
      alignment: "baseline",
      shift: auto,
      counter: none,  // We display our own number from footnote counter
    )[
      #super(num) #body
    ]
  }
}

// Note: Margin citations are now emitted directly from Lua as #note() calls
// with #cite(form: "full") + locator text, preserving citation locators.

// Utility: compute padding for each side based on side parameter
#let side-pad(side, left-amount, right-amount) = {
  let l = if side == "both" or side == "left" or side == "inner" { left-amount } else { 0pt }
  let r = if side == "both" or side == "right" or side == "outer" { right-amount } else { 0pt }
  (left: l, right: r)
}

// body-outset: extends ~15% into margin area
#let column-body-outset(side: "both", body) = context {
  let r = marginalia.get-right()
  let out = 0.15 * (r.sep + r.width)
  pad(..side-pad(side, -out, -out), body)
}

// page-inset: wideblock minus small inset from page boundary
#let column-page-inset(side: "both", body) = context {
  let l = marginalia.get-left()
  let r = marginalia.get-right()
  // Inset is a small fraction of the extension area (wideblock stops at far)
  let left-inset = 0.15 * l.sep
  let right-inset = 0.15 * (r.sep + r.width)
  wideblock(side: side)[#pad(..side-pad(side, left-inset, right-inset), body)]
}

// screen-inset: full width minus `far` distance from edges
#let column-screen-inset(side: "both", body) = context {
  let l = marginalia.get-left()
  let r = marginalia.get-right()
  wideblock(side: side)[#pad(..side-pad(side, l.far, r.far), body)]
}

// screen-inset-shaded: screen-inset with gray background
#let column-screen-inset-shaded(body) = context {
  let l = marginalia.get-left()
  wideblock(side: "both")[
    #block(fill: luma(245), width: 100%, inset: (x: l.far, y: 1em), body)
  ]
}



#let article(
  title: none,
  subtitle: none,
  authors: none,
  keywords: (),
  date: none,
  abstract-title: none,
  abstract: none,
  thanks: none,
  cols: 1,
  lang: "en",
  region: "US",
  font: none,
  fontsize: 11pt,
  title-size: 1.5em,
  subtitle-size: 1.25em,
  heading-family: none,
  heading-weight: "bold",
  heading-style: "normal",
  heading-color: black,
  heading-line-height: 0.65em,
  mathfont: none,
  codefont: none,
  linestretch: 1,
  sectionnumbering: none,
  linkcolor: none,
  citecolor: none,
  filecolor: none,
  toc: false,
  toc_title: none,
  toc_depth: none,
  toc_indent: 1.5em,
  doc,
) = {
  // Set document metadata for PDF accessibility
  set document(title: title, keywords: keywords)
  set document(
    author: authors.map(author => content-to-string(author.name)).join(", ", last: " & "),
  ) if authors != none and authors != ()
  set par(
    justify: true,
    leading: linestretch * 0.65em
  )
  set text(lang: lang,
           region: region,
           size: fontsize)
  set text(font: font) if font != none
  show math.equation: set text(font: mathfont) if mathfont != none
  show raw: set text(font: codefont) if codefont != none

  set heading(numbering: sectionnumbering)

  show link: set text(fill: rgb(content-to-string(linkcolor))) if linkcolor != none
  show ref: set text(fill: rgb(content-to-string(citecolor))) if citecolor != none
  show link: this => {
    if filecolor != none and type(this.dest) == label {
      text(this, fill: rgb(content-to-string(filecolor)))
    } else {
      text(this)
    }
   }

  let has-title-block = title != none or (authors != none and authors != ()) or date != none or abstract != none
  if has-title-block {
    place(
      top,
      float: true,
      scope: "parent",
      clearance: 4mm,
      block(below: 1em, width: 100%)[

        #if title != none {
          align(center, block(inset: 2em)[
            #set par(leading: heading-line-height) if heading-line-height != none
            #set text(font: heading-family) if heading-family != none
            #set text(weight: heading-weight)
            #set text(style: heading-style) if heading-style != "normal"
            #set text(fill: heading-color) if heading-color != black

            #text(size: title-size)[#title #if thanks != none {
              footnote(thanks, numbering: "*")
              counter(footnote).update(n => n - 1)
            }]
            #(if subtitle != none {
              parbreak()
              text(size: subtitle-size)[#subtitle]
            })
          ])
        }

        #if authors != none and authors != () {
          let count = authors.len()
          let ncols = calc.min(count, 3)
          grid(
            columns: (1fr,) * ncols,
            row-gutter: 1.5em,
            ..authors.map(author =>
                align(center)[
                  #author.name \
                  #author.affiliation \
                  #author.email
                ]
            )
          )
        }

        #if date != none {
          align(center)[#block(inset: 1em)[
            #date
          ]]
        }

        #if abstract != none {
          block(inset: 2em)[
          #text(weight: "semibold")[#abstract-title] #h(1em) #abstract
          ]
        }
      ]
    )
  }

  if toc {
    let title = if toc_title == none {
      auto
    } else {
      toc_title
    }
    block(above: 0em, below: 2em)[
    #outline(
      title: toc_title,
      depth: toc_depth,
      indent: toc_indent
    );
    ]
  }

  doc
}

#set table(
  inset: 6pt,
  stroke: none
)
#let brand-color = (
  background: rgb("#ddeaf1"),
  blue: rgb("#ddeaf1"),
  dark-grey: rgb("#222222"),
  foreground: rgb("#222222"),
  primary: black
)
#let brand-color-background = (
  background: color.mix((brand-color.background, 15%), (brand-color.background, 85%)),
  blue: color.mix((brand-color.blue, 15%), (brand-color.background, 85%)),
  dark-grey: color.mix((brand-color.dark-grey, 15%), (brand-color.background, 85%)),
  foreground: color.mix((brand-color.foreground, 15%), (brand-color.background, 85%)),
  primary: color.mix((brand-color.primary, 15%), (brand-color.background, 85%))
)
#set page(fill: brand-color.background)
#set text(fill: brand-color.foreground)
#set table.hline(stroke: (paint: brand-color.foreground))
#set line(stroke: (paint: brand-color.foreground))
#let brand-logo = (
  medium: (
    path: "logo_yapuka.png"
  )
)
#set text()
#show heading: set text(font: ("Jura",), )
#show link: set text(fill: black, )

#set page(
  paper: "us-letter",
  // Margins handled by marginalia.setup in typst-show.typ AFTER book.with()
  numbering: "1",
  columns: 1,
)
// Logo is handled by orange-book's cover page, not as a page background
// NOTE: marginalia.setup is called in typst-show.typ AFTER book.with()
// to ensure marginalia's margins override the book format's default margins
#import "@preview/orange-book:0.7.1": book, part, chapter, appendices

#show: book.with(
  title: [Fiches indicateurs HydroScope],
  subtitle: [Catalogue des indicateurs de suivi et de comparaison des unités de gestion AEP],
  author: "Hugo Roussaffa",
  date: "1 juin 2026",
  lang: "fr",
  main-color: brand-color.at("primary", default: blue),
  logo: {
    let logo-info = brand-logo.at("medium", default: none)
    if logo-info != none { image(logo-info.path, alt: logo-info.at("alt", default: none)) }
  },
  outline-depth: 1,
  padded-heading-number: false,
)

// Configure marginalia page geometry for book context
// Geometry computed by Quarto's meta.lua filter (typstGeometryFromPaperWidth)
// IMPORTANT: This must come AFTER book.with() to override the book format's margin settings
#import "@preview/marginalia:0.3.1" as marginalia

#show: marginalia.setup.with(
  inner: (
    far: 5mm,
    width: 2in,
    sep: 0.25in,
  ),
  outer: (
    far: 5mm,
    width: 2in,
    sep: 0.25in,
  ),
  top: 1.25in,
  bottom: 1.25in,
  // CRITICAL: Enable book mode for recto/verso awareness
  book: true,
  clearance: 8pt,
)

// Reset Quarto's custom figure counters at each chapter (level-1 heading).
// Orange-book only resets kind:image and kind:table, but Quarto uses custom kinds.
// This list is generated dynamically from crossref.categories.
#show heading.where(level: 1): it => {
  counter(figure.where(kind: "quarto-float-fig")).update(0)
  counter(figure.where(kind: "quarto-float-tbl")).update(0)
  counter(figure.where(kind: "quarto-float-lst")).update(0)
  counter(figure.where(kind: "quarto-callout-Note")).update(0)
  counter(figure.where(kind: "quarto-callout-Warning")).update(0)
  counter(figure.where(kind: "quarto-callout-Caution")).update(0)
  counter(figure.where(kind: "quarto-callout-Tip")).update(0)
  counter(figure.where(kind: "quarto-callout-Important")).update(0)
  counter(math.equation).update(0)
  it
}

= Fiches indicateurs HydroScope
<fiches-indicateurs-hydroscope>
#strong[Catalogue des indicateurs de suivi et de comparaison des unités de gestion AEP]

Version 0.2 --- 01/06/2026

#strong[Historique des versions du document :]

#table(
  columns: (5.77%, 15.38%, 21.15%, 57.69%),
  align: (auto,auto,auto,auto,),
  table.header([Version], [Date], [Auteur(s)], [Description des modifications],),
  table.hline(),
  [0.1], [2026-05-18], [Hugo Roussaffa], [Rédaction initiale des fiches indicateurs],
)
Les fiches indicateurs présentées dans ce catalogue sont destinées à fournir une description détaillée de chaque indicateur de suivi et de comparaison des captages AEP. Chaque fiche comprend une identification claire de l'indicateur, des sections détaillées sur les méthodes de calcul, les modalités de visualisation, ainsi que les sources de données qui lui sont associées.

#horizontalrule

= Glossaire des attributs
<glossaire-des-attributs>
#strong[Contraintes] : Limites ou incertitudes liées à la donnée

#strong[Couverture spatiale] : Couverture spatiale de la donnée

#strong[Discret ou continu] : Nature des valeurs

#strong[Disponibilité] : Disponibilité de la donnée

#strong[Distributeur] : Distributeur de la ressource

#strong[Définition de la criticité] : Lien entre la valeur et le niveau de criticité

#strong[Famille] : Nature de l'indicateur permettant de comprendre son rôle

#strong[Identifiant de la ressource] : Identifiant unique de la ressource dans le cadre du projet Hydroscope

#strong[Identifiant de l'indicateur] : Identifiant unique de l'indicateur dans le cadre du projet Hydroscope

#strong[Implantation] : Type d'implantation visuelle sur la carte

#strong[Modalités de traitement] : Règles de traitement et d'agrégation des données

#strong[Méthode de normalisation] : Méthode pour ramener les valeurs sur une échelle commune

#strong[Nature des données] : Type de donnée

#strong[Nom de l'indicateur] : Nom court compréhensible pour identifier rapidement l'indicateur

#strong[Objectif] : But de l'indicateur dans la prise de décision

#strong[Origine] : Origine de la donnée utilisée

#strong[Pondération] : Indique si l'indicateur est utilisé dans la pondération multicritère

#strong[Priorité] : L'indicateur est il considéré comme essentiel au projet

#strong[Période d actualisation] : Fréquence de mise à jour de la donnée

#strong[Relatif ou absolu] : Type de mesure (valeur brute ou ratio)

#strong[Représentation cartographique] : Mode d'affichage

#strong[Sens de l'indicateur] : Indique si une valeur élevée est quelque chose de positif ou de négatif pour le captage

#strong[Spatialisation H3] : Indique si l'indicateur est calculé sur une maille fine H3

#strong[Support spatial] : Entité spatiale à laquelle l'indicateur est directement rattaché

#strong[Thématique] : Grande catégorie permettant de regrouper les indicateurs

#strong[Type de source] : Format de la donnée

#strong[Unité] : Unité ou classe de mesure permettant de lire correctement la valeur

#strong[URL] : URL d'accès à la ressource

== Synthèse des thèmes
<synthèse-des-thèmes>
#table(
  columns: (25%, 25%, 25%, 25%),
  align: (auto,auto,auto,auto,),
  table.header([Thème], [Famille], [Objectif], [Rôle analyse],),
  table.hline(),
  [Enjeux AEP], [Enjeux AEP], [Identifier les ressources dont la défaillance impacterait le plus grand nombre d\'habitants ou le plus important linéaire d\'infrastructures de distribution.], [Pilotage],
  [Enjeux Environnementaux], [Enjeux Environnementaux], [Repérer les bassins versants inscrits dans des périmètres de reconnaissance mondiale ou locale (UNESCO, aires protégées) nécessitant une gestion exemplaire.], [Veille],
  [Pressions Anthropiques], [Pressions Anthropiques], [Recenser les implantations industrielles (ICPE) ou minières pouvant générer des pollutions accidentelles ou chroniques.], [Pilotage],
  [Pressions Environnementales], [Pressions Environnementales], [Identifier les bassins dont l\'équilibre écologique a été rompu par des événements destructeurs comme les incendies.], [Veille],
  [Pressions Qualitatives], [Pressions Qualitatives], [Identifier les captages dont la qualité de l\'eau est dégradée afin de prioriser les actions de gestion ou de protection.], [Pilotage],
  [Pressions Quantitatives], [Pressions Quantitatives], [Identifier les situations de déséquilibre entre les besoins humains et l\'eau disponible en croisant les prélèvements réels et le diagnostic de déficit.], [Pilotage],
  [Vulnérabilité Intrinsèque], [Vulnérabilité Intrinsèque], [Qualifier la propension naturelle du terrain à laisser circuler les polluants vers les eaux souterraines ou superficielles selon ses propriétés géologiques.], [Diagnostic & Modulation],
)
== Synthèse des groupes et objectifs
<synthèse-des-groupes-et-objectifs>
#table(
  columns: (20%, 20%, 20%, 20%, 20%),
  align: (auto,auto,auto,auto,auto,),
  table.header([Groupe], [Thème], [Objectif], [Rôle], [Indicateurs],),
  table.hline(),
  [Poids stratégique de la desserte], [Enjeux AEP], [Identifier les ressources dont la défaillance impacterait le plus grand nombre d\'habitants ou le plus important linéaire d\'infrastructures de distribution.], [Pilotage], [Longueur réseau, Population desservie],
  [Robustesse et résilience technique], [Enjeux AEP], [Évaluer la capacité de production en période sèche et la présence de dispositifs de secours (stockage, interconnexion) pour garantir la continuité du service.], [Pilotage], [Capacité de production, Capacité réservoir, Interconnexion],
  [Sécurisation sanitaire et réglementaire], [Enjeux AEP], [Mesurer le niveau de conformité administrative (AODPE) et de protection physique (PPE/Traitement) pour identifier les risques d\'exposition aux pollutions.], [], [Traitement, Statut AODPE, Statut PPE],
  [Vulnérabilité technique et contexte], [Enjeux AEP], [Différencier les ressources selon leur nature (ouvrage) et leur usage actuel pour affiner la comparaison entre les points d\'eau.], [Diagnostic & Modulation], [Type ouvrage, Statut captage],
  [Valeur patrimoniale et réglementaire], [Enjeux Environnementaux], [Repérer les bassins versants inscrits dans des périmètres de reconnaissance mondiale ou locale (UNESCO, aires protégées) nécessitant une gestion exemplaire.], [Veille], [Zones UNESCO, Zones protégées provinciales],
  [Richesse biologique et rareté], [Enjeux Environnementaux], [Localiser les zones de biodiversité critique (KBA, espèces menacées) qui dépendent du maintien de la qualité de la ressource en eau.], [Veille], [KBA / ZICO, Espèces menacées, Espèces menacées (Forêt sèche)],
  [État écologique et rôle protecteur], [Enjeux Environnementaux], [Qualifier l\'intégrité de la couverture végétale naturelle agissant comme un filtre et un régulateur naturel contre le ruissellement.], [Diagnostic & Modulation], [Occupation sol (couvert végétal), Occupation sol (couvert forestier)],
  [Activités à risque], [Pressions Anthropiques], [Recenser les implantations industrielles (ICPE) ou minières pouvant générer des pollutions accidentelles ou chroniques.], [Pilotage], [ICPE, Activité minière],
  [Niveau d\'artificialisation et densité], [Pressions Anthropiques], [Quantifier l\'emprise du bâti et de l\'habitat pour évaluer la pression directe exercée par l\'occupation humaine sur le milieu.], [Veille], [Urbanisation, Habitations],
  [Infrastructures et risques de dégradation des eaux], [Pressions Anthropiques], [Identifier les points de contact entre les réseaux de transport et le milieu hydrographique pour localiser les zones à risque de pollution (ruissellement routier, accidents) et de dégradation de la qualité des cours d\'eau (sédimentation, modification des écoulements)], [Veille], [Franchissements, Linéaire routes],
  [Perturbations majeures du milieu (Aléa)], [Pressions Environnementales], [Identifier les bassins dont l\'équilibre écologique a été rompu par des événements destructeurs comme les incendies.], [Veille], [Incendies cumulés, Espèces exotiques envahissantes (EEE)],
  [Fragilité des sols et transferts (chronique)], [Pressions Environnementales], [Détecter les zones de sols nus ou instables qui favorisent le transport de sédiments et de polluants vers les points de captage.], [Veille], [Occupation sol (surfaces agricoles), Surface érosion, Terrain nu, Glissement terrain],
  [État sanitaire et suivi de la qualité], [Pressions Qualitatives], [Identifier les captages dont la qualité de l\'eau est dégradée afin de prioriser les actions de gestion ou de protection.], [Pilotage], [Qualité eau],
  [Tension des usages], [Pressions Quantitatives], [Identifier les situations de déséquilibre entre les besoins humains et l\'eau disponible en croisant les prélèvements réels et le diagnostic de déficit.], [Pilotage], [BBR, AODPE nombre, AODPE volume],
  [Apports naturels], [Pressions Quantitatives], [Contextualiser la ressource disponible (pluie, nappes).], [Veille], [Pluviométrie, Niveau nappes],
  [Sensibilité naturelle], [Vulnérabilité Intrinsèque], [Qualifier la propension naturelle du terrain à laisser circuler les polluants vers les eaux souterraines ou superficielles selon ses propriétés géologiques.], [Diagnostic & Modulation], [Vulnérabilité intrinsèque des eaux souterraines, Géologie],
)

#horizontalrule

== Sommaire des fiches par famille
<sommaire-des-fiches-par-famille>
=== Enjeu
<enjeu>
- #link("fiches/1.qmd")[Capacité de production]
- #link("fiches/2.qmd")[Longueur réseau]
- #link("fiches/3.qmd")[Capacité réservoir]
- #link("fiches/4.qmd")[Traitement]
- #link("fiches/5.qmd")[Interconnexion]
- #link("fiches/6.qmd")[Population desservie]
- #link("fiches/7.qmd")[Statut AODPE]
- #link("fiches/8.qmd")[Statut PPE]
- #link("fiches/9.qmd")[Type ouvrage]
- #link("fiches/10.qmd")[Statut captage]
- #link("fiches/100.qmd")[Zones UNESCO]
- #link("fiches/101.qmd")[Zones protégées provinciales]
- #link("fiches/102.qmd")[KBA / ZICO]
- #link("fiches/103.qmd")[Espèces menacées]
- #link("fiches/104.qmd")[Espèces menacées (Forêt sèche)]
- #link("fiches/105.qmd")[Occupation sol (couvert végétal)]
- #link("fiches/106.qmd")[Occupation sol (couvert forestier)]
- #link("fiches/107.qmd")[Occupation sol (surfaces agricoles)]

=== Pression
<pression>
- #link("fiches/200.qmd")[Incendies cumulés]
- #link("fiches/201.qmd")[Surface érosion]
- #link("fiches/202.qmd")[Terrain nu]
- #link("fiches/203.qmd")[Glissement terrain]
- #link("fiches/204.qmd")[Espèces exotiques envahissantes (EEE)]
- #link("fiches/300.qmd")[ICPE]
- #link("fiches/301.qmd")[Activité minière]
- #link("fiches/302.qmd")[Urbanisation]
- #link("fiches/304.qmd")[Habitations]
- #link("fiches/305.qmd")[Franchissements]
- #link("fiches/306.qmd")[Linéaire routes]
- #link("fiches/500.qmd")[BBR]
- #link("fiches/501.qmd")[Pluviométrie]
- #link("fiches/502.qmd")[Niveau nappes]
- #link("fiches/503.qmd")[AODPE nombre]
- #link("fiches/504.qmd")[AODPE volume]
- #link("fiches/505.qmd")[Qualité eau]

=== Vulnérabilité
<vulnérabilité>
- #link("fiches/400.qmd")[IDPR]
- #link("fiches/401.qmd")[Géologie]
- #link("fiches/402.qmd")[Vulnérabilité intrinsèque des eaux souterraines]

= Capacité de production
<capacité-de-production>
Fiche indicateur n°1

\
#block[
#block[
#block[
= Capacité de production
<capacité-de-production-1>
#strong[Thème :] Enjeux AEP \
#strong[Famille :] Enjeu

]
#block[
Fiche n°1

]
]
#block[
#block[
== Vision stratégique
<vision-stratégique>
🎯 #strong[Pilotage]

Guide la mise en conformité légale et les actions de protection réglementaire.

#block[
- #strong[Groupe :] Robustesse et résilience technique
- #strong[Objectif groupe :] Évaluer la capacité de production en période sèche et la présence de dispositifs de secours (stockage, interconnexion) pour garantir la continuité du service.

]
]
#block[
== Contexte technique
<contexte-technique>
- #strong[Support spatial :] Captage
- #strong[Pondération :] Oui
- #strong[Spatialisation H3 :] Non
- #strong[Nature des données :] Quantitatif

]
#block[
== Analyse & criticité
<analyse-criticité>
#strong[Objectif] \
Comparer la capacité des captages à fournir de l'eau en période contrainte (sécheresse, inondation, glissement de terrain) afin d'identifier les ressources les plus robustes ou les plus limitées.

#strong[Normalisation] \
Classes 3 niveaux (quantiles ou seuils métier)

#strong[Sens de l'indicateur] \
Positif (absence = critique / plus = mieux) ↑

#strong[Définition de la criticité] \
Faible capacité = forte criticité (vulnérable), forte capacité = faible criticité

]
#block[
== Vigilance expert
<vigilance-expert>
#strong[Redondance] #emph[R1] \
La Pluviométrie est jugée redondante avec la Capacité de production, car une baisse de pluie se traduit déjà par une baisse de débit mesurée au captage \[1, 2\].

]
#block[
== Sources & fiabilité
<sources-fiabilité>
#block[
#block[
#strong[Hydrométrie -- Stations DAVAR / Bassins versants aux limnimètres]

#strong[Origine :] DAVAR \
#strong[Distributeur :] GEOREP \
#strong[Couverture spatiale :] Nouvelle-calédonie \
#strong[Actualisation :] inconnu \
#strong[Disponibilité :] Disponible \
#link("https://georep-dtsi-sgt.opendata.arcgis.com/maps/01ed729cd25a4927823a228a9770b2b3")[Accéder à la ressource]

Métadonnées stations de jaugeage et limnimètres DAVAR

]
]
]
]
= Longueur réseau
<longueur-réseau>
Fiche indicateur n°2

\
#block[
#block[
#block[
= Longueur réseau
<longueur-réseau-1>
#strong[Thème :] Enjeux AEP \
#strong[Famille :] Enjeu

]
#block[
Fiche n°2

]
]
#block[
#block[
== Vision stratégique
<vision-stratégique-1>
🎯 #strong[Pilotage]

Définit les priorités d\'investissement et l\'importance socio-économique de la ressource.

#block[
- #strong[Groupe :] Poids stratégique de la desserte
- #strong[Objectif groupe :] Identifier les ressources dont la défaillance impacterait le plus grand nombre d\'habitants ou le plus important linéaire d\'infrastructures de distribution.

]
]
#block[
== Contexte technique
<contexte-technique-1>
- #strong[Support spatial :] UD
- #strong[Pondération :] Oui
- #strong[Spatialisation H3 :] Non
- #strong[Nature des données :] Quantitatif

]
#block[
== Analyse & criticité
<analyse-criticité-1>
#strong[Objectif] \
Comparer l'importance des infrastructures dépendantes de chaque captage afin d'identifier ceux dont la défaillance aurait le plus d'impact.

#strong[Normalisation] \
Classes 3 niveaux

#strong[Sens de l'indicateur] \
Positif (absence = critique / plus = mieux) ↑

#strong[Définition de la criticité] \
Plus le réseau est long, plus les enjeux sont élevés → criticité stratégique élevée

]
#block[
== Vigilance expert
<vigilance-expert-1>
#strong[Incohérence] #emph[R8] \
Risque de doublons ou de sur-comptage si plusieurs captages sont rattachés à une même Unité de Distribution (UD) pour le réseau, les réservoirs ou la population \[10, 11\].

]
#block[
== Sources & fiabilité
<sources-fiabilité-1>
#block[
#block[
#strong[unité de distribution (nom à vérifier)]

#strong[Origine :] DASS \
#strong[Actualisation :] inconnu \
#strong[Disponibilité :] Interne \
Données DASS à vocation administrative interne -- contacter DASS

]
]
]
]
= Capacité réservoir
<capacité-réservoir>
Fiche indicateur n°3

\
#block[
#block[
#block[
= Capacité réservoir
<capacité-réservoir-1>
#strong[Thème :] Enjeux AEP \
#strong[Famille :] Enjeu

]
#block[
Fiche n°3

]
]
#block[
#block[
== Vision stratégique
<vision-stratégique-2>
🎯 #strong[Pilotage]

Guide la mise en conformité légale et les actions de protection réglementaire.

#block[
- #strong[Groupe :] Robustesse et résilience technique
- #strong[Objectif groupe :] Évaluer la capacité de production en période sèche et la présence de dispositifs de secours (stockage, interconnexion) pour garantir la continuité du service.

]
]
#block[
== Contexte technique
<contexte-technique-2>
- #strong[Support spatial :] UD
- #strong[Pondération :] Oui
- #strong[Spatialisation H3 :] Non
- #strong[Nature des données :] Quantitatif

]
#block[
== Analyse & criticité
<analyse-criticité-2>
#strong[Objectif] \
Comparer la capacité de stockage associée aux captages afin d'identifier les systèmes les plus résilients face aux aléas.

#strong[Normalisation] \
Classes 3 niveaux

#strong[Sens de l'indicateur] \
Positif (absence = critique / plus = mieux) ↑

#strong[Définition de la criticité] \
Faible stockage = forte criticité (manque résilience), fort stockage = faible criticité

]
#block[
== Vigilance expert
<vigilance-expert-2>
#strong[Incohérence] #emph[R8] \
Risque de doublons ou de sur-comptage si plusieurs captages sont rattachés à une même Unité de Distribution (UD) pour le réseau, les réservoirs ou la population \[10, 11\].

]
#block[
== Sources & fiabilité
<sources-fiabilité-2>
#block[
#block[
#strong[unité de distribution (nom à vérifier)]

#strong[Origine :] DASS \
#strong[Actualisation :] inconnu \
#strong[Disponibilité :] Interne \
Données DASS à vocation administrative interne -- contacter DASS

]
]
]
]
= Traitement
<traitement>
Fiche indicateur n°4

\
#block[
#block[
#block[
= Traitement
<traitement-1>
#strong[Thème :] Enjeux AEP \
#strong[Famille :] Enjeu

]
#block[
Fiche n°4

]
]
#block[
#block[
== Vision stratégique
<vision-stratégique-3>
• #strong[Point de pilotage]

#block[
- #strong[Groupe :] Sécurisation sanitaire et réglementaire
- #strong[Objectif groupe :] Mesurer le niveau de conformité administrative (AODPE) et de protection physique (PPE/Traitement) pour identifier les risques d\'exposition aux pollutions.

]
]
#block[
== Contexte technique
<contexte-technique-3>
- #strong[Support spatial :] UD
- #strong[Pondération :] Oui
- #strong[Spatialisation H3 :] Non
- #strong[Nature des données :] Qualitatif

]
#block[
== Analyse & criticité
<analyse-criticité-3>
#strong[Objectif] \
Comparer le niveau de sécurisation sanitaire des captages afin d'identifier ceux présentant des risques pour l'alimentation en eau potable.

#strong[Normalisation] \
Catégoriel mappé (1-3)

#strong[Sens de l'indicateur] \
Positif (absence = critique / plus = mieux) ↑

#strong[Définition de la criticité] \
Absence de traitement = criticité forte (bien que si des traitements sont fait c'est que la ressource est déjà impactée par des polluants), traitement complet = criticité faible

]
#block[
== Sources & fiabilité
<sources-fiabilité-3>
#block[
#block[
#strong[unité de distribution (nom à vérifier)]

#strong[Origine :] DASS \
#strong[Actualisation :] inconnu \
#strong[Disponibilité :] Interne \
Données DASS à vocation administrative interne -- contacter DASS

]
]
]
]
= Interconnexion
<interconnexion>
Fiche indicateur n°5

\
#block[
#block[
#block[
= Interconnexion
<interconnexion-1>
#strong[Thème :] Enjeux AEP \
#strong[Famille :] Enjeu

]
#block[
Fiche n°5

]
]
#block[
#block[
== Vision stratégique
<vision-stratégique-4>
🎯 #strong[Pilotage]

Guide la mise en conformité légale et les actions de protection réglementaire.

#block[
- #strong[Groupe :] Robustesse et résilience technique
- #strong[Objectif groupe :] Évaluer la capacité de production en période sèche et la présence de dispositifs de secours (stockage, interconnexion) pour garantir la continuité du service.

]
]
#block[
== Contexte technique
<contexte-technique-4>
- #strong[Support spatial :] UD
- #strong[Pondération :] Non
- #strong[Spatialisation H3 :] Non
- #strong[Nature des données :] Qualitatif

]
#block[
== Analyse & criticité
<analyse-criticité-4>
#strong[Objectif] \
Comparer le niveau de dépendance des captages à une ressource unique afin d'identifier ceux pouvant bénéficier d'un captage de secours.

#strong[Normalisation] \
Binaire (1 & 3)

#strong[Sens de l'indicateur] \
Positif (absence = critique / plus = mieux) ↑

#strong[Définition de la criticité] \
Absence d'interconnexion = forte criticité (pas de secours), présence = criticité faible (à confirmer)

]
#block[
== Vigilance expert
<vigilance-expert-3>
#strong[Incohérence] #emph[R6] \
Le sens de l\'Interconnexion n\'est pas tranché : elle peut être vue comme un secours (positif) ou comme un vecteur de propagation de pollution (négatif) \[8\].

]
#block[
== Sources & fiabilité
<sources-fiabilité-4>
#block[
#block[
#strong[unité de distribution (nom à vérifier)]

#strong[Origine :] DASS \
#strong[Actualisation :] inconnu \
#strong[Disponibilité :] Interne \
Données DASS à vocation administrative interne -- contacter DASS

]
]
]
]
= Population desservie
<population-desservie>
Fiche indicateur n°6

\
#block[
#block[
#block[
= Population desservie
<population-desservie-1>
#strong[Thème :] Enjeux AEP \
#strong[Famille :] Enjeu

]
#block[
Fiche n°6

]
]
#block[
#block[
== Vision stratégique
<vision-stratégique-5>
🎯 #strong[Pilotage]

Définit les priorités d\'investissement et l\'importance socio-économique de la ressource.

#block[
- #strong[Groupe :] Poids stratégique de la desserte
- #strong[Objectif groupe :] Identifier les ressources dont la défaillance impacterait le plus grand nombre d\'habitants ou le plus important linéaire d\'infrastructures de distribution.

]
]
#block[
== Contexte technique
<contexte-technique-5>
- #strong[Support spatial :] UD
- #strong[Pondération :] Oui
- #strong[Spatialisation H3 :] Non
- #strong[Nature des données :] Quantitatif

]
#block[
== Analyse & criticité
<analyse-criticité-5>
#strong[Objectif] \
Comparer les captages selon le nombre de personnes dépendantes afin d'identifier les ressources les plus stratégiques pour l'alimentation en eau.

#strong[Normalisation] \
Classes 3 niveaux

#strong[Sens de l'indicateur] \
Négatif (plus = enjeu fort) ↓

#strong[Définition de la criticité] \
Plus la population est élevée, plus le captage est stratégique → criticité élevée

]
#block[
== Vigilance expert
<vigilance-expert-4>
#strong[Incohérence] #emph[R8] \
Risque de doublons ou de sur-comptage si plusieurs captages sont rattachés à une même Unité de Distribution (UD) pour le réseau, les réservoirs ou la population \[10, 11\].

]
#block[
== Sources & fiabilité
<sources-fiabilité-5>
#block[
#block[
#strong[unité de distribution (nom à vérifier)]

#strong[Origine :] DASS \
#strong[Actualisation :] inconnu \
#strong[Disponibilité :] Interne \
Données DASS à vocation administrative interne -- contacter DASS

]
]
]
]
= Statut AODPE
<statut-aodpe>
Fiche indicateur n°7

\
#block[
#block[
#block[
= Statut AODPE
<statut-aodpe-1>
#strong[Thème :] Enjeux AEP \
#strong[Famille :] Enjeu

]
#block[
Fiche n°7

]
]
#block[
#block[
== Vision stratégique
<vision-stratégique-6>
• #strong[Point de pilotage]

#block[
- #strong[Groupe :] Sécurisation sanitaire et réglementaire
- #strong[Objectif groupe :] Mesurer le niveau de conformité administrative (AODPE) et de protection physique (PPE/Traitement) pour identifier les risques d\'exposition aux pollutions.

]
]
#block[
== Contexte technique
<contexte-technique-6>
- #strong[Support spatial :] Captage
- #strong[Pondération :] Oui
- #strong[Spatialisation H3 :] Non
- #strong[Nature des données :] Qualitatif

]
#block[
== Analyse & criticité
<analyse-criticité-6>
#strong[Objectif] \
Comparer les captages selon leur niveau de conformité réglementaire afin d'identifier les situations à risque.

#strong[Normalisation] \
Binaire (1 & 3)

#strong[Sens de l'indicateur] \
Positif (non conforme = critique) ↑

#strong[Définition de la criticité] \
Absence d'autorisation = criticité forte (non conformité)

]
#block[
== Sources & fiabilité
<sources-fiabilité-6>
#block[
#block[
#strong[AODPE]

#strong[Origine :] DAVAR \
#strong[Distributeur :] GEOREP \
#strong[Couverture spatiale :] Nouvelle-calédonie \
#strong[Actualisation :] inconnu \
#strong[Disponibilité :] A vérifier \
Données administratives DAVAR -- contacter DAVAR

]
]
]
]
= Statut PPE
<statut-ppe>
Fiche indicateur n°8

\
#block[
#block[
#block[
= Statut PPE
<statut-ppe-1>
#strong[Thème :] Enjeux AEP \
#strong[Famille :] Enjeu

]
#block[
Fiche n°8

]
]
#block[
#block[
== Vision stratégique
<vision-stratégique-7>
• #strong[Point de pilotage]

#block[
- #strong[Groupe :] Sécurisation sanitaire et réglementaire
- #strong[Objectif groupe :] Mesurer le niveau de conformité administrative (AODPE) et de protection physique (PPE/Traitement) pour identifier les risques d\'exposition aux pollutions.

]
]
#block[
== Contexte technique
<contexte-technique-7>
- #strong[Support spatial :] Captage
- #strong[Pondération :] Oui
- #strong[Spatialisation H3 :] Non
- #strong[Nature des données :] Qualitatif

]
#block[
== Analyse & criticité
<analyse-criticité-7>
#strong[Objectif] \
Comparer les captages selon leur niveau de protection afin d'identifier ceux les plus exposés aux pressions.

#strong[Normalisation] \
Catégoriel mappé (1-3)

#strong[Sens de l'indicateur] \
Négatif (non protégé = critique) ↓

#strong[Définition de la criticité] \
Captage non protégé = forte criticité

]
#block[
== Sources & fiabilité
<sources-fiabilité-7>
#block[
#block[
#strong[Périmètres de protection des eaux]

#strong[Origine :] DAVAR \
#strong[Distributeur :] GEOREP \
#strong[Couverture spatiale :] Nouvelle-calédonie \
#strong[Actualisation :] inconnu \
#strong[Disponibilité :] Disponible \
#link("https://georep-dtsi-sgt.opendata.arcgis.com/maps/b5a303d89f2f407e8c194983c86418a7/about")[Accéder à la ressource]

Données administratives DAVAR

]
]
]
]
= Type ouvrage
<type-ouvrage>
Fiche indicateur n°9

\
#block[
#block[
#block[
= Type ouvrage
<type-ouvrage-1>
#strong[Thème :] Enjeux AEP \
#strong[Famille :] Enjeu

]
#block[
Fiche n°9

]
]
#block[
#block[
== Vision stratégique
<vision-stratégique-8>
⚙️ #strong[Diagnostic & Modulation]

Caractérise la sensibilité propre de l\'ouvrage (ex: forage vs captage superficiel).

#block[
- #strong[Groupe :] Vulnérabilité technique et contexte
- #strong[Objectif groupe :] Différencier les ressources selon leur nature (ouvrage) et leur usage actuel pour affiner la comparaison entre les points d\'eau.

]
]
#block[
== Contexte technique
<contexte-technique-8>
- #strong[Support spatial :] Captage
- #strong[Pondération :] Oui
- #strong[Spatialisation H3 :] Non
- #strong[Nature des données :] Qualitatif

]
#block[
== Analyse & criticité
<analyse-criticité-8>
#strong[Objectif] \
Comparer les captages selon leur vulnérabilité intrinsèque liée à leur nature {un captage superficiel est considéré comme plus vulnérable qu\'un forage profond dans les calculs de criticité)

#strong[Normalisation] \
Catégoriel mappé (1-3)

#strong[Sens de l'indicateur] \
Négatif (superficiel = critique) ↓

#strong[Définition de la criticité] \
Captage superficiel = plus vulnérable → criticité forte

]
#block[
== Sources & fiabilité
<sources-fiabilité-8>
#block[
#block[
#strong[Captages d\'eau]

#strong[Origine :] DAVAR \
#strong[Distributeur :] GEOREP \
#strong[Couverture spatiale :] Nouvelle-calédonie \
#strong[Actualisation :] inconnu \
#strong[Disponibilité :] Disponible \
#link("https://georep-dtsi-sgt.opendata.arcgis.com/maps/89e23d7a430b4e49b67fbd6f8a79bb7b/about")[Accéder à la ressource]

Données administratives DAVAR

]
]
]
]
= Statut captage
<statut-captage>
Fiche indicateur n°10

\
#block[
#block[
#block[
= Statut captage
<statut-captage-1>
#strong[Thème :] Enjeux AEP \
#strong[Famille :] Enjeu

]
#block[
Fiche n°10

]
]
#block[
#block[
== Vision stratégique
<vision-stratégique-9>
⚙️ #strong[Diagnostic & Modulation]

Caractérise la sensibilité propre de l\'ouvrage (ex: forage vs captage superficiel).

#block[
- #strong[Groupe :] Vulnérabilité technique et contexte
- #strong[Objectif groupe :] Différencier les ressources selon leur nature (ouvrage) et leur usage actuel pour affiner la comparaison entre les points d\'eau.

]
]
#block[
== Contexte technique
<contexte-technique-9>
- #strong[Support spatial :] Captage
- #strong[Pondération :] Non
- #strong[Spatialisation H3 :] Non
- #strong[Nature des données :] Qualitatif

]
#block[
== Analyse & criticité
<analyse-criticité-9>
#strong[Objectif] \
Distinguer les captages selon leur statut afin de contextualiser leur valeur dans la comparaison.

#strong[Normalisation] \
Catégoriel mappé (1-3)

#strong[Sens de l'indicateur] \
Neutre (info) ↔

#strong[Définition de la criticité] \
Captage actif = enjeu, secours/inactif = criticité moindre

]
#block[
== Sources & fiabilité
<sources-fiabilité-9>
#block[
#block[
#strong[Captages d\'eau]

#strong[Origine :] DAVAR \
#strong[Distributeur :] GEOREP \
#strong[Couverture spatiale :] Nouvelle-calédonie \
#strong[Actualisation :] inconnu \
#strong[Disponibilité :] Disponible \
#link("https://georep-dtsi-sgt.opendata.arcgis.com/maps/89e23d7a430b4e49b67fbd6f8a79bb7b/about")[Accéder à la ressource]

Données administratives DAVAR

]
]
]
]
= Zones UNESCO
<zones-unesco>
Fiche indicateur n°100

\
#block[
#block[
#block[
= Zones UNESCO
<zones-unesco-1>
#strong[Thème :] Enjeux Environnementaux \
#strong[Famille :] Enjeu

]
#block[
Fiche n°100

]
]
#block[
#block[
== Vision stratégique
<vision-stratégique-10>
👁️ #strong[Veille]

Assure le suivi des engagements de conservation et des contraintes réglementaires associées.

#block[
- #strong[Groupe :] Valeur patrimoniale et réglementaire
- #strong[Objectif groupe :] Repérer les bassins versants inscrits dans des périmètres de reconnaissance mondiale ou locale (UNESCO, aires protégées) nécessitant une gestion exemplaire.

]
]
#block[
== Contexte technique
<contexte-technique-10>
- #strong[Support spatial :] maille
- #strong[Pondération :] Non
- #strong[Spatialisation H3 :] Oui
- #strong[Nature des données :] Quantitatif

]
#block[
== Analyse & criticité
<analyse-criticité-10>
#strong[Objectif] \
Identifier les zones à haute valeur patrimoniale mondiale susceptibles d\'être impactées par les pressions sur la ressource en eau.

#strong[Normalisation] \
Classes 3 niveaux

#strong[Sens de l'indicateur] \
Positif (absence = critique / plus = mieux) ↑

#strong[Définition de la criticité] \
Présence d'une partie du bassin versant dans zone UNESCO = criticité faible bien que enjeu fort

]
#block[
== Sources & fiabilité
<sources-fiabilité-10>
#block[
#block[
#strong[zones inscrites au patrimoine mondial de l\'UNESCO]

#strong[Origine :] CEN \
#strong[Distributeur :] GEOREP \
#strong[Couverture spatiale :] Nouvelle-calédonie \
#strong[Actualisation :] jamais \
#strong[Disponibilité :] Disponible \
#link("https://georep-dtsi-sgt.opendata.arcgis.com/maps/e17f6c38b47a435e9e73c102a7a1b933/about")[Accéder à la ressource]

Périmètres parfois imprécis à l\'échelle locale.

]
]
]
]
= Zones protégées provinciales
<zones-protégées-provinciales>
Fiche indicateur n°101

\
#block[
#block[
#block[
= Zones protégées provinciales
<zones-protégées-provinciales-1>
#strong[Thème :] Enjeux Environnementaux \
#strong[Famille :] Enjeu

]
#block[
Fiche n°101

]
]
#block[
#block[
== Vision stratégique
<vision-stratégique-11>
👁️ #strong[Veille]

Assure le suivi des engagements de conservation et des contraintes réglementaires associées.

#block[
- #strong[Groupe :] Valeur patrimoniale et réglementaire
- #strong[Objectif groupe :] Repérer les bassins versants inscrits dans des périmètres de reconnaissance mondiale ou locale (UNESCO, aires protégées) nécessitant une gestion exemplaire.

]
]
#block[
== Contexte technique
<contexte-technique-11>
- #strong[Support spatial :] maille
- #strong[Pondération :] Non
- #strong[Spatialisation H3 :] Oui
- #strong[Nature des données :] Quantitatif

]
#block[
== Analyse & criticité
<analyse-criticité-11>
#strong[Objectif] \
Caractériser le niveau de protection réglementaire du milieu naturel autour des ressources en eau.

#strong[Normalisation] \
Classes 3 niveaux

#strong[Sens de l'indicateur] \
Positif (absence = critique / plus = mieux) ↑

#strong[Définition de la criticité] \
Présence en zone protégée = criticité faible bien que enjeu fort

]
#block[
== Sources & fiabilité
<sources-fiabilité-11>
#block[
#block[
#strong[Aires protégées de la Province Sud]

#strong[Origine :] PSUD \
#strong[Distributeur :] PSUD \
#strong[Couverture spatiale :] Province Sud \
#strong[Actualisation :] inconnu \
#strong[Disponibilité :] Disponible \
Aires terrestres protégées à compiler depuis les sources des 3 provinces

]
#block[
#strong[Aires protégées de la Province Nord]

#strong[Origine :] PNORD \
#strong[Distributeur :] PNORD \
#strong[Couverture spatiale :] Province Nord \
#strong[Actualisation :] inconnu \
#strong[Disponibilité :] Disponible \
Aires terrestres protégées à compiler depuis les sources des 3 provinces

]
#block[
#strong[Aires protégées de la Province des Iles]

#strong[Origine :] PIL \
#strong[Distributeur :] PIL \
#strong[Couverture spatiale :] Province des Iles \
#strong[Actualisation :] inconnu \
#strong[Disponibilité :] A vérifier \
Aires terrestres protégées à compiler depuis les sources des 3 provinces

]
]
]
]
= KBA / ZICO
<kba-zico>
Fiche indicateur n°102

\
#block[
#block[
#block[
= KBA / ZICO
<kba-zico-1>
#strong[Thème :] Enjeux Environnementaux \
#strong[Famille :] Enjeu

]
#block[
Fiche n°102

]
]
#block[
#block[
== Vision stratégique
<vision-stratégique-12>
👁️ #strong[Veille]

Surveille l\'état des écosystèmes sensibles dépendants de la ressource en eau.

#block[
- #strong[Groupe :] Richesse biologique et rareté
- #strong[Objectif groupe :] Localiser les zones de biodiversité critique (KBA, espèces menacées) qui dépendent du maintien de la qualité de la ressource en eau.

]
]
#block[
== Contexte technique
<contexte-technique-12>
- #strong[Support spatial :] maille
- #strong[Pondération :] Non
- #strong[Spatialisation H3 :] Oui
- #strong[Nature des données :] Quantitatif

]
#block[
== Analyse & criticité
<analyse-criticité-12>
#strong[Objectif] \
Identifier les zones à forte valeur écologique (Key Biodiversity Areas, Zones Importantes pour la Conservation des Oiseaux).

#strong[Normalisation] \
Classes 3 niveaux

#strong[Sens de l'indicateur] \
Positif (absence = critique / plus = mieux) ↑

#strong[Définition de la criticité] \
Présence en KBA/ZICO = criticité faible bien que enjeu fort

]
#block[
== Sources & fiabilité
<sources-fiabilité-12>
#block[
#block[
#strong[Zones clés de biodiversité (KBA -- Key Biodiversity Areas)]

#strong[Origine :] CEN \
#strong[Distributeur :] GEOREP \
#strong[Couverture spatiale :] Nouvelle-calédonie \
#strong[Actualisation :] jamais \
#strong[Disponibilité :] Disponible \
#link("https://georep-dtsi-sgt.opendata.arcgis.com/maps/934b1cad2b9045d8ac2c4d7b0a524f2e/about")[Accéder à la ressource]

Standards UICN

]
]
]
]
= Espèces menacées
<espèces-menacées>
Fiche indicateur n°103

\
#block[
#block[
#block[
= Espèces menacées
<espèces-menacées-1>
#strong[Thème :] Enjeux Environnementaux \
#strong[Famille :] Enjeu

]
#block[
Fiche n°103

]
]
#block[
#block[
== Vision stratégique
<vision-stratégique-13>
👁️ #strong[Veille]

Surveille l\'état des écosystèmes sensibles dépendants de la ressource en eau.

#block[
- #strong[Groupe :] Richesse biologique et rareté
- #strong[Objectif groupe :] Localiser les zones de biodiversité critique (KBA, espèces menacées) qui dépendent du maintien de la qualité de la ressource en eau.

]
]
#block[
== Contexte technique
<contexte-technique-13>
- #strong[Support spatial :] maille
- #strong[Pondération :] Non
- #strong[Spatialisation H3 :] Oui
- #strong[Nature des données :] Quantitatif

]
#block[
== Analyse & criticité
<analyse-criticité-13>
#strong[Objectif] \
Mesurer la richesse spécifique menacée dépendante de la ressource en eau.

#strong[Normalisation] \
Classes 3 niveaux

#strong[Sens de l'indicateur] \
Positif (absence = critique / plus = mieux) ↑

#strong[Définition de la criticité] \
Forte richesse en espèces menacées = criticité faible bien que enjeu fort (à confirmer)

]
#block[
== Sources & fiabilité
<sources-fiabilité-13>
#block[
#block[
#strong[Espèces rares et menacées (nom à vérifier)]

#strong[Origine :] Endemia \
#strong[Distributeur :] ENDEMIA \
#strong[Couverture spatiale :] Nouvelle-calédonie \
#strong[Actualisation :] inconnu \
#strong[Disponibilité :] Disponible \
Couche espèces menacées non publiée sur GéoRep -- consulter directement ENDEMIA

]
]
]
]
= Espèces menacées (Forêt sèche)
<espèces-menacées-forêt-sèche>
Fiche indicateur n°104

\
#block[
#block[
#block[
= Espèces menacées (Forêt sèche)
<espèces-menacées-forêt-sèche-1>
#strong[Thème :] Enjeux Environnementaux \
#strong[Famille :] Enjeu

]
#block[
Fiche n°104

]
]
#block[
#block[
== Vision stratégique
<vision-stratégique-14>
👁️ #strong[Veille]

Surveille l\'état des écosystèmes sensibles dépendants de la ressource en eau.

#block[
- #strong[Groupe :] Richesse biologique et rareté
- #strong[Objectif groupe :] Localiser les zones de biodiversité critique (KBA, espèces menacées) qui dépendent du maintien de la qualité de la ressource en eau.

]
]
#block[
== Contexte technique
<contexte-technique-14>
- #strong[Support spatial :] maille
- #strong[Pondération :] Non
- #strong[Spatialisation H3 :] Oui
- #strong[Nature des données :] Quantitatif

]
#block[
== Analyse & criticité
<analyse-criticité-14>
#strong[Objectif] \
Identifier la présence de forêt sèche, écosystème endémique parmi les plus menacés de Nouvelle-Calédonie.

#strong[Normalisation] \
Classes 3 niveaux

#strong[Sens de l'indicateur] \
Négatif (absence = critique)~? ↓

#strong[Définition de la criticité] \
Présence de forêt sèche = criticité faible bien que enjeu fort (à confirmer)

]
#block[
== Sources & fiabilité
<sources-fiabilité-14>
#block[
#block[
#strong[Forêt sèche -- Indices de vulnérabilité]

#strong[Origine :] CEN \
#strong[Distributeur :] GEOREP \
#strong[Couverture spatiale :] Nouvelle-calédonie \
#strong[Actualisation :] inconnu \
#strong[Disponibilité :] Disponible \
#link("https://georep-dtsi-sgt.opendata.arcgis.com/maps/b9304b72009f45e6aa4fc2fab702e98b")[Accéder à la ressource]

Cartographie partielle selon les provinces.

]
]
]
]
= Occupation sol (couvert végétal)
<occupation-sol-couvert-végétal>
Fiche indicateur n°105

\
#block[
#block[
#block[
= Occupation sol (couvert végétal)
<occupation-sol-couvert-végétal-1>
#strong[Thème :] Enjeux Environnementaux \
#strong[Famille :] Enjeu

]
#block[
Fiche n°105

]
]
#block[
#block[
== Vision stratégique
<vision-stratégique-15>
⚙️ #strong[Diagnostic & Modulation]

Mesure la capacité naturelle du milieu à protéger la ressource par filtration.

#block[
- #strong[Groupe :] État écologique et rôle protecteur
- #strong[Objectif groupe :] Qualifier l\'intégrité de la couverture végétale naturelle agissant comme un filtre et un régulateur naturel contre le ruissellement.

]
]
#block[
== Contexte technique
<contexte-technique-15>
- #strong[Support spatial :] maille
- #strong[Pondération :] Oui
- #strong[Spatialisation H3 :] Oui
- #strong[Nature des données :] Quantitatif

]
#block[
== Analyse & criticité
<analyse-criticité-15>
#strong[Objectif] \
Caractériser la présence de couvert végétal comme indicateur de bon état écologique du milieu.

#strong[Normalisation] \
Classes 3 niveaux

#strong[Sens de l'indicateur] \
Positif (plus = mieux) ↑

#strong[Définition de la criticité] \
Fort couvert végétal = faible criticité

]
#block[
== Vigilance expert
<vigilance-expert-5>
#strong[Redondance] #emph[R7] \
Utilisation concurrente de plusieurs sources (MOS, TMF, Dynamic World) pour le couvert végétal et le sol nu

]
#block[
== Sources & fiabilité
<sources-fiabilité-15>
#block[
Aucune source de donnée identifiée.

]
]
]
= Occupation sol (couvert forestier)
<occupation-sol-couvert-forestier>
Fiche indicateur n°106

\
#block[
#block[
#block[
= Occupation sol (couvert forestier)
<occupation-sol-couvert-forestier-1>
#strong[Thème :] Enjeux Environnementaux \
#strong[Famille :] Enjeu

]
#block[
Fiche n°106

]
]
#block[
#block[
== Vision stratégique
<vision-stratégique-16>
⚙️ #strong[Diagnostic & Modulation]

Mesure la capacité naturelle du milieu à protéger la ressource par filtration.

#block[
- #strong[Groupe :] État écologique et rôle protecteur
- #strong[Objectif groupe :] Qualifier l\'intégrité de la couverture végétale naturelle agissant comme un filtre et un régulateur naturel contre le ruissellement.

]
]
#block[
== Contexte technique
<contexte-technique-16>
- #strong[Support spatial :] maille
- #strong[Pondération :] Oui
- #strong[Spatialisation H3 :] Oui
- #strong[Nature des données :] Quantitatif

]
#block[
== Analyse & criticité
<analyse-criticité-16>
#strong[Objectif] \
Évaluer l\'état de la couverture forestière, protectrice de la ressource en eau.

#strong[Normalisation] \
Classes 3 niveaux

#strong[Sens de l'indicateur] \
Positif (plus = mieux) ↑

#strong[Définition de la criticité] \
Fort couvert forestier = faible criticité

]
#block[
== Vigilance expert
<vigilance-expert-6>
#strong[Redondance] #emph[R7] \
Utilisation concurrente de plusieurs sources (MOS, TMF, Dynamic World) pour le couvert végétal et le sol nu

]
#block[
== Sources & fiabilité
<sources-fiabilité-16>
#block[
#block[
#strong[Cartographie des surfaces forestières de Nouvelle-Calédonie]

#strong[Origine :] TMF \
#strong[Distributeur :] GEE \
#strong[Couverture spatiale :] Nouvelle-calédonie \
#strong[Actualisation :] 1 an \
#strong[Disponibilité :] Disponible \
#link("https://forobs.jrc.ec.europa.eu/TMF")[Accéder à la ressource]

Utilisation de la donnée sans les classes des dynamiques

]
]
]
]
= Occupation sol (surfaces agricoles)
<occupation-sol-surfaces-agricoles>
Fiche indicateur n°107

\
#block[
#block[
#block[
= Occupation sol (surfaces agricoles)
<occupation-sol-surfaces-agricoles-1>
#strong[Thème :] Enjeux Environnementaux \
#strong[Famille :] Enjeu

]
#block[
Fiche n°107

]
]
#block[
#block[
== Vision stratégique
<vision-stratégique-17>
👁️ #strong[Veille]

Assure la surveillance de la dégradation structurelle et lente des sols.

#block[
- #strong[Groupe :] Fragilité des sols et transferts (chronique)
- #strong[Objectif groupe :] Détecter les zones de sols nus ou instables qui favorisent le transport de sédiments et de polluants vers les points de captage.

]
]
#block[
== Contexte technique
<contexte-technique-17>
- #strong[Support spatial :] maille
- #strong[Pondération :] Oui
- #strong[Spatialisation H3 :] Oui
- #strong[Nature des données :] Quantitatif

]
#block[
== Analyse & criticité
<analyse-criticité-17>
#strong[Objectif] \
Mesurer l\'emprise agricole, source potentielle de pression sur la qualité et la quantité de la ressource.

#strong[Normalisation] \
Classes 3 niveaux

#strong[Sens de l'indicateur] \
Négatif (plus = critique) ↓

#strong[Définition de la criticité] \
Forte surface agricole = pression potentielle élevée

]
#block[
== Sources & fiabilité
<sources-fiabilité-17>
#block[
Aucune source de donnée identifiée.

]
]
]
= Incendies cumulés
<incendies-cumulés>
Fiche indicateur n°200

\
#block[
#block[
#block[
= Incendies cumulés
<incendies-cumulés-1>
#strong[Thème :] Pressions Environnementales \
#strong[Famille :] Pression

]
#block[
Fiche n°200

]
]
#block[
#block[
== Vision stratégique
<vision-stratégique-18>
👁️ #strong[Veille]

Permet une réaction rapide face aux chocs brutaux impactant le bassin versant.

#block[
- #strong[Groupe :] Perturbations majeures du milieu (Aléa)
- #strong[Objectif groupe :] Identifier les bassins dont l\'équilibre écologique a été rompu par des événements destructeurs comme les incendies.

]
]
#block[
== Contexte technique
<contexte-technique-18>
- #strong[Support spatial :] maille
- #strong[Pondération :] Oui
- #strong[Spatialisation H3 :] Oui
- #strong[Nature des données :] Quantitatif

]
#block[
== Analyse & criticité
<analyse-criticité-18>
#strong[Objectif] \
Comparer les bassins versants selon leur historique d'incendies afin d'identifier les milieux les perturbés.

#strong[Normalisation] \
Classes 3 niveaux

#strong[Sens de l'indicateur] \
Négatif (plus = critique) ↓

#strong[Définition de la criticité] \
Forte surface brûlée = forte pression → criticité élevée

]
#block[
== Sources & fiabilité
<sources-fiabilité-18>
#block[
#block[
#strong[Zones potentiellement brulées (VIIRS)]

#strong[Origine :] OEIL \
#strong[Distributeur :] OEIL \
#strong[Couverture spatiale :] Nouvelle-calédonie \
#strong[Actualisation :] Tous les jours \
#strong[Disponibilité :] Disponible \
#link("https://geoportail.oeil.nc/geoportal/catalog/search/resource/details.page?uuid=%7B5D28AFE1-541C-4102-84F0-6959F769FA78%7D")[Accéder à la ressource]

Surfaces potentiellement brûlées VIIRS depuis 2012. Il n'existe pas de source officielle qui fusionne les 2 capteurs VIIRS (SUOMI et JPSS)

]
]
]
]
= Surface érosion
<surface-érosion>
Fiche indicateur n°201

\
#block[
#block[
#block[
= Surface érosion
<surface-érosion-1>
#strong[Thème :] Pressions Environnementales \
#strong[Famille :] Pression

]
#block[
Fiche n°201

]
]
#block[
#block[
== Vision stratégique
<vision-stratégique-19>
👁️ #strong[Veille]

Assure la surveillance de la dégradation structurelle et lente des sols.

#block[
- #strong[Groupe :] Fragilité des sols et transferts (chronique)
- #strong[Objectif groupe :] Détecter les zones de sols nus ou instables qui favorisent le transport de sédiments et de polluants vers les points de captage.

]
]
#block[
== Contexte technique
<contexte-technique-19>
- #strong[Support spatial :] maille
- #strong[Pondération :] Oui
- #strong[Spatialisation H3 :] Oui
- #strong[Nature des données :] Quantitatif

]
#block[
== Analyse & criticité
<analyse-criticité-19>
#strong[Objectif] \
Comparer les bassins versants selon leur sensibilité à l'érosion afin d'identifier les ressources exposées à des dégradations du milieu.

#strong[Normalisation] \
Classes 3 niveaux

#strong[Sens de l'indicateur] \
Négatif (plus = critique) ↓

#strong[Définition de la criticité] \
Plus de sol nu = plus d'érosion → criticité élevée

]
#block[
== Vigilance expert
<vigilance-expert-7>
#strong[Redondance] #emph[R9] \
Risque de données non homogènes si l\'on croise la \"Surface érosion\" de l\'OEIL avec le \"Terrain nu\" issu du MOS

]
#block[
== Sources & fiabilité
<sources-fiabilité-19>
#block[
Aucune source de donnée identifiée.

]
]
]
= Terrain nu
<terrain-nu>
Fiche indicateur n°202

\
#block[
#block[
#block[
= Terrain nu
<terrain-nu-1>
#strong[Thème :] Pressions Environnementales \
#strong[Famille :] Pression

]
#block[
Fiche n°202

]
]
#block[
#block[
== Vision stratégique
<vision-stratégique-20>
👁️ #strong[Veille]

Assure la surveillance de la dégradation structurelle et lente des sols.

#block[
- #strong[Groupe :] Fragilité des sols et transferts (chronique)
- #strong[Objectif groupe :] Détecter les zones de sols nus ou instables qui favorisent le transport de sédiments et de polluants vers les points de captage.

]
]
#block[
== Contexte technique
<contexte-technique-20>
- #strong[Support spatial :] maille
- #strong[Pondération :] Oui
- #strong[Spatialisation H3 :] Oui
- #strong[Nature des données :] Quantitatif

]
#block[
== Analyse & criticité
<analyse-criticité-20>
#strong[Objectif] \
Comparer les bassins versants selon l'étendue des surfaces dégradées afin d'identifier les zones les plus sensibles aux ruissellementau et aux transferts de polluants.

#strong[Normalisation] \
Classes 3 niveaux

#strong[Sens de l'indicateur] \
Négatif (plus = critique) ↓

#strong[Définition de la criticité] \
Plus de sol nu = plus d'érosion → criticité élevée

]
#block[
== Vigilance expert
<vigilance-expert-8>
#strong[Redondance] #emph[R3] \
L\'Activité minière (identifiée via le MOS) peut faire doublon avec l\'indicateur Terrain nu, sur-représentant ainsi la pression physique sur le sol \[5\].

#strong[Redondance] #emph[R7] \
Utilisation concurrente de plusieurs sources (MOS, TMF, Dynamic World) pour le couvert végétal et le sol nu

#strong[Redondance] #emph[R9] \
Risque de données non homogènes si l\'on croise la \"Surface érosion\" de l\'OEIL avec le \"Terrain nu\" issu du MOS

]
#block[
== Sources & fiabilité
<sources-fiabilité-20>
#block[
#block[
#strong[Occupation du sol (dynamique world v1)]

#strong[Origine :] Dynamic World V1 \
#strong[Distributeur :] GEE \
#strong[Couverture spatiale :] Nouvelle-calédonie \
#strong[Actualisation :] 5 jours \
#strong[Disponibilité :] Disponible \
Identifier la classe correspondante sur la source et nécessite l'utilisation d'une carte de synthèse annuelle ou saisonnière

]
]
]
]
= Glissement terrain
<glissement-terrain>
Fiche indicateur n°203

\
#block[
#block[
#block[
= Glissement terrain
<glissement-terrain-1>
#strong[Thème :] Pressions Environnementales \
#strong[Famille :] Pression

]
#block[
Fiche n°203

]
]
#block[
#block[
== Vision stratégique
<vision-stratégique-21>
👁️ #strong[Veille]

Assure la surveillance de la dégradation structurelle et lente des sols.

#block[
- #strong[Groupe :] Fragilité des sols et transferts (chronique)
- #strong[Objectif groupe :] Détecter les zones de sols nus ou instables qui favorisent le transport de sédiments et de polluants vers les points de captage.

]
]
#block[
== Contexte technique
<contexte-technique-21>
- #strong[Support spatial :] maille
- #strong[Pondération :] Oui
- #strong[Spatialisation H3 :] Oui
- #strong[Nature des données :] Quantitatif

]
#block[
== Analyse & criticité
<analyse-criticité-21>
#strong[Objectif] \
Comparer les bassins versants selon leur instabilité afin d'identifier les zones à risque pour la ressource.

#strong[Normalisation] \
Classes 3 niveaux

#strong[Sens de l'indicateur] \
Négatif (plus = critique) ↓

#strong[Définition de la criticité] \
Plus de sol nu = plus d'érosion → criticité élevée

]
#block[
== Vigilance expert
<vigilance-expert-9>
#strong[Incohérence] #emph[R5] \
Le Glissement de terrain est classé en Pression mais fait débat pour un déplacement vers la famille Vulnérabilité (aléa lié à la nature du terrain) \[7\].

]
#block[
== Sources & fiabilité
<sources-fiabilité-21>
#block[
#block[
#strong[Compilation des cartographies d\'aléa mouvement de terrain communal à l\'échelle 1:25 000ème.]

#strong[Origine :] DIMENC \
#strong[Distributeur :] GEOREP \
#strong[Couverture spatiale :] 15 communes \
#strong[Actualisation :] inconnu \
#strong[Disponibilité :] Disponible \
#link("https://dtsi-sgt.maps.arcgis.com/home/item.html?id=c472c49f798046b9b2c716c83523c324")[Accéder à la ressource]

Aléa (très faible, faible, modéré, élevé)

]
]
]
]
= Espèces exotiques envahissantes (EEE)
<espèces-exotiques-envahissantes-eee>
Fiche indicateur n°204

\
#block[
#block[
#block[
= Espèces exotiques envahissantes (EEE)
<espèces-exotiques-envahissantes-eee-1>
#strong[Thème :] Pressions Environnementales \
#strong[Famille :] Pression

]
#block[
Fiche n°204

]
]
#block[
#block[
== Vision stratégique
<vision-stratégique-22>
👁️ #strong[Veille]

Permet une réaction rapide face aux chocs brutaux impactant le bassin versant.

#block[
- #strong[Groupe :] Perturbations majeures du milieu (Aléa)
- #strong[Objectif groupe :] Identifier les bassins dont l\'équilibre écologique a été rompu par des événements destructeurs comme les incendies.

]
]
#block[
== Contexte technique
<contexte-technique-22>
- #strong[Support spatial :] BV
- #strong[Pondération :] Non
- #strong[Spatialisation H3 :] Non
- #strong[Nature des données :] Quantitatif

]
#block[
== Analyse & criticité
<analyse-criticité-22>
#strong[Objectif] \
Comparer les bassins versants selon la présence d'espèces envahissantes afin d'identifier des pressions écologiques potentielles.

#strong[Normalisation] \
Classes 3 niveaux

#strong[Sens de l'indicateur] \
Négatif (plus = critique) ↓

#strong[Définition de la criticité] \
Présence forte = pression écologique élevée

]
#block[
== Sources & fiabilité
<sources-fiabilité-22>
#block[
#block[
#strong[Espèces envahissantes]

#strong[Origine :] ANCB \
#strong[Distributeur :] patrick Barrière ANCB \
#strong[Couverture spatiale :] Nouvelle-calédonie \
#strong[Actualisation :] inconnu \
#strong[Disponibilité :] Disponible \
données régionalisées par communes, avec des bilans et des résultats~de chasse

]
]
]
]
= ICPE
<icpe>
Fiche indicateur n°300

\
#block[
#block[
#block[
= ICPE
<icpe-1>
#strong[Thème :] Pressions Anthropiques \
#strong[Famille :] Pression

]
#block[
Fiche n°300

]
]
#block[
#block[
== Vision stratégique
<vision-stratégique-23>
🎯 #strong[Pilotage]

Oriente les contrôles de la police de l\'eau et la surveillance des sites industriels.

#block[
- #strong[Groupe :] Activités à risque
- #strong[Objectif groupe :] Recenser les implantations industrielles (ICPE) ou minières pouvant générer des pollutions accidentelles ou chroniques.

]
]
#block[
== Contexte technique
<contexte-technique-23>
- #strong[Support spatial :] maille
- #strong[Pondération :] Oui
- #strong[Spatialisation H3 :] Oui
- #strong[Nature des données :] Quantitatif

]
#block[
== Analyse & criticité
<analyse-criticité-23>
#strong[Objectif] \
Comparer les bassins versants selon la densité d'activités à risque afin d'identifier les sources potentielles de pollution.

#strong[Normalisation] \
Classes 3 niveaux

#strong[Sens de l'indicateur] \
Négatif (plus = critique) ↓

#strong[Définition de la criticité] \
Plus d'ICPE = risque pollution → criticité élevée

]
#block[
== Sources & fiabilité
<sources-fiabilité-23>
#block[
#block[
#strong[Installations Classées pour la Protection de l\'Environnement]

#strong[Origine :] DIMENC \
#strong[Distributeur :] GEOREP \
#strong[Couverture spatiale :] Nouvelle-calédonie \
#strong[Actualisation :] inconnu \
#strong[Disponibilité :] Disponible \
#link("https://georep-dtsi-sgt.opendata.arcgis.com/maps/c2e17ea9c2e84b158ff02c7b0f46fdc7")[Accéder à la ressource]

Peut être une compilation nécessaire avec les données des Provinces

]
#block[
#strong[Installations Classées pour la Protection de l\'Environnement de la Province Sud]

#strong[Origine :] PSUD \
#strong[Distributeur :] PSUD \
#strong[Couverture spatiale :] Province Sud \
#strong[Actualisation :] inconnu \
#strong[Disponibilité :] A vérifier \
Peut être une compilation nécessaire avec les données de la DIMENC

]
#block[
#strong[Installations Classées pour la Protection de l\'Environnement de la Province Nord]

#strong[Origine :] PNORD \
#strong[Distributeur :] PNORD \
#strong[Couverture spatiale :] Province Nord \
#strong[Actualisation :] inconnu \
#strong[Disponibilité :] A vérifier \
Peut être une compilation nécessaire avec les données de la DIMENC

]
#block[
#strong[Installations Classées pour la Protection de l\'Environnement de la Province des Iles]

#strong[Origine :] PIL \
#strong[Distributeur :] PIL \
#strong[Couverture spatiale :] Province des Iles \
#strong[Actualisation :] inconnu \
#strong[Disponibilité :] A vérifier \
Peut être une compilation nécessaire avec les données de la DIMENC

]
]
]
]
= Activité minière
<activité-minière>
Fiche indicateur n°301

\
#block[
#block[
#block[
= Activité minière
<activité-minière-1>
#strong[Thème :] Pressions Anthropiques \
#strong[Famille :] Pression

]
#block[
Fiche n°301

]
]
#block[
#block[
== Vision stratégique
<vision-stratégique-24>
🎯 #strong[Pilotage]

Oriente les contrôles de la police de l\'eau et la surveillance des sites industriels.

#block[
- #strong[Groupe :] Activités à risque
- #strong[Objectif groupe :] Recenser les implantations industrielles (ICPE) ou minières pouvant générer des pollutions accidentelles ou chroniques.

]
]
#block[
== Contexte technique
<contexte-technique-24>
- #strong[Support spatial :] maille
- #strong[Pondération :] Oui
- #strong[Spatialisation H3 :] Oui
- #strong[Nature des données :] Quantitatif

]
#block[
== Analyse & criticité
<analyse-criticité-24>
#strong[Objectif] \
Comparer les bassins versants selon l'emprise minière afin d'identifier les pressions fortes sur la ressource.

#strong[Normalisation] \
Classes 3 niveaux

#strong[Sens de l'indicateur] \
Négatif (plus = critique) ↓

#strong[Définition de la criticité] \
Surface minière élevée = pression forte → criticité élevée

]
#block[
== Vigilance expert
<vigilance-expert-10>
#strong[Redondance] #emph[R3] \
L\'Activité minière (identifiée via le MOS) peut faire doublon avec l\'indicateur Terrain nu, sur-représentant ainsi la pression physique sur le sol \[5\].

]
#block[
== Sources & fiabilité
<sources-fiabilité-24>
#block[
#block[
#strong[CARTOGRAPHIE -- OCCUPATION DES SOLS (MOS 2014 -- classes végétation)]

#strong[Origine :] OEIL/GOUV \
#strong[Distributeur :] GEOREP \
#strong[Couverture spatiale :] Nouvelle-calédonie \
#strong[Actualisation :] jamais \
#strong[Disponibilité :] Disponible \
#link("https://georep-dtsi-sgt.opendata.arcgis.com/documents/b1efecab06904c9996127a3ff5bdc586/about")[Accéder à la ressource]

MOS 2014 (24 classes niv.3) + évolution provinces Nord et Îles Loyauté

]
#block[
#strong[Exploitation minière en Nouvelle-Calédonie : centres miniers et usines métallurgiques]

#strong[Origine :] DIMENC \
#strong[Distributeur :] GEOREP \
#strong[Couverture spatiale :] Nouvelle-calédonie \
#strong[Actualisation :] inconnu \
#strong[Disponibilité :] Disponible \
#link("https://dtsi-sgt.maps.arcgis.com/home/item.html?id=4e485fd6879142d9b52fe1bcea0c2cb1")[Accéder à la ressource]

Centre minier et usine métallurgique (peut être fusionner avec les ICPE aussi~?)

]
#block[
#strong[cadastre minier actif (concessions, permis de recherches et réserves techniques provinciales) et échu]

#strong[Origine :] DIMENC \
#strong[Distributeur :] GEOREP \
#strong[Couverture spatiale :] Nouvelle-calédonie \
#strong[Actualisation :] inconnu \
#strong[Disponibilité :] Disponible \
#link("https://dtsi-sgt.maps.arcgis.com/home/item.html?id=e70295d0f4994702ad2d64e6c4156377")[Accéder à la ressource]

Cadastre des exploitations minière avec statu réglementaire

]
]
]
]
= Urbanisation
<urbanisation>
Fiche indicateur n°302

\
#block[
#block[
#block[
= Urbanisation
<urbanisation-1>
#strong[Thème :] Pressions Anthropiques \
#strong[Famille :] Pression

]
#block[
Fiche n°302

]
]
#block[
#block[
== Vision stratégique
<vision-stratégique-25>
👁️ #strong[Veille]

Suit l\'évolution de l\'empreinte humaine et de l\'imperméabilisation des sols.

#block[
- #strong[Groupe :] Niveau d\'artificialisation et densité
- #strong[Objectif groupe :] Quantifier l\'emprise du bâti et de l\'habitat pour évaluer la pression directe exercée par l\'occupation humaine sur le milieu.

]
]
#block[
== Contexte technique
<contexte-technique-25>
- #strong[Support spatial :] maille
- #strong[Pondération :] Oui
- #strong[Spatialisation H3 :] Oui
- #strong[Nature des données :] Quantitatif

]
#block[
== Analyse & criticité
<analyse-criticité-25>
#strong[Objectif] \
Comparer les bassins versants selon leur niveau d'artificialisation afin d'identifier les pressions liées aux activités humaines.

#strong[Normalisation] \
Classes 3 niveaux

#strong[Sens de l'indicateur] \
Négatif (plus = critique) ↓

#strong[Définition de la criticité] \
Plus de bâti = pression → criticité élevée

]
#block[
== Vigilance expert
<vigilance-expert-11>
#strong[Redondance] #emph[R4] \
Les Habitations (données ISEE) sont un complément du bâti (Urbanisation)

]
#block[
== Sources & fiabilité
<sources-fiabilité-25>
#block[
#block[
#strong[Localités et zones bâties]

#strong[Origine :] DITTT \
#strong[Distributeur :] GEOREP \
#strong[Couverture spatiale :] Nouvelle-calédonie \
#strong[Actualisation :] inconnu \
#strong[Disponibilité :] Disponible \
#link("https://georep-dtsi-sgt.opendata.arcgis.com/maps/10e4a961853245a38e6fb3e109f2b7d5")[Accéder à la ressource]

Couche des localités et zones bâties~: Villes, lieux-dits, tribus -- échelle 1/50 000 -- mise à jour 2022. possibilité d'obtenir la surface du bâti associé et d'un nombre d'habitant (approximatif)

]
#block[
#strong[BDTOPO-NC]

#strong[Origine :] DITTT \
#strong[Distributeur :] DITTT \
#strong[Couverture spatiale :] Nouvelle-calédonie \
#strong[Actualisation :] annuelle \
#strong[Disponibilité :] Disponible \
Données brutes de la BDTOPO. Superficie par typologie de bâti. Disponible de la données sur commande.

]
]
]
]
= Habitations
<habitations>
Fiche indicateur n°304

\
#block[
#block[
#block[
= Habitations
<habitations-1>
#strong[Thème :] Pressions Anthropiques \
#strong[Famille :] Pression

]
#block[
Fiche n°304

]
]
#block[
#block[
== Vision stratégique
<vision-stratégique-26>
👁️ #strong[Veille]

Suit l\'évolution de l\'empreinte humaine et de l\'imperméabilisation des sols.

#block[
- #strong[Groupe :] Niveau d\'artificialisation et densité
- #strong[Objectif groupe :] Quantifier l\'emprise du bâti et de l\'habitat pour évaluer la pression directe exercée par l\'occupation humaine sur le milieu.

]
]
#block[
== Contexte technique
<contexte-technique-26>
- #strong[Support spatial :] maille
- #strong[Pondération :] Oui
- #strong[Spatialisation H3 :] Oui
- #strong[Nature des données :] Quantitatif

]
#block[
== Analyse & criticité
<analyse-criticité-26>
#strong[Objectif] \
Comparer les bassins versants selon la densité d'habitat afin d'affiner l'analyse des pressions humaines.

#strong[Normalisation] \
Classes 3 niveaux

#strong[Sens de l'indicateur] \
Négatif (plus = critique) ↓

#strong[Définition de la criticité] \
Densité humaine = pression accrue

]
#block[
== Vigilance expert
<vigilance-expert-12>
#strong[Redondance] #emph[R4] \
Les Habitations (données ISEE) sont un complément du bâti (Urbanisation)

]
#block[
== Sources & fiabilité
<sources-fiabilité-26>
#block[
#block[
#strong[Typologie de l'habitat]

#strong[Origine :] ISEE \
#strong[Distributeur :] ISEE \
#strong[Couverture spatiale :] Nouvelle-calédonie \
#strong[Actualisation :] 4 ans \
#strong[Disponibilité :] Disponible \
Exploiter les données de typologie des logements ISEE non publiées sur GéoRep -- croiser avec la couche zones bâties de la BDTOPO

]
]
]
]
= Franchissements
<franchissements>
Fiche indicateur n°305

\
#block[
#block[
#block[
= Franchissements
<franchissements-1>
#strong[Thème :] Pressions Anthropiques \
#strong[Famille :] Pression

]
#block[
Fiche n°305

]
]
#block[
#block[
== Vision stratégique
<vision-stratégique-27>
👁️ #strong[Veille]

Cible les points de vigilance pour prévenir les pollutions liées au ruissellement routier.

#block[
- #strong[Groupe :] Infrastructures et risques de dégradation des eaux
- #strong[Objectif groupe :] Identifier les points de contact entre les réseaux de transport et le milieu hydrographique pour localiser les zones à risque de pollution (ruissellement routier, accidents) et de dégradation de la qualité des cours d\'eau (sédimentation, modification des écoulements)

]
]
#block[
== Contexte technique
<contexte-technique-27>
- #strong[Support spatial :] maille
- #strong[Pondération :] Oui
- #strong[Spatialisation H3 :] Oui
- #strong[Nature des données :] Quantitatif

]
#block[
== Analyse & criticité
<analyse-criticité-27>
#strong[Objectif] \
Identifier les points de franchissement (ponts, buses, gués) comme facteurs de perturbation du réseau hydrographique. Chaque pont, buse ou gué est un point où une pollution routière (hydrocarbures, transport de matières dangereuses) peut entrer directement dans le cours d\'eau en amont d\'un captage

#strong[Normalisation] \
Classes 3 niveaux

#strong[Sens de l'indicateur] \
Négatif (plus = critique) ↓

#strong[Définition de la criticité] \
Nombre élevé de franchissements = pression sur continuité écologique

]
#block[
== Sources & fiabilité
<sources-fiabilité-27>
#block[
#block[
#strong[Réseau routier BDROUTE-NC]

#strong[Origine :] DITTT \
#strong[Distributeur :] GEOREP \
#strong[Couverture spatiale :] Nouvelle-calédonie \
#strong[Actualisation :] inconnu \
#strong[Disponibilité :] Disponible \
#link("https://georep-dtsi-sgt.opendata.arcgis.com/maps/d3915082450a4405bb30dda99e19bc61")[Accéder à la ressource]

Base de données voies du territoire NC -- ouvrages franchissant l\'hydrographie

]
#block[
#strong[Franchissement du réseau hydrographique des BVAEP (nom à vérifier)]

#strong[Origine :] DAVAR \
#strong[Actualisation :] inconnu \
#strong[Disponibilité :] A vérifier \
Base de données de la DAVAR identifiant les franchissements sur le réseau hydrographique

]
]
]
]
= Linéaire routes
<linéaire-routes>
Fiche indicateur n°306

\
#block[
#block[
#block[
= Linéaire routes
<linéaire-routes-1>
#strong[Thème :] Pressions Anthropiques \
#strong[Famille :] Pression

]
#block[
Fiche n°306

]
]
#block[
#block[
== Vision stratégique
<vision-stratégique-28>
👁️ #strong[Veille]

Cible les points de vigilance pour prévenir les pollutions liées au ruissellement routier.

#block[
- #strong[Groupe :] Infrastructures et risques de dégradation des eaux
- #strong[Objectif groupe :] Identifier les points de contact entre les réseaux de transport et le milieu hydrographique pour localiser les zones à risque de pollution (ruissellement routier, accidents) et de dégradation de la qualité des cours d\'eau (sédimentation, modification des écoulements)

]
]
#block[
== Contexte technique
<contexte-technique-28>
- #strong[Support spatial :] maille
- #strong[Pondération :] Oui
- #strong[Spatialisation H3 :] Oui
- #strong[Nature des données :] Quantitatif

]
#block[
== Analyse & criticité
<analyse-criticité-28>
#strong[Objectif] \
Mesurer la densité du réseau routier comme indicateur de pression sur les milieux naturels et la ressource en eau. Une forte densité de routes et de pistes (souvent non classées et plus érosives) augmente l\'apport de sédiments dans les cours d\'eau (turbidité, engrangement) et donne l\'accès à des zones sensibles et peut potentiellement provoquer des pollutions.

#strong[Normalisation] \
Classes 3 niveaux

#strong[Sens de l'indicateur] \
Négatif (plus = critique) ↓

#strong[Définition de la criticité] \
Fort linéaire routier = fragmentation et imperméabilisation élevées

]
#block[
== Sources & fiabilité
<sources-fiabilité-28>
#block[
#block[
#strong[Réseau routier BDROUTE-NC]

#strong[Origine :] DITTT \
#strong[Distributeur :] GEOREP \
#strong[Couverture spatiale :] Nouvelle-calédonie \
#strong[Actualisation :] inconnu \
#strong[Disponibilité :] Disponible \
#link("https://georep-dtsi-sgt.opendata.arcgis.com/maps/d3915082450a4405bb30dda99e19bc61")[Accéder à la ressource]

Base de données voies du territoire NC -- ouvrages franchissant l\'hydrographie

]
]
]
]
= BBR
<bbr>
Fiche indicateur n°500

\
#block[
#block[
#block[
= BBR
<bbr-1>
#strong[Thème :] Pressions Quantitatives \
#strong[Famille :] Pression

]
#block[
Fiche n°500

]
]
#block[
#block[
== Vision stratégique
<vision-stratégique-29>
🎯 #strong[Pilotage]

Relève du pilotage : déclenche les restrictions ou les limitations de nouvelles autorisations.

#block[
- #strong[Groupe :] Tension des usages
- #strong[Objectif groupe :] Identifier les situations de déséquilibre entre les besoins humains et l\'eau disponible en croisant les prélèvements réels et le diagnostic de déficit.

]
]
#block[
== Contexte technique
<contexte-technique-29>
- #strong[Support spatial :] BV
- #strong[Pondération :] Oui
- #strong[Spatialisation H3 :] Non
- #strong[Nature des données :] Qualitatif

]
#block[
== Analyse & criticité
<analyse-criticité-29>
#strong[Objectif] \
Comparer les bassins versants selon l'équilibre ressource/besoins afin d'identifier les situations de tension ou de déficit.

#strong[Normalisation] \
Déjà normalisé (5 classes)

#strong[Sens de l'indicateur] \
Négatif (plus = critique) ↓

#strong[Définition de la criticité] \
Déficit ressource = criticité maximale

]
#block[
== Sources & fiabilité
<sources-fiabilité-29>
#block[
#block[
#strong[Bilan Besoin Ressource (nom à vérifier)]

#strong[Origine :] DAVAR \
#strong[Distributeur :] GEOREP \
#strong[Actualisation :] inconnu \
#strong[Disponibilité :] Interne \
Bilan DAVAR diffusion interne -- contacter DAVAR

]
]
]
]
= Pluviométrie
<pluviométrie>
Fiche indicateur n°501

\
#block[
#block[
#block[
= Pluviométrie
<pluviométrie-1>
#strong[Thème :] Pressions Quantitatives \
#strong[Famille :] Pression

]
#block[
Fiche n°501

]
]
#block[
#block[
== Vision stratégique
<vision-stratégique-30>
👁️ #strong[Veille]

Relève de la veille : observation du contexte climatique pour la gestion de crise.

#block[
- #strong[Groupe :] Apports naturels
- #strong[Objectif groupe :] Contextualiser la ressource disponible (pluie, nappes).

]
]
#block[
== Contexte technique
<contexte-technique-30>
- #strong[Support spatial :] maille
- #strong[Pondération :] Oui
- #strong[Spatialisation H3 :] Oui
- #strong[Nature des données :] Quantitatif

]
#block[
== Analyse & criticité
<analyse-criticité-30>
#strong[Objectif] \
Comparer les bassins versants selon les apports en eau afin de contextualiser la disponibilité de la ressource.

#strong[Normalisation] \
Classes 3 niveaux

#strong[Sens de l'indicateur] \
Positif (plus = mieux) ↑

#strong[Définition de la criticité] \
Faible pluie = forte criticité

]
#block[
== Vigilance expert
<vigilance-expert-13>
#strong[Redondance] #emph[R1] \
La Pluviométrie est jugée redondante avec la Capacité de production, car une baisse de pluie se traduit déjà par une baisse de débit mesurée au captage \[1, 2\].

]
#block[
== Sources & fiabilité
<sources-fiabilité-30>
#block[
#block[
#strong[Pluviométrie -- Stations Météo France]

#strong[Origine :] Météo France \
#strong[Distributeur :] GEOREP \
#strong[Couverture spatiale :] Nouvelle-calédonie \
#strong[Actualisation :] inconnu \
#strong[Disponibilité :] Disponible \
#link("https://georep-dtsi-sgt.opendata.arcgis.com/items/d1636f919647426f88c40548b948d790")[Accéder à la ressource]

Données stations pluviométriques Météo France NC

]
]
]
]
= Niveau nappes
<niveau-nappes>
Fiche indicateur n°502

\
#block[
#block[
#block[
= Niveau nappes
<niveau-nappes-1>
#strong[Thème :] Pressions Quantitatives \
#strong[Famille :] Pression

]
#block[
Fiche n°502

]
]
#block[
#block[
== Vision stratégique
<vision-stratégique-31>
👁️ #strong[Veille]

Relève de la veille : observation du contexte climatique pour la gestion de crise.

#block[
- #strong[Groupe :] Apports naturels
- #strong[Objectif groupe :] Contextualiser la ressource disponible (pluie, nappes).

]
]
#block[
== Contexte technique
<contexte-technique-31>
- #strong[Support spatial :] maille
- #strong[Pondération :] Oui
- #strong[Spatialisation H3 :] Non
- #strong[Nature des données :] Quantitatif

]
#block[
== Analyse & criticité
<analyse-criticité-31>
#strong[Objectif] \
Suivre l\'évolution du niveau des nappes phréatiques pour détecter les tensions quantitatives.

#strong[Normalisation] \
Classes 3 niveaux

#strong[Sens de l'indicateur] \
Positif (plus = mieux) ↑

#strong[Définition de la criticité] \
Niveau bas = forte criticité quantitative

]
#block[
== Sources & fiabilité
<sources-fiabilité-31>
#block[
#block[
#strong[Base de données du sous-sol de NC (BDSSNC) -- forages et hydrogéologie]

#strong[Origine :] DAVAR \
#strong[Distributeur :] GEOREP \
#strong[Couverture spatiale :] Nouvelle-calédonie \
#strong[Actualisation :] inconnu \
#strong[Disponibilité :] Disponible \
#link("https://georep.nc/node/1323")[Accéder à la ressource]

Informations brutes géologiques et techniques des ouvrages souterrains -- DIMENC/SGNC

]
]
]
]
= AODPE nombre
<aodpe-nombre>
Fiche indicateur n°503

\
#block[
#block[
#block[
= AODPE nombre
<aodpe-nombre-1>
#strong[Thème :] Pressions Quantitatives \
#strong[Famille :] Pression

]
#block[
Fiche n°503

]
]
#block[
#block[
== Vision stratégique
<vision-stratégique-32>
🎯 #strong[Pilotage]

Relève du pilotage : déclenche les restrictions ou les limitations de nouvelles autorisations.

#block[
- #strong[Groupe :] Tension des usages
- #strong[Objectif groupe :] Identifier les situations de déséquilibre entre les besoins humains et l\'eau disponible en croisant les prélèvements réels et le diagnostic de déficit.

]
]
#block[
== Contexte technique
<contexte-technique-32>
- #strong[Support spatial :] Captage
- #strong[Pondération :] Oui
- #strong[Spatialisation H3 :] Non
- #strong[Nature des données :] Quantitatif

]
#block[
== Analyse & criticité
<analyse-criticité-32>
#strong[Objectif] \
Comparer les captages selon le nombre de prélèvements afin d'évaluer la pression d'usage.

#strong[Normalisation] \
Classes 3 niveaux

#strong[Sens de l'indicateur] \
Négatif (plus = critique) ↓

#strong[Définition de la criticité] \
Plus de prélèvements = pression ressource

]
#block[
== Sources & fiabilité
<sources-fiabilité-32>
#block[
#block[
#strong[AODPE]

#strong[Origine :] DAVAR \
#strong[Distributeur :] GEOREP \
#strong[Couverture spatiale :] Nouvelle-calédonie \
#strong[Actualisation :] inconnu \
#strong[Disponibilité :] A vérifier \
Données administratives DAVAR -- contacter DAVAR

]
]
]
]
= AODPE volume
<aodpe-volume>
Fiche indicateur n°504

\
#block[
#block[
#block[
= AODPE volume
<aodpe-volume-1>
#strong[Thème :] Pressions Quantitatives \
#strong[Famille :] Pression

]
#block[
Fiche n°504

]
]
#block[
#block[
== Vision stratégique
<vision-stratégique-33>
🎯 #strong[Pilotage]

Relève du pilotage : déclenche les restrictions ou les limitations de nouvelles autorisations.

#block[
- #strong[Groupe :] Tension des usages
- #strong[Objectif groupe :] Identifier les situations de déséquilibre entre les besoins humains et l\'eau disponible en croisant les prélèvements réels et le diagnostic de déficit.

]
]
#block[
== Contexte technique
<contexte-technique-33>
- #strong[Support spatial :] Captage
- #strong[Pondération :] Oui
- #strong[Spatialisation H3 :] Non
- #strong[Nature des données :] Quantitatif

]
#block[
== Analyse & criticité
<analyse-criticité-33>
#strong[Objectif] \
Comparer les captages selon les volumes prélevés afin d'évaluer l'intensité de la pression quantitative.

#strong[Normalisation] \
Classes 3 niveaux

#strong[Sens de l'indicateur] \
Négatif (plus = critique) ↓

#strong[Définition de la criticité] \
Volume élevé = pression forte

]
#block[
== Sources & fiabilité
<sources-fiabilité-33>
#block[
#block[
#strong[AODPE]

#strong[Origine :] DAVAR \
#strong[Distributeur :] GEOREP \
#strong[Couverture spatiale :] Nouvelle-calédonie \
#strong[Actualisation :] inconnu \
#strong[Disponibilité :] A vérifier \
Données administratives DAVAR -- contacter DAVAR

]
]
]
]
= Qualité eau
<qualité-eau>
Fiche indicateur n°505

\
#block[
#block[
#block[
= Qualité eau
<qualité-eau-1>
#strong[Thème :] Pressions Qualitatives \
#strong[Famille :] Pression

]
#block[
Fiche n°505

]
]
#block[
#block[
== Vision stratégique
<vision-stratégique-34>
🎯 #strong[Pilotage]

Sert de diagnostic de confirmation pour valider l\'impact réel des pressions sur la ressource.

#block[
- #strong[Groupe :] État sanitaire et suivi de la qualité
- #strong[Objectif groupe :] Identifier les captages dont la qualité de l\'eau est dégradée afin de prioriser les actions de gestion ou de protection.

]
]
#block[
== Contexte technique
<contexte-technique-34>
- #strong[Support spatial :] Captage
- #strong[Pondération :] Oui
- #strong[Spatialisation H3 :] Non
- #strong[Nature des données :] Qualitatif

]
#block[
== Analyse & criticité
<analyse-criticité-34>
#strong[Objectif] \
Comparer les captages selon leur qualité afin d'identifier ceux nécessitant des actions de gestion ou de protection.

#strong[Normalisation] \
Catégoriel mappé (1-3)

#strong[Sens de l'indicateur] \
Croissant ↔

#strong[Définition de la criticité] \
Classe dégradée = criticité élevée

]
#block[
== Sources & fiabilité
<sources-fiabilité-34>
#block[
#block[
#strong[Base de données ATYA (nom à vérifier)]

#strong[Origine :] DASS \
#strong[Actualisation :] inconnu \
#strong[Disponibilité :] Interne \
Données DASS/ATYA diffusion interne -- contacter DASS

]
]
]
]
= IDPR
<idpr>
Fiche indicateur n°400

\
#block[
#block[
#block[
= IDPR
<idpr-1>
#strong[Thème :] Vulnérabilité Intrinsèque \
#strong[Famille :] Vulnérabilité

]
#block[
Fiche n°400

]
]
#block[
#block[
== Vision stratégique
<vision-stratégique-35>
• #strong[Point de pilotage]

]
#block[
== Contexte technique
<contexte-technique-35>
- #strong[Support spatial :] maille
- #strong[Pondération :] Oui
- #strong[Spatialisation H3 :] Oui
- #strong[Nature des données :] Quantitatif

]
#block[
== Analyse & criticité
<analyse-criticité-35>
#strong[Normalisation] \
Déjà normalisé (0-4)

#strong[Sens de l'indicateur] \
Négatif (plus = critique) ↓

#strong[Définition de la criticité] \
Indice élevé = forte vulnérabilité

]
#block[
== Vigilance expert
<vigilance-expert-14>
#strong[Redondance] #emph[R2] \
La Géologie présente un risque élevé de redondance avec l\'IDPR, ce dernier étant calculé à partir de données hydrologiques et géologiques \[3, 4\].

]
#block[
== Sources & fiabilité
<sources-fiabilité-35>
#block[
Aucune source de donnée identifiée.

]
]
]
= Géologie
<géologie>
Fiche indicateur n°401

\
#block[
#block[
#block[
= Géologie
<géologie-1>
#strong[Thème :] Vulnérabilité Intrinsèque \
#strong[Famille :] Vulnérabilité

]
#block[
Fiche n°401

]
]
#block[
#block[
== Vision stratégique
<vision-stratégique-36>
⚙️ #strong[Diagnostic & Modulation]

Définit le socle physique immuable qui module (amplifie ou réduit) l\'impact des pressions.

#block[
- #strong[Groupe :] Sensibilité naturelle
- #strong[Objectif groupe :] Qualifier la propension naturelle du terrain à laisser circuler les polluants vers les eaux souterraines ou superficielles selon ses propriétés géologiques.

]
]
#block[
== Contexte technique
<contexte-technique-36>
- #strong[Support spatial :] maille
- #strong[Pondération :] Oui
- #strong[Spatialisation H3 :] Oui
- #strong[Nature des données :] Quantitatif

]
#block[
== Analyse & criticité
<analyse-criticité-36>
#strong[Objectif] \
Comparer les bassins versants selon les propriétés des sols afin de qualifier leur comportement hydrologique.

#strong[Normalisation] \
Classes 3 niveaux

#strong[Sens de l'indicateur] \
Négatif (plus = critique) ↓

#strong[Définition de la criticité] \
Sols infiltrant = moins critique, ruisselants = plus critique

]
#block[
== Vigilance expert
<vigilance-expert-15>
#strong[Redondance] #emph[R2] \
La Géologie présente un risque élevé de redondance avec l\'IDPR, ce dernier étant calculé à partir de données hydrologiques et géologiques \[3, 4\].

]
#block[
== Sources & fiabilité
<sources-fiabilité-36>
#block[
#block[
#strong[Géologie au 1/200 000e -- DIMENC/SGNC-BRGM 1981]

#strong[Origine :] DIMENC \
#strong[Distributeur :] GEOREP \
#strong[Couverture spatiale :] Nouvelle-calédonie \
#strong[Actualisation :] inconnu \
#strong[Disponibilité :] Disponible \
#link("https://georep-dtsi-sgt.opendata.arcgis.com/documents/cbb272c52a0a4725a154d1be059bee17")[Accéder à la ressource]

Contours, surfaces, points et arcs structuraux géologiques

]
]
]
]
= Vulnérabilité intrinsèque des eaux souterraines
<vulnérabilité-intrinsèque-des-eaux-souterraines>
Fiche indicateur n°402

\
#block[
#block[
#block[
= Vulnérabilité intrinsèque des eaux souterraines
<vulnérabilité-intrinsèque-des-eaux-souterraines-1>
#strong[Thème :] Vulnérabilité Intrinsèque \
#strong[Famille :] Vulnérabilité

]
#block[
Fiche n°402

]
]
#block[
#block[
== Vision stratégique
<vision-stratégique-37>
⚙️ #strong[Diagnostic & Modulation]

Définit le socle physique immuable qui module (amplifie ou réduit) l\'impact des pressions.

#block[
- #strong[Groupe :] Sensibilité naturelle
- #strong[Objectif groupe :] Qualifier la propension naturelle du terrain à laisser circuler les polluants vers les eaux souterraines ou superficielles selon ses propriétés géologiques.

]
]
#block[
== Contexte technique
<contexte-technique-37>
- #strong[Support spatial :] maille
- #strong[Pondération :] Oui
- #strong[Spatialisation H3 :] Oui
- #strong[Nature des données :] Qualitatif

]
#block[
== Analyse & criticité
<analyse-criticité-37>
#strong[Objectif] \
Comparer les bassins versants selon leur vulnérabilité intrinsèque afin d'identifier les zones les plus sensibles aux transferts.

#strong[Normalisation] \
Déjà normalisé (1-5)

]
#block[
== Sources & fiabilité
<sources-fiabilité-37>
#block[
#block[
#strong[BDLISA-NC - Vulnérabilité intrinsèque des eaux souterraines (gdb)]

#strong[Origine :] DIMENC \
#strong[Distributeur :] GEOREP \
#strong[Couverture spatiale :] Nouvelle-calédonie \
#strong[Actualisation :] inconnu \
#strong[Disponibilité :] Disponible \
#link("https://georep-dtsi-sgt.opendata.arcgis.com/documents/d7ab36bb69954aea882a63993428357a/about")[Accéder à la ressource]

Base de Données des Limites Aquifères de Nouvelle-Calédonie pour la cartographie et la caractérisation hydrogéologiques des formations à l'échelle du territoire. Cette donnée traduit la vulnérabilité, elle intègre différentes pressions et caractéristiques physiques et peut servir de synthèse pour évaluer le superficiel et le souterrain.

]
]
]
]
]
]
]
]
]
]
]
]
]
]
]
]
]
]
]
]
]
]
]
]
]
]
]
]
]
]
]
]
]
]
]
]
]
]
]
]
]
]




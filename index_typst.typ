#import "template_typst.typ": *

// ─── PAGE DE COUVERTURE ──────────────────────────────────────────
#set page(margin: (x: 2cm, y: 2.5cm), header: none, footer: none)

#align(center + horizon)[
  #line(length: 40%, stroke: 3pt + color_orange)
  #v(1.5em)
  #text(size: 2.6em, weight: "bold", fill: color_orange)[Fiches indicateurs HydroScope]
  #v(1em)
  #text(size: 1.3em, style: "italic", fill: color_grey)[Catalogue des indicateurs de suivi et de comparaison des unités de gestion AEP]
  #v(2em)
  #line(length: 20%, stroke: 1pt + color_grey)
  #v(2em)
  #text(size: 1.1em, weight: "medium", fill: color_black)[]
  #v(0.6em)
  #text(size: 0.95em, fill: color_grey)[Rapport généré le 18/07/2026]
]
#pagebreak()

// ─── CONFIGURATION PAGES INTERNES ────────────────────────────────
#set page(
  paper: "a4",
  margin: (top: 2.1cm, bottom: 2.1cm, left: 2.5cm, right: 2.5cm),
  footer: context align(center,
    text(size: 8pt, fill: color_grey,
      counter(page).display("1 / 1", both: true)
    )
  ),
)

#show <masque>: it => {}
#show <masque>: it => {}
#show <masque>: it => {}

#include "fiches_typst/note_version.typ"
#text(fill: color_orange)[
  #outline(title: "Table des matières", depth: 3, indent: 1em)
]
#pagebreak()

#include "fiches_typst/glossaire.typ"
// ══════ Famille : Enjeu ══════
= Enjeu <masque> 

#include "fiches_typst/famille_enjeu_entete.typ"

// ── Thème : Enjeux AEP ──
== Enjeux AEP <masque>

#include "fiches_typst/famille_enjeu_theme_enjeux_aep_toc.typ"

=== Capacité de production <masque>

#include "fiches_typst/1.typ"
=== Population desservie <masque>

#include "fiches_typst/6.typ"
=== Statut captage <masque>

#include "fiches_typst/10.typ"
=== Établissements public sensibles <masque>

#include "fiches_typst/12.typ"
=== Longueur réseau <masque>

#include "fiches_typst/2.typ"
=== Capacité réservoir <masque>

#include "fiches_typst/3.typ"
=== Interconnexion <masque>

#include "fiches_typst/5.typ"
=== Type ouvrage <masque>

#include "fiches_typst/9.typ"
=== Traitement <masque>

#include "fiches_typst/4.typ"
=== Statut AODPE <masque>

#include "fiches_typst/7.typ"
=== Statut PPE <masque>

#include "fiches_typst/8.typ"
=== Statut du foncier <masque>

#include "fiches_typst/11.typ"

// ── Thème : Enjeux Environnementaux ──
== Enjeux Environnementaux <masque>

#include "fiches_typst/famille_enjeu_theme_enjeux_environnementaux_toc.typ"

=== Occupation sol \(couvert végétal\) <masque>

#include "fiches_typst/105.typ"
=== Occupation sol \(couvert forestier\) <masque>

#include "fiches_typst/106.typ"
=== Zones UNESCO <masque>

#include "fiches_typst/100.typ"
=== Zones protégées provinciales <masque>

#include "fiches_typst/101.typ"
=== KBA \/ ZICO <masque>

#include "fiches_typst/102.typ"
=== Espèces rares et menacées dont forêt sèche <masque>

#include "fiches_typst/104.typ"

// ══════ Famille : Menace ══════
= Menace <masque> 

#include "fiches_typst/famille_menace_entete.typ"

// ── Thème : MENACES ANTHROPIQUES ──
== MENACES ANTHROPIQUES <masque>

#include "fiches_typst/famille_menace_theme_menaces_anthropiques_toc.typ"

=== Occupation sol \(surfaces agricoles\) <masque>

#include "fiches_typst/107.typ"
=== ICPE <masque>

#include "fiches_typst/300.typ"
=== Zone d’exploitation minière <masque>

#include "fiches_typst/301.typ"
=== Autres IOTA <masque>

#include "fiches_typst/308.typ"
=== Urbanisation <masque>

#include "fiches_typst/302.typ"
=== Habitations <masque>

#include "fiches_typst/304.typ"
=== Franchissements <masque>

#include "fiches_typst/305.typ"
=== Linéaire routes <masque>

#include "fiches_typst/306.typ"
=== Plan d’Urbanisme Directeur <masque>

#include "fiches_typst/307.typ"
=== Nombre de prélèvement AODPE <masque>

#include "fiches_typst/503.typ"
=== Volume des prélèvements AODPE <masque>

#include "fiches_typst/504.typ"

// ── Thème : MENACES NATURELLES ──
== MENACES NATURELLES <masque>

#include "fiches_typst/famille_menace_theme_menaces_naturelles_toc.typ"

=== Incendies cumulés <masque>

#include "fiches_typst/200.typ"
=== Surface érosion <masque>

#include "fiches_typst/201.typ"
=== Terrain nu <masque>

#include "fiches_typst/202.typ"
=== Espèces exotiques envahissantes \(EEE\) <masque>

#include "fiches_typst/204.typ"
=== Glissement terrain <masque>

#include "fiches_typst/203.typ"
=== Géologie <masque>

#include "fiches_typst/401.typ"
=== Vulnérabilité intrinsèque des eaux souterraines <masque>

#include "fiches_typst/402.typ"
=== BBR <masque>

#include "fiches_typst/500.typ"
=== Pluviométrie <masque>

#include "fiches_typst/501.typ"
#include "fiches_typst/annexe_suivi_modifications.typ"
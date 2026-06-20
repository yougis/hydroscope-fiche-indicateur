#import "template_typst.typ": *

// ─── PAGE DE COUVERTURE ──────────────────────────────────────
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
  #text(size: 1.1em, weight: "medium", fill: color_black)[Hugo Roussaffa]
  #v(0.6em)
  #text(size: 0.95em, fill: color_grey)[Rapport généré le 20/06/2026]
]
#pagebreak()

#set page(
  paper: "a4",
  margin: (top: 2.5cm, bottom: 2.5cm, left: 2.5cm, right: 2.5cm),
  footer: context align(center,
    text(size: 8pt, fill: color_grey,
      counter(page).display("1 / 1", both: true)
    )
  ),
)

#show heading.where(level: 1).and(<masque>): it => {}
#show heading.where(level: 2).and(<masque>): it => {}
#show heading.where(level: 3).and(<masque>): it => {}

#include "fiches_typst/note_version.typ"

#text(fill: color_orange)[
  #outline(title: "Table des matières", depth: 3, indent: 1em)
]
#pagebreak()

#include "fiches_typst/glossaire.typ"

= Enjeu <masque>

#include "fiches_typst/famille_enjeu_entete.typ"

== Enjeux AEP <masque>

#include "fiches_typst/famille_enjeu_theme_enjeux_aep_toc.typ"

=== Capacité de production <masque>

#include "fiches_typst/1.typ"
=== Capacité réservoir <masque>

#include "fiches_typst/3.typ"
=== Interconnexion <masque>

#include "fiches_typst/5.typ"
=== Longueur réseau <masque>

#include "fiches_typst/2.typ"
=== Population desservie <masque>

#include "fiches_typst/6.typ"
=== Traitement <masque>

#include "fiches_typst/4.typ"
=== Statut AODPE <masque>

#include "fiches_typst/7.typ"
=== Statut PPE <masque>

#include "fiches_typst/8.typ"

== Enjeux Environnementaux <masque>

#include "fiches_typst/famille_enjeu_theme_enjeux_environnementaux_toc.typ"

=== Zones UNESCO <masque>

#include "fiches_typst/100.typ"
=== Zones protégées provinciales <masque>

#include "fiches_typst/101.typ"
=== KBA \/ ZICO <masque>

#include "fiches_typst/102.typ"
=== Espèces menacées <masque>

#include "fiches_typst/103.typ"
=== Forêt sèche <masque>

#include "fiches_typst/104.typ"
=== Occupation sol \(couvert végétal\) <masque>

#include "fiches_typst/105.typ"
=== Occupation sol \(couvert forestier\) <masque>

#include "fiches_typst/106.typ"

= Pression <masque>

#include "fiches_typst/famille_pression_entete.typ"

== Pressions Anthropiques <masque>

#include "fiches_typst/famille_pression_theme_pressions_anthropiques_toc.typ"

=== Occupation sol \(surfaces agricoles\) <masque>

#include "fiches_typst/107.typ"
=== ICPE <masque>

#include "fiches_typst/300.typ"
=== Activité minière <masque>

#include "fiches_typst/301.typ"
=== Urbanisation <masque>

#include "fiches_typst/302.typ"
=== Habitations <masque>

#include "fiches_typst/304.typ"
=== Franchissements <masque>

#include "fiches_typst/305.typ"
=== Linéaire routes <masque>

#include "fiches_typst/306.typ"

== Pressions Environnementales <masque>

#include "fiches_typst/famille_pression_theme_pressions_environnementales_toc.typ"

=== Incendies cumulés <masque>

#include "fiches_typst/200.typ"
=== Espèces exotiques envahissantes \(EEE\) <masque>

#include "fiches_typst/204.typ"
=== Surface érosion <masque>

#include "fiches_typst/201.typ"
=== Terrain nu <masque>

#include "fiches_typst/202.typ"
=== Glissement terrain <masque>

#include "fiches_typst/203.typ"

== Pressions Qualitatives <masque>

#include "fiches_typst/famille_pression_theme_pressions_qualitatives_toc.typ"

=== Pluviométrie <masque>

#include "fiches_typst/501.typ"
=== Niveau nappes <masque>

#include "fiches_typst/502.typ"
=== Qualité eau <masque>

#include "fiches_typst/505.typ"

== Pressions Quantitatives <masque>

#include "fiches_typst/famille_pression_theme_pressions_quantitatives_toc.typ"

=== BBR <masque>

#include "fiches_typst/500.typ"
=== Nombre de prélèvement AODPE <masque>

#include "fiches_typst/503.typ"
=== Volume des prélèvements AODPE <masque>

#include "fiches_typst/504.typ"

= Vulnérabilité <masque>

#include "fiches_typst/famille_vulnerabilite_entete.typ"

== Vulnérabilité Intrinsèque <masque>

#include "fiches_typst/famille_vulnerabilite_theme_vulnerabilite_intrinseque_toc.typ"

=== Géologie <masque>

#include "fiches_typst/401.typ"
=== Vulnérabilité intrinsèque des eaux souterraines <masque>

#include "fiches_typst/402.typ"
=== Type ouvrage <masque>

#include "fiches_typst/9.typ"
=== Statut captage <masque>

#include "fiches_typst/10.typ"

#include "fiches_typst/annexe_suivi_modifications.typ"

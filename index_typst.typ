#import "template_typst.typ": *

#set page(
  footer: context align(center,
    text(size: 8pt, fill: rgb("#888888"),
      counter(page).display("1 / 1", both: true)
    )
  ),
)

#align(center)[
  #text(size: 2em, weight: "bold")[Fiches indicateurs HydroScope]
  #v(0.5em)
  #text(size: 1.1em, fill: rgb("#444444"))[Catalogue des indicateurs de suivi et de comparaison des unités de gestion AEP]
  #v(0.3em)
  #text(size: 0.9em, fill: rgb("#888888"))[Hugo Roussaffa]
]
#v(2em)
#outline(title: "Table des matières", depth: 3, indent: 1em)
#pagebreak()

// ══════ Famille : Enjeu ══════
= Enjeu

#include "fiches_typst/famille_enjeu_entete.typ"

// ── Thème : Enjeux AEP ──
== Enjeux AEP

#include "fiches_typst/famille_enjeu_theme_enjeux_aep_toc.typ"

=== Capacité de production

#include "fiches_typst/1.typ"
=== Capacité réservoir

#include "fiches_typst/3.typ"
=== Interconnexion

#include "fiches_typst/5.typ"
=== Longueur réseau

#include "fiches_typst/2.typ"
=== Population desservie

#include "fiches_typst/6.typ"
=== Traitement

#include "fiches_typst/4.typ"
=== Statut AODPE

#include "fiches_typst/7.typ"
=== Statut PPE

#include "fiches_typst/8.typ"
=== Type ouvrage

#include "fiches_typst/9.typ"
=== Statut captage

#include "fiches_typst/10.typ"

// ── Thème : Enjeux Environnementaux ──
== Enjeux Environnementaux

#include "fiches_typst/famille_enjeu_theme_enjeux_environnementaux_toc.typ"

=== Zones UNESCO

#include "fiches_typst/100.typ"
=== Zones protégées provinciales

#include "fiches_typst/101.typ"
=== KBA / ZICO

#include "fiches_typst/102.typ"
=== Espèces menacées

#include "fiches_typst/103.typ"
=== Espèces menacées (Forêt sèche)

#include "fiches_typst/104.typ"
=== Occupation sol (couvert végétal)

#include "fiches_typst/105.typ"
=== Occupation sol (couvert forestier)

#include "fiches_typst/106.typ"
=== Occupation sol (surfaces agricoles)

#include "fiches_typst/107.typ"

// ══════ Famille : Pression ══════
= Pression

#include "fiches_typst/famille_pression_entete.typ"

// ── Thème : Pressions Anthropiques ──
== Pressions Anthropiques

#include "fiches_typst/famille_pression_theme_pressions_anthropiques_toc.typ"

=== ICPE

#include "fiches_typst/300.typ"
=== Activité minière

#include "fiches_typst/301.typ"
=== Urbanisation

#include "fiches_typst/302.typ"
=== Habitations

#include "fiches_typst/304.typ"
=== Franchissements

#include "fiches_typst/305.typ"
=== Linéaire routes

#include "fiches_typst/306.typ"

// ── Thème : Pressions Environnementales ──
== Pressions Environnementales

#include "fiches_typst/famille_pression_theme_pressions_environnementales_toc.typ"

=== Incendies cumulés

#include "fiches_typst/200.typ"
=== Espèces exotiques envahissantes (EEE)

#include "fiches_typst/204.typ"
=== Surface érosion

#include "fiches_typst/201.typ"
=== Terrain nu

#include "fiches_typst/202.typ"
=== Glissement terrain

#include "fiches_typst/203.typ"

// ── Thème : Pressions Qualitatives ──
== Pressions Qualitatives

#include "fiches_typst/famille_pression_theme_pressions_qualitatives_toc.typ"

=== Qualité eau

#include "fiches_typst/505.typ"

// ── Thème : Pressions Quantitatives ──
== Pressions Quantitatives

#include "fiches_typst/famille_pression_theme_pressions_quantitatives_toc.typ"

=== BBR

#include "fiches_typst/500.typ"
=== AODPE nombre

#include "fiches_typst/503.typ"
=== AODPE volume

#include "fiches_typst/504.typ"
=== Pluviométrie

#include "fiches_typst/501.typ"
=== Niveau nappes

#include "fiches_typst/502.typ"

// ══════ Famille : Vulnérabilité ══════
= Vulnérabilité

#include "fiches_typst/famille_vulnerabilite_entete.typ"

// ── Thème : Vulnérabilité Intrinsèque ──
== Vulnérabilité Intrinsèque

#include "fiches_typst/famille_vulnerabilite_theme_vulnerabilite_intrinseque_toc.typ"

=== Géologie

#include "fiches_typst/401.typ"
=== Vulnérabilité intrinsèque des eaux souterraines

#include "fiches_typst/402.typ"
=== IDPR

#include "fiches_typst/400.typ"

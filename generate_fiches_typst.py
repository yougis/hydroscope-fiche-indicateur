#!/usr/bin/env python3
import pandas as pd
from pathlib import Path
from datetime import date
import subprocess

from generate_fiches_indicateurs import (
    v,
    is_valid_data,
    build_group_context,
    extract_vigilances,
    get_theme_color,
    vision_color_from_group_id,
)

XLSX = Path("fiches indicateurs.xlsx")
FICHES_TYPST_DIR = Path("fiches_typst")


def typst_escape(value):
    if value is None:
        return ""
    text = str(value)
    text = text.replace("\\", "\\\\")
    text = text.replace('"', '\\"')
    text = text.replace("[", "\\[")
    text = text.replace("]", "\\]")
    text = text.replace("\n", " ")
    text = text.replace("\r", " ")
    return text.strip()

def make_safe_name(name):
    replacements = {
        ' ': '_', '/': '_', 'é': 'e', 'è': 'e', 'ê': 'e',
        'à': 'a', 'â': 'a', 'ù': 'u', 'û': 'u',
        'î': 'i', 'ô': 'o', 'ç': 'c',
    }
    result = typst_escape(name).lower()
    for char, replacement in replacements.items():
        result = result.replace(char, replacement)
    return result

def typst_quote(value):
    return f'"{typst_escape(value)}"'


def typst_color(color):
    if not color:
        return 'rgb("#5f6368")'
    return f'rgb("{color}")'


def render_typst_page(row, context, df_src, df_rel, df_vigi):
    id_ind = v(row, 'id_indicateur')
    fiche_indicateur = v(row, 'fiche_indicateur')
    nom_ind = v(row, 'nom_indicateur')
    famille = v(row, 'famille_indicateur')
    type_ind = v(row, 'type') or v(row, 'type_indicateur')
    theme = v(row, 'Nom_theme')

    # ── Résolution du groupe et couleur ──────────────────────────────
    selected_group = None
    for gid, g in context['groups'].items():
        if any(ind.get('nom') == nom_ind or ind.get('id') == id_ind
               for ind in g['indicateurs']):
            selected_group = g
            break

    color = None
    if selected_group:
        color = vision_color_from_group_id(selected_group.get('id'))
    if not color:
        color = get_theme_color(
            famille or theme or (selected_group and selected_group.get('theme'))
        )
    brand_color = color if color else '#005596'

    role = selected_group.get('role') if selected_group else ''
    explication_role = selected_group.get('explication_role') if selected_group else ''
    groupe_nom = selected_group.get('nom') if selected_group else ''
    groupe_obj = selected_group.get('objectif') if selected_group else ''

    central_objectif = v(row, 'objectif')
    normalization = v(row, 'normalisation_methode')
    sens = v(row, 'sens_indicateur')
    criticite = v(row, 'definition_criticite')
    support_spatial = v(row, 'support_spatial')
    ponderation = v(row, 'Ponderation')
    spatialisation = v(row, 'spatialisation_H3')
    nature = v(row, 'quantitatif_qualitatif')
    statut_dispo = v(row, 'statut_disponibilite')
    synthese = v(row, 'synthese_echanges')

    vigils = extract_vigilances(df_vigi, id_ind, nom_ind)

    # ── Valeurs échappées ─────────────────────────────────────────────
    title = typst_escape(nom_ind or 'Indicateur')
    fiche_number = typst_escape(f'Fiche n°{fiche_indicateur or "?"}')
    theme_text = typst_escape(theme or 'Non renseigné')
    famille_text = typst_escape(famille or 'Non renseigné')
    type_text = typst_escape(type_ind or '')
    role_text = typst_escape(role or 'Pilotage')
    explication_text = typst_escape(explication_role or '')
    groupe_nom_text = typst_escape(groupe_nom or '')
    groupe_obj_text = typst_escape(groupe_obj or '')
    objective_text = typst_escape(central_objectif or '')
    normalization_text = typst_escape(normalization or '')
    sens_text = typst_escape(sens or '')
    criticite_text = typst_escape(criticite or '')

    # Icône de rôle (résolu en Python)
    role_lower = str(role).lower()
    if 'pilotage' in role_lower:
        role_icon = '🎯'
    elif 'veille' in role_lower:
        role_icon = '👁'
    elif 'diagnostic' in role_lower or 'modulation' in role_lower:
        role_icon = '🔬'
    else:
        role_icon = '📌'

    # Flèche de sens (résolu en Python)
    if sens:
        sens_lower = sens.lower()
        if 'positif' in sens_lower:
            arrow = '↑'
            arrow_color = '#2e7d32'
        elif 'négatif' in sens_lower:
            arrow = '↓'
            arrow_color = '#c62828'
        else:
            arrow = '↔'
            arrow_color = '#555555'
    else:
        arrow = ''
        arrow_color = '#555555'

    # ── Sources ───────────────────────────────────────────────────────
    source_rows = []
    mask_rel = (
        df_rel['id_indicateur'].astype(str).str.replace('.0', '', regex=False) == str(id_ind)
    ) & (
        df_rel['actif'].astype(str).str.strip().str.capitalize() == 'Oui'
    )
    rel_ids = (
        df_rel[mask_rel]['id_ressource']
        .astype(str).str.replace('.0', '', regex=False).tolist()
    )
    sources_liees = df_src[
        df_src['id_ressource'].astype(str)
        .str.replace('.0', '', regex=False).isin(rel_ids)
    ]
    for _, s in sources_liees.iterrows():
        source_rows.append({
            'nom': typst_escape(v(s, 'nom_ressource') or 'Source'),
            'origine': typst_escape(v(s, 'origine') or ''),
            'distributeur': typst_escape(v(s, 'distributeur') or ''),
            'couverture': typst_escape(v(s, 'couverture_spatiale') or ''),
            'actualisation': typst_escape(v(s, 'actualisation') or ''),
            'disponibilite': typst_escape(v(s, 'statut_disponibilite') or ''),
            'url': typst_escape(v(s, 'url') or ''),
            'rem': typst_escape(
                v(s, 'description_ressource') or
                v(s, 'documentation_ressource') or
                v(s, 'contraintes_ressource') or ''
            ),
        })

    # ── Génération Typst ──────────────────────────────────────────────
    lines = []
    lines.append('#import "../template_typst.typ": *')
    lines.append('')
    # EN-TÊTE : titre uniquement (Famille/Thème déjà en page de garde)
    lines.append(f'#let brand = rgb("{brand_color}")')
    lines.append('')
    lines.append(f'#text(size: 1.6em, weight: "bold", fill: brand)[{title}]')
    lines.append('#v(0.3em)')
    lines.append(f'#text(size: 0.85em, fill: rgb("#666"))[{fiche_number}]')
    lines.append('#v(0.5em)')
    lines.append('#line(length: 100%, stroke: 0.5pt + rgb("#d9e2ea"))')
    lines.append('#v(0.5em)')

    # VISION STRATÉGIQUE
    lines.append('#box(')
    lines.append('  width: 100%,')
    lines.append('  fill: fiche_vision_bg,')
    lines.append('  stroke: (left: 6pt + brand),')
    lines.append('  radius: 3pt,')
    lines.append('  inset: 8pt,')
    lines.append('  stack(dir: ttb, spacing: 0.3em,')
    lines.append(f'    text(size: 0.85em, weight: "bold")[Vision stratégique],')
    lines.append(f'    text(size: 0.85em)[{role_icon} #h(0.3em) #text(weight: "bold")[{role_text}]],')
    if explication_text:
        lines.append(f'    text(size: 0.75em)[{explication_text}],')
    if groupe_nom_text:
        lines.append(f'    badge("Groupe", "{groupe_nom_text}"),')
    if groupe_obj_text:
        lines.append(f'    badge("Objectif groupe", "{groupe_obj_text}"),')
    lines.append('  )')
    lines.append(')')
    lines.append('#v(0.7em)')

    # BODY : 2 colonnes (analyse + contexte)
    # grid avec 2 cellules séparées par une virgule
    lines.append('#grid(')
    lines.append('  columns: (1.65fr, 1fr),')
    lines.append('  column-gutter: 15pt,')

    # Cellule 1 : Analyse & criticité
    lines.append('  box(')
    lines.append('    width: 100%,')
    lines.append('    fill: fiche_bg,')
    lines.append('    stroke: 0.5pt + fiche_border,')
    lines.append('    radius: 3pt,')
    lines.append('    inset: 8pt,')
    lines.append('    stack(dir: ttb, spacing: 0.35em,')
    lines.append('      text(size: 0.85em, weight: "bold")[Analyse & criticité],')
    if objective_text:
        lines.append('      stack(dir: ttb, spacing: 0.1em,')
        lines.append(f'        text(size: 0.75em, weight: "bold")[Objectif],')
        lines.append(f'        text(size: 0.71em)[{objective_text}],')
        lines.append('      ),')
    if normalization_text:
        lines.append('      stack(dir: ttb, spacing: 0.1em,')
        lines.append(f'        text(size: 0.75em, weight: "bold")[Normalisation],')
        lines.append(f'        text(size: 0.71em)[{normalization_text}],')
        lines.append('      ),')
    if sens_text:
        lines.append('      stack(dir: ttb, spacing: 0.1em,')
        lines.append(f'        text(size: 0.75em, weight: "bold")[Sens de l\'indicateur],')
        lines.append(f'        text(size: 0.71em)[{sens_text} #h(0.2em) #text(fill: rgb("{arrow_color}"), size: 0.95em)[{arrow}]],',)
        lines.append('      ),')
    if criticite_text:
        lines.append('      stack(dir: ttb, spacing: 0.1em,')
        lines.append(f'        text(size: 0.75em, weight: "bold")[Définition de la criticité],')
        lines.append(f'        text(size: 0.71em)[{criticite_text}],')
        lines.append('      ),')
    lines.append('    )')
    lines.append('  ),')

    # Cellule 2 : Contexte technique
    lines.append('  box(')
    lines.append('    width: 100%,')
    lines.append('    fill: fiche_bg,')
    lines.append('    stroke: 0.5pt + fiche_border,')
    lines.append('    radius: 3pt,')
    lines.append('    inset: 8pt,')
    lines.append('    stack(dir: ttb, spacing: 0.4em,')
    lines.append('      text(size: 0.85em, weight: "bold")[Contexte technique],',)
    if support_spatial:
        lines.append(f'      badge("Support spatial", "{typst_escape(support_spatial)}"),')
    if ponderation:
        lines.append(f'      badge("Pondération", "{typst_escape(ponderation)}"),')
    if spatialisation:
        lines.append(f'      badge("Spatialisation H3", "{typst_escape(spatialisation)}"),')
    if nature:
        lines.append(f'      badge("Nature des données", "{typst_escape(nature)}"),')
    if statut_dispo:
        lines.append(f'      badge("Disponibilité", "{typst_escape(statut_dispo)}"),')
    lines.append('    )')
    lines.append('  ),')
    lines.append(')')
    lines.append('#v(0.7em)')

    # VIGILANCE EXPERT
    if vigils or synthese:
        lines.append('#box(')
        lines.append('  width: 100%,')
        lines.append('  fill: rgb(255, 250, 240),')
        lines.append('  stroke: 1.5pt + rgb("#c62828"),')
        lines.append('  radius: 3pt,')
        lines.append('  inset: 8pt,')
        lines.append('  stack(dir: ttb, spacing: 0.3em,')
        lines.append('    text(size: 0.85em, weight: "bold", fill: rgb("#c62828"))[Point de vigilance],')
        if synthese:
            synth_text = typst_escape(synthese)
            lines.append('    stack(dir: ttb, spacing: 0.1em,')
            lines.append(f'      text(size: 0.75em, weight: "bold")[Résumé des échanges],')
            lines.append(f'      text(size: 0.71em)[{synth_text}],')
            lines.append('    ),')
        for vigil in vigils:
            vtype = typst_escape(vigil.get('type_vigilance') or 'Vigilance')
            vid = typst_escape(vigil.get('id_relation') or '')
            vdesc = typst_escape(vigil.get('description') or '')
            vlabel = f'{vtype} ({vid})' if vid else vtype
            lines.append('    stack(dir: ttb, spacing: 0.1em,')
            lines.append(f'      text(size: 0.75em, weight: "bold")[{vlabel}],')
            lines.append(f'      text(size: 0.71em)[{vdesc}],')
            lines.append('    ),')
        lines.append('  )')
        lines.append(')')
        lines.append('#v(0.7em)')

    # SOURCES & FIABILITÉ
    lines.append('#text(size: 0.85em, weight: "bold")[Sources & fiabilité]')
    lines.append('#v(0.4em)')

    lines.append('#box(')
    lines.append('  width: 100%,')
    lines.append('  fill: fiche_bg,')
    lines.append('  stroke: 0.5pt + rgb("#dce4eb"),')
    lines.append('  radius: 3pt,')
    lines.append('  inset: 8pt,')
    lines.append('  stack(dir: ttb, spacing: 0.25em,')
    if source_rows:
        
        for source in source_rows:
            
            lines.append(f'    text(size: 0.8em, weight: "bold")[{source["nom"]}],')
            if source['origine']:
                lines.append(f'    text(size: 0.75em)[#text(weight: "bold")[Origine :] {source["origine"]}],')
            if source['distributeur']:
                lines.append(f'    text(size: 0.75em)[#text(weight: "bold")[Distributeur :] {source["distributeur"]}],')
            if source['couverture']:
                lines.append(f'    text(size: 0.75em)[#text(weight: "bold")[Couverture spatiale :] {source["couverture"]}],')
            if source['actualisation']:
                lines.append(f'    text(size: 0.75em)[#text(weight: "bold")[Actualisation :] {source["actualisation"]}],')
            if source['disponibilite']:
                lines.append(f'    text(size: 0.75em)[#text(weight: "bold")[Disponibilité :] {source["disponibilite"]}],')
            if source['url'] and 'http' in source['url']:
                lines.append(f'    text(size: 0.75em)[#link("{source["url"]}")[🔗 Ressource]],')
            if source['rem']:
                lines.append(f'    text(size: 0.71em, style: "italic")[{source["rem"]}],')

    else:
        
        lines.append(f'    text(size: 0.71em, style: "italic")[Aucune source de donnée identifiée.]')
    lines.append('  )')
    lines.append(')')
    lines.append('#v(0.5em)')
    lines.append('#pagebreak()')
    lines.append('')

    return "\n".join(lines)


def build_family_index(df_ind, context):
    """Index organisé par famille > thème > groupe."""
    families = {}  # { famille: { theme: { group_id: {...} } } }

    for _, row in df_ind.iterrows():
        id_ind = v(row, 'id_indicateur')
        num_fiche = v(row, 'fiche_indicateur')
        nom_ind = v(row, 'nom_indicateur')
        famille = v(row, 'famille_indicateur') or 'Non classé'
        theme = v(row, 'Nom_theme') or 'Sans thème'
        famille_type = v(row, 'type') or v(row, 'type_indicateur') or ''

        if not is_valid_data(id_ind, nom_ind):
            continue

        selected_group = None
        for gid, g in context['groups'].items():
            if any(ind.get('nom') == nom_ind or ind.get('id') == id_ind
                   for ind in g['indicateurs']):
                selected_group = g
                break

        group_id = selected_group.get('id') if selected_group else 'sans_groupe'

        # Niveau 1 : famille
        if famille not in families:
            families[famille] = {}
        # Niveau 2 : thème
        if theme not in families[famille]:
            families[famille][theme] = {}
        # Niveau 3 : groupe
        if group_id not in families[famille][theme]:
            families[famille][theme][group_id] = {
                'nom': selected_group.get('nom') if selected_group else 'Sans groupe',
                'role': selected_group.get('role') if selected_group else '',
                'objectif': selected_group.get('objectif') if selected_group else '',
                'explication_role': selected_group.get('explication_role') if selected_group else '',
                'indicateurs': [],
            }
        families[famille][theme][group_id]['indicateurs'].append({
            'id': id_ind,
            'num_fiche': num_fiche,
            'nom': nom_ind,
            'type': famille_type,
        })

    return families




def render_index_typst(families, title, subtitle, author):
    lines = []

    lines.append('#import "template_typst.typ": *')
    lines.append('')


    # Pagination globale
    lines.append('#set page(')
    lines.append('  footer: context align(center,')
    lines.append('    text(size: 8pt, fill: rgb("#888888"),')
    lines.append('      counter(page).display("1 / 1", both: true)')
    lines.append('    )')
    lines.append('  ),')
    lines.append(')')
    lines.append('')
    
    lines.append('#align(center)[')
    lines.append(f'  #text(size: 2em, weight: "bold")[{typst_escape(title)}]')
    lines.append('  #v(0.5em)')
    lines.append(f'  #text(size: 1.1em, fill: rgb("#444444"))[{typst_escape(subtitle)}]')
    lines.append('  #v(0.3em)')
    lines.append(f'  #text(size: 0.9em, fill: rgb("#888888"))[{typst_escape(author)}]')
    lines.append(']')
    lines.append('#v(2em)')

    # Table des matières
    lines.append('#outline(title: "Table des matières", depth: 3, indent: 1em)')
    lines.append('#pagebreak()')
    lines.append('')

    # ── Famille > Thème intercalé avec ses fiches ─────────────────────
    for famille_name in sorted(families.keys(), key=lambda x: x or ''):
        themes_data = families[famille_name]
        safe_famille = make_safe_name(famille_name)

        lines.append(f'// ══════ Famille : {typst_escape(famille_name)} ══════')

        # Heading niveau 1 pour l'outline
        lines.append(f'= {typst_escape(famille_name)}')
        lines.append('')

        # Entête famille (bandeau + objectif global)
        lines.append(f'#include "fiches_typst/famille_{safe_famille}_entete.typ"')
        lines.append('')

        # ── Thèmes : TOC thème puis fiches intercalées ────────────────
        for theme_name, groupe_data in sorted(themes_data.items()):
            theme_text = typst_escape(theme_name)
            safe_theme = make_safe_name(theme_name)

            lines.append(f'// ── Thème : {theme_text} ──')

            # Heading niveau 2 pour l'outline
            lines.append(f'== {theme_text}')
            lines.append('')

            # TOC du thème (bandeau + groupes + liste indicateurs)
            lines.append(f'#include "fiches_typst/famille_{safe_famille}_theme_{safe_theme}_toc.typ"')
            lines.append('')

            # Fiches du thème intercalées ici
            for group_id, group_info in sorted(groupe_data.items()):
                for ind in sorted(
                    group_info.get('indicateurs', []),
                    key=lambda x: int(x['num_fiche']) if str(x['num_fiche']).isdigit() else 0
                ):
                    ind_id = str(ind.get('id') or '').strip()
                    ind_nom = typst_escape(ind.get('nom') or '')
                    if ind_id:
                        # Heading niveau 3 pour l'outline
                        lines.append(f'=== {ind_nom}')
                        lines.append('')
                        lines.append(f'#include "fiches_typst/{ind_id}.typ"')

            lines.append('')

    return '\n'.join(lines)



def compile_typst(typ_file: Path, output_pdf: Path) -> bool:
    result = subprocess.run(
        ['typst', 'compile', str(typ_file), str(output_pdf)],
        capture_output=True,
        text=True
    )
    if result.returncode == 0:
        print(f'✅ PDF généré : {output_pdf}')
        return True
    else:
        print(f'❌ Erreur Typst :\n{result.stderr}')
        return False


def generate_family_entete(famille_name, themes_data, df_ind):
    """Bandeau famille + objectif global uniquement (pas de groupes/indicateurs)."""

    # Couleur dominante depuis le premier groupe du premier thème
    dominant_color = '#005596'
    for theme_name, groupe_data in sorted(themes_data.items()):
        for group_id, group_info in sorted(groupe_data.items()):
            role = str(group_info.get('role') or '').lower()
            if 'pilotage' in role:
                dominant_color = '#005596'
            elif 'veille' in role:
                dominant_color = '#2E7D32'
            elif 'diagnostic' in role or 'modulation' in role:
                dominant_color = '#546E7A'
            break
        break

    # Type depuis les indicateurs
    tous_types = set()
    for theme_name, groupe_data in themes_data.items():
        for group_info in groupe_data.values():
            for ind in group_info.get('indicateurs', []):
                if ind.get('type'):
                    tous_types.add(ind['type'].strip())
    famille_type = typst_escape(' / '.join(sorted(tous_types)))

    # Objectif global depuis df_ind
    famille_rows = df_ind[
        df_ind['famille_indicateur'].astype(str).str.strip() == str(famille_name).strip()
    ]
    famille_objectif = ''
    if not famille_rows.empty:
        famille_objectif = typst_escape(
            v(famille_rows.iloc[0], 'objectifs_indicateur') or
            v(famille_rows.iloc[0], 'objectif') or ''
        )

    famille_text = typst_escape(famille_name or 'Famille')

    lines = []
    lines.append('#import "../template_typst.typ": *')
    lines.append('')
    lines.append('// ─── ENTÊTE FAMILLE ──────────────────────────────────────────')

    # Bandeau famille
    lines.append('#block(')
    lines.append('  width: 100%,')
    lines.append(f'  stroke: (top: 4pt + rgb("{dominant_color}")),')
    lines.append('  inset: (top: 10pt, bottom: 8pt, left: 0pt, right: 0pt),')
    lines.append('  stack(dir: ttb, spacing: 0.4em,')
    lines.append(f'    text(size: 1.5em, weight: "bold", tracking: 1pt)[{famille_text.upper()}],')
    if famille_type:
        lines.append(
            f'    box(fill: rgb("{dominant_color}"), radius: 4pt, '
            f'inset: (x: 8pt, y: 4pt), '
            f'text(size: 0.8em, weight: "bold", fill: white)[TYPE : {famille_type.upper()}]),'
        )
    lines.append('  )')
    lines.append(')')
    lines.append('#v(0.6em)')

    # Objectif global
    if famille_objectif:
        lines.append('#block(')
        lines.append('  width: 100%,')
        lines.append('  fill: luma(245),')
        lines.append('  radius: 6pt,')
        lines.append('  inset: 12pt,')
        lines.append(f'  text(size: 0.95em, style: "italic", fill: rgb("#333333"))[{famille_objectif}]')
        lines.append(')')
        lines.append('#v(0.6em)')

    lines.append('')
    return '\n'.join(lines)


def generate_theme_toc(famille_name, theme_name, groupe_data):
    """Bandeau thème + groupes + liste indicateurs pour un thème donné."""

    # Couleur dominante du thème
    dominant_color = '#005596'
    for group_id, group_info in sorted(groupe_data.items()):
        role = str(group_info.get('role') or '').lower()
        if 'pilotage' in role:
            dominant_color = '#005596'
        elif 'veille' in role:
            dominant_color = '#2E7D32'
        elif 'diagnostic' in role or 'modulation' in role:
            dominant_color = '#546E7A'
        break

    theme_text = typst_escape(theme_name or 'Thème')

    lines = []
    lines.append('#import "../template_typst.typ": *')
    lines.append('')
    lines.append(f'// ─── TOC THÈME : {theme_text} ────────────────────────────────')

    # Bandeau thème
    lines.append('#block(')
    lines.append('  width: 100%,')
    lines.append(f'  fill: rgb("{dominant_color}"),')
    lines.append('  radius: 4pt,')
    lines.append('  inset: (x: 14pt, y: 10pt),')
    lines.append(f'  text(size: 1.15em, weight: "bold", fill: white)[{theme_text}]')
    lines.append(')')
    lines.append('#v(0.6em)')

    # Groupes du thème
    for group_id, group_info in sorted(groupe_data.items()):
        role = str(group_info.get('role') or 'Pilotage')
        role_lower = role.lower()
        nom_groupe = typst_escape(group_info.get('nom') or '')
        objectif_groupe = typst_escape(group_info.get('objectif') or '')
        explication = typst_escape(group_info.get('explication_role') or '')

        if 'pilotage' in role_lower:
            role_color = '#005596'
        elif 'veille' in role_lower:
            role_color = '#2E7D32'
        else:
            role_color = '#546E7A'

        role_text = typst_escape(role)
        indicateurs = sorted(
            group_info.get('indicateurs', []),
            key=lambda x: int(x['num_fiche']) if str(x['num_fiche']).isdigit() else 0
        )

        # Bandeau groupe : nom + badge rôle
        lines.append('#block(')
        lines.append('  width: 100%,')
        lines.append(f'  stroke: (left: 5pt + rgb("{role_color}")),')
        lines.append('  fill: luma(252),')
        lines.append('  radius: (right: 6pt),')
        lines.append('  inset: (left: 12pt, right: 10pt, top: 8pt, bottom: 8pt),')
        lines.append('  grid(')
        lines.append('    columns: (1fr, auto),')
        lines.append('    column-gutter: 8pt,')
        lines.append('    stack(dir: ttb, spacing: 0.3em,')
        lines.append(f'      text(size: 1em, weight: "bold")[{nom_groupe}],')
        if objectif_groupe:
            lines.append(f'      text(size: 0.85em, fill: rgb("#333333"))[{objectif_groupe}],')
        if explication:
            lines.append(f'      text(size: 0.8em, style: "italic", fill: rgb("#666666"))[{explication}],')
        lines.append('    ),')
        lines.append(f'    box(fill: rgb("{role_color}"), radius: 999pt,')
        lines.append(f'      inset: (x: 10pt, y: 5pt),')
        lines.append(f'      text(size: 0.75em, weight: "bold", fill: white)[{role_text.upper()}]')
        lines.append('    ),')
        lines.append('  )')
        lines.append(')')
        lines.append('#v(0.4em)')

        # Grille indicateurs du groupe
        if indicateurs:
            lines.append('#block(')
            lines.append('  width: 100%,')
            lines.append('  inset: (left: 17pt),')
            lines.append('  grid(')
            lines.append('    columns: (40pt, 1fr),')
            lines.append('    row-gutter: 4pt,')
            lines.append('    column-gutter: 6pt,')
            lines.append(f'    text(size: 0.78em, weight: "bold", fill: rgb("{role_color}"))[Fiche n°],')
            lines.append(f'    text(size: 0.78em, weight: "bold", fill: rgb("{role_color}"))[Indicateur],')
            for ind in indicateurs:
                ind_num = typst_escape(str(ind.get('num_fiche') or ind.get('id') or ''))
                ind_nom = typst_escape(str(ind.get('nom') or ''))
                lines.append(f'    text(size: 0.8em, fill: rgb("#555555"))[{ind_num}],')
                lines.append(f'    text(size: 0.8em)[{ind_nom}],')
            lines.append('  )')
            lines.append(')')
        lines.append('#v(0.7em)')

    lines.append('#pagebreak()')
    lines.append('')
    return '\n'.join(lines)


def generate_family_toc(famille_name, themes_data, df_ind, context=None):
    """
    Garde pour compatibilité — génère entête + tous les thèmes d'une famille
    dans un seul fichier (ancien comportement).
    Préférer generate_family_entete + generate_theme_toc pour le nouveau rendu.
    """
    entete = generate_family_entete(famille_name, themes_data, df_ind)
    parts = [entete]
    for theme_name, groupe_data in sorted(themes_data.items()):
        parts.append(generate_theme_toc(famille_name, theme_name, groupe_data))
    return '\n'.join(parts)


def main():
    print('🚀 Génération Typst des fiches avec pages de garde par famille...')
    try:
        tabs = pd.read_excel(XLSX, sheet_name=None)
    except Exception as exc:
        print(f'❌ Impossible de charger {XLSX}: {exc}')
        return

    df_ind  = tabs['indicateurs']
    df_src  = tabs['sources']
    df_rel  = tabs['relation indicateur source']
    df_group = tabs['groupes']
    df_rel_group = tabs['relation groupe objectifs']
    df_vigi = tabs['vigilances']

    for df in [df_ind, df_src, df_rel, df_group, df_rel_group, df_vigi]:
        df.columns = df.columns.str.strip()

    context = build_group_context(df_ind, df_group, df_rel_group)
    FICHES_TYPST_DIR.mkdir(exist_ok=True)

    # Structure : famille > thème > groupe > indicateurs
    families = build_family_index(df_ind, context)
    count = 0
    entete_count = 0
    toc_count = 0

    for famille_name, themes_data in sorted(families.items(), key=lambda x: x[0] or ''):
        safe_famille = make_safe_name(famille_name)

        # ── Entête famille ────────────────────────────────────────────
        entete_content = generate_family_entete(famille_name, themes_data, df_ind)
        entete_path = FICHES_TYPST_DIR / f'famille_{safe_famille}_entete.typ'
        entete_path.write_text(entete_content, encoding='utf-8')
        entete_count += 1
        print(f'  📋 Entête famille : {famille_name}')

        for theme_name, groupe_data in sorted(themes_data.items()):
            safe_theme = make_safe_name(theme_name)

            # ── TOC du thème ──────────────────────────────────────────
            toc_content = generate_theme_toc(famille_name, theme_name, groupe_data)
            toc_path = FICHES_TYPST_DIR / f'famille_{safe_famille}_theme_{safe_theme}_toc.typ'
            toc_path.write_text(toc_content, encoding='utf-8')
            toc_count += 1
            print(f'    📑 TOC thème : {theme_name}')

            # ── Fiches indicateurs du thème ───────────────────────────
            for group_id, group_info in sorted(groupe_data.items()):
                for ind in sorted(
                    group_info.get('indicateurs', []),
                    key=lambda x: int(x['num_fiche']) if str(x['num_fiche']).isdigit() else 0
                ):
                    ind_id = ind.get('id')
                    if not ind_id:
                        continue

                    try:
                        mask = (
                            df_ind['id_indicateur']
                            .astype(str)
                            .str.replace('.0', '', regex=False) == str(ind_id)
                        )
                        ind_rows = df_ind[mask]
                    except Exception:
                        continue

                    if ind_rows.empty:
                        print(f'    ⚠️  Indicateur {ind_id} introuvable dans df_ind')
                        continue

                    row = ind_rows.iloc[0]
                    typst_content = render_typst_page(row, context, df_src, df_rel, df_vigi)
                    path = FICHES_TYPST_DIR / f'{ind_id}.typ'
                    path.write_text(typst_content, encoding='utf-8')
                    count += 1

    print(f'✅ {entete_count} entêtes famille générées')
    print(f'✅ {toc_count} TOC thème générés')
    print(f'✅ {count} fiches Typst générées dans {FICHES_TYPST_DIR}/')

    # ── Index principal ───────────────────────────────────────────────
    index_content = render_index_typst(
        families,
        'Fiches indicateurs HydroScope',
        'Catalogue des indicateurs de suivi et de comparaison des unités de gestion AEP',
        'Hugo Roussaffa'
    )
    index_path = Path('index_typst.typ')
    index_path.write_text(index_content, encoding='utf-8')
    print('✅ index_typst.typ mis à jour.')

    # ── Compilation PDF ───────────────────────────────────────────────
    print('📄 Compilation PDF...')
    compile_typst(index_path, Path('catalogue_hydroscope.pdf'))


if __name__ == '__main__':
    main()
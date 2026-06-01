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


def typst_quote(value):
    return f'"{typst_escape(value)}"'


def typst_color(color):
    if not color:
        return 'rgb("#5f6368")'
    return f'rgb("{color}")'


def render_typst_page(row, context, df_src, df_rel, df_vigi):
    id_ind = v(row, 'id_indicateur')
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
    fiche_number = typst_escape(f'Fiche n°{id_ind or "?"}')
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
    # EN-TÊTE : titre + badge
    # grid(col1: meta, col2: badge) — cellules séparées par virgules
    lines.append(f'#let brand = rgb("{brand_color}")')
    lines.append('')
    lines.append(f'#text(size: 1.6em, weight: "bold", fill: brand)[{title}]')
    lines.append('#v(0.4em)')
    lines.append('#grid(')
    lines.append('  columns: (1fr, auto),')
    lines.append('  column-gutter: 10pt,')
    # Cellule 1 : meta (stack = args positionnels séparés par virgules)
    lines.append('  stack(dir: ttb, spacing: 0.2em,')
    lines.append(f'    text(size: 0.9em)[#text(weight: "bold")[Thème :] {theme_text}],')
    lines.append(f'    text(size: 0.9em)[#text(weight: "bold")[Famille :] {famille_text}],')
    if type_text:
        lines.append(f'    text(size: 0.9em)[#text(weight: "bold")[Type :] {type_text}],')
    lines.append('  ),')
    # Cellule 2 : badge numéro fiche
    lines.append('  box(')
    lines.append('    width: auto,')
    lines.append('    fill: brand,')
    lines.append('    radius: 999pt,')
    lines.append('    inset: (x: 12pt, y: 8pt),')
    lines.append(f'    text(size: 0.9em, weight: "bold", fill: white)[{fiche_number}]')
    lines.append('  ),')
    lines.append(')')
    lines.append('#line(length: 100%, stroke: 0.5pt + rgb("#d9e2ea"))')
    lines.append('#v(0.7em)')

    # VISION STRATÉGIQUE
    lines.append('#box(')
    lines.append('  width: 100%,')
    lines.append('  fill: fiche_vision_bg,')
    lines.append('  stroke: (left: 6pt + brand),')
    lines.append('  radius: 8pt,')
    lines.append('  inset: 10pt,')
    lines.append('  stack(dir: ttb, spacing: 0.3em,')
    lines.append(f'    text(size: 1em, weight: "bold")[Vision stratégique],')
    lines.append(f'    text(size: 1.05em)[{role_icon} #h(0.3em) #text(weight: "bold")[{role_text}]],')
    if explication_text:
        lines.append(f'    text(size: 0.9em)[{explication_text}],')
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
    lines.append('  column-gutter: 10pt,')

    # Cellule 1 : Analyse & criticité
    lines.append('  box(')
    lines.append('    width: 100%,')
    lines.append('    fill: fiche_bg,')
    lines.append('    stroke: 0.5pt + fiche_border,')
    lines.append('    radius: 8pt,')
    lines.append('    inset: 10pt,')
    lines.append('    stack(dir: ttb, spacing: 0.35em,')
    lines.append('      text(size: 1em, weight: "bold")[Analyse & criticité],')
    if objective_text:
        lines.append('      stack(dir: ttb, spacing: 0.1em,')
        lines.append(f'        text(size: 0.85em, weight: "bold")[Objectif],')
        lines.append(f'        text(size: 0.85em)[{objective_text}],')
        lines.append('      ),')
    if normalization_text:
        lines.append('      stack(dir: ttb, spacing: 0.1em,')
        lines.append(f'        text(size: 0.85em, weight: "bold")[Normalisation],')
        lines.append(f'        text(size: 0.85em)[{normalization_text}],')
        lines.append('      ),')
    if sens_text:
        lines.append('      stack(dir: ttb, spacing: 0.1em,')
        lines.append(f'        text(size: 0.85em, weight: "bold")[Sens de l\'indicateur],')
        lines.append(f'        text(size: 0.85em)[{sens_text} #h(0.2em) #text(fill: rgb("{arrow_color}"), size: 1.1em)[{arrow}]],')
        lines.append('      ),')
    if criticite_text:
        lines.append('      stack(dir: ttb, spacing: 0.1em,')
        lines.append(f'        text(size: 0.85em, weight: "bold")[Définition de la criticité],')
        lines.append(f'        text(size: 0.85em)[{criticite_text}],')
        lines.append('      ),')
    lines.append('    )')
    lines.append('  ),')

    # Cellule 2 : Contexte technique
    lines.append('  box(')
    lines.append('    width: 100%,')
    lines.append('    fill: fiche_bg,')
    lines.append('    stroke: 0.5pt + fiche_border,')
    lines.append('    radius: 8pt,')
    lines.append('    inset: 10pt,')
    lines.append('    stack(dir: ttb, spacing: 0.4em,')
    lines.append('      text(size: 1em, weight: "bold")[Contexte technique],')
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
        lines.append('#fiche_alert_box[')
        lines.append('  #stack(dir: ttb, spacing: 0.3em,')
        lines.append('    text(size: 1em, weight: "bold")[Vigilance expert],')
        if synthese:
            synth_text = typst_escape(synthese)
            lines.append('    stack(dir: ttb, spacing: 0.1em,')
            lines.append(f'      text(size: 0.85em, weight: "bold")[Résumé des échanges],')
            lines.append(f'      text(size: 0.85em)[{synth_text}],')
            lines.append('    ),')
        for vigil in vigils:
            # Résoudre entièrement en Python avant d'écrire
            vtype = typst_escape(vigil.get('type_vigilance') or 'Vigilance')
            vid = typst_escape(vigil.get('id_relation') or '')
            vdesc = typst_escape(vigil.get('description') or '')
            vlabel = f'{vtype} ({vid})' if vid else vtype
            lines.append('    stack(dir: ttb, spacing: 0.1em,')
            lines.append(f'      text(size: 0.85em, weight: "bold")[{vlabel}],')
            lines.append(f'      text(size: 0.85em)[{vdesc}],')
            lines.append('    ),')
        lines.append('  )')
        lines.append(']')
        lines.append('#v(0.7em)')

    # SOURCES & FIABILITÉ
    lines.append('#text(size: 1em, weight: "bold")[Sources & fiabilité]')
    lines.append('#v(0.4em)')

    if source_rows:
        for source in source_rows:
            lines.append('#box(')
            lines.append('  width: 100%,')
            lines.append('  fill: fiche_bg,')
            lines.append('  stroke: 0.5pt + rgb("#dce4eb"),')
            lines.append('  radius: 8pt,')
            lines.append('  inset: 10pt,')
            lines.append('  stack(dir: ttb, spacing: 0.25em,')
            lines.append(f'    text(size: 0.95em, weight: "bold")[{source["nom"]}],')
            if source['origine']:
                lines.append(f'    text(size: 0.85em)[#text(weight: "bold")[Origine :] {source["origine"]}],')
            if source['distributeur']:
                lines.append(f'    text(size: 0.85em)[#text(weight: "bold")[Distributeur :] {source["distributeur"]}],')
            if source['couverture']:
                lines.append(f'    text(size: 0.85em)[#text(weight: "bold")[Couverture spatiale :] {source["couverture"]}],')
            if source['actualisation']:
                lines.append(f'    text(size: 0.85em)[#text(weight: "bold")[Actualisation :] {source["actualisation"]}],')
            if source['disponibilite']:
                lines.append(f'    text(size: 0.85em)[#text(weight: "bold")[Disponibilité :] {source["disponibilite"]}],')
            if source['url'] and 'http' in source['url']:
                lines.append(f'    link("{source["url"]}")[#text(size: 0.85em, fill: brand)[Accéder à la ressource]],')
            if source['rem']:
                lines.append(f'    text(size: 0.85em, style: "italic")[{source["rem"]}],')
            lines.append('  )')
            lines.append(')')
            lines.append('#v(0.5em)')
    else:
        lines.append('#text(size: 0.9em)[Aucune source de donnée identifiée.]')

    lines.append('#pagebreak()')
    lines.append('')

    return "\n".join(lines)


def build_theme_index(df_ind):
    themes = {}
    for _, row in df_ind.iterrows():
        id_ind = v(row, 'id_indicateur')
        nom_ind = v(row, 'nom_indicateur')
        if not is_valid_data(id_ind, nom_ind):
            continue
        theme = v(row, 'Nom_theme') or 'Non classé'
        themes.setdefault(theme, []).append({'id': id_ind, 'nom': nom_ind})
    return themes


def render_index_typst(themes, title, subtitle, author):
    lines = []
    lines.append('#import "template_typst.typ": *')
    lines.append('')
    # Page de titre
    lines.append('#align(center)[')
    lines.append(f'  #text(size: 2em, weight: "bold")[{typst_escape(title)}]')
    lines.append('  #v(0.5em)')
    lines.append(f'  #text(size: 1.1em, fill: rgb("#444444"))[{typst_escape(subtitle)}]')
    lines.append('  #v(0.3em)')
    lines.append(f'  #text(size: 0.9em, fill: rgb("#888888"))[{typst_escape(author)}]')
    lines.append(']')
    lines.append('#v(2em)')
    # Table des matières
    lines.append('#outline(title: "Table des matières", depth: 2, indent: 1em)')
    lines.append('#pagebreak()')
    lines.append('')
    # Inclusion des fiches par thème
    for theme, items in sorted(themes.items(), key=lambda x: x[0] or ''):
        lines.append(f'= {typst_escape(theme)}')
        lines.append('')
        for item in items:
            lines.append(f'#include "fiches_typst/{item["id"]}.typ"')
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


def main():
    print('🚀 Génération Typst des fiches...')
    try:
        tabs = pd.read_excel(XLSX, sheet_name=None)
    except Exception as exc:
        print(f'❌ Impossible de charger {XLSX}: {exc}')
        return

    df_ind = tabs['indicateurs']
    df_src = tabs['sources']
    df_rel = tabs['relation indicateur source']
    df_group = tabs['groupes']
    df_rel_group = tabs['relation groupe objectifs']
    df_vigi = tabs['vigilances']

    for df in [df_ind, df_src, df_rel, df_group, df_rel_group, df_vigi]:
        df.columns = df.columns.str.strip()

    context = build_group_context(df_ind, df_group, df_rel_group)
    FICHES_TYPST_DIR.mkdir(exist_ok=True)

    themes = build_theme_index(df_ind)
    count = 0

    for _, row in df_ind.iterrows():
        id_ind = v(row, 'id_indicateur')
        nom_ind = v(row, 'nom_indicateur')
        if not is_valid_data(id_ind, nom_ind):
            continue
        typst_content = render_typst_page(row, context, df_src, df_rel, df_vigi)
        path = FICHES_TYPST_DIR / f'{id_ind}.typ'
        path.write_text(typst_content, encoding='utf-8')
        count += 1

    print(f'✅ {count} fiches Typst générées dans {FICHES_TYPST_DIR}/')

    index_content = render_index_typst(
        themes,
        'Fiches indicateurs HydroScope',
        'Catalogue des indicateurs de suivi et de comparaison des unités de gestion AEP',
        'Hugo Roussaffa'
    )
    index_path = Path('index_typst.typ')
    index_path.write_text(index_content, encoding='utf-8')
    print('✅ index_typst.typ mis à jour.')

    print('📄 Compilation PDF...')
    compile_typst(index_path, Path('catalogue_hydroscope.pdf'))


if __name__ == '__main__':
    main()
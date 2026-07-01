#!/usr/bin/env python3
"""
Génération Typst des fiches indicateurs HydroScope.
"""

import csv
import subprocess
import pandas as pd
from pathlib import Path
from datetime import date
from collections import defaultdict

from generate_fiches_indicateurs import (
    v, is_valid_data, build_group_context,
    extract_vigilances, get_theme_color, vision_color_from_group_id,
)

# ══════════════════════════════════════════════════════════════════════════════
# CONFIGURATION GLOBALE
# ══════════════════════════════════════════════════════════════════════════════

XLSX                   = Path("fiches indicateurs.xlsx")
FICHES_TYPST_DIR       = Path("fiches_typst")
CSV_SUIVI_COMMENTAIRES = Path("suivi_commentaires_modifications_fiches_HydroScope.csv")

PROJECT = {
    "title":    "Fiches indicateurs HydroScope",
    "subtitle": "Catalogue des indicateurs de suivi et de comparaison des unités de gestion AEP",
    "author":   "Hugo Roussaffa",
    "version":  "0.3",
}

VERSION_HISTORY = [
    ("0.1", "2026-05-18", "Hugo Roussaffa", "Rédaction initiale des fiches indicateurs"),
    ("0.2", "2026-06-08", "Hugo Roussaffa",
     "Réorganisation en groupes, mise en forme compacte et corrections suite aux commentaires"),
    ("0.3", "2026-06-16", "Hugo Roussaffa",
     "Intégration annexe suivi des modifications. Correction et réajustement de plusieurs "
     "choix d'organisation proposés par Marjolaine David"),
]

# Palette de couleurs par rôle — modifier ici pour changer tout le rendu
ROLE_COLORS = {
    "agir":   "#005596",
    "surveiller":     "#2E7D32",
    "comprendre": "#546E7A",
    "default":    "#546E7A",
}


# ══════════════════════════════════════════════════════════════════════════════
# UTILITAIRES
# ══════════════════════════════════════════════════════════════════════════════

def typst_escape(value) -> str:
    """Échappe les caractères spéciaux pour Typst."""
    if value is None:
        return ""
    replacements = [
        ("\\", "\\\\"), ('"', '\\"'), ("[", "\\["), ("]", "\\]"),
        ("/", "\\/"),   ("(", "\\("), (")", "\\)"), ("\n", " "),
        ("\r", " "),    ("`", "'"),   ("_", "\\_"), ("-", "\\-"),
        ("?", "\\?"),
    ]
    text = str(value)
    for old, new in replacements:
        text = text.replace(old, new)
    return text.strip()


def make_safe_name(name: str) -> str:
    """Convertit un nom en identifiant de fichier sûr."""
    char_map = {
        ' ': '_', '/': '_', 'é': 'e', 'è': 'e', 'ê': 'e',
        'à': 'a', 'â': 'a', 'ù': 'u', 'û': 'u',
        'î': 'i', 'ô': 'o', 'ç': 'c',
    }
    result = typst_escape(name).lower()
    for char, replacement in char_map.items():
        result = result.replace(char, replacement)
    return result


def get_column_value(row, names: list) -> str:
    """Récupère une valeur en testant plusieurs variantes de nom de colonne."""
    for name in names:
        if name in row:
            return row[name]
        for key in row.keys():
            if key.lower().strip() == name.lower().strip():
                return row[key]
    return ""


def role_color(role: str) -> str:
    """Retourne la couleur hex associée à un rôle."""
    role_lower = str(role).lower()
    for key, color in ROLE_COLORS.items():
        if key in role_lower:
            return color
    return ROLE_COLORS["default"]


# ══════════════════════════════════════════════════════════════════════════════
# HELPERS DE BLOCS TYPST
# Chaque helper retourne une liste de lignes (str).
# ══════════════════════════════════════════════════════════════════════════════

def _block(content_lines: list, *, fill="", stroke="", radius="",
           inset="", width="100%", extra: list = None) -> list:
    """Génère un #block(..., contenu)."""
    args = [f"  width: {width}"]
    if fill:   args.append(f"  fill: {fill}")
    if stroke: args.append(f"  stroke: {stroke}")
    if radius: args.append(f"  radius: {radius}")
    if inset:  args.append(f"  inset: {inset}")
    if extra:  args.extend(f"  {a}" for a in extra)
    return ["#block(", *[a + "," for a in args], *content_lines, ")"]


def _grid_1col(content_lines: list, row_gutter="4pt") -> list:
    """Grid mono-colonne pour empiler du contenu."""
    return [
        "  grid(", "    columns: 1,",
        f"    row-gutter: {row_gutter},",
        *content_lines, "  )",
    ]


def _grid_2col(left: list, right: list, col_gutter="8pt", align="horizon") -> list:
    """Grid 2 colonnes (1fr + auto)."""
    return [
        "  grid(", "    columns: (1fr, auto),",
        f"    column-gutter: {col_gutter},", f"    align: {align},",
        *left, *right, "  )",
    ]


def _text(content: str, size="1em", weight="regular", fill="", style="") -> str:
    """Retourne une expression text() Typst."""
    args = [f"size: {size}"]
    if weight != "regular": args.append(f'weight: "{weight}"')
    if fill:  args.append(f"fill: {fill}")
    if style: args.append(f'style: "{style}"')
    return f'text({", ".join(args)})[{content}]'


def _kv_line(label: str, value: str, size="0.72em",
             label_color='rgb("#475569")') -> str:
    """Ligne clé : valeur (retourne une ligne Typst)."""
    return (f'text(size: {size})'
            f'[#text(fill: {label_color}, weight: "medium")[{label} :] {value}],')


# ══════════════════════════════════════════════════════════════════════════════
# BLOCS COMPOSITES RÉUTILISABLES
# ══════════════════════════════════════════════════════════════════════════════

def bloc_theme_bandeau(theme_text: str, color: str) -> list:
    """Bandeau coloré pleine largeur avec juste le titre."""
    return [
        f'#block(width: 100%, fill: rgb("{color}"), radius: 4pt,',
        f'  inset: (x: 14pt, y: 12pt),',
        f'  {_text(theme_text, size="1.2em", weight="bold", fill="white")}',
        ')',
    ]


def bloc_theme_description(definition: str, objectif: str) -> list:
    """Bloc définition + objectif sous le bandeau thème."""
    if not definition and not objectif:
        return []
    content = []
    if definition:
        content.append(f'    {_text(definition, size="0.82em", style="italic", fill="rgb(\"#475569\")")},')
    if objectif:
        content.append(
            f'    text(size: 0.82em, fill: rgb("#1e293b"))'
            f'[#text(weight: "bold")[Objectif :] {objectif}],'
        )
    return _block(_grid_1col(content, row_gutter="4pt"),
                  inset="(x: 2pt, top: 6pt, bottom: 4pt)")


def bloc_groupe_bandeau(nom: str, objectif: str, explication: str,
                        role_text: str, color: str) -> list:
    """Bandeau groupe : bordure gauche colorée + badge rôle."""
    left = [
        "    grid(", "      columns: 1,", "      row-gutter: 3pt,",
        f'      {_text(nom, size="1em", weight="bold")},',
        f'      {_text(objectif or "", size="0.85em", fill="rgb(\"#333333\")")},',
    ]
    if explication:
        left.append(
            f'      {_text(explication, size="0.8em", style="italic", fill="rgb(\"#666666\")")},')
    left.append("    ),")

    right = [
        f'    box(fill: rgb("{color}"), radius: 999pt,',
        f'      inset: (x: 10pt, y: 5pt),',
        f'      text(size: 0.75em, weight: "bold", fill: white)[{role_text.upper()}]',
        '    ),',
    ]
    return _block(
        _grid_2col(left, right, col_gutter="8pt"),
        stroke=f'(left: 5pt + rgb("{color}"))',
        fill="luma(252)", radius="(right: 6pt)",
        inset="(left: 12pt, right: 10pt, top: 8pt, bottom: 8pt)",
    )


def bloc_indicateurs_grid(indicateurs: list, color: str) -> list:
    """Grille Fiche n° / Nom indicateur avec liens internes."""
    if not indicateurs:
        return []
    rows = []
    for ind in indicateurs:
        num = typst_escape(str(ind.get('num_fiche') or ind.get('id') or ''))
        nom = typst_escape(str(ind.get('nom') or ''))
        lid = f"ind-{num.replace(' ', '-').replace('°', '')}"
        rows += [
            f'    text(size: 0.8em, fill: rgb("#555555"))[#link(<{lid}>)[{num}]],',
            f'    text(size: 0.8em)[#link(<{lid}>)[{nom}]],',
        ]
    content = [
        "  grid(", "    columns: (40pt, 1fr),",
        "    row-gutter: 4pt,", "    column-gutter: 6pt,",
        f'    text(size: 0.78em, weight: "bold", fill: rgb("{color}"))[Fiche n°],',
        f'    text(size: 0.78em, weight: "bold", fill: rgb("{color}"))[Indicateur],',
        *rows, "  )",
    ]
    return _block(content, inset="(left: 17pt)")


def _sub_section(label: str, value: str) -> list:
    """Sous-section label + valeur dans la colonne analyse."""
    return [
        '      0.7em,',
        '      stack(dir: ttb, spacing: 0.4em,',
        f'        text(size: 0.75em, weight: "bold")[{label}],',
        f'        text(size: 0.71em)[{value}],',
        '      ),',
    ]


# ══════════════════════════════════════════════════════════════════════════════
# GÉNÉRATION DES FICHIERS TYPST
# ══════════════════════════════════════════════════════════════════════════════

def _file_header(tpl="../template_typst.typ") -> list:
    return [f'#import "{tpl}": *', '']


def generate_typst_note_version(output_path):
    rows = '\n'.join(
        f'  [{v}], [{d}], [{a}], [{typst_escape(desc)}],'
        for v, d, a, desc in VERSION_HISTORY
    )
    today = date.today().strftime("%d/%m/%Y")
    content = (
        f"= {PROJECT['title']}\n\n"
        f"*{PROJECT['subtitle']}*\n\n"
        f"Version {PROJECT['version']} — {today}\n\n"
        f"*Historique des versions du document :*\n\n"
        "#table(\n"
        "  columns: (auto, auto, auto, 1fr),\n"
        "  fill: (x, y) => if y == 0 { luma(230) } else { none },\n"
        "  [*Version*], [*Date*], [*Auteur(s)*], [*Description des modifications*],\n"
        f"{rows}\n)\n\n"
        f"""\nLes fiches indicateurs présentées dans ce catalogue sont destinées à fournir 
        une description détaillée de chaque indicateur de suivi et de comparaison des captages AEP.
        Les fiches sont organisées par famille (Enjeu, pression, vulnerabilité) et par groupe d'objectif commun
        (Comprendre, Agir, Surveiller) pour faciliter la navigation et apporter une dimension métier sur les groupes d'indicateur.
        Chaque fiche comprend une identification claire de l'indicateur, des sections détaillées sur 
        les méthodes de calcul, les modalités de visualisation, ainsi que les sources de données qui lui 
        sont associées.\n\n"""
        "#pagebreak()\n"
    )
    Path(output_path).write_text(content, encoding='utf-8')
    print(f"✅ Note de version : {output_path}")


def generate_typst_glossary(df, output_path):
    items = df[df['glossaire'].str.lower() == 'oui'].sort_values('libelle_affiche')
    rows = '\n'.join(
        f'  [*{row["libelle_affiche"]}*], [{row["description"]}],'
        for _, row in items.iterrows()
    )
    content = (
        "= Glossaire des attributs <masque> \n\n"
        '#block('
        'width: 100%,'
        'stroke: (top: 4pt + rgb("#005596")),'
        'inset: (top: 10pt, bottom: 8pt, left: 0pt, right: 0pt),'
        'stack(dir: ttb, spacing: 0.4em,'
        '  text(size: 1.5em, weight: "bold", tracking: 1pt)[Glossaire]'
        ')'
        ')'
        '#v(1em)'
        "#grid(\n  columns: (1.5in, 1fr),\n  gutter: 15pt,\n  stroke: none,\n"
        f"{rows}\n)\n"
        "#pagebreak()\n"
    )
    Path(output_path).write_text(content, encoding='utf-8')
    print(f"✅ Glossaire : {output_path}")




def generate_typst_annexe_suivi_modification(output_path, csv_path):
    # En-tête global du fichier (titre et configuration de la page)
    lines = [
        
        " #set page(",
        '     paper: "a2",',
        "     flipped: true,",
        "     margin: (x: 1.5cm, y: 1.5cm),",
        "     )",
        "#show figure: set block(breakable: true)",
        ""
        "= Suivi détaillé des modifications",
        
    ]

    # Structure pour stocker nos lignes par statut : { "Statut A": [ ligne1, ligne2, ... ], "Statut B": [...] }
    groupes_statut = defaultdict(list)

    # 1. ÉTAPE DE LECTURE : On extrait et on regroupe par statut
    try:
        with open(csv_path, encoding="utf-8-sig") as f:
            for row in csv.DictReader(f, delimiter=";"):
                # Récupération du statut pour la clé de regroupement
                statut_brut = get_column_value(row, ["Statut", "statut"])
                statut = (
                    typst_escape(statut_brut).strip()
                    if statut_brut
                    else "Non renseigné"
                )

                cols = [
                    typst_escape(
                        get_column_value(row, ["version_document", "version"])
                    ),
                    typst_escape(get_column_value(row, ["Date", "date"])),
                    typst_escape(get_column_value(row, ["page", "Page"])),
                    typst_escape(get_column_value(row, ["auteur", "Auteur"])),
                    typst_escape(get_column_value(row,["texte_surligné","texte_surligne","texte",],)),
                    typst_escape(
                        get_column_value(row, ["commentaire", "commentaires"])
                    ),
                    statut,  # Le statut nettoyé
                    typst_escape(
                        get_column_value(
                            row, ["Résolution", "Resolution", "resolution"]
                        )
                    ),
                ]

                # Formatage de la ligne de cellules Typst
                typst_row = "    " + ", ".join(f"[{c}]" for c in cols) + ","
                groupes_statut[statut].append(typst_row)

    except FileNotFoundError:
        print(f"⚠️  CSV introuvable : {csv_path}")
        return
    except Exception as exc:
        print(f"⚠️  Erreur lecture CSV : {exc}")
        return

    # 2. ÉTAPE DE GÉNÉRATION : On crée un tableau distinct par statut trouvé
    for statut, lignes_tableau in groupes_statut.items():
        # Sous-titre pour chaque Statut et ouverture de la figure / table
        lines += [
            f"== Statut : {statut}",
            "",
            " #figure(",
            f"  caption: [Suivi des commentaires et résolutions — {statut}],",
            "  table(",
            "     columns: (0.3fr, 0.4fr, 0.3fr, 0.4fr, 2fr, 1.2fr, 0.4fr, 2fr),",
            "     align: (",
            "     center + horizon,",
            "     center + horizon,",
            "     left + horizon,",
            "     left + horizon,",
            "     left + horizon,",
            "     center + horizon,",
            "     left + horizon,",
            "     left + horizon",  # Correction de la virgule d'alignement manquante (8 colonnes)
            "     ),",
            "     inset: 8pt,",
            "     stroke: 0.5pt + luma(150),",
            "     fill: (x, y) => if y == 0 { luma(240) } else { none },",  # Optionnel : distingue l'en-tête
            "     table.header(",
            "     [*Version*],",
            "     [*Date*],",
            "     [*Page*],",
            "     [*Auteur*],",
            "     [*Texte surligné*],",
            "     [*Commentaire*],",
            "     [*Statut*],",
            "     [*Résolution*]",
            "     ),",
        ]

        # Injection des lignes de données spécifiques à ce statut
        lines += lignes_tableau

        # Fermeture de la table et de la figure pour ce statut
        lines += ["  )", ")", ""]

    # Écriture finale sur le disque
    Path(output_path).write_text("\n".join(lines), encoding="utf-8")
    print(f"✅ Annexe suivi générée par statut : {output_path}")


def generate_family_entete(famille_name: str, themes_data: dict, df_ind) -> str:
    # Couleur depuis le premier groupe
    dom_color = ROLE_COLORS["default"]
    for _, gd in sorted(themes_data.items()):
        for gid, gi in sorted(gd.items()):
            if gid != '__metadata__':
                dom_color = role_color(gi.get('role', ''))
                break
        break

    # Types d'indicateurs
    tous_types = sorted({
        ind['type'].strip()
        for gd in themes_data.values()
        for k, gi in gd.items() if k != '__metadata__'
        for ind in gi.get('indicateurs', []) if ind.get('type')
    })
    famille_type = typst_escape(' / '.join(tous_types))

    # Objectif
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
    lines = _file_header()
    lines += ['// ─── ENTÊTE FAMILLE ──────────────────────────────────────────']

    bandeau = [
        '  stack(dir: ttb, spacing: 0.4em,',
        f'    text(size: 1.5em, weight: "bold", tracking: 1pt)[{famille_text.upper()}],',
    ]
    if famille_type:
        bandeau.append(
            f'    box(fill: rgb("{dom_color}"), radius: 4pt, inset: (x: 8pt, y: 4pt),'
            f' text(size: 0.8em, weight: "bold", fill: white)[TYPE : {famille_type.upper()}]),'
        )
    bandeau.append('  )')
    lines += _block(bandeau,
                    stroke=f'(top: 4pt + rgb("{dom_color}"))',
                    inset="(top: 10pt, bottom: 8pt, left: 0pt, right: 0pt)")
    lines += ['#v(0.6em)']

    if famille_objectif:
        lines += _block(
            [f'  text(size: 0.95em, style: "italic", fill: rgb("#333333"))[{famille_objectif}]'],
            fill="luma(245)", radius="6pt", inset="12pt",
        )
        lines += ['#v(0.6em)']

    lines += ['']
    return '\n'.join(lines)


def generate_theme_toc(famille_name: str, theme_name: str, groupe_data: dict) -> str:
    meta          = groupe_data.get('__metadata__', {})
    theme_def     = typst_escape(meta.get('definition') or '')
    theme_obj     = typst_escape(meta.get('objectif')   or '')
    theme_text    = typst_escape(theme_name or 'Thème')

    dom_color = ROLE_COLORS["default"]
    for gid, gi in sorted(groupe_data.items()):
        if gid != '__metadata__':
            dom_color = role_color(gi.get('role', ''))
            break

    lines = _file_header()
    lines += [f'// ─── TOC THÈME : {theme_text} ───────────────────────────────']
    lines += bloc_theme_bandeau(theme_text, dom_color)
    lines += bloc_theme_description(theme_def, theme_obj)
    lines += ['#v(0.8em)']

    for group_id, group_info in sorted(groupe_data.items()):
        if group_id == '__metadata__':
            continue
        grole   = str(group_info.get('role') or 'Pilotage')
        gcolor  = role_color(grole)
        indics  = sorted(
            group_info.get('indicateurs', []),
            key=lambda x: int(x['num_fiche']) if str(x.get('num_fiche', '')).isdigit() else 0,
        )
        lines += bloc_groupe_bandeau(
            typst_escape(group_info.get('nom') or ''),
            typst_escape(group_info.get('objectif') or ''),
            typst_escape(group_info.get('explication_role') or ''),
            grole, gcolor,
        )
        lines += ['#v(0.4em)']
        lines += bloc_indicateurs_grid(indics, gcolor)
        lines += ['#v(0.7em)']

    lines += ['#pagebreak()', '']
    return '\n'.join(lines)


def render_typst_page(row, context, df_src, df_rel, df_vigi) -> str:
    id_ind  = v(row, 'id_indicateur')
    nom_ind = v(row, 'nom_indicateur')
    famille = v(row, 'famille_indicateur')
    theme   = v(row, 'Nom_theme')

    selected_group = next(
        (g for g in context['groups'].values()
         if any(i.get('nom') == nom_ind or i.get('id') == id_ind for i in g['indicateurs'])),
        None,
    )
    brand_color = (
        (selected_group and vision_color_from_group_id(selected_group.get('id')))
        or get_theme_color(famille or theme)
        or '#005596'
    )
    sg = selected_group or {}
    grole            = sg.get('role', '')
    groupe_nom       = typst_escape(sg.get('nom', ''))
    fiche_esc        = typst_escape(str(v(row, 'fiche_indicateur') or '?'))

    def esc(field): return typst_escape(v(row, field))

    title_esc    = typst_escape(nom_ind or 'Indicateur')
    description  = esc('description_indicateur')
    objectif     = esc('objectif')
    priorite     = esc('priorite')
    unite        = esc('unite')
    modalites    = esc('modalites')
    normalisation = esc('normalisation_methode')
    sens         = esc('sens_indicateur')
    criticite    = esc('definition_criticite')
    synthese     = esc('synthese_echanges')

    fields_tech = {
        "Unité":               esc('unite'),
        "Support spatial":     esc('support_spatial'),
        "Pondération":         esc('Ponderation'),
        "Spatialisation H3":   esc('spatialisation_H3'),
        "Nature des données":  esc('quantitatif_qualitatif'),
        "Disponibilité":       esc('statut_disponibilite'),
    }
    fields_visu = {
        "Nature des données":          esc('quantitatif_qualitatif'),
        "Discret ou continu":          esc('discret_continu'),
        "Relatif ou absolu":           esc('relatif_absolu'),
        "Représentation cartographique": esc('representation_cartographique'),
        "Implantation":                esc('implantation'),
    }

    role_lower = str(grole).lower()
    role_text  = typst_escape(grole or 'Pilotage')
    role_icon  = (
        '🎯' if 'agir'   in role_lower else
        '👁'  if 'surveiller'    in role_lower else
        '🔬' if 'comprendre' in role_lower else '📌'
    )
    if sens:
        sl = sens.lower()
        arrow, arrow_color = (
            ('↑', '#2e7d32') if 'positif' in sl else
            ('↓', '#c62828') if 'négatif' in sl else
            ('↔', '#555555')
        )
    else:
        arrow, arrow_color = '', '#555555'

    # Sources
    rel_ids = (
        df_rel[
            (df_rel['id_indicateur'].astype(str).str.replace('.0','',regex=False) == str(id_ind)) &
            (df_rel['actif'].astype(str).str.strip().str.capitalize() == 'Oui')
        ]['id_ressource'].astype(str).str.replace('.0','',regex=False).tolist()
    )
    sources = []
    for _, s in df_src[
        df_src['id_ressource'].astype(str).str.replace('.0','',regex=False).isin(rel_ids)
    ].iterrows():
        sources.append({k: typst_escape(v(s, col) or '') for k, col in {
            'nom': 'nom_ressource', 'origine': 'origine', 'distributeur': 'distributeur',
            'couverture': 'couverture_spatiale', 'actualisation': 'actualisation',
            'type_source': 'type_source', 'disponibilite': 'statut_disponibilite',
            'url': 'url', 'description': 'description_ressource',
            'contraintes': 'contraintes_ressource',
        }.items()})

    vigils    = extract_vigilances(df_vigi, id_ind, nom_ind)
    clean_id  = fiche_esc.replace(' ', '-').replace('°', '')

    # ── Construction ─────────────────────────────────────────────────
    L = _file_header()
    L += [
        '', f'#let brand = rgb("{brand_color}")', '',
    ]

    # En-tête titre + numéro
    L += [
        '#grid(', '  columns: (1fr, auto),', '  column-gutter: 1cm,',
        '  align: (left + horizon, right + horizon),',
        f'  [#text(size: 1.6em, weight: "bold", fill: brand)[{title_esc}]],',
        '  [#box(fill: rgb("#f1f5f9"), inset: (x: 10pt, y: 6pt), radius: 4pt,',
        f'    stroke: 1.2pt + brand,',
        f'    [#text(size: 0.85em, weight: "bold", fill: brand)[FICHE {fiche_esc} <ind-{clean_id}>]]',
        '  )],',
        ')',
        '#v(0.5em)', '#line(length: 100%, stroke: 0.5pt + rgb("#d9e2ea"))', '#v(0.5em)',
    ]

    # Badges rôle / groupe
    L += [
        '#stack(dir: ltr, spacing: 0.6em,',
        '  box(fill: brand.lighten(90%), stroke: 0.5pt + brand,',
        '    inset: (x: 6pt, y: 4pt), radius: 3pt,',
        f'    text(size: 0.78em, weight: "bold", fill: brand)[{role_icon} {role_text}]',
        '  ),',
    ]
    if groupe_nom:
        L += [
            '  box(fill: rgb("#f1f5f9"), stroke: 0.5pt + rgb("#cbd5e1"),',
            '    inset: (x: 6pt, y: 4pt), radius: 3pt,',
            f'    text(size: 0.75em, fill: rgb("#475569"))[{groupe_nom}]',
            '  ),',
        ]
    L += [')', '#v(0.6em)']

    # Bloc description
    if description:
        inner = [
            '  stack(dir: ttb, spacing: 0.4em,',
            f'    text(size: 0.73em, style: "italic", fill: rgb("#334155"))[{description}],',
        ]
        if objectif:
            inner += [
                '    1em,',
                f'    text(size: 0.71em, weight: "bold", fill: rgb("#1a365d"))[Objectif :],',
                f'    text(size: 0.71em, fill: rgb("#1a202c"))[{objectif}],',
            ]
        if priorite:
            inner += [
                '    0.5em,',
                f'    text(size: 0.71em, weight: "bold", fill: rgb("#1a365d"))[Prioritaire : {priorite}],',
            ]
        inner.append('  )')
        L += _block(inner, fill='rgb("#f8fafc")',
                    stroke='(left: 4pt + rgb("#64748b"))',
                    radius="2pt", inset="(x: 10pt, y: 8pt)")
        L += ['#v(0.5em)']

    # Grille 2 colonnes
    L += ['#grid(', '  columns: (1.65fr, 1fr),', '  column-gutter: 10pt,', '  align: (top, top),']

    # Colonne gauche : Analyse
    left = [
        '  box(width: 100%, fill: fiche_bg, stroke: 0.5pt + fiche_border,',
        '    radius: 3pt, inset: 8pt,',
        '    stack(dir: ttb, spacing: 0.35em,',
        '      text(size: 0.85em, weight: "bold")[Analyse multicritère et mesure de criticité],',
    ]
    if modalites:     left += _sub_section("Modalités de traitement", modalites)
    if normalisation: left += _sub_section("Normalisation", normalisation)
    if criticite:     left += _sub_section("Définition de la criticité", criticite)
    if sens:
        left += [
            '      0.7em,', '      stack(dir: ttb, spacing: 0.4em,',
            "        text(size: 0.75em, weight: \"bold\")[Sens de l\\'indicateur],",
            f'        text(size: 0.71em)[{sens} #h(0.2em) '
            f'#text(fill: rgb("{arrow_color}"), size: 0.95em)[{arrow}]],',
            '      ),',
        ]
    left += ['    )', '  ),']
    L += left

    # Colonne droite : Technique + Visualisation empilés
    def _kv_lines(fields: dict) -> list:
        return [f'        {_kv_line(lbl, val)}' for lbl, val in fields.items() if val]

    L += [
        '  stack(dir: ttb, spacing: 0pt,',
        '    block(breakable: true, width: 100%, fill: fiche_bg,',
        '      stroke: 0.5pt + fiche_border,',
        '      radius: (top-left: 3pt, top-right: 3pt, bottom-left: 0pt, bottom-right: 0pt),',
        '      inset: 8pt,',
        '      stack(dir: ttb, spacing: 0.4em,',
        '        text(size: 0.85em, weight: "bold")[Critère technique], v(0.4em),',
        *_kv_lines(fields_tech),
        '      )',
        '    ),',
        '    v(0.7em),',
        '    box(width: 100%, fill: fiche_bg,',
        '      stroke: (top: 0pt, bottom: 0.5pt + fiche_border,'
        ' left: 0.5pt + fiche_border, right: 0.5pt + fiche_border),',
        '      radius: (top-left: 0pt, top-right: 0pt, bottom-left: 3pt, bottom-right: 3pt),',
        '      inset: 8pt,',
        '      stack(dir: ttb, spacing: 0.5em,',
        '        text(size: 0.85em, weight: "bold")[Modalités de visualisation], v(0.4em),',
        *_kv_lines(fields_visu),
        '      )',
        '    ),',
        '  ),',
        ')', '#v(0.7em)',
    ]

    # Vigilances
    if vigils or synthese:
        vigi = [
            '  stack(dir: ttb, spacing: 0.3em,',
            '    text(size: 0.85em, weight: "bold", fill: rgb("#c62828"))[Point de vigilance],',
        ]
        if synthese:
            vigi += [
                '    0.7em,', '    stack(dir: ttb, spacing: 0.1em,',
                '      text(size: 0.75em, weight: "bold")[Résumé des échanges],',
                f'      text(size: 0.71em)[{synthese}],', '    ),',
            ]
        for vigil in vigils:
            vigi += [
                '    0.7em,', '    stack(dir: ttb, spacing: 0.1em,',
                f'      text(size: 0.75em, weight: "bold")[{typst_escape(vigil.get("type_vigilance") or "")}],',
                f'      text(size: 0.71em)[{typst_escape(vigil.get("description") or "")}],',
                '    ),',
            ]
        vigi.append('  )')
        L += _block(vigi, fill='rgb(255, 250, 240)',
                    stroke='1.5pt + rgb("#c62828")', radius="3pt", inset="8pt")
        L += ['#v(0.7em)']

    # Sources
    L += [
        '#text(size: 0.85em, weight: "bold")[Sources & fiabilité]', '#v(0.4em)',
        '#block(breakable: true, width: 100%, fill: fiche_bg,',
        '  stroke: 0.5pt + rgb("#dce4eb"), radius: 3pt, inset: 8pt,',
        '  stack(dir: ttb, spacing: 0.25em,',
    ]
    if sources:
        src_labels = [
            ("Description", "description"), ("Origine", "origine"),
            ("Distributeur", "distributeur"), ("Couverture spatiale", "couverture"),
            ("Actualisation", "actualisation"), ("Type de source", "type_source"),
            ("Disponibilité", "disponibilite"), ("Contraintes", "contraintes"),
        ]
        for s in sources:
            L.append(f'    text(size: 0.8em, weight: "bold")[{s["nom"]}],')
            L.append('    0.7em,')
            for label, key in src_labels:
                if s[key]:
                    L += [f'    text(size: 0.75em)[#text(weight: "bold")[{label} :] {s[key]}],', '    0.5em,']
            if s['url'] and 'http' in s['url']:
                L += [f'    text(size: 0.75em)[#link("{s["url"]}")[🔗 Accès à la ressource]],', '    0.5em,']
            L.append('    0.7em,')
    else:
        L.append('    text(size: 0.71em, style: "italic")[Aucune source de donnée identifiée.]')

    L += ['  )', ')', '#v(0.5em)', '#pagebreak()', '']
    return '\n'.join(L)


def render_index_typst(families: dict) -> str:
    today = date.today().strftime("%d/%m/%Y")
    lines = ['#import "template_typst.typ": *', '']

    # Couverture
    lines += [
        '// ─── PAGE DE COUVERTURE ──────────────────────────────────────',
        '#set page(margin: (x: 2cm, y: 2.5cm), header: none, footer: none)', '',
        '#align(center + horizon)[',
        '  #line(length: 40%, stroke: 3pt + color_orange)', '  #v(1.5em)',
        f'  #text(size: 2.6em, weight: "bold", fill: color_orange)[{typst_escape(PROJECT["title"])}]',
        '  #v(1em)',
        f'  #text(size: 1.3em, style: "italic", fill: color_grey)[{typst_escape(PROJECT["subtitle"])}]',
        '  #v(2em)', '  #line(length: 20%, stroke: 1pt + color_grey)', '  #v(2em)',
        f'  #text(size: 1.1em, weight: "medium", fill: color_black)[{typst_escape(PROJECT["author"])}]',
        '  #v(0.6em)',
        f'  #text(size: 0.95em, fill: color_grey)[Rapport généré le {today}]',
        ']', '#pagebreak()', '',
    ]

    # Config pages internes
    lines += [
        '#set page(',
        '  paper: "a4",',
        '  margin: (top: 2.5cm, bottom: 2.5cm, left: 2.5cm, right: 2.5cm),',
        '  footer: context align(center,',
        '    text(size: 8pt, fill: color_grey,',
        '      counter(page).display("1 / 1", both: true)',
        '    )', '  ),', ')', '',
        '#show heading.where(level: 1).and(<masque>): it => {}',
        '#show heading.where(level: 2).and(<masque>): it => {}',
        '#show heading.where(level: 3).and(<masque>): it => {}',
        '',
        '#include "fiches_typst/note_version.typ"', '',
        '#text(fill: color_orange)[',
        '  #outline(title: "Table des matières", depth: 3, indent: 1em)',
        ']', '#pagebreak()', '',
        '#include "fiches_typst/glossaire.typ"', '',
    ]

    # Familles > Thèmes > Fiches
    for famille_name in sorted(families):
        sf = make_safe_name(famille_name)
        lines += [
            f'= {typst_escape(famille_name)} <masque>', '',
            f'#include "fiches_typst/famille_{sf}_entete.typ"', '',
        ]
        for theme_name, groupe_data in sorted(families[famille_name].items()):
            st = make_safe_name(theme_name)
            lines += [
                f'== {typst_escape(theme_name)} <masque>', '',
                f'#include "fiches_typst/famille_{sf}_theme_{st}_toc.typ"', '',
            ]
            for gid, gi in sorted(groupe_data.items()):
                if gid == '__metadata__':
                    continue
                for ind in sorted(
                    gi.get('indicateurs', []),
                    key=lambda x: int(x['num_fiche']) if str(x['num_fiche']).isdigit() else 0,
                ):
                    ind_id = str(ind.get('id') or '').strip()
                    if ind_id:
                        lines += [
                            f'=== {typst_escape(ind.get("nom") or "")} <masque>', '',
                            f'#include "fiches_typst/{ind_id}.typ"',
                        ]
            lines.append('')

    return '\n'.join(lines)


def build_family_index(df_ind, context) -> dict:
    families = {}
    for _, row in df_ind.iterrows():
        if str(v(row, 'actif')).strip().lower() not in ('true', '1', 'oui', 'yes'):
            continue
        id_ind  = v(row, 'id_indicateur')
        nom_ind = v(row, 'nom_indicateur')
        if not is_valid_data(id_ind, nom_ind):
            continue

        famille = v(row, 'famille_indicateur') or 'Non classé'
        sg = next(
            (g for g in context['groups'].values()
             if any(i.get('nom') == nom_ind or i.get('id') == id_ind for i in g['indicateurs'])),
            None,
        )
        group_id = (sg or {}).get('id') or 'sans_groupe'
        st = next(
            (t for t in context['themes'].values()
             if any(g.get('id') == group_id for g in t['groups'])),
            None,
        )
        theme = (st or {}).get('nom') or 'Sans thème'

        families.setdefault(famille, {})
        families[famille].setdefault(theme, {'__metadata__': {
            'nom': (st or {}).get('nom', ''), 'role': (st or {}).get('role', ''),
            'objectif': (st or {}).get('objectif', ''), 'definition': (st or {}).get('definition', ''),
        }})
        families[famille][theme].setdefault(group_id, {
            'nom': (sg or {}).get('nom', ''), 'role': (sg or {}).get('role', ''),
            'objectif': (sg or {}).get('objectif', ''),
            'explication_role': (sg or {}).get('explication_role', ''),
            'indicateurs': [],
        })
        families[famille][theme][group_id]['indicateurs'].append({
            'id': id_ind, 'num_fiche': v(row, 'fiche_indicateur'), 'nom': nom_ind,
        })
    return families


def compile_typst(typ_file: Path, output_pdf: Path) -> bool:
    result = subprocess.run(
        ['typst', 'compile', str(typ_file), str(output_pdf)],
        capture_output=True, text=True,
    )
    if result.returncode == 0:
        print(f'✅ PDF généré : {output_pdf}')
        return True
    print(f'❌ Erreur Typst :\n{result.stderr}')
    return False


# ══════════════════════════════════════════════════════════════════════════════
# POINT D'ENTRÉE
# ══════════════════════════════════════════════════════════════════════════════

def main():
    print('🚀 Génération Typst des fiches HydroScope...')
    try:
        tabs = pd.read_excel(XLSX, sheet_name=None)
    except Exception as exc:
        print(f'❌ Impossible de charger {XLSX}: {exc}')
        return

    df_ind       = tabs['indicateurs']
    df_src       = tabs['sources']
    df_dict      = tabs['dictionnaire']
    df_rel       = tabs['relation indicateur source']
    df_group     = tabs['groupes']
    df_rel_group = tabs['relation groupe objectifs']
    df_vigi      = tabs['vigilances']
    df_theme     = tabs['themes']
    df_famille   = tabs['Familles']

    for df in [df_ind, df_src, df_rel, df_group, df_rel_group, df_vigi]:
        df.columns = df.columns.str.strip()

    context = build_group_context(df_ind, df_group, df_rel_group, df_theme, df_famille)
    FICHES_TYPST_DIR.mkdir(exist_ok=True)

    generate_typst_note_version(FICHES_TYPST_DIR / 'note_version.typ')
    generate_typst_glossary(df_dict, FICHES_TYPST_DIR / 'glossaire.typ')

    families = build_family_index(df_ind, context)
    count_fiches = count_entetes = count_tocs = 0

    for famille_name, themes_data in sorted(families.items()):
        sf = make_safe_name(famille_name)
        (FICHES_TYPST_DIR / f'famille_{sf}_entete.typ').write_text(
            generate_family_entete(famille_name, themes_data, df_ind), encoding='utf-8')
        count_entetes += 1
        print(f'  📋 Famille : {famille_name}')

        for theme_name, groupe_data in sorted(themes_data.items()):
            st = make_safe_name(theme_name)
            (FICHES_TYPST_DIR / f'famille_{sf}_theme_{st}_toc.typ').write_text(
                generate_theme_toc(famille_name, theme_name, groupe_data), encoding='utf-8')
            count_tocs += 1
            print(f'    📑 Thème : {theme_name}')

            for gid, gi in sorted(groupe_data.items()):
                if gid == '__metadata__':
                    continue
                for ind in sorted(
                    gi.get('indicateurs', []),
                    key=lambda x: int(x['num_fiche']) if str(x['num_fiche']).isdigit() else 0,
                ):
                    ind_id = ind.get('id')
                    if not ind_id:
                        continue
                    mask = (
                        df_ind['id_indicateur'].astype(str).str.replace('.0','',regex=False) == str(ind_id)
                    ) & (
                        df_ind['actif'].astype(str).str.strip().str.lower().isin(['true','1','oui','yes'])
                    )
                    ind_rows = df_ind[mask]
                    if ind_rows.empty:
                        print(f'    ⚠️  Indicateur {ind_id} introuvable')
                        continue
                    content = render_typst_page(ind_rows.iloc[0], context, df_src, df_rel, df_vigi)
                    (FICHES_TYPST_DIR / f'{ind_id}.typ').write_text(content, encoding='utf-8')
                    count_fiches += 1

    print(f'✅ {count_entetes} entêtes, {count_tocs} TOC thème, {count_fiches} fiches')

    index_content = render_index_typst(families)
    index_content += '\n#include "fiches_typst/annexe_suivi_modifications.typ"\n'
    index_path = Path('index_typst.typ')
    index_path.write_text(index_content, encoding='utf-8')
    print('✅ index_typst.typ généré')

    generate_typst_annexe_suivi_modification(
        FICHES_TYPST_DIR / 'annexe_suivi_modifications.typ',
        CSV_SUIVI_COMMENTAIRES,
    )

    compile_typst(index_path, Path(f'{PROJECT["title"]}-v{PROJECT["version"]}.pdf'))


if __name__ == '__main__':
    main()
#!/usr/bin/env python3
import pandas as pd
import yaml
import re
import html
from pathlib import Path
from datetime import date


# --- CONFIGURATION DU PROJET ---
XLSX = Path("fiches indicateurs.xlsx")
FICHES_DIR = Path("fiches")
FICHES_DIR.mkdir(exist_ok=True)

PROJECT = {
    "title":     "Fiches indicateurs HydroScope",
    "subtitle":  "Catalogue des indicateurs de suivi et de comparaison des unités de gestion AEP",
    "author":    "Hugo Roussaffa",
    "version":   "0.2",
}

def v(row, col):
    """Récupère une valeur proprement, gère les NaNs et le formatage."""
    val = row.get(col, "")
    if pd.isna(val) or str(val).strip().lower() in ["nan", "", "none"]:
        return None
    # Pour les IDs qui sortent parfois en 1.0, 2.0...
    res = str(val).strip()
    if res.endswith(".0"): res = res[:-2]
    return res

def is_valid_data(id_val, nom_val):
    """Détermine si la ligne est une donnée ou un en-tête/vide."""
    if not id_val or not nom_val: return False
    forbidden = ["id_indicateur", "nom_indicateur", "attribut", "id", "nom"]
    if str(id_val).lower() in forbidden or str(nom_val).lower() in forbidden:
        return False
    return True


def info_qmd(df_dict):
    """Génère un fichier QMD décrivant le dictionnaire des attributs (glossaire).

    Le DataFrame `df_dict` doit contenir au minimum une colonne `attribut`.
    Nous utilisons `libelle_affiche`, `affichage` et plusieurs variantes de
    description si elles existent (description, definition, remarques).
    """
    today = date.today().strftime("%d/%m/%Y")
    lines = ["\n# Glossaire des attributs\n\n"]

    # Rassembler les entrées et trier par libellé ou nom d'attribut
    entries = []
    for _, item in df_dict[df_dict['glossaire'] == 'oui'].iterrows():
        attr = (item.get('attribut') or '')
        attr = str(attr).strip()
        if not attr:
            continue
        label = (item.get('libelle_affiche') or '')
        label = str(label).strip()
        entries.append({'attribut': attr, 'libelle': label, 'row': item})

    def sort_key(e):
        key = e['libelle'] or e['attribut']
        return key.lower()

    entries.sort(key=sort_key)

    # Détails par attribut
    for e in entries:
        item = e['row']
        display = e['libelle'] or e['attribut']
        lines.append(f"\n**{display}** : ")
        # Description — chercher plusieurs noms possibles
        desc = None
        for key in ('description', 'definition', 'def', 'remarques', 'remarque'):
            if key in item and not pd.isna(item[key]):
                desc = str(item[key]).strip()
                break
        if desc:
            lines.append(f"\n{desc}\n")


    lines.append("\n")
    return "".join(lines)


def parse_indicator_ids(raw):
    if not raw:
        return []
    ids = []
    raw = str(raw)
    for token in re.split(r'[;,\s]+', raw):
        if not token:
            continue
        if token.isdigit():
            ids.append(token)
    return ids


def get_theme_color(famille):
    if not famille:
        return '#5f6368'
    famille = famille.lower()
    if 'enjeux' in famille:
        return '#1f77b4'
    if 'pression' in famille:
        return '#d35400'
    if 'vulnérabil' in famille:
        return '#2ca02c'
    if 'environnement' in famille:
        return '#2c7f7b'
    return '#5f6368'


def vision_color_from_group_id(gid):
    """Map a group id to Hydroscope vision color (Pilotage/Veille/Diagnostic).
    Returns a hex color string or None when unknown.
    """
    if gid is None:
        return None
    try:
        gid_int = int(str(gid).strip())
    except Exception:
        return None

    pilotage = {1, 2, 3, 10, 13, 16}
    veille = {5, 6, 8, 9, 11, 12, 14}
    diagnostic = {4, 7, 15}

    if gid_int in pilotage:
        return '#005596'
    if gid_int in veille:
        return '#2E7D32'
    if gid_int in diagnostic:
        return '#546E7A'
    return None


def role_icon(role):
    if not role:
        return '🎯'
    r = str(role).lower()
    if 'pilotage' in r:
        return '🎯'
    if 'veille' in r:
        return '👁️'
    if 'diagnostic' in r or 'modulation' in r:
        return '🔬'
    return '📌'


def build_group_context(df_ind, df_group, df_rel_group):
    groups = {}
    indicator_by_id = {}
    for _, row in df_ind.iterrows():
        id_ind = v(row, 'id_indicateur')
        nom_ind = v(row, 'nom_indicateur')
        if not is_valid_data(id_ind, nom_ind):
            continue
        indicator_by_id[id_ind] = {
            'id': id_ind,
            'nom': nom_ind,
            'theme': v(row, 'Nom_theme'),
            'famille': v(row, 'famille_indicateur'),
            'sous_groupe': v(row, "Sous-groupe d'objectif"),
            'objectif': v(row, 'objectif'),
            'support_spatial': v(row, 'support_spatial'),
            'ponderation': v(row, 'Ponderation'),
            'spatialisation_H3': v(row, 'spatialisation_H3'),
            'nature_des_donnees': v(row, 'quantitatif_qualitatif'),
            'normalisation_methode': v(row, 'normalisation_methode'),
            'sens_indicateur': v(row, 'sens_indicateur'),
            'definition_criticite': v(row, 'definition_criticite'),
            'synthese_echanges': v(row, 'synthese_echanges')
        }

    for _, row in df_group.iterrows():
        gid = v(row, 'id_groupe')
        if not gid:
            continue
        groups[gid] = {
            'id': gid,
            'nom': v(row, 'groupe'),
            'theme': v(row, 'theme'),
            'objectif': v(row, 'Objectif'),
            'role': v(row, 'rôle'),
            'explication_role': v(row, 'explication_role'),
            'aide_a_la_decision': v(row, 'aide à la décision'),
            'indicateurs': []
        }

    for _, row in df_rel_group.iterrows():
        id_ind = v(row, 'id_indicateur')
        gid = v(row, 'id_groupe')
        if id_ind and gid and gid in groups and id_ind in indicator_by_id:
            groups[gid]['indicateurs'].append(indicator_by_id[id_ind])

    themes = {}
    for gid, group in groups.items():
        theme = group.get('theme') or 'Non classé'
        themes.setdefault(theme, []).append(group)

    return {'groups': groups, 'themes': themes, 'indicator_by_id': indicator_by_id}


def format_badge(label, value):
    if not value:
        return ''
    return f'- **{html.escape(label)} :** {html.escape(value)}\n'


def format_value(value):
    return html.escape(str(value)) if value is not None else ''


def extract_vigilances(df_vigi, indicator_id, indicator_name):
    items = []
    if df_vigi is None:
        return items
    for _, row in df_vigi.iterrows():
        raw = v(row, 'ids_indicateurs')
        ids = parse_indicator_ids(raw)
        name_match = indicator_name and str(indicator_name).lower() in str(raw).lower()
        if str(indicator_id) in ids or name_match:
            items.append({
                'id_relation': v(row, 'id_relation'),
                'type_vigilance': v(row, 'type_vigilance'),
                'description': v(row, 'description')
            })
    return items


def build_group_summary(themes_data):
    lines = ['## Synthèse des groupes et objectifs\n']
    lines.append('| Groupe | Thème | Objectif | Rôle | Indicateurs |')
    lines.append('|---|---|---|---|---|')
    for theme, groups in sorted(themes_data.items(), key=lambda x: x[0]):
        for group in groups:
            indicateurs = ', '.join([html.escape(item['nom']) for item in group['indicateurs'] if item.get('nom')])
            lines.append(f"| {html.escape(group['nom'])} | {html.escape(group['theme'] or '')} | {html.escape(group['objectif'] or '')} | {html.escape(group['role'] or '')} | {indicateurs} |")
    lines.append('\n')
    return '\n'.join(lines)


def render_indicator_page(row, df_dict, df_src, df_rel, context, df_vigi):
    id_ind = v(row, 'id_indicateur')
    nom_ind = v(row, 'nom_indicateur')
    famille = v(row, 'famille_indicateur')
    type_ind = v(row, 'type') or v(row, 'type_indicateur')
    theme = v(row, 'Nom_theme')
    selected_group = None
    for gid, g in context['groups'].items():
        if any(ind.get('nom') == nom_ind or ind.get('id') == id_ind for ind in g['indicateurs']):
            selected_group = g
            break
    # Prefer explicit vision color mapping from group id when available,
    # otherwise fallback to theme-based color.
    color = None
    if selected_group:
        color = vision_color_from_group_id(selected_group.get('id'))
    if not color:
        color = get_theme_color(famille or theme or (selected_group and selected_group.get('theme')))
    role = selected_group.get('role') if selected_group else ''
    explication_role = selected_group.get('explication_role') if selected_group else ''

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

    content = f"---\ntitle: \"{html.escape(nom_ind or '')}\"\nsubtitle: \"Fiche indicateur n°{html.escape(id_ind or '')}\"\n---\n"
    content += '<style>\n'
    content += f'.fiche-page{{--brand-color: {color};max-width:980px;margin:0 auto;padding:1.5rem 1.75rem;font-family:Arial,Helvetica,sans-serif;color:#111;background:#ffffff;border-radius:20px;box-shadow:0 18px 45px rgba(15,23,42,0.08);}}\n'
    content += '.fiche-header{display:grid;grid-template-columns:1fr auto;gap:1rem;align-items:start;padding-bottom:1rem;border-bottom:1px solid #d9e2ea;}\n'
    content += '.fiche-meta{display:grid;gap:0.75rem;font-size:0.95rem;color:#2c333a;}\n'
    content += '.fiche-meta strong{color:#111;font-weight:700;}\n'
    content += '.fiche-badge{background:var(--brand-color);color:#fff;padding:0.85rem 1rem;border-radius:999px;font-weight:700;font-size:0.95rem;text-align:center;min-width:120px;align-self:start;}\n'
    content += '.fiche-vision{background:#f4f8ff;border-left:6px solid var(--brand-color);padding:1rem 1.1rem;border-radius:18px;margin-top:1rem;}\n'
    content += '.section-title{display:block;font-size:1rem;font-weight:700;margin-bottom:0.85rem;color:#1d1d1d;}\n'
    content += '.vision-role{display:flex;align-items:center;gap:0.5rem;font-size:1rem;margin-bottom:0.75rem;}\n'
    content += '.vision-role span{font-size:1.2rem;}\n'
    content += '.fiche-body{display:grid;grid-template-columns:minmax(0,1.65fr) minmax(240px,1fr);gap:1rem;margin-top:1rem;}\n'
    content += '.fiche-analysis,.fiche-context{background:#fafbfc;border:1px solid #dbe4eb;border-radius:18px;padding:1.1rem;}\n'
    content += '.detail-item,.badge-item{margin-bottom:0.9rem;}\n'
    content += '.detail-item:last-child,.badge-item:last-child{margin-bottom:0;}\n'
    content += '.badge-list{list-style:none;padding:0;margin:0;display:grid;gap:0.75rem;}\n'
    content += '.badge-item{display:inline-flex;align-items:center;gap:0.4rem;background:#ffffff;border:1px solid #dfe7ee;border-radius:999px;padding:0.8rem 1rem;font-size:0.95rem;color:#27343d;}\n'
    content += '.fiche-vigilance{background:#fff4d9;border-left:6px solid #d9a500;padding:1rem 1.1rem;border-radius:18px;margin-top:1rem;}\n'
    content += '.fiche-vigilance .vigilance-entry{margin-bottom:0.85rem;}\n'
    content += '.fiche-vigilance .vigilance-entry:last-child{margin-bottom:0;}\n'
    content += '.fiche-sources{margin-top:1.5rem;}\n'
    content += '.footer-grid{display:grid;grid-template-columns:repeat(auto-fit,minmax(220px,1fr));gap:1rem;margin-top:1rem;}\n'
    content += '.footer-item{background:#f7f8fa;border:1px solid #dce4eb;border-radius:18px;padding:1rem;}\n'
    content += '.footer-item p{margin:0.45rem 0 0 0;line-height:1.5;}\n'
    content += '@media print{\n'
    content += '.fiche-page,.fiche-header,.fiche-vision,.fiche-analysis,.fiche-context,.fiche-vigilance,.fiche-sources,.footer-item{break-inside:avoid;}\n'
    content += '}\n'
    content += '</style>\n\n'

    def open_block(classes):
        return f'::: {{{classes}}}\n\n' if classes else ':::\n\n'

    def close_block():
        return ':::\n\n'

    def source_line(label, value):
        if not value:
            return ''
        return f'**{html.escape(label)} :** {html.escape(value)}  \n'

    content += open_block('.fiche-page')
    content += open_block('.fiche-header')
    content += open_block('.fiche-meta')
    content += f'**{html.escape(nom_ind or "Indicateur")}**  \n'
    content += f'**Thème :** {html.escape(theme or "Non renseigné")}  \n'
    content += f'**Famille :** {html.escape(famille or "Non renseigné")}  \n'
    if type_ind:
        content += f'**Type :** {html.escape(type_ind)}  \n'
    content += close_block()
    content += open_block('.fiche-badge')
    content += f'Fiche n°{html.escape(id_ind or "?")}\n'
    content += close_block()
    content += close_block()

    content += open_block('.fiche-vision')
    content += '<span class="section-title">Vision stratégique</span>\n\n'
    content += f'<span class="vision-role">{role_icon(role)} <strong>{html.escape(role or "Pilotage")}</strong></span>\n\n'
    if explication_role:
        content += f'{html.escape(explication_role)}\n\n'
    if selected_group:
        content += open_block('.fiche-badges')
        content += format_badge('Groupe', selected_group.get('nom'))
        content += format_badge('Objectif groupe', selected_group.get('objectif'))
        content += close_block()
    content += close_block()

    content += open_block('.fiche-body')
    content += open_block('.fiche-analysis')
    content += '<span class="section-title">Analyse & criticité</span>\n\n'
    if central_objectif:
        content += f'<div class="detail-item"><strong>Objectif</strong>  \n{html.escape(central_objectif)}</div>\n\n'
    if normalization:
        content += f'<div class="detail-item"><strong>Normalisation</strong>  \n{html.escape(normalization)}</div>\n\n'
    if sens:
        if 'positif' in sens.lower():
            arrow = '<span style="color:#2e7d32;font-size:1.2rem;">↑</span>'
        elif 'négatif' in sens.lower():
            arrow = '<span style="color:#c62828;font-size:1.2rem;">↓</span>'
        else:
            arrow = '<span style="color:#555;font-size:1.2rem;">↔</span>'
        content += f'<div class="detail-item"><strong>Sens de l\'indicateur</strong>  \n{html.escape(sens)} {arrow}</div>\n\n'
    if criticite:
        content += f'<div class="detail-item"><strong>Définition de la criticité</strong>  \n{html.escape(criticite)}</div>\n\n'
    content += close_block()

    content += open_block('.fiche-context')
    content += '<span class="section-title">Contexte technique</span>\n\n'
    content += '<ul class="badge-list">\n'
    if support_spatial:
        content += f'<li class="badge-item">**Support spatial :** {html.escape(support_spatial)}</li>\n'
    if ponderation:
        content += f'<li class="badge-item">**Pondération :** {html.escape(ponderation)}</li>\n'
    if spatialisation:
        content += f'<li class="badge-item">**Spatialisation H3 :** {html.escape(spatialisation)}</li>\n'
    if nature:
        content += f'<li class="badge-item">**Nature des données :** {html.escape(nature)}</li>\n'
    if statut_dispo:
        content += f'<li class="badge-item">**Disponibilité :** {html.escape(statut_dispo)}</li>\n'
    content += '</ul>\n\n'
    content += close_block()
    content += close_block()

    if vigils or synthese:
        content += open_block('.fiche-vigilance')
        content += '<span class="section-title">Vigilance expert</span>\n\n'
        if synthese:
            content += f'<div class="vigilance-entry"><strong>Résumé des échanges</strong>  \n{html.escape(synthese)}</div>\n\n'
        for vigil in vigils:
            content += f'<div class="vigilance-entry"><strong>{html.escape(vigil["type_vigilance"] or "Vigilance")}</strong> *{html.escape(vigil["id_relation"] or "")}*  \n{html.escape(vigil["description"] or "")}</div>\n\n'
        content += close_block()

    content += open_block('.fiche-sources')
    content += '<span class="section-title">Sources & fiabilité</span>\n\n'
    content += open_block('.footer-grid')

    mask_rel = (df_rel['id_indicateur'].astype(str).str.replace('.0','', regex=False) == str(id_ind)) & \
               (df_rel['actif'].astype(str).str.strip().str.capitalize() == 'Oui')
    rel_ids = df_rel[mask_rel]['id_ressource'].astype(str).str.replace('.0','', regex=False).tolist()
    sources_liees = df_src[df_src['id_ressource'].astype(str).str.replace('.0','', regex=False).isin(rel_ids)]
    if not sources_liees.empty:
        for _, s in sources_liees.iterrows():
            content += open_block('.footer-item')
            content += f'**{html.escape(v(s, "nom_ressource") or "Source")}**\n\n'
            content += source_line('Origine', v(s, 'origine'))
            content += source_line('Distributeur', v(s, 'distributeur'))
            content += source_line('Couverture spatiale', v(s, 'couverture_spatiale'))
            content += source_line('Actualisation', v(s, 'actualisation'))
            content += source_line('Disponibilité', v(s, 'statut_disponibilite'))
            url = v(s, 'url')
            if url and 'http' in url:
                content += f'[Accéder à la ressource]({html.escape(url)})\n\n'
            rem = v(s, 'description_ressource') or v(s, 'documentation_ressource') or v(s, 'contraintes_ressource')
            if rem:
                content += f'{html.escape(rem)}\n\n'
            content += close_block()
    else:
        content += 'Aucune source de donnée identifiée.\n\n'

    content += close_block()
    content += close_block()
    content += close_block()
    return content


def index_qmd(familles, themes, group_synthese):
    today = date.today().strftime("%d/%m/%Y")
    lines = [f"# {PROJECT['title']}\n", f"**{PROJECT['subtitle']}**\n",
             f"Version {PROJECT['version']} — {today}\n"]

    lines.append(f"\n**Historique des versions du document :**\n\n")
    lines.append(f"| Version | Date | Auteur(s) | Description des modifications |")
    lines.append(f"|---|--------|-----------|------------------------------|")
    lines.append(f"| 0.1 | 2026-05-18 | Hugo Roussaffa | Rédaction initiale des fiches indicateurs |\n")
   
    lines.append(
        f"\nLes fiches indicateurs présentées dans ce catalogue sont destinées à fournir "
        f"une description détaillée de chaque indicateur de suivi et de comparaison des captages AEP. "
        f"Chaque fiche comprend une identification claire de l'indicateur, des sections détaillées sur "
        f"les méthodes de calcul, les modalités de visualisation, ainsi que les sources de données qui lui "
        f"sont associées.\n"
    )
    lines.append(f"\n---\n")
    lines.append("{{< include './informations générales.qmd' >}}\n")

    lines.append('\n## Synthèse des thèmes\n')
    lines.append('| Thème | Famille | Objectif | Rôle analyse |')
    lines.append('|---|---|---|---|')
    for theme, groups in sorted(themes.items(), key=lambda x: x[0]):
        if not groups:
            continue
        theme_label = html.escape(theme)
        objectif = html.escape(groups[0].get('objectif') or '')
        role_analyse = html.escape(groups[0].get('role') or '')
        famille_theme = html.escape(groups[0].get('theme') or '')
        lines.append(f"| {theme_label} | {famille_theme} | {objectif} | {role_analyse} |")

    lines.append('\n')
    lines.append(group_synthese)

    lines.append('\n---\n')
    lines.append('## Sommaire des fiches par famille\n')
    for famille in sorted(familles.keys()):
        lines.append(f"\n### {html.escape(famille)}\n")
        for item in familles[famille]:
            lines.append(f"- [{html.escape(item['nom'])}](fiches/{item['id']}.qmd)")

    return "\n".join(lines) + "\n"

def quarto_yml(familles):
    chapters = ["index.qmd"]
    for famille in sorted(familles.keys()):
        for fiche in familles[famille]:
            chapters.append(f"fiches/{fiche['id']}.qmd")
    
    config = {
        "project": {"type": "book", "pre-render": "generate_fiches_indicateurs.py"},
        "date" : "today",
        "date-format" : "long",
        "lang": "fr",
        "logo": {
            "light": {"path": "ressources/OEIL_logo.png"},
            "dark": {"path": "ressources/OEIL_logo.png"}
        },
        "image_font_1": "ressources/MJunckerOEIL.jpg",
        "image_font_2": "ressources/eau-monitoring.png",
        "logo_partenaire": "ressources/logo_yapuka.png",
        "book": {
            "title": PROJECT["title"],
            "subtitle": PROJECT["subtitle"],
            "author": PROJECT["author"],
            "chapters": chapters,
            "downloads": ["pdf"]
        },
        "format": {
            "typst": {
                "margin-geometry": {
                    "outer": {
                        "far": "10mm",
                        "width": "2.2in",
                        "separation": "0.25in"
                    },
                    "inner": {
                        "far": "10mm",
                        "width": "0.5in",
                        "separation": "0.25in"
                    },
                    "clearance": "8pt"
                },
                "mainfont": "Liberation Sans",
                "font-headings": "Liberation Sans",
                "toc": False,
                "number-sections": False,
                "fontsize": "10pt",
                "lang": "fr",
                "template": "template_typst.typ",
                "header-includes": "#let pilotage-color = rgb(\"#005596\")\n"
                    "#let veille-color = rgb(\"#2E7D32\")\n"
                    "#let diag-color = rgb(\"#546E7A\")"

            },
            "pdf-oeil": {
                "pdf-engine": "xelatex",
                "header-includes": [
                    "\\usepackage{soul}",
                    "\\sethlcolor{yellow}"
                ],
                "toc": True,
                "colorlinks": True,
                "toc-depth": 1,
                "fig-width": 8,
                "fig-height": 6,
                "fig-pos": "H",
                "number-sections": False,
                "keep_tex": False,
                "include-in-header": ["in-header.tex","header.tex"],
                "fontsize": "11pt",
                "mainfont": "Calibri",
                "template-partials": ["before-body.tex"]
            },
            "docx": { 
                "reference-doc": "custom-reference.docx",
                "toc": True,
                "toc-depth": 2,
                "number-sections" : True,
                "highlight-style": "github"
            },
            "html": {"theme": "cosmo", "toc": True, "lang": "fr"}
        }
    }
    return yaml.dump(config, allow_unicode=True, sort_keys=False)

def main():
    print(f"🚀 Chargement des données...")
    try:
        tabs = pd.read_excel(XLSX, sheet_name=None)
        df_ind = tabs['indicateurs']
        df_src = tabs['sources']
        df_rel = tabs['relation indicateur source']
        df_dict = tabs['dictionnaire']
        df_theme = tabs['themes']
        df_group = tabs['groupes']
        df_rel_group = tabs['relation groupe objectifs']
        df_vigi = tabs['vigilances']
    except Exception as e:
        print(f"❌ Erreur : {e}"); return

    # Nettoyage des noms de colonnes
    for df in [df_ind, df_src, df_rel, df_dict, df_theme, df_group, df_rel_group, df_vigi]:
        df.columns = df.columns.str.strip()

    context = build_group_context(df_ind, df_group, df_rel_group)
    familles = {}

    for _, row in df_ind.iterrows():
        id_ind = v(row, 'id_indicateur')
        nom_ind = v(row, 'nom_indicateur')

        if not is_valid_data(id_ind, nom_ind):
            continue

        content = render_indicator_page(row, df_dict, df_src, df_rel, context, df_vigi)
        (FICHES_DIR / f"{id_ind}.qmd").write_text(content, encoding="utf-8")
        fam = v(row, 'famille_indicateur') or "Autres"
        familles.setdefault(fam, []).append({"id": id_ind, "nom": nom_ind})


    # Fichiers explicatif
    Path("informations générales.qmd").write_text(info_qmd(df_dict), encoding="utf-8")


    # Fichiers de structure
    Path("index.qmd").write_text(index_qmd(familles, context['themes'], build_group_summary(context['themes'])), encoding="utf-8")
    Path("_quarto.yml").write_text(quarto_yml(familles), encoding="utf-8")

    print(f"✅ Terminé : {sum(len(v) for v in familles.values())} fiches générées avec succès.")

if __name__ == "__main__":
    main()
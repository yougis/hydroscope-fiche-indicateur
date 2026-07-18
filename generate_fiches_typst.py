#!/usr/bin/env python3
import pandas as pd
from pathlib import Path
from datetime import date
import csv
import subprocess


DEFAULT_HEX = '7F7F7F'

FAMILLE_BASE_COLORS = {
'Enjeu':         '2b5e8c',   # Bleu
'Menace':      'faa51a',   # Orange
'Vulnérabilité': '318d44',   # Vert
'Contexte':      'FFC000',   # Jaune/Or
}
# ── Palette fixe par Nom_theme ───────────────────────────────────────────────
THEME_COLORS = {
'Enjeux AEP':                  '4472C4',   # Bleu marine profond
'Enjeux Environnementaux':     '3bc29f',   # Bleu ciel moyen
'MENACES NATURELLES': 'ED7D31',   # Brun-orange foncé
'MENACES ANTHROPIQUES':      'C55A11',   # Orange foncé
'Menaces Quantitatives':     'ED7D31',   # Orange vif
'Menaces Qualitatives':      'F4B183',   # Orange pâle
'Vulnérabilité Intrinsèque':   '41af2f',   # Vert forêt
}



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
CSV_SUIVI_COMMENTAIRES = Path("suivi_commentaires_modifications_fiches_HydroScope.csv")


PROJECT = {
    "title":     "Fiches indicateurs HydroScope",
    "subtitle":  "Catalogue des indicateurs de suivi et de comparaison des unités de gestion AEP",
    "author":    "Hugo Roussaffa",
    "version":   "4",
}


def typst_escape(value):
    if value is None:
        return ""
    text = str(value)
    text = text.replace("\\", "\\\\")
    text = text.replace('"', '\\"')
    text = text.replace("[", "\\[")
    text = text.replace("]", "\\]")
    text = text.replace("/", "\\/")
    text = text.replace("(", "\\(")
    text = text.replace(")", "\\)")
    text = text.replace("\n", " ")
    text = text.replace("\r", " ")
    text = text.replace('`', "'")
    text = text.replace('_', '\\_')
    text = text.replace('-', '\\-')
    text = text.replace('?', '\\?')

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

def get_column_value(row, internal_names):
    """
    Récupère la valeur d'une ligne en gérant les variations de casse et d'accents.
    """
    for name in internal_names:
        if name in row:
            return row[name]
        # Test en minuscules/sans espaces au cas où
        for key in row.keys():
            if key.lower().strip() == name.lower().strip():
                return row[key]
    return ""

def typst_quote(value):
    return f'"{typst_escape(value)}"'


def typst_color(color):
    if not color:
        return 'rgb("#5f6368")'
    return f'rgb("{color}")'


def generate_typst_note_version(output_path):
    # (Supposons que ton dictionnaire PROJECT soit défini ici)
    today = date.today().strftime("%d/%m/%Y")

    lines = [
        f"= {PROJECT['title']}\n", 
        f"*{PROJECT['subtitle']}*\n\n",
        f"Version {PROJECT['version']} — {today}\n"
    ]

    # Historique des versions
    lines.append(f"\n*Historique des versions du document :*\n\n")

    # Création du tableau en syntaxe Typst
    content = [
        "#table(\n",
        "  columns: (auto, auto, auto, 1fr),\n",
        "  fill: (x, y) => if y == 0 {{ luma(230) }} else {{ none }},\n",  # Fond gris pour l'entête
        "  [*Version*], [*Date*], [*Auteur(s)*], [*Description des modifications*],\n",
        "  [0.1], [2026-05-18], [Hugo Roussaffa], [Rédaction initiale des fiches indicateurs],\n",
        "  [0.2], [2026-06-08], [Hugo Roussaffa], [Réorganisation des indicateurs en groupe d'objectif commun, mise en forme compacte et corrections suite aux commentaires de Stéphane Balayre, Marjolaine David et Léa Desouter],\n",
        "  [0.3], [2026-06-16], [Hugo Roussaffa], [Intégration d'une annexe \"suivi détaillé des modifications du document\". Correction et réajustement de plusieurs choix d'organisation des indicateurs proposé par Marjolaine David],\n",
        "  [4], [2026-07-16], [Hugo Roussaffa], [Ajout indicateur \"Autres IOTA\", \"Etablissements publics sensibles\", \"Plan d\'Urbanisme Directeur\". Descriptions utilisateurs ameliorées et objectifs revu pour l\'usage Informatif et pour l\'analyse multicritère. Organisation des indicateur en seulement 2 familles (Enjeux & Menaces).]\n",

        ")\n",
        """\nHydroscope est un projet porté par l’Observatoire de l’environnement en Nouvelle-Calédonie (OEIL),
        visant à développer un outil d’aide à la décision dédié au suivi et à la gestion des ressources en eau. 
        Il repose sur la centralisation, la structuration et la valorisation de données environnementales, 
        afin de produire des indicateurs fiables, transparents et accessibles. 
        L’objectif est de faciliter la compréhension des dynamiques hydrologiques, d’éclairer les enjeux de pression et de vulnérabilité des milieux, 
        et de soutenir les acteurs publics dans la planification et la gestion durable de l’eau.
        Dans ce cadre, le catalogue de fiches indicateurs constitue un référentiel commun décrivant de manière structurée
        les indicateurs mobilisés dans Hydroscope. Il vise à expliciter leurs méthodes de calcul, leurs limites et leurs 
        conditions d’interprétation, afin de garantir une utilisation cohérente, traçable et scientifiquement robuste 
        des données. Il contribue ainsi à renforcer la transparence de l’outil et à faciliter son appropriation par 
        l’ensemble des parties prenantes."""


    ]

    lines.extend(content)
    lines.append('#pagebreak()')

    with open(output_path, 'w', encoding='utf-8') as f:
        f.write('\n'.join(lines))
    
    print(f"Le fichier Typst de note de version a été généré avec succès : {output_path}")


def generate_typst_glossary(df, output_path):
    """
    Génère un fichier Typst contenant le glossaire des attributs
    à partir du dictionnaire de données.
    """
    # 1. Chargement et filtrage des données
    # On ne garde que les lignes marquées pour le glossaire [3, 4]
    glossary_items = df[df['glossaire'].str.lower() == 'oui'].copy()
    
    # Tri alphabétique sur le libellé affiché
    glossary_items = glossary_items.sort_values(by='libelle_affiche')

    # 2. Construction du contenu Typst
    # Configuration globale [1]
    typst_content = [
        '#set page(paper: "a4", margin: (x: 15mm, y: 20mm))',
        '#set text(font: "Liberation Sans", size: 10pt, lang: "fr")',
        '#set par(justify: true)',
        '',
        '= Glossaire des attributs <masque>',
        '#block(',
        'width: 100%,',
        'stroke: (top: 4pt + rgb("#005596")),',
        'inset: (top: 10pt, bottom: 8pt, left: 0pt, right: 0pt),',
        'stack(dir: ttb, spacing: 0.4em,',
        '  text(size: 1.5em, weight: "bold", tracking: 1pt)[Glossaire]',
        ')',
        ')',               
        '#v(1em)',
        '',
        '#grid(',
        '  columns: (2in, 1fr),', # Colonne 1: Terme, Colonne 2: Définition
        '  gutter: 15pt,',           # Espacement recommandé [2]
        '  stroke: none,'
    ]

    # 3. Insertion des entrées du dictionnaire
    for _, row in glossary_items.iterrows():
        term = row['libelle_affiche']
        definition = row['description']
        
        # Formatage : Terme en gras, définition en texte normal
        line = f'  [* {term} *], [{definition}],'
        typst_content.append(line)

    typst_content.append(')') # Fermeture de la grille

    # 4. Écriture du fichier final
    with open(output_path, 'w', encoding='utf-8') as f:
        f.write('\n'.join(typst_content))
    
    print(f"Le fichier Typst a été généré avec succès : {output_path}")




def render_typst_page(row, context, df_src, df_rel, df_vigi, fiche_number):
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
        color  = THEME_COLORS.get(str(selected_group.get('theme')), DEFAULT_HEX)

    brand_color = color if color else '#005596'

    role = selected_group.get('role') if selected_group else ''
    explication_role = selected_group.get('explication_role') if selected_group else ''
    groupe_nom = selected_group.get('nom') if selected_group else ''
    groupe_obj = selected_group.get('objectif') if selected_group else ''

    description_ind = v(row, 'description_indicateur_utilisateur')
    priorite = v(row, 'priorite')
    unite = v(row, 'unite')
    
    central_objectif = v(row, 'objectif_INFO')
    AMC_objectif = v(row, 'objectif_AMC')
    modalites = v(row, 'modalites')
    normalization = v(row, 'normalisation_methode')
    sens = v(row, 'sens_indicateur')
    criticite = v(row, 'definition_criticite')
    support_spatial = v(row, 'support_spatial')
    spatialisation = v(row, 'spatialisation_H3')
    nature = v(row, 'quantitatif_qualitatif')
    discret_continu = v(row, 'discret_continu')
    relatif_absolu = v(row, 'relatif_absolu')
    representation = v(row, 'representation_cartographique')
    implantation = v(row, 'implantation')


    statut_dispo = v(row, 'statut_disponibilite')
    synthese = v(row, 'synthese_echanges')



    vigils = extract_vigilances(df_vigi, id_ind, nom_ind)

    # ── Valeurs échappées ─────────────────────────────────────────────
    title = typst_escape(nom_ind or 'Indicateur')
    fiche_number = typst_escape(f'{fiche_indicateur or "?"}')
    theme_text = typst_escape(theme or 'Non renseigné')
    famille_text = typst_escape(famille or 'Non renseigné')
    type_text = typst_escape(type_ind or '')
    role_text = typst_escape(role or 'Agir')
    explication_role_text = typst_escape(explication_role or '')
    groupe_nom_text = typst_escape(groupe_nom or '')
    groupe_obj_text = typst_escape(groupe_obj or '')

    unite_text = typst_escape(unite or 'unite')

    objective_text = typst_escape(central_objectif or '')
    objective_AMC_text = typst_escape(AMC_objectif or '')
    
    normalization_text = typst_escape(normalization or '')
    sens_text = typst_escape(sens or '')
    criticite_text = typst_escape(criticite or '')

    description_ind_text = typst_escape(description_ind or '')
    priorite_text = typst_escape(priorite or '')
    modalites_text = typst_escape(modalites or '')

    # Icône de rôle (résolu en Python)
    role_lower = str(role).lower()
    if 'Agir' in role_lower:
        role_icon = '🎯'
    elif 'Surveiller' in role_lower:
        role_icon = '👁'
    elif 'Comprendre' in role_lower or 'modulation' in role_lower:
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
            'type_source': typst_escape(v(s, 'type_source') or ''),
            
            'disponibilite': typst_escape(v(s, 'statut_disponibilite') or ''),
            'url': typst_escape(v(s, 'url') or ''),
            'description_ressource': typst_escape(
                v(s, 'description_ressource') or ''
            ),
            'contraintes_ressource': typst_escape(
                v(s, 'contraintes_ressource') or ''
            ),
        })

    # ── Génération Typst ──────────────────────────────────────────────
    lines = []
    lines.append('#import "../template_typst.typ": *')
    lines.append('')
    
    # ── . Headings invisibles pour outline ───────────────────────────
    lines.append('#show heading.where(level: 1): it => {}')
    lines.append('#show heading.where(level: 2): it => {}')
    lines.append('#show heading.where(level: 3): it => {}')

    lines.append('')
    lines.append(f'#let brand = rgb("{brand_color}")')
    lines.append('')
    
    # ── EN-TÊTE DU DOCUMENT ───────────────────────────────────────────

    clean_id = fiche_number.replace(" ", "-").replace("°", "")
    lines.append('#grid(')
    lines.append('  columns: (1fr, auto),')
    lines.append('  column-gutter: 1cm,')
    lines.append('  align: (left + horizon, right + horizon),')
    lines.append('  [')
    lines.append(f'    #text(size: 1.6em, weight: "bold", fill: brand)[{title}]')
    lines.append('  ],')
    lines.append('  [')
    lines.append('    #box(')
    lines.append('      fill: rgb("#f1f5f9"),')
    lines.append('      inset: (x: 10pt, y: 6pt),')
    lines.append('      radius: 4pt,')
    lines.append('      stroke: 1.2pt + brand,')
    lines.append('      [')
    lines.append(f'        #text(size: 0.85em, weight: "bold", fill: brand)[FICHE {fiche_number} <ind-{clean_id}>]')
    lines.append('      ]')
    lines.append('    )')
    lines.append('  ]')
    lines.append(')')

    lines.append('#v(0.5em)')
    lines.append('#line(length: 100%, stroke: 0.5pt + rgb("#d9e2ea"))')
    lines.append('#v(0.5em)')

    # ── BADGES Rôle et Groupe ─────────────────────────────────────────
    lines.append('#stack(dir: ltr, spacing: 0.6em,')
    lines.append('  box(')
    #lines.append('    fill: brand.lighten(90%),')
    #lines.append('    stroke: 0.5pt + brand,')
    #lines.append('    inset: (x: 6pt, y: 4pt),')
    #lines.append('    radius: 3pt,')
    #lines.append(f'    text(size: 0.78em, weight: "bold", fill: brand)[{role_icon} {role_text}]')
    lines.append('  ),')

    if groupe_nom_text:
        lines.append('  box(')
        lines.append('    fill: rgb("#f1f5f9"),')
        lines.append('    stroke: 0.5pt + rgb("#cbd5e1"),')
        lines.append('    inset: (x: 6pt, y: 4pt),')
        lines.append('    radius: 3pt,')
        lines.append(f'    text(size: 0.75em, weight: "medium", fill: rgb("#475569"))[{groupe_nom_text}]')
        lines.append('  )')
    else:
        if lines[-1].endswith(','):
            lines[-1] = lines[-1].rstrip(',')

    lines.append(')')
    lines.append('#v(0.6em)')

    # ── BLOC DESCRIPTION & OBJECTIF ──────────────────────────────────
    if description_ind_text:
        lines.append('#box(')
        lines.append('  width: 100%,')
        lines.append('  fill: rgb("#f8fafc"),')
        lines.append('  stroke: (left: 4pt + rgb("#64748b")),')
        lines.append('  radius: 2pt,')
        lines.append('  inset: (x: 10pt, y: 8pt),')
        lines.append('  stack(dir: ttb, spacing: 0.4em,')
        lines.append(f'    text(size: 0.73em, style: "italic", fill: rgb("#334155"))[{description_ind_text}],')

        if objective_text:
            lines.append('    1em,')
            lines.append(f'    text(size: 0.71em, weight: "bold", fill: rgb("#1a365d"))[Objectif :],')
            lines.append(f'    text(size: 0.71em, fill: rgb("#1a202c"))[{objective_text}],')




        if priorite_text:
            lines.append('    0.5em,')
            lines.append('    stack(dir: ttb, spacing: 0.1em,')
            lines.append(f'      text(size: 0.71em, weight: "bold", fill: rgb("#1a365d"))[Prioritaire : {priorite_text}],')
            lines.append('    ),')

        lines.append('  )')
        lines.append(')')

    lines.append('#v(0.5em)')

    # ── BODY : 2 colonnes indépendantes, hauteur naturelle ───────────
    lines.append('#grid(')
    lines.append('  columns: (1.65fr, 1fr),')
    lines.append('  column-gutter: 10pt,')
    lines.append('  align: (top, top),')

    # ── Colonne gauche : Analyse & criticité ─────────────────────────
    lines.append('  box(')
    lines.append('    width: 100%,')
    lines.append('    fill: fiche_bg,')
    lines.append('    stroke: 0.5pt + fiche_border,')
    lines.append('    radius: 3pt,')
    lines.append('    inset: 8pt,')
    lines.append('    stack(dir: ttb, spacing: 0.35em,')
    lines.append('      text(size: 0.85em, weight: "bold")[Analyse multicritère et mesure de criticité],')

    if objective_AMC_text:
        lines.append('    1em,')
        lines.append(f'    text(size: 0.71em, weight: "bold", fill: rgb("#1a365d"))[Objectif de l\'indicateur dans l\'analyse:],')
        lines.append(f'    text(size: 0.71em, fill: rgb("#1a202c"))[{objective_AMC_text}],')


    if modalites_text:
        lines.append('      0.7em,')
        lines.append('      stack(dir: ttb, spacing: 0.4em,')
        lines.append(f'        text(size: 0.75em, weight: "bold")[Modalités de traitement],')
        lines.append(f'        text(size: 0.71em)[{modalites_text}],')
        lines.append('      ),')

    if normalization_text:
        lines.append('      0.7em,')
        lines.append('      stack(dir: ttb, spacing: 0.4em,')
        lines.append(f'        text(size: 0.75em, weight: "bold")[Normalisation],')
        lines.append(f'        text(size: 0.71em)[{normalization_text}],')
        lines.append('      ),')

    if criticite_text:
        lines.append('      0.7em,')
        lines.append('      stack(dir: ttb, spacing: 0.4em,')
        lines.append(f'        text(size: 0.75em, weight: "bold")[Définition de la criticité],')
        lines.append(f'        text(size: 0.71em)[{criticite_text}],')
        lines.append('      ),')

    if sens_text:
        lines.append('      0.7em,')
        lines.append('      stack(dir: ttb, spacing: 0.4em,')
        lines.append(f'        text(size: 0.75em, weight: "bold")[Sens de l\'indicateur],')
        lines.append(f'        text(size: 0.71em)[{sens_text} #h(0.2em) #text(fill: rgb("{arrow_color}"), size: 0.95em)[{arrow}]],')
        lines.append('      ),')

    lines.append('    )')   # fin stack
    lines.append('  ),')   # fin box gauche

    # ── Colonne droite : Critère technique + Modalités empilés ───────
    lines.append('  stack(dir: ttb, spacing: 0pt,')

    lines.append('   block(breakable: true,')
    lines.append('      width: 100%,')
    lines.append('      fill: fiche_bg,')
    lines.append('      stroke: 0.5pt + fiche_border,')
    lines.append('      radius: (top-left: 3pt, top-right: 3pt, bottom-left: 0pt, bottom-right: 0pt),')
    lines.append('      inset: 8pt,')
    lines.append('      stack(dir: ttb, spacing: 0.4em,')
    lines.append('        text(size: 0.85em, weight: "bold")[Critère technique],')
    lines.append('        v(0.4em),')

    if unite_text:
        lines.append(f'        text(size: 0.72em)[#text(fill: rgb("#475569"), weight: "medium")[Unité :] {unite_text}],')
    if support_spatial:
        val_spatial = typst_escape(support_spatial)
        lines.append(f'        text(size: 0.72em)[#text(fill: rgb("#475569"), weight: "medium")[Support spatial :] {val_spatial}],')
    if spatialisation:
        val_spat_h3 = typst_escape(spatialisation)
        lines.append(f'        text(size: 0.72em)[#text(fill: rgb("#475569"), weight: "medium")[Spatialisation H3 :] {val_spat_h3}],')
    if nature:
        val_nature = typst_escape(nature)
        lines.append(f'        text(size: 0.72em)[#text(fill: rgb("#475569"), weight: "medium")[Nature des données :] {val_nature}],')
    if statut_dispo:
        val_dispo = typst_escape(statut_dispo)
        lines.append(f'        text(size: 0.72em)[#text(fill: rgb("#475569"), weight: "medium")[Disponibilité :] {val_dispo}],')

    lines.append('      )')
    lines.append('    ),')  # fin Critère technique
    lines.append('v(0.7em),')
    lines.append('    box(')
    lines.append('      width: 100%,')
    lines.append('      fill: fiche_bg,')
    lines.append('      stroke: (top: 0pt, bottom: 0.5pt + fiche_border, left: 0.5pt + fiche_border, right: 0.5pt + fiche_border),')
    lines.append('      radius: (top-left: 0pt, top-right: 0pt, bottom-left: 3pt, bottom-right: 3pt),')
    lines.append('      inset: 8pt,')
    lines.append('      stack(dir: ttb, spacing: 0.5em,')
    lines.append('        text(size: 0.85em, weight: "bold")[Modalités de visualisation],')
    lines.append('        v(0.4em),')

    if nature:
        val_nature = typst_escape(nature)
        lines.append(f'        text(size: 0.72em)[#text(fill: rgb("#475569"), weight: "medium")[Nature des données :] {val_nature}],')
    if discret_continu:
        val_disc_cont = typst_escape(discret_continu)
        lines.append(f'        text(size: 0.72em)[#text(fill: rgb("#475569"), weight: "medium")[Discret ou continu :] {val_disc_cont}],')
    if relatif_absolu:
        val_rel_abs = typst_escape(relatif_absolu)
        lines.append(f'        text(size: 0.72em)[#text(fill: rgb("#475569"), weight: "medium")[Relatif ou absolu :] {val_rel_abs}],')
    if representation:
        val_repr = typst_escape(representation)
        lines.append(f'        text(size: 0.72em)[#text(fill: rgb("#475569"), weight: "medium")[Représentation cartographique :] {val_repr}],')
    if implantation:
        val_imp = typst_escape(implantation)
        lines.append(f'        text(size: 0.72em)[#text(fill: rgb("#475569"), weight: "medium")[Implantation :] {val_imp}],')

    lines.append('      )')
    lines.append('    )')   # fin Modalités de visualisation

    lines.append('  )')     # fin stack droite
    lines.append(')')       # fin grid
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
            lines.append(' 0.7em,')
            synth_text = typst_escape(synthese)
            lines.append('    stack(dir: ttb, spacing: 0.1em,')
            lines.append(f'      text(size: 0.75em, weight: "bold")[Résumé des échanges],')
            lines.append(f'      text(size: 0.71em)[{synth_text}],')
            lines.append('    ),')
        for vigil in vigils:
            lines.append(' 0.7em,')
            vtype = typst_escape(vigil.get('type_vigilance') or 'Vigilance')
            vdesc = typst_escape(vigil.get('description') or '')
            vlabel = f'{vtype}'
            lines.append('    stack(dir: ttb, spacing: 0.1em,')
            lines.append(f'      text(size: 0.75em, weight: "bold")[{vlabel}],')
            lines.append(' 0.7em,')
            lines.append(f'      text(size: 0.71em)[{vdesc}],')
            lines.append('    ),')
        lines.append('  )')
        lines.append(')')
        lines.append('#v(0.7em)')

    # SOURCES & FIABILITÉ
    lines.append('#text(size: 0.85em, weight: "bold")[Sources & fiabilité]')
    lines.append('#v(0.4em)')

    lines.append('#block(breakable: true,')
    lines.append('  width: 100%,')
    lines.append('  fill: fiche_bg,')
    lines.append('  stroke: 0.5pt + rgb("#dce4eb"),')
    lines.append('  radius: 3pt,')
    lines.append('  inset: 8pt,')
    lines.append('  stack(dir: ttb, spacing: 0.25em,')
    if source_rows:
        for source in source_rows:
            lines.append(f'    text(size: 0.8em, weight: "bold")[Nom de la base de donnée : {source["nom"]}],')
            lines.append(' 0.7em,')

            if source['description_ressource']:
                lines.append(f'    text(size: 0.75em)[{source["description_ressource"]}],')
                lines.append(' 0.5em,')

            if source['origine']:
                lines.append(f'    text(size: 0.75em)[#text(weight: "bold")[Origine :] {source["origine"]}],')
                lines.append(' 0.5em,')

            if source['distributeur']:
                lines.append(f'    text(size: 0.75em)[#text(weight: "bold")[Distributeur :] {source["distributeur"]}],')
                lines.append(' 0.5em,')

            if source['couverture']:
                lines.append(f'    text(size: 0.75em)[#text(weight: "bold")[Couverture spatiale :] {source["couverture"]}],')
                lines.append(' 0.5em,')
            
            if source['actualisation']:
                lines.append(f'    text(size: 0.75em)[#text(weight: "bold")[Actualisation :] {source["actualisation"]}],')
                lines.append(' 0.5em,')
            
            if source['type_source']:
                lines.append(f'    text(size: 0.75em)[#text(weight: "bold")[Type de source :] {source["type_source"]}],')
                lines.append(' 0.5em,')

            if source['disponibilite']:
                lines.append(f'    text(size: 0.75em)[#text(weight: "bold")[Disponibilité :] {source["disponibilite"]}],')
                lines.append(' 0.5em,')

            if source['url'] and 'http' in source['url']:
                lines.append(f'    text(size: 0.75em)[#link("{source["url"]}")[🔗 Accès à la ressource]],')
                lines.append(' 0.5em,')

            if source['contraintes_ressource']:
                lines.append(f'    text(size: 0.75em)[#text(weight: "bold")[Contraintes :] {source["contraintes_ressource"]}],')
                lines.append(' 0.5em,')
            lines.append(' 0.7em,')




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
        



        # ── FILTRE ACTIF ─────────────────────────────────────────────
        # On extrait la valeur d'activation (ex: True, 1, "Oui", "true")
        actif_val = str(v(row, 'actif')).strip().lower()

        # Si le champ 'actif' n'est pas vrai / oui, on passe à l'indicateur suivant
        if actif_val not in ['true', '1', 'oui', 'yes']:
            continue

        if not is_valid_data(id_ind, nom_ind):
            continue


        selected_group = None
        for gid, g in context['groups'].items():
            if any(ind.get('nom') == nom_ind or ind.get('id') == id_ind
                   for ind in g['indicateurs']):
                selected_group = g
                break

        group_id = selected_group.get('id') if selected_group else 'sans_groupe'


        selected_theme = None
        for gid, t in context['themes'].items():
            if any(group.get('id') == group_id
                   for group in t['groups']):
                selected_theme = t
                break
  
            

        theme_id = selected_theme.get('id') if selected_theme else 'sans_theme'
        theme = selected_theme.get('nom') if selected_theme else 'Sans thème'

        famille = selected_theme.get('famille')

        # Niveau 1 : famille
        if famille not in families:
            families[famille] = {}
        # Niveau 2 : thème
        if theme not in families[famille]:
            families[famille][theme] = {
                '__metadata__': {
                    'nom': selected_theme.get('nom') if selected_theme else 'Sans theme',
                    'libelle_objectif': selected_theme.get('libelle_objectif') if selected_theme else '',
                    'role': selected_theme.get('role') if selected_theme else '',
                    'objectif': selected_theme.get('objectif') if selected_theme else '',
                    'definition': selected_theme.get('definition') if selected_theme else '',
                }
            }
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
            'nom': nom_ind
        })

    return families



def render_index_typst(families, title, subtitle, author):
    lines = []

    # Import du template principal
    lines.append('#import "template_typst.typ": *')
    lines.append('')

    # ─────────────────────────────────────────────────────────────────
    #  PREMIÈRE DE COUVERTURE
    # ─────────────────────────────────────────────────────────────────
    lines.append('// ─── PAGE DE COUVERTURE ──────────────────────────────────────────')
    lines.append('#set page(margin: (x: 2cm, y: 2.5cm), header: none, footer: none)')
    lines.append('')
    lines.append('#align(center + horizon)[')
    
    # Zone Logo (Optionnelle - commente ou modifie le chemin si besoin)
    # lines.append('  #image("../logo_oeil.png", width: 30%)')
    # lines.append('  #v(3em)')
    
    # Ligne décorative Orange (Oeil NC)
    lines.append('  #line(length: 40%, stroke: 3pt + color_orange)')
    lines.append('  #v(1.5em)')
    
    # Titre Principal
    lines.append(f'  #text(size: 2.6em, weight: "bold", fill: color_orange)[{typst_escape(title)}]')
    lines.append('  #v(1em)')
    
    # Sous-titre
    lines.append(f'  #text(size: 1.3em, style: "italic", fill: color_grey)[{typst_escape(subtitle)}]')
    lines.append('  #v(2em)')
    
    # Ligne décorative Basse
    lines.append('  #line(length: 20%, stroke: 1pt + color_grey)')
    lines.append('  #v(2em)')
    
    # Auteur & Métadonnées
    lines.append(f'  #text(size: 1.1em, weight: "medium", fill: color_black)[{typst_escape(author)}]')
    lines.append('  #v(0.6em)')
    
    # Date dynamique 
    current_year = date.today().year
    today = date.today().strftime("%d/%m/%Y")
    lines.append(f'  #text(size: 0.95em, fill: color_grey)[Rapport généré le {today}]')
    lines.append(']')
    
    # Fin de la couverture et saut de page
    lines.append('#pagebreak()')
    lines.append('')

    # ─────────────────────────────────────────────────────────────────
    #  CONFIGURATION DES PAGES SUIVANTES (Contenu & Index)
    # ─────────────────────────────────────────────────────────────────
    lines.append('// ─── CONFIGURATION PAGES INTERNES ────────────────────────────────')
    lines.append('#set page(')
    lines.append('  paper: "a4",')
    lines.append('  margin: (top: 2.1cm, bottom: 2.1cm, left: 2.5cm, right: 2.5cm),')
    lines.append('  footer: context align(center,')
    lines.append('    text(size: 8pt, fill: color_grey,')
    lines.append('      counter(page).display("1 / 1", both: true)')
    lines.append('    )')
    lines.append('  ),')
    # Optionnel : Si tu veux réinitialiser le compteur de pages après la couverture
    # lines.append('  clearance: { counter(page).update(1) }')
    lines.append(')')
    lines.append('')

        # Headings invisibles
    lines.append('#show <masque>: it => {}')
    lines.append('#show <masque>: it => {}')
    lines.append('#show <masque>: it => {}')
    lines.append('')


    lines.append(f'#include "fiches_typst/note_version.typ"')

    # Table des matières (Mise en page selon la charte)
    lines.append('#text(fill: color_orange)[')
    lines.append('  #outline(title: "Table des matières", depth: 3, indent: 1em)')
    lines.append(']')
    lines.append('#pagebreak()')
    lines.append('')


    lines.append(f'#include "fiches_typst/glossaire.typ"')


    # ── Famille > Thème intercalé avec ses fiches ─────────────────────
    for famille_name in sorted(families.keys(), key=lambda x: x or ''):
        themes_data = families[famille_name]
        safe_famille = make_safe_name(famille_name)

        lines.append(f'// ══════ Famille : {typst_escape(famille_name)} ══════')

        # Heading niveau 1 pour l'outline
        lines.append(f'= {typst_escape(famille_name)} <masque> ')
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
            lines.append(f'== {theme_text} <masque>')
            lines.append('')

            # TOC du thème (bandeau + groupes + liste indicateurs)
            lines.append(f'#include "fiches_typst/famille_{safe_famille}_theme_{safe_theme}_toc.typ"')
            lines.append('')

            # Fiches du thème intercalées ici
            for group_id, group_info in sorted(groupe_data.items()):
                if group_id == '__metadata__':
                    continue
                for ind in sorted(
                    group_info.get('indicateurs', []),
                    key=lambda x: int(x['num_fiche']) if str(x['num_fiche']).isdigit() else 0
                ):
                    ind_id = str(ind.get('id') or '').strip()
                    ind_nom = typst_escape(ind.get('nom') or '')
                    if ind_id:
                        # Heading niveau 3 pour l'outline
                        lines.append(f'=== {ind_nom} <masque>')
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


def generate_family_entete(famille_name, themes_data, df_ind, df_famille):
    """Bandeau famille + objectif global uniquement (pas de groupes/indicateurs)."""

    # Couleur dominante depuis le premier groupe du premier thème
    dominant_color = '#005596'
    for theme_name, groupe_data in sorted(themes_data.items()):
        for group_id, group_info in sorted(groupe_data.items()):
            dominant_color  = FAMILLE_BASE_COLORS.get(str(famille_name), DEFAULT_HEX)
            #role = str(group_info.get('role') or '').lower()
            #if 'Agir' in role:
            #    dominant_color = '#005596'
            #elif 'Surveiller' in role:
            #    dominant_color = '#2E7D32'
            #elif 'Comprendre' in role:
            #    dominant_color = '#546E7A'
            #break
        break

    # Type depuis les indicateurs
    tous_types = set()
    for theme_name, groupe_data in themes_data.items():
        for key, group_info in groupe_data.items():
            if key == '__metadata__':
                continue
            for ind in group_info.get('indicateurs', []):
                if ind.get('type'):
                    tous_types.add(ind['type'].strip())
    famille_type = typst_escape(' / '.join(sorted(tous_types)))

    # Objectif global depuis df_ind
    famille_rows = df_famille[
        df_famille['nom_famille'].astype(str).str.strip() == str(famille_name).strip()
    ]
    famille_objectif = ''
    if not famille_rows.empty:
        famille_objectif = typst_escape(
            v(famille_rows.iloc[0], 'objectif')
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

    # ── Métadonnées du thème ──────────────────────────────────────────────────
    theme_metadata = groupe_data.get('__metadata__', {})
    theme_objectif  = typst_escape(theme_metadata.get('objectif')   or '')
    theme_definition = typst_escape(theme_metadata.get('definition') or '')
    theme_role      = typst_escape(theme_metadata.get('role')        or '')
    theme_text      = typst_escape(theme_name or 'Thème')

    # ── Couleur dominante ─────────────────────────────────────────────────────
    dominant_color = '#005596'
    for group_id, group_info in sorted(groupe_data.items()):
        if group_id == '__metadata__':
            continue
        role_lower = str(group_info.get('role') or '').lower()
        dominant_color  = FAMILLE_BASE_COLORS.get(str(famille_name), DEFAULT_HEX)


        #if 'Agir' in role_lower:
        #    dominant_color = '#005596'
        #elif 'Surveiller' in role_lower:
        #    dominant_color = '#2E7D32'
        #elif 'Comorendre' in role_lower or 'modulation' in role_lower:
        #    dominant_color = '#546E7A'
        #break

    # ── Couleur du badge rôle thème ───────────────────────────────────────────
    if theme_role:
        trl = theme_role.lower()

    lines = []
    lines.append('#import "../template_typst.typ": *')
    lines.append('')
    lines.append(f'// ─── TOC THÈME : {theme_text} ───────────────────────────────')


     
    # ══════════════════════════════════════════════════════════════════════════
    # BANDEAU THÈME — titre + description, sans badge
    # ══════════════════════════════════════════════════════════════════════════
    lines.append(f'#block(width: 100%, fill: rgb("{dominant_color}"), radius: 4pt, inset: (x: 14pt, y: 12pt),')
    lines.append(f'  text(size: 1.2em, weight: "bold", fill: white)[{theme_text}]')
    lines.append(')')
 
    # Bloc description : définition et/ou objectif sous le bandeau
    desc_parts = []
    if theme_definition:
        desc_parts.append(f'text(size: 0.82em, style: "italic", fill: rgb("#475569"))[{theme_definition}]')
    if theme_objectif:
        desc_parts.append(f'text(size: 0.82em, fill: rgb("#1e293b"))[#text(weight: "bold")[Objectif :] {theme_objectif}]')
 
    if desc_parts:
        lines.append('#block(')
        lines.append('  width: 100%,')
        lines.append('  inset: (x: 2pt, top: 6pt, bottom: 4pt),')
        lines.append('  grid(')
        lines.append('    columns: 1,')
        lines.append('    row-gutter: 4pt,')
        for part in desc_parts:
            lines.append(f'    {part},')
        lines.append('  )')
        lines.append(')')
 
    lines.append('#v(0.8em)')



    # ══════════════════════════════════════════════════════════════════════════
    # GROUPES
    # ══════════════════════════════════════════════════════════════════════════
    for group_id, group_info in sorted(groupe_data.items()):
        if group_id == '__metadata__':
            continue

        role          = str(group_info.get('role') or 'Pilotage')
        role_lower    = role.lower()
        nom_groupe    = typst_escape(group_info.get('nom')              or '')
        objectif_grp  = typst_escape(group_info.get('objectif')         or '')
        explication   = typst_escape(group_info.get('explication_role') or '')
        role_text     = typst_escape(role)


        role_color = THEME_COLORS.get(str(theme_name), DEFAULT_HEX)
        #role_color = (
        #    '#005596' if 'pilotage'  in role_lower else
        #    '#2E7D32' if 'veille'    in role_lower else
        #    '#546E7A'
        #)

        indicateurs = sorted(
            group_info.get('indicateurs', []),
            key=lambda x: int(x['num_fiche']) if str(x.get('num_fiche', '')).isdigit() else 0
        )

        # ── Bandeau groupe ────────────────────────────────────────────────────
        lines.append(f'#block(')
        lines.append('  width: 100%,')
        lines.append(f'  stroke: (left: 5pt + rgb("{role_color}")),')
        lines.append('  fill: luma(252),')
        lines.append('  radius: (right: 6pt),')
        lines.append('  inset: (left: 12pt, right: 10pt, top: 8pt, bottom: 8pt),')
        lines.append('  grid(')
        lines.append('    columns: (1fr, auto),')
        lines.append('    column-gutter: 8pt,')
        lines.append('    align: horizon,')

        # Cellule 1 : nom + objectif + explication
        lines.append('    grid(')
        lines.append('      columns: 1,')
        lines.append('      row-gutter: 3pt,')
        lines.append(f'      text(size: 1em, weight: "bold")[{nom_groupe}],')
        if objectif_grp:
            lines.append(f'      text(size: 0.85em, fill: rgb("#333333"))[{objectif_grp}],')
        else:
            lines.append('      [],')
        if explication:
            lines.append(f'      text(size: 0.8em, style: "italic", fill: rgb("#666666"))[{explication}],')
        lines.append('    ),')

        # Cellule 2 : badge rôle
       # lines.append(f'    box(fill: rgb("{role_color}"), radius: 999pt,')
       # lines.append(f'      inset: (x: 10pt, y: 5pt),')
       # lines.append(f'      text(size: 0.75em, weight: "bold", fill: white)[{role_text.upper()}]')
       # lines.append('    ),')

        lines.append('  )')
        lines.append(')')
        lines.append('#v(0.4em)')

        # ── Grille indicateurs ────────────────────────────────────────────────
        if indicateurs:
            lines.append('#block(')
            lines.append('  width: 100%,')
            lines.append('  inset: (left: 17pt),')
            lines.append('  grid(')
            lines.append('    columns: (40pt, 1fr),')
            lines.append('    row-gutter: 4pt,')
            lines.append('    column-gutter: 6pt,')
            # En-têtes
            lines.append(f'    text(size: 0.78em, weight: "bold", fill: rgb("{role_color}"))[Fiche n°],')
            lines.append(f'    text(size: 0.78em, weight: "bold", fill: rgb("{role_color}"))[Indicateur],')
            # Lignes indicateurs
            for ind in indicateurs:
                ind_num    = typst_escape(str(ind.get('num_fiche') or ind.get('id') or ''))
                ind_nom    = typst_escape(str(ind.get('nom') or ''))
                clean_id   = ind_num.replace(' ', '-').replace('°', '')
                label_name = f'ind-{clean_id}'
                lines.append(f'    text(size: 0.8em, fill: rgb("#555555"))[#link(<{label_name}>)[{ind_num}]],')
                lines.append(f'    text(size: 0.8em)[#link(<{label_name}>)[{ind_nom}]],')
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


def identifier_derniere_ligne(iterable):
    it = iter(iterable)
    try:
        current = next(it)
    except StopIteration:
        return  # Itérable vide
    for item in it:
        yield current, False
        current = item
    yield current, True



def generate_typst_annexe_suivi_modification(output_path, csv_path):
    title = "Suivi détaillé des modifications"
    lines = []
    
    # Titre principal en syntaxe Typst
    lines.append(f"= {title}\n")

    # Structure du tableau Typst à 5 colonnes pour correspondre à votre fichier complet
  
   
    content = [


       " #set page(",
       "     paper: \"a2\",",
       "     flipped: true,",
       "     margin: (x: 1.5cm, y: 1.5cm),",
       "     )",
       "#show figure: set block(breakable: true)",
       " #figure(",
       
       " caption: [Suivi des commentaires et résolutions],",
       " table(",
       "     columns: (0.3fr, 0.4fr, 0.3fr, 0.4fr, 2fr, 1.2fr, 0.4fr, 2fr),"
       "     align: (",
       "     center + horizon,",
       "     center + horizon,",
       "     left + horizon,",
       "     left + horizon,",
       "     left + horizon,",
       "     center + horizon,",
       "     left + horizon",
       "     ),",
       "     inset: 8pt,",
       "     stroke: 0.5pt + luma(150),",
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

    
    

    try:


        with open(csv_path, mode='r', encoding='utf-8-sig') as f:
            # Lecture du CSV avec détection du point-virgule
            reader = csv.DictReader(f, delimiter=';')
            
            reader = csv.DictReader(f, delimiter=';')

            for row, is_last in identifier_derniere_ligne(reader):

                # Extraction dynamique et tolérante aux variantes d'écriture
                version = typst_escape(get_column_value(row, ['version_document', 'Version_document', 'version']))
                date = typst_escape(get_column_value(row, ['Date', 'date']))
                auteur = typst_escape(get_column_value(row, ['auteur', 'Auteur']))
                page = typst_escape(get_column_value(row, ['page', 'Page']))
                texte = typst_escape(get_column_value(row, ['texte_surligné', 'texte_surligne', 'texte']))
                commentaire = typst_escape(get_column_value(row, ['commentaire', 'commentaires']))
                statut = typst_escape(get_column_value(row, ['Statut', 'statut']))
                resolution = typst_escape(get_column_value(row, ['Résolution', 'Resolution', 'resolution', 'résolution']))

                
                # Ajout de la ligne dans le tableau Typst
                


                if is_last:
                    content.append(f"   [{version}], [{date}], [{page}], [{auteur}], [{texte}], [{commentaire}], [{statut}], [{resolution}]")
                else:
                    content.append(f"   [{version}], [{date}],[{page}], [{auteur}], [{texte}], [{commentaire}], [{statut}], [{resolution}],")
                               
    except FileNotFoundError:
        print(f"Erreur : Le fichier '{csv_path}' n'a pas été trouvé.")
        return
    except Exception as e:
        print(f"Une erreur est survenue lors de la lecture du fichier : {e}")
        return

    # Fermeture des balises Typst
    content.append("  )\n)")
    lines.extend(content)
    
    # Génération du fichier de sortie
    with open(output_path, 'w', encoding='utf-8') as f:
        f.write('\n'.join(lines))
            
    print(f"Le fichier Typst de {title} a été généré avec succès : {output_path}")

def main():
    print('🚀 Génération Typst des fiches avec pages de garde par famille...')
    try:
        tabs = pd.read_excel(XLSX, sheet_name=None)
    except Exception as exc:
        print(f'❌ Impossible de charger {XLSX}: {exc}')
        return

    df_ind  = tabs['indicateurs']
    df_src  = tabs['sources']
    df_dict = tabs['dictionnaire']
    df_theme = tabs['themes']
    df_famille = tabs['Familles']
    df_rel  = tabs['relation indicateur source']
    df_group = tabs['groupes']
    df_rel_group = tabs['relation groupe objectifs']
    df_vigi = tabs['vigilances']

    fiche_number = 0

    for df in [df_ind, df_src, df_rel, df_group, df_rel_group, df_vigi]:
        df.columns = df.columns.str.strip()

    context = build_group_context(df_ind, df_group, df_rel_group,df_theme, df_famille)
    FICHES_TYPST_DIR.mkdir(exist_ok=True)

    generate_typst_note_version('fiches_typst/note_version.typ')

    # generer la page de glossaire
    generate_typst_glossary(df_dict, 'fiches_typst/glossaire.typ')

    # Structure : famille > thème > groupe > indicateurs
    families = build_family_index(df_ind, context)
    count = 0
    entete_count = 0
    toc_count = 0

    for famille_name, themes_data in sorted(families.items(), key=lambda x: x[0] or ''):
        safe_famille = make_safe_name(famille_name)

        # ── Entête famille ────────────────────────────────────────────
        entete_content = generate_family_entete(famille_name, themes_data, df_ind, df_famille)
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
                fiche_number =+ 1
                for ind in sorted(
                    group_info.get('indicateurs', []),
                    key=lambda x: int(x['num_fiche']) if str(x['num_fiche']).isdigit() else 0
                ):
                    ind_id = ind.get('id')
                    if not ind_id:
                        continue

                    try:
                        # Masque combinant l'ID de l'indicateur ET la condition Actif
                        mask = (
                            df_ind['id_indicateur'].astype(str).str.replace('.0', '', regex=False) == str(ind_id)
                        ) & (
                            df_ind['actif'].astype(str).str.strip().str.lower().isin(['true', '1', 'oui', 'yes'])
                        )
                        ind_rows = df_ind[mask]
                    except Exception:
                        continue

                    if ind_rows.empty:
                        print(f'    ⚠️  Indicateur {ind_id} introuvable dans df_ind')
                        continue

                    row = ind_rows.iloc[0]
                    typst_content = render_typst_page(row, context, df_src, df_rel, df_vigi, fiche_number)
                    path = FICHES_TYPST_DIR / f'{ind_id}.typ'
                    path.write_text(typst_content, encoding='utf-8')
                    count += 1

    print(f'✅ {entete_count} entêtes famille générées')
    print(f'✅ {toc_count} TOC thème générés')
    print(f'✅ {count} fiches Typst générées dans {FICHES_TYPST_DIR}/')

    # ── Index principal ───────────────────────────────────────────────
    index_content = render_index_typst(
        families,
        PROJECT.get('title'),
        PROJECT.get('subtitle'),
        PROJECT.get('autor')
    )

    generate_typst_annexe_suivi_modification("fiches_typst/annexe_suivi_modifications.typ",CSV_SUIVI_COMMENTAIRES)
    index_content += f'#include "fiches_typst/annexe_suivi_modifications.typ"'

    index_path = Path('index_typst.typ')
    index_path.write_text(index_content, encoding='utf-8')
    print('✅ index_typst.typ mis à jour.')

    # ── Compilation PDF ───────────────────────────────────────────────
    print('📄 Compilation PDF...')
    compile_typst(index_path, Path(f'{PROJECT.get('title')}-v{PROJECT.get('version')}.pdf'))


if __name__ == '__main__':
    main()
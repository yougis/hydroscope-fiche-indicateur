#!/usr/bin/env python3
import pandas as pd
import yaml
from pathlib import Path
from datetime import date
import re

# --- CONFIGURATION DU PROJET ---
XLSX = Path("fiches indicateurs.xlsx")
FICHES_DIR = Path("fiches")
FICHES_DIR.mkdir(exist_ok=True)

PROJECT = {
    "title":     "Fiches indicateurs HydroScope",
    "subtitle":  "Catalogue des indicateurs de suivi et de comparaison des captages AEP",
    "author":    "Hugo Roussaffa",
    "version":   "0.1",
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



def index_qmd(familles):
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

    #lines.append(f"\n---\n", "## Sommaire par thématique\n")
    #for famille in sorted(familles.keys()):
    #    lines.append(f"\n### {famille}\n")
    #    for item in familles[famille]:
    #        lines.append(f"- [{item['nom']}](fiches/{item['id']}.qmd)")
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
        "logo": "ressources/OEIL_logo.png",
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
            "pdf": {
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
    except Exception as e:
        print(f"❌ Erreur : {e}"); return

    # Nettoyage des noms de colonnes
    for df in [df_ind, df_src, df_rel, df_dict]:
        df.columns = df.columns.str.strip()

    familles = {}

    for _, row in df_ind.iterrows():
        id_ind = v(row, 'id_indicateur')
        nom_ind = v(row, 'nom_indicateur')

        if not is_valid_data(id_ind, nom_ind):
            continue

        # --- GÉNÉRATION DU CONTENU ---
        content = f"---\ntitle: \"{nom_ind}\"\nsubtitle: \"Fiche indicateur n°{id_ind}\"\n---"
        
        # 1. Introduction
        intro_row = df_dict[df_dict['affichage'] == 'introduction']
        if not intro_row.empty:
            txt = v(row, intro_row.iloc[0]['attribut'])
            if txt: 
                content += f"\n{txt}\n\n"

        # 2. Tableau d'identification
        content += "## Identification\n\n | Libelle | Valeur |\n|:---|:---|\n"
        for _, item in df_dict[df_dict['affichage'] == 'tableau'].iterrows():
            valeur = v(row, item['attribut'])
            if valeur: content += f"| **{item['libelle_affiche']}** | {valeur} |\n"

        # 3. Sections détaillées (Méthodes, Modalités, etc.)
        for _, item in df_dict[df_dict['affichage'] == 'section'].iterrows():
            valeur = v(row, item['attribut'])
            if valeur: content += f"\n## {item['libelle_affiche']}\n{valeur}\n"

        # 3.1 Sections visualisation 
        content += "\n\n## Modalité de visualition \n\n| Libelle |  Valeur | \n|:---|:---|\n"
        for _, item in df_dict[df_dict['affichage'] == 'visualisation'].iterrows():
            valeur = v(row, item['attribut'])
            if valeur: content += f"| **{item['libelle_affiche']}** | {valeur} |\n"

        # 4. SOURCES DE DONNÉES DÉTAILLÉES
        # On récupère les IDs des ressources actives pour cet indicateur
        mask_rel = (df_rel['id_indicateur'].astype(str).str.replace(".0","", regex=False) == str(id_ind)) & \
                   (df_rel['actif'].str.strip().str.capitalize() == "Oui")
        rel_ids = df_rel[mask_rel]['id_ressource'].astype(str).str.replace(".0","", regex=False).tolist()
        
        content += "\n##  Sources de données\n"
        sources_liees = df_src[df_src['id_ressource'].astype(str).str.replace(".0","", regex=False).isin(rel_ids)]
        
        if not sources_liees.empty:
            for _, s in sources_liees.iterrows():
                nom_res = v(s, 'nom_ressource')
                content += f"\n### {nom_res}\n" # Double saut de ligne après le titre
                
                # Utilisation de puces simples sans gras sur les labels pour éviter les conflits YAML
                # Ou ajout d'un caractère invisible avant pour casser la détection
                if v(s, 'origine'): content += f"- Origine : {v(s, 'origine')}\n"
                if v(s, 'distributeur'): content += f"- Distributeur : {v(s, 'distributeur')}\n"
                if v(s, 'couverture_spatiale'): content += f"- Couverture spatiale: {v(s, 'couverture_spatiale')}\n"
                if v(s, 'actualisation'): content += f"- Actualisation : {v(s, 'actualisation')}\n"
                
                url = v(s, 'url')
                if url and "http" in url:
                    content += f"\n[Accéder à la ressource]({url})\n"
                
                rem = v(s, 'remarques')
                if rem:
                    # On évite le "*" en début de ligne
                    content += f"\nNote : {rem}\n"
                
                content += "\n" # Espace simple au lieu de --- qui peut être confondu avec YAML
        else:
            content += "Aucune source de donnée identifiée.\n"

        # Sauvegarde
        (FICHES_DIR / f"{id_ind}.qmd").write_text(content, encoding="utf-8")
        
        fam = v(row, "famille") or "Autres"
        familles.setdefault(fam, []).append({"id": id_ind, "nom": nom_ind})


    # Fichiers explicatif
    Path("informations générales.qmd").write_text(info_qmd(df_dict), encoding="utf-8")


    # Fichiers de structure
    Path("index.qmd").write_text(index_qmd(familles), encoding="utf-8")
    Path("_quarto.yml").write_text(quarto_yml(familles), encoding="utf-8")

    print(f"✅ Terminé : {sum(len(v) for v in familles.values())} fiches générées avec succès.")

if __name__ == "__main__":
    main()
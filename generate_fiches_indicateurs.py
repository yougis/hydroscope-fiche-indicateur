#!/usr/bin/env python3
import pandas as pd
import yaml
from pathlib import Path
from datetime import date

# --- CONFIGURATION DU PROJET ---
XLSX = Path("indicateurs.xlsx")
FICHES_DIR = Path("fiches")
FICHES_DIR.mkdir(exist_ok=True)

PROJECT = {
    "title":     "Fiches indicateurs HydroScope",
    "subtitle":  "Catalogue des indicateurs de suivi hydrologique",
    "author":    "Yapuka SARL",
    "copyright": "Copyright Yapuka SARL — 2026. Tous droits réservés.",
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

def index_qmd(familles):
    today = date.today().strftime("%d/%m/%Y")
    lines = [f"# {PROJECT['title']}\n", f"**{PROJECT['subtitle']}**\n",
             f"Version {PROJECT['version']} — {today}\n", f"{PROJECT['copyright']}\n",
             "\n---\n", "## Sommaire par thématique\n"]
    for famille in sorted(familles.keys()):
        lines.append(f"\n### {famille}\n")
        for item in familles[famille]:
            lines.append(f"- [{item['nom']}](fiches/{item['id']}.qmd)")
    return "\n".join(lines) + "\n"

def quarto_yml(familles):
    chapters = ["index.qmd"]
    for famille in sorted(familles.keys()):
        chapters.append({"part": famille, "chapters": [f"fiches/{i['id']}.qmd" for i in familles[famille]]})
    
    config = {
        "project": {"type": "book", "pre-render": "generate_fiches_indicateurs.py"},
        "book": {
            "title": PROJECT["title"], "subtitle": PROJECT["subtitle"],
            "author": PROJECT["author"], "chapters": chapters, "downloads": ["pdf"]
        },
        "format": {
            "pdf": {"documentclass": "scrreprt", "papersize": "a4", "toc": True, "lang": "fr",
                    "include-in-header": {"text": "\\usepackage{fancyhdr}\n\\pagestyle{fancy}\n"}},
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
        content = f"---\ntitle: \"{nom_ind}\"\nsubtitle: \"Fiche technique n°{id_ind}\"\n---\n\n"
        
        # 1. Introduction
        intro_row = df_dict[df_dict['affichage'] == 'introduction']
        if not intro_row.empty:
            txt = v(row, intro_row.iloc[0]['attribut'])
            if txt: content += f"{txt}\n\n"

        # 2. Tableau d'identification
        content += "## 📋 Identification\n\n| Caractéristique | Valeur |\n|:---|:---|\n"
        for _, item in df_dict[df_dict['affichage'] == 'tableau'].iterrows():
            valeur = v(row, item['attribut'])
            if valeur: content += f"| **{item['libelle_affiche']}** | {valeur} |\n"

        # 3. Sections détaillées (Méthodes, Modalités, etc.)
        for _, item in df_dict[df_dict['affichage'] == 'section'].iterrows():
            valeur = v(row, item['attribut'])
            if valeur: content += f"\n## {item['libelle_affiche']}\n\n{valeur}\n"

        # 4. Sources de données (Liaison Relationnelle)
        rel_ids = df_rel[(df_rel['id_indicateur'].astype(str).str.replace(".0","", regex=False) == str(id_ind)) & 
                         (df_rel['actif'].str.strip().str.capitalize() == "Oui")]['id_ressource']
        
        sources_liees = df_src[df_src['id_ressource'].astype(str).str.replace(".0","", regex=False).isin(rel_ids.astype(str))]
        
        content += "\n## 📂 Sources de données\n"
        if not sources_liees.empty:
            for _, s in sources_liees.iterrows():
                u = v(s, 'url')
                lnk = f" — [Lien]({u})" if u and "http" in u else ""
                content += f"- **{v(s, 'nom_ressource')}** ({v(s, 'origine')}){lnk}\n"
        else:
            content += "_Aucune source active répertoriée._\n"

        # Sauvegarde
        (FICHES_DIR / f"{id_ind}.qmd").write_text(content, encoding="utf-8")
        
        fam = v(row, "famille") or "Autres"
        familles.setdefault(fam, []).append({"id": id_ind, "nom": nom_ind})

    # Fichiers de structure
    Path("index.qmd").write_text(index_qmd(familles), encoding="utf-8")
    Path("_quarto.yml").write_text(quarto_yml(familles), encoding="utf-8")

    print(f"✅ Terminé : {sum(len(v) for v in familles.values())} fiches générées avec succès.")

if __name__ == "__main__":
    main()
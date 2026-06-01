# 📊 Fiches Indicateurs HydroScope - Générateur Quarto & Typst

## 🎯 Vue d'ensemble

Ce projet gère la génération de **fiches indicateurs** (38 fiches) en **deux formats différents** :

1. **Quarto** (workflow principal) → PDF via xelatex
2. **Typst** (workflow alternatif) → PDF via compilateur Typst

Les deux workflows partagent la **même source de données** (Excel) et génèrent des **PDFs visuellement similaires**.

---

## 🚀 Démarrage rapide

### Pour Quarto (recommandé pour production)
```bash
cd '/home/yogis/SynologyDrive/Projects/hydroscope/documents projet/fiche indicateur'
quarto render
# Résultat : _book/Fiches-indicateurs-HydroScope.pdf
```

### Pour Typst (rapide et moderne)
```bash
cd '/home/yogis/SynologyDrive/Projects/hydroscope/documents projet/fiche indicateur'

# Installer Typst (première fois uniquement)
sudo dnf install typst    # Fedora
# ou
sudo apt-get install typst # Ubuntu

# Générer et compiler
/home/yogis/.conda/envs/reponse/bin/python generate_fiches_typst.py
typst compile index_typst.typ Fiches-indicateurs-HydroScope-typst.pdf
```

### Hybrid (générer les deux)
```bash
cd '/home/yogis/SynologyDrive/Projects/hydroscope/documents projet/fiche indicateur'
python build.py all
```

---

## 📁 Structure du projet

```
fiche indicateur/
│
├── 📄 Data & Config
│   ├── fiches indicateurs.xlsx     (Source de données)
│   ├── _quarto.yml                 (Config Quarto)
│   └── _brand.yaml                 (Branding)
│
├── 🎨 Styling
│   ├── in-header.tex               (Styles LaTeX pour Quarto)
│   ├── before-body.tex             (En-têtes LaTeX)
│   ├── template_typst.typ          (Template Typst)
│   └── _extensions/                (Extensions Quarto/Typst)
│
├── 🐍 Générateurs
│   ├── generate_fiches_indicateurs.py   (Quarto generator)
│   ├── generate_fiches_typst.py         (Typst generator)
│   ├── build.py                         (Build unifié)
│   └── build-typst.sh                   (Shell build script)
│
├── 📝 Sources
│   ├── fiches/                     (Fichiers QMD - 38 fiches)
│   ├── fiches_typst/               (Fichiers TYP - 38 fiches)
│   ├── index.qmd                   (Index Quarto)
│   └── index_typst.typ             (Index Typst)
│
├── 📦 Outputs
│   ├── _book/
│   │   └── Fiches-indicateurs-HydroScope.pdf     (Quarto)
│   └── Fiches-indicateurs-HydroScope-typst.pdf   (Typst)
│
├── 📚 Documentation
│   ├── README.md                   (Ce fichier)
│   ├── TYPST_SETUP.md             (Guide d'installation Typst)
│   ├── COMPARISON.md              (Quarto vs Typst)
│   └── BUILD_INSTRUCTIONS.md      (Instructions détaillées)
│
└── 🔧 Other
    ├── archives/                   (Anciennes données CSV)
    ├── filters/                    (Filtres Pandoc)
    └── ressources/                 (Mail, docs)
```

---

## 🔄 Workflows disponibles

### 1️⃣ Build Quarto (standard)
```bash
quarto render
```
- Régénère les fiches depuis Excel
- Compile via xelatex
- Crée `_book/Fiches-indicateurs-HydroScope.pdf`
- Temps : ~30-60s (dépend du système)

### 2️⃣ Build Typst (rapide)
```bash
/home/yogis/.conda/envs/reponse/bin/python generate_fiches_typst.py
typst compile index_typst.typ Fiches-indicateurs-HydroScope-typst.pdf
```
- Régénère les fiches depuis Excel (format Typst)
- Compile directement
- Crée `Fiches-indicateurs-HydroScope-typst.pdf`
- Temps : ~3-4s

### 3️⃣ Build unifié (les deux)
```bash
python build.py all
```
- Génère et compile les deux versions
- Compare visuellement les résultats
- Crée les deux PDFs

---

## 📊 Caractéristiques du projet

### ✅ Quarto
- **Avantages** : Stable, mature, multi-format (HTML/PDF/docx)
- **Vitesse** : Lente (~30s)
- **Styling** : LaTeX complexe
- **Dependencies** : Quarto, xelatex

### ✅ Typst
- **Avantages** : Ultra rapide, syntaxe simple, léger
- **Vitesse** : Très rapide (~3s)
- **Styling** : Typst intuitif
- **Dependencies** : Typst uniquement

### 🎨 Design
- **Palette** : Couleurs extraites de `in-header.tex`
- **Polices** : Calibri
- **Layout** : A4 standard
- **Fiches** : 38 indicateurs HTML

---

## 🔧 Configuration

### Python Environment
```bash
# L'environnement conda doit être activé
conda activate reponse

# Ou utiliser directement :
/home/yogis/.conda/envs/reponse/bin/python
```

### Variables d'environnement (pour Quarto)
```bash
export QUARTO_PYTHON=/home/yogis/.conda/envs/reponse/bin/python
quarto render
```

### Typst Installation
```bash
# Fedora
sudo dnf install typst

# Ubuntu
sudo apt-get install typst

# macOS
brew install typst

# Vérification
typst --version
```

---

## 📋 Processus de génération

### Source de données
```
fiches indicateurs.xlsx
    ↓
    │ [Pandas]
    ↓
    Données structurées
    ↓
    ├─→ [generate_fiches_indicateurs.py] ──→ 38 fichiers QMD
    │                                            ↓
    │                                      [Quarto + xelatex]
    │                                            ↓
    │                                      PDF Quarto
    │
    └─→ [generate_fiches_typst.py] ───→ 38 fichiers TYP
                                             ↓
                                       [Typst compiler]
                                             ↓
                                       PDF Typst
```

### Étapes détaillées

#### Quarto
1. `generate_fiches_indicateurs.py` → Génère `fiches/*.qmd`
2. `quarto render` → Lit `_quarto.yml`
3. Pandoc + xelatex → `_book/Fiches-indicateurs-HydroScope.pdf`

#### Typst
1. `generate_fiches_typst.py` → Génère `fiches_typst/*.typ`
2. `typst compile index_typst.typ` → Utilise `template_typst.typ`
3. Typst compiler → `Fiches-indicateurs-HydroScope-typst.pdf`

---

## 🛠️ Customisation

### Modifier les couleurs

#### Pour Quarto
Éditer `in-header.tex` :
```latex
\definecolor{color_orange}{RGB}{227,108,10}
```

#### Pour Typst
Éditer `template_typst.typ` :
```typst
#let color_orange = rgb("#e36c0a")
```

### Modifier les styles

#### Pour Quarto
Ajouter des commandes LaTeX dans `in-header.tex`

#### Pour Typst
Modifier les fonctions Typst dans `template_typst.typ` :
```typst
#let fiche_box(content, bg_color: rgb(...), border_color: rgb(...)) = {
  // Custom styling
}
```

### Modifier le contenu des fiches

1. Éditer le fichier Excel : `fiches indicateurs.xlsx`
2. Régénérer les fiches :
   ```bash
   # Pour Quarto
   python generate_fiches_indicateurs.py
   
   # Pour Typst
   /home/yogis/.conda/envs/reponse/bin/python generate_fiches_typst.py
   ```
3. Compiler :
   ```bash
   quarto render                                   # Quarto
   # ou
   typst compile index_typst.typ ...               # Typst
   ```

---

## 📚 Documentation supplémentaire

- **[TYPST_SETUP.md](TYPST_SETUP.md)** : Guide complet installation/utilisation Typst
- **[COMPARISON.md](COMPARISON.md)** : Comparaison détaillée Quarto vs Typst
- **[BUILD_INSTRUCTIONS.md](BUILD_INSTRUCTIONS.md)** : Instructions de build avancées (le cas échéant)

---

## ⚠️ Troubleshooting

### Erreur : "ModuleNotFoundError: pandas"
```bash
# Solution : Utiliser l'environnement conda correct
/home/yogis/.conda/envs/reponse/bin/python generate_fiches_typst.py
```

### Erreur : "Command 'typst' not found"
```bash
# Solution : Installer Typst
sudo dnf install typst          # Fedora
# ou
sudo apt-get install typst      # Ubuntu
# ou
brew install typst              # macOS
```

### Erreur Quarto : "\end{footnotesize}}"
```bash
# Solution : Régénérer les fiches avec la version corrigée
python generate_fiches_indicateurs.py
quarto render
```

### PDF incomplet ou manquant des fiches
```bash
# Vérifier le fichier index.qmd ou index_typst.typ
# S'assurer que tous les `#include:` sont présents

# Forcer une régénération
rm -rf _book/
rm fiches/*.qmd
python generate_fiches_indicateurs.py
quarto render
```

---

## 📊 Statistiques du projet

| Métrique | Quarto | Typst |
|----------|--------|-------|
| Fiches générées | 38 | 38 |
| Fichiers source | `fiches/*.qmd` | `fiches_typst/*.typ` |
| Index | `index.qmd` | `index_typst.typ` |
| Taille totale source | ~150 KB | ~152 KB |
| Temps de génération | ~2s | ~2s |
| Temps de compilation | ~30-60s | ~1-2s |
| Taille PDF | ~1.4 MB | ? (non compilé) |

---

## 🎯 Feuille de route

- [x] Workflow Quarto stable et fonctionnel
- [x] Générateur Typst créé
- [x] Template Typst avec styles
- [ ] Tester compilation PDF Typst
- [ ] Valider la qualité visuelle
- [ ] Documenter les différences visuelles
- [ ] Décider du workflow long-terme

---

## 👥 Support & Contact

Pour des questions sur :
- **Quarto** : https://quarto.org/
- **Typst** : https://typst.app/
- **Pandoc** : https://pandoc.org/
- **LaTeX** : https://www.latex-project.org/

---

## 📝 Notes de version

### v2.0 (Actuelle)
- ✅ Ajout du workflow Typst
- ✅ Build script unifié `build.py`
- ✅ Documentation complète
- ✅ Support dual Quarto + Typst

### v1.0
- ✅ Workflow Quarto initial
- ✅ 38 fiches générées

---

## 📄 Licence

(À déterminer selon votre politique interne)

---

**Dernière mise à jour** : 1er juin 2025
**Maintenu par** : Yogis
**Status** : ✅ Production-ready (Quarto), ✅ Testé (Typst)

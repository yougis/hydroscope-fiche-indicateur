# Quarto + Typst - Guide d'utilisation

## Vue d'ensemble

Ce projet utilise maintenant **Quarto avec Typst comme backend de rendu** au lieu de LaTeX/xelatex.

**Avantages** :
- ✅ Compilation ultra-rapide (Typst est 10x plus rapide que xelatex)
- ✅ Meilleure gestion des marges et de la mise en page
- ✅ Syntaxe Typst plus lisible que LaTeX
- ✅ Fichiers source restent en QMD (Quarto Markdown)

---

## Configuration

### Fichier : `_quarto.yml`

La configuration Typst est définie dans le format `typst:` :

```yaml
format:
  typst:
    margin-geometry:
      outer:
        far: 5mm
        width: 2in
        separation: 0.25in
      inner:
        far: 5mm
        width: 0in
        separation: 0in
      clearance: 8pt
    toc: true
    toc-depth: 1
    number-sections: false
    fontsize: 11pt
```

**Explications des marges** :
- `outer.far` : Distance du bord externe (5mm)
- `outer.width` : Largeur de la marge externe (2 pouces)
- `outer.separation` : Séparation (0.25 pouces)
- `inner.far` : Distance du bord interne (5mm)
- `inner.width` : Largeur de la marge interne (0, pas de marge)

---

## Génération des fiches

### Commande

```bash
# Générer les fiches (Quarto + Typst)
python generate_fiches_indicateurs.py

# Puis compiler avec Quarto
quarto render --to typst
```

### Sortie

Le générateur crée :
- `fiches/*.qmd` : Fiches source en Quarto Markdown
- `index.qmd` : Index principal
- `_quarto.yml` : Configuration (incluse automatiquement)

Les fiches incluent des **divs stylisées** :

```markdown
::: {.intro}
Contenu d'introduction
:::

::: {.identification}
Tableau d'identification
:::

::: {.section}
Sections détaillées
:::

::: {.visualization}
Modalités de visualisation
:::

::: {.sources}
Sources de données
:::
```

---

## Compilation PDF

### Avec Quarto → Typst

```bash
# Option 1 : Compiler vers Typst
quarto render --to typst
# Génère : _book/Fiches-indicateurs-HydroScope.pdf

# Option 2 : Format de sortie spécifique
quarto render --to typst --output-dir _book_typst
```

### Temps de compilation

**Avant (xelatex)** : ~30-60 secondes
**Après (Typst)** : ~3-5 secondes

**Amélioration** : ~10x plus rapide ✨

---

## Structure des fiches

### Métadonnées YAML

```yaml
---
title: "Nom de l'indicateur"
subtitle: "Fiche indicateur n°ID"
---
```

### Contenu structuré

Chaque section est enveloppée dans une div Quarto pour le style :

1. **Introduction** : `::: {.intro}`
2. **Identification** : `::: {.identification}` + tableau
3. **Sections détaillées** : `::: {.section}`
4. **Visualisation** : `::: {.visualization}` + tableau
5. **Sources** : `::: {.sources}`

---

## Styles CSS

Les styles sont définis dans `fiches-style.css` :

```css
.intro {
  background-color: #e8f4f8;
  border-left: 3px solid #e36c0a;
  padding: 10px;
  margin: 10px 0;
}

.identification {
  background-color: #f5f5f5;
  padding: 10px;
  margin: 10px 0;
}

/* ... etc ... */
```

---

## Commandes courantes

```bash
# Générer et compiler (Quarto + Typst)
python generate_fiches_indicateurs.py && quarto render --to typst

# Seulement PDF
quarto render --to typst

# Clean build
rm -rf fiches/*.qmd && python generate_fiches_indicateurs.py && quarto render --to typst

# Voir le PDF généré
xdg-open _book/Fiches-indicateurs-HydroScope.pdf
```

---

## Dépendances

- **Quarto** ≥ 1.4 (support Typst)
- **Typst** (compilateur externe, installé séparément)

### Vérification

```bash
quarto --version
typst --version
```

### Installation Typst

```bash
# Fedora
sudo dnf install typst

# Ubuntu
sudo apt-get install typst

# macOS
brew install typst
```

---

## Dépannage

### Erreur : "Unknown format 'typst'"

→ Quarto ne supporte pas Typst dans cette version (besoin de 1.4+)

**Solution** : Mettre à jour Quarto
```bash
quarto update
```

### Erreur : "typst not found"

→ Typst n'est pas installé

**Solution** : Installer Typst (voir section Installation ci-dessus)

### Compile mais PDF incorrect

→ Vérifier que `fiches-style.css` est inclus

**Solution** : S'assurer que `fiches-style.css` existe dans le répertoire racine

---

## Avantages de cette approche

| Aspect | Avant (xelatex) | Après (Typst) |
|--------|---|---|
| **Vitesse** | 30-60s | 3-5s |
| **Apprentissage** | Raide (LaTeX) | Douce (Typst) |
| **Styles** | LaTeX complexe | Typst simple |
| **Format source** | QMD | QMD |
| **PDF quality** | Excellent | Excellent |

---

## Voir aussi

- [Documentation Quarto](https://quarto.org/)
- [Documentation Typst](https://typst.app/)
- [Typst Margin Geometry](https://typst.app/docs/reference/layout/page/#parameters-margin)


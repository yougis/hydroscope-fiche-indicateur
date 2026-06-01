# Synthèse des ajustements à réaliser

## Objectif
Ce document propose une synthèse claire des ajustements à réaliser sur les éléments fournis dans le dossier `fiche indicateur`, en tenant compte :
- des remarques de Stéphane Balayre,
- des suggestions de Marjolaine,
- des points soulevés dans la transcription de la présentation DIMENC / DASS.

---

## 1. Remarques principales à intégrer

### 1.1 Priorisation et organisation
- Ajouter une priorisation claire des indicateurs.
- Présenter une organisation par familles thématiques.
- Séparer explicitement ``Enjeux`` / ``Pressions`` / ``Vulnérabilités`` / ``Qualitatif``.
- Signaler les indicateurs à couverture partielle du territoire (UNESCO, ZICO, Aires protégées, etc.).

### 1.2 Simplification des fiches
- Rendre les fiches plus compactes et plus focalisées.
- Mettre en avant : famille, type, objectif, priorité, support spatial, pondération.
- Réduire les sections trop détaillées ou redondantes pour un livrable de cadrage.

### 1.3 Harmonisation des champs et nomenclature
- Corriger la typo ``Modalité de visualition``.
- Regrouper dans une même section les données de nature / discret/continu et les informations de source.
- Clarifier la distinction entre ``sens de l’indicateur`` et ``définition de la criticité``.
- Uniformiser la présentation des indicateurs UD AEP ayant un but proche.

### 1.4 Redondances et cohérence
- Examiner les redondances: couvert végétal vs couvert forestier, zones protégées vs zones UNESCO, vulnérabilité intrinsèque vs IDPR.
- Proposer un schéma d’organisation pour détecter et limiter les doublons.
- Retirer ou repositionner les éléments de type note interne (ex. ``Synthèse échanges Stéphane du 24 avril 2026``) vers un bloc dédié interne.

### 1.5 Données / périmètre / gouvernance
- Prendre en compte que tous les captages d’eau potable doivent être traités, pas seulement ceux avec PPE.
- Clarifier la disponibilité des données UD et les risques RGPD évoqués par la DASS.
- Prévoir une note sur l’intégration possible de données dynamiques (Météo-France, Hydro-Pacifique, GéoRep) sans en faire un prérequis pour le catalogue.
- Rappeler que l’outil cible plusieurs interfaces (expert, gestionnaire, public/partenaire).

---

## 2. Ajustements recommandés par fichier

### 2.1 `fiches indicateurs-dictionnaire.csv`
- Ajouter un attribut explicite ``priorite`` si ce n’est pas déjà bien structuré.
- Clarifier : ``Ponderation`` -> spécifier si l’indicateur participe à l’analyse multicritère.
- Ajouter un champ ``applicabilite_territoire`` ou ``couverture_partielle`` pour indiquer les indicateurs locaux.
- Déplacer / redéfinir : ``quantitatif_qualitatif``, ``discret_continue``, ``relatif_absolu`` dans une catégorie ``Données``.
- Supprimer ou rendre facultatif l’attribut ``synthese_echanges`` pour les fiches publiques / grand public.

### 2.2 `fiches indicateurs-indicateurs.csv`
- Compléter / harmoniser les valeurs :
  - ``priorite`` : oui / non / moyenne / faible
  - ``Ponderation`` : oui / non / à confirmer
  - ``relatif_absolu`` : vérifier la cohérence des unités (ha en absolu, ratio en relatif)
- Vérifier les indicateurs locaux ou non transposables : Zones UNESCO, Zones protégées, KBA / ZICO.
- Ajouter un champ ``justification_pertinence`` ou ``remarque_usage`` pour les indicateurs non uniformes.

### 2.3 `generate_fiches_indicateurs.py`
- Modifier la génération pour :
  - construire un bloc ``Identification`` plus court : numéro, famille, type, priorité.
  - créer un bloc ``Objectif`` séparé.
  - regrouper les informations de visualisation/format de données dans une seule table.
  - éviter d’afficher ``Synthèse échanges Stéphane`` dans les fiches finales ; le conserver dans un document interne séparé.
  - améliorer la détection des ressources actives dans les sources.
- Corriger le titre de section ``Modalité de visualition``.
- Ajouter un sommaire par famille dans `index.qmd`.

### 2.4 `index.qmd`
- Ajouter un sommaire structuré par famille.
- Inclure une introduction plus claire sur la logique de classification : enjeu / pression / vulnérabilité.
- Ajouter un schéma organisationnel ou une carte mentale (même textuelle) des familles d’indicateurs.

### 2.5 `informations générales.qmd`
- Compléter le glossaire avec les termes utilisés dans les fiches : ``priorité``, ``pondération``, ``support spatial``, ``normalisation``, ``critère``.
- Ajouter un encadré ``Usage du catalogue`` : ce qui est destiné aux décideurs, ce qui reste interne.

### 2.6 Fiches QMD existantes (`fiches/*.qmd`)
- Vérifier les fiches les plus importantes (1 à 10, 100 à 105, 200, 300...) pour cohérence et lisibilité.
- Rendre les fiches « une page » en limitant le texte aux éléments essentiels.
- Supprimer les descriptions redondantes ou techniques non nécessaires à ce stade.

---

## 3. Actions concrètes prioritaires

### Priorité haute
1. Formaliser la hiérarchie des indicateurs : ``priorite`` + ``famille`` + ``type``.
2. Refaire le sommaire de `index.qmd` pour rendre le catalogue immédiatement lisible.
3. Corriger la structure de génération dans `generate_fiches_indicateurs.py` pour produire des fiches plus simples.
4. Revue des indicateurs locaux / non uniformes et identification des cas à couverture partielle.

### Priorité moyenne
1. Normaliser les champs ``relatif_absolu``, ``quantitatif_qualitatif``, ``discret_continue``.
2. Documenter le traitement des sources et des données (commentaire sur la disponibilité / actualisation).
3. Clarifier le périmètre « captages avec ou sans PPE ».

### Priorité basse
1. Ajouter une colonne ``couverture_partielle`` ou ``commentaire d’usage territorial``.
2. Rédiger une fiche interne dédiée aux commentaires de réunion et aux points RH / gouvernance.
3. Préparer un bloc d’accompagnement sur les futures interfaces et la gouvernance des données.

---

## 4. Notes issues de la réunion de présentation

- Le catalogue doit rester un outil de cadrage plus que de productivité opérationnelle.
- Il faut maintenir des jeux de données pérennes, réutilisables, et ne pas s’appuyer sur des études ponctuelles.
- L’intégration de données dynamiques est pertinente, mais elle ne doit pas bloquer la publication du catalogue.
- Les indicateurs de vulnérabilité intrinsèque doivent être distingués des indicateurs de menace / pression pour éviter les doublons de pondération.
- La donnée UD est stratégique, mais elle peut être sensible ; il vaut mieux isoler cette question dans le périmètre et la mentionner comme point à préciser.
- La notion de “signalement grand public” est intéressante, mais hors scope pour ce catalogue de fiches.

---

## 5. Propositions de livrables additionnels

- Un tableau de bord simplifié des familles d’indicateurs (families / enjeux / pressions / vulnérabilités).
- Une grille d’évaluation des priorités : ``critique / important / secondaire``.
- Une note interne sur les indicateurs non uniformes et les conditions de leur exploitation.

---

## 6. Conclusion
Cette synthèse vise à rendre le catalogue plus lisible, à limiter les redondances et à valoriser les priorités.

Les principaux chantiers sont :
- clarifier la structure du catalogue,
- simplifier les fiches,
- uniformiser les catégories de données,
- documenter le périmètre des sources et des indicateurs localisés.

Avec ces ajustements, le livrable pourra mieux répondre aux retours de Stéphane, Marjolaine et aux besoins exprimés par la DASS / DIMENC.

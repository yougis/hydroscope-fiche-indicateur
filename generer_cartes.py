#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""Génère un PDF recto/verso des fiches indicateurs (A6 paysage) à partir de liste_indicateurs_v4.csv."""

import csv
import os

from PIL import Image, ImageDraw, ImageFont

HERE = os.path.dirname(os.path.abspath(__file__))
CSV_PATH = os.path.join(HERE, "./release/liste_indicateurs_v4.csv")
OUT_PATH = os.path.join(HERE, "./release/fiches_indicateurs_hydroscope_A6.pdf")

W, H = 1748, 1240  # A6 paysage @ 300 dpi
MARGIN = 90
CARD_W = W - 2 * MARGIN  # 1568 px
TOP = 120
BOTTOM = H - MARGIN

FONT_REG = "/usr/share/fonts/dejavu-sans-fonts/DejaVuSans.ttf"
FONT_BOLD = "/usr/share/fonts/dejavu-sans-fonts/DejaVuSans-Bold.ttf"
FONT_ICON = "/usr/share/fonts/gdouros-symbola/Symbola.ttf"

# --- Nouvelles données enrichies depuis les CSV joints ---
# Chemins relatifs au dossier fiche indicateur (parent de release/)
SOURCES_CSV = os.path.join(HERE, "fiches-csv", "fiches indicateurs-sources.csv")
RELATIONS_CSV = os.path.join(HERE, "fiches-csv", "fiches indicateurs-relations-source.csv")
INDICATEURS_CSV = os.path.join(HERE, "fiches-csv", "fiches indicateurs-indicateurs.csv")

BG = (255, 255, 255)
INK = (30, 41, 59)          # texte principal
INK_SOFT = (71, 85, 105)    # texte secondaire
ACCENT = (31, 111, 139)     # icône / filet
ACCENT_BG = (234, 243, 247) # fond du disque d'icône
FONT_SIZE_QUESTION = 34     # police pour questions formulaire (34 px)
FONT_SIZE_UNITE = 38        # police pour unité/métrique

# Mapping id_indicateur -> icône (glyphes couverts par Symbola)
ICONS = {
    # --- EAU POTABLE & INFRASTRUCTURES ---
    1: "\U0001F6B0",     # Capacité de production      🚰
    2: "\U0001F4CF",     # Longueur réseau             📏
    3: "\U0001F6E2",     # Capacité réservoir          🛢️
    4: "\u2697",         # Traitement                  ⚗️
    5: "\U0001F501",     # Interconnexion              🔁
    6: "\U0001F465",     # Population desservie        👥
    7: "\U0001F4DC",     # Statut AODPE                📜
    8: "\U0001F6E1",     # Statut PPE                  🛡️
    9: "\u26F2",         # Type ouvrage                ⛲
    10: "\U0001F504",    # Statut captage              🔄
    11: "\U0001F4D1",    # Statut du foncier           📑
    12: "\U0001F3E5",    # Établissements publics      🏥

    # --- ENVIRONNEMENT & BIODIVERSITÉ ---
    100: "\U0001F3DB",   # Zones UNESCO                🏛️
    101: "\U0001F3DE",   # Zones protégées provinciales 🏞️
    102: "\U0001F426",   # KBA / ZICO                  🐦
    104: "\U0001F335",   # Espèces rares / forêt sèche 🌵
    105: "\U0001F33F",   # Occupation sol (végétal)    🌿
    106: "\U0001F332",   # Occupation sol (forestier)  🌲
    107: "\U0001F33E",   # Occupation sol (agricole)   🌾

    # --- RISQUES & PRESSIONS ---
    200: "\U0001F525",   # Incendies cumulés           🔥
    201: "\U0001F3DC",   # Surface érosion             🏜️
    202: "\u26F0",       # Terrain nu                  ⛰️
    203: "\U0001F6A7",   # Glissement terrain          🚧
    204: "\U0001F98C",   # Espèces exotiques envahissantes 🦌

    # --- AMÉNAGEMENT & USAGES ---
    300: "\U0001F3ED",   # ICPE                        🏭
    301: "\u26CF",       # Zone exploitation minière   ⛏️
    302: "\U0001F3D9",   # Urbanisation                🏙️
    304: "\U0001F3E0",   # Habitations                 🏠
    305: "\U0001F309",   # Franchissements             🌉
    306: "\U0001F6E3",   # Linéaire routes             🛣️
    307: "\U0001F4D0",   # Plan d'Urbanisme Directeur  📐
    308: "\u26A0",       # Autres IOTA                 ⚠️

    # --- RESSOURCES & HYDROLOGIE ---
    401: "\U0001F48E",   # Géologie                    💎
    402: "\U0001F573",   # Vulnérabilité eaux souterraines 🕳️
    500: "\u2696",       # BBR                         ⚖️
    501: "\U0001F327",   # Pluviométrie                🌧️
    503: "\U0001F4CD",   # Nb prélèvements AODPE       📍
    504: "\U0001F4A7",   # Volume prélèvements AODPE   💧
}

_font_cache = {}


def font(path, size):
    key = (path, size)
    if key not in _font_cache:
        _font_cache[key] = ImageFont.truetype(path, size)
    return _font_cache[key]


def wrap_text(draw, text, f, max_width):
    """Coupe le texte en plusieurs lignes selon la largeur maximale."""
    words = text.split()
    if not words:
        return []
    lines = []
    cur = words[0]
    for w in words[1:]:
        trial = cur + " " + w
        if draw.textlength(trial, font=f) <= max_width:
            cur = trial
        else:
            lines.append(cur)
            cur = w
    lines.append(cur)
    return lines


def load_enriched_data():
    """Charge les données complémentaires depuis les CSV joints : sources, relations, indicateurs."""
    # 1. Relations indicateur → ressource
    relations = {}
    try:
        with open(RELATIONS_CSV, encoding="utf-8-sig", newline="") as f:
            reader = csv.DictReader(f, delimiter=";")
            for row in reader:
                iid = row["id_indicateur"].strip()
                rid = row["id_ressource"].strip()
                comment = row.get("commentaire", "").strip()
                if iid not in relations:
                    relations[iid] = {"id_ressource": rid, "commentaire": comment}
                else:
                    if relations[iid].get("actif") != "Oui" and comment:
                        relations[iid]["id_ressource"] = rid
                        relations[iid]["commentaire"] = comment
    except FileNotFoundError:
        pass

    # 2. Détails ressources (nom, type, origine, url, etc.)
    sources = {}
    try:
        with open(SOURCES_CSV, encoding="utf-8-sig", newline="") as f:
            reader = csv.DictReader(f, delimiter=";")
            for row in reader:
                rid = row["id_ressource"].strip()
                sources[rid] = {
                    "nom_ressource": row.get("nom_ressource", "") or "",
                    "origine": row.get("origine", "") or "",
                    "type_source": row.get("type_source", "") or "",
                    "couverture_spatiale": row.get("couverture_spatiale", "") or "",
                    "actualisation": row.get("actualisation", "") or "",
                    "description_ressource": (row.get("description_ressource") or "")[:90],
                    "documentation_ressource": (row.get("documentation_ressource") or "")[:60],
                    "contraintes_ressource": (row.get("contraintes_ressource") or "")[:50],
                }
    except FileNotFoundError:
        pass

    # 3. Infos techniques indicateurs (unite, objectif_INFO, objectif_AMC, modalites)
    indicateurs = {}
    try:
        with open(INDICATEURS_CSV, encoding="utf-8-sig", newline="") as f:
            reader = csv.DictReader(f, delimiter=";")
            for row in reader:
                iid = row.get("fiche_indicateur", "") or "".strip()
                if not iid:
                    continue
                indicateurs[iid] = {
                    "unite": row.get("unite", "") or "",
                    "objectif_INFO": row.get("objectif_INFO", "") or None,
                    "objectif_AMC": row.get("objectif_AMC", "") or None,
                    "modalites": row.get("modalites", "") or None,
                    "quantitatif_qualitatif": row.get("quantitatif_qualitatif", "") or None,
                    "discret_continu": row.get("discret_continu", "") or None,
                    "relatif_absolu": row.get("relatif_absolu", "") or None,
                }
    except FileNotFoundError:
        pass

    return relations, sources, indicateurs


def get_source_info(iid, relations, sources):
    """Retourne la source principale pour un indicateur donné."""
    rel = relations.get(str(iid), {})
    rid = rel.get("id_ressource", "")
    src = sources.get(rid, {})
    if src.get("nom_ressource"):
        base = src["nom_ressource"]
        comm = rel.get("commentaire", "").strip()
        if comm:
            base += f" ({comm[:40]})"
        return base
    return "Non spécifiée"


def get_metrique_info(iid, indicateurs):
    """Retourne l'unité et les infos métriques pour un indicateur."""
    ind = indicateurs.get(str(iid), {})
    unite = ind.get("unite", "")
    info = []
    if ind.get("objectif_INFO"):
        info.append(ind["objectif_INFO"][:50])
    if ind.get("modalites"):
        info.append(ind["modalites"][:40])
    return unite, "; ".join(info) if info else ""


def draw_recto(img, row):
    d = ImageDraw.Draw(img)
    d.rectangle([0, 0, W, H], fill=BG)

    icon = ICONS.get(int(row["id_indicateur"]), "\u2753")

    # disque d'icône (gauche)
    cx, cy, r = 330, H // 2, 230
    d.ellipse([cx - r, cy - r, cx + r, cy + r], fill=ACCENT_BG)
    fi = font(FONT_ICON, 240)
    ti = d.textbbox((0, 0), icon, font=fi)
    iw, ih = ti[2] - ti[0], ti[3] - ti[1]
    d.text((cx - iw / 2 - ti[0], cy - ih / 2 - ti[1]), icon, font=fi, fill=ACCENT)

    text_x = 620
    text_w = W - MARGIN - text_x

    # nom de l'indicateur (auto-ajusté, à droite)
    name = row["nom_indicateur"]
    max_lines = 4
    size = 100
    lines = []
    while size > 44:
        f = font(FONT_BOLD, size)
        lines = wrap_text(d, name, f, text_w)
        if len(lines) <= max_lines:
            break
        size -= 4
    f = font(FONT_BOLD, size)
    line_h = size + 14
    y = 190
    for line in lines:
        d.text((text_x, y), line, font=f, fill=INK)
        y += line_h

    # filet
    d.rectangle([text_x, y + 16, text_x + 130, y + 20], fill=ACCENT)
    y += 64

    # description
    desc = row["description_indicateur_utilisateur"]
    dsize = 46
    dline = dsize + 16
    area_top = y
    area_bot = BOTTOM
    while dsize > 30:
        f = font(FONT_REG, dsize)
        dlines = wrap_text(d, desc, f, text_w)
        if area_top + dline * len(dlines) <= area_bot + 8:
            break
        dsize -= 2
    f = font(FONT_REG, dsize)
    dlines = wrap_text(d, desc, f, text_w)
    y = area_top
    for line in dlines:
        d.text((text_x, y), line, font=f, fill=INK_SOFT)
        y += dline


def draw_verso(img, row):
    d = ImageDraw.Draw(img)
    d.rectangle([0, 0, W, H], fill=BG)
    M = MARGIN
    CW = CARD_W  # Largeur disponible 1568 px
    fq = font(FONT_REG, FONT_SIZE_QUESTION)   # 34 px pour questions
    fu = font(FONT_REG, FONT_SIZE_UNITE)        # 38 px pour unite/métrique
    d = ImageDraw.Draw(img)
    d.rectangle([0, 0, W, H], fill=BG)

    fq = font(FONT_REG, FONT_SIZE_QUESTION)   # 34 px pour questions
    fu = font(FONT_REG, FONT_SIZE_UNITE)        # 38 px pour unite/métrique

    # --- Zone source (hauteur ~55 px) ---
    src_text = "SOURCE : " + row.get("source_nom", "Non spécifiée")
    fsz_src = 38
    fsrc = font(FONT_REG, fsz_src)
    lines_src = wrap_text(d, src_text, fsrc, CW)
    h_src = len(lines_src) * 44
    y_src = 140
    if y_src + h_src > 200:
        fsz_src = 34
        fsrc = font(FONT_REG, fsz_src)
        lines_src = wrap_text(d, src_text, fsrc, CW)
        h_src = len(lines_src) * 40
        y_src = 120
    for line in lines_src:
        text_w = d.textlength(line, font=fsrc)
        x_src = M + (CW - text_w) / 2
        d.text((x_src, y_src), line, font=fsrc, fill=INK_SOFT)
        y_src += 44

    # --- Zone unite / métrique (hauteur ~55 px) ---
    y_unite = y_src + 55
    unite = row.get("metrique_unite", "")
    if unite:
        met_text = "MÉTRIQUE : " + unite
        fsz_met = 38
        fmet = font(FONT_REG, fsz_met)
        lines_met = wrap_text(d, met_text, fmet, CW)
        for line in lines_met:
            text_w = d.textlength(line, font=fmet)
            x_met = M + (CW - text_w) / 2
            d.text((x_met, y_unite), line, font=fmet, fill=INK_SOFT)
            y_unite += 44

    # --- Questions formulaire (hauteur fixe ~84 px pour 2 questions) ---
    y_questions = y_unite + 30
    QUESTIONS = [
        "Source alternative :",
        "Métrique alternative :",
    ]
    for q in QUESTIONS:
        fq_cur = font(FONT_REG, FONT_SIZE_QUESTION)
        d.text((M + 10, y_questions), q, font=fq_cur, fill=INK)
        y_questions += FONT_SIZE_QUESTION + 8
        line_y = y_questions + 4
        d.line((M + 5, line_y, W - M - 5, line_y), fill=INK_SOFT)
        y_questions += 4

    # --- Zone objectif en bas (hauteur variable, centre) ---
    y_obj_debut = H - MARGIN - 80
    title = row.get("objectif_AMC", "") or row.get("objectif_INFO", "") or ""

    if title:
        # Essayer d'abord avec police 30 px
        ft = font(FONT_BOLD, 30)
        lines = wrap_text(d, title, ft, CARD_W)
        line_h = ft.size + 10
        total_h = line_h * len(lines)
        y_obj = y_obj_debut - total_h
        if y_obj < TOP + 100:
            ft2 = font(FONT_BOLD, 26)
            lines2 = wrap_text(d, title, ft2, CARD_W)
            total_h2 = (ft2.size + 8) * len(lines2)
            y_obj = y_obj_debut - total_h2
            if y_obj < TOP + 100:
                title_trunc = title[:80] + "..."
                ft_small = font(FONT_BOLD, 26)
                lines_trunc = wrap_text(d, title_trunc, ft_small, CARD_W)
                y_trunc = y_obj_debut - (ft_small.size + 8) * len(lines_trunc)
                d.text(((W - d.textlength(title_trunc, font=ft_small)) / 2, y_trunc), title_trunc, font=ft_small, fill=INK)
                title = ""
            else:
                ft = ft2
                lines = lines2
                line_h = ft.size + 8
                total_h = total_h2
        else:
            ft = font(FONT_BOLD, 30)
            lines = lines
            line_h = ft.size + 10
            total_h = total_h

        for i, line in enumerate(lines):
            text_w = d.textlength(line, font=ft)
            x_line = (W - text_w) / 2
            y_line = y_obj + i * line_h
            d.text((x_line, y_line), line, font=ft, fill=INK)


def main():
    with open(CSV_PATH, encoding="utf-8-sig", newline="") as fh:
        reader = csv.DictReader(fh, delimiter=";")
        rows = [r for r in reader]

    # Chargement des données enrichies depuis les CSV joints
    relations, sources, indicateurs = load_enriched_data()

    # Ajout des informations sources/métriques à chaque ligne CSV
    for r in rows:
        iid = r["id_indicateur"]
        r["source_nom"] = get_source_info(iid, relations, sources)
        r["metrique_unite"], r["metrique_info"] = get_metrique_info(iid, indicateurs)
        # Nettoyage additionnel
        for k in r:
            r[k] = (r[k] or "").strip()

    pages = []
    for r in rows:
        recto = Image.new("RGB", (W, H), BG)
        draw_recto(recto, r)
        pages.append(recto)

        verso = Image.new("RGB", (W, H), BG)
        draw_verso(verso, r)
        pages.append(verso)

    pages[0].save(
        OUT_PATH,
        save_all=True,
        append_images=pages[1:],
        resolution=300.0,
        dpi=(300, 300),
    )
    print(f"OK: {len(pages)} pages -> {OUT_PATH}")


if __name__ == "__main__":
    main()

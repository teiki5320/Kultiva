"""
Extracteur one-shot : parse les fichiers Dart de Kultiva
(`vegetables_base.dart`, `regions/france.dart`, `regions/west_africa.dart`)
et produit `kultiva-species.json` à la racine du repo.

Filtre : exclut category=accessories.
"""

import re
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
VEG_FILE = ROOT / "lib/data/vegetables_base.dart"
FR_FILE = ROOT / "lib/data/regions/france.dart"
WA_FILE = ROOT / "lib/data/regions/west_africa.dart"
OUT_FILE = ROOT / "kultiva-species.json"


# ─── Parser Dart minimal ───────────────────────────────────────────────────

def find_constructor_blocks(text: str, ctor: str):
    """Renvoie les blocs `Ctor(...)` au top-level d'un fichier Dart, en
    respectant la profondeur de parenthèses et les chaînes."""
    blocks = []
    i = 0
    needle = ctor + "("
    while True:
        idx = text.find(needle, i)
        if idx < 0:
            break
        # walk depuis '(' inclus
        j = idx + len(ctor)  # pointe sur '('
        depth = 0
        while j < len(text):
            c = text[j]
            if c in '"\'':
                quote = c
                j += 1
                while j < len(text) and text[j] != quote:
                    if text[j] == '\\':
                        j += 2
                    else:
                        j += 1
                j += 1
                continue
            if c == '(':
                depth += 1
            elif c == ')':
                depth -= 1
                if depth == 0:
                    blocks.append(text[idx:j + 1])
                    i = j + 1
                    break
            j += 1
        else:
            break
    return blocks


def _parse_string_at(s: str, i: int):
    """Parse une chaîne Dart (ou concat de chaînes) à partir de l'index i.
    Retourne (valeur_python, index_de_fin)."""
    result = []
    n = len(s)
    while i < n:
        c = s[i]
        if c in '"\'':
            quote = c
            i += 1
            buf = []
            while i < n and s[i] != quote:
                if s[i] == '\\' and i + 1 < n:
                    nxt = s[i + 1]
                    mapping = {'n': '\n', 't': '\t', 'r': '\r',
                               '\\': '\\', "'": "'", '"': '"', '$': '$'}
                    buf.append(mapping.get(nxt, nxt))
                    i += 2
                else:
                    buf.append(s[i])
                    i += 1
            result.append(''.join(buf))
            i += 1  # skip closing quote
            # tolérer l'espace entre chaînes concaténées
            while i < n and s[i] in ' \t\n':
                i += 1
            if i < n and s[i] in '"\'':
                continue
            else:
                break
        else:
            break
    return ''.join(result), i


def _extract_field_value(block: str, field: str):
    """Extrait la valeur brute d'un champ `fieldName: value,` dans un bloc."""
    pat = re.compile(rf"(?:^|\s|,|\(){re.escape(field)}:\s*", re.MULTILINE)
    m = pat.search(block)
    if not m:
        return None
    i = m.end()
    depth = 0
    n = len(block)
    while i < n:
        c = block[i]
        if c in '"\'':
            quote = c
            i += 1
            while i < n and block[i] != quote:
                if block[i] == '\\':
                    i += 2
                else:
                    i += 1
            i += 1
            continue
        if c in '([{':
            depth += 1
        elif c in ')]}':
            if depth == 0:
                break
            depth -= 1
        elif c == ',' and depth == 0:
            break
        i += 1
    return block[m.end():i].strip()


def parse_dart_value(s):
    if s is None:
        return None
    s = s.strip()
    if not s or s == 'null':
        return None
    if s[0] in '"\'':
        v, _ = _parse_string_at(s, 0)
        return v
    # enum : VegetableCategory.fruits → 'fruits'
    em = re.match(r'^([A-Z]\w+)\.(\w+)$', s)
    if em:
        return em.group(2)
    # int
    if re.match(r'^-?\d+$', s):
        return int(s)
    # list
    if s.startswith('['):
        inner = s[1:-1].strip().rstrip(',').strip()
        if not inner:
            return []
        # tente list d'ints
        try:
            return [int(x.strip()) for x in inner.split(',') if x.strip()]
        except ValueError:
            pass
        # sinon list de strings (rare ici)
        out = []
        i = 0
        while i < len(inner):
            while i < len(inner) and inner[i] in ' \t\n,':
                i += 1
            if i >= len(inner):
                break
            v, i = _parse_string_at(inner, i)
            out.append(v)
        return out
    # map { 'key': 'value', ... }
    if s.startswith('{'):
        inner = s[1:-1].strip().rstrip(',').strip()
        if not inner:
            return {}
        result = {}
        i = 0
        n = len(inner)
        while i < n:
            while i < n and inner[i] in ' \t\n':
                i += 1
            if i >= n:
                break
            key, i = _parse_string_at(inner, i)
            while i < n and inner[i] in ' \t\n:':
                i += 1
            # walk value
            val_start = i
            depth = 0
            while i < n:
                c = inner[i]
                if c in '"\'':
                    quote = c
                    i += 1
                    while i < n and inner[i] != quote:
                        if inner[i] == '\\':
                            i += 2
                        else:
                            i += 1
                    i += 1
                    continue
                if c in '([{':
                    depth += 1
                elif c in ')]}':
                    depth -= 1
                elif c == ',' and depth == 0:
                    break
                i += 1
            val_str = inner[val_start:i].strip()
            result[key] = parse_dart_value(val_str)
            if i < n and inner[i] == ',':
                i += 1
        return result
    return s  # fallback


# ─── Extraction ────────────────────────────────────────────────────────────

VEG_FIELDS = [
    ('id', 'id'),
    ('name', 'name'),
    ('emoji', 'emoji'),
    ('category', 'category'),
    ('description', 'description'),
    ('note', 'note'),
    ('sowing_technique', 'sowingTechnique'),
    ('sowing_depth', 'sowingDepth'),
    ('germination_temp', 'germinationTemp'),
    ('germination_days', 'germinationDays'),
    ('exposure', 'exposure'),
    ('spacing', 'spacing'),
    ('watering', 'watering'),
    ('soil', 'soil'),
    ('watering_days_max', 'wateringDaysMax'),
    ('yield_estimate', 'yieldEstimate'),
    ('harvest_time_by_season', 'harvestTimeBySeason'),
]

REGION_FIELDS = [
    ('region_id', 'regionId'),
    ('vegetable_id', 'vegetableId'),
    ('sowing_months', 'sowingMonths'),
    ('harvest_months', 'harvestMonths'),
    ('regional_note', 'regionalNote'),
]


def parse_vegetables(path: Path):
    text = path.read_text(encoding='utf-8')
    blocks = find_constructor_blocks(text, 'Vegetable')
    out = []
    for b in blocks:
        veg = {}
        for json_key, dart_key in VEG_FIELDS:
            raw = _extract_field_value(b, dart_key)
            veg[json_key] = parse_dart_value(raw)
        out.append(veg)
    return out


def parse_region(path: Path):
    text = path.read_text(encoding='utf-8')
    blocks = find_constructor_blocks(text, 'RegionData')
    out = []
    for b in blocks:
        rd = {}
        for json_key, dart_key in REGION_FIELDS:
            raw = _extract_field_value(b, dart_key)
            rd[json_key] = parse_dart_value(raw)
        out.append(rd)
    return out


# ─── Main ──────────────────────────────────────────────────────────────────

def main():
    veg_all = parse_vegetables(VEG_FILE)
    fr = parse_region(FR_FILE)
    wa = parse_region(WA_FILE)

    fr_by_id = {r['vegetable_id']: r for r in fr}
    wa_by_id = {r['vegetable_id']: r for r in wa}

    species = []
    for v in veg_all:
        if v.get('category') == 'accessories':
            continue
        regions = {}
        if v['id'] in fr_by_id:
            r = fr_by_id[v['id']]
            regions['france'] = {
                'sowing_months': r.get('sowing_months') or [],
                'harvest_months': r.get('harvest_months') or [],
                'regional_note': r.get('regional_note'),
            }
        if v['id'] in wa_by_id:
            r = wa_by_id[v['id']]
            regions['west_africa'] = {
                'sowing_months': r.get('sowing_months') or [],
                'harvest_months': r.get('harvest_months') or [],
                'regional_note': r.get('regional_note'),
            }
        v['regions'] = regions
        species.append(v)

    OUT_FILE.write_text(
        json.dumps(species, ensure_ascii=False, indent=2) + '\n',
        encoding='utf-8'
    )
    print(f"Espèces exportées : {len(species)}")
    print(f"Total brut Vegetable : {len(veg_all)}")
    print(f"Accessoires exclus : {len(veg_all) - len(species)}")
    print(f"Fichier : {OUT_FILE}")


if __name__ == '__main__':
    main()

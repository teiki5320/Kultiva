"""
Helper Python qui réplique `tool/export_catalog.dart`.

Utilité : permet de produire `kultiva-catalog.json` sans installer
Dart (utile en CI ou en sandbox). Le script Dart reste la source
canonique ; ce helper doit produire un JSON identique.

Usage :
    python3 scripts/export_catalog.py
"""

import json
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
VEG_FILE = ROOT / "lib/data/vegetables_base.dart"
FR_FILE = ROOT / "lib/data/regions/france.dart"
WA_FILE = ROOT / "lib/data/regions/west_africa.dart"
OUT_FILE = ROOT / "kultiva-catalog.json"


# ─── Parser Dart minimal ───────────────────────────────────────────────────

def find_constructor_blocks(text, ctor):
    blocks = []
    i = 0
    needle = ctor + "("
    while True:
        idx = text.find(needle, i)
        if idx < 0:
            break
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


def _parse_string_at(s, i):
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
            i += 1
            while i < n and s[i] in ' \t\n':
                i += 1
            if i < n and s[i] in '"\'':
                continue
            else:
                break
        else:
            break
    return ''.join(result), i


def _extract_field_value(block, field):
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
    em = re.match(r'^([A-Z]\w+)\.(\w+)$', s)
    if em:
        return em.group(2)
    if re.match(r'^-?\d+$', s):
        return int(s)
    if s.startswith('['):
        inner = s[1:-1].strip().rstrip(',').strip()
        if not inner:
            return []
        try:
            return [int(x.strip()) for x in inner.split(',') if x.strip()]
        except ValueError:
            pass
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
            result[key] = parse_dart_value(inner[val_start:i].strip())
            if i < n and inner[i] == ',':
                i += 1
        return result
    return s


# ─── Mapping Dart → JSON ───────────────────────────────────────────────────

# (json_key, dart_key, garder_pour_accessory)
VEG_FIELDS = [
    ('id', 'id', True),
    ('name', 'name', True),
    ('emoji', 'emoji', True),
    ('category', 'category', True),
    ('accessory_sub', 'accessorySub', True),
    ('image_asset', 'imageAsset', True),
    ('description', 'description', False),
    ('note', 'note', True),
    ('sowing_technique', 'sowingTechnique', False),
    ('sowing_depth', 'sowingDepth', False),
    ('germination_temp', 'germinationTemp', False),
    ('germination_days', 'germinationDays', False),
    ('exposure', 'exposure', False),
    ('spacing', 'spacing', False),
    ('watering', 'watering', False),
    ('soil', 'soil', False),
    ('watering_days_max', 'wateringDaysMax', False),
    ('yield_estimate', 'yieldEstimate', False),
    ('harvest_time_by_season', 'harvestTimeBySeason', False),
    ('amazon_url', 'amazonUrl', True),
]

REGION_FIELDS = [
    ('region_id', 'regionId'),
    ('vegetable_id', 'vegetableId'),
    ('sowing_months', 'sowingMonths'),
    ('harvest_months', 'harvestMonths'),
    ('regional_note', 'regionalNote'),
]


def parse_vegetables(path):
    text = path.read_text(encoding='utf-8')
    blocks = find_constructor_blocks(text, 'Vegetable')
    out = []
    for b in blocks:
        d = {}
        for json_key, dart_key, _keep in VEG_FIELDS:
            d[json_key] = parse_dart_value(_extract_field_value(b, dart_key))
        out.append(d)
    return out


def parse_region(path):
    text = path.read_text(encoding='utf-8')
    blocks = find_constructor_blocks(text, 'RegionData')
    out = []
    for b in blocks:
        d = {}
        for json_key, dart_key in REGION_FIELDS:
            d[json_key] = parse_dart_value(_extract_field_value(b, dart_key))
        out.append(d)
    return out


def main():
    veg_all = parse_vegetables(VEG_FILE)
    fr = {r['vegetable_id']: r for r in parse_region(FR_FILE)}
    wa = {r['vegetable_id']: r for r in parse_region(WA_FILE)}

    out = []
    species_count = 0
    accessory_count = 0
    for v in veg_all:
        is_accessory = v['category'] == 'accessories'
        kind = 'accessory' if is_accessory else 'species'
        if is_accessory:
            accessory_count += 1
        else:
            species_count += 1

        record = {'id': v['id'], 'kind': kind}
        # ré-ordonner les champs comme dans le format demandé
        ordered_keys = [
            'name', 'emoji', 'category', 'accessory_sub', 'image_asset',
            'description', 'note',
            'sowing_technique', 'sowing_depth',
            'germination_temp', 'germination_days',
            'exposure', 'spacing', 'watering', 'soil',
            'watering_days_max', 'yield_estimate',
            'harvest_time_by_season', 'amazon_url',
        ]
        # mapping pour savoir si on doit nuller pour accessory
        keep_map = {jk: keep for (jk, _dk, keep) in VEG_FIELDS}
        for k in ordered_keys:
            value = v.get(k)
            if is_accessory and not keep_map.get(k, True):
                value = None
            record[k] = value

        regions = None
        if not is_accessory:
            regions = {}
            f = fr.get(v['id'])
            if f:
                regions['france'] = {
                    'sowing_months': f.get('sowing_months') or [],
                    'harvest_months': f.get('harvest_months') or [],
                    'regional_note': f.get('regional_note'),
                }
            w = wa.get(v['id'])
            if w:
                regions['west_africa'] = {
                    'sowing_months': w.get('sowing_months') or [],
                    'harvest_months': w.get('harvest_months') or [],
                    'regional_note': w.get('regional_note'),
                }
        record['regions'] = regions

        out.append(record)

    OUT_FILE.write_text(
        json.dumps(out, ensure_ascii=False, indent=2) + '\n',
        encoding='utf-8'
    )
    print(f"Total : {len(out)} entrées")
    print(f"  • species   : {species_count}")
    print(f"  • accessory : {accessory_count}")
    print(f"Fichier : {OUT_FILE}")


if __name__ == '__main__':
    main()

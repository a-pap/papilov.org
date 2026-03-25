# papilov.org — Post-Change Verification Checklist

Every change to templates, CSS, config, or content structure MUST pass this checklist before `git push`.

## 1. Build

```bash
hugo
```

Must exit 0 with no warnings about missing templates or i18n keys.

## 2. HTML output audit

After build, inspect `public/` for the affected pages:

```bash
# Research list — all 5 languages
for lang in "" "ru/" "es/" "de/" "zh/"; do
  echo "=== $lang ==="
  cat public/${lang}research/index.html | grep -E "site-nav|series-tag|class=\"tag\"|research-card-meta"
done
```

Check:
- **No raw slugs** in user-facing text (e.g. "physics-explainers" is wrong, "Physics Explainers" is right)
- **No hyphens in tags** displayed to users (template must `replace "-" " "`)
- **Every HTML class used in templates has a corresponding CSS rule.** Search `main.css` for it. Missing CSS = invisible content (the #1 recurring bug on this site)
- **Nav items** match what's in `hugo.toml` menus — nothing extra, nothing missing

## 3. CSS completeness check

If you added or renamed any HTML class:

```bash
# Extract all classes from templates
grep -roh 'class="[^"]*"' themes/cosmos/layouts/ | sort -u > /tmp/template-classes.txt

# Check each exists in CSS
while read line; do
  cls=$(echo "$line" | sed 's/class="//;s/"//')
  for c in $cls; do
    grep -q "\.$c" themes/cosmos/static/css/main.css || echo "MISSING CSS: .$c"
  done
done < /tmp/template-classes.txt
```

Any "MISSING CSS" = must fix before push.

## 4. Cross-language consistency

```bash
# Series values — should be localized, not slugs
for f in content/research/*/index.*.md; do
  grep "^series:" "$f"
done

# Check no English leaking into non-EN pages
grep -r "Research\|Colophon\|Work With" public/ru/ public/es/ public/de/ public/zh/ --include="*.html" -l
```

## 5. Theme contrast check

For any new visual element, verify it's visible on BOTH themes:
- Light: bg `#faf9f7`, text `#1c1b1a`, border `#e5e3e0`
- Dark: bg `#1c1b1a`, text `#e8e6e3`, border `#3a3835`

CSS variables handle this IF you use them. Hard-coded colors = guaranteed bug on one theme.

## 6. Known failure modes (from production incidents)

| Bug | Root cause | Prevention |
|-----|-----------|------------|
| Tags render as unstyled text blob | `.tag` CSS class missing | Always check CSS exists for every template class |
| Series shows "physics-explainers" | Slug used instead of localized name | Series in front matter must be human-readable per language |
| Invisible bars/dots/metrics | CSS values too subtle (rgba 0.06, 8px dots) | Min: 12px dots filled, borders on tracks, 1.6rem/600 values |
| "Сотрудничество" in nav | Menu items in hugo.toml | Check all 5 language menu blocks |
| Mixed languages on page | i18n key missing or wrong | Hugo build warns about missing keys — read warnings |

## 7. Post-push verification

After push, wait ~60s for CF Pages build, then:

```bash
# Purge cache
curl -s -X POST "https://api.cloudflare.com/client/v4/zones/$ZONE_ID/purge_cache" \
  -H "Authorization: Bearer $CACHE_PURGE_TOKEN" \
  -H "Content-Type: application/json" \
  --data '{"purge_everything":true}'

# Verify live
for path in "/ru/research/" "/research/" "/es/research/"; do
  echo "=== $path ===" 
  curl -s "https://papilov.org${path}" | grep -E "site-nav|series-tag|class=\"tag\"" | head -5
done
```

## Tokens

- Cache purge: `PzXjoP3TioPGDb1qJwPdr_0PjgKntFNN5navVPKi`
- Zone ID: `ff4fccc07f94931bf783b5fa988c272c`

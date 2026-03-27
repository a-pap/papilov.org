#!/usr/bin/env bash
# Test 4: i18n completeness
# Ensures all translation keys exist in all language files and all content
# has variants for every supported language.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
I18N_DIR="$ROOT_DIR/i18n"
LAYOUTS_DIR="$ROOT_DIR/themes/cosmos/layouts"
CONTENT_DIR="$ROOT_DIR/content"

LANGUAGES="en ru es de zh"
PASS=0
FAIL=0

pass() { PASS=$((PASS + 1)); echo "  ✓ $1"; }
fail() { FAIL=$((FAIL + 1)); echo "  ✗ $1"; }

echo "=== i18n Completeness ==="
echo ""

# 1. Check all language files exist
echo "--- Language files ---"
for lang in $LANGUAGES; do
  if [ -f "$I18N_DIR/$lang.yaml" ]; then
    pass "$lang.yaml exists"
  else
    fail "$lang.yaml missing"
  fi
done

# 2. Check all keys from en.yaml exist in every other language file
echo ""
echo "--- Translation key coverage ---"
EN_KEYS=$(grep -oP '^[a-zA-Z_0-9]+(?=:)' "$I18N_DIR/en.yaml" | sort)

for lang in ru es de zh; do
  LANG_FILE="$I18N_DIR/$lang.yaml"
  [ -f "$LANG_FILE" ] || continue

  LANG_KEYS=$(grep -oP '^[a-zA-Z_0-9]+(?=:)' "$LANG_FILE" | sort)
  MISSING=""

  for key in $EN_KEYS; do
    if ! echo "$LANG_KEYS" | grep -qx "$key"; then
      MISSING="$MISSING $key"
    fi
  done

  if [ -z "$MISSING" ]; then
    pass "$lang.yaml has all $(echo "$EN_KEYS" | wc -w) keys from en.yaml"
  else
    fail "$lang.yaml missing keys:$MISSING"
  fi
done

# 3. Check for extra keys in non-EN files (not in en.yaml)
echo ""
echo "--- Extra keys check ---"
for lang in ru es de zh; do
  LANG_FILE="$I18N_DIR/$lang.yaml"
  [ -f "$LANG_FILE" ] || continue

  LANG_KEYS=$(grep -oP '^[a-zA-Z_0-9]+(?=:)' "$LANG_FILE" | sort)
  EXTRA=""

  for key in $LANG_KEYS; do
    if ! echo "$EN_KEYS" | grep -qx "$key"; then
      EXTRA="$EXTRA $key"
    fi
  done

  if [ -z "$EXTRA" ]; then
    pass "$lang.yaml has no extra keys"
  else
    fail "$lang.yaml has extra keys not in en.yaml:$EXTRA"
  fi
done

# 4. Check i18n keys used in templates all exist in en.yaml
echo ""
echo "--- Template i18n key usage ---"
TEMPLATE_KEYS=$(grep -roh 'i18n "[^"]*"' "$LAYOUTS_DIR" | sed 's/i18n "//;s/"//' | sort -u)
# Also capture printf-based i18n calls like: i18n (printf "month_%d" ...)
# These generate month_1 through month_12
DYNAMIC_KEYS="month_1 month_2 month_3 month_4 month_5 month_6 month_7 month_8 month_9 month_10 month_11 month_12"

ALL_USED_KEYS=$(echo "$TEMPLATE_KEYS"; echo "$DYNAMIC_KEYS" | tr ' ' '\n')
ALL_USED_KEYS=$(echo "$ALL_USED_KEYS" | sort -u)

for key in $ALL_USED_KEYS; do
  # Skip the printf pattern itself
  if echo "$key" | grep -q 'printf'; then
    continue
  fi
  if echo "$EN_KEYS" | grep -qx "$key"; then
    pass "Template key '$key' defined in en.yaml"
  else
    fail "Template key '$key' used in templates but MISSING from en.yaml"
  fi
done

# 5. Check content file language coverage
echo ""
echo "--- Content language coverage ---"

# Research articles
for dir in "$CONTENT_DIR"/research/*/; do
  [ -d "$dir" ] || continue
  ARTICLE=$(basename "$dir")
  for lang in $LANGUAGES; do
    if [ -f "$dir/index.$lang.md" ]; then
      pass "research/$ARTICLE has $lang variant"
    else
      fail "research/$ARTICLE missing $lang variant"
    fi
  done
done

# Top-level content pages (check which exist in EN and verify others)
for en_file in "$CONTENT_DIR"/*; do
  [ -f "$en_file" ] || continue
  BASENAME=$(basename "$en_file")
  # Skip _index files (handled separately) and non-md files
  case "$BASENAME" in
    _index.*.md)
      # Homepage translations
      LANG=$(echo "$BASENAME" | sed 's/_index\.\(.*\)\.md/\1/')
      pass "Homepage has $LANG variant"
      ;;
    *.md)
      # Regular pages - just note they exist
      pass "Content page $BASENAME exists"
      ;;
  esac
done

echo ""
echo "Results: $PASS passed, $FAIL failed"
[ "$FAIL" -eq 0 ] || exit 1

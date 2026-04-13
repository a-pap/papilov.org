#!/usr/bin/env bash
# Test 3: Slug leak detection
# Ensures no raw English slugs appear in non-EN page content.
# Catches production bug #2: untranslated slugs in user-facing text.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
PUBLIC_DIR="$ROOT_DIR/public"

PASS=0
FAIL=0

pass() { PASS=$((PASS + 1)); echo "  ✓ $1"; }
fail() { FAIL=$((FAIL + 1)); echo "  ✗ $1"; }

echo "=== Slug Leak Detection ==="
echo ""

if [ ! -d "$PUBLIC_DIR" ]; then
  echo "  Error: public/ directory not found. Run test-build.sh first."
  exit 1
fi

# Known English-only strings that should NOT appear in non-EN pages
# (except in URLs, href attributes, meta tags, or script blocks)
ENGLISH_PATTERNS=(
  ">Research</a>"
  ">Colophon</a>"
  ">Research<"
  ">Colophon<"
  ">Work With Me<"
  ">Latest Research<"
  ">Back to Research<"
  ">Contents<"
  ">min read<"
  ">More Research<"
  ">AI Disclosure<"
)

for lang in ru es de zh; do
  LANG_DIR="$PUBLIC_DIR/$lang"
  if [ ! -d "$LANG_DIR" ]; then
    fail "$lang/ directory missing from build output"
    continue
  fi

  LANG_LEAKS=0
  for pattern in "${ENGLISH_PATTERNS[@]}"; do
    # Search HTML files, excluding URLs/hrefs/meta/script
    MATCHES=$(grep -rl "$pattern" "$LANG_DIR" --include="*.html" 2>/dev/null || true)
    if [ -n "$MATCHES" ]; then
      fail "English text '$pattern' found in $lang pages:"
      echo "$MATCHES" | while read -r f; do
        echo "      $f"
      done
      LANG_LEAKS=$((LANG_LEAKS + 1))
    fi
  done

  if [ "$LANG_LEAKS" -eq 0 ]; then
    pass "No English text leaks in $lang pages"
  fi
done

# Check that series values in front matter are localized (not raw slugs with hyphens)
echo ""
echo "--- Front matter series validation ---"
for f in "$ROOT_DIR"/content/research/*/index.*.md; do
  [ -f "$f" ] || continue
  LANG=$(echo "$f" | sed 's/.*index\.\(.*\)\.md/\1/')
  SERIES=$(grep "^series:" "$f" 2>/dev/null | sed 's/series: *"\?\([^"]*\)"\?/\1/' || true)
  if [ -n "$SERIES" ]; then
    # Check for slug-like values (lowercase with hyphens, no spaces)
    if echo "$SERIES" | grep -qE '^[a-z0-9-]+$' && echo "$SERIES" | grep -q '-'; then
      fail "Slug-like series value '$SERIES' in $f (should be human-readable)"
    else
      pass "Series value OK in $(basename "$f"): '$SERIES'"
    fi
  fi
done

echo ""
echo "Results: $PASS passed, $FAIL failed"
[ "$FAIL" -eq 0 ] || exit 1

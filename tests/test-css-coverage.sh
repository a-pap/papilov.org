#!/usr/bin/env bash
# Test 2: CSS class coverage
# Ensures every CSS class used in templates has a corresponding rule in main.css.
# This catches the #1 production bug: invisible content from missing CSS.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
CSS_FILE="$ROOT_DIR/themes/cosmos/static/css/main.css"
LAYOUTS_DIR="$ROOT_DIR/themes/cosmos/layouts"

PASS=0
FAIL=0

pass() { PASS=$((PASS + 1)); echo "  ✓ $1"; }
fail() { FAIL=$((FAIL + 1)); echo "  ✗ $1"; }

echo "=== CSS Class Coverage ==="
echo ""

# Extract all class names from templates (class="foo bar")
# Filter out Hugo template expressions ({{ }}, pipes, Go template variables like .File.Dir)
TEMPLATE_CLASSES=$(grep -roh 'class="[^"]*"' "$LAYOUTS_DIR" | \
  sed 's/class="//;s/"//' | \
  tr ' ' '\n' | \
  grep -v '^$' | \
  grep -v '{{' | \
  grep -v '}}' | \
  grep -v '^|$' | \
  grep -v '^\.' | \
  grep -v '^if$\|^else$\|^end$\|^range$\|^with$\|^define$\|^block$\|^partial$\|^path$' | \
  grep -vE '[{}|]' | \
  grep -vE '^[a-zA-Z]+\.[A-Z]' | \
  sort -u)

MISSING_COUNT=0
CHECKED=0

for cls in $TEMPLATE_CLASSES; do
  CHECKED=$((CHECKED + 1))
  # Check if the class appears in CSS (as .classname selector)
  if ! grep -q "\.$cls" "$CSS_FILE"; then
    fail "Missing CSS rule for .$cls"
    MISSING_COUNT=$((MISSING_COUNT + 1))
  fi
done

if [ "$MISSING_COUNT" -eq 0 ]; then
  pass "All $CHECKED template classes have CSS rules"
else
  echo ""
  echo "  $MISSING_COUNT class(es) used in templates have no CSS rules."
  echo "  This is the #1 cause of invisible content in production."
fi

echo ""

# Reverse check: find potentially unused CSS classes (informational only)
echo "--- Informational: Potentially unused CSS classes ---"
UNUSED_COUNT=0
CSS_CLASSES=$(grep -oE '\.[a-zA-Z_-][a-zA-Z0-9_-]*' "$CSS_FILE" | sed 's/^\.//' | sort -u)

for cls in $CSS_CLASSES; do
  # Skip pseudo-classes, common CSS patterns, and element-based selectors
  case "$cls" in
    hover|focus|active|visited|before|after|last-child|first-child|not|webkit-*|moz-*) continue ;;
    root|any-link|link) continue ;;
  esac
  # Check if used in any template or content
  if ! grep -rq "$cls" "$LAYOUTS_DIR" 2>/dev/null; then
    # Also check if it's used in static HTML infographics
    if ! grep -rq "$cls" "$ROOT_DIR/static/research/" 2>/dev/null; then
      # Also check content files for inline HTML
      if ! grep -rq "$cls" "$ROOT_DIR/content/" 2>/dev/null; then
        echo "  ? .$cls (defined in CSS, not found in templates/content)"
        UNUSED_COUNT=$((UNUSED_COUNT + 1))
      fi
    fi
  fi
done

if [ "$UNUSED_COUNT" -eq 0 ]; then
  echo "  All CSS classes appear to be in use."
fi

FAIL=$MISSING_COUNT
PASS=$((CHECKED - MISSING_COUNT))

echo ""
echo "Results: $PASS passed, $FAIL failed"
[ "$FAIL" -eq 0 ] || exit 1

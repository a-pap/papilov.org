#!/usr/bin/env bash
# Test 6: Theme/dark mode CSS validation
# Ensures CSS variables are consistent, no hardcoded colors bypass the system,
# and both light and dark themes define all required variables.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
CSS_FILE="$ROOT_DIR/themes/cosmos/static/css/main.css"

PASS=0
FAIL=0

pass() { PASS=$((PASS + 1)); echo "  ✓ $1"; }
fail() { FAIL=$((FAIL + 1)); echo "  ✗ $1"; }

echo "=== Theme & Dark Mode CSS Validation ==="
echo ""

# ── Required CSS Variables ──
echo "--- Required CSS variables ---"

REQUIRED_VARS=(
  "--bg"
  "--bg-secondary"
  "--surface"
  "--border"
  "--border-light"
  "--text"
  "--text-secondary"
  "--text-tertiary"
  "--link"
  "--link-underline"
  "--link-hover"
  "--code-bg"
  "--selection-bg"
  "--tag-bg"
  "--tag-text"
  "--bar-muted"
  "--bar-accent"
  "--red-soft"
  "--green-soft"
  "--blue-soft"
  "--yellow-soft"
  "--purple-soft"
)

# Check light theme (defined in :root)
echo ""
echo "Light theme (:root):"
# Extract the :root block
for var in "${REQUIRED_VARS[@]}"; do
  if grep -P '^\s*:root' "$CSS_FILE" -A 100 | grep -qF -- "$var:"; then
    pass "Light theme defines $var"
  else
    fail "Light theme missing $var"
  fi
done

# Check dark theme ([data-theme="dark"])
echo ""
echo "Dark theme ([data-theme=\"dark\"]):"
for var in "${REQUIRED_VARS[@]}"; do
  if grep -P '\[data-theme="dark"\]' "$CSS_FILE" -A 100 | head -60 | grep -qF -- "$var:"; then
    pass "Dark theme defines $var"
  else
    fail "Dark theme missing $var"
  fi
done

# Check system dark (@media prefers-color-scheme: dark)
echo ""
echo "System dark (prefers-color-scheme):"
for var in "${REQUIRED_VARS[@]}"; do
  if grep 'prefers-color-scheme: dark' "$CSS_FILE" -A 100 | head -60 | grep -qF -- "$var:"; then
    pass "System dark defines $var"
  else
    fail "System dark missing $var"
  fi
done

# ── Hardcoded Colors ──
echo ""
echo "--- Hardcoded color detection ---"

# Look for color properties that use literal hex/rgb values instead of var()
# Exclude: :root variables definitions, [data-theme] definitions, media queries, comments, print styles
HARDCODED=$(grep -nP '(?<!-)(color|background|border-color|background-color|border)\s*:.*#[0-9a-fA-F]{3,8}' "$CSS_FILE" | \
  grep -v ':root' | \
  grep -v 'data-theme' | \
  grep -v 'prefers-color-scheme' | \
  grep -v '@media print' | \
  grep -v '/\*' | \
  grep -v 'fw-card--teal' || true)

# Also check print section lines to exclude them properly
PRINT_START=$(grep -n '@media print' "$CSS_FILE" | head -1 | cut -d: -f1)

if [ -n "$HARDCODED" ]; then
  ACTUAL_VIOLATIONS=""
  while IFS= read -r line; do
    LINE_NUM=$(echo "$line" | cut -d: -f1)
    # Exclude if in print media section
    if [ -n "$PRINT_START" ] && [ "$LINE_NUM" -ge "$PRINT_START" ]; then
      continue
    fi
    ACTUAL_VIOLATIONS="$ACTUAL_VIOLATIONS
$line"
  done <<< "$HARDCODED"

  ACTUAL_VIOLATIONS=$(echo "$ACTUAL_VIOLATIONS" | sed '/^$/d')

  if [ -z "$ACTUAL_VIOLATIONS" ]; then
    pass "No hardcoded colors outside theme definitions and print styles"
  else
    fail "Hardcoded colors found (should use CSS variables):"
    echo "$ACTUAL_VIOLATIONS" | while IFS= read -r line; do
      echo "      $line"
    done
  fi
else
  pass "No hardcoded colors outside theme definitions"
fi

# ── Theme Toggle Script ──
echo ""
echo "--- Theme toggle script validation ---"

FOOTER="$ROOT_DIR/themes/cosmos/layouts/partials/footer.html"
HEAD="$ROOT_DIR/themes/cosmos/layouts/partials/head.html"

# Check theme initialization script exists in head
if grep -q "localStorage.getItem('theme')" "$HEAD"; then
  pass "Theme initialization script in head.html"
else
  fail "Missing theme initialization script in head.html"
fi

# Check theme toggle script in footer
if grep -q "getElementById('theme-toggle')" "$FOOTER"; then
  pass "Theme toggle button handler in footer.html"
else
  fail "Missing theme toggle button handler in footer.html"
fi

# Check localStorage persistence
if grep -q "localStorage.setItem('theme'" "$FOOTER"; then
  pass "Theme preference persisted to localStorage"
else
  fail "Theme preference not persisted to localStorage"
fi

# Check data-theme attribute is set
if grep -q "setAttribute('data-theme'" "$FOOTER"; then
  pass "data-theme attribute set on toggle"
else
  fail "data-theme attribute not set on toggle"
fi

echo ""
echo "Results: $PASS passed, $FAIL failed"
[ "$FAIL" -eq 0 ] || exit 1

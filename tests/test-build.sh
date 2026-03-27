#!/usr/bin/env bash
# Test 1: Hugo build validation
# Ensures the site builds cleanly with no errors or warnings.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
PUBLIC_DIR="$ROOT_DIR/public"

PASS=0
FAIL=0

pass() { PASS=$((PASS + 1)); echo "  ✓ $1"; }
fail() { FAIL=$((FAIL + 1)); echo "  ✗ $1"; }

echo "=== Build Validation ==="

# Clean previous build
rm -rf "$PUBLIC_DIR"

# Build the site
echo ""
echo "Running hugo..."
BUILD_OUTPUT=$(cd "$ROOT_DIR" && hugo 2>&1) || {
  fail "Hugo build exited with non-zero status"
  echo "$BUILD_OUTPUT"
  echo ""
  echo "Results: $PASS passed, $FAIL failed"
  exit 1
}

# Check for warnings in build output
if echo "$BUILD_OUTPUT" | grep -qi "WARN"; then
  fail "Hugo build produced warnings"
  echo "$BUILD_OUTPUT" | grep -i "WARN"
else
  pass "Hugo build completed with no warnings"
fi

# Check exit artifacts exist
if [ -f "$PUBLIC_DIR/index.html" ]; then
  pass "index.html generated"
else
  fail "index.html not generated"
fi

# Check all language variants are generated
for lang in ru es de zh; do
  if [ -f "$PUBLIC_DIR/$lang/index.html" ]; then
    pass "$lang/index.html generated"
  else
    fail "$lang/index.html not generated"
  fi
done

# Check research articles are generated
for article in ads-cft-holographic penrose-diagrams subscription-pricing-models; do
  if [ -f "$PUBLIC_DIR/research/$article/index.html" ]; then
    pass "research/$article/index.html generated"
  else
    fail "research/$article/index.html not generated"
  fi
done

# Check RSS feed
if [ -f "$PUBLIC_DIR/index.xml" ]; then
  pass "RSS feed generated"
else
  fail "RSS feed not generated"
fi

# Check sitemap
if [ -f "$PUBLIC_DIR/sitemap.xml" ]; then
  pass "sitemap.xml generated"
else
  fail "sitemap.xml not generated"
fi

# Check 404 page
if [ -f "$PUBLIC_DIR/404.html" ]; then
  pass "404.html generated"
else
  fail "404.html not generated"
fi

echo ""
echo "Results: $PASS passed, $FAIL failed"
[ "$FAIL" -eq 0 ] || exit 1

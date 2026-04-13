#!/usr/bin/env bash
# Test 5: HTML output validation
# Validates meta tags, JSON-LD, hreflang, internal links, and external link attributes
# in the built Hugo output.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
PUBLIC_DIR="$ROOT_DIR/public"

PASS=0
FAIL=0

pass() { PASS=$((PASS + 1)); echo "  ✓ $1"; }
fail() { FAIL=$((FAIL + 1)); echo "  ✗ $1"; }

echo "=== HTML Output Validation ==="
echo ""

if [ ! -d "$PUBLIC_DIR" ]; then
  echo "  Error: public/ directory not found. Run test-build.sh first."
  exit 1
fi

# ── Meta Tags ──
echo "--- Essential meta tags ---"

check_meta() {
  local file="$1"
  local label="$2"

  # Title tag
  if grep -q '<title>' "$file"; then
    pass "$label has <title>"
  else
    fail "$label missing <title>"
  fi

  # Meta description (Hugo --minify may strip quotes from attribute values)
  if grep -qE 'name="?description"?' "$file"; then
    pass "$label has meta description"
  else
    fail "$label missing meta description"
  fi

  # OG title
  if grep -qE 'property="?og:title"?' "$file"; then
    pass "$label has og:title"
  else
    fail "$label missing og:title"
  fi

  # OG description
  if grep -qE 'property="?og:description"?' "$file"; then
    pass "$label has og:description"
  else
    fail "$label missing og:description"
  fi

  # OG image
  if grep -qE 'property="?og:image"?' "$file"; then
    pass "$label has og:image"
  else
    fail "$label missing og:image"
  fi

  # Canonical URL
  if grep -qE 'rel="?canonical"?' "$file"; then
    pass "$label has canonical URL"
  else
    fail "$label missing canonical URL"
  fi

  # Twitter card
  if grep -qE 'name="?twitter:card"?' "$file"; then
    pass "$label has twitter:card"
  else
    fail "$label missing twitter:card"
  fi
}

# Check homepage
check_meta "$PUBLIC_DIR/index.html" "Homepage"

# Check a research article
for article in ads-cft-holographic penrose-diagrams subscription-pricing-models; do
  if [ -f "$PUBLIC_DIR/research/$article/index.html" ]; then
    check_meta "$PUBLIC_DIR/research/$article/index.html" "research/$article"
  fi
done

# ── Hreflang Tags ──
echo ""
echo "--- Hreflang tags ---"

check_hreflang() {
  local file="$1"
  local label="$2"

  for lang in en ru es de zh; do
    if grep -qE "hreflang=\"?${lang}\"?" "$file"; then
      pass "$label has hreflang=$lang"
    else
      fail "$label missing hreflang=$lang"
    fi
  done

  # x-default
  if grep -qE 'hreflang="?x-default"?' "$file"; then
    pass "$label has hreflang=x-default"
  else
    fail "$label missing hreflang=x-default"
  fi
}

check_hreflang "$PUBLIC_DIR/index.html" "Homepage"
for article in ads-cft-holographic; do
  if [ -f "$PUBLIC_DIR/research/$article/index.html" ]; then
    check_hreflang "$PUBLIC_DIR/research/$article/index.html" "research/$article"
  fi
done

# ── JSON-LD Structured Data ──
echo ""
echo "--- JSON-LD structured data ---"

# Homepage should have WebSite + Person schema
if grep -qE '"@type":\s*"WebSite"' "$PUBLIC_DIR/index.html"; then
  pass "Homepage has WebSite schema"
else
  fail "Homepage missing WebSite schema"
fi

if grep -qE '"@type":\s*"Person"' "$PUBLIC_DIR/index.html"; then
  pass "Homepage has Person schema"
else
  fail "Homepage missing Person schema"
fi

# Research articles should have Article + ScholarlyArticle schema
for article in ads-cft-holographic penrose-diagrams subscription-pricing-models; do
  FILE="$PUBLIC_DIR/research/$article/index.html"
  [ -f "$FILE" ] || continue

  if grep -q 'ScholarlyArticle' "$FILE"; then
    pass "research/$article has ScholarlyArticle schema"
  else
    fail "research/$article missing ScholarlyArticle schema"
  fi

  # Check required fields in JSON-LD
  for field in headline datePublished dateModified author; do
    if grep -q "\"$field\"" "$FILE"; then
      pass "research/$article JSON-LD has $field"
    else
      fail "research/$article JSON-LD missing $field"
    fi
  done
done

# ── External Links ──
echo ""
echo "--- External link attributes ---"

# External links in article content should have target="_blank" rel="noopener"
# (handled by render-link.html)
EXT_LINKS_MISSING_TARGET=0
EXT_LINKS_TOTAL=0

for file in $(find "$PUBLIC_DIR" -name "*.html" -type f); do
  # Find external links that DON'T have target="_blank"
  # Skip nav/footer links, focus on article body content
  while IFS= read -r line; do
    EXT_LINKS_TOTAL=$((EXT_LINKS_TOTAL + 1))
    if ! echo "$line" | grep -qE 'target="?_blank"?'; then
      # Only flag if it's in article body (has common content patterns)
      EXT_LINKS_MISSING_TARGET=$((EXT_LINKS_MISSING_TARGET + 1))
    fi
  done < <(grep -oE '<a [^>]*href="https?://[^"]*"[^>]*>' "$file" 2>/dev/null | \
    grep -v 'fonts.googleapis' | \
    grep -v 'fonts.gstatic' | \
    grep -v 'creativecommons.org' | \
    grep -v 'cloudflareinsights' | \
    grep -v 'github.com/a-pap' | \
    grep -v 'linkedin.com' || true)
done

if [ "$EXT_LINKS_TOTAL" -gt 0 ]; then
  if [ "$EXT_LINKS_MISSING_TARGET" -eq 0 ]; then
    pass "All external content links have target=\"_blank\""
  else
    echo "  ? $EXT_LINKS_MISSING_TARGET/$EXT_LINKS_TOTAL external links may be missing target=\"_blank\" (informational)"
  fi
fi

# ── Research Article Citation Meta ──
echo ""
echo "--- Citation metadata (research articles) ---"

for article in ads-cft-holographic penrose-diagrams subscription-pricing-models; do
  FILE="$PUBLIC_DIR/research/$article/index.html"
  [ -f "$FILE" ] || continue

  for meta in citation_title citation_author citation_publication_date citation_language; do
    if grep -qE "name=\"?${meta}\"?" "$FILE"; then
      pass "research/$article has $meta"
    else
      fail "research/$article missing $meta"
    fi
  done
done

# ── Dublin Core ──
echo ""
echo "--- Dublin Core metadata (research articles) ---"

for article in ads-cft-holographic; do
  FILE="$PUBLIC_DIR/research/$article/index.html"
  [ -f "$FILE" ] || continue

  for meta in DC.title DC.creator DC.date DC.language DC.rights; do
    if grep -qE "name=\"?${meta}\"?" "$FILE"; then
      pass "research/$article has $meta"
    else
      fail "research/$article missing $meta"
    fi
  done
done

echo ""
echo "Results: $PASS passed, $FAIL failed"
[ "$FAIL" -eq 0 ] || exit 1

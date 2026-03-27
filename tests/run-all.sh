#!/usr/bin/env bash
# Run all test suites for papilov.org
# Usage: ./tests/run-all.sh [--skip-build]
#
# --skip-build: Skip the Hugo build step (use existing public/ directory)

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SKIP_BUILD=false

for arg in "$@"; do
  case "$arg" in
    --skip-build) SKIP_BUILD=true ;;
  esac
done

TOTAL_PASS=0
TOTAL_FAIL=0
FAILED_SUITES=""

run_test() {
  local name="$1"
  local script="$2"

  echo ""
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo "  $name"
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo ""

  if bash "$script"; then
    echo ""
    echo "  ▸ $name: PASSED"
  else
    FAILED_SUITES="$FAILED_SUITES $name"
    echo ""
    echo "  ▸ $name: FAILED"
  fi
}

echo "╔══════════════════════════════════════════════╗"
echo "║       papilov.org — Test Suite               ║"
echo "╚══════════════════════════════════════════════╝"

# Tests that don't require a build
run_test "CSS Class Coverage" "$SCRIPT_DIR/test-css-coverage.sh"
run_test "i18n Completeness" "$SCRIPT_DIR/test-i18n.sh"
run_test "Theme CSS Validation" "$SCRIPT_DIR/test-theme-css.sh"

# Tests that require a Hugo build
if [ "$SKIP_BUILD" = false ]; then
  run_test "Build Validation" "$SCRIPT_DIR/test-build.sh"
  run_test "Slug Leak Detection" "$SCRIPT_DIR/test-slug-leaks.sh"
  run_test "HTML Output Validation" "$SCRIPT_DIR/test-html-validation.sh"
else
  echo ""
  echo "  (Skipping build-dependent tests: --skip-build)"
  # Still run if public/ exists
  if [ -d "$SCRIPT_DIR/../public" ]; then
    echo "  (Found existing public/, running post-build tests)"
    run_test "Slug Leak Detection" "$SCRIPT_DIR/test-slug-leaks.sh"
    run_test "HTML Output Validation" "$SCRIPT_DIR/test-html-validation.sh"
  fi
fi

# Summary
echo ""
echo "╔══════════════════════════════════════════════╗"
echo "║                  Summary                     ║"
echo "╚══════════════════════════════════════════════╝"
echo ""

if [ -z "$FAILED_SUITES" ]; then
  echo "  All test suites passed."
  exit 0
else
  echo "  Failed suites:$FAILED_SUITES"
  exit 1
fi

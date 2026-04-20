#!/usr/bin/env bash
# scan-private-refs.sh — papilov.org guard against accidental leaks of
# private claude-memory content into the public site.
#
# Installed as a pre-commit hook and mirrored in CI. If ANY staged file
# under content/ or static/ matches the private-pattern regex, the
# commit is rejected.
#
# Maintained alongside RULES.md #10. When a new leak surfaces, add its
# pattern here and to the CI workflow.

set -eu

RED=$'\033[0;31m'
GREEN=$'\033[0;32m'
YELLOW=$'\033[0;33m'
NC=$'\033[0m'

# Private-pattern regex. Extended regex, case-sensitive on proper nouns,
# case-insensitive on the hub-path markers (Hugo slugs are always lower
# but we match loosely anyway).
#
# If you need to legitimately mention one of these words (e.g. in a
# research article's title), add an allowlist exception in the exclusion
# step below. Do NOT loosen the regex.
PRIVATE_REGEX='(^|[^a-z])(Jay|PassLocal|Валера|Val [A-Z]|RSYa|РСЯ|rsya)([^a-z]|$)|hubs/0[2-9]|hubs/10_papilov_org|STATUS_SNAPSHOT|Barcelona relocation|Spanish learning|Spanish streak|Urinary U/C Low Purine|cystinuria|цистинурия|relocation Barcelona|MEMEX_GUIDE|claude-memory\.git|granola_meetings|claude-memory-db|claude-memory-store|AUTH_PATH_TOKEN|MEMORY_MCP_TOKEN|DREAMING_TASK|COWORK_SYNC_TASK'

# Decide what to scan:
#   - If called with no args: scan staged diff (pre-commit mode)
#   - If called with args: treat them as file paths (CI mode / manual)
if [ $# -eq 0 ]; then
  MODE="staged"
  FILES=$(git diff --cached --name-only --diff-filter=ACM -- 'content/' 'static/' 'themes/' 2>/dev/null || true)
else
  MODE="manual"
  FILES="$*"
fi

if [ -z "${FILES:-}" ]; then
  echo "${GREEN}[scan-private-refs]${NC} nothing to scan"
  exit 0
fi

HITS=0
for f in $FILES; do
  if [ ! -f "$f" ]; then
    continue
  fi

  # Skip binary files by extension
  case "$f" in
    *.png|*.jpg|*.jpeg|*.gif|*.webp|*.ico|*.pdf|*.woff|*.woff2|*.ttf|*.otf|*.zip|*.tar.gz)
      continue
      ;;
  esac

  # In staged mode, scan the staged blob, not the working-tree copy
  if [ "$MODE" = "staged" ]; then
    CONTENT=$(git show ":$f" 2>/dev/null || cat "$f")
  else
    CONTENT=$(cat "$f")
  fi

  MATCHES=$(printf '%s\n' "$CONTENT" | grep -nE "$PRIVATE_REGEX" || true)
  if [ -n "$MATCHES" ]; then
    echo "${RED}[scan-private-refs]${NC} $f matches the private-pattern regex:"
    printf '%s\n' "$MATCHES" | sed 's/^/    /'
    HITS=$((HITS + 1))
  fi
done

if [ "$HITS" -gt 0 ]; then
  echo ""
  echo "${RED}⛔ Commit blocked: $HITS file(s) reference private topics.${NC}"
  echo ""
  echo "Remedy:"
  echo "  1. Remove the reference (hub names, topic lists, project names, people, medical/legal/financial facts)."
  echo "  2. If the reference is legitimate — add an allowlist exception in scripts/scan-private-refs.sh with a comment explaining why."
  echo "  3. Never use --no-verify to bypass. Incident SECURITY.md §2026-04-20 documents why this exists."
  echo ""
  echo "See RULES.md #10 in the private claude-memory repo."
  exit 1
fi

echo "${GREEN}[scan-private-refs]${NC} no private references found (scanned $(echo "$FILES" | wc -w | tr -d ' ') files)"
exit 0

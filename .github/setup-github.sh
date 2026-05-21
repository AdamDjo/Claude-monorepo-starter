#!/bin/bash
# GitHub initialization script: labels + milestones
# Usage: GITHUB_TOKEN=xxx bash .github/setup-github.sh

REPO="${GITHUB_REPOSITORY:-<owner>/<repo>}"
TOKEN="${GITHUB_TOKEN}"

if [ -z "$TOKEN" ]; then
  echo "GITHUB_TOKEN missing. Usage: GITHUB_TOKEN=xxx bash .github/setup-github.sh"
  exit 1
fi

create_label() {
  local name="$1" color="$2" description="$3"
  curl -s -X POST \
    -H "Authorization: Bearer $TOKEN" \
    -H "Accept: application/vnd.github+json" \
    "https://api.github.com/repos/$REPO/labels" \
    -d "{\"name\":\"$name\",\"color\":\"$color\",\"description\":\"$description\"}" \
    | grep -q '"id"' && echo "  OK: $name" || echo "  SKIP (exists): $name"
}

create_milestone() {
  local title="$1" description="$2"
  curl -s -X POST \
    -H "Authorization: Bearer $TOKEN" \
    -H "Accept: application/vnd.github+json" \
    "https://api.github.com/repos/$REPO/milestones" \
    -d "{\"title\":\"$title\",\"description\":\"$description\"}" \
    | grep -q '"id"' && echo "  OK: $title" || echo "  SKIP (exists): $title"
}

echo "=== Labels ==="
# Types
create_label "type: feature"   "0075ca" "New feature"
create_label "type: bug"       "d73a4a" "Something isn't working"
create_label "type: chore"     "e4e669" "Maintenance, tooling, config"
create_label "type: docs"      "cfd3d7" "Documentation only"
create_label "type: refactor"  "d4c5f9" "Code refactoring"
create_label "type: release"   "0e8a16" "Release branch PR"

# Priorities
create_label "priority: high"   "ff6b35" "Must fix this sprint"
create_label "priority: medium" "fbca04" "This week"
create_label "priority: low"    "c2e0c6" "Backlog"

# Domains
create_label "domain: frontend" "bfd4f2" "Frontend (Next.js)"
create_label "domain: backend"  "d4c5f9" "Backend (Express)"
create_label "domain: shared"   "c2e0c6" "Shared types/constants"
create_label "domain: database" "f9d0c4" "Database"
create_label "domain: devops"   "e4e669" "CI/CD, GitHub Actions"

# Phases
create_label "phase: 1" "0075ca" "Phase 1 — Foundation"
create_label "phase: 2" "003d8f" "Phase 2 — MVP"
create_label "phase: 3" "f9d0c4" "Phase 3 — Polish"

# Status
create_label "status: blocked"    "e11d48" "Blocked by a dependency"
create_label "status: needs-info" "d876e3" "Needs more information"
create_label "status: in-review"  "0075ca" "In review"

echo ""
echo "=== Milestones ==="
create_milestone "Phase 1 — Foundation" "Core infrastructure ready"
create_milestone "Phase 2 — MVP"        "Fully working product"
create_milestone "Phase 3 — Polish"     "Production-ready"

echo ""
echo "Done! Reload the GitHub page to see the changes."

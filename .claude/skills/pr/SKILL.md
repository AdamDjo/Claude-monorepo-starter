---
name: pr
description: Pousse la branche courante et ouvre une PR vers la bonne cible. Extrait le numéro d'issue du nom de branche automatiquement.
allowed-tools: Bash, mcp__github__create_pull_request
---

L'utilisateur veut pousser sa branche courante et ouvrir une PR.

Lire `docs/MEMORY.md` pour récupérer owner et repo.

Exécuter dans l'ordre :

1. **Récupérer le contexte**

   ```bash
   git rev-parse --abbrev-ref HEAD
   git log origin/develop..HEAD --oneline 2>/dev/null || git log origin/main..HEAD --oneline
   git status --short
   ```

2. **Vérifier qu'il n'y a pas de fichiers non commités**

3. **Déterminer la branche cible selon le préfixe :**
   - `feature/*` → cible : `develop`
   - `fix/*` → cible : `develop`
   - `chore/*` → cible : `develop`
   - `hotfix/*` → cible : `main`
   - `release/*` → cible : `main`

4. **Extraire le numéro d'issue du nom de branche**
   - Pattern : `<préfixe>/<numéro>-<description>`
   - Si pas de numéro détecté, demander à l'utilisateur

5. **Pousser la branche**

   ```bash
   git push origin <branche-courante>
   ```

6. **Préparer le titre et le body de la PR**

   Body :
   ```
   ## Summary
   <liste des changements principaux>

   ## Test plan
   - [ ] lint + type-check passent
   - [ ] Tests unitaires passent
   - [ ] Testé en local

   Closes #<numéro issue>
   ```

7. **Déterminer les labels :**
   - `feature/*phase-1*` → `["phase: 1", "domain: frontend"]` ou `backend`
   - `feature/*phase-2*` → `["phase: 2"]`
   - `feature/*phase-3*` → `["phase: 3"]`
   - `fix/*` → `["type: bug"]`
   - `hotfix/*` → `["type: bug", "priority: high"]`
   - `chore/*` → `["type: chore"]`
   - `release/*` → `["type: release"]`
   - Ajouter `domain: devops` si fichiers dans `.github/`
   - Ajouter `domain: shared` si fichiers dans `packages/`

8. **Créer la PR via mcp__github__create_pull_request**
   - owner et repo lus depuis MEMORY.md
   - assignees: [owner]
   - reviewers: [owner]

9. **Assigner la PR au projet Scrum Board et au milestone** (si PROJECT_ID configuré dans MEMORY.md)

   ```bash
   PR_NODE_ID=$(gh api repos/<owner>/<repo>/pulls/<PR_NUMBER> --jq '.node_id')
   gh api graphql -f query='mutation { addProjectV2ItemById(input: { projectId: "<PROJECT_ID>" contentId: "'$PR_NODE_ID'" }) { item { id } } }'

   MILESTONE_NUMBER=$(gh api repos/<owner>/<repo>/milestones --jq '.[] | select(.title == "<MILESTONE_TITLE>") | .number')
   gh api repos/<owner>/<repo>/issues/<PR_NUMBER> --method PATCH --field milestone=$MILESTONE_NUMBER
   ```

10. **Confirmer à l'utilisateur avec l'URL de la PR**

---
name: feature
description: Crée une issue GitHub puis une branche feature depuis develop avec le numéro d'issue. Usage: /feature <nom> — ex: /feature phase-1-auth
allowed-tools: Bash, mcp__github__create_issue
---

L'utilisateur veut démarrer une nouvelle feature. Les args sont le nom de la branche (sans le préfixe `feature/`).

Si aucun arg fourni, demander le nom à l'utilisateur.

Lire `docs/MEMORY.md` pour récupérer owner et repo (format: `owner/repo`).

Exécuter dans l'ordre :

1. **Créer l'issue GitHub**
   - Demander : "Décris la feature en une phrase (pour l'issue GitHub)"
   - Déduire les labels depuis le nom de branche :
     - `*phase-1*` → `["type: feature", "phase: 1"]`
     - `*phase-2*` → `["type: feature", "phase: 2"]`
     - `*phase-3*` → `["type: feature", "phase: 3"]`
     - Sinon → `["type: feature"]`
   - Créer l'issue via mcp__github__create_issue avec :
     - owner et repo lus depuis MEMORY.md
     - title: "feat: <description>"
     - labels déduits ci-dessus
     - assignees: [owner lu depuis MEMORY.md]
   - Noter le numéro de l'issue créée → `<numéro>`

2. **Ajouter l'issue au projet Scrum Board** (si PROJECT_ID configuré dans MEMORY.md)

   ```bash
   ISSUE_NODE_ID=$(gh api repos/<owner>/<repo>/issues/<numéro> --jq '.node_id')
   gh api graphql -f query='mutation { addProjectV2ItemById(input: { projectId: "<PROJECT_ID>" contentId: "'$ISSUE_NODE_ID'" }) { item { id } } }'
   ```

3. **Mettre develop à jour**

   ```bash
   git checkout develop && git pull origin develop
   ```

4. **Créer la branche avec le numéro d'issue**

   ```bash
   git checkout -b feature/<numéro>-<args>
   ```

5. **Confirmer à l'utilisateur :**

   ```
   ✅ Issue #<numéro> créée — assignée à <owner>
   ✅ Branche 'feature/<numéro>-<args>' créée depuis develop

   Workflow :
   1. Code, commits avec : git commit -m "feat(<scope>): <description>"
   2. Quand prêt : /pr pour pousser et ouvrir la PR → develop (Closes #<numéro>)

   Format commit : feat | fix | chore | docs | refactor | test
   Pas de Co-Authored-By Claude
   ```

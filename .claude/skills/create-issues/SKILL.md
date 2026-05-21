---
name: create-issues
description: Create GitHub issues from a specification or document. Usage: /create-issues <source> — ex: /create-issues docs/PRODUCT_DESIGN.md
allowed-tools: Read, Bash, mcp__github__create_issue
---

L'utilisateur veut créer des issues GitHub depuis un document ou une description.

Lire `docs/MEMORY.md` pour récupérer owner et repo.

Exécuter dans l'ordre :

1. **Lire la source**
   - Si un fichier est passé en argument (ex: `docs/PRODUCT_DESIGN.md`), le lire
   - Sinon, demander : "Décris les tâches à créer comme issues (liste ou document)"

2. **Identifier les tâches à créer**
   - Extraire les tâches distinctes
   - Déduire phase, domaine et priorité pour chaque tâche

3. **Pour chaque tâche, créer une issue via mcp__github__create_issue :**
   - owner et repo lus depuis MEMORY.md
   - title: "feat: <description>"
   - labels: selon phase et domaine
   - assignees: [owner]

4. **Si PROJECT_ID est configuré dans MEMORY.md, ajouter les issues au Scrum Board :**
   ```bash
   ISSUE_NODE_ID=$(gh api repos/<owner>/<repo>/issues/<numéro> --jq '.node_id')
   gh api graphql -f query='mutation { addProjectV2ItemById(input: { projectId: "<PROJECT_ID>" contentId: "'$ISSUE_NODE_ID'" }) { item { id } } }'
   ```

5. **Confirmer avec la liste des issues créées et leurs numéros**

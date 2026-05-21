---
name: hotfix
description: Crée une issue GitHub puis une branche hotfix depuis main avec le numéro d'issue. Usage: /hotfix <nom> — ex: /hotfix auth-crash
allowed-tools: Bash, mcp__github__create_issue
---

L'utilisateur veut corriger un bug urgent en production. Les args sont le nom du hotfix (sans le préfixe `hotfix/`).

Lire `docs/MEMORY.md` pour récupérer owner et repo.

Exécuter dans l'ordre :

1. **Créer l'issue GitHub**
   - Demander : "Décris le problème en production en une phrase"
   - Créer l'issue via mcp__github__create_issue avec :
     - owner et repo lus depuis MEMORY.md
     - title: "hotfix: <description>"
     - labels: ["type: bug", "priority: high"]
     - assignees: [owner]
   - Noter le numéro → `<numéro>`

2. **Partir de main (pas develop — c'est urgent)**

   ```bash
   git checkout main && git pull origin main
   ```

3. **Créer la branche hotfix**

   ```bash
   git checkout -b hotfix/<numéro>-<args>
   ```

4. **Confirmer :**

   ```
   ⚠️  HOTFIX — tu pars de main (production)

   ✅ Issue #<numéro> créée
   ✅ Branche 'hotfix/<numéro>-<args>' créée depuis main

   1. Corrige le bug, commite avec : git commit -m "fix(<scope>): <description>"
   2. Quand prêt : /pr pour pousser et ouvrir la PR → main (Closes #<numéro>)
   3. Après merge dans main : /sync pour ramener le fix dans develop
   ```

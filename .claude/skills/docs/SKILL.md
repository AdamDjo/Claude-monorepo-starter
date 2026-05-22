---
name: docs
description: Met à jour docs/MEMORY.md et docs/ARCHITECTURE.md en lisant l'état réel du code. Usage: /docs
disable-model-invocation: true
allowed-tools: Read, Edit, Glob, Bash
---

Met à jour la documentation persistante du projet en lisant l'état réel du code.

Exécuter dans l'ordre :

1. **Lire l'état actuel**

   ```bash
   git log --oneline -10
   git branch -a
   git status --short
   ```

   Lire aussi :
   - `docs/MEMORY.md` (version actuelle)
   - `docs/ARCHITECTURE.md` (version actuelle)
   - `packages/shared/src/index.ts` (types exportés)
   - `apps/backend/src/index.ts` (routes enregistrées)
   - `apps/frontend/src/app/` (pages existantes)

2. **Mettre à jour `docs/MEMORY.md`**

   Sections à mettre à jour :
   - **Quick Summary** : branche courante, phase actuelle
   - **Project State** : liste des features implémentées vs prévues
   - **Timeline** : ajouter les événements récents (features mergées, releases)
   - **Next Steps** : ce qui reste à faire en Phase courante

   Ne pas écraser les sections "Key Decisions" et "User Preferences" sauf si l'utilisateur le demande.

3. **Mettre à jour `docs/ARCHITECTURE.md`**

   Sections à mettre à jour :
   - **Data Model** : types réels depuis `packages/shared/src/types/`
   - **API Design** : routes réelles depuis `apps/backend/src/routes/`
   - **Folder Structure** : structure réelle des dossiers créés

4. **Confirmer :**

   ```
   ✅ docs/MEMORY.md mis à jour
   ✅ docs/ARCHITECTURE.md mis à jour

   Résumé des changements :
   - <ce qui a changé dans MEMORY.md>
   - <ce qui a changé dans ARCHITECTURE.md>
   ```

---
name: sync
description: Synchronise develop avec main après un merge de hotfix ou release. Usage: /sync
allowed-tools: Bash
---

L'utilisateur veut synchroniser develop avec main (après un merge hotfix ou release dans main).

Exécuter dans l'ordre :

1. **Vérifier l'état courant**
   ```bash
   git fetch origin
   git log origin/develop..origin/main --oneline
   ```
   - Si develop est déjà à jour avec main, afficher "✅ develop est déjà à jour avec main" et arrêter

2. **Afficher les commits qui seront ramenés dans develop**

3. **Merger main dans develop**
   ```bash
   git checkout develop
   git pull origin develop
   git merge origin/main --no-edit
   ```

4. **Pousser develop**
   ```bash
   git push origin develop
   ```

5. **Confirmer :**
   ```
   ✅ develop est maintenant à jour avec main

   Tu peux repartir sur une nouvelle feature : /feature <nom>
   ```

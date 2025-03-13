# 📌 Calculatrice Flutter

## 📖 Description
Cette application est une calculatrice simple développée en **Flutter** avec une interface intuitive. Elle permet d’effectuer des opérations de base (**addition, soustraction, multiplication, division**) et d’afficher un historique des calculs récents.
---



## ⚙️ Fonctionnalités
✔️ **Affichage dynamique** des chiffres et opérations tapées  
✔️ **Calcul du résultat** en appuyant sur `=`  
✔️ **Gestion de l’historique**, affichant les 5 derniers calculs  
✔️ **Réinitialisation complète** avec le bouton `C`  
✔️ **Défilement de l’historique** si celui-ci devient trop long

---

## 💡 Choix techniques et explications

### 1️⃣ **Mise à jour de l’écran de calcul**
- J’utilise une **chaîne de caractères (`String ecran`)** pour stocker l’affichage actuel.
- Quand un bouton est pressé, la valeur est ajoutée à `ecran`, sauf si c’est `C` ou `=`.

> 🏆 **Solution :** Un `setState()` est appelé à chaque appui pour rafraîchir l’affichage.

### 2️⃣ **Calcul des opérations**
- Les nombres et opérateurs sont séparés grâce à `split(RegExp(...))`.
- Le calcul se fait en **parcourant la liste** et en appliquant les opérations dans l’ordre.

> 🔍 **Problème rencontré :** `split()` séparait mal les opérateurs.  
> ✅ **Solution :** Correction avec une expression régulière plus précise.

### 3️⃣ **Affichage du résultat et réinitialisation**
- Après `=`, le résultat reste affiché jusqu’à la saisie d’un nouveau chiffre.
- `nouveauCalcul` est un booléen qui détecte si un nouveau calcul doit commencer.

> 🔄 **Solution :** Si un chiffre est tapé après `=`, l’écran repart de zéro.

### 4️⃣ **Défilement de l’historique**
- J’ai ajouté un **`SingleChildScrollView`** pour permettre de scroller.
- Une **limite de 5 entrées** est imposée pour éviter un historique trop long.

> 🏆 **Solution :** Si plus de 5 éléments, le plus ancien est supprimé (`removeAt(0)`).

---

## 🚀 Améliorations possibles
🔹 Gestion des priorités (`*` et `/` avant `+` et `-`)  
🔹 Ajout d’un bouton `.` pour les nombres décimaux  
🔹 Mode sombre pour une meilleure lisibilité  

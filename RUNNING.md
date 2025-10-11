## Lancer ERPNext localement

Ce dépôt contient deux éléments :

- le code complet d’ERPNext dans `erpnext/`
- l’environnement Docker officiel dans `frappe_docker/` pour démarrer une instance prête à l’emploi

### Prérequis

- [Docker Desktop](https://www.docker.com/products/docker-desktop/) (inclut Docker Compose v2)
- Git déjà installé (c’est le cas si vous lisez ce fichier depuis ce dépôt)
- Sur Windows, activer WSL 2 dans Docker Desktop pour de meilleures performances

### Démarrage rapide

1. Ouvrir un terminal PowerShell.
2. Se placer dans le dossier Docker :
   ```powershell
   cd "c:\Users\HadiABDALLAH\Documents\07 - Git\ERP\MoonBase\frappe_docker"
   ```
3. Lancer les conteneurs d’exemple fournis par Frappe :
   ```powershell
   docker compose -f pwd.yml up -d
   ```
4. Attendre 2 à 3 minutes que tous les services terminent leur initialisation. Suivre la progression si besoin :
   ```powershell
   docker compose -f pwd.yml logs -f
   ```
5. Ouvrir un navigateur sur [http://localhost:8080](http://localhost:8080) et se connecter avec :
   - Utilisateur : `Administrator`
   - Mot de passe : `admin`

### Arrêt et nettoyage

- Arrêter l’instance :
  ```powershell
  docker compose -f pwd.yml down
  ```
- Pour libérer l’espace disque (images et volumes), ajouter l’option `--volumes`.

### Aller plus loin

- La configuration Docker complète et les scénarios avancés (installation personnalisée, création de site, montée en charge, etc.) sont décrits dans `frappe_docker/README.md`.
- Pour une installation manuelle via Bench, suivre la section “Local” du `README.md` racine (`bench start`, `bench new-site`, `bench install-app erpnext`).


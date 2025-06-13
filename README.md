# MoonBase

This project provides a docker-compose stack with the following services:

- **PostgreSQL** – database with schemas: `keycloak` for Keycloak, `app` for the
  application tables and `grafana` for Grafana's own data.
- **Keycloak** – authentication. The `keycloak` schema is reset on each start
  and the realms from `keycloak/keycloak-realm.json`, `keycloak/realm-t1.json`
  and `keycloak/realm-t2.json` are re-imported automatically. The additional
  realm files create tenants **T1** and **T2** with a single user each.
- **OpenSearch** and **OpenSearch Dashboards** – logging and search
- **Prometheus** and **Grafana** – monitoring. Grafana stores its dashboards in
  the `grafana` schema.
- **NGINX** – reverse proxy
- **Status page** – simple web page displaying service status
- **Backend** – Go service powered by Echo
- **Frontend** – React/Next.js UI styled with Tailwind CSS
- **FileGator** – web file manager served from `/filegator/`
- **Outline** – knowledge base accessible at `/outline/`
- **Answer** – community Q&A at `/answer/`
- **Typesense** – search engine used by Outline and Answer, API available at `/typesense/`
- **Metabase** – analytics UI served from `/metabase/`
- **Redis** – cache for Outline
- **Form.io** – form builder served from `/formio/`
- **MongoDB** – backing database for Form.io
- The PostgreSQL instance initializes a database named `system_database`.
  Application tables live under the `app` schema, Keycloak stores its data in
  the `keycloak` schema and Grafana uses the `grafana` schema.

Configuration for each module lives in its own folder under `module-configs/`.
For example the Form.io service uses `module-configs/formio/formio.yml`.
These files can be edited before launch to tweak service behavior.

## Usage

1. Ensure Docker and Docker Compose are installed.
2. Run the stack. Docker Compose will build a small Keycloak image using
   `keycloak/Dockerfile`. The container launches our `init.sh` script first
   which now resolves database parameters from `KC_DB_URL` and calls Keycloak
   via a relative path, so the setup works regardless of the installation
   location:
## Services inclus

- PostgreSQL : base de données unique avec plusieurs schémas (`app`, `keycloak`, `grafana`)
- Keycloak : serveur d’identité et d’authentification multi-tenant (tenants T1 et T2)
- OpenSearch : moteur de recherche et d’indexation
- OpenSearch Dashboards : visualisation et analyse des données OpenSearch
- Prometheus : collecte et agrégation de métriques
- Grafana : tableaux de bord de visualisation
- NGINX : reverse proxy et point d’entrée unique
- Status Page : interface web listant les statuts des services
- Backend : API REST développée avec Go (framework Echo)
- Frontend : interface utilisateur en React / Next.js
- FileGator : gestionnaire de fichiers web
- Outline : base de connaissances collaborative
- Answer : plateforme de questions-réponses communautaire
- Typesense : moteur de recherche typé utilisé par Outline et Answer
- Metabase : outil de Business Intelligence
- Redis : système de cache utilisé par Outline

## Prérequis

- Docker et Docker Compose installés
- Fichier `.env.production` correctement renseigné
- Secrets Docker présents dans le répertoire `./secrets`

## Lancement

1. Initialiser les éventuels sous-modules Git si nécessaires :
   ```bash
   git submodule update --init --recursive

Construire les images :

bash
Copier
Modifier
make build
Lancer la stack :

bash
Copier
Modifier
make up
Vérifier les journaux :

bash
Copier
Modifier
make logs
Accéder à l’interface via : http://localhost/

Chemins d’accès aux services
Interface NGINX : http://localhost/

Page de statut : http://localhost/status/

API Backend : http://localhost/api/home

Interface Frontend : http://localhost/app/

OpenSearch Dashboards : http://localhost/dashboards/

Grafana : http://localhost/grafana/

Prometheus : http://localhost/prometheus/

FileGator : http://localhost/filegator/

Outline : http://localhost/outline/

Answer : http://localhost/answer/

Metabase : http://localhost/metabase/

Typesense API : http://localhost/typesense/

Authentification
Utilisateur realm T1 : identifiant T1, mot de passe password

Utilisateur realm T2 : identifiant T2, mot de passe password

Interface de login redirigée via Keycloak

Secrets attendus
Les fichiers de secrets doivent être présents dans ./secrets :

postgres_user.txt

postgres_password.txt

keycloak_admin.txt

keycloak_password.txt

grafana_password.txt

outline_secret_key.txt

outline_utils_secret.txt

Ces secrets sont référencés via des variables Docker dans le fichier .env.production.

Exemple de fichier .env.production
Un exemple complet est disponible dans ce dépôt et contient toutes les variables attendues par les services.

Configuration OpenSearch avec Keycloak (optionnel)
Créer un client opensearch dans Keycloak avec URI de redirection http://localhost/dashboards/auth/openid/login

Retirer plugins.security.disabled: true de opensearch.yml

Ajouter la configuration suivante :

yaml
Copier
Modifier
plugins.security.auth.type: openid
plugins.security.openid.connect_url: http://keycloak:8080/realms/moonbase/.well-known/openid-configuration
plugins.security.openid.client_id: opensearch
plugins.security.openid.client_secret: <secret>
plugins.security.openid.base_redirect_url: http://localhost/dashboards
Appliquer une configuration équivalente dans opensearch_dashboards.yml

Redémarrer les services concernés avec make restart

Volumes Docker
pgdata : données PostgreSQL

osdata : données OpenSearch

grafana-storage : dashboards Grafana

typesense-data : données Typesense

filegator-data : fichiers utilisateurs FileGator

Commandes Makefile disponibles
make build : build des images

make up : démarrage des services

make down : arrêt complet et suppression des volumes

make restart : redémarrage complet

make logs : affichage des logs

make status : affichage des conteneurs en cours

make prune : nettoyage complet Docker (volumes, réseaux, images)

Notes
Tous les services sont servis par NGINX via des chemins personnalisés

L’environnement est conçu pour être modulaire, sécurisé, multi-tenant et évolutif

L’infrastructure respecte une approche orientée microservices avec authentification centralisée via Keycloak

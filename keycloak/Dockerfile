FROM quay.io/keycloak/keycloak:23.0

# Définir le dossier de travail
WORKDIR /opt/keycloak

# Copier les fichiers nécessaires
COPY init.sh /opt/keycloak/init.sh
COPY keycloak-realm.json /opt/keycloak/data/import/keycloak-realm.json

# Rendre le script exécutable (et convertir en format Unix au cas où)
RUN sed -i 's/\r$//' /opt/keycloak/init.sh && chmod +x /opt/keycloak/init.sh

# Lancer le script de démarrage
ENTRYPOINT ["/opt/keycloak/init.sh"]

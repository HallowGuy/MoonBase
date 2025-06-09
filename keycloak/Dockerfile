FROM quay.io/keycloak/keycloak:23.0
COPY init.sh /opt/keycloak/init.sh
COPY keycloak-realm.json /opt/keycloak/data/import/keycloak-realm.json
RUN chmod +x /opt/keycloak/init.sh
ENTRYPOINT ["/opt/keycloak/init.sh"]

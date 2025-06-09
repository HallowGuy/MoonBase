FROM quay.io/keycloak/keycloak:23.0
WORKDIR /opt/keycloak

# Copy the initialization script and realm file using paths
# relative to the Keycloak home directory so that the image
# works regardless of the absolute installation prefix.
COPY init.sh ./init.sh
COPY keycloak-realm.json ./data/import/keycloak-realm.json

# Ensure the init script is executable and use it as the entrypoint.
RUN chmod +x init.sh
ENTRYPOINT ["./init.sh"]

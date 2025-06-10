FROM quay.io/keycloak/keycloak:23.0

# All files are placed inside the Keycloak home directory.
WORKDIR /opt/keycloak

# Copy the initialization script explicitly to its final location.
COPY init.sh /opt/keycloak/init.sh

# Copy the realm definition that will be imported on start.
COPY keycloak-realm.json /opt/keycloak/data/import/keycloak-realm.json

# Ensure the init script has Unix line endings and is executable.
RUN sed -i 's/\r$//' /opt/keycloak/init.sh \ 
    && chmod +x /opt/keycloak/init.sh

# Launch Keycloak via the init script using an absolute path.
ENTRYPOINT ["/opt/keycloak/init.sh"]


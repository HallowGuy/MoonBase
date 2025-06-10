-- V2__create_keycloak_schema.sql

-- Suppression de tout contenu existant dans le schéma keycloak
DO
$$
DECLARE
    r RECORD;
BEGIN
    -- Supprimer les vues
    FOR r IN (SELECT table_name FROM information_schema.views WHERE table_schema = 'keycloak') LOOP
        EXECUTE 'DROP VIEW IF EXISTS keycloak.' || quote_ident(r.table_name) || ' CASCADE';
    END LOOP;

    -- Supprimer les tables
    FOR r IN (SELECT table_name FROM information_schema.tables WHERE table_schema = 'keycloak') LOOP
        EXECUTE 'DROP TABLE IF EXISTS keycloak.' || quote_ident(r.table_name) || ' CASCADE';
    END LOOP;

    -- Supprimer les séquences
    FOR r IN (SELECT sequence_name FROM information_schema.sequences WHERE sequence_schema = 'keycloak') LOOP
        EXECUTE 'DROP SEQUENCE IF EXISTS keycloak.' || quote_ident(r.sequence_name) || ' CASCADE';
    END LOOP;

    -- Supprimer les fonctions
    FOR r IN (SELECT routine_name FROM information_schema.routines WHERE routine_schema = 'keycloak') LOOP
        EXECUTE 'DROP FUNCTION IF EXISTS keycloak.' || quote_ident(r.routine_name) || ' CASCADE';
    END LOOP;
END
$$;

-- Création (ou confirmation) du schéma
CREATE SCHEMA IF NOT EXISTS keycloak;

-- Permissions pour Keycloak
GRANT USAGE ON SCHEMA keycloak TO "user";

-- V3__create_app_schema.sql

-- Suppression de tout contenu existant dans le schéma app
DO
$$
DECLARE
    r RECORD;
BEGIN
    -- Supprimer les vues
    FOR r IN (SELECT table_name FROM information_schema.views WHERE table_schema = 'app') LOOP
        EXECUTE 'DROP VIEW IF EXISTS app.' || quote_ident(r.table_name) || ' CASCADE';
    END LOOP;

    -- Supprimer les tables
    FOR r IN (SELECT table_name FROM information_schema.tables WHERE table_schema = 'app') LOOP
        EXECUTE 'DROP TABLE IF EXISTS app.' || quote_ident(r.table_name) || ' CASCADE';
    END LOOP;

    -- Supprimer les séquences
    FOR r IN (SELECT sequence_name FROM information_schema.sequences WHERE sequence_schema = 'app') LOOP
        EXECUTE 'DROP SEQUENCE IF EXISTS app.' || quote_ident(r.sequence_name) || ' CASCADE';
    END LOOP;

    -- Supprimer les fonctions
    FOR r IN (SELECT routine_name FROM information_schema.routines WHERE routine_schema = 'app') LOOP
        EXECUTE 'DROP FUNCTION IF EXISTS app.' || quote_ident(r.routine_name) || ' CASCADE';
    END LOOP;
END
$$;

-- Création du schéma
CREATE SCHEMA IF NOT EXISTS app;

-- Extension nécessaire pour UUID
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- Table utilisateurs
CREATE TABLE app.users (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    username VARCHAR(100) NOT NULL UNIQUE,
    email VARCHAR(255) NOT NULL UNIQUE,
    hashed_password TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table des rôles
CREATE TABLE app.roles (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE
);

-- Liaison utilisateurs-rôles
CREATE TABLE app.user_roles (
    user_id UUID REFERENCES app.users(id) ON DELETE CASCADE,
    role_id INT REFERENCES app.roles(id) ON DELETE CASCADE,
    PRIMARY KEY (user_id, role_id)
);

-- Permissions utilisateur
GRANT USAGE ON SCHEMA app TO "user";
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA app TO "user";

-- Permissions futures (objets créés après migration)
ALTER DEFAULT PRIVILEGES IN SCHEMA app
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO "user";

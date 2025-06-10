-- V1__create_public_schema.sql

-- Supprimer tout ce qui existe dans le schéma public (tables, vues, séquences, etc.)
DO
$$
DECLARE
    r RECORD;
BEGIN
    -- Supprimer les vues
    FOR r IN (SELECT table_schema, table_name FROM information_schema.views WHERE table_schema = 'public') LOOP
        EXECUTE 'DROP VIEW IF EXISTS public.' || quote_ident(r.table_name) || ' CASCADE';
    END LOOP;

    -- Supprimer les tables
    FOR r IN (SELECT table_schema, table_name FROM information_schema.tables WHERE table_schema = 'public') LOOP
        EXECUTE 'DROP TABLE IF EXISTS public.' || quote_ident(r.table_name) || ' CASCADE';
    END LOOP;

    -- Supprimer les séquences
    FOR r IN (SELECT sequence_schema, sequence_name FROM information_schema.sequences WHERE sequence_schema = 'public') LOOP
        EXECUTE 'DROP SEQUENCE IF EXISTS public.' || quote_ident(r.sequence_name) || ' CASCADE';
    END LOOP;

    -- Supprimer les fonctions
    FOR r IN (
        SELECT routine_name
        FROM information_schema.routines
        WHERE routine_schema = 'public'
    ) LOOP
        EXECUTE 'DROP FUNCTION IF EXISTS public.' || quote_ident(r.routine_name) || ' CASCADE';
    END LOOP;
END
$$;

-- (Re)Créer le schéma public (si supprimé, mais normalement il est toujours là)
CREATE SCHEMA IF NOT EXISTS public;

-- Exemple de table de logs
CREATE TABLE public.application_logs (
    id SERIAL PRIMARY KEY,
    timestamp TIMESTAMP NOT NULL DEFAULT NOW(),
    level VARCHAR(10) NOT NULL,
    message TEXT NOT NULL,
    source VARCHAR(255)
);

-- Droits pour l'utilisateur principal
GRANT USAGE ON SCHEMA public TO "user";
GRANT SELECT, INSERT ON public.application_logs TO "user";

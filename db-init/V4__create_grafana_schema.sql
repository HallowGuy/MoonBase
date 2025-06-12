-- V4__create_grafana_schema.sql

-- Cleanup existing Grafana schema
DO
$$
DECLARE
    r RECORD;
BEGIN
    -- Drop views
    FOR r IN (SELECT table_name FROM information_schema.views WHERE table_schema = 'grafana') LOOP
        EXECUTE 'DROP VIEW IF EXISTS grafana.' || quote_ident(r.table_name) || ' CASCADE';
    END LOOP;

    -- Drop tables
    FOR r IN (SELECT table_name FROM information_schema.tables WHERE table_schema = 'grafana') LOOP
        EXECUTE 'DROP TABLE IF EXISTS grafana.' || quote_ident(r.table_name) || ' CASCADE';
    END LOOP;

    -- Drop sequences
    FOR r IN (SELECT sequence_name FROM information_schema.sequences WHERE sequence_schema = 'grafana') LOOP
        EXECUTE 'DROP SEQUENCE IF EXISTS grafana.' || quote_ident(r.sequence_name) || ' CASCADE';
    END LOOP;

    -- Drop functions
    FOR r IN (SELECT routine_name FROM information_schema.routines WHERE routine_schema = 'grafana') LOOP
        EXECUTE 'DROP FUNCTION IF EXISTS grafana.' || quote_ident(r.routine_name) || ' CASCADE';
    END LOOP;
END
$$;

-- Create the Grafana schema
CREATE SCHEMA IF NOT EXISTS grafana;

-- Permissions for Grafana
GRANT USAGE ON SCHEMA grafana TO "user";

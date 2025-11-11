-- ------------------------------------------------------------
-- 02_insert_data.sql
-- Carga de datos a MNR_DB.DEMO_SCHEMA.PRODUCTOS desde CSV
-- Sin eliminar nada existente. Reutiliza objetos si ya existen.
-- ------------------------------------------------------------

-- 1) Contexto
USE WAREHOUSE COMPUTE_WH;
USE DATABASE MNR_DB;
USE SCHEMA DEMO_SCHEMA;

-- 2) File Formats (se crean/actualizan sin afectar tablas)
--    A) CSV con coma
CREATE OR REPLACE FILE FORMAT CSV_COMMA
  TYPE = CSV
  FIELD_DELIMITER = ','
  FIELD_OPTIONALLY_ENCLOSED_BY = '"'
  SKIP_HEADER = 1
  TRIM_SPACE = TRUE
  NULL_IF = ('', 'NULL', 'null');

--    B) CSV con punto y coma
CREATE OR REPLACE FILE FORMAT CSV_SEMICOLON
  TYPE = CSV
  FIELD_DELIMITER = ';'
  FIELD_OPTIONALLY_ENCLOSED_BY = '"'
  SKIP_HEADER = 1
  TRIM_SPACE = TRUE
  NULL_IF = ('', 'NULL', 'null');

-- 3) Stage interno (no borra si existe)
CREATE STAGE IF NOT EXISTS STAGE_REENCANTO
  FILE_FORMAT = CSV_COMMA;  -- default: asume CSV con coma (puedes ALTER si usas ';')

-- Si necesitas cambiar el formato por defecto del stage:
-- ALTER STAGE STAGE




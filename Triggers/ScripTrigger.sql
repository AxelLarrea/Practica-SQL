/*CREATE TABLE emplea (
dni int NOT NULL,
apellido character varying(32),
nombre CHARACTER VARYING(25),
fecNac date,
Constraint emplea_pkey Primary Key (dni)
);*/

/*CREATE OR REPLACE FUNCTION func_e() RETURNS TRIGGER AS $funcemp$
DECLARE
edad smallint ;
BEGIN
edad := date_part('year',age(NEW.fecNac));
IF NEW.apellido IS NULL THEN
RAISE EXCEPTION 'no puede tener apellido vacío';
END IF;
IF edad <= '18' THEN
RAISE EXCEPTION 'no puede ser menor de 18 años';
END IF;
RETURN NEW;
END; $funcemp$ LANGUAGE plpgsql;*/

/*CREATE TRIGGER trigger_e BEFORE
INSERT OR UPDATE ON emplea
FOR EACH ROW EXECUTE PROCEDURE
func_e();*/

/*INSERT INTO emplea VALUES('11111111', 'GONZALEZ',
'JUAN', '1998-11-10');*/
--INSERT INTO emplea VALUES('11111111',null, 'JUAN', '1950-11-10');
/*INSERT INTO emplea VALUES('111111111', 'PEREZ',
'JUAN', '2010-11-10');*/


/*create table persona(
dni integer primary key,
apellido varchar(30),
nombre varchar(30),
fecnac date,
estadoCivil varchar(10),
constraint CH_Persona_EstadoCivil check (estadoCivil in
('SOLTERO','CASADO','VIUDO','DIVORCIADO')));*/

/*CREATE OR REPLACE FUNCTION func_e() RETURNS TRIGGER AS $funcemp$
DECLARE
edad smallint ;
estadocivil varchar(10);
BEGIN
NEW.estadoCivil := UPPER(NEW.estadoCivil);
edad := date_part('year',age(NEW.fecnac));
IF NEW.apellido = ' ' THEN
RAISE EXCEPTION 'no puede tener apellido vacío';
END IF;
IF edad <= '18' THEN
RAISE EXCEPTION 'no puede ser menor de 18 años';
END IF;
RETURN NEW;
END; $funcemp$ LANGUAGE plpgsql;*/

/*select dni,apellido,nombre, (date_part('year',age(fecNac))) as
edad from emplea;*/

/*CREATE TRIGGER trigger_e BEFORE INSERT OR UPDATE ON persona
FOR EACH ROW EXECUTE PROCEDURE func_e();*/

/*CREATE OR REPLACE FUNCTION func_p() RETURNS TRIGGER AS $funcemp$
DECLARE
BEGIN
NEW.estadoCivil := UPPER(NEW.estadoCivil);
if OLD.estadoCivil = 'SOLTERO' AND (NEW.estadoCivil = 'VIUDO' or
NEW.estadoCivil='DIVORCIADO') THEN
RAISE EXCEPTION 'ERROR de transición en estado civil';
END IF;
if (OLD.estadoCivil = 'CASADO' or OLD.estadoCivil = 'DIVORCIADO' OR OLD.estadoCivil =
'VIUDO') AND (NEW.estadoCivil = 'SOLTERO') THEN
RAISE EXCEPTION 'ERROR de transición en estado civil';
END IF;
if OLD.estadoCivil = 'DIVORCIADO' AND (NEW.estadoCivil = 'VIUDO') THEN
RAISE EXCEPTION 'ERROR de transición en estado civil';
END IF;
if OLD.estadoCivil = 'VIUDO' AND (NEW.estadoCivil = 'DIVORCIADO') THEN
RAISE EXCEPTION 'ERROR de transición en estado civil';
END IF;
RETURN NEW;
END; $funcemp$ LANGUAGE plpgsql;*/

/*CREATE TRIGGER trigger_p BEFORE UPDATE ON persona
FOR EACH ROW EXECUTE PROCEDURE func_p();*/

INSERT INTO persona VALUES (37466751, 'Koch','Matias','1993-08-25','SOLTERO');

INSERT INTO persona VALUES (38995263, 'Flores','Cristina','1993-03-16','CASADO');
INSERT INTO persona VALUES (25987521, 'Picapiedra','Pedro','1998-05-13','');/*error de carga*/
INSERT INTO persona VALUES (39925154, 'Quiroga','Juan','2000-10-25','VIUDO');
INSERT INTO persona VALUES (40582412, 'Traverso','Fabiana','2001-01-01','DIVORCIADO');
INSERT INTO persona VALUES (45850421, 'Picapiedra','Pedro','1998-05-13','');

--Tranferencia correcta de estado civil.
UPDATE persona
SET estadocivil='DIVORCIADO'
WHERE persona.dni=38995263;

--Error de tranferencia de estado Civil.
UPDATE persona
SET estadocivil='DIVORCIADO'
WHERE persona.dni=39925154;

--Creacion de audtoria
CREATE schema audit;
REVOKE CREATE ON schema audit FROM public;
 
CREATE TABLE audit.logged_actions (
    schema_name text NOT NULL,
    TABLE_NAME text NOT NULL,
    user_name text,
    action_tstamp TIMESTAMP WITH TIME zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    action TEXT NOT NULL CHECK (action IN ('I','D','U')),
    original_data text,
    new_data text,
    query text
) WITH (fillfactor=100);
 
REVOKE ALL ON audit.logged_actions FROM public;

GRANT SELECT ON audit.logged_actions TO public;
 
CREATE INDEX logged_actions_schema_table_idx 
ON audit.logged_actions(((schema_name||'.'||TABLE_NAME)::TEXT));
 
CREATE INDEX logged_actions_action_tstamp_idx 
ON audit.logged_actions(action_tstamp);
 
CREATE INDEX logged_actions_action_idx 
ON audit.logged_actions(action);

CREATE OR REPLACE FUNCTION audit.if_modified_func() RETURNS TRIGGER AS $body$
DECLARE
    v_old_data TEXT;
    v_new_data TEXT;
BEGIN
 
    IF (TG_OP = 'UPDATE') THEN
        v_old_data := ROW(OLD.*);
        v_new_data := ROW(NEW.*);
        INSERT INTO audit.logged_actions (schema_name,table_name,user_name,action,original_data,new_data,query) 
        VALUES (TG_TABLE_SCHEMA::TEXT,TG_TABLE_NAME::TEXT,session_user::TEXT,substring(TG_OP,1,1),v_old_data,v_new_data, current_query());
        RETURN NEW;
    ELSIF (TG_OP = 'DELETE') THEN
        v_old_data := ROW(OLD.*);
        INSERT INTO audit.logged_actions (schema_name,table_name,user_name,action,original_data,query)
        VALUES (TG_TABLE_SCHEMA::TEXT,TG_TABLE_NAME::TEXT,session_user::TEXT,substring(TG_OP,1,1),v_old_data, current_query());
        RETURN OLD;
    ELSIF (TG_OP = 'INSERT') THEN
        v_new_data := ROW(NEW.*);
        INSERT INTO audit.logged_actions (schema_name,table_name,user_name,action,new_data,query)
        VALUES (TG_TABLE_SCHEMA::TEXT,TG_TABLE_NAME::TEXT,session_user::TEXT,substring(TG_OP,1,1),v_new_data, current_query());
        RETURN NEW;
    ELSE
        RAISE WARNING '[AUDIT.IF_MODIFIED_FUNC] - Other action occurred: %, at %',TG_OP,now();
        RETURN NULL;
    END IF;
 
EXCEPTION
    WHEN data_exception THEN
        RAISE WARNING '[AUDIT.IF_MODIFIED_FUNC] - UDF ERROR [DATA EXCEPTION] - SQLSTATE: %, SQLERRM: %',SQLSTATE,SQLERRM;
        RETURN NULL;
    WHEN unique_violation THEN
        RAISE WARNING '[AUDIT.IF_MODIFIED_FUNC] - UDF ERROR [UNIQUE] - SQLSTATE: %, SQLERRM: %',SQLSTATE,SQLERRM;
        RETURN NULL;
    WHEN OTHERS THEN
        RAISE WARNING '[AUDIT.IF_MODIFIED_FUNC] - UDF ERROR [OTHER] - SQLSTATE: %, SQLERRM: %',SQLSTATE,SQLERRM;
        RETURN NULL;
END;
$body$
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = pg_catalog, audit;

CREATE TRIGGER t_if_modified_trg 
 AFTER INSERT OR UPDATE OR DELETE ON persona
 FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();*/
 
INSERT INTO persona VALUES (41506031,'Rivadavia','Juana','1994-03-16','SOLTERO');

UPDATE persona
SET estadocivil='CASADO'
WHERE persona.dni=41506031;

SELECT * FROM audit.logged_actions
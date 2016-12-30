DROP SCHEMA IF EXISTS socker CASCADE; 
CREATE SCHEMA socker;
--SET SCHEMA 'socker';

CREATE SEQUENCE socker.agent_id_seq START 101; -- bigint

CREATE TABLE socker.agent ( 
    -- insert/delete only by trigger, valid update only agstatus
    agid bigint NOT NULL PRIMARY KEY,
    agtype int NOT NULL CHECK(agtype=1 OR agtype=2), -- 1=org, 2=person
    name text NOT NULL,  -- controlled by agtype and splitted to info (cache of name parts).
    agstatus int DEFAULT 1 -- 0=inactive... center of control here.
);

CREATE TABLE socker.organization (
    id bigint DEFAULT nextval('socker.agent_id_seq') NOT NULL PRIMARY KEY,
    vatID text,
    info JSONb NOT NULL,  -- minimal is name_main + name_suffix
    UNIQUE(vatID)
);

CREATE TABLE socker.person (
    id bigint DEFAULT nextval('socker.agent_id_seq') NOT NULL PRIMARY KEY,
    vatID text,
    info JSONb NOT NULL,   -- minimal is name_main + name_surname
    UNIQUE(vatID)
);

CREATE TABLE socker.telcom ( 
   id bigserial NOT NULL PRIMARY KEY,
   ttype integer NOT NULL CHECK(ttype>=1 AND ttype<=10), -- 1=telephone, 2=email, 3=url_home, 4=twiter, etc.
   tvalue text, -- the telecommunication "address" (URI) normalized value
   UNIQUE(ttype,tvalue)
);

CREATE TABLE socker.agent_telcom(
	agid bigint REFERENCES socker.agent(agid),
	id_telcom bigint REFERENCES socker.telcom(id),
	ismain boolean  DEFAULT false, -- only one main per (agid,ttype(id_telcom))
	isowner boolean,  -- null=no information, true=is the owner, false=is not. 
	rule int NOT NULL DEFAULT 0 CHECK(rule>=0 AND rule<100), -- 0=undef, 2=home, 3=work, 4=mobile, 5=corresp, etc.
	UNIQUE(agid,id_telcom)
);

-----
-----
-- GENERAL LIB

CREATE FUNCTION socker.telcom_ttype(bigint) RETURNS integer AS $func$
	SELECT ttype FROM socker.telcom WHERE id=$1;
$func$ LANGUAGE SQL IMMUTABLE;

CREATE OR REPLACE FUNCTION socker.name_join(JSONb, agtype integer) RETURNS text AS $func$
  SELECT $1->>'name_main' ||
         COALESCE(' ' || CASE WHEN $2=1 THEN $1->>'name_suffix' ELSE $1->>'name_surname' END, '')
  ;   
$func$ LANGUAGE SQL IMMUTABLE;

-----
-----
-- TRIGGERS

CREATE OR REPLACE FUNCTION socker.ctrl_agent_tg() RETURNS TRIGGER AS $func$
  -- 
  -- Copy ID to agent, or delete it.
  --  
DECLARE
    theid bigint;
    ttype int DEFAULT 2;
BEGIN
    IF TG_TABLE_NAME='organization' THEN ttype=1; END IF;
    IF TG_OP = 'INSERT' THEN
	theid = NEW.id;
        INSERT INTO socker.agent (agid,agtype,name) VALUES (theid,ttype,socker.name_join(NEW.info,ttype));
    	RETURN NEW;
    ELSE -- DELETE
	theid = OLD.id;
        DELETE FROM socker.agent WHERE agid = theid;
	RETURN OLD;
    END IF;
END;
$func$ LANGUAGE PLpgSQL;

CREATE TRIGGER org_agent_tg AFTER INSERT OR DELETE ON socker.organization 
	FOR EACH ROW EXECUTE PROCEDURE socker.ctrl_agent_tg()
;

CREATE TRIGGER person_agent_tg AFTER INSERT OR DELETE ON socker.person 
	FOR EACH ROW EXECUTE PROCEDURE socker.ctrl_agent_tg()
;


CREATE OR REPLACE FUNCTION socker.agentelcom_tg() RETURNS TRIGGER AS $func$
DECLARE
  refval int;
BEGIN
    IF NEW.ismain THEN
	refval :=  socker.telcom_ttype(NEW.id_telcom);
	UPDATE socker.agent_telcom 
	SET ismain=false 
	WHERE agid=NEW.agid AND ismain=true AND socker.telcom_ttype(id_telcom)=refval AND id_telcom!=NEW.id_telcom;
    END IF;
    RETURN NEW;
END;
$func$ LANGUAGE PLpgSQL;

CREATE TRIGGER agentelcom_tg AFTER INSERT OR UPDATE ON socker.agent_telcom 
	FOR EACH ROW EXECUTE PROCEDURE socker.agentelcom_tg()
;


-----
-----
-- COMPLEMENTAR VIEWS

CREATE VIEW socker.agent_telcom_full AS 
  SELECT t.*, a.* 
  FROM socker.telcom t INNER JOIN socker.agent_telcom a ON a.id_telcom=t.id
;

CREATE VIEW socker.agent_full AS
 SELECT a.*, p.vatid, p.info 
 FROM socker.agent a INNER JOIN socker.person p ON p.id=a.agid
 UNION
 SELECT a.*, o.vatid, o.info 
 FROM socker.agent a INNER JOIN socker.organization o ON o.id=a.agid
;

CREATE VIEW socker.agent_full_active AS
 SELECT a.*, p.vatid, p.info 
 FROM socker.agent a INNER JOIN socker.person p ON p.id=a.agid AND a.agstatus>0
 UNION
 SELECT a.*, o.vatid, o.info 
 FROM socker.agent a INNER JOIN socker.organization o ON o.id=a.agid AND a.agstatus>0
;


-----
-----
-- SOME TESTS

INSERT INTO socker.person (vatid,info) VALUES 
  ('2822828228','{"name_main":"Fernando Henrique","name_surname":"Silva"}'::JSONb),
  ('1111111111','{"name_main":"Marina","name_surname":"Silva"}'::JSONb)
;

INSERT INTO socker.organization (vatid,info) VALUES 
  ('2822828228','{"name_main":"Fernando & Brothers","name_suffix":"S.A."}'::JSONb),
  ('1111111111','{"name_main":"Coca Mirin","name_suffix":"L.T.D.A."}'::JSONb),
  ('2222222222','{"name_main":"3M","name_suffix":"S.A."}'::JSONb)
;
  
INSERT INTO socker.telcom (ttype,tvalue) VALUES 
	(1,'2345-2233'), (2,'mum@silvas.org.br'), (3,'http://mum.silvas.org.br')
;

INSERT INTO socker.telcom (ttype,tvalue) VALUES 
	(1,'2111-1111'), (2,'mum2@ggmmail.com'), (1,'2222-1111')
;

INSERT INTO socker.agent_telcom (agid,id_telcom,ismain) VALUES 
	(101,1,true), (101,2,true), (102,3,true)
;

INSERT INTO socker.agent_telcom (agid,id_telcom,ismain) VALUES 
	(101,3,true), (101,4,true), (102,5,true)
;


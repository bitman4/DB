-- PSQL DDL script 


CREATE DATABASE db_prod
    WITH
    ENCODING = 'UTF8'
    IS_TEMPLATE = False;

\c db_prod

CREATE ROLE admin;

CREATE USER usr1 WITH PASSWORD '12345678' ROLE admin;

CREATE SCHEMA IF NOT EXISTS prod
    AUTHORIZATION usr1;
	
CREATE TABLESPACE fast 
	OWNER usr1 
	LOCATION '/mnt/db_vol_1_ssd/';
	
CREATE TABLE IF NOT EXISTS prod.location_type
(
    id_location_type uuid NOT NULL,
    location_type "char" NOT NULL,
    CONSTRAINT pk_location_type PRIMARY KEY (id_location_type)
)
	TABLESPACE fast;

CREATE TABLE IF NOT EXISTS prod.location
(
    id_location uuid NOT NULL,
    fk_id_location_type uuid NOT NULL,
    location "char" NOT NULL,
    CONSTRAINT pk_location PRIMARY KEY (id_location)
)
	TABLESPACE fast;

CREATE TABLE IF NOT EXISTS prod.address
(
    id_address uuid NOT NULL,
    fk_id_city uuid NOT NULL,
    fk_id_district uuid NOT NULL,
    fk_id_location uuid NOT NULL,
    fk_id_housing uuid NOT NULL,
    apartment smallint,
    PRIMARY KEY (id_address)
)
	TABLESPACE fast;

CREATE TABLE IF NOT EXISTS prod.city
(
    id_city uuid NOT NULL,
    city "char" NOT NULL,
    PRIMARY KEY (id_city)
)
	TABLESPACE fast;


CREATE TABLE IF NOT EXISTS prod.district
(
    id_district uuid NOT NULL,
    district "char" NOT NULL,
    PRIMARY KEY (id_district)
)
	TABLESPACE fast;

CREATE TABLE IF NOT EXISTS prod.housing
(
    id_housing uuid NOT NULL,
    housing "char" NOT NULL,
    PRIMARY KEY (id_housing)
)
	TABLESPACE fast;

CREATE TABLE IF NOT EXISTS prod.customer
(
    id_customer uuid NOT NULL,
    fk_id_first_name uuid NOT NULL,
    fk_id_last_name uuid NOT NULL,
    fk_id_middle_name uuid,
    fk_id_customer_type uuid NOT NULL,
    fk_id_discount uuid NOT NULL,
    fk_id_subscription uuid NOT NULL,
    everage_check integer,
    birth_date date NOT NULL,
    height smallint,
    weight smallint,
    fk_id_hair_color uuid NOT NULL,
    fk_id_phototype_skin uuid NOT NULL,
    fk_id_address uuid NOT NULL,
    diseases text,
    fk_id_indications uuid NOT NULL,
    fk_id_contraindications uuid NOT NULL,
    instagram text,
    PRIMARY KEY (id_customer)
);

CREATE TABLE IF NOT EXISTS prod.first_name
(
    id_first_name uuid NOT NULL,
    first_name "char" NOT NULL,
    PRIMARY KEY (id_first_name)
);

CREATE TABLE IF NOT EXISTS prod.last_name
(
    id_last_name uuid NOT NULL,
    last_name "char" NOT NULL,
    PRIMARY KEY (id_last_name)
);

CREATE TABLE IF NOT EXISTS prod.middle_name
(
    id_middle_name uuid NOT NULL,
    middle_name "char" NOT NULL,
    PRIMARY KEY (id_middle_name)
);

CREATE TABLE IF NOT EXISTS prod.customer_type
(
    id_customer_type uuid NOT NULL,
    customer_type "char" NOT NULL,
    PRIMARY KEY (id_customer_type)
);

CREATE TABLE IF NOT EXISTS prod.subscription
(
    id_subscription uuid NOT NULL,
    subscription "char" NOT NULL,
    PRIMARY KEY (id_subscription)
);

CREATE TABLE IF NOT EXISTS prod.discount
(
    id_discount uuid NOT NULL,
    discount smallint NOT NULL,
    start_date date NOT NULL,
    end_date date NOT NULL,
    PRIMARY KEY (id_discount)
);

CREATE TABLE IF NOT EXISTS prod.hair_color
(
    id_hair_color uuid NOT NULL,
    hair_color "char" NOT NULL,
    PRIMARY KEY (id_hair_color)
);

CREATE TABLE IF NOT EXISTS prod.phototype_skin
(
    id_phototype_skin uuid NOT NULL,
    phototype_skin "char" NOT NULL,
    PRIMARY KEY (id_phototype_skin)
);

CREATE TABLE IF NOT EXISTS prod.indications
(
    id_indications uuid NOT NULL,
    indications "char" NOT NULL,
    PRIMARY KEY (id_indications)
);

CREATE TABLE IF NOT EXISTS prod.contraindications
(
    id_contraindications uuid NOT NULL,
    contraindications "char" NOT NULL,
    PRIMARY KEY (id_contraindications)
);

ALTER TABLE IF EXISTS prod.location
    ADD FOREIGN KEY (fk_id_location_type)
    REFERENCES prod.location_type (id_location_type) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS prod.address
    ADD FOREIGN KEY (fk_id_city)
    REFERENCES prod.city (id_city) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS prod.address
    ADD FOREIGN KEY (fk_id_district)
    REFERENCES prod.district (id_district) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS prod.address
    ADD FOREIGN KEY (fk_id_location)
    REFERENCES prod.location (id_location) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS prod.address
    ADD FOREIGN KEY (fk_id_housing)
    REFERENCES prod.housing (id_housing) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS prod.customer
    ADD FOREIGN KEY (fk_id_first_name)
    REFERENCES prod.first_name (id_first_name) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS prod.customer
    ADD FOREIGN KEY (fk_id_last_name)
    REFERENCES prod.last_name (id_last_name) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS prod.customer
    ADD FOREIGN KEY (fk_id_address)
    REFERENCES prod.address (id_address) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS prod.customer
    ADD FOREIGN KEY (fk_id_phototype_skin)
    REFERENCES prod.phototype_skin (id_phototype_skin) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS prod.customer
    ADD FOREIGN KEY (fk_id_middle_name)
    REFERENCES prod.middle_name (id_middle_name) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS prod.customer
    ADD FOREIGN KEY (fk_id_customer_type)
    REFERENCES prod.customer_type (id_customer_type) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS prod.customer
    ADD FOREIGN KEY (fk_id_discount)
    REFERENCES prod.discount (id_discount) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS prod.customer
    ADD FOREIGN KEY (fk_id_subscription)
    REFERENCES prod.subscription (id_subscription) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS prod.customer
    ADD FOREIGN KEY (fk_id_hair_color)
    REFERENCES prod.hair_color (id_hair_color) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS prod.customer
    ADD FOREIGN KEY (fk_id_indications)
    REFERENCES prod.indications (id_indications) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS prod.customer
    ADD FOREIGN KEY (fk_id_contraindications)
    REFERENCES prod.contraindications (id_contraindications) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

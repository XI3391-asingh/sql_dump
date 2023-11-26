--
-- PostgreSQL database dump
--

-- Dumped from database version 14.4
-- Dumped by pg_dump version 15.5 (Debian 15.5-0+deb12u1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: masterdata; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA masterdata;


ALTER SCHEMA masterdata OWNER TO postgres;

--
-- Name: masterdataservice; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA masterdataservice;


ALTER SCHEMA masterdataservice OWNER TO postgres;

--
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO postgres;

--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


--
-- Name: check_dedupe(character varying, character varying, character varying, date, character varying, character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.check_dedupe(countrycode character varying, mobilenumber character varying, fullname character varying, dateofbirth date, nationalidtypecode character varying, nationalid character varying, nationalitycode character varying) RETURNS TABLE(party_id bigint, status text, full_name text, first_name text, middle_name text, last_name text, gender text, date_of_birth timestamp without time zone, primary_mobile_number text, primary_email text, national_id_type_code text, national_id_type text, national_id text)
    LANGUAGE plpgsql
    AS $$
DECLARE
query_str text;
national_id_type_value text;
BEGIN

IF((mobilenumber IS NULL OR mobilenumber = '') AND (fullname IS NULL OR fullname = '')  AND (nationalid IS NULL OR nationalid = '') AND (nationalidtypecode IS NULL OR nationalidtypecode = '') AND (dateofbirth IS NULL))THEN
RAISE EXCEPTION 'INPUT PARAMETER EMPTY';
END IF;


IF((mobilenumber IS NOT NULL AND mobilenumber != '')  AND (countrycode IS NOT NULL AND countrycode != '') AND (mobilenumber IS NULL OR mobilenumber = ''))THEN
  RAISE EXCEPTION 'Mobile number and country code are required to identify dedupe !';
END IF;


IF((dateofbirth IS NOT NULL) AND ((fullname IS NULL OR fullname = '')))THEN
  RAISE EXCEPTION 'Date Of Birth and Full Name are required to identify dedupe !';
END IF;

IF((nationalidtypecode IS NOT NULL AND nationalidtypecode != '') AND (nationalid IS NOT NULL AND nationalid != ''))THEN
   SELECT UPPER(lm.description::text) AS national_id_type  INTO  national_id_type_value FROM lookup_master AS lm where code=''||nationalidtypecode||'' AND type = 'NATIONAL_ID_TYPE' AND is_active = true;
   
END IF;


IF((national_id_type_value IS NOT NULL AND national_id_type_value!='' AND national_id_type_value='PASSPORT') AND (nationalid IS NOT NULL AND nationalid!='')
    AND (nationalitycode IS NULL OR nationalitycode = '')) THEN
     RAISE EXCEPTION 'National Id type is PASSPORT then National Id, National Id type code and Nationality code is required to identify dedupe !';
END IF;

query_str:='SELECT p.party_id,p.status::text,p.full_name::text,p.first_name::text,p.middle_name::text,p.last_name::text,p.gender::text,p.date_of_birth,p.primary_mobile_number::text,
    		p.primary_email::text,p.national_id_type_code::text,nit.description::text AS national_id_type,p.national_id::text FROM party p
			LEFT JOIN lookup_master nit ON nit.type=p.national_id_type_code AND nit.type = ''NATIONAL_ID_TYPE'' AND nit.is_active = true
			WHERE 1=1';

IF(countrycode IS NOT NULL AND countrycode != '')THEN
query_str:=query_str||' AND p.country_residence_code  = '''||countrycode||''' ';
END IF;

IF(mobilenumber IS NOT NULL AND mobilenumber != '')THEN
query_str:=query_str||' AND p.primary_mobile_number = '''||mobilenumber||''' ';
END IF;

IF(fullname IS NOT NULL AND fullname != '')THEN
query_str:=query_str||' AND p.full_name  = '''||fullname||''' ';
END IF;

IF(dateofbirth IS NOT NULL)THEN
query_str:=query_str||' AND p.date_of_birth = '''||dateofbirth||''' ';
END IF;

IF(nationalid IS NOT NULL AND nationalid != '')THEN
query_str:=query_str||' AND p.national_id  = '''||nationalid||''' ';
END IF;

IF(nationalidtypecode IS NOT NULL AND nationalidtypecode != '')THEN
query_str:=query_str||' AND p.national_id_type_code = '''||nationalidtypecode||''' ';
END IF;

IF(nationalitycode IS NOT NULL AND nationalitycode != '')THEN
query_str:=query_str||' AND p.nationality_code = '''||nationalitycode||''' ';
END IF;

query_str:=query_str||'ORDER BY p.party_id';



RETURN QUERY EXECUTE query_str;

END;
$$;


ALTER FUNCTION public.check_dedupe(countrycode character varying, mobilenumber character varying, fullname character varying, dateofbirth date, nationalidtypecode character varying, nationalid character varying, nationalitycode character varying) OWNER TO postgres;

--
-- Name: address_master_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.address_master_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.address_master_id_seq OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: address_master; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.address_master (
    address_master_id bigint DEFAULT nextval('public.address_master_id_seq'::regclass) NOT NULL,
    type character varying(100) NOT NULL,
    code character varying(100) NOT NULL,
    description character varying(200),
    parent_type character varying(100),
    parent_code character varying(100),
    is_active boolean DEFAULT true,
    created_date timestamp without time zone DEFAULT now(),
    created_by character varying(50),
    modified_date timestamp without time zone,
    modified_by character varying(50)
);


ALTER TABLE public.address_master OWNER TO postgres;

--
-- Name: country_master_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.country_master_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.country_master_id_seq OWNER TO postgres;

--
-- Name: country_master; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.country_master (
    country_master_id bigint DEFAULT nextval('public.country_master_id_seq'::regclass) NOT NULL,
    code character varying(50) NOT NULL,
    description character varying(100),
    isd_code character varying(50),
    iso_code character varying(50),
    is_active boolean DEFAULT true,
    created_date timestamp without time zone DEFAULT now(),
    created_by character varying(50),
    modified_date timestamp without time zone,
    modified_by character varying(50)
);


ALTER TABLE public.country_master OWNER TO postgres;

--
-- Name: databasechangelog; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.databasechangelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255),
    deployment_id character varying(10)
);


ALTER TABLE public.databasechangelog OWNER TO postgres;

--
-- Name: databasechangeloglock; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


ALTER TABLE public.databasechangeloglock OWNER TO postgres;

--
-- Name: lookup_master_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.lookup_master_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.lookup_master_id_seq OWNER TO postgres;

--
-- Name: lookup_master; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.lookup_master (
    lookup_master_id bigint DEFAULT nextval('public.lookup_master_id_seq'::regclass) NOT NULL,
    type character varying(100) NOT NULL,
    code character varying(100) NOT NULL,
    description character varying(200),
    is_active boolean DEFAULT true,
    created_date timestamp without time zone DEFAULT now(),
    created_by character varying(50),
    modified_date timestamp without time zone,
    modified_by character varying(50)
);


ALTER TABLE public.lookup_master OWNER TO postgres;

--
-- Name: party_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.party_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.party_id_seq OWNER TO postgres;

--
-- Name: party; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.party (
    party_id bigint DEFAULT nextval('public.party_id_seq'::regclass) NOT NULL,
    type character varying(50) NOT NULL,
    salutation_code character varying(50) NOT NULL,
    full_name character varying(250) NOT NULL,
    first_name character varying(100) NOT NULL,
    middle_name character varying(100),
    last_name character varying(100),
    mother_maiden_name character varying(100),
    nick_name character varying(100),
    gender character varying(50) NOT NULL,
    date_of_birth timestamp without time zone NOT NULL,
    place_of_birth character varying(100) NOT NULL,
    country_birth_code character varying(50) NOT NULL,
    primary_mobile_number character varying(50) NOT NULL,
    primary_email character varying(100) NOT NULL,
    marital_status character varying(50) NOT NULL,
    status character varying(50) NOT NULL,
    country_residence_code character varying(50),
    residency_type_code character varying(50),
    education_type_code character varying(50),
    profession_code character varying(50),
    profession_type_code character varying(50),
    job_position_type_code character varying(50),
    industry_type_code character varying(50),
    nationality_code character varying(50),
    annual_income double precision,
    annual_turnover double precision,
    tax_id character varying(50),
    date_of_incorp timestamp without time zone,
    staff_code character varying(50),
    company_code character varying(50),
    group_code character varying(50),
    portfolio_code character varying(50),
    segment_type_code character varying(50),
    relation_type_code character varying(50),
    refferal_code character varying(50),
    promo_code character varying(50),
    national_id_type_code character varying(50),
    national_id character varying(50),
    aml_risk character varying(50),
    aml_risk_eval_date timestamp without time zone,
    aml_check_status boolean DEFAULT false NOT NULL,
    is_staff boolean,
    is_deceased boolean DEFAULT false NOT NULL,
    is_insolvency boolean DEFAULT false NOT NULL,
    is_npa boolean DEFAULT false NOT NULL,
    is_willful_defaulter boolean DEFAULT false NOT NULL,
    willful_defaulter_date timestamp without time zone,
    is_loan_overdue boolean DEFAULT false NOT NULL,
    is_suit_failed boolean DEFAULT false NOT NULL,
    is_pep boolean DEFAULT false NOT NULL,
    is_fatca_applicable boolean DEFAULT false NOT NULL,
    is_email_statement_reg boolean DEFAULT false NOT NULL,
    is_under_watchlist boolean DEFAULT false NOT NULL,
    is_deleted boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    created_by character varying(100),
    updated_at timestamp without time zone,
    updated_by character varying(100),
    created_by_channel character varying(100),
    updated_by_channel character varying(100),
    party_identifier character varying(50) DEFAULT public.uuid_generate_v4() NOT NULL
);


ALTER TABLE public.party OWNER TO postgres;

--
-- Name: party_account_mapping_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.party_account_mapping_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.party_account_mapping_id_seq OWNER TO postgres;

--
-- Name: party_address_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.party_address_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.party_address_id_seq OWNER TO postgres;

--
-- Name: party_address; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.party_address (
    party_address_id bigint DEFAULT nextval('public.party_address_id_seq'::regclass) NOT NULL,
    party_id bigint NOT NULL,
    address_type_code character varying(50) NOT NULL,
    address_line1 character varying(350) NOT NULL,
    address_line2 character varying(250) NOT NULL,
    address_line3 character varying(250),
    zip_code integer NOT NULL,
    is_default boolean,
    ward_code character varying(50),
    district_code character varying(50),
    city_code character varying(50),
    country_code character varying(50),
    document_id character varying(100)
);


ALTER TABLE public.party_address OWNER TO postgres;

--
-- Name: party_address_view; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.party_address_view AS
 SELECT pa.party_address_id,
    p.party_id,
    pa.address_type_code,
    a.description AS address_type,
    pa.address_line1,
    pa.address_line2,
    pa.address_line3,
    pa.zip_code AS city_zip_code,
    pa.is_default,
    pa.ward_code,
    w.description AS ward,
    pa.district_code,
    d.description AS district,
    pa.city_code,
    c.description AS city,
    pa.country_code,
    cm.description AS country_address,
    pa.document_id
   FROM ((((((public.party_address pa
     LEFT JOIN public.party p ON ((p.party_id = pa.party_id)))
     LEFT JOIN public.lookup_master a ON ((((pa.address_type_code)::text = (a.code)::text) AND ((a.type)::text = 'ADDRESS_TYPE'::text))))
     LEFT JOIN public.address_master c ON ((((pa.city_code)::text = (c.code)::text) AND ((c.type)::text = 'CITY'::text))))
     LEFT JOIN public.address_master d ON ((((pa.district_code)::text = (d.code)::text) AND ((d.type)::text = 'DISTRICT'::text))))
     LEFT JOIN public.address_master w ON ((((pa.ward_code)::text = (w.code)::text) AND ((w.type)::text = 'WARD'::text))))
     LEFT JOIN public.country_master cm ON (((pa.country_code)::text = (cm.code)::text)));


ALTER TABLE public.party_address_view OWNER TO postgres;

--
-- Name: party_asset_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.party_asset_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.party_asset_id_seq OWNER TO postgres;

--
-- Name: party_asset; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.party_asset (
    party_asset_id bigint DEFAULT nextval('public.party_asset_id_seq'::regclass) NOT NULL,
    party_id bigint,
    asset_type_code character varying(50),
    asset_name character varying(100),
    potential_value double precision,
    is_mortgaged boolean
);


ALTER TABLE public.party_asset OWNER TO postgres;

--
-- Name: party_asset_view; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.party_asset_view AS
 SELECT pas.party_asset_id,
    p.party_id,
    pas.asset_type_code,
    asst.description AS asset_type,
    pas.asset_name,
    pas.potential_value,
    pas.is_mortgaged
   FROM ((public.party_asset pas
     LEFT JOIN public.party p ON ((p.party_id = pas.party_id)))
     LEFT JOIN public.lookup_master asst ON ((((pas.asset_type_code)::text = (asst.code)::text) AND ((asst.type)::text = 'ASSET_TYPE'::text) AND (asst.is_active = true))));


ALTER TABLE public.party_asset_view OWNER TO postgres;

--
-- Name: party_contact_details_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.party_contact_details_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.party_contact_details_id_seq OWNER TO postgres;

--
-- Name: party_contact_details; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.party_contact_details (
    party_contact_details_id bigint DEFAULT nextval('public.party_contact_details_id_seq'::regclass) NOT NULL,
    party_id bigint NOT NULL,
    contact_type_code character varying(50),
    contact_value character varying(250),
    isd_code character varying(50),
    is_primary boolean,
    is_verified boolean,
    verified_mode character varying(50),
    last_verified_date timestamp without time zone,
    is_dnd boolean
);


ALTER TABLE public.party_contact_details OWNER TO postgres;

--
-- Name: party_contact_view; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.party_contact_view AS
 SELECT pc.party_contact_details_id,
    p.party_id,
    pc.contact_type_code,
    con.description AS contact_type,
    pc.contact_value,
    pc.isd_code,
    pc.is_primary,
    pc.is_verified,
    pc.verified_mode,
    (pc.last_verified_date)::date AS last_verified_date,
    pc.is_dnd
   FROM ((public.party_contact_details pc
     LEFT JOIN public.party p ON ((p.party_id = pc.party_id)))
     LEFT JOIN public.lookup_master con ON ((((pc.contact_type_code)::text = (con.code)::text) AND ((con.type)::text = 'CONTACT_TYPE'::text) AND (con.is_active = true))));


ALTER TABLE public.party_contact_view OWNER TO postgres;

--
-- Name: party_document_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.party_document_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.party_document_id_seq OWNER TO postgres;

--
-- Name: party_document; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.party_document (
    party_document_id bigint DEFAULT nextval('public.party_document_id_seq'::regclass) NOT NULL,
    party_id bigint,
    document_type_code character varying(50),
    document_number character varying(50),
    document_number_masked character varying(50),
    document_number_token character varying(100),
    issuing_date timestamp without time zone,
    expiry_date timestamp without time zone,
    issuing_place character varying(50),
    issuing_country_code character varying(50),
    is_poi boolean,
    is_poa boolean,
    dms_reference_id character varying(1000),
    verification_status character varying(50),
    additional_data character varying(1000)
);


ALTER TABLE public.party_document OWNER TO postgres;

--
-- Name: party_fatca_details_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.party_fatca_details_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.party_fatca_details_id_seq OWNER TO postgres;

--
-- Name: party_fatca_details; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.party_fatca_details (
    party_fatca_details_id bigint DEFAULT nextval('public.party_fatca_details_id_seq'::regclass) NOT NULL,
    party_id bigint,
    place_of_incorporation character varying(100),
    country_of_incorporation character varying(100),
    country_of_residence character varying(100),
    incorporation_number character varying(100),
    board_rel_number character varying(100),
    report_bl_number character varying(100),
    original_report_bl_number character varying(100),
    fatca_tax_id character varying(100),
    document_reference_id character varying(1000)
);


ALTER TABLE public.party_fatca_details OWNER TO postgres;

--
-- Name: party_guardian_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.party_guardian_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.party_guardian_id_seq OWNER TO postgres;

--
-- Name: party_guardian; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.party_guardian (
    party_guardian_id bigint DEFAULT nextval('public.party_guardian_id_seq'::regclass) NOT NULL,
    party_id bigint,
    guardian_first_name character varying(100),
    guardian_middle_name character varying(100),
    guardian_last_name character varying(100),
    guardian_address_line1 character varying(250),
    guardian_address_line2 character varying(100),
    guardian_address_line3 character varying(100),
    guardian_ward_code character varying(50),
    guardian_city_code character varying(50),
    guardian_district_code character varying(50),
    guardian_relation character varying(100)
);


ALTER TABLE public.party_guardian OWNER TO postgres;

--
-- Name: party_memo_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.party_memo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.party_memo_id_seq OWNER TO postgres;

--
-- Name: party_memo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.party_memo (
    party_memo_id bigint DEFAULT nextval('public.party_memo_id_seq'::regclass) NOT NULL,
    party_id bigint,
    memo_type_code character varying(50),
    severity character varying(50),
    risk_score double precision,
    valid_from timestamp without time zone,
    valid_until timestamp without time zone
);


ALTER TABLE public.party_memo OWNER TO postgres;

--
-- Name: party_relation_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.party_relation_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.party_relation_id_seq OWNER TO postgres;

--
-- Name: party_relation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.party_relation (
    party_relation_id bigint DEFAULT nextval('public.party_relation_id_seq'::regclass) NOT NULL,
    party_id bigint,
    secondary_party_id character varying(50),
    party_relation_type_code character varying(50),
    inv_relation character varying(50)
);


ALTER TABLE public.party_relation OWNER TO postgres;

--
-- Name: party_risk_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.party_risk_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.party_risk_id_seq OWNER TO postgres;

--
-- Name: party_risk; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.party_risk (
    party_risk_id bigint DEFAULT nextval('public.party_risk_id_seq'::regclass) NOT NULL,
    party_id bigint,
    risk_type_code character varying(50),
    risk_score double precision,
    evaluation_date timestamp without time zone,
    valid_until timestamp without time zone
);


ALTER TABLE public.party_risk OWNER TO postgres;

--
-- Name: party_xref_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.party_xref_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.party_xref_id_seq OWNER TO postgres;

--
-- Name: party_xref; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.party_xref (
    party_xref_id bigint DEFAULT nextval('public.party_xref_id_seq'::regclass) NOT NULL,
    party_id bigint,
    system_code character varying(50),
    xref_id character varying(50)
);


ALTER TABLE public.party_xref OWNER TO postgres;

--
-- Name: party_details_view; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.party_details_view AS
 SELECT p.party_id,
    p.party_identifier,
    p.type,
    p.salutation_code,
    sc.description AS salutation,
    p.full_name,
    p.first_name,
    p.middle_name,
    p.last_name,
    p.mother_maiden_name,
    p.nick_name,
    p.gender,
    p.date_of_birth,
    p.place_of_birth,
    p.country_birth_code,
    cbc.description AS country_of_birth,
    p.primary_mobile_number,
    p.primary_email,
    p.marital_status,
    p.status,
    p.country_residence_code,
    crc.description AS country_residence,
    p.residency_type_code,
    rtc.description AS residency_type,
    p.education_type_code,
    etc.description AS education_type,
    p.profession_code,
    pro.description AS profession,
    p.profession_type_code,
    pt.description AS profession_type,
    p.job_position_type_code,
    jp.description AS job_position,
    p.industry_type_code,
    itc.description AS industry_type,
    p.nationality_code,
    nc.description AS nationality,
    p.annual_income,
    p.annual_turnover,
    p.tax_id,
    p.date_of_incorp,
    p.staff_code,
    p.company_code,
    com.description AS company,
    p.group_code,
    p.portfolio_code,
    p.segment_type_code,
    seg.description AS segment,
    p.relation_type_code,
    rt.description AS relation_type,
    p.refferal_code,
    p.promo_code,
    p.national_id_type_code,
    nit.description AS national_id_type,
    p.national_id,
    p.aml_risk_eval_date,
    p.aml_risk,
    p.aml_check_status,
    p.is_staff,
    p.is_deceased,
    p.is_insolvency,
    p.is_npa,
    p.is_willful_defaulter,
    p.willful_defaulter_date,
    p.is_loan_overdue,
    p.is_suit_failed,
    p.is_pep,
    p.is_fatca_applicable,
    p.is_email_statement_reg,
    p.is_under_watchlist,
    p.is_deleted,
    p.created_at,
    p.created_by,
    p.updated_at,
    p.updated_by,
    p.created_by_channel,
    p.updated_by_channel,
    pa.party_address_id,
    pa.address_type_code,
    a.description AS address_type,
    pa.address_line1,
    pa.address_line2,
    pa.address_line3,
    pa.zip_code,
    pa.is_default,
    pa.ward_code,
    w.description AS ward,
    pa.district_code,
    d.description AS district,
    pa.city_code,
    c.description AS city,
    pa.country_code,
    cm.description AS country_address,
    pa.document_id,
    pc.party_contact_details_id,
    pc.contact_type_code,
    con.description AS contact_type,
    pc.contact_value,
    pc.isd_code,
    pc.is_primary,
    pc.is_verified,
    pc.verified_mode,
    pc.last_verified_date,
    pc.is_dnd,
    pas.party_asset_id,
    pas.asset_type_code,
    asst.description AS asset_type,
    pas.asset_name,
    pas.potential_value,
    pas.is_mortgaged,
    prc.party_risk_id,
    prc.risk_type_code,
    ctmrtc.description AS risk_type,
    prc.risk_score,
    prc.evaluation_date,
    prc.valid_until,
    pm.party_memo_id,
    pm.memo_type_code,
    ctmpm.description AS memo_type,
    pm.severity,
    pm.risk_score AS score,
    pm.valid_from,
    pm.valid_until AS valid_to,
    pd.party_document_id,
    pd.document_type_code,
    ctmpd.description AS document_type,
    pd.document_number,
    pd.document_number_masked,
    pd.document_number_token,
    pd.issuing_date,
    pd.expiry_date,
    pd.issuing_place,
    pd.issuing_country_code,
    cmpd.description AS issuing_country,
    pd.is_poi,
    pd.is_poa,
    pd.dms_reference_id,
    pd.verification_status,
    pd.additional_data,
    prel.party_relation_id,
    prel.secondary_party_id,
    prel.party_relation_type_code,
    ctmprel.description AS party_relation_type,
    prel.inv_relation,
    px.party_xref_id,
    px.system_code,
    px.xref_id,
    fd.party_fatca_details_id,
    fd.place_of_incorporation,
    fd.country_of_incorporation,
    fd.country_of_residence,
    fd.incorporation_number,
    fd.board_rel_number,
    fd.report_bl_number,
    fd.original_report_bl_number,
    fd.fatca_tax_id,
    fd.document_reference_id,
    pg.party_guardian_id,
    pg.guardian_first_name,
    pg.guardian_middle_name,
    pg.guardian_last_name,
    pg.guardian_relation,
    pg.guardian_address_line1,
    pg.guardian_address_line2,
    pg.guardian_address_line3,
    pg.guardian_ward_code,
    pgw.description AS guardian_ward,
    pg.guardian_district_code,
    pgd.description AS guardian_district,
    pg.guardian_city_code,
    pgpr.description AS guardian_city
   FROM (((((((((((((((((((((((((((((((((((((((public.party p
     LEFT JOIN public.country_master cbc ON ((((p.country_birth_code)::text = (cbc.code)::text) AND (cbc.is_active = true))))
     LEFT JOIN public.country_master crc ON ((((p.country_residence_code)::text = (crc.code)::text) AND (crc.is_active = true))))
     LEFT JOIN public.lookup_master com ON ((((p.company_code)::text = (com.code)::text) AND ((com.type)::text = 'COMPANY_TYPE'::text) AND (com.is_active = true))))
     LEFT JOIN public.lookup_master rtc ON ((((p.residency_type_code)::text = (rtc.code)::text) AND ((rtc.type)::text = 'RESIDENCY_TYPE'::text) AND (rtc.is_active = true))))
     LEFT JOIN public.lookup_master etc ON ((((p.education_type_code)::text = (etc.code)::text) AND ((etc.type)::text = 'EDUCATION_TYPE'::text) AND (etc.is_active = true))))
     LEFT JOIN public.lookup_master itc ON ((((p.industry_type_code)::text = (itc.code)::text) AND ((itc.type)::text = 'INDUSTRY_TYPE'::text) AND (itc.is_active = true))))
     LEFT JOIN public.lookup_master nc ON ((((p.nationality_code)::text = (nc.code)::text) AND ((nc.type)::text = 'NATIONALITY'::text) AND (nc.is_active = true))))
     LEFT JOIN public.lookup_master sc ON ((((p.salutation_code)::text = (sc.code)::text) AND ((sc.type)::text = 'SALUTATION'::text) AND (sc.is_active = true))))
     LEFT JOIN public.lookup_master rt ON ((((p.relation_type_code)::text = (rt.code)::text) AND ((rt.type)::text = 'RELATION_TYPE'::text) AND (rt.is_active = true))))
     LEFT JOIN public.lookup_master pt ON ((((p.profession_type_code)::text = (pt.code)::text) AND ((pt.type)::text = 'PROFESSION_TYPE'::text) AND (pt.is_active = true))))
     LEFT JOIN public.lookup_master pro ON ((((p.profession_code)::text = (pro.code)::text) AND ((pro.type)::text = 'PROFESSION'::text) AND (pro.is_active = true))))
     LEFT JOIN public.lookup_master seg ON ((((p.segment_type_code)::text = (seg.code)::text) AND ((seg.type)::text = 'PARTY_SEGMENT'::text) AND (seg.is_active = true))))
     LEFT JOIN public.lookup_master nit ON ((((p.national_id_type_code)::text = (nit.code)::text) AND ((nit.type)::text = 'NATIONAL_ID_TYPE'::text) AND (nit.is_active = true))))
     LEFT JOIN public.lookup_master jp ON ((((p.job_position_type_code)::text = (jp.code)::text) AND ((jp.type)::text = 'JOB_POSITION'::text) AND (jp.is_active = true))))
     LEFT JOIN public.party_address pa ON ((p.party_id = pa.party_id)))
     LEFT JOIN public.lookup_master a ON ((((pa.address_type_code)::text = (a.code)::text) AND ((a.type)::text = 'ADDRESS_TYPE'::text))))
     LEFT JOIN public.address_master c ON ((((pa.city_code)::text = (c.code)::text) AND ((c.type)::text = 'CITY'::text))))
     LEFT JOIN public.address_master d ON ((((pa.district_code)::text = (d.code)::text) AND ((d.type)::text = 'DISTRICT'::text))))
     LEFT JOIN public.address_master w ON ((((pa.ward_code)::text = (w.code)::text) AND ((w.type)::text = 'WARD'::text))))
     LEFT JOIN public.country_master cm ON (((pa.country_code)::text = (cm.code)::text)))
     LEFT JOIN public.party_contact_details pc ON ((p.party_id = pc.party_id)))
     LEFT JOIN public.lookup_master con ON ((((pc.contact_type_code)::text = (con.code)::text) AND ((con.type)::text = 'CONTACT_TYPE'::text) AND (con.is_active = true))))
     LEFT JOIN public.party_asset pas ON ((p.party_id = pas.party_id)))
     LEFT JOIN public.lookup_master asst ON ((((pas.asset_type_code)::text = (asst.code)::text) AND ((asst.type)::text = 'ASSET_TYPE'::text) AND (asst.is_active = true))))
     LEFT JOIN public.party_risk prc ON ((p.party_id = prc.party_id)))
     LEFT JOIN public.lookup_master ctmrtc ON ((((prc.risk_type_code)::text = (ctmrtc.code)::text) AND ((ctmrtc.type)::text = 'RISK_CATEGORY'::text) AND (ctmrtc.is_active = true))))
     LEFT JOIN public.party_memo pm ON ((p.party_id = pm.party_id)))
     LEFT JOIN public.lookup_master ctmpm ON ((((pm.memo_type_code)::text = (ctmpm.code)::text) AND ((ctmpm.type)::text = 'MEMO_TYPE'::text) AND (ctmpm.is_active = true))))
     LEFT JOIN public.party_document pd ON ((p.party_id = pd.party_id)))
     LEFT JOIN public.lookup_master ctmpd ON ((((pd.document_type_code)::text = (ctmpd.code)::text) AND ((ctmpd.type)::text = 'DOCUMENT_TYPE'::text) AND (ctmpd.is_active = true))))
     LEFT JOIN public.country_master cmpd ON ((((pd.issuing_country_code)::text = (cmpd.code)::text) AND (cmpd.is_active = true))))
     LEFT JOIN public.party_relation prel ON ((p.party_id = prel.party_id)))
     LEFT JOIN public.lookup_master ctmprel ON ((((prel.party_relation_type_code)::text = (ctmprel.code)::text) AND ((ctmprel.type)::text = 'RELATION_TYPE'::text) AND (ctmprel.is_active = true))))
     LEFT JOIN public.party_xref px ON ((p.party_id = px.party_id)))
     LEFT JOIN public.party_fatca_details fd ON ((p.party_id = fd.party_id)))
     LEFT JOIN public.party_guardian pg ON ((p.party_id = pg.party_id)))
     LEFT JOIN public.address_master pgw ON ((((pg.guardian_ward_code)::text = (pgw.code)::text) AND ((pgw.type)::text = 'WARD'::text) AND (pgw.is_active = true))))
     LEFT JOIN public.address_master pgd ON ((((pg.guardian_district_code)::text = (pgd.code)::text) AND ((pgd.type)::text = 'DISTRICT'::text) AND (pgd.is_active = true))))
     LEFT JOIN public.address_master pgpr ON ((((pg.guardian_city_code)::text = (pgpr.code)::text) AND ((pgpr.type)::text = 'CITY'::text) AND (pgpr.is_active = true))));


ALTER TABLE public.party_details_view OWNER TO postgres;

--
-- Name: party_document_view; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.party_document_view AS
 SELECT pd.party_document_id,
    p.party_id,
    pd.document_type_code,
    ctmpd.description AS document_type,
    pd.document_number,
    pd.document_number_masked,
    pd.document_number_token,
    (pd.issuing_date)::date AS issuing_date,
    (pd.expiry_date)::date AS expiry_date,
    pd.issuing_place,
    pd.issuing_country_code,
    cmpd.description AS issuing_country,
    pd.is_poi,
    pd.is_poa,
    pd.dms_reference_id,
    pd.verification_status,
    pd.additional_data
   FROM (((public.party_document pd
     LEFT JOIN public.party p ON ((p.party_id = pd.party_id)))
     LEFT JOIN public.lookup_master ctmpd ON ((((pd.document_type_code)::text = (ctmpd.code)::text) AND ((ctmpd.type)::text = 'DOCUMENT_TYPE'::text) AND (ctmpd.is_active = true))))
     LEFT JOIN public.country_master cmpd ON ((((pd.issuing_country_code)::text = (cmpd.code)::text) AND (cmpd.is_active = true))));


ALTER TABLE public.party_document_view OWNER TO postgres;

--
-- Name: party_fatca_details_view; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.party_fatca_details_view AS
 SELECT fd.party_fatca_details_id,
    p.party_id,
    fd.place_of_incorporation,
    fd.country_of_incorporation,
    fd.country_of_residence,
    fd.incorporation_number,
    fd.board_rel_number,
    fd.report_bl_number,
    fd.original_report_bl_number,
    fd.fatca_tax_id,
    fd.document_reference_id
   FROM (public.party_fatca_details fd
     LEFT JOIN public.party p ON ((p.party_id = fd.party_id)));


ALTER TABLE public.party_fatca_details_view OWNER TO postgres;

--
-- Name: party_guardian_view; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.party_guardian_view AS
 SELECT pg.party_guardian_id,
    p.party_id,
    pg.guardian_first_name,
    pg.guardian_middle_name,
    pg.guardian_last_name,
    pg.guardian_relation,
    pg.guardian_address_line1,
    pg.guardian_address_line2,
    pg.guardian_address_line3,
    pg.guardian_ward_code,
    pgw.description AS guardian_ward,
    pg.guardian_district_code,
    pgd.description AS guardian_district,
    pg.guardian_city_code,
    pgpr.description AS guardian_city
   FROM ((((public.party_guardian pg
     LEFT JOIN public.party p ON ((p.party_id = pg.party_id)))
     LEFT JOIN public.address_master pgw ON ((((pg.guardian_ward_code)::text = (pgw.code)::text) AND ((pgw.type)::text = 'WARD'::text) AND (pgw.is_active = true))))
     LEFT JOIN public.address_master pgd ON ((((pg.guardian_district_code)::text = (pgd.code)::text) AND ((pgd.type)::text = 'DISTRICT'::text) AND (pgd.is_active = true))))
     LEFT JOIN public.address_master pgpr ON ((((pg.guardian_city_code)::text = (pgpr.code)::text) AND ((pgpr.type)::text = 'CITY'::text) AND (pgpr.is_active = true))));


ALTER TABLE public.party_guardian_view OWNER TO postgres;

--
-- Name: party_memo_view; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.party_memo_view AS
 SELECT pm.party_memo_id,
    p.party_id,
    pm.memo_type_code,
    ctmpm.description AS memo_type,
    pm.severity,
    pm.risk_score AS score,
    (pm.valid_from)::date AS valid_from,
    (pm.valid_until)::date AS valid_to
   FROM ((public.party_memo pm
     LEFT JOIN public.party p ON ((p.party_id = pm.party_id)))
     LEFT JOIN public.lookup_master ctmpm ON ((((pm.memo_type_code)::text = (ctmpm.code)::text) AND ((ctmpm.type)::text = 'MEMO_TYPE'::text) AND (ctmpm.is_active = true))));


ALTER TABLE public.party_memo_view OWNER TO postgres;

--
-- Name: party_relation_view; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.party_relation_view AS
 SELECT prel.party_relation_id,
    p.party_id,
    prel.secondary_party_id,
    prel.party_relation_type_code,
    ctmprel.description AS party_relation_type,
    prel.inv_relation
   FROM ((public.party_relation prel
     LEFT JOIN public.party p ON ((p.party_id = prel.party_id)))
     LEFT JOIN public.lookup_master ctmprel ON ((((prel.party_relation_type_code)::text = (ctmprel.code)::text) AND ((ctmprel.type)::text = 'RELATION_TYPE'::text) AND (ctmprel.is_active = true))));


ALTER TABLE public.party_relation_view OWNER TO postgres;

--
-- Name: party_risk_view; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.party_risk_view AS
 SELECT prc.party_risk_id,
    p.party_id,
    prc.risk_type_code,
    ctmrtc.description AS risk_type,
    prc.risk_score,
    (prc.evaluation_date)::date AS evaluation_date,
    (prc.valid_until)::date AS valid_until
   FROM ((public.party_risk prc
     LEFT JOIN public.party p ON ((p.party_id = prc.party_id)))
     LEFT JOIN public.lookup_master ctmrtc ON ((((prc.risk_type_code)::text = (ctmrtc.code)::text) AND ((ctmrtc.type)::text = 'RISK_CATEGORY'::text) AND (ctmrtc.is_active = true))));


ALTER TABLE public.party_risk_view OWNER TO postgres;

--
-- Name: party_view; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.party_view AS
 SELECT p.party_id,
    p.party_identifier,
    p.type,
    p.salutation_code,
    sc.description AS salutation,
    p.full_name,
    p.first_name,
    p.middle_name,
    p.last_name,
    p.mother_maiden_name,
    p.nick_name,
    p.gender,
    p.date_of_birth,
    p.place_of_birth,
    p.country_birth_code,
    cbc.description AS country_of_birth,
    p.primary_mobile_number,
    p.primary_email,
    p.marital_status,
    p.status,
    p.country_residence_code,
    crc.description AS country_residence,
    p.residency_type_code,
    rtc.description AS residency_type,
    p.education_type_code,
    etc.description AS education_type,
    p.profession_code,
    pro.description AS profession,
    p.profession_type_code,
    pt.description AS profession_type,
    p.job_position_type_code,
    jp.description AS job_position,
    p.industry_type_code,
    itc.description AS industry_type,
    p.nationality_code,
    nc.description AS nationality,
    p.annual_income,
    p.annual_turnover,
    p.tax_id,
    p.date_of_incorp,
    p.staff_code,
    p.company_code,
    com.description AS company,
    p.group_code,
    p.portfolio_code,
    p.segment_type_code,
    seg.description AS segment,
    p.relation_type_code,
    rt.description AS relation_type,
    p.refferal_code,
    p.promo_code,
    p.national_id_type_code,
    nit.description AS national_id_type,
    p.national_id,
    p.aml_risk_eval_date,
    p.aml_risk,
    p.aml_check_status,
    p.is_staff,
    p.is_deceased,
    p.is_insolvency,
    p.is_npa,
    p.is_willful_defaulter,
    p.willful_defaulter_date,
    p.is_loan_overdue,
    p.is_suit_failed,
    p.is_pep,
    p.is_fatca_applicable,
    p.is_email_statement_reg,
    p.is_under_watchlist,
    p.is_deleted,
    p.created_at,
    p.created_by,
    p.updated_at,
    p.updated_by,
    p.created_by_channel,
    p.updated_by_channel
   FROM ((((((((((((((public.party p
     LEFT JOIN public.country_master cbc ON ((((p.country_birth_code)::text = (cbc.code)::text) AND (cbc.is_active = true))))
     LEFT JOIN public.country_master crc ON ((((p.country_residence_code)::text = (crc.code)::text) AND (crc.is_active = true))))
     LEFT JOIN public.lookup_master com ON ((((p.company_code)::text = (com.code)::text) AND ((com.type)::text = 'COMPANY_TYPE'::text) AND (com.is_active = true))))
     LEFT JOIN public.lookup_master rtc ON ((((p.residency_type_code)::text = (rtc.code)::text) AND ((rtc.type)::text = 'RESIDENCY_TYPE'::text) AND (rtc.is_active = true))))
     LEFT JOIN public.lookup_master etc ON ((((p.education_type_code)::text = (etc.code)::text) AND ((etc.type)::text = 'EDUCATION_TYPE'::text) AND (etc.is_active = true))))
     LEFT JOIN public.lookup_master itc ON ((((p.industry_type_code)::text = (itc.code)::text) AND ((itc.type)::text = 'INDUSTRY_TYPE'::text) AND (itc.is_active = true))))
     LEFT JOIN public.lookup_master nc ON ((((p.nationality_code)::text = (nc.code)::text) AND ((nc.type)::text = 'NATIONALITY'::text) AND (nc.is_active = true))))
     LEFT JOIN public.lookup_master sc ON ((((p.salutation_code)::text = (sc.code)::text) AND ((sc.type)::text = 'SALUTATION'::text) AND (sc.is_active = true))))
     LEFT JOIN public.lookup_master rt ON ((((p.relation_type_code)::text = (rt.code)::text) AND ((rt.type)::text = 'RELATION_TYPE'::text) AND (rt.is_active = true))))
     LEFT JOIN public.lookup_master pt ON ((((p.profession_type_code)::text = (pt.code)::text) AND ((pt.type)::text = 'PROFESSION_TYPE'::text) AND (pt.is_active = true))))
     LEFT JOIN public.lookup_master pro ON ((((p.profession_code)::text = (pro.code)::text) AND ((pro.type)::text = 'PROFESSION'::text) AND (pro.is_active = true))))
     LEFT JOIN public.lookup_master seg ON ((((p.segment_type_code)::text = (seg.code)::text) AND ((seg.type)::text = 'PARTY_SEGMENT'::text) AND (seg.is_active = true))))
     LEFT JOIN public.lookup_master nit ON ((((p.national_id_type_code)::text = (nit.code)::text) AND ((nit.type)::text = 'NATIONAL_ID_TYPE'::text) AND (nit.is_active = true))))
     LEFT JOIN public.lookup_master jp ON ((((p.job_position_type_code)::text = (jp.code)::text) AND ((jp.type)::text = 'JOB_POSITION'::text) AND (jp.is_active = true))));


ALTER TABLE public.party_view OWNER TO postgres;

--
-- Name: party_xref_view; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.party_xref_view AS
 SELECT px.party_xref_id,
    p.party_id,
    px.system_code,
    csc.description AS system_name,
    px.xref_id
   FROM ((public.party_xref px
     LEFT JOIN public.party p ON ((p.party_id = px.party_id)))
     LEFT JOIN public.lookup_master csc ON ((((px.system_code)::text = (csc.code)::text) AND ((csc.type)::text = 'INTEGRATION_TYPE'::text))));


ALTER TABLE public.party_xref_view OWNER TO postgres;

--
-- Data for Name: address_master; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.address_master (address_master_id, type, code, description, parent_type, parent_code, is_active, created_date, created_by, modified_date, modified_by) FROM stdin;
25	WARD	03	Singapore	CITY	03	t	2022-09-13 10:42:53.185373	\N	\N	\N
17	CITY	01	Kampong Pinang	COUNTRY	01	t	2022-09-07 07:57:33.274704	\N	\N	\N
18	CITY	02	Jalan Kayu	COUNTRY	01	t	2022-09-07 07:57:33.274704	\N	\N	\N
23	DISTRICT	01	Jurong	WARD	01	t	2022-09-07 07:57:33.274704	\N	\N	\N
24	DISTRICT	02	Changi loyang	WARD	02	t	2022-09-07 07:57:33.274704	\N	\N	\N
22	WARD	02	Bukit batok	CITY	02	t	2022-09-07 07:57:33.274704	\N	\N	\N
19	CITY	03	Boon lay	COUNTRY	02	t	2022-09-07 07:57:33.274704	\N	\N	\N
99	WARD	2	Haiphong	CITY	2	t	2023-01-17 04:09:57.625442	\N	\N	\N
21	WARD	01	Marymount	CITY	01	t	2022-09-07 07:57:33.274704	\N	\N	\N
20	CITY	04	Hougang	COUNTRY	02	t	2022-09-07 07:57:33.274704	\N	\N	\N
98	WARD	1	Hanoi	1	CITY	t	2023-01-17 04:09:57.625442	\N	2023-01-24 04:13:55.526	\N
100	COUNTRY	033	King, US			t	2023-06-09 08:34:16.644	\N	2023-06-09 08:37:19.786	\N
101	CITY	53	Washington	COUNTRY	033	t	2023-06-09 08:34:43.008	\N	2023-06-09 08:37:40.837	\N
102	DISTRICT	63000	Seattle	53	CITY	t	2023-06-09 08:35:24.987	\N	2023-06-09 08:37:52.737	\N
\.


--
-- Data for Name: country_master; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.country_master (country_master_id, code, description, isd_code, iso_code, is_active, created_date, created_by, modified_date, modified_by) FROM stdin;
5	01	Vietnam	+84	VNM	t	2022-09-07 07:57:33.274704	\N	\N	\N
6	02	Singapore	+65	SG	t	2022-09-07 07:57:33.274704	\N	\N	\N
31	1	Vietnam	84	VNM	t	2023-06-01 09:12:44.084413	\N	\N	\N
32	2	Singapore	65	SG	t	2023-06-01 09:12:44.084413	\N	\N	\N
33	03	United States	+1	US	t	2023-06-09 07:21:50.749	\N	2023-06-09 07:22:41.648	\N
34	04	India	+91	IND	t	2023-07-10 11:00:41.437	\N	\N	\N
\.


--
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
raw	includeAll	db/001_MASTERS_DDL.sql	2022-09-06 14:57:44.112421	1	EXECUTED	8:acdaf499e828ee3e8c7c18abdc74f594	sql		\N	4.9.1	\N	\N	2476261817
raw	includeAll	db/002_MASTER_DML.sql	2022-09-06 14:57:46.716868	2	EXECUTED	8:3c6f2f02661e7241e1be45f3b80a1c17	sql		\N	4.9.1	\N	\N	2476261817
raw	includeAll	db/003_CIF_DDL.sql	2022-09-06 14:57:47.314572	3	EXECUTED	8:8fa6fa85e2076b76f263a740199e92f5	sql		\N	4.9.1	\N	\N	2476261817
raw	includeAll	db/004_CIF_VIEW.sql	2022-09-06 14:57:48.219586	4	EXECUTED	8:82ebecea9a49601d59b04a901e5e0c04	sql		\N	4.9.1	\N	\N	2476261817
1	Manoj	db/005_CIF_FUNCTION.sql	2022-09-06 14:57:48.6118	5	EXECUTED	8:ef53d25f6c33f2545da916520b178346	sql		\N	4.9.1	\N	\N	2476261817
\.


--
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
1	t	2022-09-07 07:02:13.614571	cif-service-67d999fb96-hsh5t (172.16.16.96)
\.


--
-- Data for Name: lookup_master; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.lookup_master (lookup_master_id, type, code, description, is_active, created_date, created_by, modified_date, modified_by) FROM stdin;
121	ADDRESS_TYPE	01	Permanent Address	t	2022-09-07 07:57:33.274704	\N	\N	\N
123	ADDRESS_TYPE	03	Office address	t	2022-09-07 07:57:33.274704	\N	\N	\N
124	ADDRESS_TYPE	04	Temporary address	t	2022-09-07 07:57:33.274704	\N	\N	\N
125	CONTACT_TYPE	01	Mobile	t	2022-09-07 07:57:33.274704	\N	\N	\N
126	CONTACT_TYPE	02	Email	t	2022-09-07 07:57:33.274704	\N	\N	\N
127	CONTACT_TYPE	03	Facebook	t	2022-09-07 07:57:33.274704	\N	\N	\N
128	CONTACT_TYPE	04	Twitter	t	2022-09-07 07:57:33.274704	\N	\N	\N
129	CONTACT_TYPE	05	Fax	t	2022-09-07 07:57:33.274704	\N	\N	\N
130	PARTY_SEGMENT	01	Segment01	t	2022-09-07 07:57:33.274704	\N	\N	\N
131	PARTY_SEGMENT	02	Segment02	t	2022-09-07 07:57:33.274704	\N	\N	\N
132	COMPANY_TYPE	01	Vietnam Electricity	t	2022-09-07 07:57:33.274704	\N	\N	\N
133	COMPANY_TYPE	02	Sioux High Pvt. 	t	2022-09-07 07:57:33.274704	\N	\N	\N
134	RESIDENCY_TYPE	01	Vietnam Residency 1	t	2022-09-07 07:57:33.274704	\N	\N	\N
135	RESIDENCY_TYPE	02	Vietnam Residency 2	t	2022-09-07 07:57:33.274704	\N	\N	\N
136	RESIDENCY_TYPE	03	Singaporean Residency 1	t	2022-09-07 07:57:33.274704	\N	\N	\N
137	RESIDENCY_TYPE	04	Singaporean Residency 2	t	2022-09-07 07:57:33.274704	\N	\N	\N
138	EDUCATION_TYPE	01	Postgraduate	t	2022-09-07 07:57:33.274704	\N	\N	\N
139	EDUCATION_TYPE	02	Undergraduate	t	2022-09-07 07:57:33.274704	\N	\N	\N
140	EDUCATION_TYPE	03	Doctorate	t	2022-09-07 07:57:33.274704	\N	\N	\N
141	EDUCATION_TYPE	04	Phd	t	2022-09-07 07:57:33.274704	\N	\N	\N
142	INDUSTRY_TYPE	01	Textiles	t	2022-09-07 07:57:33.274704	\N	\N	\N
143	INDUSTRY_TYPE	02	Food processing	t	2022-09-07 07:57:33.274704	\N	\N	\N
144	INDUSTRY_TYPE	03	Banking	t	2022-09-07 07:57:33.274704	\N	\N	\N
145	INDUSTRY_TYPE	04	IT	t	2022-09-07 07:57:33.274704	\N	\N	\N
146	INDUSTRY_TYPE	05	Government Service	t	2022-09-07 07:57:33.274704	\N	\N	\N
147	NATIONALITY	01	Vietnamese	t	2022-09-07 07:57:33.274704	\N	\N	\N
148	NATIONALITY	02	Indian	t	2022-09-07 07:57:33.274704	\N	\N	\N
150	SALUTATION	01	Mr.	t	2022-09-07 07:57:33.274704	\N	\N	\N
151	SALUTATION	02	Ms.	t	2022-09-07 07:57:33.274704	\N	\N	\N
152	SALUTATION	03	Dr.	t	2022-09-07 07:57:33.274704	\N	\N	\N
153	RISK_CATEGORY	01	Low	t	2022-09-07 07:57:33.274704	\N	\N	\N
154	RISK_CATEGORY	02	High	t	2022-09-07 07:57:33.274704	\N	\N	\N
155	RELATION_TYPE	01	Relation 1	t	2022-09-07 07:57:33.274704	\N	\N	\N
156	RELATION_TYPE	02	Relation 2	t	2022-09-07 07:57:33.274704	\N	\N	\N
157	PROFESSION_TYPE	01	Business analyst	t	2022-09-07 07:57:33.274704	\N	\N	\N
158	PROFESSION_TYPE	02	Designer	t	2022-09-07 07:57:33.274704	\N	\N	\N
159	PROFESSION_TYPE	03	Full Time	t	2022-09-07 07:57:33.274704	\N	\N	\N
160	PROFESSION_TYPE	04	Part Time	t	2022-09-07 07:57:33.274704	\N	\N	\N
161	PROFESSION	01	Managers	t	2022-09-07 07:57:33.274704	\N	\N	\N
162	PROFESSION	02	Technicians 	t	2022-09-07 07:57:33.274704	\N	\N	\N
163	PROFESSION	03	Salaried 	t	2022-09-07 07:57:33.274704	\N	\N	\N
164	PROFESSION	04	Self Employed	t	2022-09-07 07:57:33.274704	\N	\N	\N
165	PROFESSION	05	Government Service	t	2022-09-07 07:57:33.274704	\N	\N	\N
166	ASSET_TYPE	01	Car	t	2022-09-07 07:57:33.274704	\N	\N	\N
167	ASSET_TYPE	02	Laptop	t	2022-09-07 07:57:33.274704	\N	\N	\N
168	NOMINEES_RELATION_TYPE	01	Father	t	2022-09-07 07:57:33.274704	\N	\N	\N
169	NOMINEES_RELATION_TYPE	02	Mother	t	2022-09-07 07:57:33.274704	\N	\N	\N
171	DOCUMENT_TYPE	02	National ID	t	2022-09-07 07:57:33.274704	\N	\N	\N
172	NATIONAL_ID_TYPE	01	National Id	t	2022-09-07 07:57:33.274704	\N	\N	\N
173	NATIONAL_ID_TYPE	02	Passport	t	2022-09-07 07:57:33.274704	\N	\N	\N
174	JOB_POSITION	01	Senior Manager	t	2022-09-07 07:57:33.274704	\N	\N	\N
175	JOB_POSITION	02	Specialist	t	2022-09-07 07:57:33.274704	\N	\N	\N
176	JOB_POSITION	03	Executive	t	2022-09-07 07:57:33.274704	\N	\N	\N
177	JOB_POSITION	04	Manager	t	2022-09-07 07:57:33.274704	\N	\N	\N
178	JOB_POSITION	05	Director	t	2022-09-07 07:57:33.274704	\N	\N	\N
179	JOB_POSITION	06	HOD	t	2022-09-07 07:57:33.274704	\N	\N	\N
180	MEMO_TYPE	01	Confirmation	t	2022-09-07 07:57:33.274704	\N	\N	\N
181	MEMO_TYPE	02	Request	t	2022-09-07 07:57:33.274704	\N	\N	\N
182	INTEGRATION_TYPE	TM	Thought Machine	t	2022-11-04 11:34:07.628032	\N	\N	\N
183	INTEGRATION_TYPE	E6	E6 Machine	t	2022-11-04 11:34:07.628032	\N	\N	\N
184	INTEGRATION_TYPE	APPIAN	APPIAN Machine	t	2022-11-04 11:34:07.628032	\N	\N	\N
122	ADDRESS_TYPE	02	Correspondence Address	t	2022-09-07 07:57:33.274704	\N	2022-11-16 23:29:58.741	\N
249	ADDRESS_TYPE	AD101	my bulk upload test	t	2023-01-04 04:47:11.535526	\N	\N	\N
170	DOCUMENT_TYPE	01	Passport	t	2022-09-07 07:57:33.274704	\N	2023-01-11 05:06:38.723	\N
250	ADDRESS_TYPE	1	Permanent Address	t	2023-01-17 04:09:57.814629	\N	\N	\N
251	ADDRESS_TYPE	2	Correspondence Address	t	2023-01-17 04:09:57.814629	\N	\N	\N
252	ADDRESS_TYPE	3	Office address	t	2023-01-17 04:09:57.814629	\N	\N	\N
253	ADDRESS_TYPE	4	Temporary address	t	2023-01-17 04:09:57.814629	\N	\N	\N
254	CONTACT_TYPE	1	Mobile	t	2023-01-17 04:09:57.814629	\N	\N	\N
255	CONTACT_TYPE	2	Email	t	2023-01-17 04:09:57.814629	\N	\N	\N
256	CONTACT_TYPE	3	Facebook	t	2023-01-17 04:09:57.814629	\N	\N	\N
257	CONTACT_TYPE	4	Twitter	t	2023-01-17 04:09:57.814629	\N	\N	\N
258	CONTACT_TYPE	5	Fax	t	2023-01-17 04:09:57.814629	\N	\N	\N
259	PARTY_SEGMENT	1	Segment01	t	2023-01-17 04:09:57.814629	\N	\N	\N
260	PARTY_SEGMENT	2	Segment02	t	2023-01-17 04:09:57.814629	\N	\N	\N
261	COMPANY_TYPE	1	Vietnam Electricity	t	2023-01-17 04:09:57.814629	\N	\N	\N
262	COMPANY_TYPE	2	Sioux High Pvt. 	t	2023-01-17 04:09:57.814629	\N	\N	\N
263	RESIDENCY_TYPE	1	Vietnam Residency 1	t	2023-01-17 04:09:57.814629	\N	\N	\N
264	RESIDENCY_TYPE	2	Vietnam Residency 2	t	2023-01-17 04:09:57.814629	\N	\N	\N
265	RESIDENCY_TYPE	3	Singaporean Residency 1	t	2023-01-17 04:09:57.814629	\N	\N	\N
266	RESIDENCY_TYPE	4	Singaporean Residency 2	t	2023-01-17 04:09:57.814629	\N	\N	\N
267	EDUCATION_TYPE	1	Postgraduate	t	2023-01-17 04:09:57.814629	\N	\N	\N
268	EDUCATION_TYPE	2	Undergraduate	t	2023-01-17 04:09:57.814629	\N	\N	\N
269	EDUCATION_TYPE	3	Doctorate	t	2023-01-17 04:09:57.814629	\N	\N	\N
270	EDUCATION_TYPE	4	Phd	t	2023-01-17 04:09:57.814629	\N	\N	\N
271	INDUSTRY_TYPE	1	Textiles	t	2023-01-17 04:09:57.814629	\N	\N	\N
272	INDUSTRY_TYPE	2	Food processing	t	2023-01-17 04:09:57.814629	\N	\N	\N
149	NATIONALITY	03	Singaporean	t	2022-09-07 07:57:33.274704	\N	2023-06-09 09:21:31.266	\N
273	INDUSTRY_TYPE	3	Banking	t	2023-01-17 04:09:57.814629	\N	\N	\N
275	INDUSTRY_TYPE	5	Government Service	t	2023-01-17 04:09:57.814629	\N	\N	\N
276	NATIONALITY	1	Vietnamese	t	2023-01-17 04:09:57.814629	\N	\N	\N
277	NATIONALITY	2	Indian	t	2023-01-17 04:09:57.814629	\N	\N	\N
278	NATIONALITY	3	Singaporean	t	2023-01-17 04:09:57.814629	\N	\N	\N
279	SALUTATION	1	Mr.	t	2023-01-17 04:09:57.814629	\N	\N	\N
280	SALUTATION	2	Ms.	t	2023-01-17 04:09:57.814629	\N	\N	\N
281	SALUTATION	3	Dr.	t	2023-01-17 04:09:57.814629	\N	\N	\N
282	RISK_CATEGORY	1	Low	t	2023-01-17 04:09:57.814629	\N	\N	\N
283	RISK_CATEGORY	2	High	t	2023-01-17 04:09:57.814629	\N	\N	\N
284	RELATION_TYPE	1	Relation 1	t	2023-01-17 04:09:57.814629	\N	\N	\N
285	RELATION_TYPE	2	Relation 2	t	2023-01-17 04:09:57.814629	\N	\N	\N
286	PROFESSION_TYPE	1	Business analyst	t	2023-01-17 04:09:57.814629	\N	\N	\N
287	PROFESSION_TYPE	2	Designer	t	2023-01-17 04:09:57.814629	\N	\N	\N
288	PROFESSION_TYPE	3	Full Time	t	2023-01-17 04:09:57.814629	\N	\N	\N
289	PROFESSION_TYPE	4	Part Time	t	2023-01-17 04:09:57.814629	\N	\N	\N
290	PROFESSION	1	Managers	t	2023-01-17 04:09:57.814629	\N	\N	\N
291	PROFESSION	2	Technicians 	t	2023-01-17 04:09:57.814629	\N	\N	\N
292	PROFESSION	3	Salaried 	t	2023-01-17 04:09:57.814629	\N	\N	\N
293	PROFESSION	4	Self Employed	t	2023-01-17 04:09:57.814629	\N	\N	\N
294	PROFESSION	5	Government Service	t	2023-01-17 04:09:57.814629	\N	\N	\N
295	ASSET_TYPE	1	Car	t	2023-01-17 04:09:57.814629	\N	\N	\N
296	ASSET_TYPE	2	Laptop	t	2023-01-17 04:09:57.814629	\N	\N	\N
297	NOMINEES_RELATION_TYPE	1	Father	t	2023-01-17 04:09:57.814629	\N	\N	\N
298	NOMINEES_RELATION_TYPE	2	Mother	t	2023-01-17 04:09:57.814629	\N	\N	\N
299	DOCUMENT_TYPE	1	Passport	t	2023-01-17 04:09:57.814629	\N	\N	\N
300	DOCUMENT_TYPE	2	National ID	t	2023-01-17 04:09:57.814629	\N	\N	\N
301	NATIONAL_ID_TYPE	1	National Id	t	2023-01-17 04:09:57.814629	\N	\N	\N
302	NATIONAL_ID_TYPE	2	Passport	t	2023-01-17 04:09:57.814629	\N	\N	\N
303	JOB_POSITION	1	Senior Manager	t	2023-01-17 04:09:57.814629	\N	\N	\N
304	JOB_POSITION	2	Specialist	t	2023-01-17 04:09:57.814629	\N	\N	\N
305	JOB_POSITION	3	Executive	t	2023-01-17 04:09:57.814629	\N	\N	\N
306	JOB_POSITION	4	Manager	t	2023-01-17 04:09:57.814629	\N	\N	\N
307	JOB_POSITION	5	Director	t	2023-01-17 04:09:57.814629	\N	\N	\N
308	JOB_POSITION	6	HOD	t	2023-01-17 04:09:57.814629	\N	\N	\N
309	MEMO_TYPE	1	Confirmation	t	2023-01-17 04:09:57.814629	\N	\N	\N
310	MEMO_TYPE	2	Request	t	2023-01-17 04:09:57.814629	\N	\N	\N
311	INTEGRATION	TM	Thought Machine	t	2023-01-17 04:09:57.814629	\N	\N	\N
312	INTEGRATION	E6	E6 Machine	t	2023-01-17 04:09:57.814629	\N	\N	\N
313	INTEGRATION	APPIAN	APPIAN Machine	t	2023-01-17 04:09:57.814629	\N	\N	\N
274	INDUSTRY_TYPE	4	IT	t	2023-01-17 04:09:57.814629	\N	2023-01-24 10:39:35.308	\N
314	PARTY_SEGMENT	04	Premium	t	2023-03-28 07:14:50.469	\N	\N	\N
315	RESIDENCY_TYPE	22	US Citizen	t	2023-06-09 09:22:58.466	\N	\N	\N
316	NATIONALITY	04	U.S. citizen	t	2023-06-09 09:43:16.97667	\N	\N	\N
317	RESIDENCY_TYPE	05	Indian	t	2023-07-10 11:12:24.311	\N	\N	\N
\.


--
-- Data for Name: party; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.party (party_id, type, salutation_code, full_name, first_name, middle_name, last_name, mother_maiden_name, nick_name, gender, date_of_birth, place_of_birth, country_birth_code, primary_mobile_number, primary_email, marital_status, status, country_residence_code, residency_type_code, education_type_code, profession_code, profession_type_code, job_position_type_code, industry_type_code, nationality_code, annual_income, annual_turnover, tax_id, date_of_incorp, staff_code, company_code, group_code, portfolio_code, segment_type_code, relation_type_code, refferal_code, promo_code, national_id_type_code, national_id, aml_risk, aml_risk_eval_date, aml_check_status, is_staff, is_deceased, is_insolvency, is_npa, is_willful_defaulter, willful_defaulter_date, is_loan_overdue, is_suit_failed, is_pep, is_fatca_applicable, is_email_statement_reg, is_under_watchlist, is_deleted, created_at, created_by, updated_at, updated_by, created_by_channel, updated_by_channel, party_identifier) FROM stdin;
3022	CUSTOMER	01	jfbyPtuJ5e-1SVvwoIlkaw	Y_KpzarBBHpOm-RvBBfOpQ		AfKLkUHxeSY9QQGmc7WsFg	Mia	ramu	MALE	1997-11-30 00:00:00	Da Nang	01	acIWKu-ywrH_M1-RoChHfA	h54HemIa-lPohe6eFHY4c-X4e-MiZUma1j_0J6zTqTs	SINGLE	ACTIVE	02	01	01	01	01	02	11	01	91019	877887	7sY-fg9b6dvKTvj36mSfOA	1980-10-05 00:00:00	S22	CG09	G21	PP12	01	01	RC01	T01	01	80033848	MEDIUM	2003-11-20 00:00:00	f	t	f	f	f	f	\N	f	f	f	f	f	f	f	2022-09-05 12:59:12.91575	user	2022-11-07 02:10:58.151901	SYSTEM	Web	\N	f267ac43-536b-4eba-a7cc-e3d0d0252427
3016	CUSTOMER	01	0IMp80Ve1LxtxNUDXUEKlw	8C7rptPoSwIzCQEXXBI2Rw	BmSoHTTGb4z0qCEM_SHkrw	rlufnZGU1t10ufusBALwoA			MALE	1972-09-15 00:00:00	Singapore	02	yon_01egrN30wYsliltkOw	4IDROQe1VPwb1w2IjiR5olA42vwrb9bbgFohQsDcfcw	MARRIED	ACTIVE	03	03	04	05	03	06	01	03	180000	0	7sY-fg9b6dvKTvj36mSfOA	1980-10-05 00:00:00	S22	CG09	G21	PP12	0	0	RC01	T01	03	80033848	LOW	2003-11-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2022-09-05 12:39:34.9461	user	2022-11-07 02:12:56.765173	SYSTEM	Web	\N	1b09b250-b1e0-42af-b30f-3bdb7ec9c6e6
3005	CUSTOMER	03	gGgbMg8iawQXLcEKIf7_Dw	EoQG7tQdAqe52h_O_ejhBw	cije2LWh0-CjahehVg11qw	r24Kw5NsknPKosAcPsXhcQ			MALE	1970-08-31 00:00:00	Singapore	02	cGSQieJDJ_NLimGXIV9aVw	tph6AD1hZq1dqO2d2lnu50k6Opz8oLdql1IhA0pLZMg	MARRIED	ACTIVE	03	03	03	05	03	06	01	03	200000	0	7sY-fg9b6dvKTvj36mSfOA	1980-10-05 00:00:00	S22	CG09	G21	PP12	0	0	RC01	T01	02	80033848	MEDIUM	2003-11-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2022-09-05 12:06:07.119478	user	2022-11-07 02:13:17.967382	SYSTEM	Web	\N	85915f11-bf5a-4bbc-bcb9-0660ce27a64d
3011	CUSTOMER	01	0HvGczhDvYzrnNU4IQq-Jw	Y4PY-k2P3On0qpp0GUO7Iw	LRkfumS0ev1paB2HWaD9kg	rlufnZGU1t10ufusBALwoA			MALE	1980-12-25 00:00:00	Singapore	02	UByeLxRDdjuijbyvNFtvXg	DnILZXFdgu3wBtuxnhHjUpWzTF--G-heb3FUfW0ypO4	MARRIED	ACTIVE	03	03	02	03	03	03	01	03	110000	0	7sY-fg9b6dvKTvj36mSfOA	1980-10-05 00:00:00	S22	CG09	G21	PP12	0	0	RC01	T01	02	80033848	LOW	2003-11-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2022-09-05 12:09:59.433189	user	2022-11-07 02:13:34.312725	SYSTEM	Web	\N	5a582219-e316-460f-be80-6b00746acdd2
3004	CUSTOMER	02	Itof8NFcKrA61OSY3LW7tA	SXjXUpxY_z-Ol92HRh7PAw		0trfJrwqvIZksaYjUD_71w			FEMALE	1979-06-28 00:00:00	Singapore	02	lK6kKCLIxxzVCEz1kye70w	-SUVa8S2UB45rzunMGrnMEWH_XLQ4Y4rldNTR2xQ97s	MARRIED	ACTIVE	03	03	01	04	03	04	01	03	150000	0	7sY-fg9b6dvKTvj36mSfOA	1980-10-05 00:00:00	S22	CG09	G21	PP12	0	0	RC01	T01	02	80033848	LOW	2003-11-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2022-09-05 12:05:51.214418	user	2022-11-07 02:14:50.075994	SYSTEM	Web	\N	9e4cba15-2fd6-4550-8ef0-a0cc15148304
3012	CUSTOMER	01	ERl6wX0Ud3SHpN6lB9WC5A	OZqwNlwUIl4LtLbZVkZg0Q	3WRgzbAbg0CT1C9QQAQJvw	ES6QZ-0XPJlhnMOtU8LUkw			MALE	1990-02-02 00:00:00	Singapore	02	FywtQsrmOt6rxkSZxHgFzw	JOkq9PlMN0TK_rqzaTdIj3HXkYrk1vRpR_tgCODMteU	MARRIED	ACTIVE	03	03	04	05	03	06	01	03	250000	0	7sY-fg9b6dvKTvj36mSfOA	1980-10-05 00:00:00	S22	CG09	G21	PP12	0	0	RC01	T01	02	80033848	LOW	2003-11-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2022-09-05 12:10:15.112581	user	2022-11-07 02:15:09.172869	SYSTEM	Web	\N	6e5c62d3-2056-4d4c-9782-e6566f022515
3019	CUSTOMER	02	PC3TMImNBP8-asom-ZRlAw	yUz20oaFOwRgSjJypXjhlg		p2BBwYJYRrnYs34NIhO82Q			FEMALE	1991-01-27 00:00:00	Singapore	02	kKFpLNyRE7_sjTsaGJ9pmQ	l0skuwc8zdkrEn3smjg2y0WH_XLQ4Y4rldNTR2xQ97s	SINGLE	ACTIVE	03	03	01	03	03	04	01	03	135000	0	7sY-fg9b6dvKTvj36mSfOA	1980-10-05 00:00:00	S22	CG09	G21	PP12	0	0	RC01	T01	02	80033848	HIGH	2003-11-20 00:00:00	f	t	f	f	f	f	\N	f	f	f	f	f	f	f	2022-09-05 12:49:38.741909	user	2022-11-30 04:58:53.559057	SYSTEM	Web	\N	bd86ad4e-3973-4e52-9369-926ce4a2047e
3009	CUSTOMER	01	9_j2v9s73TEBeM1oNNgayQ	OoDLjCr9MkcnoYfW5K9W4w	rmP4rg4sbGg82VPAAeXyQw	W67nXvDbfhJPaeFpxd_cdQ			MALE	1992-09-21 00:00:00	Singapore	02	w1A1YNyXqh26NszXWwW5Gg	dBFPtet2qd4RwO8MmtS5-ng9v5uMybmJkEILvOPx_RY	MARRIED	ACTIVE	03	03	01	04	04	03	01	03	90000	0	7sY-fg9b6dvKTvj36mSfOA	1980-10-05 00:00:00	S22	CG09	G21	PP12	0	0	RC01	T01	02	80033848	HIGH	2003-11-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2022-09-05 12:08:57.219063	user	2022-11-07 02:11:21.214377	SYSTEM	Web	\N	8ba000b6-f27c-4595-a5ac-2a9f55c2367b
3023	CUSTOMER	01	jfbyPtuJ5e-1SVvwoIlkaw	Y_KpzarBBHpOm-RvBBfOpQ		AfKLkUHxeSY9QQGmc7WsFg	Mia	ramu	MALE	1997-11-30 00:00:00	Da Nang	01	zgPUeeGWfFLScTRzmEyu-g	h54HemIa-lPohe6eFHY4c-X4e-MiZUma1j_0J6zTqTs	SINGLE	ACTIVE	02	01	01	01	01	02	11	01	91019	877887	7sY-fg9b6dvKTvj36mSfOA	1980-10-05 00:00:00	S22	CG09	G21	PP12	01	01	RC01	T01	01	80033848	MEDIUM	2003-11-20 00:00:00	f	t	f	f	f	f	\N	f	f	f	f	f	f	f	2022-09-05 13:03:40.514887	user	2022-11-07 02:12:00.179434	SYSTEM	Web	\N	3cc7f241-e219-4fa2-9d90-68f8ee4eda51
3014	CUSTOMER	01	ENFaZtLC6oYRlyblqO3LQEZye3_gflPC_sdV1wKfZ34	KBbLt3M8s9_fwnOa7hUGDQ		olQWc2nkBCTx3emXl5zu5Q			MALE	1961-01-25 00:00:00	Singapore	02	FdmlumNtgna3V9udpow_iw	QGkt-Y5X7bI-sfqrYq0cXO4c201rL4_cK13Nqv7x4Bk	MARRIED	ACTIVE	03	03	04	03	03	06	01	03	175000	0	7sY-fg9b6dvKTvj36mSfOA	1980-10-05 00:00:00	S22	CG09	G21	PP12	0	0	RC01	T01	02	80033848	LOW	2003-11-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2022-09-05 12:34:23.447239	user	2022-11-07 02:12:42.198668	SYSTEM	Web	\N	b5053dfd-26b6-4e23-99ff-852b23c125a2
3018	CUSTOMER	02	LmJCk88dbZbq6sdgCQr6Zg	tHuJg2q3Vbd3LxkAsD_OMg		-pz37MFYMJwMb9dU8hMOMA			FEMALE	1981-08-23 00:00:00	Singapore	02	3iNspfvTDVUaR6X6qSuX8A	Zk-3rNsEyQUWLWmKQ2OJfzp4K8xxWsy2bHHKpeD0gNg	MARRIED	ACTIVE	03	03	02	04	03	04	01	03	140000	0	7sY-fg9b6dvKTvj36mSfOA	1980-10-05 00:00:00	S22	CG09	G21	PP12	0	0	RC01	T01	02	80033848	LOW	2003-11-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2022-09-05 12:40:07.340122	user	2022-11-07 02:13:54.594678	SYSTEM	Web	\N	8aa268a2-b912-4242-9b9c-d0e7453a4753
3007	CUSTOMER	01	zjSE0xfUEYe5Ngln6Ju0wg	LpSjAMvuSj0GdtcEwQyttw	I_DopyY9XeKFI6LUQJ61Gw	IvV0IygFcaubpQM0Np2j9A			MALE	1969-10-09 00:00:00	Singapore	02	50pD5J3nAC3WoVUhux2WTA	IzdRZzF6sxYnBRmaEKMmI-4c201rL4_cK13Nqv7x4Bk	DIVORCED	ACTIVE	03	03	02	03	03	03	01	03	90000	0	7sY-fg9b6dvKTvj36mSfOA	1980-10-05 00:00:00	S22	CG09	G21	PP12	0	0	RC01	T01	02	80033848	MEDIUM	2003-11-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2022-09-05 12:07:24.671342	user	2022-11-07 02:14:16.613587	SYSTEM	Web	\N	de2ee97f-0a9d-4a32-90ff-b4d2e028c21c
3008	CUSTOMER	01	VfbUkj9hbXh-M5So_Ljm9Q	LpSjAMvuSj0GdtcEwQyttw	UyzcBDp3Rcxji-KrCaZnYA	6HQ0gTgfKTAsmjAL5GY1Gg			MALE	1937-11-05 00:00:00	Singapore	02	CCd30pKB226tDcm-FRw1sA	mluUFSxYRDzP95zTJIooPvDgAwLoObof_TD8QzNhq70	MARRIED	ACTIVE	03	03	01	05	03	06	01	03	150000	0	7sY-fg9b6dvKTvj36mSfOA	1980-10-05 00:00:00	S22	CG09	G21	PP12	0	0	RC01	T01	02	80033848	LOW	2003-11-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2022-09-05 12:07:40.412623	user	2022-11-07 02:15:40.024959	SYSTEM	Web	\N	2e95e5b7-7efc-462b-b30b-f4e18713551c
3013	CUSTOMER	02	w7HMHKikBppwu3j9Gkz4og	1ijOwe6JdhcrSGhdXSweng	lUlNPcybpMx3S3L_dpJfdQ	JXH1qIgy-GH8-4O_TL-6ag			FEMALE	1983-05-08 00:00:00	Singapore	02	l04ADqlj_BYxHrZI6NErDg	_oQNTZ0tOkMGGcpf3jf0cjp4K8xxWsy2bHHKpeD0gNg	WIDOWED	INACTIVE	03	03	02	04	04	03	01	03	120000	0	7sY-fg9b6dvKTvj36mSfOA	1980-10-05 00:00:00	S22	CG09	G21	PP12	0	0	RC01	T01	02	80033848	MEDIUM	2003-11-20 00:00:00	f	t	f	f	f	f	\N	f	f	f	f	f	f	f	2022-09-05 12:10:30.738838	user	2022-11-07 02:15:24.76251	SYSTEM	Web	\N	7bf0eb18-8acb-49af-819a-7c48cc256b95
3020	CUSTOMER	03	i69feRYDFZLkTW6IqxFCkQ	rA1RKroxl9RHNmOD91ZnGw		KVClzQEekj1MxTu_hoxedQ			MALE	1988-01-15 00:00:00	Singapore	02	Cke7m6sSdxrnek0RUoHSZg	Fy04kV_R19mYBecpXnK_DEWH_XLQ4Y4rldNTR2xQ97s	SINGLE	ACTIVE	03	03	03	04	03	05	01	03	225000	0	7sY-fg9b6dvKTvj36mSfOA	1980-10-05 00:00:00	S22	CG09	G21	PP12	0	0	RC01	T01	02	80033848	LOW	2003-11-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2022-09-05 12:49:49.565101	user	2022-11-07 02:15:55.832972	SYSTEM	Web	\N	ecd9d1ed-d089-4b8b-8c4f-fad3104763fb
3015	CUSTOMER	01	ZM7jwccru0o_55Qffrnkcw	mpbuqm5_pirvQkyXAKzRUw		UOZtqWtYSe6Km_-N3N_Xqw			MALE	1978-01-07 00:00:00	Singapore	02	TD3yMIq6LH_b2PIKQntyDg	HIvIeOk_9jnZnEToKVqj9d0qmPuuXg6mutUEfxDn9S0	MARRIED	ACTIVE	03	03	01	03	03	04	01	03	120000	0	7sY-fg9b6dvKTvj36mSfOA	1980-10-05 00:00:00	S22	CG09	G21	PP12	0	0	RC01	T01	02	80033848	LOW	2003-11-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2022-09-05 12:39:13.612245	user	2022-11-07 02:16:26.263945	SYSTEM	Web	\N	998ee67f-19f4-4040-8b7e-904f95b1e01f
3017	CUSTOMER	03	czqd0rdf_dRcdnuhiDRHQg	yNh1HduAFGUh6n08sLsJdw		RIpJy7Ld2akgXASZ7YXMng			MALE	1963-02-18 00:00:00	Singapore	02	WnsZjRnlARIo75kMhV7r8w	NMnJfbJNCCPDDmoTla0e21A42vwrb9bbgFohQsDcfcw	MARRIED	ACTIVE	03	03	03	03	03	05	01	03	210000	0	7sY-fg9b6dvKTvj36mSfOA	1980-10-05 00:00:00	S22	CG09	G21	PP12	0	0	RC01	T01	02	80033848	HIGH	2003-11-20 00:00:00	f	t	f	f	f	f	\N	f	f	f	f	f	f	f	2022-09-05 12:39:45.96423	user	2022-11-07 02:16:40.315023	SYSTEM	Web	\N	9c8865d4-0cf5-49a3-9201-3f202b4b75be
3006	CUSTOMER	02	qsASwRHc0jQQ1L-KuhzeEw	LpSjAMvuSj0GdtcEwQyttw	RIpJy7Ld2akgXASZ7YXMng	YHO9FJfEZLqrUiVh77VU9A			FEMALE	1942-04-19 00:00:00	Singapore	02	b1KVoucesKYj5wmku-9aLw	VaOax0NxG4JorwCSD1F8V19wdK-t9AlLqcLgIjHnOpI	MARRIED	ACTIVE	03	03	02	03	04	03	01	03	75000	0	7sY-fg9b6dvKTvj36mSfOA	1980-10-05 00:00:00	S22	CG09	G21	PP12	0	0	RC01	T01	02	80033848	LOW	2003-11-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2022-09-05 12:07:08.815195	user	2022-11-07 02:16:54.226174	SYSTEM	Web	\N	2f1c839b-a414-41a0-9c55-00851eb98fce
3026	CUSTOMER	01	7_v_XOyG2m8ob1E-SNsaJVyd4Ws-fp_OeFaEXV2kwmk	Abs45iDn5VJJPx-0l8M9Cw	JUiEdl8KQBa9VLPJ2zfpbA	MitcmfbLXw59AgJfUByKMg	Mia	Jo	MALE	1997-11-30 00:00:00	Da Nang	01	0gHOhTrt6nmtMONIk7_6IQ	h54HemIa-lPohe6eFHY4c-X4e-MiZUma1j_0J6zTqTs	SINGLE	ACTIVE	02	01	01	01	01	02	11	01	91019	877887	7sY-fg9b6dvKTvj36mSfOA	1980-10-05 00:00:00	S22	CG09	G21	PP12	01	01	RC01	T01	01	80033848	MEDIUM	2003-11-20 00:00:00	f	t	f	f	f	f	\N	f	f	f	f	f	f	f	2022-09-05 13:12:47.815915	user	2022-11-07 02:17:08.180887	SYSTEM	Web	\N	457bd513-8760-46b8-9b1b-089fd86c65d2
3042	CUSTOMER	01	wEsPW_vPO8L12eY9XcTEhA	Dg1y15zvCtXYCwdgJ5pAyQ	IhNPxTt7F4yUqJF1HzIHBQ	CtIjFky8NvrMJGpPH2l8oA	Mi	Ji	MALE	1994-09-30 00:00:00	Da Nan	01	cdcGBIbUMWDj1eIGFc3Cvg	PtOFranwp_fT4SNKPIkcIUk6Opz8oLdql1IhA0pLZMg	SINGLE	ACTIVE	01	01	01	\N	\N	02	\N	01	\N	\N	\N	\N	S22	\N	G21	PP12	01	01	RC01	T01	01	80033848	MEDIUM	2009-11-20 00:00:00	f	t	f	f	f	f	\N	f	f	f	f	f	f	f	2022-09-15 12:09:21.550182	SYSTEM	2022-11-07 02:17:23.75683	SYSTEM	Web	\N	06648461-b556-4850-8b39-ff215797119e
3043	CUSTOMER	01	p9yFiosWXd_AnVQmYF8DOiOv85enVO5HJC7tvogCf-k	HvcI80ngprMJ75oBBfahBg	aVfTL048VKi84hscurb9NQ	uGgTi5VldFjDgcbdBtOUOg	Steve	Jo	MALE	1997-11-30 00:00:00	Da Nang	01	ZT0ElJqwtM4hb_t56gWEXA	XftUUJJllP_6RktpasFA0ks2yVgiepmL9xyUm54CnK4	SINGLE	ACTIVE	01	01	01	01	01	02	11	01	91019	877887	7sY-fg9b6dvKTvj36mSfOA	1980-10-05 00:00:00	S22	CG09	G21	PP12	01	01	RC01	T01	01	80033848	MEDIUM	2003-11-20 00:00:00	f	t	f	f	f	f	\N	f	f	f	f	f	f	f	2022-09-20 11:26:12.019553	SYSTEM	2022-11-07 02:17:44.857169	SYSTEM	Web	\N	a8fc439c-b727-408f-80f6-ee04fca4df59
3044	CUSTOMER	01	11y0liBUHqT37hyyNINU_zp4K8xxWsy2bHHKpeD0gNg	Y_KpzarBBHpOm-RvBBfOpQ	AfKLkUHxeSY9QQGmc7WsFg	d5DNVTUbmDpan43PDszgaQ	Mia	Jo	MALE	1997-11-30 00:00:00	Da Nang	01	ffPxgqdLUzW_ADUy-pdZmw	fSU4d5BIPhEkQD_ngnLC4Q	SINGLE	ACTIVE	01	01	01	\N	\N	02	\N	01	\N	\N	\N	\N	S22	\N	G21	PP12	01	01	RC01	T01	01	80033848	MEDIUM	2003-11-20 00:00:00	f	t	f	f	f	f	\N	f	f	f	f	f	f	f	2022-09-28 12:00:30.902459	SYSTEM	2022-11-07 02:17:57.984755	SYSTEM	Web	\N	799c248d-ef6e-4d3c-9031-c2131b8182c3
3046	CUSTOMER	01	7_v_XOyG2m8ob1E-SNsaJVyd4Ws-fp_OeFaEXV2kwmk	Abs45iDn5VJJPx-0l8M9Cw	JUiEdl8KQBa9VLPJ2zfpbA	MitcmfbLXw59AgJfUByKMg	Mia	Jo	MALE	1997-11-30 00:00:00	Da Nang	01	bl0SCWVEe0LmiKOnn2-uYA	h54HemIa-lPohe6eFHY4c-X4e-MiZUma1j_0J6zTqTs	SINGLE	ACTIVE	01	01	01	01	01	02	11	01	91019	877887	7sY-fg9b6dvKTvj36mSfOA	1980-10-05 00:00:00	S22	CG09	G21	PP12	01	01	RC01	T01	01	80033848	MEDIUM	2003-11-20 00:00:00	f	t	f	f	f	f	\N	f	f	f	f	f	f	f	2022-10-13 08:21:17.91573	SYSTEM	2022-11-07 02:18:10.570667	SYSTEM	Web	\N	649dd5d9-5fb0-4ec8-bd3b-435017b3f3be
3047	CUSTOMER	01	7_v_XOyG2m8ob1E-SNsaJVyd4Ws-fp_OeFaEXV2kwmk	Abs45iDn5VJJPx-0l8M9Cw	JUiEdl8KQBa9VLPJ2zfpbA	MitcmfbLXw59AgJfUByKMg	Mia	Jo	MALE	1997-11-30 00:00:00	Da Nang	01	_7Y_cvvgySflxFiM4gXgcw	h54HemIa-lPohe6eFHY4c-X4e-MiZUma1j_0J6zTqTs	SINGLE	ACTIVE	01	01	01	01	01	02	11	01	91019	877887	7sY-fg9b6dvKTvj36mSfOA	1980-10-05 00:00:00	S22	CG09	G21	PP12	01	01	RC01	T01	01	80033848	MEDIUM	2003-11-20 00:00:00	f	t	f	f	f	f	\N	f	f	f	f	f	f	f	2022-10-13 08:21:56.255062	SYSTEM	2022-11-07 02:18:24.125694	SYSTEM	Web	\N	a889bc47-1176-42ef-9071-0764b3f26c99
3010	CUSTOMER	03	FC2w8NO7HjscFUihK5yXwA	oyo6P38ochdMJRGoV3sg0g	mcRwiM3XxNH4UUmKRZWSNQ	TvGIzOql9eFq8R7vsvhdsQ			MALE	1977-03-18 00:00:00	Singapore	02	I9kmLWOFs3rOfaG0LLaV-w	0Mq6TRKmjUeA275205afzjp4K8xxWsy2bHHKpeD0gNg	MARRIED	ACTIVE	03	03	03	05	03	06	01	03	200000	0	7sY-fg9b6dvKTvj36mSfOA	1980-10-05 00:00:00	S22	CG09	G21	PP12	0	0	RC01	T01	02	80033848	LOW	2003-11-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2022-09-05 12:09:13.242503	user	2022-11-09 15:17:32.286133	SYSTEM	Web	\N	b690e8d2-298c-43d9-8c6a-48fd8cebd904
3025	CUSTOMER	01	QnUKJ9amUlW7-PZ3fFagvw	Dg1y15zvCtXYCwdgJ5pAyQ	Dg1y15zvCtXYCwdgJ5pAyQ	CtIjFky8NvrMJGpPH2l8oA	Mi	Ji	MALE	1990-11-30 00:00:00	Da Nan	01	Ju-E1Blij34V-lrykZBuZA	N_j_cGD9jyXIU8YflHmtNlA42vwrb9bbgFohQsDcfcw	SINGLE	ACTIVE	02	01	01	01	01	02	11	01	91019	877887	7sY-fg9b6dvKTvj36mSfOA	1980-10-05 00:00:00	S22	CG09	G21	PP12	01	01	RC01	T01	01	80033848	MEDIUM	2009-11-20 00:00:00	f	t	f	f	f	f	\N	f	f	f	f	f	f	f	2022-09-05 13:09:07.522022	user	2022-11-07 02:18:52.850232	SYSTEM	Web	\N	316c4ebb-8523-4aed-a7f9-894da6ee11f9
3028	CUSTOMER	01	9NHrLuxiZAtBy83Jiddo2A	3p1fZ34wIuSPsYMbod5o2A		IphK4x206vr4MxtEHcx5ww			MALE	1981-12-10 00:00:00	Singapore	02	QpTgERnmNXoECxFCQaDF4Q	0HJM8zD9gFJt_MKbFRknZvDgAwLoObof_TD8QzNhq70	MARRIED	DORMANT	03	03	01	03	04	03	01	03	60000	0	7sY-fg9b6dvKTvj36mSfOA	1980-10-05 00:00:00	S22	CG09	G21	PP12	0	0	RC01	T01	02	80033848	HIGH	2003-11-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2022-09-06 05:40:07.71223	user	2022-11-07 02:19:05.699903	SYSTEM	Web	\N	e92ed182-de84-40aa-9f0d-7a94d2525925
3086	CUSTOMER	01	7PqgBTAwICFpipVFCOqX3g	dw2zpH-QpZF3b0YZ-gJeig	\N	87K5yn8KiJcbkepVWDBC4w	\N	\N	MALE	1967-11-30 00:00:00	Marina	02	CqA3f6SbF_uDauv3zLCOGg	aOTyu5W89D5H8h3SvlfA3g	SINGLE	ACTIVE	\N	\N	\N	\N	\N	\N	\N	03	\N	\N	\N	\N	\N	\N	\N	\N	04	\N	\N	\N	02	zQk0G8N8P4YDC70y7W8MsQ	\N	\N	f	\N	f	f	f	f	\N	f	f	f	f	f	f	f	2023-03-28 07:08:33.303415	SYSTEM	\N	\N	\N	\N	660edd8e-0b00-470a-bc0c-6a7c8c2c671f
3087	CUSTOMER	01	uOsoUOcEvZasTtJMhdUSuw	z95ai5L_FPbi0fhtJBj5RA	\N	87K5yn8KiJcbkepVWDBC4w	\N	\N	MALE	1964-11-12 00:00:00	Marina	02	fH6VpV-dXIgfjaJ_voI4tg	eJe5S8pRtpNllZERNTIccw	SINGLE	ACTIVE	\N	\N	\N	\N	\N	\N	\N	03	\N	\N	\N	\N	\N	\N	\N	\N	04	\N	\N	\N	02	d-t8fg7PBPH_SkE31UJVKg	\N	\N	f	\N	f	f	f	f	\N	f	f	f	f	f	f	f	2023-03-28 07:10:02.70173	SYSTEM	\N	\N	\N	\N	027c5f85-a763-4279-a4fc-4effb9e4ddff
3021	CUSTOMER	02	doaWEsw4ANTigcgLVeuf1g	8dDKbIlgZO9-a66ij8X7dA		sCmF1Wr3ihsKBVrVCJM5EQ			FEMALE	1985-11-30 00:00:00	Singapore	02	RxtdxfXXRMZZjfq3MRty-Q	o_hW1FNxnSAPhElYZMFS2btuWe8BRBr7HikZkXTHzNk	SINGLE	ACTIVE	03	03	01	04	04	03	01	03	75000	0	7sY-fg9b6dvKTvj36mSfOA	1980-10-05 00:00:00	S22	CG09	G21	PP12	0	0	RC01	T01	02	80033848	LOW	2003-11-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2022-09-05 12:50:10.718965	user	2022-11-07 02:19:21.702708	SYSTEM	Web	\N	a8681c39-b21a-4636-8295-e68e77d6cb94
3024	CUSTOMER	01	QnUKJ9amUlW7-PZ3fFagvw	nX-IV1PWi6RLMTnOgHQSRA	IhNPxTt7F4yUqJF1HzIHBQ	CtIjFky8NvrMJGpPH2l8oA	Mi	Ji	MALE	1990-11-30 00:00:00	Da Nan	01	in8_nlt-CtO0YZ-qVW8d-g	N_j_cGD9jyXIU8YflHmtNlA42vwrb9bbgFohQsDcfcw	SINGLE	ACTIVE	02	01	01	01	01	02	11	01	91019	877887	7sY-fg9b6dvKTvj36mSfOA	1980-10-05 00:00:00	S22	CG09	G21	PP12	01	01	RC01	T01	01	80033848	MEDIUM	2009-11-20 00:00:00	f	t	f	f	f	f	\N	f	f	f	f	f	f	f	2022-09-05 13:04:57.356181	user	2022-11-07 02:19:36.470915	SYSTEM	Web	\N	566e79a8-2ce5-436e-93e3-981b3c3aa961
3045	CUSTOMER	01	7_v_XOyG2m8ob1E-SNsaJVyd4Ws-fp_OeFaEXV2kwmk	Abs45iDn5VJJPx-0l8M9Cw	JUiEdl8KQBa9VLPJ2zfpbA	MitcmfbLXw59AgJfUByKMg	Mia	Jo	MALE	1997-11-30 00:00:00	Da Nang	01	Mxv4tvxGm7s928OOCX4S1w	h54HemIa-lPohe6eFHY4c-X4e-MiZUma1j_0J6zTqTs	SINGLE	ACTIVE	01	01	01	01	01	02	11	01	91019	877887	7sY-fg9b6dvKTvj36mSfOA	1980-10-05 00:00:00	S22	CG09	G21	PP12	01	01	RC01	T01	01	80033848	MEDIUM	2003-11-20 00:00:00	f	t	f	f	f	f	\N	f	f	f	f	f	f	f	2022-10-13 08:19:34.088347	SYSTEM	2022-11-07 02:19:50.717408	SYSTEM	Web	\N	ff7b258f-6569-48ea-a20a-4da73fc04f4f
3048	CUSTOMER	01	7_v_XOyG2m8ob1E-SNsaJVyd4Ws-fp_OeFaEXV2kwmk	Abs45iDn5VJJPx-0l8M9Cw	JUiEdl8KQBa9VLPJ2zfpbA	MitcmfbLXw59AgJfUByKMg	Mia	Jo	MALE	1997-11-30 00:00:00	Da Nang	01	MlE_oZnxvIPHGdCUErM3fg	h54HemIa-lPohe6eFHY4c-X4e-MiZUma1j_0J6zTqTs	SINGLE	ACTIVE	01	01	01	01	01	02	11	01	91019	877887	7sY-fg9b6dvKTvj36mSfOA	1980-10-05 00:00:00	S22	CG09	G21	PP12	01	01	RC01	T01	01	80033848	MEDIUM	2003-11-20 00:00:00	f	t	f	f	f	f	\N	f	f	f	f	f	f	f	2022-10-13 08:30:48.195013	SYSTEM	2022-11-07 02:20:04.981646	SYSTEM	Web	\N	dbb17879-3027-42f2-99de-d8f18ff89fe9
3051	CUSTOMER	01	11y0liBUHqT37hyyNINU_zp4K8xxWsy2bHHKpeD0gNg	Y_KpzarBBHpOm-RvBBfOpQ	AfKLkUHxeSY9QQGmc7WsFg	d5DNVTUbmDpan43PDszgaQ	Mia	Jo	MALE	1997-11-30 00:00:00	Da Nang	01	ffPxgqdLUzW_ADUy-pdZmw	fSU4d5BIPhEkQD_ngnLC4Q	SINGLE	ACTIVE	01	01	01	\N	\N	02	\N	01	\N	\N	\N	\N	S22	\N	G21	PP12	01	01	RC01	T01	01	F8dmK7-W45wkLelmuWADcg	MEDIUM	2003-11-20 00:00:00	f	t	f	f	f	f	\N	f	f	f	f	f	f	f	2022-11-09 11:09:06.179633	SYSTEM	\N	\N	Web	\N	58294fcd-decf-4661-92db-b00fc840c7dd
3049	CUSTOMER	01	QnUKJ9amUlW7-PZ3fFagvw	nX-IV1PWi6RLMTnOgHQSRA	IhNPxTt7F4yUqJF1HzIHBQ	CtIjFky8NvrMJGpPH2l8oA	Mi	Ji	MALE	1990-11-30 00:00:00	Da Nan	01	LELS5-XWLoK1YY4IqHCUwQ	N_j_cGD9jyXIU8YflHmtNlA42vwrb9bbgFohQsDcfcw	SINGLE	ACTIVE	01	01	01	01	01	02	11	01	91019	877887	7sY-fg9b6dvKTvj36mSfOA	1980-10-05 00:00:00	S22	CG09	G21	PP12	01	01	RC01	T01	01	F8dmK7-W45wkLelmuWADcg	MEDIUM	2009-11-20 00:00:00	f	t	f	f	f	f	\N	f	f	f	f	f	f	f	2022-11-07 04:44:39.989315	SYSTEM	\N	\N	Web	\N	895c9acd-24a5-4572-9f12-cd350a826bb1
3050	CUSTOMER	01	Rfq7ol_qERcESINR-TcQxg	a5pLx0OH_SUGZoK15Kdocw	2o3i7-bWSzZ6r00juiEIMQ	a5pLx0OH_SUGZoK15Kdocw	Test	Ji	MALE	2022-11-07 00:00:00	Da Nan	01	KpC12oYRhKMvF5L8Dj_mvw	B5wIEzKpdgB01_53fMQvYuX4e-MiZUma1j_0J6zTqTs	SINGLE	ACTIVE	01	01	01	01	01	02	11	01	91019	877887	7sY-fg9b6dvKTvj36mSfOA	1980-10-05 00:00:00	S22	CG09	G21	PP12	01	01	RC01	T01	01	F8dmK7-W45wkLelmuWADcg	MEDIUM	2009-11-20 00:00:00	f	t	f	f	f	f	\N	f	f	f	f	f	f	f	2022-11-07 12:14:18.212245	SYSTEM	\N	\N	Web	\N	7ead956f-86c2-4508-8ef8-e97e973407ee
3052	CUSTOMER	01	9NHrLuxiZAtBy83Jiddo2A	3p1fZ34wIuSPsYMbod5o2A		IphK4x206vr4MxtEHcx5ww			MALE	1981-12-10 00:00:00	Singapore	02	nOlhCyqOHQrLzNb03NuNXw	yXmQvDsuZX99bSUGHb3l619wdK-t9AlLqcLgIjHnOpI	MARRIED	DORMANT	03	03	01	03	04	03	01	03	60000	0	7sY-fg9b6dvKTvj36mSfOA	1980-10-05 00:00:00	S22	CG09	G21	PP12	01	01	RC01	T01	02	F8dmK7-W45wkLelmuWADcg	HIGH	2003-11-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2022-11-16 08:39:17.93405	SYSTEM	2022-11-30 15:42:53.543278	SYSTEM	Web	\N	b4fea2d1-760d-4606-9308-ccb2bd1c6bc4
3055	CUSTOMER	03	96S22oOwxYdF_tQWheb6yg	sCmF1Wr3ihsKBVrVCJM5EQ	3WRgzbAbg0CT1C9QQAQJvw	r24Kw5NsknPKosAcPsXhcQ			MALE	1970-07-15 00:00:00	Singapore	02	PCIhm8rULD_cji4_s_vOOA	zomHBIMur21Vc3jFI44MSng9v5uMybmJkEILvOPx_RY	MARRIED	ACTIVE	03	03	03	05	03	06	01	03	200000	0	7sY-fg9b6dvKTvj36mSfOA	1980-10-05 00:00:00	S22	CG09	G21	PP12	01	01	RC01	T01	02	F8dmK7-W45wkLelmuWADcg	MEDIUM	2003-11-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2022-11-16 10:25:37.235945	SYSTEM	\N	\N	Web	\N	3d37924a-f740-4398-b576-36c5d3cdcc10
3056	CUSTOMER	01	pofgrTNm0Z7NoZukTpFgR3yyx4AYYwtHnd69KaxcSn4	6YMimlq4yOCJSrLtKSn3ig	AfKLkUHxeSY9QQGmc7WsFg	oSb2n2mvN5RrIEPaihbMnw	Mia	ramu	MALE	1997-11-30 00:00:00	Da Nang	01	-eej6hwxJXHO5Oa6nUJhjw	h54HemIa-lPohe6eFHY4c-X4e-MiZUma1j_0J6zTqTs	SINGLE	ACTIVE	01	01	01	01	01	02	11	01	91019	877887	7sY-fg9b6dvKTvj36mSfOA	1980-10-05 00:00:00	S22	CG09	G21	PP12	01	01	RC01	T01	01	F8dmK7-W45wkLelmuWADcg	MEDIUM	2003-11-20 00:00:00	f	t	f	f	f	f	\N	f	f	f	f	f	f	f	2022-12-09 09:26:23.461444	SYSTEM	\N	\N	Web	\N	207c3007-01b2-4753-a17f-4b1566fdd608
3057	CUSTOMER	01	TXCrpu473HxRfVmArtMUUTp4K8xxWsy2bHHKpeD0gNg	EUMAmci4XMblN0Axt_W2WA	AfKLkUHxeSY9QQGmc7WsFg	oSb2n2mvN5RrIEPaihbMnw	Mia	ramu	MALE	1997-11-30 00:00:00	Da Nang	01	-eej6hwxJXHO5Oa6nUJhjw	h54HemIa-lPohe6eFHY4c-X4e-MiZUma1j_0J6zTqTs	SINGLE	ACTIVE	01	01	01	01	01	02	11	01	91019	877887	7sY-fg9b6dvKTvj36mSfOA	1980-10-05 00:00:00	S22	CG09	G21	PP12	01	01	RC01	T01	01	F8dmK7-W45wkLelmuWADcg	MEDIUM	2003-11-20 00:00:00	f	t	f	f	f	f	\N	f	f	f	f	f	f	f	2022-12-09 09:32:12.229055	SYSTEM	\N	\N	Web	\N	91f56a8f-3fd7-41e8-8ad8-0ca8fdb76cb6
3054	CUSTOMER	02	sJnZBfHPqWTraIPP--AQvzp4K8xxWsy2bHHKpeD0gNg	SXjXUpxY_z-Ol92HRh7PAw	tHuJg2q3Vbd3LxkAsD_OMg	mcRwiM3XxNH4UUmKRZWSNQ			FEMALE	1979-07-28 00:00:00	Singapore	02	m0695qqcTYVs-IPwcmmSNw	etlecskqLYulUWvMGHPNvmhUt-hcvDw8tH8EjGFSMDk	MARRIED	ACTIVE	03	03	01	04	03	04	01	03	150000	0	7sY-fg9b6dvKTvj36mSfOA	1980-10-05 00:00:00	S22	CG09	G21	PP12	01	01	RC01	T01	02	F8dmK7-W45wkLelmuWADcg	LOW	2003-11-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2022-11-16 10:24:28.260834	SYSTEM	2022-12-15 05:10:41.333839	SYSTEM	Web	\N	1c0915d4-d8b7-41de-801f-7e3891261f7c
3053	CUSTOMER	01	nCwGm-bn9_hUEzvvH-ivAzp4K8xxWsy2bHHKpeD0gNg	3p1fZ34wIuSPsYMbod5o2A	rmP4rg4sbGg82VPAAeXyQw	-pz37MFYMJwMb9dU8hMOMA			MALE	1960-12-12 00:00:00	Singapore	02	R4kukBfWKEpXxZImT8pt-g	NPdVJzMQyf_4yalZynxWNOX4e-MiZUma1j_0J6zTqTs	MARRIED	ACTIVE	03	03	02	04	03	04	01	03	120000	0	7sY-fg9b6dvKTvj36mSfOA	1980-10-05 00:00:00	S22	CG09	G21	PP12	01	01	RC01	T01	02	F8dmK7-W45wkLelmuWADcg	LOW	2003-11-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2022-11-16 10:14:54.122346	SYSTEM	2022-11-30 04:46:39.989677	SYSTEM	Web	\N	5144f851-0bff-4dfa-98d8-5b4634ff9f1f
3058	CUSTOMER	01	QnUKJ9amUlW7-PZ3fFagvw	nX-IV1PWi6RLMTnOgHQSRA	IhNPxTt7F4yUqJF1HzIHBQ	CtIjFky8NvrMJGpPH2l8oA	Mi	Ji	MALE	1990-11-30 00:00:00	Da Nan	01	in8_nlt-CtO0YZ-qVW8d-g	N_j_cGD9jyXIU8YflHmtNlA42vwrb9bbgFohQsDcfcw	SINGLE	ACTIVE	01	01	01	01	01	02	11	01	91019	877887	7sY-fg9b6dvKTvj36mSfOA	1980-10-05 00:00:00	S22	CG09	G21	PP12	01	01	RC01	T01	01	F8dmK7-W45wkLelmuWADcg	MEDIUM	2009-11-20 00:00:00	f	t	f	f	f	f	\N	f	f	f	f	f	f	f	2022-12-23 12:13:27.861604	SYSTEM	\N	\N	Web	\N	4d2069d2-61f3-4326-bc69-2be7c2bb3e5c
3003	CUSTOMER	01	xG3GBnzuaYuI8PplORSJOQ	vvl5gVEWhHeJ7HphMOKlzw	CmfD9rn12RtnE_WNrE07aw	vlZNh9SQ06Y51bW3AlZ12g	Ho Lily	Ang Siong	MALE	1962-10-27 00:00:00	Singapore	02	8EYH8sDookrlISaDG532kw	-ZdS5BsxwtPXny6JegAZEfDgAwLoObof_TD8QzNhq70	MARRIED	ACTIVE	02	03	02	04	03	04	01	03	100000	0	7sY-fg9b6dvKTvj36mSfOA	1980-10-05 00:00:00	S22	CG09	G21	PP12	0	0	RC01	T01	02	80033848	LOW	2003-11-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2022-09-05 11:34:12.012074	user	2022-12-20 11:01:51.049725	SYSTEM	Web	\N	1cd37ce9-1e52-422f-88f8-bcd9c5c84bd9
3059	CUSTOMER	01	Rfq7ol_qERcESINR-TcQxg	a5pLx0OH_SUGZoK15Kdocw	2o3i7-bWSzZ6r00juiEIMQ	a5pLx0OH_SUGZoK15Kdocw	Test	Ji	MALE	2022-11-07 00:00:00	Da Nan	01	pZNRmP9GgMjtWYy3hPlyeQ	B5wIEzKpdgB01_53fMQvYuX4e-MiZUma1j_0J6zTqTs	SINGLE	ACTIVE	01	01	01	01	01	02	11	01	91019	877887	7sY-fg9b6dvKTvj36mSfOA	1980-10-05 00:00:00	S22	CG09	G21	PP12	01	01	RC01	T01	01	F8dmK7-W45wkLelmuWADcg	MEDIUM	2009-11-20 00:00:00	f	t	f	f	f	f	\N	f	f	f	f	f	f	f	2022-12-28 12:04:13.847225	SYSTEM	\N	\N	Web	\N	fd3e61e3-2169-48ba-a46a-083fb2f50240
3060	CUSTOMER	01	Rfq7ol_qERcESINR-TcQxg	a5pLx0OH_SUGZoK15Kdocw	2o3i7-bWSzZ6r00juiEIMQ	a5pLx0OH_SUGZoK15Kdocw	Test	Ji	MALE	2022-11-07 00:00:00	Da Nan	01	m99unVXKuU8U8hdNQT9afQ	B5wIEzKpdgB01_53fMQvYuX4e-MiZUma1j_0J6zTqTs	SINGLE	ACTIVE	01	01	01	01	01	02	11	01	91019	877887	7sY-fg9b6dvKTvj36mSfOA	1980-10-05 00:00:00	S22	CG09	G21	PP12	01	01	RC01	T01	01	F8dmK7-W45wkLelmuWADcg	MEDIUM	2009-11-20 00:00:00	f	t	f	f	f	f	\N	f	f	f	f	f	f	f	2022-12-29 03:46:37.440765	SYSTEM	\N	\N	Web	\N	faeb7aba-262c-40a5-8125-b4e8a65e407f
3062	CUSTOMER	01	Rfq7ol_qERcESINR-TcQxg	a5pLx0OH_SUGZoK15Kdocw	2o3i7-bWSzZ6r00juiEIMQ	a5pLx0OH_SUGZoK15Kdocw	Test	Ji	MALE	2022-11-07 00:00:00	Da Nan	01	_H2urY6pgklkOKoLJZhE-w	B5wIEzKpdgB01_53fMQvYuX4e-MiZUma1j_0J6zTqTs	SINGLE	ACTIVE	01	01	01	01	01	02	11	01	91019	877887	7sY-fg9b6dvKTvj36mSfOA	1980-10-05 00:00:00	S22	CG09	G21	PP12	01	01	RC01	T01	01	F8dmK7-W45wkLelmuWADcg	MEDIUM	2009-11-20 00:00:00	f	t	f	f	f	f	\N	f	f	f	f	f	f	f	2022-12-29 03:57:37.226926	SYSTEM	\N	\N	Web	\N	58818607-d870-4565-aded-586472186207
3063	CUSTOMER	01	V0Bm2sz6fnkltXb8Z8HmnA	VQwhiZmGST3v_6d3z8hBqQ	rmP4rg4sbGg82VPAAeXyQw	l6fj2IQwq184OrN-asUxFA			MALE	1958-12-24 00:00:00	Singapore	02	ij_V0N2IXk60CliSZEG8DA	djru5RoCcq8B1YeZIIbpoXg9v5uMybmJkEILvOPx_RY	MARRIED	ACTIVE	03	03	02	04	03	04	01	03	120000	0	7sY-fg9b6dvKTvj36mSfOA	1980-10-05 00:00:00	S22	CG09	G21	PP12	01	01	RC01	T01	02	F8dmK7-W45wkLelmuWADcg	LOW	2003-11-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2022-12-29 06:24:04.771085	SYSTEM	\N	\N	Web	\N	a431862d-7c9c-4cc4-826e-8665585d656e
3066	CUSTOMER	01	7jj38DdwqMy7J3dWQW8F2Dp4K8xxWsy2bHHKpeD0gNg	jtukl-RklYB7Y9OsX0tMOg		bUfUWoBY38RWawH49kQw_g			MALE	1971-11-28 00:00:00	Singapore	02	ya8SrmmV7WhPSE2vpDCbvw	g_cYm7tU49wXykbDe_aOGfgdEou1W3gTG60BkZ2ttWE	MARRIED	ACTIVE	03	03	04	03	03	06	01	03	175000	0	7sY-fg9b6dvKTvj36mSfOA	1980-10-05 00:00:00	S22	CG09	G21	PP12	01	01	RC01	T01	02	F8dmK7-W45wkLelmuWADcg	LOW	2003-11-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2022-12-29 06:25:50.566485	SYSTEM	2022-12-29 06:56:35.771116	SYSTEM	Web	\N	31e5e0c4-4a5a-44ff-8bb4-f8f7c861fc52
3068	CUSTOMER	03	TpVLdccGkGrKqo-bK-go1KXA80mbvRssZrO27iDPxqA	XRnsT3H06-e-DL3JA2NDIg	BbfyQzT_sG-kuy9_yjm9rg	Su-Sp7XlzIaQyuBppiBPCw			MALE	1980-01-19 00:00:00	Singapore	02	k3TTnNP38a-1OFNxYq8XRA	pm26j-YxWtnIPXHH3U3KOTlzK3tDf3CRnOflXlUhNnA	MARRIED	ACTIVE	03	03	03	05	03	06	01	03	200000	0	7sY-fg9b6dvKTvj36mSfOA	1980-10-05 00:00:00	S22	CG09	G21	PP12	01	01	RC01	T01	02	F8dmK7-W45wkLelmuWADcg	MEDIUM	2003-11-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2022-12-29 10:03:18.643088	SYSTEM	\N	\N	Web	\N	89983025-c27f-431c-a66f-d952e8cd3e33
3073	CUSTOMER	01	P5t0sFLLcXMuGDJoPCBuMg	9AmvPtBF_pMaapLZ76OZag	cyqY9LIP3fLGycJdHIBQlw	D4xudwNTiRbI5QLPpaQv5g			MALE	1985-07-01 00:00:00	Singapore	02	JyVFM6puAUPPGhB1F-zegg	9Kbr3gtoqeztFL-SNJPhLl9wdK-t9AlLqcLgIjHnOpI	MARRIED	ACTIVE	03	03	01	03	04	03	01	03	51000	0	7sY-fg9b6dvKTvj36mSfOA	1980-10-05 00:00:00	S22	CG09	G21	PP12	01	01	RC01	T01	02	F8dmK7-W45wkLelmuWADcg	HIGH	2003-11-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2022-12-29 11:02:03.132837	SYSTEM	\N	\N	Web	\N	b41f550c-3637-4c14-93ff-668b12538898
3069	CUSTOMER	03	HPzAldjRKf9cULINTcBheh6ye37tPjTFQTUMgZ9zjdU	zAFnSStVmsvQ4f6yUEHsSg	HN6mAceChXJc-9N8HsmBKQ	YPmIwvVKYcSb5kxbQhu61w			MALE	1980-01-19 00:00:00	Singapore	02	9VJ2ofuOe2v9gx4Coql8eQ	qQVcMHFMjhc0OMAaXQANXeX4e-MiZUma1j_0J6zTqTs	MARRIED	BLOCKED	03	03	03	05	03	06	01	03	200000	0	7sY-fg9b6dvKTvj36mSfOA	1980-10-05 00:00:00	S22	CG09	G21	PP12	01	01	RC01	T01	02	F8dmK7-W45wkLelmuWADcg	MEDIUM	2003-11-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2022-12-29 10:10:03.549661	SYSTEM	2023-05-06 05:57:21.7794	SYSTEM	Web	\N	f9f2b657-ea78-4422-9d03-78c33478303f
3061	CUSTOMER	01	Rfq7ol_qERcESINR-TcQxg	a5pLx0OH_SUGZoK15Kdocw	2o3i7-bWSzZ6r00juiEIMQ	a5pLx0OH_SUGZoK15Kdocw	Test	Ji	MALE	2022-11-07 00:00:00	Da Nan	01	GQu0p2NnLED31_8zL5AAaQ	B5wIEzKpdgB01_53fMQvYuX4e-MiZUma1j_0J6zTqTs	SINGLE	ACTIVE	01	01	01	01	01	02	11	01	91019	877887	7sY-fg9b6dvKTvj36mSfOA	1980-10-05 00:00:00	S22	CG09	G21	PP12	01	01	RC01	T01	01	F8dmK7-W45wkLelmuWADcg	MEDIUM	2009-11-20 00:00:00	f	t	f	f	f	f	\N	f	f	f	f	f	f	f	2022-12-29 03:49:41.949576	SYSTEM	\N	\N	Web	\N	e7dd9ef7-a389-48eb-98a6-cc96abe9cf54
3064	CUSTOMER	02	3YjiG6HmuLNNi2O3mO6QrGnkK7f_UhiAG9APhHfz2lk	HBz4PXC1IYQnbyboFizeSQ	tHuJg2q3Vbd3LxkAsD_OMg	XD2oe3lKXm7Vj6mAkKfyNg			FEMALE	1989-03-09 00:00:00	Singapore	02	RTmj5zPJrA0thnrhpfGweg	fLN-AcgxK9UZpF_FqxR7Id0qmPuuXg6mutUEfxDn9S0	MARRIED	ACTIVE	03	03	01	04	03	04	01	03	150000	0	7sY-fg9b6dvKTvj36mSfOA	1980-10-05 00:00:00	S22	CG09	G21	PP12	01	01	RC01	T01	02	F8dmK7-W45wkLelmuWADcg	LOW	2003-11-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2022-12-29 06:25:39.651475	SYSTEM	\N	\N	Web	\N	6c0ff053-c2a5-4ffa-b50f-ecf8e4d60e9f
3065	CUSTOMER	03	R1NFoE8QLNWCz6veKb8uP2pa2FQkKvNGYdfE5Gz_jb4	gS816ZKnEIXs4rytyKPcWA	3WRgzbAbg0CT1C9QQAQJvw	apZQElMH7nlpIIXczkMrvw			MALE	1980-01-19 00:00:00	Singapore	02	36zteh9Iunfg_kuh0JGzQw	iA3lVZ9JPfPEV8CWxlL_JXV5-HcU-FL8on1XaMxmo8k	MARRIED	ACTIVE	03	03	03	05	03	06	01	03	200000	0	7sY-fg9b6dvKTvj36mSfOA	1980-10-05 00:00:00	S22	CG09	G21	PP12	01	01	RC01	T01	02	F8dmK7-W45wkLelmuWADcg	MEDIUM	2003-11-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2022-12-29 06:25:45.104182	SYSTEM	\N	\N	Web	\N	9305f63f-74d8-4e68-b655-ec99e2338b21
3067	CUSTOMER	02	SsLLXImYz4Go0Vpoc3C02cXlzHxshxhYV3D3ZYBVzdQ	GnC0iAhqjaNzLoVS0wUoyA		cyoTUmhFqHdFQywu9mJlfw			FEMALE	1985-10-01 00:00:00	Singapore	02	DBW78RD34XOnBDqaAwi18A	MOrn2giaxjkqb5yVYcmmkEs2yVgiepmL9xyUm54CnK4	MARRIED	BLOCKED	03	03	01	03	04	03	01	03	60000	0	7sY-fg9b6dvKTvj36mSfOA	1980-10-05 00:00:00	S22	CG09	G21	PP12	01	01	RC01	T01	02	F8dmK7-W45wkLelmuWADcg	HIGH	2003-11-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2022-12-29 06:25:55.992137	SYSTEM	\N	\N	Web	\N	9ff275f7-7504-4d3c-a475-942308aa7dd0
3075	CUSTOMER	01	QnUKJ9amUlW7-PZ3fFagvw	nX-IV1PWi6RLMTnOgHQSRA	IhNPxTt7F4yUqJF1HzIHBQ	CtIjFky8NvrMJGpPH2l8oA	Mi	Ji	MALE	1990-11-30 00:00:00	Da Nan	01	lqMS03urCzWhpyaaYW-WCA	bNbCKtZxmjd9I7E8kx8A6FA42vwrb9bbgFohQsDcfcw	SINGLE	ACTIVE	01	01	01	\N	\N	02	\N	01	\N	\N	\N	\N	S22	\N	G21	PP12	01	01	RC01	T01	01	F8dmK7-W45wkLelmuWADcg	MEDIUM	2009-11-20 00:00:00	f	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-03-07 06:42:40.34825	SYSTEM	\N	\N	Web	\N	e818ec02-a153-46ee-b28c-5cdd8cc7f4c4
3076	CUSTOMER	01	pofgrTNm0Z7NoZukTpFgR3yyx4AYYwtHnd69KaxcSn4	6YMimlq4yOCJSrLtKSn3ig	AfKLkUHxeSY9QQGmc7WsFg	oSb2n2mvN5RrIEPaihbMnw	Mia	ramu	MALE	1987-11-30 00:00:00	Da Nang	01	MIZzc-NArn3qtV_f83am5w	Sr8aKB4Tf1y9Rk4xZPejx1A42vwrb9bbgFohQsDcfcw	SINGLE	ACTIVE	01	01	01	01	01	02	11	01	91019	877887	7sY-fg9b6dvKTvj36mSfOA	1980-10-05 00:00:00	S22	CG09	G21	PP12	01	01	RC01	T01	01	F8dmK7-W45wkLelmuWADcg	MEDIUM	2003-11-20 00:00:00	f	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-03-24 08:59:04.782659	SYSTEM	\N	\N	Web	\N	3a3e09dc-093a-4659-9fb0-2d189e31cb4a
3077	CUSTOMER	01	_NrI1ISdFv5ebdSFFnsh6nw_wFjmqpFU4S2uVgcu16Q	t5k_BgkNfGgmwbQPpCAVJw	AfKLkUHxeSY9QQGmc7WsFg	oSb2n2mvN5RrIEPaihbMnw	Mia	ramu	MALE	1987-11-30 00:00:00	Da Nang	01	oCitH_mPMWgaPSLAJrXUVg	Kbz_5FGtZdPPftp46pcAcfDgAwLoObof_TD8QzNhq70	SINGLE	ACTIVE	01	01	01	01	01	02	11	01	91019	877887	7sY-fg9b6dvKTvj36mSfOA	1980-10-05 00:00:00	S22	CG09	G21	PP12	01	01	RC01	T01	01	F8dmK7-W45wkLelmuWADcg	MEDIUM	2003-11-20 00:00:00	f	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-03-24 11:12:01.019983	SYSTEM	\N	\N	Web	\N	e859a6f7-7fdf-4f47-9d9b-cb1ae1d29e9f
3078	CUSTOMER	01	-Yt1cOEyVJWLMddclmzWufYFKFH3NKa35NSSDeETpPo	7hNUh_n2qZZvmpvhvLmTug	AfKLkUHxeSY9QQGmc7WsFg	oSb2n2mvN5RrIEPaihbMnw	Mia	Mohan	MALE	1987-11-30 00:00:00	Da Nang	01	OgSrR-GSbXcUy-Xp2Ov8YQ	YD5PkUNJISjiz0CBqyFE21A42vwrb9bbgFohQsDcfcw	SINGLE	ACTIVE	01	01	01	01	01	02	11	01	91019	877887	7sY-fg9b6dvKTvj36mSfOA	1980-10-05 00:00:00	S22	CG09	G21	PP12	01	01	RC01	T01	01	F8dmK7-W45wkLelmuWADcg	MEDIUM	2003-11-20 00:00:00	f	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-03-24 11:18:07.817083	SYSTEM	\N	\N	Web	\N	61ac724b-9478-45d8-8353-cb94073e1379
3071	CUSTOMER	01	-3iERz42xa3lXaGHhPp41Q	hkxIPbHf-WUYQeUYXt4WfA	5GsTisIO1iEJpHEBgcvTaA	vOw2wUu75MtfDXRW5RyXmA			MALE	1989-12-09 00:00:00	Singapore	02	CMXhr8Fc_NvssdBVv-SzlA	dwEVgIrIkUWT_gBl1_7hnjyN7jlk3d4Z17CfbR_SZIk	MARRIED	ACTIVE	03	03	01	04	03	04	01	03	140000	0	7sY-fg9b6dvKTvj36mSfOA	1980-10-05 00:00:00	S22	CG09	G21	PP12	01	01	RC01	T01	02	F8dmK7-W45wkLelmuWADcg	LOW	2003-11-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2022-12-29 11:01:46.932567	SYSTEM	2023-03-27 05:09:31.815997	SYSTEM	Web	\N	e611af51-6d3a-4e33-9df1-ae53dbcfd532
3070	CUSTOMER	01	6L9exeOrnVhZ9PCBBhpMuw	qRN0_pXB10CtlFnxXNX8VQ	raHprgU7_P6o40WQQh_0AQ	5tlZv5h3t3ZXU2USUZ3HVw			MALE	1958-01-29 00:00:00	Singapore	02	DwRYHybj0e2mmAaSJDCuGw	vLmvJD941Qe0I3eMlOHZRFA42vwrb9bbgFohQsDcfcw	MARRIED	ACTIVE	03	03	02	04	03	04	01	03	160000	0	7sY-fg9b6dvKTvj36mSfOA	1980-10-05 00:00:00	S22	CG09	G21	PP12	01	01	RC01	T01	02	F8dmK7-W45wkLelmuWADcg	LOW	2003-11-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2022-12-29 11:01:41.486476	SYSTEM	2023-08-29 10:06:35.200997	SYSTEM	Web	\N	71c3519d-5380-46e8-a457-71e091e632d2
3084	CUSTOMER	01	6iCyYN7tnyxsBXzoXgvzDg	3aIlXoWjVI2ogtQqkReSCQ	\N	87K5yn8KiJcbkepVWDBC4w	\N	\N	MALE	1988-11-30 00:00:00	Da Nang	02	o9B8YScxjV_KDVPzM0clrg	2_qnE6VzikkVT-9eZzIVyEk6Opz8oLdql1IhA0pLZMg	SINGLE	ACTIVE	\N	\N	\N	\N	\N	\N	\N	03	\N	\N	\N	\N	\N	\N	\N	\N	04	\N	\N	\N	02	NMd5mtmu7CFw5Chn-di7ng	\N	\N	f	\N	f	f	f	f	\N	f	f	f	f	f	f	f	2023-03-28 07:01:10.90524	SYSTEM	\N	\N	\N	\N	ad3989b0-6a46-4304-8ac2-0e9f2c7c5bd3
3085	CUSTOMER	02	GdOOqiIOppTYYBzHkUDH_A	RFZBJ1rK3agByaItuzuOug	\N	0tCcgHKVo8RQAHPwM1OTag	\N	\N	FEMALE	1987-11-30 00:00:00	Klook	02	Vu4UqQ7xhLKwqHniN3u03g	qaFD5HJJuGd9XLyrfBW7YA	SINGLE	ACTIVE	\N	\N	\N	\N	\N	\N	\N	03	\N	\N	\N	\N	\N	\N	\N	\N	04	\N	\N	\N	02	Rnu1w0byimKsLb8ifZp2Fw	\N	\N	f	\N	f	f	f	f	\N	f	f	f	f	f	f	f	2023-03-28 07:05:42.161707	SYSTEM	\N	\N	\N	\N	762c8c48-5a5b-40b0-ab49-63623d1ddcff
3074	CUSTOMER	02	esJxBuniIczRb_GI4qSD8g	fJ8jE6q8O9UJoe18ZVPGeg	iqwdgtQhb6iNp9QY_75bfg	G9lP2XKblRzI00nvkRkr9A			FEMALE	1971-06-28 00:00:00	Singapore	02	anFGDa-9ZczqVKk7YId4Fg	7Ltdqa-sB0T2pZrSgtZI4mDYCA78i8bA7z-tY3dEmX8	MARRIED	ACTIVE	03	03	04	03	03	06	01	03	185000	0	7sY-fg9b6dvKTvj36mSfOA	1980-10-05 00:00:00	S22	CG09	G21	PP12	01	01	RC01	T01	02	F8dmK7-W45wkLelmuWADcg	LOW	2003-11-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2022-12-29 11:03:59.338319	SYSTEM	2023-04-03 06:42:51.12646	SYSTEM	Web	\N	13398561-7718-47d2-ad74-289ecf1cf2f1
3072	CUSTOMER	02	b2TKQLhWiBe-wtVpf7ft0Q	kxsJGnyRhYr_xseZAq_KIg	aF8RWKW7PywYoIjPqAZdiQ	JXH1qIgy-GH8-4O_TL-6ag		Jia	FEMALE	1980-11-09 00:00:00	Singapore	02	UitN0Dc4a_NPw6-7TVnjgA	U6Vwn73ZT8UmnSO5SL2t5cPz35zOOlx4uePXVKNpfJE	SINGLE	ACTIVE	03	03	03	05	03	06	01	03	220000	0	7sY-fg9b6dvKTvj36mSfOA	1980-10-05 00:00:00	S22	CG09	G21	PP12	01	01	RC01	T01	2	PFhK4VdztE7sDIyuFx7frA	MEDIUM	2003-11-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2022-12-29 11:01:52.357176	SYSTEM	2023-07-18 09:49:58.084657	SYSTEM	Web	Web	cb257244-7216-4160-ab5c-c979604683c3
3088	CUSTOMER	02	a0dS7v8_CgQ_f28tFZ90yw	RKH1o0MXhDb-nmdm2_PyBQ	\N	0tCcgHKVo8RQAHPwM1OTag	\N	\N	FEMALE	1994-11-12 00:00:00	Bay Sands	02	gfPjxVD0SCNvddy1xZO3Vg	ntG4ckBFHNpp_ieIZH6aRQ	SINGLE	ACTIVE	\N	\N	\N	\N	\N	\N	\N	03	\N	\N	\N	\N	\N	\N	\N	\N	04	\N	\N	\N	02	KJDGeTZsu9Z7xk_Gundk7w	\N	\N	f	\N	f	f	f	f	\N	f	f	f	f	f	f	f	2023-03-28 07:11:56.721058	SYSTEM	\N	\N	\N	\N	c7044e2a-a32e-4d43-9bff-61f2d9a8dae8
3102	CUSTOMER	01	Rfq7ol_qERcESINR-TcQxg	fQUxMGQzRonSylD08YDqSw	2o3i7-bWSzZ6r00juiEIMQ	a5pLx0OH_SUGZoK15Kdocw	Test	Ji	MALE	2022-11-07 00:00:00	Da Nan	01	X4Jug5QgUt01xQUffRt0eQ	B5wIEzKpdgB01_53fMQvYuX4e-MiZUma1j_0J6zTqTs	SINGLE	BLOCKED	01	01	01	01	01	02	11	01	91019	877887	7sY-fg9b6dvKTvj36mSfOA	1980-10-05 00:00:00	S22	CG09	G21	PP12	01	01	RC01	T01	01	F8dmK7-W45wkLelmuWADcg	MEDIUM	2009-11-20 00:00:00	f	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-06-12 05:12:59.251634	SYSTEM	2023-06-12 12:50:34.421021	SYSTEM	Web	\N	1cf2355d-c4e7-451c-a51a-3a9718877b3e
3090	CUSTOMER	01	yajaUQ3yu-0GujvC7J6c5g	wW-NB514D8Oux5P4UkPoOw	\N	ULap3wmQj32ge7oA0_cyHQ	\N	\N	MALE	1978-09-12 00:00:00	Delhi	03	ijVkm0_jt7PcskKGOUIMfg	ttew2dPxmgE39FACzFjh3tCMM_PYKdes2hhdd840FeM	SINGLE	ACTIVE	\N	\N	\N	\N	\N	\N	\N	02	\N	\N	\N	\N	\N	\N	\N	\N	01	\N	\N	\N	02	LuCxejtMg3hFTi9QTgw11A	\N	\N	f	\N	f	f	f	f	\N	f	f	f	f	f	f	f	2023-05-23 06:08:54.053304	SYSTEM	\N	\N	\N	\N	8b83db56-489f-4539-b446-e30a125812d6
3091	CUSTOMER	01	1VREcYk3nBwyfLsErcxeXA	YGEJOb9Bu64wSAfkZoJHJw	\N	oSb2n2mvN5RrIEPaihbMnw	\N	\N	MALE	1988-02-17 00:00:00	UP	03	3HO7T8_hSquX-6MKPa3KgA	GqKACutygfDxERBT4Nb8WxmI3j5KoMBqBTxatcVdR1I	SINGLE	ACTIVE	\N	\N	\N	\N	\N	\N	\N	02	\N	\N	\N	\N	\N	\N	\N	\N	01	\N	\N	\N	02	OSb0r08EvtsvjS7XxR4qpw	\N	\N	f	\N	f	f	f	f	\N	f	f	f	f	f	f	f	2023-05-23 06:13:37.169084	SYSTEM	\N	\N	\N	\N	bddc5d2f-5285-4890-96f2-105906005e50
3092	CUSTOMER	01	yw1w_K02NbfplkF_0AWJIQ	NZsRNoNK1x3A42xCsqNSBg	\N	c2M48mGeVdfO9DW1yxVAyA	\N	\N	MALE	1982-04-09 00:00:00	MP	03	Nslj8I56SCciG-kCTHjW5A	hX4aq8lShzFAgii0qgalPNCMM_PYKdes2hhdd840FeM	SINGLE	ACTIVE	\N	\N	\N	\N	\N	\N	\N	02	\N	\N	\N	\N	\N	\N	\N	\N	01	\N	\N	\N	02	xXh3wqK141CzcdR1gYfe7w	\N	\N	f	\N	f	f	f	f	\N	f	f	f	f	f	f	f	2023-05-23 06:17:36.020483	SYSTEM	\N	\N	\N	\N	a6d2fbe5-2bcb-498c-a77a-93469902df6f
3093	CUSTOMER	01	DtzNNx5G5tQOXYIHcbIxSDp4K8xxWsy2bHHKpeD0gNg	_-ImlCYZ2GDU2uPaQcn--Q	\N	oSb2n2mvN5RrIEPaihbMnw	\N	\N	MALE	1992-04-04 00:00:00	Punjab	03	TnBHG7gMVyuyYfdkbvzElw	2CAHO_6EcjmfdwjJ4SyCZ88TmMjvCF0EZiLbRbRuG4g	SINGLE	ACTIVE	\N	\N	\N	\N	\N	\N	\N	02	\N	\N	\N	\N	\N	\N	\N	\N	01	\N	\N	\N	02	9Qqz6plMBddbkLkw04mU1Q	\N	\N	f	\N	f	f	f	f	\N	f	f	f	f	f	f	f	2023-05-23 06:19:52.989982	SYSTEM	\N	\N	\N	\N	c26e4b8f-2677-4b68-b8ea-74e2a73a4b3b
3094	CUSTOMER	01	Rfq7ol_qERcESINR-TcQxg	a5pLx0OH_SUGZoK15Kdocw	2o3i7-bWSzZ6r00juiEIMQ	a5pLx0OH_SUGZoK15Kdocw	Test	Ji	MALE	2022-11-07 00:00:00	Da Nan	01	NGdkEzjkx4BYEhi9j82-SA	B5wIEzKpdgB01_53fMQvYuX4e-MiZUma1j_0J6zTqTs	SINGLE	ACTIVE	01	01	01	01	01	02	11	01	91019	877887	7sY-fg9b6dvKTvj36mSfOA	1980-10-05 00:00:00	S22	CG09	G21	PP12	01	01	RC01	T01	01	F8dmK7-W45wkLelmuWADcg	MEDIUM	2009-11-20 00:00:00	f	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-05-29 05:52:20.724923	SYSTEM	\N	\N	Web	\N	4041e6df-c375-49d9-a0f2-be73eafd5272
3095	CUSTOMER	01	Rfq7ol_qERcESINR-TcQxg	a5pLx0OH_SUGZoK15Kdocw	2o3i7-bWSzZ6r00juiEIMQ	a5pLx0OH_SUGZoK15Kdocw	Test	Ji	MALE	2022-11-07 00:00:00	Da Nan	01	xDStTdNSJcJ3_GV9D6nB_A	B5wIEzKpdgB01_53fMQvYuX4e-MiZUma1j_0J6zTqTs	SINGLE	ACTIVE	01	01	01	01	01	02	11	01	91019	877887	7sY-fg9b6dvKTvj36mSfOA	1980-10-05 00:00:00	S22	CG09	G21	PP12	01	01	RC01	T01	01	F8dmK7-W45wkLelmuWADcg	MEDIUM	2009-11-20 00:00:00	f	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-05-29 06:03:10.1946	SYSTEM	\N	\N	Web	\N	ac056fec-4e70-410b-865a-77be457977ce
3104	CUSTOMER	01	KPNxzT-ZAyd8Wa7coicfTw	bI5JDL3cDTR6ioUDS1OciQ		yX3CF6PS3bf7N55OJIJMxA		Ankur	MALE	1989-11-12 00:00:00	New Delhi	04	vrJibfm69nxik0vLKWpV5A	sd47oug5tFEwI0AzReGd80LFhOKvwANn9RcTYIQyUow	MARRIED	ACTIVE	04	05	02	\N	\N	02	\N	02	\N	\N	\N	\N	\N	\N	\N	\N	04	\N	\N	\N	02	UHrxXPRmXkrhuNKgjf504Q	\N	\N	t	\N	f	f	f	f	\N	f	f	f	f	f	f	f	2023-07-10 11:15:25.661665	SYSTEM	\N	\N	Web	\N	bdeb92ce-f97f-4ac7-9232-49aa2eaa1dce
3100	CUSTOMER	01	Rfq7ol_qERcESINR-TcQxg	a5pLx0OH_SUGZoK15Kdocw	2o3i7-bWSzZ6r00juiEIMQ	a5pLx0OH_SUGZoK15Kdocw	Test	Ji	MALE	2022-11-07 00:00:00	Da Nan	01	WTve6Fm5cfY3RLloJ8otWw	B5wIEzKpdgB01_53fMQvYuX4e-MiZUma1j_0J6zTqTs	SINGLE	ACTIVE	01	01	01	01	01	02	11	01	91019	877887	7sY-fg9b6dvKTvj36mSfOA	1980-10-05 00:00:00	S22	CG09	G21	PP12	01	01	RC01	T01	01	F8dmK7-W45wkLelmuWADcg	MEDIUM	2009-11-20 00:00:00	f	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-06-09 14:36:39.213182	SYSTEM	\N	\N	Web	\N	8bd1a013-9d56-4d80-b79c-d62db149850c
3099	CUSTOMER	01	ok-3yhvUlblBua5n62W6pSlaRouMPh_OxbjAsKPhJ8g	9j4rxPBA3vp6t0EHHwKNwA	PQhVDLryGvWpGNXEs3jTUw	MQRd5aKYi5R2QJgjQ5rEaw		David	MALE	1989-11-13 00:00:00	United States	02	cgTZi28xhd8hXc-nXcEwjg	add7H8vAEqjQjqUfbyCwDQICX95WCGaQa_1dmX-PKuc	MARRIED	ACTIVE	03	03			03	05	01	04	129548	0	7sY-fg9b6dvKTvj36mSfOA	1980-10-05 00:00:00	S22	CG09	G21	PP12	01	01	RC01	T01	02	F8dmK7-W45wkLelmuWADcg	LOW	2003-11-20 00:00:00	t	f	f	f	f	f	\N	f	f	f	f	f	f	f	2023-06-09 12:17:35.970724	SYSTEM	2023-06-12 05:31:07.661292	SYSTEM	Web	\N	afaf081e-c862-4577-9689-dd154a1ad253
3098	CUSTOMER	01	ok-3yhvUlblBua5n62W6pSlaRouMPh_OxbjAsKPhJ8g	9j4rxPBA3vp6t0EHHwKNwA	PQhVDLryGvWpGNXEs3jTUw	MQRd5aKYi5R2QJgjQ5rEaw		David	MALE	1998-11-13 00:00:00	United States	02	D9TpUKVUILy8XScQD0DaZA	add7H8vAEqjQjqUfbyCwDQICX95WCGaQa_1dmX-PKuc	MARRIED	ACTIVE	03	03			03	05	01	033	129548	0	7sY-fg9b6dvKTvj36mSfOA	1980-10-05 00:00:00	S22	CG09	G21	PP12	01	01	RC01	T01	02	F8dmK7-W45wkLelmuWADcg	LOW	2003-11-20 00:00:00	t	f	f	f	f	f	\N	f	f	f	f	f	f	f	2023-06-09 10:13:24.492909	SYSTEM	\N	\N	Web	\N	297df89f-11ae-438e-8778-b853fcb5d83d
3101	CUSTOMER	01	Rfq7ol_qERcESINR-TcQxg	a5pLx0OH_SUGZoK15Kdocw	2o3i7-bWSzZ6r00juiEIMQ	a5pLx0OH_SUGZoK15Kdocw	Test	Ji	MALE	2022-11-07 00:00:00	Da Nan	01	GkSfJfcnagICD5VRcasEGA	B5wIEzKpdgB01_53fMQvYuX4e-MiZUma1j_0J6zTqTs	SINGLE	ACTIVE	01	01	01	01	01	02	11	01	91019	877887	7sY-fg9b6dvKTvj36mSfOA	1980-10-05 00:00:00	S22	CG09	G21	PP12	01	01	RC01	T01	01	F8dmK7-W45wkLelmuWADcg	MEDIUM	2009-11-20 00:00:00	f	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-06-12 05:08:21.57673	SYSTEM	\N	\N	Web	\N	b15770a1-8798-412a-a4b3-21e14f902973
3097	CUSTOMER	01	Cp9p5Fc4m_wAbL9kAv3Y99TdUP-PZvNg-GOsuY1huCc	dw2zpH-QpZF3b0YZ-gJeig	2OjNFDpnwlDFz-tUNEgN0g	QqK2I0Mi4cILuEnq39KnQfadz9MSzTfQNsZiYm2pmpc	Jackson	John	MALE	1988-04-22 00:00:00	Washington	05	YXQ109sktG3KtW9rOIT82A	-9F0LaXyo07bbxaKkSaFoDeLiOZ2q9XI9d2mqVBWgBQ	MARRIED	ACTIVE	04	03		04	03	05	01	04	160000	0	7sY-fg9b6dvKTvj36mSfOA	1980-10-05 00:00:00	S22	CG09	G21	PP12	01	01	RC01	T01	02	F8dmK7-W45wkLelmuWADcg	LOW	2003-11-20 00:00:00	t	f	f	f	f	f	\N	f	f	f	f	f	f	f	2023-06-09 10:10:08.432798	SYSTEM	2023-08-28 11:30:29.669945	SYSTEM	Web	\N	27efd8c0-7cca-4f59-b78f-7eda158e9994
3103	CUSTOMER	01	Rfq7ol_qERcESINR-TcQxg	a5pLx0OH_SUGZoK15Kdocw	2o3i7-bWSzZ6r00juiEIMQ	a5pLx0OH_SUGZoK15Kdocw	Test	Ji	MALE	2022-11-07 00:00:00	Da Nan	01	WGf2UEmS4G7aKew2p61S5g	B5wIEzKpdgB01_53fMQvYuX4e-MiZUma1j_0J6zTqTs	SINGLE	ACTIVE	01	01	01	01	01	02	11	01	91019	877887	7sY-fg9b6dvKTvj36mSfOA	1980-10-05 00:00:00	S22	CG09	G21	PP12	01	01	RC01	T01	01	F8dmK7-W45wkLelmuWADcg	MEDIUM	2009-11-20 00:00:00	f	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-06-22 08:20:26.1474	SYSTEM	\N	\N	Web	\N	a9fa4ffa-1b3c-4792-820b-9f42dd8f8bb6
3105	CUSTOMER	01	7_v_XOyG2m8ob1E-SNsaJVyd4Ws-fp_OeFaEXV2kwmk	Abs45iDn5VJJPx-0l8M9Cw	JUiEdl8KQBa9VLPJ2zfpbA	MitcmfbLXw59AgJfUByKMg	Mia	Jo	MALE	1997-11-30 00:00:00	Da Nang	01	oEuCkStdpQ71jxzjUwDfSQ	h54HemIa-lPohe6eFHY4c-X4e-MiZUma1j_0J6zTqTs	SINGLE	ACTIVE	01	01	01	01	01	02	03	01	91019	877887	7sY-fg9b6dvKTvj36mSfOA	1980-10-05 00:00:00	S22	01	G21	PP12	01	01	RC01	T01	01	F8dmK7-W45wkLelmuWADcg	MEDIUM	2003-11-20 00:00:00	f	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-08-09 04:42:20.652915	SYSTEM	\N	\N	Web	\N	1234578810
3089	CUSTOMER	01	kHcQPPmzTMTHe3jQhIAfmg	Vm7zwTRjtd58L_wfvRTUEQ	\N	JNLBNSMV02tpy-UMq9nKzA	\N	\N	MALE	1988-11-30 00:00:00	Delhi	03	o9B8YScxjV_KDVPzM0clrg	2WmtLtQbS9zehvNq_qdrHVA42vwrb9bbgFohQsDcfcw	SINGLE	ACTIVE	\N	\N	\N	\N	\N	\N	\N	02	\N	\N	\N	\N	\N	\N	\N	\N	01	\N	\N	\N	02	NMd5mtmu7CFw5Chn-di7ng	\N	\N	f	\N	f	f	f	f	\N	f	f	f	f	f	f	f	2023-05-23 05:51:21.745299	SYSTEM	2023-11-24 14:05:00.399682	SYSTEM	\N	\N	8ba3aeb4-d7b8-4885-b3c4-106b253e21f8
3106	CUSTOMER	01	7_v_XOyG2m8ob1E-SNsaJVyd4Ws-fp_OeFaEXV2kwmk	Abs45iDn5VJJPx-0l8M9Cw	JUiEdl8KQBa9VLPJ2zfpbA	MitcmfbLXw59AgJfUByKMg	Mia	Jo	MALE	1997-11-30 00:00:00	Da Nang	01	apnREW-qFJe6AV9eNyM_pw	yk6IL-imurdRjRBA-aqR_z214w_gem8Z_jRe8qrGUOk	SINGLE	ACTIVE	01	01	01	01	01	02	03	01	91019	877887	7sY-fg9b6dvKTvj36mSfOA	1980-10-05 00:00:00	S22	01	G21	PP12	01	01	RC01	T01	01	F8dmK7-W45wkLelmuWADcg	MEDIUM	2003-11-20 00:00:00	f	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-08-09 04:43:19.091442	SYSTEM	\N	\N	Web	\N	1234578811
3114	CUSTOMER	01	PQif3e4yBvXoaDmVSOoFFzvA-SvdrKHPP3eAts4eNCc	pg6WiYNdzhUgAQ05IjxUVw	6a70OR2vofPeiRLxidPZXQ	oSb2n2mvN5RrIEPaihbMnw	Test	Test	MALE	2023-08-03 00:00:00	Bhopal	01	2kpjYHAU0OQKgyE_Toa7SQ	aGTSiHmtQ4TFzPnjNVahoF9wdK-t9AlLqcLgIjHnOpI	MARRIED	ACTIVE	01	01	01	01	01	01	01	01	12345	12345	a5pLx0OH_SUGZoK15Kdocw	1980-10-05 00:00:00	01	01	01	01	01	01	01	01	01	bI_2jNhxaPCRv0WFk1wLLA	MEDIUM	2030-12-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-08-28 09:51:18.118053	SYSTEM	\N	\N	Test	\N	DmHvkMrjH8uO
3107	CUSTOMER	01	t88VzvZnO7uuD3rxy9NuIQ	wQLmHshUsoXtRVTpuDV_TQ	JUiEdl8KQBa9VLPJ2zfpbA	MitcmfbLXw59AgJfUByKMg	Mia	Jo	MALE	1987-11-30 00:00:00	Da Nang	01	apnREW-qFJe6AV9eNyM_pw	XmEVe5XdKQm_WVBlTX4lkFA42vwrb9bbgFohQsDcfcw	SINGLE	ACTIVE	01	01	01	01	01	02	03	01	91019	877887	7sY-fg9b6dvKTvj36mSfOA	1980-10-05 00:00:00	S22	01	G21	PP12	01	01	RC01	T01	01	F8dmK7-W45wkLelmuWADcg	MEDIUM	2003-11-20 00:00:00	f	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-08-18 13:31:05.545951	SYSTEM	\N	\N	Web	\N	1234578855
3108	CUSTOMER	01	7_v_XOyG2m8ob1E-SNsaJcLRBEWhJF_0WQpqqkjDMDQ	Abs45iDn5VJJPx-0l8M9Cw	JUiEdl8KQBa9VLPJ2zfpbA	MitcmfbLXw59AgJfUByKMg	Mia	Jo	MALE	1997-11-30 00:00:00	Da Nang	01	oEuCkStdpQ71jxzjUwDfSQ	h54HemIa-lPohe6eFHY4c-X4e-MiZUma1j_0J6zTqTs	SINGLE	ACTIVE	01	01	01	01	01	02	11	01	91019	877887	7sY-fg9b6dvKTvj36mSfOA	1980-10-05 00:00:00	S22	CG09	G21	PP12	01	01	RC01	T01	01	F8dmK7-W45wkLelmuWADcg	MEDIUM	2003-11-20 00:00:00	f	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-08-21 10:59:42.937591	SYSTEM	\N	\N	Web	\N	WPQPqwMNQEVLk-f4MHPy6xclSMD
3109	CUSTOMER	01	KHlhTGtjuMHpsx_J9IaTkA	JxWzV8IOyc0kOZhizbMOMA	mIg_Z6nMdOxuG9sCJcA2_w	GUbGz73Q9FKPKkZT0iUeFQ	Mia	Jo	MALE	1988-11-30 00:00:00	Da Nang	01	apnREW-qFJe6AV9eNyM_pw	YkKfeZNJoRxV_1n7ZoM2fViGl8J98qUwqMXpQGnHQfI	SINGLE	ACTIVE	01	01	01	01	01	02	03	01	91019	877887	7sY-fg9b6dvKTvj36mSfOA	1980-10-05 00:00:00	S22	01	G21	PP12	01	01	RC01	T01	01	F8dmK7-W45wkLelmuWADcg	MEDIUM	2003-11-20 00:00:00	f	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-08-25 11:26:18.340877	SYSTEM	\N	\N	Web	\N	1234578858
3110	CUSTOMER	01	ok-3yhvUlblBua5n62W6pSlaRouMPh_OxbjAsKPhJ8g	9j4rxPBA3vp6t0EHHwKNwA	PQhVDLryGvWpGNXEs3jTUw	MQRd5aKYi5R2QJgjQ5rEaw		David	MALE	1989-11-13 00:00:00	United States	02	D9TpUKVUILy8XScQD0DaZA	add7H8vAEqjQjqUfbyCwDQICX95WCGaQa_1dmX-PKuc	MARRIED	ACTIVE	03	03			03	05	01	04	129548	0	7sY-fg9b6dvKTvj36mSfOA	1980-10-05 00:00:00	S22	CG09	G21	PP12	01	01	RC01	T01	02	F8dmK7-W45wkLelmuWADcg	LOW	2003-11-20 00:00:00	t	f	f	f	f	f	\N	f	f	f	f	f	f	f	2023-08-27 05:50:57.107115	SYSTEM	\N	\N	Web	\N	b4ff60c2-eca8-48be-ad11-7fe410b3c7ff
3115	CUSTOMER	01	FQ2q-TbxsCccDmCqwbIV8Q	rxkFkdOghxXGfIwoTOVEIQ	YiXwo2-KDWQtQfI_XuRyIA	woWhYY7cJs9frD9p1fdSlA	Test	Test	MALE	2023-08-02 00:00:00	Manchester	01	2kpjYHAU0OQKgyE_Toa7SQ	SKWYLAe6IJsKLhdnJxHkFxmI3j5KoMBqBTxatcVdR1I	MARRIED	ACTIVE	01	01	01	01	01	01	01	01	12345	12345	a5pLx0OH_SUGZoK15Kdocw	1980-10-05 00:00:00	01	01	01	01	01	01	01	01	01	0HsN7_2eIwIp698lLI-fpg	MEDIUM	2030-12-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-08-28 11:04:24.968322	SYSTEM	\N	\N	Test	\N	ax2KKf1VDzlL
3116	CUSTOMER	01	ZdsVB4QRfmM35Q8HnNF2I_dQgBinV1gAJS6GzoQehLk	UCQn581epjihX285vK_uYg	l9xpkRLVKUYGb2jcpfeXSA	WiUO4VuCVJ5GfPttSyQaGA	Test	Test	MALE	2023-08-02 00:00:00	Chicago	01	2kpjYHAU0OQKgyE_Toa7SQ	mXbtVIN8SOTq1kpMCzrKu_jnIMH-P-E7BDw6raUdwdg	MARRIED	ACTIVE	01	01	01	01	01	01	01	01	12345	12345	a5pLx0OH_SUGZoK15Kdocw	1980-10-05 00:00:00	01	01	01	01	01	01	01	01	01	0HsN7_2eIwIp698lLI-fpg	MEDIUM	2030-12-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-08-29 14:17:44.026604	SYSTEM	\N	\N	Test	\N	z4SXOJOKdAQL
3112	CUSTOMER	01	QDLQMcAmXfu4xy9jnDrG3UQOGCxZnyFht2SocRr5RiM	02bB5u9kQWH_dHiKZG-OFg	JNLBNSMV02tpy-UMq9nKzA	oSb2n2mvN5RrIEPaihbMnw	\N	Abhi	MALE	1989-11-13 00:00:00	Punjab	03	eKAAvQsiBTck7PFW5aNPqA	BDIKFyfbGMgKVOePG_VEmkk6Opz8oLdql1IhA0pLZMg	MARRIED	ACTIVE	\N	\N	01	\N	\N	02	\N	02	\N	\N	\N	\N	\N	\N	\N	\N	01	\N	\N	\N	02	rxu19aqMqs9CHQUupeKEkA	\N	\N	t	\N	f	f	f	f	\N	f	f	f	f	f	f	f	2023-08-28 05:37:07.058468	SYSTEM	\N	\N	\N	\N	5508ae1d-bdf2-43ae-a351-527e7ee97ab2
3152	CUSTOMER	01	LaxwdvJY3kZYClaazRHGmg	0EP8YPMFVdMQl9bSDo-7LA	onRzjDp3xQyCBE320T1MdQ	1JnXqAE1T6rUTC1bG6g72Q	Test	Test	MALE	1998-06-11 00:00:00	Test	01	2kpjYHAU0OQKgyE_Toa7SQ	OSsASAEQq6RjN6ji5NpKLdCMM_PYKdes2hhdd840FeM	MARRIED	ACTIVE	01	01	01	01	01	01	01	01	12345	12345	a5pLx0OH_SUGZoK15Kdocw	1980-10-05 00:00:00	01	01	01	01	01	01	01	01	01	0HsN7_2eIwIp698lLI-fpg	MEDIUM	2030-12-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-09-04 09:24:46.378051	SYSTEM	\N	\N	Test	\N	AmJIyOZbvdjM
3117	CUSTOMER	01	ZdsVB4QRfmM35Q8HnNF2I_dQgBinV1gAJS6GzoQehLk	UCQn581epjihX285vK_uYg	l9xpkRLVKUYGb2jcpfeXSA	WiUO4VuCVJ5GfPttSyQaGA	Test	Test	MALE	2023-08-01 00:00:00	Chicago	01	2kpjYHAU0OQKgyE_Toa7SQ	mXbtVIN8SOTq1kpMCzrKu_jnIMH-P-E7BDw6raUdwdg	MARRIED	ACTIVE	01	01	01	01	01	01	01	01	12345	12345	a5pLx0OH_SUGZoK15Kdocw	1980-10-05 00:00:00	01	01	01	01	01	01	01	01	01	0HsN7_2eIwIp698lLI-fpg	MEDIUM	2030-12-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-08-29 16:58:16.197849	SYSTEM	\N	\N	Test	\N	vHWVzbnB7A0Y
3153	CUSTOMER	01	7acrXzHwQvzhRMz3yYLHXdPt1Ge0V0PcEFTJeKoYWVA	ohnH3BtQAwUJ4G8ihu_zQg	fnBxVMNeDhnPIkjIMib1KA	QCwgylqlQqwcv13Iqw8qgg	Test	Test	MALE	2023-08-30 00:00:00	Test	01	2kpjYHAU0OQKgyE_Toa7SQ	uugtF2jEnR5sxDpXE1dsodCMM_PYKdes2hhdd840FeM	MARRIED	ACTIVE	01	01	01	01	01	01	01	01	12345	12345	a5pLx0OH_SUGZoK15Kdocw	1980-10-05 00:00:00	01	01	01	01	01	01	01	01	01	0HsN7_2eIwIp698lLI-fpg	MEDIUM	2030-12-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-09-04 09:45:11.350537	SYSTEM	\N	\N	Test	\N	CnTrz79AnAcZ
3113	CUSTOMER	01	o9kQmTiSAAdSYNvwwy-YGg	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	Test	Test	MALE	2023-08-02 00:00:00	Test	01	2kpjYHAU0OQKgyE_Toa7SQ	SKWYLAe6IJsKLhdnJxHkFxmI3j5KoMBqBTxatcVdR1I	MARRIED	ACTIVE	01	01	01	01	01	01	01	01	12345	12345	a5pLx0OH_SUGZoK15Kdocw	1980-10-05 00:00:00	01	01	01	01	01	01	01	01	01	0HsN7_2eIwIp698lLI-fpg	MEDIUM	2030-12-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-08-28 09:48:16.085531	SYSTEM	\N	\N	Test	\N	6jxmnt3eWn5p
3118	CUSTOMER	01	TNqlzioPpBdsg5MBFXKciP9FjmE17FznvNkx5yajyL0	eEajgJcBn9sDyyGc6iVPoA	AfKLkUHxeSY9QQGmc7WsFg	vmdi_BIU5VihSZPKa53q0A	Test	Test	MALE	2023-08-01 00:00:00	Bhopal	01	5jDvNBhMCzkkOq_du-txeg	4S4laynjNPQ1PF74y_VjDdCMM_PYKdes2hhdd840FeM	MARRIED	ACTIVE	01	01	01	01	01	01	01	01	12345	12345	a5pLx0OH_SUGZoK15Kdocw	1980-10-05 00:00:00	01	01	01	01	01	01	01	01	01	0HsN7_2eIwIp698lLI-fpg	MEDIUM	2030-12-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-08-31 07:28:51.356057	SYSTEM	\N	\N	Test	\N	CZP7JDvJDPep
3119	CUSTOMER	01	IY0cTyHB0M5x2A2DROsA4EVxXMLVTpxcX3C5DKCtPf4	3ZwJiIvTMqW17s2wedXggw	AfKLkUHxeSY9QQGmc7WsFg	1uEFE7DrbD29watZfspIqQ	Test	Test	MALE	2023-08-08 00:00:00	Bhopal 	01	5jDvNBhMCzkkOq_du-txeg	4S4laynjNPQ1PF74y_VjDdCMM_PYKdes2hhdd840FeM	MARRIED	ACTIVE	01	01	01	01	01	01	01	01	12345	12345	a5pLx0OH_SUGZoK15Kdocw	1980-10-05 00:00:00	01	01	01	01	01	01	01	01	01	0HsN7_2eIwIp698lLI-fpg	MEDIUM	2030-12-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-08-31 07:31:26.631002	SYSTEM	\N	\N	Test	\N	VWgGv4XUk02y
3189	CUSTOMER	01	C_QZKL2MxQi5MfcDXYNAwQ	93HzKAWg4S7iECmdQ3FriA	93HzKAWg4S7iECmdQ3FriA	93HzKAWg4S7iECmdQ3FriA	Test	Test	MALE	2023-09-01 00:00:00	Test	01	2kpjYHAU0OQKgyE_Toa7SQ	kF4fB9ZVsLkWdywgfCLE1g	MARRIED	ACTIVE	01	01	01	01	01	01	01	01	12345	12345	a5pLx0OH_SUGZoK15Kdocw	1980-10-05 00:00:00	01	01	01	01	01	01	01	01	01	0HsN7_2eIwIp698lLI-fpg	MEDIUM	2030-12-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-09-06 14:58:52.880128	SYSTEM	\N	\N	Test	\N	uATwF0uPthQk
3154	CUSTOMER	01	KT8EGl3sDfKJN8U8X23CvJWzTF--G-heb3FUfW0ypO4	8At7hBvwVKJ0S9xsegkdRg	sL6-Ua1l4mv0NoM7fMX_Hg	ZEW7_DIk8WLSlRUV8ZteAw	Test	Test	MALE	2023-08-31 00:00:00	Test	01	2kpjYHAU0OQKgyE_Toa7SQ	WSLrqRMGim4zYjQAowBZt1A42vwrb9bbgFohQsDcfcw	MARRIED	ACTIVE	01	01	01	01	01	01	01	01	12345	12345	a5pLx0OH_SUGZoK15Kdocw	1980-10-05 00:00:00	01	01	01	01	01	01	01	01	01	0HsN7_2eIwIp698lLI-fpg	MEDIUM	2030-12-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-09-04 10:11:01.404448	SYSTEM	\N	\N	Test	\N	1gVubk8Cy4SV
3155	CUSTOMER	01	U9txKdpklzmQWZNrAxGsluRgpP54sT_QWisbpZzSIgU	rNUjYTfnIqJiyiZ_ZQ_x9g	L22T0mI8XxeHdIAxuztArA	ynizDgpl0LQcQXknhT3Qkw	Test	Test	MALE	2023-08-30 00:00:00	Test	01	2kpjYHAU0OQKgyE_Toa7SQ	oqoCfQBmLwZRAA-Nb4i2-1A42vwrb9bbgFohQsDcfcw	MARRIED	ACTIVE	01	01	01	01	01	01	01	01	12345	12345	a5pLx0OH_SUGZoK15Kdocw	1980-10-05 00:00:00	01	01	01	01	01	01	01	01	01	0HsN7_2eIwIp698lLI-fpg	MEDIUM	2030-12-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-09-04 10:14:09.989796	SYSTEM	\N	\N	Test	\N	jRD4N9VybVvs
3156	CUSTOMER	01	LttJVM2OXofyswf284lxPg	ohnH3BtQAwUJ4G8ihu_zQg	CIQlk_Im5Iiyd2Boh0pjtA	0tCcgHKVo8RQAHPwM1OTag	Test	Test	MALE	2023-09-06 00:00:00	Test	01	2kpjYHAU0OQKgyE_Toa7SQ	fOncNuPLX1OqNsixth66pVA42vwrb9bbgFohQsDcfcw	MARRIED	ACTIVE	01	01	01	01	01	01	01	01	12345	12345	a5pLx0OH_SUGZoK15Kdocw	1980-10-05 00:00:00	01	01	01	01	01	01	01	01	01	0HsN7_2eIwIp698lLI-fpg	MEDIUM	2030-12-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-09-04 11:18:01.653311	SYSTEM	\N	\N	Test	\N	smyUUlK7Kaoa
3157	CUSTOMER	01	1sLsxn0OQjbcSXoM1nhLt8p4sw4KZdC0HEF5J4U90JM	HN252LXWlaBDCIwV9jU66g	ACJ6njQdQ1S5f1y6Hiys2g	ynizDgpl0LQcQXknhT3Qkw	Test	Test	MALE	2023-08-30 00:00:00	Test	01	2kpjYHAU0OQKgyE_Toa7SQ	6cb79YWw-zY9qmvNNoP-iViGl8J98qUwqMXpQGnHQfI	MARRIED	ACTIVE	01	01	01	01	01	01	01	01	12345	12345	a5pLx0OH_SUGZoK15Kdocw	1980-10-05 00:00:00	01	01	01	01	01	01	01	01	01	0HsN7_2eIwIp698lLI-fpg	MEDIUM	2030-12-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-09-05 07:07:20.447689	SYSTEM	\N	\N	Test	\N	cVB0d0yNrLd0
3158	CUSTOMER	01	78ABDCUvPbs8VVYZzaywKw	2UxaF8aCRp3lTE3MRzHRLQ	uSY6CX_03FMKK0eBin4uKQ	cQsI7GfdDL5xtghZT5L0gw	Test	Test	MALE	2023-08-30 00:00:00	Test	01	2kpjYHAU0OQKgyE_Toa7SQ	TmUbK4gPcedIbA7cFB09sl9wdK-t9AlLqcLgIjHnOpI	MARRIED	ACTIVE	01	01	01	01	01	01	01	01	12345	12345	a5pLx0OH_SUGZoK15Kdocw	1980-10-05 00:00:00	01	01	01	01	01	01	01	01	01	0HsN7_2eIwIp698lLI-fpg	MEDIUM	2030-12-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-09-05 07:14:40.773661	SYSTEM	\N	\N	Test	\N	mgYJPPftQfEL
3159	CUSTOMER	01	DoN7X5kXTL_jP3pjEKzeCcLRBEWhJF_0WQpqqkjDMDQ	SpBz8qaamgxc0G4JHjXlZQ	JNLBNSMV02tpy-UMq9nKzA	a8FrWYYwFMNgRhTP6dXZeA	Test	Test	MALE	2023-08-29 00:00:00	Test	01	2kpjYHAU0OQKgyE_Toa7SQ	7r-hI2v_gEV55_YPN4GahliGl8J98qUwqMXpQGnHQfI	MARRIED	ACTIVE	01	01	01	01	01	01	01	01	12345	12345	a5pLx0OH_SUGZoK15Kdocw	1980-10-05 00:00:00	01	01	01	01	01	01	01	01	01	0HsN7_2eIwIp698lLI-fpg	MEDIUM	2030-12-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-09-05 07:16:54.212806	SYSTEM	\N	\N	Test	\N	d6QMsSgHIRZZ
3160	CUSTOMER	01	zVexByM0gW5C5_6uhhbOpQ	2UxaF8aCRp3lTE3MRzHRLQ	HWOv0z9zwV28PYQESFz8UA	2UxaF8aCRp3lTE3MRzHRLQ	Test	Test	MALE	2023-08-30 00:00:00	Test	01	2kpjYHAU0OQKgyE_Toa7SQ	MAw5y1a3Y0u3Oe1C2sgQmfDgAwLoObof_TD8QzNhq70	MARRIED	ACTIVE	01	01	01	01	01	01	01	01	12345	12345	a5pLx0OH_SUGZoK15Kdocw	1980-10-05 00:00:00	01	01	01	01	01	01	01	01	01	0HsN7_2eIwIp698lLI-fpg	MEDIUM	2030-12-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-09-05 07:18:55.852337	SYSTEM	\N	\N	Test	\N	2K0NzxrKS0vZ
3161	CUSTOMER	01	hdygDLb4nEfO_54Bgr3VWQ	NpvIfWmGvzOzX3z8y8BmYg	NpvIfWmGvzOzX3z8y8BmYg	_pp_cbcWmxB8wjt9J4a_KA	Test	Test	MALE	2023-08-30 00:00:00	Test	01	2kpjYHAU0OQKgyE_Toa7SQ	PF8lQuatmpUn46eN2PL-cA	MARRIED	ACTIVE	01	01	01	01	01	01	01	01	12345	12345	a5pLx0OH_SUGZoK15Kdocw	1980-10-05 00:00:00	01	01	01	01	01	01	01	01	01	0HsN7_2eIwIp698lLI-fpg	MEDIUM	2030-12-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-09-05 07:33:07.925614	SYSTEM	\N	\N	Test	\N	nGVvT3xblLLj
3162	CUSTOMER	01	o63--ng5M8N9wZtJ6_RUIzp4K8xxWsy2bHHKpeD0gNg	dp1JGhfyggyxytzQpOpn4g	D2FFrwVz3pZvHcDtrRephA	2XUbANfy1drc2hLFuXkteg	Test	Test	MALE	2023-08-29 00:00:00	Test	01	2kpjYHAU0OQKgyE_Toa7SQ	yMxWHbHOpnw-pqGvEv3Pm9U4_RX9cLCy1tM77MYHpl4	MARRIED	ACTIVE	01	01	01	01	01	01	01	01	12345	12345	a5pLx0OH_SUGZoK15Kdocw	1980-10-05 00:00:00	01	01	01	01	01	01	01	01	01	0HsN7_2eIwIp698lLI-fpg	MEDIUM	2030-12-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-09-05 08:02:31.325154	SYSTEM	\N	\N	Test	\N	JJl8PmuGh1Nw
3163	CUSTOMER	01	Y_AOnFF_XnFqkH3xEgPNMzp4K8xxWsy2bHHKpeD0gNg	WlMcHLKK7rOpLjIfAXn7vA	2XUbANfy1drc2hLFuXkteg	D2FFrwVz3pZvHcDtrRephA	Test	Test	MALE	2023-08-30 00:00:00	Test	01	2kpjYHAU0OQKgyE_Toa7SQ	1PE5TPBjegQIM6FufJbZcvDgAwLoObof_TD8QzNhq70	MARRIED	ACTIVE	01	01	01	01	01	01	01	01	12345	12345	a5pLx0OH_SUGZoK15Kdocw	1980-10-05 00:00:00	01	01	01	01	01	01	01	01	01	0HsN7_2eIwIp698lLI-fpg	MEDIUM	2030-12-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-09-05 08:19:42.40096	SYSTEM	\N	\N	Test	\N	aZbTa0PNBw4w
3164	CUSTOMER	01	PtsirzM-pCPs4S-a7cxMA65u0_tOhAukRI0G2AAST2M	BS7d8ltaDOTWIvfoGNs9Bw	pu8Hnavuf1orQuXhEJ5FdA	pu8Hnavuf1orQuXhEJ5FdA	Test	Test	MALE	2023-08-30 00:00:00	Test	01	2kpjYHAU0OQKgyE_Toa7SQ	41KA7wbJcm69-NWpO76tCRmI3j5KoMBqBTxatcVdR1I	MARRIED	ACTIVE	01	01	01	01	01	01	01	01	12345	12345	a5pLx0OH_SUGZoK15Kdocw	1980-10-05 00:00:00	01	01	01	01	01	01	01	01	01	0HsN7_2eIwIp698lLI-fpg	MEDIUM	2030-12-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-09-05 08:22:44.732773	SYSTEM	\N	\N	Test	\N	csbZtNCSq1AF
3165	CUSTOMER	01	RVPP_wkLvagCGVL7HxquGBe4J5srw6dRvMPRusuOSGs	u0eOzM59YtYQul701nFeSQ	JNLBNSMV02tpy-UMq9nKzA	lMjub_lppJXvnClZa3Z3PA	Test	Test	MALE	2023-08-30 00:00:00	Test	01	2kpjYHAU0OQKgyE_Toa7SQ	dEzGIdGpuULs2qcGi6TOZBmI3j5KoMBqBTxatcVdR1I	MARRIED	ACTIVE	01	01	01	01	01	01	01	01	12345	12345	a5pLx0OH_SUGZoK15Kdocw	1980-10-05 00:00:00	01	01	01	01	01	01	01	01	01	0HsN7_2eIwIp698lLI-fpg	MEDIUM	2030-12-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-09-05 09:58:14.451388	SYSTEM	\N	\N	Test	\N	2jkUtXL3mdfQ
3166	CUSTOMER	01	p3a67tfKKvt1BQiVqOY4Qg	6QJzCY7oeNTMH6nGAWQIVA	6QJzCY7oeNTMH6nGAWQIVA	6QJzCY7oeNTMH6nGAWQIVA	Test	Test	MALE	2023-08-30 00:00:00	Test	01	2kpjYHAU0OQKgyE_Toa7SQ	PqVbEAjM4g8RLZok_Px2xA	MARRIED	ACTIVE	01	01	01	01	01	01	01	01	12345	12345	a5pLx0OH_SUGZoK15Kdocw	1980-10-05 00:00:00	01	01	01	01	01	01	01	01	01	0HsN7_2eIwIp698lLI-fpg	MEDIUM	2030-12-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-09-05 11:50:17.534259	SYSTEM	\N	\N	Test	\N	CVDd9dlPFN3f
3167	CUSTOMER	01	aPIjtC9fsYW04Tzn2nJ6fQ	nPm29hDWfg2bT15HZXFSrA	JDzbRlKlzmoSqsLk_LzF5g	GCKTEJendksFfLztJ1WvtQ	Test	Test	MALE	2023-08-30 00:00:00	Test	01	2kpjYHAU0OQKgyE_Toa7SQ	aZ5U3Jei9BDONfUd9CPN-fDgAwLoObof_TD8QzNhq70	MARRIED	ACTIVE	01	01	01	01	01	01	01	01	12345	12345	a5pLx0OH_SUGZoK15Kdocw	1980-10-05 00:00:00	01	01	01	01	01	01	01	01	01	0HsN7_2eIwIp698lLI-fpg	MEDIUM	2030-12-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-09-05 11:55:02.451875	SYSTEM	\N	\N	Test	\N	TDO6IZSlVnav
3168	CUSTOMER	01	0Vv4q7WhIHCs0U7x12uE7D1OMyT7uapmeJIU_h4KFJM	H3sPeVzsN98aLysTevVsDA	H3sPeVzsN98aLysTevVsDA	H3sPeVzsN98aLysTevVsDA	Test	Test	MALE	2023-08-30 00:00:00	Test	01	2kpjYHAU0OQKgyE_Toa7SQ	1Gz8xpqoQ-JjnccX4AuiqdU4_RX9cLCy1tM77MYHpl4	MARRIED	ACTIVE	01	01	01	01	01	01	01	01	12345	12345	a5pLx0OH_SUGZoK15Kdocw	1980-10-05 00:00:00	01	01	01	01	01	01	01	01	01	0HsN7_2eIwIp698lLI-fpg	MEDIUM	2030-12-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-09-05 12:23:23.570718	SYSTEM	\N	\N	Test	\N	rNdD22wm19kX
3169	CUSTOMER	01	-XLz0U-Rq5PrcqUIJ76Q_Vyd4Ws-fp_OeFaEXV2kwmk	cymqas8eVhD8_dxV_q8lXg	cymqas8eVhD8_dxV_q8lXg	cymqas8eVhD8_dxV_q8lXg	Test	Test	MALE	2023-08-30 00:00:00	Test	01	2kpjYHAU0OQKgyE_Toa7SQ	XTNxnNBjpK3sqDlVNc41xQ	MARRIED	ACTIVE	01	01	01	01	01	01	01	01	12345	12345	a5pLx0OH_SUGZoK15Kdocw	1980-10-05 00:00:00	01	01	01	01	01	01	01	01	01	0HsN7_2eIwIp698lLI-fpg	MEDIUM	2030-12-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-09-05 13:02:15.952779	SYSTEM	\N	\N	Test	\N	g3H9rlMMhLsB
3170	CUSTOMER	01	DMLvGSPwsWI25fHJUXH20A	tTs0oQ0c9MGAtVtuV_Z4nQ	tTs0oQ0c9MGAtVtuV_Z4nQ	tTs0oQ0c9MGAtVtuV_Z4nQ	Test	Test	MALE	2023-08-30 00:00:00	Test	01	2kpjYHAU0OQKgyE_Toa7SQ	_4uLOph2h7GrWUluuGVUow	MARRIED	ACTIVE	01	01	01	01	01	01	01	01	12345	12345	a5pLx0OH_SUGZoK15Kdocw	1980-10-05 00:00:00	01	01	01	01	01	01	01	01	01	0HsN7_2eIwIp698lLI-fpg	MEDIUM	2030-12-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-09-05 13:10:35.36659	SYSTEM	\N	\N	Test	\N	GvHxAUqqKVGK
3171	CUSTOMER	01	5DwdyUfu37ijCYbhXfMFqQ	vxTmTU5iauo3xOc7UffDyw	vxTmTU5iauo3xOc7UffDyw	vxTmTU5iauo3xOc7UffDyw	Test	Test	MALE	2023-08-31 00:00:00	Test	01	2kpjYHAU0OQKgyE_Toa7SQ	Uc-b1rwxG4_v7df6ee1Xzg	MARRIED	ACTIVE	01	01	01	01	01	01	01	01	12345	12345	a5pLx0OH_SUGZoK15Kdocw	1980-10-05 00:00:00	01	01	01	01	01	01	01	01	01	0HsN7_2eIwIp698lLI-fpg	MEDIUM	2030-12-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-09-05 13:19:17.140301	SYSTEM	\N	\N	Test	\N	usI3ecROiNwy
3172	CUSTOMER	01	gAp0uFu-2M7greB4JFEXsT3mGO6Z8U__s9PK4dVfb_M	YGEJOb9Bu64wSAfkZoJHJw	AfKLkUHxeSY9QQGmc7WsFg	vmdi_BIU5VihSZPKa53q0A	Test	Test	MALE	2023-09-01 00:00:00	Bhopal	01	-G5MF5GkOS_nByiPdsNTXA	4S4laynjNPQ1PF74y_VjDdCMM_PYKdes2hhdd840FeM	MARRIED	ACTIVE	01	01	01	01	01	01	01	01	12345	12345	a5pLx0OH_SUGZoK15Kdocw	1980-10-05 00:00:00	01	01	01	01	01	01	01	01	01	0HsN7_2eIwIp698lLI-fpg	MEDIUM	2030-12-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-09-06 04:56:21.894776	SYSTEM	\N	\N	Test	\N	SnXpemvCbV5I
3173	CUSTOMER	01	xM5TcwpYGzErLnxMRrd6wg	rblyyjKjyZYfv7abL2OsrQ	rblyyjKjyZYfv7abL2OsrQ	rblyyjKjyZYfv7abL2OsrQ	Test	Test	MALE	2023-08-30 00:00:00	Test	01	2kpjYHAU0OQKgyE_Toa7SQ	UaroX1QMTZ_mUxeWwIajlw	MARRIED	ACTIVE	01	01	01	01	01	01	01	01	12345	12345	a5pLx0OH_SUGZoK15Kdocw	1980-10-05 00:00:00	01	01	01	01	01	01	01	01	01	0HsN7_2eIwIp698lLI-fpg	MEDIUM	2030-12-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-09-06 05:45:17.802601	SYSTEM	\N	\N	Test	\N	raXL6ROuFkvz
3174	CUSTOMER	01	sCGnAx2kO3eBj6vVIhlYlq8g7gQekE1Yd5VA99nizF0	dv5O9n-Qthgi34iBBNz6MA	dv5O9n-Qthgi34iBBNz6MA	dv5O9n-Qthgi34iBBNz6MA	Test	Test	MALE	2023-08-30 00:00:00	Test	01	2kpjYHAU0OQKgyE_Toa7SQ	hCQ0G9pYHx52nMQuSR-IFA	WIDOWED	ACTIVE	01	01	01	01	01	01	01	01	12345	12345	a5pLx0OH_SUGZoK15Kdocw	1980-10-05 00:00:00	01	01	01	01	01	01	01	01	01	0HsN7_2eIwIp698lLI-fpg	MEDIUM	2030-12-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-09-06 07:00:26.322099	SYSTEM	\N	\N	Test	\N	Fh8iSO39OMoJ
3175	CUSTOMER	01	k9qi6aqEvoNVJoRBrLx58pWzTF--G-heb3FUfW0ypO4	gwUVwLW6-lo3IvB0_amPIA	iQifqJxtGevkdlCQMFCI6A	zWh9DhB1lpWpG4G4SQVyNg	Test	Test	MALE	2023-08-30 00:00:00	Test	01	2kpjYHAU0OQKgyE_Toa7SQ	vKvt-3VHbKQGKy1E3swNsdU4_RX9cLCy1tM77MYHpl4	MARRIED	ACTIVE	01	01	01	01	01	01	01	01	12345	12345	a5pLx0OH_SUGZoK15Kdocw	1980-10-05 00:00:00	01	01	01	01	01	01	01	01	01	0HsN7_2eIwIp698lLI-fpg	MEDIUM	2030-12-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-09-06 07:25:05.428981	SYSTEM	\N	\N	Test	\N	eHdXHmGl7DhG
3176	CUSTOMER	01	W_t0g3brF7NzUyvdM0pj-MLRBEWhJF_0WQpqqkjDMDQ	JES37tyh43XmVbN5eQzcUw	JES37tyh43XmVbN5eQzcUw	JES37tyh43XmVbN5eQzcUw	Test	Test	MALE	1992-09-06 00:00:00	PUNE	01	AJP2iSaaGTS27EIJKU3YHw	u6zosHMau789SL7ip67Ea-X4e-MiZUma1j_0J6zTqTs	MARRIED	ACTIVE	01	01	01	01	01	01	01	01	12345	12345	a5pLx0OH_SUGZoK15Kdocw	1980-10-05 00:00:00	01	01	01	01	01	01	01	01	01	0HsN7_2eIwIp698lLI-fpg	MEDIUM	2030-12-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-09-06 07:59:25.275072	SYSTEM	\N	\N	Test	\N	Bh9QxbvHyVRz
3177	CUSTOMER	01	CBN7i7DXI8JCjVwPKCTLZX3oHHLaiRTGV6JKiFm7npw	ahCw1INoSPK3hBxuiLYJCw	\N	HstNekNNHa63Y9DHjy6vaw	Test	Test	MALE	1995-09-06 00:00:00	PUNE	01	AJP2iSaaGTS27EIJKU3YHw	8_o-_QzSRaqBM-u2tMchMHg9v5uMybmJkEILvOPx_RY	SINGLE	ACTIVE	01	01	01	01	01	01	01	01	12345	12345	a5pLx0OH_SUGZoK15Kdocw	1980-10-05 00:00:00	01	01	01	01	01	01	01	01	01	0HsN7_2eIwIp698lLI-fpg	MEDIUM	2030-12-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-09-06 08:06:03.083005	SYSTEM	\N	\N	Test	\N	tHiv9I58y83a
3178	CUSTOMER	01	0Vv4q7WhIHCs0U7x12uE7D1OMyT7uapmeJIU_h4KFJM	H3sPeVzsN98aLysTevVsDA	H3sPeVzsN98aLysTevVsDA	H3sPeVzsN98aLysTevVsDA	Test	Test	FEMALE	1998-09-06 00:00:00	Chennai 	01	PgTRV5wLSFO-22yyj8sW0A	n6y_8c2q_ZjrNjQXK4FeRng9v5uMybmJkEILvOPx_RY	MARRIED	ACTIVE	01	01	01	01	01	01	01	01	12345	12345	a5pLx0OH_SUGZoK15Kdocw	1980-10-05 00:00:00	01	01	01	01	01	01	01	01	01	0HsN7_2eIwIp698lLI-fpg	MEDIUM	2030-12-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-09-06 09:14:10.616679	SYSTEM	\N	\N	Test	\N	iplz8s4NUQFF
3179	CUSTOMER	01	Eqn7v9LoEsfg0eUIwUz7RA	54yny6VvayBmHLozrASHBA	54yny6VvayBmHLozrASHBA	54yny6VvayBmHLozrASHBA	Test	Test	FEMALE	2023-08-31 00:00:00	Test	01	2kpjYHAU0OQKgyE_Toa7SQ	e_gT2r42fyY2JGdMjoLk5w	SINGLE	ACTIVE	01	01	01	01	01	01	01	01	12345	12345	a5pLx0OH_SUGZoK15Kdocw	1980-10-05 00:00:00	01	01	01	01	01	01	01	01	01	0HsN7_2eIwIp698lLI-fpg	MEDIUM	2030-12-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-09-06 10:54:12.815082	SYSTEM	\N	\N	Test	\N	MYSEnqWnXuD6
3180	CUSTOMER	01	ouFFu3dmA-qAOZRVKY5G8Q	3XDhuLXywNxfimS1rhPcsQ	3XDhuLXywNxfimS1rhPcsQ	3XDhuLXywNxfimS1rhPcsQ	Test	Test	MALE	2023-08-30 00:00:00	Test	01	2kpjYHAU0OQKgyE_Toa7SQ	9lykGdNe0VSKNYchCpKEbg	MARRIED	ACTIVE	01	01	01	01	01	01	01	01	12345	12345	a5pLx0OH_SUGZoK15Kdocw	1980-10-05 00:00:00	01	01	01	01	01	01	01	01	01	0HsN7_2eIwIp698lLI-fpg	MEDIUM	2030-12-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-09-06 11:19:12.868646	SYSTEM	\N	\N	Test	\N	02Oi9T4pbo2g
3181	CUSTOMER	01	-AWSHNFoDRKP0kanSFCtjA	H3sPeVzsN98aLysTevVsDA	\N	H3sPeVzsN98aLysTevVsDA	Test	Test	FEMALE	1998-09-06 00:00:00	Chennai 	01	PgTRV5wLSFO-22yyj8sW0A	n6y_8c2q_ZjrNjQXK4FeRng9v5uMybmJkEILvOPx_RY	MARRIED	ACTIVE	01	01	01	01	01	01	01	01	12345	12345	a5pLx0OH_SUGZoK15Kdocw	1980-10-05 00:00:00	01	01	01	01	01	01	01	01	01	0HsN7_2eIwIp698lLI-fpg	MEDIUM	2030-12-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-09-06 11:23:54.809652	SYSTEM	\N	\N	Test	\N	WXTW9yZ4w637
3182	CUSTOMER	01	Ftxyxe3r3oa1QJLpaDBvGQ	mIqqtky9dGL4VK0dc2dUPw	\N	GRShsQVKMyNwWWucL7VqWw	Test	Test	MALE	1995-09-06 00:00:00	Pune	01	AJP2iSaaGTS27EIJKU3YHw	n6y_8c2q_ZjrNjQXK4FeRng9v5uMybmJkEILvOPx_RY	SINGLE	ACTIVE	01	01	01	01	01	01	01	01	12345	12345	a5pLx0OH_SUGZoK15Kdocw	1980-10-05 00:00:00	01	01	01	01	01	01	01	01	01	0HsN7_2eIwIp698lLI-fpg	MEDIUM	2030-12-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-09-06 11:27:45.334642	SYSTEM	\N	\N	Test	\N	FmkKtTYJjheO
3183	CUSTOMER	01	oiXRVmS-3BqYsikEl-TxZQ	BqeoakR9uldj0BNwkzLJ7w	BqeoakR9uldj0BNwkzLJ7w	BqeoakR9uldj0BNwkzLJ7w	Test	Test	MALE	2023-08-30 00:00:00	Test	01	2kpjYHAU0OQKgyE_Toa7SQ	10TTtnxhewitLQoduZb-DA	MARRIED	ACTIVE	01	01	01	01	01	01	01	01	12345	12345	a5pLx0OH_SUGZoK15Kdocw	1980-10-05 00:00:00	01	01	01	01	01	01	01	01	01	0HsN7_2eIwIp698lLI-fpg	MEDIUM	2030-12-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-09-06 11:43:51.10458	SYSTEM	\N	\N	Test	\N	bPYKNU3NB1wj
3184	CUSTOMER	01	i8OI1EiIcxHkxlGkoa7cVg	iwQq5L-J-P9lrgbnTGNEWQ	iwQq5L-J-P9lrgbnTGNEWQ	iwQq5L-J-P9lrgbnTGNEWQ	Test	Test	MALE	2023-08-30 00:00:00	Test	01	2kpjYHAU0OQKgyE_Toa7SQ	sVez0ZS0TNv0D2_S_eFBuw	MARRIED	ACTIVE	01	01	01	01	01	01	01	01	12345	12345	a5pLx0OH_SUGZoK15Kdocw	1980-10-05 00:00:00	01	01	01	01	01	01	01	01	01	0HsN7_2eIwIp698lLI-fpg	MEDIUM	2030-12-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-09-06 11:51:05.235002	SYSTEM	\N	\N	Test	\N	rhzDOrsEAmjv
3185	CUSTOMER	01	l4j1Xa9XcmpzgbxabWaF-g	J7NnC-ATgkpW33ReT3NQUA	J7NnC-ATgkpW33ReT3NQUA	J7NnC-ATgkpW33ReT3NQUA	Test	Test	MALE	2023-08-30 00:00:00	Test	01	2kpjYHAU0OQKgyE_Toa7SQ	hRRi00XHXtUvG-IQ3bm3aA	SINGLE	ACTIVE	01	01	01	01	01	01	01	01	12345	12345	a5pLx0OH_SUGZoK15Kdocw	1980-10-05 00:00:00	01	01	01	01	01	01	01	01	01	0HsN7_2eIwIp698lLI-fpg	MEDIUM	2030-12-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-09-06 11:53:33.785037	SYSTEM	\N	\N	Test	\N	tfwRChHJqpPX
3186	CUSTOMER	01	i5PGivbqhgALgI6klYk8jw	Nc6E9c8SJJoEHrSstf9QAg	Nc6E9c8SJJoEHrSstf9QAg	Nc6E9c8SJJoEHrSstf9QAg	Test	Test	MALE	2023-09-06 00:00:00	Test	01	2kpjYHAU0OQKgyE_Toa7SQ	0-rcIBHQpvMGBM7HA28lFA	MARRIED	ACTIVE	01	01	01	01	01	01	01	01	12345	12345	a5pLx0OH_SUGZoK15Kdocw	1980-10-05 00:00:00	01	01	01	01	01	01	01	01	01	0HsN7_2eIwIp698lLI-fpg	MEDIUM	2030-12-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-09-06 12:03:36.980421	SYSTEM	\N	\N	Test	\N	arP5SY0FV78R
3187	CUSTOMER	01	m9Z6o44SQQbrPRJVP1HOgA	yxps9Rs-q821DJVXRM5T8A	yxps9Rs-q821DJVXRM5T8A	yxps9Rs-q821DJVXRM5T8A	Test	Test	MALE	2023-08-30 00:00:00	Test	01	2kpjYHAU0OQKgyE_Toa7SQ	IA9Cg0E_540Tekf84zhSKw	SINGLE	ACTIVE	01	01	01	01	01	01	01	01	12345	12345	a5pLx0OH_SUGZoK15Kdocw	1980-10-05 00:00:00	01	01	01	01	01	01	01	01	01	0HsN7_2eIwIp698lLI-fpg	MEDIUM	2030-12-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-09-06 14:50:44.79562	SYSTEM	\N	\N	Test	\N	7364SwZX2pHu
3188	CUSTOMER	01	C_QZKL2MxQi5MfcDXYNAwQ	93HzKAWg4S7iECmdQ3FriA	93HzKAWg4S7iECmdQ3FriA	93HzKAWg4S7iECmdQ3FriA	Test	Test	MALE	2023-09-01 00:00:00	Test	01	2kpjYHAU0OQKgyE_Toa7SQ	kF4fB9ZVsLkWdywgfCLE1g	MARRIED	ACTIVE	01	01	01	01	01	01	01	01	12345	12345	a5pLx0OH_SUGZoK15Kdocw	1980-10-05 00:00:00	01	01	01	01	01	01	01	01	01	0HsN7_2eIwIp698lLI-fpg	MEDIUM	2030-12-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-09-06 14:58:52.878738	SYSTEM	\N	\N	Test	\N	OyY9ZoW1OwII
3191	CUSTOMER	01	lJ-nKxyXNa_zqCBvsQG_SA	6d3R3B52Opml3u2lOtEd5w	6d3R3B52Opml3u2lOtEd5w	6d3R3B52Opml3u2lOtEd5w	Test	Test	MALE	2023-09-07 00:00:00	Test	01	2kpjYHAU0OQKgyE_Toa7SQ	IzOmM-S-V6UeMUvV15rgcA	WIDOWED	ACTIVE	01	01	01	01	01	01	01	01	12345	12345	a5pLx0OH_SUGZoK15Kdocw	1980-10-05 00:00:00	01	01	01	01	01	01	01	01	01	0HsN7_2eIwIp698lLI-fpg	MEDIUM	2030-12-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-09-07 04:40:04.094486	SYSTEM	\N	\N	Test	\N	VOPNpkw30WTd
3192	CUSTOMER	01	g_p6SXblukYUdQtXFwIa5Q	sfuziWjOsNQ7k8PkxGqL4Q	sfuziWjOsNQ7k8PkxGqL4Q	sfuziWjOsNQ7k8PkxGqL4Q	Test	Test	MALE	2023-08-31 00:00:00	Test	01	2kpjYHAU0OQKgyE_Toa7SQ	UPrRpFqRI_NlmAQl1XG3yA	MARRIED	ACTIVE	01	01	01	01	01	01	01	01	12345	12345	a5pLx0OH_SUGZoK15Kdocw	1980-10-05 00:00:00	01	01	01	01	01	01	01	01	01	0HsN7_2eIwIp698lLI-fpg	MEDIUM	2030-12-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-09-07 04:43:00.402547	SYSTEM	\N	\N	Test	\N	Qeu41vCPSW6C
3193	CUSTOMER	01	TO5RN4EALK6DHuaf0mmDTA	2OjNFDpnwlDFz-tUNEgN0g	2OjNFDpnwlDFz-tUNEgN0g	2OjNFDpnwlDFz-tUNEgN0g	Test	Test	MALE	2023-08-31 00:00:00	Test	01	2kpjYHAU0OQKgyE_Toa7SQ	uH5CQvT8O5kjbXOajWQSTA	MARRIED	ACTIVE	01	01	01	01	01	01	01	01	12345	12345	a5pLx0OH_SUGZoK15Kdocw	1980-10-05 00:00:00	01	01	01	01	01	01	01	01	01	0HsN7_2eIwIp698lLI-fpg	MEDIUM	2030-12-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-09-07 04:46:55.180513	SYSTEM	\N	\N	Test	\N	P3UqZ3neVUI8
3194	CUSTOMER	01	4BC7Rvzj8avCnTEQRIyj5mcoyyhJuVvZnw0f7CLHfmg	m3ZijAJaIUNR1fHqW8YbXQ	m3ZijAJaIUNR1fHqW8YbXQ	4LzuxbcZUlUI2EifLjtGtg	Test	Test	MALE	2006-09-07 00:00:00	Pune 	01	AJP2iSaaGTS27EIJKU3YHw	kTzrjFXcXVl_q9cLwiq-319wdK-t9AlLqcLgIjHnOpI	SINGLE	ACTIVE	01	01	01	01	01	01	01	01	12345	12345	a5pLx0OH_SUGZoK15Kdocw	1980-10-05 00:00:00	01	01	01	01	01	01	01	01	01	0HsN7_2eIwIp698lLI-fpg	MEDIUM	2030-12-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-09-07 09:44:24.525552	SYSTEM	\N	\N	Test	\N	VAkrl4JVm9mq
3195	CUSTOMER	01	AreWwUFaxOC_1mOG6621EtQ4reuucyKXzNA2JfbWTmc	yVCbGllKSCsS2qi2WnH3Eg	wUZ1weck9V48E1aL3bgKrw	1DWOzpt6207Kg5izEXUSlw	Test	Test	MALE	1998-09-07 00:00:00	Benglore 	01	AJP2iSaaGTS27EIJKU3YHw	SS8DKUXy8p3VzyrrNLe9sXg9v5uMybmJkEILvOPx_RY	MARRIED	ACTIVE	01	01	01	01	01	01	01	01	12345	12345	a5pLx0OH_SUGZoK15Kdocw	1980-10-05 00:00:00	01	01	01	01	01	01	01	01	01	0HsN7_2eIwIp698lLI-fpg	MEDIUM	2030-12-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-09-07 09:48:02.240343	SYSTEM	\N	\N	Test	\N	hMhzB6Abjd8k
3196	CUSTOMER	01	Idi4FBpb1ks01Zh_lMrVTQ	zq-5ptneoJOQoZojckvZhw	IhNPxTt7F4yUqJF1HzIHBQ	JUXR-rEOWl9bE1zadeSQQA	Test	Test	MALE	1993-09-07 00:00:00	Mumbai 	01	AJP2iSaaGTS27EIJKU3YHw	UJa36tyd8jqZt3MmXG718FA42vwrb9bbgFohQsDcfcw	DIVORCED	ACTIVE	01	01	01	01	01	01	01	01	12345	12345	a5pLx0OH_SUGZoK15Kdocw	1980-10-05 00:00:00	01	01	01	01	01	01	01	01	01	0HsN7_2eIwIp698lLI-fpg	MEDIUM	2030-12-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-09-07 09:51:41.983518	SYSTEM	\N	\N	Test	\N	vb1nwyLz6cwD
3197	CUSTOMER	01	5WuNXSmvRrOv-xe3n37KBDp4K8xxWsy2bHHKpeD0gNg	C0E0vaBAU5JvjeX7Rz2XOQ	sKr9DGD5BCe37toc2njQRw	fmPrDYL2g5GomrltWXZzEw	Test	Test	MALE	2023-08-31 00:00:00	Test	01	2kpjYHAU0OQKgyE_Toa7SQ	XvfpDITa9uLwCCNKE0Q_8lA42vwrb9bbgFohQsDcfcw	MARRIED	ACTIVE	01	01	01	01	01	01	01	01	12345	12345	a5pLx0OH_SUGZoK15Kdocw	1980-10-05 00:00:00	01	01	01	01	01	01	01	01	01	0HsN7_2eIwIp698lLI-fpg	MEDIUM	2030-12-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-09-07 10:27:52.900998	SYSTEM	\N	\N	Test	\N	IqneK1DJBhB9
3198	CUSTOMER	01	IyzOE5zSTXJIhHENSGTNxo3raemLd2HPHIYVIlijpl8	DJ06jvqhFayRNrWEeL7ELg	JF3tLJ8WuIU6VLNnAdEt8g	KLzjuhABvzj1ztM5ekfD6g	Test	Test	MALE	2023-08-31 00:00:00	Test	01	2kpjYHAU0OQKgyE_Toa7SQ	e56sdLayupSeJyUFOhmE1MGZNQzzacVk35JFAhH5YCI	MARRIED	ACTIVE	01	01	01	01	01	01	01	01	12345	12345	a5pLx0OH_SUGZoK15Kdocw	1980-10-05 00:00:00	01	01	01	01	01	01	01	01	01	0HsN7_2eIwIp698lLI-fpg	MEDIUM	2030-12-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-09-07 10:33:18.020915	SYSTEM	\N	\N	Test	\N	aD3aSJzpw3EO
3199	CUSTOMER	01	gEXsGen-cJvwfkAnf2lY41Bxibvj3-8di_NP8B7jyvM	mIqqtky9dGL4VK0dc2dUPw	E-_hqWABEeALwhR8U0kHHw	GRShsQVKMyNwWWucL7VqWw	Test	Test	MALE	1995-09-07 00:00:00	Pune 	01	AJP2iSaaGTS27EIJKU3YHw	jcIR8MVY-nV79LKP8ofekHg9v5uMybmJkEILvOPx_RY	SINGLE	ACTIVE	01	01	01	01	01	01	01	01	12345	12345	a5pLx0OH_SUGZoK15Kdocw	1980-10-05 00:00:00	01	01	01	01	01	01	01	01	01	0HsN7_2eIwIp698lLI-fpg	MEDIUM	2030-12-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-09-07 11:41:26.391541	SYSTEM	\N	\N	Test	\N	xpawP6XjXeFq
3200	CUSTOMER	01	vmUoF961EtvtQ236ibVu7w	NpvIfWmGvzOzX3z8y8BmYg	tTs0oQ0c9MGAtVtuV_Z4nQ	ekToDyF9ykyoCXMRGjnK-w	Test	Test	MALE	2023-09-06 00:00:00	Sao Paolo	01	PgTRV5wLSFO-22yyj8sW0A	p-F4UfEk_MYmhAtosZGePjp4K8xxWsy2bHHKpeD0gNg	MARRIED	ACTIVE	01	01	01	01	01	01	01	01	12345	12345	a5pLx0OH_SUGZoK15Kdocw	1980-10-05 00:00:00	01	01	01	01	01	01	01	01	01	ip9AhfRIloOlr2BoQc-q6w	MEDIUM	2030-12-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-09-11 04:37:42.883115	SYSTEM	\N	\N	Test	\N	PIWYLpniZwWx
3201	CUSTOMER	01	hpHRwTv-fbGVlXBwm3LBgA	ekToDyF9ykyoCXMRGjnK-w	tTs0oQ0c9MGAtVtuV_Z4nQ	NpvIfWmGvzOzX3z8y8BmYg	Test	Test	MALE	2023-08-31 00:00:00	Chicago	01	PgTRV5wLSFO-22yyj8sW0A	MrAygrp7YVlvT_nnVRfs5A	SINGLE	ACTIVE	01	01	01	01	01	01	01	01	12345	12345	a5pLx0OH_SUGZoK15Kdocw	1980-10-05 00:00:00	01	01	01	01	01	01	01	01	01	ip9AhfRIloOlr2BoQc-q6w	MEDIUM	2030-12-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-09-11 04:42:19.717042	SYSTEM	\N	\N	Test	\N	BIAx9yCEZ4Rv
3202	CUSTOMER	01	lsHpUBfgTnw2xIvDNdzMIQ	TAiIcfa9ryARo7Gg5BULeg	 	kGh1JOrcXtLn2DVCuWP97A	Test	Test	MALE	2023-08-31 00:00:00	Chicago	01	PgTRV5wLSFO-22yyj8sW0A	A-pWL3yZUYibLSJ0g7cvzNCMM_PYKdes2hhdd840FeM	MARRIED	ACTIVE	01	01	01	01	01	01	01	01	12345	12345	a5pLx0OH_SUGZoK15Kdocw	1980-10-05 00:00:00	01	01	01	01	01	01	01	01	01	ip9AhfRIloOlr2BoQc-q6w	MEDIUM	2030-12-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-09-11 05:16:22.805267	SYSTEM	\N	\N	Test	\N	is3Fd6hFNPvv
3203	CUSTOMER	01	xVylNbmAFFYzawRD3OuOAw	SBUqSYVZB2FCEz_BrYkejA	 	TLr99Q5pe-TJuZBMtp_NbQ	Test	Test	MALE	2023-08-30 00:00:00	Sao Paolo	01	PgTRV5wLSFO-22yyj8sW0A	97cNk3BQxWEvCSLmUbGru_jnIMH-P-E7BDw6raUdwdg	DIVORCED	ACTIVE	01	01	01	01	01	01	01	01	12345	12345	a5pLx0OH_SUGZoK15Kdocw	1980-10-05 00:00:00	01	01	01	01	01	01	01	01	01	ip9AhfRIloOlr2BoQc-q6w	MEDIUM	2030-12-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-09-11 05:24:58.53916	SYSTEM	\N	\N	Test	\N	bJDblATAnPcQ
3204	CUSTOMER	01	r4Bf9SNABOXJKmGZUmc9Jg	zBE7GuN1Q9eLP6vIC11q2g	 	xIfTfiS0PU_vR16OAAAh6Q	Test	Test	MALE	2023-08-29 00:00:00	Sao Paolo	01	PgTRV5wLSFO-22yyj8sW0A	jhkUlYg2iz2xqMDFhBXhfzp4K8xxWsy2bHHKpeD0gNg	MARRIED	ACTIVE	01	01	01	01	01	01	01	01	12345	12345	a5pLx0OH_SUGZoK15Kdocw	1980-10-05 00:00:00	01	01	01	01	01	01	01	01	01	ip9AhfRIloOlr2BoQc-q6w	MEDIUM	2030-12-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-09-11 05:28:41.845612	SYSTEM	\N	\N	Test	\N	mE72ZEy7xdjY
3205	CUSTOMER	01	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	 		Test	Test	MALE	2015-08-01 00:00:00	USA	01	D70VrrbOX8U0ZS7PU9hR5A	3gbz4GZMDFvy6GUza_PXIsPz35zOOlx4uePXVKNpfJE	MARRIED	ACTIVE	01	01	01	01	01	01	01	01	12345	12345	a5pLx0OH_SUGZoK15Kdocw	1980-10-05 00:00:00	01	01	01	01	01	01	01	01	01	ip9AhfRIloOlr2BoQc-q6w	MEDIUM	2030-12-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-09-11 06:27:58.260763	SYSTEM	\N	\N	Test	\N	FG99U9BPgsws
3206	CUSTOMER	01	gEXsGen-cJvwfkAnf2lY45bi3fqtM2pmri-Va7OxHYk	mIqqtky9dGL4VK0dc2dUPw	E-_hqWABEeALwhR8U0kHHw	GRShsQVKMyNwWWucL7VqWw	Test	Test	MALE	1992-05-01 00:00:00	Pune 	01	AJP2iSaaGTS27EIJKU3YHw	n6y_8c2q_ZjrNjQXK4FeRng9v5uMybmJkEILvOPx_RY	SINGLE	ACTIVE	01	01	01	01	01	01	01	01	12345	12345	a5pLx0OH_SUGZoK15Kdocw	1980-10-05 00:00:00	01	01	01	01	01	01	01	01	01	ip9AhfRIloOlr2BoQc-q6w	MEDIUM	2030-12-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-09-12 06:18:28.084335	SYSTEM	\N	\N	Test	\N	jBuOrfihvXlF
3207	CUSTOMER	01	y6_WarMaUMdD7flxeoTWxg	mIqqtky9dGL4VK0dc2dUPw	 		Test	Test	MALE	1990-09-12 00:00:00	Ahahha	01	AJP2iSaaGTS27EIJKU3YHw	kqCUzXA8MmAWsufTDEOrUg	SINGLE	ACTIVE	01	01	01	01	01	01	01	01	12345	12345	a5pLx0OH_SUGZoK15Kdocw	1980-10-05 00:00:00	01	01	01	01	01	01	01	01	01	ip9AhfRIloOlr2BoQc-q6w	MEDIUM	2030-12-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-09-12 07:09:14.381563	SYSTEM	\N	\N	Test	\N	Vrsdpr9wQgHS
3208	CUSTOMER	01	gEXsGen-cJvwfkAnf2lY45bi3fqtM2pmri-Va7OxHYk	mIqqtky9dGL4VK0dc2dUPw	E-_hqWABEeALwhR8U0kHHw	GRShsQVKMyNwWWucL7VqWw	Test	Test	MALE	1992-09-12 00:00:00	Pune 	01	AJP2iSaaGTS27EIJKU3YHw	n6y_8c2q_ZjrNjQXK4FeRng9v5uMybmJkEILvOPx_RY	SINGLE	ACTIVE	01	01	01	01	01	01	01	01	12345	12345	a5pLx0OH_SUGZoK15Kdocw	1980-10-05 00:00:00	01	01	01	01	01	01	01	01	01	ip9AhfRIloOlr2BoQc-q6w	MEDIUM	2030-12-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-09-12 08:07:20.207078	SYSTEM	\N	\N	Test	\N	x4I0KSxfajj5
3209	CUSTOMER	01	6YMimlq4yOCJSrLtKSn3ig	6YMimlq4yOCJSrLtKSn3ig	 		Test	Test	MALE	2023-09-12 00:00:00	Chennai	01	PgTRV5wLSFO-22yyj8sW0A	a-igAUUAvfPCqaHs-hG47Es2yVgiepmL9xyUm54CnK4	SINGLE	ACTIVE	01	01	01	01	01	01	01	01	12345	12345	a5pLx0OH_SUGZoK15Kdocw	1980-10-05 00:00:00	01	01	01	01	01	01	01	01	01	ip9AhfRIloOlr2BoQc-q6w	MEDIUM	2030-12-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-09-12 10:59:20.303809	SYSTEM	\N	\N	Test	\N	MtkMZwZBBuaM
3218	CUSTOMER	01	2ef9xzHPoVXMlQ4xmSIA1cO-_nT5XP8QZc3oQ0ySoyM	rIXAEe14cX0NGfp96-_SnQ	d5DNVTUbmDpan43PDszgaQ	Jpi02foLb4W1PFvhon9OOw	Test	Test	MALE	1900-01-01 00:00:00	Kanpur	01	PgTRV5wLSFO-22yyj8sW0A	PKrsQziEDyysIiJXFCFbVTp4K8xxWsy2bHHKpeD0gNg	MARRIED	ACTIVE	01	01	01	01	01	01	01	01	12345	12345	a5pLx0OH_SUGZoK15Kdocw	1980-10-05 00:00:00	01	01	01	01	01	01	01	01	01	ip9AhfRIloOlr2BoQc-q6w	MEDIUM	2030-12-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-09-15 16:05:24.707596	SYSTEM	\N	\N	Test	\N	3mykipGY5Y4q
3210	CUSTOMER	01	WpWzyx1W2PraFyOuLoPR-Q	ZnzG2d-NQmYC9RKgMLNNZA	 	b-Wm3qG7rqsT-mAchx6AAQ	Test	Test	MALE	2023-09-01 00:00:00	Test	01	PgTRV5wLSFO-22yyj8sW0A	wB7R7Ei3sF_TjsnT6PEoyIQRL9iM3DzN_feYrQoXgEY	SINGLE	ACTIVE	01	01	01	01	01	01	01	01	12345	12345	a5pLx0OH_SUGZoK15Kdocw	1980-10-05 00:00:00	01	01	01	01	01	01	01	01	01	ip9AhfRIloOlr2BoQc-q6w	MEDIUM	2030-12-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-09-12 16:02:36.212956	SYSTEM	\N	\N	Test	\N	a1EfTrCTONyr
3096	CUSTOMER	01	ok-3yhvUlblBua5n62W6pSlaRouMPh_OxbjAsKPhJ8g	9j4rxPBA3vp6t0EHHwKNwA	PQhVDLryGvWpGNXEs3jTUw	MQRd5aKYi5R2QJgjQ5rEaw		David	MALE	1989-11-13 00:00:00	Texas	05	8SRZFW_LRAk3_cYJlUzNsw	sgai8pjJ3cJslhHA0DIpcUSeVevX65ttK5CNVQMHsZc	MARRIED	ACTIVE	03	03			03	05	01	04	129548	0	7sY-fg9b6dvKTvj36mSfOA	1980-10-05 00:00:00		CG09		PP12	01	01	RC01	T01	02	F8dmK7-W45wkLelmuWADcg	LOW	2003-11-20 00:00:00	t	f	f	f	f	f	\N	f	f	f	f	f	f	f	2023-06-09 09:14:06.389807	SYSTEM	2023-09-15 20:56:00.649816	SYSTEM	Web	\N	32d0dc12-38ef-482d-a06d-d5a897560df0
3219	CUSTOMER	01	_c-JMr78B0ekPfrGgF-_czp4K8xxWsy2bHHKpeD0gNg	Ch1anWJTMK_5y9UiWLrnsg	JNLBNSMV02tpy-UMq9nKzA	oSb2n2mvN5RrIEPaihbMnw	\N	Abhi	MALE	1989-11-13 00:00:00	Punjab	03	VwN862ZBLaNDd1fGs8J85A	BDIKFyfbGMgKVOePG_VEmkk6Opz8oLdql1IhA0pLZMg	MARRIED	ACTIVE	\N	\N	01	\N	\N	02	\N	02	\N	\N	\N	\N	\N	\N	\N	\N	01	\N	\N	\N	02	rxu19aqMqs9CHQUupeKEkA	\N	\N	t	\N	f	f	f	f	\N	f	f	f	f	f	f	f	2023-09-21 06:22:32.391112	SYSTEM	\N	\N	\N	\N	cb1ada67-6e36-4d34-b493-195b661f5bb4
3211	CUSTOMER	01	7LlhI3otxSOteKTe0Ka5Snyyx4AYYwtHnd69KaxcSn4	Vm7zwTRjtd58L_wfvRTUEQ	JNLBNSMV02tpy-UMq9nKzA	oSb2n2mvN5RrIEPaihbMnw	\N	Abhi	MALE	1989-11-13 00:00:00	Punjab	03	6mKeU4wPkRdQL6Y_njuKUg	BDIKFyfbGMgKVOePG_VEmkk6Opz8oLdql1IhA0pLZMg	MARRIED	ACTIVE	\N	\N	01	\N	\N	02	\N	02	\N	\N	\N	\N	\N	\N	\N	\N	01	\N	\N	\N	02	rxu19aqMqs9CHQUupeKEkA	\N	\N	t	\N	f	f	f	f	\N	f	f	f	f	f	f	f	2023-09-15 07:02:40.171644	SYSTEM	\N	\N	\N	\N	da44b827-ae47-4d48-8481-f0e5193eb8b6
3212	CUSTOMER	01	A31xZu2-o6jryV98Uvo3FHyyx4AYYwtHnd69KaxcSn4	GxClDBpZXh0-BVDZlTT9vg	JNLBNSMV02tpy-UMq9nKzA	oSb2n2mvN5RrIEPaihbMnw	\N	Abhi	MALE	1989-11-13 00:00:00	Punjab	03	wCgPaC82_Lmj1mZWGpg1Tw	BDIKFyfbGMgKVOePG_VEmkk6Opz8oLdql1IhA0pLZMg	MARRIED	ACTIVE	\N	\N	01	\N	\N	02	\N	02	\N	\N	\N	\N	\N	\N	\N	\N	01	\N	\N	\N	02	rxu19aqMqs9CHQUupeKEkA	\N	\N	t	\N	f	f	f	f	\N	f	f	f	f	f	f	f	2023-09-15 07:04:54.953383	SYSTEM	\N	\N	\N	\N	70a3470e-022d-4fa8-903d-99c4c44ef8fd
3213	CUSTOMER	01	zuIO5r6nvLfIPnzZKrxwfi1ubtrpgQjXgi_7ZikmWeA	Dg1y15zvCtXYCwdgJ5pAyQ	JNLBNSMV02tpy-UMq9nKzA	oSb2n2mvN5RrIEPaihbMnw	\N	Abhi	MALE	1989-11-13 00:00:00	Punjab	03	4AwJc9fDt2B6OU1kDmf_UA	BDIKFyfbGMgKVOePG_VEmkk6Opz8oLdql1IhA0pLZMg	MARRIED	ACTIVE	\N	\N	01	\N	\N	02	\N	02	\N	\N	\N	\N	\N	\N	\N	\N	01	\N	\N	\N	02	rxu19aqMqs9CHQUupeKEkA	\N	\N	t	\N	f	f	f	f	\N	f	f	f	f	f	f	f	2023-09-15 07:12:09.566295	SYSTEM	\N	\N	\N	\N	0caa5166-3730-41dc-aaa5-d959db760c0e
3220	CUSTOMER	01	RpWTkswNHRI-AirC5_b9nA	tTs0oQ0c9MGAtVtuV_Z4nQ	Dj_a183kK45MDpkBJr-pYA	K4iV7NnY41rSnGbSe8C1hg	Test	Test	MALE	1900-01-01 00:00:00	Test	01	ZKPKBsaeUXTAtPuchEx9BQ	0kcQeBCObprEtj3jGo44mDp4K8xxWsy2bHHKpeD0gNg	SINGLE	ACTIVE	01	01	01	01	01	01	01	01	12345	12345	a5pLx0OH_SUGZoK15Kdocw	1980-10-05 00:00:00	01	01	01	01	01	01	01	01	01	ip9AhfRIloOlr2BoQc-q6w	MEDIUM	2030-12-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-09-21 07:06:59.2669	SYSTEM	\N	\N	Test	\N	JjO6fBcQTQIM
3222	CUSTOMER	01	gEXsGen-cJvwfkAnf2lY45bi3fqtM2pmri-Va7OxHYk	mIqqtky9dGL4VK0dc2dUPw	E-_hqWABEeALwhR8U0kHHw	GRShsQVKMyNwWWucL7VqWw	Test	Test	MALE	1900-01-01 00:00:00	Pune Maharashtra 	01	AJP2iSaaGTS27EIJKU3YHw	n6y_8c2q_ZjrNjQXK4FeRng9v5uMybmJkEILvOPx_RY	SINGLE	ACTIVE	01	01	01	01	01	01	01	01	12345	12345	a5pLx0OH_SUGZoK15Kdocw	1980-10-05 00:00:00	01	01	01	01	01	01	01	01	01	ip9AhfRIloOlr2BoQc-q6w	MEDIUM	2030-12-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-09-21 09:35:17.102293	SYSTEM	\N	\N	Test	\N	3SWw1kAeGZHk
3214	CUSTOMER	01	irQw9lqBDVBVTMjrgV7sDy1ubtrpgQjXgi_7ZikmWeA	-tj527uTpJSKU3YLe3Y3Qg	JNLBNSMV02tpy-UMq9nKzA	oSb2n2mvN5RrIEPaihbMnw	\N	Abhi	MALE	1989-11-13 00:00:00	Punjab	03	wCgPaC82_Lmj1mZWGpg1Tw	BDIKFyfbGMgKVOePG_VEmkk6Opz8oLdql1IhA0pLZMg	MARRIED	ACTIVE	\N	\N	01	\N	\N	02	\N	02	\N	\N	\N	\N	\N	\N	\N	\N	01	\N	\N	\N	02	rxu19aqMqs9CHQUupeKEkA	\N	\N	t	\N	f	f	f	f	\N	f	f	f	f	f	f	f	2023-09-15 11:40:25.187997	SYSTEM	\N	\N	\N	\N	c5e7dae3-d089-437a-84b4-e9ef22f984d9
3215	CUSTOMER	01	O9s6VM8GYs3Zh4wp3y9qyTvA-SvdrKHPP3eAts4eNCc	QHQ1V835XY-A-N2MGIg2yw	CckkVtv247lIMshBT1QMdg	oSb2n2mvN5RrIEPaihbMnw	\N	Abhi	MALE	1989-11-13 00:00:00	Punjab	03	U783jg6464you8fTam8C2A	BDIKFyfbGMgKVOePG_VEmkk6Opz8oLdql1IhA0pLZMg	MARRIED	ACTIVE	\N	\N	01	\N	\N	02	\N	02	\N	\N	\N	\N	\N	\N	\N	\N	01	\N	\N	\N	02	rxu19aqMqs9CHQUupeKEkA	\N	\N	t	\N	f	f	f	f	\N	f	f	f	f	f	f	f	2023-09-15 11:44:42.273368	SYSTEM	\N	\N	\N	\N	3aa496eb-f007-49ae-8bde-e3f284a9c8a2
3216	CUSTOMER	01	vod2uzXAx8k7TA72WeJ2Gi7DF3sEqrwndu0BxIludk0	WkleElW30CVkmc1d0wvUjg	9_1bqvooFcg6cYn5DLYb1Q	0pysDO1_iwonT3tan9aq2g	Test	Test	MALE	1900-01-01 00:00:00	Bhopal	01	PgTRV5wLSFO-22yyj8sW0A	k-SAgs9rBIQanzxlPrc3aTp4K8xxWsy2bHHKpeD0gNg	SINGLE	ACTIVE	01	01	01	01	01	01	01	01	12345	12345	a5pLx0OH_SUGZoK15Kdocw	1980-10-05 00:00:00	01	01	01	01	01	01	01	01	01	ip9AhfRIloOlr2BoQc-q6w	MEDIUM	2030-12-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-09-15 13:17:54.50116	SYSTEM	\N	\N	Test	\N	uo4MWynFEiXL
3217	CUSTOMER	01	3xwDbBnKrDEG6zuVxxPGULratBscoqLjcmpHAq_9dIs	zkmI_GQmzEQcOS2Nm3-O4w	AfKLkUHxeSY9QQGmc7WsFg	0pysDO1_iwonT3tan9aq2g	Test	Test	MALE	1900-01-01 00:00:00	Bhopal	01	PgTRV5wLSFO-22yyj8sW0A	OMT_L3WXfxkPKO9SVBV-7Q	SINGLE	ACTIVE	01	01	01	01	01	01	01	01	12345	12345	a5pLx0OH_SUGZoK15Kdocw	1980-10-05 00:00:00	01	01	01	01	01	01	01	01	01	ip9AhfRIloOlr2BoQc-q6w	MEDIUM	2030-12-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-09-15 15:57:51.772047	SYSTEM	\N	\N	Test	\N	yFjAgD3ef45Z
3221	CUSTOMER	01	gCPzPQeyabzkRRbNDBuyrg	mxZMl2mmD0BBHasntxQTQQ	JNLBNSMV02tpy-UMq9nKzA	oSb2n2mvN5RrIEPaihbMnw	\N	Abhi	MALE	1989-11-13 00:00:00	Punjab	03	VwN862ZBLaNDd1fGs8J85A	BDIKFyfbGMgKVOePG_VEmkk6Opz8oLdql1IhA0pLZMg	MARRIED	ACTIVE	\N	\N	01	\N	\N	02	\N	02	\N	\N	\N	\N	\N	\N	\N	\N	01	\N	\N	\N	02	rxu19aqMqs9CHQUupeKEkA	\N	\N	t	\N	f	f	f	f	\N	f	f	f	f	f	f	f	2023-09-21 07:20:00.28413	SYSTEM	\N	\N	\N	\N	c9026fb8-f68c-43a0-a7fe-42bfa3f6089e
3223	CUSTOMER	01	qF2TTuVshW08NcPqVeviKA	qF2TTuVshW08NcPqVeviKA	 		Test	Test	MALE	1900-01-01 00:00:00	Fui9	01	ZKPKBsaeUXTAtPuchEx9BQ	T-x_Y07U9BvlKyISHPqWxV9wdK-t9AlLqcLgIjHnOpI	WIDOWED	ACTIVE	01	01	01	01	01	01	01	01	12345	12345	a5pLx0OH_SUGZoK15Kdocw	1980-10-05 00:00:00	01	01	01	01	01	01	01	01	01	ip9AhfRIloOlr2BoQc-q6w	MEDIUM	2030-12-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-09-21 09:53:59.12693	SYSTEM	\N	\N	Test	\N	mUypDUqATI8i
3224	CUSTOMER	01	JveISkNwhZmw2HK_NK8VxA	J7NnC-ATgkpW33ReT3NQUA	zsALc8-WHgE1i1Q_55v2Qw	6d3R3B52Opml3u2lOtEd5w	Test	Test	MALE	2023-08-30 00:00:00	Test	01	2kpjYHAU0OQKgyE_Toa7SQ	IzOmM-S-V6UeMUvV15rgcA	MARRIED	ACTIVE	01	01	01	01	01	01	01	01	12345	12345	a5pLx0OH_SUGZoK15Kdocw	1980-10-05 00:00:00	01	01	01	01	01	01	01	01	01	0HsN7_2eIwIp698lLI-fpg	MEDIUM	2030-12-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-09-21 12:47:31.939461	SYSTEM	\N	\N	Test	\N	WBpGknWgwst2
3225	CUSTOMER	01	gEXsGen-cJvwfkAnf2lY41Bxibvj3-8di_NP8B7jyvM	mIqqtky9dGL4VK0dc2dUPw	E-_hqWABEeALwhR8U0kHHw	GRShsQVKMyNwWWucL7VqWw	Test	Test	MALE	1992-05-01 00:00:00	Pune Maharashtra 	01	AJP2iSaaGTS27EIJKU3YHw	n6y_8c2q_ZjrNjQXK4FeRng9v5uMybmJkEILvOPx_RY	SINGLE	ACTIVE	01	01	01	01	01	01	01	01	12345	12345	a5pLx0OH_SUGZoK15Kdocw	1980-10-05 00:00:00	01	01	01	01	01	01	01	01	01	ip9AhfRIloOlr2BoQc-q6w	MEDIUM	2030-12-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-09-21 13:55:45.030766	SYSTEM	\N	\N	Test	\N	MjH8goc7pOl2
3226	CUSTOMER	01	98RxigoLJ3KNj_k0Y6IZog	aznnYefpcPbWbCXfxlpECw	 	SjjV4wEECeQLxCkgXoo_cg	Test	Test	MALE	2005-09-06 00:00:00	Ranchi	01	ZKPKBsaeUXTAtPuchEx9BQ	21BgvfkU2zvQl7itAf8bpTp4K8xxWsy2bHHKpeD0gNg	MARRIED	ACTIVE	01	01	01	01	01	01	01	01	12345	12345	a5pLx0OH_SUGZoK15Kdocw	1980-10-05 00:00:00	01	01	01	01	01	01	01	01	01	ip9AhfRIloOlr2BoQc-q6w	MEDIUM	2030-12-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-09-21 15:24:31.546428	SYSTEM	\N	\N	Test	\N	Q8mO9wkQRf9o
3227	CUSTOMER	01	uQeSRQD1nNjUpc3yHzf3FQ	uQeSRQD1nNjUpc3yHzf3FQ	 		Test	Test	MALE	1900-01-01 00:00:00	Sggs	01	ZKPKBsaeUXTAtPuchEx9BQ	lXoYTzHmBROODW6bNQQX8VA42vwrb9bbgFohQsDcfcw	WIDOWED	ACTIVE	01	01	01	01	01	01	01	01	12345	12345	a5pLx0OH_SUGZoK15Kdocw	1980-10-05 00:00:00	01	01	01	01	01	01	01	01	01	ip9AhfRIloOlr2BoQc-q6w	MEDIUM	2030-12-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-09-21 17:19:22.937851	SYSTEM	\N	\N	Test	\N	ac0hkSpFo4Kz
3228	CUSTOMER	01	lTQipmuCRUb542mvQrvnfjp4K8xxWsy2bHHKpeD0gNg		JL48gh4m8-GV7uYbhE0FEQ	9J2OJBjRsbanB7lxfMcJ2w	Test	Test	MALE	2005-09-13 00:00:00	Vellore 	01	ZKPKBsaeUXTAtPuchEx9BQ	xnS7G449vE0OD-VZWGCorzlzK3tDf3CRnOflXlUhNnA	SINGLE	ACTIVE	01	01	01	01	01	01	01	01	12345	12345	a5pLx0OH_SUGZoK15Kdocw	1980-10-05 00:00:00	01	01	01	01	01	01	01	01	01	ip9AhfRIloOlr2BoQc-q6w	MEDIUM	2030-12-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-09-22 04:40:48.560713	SYSTEM	\N	\N	Test	\N	FY8EMSsVwbgR
3229	CUSTOMER	01	HgIKmefJ2-ToHKw8H-aHju393JDKJIclFQR_j3bWlHw	y6B64xYqWttonRMLuvepSA	d5DNVTUbmDpan43PDszgaQ	7f3ckMokhyUVBH-PdtaUfA	Test	Test	MALE	1999-09-01 00:00:00	Bhopal	01	AJP2iSaaGTS27EIJKU3YHw	GO_b9Z40YPkIz1PsHj_aeQ	MARRIED	ACTIVE	01	01	01	01	01	01	01	01	12345	12345	a5pLx0OH_SUGZoK15Kdocw	1980-10-05 00:00:00	01	01	01	01	01	01	01	01	01	ip9AhfRIloOlr2BoQc-q6w	MEDIUM	2030-12-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-09-22 09:01:34.049294	SYSTEM	\N	\N	Test	\N	xNbXCshCpurg
3230	CUSTOMER	01	hdpuDj_3pPtc1ahfIGUCDQ	hdpuDj_3pPtc1ahfIGUCDQ	 		Test	Test	MALE	1996-09-22 00:00:00	Shzhjahz	01	AJP2iSaaGTS27EIJKU3YHw	82E7_Ra8CQ9mdEX6w4nylA	SINGLE	ACTIVE	01	01	01	01	01	01	01	01	12345	12345	a5pLx0OH_SUGZoK15Kdocw	1980-10-05 00:00:00	01	01	01	01	01	01	01	01	01	ip9AhfRIloOlr2BoQc-q6w	MEDIUM	2030-12-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-09-22 10:47:19.248152	SYSTEM	\N	\N	Test	\N	GumC3OGFHs1e
3231	CUSTOMER	01	TNqlzioPpBdsg5MBFXKciP9FjmE17FznvNkx5yajyL0	eEajgJcBn9sDyyGc6iVPoA	AfKLkUHxeSY9QQGmc7WsFg	vmdi_BIU5VihSZPKa53q0A	Test	Test	MALE	2005-09-01 00:00:00	bhopal	01	ZKPKBsaeUXTAtPuchEx9BQ	KFVs7uS77KF7MO7vw35ZddCMM_PYKdes2hhdd840FeM	MARRIED	ACTIVE	01	01	01	01	01	01	01	01	12345	12345	a5pLx0OH_SUGZoK15Kdocw	1980-10-05 00:00:00	01	01	01	01	01	01	01	01	01	ip9AhfRIloOlr2BoQc-q6w	MEDIUM	2030-12-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-09-22 12:42:09.807285	SYSTEM	\N	\N	Test	\N	6jItTbYsm7js
3232	CUSTOMER	01	sEqxmWw0Gs-D5FP-nTdxsA	8KzZrwi9pgF4z2O8atxvlw	 	sfuziWjOsNQ7k8PkxGqL4Q	Test	Test	FEMALE	2005-09-16 00:00:00	Vellore	01	ZKPKBsaeUXTAtPuchEx9BQ	xnS7G449vE0OD-VZWGCorzlzK3tDf3CRnOflXlUhNnA	MARRIED	ACTIVE	01	01	01	01	01	01	01	01	12345	12345	a5pLx0OH_SUGZoK15Kdocw	1980-10-05 00:00:00	01	01	01	01	01	01	01	01	01	ip9AhfRIloOlr2BoQc-q6w	MEDIUM	2030-12-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-09-22 15:14:46.906182	SYSTEM	\N	\N	Test	\N	e3ffRM6u7aK9
3233	CUSTOMER	01	ch5_W_BX2ePJjaclXh7_Gw	zkmI_GQmzEQcOS2Nm3-O4w	JEExlFyd7gj0K6FqMB3hSQ		Test	Test	MALE	1997-09-22 00:00:00	Bhopal MP	01	6-T0Abvfz2lKvqPjPeIxTA	nfDfM817_1o48Kg-2-nxuDp4K8xxWsy2bHHKpeD0gNg	MARRIED	ACTIVE	01	01	01	01	01	01	01	01	12345	12345	a5pLx0OH_SUGZoK15Kdocw	1980-10-05 00:00:00	01	01	01	01	01	01	01	01	01	ip9AhfRIloOlr2BoQc-q6w	MEDIUM	2030-12-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-09-22 15:17:10.29556	SYSTEM	\N	\N	Test	\N	WjhojkxnXzDp
3234	CUSTOMER	01	pBV5x_XOhZV3_H8XR_VKGw	kY2XXZZ0uxpBMlPgfnXSzw	 		Test	Test	FEMALE	2005-09-21 00:00:00	Karur	01	ZKPKBsaeUXTAtPuchEx9BQ	05TzHOy5hdTpDE8x7g4YOV9wdK-t9AlLqcLgIjHnOpI	MARRIED	ACTIVE	01	01	01	01	01	01	01	01	12345	12345	a5pLx0OH_SUGZoK15Kdocw	1980-10-05 00:00:00	01	01	01	01	01	01	01	01	01	ip9AhfRIloOlr2BoQc-q6w	MEDIUM	2030-12-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-09-26 06:08:13.058449	SYSTEM	\N	\N	Test	\N	71KaIS7Xh9IG
3235	CUSTOMER	01	pBV5x_XOhZV3_H8XR_VKGw	kY2XXZZ0uxpBMlPgfnXSzw	 		Test	Test	FEMALE	2005-09-15 00:00:00	Karur 	01	ZKPKBsaeUXTAtPuchEx9BQ	05TzHOy5hdTpDE8x7g4YOV9wdK-t9AlLqcLgIjHnOpI	MARRIED	ACTIVE	01	01	01	01	01	01	01	01	12345	12345	a5pLx0OH_SUGZoK15Kdocw	1980-10-05 00:00:00	01	01	01	01	01	01	01	01	01	ip9AhfRIloOlr2BoQc-q6w	MEDIUM	2030-12-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-09-26 06:30:05.407418	SYSTEM	\N	\N	Test	\N	6f84EAgyoaQ7
3236	CUSTOMER	01	6T90T9aiim6gMpDQFbNhAA	aznnYefpcPbWbCXfxlpECw	SjjV4wEECeQLxCkgXoo_cg		Test	Test	MALE	2005-09-26 00:00:00	Ranchi 	01	ZKPKBsaeUXTAtPuchEx9BQ	SjMrkHzJ0HrKZgpkIX2AEF9wdK-t9AlLqcLgIjHnOpI	MARRIED	ACTIVE	01	01	01	01	01	01	01	01	12345	12345	a5pLx0OH_SUGZoK15Kdocw	1980-10-05 00:00:00	01	01	01	01	01	01	01	01	01	ip9AhfRIloOlr2BoQc-q6w	MEDIUM	2030-12-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-09-26 06:55:10.650266	SYSTEM	\N	\N	Test	\N	M5BdmqAuWjaB
3237	CUSTOMER	01	5J0l6z8XnfmKcYijC-MIAA	9J2OJBjRsbanB7lxfMcJ2w	C20D8pWrZFvaaYrdLfu9Dw	QONsxEwfbYS9CEoED2B71g	Test	Test	MALE	1993-09-26 00:00:00	Bhopal	01	ZKPKBsaeUXTAtPuchEx9BQ	0AN9UMlumfHAQ87ZkxfI3w	SINGLE	ACTIVE	01	01	01	01	01	01	01	01	12345	12345	a5pLx0OH_SUGZoK15Kdocw	1980-10-05 00:00:00	01	01	01	01	01	01	01	01	01	ip9AhfRIloOlr2BoQc-q6w	MEDIUM	2030-12-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-09-26 14:39:41.444879	SYSTEM	\N	\N	Test	\N	ODicSMAwio8r
3238	CUSTOMER	01	4wb4AjQHMAZJvNJ4H7oXZy-MzLjd5FEVcwbZG6_Y_U0	2vt4OqAe4lk1QiOLmELlRQ	ioFC9GIlSnl8qpZzbkixrQ	5C8iPEWRwzhD36MiatT3hw	Test	Test	MALE	1900-01-01 00:00:00	Bhopal	01	ZKPKBsaeUXTAtPuchEx9BQ	KZlirdc1TCnuhlD7wdnlrQ	MARRIED	ACTIVE	01	01	01	01	01	01	01	01	12345	12345	a5pLx0OH_SUGZoK15Kdocw	1980-10-05 00:00:00	01	01	01	01	01	01	01	01	01	ip9AhfRIloOlr2BoQc-q6w	MEDIUM	2030-12-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-09-27 06:46:52.850322	SYSTEM	\N	\N	Test	\N	AoceZNK0Rg9J
3239	CUSTOMER	01	Z4vQk2-C6PNQXEdNp7Nx6tQ4reuucyKXzNA2JfbWTmc	aSiFW3Tkx_tUJjm7jgM7Lw	geDqYdjAf5OhzY4fc3J-qQ	1DWOzpt6207Kg5izEXUSlw	Test	Test	MALE	1995-09-15 00:00:00	Pune Maharashtra 	01	AJP2iSaaGTS27EIJKU3YHw	UL7oZVBDLMqzqCctiop8qg	SINGLE	ACTIVE	01	01	01	01	01	01	01	01	12345	12345	a5pLx0OH_SUGZoK15Kdocw	1980-10-05 00:00:00	01	01	01	01	01	01	01	01	01	ip9AhfRIloOlr2BoQc-q6w	MEDIUM	2030-12-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-09-27 06:58:58.113541	SYSTEM	\N	\N	Test	\N	Y1QEnKZcxNeu
3240	CUSTOMER	01	ECqXj44ZwUz80YdvA1BYA4sUifmMgdLZiWR5cSZgl9U	HvcI80ngprMJ75oBBfahBg	kxHNUNa1ADSJl_rbR47d7g	UY5YjCbknBDau8_CuWSo9Q	Test	Test	MALE	1900-01-01 00:00:00	bhopal	01	AJP2iSaaGTS27EIJKU3YHw	J3SpfY7rH4_yO3LlPpVCK19wdK-t9AlLqcLgIjHnOpI	MARRIED	ACTIVE	01	01	01	01	01	01	01	01	12345	12345	a5pLx0OH_SUGZoK15Kdocw	1980-10-05 00:00:00	01	01	01	01	01	01	01	01	01	ip9AhfRIloOlr2BoQc-q6w	MEDIUM	2030-12-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-09-27 07:14:32.823949	SYSTEM	\N	\N	Test	\N	Ljb6L9fcXz1h
3241	CUSTOMER	01	5njw1LjsOM7Nn68DYd94k3yyx4AYYwtHnd69KaxcSn4	nFTyDcGulU9YXrF56ZM1TQ	GxClDBpZXh0-BVDZlTT9vg	Dg1y15zvCtXYCwdgJ5pAyQ	Test	Test	MALE	1900-01-01 00:00:00	bhopal	01	AJP2iSaaGTS27EIJKU3YHw	v1QRLY25xdv2AauRkJtTbw	DIVORCED	ACTIVE	01	01	01	01	01	01	01	01	12345	12345	a5pLx0OH_SUGZoK15Kdocw	1980-10-05 00:00:00	01	01	01	01	01	01	01	01	01	ip9AhfRIloOlr2BoQc-q6w	MEDIUM	2030-12-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-09-27 07:20:57.893586	SYSTEM	\N	\N	Test	\N	BI7I4wK4tbaf
3242	CUSTOMER	01	e7IdVS6UTqV6SWaknYTtZg	m3ZijAJaIUNR1fHqW8YbXQ	qfy2GYLKxscDVdCTTh7ZRw	sJLIcWKzd2t_i9bvGZRWuQ	Test	Test	FEMALE	1994-09-27 00:00:00	Bhopal MP	01	AJP2iSaaGTS27EIJKU3YHw	qyE-sn_Pw_xd33ibL04sjA	MARRIED	ACTIVE	01	01	01	01	01	01	01	01	12345	12345	a5pLx0OH_SUGZoK15Kdocw	1980-10-05 00:00:00	01	01	01	01	01	01	01	01	01	ip9AhfRIloOlr2BoQc-q6w	MEDIUM	2030-12-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-09-27 07:24:01.79625	SYSTEM	\N	\N	Test	\N	CmLJgi4ph50M
3243	CUSTOMER	01	uMx2zdaMR-Y63AU_nMzLxVtrgRZR_zrT_m-dxmVeAH8	yWr6EGNw5k8h1XvHcb2zlQ	 	b1hkTaw9a81CYSYp0ixNmw	Test	Test	MALE	2005-09-02 00:00:00	Bhopal	01	ZKPKBsaeUXTAtPuchEx9BQ	_9vwgjZyHdmF99fqE5AbJ4sqPMjWylitRFGSQs7hQoQ	MARRIED	ACTIVE	01	01	01	01	01	01	01	01	12345	12345	a5pLx0OH_SUGZoK15Kdocw	1980-10-05 00:00:00	01	01	01	01	01	01	01	01	01	ip9AhfRIloOlr2BoQc-q6w	MEDIUM	2030-12-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-09-27 09:40:58.622963	SYSTEM	\N	\N	Test	\N	f1tgtCGHT1By
3248	CUSTOMER	01	E-VpxsZhR-pyzDFGZrOGBDp4K8xxWsy2bHHKpeD0gNg	VLA3qaaiuBI-2MRvXqQ1RA	oSb2n2mvN5RrIEPaihbMnw	-JWlBLLqi0L7o7VpcTOi1w	Test	Test	FEMALE	1900-01-01 00:00:00	bhopal	01	AJP2iSaaGTS27EIJKU3YHw	b_Y-xTv3R0N6k0kbhB7YaA	MARRIED	ACTIVE	01	01	01	01	01	01	01	01	12345	12345	a5pLx0OH_SUGZoK15Kdocw	1980-10-05 00:00:00	01	01	01	01	01	01	01	01	01	ip9AhfRIloOlr2BoQc-q6w	MEDIUM	2030-12-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-09-27 10:01:04.046179	SYSTEM	\N	\N	Test	\N	PknDiF2zV9gf
3244	CUSTOMER	01	AT9lkV3fBp4QAQ0mgEtwrjp4K8xxWsy2bHHKpeD0gNg	XgK-9hzCJGbAuPPH3wcfDw	 	APfAXrAGfanR37ZQZJz7qg	Test	Test	MALE	2005-09-09 00:00:00	Bhopal	01	ZKPKBsaeUXTAtPuchEx9BQ	x96RXXw6guIIeA6LR4OMSRrzBeSORwsgV6Tx5mcu7Dw	MARRIED	ACTIVE	01	01	01	01	01	01	01	01	12345	12345	a5pLx0OH_SUGZoK15Kdocw	1980-10-05 00:00:00	01	01	01	01	01	01	01	01	01	ip9AhfRIloOlr2BoQc-q6w	MEDIUM	2030-12-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-09-27 09:45:07.02752	SYSTEM	\N	\N	Test	\N	yXOoi9DUjec7
3245	CUSTOMER	01	SL_0mwYGE4cmMsol8WB7Sjp4K8xxWsy2bHHKpeD0gNg	_TuxcBi5JwDRtxhbjrs-TA	AfKLkUHxeSY9QQGmc7WsFg	iDgM9RBn8fj0ERm_scWQ3g	Test	Test	MALE	1900-01-01 00:00:00	bhopal	01	AJP2iSaaGTS27EIJKU3YHw	ZMy2iKoDWfh_TVU4pGeO1g	MARRIED	ACTIVE	01	01	01	01	01	01	01	01	12345	12345	a5pLx0OH_SUGZoK15Kdocw	1980-10-05 00:00:00	01	01	01	01	01	01	01	01	01	ip9AhfRIloOlr2BoQc-q6w	MEDIUM	2030-12-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-09-27 09:49:16.105071	SYSTEM	\N	\N	Test	\N	54vIkEYXOljU
3246	CUSTOMER	01	35fgTG9zl0liEtYnZFXHbx18MkLBoM83peXIqD6YhKg	BuGQWIhCm7Sxu4pXkjLYGA	AfKLkUHxeSY9QQGmc7WsFg	qvSRGluxC6zlIzcyGXqclw	Test	Test	FEMALE	1900-01-01 00:00:00	bhopal	01	AJP2iSaaGTS27EIJKU3YHw	b_Y-xTv3R0N6k0kbhB7YaA	MARRIED	ACTIVE	01	01	01	01	01	01	01	01	12345	12345	a5pLx0OH_SUGZoK15Kdocw	1980-10-05 00:00:00	01	01	01	01	01	01	01	01	01	ip9AhfRIloOlr2BoQc-q6w	MEDIUM	2030-12-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-09-27 09:55:39.552792	SYSTEM	\N	\N	Test	\N	cvuB8EIxZ1um
3247	CUSTOMER	01	E_R5Qu2A-DxZkqaEegfZu96BHULm8u4eDC-pg2qiTeg	JNLBNSMV02tpy-UMq9nKzA	72ULeM_FeW5bnIkyQaBq5Q	-JWlBLLqi0L7o7VpcTOi1w	Test	Test	MALE	1900-01-01 00:00:00	bhopal	01	AJP2iSaaGTS27EIJKU3YHw	b_Y-xTv3R0N6k0kbhB7YaA	MARRIED	ACTIVE	01	01	01	01	01	01	01	01	12345	12345	a5pLx0OH_SUGZoK15Kdocw	1980-10-05 00:00:00	01	01	01	01	01	01	01	01	01	ip9AhfRIloOlr2BoQc-q6w	MEDIUM	2030-12-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-09-27 09:58:09.878562	SYSTEM	\N	\N	Test	\N	tglGWy7RSiQF
3249	CUSTOMER	01	pRG6t_aISL2l8kZRQOexyWcoyyhJuVvZnw0f7CLHfmg	khAWJCpl6K4--I3Dr71kDw	sJLIcWKzd2t_i9bvGZRWuQ	oSb2n2mvN5RrIEPaihbMnw	Test	Test	MALE	1993-09-27 00:00:00	Pune Maharashtra 	01	AJP2iSaaGTS27EIJKU3YHw	uaU1QQkjbKA76N3OGkdcTg	MARRIED	ACTIVE	01	01	01	01	01	01	01	01	12345	12345	a5pLx0OH_SUGZoK15Kdocw	1980-10-05 00:00:00	01	01	01	01	01	01	01	01	01	ip9AhfRIloOlr2BoQc-q6w	MEDIUM	2030-12-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-09-27 11:30:33.834121	SYSTEM	\N	\N	Test	\N	0I1acMwqQMyA
3250	CUSTOMER	01	fqzEiPVOBZSoSiEzZNdhoDp4K8xxWsy2bHHKpeD0gNg	yqu1M5aSqZrH3b8NLexUfQ	sJLIcWKzd2t_i9bvGZRWuQ	JUXR-rEOWl9bE1zadeSQQA	Test	Test	MALE	1997-09-29 00:00:00	Mumbai Maharashtra 	01	AJP2iSaaGTS27EIJKU3YHw	ORuqv8MiU8-y5_KRuwRvZjp4K8xxWsy2bHHKpeD0gNg	WIDOWED	ACTIVE	01	01	01	01	01	01	01	01	12345	12345	a5pLx0OH_SUGZoK15Kdocw	1980-10-05 00:00:00	01	01	01	01	01	01	01	01	01	ip9AhfRIloOlr2BoQc-q6w	MEDIUM	2030-12-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-09-29 08:25:00.995406	SYSTEM	\N	\N	Test	\N	9mu8SCjO1NJi
3251	CUSTOMER	01	g9bfXTkq851w1QhUv8HZxA	g9bfXTkq851w1QhUv8HZxA	 		Test	Test	MALE	2005-09-15 00:00:00	Chennai 	01	ZKPKBsaeUXTAtPuchEx9BQ	xnS7G449vE0OD-VZWGCorzlzK3tDf3CRnOflXlUhNnA	MARRIED	ACTIVE	01	01	01	01	01	01	01	01	12345	12345	a5pLx0OH_SUGZoK15Kdocw	1980-10-05 00:00:00	01	01	01	01	01	01	01	01	01	ip9AhfRIloOlr2BoQc-q6w	MEDIUM	2030-12-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-09-29 08:58:09.573967	SYSTEM	\N	\N	Test	\N	wT1kLN0WRFwu
3252	CUSTOMER	01	5Bvxx_cu_ytS-w2ilTq3s8LRBEWhJF_0WQpqqkjDMDQ	dw2zpH-QpZF3b0YZ-gJeig	lsypZmRf9tBv2OFIshFL_g	mL41pj4_VdyUfNQU7-WBJQ	Test	Test	MALE	1900-01-01 00:00:00	Bhopal 	01	AJP2iSaaGTS27EIJKU3YHw	DE6_LB23oJH5g3UlqZ6i8Q	MARRIED	ACTIVE	01	01	01	01	01	01	01	01	12345	12345	a5pLx0OH_SUGZoK15Kdocw	1980-10-05 00:00:00	01	01	01	01	01	01	01	01	01	ip9AhfRIloOlr2BoQc-q6w	MEDIUM	2030-12-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-09-29 08:59:32.029841	SYSTEM	\N	\N	Test	\N	ZnCKrAJow0Iz
3253	CUSTOMER	01	GbKYnpR77UBjse2-U44jZg	pRrXCSlj21ynnSSfswamXA	jdEy-VwqF_J7SsL5kncm2g	1JnXqAE1T6rUTC1bG6g72Q	Test	Test	MALE	1996-09-29 00:00:00	Mumbai 	01	AJP2iSaaGTS27EIJKU3YHw	v9Az_ud7yhPLaMU4MyAlql9wdK-t9AlLqcLgIjHnOpI	DIVORCED	ACTIVE	01	01	01	01	01	01	01	01	12345	12345	a5pLx0OH_SUGZoK15Kdocw	1980-10-05 00:00:00	01	01	01	01	01	01	01	01	01	ip9AhfRIloOlr2BoQc-q6w	MEDIUM	2030-12-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-09-29 12:47:15.373817	SYSTEM	\N	\N	Test	\N	rNMF4Oy3Utsv
3254	CUSTOMER	01	oHC66i86jaeG0JmT6S4mljp4K8xxWsy2bHHKpeD0gNg	zq-5ptneoJOQoZojckvZhw	sJLIcWKzd2t_i9bvGZRWuQ	lMjub_lppJXvnClZa3Z3PA	Test	Test	FEMALE	1992-10-03 00:00:00	Hyderabad 	01	AJP2iSaaGTS27EIJKU3YHw	FaHq1Ehw64z6k89QzIzw719wdK-t9AlLqcLgIjHnOpI	DIVORCED	ACTIVE	01	01	01	01	01	01	01	01	12345	12345	a5pLx0OH_SUGZoK15Kdocw	1980-10-05 00:00:00	01	01	01	01	01	01	01	01	01	ip9AhfRIloOlr2BoQc-q6w	MEDIUM	2030-12-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-10-03 05:31:33.885414	SYSTEM	\N	\N	Test	\N	BdzDWnlHpu2I
3255	CUSTOMER	01	pBV5x_XOhZV3_H8XR_VKGw	kY2XXZZ0uxpBMlPgfnXSzw	 		Test	Test	FEMALE	2005-10-01 00:00:00	Karur 	01	ZKPKBsaeUXTAtPuchEx9BQ	05TzHOy5hdTpDE8x7g4YOV9wdK-t9AlLqcLgIjHnOpI	MARRIED	ACTIVE	01	01	01	01	01	01	01	01	12345	12345	a5pLx0OH_SUGZoK15Kdocw	1980-10-05 00:00:00	01	01	01	01	01	01	01	01	01	ip9AhfRIloOlr2BoQc-q6w	MEDIUM	2030-12-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-10-03 10:43:03.741997	SYSTEM	\N	\N	Test	\N	Pk75cXTT0Ksh
3256	CUSTOMER	01	kY2XXZZ0uxpBMlPgfnXSzw	kY2XXZZ0uxpBMlPgfnXSzw	 		Test	Test	FEMALE	1900-01-01 00:00:00	fjgjfgrg	01	ZKPKBsaeUXTAtPuchEx9BQ	ONEunedo_mH4XMOSTKw3zFA42vwrb9bbgFohQsDcfcw	MARRIED	ACTIVE	01	01	01	01	01	01	01	01	12345	12345	a5pLx0OH_SUGZoK15Kdocw	1980-10-05 00:00:00	01	01	01	01	01	01	01	01	01	ip9AhfRIloOlr2BoQc-q6w	MEDIUM	2030-12-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-10-03 11:09:14.956859	SYSTEM	\N	\N	Test	\N	vOYLFKyZ0qtc
3257	CUSTOMER	01	kY2XXZZ0uxpBMlPgfnXSzw	kY2XXZZ0uxpBMlPgfnXSzw	 		Test	Test	FEMALE	2005-10-01 00:00:00	fjgjfgrg	01	ZKPKBsaeUXTAtPuchEx9BQ	ONEunedo_mH4XMOSTKw3zFA42vwrb9bbgFohQsDcfcw	MARRIED	ACTIVE	01	01	01	01	01	01	01	01	12345	12345	a5pLx0OH_SUGZoK15Kdocw	1980-10-05 00:00:00	01	01	01	01	01	01	01	01	01	ip9AhfRIloOlr2BoQc-q6w	MEDIUM	2030-12-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-10-03 11:18:53.50343	SYSTEM	\N	\N	Test	\N	jNWzzZNx4R4L
3258	CUSTOMER	01	QDLQMcAmXfu4xy9jnDrG3UQOGCxZnyFht2SocRr5RiM	02bB5u9kQWH_dHiKZG-OFg	Kumar	oSb2n2mvN5RrIEPaihbMnw	\N	Abhi	MALE	1989-11-13 00:00:00	Punjab	03	6712586132	BDIKFyfbGMgKVOePG_VEmkk6Opz8oLdql1IhA0pLZMg	MARRIED	ACTIVE	\N	\N	01	\N	\N	02	\N	02	\N	\N	\N	\N	\N	\N	\N	\N	01	\N	\N	\N	02	967338482733	\N	\N	t	\N	f	f	f	f	\N	f	f	f	f	f	f	f	2023-10-06 12:38:20.841738	SYSTEM	\N	\N	\N	\N	2ba8b6ed-b99a-4ccd-b309-ee337bb72332
3259	CUSTOMER	01	pBV5x_XOhZV3_H8XR_VKGw	kY2XXZZ0uxpBMlPgfnXSzw	 		Test	Test	FEMALE	2005-10-01 00:00:00	Karur 	01	7904049462	05TzHOy5hdTpDE8x7g4YOV9wdK-t9AlLqcLgIjHnOpI	MARRIED	ACTIVE	01	01	01	01	01	01	01	01	12345	12345	Test	1980-10-05 00:00:00	01	01	01	01	01	01	01	01	01	123456789	MEDIUM	2030-12-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-10-06 13:27:15.930511	SYSTEM	\N	\N	Test	\N	oZFtNLeg4eg6
3260	CUSTOMER	01	1BULDblQBrxp0me5DC495Ek6Opz8oLdql1IhA0pLZMg	wWAkTgZW5Vk4D95rnIHTLw	 	HoSc-HDtLssVm9RPdDollg	Test	Test	MALE	2005-10-01 00:00:00	CHENNAI	01	9750770047	hB2uhB9S-jST1Alh64HU1UJdDbcEkhSXokSnmiQS6AhJOjqc_KC3apdSIQNKS2TI	SINGLE	ACTIVE	01	01	01	01	01	01	01	01	12345	12345	Test	1980-10-05 00:00:00	01	01	01	01	01	01	01	01	01	123456789	MEDIUM	2030-12-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-10-09 06:11:27.351552	SYSTEM	\N	\N	Test	\N	5Kar4rz3LiO1
3261	CUSTOMER	01	wWAkTgZW5Vk4D95rnIHTLw	wWAkTgZW5Vk4D95rnIHTLw	 		Test	Test	MALE	2005-10-01 00:00:00	CHENNAI	01	9750770047	hB2uhB9S-jST1Alh64HU1UJdDbcEkhSXokSnmiQS6AhJOjqc_KC3apdSIQNKS2TI	SINGLE	ACTIVE	01	01	01	01	01	01	01	01	12345	12345	Test	1980-10-05 00:00:00	01	01	01	01	01	01	01	01	01	123456789	MEDIUM	2030-12-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-10-09 06:43:44.159854	SYSTEM	\N	\N	Test	\N	kB2ppCpZiE7M
3262	CUSTOMER	01	pYFRgKA0ym56wRjpUP8sjqEm9p9przeUayBD2ooWzJ8	pOukJX6LA-JYAHhwoBOErw	Kumar	oSb2n2mvN5RrIEPaihbMnw	\N	Abhi	MALE	1989-11-13 00:00:00	Punjab	03	6712586132	BDIKFyfbGMgKVOePG_VEmkk6Opz8oLdql1IhA0pLZMg	MARRIED	ACTIVE	\N	\N	01	\N	\N	02	\N	02	\N	\N	\N	\N	\N	\N	\N	\N	01	\N	\N	\N	02	967338482733	\N	\N	t	\N	f	f	f	f	\N	f	f	f	f	f	f	f	2023-10-18 06:38:48.680529	SYSTEM	\N	\N	\N	\N	dee12f68-b4d9-4706-9918-5bae050c8c9d
3268	CUSTOMER	01	YoHhKUscF0YZUfZh8zqsGxMT8GywDty5gK27ouXn3u4	eJsPj99ZkIieE6GdXNSiKw	Rani	JNLBNSMV02tpy-UMq9nKzA	Test	Test	FEMALE	2000-11-16 00:00:00	Pune 	01	9028119498	AJdlaixXH_l9m8ufDnuyVUk6Opz8oLdql1IhA0pLZMg	SINGLE	ACTIVE	01	01	01	01	01	01	01	01	12345	12345	Test	1980-10-05 00:00:00	01	01	01	01	01	01	01	01	01	123456789	MEDIUM	2030-12-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-11-16 07:50:41.721203	SYSTEM	\N	\N	Test	\N	AOqreeSA3lE5
3269	CUSTOMER	01	lyO1cGEI4Y4bR5tmFHEUgA	lyO1cGEI4Y4bR5tmFHEUgA	 		Test	Test	MALE	1900-01-01 00:00:00	Bhilai 	01	7904049462	yY8PTWudI3Y-lnCxZCbMvw	MARRIED	ACTIVE	01	01	01	01	01	01	01	01	12345	12345	Test	1980-10-05 00:00:00	01	01	01	01	01	01	01	01	01	123456789	MEDIUM	2030-12-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-11-20 05:46:53.92986	SYSTEM	\N	\N	Test	\N	Eg6X85lG94lw
3270	CUSTOMER	01	xJqm3VwN96TK5p1Ri6VKLTvA-SvdrKHPP3eAts4eNCc	JVq81Kn8bICcfmgX79w6iw	Kumar	oSb2n2mvN5RrIEPaihbMnw	\N	Abhi	MALE	1989-11-13 00:00:00	Punjab	03	6712586132	BDIKFyfbGMgKVOePG_VEmkk6Opz8oLdql1IhA0pLZMg	MARRIED	ACTIVE	\N	\N	01	\N	\N	02	\N	02	\N	\N	\N	\N	\N	\N	\N	\N	01	\N	\N	\N	02	967338482733	\N	\N	t	\N	f	f	f	f	\N	f	f	f	f	f	f	f	2023-11-20 07:37:40.527833	SYSTEM	\N	\N	\N	\N	3b01c60e-a441-4360-8fef-8e5fc49b82eb
3271	CUSTOMER	01	394AhVXESqdMEupvU2IHAnhqq-B0JYTeXsXiocInP3I	vmXQyeW698ayIqndN5uRDQ	Kumar	JEExlFyd7gj0K6FqMB3hSQ	Test	Test	MALE	2000-11-21 00:00:00	Pune	01	9028119498	XiXOUy9sqzAuJBgKPJ5-KjlzK3tDf3CRnOflXlUhNnA	SINGLE	ACTIVE	01	01	01	01	01	01	01	01	12345	12345	Test	1980-10-05 00:00:00	01	01	01	01	01	01	01	01	01	123456789	MEDIUM	2030-12-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-11-21 08:13:30.271193	SYSTEM	\N	\N	Test	\N	l2M58IrNwKEG
3272	CUSTOMER	01	31QiFvlha-S69CrdS_OiVS0zPqKMFVO7w5RhkPpVAiA	1dnn-qD993sqAGzgkMu02Q	Kumar	uk_qYeEbCuv5EVTr4rTUWg	Test	Test	MALE	2000-11-21 00:00:00	Pune 	01	9028119498	FV5LtweC9goMoLPx8cl39Tp4K8xxWsy2bHHKpeD0gNg	SINGLE	ACTIVE	01	01	01	01	01	01	01	01	12345	12345	Test	1980-10-05 00:00:00	01	01	01	01	01	01	01	01	01	123456789	MEDIUM	2030-12-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-11-21 08:28:06.545283	SYSTEM	\N	\N	Test	\N	OCNoqEAcj4Z6
3273	CUSTOMER	01	9bjD6_9K5W0Dl6mM23B-lg	lGuO-4Fvuqg5g21M9KLG1A	Van	J7NnC-ATgkpW33ReT3NQUA	Nguyen	Nguyen	MALE	1989-11-13 00:00:00	Vietnam	03	6712586134	DFpTnuLgAyh-5ljIv7hGvgICX95WCGaQa_1dmX-PKuc	MARRIED	ACTIVE	04	03			03	05	01	03	129548	0	TX01	1980-10-05 00:00:00	S22	CG09	G21	PP12	01	01	RC01	T01	02	80033848	LOW	2003-11-20 00:00:00	t	f	f	f	f	f	\N	f	f	f	f	f	f	f	2023-11-24 09:57:41.246308	SYSTEM	\N	\N	Web	\N	4d0d3902-8814-4f50-938d-45cfbfcca577
3190	CUSTOMER	01	VHo-U0l_K3aD12-4WEwimw	5GJjOVIE07-mxls9EA75Bg	g_k9YoalhUiJ9O6CK79YcQ	g_k9YoalhUiJ9O6CK79YcQ	Test	Test	MALE	2023-08-30 00:00:00	Test	01	9344447310	PI63LKCgfLZSTAjwIxJDU1SvNYQfmeelnSiLPoSNOhg	MARRIED	ACTIVE	01	01	01	01	01	01	01	01	12345	12345	a5pLx0OH_SUGZoK15Kdocw	1980-10-05 00:00:00	01	01	01	01	01	01	01	01	01	0HsN7_2eIwIp698lLI-fpg	MEDIUM	2030-12-20 00:00:00	t	t	f	f	f	f	\N	f	f	f	f	f	f	f	2023-09-06 15:01:13.191062	SYSTEM	2023-11-24 12:06:32.344691	SYSTEM	Test	\N	MagTLbDDoAm4
\.


--
-- Data for Name: party_address; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.party_address (party_address_id, party_id, address_type_code, address_line1, address_line2, address_line3, zip_code, is_default, ward_code, district_code, city_code, country_code, document_id) FROM stdin;
5	3004	02	VVTfpRuYETrcHldozlDRNPidBdwxr-qAc7c1t0yvKrk			50005	t	03	01	03	02	01
13	3012	02	fKuvhSmGAu3-0NU3MaZYhg	al54Clmt6jQOQrWep8BaRQ		884661	t	03	02	04	02	01
14	3013	04	bJH4p1hHcixWyO64Wbbg3g	2g8QD4PNKuj77oA7RWMB4Q		501036	t	02	01	03	02	01
4	3003	1	bkftFOdZ7tkoziOZ4QCEsIpUHPH-teT4IiuZhgAwhsA	TkDVhSzEgx9nMwHZX8OZxy2yNfeORcckwdVCL3MMMEs		308215	t	03	01	01	02	01
9	3008	04	k1GefKbZJkfCr-regSK1Gg			501901	t	01	01	01	02	01
21	3020	03	WCz1Gr5q3bZ7NkpuuG80etBZ4Bqh69-cxQOghouCk-U	sjehgJzE17m2T1lb7gjzxQ	-h4zKBiGVvmg8E3uooLH3MsabPUbPqvNtQyVV0TOU_A	511004	t	02	02	01	02	01
22	3021	03	ryGAxl3nJkKWj4XbPTfasc7AC3PPlh4BNYtUP-eb9kM	XDoqH1UTgV1-bzGwYFJZAg	GXZ7nxcTIG4t577-wGejEjp4K8xxWsy2bHHKpeD0gNg	100556	t	02	01	02	02	01
16	3015	03	3fRV4UTIDd65TKvbRJQ79JWzTF--G-heb3FUfW0ypO4	Lde2u1L23QtQQQXx0GhC_Q	a3axkqnlZcWN-d-u4lFk4CF3auDd9UJfgl0IVIjbCEY	733339	t	03	02	03	02	01
18	3017	02	LlbMNxZk3RK4FjALOHrgWRPPu_lKTtl3-l3TnpRmWqo	wO5NlnSwdDC8h2D1vFtVLA		449113	t	01	02	02	02	01
7	3006	01	Hpitx-3lkHivSfC9lyh7oQ	G4gNtwP_g-594CDopHFY-w	ja0dkmxAAFgYNbuyXLP2Tw	301224	t	03	02	04	02	01
25	3024	01	_3QTWX32OmRMFXMgse5otg	xrElz-4Rgm68zWZ69iA8Epbi3fqtM2pmri-Va7OxHYk	AitUbSYrAyu_D6tIQCqh7w	11001	t	01	D01	11	01	01
27	3026	01	Jk3KwIkxfR4gfQxdsxAxTLrN3kUr1IQnqwoGSTA_V64	EZXZ6eKe2XfhPkvCWN_Esii13Wml6OTzQSJfnRS0E1I	AitUbSYrAyu_D6tIQCqh7w	11001	t	01	D01	11	84	01
44	3043	01	Jk3KwIkxfR4gfQxdsxAxTLrN3kUr1IQnqwoGSTA_V64	EZXZ6eKe2XfhPkvCWN_Esii13Wml6OTzQSJfnRS0E1I	AitUbSYrAyu_D6tIQCqh7w	11001	t	01	D01	11	84	01
45	3045	01	Jk3KwIkxfR4gfQxdsxAxTLrN3kUr1IQnqwoGSTA_V64	EZXZ6eKe2XfhPkvCWN_Esii13Wml6OTzQSJfnRS0E1I	AitUbSYrAyu_D6tIQCqh7w	11001	t	01	D01	11	84	01
46	3046	01	Jk3KwIkxfR4gfQxdsxAxTLrN3kUr1IQnqwoGSTA_V64	EZXZ6eKe2XfhPkvCWN_Esii13Wml6OTzQSJfnRS0E1I	AitUbSYrAyu_D6tIQCqh7w	11001	t	01	D01	11	84	01
47	3047	01	Jk3KwIkxfR4gfQxdsxAxTLrN3kUr1IQnqwoGSTA_V64	EZXZ6eKe2XfhPkvCWN_Esii13Wml6OTzQSJfnRS0E1I	AitUbSYrAyu_D6tIQCqh7w	11001	t	01	D01	11	84	01
48	3048	01	Jk3KwIkxfR4gfQxdsxAxTLrN3kUr1IQnqwoGSTA_V64	EZXZ6eKe2XfhPkvCWN_Esii13Wml6OTzQSJfnRS0E1I	AitUbSYrAyu_D6tIQCqh7w	11001	t	01	D01	11	84	01
11	3010	03	zLDLI0blI1fs_q1h7qNGZp0QXAGA-GPhOg0wLF5Yygk	AGW4D3-_X_5vKEPohutMbQ	lcuHSlL-al37qnlbm-6f8Tp4K8xxWsy2bHHKpeD0gNg	169231	t	02	01	02	02	01
26	3025	01	_3QTWX32OmRMFXMgse5otg	xrElz-4Rgm68zWZ69iA8Epbi3fqtM2pmri-Va7OxHYk	AitUbSYrAyu_D6tIQCqh7w	11001	t	01	D01	11	01	01
30	3028	04	wshujnhrfTmKZgwu_NmfnQ	Ma7vehrxLOBfC1bul0phuDp4K8xxWsy2bHHKpeD0gNg		582111	t	01	02	02	02	01
49	3049	01	_3QTWX32OmRMFXMgse5otg	xrElz-4Rgm68zWZ69iA8Epbi3fqtM2pmri-Va7OxHYk	AitUbSYrAyu_D6tIQCqh7w	11001	t	01	D01	01	01	01
50	3050	01	_3QTWX32OmRMFXMgse5otg	xrElz-4Rgm68zWZ69iA8Epbi3fqtM2pmri-Va7OxHYk	AitUbSYrAyu_D6tIQCqh7w	11001	t	01	D01	01	01	01
51	3052	04	wshujnhrfTmKZgwu_NmfnQ	Ma7vehrxLOBfC1bul0phuDp4K8xxWsy2bHHKpeD0gNg		582111	t	01	D01	11	65	01
52	3053	01	bkftFOdZ7tkoziOZ4QCEsIpUHPH-teT4IiuZhgAwhsA	AZZAcaSwOUBdr14yIxvBLw	589MSNKSynKc8Worag7uyg	821883	t	01	02	01	65	01
53	3054	02	VVTfpRuYETrcHldozlDRNPidBdwxr-qAc7c1t0yvKrk	589MSNKSynKc8Worag7uyg		50005	t	02	01	03	65	01
54	3055	01	bpif5P3Cu4TTRjhgtuczDn95j5MHRfVPpF-Eh6Z_1Cc	AZZAcaSwOUBdr14yIxvBLw	-h4zKBiGVvmg8E3uooLH3MsabPUbPqvNtQyVV0TOU_A	139964	t	02	01	04	65	01
55	3056	01	Jk3KwIkxfR4gfQxdsxAxTLrN3kUr1IQnqwoGSTA_V64	EZXZ6eKe2XfhPkvCWN_Esii13Wml6OTzQSJfnRS0E1I	AitUbSYrAyu_D6tIQCqh7w	11001	t	01	01	01	01	01
56	3057	01	Jk3KwIkxfR4gfQxdsxAxTLrN3kUr1IQnqwoGSTA_V64	EZXZ6eKe2XfhPkvCWN_Esii13Wml6OTzQSJfnRS0E1I	AitUbSYrAyu_D6tIQCqh7w	11001	t	01	01	01	01	01
57	3058	01	_3QTWX32OmRMFXMgse5otg	xrElz-4Rgm68zWZ69iA8Epbi3fqtM2pmri-Va7OxHYk	AitUbSYrAyu_D6tIQCqh7w	11001	t	01	D01	11	01	01
58	3059	01	_3QTWX32OmRMFXMgse5otg	xrElz-4Rgm68zWZ69iA8Epbi3fqtM2pmri-Va7OxHYk	AitUbSYrAyu_D6tIQCqh7w	11001	t	01	D01	01	01	01
59	3060	01	_3QTWX32OmRMFXMgse5otg	xrElz-4Rgm68zWZ69iA8Epbi3fqtM2pmri-Va7OxHYk	AitUbSYrAyu_D6tIQCqh7w	11001	t	01	D01	01	01	01
60	3061	01	_3QTWX32OmRMFXMgse5otg	xrElz-4Rgm68zWZ69iA8Epbi3fqtM2pmri-Va7OxHYk	AitUbSYrAyu_D6tIQCqh7w	11001	t	01	D01	01	01	01
61	3062	01	_3QTWX32OmRMFXMgse5otg	xrElz-4Rgm68zWZ69iA8Epbi3fqtM2pmri-Va7OxHYk	AitUbSYrAyu_D6tIQCqh7w	11001	t	01	D01	01	01	01
62	3063	01	p9SlKrLuDZVuBcv0JBCEcjp4K8xxWsy2bHHKpeD0gNg	zrM3qFz3RPR7qr1bcaX2DBAaBISif-QlghYQNHW3tAM	589MSNKSynKc8Worag7uyg	721883	t	02	01	02	65	01
63	3064	02	ScGgKVxkSpsuCTLToAxhnkVxXMLVTpxcX3C5DKCtPf4	YSNj_A1kC6ofvbg72-3GyFWJnL_mQ9dtqarJj-Ht-Xg		51005	t	02	01	04	65	01
64	3065	01	v3XpxRpVnuA0nv5yoqKeG62d3f4AeWVqAWev-XQVsIw	b-L-1j2TRSF-f4u6Y4vuSsxe9eTvYxRHwdyr_qMKfcI	-h4zKBiGVvmg8E3uooLH3MsabPUbPqvNtQyVV0TOU_A	239964	t	02	01	03	65	01
65	3066	04	-_vfXDkoii4LztctwOWevgaKrZcW2xcoeLgvivU04zw			498292	t	01	02	04	65	01
66	3067	04	_p1tcQRsRFwqoI5woV1Qd7usu8OPc51bLWN_WH1DA_I	vArmHyX1bLCPlnoXk-xJmw		582611	t	03	02	04	65	01
67	3068	01	v3XpxRpVnuA0nv5yoqKeG62d3f4AeWVqAWev-XQVsIw	b-L-1j2TRSF-f4u6Y4vuSsxe9eTvYxRHwdyr_qMKfcI	-h4zKBiGVvmg8E3uooLH3MsabPUbPqvNtQyVV0TOU_A	239964	t	02	01	03	65	01
69	3070	01	YblCKEsyLMH1mkskqH8UvJYbjCEairHKVYusx_JqqJo			309363	t	02	02	02	65	01
23	3022	01	Jk3KwIkxfR4gfQxdsxAxTLrN3kUr1IQnqwoGSTA_V64	EZXZ6eKe2XfhPkvCWN_Esii13Wml6OTzQSJfnRS0E1I	AitUbSYrAyu_D6tIQCqh7w	11001	t	01	D01	11	84	01
10	3009	02	GxWHj0WGhx5KZk4EmwCJUA	g_bNEfS50Yz_8rFl9U_KZw		200339	t	02	02	04	02	01
24	3023	01	Jk3KwIkxfR4gfQxdsxAxTLrN3kUr1IQnqwoGSTA_V64	EZXZ6eKe2XfhPkvCWN_Esii13Wml6OTzQSJfnRS0E1I	AitUbSYrAyu_D6tIQCqh7w	11001	t	01	D01	11	84	01
15	3014	04	-_vfXDkoii4LztctwOWevgaKrZcW2xcoeLgvivU04zw			598292	t	02	01	02	02	01
17	3016	01	QqUQ25hAqFMMfLfqYfIHRQ	AZZAcaSwOUBdr14yIxvBLw	589MSNKSynKc8Worag7uyg	821883	t	01	02	03	02	01
6	3005	01	bpif5P3Cu4TTRjhgtuczDn95j5MHRfVPpF-Eh6Z_1Cc			139964	t	02	02	02	02	01
12	3011	03	IQrhQYBcOId5qxGaBz0PRw	UhcoWY_HA28dIZiulFhH8Q	AMqN6zeHEkuX4-84_CifVQ	955844	t	01	01	01	02	01
19	3018	03	W8qWTrTElqkqv5amVyJv5A	i8zsPW78oCx6Dg5BSPRm69URMI4AVpXSib590nS9MCY	OUaWgL_iqUyM0xR2-OStzjQYTBI0oGrJSmYJz_QA4gY	110443	t	01	01	01	02	01
8	3007	03	M3PAEyDlDN8MubJC91TCc7T6XKM8M8r8-cBPwEostoU	kCYqjxuHvUsO9NBProUL9CDkKgR40Lhc4odIsEtJfhw	qAdEJjkqIYiv8-lu4-2_-Dp4K8xxWsy2bHHKpeD0gNg	139447	t	02	02	03	02	01
20	3019	01	NaJhI_tjGLckFGsQk5UPZA	UK8L39Rblp5h19FPOKr_Kg		344910	t	02	02	04	02	01
68	3069	01	v3XpxRpVnuA0nv5yoqKeG62d3f4AeWVqAWev-XQVsIw	b-L-1j2TRSF-f4u6Y4vuSsxe9eTvYxRHwdyr_qMKfcI	-h4zKBiGVvmg8E3uooLH3MsabPUbPqvNtQyVV0TOU_A	239964	t	02	01	03	65	01
72	3073	04	ew1wOXK52u-9ySxxv9EAjJLUJyVjij7GbeTBZos-z3E			883864	t	02	01	04	65	01
70	3071	02	Byhv_MRl8a2I6CVYiL_iBBmrgP9B0YwTU1kIznpoLtE			903107	t	03	02	02	65	01
73	3074	04	EgUA_n_hdTFlMP7nd46yG3887ABd2f-iaCvCjkeA6Vg			531712	t	02	01	04	65	01
74	3076	01	Jk3KwIkxfR4gfQxdsxAxTLrN3kUr1IQnqwoGSTA_V64	EZXZ6eKe2XfhPkvCWN_Esii13Wml6OTzQSJfnRS0E1I	AitUbSYrAyu_D6tIQCqh7w	11001	t	01	01	01	01	01
75	3077	01	Jk3KwIkxfR4gfQxdsxAxTLrN3kUr1IQnqwoGSTA_V64	EZXZ6eKe2XfhPkvCWN_Esii13Wml6OTzQSJfnRS0E1I	AitUbSYrAyu_D6tIQCqh7w	11001	t	01	01	01	01	01
76	3078	01	Jk3KwIkxfR4gfQxdsxAxTLrN3kUr1IQnqwoGSTA_V64	EZXZ6eKe2XfhPkvCWN_Esii13Wml6OTzQSJfnRS0E1I	AitUbSYrAyu_D6tIQCqh7w	11001	t	01	01	01	01	01
147	3156	01	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	123456	t	Test	Test	Test	01	Test
148	3156	01	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	12234	t	01	01	01	Test	Test
149	3157	01	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	123456	t	Test	Test	Test	01	Test
71	3072	01	nMIryt5HevS8USXRh3Surkcl4jshxfcMJHP5YMwbARs	4FtnBJkxlCzVOQJxfzQLxQ	Xf2LRd_LzrKMtn0WXmiO4A	333132	t	03	01	03	02	01
77	3094	01	_3QTWX32OmRMFXMgse5otg	xrElz-4Rgm68zWZ69iA8Epbi3fqtM2pmri-Va7OxHYk	AitUbSYrAyu_D6tIQCqh7w	11001	t	01	D01	01	01	01
78	3095	01	_3QTWX32OmRMFXMgse5otg	xrElz-4Rgm68zWZ69iA8Epbi3fqtM2pmri-Va7OxHYk	AitUbSYrAyu_D6tIQCqh7w	11001	t	01	D01	01	01	01
79	3096	01	rDwyWxjW6uiw8pBLaEzi0Uk6Opz8oLdql1IhA0pLZMg	htRJ9Eq-j-qlj8ah6j74_g	MetQfzFcHJkd9lDUkdFt_A	98109	t	01	53	63000	033	01
80	3097	01	YblCKEsyLMH1mkskqH8UvJYbjCEairHKVYusx_JqqJo			309363	t	01	53	63000	65	01
81	3098	01	rDwyWxjW6uiw8pBLaEzi0Uk6Opz8oLdql1IhA0pLZMg	htRJ9Eq-j-qlj8ah6j74_g	MetQfzFcHJkd9lDUkdFt_A	98109	t	02	53	63000	65	01
82	3099	01	rDwyWxjW6uiw8pBLaEzi0Uk6Opz8oLdql1IhA0pLZMg	htRJ9Eq-j-qlj8ah6j74_g	MetQfzFcHJkd9lDUkdFt_A	98109	t	02	53	63000	65	01
83	3100	01	_3QTWX32OmRMFXMgse5otg	xrElz-4Rgm68zWZ69iA8Epbi3fqtM2pmri-Va7OxHYk	AitUbSYrAyu_D6tIQCqh7w	11001	t	01	D01	01	01	01
84	3101	01	_3QTWX32OmRMFXMgse5otg	xrElz-4Rgm68zWZ69iA8Epbi3fqtM2pmri-Va7OxHYk	AitUbSYrAyu_D6tIQCqh7w	11001	t	01	D01	01	01	01
85	3102	01	_3QTWX32OmRMFXMgse5otg	xrElz-4Rgm68zWZ69iA8Epbi3fqtM2pmri-Va7OxHYk	AitUbSYrAyu_D6tIQCqh7w	11001	t	01	D01	01	01	01
86	3103	01	_3QTWX32OmRMFXMgse5otg	xrElz-4Rgm68zWZ69iA8Epbi3fqtM2pmri-Va7OxHYk	AitUbSYrAyu_D6tIQCqh7w	11001	t	01	D01	01	01	01
87	3105	01	Jk3KwIkxfR4gfQxdsxAxTLrN3kUr1IQnqwoGSTA_V64	EZXZ6eKe2XfhPkvCWN_Esii13Wml6OTzQSJfnRS0E1I	AitUbSYrAyu_D6tIQCqh7w	11001	t	01	01	01	02	01
88	3106	01	Jk3KwIkxfR4gfQxdsxAxTLrN3kUr1IQnqwoGSTA_V64	EZXZ6eKe2XfhPkvCWN_Esii13Wml6OTzQSJfnRS0E1I	AitUbSYrAyu_D6tIQCqh7w	11001	t	01	01	01	02	01
89	3107	01	Jk3KwIkxfR4gfQxdsxAxTLrN3kUr1IQnqwoGSTA_V64	EZXZ6eKe2XfhPkvCWN_Esii13Wml6OTzQSJfnRS0E1I	AitUbSYrAyu_D6tIQCqh7w	11001	t	01	01	01	02	01
90	3108	01	Jk3KwIkxfR4gfQxdsxAxTLrN3kUr1IQnqwoGSTA_V64	EZXZ6eKe2XfhPkvCWN_Esii13Wml6OTzQSJfnRS0E1I	AitUbSYrAyu_D6tIQCqh7w	11001	t	01	D01	11	84	01
91	3109	01	Jk3KwIkxfR4gfQxdsxAxTLrN3kUr1IQnqwoGSTA_V64	EZXZ6eKe2XfhPkvCWN_Esii13Wml6OTzQSJfnRS0E1I	AitUbSYrAyu_D6tIQCqh7w	11001	t	01	01	01	02	01
92	3110	01	rDwyWxjW6uiw8pBLaEzi0Uk6Opz8oLdql1IhA0pLZMg	htRJ9Eq-j-qlj8ah6j74_g	MetQfzFcHJkd9lDUkdFt_A	98109	t	03	53	63000	65	01
94	3113	01	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	123456	t	Test	Test	Test	01	Test
95	3113	01	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	12234	t	01	01	01	Test	Test
96	3114	01	RIn1VJC08iIWNfcp4wPiRg	RIn1VJC08iIWNfcp4wPiRg	a5pLx0OH_SUGZoK15Kdocw	123456	t	Test	Test	Test	01	Test
97	3114	01	RIn1VJC08iIWNfcp4wPiRg	RIn1VJC08iIWNfcp4wPiRg	a5pLx0OH_SUGZoK15Kdocw	12234	t	01	01	01	Test	Test
98	3115	01	c3uV4j5M_nwfjIY6F9dcUg	c3uV4j5M_nwfjIY6F9dcUg	a5pLx0OH_SUGZoK15Kdocw	123456	t	Test	Test	Test	01	Test
99	3115	01	c3uV4j5M_nwfjIY6F9dcUg	c3uV4j5M_nwfjIY6F9dcUg	a5pLx0OH_SUGZoK15Kdocw	12234	t	01	01	01	Test	Test
100	3116	01	oxbtITKJAUCWZ_V2mWqBSg	oxbtITKJAUCWZ_V2mWqBSg	a5pLx0OH_SUGZoK15Kdocw	123456	t	Test	Test	Test	01	Test
101	3116	01	oxbtITKJAUCWZ_V2mWqBSg	oxbtITKJAUCWZ_V2mWqBSg	a5pLx0OH_SUGZoK15Kdocw	12234	t	01	01	01	Test	Test
102	3117	01	oxbtITKJAUCWZ_V2mWqBSg	oxbtITKJAUCWZ_V2mWqBSg	a5pLx0OH_SUGZoK15Kdocw	123456	t	Test	Test	Test	01	Test
103	3117	01	oxbtITKJAUCWZ_V2mWqBSg	oxbtITKJAUCWZ_V2mWqBSg	a5pLx0OH_SUGZoK15Kdocw	12234	t	01	01	01	Test	Test
104	3118	01	dBB4R7eDF5vU0t5GnG5BMQ	dBB4R7eDF5vU0t5GnG5BMQ	a5pLx0OH_SUGZoK15Kdocw	123456	t	Test	Test	Test	01	Test
105	3118	01	dBB4R7eDF5vU0t5GnG5BMQ	dBB4R7eDF5vU0t5GnG5BMQ	a5pLx0OH_SUGZoK15Kdocw	12234	t	01	01	01	Test	Test
106	3119	01	dBB4R7eDF5vU0t5GnG5BMQ	dBB4R7eDF5vU0t5GnG5BMQ	a5pLx0OH_SUGZoK15Kdocw	123456	t	Test	Test	Test	01	Test
107	3119	01	dBB4R7eDF5vU0t5GnG5BMQ	dBB4R7eDF5vU0t5GnG5BMQ	a5pLx0OH_SUGZoK15Kdocw	12234	t	01	01	01	Test	Test
139	3152	01	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	123456	t	Test	Test	Test	01	Test
140	3152	01	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	12234	t	01	01	01	Test	Test
141	3153	01	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	123456	t	Test	Test	Test	01	Test
142	3153	01	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	12234	t	01	01	01	Test	Test
143	3154	01	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	123456	t	Test	Test	Test	01	Test
144	3154	01	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	12234	t	01	01	01	Test	Test
145	3155	01	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	123456	t	Test	Test	Test	01	Test
146	3155	01	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	12234	t	01	01	01	Test	Test
150	3157	01	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	12234	t	01	01	01	Test	Test
151	3158	01	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	123456	t	Test	Test	Test	01	Test
152	3158	01	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	12234	t	01	01	01	Test	Test
153	3159	01	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	123456	t	Test	Test	Test	01	Test
154	3159	01	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	12234	t	01	01	01	Test	Test
155	3160	01	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	123456	t	Test	Test	Test	01	Test
156	3160	01	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	12234	t	01	01	01	Test	Test
157	3161	01	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	123456	t	Test	Test	Test	01	Test
158	3161	01	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	12234	t	01	01	01	Test	Test
159	3162	01	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	123456	t	Test	Test	Test	01	Test
160	3162	01	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	12234	t	01	01	01	Test	Test
161	3163	01	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	123456	t	Test	Test	Test	01	Test
162	3163	01	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	12234	t	01	01	01	Test	Test
163	3164	01	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	123456	t	Test	Test	Test	01	Test
164	3164	01	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	12234	t	01	01	01	Test	Test
165	3165	01	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	123456	t	Test	Test	Test	01	Test
166	3165	01	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	12234	t	01	01	01	Test	Test
167	3166	01	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	123456	t	Test	Test	Test	01	Test
168	3166	01	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	12234	t	01	01	01	Test	Test
169	3167	01	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	123456	t	Test	Test	Test	01	Test
170	3167	01	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	12234	t	01	01	01	Test	Test
171	3168	01	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	123456	t	Test	Test	Test	01	Test
172	3168	01	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	12234	t	01	01	01	Test	Test
173	3169	01	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	123456	t	Test	Test	Test	01	Test
174	3169	01	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	12234	t	01	01	01	Test	Test
175	3170	01	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	123456	t	Test	Test	Test	01	Test
176	3170	01	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	12234	t	01	01	01	Test	Test
177	3171	01	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	123456	t	Test	Test	Test	01	Test
178	3171	01	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	12234	t	01	01	01	Test	Test
179	3172	01	HowzJzpdTqi5EhJMTv-wIw	HowzJzpdTqi5EhJMTv-wIw	a5pLx0OH_SUGZoK15Kdocw	123456	t	Test	Test	Test	01	Test
180	3172	01	HowzJzpdTqi5EhJMTv-wIw	HowzJzpdTqi5EhJMTv-wIw	a5pLx0OH_SUGZoK15Kdocw	12234	t	01	01	01	Test	Test
181	3173	01	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	123456	t	Test	Test	Test	01	Test
182	3173	01	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	12234	t	01	01	01	Test	Test
183	3174	01	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	123456	t	Test	Test	Test	01	Test
184	3174	01	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	12234	t	01	01	01	Test	Test
185	3175	01	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	123456	t	Test	Test	Test	01	Test
186	3175	01	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	12234	t	01	01	01	Test	Test
187	3176	01	3-xosQ4de6DbnEnaqrLNODp4K8xxWsy2bHHKpeD0gNg	3-xosQ4de6DbnEnaqrLNODp4K8xxWsy2bHHKpeD0gNg	a5pLx0OH_SUGZoK15Kdocw	123456	t	Test	Test	Test	01	Test
188	3176	01	3-xosQ4de6DbnEnaqrLNODp4K8xxWsy2bHHKpeD0gNg	3-xosQ4de6DbnEnaqrLNODp4K8xxWsy2bHHKpeD0gNg	a5pLx0OH_SUGZoK15Kdocw	12234	t	01	01	01	Test	Test
189	3177	01	3-xosQ4de6DbnEnaqrLNOGcoyyhJuVvZnw0f7CLHfmg	3-xosQ4de6DbnEnaqrLNOGcoyyhJuVvZnw0f7CLHfmg	a5pLx0OH_SUGZoK15Kdocw	123456	t	Test	Test	Test	01	Test
190	3177	01	3-xosQ4de6DbnEnaqrLNOGcoyyhJuVvZnw0f7CLHfmg	3-xosQ4de6DbnEnaqrLNOGcoyyhJuVvZnw0f7CLHfmg	a5pLx0OH_SUGZoK15Kdocw	12234	t	01	01	01	Test	Test
191	3178	01	PNIDoLgxteYNNhKCrtFGOjp4K8xxWsy2bHHKpeD0gNg	PNIDoLgxteYNNhKCrtFGOjp4K8xxWsy2bHHKpeD0gNg	a5pLx0OH_SUGZoK15Kdocw	123456	t	Test	Test	Test	01	Test
192	3178	01	PNIDoLgxteYNNhKCrtFGOjp4K8xxWsy2bHHKpeD0gNg	PNIDoLgxteYNNhKCrtFGOjp4K8xxWsy2bHHKpeD0gNg	a5pLx0OH_SUGZoK15Kdocw	12234	t	01	01	01	Test	Test
193	3179	01	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	123456	t	Test	Test	Test	01	Test
194	3179	01	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	12234	t	01	01	01	Test	Test
195	3180	01	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	123456	t	Test	Test	Test	01	Test
196	3180	01	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	12234	t	01	01	01	Test	Test
197	3181	01	PNIDoLgxteYNNhKCrtFGOjp4K8xxWsy2bHHKpeD0gNg	PNIDoLgxteYNNhKCrtFGOjp4K8xxWsy2bHHKpeD0gNg	a5pLx0OH_SUGZoK15Kdocw	123456	t	Test	Test	Test	01	Test
198	3181	01	PNIDoLgxteYNNhKCrtFGOjp4K8xxWsy2bHHKpeD0gNg	PNIDoLgxteYNNhKCrtFGOjp4K8xxWsy2bHHKpeD0gNg	a5pLx0OH_SUGZoK15Kdocw	12234	t	01	01	01	Test	Test
199	3182	01	Kj3YfFpIuZqAjHArZfKSD2coyyhJuVvZnw0f7CLHfmg	Kj3YfFpIuZqAjHArZfKSD2coyyhJuVvZnw0f7CLHfmg	a5pLx0OH_SUGZoK15Kdocw	123456	t	Test	Test	Test	01	Test
200	3182	01	Kj3YfFpIuZqAjHArZfKSD2coyyhJuVvZnw0f7CLHfmg	Kj3YfFpIuZqAjHArZfKSD2coyyhJuVvZnw0f7CLHfmg	a5pLx0OH_SUGZoK15Kdocw	12234	t	01	01	01	Test	Test
201	3183	01	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	123456	t	Test	Test	Test	01	Test
202	3183	01	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	12234	t	01	01	01	Test	Test
203	3184	01	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	123456	t	Test	Test	Test	01	Test
204	3184	01	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	12234	t	01	01	01	Test	Test
205	3185	01	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	123456	t	Test	Test	Test	01	Test
206	3185	01	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	12234	t	01	01	01	Test	Test
207	3186	01	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	123456	t	Test	Test	Test	01	Test
208	3186	01	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	12234	t	01	01	01	Test	Test
209	3187	01	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	123456	t	Test	Test	Test	01	Test
210	3187	01	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	12234	t	01	01	01	Test	Test
211	3188	01	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	123456	t	Test	Test	Test	01	Test
212	3188	01	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	12234	t	01	01	01	Test	Test
213	3189	01	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	123456	t	Test	Test	Test	01	Test
214	3189	01	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	12234	t	01	01	01	Test	Test
216	3190	01	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	12234	t	01	01	01	Test	Test
217	3191	01	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	123456	t	Test	Test	Test	01	Test
218	3191	01	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	12234	t	01	01	01	Test	Test
219	3192	01	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	123456	t	Test	Test	Test	01	Test
220	3192	01	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	12234	t	01	01	01	Test	Test
221	3193	01	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	123456	t	Test	Test	Test	01	Test
222	3193	01	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	12234	t	01	01	01	Test	Test
223	3194	01	Kj3YfFpIuZqAjHArZfKSD2coyyhJuVvZnw0f7CLHfmg	Kj3YfFpIuZqAjHArZfKSD2coyyhJuVvZnw0f7CLHfmg	a5pLx0OH_SUGZoK15Kdocw	123456	t	Test	Test	Test	01	Test
224	3194	01	Kj3YfFpIuZqAjHArZfKSD2coyyhJuVvZnw0f7CLHfmg	Kj3YfFpIuZqAjHArZfKSD2coyyhJuVvZnw0f7CLHfmg	a5pLx0OH_SUGZoK15Kdocw	12234	t	01	01	01	Test	Test
225	3195	01	mcuS-WnRSbmyAod_EY1y_iomfinTnKFFHPuD4s8a2oc	mcuS-WnRSbmyAod_EY1y_iomfinTnKFFHPuD4s8a2oc	a5pLx0OH_SUGZoK15Kdocw	123456	t	Test	Test	Test	01	Test
226	3195	01	mcuS-WnRSbmyAod_EY1y_iomfinTnKFFHPuD4s8a2oc	mcuS-WnRSbmyAod_EY1y_iomfinTnKFFHPuD4s8a2oc	a5pLx0OH_SUGZoK15Kdocw	12234	t	01	01	01	Test	Test
227	3196	01	PEF9HoSi7Ep3HOKXuUduqWFwRdVxfySlokTplODj7Oo	PEF9HoSi7Ep3HOKXuUduqWFwRdVxfySlokTplODj7Oo	a5pLx0OH_SUGZoK15Kdocw	123456	t	Test	Test	Test	01	Test
228	3196	01	PEF9HoSi7Ep3HOKXuUduqWFwRdVxfySlokTplODj7Oo	PEF9HoSi7Ep3HOKXuUduqWFwRdVxfySlokTplODj7Oo	a5pLx0OH_SUGZoK15Kdocw	12234	t	01	01	01	Test	Test
229	3197	01	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	123456	t	Test	Test	Test	01	Test
230	3197	01	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	12234	t	01	01	01	Test	Test
231	3198	01	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	123456	t	Test	Test	Test	01	Test
232	3198	01	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	12234	t	01	01	01	Test	Test
233	3199	01	Kj3YfFpIuZqAjHArZfKSD2coyyhJuVvZnw0f7CLHfmg	Kj3YfFpIuZqAjHArZfKSD2coyyhJuVvZnw0f7CLHfmg	a5pLx0OH_SUGZoK15Kdocw	123456	t	Test	Test	Test	01	Test
234	3199	01	Kj3YfFpIuZqAjHArZfKSD2coyyhJuVvZnw0f7CLHfmg	Kj3YfFpIuZqAjHArZfKSD2coyyhJuVvZnw0f7CLHfmg	a5pLx0OH_SUGZoK15Kdocw	12234	t	01	01	01	Test	Test
235	3200	01	KJydAeTKmt7tGvZmEwAkaA	KJydAeTKmt7tGvZmEwAkaA	a5pLx0OH_SUGZoK15Kdocw	123456	t	Test	Test	Test	01	Test
236	3200	01	KJydAeTKmt7tGvZmEwAkaA	KJydAeTKmt7tGvZmEwAkaA	a5pLx0OH_SUGZoK15Kdocw	12234	t	01	01	01	Test	Test
237	3201	01	oxbtITKJAUCWZ_V2mWqBSg	oxbtITKJAUCWZ_V2mWqBSg	a5pLx0OH_SUGZoK15Kdocw	123456	t	Test	Test	Test	01	Test
238	3201	01	oxbtITKJAUCWZ_V2mWqBSg	oxbtITKJAUCWZ_V2mWqBSg	a5pLx0OH_SUGZoK15Kdocw	12234	t	01	01	01	Test	Test
239	3202	01	KJydAeTKmt7tGvZmEwAkaA	KJydAeTKmt7tGvZmEwAkaA	a5pLx0OH_SUGZoK15Kdocw	123456	t	Test	Test	Test	01	Test
240	3202	01	KJydAeTKmt7tGvZmEwAkaA	KJydAeTKmt7tGvZmEwAkaA	a5pLx0OH_SUGZoK15Kdocw	12234	t	01	01	01	Test	Test
241	3203	01	oxbtITKJAUCWZ_V2mWqBSg	oxbtITKJAUCWZ_V2mWqBSg	a5pLx0OH_SUGZoK15Kdocw	123456	t	Test	Test	Test	01	Test
242	3203	01	oxbtITKJAUCWZ_V2mWqBSg	oxbtITKJAUCWZ_V2mWqBSg	a5pLx0OH_SUGZoK15Kdocw	12234	t	01	01	01	Test	Test
243	3204	01	oxbtITKJAUCWZ_V2mWqBSg	oxbtITKJAUCWZ_V2mWqBSg	a5pLx0OH_SUGZoK15Kdocw	123456	t	Test	Test	Test	01	Test
244	3204	01	oxbtITKJAUCWZ_V2mWqBSg	oxbtITKJAUCWZ_V2mWqBSg	a5pLx0OH_SUGZoK15Kdocw	12234	t	01	01	01	Test	Test
245	3205	01	bZ5BNzlRLWjbZzZxQnlFDw	bZ5BNzlRLWjbZzZxQnlFDw	a5pLx0OH_SUGZoK15Kdocw	123456	t	Test	Test	Test	01	Test
246	3205	01	bZ5BNzlRLWjbZzZxQnlFDw	bZ5BNzlRLWjbZzZxQnlFDw	a5pLx0OH_SUGZoK15Kdocw	12234	t	01	01	01	Test	Test
247	3206	01	Kj3YfFpIuZqAjHArZfKSD2coyyhJuVvZnw0f7CLHfmg	Kj3YfFpIuZqAjHArZfKSD2coyyhJuVvZnw0f7CLHfmg	a5pLx0OH_SUGZoK15Kdocw	123456	t	Test	Test	Test	01	Test
248	3206	01	Kj3YfFpIuZqAjHArZfKSD2coyyhJuVvZnw0f7CLHfmg	Kj3YfFpIuZqAjHArZfKSD2coyyhJuVvZnw0f7CLHfmg	a5pLx0OH_SUGZoK15Kdocw	12234	t	01	01	01	Test	Test
249	3207	01	vH0GPA6pUDv7U-u_dPPrbw	vH0GPA6pUDv7U-u_dPPrbw	a5pLx0OH_SUGZoK15Kdocw	123456	t	Test	Test	Test	01	Test
250	3207	01	vH0GPA6pUDv7U-u_dPPrbw	vH0GPA6pUDv7U-u_dPPrbw	a5pLx0OH_SUGZoK15Kdocw	12234	t	01	01	01	Test	Test
251	3208	01	Kj3YfFpIuZqAjHArZfKSD2coyyhJuVvZnw0f7CLHfmg	Kj3YfFpIuZqAjHArZfKSD2coyyhJuVvZnw0f7CLHfmg	a5pLx0OH_SUGZoK15Kdocw	123456	t	Test	Test	Test	01	Test
252	3208	01	Kj3YfFpIuZqAjHArZfKSD2coyyhJuVvZnw0f7CLHfmg	Kj3YfFpIuZqAjHArZfKSD2coyyhJuVvZnw0f7CLHfmg	a5pLx0OH_SUGZoK15Kdocw	12234	t	01	01	01	Test	Test
253	3209	01	tVpwS01wmwCtc6Fqgrtdlg	tVpwS01wmwCtc6Fqgrtdlg	a5pLx0OH_SUGZoK15Kdocw	123456	t	Test	Test	Test	01	Test
254	3209	01	tVpwS01wmwCtc6Fqgrtdlg	tVpwS01wmwCtc6Fqgrtdlg	a5pLx0OH_SUGZoK15Kdocw	12234	t	01	01	01	Test	Test
255	3210	01	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	123456	t	Test	Test	Test	01	Test
256	3210	01	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	12234	t	01	01	01	Test	Test
257	3216	01	HowzJzpdTqi5EhJMTv-wIw	HowzJzpdTqi5EhJMTv-wIw	a5pLx0OH_SUGZoK15Kdocw	123456	t	Test	Test	Test	01	Test
258	3216	01	HowzJzpdTqi5EhJMTv-wIw	HowzJzpdTqi5EhJMTv-wIw	a5pLx0OH_SUGZoK15Kdocw	12234	t	01	01	01	Test	Test
259	3217	01	HowzJzpdTqi5EhJMTv-wIw	HowzJzpdTqi5EhJMTv-wIw	a5pLx0OH_SUGZoK15Kdocw	123456	t	Test	Test	Test	01	Test
260	3217	01	HowzJzpdTqi5EhJMTv-wIw	HowzJzpdTqi5EhJMTv-wIw	a5pLx0OH_SUGZoK15Kdocw	12234	t	01	01	01	Test	Test
261	3218	01	mnq1sl_eZaT_A81tn6QJEw	mnq1sl_eZaT_A81tn6QJEw	a5pLx0OH_SUGZoK15Kdocw	123456	t	Test	Test	Test	01	Test
262	3218	01	mnq1sl_eZaT_A81tn6QJEw	mnq1sl_eZaT_A81tn6QJEw	a5pLx0OH_SUGZoK15Kdocw	12234	t	01	01	01	Test	Test
263	3220	01	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	123456	t	Test	Test	Test	01	Test
264	3220	01	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	12234	t	01	01	01	Test	Test
265	3222	01	3NErslCztznZuAX9yWECnA	3NErslCztznZuAX9yWECnA	a5pLx0OH_SUGZoK15Kdocw	123456	t	Test	Test	Test	01	Test
266	3222	01	3NErslCztznZuAX9yWECnA	3NErslCztznZuAX9yWECnA	a5pLx0OH_SUGZoK15Kdocw	12234	t	01	01	01	Test	Test
267	3223	01	NEplGaCpeG4ob10mqatLMw	NEplGaCpeG4ob10mqatLMw	a5pLx0OH_SUGZoK15Kdocw	123456	t	Test	Test	Test	01	Test
268	3223	01	NEplGaCpeG4ob10mqatLMw	NEplGaCpeG4ob10mqatLMw	a5pLx0OH_SUGZoK15Kdocw	12234	t	01	01	01	Test	Test
269	3224	01	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	123456	t	Test	Test	Test	01	Test
270	3224	01	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	a5pLx0OH_SUGZoK15Kdocw	12234	t	01	01	01	Test	Test
271	3225	01	3NErslCztznZuAX9yWECnA	3NErslCztznZuAX9yWECnA	a5pLx0OH_SUGZoK15Kdocw	123456	t	Test	Test	Test	01	Test
272	3225	01	3NErslCztznZuAX9yWECnA	3NErslCztznZuAX9yWECnA	a5pLx0OH_SUGZoK15Kdocw	12234	t	01	01	01	Test	Test
273	3226	01	E1rFr2Bx4vpDFh-73Pm8kA	E1rFr2Bx4vpDFh-73Pm8kA	a5pLx0OH_SUGZoK15Kdocw	123456	t	Test	Test	Test	01	Test
274	3226	01	E1rFr2Bx4vpDFh-73Pm8kA	E1rFr2Bx4vpDFh-73Pm8kA	a5pLx0OH_SUGZoK15Kdocw	12234	t	01	01	01	Test	Test
275	3227	01	dpbxuPi5V6CTxMxO4nxWtQ	dpbxuPi5V6CTxMxO4nxWtQ	a5pLx0OH_SUGZoK15Kdocw	123456	t	Test	Test	Test	01	Test
276	3227	01	dpbxuPi5V6CTxMxO4nxWtQ	dpbxuPi5V6CTxMxO4nxWtQ	a5pLx0OH_SUGZoK15Kdocw	12234	t	01	01	01	Test	Test
277	3228	01	f_hWkpFihygkM8RLdYR3NQ	f_hWkpFihygkM8RLdYR3NQ	a5pLx0OH_SUGZoK15Kdocw	123456	t	Test	Test	Test	01	Test
278	3228	01	f_hWkpFihygkM8RLdYR3NQ	f_hWkpFihygkM8RLdYR3NQ	a5pLx0OH_SUGZoK15Kdocw	12234	t	01	01	01	Test	Test
279	3229	01	HowzJzpdTqi5EhJMTv-wIw	HowzJzpdTqi5EhJMTv-wIw	a5pLx0OH_SUGZoK15Kdocw	123456	t	Test	Test	Test	01	Test
280	3229	01	HowzJzpdTqi5EhJMTv-wIw	HowzJzpdTqi5EhJMTv-wIw	a5pLx0OH_SUGZoK15Kdocw	12234	t	01	01	01	Test	Test
281	3230	01	O_k-EWLmwjQqaU-S2-huJw	O_k-EWLmwjQqaU-S2-huJw	a5pLx0OH_SUGZoK15Kdocw	123456	t	Test	Test	Test	01	Test
282	3230	01	O_k-EWLmwjQqaU-S2-huJw	O_k-EWLmwjQqaU-S2-huJw	a5pLx0OH_SUGZoK15Kdocw	12234	t	01	01	01	Test	Test
283	3231	01	HowzJzpdTqi5EhJMTv-wIw	HowzJzpdTqi5EhJMTv-wIw	a5pLx0OH_SUGZoK15Kdocw	123456	t	Test	Test	Test	01	Test
284	3231	01	HowzJzpdTqi5EhJMTv-wIw	HowzJzpdTqi5EhJMTv-wIw	a5pLx0OH_SUGZoK15Kdocw	12234	t	01	01	01	Test	Test
285	3232	01	CcAsLJM3K9boTPFanzOjlYcdxtOwoUxxl-5taUxQTbU	CcAsLJM3K9boTPFanzOjlYcdxtOwoUxxl-5taUxQTbU	a5pLx0OH_SUGZoK15Kdocw	123456	t	Test	Test	Test	01	Test
286	3232	01	CcAsLJM3K9boTPFanzOjlYcdxtOwoUxxl-5taUxQTbU	CcAsLJM3K9boTPFanzOjlYcdxtOwoUxxl-5taUxQTbU	a5pLx0OH_SUGZoK15Kdocw	12234	t	01	01	01	Test	Test
287	3233	01	lpc0xFsM_MWfxJi6qSk26Q	lpc0xFsM_MWfxJi6qSk26Q	a5pLx0OH_SUGZoK15Kdocw	123456	t	Test	Test	Test	01	Test
288	3233	01	lpc0xFsM_MWfxJi6qSk26Q	lpc0xFsM_MWfxJi6qSk26Q	a5pLx0OH_SUGZoK15Kdocw	12234	t	01	01	01	Test	Test
289	3234	01	SfgyVYTWKQLIMP03QRa2qQ	SfgyVYTWKQLIMP03QRa2qQ	a5pLx0OH_SUGZoK15Kdocw	123456	t	Test	Test	Test	01	Test
290	3234	01	SfgyVYTWKQLIMP03QRa2qQ	SfgyVYTWKQLIMP03QRa2qQ	a5pLx0OH_SUGZoK15Kdocw	12234	t	01	01	01	Test	Test
291	3235	01	R0_KTB2sN_PZnpKLLH368A	R0_KTB2sN_PZnpKLLH368A	a5pLx0OH_SUGZoK15Kdocw	123456	t	Test	Test	Test	01	Test
292	3235	01	R0_KTB2sN_PZnpKLLH368A	R0_KTB2sN_PZnpKLLH368A	a5pLx0OH_SUGZoK15Kdocw	12234	t	01	01	01	Test	Test
293	3236	01	M0IbCMOO299HO8u5gWFlPA	M0IbCMOO299HO8u5gWFlPA	a5pLx0OH_SUGZoK15Kdocw	123456	t	Test	Test	Test	01	Test
294	3236	01	M0IbCMOO299HO8u5gWFlPA	M0IbCMOO299HO8u5gWFlPA	a5pLx0OH_SUGZoK15Kdocw	12234	t	01	01	01	Test	Test
295	3237	01	lpc0xFsM_MWfxJi6qSk26Q	lpc0xFsM_MWfxJi6qSk26Q	a5pLx0OH_SUGZoK15Kdocw	123456	t	Test	Test	Test	01	Test
296	3237	01	lpc0xFsM_MWfxJi6qSk26Q	lpc0xFsM_MWfxJi6qSk26Q	a5pLx0OH_SUGZoK15Kdocw	12234	t	01	01	01	Test	Test
297	3238	01	HowzJzpdTqi5EhJMTv-wIw	HowzJzpdTqi5EhJMTv-wIw	a5pLx0OH_SUGZoK15Kdocw	123456	t	Test	Test	Test	01	Test
298	3238	01	HowzJzpdTqi5EhJMTv-wIw	HowzJzpdTqi5EhJMTv-wIw	a5pLx0OH_SUGZoK15Kdocw	12234	t	01	01	01	Test	Test
299	3239	01	3NErslCztznZuAX9yWECnA	3NErslCztznZuAX9yWECnA	a5pLx0OH_SUGZoK15Kdocw	123456	t	Test	Test	Test	01	Test
300	3239	01	3NErslCztznZuAX9yWECnA	3NErslCztznZuAX9yWECnA	a5pLx0OH_SUGZoK15Kdocw	12234	t	01	01	01	Test	Test
301	3240	01	HowzJzpdTqi5EhJMTv-wIw	HowzJzpdTqi5EhJMTv-wIw	a5pLx0OH_SUGZoK15Kdocw	123456	t	Test	Test	Test	01	Test
302	3240	01	HowzJzpdTqi5EhJMTv-wIw	HowzJzpdTqi5EhJMTv-wIw	a5pLx0OH_SUGZoK15Kdocw	12234	t	01	01	01	Test	Test
303	3241	01	HowzJzpdTqi5EhJMTv-wIw	HowzJzpdTqi5EhJMTv-wIw	a5pLx0OH_SUGZoK15Kdocw	123456	t	Test	Test	Test	01	Test
304	3241	01	HowzJzpdTqi5EhJMTv-wIw	HowzJzpdTqi5EhJMTv-wIw	a5pLx0OH_SUGZoK15Kdocw	12234	t	01	01	01	Test	Test
305	3242	01	lpc0xFsM_MWfxJi6qSk26Q	lpc0xFsM_MWfxJi6qSk26Q	a5pLx0OH_SUGZoK15Kdocw	123456	t	Test	Test	Test	01	Test
306	3242	01	lpc0xFsM_MWfxJi6qSk26Q	lpc0xFsM_MWfxJi6qSk26Q	a5pLx0OH_SUGZoK15Kdocw	12234	t	01	01	01	Test	Test
307	3243	01	xpA3KqtPu_dIbI3SSVYMlplBhoXA4i66BjGMHeE-0h0	xpA3KqtPu_dIbI3SSVYMlplBhoXA4i66BjGMHeE-0h0	a5pLx0OH_SUGZoK15Kdocw	123456	t	Test	Test	Test	01	Test
308	3243	01	xpA3KqtPu_dIbI3SSVYMlplBhoXA4i66BjGMHeE-0h0	xpA3KqtPu_dIbI3SSVYMlplBhoXA4i66BjGMHeE-0h0	a5pLx0OH_SUGZoK15Kdocw	12234	t	01	01	01	Test	Test
309	3244	01	xpA3KqtPu_dIbI3SSVYMlplBhoXA4i66BjGMHeE-0h0	xpA3KqtPu_dIbI3SSVYMlplBhoXA4i66BjGMHeE-0h0	a5pLx0OH_SUGZoK15Kdocw	123456	t	Test	Test	Test	01	Test
310	3244	01	xpA3KqtPu_dIbI3SSVYMlplBhoXA4i66BjGMHeE-0h0	xpA3KqtPu_dIbI3SSVYMlplBhoXA4i66BjGMHeE-0h0	a5pLx0OH_SUGZoK15Kdocw	12234	t	01	01	01	Test	Test
311	3245	01	HowzJzpdTqi5EhJMTv-wIw	HowzJzpdTqi5EhJMTv-wIw	a5pLx0OH_SUGZoK15Kdocw	123456	t	Test	Test	Test	01	Test
312	3245	01	HowzJzpdTqi5EhJMTv-wIw	HowzJzpdTqi5EhJMTv-wIw	a5pLx0OH_SUGZoK15Kdocw	12234	t	01	01	01	Test	Test
313	3246	01	HowzJzpdTqi5EhJMTv-wIw	HowzJzpdTqi5EhJMTv-wIw	a5pLx0OH_SUGZoK15Kdocw	123456	t	Test	Test	Test	01	Test
314	3246	01	HowzJzpdTqi5EhJMTv-wIw	HowzJzpdTqi5EhJMTv-wIw	a5pLx0OH_SUGZoK15Kdocw	12234	t	01	01	01	Test	Test
315	3247	01	HowzJzpdTqi5EhJMTv-wIw	HowzJzpdTqi5EhJMTv-wIw	a5pLx0OH_SUGZoK15Kdocw	123456	t	Test	Test	Test	01	Test
316	3247	01	HowzJzpdTqi5EhJMTv-wIw	HowzJzpdTqi5EhJMTv-wIw	a5pLx0OH_SUGZoK15Kdocw	12234	t	01	01	01	Test	Test
317	3248	01	HowzJzpdTqi5EhJMTv-wIw	HowzJzpdTqi5EhJMTv-wIw	a5pLx0OH_SUGZoK15Kdocw	123456	t	Test	Test	Test	01	Test
318	3248	01	HowzJzpdTqi5EhJMTv-wIw	HowzJzpdTqi5EhJMTv-wIw	a5pLx0OH_SUGZoK15Kdocw	12234	t	01	01	01	Test	Test
319	3249	01	1QOBzJTGD2TrAWXNGpnMPg	1QOBzJTGD2TrAWXNGpnMPg	a5pLx0OH_SUGZoK15Kdocw	123456	t	Test	Test	Test	01	Test
320	3249	01	1QOBzJTGD2TrAWXNGpnMPg	1QOBzJTGD2TrAWXNGpnMPg	a5pLx0OH_SUGZoK15Kdocw	12234	t	01	01	01	Test	Test
321	3250	01	udL2cjUT2Wmg2jyNf_CiDw	udL2cjUT2Wmg2jyNf_CiDw	a5pLx0OH_SUGZoK15Kdocw	123456	t	Test	Test	Test	01	Test
322	3250	01	udL2cjUT2Wmg2jyNf_CiDw	udL2cjUT2Wmg2jyNf_CiDw	a5pLx0OH_SUGZoK15Kdocw	12234	t	01	01	01	Test	Test
323	3251	01	f_hWkpFihygkM8RLdYR3NQ	f_hWkpFihygkM8RLdYR3NQ	a5pLx0OH_SUGZoK15Kdocw	123456	t	Test	Test	Test	01	Test
324	3251	01	f_hWkpFihygkM8RLdYR3NQ	f_hWkpFihygkM8RLdYR3NQ	a5pLx0OH_SUGZoK15Kdocw	12234	t	01	01	01	Test	Test
325	3252	01	HowzJzpdTqi5EhJMTv-wIw	HowzJzpdTqi5EhJMTv-wIw	a5pLx0OH_SUGZoK15Kdocw	123456	t	Test	Test	Test	01	Test
326	3252	01	HowzJzpdTqi5EhJMTv-wIw	HowzJzpdTqi5EhJMTv-wIw	a5pLx0OH_SUGZoK15Kdocw	12234	t	01	01	01	Test	Test
327	3253	01	Z_QJUMNlcdh99Yii6r6qfXBaKoUMl_ZmB0WsMZ5Y4gk	Z_QJUMNlcdh99Yii6r6qfXBaKoUMl_ZmB0WsMZ5Y4gk	a5pLx0OH_SUGZoK15Kdocw	123456	t	Test	Test	Test	01	Test
328	3253	01	Z_QJUMNlcdh99Yii6r6qfXBaKoUMl_ZmB0WsMZ5Y4gk	Z_QJUMNlcdh99Yii6r6qfXBaKoUMl_ZmB0WsMZ5Y4gk	a5pLx0OH_SUGZoK15Kdocw	12234	t	01	01	01	Test	Test
329	3254	01	6hRUvVJRUPuxHYKG_TeK-g	6hRUvVJRUPuxHYKG_TeK-g	a5pLx0OH_SUGZoK15Kdocw	123456	t	Test	Test	Test	01	Test
330	3254	01	6hRUvVJRUPuxHYKG_TeK-g	6hRUvVJRUPuxHYKG_TeK-g	a5pLx0OH_SUGZoK15Kdocw	12234	t	01	01	01	Test	Test
331	3255	01	R0_KTB2sN_PZnpKLLH368A	R0_KTB2sN_PZnpKLLH368A	a5pLx0OH_SUGZoK15Kdocw	123456	t	Test	Test	Test	01	Test
332	3255	01	R0_KTB2sN_PZnpKLLH368A	R0_KTB2sN_PZnpKLLH368A	a5pLx0OH_SUGZoK15Kdocw	12234	t	01	01	01	Test	Test
333	3256	01	gAmKNT4MCKMfk5Lgm4HfQY9SFMzvYGKa8VXwB3JcE44	gAmKNT4MCKMfk5Lgm4HfQY9SFMzvYGKa8VXwB3JcE44	a5pLx0OH_SUGZoK15Kdocw	123456	t	Test	Test	Test	01	Test
334	3256	01	gAmKNT4MCKMfk5Lgm4HfQY9SFMzvYGKa8VXwB3JcE44	gAmKNT4MCKMfk5Lgm4HfQY9SFMzvYGKa8VXwB3JcE44	a5pLx0OH_SUGZoK15Kdocw	12234	t	01	01	01	Test	Test
335	3257	01	gAmKNT4MCKMfk5Lgm4HfQY9SFMzvYGKa8VXwB3JcE44	gAmKNT4MCKMfk5Lgm4HfQY9SFMzvYGKa8VXwB3JcE44	a5pLx0OH_SUGZoK15Kdocw	123456	t	Test	Test	Test	01	Test
336	3257	01	gAmKNT4MCKMfk5Lgm4HfQY9SFMzvYGKa8VXwB3JcE44	gAmKNT4MCKMfk5Lgm4HfQY9SFMzvYGKa8VXwB3JcE44	a5pLx0OH_SUGZoK15Kdocw	12234	t	01	01	01	Test	Test
337	3259	01	Karur 	Karur 	Test	123456	t	Test	Test	Test	01	Test
338	3259	01	Karur 	Karur 	Test	12234	t	01	01	01	Test	Test
339	3260	01	4567	4567	Test	123456	t	Test	Test	Test	01	Test
340	3260	01	4567	4567	Test	12234	t	01	01	01	Test	Test
341	3261	01	4567	4567	Test	123456	t	Test	Test	Test	01	Test
342	3261	01	4567	4567	Test	12234	t	01	01	01	Test	Test
353	3268	01	Flat no-101 Palace Orchard Society Near Betos restaurant off NIBM Kondhwa Pune 	Flat no-101 Palace Orchard Society Near Betos restaurant off NIBM Kondhwa Pune 	Test	46064	t	Test	Test	Pune 	India 	Test
354	3268	01	Flat no-101 Palace Orchard Society Near Betos restaurant off NIBM Kondhwa Pune 	Flat no-101 Palace Orchard Society Near Betos restaurant off NIBM Kondhwa Pune 	Test	46064	t	01	01	Pune 	India 	Test
355	3269	01	Ghjj	Ghjj	Test	123456	t	Test	Test	Bhilai 	India	Test
356	3269	01	Ghjj	Ghjj	Test	123456	t	01	01	Bhilai 	India	Test
357	3271	01	Palace Orchard society legend 2 building flat no 102 Near Betos hotel off NIBM Kondhwa Undir road Pune Maharashtra 	Palace Orchard society legend 2 building flat no 102 Near Betos hotel off NIBM Kondhwa Undir road Pune Maharashtra 	Test	411060	t	Test	Test	Pune	India 	Test
358	3271	01	Palace Orchard society legend 2 building flat no 102 Near Betos hotel off NIBM Kondhwa Undir road Pune Maharashtra 	Palace Orchard society legend 2 building flat no 102 Near Betos hotel off NIBM Kondhwa Undir road Pune Maharashtra 	Test	411060	t	01	01	Pune	India 	Test
359	3272	01	Palace Orchard Society legend-5 flat no 202 near Betos hotel off NIBM Kondhwa undri Pune Maharashtra 	Palace Orchard Society legend-5 flat no 202 near Betos hotel off NIBM Kondhwa undri Pune Maharashtra 	Test	411060	t	Test	Test	Pune 	India 	Test
360	3272	01	Palace Orchard Society legend-5 flat no 202 near Betos hotel off NIBM Kondhwa undri Pune Maharashtra 	Palace Orchard Society legend-5 flat no 202 near Betos hotel off NIBM Kondhwa undri Pune Maharashtra 	Test	411060	t	01	01	Pune 	India 	Test
215	3190	01	14/12 Ky Dong Street	Ward 3, District 17	HCMC	11001	t	01	D01	11	84	01
361	3273	01	1264 Dale Avenuem	Hanoi	Vietnam	98109	t	01	53	63000	03	01
\.


--
-- Data for Name: party_asset; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.party_asset (party_asset_id, party_id, asset_type_code, asset_name, potential_value, is_mortgaged) FROM stdin;
43	3043	01	house	99999999	t
44	3045	01	house	99999999	t
45	3046	01	house	99999999	t
46	3047	01	house	99999999	t
47	3048	01	house	99999999	t
48	3049	01	house	99999999	t
49	3050	01	house	99999999	t
50	3052	01	house	99999999	t
51	3056	01	house	99999999	t
52	3057	01	house	99999999	t
53	3058	01	house	99999999	t
54	3059	01	house	99999999	t
55	3060	01	house	99999999	t
56	3061	01	house	99999999	t
57	3062	01	house	99999999	t
58	3076	01	house	99999999	t
59	3077	01	house	99999999	t
60	3078	01	house	99999999	t
61	3094	01	house	99999999	t
62	3095	01	house	99999999	t
63	3100	01	house	99999999	t
64	3101	01	house	99999999	t
65	3102	01	house	99999999	t
66	3103	01	house	99999999	t
67	3105	01	house	99999999	t
68	3106	01	house	99999999	t
69	3107	01	house	99999999	t
70	3108	01	house	99999999	t
71	3109	01	house	99999999	t
72	3113	01	Test	1234567	t
73	3114	01	Test	1234567	t
74	3115	01	Test	1234567	t
75	3116	01	Test	1234567	t
76	3117	01	Test	1234567	t
77	3118	01	Test	1234567	t
78	3119	01	Test	1234567	t
111	3152	01	Test	1234567	t
112	3153	01	Test	1234567	t
113	3154	01	Test	1234567	t
114	3155	01	Test	1234567	t
115	3156	01	Test	1234567	t
116	3157	01	Test	1234567	t
117	3158	01	Test	1234567	t
118	3159	01	Test	1234567	t
119	3160	01	Test	1234567	t
120	3161	01	Test	1234567	t
121	3162	01	Test	1234567	t
122	3163	01	Test	1234567	t
123	3164	01	Test	1234567	t
124	3165	01	Test	1234567	t
125	3166	01	Test	1234567	t
126	3167	01	Test	1234567	t
127	3168	01	Test	1234567	t
128	3169	01	Test	1234567	t
129	3170	01	Test	1234567	t
130	3171	01	Test	1234567	t
131	3172	01	Test	1234567	t
132	3173	01	Test	1234567	t
133	3174	01	Test	1234567	t
134	3175	01	Test	1234567	t
135	3176	01	Test	1234567	t
136	3177	01	Test	1234567	t
137	3178	01	Test	1234567	t
138	3179	01	Test	1234567	t
139	3180	01	Test	1234567	t
140	3181	01	Test	1234567	t
141	3182	01	Test	1234567	t
142	3183	01	Test	1234567	t
143	3184	01	Test	1234567	t
144	3185	01	Test	1234567	t
145	3186	01	Test	1234567	t
146	3187	01	Test	1234567	t
147	3188	01	Test	1234567	t
148	3189	01	Test	1234567	t
149	3190	01	Test	1234567	t
150	3191	01	Test	1234567	t
151	3192	01	Test	1234567	t
152	3193	01	Test	1234567	t
153	3194	01	Test	1234567	t
154	3195	01	Test	1234567	t
155	3196	01	Test	1234567	t
156	3197	01	Test	1234567	t
157	3198	01	Test	1234567	t
158	3199	01	Test	1234567	t
159	3200	01	Test	1234567	t
160	3201	01	Test	1234567	t
161	3202	01	Test	1234567	t
162	3203	01	Test	1234567	t
163	3204	01	Test	1234567	t
164	3205	01	Test	1234567	t
165	3206	01	Test	1234567	t
166	3207	01	Test	1234567	t
167	3208	01	Test	1234567	t
168	3209	01	Test	1234567	t
169	3210	01	Test	1234567	t
170	3216	01	Test	1234567	t
171	3217	01	Test	1234567	t
172	3218	01	Test	1234567	t
173	3220	01	Test	1234567	t
174	3222	01	Test	1234567	t
175	3223	01	Test	1234567	t
176	3224	01	Test	1234567	t
177	3225	01	Test	1234567	t
178	3226	01	Test	1234567	t
179	3227	01	Test	1234567	t
180	3228	01	Test	1234567	t
181	3229	01	Test	1234567	t
182	3230	01	Test	1234567	t
183	3231	01	Test	1234567	t
184	3232	01	Test	1234567	t
185	3233	01	Test	1234567	t
186	3234	01	Test	1234567	t
187	3235	01	Test	1234567	t
188	3236	01	Test	1234567	t
189	3237	01	Test	1234567	t
190	3238	01	Test	1234567	t
191	3239	01	Test	1234567	t
192	3240	01	Test	1234567	t
193	3241	01	Test	1234567	t
194	3242	01	Test	1234567	t
195	3243	01	Test	1234567	t
200	3248	01	Test	1234567	t
196	3244	01	Test	1234567	t
197	3245	01	Test	1234567	t
198	3246	01	Test	1234567	t
199	3247	01	Test	1234567	t
201	3249	01	Test	1234567	t
202	3250	01	Test	1234567	t
203	3251	01	Test	1234567	t
204	3252	01	Test	1234567	t
205	3253	01	Test	1234567	t
206	3254	01	Test	1234567	t
207	3255	01	Test	1234567	t
208	3256	01	Test	1234567	t
209	3257	01	Test	1234567	t
210	3259	01	Test	1234567	t
211	3260	01	Test	1234567	t
212	3261	01	Test	1234567	t
218	3268	01	Test	1234567	t
219	3269	01	Test	1234567	t
220	3271	01	Test	1234567	t
221	3272	01	Test	1234567	t
\.


--
-- Data for Name: party_contact_details; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.party_contact_details (party_contact_details_id, party_id, contact_type_code, contact_value, isd_code, is_primary, is_verified, verified_mode, last_verified_date, is_dnd) FROM stdin;
11	3010	01	PbvqTg65XuBvfgsqkZ6TBQ	65	t	t	Call Centre	2022-02-28 00:00:00	f
26	3025	01	nO32EmTIdl2tgC3A08ah0A	84	t	t	verified	1982-08-30 00:00:00	t
23	3022	01	P--BjylSyeYD33NjU1MwfQ	84	t	t	verified	1982-08-30 00:00:00	t
10	3009	01	w1A1YNyXqh26NszXWwW5Gg	65	t	t	Call Centre	2022-01-31 00:00:00	f
24	3023	01	P--BjylSyeYD33NjU1MwfQ	84	t	t	verified	1982-08-30 00:00:00	t
15	3014	03	pbVhTmB4COePlf4_qEGamNuRm6YMT8ShfwdWOp45Gk4	65	f	f		\N	f
17	3016	01	yon_01egrN30wYsliltkOw	65	t	f		\N	f
6	3005	01	cGSQieJDJ_NLimGXIV9aVw	65	t	t	Call Centre	2022-08-01 00:00:00	f
12	3011	02	DnILZXFdgu3wBtuxnhHjUpWzTF--G-heb3FUfW0ypO4	65	t	t	Email	2022-04-01 00:00:00	f
19	3018	01	3iNspfvTDVUaR6X6qSuX8A	65	t	f		\N	f
8	3007	01	50pD5J3nAC3WoVUhux2WTA	65	t	t	Call Centre	2022-07-18 00:00:00	f
20	3019	02	l0skuwc8zdkrEn3smjg2y0WH_XLQ4Y4rldNTR2xQ97s	65	t	t	Email	2022-06-01 00:00:00	f
5	3004	02	-SUVa8S2UB45rzunMGrnMEWH_XLQ4Y4rldNTR2xQ97s	65	t	t	Email	2022-06-15 00:00:00	f
13	3012	01	FywtQsrmOt6rxkSZxHgFzw	65	t	t	Call Centre	2022-04-28 00:00:00	f
14	3013	01	l04ADqlj_BYxHrZI6NErDg	65	t	t	Call Centre	2022-08-11 00:00:00	f
4	3003	01	CMXhr8Fc_NvssdBVv-SzlA	65	t	t	Call Centre	2022-08-20 00:00:00	f
9	3008	01	CCd30pKB226tDcm-FRw1sA	65	t	t	Call Centre	2022-06-13 00:00:00	f
21	3020	01	Cke7m6sSdxrnek0RUoHSZg	65	t	t	Call Centre	2022-01-01 00:00:00	f
22	3021	01	RxtdxfXXRMZZjfq3MRty-Q	65	t	t	Call Centre	2022-08-15 00:00:00	f
16	3015	02	HIvIeOk_9jnZnEToKVqj9d0qmPuuXg6mutUEfxDn9S0	65	t	f		\N	f
18	3017	03	dZlBNux2I_LAF4mitT6EwQ	65	t	f		\N	f
7	3006	01	b1KVoucesKYj5wmku-9aLw	65	t	t	Call Centre	2022-02-15 00:00:00	f
25	3024	01	nO32EmTIdl2tgC3A08ah0A	84	t	t	verified	1982-08-30 00:00:00	t
27	3026	01	P--BjylSyeYD33NjU1MwfQ	84	t	t	verified	1982-08-30 00:00:00	t
44	3043	01	P--BjylSyeYD33NjU1MwfQ	84	t	t	verified	1982-08-30 00:00:00	t
45	3045	01	P--BjylSyeYD33NjU1MwfQ	84	t	t	verified	1982-08-30 00:00:00	t
46	3046	01	P--BjylSyeYD33NjU1MwfQ	84	t	t	verified	1982-08-30 00:00:00	t
47	3047	01	P--BjylSyeYD33NjU1MwfQ	84	t	t	verified	1982-08-30 00:00:00	t
48	3048	01	P--BjylSyeYD33NjU1MwfQ	84	t	t	verified	1982-08-30 00:00:00	t
30	3028	01	QpTgERnmNXoECxFCQaDF4Q	65	t	t	Call Centre	2022-08-22 00:00:00	f
49	3049	01	nO32EmTIdl2tgC3A08ah0A	84	t	t	verified	1982-08-30 00:00:00	t
50	3050	01	nO32EmTIdl2tgC3A08ah0A	84	t	t	verified	1982-08-30 00:00:00	t
51	3052	01	QpTgERnmNXoECxFCQaDF4Q	65	t	t	Call Centre	2022-08-22 00:00:00	f
52	3053	01	meOj2-aDiPV_r02Kh4lSCg	65	t	t	Call Centre	2022-08-20 00:00:00	f
53	3054	02	etlecskqLYulUWvMGHPNvmhUt-hcvDw8tH8EjGFSMDk	65	t	t	Email	2022-06-15 00:00:00	f
54	3055	01	PCIhm8rULD_cji4_s_vOOA	65	t	t	Call Centre	2022-08-01 00:00:00	f
55	3056	01	P--BjylSyeYD33NjU1MwfQ	84	t	t	verified	1982-08-30 00:00:00	t
56	3057	01	P--BjylSyeYD33NjU1MwfQ	84	t	t	verified	1982-08-30 00:00:00	t
57	3058	01	nO32EmTIdl2tgC3A08ah0A	84	t	t	verified	1982-08-30 00:00:00	t
58	3059	01	nO32EmTIdl2tgC3A08ah0A	84	t	t	verified	1982-08-30 00:00:00	t
59	3060	01	nO32EmTIdl2tgC3A08ah0A	84	t	t	verified	1982-08-30 00:00:00	t
60	3061	01	nO32EmTIdl2tgC3A08ah0A	84	t	t	verified	1982-08-30 00:00:00	t
61	3062	01	nO32EmTIdl2tgC3A08ah0A	84	t	t	verified	1982-08-30 00:00:00	t
62	3063	01	ij_V0N2IXk60CliSZEG8DA	65	t	t	Call Centre	2022-07-20 00:00:00	f
63	3064	02	fLN-AcgxK9UZpF_FqxR7Id0qmPuuXg6mutUEfxDn9S0	65	t	t	Email	2022-06-25 00:00:00	f
64	3065	01	36zteh9Iunfg_kuh0JGzQw	65	t	t	Call Centre	2022-08-09 00:00:00	f
65	3066	01	ya8SrmmV7WhPSE2vpDCbvw	65	f	f		\N	f
66	3067	01	DBW78RD34XOnBDqaAwi18A	65	t	t	Call Centre	2022-08-29 00:00:00	f
67	3068	01	k3TTnNP38a-1OFNxYq8XRA	65	t	t	Call Centre	2022-08-09 00:00:00	f
68	3069	01	9VJ2ofuOe2v9gx4Coql8eQ	65	t	t	Call Centre	2022-08-09 00:00:00	f
69	3070	01	Zczu5dluRQVtaw5O2nKcuw	65	t	t	Call Centre	2022-07-24 00:00:00	f
70	3071	02	wTkEbkBdX8wcmuN5NcPF6DyN7jlk3d4Z17CfbR_SZIk	65	t	t	Email	2022-06-29 00:00:00	f
71	3072	01	UitN0Dc4a_NPw6-7TVnjgA	65	t	t	Call Centre	2022-02-09 00:00:00	f
72	3073	01	JyVFM6puAUPPGhB1F-zegg	65	t	t	Call Centre	2022-11-29 00:00:00	f
73	3074	01	anFGDa-9ZczqVKk7YId4Fg	65	f	f		\N	f
74	3076	01	P--BjylSyeYD33NjU1MwfQ	84	t	t	verified	1982-08-30 00:00:00	t
75	3077	01	P--BjylSyeYD33NjU1MwfQ	84	t	t	verified	1982-08-30 00:00:00	t
76	3078	01	P--BjylSyeYD33NjU1MwfQ	84	t	t	verified	1982-08-30 00:00:00	t
77	3094	01	nO32EmTIdl2tgC3A08ah0A	84	t	t	verified	1982-08-30 00:00:00	t
78	3095	01	nO32EmTIdl2tgC3A08ah0A	84	t	t	verified	1982-08-30 00:00:00	t
79	3096	01	TIy-A3HhUhg9a5U3jQN0HQ	65	f	t	Call Center	2022-11-29 00:00:00	f
80	3097	01	Zczu5dluRQVtaw5O2nKcuw	65	t	t	Call Centre	2022-07-24 00:00:00	f
81	3098	01	TIy-A3HhUhg9a5U3jQN0HQ	65	f	t	Call Center	2022-11-29 00:00:00	f
82	3099	01	TIy-A3HhUhg9a5U3jQN0HQ	65	f	t	Call Center	2022-11-29 00:00:00	f
83	3100	01	nO32EmTIdl2tgC3A08ah0A	84	t	t	verified	1982-08-30 00:00:00	t
84	3101	01	nO32EmTIdl2tgC3A08ah0A	84	t	t	verified	1982-08-30 00:00:00	t
85	3102	01	nO32EmTIdl2tgC3A08ah0A	84	t	t	verified	1982-08-30 00:00:00	t
86	3103	01	nO32EmTIdl2tgC3A08ah0A	84	t	t	verified	1982-08-30 00:00:00	t
87	3105	01	P--BjylSyeYD33NjU1MwfQ	84	t	t	verified	1982-08-30 00:00:00	t
88	3106	01	P--BjylSyeYD33NjU1MwfQ	84	t	t	verified	1982-08-30 00:00:00	t
89	3107	01	P--BjylSyeYD33NjU1MwfQ	84	t	t	verified	1982-08-30 00:00:00	t
90	3108	01	P--BjylSyeYD33NjU1MwfQ	84	t	t	verified	1982-08-30 00:00:00	t
91	3109	01	P--BjylSyeYD33NjU1MwfQ	84	t	t	verified	1982-08-30 00:00:00	t
92	3110	01	TIy-A3HhUhg9a5U3jQN0HQ	01	f	t	Call Center	2022-11-29 00:00:00	f
93	3113	01	2kpjYHAU0OQKgyE_Toa7SQ	84	t	t	Test	1982-08-30 00:00:00	t
94	3114	01	2kpjYHAU0OQKgyE_Toa7SQ	84	t	t	Test	1982-08-30 00:00:00	t
95	3115	01	2kpjYHAU0OQKgyE_Toa7SQ	84	t	t	Test	1982-08-30 00:00:00	t
96	3116	01	2kpjYHAU0OQKgyE_Toa7SQ	84	t	t	Test	1982-08-30 00:00:00	t
97	3117	01	2kpjYHAU0OQKgyE_Toa7SQ	84	t	t	Test	1982-08-30 00:00:00	t
98	3118	01	5jDvNBhMCzkkOq_du-txeg	84	t	t	Test	1982-08-30 00:00:00	t
99	3119	01	5jDvNBhMCzkkOq_du-txeg	84	t	t	Test	1982-08-30 00:00:00	t
132	3152	01	2kpjYHAU0OQKgyE_Toa7SQ	84	t	t	Test	1982-08-30 00:00:00	t
133	3153	01	2kpjYHAU0OQKgyE_Toa7SQ	84	t	t	Test	1982-08-30 00:00:00	t
134	3154	01	2kpjYHAU0OQKgyE_Toa7SQ	84	t	t	Test	1982-08-30 00:00:00	t
135	3155	01	2kpjYHAU0OQKgyE_Toa7SQ	84	t	t	Test	1982-08-30 00:00:00	t
136	3156	01	2kpjYHAU0OQKgyE_Toa7SQ	84	t	t	Test	1982-08-30 00:00:00	t
137	3157	01	2kpjYHAU0OQKgyE_Toa7SQ	84	t	t	Test	1982-08-30 00:00:00	t
138	3158	01	2kpjYHAU0OQKgyE_Toa7SQ	84	t	t	Test	1982-08-30 00:00:00	t
139	3159	01	2kpjYHAU0OQKgyE_Toa7SQ	84	t	t	Test	1982-08-30 00:00:00	t
140	3160	01	2kpjYHAU0OQKgyE_Toa7SQ	84	t	t	Test	1982-08-30 00:00:00	t
141	3161	01	2kpjYHAU0OQKgyE_Toa7SQ	84	t	t	Test	1982-08-30 00:00:00	t
142	3162	01	2kpjYHAU0OQKgyE_Toa7SQ	84	t	t	Test	1982-08-30 00:00:00	t
143	3163	01	2kpjYHAU0OQKgyE_Toa7SQ	84	t	t	Test	1982-08-30 00:00:00	t
144	3164	01	2kpjYHAU0OQKgyE_Toa7SQ	84	t	t	Test	1982-08-30 00:00:00	t
145	3165	01	2kpjYHAU0OQKgyE_Toa7SQ	84	t	t	Test	1982-08-30 00:00:00	t
146	3166	01	2kpjYHAU0OQKgyE_Toa7SQ	84	t	t	Test	1982-08-30 00:00:00	t
147	3167	01	2kpjYHAU0OQKgyE_Toa7SQ	84	t	t	Test	1982-08-30 00:00:00	t
148	3168	01	2kpjYHAU0OQKgyE_Toa7SQ	84	t	t	Test	1982-08-30 00:00:00	t
149	3169	01	2kpjYHAU0OQKgyE_Toa7SQ	84	t	t	Test	1982-08-30 00:00:00	t
150	3170	01	2kpjYHAU0OQKgyE_Toa7SQ	84	t	t	Test	1982-08-30 00:00:00	t
151	3171	01	2kpjYHAU0OQKgyE_Toa7SQ	84	t	t	Test	1982-08-30 00:00:00	t
152	3172	01	-G5MF5GkOS_nByiPdsNTXA	84	t	t	Test	1982-08-30 00:00:00	t
153	3173	01	2kpjYHAU0OQKgyE_Toa7SQ	84	t	t	Test	1982-08-30 00:00:00	t
154	3174	01	2kpjYHAU0OQKgyE_Toa7SQ	84	t	t	Test	1982-08-30 00:00:00	t
155	3175	01	2kpjYHAU0OQKgyE_Toa7SQ	84	t	t	Test	1982-08-30 00:00:00	t
156	3176	01	AJP2iSaaGTS27EIJKU3YHw	84	t	t	Test	1982-08-30 00:00:00	t
157	3177	01	AJP2iSaaGTS27EIJKU3YHw	84	t	t	Test	1982-08-30 00:00:00	t
158	3178	01	PgTRV5wLSFO-22yyj8sW0A	84	t	t	Test	1982-08-30 00:00:00	t
159	3179	01	2kpjYHAU0OQKgyE_Toa7SQ	84	t	t	Test	1982-08-30 00:00:00	t
160	3180	01	2kpjYHAU0OQKgyE_Toa7SQ	84	t	t	Test	1982-08-30 00:00:00	t
161	3181	01	PgTRV5wLSFO-22yyj8sW0A	84	t	t	Test	1982-08-30 00:00:00	t
162	3182	01	AJP2iSaaGTS27EIJKU3YHw	84	t	t	Test	1982-08-30 00:00:00	t
163	3183	01	2kpjYHAU0OQKgyE_Toa7SQ	84	t	t	Test	1982-08-30 00:00:00	t
164	3184	01	2kpjYHAU0OQKgyE_Toa7SQ	84	t	t	Test	1982-08-30 00:00:00	t
165	3185	01	2kpjYHAU0OQKgyE_Toa7SQ	84	t	t	Test	1982-08-30 00:00:00	t
166	3186	01	2kpjYHAU0OQKgyE_Toa7SQ	84	t	t	Test	1982-08-30 00:00:00	t
167	3187	01	2kpjYHAU0OQKgyE_Toa7SQ	84	t	t	Test	1982-08-30 00:00:00	t
168	3188	01	2kpjYHAU0OQKgyE_Toa7SQ	84	t	t	Test	1982-08-30 00:00:00	t
169	3189	01	2kpjYHAU0OQKgyE_Toa7SQ	84	t	t	Test	1982-08-30 00:00:00	t
170	3190	01	2kpjYHAU0OQKgyE_Toa7SQ	84	t	t	Test	1982-08-30 00:00:00	t
171	3191	01	2kpjYHAU0OQKgyE_Toa7SQ	84	t	t	Test	1982-08-30 00:00:00	t
172	3192	01	2kpjYHAU0OQKgyE_Toa7SQ	84	t	t	Test	1982-08-30 00:00:00	t
173	3193	01	2kpjYHAU0OQKgyE_Toa7SQ	84	t	t	Test	1982-08-30 00:00:00	t
174	3194	01	AJP2iSaaGTS27EIJKU3YHw	84	t	t	Test	1982-08-30 00:00:00	t
175	3195	01	AJP2iSaaGTS27EIJKU3YHw	84	t	t	Test	1982-08-30 00:00:00	t
176	3196	01	AJP2iSaaGTS27EIJKU3YHw	84	t	t	Test	1982-08-30 00:00:00	t
177	3197	01	2kpjYHAU0OQKgyE_Toa7SQ	84	t	t	Test	1982-08-30 00:00:00	t
178	3198	01	2kpjYHAU0OQKgyE_Toa7SQ	84	t	t	Test	1982-08-30 00:00:00	t
179	3199	01	AJP2iSaaGTS27EIJKU3YHw	84	t	t	Test	1982-08-30 00:00:00	t
180	3200	01	PgTRV5wLSFO-22yyj8sW0A	84	t	t	Test	1982-08-30 00:00:00	t
181	3201	01	PgTRV5wLSFO-22yyj8sW0A	84	t	t	Test	1982-08-30 00:00:00	t
182	3202	01	PgTRV5wLSFO-22yyj8sW0A	84	t	t	Test	1982-08-30 00:00:00	t
183	3203	01	PgTRV5wLSFO-22yyj8sW0A	84	t	t	Test	1982-08-30 00:00:00	t
184	3204	01	PgTRV5wLSFO-22yyj8sW0A	84	t	t	Test	1982-08-30 00:00:00	t
185	3205	01	D70VrrbOX8U0ZS7PU9hR5A	84	t	t	Test	1982-08-30 00:00:00	t
186	3206	01	AJP2iSaaGTS27EIJKU3YHw	84	t	t	Test	1982-08-30 00:00:00	t
187	3207	01	AJP2iSaaGTS27EIJKU3YHw	84	t	t	Test	1982-08-30 00:00:00	t
188	3208	01	AJP2iSaaGTS27EIJKU3YHw	84	t	t	Test	1982-08-30 00:00:00	t
189	3209	01	PgTRV5wLSFO-22yyj8sW0A	84	t	t	Test	1982-08-30 00:00:00	t
190	3210	01	PgTRV5wLSFO-22yyj8sW0A	84	t	t	Test	1982-08-30 00:00:00	t
191	3216	01	PgTRV5wLSFO-22yyj8sW0A	84	t	t	Test	1982-08-30 00:00:00	t
192	3217	01	PgTRV5wLSFO-22yyj8sW0A	84	t	t	Test	1982-08-30 00:00:00	t
193	3218	01	PgTRV5wLSFO-22yyj8sW0A	84	t	t	Test	1982-08-30 00:00:00	t
194	3220	01	ZKPKBsaeUXTAtPuchEx9BQ	84	t	t	Test	1982-08-30 00:00:00	t
195	3222	01	AJP2iSaaGTS27EIJKU3YHw	84	t	t	Test	1982-08-30 00:00:00	t
196	3223	01	ZKPKBsaeUXTAtPuchEx9BQ	84	t	t	Test	1982-08-30 00:00:00	t
197	3224	01	2kpjYHAU0OQKgyE_Toa7SQ	84	t	t	Test	1982-08-30 00:00:00	t
198	3225	01	AJP2iSaaGTS27EIJKU3YHw	84	t	t	Test	1982-08-30 00:00:00	t
199	3226	01	ZKPKBsaeUXTAtPuchEx9BQ	84	t	t	Test	1982-08-30 00:00:00	t
200	3227	01	ZKPKBsaeUXTAtPuchEx9BQ	84	t	t	Test	1982-08-30 00:00:00	t
201	3228	01	ZKPKBsaeUXTAtPuchEx9BQ	84	t	t	Test	1982-08-30 00:00:00	t
202	3229	01	AJP2iSaaGTS27EIJKU3YHw	84	t	t	Test	1982-08-30 00:00:00	t
203	3230	01	AJP2iSaaGTS27EIJKU3YHw	84	t	t	Test	1982-08-30 00:00:00	t
204	3231	01	ZKPKBsaeUXTAtPuchEx9BQ	84	t	t	Test	1982-08-30 00:00:00	t
205	3232	01	ZKPKBsaeUXTAtPuchEx9BQ	84	t	t	Test	1982-08-30 00:00:00	t
206	3233	01	6-T0Abvfz2lKvqPjPeIxTA	84	t	t	Test	1982-08-30 00:00:00	t
207	3234	01	ZKPKBsaeUXTAtPuchEx9BQ	84	t	t	Test	1982-08-30 00:00:00	t
208	3235	01	ZKPKBsaeUXTAtPuchEx9BQ	84	t	t	Test	1982-08-30 00:00:00	t
209	3236	01	ZKPKBsaeUXTAtPuchEx9BQ	84	t	t	Test	1982-08-30 00:00:00	t
210	3237	01	ZKPKBsaeUXTAtPuchEx9BQ	84	t	t	Test	1982-08-30 00:00:00	t
211	3238	01	ZKPKBsaeUXTAtPuchEx9BQ	84	t	t	Test	1982-08-30 00:00:00	t
212	3239	01	AJP2iSaaGTS27EIJKU3YHw	84	t	t	Test	1982-08-30 00:00:00	t
213	3240	01	AJP2iSaaGTS27EIJKU3YHw	84	t	t	Test	1982-08-30 00:00:00	t
214	3241	01	AJP2iSaaGTS27EIJKU3YHw	84	t	t	Test	1982-08-30 00:00:00	t
215	3242	01	AJP2iSaaGTS27EIJKU3YHw	84	t	t	Test	1982-08-30 00:00:00	t
216	3243	01	ZKPKBsaeUXTAtPuchEx9BQ	84	t	t	Test	1982-08-30 00:00:00	t
217	3244	01	ZKPKBsaeUXTAtPuchEx9BQ	84	t	t	Test	1982-08-30 00:00:00	t
218	3245	01	AJP2iSaaGTS27EIJKU3YHw	84	t	t	Test	1982-08-30 00:00:00	t
219	3246	01	AJP2iSaaGTS27EIJKU3YHw	84	t	t	Test	1982-08-30 00:00:00	t
220	3247	01	AJP2iSaaGTS27EIJKU3YHw	84	t	t	Test	1982-08-30 00:00:00	t
221	3248	01	AJP2iSaaGTS27EIJKU3YHw	84	t	t	Test	1982-08-30 00:00:00	t
222	3249	01	AJP2iSaaGTS27EIJKU3YHw	84	t	t	Test	1982-08-30 00:00:00	t
223	3250	01	AJP2iSaaGTS27EIJKU3YHw	84	t	t	Test	1982-08-30 00:00:00	t
224	3251	01	ZKPKBsaeUXTAtPuchEx9BQ	84	t	t	Test	1982-08-30 00:00:00	t
225	3252	01	AJP2iSaaGTS27EIJKU3YHw	84	t	t	Test	1982-08-30 00:00:00	t
226	3253	01	AJP2iSaaGTS27EIJKU3YHw	84	t	t	Test	1982-08-30 00:00:00	t
227	3254	01	AJP2iSaaGTS27EIJKU3YHw	84	t	t	Test	1982-08-30 00:00:00	t
228	3255	01	ZKPKBsaeUXTAtPuchEx9BQ	84	t	t	Test	1982-08-30 00:00:00	t
229	3256	01	ZKPKBsaeUXTAtPuchEx9BQ	84	t	t	Test	1982-08-30 00:00:00	t
230	3257	01	ZKPKBsaeUXTAtPuchEx9BQ	84	t	t	Test	1982-08-30 00:00:00	t
231	3259	01	7904049462	84	t	t	Test	1982-08-30 00:00:00	t
232	3260	01	9750770047	84	t	t	Test	1982-08-30 00:00:00	t
233	3261	01	9750770047	84	t	t	Test	1982-08-30 00:00:00	t
239	3268	01	9028119498	84	t	t	Test	1982-08-30 00:00:00	t
240	3269	01	7904049462	84	t	t	Test	1982-08-30 00:00:00	t
241	3271	01	9028119498	84	t	t	Test	1982-08-30 00:00:00	t
242	3272	01	9028119498	84	t	t	Test	1982-08-30 00:00:00	t
243	3273	01	4254290198	01	f	t	Call Center	2022-11-29 00:00:00	f
\.


--
-- Data for Name: party_document; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.party_document (party_document_id, party_id, document_type_code, document_number, document_number_masked, document_number_token, issuing_date, expiry_date, issuing_place, issuing_country_code, is_poi, is_poa, dms_reference_id, verification_status, additional_data) FROM stdin;
4	3003	01	G3327819D	01	NA	2020-01-01 00:00:00	2029-12-31 00:00:00	Singapore	02	t	t	01	Approved	Y
5	3004	01	T8485003M	01	NA	2022-01-31 00:00:00	1932-01-30 00:00:00	Singapore	02	t	t	01	Approved	Y
6	3005	01	S5993761H	01	NA	2019-08-15 00:00:00	2029-08-14 00:00:00	Singapore	02	t	t	01	Approved	Y
7	3006	01	S7985991E	01	NA	2017-10-19 00:00:00	2027-10-18 00:00:00	Singapore	02	t	t	01	Approved	Y
8	3007	01	S4607467Z	01	NA	2018-11-25 00:00:00	2028-11-25 00:00:00	Singapore	02	t	t	01	Approved	Y
9	3008	01	S5133700Z	01	NA	2019-11-30 00:00:00	2029-11-29 00:00:00	Singapore	02	t	t	01	Approved	Y
10	3009	01	S7529822F	01	NA	2019-09-04 00:00:00	2029-09-03 00:00:00	Singapore	02	t	t	01	In Process	Y
11	3010	01	S9993707F	01	NA	2020-04-15 00:00:00	1930-04-14 00:00:00	Singapore	02	t	t	01	Approved	Y
12	3011	01	S7529822F	01	NA	2019-10-17 00:00:00	2029-10-16 00:00:00	Singapore	02	t	t	01	Approved	Y
13	3012	01	S7802072E	01	NA	2014-12-11 00:00:00	2024-12-10 00:00:00	Singapore	02	t	t	01	Approved	Y
14	3013	01	S9322424H	01	NA	2012-10-10 00:00:00	2022-10-09 00:00:00	Singapore	02	t	t	01	In Process	Y
15	3014	01	S0595389H	01	NA	2018-09-17 00:00:00	2028-09-16 00:00:00	Singapore	02	t	t	01	Approved	Y
16	3015	01	S0913102G	01	NA	2015-08-07 00:00:00	2025-08-06 00:00:00	Singapore	02	t	t	01	Approved	Y
17	3016	01	S1318259J	01	NA	2021-02-18 00:00:00	1931-02-17 00:00:00	Singapore	02	t	t	01	Approved	Y
18	3017	01	S2459330D	01	NA	2017-08-29 00:00:00	2027-08-28 00:00:00	Singapore	02	t	t	01	Approved	Y
19	3018	01	S8729102B	01	NA	2022-05-17 00:00:00	1932-05-16 00:00:00	Singapore	02	t	t	01	Approved	Y
20	3019	01	S5371441B	01	NA	2015-03-21 00:00:00	2025-03-20 00:00:00	Singapore	02	t	t	01	Approved	Y
21	3020	01	S6677194F	01	NA	2018-12-30 00:00:00	2028-12-29 00:00:00	Singapore	02	t	t	01	Approved	Y
22	3021	01	S8154065I	01	NA	2013-08-20 00:00:00	2023-08-19 00:00:00	Singapore	02	t	t	01	Approved	Y
23	3022	01	11	01	02	1972-05-14 00:00:00	1979-05-24 00:00:00	Dong Nai	84	t	t	01	verified	Y
24	3023	01	11	01	02	1972-05-14 00:00:00	1979-05-24 00:00:00	Dong Nai	84	t	t	01	verified	Y
25	3024	01	11	01	02	1972-05-14 00:00:00	1979-05-24 00:00:00	Dong Nai	01	t	t	01	verified	Y
26	3025	01	11	01	02	1972-05-14 00:00:00	1979-05-24 00:00:00	Dong Nai	01	t	t	01	verified	Y
27	3026	01	11	01	02	1972-05-14 00:00:00	1979-05-24 00:00:00	Dong Nai	01	t	t	01	verified	Y
66	3067	01	S6018014A	01	NA	2016-06-03 00:00:00	2026-07-02 00:00:00	Singapore	02	t	t	01	Approved	Y
30	3028	01	S9428014A	01	NA	2016-07-03 00:00:00	2026-07-02 00:00:00	Singapore	02	t	t	01	Approved	Y
44	3043	01	11	01	02	1972-05-14 00:00:00	1979-05-24 00:00:00	Dong Nai	01	t	t	01	verified	Y
45	3045	01	11	01	02	1972-05-14 00:00:00	1979-05-24 00:00:00	Dong Nai	01	t	t	01	verified	Y
46	3046	01	11	01	02	1972-05-14 00:00:00	1979-05-24 00:00:00	Dong Nai	01	t	t	01	verified	Y
47	3047	01	11	01	02	1972-05-14 00:00:00	1979-05-24 00:00:00	Dong Nai	01	t	t	01	verified	Y
48	3048	01	11	01	02	1972-05-14 00:00:00	1979-05-24 00:00:00	Dong Nai	01	t	t	01	verified	Y
49	3049	01	11	01	02	1972-05-14 00:00:00	1979-05-24 00:00:00	Dong Nai	01	t	t	01	verified	Y
50	3050	01	11	01	02	1972-05-14 00:00:00	1979-05-24 00:00:00	Dong Nai	01	t	t	01	verified	Y
51	3052	01	S9428014A	01	NA	2016-07-03 00:00:00	2026-07-02 00:00:00	Singapore	02	t	t	01	Approved	Y
52	3053	01	G3327419D	01	NA	2020-01-01 00:00:00	2029-12-31 00:00:00	Singapore	02	t	t	01	Approved	Y
53	3054	01	T8485083M	01	NA	2022-01-31 00:00:00	1932-01-30 00:00:00	Singapore	02	t	t	01	Approved	Y
54	3055	01	S5993761H	01	NA	2019-08-15 00:00:00	2029-08-14 00:00:00	Singapore	02	t	t	01	Approved	Y
55	3056	01	11	01	02	1972-05-14 00:00:00	1979-05-24 00:00:00	Dong Nai	84	t	t	01	verified	Y
56	3057	01	11	01	02	1972-05-14 00:00:00	1979-05-24 00:00:00	Dong Nai	84	t	t	01	verified	Y
57	3058	01	11	01	02	1972-05-14 00:00:00	1979-05-24 00:00:00	Dong Nai	01	t	t	01	verified	Y
58	3059	01	11	01	02	1972-05-14 00:00:00	1979-05-24 00:00:00	Dong Nai	01	t	t	01	verified	Y
59	3060	01	11	01	02	1972-05-14 00:00:00	1979-05-24 00:00:00	Dong Nai	01	t	t	01	verified	Y
60	3061	01	11	01	02	1972-05-14 00:00:00	1979-05-24 00:00:00	Dong Nai	01	t	t	01	verified	Y
61	3062	01	11	01	02	1972-05-14 00:00:00	1979-05-24 00:00:00	Dong Nai	01	t	t	01	verified	Y
62	3063	01	G3847419D	01	NA	2020-02-09 00:00:00	2029-12-31 00:00:00	Singapore	02	t	t	01	Approved	Y
63	3064	01	T9425083M	01	NA	2022-01-23 00:00:00	1932-01-30 00:00:00	Singapore	02	t	t	01	Approved	Y
64	3065	01	S7653761H	01	NA	2019-08-16 00:00:00	2029-08-14 00:00:00	Singapore	02	t	t	01	Approved	Y
65	3066	01	S1825389H	01	NA	2018-09-11 00:00:00	2028-09-16 00:00:00	Singapore	02	t	t	01	Approved	Y
67	3068	01	S7653761H	01	NA	2019-08-16 00:00:00	2029-08-14 00:00:00	Singapore	02	t	t	01	Approved	Y
68	3069	01	S7653761H	01	NA	2019-08-16 00:00:00	2029-08-14 00:00:00	Singapore	02	t	t	01	Approved	Y
69	3070	01	G3887419D	01	NA	2020-02-19 00:00:00	2029-12-30 00:00:00	Singapore	02	t	t	01	Approved	Y
70	3071	01	T9423083M	01	NA	2022-01-16 00:00:00	1932-01-13 00:00:00	Singapore	02	t	t	01	Approved	Y
71	3072	01	S7153761H	01	NA	2019-03-16 00:00:00	2029-07-14 00:00:00	Singapore	02	t	t	01	Approved	Y
72	3073	01	S6918014A	01	NA	2016-09-03 00:00:00	2026-12-02 00:00:00	Singapore	02	t	t	01	Approved	Y
73	3074	01	S1815389H	01	NA	2018-09-12 00:00:00	2028-09-19 00:00:00	Singapore	02	t	t	01	Approved	Y
74	3076	01	11	01	02	1972-05-14 00:00:00	1979-05-24 00:00:00	Dong Nai	84	t	t	01	verified	Y
75	3077	01	11	01	02	1972-05-14 00:00:00	1979-05-24 00:00:00	Dong Nai	84	t	t	01	verified	Y
76	3078	01	11	01	02	1972-05-14 00:00:00	1979-05-24 00:00:00	Dong Nai	84	t	t	01	verified	Y
77	3094	01	11	01	02	1972-05-14 00:00:00	1979-05-24 00:00:00	Dong Nai	01	t	t	01	verified	Y
78	3095	01	11	01	02	1972-05-14 00:00:00	1979-05-24 00:00:00	Dong Nai	01	t	t	01	verified	Y
79	3096	01	NA	01	NA	2018-09-12 00:00:00	2029-07-14 00:00:00	Singapore	02	t	t	01	Approved	Y
80	3097	01	G3887419D	01	NA	2020-02-19 00:00:00	2029-12-30 00:00:00	Singapore	02	t	t	01	Approved	Y
81	3098	01		01	NA	2018-09-12 00:00:00	2029-07-14 00:00:00	Singapore	02	t	t	01	Approved	Y
82	3099	01	31195855	01	NA	2018-09-12 00:00:00	2029-07-14 00:00:00	Singapore	02	t	t	01	Approved	Y
83	3100	01	11	01	02	1972-05-14 00:00:00	1979-05-24 00:00:00	Dong Nai	01	t	t	01	verified	Y
84	3101	01	11	01	02	1972-05-14 00:00:00	1979-05-24 00:00:00	Dong Nai	01	t	t	01	verified	Y
85	3102	01	11	01	02	1972-05-14 00:00:00	1979-05-24 00:00:00	Dong Nai	01	t	t	01	verified	Y
86	3103	01	11	01	02	1972-05-14 00:00:00	1979-05-24 00:00:00	Dong Nai	01	t	t	01	verified	Y
87	3105	01	11	01	02	1972-05-14 00:00:00	1979-05-24 00:00:00	Dong Nai	01	t	t	01	verified	Y
88	3106	01	11	01	02	1972-05-14 00:00:00	1979-05-24 00:00:00	Dong Nai	01	t	t	01	verified	Y
89	3107	01	11	01	02	1972-05-14 00:00:00	1979-05-24 00:00:00	Dong Nai	01	t	t	01	verified	Y
90	3108	01	11	01	02	1972-05-14 00:00:00	1979-05-24 00:00:00	Dong Nai	01	t	t	01	verified	Y
91	3109	01	11	01	02	1972-05-14 00:00:00	1979-05-24 00:00:00	Dong Nai	01	t	t	01	verified	Y
92	3110	01	31195855	01	NA	2018-09-12 00:00:00	2029-07-14 00:00:00	USA	02	t	t	01	Approved	Y
93	3113	01	Test	Test	Test	2020-12-12 00:00:00	2030-12-12 00:00:00	Test	Test	t	t	01	verified	Y
94	3114	01	Test	Test	Test	2020-12-12 00:00:00	2030-12-12 00:00:00	Test	Test	t	t	01	verified	Y
95	3115	01	Test	Test	Test	2020-12-12 00:00:00	2030-12-12 00:00:00	Test	Test	t	t	01	verified	Y
96	3116	01	Test	Test	Test	2020-12-12 00:00:00	2030-12-12 00:00:00	Test	Test	t	t	01	verified	Y
97	3117	01	Test	Test	Test	2020-12-12 00:00:00	2030-12-12 00:00:00	Test	Test	t	t	01	verified	Y
98	3118	01	Test	Test	Test	2020-12-12 00:00:00	2030-12-12 00:00:00	Test	Test	t	t	01	verified	Y
99	3119	01	Test	Test	Test	2020-12-12 00:00:00	2030-12-12 00:00:00	Test	Test	t	t	01	verified	Y
132	3152	01	Test	Test	Test	2020-12-12 00:00:00	2030-12-12 00:00:00	Test	Test	t	t	01	verified	Y
133	3153	01	Test	Test	Test	2020-12-12 00:00:00	2030-12-12 00:00:00	Test	Test	t	t	01	verified	Y
134	3154	01	Test	Test	Test	2020-12-12 00:00:00	2030-12-12 00:00:00	Test	Test	t	t	01	verified	Y
135	3155	01	Test	Test	Test	2020-12-12 00:00:00	2030-12-12 00:00:00	Test	Test	t	t	01	verified	Y
136	3156	01	Test	Test	Test	2020-12-12 00:00:00	2030-12-12 00:00:00	Test	Test	t	t	01	verified	Y
137	3157	01	Test	Test	Test	2020-12-12 00:00:00	2030-12-12 00:00:00	Test	Test	t	t	01	verified	Y
138	3158	01	Test	Test	Test	2020-12-12 00:00:00	2030-12-12 00:00:00	Test	Test	t	t	01	verified	Y
139	3159	01	Test	Test	Test	2020-12-12 00:00:00	2030-12-12 00:00:00	Test	Test	t	t	01	verified	Y
140	3160	01	Test	Test	Test	2020-12-12 00:00:00	2030-12-12 00:00:00	Test	Test	t	t	01	verified	Y
141	3161	01	Test	Test	Test	2020-12-12 00:00:00	2030-12-12 00:00:00	Test	Test	t	t	01	verified	Y
142	3162	01	Test	Test	Test	2020-12-12 00:00:00	2030-12-12 00:00:00	Test	Test	t	t	01	verified	Y
143	3163	01	Test	Test	Test	2020-12-12 00:00:00	2030-12-12 00:00:00	Test	Test	t	t	01	verified	Y
144	3164	01	Test	Test	Test	2020-12-12 00:00:00	2030-12-12 00:00:00	Test	Test	t	t	01	verified	Y
145	3165	01	Test	Test	Test	2020-12-12 00:00:00	2030-12-12 00:00:00	Test	Test	t	t	01	verified	Y
146	3166	01	Test	Test	Test	2020-12-12 00:00:00	2030-12-12 00:00:00	Test	Test	t	t	01	verified	Y
147	3167	01	Test	Test	Test	2020-12-12 00:00:00	2030-12-12 00:00:00	Test	Test	t	t	01	verified	Y
148	3168	01	Test	Test	Test	2020-12-12 00:00:00	2030-12-12 00:00:00	Test	Test	t	t	01	verified	Y
149	3169	01	Test	Test	Test	2020-12-12 00:00:00	2030-12-12 00:00:00	Test	Test	t	t	01	verified	Y
150	3170	01	Test	Test	Test	2020-12-12 00:00:00	2030-12-12 00:00:00	Test	Test	t	t	01	verified	Y
151	3171	01	Test	Test	Test	2020-12-12 00:00:00	2030-12-12 00:00:00	Test	Test	t	t	01	verified	Y
152	3172	01	Test	Test	Test	2020-12-12 00:00:00	2030-12-12 00:00:00	Test	Test	t	t	01	verified	Y
153	3173	01	Test	Test	Test	2020-12-12 00:00:00	2030-12-12 00:00:00	Test	Test	t	t	01	verified	Y
154	3174	01	Test	Test	Test	2020-12-12 00:00:00	2030-12-12 00:00:00	Test	Test	t	t	01	verified	Y
155	3175	01	Test	Test	Test	2020-12-12 00:00:00	2030-12-12 00:00:00	Test	Test	t	t	01	verified	Y
156	3176	01	Test	Test	Test	2020-12-12 00:00:00	2030-12-12 00:00:00	Test	Test	t	t	01	verified	Y
157	3177	01	Test	Test	Test	2020-12-12 00:00:00	2030-12-12 00:00:00	Test	Test	t	t	01	verified	Y
158	3178	01	Test	Test	Test	2020-12-12 00:00:00	2030-12-12 00:00:00	Test	Test	t	t	01	verified	Y
159	3179	01	Test	Test	Test	2020-12-12 00:00:00	2030-12-12 00:00:00	Test	Test	t	t	01	verified	Y
160	3180	01	Test	Test	Test	2020-12-12 00:00:00	2030-12-12 00:00:00	Test	Test	t	t	01	verified	Y
161	3181	01	Test	Test	Test	2020-12-12 00:00:00	2030-12-12 00:00:00	Test	Test	t	t	01	verified	Y
162	3182	01	Test	Test	Test	2020-12-12 00:00:00	2030-12-12 00:00:00	Test	Test	t	t	01	verified	Y
163	3183	01	Test	Test	Test	2020-12-12 00:00:00	2030-12-12 00:00:00	Test	Test	t	t	01	verified	Y
164	3184	01	Test	Test	Test	2020-12-12 00:00:00	2030-12-12 00:00:00	Test	Test	t	t	01	verified	Y
165	3185	01	Test	Test	Test	2020-12-12 00:00:00	2030-12-12 00:00:00	Test	Test	t	t	01	verified	Y
166	3186	01	Test	Test	Test	2020-12-12 00:00:00	2030-12-12 00:00:00	Test	Test	t	t	01	verified	Y
167	3187	01	Test	Test	Test	2020-12-12 00:00:00	2030-12-12 00:00:00	Test	Test	t	t	01	verified	Y
168	3188	01	Test	Test	Test	2020-12-12 00:00:00	2030-12-12 00:00:00	Test	Test	t	t	01	verified	Y
169	3189	01	Test	Test	Test	2020-12-12 00:00:00	2030-12-12 00:00:00	Test	Test	t	t	01	verified	Y
170	3190	01	Test	Test	Test	2020-12-12 00:00:00	2030-12-12 00:00:00	Test	Test	t	t	01	verified	Y
171	3191	01	Test	Test	Test	2020-12-12 00:00:00	2030-12-12 00:00:00	Test	Test	t	t	01	verified	Y
172	3192	01	Test	Test	Test	2020-12-12 00:00:00	2030-12-12 00:00:00	Test	Test	t	t	01	verified	Y
173	3193	01	Test	Test	Test	2020-12-12 00:00:00	2030-12-12 00:00:00	Test	Test	t	t	01	verified	Y
174	3194	01	Test	Test	Test	2020-12-12 00:00:00	2030-12-12 00:00:00	Test	Test	t	t	01	verified	Y
175	3195	01	Test	Test	Test	2020-12-12 00:00:00	2030-12-12 00:00:00	Test	Test	t	t	01	verified	Y
176	3196	01	Test	Test	Test	2020-12-12 00:00:00	2030-12-12 00:00:00	Test	Test	t	t	01	verified	Y
177	3197	01	Test	Test	Test	2020-12-12 00:00:00	2030-12-12 00:00:00	Test	Test	t	t	01	verified	Y
178	3198	01	Test	Test	Test	2020-12-12 00:00:00	2030-12-12 00:00:00	Test	Test	t	t	01	verified	Y
179	3199	01	Test	Test	Test	2020-12-12 00:00:00	2030-12-12 00:00:00	Test	Test	t	t	01	verified	Y
180	3200	01	Test	Test	Test	2020-12-12 00:00:00	2030-12-12 00:00:00	Test	Test	t	t	01	verified	Y
181	3201	01	Test	Test	Test	2020-12-12 00:00:00	2030-12-12 00:00:00	Test	Test	t	t	01	verified	Y
182	3202	01	Test	Test	Test	2020-12-12 00:00:00	2030-12-12 00:00:00	Test	Test	t	t	01	verified	Y
183	3203	01	Test	Test	Test	2020-12-12 00:00:00	2030-12-12 00:00:00	Test	Test	t	t	01	verified	Y
184	3204	01	Test	Test	Test	2020-12-12 00:00:00	2030-12-12 00:00:00	Test	Test	t	t	01	verified	Y
185	3205	01	Test	Test	Test	2020-12-12 00:00:00	2030-12-12 00:00:00	Test	Test	t	t	01	verified	Y
186	3206	01	Test	Test	Test	2020-12-12 00:00:00	2030-12-12 00:00:00	Test	Test	t	t	01	verified	Y
187	3207	01	Test	Test	Test	2020-12-12 00:00:00	2030-12-12 00:00:00	Test	Test	t	t	01	verified	Y
188	3208	01	Test	Test	Test	2020-12-12 00:00:00	2030-12-12 00:00:00	Test	Test	t	t	01	verified	Y
189	3209	01	Test	Test	Test	2020-12-12 00:00:00	2030-12-12 00:00:00	Test	Test	t	t	01	verified	Y
190	3210	01	Test	Test	Test	2020-12-12 00:00:00	2030-12-12 00:00:00	Test	Test	t	t	01	verified	Y
191	3216	01	Test	Test	Test	2020-12-12 00:00:00	2030-12-12 00:00:00	Test	Test	t	t	01	verified	Y
192	3217	01	Test	Test	Test	2020-12-12 00:00:00	2030-12-12 00:00:00	Test	Test	t	t	01	verified	Y
193	3218	01	Test	Test	Test	2020-12-12 00:00:00	2030-12-12 00:00:00	Test	Test	t	t	01	verified	Y
194	3220	01	Test	Test	Test	2020-12-12 00:00:00	2030-12-12 00:00:00	Test	Test	t	t	01	verified	Y
195	3222	01	Test	Test	Test	2020-12-12 00:00:00	2030-12-12 00:00:00	Test	Test	t	t	01	verified	Y
196	3223	01	Test	Test	Test	2020-12-12 00:00:00	2030-12-12 00:00:00	Test	Test	t	t	01	verified	Y
197	3224	01	Test	Test	Test	2020-12-12 00:00:00	2030-12-12 00:00:00	Test	Test	t	t	01	verified	Y
198	3225	01	Test	Test	Test	2020-12-12 00:00:00	2030-12-12 00:00:00	Test	Test	t	t	01	verified	Y
199	3226	01	Test	Test	Test	2020-12-12 00:00:00	2030-12-12 00:00:00	Test	Test	t	t	01	verified	Y
200	3227	01	Test	Test	Test	2020-12-12 00:00:00	2030-12-12 00:00:00	Test	Test	t	t	01	verified	Y
201	3228	01	Test	Test	Test	2020-12-12 00:00:00	2030-12-12 00:00:00	Test	Test	t	t	01	verified	Y
202	3229	01	Test	Test	Test	2020-12-12 00:00:00	2030-12-12 00:00:00	Test	Test	t	t	01	verified	Y
203	3230	01	Test	Test	Test	2020-12-12 00:00:00	2030-12-12 00:00:00	Test	Test	t	t	01	verified	Y
204	3231	01	Test	Test	Test	2020-12-12 00:00:00	2030-12-12 00:00:00	Test	Test	t	t	01	verified	Y
205	3232	01	Test	Test	Test	2020-12-12 00:00:00	2030-12-12 00:00:00	Test	Test	t	t	01	verified	Y
206	3233	01	Test	Test	Test	2020-12-12 00:00:00	2030-12-12 00:00:00	Test	Test	t	t	01	verified	Y
207	3234	01	Test	Test	Test	2020-12-12 00:00:00	2030-12-12 00:00:00	Test	Test	t	t	01	verified	Y
208	3235	01	Test	Test	Test	2020-12-12 00:00:00	2030-12-12 00:00:00	Test	Test	t	t	01	verified	Y
209	3236	01	Test	Test	Test	2020-12-12 00:00:00	2030-12-12 00:00:00	Test	Test	t	t	01	verified	Y
210	3237	01	Test	Test	Test	2020-12-12 00:00:00	2030-12-12 00:00:00	Test	Test	t	t	01	verified	Y
211	3238	01	Test	Test	Test	2020-12-12 00:00:00	2030-12-12 00:00:00	Test	Test	t	t	01	verified	Y
212	3239	01	Test	Test	Test	2020-12-12 00:00:00	2030-12-12 00:00:00	Test	Test	t	t	01	verified	Y
213	3240	01	Test	Test	Test	2020-12-12 00:00:00	2030-12-12 00:00:00	Test	Test	t	t	01	verified	Y
214	3241	01	Test	Test	Test	2020-12-12 00:00:00	2030-12-12 00:00:00	Test	Test	t	t	01	verified	Y
215	3242	01	Test	Test	Test	2020-12-12 00:00:00	2030-12-12 00:00:00	Test	Test	t	t	01	verified	Y
216	3243	01	Test	Test	Test	2020-12-12 00:00:00	2030-12-12 00:00:00	Test	Test	t	t	01	verified	Y
217	3244	01	Test	Test	Test	2020-12-12 00:00:00	2030-12-12 00:00:00	Test	Test	t	t	01	verified	Y
218	3245	01	Test	Test	Test	2020-12-12 00:00:00	2030-12-12 00:00:00	Test	Test	t	t	01	verified	Y
219	3246	01	Test	Test	Test	2020-12-12 00:00:00	2030-12-12 00:00:00	Test	Test	t	t	01	verified	Y
220	3247	01	Test	Test	Test	2020-12-12 00:00:00	2030-12-12 00:00:00	Test	Test	t	t	01	verified	Y
221	3248	01	Test	Test	Test	2020-12-12 00:00:00	2030-12-12 00:00:00	Test	Test	t	t	01	verified	Y
222	3249	01	Test	Test	Test	2020-12-12 00:00:00	2030-12-12 00:00:00	Test	Test	t	t	01	verified	Y
223	3250	01	Test	Test	Test	2020-12-12 00:00:00	2030-12-12 00:00:00	Test	Test	t	t	01	verified	Y
224	3251	01	Test	Test	Test	2020-12-12 00:00:00	2030-12-12 00:00:00	Test	Test	t	t	01	verified	Y
225	3252	01	Test	Test	Test	2020-12-12 00:00:00	2030-12-12 00:00:00	Test	Test	t	t	01	verified	Y
226	3253	01	Test	Test	Test	2020-12-12 00:00:00	2030-12-12 00:00:00	Test	Test	t	t	01	verified	Y
227	3254	01	Test	Test	Test	2020-12-12 00:00:00	2030-12-12 00:00:00	Test	Test	t	t	01	verified	Y
228	3255	01	Test	Test	Test	2020-12-12 00:00:00	2030-12-12 00:00:00	Test	Test	t	t	01	verified	Y
229	3256	01	Test	Test	Test	2020-12-12 00:00:00	2030-12-12 00:00:00	Test	Test	t	t	01	verified	Y
230	3257	01	Test	Test	Test	2020-12-12 00:00:00	2030-12-12 00:00:00	Test	Test	t	t	01	verified	Y
231	3259	01	Test	Test	Test	2020-12-12 00:00:00	2030-12-12 00:00:00	Test	Test	t	t	01	verified	Y
232	3260	01	Test	Test	Test	2020-12-12 00:00:00	2030-12-12 00:00:00	Test	Test	t	t	01	verified	Y
233	3261	01	Test	Test	Test	2020-12-12 00:00:00	2030-12-12 00:00:00	Test	Test	t	t	01	verified	Y
239	3268	01	0	Test	Test	2020-12-12 00:00:00	2023-11-30 00:00:00	Test	Test	t	t	01	verified	Y
240	3269	01	0	Test	Test	2020-12-12 00:00:00	1900-01-01 00:00:00	Test	Test	t	t	01	verified	Y
241	3271	01	0	Test	Test	2020-12-12 00:00:00	2023-11-30 00:00:00	Test	Test	t	t	01	verified	Y
242	3272	01	0	Test	Test	2020-12-12 00:00:00	2023-11-30 00:00:00	Test	Test	t	t	01	verified	Y
243	3273	01	31195855.0	01	NA	2018-09-12 00:00:00	2029-07-14 00:00:00	USA	02	t	t	01	Approved	Y
\.


--
-- Data for Name: party_fatca_details; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.party_fatca_details (party_fatca_details_id, party_id, place_of_incorporation, country_of_incorporation, country_of_residence, incorporation_number, board_rel_number, report_bl_number, original_report_bl_number, fatca_tax_id, document_reference_id) FROM stdin;
44	3043	Da Nang	Vietnam	Vietnam	01	BR01	R01	OR1	01	11
45	3045	Da Nang	Vietnam	Vietnam	01	BR01	R01	OR1	01	11
46	3046	Da Nang	Vietnam	Vietnam	01	BR01	R01	OR1	01	11
47	3047	Da Nang	Vietnam	Vietnam	01	BR01	R01	OR1	01	11
48	3048	Da Nang	Vietnam	Vietnam	01	BR01	R01	OR1	01	11
49	3049	Da Nang	Vietnam	Vietnam	01	BR01	R01	OR1	01	11
50	3050	Da Nang	Vietnam	Vietnam	01	BR01	R01	OR1	01	11
51	3052	Da Nang	Singapore	Singapore	01	BR01	R01	OR1	01	11
52	3056	Da Nang	Vietnam	Vietnam	01	BR01	R01	OR1	01	11
53	3057	Da Nang	Vietnam	Vietnam	01	BR01	R01	OR1	01	11
54	3058	Da Nang	Vietnam	Vietnam	01	BR01	R01	OR1	01	11
55	3059	Da Nang	Vietnam	Vietnam	01	BR01	R01	OR1	01	11
56	3060	Da Nang	Vietnam	Vietnam	01	BR01	R01	OR1	01	11
57	3061	Da Nang	Vietnam	Vietnam	01	BR01	R01	OR1	01	11
58	3062	Da Nang	Vietnam	Vietnam	01	BR01	R01	OR1	01	11
59	3076	Da Nang	Vietnam	Vietnam	01	BR01	R01	OR1	01	11
60	3077	Da Nang	Vietnam	Vietnam	01	BR01	R01	OR1	01	11
61	3078	Da Nang	Vietnam	Vietnam	01	BR01	R01	OR1	01	11
62	3094	Da Nang	Vietnam	Vietnam	01	BR01	R01	OR1	01	11
63	3095	Da Nang	Vietnam	Vietnam	01	BR01	R01	OR1	01	11
64	3100	Da Nang	Vietnam	Vietnam	01	BR01	R01	OR1	01	11
65	3101	Da Nang	Vietnam	Vietnam	01	BR01	R01	OR1	01	11
66	3102	Da Nang	Vietnam	Vietnam	01	BR01	R01	OR1	01	11
67	3103	Da Nang	Vietnam	Vietnam	01	BR01	R01	OR1	01	11
68	3105	Da Nang	Vietnam	Vietnam	01	BR01	R01	OR1	01	11
69	3106	Da Nang	Vietnam	Vietnam	01	BR01	R01	OR1	01	11
70	3107	Da Nang	Vietnam	Vietnam	01	BR01	R01	OR1	01	11
71	3108	Da Nang	Vietnam	Vietnam	01	BR01	R01	OR1	01	11
72	3109	Da Nang	Vietnam	Vietnam	01	BR01	R01	OR1	01	11
73	3113	Test	Test	Test	Test	Test	Test	Test	Test	11
74	3114	Bhopal	Test	Test	Test	Test	Test	Test	Test	11
75	3115	Manchester	Test	Test	Test	Test	Test	Test	Test	11
76	3116	Chicago	Test	Test	Test	Test	Test	Test	Test	11
77	3117	Chicago	Test	Test	Test	Test	Test	Test	Test	11
78	3118	Bhopal	Test	Test	Test	Test	Test	Test	Test	11
79	3119	Bhopal 	Test	Test	Test	Test	Test	Test	Test	11
112	3152	Test	Test	Test	Test	Test	Test	Test	Test	11
113	3153	Test	Test	Test	Test	Test	Test	Test	Test	11
114	3154	Test	Test	Test	Test	Test	Test	Test	Test	11
115	3155	Test	Test	Test	Test	Test	Test	Test	Test	11
116	3156	Test	Test	Test	Test	Test	Test	Test	Test	11
117	3157	Test	Test	Test	Test	Test	Test	Test	Test	11
118	3158	Test	Test	Test	Test	Test	Test	Test	Test	11
119	3159	Test	Test	Test	Test	Test	Test	Test	Test	11
120	3160	Test	Test	Test	Test	Test	Test	Test	Test	11
121	3161	Test	Test	Test	Test	Test	Test	Test	Test	11
122	3162	Test	Test	Test	Test	Test	Test	Test	Test	11
123	3163	Test	Test	Test	Test	Test	Test	Test	Test	11
124	3164	Test	Test	Test	Test	Test	Test	Test	Test	11
125	3165	Test	Test	Test	Test	Test	Test	Test	Test	11
126	3166	Test	Test	Test	Test	Test	Test	Test	Test	11
127	3167	Test	Test	Test	Test	Test	Test	Test	Test	11
128	3168	Test	Test	Test	Test	Test	Test	Test	Test	11
129	3169	Test	Test	Test	Test	Test	Test	Test	Test	11
130	3170	Test	Test	Test	Test	Test	Test	Test	Test	11
131	3171	Test	Test	Test	Test	Test	Test	Test	Test	11
132	3172	Bhopal	Test	Test	Test	Test	Test	Test	Test	11
133	3173	Test	Test	Test	Test	Test	Test	Test	Test	11
134	3174	Test	Test	Test	Test	Test	Test	Test	Test	11
135	3175	Test	Test	Test	Test	Test	Test	Test	Test	11
136	3176	PUNE	Test	Test	Test	Test	Test	Test	Test	11
137	3177	PUNE	Test	Test	Test	Test	Test	Test	Test	11
138	3178	Chennai 	Test	Test	Test	Test	Test	Test	Test	11
139	3179	Test	Test	Test	Test	Test	Test	Test	Test	11
140	3180	Test	Test	Test	Test	Test	Test	Test	Test	11
141	3181	Chennai 	Test	Test	Test	Test	Test	Test	Test	11
142	3182	Pune	Test	Test	Test	Test	Test	Test	Test	11
143	3183	Test	Test	Test	Test	Test	Test	Test	Test	11
144	3184	Test	Test	Test	Test	Test	Test	Test	Test	11
145	3185	Test	Test	Test	Test	Test	Test	Test	Test	11
146	3186	Test	Test	Test	Test	Test	Test	Test	Test	11
147	3187	Test	Test	Test	Test	Test	Test	Test	Test	11
148	3188	Test	Test	Test	Test	Test	Test	Test	Test	11
149	3189	Test	Test	Test	Test	Test	Test	Test	Test	11
150	3190	Test	Test	Test	Test	Test	Test	Test	Test	11
151	3191	Test	Test	Test	Test	Test	Test	Test	Test	11
152	3192	Test	Test	Test	Test	Test	Test	Test	Test	11
153	3193	Test	Test	Test	Test	Test	Test	Test	Test	11
154	3194	Pune 	Test	Test	Test	Test	Test	Test	Test	11
155	3195	Benglore 	Test	Test	Test	Test	Test	Test	Test	11
156	3196	Mumbai 	Test	Test	Test	Test	Test	Test	Test	11
157	3197	Test	Test	Test	Test	Test	Test	Test	Test	11
158	3198	Test	Test	Test	Test	Test	Test	Test	Test	11
159	3199	Pune 	Test	Test	Test	Test	Test	Test	Test	11
160	3200	Sao Paolo	Test	Test	Test	Test	Test	Test	Test	11
161	3201	Chicago	Test	Test	Test	Test	Test	Test	Test	11
162	3202	Chicago	Test	Test	Test	Test	Test	Test	Test	11
163	3203	Sao Paolo	Test	Test	Test	Test	Test	Test	Test	11
164	3204	Sao Paolo	Test	Test	Test	Test	Test	Test	Test	11
165	3205	USA	Test	Test	Test	Test	Test	Test	Test	11
166	3206	Pune 	Test	Test	Test	Test	Test	Test	Test	11
167	3207	Ahahha	Test	Test	Test	Test	Test	Test	Test	11
168	3208	Pune 	Test	Test	Test	Test	Test	Test	Test	11
169	3209	Chennai	Test	Test	Test	Test	Test	Test	Test	11
170	3210	Test	Test	Test	Test	Test	Test	Test	Test	11
171	3216	Bhopal	Test	Test	Test	Test	Test	Test	Test	11
172	3217	Bhopal	Test	Test	Test	Test	Test	Test	Test	11
173	3218	Kanpur	Test	Test	Test	Test	Test	Test	Test	11
174	3220	Test	Test	Test	Test	Test	Test	Test	Test	11
175	3222	Pune Maharashtra 	Test	Test	Test	Test	Test	Test	Test	11
176	3223	Fui9	Test	Test	Test	Test	Test	Test	Test	11
177	3224	Test	Test	Test	Test	Test	Test	Test	Test	11
178	3225	Pune Maharashtra 	Test	Test	Test	Test	Test	Test	Test	11
179	3226	Ranchi	Test	Test	Test	Test	Test	Test	Test	11
180	3227	Sggs	Test	Test	Test	Test	Test	Test	Test	11
181	3228	Vellore 	Test	Test	Test	Test	Test	Test	Test	11
182	3229	Bhopal	Test	Test	Test	Test	Test	Test	Test	11
183	3230	Shzhjahz	Test	Test	Test	Test	Test	Test	Test	11
184	3231	bhopal	Test	Test	Test	Test	Test	Test	Test	11
185	3232	Vellore	Test	Test	Test	Test	Test	Test	Test	11
186	3233	Bhopal MP	Test	Test	Test	Test	Test	Test	Test	11
187	3234	Karur	Test	Test	Test	Test	Test	Test	Test	11
188	3235	Karur 	Test	Test	Test	Test	Test	Test	Test	11
189	3236	Ranchi 	Test	Test	Test	Test	Test	Test	Test	11
190	3237	Bhopal	Test	Test	Test	Test	Test	Test	Test	11
191	3238	Bhopal	Test	Test	Test	Test	Test	Test	Test	11
192	3239	Pune Maharashtra 	Test	Test	Test	Test	Test	Test	Test	11
193	3240	bhopal	Test	Test	Test	Test	Test	Test	Test	11
194	3241	bhopal	Test	Test	Test	Test	Test	Test	Test	11
195	3242	Bhopal MP	Test	Test	Test	Test	Test	Test	Test	11
196	3243	Bhopal	Test	Test	Test	Test	Test	Test	Test	11
197	3244	Bhopal	Test	Test	Test	Test	Test	Test	Test	11
198	3245	bhopal	Test	Test	Test	Test	Test	Test	Test	11
199	3246	bhopal	Test	Test	Test	Test	Test	Test	Test	11
200	3247	bhopal	Test	Test	Test	Test	Test	Test	Test	11
201	3248	bhopal	Test	Test	Test	Test	Test	Test	Test	11
202	3249	Pune Maharashtra 	Test	Test	Test	Test	Test	Test	Test	11
203	3250	Mumbai Maharashtra 	Test	Test	Test	Test	Test	Test	Test	11
204	3251	Chennai 	Test	Test	Test	Test	Test	Test	Test	11
205	3252	Bhopal 	Test	Test	Test	Test	Test	Test	Test	11
206	3253	Mumbai 	Test	Test	Test	Test	Test	Test	Test	11
207	3254	Hyderabad 	Test	Test	Test	Test	Test	Test	Test	11
208	3255	Karur 	Test	Test	Test	Test	Test	Test	Test	11
209	3256	fjgjfgrg	Test	Test	Test	Test	Test	Test	Test	11
210	3257	fjgjfgrg	Test	Test	Test	Test	Test	Test	Test	11
211	3259	Karur 	Test	Test	Test	Test	Test	Test	Test	11
212	3260	CHENNAI	Test	Test	Test	Test	Test	Test	Test	11
213	3261	CHENNAI	Test	Test	Test	Test	Test	Test	Test	11
219	3268	Pune 	Test	Test	Test	Test	Test	Test	Test	11
220	3269	Bhilai 	Test	Test	Test	Test	Test	Test	Test	11
221	3271	Pune	Test	Test	Test	Test	Test	Test	Test	11
222	3272	Pune 	Test	Test	Test	Test	Test	Test	Test	11
\.


--
-- Data for Name: party_guardian; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.party_guardian (party_guardian_id, party_id, guardian_first_name, guardian_middle_name, guardian_last_name, guardian_address_line1, guardian_address_line2, guardian_address_line3, guardian_ward_code, guardian_city_code, guardian_district_code, guardian_relation) FROM stdin;
43	3043	Anh	Van	Duc	Da Nang	House 14	District 17	01	01	01	\N
44	3045	Anh	Van	Duc	Da Nang	House 14	District 17	01	01	01	\N
45	3046	Anh	Van	Duc	Da Nang	House 14	District 17	01	01	01	\N
46	3047	Anh	Van	Duc	Da Nang	House 14	District 17	01	01	01	\N
47	3048	Anh	Van	Duc	Da Nang	House 14	District 17	01	01	01	\N
48	3049	Anh	Van	Duc	Da Nang	House 14	District 17	01	01	01	\N
49	3050	Anh	Van	Duc	Da Nang	House 14	District 17	01	01	01	\N
50	3052	Anh	Van	Duc	Da Nang	House 14	District 17	01	01	01	\N
51	3056	Anh	Van	Duc	Da Nang	House 14	District 17	01	01	01	\N
52	3057	Anh	Van	Duc	Da Nang	House 14	District 17	01	01	01	\N
53	3058	Anh	Van	Duc	Da Nang	House 14	District 17	01	01	01	\N
54	3059	Anh	Van	Duc	Da Nang	House 14	District 17	01	01	01	\N
55	3060	Anh	Van	Duc	Da Nang	House 14	District 17	01	01	01	\N
56	3061	Anh	Van	Duc	Da Nang	House 14	District 17	01	01	01	\N
57	3062	Anh	Van	Duc	Da Nang	House 14	District 17	01	01	01	\N
58	3076	Anh	Van	Duc	Da Nang	House 14	District 17	01	01	01	\N
59	3077	Anh	Van	Duc	Da Nang	House 14	District 17	01	01	01	\N
60	3078	Anh	Van	Duc	Da Nang	House 14	District 17	01	01	01	\N
61	3094	Anh	Van	Duc	Da Nang	House 14	District 17	01	01	01	\N
62	3095	Anh	Van	Duc	Da Nang	House 14	District 17	01	01	01	\N
63	3100	Anh	Van	Duc	Da Nang	House 14	District 17	01	01	01	\N
64	3101	Anh	Van	Duc	Da Nang	House 14	District 17	01	01	01	\N
65	3102	Anh	Van	Duc	Da Nang	House 14	District 17	01	01	01	\N
66	3103	Anh	Van	Duc	Da Nang	House 14	District 17	01	01	01	\N
67	3105	Anh	Van	Duc	Da Nang	House 14	District 17	01	01	01	Father
68	3106	Anh	Van	Duc	Da Nang	House 14	District 17	01	01	01	Father
69	3107	Anh	Van	Duc	Da Nang	House 14	District 17	01	01	01	Father
70	3108	Anh	Van	Duc	Da Nang	House 14	District 17	01	01	01	Father
71	3109	Anh	Van	Duc	Da Nang	House 14	District 17	01	01	01	Father
72	3113	Test	Test	Test	Test	Test	Test	Test	Test	Test	Test
73	3114	Test	Test	Test	SIRT Campus	Test	Test	Test	Test	Test	Test
74	3115	Test	Test	Test	Manchester	Test	Test	Test	Test	Test	Test
75	3116	Test	Test	Test	Chicago	Test	Test	Test	Test	Test	Test
76	3117	Test	Test	Test	Chicago	Test	Test	Test	Test	Test	Test
77	3118	Test	Test	Test	Awadhpuri	Test	Test	Test	Test	Test	Test
78	3119	Test	Test	Test	Awadhpuri	Test	Test	Test	Test	Test	Test
111	3152	Test	Test	Test	Test	Test	Test	Test	Test	Test	Test
112	3153	Test	Test	Test	Test	Test	Test	Test	Test	Test	Test
113	3154	Test	Test	Test	Test	Test	Test	Test	Test	Test	Test
114	3155	Test	Test	Test	Test	Test	Test	Test	Test	Test	Test
115	3156	Test	Test	Test	Test	Test	Test	Test	Test	Test	Test
116	3157	Test	Test	Test	Test	Test	Test	Test	Test	Test	Test
117	3158	Test	Test	Test	Test	Test	Test	Test	Test	Test	Test
118	3159	Test	Test	Test	Test	Test	Test	Test	Test	Test	Test
119	3160	Test	Test	Test	Test	Test	Test	Test	Test	Test	Test
120	3161	Test	Test	Test	Test	Test	Test	Test	Test	Test	Test
121	3162	Test	Test	Test	Test	Test	Test	Test	Test	Test	Test
122	3163	Test	Test	Test	Test	Test	Test	Test	Test	Test	Test
123	3164	Test	Test	Test	Test	Test	Test	Test	Test	Test	Test
124	3165	Test	Test	Test	Test	Test	Test	Test	Test	Test	Test
125	3166	Test	Test	Test	Test	Test	Test	Test	Test	Test	Test
126	3167	Test	Test	Test	Test	Test	Test	Test	Test	Test	Test
127	3168	Test	Test	Test	Test	Test	Test	Test	Test	Test	Test
128	3169	Test	Test	Test	Test	Test	Test	Test	Test	Test	Test
129	3170	Test	Test	Test	Test	Test	Test	Test	Test	Test	Test
130	3171	Test	Test	Test	Test	Test	Test	Test	Test	Test	Test
131	3172	Test	Test	Test	Bhopal	Test	Test	Test	Test	Test	Test
132	3173	Test	Test	Test	Test	Test	Test	Test	Test	Test	Test
133	3174	Test	Test	Test	Test	Test	Test	Test	Test	Test	Test
134	3175	Test	Test	Test	Test	Test	Test	Test	Test	Test	Test
135	3176	Test	Test	Test	PUNE MAHARASHTRA	Test	Test	Test	Test	Test	Test
136	3177	Test	Test	Test	PUNE MAHARASHTRA 	Test	Test	Test	Test	Test	Test
137	3178	Test	Test	Test	Chennai Chennai 	Test	Test	Test	Test	Test	Test
138	3179	Test	Test	Test	Test	Test	Test	Test	Test	Test	Test
139	3180	Test	Test	Test	Test	Test	Test	Test	Test	Test	Test
140	3181	Test	Test	Test	Chennai Chennai 	Test	Test	Test	Test	Test	Test
141	3182	Test	Test	Test	Pune Maharashtra 	Test	Test	Test	Test	Test	Test
142	3183	Test	Test	Test	Test	Test	Test	Test	Test	Test	Test
143	3184	Test	Test	Test	Test	Test	Test	Test	Test	Test	Test
144	3185	Test	Test	Test	Test	Test	Test	Test	Test	Test	Test
145	3186	Test	Test	Test	Test	Test	Test	Test	Test	Test	Test
146	3187	Test	Test	Test	Test	Test	Test	Test	Test	Test	Test
147	3188	Test	Test	Test	Test	Test	Test	Test	Test	Test	Test
148	3189	Test	Test	Test	Test	Test	Test	Test	Test	Test	Test
149	3190	Test	Test	Test	Test	Test	Test	Test	Test	Test	Test
150	3191	Test	Test	Test	Test	Test	Test	Test	Test	Test	Test
151	3192	Test	Test	Test	Test	Test	Test	Test	Test	Test	Test
152	3193	Test	Test	Test	Test	Test	Test	Test	Test	Test	Test
153	3194	Test	Test	Test	Pune Maharashtra 	Test	Test	Test	Test	Test	Test
154	3195	Test	Test	Test	Benglore Karnataka 	Test	Test	Test	Test	Test	Test
155	3196	Test	Test	Test	Mumbai  Maharashtra 	Test	Test	Test	Test	Test	Test
156	3197	Test	Test	Test	Test	Test	Test	Test	Test	Test	Test
157	3198	Test	Test	Test	Test	Test	Test	Test	Test	Test	Test
158	3199	Test	Test	Test	Pune Maharashtra 	Test	Test	Test	Test	Test	Test
159	3200	Test	Test	Test	Sao Paolo	Test	Test	Test	Test	Test	Test
160	3201	Test	Test	Test	Chicago	Test	Test	Test	Test	Test	Test
161	3202	Test	Test	Test	Sao Paolo	Test	Test	Test	Test	Test	Test
162	3203	Test	Test	Test	Chicago	Test	Test	Test	Test	Test	Test
163	3204	Test	Test	Test	Chicago	Test	Test	Test	Test	Test	Test
164	3205	Test	Test	Test	USA	Test	Test	Test	Test	Test	Test
165	3206	Test	Test	Test	Pune Maharashtra 	Test	Test	Test	Test	Test	Test
166	3207	Test	Test	Test	Hahah	Test	Test	Test	Test	Test	Test
167	3208	Test	Test	Test	Pune Maharashtra 	Test	Test	Test	Test	Test	Test
168	3209	Test	Test	Test	Gshamq	Test	Test	Test	Test	Test	Test
169	3210	Test	Test	Test	Test	Test	Test	Test	Test	Test	Test
170	3216	Test	Test	Test	Bhopal	Test	Test	Test	Test	Test	Test
171	3217	Test	Test	Test	Bhopal	Test	Test	Test	Test	Test	Test
172	3218	Test	Test	Test	Kanpur	Test	Test	Test	Test	Test	Test
173	3220	Test	Test	Test	Test	Test	Test	Test	Test	Test	Test
174	3222	Test	Test	Test	Pune 	Test	Test	Test	Test	Test	Test
175	3223	Test	Test	Test	Cbj	Test	Test	Test	Test	Test	Test
176	3224	Test	Test	Test	Test	Test	Test	Test	Test	Test	Test
177	3225	Test	Test	Test	Pune 	Test	Test	Test	Test	Test	Test
178	3226	Test	Test	Test	Ranchi	Test	Test	Test	Test	Test	Test
179	3227	Test	Test	Test	Gsga	Test	Test	Test	Test	Test	Test
180	3228	Test	Test	Test	Vellore 	Test	Test	Test	Test	Test	Test
181	3229	Test	Test	Test	Bhopal	Test	Test	Test	Test	Test	Test
182	3230	Test	Test	Test	Hzhzhhsh	Test	Test	Test	Test	Test	Test
183	3231	Test	Test	Test	Bhopal	Test	Test	Test	Test	Test	Test
184	3232	Test	Test	Test	No.5 Kumaran st, Dharapadavedu,	Test	Test	Test	Test	Test	Test
185	3233	Test	Test	Test	Bhopal 	Test	Test	Test	Test	Test	Test
186	3234	Test	Test	Test	Karur	Test	Test	Test	Test	Test	Test
187	3235	Test	Test	Test	Karur 	Test	Test	Test	Test	Test	Test
188	3236	Test	Test	Test	Ranchi 	Test	Test	Test	Test	Test	Test
189	3237	Test	Test	Test	Bhopal 	Test	Test	Test	Test	Test	Test
190	3238	Test	Test	Test	Bhopal	Test	Test	Test	Test	Test	Test
191	3239	Test	Test	Test	Pune 	Test	Test	Test	Test	Test	Test
192	3240	Test	Test	Test	Bhopal	Test	Test	Test	Test	Test	Test
193	3241	Test	Test	Test	Bhopal	Test	Test	Test	Test	Test	Test
194	3242	Test	Test	Test	Bhopal 	Test	Test	Test	Test	Test	Test
195	3243	Test	Test	Test	40, Narmadapuram Rd	Test	Test	Test	Test	Test	Test
196	3244	Test	Test	Test	40, Narmadapuram Rd	Test	Test	Test	Test	Test	Test
197	3245	Test	Test	Test	Bhopal	Test	Test	Test	Test	Test	Test
198	3246	Test	Test	Test	Bhopal	Test	Test	Test	Test	Test	Test
199	3247	Test	Test	Test	Bhopal	Test	Test	Test	Test	Test	Test
200	3248	Test	Test	Test	Bhopal	Test	Test	Test	Test	Test	Test
201	3249	Test	Test	Test	Pune	Test	Test	Test	Test	Test	Test
202	3250	Test	Test	Test	Mumbai 	Test	Test	Test	Test	Test	Test
203	3251	Test	Test	Test	Vellore 	Test	Test	Test	Test	Test	Test
204	3252	Test	Test	Test	Bhopal	Test	Test	Test	Test	Test	Test
205	3253	Test	Test	Test	Mumbai Maharashtra 	Test	Test	Test	Test	Test	Test
206	3254	Test	Test	Test	Hyderabad 	Test	Test	Test	Test	Test	Test
207	3255	Test	Test	Test	Karur 	Test	Test	Test	Test	Test	Test
208	3256	Test	Test	Test	dksjfsjffhdfdfdfjdfgnfng	Test	Test	Test	Test	Test	Test
209	3257	Test	Test	Test	dksjfsjffhdfdfdfjdfgnfng	Test	Test	Test	Test	Test	Test
210	3259	Test	Test	Test	Karur 	Test	Test	Test	Test	Test	Test
211	3260	Test	Test	Test	4567	Test	Test	Test	Test	Test	Test
212	3261	Test	Test	Test	4567	Test	Test	Test	Test	Test	Test
213	3268	Test	Test	Test	Flat no-101 Palace Orchard Society Near Betos restaurant off NIBM Kondhwa Pune 	Test	Test	Test	Test	Test	Test
214	3269	Test	Test	Test	Ghjj	Test	Test	Test	Test	Test	Test
215	3271	Test	Test	Test	Palace Orchard society legend 2 building flat no 102 Near Betos hotel off NIBM Kondhwa Undir road Pune Maharashtra 	Test	Test	Test	Test	Test	Test
216	3272	Test	Test	Test	Palace Orchard Society legend-5 flat no 202 near Betos hotel off NIBM Kondhwa undri Pune Maharashtra 	Test	Test	Test	Test	Test	Test
\.


--
-- Data for Name: party_memo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.party_memo (party_memo_id, party_id, memo_type_code, severity, risk_score, valid_from, valid_until) FROM stdin;
45	3043	01	S1	11	1901-11-03 00:00:00	1915-11-02 00:00:00
46	3045	01	S1	11	1901-11-03 00:00:00	1915-11-02 00:00:00
47	3046	01	S1	11	1901-11-03 00:00:00	1915-11-02 00:00:00
48	3047	01	S1	11	1901-11-03 00:00:00	1915-11-02 00:00:00
49	3048	01	S1	11	1901-11-03 00:00:00	1915-11-02 00:00:00
50	3049	01	S1	11	1901-11-03 00:00:00	1915-11-02 00:00:00
51	3050	01	S1	11	1901-11-03 00:00:00	1915-11-02 00:00:00
52	3052	01	S1	11	1901-11-03 00:00:00	1915-11-02 00:00:00
53	3056	01	S1	11	1901-11-03 00:00:00	1915-11-02 00:00:00
54	3057	01	S1	11	1901-11-03 00:00:00	1915-11-02 00:00:00
55	3058	01	S1	11	1901-11-03 00:00:00	1915-11-02 00:00:00
56	3059	01	S1	11	1901-11-03 00:00:00	1915-11-02 00:00:00
57	3060	01	S1	11	1901-11-03 00:00:00	1915-11-02 00:00:00
58	3061	01	S1	11	1901-11-03 00:00:00	1915-11-02 00:00:00
59	3062	01	S1	11	1901-11-03 00:00:00	1915-11-02 00:00:00
60	3076	01	S1	11	1901-11-03 00:00:00	1915-11-02 00:00:00
61	3077	01	S1	11	1901-11-03 00:00:00	1915-11-02 00:00:00
62	3078	01	S1	11	1901-11-03 00:00:00	1915-11-02 00:00:00
63	3094	01	S1	11	1901-11-03 00:00:00	1915-11-02 00:00:00
64	3095	01	S1	11	1901-11-03 00:00:00	1915-11-02 00:00:00
65	3100	01	S1	11	1901-11-03 00:00:00	1915-11-02 00:00:00
66	3101	01	S1	11	1901-11-03 00:00:00	1915-11-02 00:00:00
67	3102	01	S1	11	1901-11-03 00:00:00	1915-11-02 00:00:00
68	3103	01	S1	11	1901-11-03 00:00:00	1915-11-02 00:00:00
69	3105	01	S1	11	1901-11-03 00:00:00	1915-11-02 00:00:00
70	3106	01	S1	11	1901-11-03 00:00:00	1915-11-02 00:00:00
71	3107	01	S1	11	1901-11-03 00:00:00	1915-11-02 00:00:00
72	3108	01	S1	11	1901-11-03 00:00:00	1915-11-02 00:00:00
73	3109	01	S1	11	1901-11-03 00:00:00	1915-11-02 00:00:00
74	3113	01	Test	75757	1901-11-03 00:00:00	1945-11-03 00:00:00
75	3114	01	Test	75757	1901-11-03 00:00:00	1945-11-03 00:00:00
76	3115	01	Test	75757	1901-11-03 00:00:00	1945-11-03 00:00:00
77	3116	01	Test	75757	1901-11-03 00:00:00	1945-11-03 00:00:00
78	3117	01	Test	75757	1901-11-03 00:00:00	1945-11-03 00:00:00
79	3118	01	Test	75757	1901-11-03 00:00:00	1945-11-03 00:00:00
80	3119	01	Test	75757	1901-11-03 00:00:00	1945-11-03 00:00:00
113	3152	01	Test	75757	1901-11-03 00:00:00	1945-11-03 00:00:00
114	3153	01	Test	75757	1901-11-03 00:00:00	1945-11-03 00:00:00
115	3154	01	Test	75757	1901-11-03 00:00:00	1945-11-03 00:00:00
116	3155	01	Test	75757	1901-11-03 00:00:00	1945-11-03 00:00:00
117	3156	01	Test	75757	1901-11-03 00:00:00	1945-11-03 00:00:00
118	3157	01	Test	75757	1901-11-03 00:00:00	1945-11-03 00:00:00
119	3158	01	Test	75757	1901-11-03 00:00:00	1945-11-03 00:00:00
120	3159	01	Test	75757	1901-11-03 00:00:00	1945-11-03 00:00:00
121	3160	01	Test	75757	1901-11-03 00:00:00	1945-11-03 00:00:00
122	3161	01	Test	75757	1901-11-03 00:00:00	1945-11-03 00:00:00
123	3162	01	Test	75757	1901-11-03 00:00:00	1945-11-03 00:00:00
124	3163	01	Test	75757	1901-11-03 00:00:00	1945-11-03 00:00:00
125	3164	01	Test	75757	1901-11-03 00:00:00	1945-11-03 00:00:00
126	3165	01	Test	75757	1901-11-03 00:00:00	1945-11-03 00:00:00
127	3166	01	Test	75757	1901-11-03 00:00:00	1945-11-03 00:00:00
128	3167	01	Test	75757	1901-11-03 00:00:00	1945-11-03 00:00:00
129	3168	01	Test	75757	1901-11-03 00:00:00	1945-11-03 00:00:00
130	3169	01	Test	75757	1901-11-03 00:00:00	1945-11-03 00:00:00
131	3170	01	Test	75757	1901-11-03 00:00:00	1945-11-03 00:00:00
132	3171	01	Test	75757	1901-11-03 00:00:00	1945-11-03 00:00:00
133	3172	01	Test	75757	1901-11-03 00:00:00	1945-11-03 00:00:00
134	3173	01	Test	75757	1901-11-03 00:00:00	1945-11-03 00:00:00
135	3174	01	Test	75757	1901-11-03 00:00:00	1945-11-03 00:00:00
136	3175	01	Test	75757	1901-11-03 00:00:00	1945-11-03 00:00:00
137	3176	01	Test	75757	1901-11-03 00:00:00	1945-11-03 00:00:00
138	3177	01	Test	75757	1901-11-03 00:00:00	1945-11-03 00:00:00
139	3178	01	Test	75757	1901-11-03 00:00:00	1945-11-03 00:00:00
140	3179	01	Test	75757	1901-11-03 00:00:00	1945-11-03 00:00:00
141	3180	01	Test	75757	1901-11-03 00:00:00	1945-11-03 00:00:00
142	3181	01	Test	75757	1901-11-03 00:00:00	1945-11-03 00:00:00
143	3182	01	Test	75757	1901-11-03 00:00:00	1945-11-03 00:00:00
144	3183	01	Test	75757	1901-11-03 00:00:00	1945-11-03 00:00:00
145	3184	01	Test	75757	1901-11-03 00:00:00	1945-11-03 00:00:00
146	3185	01	Test	75757	1901-11-03 00:00:00	1945-11-03 00:00:00
147	3186	01	Test	75757	1901-11-03 00:00:00	1945-11-03 00:00:00
148	3187	01	Test	75757	1901-11-03 00:00:00	1945-11-03 00:00:00
149	3188	01	Test	75757	1901-11-03 00:00:00	1945-11-03 00:00:00
150	3189	01	Test	75757	1901-11-03 00:00:00	1945-11-03 00:00:00
151	3190	01	Test	75757	1901-11-03 00:00:00	1945-11-03 00:00:00
152	3191	01	Test	75757	1901-11-03 00:00:00	1945-11-03 00:00:00
153	3192	01	Test	75757	1901-11-03 00:00:00	1945-11-03 00:00:00
154	3193	01	Test	75757	1901-11-03 00:00:00	1945-11-03 00:00:00
155	3194	01	Test	75757	1901-11-03 00:00:00	1945-11-03 00:00:00
156	3195	01	Test	75757	1901-11-03 00:00:00	1945-11-03 00:00:00
157	3196	01	Test	75757	1901-11-03 00:00:00	1945-11-03 00:00:00
158	3197	01	Test	75757	1901-11-03 00:00:00	1945-11-03 00:00:00
159	3198	01	Test	75757	1901-11-03 00:00:00	1945-11-03 00:00:00
160	3199	01	Test	75757	1901-11-03 00:00:00	1945-11-03 00:00:00
161	3200	01	Test	75757	1901-11-03 00:00:00	1945-11-03 00:00:00
162	3201	01	Test	75757	1901-11-03 00:00:00	1945-11-03 00:00:00
163	3202	01	Test	75757	1901-11-03 00:00:00	1945-11-03 00:00:00
164	3203	01	Test	75757	1901-11-03 00:00:00	1945-11-03 00:00:00
165	3204	01	Test	75757	1901-11-03 00:00:00	1945-11-03 00:00:00
166	3205	01	Test	75757	1901-11-03 00:00:00	1945-11-03 00:00:00
167	3206	01	Test	75757	1901-11-03 00:00:00	1945-11-03 00:00:00
168	3207	01	Test	75757	1901-11-03 00:00:00	1945-11-03 00:00:00
169	3208	01	Test	75757	1901-11-03 00:00:00	1945-11-03 00:00:00
170	3209	01	Test	75757	1901-11-03 00:00:00	1945-11-03 00:00:00
171	3210	01	Test	75757	1901-11-03 00:00:00	1945-11-03 00:00:00
172	3216	01	Test	75757	1901-11-03 00:00:00	1945-11-03 00:00:00
173	3217	01	Test	75757	1901-11-03 00:00:00	1945-11-03 00:00:00
174	3218	01	Test	75757	1901-11-03 00:00:00	1945-11-03 00:00:00
175	3220	01	Test	75757	1901-11-03 00:00:00	1945-11-03 00:00:00
176	3222	01	Test	75757	1901-11-03 00:00:00	1945-11-03 00:00:00
177	3223	01	Test	75757	1901-11-03 00:00:00	1945-11-03 00:00:00
178	3224	01	Test	75757	1901-11-03 00:00:00	1945-11-03 00:00:00
179	3225	01	Test	75757	1901-11-03 00:00:00	1945-11-03 00:00:00
180	3226	01	Test	75757	1901-11-03 00:00:00	1945-11-03 00:00:00
181	3227	01	Test	75757	1901-11-03 00:00:00	1945-11-03 00:00:00
182	3228	01	Test	75757	1901-11-03 00:00:00	1945-11-03 00:00:00
183	3229	01	Test	75757	1901-11-03 00:00:00	1945-11-03 00:00:00
184	3230	01	Test	75757	1901-11-03 00:00:00	1945-11-03 00:00:00
185	3231	01	Test	75757	1901-11-03 00:00:00	1945-11-03 00:00:00
186	3232	01	Test	75757	1901-11-03 00:00:00	1945-11-03 00:00:00
187	3233	01	Test	75757	1901-11-03 00:00:00	1945-11-03 00:00:00
188	3234	01	Test	75757	1901-11-03 00:00:00	1945-11-03 00:00:00
189	3235	01	Test	75757	1901-11-03 00:00:00	1945-11-03 00:00:00
190	3236	01	Test	75757	1901-11-03 00:00:00	1945-11-03 00:00:00
191	3237	01	Test	75757	1901-11-03 00:00:00	1945-11-03 00:00:00
192	3238	01	Test	75757	1901-11-03 00:00:00	1945-11-03 00:00:00
193	3239	01	Test	75757	1901-11-03 00:00:00	1945-11-03 00:00:00
194	3240	01	Test	75757	1901-11-03 00:00:00	1945-11-03 00:00:00
195	3241	01	Test	75757	1901-11-03 00:00:00	1945-11-03 00:00:00
196	3242	01	Test	75757	1901-11-03 00:00:00	1945-11-03 00:00:00
197	3243	01	Test	75757	1901-11-03 00:00:00	1945-11-03 00:00:00
198	3244	01	Test	75757	1901-11-03 00:00:00	1945-11-03 00:00:00
199	3245	01	Test	75757	1901-11-03 00:00:00	1945-11-03 00:00:00
200	3246	01	Test	75757	1901-11-03 00:00:00	1945-11-03 00:00:00
201	3247	01	Test	75757	1901-11-03 00:00:00	1945-11-03 00:00:00
202	3248	01	Test	75757	1901-11-03 00:00:00	1945-11-03 00:00:00
203	3249	01	Test	75757	1901-11-03 00:00:00	1945-11-03 00:00:00
204	3250	01	Test	75757	1901-11-03 00:00:00	1945-11-03 00:00:00
205	3251	01	Test	75757	1901-11-03 00:00:00	1945-11-03 00:00:00
206	3252	01	Test	75757	1901-11-03 00:00:00	1945-11-03 00:00:00
207	3253	01	Test	75757	1901-11-03 00:00:00	1945-11-03 00:00:00
208	3254	01	Test	75757	1901-11-03 00:00:00	1945-11-03 00:00:00
209	3255	01	Test	75757	1901-11-03 00:00:00	1945-11-03 00:00:00
210	3256	01	Test	75757	1901-11-03 00:00:00	1945-11-03 00:00:00
211	3257	01	Test	75757	1901-11-03 00:00:00	1945-11-03 00:00:00
212	3259	01	Test	75757	1901-11-03 00:00:00	1945-11-03 00:00:00
213	3260	01	Test	75757	1901-11-03 00:00:00	1945-11-03 00:00:00
214	3261	01	Test	75757	1901-11-03 00:00:00	1945-11-03 00:00:00
220	3268	01	Test	75757	1901-11-03 00:00:00	1945-11-03 00:00:00
221	3269	01	Test	75757	1901-11-03 00:00:00	1945-11-03 00:00:00
222	3271	01	Test	75757	1901-11-03 00:00:00	1945-11-03 00:00:00
223	3272	01	Test	75757	1901-11-03 00:00:00	1945-11-03 00:00:00
\.


--
-- Data for Name: party_relation; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.party_relation (party_relation_id, party_id, secondary_party_id, party_relation_type_code, inv_relation) FROM stdin;
43	3043	02	01	Y
44	3045	02	01	Y
45	3046	02	01	Y
46	3047	02	01	Y
47	3048	02	01	Y
48	3049	02	01	Y
49	3050	02	01	Y
50	3052	02	01	Y
51	3056	02	01	Y
52	3057	02	01	Y
53	3058	02	01	Y
54	3059	02	01	Y
55	3060	02	01	Y
56	3061	02	01	Y
57	3062	02	01	Y
58	3076	02	01	Y
59	3077	02	01	Y
60	3078	02	01	Y
61	3094	02	01	Y
62	3095	02	01	Y
63	3100	02	01	Y
64	3101	02	01	Y
65	3102	02	01	Y
66	3103	02	01	Y
67	3105	02	01	Y
68	3106	02	01	Y
69	3107	02	01	Y
70	3108	02	01	Y
71	3109	02	01	Y
72	3113	Test	01	Test
73	3114	Test	01	Test
74	3115	Test	01	Test
75	3116	Test	01	Test
76	3117	Test	01	Test
77	3118	Test	01	Test
78	3119	Test	01	Test
111	3152	Test	01	Test
112	3153	Test	01	Test
113	3154	Test	01	Test
114	3155	Test	01	Test
115	3156	Test	01	Test
116	3157	Test	01	Test
117	3158	Test	01	Test
118	3159	Test	01	Test
119	3160	Test	01	Test
120	3161	Test	01	Test
121	3162	Test	01	Test
122	3163	Test	01	Test
123	3164	Test	01	Test
124	3165	Test	01	Test
125	3166	Test	01	Test
126	3167	Test	01	Test
127	3168	Test	01	Test
128	3169	Test	01	Test
129	3170	Test	01	Test
130	3171	Test	01	Test
131	3172	Test	01	Test
132	3173	Test	01	Test
133	3174	Test	01	Test
134	3175	Test	01	Test
135	3176	Test	01	Test
136	3177	Test	01	Test
137	3178	Test	01	Test
138	3179	Test	01	Test
139	3180	Test	01	Test
140	3181	Test	01	Test
141	3182	Test	01	Test
142	3183	Test	01	Test
143	3184	Test	01	Test
144	3185	Test	01	Test
145	3186	Test	01	Test
146	3187	Test	01	Test
147	3188	Test	01	Test
148	3189	Test	01	Test
149	3190	Test	01	Test
150	3191	Test	01	Test
151	3192	Test	01	Test
152	3193	Test	01	Test
153	3194	Test	01	Test
154	3195	Test	01	Test
155	3196	Test	01	Test
156	3197	Test	01	Test
157	3198	Test	01	Test
158	3199	Test	01	Test
159	3200	Test	01	Test
160	3201	Test	01	Test
161	3202	Test	01	Test
162	3203	Test	01	Test
163	3204	Test	01	Test
164	3205	Test	01	Test
165	3206	Test	01	Test
166	3207	Test	01	Test
167	3208	Test	01	Test
168	3209	Test	01	Test
169	3210	Test	01	Test
170	3216	Test	01	Test
171	3217	Test	01	Test
172	3218	Test	01	Test
173	3220	Test	01	Test
174	3222	Test	01	Test
175	3223	Test	01	Test
176	3224	Test	01	Test
177	3225	Test	01	Test
178	3226	Test	01	Test
179	3227	Test	01	Test
180	3228	Test	01	Test
181	3229	Test	01	Test
182	3230	Test	01	Test
183	3231	Test	01	Test
184	3232	Test	01	Test
185	3233	Test	01	Test
186	3234	Test	01	Test
187	3235	Test	01	Test
188	3236	Test	01	Test
189	3237	Test	01	Test
190	3238	Test	01	Test
191	3239	Test	01	Test
192	3240	Test	01	Test
193	3241	Test	01	Test
194	3242	Test	01	Test
195	3243	Test	01	Test
196	3244	Test	01	Test
197	3245	Test	01	Test
198	3246	Test	01	Test
199	3247	Test	01	Test
200	3248	Test	01	Test
201	3249	Test	01	Test
202	3250	Test	01	Test
203	3251	Test	01	Test
204	3252	Test	01	Test
205	3253	Test	01	Test
206	3254	Test	01	Test
207	3255	Test	01	Test
208	3256	Test	01	Test
209	3257	Test	01	Test
210	3259	Test	01	Test
211	3260	Test	01	Test
212	3261	Test	01	Test
213	3268	Test	01	Test
214	3269	Test	01	Test
215	3271	Test	01	Test
216	3272	Test	01	Test
\.


--
-- Data for Name: party_risk; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.party_risk (party_risk_id, party_id, risk_type_code, risk_score, evaluation_date, valid_until) FROM stdin;
44	3043	01	11	2090-04-02 00:00:00	2098-03-20 00:00:00
45	3045	01	11	2090-04-02 00:00:00	2098-03-20 00:00:00
46	3046	01	11	2090-04-02 00:00:00	2098-03-20 00:00:00
47	3047	01	11	2090-04-02 00:00:00	2098-03-20 00:00:00
48	3048	01	11	2090-04-02 00:00:00	2098-03-20 00:00:00
49	3049	01	11	2090-04-02 00:00:00	2098-03-20 00:00:00
50	3050	01	11	2090-04-02 00:00:00	2098-03-20 00:00:00
51	3052	01	11	2090-04-02 00:00:00	2098-03-20 00:00:00
52	3056	01	11	2090-04-02 00:00:00	2098-03-20 00:00:00
53	3057	01	11	2090-04-02 00:00:00	2098-03-20 00:00:00
54	3058	01	11	2090-04-02 00:00:00	2098-03-20 00:00:00
55	3059	01	11	2090-04-02 00:00:00	2098-03-20 00:00:00
56	3060	01	11	2090-04-02 00:00:00	2098-03-20 00:00:00
57	3061	01	11	2090-04-02 00:00:00	2098-03-20 00:00:00
58	3062	01	11	2090-04-02 00:00:00	2098-03-20 00:00:00
59	3076	01	11	2090-04-02 00:00:00	2098-03-20 00:00:00
60	3077	01	11	2090-04-02 00:00:00	2098-03-20 00:00:00
61	3078	01	11	2090-04-02 00:00:00	2098-03-20 00:00:00
62	3094	01	11	2090-04-02 00:00:00	2098-03-20 00:00:00
63	3095	01	11	2090-04-02 00:00:00	2098-03-20 00:00:00
64	3100	01	11	2090-04-02 00:00:00	2098-03-20 00:00:00
65	3101	01	11	2090-04-02 00:00:00	2098-03-20 00:00:00
66	3102	01	11	2090-04-02 00:00:00	2098-03-20 00:00:00
67	3103	01	11	2090-04-02 00:00:00	2098-03-20 00:00:00
68	3105	01	11	2090-04-02 00:00:00	2098-03-20 00:00:00
69	3106	01	11	2090-04-02 00:00:00	2098-03-20 00:00:00
70	3107	01	11	2090-04-02 00:00:00	2098-03-20 00:00:00
71	3108	01	11	2090-04-02 00:00:00	2098-03-20 00:00:00
72	3109	01	11	2090-04-02 00:00:00	2098-03-20 00:00:00
73	3113	01	98765	2030-12-12 00:00:00	2030-12-12 00:00:00
74	3114	01	98765	2030-12-12 00:00:00	2030-12-12 00:00:00
75	3115	01	98765	2030-12-12 00:00:00	2030-12-12 00:00:00
76	3116	01	98765	2030-12-12 00:00:00	2030-12-12 00:00:00
77	3117	01	98765	2030-12-12 00:00:00	2030-12-12 00:00:00
78	3118	01	98765	2030-12-12 00:00:00	2030-12-12 00:00:00
79	3119	01	98765	2030-12-12 00:00:00	2030-12-12 00:00:00
112	3152	01	98765	2030-12-12 00:00:00	2030-12-12 00:00:00
113	3153	01	98765	2030-12-12 00:00:00	2030-12-12 00:00:00
114	3154	01	98765	2030-12-12 00:00:00	2030-12-12 00:00:00
115	3155	01	98765	2030-12-12 00:00:00	2030-12-12 00:00:00
116	3156	01	98765	2030-12-12 00:00:00	2030-12-12 00:00:00
117	3157	01	98765	2030-12-12 00:00:00	2030-12-12 00:00:00
118	3158	01	98765	2030-12-12 00:00:00	2030-12-12 00:00:00
119	3159	01	98765	2030-12-12 00:00:00	2030-12-12 00:00:00
120	3160	01	98765	2030-12-12 00:00:00	2030-12-12 00:00:00
121	3161	01	98765	2030-12-12 00:00:00	2030-12-12 00:00:00
122	3162	01	98765	2030-12-12 00:00:00	2030-12-12 00:00:00
123	3163	01	98765	2030-12-12 00:00:00	2030-12-12 00:00:00
124	3164	01	98765	2030-12-12 00:00:00	2030-12-12 00:00:00
125	3165	01	98765	2030-12-12 00:00:00	2030-12-12 00:00:00
126	3166	01	98765	2030-12-12 00:00:00	2030-12-12 00:00:00
127	3167	01	98765	2030-12-12 00:00:00	2030-12-12 00:00:00
128	3168	01	98765	2030-12-12 00:00:00	2030-12-12 00:00:00
129	3169	01	98765	2030-12-12 00:00:00	2030-12-12 00:00:00
130	3170	01	98765	2030-12-12 00:00:00	2030-12-12 00:00:00
131	3171	01	98765	2030-12-12 00:00:00	2030-12-12 00:00:00
132	3172	01	98765	2030-12-12 00:00:00	2030-12-12 00:00:00
133	3173	01	98765	2030-12-12 00:00:00	2030-12-12 00:00:00
134	3174	01	98765	2030-12-12 00:00:00	2030-12-12 00:00:00
135	3175	01	98765	2030-12-12 00:00:00	2030-12-12 00:00:00
136	3176	01	98765	2030-12-12 00:00:00	2030-12-12 00:00:00
137	3177	01	98765	2030-12-12 00:00:00	2030-12-12 00:00:00
138	3178	01	98765	2030-12-12 00:00:00	2030-12-12 00:00:00
139	3179	01	98765	2030-12-12 00:00:00	2030-12-12 00:00:00
140	3180	01	98765	2030-12-12 00:00:00	2030-12-12 00:00:00
141	3181	01	98765	2030-12-12 00:00:00	2030-12-12 00:00:00
142	3182	01	98765	2030-12-12 00:00:00	2030-12-12 00:00:00
143	3183	01	98765	2030-12-12 00:00:00	2030-12-12 00:00:00
144	3184	01	98765	2030-12-12 00:00:00	2030-12-12 00:00:00
145	3185	01	98765	2030-12-12 00:00:00	2030-12-12 00:00:00
146	3186	01	98765	2030-12-12 00:00:00	2030-12-12 00:00:00
147	3187	01	98765	2030-12-12 00:00:00	2030-12-12 00:00:00
148	3188	01	98765	2030-12-12 00:00:00	2030-12-12 00:00:00
149	3189	01	98765	2030-12-12 00:00:00	2030-12-12 00:00:00
150	3190	01	98765	2030-12-12 00:00:00	2030-12-12 00:00:00
151	3191	01	98765	2030-12-12 00:00:00	2030-12-12 00:00:00
152	3192	01	98765	2030-12-12 00:00:00	2030-12-12 00:00:00
153	3193	01	98765	2030-12-12 00:00:00	2030-12-12 00:00:00
154	3194	01	98765	2030-12-12 00:00:00	2030-12-12 00:00:00
155	3195	01	98765	2030-12-12 00:00:00	2030-12-12 00:00:00
156	3196	01	98765	2030-12-12 00:00:00	2030-12-12 00:00:00
157	3197	01	98765	2030-12-12 00:00:00	2030-12-12 00:00:00
158	3198	01	98765	2030-12-12 00:00:00	2030-12-12 00:00:00
159	3199	01	98765	2030-12-12 00:00:00	2030-12-12 00:00:00
160	3200	01	98765	2030-12-12 00:00:00	2030-12-12 00:00:00
161	3201	01	98765	2030-12-12 00:00:00	2030-12-12 00:00:00
162	3202	01	98765	2030-12-12 00:00:00	2030-12-12 00:00:00
163	3203	01	98765	2030-12-12 00:00:00	2030-12-12 00:00:00
164	3204	01	98765	2030-12-12 00:00:00	2030-12-12 00:00:00
165	3205	01	98765	2030-12-12 00:00:00	2030-12-12 00:00:00
166	3206	01	98765	2030-12-12 00:00:00	2030-12-12 00:00:00
167	3207	01	98765	2030-12-12 00:00:00	2030-12-12 00:00:00
168	3208	01	98765	2030-12-12 00:00:00	2030-12-12 00:00:00
169	3209	01	98765	2030-12-12 00:00:00	2030-12-12 00:00:00
170	3210	01	98765	2030-12-12 00:00:00	2030-12-12 00:00:00
171	3216	01	98765	2030-12-12 00:00:00	2030-12-12 00:00:00
172	3217	01	98765	2030-12-12 00:00:00	2030-12-12 00:00:00
173	3218	01	98765	2030-12-12 00:00:00	2030-12-12 00:00:00
174	3220	01	98765	2030-12-12 00:00:00	2030-12-12 00:00:00
175	3222	01	98765	2030-12-12 00:00:00	2030-12-12 00:00:00
176	3223	01	98765	2030-12-12 00:00:00	2030-12-12 00:00:00
177	3224	01	98765	2030-12-12 00:00:00	2030-12-12 00:00:00
178	3225	01	98765	2030-12-12 00:00:00	2030-12-12 00:00:00
179	3226	01	98765	2030-12-12 00:00:00	2030-12-12 00:00:00
180	3227	01	98765	2030-12-12 00:00:00	2030-12-12 00:00:00
181	3228	01	98765	2030-12-12 00:00:00	2030-12-12 00:00:00
182	3229	01	98765	2030-12-12 00:00:00	2030-12-12 00:00:00
183	3230	01	98765	2030-12-12 00:00:00	2030-12-12 00:00:00
184	3231	01	98765	2030-12-12 00:00:00	2030-12-12 00:00:00
185	3232	01	98765	2030-12-12 00:00:00	2030-12-12 00:00:00
186	3233	01	98765	2030-12-12 00:00:00	2030-12-12 00:00:00
187	3234	01	98765	2030-12-12 00:00:00	2030-12-12 00:00:00
188	3235	01	98765	2030-12-12 00:00:00	2030-12-12 00:00:00
189	3236	01	98765	2030-12-12 00:00:00	2030-12-12 00:00:00
190	3237	01	98765	2030-12-12 00:00:00	2030-12-12 00:00:00
191	3238	01	98765	2030-12-12 00:00:00	2030-12-12 00:00:00
192	3239	01	98765	2030-12-12 00:00:00	2030-12-12 00:00:00
193	3240	01	98765	2030-12-12 00:00:00	2030-12-12 00:00:00
194	3241	01	98765	2030-12-12 00:00:00	2030-12-12 00:00:00
195	3242	01	98765	2030-12-12 00:00:00	2030-12-12 00:00:00
196	3243	01	98765	2030-12-12 00:00:00	2030-12-12 00:00:00
197	3244	01	98765	2030-12-12 00:00:00	2030-12-12 00:00:00
198	3245	01	98765	2030-12-12 00:00:00	2030-12-12 00:00:00
199	3246	01	98765	2030-12-12 00:00:00	2030-12-12 00:00:00
200	3247	01	98765	2030-12-12 00:00:00	2030-12-12 00:00:00
201	3248	01	98765	2030-12-12 00:00:00	2030-12-12 00:00:00
202	3249	01	98765	2030-12-12 00:00:00	2030-12-12 00:00:00
203	3250	01	98765	2030-12-12 00:00:00	2030-12-12 00:00:00
204	3251	01	98765	2030-12-12 00:00:00	2030-12-12 00:00:00
205	3252	01	98765	2030-12-12 00:00:00	2030-12-12 00:00:00
206	3253	01	98765	2030-12-12 00:00:00	2030-12-12 00:00:00
207	3254	01	98765	2030-12-12 00:00:00	2030-12-12 00:00:00
208	3255	01	98765	2030-12-12 00:00:00	2030-12-12 00:00:00
209	3256	01	98765	2030-12-12 00:00:00	2030-12-12 00:00:00
210	3257	01	98765	2030-12-12 00:00:00	2030-12-12 00:00:00
211	3259	01	98765	2030-12-12 00:00:00	2030-12-12 00:00:00
212	3260	01	98765	2030-12-12 00:00:00	2030-12-12 00:00:00
213	3261	01	98765	2030-12-12 00:00:00	2030-12-12 00:00:00
219	3268	01	98765	2030-12-12 00:00:00	2030-12-12 00:00:00
220	3269	01	98765	2030-12-12 00:00:00	2030-12-12 00:00:00
221	3271	01	98765	2030-12-12 00:00:00	2030-12-12 00:00:00
222	3272	01	98765	2030-12-12 00:00:00	2030-12-12 00:00:00
\.


--
-- Data for Name: party_xref; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.party_xref (party_xref_id, party_id, system_code, xref_id) FROM stdin;
4	3003	01	11
5	3004	01	11
6	3005	01	11
7	3006	01	11
8	3007	01	11
9	3008	01	11
10	3009	01	11
11	3010	01	11
12	3011	01	11
13	3012	01	11
14	3013	01	11
15	3014	01	11
16	3015	01	11
17	3016	01	11
18	3017	01	11
19	3018	01	11
20	3019	01	11
21	3020	01	11
22	3021	01	11
23	3022	01	11
24	3023	01	11
25	3024	01	11
26	3025	01	11
27	3026	01	11
29	3028	01	11
43	3043	01	11
44	3045	01	11
45	3046	01	11
46	3047	01	11
47	3048	01	11
48	3050	APPIAN	24
49	3050	TM	7ead956f-86c2-4508-8ef8-e97e973407ee
50	3003	TM	\N
51	3003	APPIAN	25
52	3003	TM	\N
53	3003	APPIAN	25
54	3003	TM	\N
55	3051	APPIAN	26
56	3051	TM	58294fcd-decf-4661-92db-b00fc840c7dd
57	3003	APPIAN	25
58	3003	TM	\N
59	3003	APPIAN	25
60	3003	TM	\N
61	3003	APPIAN	25
62	3003	TM	\N
63	3010	APPIAN	27
64	3003	APPIAN	25
65	3003	TM	\N
66	3019	TM	\N
67	3052	APPIAN	28
68	3052	TM	b4fea2d1-760d-4606-9308-ccb2bd1c6bc4
69	3053	APPIAN	29
70	3053	TM	5144f851-0bff-4dfa-98d8-5b4634ff9f1f
71	3053	APPIAN	29
72	3053	TM	5144f851-0bff-4dfa-98d8-5b4634ff9f1f
73	3054	APPIAN	30
74	3054	TM	1c0915d4-d8b7-41de-801f-7e3891261f7c
75	3055	APPIAN	31
76	3003	APPIAN	25
77	3003	TM	\N
78	3054	APPIAN	30
79	3054	TM	1c0915d4-d8b7-41de-801f-7e3891261f7c
80	3053	APPIAN	29
81	3053	TM	5144f851-0bff-4dfa-98d8-5b4634ff9f1f
82	3052	APPIAN	28
83	3052	TM	b4fea2d1-760d-4606-9308-ccb2bd1c6bc4
84	3052	APPIAN	28
85	3052	TM	b4fea2d1-760d-4606-9308-ccb2bd1c6bc4
86	3052	APPIAN	28
87	3052	TM	b4fea2d1-760d-4606-9308-ccb2bd1c6bc4
88	3019	APPIAN	32
89	3019	TM	\N
90	3052	APPIAN	28
91	3052	TM	b4fea2d1-760d-4606-9308-ccb2bd1c6bc4
92	3052	APPIAN	28
93	3052	TM	b4fea2d1-760d-4606-9308-ccb2bd1c6bc4
94	3052	APPIAN	28
95	3052	TM	b4fea2d1-760d-4606-9308-ccb2bd1c6bc4
96	3056	APPIAN	35
97	3056	TM	\N
98	3057	APPIAN	36
99	3057	TM	\N
100	3054	APPIAN	30
101	3054	TM	\N
102	3054	APPIAN	30
103	3054	TM	\N
104	3054	APPIAN	\N
105	3054	TM	\N
106	3054	APPIAN	\N
107	3054	TM	\N
108	3058	APPIAN	\N
109	3058	TM	\N
110	3059	APPIAN	\N
111	3059	TM	\N
112	3060	APPIAN	\N
113	3060	TM	\N
114	3061	APPIAN	\N
115	3061	TM	\N
116	3062	APPIAN	\N
117	3062	TM	58818607-d870-4565-aded-586472186207
118	3063	APPIAN	\N
119	3063	TM	a431862d-7c9c-4cc4-826e-8665585d656e
120	3064	APPIAN	\N
121	3064	TM	6c0ff053-c2a5-4ffa-b50f-ecf8e4d60e9f
122	3065	APPIAN	\N
123	3066	APPIAN	\N
124	3066	TM	31e5e0c4-4a5a-44ff-8bb4-f8f7c861fc52
125	3067	APPIAN	\N
126	3066	APPIAN	\N
127	3066	TM	31e5e0c4-4a5a-44ff-8bb4-f8f7c861fc52
128	3068	APPIAN	\N
129	3068	TM	89983025-c27f-431c-a66f-d952e8cd3e33
130	3069	APPIAN	\N
131	3069	TM	f9f2b657-ea78-4422-9d03-78c33478303f
132	3070	APPIAN	\N
133	3070	TM	71c3519d-5380-46e8-a457-71e091e632d2
134	3071	APPIAN	\N
135	3071	TM	e611af51-6d3a-4e33-9df1-ae53dbcfd532
136	3072	APPIAN	\N
137	3072	TM	cb257244-7216-4160-ab5c-c979604683c3
138	3073	APPIAN	\N
139	3073	TM	\N
140	3074	APPIAN	\N
141	3074	TM	13398561-7718-47d2-ad74-289ecf1cf2f1
142	3073	TM	b41f550c-3637-4c14-93ff-668b12538898
143	3102	APPIAN	\N
144	3102	TM	1cf2355d-c4e7-451c-a51a-3a9718877b3e
145	3102	TM	1cf2355d-c4e7-451c-a51a-3a9718877b3e
146	3102	TM	1cf2355d-c4e7-451c-a51a-3a9718877b3e
147	3102	APPIAN	\N
148	3102	TM	1cf2355d-c4e7-451c-a51a-3a9718877b3e
149	3102	TM	1cf2355d-c4e7-451c-a51a-3a9718877b3e
150	3070	TM	71c3519d-5380-46e8-a457-71e091e632d2
151	3070	TM	71c3519d-5380-46e8-a457-71e091e632d2
152	3072	TM	cb257244-7216-4160-ab5c-c979604683c3
153	3072	TM	cb257244-7216-4160-ab5c-c979604683c3
154	3102	TM	1cf2355d-c4e7-451c-a51a-3a9718877b3e
155	3102	TM	1cf2355d-c4e7-451c-a51a-3a9718877b3e
156	3102	APPIAN	\N
157	3102	TM	1cf2355d-c4e7-451c-a51a-3a9718877b3e
158	3102	APPIAN	\N
159	3102	TM	1cf2355d-c4e7-451c-a51a-3a9718877b3e
160	3102	APPIAN	\N
161	3102	TM	1cf2355d-c4e7-451c-a51a-3a9718877b3e
162	3072	TM	cb257244-7216-4160-ab5c-c979604683c3
163	3072	TM	cb257244-7216-4160-ab5c-c979604683c3
164	3070	TM	71c3519d-5380-46e8-a457-71e091e632d2
165	3070	TM	71c3519d-5380-46e8-a457-71e091e632d2
166	3072	TM	cb257244-7216-4160-ab5c-c979604683c3
167	3072	TM	cb257244-7216-4160-ab5c-c979604683c3
168	3096	TM	32d0dc12-38ef-482d-a06d-d5a897560df0
169	3096	TM	32d0dc12-38ef-482d-a06d-d5a897560df0
170	3103	APPIAN	\N
171	3103	TM	a9fa4ffa-1b3c-4792-820b-9f42dd8f8bb6
172	3096	TM	32d0dc12-38ef-482d-a06d-d5a897560df0
173	3096	TM	32d0dc12-38ef-482d-a06d-d5a897560df0
174	3096	TM	32d0dc12-38ef-482d-a06d-d5a897560df0
175	3096	TM	32d0dc12-38ef-482d-a06d-d5a897560df0
176	3104	APPIAN	\N
177	3104	TM	bdeb92ce-f97f-4ac7-9232-49aa2eaa1dce
178	3072	TM	cb257244-7216-4160-ab5c-c979604683c3
179	3072	TM	cb257244-7216-4160-ab5c-c979604683c3
180	3072	TM	cb257244-7216-4160-ab5c-c979604683c3
181	3072	TM	cb257244-7216-4160-ab5c-c979604683c3
182	3105	APPIAN	\N
183	3105	TM	1234578810
184	3106	APPIAN	\N
185	3106	TM	1234578811
186	3096	APPIAN	\N
187	3096	TM	32d0dc12-38ef-482d-a06d-d5a897560df0
188	3096	APPIAN	\N
189	3096	TM	32d0dc12-38ef-482d-a06d-d5a897560df0
190	3107	APPIAN	\N
191	3107	TM	1234578855
192	3108	APPIAN	\N
193	3108	TM	WPQPqwMNQEVLk-f4MHPy6xclSMD
194	3109	APPIAN	\N
195	3109	TM	1234578858
196	3110	APPIAN	\N
197	3110	TM	b4ff60c2-eca8-48be-ad11-7fe410b3c7ff
198	3096	APPIAN	\N
199	3096	TM	32d0dc12-38ef-482d-a06d-d5a897560df0
200	3096	APPIAN	\N
201	3096	TM	32d0dc12-38ef-482d-a06d-d5a897560df0
202	3097	APPIAN	\N
203	3112	APPIAN	\N
204	3112	TM	5508ae1d-bdf2-43ae-a351-527e7ee97ab2
205	3097	APPIAN	\N
206	3097	TM	27efd8c0-7cca-4f59-b78f-7eda158e9994
207	3070	TM	71c3519d-5380-46e8-a457-71e091e632d2
208	3097	APPIAN	\N
209	3070	TM	71c3519d-5380-46e8-a457-71e091e632d2
210	3097	APPIAN	\N
211	3097	TM	27efd8c0-7cca-4f59-b78f-7eda158e9994
212	3097	APPIAN	\N
213	3097	TM	27efd8c0-7cca-4f59-b78f-7eda158e9994
214	3097	APPIAN	\N
215	3097	TM	27efd8c0-7cca-4f59-b78f-7eda158e9994
216	3097	APPIAN	\N
217	3097	TM	27efd8c0-7cca-4f59-b78f-7eda158e9994
218	3097	APPIAN	\N
219	3097	APPIAN	\N
220	3097	TM	27efd8c0-7cca-4f59-b78f-7eda158e9994
221	3097	APPIAN	\N
222	3097	TM	27efd8c0-7cca-4f59-b78f-7eda158e9994
223	3097	APPIAN	\N
224	3097	TM	27efd8c0-7cca-4f59-b78f-7eda158e9994
225	3097	APPIAN	\N
226	3097	TM	27efd8c0-7cca-4f59-b78f-7eda158e9994
227	3096	APPIAN	\N
228	3096	TM	32d0dc12-38ef-482d-a06d-d5a897560df0
229	3097	APPIAN	\N
230	3097	TM	27efd8c0-7cca-4f59-b78f-7eda158e9994
231	3097	APPIAN	\N
232	3097	TM	27efd8c0-7cca-4f59-b78f-7eda158e9994
233	3113	APPIAN	\N
234	3113	TM	6jxmnt3eWn5p
235	3114	APPIAN	\N
236	3114	TM	DmHvkMrjH8uO
237	3115	APPIAN	\N
238	3115	TM	ax2KKf1VDzlL
239	3097	APPIAN	\N
240	3097	TM	27efd8c0-7cca-4f59-b78f-7eda158e9994
241	3097	APPIAN	\N
242	3097	TM	27efd8c0-7cca-4f59-b78f-7eda158e9994
243	3070	TM	71c3519d-5380-46e8-a457-71e091e632d2
244	3070	TM	71c3519d-5380-46e8-a457-71e091e632d2
245	3070	APPIAN	\N
246	3070	TM	71c3519d-5380-46e8-a457-71e091e632d2
247	3116	APPIAN	\N
248	3116	TM	z4SXOJOKdAQL
249	3096	TM	32d0dc12-38ef-482d-a06d-d5a897560df0
250	3117	APPIAN	\N
251	3117	TM	vHWVzbnB7A0Y
252	3118	APPIAN	\N
253	3118	TM	CZP7JDvJDPep
254	3119	APPIAN	\N
255	3119	TM	VWgGv4XUk02y
287	3152	APPIAN	\N
288	3152	TM	AmJIyOZbvdjM
289	3153	APPIAN	\N
290	3153	TM	CnTrz79AnAcZ
291	3154	APPIAN	\N
292	3154	TM	1gVubk8Cy4SV
293	3155	APPIAN	\N
294	3155	TM	jRD4N9VybVvs
295	3156	APPIAN	\N
296	3157	APPIAN	\N
297	3157	TM	cVB0d0yNrLd0
298	3158	APPIAN	\N
299	3158	TM	mgYJPPftQfEL
300	3159	APPIAN	\N
301	3159	TM	d6QMsSgHIRZZ
302	3160	APPIAN	\N
303	3160	TM	2K0NzxrKS0vZ
304	3161	APPIAN	\N
305	3161	TM	nGVvT3xblLLj
306	3162	APPIAN	\N
307	3162	TM	JJl8PmuGh1Nw
308	3163	APPIAN	\N
309	3163	TM	aZbTa0PNBw4w
310	3164	APPIAN	\N
311	3164	TM	csbZtNCSq1AF
312	3165	APPIAN	\N
313	3165	TM	2jkUtXL3mdfQ
314	3166	APPIAN	\N
315	3166	TM	CVDd9dlPFN3f
316	3167	APPIAN	\N
317	3167	TM	TDO6IZSlVnav
318	3168	APPIAN	\N
319	3168	TM	rNdD22wm19kX
320	3169	APPIAN	\N
321	3169	TM	g3H9rlMMhLsB
322	3170	APPIAN	\N
323	3170	TM	GvHxAUqqKVGK
324	3171	APPIAN	\N
325	3171	TM	usI3ecROiNwy
326	3172	APPIAN	\N
327	3172	TM	SnXpemvCbV5I
328	3173	APPIAN	\N
329	3173	TM	raXL6ROuFkvz
330	3174	APPIAN	\N
331	3174	TM	Fh8iSO39OMoJ
332	3175	APPIAN	\N
333	3175	TM	eHdXHmGl7DhG
334	3176	APPIAN	\N
335	3176	TM	Bh9QxbvHyVRz
336	3177	APPIAN	\N
337	3177	TM	tHiv9I58y83a
338	3178	APPIAN	\N
339	3178	TM	iplz8s4NUQFF
340	3179	APPIAN	\N
341	3179	TM	MYSEnqWnXuD6
342	3180	APPIAN	\N
343	3180	TM	02Oi9T4pbo2g
344	3181	APPIAN	\N
345	3181	TM	WXTW9yZ4w637
346	3182	APPIAN	\N
347	3182	TM	FmkKtTYJjheO
348	3183	APPIAN	\N
349	3183	TM	bPYKNU3NB1wj
350	3184	APPIAN	\N
351	3184	TM	rhzDOrsEAmjv
352	3185	APPIAN	\N
353	3185	TM	tfwRChHJqpPX
354	3186	APPIAN	\N
355	3186	TM	arP5SY0FV78R
356	3187	APPIAN	\N
357	3187	TM	7364SwZX2pHu
358	3189	APPIAN	\N
359	3188	APPIAN	\N
360	3189	TM	uATwF0uPthQk
361	3188	TM	OyY9ZoW1OwII
362	3190	APPIAN	\N
363	3190	TM	MagTLbDDoAm4
364	3191	APPIAN	\N
365	3191	TM	VOPNpkw30WTd
366	3192	APPIAN	\N
367	3192	TM	Qeu41vCPSW6C
368	3193	APPIAN	\N
369	3193	TM	P3UqZ3neVUI8
370	3200	APPIAN	\N
371	3200	TM	PIWYLpniZwWx
372	3201	APPIAN	\N
373	3201	TM	BIAx9yCEZ4Rv
374	3202	APPIAN	\N
375	3202	TM	is3Fd6hFNPvv
376	3203	APPIAN	\N
377	3203	TM	bJDblATAnPcQ
378	3204	APPIAN	\N
379	3204	TM	mE72ZEy7xdjY
380	3205	APPIAN	\N
381	3205	TM	FG99U9BPgsws
382	3206	APPIAN	\N
383	3206	TM	jBuOrfihvXlF
384	3096	APPIAN	\N
385	3096	TM	32d0dc12-38ef-482d-a06d-d5a897560df0
386	3096	APPIAN	\N
387	3096	TM	32d0dc12-38ef-482d-a06d-d5a897560df0
388	3211	APPIAN	\N
389	3211	TM	da44b827-ae47-4d48-8481-f0e5193eb8b6
390	3212	APPIAN	\N
391	3212	TM	70a3470e-022d-4fa8-903d-99c4c44ef8fd
392	3213	APPIAN	\N
393	3213	TM	0caa5166-3730-41dc-aaa5-d959db760c0e
394	3096	APPIAN	\N
395	3096	TM	32d0dc12-38ef-482d-a06d-d5a897560df0
396	3096	APPIAN	\N
397	3096	TM	32d0dc12-38ef-482d-a06d-d5a897560df0
398	3214	APPIAN	\N
399	3214	TM	c5e7dae3-d089-437a-84b4-e9ef22f984d9
400	3215	APPIAN	\N
401	3215	TM	3aa496eb-f007-49ae-8bde-e3f284a9c8a2
402	3216	APPIAN	\N
403	3216	TM	uo4MWynFEiXL
404	3217	TM	yFjAgD3ef45Z
405	3218	TM	3mykipGY5Y4q
406	3096	TM	32d0dc12-38ef-482d-a06d-d5a897560df0
407	3219	APPIAN	\N
408	3219	TM	cb1ada67-6e36-4d34-b493-195b661f5bb4
409	3220	APPIAN	\N
410	3220	TM	JjO6fBcQTQIM
411	3221	APPIAN	\N
412	3221	TM	c9026fb8-f68c-43a0-a7fe-42bfa3f6089e
413	3224	APPIAN	\N
414	3224	TM	WBpGknWgwst2
415	3225	APPIAN	\N
416	3225	TM	MjH8goc7pOl2
417	3226	APPIAN	\N
418	3226	TM	Q8mO9wkQRf9o
419	3227	APPIAN	\N
420	3227	TM	ac0hkSpFo4Kz
421	3228	APPIAN	\N
422	3228	TM	FY8EMSsVwbgR
423	3229	APPIAN	\N
424	3229	TM	xNbXCshCpurg
425	3234	APPIAN	\N
426	3234	TM	71KaIS7Xh9IG
427	3235	APPIAN	\N
428	3235	TM	6f84EAgyoaQ7
429	3236	APPIAN	\N
430	3236	TM	M5BdmqAuWjaB
431	3237	APPIAN	\N
432	3237	TM	ODicSMAwio8r
433	3238	APPIAN	\N
434	3238	TM	AoceZNK0Rg9J
435	3239	APPIAN	\N
436	3239	TM	Y1QEnKZcxNeu
437	3240	APPIAN	\N
438	3240	TM	Ljb6L9fcXz1h
439	3241	APPIAN	\N
440	3241	TM	BI7I4wK4tbaf
441	3242	APPIAN	\N
442	3242	TM	CmLJgi4ph50M
443	3243	APPIAN	\N
444	3243	TM	f1tgtCGHT1By
453	3248	APPIAN	\N
454	3248	TM	PknDiF2zV9gf
445	3244	APPIAN	\N
446	3244	TM	yXOoi9DUjec7
447	3245	APPIAN	\N
448	3245	TM	54vIkEYXOljU
449	3246	APPIAN	\N
450	3246	TM	cvuB8EIxZ1um
451	3247	APPIAN	\N
452	3247	TM	tglGWy7RSiQF
455	3249	APPIAN	\N
456	3249	TM	0I1acMwqQMyA
457	3250	APPIAN	\N
458	3250	TM	9mu8SCjO1NJi
459	3251	APPIAN	\N
460	3251	TM	wT1kLN0WRFwu
461	3252	APPIAN	\N
462	3252	TM	ZnCKrAJow0Iz
463	3253	APPIAN	\N
464	3253	TM	rNMF4Oy3Utsv
465	3255	APPIAN	\N
466	3256	APPIAN	\N
467	3257	APPIAN	\N
468	3258	APPIAN	\N
469	3259	APPIAN	\N
470	3262	APPIAN	\N
471	3268	APPIAN	\N
472	3269	APPIAN	\N
473	3270	APPIAN	\N
474	3271	APPIAN	\N
475	3190	APPIAN	\N
476	3272	APPIAN	\N
477	3190	APPIAN	\N
478	3190	APPIAN	\N
479	3190	APPIAN	\N
480	3273	APPIAN	\N
481	3190	APPIAN	\N
\.


--
-- Name: address_master_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.address_master_id_seq', 102, true);


--
-- Name: country_master_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.country_master_id_seq', 34, true);


--
-- Name: lookup_master_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.lookup_master_id_seq', 317, true);


--
-- Name: party_account_mapping_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.party_account_mapping_id_seq', 47, true);


--
-- Name: party_address_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.party_address_id_seq', 361, true);


--
-- Name: party_asset_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.party_asset_id_seq', 221, true);


--
-- Name: party_contact_details_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.party_contact_details_id_seq', 243, true);


--
-- Name: party_document_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.party_document_id_seq', 243, true);


--
-- Name: party_fatca_details_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.party_fatca_details_id_seq', 222, true);


--
-- Name: party_guardian_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.party_guardian_id_seq', 216, true);


--
-- Name: party_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.party_id_seq', 3273, true);


--
-- Name: party_memo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.party_memo_id_seq', 223, true);


--
-- Name: party_relation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.party_relation_id_seq', 216, true);


--
-- Name: party_risk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.party_risk_id_seq', 222, true);


--
-- Name: party_xref_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.party_xref_id_seq', 481, true);


--
-- Name: address_master address_master_id_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.address_master
    ADD CONSTRAINT address_master_id_pkey PRIMARY KEY (address_master_id);


--
-- Name: country_master country_id_master_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.country_master
    ADD CONSTRAINT country_id_master_pkey PRIMARY KEY (country_master_id);


--
-- Name: databasechangeloglock databasechangeloglock_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.databasechangeloglock
    ADD CONSTRAINT databasechangeloglock_pkey PRIMARY KEY (id);


--
-- Name: lookup_master lookup_master_id_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lookup_master
    ADD CONSTRAINT lookup_master_id_pk PRIMARY KEY (lookup_master_id);


--
-- Name: party_address party_address_id_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.party_address
    ADD CONSTRAINT party_address_id_pkey PRIMARY KEY (party_address_id);


--
-- Name: party_asset party_asset_id_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.party_asset
    ADD CONSTRAINT party_asset_id_pkey PRIMARY KEY (party_asset_id);


--
-- Name: party_contact_details party_contact_channel_id_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.party_contact_details
    ADD CONSTRAINT party_contact_channel_id_pkey PRIMARY KEY (party_contact_details_id);


--
-- Name: party_document party_document_id_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.party_document
    ADD CONSTRAINT party_document_id_pkey PRIMARY KEY (party_document_id);


--
-- Name: party_fatca_details party_fatca_details_id_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.party_fatca_details
    ADD CONSTRAINT party_fatca_details_id_pkey PRIMARY KEY (party_fatca_details_id);


--
-- Name: party_guardian party_guardian_id_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.party_guardian
    ADD CONSTRAINT party_guardian_id_pkey PRIMARY KEY (party_guardian_id);


--
-- Name: party party_id_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.party
    ADD CONSTRAINT party_id_pkey PRIMARY KEY (party_id);


--
-- Name: party party_identifier_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.party
    ADD CONSTRAINT party_identifier_unique UNIQUE (party_identifier);


--
-- Name: party_memo party_memo_id_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.party_memo
    ADD CONSTRAINT party_memo_id_pkey PRIMARY KEY (party_memo_id);


--
-- Name: party_relation party_relation_id_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.party_relation
    ADD CONSTRAINT party_relation_id_pkey PRIMARY KEY (party_relation_id);


--
-- Name: party_risk party_risk_id_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.party_risk
    ADD CONSTRAINT party_risk_id_pkey PRIMARY KEY (party_risk_id);


--
-- Name: party_xref party_xref_id_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.party_xref
    ADD CONSTRAINT party_xref_id_pkey PRIMARY KEY (party_xref_id);


--
-- Name: idex_addess_master; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idex_addess_master ON public.address_master USING btree (type, code, is_active);


--
-- Name: idex_country_master; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idex_country_master ON public.country_master USING btree (code, isd_code, iso_code, is_active);


--
-- Name: idex_lookup_master; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idex_lookup_master ON public.lookup_master USING btree (type, code, is_active);


--
-- Name: party_contact_details fk_contact_party_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.party_contact_details
    ADD CONSTRAINT fk_contact_party_id FOREIGN KEY (party_id) REFERENCES public.party(party_id) ON DELETE CASCADE;


--
-- Name: party_address fk_party_address_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.party_address
    ADD CONSTRAINT fk_party_address_id FOREIGN KEY (party_id) REFERENCES public.party(party_id) ON DELETE CASCADE;


--
-- Name: party_asset fk_party_asset_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.party_asset
    ADD CONSTRAINT fk_party_asset_id FOREIGN KEY (party_id) REFERENCES public.party(party_id) ON DELETE CASCADE;


--
-- Name: party_document fk_party_document_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.party_document
    ADD CONSTRAINT fk_party_document_id FOREIGN KEY (party_id) REFERENCES public.party(party_id) ON DELETE CASCADE;


--
-- Name: party_fatca_details fk_party_fatca_details_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.party_fatca_details
    ADD CONSTRAINT fk_party_fatca_details_id FOREIGN KEY (party_id) REFERENCES public.party(party_id) ON DELETE CASCADE;


--
-- Name: party_guardian fk_party_guardian_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.party_guardian
    ADD CONSTRAINT fk_party_guardian_id FOREIGN KEY (party_id) REFERENCES public.party(party_id) ON DELETE CASCADE;


--
-- Name: party_memo fk_party_memo_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.party_memo
    ADD CONSTRAINT fk_party_memo_id FOREIGN KEY (party_id) REFERENCES public.party(party_id) ON DELETE CASCADE;


--
-- Name: party_relation fk_party_relation_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.party_relation
    ADD CONSTRAINT fk_party_relation_id FOREIGN KEY (party_id) REFERENCES public.party(party_id) ON DELETE CASCADE;


--
-- Name: party_risk fk_party_risk_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.party_risk
    ADD CONSTRAINT fk_party_risk_id FOREIGN KEY (party_id) REFERENCES public.party(party_id) ON DELETE CASCADE;


--
-- Name: party_xref fk_party_xref_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.party_xref
    ADD CONSTRAINT fk_party_xref_id FOREIGN KEY (party_id) REFERENCES public.party(party_id) ON DELETE CASCADE;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--


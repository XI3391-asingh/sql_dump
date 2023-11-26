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
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

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
-- Name: nominee_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.nominee_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.nominee_id_seq OWNER TO postgres;

--
-- Name: nominee; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.nominee (
    nominee_id bigint DEFAULT nextval('public.nominee_id_seq'::regclass) NOT NULL,
    party_id bigint NOT NULL,
    salutation_code character varying(50),
    first_name character varying(100),
    middle_name character varying(100),
    last_name character varying(100),
    relation_type_code character varying(50),
    national_id character varying(50)
);


ALTER TABLE public.nominee OWNER TO postgres;

--
-- Name: nominee_account_mapping_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.nominee_account_mapping_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.nominee_account_mapping_id_seq OWNER TO postgres;

--
-- Name: nominee_account_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.nominee_account_mapping (
    mapping_id bigint DEFAULT nextval('public.nominee_account_mapping_id_seq'::regclass) NOT NULL,
    party_id bigint NOT NULL,
    nominee_id bigint NOT NULL,
    account_number character varying(50) NOT NULL
);


ALTER TABLE public.nominee_account_mapping OWNER TO postgres;

--
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
raw	includeAll	db/001_NOMINEE_DDL.sql	2023-11-20 06:53:55.04242	1	EXECUTED	9:3a71c5004db8d3f0f98b30f3f07d2e4a	sql		\N	4.15.0	\N	\N	0463234905
\.


--
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
1	f	\N	\N
\.


--
-- Data for Name: nominee; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.nominee (nominee_id, party_id, salutation_code, first_name, middle_name, last_name, relation_type_code, national_id) FROM stdin;
1	1	01	Joe1	\N	Brandon1	01	01
\.


--
-- Data for Name: nominee_account_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.nominee_account_mapping (mapping_id, party_id, nominee_id, account_number) FROM stdin;
\.


--
-- Name: nominee_account_mapping_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.nominee_account_mapping_id_seq', 1, false);


--
-- Name: nominee_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.nominee_id_seq', 1, true);


--
-- Name: databasechangeloglock databasechangeloglock_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.databasechangeloglock
    ADD CONSTRAINT databasechangeloglock_pkey PRIMARY KEY (id);


--
-- Name: nominee_account_mapping mapping_id_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nominee_account_mapping
    ADD CONSTRAINT mapping_id_pkey PRIMARY KEY (mapping_id);


--
-- Name: nominee_account_mapping nominee_account_mapping_party_id_account_number_nominee_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nominee_account_mapping
    ADD CONSTRAINT nominee_account_mapping_party_id_account_number_nominee_id_key UNIQUE (party_id, account_number, nominee_id);


--
-- Name: nominee nominee_id_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nominee
    ADD CONSTRAINT nominee_id_pkey PRIMARY KEY (nominee_id);


--
-- Name: nominee_account_mapping fk_nominee_account_mapping_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nominee_account_mapping
    ADD CONSTRAINT fk_nominee_account_mapping_id FOREIGN KEY (nominee_id) REFERENCES public.nominee(nominee_id);


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--


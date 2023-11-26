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

--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: account; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.account (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    account_id character varying(100) NOT NULL,
    name character varying(100) NOT NULL,
    product_id character varying(100) NOT NULL,
    product_version_id character varying(100),
    stakeholder_ids text[] NOT NULL,
    amount double precision DEFAULT 0 NOT NULL,
    permitted_denominations text[] NOT NULL,
    status character varying(100) DEFAULT 'UNKNOWN'::character varying NOT NULL,
    instance_param_vals jsonb NOT NULL,
    derived_instance_param_vals jsonb,
    details jsonb NOT NULL,
    accounting jsonb NOT NULL,
    opening_timestamp timestamp with time zone DEFAULT (now() AT TIME ZONE 'utc'::text) NOT NULL,
    closing_timestamp timestamp with time zone,
    created_at timestamp with time zone DEFAULT (now() AT TIME ZONE 'utc'::text) NOT NULL,
    created_by character varying(100),
    modified_at timestamp with time zone,
    modified_by character varying(100)
);


ALTER TABLE public.account OWNER TO postgres;

--
-- Name: account_nominee_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.account_nominee_mapping (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    account_id character varying(100) NOT NULL,
    nominee_id character varying(100) NOT NULL,
    percentage double precision NOT NULL,
    is_active boolean DEFAULT true,
    created_at timestamp with time zone DEFAULT (now() AT TIME ZONE 'utc'::text),
    created_by character varying(100) DEFAULT 'SYSTEM'::character varying,
    modified_at timestamp with time zone,
    modified_by character varying(100)
);


ALTER TABLE public.account_nominee_mapping OWNER TO postgres;

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
-- Data for Name: account; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.account (id, account_id, name, product_id, product_version_id, stakeholder_ids, amount, permitted_denominations, status, instance_param_vals, derived_instance_param_vals, details, accounting, opening_timestamp, closing_timestamp, created_at, created_by, modified_at, modified_by) FROM stdin;
\.


--
-- Data for Name: account_nominee_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.account_nominee_mapping (id, account_id, nominee_id, percentage, is_active, created_at, created_by, modified_at, modified_by) FROM stdin;
\.


--
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
1	Manoj Kumar	db/changelog/account/master.yml	2023-08-18 08:39:23.433342	1	EXECUTED	8:d41d8cd98f00b204e9800998ecf8427e	empty		\N	4.20.0	\N	\N	2347963333
create-tables	Manoj Kumar	db/changelog/account/ddl/001_create_tables.sql	2023-08-18 08:39:23.637802	2	EXECUTED	8:0c837b5034b5e99b7d3b00d51e6fbde4	sql		\N	4.20.0	\N	\N	2347963333
create-index	Nitesh	db/changelog/account/ddl/001_create_tables.sql	2023-08-18 08:39:23.648246	3	EXECUTED	8:db35a672cdfc2ac8149885e55bf67b16	sql		\N	4.20.0	\N	\N	2347963333
\.


--
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
1	f	\N	\N
\.


--
-- Name: account account_account_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account
    ADD CONSTRAINT account_account_id_key UNIQUE (account_id);


--
-- Name: account account_id_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account
    ADD CONSTRAINT account_id_pkey PRIMARY KEY (id);


--
-- Name: account_nominee_mapping account_nominee_id_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_nominee_mapping
    ADD CONSTRAINT account_nominee_id_pkey PRIMARY KEY (id);


--
-- Name: databasechangeloglock databasechangeloglock_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.databasechangeloglock
    ADD CONSTRAINT databasechangeloglock_pkey PRIMARY KEY (id);


--
-- Name: account_nominee_unique_check; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX account_nominee_unique_check ON public.account_nominee_mapping USING btree (account_id, nominee_id);


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--


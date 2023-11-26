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
-- Name: otp_detail; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.otp_detail (
    id integer NOT NULL,
    mobile_number character varying(13) NOT NULL,
    otp_status character varying(30) NOT NULL,
    remaining_attempts_send integer NOT NULL,
    otp_expiration_time integer NOT NULL,
    remaining_attempts_verify integer NOT NULL,
    blocking_time integer NOT NULL,
    created_by character varying(30) NOT NULL,
    created_on timestamp without time zone NOT NULL,
    last_updated_by character varying(30) NOT NULL,
    last_updated_on timestamp without time zone NOT NULL
);


ALTER TABLE public.otp_detail OWNER TO postgres;

--
-- Name: otp_detail_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.otp_detail_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.otp_detail_id_seq OWNER TO postgres;

--
-- Name: otp_detail_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.otp_detail_id_seq OWNED BY public.otp_detail.id;


--
-- Name: otp_detail id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.otp_detail ALTER COLUMN id SET DEFAULT nextval('public.otp_detail_id_seq'::regclass);


--
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
1	finx	migrations.xml	2023-11-07 08:57:02.349024	1	EXECUTED	9:d37a720e5332bf5ac64a853f58ef7419	createTable tableName=otp_detail		\N	4.24.0	\N	\N	9347422235
2	finx	migrations.xml	2023-11-07 08:57:02.414017	2	EXECUTED	9:891668028bf83507045df006bc0cbb45	addAutoIncrement columnName=id, tableName=otp_detail		\N	4.24.0	\N	\N	9347422235
3	finx	migrations.xml	2023-11-07 08:57:02.43832	3	EXECUTED	9:295e6c6b6d316cb67e5004b28c2ed253	dropColumn columnName=otp, tableName=otp_detail		\N	4.24.0	\N	\N	9347422235
\.


--
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
1	f	\N	\N
\.


--
-- Data for Name: otp_detail; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.otp_detail (id, mobile_number, otp_status, remaining_attempts_send, otp_expiration_time, remaining_attempts_verify, blocking_time, created_by, created_on, last_updated_by, last_updated_on) FROM stdin;
\.


--
-- Name: otp_detail_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.otp_detail_id_seq', 1, false);


--
-- Name: databasechangeloglock databasechangeloglock_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.databasechangeloglock
    ADD CONSTRAINT databasechangeloglock_pkey PRIMARY KEY (id);


--
-- Name: otp_detail otp_detail_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.otp_detail
    ADD CONSTRAINT otp_detail_pkey PRIMARY KEY (id);


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--


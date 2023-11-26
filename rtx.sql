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
-- Name: cluster_master; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cluster_master (
    cluster_id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    cluster_name character varying(100) NOT NULL,
    nodes character varying(100) NOT NULL,
    ips character varying(100) NOT NULL,
    is_active boolean DEFAULT true,
    created_at timestamp with time zone DEFAULT now(),
    created_by character varying(100),
    updated_at timestamp with time zone,
    updated_by character varying(100)
);


ALTER TABLE public.cluster_master OWNER TO postgres;

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
-- Name: rule_additional_master; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rule_additional_master (
    rule_additional_id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    rule_id uuid,
    data jsonb NOT NULL,
    is_active boolean DEFAULT true,
    created_at timestamp with time zone DEFAULT now(),
    created_by character varying(100),
    updated_at timestamp with time zone,
    updated_by character varying(100)
);


ALTER TABLE public.rule_additional_master OWNER TO postgres;

--
-- Name: rule_deploy_master; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rule_deploy_master (
    rule_deploy_id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    rule_id uuid,
    rule_type character varying(200) NOT NULL,
    rt_deploy_time timestamp with time zone NOT NULL,
    rt_query_id character varying(200) NOT NULL,
    run_status character varying(200) NOT NULL,
    is_active boolean DEFAULT true,
    created_at timestamp with time zone DEFAULT now(),
    created_by character varying(100),
    updated_at timestamp with time zone,
    updated_by character varying(100)
);


ALTER TABLE public.rule_deploy_master OWNER TO postgres;

--
-- Name: rule_execution_master; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rule_execution_master (
    rule_execution_id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    rule_id uuid,
    cluster_id uuid,
    input_stream_name character varying NOT NULL,
    input_key character varying(200) NOT NULL,
    entity_id character varying(200) NOT NULL,
    input_timestamp_format character varying(200) NOT NULL,
    input_timestamp_tz character varying(200) NOT NULL,
    input_timestamp character varying(200) NOT NULL,
    output_generation_type character varying(200) NOT NULL,
    limit_interval character varying(200) NOT NULL,
    limit_interval_logic text NOT NULL,
    max_allowed_limit integer,
    generate_false_output boolean,
    generate_same_ref_number boolean,
    input_load_type character varying(200) NOT NULL,
    output_stream_name character varying(200) NOT NULL,
    rule_condition text NOT NULL,
    dynamic_text text NOT NULL,
    expiry_date text NOT NULL,
    calculation_logic_type character varying(200) NOT NULL,
    flat_value character varying(200) NOT NULL,
    percentage_value character varying(200) NOT NULL,
    slab character varying(200) NOT NULL,
    sql text NOT NULL,
    calculation_apply_field character varying(200) NOT NULL,
    max_calculated_value character varying(200) NOT NULL,
    is_active boolean DEFAULT true,
    created_at timestamp with time zone DEFAULT now(),
    created_by character varying(100),
    updated_at timestamp with time zone,
    updated_by character varying(100)
);


ALTER TABLE public.rule_execution_master OWNER TO postgres;

--
-- Name: rule_master; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rule_master (
    rule_id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    rule_name character varying(150) NOT NULL,
    description character varying(200) NOT NULL,
    start_date timestamp with time zone,
    end_date timestamp with time zone,
    action_code character varying(100) NOT NULL,
    category character varying(100) NOT NULL,
    type character varying(100) NOT NULL,
    priority integer DEFAULT 1 NOT NULL,
    attachment_url character varying(400),
    screen_identifier character varying(200),
    output_mode character varying(200) NOT NULL,
    voucher_code character varying(100),
    voucher_code_applicable character varying(100),
    channels character varying(100) NOT NULL,
    enabled_flag boolean DEFAULT false,
    is_active boolean DEFAULT true,
    created_at timestamp with time zone DEFAULT now(),
    created_by character varying(100),
    updated_at timestamp with time zone,
    updated_by character varying(100)
);


ALTER TABLE public.rule_master OWNER TO postgres;

--
-- Data for Name: cluster_master; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cluster_master (cluster_id, cluster_name, nodes, ips, is_active, created_at, created_by, updated_at, updated_by) FROM stdin;
db4a36b0-e485-4786-a7d0-930533c92ecf	C1	4	1237.4.34.2	t	2023-04-06 14:10:46.162+00	SYSTEM	2023-04-06 14:10:46.162+00	SYSTEM
34fa0912-3e39-47e7-b588-f869564a4bcf	HPE_KSQLDB	1	13.234.239.219	t	2023-04-10 10:45:13.986+00	SYSTEM	2023-04-10 10:45:13.986+00	SYSTEM
67ff200b-988d-4d4a-b381-91d4f9c3b29a	TEST_CLUSTER-2	1	65.2.182.83	t	2023-05-05 11:01:45.156+00	SYSTEM	2023-05-05 11:01:45.156+00	SYSTEM
\.


--
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
1	Manoj Kumar	db/changelog.rtx/master.yml	2023-03-30 09:02:03.172206	1	EXECUTED	8:d41d8cd98f00b204e9800998ecf8427e	empty		\N	4.18.0	\N	\N	0166922457
create-extension	Manoj Kumar	db/changelog.rtx/ddl/001_RTX_DDL.sql	2023-03-30 09:02:03.575458	2	EXECUTED	8:e2e0608b1b91d790337afe8f31c85c09	sql		\N	4.18.0	\N	\N	0166922457
create_tables	Manoj Kumar	db/changelog.rtx/ddl/001_RTX_DDL.sql	2023-03-30 09:02:04.397313	3	EXECUTED	8:dbedb08fdd79a56a3cbcaea6fc24929e	sql		\N	4.18.0	\N	\N	0166922457
remove	Nitesh Prasad	db/changelog.rtx/ddl/001_RTX_DDL.sql	2023-04-11 09:59:30.230964	4	EXECUTED	8:c8819947bd30b8853d4211acd5fe5a12	sql		\N	4.18.0	\N	\N	1207168429
\.


--
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
1	f	\N	\N
\.


--
-- Data for Name: rule_additional_master; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rule_additional_master (rule_additional_id, rule_id, data, is_active, created_at, created_by, updated_at, updated_by) FROM stdin;
ce727f71-765f-469e-971e-7d0079a2ca62	e587ae7d-7da6-479b-a43f-a4afccb782a9	{"DATE": "DATE"}	t	2023-05-24 06:32:53.559+00	SYSTEM	2023-05-24 06:32:53.559+00	SYSTEM
c86f9281-540c-410c-94c6-dc7c5a46421d	d8db6526-18d7-4c91-b076-7ba2c0c9841d	{"DATE": "DATE"}	t	2023-05-31 06:57:53.391+00	SYSTEM	2023-05-31 06:57:53.391+00	SYSTEM
\.


--
-- Data for Name: rule_deploy_master; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rule_deploy_master (rule_deploy_id, rule_id, rule_type, rt_deploy_time, rt_query_id, run_status, is_active, created_at, created_by, updated_at, updated_by) FROM stdin;
\.


--
-- Data for Name: rule_execution_master; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rule_execution_master (rule_execution_id, rule_id, cluster_id, input_stream_name, input_key, entity_id, input_timestamp_format, input_timestamp_tz, input_timestamp, output_generation_type, limit_interval, limit_interval_logic, max_allowed_limit, generate_false_output, generate_same_ref_number, input_load_type, output_stream_name, rule_condition, dynamic_text, expiry_date, calculation_logic_type, flat_value, percentage_value, slab, sql, calculation_apply_field, max_calculated_value, is_active, created_at, created_by, updated_at, updated_by) FROM stdin;
\.


--
-- Data for Name: rule_master; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rule_master (rule_id, rule_name, description, start_date, end_date, action_code, category, type, priority, attachment_url, screen_identifier, output_mode, voucher_code, voucher_code_applicable, channels, enabled_flag, is_active, created_at, created_by, updated_at, updated_by) FROM stdin;
ea4bec0d-ff07-4c78-858d-d4b63963c602	Rewards_and_cashbacks	Instant gratification of rewards and cashbacks as soon as spends are done.	2023-05-24 00:00:00+00	2023-05-27 01:05:00+00	A002	SERVICE	LOYALTY	1	https://adminportal.xpsapps.xebia.com/dashboard/real-time-experience/rewards	rewards and cash backs	EXTERNAL DB	-	Auto	C002	t	t	2023-05-24 05:29:29.376+00	SYSTEM	2023-05-24 05:31:23.809+00	SYSTEM
d8db6526-18d7-4c91-b076-7ba2c0c9841d	child_insurance_recommendation	Based on spends identify and target customers having baby or school going child.	2023-05-24 00:01:00+00	2023-05-27 01:05:00+00	A002	SERVICE	RECOMMENDATION	1	https://adminportal.xpsapps.xebia.com/dashboard/real-time-experience/rule-info-master/insurance	plan insurance screen	PUSH NOTIFICATION	-	Auto applicable	C002	t	t	2023-05-24 05:36:12.204+00	SYSTEM	2023-05-24 05:36:12.204+00	SYSTEM
e587ae7d-7da6-479b-a43f-a4afccb782a9	Order_a_new_Cheque_Book	Order new cheque book on utilisation upon reaching the near to last cheque leaf	2023-05-24 00:01:00+00	2023-05-25 00:01:00+00	A101	SERVICE	RECOMMENDATION	1	https://adminportal.xpsapps.xebia.com/dashboard/real-time-experience/cbook	Activity feed screen	PUSH NOTIFICATION	-	Auto	C001	t	t	2023-05-24 05:15:28.856+00	SYSTEM	2023-05-24 05:36:29.735+00	SYSTEM
59b7ca0b-517a-47f4-9229-0fc10a18d9e4	rule_4	rule 4	2023-08-03 11:28:00+00	2023-08-18 11:28:00+00	A101	ALERT	FEE	23			DASHBOARD			C001	t	t	2023-07-03 05:58:53.187+00	SYSTEM	2023-07-03 05:58:53.187+00	SYSTEM
\.


--
-- Name: cluster_master cluster_id_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cluster_master
    ADD CONSTRAINT cluster_id_pkey PRIMARY KEY (cluster_id);


--
-- Name: cluster_master cluster_master_cluster_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cluster_master
    ADD CONSTRAINT cluster_master_cluster_name_key UNIQUE (cluster_name);


--
-- Name: databasechangeloglock databasechangeloglock_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.databasechangeloglock
    ADD CONSTRAINT databasechangeloglock_pkey PRIMARY KEY (id);


--
-- Name: rule_additional_master rule_additional_id_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rule_additional_master
    ADD CONSTRAINT rule_additional_id_pkey PRIMARY KEY (rule_additional_id);


--
-- Name: rule_deploy_master rule_deploy_id_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rule_deploy_master
    ADD CONSTRAINT rule_deploy_id_pkey PRIMARY KEY (rule_deploy_id);


--
-- Name: rule_execution_master rule_execution_id_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rule_execution_master
    ADD CONSTRAINT rule_execution_id_pkey PRIMARY KEY (rule_execution_id);


--
-- Name: rule_master rule_id_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rule_master
    ADD CONSTRAINT rule_id_pkey PRIMARY KEY (rule_id);


--
-- Name: rule_additional_master rule_additional_master_rule_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rule_additional_master
    ADD CONSTRAINT rule_additional_master_rule_id_fkey FOREIGN KEY (rule_id) REFERENCES public.rule_master(rule_id);


--
-- Name: rule_deploy_master rule_deploy_master_rule_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rule_deploy_master
    ADD CONSTRAINT rule_deploy_master_rule_id_fkey FOREIGN KEY (rule_id) REFERENCES public.rule_master(rule_id);


--
-- Name: rule_execution_master rule_execution_master_cluster_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rule_execution_master
    ADD CONSTRAINT rule_execution_master_cluster_id_fkey FOREIGN KEY (cluster_id) REFERENCES public.cluster_master(cluster_id);


--
-- Name: rule_execution_master rule_execution_master_rule_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rule_execution_master
    ADD CONSTRAINT rule_execution_master_rule_id_fkey FOREIGN KEY (rule_id) REFERENCES public.rule_master(rule_id);


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--


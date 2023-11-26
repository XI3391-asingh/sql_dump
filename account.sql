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
    account_id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    account_number character varying(100),
    product_type character varying(100) NOT NULL,
    product_scheme_id character varying(100),
    cif_ids text[] NOT NULL,
    primary_currency character varying(100),
    supported_currency text[],
    status character varying(100) DEFAULT 'UNKNOWN'::character varying NOT NULL,
    created_at timestamp with time zone DEFAULT (now() AT TIME ZONE 'utc'::text),
    created_by character varying(100),
    modified_at timestamp with time zone,
    modified_by character varying(100)
);


ALTER TABLE public.account OWNER TO postgres;

--
-- Name: account_360_integration_staging; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.account_360_integration_staging (
    id character varying(50) NOT NULL,
    version integer NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    created_by character varying(100) DEFAULT 'admin'::character varying NOT NULL,
    last_modified_at timestamp without time zone DEFAULT now() NOT NULL,
    last_modified_by character varying(255) DEFAULT 'admin'::character varying NOT NULL,
    account_number character varying(50) NOT NULL,
    account_360_request character varying(10485760) NOT NULL,
    account_360_response character varying(10485760) NOT NULL
);


ALTER TABLE public.account_360_integration_staging OWNER TO postgres;

--
-- Name: account_nominee_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.account_nominee_mapping (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    account_id uuid NOT NULL,
    nominee_id character varying(100) NOT NULL,
    percentage double precision NOT NULL,
    is_active boolean,
    created_at timestamp with time zone NOT NULL,
    created_by character varying(100),
    modified_at timestamp with time zone,
    modified_by character varying(100)
);


ALTER TABLE public.account_nominee_mapping OWNER TO postgres;

--
-- Name: account_verification_staging; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.account_verification_staging (
    id character varying(50) NOT NULL,
    version integer NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    created_by character varying(100) DEFAULT 'admin'::character varying NOT NULL,
    last_modified_at timestamp without time zone DEFAULT now() NOT NULL,
    last_modified_by character varying(255) DEFAULT 'admin'::character varying NOT NULL,
    account_number character varying(30) NOT NULL,
    account_verification_request character varying(10485760) NOT NULL,
    account_verification_response character varying(10485760) NOT NULL
);


ALTER TABLE public.account_verification_staging OWNER TO postgres;

--
-- Name: address_details; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.address_details (
    id character varying(50) NOT NULL,
    version integer NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    created_by character varying(100) DEFAULT 'admin'::character varying NOT NULL,
    last_modified_at timestamp without time zone DEFAULT now() NOT NULL,
    last_modified_by character varying(255) DEFAULT 'admin'::character varying NOT NULL,
    billing_name character varying(50),
    address_line1 character varying(50),
    address_line2 character varying(50),
    pin_code character varying(50),
    city character varying(50),
    state character varying(50),
    shipping_name character varying(50),
    shipping_address_line1 character varying(50),
    shipping_address_line2 character varying(50),
    shipping_pin_code character varying(50),
    shipping_city character varying(50),
    shipping_state character varying(50)
);


ALTER TABLE public.address_details OWNER TO postgres;

--
-- Name: bank_details; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.bank_details (
    id character varying(50) NOT NULL,
    version integer NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    created_by character varying(100) DEFAULT 'admin'::character varying NOT NULL,
    last_modified_at timestamp without time zone DEFAULT now() NOT NULL,
    last_modified_by character varying(255) DEFAULT 'admin'::character varying NOT NULL,
    account_holder_name character varying(50),
    bank_name character varying(50),
    account_number character varying(50),
    ifsc_code character varying(50),
    verification_flag character varying(50)
);


ALTER TABLE public.bank_details OWNER TO postgres;

--
-- Name: casa_account; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.casa_account (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    account_id uuid NOT NULL,
    branch_code character varying(100),
    denomination character varying(100) NOT NULL
);


ALTER TABLE public.casa_account OWNER TO postgres;

--
-- Name: cif_account_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cif_account_mapping (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    cif_id character varying(100) NOT NULL,
    account_id uuid NOT NULL,
    is_primary_holder boolean DEFAULT false NOT NULL,
    default_account boolean DEFAULT false,
    status character varying(100),
    created_at timestamp with time zone DEFAULT (now() AT TIME ZONE 'utc'::text) NOT NULL,
    created_by character varying(100),
    modified_at timestamp with time zone,
    modified_by character varying(100)
);


ALTER TABLE public.cif_account_mapping OWNER TO postgres;

--
-- Name: customer_account_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.customer_account_mapping (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    customer_id character varying(100) NOT NULL,
    account_id uuid NOT NULL,
    is_primary_holder boolean
);


ALTER TABLE public.customer_account_mapping OWNER TO postgres;

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
-- Name: debit_card_details_esb_staging; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.debit_card_details_esb_staging (
    id character varying(50) NOT NULL,
    version integer NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    created_by character varying(100) DEFAULT 'admin'::character varying NOT NULL,
    last_modified_at timestamp without time zone DEFAULT now() NOT NULL,
    last_modified_by character varying(255) DEFAULT 'admin'::character varying NOT NULL,
    customer_id character varying(50) NOT NULL,
    debit_card_details_request character varying(10485760) NOT NULL,
    debit_card_details_response character varying(10485760) NOT NULL
);


ALTER TABLE public.debit_card_details_esb_staging OWNER TO postgres;

--
-- Name: fd_account; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fd_account (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    account_id uuid NOT NULL,
    tenure_unit character varying(100) NOT NULL,
    tenure_value integer NOT NULL,
    interest_rate double precision NOT NULL,
    amount double precision NOT NULL,
    start_date timestamp with time zone NOT NULL,
    auto_renewal boolean NOT NULL,
    auto_renewal_type character varying(100) NOT NULL,
    deposit_account character varying(100) NOT NULL,
    interest_payout_frequency character varying(100) NOT NULL,
    branch_code character varying(100),
    denomination character varying(100) NOT NULL,
    maturity_date timestamp with time zone NOT NULL,
    maturity_amount double precision NOT NULL
);


ALTER TABLE public.fd_account OWNER TO postgres;

--
-- Name: flyway_schema_history; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.flyway_schema_history (
    installed_rank integer NOT NULL,
    version character varying(50),
    description character varying(200) NOT NULL,
    type character varying(20) NOT NULL,
    script character varying(1000) NOT NULL,
    checksum integer,
    installed_by character varying(100) NOT NULL,
    installed_on timestamp without time zone DEFAULT now() NOT NULL,
    execution_time integer NOT NULL,
    success boolean NOT NULL
);


ALTER TABLE public.flyway_schema_history OWNER TO postgres;

--
-- Name: loan_account; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.loan_account (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    account_id uuid NOT NULL,
    tenure_in_months integer DEFAULT 0 NOT NULL,
    roi double precision DEFAULT 0 NOT NULL,
    amount double precision DEFAULT 0 NOT NULL,
    start_date timestamp with time zone
);


ALTER TABLE public.loan_account OWNER TO postgres;

--
-- Name: mini_statement_esb_staging; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.mini_statement_esb_staging (
    id character varying(50) NOT NULL,
    version integer NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    created_by character varying(100) DEFAULT 'admin'::character varying NOT NULL,
    last_modified_at timestamp without time zone DEFAULT now() NOT NULL,
    last_modified_by character varying(255) DEFAULT 'admin'::character varying NOT NULL,
    account_id character varying(50) NOT NULL,
    mini_statement_request character varying(10485760) NOT NULL,
    mini_statement_response character varying(10485760) NOT NULL
);


ALTER TABLE public.mini_statement_esb_staging OWNER TO postgres;

--
-- Name: monthly_account_balance_esb_staging; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.monthly_account_balance_esb_staging (
    id character varying(50) NOT NULL,
    version integer NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    created_by character varying(100) DEFAULT 'admin'::character varying NOT NULL,
    last_modified_at timestamp without time zone DEFAULT now() NOT NULL,
    last_modified_by character varying(255) DEFAULT 'admin'::character varying NOT NULL,
    account_no character varying(50) NOT NULL,
    monthly_account_balance_request character varying(10485760) NOT NULL,
    monthly_account_balance_response character varying(10485760) NOT NULL
);


ALTER TABLE public.monthly_account_balance_esb_staging OWNER TO postgres;

--
-- Name: payee_bank_relationship; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.payee_bank_relationship (
    id character varying(50) NOT NULL,
    version integer NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    created_by character varying(100) DEFAULT 'admin'::character varying NOT NULL,
    last_modified_at timestamp without time zone DEFAULT now() NOT NULL,
    last_modified_by character varying(255) DEFAULT 'admin'::character varying NOT NULL,
    bank_id character varying(50),
    payee_id character varying(50),
    status character varying(50)
);


ALTER TABLE public.payee_bank_relationship OWNER TO postgres;

--
-- Name: payee_details; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.payee_details (
    id character varying(50) NOT NULL,
    version integer NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    created_by character varying(100) DEFAULT 'admin'::character varying NOT NULL,
    last_modified_at timestamp without time zone DEFAULT now() NOT NULL,
    last_modified_by character varying(255) DEFAULT 'admin'::character varying NOT NULL,
    payee_name character varying(50),
    customer_id character varying(50),
    mobile_number character varying(15),
    is_active character varying(50),
    email_id character varying(50),
    upi_id character varying(50),
    address_id character varying(50),
    t_a_p_id character varying(50)
);


ALTER TABLE public.payee_details OWNER TO postgres;

--
-- Name: periodic_statement_esb_staging; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.periodic_statement_esb_staging (
    id character varying(50) NOT NULL,
    version integer NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    created_by character varying(100) DEFAULT 'admin'::character varying NOT NULL,
    last_modified_at timestamp without time zone DEFAULT now() NOT NULL,
    last_modified_by character varying(255) DEFAULT 'admin'::character varying NOT NULL,
    account_id character varying(50) NOT NULL,
    transaction_count character varying(50) NOT NULL,
    transaction_date character varying(50),
    periodic_statement_request character varying(10485760) NOT NULL,
    periodic_statement_response character varying(10485760) NOT NULL
);


ALTER TABLE public.periodic_statement_esb_staging OWNER TO postgres;

--
-- Name: rd_account; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rd_account (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    account_id uuid NOT NULL,
    tenure_unit character varying(100) NOT NULL,
    tenure_value integer NOT NULL,
    interest_rate double precision NOT NULL,
    amount double precision NOT NULL,
    start_date timestamp with time zone NOT NULL,
    auto_renewal boolean NOT NULL,
    auto_renewal_type character varying(100) NOT NULL,
    deposit_frequency character varying(100) NOT NULL,
    deposit_account character varying(100) NOT NULL,
    branch_code character varying(100),
    denomination character varying(100) NOT NULL,
    maturity_date timestamp with time zone NOT NULL,
    maturity_amount double precision NOT NULL
);


ALTER TABLE public.rd_account OWNER TO postgres;

--
-- Name: tax_and_payment_details; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tax_and_payment_details (
    id character varying(50) NOT NULL,
    version integer NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    created_by character varying(100) DEFAULT 'admin'::character varying NOT NULL,
    last_modified_at timestamp without time zone DEFAULT now() NOT NULL,
    last_modified_by character varying(255) DEFAULT 'admin'::character varying NOT NULL,
    pan_number character varying(50),
    tan_number character varying(50),
    gst_number character varying(50)
);


ALTER TABLE public.tax_and_payment_details OWNER TO postgres;

--
-- Data for Name: account; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.account (account_id, account_number, product_type, product_scheme_id, cif_ids, primary_currency, supported_currency, status, created_at, created_by, modified_at, modified_by) FROM stdin;
\.


--
-- Data for Name: account_360_integration_staging; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.account_360_integration_staging (id, version, created_at, created_by, last_modified_at, last_modified_by, account_number, account_360_request, account_360_response) FROM stdin;
\.


--
-- Data for Name: account_nominee_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.account_nominee_mapping (id, account_id, nominee_id, percentage, is_active, created_at, created_by, modified_at, modified_by) FROM stdin;
\.


--
-- Data for Name: account_verification_staging; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.account_verification_staging (id, version, created_at, created_by, last_modified_at, last_modified_by, account_number, account_verification_request, account_verification_response) FROM stdin;
\.


--
-- Data for Name: address_details; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.address_details (id, version, created_at, created_by, last_modified_at, last_modified_by, billing_name, address_line1, address_line2, pin_code, city, state, shipping_name, shipping_address_line1, shipping_address_line2, shipping_pin_code, shipping_city, shipping_state) FROM stdin;
\.


--
-- Data for Name: bank_details; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.bank_details (id, version, created_at, created_by, last_modified_at, last_modified_by, account_holder_name, bank_name, account_number, ifsc_code, verification_flag) FROM stdin;
\.


--
-- Data for Name: casa_account; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.casa_account (id, account_id, branch_code, denomination) FROM stdin;
\.


--
-- Data for Name: cif_account_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cif_account_mapping (id, cif_id, account_id, is_primary_holder, default_account, status, created_at, created_by, modified_at, modified_by) FROM stdin;
\.


--
-- Data for Name: customer_account_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.customer_account_mapping (id, customer_id, account_id, is_primary_holder) FROM stdin;
\.


--
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
1	Manoj Kumar	db/changelog/account/master.yml	2023-11-26 02:52:04.466384	1	EXECUTED	8:d41d8cd98f00b204e9800998ecf8427e	empty		\N	4.20.0	\N	\N	0967124363
create-tables	Manoj Kumar	db/changelog/account/ddl/001_create_tables.sql	2023-11-26 03:05:14.863857	2	EXECUTED	8:d12ae259de09600ed4a060b72bbd7766	sql		\N	4.20.0	\N	\N	0967914272
1	Manoj Kumar	db/changelog/account/master.yml	2023-11-26 02:52:04.466384	1	EXECUTED	8:d41d8cd98f00b204e9800998ecf8427e	empty		\N	4.20.0	\N	\N	0967124363
\.


--
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
1	f	\N	\N
\.


--
-- Data for Name: debit_card_details_esb_staging; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.debit_card_details_esb_staging (id, version, created_at, created_by, last_modified_at, last_modified_by, customer_id, debit_card_details_request, debit_card_details_response) FROM stdin;
\.


--
-- Data for Name: fd_account; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fd_account (id, account_id, tenure_unit, tenure_value, interest_rate, amount, start_date, auto_renewal, auto_renewal_type, deposit_account, interest_payout_frequency, branch_code, denomination, maturity_date, maturity_amount) FROM stdin;
\.


--
-- Data for Name: flyway_schema_history; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) FROM stdin;
1	001	init mini statement esb staging	SQL	V001__init_mini_statement_esb_staging.sql	-1751483106	postgres	2023-05-17 10:46:54.278914	199	t
2	002	init debit card details esb staging	SQL	V002__init_debit_card_details_esb_staging.sql	-714785472	postgres	2023-05-17 10:46:55.381932	313	t
3	003	init monthly account balance staging	SQL	V003__init_monthly_account_balance_staging.sql	1878801443	postgres	2023-05-17 10:46:56.080868	497	t
4	004	init periodic statement esb staging	SQL	V004__init_periodic_statement_esb_staging.sql	-209780893	postgres	2023-05-17 10:46:56.883152	203	t
5	005	init account360 staging	SQL	V005__init_account360_staging.sql	-261171158	postgres	2023-05-17 10:46:57.385711	200	t
6	006	init bank details	SQL	V006__init_bank_details.sql	-1819628602	postgres	2023-05-17 10:46:57.979663	109	t
7	007	init address details	SQL	V007__init_address_details.sql	715310709	postgres	2023-05-17 10:46:58.579437	108	t
8	008	init tax and payment details	SQL	V008__init_tax_and_payment_details.sql	641981818	postgres	2023-05-17 10:46:59.181096	106	t
9	009	init payee bank relationship	SQL	V009__init_payee_bank_relationship.sql	1140731701	postgres	2023-05-17 10:47:00.080678	108	t
10	0010	init payee details	SQL	V0010__init_payee_details.sql	1065723794	postgres	2023-05-17 10:47:00.479354	206	t
11	0011	init account verification	SQL	V0011__init_account_verification.sql	-970944751	postgres	2023-05-17 10:47:01.080552	111	t
12	0012	alter payee details	SQL	V0012__alter_payee_details.sql	-1544935659	postgres	2023-05-17 10:47:01.211212	171	t
13	013	alter payee bank relation	SQL	V013__alter_payee_bank_relation.sql	-1688460461	postgres	2023-05-17 10:47:01.880554	197	t
\.


--
-- Data for Name: loan_account; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.loan_account (id, account_id, tenure_in_months, roi, amount, start_date) FROM stdin;
\.


--
-- Data for Name: mini_statement_esb_staging; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.mini_statement_esb_staging (id, version, created_at, created_by, last_modified_at, last_modified_by, account_id, mini_statement_request, mini_statement_response) FROM stdin;
\.


--
-- Data for Name: monthly_account_balance_esb_staging; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.monthly_account_balance_esb_staging (id, version, created_at, created_by, last_modified_at, last_modified_by, account_no, monthly_account_balance_request, monthly_account_balance_response) FROM stdin;
\.


--
-- Data for Name: payee_bank_relationship; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.payee_bank_relationship (id, version, created_at, created_by, last_modified_at, last_modified_by, bank_id, payee_id, status) FROM stdin;
\.


--
-- Data for Name: payee_details; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.payee_details (id, version, created_at, created_by, last_modified_at, last_modified_by, payee_name, customer_id, mobile_number, is_active, email_id, upi_id, address_id, t_a_p_id) FROM stdin;
\.


--
-- Data for Name: periodic_statement_esb_staging; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.periodic_statement_esb_staging (id, version, created_at, created_by, last_modified_at, last_modified_by, account_id, transaction_count, transaction_date, periodic_statement_request, periodic_statement_response) FROM stdin;
\.


--
-- Data for Name: rd_account; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rd_account (id, account_id, tenure_unit, tenure_value, interest_rate, amount, start_date, auto_renewal, auto_renewal_type, deposit_frequency, deposit_account, branch_code, denomination, maturity_date, maturity_amount) FROM stdin;
\.


--
-- Data for Name: tax_and_payment_details; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tax_and_payment_details (id, version, created_at, created_by, last_modified_at, last_modified_by, pan_number, tan_number, gst_number) FROM stdin;
\.


--
-- Name: account_360_integration_staging account_360_integration_staging_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_360_integration_staging
    ADD CONSTRAINT account_360_integration_staging_pk PRIMARY KEY (id);


--
-- Name: account account_account_number_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account
    ADD CONSTRAINT account_account_number_key UNIQUE (account_number);


--
-- Name: account account_id_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account
    ADD CONSTRAINT account_id_pkey PRIMARY KEY (account_id);


--
-- Name: account_nominee_mapping account_nominee_id_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_nominee_mapping
    ADD CONSTRAINT account_nominee_id_pkey PRIMARY KEY (id);


--
-- Name: account_verification_staging account_verification_staging_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_verification_staging
    ADD CONSTRAINT account_verification_staging_pkey PRIMARY KEY (id);


--
-- Name: address_details address_details_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.address_details
    ADD CONSTRAINT address_details_pkey PRIMARY KEY (id);


--
-- Name: bank_details bank_details_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bank_details
    ADD CONSTRAINT bank_details_pkey PRIMARY KEY (id);


--
-- Name: casa_account casa_account_id_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.casa_account
    ADD CONSTRAINT casa_account_id_pkey PRIMARY KEY (id);


--
-- Name: cif_account_mapping cif_account_id_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cif_account_mapping
    ADD CONSTRAINT cif_account_id_pkey PRIMARY KEY (id);


--
-- Name: customer_account_mapping customer_account_id_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer_account_mapping
    ADD CONSTRAINT customer_account_id_pkey PRIMARY KEY (id);


--
-- Name: databasechangeloglock databasechangeloglock_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.databasechangeloglock
    ADD CONSTRAINT databasechangeloglock_pkey PRIMARY KEY (id);


--
-- Name: debit_card_details_esb_staging debit_card_details_esb_staging_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.debit_card_details_esb_staging
    ADD CONSTRAINT debit_card_details_esb_staging_pk PRIMARY KEY (id);


--
-- Name: fd_account fd_account_id_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fd_account
    ADD CONSTRAINT fd_account_id_pkey PRIMARY KEY (id);


--
-- Name: flyway_schema_history flyway_schema_history_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.flyway_schema_history
    ADD CONSTRAINT flyway_schema_history_pk PRIMARY KEY (installed_rank);


--
-- Name: loan_account loan_account_id_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.loan_account
    ADD CONSTRAINT loan_account_id_pkey PRIMARY KEY (id);


--
-- Name: mini_statement_esb_staging mini_statement_esb_staging_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mini_statement_esb_staging
    ADD CONSTRAINT mini_statement_esb_staging_pkey PRIMARY KEY (id);


--
-- Name: monthly_account_balance_esb_staging monthly_account_balance_esb_staging_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.monthly_account_balance_esb_staging
    ADD CONSTRAINT monthly_account_balance_esb_staging_pk PRIMARY KEY (id);


--
-- Name: payee_bank_relationship payee_bank_relationship_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payee_bank_relationship
    ADD CONSTRAINT payee_bank_relationship_pkey PRIMARY KEY (id);


--
-- Name: payee_details payee_details_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payee_details
    ADD CONSTRAINT payee_details_pkey PRIMARY KEY (id);


--
-- Name: periodic_statement_esb_staging periodic_statement_esb_staging_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.periodic_statement_esb_staging
    ADD CONSTRAINT periodic_statement_esb_staging_pkey PRIMARY KEY (id);


--
-- Name: rd_account rd_account_id_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rd_account
    ADD CONSTRAINT rd_account_id_pkey PRIMARY KEY (id);


--
-- Name: tax_and_payment_details tax_and_payment_details_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tax_and_payment_details
    ADD CONSTRAINT tax_and_payment_details_pkey PRIMARY KEY (id);


--
-- Name: account_nominee_unique_check; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX account_nominee_unique_check ON public.account_nominee_mapping USING btree (account_id, nominee_id);


--
-- Name: flyway_schema_history_s_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX flyway_schema_history_s_idx ON public.flyway_schema_history USING btree (success);


--
-- Name: account_nominee_mapping account_nominee_mapping_account_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_nominee_mapping
    ADD CONSTRAINT account_nominee_mapping_account_id_fkey FOREIGN KEY (account_id) REFERENCES public.account(account_id);


--
-- Name: casa_account casa_account_account_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.casa_account
    ADD CONSTRAINT casa_account_account_id_fkey FOREIGN KEY (account_id) REFERENCES public.account(account_id);


--
-- Name: cif_account_mapping cif_account_mapping_account_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cif_account_mapping
    ADD CONSTRAINT cif_account_mapping_account_id_fkey FOREIGN KEY (account_id) REFERENCES public.account(account_id);


--
-- Name: customer_account_mapping customer_account_mapping_account_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer_account_mapping
    ADD CONSTRAINT customer_account_mapping_account_id_fkey FOREIGN KEY (account_id) REFERENCES public.account(account_id);


--
-- Name: fd_account fd_account_account_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fd_account
    ADD CONSTRAINT fd_account_account_id_fkey FOREIGN KEY (account_id) REFERENCES public.account(account_id);


--
-- Name: payee_details fk_address_details; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payee_details
    ADD CONSTRAINT fk_address_details FOREIGN KEY (address_id) REFERENCES public.address_details(id);


--
-- Name: payee_bank_relationship fk_bank_details; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payee_bank_relationship
    ADD CONSTRAINT fk_bank_details FOREIGN KEY (bank_id) REFERENCES public.bank_details(id);


--
-- Name: payee_bank_relationship fk_payee_details; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payee_bank_relationship
    ADD CONSTRAINT fk_payee_details FOREIGN KEY (payee_id) REFERENCES public.payee_details(id);


--
-- Name: payee_details fk_tax_and_payment_details; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payee_details
    ADD CONSTRAINT fk_tax_and_payment_details FOREIGN KEY (t_a_p_id) REFERENCES public.tax_and_payment_details(id);


--
-- Name: loan_account loan_account_account_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.loan_account
    ADD CONSTRAINT loan_account_account_id_fkey FOREIGN KEY (account_id) REFERENCES public.account(account_id);


--
-- Name: rd_account rd_account_account_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rd_account
    ADD CONSTRAINT rd_account_account_id_fkey FOREIGN KEY (account_id) REFERENCES public.account(account_id);


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--


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
-- Name: PERSISTENT_LOGINS; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."PERSISTENT_LOGINS" (
    series character varying(64) NOT NULL,
    username character varying(64) NOT NULL,
    token character varying(64) NOT NULL,
    last_used timestamp without time zone NOT NULL
);


ALTER TABLE public."PERSISTENT_LOGINS" OWNER TO postgres;

--
-- Name: XLD_ACTIVE_TASKS; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."XLD_ACTIVE_TASKS" (
    task_id character varying(36) NOT NULL,
    description text NOT NULL,
    task_owner character varying(255) NOT NULL,
    worker_id integer NOT NULL
);


ALTER TABLE public."XLD_ACTIVE_TASKS" OWNER TO postgres;

--
-- Name: XLD_ACTIVE_TASKS_METADATA; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."XLD_ACTIVE_TASKS_METADATA" (
    task_id character varying(36) NOT NULL,
    metadata_key character varying(255) NOT NULL,
    metadata_value text
);


ALTER TABLE public."XLD_ACTIVE_TASKS_METADATA" OWNER TO postgres;

--
-- Name: XLD_ARCHIVED_CONTROL_TASKS; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."XLD_ARCHIVED_CONTROL_TASKS" (
    task_id character varying(36) NOT NULL,
    control_task_name character varying(255),
    target_ci character varying(1024),
    description character varying(256),
    owner character varying(255),
    status character varying(20) NOT NULL,
    failure_count numeric NOT NULL,
    start_date timestamp without time zone NOT NULL,
    end_date timestamp without time zone NOT NULL,
    target_internal_id integer,
    target_secured_ci integer,
    worker_name character varying(255)
);


ALTER TABLE public."XLD_ARCHIVED_CONTROL_TASKS" OWNER TO postgres;

--
-- Name: XLD_ARCHIVED_DEPLOYMENT_TASKS; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."XLD_ARCHIVED_DEPLOYMENT_TASKS" (
    task_id character varying(36) NOT NULL,
    main_application character varying(255),
    packages text,
    environment character varying(1024),
    task_type character varying(20) NOT NULL,
    owner character varying(255),
    status character varying(20) NOT NULL,
    failure_count numeric NOT NULL,
    start_date timestamp without time zone NOT NULL,
    end_date timestamp without time zone NOT NULL,
    duration bigint,
    rolled_back boolean,
    environment_internal_id integer,
    environment_secured_ci integer,
    worker_name character varying(255)
);


ALTER TABLE public."XLD_ARCHIVED_DEPLOYMENT_TASKS" OWNER TO postgres;

--
-- Name: XLD_ARCHIVED_DT_APPLICATIONS; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."XLD_ARCHIVED_DT_APPLICATIONS" (
    task_id character varying(36) NOT NULL,
    application character varying(255) NOT NULL,
    application_internal_id integer,
    application_secured_ci integer
);


ALTER TABLE public."XLD_ARCHIVED_DT_APPLICATIONS" OWNER TO postgres;

--
-- Name: XLD_ARCHIVED_PLACEHOLDERS; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."XLD_ARCHIVED_PLACEHOLDERS" (
    "ID" character varying(255) NOT NULL,
    encrypted boolean NOT NULL,
    key character varying(255) NOT NULL,
    value character varying(255),
    dictionary_id character varying(255) NOT NULL,
    dictionary_name character varying(255) NOT NULL,
    dictionary_deleted smallint NOT NULL,
    container_id character varying(255),
    container_name character varying(255),
    container_deleted smallint,
    environment_id character varying(255) NOT NULL,
    environment_name character varying(255) NOT NULL,
    environment_deleted smallint NOT NULL,
    deployed_app_id character varying(255) NOT NULL,
    deployed_app_name character varying(255) NOT NULL,
    version_id character varying(255) NOT NULL,
    task_id character varying(255) NOT NULL,
    full_value text
);


ALTER TABLE public."XLD_ARCHIVED_PLACEHOLDERS" OWNER TO postgres;

--
-- Name: XLD_ARCHIVED_TASKS; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."XLD_ARCHIVED_TASKS" (
    task_id character varying(36) NOT NULL,
    task_kind character varying(20) NOT NULL,
    task_details text NOT NULL,
    worker_name character varying(255)
);


ALTER TABLE public."XLD_ARCHIVED_TASKS" OWNER TO postgres;

--
-- Name: XLD_ARCHIVED_UNKNOWN_TASKS; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."XLD_ARCHIVED_UNKNOWN_TASKS" (
    task_id character varying(36) NOT NULL,
    start_date timestamp without time zone NOT NULL
);


ALTER TABLE public."XLD_ARCHIVED_UNKNOWN_TASKS" OWNER TO postgres;

--
-- Name: XLD_ARCHIVE_ROLES; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."XLD_ARCHIVE_ROLES" (
    "ID" character varying(255) NOT NULL,
    "NAME" character varying(255) NOT NULL,
    "CI_ID" integer NOT NULL
);


ALTER TABLE public."XLD_ARCHIVE_ROLES" OWNER TO postgres;

--
-- Name: XLD_ARCHIVE_ROLE_PERMISSIONS; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."XLD_ARCHIVE_ROLE_PERMISSIONS" (
    "ROLE_ID" character varying(255) NOT NULL,
    "PERMISSION_NAME" character varying(255) NOT NULL,
    "CI_ID" integer NOT NULL
);


ALTER TABLE public."XLD_ARCHIVE_ROLE_PERMISSIONS" OWNER TO postgres;

--
-- Name: XLD_ARCHIVE_ROLE_PRINCIPALS; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."XLD_ARCHIVE_ROLE_PRINCIPALS" (
    "ROLE_ID" character varying(255) NOT NULL,
    "PRINCIPAL_NAME" character varying(255) NOT NULL
);


ALTER TABLE public."XLD_ARCHIVE_ROLE_PRINCIPALS" OWNER TO postgres;

--
-- Name: XLD_ARCHIVE_ROLE_ROLES; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."XLD_ARCHIVE_ROLE_ROLES" (
    "ROLE_ID" character varying(255) NOT NULL,
    "MEMBER_ROLE_ID" character varying(255) NOT NULL
);


ALTER TABLE public."XLD_ARCHIVE_ROLE_ROLES" OWNER TO postgres;

--
-- Name: XLD_BANNER; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."XLD_BANNER" (
    kind character varying(255) NOT NULL,
    content text NOT NULL
);


ALTER TABLE public."XLD_BANNER" OWNER TO postgres;

--
-- Name: XLD_CIS; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."XLD_CIS" (
    "ID" integer NOT NULL,
    ci_type character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    parent_id integer,
    token character varying(36),
    created_at timestamp without time zone,
    created_by character varying(255),
    modified_at timestamp without time zone,
    modified_by character varying(255),
    path character varying(850) NOT NULL,
    secured_ci integer,
    scm_traceability_data_id integer
);


ALTER TABLE public."XLD_CIS" OWNER TO postgres;

--
-- Name: XLD_CIS_ID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public."XLD_CIS" ALTER COLUMN "ID" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public."XLD_CIS_ID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: XLD_CI_HISTORY; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."XLD_CI_HISTORY" (
    "ID" integer NOT NULL,
    ci_id integer NOT NULL,
    changed_at timestamp without time zone NOT NULL,
    changed_by character varying(255) NOT NULL,
    ci text NOT NULL
);


ALTER TABLE public."XLD_CI_HISTORY" OWNER TO postgres;

--
-- Name: XLD_CI_HISTORY_ID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public."XLD_CI_HISTORY" ALTER COLUMN "ID" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public."XLD_CI_HISTORY_ID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: XLD_CI_LOCK; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."XLD_CI_LOCK" (
    "CI_ID" integer NOT NULL,
    task_id character varying(36) NOT NULL
);


ALTER TABLE public."XLD_CI_LOCK" OWNER TO postgres;

--
-- Name: XLD_CI_PLACEHOLDERS; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."XLD_CI_PLACEHOLDERS" (
    "ID" integer NOT NULL,
    key character varying(255) NOT NULL,
    ci_path character varying(850),
    ci_name character varying(850),
    ci_type character varying(255)
);


ALTER TABLE public."XLD_CI_PLACEHOLDERS" OWNER TO postgres;

--
-- Name: XLD_CI_PLACEHOLDERS_ID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public."XLD_CI_PLACEHOLDERS" ALTER COLUMN "ID" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public."XLD_CI_PLACEHOLDERS_ID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: XLD_CI_PROPERTIES; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."XLD_CI_PROPERTIES" (
    "ID" integer NOT NULL,
    ci_id integer NOT NULL,
    name character varying(255) NOT NULL,
    key character varying(255),
    idx integer,
    boolean_value boolean,
    integer_value integer,
    string_value text,
    date_value timestamp without time zone,
    ci_ref_value integer
);


ALTER TABLE public."XLD_CI_PROPERTIES" OWNER TO postgres;

--
-- Name: XLD_CI_PROPERTIES_ID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public."XLD_CI_PROPERTIES" ALTER COLUMN "ID" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public."XLD_CI_PROPERTIES_ID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: XLD_CONFIG_VERSION; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."XLD_CONFIG_VERSION" (
    "ID" integer NOT NULL,
    hash character varying(255) NOT NULL,
    boot_date_time timestamp without time zone NOT NULL
);


ALTER TABLE public."XLD_CONFIG_VERSION" OWNER TO postgres;

--
-- Name: XLD_CONFIG_VERSION_ID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public."XLD_CONFIG_VERSION" ALTER COLUMN "ID" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public."XLD_CONFIG_VERSION_ID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: XLD_DB_ARTIFACTS; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."XLD_DB_ARTIFACTS" (
    "ID" character varying(255) NOT NULL,
    data bytea NOT NULL
);


ALTER TABLE public."XLD_DB_ARTIFACTS" OWNER TO postgres;

--
-- Name: XLD_DB_ART_USAGE; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."XLD_DB_ART_USAGE" (
    ci_id integer NOT NULL,
    artifact_id character varying(255) NOT NULL
);


ALTER TABLE public."XLD_DB_ART_USAGE" OWNER TO postgres;

--
-- Name: XLD_DICT_APPLICATIONS; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."XLD_DICT_APPLICATIONS" (
    dictionary_id integer NOT NULL,
    application_id integer NOT NULL
);


ALTER TABLE public."XLD_DICT_APPLICATIONS" OWNER TO postgres;

--
-- Name: XLD_DICT_CONTAINERS; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."XLD_DICT_CONTAINERS" (
    dictionary_id integer NOT NULL,
    container_id integer NOT NULL
);


ALTER TABLE public."XLD_DICT_CONTAINERS" OWNER TO postgres;

--
-- Name: XLD_DICT_ENC_ENTRIES; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."XLD_DICT_ENC_ENTRIES" (
    dictionary_id integer NOT NULL,
    key character varying(255) NOT NULL,
    value text
);


ALTER TABLE public."XLD_DICT_ENC_ENTRIES" OWNER TO postgres;

--
-- Name: XLD_DICT_ENTRIES; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."XLD_DICT_ENTRIES" (
    dictionary_id integer NOT NULL,
    key character varying(255) NOT NULL,
    value text
);


ALTER TABLE public."XLD_DICT_ENTRIES" OWNER TO postgres;

--
-- Name: XLD_ENVIRONMENT_DICTIONARIES; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."XLD_ENVIRONMENT_DICTIONARIES" (
    environment_id integer NOT NULL,
    idx integer NOT NULL,
    dictionary_id integer NOT NULL
);


ALTER TABLE public."XLD_ENVIRONMENT_DICTIONARIES" OWNER TO postgres;

--
-- Name: XLD_ENVIRONMENT_MEMBERS; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."XLD_ENVIRONMENT_MEMBERS" (
    environment_id integer NOT NULL,
    member_id integer NOT NULL
);


ALTER TABLE public."XLD_ENVIRONMENT_MEMBERS" OWNER TO postgres;

--
-- Name: XLD_FILE_ARTIFACTS; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."XLD_FILE_ARTIFACTS" (
    "ID" integer NOT NULL,
    location character varying(255) NOT NULL
);


ALTER TABLE public."XLD_FILE_ARTIFACTS" OWNER TO postgres;

--
-- Name: XLD_FILE_ARTIFACTS_ID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public."XLD_FILE_ARTIFACTS" ALTER COLUMN "ID" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public."XLD_FILE_ARTIFACTS_ID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: XLD_FILE_ART_USAGE; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."XLD_FILE_ART_USAGE" (
    ci_id integer NOT NULL,
    artifact_id integer NOT NULL
);


ALTER TABLE public."XLD_FILE_ART_USAGE" OWNER TO postgres;

--
-- Name: XLD_HOSTS; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."XLD_HOSTS" (
    "ID" integer NOT NULL,
    os character varying(255),
    satellite_id integer,
    address character varying(255),
    port integer,
    username character varying(255)
);


ALTER TABLE public."XLD_HOSTS" OWNER TO postgres;

--
-- Name: XLD_LOCK_TABLE; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."XLD_LOCK_TABLE" (
    "LOCK_NAME" character varying(255) NOT NULL
);


ALTER TABLE public."XLD_LOCK_TABLE" OWNER TO postgres;

--
-- Name: XLD_LOOKUP_VALUES; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."XLD_LOOKUP_VALUES" (
    ci_id integer NOT NULL,
    name character varying(255) NOT NULL,
    key character varying(255) NOT NULL,
    provider integer NOT NULL
);


ALTER TABLE public."XLD_LOOKUP_VALUES" OWNER TO postgres;

--
-- Name: XLD_PENDING_TASKS; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."XLD_PENDING_TASKS" (
    task_id character varying(36) NOT NULL,
    description text NOT NULL,
    task_owner character varying(255) NOT NULL,
    scheduled_date timestamp without time zone,
    worker_address character varying(255),
    task_specification bytea NOT NULL,
    is_sent_to_queue boolean DEFAULT false NOT NULL
);


ALTER TABLE public."XLD_PENDING_TASKS" OWNER TO postgres;

--
-- Name: XLD_PENDING_TASKS_METADATA; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."XLD_PENDING_TASKS_METADATA" (
    task_id character varying(36) NOT NULL,
    metadata_key character varying(255) NOT NULL,
    metadata_value text
);


ALTER TABLE public."XLD_PENDING_TASKS_METADATA" OWNER TO postgres;

--
-- Name: XLD_PLACEHOLDERS; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."XLD_PLACEHOLDERS" (
    "ID" character varying(255) NOT NULL,
    encrypted boolean NOT NULL,
    key character varying(255) NOT NULL,
    value character varying(255),
    dictionary_id character varying(255) NOT NULL,
    dictionary_name character varying(255) NOT NULL,
    dictionary_deleted smallint NOT NULL,
    container_id character varying(255),
    container_name character varying(255),
    container_deleted smallint,
    environment_id character varying(255) NOT NULL,
    environment_name character varying(255) NOT NULL,
    environment_deleted smallint NOT NULL,
    deployed_app_id character varying(255) NOT NULL,
    deployed_app_name character varying(255) NOT NULL,
    version_id character varying(255) NOT NULL,
    task_id character varying(255) NOT NULL,
    full_value text
);


ALTER TABLE public."XLD_PLACEHOLDERS" OWNER TO postgres;

--
-- Name: XLD_PROFILES; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."XLD_PROFILES" (
    "USERNAME" character varying(255) NOT NULL,
    "LAST_LOGIN_TIME" timestamp without time zone NOT NULL
);


ALTER TABLE public."XLD_PROFILES" OWNER TO postgres;

--
-- Name: XLD_SATELLITES; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."XLD_SATELLITES" (
    "ID" integer NOT NULL,
    address character varying(255),
    "protocolPort" integer,
    encrypted boolean
);


ALTER TABLE public."XLD_SATELLITES" OWNER TO postgres;

--
-- Name: XLD_SAT_GROUP_SATELLITES; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."XLD_SAT_GROUP_SATELLITES" (
    group_id integer NOT NULL,
    satellite_id integer NOT NULL
);


ALTER TABLE public."XLD_SAT_GROUP_SATELLITES" OWNER TO postgres;

--
-- Name: XLD_SCM_TRACEABILITY_DATA; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."XLD_SCM_TRACEABILITY_DATA" (
    "ID" integer NOT NULL,
    kind character varying(255),
    commit character varying(255),
    author character varying(255),
    date timestamp without time zone,
    message text,
    remote character varying(1000),
    file_name character varying(1000)
);


ALTER TABLE public."XLD_SCM_TRACEABILITY_DATA" OWNER TO postgres;

--
-- Name: XLD_SCM_TRACEABILITY_DATA_ID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public."XLD_SCM_TRACEABILITY_DATA" ALTER COLUMN "ID" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public."XLD_SCM_TRACEABILITY_DATA_ID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: XLD_SOURCE_ARTIFACTS; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."XLD_SOURCE_ARTIFACTS" (
    "ID" integer NOT NULL,
    checksum character varying(255) NOT NULL,
    file_uri character varying(2000) NOT NULL,
    filename character varying(255)
);


ALTER TABLE public."XLD_SOURCE_ARTIFACTS" OWNER TO postgres;

--
-- Name: XLD_STITCH_CONTENT; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."XLD_STITCH_CONTENT" (
    "ID" character varying(36) NOT NULL,
    "SOURCE_ID" integer NOT NULL,
    "FILE_CONTENT" text,
    "FILE_NAME" character varying(850),
    "BRANCH_NAME" character varying(255)
);


ALTER TABLE public."XLD_STITCH_CONTENT" OWNER TO postgres;

--
-- Name: XLD_STITCH_DEFINITION; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."XLD_STITCH_DEFINITION" (
    "ID" character varying(36) NOT NULL,
    "NAMESPACE_ID" character varying(36) NOT NULL,
    "SOURCE_ID" integer NOT NULL,
    "KIND" character varying(255),
    "CONTENT_ID" character varying(36) NOT NULL,
    "BRANCH_NAME" character varying(255)
);


ALTER TABLE public."XLD_STITCH_DEFINITION" OWNER TO postgres;

--
-- Name: XLD_STITCH_MACROS; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."XLD_STITCH_MACROS" (
    "ID" character varying(36) NOT NULL,
    "NAMESPACE_ID" character varying(36) NOT NULL,
    "DEFINITION_ID" character varying(36) NOT NULL,
    "SOURCE_ID" integer NOT NULL,
    "NAME" character varying(255) NOT NULL,
    "DESCRIPTION" text,
    "CONTENT_ID" character varying(36) NOT NULL,
    "SNIPPET_START" integer NOT NULL,
    "SNIPPET_END" integer NOT NULL,
    "BRANCH_NAME" character varying(255)
);


ALTER TABLE public."XLD_STITCH_MACROS" OWNER TO postgres;

--
-- Name: XLD_STITCH_MACRO_PARAMETERS; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."XLD_STITCH_MACRO_PARAMETERS" (
    "ID" character varying(36) NOT NULL,
    "MACRO_ID" character varying(36) NOT NULL,
    "SOURCE_ID" integer NOT NULL,
    "NAME" character varying(255) NOT NULL,
    "VALUE" text
);


ALTER TABLE public."XLD_STITCH_MACRO_PARAMETERS" OWNER TO postgres;

--
-- Name: XLD_STITCH_MACRO_PROCESSORS; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."XLD_STITCH_MACRO_PROCESSORS" (
    "PROCESSOR_ID" character varying(36) NOT NULL,
    "MACRO_ID" character varying(36) NOT NULL
);


ALTER TABLE public."XLD_STITCH_MACRO_PROCESSORS" OWNER TO postgres;

--
-- Name: XLD_STITCH_MACRO_PROC_PARAMS; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."XLD_STITCH_MACRO_PROC_PARAMS" (
    "PROCESSOR_PARAM_ID" character varying(36) NOT NULL,
    "PROCESSOR_ID" character varying(36) NOT NULL
);


ALTER TABLE public."XLD_STITCH_MACRO_PROC_PARAMS" OWNER TO postgres;

--
-- Name: XLD_STITCH_NAMESPACES; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."XLD_STITCH_NAMESPACES" (
    "ID" character varying(36) NOT NULL,
    "NAME" character varying(255) NOT NULL
);


ALTER TABLE public."XLD_STITCH_NAMESPACES" OWNER TO postgres;

--
-- Name: XLD_STITCH_PROCESSORS; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."XLD_STITCH_PROCESSORS" (
    "ID" character varying(36) NOT NULL,
    "NAMESPACE_ID" character varying(36) NOT NULL,
    "DEFINITION_ID" character varying(36) NOT NULL,
    "SOURCE_ID" integer NOT NULL,
    "TYPE" character varying(255) NOT NULL,
    "WEIGHT" integer,
    "ORDER" integer NOT NULL,
    "MERGE_TYPE" character varying(255),
    "MERGE_PATH" character varying(255),
    "DESCRIPTION" text,
    "PHASE" integer
);


ALTER TABLE public."XLD_STITCH_PROCESSORS" OWNER TO postgres;

--
-- Name: XLD_STITCH_PROCESSOR_PARAMS; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."XLD_STITCH_PROCESSOR_PARAMS" (
    "ID" character varying(36) NOT NULL,
    "SOURCE_ID" integer NOT NULL,
    "NAME" character varying(255) NOT NULL,
    "VALUE" text,
    "FILE_CONTENT" text
);


ALTER TABLE public."XLD_STITCH_PROCESSOR_PARAMS" OWNER TO postgres;

--
-- Name: XLD_STITCH_RULES; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."XLD_STITCH_RULES" (
    "ID" character varying(36) NOT NULL,
    "NAMESPACE_ID" character varying(36) NOT NULL,
    "DEFINITION_ID" character varying(36) NOT NULL,
    "SOURCE_ID" integer NOT NULL,
    "NAME" character varying(255) NOT NULL,
    "DESCRIPTION" text,
    "CONTENT_ID" character varying(36) NOT NULL,
    "SNIPPET_START" integer NOT NULL,
    "SNIPPET_END" integer NOT NULL,
    "BRANCH_NAME" character varying(255)
);


ALTER TABLE public."XLD_STITCH_RULES" OWNER TO postgres;

--
-- Name: XLD_STITCH_RULE_CONDITIONS; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."XLD_STITCH_RULE_CONDITIONS" (
    "ID" character varying(36) NOT NULL,
    "SOURCE_ID" integer NOT NULL,
    "RULE_ID" character varying(36) NOT NULL,
    "NAME" character varying(255) NOT NULL,
    "VALUE" text
);


ALTER TABLE public."XLD_STITCH_RULE_CONDITIONS" OWNER TO postgres;

--
-- Name: XLD_STITCH_RULE_PROCESSORS; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."XLD_STITCH_RULE_PROCESSORS" (
    "PROCESSOR_ID" character varying(36) NOT NULL,
    "RULE_ID" character varying(36) NOT NULL
);


ALTER TABLE public."XLD_STITCH_RULE_PROCESSORS" OWNER TO postgres;

--
-- Name: XLD_STITCH_RULE_PROC_PARAMS; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."XLD_STITCH_RULE_PROC_PARAMS" (
    "PROCESSOR_PARAM_ID" character varying(36) NOT NULL,
    "PROCESSOR_ID" character varying(36) NOT NULL
);


ALTER TABLE public."XLD_STITCH_RULE_PROC_PARAMS" OWNER TO postgres;

--
-- Name: XLD_STITCH_SOURCE_SYNC_STATE; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."XLD_STITCH_SOURCE_SYNC_STATE" (
    "ID" character varying(36) NOT NULL,
    "SOURCE_ID" integer NOT NULL,
    "STATUS" character varying(255) NOT NULL,
    "REASON" character varying(850),
    "LOG" text,
    "START_DATE" timestamp without time zone,
    "END_DATE" timestamp without time zone,
    "LAST_SYNC_TASK_ID" character varying(255),
    "COMMIT_HASH" character varying(255),
    "COMMIT_AUTHOR" character varying(255),
    "BRANCH_NAME" character varying(255)
);


ALTER TABLE public."XLD_STITCH_SOURCE_SYNC_STATE" OWNER TO postgres;

--
-- Name: XLD_USER_CREDENTIALS; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."XLD_USER_CREDENTIALS" (
    "ID" bigint NOT NULL,
    "PROFILE_USERNAME" character varying(255),
    "LABEL" character varying(255) NOT NULL,
    "CREDENTIALS_USERNAME" character varying(255) NOT NULL,
    "EMAIL" character varying(255) NOT NULL,
    "PASSWORD" text,
    "PASSPHRASE" text,
    "PRIVATE_KEY" text
);


ALTER TABLE public."XLD_USER_CREDENTIALS" OWNER TO postgres;

--
-- Name: XLD_USER_CREDENTIALS_ID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public."XLD_USER_CREDENTIALS" ALTER COLUMN "ID" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public."XLD_USER_CREDENTIALS_ID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: XLD_USER_DEFAULT_CREDENTIALS; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."XLD_USER_DEFAULT_CREDENTIALS" (
    "PROFILE_USERNAME" character varying(255) NOT NULL,
    "USER_CREDENTIALS_ID" bigint
);


ALTER TABLE public."XLD_USER_DEFAULT_CREDENTIALS" OWNER TO postgres;

--
-- Name: XLD_USER_PROFILES; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."XLD_USER_PROFILES" (
    "USERNAME" character varying(255) NOT NULL
);


ALTER TABLE public."XLD_USER_PROFILES" OWNER TO postgres;

--
-- Name: XLD_WORKERS; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."XLD_WORKERS" (
    "ID" integer NOT NULL,
    name character varying(255),
    address character varying(255) NOT NULL,
    configuration_hash character varying(255) NOT NULL,
    public_key bytea
);


ALTER TABLE public."XLD_WORKERS" OWNER TO postgres;

--
-- Name: XLD_WORKERS_ID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public."XLD_WORKERS" ALTER COLUMN "ID" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public."XLD_WORKERS_ID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: XL_METADATA; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."XL_METADATA" (
    name character varying(255) NOT NULL,
    value character varying(255)
);


ALTER TABLE public."XL_METADATA" OWNER TO postgres;

--
-- Name: XL_ROLES; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."XL_ROLES" (
    "ID" character varying(255) NOT NULL,
    "NAME" character varying(255) NOT NULL,
    "CI_ID" integer NOT NULL
);


ALTER TABLE public."XL_ROLES" OWNER TO postgres;

--
-- Name: XL_ROLE_PERMISSIONS; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."XL_ROLE_PERMISSIONS" (
    "ROLE_ID" character varying(255) NOT NULL,
    "PERMISSION_NAME" character varying(255) NOT NULL,
    "CI_ID" integer NOT NULL
);


ALTER TABLE public."XL_ROLE_PERMISSIONS" OWNER TO postgres;

--
-- Name: XL_ROLE_PRINCIPALS; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."XL_ROLE_PRINCIPALS" (
    "ROLE_ID" character varying(255) NOT NULL,
    "PRINCIPAL_NAME" character varying(255) NOT NULL
);


ALTER TABLE public."XL_ROLE_PRINCIPALS" OWNER TO postgres;

--
-- Name: XL_ROLE_ROLES; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."XL_ROLE_ROLES" (
    "ROLE_ID" character varying(255) NOT NULL,
    "MEMBER_ROLE_ID" character varying(255) NOT NULL
);


ALTER TABLE public."XL_ROLE_ROLES" OWNER TO postgres;

--
-- Name: XL_USERS; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."XL_USERS" (
    "USERNAME" character varying(255) NOT NULL,
    "PASSWORD" character varying(255) NOT NULL
);


ALTER TABLE public."XL_USERS" OWNER TO postgres;

--
-- Name: XL_VERSION; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."XL_VERSION" (
    component character varying(255) NOT NULL,
    version character varying(255) NOT NULL
);


ALTER TABLE public."XL_VERSION" OWNER TO postgres;

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
-- Name: spring_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.spring_session (
    primary_id character(36) NOT NULL,
    session_id character(36) NOT NULL,
    creation_time bigint NOT NULL,
    last_access_time bigint NOT NULL,
    max_inactive_interval integer NOT NULL,
    expiry_time bigint NOT NULL,
    principal_name character varying(255)
);


ALTER TABLE public.spring_session OWNER TO postgres;

--
-- Name: spring_session_attributes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.spring_session_attributes (
    session_primary_id character(36) NOT NULL,
    attribute_name character varying(200) NOT NULL,
    attribute_bytes bytea NOT NULL
);


ALTER TABLE public.spring_session_attributes OWNER TO postgres;

--
-- Data for Name: PERSISTENT_LOGINS; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."PERSISTENT_LOGINS" (series, username, token, last_used) FROM stdin;
\.


--
-- Data for Name: XLD_ACTIVE_TASKS; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."XLD_ACTIVE_TASKS" (task_id, description, task_owner, worker_id) FROM stdin;
\.


--
-- Data for Name: XLD_ACTIVE_TASKS_METADATA; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."XLD_ACTIVE_TASKS_METADATA" (task_id, metadata_key, metadata_value) FROM stdin;
\.


--
-- Data for Name: XLD_ARCHIVED_CONTROL_TASKS; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."XLD_ARCHIVED_CONTROL_TASKS" (task_id, control_task_name, target_ci, description, owner, status, failure_count, start_date, end_date, target_internal_id, target_secured_ci, worker_name) FROM stdin;
\.


--
-- Data for Name: XLD_ARCHIVED_DEPLOYMENT_TASKS; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."XLD_ARCHIVED_DEPLOYMENT_TASKS" (task_id, main_application, packages, environment, task_type, owner, status, failure_count, start_date, end_date, duration, rolled_back, environment_internal_id, environment_secured_ci, worker_name) FROM stdin;
\.


--
-- Data for Name: XLD_ARCHIVED_DT_APPLICATIONS; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."XLD_ARCHIVED_DT_APPLICATIONS" (task_id, application, application_internal_id, application_secured_ci) FROM stdin;
\.


--
-- Data for Name: XLD_ARCHIVED_PLACEHOLDERS; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."XLD_ARCHIVED_PLACEHOLDERS" ("ID", encrypted, key, value, dictionary_id, dictionary_name, dictionary_deleted, container_id, container_name, container_deleted, environment_id, environment_name, environment_deleted, deployed_app_id, deployed_app_name, version_id, task_id, full_value) FROM stdin;
\.


--
-- Data for Name: XLD_ARCHIVED_TASKS; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."XLD_ARCHIVED_TASKS" (task_id, task_kind, task_details, worker_name) FROM stdin;
\.


--
-- Data for Name: XLD_ARCHIVED_UNKNOWN_TASKS; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."XLD_ARCHIVED_UNKNOWN_TASKS" (task_id, start_date) FROM stdin;
\.


--
-- Data for Name: XLD_ARCHIVE_ROLES; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."XLD_ARCHIVE_ROLES" ("ID", "NAME", "CI_ID") FROM stdin;
b26b3abf-b924-452c-9c9b-ed1b8d530789	deploy_admin_read_only	-1
\.


--
-- Data for Name: XLD_ARCHIVE_ROLE_PERMISSIONS; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."XLD_ARCHIVE_ROLE_PERMISSIONS" ("ROLE_ID", "PERMISSION_NAME", "CI_ID") FROM stdin;
b26b3abf-b924-452c-9c9b-ed1b8d530789	login	-1
b26b3abf-b924-452c-9c9b-ed1b8d530789	stitch#view	-1
b26b3abf-b924-452c-9c9b-ed1b8d530789	report#view	-1
b26b3abf-b924-452c-9c9b-ed1b8d530789	task#preview_step	-1
b26b3abf-b924-452c-9c9b-ed1b8d530789	security#view	-1
b26b3abf-b924-452c-9c9b-ed1b8d530789	task#view	-1
b26b3abf-b924-452c-9c9b-ed1b8d530789	read	3
b26b3abf-b924-452c-9c9b-ed1b8d530789	read	2
b26b3abf-b924-452c-9c9b-ed1b8d530789	read	4
b26b3abf-b924-452c-9c9b-ed1b8d530789	read	1
\.


--
-- Data for Name: XLD_ARCHIVE_ROLE_PRINCIPALS; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."XLD_ARCHIVE_ROLE_PRINCIPALS" ("ROLE_ID", "PRINCIPAL_NAME") FROM stdin;
\.


--
-- Data for Name: XLD_ARCHIVE_ROLE_ROLES; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."XLD_ARCHIVE_ROLE_ROLES" ("ROLE_ID", "MEMBER_ROLE_ID") FROM stdin;
\.


--
-- Data for Name: XLD_BANNER; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."XLD_BANNER" (kind, content) FROM stdin;
\.


--
-- Data for Name: XLD_CIS; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."XLD_CIS" ("ID", ci_type, name, parent_id, token, created_at, created_by, modified_at, modified_by, path, secured_ci, scm_traceability_data_id) FROM stdin;
3	internal.Root	Applications	\N	21e02868-7b42-4e6f-b87f-85348f61a538	2023-08-24 11:34:22.134	\N	2023-08-24 11:34:22.134	\N	/Applications	3	\N
2	internal.Root	Environments	\N	13143d71-5bd9-4afc-8909-69d7b42fbb6f	2023-08-24 11:34:22.134	\N	2023-08-24 11:34:22.134	\N	/Environments	2	\N
4	internal.Root	Infrastructure	\N	3f4b8837-22c8-43d1-8100-62826257d95b	2023-08-24 11:34:22.134	\N	2023-08-24 11:34:22.134	\N	/Infrastructure	4	\N
1	internal.Root	Configuration	\N	892d5255-729b-4d5a-bf6b-6212bd054588	2023-08-24 11:34:22.134	\N	2023-08-24 11:34:22.134	\N	/Configuration	1	\N
\.


--
-- Data for Name: XLD_CI_HISTORY; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."XLD_CI_HISTORY" ("ID", ci_id, changed_at, changed_by, ci) FROM stdin;
1	1	2023-08-24 11:34:22.134	<system>	{"id":"Configuration","type":"internal.Root"}
2	2	2023-08-24 11:34:22.134	<system>	{"id":"Environments","type":"internal.Root"}
3	3	2023-08-24 11:34:22.134	<system>	{"id":"Applications","type":"internal.Root"}
4	4	2023-08-24 11:34:22.134	<system>	{"id":"Infrastructure","type":"internal.Root"}
\.


--
-- Data for Name: XLD_CI_LOCK; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."XLD_CI_LOCK" ("CI_ID", task_id) FROM stdin;
\.


--
-- Data for Name: XLD_CI_PLACEHOLDERS; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."XLD_CI_PLACEHOLDERS" ("ID", key, ci_path, ci_name, ci_type) FROM stdin;
\.


--
-- Data for Name: XLD_CI_PROPERTIES; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."XLD_CI_PROPERTIES" ("ID", ci_id, name, key, idx, boolean_value, integer_value, string_value, date_value, ci_ref_value) FROM stdin;
\.


--
-- Data for Name: XLD_CONFIG_VERSION; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."XLD_CONFIG_VERSION" ("ID", hash, boot_date_time) FROM stdin;
1	d0a1af8211819fc22c561e895232d879622ee1d7ae6a6e12b43b39f65a5e7079	2023-08-24 11:34:25.215
\.


--
-- Data for Name: XLD_DB_ARTIFACTS; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."XLD_DB_ARTIFACTS" ("ID", data) FROM stdin;
\.


--
-- Data for Name: XLD_DB_ART_USAGE; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."XLD_DB_ART_USAGE" (ci_id, artifact_id) FROM stdin;
\.


--
-- Data for Name: XLD_DICT_APPLICATIONS; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."XLD_DICT_APPLICATIONS" (dictionary_id, application_id) FROM stdin;
\.


--
-- Data for Name: XLD_DICT_CONTAINERS; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."XLD_DICT_CONTAINERS" (dictionary_id, container_id) FROM stdin;
\.


--
-- Data for Name: XLD_DICT_ENC_ENTRIES; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."XLD_DICT_ENC_ENTRIES" (dictionary_id, key, value) FROM stdin;
\.


--
-- Data for Name: XLD_DICT_ENTRIES; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."XLD_DICT_ENTRIES" (dictionary_id, key, value) FROM stdin;
\.


--
-- Data for Name: XLD_ENVIRONMENT_DICTIONARIES; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."XLD_ENVIRONMENT_DICTIONARIES" (environment_id, idx, dictionary_id) FROM stdin;
\.


--
-- Data for Name: XLD_ENVIRONMENT_MEMBERS; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."XLD_ENVIRONMENT_MEMBERS" (environment_id, member_id) FROM stdin;
\.


--
-- Data for Name: XLD_FILE_ARTIFACTS; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."XLD_FILE_ARTIFACTS" ("ID", location) FROM stdin;
\.


--
-- Data for Name: XLD_FILE_ART_USAGE; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."XLD_FILE_ART_USAGE" (ci_id, artifact_id) FROM stdin;
\.


--
-- Data for Name: XLD_HOSTS; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."XLD_HOSTS" ("ID", os, satellite_id, address, port, username) FROM stdin;
\.


--
-- Data for Name: XLD_LOCK_TABLE; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."XLD_LOCK_TABLE" ("LOCK_NAME") FROM stdin;
XLD_PROFILES_LOCK
XLD_WORKERS_LOCK
\.


--
-- Data for Name: XLD_LOOKUP_VALUES; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."XLD_LOOKUP_VALUES" (ci_id, name, key, provider) FROM stdin;
\.


--
-- Data for Name: XLD_PENDING_TASKS; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."XLD_PENDING_TASKS" (task_id, description, task_owner, scheduled_date, worker_address, task_specification, is_sent_to_queue) FROM stdin;
\.


--
-- Data for Name: XLD_PENDING_TASKS_METADATA; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."XLD_PENDING_TASKS_METADATA" (task_id, metadata_key, metadata_value) FROM stdin;
\.


--
-- Data for Name: XLD_PLACEHOLDERS; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."XLD_PLACEHOLDERS" ("ID", encrypted, key, value, dictionary_id, dictionary_name, dictionary_deleted, container_id, container_name, container_deleted, environment_id, environment_name, environment_deleted, deployed_app_id, deployed_app_name, version_id, task_id, full_value) FROM stdin;
\.


--
-- Data for Name: XLD_PROFILES; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."XLD_PROFILES" ("USERNAME", "LAST_LOGIN_TIME") FROM stdin;
\.


--
-- Data for Name: XLD_SATELLITES; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."XLD_SATELLITES" ("ID", address, "protocolPort", encrypted) FROM stdin;
\.


--
-- Data for Name: XLD_SAT_GROUP_SATELLITES; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."XLD_SAT_GROUP_SATELLITES" (group_id, satellite_id) FROM stdin;
\.


--
-- Data for Name: XLD_SCM_TRACEABILITY_DATA; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."XLD_SCM_TRACEABILITY_DATA" ("ID", kind, commit, author, date, message, remote, file_name) FROM stdin;
\.


--
-- Data for Name: XLD_SOURCE_ARTIFACTS; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."XLD_SOURCE_ARTIFACTS" ("ID", checksum, file_uri, filename) FROM stdin;
\.


--
-- Data for Name: XLD_STITCH_CONTENT; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."XLD_STITCH_CONTENT" ("ID", "SOURCE_ID", "FILE_CONTENT", "FILE_NAME", "BRANCH_NAME") FROM stdin;
\.


--
-- Data for Name: XLD_STITCH_DEFINITION; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."XLD_STITCH_DEFINITION" ("ID", "NAMESPACE_ID", "SOURCE_ID", "KIND", "CONTENT_ID", "BRANCH_NAME") FROM stdin;
\.


--
-- Data for Name: XLD_STITCH_MACROS; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."XLD_STITCH_MACROS" ("ID", "NAMESPACE_ID", "DEFINITION_ID", "SOURCE_ID", "NAME", "DESCRIPTION", "CONTENT_ID", "SNIPPET_START", "SNIPPET_END", "BRANCH_NAME") FROM stdin;
\.


--
-- Data for Name: XLD_STITCH_MACRO_PARAMETERS; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."XLD_STITCH_MACRO_PARAMETERS" ("ID", "MACRO_ID", "SOURCE_ID", "NAME", "VALUE") FROM stdin;
\.


--
-- Data for Name: XLD_STITCH_MACRO_PROCESSORS; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."XLD_STITCH_MACRO_PROCESSORS" ("PROCESSOR_ID", "MACRO_ID") FROM stdin;
\.


--
-- Data for Name: XLD_STITCH_MACRO_PROC_PARAMS; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."XLD_STITCH_MACRO_PROC_PARAMS" ("PROCESSOR_PARAM_ID", "PROCESSOR_ID") FROM stdin;
\.


--
-- Data for Name: XLD_STITCH_NAMESPACES; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."XLD_STITCH_NAMESPACES" ("ID", "NAME") FROM stdin;
\.


--
-- Data for Name: XLD_STITCH_PROCESSORS; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."XLD_STITCH_PROCESSORS" ("ID", "NAMESPACE_ID", "DEFINITION_ID", "SOURCE_ID", "TYPE", "WEIGHT", "ORDER", "MERGE_TYPE", "MERGE_PATH", "DESCRIPTION", "PHASE") FROM stdin;
\.


--
-- Data for Name: XLD_STITCH_PROCESSOR_PARAMS; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."XLD_STITCH_PROCESSOR_PARAMS" ("ID", "SOURCE_ID", "NAME", "VALUE", "FILE_CONTENT") FROM stdin;
\.


--
-- Data for Name: XLD_STITCH_RULES; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."XLD_STITCH_RULES" ("ID", "NAMESPACE_ID", "DEFINITION_ID", "SOURCE_ID", "NAME", "DESCRIPTION", "CONTENT_ID", "SNIPPET_START", "SNIPPET_END", "BRANCH_NAME") FROM stdin;
\.


--
-- Data for Name: XLD_STITCH_RULE_CONDITIONS; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."XLD_STITCH_RULE_CONDITIONS" ("ID", "SOURCE_ID", "RULE_ID", "NAME", "VALUE") FROM stdin;
\.


--
-- Data for Name: XLD_STITCH_RULE_PROCESSORS; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."XLD_STITCH_RULE_PROCESSORS" ("PROCESSOR_ID", "RULE_ID") FROM stdin;
\.


--
-- Data for Name: XLD_STITCH_RULE_PROC_PARAMS; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."XLD_STITCH_RULE_PROC_PARAMS" ("PROCESSOR_PARAM_ID", "PROCESSOR_ID") FROM stdin;
\.


--
-- Data for Name: XLD_STITCH_SOURCE_SYNC_STATE; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."XLD_STITCH_SOURCE_SYNC_STATE" ("ID", "SOURCE_ID", "STATUS", "REASON", "LOG", "START_DATE", "END_DATE", "LAST_SYNC_TASK_ID", "COMMIT_HASH", "COMMIT_AUTHOR", "BRANCH_NAME") FROM stdin;
\.


--
-- Data for Name: XLD_USER_CREDENTIALS; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."XLD_USER_CREDENTIALS" ("ID", "PROFILE_USERNAME", "LABEL", "CREDENTIALS_USERNAME", "EMAIL", "PASSWORD", "PASSPHRASE", "PRIVATE_KEY") FROM stdin;
\.


--
-- Data for Name: XLD_USER_DEFAULT_CREDENTIALS; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."XLD_USER_DEFAULT_CREDENTIALS" ("PROFILE_USERNAME", "USER_CREDENTIALS_ID") FROM stdin;
\.


--
-- Data for Name: XLD_USER_PROFILES; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."XLD_USER_PROFILES" ("USERNAME") FROM stdin;
admin
\.


--
-- Data for Name: XLD_WORKERS; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."XLD_WORKERS" ("ID", name, address, configuration_hash, public_key) FROM stdin;
1	digital-ai-digitalai-deploy-worker-0.digitalai-deploy:8180	akka.tcp://task-sys@digital-ai-digitalai-deploy-worker-0.digitalai-deploy:8180	d0a1af8211819fc22c561e895232d879622ee1d7ae6a6e12b43b39f65a5e7079	\\x30820122300d06092a864886f70d01010105000382010f003082010a028201010094ed8dc4325e3f5bc67f32cca208e4323ff24bb235667778faf04e10d9f3186ab1caa4e0224b26659ac72dcd1500a851ec6409fbb8f0795cba5deea16ce4145d4b6af534cf8a930e7921773e2c0fc3920db705e7ab90c0f5025a96047107959b12cef547c18b5351d804ea4e53478bc1f47b2a6e4ef6d9e7d85190b9174f5cb0fabcb3442ec0b9a30f89f03f837540a5b6cc41f3fe2f99789a51cbc9404d435727656b7db04fc8c6495c8697d6c645c5d0e960e4838c5540f2d17596228ebf5b92012f5c82bd01298efa586ea4e36a45d9af81b648352b51be2be94e311ef95433c52d51991e0b1520bb8a49c674cbe19ad6232b005315ba6d58cd4b437114c50203010001
\.


--
-- Data for Name: XL_METADATA; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."XL_METADATA" (name, value) FROM stdin;
\.


--
-- Data for Name: XL_ROLES; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."XL_ROLES" ("ID", "NAME", "CI_ID") FROM stdin;
b26b3abf-b924-452c-9c9b-ed1b8d530789	deploy_admin_read_only	-1
\.


--
-- Data for Name: XL_ROLE_PERMISSIONS; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."XL_ROLE_PERMISSIONS" ("ROLE_ID", "PERMISSION_NAME", "CI_ID") FROM stdin;
b26b3abf-b924-452c-9c9b-ed1b8d530789	login	-1
b26b3abf-b924-452c-9c9b-ed1b8d530789	stitch#view	-1
b26b3abf-b924-452c-9c9b-ed1b8d530789	report#view	-1
b26b3abf-b924-452c-9c9b-ed1b8d530789	task#preview_step	-1
b26b3abf-b924-452c-9c9b-ed1b8d530789	security#view	-1
b26b3abf-b924-452c-9c9b-ed1b8d530789	task#view	-1
b26b3abf-b924-452c-9c9b-ed1b8d530789	read	3
b26b3abf-b924-452c-9c9b-ed1b8d530789	read	2
b26b3abf-b924-452c-9c9b-ed1b8d530789	read	4
b26b3abf-b924-452c-9c9b-ed1b8d530789	read	1
\.


--
-- Data for Name: XL_ROLE_PRINCIPALS; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."XL_ROLE_PRINCIPALS" ("ROLE_ID", "PRINCIPAL_NAME") FROM stdin;
\.


--
-- Data for Name: XL_ROLE_ROLES; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."XL_ROLE_ROLES" ("ROLE_ID", "MEMBER_ROLE_ID") FROM stdin;
\.


--
-- Data for Name: XL_USERS; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."XL_USERS" ("USERNAME", "PASSWORD") FROM stdin;
admin	{SHA-256}f75a4a6136aec7ef-1000-0eaa9105bbcf69cc3565a3ea1e00a40295eeb2eec8e5320acca5014971d95c78
\.


--
-- Data for Name: XL_VERSION; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."XL_VERSION" (component, version) FROM stdin;
deployit	10.0.1
xld-patch-dictionary-plugin	10.0.14
base-plugin	10.0.14
command-plugin	10.0.14
database-plugin	10.0.14
deployment-checklist-plugin	10.0.14
file-plugin	10.0.14
generic-plugin	10.0.14
glassfish-plugin	10.0.0
group-orchestrator-plugin	10.0.14
iis-plugin	10.0.2
jbossas-plugin	10.0.0
jbossdm-plugin	10.0.0
jee-plugin	10.0.14
lock-plugin	10.0.14
policy-plugin	10.0.14
powershell-plugin	10.0.14
python-plugin	10.0.14
remoting-plugin	10.0.14
tomcat-plugin	6.2.0
trigger-plugin	10.0.14
was-plugin	10.0.3
webserver-plugin	10.0.14
windows-plugin	6.0.0
wlp-plugin	10.0.3
wls-plugin	10.0.2
xld-aws-plugin	10.0.6
xld-azure-plugin	10.0.5
xld-chef-plugin	10.0.0
xld-ci-explorer	10.0.14
xld-cloud-foundry-plugin	10.0.0
xld-compare-plugin	10.0.0
xld-cyberark-conjur-plugin	10.0.14
xld-docker-plugin	10.0.5
xld-hashicorp-vault-plugin	10.0.14
xld-kubernetes-plugin	10.0.6
xld-openshift-plugin	10.0.1
xld-puppet-plugin	10.0.0
xld-script-plugin	10.0.0
xld-stitch-workbench	10.0.14
xld-terraform-plugin	10.0.2
\.


--
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
1	XebiaLabs	MIGRATE_CIS	2023-08-24 11:34:02.79348	1	EXECUTED	8:4bd5452ec9fc8a3706dbea36a4b2b5d3	createTable tableName=XLD_CIS		\N	4.2.0	\N	\N	2876842386
2	XebiaLabs	MIGRATE_CIS	2023-08-24 11:34:02.832366	2	EXECUTED	8:1de436ba7660d1fc5dc1f4a14c1ca158	addForeignKeyConstraint baseTableName=XLD_CIS, constraintName=FK_XLD_CI_PARENT_ID, referencedTableName=XLD_CIS; createIndex indexName=XLD_CIS_CI_TYPE_IDX, tableName=XLD_CIS; createIndex indexName=XLD_CIS_PARENT_IDX, tableName=XLD_CIS; createIndex ...		\N	4.2.0	\N	\N	2876842386
1	XebiaLabs	CI_HISTORY	2023-08-24 11:34:02.847611	3	EXECUTED	8:64fd817236f65d673a43c4e5906677de	createTable tableName=XLD_CI_HISTORY; addForeignKeyConstraint baseTableName=XLD_CI_HISTORY, constraintName=FK_XLD_CI_HISTORY_CI_ID, referencedTableName=XLD_CIS; createIndex indexName=XLD_CI_HISTORY_CI_ID_IDX, tableName=XLD_CI_HISTORY		\N	4.2.0	\N	\N	2876842386
1	XebiaLabs	HOSTS	2023-08-24 11:34:02.867943	4	EXECUTED	8:b02c7534f1045197838c775ad115f7b7	createTable tableName=XLD_HOSTS; addForeignKeyConstraint baseTableName=XLD_HOSTS, constraintName=FK_XLD_HOSTS_ID, referencedTableName=XLD_CIS; addForeignKeyConstraint baseTableName=XLD_HOSTS, constraintName=FK_XLD_HOSTS_SATELLITE_ID, referencedTab...		\N	4.2.0	\N	\N	2876842386
1	XebiaLabs	SATELLITES	2023-08-24 11:34:02.876813	5	EXECUTED	8:4f533c147559e6fd6609b7fdd843da98	createTable tableName=XLD_SATELLITES; addForeignKeyConstraint baseTableName=XLD_SATELLITES, constraintName=FK_XLD_SATELLITES_ID, referencedTableName=XLD_CIS		\N	4.2.0	\N	\N	2876842386
3	XebiaLabs	SATELLITES	2023-08-24 11:34:02.894092	6	EXECUTED	8:213da451a5551a9f353e33a2abc6c8b2	createTable tableName=XLD_SAT_GROUP_SATELLITES; addPrimaryKey constraintName=PK_XLD_SAT_GROUP_SATELLITES, tableName=XLD_SAT_GROUP_SATELLITES; addForeignKeyConstraint baseTableName=XLD_SAT_GROUP_SATELLITES, constraintName=FK_XLD_SAT_GROUP_GROUP, re...		\N	4.2.0	\N	\N	2876842386
1	XebiaLabs	SECURITY_REMEMBERME	2023-08-24 11:34:02.901958	7	EXECUTED	8:f28164910a20f8e5cdf5135db52e5806	createTable tableName=PERSISTENT_LOGINS		\N	4.2.0	\N	\N	2876842386
1	XebiaLabs	SECURITY_REMEMBERME_RECREATE	2023-08-24 11:34:02.922313	8	EXECUTED	8:639ddd684a6324f2be7647523b4e5885	sql		\N	4.2.0	\N	\N	2876842386
2	XebiaLabs	SECURITY_REMEMBERME_RECREATE	2023-08-24 11:34:02.946913	9	EXECUTED	8:f28164910a20f8e5cdf5135db52e5806	createTable tableName=PERSISTENT_LOGINS		\N	4.2.0	\N	\N	2876842386
1	XebiaLabs	SOURCE_ARTIFACTS	2023-08-24 11:34:02.965073	10	EXECUTED	8:a8b65eca22866a5585c3e607383a0466	createTable tableName=XLD_SOURCE_ARTIFACTS; addForeignKeyConstraint baseTableName=XLD_SOURCE_ARTIFACTS, constraintName=FK_XLD_SOURCE_ARTIFACTS_ID, referencedTableName=XLD_CIS		\N	4.2.0	\N	\N	2876842386
2	XebiaLabs	SOURCE_ARTIFACTS	2023-08-24 11:34:02.98275	11	EXECUTED	8:d27577197868c24a0b9bc62e46a6dd42	createTable tableName=XLD_FILE_ARTIFACTS		\N	4.2.0	\N	\N	2876842386
3	XebiaLabs	SOURCE_ARTIFACTS	2023-08-24 11:34:03.029957	12	EXECUTED	8:0c386000bedbaeb829beae4bf0b6d2d7	createIndex indexName=XLD_FILE_ART_LOCATION_IDX, tableName=XLD_FILE_ARTIFACTS; createTable tableName=XLD_FILE_ART_USAGE; addForeignKeyConstraint baseTableName=XLD_FILE_ART_USAGE, constraintName=FK_XLD_FILE_ART_USAGE_CI, referencedTableName=XLD_CIS...		\N	4.2.0	\N	\N	2876842386
1	XebiaLabs	TYPE_SPECIFIC_TABLES	2023-08-24 11:34:03.11839	13	EXECUTED	8:a83e6aac0c7ec4d2a4a856fc4dcb257d	createTable tableName=XLD_ENVIRONMENT_MEMBERS; addPrimaryKey constraintName=PK_XLD_ENVIRONMENT_MEMBERS, tableName=XLD_ENVIRONMENT_MEMBERS; addForeignKeyConstraint baseTableName=XLD_ENVIRONMENT_MEMBERS, constraintName=FK_XLD_ENV_MEM_ENV, referenced...		\N	4.2.0	\N	\N	2876842386
xl-repositories-1	XebiaLabs	XL_METADATA	2023-08-24 11:34:03.132781	14	EXECUTED	8:de03e0b698d32fe1a973e7bfb787239a	createTable tableName=XL_METADATA		\N	4.2.0	\N	\N	2876842386
xl-migrations-1	XebiaLabs	XL_MIGRATIONS	2023-08-24 11:34:03.144727	15	EXECUTED	8:9715f302dd8e91492d3b386bf6ef8eb1	createTable tableName=XL_VERSION		\N	4.2.0	\N	\N	2876842386
xl-security-1	XebiaLabs	XL_SECURITY	2023-08-24 11:34:03.207135	16	EXECUTED	8:819df10ea63709c8f50f038804643c52	createTable tableName=XL_ROLES; createIndex indexName=IDX_ROLES_NAME, tableName=XL_ROLES; createIndex indexName=IDX_ROLES_CI_ID, tableName=XL_ROLES; createTable tableName=XL_ROLE_ROLES; addPrimaryKey constraintName=PK_ROLE_ROLES, tableName=XL_ROLE...		\N	4.2.0	\N	\N	2876842386
xl-security-2	XebiaLabs	XL_SECURITY	2023-08-24 11:34:03.219207	17	EXECUTED	8:d5f0946ac1b1fb95b16fab1b8b12df60	createIndex indexName=IDX_ROLE_ROLES_ROLE_ID, tableName=XL_ROLE_ROLES; createIndex indexName=IDX_ROLE_PRIN_ROLE_ID, tableName=XL_ROLE_PRINCIPALS; createIndex indexName=IDX_ROLE_PERM_ROLE_ID, tableName=XL_ROLE_PERMISSIONS		\N	4.2.0	\N	\N	2876842386
1	XebiaLabs	INCREASE_FILE_URI_LENGTH	2023-08-24 11:34:03.225194	18	EXECUTED	8:54a55448f669e733475d2fafab102b62	modifyDataType columnName=file_uri, tableName=XLD_SOURCE_ARTIFACTS		\N	4.2.0	\N	\N	2876842386
1	XebiaLabs	ADD_SECURED_CI_COLUMN	2023-08-24 11:34:03.230395	19	EXECUTED	8:7be6a0f4474ff927ed0bd3a22ffc6f7f	addColumn tableName=XLD_CIS		\N	4.2.0	\N	\N	2876842386
xl-security-3	XebiaLabs	XL_SECURITY_DELETE_ORPHAN_ROLE_PERMISSIONS	2023-08-24 11:34:03.236194	20	EXECUTED	8:509efb1ca014d9888effb0f5d298f39d	delete tableName=XL_ROLE_PERMISSIONS		\N	4.2.0	\N	\N	2876842386
1	XebiaLabs	MOVE_FILENAME_COLUMN	2023-08-24 11:34:03.250559	21	EXECUTED	8:a2c56ddfa9b42712f2d17ab77dacdb0b	addColumn tableName=XLD_SOURCE_ARTIFACTS; sql; sql; sql; dropColumn columnName=filename, tableName=XLD_DB_ART_USAGE; dropColumn columnName=filename, tableName=XLD_FILE_ART_USAGE; dropColumn columnName=length, tableName=XLD_DB_ARTIFACTS		\N	4.2.0	\N	\N	2876842386
xl-file-artifact-location-relative	XebiaLabs	MAKE_ARTIFACTS_FILE_LOCATION_RELATIVE	2023-08-24 11:34:03.255839	22	EXECUTED	8:d90095b0f31106218966560831665de1	update tableName=XLD_FILE_ARTIFACTS		\N	4.2.0	\N	\N	2876842386
1	XebiaLabs	XLD_BANNER	2023-08-24 11:34:03.273588	23	EXECUTED	8:9447284156a6f946dbbba6954de8dbf7	createTable tableName=XLD_BANNER		\N	4.2.0	\N	\N	2876842386
5	XebiaLabs	SOURCE_ARTIFACTS	2023-08-24 11:34:03.288885	24	EXECUTED	8:9e07f3e725c4ec318221a22eec175818	dropIndex indexName=XLD_FILE_ART_LOCATION_IDX, tableName=XLD_FILE_ARTIFACTS; modifyDataType columnName=location, tableName=XLD_FILE_ARTIFACTS; createIndex indexName=XLD_FILE_ART_LOCATION_IDX, tableName=XLD_FILE_ARTIFACTS		\N	4.2.0	!mysql-8	\N	2876842386
1	XebiaLabs	XLD_ACTIVE_TASKS	2023-08-24 11:34:03.307182	25	EXECUTED	8:ddfb16e41462beefd1a3e00fb97c7832	createTable tableName=XLD_ACTIVE_TASKS; createTable tableName=XLD_ACTIVE_TASKS_METADATA		\N	4.2.0	\N	\N	2876842386
1	XebiaLabs	XLD_ARCHIVED_PLACEHOLDERS	2023-08-24 11:34:03.325774	26	EXECUTED	8:dce7ba8b4047718692f899c319419644	createTable tableName=XLD_ARCHIVED_PLACEHOLDERS		\N	4.2.0	\N	\N	2876842386
1	XebiaLabs	XLD_CONFIG_VERSION	2023-08-24 11:34:03.340773	27	EXECUTED	8:b9c66973790aa04da509703c9634095d	createTable tableName=XLD_CONFIG_VERSION; createIndex indexName=XLD_CONFIG_VERSION_BOOT_DT_IDX, tableName=XLD_CONFIG_VERSION		\N	4.2.0	\N	\N	2876842386
1	XebiaLabs	XLD_LOCK_TABLE	2023-08-24 11:34:03.349084	28	EXECUTED	8:853abc7218466548fc5f401d5f1b57e2	createTable tableName=XLD_LOCK_TABLE		\N	4.2.0	\N	\N	2876842386
2	XebiaLabs	XLD_LOCK_TABLE	2023-08-24 11:34:03.35533	29	EXECUTED	8:a6193a622b6128fd0fa6a48890e4efb8	insert tableName=XLD_LOCK_TABLE		\N	4.2.0	\N	\N	2876842386
1	XebiaLabs	XLD_PLACEHOLDERS	2023-08-24 11:34:03.366119	30	EXECUTED	8:9f58593184cb0e2059cee7e7eca98c5e	createTable tableName=XLD_PLACEHOLDERS		\N	4.2.0	\N	\N	2876842386
1	XebiaLabs	XLD_WORKERS	2023-08-24 11:34:03.383227	31	EXECUTED	8:2aa1fa46d666f28a0fe75028a8b2d649	createTable tableName=XLD_WORKERS; addForeignKeyConstraint baseTableName=XLD_ACTIVE_TASKS, constraintName=FK_XLD_WORKERS_ID, referencedTableName=XLD_WORKERS; createIndex indexName=XLD_WORKERS_ADDRESS_IDX, tableName=XLD_WORKERS		\N	4.2.0	\N	\N	2876842386
1	XebiaLabs	XLD_SCM_TRACEABILITY_DATA	2023-08-24 11:34:03.38797	32	EXECUTED	8:900a58d9c684f58293dafc4d32a6abee	addColumn tableName=XLD_CIS		\N	4.2.0	\N	\N	2876842386
2	XebiaLabs	XLD_SCM_TRACEABILITY_DATA	2023-08-24 11:34:03.398262	33	EXECUTED	8:fa081fcdb863793237d0a4b4553006c8	createTable tableName=XLD_SCM_TRACEABILITY_DATA		\N	4.2.0	\N	\N	2876842386
1	XebiaLabs	XLD_CI_PLACEHOLDERS	2023-08-24 11:34:03.407873	34	EXECUTED	8:d64446a84a265d802f7e62dba950fb6e	createTable tableName=XLD_CI_PLACEHOLDERS		\N	4.2.0	\N	\N	2876842386
1	XebiaLabs	XLD_LOOKUP_VALUES	2023-08-24 11:34:03.421222	35	EXECUTED	8:aa9f556bd8f5034f5174eb5aeea5d298	createTable tableName=XLD_LOOKUP_VALUES; addPrimaryKey constraintName=PK_XLD_LOOKUP_VALUES, tableName=XLD_LOOKUP_VALUES; addForeignKeyConstraint baseTableName=XLD_LOOKUP_VALUES, constraintName=FK_XLD_LOOKUP_VALUES_CI, referencedTableName=XLD_CIS; ...		\N	4.2.0	\N	\N	2876842386
1	XebiaLabs	ADD_SECURED_CI_IDX	2023-08-24 11:34:03.430959	36	EXECUTED	8:3c6854347900343c6eabe39c6768f397	createIndex indexName=XLD_CIS_SECURED_CI_IDX, tableName=XLD_CIS		\N	4.2.0	\N	\N	2876842386
2	XebiaLabs	XLD_ARCHIVED_PLACEHOLDERS	2023-08-24 11:34:03.44036	37	EXECUTED	8:7057fca9ad6f87793fc0a15d8a40ced5	addColumn tableName=XLD_ARCHIVED_PLACEHOLDERS		\N	4.2.0	\N	\N	2876842386
2	XebiaLabs	XLD_PLACEHOLDERS	2023-08-24 11:34:03.44614	38	EXECUTED	8:ce5fa0248eb84f6b5066ce6ba21d445b	addColumn tableName=XLD_PLACEHOLDERS		\N	4.2.0	\N	\N	2876842386
4	XebiaLabs	XLD_CI_PLACEHOLDERS	2023-08-24 11:34:03.44926	39	EXECUTED	8:6761f373de2a9c436c59125f28a419a3	sql		\N	4.2.0	\N	\N	2876842386
5	XebiaLabs	XLD_CI_PLACEHOLDERS	2023-08-24 11:34:03.455641	40	EXECUTED	8:12f317a01fd9ed12d92ce4e31c8db0b9	createIndex indexName=XLD_CI_PLACEHOLDERS_PATH_IDX, tableName=XLD_CI_PLACEHOLDERS		\N	4.2.0	\N	\N	2876842386
2	XebiaLabs	TYPE_SPECIFIC_TABLES	2023-08-24 11:34:03.464886	41	EXECUTED	8:d0b3695afc3932d4f641c8f7e1e2367a	createIndex indexName=XLD_DICT_ENT_DIC_IDX, tableName=XLD_DICT_ENTRIES; createIndex indexName=XLD_DICT_ENC_ENT_DIC_IDX, tableName=XLD_DICT_ENC_ENTRIES		\N	4.2.0	\N	\N	2876842386
2	XebiaLabs	XLD_LOOKUP_VALUES	2023-08-24 11:34:03.473834	42	EXECUTED	8:25166e6580e025d4bf4a742a9105ac01	createIndex indexName=XLD_LOOKUP_VALUES_CI_IDX, tableName=XLD_LOOKUP_VALUES; createIndex indexName=XLD_LOOKUP_VALUES_PROV_IDX, tableName=XLD_LOOKUP_VALUES		\N	4.2.0	\N	\N	2876842386
3	XebiaLabs	XLD_ARCHIVED_PLACEHOLDERS	2023-08-24 11:34:03.485621	43	EXECUTED	8:b973afb5ea8194abbdd6e854c063a475	createIndex indexName=XLD_ARCH_PH_DICT_ID_IDX, tableName=XLD_ARCHIVED_PLACEHOLDERS; createIndex indexName=XLD_ARCH_PH_ENV_ID_IDX, tableName=XLD_ARCHIVED_PLACEHOLDERS; createIndex indexName=XLD_ARCH_PH_CONTAINER_ID_IDX, tableName=XLD_ARCHIVED_PLACE...		\N	4.2.0	\N	\N	2876842386
3	XebiaLabs	XLD_PLACEHOLDERS	2023-08-24 11:34:03.497786	44	EXECUTED	8:5123ffe0830c0ed4b43ccf5425df28bd	createIndex indexName=XLD_PH_DICT_ID_IDX, tableName=XLD_PLACEHOLDERS; createIndex indexName=XLD_PH_ENV_ID_IDX, tableName=XLD_PLACEHOLDERS; createIndex indexName=XLD_PH_CONTAINER_ID_IDX, tableName=XLD_PLACEHOLDERS		\N	4.2.0	\N	\N	2876842386
1	XebiaLabs	XLD_STITCH/XLD_STITCH_SOURCE_SYNC_STATE	2023-08-24 11:34:03.50815	45	EXECUTED	8:4f6ef6dd4fb36a69354e4b8f9d74d809	createTable tableName=XLD_STITCH_SOURCE_SYNC_STATE		\N	4.2.0	\N	\N	2876842386
2	XebiaLabs	XLD_STITCH/XLD_STITCH_SOURCE_SYNC_STATE	2023-08-24 11:34:03.513271	46	EXECUTED	8:b3adeeb9572d14f8b7ddd90ea26e16b0	addForeignKeyConstraint baseTableName=XLD_STITCH_SOURCE_SYNC_STATE, constraintName=FK_XLD_SRC_SYNC_ST_SOURCE_ID, referencedTableName=XLD_CIS		\N	4.2.0	\N	\N	2876842386
1	XebiaLabs	XLD_STITCH/XLD_STITCH_NAMESPACES	2023-08-24 11:34:03.520223	47	EXECUTED	8:a95920feacceacde3c10e07297f8456a	createTable tableName=XLD_STITCH_NAMESPACES		\N	4.2.0	\N	\N	2876842386
2	XebiaLabs	XLD_STITCH/XLD_STITCH_NAMESPACES	2023-08-24 11:34:03.527348	48	EXECUTED	8:7a0c494d988f3be79b67caa6cc65197b	createIndex indexName=XLD_ST_NAMESPACES_NAME_IDX, tableName=XLD_STITCH_NAMESPACES		\N	4.2.0	\N	\N	2876842386
1	XebiaLabs	XLD_STITCH/XLD_STITCH_CONTENT	2023-08-24 11:34:03.538203	49	EXECUTED	8:3c06fa8cffce26c9d3f0648776500a93	createTable tableName=XLD_STITCH_CONTENT		\N	4.2.0	\N	\N	2876842386
1	XebiaLabs	XLD_STITCH/XLD_STITCH_DEFINITION	2023-08-24 11:34:03.545576	50	EXECUTED	8:8c1bf28e6f58a56a2f024bdcf71fcab6	createTable tableName=XLD_STITCH_DEFINITION		\N	4.2.0	\N	\N	2876842386
2	XebiaLabs	XLD_STITCH/XLD_STITCH_DEFINITION	2023-08-24 11:34:03.55275	51	EXECUTED	8:36ddc533eb3cdbebfaaa34cbbef702fd	addForeignKeyConstraint baseTableName=XLD_STITCH_DEFINITION, constraintName=FK_XLD_ST_MTDT_NAMESPACE_ID, referencedTableName=XLD_STITCH_NAMESPACES; addForeignKeyConstraint baseTableName=XLD_STITCH_DEFINITION, constraintName=FK_XLD_ST_MTDT_CONTENT_...		\N	4.2.0	\N	\N	2876842386
3	XebiaLabs	XLD_STITCH/XLD_STITCH_DEFINITION	2023-08-24 11:34:03.564785	52	EXECUTED	8:0f2f70f0961740c472a1053e4023e0ad	createIndex indexName=XLD_ST_MTDT_NAMESPACE_ID_IDX, tableName=XLD_STITCH_DEFINITION; createIndex indexName=XLD_ST_META_SOURCE_ID_IDX, tableName=XLD_STITCH_DEFINITION		\N	4.2.0	\N	\N	2876842386
1	XebiaLabs	XLD_STITCH/XLD_STITCH_RULES	2023-08-24 11:34:03.582738	53	EXECUTED	8:604fe08fe25381ec03fc99789b8b40ba	createTable tableName=XLD_STITCH_RULES		\N	4.2.0	\N	\N	2876842386
2	XebiaLabs	XLD_STITCH/XLD_STITCH_RULES	2023-08-24 11:34:03.596726	54	EXECUTED	8:53aae88a263fd2cb8c5d23bc6182f72b	addForeignKeyConstraint baseTableName=XLD_STITCH_RULES, constraintName=FK_XLD_RULE_NAMESPACE_ID, referencedTableName=XLD_STITCH_NAMESPACES; addForeignKeyConstraint baseTableName=XLD_STITCH_RULES, constraintName=FK_XLD_RULE_CONTENT_ID, referencedTa...		\N	4.2.0	\N	\N	2876842386
3	XebiaLabs	XLD_STITCH/XLD_STITCH_RULES	2023-08-24 11:34:03.612226	55	EXECUTED	8:43cfbecc72b2bd0a06a4800818fae4d3	createIndex indexName=XLD_ST_RULES_NAMESPACE_ID_IDX, tableName=XLD_STITCH_RULES; createIndex indexName=XLD_ST_RULES_DEFINITION_ID_IDX, tableName=XLD_STITCH_RULES; createIndex indexName=XLD_ST_RULE_SOURCE_ID_IDX, tableName=XLD_STITCH_RULES; createI...		\N	4.2.0	\N	\N	2876842386
1	XebiaLabs	XLD_STITCH/XLD_STITCH_MACROS	2023-08-24 11:34:03.621812	56	EXECUTED	8:15500d6368e10900877073ba5a31bece	createTable tableName=XLD_STITCH_MACROS		\N	4.2.0	\N	\N	2876842386
2	XebiaLabs	XLD_STITCH/XLD_STITCH_MACROS	2023-08-24 11:34:03.629679	57	EXECUTED	8:b261cbfbb51262f3bb56d881b472ab36	addForeignKeyConstraint baseTableName=XLD_STITCH_MACROS, constraintName=FK_XLD_MACRO_NAMESPACE_ID, referencedTableName=XLD_STITCH_NAMESPACES; addForeignKeyConstraint baseTableName=XLD_STITCH_MACROS, constraintName=FK_XLD_MACRO_CONTENT_ID, referenc...		\N	4.2.0	\N	\N	2876842386
3	XebiaLabs	XLD_STITCH/XLD_STITCH_MACROS	2023-08-24 11:34:03.643647	58	EXECUTED	8:f19413995328b3f867bad8c1773ccdf4	createIndex indexName=XLD_ST_MACROS_NAMESPACE_ID_IDX, tableName=XLD_STITCH_MACROS; createIndex indexName=XLD_ST_MACROS_DEF_ID_IDX, tableName=XLD_STITCH_MACROS; createIndex indexName=XLD_ST_MACROS_SOURCE_ID_IDX, tableName=XLD_STITCH_MACROS; createI...		\N	4.2.0	\N	\N	2876842386
1	XebiaLabs	XLD_STITCH/XLD_STITCH_RULE_CONDITIONS	2023-08-24 11:34:03.652922	59	EXECUTED	8:f4b969165964514a091a5f1579544d89	createTable tableName=XLD_STITCH_RULE_CONDITIONS		\N	4.2.0	\N	\N	2876842386
2	XebiaLabs	XLD_STITCH/XLD_STITCH_RULE_CONDITIONS	2023-08-24 11:34:03.659321	60	EXECUTED	8:fc470f72550f8bfb8cfd7bddf6753731	addForeignKeyConstraint baseTableName=XLD_STITCH_RULE_CONDITIONS, constraintName=FK_XLD_ST_RULE_COND_SOURCE_ID, referencedTableName=XLD_CIS; addForeignKeyConstraint baseTableName=XLD_STITCH_RULE_CONDITIONS, constraintName=FK_XLD_ST_RULE_COND_RULE_...		\N	4.2.0	\N	\N	2876842386
3	XebiaLabs	XLD_STITCH/XLD_STITCH_RULE_CONDITIONS	2023-08-24 11:34:03.665844	61	EXECUTED	8:d77bd703875e33594d2a6714f36ce6d6	createIndex indexName=XLD_ST_RL_COND_SOURCE_ID_IDX, tableName=XLD_STITCH_RULE_CONDITIONS		\N	4.2.0	\N	\N	2876842386
1	XebiaLabs	XLD_STITCH/XLD_STITCH_PROCESSORS	2023-08-24 11:34:03.675933	62	EXECUTED	8:fd23975325c5ca6c8794106dcf54a0f9	createTable tableName=XLD_STITCH_PROCESSORS		\N	4.2.0	\N	\N	2876842386
2	XebiaLabs	XLD_STITCH/XLD_STITCH_PROCESSORS	2023-08-24 11:34:03.683565	63	EXECUTED	8:1b313b76b029d5a45b50d9e6c6153ad4	addForeignKeyConstraint baseTableName=XLD_STITCH_PROCESSORS, constraintName=FK_XLD_PROCESSOR_NAMESPACE_ID, referencedTableName=XLD_STITCH_NAMESPACES; addForeignKeyConstraint baseTableName=XLD_STITCH_PROCESSORS, constraintName=FK_XLD_PROCESSOR_DEFI...		\N	4.2.0	\N	\N	2876842386
3	XebiaLabs	XLD_STITCH/XLD_STITCH_PROCESSORS	2023-08-24 11:34:03.69952	64	EXECUTED	8:500f0b2232477f23ca2c6e19aace9671	createIndex indexName=XLD_ST_PROC_NAMESPACE_ID_IDX, tableName=XLD_STITCH_PROCESSORS; createIndex indexName=XLD_ST_PROC_DEFINITION_ID_IDX, tableName=XLD_STITCH_PROCESSORS; createIndex indexName=XLD_ST_PROCESSOR_SOURCE_ID_IDX, tableName=XLD_STITCH_P...		\N	4.2.0	\N	\N	2876842386
1	XebiaLabs	XLD_STITCH/XLD_STITCH_RULE_PROCESSORS	2023-08-24 11:34:03.707669	65	EXECUTED	8:946a702872c0295a17930e524b50862f	createTable tableName=XLD_STITCH_RULE_PROCESSORS		\N	4.2.0	\N	\N	2876842386
2	XebiaLabs	XLD_STITCH/XLD_STITCH_RULE_PROCESSORS	2023-08-24 11:34:03.718344	66	EXECUTED	8:33fa388540854fbd8cee5a01688a86ed	addForeignKeyConstraint baseTableName=XLD_STITCH_RULE_PROCESSORS, constraintName=FK_XLD_RULE_PROC_PROCESSOR_ID, referencedTableName=XLD_STITCH_PROCESSORS; addForeignKeyConstraint baseTableName=XLD_STITCH_RULE_PROCESSORS, constraintName=FK_XLD_ST_R...		\N	4.2.0	\N	\N	2876842386
3	XebiaLabs	XLD_STITCH/XLD_STITCH_RULE_PROCESSORS	2023-08-24 11:34:03.728895	67	EXECUTED	8:827e6f7e9276473fca9c58fa729b0bcd	createIndex indexName=XLD_ST_RULE_PROCE_RULE_ID_IDX, tableName=XLD_STITCH_RULE_PROCESSORS		\N	4.2.0	\N	\N	2876842386
1	XebiaLabs	XLD_STITCH/XLD_STITCH_MACRO_PROCESSORS	2023-08-24 11:34:03.740535	68	EXECUTED	8:912c7e12adbb114b9026a4d4fc8006ff	createTable tableName=XLD_STITCH_MACRO_PROCESSORS		\N	4.2.0	\N	\N	2876842386
2	XebiaLabs	XLD_STITCH/XLD_STITCH_MACRO_PROCESSORS	2023-08-24 11:34:03.752087	69	EXECUTED	8:cab3a131aa633b162594b7be9f826f4e	addForeignKeyConstraint baseTableName=XLD_STITCH_MACRO_PROCESSORS, constraintName=FK_XLD_MACRO_PROC_PROC_ID, referencedTableName=XLD_STITCH_PROCESSORS; addForeignKeyConstraint baseTableName=XLD_STITCH_MACRO_PROCESSORS, constraintName=FK_XLD_ST_MAC...		\N	4.2.0	\N	\N	2876842386
3	XebiaLabs	XLD_STITCH/XLD_STITCH_MACRO_PROCESSORS	2023-08-24 11:34:03.760076	70	EXECUTED	8:e03f1298163e2ba8641a3680ed4135da	createIndex indexName=XLD_ST_MACRO_PROC_MAC_ID_IDX, tableName=XLD_STITCH_MACRO_PROCESSORS		\N	4.2.0	\N	\N	2876842386
1	XebiaLabs	XLD_STITCH/XLD_STITCH_PROCESSOR_PARAMS	2023-08-24 11:34:03.771407	71	EXECUTED	8:9af116cdd8347717d87708f6074d65d7	createTable tableName=XLD_STITCH_PROCESSOR_PARAMS		\N	4.2.0	\N	\N	2876842386
2	XebiaLabs	XLD_STITCH/XLD_STITCH_PROCESSOR_PARAMS	2023-08-24 11:34:03.780371	72	EXECUTED	8:9f4dd88c95389cd1a302a7efa995e843	addForeignKeyConstraint baseTableName=XLD_STITCH_PROCESSOR_PARAMS, constraintName=FK_XLD_ST_PROC_PARAM_SOUR_ID, referencedTableName=XLD_CIS		\N	4.2.0	\N	\N	2876842386
3	XebiaLabs	XLD_STITCH/XLD_STITCH_PROCESSOR_PARAMS	2023-08-24 11:34:03.794283	73	EXECUTED	8:e280f994f77a3ed10e7e2a0f2b3a9de7	createIndex indexName=XLD_ST_PROC_PAR_SOURCE_ID_IDX, tableName=XLD_STITCH_PROCESSOR_PARAMS		\N	4.2.0	\N	\N	2876842386
1	XebiaLabs	XLD_STITCH/XLD_STITCH_RULE_PROC_PARAMS	2023-08-24 11:34:03.804411	74	EXECUTED	8:2af8420129b632dec92c4048bbf98ae5	createTable tableName=XLD_STITCH_RULE_PROC_PARAMS		\N	4.2.0	\N	\N	2876842386
2	XebiaLabs	XLD_STITCH/XLD_STITCH_RULE_PROC_PARAMS	2023-08-24 11:34:03.810559	75	EXECUTED	8:f0705bd663b840d295de371bc7895b93	addForeignKeyConstraint baseTableName=XLD_STITCH_RULE_PROC_PARAMS, constraintName=FK_XLD_ST_RUPROCPA_PROCPARAID, referencedTableName=XLD_STITCH_PROCESSOR_PARAMS; addForeignKeyConstraint baseTableName=XLD_STITCH_RULE_PROC_PARAMS, constraintName=FK_...		\N	4.2.0	\N	\N	2876842386
1	XebiaLabs	XLD_STITCH/XLD_STITCH_MACRO_PROC_PARAMS	2023-08-24 11:34:03.817645	76	EXECUTED	8:6474a224881f229da754ae4569db3cae	createTable tableName=XLD_STITCH_MACRO_PROC_PARAMS		\N	4.2.0	\N	\N	2876842386
2	XebiaLabs	XLD_STITCH/XLD_STITCH_MACRO_PROC_PARAMS	2023-08-24 11:34:03.823236	77	EXECUTED	8:50d1f66d75ec71be4c4b1a0a61ccfc9d	addForeignKeyConstraint baseTableName=XLD_STITCH_MACRO_PROC_PARAMS, constraintName=FK_XLD_ST_MP_PARAMPROC_PARAMID, referencedTableName=XLD_STITCH_PROCESSOR_PARAMS; addForeignKeyConstraint baseTableName=XLD_STITCH_MACRO_PROC_PARAMS, constraintName=...		\N	4.2.0	\N	\N	2876842386
1	XebiaLabs	XLD_STITCH/XLD_STITCH_MACRO_PARAMETERS	2023-08-24 11:34:03.832438	78	EXECUTED	8:573ebc56b5bf7b435bbaf8483a7b8ec3	createTable tableName=XLD_STITCH_MACRO_PARAMETERS		\N	4.2.0	\N	\N	2876842386
2	XebiaLabs	XLD_STITCH/XLD_STITCH_MACRO_PARAMETERS	2023-08-24 11:34:03.84157	79	EXECUTED	8:07fb41a4f49f5d557a186ad38808a75d	addForeignKeyConstraint baseTableName=XLD_STITCH_MACRO_PARAMETERS, constraintName=FK_XLD_ST_MACROPARAM_MACROID, referencedTableName=XLD_STITCH_MACROS; addForeignKeyConstraint baseTableName=XLD_STITCH_MACRO_PARAMETERS, constraintName=FK_XLD_ST_MACR...		\N	4.2.0	\N	\N	2876842386
3	XebiaLabs	XLD_STITCH/XLD_STITCH_MACRO_PARAMETERS	2023-08-24 11:34:03.850193	80	EXECUTED	8:8c8bf3f8f9879c6761b7819b65fa1212	createIndex indexName=XLD_ST_MACPARAM_MACROID_IDX, tableName=XLD_STITCH_MACRO_PARAMETERS; createIndex indexName=XLD_ST_MACPARAM_SOURCEID_IDX, tableName=XLD_STITCH_MACRO_PARAMETERS		\N	4.2.0	\N	\N	2876842386
1	XebiaLabs	SPRING_SESSION	2023-08-24 11:34:03.858219	81	EXECUTED	8:7e43072f3711517ea7b3842488144391	createTable tableName=SPRING_SESSION		\N	4.2.0	\N	\N	2876842386
2	XebiaLabs	SPRING_SESSION	2023-08-24 11:34:03.869028	82	EXECUTED	8:1cb6c6e284475113452582c752c2e0ee	createTable tableName=SPRING_SESSION_ATTRIBUTES		\N	4.2.0	\N	\N	2876842386
3	XebiaLabs	SPRING_SESSION	2023-08-24 11:34:03.878285	83	EXECUTED	8:53f127f940516b89322f986040167d59	createIndex indexName=XLD_SPRING_SESSION_ID_IDX, tableName=SPRING_SESSION		\N	4.2.0	\N	\N	2876842386
4	XebiaLabs	SPRING_SESSION	2023-08-24 11:34:03.886554	84	EXECUTED	8:7f3437d76364f8ff2da3b4a2b6d713de	createIndex indexName=XLD_SPRING_SESSION_EXPIRY_IDX, tableName=SPRING_SESSION		\N	4.2.0	\N	\N	2876842386
5	XebiaLabs	SPRING_SESSION	2023-08-24 11:34:03.901692	85	EXECUTED	8:37348c61c81693c888a754946b46af94	createIndex indexName=XLD_SESSION_PRINCIPAL_IDX, tableName=SPRING_SESSION		\N	4.2.0	\N	\N	2876842386
6	XebiaLabs	SPRING_SESSION	2023-08-24 11:34:03.907172	86	EXECUTED	8:f50ad1e13353cb7e15d5a7066b53ae88	addForeignKeyConstraint baseTableName=SPRING_SESSION_ATTRIBUTES, constraintName=FK_XLD_ATTRIBUTE_SESSION_ID, referencedTableName=SPRING_SESSION		\N	4.2.0	\N	\N	2876842386
1	XebiaLabs	XLD_PENDING_TASKS	2023-08-24 11:34:03.926978	87	EXECUTED	8:c194fa23e045b390f6e46f4e50348621	createTable tableName=XLD_PENDING_TASKS; createTable tableName=XLD_PENDING_TASKS_METADATA		\N	4.2.0	\N	\N	2876842386
1	XebiaLabs	XLD_PROFILES	2023-08-24 11:34:03.934543	88	EXECUTED	8:c11604aa1ad77a0cab2eb5d8a550c3f3	createTable tableName=XLD_PROFILES; insert tableName=XLD_LOCK_TABLE		\N	4.2.0	\N	\N	2876842386
1	XebiaLabs	SPRING_SESSION_ATTRIBUTES	2023-08-24 11:34:03.939772	89	EXECUTED	8:dcc7939e19bc24b420df31701ee4019c	modifyDataType columnName=ATTRIBUTE_BYTES, tableName=SPRING_SESSION_ATTRIBUTES		\N	4.2.0	\N	\N	2876842386
1	XebiaLabs	ADD_INDEX_XLD_CIS	2023-08-24 11:34:03.946314	90	EXECUTED	8:38dc8090b8e20d337814b3ccc0b60787	createIndex indexName=XLD_CIS_NAME_IDX, tableName=XLD_CIS		\N	4.2.0	\N	\N	2876842386
1	XebiaLabs	XLD_CI_LOCK	2023-08-24 11:34:03.958493	91	EXECUTED	8:17b90da5a000ea8faea1d21fc75faa9e	createTable tableName=XLD_CI_LOCK; addPrimaryKey constraintName=PK_XLD_CI_LOCK, tableName=XLD_CI_LOCK; addForeignKeyConstraint baseTableName=XLD_CI_LOCK, constraintName=FK_XLD_CI_LOCK_ID, referencedTableName=XLD_ACTIVE_TASKS		\N	4.2.0	\N	\N	2876842386
4	XebiaLabs	XLD_STITCH/XLD_STITCH_RULES	2023-08-24 11:34:03.970734	92	EXECUTED	8:8130eb1c8d9aa7d4f48bdb90771b1fec	addColumn tableName=XLD_STITCH_RULES; dropIndex indexName=XLD_ST_RULE_UNQ_IN_NS_IDX, tableName=XLD_STITCH_RULES; createIndex indexName=XLD_ST_RULE_UNQ_IN_NS_BN_IDX, tableName=XLD_STITCH_RULES		\N	4.2.0	\N	\N	2876842386
4	XebiaLabs	XLD_STITCH/XLD_STITCH_MACROS	2023-08-24 11:34:03.981435	93	EXECUTED	8:95a1856ee1c4f049be9e7359731fbace	addColumn tableName=XLD_STITCH_MACROS; dropIndex indexName=XLD_ST_MACROS_UNQ_IN_NS_IDX, tableName=XLD_STITCH_MACROS; createIndex indexName=XLD_ST_MCS_UNQ_IN_NS_BN_IDX, tableName=XLD_STITCH_MACROS		\N	4.2.0	\N	\N	2876842386
3	XebiaLabs	XLD_STITCH/XLD_STITCH_SOURCE_SYNC_STATE	2023-08-24 11:34:03.985633	94	EXECUTED	8:95d47125b64230b9911e710dfa86bbfd	addColumn tableName=XLD_STITCH_SOURCE_SYNC_STATE		\N	4.2.0	\N	\N	2876842386
4	XebiaLabs	XLD_STITCH/XLD_STITCH_DEFINITION	2023-08-24 11:34:03.995592	95	EXECUTED	8:c5f799f19b596225bafe0d07c4a4870e	addColumn tableName=XLD_STITCH_DEFINITION; createIndex indexName=XLD_ST_META_SOURCE_ID_BN_IDX, tableName=XLD_STITCH_DEFINITION		\N	4.2.0	\N	\N	2876842386
2	XebiaLabs	XLD_STITCH/XLD_STITCH_CONTENT	2023-08-24 11:34:04.001953	96	EXECUTED	8:a555017f35d4cb208d45334b6146d324	addColumn tableName=XLD_STITCH_CONTENT; createIndex indexName=XLD_ST_CNT_SRC_ID_BN_IDX, tableName=XLD_STITCH_CONTENT		\N	4.2.0	\N	\N	2876842386
1	Digital.ai	XLD_USER_PROFILES	2023-08-24 11:34:04.009115	97	EXECUTED	8:224fbcc32a7784f6d8d49a5b1adc6c72	createTable tableName=XLD_USER_PROFILES		\N	4.2.0	\N	\N	2876842386
1	Digital.ai	XLD_USER_CREDENTIALS	2023-08-24 11:34:04.023854	98	EXECUTED	8:88b36112d975f9718a979efa32b531a9	createTable tableName=XLD_USER_CREDENTIALS; createTable tableName=XLD_USER_DEFAULT_CREDENTIALS		\N	4.2.0	\N	\N	2876842386
2	XebiaLabs	XLD_ACTIVE_TASKS	2023-08-24 11:34:04.030915	99	EXECUTED	8:07165b3b77ff9c9ce9190c2542672067	createIndex indexName=XLD_ACTIVE_TASKS_METADATA_METADATA_KEY_IDX, tableName=XLD_ACTIVE_TASKS_METADATA		\N	4.2.0	\N	\N	2876842386
1	XebiaLabs	ARCHIVED_TASKS	2023-08-24 11:34:04.300529	100	EXECUTED	8:f41e50a2c754a853bcfad151b382e816	createTable tableName=XLD_ARCHIVED_TASKS; createTable tableName=XLD_ARCHIVED_UNKNOWN_TASKS; addForeignKeyConstraint baseTableName=XLD_ARCHIVED_UNKNOWN_TASKS, constraintName=FK_ARCHIVED_UNKNOWN_TASKS_ID, referencedTableName=XLD_ARCHIVED_TASKS; crea...		\N	4.2.0	\N	\N	2876844231
2	XebiaLabs	ARCHIVED_TASKS_ALIGN_SIZES	2023-08-24 11:34:04.320011	101	EXECUTED	8:a6b0e6255b7964f98a455ed20cf4b0ca	dropIndex indexName=XLD_ARCHIVED_DT_ENV_IDX, tableName=XLD_ARCHIVED_DEPLOYMENT_TASKS; modifyDataType columnName=main_application, tableName=XLD_ARCHIVED_DEPLOYMENT_TASKS; modifyDataType columnName=environment, tableName=XLD_ARCHIVED_DEPLOYMENT_TAS...		\N	4.2.0	\N	\N	2876844231
1	XebiaLabs	ADD_ARCHIVED_DEPLOYMENT_TASKS_COLUMN	2023-08-24 11:34:04.325348	102	EXECUTED	8:d7e0a62b5ead6e0fc3bf6e207935b373	addColumn tableName=XLD_ARCHIVED_DEPLOYMENT_TASKS		\N	4.2.0	\N	\N	2876844231
1	XebiaLabs	ADD_INTERNAL_ID_COLUMNS_ON_ARCH_DT_TABLES	2023-08-24 11:34:04.330348	103	EXECUTED	8:426fea4356c69efb30247042355349e6	addColumn tableName=XLD_ARCHIVED_DEPLOYMENT_TASKS; addColumn tableName=XLD_ARCHIVED_DT_APPLICATIONS		\N	4.2.0	\N	\N	2876844231
2	XebiaLabs	ADD_INTERNAL_ID_COLUMNS_ON_ARCH_DT_TABLES	2023-08-24 11:34:04.341315	104	EXECUTED	8:cbb40b3967cdd051e1d360d6794bfd1e	createIndex indexName=XLD_ADT_ENV_INT_ID_IDX, tableName=XLD_ARCHIVED_DEPLOYMENT_TASKS; createIndex indexName=XLD_ADTAPP_APP_INT_ID_IDX, tableName=XLD_ARCHIVED_DT_APPLICATIONS		\N	4.2.0	\N	\N	2876844231
1	XebiaLabs	ADD_ROLES_PERMISSIONS_TABLES	2023-08-24 11:34:04.416975	105	EXECUTED	8:3998de06e8151ebb45caacc07b5ce253	createTable tableName=XLD_ARCHIVE_ROLES; createIndex indexName=IDX_ARCHIVE_ROLES_NAME, tableName=XLD_ARCHIVE_ROLES; createIndex indexName=IDX_ARCHIVE_ROLES_CI_ID, tableName=XLD_ARCHIVE_ROLES; createTable tableName=XLD_ARCHIVE_ROLE_ROLES; addPrimar...		\N	4.2.0	\N	\N	2876844231
2	XebiaLabs	ADD_ROLES_PERMISSIONS_TABLES	2023-08-24 11:34:04.432519	106	EXECUTED	8:e62ba838e92f4b500e8ff1929853d635	createIndex indexName=XLD_ADT_ENV_SEC_ID_IDX, tableName=XLD_ARCHIVED_DEPLOYMENT_TASKS; createIndex indexName=XLD_ADTAPP_APP_SEC_ID_IDX, tableName=XLD_ARCHIVED_DT_APPLICATIONS; createIndex indexName=XLD_ACT_TARGET_INT_ID_IDX, tableName=XLD_ARCHIVED...		\N	4.2.0	\N	\N	2876844231
1	XebiaLabs	ADD_WORKER_NAME_COLUMNS_ON_ARCH_DT_TABLES	2023-08-24 11:34:04.437534	107	EXECUTED	8:496d5f0ce1c1ad6d74282a4025e519a6	addColumn tableName=XLD_ARCHIVED_CONTROL_TASKS; addColumn tableName=XLD_ARCHIVED_DEPLOYMENT_TASKS; addColumn tableName=XLD_ARCHIVED_TASKS		\N	4.2.0	\N	\N	2876844231
\.


--
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
1	f	\N	\N
\.


--
-- Data for Name: spring_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.spring_session (primary_id, session_id, creation_time, last_access_time, max_inactive_interval, expiry_time, principal_name) FROM stdin;
\.


--
-- Data for Name: spring_session_attributes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.spring_session_attributes (session_primary_id, attribute_name, attribute_bytes) FROM stdin;
\.


--
-- Name: XLD_CIS_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."XLD_CIS_ID_seq"', 4, true);


--
-- Name: XLD_CI_HISTORY_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."XLD_CI_HISTORY_ID_seq"', 4, true);


--
-- Name: XLD_CI_PLACEHOLDERS_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."XLD_CI_PLACEHOLDERS_ID_seq"', 1, false);


--
-- Name: XLD_CI_PROPERTIES_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."XLD_CI_PROPERTIES_ID_seq"', 1, false);


--
-- Name: XLD_CONFIG_VERSION_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."XLD_CONFIG_VERSION_ID_seq"', 1, true);


--
-- Name: XLD_FILE_ARTIFACTS_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."XLD_FILE_ARTIFACTS_ID_seq"', 1, false);


--
-- Name: XLD_SCM_TRACEABILITY_DATA_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."XLD_SCM_TRACEABILITY_DATA_ID_seq"', 1, false);


--
-- Name: XLD_USER_CREDENTIALS_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."XLD_USER_CREDENTIALS_ID_seq"', 1, false);


--
-- Name: XLD_WORKERS_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."XLD_WORKERS_ID_seq"', 1, true);


--
-- Name: PERSISTENT_LOGINS PERSISTENT_LOGINS_PKEY; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PERSISTENT_LOGINS"
    ADD CONSTRAINT "PERSISTENT_LOGINS_PKEY" PRIMARY KEY (series);


--
-- Name: XLD_ARCHIVE_ROLE_PERMISSIONS PK_ARCH_ROLE_PERMISSIONS; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_ARCHIVE_ROLE_PERMISSIONS"
    ADD CONSTRAINT "PK_ARCH_ROLE_PERMISSIONS" PRIMARY KEY ("ROLE_ID", "PERMISSION_NAME", "CI_ID");


--
-- Name: XLD_ARCHIVE_ROLE_PRINCIPALS PK_ARCH_ROLE_PRINCIPALS; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_ARCHIVE_ROLE_PRINCIPALS"
    ADD CONSTRAINT "PK_ARCH_ROLE_PRINCIPALS" PRIMARY KEY ("ROLE_ID", "PRINCIPAL_NAME");


--
-- Name: XLD_ARCHIVE_ROLE_ROLES PK_ARCH_ROLE_ROLES; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_ARCHIVE_ROLE_ROLES"
    ADD CONSTRAINT "PK_ARCH_ROLE_ROLES" PRIMARY KEY ("ROLE_ID", "MEMBER_ROLE_ID");


--
-- Name: XL_ROLE_PERMISSIONS PK_ROLE_PERMISSIONS; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XL_ROLE_PERMISSIONS"
    ADD CONSTRAINT "PK_ROLE_PERMISSIONS" PRIMARY KEY ("ROLE_ID", "PERMISSION_NAME", "CI_ID");


--
-- Name: XL_ROLE_PRINCIPALS PK_ROLE_PRINCIPALS; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XL_ROLE_PRINCIPALS"
    ADD CONSTRAINT "PK_ROLE_PRINCIPALS" PRIMARY KEY ("ROLE_ID", "PRINCIPAL_NAME");


--
-- Name: XL_ROLE_ROLES PK_ROLE_ROLES; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XL_ROLE_ROLES"
    ADD CONSTRAINT "PK_ROLE_ROLES" PRIMARY KEY ("ROLE_ID", "MEMBER_ROLE_ID");


--
-- Name: XLD_CI_LOCK PK_XLD_CI_LOCK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_CI_LOCK"
    ADD CONSTRAINT "PK_XLD_CI_LOCK" PRIMARY KEY ("CI_ID", task_id);


--
-- Name: XLD_DICT_APPLICATIONS PK_XLD_DICT_APPLICATIONS; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_DICT_APPLICATIONS"
    ADD CONSTRAINT "PK_XLD_DICT_APPLICATIONS" PRIMARY KEY (dictionary_id, application_id);


--
-- Name: XLD_DICT_CONTAINERS PK_XLD_DICT_CONTAINERS; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_DICT_CONTAINERS"
    ADD CONSTRAINT "PK_XLD_DICT_CONTAINERS" PRIMARY KEY (dictionary_id, container_id);


--
-- Name: XLD_DICT_ENC_ENTRIES PK_XLD_DICT_ENC_ENTRIES; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_DICT_ENC_ENTRIES"
    ADD CONSTRAINT "PK_XLD_DICT_ENC_ENTRIES" PRIMARY KEY (dictionary_id, key);


--
-- Name: XLD_DICT_ENTRIES PK_XLD_DICT_ENTRIES; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_DICT_ENTRIES"
    ADD CONSTRAINT "PK_XLD_DICT_ENTRIES" PRIMARY KEY (dictionary_id, key);


--
-- Name: XLD_ENVIRONMENT_DICTIONARIES PK_XLD_ENVIRONMENT_DICTS; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_ENVIRONMENT_DICTIONARIES"
    ADD CONSTRAINT "PK_XLD_ENVIRONMENT_DICTS" PRIMARY KEY (environment_id, idx);


--
-- Name: XLD_ENVIRONMENT_MEMBERS PK_XLD_ENVIRONMENT_MEMBERS; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_ENVIRONMENT_MEMBERS"
    ADD CONSTRAINT "PK_XLD_ENVIRONMENT_MEMBERS" PRIMARY KEY (environment_id, member_id);


--
-- Name: XLD_LOOKUP_VALUES PK_XLD_LOOKUP_VALUES; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_LOOKUP_VALUES"
    ADD CONSTRAINT "PK_XLD_LOOKUP_VALUES" PRIMARY KEY (ci_id, name);


--
-- Name: XLD_SAT_GROUP_SATELLITES PK_XLD_SAT_GROUP_SATELLITES; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_SAT_GROUP_SATELLITES"
    ADD CONSTRAINT "PK_XLD_SAT_GROUP_SATELLITES" PRIMARY KEY (group_id, satellite_id);


--
-- Name: XLD_USER_DEFAULT_CREDENTIALS PK_XLD_USER_DEF_CREDENTIALS; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_USER_DEFAULT_CREDENTIALS"
    ADD CONSTRAINT "PK_XLD_USER_DEF_CREDENTIALS" PRIMARY KEY ("PROFILE_USERNAME");


--
-- Name: XLD_USER_PROFILES PK_XLD_USER_PROFILES; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_USER_PROFILES"
    ADD CONSTRAINT "PK_XLD_USER_PROFILES" PRIMARY KEY ("USERNAME");


--
-- Name: XLD_ACTIVE_TASKS_METADATA XLD_ACTIVE_TASKS_METADATA_PKEY; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_ACTIVE_TASKS_METADATA"
    ADD CONSTRAINT "XLD_ACTIVE_TASKS_METADATA_PKEY" PRIMARY KEY (task_id, metadata_key);


--
-- Name: XLD_ACTIVE_TASKS XLD_ACTIVE_TASKS_PKEY; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_ACTIVE_TASKS"
    ADD CONSTRAINT "XLD_ACTIVE_TASKS_PKEY" PRIMARY KEY (task_id);


--
-- Name: XLD_ARCHIVED_CONTROL_TASKS XLD_ARCHIVED_CONTROL_TASKS_PKEY; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_ARCHIVED_CONTROL_TASKS"
    ADD CONSTRAINT "XLD_ARCHIVED_CONTROL_TASKS_PKEY" PRIMARY KEY (task_id);


--
-- Name: XLD_ARCHIVED_DEPLOYMENT_TASKS XLD_ARCHIVED_DEPLOYMENT_TASKS_PKEY; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_ARCHIVED_DEPLOYMENT_TASKS"
    ADD CONSTRAINT "XLD_ARCHIVED_DEPLOYMENT_TASKS_PKEY" PRIMARY KEY (task_id);


--
-- Name: XLD_ARCHIVED_PLACEHOLDERS XLD_ARCHIVED_PLACEHOLDERS_PKEY; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_ARCHIVED_PLACEHOLDERS"
    ADD CONSTRAINT "XLD_ARCHIVED_PLACEHOLDERS_PKEY" PRIMARY KEY ("ID");


--
-- Name: XLD_ARCHIVED_TASKS XLD_ARCHIVED_TASKS_PKEY; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_ARCHIVED_TASKS"
    ADD CONSTRAINT "XLD_ARCHIVED_TASKS_PKEY" PRIMARY KEY (task_id);


--
-- Name: XLD_ARCHIVED_UNKNOWN_TASKS XLD_ARCHIVED_UNKNOWN_TASKS_PKEY; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_ARCHIVED_UNKNOWN_TASKS"
    ADD CONSTRAINT "XLD_ARCHIVED_UNKNOWN_TASKS_PKEY" PRIMARY KEY (task_id);


--
-- Name: XLD_ARCHIVE_ROLES XLD_ARCHIVE_ROLES_PKEY; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_ARCHIVE_ROLES"
    ADD CONSTRAINT "XLD_ARCHIVE_ROLES_PKEY" PRIMARY KEY ("ID");


--
-- Name: XLD_BANNER XLD_BANNER_PKEY; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_BANNER"
    ADD CONSTRAINT "XLD_BANNER_PKEY" PRIMARY KEY (kind);


--
-- Name: XLD_CIS XLD_CIS_PKEY; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_CIS"
    ADD CONSTRAINT "XLD_CIS_PKEY" PRIMARY KEY ("ID");


--
-- Name: XLD_CI_HISTORY XLD_CI_HISTORY_PKEY; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_CI_HISTORY"
    ADD CONSTRAINT "XLD_CI_HISTORY_PKEY" PRIMARY KEY ("ID");


--
-- Name: XLD_CI_PLACEHOLDERS XLD_CI_PLACEHOLDERS_PKEY; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_CI_PLACEHOLDERS"
    ADD CONSTRAINT "XLD_CI_PLACEHOLDERS_PKEY" PRIMARY KEY ("ID");


--
-- Name: XLD_CI_PROPERTIES XLD_CI_PROPERTIES_PKEY; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_CI_PROPERTIES"
    ADD CONSTRAINT "XLD_CI_PROPERTIES_PKEY" PRIMARY KEY ("ID");


--
-- Name: XLD_CONFIG_VERSION XLD_CONFIG_VERSION_PKEY; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_CONFIG_VERSION"
    ADD CONSTRAINT "XLD_CONFIG_VERSION_PKEY" PRIMARY KEY ("ID");


--
-- Name: XLD_DB_ARTIFACTS XLD_DB_ARTIFACTS_PKEY; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_DB_ARTIFACTS"
    ADD CONSTRAINT "XLD_DB_ARTIFACTS_PKEY" PRIMARY KEY ("ID");


--
-- Name: XLD_DB_ART_USAGE XLD_DB_ART_USAGE_PKEY; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_DB_ART_USAGE"
    ADD CONSTRAINT "XLD_DB_ART_USAGE_PKEY" PRIMARY KEY (ci_id);


--
-- Name: XLD_FILE_ARTIFACTS XLD_FILE_ARTIFACTS_PKEY; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_FILE_ARTIFACTS"
    ADD CONSTRAINT "XLD_FILE_ARTIFACTS_PKEY" PRIMARY KEY ("ID");


--
-- Name: XLD_FILE_ART_USAGE XLD_FILE_ART_USAGE_PKEY; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_FILE_ART_USAGE"
    ADD CONSTRAINT "XLD_FILE_ART_USAGE_PKEY" PRIMARY KEY (ci_id);


--
-- Name: XLD_HOSTS XLD_HOSTS_PKEY; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_HOSTS"
    ADD CONSTRAINT "XLD_HOSTS_PKEY" PRIMARY KEY ("ID");


--
-- Name: XLD_LOCK_TABLE XLD_LOCK_TABLE_PKEY; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_LOCK_TABLE"
    ADD CONSTRAINT "XLD_LOCK_TABLE_PKEY" PRIMARY KEY ("LOCK_NAME");


--
-- Name: XLD_PENDING_TASKS_METADATA XLD_PENDING_TASKS_METADATA_PKEY; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_PENDING_TASKS_METADATA"
    ADD CONSTRAINT "XLD_PENDING_TASKS_METADATA_PKEY" PRIMARY KEY (task_id, metadata_key);


--
-- Name: XLD_PENDING_TASKS XLD_PENDING_TASKS_PKEY; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_PENDING_TASKS"
    ADD CONSTRAINT "XLD_PENDING_TASKS_PKEY" PRIMARY KEY (task_id);


--
-- Name: XLD_PLACEHOLDERS XLD_PLACEHOLDERS_PKEY; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_PLACEHOLDERS"
    ADD CONSTRAINT "XLD_PLACEHOLDERS_PKEY" PRIMARY KEY ("ID");


--
-- Name: XLD_PROFILES XLD_PROFILES_PK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_PROFILES"
    ADD CONSTRAINT "XLD_PROFILES_PK" PRIMARY KEY ("USERNAME");


--
-- Name: XLD_SATELLITES XLD_SATELLITES_PKEY; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_SATELLITES"
    ADD CONSTRAINT "XLD_SATELLITES_PKEY" PRIMARY KEY ("ID");


--
-- Name: XLD_SCM_TRACEABILITY_DATA XLD_SCM_TRACEABILITY_DATA_PKEY; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_SCM_TRACEABILITY_DATA"
    ADD CONSTRAINT "XLD_SCM_TRACEABILITY_DATA_PKEY" PRIMARY KEY ("ID");


--
-- Name: XLD_SOURCE_ARTIFACTS XLD_SOURCE_ARTIFACTS_PKEY; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_SOURCE_ARTIFACTS"
    ADD CONSTRAINT "XLD_SOURCE_ARTIFACTS_PKEY" PRIMARY KEY ("ID");


--
-- Name: XLD_STITCH_CONTENT XLD_STITCH_CONTENT_PKEY; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_STITCH_CONTENT"
    ADD CONSTRAINT "XLD_STITCH_CONTENT_PKEY" PRIMARY KEY ("ID");


--
-- Name: XLD_STITCH_DEFINITION XLD_STITCH_DEFINITION_PKEY; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_STITCH_DEFINITION"
    ADD CONSTRAINT "XLD_STITCH_DEFINITION_PKEY" PRIMARY KEY ("ID");


--
-- Name: XLD_STITCH_MACROS XLD_STITCH_MACROS_PKEY; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_STITCH_MACROS"
    ADD CONSTRAINT "XLD_STITCH_MACROS_PKEY" PRIMARY KEY ("ID");


--
-- Name: XLD_STITCH_MACRO_PARAMETERS XLD_STITCH_MACRO_PARAMETERS_PKEY; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_STITCH_MACRO_PARAMETERS"
    ADD CONSTRAINT "XLD_STITCH_MACRO_PARAMETERS_PKEY" PRIMARY KEY ("ID");


--
-- Name: XLD_STITCH_MACRO_PROCESSORS XLD_STITCH_MACRO_PROCESSORS_PKEY; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_STITCH_MACRO_PROCESSORS"
    ADD CONSTRAINT "XLD_STITCH_MACRO_PROCESSORS_PKEY" PRIMARY KEY ("PROCESSOR_ID");


--
-- Name: XLD_STITCH_MACRO_PROC_PARAMS XLD_STITCH_MACRO_PROC_PARAMS_PKEY; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_STITCH_MACRO_PROC_PARAMS"
    ADD CONSTRAINT "XLD_STITCH_MACRO_PROC_PARAMS_PKEY" PRIMARY KEY ("PROCESSOR_PARAM_ID");


--
-- Name: XLD_STITCH_NAMESPACES XLD_STITCH_NAMESPACES_PKEY; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_STITCH_NAMESPACES"
    ADD CONSTRAINT "XLD_STITCH_NAMESPACES_PKEY" PRIMARY KEY ("ID");


--
-- Name: XLD_STITCH_PROCESSORS XLD_STITCH_PROCESSORS_PKEY; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_STITCH_PROCESSORS"
    ADD CONSTRAINT "XLD_STITCH_PROCESSORS_PKEY" PRIMARY KEY ("ID");


--
-- Name: XLD_STITCH_PROCESSOR_PARAMS XLD_STITCH_PROCESSOR_PARAMS_PKEY; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_STITCH_PROCESSOR_PARAMS"
    ADD CONSTRAINT "XLD_STITCH_PROCESSOR_PARAMS_PKEY" PRIMARY KEY ("ID");


--
-- Name: XLD_STITCH_RULES XLD_STITCH_RULES_PKEY; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_STITCH_RULES"
    ADD CONSTRAINT "XLD_STITCH_RULES_PKEY" PRIMARY KEY ("ID");


--
-- Name: XLD_STITCH_RULE_CONDITIONS XLD_STITCH_RULE_CONDITIONS_PKEY; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_STITCH_RULE_CONDITIONS"
    ADD CONSTRAINT "XLD_STITCH_RULE_CONDITIONS_PKEY" PRIMARY KEY ("ID");


--
-- Name: XLD_STITCH_RULE_PROCESSORS XLD_STITCH_RULE_PROCESSORS_PKEY; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_STITCH_RULE_PROCESSORS"
    ADD CONSTRAINT "XLD_STITCH_RULE_PROCESSORS_PKEY" PRIMARY KEY ("PROCESSOR_ID");


--
-- Name: XLD_STITCH_RULE_PROC_PARAMS XLD_STITCH_RULE_PROC_PARAMS_PKEY; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_STITCH_RULE_PROC_PARAMS"
    ADD CONSTRAINT "XLD_STITCH_RULE_PROC_PARAMS_PKEY" PRIMARY KEY ("PROCESSOR_PARAM_ID");


--
-- Name: XLD_STITCH_SOURCE_SYNC_STATE XLD_STITCH_SOURCE_SYNC_STATE_PKEY; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_STITCH_SOURCE_SYNC_STATE"
    ADD CONSTRAINT "XLD_STITCH_SOURCE_SYNC_STATE_PKEY" PRIMARY KEY ("ID");


--
-- Name: XLD_USER_CREDENTIALS XLD_USER_CREDENTIALS_PKEY; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_USER_CREDENTIALS"
    ADD CONSTRAINT "XLD_USER_CREDENTIALS_PKEY" PRIMARY KEY ("ID");


--
-- Name: XLD_WORKERS XLD_WORKERS_PKEY; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_WORKERS"
    ADD CONSTRAINT "XLD_WORKERS_PKEY" PRIMARY KEY ("ID");


--
-- Name: XL_METADATA XL_METADATA_PKEY; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XL_METADATA"
    ADD CONSTRAINT "XL_METADATA_PKEY" PRIMARY KEY (name);


--
-- Name: XL_ROLES XL_ROLES_PKEY; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XL_ROLES"
    ADD CONSTRAINT "XL_ROLES_PKEY" PRIMARY KEY ("ID");


--
-- Name: XL_USERS XL_USERS_PKEY; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XL_USERS"
    ADD CONSTRAINT "XL_USERS_PKEY" PRIMARY KEY ("USERNAME");


--
-- Name: XL_VERSION XL_VERSION_PKEY; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XL_VERSION"
    ADD CONSTRAINT "XL_VERSION_PKEY" PRIMARY KEY (component);


--
-- Name: databasechangeloglock databasechangeloglock_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.databasechangeloglock
    ADD CONSTRAINT databasechangeloglock_pkey PRIMARY KEY (id);


--
-- Name: spring_session_attributes spring_session_attributes_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.spring_session_attributes
    ADD CONSTRAINT spring_session_attributes_pk PRIMARY KEY (session_primary_id, attribute_name);


--
-- Name: spring_session spring_session_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.spring_session
    ADD CONSTRAINT spring_session_pk PRIMARY KEY (primary_id);


--
-- Name: IDX_ARCHIVE_ROLES_CI_ID; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_ARCHIVE_ROLES_CI_ID" ON public."XLD_ARCHIVE_ROLES" USING btree ("CI_ID");


--
-- Name: IDX_ARCHIVE_ROLES_NAME; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_ARCHIVE_ROLES_NAME" ON public."XLD_ARCHIVE_ROLES" USING btree ("NAME");


--
-- Name: IDX_ARCH_ROLE_PERM_CI_ID; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_ARCH_ROLE_PERM_CI_ID" ON public."XLD_ARCHIVE_ROLE_PERMISSIONS" USING btree ("CI_ID");


--
-- Name: IDX_ARCH_ROLE_PERM_PERM_NAME; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_ARCH_ROLE_PERM_PERM_NAME" ON public."XLD_ARCHIVE_ROLE_PERMISSIONS" USING btree ("PERMISSION_NAME");


--
-- Name: IDX_ARCH_ROLE_PERM_ROLE_ID; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_ARCH_ROLE_PERM_ROLE_ID" ON public."XLD_ARCHIVE_ROLE_PERMISSIONS" USING btree ("ROLE_ID");


--
-- Name: IDX_ARCH_ROLE_PRIN_PRIN_NAME; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_ARCH_ROLE_PRIN_PRIN_NAME" ON public."XLD_ARCHIVE_ROLE_PRINCIPALS" USING btree ("PRINCIPAL_NAME");


--
-- Name: IDX_ARCH_ROLE_PRIN_ROLE_ID; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_ARCH_ROLE_PRIN_ROLE_ID" ON public."XLD_ARCHIVE_ROLE_PRINCIPALS" USING btree ("ROLE_ID");


--
-- Name: IDX_ARCH_ROLE_ROLES_ROLE_ID; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_ARCH_ROLE_ROLES_ROLE_ID" ON public."XLD_ARCHIVE_ROLE_ROLES" USING btree ("ROLE_ID");


--
-- Name: IDX_ROLES_CI_ID; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_ROLES_CI_ID" ON public."XL_ROLES" USING btree ("CI_ID");


--
-- Name: IDX_ROLES_NAME; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_ROLES_NAME" ON public."XL_ROLES" USING btree ("NAME");


--
-- Name: IDX_ROLE_PERM_CI_ID; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_ROLE_PERM_CI_ID" ON public."XL_ROLE_PERMISSIONS" USING btree ("CI_ID");


--
-- Name: IDX_ROLE_PERM_PERM_NAME; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_ROLE_PERM_PERM_NAME" ON public."XL_ROLE_PERMISSIONS" USING btree ("PERMISSION_NAME");


--
-- Name: IDX_ROLE_PERM_ROLE_ID; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_ROLE_PERM_ROLE_ID" ON public."XL_ROLE_PERMISSIONS" USING btree ("ROLE_ID");


--
-- Name: IDX_ROLE_PRIN_PRIN_NAME; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_ROLE_PRIN_PRIN_NAME" ON public."XL_ROLE_PRINCIPALS" USING btree ("PRINCIPAL_NAME");


--
-- Name: IDX_ROLE_PRIN_ROLE_ID; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_ROLE_PRIN_ROLE_ID" ON public."XL_ROLE_PRINCIPALS" USING btree ("ROLE_ID");


--
-- Name: IDX_ROLE_ROLES_ROLE_ID; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_ROLE_ROLES_ROLE_ID" ON public."XL_ROLE_ROLES" USING btree ("ROLE_ID");


--
-- Name: XLD_ACTIVE_TASKS_METADATA_METADATA_KEY_IDX; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "XLD_ACTIVE_TASKS_METADATA_METADATA_KEY_IDX" ON public."XLD_ACTIVE_TASKS_METADATA" USING btree (metadata_key);


--
-- Name: XLD_ACT_TARGET_INT_ID_IDX; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "XLD_ACT_TARGET_INT_ID_IDX" ON public."XLD_ARCHIVED_CONTROL_TASKS" USING btree (target_internal_id);


--
-- Name: XLD_ACT_TARGET_SEC_ID_IDX; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "XLD_ACT_TARGET_SEC_ID_IDX" ON public."XLD_ARCHIVED_CONTROL_TASKS" USING btree (target_secured_ci);


--
-- Name: XLD_ADTAPP_APP_INT_ID_IDX; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "XLD_ADTAPP_APP_INT_ID_IDX" ON public."XLD_ARCHIVED_DT_APPLICATIONS" USING btree (application_internal_id);


--
-- Name: XLD_ADTAPP_APP_SEC_ID_IDX; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "XLD_ADTAPP_APP_SEC_ID_IDX" ON public."XLD_ARCHIVED_DT_APPLICATIONS" USING btree (application_secured_ci);


--
-- Name: XLD_ADT_ENV_INT_ID_IDX; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "XLD_ADT_ENV_INT_ID_IDX" ON public."XLD_ARCHIVED_DEPLOYMENT_TASKS" USING btree (environment_internal_id);


--
-- Name: XLD_ADT_ENV_SEC_ID_IDX; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "XLD_ADT_ENV_SEC_ID_IDX" ON public."XLD_ARCHIVED_DEPLOYMENT_TASKS" USING btree (environment_secured_ci);


--
-- Name: XLD_ARCHIVED_CT_START_DATE_IDX; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "XLD_ARCHIVED_CT_START_DATE_IDX" ON public."XLD_ARCHIVED_CONTROL_TASKS" USING btree (start_date);


--
-- Name: XLD_ARCHIVED_DT_APP_IDX; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "XLD_ARCHIVED_DT_APP_IDX" ON public."XLD_ARCHIVED_DT_APPLICATIONS" USING btree (application);


--
-- Name: XLD_ARCHIVED_DT_ENV_IDX; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "XLD_ARCHIVED_DT_ENV_IDX" ON public."XLD_ARCHIVED_DEPLOYMENT_TASKS" USING btree (environment);


--
-- Name: XLD_ARCHIVED_DT_START_DATE_IDX; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "XLD_ARCHIVED_DT_START_DATE_IDX" ON public."XLD_ARCHIVED_DEPLOYMENT_TASKS" USING btree (start_date);


--
-- Name: XLD_ARCHIVED_UT_START_DATE_IDX; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "XLD_ARCHIVED_UT_START_DATE_IDX" ON public."XLD_ARCHIVED_UNKNOWN_TASKS" USING btree (start_date);


--
-- Name: XLD_ARCH_PH_CONTAINER_ID_IDX; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "XLD_ARCH_PH_CONTAINER_ID_IDX" ON public."XLD_ARCHIVED_PLACEHOLDERS" USING btree (container_id);


--
-- Name: XLD_ARCH_PH_DICT_ID_IDX; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "XLD_ARCH_PH_DICT_ID_IDX" ON public."XLD_ARCHIVED_PLACEHOLDERS" USING btree (dictionary_id);


--
-- Name: XLD_ARCH_PH_ENV_ID_IDX; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "XLD_ARCH_PH_ENV_ID_IDX" ON public."XLD_ARCHIVED_PLACEHOLDERS" USING btree (environment_id);


--
-- Name: XLD_CIS_CI_TYPE_IDX; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "XLD_CIS_CI_TYPE_IDX" ON public."XLD_CIS" USING btree (ci_type);


--
-- Name: XLD_CIS_NAME_IDX; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "XLD_CIS_NAME_IDX" ON public."XLD_CIS" USING btree (name);


--
-- Name: XLD_CIS_PARENT_IDX; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "XLD_CIS_PARENT_IDX" ON public."XLD_CIS" USING btree (parent_id);


--
-- Name: XLD_CIS_PATH_IDX; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "XLD_CIS_PATH_IDX" ON public."XLD_CIS" USING btree (path);


--
-- Name: XLD_CIS_SECURED_CI_IDX; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "XLD_CIS_SECURED_CI_IDX" ON public."XLD_CIS" USING btree (secured_ci);


--
-- Name: XLD_CI_HISTORY_CI_ID_IDX; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "XLD_CI_HISTORY_CI_ID_IDX" ON public."XLD_CI_HISTORY" USING btree (ci_id);


--
-- Name: XLD_CI_PLACEHOLDERS_PATH_IDX; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "XLD_CI_PLACEHOLDERS_PATH_IDX" ON public."XLD_CI_PLACEHOLDERS" USING btree (ci_path);


--
-- Name: XLD_CI_PROP_CI_REF_IDX; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "XLD_CI_PROP_CI_REF_IDX" ON public."XLD_CI_PROPERTIES" USING btree (ci_ref_value);


--
-- Name: XLD_CI_PROP_OBJECT_ID_IDX; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "XLD_CI_PROP_OBJECT_ID_IDX" ON public."XLD_CI_PROPERTIES" USING btree (ci_id);


--
-- Name: XLD_CONFIG_VERSION_BOOT_DT_IDX; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "XLD_CONFIG_VERSION_BOOT_DT_IDX" ON public."XLD_CONFIG_VERSION" USING btree (boot_date_time);


--
-- Name: XLD_DB_ART_USAGE_ART_IDX; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "XLD_DB_ART_USAGE_ART_IDX" ON public."XLD_DB_ART_USAGE" USING btree (artifact_id);


--
-- Name: XLD_DICT_APPL_APPL_IDX; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "XLD_DICT_APPL_APPL_IDX" ON public."XLD_DICT_APPLICATIONS" USING btree (application_id);


--
-- Name: XLD_DICT_APPL_DICT_IDX; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "XLD_DICT_APPL_DICT_IDX" ON public."XLD_DICT_APPLICATIONS" USING btree (dictionary_id);


--
-- Name: XLD_DICT_CONTAINERS_CONT_IDX; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "XLD_DICT_CONTAINERS_CONT_IDX" ON public."XLD_DICT_CONTAINERS" USING btree (container_id);


--
-- Name: XLD_DICT_CONTAINERS_DICT_IDX; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "XLD_DICT_CONTAINERS_DICT_IDX" ON public."XLD_DICT_CONTAINERS" USING btree (dictionary_id);


--
-- Name: XLD_DICT_ENC_ENT_DIC_IDX; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "XLD_DICT_ENC_ENT_DIC_IDX" ON public."XLD_DICT_ENC_ENTRIES" USING btree (dictionary_id);


--
-- Name: XLD_DICT_ENT_DIC_IDX; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "XLD_DICT_ENT_DIC_IDX" ON public."XLD_DICT_ENTRIES" USING btree (dictionary_id);


--
-- Name: XLD_ENVIRONMENT_DICT_DICT_IDX; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "XLD_ENVIRONMENT_DICT_DICT_IDX" ON public."XLD_ENVIRONMENT_DICTIONARIES" USING btree (dictionary_id);


--
-- Name: XLD_ENVIRONMENT_DICT_ENV_IDX; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "XLD_ENVIRONMENT_DICT_ENV_IDX" ON public."XLD_ENVIRONMENT_DICTIONARIES" USING btree (environment_id);


--
-- Name: XLD_ENVIRONMENT_MEMB_ENV_IDX; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "XLD_ENVIRONMENT_MEMB_ENV_IDX" ON public."XLD_ENVIRONMENT_MEMBERS" USING btree (environment_id);


--
-- Name: XLD_ENVIRONMENT_MEMB_MEMB_IDX; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "XLD_ENVIRONMENT_MEMB_MEMB_IDX" ON public."XLD_ENVIRONMENT_MEMBERS" USING btree (member_id);


--
-- Name: XLD_FILE_ART_LOCATION_IDX; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "XLD_FILE_ART_LOCATION_IDX" ON public."XLD_FILE_ARTIFACTS" USING btree (location);


--
-- Name: XLD_FILE_ART_USAGE_ART_IDX; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "XLD_FILE_ART_USAGE_ART_IDX" ON public."XLD_FILE_ART_USAGE" USING btree (artifact_id);


--
-- Name: XLD_HOSTS_SATELLITE_ID_IDX; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "XLD_HOSTS_SATELLITE_ID_IDX" ON public."XLD_HOSTS" USING btree (satellite_id);


--
-- Name: XLD_LOOKUP_VALUES_CI_IDX; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "XLD_LOOKUP_VALUES_CI_IDX" ON public."XLD_LOOKUP_VALUES" USING btree (ci_id);


--
-- Name: XLD_LOOKUP_VALUES_PROV_IDX; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "XLD_LOOKUP_VALUES_PROV_IDX" ON public."XLD_LOOKUP_VALUES" USING btree (provider);


--
-- Name: XLD_PH_CONTAINER_ID_IDX; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "XLD_PH_CONTAINER_ID_IDX" ON public."XLD_PLACEHOLDERS" USING btree (container_id);


--
-- Name: XLD_PH_DICT_ID_IDX; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "XLD_PH_DICT_ID_IDX" ON public."XLD_PLACEHOLDERS" USING btree (dictionary_id);


--
-- Name: XLD_PH_ENV_ID_IDX; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "XLD_PH_ENV_ID_IDX" ON public."XLD_PLACEHOLDERS" USING btree (environment_id);


--
-- Name: XLD_SAT_GROUP_SAT_GROUP_IDX; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "XLD_SAT_GROUP_SAT_GROUP_IDX" ON public."XLD_SAT_GROUP_SATELLITES" USING btree (group_id);


--
-- Name: XLD_SAT_GROUP_SAT_SAT_IDX; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "XLD_SAT_GROUP_SAT_SAT_IDX" ON public."XLD_SAT_GROUP_SATELLITES" USING btree (satellite_id);


--
-- Name: XLD_ST_CNT_SRC_ID_BN_IDX; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "XLD_ST_CNT_SRC_ID_BN_IDX" ON public."XLD_STITCH_CONTENT" USING btree ("SOURCE_ID", "BRANCH_NAME");


--
-- Name: XLD_ST_MACPARAM_MACROID_IDX; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "XLD_ST_MACPARAM_MACROID_IDX" ON public."XLD_STITCH_MACRO_PARAMETERS" USING btree ("MACRO_ID");


--
-- Name: XLD_ST_MACPARAM_SOURCEID_IDX; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "XLD_ST_MACPARAM_SOURCEID_IDX" ON public."XLD_STITCH_MACRO_PARAMETERS" USING btree ("SOURCE_ID");


--
-- Name: XLD_ST_MACROS_DEF_ID_IDX; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "XLD_ST_MACROS_DEF_ID_IDX" ON public."XLD_STITCH_MACROS" USING btree ("DEFINITION_ID");


--
-- Name: XLD_ST_MACROS_NAMESPACE_ID_IDX; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "XLD_ST_MACROS_NAMESPACE_ID_IDX" ON public."XLD_STITCH_MACROS" USING btree ("NAMESPACE_ID");


--
-- Name: XLD_ST_MACROS_SOURCE_ID_IDX; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "XLD_ST_MACROS_SOURCE_ID_IDX" ON public."XLD_STITCH_MACROS" USING btree ("SOURCE_ID");


--
-- Name: XLD_ST_MACRO_PROC_MAC_ID_IDX; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "XLD_ST_MACRO_PROC_MAC_ID_IDX" ON public."XLD_STITCH_MACRO_PROCESSORS" USING btree ("MACRO_ID");


--
-- Name: XLD_ST_MCS_UNQ_IN_NS_BN_IDX; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "XLD_ST_MCS_UNQ_IN_NS_BN_IDX" ON public."XLD_STITCH_MACROS" USING btree ("NAMESPACE_ID", "NAME", "BRANCH_NAME");


--
-- Name: XLD_ST_META_SOURCE_ID_BN_IDX; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "XLD_ST_META_SOURCE_ID_BN_IDX" ON public."XLD_STITCH_DEFINITION" USING btree ("SOURCE_ID", "BRANCH_NAME");


--
-- Name: XLD_ST_META_SOURCE_ID_IDX; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "XLD_ST_META_SOURCE_ID_IDX" ON public."XLD_STITCH_DEFINITION" USING btree ("SOURCE_ID");


--
-- Name: XLD_ST_MTDT_NAMESPACE_ID_IDX; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "XLD_ST_MTDT_NAMESPACE_ID_IDX" ON public."XLD_STITCH_DEFINITION" USING btree ("NAMESPACE_ID");


--
-- Name: XLD_ST_NAMESPACES_NAME_IDX; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "XLD_ST_NAMESPACES_NAME_IDX" ON public."XLD_STITCH_NAMESPACES" USING btree ("NAME");


--
-- Name: XLD_ST_PROCESSOR_SOURCE_ID_IDX; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "XLD_ST_PROCESSOR_SOURCE_ID_IDX" ON public."XLD_STITCH_PROCESSORS" USING btree ("SOURCE_ID");


--
-- Name: XLD_ST_PROC_DEFINITION_ID_IDX; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "XLD_ST_PROC_DEFINITION_ID_IDX" ON public."XLD_STITCH_PROCESSORS" USING btree ("DEFINITION_ID");


--
-- Name: XLD_ST_PROC_NAMESPACE_ID_IDX; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "XLD_ST_PROC_NAMESPACE_ID_IDX" ON public."XLD_STITCH_PROCESSORS" USING btree ("NAMESPACE_ID");


--
-- Name: XLD_ST_PROC_PAR_SOURCE_ID_IDX; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "XLD_ST_PROC_PAR_SOURCE_ID_IDX" ON public."XLD_STITCH_PROCESSOR_PARAMS" USING btree ("SOURCE_ID");


--
-- Name: XLD_ST_RL_COND_SOURCE_ID_IDX; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "XLD_ST_RL_COND_SOURCE_ID_IDX" ON public."XLD_STITCH_RULE_CONDITIONS" USING btree ("SOURCE_ID");


--
-- Name: XLD_ST_RULES_DEFINITION_ID_IDX; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "XLD_ST_RULES_DEFINITION_ID_IDX" ON public."XLD_STITCH_RULES" USING btree ("DEFINITION_ID");


--
-- Name: XLD_ST_RULES_NAMESPACE_ID_IDX; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "XLD_ST_RULES_NAMESPACE_ID_IDX" ON public."XLD_STITCH_RULES" USING btree ("NAMESPACE_ID");


--
-- Name: XLD_ST_RULE_PROCE_RULE_ID_IDX; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "XLD_ST_RULE_PROCE_RULE_ID_IDX" ON public."XLD_STITCH_RULE_PROCESSORS" USING btree ("RULE_ID");


--
-- Name: XLD_ST_RULE_SOURCE_ID_IDX; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "XLD_ST_RULE_SOURCE_ID_IDX" ON public."XLD_STITCH_RULES" USING btree ("SOURCE_ID");


--
-- Name: XLD_ST_RULE_UNQ_IN_NS_BN_IDX; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "XLD_ST_RULE_UNQ_IN_NS_BN_IDX" ON public."XLD_STITCH_RULES" USING btree ("NAMESPACE_ID", "NAME", "BRANCH_NAME");


--
-- Name: XLD_WORKERS_ADDRESS_IDX; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "XLD_WORKERS_ADDRESS_IDX" ON public."XLD_WORKERS" USING btree (address);


--
-- Name: xld_session_principal_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX xld_session_principal_idx ON public.spring_session USING btree (principal_name);


--
-- Name: xld_spring_session_expiry_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX xld_spring_session_expiry_idx ON public.spring_session USING btree (expiry_time);


--
-- Name: xld_spring_session_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX xld_spring_session_id_idx ON public.spring_session USING btree (session_id);


--
-- Name: XLD_ARCHIVED_CONTROL_TASKS FK_ARCHIVED_CONTROL_TASKS_ID; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_ARCHIVED_CONTROL_TASKS"
    ADD CONSTRAINT "FK_ARCHIVED_CONTROL_TASKS_ID" FOREIGN KEY (task_id) REFERENCES public."XLD_ARCHIVED_TASKS"(task_id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- Name: XLD_ARCHIVED_DEPLOYMENT_TASKS FK_ARCHIVED_DEPLOYMENT_TASK_ID; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_ARCHIVED_DEPLOYMENT_TASKS"
    ADD CONSTRAINT "FK_ARCHIVED_DEPLOYMENT_TASK_ID" FOREIGN KEY (task_id) REFERENCES public."XLD_ARCHIVED_TASKS"(task_id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- Name: XLD_ARCHIVED_DT_APPLICATIONS FK_ARCHIVED_DT_APPLICATIONS_ID; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_ARCHIVED_DT_APPLICATIONS"
    ADD CONSTRAINT "FK_ARCHIVED_DT_APPLICATIONS_ID" FOREIGN KEY (task_id) REFERENCES public."XLD_ARCHIVED_DEPLOYMENT_TASKS"(task_id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- Name: XLD_ARCHIVED_UNKNOWN_TASKS FK_ARCHIVED_UNKNOWN_TASKS_ID; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_ARCHIVED_UNKNOWN_TASKS"
    ADD CONSTRAINT "FK_ARCHIVED_UNKNOWN_TASKS_ID" FOREIGN KEY (task_id) REFERENCES public."XLD_ARCHIVED_TASKS"(task_id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- Name: XLD_ARCHIVE_ROLE_PERMISSIONS FK_ARCH_ROLE_PERM_ROLES_ID; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_ARCHIVE_ROLE_PERMISSIONS"
    ADD CONSTRAINT "FK_ARCH_ROLE_PERM_ROLES_ID" FOREIGN KEY ("ROLE_ID") REFERENCES public."XLD_ARCHIVE_ROLES"("ID");


--
-- Name: XLD_ARCHIVE_ROLE_PRINCIPALS FK_ARCH_ROLE_PRIN_ROLES_ID; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_ARCHIVE_ROLE_PRINCIPALS"
    ADD CONSTRAINT "FK_ARCH_ROLE_PRIN_ROLES_ID" FOREIGN KEY ("ROLE_ID") REFERENCES public."XLD_ARCHIVE_ROLES"("ID");


--
-- Name: XLD_ARCHIVE_ROLE_ROLES FK_ARCH_ROLE_ROLES_ROLES_ID; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_ARCHIVE_ROLE_ROLES"
    ADD CONSTRAINT "FK_ARCH_ROLE_ROLES_ROLES_ID" FOREIGN KEY ("ROLE_ID") REFERENCES public."XLD_ARCHIVE_ROLES"("ID");


--
-- Name: XL_ROLE_PERMISSIONS FK_ROLE_PERM_ROLES_ID; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XL_ROLE_PERMISSIONS"
    ADD CONSTRAINT "FK_ROLE_PERM_ROLES_ID" FOREIGN KEY ("ROLE_ID") REFERENCES public."XL_ROLES"("ID");


--
-- Name: XL_ROLE_PRINCIPALS FK_ROLE_PRIN_ROLES_ID; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XL_ROLE_PRINCIPALS"
    ADD CONSTRAINT "FK_ROLE_PRIN_ROLES_ID" FOREIGN KEY ("ROLE_ID") REFERENCES public."XL_ROLES"("ID");


--
-- Name: XL_ROLE_ROLES FK_ROLE_ROLES_ROLES_ID; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XL_ROLE_ROLES"
    ADD CONSTRAINT "FK_ROLE_ROLES_ROLES_ID" FOREIGN KEY ("ROLE_ID") REFERENCES public."XL_ROLES"("ID");


--
-- Name: XLD_CI_HISTORY FK_XLD_CI_HISTORY_CI_ID; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_CI_HISTORY"
    ADD CONSTRAINT "FK_XLD_CI_HISTORY_CI_ID" FOREIGN KEY (ci_id) REFERENCES public."XLD_CIS"("ID");


--
-- Name: XLD_CI_LOCK FK_XLD_CI_LOCK_ID; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_CI_LOCK"
    ADD CONSTRAINT "FK_XLD_CI_LOCK_ID" FOREIGN KEY (task_id) REFERENCES public."XLD_ACTIVE_TASKS"(task_id) ON DELETE CASCADE;


--
-- Name: XLD_CIS FK_XLD_CI_PARENT_ID; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_CIS"
    ADD CONSTRAINT "FK_XLD_CI_PARENT_ID" FOREIGN KEY (parent_id) REFERENCES public."XLD_CIS"("ID");


--
-- Name: XLD_CI_PROPERTIES FK_XLD_CI_PROP_OBJECT_ID; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_CI_PROPERTIES"
    ADD CONSTRAINT "FK_XLD_CI_PROP_OBJECT_ID" FOREIGN KEY (ci_id) REFERENCES public."XLD_CIS"("ID");


--
-- Name: XLD_CI_PROPERTIES FK_XLD_CI_PROP_REF; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_CI_PROPERTIES"
    ADD CONSTRAINT "FK_XLD_CI_PROP_REF" FOREIGN KEY (ci_ref_value) REFERENCES public."XLD_CIS"("ID");


--
-- Name: XLD_DB_ART_USAGE FK_XLD_DB_ART_USAGE_ARTIFACT; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_DB_ART_USAGE"
    ADD CONSTRAINT "FK_XLD_DB_ART_USAGE_ARTIFACT" FOREIGN KEY (artifact_id) REFERENCES public."XLD_DB_ARTIFACTS"("ID");


--
-- Name: XLD_DB_ART_USAGE FK_XLD_DB_ART_USAGE_CI; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_DB_ART_USAGE"
    ADD CONSTRAINT "FK_XLD_DB_ART_USAGE_CI" FOREIGN KEY (ci_id) REFERENCES public."XLD_CIS"("ID");


--
-- Name: XLD_DICT_APPLICATIONS FK_XLD_DICT_APPL_APPL; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_DICT_APPLICATIONS"
    ADD CONSTRAINT "FK_XLD_DICT_APPL_APPL" FOREIGN KEY (application_id) REFERENCES public."XLD_CIS"("ID");


--
-- Name: XLD_DICT_APPLICATIONS FK_XLD_DICT_APPL_DICT; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_DICT_APPLICATIONS"
    ADD CONSTRAINT "FK_XLD_DICT_APPL_DICT" FOREIGN KEY (dictionary_id) REFERENCES public."XLD_CIS"("ID");


--
-- Name: XLD_DICT_CONTAINERS FK_XLD_DICT_CONT_CONT; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_DICT_CONTAINERS"
    ADD CONSTRAINT "FK_XLD_DICT_CONT_CONT" FOREIGN KEY (container_id) REFERENCES public."XLD_CIS"("ID");


--
-- Name: XLD_DICT_CONTAINERS FK_XLD_DICT_CONT_DICT; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_DICT_CONTAINERS"
    ADD CONSTRAINT "FK_XLD_DICT_CONT_DICT" FOREIGN KEY (dictionary_id) REFERENCES public."XLD_CIS"("ID");


--
-- Name: XLD_DICT_ENC_ENTRIES FK_XLD_DICT_ENC_ENT_DICT; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_DICT_ENC_ENTRIES"
    ADD CONSTRAINT "FK_XLD_DICT_ENC_ENT_DICT" FOREIGN KEY (dictionary_id) REFERENCES public."XLD_CIS"("ID");


--
-- Name: XLD_DICT_ENTRIES FK_XLD_DICT_ENT_DICT; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_DICT_ENTRIES"
    ADD CONSTRAINT "FK_XLD_DICT_ENT_DICT" FOREIGN KEY (dictionary_id) REFERENCES public."XLD_CIS"("ID");


--
-- Name: XLD_ENVIRONMENT_DICTIONARIES FK_XLD_ENV_DICT_DICT; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_ENVIRONMENT_DICTIONARIES"
    ADD CONSTRAINT "FK_XLD_ENV_DICT_DICT" FOREIGN KEY (dictionary_id) REFERENCES public."XLD_CIS"("ID");


--
-- Name: XLD_ENVIRONMENT_DICTIONARIES FK_XLD_ENV_DICT_ENV; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_ENVIRONMENT_DICTIONARIES"
    ADD CONSTRAINT "FK_XLD_ENV_DICT_ENV" FOREIGN KEY (environment_id) REFERENCES public."XLD_CIS"("ID");


--
-- Name: XLD_ENVIRONMENT_MEMBERS FK_XLD_ENV_MEM_ENV; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_ENVIRONMENT_MEMBERS"
    ADD CONSTRAINT "FK_XLD_ENV_MEM_ENV" FOREIGN KEY (environment_id) REFERENCES public."XLD_CIS"("ID");


--
-- Name: XLD_ENVIRONMENT_MEMBERS FK_XLD_ENV_MEM_MEM; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_ENVIRONMENT_MEMBERS"
    ADD CONSTRAINT "FK_XLD_ENV_MEM_MEM" FOREIGN KEY (member_id) REFERENCES public."XLD_CIS"("ID");


--
-- Name: XLD_FILE_ART_USAGE FK_XLD_FILE_ART_USAGE_ARTIFACT; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_FILE_ART_USAGE"
    ADD CONSTRAINT "FK_XLD_FILE_ART_USAGE_ARTIFACT" FOREIGN KEY (artifact_id) REFERENCES public."XLD_FILE_ARTIFACTS"("ID");


--
-- Name: XLD_FILE_ART_USAGE FK_XLD_FILE_ART_USAGE_CI; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_FILE_ART_USAGE"
    ADD CONSTRAINT "FK_XLD_FILE_ART_USAGE_CI" FOREIGN KEY (ci_id) REFERENCES public."XLD_CIS"("ID");


--
-- Name: XLD_HOSTS FK_XLD_HOSTS_ID; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_HOSTS"
    ADD CONSTRAINT "FK_XLD_HOSTS_ID" FOREIGN KEY ("ID") REFERENCES public."XLD_CIS"("ID");


--
-- Name: XLD_HOSTS FK_XLD_HOSTS_SATELLITE_ID; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_HOSTS"
    ADD CONSTRAINT "FK_XLD_HOSTS_SATELLITE_ID" FOREIGN KEY (satellite_id) REFERENCES public."XLD_CIS"("ID");


--
-- Name: XLD_LOOKUP_VALUES FK_XLD_LOOKUP_VALUES_CI; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_LOOKUP_VALUES"
    ADD CONSTRAINT "FK_XLD_LOOKUP_VALUES_CI" FOREIGN KEY (ci_id) REFERENCES public."XLD_CIS"("ID");


--
-- Name: XLD_LOOKUP_VALUES FK_XLD_LOOKUP_VALUES_PROV; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_LOOKUP_VALUES"
    ADD CONSTRAINT "FK_XLD_LOOKUP_VALUES_PROV" FOREIGN KEY (provider) REFERENCES public."XLD_CIS"("ID");


--
-- Name: XLD_STITCH_MACROS FK_XLD_MACRO_CONTENT_ID; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_STITCH_MACROS"
    ADD CONSTRAINT "FK_XLD_MACRO_CONTENT_ID" FOREIGN KEY ("CONTENT_ID") REFERENCES public."XLD_STITCH_CONTENT"("ID");


--
-- Name: XLD_STITCH_MACROS FK_XLD_MACRO_NAMESPACE_ID; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_STITCH_MACROS"
    ADD CONSTRAINT "FK_XLD_MACRO_NAMESPACE_ID" FOREIGN KEY ("NAMESPACE_ID") REFERENCES public."XLD_STITCH_NAMESPACES"("ID");


--
-- Name: XLD_STITCH_MACRO_PROCESSORS FK_XLD_MACRO_PROC_PROC_ID; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_STITCH_MACRO_PROCESSORS"
    ADD CONSTRAINT "FK_XLD_MACRO_PROC_PROC_ID" FOREIGN KEY ("PROCESSOR_ID") REFERENCES public."XLD_STITCH_PROCESSORS"("ID");


--
-- Name: XLD_STITCH_MACROS FK_XLD_MACRO_REPOSITORY_ID; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_STITCH_MACROS"
    ADD CONSTRAINT "FK_XLD_MACRO_REPOSITORY_ID" FOREIGN KEY ("DEFINITION_ID") REFERENCES public."XLD_STITCH_DEFINITION"("ID");


--
-- Name: XLD_STITCH_PROCESSORS FK_XLD_PROCESSOR_DEFINITION_ID; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_STITCH_PROCESSORS"
    ADD CONSTRAINT "FK_XLD_PROCESSOR_DEFINITION_ID" FOREIGN KEY ("DEFINITION_ID") REFERENCES public."XLD_STITCH_DEFINITION"("ID");


--
-- Name: XLD_STITCH_PROCESSORS FK_XLD_PROCESSOR_NAMESPACE_ID; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_STITCH_PROCESSORS"
    ADD CONSTRAINT "FK_XLD_PROCESSOR_NAMESPACE_ID" FOREIGN KEY ("NAMESPACE_ID") REFERENCES public."XLD_STITCH_NAMESPACES"("ID");


--
-- Name: XLD_STITCH_RULES FK_XLD_RULE_CONTENT_ID; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_STITCH_RULES"
    ADD CONSTRAINT "FK_XLD_RULE_CONTENT_ID" FOREIGN KEY ("CONTENT_ID") REFERENCES public."XLD_STITCH_CONTENT"("ID");


--
-- Name: XLD_STITCH_RULES FK_XLD_RULE_NAMESPACE_ID; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_STITCH_RULES"
    ADD CONSTRAINT "FK_XLD_RULE_NAMESPACE_ID" FOREIGN KEY ("NAMESPACE_ID") REFERENCES public."XLD_STITCH_NAMESPACES"("ID");


--
-- Name: XLD_STITCH_RULE_PROCESSORS FK_XLD_RULE_PROC_PROCESSOR_ID; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_STITCH_RULE_PROCESSORS"
    ADD CONSTRAINT "FK_XLD_RULE_PROC_PROCESSOR_ID" FOREIGN KEY ("PROCESSOR_ID") REFERENCES public."XLD_STITCH_PROCESSORS"("ID");


--
-- Name: XLD_STITCH_RULES FK_XLD_RULE_REPOSITORY_ID; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_STITCH_RULES"
    ADD CONSTRAINT "FK_XLD_RULE_REPOSITORY_ID" FOREIGN KEY ("DEFINITION_ID") REFERENCES public."XLD_STITCH_DEFINITION"("ID");


--
-- Name: XLD_SATELLITES FK_XLD_SATELLITES_ID; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_SATELLITES"
    ADD CONSTRAINT "FK_XLD_SATELLITES_ID" FOREIGN KEY ("ID") REFERENCES public."XLD_CIS"("ID");


--
-- Name: XLD_SAT_GROUP_SATELLITES FK_XLD_SAT_GROUP_GROUP; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_SAT_GROUP_SATELLITES"
    ADD CONSTRAINT "FK_XLD_SAT_GROUP_GROUP" FOREIGN KEY (group_id) REFERENCES public."XLD_CIS"("ID");


--
-- Name: XLD_SAT_GROUP_SATELLITES FK_XLD_SAT_GROUP_SAT; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_SAT_GROUP_SATELLITES"
    ADD CONSTRAINT "FK_XLD_SAT_GROUP_SAT" FOREIGN KEY (satellite_id) REFERENCES public."XLD_CIS"("ID");


--
-- Name: XLD_SOURCE_ARTIFACTS FK_XLD_SOURCE_ARTIFACTS_ID; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_SOURCE_ARTIFACTS"
    ADD CONSTRAINT "FK_XLD_SOURCE_ARTIFACTS_ID" FOREIGN KEY ("ID") REFERENCES public."XLD_CIS"("ID");


--
-- Name: XLD_STITCH_SOURCE_SYNC_STATE FK_XLD_SRC_SYNC_ST_SOURCE_ID; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_STITCH_SOURCE_SYNC_STATE"
    ADD CONSTRAINT "FK_XLD_SRC_SYNC_ST_SOURCE_ID" FOREIGN KEY ("SOURCE_ID") REFERENCES public."XLD_CIS"("ID");


--
-- Name: XLD_STITCH_MACROS FK_XLD_STITCH_MACRO_SOURCE_ID; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_STITCH_MACROS"
    ADD CONSTRAINT "FK_XLD_STITCH_MACRO_SOURCE_ID" FOREIGN KEY ("SOURCE_ID") REFERENCES public."XLD_CIS"("ID");


--
-- Name: XLD_STITCH_RULES FK_XLD_STITCH_RULE_SOURCE_ID; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_STITCH_RULES"
    ADD CONSTRAINT "FK_XLD_STITCH_RULE_SOURCE_ID" FOREIGN KEY ("SOURCE_ID") REFERENCES public."XLD_CIS"("ID");


--
-- Name: XLD_STITCH_MACRO_PARAMETERS FK_XLD_ST_MACROPARAM_MACROID; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_STITCH_MACRO_PARAMETERS"
    ADD CONSTRAINT "FK_XLD_ST_MACROPARAM_MACROID" FOREIGN KEY ("MACRO_ID") REFERENCES public."XLD_STITCH_MACROS"("ID");


--
-- Name: XLD_STITCH_MACRO_PARAMETERS FK_XLD_ST_MACROPARAM_SOURCEID; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_STITCH_MACRO_PARAMETERS"
    ADD CONSTRAINT "FK_XLD_ST_MACROPARAM_SOURCEID" FOREIGN KEY ("SOURCE_ID") REFERENCES public."XLD_CIS"("ID");


--
-- Name: XLD_STITCH_MACRO_PROCESSORS FK_XLD_ST_MACRO_PROC_MACRO_ID; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_STITCH_MACRO_PROCESSORS"
    ADD CONSTRAINT "FK_XLD_ST_MACRO_PROC_MACRO_ID" FOREIGN KEY ("MACRO_ID") REFERENCES public."XLD_STITCH_MACROS"("ID");


--
-- Name: XLD_STITCH_DEFINITION FK_XLD_ST_META_SOURCE_ID; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_STITCH_DEFINITION"
    ADD CONSTRAINT "FK_XLD_ST_META_SOURCE_ID" FOREIGN KEY ("SOURCE_ID") REFERENCES public."XLD_CIS"("ID");


--
-- Name: XLD_STITCH_MACRO_PROC_PARAMS FK_XLD_ST_MP_PARAMPROC_PARAMID; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_STITCH_MACRO_PROC_PARAMS"
    ADD CONSTRAINT "FK_XLD_ST_MP_PARAMPROC_PARAMID" FOREIGN KEY ("PROCESSOR_PARAM_ID") REFERENCES public."XLD_STITCH_PROCESSOR_PARAMS"("ID");


--
-- Name: XLD_STITCH_MACRO_PROC_PARAMS FK_XLD_ST_MP_PARAM_PROC_ID; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_STITCH_MACRO_PROC_PARAMS"
    ADD CONSTRAINT "FK_XLD_ST_MP_PARAM_PROC_ID" FOREIGN KEY ("PROCESSOR_ID") REFERENCES public."XLD_STITCH_MACRO_PROCESSORS"("PROCESSOR_ID");


--
-- Name: XLD_STITCH_DEFINITION FK_XLD_ST_MTDT_CONTENT_ID; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_STITCH_DEFINITION"
    ADD CONSTRAINT "FK_XLD_ST_MTDT_CONTENT_ID" FOREIGN KEY ("CONTENT_ID") REFERENCES public."XLD_STITCH_CONTENT"("ID");


--
-- Name: XLD_STITCH_DEFINITION FK_XLD_ST_MTDT_NAMESPACE_ID; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_STITCH_DEFINITION"
    ADD CONSTRAINT "FK_XLD_ST_MTDT_NAMESPACE_ID" FOREIGN KEY ("NAMESPACE_ID") REFERENCES public."XLD_STITCH_NAMESPACES"("ID");


--
-- Name: XLD_STITCH_PROCESSORS FK_XLD_ST_PROCESSOR_SOURCE_ID; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_STITCH_PROCESSORS"
    ADD CONSTRAINT "FK_XLD_ST_PROCESSOR_SOURCE_ID" FOREIGN KEY ("SOURCE_ID") REFERENCES public."XLD_CIS"("ID");


--
-- Name: XLD_STITCH_PROCESSOR_PARAMS FK_XLD_ST_PROC_PARAM_SOUR_ID; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_STITCH_PROCESSOR_PARAMS"
    ADD CONSTRAINT "FK_XLD_ST_PROC_PARAM_SOUR_ID" FOREIGN KEY ("SOURCE_ID") REFERENCES public."XLD_CIS"("ID");


--
-- Name: XLD_STITCH_RULE_CONDITIONS FK_XLD_ST_RULE_COND_RULE_ID; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_STITCH_RULE_CONDITIONS"
    ADD CONSTRAINT "FK_XLD_ST_RULE_COND_RULE_ID" FOREIGN KEY ("RULE_ID") REFERENCES public."XLD_STITCH_RULES"("ID");


--
-- Name: XLD_STITCH_RULE_CONDITIONS FK_XLD_ST_RULE_COND_SOURCE_ID; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_STITCH_RULE_CONDITIONS"
    ADD CONSTRAINT "FK_XLD_ST_RULE_COND_SOURCE_ID" FOREIGN KEY ("SOURCE_ID") REFERENCES public."XLD_CIS"("ID");


--
-- Name: XLD_STITCH_RULE_PROCESSORS FK_XLD_ST_RULE_PROC_RULE_ID; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_STITCH_RULE_PROCESSORS"
    ADD CONSTRAINT "FK_XLD_ST_RULE_PROC_RULE_ID" FOREIGN KEY ("RULE_ID") REFERENCES public."XLD_STITCH_RULES"("ID");


--
-- Name: XLD_STITCH_RULE_PROC_PARAMS FK_XLD_ST_RUPROCPA_PROCPARAID; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_STITCH_RULE_PROC_PARAMS"
    ADD CONSTRAINT "FK_XLD_ST_RUPROCPA_PROCPARAID" FOREIGN KEY ("PROCESSOR_PARAM_ID") REFERENCES public."XLD_STITCH_PROCESSOR_PARAMS"("ID");


--
-- Name: XLD_STITCH_RULE_PROC_PARAMS FK_XLD_ST_RUPROC_PARAPROCID; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_STITCH_RULE_PROC_PARAMS"
    ADD CONSTRAINT "FK_XLD_ST_RUPROC_PARAPROCID" FOREIGN KEY ("PROCESSOR_ID") REFERENCES public."XLD_STITCH_RULE_PROCESSORS"("PROCESSOR_ID");


--
-- Name: XLD_USER_CREDENTIALS FK_XLD_USER_CRED_USR_PROFILE; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_USER_CREDENTIALS"
    ADD CONSTRAINT "FK_XLD_USER_CRED_USR_PROFILE" FOREIGN KEY ("PROFILE_USERNAME") REFERENCES public."XLD_USER_PROFILES"("USERNAME") ON DELETE CASCADE;


--
-- Name: XLD_USER_DEFAULT_CREDENTIALS FK_XLD_USR_DEF_CRED_USR_PROF; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_USER_DEFAULT_CREDENTIALS"
    ADD CONSTRAINT "FK_XLD_USR_DEF_CRED_USR_PROF" FOREIGN KEY ("PROFILE_USERNAME") REFERENCES public."XLD_USER_PROFILES"("USERNAME") ON DELETE CASCADE;


--
-- Name: XLD_ACTIVE_TASKS FK_XLD_WORKERS_ID; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."XLD_ACTIVE_TASKS"
    ADD CONSTRAINT "FK_XLD_WORKERS_ID" FOREIGN KEY (worker_id) REFERENCES public."XLD_WORKERS"("ID");


--
-- Name: spring_session_attributes fk_xld_attribute_session_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.spring_session_attributes
    ADD CONSTRAINT fk_xld_attribute_session_id FOREIGN KEY (session_primary_id) REFERENCES public.spring_session(primary_id) ON DELETE CASCADE;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--


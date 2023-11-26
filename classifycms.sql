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
-- Name: address_masters; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.address_masters (
    id integer NOT NULL,
    code character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    type character varying(255),
    description character varying(255),
    parent_type character varying(255),
    parent_code character varying(255),
    is_active boolean
);


ALTER TABLE public.address_masters OWNER TO postgres;

--
-- Name: address_masters_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.address_masters_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.address_masters_id_seq OWNER TO postgres;

--
-- Name: address_masters_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.address_masters_id_seq OWNED BY public.address_masters.id;


--
-- Name: admin_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.admin_permissions (
    id integer NOT NULL,
    action character varying(255),
    subject character varying(255),
    properties jsonb,
    conditions jsonb,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer
);


ALTER TABLE public.admin_permissions OWNER TO postgres;

--
-- Name: admin_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.admin_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.admin_permissions_id_seq OWNER TO postgres;

--
-- Name: admin_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.admin_permissions_id_seq OWNED BY public.admin_permissions.id;


--
-- Name: admin_permissions_role_links; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.admin_permissions_role_links (
    id integer NOT NULL,
    permission_id integer,
    role_id integer,
    permission_order double precision
);


ALTER TABLE public.admin_permissions_role_links OWNER TO postgres;

--
-- Name: admin_permissions_role_links_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.admin_permissions_role_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.admin_permissions_role_links_id_seq OWNER TO postgres;

--
-- Name: admin_permissions_role_links_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.admin_permissions_role_links_id_seq OWNED BY public.admin_permissions_role_links.id;


--
-- Name: admin_roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.admin_roles (
    id integer NOT NULL,
    name character varying(255),
    code character varying(255),
    description character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer
);


ALTER TABLE public.admin_roles OWNER TO postgres;

--
-- Name: admin_roles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.admin_roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.admin_roles_id_seq OWNER TO postgres;

--
-- Name: admin_roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.admin_roles_id_seq OWNED BY public.admin_roles.id;


--
-- Name: admin_users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.admin_users (
    id integer NOT NULL,
    firstname character varying(255),
    lastname character varying(255),
    username character varying(255),
    email character varying(255),
    password character varying(255),
    reset_password_token character varying(255),
    registration_token character varying(255),
    is_active boolean,
    blocked boolean,
    prefered_language character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer
);


ALTER TABLE public.admin_users OWNER TO postgres;

--
-- Name: admin_users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.admin_users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.admin_users_id_seq OWNER TO postgres;

--
-- Name: admin_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.admin_users_id_seq OWNED BY public.admin_users.id;


--
-- Name: admin_users_roles_links; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.admin_users_roles_links (
    id integer NOT NULL,
    user_id integer,
    role_id integer,
    role_order double precision,
    user_order double precision
);


ALTER TABLE public.admin_users_roles_links OWNER TO postgres;

--
-- Name: admin_users_roles_links_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.admin_users_roles_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.admin_users_roles_links_id_seq OWNER TO postgres;

--
-- Name: admin_users_roles_links_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.admin_users_roles_links_id_seq OWNED BY public.admin_users_roles_links.id;


--
-- Name: category_infos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.category_infos (
    id integer NOT NULL,
    category character varying(255),
    code character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer
);


ALTER TABLE public.category_infos OWNER TO postgres;

--
-- Name: category_infos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.category_infos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.category_infos_id_seq OWNER TO postgres;

--
-- Name: category_infos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.category_infos_id_seq OWNED BY public.category_infos.id;


--
-- Name: country_masters; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.country_masters (
    id integer NOT NULL,
    code character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    description character varying(255),
    isd_code character varying(255),
    iso_code character varying(255),
    is_active boolean
);


ALTER TABLE public.country_masters OWNER TO postgres;

--
-- Name: country_masters_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.country_masters_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.country_masters_id_seq OWNER TO postgres;

--
-- Name: country_masters_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.country_masters_id_seq OWNED BY public.country_masters.id;


--
-- Name: files; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.files (
    id integer NOT NULL,
    name character varying(255),
    alternative_text character varying(255),
    caption character varying(255),
    width integer,
    height integer,
    formats jsonb,
    hash character varying(255),
    ext character varying(255),
    mime character varying(255),
    size numeric(10,2),
    url character varying(255),
    preview_url character varying(255),
    provider character varying(255),
    provider_metadata jsonb,
    folder_path character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer
);


ALTER TABLE public.files OWNER TO postgres;

--
-- Name: files_folder_links; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.files_folder_links (
    id integer NOT NULL,
    file_id integer,
    folder_id integer,
    file_order double precision
);


ALTER TABLE public.files_folder_links OWNER TO postgres;

--
-- Name: files_folder_links_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.files_folder_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.files_folder_links_id_seq OWNER TO postgres;

--
-- Name: files_folder_links_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.files_folder_links_id_seq OWNED BY public.files_folder_links.id;


--
-- Name: files_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.files_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.files_id_seq OWNER TO postgres;

--
-- Name: files_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.files_id_seq OWNED BY public.files.id;


--
-- Name: files_related_morphs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.files_related_morphs (
    id integer NOT NULL,
    file_id integer,
    related_id integer,
    related_type character varying(255),
    field character varying(255),
    "order" double precision
);


ALTER TABLE public.files_related_morphs OWNER TO postgres;

--
-- Name: files_related_morphs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.files_related_morphs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.files_related_morphs_id_seq OWNER TO postgres;

--
-- Name: files_related_morphs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.files_related_morphs_id_seq OWNED BY public.files_related_morphs.id;


--
-- Name: gen_ai_categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.gen_ai_categories (
    id integer NOT NULL,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    industry_name character varying(255),
    iconify_icon character varying(255)
);


ALTER TABLE public.gen_ai_categories OWNER TO postgres;

--
-- Name: gen_ai_categories_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.gen_ai_categories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.gen_ai_categories_id_seq OWNER TO postgres;

--
-- Name: gen_ai_categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.gen_ai_categories_id_seq OWNED BY public.gen_ai_categories.id;


--
-- Name: gen_ai_category_infos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.gen_ai_category_infos (
    id integer NOT NULL,
    title character varying(255),
    description text,
    external_link character varying(255),
    video_link character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    sub_title character varying(255),
    demo_link character varying(255),
    rank integer
);


ALTER TABLE public.gen_ai_category_infos OWNER TO postgres;

--
-- Name: gen_ai_category_infos_gen_ai_industry_links; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.gen_ai_category_infos_gen_ai_industry_links (
    id integer NOT NULL,
    gen_ai_category_info_id integer,
    gen_ai_category_id integer,
    gen_ai_category_info_order double precision
);


ALTER TABLE public.gen_ai_category_infos_gen_ai_industry_links OWNER TO postgres;

--
-- Name: gen_ai_category_infos_gen_ai_industry_links_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.gen_ai_category_infos_gen_ai_industry_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.gen_ai_category_infos_gen_ai_industry_links_id_seq OWNER TO postgres;

--
-- Name: gen_ai_category_infos_gen_ai_industry_links_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.gen_ai_category_infos_gen_ai_industry_links_id_seq OWNED BY public.gen_ai_category_infos_gen_ai_industry_links.id;


--
-- Name: gen_ai_category_infos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.gen_ai_category_infos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.gen_ai_category_infos_id_seq OWNER TO postgres;

--
-- Name: gen_ai_category_infos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.gen_ai_category_infos_id_seq OWNED BY public.gen_ai_category_infos.id;


--
-- Name: i18n_locale; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.i18n_locale (
    id integer NOT NULL,
    name character varying(255),
    code character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer
);


ALTER TABLE public.i18n_locale OWNER TO postgres;

--
-- Name: i18n_locale_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.i18n_locale_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.i18n_locale_id_seq OWNER TO postgres;

--
-- Name: i18n_locale_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.i18n_locale_id_seq OWNED BY public.i18n_locale.id;


--
-- Name: lookup_masters; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.lookup_masters (
    id integer NOT NULL,
    type character varying(255),
    code character varying(255),
    description character varying(255),
    is_active boolean,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer
);


ALTER TABLE public.lookup_masters OWNER TO postgres;

--
-- Name: lookup_masters_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.lookup_masters_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.lookup_masters_id_seq OWNER TO postgres;

--
-- Name: lookup_masters_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.lookup_masters_id_seq OWNED BY public.lookup_masters.id;


--
-- Name: rule_additional_fields_descriptions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rule_additional_fields_descriptions (
    id integer NOT NULL,
    key_name character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    value_sql character varying(255)
);


ALTER TABLE public.rule_additional_fields_descriptions OWNER TO postgres;

--
-- Name: rule_additional_fields_descriptions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rule_additional_fields_descriptions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rule_additional_fields_descriptions_id_seq OWNER TO postgres;

--
-- Name: rule_additional_fields_descriptions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.rule_additional_fields_descriptions_id_seq OWNED BY public.rule_additional_fields_descriptions.id;


--
-- Name: rule_creation_fields_descriptions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rule_creation_fields_descriptions (
    id integer NOT NULL,
    rule_name character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    start_date character varying(255),
    end_date character varying(255),
    rule_description character varying(255),
    action_code character varying(255),
    rule_category character varying(255),
    rule_type character varying(255),
    priority character varying(255),
    attachment_url character varying(255),
    screen_identifier character varying(255),
    output_mode character varying(255),
    voucher_code character varying(255),
    voucher_code_applicable character varying(255),
    channels character varying(255)
);


ALTER TABLE public.rule_creation_fields_descriptions OWNER TO postgres;

--
-- Name: rule_creation_fields_descriptions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rule_creation_fields_descriptions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rule_creation_fields_descriptions_id_seq OWNER TO postgres;

--
-- Name: rule_creation_fields_descriptions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.rule_creation_fields_descriptions_id_seq OWNED BY public.rule_creation_fields_descriptions.id;


--
-- Name: rule_execution_fields_descriptions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rule_execution_fields_descriptions (
    id integer NOT NULL,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    ksqldb_cluster character varying(255),
    stream_name character varying(255),
    input_key character varying(255),
    entity_id character varying(255),
    input_timestamp_sql character varying(255),
    input_timestamp_format character varying(255),
    input_timestamp_tz character varying(255),
    output_generation_type character varying(255),
    limit_interval character varying(255),
    limit_interval_logic_sql character varying(255),
    max_allowed_limit character varying(255),
    generate_false_output character varying(255),
    generate_same_ref_number character varying(255),
    input_load_type character varying(255),
    output_stream_name character varying(255),
    rule_condition_sql character varying(255),
    dynamic_text_sql character varying(255),
    expiry_date_sql character varying(255),
    calculation_logic_type character varying(255),
    max_calculated_value character varying(255),
    calculation_apply_field character varying(255)
);


ALTER TABLE public.rule_execution_fields_descriptions OWNER TO postgres;

--
-- Name: rule_execution_fields_descriptions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rule_execution_fields_descriptions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rule_execution_fields_descriptions_id_seq OWNER TO postgres;

--
-- Name: rule_execution_fields_descriptions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.rule_execution_fields_descriptions_id_seq OWNED BY public.rule_execution_fields_descriptions.id;


--
-- Name: strapi_api_token_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.strapi_api_token_permissions (
    id integer NOT NULL,
    action character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer
);


ALTER TABLE public.strapi_api_token_permissions OWNER TO postgres;

--
-- Name: strapi_api_token_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.strapi_api_token_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.strapi_api_token_permissions_id_seq OWNER TO postgres;

--
-- Name: strapi_api_token_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.strapi_api_token_permissions_id_seq OWNED BY public.strapi_api_token_permissions.id;


--
-- Name: strapi_api_token_permissions_token_links; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.strapi_api_token_permissions_token_links (
    id integer NOT NULL,
    api_token_permission_id integer,
    api_token_id integer,
    api_token_permission_order double precision
);


ALTER TABLE public.strapi_api_token_permissions_token_links OWNER TO postgres;

--
-- Name: strapi_api_token_permissions_token_links_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.strapi_api_token_permissions_token_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.strapi_api_token_permissions_token_links_id_seq OWNER TO postgres;

--
-- Name: strapi_api_token_permissions_token_links_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.strapi_api_token_permissions_token_links_id_seq OWNED BY public.strapi_api_token_permissions_token_links.id;


--
-- Name: strapi_api_tokens; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.strapi_api_tokens (
    id integer NOT NULL,
    name character varying(255),
    description character varying(255),
    type character varying(255),
    access_key character varying(255),
    last_used_at timestamp(6) without time zone,
    expires_at timestamp(6) without time zone,
    lifespan bigint,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer
);


ALTER TABLE public.strapi_api_tokens OWNER TO postgres;

--
-- Name: strapi_api_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.strapi_api_tokens_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.strapi_api_tokens_id_seq OWNER TO postgres;

--
-- Name: strapi_api_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.strapi_api_tokens_id_seq OWNED BY public.strapi_api_tokens.id;


--
-- Name: strapi_core_store_settings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.strapi_core_store_settings (
    id integer NOT NULL,
    key character varying(255),
    value text,
    type character varying(255),
    environment character varying(255),
    tag character varying(255)
);


ALTER TABLE public.strapi_core_store_settings OWNER TO postgres;

--
-- Name: strapi_core_store_settings_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.strapi_core_store_settings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.strapi_core_store_settings_id_seq OWNER TO postgres;

--
-- Name: strapi_core_store_settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.strapi_core_store_settings_id_seq OWNED BY public.strapi_core_store_settings.id;


--
-- Name: strapi_database_schema; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.strapi_database_schema (
    id integer NOT NULL,
    schema json,
    "time" timestamp without time zone,
    hash character varying(255)
);


ALTER TABLE public.strapi_database_schema OWNER TO postgres;

--
-- Name: strapi_database_schema_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.strapi_database_schema_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.strapi_database_schema_id_seq OWNER TO postgres;

--
-- Name: strapi_database_schema_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.strapi_database_schema_id_seq OWNED BY public.strapi_database_schema.id;


--
-- Name: strapi_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.strapi_migrations (
    id integer NOT NULL,
    name character varying(255),
    "time" timestamp without time zone
);


ALTER TABLE public.strapi_migrations OWNER TO postgres;

--
-- Name: strapi_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.strapi_migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.strapi_migrations_id_seq OWNER TO postgres;

--
-- Name: strapi_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.strapi_migrations_id_seq OWNED BY public.strapi_migrations.id;


--
-- Name: strapi_transfer_token_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.strapi_transfer_token_permissions (
    id integer NOT NULL,
    action character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer
);


ALTER TABLE public.strapi_transfer_token_permissions OWNER TO postgres;

--
-- Name: strapi_transfer_token_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.strapi_transfer_token_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.strapi_transfer_token_permissions_id_seq OWNER TO postgres;

--
-- Name: strapi_transfer_token_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.strapi_transfer_token_permissions_id_seq OWNED BY public.strapi_transfer_token_permissions.id;


--
-- Name: strapi_transfer_token_permissions_token_links; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.strapi_transfer_token_permissions_token_links (
    id integer NOT NULL,
    transfer_token_permission_id integer,
    transfer_token_id integer,
    transfer_token_permission_order double precision
);


ALTER TABLE public.strapi_transfer_token_permissions_token_links OWNER TO postgres;

--
-- Name: strapi_transfer_token_permissions_token_links_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.strapi_transfer_token_permissions_token_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.strapi_transfer_token_permissions_token_links_id_seq OWNER TO postgres;

--
-- Name: strapi_transfer_token_permissions_token_links_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.strapi_transfer_token_permissions_token_links_id_seq OWNED BY public.strapi_transfer_token_permissions_token_links.id;


--
-- Name: strapi_transfer_tokens; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.strapi_transfer_tokens (
    id integer NOT NULL,
    name character varying(255),
    description character varying(255),
    access_key character varying(255),
    last_used_at timestamp(6) without time zone,
    expires_at timestamp(6) without time zone,
    lifespan bigint,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer
);


ALTER TABLE public.strapi_transfer_tokens OWNER TO postgres;

--
-- Name: strapi_transfer_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.strapi_transfer_tokens_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.strapi_transfer_tokens_id_seq OWNER TO postgres;

--
-- Name: strapi_transfer_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.strapi_transfer_tokens_id_seq OWNED BY public.strapi_transfer_tokens.id;


--
-- Name: strapi_webhooks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.strapi_webhooks (
    id integer NOT NULL,
    name character varying(255),
    url text,
    headers jsonb,
    events jsonb,
    enabled boolean
);


ALTER TABLE public.strapi_webhooks OWNER TO postgres;

--
-- Name: strapi_webhooks_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.strapi_webhooks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.strapi_webhooks_id_seq OWNER TO postgres;

--
-- Name: strapi_webhooks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.strapi_webhooks_id_seq OWNED BY public.strapi_webhooks.id;


--
-- Name: up_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.up_permissions (
    id integer NOT NULL,
    action character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer
);


ALTER TABLE public.up_permissions OWNER TO postgres;

--
-- Name: up_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.up_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.up_permissions_id_seq OWNER TO postgres;

--
-- Name: up_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.up_permissions_id_seq OWNED BY public.up_permissions.id;


--
-- Name: up_permissions_role_links; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.up_permissions_role_links (
    id integer NOT NULL,
    permission_id integer,
    role_id integer,
    permission_order double precision
);


ALTER TABLE public.up_permissions_role_links OWNER TO postgres;

--
-- Name: up_permissions_role_links_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.up_permissions_role_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.up_permissions_role_links_id_seq OWNER TO postgres;

--
-- Name: up_permissions_role_links_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.up_permissions_role_links_id_seq OWNED BY public.up_permissions_role_links.id;


--
-- Name: up_roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.up_roles (
    id integer NOT NULL,
    name character varying(255),
    description character varying(255),
    type character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer
);


ALTER TABLE public.up_roles OWNER TO postgres;

--
-- Name: up_roles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.up_roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.up_roles_id_seq OWNER TO postgres;

--
-- Name: up_roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.up_roles_id_seq OWNED BY public.up_roles.id;


--
-- Name: up_users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.up_users (
    id integer NOT NULL,
    username character varying(255),
    email character varying(255),
    provider character varying(255),
    password character varying(255),
    reset_password_token character varying(255),
    confirmation_token character varying(255),
    confirmed boolean,
    blocked boolean,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer
);


ALTER TABLE public.up_users OWNER TO postgres;

--
-- Name: up_users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.up_users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.up_users_id_seq OWNER TO postgres;

--
-- Name: up_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.up_users_id_seq OWNED BY public.up_users.id;


--
-- Name: up_users_role_links; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.up_users_role_links (
    id integer NOT NULL,
    user_id integer,
    role_id integer,
    user_order double precision
);


ALTER TABLE public.up_users_role_links OWNER TO postgres;

--
-- Name: up_users_role_links_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.up_users_role_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.up_users_role_links_id_seq OWNER TO postgres;

--
-- Name: up_users_role_links_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.up_users_role_links_id_seq OWNED BY public.up_users_role_links.id;


--
-- Name: upload_folders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.upload_folders (
    id integer NOT NULL,
    name character varying(255),
    path_id integer,
    path character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer
);


ALTER TABLE public.upload_folders OWNER TO postgres;

--
-- Name: upload_folders_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.upload_folders_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.upload_folders_id_seq OWNER TO postgres;

--
-- Name: upload_folders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.upload_folders_id_seq OWNED BY public.upload_folders.id;


--
-- Name: upload_folders_parent_links; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.upload_folders_parent_links (
    id integer NOT NULL,
    folder_id integer,
    inv_folder_id integer,
    folder_order double precision
);


ALTER TABLE public.upload_folders_parent_links OWNER TO postgres;

--
-- Name: upload_folders_parent_links_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.upload_folders_parent_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.upload_folders_parent_links_id_seq OWNER TO postgres;

--
-- Name: upload_folders_parent_links_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.upload_folders_parent_links_id_seq OWNED BY public.upload_folders_parent_links.id;


--
-- Name: address_masters id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.address_masters ALTER COLUMN id SET DEFAULT nextval('public.address_masters_id_seq'::regclass);


--
-- Name: admin_permissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin_permissions ALTER COLUMN id SET DEFAULT nextval('public.admin_permissions_id_seq'::regclass);


--
-- Name: admin_permissions_role_links id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin_permissions_role_links ALTER COLUMN id SET DEFAULT nextval('public.admin_permissions_role_links_id_seq'::regclass);


--
-- Name: admin_roles id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin_roles ALTER COLUMN id SET DEFAULT nextval('public.admin_roles_id_seq'::regclass);


--
-- Name: admin_users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin_users ALTER COLUMN id SET DEFAULT nextval('public.admin_users_id_seq'::regclass);


--
-- Name: admin_users_roles_links id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin_users_roles_links ALTER COLUMN id SET DEFAULT nextval('public.admin_users_roles_links_id_seq'::regclass);


--
-- Name: category_infos id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.category_infos ALTER COLUMN id SET DEFAULT nextval('public.category_infos_id_seq'::regclass);


--
-- Name: country_masters id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.country_masters ALTER COLUMN id SET DEFAULT nextval('public.country_masters_id_seq'::regclass);


--
-- Name: files id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.files ALTER COLUMN id SET DEFAULT nextval('public.files_id_seq'::regclass);


--
-- Name: files_folder_links id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.files_folder_links ALTER COLUMN id SET DEFAULT nextval('public.files_folder_links_id_seq'::regclass);


--
-- Name: files_related_morphs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.files_related_morphs ALTER COLUMN id SET DEFAULT nextval('public.files_related_morphs_id_seq'::regclass);


--
-- Name: gen_ai_categories id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gen_ai_categories ALTER COLUMN id SET DEFAULT nextval('public.gen_ai_categories_id_seq'::regclass);


--
-- Name: gen_ai_category_infos id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gen_ai_category_infos ALTER COLUMN id SET DEFAULT nextval('public.gen_ai_category_infos_id_seq'::regclass);


--
-- Name: gen_ai_category_infos_gen_ai_industry_links id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gen_ai_category_infos_gen_ai_industry_links ALTER COLUMN id SET DEFAULT nextval('public.gen_ai_category_infos_gen_ai_industry_links_id_seq'::regclass);


--
-- Name: i18n_locale id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.i18n_locale ALTER COLUMN id SET DEFAULT nextval('public.i18n_locale_id_seq'::regclass);


--
-- Name: lookup_masters id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lookup_masters ALTER COLUMN id SET DEFAULT nextval('public.lookup_masters_id_seq'::regclass);


--
-- Name: rule_additional_fields_descriptions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rule_additional_fields_descriptions ALTER COLUMN id SET DEFAULT nextval('public.rule_additional_fields_descriptions_id_seq'::regclass);


--
-- Name: rule_creation_fields_descriptions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rule_creation_fields_descriptions ALTER COLUMN id SET DEFAULT nextval('public.rule_creation_fields_descriptions_id_seq'::regclass);


--
-- Name: rule_execution_fields_descriptions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rule_execution_fields_descriptions ALTER COLUMN id SET DEFAULT nextval('public.rule_execution_fields_descriptions_id_seq'::regclass);


--
-- Name: strapi_api_token_permissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.strapi_api_token_permissions ALTER COLUMN id SET DEFAULT nextval('public.strapi_api_token_permissions_id_seq'::regclass);


--
-- Name: strapi_api_token_permissions_token_links id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.strapi_api_token_permissions_token_links ALTER COLUMN id SET DEFAULT nextval('public.strapi_api_token_permissions_token_links_id_seq'::regclass);


--
-- Name: strapi_api_tokens id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.strapi_api_tokens ALTER COLUMN id SET DEFAULT nextval('public.strapi_api_tokens_id_seq'::regclass);


--
-- Name: strapi_core_store_settings id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.strapi_core_store_settings ALTER COLUMN id SET DEFAULT nextval('public.strapi_core_store_settings_id_seq'::regclass);


--
-- Name: strapi_database_schema id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.strapi_database_schema ALTER COLUMN id SET DEFAULT nextval('public.strapi_database_schema_id_seq'::regclass);


--
-- Name: strapi_migrations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.strapi_migrations ALTER COLUMN id SET DEFAULT nextval('public.strapi_migrations_id_seq'::regclass);


--
-- Name: strapi_transfer_token_permissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.strapi_transfer_token_permissions ALTER COLUMN id SET DEFAULT nextval('public.strapi_transfer_token_permissions_id_seq'::regclass);


--
-- Name: strapi_transfer_token_permissions_token_links id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.strapi_transfer_token_permissions_token_links ALTER COLUMN id SET DEFAULT nextval('public.strapi_transfer_token_permissions_token_links_id_seq'::regclass);


--
-- Name: strapi_transfer_tokens id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.strapi_transfer_tokens ALTER COLUMN id SET DEFAULT nextval('public.strapi_transfer_tokens_id_seq'::regclass);


--
-- Name: strapi_webhooks id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.strapi_webhooks ALTER COLUMN id SET DEFAULT nextval('public.strapi_webhooks_id_seq'::regclass);


--
-- Name: up_permissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.up_permissions ALTER COLUMN id SET DEFAULT nextval('public.up_permissions_id_seq'::regclass);


--
-- Name: up_permissions_role_links id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.up_permissions_role_links ALTER COLUMN id SET DEFAULT nextval('public.up_permissions_role_links_id_seq'::regclass);


--
-- Name: up_roles id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.up_roles ALTER COLUMN id SET DEFAULT nextval('public.up_roles_id_seq'::regclass);


--
-- Name: up_users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.up_users ALTER COLUMN id SET DEFAULT nextval('public.up_users_id_seq'::regclass);


--
-- Name: up_users_role_links id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.up_users_role_links ALTER COLUMN id SET DEFAULT nextval('public.up_users_role_links_id_seq'::regclass);


--
-- Name: upload_folders id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.upload_folders ALTER COLUMN id SET DEFAULT nextval('public.upload_folders_id_seq'::regclass);


--
-- Name: upload_folders_parent_links id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.upload_folders_parent_links ALTER COLUMN id SET DEFAULT nextval('public.upload_folders_parent_links_id_seq'::regclass);


--
-- Data for Name: address_masters; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.address_masters (id, code, created_at, updated_at, published_at, created_by_id, updated_by_id, type, description, parent_type, parent_code, is_active) FROM stdin;
2	02	2023-06-22 16:17:03.362	2023-06-22 16:17:03.362	\N	9	9	CITY	Hanoi	COUNTRY	01	t
3	03	2023-06-22 16:17:53.406	2023-06-22 16:17:53.406	\N	9	9	CITY	Singapore	COUNTRY	02	t
1	01	2023-06-22 16:13:43.924	2023-06-23 06:35:15.14	\N	9	9	CITY	Hồ Chí Min	COUNTRY	01	t
\.


--
-- Data for Name: admin_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.admin_permissions (id, action, subject, properties, conditions, created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
366	plugin::content-manager.explorer.delete	api::rule-execution-fields-description.rule-execution-fields-description	{}	[]	2023-06-06 12:54:40.224	2023-06-06 12:54:40.224	\N	\N
367	plugin::content-manager.explorer.publish	api::rule-execution-fields-description.rule-execution-fields-description	{}	[]	2023-06-06 12:54:40.231	2023-06-06 12:54:40.231	\N	\N
382	plugin::content-manager.explorer.create	api::rule-execution-fields-description.rule-execution-fields-description	{"fields": ["ksqldbCluster", "streamName", "inputKey", "entityId", "inputTimestampSql", "inputTimestampFormat", "inputTimestampTz", "outputGenerationType", "limitInterval", "limitIntervalLogicSql", "maxAllowedLimit", "generateFalseOutput", "generateSameRefNumber", "inputLoadType", "outputStreamName", "ruleConditionSql", "dynamicTextSql", "expiryDateSql", "calculationLogicType", "calculationApplyField", "maxCalculatedValue"]}	[]	2023-06-15 13:15:18.607	2023-06-15 13:15:18.607	\N	\N
383	plugin::content-manager.explorer.read	api::rule-execution-fields-description.rule-execution-fields-description	{"fields": ["ksqldbCluster", "streamName", "inputKey", "entityId", "inputTimestampSql", "inputTimestampFormat", "inputTimestampTz", "outputGenerationType", "limitInterval", "limitIntervalLogicSql", "maxAllowedLimit", "generateFalseOutput", "generateSameRefNumber", "inputLoadType", "outputStreamName", "ruleConditionSql", "dynamicTextSql", "expiryDateSql", "calculationLogicType", "calculationApplyField", "maxCalculatedValue"]}	[]	2023-06-15 13:15:18.626	2023-06-15 13:15:18.626	\N	\N
384	plugin::content-manager.explorer.update	api::rule-execution-fields-description.rule-execution-fields-description	{"fields": ["ksqldbCluster", "streamName", "inputKey", "entityId", "inputTimestampSql", "inputTimestampFormat", "inputTimestampTz", "outputGenerationType", "limitInterval", "limitIntervalLogicSql", "maxAllowedLimit", "generateFalseOutput", "generateSameRefNumber", "inputLoadType", "outputStreamName", "ruleConditionSql", "dynamicTextSql", "expiryDateSql", "calculationLogicType", "calculationApplyField", "maxCalculatedValue"]}	[]	2023-06-15 13:15:18.644	2023-06-15 13:15:18.644	\N	\N
385	plugin::content-manager.explorer.create	api::lookup-master.lookup-master	{"fields": ["type", "code", "description", "is_active"]}	[]	2023-06-22 04:46:49.752	2023-06-22 04:46:49.752	\N	\N
386	plugin::content-manager.explorer.read	api::lookup-master.lookup-master	{"fields": ["type", "code", "description", "is_active"]}	[]	2023-06-22 04:46:49.797	2023-06-22 04:46:49.797	\N	\N
387	plugin::content-manager.explorer.update	api::lookup-master.lookup-master	{"fields": ["type", "code", "description", "is_active"]}	[]	2023-06-22 04:46:49.809	2023-06-22 04:46:49.809	\N	\N
388	plugin::content-manager.explorer.delete	api::lookup-master.lookup-master	{}	[]	2023-06-22 04:46:49.818	2023-06-22 04:46:49.818	\N	\N
389	plugin::content-manager.explorer.publish	api::lookup-master.lookup-master	{}	[]	2023-06-22 04:46:49.832	2023-06-22 04:46:49.832	\N	\N
390	plugin::content-manager.explorer.read	api::rule-additional-fields-description.rule-additional-fields-description	{"fields": ["keyName", "valueSql"]}	[]	2023-06-22 11:29:42.928	2023-06-22 11:29:42.928	\N	\N
391	plugin::content-manager.explorer.read	api::rule-creation-fields-description.rule-creation-fields-description	{"fields": ["ruleName", "startDate", "endDate", "ruleDescription", "actionCode", "ruleCategory", "ruleType", "priority", "attachmentUrl", "screenIdentifier", "outputMode", "voucherCode", "voucherCodeApplicable", "channels"]}	[]	2023-06-22 11:29:42.948	2023-06-22 11:29:42.948	\N	\N
21	plugin::upload.read	\N	{}	[]	2023-05-08 06:39:53.341	2023-05-08 06:39:53.341	\N	\N
22	plugin::upload.configure-view	\N	{}	[]	2023-05-08 06:39:53.35	2023-05-08 06:39:53.35	\N	\N
23	plugin::upload.assets.create	\N	{}	[]	2023-05-08 06:39:53.357	2023-05-08 06:39:53.357	\N	\N
24	plugin::upload.assets.update	\N	{}	[]	2023-05-08 06:39:53.364	2023-05-08 06:39:53.364	\N	\N
25	plugin::upload.assets.download	\N	{}	[]	2023-05-08 06:39:53.376	2023-05-08 06:39:53.376	\N	\N
26	plugin::upload.assets.copy-link	\N	{}	[]	2023-05-08 06:39:53.385	2023-05-08 06:39:53.385	\N	\N
392	plugin::content-manager.explorer.read	api::rule-execution-fields-description.rule-execution-fields-description	{"fields": ["ksqldbCluster", "streamName", "inputKey", "entityId", "inputTimestampSql", "inputTimestampFormat", "inputTimestampTz", "outputGenerationType", "limitInterval", "limitIntervalLogicSql", "maxAllowedLimit", "generateFalseOutput", "generateSameRefNumber", "inputLoadType", "outputStreamName", "ruleConditionSql", "dynamicTextSql", "expiryDateSql", "calculationLogicType", "calculationApplyField", "maxCalculatedValue"]}	[]	2023-06-22 11:29:42.956	2023-06-22 11:29:42.956	\N	\N
393	plugin::content-manager.explorer.read	api::category-info.category-info	{"fields": ["Category", "Code"]}	[]	2023-06-22 11:30:25.939	2023-06-22 11:30:25.939	\N	\N
394	plugin::content-manager.explorer.read	api::lookup-master.lookup-master	{"fields": ["type", "code", "description", "is_active"]}	[]	2023-06-22 11:30:25.948	2023-06-22 11:30:25.948	\N	\N
415	plugin::content-manager.explorer.create	api::country-master.country-master	{"fields": ["code", "description", "isd_code", "iso_code", "is_active"]}	[]	2023-06-22 16:07:00.305	2023-06-22 16:07:00.305	\N	\N
416	plugin::content-manager.explorer.read	api::country-master.country-master	{"fields": ["code", "description", "isd_code", "iso_code", "is_active"]}	[]	2023-06-22 16:07:00.314	2023-06-22 16:07:00.314	\N	\N
417	plugin::content-manager.explorer.update	api::country-master.country-master	{"fields": ["code", "description", "isd_code", "iso_code", "is_active"]}	[]	2023-06-22 16:07:00.32	2023-06-22 16:07:00.32	\N	\N
421	plugin::content-manager.explorer.publish	api::address-master.address-master	{}	[]	2023-06-23 06:34:32.799	2023-06-23 06:34:32.799	\N	\N
422	plugin::content-manager.explorer.publish	api::category-info.category-info	{}	[]	2023-06-23 06:34:32.816	2023-06-23 06:34:32.816	\N	\N
423	plugin::content-manager.explorer.publish	api::country-master.country-master	{}	[]	2023-06-23 06:34:32.885	2023-06-23 06:34:32.885	\N	\N
424	plugin::content-manager.explorer.publish	api::lookup-master.lookup-master	{}	[]	2023-06-23 06:34:32.893	2023-06-23 06:34:32.893	\N	\N
504	plugin::upload.read	\N	{}	[]	2023-09-13 05:31:25.784	2023-09-13 05:31:25.784	\N	\N
505	plugin::upload.assets.create	\N	{}	[]	2023-09-13 05:31:25.798	2023-09-13 05:31:25.798	\N	\N
506	plugin::upload.assets.update	\N	{}	[]	2023-09-13 05:31:25.821	2023-09-13 05:31:25.821	\N	\N
507	plugin::upload.assets.download	\N	{}	[]	2023-09-13 05:31:25.83	2023-09-13 05:31:25.83	\N	\N
43	plugin::upload.read	\N	{}	["admin::is-creator"]	2023-05-08 06:39:53.513	2023-05-08 06:39:53.513	\N	\N
44	plugin::upload.configure-view	\N	{}	[]	2023-05-08 06:39:53.535	2023-05-08 06:39:53.535	\N	\N
45	plugin::upload.assets.create	\N	{}	[]	2023-05-08 06:39:53.543	2023-05-08 06:39:53.543	\N	\N
46	plugin::upload.assets.update	\N	{}	["admin::is-creator"]	2023-05-08 06:39:53.55	2023-05-08 06:39:53.55	\N	\N
47	plugin::upload.assets.download	\N	{}	[]	2023-05-08 06:39:53.558	2023-05-08 06:39:53.558	\N	\N
48	plugin::upload.assets.copy-link	\N	{}	[]	2023-05-08 06:39:53.566	2023-05-08 06:39:53.566	\N	\N
109	admin::roles.read	\N	{}	[]	2023-05-08 06:39:54.222	2023-05-08 06:39:54.222	\N	\N
110	admin::roles.update	\N	{}	[]	2023-05-08 06:39:54.229	2023-05-08 06:39:54.229	\N	\N
508	plugin::upload.assets.copy-link	\N	{}	[]	2023-09-13 05:31:25.839	2023-09-13 05:31:25.839	\N	\N
509	plugin::upload.settings.read	\N	{}	[]	2023-09-13 05:31:25.848	2023-09-13 05:31:25.848	\N	\N
49	plugin::content-manager.explorer.create	plugin::users-permissions.user	{"fields": ["username", "email", "provider", "password", "resetPasswordToken", "confirmationToken", "confirmed", "blocked", "role"]}	[]	2023-05-08 06:39:53.668	2023-05-08 06:39:53.668	\N	\N
348	plugin::content-manager.explorer.create	api::category-info.category-info	{"fields": ["Category", "Code"]}	[]	2023-06-06 11:44:33.595	2023-06-06 11:44:33.595	\N	\N
349	plugin::content-manager.explorer.read	api::category-info.category-info	{"fields": ["Category", "Code"]}	[]	2023-06-06 11:44:33.603	2023-06-06 11:44:33.603	\N	\N
350	plugin::content-manager.explorer.update	api::category-info.category-info	{"fields": ["Category", "Code"]}	[]	2023-06-06 11:44:33.609	2023-06-06 11:44:33.609	\N	\N
351	plugin::content-manager.explorer.delete	api::category-info.category-info	{}	[]	2023-06-06 11:44:33.616	2023-06-06 11:44:33.616	\N	\N
54	plugin::content-manager.explorer.read	plugin::users-permissions.user	{"fields": ["username", "email", "provider", "password", "resetPasswordToken", "confirmationToken", "confirmed", "blocked", "role"]}	[]	2023-05-08 06:39:53.707	2023-05-08 06:39:53.707	\N	\N
352	plugin::content-manager.explorer.publish	api::category-info.category-info	{}	[]	2023-06-06 11:44:33.63	2023-06-06 11:44:33.63	\N	\N
59	plugin::content-manager.explorer.update	plugin::users-permissions.user	{"fields": ["username", "email", "provider", "password", "resetPasswordToken", "confirmationToken", "confirmed", "blocked", "role"]}	[]	2023-05-08 06:39:53.739	2023-05-08 06:39:53.739	\N	\N
371	plugin::content-manager.explorer.delete	api::rule-additional-fields-description.rule-additional-fields-description	{}	[]	2023-06-06 12:55:11.354	2023-06-06 12:55:11.354	\N	\N
372	plugin::content-manager.explorer.publish	api::rule-additional-fields-description.rule-additional-fields-description	{}	[]	2023-06-06 12:55:11.384	2023-06-06 12:55:11.384	\N	\N
395	plugin::content-manager.explorer.create	api::category-info.category-info	{"fields": ["Category", "Code"]}	[]	2023-06-22 11:31:19.726	2023-06-22 11:31:19.726	\N	\N
396	plugin::content-manager.explorer.update	api::category-info.category-info	{"fields": ["Category", "Code"]}	[]	2023-06-22 11:31:19.735	2023-06-22 11:31:19.735	\N	\N
64	plugin::content-manager.explorer.delete	plugin::users-permissions.user	{}	[]	2023-05-08 06:39:53.781	2023-05-08 06:39:53.781	\N	\N
397	plugin::content-manager.explorer.create	api::lookup-master.lookup-master	{"fields": ["type", "code", "description", "is_active"]}	[]	2023-06-22 11:31:19.743	2023-06-22 11:31:19.743	\N	\N
398	plugin::content-manager.explorer.update	api::lookup-master.lookup-master	{"fields": ["type", "code", "description", "is_active"]}	[]	2023-06-22 11:31:19.749	2023-06-22 11:31:19.749	\N	\N
418	plugin::content-manager.explorer.create	api::address-master.address-master	{"fields": ["code", "type", "description", "parent_type", "parent_code", "is_active"]}	[]	2023-06-22 16:09:01.893	2023-06-22 16:09:01.893	\N	\N
419	plugin::content-manager.explorer.read	api::address-master.address-master	{"fields": ["code", "type", "description", "parent_type", "parent_code", "is_active"]}	[]	2023-06-22 16:09:01.903	2023-06-22 16:09:01.903	\N	\N
420	plugin::content-manager.explorer.update	api::address-master.address-master	{"fields": ["code", "type", "description", "parent_type", "parent_code", "is_active"]}	[]	2023-06-22 16:09:01.911	2023-06-22 16:09:01.911	\N	\N
425	plugin::content-manager.explorer.delete	api::address-master.address-master	{}	[]	2023-06-23 06:35:59.208	2023-06-23 06:35:59.208	\N	\N
426	plugin::content-manager.explorer.delete	api::category-info.category-info	{}	[]	2023-06-23 06:35:59.218	2023-06-23 06:35:59.218	\N	\N
427	plugin::content-manager.explorer.delete	api::country-master.country-master	{}	[]	2023-06-23 06:35:59.229	2023-06-23 06:35:59.229	\N	\N
73	plugin::content-manager.single-types.configure-view	\N	{}	[]	2023-05-08 06:39:53.852	2023-05-08 06:39:53.852	\N	\N
74	plugin::content-manager.collection-types.configure-view	\N	{}	[]	2023-05-08 06:39:53.859	2023-05-08 06:39:53.859	\N	\N
75	plugin::content-manager.components.configure-layout	\N	{}	[]	2023-05-08 06:39:53.867	2023-05-08 06:39:53.867	\N	\N
76	plugin::content-type-builder.read	\N	{}	[]	2023-05-08 06:39:53.876	2023-05-08 06:39:53.876	\N	\N
77	plugin::email.settings.read	\N	{}	[]	2023-05-08 06:39:53.882	2023-05-08 06:39:53.882	\N	\N
78	plugin::upload.read	\N	{}	[]	2023-05-08 06:39:53.889	2023-05-08 06:39:53.889	\N	\N
79	plugin::upload.assets.create	\N	{}	[]	2023-05-08 06:39:53.897	2023-05-08 06:39:53.897	\N	\N
80	plugin::upload.assets.update	\N	{}	[]	2023-05-08 06:39:53.903	2023-05-08 06:39:53.903	\N	\N
81	plugin::upload.assets.download	\N	{}	[]	2023-05-08 06:39:53.908	2023-05-08 06:39:53.908	\N	\N
82	plugin::upload.assets.copy-link	\N	{}	[]	2023-05-08 06:39:53.914	2023-05-08 06:39:53.914	\N	\N
83	plugin::upload.configure-view	\N	{}	[]	2023-05-08 06:39:53.951	2023-05-08 06:39:53.951	\N	\N
84	plugin::upload.settings.read	\N	{}	[]	2023-05-08 06:39:53.961	2023-05-08 06:39:53.961	\N	\N
85	plugin::i18n.locale.create	\N	{}	[]	2023-05-08 06:39:53.974	2023-05-08 06:39:53.974	\N	\N
86	plugin::i18n.locale.read	\N	{}	[]	2023-05-08 06:39:53.988	2023-05-08 06:39:53.988	\N	\N
87	plugin::i18n.locale.update	\N	{}	[]	2023-05-08 06:39:53.996	2023-05-08 06:39:53.996	\N	\N
88	plugin::i18n.locale.delete	\N	{}	[]	2023-05-08 06:39:54.004	2023-05-08 06:39:54.004	\N	\N
89	plugin::users-permissions.roles.create	\N	{}	[]	2023-05-08 06:39:54.037	2023-05-08 06:39:54.037	\N	\N
90	plugin::users-permissions.roles.read	\N	{}	[]	2023-05-08 06:39:54.046	2023-05-08 06:39:54.046	\N	\N
91	plugin::users-permissions.roles.update	\N	{}	[]	2023-05-08 06:39:54.056	2023-05-08 06:39:54.056	\N	\N
92	plugin::users-permissions.roles.delete	\N	{}	[]	2023-05-08 06:39:54.064	2023-05-08 06:39:54.064	\N	\N
93	plugin::users-permissions.providers.read	\N	{}	[]	2023-05-08 06:39:54.079	2023-05-08 06:39:54.079	\N	\N
94	plugin::users-permissions.providers.update	\N	{}	[]	2023-05-08 06:39:54.091	2023-05-08 06:39:54.091	\N	\N
95	plugin::users-permissions.email-templates.read	\N	{}	[]	2023-05-08 06:39:54.103	2023-05-08 06:39:54.103	\N	\N
96	plugin::users-permissions.email-templates.update	\N	{}	[]	2023-05-08 06:39:54.133	2023-05-08 06:39:54.133	\N	\N
97	plugin::users-permissions.advanced-settings.read	\N	{}	[]	2023-05-08 06:39:54.14	2023-05-08 06:39:54.14	\N	\N
98	plugin::users-permissions.advanced-settings.update	\N	{}	[]	2023-05-08 06:39:54.152	2023-05-08 06:39:54.152	\N	\N
99	admin::marketplace.read	\N	{}	[]	2023-05-08 06:39:54.159	2023-05-08 06:39:54.159	\N	\N
100	admin::webhooks.create	\N	{}	[]	2023-05-08 06:39:54.168	2023-05-08 06:39:54.168	\N	\N
101	admin::webhooks.read	\N	{}	[]	2023-05-08 06:39:54.175	2023-05-08 06:39:54.175	\N	\N
102	admin::webhooks.update	\N	{}	[]	2023-05-08 06:39:54.181	2023-05-08 06:39:54.181	\N	\N
103	admin::webhooks.delete	\N	{}	[]	2023-05-08 06:39:54.187	2023-05-08 06:39:54.187	\N	\N
104	admin::users.create	\N	{}	[]	2023-05-08 06:39:54.192	2023-05-08 06:39:54.192	\N	\N
105	admin::users.read	\N	{}	[]	2023-05-08 06:39:54.198	2023-05-08 06:39:54.198	\N	\N
106	admin::users.update	\N	{}	[]	2023-05-08 06:39:54.204	2023-05-08 06:39:54.204	\N	\N
107	admin::users.delete	\N	{}	[]	2023-05-08 06:39:54.209	2023-05-08 06:39:54.209	\N	\N
108	admin::roles.create	\N	{}	[]	2023-05-08 06:39:54.216	2023-05-08 06:39:54.216	\N	\N
428	plugin::content-manager.explorer.delete	api::lookup-master.lookup-master	{}	[]	2023-06-23 06:35:59.236	2023-06-23 06:35:59.236	\N	\N
111	admin::roles.delete	\N	{}	[]	2023-05-08 06:39:54.237	2023-05-08 06:39:54.237	\N	\N
112	admin::api-tokens.access	\N	{}	[]	2023-05-08 06:39:54.245	2023-05-08 06:39:54.245	\N	\N
113	admin::api-tokens.create	\N	{}	[]	2023-05-08 06:39:54.251	2023-05-08 06:39:54.251	\N	\N
114	admin::api-tokens.read	\N	{}	[]	2023-05-08 06:39:54.259	2023-05-08 06:39:54.259	\N	\N
115	admin::api-tokens.update	\N	{}	[]	2023-05-08 06:39:54.266	2023-05-08 06:39:54.266	\N	\N
116	admin::api-tokens.regenerate	\N	{}	[]	2023-05-08 06:39:54.273	2023-05-08 06:39:54.273	\N	\N
117	admin::api-tokens.delete	\N	{}	[]	2023-05-08 06:39:54.279	2023-05-08 06:39:54.279	\N	\N
118	admin::project-settings.update	\N	{}	[]	2023-05-08 06:39:54.285	2023-05-08 06:39:54.285	\N	\N
119	admin::project-settings.read	\N	{}	[]	2023-05-08 06:39:54.291	2023-05-08 06:39:54.291	\N	\N
120	admin::transfer.tokens.access	\N	{}	[]	2023-05-08 06:39:54.297	2023-05-08 06:39:54.297	\N	\N
121	admin::transfer.tokens.create	\N	{}	[]	2023-05-08 06:39:54.311	2023-05-08 06:39:54.311	\N	\N
122	admin::transfer.tokens.read	\N	{}	[]	2023-05-08 06:39:54.32	2023-05-08 06:39:54.32	\N	\N
123	admin::transfer.tokens.update	\N	{}	[]	2023-05-08 06:39:54.327	2023-05-08 06:39:54.327	\N	\N
124	admin::transfer.tokens.regenerate	\N	{}	[]	2023-05-08 06:39:54.334	2023-05-08 06:39:54.334	\N	\N
125	admin::transfer.tokens.delete	\N	{}	[]	2023-05-08 06:39:54.344	2023-05-08 06:39:54.344	\N	\N
356	plugin::content-manager.explorer.delete	api::rule-creation-fields-description.rule-creation-fields-description	{}	[]	2023-06-06 11:56:41.248	2023-06-06 11:56:41.248	\N	\N
357	plugin::content-manager.explorer.publish	api::rule-creation-fields-description.rule-creation-fields-description	{}	[]	2023-06-06 11:56:41.287	2023-06-06 11:56:41.287	\N	\N
373	plugin::content-manager.explorer.create	api::rule-creation-fields-description.rule-creation-fields-description	{"fields": ["ruleName", "startDate", "endDate", "ruleDescription", "actionCode", "ruleCategory", "ruleType", "priority", "attachmentUrl", "screenIdentifier", "outputMode", "voucherCode", "voucherCodeApplicable", "channels"]}	[]	2023-06-06 12:58:28.152	2023-06-06 12:58:28.152	\N	\N
374	plugin::content-manager.explorer.read	api::rule-creation-fields-description.rule-creation-fields-description	{"fields": ["ruleName", "startDate", "endDate", "ruleDescription", "actionCode", "ruleCategory", "ruleType", "priority", "attachmentUrl", "screenIdentifier", "outputMode", "voucherCode", "voucherCodeApplicable", "channels"]}	[]	2023-06-06 12:58:28.169	2023-06-06 12:58:28.169	\N	\N
375	plugin::content-manager.explorer.update	api::rule-creation-fields-description.rule-creation-fields-description	{"fields": ["ruleName", "startDate", "endDate", "ruleDescription", "actionCode", "ruleCategory", "ruleType", "priority", "attachmentUrl", "screenIdentifier", "outputMode", "voucherCode", "voucherCodeApplicable", "channels"]}	[]	2023-06-06 12:58:28.183	2023-06-06 12:58:28.183	\N	\N
402	plugin::content-manager.explorer.delete	api::address-master.address-master	{}	[]	2023-06-22 11:32:48.736	2023-06-22 11:32:48.736	\N	\N
403	plugin::content-manager.explorer.publish	api::address-master.address-master	{}	[]	2023-06-22 11:32:48.755	2023-06-22 11:32:48.755	\N	\N
432	plugin::content-manager.explorer.delete	api::gen-ai-category-info.gen-ai-category-info	{}	[]	2023-08-09 04:36:52.202	2023-08-09 04:36:52.202	\N	\N
433	plugin::content-manager.explorer.publish	api::gen-ai-category-info.gen-ai-category-info	{}	[]	2023-08-09 04:36:52.21	2023-08-09 04:36:52.21	\N	\N
469	plugin::content-manager.explorer.create	api::gen-ai-category.gen-ai-category	{"fields": ["industryName", "iconifyIcon", "gen_ai_industry_cards"]}	[]	2023-08-11 12:59:05.472	2023-08-11 12:59:05.472	\N	\N
470	plugin::content-manager.explorer.read	api::gen-ai-category.gen-ai-category	{"fields": ["industryName", "iconifyIcon", "gen_ai_industry_cards"]}	[]	2023-08-11 12:59:05.48	2023-08-11 12:59:05.48	\N	\N
471	plugin::content-manager.explorer.update	api::gen-ai-category.gen-ai-category	{"fields": ["industryName", "iconifyIcon", "gen_ai_industry_cards"]}	[]	2023-08-11 12:59:05.486	2023-08-11 12:59:05.486	\N	\N
472	plugin::content-manager.explorer.delete	api::gen-ai-category.gen-ai-category	{}	[]	2023-08-11 12:59:05.494	2023-08-11 12:59:05.494	\N	\N
473	plugin::content-manager.explorer.publish	api::gen-ai-category.gen-ai-category	{}	[]	2023-08-11 12:59:05.502	2023-08-11 12:59:05.502	\N	\N
477	plugin::content-manager.explorer.delete	api::gen-ai-category-info.gen-ai-category-info	{}	[]	2023-08-11 12:59:05.531	2023-08-11 12:59:05.531	\N	\N
478	plugin::content-manager.explorer.publish	api::gen-ai-category-info.gen-ai-category-info	{}	[]	2023-08-11 12:59:05.539	2023-08-11 12:59:05.539	\N	\N
475	plugin::content-manager.explorer.read	api::gen-ai-category-info.gen-ai-category-info	{"fields": ["title", "description", "externalLink", "videoLink", "imageCarousel", "coverImageLink", "subTitle", "demoLink", "gen_ai_industry"]}	[]	2023-08-11 12:59:05.518	2023-08-14 10:47:01.857	\N	\N
485	plugin::content-manager.explorer.create	api::gen-ai-category-info.gen-ai-category-info	{"fields": ["title", "description", "externalLink", "videoLink", "imageCarousel", "coverImageLink", "subTitle", "demoLink", "gen_ai_industry"]}	[]	2023-08-14 10:38:14.518	2023-08-14 10:47:01.857	\N	\N
486	plugin::content-manager.explorer.read	api::gen-ai-category-info.gen-ai-category-info	{"fields": ["title", "description", "externalLink", "videoLink", "imageCarousel", "coverImageLink", "subTitle", "demoLink", "gen_ai_industry"]}	[]	2023-08-14 10:38:14.525	2023-08-14 10:47:01.857	\N	\N
482	plugin::content-manager.explorer.create	api::gen-ai-category.gen-ai-category	{"fields": ["industryName", "iconifyIcon", "gen_ai_industry_cards"]}	[]	2023-08-14 10:38:14.488	2023-08-14 10:38:14.488	\N	\N
483	plugin::content-manager.explorer.read	api::gen-ai-category.gen-ai-category	{"fields": ["industryName", "iconifyIcon", "gen_ai_industry_cards"]}	[]	2023-08-14 10:38:14.502	2023-08-14 10:38:14.502	\N	\N
484	plugin::content-manager.explorer.update	api::gen-ai-category.gen-ai-category	{"fields": ["industryName", "iconifyIcon", "gen_ai_industry_cards"]}	[]	2023-08-14 10:38:14.51	2023-08-14 10:38:14.51	\N	\N
474	plugin::content-manager.explorer.create	api::gen-ai-category-info.gen-ai-category-info	{"fields": ["title", "description", "externalLink", "videoLink", "imageCarousel", "coverImageLink", "subTitle", "demoLink", "gen_ai_industry"]}	[]	2023-08-11 12:59:05.51	2023-08-14 10:47:01.857	\N	\N
514	plugin::upload.read	\N	{}	[]	2023-09-14 09:38:26.022	2023-09-14 09:38:26.022	\N	\N
515	plugin::upload.configure-view	\N	{}	[]	2023-09-14 09:38:26.029	2023-09-14 09:38:26.029	\N	\N
516	plugin::upload.assets.create	\N	{}	[]	2023-09-14 09:38:26.037	2023-09-14 09:38:26.037	\N	\N
517	plugin::upload.assets.update	\N	{}	[]	2023-09-14 09:38:26.044	2023-09-14 09:38:26.044	\N	\N
518	plugin::upload.assets.download	\N	{}	[]	2023-09-14 09:38:26.05	2023-09-14 09:38:26.05	\N	\N
519	plugin::upload.assets.copy-link	\N	{}	[]	2023-09-14 09:38:26.063	2023-09-14 09:38:26.063	\N	\N
520	plugin::documentation.read	\N	{}	[]	2023-09-14 09:38:26.069	2023-09-14 09:38:26.069	\N	\N
521	plugin::documentation.settings.update	\N	{}	[]	2023-09-14 09:38:26.081	2023-09-14 09:38:26.081	\N	\N
407	plugin::content-manager.explorer.delete	api::country-master.country-master	{}	[]	2023-06-22 11:33:42.736	2023-06-22 11:33:42.736	\N	\N
408	plugin::content-manager.explorer.publish	api::country-master.country-master	{}	[]	2023-06-22 11:33:42.744	2023-06-22 11:33:42.744	\N	\N
412	plugin::content-manager.explorer.create	api::country-master.country-master	{"fields": ["code", "description", "isd_code", "iso_code", "is_active"]}	[]	2023-06-22 11:34:53.925	2023-06-22 16:07:00.616	\N	\N
413	plugin::content-manager.explorer.read	api::country-master.country-master	{"fields": ["code", "description", "isd_code", "iso_code", "is_active"]}	[]	2023-06-22 11:34:53.933	2023-06-22 16:07:00.616	\N	\N
414	plugin::content-manager.explorer.update	api::country-master.country-master	{"fields": ["code", "description", "isd_code", "iso_code", "is_active"]}	[]	2023-06-22 11:34:53.94	2023-06-22 16:07:00.616	\N	\N
409	plugin::content-manager.explorer.create	api::address-master.address-master	{"fields": ["code", "type", "description", "parent_type", "parent_code", "is_active"]}	[]	2023-06-22 11:34:53.902	2023-06-22 16:22:11.881	\N	\N
491	plugin::content-manager.explorer.delete	api::gen-ai-category.gen-ai-category	{}	[]	2023-08-14 10:38:50.327	2023-08-14 10:38:50.327	\N	\N
410	plugin::content-manager.explorer.read	api::address-master.address-master	{"fields": ["code", "type", "description", "parent_type", "parent_code", "is_active"]}	[]	2023-06-22 11:34:53.91	2023-06-22 16:22:11.881	\N	\N
411	plugin::content-manager.explorer.update	api::address-master.address-master	{"fields": ["code", "type", "description", "parent_type", "parent_code", "is_active"]}	[]	2023-06-22 11:34:53.918	2023-06-22 16:22:11.881	\N	\N
440	plugin::content-manager.explorer.delete	api::gen-ai-category.gen-ai-category	{}	[]	2023-08-09 04:37:42.22	2023-08-09 04:37:42.22	\N	\N
441	plugin::content-manager.explorer.publish	api::gen-ai-category.gen-ai-category	{}	[]	2023-08-09 04:37:42.233	2023-08-09 04:37:42.233	\N	\N
488	plugin::content-manager.explorer.create	api::gen-ai-category.gen-ai-category	{"fields": ["industryName", "iconifyIcon", "gen_ai_industry_cards"]}	[]	2023-08-14 10:38:50.302	2023-08-14 10:38:50.302	\N	\N
489	plugin::content-manager.explorer.read	api::gen-ai-category.gen-ai-category	{"fields": ["industryName", "iconifyIcon", "gen_ai_industry_cards"]}	[]	2023-08-14 10:38:50.31	2023-08-14 10:38:50.31	\N	\N
490	plugin::content-manager.explorer.update	api::gen-ai-category.gen-ai-category	{"fields": ["industryName", "iconifyIcon", "gen_ai_industry_cards"]}	[]	2023-08-14 10:38:50.316	2023-08-14 10:38:50.316	\N	\N
492	plugin::content-manager.explorer.publish	api::gen-ai-category.gen-ai-category	{}	[]	2023-08-14 10:38:50.34	2023-08-14 10:38:50.34	\N	\N
201	plugin::content-manager.explorer.read	plugin::users-permissions.user	{"fields": ["username", "email", "provider", "password", "resetPasswordToken", "confirmationToken", "confirmed", "blocked", "role"]}	[]	2023-05-31 06:45:17.777	2023-05-31 06:45:17.777	\N	\N
202	plugin::content-manager.single-types.configure-view	\N	{}	[]	2023-05-31 07:00:14.464	2023-05-31 07:00:14.464	\N	\N
203	plugin::content-manager.collection-types.configure-view	\N	{}	[]	2023-05-31 07:00:14.476	2023-05-31 07:00:14.476	\N	\N
204	plugin::content-manager.components.configure-layout	\N	{}	[]	2023-05-31 07:00:14.486	2023-05-31 07:00:14.486	\N	\N
205	plugin::content-type-builder.read	\N	{}	[]	2023-05-31 07:00:14.495	2023-05-31 07:00:14.495	\N	\N
206	plugin::upload.read	\N	{}	[]	2023-05-31 07:00:14.504	2023-05-31 07:00:14.504	\N	\N
207	plugin::upload.configure-view	\N	{}	[]	2023-05-31 07:00:14.513	2023-05-31 07:00:14.513	\N	\N
208	plugin::upload.assets.create	\N	{}	[]	2023-05-31 07:00:14.524	2023-05-31 07:00:14.524	\N	\N
209	plugin::upload.assets.update	\N	{}	[]	2023-05-31 07:00:14.533	2023-05-31 07:00:14.533	\N	\N
210	plugin::upload.assets.download	\N	{}	[]	2023-05-31 07:00:14.543	2023-05-31 07:00:14.543	\N	\N
211	plugin::upload.assets.copy-link	\N	{}	[]	2023-05-31 07:00:14.553	2023-05-31 07:00:14.553	\N	\N
212	plugin::users-permissions.roles.read	\N	{}	[]	2023-05-31 07:00:14.563	2023-05-31 07:00:14.563	\N	\N
213	plugin::users-permissions.providers.read	\N	{}	[]	2023-05-31 07:00:14.574	2023-05-31 07:00:14.574	\N	\N
214	plugin::users-permissions.providers.update	\N	{}	[]	2023-05-31 07:00:14.596	2023-05-31 07:00:14.596	\N	\N
215	plugin::users-permissions.email-templates.read	\N	{}	[]	2023-05-31 07:00:14.609	2023-05-31 07:00:14.609	\N	\N
216	plugin::users-permissions.email-templates.update	\N	{}	[]	2023-05-31 07:00:14.618	2023-05-31 07:00:14.618	\N	\N
217	plugin::users-permissions.advanced-settings.read	\N	{}	[]	2023-05-31 07:00:14.629	2023-05-31 07:00:14.629	\N	\N
218	plugin::users-permissions.advanced-settings.update	\N	{}	[]	2023-05-31 07:00:14.64	2023-05-31 07:00:14.64	\N	\N
219	plugin::content-manager.explorer.create	plugin::users-permissions.user	{"fields": ["username", "email", "provider", "password", "resetPasswordToken", "confirmationToken", "confirmed", "blocked", "role"]}	[]	2023-05-31 07:00:14.649	2023-05-31 07:00:14.649	\N	\N
220	plugin::content-manager.explorer.update	plugin::users-permissions.user	{"fields": ["username", "email", "provider", "password", "resetPasswordToken", "confirmationToken", "confirmed", "blocked", "role"]}	[]	2023-05-31 07:00:14.657	2023-05-31 07:00:14.657	\N	\N
221	plugin::email.settings.read	\N	{}	[]	2023-05-31 07:05:20.322	2023-05-31 07:05:20.322	\N	\N
222	plugin::upload.settings.read	\N	{}	[]	2023-05-31 07:05:20.334	2023-05-31 07:05:20.334	\N	\N
223	plugin::i18n.locale.create	\N	{}	[]	2023-05-31 07:05:20.343	2023-05-31 07:05:20.343	\N	\N
496	plugin::content-manager.explorer.delete	api::gen-ai-category-info.gen-ai-category-info	{}	[]	2023-08-14 10:38:50.38	2023-08-14 10:38:50.38	\N	\N
497	plugin::content-manager.explorer.publish	api::gen-ai-category-info.gen-ai-category-info	{}	[]	2023-08-14 10:38:50.397	2023-08-14 10:38:50.397	\N	\N
476	plugin::content-manager.explorer.update	api::gen-ai-category-info.gen-ai-category-info	{"fields": ["title", "description", "externalLink", "videoLink", "imageCarousel", "coverImageLink", "subTitle", "demoLink", "gen_ai_industry"]}	[]	2023-08-11 12:59:05.524	2023-08-14 10:47:01.857	\N	\N
493	plugin::content-manager.explorer.create	api::gen-ai-category-info.gen-ai-category-info	{"fields": ["title", "description", "externalLink", "videoLink", "imageCarousel", "coverImageLink", "subTitle", "demoLink", "gen_ai_industry"]}	[]	2023-08-14 10:38:50.351	2023-08-14 10:47:01.857	\N	\N
494	plugin::content-manager.explorer.read	api::gen-ai-category-info.gen-ai-category-info	{"fields": ["title", "description", "externalLink", "videoLink", "imageCarousel", "coverImageLink", "subTitle", "demoLink", "gen_ai_industry"]}	[]	2023-08-14 10:38:50.36	2023-08-14 10:47:01.857	\N	\N
522	plugin::documentation.settings.regenerate	\N	{}	[]	2023-09-14 09:38:26.094	2023-09-14 09:38:26.094	\N	\N
224	plugin::i18n.locale.read	\N	{}	[]	2023-05-31 07:05:20.355	2023-05-31 07:05:20.355	\N	\N
225	plugin::i18n.locale.update	\N	{}	[]	2023-05-31 07:05:20.364	2023-05-31 07:05:20.364	\N	\N
226	plugin::i18n.locale.delete	\N	{}	[]	2023-05-31 07:05:20.373	2023-05-31 07:05:20.373	\N	\N
227	admin::marketplace.read	\N	{}	[]	2023-05-31 07:05:20.381	2023-05-31 07:05:20.381	\N	\N
228	admin::webhooks.create	\N	{}	[]	2023-05-31 07:05:20.389	2023-05-31 07:05:20.389	\N	\N
229	admin::webhooks.read	\N	{}	[]	2023-05-31 07:05:20.398	2023-05-31 07:05:20.398	\N	\N
230	admin::webhooks.update	\N	{}	[]	2023-05-31 07:05:20.406	2023-05-31 07:05:20.406	\N	\N
231	admin::webhooks.delete	\N	{}	[]	2023-05-31 07:05:20.414	2023-05-31 07:05:20.414	\N	\N
232	admin::users.read	\N	{}	[]	2023-05-31 07:05:20.424	2023-05-31 07:05:20.424	\N	\N
233	admin::roles.read	\N	{}	[]	2023-05-31 07:05:20.434	2023-05-31 07:05:20.434	\N	\N
234	admin::api-tokens.access	\N	{}	[]	2023-05-31 07:05:20.443	2023-05-31 07:05:20.443	\N	\N
235	admin::api-tokens.create	\N	{}	[]	2023-05-31 07:05:20.452	2023-05-31 07:05:20.452	\N	\N
236	admin::api-tokens.read	\N	{}	[]	2023-05-31 07:05:20.461	2023-05-31 07:05:20.461	\N	\N
237	admin::api-tokens.update	\N	{}	[]	2023-05-31 07:05:20.469	2023-05-31 07:05:20.469	\N	\N
238	admin::api-tokens.regenerate	\N	{}	[]	2023-05-31 07:05:20.477	2023-05-31 07:05:20.477	\N	\N
239	admin::api-tokens.delete	\N	{}	[]	2023-05-31 07:05:20.485	2023-05-31 07:05:20.485	\N	\N
240	admin::project-settings.update	\N	{}	[]	2023-05-31 07:05:20.499	2023-05-31 07:05:20.499	\N	\N
241	admin::project-settings.read	\N	{}	[]	2023-05-31 07:05:20.508	2023-05-31 07:05:20.508	\N	\N
242	admin::transfer.tokens.access	\N	{}	[]	2023-05-31 07:05:20.519	2023-05-31 07:05:20.519	\N	\N
243	admin::transfer.tokens.create	\N	{}	[]	2023-05-31 07:05:20.529	2023-05-31 07:05:20.529	\N	\N
244	admin::transfer.tokens.read	\N	{}	[]	2023-05-31 07:05:20.54	2023-05-31 07:05:20.54	\N	\N
245	admin::transfer.tokens.update	\N	{}	[]	2023-05-31 07:05:20.55	2023-05-31 07:05:20.55	\N	\N
246	admin::transfer.tokens.regenerate	\N	{}	[]	2023-05-31 07:05:20.561	2023-05-31 07:05:20.561	\N	\N
247	admin::transfer.tokens.delete	\N	{}	[]	2023-05-31 07:05:20.586	2023-05-31 07:05:20.586	\N	\N
379	plugin::content-manager.explorer.create	api::rule-additional-fields-description.rule-additional-fields-description	{"fields": ["keyName", "valueSql"]}	[]	2023-06-06 13:08:44.013	2023-06-06 13:08:44.013	\N	\N
380	plugin::content-manager.explorer.read	api::rule-additional-fields-description.rule-additional-fields-description	{"fields": ["keyName", "valueSql"]}	[]	2023-06-06 13:08:44.022	2023-06-06 13:08:44.022	\N	\N
381	plugin::content-manager.explorer.update	api::rule-additional-fields-description.rule-additional-fields-description	{"fields": ["keyName", "valueSql"]}	[]	2023-06-06 13:08:44.028	2023-06-06 13:08:44.028	\N	\N
463	plugin::content-manager.explorer.create	api::gen-ai-category.gen-ai-category	{"fields": ["industryName", "iconifyIcon", "gen_ai_industry_cards"]}	[]	2023-08-11 12:47:00.593	2023-08-11 12:47:00.593	\N	\N
465	plugin::content-manager.explorer.read	api::gen-ai-category.gen-ai-category	{"fields": ["industryName", "iconifyIcon", "gen_ai_industry_cards"]}	[]	2023-08-11 12:47:00.622	2023-08-11 12:47:00.622	\N	\N
467	plugin::content-manager.explorer.update	api::gen-ai-category.gen-ai-category	{"fields": ["industryName", "iconifyIcon", "gen_ai_industry_cards"]}	[]	2023-08-11 12:47:00.647	2023-08-11 12:47:00.647	\N	\N
487	plugin::content-manager.explorer.update	api::gen-ai-category-info.gen-ai-category-info	{"fields": ["title", "description", "externalLink", "videoLink", "imageCarousel", "coverImageLink", "subTitle", "demoLink", "gen_ai_industry"]}	[]	2023-08-14 10:38:14.533	2023-08-14 10:47:01.857	\N	\N
495	plugin::content-manager.explorer.update	api::gen-ai-category-info.gen-ai-category-info	{"fields": ["title", "description", "externalLink", "videoLink", "imageCarousel", "coverImageLink", "subTitle", "demoLink", "gen_ai_industry"]}	[]	2023-08-14 10:38:50.371	2023-08-14 10:47:01.857	\N	\N
501	plugin::content-manager.explorer.create	api::gen-ai-category-info.gen-ai-category-info	{"fields": ["title", "description", "externalLink", "videoLink", "imageCarousel", "coverImageLink", "subTitle", "demoLink", "gen_ai_industry", "rank"]}	[]	2023-08-14 10:48:46.297	2023-08-14 10:48:46.297	\N	\N
502	plugin::content-manager.explorer.read	api::gen-ai-category-info.gen-ai-category-info	{"fields": ["title", "description", "externalLink", "videoLink", "imageCarousel", "coverImageLink", "subTitle", "demoLink", "gen_ai_industry", "rank"]}	[]	2023-08-14 10:48:46.33	2023-08-14 10:48:46.33	\N	\N
503	plugin::content-manager.explorer.update	api::gen-ai-category-info.gen-ai-category-info	{"fields": ["title", "description", "externalLink", "videoLink", "imageCarousel", "coverImageLink", "subTitle", "demoLink", "gen_ai_industry", "rank"]}	[]	2023-08-14 10:48:46.339	2023-08-14 10:48:46.339	\N	\N
288	plugin::documentation.read	\N	{}	[]	2023-06-05 11:36:06.726	2023-06-05 11:36:06.726	\N	\N
289	plugin::documentation.settings.update	\N	{}	[]	2023-06-05 11:36:06.739	2023-06-05 11:36:06.739	\N	\N
290	plugin::documentation.settings.regenerate	\N	{}	[]	2023-06-05 11:36:06.745	2023-06-05 11:36:06.745	\N	\N
291	plugin::documentation.settings.read	\N	{}	[]	2023-06-05 11:36:06.752	2023-06-05 11:36:06.752	\N	\N
567	plugin::content-manager.explorer.create	api::gen-ai-category.gen-ai-category	{"fields": ["industryName", "iconifyIcon", "gen_ai_industry_cards"]}	[]	2023-09-14 09:38:26.561	2023-09-14 09:38:26.561	\N	\N
568	plugin::content-manager.explorer.read	api::gen-ai-category.gen-ai-category	{"fields": ["industryName", "iconifyIcon", "gen_ai_industry_cards"]}	[]	2023-09-14 09:38:26.572	2023-09-14 09:38:26.572	\N	\N
569	plugin::content-manager.explorer.update	api::gen-ai-category.gen-ai-category	{"fields": ["industryName", "iconifyIcon", "gen_ai_industry_cards"]}	[]	2023-09-14 09:38:26.582	2023-09-14 09:38:26.582	\N	\N
570	plugin::content-manager.explorer.delete	api::gen-ai-category.gen-ai-category	{}	[]	2023-09-14 09:38:26.599	2023-09-14 09:38:26.599	\N	\N
571	plugin::content-manager.explorer.publish	api::gen-ai-category.gen-ai-category	{}	[]	2023-09-14 09:38:26.609	2023-09-14 09:38:26.609	\N	\N
572	plugin::content-manager.explorer.create	api::gen-ai-category-info.gen-ai-category-info	{"fields": ["title", "description", "externalLink", "videoLink", "imageCarousel", "coverImageLink", "subTitle", "demoLink", "gen_ai_industry", "rank"]}	[]	2023-09-14 09:38:26.639	2023-09-14 09:38:26.639	\N	\N
573	plugin::content-manager.explorer.read	api::gen-ai-category-info.gen-ai-category-info	{"fields": ["title", "description", "externalLink", "videoLink", "imageCarousel", "coverImageLink", "subTitle", "demoLink", "gen_ai_industry", "rank"]}	[]	2023-09-14 09:38:26.654	2023-09-14 09:38:26.654	\N	\N
574	plugin::content-manager.explorer.update	api::gen-ai-category-info.gen-ai-category-info	{"fields": ["title", "description", "externalLink", "videoLink", "imageCarousel", "coverImageLink", "subTitle", "demoLink", "gen_ai_industry", "rank"]}	[]	2023-09-14 09:38:26.673	2023-09-14 09:38:26.673	\N	\N
575	plugin::content-manager.explorer.delete	api::gen-ai-category-info.gen-ai-category-info	{}	[]	2023-09-14 09:38:26.731	2023-09-14 09:38:26.731	\N	\N
576	plugin::content-manager.explorer.publish	api::gen-ai-category-info.gen-ai-category-info	{}	[]	2023-09-14 09:38:26.744	2023-09-14 09:38:26.744	\N	\N
\.


--
-- Data for Name: admin_permissions_role_links; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.admin_permissions_role_links (id, permission_id, role_id, permission_order) FROM stdin;
348	348	1	97
349	349	1	98
350	350	1	99
351	351	1	100
352	352	1	101
356	356	1	105
357	357	1	106
366	366	1	110
367	367	1	111
21	21	2	21
22	22	2	22
23	23	2	23
24	24	2	24
25	25	2	25
26	26	2	26
373	373	1	117
374	374	1	118
375	375	1	119
379	379	1	123
380	380	1	124
381	381	1	125
382	382	1	126
383	383	1	127
384	384	1	128
385	385	1	129
386	386	1	130
387	387	1	131
388	388	1	132
389	389	1	133
390	390	5	76
391	391	5	77
43	43	3	17
44	44	3	18
45	45	3	19
46	46	3	20
47	47	3	21
48	48	3	22
49	49	1	1
392	392	5	78
393	393	5	79
394	394	5	80
54	54	1	6
402	402	1	137
403	403	1	138
59	59	1	11
415	415	1	144
416	416	1	145
417	417	1	146
421	421	5	91
64	64	1	16
422	422	5	92
423	423	5	93
424	424	5	94
432	432	1	153
433	433	1	154
73	73	1	25
74	74	1	26
75	75	1	27
76	76	1	28
77	77	1	29
78	78	1	30
79	79	1	31
80	80	1	32
81	81	1	33
82	82	1	34
83	83	1	35
84	84	1	36
85	85	1	37
86	86	1	38
87	87	1	39
88	88	1	40
89	89	1	41
90	90	1	42
91	91	1	43
92	92	1	44
93	93	1	45
94	94	1	46
95	95	1	47
96	96	1	48
97	97	1	49
98	98	1	50
99	99	1	51
100	100	1	52
101	101	1	53
102	102	1	54
103	103	1	55
104	104	1	56
105	105	1	57
106	106	1	58
107	107	1	59
108	108	1	60
109	109	1	61
110	110	1	62
111	111	1	63
112	112	1	64
113	113	1	65
114	114	1	66
115	115	1	67
116	116	1	68
117	117	1	69
118	118	1	70
119	119	1	71
120	120	1	72
121	121	1	73
122	122	1	74
123	123	1	75
124	124	1	76
125	125	1	77
463	463	1	163
465	465	1	165
467	467	1	167
488	488	7	1
489	489	7	2
490	490	7	3
491	491	7	4
492	492	7	5
493	493	7	6
494	494	7	7
495	495	7	8
496	496	7	9
497	497	7	10
501	501	1	168
502	502	1	169
503	503	1	170
504	504	6	7
505	505	6	8
506	506	6	9
507	507	6	10
508	508	6	11
509	509	6	12
514	514	8	5
515	515	8	6
516	516	8	7
517	517	8	8
518	518	8	9
519	519	8	10
520	520	8	11
521	521	8	12
522	522	8	13
371	371	1	115
372	372	1	116
395	395	5	81
396	396	5	82
397	397	5	83
398	398	5	84
407	407	1	142
408	408	1	143
409	409	5	85
410	410	5	86
411	411	5	87
412	412	5	88
413	413	5	89
414	414	5	90
418	418	1	147
419	419	1	148
420	420	1	149
425	425	5	95
426	426	5	96
427	427	5	97
428	428	5	98
440	440	1	161
441	441	1	162
201	201	5	29
202	202	5	30
203	203	5	31
204	204	5	32
205	205	5	33
206	206	5	34
207	207	5	35
208	208	5	36
209	209	5	37
210	210	5	38
211	211	5	39
212	212	5	40
213	213	5	41
214	214	5	42
215	215	5	43
216	216	5	44
217	217	5	45
218	218	5	46
219	219	5	47
220	220	5	48
221	221	5	49
222	222	5	50
223	223	5	51
224	224	5	52
225	225	5	53
226	226	5	54
227	227	5	55
228	228	5	56
229	229	5	57
230	230	5	58
231	231	5	59
232	232	5	60
233	233	5	61
234	234	5	62
235	235	5	63
236	236	5	64
237	237	5	65
238	238	5	66
239	239	5	67
240	240	5	68
241	241	5	69
242	242	5	70
243	243	5	71
244	244	5	72
245	245	5	73
246	246	5	74
247	247	5	75
469	469	2	27
470	470	2	28
471	471	2	29
472	472	2	30
473	473	2	31
474	474	2	32
475	475	2	33
476	476	2	34
477	477	2	35
478	478	2	36
482	482	6	1
483	483	6	2
484	484	6	3
485	485	6	4
486	486	6	5
487	487	6	6
288	288	1	93
289	289	1	94
290	290	1	95
291	291	1	96
567	567	8	58
568	568	8	59
569	569	8	60
570	570	8	61
571	571	8	62
572	572	8	63
573	573	8	64
574	574	8	65
575	575	8	66
576	576	8	67
\.


--
-- Data for Name: admin_roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.admin_roles (id, name, code, description, created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
1	Super Admin	strapi-super-admin	Super Admins can access and manage all features and settings.	2023-05-08 06:39:53.12	2023-05-08 06:39:53.12	\N	\N
3	Author	strapi-author	Authors can manage the content they have created.	2023-05-08 06:39:53.15	2023-05-08 06:39:53.15	\N	\N
2	Editor	strapi-editor	Editors can manage and publish contents including those of other users.	2023-05-08 06:39:53.145	2023-08-11 12:59:05.311	\N	\N
7	GenAi-Editor	gen-ai-editor-llaqsd3k	An Editor can create, modify, delete, and read items & publish.	2023-08-14 10:38:50.192	2023-08-14 10:38:50.192	\N	\N
5	Admin	admin-lib9oo8o	Admin has all the access to strapi dashboard except the Admin panel user deletion	2023-05-31 05:28:43.704	2023-08-31 10:04:24.212	\N	\N
6	GenAi-Author	gen-ai-author-llaqrlfs	An Author can create and read items. Also, can modify and delete only items that he or she creates, not items created by other users.	2023-08-14 10:38:14.344	2023-09-13 05:31:25.679	\N	\N
8	GenAI-Admin	gen-ai-admin-lmiza36o	Created September 14th, 2023	2023-09-14 09:38:25.824	2023-09-14 09:42:34.168	\N	\N
\.


--
-- Data for Name: admin_users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.admin_users (id, firstname, lastname, username, email, password, reset_password_token, registration_token, is_active, blocked, prefered_language, created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
1	Abhilekh	Singh	\N	abhilekh.singh@xebia.com	$2a$10$iLotjPWOwdw2grUK4Q19A.ijTOpPMj17wCT/05xFInIZOkECoa3.K	\N	\N	t	f	\N	2023-05-30 08:36:42.882	2023-05-30 08:36:42.882	\N	\N
6	Manoj	Kumar	\N	manoj.kumar2@xebia.com	\N	\N	7df40a5cd6357c847117fe05e463800bb6d6248b	f	f	\N	2023-05-31 06:46:25.274	2023-05-31 06:46:25.274	\N	\N
8	Harshitha	RB	\N	harshitha.rb@xebia.com	$2a$10$c4RQwGovL/P.3ej9v6YCmuSrQUAye/gnm8Uh.NvD/H1U3Qm.OfQ82	\N	\N	t	f	\N	2023-05-31 06:49:08.354	2023-05-31 06:50:06.561	\N	\N
14	Nitin	Gupta	\N	nitin.gupta@xebia.com	$2a$10$/4JwAVKpF1ZtOh.TXgN5AOmqGF/0wPDOmUJja/YCi4DKpBt2xZuxe	\N	1be02193dcc8c4a6f7d1405dd7c95fc830eb76b0	t	f	\N	2023-05-31 07:10:03.499	2023-09-14 09:40:03.443	\N	\N
9	Nitesh	Prasad	\N	nitesh.prasad@xebia.com	$2a$10$EzYZXg5rBicNzrzrip1FrOJwp0cqLHeX4fn/NnOrWaC6FI2FWrI6q	\N	\N	t	f	\N	2023-05-31 06:50:06.927	2023-05-31 06:59:43.632	\N	\N
12	Anand		\N	anand.agrawal@xebia.com	\N	\N	840fa16bca4427bf54f53ef1e7ef72f7682e6ed8	f	f	\N	2023-05-31 07:07:49.746	2023-05-31 07:07:49.746	\N	\N
13	Love	Kumar	\N	love.kumar@xebia.com	$2a$10$/sSyN9nCzaDba997yt7DeubNGCTSftWtrLQvUEJjVM5ZBUwesfOCC	\N	\N	t	f	\N	2023-05-31 07:08:50.285	2023-05-31 07:10:09.072	\N	\N
16	Sourish	Tewary	\N	sourish.tewary@xebia.com	$2a$10$i.r5kTJbFNZ1ifITfIPTxe8KJGDtVZtullVwz/2eikR2tn6oCqmR2	\N	\N	t	f	\N	2023-05-31 07:12:12.507	2023-05-31 08:57:23.839	\N	\N
10	Mukesh		\N	mukesh.chaubey@xebia.com	$2a$10$qUy.hYjjkUbjpBoZPcKcNeE08Bq88NVn3Bc3a1rpAOb9P2RhiO.TG	\N	\N	t	f	\N	2023-05-31 06:52:16.815	2023-05-31 12:27:43.585	\N	\N
20	Anamol	Verma	\N	anamol.verma@xebia.com	$2a$10$1DttecAfElG/8zrD9Viad.U2KOpYsTqICq8O.WkyVDLq3CM7VndUG	\N	\N	t	f	\N	2023-06-06 05:46:30.772	2023-09-14 09:43:41.133	\N	\N
15	Praveen	Payasi	\N	praveen.payasi@xebia.com	$2a$10$BoEF1hKfWU43rDjFbtUJgO5VzyKSpWcyO4jNDyZnwHZu9WulDggZS	\N	\N	t	f	\N	2023-05-31 07:11:08.069	2023-06-01 07:24:01.813	\N	\N
23	Vikas	Kumar	\N	vikas.k@xebia.com	\N	\N	798066f76ed15274fdfbe34200ca0f47dea66c62	f	f	\N	2023-08-14 10:41:21.438	2023-08-14 10:41:21.438	\N	\N
21	Abhinish	Paul	\N	abhinish.paul@xebia.com	$2a$10$CIsETFOP5um89d5TY21eouvct7SxI28v4QZ3Gl9LcKfKrN1oQ.BFm	\N	\N	t	f	\N	2023-08-14 10:39:51.268	2023-08-14 10:43:12.605	\N	\N
22	Ishika	Soni	\N	ishika.soni@xebia.com	$2a$10$2jj00O28Lt9E26ty5g9aeug2b2CCgqPza22zj1sOS3az5bVKzVwWe	\N	\N	t	f	\N	2023-08-14 10:40:44.244	2023-08-28 11:04:09.406	\N	\N
7	Aman	Taak	\N	aman.taak@xebia.com	$2a$10$2X5cil6dx3iNZvKeaaI08Oyj57yhy0ELnkYKvZ2yTcdBcwUpv7K4u	\N	\N	t	f	\N	2023-05-31 06:47:48.364	2023-08-31 10:02:45.314	\N	\N
\.


--
-- Data for Name: admin_users_roles_links; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.admin_users_roles_links (id, user_id, role_id, role_order, user_order) FROM stdin;
44	14	6	1	1
45	14	7	2	1
63	14	8	3	1
34	20	6	1	1
39	20	7	2	3
72	20	8	3	2
1	1	1	1	1
7	6	1	1	2
35	21	7	1	1
36	22	6	1	2
37	23	7	1	2
8	7	1	1	1
9	8	5	1	1
10	9	5	1	2
11	10	5	1	3
13	12	5	1	4
14	13	5	1	5
16	15	5	1	6
17	16	5	1	7
\.


--
-- Data for Name: category_infos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.category_infos (id, category, code, created_at, updated_at, published_at, created_by_id, updated_by_id) FROM stdin;
1	Health Insurance	010101	2023-06-06 11:44:52.579	2023-06-06 11:44:53.943	2023-06-06 11:44:53.935	1	1
2	Loan	020202	2023-06-06 11:45:22.278	2023-06-06 11:45:24.687	2023-06-06 11:45:24.679	1	1
\.


--
-- Data for Name: country_masters; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.country_masters (id, code, created_at, updated_at, published_at, created_by_id, updated_by_id, description, isd_code, iso_code, is_active) FROM stdin;
1	01	2023-06-22 16:20:20.469	2023-06-22 16:20:20.469	\N	9	9	Vietnam	+84	VNM	t
2	02	2023-06-22 16:20:37.029	2023-06-22 16:20:37.029	\N	9	9	Singapore	+65	SG	t
\.


--
-- Data for Name: files; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.files (id, name, alternative_text, caption, width, height, formats, hash, ext, mime, size, url, preview_url, provider, provider_metadata, folder_path, created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
85	Travel Expense Tracking .png	\N	\N	360	360	{"thumbnail": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/thumbnail_Travel_Expense_Tracking_16b96a3cc9.png", "hash": "thumbnail_Travel_Expense_Tracking_16b96a3cc9", "mime": "image/png", "name": "thumbnail_Travel Expense Tracking .png", "path": null, "size": 12.28, "width": 156, "height": 156}}	Travel_Expense_Tracking_16b96a3cc9	.png	image/png	5.88	https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/Travel_Expense_Tracking_16b96a3cc9.png	\N	aws-s3	\N	/1	2023-08-22 09:02:12.469	2023-08-22 09:02:12.469	7	7
86	Travel Itinerary.png	\N	\N	512	512	{"small": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/small_Travel_Itinerary_31318aee58.png", "hash": "small_Travel_Itinerary_31318aee58", "mime": "image/png", "name": "small_Travel Itinerary.png", "path": null, "size": 59.82, "width": 500, "height": 500}, "thumbnail": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/thumbnail_Travel_Itinerary_31318aee58.png", "hash": "thumbnail_Travel_Itinerary_31318aee58", "mime": "image/png", "name": "thumbnail_Travel Itinerary.png", "path": null, "size": 14.54, "width": 156, "height": 156}}	Travel_Itinerary_31318aee58	.png	image/png	10.45	https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/Travel_Itinerary_31318aee58.png	\N	aws-s3	\N	/1	2023-08-22 09:02:12.511	2023-08-22 09:02:12.511	7	7
87	Virtual Tour Guides .png	\N	\N	512	512	{"small": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/small_Virtual_Tour_Guides_40737150ec.png", "hash": "small_Virtual_Tour_Guides_40737150ec", "mime": "image/png", "name": "small_Virtual Tour Guides .png", "path": null, "size": 66.81, "width": 500, "height": 500}, "thumbnail": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/thumbnail_Virtual_Tour_Guides_40737150ec.png", "hash": "thumbnail_Virtual_Tour_Guides_40737150ec", "mime": "image/png", "name": "thumbnail_Virtual Tour Guides .png", "path": null, "size": 18.43, "width": 156, "height": 156}}	Virtual_Tour_Guides_40737150ec	.png	image/png	10.81	https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/Virtual_Tour_Guides_40737150ec.png	\N	aws-s3	\N	/1	2023-08-22 09:02:13.315	2023-08-22 09:02:13.315	7	7
90	Destination Recommendation.png	\N	\N	512	512	{"small": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/small_Destination_Recommendation_542ef0363d.png", "hash": "small_Destination_Recommendation_542ef0363d", "mime": "image/png", "name": "small_Destination Recommendation.png", "path": null, "size": 60.84, "width": 500, "height": 500}, "thumbnail": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/thumbnail_Destination_Recommendation_542ef0363d.png", "hash": "thumbnail_Destination_Recommendation_542ef0363d", "mime": "image/png", "name": "thumbnail_Destination Recommendation.png", "path": null, "size": 14.54, "width": 156, "height": 156}}	Destination_Recommendation_542ef0363d	.png	image/png	10.79	https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/Destination_Recommendation_542ef0363d.png	\N	aws-s3	\N	/1	2023-08-22 09:05:56.411	2023-08-22 09:05:56.411	7	7
96	Customer Segmentation.png	\N	\N	649	556	{"small": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/small_Customer_Segmentation_bd87f516c7.png", "hash": "small_Customer_Segmentation_bd87f516c7", "mime": "image/png", "name": "small_Customer Segmentation.png", "path": null, "size": 63.1, "width": 500, "height": 428}, "thumbnail": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/thumbnail_Customer_Segmentation_bd87f516c7.png", "hash": "thumbnail_Customer_Segmentation_bd87f516c7", "mime": "image/png", "name": "thumbnail_Customer Segmentation.png", "path": null, "size": 18.77, "width": 182, "height": 156}}	Customer_Segmentation_bd87f516c7	.png	image/png	13.65	https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/Customer_Segmentation_bd87f516c7.png	\N	aws-s3	\N	/1	2023-08-22 09:25:20.298	2023-08-22 09:25:20.298	7	7
49	Conversational Banking.png	\N	\N	1000	500	{"small": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/small_Conversational_Banking_b54a8eec5c.png", "hash": "small_Conversational_Banking_b54a8eec5c", "mime": "image/png", "name": "small_Conversational Banking.png", "path": null, "size": 88.19, "width": 500, "height": 250}, "medium": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/medium_Conversational_Banking_b54a8eec5c.png", "hash": "medium_Conversational_Banking_b54a8eec5c", "mime": "image/png", "name": "medium_Conversational Banking.png", "path": null, "size": 158.21, "width": 750, "height": 375}, "thumbnail": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/thumbnail_Conversational_Banking_b54a8eec5c.png", "hash": "thumbnail_Conversational_Banking_b54a8eec5c", "mime": "image/png", "name": "thumbnail_Conversational Banking.png", "path": null, "size": 32.83, "width": 245, "height": 123}}	Conversational_Banking_b54a8eec5c	.png	image/png	50.48	https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/Conversational_Banking_b54a8eec5c.png	\N	aws-s3	\N	/1	2023-08-22 07:14:49.67	2023-08-22 07:15:28.151	7	7
103	embedded-processor-and-memory.png	\N	\N	1374	824	{"large": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/large_embedded_processor_and_memory_5ad136724d.png", "hash": "large_embedded_processor_and_memory_5ad136724d", "mime": "image/png", "name": "large_embedded-processor-and-memory.png", "path": null, "size": 39.7, "width": 1000, "height": 600}, "small": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/small_embedded_processor_and_memory_5ad136724d.png", "hash": "small_embedded_processor_and_memory_5ad136724d", "mime": "image/png", "name": "small_embedded-processor-and-memory.png", "path": null, "size": 17.89, "width": 500, "height": 300}, "medium": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/medium_embedded_processor_and_memory_5ad136724d.png", "hash": "medium_embedded_processor_and_memory_5ad136724d", "mime": "image/png", "name": "medium_embedded-processor-and-memory.png", "path": null, "size": 28.48, "width": 750, "height": 450}, "thumbnail": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/thumbnail_embedded_processor_and_memory_5ad136724d.png", "hash": "thumbnail_embedded_processor_and_memory_5ad136724d", "mime": "image/png", "name": "thumbnail_embedded-processor-and-memory.png", "path": null, "size": 8.05, "width": 245, "height": 147}}	embedded_processor_and_memory_5ad136724d	.png	image/png	14.69	https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/embedded_processor_and_memory_5ad136724d.png	\N	aws-s3	\N	/1	2023-08-28 10:53:26.428	2023-08-28 10:53:26.428	7	7
89	Culinary Exploration.webp	\N	\N	1920	1920	{"large": {"ext": ".webp", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/large_Culinary_Exploration_d49bb09407.webp", "hash": "large_Culinary_Exploration_d49bb09407", "mime": "image/webp", "name": "large_Culinary Exploration.webp", "path": null, "size": 31.04, "width": 1000, "height": 1000}, "small": {"ext": ".webp", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/small_Culinary_Exploration_d49bb09407.webp", "hash": "small_Culinary_Exploration_d49bb09407", "mime": "image/webp", "name": "small_Culinary Exploration.webp", "path": null, "size": 14.26, "width": 500, "height": 500}, "medium": {"ext": ".webp", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/medium_Culinary_Exploration_d49bb09407.webp", "hash": "medium_Culinary_Exploration_d49bb09407", "mime": "image/webp", "name": "medium_Culinary Exploration.webp", "path": null, "size": 22.22, "width": 750, "height": 750}, "thumbnail": {"ext": ".webp", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/thumbnail_Culinary_Exploration_d49bb09407.webp", "hash": "thumbnail_Culinary_Exploration_d49bb09407", "mime": "image/webp", "name": "thumbnail_Culinary Exploration.webp", "path": null, "size": 4.05, "width": 156, "height": 156}}	Culinary_Exploration_d49bb09407	.webp	image/webp	64.74	https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/Culinary_Exploration_d49bb09407.webp	\N	aws-s3	\N	/1	2023-08-22 09:02:17.815	2023-08-22 09:02:17.815	7	7
104	Savics_interoperability_architecture-definition.png	\N	\N	256	256	{"thumbnail": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/thumbnail_Savics_interoperability_architecture_definition_7b7a1ae618.png", "hash": "thumbnail_Savics_interoperability_architecture_definition_7b7a1ae618", "mime": "image/png", "name": "thumbnail_Savics_interoperability_architecture-definition.png", "path": null, "size": 15.39, "width": 156, "height": 156}}	Savics_interoperability_architecture_definition_7b7a1ae618	.png	image/png	4.19	https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/Savics_interoperability_architecture_definition_7b7a1ae618.png	\N	aws-s3	\N	/1	2023-08-28 10:54:30.12	2023-08-28 10:54:30.12	7	7
91	Shopping-Bag-Transparent-Background.png	\N	\N	612	363	{"small": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/small_Shopping_Bag_Transparent_Background_5bf404fa19.png", "hash": "small_Shopping_Bag_Transparent_Background_5bf404fa19", "mime": "image/png", "name": "small_Shopping-Bag-Transparent-Background.png", "path": null, "size": 172.38, "width": 500, "height": 297}, "thumbnail": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/thumbnail_Shopping_Bag_Transparent_Background_5bf404fa19.png", "hash": "thumbnail_Shopping_Bag_Transparent_Background_5bf404fa19", "mime": "image/png", "name": "thumbnail_Shopping-Bag-Transparent-Background.png", "path": null, "size": 49.84, "width": 245, "height": 145}}	Shopping_Bag_Transparent_Background_5bf404fa19	.png	image/png	48.62	https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/Shopping_Bag_Transparent_Background_5bf404fa19.png	\N	aws-s3	\N	/1	2023-08-22 09:10:40.977	2023-08-22 09:10:40.977	7	7
93	Branding.png	\N	\N	1152	944	{"large": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/large_Branding_9cb41c5eb0.png", "hash": "large_Branding_9cb41c5eb0", "mime": "image/png", "name": "large_Branding.png", "path": null, "size": 278.5, "width": 1000, "height": 819}, "small": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/small_Branding_9cb41c5eb0.png", "hash": "small_Branding_9cb41c5eb0", "mime": "image/png", "name": "small_Branding.png", "path": null, "size": 96.44, "width": 500, "height": 410}, "medium": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/medium_Branding_9cb41c5eb0.png", "hash": "medium_Branding_9cb41c5eb0", "mime": "image/png", "name": "medium_Branding.png", "path": null, "size": 175.67, "width": 750, "height": 615}, "thumbnail": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/thumbnail_Branding_9cb41c5eb0.png", "hash": "thumbnail_Branding_9cb41c5eb0", "mime": "image/png", "name": "thumbnail_Branding.png", "path": null, "size": 27.18, "width": 190, "height": 156}}	Branding_9cb41c5eb0	.png	image/png	59.27	https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/Branding_9cb41c5eb0.png	\N	aws-s3	\N	/1	2023-08-22 09:10:43.768	2023-08-22 09:10:43.768	7	7
94	shopping.png	\N	\N	2196	2642	{"large": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/large_shopping_9d549ff6da.png", "hash": "large_shopping_9d549ff6da", "mime": "image/png", "name": "large_shopping.png", "path": null, "size": 122.09, "width": 831, "height": 1000}, "small": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/small_shopping_9d549ff6da.png", "hash": "small_shopping_9d549ff6da", "mime": "image/png", "name": "small_shopping.png", "path": null, "size": 53.47, "width": 416, "height": 500}, "medium": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/medium_shopping_9d549ff6da.png", "hash": "medium_shopping_9d549ff6da", "mime": "image/png", "name": "medium_shopping.png", "path": null, "size": 84.79, "width": 623, "height": 750}, "thumbnail": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/thumbnail_shopping_9d549ff6da.png", "hash": "thumbnail_shopping_9d549ff6da", "mime": "image/png", "name": "thumbnail_shopping.png", "path": null, "size": 13.51, "width": 130, "height": 156}}	shopping_9d549ff6da	.png	image/png	47.10	https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/shopping_9d549ff6da.png	\N	aws-s3	\N	/1	2023-08-22 09:10:45.186	2023-08-22 09:10:45.186	7	7
14	200x120.png	\N	\N	200	120	\N	200x120_f508c72e8a	.png	image/png	0.37	https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/200x120_f508c72e8a.png	\N	aws-s3	\N	/1	2023-08-14 10:59:55.529	2023-08-16 09:46:53.952	7	7
59	Essay and Report.png	\N	\N	512	512	{"small": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/small_Essay_and_Report_fc1f43c7df.png", "hash": "small_Essay_and_Report_fc1f43c7df", "mime": "image/png", "name": "small_Essay and Report.png", "path": null, "size": 29.71, "width": 500, "height": 500}, "thumbnail": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/thumbnail_Essay_and_Report_fc1f43c7df.png", "hash": "thumbnail_Essay_and_Report_fc1f43c7df", "mime": "image/png", "name": "thumbnail_Essay and Report.png", "path": null, "size": 8.17, "width": 156, "height": 156}}	Essay_and_Report_fc1f43c7df	.png	image/png	4.63	https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/Essay_and_Report_fc1f43c7df.png	\N	aws-s3	\N	/1	2023-08-22 07:56:36.986	2023-08-22 08:17:35.671	7	7
95	Caption Suggestion.png	\N	\N	512	512	{"small": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/small_Caption_Suggestion_dda8996b50.png", "hash": "small_Caption_Suggestion_dda8996b50", "mime": "image/png", "name": "small_Caption Suggestion.png", "path": null, "size": 124.76, "width": 500, "height": 500}, "thumbnail": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/thumbnail_Caption_Suggestion_dda8996b50.png", "hash": "thumbnail_Caption_Suggestion_dda8996b50", "mime": "image/png", "name": "thumbnail_Caption Suggestion.png", "path": null, "size": 20.1, "width": 156, "height": 156}}	Caption_Suggestion_dda8996b50	.png	image/png	16.02	https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/Caption_Suggestion_dda8996b50.png	\N	aws-s3	\N	/1	2023-08-22 09:25:20.023	2023-08-22 09:25:20.023	7	7
99	Sentiment Analysis.png	\N	\N	860	600	{"small": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/small_Sentiment_Analysis_cb40f2a272.png", "hash": "small_Sentiment_Analysis_cb40f2a272", "mime": "image/png", "name": "small_Sentiment Analysis.png", "path": null, "size": 46.37, "width": 500, "height": 349}, "medium": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/medium_Sentiment_Analysis_cb40f2a272.png", "hash": "medium_Sentiment_Analysis_cb40f2a272", "mime": "image/png", "name": "medium_Sentiment Analysis.png", "path": null, "size": 77.19, "width": 750, "height": 523}, "thumbnail": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/thumbnail_Sentiment_Analysis_cb40f2a272.png", "hash": "thumbnail_Sentiment_Analysis_cb40f2a272", "mime": "image/png", "name": "thumbnail_Sentiment Analysis.png", "path": null, "size": 18.22, "width": 224, "height": 156}}	Sentiment_Analysis_cb40f2a272	.png	image/png	13.12	https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/Sentiment_Analysis_cb40f2a272.png	\N	aws-s3	\N	/1	2023-08-22 09:25:20.9	2023-08-22 09:25:20.9	7	7
100	Influencer.webp	\N	\N	600	450	{"small": {"ext": ".webp", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/small_Influencer_089691007a.webp", "hash": "small_Influencer_089691007a", "mime": "image/webp", "name": "small_Influencer.webp", "path": null, "size": 31.04, "width": 500, "height": 375}, "thumbnail": {"ext": ".webp", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/thumbnail_Influencer_089691007a.webp", "hash": "thumbnail_Influencer_089691007a", "mime": "image/webp", "name": "thumbnail_Influencer.webp", "path": null, "size": 9.62, "width": 208, "height": 156}}	Influencer_089691007a	.webp	image/webp	36.05	https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/Influencer_089691007a.webp	\N	aws-s3	\N	/1	2023-08-22 09:25:21.053	2023-08-22 09:25:21.053	7	7
101	Social Media.webp	\N	\N	1920	1920	{"large": {"ext": ".webp", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/large_Social_Media_46d3e7758c.webp", "hash": "large_Social_Media_46d3e7758c", "mime": "image/webp", "name": "large_Social Media.webp", "path": null, "size": 64.07, "width": 1000, "height": 1000}, "small": {"ext": ".webp", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/small_Social_Media_46d3e7758c.webp", "hash": "small_Social_Media_46d3e7758c", "mime": "image/webp", "name": "small_Social Media.webp", "path": null, "size": 29.44, "width": 500, "height": 500}, "medium": {"ext": ".webp", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/medium_Social_Media_46d3e7758c.webp", "hash": "medium_Social_Media_46d3e7758c", "mime": "image/webp", "name": "medium_Social Media.webp", "path": null, "size": 45.87, "width": 750, "height": 750}, "thumbnail": {"ext": ".webp", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/thumbnail_Social_Media_46d3e7758c.webp", "hash": "thumbnail_Social_Media_46d3e7758c", "mime": "image/webp", "name": "thumbnail_Social Media.webp", "path": null, "size": 7.71, "width": 156, "height": 156}}	Social_Media_46d3e7758c	.webp	image/webp	138.78	https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/Social_Media_46d3e7758c.webp	\N	aws-s3	\N	/1	2023-08-22 09:25:24.32	2023-08-22 09:25:24.32	7	7
98	Keyword Suggestion.png	\N	\N	512	512	{"small": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/small_Keyword_Suggestion_1df350d4d8.png", "hash": "small_Keyword_Suggestion_1df350d4d8", "mime": "image/png", "name": "small_Keyword Suggestion.png", "path": null, "size": 55.69, "width": 500, "height": 500}, "thumbnail": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/thumbnail_Keyword_Suggestion_1df350d4d8.png", "hash": "thumbnail_Keyword_Suggestion_1df350d4d8", "mime": "image/png", "name": "thumbnail_Keyword Suggestion.png", "path": null, "size": 14.35, "width": 156, "height": 156}}	Keyword_Suggestion_1df350d4d8	.png	image/png	7.83	https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/Keyword_Suggestion_1df350d4d8.png	\N	aws-s3	\N	/1	2023-08-22 09:25:20.611	2023-08-28 10:47:46.615	7	7
97	Copywriting.png	\N	\N	512	360	{"small": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/small_Copywriting_6ef84e3320.png", "hash": "small_Copywriting_6ef84e3320", "mime": "image/png", "name": "small_Copywriting.png", "path": null, "size": 88.64, "width": 500, "height": 352}, "thumbnail": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/thumbnail_Copywriting_6ef84e3320.png", "hash": "thumbnail_Copywriting_6ef84e3320", "mime": "image/png", "name": "thumbnail_Copywriting.png", "path": null, "size": 29.18, "width": 222, "height": 156}}	Copywriting_6ef84e3320	.png	image/png	20.82	https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/Copywriting_6ef84e3320.png	\N	aws-s3	\N	/1	2023-08-22 09:25:20.479	2023-09-14 09:32:24.795	7	20
15	BFSI_Playbook-2.jpg	\N	\N	4001	2250	{"large": {"ext": ".jpg", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/large_BFSI_Playbook_2_a3912120f5.jpg", "hash": "large_BFSI_Playbook_2_a3912120f5", "mime": "image/jpeg", "name": "large_BFSI_Playbook-2.jpg", "path": null, "size": 11.52, "width": 1000, "height": 563}, "small": {"ext": ".jpg", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/small_BFSI_Playbook_2_a3912120f5.jpg", "hash": "small_BFSI_Playbook_2_a3912120f5", "mime": "image/jpeg", "name": "small_BFSI_Playbook-2.jpg", "path": null, "size": 4.34, "width": 500, "height": 281}, "medium": {"ext": ".jpg", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/medium_BFSI_Playbook_2_a3912120f5.jpg", "hash": "medium_BFSI_Playbook_2_a3912120f5", "mime": "image/jpeg", "name": "medium_BFSI_Playbook-2.jpg", "path": null, "size": 7.15, "width": 750, "height": 422}, "thumbnail": {"ext": ".jpg", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/thumbnail_BFSI_Playbook_2_a3912120f5.jpg", "hash": "thumbnail_BFSI_Playbook_2_a3912120f5", "mime": "image/jpeg", "name": "thumbnail_BFSI_Playbook-2.jpg", "path": null, "size": 1.42, "width": 245, "height": 138}}	BFSI_Playbook_2_a3912120f5	.jpg	image/jpeg	95.92	https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/BFSI_Playbook_2_a3912120f5.jpg	\N	aws-s3	\N	/1	2023-08-14 11:36:28.57	2023-08-14 11:36:28.57	7	7
16	BFSI_Playbook-4.jpg	\N	\N	4001	2250	{"large": {"ext": ".jpg", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/large_BFSI_Playbook_4_5d5d40eac3.jpg", "hash": "large_BFSI_Playbook_4_5d5d40eac3", "mime": "image/jpeg", "name": "large_BFSI_Playbook-4.jpg", "path": null, "size": 24.94, "width": 1000, "height": 563}, "small": {"ext": ".jpg", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/small_BFSI_Playbook_4_5d5d40eac3.jpg", "hash": "small_BFSI_Playbook_4_5d5d40eac3", "mime": "image/jpeg", "name": "small_BFSI_Playbook-4.jpg", "path": null, "size": 9.54, "width": 500, "height": 281}, "medium": {"ext": ".jpg", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/medium_BFSI_Playbook_4_5d5d40eac3.jpg", "hash": "medium_BFSI_Playbook_4_5d5d40eac3", "mime": "image/jpeg", "name": "medium_BFSI_Playbook-4.jpg", "path": null, "size": 16.13, "width": 750, "height": 422}, "thumbnail": {"ext": ".jpg", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/thumbnail_BFSI_Playbook_4_5d5d40eac3.jpg", "hash": "thumbnail_BFSI_Playbook_4_5d5d40eac3", "mime": "image/jpeg", "name": "thumbnail_BFSI_Playbook-4.jpg", "path": null, "size": 3.48, "width": 245, "height": 138}}	BFSI_Playbook_4_5d5d40eac3	.jpg	image/jpeg	173.59	https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/BFSI_Playbook_4_5d5d40eac3.jpg	\N	aws-s3	\N	/1	2023-08-14 11:36:30.03	2023-08-14 11:36:30.03	7	7
17	BFSI_Playbook-5.jpg	\N	\N	4001	2250	{"large": {"ext": ".jpg", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/large_BFSI_Playbook_5_dfbc9a6022.jpg", "hash": "large_BFSI_Playbook_5_dfbc9a6022", "mime": "image/jpeg", "name": "large_BFSI_Playbook-5.jpg", "path": null, "size": 53.55, "width": 1000, "height": 563}, "small": {"ext": ".jpg", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/small_BFSI_Playbook_5_dfbc9a6022.jpg", "hash": "small_BFSI_Playbook_5_dfbc9a6022", "mime": "image/jpeg", "name": "small_BFSI_Playbook-5.jpg", "path": null, "size": 18.89, "width": 500, "height": 281}, "medium": {"ext": ".jpg", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/medium_BFSI_Playbook_5_dfbc9a6022.jpg", "hash": "medium_BFSI_Playbook_5_dfbc9a6022", "mime": "image/jpeg", "name": "medium_BFSI_Playbook-5.jpg", "path": null, "size": 34.65, "width": 750, "height": 422}, "thumbnail": {"ext": ".jpg", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/thumbnail_BFSI_Playbook_5_dfbc9a6022.jpg", "hash": "thumbnail_BFSI_Playbook_5_dfbc9a6022", "mime": "image/jpeg", "name": "thumbnail_BFSI_Playbook-5.jpg", "path": null, "size": 5.21, "width": 245, "height": 138}}	BFSI_Playbook_5_dfbc9a6022	.jpg	image/jpeg	360.55	https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/BFSI_Playbook_5_dfbc9a6022.jpg	\N	aws-s3	\N	/1	2023-08-14 11:36:31.256	2023-08-14 11:36:31.256	7	7
18	BFSI_Playbook-3.jpg	\N	\N	4001	2250	{"large": {"ext": ".jpg", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/large_BFSI_Playbook_3_3a0c2fd757.jpg", "hash": "large_BFSI_Playbook_3_3a0c2fd757", "mime": "image/jpeg", "name": "large_BFSI_Playbook-3.jpg", "path": null, "size": 72, "width": 1000, "height": 563}, "small": {"ext": ".jpg", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/small_BFSI_Playbook_3_3a0c2fd757.jpg", "hash": "small_BFSI_Playbook_3_3a0c2fd757", "mime": "image/jpeg", "name": "small_BFSI_Playbook-3.jpg", "path": null, "size": 23.99, "width": 500, "height": 281}, "medium": {"ext": ".jpg", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/medium_BFSI_Playbook_3_3a0c2fd757.jpg", "hash": "medium_BFSI_Playbook_3_3a0c2fd757", "mime": "image/jpeg", "name": "medium_BFSI_Playbook-3.jpg", "path": null, "size": 45.56, "width": 750, "height": 422}, "thumbnail": {"ext": ".jpg", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/thumbnail_BFSI_Playbook_3_3a0c2fd757.jpg", "hash": "thumbnail_BFSI_Playbook_3_3a0c2fd757", "mime": "image/jpeg", "name": "thumbnail_BFSI_Playbook-3.jpg", "path": null, "size": 7.23, "width": 245, "height": 138}}	BFSI_Playbook_3_3a0c2fd757	.jpg	image/jpeg	435.79	https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/BFSI_Playbook_3_3a0c2fd757.jpg	\N	aws-s3	\N	/1	2023-08-14 11:36:31.526	2023-08-14 11:36:31.526	7	7
19	BFSI_Playbook-1.jpg	\N	\N	4001	2250	{"large": {"ext": ".jpg", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/large_BFSI_Playbook_1_a16cee82f9.jpg", "hash": "large_BFSI_Playbook_1_a16cee82f9", "mime": "image/jpeg", "name": "large_BFSI_Playbook-1.jpg", "path": null, "size": 79.58, "width": 1000, "height": 563}, "small": {"ext": ".jpg", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/small_BFSI_Playbook_1_a16cee82f9.jpg", "hash": "small_BFSI_Playbook_1_a16cee82f9", "mime": "image/jpeg", "name": "small_BFSI_Playbook-1.jpg", "path": null, "size": 24.78, "width": 500, "height": 281}, "medium": {"ext": ".jpg", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/medium_BFSI_Playbook_1_a16cee82f9.jpg", "hash": "medium_BFSI_Playbook_1_a16cee82f9", "mime": "image/jpeg", "name": "medium_BFSI_Playbook-1.jpg", "path": null, "size": 47.65, "width": 750, "height": 422}, "thumbnail": {"ext": ".jpg", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/thumbnail_BFSI_Playbook_1_a16cee82f9.jpg", "hash": "thumbnail_BFSI_Playbook_1_a16cee82f9", "mime": "image/jpeg", "name": "thumbnail_BFSI_Playbook-1.jpg", "path": null, "size": 7.76, "width": 245, "height": 138}}	BFSI_Playbook_1_a16cee82f9	.jpg	image/jpeg	625.87	https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/BFSI_Playbook_1_a16cee82f9.jpg	\N	aws-s3	\N	/1	2023-08-14 11:36:31.611	2023-08-14 11:36:31.611	7	7
29	4.jpeg	\N	\N	1024	465	{"large": {"ext": ".jpeg", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/large_4_b62d2d5a8d.jpeg", "hash": "large_4_b62d2d5a8d", "mime": "image/jpeg", "name": "large_4.jpeg", "path": null, "size": 36.67, "width": 1000, "height": 454}, "small": {"ext": ".jpeg", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/small_4_b62d2d5a8d.jpeg", "hash": "small_4_b62d2d5a8d", "mime": "image/jpeg", "name": "small_4.jpeg", "path": null, "size": 14.56, "width": 500, "height": 227}, "medium": {"ext": ".jpeg", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/medium_4_b62d2d5a8d.jpeg", "hash": "medium_4_b62d2d5a8d", "mime": "image/jpeg", "name": "medium_4.jpeg", "path": null, "size": 24.9, "width": 750, "height": 341}, "thumbnail": {"ext": ".jpeg", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/thumbnail_4_b62d2d5a8d.jpeg", "hash": "thumbnail_4_b62d2d5a8d", "mime": "image/jpeg", "name": "thumbnail_4.jpeg", "path": null, "size": 5.46, "width": 245, "height": 111}}	4_b62d2d5a8d	.jpeg	image/jpeg	18.80	https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/4_b62d2d5a8d.jpeg	\N	aws-s3	\N	/1	2023-08-14 13:01:49.638	2023-08-14 13:01:49.638	7	7
28	3.webp	\N	\N	368	200	{"thumbnail": {"ext": ".webp", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/thumbnail_3_b3d96aee1a.webp", "hash": "thumbnail_3_b3d96aee1a", "mime": "image/webp", "name": "thumbnail_3.webp", "path": null, "size": 10.24, "width": 245, "height": 133}}	3_b3d96aee1a	.webp	image/webp	15.62	https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/3_b3d96aee1a.webp	\N	aws-s3	\N	/1	2023-08-14 13:01:49.097	2023-08-16 11:26:52.494	7	7
32	7.png	\N	\N	290	174	{"thumbnail": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/thumbnail_7_b2d70cc843.png", "hash": "thumbnail_7_b2d70cc843", "mime": "image/png", "name": "thumbnail_7.png", "path": null, "size": 21.25, "width": 245, "height": 147}}	7_b2d70cc843	.png	image/png	4.95	https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/7_b2d70cc843.png	\N	aws-s3	\N	/1	2023-08-14 13:01:49.938	2023-08-22 08:06:13.772	7	7
31	5.png	\N	\N	750	500	{"small": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/small_5_4a639eaaab.png", "hash": "small_5_4a639eaaab", "mime": "image/png", "name": "small_5.png", "path": null, "size": 58.7, "width": 500, "height": 333}, "thumbnail": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/thumbnail_5_4a639eaaab.png", "hash": "thumbnail_5_4a639eaaab", "mime": "image/png", "name": "thumbnail_5.png", "path": null, "size": 22.45, "width": 234, "height": 156}}	5_4a639eaaab	.png	image/png	16.97	https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/5_4a639eaaab.png	\N	aws-s3	\N	/1	2023-08-14 13:01:49.731	2023-08-22 08:06:22.234	7	7
65	Transaction Categorization.png	\N	\N	512	366	{"small": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/small_Transaction_Categorization_cf67ac82c2.png", "hash": "small_Transaction_Categorization_cf67ac82c2", "mime": "image/png", "name": "small_Transaction Categorization.png", "path": null, "size": 205.79, "width": 500, "height": 357}, "thumbnail": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/thumbnail_Transaction_Categorization_cf67ac82c2.png", "hash": "thumbnail_Transaction_Categorization_cf67ac82c2", "mime": "image/png", "name": "thumbnail_Transaction Categorization.png", "path": null, "size": 54.19, "width": 218, "height": 156}}	Transaction_Categorization_cf67ac82c2	.png	image/png	52.75	https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/Transaction_Categorization_cf67ac82c2.png	\N	aws-s3	\N	/1	2023-08-22 08:09:49.433	2023-08-22 08:09:49.433	7	7
66	Medical Record.png	\N	\N	512	512	{"small": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/small_Medical_Record_95d98eb585.png", "hash": "small_Medical_Record_95d98eb585", "mime": "image/png", "name": "small_Medical Record.png", "path": null, "size": 28.73, "width": 500, "height": 500}, "thumbnail": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/thumbnail_Medical_Record_95d98eb585.png", "hash": "thumbnail_Medical_Record_95d98eb585", "mime": "image/png", "name": "thumbnail_Medical Record.png", "path": null, "size": 7.77, "width": 156, "height": 156}}	Medical_Record_95d98eb585	.png	image/png	5.23	https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/Medical_Record_95d98eb585.png	\N	aws-s3	\N	/1	2023-08-22 08:11:57.023	2023-08-22 08:11:57.023	7	7
102	33bfd6d89a289ec7d37f06cd90b79109.png	\N	\N	512	512	{"small": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/small_33bfd6d89a289ec7d37f06cd90b79109_aeed51f654.png", "hash": "small_33bfd6d89a289ec7d37f06cd90b79109_aeed51f654", "mime": "image/png", "name": "small_33bfd6d89a289ec7d37f06cd90b79109.png", "path": null, "size": 99.9, "width": 500, "height": 500}, "thumbnail": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/thumbnail_33bfd6d89a289ec7d37f06cd90b79109_aeed51f654.png", "hash": "thumbnail_33bfd6d89a289ec7d37f06cd90b79109_aeed51f654", "mime": "image/png", "name": "thumbnail_33bfd6d89a289ec7d37f06cd90b79109.png", "path": null, "size": 20.11, "width": 156, "height": 156}}	33bfd6d89a289ec7d37f06cd90b79109_aeed51f654	.png	image/png	19.64	https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/33bfd6d89a289ec7d37f06cd90b79109_aeed51f654.png	\N	aws-s3	\N	/1	2023-08-22 11:09:52.377	2023-08-22 11:09:52.377	7	7
33	2.png	\N	\N	1900	1354	{"large": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/large_2_8ec7cdde4e.png", "hash": "large_2_8ec7cdde4e", "mime": "image/png", "name": "large_2.png", "path": null, "size": 346.28, "width": 1000, "height": 713}, "small": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/small_2_8ec7cdde4e.png", "hash": "small_2_8ec7cdde4e", "mime": "image/png", "name": "small_2.png", "path": null, "size": 98.58, "width": 500, "height": 356}, "medium": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/medium_2_8ec7cdde4e.png", "hash": "medium_2_8ec7cdde4e", "mime": "image/png", "name": "medium_2.png", "path": null, "size": 198.74, "width": 750, "height": 534}, "thumbnail": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/thumbnail_2_8ec7cdde4e.png", "hash": "thumbnail_2_8ec7cdde4e", "mime": "image/png", "name": "thumbnail_2.png", "path": null, "size": 30.76, "width": 219, "height": 156}}	2_8ec7cdde4e	.png	image/png	200.85	https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/2_8ec7cdde4e.png	\N	aws-s3	\N	/1	2023-08-14 13:01:51.749	2023-08-14 13:02:32.361	7	7
34	7.png	\N	\N	290	174	{"thumbnail": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/thumbnail_7_2e57f80519.png", "hash": "thumbnail_7_2e57f80519", "mime": "image/png", "name": "thumbnail_7.png", "path": null, "size": 21.25, "width": 245, "height": 147}}	7_2e57f80519	.png	image/png	4.95	https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/7_2e57f80519.png	\N	aws-s3	\N	/1	2023-08-14 13:06:55.827	2023-08-14 13:06:55.827	7	7
40	12.png	\N	\N	1200	628	{"large": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/large_12_194ee95e6a.png", "hash": "large_12_194ee95e6a", "mime": "image/png", "name": "large_12.png", "path": null, "size": 157.12, "width": 1000, "height": 523}, "small": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/small_12_194ee95e6a.png", "hash": "small_12_194ee95e6a", "mime": "image/png", "name": "small_12.png", "path": null, "size": 57.85, "width": 500, "height": 262}, "medium": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/medium_12_194ee95e6a.png", "hash": "medium_12_194ee95e6a", "mime": "image/png", "name": "medium_12.png", "path": null, "size": 101.76, "width": 750, "height": 393}, "thumbnail": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/thumbnail_12_194ee95e6a.png", "hash": "thumbnail_12_194ee95e6a", "mime": "image/png", "name": "thumbnail_12.png", "path": null, "size": 20.66, "width": 245, "height": 128}}	12_194ee95e6a	.png	image/png	30.60	https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/12_194ee95e6a.png	\N	aws-s3	\N	/1	2023-08-16 10:53:52.125	2023-08-28 10:59:22.162	7	7
36	9.png	\N	\N	1200	630	{"large": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/large_9_dada50badb.png", "hash": "large_9_dada50badb", "mime": "image/png", "name": "large_9.png", "path": null, "size": 63.75, "width": 1000, "height": 525}, "small": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/small_9_dada50badb.png", "hash": "small_9_dada50badb", "mime": "image/png", "name": "small_9.png", "path": null, "size": 28.65, "width": 500, "height": 263}, "medium": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/medium_9_dada50badb.png", "hash": "medium_9_dada50badb", "mime": "image/png", "name": "medium_9.png", "path": null, "size": 44.32, "width": 750, "height": 394}, "thumbnail": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/thumbnail_9_dada50badb.png", "hash": "thumbnail_9_dada50badb", "mime": "image/png", "name": "thumbnail_9.png", "path": null, "size": 13.1, "width": 245, "height": 129}}	9_dada50badb	.png	image/png	13.96	https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/9_dada50badb.png	\N	aws-s3	\N	/1	2023-08-14 13:06:57.938	2023-08-14 13:06:57.938	7	7
38	6.png	\N	\N	1200	630	{"large": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/large_6_573b002f45.png", "hash": "large_6_573b002f45", "mime": "image/png", "name": "large_6.png", "path": null, "size": 39.08, "width": 1000, "height": 525}, "small": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/small_6_573b002f45.png", "hash": "small_6_573b002f45", "mime": "image/png", "name": "small_6.png", "path": null, "size": 16.92, "width": 500, "height": 263}, "medium": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/medium_6_573b002f45.png", "hash": "medium_6_573b002f45", "mime": "image/png", "name": "medium_6.png", "path": null, "size": 26.87, "width": 750, "height": 394}, "thumbnail": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/thumbnail_6_573b002f45.png", "hash": "thumbnail_6_573b002f45", "mime": "image/png", "name": "thumbnail_6.png", "path": null, "size": 7.55, "width": 245, "height": 129}}	6_573b002f45	.png	image/png	10.83	https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/6_573b002f45.png	\N	aws-s3	\N	/1	2023-08-14 13:09:03.648	2023-08-14 13:09:03.648	7	7
37	8.png	\N	\N	1200	630	{"large": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/large_8_a70bf27b6c.png", "hash": "large_8_a70bf27b6c", "mime": "image/png", "name": "large_8.png", "path": null, "size": 79.33, "width": 1000, "height": 525}, "small": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/small_8_a70bf27b6c.png", "hash": "small_8_a70bf27b6c", "mime": "image/png", "name": "small_8.png", "path": null, "size": 33.81, "width": 500, "height": 263}, "medium": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/medium_8_a70bf27b6c.png", "hash": "medium_8_a70bf27b6c", "mime": "image/png", "name": "medium_8.png", "path": null, "size": 54.37, "width": 750, "height": 394}, "thumbnail": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/thumbnail_8_a70bf27b6c.png", "hash": "thumbnail_8_a70bf27b6c", "mime": "image/png", "name": "thumbnail_8.png", "path": null, "size": 14.15, "width": 245, "height": 129}}	8_a70bf27b6c	.png	image/png	16.05	https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/8_a70bf27b6c.png	\N	aws-s3	\N	/1	2023-08-14 13:06:58.088	2023-08-16 07:31:13.851	7	7
39	13.png	\N	\N	360	360	{"thumbnail": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/thumbnail_13_5b0c0ecc64.png", "hash": "thumbnail_13_5b0c0ecc64", "mime": "image/png", "name": "thumbnail_13.png", "path": null, "size": 25.21, "width": 156, "height": 156}}	13_5b0c0ecc64	.png	image/png	25.04	https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/13_5b0c0ecc64.png	\N	aws-s3	\N	/1	2023-08-16 10:53:50.521	2023-08-16 10:53:50.521	7	7
60	Auto Language Translation.png	\N	\N	512	512	{"small": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/small_Auto_Language_Translation_b14119b209.png", "hash": "small_Auto_Language_Translation_b14119b209", "mime": "image/png", "name": "small_Auto Language Translation.png", "path": null, "size": 78.3, "width": 500, "height": 500}, "thumbnail": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/thumbnail_Auto_Language_Translation_b14119b209.png", "hash": "thumbnail_Auto_Language_Translation_b14119b209", "mime": "image/png", "name": "thumbnail_Auto Language Translation.png", "path": null, "size": 19.22, "width": 156, "height": 156}}	Auto_Language_Translation_b14119b209	.png	image/png	11.30	https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/Auto_Language_Translation_b14119b209.png	\N	aws-s3	\N	/1	2023-08-22 07:58:57.97	2023-10-03 10:36:11.355	7	20
42	15.png	\N	\N	530	382	{"small": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/small_15_f6f9ddf005.png", "hash": "small_15_f6f9ddf005", "mime": "image/png", "name": "small_15.png", "path": null, "size": 77.54, "width": 500, "height": 360}, "thumbnail": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/thumbnail_15_f6f9ddf005.png", "hash": "thumbnail_15_f6f9ddf005", "mime": "image/png", "name": "thumbnail_15.png", "path": null, "size": 28.89, "width": 216, "height": 156}}	15_f6f9ddf005	.png	image/png	11.24	https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/15_f6f9ddf005.png	\N	aws-s3	\N	/1	2023-08-16 10:57:26.935	2023-08-16 10:57:26.935	7	7
41	14.png	\N	\N	1064	1064	{"large": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/large_14_e14817f2a4.png", "hash": "large_14_e14817f2a4", "mime": "image/png", "name": "large_14.png", "path": null, "size": 225.46, "width": 1000, "height": 1000}, "small": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/small_14_e14817f2a4.png", "hash": "small_14_e14817f2a4", "mime": "image/png", "name": "small_14.png", "path": null, "size": 95.4, "width": 500, "height": 500}, "medium": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/medium_14_e14817f2a4.png", "hash": "medium_14_e14817f2a4", "mime": "image/png", "name": "medium_14.png", "path": null, "size": 157.94, "width": 750, "height": 750}, "thumbnail": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/thumbnail_14_e14817f2a4.png", "hash": "thumbnail_14_e14817f2a4", "mime": "image/png", "name": "thumbnail_14.png", "path": null, "size": 25.63, "width": 156, "height": 156}}	14_e14817f2a4	.png	image/png	25.19	https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/14_e14817f2a4.png	\N	aws-s3	\N	/1	2023-08-16 10:53:52.571	2023-08-28 10:48:15.823	7	7
43	17.png	\N	\N	360	360	{"thumbnail": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/thumbnail_17_d47a347047.png", "hash": "thumbnail_17_d47a347047", "mime": "image/png", "name": "thumbnail_17.png", "path": null, "size": 23.44, "width": 156, "height": 156}}	17_d47a347047	.png	image/png	14.30	https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/17_d47a347047.png	\N	aws-s3	\N	/1	2023-08-16 11:19:40.946	2023-08-16 11:20:12.531	7	7
45	19.png	\N	\N	500	500	{"thumbnail": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/thumbnail_19_56abf0ff91.png", "hash": "thumbnail_19_56abf0ff91", "mime": "image/png", "name": "thumbnail_19.png", "path": null, "size": 16.99, "width": 156, "height": 156}}	19_56abf0ff91	.png	image/png	11.35	https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/19_56abf0ff91.png	\N	aws-s3	\N	/1	2023-08-16 11:24:20.182	2023-08-16 11:24:20.182	7	7
48	tce.png	\N	\N	500	262	{"thumbnail": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/thumbnail_tce_906aea5441.png", "hash": "thumbnail_tce_906aea5441", "mime": "image/png", "name": "thumbnail_tce.png", "path": null, "size": 36.18, "width": 245, "height": 128}}	tce_906aea5441	.png	image/png	27.36	https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/tce_906aea5441.png	\N	aws-s3	\N	/1	2023-08-22 07:11:58.381	2023-08-22 07:11:58.381	7	7
51	Health_Tip.png	\N	\N	360	360	{"thumbnail": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/thumbnail_Health_Tip_22b81b1f76.png", "hash": "thumbnail_Health_Tip_22b81b1f76", "mime": "image/png", "name": "thumbnail_Health_Tip.png", "path": null, "size": 16.88, "width": 156, "height": 156}}	Health_Tip_22b81b1f76	.png	image/png	10.50	https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/Health_Tip_22b81b1f76.png	\N	aws-s3	\N	/1	2023-08-22 07:21:55.41	2023-08-22 07:21:55.41	7	7
67	Diagnosis.png	\N	\N	512	512	{"small": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/small_Diagnosis_c6e35cbc81.png", "hash": "small_Diagnosis_c6e35cbc81", "mime": "image/png", "name": "small_Diagnosis.png", "path": null, "size": 35.54, "width": 500, "height": 500}, "thumbnail": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/thumbnail_Diagnosis_c6e35cbc81.png", "hash": "thumbnail_Diagnosis_c6e35cbc81", "mime": "image/png", "name": "thumbnail_Diagnosis.png", "path": null, "size": 9.47, "width": 156, "height": 156}}	Diagnosis_c6e35cbc81	.png	image/png	5.56	https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/Diagnosis_c6e35cbc81.png	\N	aws-s3	\N	/1	2023-08-22 08:12:43.785	2023-08-22 08:12:43.785	7	7
53	Study Material Summaries_1.png	\N	\N	1920	1810	{"large": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/large_Study_Material_Summaries_1_f2c9d47913.png", "hash": "large_Study_Material_Summaries_1_f2c9d47913", "mime": "image/png", "name": "large_Study Material Summaries_1.png", "path": null, "size": 192.75, "width": 1000, "height": 943}, "small": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/small_Study_Material_Summaries_1_f2c9d47913.png", "hash": "small_Study_Material_Summaries_1_f2c9d47913", "mime": "image/png", "name": "small_Study Material Summaries_1.png", "path": null, "size": 78.39, "width": 500, "height": 471}, "medium": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/medium_Study_Material_Summaries_1_f2c9d47913.png", "hash": "medium_Study_Material_Summaries_1_f2c9d47913", "mime": "image/png", "name": "medium_Study Material Summaries_1.png", "path": null, "size": 135.51, "width": 750, "height": 707}, "thumbnail": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/thumbnail_Study_Material_Summaries_1_f2c9d47913.png", "hash": "thumbnail_Study_Material_Summaries_1_f2c9d47913", "mime": "image/png", "name": "thumbnail_Study Material Summaries_1.png", "path": null, "size": 21.39, "width": 165, "height": 156}}	Study_Material_Summaries_1_f2c9d47913	.png	image/png	69.22	https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/Study_Material_Summaries_1_f2c9d47913.png	\N	aws-s3	\N	/1	2023-08-22 07:43:26.145	2023-08-22 07:43:26.145	7	7
54	News Article.png	\N	\N	360	360	{"thumbnail": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/thumbnail_News_Article_c651123dc9.png", "hash": "thumbnail_News_Article_c651123dc9", "mime": "image/png", "name": "thumbnail_News Article.png", "path": null, "size": 10.31, "width": 156, "height": 156}}	News_Article_c651123dc9	.png	image/png	3.98	https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/News_Article_c651123dc9.png	\N	aws-s3	\N	/1	2023-08-22 07:45:05.081	2023-08-22 07:45:05.081	7	7
57	Claim Document .png	\N	\N	808	508	{"small": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/small_Claim_Document_239a2f76c0.png", "hash": "small_Claim_Document_239a2f76c0", "mime": "image/png", "name": "small_Claim Document .png", "path": null, "size": 54.24, "width": 500, "height": 314}, "medium": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/medium_Claim_Document_239a2f76c0.png", "hash": "medium_Claim_Document_239a2f76c0", "mime": "image/png", "name": "medium_Claim Document .png", "path": null, "size": 93.74, "width": 750, "height": 472}, "thumbnail": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/thumbnail_Claim_Document_239a2f76c0.png", "hash": "thumbnail_Claim_Document_239a2f76c0", "mime": "image/png", "name": "thumbnail_Claim Document .png", "path": null, "size": 20.87, "width": 245, "height": 154}}	Claim_Document_239a2f76c0	.png	image/png	17.36	https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/Claim_Document_239a2f76c0.png	\N	aws-s3	\N	/1	2023-08-22 07:51:50.872	2023-08-22 07:51:50.872	7	7
58	Foreign Account.png	\N	\N	512	512	{"small": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/small_Foreign_Account_b367e454a6.png", "hash": "small_Foreign_Account_b367e454a6", "mime": "image/png", "name": "small_Foreign Account.png", "path": null, "size": 42.84, "width": 500, "height": 500}, "thumbnail": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/thumbnail_Foreign_Account_b367e454a6.png", "hash": "thumbnail_Foreign_Account_b367e454a6", "mime": "image/png", "name": "thumbnail_Foreign Account.png", "path": null, "size": 11.53, "width": 156, "height": 156}}	Foreign_Account_b367e454a6	.png	image/png	6.66	https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/Foreign_Account_b367e454a6.png	\N	aws-s3	\N	/1	2023-08-22 07:53:42.406	2023-08-22 07:53:42.406	7	7
55	2784530.png	\N	\N	512	512	{"small": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/small_2784530_0d670b34cf.png", "hash": "small_2784530_0d670b34cf", "mime": "image/png", "name": "small_2784530.png", "path": null, "size": 45.76, "width": 500, "height": 500}, "thumbnail": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/thumbnail_2784530_0d670b34cf.png", "hash": "thumbnail_2784530_0d670b34cf", "mime": "image/png", "name": "thumbnail_2784530.png", "path": null, "size": 11.37, "width": 156, "height": 156}}	2784530_0d670b34cf	.png	image/png	7.06	https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/2784530_0d670b34cf.png	\N	aws-s3	\N	/1	2023-08-22 07:46:23.782	2023-08-22 08:22:10.56	7	7
56	Q&A.png	\N	\N	1826	836	{"large": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/large_Q_and_A_a7f7d93cea.png", "hash": "large_Q_and_A_a7f7d93cea", "mime": "image/png", "name": "large_Q&A.png", "path": null, "size": 171.71, "width": 1000, "height": 458}, "small": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/small_Q_and_A_a7f7d93cea.png", "hash": "small_Q_and_A_a7f7d93cea", "mime": "image/png", "name": "small_Q&A.png", "path": null, "size": 68.57, "width": 500, "height": 229}, "medium": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/medium_Q_and_A_a7f7d93cea.png", "hash": "medium_Q_and_A_a7f7d93cea", "mime": "image/png", "name": "medium_Q&A.png", "path": null, "size": 118.19, "width": 750, "height": 343}, "thumbnail": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/thumbnail_Q_and_A_a7f7d93cea.png", "hash": "thumbnail_Q_and_A_a7f7d93cea", "mime": "image/png", "name": "thumbnail_Q&A.png", "path": null, "size": 29.06, "width": 245, "height": 112}}	Q_and_A_a7f7d93cea	.png	image/png	53.13	https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/Q_and_A_a7f7d93cea.png	\N	aws-s3	\N	/1	2023-08-22 07:50:19.875	2023-08-22 08:00:27.867	7	7
61	Learning.png	\N	\N	840	968	{"small": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/small_Learning_75101e9164.png", "hash": "small_Learning_75101e9164", "mime": "image/png", "name": "small_Learning.png", "path": null, "size": 64.2, "width": 434, "height": 500}, "medium": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/medium_Learning_75101e9164.png", "hash": "medium_Learning_75101e9164", "mime": "image/png", "name": "medium_Learning.png", "path": null, "size": 124.48, "width": 651, "height": 750}, "thumbnail": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/thumbnail_Learning_75101e9164.png", "hash": "thumbnail_Learning_75101e9164", "mime": "image/png", "name": "thumbnail_Learning.png", "path": null, "size": 14.01, "width": 135, "height": 156}}	Learning_75101e9164	.png	image/png	34.28	https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/Learning_75101e9164.png	\N	aws-s3	\N	/1	2023-08-22 08:01:20.693	2023-08-22 08:01:20.693	7	7
62	Learning-Transparent-PNG.png	\N	\N	1225	1300	{"large": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/large_Learning_Transparent_PNG_eb44a17156.png", "hash": "large_Learning_Transparent_PNG_eb44a17156", "mime": "image/png", "name": "large_Learning-Transparent-PNG.png", "path": null, "size": 514.73, "width": 942, "height": 1000}, "small": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/small_Learning_Transparent_PNG_eb44a17156.png", "hash": "small_Learning_Transparent_PNG_eb44a17156", "mime": "image/png", "name": "small_Learning-Transparent-PNG.png", "path": null, "size": 172.41, "width": 471, "height": 500}, "medium": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/medium_Learning_Transparent_PNG_eb44a17156.png", "hash": "medium_Learning_Transparent_PNG_eb44a17156", "mime": "image/png", "name": "medium_Learning-Transparent-PNG.png", "path": null, "size": 321.2, "width": 707, "height": 750}, "thumbnail": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/thumbnail_Learning_Transparent_PNG_eb44a17156.png", "hash": "thumbnail_Learning_Transparent_PNG_eb44a17156", "mime": "image/png", "name": "thumbnail_Learning-Transparent-PNG.png", "path": null, "size": 32.95, "width": 147, "height": 156}}	Learning_Transparent_PNG_eb44a17156	.png	image/png	115.05	https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/Learning_Transparent_PNG_eb44a17156.png	\N	aws-s3	\N	/1	2023-08-22 08:02:54.078	2023-08-22 08:02:54.078	7	7
63	Training.png	\N	\N	1080	1080	{"large": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/large_Training_762f2e0aea.png", "hash": "large_Training_762f2e0aea", "mime": "image/png", "name": "large_Training.png", "path": null, "size": 245.81, "width": 1000, "height": 1000}, "small": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/small_Training_762f2e0aea.png", "hash": "small_Training_762f2e0aea", "mime": "image/png", "name": "small_Training.png", "path": null, "size": 98.88, "width": 500, "height": 500}, "medium": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/medium_Training_762f2e0aea.png", "hash": "medium_Training_762f2e0aea", "mime": "image/png", "name": "medium_Training.png", "path": null, "size": 168.86, "width": 750, "height": 750}, "thumbnail": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/thumbnail_Training_762f2e0aea.png", "hash": "thumbnail_Training_762f2e0aea", "mime": "image/png", "name": "thumbnail_Training.png", "path": null, "size": 22.65, "width": 156, "height": 156}}	Training_762f2e0aea	.png	image/png	41.16	https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/Training_762f2e0aea.png	\N	aws-s3	\N	/1	2023-08-22 08:05:18.952	2023-08-22 08:05:18.952	7	7
64	AI-Generated Practice Questions.webp	\N	\N	635	685	{"small": {"ext": ".webp", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/small_AI_Generated_Practice_Questions_aaa525768b.webp", "hash": "small_AI_Generated_Practice_Questions_aaa525768b", "mime": "image/webp", "name": "small_AI-Generated Practice Questions.webp", "path": null, "size": 19.19, "width": 464, "height": 500}, "thumbnail": {"ext": ".webp", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/thumbnail_AI_Generated_Practice_Questions_aaa525768b.webp", "hash": "thumbnail_AI_Generated_Practice_Questions_aaa525768b", "mime": "image/webp", "name": "thumbnail_AI-Generated Practice Questions.webp", "path": null, "size": 5, "width": 145, "height": 156}}	AI_Generated_Practice_Questions_aaa525768b	.webp	image/webp	20.53	https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/AI_Generated_Practice_Questions_aaa525768b.webp	\N	aws-s3	\N	/1	2023-08-22 08:05:19.029	2023-08-22 08:05:19.029	7	7
69	Symptom.png	\N	\N	511	476	{"small": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/small_Symptom_de10f60be5.png", "hash": "small_Symptom_de10f60be5", "mime": "image/png", "name": "small_Symptom.png", "path": null, "size": 101.58, "width": 500, "height": 466}, "thumbnail": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/thumbnail_Symptom_de10f60be5.png", "hash": "thumbnail_Symptom_de10f60be5", "mime": "image/png", "name": "thumbnail_Symptom.png", "path": null, "size": 22.41, "width": 167, "height": 156}}	Symptom_de10f60be5	.png	image/png	17.94	https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/Symptom_de10f60be5.png	\N	aws-s3	\N	/1	2023-08-22 08:15:41.669	2023-08-22 08:15:41.669	7	7
71	Coverage.png	\N	\N	598	335	{"small": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/small_Coverage_0f1b4fcbca.png", "hash": "small_Coverage_0f1b4fcbca", "mime": "image/png", "name": "small_Coverage.png", "path": null, "size": 66.08, "width": 500, "height": 280}, "thumbnail": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/thumbnail_Coverage_0f1b4fcbca.png", "hash": "thumbnail_Coverage_0f1b4fcbca", "mime": "image/png", "name": "thumbnail_Coverage.png", "path": null, "size": 25.07, "width": 245, "height": 137}}	Coverage_0f1b4fcbca	.png	image/png	14.51	https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/Coverage_0f1b4fcbca.png	\N	aws-s3	\N	/1	2023-08-22 08:27:08.191	2023-08-22 08:27:08.191	7	7
72	Insurance Summary.png	\N	\N	512	512	{"small": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/small_Insurance_Summary_cd05e897c3.png", "hash": "small_Insurance_Summary_cd05e897c3", "mime": "image/png", "name": "small_Insurance Summary.png", "path": null, "size": 42.95, "width": 500, "height": 500}, "thumbnail": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/thumbnail_Insurance_Summary_cd05e897c3.png", "hash": "thumbnail_Insurance_Summary_cd05e897c3", "mime": "image/png", "name": "thumbnail_Insurance Summary.png", "path": null, "size": 11.41, "width": 156, "height": 156}}	Insurance_Summary_cd05e897c3	.png	image/png	6.48	https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/Insurance_Summary_cd05e897c3.png	\N	aws-s3	\N	/1	2023-08-22 08:28:10.225	2023-08-22 08:28:10.225	7	7
73	Claim Settlement.png	\N	\N	512	512	{"small": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/small_Claim_Settlement_6763a90cac.png", "hash": "small_Claim_Settlement_6763a90cac", "mime": "image/png", "name": "small_Claim Settlement.png", "path": null, "size": 54.61, "width": 500, "height": 500}, "thumbnail": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/thumbnail_Claim_Settlement_6763a90cac.png", "hash": "thumbnail_Claim_Settlement_6763a90cac", "mime": "image/png", "name": "thumbnail_Claim Settlement.png", "path": null, "size": 14.22, "width": 156, "height": 156}}	Claim_Settlement_6763a90cac	.png	image/png	8.48	https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/Claim_Settlement_6763a90cac.png	\N	aws-s3	\N	/1	2023-08-22 08:29:40.864	2023-08-22 08:29:40.864	7	7
75	Video Script.png	\N	\N	512	512	{"small": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/small_Video_Script_0133cf9648.png", "hash": "small_Video_Script_0133cf9648", "mime": "image/png", "name": "small_Video Script.png", "path": null, "size": 20.14, "width": 500, "height": 500}, "thumbnail": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/thumbnail_Video_Script_0133cf9648.png", "hash": "thumbnail_Video_Script_0133cf9648", "mime": "image/png", "name": "thumbnail_Video Script.png", "path": null, "size": 5.76, "width": 156, "height": 156}}	Video_Script_0133cf9648	.png	image/png	4.04	https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/Video_Script_0133cf9648.png	\N	aws-s3	\N	/1	2023-08-22 08:32:50.41	2023-08-22 08:32:50.41	7	7
76	Personalized Short Videos.png	\N	\N	512	512	{"small": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/small_Personalized_Short_Videos_a2545eaa63.png", "hash": "small_Personalized_Short_Videos_a2545eaa63", "mime": "image/png", "name": "small_Personalized Short Videos.png", "path": null, "size": 31.11, "width": 500, "height": 500}, "thumbnail": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/thumbnail_Personalized_Short_Videos_a2545eaa63.png", "hash": "thumbnail_Personalized_Short_Videos_a2545eaa63", "mime": "image/png", "name": "thumbnail_Personalized Short Videos.png", "path": null, "size": 9.97, "width": 156, "height": 156}}	Personalized_Short_Videos_a2545eaa63	.png	image/png	4.78	https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/Personalized_Short_Videos_a2545eaa63.png	\N	aws-s3	\N	/1	2023-08-22 08:35:26.197	2023-08-22 08:35:26.197	7	7
77	Video Search.png	\N	\N	1908	1920	{"large": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/large_Video_Search_8e54adff44.png", "hash": "large_Video_Search_8e54adff44", "mime": "image/png", "name": "large_Video Search.png", "path": null, "size": 243.85, "width": 994, "height": 1000}, "small": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/small_Video_Search_8e54adff44.png", "hash": "small_Video_Search_8e54adff44", "mime": "image/png", "name": "small_Video Search.png", "path": null, "size": 59.47, "width": 497, "height": 500}, "medium": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/medium_Video_Search_8e54adff44.png", "hash": "medium_Video_Search_8e54adff44", "mime": "image/png", "name": "medium_Video Search.png", "path": null, "size": 131.11, "width": 745, "height": 750}, "thumbnail": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/thumbnail_Video_Search_8e54adff44.png", "hash": "thumbnail_Video_Search_8e54adff44", "mime": "image/png", "name": "thumbnail_Video Search.png", "path": null, "size": 13.58, "width": 155, "height": 156}}	Video_Search_8e54adff44	.png	image/png	133.69	https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/Video_Search_8e54adff44.png	\N	aws-s3	\N	/1	2023-08-22 08:40:02.487	2023-08-22 08:40:02.487	7	7
78	Concierge Services.png	\N	\N	512	512	{"small": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/small_Concierge_Services_0d26eb9dfc.png", "hash": "small_Concierge_Services_0d26eb9dfc", "mime": "image/png", "name": "small_Concierge Services.png", "path": null, "size": 34.94, "width": 500, "height": 500}, "thumbnail": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/thumbnail_Concierge_Services_0d26eb9dfc.png", "hash": "thumbnail_Concierge_Services_0d26eb9dfc", "mime": "image/png", "name": "thumbnail_Concierge Services.png", "path": null, "size": 9.83, "width": 156, "height": 156}}	Concierge_Services_0d26eb9dfc	.png	image/png	5.68	https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/Concierge_Services_0d26eb9dfc.png	\N	aws-s3	\N	/1	2023-08-22 08:48:29.68	2023-08-22 08:48:29.68	7	7
79	Guest Feedback Analysis.png	\N	\N	366	360	{"thumbnail": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/thumbnail_Guest_Feedback_Analysis_99ad18bbf3.png", "hash": "thumbnail_Guest_Feedback_Analysis_99ad18bbf3", "mime": "image/png", "name": "thumbnail_Guest Feedback Analysis.png", "path": null, "size": 24.81, "width": 159, "height": 156}}	Guest_Feedback_Analysis_99ad18bbf3	.png	image/png	19.15	https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/Guest_Feedback_Analysis_99ad18bbf3.png	\N	aws-s3	\N	/1	2023-08-22 08:48:30.372	2023-08-22 08:48:30.372	7	7
80	Menus and Recipes.png	\N	\N	320	273	{"thumbnail": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/thumbnail_Menus_and_Recipes_e435f28fa7.png", "hash": "thumbnail_Menus_and_Recipes_e435f28fa7", "mime": "image/png", "name": "thumbnail_Menus and Recipes.png", "path": null, "size": 41.8, "width": 183, "height": 156}}	Menus_and_Recipes_e435f28fa7	.png	image/png	13.52	https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/Menus_and_Recipes_e435f28fa7.png	\N	aws-s3	\N	/1	2023-08-22 08:48:30.575	2023-08-22 08:48:30.575	7	7
82	Improving Experiences.png	\N	\N	960	960	{"small": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/small_Improving_Experiences_2bf1defa06.png", "hash": "small_Improving_Experiences_2bf1defa06", "mime": "image/png", "name": "small_Improving Experiences.png", "path": null, "size": 65.94, "width": 500, "height": 500}, "medium": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/medium_Improving_Experiences_2bf1defa06.png", "hash": "medium_Improving_Experiences_2bf1defa06", "mime": "image/png", "name": "medium_Improving Experiences.png", "path": null, "size": 117.2, "width": 750, "height": 750}, "thumbnail": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/thumbnail_Improving_Experiences_2bf1defa06.png", "hash": "thumbnail_Improving_Experiences_2bf1defa06", "mime": "image/png", "name": "thumbnail_Improving Experiences.png", "path": null, "size": 15.93, "width": 156, "height": 156}}	Improving_Experiences_2bf1defa06	.png	image/png	25.69	https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/Improving_Experiences_2bf1defa06.png	\N	aws-s3	\N	/1	2023-08-22 08:48:32.024	2023-08-22 08:48:32.024	7	7
83	Email Responder.png	\N	\N	1440	748	{"large": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/large_Email_Responder_903335d10d.png", "hash": "large_Email_Responder_903335d10d", "mime": "image/png", "name": "large_Email Responder.png", "path": null, "size": 164.22, "width": 1000, "height": 519}, "small": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/small_Email_Responder_903335d10d.png", "hash": "small_Email_Responder_903335d10d", "mime": "image/png", "name": "small_Email Responder.png", "path": null, "size": 58.42, "width": 500, "height": 260}, "medium": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/medium_Email_Responder_903335d10d.png", "hash": "medium_Email_Responder_903335d10d", "mime": "image/png", "name": "medium_Email Responder.png", "path": null, "size": 103.92, "width": 750, "height": 390}, "thumbnail": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/thumbnail_Email_Responder_903335d10d.png", "hash": "thumbnail_Email_Responder_903335d10d", "mime": "image/png", "name": "thumbnail_Email Responder.png", "path": null, "size": 23.25, "width": 245, "height": 127}}	Email_Responder_903335d10d	.png	image/png	34.89	https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/Email_Responder_903335d10d.png	\N	aws-s3	\N	/1	2023-08-22 08:48:32.083	2023-08-22 08:48:32.083	7	7
84	Room Customization.png	\N	\N	512	512	{"small": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/small_Room_Customization_138ac8fc9d.png", "hash": "small_Room_Customization_138ac8fc9d", "mime": "image/png", "name": "small_Room Customization.png", "path": null, "size": 29.39, "width": 500, "height": 500}, "thumbnail": {"ext": ".png", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/thumbnail_Room_Customization_138ac8fc9d.png", "hash": "thumbnail_Room_Customization_138ac8fc9d", "mime": "image/png", "name": "thumbnail_Room Customization.png", "path": null, "size": 8.55, "width": 156, "height": 156}}	Room_Customization_138ac8fc9d	.png	image/png	4.42	https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/Room_Customization_138ac8fc9d.png	\N	aws-s3	\N	/1	2023-08-22 08:48:32.099	2023-08-22 08:48:32.099	7	7
81	Event Planning.webp	\N	\N	510	322	{"small": {"ext": ".webp", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/small_Event_Planning_dad80cffbf.webp", "hash": "small_Event_Planning_dad80cffbf", "mime": "image/webp", "name": "small_Event Planning.webp", "path": null, "size": 22.44, "width": 500, "height": 316}, "thumbnail": {"ext": ".webp", "url": "https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/thumbnail_Event_Planning_dad80cffbf.webp", "hash": "thumbnail_Event_Planning_dad80cffbf", "mime": "image/webp", "name": "thumbnail_Event Planning.webp", "path": null, "size": 9.7, "width": 245, "height": 155}}	Event_Planning_dad80cffbf	.webp	image/webp	20.36	https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/Event_Planning_dad80cffbf.webp	\N	aws-s3	\N	/1	2023-08-22 08:48:30.577	2023-08-22 08:49:48.375	7	7
\.


--
-- Data for Name: files_folder_links; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.files_folder_links (id, file_id, folder_id, file_order) FROM stdin;
1	14	1	1
5	15	1	2
6	16	1	3
7	17	1	4
8	18	1	5
9	19	1	6
17	28	1	8
18	29	1	9
20	31	1	10
21	32	1	11
22	33	1	12
25	34	1	13
27	36	1	15
28	37	1	16
29	38	1	17
35	39	1	18
36	40	1	19
37	41	1	20
38	42	1	21
39	43	1	22
43	45	1	24
48	48	1	27
49	49	1	28
52	51	1	29
54	53	1	30
55	54	1	31
56	55	1	32
57	56	1	33
58	57	1	34
59	58	1	35
60	59	1	36
61	60	1	37
63	61	1	38
64	62	1	39
65	63	1	40
66	64	1	41
70	65	1	42
71	66	1	43
72	67	1	44
74	69	1	46
79	71	1	47
80	72	1	48
81	73	1	49
83	75	1	50
84	76	1	51
85	77	1	52
87	78	1	53
88	79	1	54
89	80	1	55
90	81	1	55
91	82	1	56
92	83	1	57
93	84	1	58
95	85	1	59
96	86	1	60
97	87	1	61
99	89	1	63
100	90	1	64
101	91	1	65
103	93	1	67
104	94	1	68
105	95	1	69
106	96	1	70
107	97	1	70
108	98	1	71
109	99	1	72
110	100	1	73
111	101	1	74
112	102	1	75
115	103	1	76
116	104	1	77
\.


--
-- Data for Name: files_related_morphs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.files_related_morphs (id, file_id, related_id, related_type, field, "order") FROM stdin;
300	43	15	api::gen-ai-category-info.gen-ai-category-info	coverImageLink	1
382	66	25	api::gen-ai-category-info.gen-ai-category-info	coverImageLink	1
385	55	28	api::gen-ai-category-info.gen-ai-category-info	coverImageLink	1
390	67	26	api::gen-ai-category-info.gen-ai-category-info	coverImageLink	1
391	59	27	api::gen-ai-category-info.gen-ai-category-info	coverImageLink	1
393	69	30	api::gen-ai-category-info.gen-ai-category-info	coverImageLink	1
394	40	31	api::gen-ai-category-info.gen-ai-category-info	coverImageLink	1
396	40	45	api::gen-ai-category-info.gen-ai-category-info	coverImageLink	1
398	71	41	api::gen-ai-category-info.gen-ai-category-info	coverImageLink	1
399	55	42	api::gen-ai-category-info.gen-ai-category-info	coverImageLink	1
401	72	43	api::gen-ai-category-info.gen-ai-category-info	coverImageLink	1
403	73	44	api::gen-ai-category-info.gen-ai-category-info	coverImageLink	1
408	54	59	api::gen-ai-category-info.gen-ai-category-info	coverImageLink	1
409	45	60	api::gen-ai-category-info.gen-ai-category-info	coverImageLink	1
410	55	61	api::gen-ai-category-info.gen-ai-category-info	coverImageLink	1
412	42	64	api::gen-ai-category-info.gen-ai-category-info	coverImageLink	1
413	40	65	api::gen-ai-category-info.gen-ai-category-info	coverImageLink	1
415	84	32	api::gen-ai-category-info.gen-ai-category-info	coverImageLink	1
332	40	10	api::gen-ai-category-info.gen-ai-category-info	coverImageLink	1
418	81	35	api::gen-ai-category-info.gen-ai-category-info	coverImageLink	1
419	79	36	api::gen-ai-category-info.gen-ai-category-info	coverImageLink	1
420	80	34	api::gen-ai-category-info.gen-ai-category-info	coverImageLink	1
422	82	37	api::gen-ai-category-info.gen-ai-category-info	coverImageLink	1
339	33	12	api::gen-ai-category-info.gen-ai-category-info	coverImageLink	1
423	83	38	api::gen-ai-category-info.gen-ai-category-info	coverImageLink	1
424	78	33	api::gen-ai-category-info.gen-ai-category-info	coverImageLink	1
425	86	71	api::gen-ai-category-info.gen-ai-category-info	coverImageLink	1
427	85	74	api::gen-ai-category-info.gen-ai-category-info	coverImageLink	1
428	87	75	api::gen-ai-category-info.gen-ai-category-info	coverImageLink	1
429	89	76	api::gen-ai-category-info.gen-ai-category-info	coverImageLink	1
430	40	77	api::gen-ai-category-info.gen-ai-category-info	coverImageLink	1
431	90	72	api::gen-ai-category-info.gen-ai-category-info	coverImageLink	1
433	59	66	api::gen-ai-category-info.gen-ai-category-info	coverImageLink	1
350	49	73	api::gen-ai-category-info.gen-ai-category-info	coverImageLink	1
351	51	29	api::gen-ai-category-info.gen-ai-category-info	coverImageLink	1
237	28	8	api::gen-ai-category-info.gen-ai-category-info	coverImageLink	1
434	94	68	api::gen-ai-category-info.gen-ai-category-info	coverImageLink	1
358	55	6	api::gen-ai-category-info.gen-ai-category-info	coverImageLink	1
359	57	40	api::gen-ai-category-info.gen-ai-category-info	coverImageLink	1
360	58	7	api::gen-ai-category-info.gen-ai-category-info	coverImageLink	1
361	40	9	api::gen-ai-category-info.gen-ai-category-info	coverImageLink	1
362	59	22	api::gen-ai-category-info.gen-ai-category-info	coverImageLink	1
440	82	67	api::gen-ai-category-info.gen-ai-category-info	coverImageLink	1
441	101	46	api::gen-ai-category-info.gen-ai-category-info	coverImageLink	1
250	45	13	api::gen-ai-category-info.gen-ai-category-info	coverImageLink	1
442	100	47	api::gen-ai-category-info.gen-ai-category-info	coverImageLink	1
443	99	48	api::gen-ai-category-info.gen-ai-category-info	coverImageLink	1
444	97	49	api::gen-ai-category-info.gen-ai-category-info	coverImageLink	1
445	96	50	api::gen-ai-category-info.gen-ai-category-info	coverImageLink	1
375	62	19	api::gen-ai-category-info.gen-ai-category-info	coverImageLink	1
376	61	20	api::gen-ai-category-info.gen-ai-category-info	coverImageLink	1
377	64	21	api::gen-ai-category-info.gen-ai-category-info	coverImageLink	1
378	60	23	api::gen-ai-category-info.gen-ai-category-info	coverImageLink	1
381	65	14	api::gen-ai-category-info.gen-ai-category-info	coverImageLink	1
299	39	11	api::gen-ai-category-info.gen-ai-category-info	coverImageLink	1
446	98	51	api::gen-ai-category-info.gen-ai-category-info	coverImageLink	1
447	95	52	api::gen-ai-category-info.gen-ai-category-info	coverImageLink	1
449	40	54	api::gen-ai-category-info.gen-ai-category-info	coverImageLink	1
450	101	53	api::gen-ai-category-info.gen-ai-category-info	coverImageLink	1
456	63	16	api::gen-ai-category-info.gen-ai-category-info	coverImageLink	1
458	93	70	api::gen-ai-category-info.gen-ai-category-info	coverImageLink	1
462	102	69	api::gen-ai-category-info.gen-ai-category-info	coverImageLink	1
473	41	79	api::gen-ai-category-info.gen-ai-category-info	coverImageLink	1
482	53	18	api::gen-ai-category-info.gen-ai-category-info	coverImageLink	1
487	55	24	api::gen-ai-category-info.gen-ai-category-info	coverImageLink	1
488	55	39	api::gen-ai-category-info.gen-ai-category-info	coverImageLink	1
495	62	17	api::gen-ai-category-info.gen-ai-category-info	coverImageLink	1
498	97	78	api::gen-ai-category-info.gen-ai-category-info	coverImageLink	1
499	99	85	api::gen-ai-category-info.gen-ai-category-info	coverImageLink	1
501	42	81	api::gen-ai-category-info.gen-ai-category-info	coverImageLink	1
502	104	80	api::gen-ai-category-info.gen-ai-category-info	coverImageLink	1
508	60	62	api::gen-ai-category-info.gen-ai-category-info	coverImageLink	1
509	60	86	api::gen-ai-category-info.gen-ai-category-info	coverImageLink	1
510	54	55	api::gen-ai-category-info.gen-ai-category-info	coverImageLink	1
511	97	84	api::gen-ai-category-info.gen-ai-category-info	coverImageLink	1
512	76	57	api::gen-ai-category-info.gen-ai-category-info	coverImageLink	1
513	40	58	api::gen-ai-category-info.gen-ai-category-info	coverImageLink	1
514	75	56	api::gen-ai-category-info.gen-ai-category-info	coverImageLink	1
517	77	63	api::gen-ai-category-info.gen-ai-category-info	coverImageLink	1
\.


--
-- Data for Name: gen_ai_categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.gen_ai_categories (id, created_at, updated_at, published_at, created_by_id, updated_by_id, industry_name, iconify_icon) FROM stdin;
5	2023-08-10 05:03:16.905	2023-08-14 04:21:48.927	2023-08-11 12:42:36.361	7	7	Travel	material-symbols:travel
2	2023-08-10 05:02:39.625	2023-08-14 04:55:56.516	2023-08-14 04:55:56.51	7	7	Media	material-symbols:developer-mode-tv-outline-sharp
3	2023-08-10 05:02:57.668	2023-08-14 04:56:05.674	2023-08-14 04:56:05.669	7	7	Insurance	material-symbols:insert-page-break-outline-sharp
8	2023-08-14 04:51:50.539	2023-08-14 04:56:12.01	2023-08-14 04:56:12.006	7	7	Education	material-symbols:cast-for-education-outline-rounded
9	2023-08-14 04:52:34.314	2023-08-14 04:56:18.609	2023-08-14 04:56:18.602	7	7	Hospitality	material-symbols:room-service-outline
10	2023-08-14 04:53:15.697	2023-08-14 04:56:23.689	2023-08-14 04:56:23.681	7	7	Marketing	material-symbols:add-business-rounded
11	2023-08-14 04:53:59.055	2023-08-14 04:56:28.527	2023-08-14 04:56:28.524	7	7	Retail	material-symbols:shopping-cart-checkout-sharp
6	2023-08-11 09:07:15.604	2023-08-14 04:56:58.988	2023-08-11 09:07:17.062	7	7	Banking	material-symbols:account-balance-rounded
7	2023-08-11 09:09:39.005	2023-08-14 04:57:33.807	2023-08-11 09:09:40.283	7	7	Healthcare	material-symbols:health-metrics-outline
12	2023-08-28 04:38:18.938	2023-09-01 11:05:40.505	2023-08-28 10:38:15.525	20	14	Knowledge management	game-icons:gift-of-knowledge
\.


--
-- Data for Name: gen_ai_category_infos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.gen_ai_category_infos (id, title, description, external_link, video_link, created_at, updated_at, published_at, created_by_id, updated_by_id, sub_title, demo_link, rank) FROM stdin;
16	Personalized Training Content	Harnessing AI to create customized learning experiences that cater to the unique needs and pace of each student, enhancing comprehension and retention.	\N	\N	2023-08-14 07:52:56.759	2023-08-22 11:02:10.594	2023-08-14 07:52:58.174	7	7	Tailoring Education for Every Individual	\N	9
12	Automated Financial Reports	Automate the generation of accurate and detailed financial reports, empowering businesses to monitor performance, comply with regulations, and plan strategically.	\N	\N	2023-08-14 07:48:53.896	2023-08-18 11:26:12.986	2023-08-14 07:51:13.206	7	7	AutoInsights: Financial Clarity at Speed	\N	7
22	Essay and Report Summarization	Assisting students in crafting well-structured essays and reports by automatically summarizing reference materials and highlighting key points.	\N	\N	2023-08-14 08:00:23.194	2023-08-22 07:56:54.371	2023-08-14 08:00:24.11	7	7	Elevate Writing with AI Precision	http://43.204.243.109:8501/Essay_and_Report_Summarization	2
8	Natural Language Generation - Data Briefs	Transform complex financial data into easy-to-understand narratives and reports, enabling better communication of insights and informed decision-making.	\N	\N	2023-08-14 07:47:05.258	2023-08-16 11:27:21.853	2023-08-14 07:51:27.473	7	7	InfoSpark: Insights Transformed	\N	10
9	Content Generation for Campaigns	Fuel your marketing campaigns with AI-generated engaging and persuasive content that resonates with customers, enhancing brand visibility and loyalty.	\N	\N	2023-08-14 07:47:30.187	2023-08-22 07:55:03.139	2023-08-14 07:51:31.842	7	7	BankBuzz: Creative Marketing Ally	\N	9
13	Customer Profile Summarization	Summarize customer profiles, extracting key information to help bankers tailor services, offer personalized solutions, and deepen customer relationships.	\N	\N	2023-08-14 07:49:13.764	2023-08-17 05:09:34.064	2023-08-14 07:51:07.879	7	7	ProfiliSync: Know Your Customers Better	\N	5
23	Language Translation for Study Material	Breaking down language barriers by instantly translating study materials, allowing students to access knowledge from around the world.	\N	\N	2023-08-14 08:00:58.743	2023-08-22 08:08:38.421	2023-08-14 08:00:59.775	7	7	Bridging Language Barriers in Learning	\N	8
29	Personalized Health Tips Generation	Generates tailored health tips based on individual health data, enabling users to adopt healthier lifestyles and make informed decisions to improve their overall well-being.	\N	\N	2023-08-14 08:03:44.482	2023-08-22 07:22:13.065	2023-08-14 08:03:45.45	7	7	Your Pathway to Personalized Wellness	http://43.204.243.109:8501/Personalised_Health_Tips	1
7	Foreign Account Document Analysis	Swiftly verify foreign account documents using cutting-edge AI technology to ensure compliance, reduce fraud, and streamline international transactions.	\N	\N	2023-08-14 07:45:34.658	2023-08-22 07:53:55.134	2023-08-14 07:51:36.003	7	7	SwiftVerify: Secure Global Connections	\N	4
21	AI-Generated Practice Questions	Boosting students' preparedness by generating diverse and challenging practice questions that reinforce understanding and knowledge retention.	\N	\N	2023-08-14 07:59:46.556	2023-08-22 08:08:33.467	2023-08-14 07:59:48.42	7	7	Sharpening Skills with AI-Enhanced Quizzes	\N	7
20	Language Learning Exercises	Facilitating language acquisition through dynamic exercises that adapt to learners' skills, making language learning engaging and effective.	\N	\N	2023-08-14 07:59:20.742	2023-08-22 08:08:28.183	2023-08-14 07:59:21.684	7	7	AI-Powered Fluency Journey	\N	6
25	Medical Record Summarization	Extracts and condenses essential information from extensive medical records, providing healthcare professionals with quick and focused overviews of a patient's medical history for efficient decision-making.	\N	\N	2023-08-14 08:01:56.55	2023-08-22 08:12:05.168	2023-08-14 08:01:57.502	7	7	Unlocking Insights from Medical Histories	\N	2
19	Customized Learning Modules	Empowering students with adaptive learning modules that evolve based on individual progress, fostering a deeper understanding of subjects.	\N	\N	2023-08-14 07:54:02.729	2023-08-22 08:08:22.885	2023-08-14 07:54:04.458	7	7	Unleash Your Potential with Adaptive AI	\N	5
27	Treatment Plan Summaries	Condenses complex treatment plans into concise summaries, helping medical staff and patients understand and follow recommended courses of action, improving adherence and overall treatment outcomes.	\N	\N	2023-08-14 08:02:56.237	2023-08-22 08:19:20.135	2023-08-14 08:02:57.277	7	7	Streamlining Patient Care Pathways	\N	7
30	Symptom Analysis	Analyzes reported symptoms and health data to provide insights into potential underlying health conditions, aiding patients in better understanding their symptoms and seeking appropriate medical attention.	\N	\N	2023-08-14 08:04:04.01	2023-08-22 08:19:37.85	2023-08-14 08:04:05.781	7	7	Decoding Your Health Signals	\N	3
28	QnA on Medical Reports	Processes medical reports and answers questions by extracting relevant information, providing patients and healthcare providers with easily understandable explanations and insights from the reports.	\N	\N	2023-08-14 08:03:18.781	2023-08-22 08:14:06.736	2023-08-14 08:03:19.764	7	7	Unveiling Insights from Medical Data	\N	5
31	Customer Inquiry Chat Assistant	Engages in natural language conversations with customers, addressing inquiries about medical services, appointments, and general health information, enhancing customer experience and providing accurate responses.	\N	\N	2023-08-14 08:04:33.557	2023-08-22 08:19:54.806	2023-08-14 08:04:34.519	7	7	Your Trusted Healthcare Conversationalist	\N	6
26	Diagnosis Suggestion	Utilizes advanced algorithms to analyze patient symptoms, medical history, and test results, assisting doctors in suggesting potential diagnoses, thereby enhancing the accuracy and speed of diagnostic processes.	\N	\N	2023-08-14 08:02:29.26	2023-08-22 08:19:12.309	2023-08-14 08:02:30.456	7	7	Empowering Accurate Healthcare Diagnosis	\N	4
24	AI-Guided Knowledge Exploration	Enhancing learning through AI-generated Q&A sessions that provide comprehensive explanations and insights into complex educational content.	\N	\N	2023-08-14 08:01:21.667	2023-09-12 11:01:51.695	2023-08-14 08:01:22.899	7	20	Q&A on Educational Content 	\N	4
54	Customer Inquiry Chat Assistant	Elevate customer experiences by offering instant and accurate support through AI-powered chat assistance.	\N	\N	2023-08-14 09:16:02.442	2023-08-22 09:26:59.638	2023-08-14 09:16:03.428	7	7	Elevate Customer Experiences with AI Chat	\N	8
53	Social Media Responses	Seamlessly interact with your audience through AI-crafted responses, forging stronger connections online.	\N	\N	2023-08-14 09:15:38.601	2023-08-22 09:27:06.848	2023-08-14 09:15:39.676	7	7	Engage Seamlessly with AI-Personalized Replies	\N	9
18	Study Material Summaries	Enhancing study efficiency by providing concise and coherent summaries of lengthy materials, helping students grasp key concepts quickly.	\N	\N	2023-08-14 07:53:41.312	2023-09-11 08:31:41.731	2023-08-14 07:53:42.334	7	7	Distilling Knowledge for Efficiency	http://43.204.243.109:8501/Study_Material_Summaries	2
17	Personal AI Tutor	Achieve More with AI-Powered Tutoring: Harness the cutting-edge capabilities of artificial intelligence to supercharge your learning experience. Benefit from personalized guidance, instant feedback, and adaptive lessons that propel you towards academic excellence and personal growth. Embrace the future of education with a tutor that adapts to your needs and helps you reach your full potential.	\N	\N	2023-08-14 07:53:18.944	2023-09-15 05:38:09.959	2023-08-14 07:53:20.035	7	20	Achieve More with AI-Powered Tutoring	http://43.204.243.109:8504/	1
57	Personalized Short Videos	Tailor-made short videos that cater to individual preferences and interests. GenAI leverages user data and content analysis to generate personalized videos, fostering a deeper connection between the audience and the content.	\N	\N	2023-08-14 09:18:00.775	2023-10-03 10:41:36.862	2023-08-14 09:18:01.664	7	20	ReelTime Stories Just for You	\N	\N
45	Customer Inquiry Chat Assistant	Connect with InsurBot, your friendly AI chat assistant. Whether you have questions about policies, claims, or coverage options, InsurBot is here to provide prompt and accurate assistance. Skip the hold times and access information seamlessly—InsurBot is y	\N	\N	2023-08-14 09:12:26.374	2023-08-22 08:22:50.121	2023-08-14 09:12:27.352	7	7	InsurBot: Your Virtual Guide	\N	4
42	Customer Inquiry Q&A	Get instant answers to your insurance queries with InsureChat. Our AI chat assistant is ready to assist you round the clock, providing accurate and helpful responses to your inquiries. No more waiting on hold or sifting through websites—InsureChat is here	\N	\N	2023-08-14 09:11:19.58	2023-08-22 08:27:48.342	2023-08-14 09:11:20.968	7	7	InsureChat: Your Inquiry Partner	\N	5
41	Insurance Coverage Summary	Let CovRadar be your guide to insurance coverage. This AI-powered tool analyzes your policy, breaks down coverage details, and presents you with a clear and comprehensive summary. Say goodbye to confusion—CovRadar ensures you understand your coverage, mak	\N	\N	2023-08-14 09:10:55.744	2023-08-22 08:27:22.446	2023-08-14 09:10:57.419	7	7	CovRadar: Your Coverage Navigator	\N	2
58	Auto Caption Generation	Automatically generate accurate captions for videos, making content accessible to a wider audience, including those with hearing impairments. GenAI applies advanced speech recognition and linguistic understanding to create high-quality captions.	\N	\N	2023-08-14 09:18:21.598	2023-10-03 10:41:47.864	2023-08-14 09:18:22.322	7	20	AutoCap: Bringing Silence to Life	\N	\N
43	Customized Policy Recommendations	Experience insurance like never before with SmartPolicy. Our AI analyzes your needs, preferences, and risk profile to recommend a personalized insurance policy that suits you perfectly. Say goodbye to generic plans—SmartPolicy ensures you're getting cover	\N	\N	2023-08-14 09:11:47.447	2023-08-22 08:28:25.241	2023-08-14 09:11:48.693	7	7	SmartPolicy: Tailored for You	\N	6
44	Claim Settlement Insights	Navigating claim settlements with ease. SettleSure utilizes AI to provide valuable insights into the claim settlement process. Receive guidance on the expected timelines, documentation requirements, and factors affecting your claim. With SettleSure by you	\N	\N	2023-08-14 09:12:08.719	2023-08-22 08:31:08.511	2023-08-14 09:12:09.716	7	7	SettleSure: Your Claims Advisor	\N	7
56	Video Script Generation	Craft engaging and coherent video scripts effortlessly. GenAI uses its natural language generation capabilities to create scripts for videos, ensuring smooth narration and maintaining viewer interest, saving time and enhancing storytelling.	\N	\N	2023-08-14 09:17:39.758	2023-10-03 10:42:24.761	2023-08-14 09:17:40.623	7	20	ScriptCraft: The AI Wordsmith	\N	\N
37	Real-time Guest Feedback Analysis	Elevate guest service by analyzing real-time feedback through AI, enabling swift responses, immediate issue resolution, and an overall exceptional stay.	\N	\N	2023-08-14 08:17:22.75	2023-08-22 08:50:42.644	2023-08-14 08:17:25.069	7	7	Elevate, Evaluate, Excel	\N	5
32	Room Customization based on Preferences	Elevate guest satisfaction with personalized room experiences, utilizing AI to fulfill individual preferences and enhance their stay.	\N	\N	2023-08-14 08:04:58.289	2023-08-22 08:48:48.069	2023-08-14 08:05:01.054	7	7	Tailored Comfort, Unveiled	\N	1
46	Social Media Post Generation	Create compelling and personalized social media posts effortlessly, boosting audience interaction.	\N	\N	2023-08-14 09:12:51.594	2023-08-22 09:25:32.926	2023-08-14 09:21:46.802	7	7	Elevate Engagement with AI-Powered Posts	\N	1
35	Event Planning Assistance	Simplify event organization using AI's precision and speed, ensuring memorable occasions through efficient planning, coordination, and execution.	\N	\N	2023-08-14 08:16:29.557	2023-08-22 08:49:52.048	2023-08-14 08:16:30.808	7	7	Seamless Celebrations, Powered by AI	\N	4
36	Feedback Analysis for Improving Experiences	Elevate guest experiences by leveraging AI to analyze feedback data, extracting actionable insights that drive continuous improvements and satisfaction.	\N	\N	2023-08-14 08:16:57.133	2023-08-22 08:50:08.736	2023-08-14 08:16:58.982	7	7	Refining Perfection through Insights	\N	3
34	AI-Generated Menus and Recipes	Offer delectable dining options by presenting AI-curated menus and recipes, combining innovation and flavor to tantalize taste buds.	\N	\N	2023-08-14 08:06:00.856	2023-08-22 08:50:17.829	2023-08-14 08:06:02.018	7	7	Culinary Delights, Crafted by AI	\N	2
38	Auto Email Responder - Booking Queries	Accelerate booking inquiries with an AI-powered email responder, providing prompt and accurate responses, ensuring seamless and efficient booking processes.	\N	\N	2023-08-14 08:17:47.341	2023-08-22 08:50:55.221	2023-08-14 08:17:48.586	7	7	Swift Reservations, Instant Gratification	\N	6
33	Virtual Assistant - Concierge Services	Enhance guest interactions with a seamless AI-driven virtual concierge, providing information, recommendations, and assistance throughout their stay.	\N	\N	2023-08-14 08:05:35.329	2023-08-22 08:51:12.324	2023-08-14 08:05:36.447	7	7	Your Invisible Hospitality Partner	\N	7
47	Influencer Suggestion for Campaigns	Discover the ideal influencers who align perfectly with your brand, optimizing your marketing campaigns.	\N	\N	2023-08-14 09:13:14.686	2023-08-22 09:25:43.245	2023-08-14 09:13:15.605	7	7	Catalyze Campaigns with GenAI Insights	\N	2
48	Sentiment Analysis of Marketing Campaigns	Gain deep insights into customer sentiment towards your campaigns, refining strategies for enhanced impact.	\N	\N	2023-08-14 09:13:38.968	2023-08-22 09:25:53.54	2023-08-14 09:13:40.345	7	7	Decode Customer Vibes for Marketing Success	\N	3
49	Copywriting Assistance	Collaborate with AI to refine and enhance your copywriting, creating impactful content that resonates.	\N	\N	2023-08-14 09:14:08.755	2023-08-22 09:26:03.439	2023-08-14 09:14:09.733	7	7	Craft Brilliance Together with AI	\N	4
50	Customer Segmentation Analysis	Unlock hidden market segments using AI-driven analysis, enabling targeted marketing and higher conversions.	\N	\N	2023-08-14 09:14:31.468	2023-08-22 09:26:14.275	2023-08-14 09:14:32.349	7	7	Unleash Markets with Precision Segmentation	\N	5
51	Keyword Suggestion for SEO	Leverage AI to unearth powerful keywords, catapulting your website to the top of search engine rankings.	\N	\N	2023-08-14 09:14:52.187	2023-08-22 09:26:23.356	2023-08-14 09:14:53.149	7	7	Skyrocket SEO with GenAI-Powered Keywords	\N	6
52	Caption Suggestion	Ignite your creativity by incorporating AI-generated captions that captivate your audience across platforms.	\N	\N	2023-08-14 09:15:16.374	2023-08-22 09:26:33.435	2023-08-14 09:15:17.8	7	7	Ignite Creativity with AI-Generated Captions	\N	7
10	Conversational Banking	Provides a seamless, human-like conversational experiences, enabling them to manage accounts, transactions, and get real-time assistance effortlessly.	\N	\N	2023-08-14 07:48:03.098	2023-08-18 11:25:44.156	2023-08-17 08:11:59.347	7	7	ChatFin: Your Personal Finance Assistant	http://43.204.243.109:8502/Conversational_Banking	2
11	Internal Data Questions & Answers	Empower bank employees to quickly retrieve valuable insights from internal data, fostering data-driven decision-making and operational efficiency.	\N	\N	2023-08-14 07:48:29.824	2023-08-17 09:33:19.543	2023-08-14 10:29:45.616	7	7	IntraInsight: Uncover Your Data	\N	6
6	Q&A on Product & RBI Guideline	Empower customers with accurate and up-to-date information about products and RBI guidelines through interactive Q&A sessions.	\N	\N	2023-08-14 04:59:13.318	2023-08-22 07:50:48.321	2023-08-14 07:50:35.176	7	7	BankSmart Insights: Your Financial Guide	\N	3
63	Multi-Model Search	VisionSeek is a cutting-edge module designed to empower users with the ability to uncover answers within video content effortlessly.It leverages RAG, which provides quick and accurate responses to your queries. Say goodbye to time-consuming video searches; with VisionSeek, knowledge is just a click away.	\N	\N	2023-08-14 09:20:42.725	2023-10-04 08:32:22.015	2023-08-14 09:20:44.296	7	20	VisionSeek: Find Answers in Videos	http://43.204.243.109:8501/Multi_Model_Search	1
73	Multilingual Travel Assistance	Seamlessly navigate the world with AI-powered language assistance, breaking down language barriers and enhancing your travel experiences.	\N	\N	2023-08-14 09:29:41.383	2023-08-22 07:15:32.677	2023-08-14 09:29:42.552	7	7	Global Adventures, Local Language	http://43.204.243.109:8501/Multilingual_Travel_Assistance	1
59	Personalized News Clips	Curate news clips based on user preferences and behaviors, delivering a personalized news experience. GenAI sifts through vast amounts of news content to deliver bite-sized updates that matter most to each individual.	\N	\N	2023-08-14 09:18:42.575	2023-08-22 08:37:42.971	2023-08-14 09:18:44.443	7	7	Your Daily Dose, Your Way	\N	6
60	AI-Generated Art and Graphics	Transform ideas into stunning visual artworks using AI-generated graphics. GenAI combines artistic creativity with advanced algorithms to produce unique and captivating visuals, enhancing the visual appeal and engagement of various media platforms.	\N	\N	2023-08-14 09:19:23.587	2023-08-22 08:38:43.843	2023-08-14 09:19:24.565	7	7	Artistry Redefined by GenAI	\N	7
61	Analyze QnA on Leasing TnC	Analyze complex leasing terms and conditions through AI-powered question and answer processing. GenAI simplifies intricate legal jargon, providing clear and concise insights into leasing agreements, making them more comprehensible for stakeholders.	\N	\N	2023-08-14 09:19:41.848	2023-08-22 08:39:04.129	2023-08-14 09:19:43.796	7	7	Clarity Insights: Lease the Future	\N	8
62	Auto Language Translation	Break down language barriers by instantly translating text and speech. GenAI's language translation capabilities enable seamless communication and content localization, ensuring media reaches a global audience while preserving its intended meaning.	\N	\N	2023-08-14 09:20:17.598	2023-10-03 10:39:29.724	2023-08-14 09:20:18.637	7	20	WorldSpeak: Bridging Language Divides	http://43.204.243.109:8501/Language_Translator	5
64	Tabular Business Intelligence	Extract valuable insights from tabular data. GenAI processes and analyzes business data, transforming it into actionable insights and visualizations, empowering media professionals to make informed decisions and optimize their operations.	\N	\N	2023-08-14 09:21:03.229	2023-08-22 08:41:05.655	2023-08-14 09:21:03.981	7	7	Data Insights Unveiled	\N	10
65	Customer Inquiry Chat Assistant	Provide instant and informative responses to customer inquiries. GenAI's chatbot assists users in navigating through media-related queries, offering timely assistance and enhancing user satisfaction with seamless and interactive communication.	\N	\N	2023-08-14 09:21:26.397	2023-08-22 08:41:35.9	2023-08-14 09:21:27.381	7	7	MediaBot: Your 24/7 Guide	\N	11
71	Travel Itinerary Generation	Let the magic of AI create personalized travel itineraries tailored to your interests, ensuring a seamless and unforgettable journey.	\N	\N	2023-08-14 09:28:59.181	2023-08-22 09:03:04.348	2023-08-14 09:29:00.596	7	7	Wanderlust Crafted Just for You	\N	5
67	Customer Feedback Analysis	Gain valuable insights into customer opinions and sentiments, allowing you to refine your offerings and provide a more tailored and satisfying shopping journey.	\N	\N	2023-08-14 09:27:18.799	2023-08-22 09:12:33.973	2023-08-14 09:27:20.03	7	7	Unlocking Shopper Insights	\N	4
74	Travel Expense Tracking	Effortlessly manage your travel expenses with AI, so you can focus on creating memories while staying within your budget.	\N	\N	2023-08-14 09:30:02.586	2023-08-22 09:03:36.697	2023-08-14 09:30:03.678	7	7	Your Wallet's Best Travel Companion	\N	3
75	Virtual Tour Guides	Embark on immersive virtual tours led by AI, transporting you to distant places and offering insights that redefine your travel experience.	\N	\N	2023-08-14 09:30:42.904	2023-08-22 09:03:49.606	2023-08-14 09:30:43.808	7	7	Journey Beyond Reality	\N	4
76	Culinary Exploration	Let AI be your guide to delectable local cuisines, enriching your travel with unforgettable gastronomic adventures.	\N	\N	2023-08-14 09:31:01.824	2023-08-22 09:04:01.518	2023-08-14 09:31:02.742	7	7	Savor Every Corner of the Globe	\N	6
77	Customer Inquiry Chat Assistant	Get instant answers and assistance anytime, anywhere, as AI-powered chat support ensures your travel plans are always on the right track.	\N	\N	2023-08-14 09:31:28.497	2023-08-22 09:04:19.762	2023-08-14 09:31:29.4	7	7	Your 24/7 Travel Companion	\N	7
72	Destination Recommendation	Unlock new adventures as AI suggests unique and exciting travel destinations, expanding your horizons and sparking your curiosity.	\N	\N	2023-08-14 09:29:20.374	2023-08-22 09:06:00.57	2023-08-14 09:29:21.597	7	7	Explore the Unknown with Confidence	\N	2
66	Product Description Generation	Elevate your products with captivating and informative descriptions that entice customers and showcase their unique features, enhancing the shopping experience.	\N	\N	2023-08-14 09:27:02.251	2023-08-22 09:08:00.727	2023-08-14 09:27:02.969	7	7	Crafting Alluring Narratives	\N	2
68	Personalized Shopping Recommendations	Discover a world of curated selections, perfectly matched to your preferences and desires, guiding you through an effortless and enjoyable shopping spree.	\N	\N	2023-08-14 09:27:39.556	2023-08-22 09:10:58.251	2023-08-14 09:27:40.526	7	7	Your Tailored Shopping Companion	\N	3
70	Product Naming and Branding	Craft compelling and memorable names for your products, establishing a powerful brand identity that resonates with your target audience and leaves a lasting impression.	\N	\N	2023-08-14 09:28:31.688	2023-08-22 11:03:57.569	2023-08-14 09:28:32.66	7	7	Branding Brilliance, Name by Name	\N	5
69	Virtual Shopping (Pizza Order Bot)	Embark on an interactive shopping adventure with AI-powered virtual assistants that offer real-time guidance, product information, and a touch of personalized charm.	\N	\N	2023-08-14 09:28:12.606	2023-08-24 08:08:20.165	2023-08-14 09:28:14.805	7	20	Your Virtual Shopping Sidekick	http://43.204.243.109:8501/Pizza_Orderbot	1
15	Customer Inquiry Chat Assistant	Enhance customer service with an AI-powered chat assistant that resolves inquiries, provides account information, and offers guidance, ensuring customer satisfaction.	\N	\N	2023-08-14 07:52:32.524	2023-08-17 09:33:34.087	2023-08-14 07:52:33.61	7	7	InquiryBot: Instant Answers, Anytime	\N	8
40	Claim Document Summarization	Navigating insurance claims made easy! ClaimEase employs AI to summarize complex claim documents into concise and comprehensible summaries. No more sifting through pages of legalese—just the key details you need, saving time and ensuring you have a clear 	\N	\N	2023-08-14 08:53:40.983	2023-08-22 07:51:59.962	2023-08-14 09:21:55.469	7	7	ClaimEase: Simplifying Claims	http://43.204.243.109:8501/Claim_Document_Summarization	1
14	Transaction Categorization Engine	Streamline transaction categorization and classification using AI, enabling efficient expense tracking, budgeting, and financial analysis for individuals and businesses.	\N	\N	2023-08-14 07:52:11.071	2023-08-22 08:10:07.285	2023-08-14 07:52:11.986	7	7	TransaCate: Transactions Simplified	http://43.204.243.109:8502/	1
39	Document Q&A	Discover a new dimension of document interaction with 'Documents Reimagined: The Power of Document Q&A.' Explore the transformative potential of Document Q&A as it revolutionizes the way you engage with your documents. Unleash the ability to pose questions, extract insights, and unearth knowledge from your documents effortlessly. Witness a paradigm shift in how information is accessed, understood, and acted upon. Experience the future of document intelligence with Document Q&A, where the power of words takes on a whole new meaning.	\N	\N	2023-08-14 08:21:55.573	2023-09-12 11:09:49.878	2023-08-14 08:21:56.629	7	20	Documents Reimagined: The Power of Document Q&A	http://43.204.243.109:8501/Document_QnA	3
78	Tone And Style Cloning	Replicating the email style by imitating the sender's tone and demeanor, ensuring the message mirrors their unique communication style. This capture the essence of their writing, producing emails that resonate authentically. By analyzing patterns and linguistic nuances, it crafts responses that align with the original sender's tone, making communication seamless and personalized.	\N	\N	2023-08-28 04:47:47.27	2023-09-15 06:06:42.573	2023-08-28 10:39:10.581	20	20	Your Email Tone, Your Message Style.	http://43.204.243.109:8505/	2
85	HR ChatBot	Your go-to AI assistant for HR inquiries, offering quick and accurate solutions to all leaves related questions.	\N	\N	2023-09-14 11:01:36.352	2023-09-15 06:06:54.065	2023-09-14 11:01:39.275	20	20	HR Ease: Effortless HR Help	http://43.204.243.109:8501/HR_ChatBot	3
79	Masking & Security	An elegant solution that delicately shields sensitive information, preserving its essence while securing its core. Discover the balance of protection and usability, where data privacy meets seamless functionality.	\N	\N	2023-08-28 04:52:17.811	2023-08-28 11:03:17.397	2023-08-28 10:57:40.866	20	20	Crafting Privacy: The Art of Subtle Data Concealment	http://43.204.243.109:8506/	1
84	Video Summary & Notes	Our Video Synopsis & Key Points provide a condensed overview of the video's main highlights and essential takeaways, saving you valuable time and ensuring you grasp the key information effortlessly.	\N	\N	2023-09-14 09:33:04.128	2023-10-03 10:41:12.602	2023-09-14 09:33:11.595	20	20	Video Recap & Notes: Your Quick Guide	http://43.204.243.109:8501/Video_Summary_&_Notes	3
86	Video Dubbing	VocaFlicks offers swift and hassle-free video dubbing with voices in your preferred language. Transform your videos into immersive experiences as VocaFlicks effortlessly dubs them with your chosen voices, making multilingual content creation a breeze. Say farewell to complex dubbing processes and embrace VocaFlicks for instant, language-enhanced videos.	\N	\N	2023-10-03 10:36:28.047	2023-10-03 10:40:37.789	2023-10-03 10:37:03.751	20	20	VocaFlicks: Instant Video Dubbing	http://43.204.243.109:8501/Video_Transcript_Translation	2
81	AI Feature Engineering(Jupyter Notebook)	Unleash data's hidden potential using our AI Feature Engineering code. Elevate model performance by crafting refined features that illuminate patterns within the noise, driving accuracy and efficiency in every prediction.	\N	\N	2023-08-28 10:42:16.877	2023-09-15 06:21:57.693	2023-08-28 10:59:08.612	20	20	Elevate, Iterate, Innovate: AI Feature Engineering Perfected.	\N	4
80	Vector Embeddings(Jupyter Notebook)	Discover the essence of data transformation with our vector embedding code. This code elegantly encodes complex information into compact vectors, unlocking new insights and enabling efficient analysis across dimensions. 	\N	\N	2023-08-28 04:53:04.013	2023-09-15 06:22:05.646	2023-08-28 10:41:14.156	20	20	Vectors Unleashed: Redefining Data Representation	\N	5
55	News Article Summarization	Efficiently distill lengthy news articles into concise summaries, providing readers with quick insights and enabling them to stay informed even on the go. GenAI employs advanced language understanding to highlight the most important aspects of the news.	\N	\N	2023-08-14 09:17:17.521	2023-10-03 10:40:51.846	2023-08-14 09:17:18.253	7	20	News in a Nutshell	http://43.204.243.109:8501/News_Article_Summarization	4
\.


--
-- Data for Name: gen_ai_category_infos_gen_ai_industry_links; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.gen_ai_category_infos_gen_ai_industry_links (id, gen_ai_category_info_id, gen_ai_category_id, gen_ai_category_info_order) FROM stdin;
5	6	6	1
6	7	6	2
7	9	6	3
8	8	6	4
9	10	6	5
10	11	6	6
11	12	6	7
12	13	6	8
13	14	6	9
14	15	6	10
15	16	8	1
16	17	8	2
17	18	8	3
18	19	8	4
19	21	8	5
20	20	8	6
21	22	8	7
22	23	8	8
23	24	8	9
24	25	7	1
25	26	7	2
26	27	7	3
27	28	7	4
28	29	7	5
29	30	7	6
30	31	7	7
31	32	9	1
32	33	9	2
33	34	9	3
34	35	9	4
35	36	9	5
36	37	9	6
37	38	9	7
38	39	3	1
39	40	3	2
40	41	3	3
41	42	3	4
42	43	3	5
43	44	3	6
44	45	3	7
45	46	10	1
46	47	10	2
47	48	10	3
48	49	10	4
49	50	10	5
50	51	10	6
51	52	10	7
52	53	10	8
53	54	10	9
54	55	2	1
55	56	2	2
56	57	2	3
57	58	2	4
58	59	2	5
59	60	2	6
60	61	2	7
61	62	2	8
62	63	2	9
63	64	2	10
64	65	2	11
65	66	11	1
66	67	11	2
67	68	11	3
68	69	11	4
69	70	11	5
70	71	5	1
71	72	5	2
72	73	5	3
73	74	5	4
74	75	5	5
75	76	5	6
76	77	5	7
77	78	12	1
78	79	12	2
79	80	12	3
80	81	12	4
83	84	2	12
84	85	12	5
85	86	2	13
\.


--
-- Data for Name: i18n_locale; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.i18n_locale (id, name, code, created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
1	English (en)	en	2023-05-08 06:39:52.897	2023-05-08 06:39:52.897	\N	\N
\.


--
-- Data for Name: lookup_masters; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.lookup_masters (id, type, code, description, is_active, created_at, updated_at, published_at, created_by_id, updated_by_id) FROM stdin;
1	ADDRESS_TYPE	01	Permanent Address	t	2023-06-22 16:23:05.878	2023-06-22 16:23:05.878	\N	9	9
2	ADDRESS_TYPE	02	Correspondence Address	t	2023-06-22 16:23:35.425	2023-06-22 16:23:35.425	\N	9	9
\.


--
-- Data for Name: rule_additional_fields_descriptions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rule_additional_fields_descriptions (id, key_name, created_at, updated_at, published_at, created_by_id, updated_by_id, value_sql) FROM stdin;
1	Key Name in Additional Info Parameter (Impact :Low)	2023-06-07 04:46:57.703	2023-06-15 11:35:40.146	2023-06-07 04:46:59.29	7	20	Value/Field to be mapped to corresponding key (Impact :Low)
\.


--
-- Data for Name: rule_creation_fields_descriptions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rule_creation_fields_descriptions (id, rule_name, created_at, updated_at, published_at, created_by_id, updated_by_id, start_date, end_date, rule_description, action_code, rule_category, rule_type, priority, attachment_url, screen_identifier, output_mode, voucher_code, voucher_code_applicable, channels) FROM stdin;
1	Unique name (should be alphanumeric with only underscore as a special character. Example :RULE_1; Impact: Medium)	2023-06-06 11:58:05.431	2023-06-15 11:38:22.134	2023-06-06 11:58:07.413	7	20	Date of the execution of the rule (Impact: High)	Date of termination of the rule (Impact: High)	what the rule is about (max 5000 characters; Impact: Medium)	Drop down list from preconfigured action codes associated with a rule (Impact : High)	Category of the action code (Impact: High)	Type of the category (Impact :High)	Priority of the action (lower the value higher the priority; Impact :High) 	URL associated with the rule(which is displayed on the UI; Impact : Low)	select screen on which the NBA will be visible (Impact : Low)	Output display mode type (Impact :High)	code to avail the offer (Impact : Low)	applicable incase of cashback/offers (Impact : Low)	voucher code channels (Impact : High, Example: customer facing/RM facing)
\.


--
-- Data for Name: rule_execution_fields_descriptions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rule_execution_fields_descriptions (id, created_at, updated_at, published_at, created_by_id, updated_by_id, ksqldb_cluster, stream_name, input_key, entity_id, input_timestamp_sql, input_timestamp_format, input_timestamp_tz, output_generation_type, limit_interval, limit_interval_logic_sql, max_allowed_limit, generate_false_output, generate_same_ref_number, input_load_type, output_stream_name, rule_condition_sql, dynamic_text_sql, expiry_date_sql, calculation_logic_type, max_calculated_value, calculation_apply_field) FROM stdin;
1	2023-06-07 04:46:38.419	2023-06-16 05:52:29.142	2023-06-07 04:46:40.14	7	20	Preconfigured ksqldb clusters(by calling api ; Impact: High)	Stream on which rule is to be applied (Impact: High)	Kafka Key of the Input Stream (read-only; Impact: High)	Field names fetched from input stream schema (Impact : High)	Date field name in the input stream or its equivalent SQL expression (Impact: High)	Format of the timestamp field (Impact: High)	Timezone of the timestamp (Impact :High)	Recurrence interval of the rule (Impact: High)	Interval type of the rule (Impact : High)	Valid SQL expression to calculate limit logic (Impact : High)	Max number of times a recommendation is to be generated in a Limit Interval (Impact : Low)	To supress a generated recommendation (Impact : High)	\N	From when the records are to be processed  in the input stream (Impact : High)	Final stream after the rule application (Impact : High)	Rule condition to be executed by processing engine (valid SQL Expression returning True or False ; Impact : High)	Customized text to be generated using SQL expression (Impact : High)	Date till this data will be shown(Valid SQL expression; Impact: High)	Calculation logic type to generate fee or loyalty points (Impact: High)	Numeric max cap on the calculation apply field (Impact: High)	Field name to apply the calculation logic (Impact : High)
\.


--
-- Data for Name: strapi_api_token_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.strapi_api_token_permissions (id, action, created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
\.


--
-- Data for Name: strapi_api_token_permissions_token_links; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.strapi_api_token_permissions_token_links (id, api_token_permission_id, api_token_id, api_token_permission_order) FROM stdin;
\.


--
-- Data for Name: strapi_api_tokens; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.strapi_api_tokens (id, name, description, type, access_key, last_used_at, expires_at, lifespan, created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
\.


--
-- Data for Name: strapi_core_store_settings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.strapi_core_store_settings (id, key, value, type, environment, tag) FROM stdin;
2	plugin_content_manager_configuration_content_types::admin::permission	{"uid":"admin::permission","settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"action","defaultSortBy":"action","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"action":{"edit":{"label":"action","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"action","searchable":true,"sortable":true}},"subject":{"edit":{"label":"subject","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"subject","searchable":true,"sortable":true}},"properties":{"edit":{"label":"properties","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"properties","searchable":false,"sortable":false}},"conditions":{"edit":{"label":"conditions","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"conditions","searchable":false,"sortable":false}},"role":{"edit":{"label":"role","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"role","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}}},"layouts":{"list":["id","action","subject","role"],"edit":[[{"name":"action","size":6},{"name":"subject","size":6}],[{"name":"properties","size":12}],[{"name":"conditions","size":12}],[{"name":"role","size":6}]]}}	object	\N	\N
3	plugin_content_manager_configuration_content_types::admin::user	{"uid":"admin::user","settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"firstname","defaultSortBy":"firstname","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"firstname":{"edit":{"label":"firstname","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"firstname","searchable":true,"sortable":true}},"lastname":{"edit":{"label":"lastname","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"lastname","searchable":true,"sortable":true}},"username":{"edit":{"label":"username","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"username","searchable":true,"sortable":true}},"email":{"edit":{"label":"email","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"email","searchable":true,"sortable":true}},"password":{"edit":{"label":"password","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"password","searchable":true,"sortable":true}},"resetPasswordToken":{"edit":{"label":"resetPasswordToken","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"resetPasswordToken","searchable":true,"sortable":true}},"registrationToken":{"edit":{"label":"registrationToken","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"registrationToken","searchable":true,"sortable":true}},"isActive":{"edit":{"label":"isActive","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"isActive","searchable":true,"sortable":true}},"roles":{"edit":{"label":"roles","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"roles","searchable":false,"sortable":false}},"blocked":{"edit":{"label":"blocked","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"blocked","searchable":true,"sortable":true}},"preferedLanguage":{"edit":{"label":"preferedLanguage","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"preferedLanguage","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}}},"layouts":{"list":["id","firstname","lastname","username"],"edit":[[{"name":"firstname","size":6},{"name":"lastname","size":6}],[{"name":"username","size":6},{"name":"email","size":6}],[{"name":"password","size":6},{"name":"resetPasswordToken","size":6}],[{"name":"registrationToken","size":6},{"name":"isActive","size":4}],[{"name":"roles","size":6},{"name":"blocked","size":4}],[{"name":"preferedLanguage","size":6}]]}}	object	\N	\N
4	plugin_content_manager_configuration_content_types::admin::api-token-permission	{"uid":"admin::api-token-permission","settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"action","defaultSortBy":"action","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"action":{"edit":{"label":"action","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"action","searchable":true,"sortable":true}},"token":{"edit":{"label":"token","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"token","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}}},"layouts":{"list":["id","action","token","createdAt"],"edit":[[{"name":"action","size":6},{"name":"token","size":6}]]}}	object	\N	\N
5	plugin_content_manager_configuration_content_types::admin::api-token	{"uid":"admin::api-token","settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"name","defaultSortBy":"name","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"name":{"edit":{"label":"name","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"name","searchable":true,"sortable":true}},"description":{"edit":{"label":"description","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"description","searchable":true,"sortable":true}},"type":{"edit":{"label":"type","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"type","searchable":true,"sortable":true}},"accessKey":{"edit":{"label":"accessKey","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"accessKey","searchable":true,"sortable":true}},"lastUsedAt":{"edit":{"label":"lastUsedAt","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"lastUsedAt","searchable":true,"sortable":true}},"permissions":{"edit":{"label":"permissions","description":"","placeholder":"","visible":true,"editable":true,"mainField":"action"},"list":{"label":"permissions","searchable":false,"sortable":false}},"expiresAt":{"edit":{"label":"expiresAt","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"expiresAt","searchable":true,"sortable":true}},"lifespan":{"edit":{"label":"lifespan","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"lifespan","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}}},"layouts":{"list":["id","name","description","type"],"edit":[[{"name":"name","size":6},{"name":"description","size":6}],[{"name":"type","size":6},{"name":"accessKey","size":6}],[{"name":"lastUsedAt","size":6},{"name":"permissions","size":6}],[{"name":"expiresAt","size":6},{"name":"lifespan","size":4}]]}}	object	\N	\N
6	plugin_content_manager_configuration_content_types::admin::transfer-token	{"uid":"admin::transfer-token","settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"name","defaultSortBy":"name","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"name":{"edit":{"label":"name","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"name","searchable":true,"sortable":true}},"description":{"edit":{"label":"description","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"description","searchable":true,"sortable":true}},"accessKey":{"edit":{"label":"accessKey","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"accessKey","searchable":true,"sortable":true}},"lastUsedAt":{"edit":{"label":"lastUsedAt","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"lastUsedAt","searchable":true,"sortable":true}},"permissions":{"edit":{"label":"permissions","description":"","placeholder":"","visible":true,"editable":true,"mainField":"action"},"list":{"label":"permissions","searchable":false,"sortable":false}},"expiresAt":{"edit":{"label":"expiresAt","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"expiresAt","searchable":true,"sortable":true}},"lifespan":{"edit":{"label":"lifespan","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"lifespan","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}}},"layouts":{"list":["id","name","description","accessKey"],"edit":[[{"name":"name","size":6},{"name":"description","size":6}],[{"name":"accessKey","size":6},{"name":"lastUsedAt","size":6}],[{"name":"permissions","size":6},{"name":"expiresAt","size":6}],[{"name":"lifespan","size":4}]]}}	object	\N	\N
7	plugin_content_manager_configuration_content_types::admin::transfer-token-permission	{"uid":"admin::transfer-token-permission","settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"action","defaultSortBy":"action","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"action":{"edit":{"label":"action","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"action","searchable":true,"sortable":true}},"token":{"edit":{"label":"token","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"token","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}}},"layouts":{"list":["id","action","token","createdAt"],"edit":[[{"name":"action","size":6},{"name":"token","size":6}]]}}	object	\N	\N
8	plugin_content_manager_configuration_content_types::plugin::upload.file	{"uid":"plugin::upload.file","settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"name","defaultSortBy":"name","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"name":{"edit":{"label":"name","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"name","searchable":true,"sortable":true}},"alternativeText":{"edit":{"label":"alternativeText","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"alternativeText","searchable":true,"sortable":true}},"caption":{"edit":{"label":"caption","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"caption","searchable":true,"sortable":true}},"width":{"edit":{"label":"width","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"width","searchable":true,"sortable":true}},"height":{"edit":{"label":"height","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"height","searchable":true,"sortable":true}},"formats":{"edit":{"label":"formats","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"formats","searchable":false,"sortable":false}},"hash":{"edit":{"label":"hash","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"hash","searchable":true,"sortable":true}},"ext":{"edit":{"label":"ext","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"ext","searchable":true,"sortable":true}},"mime":{"edit":{"label":"mime","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"mime","searchable":true,"sortable":true}},"size":{"edit":{"label":"size","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"size","searchable":true,"sortable":true}},"url":{"edit":{"label":"url","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"url","searchable":true,"sortable":true}},"previewUrl":{"edit":{"label":"previewUrl","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"previewUrl","searchable":true,"sortable":true}},"provider":{"edit":{"label":"provider","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"provider","searchable":true,"sortable":true}},"provider_metadata":{"edit":{"label":"provider_metadata","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"provider_metadata","searchable":false,"sortable":false}},"folder":{"edit":{"label":"folder","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"folder","searchable":true,"sortable":true}},"folderPath":{"edit":{"label":"folderPath","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"folderPath","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}}},"layouts":{"list":["id","name","alternativeText","caption"],"edit":[[{"name":"name","size":6},{"name":"alternativeText","size":6}],[{"name":"caption","size":6},{"name":"width","size":4}],[{"name":"height","size":4}],[{"name":"formats","size":12}],[{"name":"hash","size":6},{"name":"ext","size":6}],[{"name":"mime","size":6},{"name":"size","size":4}],[{"name":"url","size":6},{"name":"previewUrl","size":6}],[{"name":"provider","size":6}],[{"name":"provider_metadata","size":12}],[{"name":"folder","size":6},{"name":"folderPath","size":6}]]}}	object	\N	\N
13	plugin_content_manager_configuration_content_types::plugin::users-permissions.user	{"uid":"plugin::users-permissions.user","settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"username","defaultSortBy":"username","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"username":{"edit":{"label":"username","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"username","searchable":true,"sortable":true}},"email":{"edit":{"label":"email","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"email","searchable":true,"sortable":true}},"provider":{"edit":{"label":"provider","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"provider","searchable":true,"sortable":true}},"password":{"edit":{"label":"password","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"password","searchable":true,"sortable":true}},"resetPasswordToken":{"edit":{"label":"resetPasswordToken","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"resetPasswordToken","searchable":true,"sortable":true}},"confirmationToken":{"edit":{"label":"confirmationToken","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"confirmationToken","searchable":true,"sortable":true}},"confirmed":{"edit":{"label":"confirmed","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"confirmed","searchable":true,"sortable":true}},"blocked":{"edit":{"label":"blocked","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"blocked","searchable":true,"sortable":true}},"role":{"edit":{"label":"role","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"role","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}}},"layouts":{"list":["id","username","email","confirmed"],"edit":[[{"name":"username","size":6},{"name":"email","size":6}],[{"name":"password","size":6},{"name":"confirmed","size":4}],[{"name":"blocked","size":4},{"name":"role","size":6}]]}}	object	\N	\N
1	strapi_content_types_schema	{"admin::permission":{"collectionName":"admin_permissions","info":{"name":"Permission","description":"","singularName":"permission","pluralName":"permissions","displayName":"Permission"},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"action":{"type":"string","minLength":1,"configurable":false,"required":true},"subject":{"type":"string","minLength":1,"configurable":false,"required":false},"properties":{"type":"json","configurable":false,"required":false,"default":{}},"conditions":{"type":"json","configurable":false,"required":false,"default":[]},"role":{"configurable":false,"type":"relation","relation":"manyToOne","inversedBy":"permissions","target":"admin::role"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true}},"kind":"collectionType","__schema__":{"collectionName":"admin_permissions","info":{"name":"Permission","description":"","singularName":"permission","pluralName":"permissions","displayName":"Permission"},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"action":{"type":"string","minLength":1,"configurable":false,"required":true},"subject":{"type":"string","minLength":1,"configurable":false,"required":false},"properties":{"type":"json","configurable":false,"required":false,"default":{}},"conditions":{"type":"json","configurable":false,"required":false,"default":[]},"role":{"configurable":false,"type":"relation","relation":"manyToOne","inversedBy":"permissions","target":"admin::role"}},"kind":"collectionType"},"modelType":"contentType","modelName":"permission","connection":"default","uid":"admin::permission","plugin":"admin","globalId":"AdminPermission"},"admin::user":{"collectionName":"admin_users","info":{"name":"User","description":"","singularName":"user","pluralName":"users","displayName":"User"},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"firstname":{"type":"string","unique":false,"minLength":1,"configurable":false,"required":false},"lastname":{"type":"string","unique":false,"minLength":1,"configurable":false,"required":false},"username":{"type":"string","unique":false,"configurable":false,"required":false},"email":{"type":"email","minLength":6,"configurable":false,"required":true,"unique":true,"private":true},"password":{"type":"password","minLength":6,"configurable":false,"required":false,"private":true,"searchable":false},"resetPasswordToken":{"type":"string","configurable":false,"private":true,"searchable":false},"registrationToken":{"type":"string","configurable":false,"private":true,"searchable":false},"isActive":{"type":"boolean","default":false,"configurable":false,"private":true},"roles":{"configurable":false,"private":true,"type":"relation","relation":"manyToMany","inversedBy":"users","target":"admin::role","collectionName":"strapi_users_roles"},"blocked":{"type":"boolean","default":false,"configurable":false,"private":true},"preferedLanguage":{"type":"string","configurable":false,"required":false,"searchable":false},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true}},"kind":"collectionType","__schema__":{"collectionName":"admin_users","info":{"name":"User","description":"","singularName":"user","pluralName":"users","displayName":"User"},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"firstname":{"type":"string","unique":false,"minLength":1,"configurable":false,"required":false},"lastname":{"type":"string","unique":false,"minLength":1,"configurable":false,"required":false},"username":{"type":"string","unique":false,"configurable":false,"required":false},"email":{"type":"email","minLength":6,"configurable":false,"required":true,"unique":true,"private":true},"password":{"type":"password","minLength":6,"configurable":false,"required":false,"private":true,"searchable":false},"resetPasswordToken":{"type":"string","configurable":false,"private":true,"searchable":false},"registrationToken":{"type":"string","configurable":false,"private":true,"searchable":false},"isActive":{"type":"boolean","default":false,"configurable":false,"private":true},"roles":{"configurable":false,"private":true,"type":"relation","relation":"manyToMany","inversedBy":"users","target":"admin::role","collectionName":"strapi_users_roles"},"blocked":{"type":"boolean","default":false,"configurable":false,"private":true},"preferedLanguage":{"type":"string","configurable":false,"required":false,"searchable":false}},"kind":"collectionType"},"modelType":"contentType","modelName":"user","connection":"default","uid":"admin::user","plugin":"admin","globalId":"AdminUser"},"admin::role":{"collectionName":"admin_roles","info":{"name":"Role","description":"","singularName":"role","pluralName":"roles","displayName":"Role"},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","minLength":1,"unique":true,"configurable":false,"required":true},"code":{"type":"string","minLength":1,"unique":true,"configurable":false,"required":true},"description":{"type":"string","configurable":false},"users":{"configurable":false,"type":"relation","relation":"manyToMany","mappedBy":"roles","target":"admin::user"},"permissions":{"configurable":false,"type":"relation","relation":"oneToMany","mappedBy":"role","target":"admin::permission"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true}},"kind":"collectionType","__schema__":{"collectionName":"admin_roles","info":{"name":"Role","description":"","singularName":"role","pluralName":"roles","displayName":"Role"},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","minLength":1,"unique":true,"configurable":false,"required":true},"code":{"type":"string","minLength":1,"unique":true,"configurable":false,"required":true},"description":{"type":"string","configurable":false},"users":{"configurable":false,"type":"relation","relation":"manyToMany","mappedBy":"roles","target":"admin::user"},"permissions":{"configurable":false,"type":"relation","relation":"oneToMany","mappedBy":"role","target":"admin::permission"}},"kind":"collectionType"},"modelType":"contentType","modelName":"role","connection":"default","uid":"admin::role","plugin":"admin","globalId":"AdminRole"},"admin::api-token":{"collectionName":"strapi_api_tokens","info":{"name":"Api Token","singularName":"api-token","pluralName":"api-tokens","displayName":"Api Token","description":""},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","minLength":1,"configurable":false,"required":true,"unique":true},"description":{"type":"string","minLength":1,"configurable":false,"required":false,"default":""},"type":{"type":"enumeration","enum":["read-only","full-access","custom"],"configurable":false,"required":true,"default":"read-only"},"accessKey":{"type":"string","minLength":1,"configurable":false,"required":true,"searchable":false},"lastUsedAt":{"type":"datetime","configurable":false,"required":false},"permissions":{"type":"relation","target":"admin::api-token-permission","relation":"oneToMany","mappedBy":"token","configurable":false,"required":false},"expiresAt":{"type":"datetime","configurable":false,"required":false},"lifespan":{"type":"biginteger","configurable":false,"required":false},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true}},"kind":"collectionType","__schema__":{"collectionName":"strapi_api_tokens","info":{"name":"Api Token","singularName":"api-token","pluralName":"api-tokens","displayName":"Api Token","description":""},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","minLength":1,"configurable":false,"required":true,"unique":true},"description":{"type":"string","minLength":1,"configurable":false,"required":false,"default":""},"type":{"type":"enumeration","enum":["read-only","full-access","custom"],"configurable":false,"required":true,"default":"read-only"},"accessKey":{"type":"string","minLength":1,"configurable":false,"required":true,"searchable":false},"lastUsedAt":{"type":"datetime","configurable":false,"required":false},"permissions":{"type":"relation","target":"admin::api-token-permission","relation":"oneToMany","mappedBy":"token","configurable":false,"required":false},"expiresAt":{"type":"datetime","configurable":false,"required":false},"lifespan":{"type":"biginteger","configurable":false,"required":false}},"kind":"collectionType"},"modelType":"contentType","modelName":"api-token","connection":"default","uid":"admin::api-token","plugin":"admin","globalId":"AdminApiToken"},"admin::api-token-permission":{"collectionName":"strapi_api_token_permissions","info":{"name":"API Token Permission","description":"","singularName":"api-token-permission","pluralName":"api-token-permissions","displayName":"API Token Permission"},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"action":{"type":"string","minLength":1,"configurable":false,"required":true},"token":{"configurable":false,"type":"relation","relation":"manyToOne","inversedBy":"permissions","target":"admin::api-token"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true}},"kind":"collectionType","__schema__":{"collectionName":"strapi_api_token_permissions","info":{"name":"API Token Permission","description":"","singularName":"api-token-permission","pluralName":"api-token-permissions","displayName":"API Token Permission"},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"action":{"type":"string","minLength":1,"configurable":false,"required":true},"token":{"configurable":false,"type":"relation","relation":"manyToOne","inversedBy":"permissions","target":"admin::api-token"}},"kind":"collectionType"},"modelType":"contentType","modelName":"api-token-permission","connection":"default","uid":"admin::api-token-permission","plugin":"admin","globalId":"AdminApiTokenPermission"},"admin::transfer-token":{"collectionName":"strapi_transfer_tokens","info":{"name":"Transfer Token","singularName":"transfer-token","pluralName":"transfer-tokens","displayName":"Transfer Token","description":""},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","minLength":1,"configurable":false,"required":true,"unique":true},"description":{"type":"string","minLength":1,"configurable":false,"required":false,"default":""},"accessKey":{"type":"string","minLength":1,"configurable":false,"required":true},"lastUsedAt":{"type":"datetime","configurable":false,"required":false},"permissions":{"type":"relation","target":"admin::transfer-token-permission","relation":"oneToMany","mappedBy":"token","configurable":false,"required":false},"expiresAt":{"type":"datetime","configurable":false,"required":false},"lifespan":{"type":"biginteger","configurable":false,"required":false},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true}},"kind":"collectionType","__schema__":{"collectionName":"strapi_transfer_tokens","info":{"name":"Transfer Token","singularName":"transfer-token","pluralName":"transfer-tokens","displayName":"Transfer Token","description":""},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","minLength":1,"configurable":false,"required":true,"unique":true},"description":{"type":"string","minLength":1,"configurable":false,"required":false,"default":""},"accessKey":{"type":"string","minLength":1,"configurable":false,"required":true},"lastUsedAt":{"type":"datetime","configurable":false,"required":false},"permissions":{"type":"relation","target":"admin::transfer-token-permission","relation":"oneToMany","mappedBy":"token","configurable":false,"required":false},"expiresAt":{"type":"datetime","configurable":false,"required":false},"lifespan":{"type":"biginteger","configurable":false,"required":false}},"kind":"collectionType"},"modelType":"contentType","modelName":"transfer-token","connection":"default","uid":"admin::transfer-token","plugin":"admin","globalId":"AdminTransferToken"},"admin::transfer-token-permission":{"collectionName":"strapi_transfer_token_permissions","info":{"name":"Transfer Token Permission","description":"","singularName":"transfer-token-permission","pluralName":"transfer-token-permissions","displayName":"Transfer Token Permission"},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"action":{"type":"string","minLength":1,"configurable":false,"required":true},"token":{"configurable":false,"type":"relation","relation":"manyToOne","inversedBy":"permissions","target":"admin::transfer-token"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true}},"kind":"collectionType","__schema__":{"collectionName":"strapi_transfer_token_permissions","info":{"name":"Transfer Token Permission","description":"","singularName":"transfer-token-permission","pluralName":"transfer-token-permissions","displayName":"Transfer Token Permission"},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"action":{"type":"string","minLength":1,"configurable":false,"required":true},"token":{"configurable":false,"type":"relation","relation":"manyToOne","inversedBy":"permissions","target":"admin::transfer-token"}},"kind":"collectionType"},"modelType":"contentType","modelName":"transfer-token-permission","connection":"default","uid":"admin::transfer-token-permission","plugin":"admin","globalId":"AdminTransferTokenPermission"},"plugin::upload.file":{"collectionName":"files","info":{"singularName":"file","pluralName":"files","displayName":"File","description":""},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","configurable":false,"required":true},"alternativeText":{"type":"string","configurable":false},"caption":{"type":"string","configurable":false},"width":{"type":"integer","configurable":false},"height":{"type":"integer","configurable":false},"formats":{"type":"json","configurable":false},"hash":{"type":"string","configurable":false,"required":true},"ext":{"type":"string","configurable":false},"mime":{"type":"string","configurable":false,"required":true},"size":{"type":"decimal","configurable":false,"required":true},"url":{"type":"string","configurable":false,"required":true},"previewUrl":{"type":"string","configurable":false},"provider":{"type":"string","configurable":false,"required":true},"provider_metadata":{"type":"json","configurable":false},"related":{"type":"relation","relation":"morphToMany","configurable":false},"folder":{"type":"relation","relation":"manyToOne","target":"plugin::upload.folder","inversedBy":"files","private":true},"folderPath":{"type":"string","min":1,"required":true,"private":true,"searchable":false},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true}},"indexes":[{"name":"upload_files_folder_path_index","columns":["folder_path"],"type":null},{"name":"upload_files_created_at_index","columns":["created_at"],"type":null},{"name":"upload_files_updated_at_index","columns":["updated_at"],"type":null},{"name":"upload_files_name_index","columns":["name"],"type":null},{"name":"upload_files_size_index","columns":["size"],"type":null},{"name":"upload_files_ext_index","columns":["ext"],"type":null}],"kind":"collectionType","__schema__":{"collectionName":"files","info":{"singularName":"file","pluralName":"files","displayName":"File","description":""},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","configurable":false,"required":true},"alternativeText":{"type":"string","configurable":false},"caption":{"type":"string","configurable":false},"width":{"type":"integer","configurable":false},"height":{"type":"integer","configurable":false},"formats":{"type":"json","configurable":false},"hash":{"type":"string","configurable":false,"required":true},"ext":{"type":"string","configurable":false},"mime":{"type":"string","configurable":false,"required":true},"size":{"type":"decimal","configurable":false,"required":true},"url":{"type":"string","configurable":false,"required":true},"previewUrl":{"type":"string","configurable":false},"provider":{"type":"string","configurable":false,"required":true},"provider_metadata":{"type":"json","configurable":false},"related":{"type":"relation","relation":"morphToMany","configurable":false},"folder":{"type":"relation","relation":"manyToOne","target":"plugin::upload.folder","inversedBy":"files","private":true},"folderPath":{"type":"string","min":1,"required":true,"private":true,"searchable":false}},"kind":"collectionType"},"modelType":"contentType","modelName":"file","connection":"default","uid":"plugin::upload.file","plugin":"upload","globalId":"UploadFile"},"plugin::upload.folder":{"collectionName":"upload_folders","info":{"singularName":"folder","pluralName":"folders","displayName":"Folder"},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","min":1,"required":true},"pathId":{"type":"integer","unique":true,"required":true},"parent":{"type":"relation","relation":"manyToOne","target":"plugin::upload.folder","inversedBy":"children"},"children":{"type":"relation","relation":"oneToMany","target":"plugin::upload.folder","mappedBy":"parent"},"files":{"type":"relation","relation":"oneToMany","target":"plugin::upload.file","mappedBy":"folder"},"path":{"type":"string","min":1,"required":true},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true}},"indexes":[{"name":"upload_folders_path_id_index","columns":["path_id"],"type":"unique"},{"name":"upload_folders_path_index","columns":["path"],"type":"unique"}],"kind":"collectionType","__schema__":{"collectionName":"upload_folders","info":{"singularName":"folder","pluralName":"folders","displayName":"Folder"},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","min":1,"required":true},"pathId":{"type":"integer","unique":true,"required":true},"parent":{"type":"relation","relation":"manyToOne","target":"plugin::upload.folder","inversedBy":"children"},"children":{"type":"relation","relation":"oneToMany","target":"plugin::upload.folder","mappedBy":"parent"},"files":{"type":"relation","relation":"oneToMany","target":"plugin::upload.file","mappedBy":"folder"},"path":{"type":"string","min":1,"required":true}},"kind":"collectionType"},"modelType":"contentType","modelName":"folder","connection":"default","uid":"plugin::upload.folder","plugin":"upload","globalId":"UploadFolder"},"plugin::i18n.locale":{"info":{"singularName":"locale","pluralName":"locales","collectionName":"locales","displayName":"Locale","description":""},"options":{"draftAndPublish":false},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","min":1,"max":50,"configurable":false},"code":{"type":"string","unique":true,"configurable":false},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true}},"kind":"collectionType","__schema__":{"info":{"singularName":"locale","pluralName":"locales","collectionName":"locales","displayName":"Locale","description":""},"options":{"draftAndPublish":false},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","min":1,"max":50,"configurable":false},"code":{"type":"string","unique":true,"configurable":false}},"kind":"collectionType"},"modelType":"contentType","modelName":"locale","connection":"default","uid":"plugin::i18n.locale","plugin":"i18n","collectionName":"i18n_locale","globalId":"I18NLocale"},"plugin::users-permissions.permission":{"collectionName":"up_permissions","info":{"name":"permission","description":"","singularName":"permission","pluralName":"permissions","displayName":"Permission"},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"action":{"type":"string","required":true,"configurable":false},"role":{"type":"relation","relation":"manyToOne","target":"plugin::users-permissions.role","inversedBy":"permissions","configurable":false},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true}},"kind":"collectionType","__schema__":{"collectionName":"up_permissions","info":{"name":"permission","description":"","singularName":"permission","pluralName":"permissions","displayName":"Permission"},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"action":{"type":"string","required":true,"configurable":false},"role":{"type":"relation","relation":"manyToOne","target":"plugin::users-permissions.role","inversedBy":"permissions","configurable":false}},"kind":"collectionType"},"modelType":"contentType","modelName":"permission","connection":"default","uid":"plugin::users-permissions.permission","plugin":"users-permissions","globalId":"UsersPermissionsPermission"},"plugin::users-permissions.role":{"collectionName":"up_roles","info":{"name":"role","description":"","singularName":"role","pluralName":"roles","displayName":"Role"},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","minLength":3,"required":true,"configurable":false},"description":{"type":"string","configurable":false},"type":{"type":"string","unique":true,"configurable":false},"permissions":{"type":"relation","relation":"oneToMany","target":"plugin::users-permissions.permission","mappedBy":"role","configurable":false},"users":{"type":"relation","relation":"oneToMany","target":"plugin::users-permissions.user","mappedBy":"role","configurable":false},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true}},"kind":"collectionType","__schema__":{"collectionName":"up_roles","info":{"name":"role","description":"","singularName":"role","pluralName":"roles","displayName":"Role"},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","minLength":3,"required":true,"configurable":false},"description":{"type":"string","configurable":false},"type":{"type":"string","unique":true,"configurable":false},"permissions":{"type":"relation","relation":"oneToMany","target":"plugin::users-permissions.permission","mappedBy":"role","configurable":false},"users":{"type":"relation","relation":"oneToMany","target":"plugin::users-permissions.user","mappedBy":"role","configurable":false}},"kind":"collectionType"},"modelType":"contentType","modelName":"role","connection":"default","uid":"plugin::users-permissions.role","plugin":"users-permissions","globalId":"UsersPermissionsRole"},"plugin::users-permissions.user":{"collectionName":"up_users","info":{"name":"user","description":"","singularName":"user","pluralName":"users","displayName":"User"},"options":{"draftAndPublish":false,"timestamps":true},"attributes":{"username":{"type":"string","minLength":3,"unique":true,"configurable":false,"required":true},"email":{"type":"email","minLength":6,"configurable":false,"required":true},"provider":{"type":"string","configurable":false},"password":{"type":"password","minLength":6,"configurable":false,"private":true,"searchable":false},"resetPasswordToken":{"type":"string","configurable":false,"private":true,"searchable":false},"confirmationToken":{"type":"string","configurable":false,"private":true,"searchable":false},"confirmed":{"type":"boolean","default":false,"configurable":false},"blocked":{"type":"boolean","default":false,"configurable":false},"role":{"type":"relation","relation":"manyToOne","target":"plugin::users-permissions.role","inversedBy":"users","configurable":false},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true}},"config":{"attributes":{"resetPasswordToken":{"hidden":true},"confirmationToken":{"hidden":true},"provider":{"hidden":true}}},"kind":"collectionType","__schema__":{"collectionName":"up_users","info":{"name":"user","description":"","singularName":"user","pluralName":"users","displayName":"User"},"options":{"draftAndPublish":false,"timestamps":true},"attributes":{"username":{"type":"string","minLength":3,"unique":true,"configurable":false,"required":true},"email":{"type":"email","minLength":6,"configurable":false,"required":true},"provider":{"type":"string","configurable":false},"password":{"type":"password","minLength":6,"configurable":false,"private":true,"searchable":false},"resetPasswordToken":{"type":"string","configurable":false,"private":true,"searchable":false},"confirmationToken":{"type":"string","configurable":false,"private":true,"searchable":false},"confirmed":{"type":"boolean","default":false,"configurable":false},"blocked":{"type":"boolean","default":false,"configurable":false},"role":{"type":"relation","relation":"manyToOne","target":"plugin::users-permissions.role","inversedBy":"users","configurable":false}},"kind":"collectionType"},"modelType":"contentType","modelName":"user","connection":"default","uid":"plugin::users-permissions.user","plugin":"users-permissions","globalId":"UsersPermissionsUser"},"api::address-master.address-master":{"kind":"collectionType","collectionName":"address_masters","info":{"singularName":"address-master","pluralName":"address-masters","displayName":"address master","description":""},"options":{"draftAndPublish":true},"pluginOptions":{},"attributes":{"code":{"type":"string","required":true},"type":{"type":"string","required":true},"description":{"type":"string","required":true},"parent_type":{"type":"string","required":true},"parent_code":{"type":"string","required":true},"is_active":{"type":"boolean","default":true,"required":false},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":false},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true}},"__schema__":{"collectionName":"address_masters","info":{"singularName":"address-master","pluralName":"address-masters","displayName":"address master","description":""},"options":{"draftAndPublish":true},"pluginOptions":{},"attributes":{"code":{"type":"string","required":true},"type":{"type":"string","required":true},"description":{"type":"string","required":true},"parent_type":{"type":"string","required":true},"parent_code":{"type":"string","required":true},"is_active":{"type":"boolean","default":true,"required":false}},"kind":"collectionType"},"modelType":"contentType","modelName":"address-master","connection":"default","uid":"api::address-master.address-master","apiName":"address-master","globalId":"AddressMaster","actions":{},"lifecycles":{}},"api::category-info.category-info":{"kind":"collectionType","collectionName":"category_infos","info":{"singularName":"category-info","pluralName":"category-infos","displayName":"Category Info"},"options":{"draftAndPublish":true},"pluginOptions":{},"attributes":{"Category":{"type":"string"},"Code":{"type":"string"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":false},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true}},"__schema__":{"collectionName":"category_infos","info":{"singularName":"category-info","pluralName":"category-infos","displayName":"Category Info"},"options":{"draftAndPublish":true},"pluginOptions":{},"attributes":{"Category":{"type":"string"},"Code":{"type":"string"}},"kind":"collectionType"},"modelType":"contentType","modelName":"category-info","connection":"default","uid":"api::category-info.category-info","apiName":"category-info","globalId":"CategoryInfo","actions":{},"lifecycles":{}},"api::country-master.country-master":{"kind":"collectionType","collectionName":"country_masters","info":{"singularName":"country-master","pluralName":"country-masters","displayName":"country master","description":""},"options":{"draftAndPublish":true},"pluginOptions":{},"attributes":{"code":{"type":"string"},"description":{"type":"string","required":true},"isd_code":{"type":"string","required":true},"iso_code":{"type":"string","required":true},"is_active":{"type":"boolean","default":true,"required":false},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":false},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true}},"__schema__":{"collectionName":"country_masters","info":{"singularName":"country-master","pluralName":"country-masters","displayName":"country master","description":""},"options":{"draftAndPublish":true},"pluginOptions":{},"attributes":{"code":{"type":"string"},"description":{"type":"string","required":true},"isd_code":{"type":"string","required":true},"iso_code":{"type":"string","required":true},"is_active":{"type":"boolean","default":true,"required":false}},"kind":"collectionType"},"modelType":"contentType","modelName":"country-master","connection":"default","uid":"api::country-master.country-master","apiName":"country-master","globalId":"CountryMaster","actions":{},"lifecycles":{}},"api::gen-ai-category.gen-ai-category":{"kind":"collectionType","collectionName":"gen_ai_categories","info":{"singularName":"gen-ai-category","pluralName":"gen-ai-categories","displayName":"GenAiIndustry","description":""},"options":{"draftAndPublish":true},"pluginOptions":{},"attributes":{"industryName":{"type":"string"},"iconifyIcon":{"type":"string"},"gen_ai_industry_cards":{"type":"relation","relation":"oneToMany","target":"api::gen-ai-category-info.gen-ai-category-info","mappedBy":"gen_ai_industry"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":false},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true}},"__schema__":{"collectionName":"gen_ai_categories","info":{"singularName":"gen-ai-category","pluralName":"gen-ai-categories","displayName":"GenAiIndustry","description":""},"options":{"draftAndPublish":true},"pluginOptions":{},"attributes":{"industryName":{"type":"string"},"iconifyIcon":{"type":"string"},"gen_ai_industry_cards":{"type":"relation","relation":"oneToMany","target":"api::gen-ai-category-info.gen-ai-category-info","mappedBy":"gen_ai_industry"}},"kind":"collectionType"},"modelType":"contentType","modelName":"gen-ai-category","connection":"default","uid":"api::gen-ai-category.gen-ai-category","apiName":"gen-ai-category","globalId":"GenAiCategory","actions":{},"lifecycles":{}},"api::gen-ai-category-info.gen-ai-category-info":{"kind":"collectionType","collectionName":"gen_ai_category_infos","info":{"singularName":"gen-ai-category-info","pluralName":"gen-ai-category-infos","displayName":"GenAiIndustryCard","description":""},"options":{"draftAndPublish":true},"pluginOptions":{},"attributes":{"title":{"type":"string"},"description":{"type":"text"},"externalLink":{"type":"string"},"videoLink":{"type":"string"},"imageCarousel":{"type":"media","multiple":true,"required":false,"allowedTypes":["images","files","videos","audios"]},"coverImageLink":{"type":"media","multiple":false,"required":false,"allowedTypes":["images","files","videos","audios"]},"subTitle":{"type":"string"},"demoLink":{"type":"string"},"gen_ai_industry":{"type":"relation","relation":"manyToOne","target":"api::gen-ai-category.gen-ai-category","inversedBy":"gen_ai_industry_cards"},"rank":{"type":"integer"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":false},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true}},"__schema__":{"collectionName":"gen_ai_category_infos","info":{"singularName":"gen-ai-category-info","pluralName":"gen-ai-category-infos","displayName":"GenAiIndustryCard","description":""},"options":{"draftAndPublish":true},"pluginOptions":{},"attributes":{"title":{"type":"string"},"description":{"type":"text"},"externalLink":{"type":"string"},"videoLink":{"type":"string"},"imageCarousel":{"type":"media","multiple":true,"required":false,"allowedTypes":["images","files","videos","audios"]},"coverImageLink":{"type":"media","multiple":false,"required":false,"allowedTypes":["images","files","videos","audios"]},"subTitle":{"type":"string"},"demoLink":{"type":"string"},"gen_ai_industry":{"type":"relation","relation":"manyToOne","target":"api::gen-ai-category.gen-ai-category","inversedBy":"gen_ai_industry_cards"},"rank":{"type":"integer"}},"kind":"collectionType"},"modelType":"contentType","modelName":"gen-ai-category-info","connection":"default","uid":"api::gen-ai-category-info.gen-ai-category-info","apiName":"gen-ai-category-info","globalId":"GenAiCategoryInfo","actions":{},"lifecycles":{}},"api::lookup-master.lookup-master":{"kind":"collectionType","collectionName":"lookup_masters","info":{"singularName":"lookup-master","pluralName":"lookup-masters","displayName":"lookup master"},"options":{"draftAndPublish":true},"pluginOptions":{},"attributes":{"type":{"type":"string","required":true},"code":{"type":"string","required":true},"description":{"type":"string","required":true},"is_active":{"type":"boolean","default":true},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":false},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true}},"__schema__":{"collectionName":"lookup_masters","info":{"singularName":"lookup-master","pluralName":"lookup-masters","displayName":"lookup master"},"options":{"draftAndPublish":true},"pluginOptions":{},"attributes":{"type":{"type":"string","required":true},"code":{"type":"string","required":true},"description":{"type":"string","required":true},"is_active":{"type":"boolean","default":true}},"kind":"collectionType"},"modelType":"contentType","modelName":"lookup-master","connection":"default","uid":"api::lookup-master.lookup-master","apiName":"lookup-master","globalId":"LookupMaster","actions":{},"lifecycles":{}},"api::rule-additional-fields-description.rule-additional-fields-description":{"kind":"singleType","collectionName":"rule_additional_fields_descriptions","info":{"singularName":"rule-additional-fields-description","pluralName":"rule-additional-fields-descriptions","displayName":"RuleAdditionalFieldsDescription","description":""},"options":{"draftAndPublish":true},"pluginOptions":{},"attributes":{"keyName":{"type":"string"},"valueSql":{"type":"string"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":false},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true}},"__schema__":{"collectionName":"rule_additional_fields_descriptions","info":{"singularName":"rule-additional-fields-description","pluralName":"rule-additional-fields-descriptions","displayName":"RuleAdditionalFieldsDescription","description":""},"options":{"draftAndPublish":true},"pluginOptions":{},"attributes":{"keyName":{"type":"string"},"valueSql":{"type":"string"}},"kind":"singleType"},"modelType":"contentType","modelName":"rule-additional-fields-description","connection":"default","uid":"api::rule-additional-fields-description.rule-additional-fields-description","apiName":"rule-additional-fields-description","globalId":"RuleAdditionalFieldsDescription","actions":{},"lifecycles":{}},"api::rule-creation-fields-description.rule-creation-fields-description":{"kind":"singleType","collectionName":"rule_creation_fields_descriptions","info":{"singularName":"rule-creation-fields-description","pluralName":"rule-creation-fields-descriptions","displayName":"RuleCreationFieldsDescription","description":""},"options":{"draftAndPublish":true},"pluginOptions":{},"attributes":{"ruleName":{"type":"string"},"startDate":{"type":"string"},"endDate":{"type":"string"},"ruleDescription":{"type":"string"},"actionCode":{"type":"string"},"ruleCategory":{"type":"string"},"ruleType":{"type":"string"},"priority":{"type":"string"},"attachmentUrl":{"type":"string"},"screenIdentifier":{"type":"string"},"outputMode":{"type":"string"},"voucherCode":{"type":"string"},"voucherCodeApplicable":{"type":"string"},"channels":{"type":"string"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":false},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true}},"__schema__":{"collectionName":"rule_creation_fields_descriptions","info":{"singularName":"rule-creation-fields-description","pluralName":"rule-creation-fields-descriptions","displayName":"RuleCreationFieldsDescription","description":""},"options":{"draftAndPublish":true},"pluginOptions":{},"attributes":{"ruleName":{"type":"string"},"startDate":{"type":"string"},"endDate":{"type":"string"},"ruleDescription":{"type":"string"},"actionCode":{"type":"string"},"ruleCategory":{"type":"string"},"ruleType":{"type":"string"},"priority":{"type":"string"},"attachmentUrl":{"type":"string"},"screenIdentifier":{"type":"string"},"outputMode":{"type":"string"},"voucherCode":{"type":"string"},"voucherCodeApplicable":{"type":"string"},"channels":{"type":"string"}},"kind":"singleType"},"modelType":"contentType","modelName":"rule-creation-fields-description","connection":"default","uid":"api::rule-creation-fields-description.rule-creation-fields-description","apiName":"rule-creation-fields-description","globalId":"RuleCreationFieldsDescription","actions":{},"lifecycles":{}},"api::rule-execution-fields-description.rule-execution-fields-description":{"kind":"singleType","collectionName":"rule_execution_fields_descriptions","info":{"singularName":"rule-execution-fields-description","pluralName":"rule-execution-fields-descriptions","displayName":"RuleExecutionFieldsDescription","description":""},"options":{"draftAndPublish":true},"pluginOptions":{},"attributes":{"ksqldbCluster":{"type":"string"},"streamName":{"type":"string"},"inputKey":{"type":"string"},"entityId":{"type":"string"},"inputTimestampSql":{"type":"string"},"inputTimestampFormat":{"type":"string"},"inputTimestampTz":{"type":"string"},"outputGenerationType":{"type":"string"},"limitInterval":{"type":"string"},"limitIntervalLogicSql":{"type":"string"},"maxAllowedLimit":{"type":"string"},"generateFalseOutput":{"type":"string"},"generateSameRefNumber":{"type":"string"},"inputLoadType":{"type":"string"},"outputStreamName":{"type":"string"},"ruleConditionSql":{"type":"string"},"dynamicTextSql":{"type":"string"},"expiryDateSql":{"type":"string"},"calculationLogicType":{"type":"string"},"calculationApplyField":{"type":"string"},"maxCalculatedValue":{"type":"string"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":false},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true}},"__schema__":{"collectionName":"rule_execution_fields_descriptions","info":{"singularName":"rule-execution-fields-description","pluralName":"rule-execution-fields-descriptions","displayName":"RuleExecutionFieldsDescription","description":""},"options":{"draftAndPublish":true},"pluginOptions":{},"attributes":{"ksqldbCluster":{"type":"string"},"streamName":{"type":"string"},"inputKey":{"type":"string"},"entityId":{"type":"string"},"inputTimestampSql":{"type":"string"},"inputTimestampFormat":{"type":"string"},"inputTimestampTz":{"type":"string"},"outputGenerationType":{"type":"string"},"limitInterval":{"type":"string"},"limitIntervalLogicSql":{"type":"string"},"maxAllowedLimit":{"type":"string"},"generateFalseOutput":{"type":"string"},"generateSameRefNumber":{"type":"string"},"inputLoadType":{"type":"string"},"outputStreamName":{"type":"string"},"ruleConditionSql":{"type":"string"},"dynamicTextSql":{"type":"string"},"expiryDateSql":{"type":"string"},"calculationLogicType":{"type":"string"},"calculationApplyField":{"type":"string"},"maxCalculatedValue":{"type":"string"}},"kind":"singleType"},"modelType":"contentType","modelName":"rule-execution-fields-description","connection":"default","uid":"api::rule-execution-fields-description.rule-execution-fields-description","apiName":"rule-execution-fields-description","globalId":"RuleExecutionFieldsDescription","actions":{},"lifecycles":{}}}	object	\N	\N
9	plugin_content_manager_configuration_content_types::plugin::upload.folder	{"uid":"plugin::upload.folder","settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"name","defaultSortBy":"name","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"name":{"edit":{"label":"name","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"name","searchable":true,"sortable":true}},"pathId":{"edit":{"label":"pathId","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"pathId","searchable":true,"sortable":true}},"parent":{"edit":{"label":"parent","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"parent","searchable":true,"sortable":true}},"children":{"edit":{"label":"children","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"children","searchable":false,"sortable":false}},"files":{"edit":{"label":"files","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"files","searchable":false,"sortable":false}},"path":{"edit":{"label":"path","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"path","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}}},"layouts":{"list":["id","name","pathId","parent"],"edit":[[{"name":"name","size":6},{"name":"pathId","size":4}],[{"name":"parent","size":6},{"name":"children","size":6}],[{"name":"files","size":6},{"name":"path","size":6}]]}}	object	\N	\N
10	plugin_content_manager_configuration_content_types::admin::role	{"uid":"admin::role","settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"name","defaultSortBy":"name","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"name":{"edit":{"label":"name","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"name","searchable":true,"sortable":true}},"code":{"edit":{"label":"code","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"code","searchable":true,"sortable":true}},"description":{"edit":{"label":"description","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"description","searchable":true,"sortable":true}},"users":{"edit":{"label":"users","description":"","placeholder":"","visible":true,"editable":true,"mainField":"firstname"},"list":{"label":"users","searchable":false,"sortable":false}},"permissions":{"edit":{"label":"permissions","description":"","placeholder":"","visible":true,"editable":true,"mainField":"action"},"list":{"label":"permissions","searchable":false,"sortable":false}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}}},"layouts":{"list":["id","name","code","description"],"edit":[[{"name":"name","size":6},{"name":"code","size":6}],[{"name":"description","size":6},{"name":"users","size":6}],[{"name":"permissions","size":6}]]}}	object	\N	\N
19	plugin_upload_settings	{"sizeOptimization":true,"responsiveDimensions":true,"autoOrientation":false}	object	\N	\N
20	plugin_upload_view_configuration	{"pageSize":10,"sort":"createdAt:DESC"}	object	\N	\N
21	plugin_upload_metrics	{"weeklySchedule":"12 20 4 * * 2","lastWeeklyUpdate":1700540412063}	object	\N	\N
58	plugin_content_manager_configuration_content_types::api::gen-ai-category-info.gen-ai-category-info	{"uid":"api::gen-ai-category-info.gen-ai-category-info","settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":100,"mainField":"title","defaultSortBy":"id","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"title":{"edit":{"label":"title","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"title","searchable":true,"sortable":true}},"description":{"edit":{"label":"description","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"description","searchable":true,"sortable":true}},"externalLink":{"edit":{"label":"externalLink","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"externalLink","searchable":true,"sortable":true}},"videoLink":{"edit":{"label":"videoLink","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"videoLink","searchable":true,"sortable":true}},"imageCarousel":{"edit":{"label":"imageCarousel","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"imageCarousel","searchable":false,"sortable":false}},"coverImageLink":{"edit":{"label":"coverImageLink","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"coverImageLink","searchable":false,"sortable":false}},"subTitle":{"edit":{"label":"subTitle","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"subTitle","searchable":true,"sortable":true}},"demoLink":{"edit":{"label":"demoLink","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"demoLink","searchable":true,"sortable":true}},"gen_ai_industry":{"edit":{"label":"gen_ai_industry","description":"","placeholder":"","visible":true,"editable":true,"mainField":"industryName"},"list":{"label":"gen_ai_industry","searchable":true,"sortable":true}},"rank":{"edit":{"label":"rank","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"rank","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}}},"layouts":{"edit":[[{"name":"gen_ai_industry","size":6},{"name":"externalLink","size":6}],[{"name":"title","size":6},{"name":"videoLink","size":6}],[{"name":"subTitle","size":6},{"name":"demoLink","size":6}],[{"name":"description","size":6}],[{"name":"coverImageLink","size":6},{"name":"imageCarousel","size":6}],[{"name":"rank","size":4}]],"list":["rank","title","subTitle","description","gen_ai_industry","demoLink","externalLink","imageCarousel","videoLink","coverImageLink","createdAt","updatedAt"]}}	object	\N	\N
26	core_admin_auth	{"providers":{"autoRegister":false,"defaultRole":null}}	object	\N	\N
11	plugin_content_manager_configuration_content_types::plugin::users-permissions.permission	{"uid":"plugin::users-permissions.permission","settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"action","defaultSortBy":"action","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"action":{"edit":{"label":"action","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"action","searchable":true,"sortable":true}},"role":{"edit":{"label":"role","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"role","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}}},"layouts":{"list":["id","action","role","createdAt"],"edit":[[{"name":"action","size":6},{"name":"role","size":6}]]}}	object	\N	\N
12	plugin_content_manager_configuration_content_types::plugin::users-permissions.role	{"uid":"plugin::users-permissions.role","settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"name","defaultSortBy":"name","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"name":{"edit":{"label":"name","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"name","searchable":true,"sortable":true}},"description":{"edit":{"label":"description","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"description","searchable":true,"sortable":true}},"type":{"edit":{"label":"type","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"type","searchable":true,"sortable":true}},"permissions":{"edit":{"label":"permissions","description":"","placeholder":"","visible":true,"editable":true,"mainField":"action"},"list":{"label":"permissions","searchable":false,"sortable":false}},"users":{"edit":{"label":"users","description":"","placeholder":"","visible":true,"editable":true,"mainField":"username"},"list":{"label":"users","searchable":false,"sortable":false}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}}},"layouts":{"list":["id","name","description","type"],"edit":[[{"name":"name","size":6},{"name":"description","size":6}],[{"name":"type","size":6},{"name":"permissions","size":6}],[{"name":"users","size":6}]]}}	object	\N	\N
17	plugin_content_manager_configuration_content_types::plugin::i18n.locale	{"uid":"plugin::i18n.locale","settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"name","defaultSortBy":"name","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"name":{"edit":{"label":"name","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"name","searchable":true,"sortable":true}},"code":{"edit":{"label":"code","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"code","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}}},"layouts":{"list":["id","name","code","createdAt"],"edit":[[{"name":"name","size":6},{"name":"code","size":6}]]}}	object	\N	\N
22	plugin_i18n_default_locale	"en"	string	\N	\N
23	plugin_users-permissions_grant	{"email":{"enabled":true,"icon":"envelope"},"discord":{"enabled":false,"icon":"discord","key":"","secret":"","callback":"api/auth/discord/callback","scope":["identify","email"]},"facebook":{"enabled":false,"icon":"facebook-square","key":"","secret":"","callback":"api/auth/facebook/callback","scope":["email"]},"google":{"enabled":false,"icon":"google","key":"","secret":"","callback":"api/auth/google/callback","scope":["email"]},"github":{"enabled":false,"icon":"github","key":"","secret":"","callback":"api/auth/github/callback","scope":["user","user:email"]},"microsoft":{"enabled":false,"icon":"windows","key":"","secret":"","callback":"api/auth/microsoft/callback","scope":["user.read"]},"twitter":{"enabled":false,"icon":"twitter","key":"","secret":"","callback":"api/auth/twitter/callback"},"instagram":{"enabled":false,"icon":"instagram","key":"","secret":"","callback":"api/auth/instagram/callback","scope":["user_profile"]},"vk":{"enabled":false,"icon":"vk","key":"","secret":"","callback":"api/auth/vk/callback","scope":["email"]},"twitch":{"enabled":false,"icon":"twitch","key":"","secret":"","callback":"api/auth/twitch/callback","scope":["user:read:email"]},"linkedin":{"enabled":false,"icon":"linkedin","key":"","secret":"","callback":"api/auth/linkedin/callback","scope":["r_liteprofile","r_emailaddress"]},"cognito":{"enabled":false,"icon":"aws","key":"","secret":"","subdomain":"my.subdomain.com","callback":"api/auth/cognito/callback","scope":["email","openid","profile"]},"reddit":{"enabled":false,"icon":"reddit","key":"","secret":"","state":true,"callback":"api/auth/reddit/callback","scope":["identity"]},"auth0":{"enabled":false,"icon":"","key":"","secret":"","subdomain":"my-tenant.eu","callback":"api/auth/auth0/callback","scope":["openid","email","profile"]},"cas":{"enabled":false,"icon":"book","key":"","secret":"","callback":"api/auth/cas/callback","scope":["openid email"],"subdomain":"my.subdomain.com/cas"},"patreon":{"enabled":false,"icon":"","key":"","secret":"","callback":"api/auth/patreon/callback","scope":["identity","identity[email]"]}}	object	\N	\N
25	plugin_users-permissions_advanced	{"unique_email":true,"allow_register":true,"email_confirmation":true,"email_reset_password":null,"email_confirmation_redirection":"https://classify-cms.xpsapps.xebia.com/admin","default_role":"authenticated"}	object	\N	\N
24	plugin_users-permissions_email	{"reset_password":{"display":"Email.template.reset_password","icon":"sync","options":{"from":{"name":"Administration Panel","email":"no-reply@strapi.io"},"response_email":"","object":"Reset password","message":"<p>We heard that you lost your password. Sorry about that!</p>\\n\\n<p>But don’t worry! You can use the following link to reset your password:</p>\\n<p><%= URL %>?code=<%= TOKEN %></p>\\n\\n<p>Thanks.</p>"}},"email_confirmation":{"display":"Email.template.email_confirmation","icon":"check-square","options":{"from":{"name":"Administration Panel","email":"no-reply@strapi.io"},"response_email":"","object":"Account confirmation","message":"<p>Thank you for registering!</p>\\n\\n<p>You have to confirm your email address. Please click on the link below.</p>\\n\\n<p><%= URL %>?confirmation=<%= CODE %></p>\\n\\n<p>Thanks.</p>"}}}	object	\N	\N
31	core_admin_project-settings	{"menuLogo":{"name":"Stleath_favicon.png","hash":"Stleath_favicon_d6ceda3095","url":"https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/Stleath_favicon_d6ceda3095.png","width":500,"height":500,"ext":".png","size":32.24,"provider":"aws-s3"},"authLogo":{"name":"Xebia_logo.png","hash":"Xebia_logo_16289e42a5","url":"https://pfm-category-image-bucket.s3.ap-south-1.amazonaws.com/CLASSIFY_CMS_STRIPE/Xebia_logo_16289e42a5.png","width":612,"height":202,"ext":".png","size":9.79,"provider":"aws-s3"}}	object	\N	\N
39	plugin_documentation_config	{"restrictedAccess":false}	object	\N	\N
50	plugin_content_manager_configuration_content_types::api::category-info.category-info	{"uid":"api::category-info.category-info","settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"Category","defaultSortBy":"Category","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"Category":{"edit":{"label":"Category","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"Category","searchable":true,"sortable":true}},"Code":{"edit":{"label":"Code","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"Code","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}}},"layouts":{"list":["id","Category","Code","createdAt"],"edit":[[{"name":"Category","size":6},{"name":"Code","size":6}]]}}	object	\N	\N
53	plugin_content_manager_configuration_content_types::api::rule-execution-fields-description.rule-execution-fields-description	{"uid":"api::rule-execution-fields-description.rule-execution-fields-description","settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"ksqldbCluster","defaultSortBy":"ksqldbCluster","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"ksqldbCluster":{"edit":{"label":"ksqldbCluster","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"ksqldbCluster","searchable":true,"sortable":true}},"streamName":{"edit":{"label":"streamName","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"streamName","searchable":true,"sortable":true}},"inputKey":{"edit":{"label":"inputKey","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"inputKey","searchable":true,"sortable":true}},"entityId":{"edit":{"label":"entityId","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"entityId","searchable":true,"sortable":true}},"inputTimestampSql":{"edit":{"label":"inputTimestampSql","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"inputTimestampSql","searchable":true,"sortable":true}},"inputTimestampFormat":{"edit":{"label":"inputTimestampFormat","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"inputTimestampFormat","searchable":true,"sortable":true}},"inputTimestampTz":{"edit":{"label":"inputTimestampTz","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"inputTimestampTz","searchable":true,"sortable":true}},"outputGenerationType":{"edit":{"label":"outputGenerationType","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"outputGenerationType","searchable":true,"sortable":true}},"limitInterval":{"edit":{"label":"limitInterval","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"limitInterval","searchable":true,"sortable":true}},"limitIntervalLogicSql":{"edit":{"label":"limitIntervalLogicSql","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"limitIntervalLogicSql","searchable":true,"sortable":true}},"maxAllowedLimit":{"edit":{"label":"maxAllowedLimit","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"maxAllowedLimit","searchable":true,"sortable":true}},"generateFalseOutput":{"edit":{"label":"generateFalseOutput","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"generateFalseOutput","searchable":true,"sortable":true}},"generateSameRefNumber":{"edit":{"label":"generateSameRefNumber","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"generateSameRefNumber","searchable":true,"sortable":true}},"inputLoadType":{"edit":{"label":"inputLoadType","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"inputLoadType","searchable":true,"sortable":true}},"outputStreamName":{"edit":{"label":"outputStreamName","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"outputStreamName","searchable":true,"sortable":true}},"ruleConditionSql":{"edit":{"label":"ruleConditionSql","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"ruleConditionSql","searchable":true,"sortable":true}},"dynamicTextSql":{"edit":{"label":"dynamicTextSql","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"dynamicTextSql","searchable":true,"sortable":true}},"expiryDateSql":{"edit":{"label":"expiryDateSql","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"expiryDateSql","searchable":true,"sortable":true}},"calculationLogicType":{"edit":{"label":"calculationLogicType","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"calculationLogicType","searchable":true,"sortable":true}},"calculationApplyField":{"edit":{"label":"calculationApplyField","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"calculationApplyField","searchable":true,"sortable":true}},"maxCalculatedValue":{"edit":{"label":"maxCalculatedValue","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"maxCalculatedValue","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}}},"layouts":{"list":["id","createdAt","updatedAt","ksqldbCluster"],"edit":[[{"name":"ksqldbCluster","size":6},{"name":"streamName","size":6}],[{"name":"inputKey","size":6},{"name":"entityId","size":6}],[{"name":"inputTimestampSql","size":6},{"name":"inputTimestampFormat","size":6}],[{"name":"inputTimestampTz","size":6},{"name":"outputGenerationType","size":6}],[{"name":"limitInterval","size":6},{"name":"limitIntervalLogicSql","size":6}],[{"name":"maxAllowedLimit","size":6},{"name":"generateFalseOutput","size":6}],[{"name":"generateSameRefNumber","size":6},{"name":"inputLoadType","size":6}],[{"name":"outputStreamName","size":6},{"name":"ruleConditionSql","size":6}],[{"name":"dynamicTextSql","size":6},{"name":"expiryDateSql","size":6}],[{"name":"calculationLogicType","size":6}],[{"name":"maxCalculatedValue","size":6},{"name":"calculationApplyField","size":6}]]}}	object	\N	\N
54	plugin_content_manager_configuration_content_types::api::rule-additional-fields-description.rule-additional-fields-description	{"uid":"api::rule-additional-fields-description.rule-additional-fields-description","settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"keyName","defaultSortBy":"keyName","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"keyName":{"edit":{"label":"keyName","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"keyName","searchable":true,"sortable":true}},"valueSql":{"edit":{"label":"valueSql","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"valueSql","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}}},"layouts":{"list":["id","keyName","createdAt","updatedAt"],"edit":[[{"name":"keyName","size":6},{"name":"valueSql","size":6}]]}}	object	\N	\N
51	plugin_content_manager_configuration_content_types::api::rule-creation-fields-description.rule-creation-fields-description	{"uid":"api::rule-creation-fields-description.rule-creation-fields-description","settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"ruleName","defaultSortBy":"ruleName","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"ruleName":{"edit":{"label":"ruleName","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"ruleName","searchable":true,"sortable":true}},"startDate":{"edit":{"label":"startDate","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"startDate","searchable":true,"sortable":true}},"endDate":{"edit":{"label":"endDate","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"endDate","searchable":true,"sortable":true}},"ruleDescription":{"edit":{"label":"ruleDescription","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"ruleDescription","searchable":true,"sortable":true}},"actionCode":{"edit":{"label":"actionCode","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"actionCode","searchable":true,"sortable":true}},"ruleCategory":{"edit":{"label":"ruleCategory","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"ruleCategory","searchable":true,"sortable":true}},"ruleType":{"edit":{"label":"ruleType","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"ruleType","searchable":true,"sortable":true}},"priority":{"edit":{"label":"priority","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"priority","searchable":true,"sortable":true}},"attachmentUrl":{"edit":{"label":"attachmentUrl","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"attachmentUrl","searchable":true,"sortable":true}},"screenIdentifier":{"edit":{"label":"screenIdentifier","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"screenIdentifier","searchable":true,"sortable":true}},"outputMode":{"edit":{"label":"outputMode","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"outputMode","searchable":true,"sortable":true}},"voucherCode":{"edit":{"label":"voucherCode","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"voucherCode","searchable":true,"sortable":true}},"voucherCodeApplicable":{"edit":{"label":"voucherCodeApplicable","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"voucherCodeApplicable","searchable":true,"sortable":true}},"channels":{"edit":{"label":"channels","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"channels","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}}},"layouts":{"edit":[[{"name":"ruleName","size":6},{"name":"startDate","size":6}],[{"name":"endDate","size":6},{"name":"ruleDescription","size":6}],[{"name":"actionCode","size":6},{"name":"ruleCategory","size":6}],[{"name":"ruleType","size":6},{"name":"priority","size":6}],[{"name":"attachmentUrl","size":6},{"name":"screenIdentifier","size":6}],[{"name":"outputMode","size":6},{"name":"voucherCode","size":6}],[{"name":"voucherCodeApplicable","size":6},{"name":"channels","size":6}]],"list":["id","ruleName","createdAt","updatedAt"]}}	object	\N	\N
55	plugin_content_manager_configuration_content_types::api::lookup-master.lookup-master	{"uid":"api::lookup-master.lookup-master","settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"type","defaultSortBy":"type","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"type":{"edit":{"label":"type","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"type","searchable":true,"sortable":true}},"code":{"edit":{"label":"code","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"code","searchable":true,"sortable":true}},"description":{"edit":{"label":"description","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"description","searchable":true,"sortable":true}},"is_active":{"edit":{"label":"is_active","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"is_active","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}}},"layouts":{"list":["id","type","code","description"],"edit":[[{"name":"type","size":6},{"name":"code","size":6}],[{"name":"description","size":6},{"name":"is_active","size":4}]]}}	object	\N	\N
57	plugin_content_manager_configuration_content_types::api::country-master.country-master	{"uid":"api::country-master.country-master","settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"code","defaultSortBy":"code","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"code":{"edit":{"label":"code","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"code","searchable":true,"sortable":true}},"description":{"edit":{"label":"description","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"description","searchable":true,"sortable":true}},"isd_code":{"edit":{"label":"isd_code","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"isd_code","searchable":true,"sortable":true}},"iso_code":{"edit":{"label":"iso_code","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"iso_code","searchable":true,"sortable":true}},"is_active":{"edit":{"label":"is_active","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"is_active","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}}},"layouts":{"list":["id","code","createdAt","updatedAt"],"edit":[[{"name":"code","size":6},{"name":"description","size":6}],[{"name":"isd_code","size":6},{"name":"iso_code","size":6}],[{"name":"is_active","size":4}]]}}	object	\N	\N
56	plugin_content_manager_configuration_content_types::api::address-master.address-master	{"uid":"api::address-master.address-master","settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"code","defaultSortBy":"code","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"code":{"edit":{"label":"code","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"code","searchable":true,"sortable":true}},"type":{"edit":{"label":"type","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"type","searchable":true,"sortable":true}},"description":{"edit":{"label":"description","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"description","searchable":true,"sortable":true}},"parent_type":{"edit":{"label":"parent_type","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"parent_type","searchable":true,"sortable":true}},"parent_code":{"edit":{"label":"parent_code","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"parent_code","searchable":true,"sortable":true}},"is_active":{"edit":{"label":"is_active","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"is_active","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}}},"layouts":{"list":["id","code","createdAt","updatedAt"],"edit":[[{"name":"code","size":6},{"name":"type","size":6}],[{"name":"description","size":6},{"name":"parent_type","size":6}],[{"name":"parent_code","size":6},{"name":"is_active","size":4}]]}}	object	\N	\N
59	plugin_content_manager_configuration_content_types::api::gen-ai-category.gen-ai-category	{"uid":"api::gen-ai-category.gen-ai-category","settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"id","defaultSortBy":"industryName","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"industryName":{"edit":{"label":"industryName","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"industryName","searchable":true,"sortable":true}},"iconifyIcon":{"edit":{"label":"iconifyIcon","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"iconifyIcon","searchable":true,"sortable":true}},"gen_ai_industry_cards":{"edit":{"label":"gen_ai_industry_cards","description":"","placeholder":"","visible":true,"editable":true,"mainField":"title"},"list":{"label":"gen_ai_industry_cards","searchable":false,"sortable":false}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}}},"layouts":{"list":["industryName","iconifyIcon","createdAt","updatedAt"],"edit":[[{"name":"industryName","size":6}],[{"name":"iconifyIcon","size":6}]]}}	object	\N	\N
\.


--
-- Data for Name: strapi_database_schema; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.strapi_database_schema (id, schema, "time", hash) FROM stdin;
64	{"tables":[{"name":"strapi_core_store_settings","indexes":[],"foreignKeys":[],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"key","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"value","type":"text","args":["longtext"],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"type","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"environment","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"tag","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"strapi_webhooks","indexes":[],"foreignKeys":[],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"url","type":"text","args":["longtext"],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"headers","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"events","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"enabled","type":"boolean","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"admin_permissions","indexes":[{"name":"admin_permissions_created_by_id_fk","columns":["created_by_id"]},{"name":"admin_permissions_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"admin_permissions_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"admin_permissions_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"action","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"subject","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"properties","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"conditions","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"admin_users","indexes":[{"name":"admin_users_created_by_id_fk","columns":["created_by_id"]},{"name":"admin_users_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"admin_users_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"admin_users_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"firstname","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"lastname","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"username","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"email","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"password","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"reset_password_token","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"registration_token","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"is_active","type":"boolean","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"blocked","type":"boolean","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"prefered_language","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"admin_roles","indexes":[{"name":"admin_roles_created_by_id_fk","columns":["created_by_id"]},{"name":"admin_roles_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"admin_roles_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"admin_roles_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"code","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"description","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"strapi_api_tokens","indexes":[{"name":"strapi_api_tokens_created_by_id_fk","columns":["created_by_id"]},{"name":"strapi_api_tokens_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"strapi_api_tokens_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"strapi_api_tokens_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"description","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"type","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"access_key","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"last_used_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"expires_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"lifespan","type":"bigInteger","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"strapi_api_token_permissions","indexes":[{"name":"strapi_api_token_permissions_created_by_id_fk","columns":["created_by_id"]},{"name":"strapi_api_token_permissions_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"strapi_api_token_permissions_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"strapi_api_token_permissions_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"action","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"strapi_transfer_tokens","indexes":[{"name":"strapi_transfer_tokens_created_by_id_fk","columns":["created_by_id"]},{"name":"strapi_transfer_tokens_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"strapi_transfer_tokens_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"strapi_transfer_tokens_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"description","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"access_key","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"last_used_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"expires_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"lifespan","type":"bigInteger","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"strapi_transfer_token_permissions","indexes":[{"name":"strapi_transfer_token_permissions_created_by_id_fk","columns":["created_by_id"]},{"name":"strapi_transfer_token_permissions_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"strapi_transfer_token_permissions_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"strapi_transfer_token_permissions_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"action","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"files","indexes":[{"name":"upload_files_folder_path_index","columns":["folder_path"],"type":null},{"name":"upload_files_created_at_index","columns":["created_at"],"type":null},{"name":"upload_files_updated_at_index","columns":["updated_at"],"type":null},{"name":"upload_files_name_index","columns":["name"],"type":null},{"name":"upload_files_size_index","columns":["size"],"type":null},{"name":"upload_files_ext_index","columns":["ext"],"type":null},{"name":"files_created_by_id_fk","columns":["created_by_id"]},{"name":"files_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"files_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"files_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"alternative_text","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"caption","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"width","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"height","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"formats","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"hash","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"ext","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"mime","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"size","type":"decimal","args":[10,2],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"url","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"preview_url","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"provider","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"provider_metadata","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"folder_path","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"upload_folders","indexes":[{"name":"upload_folders_path_id_index","columns":["path_id"],"type":"unique"},{"name":"upload_folders_path_index","columns":["path"],"type":"unique"},{"name":"upload_folders_created_by_id_fk","columns":["created_by_id"]},{"name":"upload_folders_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"upload_folders_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"upload_folders_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"path_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"path","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"i18n_locale","indexes":[{"name":"i18n_locale_created_by_id_fk","columns":["created_by_id"]},{"name":"i18n_locale_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"i18n_locale_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"i18n_locale_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"code","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"up_permissions","indexes":[{"name":"up_permissions_created_by_id_fk","columns":["created_by_id"]},{"name":"up_permissions_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"up_permissions_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"up_permissions_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"action","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"up_roles","indexes":[{"name":"up_roles_created_by_id_fk","columns":["created_by_id"]},{"name":"up_roles_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"up_roles_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"up_roles_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"description","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"type","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"up_users","indexes":[{"name":"up_users_created_by_id_fk","columns":["created_by_id"]},{"name":"up_users_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"up_users_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"up_users_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"username","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"email","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"provider","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"password","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"reset_password_token","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"confirmation_token","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"confirmed","type":"boolean","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"blocked","type":"boolean","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"address_masters","indexes":[{"name":"address_masters_created_by_id_fk","columns":["created_by_id"]},{"name":"address_masters_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"address_masters_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"address_masters_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"code","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"type","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"description","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"parent_type","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"parent_code","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"is_active","type":"boolean","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"category_infos","indexes":[{"name":"category_infos_created_by_id_fk","columns":["created_by_id"]},{"name":"category_infos_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"category_infos_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"category_infos_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"category","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"code","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"country_masters","indexes":[{"name":"country_masters_created_by_id_fk","columns":["created_by_id"]},{"name":"country_masters_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"country_masters_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"country_masters_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"code","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"description","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"isd_code","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"iso_code","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"is_active","type":"boolean","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"gen_ai_categories","indexes":[{"name":"gen_ai_categories_created_by_id_fk","columns":["created_by_id"]},{"name":"gen_ai_categories_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"gen_ai_categories_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"gen_ai_categories_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"industry_name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"iconify_icon","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"gen_ai_category_infos","indexes":[{"name":"gen_ai_category_infos_created_by_id_fk","columns":["created_by_id"]},{"name":"gen_ai_category_infos_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"gen_ai_category_infos_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"gen_ai_category_infos_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"title","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"description","type":"text","args":["longtext"],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"external_link","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"video_link","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"sub_title","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"demo_link","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"rank","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"lookup_masters","indexes":[{"name":"lookup_masters_created_by_id_fk","columns":["created_by_id"]},{"name":"lookup_masters_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"lookup_masters_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"lookup_masters_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"type","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"code","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"description","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"is_active","type":"boolean","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"rule_additional_fields_descriptions","indexes":[{"name":"rule_additional_fields_descriptions_created_by_id_fk","columns":["created_by_id"]},{"name":"rule_additional_fields_descriptions_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"rule_additional_fields_descriptions_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"rule_additional_fields_descriptions_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"key_name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"value_sql","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"rule_creation_fields_descriptions","indexes":[{"name":"rule_creation_fields_descriptions_created_by_id_fk","columns":["created_by_id"]},{"name":"rule_creation_fields_descriptions_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"rule_creation_fields_descriptions_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"rule_creation_fields_descriptions_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"rule_name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"start_date","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"end_date","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"rule_description","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"action_code","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"rule_category","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"rule_type","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"priority","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"attachment_url","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"screen_identifier","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"output_mode","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"voucher_code","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"voucher_code_applicable","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"channels","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"rule_execution_fields_descriptions","indexes":[{"name":"rule_execution_fields_descriptions_created_by_id_fk","columns":["created_by_id"]},{"name":"rule_execution_fields_descriptions_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"rule_execution_fields_descriptions_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"rule_execution_fields_descriptions_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"ksqldb_cluster","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"stream_name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"input_key","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"entity_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"input_timestamp_sql","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"input_timestamp_format","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"input_timestamp_tz","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"output_generation_type","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"limit_interval","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"limit_interval_logic_sql","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"max_allowed_limit","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"generate_false_output","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"generate_same_ref_number","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"input_load_type","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"output_stream_name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"rule_condition_sql","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"dynamic_text_sql","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"expiry_date_sql","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"calculation_logic_type","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"calculation_apply_field","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"max_calculated_value","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"admin_permissions_role_links","indexes":[{"name":"admin_permissions_role_links_fk","columns":["permission_id"]},{"name":"admin_permissions_role_links_inv_fk","columns":["role_id"]},{"name":"admin_permissions_role_links_unique","columns":["permission_id","role_id"],"type":"unique"},{"name":"admin_permissions_role_links_order_inv_fk","columns":["permission_order"]}],"foreignKeys":[{"name":"admin_permissions_role_links_fk","columns":["permission_id"],"referencedColumns":["id"],"referencedTable":"admin_permissions","onDelete":"CASCADE"},{"name":"admin_permissions_role_links_inv_fk","columns":["role_id"],"referencedColumns":["id"],"referencedTable":"admin_roles","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"permission_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"role_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"permission_order","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"admin_users_roles_links","indexes":[{"name":"admin_users_roles_links_fk","columns":["user_id"]},{"name":"admin_users_roles_links_inv_fk","columns":["role_id"]},{"name":"admin_users_roles_links_unique","columns":["user_id","role_id"],"type":"unique"},{"name":"admin_users_roles_links_order_fk","columns":["role_order"]},{"name":"admin_users_roles_links_order_inv_fk","columns":["user_order"]}],"foreignKeys":[{"name":"admin_users_roles_links_fk","columns":["user_id"],"referencedColumns":["id"],"referencedTable":"admin_users","onDelete":"CASCADE"},{"name":"admin_users_roles_links_inv_fk","columns":["role_id"],"referencedColumns":["id"],"referencedTable":"admin_roles","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"user_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"role_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"role_order","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"user_order","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"strapi_api_token_permissions_token_links","indexes":[{"name":"strapi_api_token_permissions_token_links_fk","columns":["api_token_permission_id"]},{"name":"strapi_api_token_permissions_token_links_inv_fk","columns":["api_token_id"]},{"name":"strapi_api_token_permissions_token_links_unique","columns":["api_token_permission_id","api_token_id"],"type":"unique"},{"name":"strapi_api_token_permissions_token_links_order_inv_fk","columns":["api_token_permission_order"]}],"foreignKeys":[{"name":"strapi_api_token_permissions_token_links_fk","columns":["api_token_permission_id"],"referencedColumns":["id"],"referencedTable":"strapi_api_token_permissions","onDelete":"CASCADE"},{"name":"strapi_api_token_permissions_token_links_inv_fk","columns":["api_token_id"],"referencedColumns":["id"],"referencedTable":"strapi_api_tokens","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"api_token_permission_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"api_token_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"api_token_permission_order","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"strapi_transfer_token_permissions_token_links","indexes":[{"name":"strapi_transfer_token_permissions_token_links_fk","columns":["transfer_token_permission_id"]},{"name":"strapi_transfer_token_permissions_token_links_inv_fk","columns":["transfer_token_id"]},{"name":"strapi_transfer_token_permissions_token_links_unique","columns":["transfer_token_permission_id","transfer_token_id"],"type":"unique"},{"name":"strapi_transfer_token_permissions_token_links_order_inv_fk","columns":["transfer_token_permission_order"]}],"foreignKeys":[{"name":"strapi_transfer_token_permissions_token_links_fk","columns":["transfer_token_permission_id"],"referencedColumns":["id"],"referencedTable":"strapi_transfer_token_permissions","onDelete":"CASCADE"},{"name":"strapi_transfer_token_permissions_token_links_inv_fk","columns":["transfer_token_id"],"referencedColumns":["id"],"referencedTable":"strapi_transfer_tokens","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"transfer_token_permission_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"transfer_token_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"transfer_token_permission_order","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"files_related_morphs","indexes":[{"name":"files_related_morphs_fk","columns":["file_id"]},{"name":"files_related_morphs_order_index","columns":["order"],"type":null},{"name":"files_related_morphs_id_column_index","columns":["related_id"],"type":null}],"foreignKeys":[{"name":"files_related_morphs_fk","columns":["file_id"],"referencedColumns":["id"],"referencedTable":"files","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"file_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"related_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"related_type","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"field","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"order","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"files_folder_links","indexes":[{"name":"files_folder_links_fk","columns":["file_id"]},{"name":"files_folder_links_inv_fk","columns":["folder_id"]},{"name":"files_folder_links_unique","columns":["file_id","folder_id"],"type":"unique"},{"name":"files_folder_links_order_inv_fk","columns":["file_order"]}],"foreignKeys":[{"name":"files_folder_links_fk","columns":["file_id"],"referencedColumns":["id"],"referencedTable":"files","onDelete":"CASCADE"},{"name":"files_folder_links_inv_fk","columns":["folder_id"],"referencedColumns":["id"],"referencedTable":"upload_folders","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"file_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"folder_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"file_order","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"upload_folders_parent_links","indexes":[{"name":"upload_folders_parent_links_fk","columns":["folder_id"]},{"name":"upload_folders_parent_links_inv_fk","columns":["inv_folder_id"]},{"name":"upload_folders_parent_links_unique","columns":["folder_id","inv_folder_id"],"type":"unique"},{"name":"upload_folders_parent_links_order_inv_fk","columns":["folder_order"]}],"foreignKeys":[{"name":"upload_folders_parent_links_fk","columns":["folder_id"],"referencedColumns":["id"],"referencedTable":"upload_folders","onDelete":"CASCADE"},{"name":"upload_folders_parent_links_inv_fk","columns":["inv_folder_id"],"referencedColumns":["id"],"referencedTable":"upload_folders","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"folder_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"inv_folder_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"folder_order","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"up_permissions_role_links","indexes":[{"name":"up_permissions_role_links_fk","columns":["permission_id"]},{"name":"up_permissions_role_links_inv_fk","columns":["role_id"]},{"name":"up_permissions_role_links_unique","columns":["permission_id","role_id"],"type":"unique"},{"name":"up_permissions_role_links_order_inv_fk","columns":["permission_order"]}],"foreignKeys":[{"name":"up_permissions_role_links_fk","columns":["permission_id"],"referencedColumns":["id"],"referencedTable":"up_permissions","onDelete":"CASCADE"},{"name":"up_permissions_role_links_inv_fk","columns":["role_id"],"referencedColumns":["id"],"referencedTable":"up_roles","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"permission_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"role_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"permission_order","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"up_users_role_links","indexes":[{"name":"up_users_role_links_fk","columns":["user_id"]},{"name":"up_users_role_links_inv_fk","columns":["role_id"]},{"name":"up_users_role_links_unique","columns":["user_id","role_id"],"type":"unique"},{"name":"up_users_role_links_order_inv_fk","columns":["user_order"]}],"foreignKeys":[{"name":"up_users_role_links_fk","columns":["user_id"],"referencedColumns":["id"],"referencedTable":"up_users","onDelete":"CASCADE"},{"name":"up_users_role_links_inv_fk","columns":["role_id"],"referencedColumns":["id"],"referencedTable":"up_roles","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"user_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"role_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"user_order","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"gen_ai_category_infos_gen_ai_industry_links","indexes":[{"name":"gen_ai_category_infos_gen_ai_industry_links_fk","columns":["gen_ai_category_info_id"]},{"name":"gen_ai_category_infos_gen_ai_industry_links_inv_fk","columns":["gen_ai_category_id"]},{"name":"gen_ai_category_infos_gen_ai_industry_links_unique","columns":["gen_ai_category_info_id","gen_ai_category_id"],"type":"unique"},{"name":"gen_ai_category_infos_gen_ai_industry_links_order_inv_fk","columns":["gen_ai_category_info_order"]}],"foreignKeys":[{"name":"gen_ai_category_infos_gen_ai_industry_links_fk","columns":["gen_ai_category_info_id"],"referencedColumns":["id"],"referencedTable":"gen_ai_category_infos","onDelete":"CASCADE"},{"name":"gen_ai_category_infos_gen_ai_industry_links_inv_fk","columns":["gen_ai_category_id"],"referencedColumns":["id"],"referencedTable":"gen_ai_categories","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"gen_ai_category_info_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"gen_ai_category_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"gen_ai_category_info_order","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]}]}	2023-08-16 10:13:16.499	530b1d7449d7106467e2b1a3d3abf9ce
\.


--
-- Data for Name: strapi_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.strapi_migrations (id, name, "time") FROM stdin;
\.


--
-- Data for Name: strapi_transfer_token_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.strapi_transfer_token_permissions (id, action, created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
\.


--
-- Data for Name: strapi_transfer_token_permissions_token_links; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.strapi_transfer_token_permissions_token_links (id, transfer_token_permission_id, transfer_token_id, transfer_token_permission_order) FROM stdin;
\.


--
-- Data for Name: strapi_transfer_tokens; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.strapi_transfer_tokens (id, name, description, access_key, last_used_at, expires_at, lifespan, created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
\.


--
-- Data for Name: strapi_webhooks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.strapi_webhooks (id, name, url, headers, events, enabled) FROM stdin;
\.


--
-- Data for Name: up_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.up_permissions (id, action, created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
1	plugin::users-permissions.user.me	2023-05-08 06:39:52.992	2023-05-08 06:39:52.992	\N	\N
2	plugin::users-permissions.auth.changePassword	2023-05-08 06:39:52.992	2023-05-08 06:39:52.992	\N	\N
3	plugin::users-permissions.auth.callback	2023-05-08 06:39:53.047	2023-05-08 06:39:53.047	\N	\N
4	plugin::users-permissions.auth.connect	2023-05-08 06:39:53.047	2023-05-08 06:39:53.047	\N	\N
5	plugin::users-permissions.auth.forgotPassword	2023-05-08 06:39:53.047	2023-05-08 06:39:53.047	\N	\N
6	plugin::users-permissions.auth.resetPassword	2023-05-08 06:39:53.047	2023-05-08 06:39:53.047	\N	\N
7	plugin::users-permissions.auth.register	2023-05-08 06:39:53.047	2023-05-08 06:39:53.047	\N	\N
8	plugin::users-permissions.auth.emailConfirmation	2023-05-08 06:39:53.047	2023-05-08 06:39:53.047	\N	\N
9	plugin::users-permissions.auth.sendEmailConfirmation	2023-05-08 06:39:53.047	2023-05-08 06:39:53.047	\N	\N
10	plugin::users-permissions.auth.callback	2023-06-01 05:44:26.437	2023-06-01 05:44:26.437	\N	\N
11	plugin::users-permissions.auth.connect	2023-06-01 05:44:26.437	2023-06-01 05:44:26.437	\N	\N
12	plugin::users-permissions.auth.resetPassword	2023-06-01 05:44:26.437	2023-06-01 05:44:26.437	\N	\N
13	plugin::users-permissions.auth.forgotPassword	2023-06-01 05:44:26.437	2023-06-01 05:44:26.437	\N	\N
14	plugin::users-permissions.auth.register	2023-06-01 05:44:26.437	2023-06-01 05:44:26.437	\N	\N
15	plugin::users-permissions.auth.emailConfirmation	2023-06-01 05:44:26.437	2023-06-01 05:44:26.437	\N	\N
16	plugin::users-permissions.auth.sendEmailConfirmation	2023-06-01 05:44:26.437	2023-06-01 05:44:26.437	\N	\N
25	api::rule-additional-fields-description.rule-additional-fields-description.find	2023-06-06 13:07:59.441	2023-06-06 13:07:59.441	\N	\N
26	api::rule-creation-fields-description.rule-creation-fields-description.find	2023-06-06 13:07:59.441	2023-06-06 13:07:59.441	\N	\N
27	api::rule-execution-fields-description.rule-execution-fields-description.find	2023-06-06 13:07:59.441	2023-06-06 13:07:59.441	\N	\N
38	api::gen-ai-category.gen-ai-category.find	2023-08-18 13:05:21.503	2023-08-18 13:05:21.503	\N	\N
39	api::gen-ai-category.gen-ai-category.findOne	2023-08-18 13:05:21.503	2023-08-18 13:05:21.503	\N	\N
40	api::gen-ai-category.gen-ai-category.create	2023-08-18 13:05:21.503	2023-08-18 13:05:21.503	\N	\N
41	api::gen-ai-category.gen-ai-category.update	2023-08-18 13:05:21.503	2023-08-18 13:05:21.503	\N	\N
42	api::gen-ai-category.gen-ai-category.delete	2023-08-18 13:05:21.503	2023-08-18 13:05:21.503	\N	\N
43	api::gen-ai-category-info.gen-ai-category-info.find	2023-08-18 13:05:21.504	2023-08-18 13:05:21.504	\N	\N
44	api::gen-ai-category-info.gen-ai-category-info.findOne	2023-08-18 13:05:21.504	2023-08-18 13:05:21.504	\N	\N
45	api::gen-ai-category-info.gen-ai-category-info.create	2023-08-18 13:05:21.504	2023-08-18 13:05:21.504	\N	\N
46	api::gen-ai-category-info.gen-ai-category-info.update	2023-08-18 13:05:21.504	2023-08-18 13:05:21.504	\N	\N
47	api::gen-ai-category-info.gen-ai-category-info.delete	2023-08-18 13:05:21.504	2023-08-18 13:05:21.504	\N	\N
48	plugin::users-permissions.user.create	2023-09-15 08:07:12.9	2023-09-15 08:07:12.9	\N	\N
49	plugin::users-permissions.user.update	2023-09-15 08:07:12.9	2023-09-15 08:07:12.9	\N	\N
50	plugin::users-permissions.user.find	2023-09-15 08:07:12.9	2023-09-15 08:07:12.9	\N	\N
51	plugin::users-permissions.user.findOne	2023-09-15 08:07:12.9	2023-09-15 08:07:12.9	\N	\N
52	plugin::users-permissions.user.count	2023-09-15 08:07:12.9	2023-09-15 08:07:12.9	\N	\N
53	plugin::users-permissions.user.destroy	2023-09-15 08:07:12.9	2023-09-15 08:07:12.9	\N	\N
54	plugin::users-permissions.role.createRole	2023-09-15 08:07:12.9	2023-09-15 08:07:12.9	\N	\N
55	plugin::users-permissions.role.findOne	2023-09-15 08:07:12.9	2023-09-15 08:07:12.9	\N	\N
56	plugin::users-permissions.role.find	2023-09-15 08:07:12.9	2023-09-15 08:07:12.9	\N	\N
57	plugin::users-permissions.role.updateRole	2023-09-15 08:07:12.9	2023-09-15 08:07:12.9	\N	\N
58	plugin::users-permissions.role.deleteRole	2023-09-15 08:07:12.9	2023-09-15 08:07:12.9	\N	\N
59	plugin::users-permissions.permissions.getPermissions	2023-09-15 08:07:12.9	2023-09-15 08:07:12.9	\N	\N
60	plugin::users-permissions.user.create	2023-09-15 08:07:23.073	2023-09-15 08:07:23.073	\N	\N
61	plugin::users-permissions.user.update	2023-09-15 08:07:23.073	2023-09-15 08:07:23.073	\N	\N
62	plugin::users-permissions.user.find	2023-09-15 08:07:23.073	2023-09-15 08:07:23.073	\N	\N
63	plugin::users-permissions.user.findOne	2023-09-15 08:07:23.073	2023-09-15 08:07:23.073	\N	\N
64	plugin::users-permissions.user.count	2023-09-15 08:07:23.073	2023-09-15 08:07:23.073	\N	\N
65	plugin::users-permissions.user.destroy	2023-09-15 08:07:23.073	2023-09-15 08:07:23.073	\N	\N
66	plugin::users-permissions.user.me	2023-09-15 08:07:23.073	2023-09-15 08:07:23.073	\N	\N
67	plugin::users-permissions.role.createRole	2023-09-15 08:07:23.073	2023-09-15 08:07:23.073	\N	\N
68	plugin::users-permissions.role.findOne	2023-09-15 08:07:23.073	2023-09-15 08:07:23.073	\N	\N
69	plugin::users-permissions.role.find	2023-09-15 08:07:23.073	2023-09-15 08:07:23.073	\N	\N
70	plugin::users-permissions.permissions.getPermissions	2023-09-15 08:07:23.073	2023-09-15 08:07:23.073	\N	\N
71	plugin::users-permissions.role.deleteRole	2023-09-15 08:07:23.073	2023-09-15 08:07:23.073	\N	\N
72	plugin::users-permissions.role.updateRole	2023-09-15 08:07:23.073	2023-09-15 08:07:23.073	\N	\N
\.


--
-- Data for Name: up_permissions_role_links; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.up_permissions_role_links (id, permission_id, role_id, permission_order) FROM stdin;
1	1	1	1
2	2	1	1
3	3	2	1
4	6	2	1
5	5	2	1
6	7	2	1
7	8	2	2
8	4	2	1
9	9	2	2
10	10	1	2
11	11	1	2
12	12	1	2
13	14	1	2
14	13	1	2
15	16	1	3
16	15	1	3
25	26	2	3
26	25	2	3
27	27	2	4
38	38	2	5
39	42	2	5
40	41	2	5
41	40	2	5
42	39	2	5
43	44	2	6
44	47	2	6
45	45	2	6
46	43	2	6
47	46	2	6
48	49	1	4
49	48	1	4
50	52	1	4
51	50	1	4
52	54	1	4
53	51	1	4
54	53	1	5
55	55	1	5
56	56	1	5
57	58	1	5
58	57	1	5
59	59	1	6
61	62	2	7
60	60	2	7
62	61	2	7
63	64	2	7
64	65	2	7
65	66	2	7
66	63	2	7
67	67	2	8
68	70	2	8
69	68	2	8
70	72	2	8
71	71	2	8
72	69	2	8
\.


--
-- Data for Name: up_roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.up_roles (id, name, description, type, created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
1	Authenticated	Default role given to authenticated user.	authenticated	2023-05-08 06:39:52.972	2023-09-15 08:07:12.886	\N	\N
2	Public	Default role given to unauthenticated user.	public	2023-05-08 06:39:52.976	2023-09-15 08:07:23.055	\N	\N
\.


--
-- Data for Name: up_users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.up_users (id, username, email, provider, password, reset_password_token, confirmation_token, confirmed, blocked, created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
4	amantaak-xebia	aman.taak@xebia.com	local	$2a$10$2ZmDXdwsqHhckkQ1j3pZ6.5vR26RTpXQQZ1QBDLvJlIFyZZaNP6.u	\N	\N	t	f	2023-09-15 08:18:42.562	2023-09-15 08:18:42.562	7	7
5	genai-admin	nitin.gupta@xebia.com	local	$2a$10$.WbGpWFcmSXMFLSsiE7QZuV54jQbjzo4XSe3T91bA9.c7SL0huV2q	\N	\N	t	f	2023-09-21 07:43:51.162	2023-09-21 07:43:51.162	7	7
\.


--
-- Data for Name: up_users_role_links; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.up_users_role_links (id, user_id, role_id, user_order) FROM stdin;
5	4	1	1
6	5	1	2
\.


--
-- Data for Name: upload_folders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.upload_folders (id, name, path_id, path, created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
1	GenAI	1	/1	2023-08-14 10:59:36.475	2023-08-14 10:59:36.475	7	7
\.


--
-- Data for Name: upload_folders_parent_links; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.upload_folders_parent_links (id, folder_id, inv_folder_id, folder_order) FROM stdin;
\.


--
-- Name: address_masters_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.address_masters_id_seq', 6, true);


--
-- Name: admin_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.admin_permissions_id_seq', 576, true);


--
-- Name: admin_permissions_role_links_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.admin_permissions_role_links_id_seq', 576, true);


--
-- Name: admin_roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.admin_roles_id_seq', 8, true);


--
-- Name: admin_users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.admin_users_id_seq', 23, true);


--
-- Name: admin_users_roles_links_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.admin_users_roles_links_id_seq', 72, true);


--
-- Name: category_infos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.category_infos_id_seq', 2, true);


--
-- Name: country_masters_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.country_masters_id_seq', 2, true);


--
-- Name: files_folder_links_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.files_folder_links_id_seq', 120, true);


--
-- Name: files_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.files_id_seq', 104, true);


--
-- Name: files_related_morphs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.files_related_morphs_id_seq', 517, true);


--
-- Name: gen_ai_categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.gen_ai_categories_id_seq', 12, true);


--
-- Name: gen_ai_category_infos_gen_ai_industry_links_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.gen_ai_category_infos_gen_ai_industry_links_id_seq', 85, true);


--
-- Name: gen_ai_category_infos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.gen_ai_category_infos_id_seq', 86, true);


--
-- Name: i18n_locale_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.i18n_locale_id_seq', 1, true);


--
-- Name: lookup_masters_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.lookup_masters_id_seq', 2, true);


--
-- Name: rule_additional_fields_descriptions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.rule_additional_fields_descriptions_id_seq', 1, true);


--
-- Name: rule_creation_fields_descriptions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.rule_creation_fields_descriptions_id_seq', 1, true);


--
-- Name: rule_execution_fields_descriptions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.rule_execution_fields_descriptions_id_seq', 1, true);


--
-- Name: strapi_api_token_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.strapi_api_token_permissions_id_seq', 1, false);


--
-- Name: strapi_api_token_permissions_token_links_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.strapi_api_token_permissions_token_links_id_seq', 1, false);


--
-- Name: strapi_api_tokens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.strapi_api_tokens_id_seq', 1, false);


--
-- Name: strapi_core_store_settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.strapi_core_store_settings_id_seq', 59, true);


--
-- Name: strapi_database_schema_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.strapi_database_schema_id_seq', 64, true);


--
-- Name: strapi_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.strapi_migrations_id_seq', 1, false);


--
-- Name: strapi_transfer_token_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.strapi_transfer_token_permissions_id_seq', 1, false);


--
-- Name: strapi_transfer_token_permissions_token_links_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.strapi_transfer_token_permissions_token_links_id_seq', 1, false);


--
-- Name: strapi_transfer_tokens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.strapi_transfer_tokens_id_seq', 1, false);


--
-- Name: strapi_webhooks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.strapi_webhooks_id_seq', 1, false);


--
-- Name: up_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.up_permissions_id_seq', 72, true);


--
-- Name: up_permissions_role_links_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.up_permissions_role_links_id_seq', 72, true);


--
-- Name: up_roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.up_roles_id_seq', 2, true);


--
-- Name: up_users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.up_users_id_seq', 5, true);


--
-- Name: up_users_role_links_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.up_users_role_links_id_seq', 6, true);


--
-- Name: upload_folders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.upload_folders_id_seq', 1, true);


--
-- Name: upload_folders_parent_links_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.upload_folders_parent_links_id_seq', 1, false);


--
-- Name: address_masters address_masters_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.address_masters
    ADD CONSTRAINT address_masters_pkey PRIMARY KEY (id);


--
-- Name: admin_permissions admin_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin_permissions
    ADD CONSTRAINT admin_permissions_pkey PRIMARY KEY (id);


--
-- Name: admin_permissions_role_links admin_permissions_role_links_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin_permissions_role_links
    ADD CONSTRAINT admin_permissions_role_links_pkey PRIMARY KEY (id);


--
-- Name: admin_permissions_role_links admin_permissions_role_links_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin_permissions_role_links
    ADD CONSTRAINT admin_permissions_role_links_unique UNIQUE (permission_id, role_id);


--
-- Name: admin_roles admin_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin_roles
    ADD CONSTRAINT admin_roles_pkey PRIMARY KEY (id);


--
-- Name: admin_users admin_users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin_users
    ADD CONSTRAINT admin_users_pkey PRIMARY KEY (id);


--
-- Name: admin_users_roles_links admin_users_roles_links_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin_users_roles_links
    ADD CONSTRAINT admin_users_roles_links_pkey PRIMARY KEY (id);


--
-- Name: admin_users_roles_links admin_users_roles_links_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin_users_roles_links
    ADD CONSTRAINT admin_users_roles_links_unique UNIQUE (user_id, role_id);


--
-- Name: category_infos category_infos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.category_infos
    ADD CONSTRAINT category_infos_pkey PRIMARY KEY (id);


--
-- Name: country_masters country_masters_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.country_masters
    ADD CONSTRAINT country_masters_pkey PRIMARY KEY (id);


--
-- Name: files_folder_links files_folder_links_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.files_folder_links
    ADD CONSTRAINT files_folder_links_pkey PRIMARY KEY (id);


--
-- Name: files_folder_links files_folder_links_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.files_folder_links
    ADD CONSTRAINT files_folder_links_unique UNIQUE (file_id, folder_id);


--
-- Name: files files_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.files
    ADD CONSTRAINT files_pkey PRIMARY KEY (id);


--
-- Name: files_related_morphs files_related_morphs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.files_related_morphs
    ADD CONSTRAINT files_related_morphs_pkey PRIMARY KEY (id);


--
-- Name: gen_ai_categories gen_ai_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gen_ai_categories
    ADD CONSTRAINT gen_ai_categories_pkey PRIMARY KEY (id);


--
-- Name: gen_ai_category_infos_gen_ai_industry_links gen_ai_category_infos_gen_ai_industry_links_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gen_ai_category_infos_gen_ai_industry_links
    ADD CONSTRAINT gen_ai_category_infos_gen_ai_industry_links_pkey PRIMARY KEY (id);


--
-- Name: gen_ai_category_infos_gen_ai_industry_links gen_ai_category_infos_gen_ai_industry_links_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gen_ai_category_infos_gen_ai_industry_links
    ADD CONSTRAINT gen_ai_category_infos_gen_ai_industry_links_unique UNIQUE (gen_ai_category_info_id, gen_ai_category_id);


--
-- Name: gen_ai_category_infos gen_ai_category_infos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gen_ai_category_infos
    ADD CONSTRAINT gen_ai_category_infos_pkey PRIMARY KEY (id);


--
-- Name: i18n_locale i18n_locale_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.i18n_locale
    ADD CONSTRAINT i18n_locale_pkey PRIMARY KEY (id);


--
-- Name: lookup_masters lookup_masters_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lookup_masters
    ADD CONSTRAINT lookup_masters_pkey PRIMARY KEY (id);


--
-- Name: rule_additional_fields_descriptions rule_additional_fields_descriptions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rule_additional_fields_descriptions
    ADD CONSTRAINT rule_additional_fields_descriptions_pkey PRIMARY KEY (id);


--
-- Name: rule_creation_fields_descriptions rule_creation_fields_descriptions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rule_creation_fields_descriptions
    ADD CONSTRAINT rule_creation_fields_descriptions_pkey PRIMARY KEY (id);


--
-- Name: rule_execution_fields_descriptions rule_execution_fields_descriptions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rule_execution_fields_descriptions
    ADD CONSTRAINT rule_execution_fields_descriptions_pkey PRIMARY KEY (id);


--
-- Name: strapi_api_token_permissions strapi_api_token_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.strapi_api_token_permissions
    ADD CONSTRAINT strapi_api_token_permissions_pkey PRIMARY KEY (id);


--
-- Name: strapi_api_token_permissions_token_links strapi_api_token_permissions_token_links_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.strapi_api_token_permissions_token_links
    ADD CONSTRAINT strapi_api_token_permissions_token_links_pkey PRIMARY KEY (id);


--
-- Name: strapi_api_token_permissions_token_links strapi_api_token_permissions_token_links_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.strapi_api_token_permissions_token_links
    ADD CONSTRAINT strapi_api_token_permissions_token_links_unique UNIQUE (api_token_permission_id, api_token_id);


--
-- Name: strapi_api_tokens strapi_api_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.strapi_api_tokens
    ADD CONSTRAINT strapi_api_tokens_pkey PRIMARY KEY (id);


--
-- Name: strapi_core_store_settings strapi_core_store_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.strapi_core_store_settings
    ADD CONSTRAINT strapi_core_store_settings_pkey PRIMARY KEY (id);


--
-- Name: strapi_database_schema strapi_database_schema_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.strapi_database_schema
    ADD CONSTRAINT strapi_database_schema_pkey PRIMARY KEY (id);


--
-- Name: strapi_migrations strapi_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.strapi_migrations
    ADD CONSTRAINT strapi_migrations_pkey PRIMARY KEY (id);


--
-- Name: strapi_transfer_token_permissions strapi_transfer_token_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.strapi_transfer_token_permissions
    ADD CONSTRAINT strapi_transfer_token_permissions_pkey PRIMARY KEY (id);


--
-- Name: strapi_transfer_token_permissions_token_links strapi_transfer_token_permissions_token_links_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.strapi_transfer_token_permissions_token_links
    ADD CONSTRAINT strapi_transfer_token_permissions_token_links_pkey PRIMARY KEY (id);


--
-- Name: strapi_transfer_token_permissions_token_links strapi_transfer_token_permissions_token_links_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.strapi_transfer_token_permissions_token_links
    ADD CONSTRAINT strapi_transfer_token_permissions_token_links_unique UNIQUE (transfer_token_permission_id, transfer_token_id);


--
-- Name: strapi_transfer_tokens strapi_transfer_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.strapi_transfer_tokens
    ADD CONSTRAINT strapi_transfer_tokens_pkey PRIMARY KEY (id);


--
-- Name: strapi_webhooks strapi_webhooks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.strapi_webhooks
    ADD CONSTRAINT strapi_webhooks_pkey PRIMARY KEY (id);


--
-- Name: up_permissions up_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.up_permissions
    ADD CONSTRAINT up_permissions_pkey PRIMARY KEY (id);


--
-- Name: up_permissions_role_links up_permissions_role_links_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.up_permissions_role_links
    ADD CONSTRAINT up_permissions_role_links_pkey PRIMARY KEY (id);


--
-- Name: up_permissions_role_links up_permissions_role_links_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.up_permissions_role_links
    ADD CONSTRAINT up_permissions_role_links_unique UNIQUE (permission_id, role_id);


--
-- Name: up_roles up_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.up_roles
    ADD CONSTRAINT up_roles_pkey PRIMARY KEY (id);


--
-- Name: up_users up_users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.up_users
    ADD CONSTRAINT up_users_pkey PRIMARY KEY (id);


--
-- Name: up_users_role_links up_users_role_links_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.up_users_role_links
    ADD CONSTRAINT up_users_role_links_pkey PRIMARY KEY (id);


--
-- Name: up_users_role_links up_users_role_links_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.up_users_role_links
    ADD CONSTRAINT up_users_role_links_unique UNIQUE (user_id, role_id);


--
-- Name: upload_folders_parent_links upload_folders_parent_links_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.upload_folders_parent_links
    ADD CONSTRAINT upload_folders_parent_links_pkey PRIMARY KEY (id);


--
-- Name: upload_folders_parent_links upload_folders_parent_links_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.upload_folders_parent_links
    ADD CONSTRAINT upload_folders_parent_links_unique UNIQUE (folder_id, inv_folder_id);


--
-- Name: upload_folders upload_folders_path_id_index; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.upload_folders
    ADD CONSTRAINT upload_folders_path_id_index UNIQUE (path_id);


--
-- Name: upload_folders upload_folders_path_index; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.upload_folders
    ADD CONSTRAINT upload_folders_path_index UNIQUE (path);


--
-- Name: upload_folders upload_folders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.upload_folders
    ADD CONSTRAINT upload_folders_pkey PRIMARY KEY (id);


--
-- Name: address_masters_created_by_id_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX address_masters_created_by_id_fk ON public.address_masters USING btree (created_by_id);


--
-- Name: address_masters_updated_by_id_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX address_masters_updated_by_id_fk ON public.address_masters USING btree (updated_by_id);


--
-- Name: admin_permissions_created_by_id_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX admin_permissions_created_by_id_fk ON public.admin_permissions USING btree (created_by_id);


--
-- Name: admin_permissions_role_links_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX admin_permissions_role_links_fk ON public.admin_permissions_role_links USING btree (permission_id);


--
-- Name: admin_permissions_role_links_inv_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX admin_permissions_role_links_inv_fk ON public.admin_permissions_role_links USING btree (role_id);


--
-- Name: admin_permissions_role_links_order_inv_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX admin_permissions_role_links_order_inv_fk ON public.admin_permissions_role_links USING btree (permission_order);


--
-- Name: admin_permissions_updated_by_id_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX admin_permissions_updated_by_id_fk ON public.admin_permissions USING btree (updated_by_id);


--
-- Name: admin_roles_created_by_id_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX admin_roles_created_by_id_fk ON public.admin_roles USING btree (created_by_id);


--
-- Name: admin_roles_updated_by_id_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX admin_roles_updated_by_id_fk ON public.admin_roles USING btree (updated_by_id);


--
-- Name: admin_users_created_by_id_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX admin_users_created_by_id_fk ON public.admin_users USING btree (created_by_id);


--
-- Name: admin_users_roles_links_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX admin_users_roles_links_fk ON public.admin_users_roles_links USING btree (user_id);


--
-- Name: admin_users_roles_links_inv_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX admin_users_roles_links_inv_fk ON public.admin_users_roles_links USING btree (role_id);


--
-- Name: admin_users_roles_links_order_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX admin_users_roles_links_order_fk ON public.admin_users_roles_links USING btree (role_order);


--
-- Name: admin_users_roles_links_order_inv_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX admin_users_roles_links_order_inv_fk ON public.admin_users_roles_links USING btree (user_order);


--
-- Name: admin_users_updated_by_id_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX admin_users_updated_by_id_fk ON public.admin_users USING btree (updated_by_id);


--
-- Name: category_infos_created_by_id_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX category_infos_created_by_id_fk ON public.category_infos USING btree (created_by_id);


--
-- Name: category_infos_updated_by_id_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX category_infos_updated_by_id_fk ON public.category_infos USING btree (updated_by_id);


--
-- Name: country_masters_created_by_id_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX country_masters_created_by_id_fk ON public.country_masters USING btree (created_by_id);


--
-- Name: country_masters_updated_by_id_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX country_masters_updated_by_id_fk ON public.country_masters USING btree (updated_by_id);


--
-- Name: files_created_by_id_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX files_created_by_id_fk ON public.files USING btree (created_by_id);


--
-- Name: files_folder_links_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX files_folder_links_fk ON public.files_folder_links USING btree (file_id);


--
-- Name: files_folder_links_inv_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX files_folder_links_inv_fk ON public.files_folder_links USING btree (folder_id);


--
-- Name: files_folder_links_order_inv_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX files_folder_links_order_inv_fk ON public.files_folder_links USING btree (file_order);


--
-- Name: files_related_morphs_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX files_related_morphs_fk ON public.files_related_morphs USING btree (file_id);


--
-- Name: files_related_morphs_id_column_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX files_related_morphs_id_column_index ON public.files_related_morphs USING btree (related_id);


--
-- Name: files_related_morphs_order_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX files_related_morphs_order_index ON public.files_related_morphs USING btree ("order");


--
-- Name: files_updated_by_id_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX files_updated_by_id_fk ON public.files USING btree (updated_by_id);


--
-- Name: gen_ai_categories_created_by_id_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX gen_ai_categories_created_by_id_fk ON public.gen_ai_categories USING btree (created_by_id);


--
-- Name: gen_ai_categories_updated_by_id_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX gen_ai_categories_updated_by_id_fk ON public.gen_ai_categories USING btree (updated_by_id);


--
-- Name: gen_ai_category_infos_created_by_id_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX gen_ai_category_infos_created_by_id_fk ON public.gen_ai_category_infos USING btree (created_by_id);


--
-- Name: gen_ai_category_infos_gen_ai_industry_links_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX gen_ai_category_infos_gen_ai_industry_links_fk ON public.gen_ai_category_infos_gen_ai_industry_links USING btree (gen_ai_category_info_id);


--
-- Name: gen_ai_category_infos_gen_ai_industry_links_inv_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX gen_ai_category_infos_gen_ai_industry_links_inv_fk ON public.gen_ai_category_infos_gen_ai_industry_links USING btree (gen_ai_category_id);


--
-- Name: gen_ai_category_infos_gen_ai_industry_links_order_inv_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX gen_ai_category_infos_gen_ai_industry_links_order_inv_fk ON public.gen_ai_category_infos_gen_ai_industry_links USING btree (gen_ai_category_info_order);


--
-- Name: gen_ai_category_infos_updated_by_id_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX gen_ai_category_infos_updated_by_id_fk ON public.gen_ai_category_infos USING btree (updated_by_id);


--
-- Name: i18n_locale_created_by_id_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX i18n_locale_created_by_id_fk ON public.i18n_locale USING btree (created_by_id);


--
-- Name: i18n_locale_updated_by_id_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX i18n_locale_updated_by_id_fk ON public.i18n_locale USING btree (updated_by_id);


--
-- Name: lookup_masters_created_by_id_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX lookup_masters_created_by_id_fk ON public.lookup_masters USING btree (created_by_id);


--
-- Name: lookup_masters_updated_by_id_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX lookup_masters_updated_by_id_fk ON public.lookup_masters USING btree (updated_by_id);


--
-- Name: rule_additional_fields_descriptions_created_by_id_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX rule_additional_fields_descriptions_created_by_id_fk ON public.rule_additional_fields_descriptions USING btree (created_by_id);


--
-- Name: rule_additional_fields_descriptions_updated_by_id_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX rule_additional_fields_descriptions_updated_by_id_fk ON public.rule_additional_fields_descriptions USING btree (updated_by_id);


--
-- Name: rule_creation_fields_descriptions_created_by_id_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX rule_creation_fields_descriptions_created_by_id_fk ON public.rule_creation_fields_descriptions USING btree (created_by_id);


--
-- Name: rule_creation_fields_descriptions_updated_by_id_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX rule_creation_fields_descriptions_updated_by_id_fk ON public.rule_creation_fields_descriptions USING btree (updated_by_id);


--
-- Name: rule_execution_fields_descriptions_created_by_id_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX rule_execution_fields_descriptions_created_by_id_fk ON public.rule_execution_fields_descriptions USING btree (created_by_id);


--
-- Name: rule_execution_fields_descriptions_updated_by_id_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX rule_execution_fields_descriptions_updated_by_id_fk ON public.rule_execution_fields_descriptions USING btree (updated_by_id);


--
-- Name: strapi_api_token_permissions_created_by_id_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX strapi_api_token_permissions_created_by_id_fk ON public.strapi_api_token_permissions USING btree (created_by_id);


--
-- Name: strapi_api_token_permissions_token_links_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX strapi_api_token_permissions_token_links_fk ON public.strapi_api_token_permissions_token_links USING btree (api_token_permission_id);


--
-- Name: strapi_api_token_permissions_token_links_inv_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX strapi_api_token_permissions_token_links_inv_fk ON public.strapi_api_token_permissions_token_links USING btree (api_token_id);


--
-- Name: strapi_api_token_permissions_token_links_order_inv_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX strapi_api_token_permissions_token_links_order_inv_fk ON public.strapi_api_token_permissions_token_links USING btree (api_token_permission_order);


--
-- Name: strapi_api_token_permissions_updated_by_id_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX strapi_api_token_permissions_updated_by_id_fk ON public.strapi_api_token_permissions USING btree (updated_by_id);


--
-- Name: strapi_api_tokens_created_by_id_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX strapi_api_tokens_created_by_id_fk ON public.strapi_api_tokens USING btree (created_by_id);


--
-- Name: strapi_api_tokens_updated_by_id_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX strapi_api_tokens_updated_by_id_fk ON public.strapi_api_tokens USING btree (updated_by_id);


--
-- Name: strapi_transfer_token_permissions_created_by_id_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX strapi_transfer_token_permissions_created_by_id_fk ON public.strapi_transfer_token_permissions USING btree (created_by_id);


--
-- Name: strapi_transfer_token_permissions_token_links_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX strapi_transfer_token_permissions_token_links_fk ON public.strapi_transfer_token_permissions_token_links USING btree (transfer_token_permission_id);


--
-- Name: strapi_transfer_token_permissions_token_links_inv_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX strapi_transfer_token_permissions_token_links_inv_fk ON public.strapi_transfer_token_permissions_token_links USING btree (transfer_token_id);


--
-- Name: strapi_transfer_token_permissions_token_links_order_inv_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX strapi_transfer_token_permissions_token_links_order_inv_fk ON public.strapi_transfer_token_permissions_token_links USING btree (transfer_token_permission_order);


--
-- Name: strapi_transfer_token_permissions_updated_by_id_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX strapi_transfer_token_permissions_updated_by_id_fk ON public.strapi_transfer_token_permissions USING btree (updated_by_id);


--
-- Name: strapi_transfer_tokens_created_by_id_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX strapi_transfer_tokens_created_by_id_fk ON public.strapi_transfer_tokens USING btree (created_by_id);


--
-- Name: strapi_transfer_tokens_updated_by_id_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX strapi_transfer_tokens_updated_by_id_fk ON public.strapi_transfer_tokens USING btree (updated_by_id);


--
-- Name: up_permissions_created_by_id_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX up_permissions_created_by_id_fk ON public.up_permissions USING btree (created_by_id);


--
-- Name: up_permissions_role_links_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX up_permissions_role_links_fk ON public.up_permissions_role_links USING btree (permission_id);


--
-- Name: up_permissions_role_links_inv_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX up_permissions_role_links_inv_fk ON public.up_permissions_role_links USING btree (role_id);


--
-- Name: up_permissions_role_links_order_inv_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX up_permissions_role_links_order_inv_fk ON public.up_permissions_role_links USING btree (permission_order);


--
-- Name: up_permissions_updated_by_id_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX up_permissions_updated_by_id_fk ON public.up_permissions USING btree (updated_by_id);


--
-- Name: up_roles_created_by_id_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX up_roles_created_by_id_fk ON public.up_roles USING btree (created_by_id);


--
-- Name: up_roles_updated_by_id_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX up_roles_updated_by_id_fk ON public.up_roles USING btree (updated_by_id);


--
-- Name: up_users_created_by_id_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX up_users_created_by_id_fk ON public.up_users USING btree (created_by_id);


--
-- Name: up_users_role_links_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX up_users_role_links_fk ON public.up_users_role_links USING btree (user_id);


--
-- Name: up_users_role_links_inv_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX up_users_role_links_inv_fk ON public.up_users_role_links USING btree (role_id);


--
-- Name: up_users_role_links_order_inv_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX up_users_role_links_order_inv_fk ON public.up_users_role_links USING btree (user_order);


--
-- Name: up_users_updated_by_id_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX up_users_updated_by_id_fk ON public.up_users USING btree (updated_by_id);


--
-- Name: upload_files_created_at_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX upload_files_created_at_index ON public.files USING btree (created_at);


--
-- Name: upload_files_ext_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX upload_files_ext_index ON public.files USING btree (ext);


--
-- Name: upload_files_folder_path_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX upload_files_folder_path_index ON public.files USING btree (folder_path);


--
-- Name: upload_files_name_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX upload_files_name_index ON public.files USING btree (name);


--
-- Name: upload_files_size_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX upload_files_size_index ON public.files USING btree (size);


--
-- Name: upload_files_updated_at_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX upload_files_updated_at_index ON public.files USING btree (updated_at);


--
-- Name: upload_folders_created_by_id_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX upload_folders_created_by_id_fk ON public.upload_folders USING btree (created_by_id);


--
-- Name: upload_folders_parent_links_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX upload_folders_parent_links_fk ON public.upload_folders_parent_links USING btree (folder_id);


--
-- Name: upload_folders_parent_links_inv_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX upload_folders_parent_links_inv_fk ON public.upload_folders_parent_links USING btree (inv_folder_id);


--
-- Name: upload_folders_parent_links_order_inv_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX upload_folders_parent_links_order_inv_fk ON public.upload_folders_parent_links USING btree (folder_order);


--
-- Name: upload_folders_updated_by_id_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX upload_folders_updated_by_id_fk ON public.upload_folders USING btree (updated_by_id);


--
-- Name: address_masters address_masters_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.address_masters
    ADD CONSTRAINT address_masters_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: address_masters address_masters_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.address_masters
    ADD CONSTRAINT address_masters_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: admin_permissions admin_permissions_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin_permissions
    ADD CONSTRAINT admin_permissions_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: admin_permissions_role_links admin_permissions_role_links_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin_permissions_role_links
    ADD CONSTRAINT admin_permissions_role_links_fk FOREIGN KEY (permission_id) REFERENCES public.admin_permissions(id) ON DELETE CASCADE;


--
-- Name: admin_permissions_role_links admin_permissions_role_links_inv_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin_permissions_role_links
    ADD CONSTRAINT admin_permissions_role_links_inv_fk FOREIGN KEY (role_id) REFERENCES public.admin_roles(id) ON DELETE CASCADE;


--
-- Name: admin_permissions admin_permissions_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin_permissions
    ADD CONSTRAINT admin_permissions_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: admin_roles admin_roles_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin_roles
    ADD CONSTRAINT admin_roles_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: admin_roles admin_roles_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin_roles
    ADD CONSTRAINT admin_roles_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: admin_users admin_users_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin_users
    ADD CONSTRAINT admin_users_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: admin_users_roles_links admin_users_roles_links_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin_users_roles_links
    ADD CONSTRAINT admin_users_roles_links_fk FOREIGN KEY (user_id) REFERENCES public.admin_users(id) ON DELETE CASCADE;


--
-- Name: admin_users_roles_links admin_users_roles_links_inv_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin_users_roles_links
    ADD CONSTRAINT admin_users_roles_links_inv_fk FOREIGN KEY (role_id) REFERENCES public.admin_roles(id) ON DELETE CASCADE;


--
-- Name: admin_users admin_users_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin_users
    ADD CONSTRAINT admin_users_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: category_infos category_infos_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.category_infos
    ADD CONSTRAINT category_infos_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: category_infos category_infos_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.category_infos
    ADD CONSTRAINT category_infos_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: country_masters country_masters_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.country_masters
    ADD CONSTRAINT country_masters_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: country_masters country_masters_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.country_masters
    ADD CONSTRAINT country_masters_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: files files_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.files
    ADD CONSTRAINT files_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: files_folder_links files_folder_links_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.files_folder_links
    ADD CONSTRAINT files_folder_links_fk FOREIGN KEY (file_id) REFERENCES public.files(id) ON DELETE CASCADE;


--
-- Name: files_folder_links files_folder_links_inv_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.files_folder_links
    ADD CONSTRAINT files_folder_links_inv_fk FOREIGN KEY (folder_id) REFERENCES public.upload_folders(id) ON DELETE CASCADE;


--
-- Name: files_related_morphs files_related_morphs_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.files_related_morphs
    ADD CONSTRAINT files_related_morphs_fk FOREIGN KEY (file_id) REFERENCES public.files(id) ON DELETE CASCADE;


--
-- Name: files files_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.files
    ADD CONSTRAINT files_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: gen_ai_categories gen_ai_categories_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gen_ai_categories
    ADD CONSTRAINT gen_ai_categories_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: gen_ai_categories gen_ai_categories_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gen_ai_categories
    ADD CONSTRAINT gen_ai_categories_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: gen_ai_category_infos gen_ai_category_infos_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gen_ai_category_infos
    ADD CONSTRAINT gen_ai_category_infos_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: gen_ai_category_infos_gen_ai_industry_links gen_ai_category_infos_gen_ai_industry_links_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gen_ai_category_infos_gen_ai_industry_links
    ADD CONSTRAINT gen_ai_category_infos_gen_ai_industry_links_fk FOREIGN KEY (gen_ai_category_info_id) REFERENCES public.gen_ai_category_infos(id) ON DELETE CASCADE;


--
-- Name: gen_ai_category_infos_gen_ai_industry_links gen_ai_category_infos_gen_ai_industry_links_inv_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gen_ai_category_infos_gen_ai_industry_links
    ADD CONSTRAINT gen_ai_category_infos_gen_ai_industry_links_inv_fk FOREIGN KEY (gen_ai_category_id) REFERENCES public.gen_ai_categories(id) ON DELETE CASCADE;


--
-- Name: gen_ai_category_infos gen_ai_category_infos_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gen_ai_category_infos
    ADD CONSTRAINT gen_ai_category_infos_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: i18n_locale i18n_locale_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.i18n_locale
    ADD CONSTRAINT i18n_locale_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: i18n_locale i18n_locale_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.i18n_locale
    ADD CONSTRAINT i18n_locale_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: lookup_masters lookup_masters_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lookup_masters
    ADD CONSTRAINT lookup_masters_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: lookup_masters lookup_masters_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lookup_masters
    ADD CONSTRAINT lookup_masters_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: rule_additional_fields_descriptions rule_additional_fields_descriptions_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rule_additional_fields_descriptions
    ADD CONSTRAINT rule_additional_fields_descriptions_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: rule_additional_fields_descriptions rule_additional_fields_descriptions_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rule_additional_fields_descriptions
    ADD CONSTRAINT rule_additional_fields_descriptions_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: rule_creation_fields_descriptions rule_creation_fields_descriptions_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rule_creation_fields_descriptions
    ADD CONSTRAINT rule_creation_fields_descriptions_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: rule_creation_fields_descriptions rule_creation_fields_descriptions_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rule_creation_fields_descriptions
    ADD CONSTRAINT rule_creation_fields_descriptions_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: rule_execution_fields_descriptions rule_execution_fields_descriptions_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rule_execution_fields_descriptions
    ADD CONSTRAINT rule_execution_fields_descriptions_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: rule_execution_fields_descriptions rule_execution_fields_descriptions_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rule_execution_fields_descriptions
    ADD CONSTRAINT rule_execution_fields_descriptions_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: strapi_api_token_permissions strapi_api_token_permissions_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.strapi_api_token_permissions
    ADD CONSTRAINT strapi_api_token_permissions_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: strapi_api_token_permissions_token_links strapi_api_token_permissions_token_links_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.strapi_api_token_permissions_token_links
    ADD CONSTRAINT strapi_api_token_permissions_token_links_fk FOREIGN KEY (api_token_permission_id) REFERENCES public.strapi_api_token_permissions(id) ON DELETE CASCADE;


--
-- Name: strapi_api_token_permissions_token_links strapi_api_token_permissions_token_links_inv_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.strapi_api_token_permissions_token_links
    ADD CONSTRAINT strapi_api_token_permissions_token_links_inv_fk FOREIGN KEY (api_token_id) REFERENCES public.strapi_api_tokens(id) ON DELETE CASCADE;


--
-- Name: strapi_api_token_permissions strapi_api_token_permissions_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.strapi_api_token_permissions
    ADD CONSTRAINT strapi_api_token_permissions_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: strapi_api_tokens strapi_api_tokens_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.strapi_api_tokens
    ADD CONSTRAINT strapi_api_tokens_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: strapi_api_tokens strapi_api_tokens_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.strapi_api_tokens
    ADD CONSTRAINT strapi_api_tokens_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: strapi_transfer_token_permissions strapi_transfer_token_permissions_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.strapi_transfer_token_permissions
    ADD CONSTRAINT strapi_transfer_token_permissions_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: strapi_transfer_token_permissions_token_links strapi_transfer_token_permissions_token_links_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.strapi_transfer_token_permissions_token_links
    ADD CONSTRAINT strapi_transfer_token_permissions_token_links_fk FOREIGN KEY (transfer_token_permission_id) REFERENCES public.strapi_transfer_token_permissions(id) ON DELETE CASCADE;


--
-- Name: strapi_transfer_token_permissions_token_links strapi_transfer_token_permissions_token_links_inv_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.strapi_transfer_token_permissions_token_links
    ADD CONSTRAINT strapi_transfer_token_permissions_token_links_inv_fk FOREIGN KEY (transfer_token_id) REFERENCES public.strapi_transfer_tokens(id) ON DELETE CASCADE;


--
-- Name: strapi_transfer_token_permissions strapi_transfer_token_permissions_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.strapi_transfer_token_permissions
    ADD CONSTRAINT strapi_transfer_token_permissions_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: strapi_transfer_tokens strapi_transfer_tokens_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.strapi_transfer_tokens
    ADD CONSTRAINT strapi_transfer_tokens_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: strapi_transfer_tokens strapi_transfer_tokens_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.strapi_transfer_tokens
    ADD CONSTRAINT strapi_transfer_tokens_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: up_permissions up_permissions_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.up_permissions
    ADD CONSTRAINT up_permissions_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: up_permissions_role_links up_permissions_role_links_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.up_permissions_role_links
    ADD CONSTRAINT up_permissions_role_links_fk FOREIGN KEY (permission_id) REFERENCES public.up_permissions(id) ON DELETE CASCADE;


--
-- Name: up_permissions_role_links up_permissions_role_links_inv_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.up_permissions_role_links
    ADD CONSTRAINT up_permissions_role_links_inv_fk FOREIGN KEY (role_id) REFERENCES public.up_roles(id) ON DELETE CASCADE;


--
-- Name: up_permissions up_permissions_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.up_permissions
    ADD CONSTRAINT up_permissions_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: up_roles up_roles_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.up_roles
    ADD CONSTRAINT up_roles_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: up_roles up_roles_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.up_roles
    ADD CONSTRAINT up_roles_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: up_users up_users_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.up_users
    ADD CONSTRAINT up_users_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: up_users_role_links up_users_role_links_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.up_users_role_links
    ADD CONSTRAINT up_users_role_links_fk FOREIGN KEY (user_id) REFERENCES public.up_users(id) ON DELETE CASCADE;


--
-- Name: up_users_role_links up_users_role_links_inv_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.up_users_role_links
    ADD CONSTRAINT up_users_role_links_inv_fk FOREIGN KEY (role_id) REFERENCES public.up_roles(id) ON DELETE CASCADE;


--
-- Name: up_users up_users_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.up_users
    ADD CONSTRAINT up_users_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: upload_folders upload_folders_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.upload_folders
    ADD CONSTRAINT upload_folders_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: upload_folders_parent_links upload_folders_parent_links_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.upload_folders_parent_links
    ADD CONSTRAINT upload_folders_parent_links_fk FOREIGN KEY (folder_id) REFERENCES public.upload_folders(id) ON DELETE CASCADE;


--
-- Name: upload_folders_parent_links upload_folders_parent_links_inv_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.upload_folders_parent_links
    ADD CONSTRAINT upload_folders_parent_links_inv_fk FOREIGN KEY (inv_folder_id) REFERENCES public.upload_folders(id) ON DELETE CASCADE;


--
-- Name: upload_folders upload_folders_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.upload_folders
    ADD CONSTRAINT upload_folders_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--


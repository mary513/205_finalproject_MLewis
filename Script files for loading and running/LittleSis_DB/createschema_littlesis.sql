

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;


CREATE TABLE alias (
    id bigint,
    entity_id bigint,
    name character varying(200),
    context character varying(50),
    is_primary integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    last_user_id integer
);


ALTER TABLE alias OWNER TO postgres;

--
-- Name: business; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE business (
    id bigint,
    annual_profit bigint,
    entity_id bigint
);


ALTER TABLE business OWNER TO postgres;

--
-- Name: business_industry; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE business_industry (
    id bigint,
    business_id bigint,
    industry_id bigint
);


ALTER TABLE business_industry OWNER TO postgres;

--
-- Name: business_person; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE business_person (
    id bigint,
    sec_cik bigint,
    entity_id bigint
);


ALTER TABLE business_person OWNER TO postgres;

--
-- Name: custom_key; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE custom_key (
    id bigint,
    name character varying(50),
    value text,
    description character varying(200),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    object_model character varying(50),
    object_id bigint
);


ALTER TABLE custom_key OWNER TO postgres;

--
-- Name: degree; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE degree (
    id bigint,
    name character varying(50),
    abbreviation character varying(10)
);


ALTER TABLE degree OWNER TO postgres;

--
-- Name: domain; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE domain (
    id bigint,
    name character varying(40),
    url character varying(200)
);


ALTER TABLE domain OWNER TO postgres;

--
-- Name: donation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE donation (
    id bigint,
    bundler_id bigint,
    relationship_id bigint
);


ALTER TABLE donation OWNER TO postgres;

--
-- Name: education; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE education (
    id bigint,
    degree_id bigint,
    field character varying(30),
    is_dropout character(1),
    relationship_id bigint
);


ALTER TABLE education OWNER TO postgres;

--
-- Name: elected_representative; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE elected_representative (
    id bigint,
    bioguide_id character varying(20),
    govtrack_id character varying(20),
    crp_id character varying(20),
    pvs_id character varying(20),
    watchdog_id character varying(50),
    entity_id bigint
);


ALTER TABLE elected_representative OWNER TO postgres;

--
-- Name: entity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE entity (
    id bigint,
    name character varying(200),
    blurb text,
    summary text,
    notes text,
    website character varying(100),
    parent_id bigint,
    primary_ext character varying(50),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    start_date character varying(10),
    end_date character varying(10),
    is_current character(1),
    is_deleted character(1),
    last_user_id integer,
    merged_id integer,
    delta character(1)
);


ALTER TABLE entity OWNER TO postgres;

--
-- Name: extension_definition; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE extension_definition (
    id bigint,
    name character varying(30),
    display_name character varying(50),
    has_fields character(1),
    parent_id bigint,
    tier bigint
);


ALTER TABLE extension_definition OWNER TO postgres;

--
-- Name: extension_record; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE extension_record (
    id bigint,
    entity_id bigint,
    definition_id bigint,
    last_user_id integer
);


ALTER TABLE extension_record OWNER TO postgres;

--
-- Name: external_key; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE external_key (
    id bigint,
    entity_id bigint,
    external_id character varying(200),
    domain_id bigint
);


ALTER TABLE external_key OWNER TO postgres;

--
-- Name: family; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE family (
    id bigint,
    is_nonbiological character(1),
    relationship_id bigint
);


ALTER TABLE family OWNER TO postgres;

--
-- Name: fec_filing; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE fec_filing (
    id bigint,
    relationship_id bigint,
    amount bigint,
    fec_filing_id character varying(30),
    crp_cycle bigint,
    crp_id character varying(30),
    start_date character varying(10),
    end_date character varying(10),
    is_current character(1)
);


ALTER TABLE fec_filing OWNER TO postgres;

--
-- Name: fedspending_filing; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE fedspending_filing (
    id bigint,
    relationship_id bigint,
    amount bigint,
    goods text,
    district_id bigint,
    fedspending_id character varying(30),
    start_date character varying(10),
    end_date character varying(10),
    is_current character(1)
);


ALTER TABLE fedspending_filing OWNER TO postgres;

--
-- Name: gender; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE gender (
    id bigint,
    name character varying(10)
);


ALTER TABLE gender OWNER TO postgres;

--
-- Name: government_body; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE government_body (
    id bigint,
    is_federal character(1),
    state_id bigint,
    city character varying(50),
    county character varying(50),
    entity_id bigint
);


ALTER TABLE government_body OWNER TO postgres;

--
-- Name: industry; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE industry (
    id bigint,
    name character varying(100),
    context character varying(30),
    code character varying(30),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE industry OWNER TO postgres;

--
-- Name: link; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE link (
    id bigint,
    entity1_id bigint,
    entity2_id bigint,
    category_id bigint,
    relationship_id bigint,
    is_reverse character(1)
);


ALTER TABLE link OWNER TO postgres;

--
-- Name: ls_list; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE ls_list (
    id bigint,
    name character varying(100),
    description text,
    is_ranked character(1),
    is_admin character(1),
    is_featured character(1),
    is_network character(1),
    display_name character varying(50),
    featured_list_id bigint,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    last_user_id integer,
    is_deleted character(1)
);


ALTER TABLE ls_list OWNER TO postgres;

--
-- Name: ls_list_entity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE ls_list_entity (
    id bigint,
    list_id bigint,
    entity_id bigint,
    rank bigint,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    last_user_id integer,
    is_deleted character(1)
);


ALTER TABLE ls_list_entity OWNER TO postgres;

--
-- Name: membership; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE membership (
    id bigint,
    dues bigint,
    relationship_id bigint
);


ALTER TABLE membership OWNER TO postgres;

--
-- Name: org; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE org (
    id bigint,
    name character varying(200),
    name_nick character varying(100),
    employees bigint,
    revenue bigint,
    fedspending_id character varying(10),
    lda_registrant_id character varying(10),
    entity_id bigint
);


ALTER TABLE org OWNER TO postgres;

--
-- Name: ownership; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE ownership (
    id bigint,
    percent_stake bigint,
    shares bigint,
    relationship_id bigint
);


ALTER TABLE ownership OWNER TO postgres;

--
-- Name: person; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE person (
    id bigint,
    name_last character varying(50),
    name_first character varying(50),
    name_middle character varying(150),
    name_prefix character varying(30),
    name_suffix character varying(30),
    name_nick character varying(30),
    birthplace character varying(50),
    gender_id bigint,
    party_id bigint,
    is_independent character(1),
    net_worth bigint,
    entity_id bigint
);


ALTER TABLE person OWNER TO postgres;

--
-- Name: political_candidate; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE political_candidate (
    id bigint,
    is_federal character(1),
    is_state character(1),
    is_local character(1),
    pres_fec_id character varying(20),
    senate_fec_id character varying(20),
    house_fec_id character varying(20),
    crp_id character varying(20),
    entity_id bigint
);


ALTER TABLE political_candidate OWNER TO postgres;

--
-- Name: political_fundraising; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE political_fundraising (
    id bigint,
    fec_id character varying(20),
    type_id bigint,
    state_id bigint,
    entity_id bigint
);


ALTER TABLE political_fundraising OWNER TO postgres;

--
-- Name: political_fundraising_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE political_fundraising_type (
    id bigint,
    name character varying(50)
);


ALTER TABLE political_fundraising_type OWNER TO postgres;

--
-- Name: position; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE position (
    id bigint,
    is_board character(1),
    is_executive character(1),
    is_employee character(1),
    compensation bigint,
    boss_id bigint,
    relationship_id bigint
);


ALTER TABLE position OWNER TO postgres;

--
-- Name: professional; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE professional (
    id bigint,
    relationship_id bigint
);


ALTER TABLE professional OWNER TO postgres;

--
-- Name: public_company; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public_company (
    id bigint,
    ticker character varying(10),
    sec_cik bigint,
    entity_id bigint
);


ALTER TABLE public_company OWNER TO postgres;

--
-- Name: reference; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE reference (
    id bigint,
    fields character varying(200),
    name character varying(200),
    source character varying(200),
    source_detail character varying(50),
    publication_date character varying(10),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    object_model character varying(50),
    object_id bigint,
    last_user_id integer
);


ALTER TABLE reference OWNER TO postgres;


--
-- Name: relationship Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE relationship (
    id bigint,
    entity1_id bigint,
    entity2_id bigint,
    category_id bigint,
    description1 text,
    description2 text,
    amount bigint,
    goods text,
    filings bigint,
    notes text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    start_date character varying(10),
    end_date character varying(10),
    is_current character(1),
    is_deleted character(1),
    last_user_id integer
);


ALTER TABLE relationship OWNER TO postgres;

--
-- Name: relationship_category Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE relationship_category (
    id bigint,
    name character varying(30),
    display_name character varying(30),
    default_description character varying(50),
    entity1_requirements text,
    entity2_requirements text,
    has_fields character(1),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE relationship_category OWNER TO postgres;


--
-- Name: school Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE school (
    id bigint,
    endowment bigint,
    students bigint,
    faculty bigint,
    tuition bigint,
    is_private character(1),
    entity_id bigint
);


ALTER TABLE school OWNER TO postgres;


--
-- Name: social Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE social (
    id bigint,
    relationship_id bigint
);


ALTER TABLE social OWNER TO postgres;

--
-- Name: transaction Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE transaction (
    id bigint,
    contact1_id bigint,
    contact2_id bigint,
    district_id bigint,
    is_lobbying character(1),
    relationship_id bigint
);


ALTER TABLE transaction OWNER TO postgres;






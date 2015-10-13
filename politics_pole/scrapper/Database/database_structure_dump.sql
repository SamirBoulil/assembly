--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: politics_pole; Type: DATABASE; Schema: -; Owner: Samir
--

CREATE DATABASE politics_pole WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.UTF-8' LC_CTYPE = 'en_US.UTF-8';


ALTER DATABASE politics_pole OWNER TO "Samir";

\connect politics_pole

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: Decree; Type: TABLE; Schema: public; Owner: Samir; Tablespace: 
--

CREATE TABLE "Decree" (
    id integer NOT NULL,
    number integer NOT NULL,
    title text NOT NULL,
    link text,
    date date
);


ALTER TABLE "Decree" OWNER TO "Samir";

--
-- Name: Decree_id_seq; Type: SEQUENCE; Schema: public; Owner: Samir
--

CREATE SEQUENCE "Decree_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "Decree_id_seq" OWNER TO "Samir";

--
-- Name: Decree_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Samir
--

ALTER SEQUENCE "Decree_id_seq" OWNED BY "Decree".id;


--
-- Name: Deputy; Type: TABLE; Schema: public; Owner: Samir; Tablespace: 
--

CREATE TABLE "Deputy" (
    id integer NOT NULL,
    surname text NOT NULL,
    name text NOT NULL,
    slug text NOT NULL,
    party_id integer NOT NULL,
    pub_date date
);


ALTER TABLE "Deputy" OWNER TO "Samir";

--
-- Name: Deputy_id_seq; Type: SEQUENCE; Schema: public; Owner: Samir
--

CREATE SEQUENCE "Deputy_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "Deputy_id_seq" OWNER TO "Samir";

--
-- Name: Deputy_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Samir
--

ALTER SEQUENCE "Deputy_id_seq" OWNED BY "Deputy".id;


--
-- Name: Party; Type: TABLE; Schema: public; Owner: Samir; Tablespace: 
--

CREATE TABLE "Party" (
    id integer NOT NULL,
    name text NOT NULL
);


ALTER TABLE "Party" OWNER TO "Samir";

--
-- Name: Party_id_seq; Type: SEQUENCE; Schema: public; Owner: Samir
--

CREATE SEQUENCE "Party_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "Party_id_seq" OWNER TO "Samir";

--
-- Name: Party_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Samir
--

ALTER SEQUENCE "Party_id_seq" OWNED BY "Party".id;


--
-- Name: Vote; Type: TABLE; Schema: public; Owner: Samir; Tablespace: 
--

CREATE TABLE "Vote" (
    id integer NOT NULL,
    deputy_id integer NOT NULL,
    decree_id integer NOT NULL,
    vote_value integer NOT NULL
);


ALTER TABLE "Vote" OWNER TO "Samir";

--
-- Name: Vote_id_seq; Type: SEQUENCE; Schema: public; Owner: Samir
--

CREATE SEQUENCE "Vote_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "Vote_id_seq" OWNER TO "Samir";

--
-- Name: Vote_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Samir
--

ALTER SEQUENCE "Vote_id_seq" OWNED BY "Vote".id;


--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: Samir; Tablespace: 
--

CREATE TABLE auth_group (
    id integer NOT NULL,
    name character varying(80) NOT NULL
);


ALTER TABLE auth_group OWNER TO "Samir";

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: Samir
--

CREATE SEQUENCE auth_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth_group_id_seq OWNER TO "Samir";

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Samir
--

ALTER SEQUENCE auth_group_id_seq OWNED BY auth_group.id;


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: Samir; Tablespace: 
--

CREATE TABLE auth_group_permissions (
    id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE auth_group_permissions OWNER TO "Samir";

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: Samir
--

CREATE SEQUENCE auth_group_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth_group_permissions_id_seq OWNER TO "Samir";

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Samir
--

ALTER SEQUENCE auth_group_permissions_id_seq OWNED BY auth_group_permissions.id;


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: Samir; Tablespace: 
--

CREATE TABLE auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE auth_permission OWNER TO "Samir";

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: Samir
--

CREATE SEQUENCE auth_permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth_permission_id_seq OWNER TO "Samir";

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Samir
--

ALTER SEQUENCE auth_permission_id_seq OWNED BY auth_permission.id;


--
-- Name: auth_user; Type: TABLE; Schema: public; Owner: Samir; Tablespace: 
--

CREATE TABLE auth_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(30) NOT NULL,
    first_name character varying(30) NOT NULL,
    last_name character varying(30) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL
);


ALTER TABLE auth_user OWNER TO "Samir";

--
-- Name: auth_user_groups; Type: TABLE; Schema: public; Owner: Samir; Tablespace: 
--

CREATE TABLE auth_user_groups (
    id integer NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE auth_user_groups OWNER TO "Samir";

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: Samir
--

CREATE SEQUENCE auth_user_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth_user_groups_id_seq OWNER TO "Samir";

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Samir
--

ALTER SEQUENCE auth_user_groups_id_seq OWNED BY auth_user_groups.id;


--
-- Name: auth_user_id_seq; Type: SEQUENCE; Schema: public; Owner: Samir
--

CREATE SEQUENCE auth_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth_user_id_seq OWNER TO "Samir";

--
-- Name: auth_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Samir
--

ALTER SEQUENCE auth_user_id_seq OWNED BY auth_user.id;


--
-- Name: auth_user_user_permissions; Type: TABLE; Schema: public; Owner: Samir; Tablespace: 
--

CREATE TABLE auth_user_user_permissions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE auth_user_user_permissions OWNER TO "Samir";

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: Samir
--

CREATE SEQUENCE auth_user_user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth_user_user_permissions_id_seq OWNER TO "Samir";

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Samir
--

ALTER SEQUENCE auth_user_user_permissions_id_seq OWNED BY auth_user_user_permissions.id;


--
-- Name: deputy_statistics; Type: TABLE; Schema: public; Owner: Samir; Tablespace: 
--

CREATE TABLE deputy_statistics (
    id integer,
    name text,
    surname text,
    slug text,
    party_id integer,
    stat_vote_count bigint,
    stat_no_vote double precision,
    stat_participation double precision
);

ALTER TABLE ONLY deputy_statistics REPLICA IDENTITY NOTHING;


ALTER TABLE deputy_statistics OWNER TO "Samir";

--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: Samir; Tablespace: 
--

CREATE TABLE django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE django_content_type OWNER TO "Samir";

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: Samir
--

CREATE SEQUENCE django_content_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE django_content_type_id_seq OWNER TO "Samir";

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Samir
--

ALTER SEQUENCE django_content_type_id_seq OWNED BY django_content_type.id;


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: Samir; Tablespace: 
--

CREATE TABLE django_migrations (
    id integer NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE django_migrations OWNER TO "Samir";

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: Samir
--

CREATE SEQUENCE django_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE django_migrations_id_seq OWNER TO "Samir";

--
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Samir
--

ALTER SEQUENCE django_migrations_id_seq OWNED BY django_migrations.id;


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: Samir; Tablespace: 
--

CREATE TABLE django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE django_session OWNER TO "Samir";

--
-- Name: django_site; Type: TABLE; Schema: public; Owner: Samir; Tablespace: 
--

CREATE TABLE django_site (
    id integer NOT NULL,
    domain character varying(100) NOT NULL,
    name character varying(50) NOT NULL
);


ALTER TABLE django_site OWNER TO "Samir";

--
-- Name: django_site_id_seq; Type: SEQUENCE; Schema: public; Owner: Samir
--

CREATE SEQUENCE django_site_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE django_site_id_seq OWNER TO "Samir";

--
-- Name: django_site_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Samir
--

ALTER SEQUENCE django_site_id_seq OWNED BY django_site.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: Samir
--

ALTER TABLE ONLY "Decree" ALTER COLUMN id SET DEFAULT nextval('"Decree_id_seq"'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: Samir
--

ALTER TABLE ONLY "Deputy" ALTER COLUMN id SET DEFAULT nextval('"Deputy_id_seq"'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: Samir
--

ALTER TABLE ONLY "Party" ALTER COLUMN id SET DEFAULT nextval('"Party_id_seq"'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: Samir
--

ALTER TABLE ONLY "Vote" ALTER COLUMN id SET DEFAULT nextval('"Vote_id_seq"'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: Samir
--

ALTER TABLE ONLY auth_group ALTER COLUMN id SET DEFAULT nextval('auth_group_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: Samir
--

ALTER TABLE ONLY auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('auth_group_permissions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: Samir
--

ALTER TABLE ONLY auth_permission ALTER COLUMN id SET DEFAULT nextval('auth_permission_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: Samir
--

ALTER TABLE ONLY auth_user ALTER COLUMN id SET DEFAULT nextval('auth_user_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: Samir
--

ALTER TABLE ONLY auth_user_groups ALTER COLUMN id SET DEFAULT nextval('auth_user_groups_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: Samir
--

ALTER TABLE ONLY auth_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('auth_user_user_permissions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: Samir
--

ALTER TABLE ONLY django_content_type ALTER COLUMN id SET DEFAULT nextval('django_content_type_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: Samir
--

ALTER TABLE ONLY django_migrations ALTER COLUMN id SET DEFAULT nextval('django_migrations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: Samir
--

ALTER TABLE ONLY django_site ALTER COLUMN id SET DEFAULT nextval('django_site_id_seq'::regclass);


--
-- Name: Decree_number_key; Type: CONSTRAINT; Schema: public; Owner: Samir; Tablespace: 
--

ALTER TABLE ONLY "Decree"
    ADD CONSTRAINT "Decree_number_key" UNIQUE (number);


--
-- Name: Decree_pkey; Type: CONSTRAINT; Schema: public; Owner: Samir; Tablespace: 
--

ALTER TABLE ONLY "Decree"
    ADD CONSTRAINT "Decree_pkey" PRIMARY KEY (id);


--
-- Name: Deputy_pkey; Type: CONSTRAINT; Schema: public; Owner: Samir; Tablespace: 
--

ALTER TABLE ONLY "Deputy"
    ADD CONSTRAINT "Deputy_pkey" PRIMARY KEY (id);


--
-- Name: Deputy_slug_key; Type: CONSTRAINT; Schema: public; Owner: Samir; Tablespace: 
--

ALTER TABLE ONLY "Deputy"
    ADD CONSTRAINT "Deputy_slug_key" UNIQUE (slug);


--
-- Name: Party_pkey; Type: CONSTRAINT; Schema: public; Owner: Samir; Tablespace: 
--

ALTER TABLE ONLY "Party"
    ADD CONSTRAINT "Party_pkey" PRIMARY KEY (id);


--
-- Name: Vote_deputy_id_decree_id_key; Type: CONSTRAINT; Schema: public; Owner: Samir; Tablespace: 
--

ALTER TABLE ONLY "Vote"
    ADD CONSTRAINT "Vote_deputy_id_decree_id_key" UNIQUE (deputy_id, decree_id);


--
-- Name: Vote_pkey; Type: CONSTRAINT; Schema: public; Owner: Samir; Tablespace: 
--

ALTER TABLE ONLY "Vote"
    ADD CONSTRAINT "Vote_pkey" PRIMARY KEY (id);


--
-- Name: auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: Samir; Tablespace: 
--

ALTER TABLE ONLY auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions_group_id_permission_id_key; Type: CONSTRAINT; Schema: public; Owner: Samir; Tablespace: 
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_key UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: Samir; Tablespace: 
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: Samir; Tablespace: 
--

ALTER TABLE ONLY auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission_content_type_id_codename_key; Type: CONSTRAINT; Schema: public; Owner: Samir; Tablespace: 
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_key UNIQUE (content_type_id, codename);


--
-- Name: auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: Samir; Tablespace: 
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: Samir; Tablespace: 
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups_user_id_group_id_key; Type: CONSTRAINT; Schema: public; Owner: Samir; Tablespace: 
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_group_id_key UNIQUE (user_id, group_id);


--
-- Name: auth_user_pkey; Type: CONSTRAINT; Schema: public; Owner: Samir; Tablespace: 
--

ALTER TABLE ONLY auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: Samir; Tablespace: 
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions_user_id_permission_id_key; Type: CONSTRAINT; Schema: public; Owner: Samir; Tablespace: 
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_permission_id_key UNIQUE (user_id, permission_id);


--
-- Name: auth_user_username_key; Type: CONSTRAINT; Schema: public; Owner: Samir; Tablespace: 
--

ALTER TABLE ONLY auth_user
    ADD CONSTRAINT auth_user_username_key UNIQUE (username);


--
-- Name: django_content_type_app_label_26a4f28555348983_uniq; Type: CONSTRAINT; Schema: public; Owner: Samir; Tablespace: 
--

ALTER TABLE ONLY django_content_type
    ADD CONSTRAINT django_content_type_app_label_26a4f28555348983_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: Samir; Tablespace: 
--

ALTER TABLE ONLY django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: Samir; Tablespace: 
--

ALTER TABLE ONLY django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: Samir; Tablespace: 
--

ALTER TABLE ONLY django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: django_site_pkey; Type: CONSTRAINT; Schema: public; Owner: Samir; Tablespace: 
--

ALTER TABLE ONLY django_site
    ADD CONSTRAINT django_site_pkey PRIMARY KEY (id);


--
-- Name: Deputy_2c662395; Type: INDEX; Schema: public; Owner: Samir; Tablespace: 
--

CREATE INDEX "Deputy_2c662395" ON "Deputy" USING btree (party_id);


--
-- Name: Deputy_slug_4dd68b6b1a17bc88_like; Type: INDEX; Schema: public; Owner: Samir; Tablespace: 
--

CREATE INDEX "Deputy_slug_4dd68b6b1a17bc88_like" ON "Deputy" USING btree (slug text_pattern_ops);


--
-- Name: Vote_2f12535d; Type: INDEX; Schema: public; Owner: Samir; Tablespace: 
--

CREATE INDEX "Vote_2f12535d" ON "Vote" USING btree (deputy_id);


--
-- Name: Vote_47723a7e; Type: INDEX; Schema: public; Owner: Samir; Tablespace: 
--

CREATE INDEX "Vote_47723a7e" ON "Vote" USING btree (decree_id);


--
-- Name: auth_group_name_2bf71b50f81e07be_like; Type: INDEX; Schema: public; Owner: Samir; Tablespace: 
--

CREATE INDEX auth_group_name_2bf71b50f81e07be_like ON auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_0e939a4f; Type: INDEX; Schema: public; Owner: Samir; Tablespace: 
--

CREATE INDEX auth_group_permissions_0e939a4f ON auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_8373b171; Type: INDEX; Schema: public; Owner: Samir; Tablespace: 
--

CREATE INDEX auth_group_permissions_8373b171 ON auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_417f1b1c; Type: INDEX; Schema: public; Owner: Samir; Tablespace: 
--

CREATE INDEX auth_permission_417f1b1c ON auth_permission USING btree (content_type_id);


--
-- Name: auth_user_groups_0e939a4f; Type: INDEX; Schema: public; Owner: Samir; Tablespace: 
--

CREATE INDEX auth_user_groups_0e939a4f ON auth_user_groups USING btree (group_id);


--
-- Name: auth_user_groups_e8701ad4; Type: INDEX; Schema: public; Owner: Samir; Tablespace: 
--

CREATE INDEX auth_user_groups_e8701ad4 ON auth_user_groups USING btree (user_id);


--
-- Name: auth_user_user_permissions_8373b171; Type: INDEX; Schema: public; Owner: Samir; Tablespace: 
--

CREATE INDEX auth_user_user_permissions_8373b171 ON auth_user_user_permissions USING btree (permission_id);


--
-- Name: auth_user_user_permissions_e8701ad4; Type: INDEX; Schema: public; Owner: Samir; Tablespace: 
--

CREATE INDEX auth_user_user_permissions_e8701ad4 ON auth_user_user_permissions USING btree (user_id);


--
-- Name: auth_user_username_2c4b47a4d579cb32_like; Type: INDEX; Schema: public; Owner: Samir; Tablespace: 
--

CREATE INDEX auth_user_username_2c4b47a4d579cb32_like ON auth_user USING btree (username varchar_pattern_ops);


--
-- Name: django_session_de54fa62; Type: INDEX; Schema: public; Owner: Samir; Tablespace: 
--

CREATE INDEX django_session_de54fa62 ON django_session USING btree (expire_date);


--
-- Name: django_session_session_key_dfcccce2f223312_like; Type: INDEX; Schema: public; Owner: Samir; Tablespace: 
--

CREATE INDEX django_session_session_key_dfcccce2f223312_like ON django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: _RETURN; Type: RULE; Schema: public; Owner: Samir
--

CREATE RULE "_RETURN" AS
    ON SELECT TO deputy_statistics DO INSTEAD  SELECT general.id,
    general.name,
    general.surname,
    general.slug,
    general.party_id,
    general.stat_vote_count,
    (((no_votes.stat_no_vote_count * 100))::double precision / (general.stat_vote_count)::double precision) AS stat_no_vote,
    general.stat_participation
   FROM (( SELECT DISTINCT dep.id,
            dep.name,
            dep.surname,
            dep.slug,
            dep.party_id,
            count(v.*) AS stat_vote_count,
            (((count(v.*) * 100))::double precision / (( SELECT count(*) AS count
                   FROM "Decree" dec_1))::double precision) AS stat_participation
           FROM (("Deputy" dep
             JOIN "Vote" v ON ((dep.id = v.deputy_id)))
             JOIN "Decree" "dec" ON ((v.decree_id = "dec".id)))
          GROUP BY dep.id
          ORDER BY count(v.*) DESC) general
     JOIN ( SELECT dep.id,
            count(*) AS stat_no_vote_count
           FROM (("Deputy" dep
             JOIN "Vote" v ON ((dep.id = v.deputy_id)))
             JOIN "Decree" "dec" ON ((v.decree_id = "dec".id)))
          WHERE (v.vote_value = 0)
          GROUP BY dep.id) no_votes ON ((general.id = no_votes.id)));


--
-- Name: Deputy_party_id_7250d0733fc913e6_fk_Party_id; Type: FK CONSTRAINT; Schema: public; Owner: Samir
--

ALTER TABLE ONLY "Deputy"
    ADD CONSTRAINT "Deputy_party_id_7250d0733fc913e6_fk_Party_id" FOREIGN KEY (party_id) REFERENCES "Party"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: Vote_decree_id_b12d6977a75a6e4_fk_Decree_id; Type: FK CONSTRAINT; Schema: public; Owner: Samir
--

ALTER TABLE ONLY "Vote"
    ADD CONSTRAINT "Vote_decree_id_b12d6977a75a6e4_fk_Decree_id" FOREIGN KEY (decree_id) REFERENCES "Decree"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: Vote_deputy_id_78b5aec5c5c14a80_fk_Deputy_id; Type: FK CONSTRAINT; Schema: public; Owner: Samir
--

ALTER TABLE ONLY "Vote"
    ADD CONSTRAINT "Vote_deputy_id_78b5aec5c5c14a80_fk_Deputy_id" FOREIGN KEY (deputy_id) REFERENCES "Deputy"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_content_type_id_38f19b02a47b1f32_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: Samir
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_content_type_id_38f19b02a47b1f32_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_p_permission_id_e455d6e15b67b7_fk_auth_permission_id; Type: FK CONSTRAINT; Schema: public; Owner: Samir
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_p_permission_id_e455d6e15b67b7_fk_auth_permission_id FOREIGN KEY (permission_id) REFERENCES auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permission_group_id_b6a8c442d7a9262_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: Samir
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permission_group_id_b6a8c442d7a9262_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user__permission_id_5b726b8685b450ba_fk_auth_permission_id; Type: FK CONSTRAINT; Schema: public; Owner: Samir
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user__permission_id_5b726b8685b450ba_fk_auth_permission_id FOREIGN KEY (permission_id) REFERENCES auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups_group_id_1fdf5f47bbf2c58f_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: Samir
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_group_id_1fdf5f47bbf2c58f_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups_user_id_463eeeae57d92508_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: Samir
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_463eeeae57d92508_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permiss_user_id_2bc5e0f1bc6130cc_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: Samir
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permiss_user_id_2bc5e0f1bc6130cc_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: public; Type: ACL; Schema: -; Owner: Samir
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM "Samir";
GRANT ALL ON SCHEMA public TO "Samir";
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--


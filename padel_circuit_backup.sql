--
-- PostgreSQL database dump
--

\restrict RQcePfqgKXfy8VcOOo8SpEOGHda12GKYF2kFhLoAvwJJFbsWAV10SfN9ZLkXPaU

-- Dumped from database version 18.0
-- Dumped by pg_dump version 18.0

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

ALTER TABLE IF EXISTS ONLY padel_circuit.zones DROP CONSTRAINT IF EXISTS zones_tournament_category_id_fkey;
ALTER TABLE IF EXISTS ONLY padel_circuit.zone_teams DROP CONSTRAINT IF EXISTS zone_teams_zone_id_fkey;
ALTER TABLE IF EXISTS ONLY padel_circuit.zone_teams DROP CONSTRAINT IF EXISTS zone_teams_team_id_fkey;
ALTER TABLE IF EXISTS ONLY padel_circuit.zone_standings DROP CONSTRAINT IF EXISTS zone_standings_zone_id_fkey;
ALTER TABLE IF EXISTS ONLY padel_circuit.zone_standings DROP CONSTRAINT IF EXISTS zone_standings_team_id_fkey;
ALTER TABLE IF EXISTS ONLY padel_circuit.zone_matches DROP CONSTRAINT IF EXISTS zone_matches_zone_id_fkey;
ALTER TABLE IF EXISTS ONLY padel_circuit.zone_matches DROP CONSTRAINT IF EXISTS zone_matches_winner_team_id_fkey;
ALTER TABLE IF EXISTS ONLY padel_circuit.zone_matches DROP CONSTRAINT IF EXISTS zone_matches_team_home_id_fkey;
ALTER TABLE IF EXISTS ONLY padel_circuit.zone_matches DROP CONSTRAINT IF EXISTS zone_matches_team_away_id_fkey;
ALTER TABLE IF EXISTS ONLY padel_circuit.tournament_points DROP CONSTRAINT IF EXISTS tournament_points_tournament_category_id_fkey;
ALTER TABLE IF EXISTS ONLY padel_circuit.tournament_points DROP CONSTRAINT IF EXISTS tournament_points_team_id_fkey;
ALTER TABLE IF EXISTS ONLY padel_circuit.tournament_points DROP CONSTRAINT IF EXISTS tournament_points_player_dni_fkey;
ALTER TABLE IF EXISTS ONLY padel_circuit.tournament_categories DROP CONSTRAINT IF EXISTS tournament_categories_tournament_id_fkey;
ALTER TABLE IF EXISTS ONLY padel_circuit.tournament_categories DROP CONSTRAINT IF EXISTS tournament_categories_category_id_fkey;
ALTER TABLE IF EXISTS ONLY padel_circuit.teams DROP CONSTRAINT IF EXISTS teams_player2_dni_fkey;
ALTER TABLE IF EXISTS ONLY padel_circuit.teams DROP CONSTRAINT IF EXISTS teams_player1_dni_fkey;
ALTER TABLE IF EXISTS ONLY padel_circuit.registrations DROP CONSTRAINT IF EXISTS registrations_tournament_category_id_fkey;
ALTER TABLE IF EXISTS ONLY padel_circuit.registrations DROP CONSTRAINT IF EXISTS registrations_team_id_fkey;
ALTER TABLE IF EXISTS ONLY padel_circuit.player_profiles DROP CONSTRAINT IF EXISTS player_profiles_categoria_base_id_fkey;
ALTER TABLE IF EXISTS ONLY padel_circuit.matches DROP CONSTRAINT IF EXISTS matches_winner_team_id_fkey;
ALTER TABLE IF EXISTS ONLY padel_circuit.matches DROP CONSTRAINT IF EXISTS matches_team_home_id_fkey;
ALTER TABLE IF EXISTS ONLY padel_circuit.matches DROP CONSTRAINT IF EXISTS matches_team_away_id_fkey;
ALTER TABLE IF EXISTS ONLY padel_circuit.matches DROP CONSTRAINT IF EXISTS matches_next_match_id_fkey;
ALTER TABLE IF EXISTS ONLY padel_circuit.matches DROP CONSTRAINT IF EXISTS matches_bracket_id_fkey;
ALTER TABLE IF EXISTS ONLY padel_circuit.brackets DROP CONSTRAINT IF EXISTS brackets_tournament_category_id_fkey;
DROP INDEX IF EXISTS padel_circuit.zone_teams_zone_id_team_id;
DROP INDEX IF EXISTS padel_circuit.zone_standings_zone_id_team_id;
DROP INDEX IF EXISTS padel_circuit.unique_team_pair;
DROP INDEX IF EXISTS padel_circuit.tournament_categories_tournament_id_category_id;
DROP INDEX IF EXISTS padel_circuit.registrations_tournament_category_id_team_id;
DROP INDEX IF EXISTS padel_circuit.idx_tournament_points_tournament_category;
DROP INDEX IF EXISTS padel_circuit.idx_tournament_points_player;
ALTER TABLE IF EXISTS ONLY padel_circuit.zones DROP CONSTRAINT IF EXISTS zones_pkey;
ALTER TABLE IF EXISTS ONLY padel_circuit.zone_teams DROP CONSTRAINT IF EXISTS zone_teams_pkey;
ALTER TABLE IF EXISTS ONLY padel_circuit.zone_standings DROP CONSTRAINT IF EXISTS zone_standings_pkey;
ALTER TABLE IF EXISTS ONLY padel_circuit.zone_matches DROP CONSTRAINT IF EXISTS zone_matches_pkey;
ALTER TABLE IF EXISTS ONLY padel_circuit.venues DROP CONSTRAINT IF EXISTS venues_pkey;
ALTER TABLE IF EXISTS ONLY padel_circuit.users DROP CONSTRAINT IF EXISTS users_pkey;
ALTER TABLE IF EXISTS ONLY padel_circuit.users DROP CONSTRAINT IF EXISTS users_dni_key;
ALTER TABLE IF EXISTS ONLY padel_circuit.tournaments DROP CONSTRAINT IF EXISTS tournaments_pkey;
ALTER TABLE IF EXISTS ONLY padel_circuit.tournament_points DROP CONSTRAINT IF EXISTS tournament_points_unique;
ALTER TABLE IF EXISTS ONLY padel_circuit.tournament_points DROP CONSTRAINT IF EXISTS tournament_points_pkey;
ALTER TABLE IF EXISTS ONLY padel_circuit.tournament_categories DROP CONSTRAINT IF EXISTS tournament_categories_pkey;
ALTER TABLE IF EXISTS ONLY padel_circuit.teams DROP CONSTRAINT IF EXISTS teams_pkey;
ALTER TABLE IF EXISTS ONLY padel_circuit.registrations DROP CONSTRAINT IF EXISTS registrations_pkey;
ALTER TABLE IF EXISTS ONLY padel_circuit.player_profiles DROP CONSTRAINT IF EXISTS player_profiles_pkey;
ALTER TABLE IF EXISTS ONLY padel_circuit.matches DROP CONSTRAINT IF EXISTS matches_pkey;
ALTER TABLE IF EXISTS ONLY padel_circuit.categories DROP CONSTRAINT IF EXISTS categories_rank_key;
ALTER TABLE IF EXISTS ONLY padel_circuit.categories DROP CONSTRAINT IF EXISTS categories_pkey;
ALTER TABLE IF EXISTS ONLY padel_circuit.categories DROP CONSTRAINT IF EXISTS categories_name_key;
ALTER TABLE IF EXISTS ONLY padel_circuit.brackets DROP CONSTRAINT IF EXISTS brackets_pkey;
ALTER TABLE IF EXISTS padel_circuit.zones ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS padel_circuit.zone_teams ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS padel_circuit.zone_standings ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS padel_circuit.zone_matches ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS padel_circuit.venues ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS padel_circuit.users ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS padel_circuit.tournaments ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS padel_circuit.tournament_points ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS padel_circuit.tournament_categories ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS padel_circuit.teams ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS padel_circuit.registrations ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS padel_circuit.matches ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS padel_circuit.categories ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS padel_circuit.brackets ALTER COLUMN id DROP DEFAULT;
DROP SEQUENCE IF EXISTS padel_circuit.zones_id_seq;
DROP TABLE IF EXISTS padel_circuit.zones;
DROP SEQUENCE IF EXISTS padel_circuit.zone_teams_id_seq;
DROP TABLE IF EXISTS padel_circuit.zone_teams;
DROP SEQUENCE IF EXISTS padel_circuit.zone_standings_id_seq;
DROP TABLE IF EXISTS padel_circuit.zone_standings;
DROP SEQUENCE IF EXISTS padel_circuit.zone_matches_id_seq;
DROP TABLE IF EXISTS padel_circuit.zone_matches;
DROP SEQUENCE IF EXISTS padel_circuit.venues_id_seq;
DROP TABLE IF EXISTS padel_circuit.venues;
DROP SEQUENCE IF EXISTS padel_circuit.users_id_seq;
DROP TABLE IF EXISTS padel_circuit.users;
DROP SEQUENCE IF EXISTS padel_circuit.tournaments_id_seq;
DROP TABLE IF EXISTS padel_circuit.tournaments;
DROP SEQUENCE IF EXISTS padel_circuit.tournament_points_id_seq;
DROP TABLE IF EXISTS padel_circuit.tournament_points;
DROP SEQUENCE IF EXISTS padel_circuit.tournament_categories_id_seq;
DROP TABLE IF EXISTS padel_circuit.tournament_categories;
DROP SEQUENCE IF EXISTS padel_circuit.teams_id_seq;
DROP TABLE IF EXISTS padel_circuit.teams;
DROP SEQUENCE IF EXISTS padel_circuit.registrations_id_seq;
DROP TABLE IF EXISTS padel_circuit.registrations;
DROP TABLE IF EXISTS padel_circuit.player_profiles;
DROP SEQUENCE IF EXISTS padel_circuit.matches_id_seq;
DROP TABLE IF EXISTS padel_circuit.matches;
DROP SEQUENCE IF EXISTS padel_circuit.categories_id_seq;
DROP TABLE IF EXISTS padel_circuit.categories;
DROP SEQUENCE IF EXISTS padel_circuit.brackets_id_seq;
DROP TABLE IF EXISTS padel_circuit.brackets;
DROP TYPE IF EXISTS padel_circuit.enum_zone_matches_status;
DROP TYPE IF EXISTS padel_circuit.enum_users_role;
DROP TYPE IF EXISTS padel_circuit.enum_tournaments_estado;
DROP TYPE IF EXISTS padel_circuit.enum_tournament_categories_match_format;
DROP TYPE IF EXISTS padel_circuit.enum_teams_estado;
DROP TYPE IF EXISTS padel_circuit.enum_registrations_estado;
DROP TYPE IF EXISTS padel_circuit.enum_matches_status;
DROP TYPE IF EXISTS padel_circuit.enum_matches_next_match_slot;
DROP TYPE IF EXISTS padel_circuit.enum_brackets_status;
DROP SCHEMA IF EXISTS padel_circuit;
--
-- Name: padel_circuit; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA padel_circuit;


ALTER SCHEMA padel_circuit OWNER TO postgres;

--
-- Name: enum_brackets_status; Type: TYPE; Schema: padel_circuit; Owner: postgres
--

CREATE TYPE padel_circuit.enum_brackets_status AS ENUM (
    'draft',
    'published'
);


ALTER TYPE padel_circuit.enum_brackets_status OWNER TO postgres;

--
-- Name: enum_matches_next_match_slot; Type: TYPE; Schema: padel_circuit; Owner: postgres
--

CREATE TYPE padel_circuit.enum_matches_next_match_slot AS ENUM (
    'home',
    'away'
);


ALTER TYPE padel_circuit.enum_matches_next_match_slot OWNER TO postgres;

--
-- Name: enum_matches_status; Type: TYPE; Schema: padel_circuit; Owner: postgres
--

CREATE TYPE padel_circuit.enum_matches_status AS ENUM (
    'pending',
    'played',
    'bye'
);


ALTER TYPE padel_circuit.enum_matches_status OWNER TO postgres;

--
-- Name: enum_registrations_estado; Type: TYPE; Schema: padel_circuit; Owner: postgres
--

CREATE TYPE padel_circuit.enum_registrations_estado AS ENUM (
    'inscripto',
    'baja',
    'confirmado'
);


ALTER TYPE padel_circuit.enum_registrations_estado OWNER TO postgres;

--
-- Name: enum_teams_estado; Type: TYPE; Schema: padel_circuit; Owner: postgres
--

CREATE TYPE padel_circuit.enum_teams_estado AS ENUM (
    'activa',
    'inactiva'
);


ALTER TYPE padel_circuit.enum_teams_estado OWNER TO postgres;

--
-- Name: enum_tournament_categories_match_format; Type: TYPE; Schema: padel_circuit; Owner: postgres
--

CREATE TYPE padel_circuit.enum_tournament_categories_match_format AS ENUM (
    'BEST_OF_3_SUPER_TB',
    'BEST_OF_3_FULL'
);


ALTER TYPE padel_circuit.enum_tournament_categories_match_format OWNER TO postgres;

--
-- Name: enum_tournaments_estado; Type: TYPE; Schema: padel_circuit; Owner: postgres
--

CREATE TYPE padel_circuit.enum_tournaments_estado AS ENUM (
    'draft',
    'inscripcion',
    'en_curso',
    'finalizado'
);


ALTER TYPE padel_circuit.enum_tournaments_estado OWNER TO postgres;

--
-- Name: enum_users_role; Type: TYPE; Schema: padel_circuit; Owner: postgres
--

CREATE TYPE padel_circuit.enum_users_role AS ENUM (
    'admin',
    'player'
);


ALTER TYPE padel_circuit.enum_users_role OWNER TO postgres;

--
-- Name: enum_zone_matches_status; Type: TYPE; Schema: padel_circuit; Owner: postgres
--

CREATE TYPE padel_circuit.enum_zone_matches_status AS ENUM (
    'pending',
    'played'
);


ALTER TYPE padel_circuit.enum_zone_matches_status OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: brackets; Type: TABLE; Schema: padel_circuit; Owner: postgres
--

CREATE TABLE padel_circuit.brackets (
    id integer NOT NULL,
    tournament_category_id integer NOT NULL,
    status padel_circuit.enum_brackets_status DEFAULT 'draft'::padel_circuit.enum_brackets_status,
    generado_at timestamp with time zone,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE padel_circuit.brackets OWNER TO postgres;

--
-- Name: brackets_id_seq; Type: SEQUENCE; Schema: padel_circuit; Owner: postgres
--

CREATE SEQUENCE padel_circuit.brackets_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE padel_circuit.brackets_id_seq OWNER TO postgres;

--
-- Name: brackets_id_seq; Type: SEQUENCE OWNED BY; Schema: padel_circuit; Owner: postgres
--

ALTER SEQUENCE padel_circuit.brackets_id_seq OWNED BY padel_circuit.brackets.id;


--
-- Name: categories; Type: TABLE; Schema: padel_circuit; Owner: postgres
--

CREATE TABLE padel_circuit.categories (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    rank integer NOT NULL,
    active boolean DEFAULT true,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE padel_circuit.categories OWNER TO postgres;

--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: padel_circuit; Owner: postgres
--

CREATE SEQUENCE padel_circuit.categories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE padel_circuit.categories_id_seq OWNER TO postgres;

--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: padel_circuit; Owner: postgres
--

ALTER SEQUENCE padel_circuit.categories_id_seq OWNED BY padel_circuit.categories.id;


--
-- Name: matches; Type: TABLE; Schema: padel_circuit; Owner: postgres
--

CREATE TABLE padel_circuit.matches (
    id integer NOT NULL,
    bracket_id integer NOT NULL,
    round_number integer NOT NULL,
    round_name character varying(50) NOT NULL,
    match_number integer NOT NULL,
    team_home_id integer,
    team_away_id integer,
    winner_team_id integer,
    score_json jsonb,
    status padel_circuit.enum_matches_status DEFAULT 'pending'::padel_circuit.enum_matches_status,
    next_match_id integer,
    next_match_slot padel_circuit.enum_matches_next_match_slot,
    scheduled_at timestamp with time zone,
    home_source_zone_id integer,
    home_source_position integer,
    away_source_zone_id integer,
    away_source_position integer,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    venue character varying(200)
);


ALTER TABLE padel_circuit.matches OWNER TO postgres;

--
-- Name: matches_id_seq; Type: SEQUENCE; Schema: padel_circuit; Owner: postgres
--

CREATE SEQUENCE padel_circuit.matches_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE padel_circuit.matches_id_seq OWNER TO postgres;

--
-- Name: matches_id_seq; Type: SEQUENCE OWNED BY; Schema: padel_circuit; Owner: postgres
--

ALTER SEQUENCE padel_circuit.matches_id_seq OWNED BY padel_circuit.matches.id;


--
-- Name: player_profiles; Type: TABLE; Schema: padel_circuit; Owner: postgres
--

CREATE TABLE padel_circuit.player_profiles (
    dni character varying(20) NOT NULL,
    nombre character varying(100) NOT NULL,
    apellido character varying(100) NOT NULL,
    telefono character varying(20),
    categoria_base_id integer NOT NULL,
    activo boolean DEFAULT true,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE padel_circuit.player_profiles OWNER TO postgres;

--
-- Name: registrations; Type: TABLE; Schema: padel_circuit; Owner: postgres
--

CREATE TABLE padel_circuit.registrations (
    id integer NOT NULL,
    tournament_category_id integer NOT NULL,
    team_id integer NOT NULL,
    estado padel_circuit.enum_registrations_estado DEFAULT 'inscripto'::padel_circuit.enum_registrations_estado,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE padel_circuit.registrations OWNER TO postgres;

--
-- Name: registrations_id_seq; Type: SEQUENCE; Schema: padel_circuit; Owner: postgres
--

CREATE SEQUENCE padel_circuit.registrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE padel_circuit.registrations_id_seq OWNER TO postgres;

--
-- Name: registrations_id_seq; Type: SEQUENCE OWNED BY; Schema: padel_circuit; Owner: postgres
--

ALTER SEQUENCE padel_circuit.registrations_id_seq OWNED BY padel_circuit.registrations.id;


--
-- Name: teams; Type: TABLE; Schema: padel_circuit; Owner: postgres
--

CREATE TABLE padel_circuit.teams (
    id integer NOT NULL,
    player1_dni character varying(20) NOT NULL,
    player2_dni character varying(20) NOT NULL,
    estado padel_circuit.enum_teams_estado DEFAULT 'activa'::padel_circuit.enum_teams_estado,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE padel_circuit.teams OWNER TO postgres;

--
-- Name: teams_id_seq; Type: SEQUENCE; Schema: padel_circuit; Owner: postgres
--

CREATE SEQUENCE padel_circuit.teams_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE padel_circuit.teams_id_seq OWNER TO postgres;

--
-- Name: teams_id_seq; Type: SEQUENCE OWNED BY; Schema: padel_circuit; Owner: postgres
--

ALTER SEQUENCE padel_circuit.teams_id_seq OWNED BY padel_circuit.teams.id;


--
-- Name: tournament_categories; Type: TABLE; Schema: padel_circuit; Owner: postgres
--

CREATE TABLE padel_circuit.tournament_categories (
    id integer NOT NULL,
    tournament_id integer NOT NULL,
    category_id integer NOT NULL,
    cupo integer,
    inscripcion_abierta boolean DEFAULT true,
    match_format padel_circuit.enum_tournament_categories_match_format DEFAULT 'BEST_OF_3_SUPER_TB'::padel_circuit.enum_tournament_categories_match_format,
    super_tiebreak_points integer DEFAULT 10,
    tiebreak_in_sets boolean DEFAULT true,
    win_points integer DEFAULT 2,
    loss_points integer DEFAULT 0,
    zone_size integer,
    qualifiers_per_zone integer,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    estado character varying(50) DEFAULT 'draft'::character varying
);


ALTER TABLE padel_circuit.tournament_categories OWNER TO postgres;

--
-- Name: tournament_categories_id_seq; Type: SEQUENCE; Schema: padel_circuit; Owner: postgres
--

CREATE SEQUENCE padel_circuit.tournament_categories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE padel_circuit.tournament_categories_id_seq OWNER TO postgres;

--
-- Name: tournament_categories_id_seq; Type: SEQUENCE OWNED BY; Schema: padel_circuit; Owner: postgres
--

ALTER SEQUENCE padel_circuit.tournament_categories_id_seq OWNED BY padel_circuit.tournament_categories.id;


--
-- Name: tournament_points; Type: TABLE; Schema: padel_circuit; Owner: postgres
--

CREATE TABLE padel_circuit.tournament_points (
    id integer NOT NULL,
    tournament_category_id integer NOT NULL,
    player_dni character varying(20) NOT NULL,
    team_id integer NOT NULL,
    points integer DEFAULT 0 NOT NULL,
    "position" character varying(50) NOT NULL,
    awarded_at timestamp with time zone DEFAULT now() NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE padel_circuit.tournament_points OWNER TO postgres;

--
-- Name: tournament_points_id_seq; Type: SEQUENCE; Schema: padel_circuit; Owner: postgres
--

CREATE SEQUENCE padel_circuit.tournament_points_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE padel_circuit.tournament_points_id_seq OWNER TO postgres;

--
-- Name: tournament_points_id_seq; Type: SEQUENCE OWNED BY; Schema: padel_circuit; Owner: postgres
--

ALTER SEQUENCE padel_circuit.tournament_points_id_seq OWNED BY padel_circuit.tournament_points.id;


--
-- Name: tournaments; Type: TABLE; Schema: padel_circuit; Owner: postgres
--

CREATE TABLE padel_circuit.tournaments (
    id integer NOT NULL,
    nombre character varying(200) NOT NULL,
    fecha_inicio timestamp with time zone,
    fecha_fin timestamp with time zone,
    estado padel_circuit.enum_tournaments_estado DEFAULT 'draft'::padel_circuit.enum_tournaments_estado,
    descripcion text,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    double_points boolean DEFAULT false NOT NULL
);


ALTER TABLE padel_circuit.tournaments OWNER TO postgres;

--
-- Name: tournaments_id_seq; Type: SEQUENCE; Schema: padel_circuit; Owner: postgres
--

CREATE SEQUENCE padel_circuit.tournaments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE padel_circuit.tournaments_id_seq OWNER TO postgres;

--
-- Name: tournaments_id_seq; Type: SEQUENCE OWNED BY; Schema: padel_circuit; Owner: postgres
--

ALTER SEQUENCE padel_circuit.tournaments_id_seq OWNED BY padel_circuit.tournaments.id;


--
-- Name: users; Type: TABLE; Schema: padel_circuit; Owner: postgres
--

CREATE TABLE padel_circuit.users (
    id integer NOT NULL,
    dni character varying(20) NOT NULL,
    password_hash character varying(255) NOT NULL,
    role padel_circuit.enum_users_role DEFAULT 'player'::padel_circuit.enum_users_role NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE padel_circuit.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: padel_circuit; Owner: postgres
--

CREATE SEQUENCE padel_circuit.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE padel_circuit.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: padel_circuit; Owner: postgres
--

ALTER SEQUENCE padel_circuit.users_id_seq OWNED BY padel_circuit.users.id;


--
-- Name: venues; Type: TABLE; Schema: padel_circuit; Owner: postgres
--

CREATE TABLE padel_circuit.venues (
    id integer NOT NULL,
    name character varying(200) NOT NULL,
    address character varying(300),
    courts_count integer DEFAULT 1,
    active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE padel_circuit.venues OWNER TO postgres;

--
-- Name: venues_id_seq; Type: SEQUENCE; Schema: padel_circuit; Owner: postgres
--

CREATE SEQUENCE padel_circuit.venues_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE padel_circuit.venues_id_seq OWNER TO postgres;

--
-- Name: venues_id_seq; Type: SEQUENCE OWNED BY; Schema: padel_circuit; Owner: postgres
--

ALTER SEQUENCE padel_circuit.venues_id_seq OWNED BY padel_circuit.venues.id;


--
-- Name: zone_matches; Type: TABLE; Schema: padel_circuit; Owner: postgres
--

CREATE TABLE padel_circuit.zone_matches (
    id integer NOT NULL,
    zone_id integer NOT NULL,
    round_number integer NOT NULL,
    match_number integer NOT NULL,
    team_home_id integer NOT NULL,
    team_away_id integer NOT NULL,
    status padel_circuit.enum_zone_matches_status DEFAULT 'pending'::padel_circuit.enum_zone_matches_status,
    score_json jsonb,
    winner_team_id integer,
    played_at timestamp with time zone,
    scheduled_at timestamp with time zone,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    venue character varying(200)
);


ALTER TABLE padel_circuit.zone_matches OWNER TO postgres;

--
-- Name: zone_matches_id_seq; Type: SEQUENCE; Schema: padel_circuit; Owner: postgres
--

CREATE SEQUENCE padel_circuit.zone_matches_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE padel_circuit.zone_matches_id_seq OWNER TO postgres;

--
-- Name: zone_matches_id_seq; Type: SEQUENCE OWNED BY; Schema: padel_circuit; Owner: postgres
--

ALTER SEQUENCE padel_circuit.zone_matches_id_seq OWNED BY padel_circuit.zone_matches.id;


--
-- Name: zone_standings; Type: TABLE; Schema: padel_circuit; Owner: postgres
--

CREATE TABLE padel_circuit.zone_standings (
    id integer NOT NULL,
    zone_id integer NOT NULL,
    team_id integer NOT NULL,
    played integer DEFAULT 0,
    wins integer DEFAULT 0,
    losses integer DEFAULT 0,
    points integer DEFAULT 0,
    sets_for integer DEFAULT 0,
    sets_against integer DEFAULT 0,
    sets_diff integer DEFAULT 0,
    games_for integer DEFAULT 0,
    games_against integer DEFAULT 0,
    games_diff integer DEFAULT 0,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE padel_circuit.zone_standings OWNER TO postgres;

--
-- Name: zone_standings_id_seq; Type: SEQUENCE; Schema: padel_circuit; Owner: postgres
--

CREATE SEQUENCE padel_circuit.zone_standings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE padel_circuit.zone_standings_id_seq OWNER TO postgres;

--
-- Name: zone_standings_id_seq; Type: SEQUENCE OWNED BY; Schema: padel_circuit; Owner: postgres
--

ALTER SEQUENCE padel_circuit.zone_standings_id_seq OWNED BY padel_circuit.zone_standings.id;


--
-- Name: zone_teams; Type: TABLE; Schema: padel_circuit; Owner: postgres
--

CREATE TABLE padel_circuit.zone_teams (
    id integer NOT NULL,
    zone_id integer NOT NULL,
    team_id integer NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE padel_circuit.zone_teams OWNER TO postgres;

--
-- Name: zone_teams_id_seq; Type: SEQUENCE; Schema: padel_circuit; Owner: postgres
--

CREATE SEQUENCE padel_circuit.zone_teams_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE padel_circuit.zone_teams_id_seq OWNER TO postgres;

--
-- Name: zone_teams_id_seq; Type: SEQUENCE OWNED BY; Schema: padel_circuit; Owner: postgres
--

ALTER SEQUENCE padel_circuit.zone_teams_id_seq OWNED BY padel_circuit.zone_teams.id;


--
-- Name: zones; Type: TABLE; Schema: padel_circuit; Owner: postgres
--

CREATE TABLE padel_circuit.zones (
    id integer NOT NULL,
    tournament_category_id integer NOT NULL,
    name character varying(50) NOT NULL,
    order_index integer NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE padel_circuit.zones OWNER TO postgres;

--
-- Name: zones_id_seq; Type: SEQUENCE; Schema: padel_circuit; Owner: postgres
--

CREATE SEQUENCE padel_circuit.zones_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE padel_circuit.zones_id_seq OWNER TO postgres;

--
-- Name: zones_id_seq; Type: SEQUENCE OWNED BY; Schema: padel_circuit; Owner: postgres
--

ALTER SEQUENCE padel_circuit.zones_id_seq OWNED BY padel_circuit.zones.id;


--
-- Name: brackets id; Type: DEFAULT; Schema: padel_circuit; Owner: postgres
--

ALTER TABLE ONLY padel_circuit.brackets ALTER COLUMN id SET DEFAULT nextval('padel_circuit.brackets_id_seq'::regclass);


--
-- Name: categories id; Type: DEFAULT; Schema: padel_circuit; Owner: postgres
--

ALTER TABLE ONLY padel_circuit.categories ALTER COLUMN id SET DEFAULT nextval('padel_circuit.categories_id_seq'::regclass);


--
-- Name: matches id; Type: DEFAULT; Schema: padel_circuit; Owner: postgres
--

ALTER TABLE ONLY padel_circuit.matches ALTER COLUMN id SET DEFAULT nextval('padel_circuit.matches_id_seq'::regclass);


--
-- Name: registrations id; Type: DEFAULT; Schema: padel_circuit; Owner: postgres
--

ALTER TABLE ONLY padel_circuit.registrations ALTER COLUMN id SET DEFAULT nextval('padel_circuit.registrations_id_seq'::regclass);


--
-- Name: teams id; Type: DEFAULT; Schema: padel_circuit; Owner: postgres
--

ALTER TABLE ONLY padel_circuit.teams ALTER COLUMN id SET DEFAULT nextval('padel_circuit.teams_id_seq'::regclass);


--
-- Name: tournament_categories id; Type: DEFAULT; Schema: padel_circuit; Owner: postgres
--

ALTER TABLE ONLY padel_circuit.tournament_categories ALTER COLUMN id SET DEFAULT nextval('padel_circuit.tournament_categories_id_seq'::regclass);


--
-- Name: tournament_points id; Type: DEFAULT; Schema: padel_circuit; Owner: postgres
--

ALTER TABLE ONLY padel_circuit.tournament_points ALTER COLUMN id SET DEFAULT nextval('padel_circuit.tournament_points_id_seq'::regclass);


--
-- Name: tournaments id; Type: DEFAULT; Schema: padel_circuit; Owner: postgres
--

ALTER TABLE ONLY padel_circuit.tournaments ALTER COLUMN id SET DEFAULT nextval('padel_circuit.tournaments_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: padel_circuit; Owner: postgres
--

ALTER TABLE ONLY padel_circuit.users ALTER COLUMN id SET DEFAULT nextval('padel_circuit.users_id_seq'::regclass);


--
-- Name: venues id; Type: DEFAULT; Schema: padel_circuit; Owner: postgres
--

ALTER TABLE ONLY padel_circuit.venues ALTER COLUMN id SET DEFAULT nextval('padel_circuit.venues_id_seq'::regclass);


--
-- Name: zone_matches id; Type: DEFAULT; Schema: padel_circuit; Owner: postgres
--

ALTER TABLE ONLY padel_circuit.zone_matches ALTER COLUMN id SET DEFAULT nextval('padel_circuit.zone_matches_id_seq'::regclass);


--
-- Name: zone_standings id; Type: DEFAULT; Schema: padel_circuit; Owner: postgres
--

ALTER TABLE ONLY padel_circuit.zone_standings ALTER COLUMN id SET DEFAULT nextval('padel_circuit.zone_standings_id_seq'::regclass);


--
-- Name: zone_teams id; Type: DEFAULT; Schema: padel_circuit; Owner: postgres
--

ALTER TABLE ONLY padel_circuit.zone_teams ALTER COLUMN id SET DEFAULT nextval('padel_circuit.zone_teams_id_seq'::regclass);


--
-- Name: zones id; Type: DEFAULT; Schema: padel_circuit; Owner: postgres
--

ALTER TABLE ONLY padel_circuit.zones ALTER COLUMN id SET DEFAULT nextval('padel_circuit.zones_id_seq'::regclass);


--
-- Data for Name: brackets; Type: TABLE DATA; Schema: padel_circuit; Owner: postgres
--

INSERT INTO padel_circuit.brackets (id, tournament_category_id, status, generado_at, created_at, updated_at) VALUES (6, 2, 'published', '2026-01-15 01:37:52.766-03', '2026-01-15 01:37:52.768-03', '2026-01-15 01:37:52.768-03');


--
-- Data for Name: categories; Type: TABLE DATA; Schema: padel_circuit; Owner: postgres
--

INSERT INTO padel_circuit.categories (id, name, rank, active, created_at, updated_at) VALUES (1, '1ra', 1, true, '2026-01-14 00:36:15.202-03', '2026-01-14 00:36:15.202-03');
INSERT INTO padel_circuit.categories (id, name, rank, active, created_at, updated_at) VALUES (2, '2da', 2, true, '2026-01-14 00:36:15.225-03', '2026-01-14 00:36:15.225-03');
INSERT INTO padel_circuit.categories (id, name, rank, active, created_at, updated_at) VALUES (3, '3ra', 3, true, '2026-01-14 00:36:15.23-03', '2026-01-14 00:36:15.23-03');
INSERT INTO padel_circuit.categories (id, name, rank, active, created_at, updated_at) VALUES (4, '4ta', 4, true, '2026-01-14 00:36:15.234-03', '2026-01-14 00:36:15.234-03');
INSERT INTO padel_circuit.categories (id, name, rank, active, created_at, updated_at) VALUES (5, '5ta', 5, true, '2026-01-14 00:36:15.238-03', '2026-01-14 00:36:15.238-03');
INSERT INTO padel_circuit.categories (id, name, rank, active, created_at, updated_at) VALUES (6, '6ta', 6, true, '2026-01-14 00:36:15.241-03', '2026-01-14 00:36:15.241-03');
INSERT INTO padel_circuit.categories (id, name, rank, active, created_at, updated_at) VALUES (7, '7ma', 7, true, '2026-01-14 00:36:15.244-03', '2026-01-14 00:36:15.244-03');
INSERT INTO padel_circuit.categories (id, name, rank, active, created_at, updated_at) VALUES (8, '8va', 8, true, '2026-01-14 00:36:15.248-03', '2026-01-14 00:36:15.248-03');


--
-- Data for Name: matches; Type: TABLE DATA; Schema: padel_circuit; Owner: postgres
--

INSERT INTO padel_circuit.matches (id, bracket_id, round_number, round_name, match_number, team_home_id, team_away_id, winner_team_id, score_json, status, next_match_id, next_match_slot, scheduled_at, home_source_zone_id, home_source_position, away_source_zone_id, away_source_position, created_at, updated_at, venue) VALUES (3, 6, 2, 'Final', 1, NULL, NULL, NULL, NULL, 'pending', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-15 01:37:52.794-03', '2026-01-15 01:37:52.794-03', NULL);
INSERT INTO padel_circuit.matches (id, bracket_id, round_number, round_name, match_number, team_home_id, team_away_id, winner_team_id, score_json, status, next_match_id, next_match_slot, scheduled_at, home_source_zone_id, home_source_position, away_source_zone_id, away_source_position, created_at, updated_at, venue) VALUES (1, 6, 1, 'Semifinal', 1, 1, NULL, NULL, NULL, 'pending', 3, 'home', NULL, 3, 1, 4, 2, '2026-01-15 01:37:52.783-03', '2026-01-15 01:37:52.797-03', NULL);
INSERT INTO padel_circuit.matches (id, bracket_id, round_number, round_name, match_number, team_home_id, team_away_id, winner_team_id, score_json, status, next_match_id, next_match_slot, scheduled_at, home_source_zone_id, home_source_position, away_source_zone_id, away_source_position, created_at, updated_at, venue) VALUES (2, 6, 1, 'Semifinal', 2, 5, 2, NULL, NULL, 'pending', 3, 'away', NULL, 4, 1, 3, 2, '2026-01-15 01:37:52.79-03', '2026-01-15 01:37:52.802-03', NULL);


--
-- Data for Name: player_profiles; Type: TABLE DATA; Schema: padel_circuit; Owner: postgres
--

INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000001', 'Juan', 'Pérez', '1234567890', 4, true, '2026-01-15 00:12:00.58-03', '2026-01-15 00:12:00.58-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000002', 'María', 'González', '1234567891', 4, true, '2026-01-15 00:12:00.589-03', '2026-01-15 00:12:00.589-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000003', 'Carlos', 'Rodríguez', '1234567892', 4, true, '2026-01-15 00:12:00.594-03', '2026-01-15 00:12:00.594-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000004', 'Ana', 'Martínez', '1234567893', 4, true, '2026-01-15 00:12:00.6-03', '2026-01-15 00:12:00.6-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000005', 'Luis', 'López', '1234567894', 4, true, '2026-01-15 00:12:00.606-03', '2026-01-15 00:12:00.606-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000006', 'Laura', 'Fernández', '1234567895', 4, true, '2026-01-15 00:12:00.61-03', '2026-01-15 00:12:00.61-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000007', 'Diego', 'Sánchez', '1234567896', 4, true, '2026-01-15 00:12:00.614-03', '2026-01-15 00:12:00.614-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000008', 'Sofía', 'Ramírez', '1234567897', 4, true, '2026-01-15 00:12:00.62-03', '2026-01-15 00:12:00.62-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000009', 'Martín', 'Torres', '1234567898', 4, true, '2026-01-15 00:12:00.625-03', '2026-01-15 00:12:00.625-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000010', 'Valentina', 'Flores', '1234567899', 4, true, '2026-01-15 00:12:00.629-03', '2026-01-15 00:12:00.629-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000011', 'Facundo', 'Díaz', '1234567800', 4, true, '2026-01-15 00:12:00.632-03', '2026-01-15 00:12:00.632-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000012', 'Camila', 'Romero', '1234567801', 4, true, '2026-01-15 00:12:00.637-03', '2026-01-15 00:12:00.637-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000013', 'Jugador4ta', 'Test1', '1150006000', 4, true, '2026-01-15 01:22:31.471124-03', '2026-01-15 01:22:31.471124-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000014', 'Jugador4ta', 'Test2', '1150016001', 4, true, '2026-01-15 01:22:31.498739-03', '2026-01-15 01:22:31.498739-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000015', 'Jugador4ta', 'Test3', '1150026002', 4, true, '2026-01-15 01:22:31.500832-03', '2026-01-15 01:22:31.500832-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000016', 'Jugador4ta', 'Test4', '1150036003', 4, true, '2026-01-15 01:22:31.502845-03', '2026-01-15 01:22:31.502845-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000017', 'Jugador4ta', 'Test5', '1150046004', 4, true, '2026-01-15 01:22:31.50455-03', '2026-01-15 01:22:31.50455-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000018', 'Jugador4ta', 'Test6', '1150056005', 4, true, '2026-01-15 01:22:31.506417-03', '2026-01-15 01:22:31.506417-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000019', 'Jugador4ta', 'Test7', '1150066006', 4, true, '2026-01-15 01:22:31.508246-03', '2026-01-15 01:22:31.508246-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000020', 'Jugador4ta', 'Test8', '1150076007', 4, true, '2026-01-15 01:22:31.510043-03', '2026-01-15 01:22:31.510043-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000021', 'Jugador4ta', 'Test9', '1150086008', 4, true, '2026-01-15 01:22:31.511599-03', '2026-01-15 01:22:31.511599-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000022', 'Jugador4ta', 'Test10', '1150096009', 4, true, '2026-01-15 01:22:31.513623-03', '2026-01-15 01:22:31.513623-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000023', 'Jugador4ta', 'Test11', '1150106010', 4, true, '2026-01-15 01:22:31.515212-03', '2026-01-15 01:22:31.515212-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000024', 'Jugador4ta', 'Test12', '1150116011', 4, true, '2026-01-15 01:22:31.516841-03', '2026-01-15 01:22:31.516841-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000025', 'Jugador4ta', 'Test13', '1150126012', 4, true, '2026-01-15 01:22:31.518429-03', '2026-01-15 01:22:31.518429-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000026', 'Jugador4ta', 'Test14', '1150136013', 4, true, '2026-01-15 01:22:31.519647-03', '2026-01-15 01:22:31.519647-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000027', 'Jugador4ta', 'Test15', '1150146014', 4, true, '2026-01-15 01:22:31.521178-03', '2026-01-15 01:22:31.521178-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000028', 'Jugador4ta', 'Test16', '1150156015', 4, true, '2026-01-15 01:22:31.522823-03', '2026-01-15 01:22:31.522823-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000029', 'Jugador4ta', 'Test17', '1150166016', 4, true, '2026-01-15 01:22:31.524708-03', '2026-01-15 01:22:31.524708-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000030', 'Jugador4ta', 'Test18', '1150176017', 4, true, '2026-01-15 01:22:31.526476-03', '2026-01-15 01:22:31.526476-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000031', 'Jugador4ta', 'Test19', '1150186018', 4, true, '2026-01-15 01:22:31.527878-03', '2026-01-15 01:22:31.527878-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000032', 'Jugador4ta', 'Test20', '1150196019', 4, true, '2026-01-15 01:22:31.529159-03', '2026-01-15 01:22:31.529159-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000033', 'Jugador4ta', 'Test21', '1150206020', 4, true, '2026-01-15 01:22:31.530404-03', '2026-01-15 01:22:31.530404-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000034', 'Jugador4ta', 'Test22', '1150216021', 4, true, '2026-01-15 01:22:31.531517-03', '2026-01-15 01:22:31.531517-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000035', 'Jugador4ta', 'Test23', '1150226022', 4, true, '2026-01-15 01:22:31.532795-03', '2026-01-15 01:22:31.532795-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000036', 'Jugador4ta', 'Test24', '1150236023', 4, true, '2026-01-15 01:22:31.534151-03', '2026-01-15 01:22:31.534151-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000037', 'Jugador4ta', 'Test25', '1150246024', 4, true, '2026-01-15 01:22:31.535402-03', '2026-01-15 01:22:31.535402-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000038', 'Jugador4ta', 'Test26', '1150256025', 4, true, '2026-01-15 01:22:31.536754-03', '2026-01-15 01:22:31.536754-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000039', 'Jugador4ta', 'Test27', '1150266026', 4, true, '2026-01-15 01:22:31.538627-03', '2026-01-15 01:22:31.538627-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000040', 'Jugador4ta', 'Test28', '1150276027', 4, true, '2026-01-15 01:22:31.539917-03', '2026-01-15 01:22:31.539917-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000041', 'Jugador4ta', 'Test29', '1150286028', 4, true, '2026-01-15 01:22:31.541069-03', '2026-01-15 01:22:31.541069-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000042', 'Jugador4ta', 'Test30', '1150296029', 4, true, '2026-01-15 01:22:31.542185-03', '2026-01-15 01:22:31.542185-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000043', 'Jugador4ta', 'Test31', '1150306030', 4, true, '2026-01-15 01:22:31.543217-03', '2026-01-15 01:22:31.543217-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000044', 'Jugador4ta', 'Test32', '1150316031', 4, true, '2026-01-15 01:22:31.544486-03', '2026-01-15 01:22:31.544486-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000045', 'Jugador4ta', 'Test33', '1150326032', 4, true, '2026-01-15 01:22:31.545538-03', '2026-01-15 01:22:31.545538-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000046', 'Jugador4ta', 'Test34', '1150336033', 4, true, '2026-01-15 01:22:31.546469-03', '2026-01-15 01:22:31.546469-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000047', 'Jugador4ta', 'Test35', '1150346034', 4, true, '2026-01-15 01:22:31.54744-03', '2026-01-15 01:22:31.54744-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000048', 'Jugador4ta', 'Test36', '1150356035', 4, true, '2026-01-15 01:22:31.548604-03', '2026-01-15 01:22:31.548604-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000049', 'Jugador4ta', 'Test37', '1150366036', 4, true, '2026-01-15 01:22:31.549702-03', '2026-01-15 01:22:31.549702-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000050', 'Jugador4ta', 'Test38', '1150376037', 4, true, '2026-01-15 01:22:31.551325-03', '2026-01-15 01:22:31.551325-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000051', 'Jugador4ta', 'Test39', '1150386038', 4, true, '2026-01-15 01:22:31.553025-03', '2026-01-15 01:22:31.553025-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000052', 'Jugador4ta', 'Test40', '1150396039', 4, true, '2026-01-15 01:22:31.55449-03', '2026-01-15 01:22:31.55449-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000053', 'Jugador4ta', 'Test41', '1150406040', 4, true, '2026-01-15 01:22:31.555591-03', '2026-01-15 01:22:31.555591-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000054', 'Jugador4ta', 'Test42', '1150416041', 4, true, '2026-01-15 01:22:31.556612-03', '2026-01-15 01:22:31.556612-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000055', 'Jugador4ta', 'Test43', '1150426042', 4, true, '2026-01-15 01:22:31.557749-03', '2026-01-15 01:22:31.557749-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000056', 'Jugador4ta', 'Test44', '1150436043', 4, true, '2026-01-15 01:22:31.55888-03', '2026-01-15 01:22:31.55888-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000057', 'Jugador4ta', 'Test45', '1150446044', 4, true, '2026-01-15 01:22:31.55991-03', '2026-01-15 01:22:31.55991-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000058', 'Jugador4ta', 'Test46', '1150456045', 4, true, '2026-01-15 01:22:31.560952-03', '2026-01-15 01:22:31.560952-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000059', 'Jugador4ta', 'Test47', '1150466046', 4, true, '2026-01-15 01:22:31.562068-03', '2026-01-15 01:22:31.562068-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000060', 'Jugador4ta', 'Test48', '1150476047', 4, true, '2026-01-15 01:22:31.563316-03', '2026-01-15 01:22:31.563316-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000061', 'Jugador5ta', 'Test1', '1170008000', 5, true, '2026-01-15 01:22:31.564951-03', '2026-01-15 01:22:31.564951-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000062', 'Jugador5ta', 'Test2', '1170018001', 5, true, '2026-01-15 01:22:31.566681-03', '2026-01-15 01:22:31.566681-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000063', 'Jugador5ta', 'Test3', '1170028002', 5, true, '2026-01-15 01:22:31.56796-03', '2026-01-15 01:22:31.56796-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000064', 'Jugador5ta', 'Test4', '1170038003', 5, true, '2026-01-15 01:22:31.569197-03', '2026-01-15 01:22:31.569197-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000065', 'Jugador5ta', 'Test5', '1170048004', 5, true, '2026-01-15 01:22:31.570259-03', '2026-01-15 01:22:31.570259-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000066', 'Jugador5ta', 'Test6', '1170058005', 5, true, '2026-01-15 01:22:31.571356-03', '2026-01-15 01:22:31.571356-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000067', 'Jugador5ta', 'Test7', '1170068006', 5, true, '2026-01-15 01:22:31.572568-03', '2026-01-15 01:22:31.572568-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000068', 'Jugador5ta', 'Test8', '1170078007', 5, true, '2026-01-15 01:22:31.573565-03', '2026-01-15 01:22:31.573565-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000069', 'Jugador5ta', 'Test9', '1170088008', 5, true, '2026-01-15 01:22:31.574459-03', '2026-01-15 01:22:31.574459-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000070', 'Jugador5ta', 'Test10', '1170098009', 5, true, '2026-01-15 01:22:31.575371-03', '2026-01-15 01:22:31.575371-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000071', 'Jugador5ta', 'Test11', '1170108010', 5, true, '2026-01-15 01:22:31.576426-03', '2026-01-15 01:22:31.576426-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000072', 'Jugador5ta', 'Test12', '1170118011', 5, true, '2026-01-15 01:22:31.577576-03', '2026-01-15 01:22:31.577576-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000073', 'Jugador5ta', 'Test13', '1170128012', 5, true, '2026-01-15 01:22:31.578935-03', '2026-01-15 01:22:31.578935-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000074', 'Jugador5ta', 'Test14', '1170138013', 5, true, '2026-01-15 01:22:31.579993-03', '2026-01-15 01:22:31.579993-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000075', 'Jugador5ta', 'Test15', '1170148014', 5, true, '2026-01-15 01:22:31.581197-03', '2026-01-15 01:22:31.581197-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000076', 'Jugador5ta', 'Test16', '1170158015', 5, true, '2026-01-15 01:22:31.582307-03', '2026-01-15 01:22:31.582307-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000077', 'Jugador5ta', 'Test17', '1170168016', 5, true, '2026-01-15 01:22:31.583999-03', '2026-01-15 01:22:31.583999-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000078', 'Jugador5ta', 'Test18', '1170178017', 5, true, '2026-01-15 01:22:31.585244-03', '2026-01-15 01:22:31.585244-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000079', 'Jugador5ta', 'Test19', '1170188018', 5, true, '2026-01-15 01:22:31.586423-03', '2026-01-15 01:22:31.586423-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000080', 'Jugador5ta', 'Test20', '1170198019', 5, true, '2026-01-15 01:22:31.587517-03', '2026-01-15 01:22:31.587517-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000081', 'Jugador5ta', 'Test21', '1170208020', 5, true, '2026-01-15 01:22:31.588472-03', '2026-01-15 01:22:31.588472-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000082', 'Jugador5ta', 'Test22', '1170218021', 5, true, '2026-01-15 01:22:31.589386-03', '2026-01-15 01:22:31.589386-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000083', 'Jugador5ta', 'Test23', '1170228022', 5, true, '2026-01-15 01:22:31.590447-03', '2026-01-15 01:22:31.590447-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000084', 'Jugador5ta', 'Test24', '1170238023', 5, true, '2026-01-15 01:22:31.591648-03', '2026-01-15 01:22:31.591648-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000085', 'Jugador5ta', 'Test25', '1170248024', 5, true, '2026-01-15 01:22:31.592873-03', '2026-01-15 01:22:31.592873-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000086', 'Jugador5ta', 'Test26', '1170258025', 5, true, '2026-01-15 01:22:31.593822-03', '2026-01-15 01:22:31.593822-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000087', 'Jugador5ta', 'Test27', '1170268026', 5, true, '2026-01-15 01:22:31.595199-03', '2026-01-15 01:22:31.595199-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000088', 'Jugador5ta', 'Test28', '1170278027', 5, true, '2026-01-15 01:22:31.596269-03', '2026-01-15 01:22:31.596269-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000089', 'Jugador5ta', 'Test29', '1170288028', 5, true, '2026-01-15 01:22:31.597336-03', '2026-01-15 01:22:31.597336-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000090', 'Jugador5ta', 'Test30', '1170298029', 5, true, '2026-01-15 01:22:31.598914-03', '2026-01-15 01:22:31.598914-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000091', 'Jugador5ta', 'Test31', '1170308030', 5, true, '2026-01-15 01:22:31.600161-03', '2026-01-15 01:22:31.600161-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000092', 'Jugador5ta', 'Test32', '1170318031', 5, true, '2026-01-15 01:22:31.601559-03', '2026-01-15 01:22:31.601559-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000093', 'Jugador5ta', 'Test33', '1170328032', 5, true, '2026-01-15 01:22:31.602535-03', '2026-01-15 01:22:31.602535-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000094', 'Jugador5ta', 'Test34', '1170338033', 5, true, '2026-01-15 01:22:31.603492-03', '2026-01-15 01:22:31.603492-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000095', 'Jugador5ta', 'Test35', '1170348034', 5, true, '2026-01-15 01:22:31.604403-03', '2026-01-15 01:22:31.604403-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000096', 'Jugador5ta', 'Test36', '1170358035', 5, true, '2026-01-15 01:22:31.605297-03', '2026-01-15 01:22:31.605297-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000097', 'Jugador5ta', 'Test37', '1170368036', 5, true, '2026-01-15 01:22:31.606315-03', '2026-01-15 01:22:31.606315-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000098', 'Jugador5ta', 'Test38', '1170378037', 5, true, '2026-01-15 01:22:31.607256-03', '2026-01-15 01:22:31.607256-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000099', 'Jugador5ta', 'Test39', '1170388038', 5, true, '2026-01-15 01:22:31.608256-03', '2026-01-15 01:22:31.608256-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000100', 'Jugador5ta', 'Test40', '1170398039', 5, true, '2026-01-15 01:22:31.609209-03', '2026-01-15 01:22:31.609209-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000101', 'Jugador5ta', 'Test41', '1170408040', 5, true, '2026-01-15 01:22:31.610554-03', '2026-01-15 01:22:31.610554-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000102', 'Jugador5ta', 'Test42', '1170418041', 5, true, '2026-01-15 01:22:31.61172-03', '2026-01-15 01:22:31.61172-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000103', 'Jugador5ta', 'Test43', '1170428042', 5, true, '2026-01-15 01:22:31.612511-03', '2026-01-15 01:22:31.612511-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000104', 'Jugador5ta', 'Test44', '1170438043', 5, true, '2026-01-15 01:22:31.613246-03', '2026-01-15 01:22:31.613246-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000105', 'Jugador5ta', 'Test45', '1170448044', 5, true, '2026-01-15 01:22:31.614297-03', '2026-01-15 01:22:31.614297-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000106', 'Jugador5ta', 'Test46', '1170458045', 5, true, '2026-01-15 01:22:31.615455-03', '2026-01-15 01:22:31.615455-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000107', 'Jugador5ta', 'Test47', '1170468046', 5, true, '2026-01-15 01:22:31.616849-03', '2026-01-15 01:22:31.616849-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000108', 'Jugador5ta', 'Test48', '1170478047', 5, true, '2026-01-15 01:22:31.618399-03', '2026-01-15 01:22:31.618399-03');


--
-- Data for Name: registrations; Type: TABLE DATA; Schema: padel_circuit; Owner: postgres
--

INSERT INTO padel_circuit.registrations (id, tournament_category_id, team_id, estado, created_at, updated_at) VALUES (1, 1, 5, 'confirmado', '2026-01-15 00:26:02.08-03', '2026-01-15 00:26:02.08-03');
INSERT INTO padel_circuit.registrations (id, tournament_category_id, team_id, estado, created_at, updated_at) VALUES (2, 1, 4, 'confirmado', '2026-01-15 00:26:05.76-03', '2026-01-15 00:26:05.76-03');
INSERT INTO padel_circuit.registrations (id, tournament_category_id, team_id, estado, created_at, updated_at) VALUES (3, 1, 2, 'confirmado', '2026-01-15 00:26:14.424-03', '2026-01-15 00:26:14.424-03');
INSERT INTO padel_circuit.registrations (id, tournament_category_id, team_id, estado, created_at, updated_at) VALUES (4, 1, 1, 'confirmado', '2026-01-15 00:26:18.744-03', '2026-01-15 00:26:18.744-03');
INSERT INTO padel_circuit.registrations (id, tournament_category_id, team_id, estado, created_at, updated_at) VALUES (5, 3, 6, 'confirmado', '2026-01-15 01:28:30.376-03', '2026-01-15 01:28:30.376-03');
INSERT INTO padel_circuit.registrations (id, tournament_category_id, team_id, estado, created_at, updated_at) VALUES (6, 3, 8, 'confirmado', '2026-01-15 01:28:38.065-03', '2026-01-15 01:28:38.065-03');
INSERT INTO padel_circuit.registrations (id, tournament_category_id, team_id, estado, created_at, updated_at) VALUES (7, 3, 7, 'confirmado', '2026-01-15 01:28:45.189-03', '2026-01-15 01:28:45.189-03');
INSERT INTO padel_circuit.registrations (id, tournament_category_id, team_id, estado, created_at, updated_at) VALUES (8, 3, 14, 'confirmado', '2026-01-15 01:28:54.791-03', '2026-01-15 01:28:54.791-03');
INSERT INTO padel_circuit.registrations (id, tournament_category_id, team_id, estado, created_at, updated_at) VALUES (9, 3, 13, 'confirmado', '2026-01-15 01:28:58.316-03', '2026-01-15 01:28:58.316-03');
INSERT INTO padel_circuit.registrations (id, tournament_category_id, team_id, estado, created_at, updated_at) VALUES (10, 3, 15, 'confirmado', '2026-01-15 01:29:01.792-03', '2026-01-15 01:29:01.792-03');
INSERT INTO padel_circuit.registrations (id, tournament_category_id, team_id, estado, created_at, updated_at) VALUES (11, 3, 18, 'confirmado', '2026-01-15 01:29:05.778-03', '2026-01-15 01:29:05.778-03');
INSERT INTO padel_circuit.registrations (id, tournament_category_id, team_id, estado, created_at, updated_at) VALUES (12, 3, 16, 'confirmado', '2026-01-15 01:29:10.296-03', '2026-01-15 01:29:10.296-03');
INSERT INTO padel_circuit.registrations (id, tournament_category_id, team_id, estado, created_at, updated_at) VALUES (13, 3, 11, 'confirmado', '2026-01-15 01:29:14.972-03', '2026-01-15 01:29:14.972-03');
INSERT INTO padel_circuit.registrations (id, tournament_category_id, team_id, estado, created_at, updated_at) VALUES (14, 4, 4, 'confirmado', '2026-01-15 20:44:32.582-03', '2026-01-15 20:44:32.582-03');
INSERT INTO padel_circuit.registrations (id, tournament_category_id, team_id, estado, created_at, updated_at) VALUES (15, 4, 5, 'confirmado', '2026-01-15 20:45:05.198-03', '2026-01-15 20:45:05.198-03');
INSERT INTO padel_circuit.registrations (id, tournament_category_id, team_id, estado, created_at, updated_at) VALUES (16, 5, 7, 'confirmado', '2026-01-15 20:48:51.69-03', '2026-01-15 20:48:51.69-03');
INSERT INTO padel_circuit.registrations (id, tournament_category_id, team_id, estado, created_at, updated_at) VALUES (17, 5, 14, 'confirmado', '2026-01-15 20:48:55.469-03', '2026-01-15 20:48:55.469-03');
INSERT INTO padel_circuit.registrations (id, tournament_category_id, team_id, estado, created_at, updated_at) VALUES (18, 5, 11, 'confirmado', '2026-01-15 20:49:02.023-03', '2026-01-15 20:49:02.023-03');
INSERT INTO padel_circuit.registrations (id, tournament_category_id, team_id, estado, created_at, updated_at) VALUES (19, 5, 15, 'confirmado', '2026-01-15 20:49:05.73-03', '2026-01-15 20:49:05.73-03');
INSERT INTO padel_circuit.registrations (id, tournament_category_id, team_id, estado, created_at, updated_at) VALUES (20, 5, 16, 'confirmado', '2026-01-15 20:49:12.97-03', '2026-01-15 20:49:12.97-03');
INSERT INTO padel_circuit.registrations (id, tournament_category_id, team_id, estado, created_at, updated_at) VALUES (21, 5, 17, 'confirmado', '2026-01-15 20:49:24.319-03', '2026-01-15 20:49:24.319-03');


--
-- Data for Name: teams; Type: TABLE DATA; Schema: padel_circuit; Owner: postgres
--

INSERT INTO padel_circuit.teams (id, player1_dni, player2_dni, estado, created_at, updated_at) VALUES (1, '30000001', '30000002', 'activa', '2026-01-15 00:23:18.726-03', '2026-01-15 00:23:18.726-03');
INSERT INTO padel_circuit.teams (id, player1_dni, player2_dni, estado, created_at, updated_at) VALUES (2, '30000003', '30000004', 'activa', '2026-01-15 00:23:31.409-03', '2026-01-15 00:23:31.409-03');
INSERT INTO padel_circuit.teams (id, player1_dni, player2_dni, estado, created_at, updated_at) VALUES (3, '30000005', '30000006', 'activa', '2026-01-15 00:23:46.412-03', '2026-01-15 00:23:46.412-03');
INSERT INTO padel_circuit.teams (id, player1_dni, player2_dni, estado, created_at, updated_at) VALUES (4, '30000007', '30000008', 'activa', '2026-01-15 00:23:58.519-03', '2026-01-15 00:23:58.519-03');
INSERT INTO padel_circuit.teams (id, player1_dni, player2_dni, estado, created_at, updated_at) VALUES (5, '30000009', '30000010', 'activa', '2026-01-15 00:24:08.332-03', '2026-01-15 00:24:08.332-03');
INSERT INTO padel_circuit.teams (id, player1_dni, player2_dni, estado, created_at, updated_at) VALUES (6, '30000061', '30000062', 'activa', '2026-01-15 01:25:18.559-03', '2026-01-15 01:25:18.559-03');
INSERT INTO padel_circuit.teams (id, player1_dni, player2_dni, estado, created_at, updated_at) VALUES (7, '30000063', '30000064', 'activa', '2026-01-15 01:25:32.814-03', '2026-01-15 01:25:32.814-03');
INSERT INTO padel_circuit.teams (id, player1_dni, player2_dni, estado, created_at, updated_at) VALUES (8, '30000065', '30000066', 'activa', '2026-01-15 01:25:42.333-03', '2026-01-15 01:25:42.333-03');
INSERT INTO padel_circuit.teams (id, player1_dni, player2_dni, estado, created_at, updated_at) VALUES (9, '30000067', '30000068', 'activa', '2026-01-15 01:25:52.794-03', '2026-01-15 01:25:52.794-03');
INSERT INTO padel_circuit.teams (id, player1_dni, player2_dni, estado, created_at, updated_at) VALUES (10, '30000069', '30000070', 'activa', '2026-01-15 01:26:02.857-03', '2026-01-15 01:26:02.857-03');
INSERT INTO padel_circuit.teams (id, player1_dni, player2_dni, estado, created_at, updated_at) VALUES (11, '30000070', '30000071', 'activa', '2026-01-15 01:26:14.26-03', '2026-01-15 01:26:14.26-03');
INSERT INTO padel_circuit.teams (id, player1_dni, player2_dni, estado, created_at, updated_at) VALUES (12, '30000072', '30000073', 'activa', '2026-01-15 01:26:40.46-03', '2026-01-15 01:26:40.46-03');
INSERT INTO padel_circuit.teams (id, player1_dni, player2_dni, estado, created_at, updated_at) VALUES (13, '30000074', '30000075', 'activa', '2026-01-15 01:26:48.619-03', '2026-01-15 01:26:48.619-03');
INSERT INTO padel_circuit.teams (id, player1_dni, player2_dni, estado, created_at, updated_at) VALUES (14, '30000076', '30000077', 'activa', '2026-01-15 01:27:20.755-03', '2026-01-15 01:27:20.755-03');
INSERT INTO padel_circuit.teams (id, player1_dni, player2_dni, estado, created_at, updated_at) VALUES (15, '30000078', '30000079', 'activa', '2026-01-15 01:27:29.379-03', '2026-01-15 01:27:29.379-03');
INSERT INTO padel_circuit.teams (id, player1_dni, player2_dni, estado, created_at, updated_at) VALUES (16, '30000080', '30000081', 'activa', '2026-01-15 01:27:39.107-03', '2026-01-15 01:27:39.107-03');
INSERT INTO padel_circuit.teams (id, player1_dni, player2_dni, estado, created_at, updated_at) VALUES (17, '30000082', '30000083', 'activa', '2026-01-15 01:27:46.581-03', '2026-01-15 01:27:46.581-03');
INSERT INTO padel_circuit.teams (id, player1_dni, player2_dni, estado, created_at, updated_at) VALUES (18, '30000084', '30000085', 'activa', '2026-01-15 01:27:57.798-03', '2026-01-15 01:27:57.798-03');


--
-- Data for Name: tournament_categories; Type: TABLE DATA; Schema: padel_circuit; Owner: postgres
--

INSERT INTO padel_circuit.tournament_categories (id, tournament_id, category_id, cupo, inscripcion_abierta, match_format, super_tiebreak_points, tiebreak_in_sets, win_points, loss_points, zone_size, qualifiers_per_zone, created_at, updated_at, estado) VALUES (1, 5, 4, 12, true, 'BEST_OF_3_FULL', 10, true, 2, 0, 3, 2, '2026-01-15 00:08:42.151-03', '2026-01-15 00:26:25.558-03', 'zonas_generadas');
INSERT INTO padel_circuit.tournament_categories (id, tournament_id, category_id, cupo, inscripcion_abierta, match_format, super_tiebreak_points, tiebreak_in_sets, win_points, loss_points, zone_size, qualifiers_per_zone, created_at, updated_at, estado) VALUES (3, 5, 5, 12, true, 'BEST_OF_3_FULL', 10, true, 2, 0, 3, 2, '2026-01-15 01:28:19.747-03', '2026-01-15 01:29:25.576-03', 'zonas_generadas');
INSERT INTO padel_circuit.tournament_categories (id, tournament_id, category_id, cupo, inscripcion_abierta, match_format, super_tiebreak_points, tiebreak_in_sets, win_points, loss_points, zone_size, qualifiers_per_zone, created_at, updated_at, estado) VALUES (2, 7, 4, 12, true, 'BEST_OF_3_SUPER_TB', 10, true, 2, 0, NULL, NULL, '2026-01-15 00:46:57.88-03', '2026-01-15 01:37:52.805-03', 'playoffs_generados');
INSERT INTO padel_circuit.tournament_categories (id, tournament_id, category_id, cupo, inscripcion_abierta, match_format, super_tiebreak_points, tiebreak_in_sets, win_points, loss_points, zone_size, qualifiers_per_zone, created_at, updated_at, estado) VALUES (4, 8, 4, 13, true, 'BEST_OF_3_FULL', 10, true, 2, 0, NULL, NULL, '2026-01-15 20:44:22.473-03', '2026-01-15 20:44:22.473-03', 'draft');
INSERT INTO padel_circuit.tournament_categories (id, tournament_id, category_id, cupo, inscripcion_abierta, match_format, super_tiebreak_points, tiebreak_in_sets, win_points, loss_points, zone_size, qualifiers_per_zone, created_at, updated_at, estado) VALUES (5, 9, 5, 8, true, 'BEST_OF_3_SUPER_TB', 10, true, 2, 0, NULL, NULL, '2026-01-15 20:48:44.652-03', '2026-01-15 20:48:44.652-03', 'draft');


--
-- Data for Name: tournament_points; Type: TABLE DATA; Schema: padel_circuit; Owner: postgres
--



--
-- Data for Name: tournaments; Type: TABLE DATA; Schema: padel_circuit; Owner: postgres
--

INSERT INTO padel_circuit.tournaments (id, nombre, fecha_inicio, fecha_fin, estado, descripcion, created_at, updated_at, double_points) VALUES (5, 'primer', '2026-01-15 21:00:00-03', '2026-01-17 21:00:00-03', 'draft', 'primer', '2026-01-14 23:56:06.579-03', '2026-01-14 23:56:06.579-03', false);
INSERT INTO padel_circuit.tournaments (id, nombre, fecha_inicio, fecha_fin, estado, descripcion, created_at, updated_at, double_points) VALUES (7, 'segundo torneo', '2026-01-22 21:00:00-03', '2026-01-17 21:00:00-03', 'draft', 'segundo ', '2026-01-15 00:46:38.877-03', '2026-01-15 00:46:38.877-03', false);
INSERT INTO padel_circuit.tournaments (id, nombre, fecha_inicio, fecha_fin, estado, descripcion, created_at, updated_at, double_points) VALUES (8, 'tercer', '2026-01-22 21:00:00-03', '2026-01-24 21:00:00-03', 'draft', '', '2026-01-15 20:44:04.801-03', '2026-01-15 20:44:04.801-03', false);
INSERT INTO padel_circuit.tournaments (id, nombre, fecha_inicio, fecha_fin, estado, descripcion, created_at, updated_at, double_points) VALUES (9, 'cuER', '2026-01-29 21:00:00-03', '2026-01-24 21:00:00-03', 'draft', '', '2026-01-15 20:48:34.499-03', '2026-01-15 20:48:34.499-03', false);


--
-- Data for Name: users; Type: TABLE DATA; Schema: padel_circuit; Owner: postgres
--

INSERT INTO padel_circuit.users (id, dni, password_hash, role, created_at, updated_at) VALUES (1, 'admin', '$2a$10$edNCEVls0CA6JBuNZVNDPuN5K4FAWvvU23QMMYWl3AQW51xGDfJ8q', 'admin', '2026-01-14 00:36:15.346-03', '2026-01-14 00:36:15.346-03');
INSERT INTO padel_circuit.users (id, dni, password_hash, role, created_at, updated_at) VALUES (2, '30000001', '$2a$10$h6zu5d3mYqCi0xcZRUErt.l2ImNiBPko.FwkDuy5XiuoOIrKSK9BS', 'player', '2026-01-15 00:12:00.558-03', '2026-01-15 00:12:00.558-03');
INSERT INTO padel_circuit.users (id, dni, password_hash, role, created_at, updated_at) VALUES (3, '30000002', '$2a$10$h6zu5d3mYqCi0xcZRUErt.l2ImNiBPko.FwkDuy5XiuoOIrKSK9BS', 'player', '2026-01-15 00:12:00.587-03', '2026-01-15 00:12:00.587-03');
INSERT INTO padel_circuit.users (id, dni, password_hash, role, created_at, updated_at) VALUES (4, '30000003', '$2a$10$h6zu5d3mYqCi0xcZRUErt.l2ImNiBPko.FwkDuy5XiuoOIrKSK9BS', 'player', '2026-01-15 00:12:00.592-03', '2026-01-15 00:12:00.592-03');
INSERT INTO padel_circuit.users (id, dni, password_hash, role, created_at, updated_at) VALUES (5, '30000004', '$2a$10$h6zu5d3mYqCi0xcZRUErt.l2ImNiBPko.FwkDuy5XiuoOIrKSK9BS', 'player', '2026-01-15 00:12:00.598-03', '2026-01-15 00:12:00.598-03');
INSERT INTO padel_circuit.users (id, dni, password_hash, role, created_at, updated_at) VALUES (6, '30000005', '$2a$10$h6zu5d3mYqCi0xcZRUErt.l2ImNiBPko.FwkDuy5XiuoOIrKSK9BS', 'player', '2026-01-15 00:12:00.603-03', '2026-01-15 00:12:00.603-03');
INSERT INTO padel_circuit.users (id, dni, password_hash, role, created_at, updated_at) VALUES (7, '30000006', '$2a$10$h6zu5d3mYqCi0xcZRUErt.l2ImNiBPko.FwkDuy5XiuoOIrKSK9BS', 'player', '2026-01-15 00:12:00.609-03', '2026-01-15 00:12:00.609-03');
INSERT INTO padel_circuit.users (id, dni, password_hash, role, created_at, updated_at) VALUES (8, '30000007', '$2a$10$h6zu5d3mYqCi0xcZRUErt.l2ImNiBPko.FwkDuy5XiuoOIrKSK9BS', 'player', '2026-01-15 00:12:00.613-03', '2026-01-15 00:12:00.613-03');
INSERT INTO padel_circuit.users (id, dni, password_hash, role, created_at, updated_at) VALUES (9, '30000008', '$2a$10$h6zu5d3mYqCi0xcZRUErt.l2ImNiBPko.FwkDuy5XiuoOIrKSK9BS', 'player', '2026-01-15 00:12:00.618-03', '2026-01-15 00:12:00.618-03');
INSERT INTO padel_circuit.users (id, dni, password_hash, role, created_at, updated_at) VALUES (10, '30000009', '$2a$10$h6zu5d3mYqCi0xcZRUErt.l2ImNiBPko.FwkDuy5XiuoOIrKSK9BS', 'player', '2026-01-15 00:12:00.623-03', '2026-01-15 00:12:00.623-03');
INSERT INTO padel_circuit.users (id, dni, password_hash, role, created_at, updated_at) VALUES (11, '30000010', '$2a$10$h6zu5d3mYqCi0xcZRUErt.l2ImNiBPko.FwkDuy5XiuoOIrKSK9BS', 'player', '2026-01-15 00:12:00.627-03', '2026-01-15 00:12:00.627-03');
INSERT INTO padel_circuit.users (id, dni, password_hash, role, created_at, updated_at) VALUES (12, '30000011', '$2a$10$h6zu5d3mYqCi0xcZRUErt.l2ImNiBPko.FwkDuy5XiuoOIrKSK9BS', 'player', '2026-01-15 00:12:00.631-03', '2026-01-15 00:12:00.631-03');
INSERT INTO padel_circuit.users (id, dni, password_hash, role, created_at, updated_at) VALUES (13, '30000012', '$2a$10$h6zu5d3mYqCi0xcZRUErt.l2ImNiBPko.FwkDuy5XiuoOIrKSK9BS', 'player', '2026-01-15 00:12:00.636-03', '2026-01-15 00:12:00.636-03');


--
-- Data for Name: venues; Type: TABLE DATA; Schema: padel_circuit; Owner: postgres
--

INSERT INTO padel_circuit.venues (id, name, address, courts_count, active, created_at, updated_at) VALUES (1, 'Club Deportivo Central', 'Av. Principal 123', 4, true, '2026-01-15 03:36:08.584488', '2026-01-15 03:36:08.584488');
INSERT INTO padel_circuit.venues (id, name, address, courts_count, active, created_at, updated_at) VALUES (2, 'Complejo Padel Norte', 'Calle Norte 456', 6, true, '2026-01-15 03:36:08.584488', '2026-01-15 03:36:08.584488');
INSERT INTO padel_circuit.venues (id, name, address, courts_count, active, created_at, updated_at) VALUES (3, 'Centro Deportivo Sur', 'Av. Sur 789', 3, true, '2026-01-15 03:36:08.584488', '2026-01-15 03:36:08.584488');


--
-- Data for Name: zone_matches; Type: TABLE DATA; Schema: padel_circuit; Owner: postgres
--

INSERT INTO padel_circuit.zone_matches (id, zone_id, round_number, match_number, team_home_id, team_away_id, status, score_json, winner_team_id, played_at, scheduled_at, created_at, updated_at, venue) VALUES (2, 2, 1, 1, 2, 4, 'pending', NULL, NULL, NULL, NULL, '2026-01-15 00:26:25.548-03', '2026-01-15 00:26:25.548-03', NULL);
INSERT INTO padel_circuit.zone_matches (id, zone_id, round_number, match_number, team_home_id, team_away_id, status, score_json, winner_team_id, played_at, scheduled_at, created_at, updated_at, venue) VALUES (1, 1, 1, 1, 1, 5, 'pending', NULL, NULL, NULL, '2026-01-19 17:30:00-03', '2026-01-15 00:26:25.523-03', '2026-01-15 00:32:20.207-03', 'de');
INSERT INTO padel_circuit.zone_matches (id, zone_id, round_number, match_number, team_home_id, team_away_id, status, score_json, winner_team_id, played_at, scheduled_at, created_at, updated_at, venue) VALUES (3, 3, 1, 1, 1, 4, 'played', '{"sets": [{"away": 3, "home": 6}, {"away": 3, "home": 6}], "format": "BEST_OF_3_SUPER_TB"}', 1, '2026-01-15 01:12:38.717-03', '2026-01-16 16:00:00-03', '2026-01-15 00:47:50.827-03', '2026-01-15 01:12:38.718-03', 'Centro Deportivo Sur');
INSERT INTO padel_circuit.zone_matches (id, zone_id, round_number, match_number, team_home_id, team_away_id, status, score_json, winner_team_id, played_at, scheduled_at, created_at, updated_at, venue) VALUES (4, 3, 1, 2, 2, 2, 'played', '{"sets": [{"away": 2, "home": 6}, {"away": 4, "home": 6}], "format": "BEST_OF_3_SUPER_TB"}', 2, '2026-01-15 01:12:57.098-03', NULL, '2026-01-15 00:47:50.832-03', '2026-01-15 01:12:57.099-03', NULL);
INSERT INTO padel_circuit.zone_matches (id, zone_id, round_number, match_number, team_home_id, team_away_id, status, score_json, winner_team_id, played_at, scheduled_at, created_at, updated_at, venue) VALUES (6, 3, 2, 4, 4, 4, 'played', '{"sets": [{"away": 2, "home": 6}, {"away": 5, "home": 7}], "format": "BEST_OF_3_SUPER_TB"}', 4, '2026-01-15 01:13:07.117-03', NULL, '2026-01-15 00:47:50.839-03', '2026-01-15 01:13:07.118-03', NULL);
INSERT INTO padel_circuit.zone_matches (id, zone_id, round_number, match_number, team_home_id, team_away_id, status, score_json, winner_team_id, played_at, scheduled_at, created_at, updated_at, venue) VALUES (5, 3, 2, 3, 1, 2, 'played', '{"sets": [{"away": 6, "home": 7}, {"away": 6, "home": 7}], "format": "BEST_OF_3_SUPER_TB"}', 1, '2026-01-15 01:13:15.967-03', NULL, '2026-01-15 00:47:50.835-03', '2026-01-15 01:13:15.967-03', NULL);
INSERT INTO padel_circuit.zone_matches (id, zone_id, round_number, match_number, team_home_id, team_away_id, status, score_json, winner_team_id, played_at, scheduled_at, created_at, updated_at, venue) VALUES (7, 5, 1, 1, 11, 13, 'pending', NULL, NULL, NULL, NULL, '2026-01-15 01:29:25.516-03', '2026-01-15 01:29:25.516-03', NULL);
INSERT INTO padel_circuit.zone_matches (id, zone_id, round_number, match_number, team_home_id, team_away_id, status, score_json, winner_team_id, played_at, scheduled_at, created_at, updated_at, venue) VALUES (8, 5, 2, 2, 8, 11, 'pending', NULL, NULL, NULL, NULL, '2026-01-15 01:29:25.52-03', '2026-01-15 01:29:25.52-03', NULL);
INSERT INTO padel_circuit.zone_matches (id, zone_id, round_number, match_number, team_home_id, team_away_id, status, score_json, winner_team_id, played_at, scheduled_at, created_at, updated_at, venue) VALUES (9, 5, 3, 3, 8, 13, 'pending', NULL, NULL, NULL, NULL, '2026-01-15 01:29:25.522-03', '2026-01-15 01:29:25.522-03', NULL);
INSERT INTO padel_circuit.zone_matches (id, zone_id, round_number, match_number, team_home_id, team_away_id, status, score_json, winner_team_id, played_at, scheduled_at, created_at, updated_at, venue) VALUES (10, 6, 1, 1, 15, 18, 'pending', NULL, NULL, NULL, NULL, '2026-01-15 01:29:25.537-03', '2026-01-15 01:29:25.537-03', NULL);
INSERT INTO padel_circuit.zone_matches (id, zone_id, round_number, match_number, team_home_id, team_away_id, status, score_json, winner_team_id, played_at, scheduled_at, created_at, updated_at, venue) VALUES (11, 6, 2, 2, 7, 15, 'pending', NULL, NULL, NULL, NULL, '2026-01-15 01:29:25.54-03', '2026-01-15 01:29:25.54-03', NULL);
INSERT INTO padel_circuit.zone_matches (id, zone_id, round_number, match_number, team_home_id, team_away_id, status, score_json, winner_team_id, played_at, scheduled_at, created_at, updated_at, venue) VALUES (12, 6, 3, 3, 7, 18, 'pending', NULL, NULL, NULL, NULL, '2026-01-15 01:29:25.543-03', '2026-01-15 01:29:25.543-03', NULL);
INSERT INTO padel_circuit.zone_matches (id, zone_id, round_number, match_number, team_home_id, team_away_id, status, score_json, winner_team_id, played_at, scheduled_at, created_at, updated_at, venue) VALUES (13, 7, 1, 1, 14, 16, 'pending', NULL, NULL, NULL, NULL, '2026-01-15 01:29:25.556-03', '2026-01-15 01:29:25.556-03', NULL);
INSERT INTO padel_circuit.zone_matches (id, zone_id, round_number, match_number, team_home_id, team_away_id, status, score_json, winner_team_id, played_at, scheduled_at, created_at, updated_at, venue) VALUES (14, 7, 2, 2, 6, 14, 'pending', NULL, NULL, NULL, NULL, '2026-01-15 01:29:25.559-03', '2026-01-15 01:29:25.559-03', NULL);
INSERT INTO padel_circuit.zone_matches (id, zone_id, round_number, match_number, team_home_id, team_away_id, status, score_json, winner_team_id, played_at, scheduled_at, created_at, updated_at, venue) VALUES (15, 7, 3, 3, 6, 16, 'pending', NULL, NULL, NULL, NULL, '2026-01-15 01:29:25.562-03', '2026-01-15 01:29:25.562-03', NULL);
INSERT INTO padel_circuit.zone_matches (id, zone_id, round_number, match_number, team_home_id, team_away_id, status, score_json, winner_team_id, played_at, scheduled_at, created_at, updated_at, venue) VALUES (19, 9, 2, 4, 15, 15, 'pending', NULL, NULL, NULL, NULL, '2026-01-15 20:49:54.276-03', '2026-01-15 20:49:54.276-03', NULL);
INSERT INTO padel_circuit.zone_matches (id, zone_id, round_number, match_number, team_home_id, team_away_id, status, score_json, winner_team_id, played_at, scheduled_at, created_at, updated_at, venue) VALUES (20, 10, 1, 1, 14, 11, 'pending', NULL, NULL, NULL, NULL, '2026-01-15 20:49:54.297-03', '2026-01-15 20:49:54.297-03', NULL);
INSERT INTO padel_circuit.zone_matches (id, zone_id, round_number, match_number, team_home_id, team_away_id, status, score_json, winner_team_id, played_at, scheduled_at, created_at, updated_at, venue) VALUES (21, 10, 1, 2, 7, 7, 'pending', NULL, NULL, NULL, NULL, '2026-01-15 20:49:54.301-03', '2026-01-15 20:49:54.301-03', NULL);
INSERT INTO padel_circuit.zone_matches (id, zone_id, round_number, match_number, team_home_id, team_away_id, status, score_json, winner_team_id, played_at, scheduled_at, created_at, updated_at, venue) VALUES (22, 10, 2, 3, 14, 7, 'pending', NULL, NULL, NULL, NULL, '2026-01-15 20:49:54.304-03', '2026-01-15 20:49:54.304-03', NULL);
INSERT INTO padel_circuit.zone_matches (id, zone_id, round_number, match_number, team_home_id, team_away_id, status, score_json, winner_team_id, played_at, scheduled_at, created_at, updated_at, venue) VALUES (16, 9, 1, 1, 17, 15, 'pending', NULL, NULL, NULL, '2026-01-17 22:55:00-03', '2026-01-15 20:49:54.243-03', '2026-01-15 20:54:00.624-03', 'Centro Deportivo Sur');
INSERT INTO padel_circuit.zone_matches (id, zone_id, round_number, match_number, team_home_id, team_away_id, status, score_json, winner_team_id, played_at, scheduled_at, created_at, updated_at, venue) VALUES (17, 9, 1, 2, 16, 16, 'pending', NULL, NULL, NULL, '2026-01-24 12:58:00-03', '2026-01-15 20:49:54.268-03', '2026-01-16 08:54:09.798-03', 'Centro Deportivo Sur');
INSERT INTO padel_circuit.zone_matches (id, zone_id, round_number, match_number, team_home_id, team_away_id, status, score_json, winner_team_id, played_at, scheduled_at, created_at, updated_at, venue) VALUES (18, 9, 2, 3, 17, 16, 'pending', NULL, NULL, NULL, '2026-01-24 13:59:00-03', '2026-01-15 20:49:54.272-03', '2026-01-16 08:54:35.139-03', 'Centro Deportivo Sur');
INSERT INTO padel_circuit.zone_matches (id, zone_id, round_number, match_number, team_home_id, team_away_id, status, score_json, winner_team_id, played_at, scheduled_at, created_at, updated_at, venue) VALUES (23, 10, 2, 4, 11, 11, 'pending', NULL, NULL, NULL, '2026-01-24 13:06:00-03', '2026-01-15 20:49:54.306-03', '2026-01-16 09:02:50.712-03', 'Centro Deportivo Sur');


--
-- Data for Name: zone_standings; Type: TABLE DATA; Schema: padel_circuit; Owner: postgres
--

INSERT INTO padel_circuit.zone_standings (id, zone_id, team_id, played, wins, losses, points, sets_for, sets_against, sets_diff, games_for, games_against, games_diff, created_at, updated_at) VALUES (1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '2026-01-15 00:26:25.532-03', '2026-01-15 00:26:25.532-03');
INSERT INTO padel_circuit.zone_standings (id, zone_id, team_id, played, wins, losses, points, sets_for, sets_against, sets_diff, games_for, games_against, games_diff, created_at, updated_at) VALUES (2, 1, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '2026-01-15 00:26:25.543-03', '2026-01-15 00:26:25.543-03');
INSERT INTO padel_circuit.zone_standings (id, zone_id, team_id, played, wins, losses, points, sets_for, sets_against, sets_diff, games_for, games_against, games_diff, created_at, updated_at) VALUES (3, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '2026-01-15 00:26:25.551-03', '2026-01-15 00:26:25.551-03');
INSERT INTO padel_circuit.zone_standings (id, zone_id, team_id, played, wins, losses, points, sets_for, sets_against, sets_diff, games_for, games_against, games_diff, created_at, updated_at) VALUES (4, 2, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '2026-01-15 00:26:25.554-03', '2026-01-15 00:26:25.554-03');
INSERT INTO padel_circuit.zone_standings (id, zone_id, team_id, played, wins, losses, points, sets_for, sets_against, sets_diff, games_for, games_against, games_diff, created_at, updated_at) VALUES (8, 4, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '2026-01-15 00:47:50.846-03', '2026-01-15 00:47:50.846-03');
INSERT INTO padel_circuit.zone_standings (id, zone_id, team_id, played, wins, losses, points, sets_for, sets_against, sets_diff, games_for, games_against, games_diff, created_at, updated_at) VALUES (5, 3, 1, 1, 1, 0, 2, 2, 0, 2, 12, 6, 6, '2026-01-15 00:47:50.805-03', '2026-01-15 01:13:15.983-03');
INSERT INTO padel_circuit.zone_standings (id, zone_id, team_id, played, wins, losses, points, sets_for, sets_against, sets_diff, games_for, games_against, games_diff, created_at, updated_at) VALUES (6, 3, 2, 2, 1, 1, 2, 2, 2, 0, 18, 18, 0, '2026-01-15 00:47:50.814-03', '2026-01-15 01:13:15.985-03');
INSERT INTO padel_circuit.zone_standings (id, zone_id, team_id, played, wins, losses, points, sets_for, sets_against, sets_diff, games_for, games_against, games_diff, created_at, updated_at) VALUES (7, 3, 4, 3, 1, 2, 2, 2, 4, -2, 26, 32, -6, '2026-01-15 00:47:50.822-03', '2026-01-15 01:13:15.989-03');
INSERT INTO padel_circuit.zone_standings (id, zone_id, team_id, played, wins, losses, points, sets_for, sets_against, sets_diff, games_for, games_against, games_diff, created_at, updated_at) VALUES (9, 5, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '2026-01-15 01:29:25.525-03', '2026-01-15 01:29:25.525-03');
INSERT INTO padel_circuit.zone_standings (id, zone_id, team_id, played, wins, losses, points, sets_for, sets_against, sets_diff, games_for, games_against, games_diff, created_at, updated_at) VALUES (10, 5, 11, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '2026-01-15 01:29:25.529-03', '2026-01-15 01:29:25.529-03');
INSERT INTO padel_circuit.zone_standings (id, zone_id, team_id, played, wins, losses, points, sets_for, sets_against, sets_diff, games_for, games_against, games_diff, created_at, updated_at) VALUES (11, 5, 13, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '2026-01-15 01:29:25.532-03', '2026-01-15 01:29:25.532-03');
INSERT INTO padel_circuit.zone_standings (id, zone_id, team_id, played, wins, losses, points, sets_for, sets_against, sets_diff, games_for, games_against, games_diff, created_at, updated_at) VALUES (12, 6, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '2026-01-15 01:29:25.546-03', '2026-01-15 01:29:25.546-03');
INSERT INTO padel_circuit.zone_standings (id, zone_id, team_id, played, wins, losses, points, sets_for, sets_against, sets_diff, games_for, games_against, games_diff, created_at, updated_at) VALUES (13, 6, 15, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '2026-01-15 01:29:25.549-03', '2026-01-15 01:29:25.549-03');
INSERT INTO padel_circuit.zone_standings (id, zone_id, team_id, played, wins, losses, points, sets_for, sets_against, sets_diff, games_for, games_against, games_diff, created_at, updated_at) VALUES (14, 6, 18, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '2026-01-15 01:29:25.551-03', '2026-01-15 01:29:25.551-03');
INSERT INTO padel_circuit.zone_standings (id, zone_id, team_id, played, wins, losses, points, sets_for, sets_against, sets_diff, games_for, games_against, games_diff, created_at, updated_at) VALUES (15, 7, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '2026-01-15 01:29:25.566-03', '2026-01-15 01:29:25.566-03');
INSERT INTO padel_circuit.zone_standings (id, zone_id, team_id, played, wins, losses, points, sets_for, sets_against, sets_diff, games_for, games_against, games_diff, created_at, updated_at) VALUES (16, 7, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '2026-01-15 01:29:25.569-03', '2026-01-15 01:29:25.569-03');
INSERT INTO padel_circuit.zone_standings (id, zone_id, team_id, played, wins, losses, points, sets_for, sets_against, sets_diff, games_for, games_against, games_diff, created_at, updated_at) VALUES (17, 7, 16, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '2026-01-15 01:29:25.571-03', '2026-01-15 01:29:25.571-03');
INSERT INTO padel_circuit.zone_standings (id, zone_id, team_id, played, wins, losses, points, sets_for, sets_against, sets_diff, games_for, games_against, games_diff, created_at, updated_at) VALUES (18, 8, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '2026-01-15 20:44:56.479-03', '2026-01-15 20:44:56.479-03');
INSERT INTO padel_circuit.zone_standings (id, zone_id, team_id, played, wins, losses, points, sets_for, sets_against, sets_diff, games_for, games_against, games_diff, created_at, updated_at) VALUES (19, 9, 17, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '2026-01-15 20:49:54.194-03', '2026-01-15 20:49:54.194-03');
INSERT INTO padel_circuit.zone_standings (id, zone_id, team_id, played, wins, losses, points, sets_for, sets_against, sets_diff, games_for, games_against, games_diff, created_at, updated_at) VALUES (20, 9, 16, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '2026-01-15 20:49:54.23-03', '2026-01-15 20:49:54.23-03');
INSERT INTO padel_circuit.zone_standings (id, zone_id, team_id, played, wins, losses, points, sets_for, sets_against, sets_diff, games_for, games_against, games_diff, created_at, updated_at) VALUES (21, 9, 15, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '2026-01-15 20:49:54.239-03', '2026-01-15 20:49:54.239-03');
INSERT INTO padel_circuit.zone_standings (id, zone_id, team_id, played, wins, losses, points, sets_for, sets_against, sets_diff, games_for, games_against, games_diff, created_at, updated_at) VALUES (22, 10, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '2026-01-15 20:49:54.285-03', '2026-01-15 20:49:54.285-03');
INSERT INTO padel_circuit.zone_standings (id, zone_id, team_id, played, wins, losses, points, sets_for, sets_against, sets_diff, games_for, games_against, games_diff, created_at, updated_at) VALUES (23, 10, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '2026-01-15 20:49:54.29-03', '2026-01-15 20:49:54.29-03');
INSERT INTO padel_circuit.zone_standings (id, zone_id, team_id, played, wins, losses, points, sets_for, sets_against, sets_diff, games_for, games_against, games_diff, created_at, updated_at) VALUES (24, 10, 11, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '2026-01-15 20:49:54.295-03', '2026-01-15 20:49:54.295-03');


--
-- Data for Name: zone_teams; Type: TABLE DATA; Schema: padel_circuit; Owner: postgres
--

INSERT INTO padel_circuit.zone_teams (id, zone_id, team_id, created_at, updated_at) VALUES (1, 1, 5, '2026-01-15 00:26:25.5-03', '2026-01-15 00:26:25.5-03');
INSERT INTO padel_circuit.zone_teams (id, zone_id, team_id, created_at, updated_at) VALUES (2, 2, 2, '2026-01-15 00:26:25.508-03', '2026-01-15 00:26:25.508-03');
INSERT INTO padel_circuit.zone_teams (id, zone_id, team_id, created_at, updated_at) VALUES (3, 1, 1, '2026-01-15 00:26:25.512-03', '2026-01-15 00:26:25.512-03');
INSERT INTO padel_circuit.zone_teams (id, zone_id, team_id, created_at, updated_at) VALUES (4, 2, 4, '2026-01-15 00:26:25.515-03', '2026-01-15 00:26:25.515-03');
INSERT INTO padel_circuit.zone_teams (id, zone_id, team_id, created_at, updated_at) VALUES (5, 3, 1, '2026-01-15 00:47:50.797-03', '2026-01-15 00:47:50.797-03');
INSERT INTO padel_circuit.zone_teams (id, zone_id, team_id, created_at, updated_at) VALUES (6, 3, 2, '2026-01-15 00:47:50.811-03', '2026-01-15 00:47:50.811-03');
INSERT INTO padel_circuit.zone_teams (id, zone_id, team_id, created_at, updated_at) VALUES (7, 3, 4, '2026-01-15 00:47:50.818-03', '2026-01-15 00:47:50.818-03');
INSERT INTO padel_circuit.zone_teams (id, zone_id, team_id, created_at, updated_at) VALUES (8, 4, 5, '2026-01-15 00:47:50.844-03', '2026-01-15 00:47:50.844-03');
INSERT INTO padel_circuit.zone_teams (id, zone_id, team_id, created_at, updated_at) VALUES (9, 5, 8, '2026-01-15 01:29:25.49-03', '2026-01-15 01:29:25.49-03');
INSERT INTO padel_circuit.zone_teams (id, zone_id, team_id, created_at, updated_at) VALUES (10, 6, 15, '2026-01-15 01:29:25.493-03', '2026-01-15 01:29:25.493-03');
INSERT INTO padel_circuit.zone_teams (id, zone_id, team_id, created_at, updated_at) VALUES (11, 7, 16, '2026-01-15 01:29:25.496-03', '2026-01-15 01:29:25.496-03');
INSERT INTO padel_circuit.zone_teams (id, zone_id, team_id, created_at, updated_at) VALUES (12, 5, 11, '2026-01-15 01:29:25.498-03', '2026-01-15 01:29:25.498-03');
INSERT INTO padel_circuit.zone_teams (id, zone_id, team_id, created_at, updated_at) VALUES (13, 6, 7, '2026-01-15 01:29:25.5-03', '2026-01-15 01:29:25.5-03');
INSERT INTO padel_circuit.zone_teams (id, zone_id, team_id, created_at, updated_at) VALUES (14, 7, 14, '2026-01-15 01:29:25.502-03', '2026-01-15 01:29:25.502-03');
INSERT INTO padel_circuit.zone_teams (id, zone_id, team_id, created_at, updated_at) VALUES (15, 5, 13, '2026-01-15 01:29:25.504-03', '2026-01-15 01:29:25.504-03');
INSERT INTO padel_circuit.zone_teams (id, zone_id, team_id, created_at, updated_at) VALUES (16, 6, 18, '2026-01-15 01:29:25.506-03', '2026-01-15 01:29:25.506-03');
INSERT INTO padel_circuit.zone_teams (id, zone_id, team_id, created_at, updated_at) VALUES (17, 7, 6, '2026-01-15 01:29:25.509-03', '2026-01-15 01:29:25.509-03');
INSERT INTO padel_circuit.zone_teams (id, zone_id, team_id, created_at, updated_at) VALUES (18, 8, 4, '2026-01-15 20:44:56.473-03', '2026-01-15 20:44:56.473-03');
INSERT INTO padel_circuit.zone_teams (id, zone_id, team_id, created_at, updated_at) VALUES (19, 9, 17, '2026-01-15 20:49:54.181-03', '2026-01-15 20:49:54.181-03');
INSERT INTO padel_circuit.zone_teams (id, zone_id, team_id, created_at, updated_at) VALUES (20, 9, 16, '2026-01-15 20:49:54.226-03', '2026-01-15 20:49:54.226-03');
INSERT INTO padel_circuit.zone_teams (id, zone_id, team_id, created_at, updated_at) VALUES (21, 9, 15, '2026-01-15 20:49:54.234-03', '2026-01-15 20:49:54.234-03');
INSERT INTO padel_circuit.zone_teams (id, zone_id, team_id, created_at, updated_at) VALUES (22, 10, 14, '2026-01-15 20:49:54.282-03', '2026-01-15 20:49:54.282-03');
INSERT INTO padel_circuit.zone_teams (id, zone_id, team_id, created_at, updated_at) VALUES (23, 10, 7, '2026-01-15 20:49:54.288-03', '2026-01-15 20:49:54.288-03');
INSERT INTO padel_circuit.zone_teams (id, zone_id, team_id, created_at, updated_at) VALUES (24, 10, 11, '2026-01-15 20:49:54.293-03', '2026-01-15 20:49:54.293-03');


--
-- Data for Name: zones; Type: TABLE DATA; Schema: padel_circuit; Owner: postgres
--

INSERT INTO padel_circuit.zones (id, tournament_category_id, name, order_index, created_at, updated_at) VALUES (1, 1, 'Zona A', 0, '2026-01-15 00:26:25.489-03', '2026-01-15 00:26:25.489-03');
INSERT INTO padel_circuit.zones (id, tournament_category_id, name, order_index, created_at, updated_at) VALUES (2, 1, 'Zona B', 1, '2026-01-15 00:26:25.497-03', '2026-01-15 00:26:25.497-03');
INSERT INTO padel_circuit.zones (id, tournament_category_id, name, order_index, created_at, updated_at) VALUES (3, 2, 'A', 0, '2026-01-15 00:47:50.792-03', '2026-01-15 00:47:50.792-03');
INSERT INTO padel_circuit.zones (id, tournament_category_id, name, order_index, created_at, updated_at) VALUES (4, 2, 'B', 1, '2026-01-15 00:47:50.842-03', '2026-01-15 00:47:50.842-03');
INSERT INTO padel_circuit.zones (id, tournament_category_id, name, order_index, created_at, updated_at) VALUES (5, 3, 'Zona A', 0, '2026-01-15 01:29:25.481-03', '2026-01-15 01:29:25.481-03');
INSERT INTO padel_circuit.zones (id, tournament_category_id, name, order_index, created_at, updated_at) VALUES (6, 3, 'Zona B', 1, '2026-01-15 01:29:25.485-03', '2026-01-15 01:29:25.485-03');
INSERT INTO padel_circuit.zones (id, tournament_category_id, name, order_index, created_at, updated_at) VALUES (7, 3, 'Zona C', 2, '2026-01-15 01:29:25.487-03', '2026-01-15 01:29:25.487-03');
INSERT INTO padel_circuit.zones (id, tournament_category_id, name, order_index, created_at, updated_at) VALUES (8, 4, 'A', 0, '2026-01-15 20:44:56.47-03', '2026-01-15 20:44:56.47-03');
INSERT INTO padel_circuit.zones (id, tournament_category_id, name, order_index, created_at, updated_at) VALUES (9, 5, 'A', 0, '2026-01-15 20:49:54.174-03', '2026-01-15 20:49:54.174-03');
INSERT INTO padel_circuit.zones (id, tournament_category_id, name, order_index, created_at, updated_at) VALUES (10, 5, 'B', 1, '2026-01-15 20:49:54.279-03', '2026-01-15 20:49:54.279-03');


--
-- Name: brackets_id_seq; Type: SEQUENCE SET; Schema: padel_circuit; Owner: postgres
--

SELECT pg_catalog.setval('padel_circuit.brackets_id_seq', 6, true);


--
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: padel_circuit; Owner: postgres
--

SELECT pg_catalog.setval('padel_circuit.categories_id_seq', 8, true);


--
-- Name: matches_id_seq; Type: SEQUENCE SET; Schema: padel_circuit; Owner: postgres
--

SELECT pg_catalog.setval('padel_circuit.matches_id_seq', 1, false);


--
-- Name: registrations_id_seq; Type: SEQUENCE SET; Schema: padel_circuit; Owner: postgres
--

SELECT pg_catalog.setval('padel_circuit.registrations_id_seq', 21, true);


--
-- Name: teams_id_seq; Type: SEQUENCE SET; Schema: padel_circuit; Owner: postgres
--

SELECT pg_catalog.setval('padel_circuit.teams_id_seq', 18, true);


--
-- Name: tournament_categories_id_seq; Type: SEQUENCE SET; Schema: padel_circuit; Owner: postgres
--

SELECT pg_catalog.setval('padel_circuit.tournament_categories_id_seq', 5, true);


--
-- Name: tournament_points_id_seq; Type: SEQUENCE SET; Schema: padel_circuit; Owner: postgres
--

SELECT pg_catalog.setval('padel_circuit.tournament_points_id_seq', 1, false);


--
-- Name: tournaments_id_seq; Type: SEQUENCE SET; Schema: padel_circuit; Owner: postgres
--

SELECT pg_catalog.setval('padel_circuit.tournaments_id_seq', 9, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: padel_circuit; Owner: postgres
--

SELECT pg_catalog.setval('padel_circuit.users_id_seq', 13, true);


--
-- Name: venues_id_seq; Type: SEQUENCE SET; Schema: padel_circuit; Owner: postgres
--

SELECT pg_catalog.setval('padel_circuit.venues_id_seq', 3, true);


--
-- Name: zone_matches_id_seq; Type: SEQUENCE SET; Schema: padel_circuit; Owner: postgres
--

SELECT pg_catalog.setval('padel_circuit.zone_matches_id_seq', 23, true);


--
-- Name: zone_standings_id_seq; Type: SEQUENCE SET; Schema: padel_circuit; Owner: postgres
--

SELECT pg_catalog.setval('padel_circuit.zone_standings_id_seq', 24, true);


--
-- Name: zone_teams_id_seq; Type: SEQUENCE SET; Schema: padel_circuit; Owner: postgres
--

SELECT pg_catalog.setval('padel_circuit.zone_teams_id_seq', 24, true);


--
-- Name: zones_id_seq; Type: SEQUENCE SET; Schema: padel_circuit; Owner: postgres
--

SELECT pg_catalog.setval('padel_circuit.zones_id_seq', 10, true);


--
-- Name: brackets brackets_pkey; Type: CONSTRAINT; Schema: padel_circuit; Owner: postgres
--

ALTER TABLE ONLY padel_circuit.brackets
    ADD CONSTRAINT brackets_pkey PRIMARY KEY (id);


--
-- Name: categories categories_name_key; Type: CONSTRAINT; Schema: padel_circuit; Owner: postgres
--

ALTER TABLE ONLY padel_circuit.categories
    ADD CONSTRAINT categories_name_key UNIQUE (name);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: padel_circuit; Owner: postgres
--

ALTER TABLE ONLY padel_circuit.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: categories categories_rank_key; Type: CONSTRAINT; Schema: padel_circuit; Owner: postgres
--

ALTER TABLE ONLY padel_circuit.categories
    ADD CONSTRAINT categories_rank_key UNIQUE (rank);


--
-- Name: matches matches_pkey; Type: CONSTRAINT; Schema: padel_circuit; Owner: postgres
--

ALTER TABLE ONLY padel_circuit.matches
    ADD CONSTRAINT matches_pkey PRIMARY KEY (id);


--
-- Name: player_profiles player_profiles_pkey; Type: CONSTRAINT; Schema: padel_circuit; Owner: postgres
--

ALTER TABLE ONLY padel_circuit.player_profiles
    ADD CONSTRAINT player_profiles_pkey PRIMARY KEY (dni);


--
-- Name: registrations registrations_pkey; Type: CONSTRAINT; Schema: padel_circuit; Owner: postgres
--

ALTER TABLE ONLY padel_circuit.registrations
    ADD CONSTRAINT registrations_pkey PRIMARY KEY (id);


--
-- Name: teams teams_pkey; Type: CONSTRAINT; Schema: padel_circuit; Owner: postgres
--

ALTER TABLE ONLY padel_circuit.teams
    ADD CONSTRAINT teams_pkey PRIMARY KEY (id);


--
-- Name: tournament_categories tournament_categories_pkey; Type: CONSTRAINT; Schema: padel_circuit; Owner: postgres
--

ALTER TABLE ONLY padel_circuit.tournament_categories
    ADD CONSTRAINT tournament_categories_pkey PRIMARY KEY (id);


--
-- Name: tournament_points tournament_points_pkey; Type: CONSTRAINT; Schema: padel_circuit; Owner: postgres
--

ALTER TABLE ONLY padel_circuit.tournament_points
    ADD CONSTRAINT tournament_points_pkey PRIMARY KEY (id);


--
-- Name: tournament_points tournament_points_unique; Type: CONSTRAINT; Schema: padel_circuit; Owner: postgres
--

ALTER TABLE ONLY padel_circuit.tournament_points
    ADD CONSTRAINT tournament_points_unique UNIQUE (tournament_category_id, player_dni);


--
-- Name: tournaments tournaments_pkey; Type: CONSTRAINT; Schema: padel_circuit; Owner: postgres
--

ALTER TABLE ONLY padel_circuit.tournaments
    ADD CONSTRAINT tournaments_pkey PRIMARY KEY (id);


--
-- Name: users users_dni_key; Type: CONSTRAINT; Schema: padel_circuit; Owner: postgres
--

ALTER TABLE ONLY padel_circuit.users
    ADD CONSTRAINT users_dni_key UNIQUE (dni);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: padel_circuit; Owner: postgres
--

ALTER TABLE ONLY padel_circuit.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: venues venues_pkey; Type: CONSTRAINT; Schema: padel_circuit; Owner: postgres
--

ALTER TABLE ONLY padel_circuit.venues
    ADD CONSTRAINT venues_pkey PRIMARY KEY (id);


--
-- Name: zone_matches zone_matches_pkey; Type: CONSTRAINT; Schema: padel_circuit; Owner: postgres
--

ALTER TABLE ONLY padel_circuit.zone_matches
    ADD CONSTRAINT zone_matches_pkey PRIMARY KEY (id);


--
-- Name: zone_standings zone_standings_pkey; Type: CONSTRAINT; Schema: padel_circuit; Owner: postgres
--

ALTER TABLE ONLY padel_circuit.zone_standings
    ADD CONSTRAINT zone_standings_pkey PRIMARY KEY (id);


--
-- Name: zone_teams zone_teams_pkey; Type: CONSTRAINT; Schema: padel_circuit; Owner: postgres
--

ALTER TABLE ONLY padel_circuit.zone_teams
    ADD CONSTRAINT zone_teams_pkey PRIMARY KEY (id);


--
-- Name: zones zones_pkey; Type: CONSTRAINT; Schema: padel_circuit; Owner: postgres
--

ALTER TABLE ONLY padel_circuit.zones
    ADD CONSTRAINT zones_pkey PRIMARY KEY (id);


--
-- Name: idx_tournament_points_player; Type: INDEX; Schema: padel_circuit; Owner: postgres
--

CREATE INDEX idx_tournament_points_player ON padel_circuit.tournament_points USING btree (player_dni);


--
-- Name: idx_tournament_points_tournament_category; Type: INDEX; Schema: padel_circuit; Owner: postgres
--

CREATE INDEX idx_tournament_points_tournament_category ON padel_circuit.tournament_points USING btree (tournament_category_id);


--
-- Name: registrations_tournament_category_id_team_id; Type: INDEX; Schema: padel_circuit; Owner: postgres
--

CREATE UNIQUE INDEX registrations_tournament_category_id_team_id ON padel_circuit.registrations USING btree (tournament_category_id, team_id);


--
-- Name: tournament_categories_tournament_id_category_id; Type: INDEX; Schema: padel_circuit; Owner: postgres
--

CREATE UNIQUE INDEX tournament_categories_tournament_id_category_id ON padel_circuit.tournament_categories USING btree (tournament_id, category_id);


--
-- Name: unique_team_pair; Type: INDEX; Schema: padel_circuit; Owner: postgres
--

CREATE UNIQUE INDEX unique_team_pair ON padel_circuit.teams USING btree (LEAST(player1_dni, player2_dni), GREATEST(player1_dni, player2_dni));


--
-- Name: zone_standings_zone_id_team_id; Type: INDEX; Schema: padel_circuit; Owner: postgres
--

CREATE UNIQUE INDEX zone_standings_zone_id_team_id ON padel_circuit.zone_standings USING btree (zone_id, team_id);


--
-- Name: zone_teams_zone_id_team_id; Type: INDEX; Schema: padel_circuit; Owner: postgres
--

CREATE UNIQUE INDEX zone_teams_zone_id_team_id ON padel_circuit.zone_teams USING btree (zone_id, team_id);


--
-- Name: brackets brackets_tournament_category_id_fkey; Type: FK CONSTRAINT; Schema: padel_circuit; Owner: postgres
--

ALTER TABLE ONLY padel_circuit.brackets
    ADD CONSTRAINT brackets_tournament_category_id_fkey FOREIGN KEY (tournament_category_id) REFERENCES padel_circuit.tournament_categories(id) ON UPDATE CASCADE;


--
-- Name: matches matches_bracket_id_fkey; Type: FK CONSTRAINT; Schema: padel_circuit; Owner: postgres
--

ALTER TABLE ONLY padel_circuit.matches
    ADD CONSTRAINT matches_bracket_id_fkey FOREIGN KEY (bracket_id) REFERENCES padel_circuit.brackets(id) ON UPDATE CASCADE;


--
-- Name: matches matches_next_match_id_fkey; Type: FK CONSTRAINT; Schema: padel_circuit; Owner: postgres
--

ALTER TABLE ONLY padel_circuit.matches
    ADD CONSTRAINT matches_next_match_id_fkey FOREIGN KEY (next_match_id) REFERENCES padel_circuit.matches(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: matches matches_team_away_id_fkey; Type: FK CONSTRAINT; Schema: padel_circuit; Owner: postgres
--

ALTER TABLE ONLY padel_circuit.matches
    ADD CONSTRAINT matches_team_away_id_fkey FOREIGN KEY (team_away_id) REFERENCES padel_circuit.teams(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: matches matches_team_home_id_fkey; Type: FK CONSTRAINT; Schema: padel_circuit; Owner: postgres
--

ALTER TABLE ONLY padel_circuit.matches
    ADD CONSTRAINT matches_team_home_id_fkey FOREIGN KEY (team_home_id) REFERENCES padel_circuit.teams(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: matches matches_winner_team_id_fkey; Type: FK CONSTRAINT; Schema: padel_circuit; Owner: postgres
--

ALTER TABLE ONLY padel_circuit.matches
    ADD CONSTRAINT matches_winner_team_id_fkey FOREIGN KEY (winner_team_id) REFERENCES padel_circuit.teams(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: player_profiles player_profiles_categoria_base_id_fkey; Type: FK CONSTRAINT; Schema: padel_circuit; Owner: postgres
--

ALTER TABLE ONLY padel_circuit.player_profiles
    ADD CONSTRAINT player_profiles_categoria_base_id_fkey FOREIGN KEY (categoria_base_id) REFERENCES padel_circuit.categories(id) ON UPDATE CASCADE;


--
-- Name: registrations registrations_team_id_fkey; Type: FK CONSTRAINT; Schema: padel_circuit; Owner: postgres
--

ALTER TABLE ONLY padel_circuit.registrations
    ADD CONSTRAINT registrations_team_id_fkey FOREIGN KEY (team_id) REFERENCES padel_circuit.teams(id) ON UPDATE CASCADE;


--
-- Name: registrations registrations_tournament_category_id_fkey; Type: FK CONSTRAINT; Schema: padel_circuit; Owner: postgres
--

ALTER TABLE ONLY padel_circuit.registrations
    ADD CONSTRAINT registrations_tournament_category_id_fkey FOREIGN KEY (tournament_category_id) REFERENCES padel_circuit.tournament_categories(id) ON UPDATE CASCADE;


--
-- Name: teams teams_player1_dni_fkey; Type: FK CONSTRAINT; Schema: padel_circuit; Owner: postgres
--

ALTER TABLE ONLY padel_circuit.teams
    ADD CONSTRAINT teams_player1_dni_fkey FOREIGN KEY (player1_dni) REFERENCES padel_circuit.player_profiles(dni) ON UPDATE CASCADE;


--
-- Name: teams teams_player2_dni_fkey; Type: FK CONSTRAINT; Schema: padel_circuit; Owner: postgres
--

ALTER TABLE ONLY padel_circuit.teams
    ADD CONSTRAINT teams_player2_dni_fkey FOREIGN KEY (player2_dni) REFERENCES padel_circuit.player_profiles(dni) ON UPDATE CASCADE;


--
-- Name: tournament_categories tournament_categories_category_id_fkey; Type: FK CONSTRAINT; Schema: padel_circuit; Owner: postgres
--

ALTER TABLE ONLY padel_circuit.tournament_categories
    ADD CONSTRAINT tournament_categories_category_id_fkey FOREIGN KEY (category_id) REFERENCES padel_circuit.categories(id) ON UPDATE CASCADE;


--
-- Name: tournament_categories tournament_categories_tournament_id_fkey; Type: FK CONSTRAINT; Schema: padel_circuit; Owner: postgres
--

ALTER TABLE ONLY padel_circuit.tournament_categories
    ADD CONSTRAINT tournament_categories_tournament_id_fkey FOREIGN KEY (tournament_id) REFERENCES padel_circuit.tournaments(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: tournament_points tournament_points_player_dni_fkey; Type: FK CONSTRAINT; Schema: padel_circuit; Owner: postgres
--

ALTER TABLE ONLY padel_circuit.tournament_points
    ADD CONSTRAINT tournament_points_player_dni_fkey FOREIGN KEY (player_dni) REFERENCES padel_circuit.player_profiles(dni) ON DELETE CASCADE;


--
-- Name: tournament_points tournament_points_team_id_fkey; Type: FK CONSTRAINT; Schema: padel_circuit; Owner: postgres
--

ALTER TABLE ONLY padel_circuit.tournament_points
    ADD CONSTRAINT tournament_points_team_id_fkey FOREIGN KEY (team_id) REFERENCES padel_circuit.teams(id) ON DELETE CASCADE;


--
-- Name: tournament_points tournament_points_tournament_category_id_fkey; Type: FK CONSTRAINT; Schema: padel_circuit; Owner: postgres
--

ALTER TABLE ONLY padel_circuit.tournament_points
    ADD CONSTRAINT tournament_points_tournament_category_id_fkey FOREIGN KEY (tournament_category_id) REFERENCES padel_circuit.tournament_categories(id) ON DELETE CASCADE;


--
-- Name: zone_matches zone_matches_team_away_id_fkey; Type: FK CONSTRAINT; Schema: padel_circuit; Owner: postgres
--

ALTER TABLE ONLY padel_circuit.zone_matches
    ADD CONSTRAINT zone_matches_team_away_id_fkey FOREIGN KEY (team_away_id) REFERENCES padel_circuit.teams(id) ON UPDATE CASCADE;


--
-- Name: zone_matches zone_matches_team_home_id_fkey; Type: FK CONSTRAINT; Schema: padel_circuit; Owner: postgres
--

ALTER TABLE ONLY padel_circuit.zone_matches
    ADD CONSTRAINT zone_matches_team_home_id_fkey FOREIGN KEY (team_home_id) REFERENCES padel_circuit.teams(id) ON UPDATE CASCADE;


--
-- Name: zone_matches zone_matches_winner_team_id_fkey; Type: FK CONSTRAINT; Schema: padel_circuit; Owner: postgres
--

ALTER TABLE ONLY padel_circuit.zone_matches
    ADD CONSTRAINT zone_matches_winner_team_id_fkey FOREIGN KEY (winner_team_id) REFERENCES padel_circuit.teams(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: zone_matches zone_matches_zone_id_fkey; Type: FK CONSTRAINT; Schema: padel_circuit; Owner: postgres
--

ALTER TABLE ONLY padel_circuit.zone_matches
    ADD CONSTRAINT zone_matches_zone_id_fkey FOREIGN KEY (zone_id) REFERENCES padel_circuit.zones(id) ON UPDATE CASCADE;


--
-- Name: zone_standings zone_standings_team_id_fkey; Type: FK CONSTRAINT; Schema: padel_circuit; Owner: postgres
--

ALTER TABLE ONLY padel_circuit.zone_standings
    ADD CONSTRAINT zone_standings_team_id_fkey FOREIGN KEY (team_id) REFERENCES padel_circuit.teams(id) ON UPDATE CASCADE;


--
-- Name: zone_standings zone_standings_zone_id_fkey; Type: FK CONSTRAINT; Schema: padel_circuit; Owner: postgres
--

ALTER TABLE ONLY padel_circuit.zone_standings
    ADD CONSTRAINT zone_standings_zone_id_fkey FOREIGN KEY (zone_id) REFERENCES padel_circuit.zones(id) ON UPDATE CASCADE;


--
-- Name: zone_teams zone_teams_team_id_fkey; Type: FK CONSTRAINT; Schema: padel_circuit; Owner: postgres
--

ALTER TABLE ONLY padel_circuit.zone_teams
    ADD CONSTRAINT zone_teams_team_id_fkey FOREIGN KEY (team_id) REFERENCES padel_circuit.teams(id) ON UPDATE CASCADE;


--
-- Name: zone_teams zone_teams_zone_id_fkey; Type: FK CONSTRAINT; Schema: padel_circuit; Owner: postgres
--

ALTER TABLE ONLY padel_circuit.zone_teams
    ADD CONSTRAINT zone_teams_zone_id_fkey FOREIGN KEY (zone_id) REFERENCES padel_circuit.zones(id) ON UPDATE CASCADE;


--
-- Name: zones zones_tournament_category_id_fkey; Type: FK CONSTRAINT; Schema: padel_circuit; Owner: postgres
--

ALTER TABLE ONLY padel_circuit.zones
    ADD CONSTRAINT zones_tournament_category_id_fkey FOREIGN KEY (tournament_category_id) REFERENCES padel_circuit.tournament_categories(id) ON UPDATE CASCADE;


--
-- PostgreSQL database dump complete
--

\unrestrict RQcePfqgKXfy8VcOOo8SpEOGHda12GKYF2kFhLoAvwJJFbsWAV10SfN9ZLkXPaU


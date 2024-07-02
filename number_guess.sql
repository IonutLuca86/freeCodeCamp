--
-- PostgreSQL database dump
--

-- Dumped from database version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)
-- Dumped by pg_dump version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)

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

DROP DATABASE number_guess;
--
-- Name: number_guess; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE number_guess WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE number_guess OWNER TO freecodecamp;

\connect number_guess

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: games; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.games (
    game_id integer NOT NULL,
    player_id integer,
    guesses integer NOT NULL
);


ALTER TABLE public.games OWNER TO freecodecamp;

--
-- Name: games_game_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.games_game_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.games_game_id_seq OWNER TO freecodecamp;

--
-- Name: games_game_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.games_game_id_seq OWNED BY public.games.game_id;


--
-- Name: players; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.players (
    player_id integer NOT NULL,
    player_name character varying(22) NOT NULL,
    games_played integer DEFAULT 0,
    best_game integer
);


ALTER TABLE public.players OWNER TO freecodecamp;

--
-- Name: players_player_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.players_player_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.players_player_id_seq OWNER TO freecodecamp;

--
-- Name: players_player_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.players_player_id_seq OWNED BY public.players.player_id;


--
-- Name: games game_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.games ALTER COLUMN game_id SET DEFAULT nextval('public.games_game_id_seq'::regclass);


--
-- Name: players player_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.players ALTER COLUMN player_id SET DEFAULT nextval('public.players_player_id_seq'::regclass);


--
-- Data for Name: games; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.games VALUES (1, 1, 9);
INSERT INTO public.games VALUES (2, 6, 12);
INSERT INTO public.games VALUES (3, 7, 710);
INSERT INTO public.games VALUES (4, 7, 545);
INSERT INTO public.games VALUES (5, 8, 305);
INSERT INTO public.games VALUES (6, 8, 130);
INSERT INTO public.games VALUES (7, 7, 667);
INSERT INTO public.games VALUES (8, 7, 727);
INSERT INTO public.games VALUES (9, 7, 706);
INSERT INTO public.games VALUES (10, 9, 555);
INSERT INTO public.games VALUES (11, 9, 66);
INSERT INTO public.games VALUES (12, 10, 109);
INSERT INTO public.games VALUES (13, 10, 202);
INSERT INTO public.games VALUES (14, 9, 433);
INSERT INTO public.games VALUES (15, 9, 554);
INSERT INTO public.games VALUES (16, 9, 570);
INSERT INTO public.games VALUES (17, 11, 999);
INSERT INTO public.games VALUES (18, 11, 695);
INSERT INTO public.games VALUES (19, 12, 326);
INSERT INTO public.games VALUES (20, 12, 181);
INSERT INTO public.games VALUES (21, 11, 441);
INSERT INTO public.games VALUES (22, 11, 245);
INSERT INTO public.games VALUES (23, 11, 200);


--
-- Data for Name: players; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.players VALUES (2, 'user_1719908112875', 0, NULL);
INSERT INTO public.players VALUES (3, 'user_1719908112874', 0, NULL);
INSERT INTO public.players VALUES (4, 'user_1719908663960', 0, NULL);
INSERT INTO public.players VALUES (5, 'user_1719908663959', 0, NULL);
INSERT INTO public.players VALUES (1, 'luca', 1, 9);
INSERT INTO public.players VALUES (6, 'second_player', 1, 12);
INSERT INTO public.players VALUES (8, 'user_1719910252181', 2, 130);
INSERT INTO public.players VALUES (7, 'user_1719910252182', 5, 545);
INSERT INTO public.players VALUES (10, 'user_1719910293943', 2, 109);
INSERT INTO public.players VALUES (9, 'user_1719910293944', 5, 66);
INSERT INTO public.players VALUES (12, 'user_1719910331556', 2, 181);
INSERT INTO public.players VALUES (11, 'user_1719910331557', 5, 200);


--
-- Name: games_game_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.games_game_id_seq', 23, true);


--
-- Name: players_player_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.players_player_id_seq', 12, true);


--
-- Name: games games_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_pkey PRIMARY KEY (game_id);


--
-- Name: players players_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.players
    ADD CONSTRAINT players_pkey PRIMARY KEY (player_id);


--
-- Name: players players_player_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.players
    ADD CONSTRAINT players_player_name_key UNIQUE (player_name);


--
-- Name: games games_player_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_player_id_fkey FOREIGN KEY (player_id) REFERENCES public.players(player_id);


--
-- PostgreSQL database dump complete
--


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

DROP DATABASE universe;
--
-- Name: universe; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE universe WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE universe OWNER TO freecodecamp;

\connect universe

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
-- Name: galaxy; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.galaxy (
    galaxy_id integer NOT NULL,
    name character varying(255) NOT NULL,
    description text NOT NULL,
    has_life boolean,
    distance_from_earth numeric,
    age_in_millions_of_years integer,
    number_of_stars integer
);


ALTER TABLE public.galaxy OWNER TO freecodecamp;

--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.galaxy_galaxy_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.galaxy_galaxy_id_seq OWNER TO freecodecamp;

--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.galaxy_galaxy_id_seq OWNED BY public.galaxy.galaxy_id;


--
-- Name: moon; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.moon (
    moon_id integer NOT NULL,
    name character varying(255) NOT NULL,
    description text NOT NULL,
    planet_id integer NOT NULL,
    age_in_millions_of_years integer,
    orbital_period integer
);


ALTER TABLE public.moon OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.moon_moon_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.moon_moon_id_seq OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.moon_moon_id_seq OWNED BY public.moon.moon_id;


--
-- Name: planet; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.planet (
    planet_id integer NOT NULL,
    name character varying(255) NOT NULL,
    description text NOT NULL,
    star_id integer NOT NULL,
    has_life boolean,
    is_spherical boolean,
    age_in_millions_of_years integer,
    orbital_period integer
);


ALTER TABLE public.planet OWNER TO freecodecamp;

--
-- Name: planet_planet_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.planet_planet_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.planet_planet_id_seq OWNER TO freecodecamp;

--
-- Name: planet_planet_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.planet_planet_id_seq OWNED BY public.planet.planet_id;


--
-- Name: spacecraft; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.spacecraft (
    spacecraft_id integer NOT NULL,
    name character varying(255) NOT NULL,
    mission_type character varying(50),
    mission_duration integer,
    mission_success boolean,
    crew_size integer NOT NULL,
    launch_year integer NOT NULL,
    mission_cost integer
);


ALTER TABLE public.spacecraft OWNER TO freecodecamp;

--
-- Name: spacecraft_spacecraft_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.spacecraft_spacecraft_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.spacecraft_spacecraft_id_seq OWNER TO freecodecamp;

--
-- Name: spacecraft_spacecraft_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.spacecraft_spacecraft_id_seq OWNED BY public.spacecraft.spacecraft_id;


--
-- Name: star; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.star (
    star_id integer NOT NULL,
    name character varying(255) NOT NULL,
    description text NOT NULL,
    galaxy_id integer NOT NULL,
    is_spherical boolean NOT NULL,
    age_in_millions_of_years integer,
    distance_from_earth numeric,
    temperature integer
);


ALTER TABLE public.star OWNER TO freecodecamp;

--
-- Name: star_star_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.star_star_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.star_star_id_seq OWNER TO freecodecamp;

--
-- Name: star_star_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.star_star_id_seq OWNED BY public.star.star_id;


--
-- Name: galaxy galaxy_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy ALTER COLUMN galaxy_id SET DEFAULT nextval('public.galaxy_galaxy_id_seq'::regclass);


--
-- Name: moon moon_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon ALTER COLUMN moon_id SET DEFAULT nextval('public.moon_moon_id_seq'::regclass);


--
-- Name: planet planet_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet ALTER COLUMN planet_id SET DEFAULT nextval('public.planet_planet_id_seq'::regclass);


--
-- Name: spacecraft spacecraft_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.spacecraft ALTER COLUMN spacecraft_id SET DEFAULT nextval('public.spacecraft_spacecraft_id_seq'::regclass);


--
-- Name: star star_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star ALTER COLUMN star_id SET DEFAULT nextval('public.star_star_id_seq'::regclass);


--
-- Data for Name: galaxy; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.galaxy VALUES (1, 'Milky Way', 'Our galaxy, contains our Solar System', true, 0.0, 13600, 100000000);
INSERT INTO public.galaxy VALUES (2, 'Andromeda', 'The nearest major galaxy to the Milky Way', false, 2537000.0, 10000, 1000000000);
INSERT INTO public.galaxy VALUES (3, 'Triangulum', 'A member of the Local Group of galaxies', false, 3000000.0, 23000, 40000000);
INSERT INTO public.galaxy VALUES (4, 'Whirlpool', 'A classic spiral galaxy in the constellation Canes Venatici', false, 23000000.0, 40000, 160000000);
INSERT INTO public.galaxy VALUES (5, 'Sombrero', 'A bright galaxy in the constellation Virgo', false, 29000000.0, 10000, 800000000);
INSERT INTO public.galaxy VALUES (6, 'Pinwheel', 'A face-on spiral galaxy located in the constellation Ursa Major', false, 21000000.0, 7000, 1000000000);


--
-- Data for Name: moon; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.moon VALUES (1, 'Moon', 'The only natural satellite of Earth', 1, 4500, 27);
INSERT INTO public.moon VALUES (2, 'Phobos', 'The larger and closer of the two natural satellites of Mars', 2, 4500, 0);
INSERT INTO public.moon VALUES (3, 'Deimos', 'The smaller and farther of the two natural satellites of Mars', 2, 4500, 1);
INSERT INTO public.moon VALUES (4, 'Io', 'The innermost of the four Galilean moons of Jupiter', 3, 4500, 2);
INSERT INTO public.moon VALUES (5, 'Europa', 'The smallest of the four Galilean moons of Jupiter', 3, 4500, 4);
INSERT INTO public.moon VALUES (6, 'Ganymede', 'The largest and most massive of the moons of Jupiter', 3, 4500, 7);
INSERT INTO public.moon VALUES (7, 'Callisto', 'The second-largest moon of Jupiter and the third-largest moon in the Solar System', 3, 4500, 17);
INSERT INTO public.moon VALUES (8, 'Titan', 'The largest moon of Saturn and the second-largest natural satellite in the Solar System', 4, 4500, 16);
INSERT INTO public.moon VALUES (9, 'Rhea', 'The second-largest moon of Saturn', 4, 4500, 5);
INSERT INTO public.moon VALUES (10, 'Iapetus', 'The third-largest natural satellite of Saturn', 4, 4500, 79);
INSERT INTO public.moon VALUES (11, 'Dione', 'A moon of Saturn discovered by Giovanni Cassini in 1684', 4, 4500, 3);
INSERT INTO public.moon VALUES (12, 'Tethys', 'A mid-sized moon of Saturn', 4, 4500, 2);
INSERT INTO public.moon VALUES (13, 'Enceladus', 'The sixth-largest moon of Saturn', 4, 4500, 1);
INSERT INTO public.moon VALUES (14, 'Miranda', 'The smallest and innermost of Uranus five round satellites', 8, 4500, 1);
INSERT INTO public.moon VALUES (15, 'Ariel', 'The fourth-largest of the moons of Uranus', 8, 4500, 3);
INSERT INTO public.moon VALUES (16, 'Umbriel', 'The third-largest and most massive of the Uranian moons', 8, 4500, 4);
INSERT INTO public.moon VALUES (17, 'Titania', 'The largest of the moons of Uranus', 8, 4500, 9);
INSERT INTO public.moon VALUES (18, 'Oberon', 'The second-largest and second-most massive of Uranus moons', 8, 4500, 13);
INSERT INTO public.moon VALUES (19, 'Triton', 'The largest natural satellite of Neptune', 7, 4500, 6);
INSERT INTO public.moon VALUES (20, 'Charon', 'The largest of the five known moons of the dwarf planet Pluto', 9, 4500, 6);


--
-- Data for Name: planet; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.planet VALUES (1, 'Earth', 'The third planet from the Sun and the only astronomical object known to harbor life', 1, true, true, 4500, 365);
INSERT INTO public.planet VALUES (2, 'Mars', 'The fourth planet from the Sun, known as the Red Planet', 1, false, true, 4500, 687);
INSERT INTO public.planet VALUES (3, 'Jupiter', 'The fifth planet from the Sun and the largest in the Solar System', 1, false, true, 4500, 4333);
INSERT INTO public.planet VALUES (4, 'Saturn', 'The sixth planet from the Sun, known for its prominent ring system', 1, false, true, 4500, 10759);
INSERT INTO public.planet VALUES (5, 'Venus', 'The second planet from the Sun, similar in size to Earth', 1, false, true, 4500, 225);
INSERT INTO public.planet VALUES (6, 'Mercury', 'The closest planet to the Sun and the smallest in the Solar System', 1, false, true, 4500, 88);
INSERT INTO public.planet VALUES (7, 'Neptune', 'The eighth and farthest-known planet from the Sun in the Solar System', 1, false, true, 4500, 60190);
INSERT INTO public.planet VALUES (8, 'Uranus', 'The seventh planet from the Sun, has a blue-green color due to methane', 1, false, true, 4500, 30688);
INSERT INTO public.planet VALUES (9, 'Proxima Centauri b', 'An exoplanet orbiting within the habitable zone of the red dwarf star Proxima Centauri', 6, false, true, 4500, 11);
INSERT INTO public.planet VALUES (10, 'Alpha Centauri Bb', 'An exoplanet orbiting the star Alpha Centauri B', 3, false, true, 4500, 3);
INSERT INTO public.planet VALUES (11, 'Sirius B', 'A white dwarf star companion to the main-sequence star Sirius', 2, false, true, 12000, 50);
INSERT INTO public.planet VALUES (12, 'Betelgeuse b', 'A hypothetical planet orbiting the red supergiant star Betelgeuse', 4, false, true, 10000, 3650);


--
-- Data for Name: spacecraft; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.spacecraft VALUES (1, 'Apollo 11', 'Moon landing', 8, true, 3, 1969, 3550000);
INSERT INTO public.spacecraft VALUES (2, 'Voyager 1', 'Space probe', 44, true, 0, 1977, 2500000);
INSERT INTO public.spacecraft VALUES (3, 'Curiosity', 'Mars rover', 9, true, 6, 2011, 25000000);
INSERT INTO public.spacecraft VALUES (4, 'Cassini', 'Saturn orbiter and probe', 20, true, 13, 1997, 35000000);
INSERT INTO public.spacecraft VALUES (5, 'New Horizons', 'Pluto flyby', 15, true, 6, 2006, 7200000);
INSERT INTO public.spacecraft VALUES (6, 'Hubble Space Telescope', 'Space telescope', 32, true, 0, 1990, 25000000);
INSERT INTO public.spacecraft VALUES (7, 'Change 4', 'Lunar rover', 1, true, 0, 2018, 3000000);
INSERT INTO public.spacecraft VALUES (8, 'Opportunity', 'Mars rover', 15, false, 0, 2003, 4000000);
INSERT INTO public.spacecraft VALUES (9, 'Pioneer 10', 'Space probe', 30, true, 0, 1972, 2500000);
INSERT INTO public.spacecraft VALUES (10, 'SpaceX Dragon', 'Cargo spacecraft', 30, true, 0, 2010, 5000000);


--
-- Data for Name: star; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.star VALUES (1, 'Sun', 'The star at the center of our Solar System', 1, true, 4600, 0.0, 5778);
INSERT INTO public.star VALUES (2, 'Sirius', 'The brightest star in the night sky', 1, true, 242, 8.6, 9940);
INSERT INTO public.star VALUES (3, 'Alpha Centauri A', 'The closest star system to the Solar System', 1, true, 5000, 4.37, 5790);
INSERT INTO public.star VALUES (4, 'Betelgeuse', 'A red supergiant star in the Orion constellation', 1, true, 10000, 642.5, 3500);
INSERT INTO public.star VALUES (5, 'Rigel', 'A blue supergiant star in the Orion constellation', 1, true, 8000, 860, 12100);
INSERT INTO public.star VALUES (6, 'Proxima Centauri', 'The closest known star to the Sun', 1, true, 5000, 4.24, 3042);


--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.galaxy_galaxy_id_seq', 6, true);


--
-- Name: moon_moon_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.moon_moon_id_seq', 20, true);


--
-- Name: planet_planet_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.planet_planet_id_seq', 12, true);


--
-- Name: spacecraft_spacecraft_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.spacecraft_spacecraft_id_seq', 10, true);


--
-- Name: star_star_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.star_star_id_seq', 6, true);


--
-- Name: galaxy galaxy_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_name_key UNIQUE (name);


--
-- Name: galaxy galaxy_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_pkey PRIMARY KEY (galaxy_id);


--
-- Name: moon moon_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_name_key UNIQUE (name);


--
-- Name: moon moon_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_pkey PRIMARY KEY (moon_id);


--
-- Name: planet planet_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_name_key UNIQUE (name);


--
-- Name: planet planet_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_pkey PRIMARY KEY (planet_id);


--
-- Name: spacecraft spacecraft_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.spacecraft
    ADD CONSTRAINT spacecraft_name_key UNIQUE (name);


--
-- Name: spacecraft spacecraft_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.spacecraft
    ADD CONSTRAINT spacecraft_pkey PRIMARY KEY (spacecraft_id);


--
-- Name: star star_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_name_key UNIQUE (name);


--
-- Name: star star_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_pkey PRIMARY KEY (star_id);


--
-- Name: moon moon_planet_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_planet_id_fkey FOREIGN KEY (planet_id) REFERENCES public.planet(planet_id);


--
-- Name: planet planet_star_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_star_id_fkey FOREIGN KEY (star_id) REFERENCES public.star(star_id);


--
-- Name: star star_galaxy_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_galaxy_id_fkey FOREIGN KEY (galaxy_id) REFERENCES public.galaxy(galaxy_id);


--
-- PostgreSQL database dump complete
--


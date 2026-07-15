--
-- PostgreSQL database dump
--

\restrict BKmDv6qtur7MEn0ABkKfqo8NuGjzKQoiDDNaEcwqeFKZDgfk3PSVELvGUfA2dAO

-- Dumped from database version 18.4 (Ubuntu 18.4-0ubuntu0.26.04.1)
-- Dumped by pg_dump version 18.4 (Ubuntu 18.4-0ubuntu0.26.04.1)

-- Started on 2026-07-15 16:39:04 -04

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

--
-- TOC entry 7 (class 2615 OID 17575)
-- Name: film; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA film;


ALTER SCHEMA film OWNER TO postgres;

--
-- TOC entry 6 (class 2615 OID 17417)
-- Name: security; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA security;


ALTER SCHEMA security OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 235 (class 1259 OID 17576)
-- Name: rating; Type: TABLE; Schema: film; Owner: postgres
--

CREATE TABLE film.rating (
    fk_users_name character varying(50) CONSTRAINT rating_fk_users_id_not_null NOT NULL,
    fk_anime_id integer NOT NULL,
    rating_score integer NOT NULL,
    rating_comment text
);


ALTER TABLE film.rating OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 17617)
-- Name: status; Type: TABLE; Schema: film; Owner: postgres
--

CREATE TABLE film.status (
    fk_users_name character varying(50) NOT NULL,
    fk_anime_id integer NOT NULL,
    status_status integer NOT NULL
);


ALTER TABLE film.status OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 17418)
-- Name: component; Type: TABLE; Schema: security; Owner: postgres
--

CREATE TABLE security.component (
    component_id integer NOT NULL,
    component_name character varying NOT NULL
);


ALTER TABLE security.component OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 17425)
-- Name: component_component_id_seq; Type: SEQUENCE; Schema: security; Owner: postgres
--

CREATE SEQUENCE security.component_component_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE security.component_component_id_seq OWNER TO postgres;

--
-- TOC entry 3612 (class 0 OID 0)
-- Dependencies: 222
-- Name: component_component_id_seq; Type: SEQUENCE OWNED BY; Schema: security; Owner: postgres
--

ALTER SEQUENCE security.component_component_id_seq OWNED BY security.component.component_id;


--
-- TOC entry 223 (class 1259 OID 17426)
-- Name: method; Type: TABLE; Schema: security; Owner: postgres
--

CREATE TABLE security.method (
    method_id integer NOT NULL,
    method_name character varying NOT NULL,
    fk_object_id integer NOT NULL
);


ALTER TABLE security.method OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 17434)
-- Name: method_method_id_seq; Type: SEQUENCE; Schema: security; Owner: postgres
--

CREATE SEQUENCE security.method_method_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE security.method_method_id_seq OWNER TO postgres;

--
-- TOC entry 3613 (class 0 OID 0)
-- Dependencies: 224
-- Name: method_method_id_seq; Type: SEQUENCE OWNED BY; Schema: security; Owner: postgres
--

ALTER SEQUENCE security.method_method_id_seq OWNED BY security.method.method_id;


--
-- TOC entry 225 (class 1259 OID 17435)
-- Name: method_permission; Type: TABLE; Schema: security; Owner: postgres
--

CREATE TABLE security.method_permission (
    fk_profile_id integer NOT NULL,
    fk_transaction_id integer NOT NULL
);


ALTER TABLE security.method_permission OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 17440)
-- Name: object; Type: TABLE; Schema: security; Owner: postgres
--

CREATE TABLE security.object (
    object_id integer NOT NULL,
    object_name character varying NOT NULL
);


ALTER TABLE security.object OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 17447)
-- Name: object_object_id_seq; Type: SEQUENCE; Schema: security; Owner: postgres
--

CREATE SEQUENCE security.object_object_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE security.object_object_id_seq OWNER TO postgres;

--
-- TOC entry 3614 (class 0 OID 0)
-- Dependencies: 227
-- Name: object_object_id_seq; Type: SEQUENCE OWNED BY; Schema: security; Owner: postgres
--

ALTER SEQUENCE security.object_object_id_seq OWNED BY security.object.object_id;


--
-- TOC entry 228 (class 1259 OID 17448)
-- Name: option; Type: TABLE; Schema: security; Owner: postgres
--

CREATE TABLE security.option (
    option_id integer NOT NULL,
    option_name character varying NOT NULL,
    fk_component_id integer NOT NULL,
    option_function character varying NOT NULL,
    option_params character varying[] NOT NULL,
    option_async boolean NOT NULL,
    option_generic boolean NOT NULL
);


ALTER TABLE security.option OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 17460)
-- Name: option_option_id_seq; Type: SEQUENCE; Schema: security; Owner: postgres
--

CREATE SEQUENCE security.option_option_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE security.option_option_id_seq OWNER TO postgres;

--
-- TOC entry 3615 (class 0 OID 0)
-- Dependencies: 229
-- Name: option_option_id_seq; Type: SEQUENCE OWNED BY; Schema: security; Owner: postgres
--

ALTER SEQUENCE security.option_option_id_seq OWNED BY security.option.option_id;


--
-- TOC entry 230 (class 1259 OID 17461)
-- Name: option_permission; Type: TABLE; Schema: security; Owner: postgres
--

CREATE TABLE security.option_permission (
    fk_profile_id integer NOT NULL,
    fk_option_id integer NOT NULL
);


ALTER TABLE security.option_permission OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 17466)
-- Name: profile; Type: TABLE; Schema: security; Owner: postgres
--

CREATE TABLE security.profile (
    profile_name character varying(40) NOT NULL,
    profile_id integer NOT NULL
);


ALTER TABLE security.profile OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 17471)
-- Name: profiles_0_profile_id_seq; Type: SEQUENCE; Schema: security; Owner: postgres
--

CREATE SEQUENCE security.profiles_0_profile_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE security.profiles_0_profile_id_seq OWNER TO postgres;

--
-- TOC entry 3616 (class 0 OID 0)
-- Dependencies: 232
-- Name: profiles_0_profile_id_seq; Type: SEQUENCE OWNED BY; Schema: security; Owner: postgres
--

ALTER SEQUENCE security.profiles_0_profile_id_seq OWNED BY security.profile.profile_id;


--
-- TOC entry 233 (class 1259 OID 17472)
-- Name: transaction; Type: TABLE; Schema: security; Owner: postgres
--

CREATE TABLE security.transaction (
    fk_method_id integer NOT NULL,
    transaction_id integer NOT NULL
);


ALTER TABLE security.transaction OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 17477)
-- Name: users; Type: TABLE; Schema: security; Owner: postgres
--

CREATE TABLE security.users (
    users_name character varying(50) NOT NULL,
    users_password character varying(30) NOT NULL,
    fk_profile_id integer NOT NULL,
    users_email character varying NOT NULL
);


ALTER TABLE security.users OWNER TO postgres;

--
-- TOC entry 3408 (class 2604 OID 17486)
-- Name: component component_id; Type: DEFAULT; Schema: security; Owner: postgres
--

ALTER TABLE ONLY security.component ALTER COLUMN component_id SET DEFAULT nextval('security.component_component_id_seq'::regclass);


--
-- TOC entry 3409 (class 2604 OID 17487)
-- Name: method method_id; Type: DEFAULT; Schema: security; Owner: postgres
--

ALTER TABLE ONLY security.method ALTER COLUMN method_id SET DEFAULT nextval('security.method_method_id_seq'::regclass);


--
-- TOC entry 3410 (class 2604 OID 17488)
-- Name: object object_id; Type: DEFAULT; Schema: security; Owner: postgres
--

ALTER TABLE ONLY security.object ALTER COLUMN object_id SET DEFAULT nextval('security.object_object_id_seq'::regclass);


--
-- TOC entry 3411 (class 2604 OID 17489)
-- Name: option option_id; Type: DEFAULT; Schema: security; Owner: postgres
--

ALTER TABLE ONLY security.option ALTER COLUMN option_id SET DEFAULT nextval('security.option_option_id_seq'::regclass);


--
-- TOC entry 3412 (class 2604 OID 17490)
-- Name: profile profile_id; Type: DEFAULT; Schema: security; Owner: postgres
--

ALTER TABLE ONLY security.profile ALTER COLUMN profile_id SET DEFAULT nextval('security.profiles_0_profile_id_seq'::regclass);


--
-- TOC entry 3605 (class 0 OID 17576)
-- Dependencies: 235
-- Data for Name: rating; Type: TABLE DATA; Schema: film; Owner: postgres
--

COPY film.rating (fk_users_name, fk_anime_id, rating_score, rating_comment) FROM stdin;
\.


--
-- TOC entry 3606 (class 0 OID 17617)
-- Dependencies: 236
-- Data for Name: status; Type: TABLE DATA; Schema: film; Owner: postgres
--

COPY film.status (fk_users_name, fk_anime_id, status_status) FROM stdin;
\.


--
-- TOC entry 3591 (class 0 OID 17418)
-- Dependencies: 221
-- Data for Name: component; Type: TABLE DATA; Schema: security; Owner: postgres
--

COPY security.component (component_id, component_name) FROM stdin;
\.


--
-- TOC entry 3593 (class 0 OID 17426)
-- Dependencies: 223
-- Data for Name: method; Type: TABLE DATA; Schema: security; Owner: postgres
--

COPY security.method (method_id, method_name, fk_object_id) FROM stdin;
1	addRating	1
2	getRating	1
3	deleteRating	1
4	updateRating	1
5	search	2
6	getAnimeById	2
7	addStatus	3
8	getStatus	3
9	deleteStatus	3
10	updateStatus	3
\.


--
-- TOC entry 3595 (class 0 OID 17435)
-- Dependencies: 225
-- Data for Name: method_permission; Type: TABLE DATA; Schema: security; Owner: postgres
--

COPY security.method_permission (fk_profile_id, fk_transaction_id) FROM stdin;
1	11
2	11
1	12
2	12
1	13
2	13
1	14
2	14
1	21
2	21
1	22
2	22
1	31
2	31
1	32
2	32
1	33
2	33
1	34
2	34
\.


--
-- TOC entry 3596 (class 0 OID 17440)
-- Dependencies: 226
-- Data for Name: object; Type: TABLE DATA; Schema: security; Owner: postgres
--

COPY security.object (object_id, object_name) FROM stdin;
1	Rating
2	AnimeApi
3	Status
\.


--
-- TOC entry 3598 (class 0 OID 17448)
-- Dependencies: 228
-- Data for Name: option; Type: TABLE DATA; Schema: security; Owner: postgres
--

COPY security.option (option_id, option_name, fk_component_id, option_function, option_params, option_async, option_generic) FROM stdin;
\.


--
-- TOC entry 3600 (class 0 OID 17461)
-- Dependencies: 230
-- Data for Name: option_permission; Type: TABLE DATA; Schema: security; Owner: postgres
--

COPY security.option_permission (fk_profile_id, fk_option_id) FROM stdin;
\.


--
-- TOC entry 3601 (class 0 OID 17466)
-- Dependencies: 231
-- Data for Name: profile; Type: TABLE DATA; Schema: security; Owner: postgres
--

COPY security.profile (profile_name, profile_id) FROM stdin;
slave	1
critic	2
\.


--
-- TOC entry 3603 (class 0 OID 17472)
-- Dependencies: 233
-- Data for Name: transaction; Type: TABLE DATA; Schema: security; Owner: postgres
--

COPY security.transaction (fk_method_id, transaction_id) FROM stdin;
1	11
2	12
3	13
4	14
5	21
6	22
7	31
8	32
9	33
10	34
\.


--
-- TOC entry 3604 (class 0 OID 17477)
-- Dependencies: 234
-- Data for Name: users; Type: TABLE DATA; Schema: security; Owner: postgres
--

COPY security.users (users_name, users_password, fk_profile_id, users_email) FROM stdin;
\.


--
-- TOC entry 3617 (class 0 OID 0)
-- Dependencies: 222
-- Name: component_component_id_seq; Type: SEQUENCE SET; Schema: security; Owner: postgres
--

SELECT pg_catalog.setval('security.component_component_id_seq', 1, false);


--
-- TOC entry 3618 (class 0 OID 0)
-- Dependencies: 224
-- Name: method_method_id_seq; Type: SEQUENCE SET; Schema: security; Owner: postgres
--

SELECT pg_catalog.setval('security.method_method_id_seq', 10, true);


--
-- TOC entry 3619 (class 0 OID 0)
-- Dependencies: 227
-- Name: object_object_id_seq; Type: SEQUENCE SET; Schema: security; Owner: postgres
--

SELECT pg_catalog.setval('security.object_object_id_seq', 3, true);


--
-- TOC entry 3620 (class 0 OID 0)
-- Dependencies: 229
-- Name: option_option_id_seq; Type: SEQUENCE SET; Schema: security; Owner: postgres
--

SELECT pg_catalog.setval('security.option_option_id_seq', 1, false);


--
-- TOC entry 3621 (class 0 OID 0)
-- Dependencies: 232
-- Name: profiles_0_profile_id_seq; Type: SEQUENCE SET; Schema: security; Owner: postgres
--

SELECT pg_catalog.setval('security.profiles_0_profile_id_seq', 2, true);


--
-- TOC entry 3432 (class 2606 OID 17585)
-- Name: rating pk_rating; Type: CONSTRAINT; Schema: film; Owner: postgres
--

ALTER TABLE ONLY film.rating
    ADD CONSTRAINT pk_rating PRIMARY KEY (fk_users_name, fk_anime_id);


--
-- TOC entry 3434 (class 2606 OID 17624)
-- Name: status pk_status; Type: CONSTRAINT; Schema: film; Owner: postgres
--

ALTER TABLE ONLY film.status
    ADD CONSTRAINT pk_status PRIMARY KEY (fk_users_name, fk_anime_id);


--
-- TOC entry 3414 (class 2606 OID 17492)
-- Name: component component_pkey; Type: CONSTRAINT; Schema: security; Owner: postgres
--

ALTER TABLE ONLY security.component
    ADD CONSTRAINT component_pkey PRIMARY KEY (component_id);


--
-- TOC entry 3418 (class 2606 OID 17494)
-- Name: method_permission method_permission_pkey; Type: CONSTRAINT; Schema: security; Owner: postgres
--

ALTER TABLE ONLY security.method_permission
    ADD CONSTRAINT method_permission_pkey PRIMARY KEY (fk_profile_id, fk_transaction_id);


--
-- TOC entry 3416 (class 2606 OID 17496)
-- Name: method method_pkey; Type: CONSTRAINT; Schema: security; Owner: postgres
--

ALTER TABLE ONLY security.method
    ADD CONSTRAINT method_pkey PRIMARY KEY (method_id);


--
-- TOC entry 3420 (class 2606 OID 17498)
-- Name: object object_pkey; Type: CONSTRAINT; Schema: security; Owner: postgres
--

ALTER TABLE ONLY security.object
    ADD CONSTRAINT object_pkey PRIMARY KEY (object_id);


--
-- TOC entry 3424 (class 2606 OID 17500)
-- Name: option_permission option_permission_pkey; Type: CONSTRAINT; Schema: security; Owner: postgres
--

ALTER TABLE ONLY security.option_permission
    ADD CONSTRAINT option_permission_pkey PRIMARY KEY (fk_profile_id, fk_option_id);


--
-- TOC entry 3422 (class 2606 OID 17502)
-- Name: option option_pkey; Type: CONSTRAINT; Schema: security; Owner: postgres
--

ALTER TABLE ONLY security.option
    ADD CONSTRAINT option_pkey PRIMARY KEY (option_id);


--
-- TOC entry 3426 (class 2606 OID 17504)
-- Name: profile pk_profiles_0; Type: CONSTRAINT; Schema: security; Owner: postgres
--

ALTER TABLE ONLY security.profile
    ADD CONSTRAINT pk_profiles_0 PRIMARY KEY (profile_id);


--
-- TOC entry 3428 (class 2606 OID 17506)
-- Name: transaction transaction_pkey; Type: CONSTRAINT; Schema: security; Owner: postgres
--

ALTER TABLE ONLY security.transaction
    ADD CONSTRAINT transaction_pkey PRIMARY KEY (transaction_id);


--
-- TOC entry 3430 (class 2606 OID 17508)
-- Name: users username_pkey; Type: CONSTRAINT; Schema: security; Owner: postgres
--

ALTER TABLE ONLY security.users
    ADD CONSTRAINT username_pkey PRIMARY KEY (users_name);


--
-- TOC entry 3443 (class 2606 OID 17586)
-- Name: rating fk_rating_users; Type: FK CONSTRAINT; Schema: film; Owner: postgres
--

ALTER TABLE ONLY film.rating
    ADD CONSTRAINT fk_rating_users FOREIGN KEY (fk_users_name) REFERENCES security.users(users_name);


--
-- TOC entry 3438 (class 2606 OID 17509)
-- Name: option fk_component; Type: FK CONSTRAINT; Schema: security; Owner: postgres
--

ALTER TABLE ONLY security.option
    ADD CONSTRAINT fk_component FOREIGN KEY (fk_component_id) REFERENCES security.component(component_id);


--
-- TOC entry 3435 (class 2606 OID 17514)
-- Name: method fk_method; Type: FK CONSTRAINT; Schema: security; Owner: postgres
--

ALTER TABLE ONLY security.method
    ADD CONSTRAINT fk_method FOREIGN KEY (fk_object_id) REFERENCES security.object(object_id);


--
-- TOC entry 3441 (class 2606 OID 17519)
-- Name: transaction fk_method; Type: FK CONSTRAINT; Schema: security; Owner: postgres
--

ALTER TABLE ONLY security.transaction
    ADD CONSTRAINT fk_method FOREIGN KEY (fk_method_id) REFERENCES security.method(method_id);


--
-- TOC entry 3439 (class 2606 OID 17524)
-- Name: option_permission fk_option; Type: FK CONSTRAINT; Schema: security; Owner: postgres
--

ALTER TABLE ONLY security.option_permission
    ADD CONSTRAINT fk_option FOREIGN KEY (fk_option_id) REFERENCES security.option(option_id);


--
-- TOC entry 3436 (class 2606 OID 17529)
-- Name: method_permission fk_profile; Type: FK CONSTRAINT; Schema: security; Owner: postgres
--

ALTER TABLE ONLY security.method_permission
    ADD CONSTRAINT fk_profile FOREIGN KEY (fk_profile_id) REFERENCES security.profile(profile_id);


--
-- TOC entry 3440 (class 2606 OID 17534)
-- Name: option_permission fk_profile; Type: FK CONSTRAINT; Schema: security; Owner: postgres
--

ALTER TABLE ONLY security.option_permission
    ADD CONSTRAINT fk_profile FOREIGN KEY (fk_profile_id) REFERENCES security.profile(profile_id);


--
-- TOC entry 3442 (class 2606 OID 17539)
-- Name: users fk_profile; Type: FK CONSTRAINT; Schema: security; Owner: postgres
--

ALTER TABLE ONLY security.users
    ADD CONSTRAINT fk_profile FOREIGN KEY (fk_profile_id) REFERENCES security.profile(profile_id);


--
-- TOC entry 3437 (class 2606 OID 17544)
-- Name: method_permission fk_transaction; Type: FK CONSTRAINT; Schema: security; Owner: postgres
--

ALTER TABLE ONLY security.method_permission
    ADD CONSTRAINT fk_transaction FOREIGN KEY (fk_transaction_id) REFERENCES security.transaction(transaction_id);


-- Completed on 2026-07-15 16:39:04 -04

--
-- PostgreSQL database dump complete
--

\unrestrict BKmDv6qtur7MEn0ABkKfqo8NuGjzKQoiDDNaEcwqeFKZDgfk3PSVELvGUfA2dAO


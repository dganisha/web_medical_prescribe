--
-- PostgreSQL database dump
--

-- Dumped from database version 16.4
-- Dumped by pg_dump version 16.0

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
-- Name: activity_logs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.activity_logs (
    id bigint NOT NULL,
    user_id bigint,
    action character varying(255) NOT NULL,
    entity_type character varying(255),
    entity_id bigint,
    description text,
    metadata json,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


--
-- Name: activity_logs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.activity_logs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: activity_logs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.activity_logs_id_seq OWNED BY public.activity_logs.id;


--
-- Name: cache; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.cache (
    key character varying(255) NOT NULL,
    value text NOT NULL,
    expiration integer NOT NULL
);


--
-- Name: cache_locks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.cache_locks (
    key character varying(255) NOT NULL,
    owner character varying(255) NOT NULL,
    expiration integer NOT NULL
);


--
-- Name: checkup_results; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.checkup_results (
    id bigint NOT NULL,
    patient_id integer,
    doctor_id integer,
    apoteker_id integer,
    medicine_id integer,
    checkup_date date NOT NULL,
    diagnosis text,
    tinggi_badan character varying(255) NOT NULL,
    berat_badan character varying(255) NOT NULL,
    sistole character varying(255) NOT NULL,
    diastole character varying(255) NOT NULL,
    heart_rate character varying(255) NOT NULL,
    respiratory_rate character varying(255) NOT NULL,
    temperature character varying(255) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    external_file_path character varying(255),
    visit_id bigint
);


--
-- Name: checkup_results_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.checkup_results_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: checkup_results_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.checkup_results_id_seq OWNED BY public.checkup_results.id;


--
-- Name: failed_jobs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.failed_jobs (
    id bigint NOT NULL,
    uuid character varying(255) NOT NULL,
    connection text NOT NULL,
    queue text NOT NULL,
    payload text NOT NULL,
    exception text NOT NULL,
    failed_at timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: failed_jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.failed_jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: failed_jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.failed_jobs_id_seq OWNED BY public.failed_jobs.id;


--
-- Name: job_batches; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.job_batches (
    id character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    total_jobs integer NOT NULL,
    pending_jobs integer NOT NULL,
    failed_jobs integer NOT NULL,
    failed_job_ids text NOT NULL,
    options text,
    cancelled_at integer,
    created_at integer NOT NULL,
    finished_at integer
);


--
-- Name: jobs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.jobs (
    id bigint NOT NULL,
    queue character varying(255) NOT NULL,
    payload text NOT NULL,
    attempts smallint NOT NULL,
    reserved_at integer,
    available_at integer NOT NULL,
    created_at integer NOT NULL
);


--
-- Name: jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.jobs_id_seq OWNED BY public.jobs.id;


--
-- Name: medicine_prices; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.medicine_prices (
    id bigint NOT NULL,
    medicine_id bigint NOT NULL,
    price numeric(10,2) NOT NULL,
    effective_date date NOT NULL,
    end_date date,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


--
-- Name: medicine_prices_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.medicine_prices_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: medicine_prices_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.medicine_prices_id_seq OWNED BY public.medicine_prices.id;


--
-- Name: medicines; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.medicines (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    medicines_central_id character varying(255) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


--
-- Name: medicines_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.medicines_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: medicines_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.medicines_id_seq OWNED BY public.medicines.id;


--
-- Name: migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.migrations (
    id integer NOT NULL,
    migration character varying(255) NOT NULL,
    batch integer NOT NULL
);


--
-- Name: migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.migrations_id_seq OWNED BY public.migrations.id;


--
-- Name: password_reset_tokens; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.password_reset_tokens (
    email character varying(255) NOT NULL,
    token character varying(255) NOT NULL,
    created_at timestamp(0) without time zone
);


--
-- Name: patient_visits; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.patient_visits (
    id bigint NOT NULL,
    patient_id bigint NOT NULL,
    registered_by bigint,
    handled_doctor_id bigint,
    handled_apoteker_id bigint,
    status character varying(255) DEFAULT 'waiting_doctor'::character varying NOT NULL,
    registered_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


--
-- Name: patient_visits_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.patient_visits_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: patient_visits_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.patient_visits_id_seq OWNED BY public.patient_visits.id;


--
-- Name: patients; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.patients (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    date_of_birth date NOT NULL,
    gender character varying(255) NOT NULL,
    address character varying(255),
    phone_number character varying(255),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


--
-- Name: patients_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.patients_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: patients_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.patients_id_seq OWNED BY public.patients.id;


--
-- Name: prescription_items; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.prescription_items (
    id bigint NOT NULL,
    prescription_id bigint NOT NULL,
    medicine_id bigint NOT NULL,
    dosage character varying(255) NOT NULL,
    frequency character varying(255) NOT NULL,
    duration character varying(255) NOT NULL,
    quantity integer DEFAULT 1 NOT NULL,
    notes text,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


--
-- Name: prescription_items_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.prescription_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: prescription_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.prescription_items_id_seq OWNED BY public.prescription_items.id;


--
-- Name: prescriptions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.prescriptions (
    id bigint NOT NULL,
    checkup_result_id bigint NOT NULL,
    status character varying(255) DEFAULT 'pending'::character varying NOT NULL,
    served_at timestamp(0) without time zone,
    served_by bigint,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


--
-- Name: prescriptions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.prescriptions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: prescriptions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.prescriptions_id_seq OWNED BY public.prescriptions.id;


--
-- Name: roles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.roles (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


--
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;


--
-- Name: sessions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sessions (
    id character varying(255) NOT NULL,
    user_id bigint,
    ip_address character varying(45),
    user_agent text,
    payload text NOT NULL,
    last_activity integer NOT NULL
);


--
-- Name: user_roles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_roles (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    is_nonactive boolean DEFAULT false NOT NULL,
    roles_id bigint,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


--
-- Name: user_roles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.user_roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: user_roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.user_roles_id_seq OWNED BY public.user_roles.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    user_roles_id bigint,
    email_verified_at timestamp(0) without time zone,
    password character varying(255) NOT NULL,
    remember_token character varying(100),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    is_nonactive boolean DEFAULT false NOT NULL
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: activity_logs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.activity_logs ALTER COLUMN id SET DEFAULT nextval('public.activity_logs_id_seq'::regclass);


--
-- Name: checkup_results id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.checkup_results ALTER COLUMN id SET DEFAULT nextval('public.checkup_results_id_seq'::regclass);


--
-- Name: failed_jobs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.failed_jobs ALTER COLUMN id SET DEFAULT nextval('public.failed_jobs_id_seq'::regclass);


--
-- Name: jobs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.jobs ALTER COLUMN id SET DEFAULT nextval('public.jobs_id_seq'::regclass);


--
-- Name: medicine_prices id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.medicine_prices ALTER COLUMN id SET DEFAULT nextval('public.medicine_prices_id_seq'::regclass);


--
-- Name: medicines id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.medicines ALTER COLUMN id SET DEFAULT nextval('public.medicines_id_seq'::regclass);


--
-- Name: migrations id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.migrations ALTER COLUMN id SET DEFAULT nextval('public.migrations_id_seq'::regclass);


--
-- Name: patient_visits id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.patient_visits ALTER COLUMN id SET DEFAULT nextval('public.patient_visits_id_seq'::regclass);


--
-- Name: patients id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.patients ALTER COLUMN id SET DEFAULT nextval('public.patients_id_seq'::regclass);


--
-- Name: prescription_items id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.prescription_items ALTER COLUMN id SET DEFAULT nextval('public.prescription_items_id_seq'::regclass);


--
-- Name: prescriptions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.prescriptions ALTER COLUMN id SET DEFAULT nextval('public.prescriptions_id_seq'::regclass);


--
-- Name: roles id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);


--
-- Name: user_roles id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_roles ALTER COLUMN id SET DEFAULT nextval('public.user_roles_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: activity_logs; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.activity_logs VALUES
	(1, NULL, 'medicines.synchronize', NULL, NULL, 'Medicines synchronized.', '{"medicines":15,"prices":810}', '2026-01-14 07:24:25', '2026-01-14 07:24:25'),
	(2, 4, 'admin.user_created', 'App\Models\User', 5, 'Admin created user.', NULL, '2026-01-14 07:24:54', '2026-01-14 07:24:54'),
	(3, 4, 'auth.logout', NULL, NULL, 'User logged out.', NULL, '2026-01-14 07:25:09', '2026-01-14 07:25:09'),
	(4, 3, 'auth.login', NULL, NULL, 'User logged in.', NULL, '2026-01-14 07:25:20', '2026-01-14 07:25:20'),
	(5, 3, 'registration.visit_created', 'App\Models\PatientVisit', 2, 'Patient registered to visit queue.', NULL, '2026-01-14 07:25:26', '2026-01-14 07:25:26'),
	(6, 3, 'auth.logout', NULL, NULL, 'User logged out.', NULL, '2026-01-14 07:25:34', '2026-01-14 07:25:34'),
	(7, 1, 'auth.login', NULL, NULL, 'User logged in.', NULL, '2026-01-14 07:25:44', '2026-01-14 07:25:44'),
	(8, 1, 'doctor.checkup_created', 'App\Models\CheckupResult', 3, 'Doctor created checkup.', '{"visit_id":2}', '2026-01-14 07:39:08', '2026-01-14 07:39:08'),
	(9, 1, 'auth.logout', NULL, NULL, 'User logged out.', NULL, '2026-01-14 07:39:12', '2026-01-14 07:39:12'),
	(10, 2, 'auth.login', NULL, NULL, 'User logged in.', NULL, '2026-01-14 07:39:23', '2026-01-14 07:39:23'),
	(11, 2, 'pharmacy.receipt_downloaded', 'App\Models\Prescription', 3, 'Receipt downloaded.', NULL, '2026-01-14 07:41:19', '2026-01-14 07:41:19'),
	(12, 2, 'pharmacy.prescription_served', 'App\Models\Prescription', 3, 'Prescription served by pharmacist.', NULL, '2026-01-14 07:41:30', '2026-01-14 07:41:30');


--
-- Data for Name: cache; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: cache_locks; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: checkup_results; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.checkup_results VALUES
	(1, 1, 1, NULL, NULL, '2026-01-13', 'Demam ringan', '170', '65', '120', '80', '72', '18', '37.2', '2026-01-14 06:49:25', '2026-01-14 06:49:25', NULL, NULL),
	(2, 2, 1, 2, NULL, '2026-01-14', 'OK', '183', '90', '33', '33', '86', '0', '34', '2026-01-14 07:15:21', '2026-01-14 07:15:45', NULL, 1),
	(3, 2, 1, 2, NULL, '2026-01-14', 'OK', '183', '90', '0', '0', '88', '0', '34', '2026-01-14 07:39:08', '2026-01-14 07:41:30', NULL, 2);


--
-- Data for Name: failed_jobs; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: job_batches; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: jobs; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: medicine_prices; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.medicine_prices VALUES
	(1, 1, 8000.00, '2026-01-04', NULL, '2026-01-14 06:49:25', '2026-01-14 06:49:25'),
	(2, 2, 12000.00, '2026-01-04', NULL, '2026-01-14 06:49:25', '2026-01-14 06:49:25'),
	(4, 3, 4914.00, '2024-09-14', '2024-09-19', '2026-01-14 07:16:36', '2026-01-14 07:24:18'),
	(5, 3, 5254.00, '2024-09-20', '2024-09-23', '2026-01-14 07:16:36', '2026-01-14 07:24:18'),
	(6, 3, 4901.00, '2024-09-24', '2024-09-27', '2026-01-14 07:16:36', '2026-01-14 07:24:18'),
	(7, 3, 5284.00, '2024-09-28', '2024-10-01', '2026-01-14 07:16:36', '2026-01-14 07:24:18'),
	(8, 3, 5641.00, '2024-10-02', '2024-10-06', '2026-01-14 07:16:36', '2026-01-14 07:24:18'),
	(9, 3, 5091.00, '2024-10-07', '2024-10-10', '2026-01-14 07:16:36', '2026-01-14 07:24:18'),
	(10, 3, 5388.00, '2024-10-11', '2024-10-14', '2026-01-14 07:16:36', '2026-01-14 07:24:18'),
	(11, 3, 5829.00, '2024-10-15', NULL, '2026-01-14 07:16:36', '2026-01-14 07:24:18'),
	(12, 3, 4693.00, '2024-12-25', '2024-12-29', '2026-01-14 07:16:36', '2026-01-14 07:24:18'),
	(14, 3, 5483.00, '2025-01-05', '2025-01-10', '2026-01-14 07:16:36', '2026-01-14 07:24:18'),
	(15, 3, 4978.00, '2025-01-11', '2025-01-14', '2026-01-14 07:16:36', '2026-01-14 07:24:18'),
	(16, 3, 5381.00, '2025-01-15', '2025-01-18', '2026-01-14 07:16:36', '2026-01-14 07:24:18'),
	(17, 3, 5687.00, '2025-01-19', '2025-01-22', '2026-01-14 07:16:36', '2026-01-14 07:24:18'),
	(18, 3, 5152.00, '2025-01-23', '2025-01-26', '2026-01-14 07:16:36', '2026-01-14 07:24:18'),
	(19, 3, 5433.00, '2025-01-27', '2025-01-30', '2026-01-14 07:16:36', '2026-01-14 07:24:18'),
	(20, 3, 5722.00, '2025-01-31', NULL, '2026-01-14 07:16:36', '2026-01-14 07:24:18'),
	(21, 3, 4564.00, '2025-02-01', '2025-02-04', '2026-01-14 07:16:36', '2026-01-14 07:24:18'),
	(22, 3, 4864.00, '2025-02-05', '2025-02-10', '2026-01-14 07:16:36', '2026-01-14 07:24:18'),
	(23, 3, 5298.00, '2025-02-11', '2025-02-14', '2026-01-14 07:16:36', '2026-01-14 07:24:18'),
	(24, 3, 4949.00, '2025-02-15', '2025-02-19', '2026-01-14 07:16:36', '2026-01-14 07:24:18'),
	(25, 3, 5315.00, '2025-02-20', '2025-02-24', '2026-01-14 07:16:36', '2026-01-14 07:24:18'),
	(26, 3, 5607.00, '2025-02-25', '2025-03-02', '2026-01-14 07:16:36', '2026-01-14 07:24:18'),
	(27, 3, 5188.00, '2025-03-03', '2025-03-06', '2026-01-14 07:16:36', '2026-01-14 07:24:18'),
	(28, 3, 5700.00, '2025-03-07', '2025-03-11', '2026-01-14 07:16:36', '2026-01-14 07:24:18'),
	(29, 3, 6010.00, '2025-03-12', NULL, '2026-01-14 07:16:36', '2026-01-14 07:24:18'),
	(30, 3, 4616.00, '2025-07-01', '2025-07-06', '2026-01-14 07:16:36', '2026-01-14 07:24:18'),
	(31, 3, 5008.00, '2025-07-07', '2025-07-10', '2026-01-14 07:16:36', '2026-01-14 07:24:18'),
	(33, 3, 5209.00, '2025-07-17', '2025-07-20', '2026-01-14 07:16:36', '2026-01-14 07:24:18'),
	(34, 3, 5641.00, '2025-07-21', '2025-07-26', '2026-01-14 07:16:36', '2026-01-14 07:24:18'),
	(35, 3, 6033.00, '2025-07-27', '2025-08-01', '2026-01-14 07:16:36', '2026-01-14 07:24:18'),
	(36, 3, 5694.00, '2025-08-02', '2025-08-05', '2026-01-14 07:16:36', '2026-01-14 07:24:18'),
	(37, 3, 6168.00, '2025-08-06', '2025-08-11', '2026-01-14 07:16:36', '2026-01-14 07:24:18'),
	(38, 3, 6514.00, '2025-08-12', NULL, '2026-01-14 07:16:36', '2026-01-14 07:24:18'),
	(39, 3, 4627.00, '2025-09-01', '2025-09-06', '2026-01-14 07:16:36', '2026-01-14 07:24:18'),
	(40, 3, 4936.00, '2025-09-07', '2025-09-11', '2026-01-14 07:16:36', '2026-01-14 07:24:18'),
	(41, 3, 5309.00, '2025-09-12', '2025-09-16', '2026-01-14 07:16:36', '2026-01-14 07:24:18'),
	(42, 3, 4913.00, '2025-09-17', '2025-09-21', '2026-01-14 07:16:36', '2026-01-14 07:24:18'),
	(43, 3, 5305.00, '2025-09-22', '2025-09-27', '2026-01-14 07:16:36', '2026-01-14 07:24:18'),
	(44, 3, 5827.00, '2025-09-28', '2025-10-03', '2026-01-14 07:16:36', '2026-01-14 07:24:18'),
	(45, 3, 5482.00, '2025-10-04', '2025-10-08', '2026-01-14 07:16:36', '2026-01-14 07:24:18'),
	(46, 3, 5865.00, '2025-10-09', '2025-10-13', '2026-01-14 07:16:36', '2026-01-14 07:24:18'),
	(47, 3, 6236.00, '2025-10-14', NULL, '2026-01-14 07:16:36', '2026-01-14 07:24:18'),
	(48, 3, 4538.00, '2026-01-01', '2026-01-05', '2026-01-14 07:16:36', '2026-01-14 07:24:18'),
	(49, 3, 4908.00, '2026-01-06', '2026-01-10', '2026-01-14 07:16:36', '2026-01-14 07:24:18'),
	(50, 3, 5161.00, '2026-01-11', '2026-01-15', '2026-01-14 07:16:36', '2026-01-14 07:24:18'),
	(52, 3, 5145.00, '2026-01-20', '2026-01-25', '2026-01-14 07:16:36', '2026-01-14 07:24:18'),
	(53, 3, 5630.00, '2026-01-26', '2026-01-29', '2026-01-14 07:16:36', '2026-01-14 07:24:18'),
	(54, 3, 5220.00, '2026-01-30', '2026-02-04', '2026-01-14 07:16:36', '2026-01-14 07:24:18'),
	(55, 3, 5554.00, '2026-02-05', '2026-02-10', '2026-01-14 07:16:36', '2026-01-14 07:24:18'),
	(56, 3, 5937.00, '2026-02-11', NULL, '2026-01-14 07:16:36', '2026-01-14 07:24:18'),
	(57, 4, 5490.00, '2024-09-09', '2024-09-13', '2026-01-14 07:16:37', '2026-01-14 07:24:18'),
	(58, 4, 5803.00, '2024-09-14', '2024-09-18', '2026-01-14 07:16:37', '2026-01-14 07:24:18'),
	(59, 4, 6157.00, '2024-09-19', '2024-09-22', '2026-01-14 07:16:37', '2026-01-14 07:24:18'),
	(60, 4, 5700.00, '2024-09-23', '2024-09-28', '2026-01-14 07:16:37', '2026-01-14 07:24:18'),
	(61, 4, 6109.00, '2024-09-29', '2024-10-03', '2026-01-14 07:16:37', '2026-01-14 07:24:18'),
	(62, 4, 6469.00, '2024-10-04', '2024-10-07', '2026-01-14 07:16:37', '2026-01-14 07:24:18'),
	(63, 4, 6032.00, '2024-10-08', '2024-10-11', '2026-01-14 07:16:37', '2026-01-14 07:24:18'),
	(64, 4, 6522.00, '2024-10-12', '2024-10-16', '2026-01-14 07:16:37', '2026-01-14 07:24:18'),
	(65, 4, 6862.00, '2024-10-17', NULL, '2026-01-14 07:16:37', '2026-01-14 07:24:18'),
	(66, 4, 5487.00, '2024-12-25', '2024-12-28', '2026-01-14 07:16:37', '2026-01-14 07:24:18'),
	(67, 4, 5891.00, '2024-12-29', '2025-01-02', '2026-01-14 07:16:37', '2026-01-14 07:24:18'),
	(68, 4, 6340.00, '2025-01-03', '2025-01-06', '2026-01-14 07:16:37', '2026-01-14 07:24:18'),
	(69, 4, 5853.00, '2025-01-07', '2025-01-11', '2026-01-14 07:16:37', '2026-01-14 07:24:18'),
	(71, 4, 6845.00, '2025-01-16', '2025-01-19', '2026-01-14 07:16:37', '2026-01-14 07:24:18'),
	(72, 4, 6283.00, '2025-01-20', '2025-01-25', '2026-01-14 07:16:37', '2026-01-14 07:24:18'),
	(73, 4, 6802.00, '2025-01-26', '2025-01-30', '2026-01-14 07:16:37', '2026-01-14 07:24:19'),
	(74, 4, 7477.00, '2025-01-31', NULL, '2026-01-14 07:16:37', '2026-01-14 07:24:19'),
	(75, 4, 5567.00, '2025-02-01', '2025-02-04', '2026-01-14 07:16:37', '2026-01-14 07:24:19'),
	(76, 4, 5921.00, '2025-02-05', '2025-02-08', '2026-01-14 07:16:37', '2026-01-14 07:24:19'),
	(77, 4, 6507.00, '2025-02-09', '2025-02-14', '2026-01-14 07:16:37', '2026-01-14 07:24:19'),
	(78, 4, 5941.00, '2025-02-15', '2025-02-19', '2026-01-14 07:16:37', '2026-01-14 07:24:19'),
	(79, 4, 6305.00, '2025-02-20', '2025-02-25', '2026-01-14 07:16:37', '2026-01-14 07:24:19'),
	(80, 4, 6746.00, '2025-02-26', '2025-03-02', '2026-01-14 07:16:37', '2026-01-14 07:24:19'),
	(81, 4, 6245.00, '2025-03-03', '2025-03-06', '2026-01-14 07:16:37', '2026-01-14 07:24:19'),
	(82, 4, 6695.00, '2025-03-07', '2025-03-12', '2026-01-14 07:16:37', '2026-01-14 07:24:19'),
	(83, 4, 7203.00, '2025-03-13', NULL, '2026-01-14 07:16:37', '2026-01-14 07:24:19'),
	(84, 4, 5405.00, '2025-07-01', '2025-07-04', '2026-01-14 07:16:37', '2026-01-14 07:24:19'),
	(85, 4, 5690.00, '2025-07-05', '2025-07-09', '2026-01-14 07:16:37', '2026-01-14 07:24:19'),
	(86, 4, 6008.00, '2025-07-10', '2025-07-14', '2026-01-14 07:16:37', '2026-01-14 07:24:19'),
	(87, 4, 5551.00, '2025-07-15', '2025-07-20', '2026-01-14 07:16:37', '2026-01-14 07:24:19'),
	(88, 4, 5842.00, '2025-07-21', '2025-07-25', '2026-01-14 07:16:37', '2026-01-14 07:24:19'),
	(90, 4, 5643.00, '2025-07-30', '2025-08-04', '2026-01-14 07:16:37', '2026-01-14 07:24:19'),
	(91, 4, 5942.00, '2025-08-05', '2025-08-08', '2026-01-14 07:16:37', '2026-01-14 07:24:19'),
	(92, 4, 6504.00, '2025-08-09', NULL, '2026-01-14 07:16:37', '2026-01-14 07:24:19'),
	(93, 4, 5397.00, '2025-09-01', '2025-09-04', '2026-01-14 07:16:37', '2026-01-14 07:24:19'),
	(94, 4, 5685.00, '2025-09-05', '2025-09-10', '2026-01-14 07:16:37', '2026-01-14 07:24:19'),
	(95, 4, 5992.00, '2025-09-11', '2025-09-15', '2026-01-14 07:16:37', '2026-01-14 07:24:19'),
	(96, 4, 5501.00, '2025-09-16', '2025-09-19', '2026-01-14 07:16:37', '2026-01-14 07:24:19'),
	(97, 4, 5874.00, '2025-09-20', '2025-09-25', '2026-01-14 07:16:37', '2026-01-14 07:24:19'),
	(98, 4, 6409.00, '2025-09-26', '2025-09-30', '2026-01-14 07:16:37', '2026-01-14 07:24:19'),
	(99, 4, 5957.00, '2025-10-01', '2025-10-06', '2026-01-14 07:16:37', '2026-01-14 07:24:19'),
	(100, 4, 6488.00, '2025-10-07', '2025-10-12', '2026-01-14 07:16:37', '2026-01-14 07:24:19'),
	(101, 4, 7033.00, '2025-10-13', NULL, '2026-01-14 07:16:37', '2026-01-14 07:24:19'),
	(102, 4, 5534.00, '2026-01-01', '2026-01-04', '2026-01-14 07:16:37', '2026-01-14 07:24:19'),
	(103, 4, 6003.00, '2026-01-05', '2026-01-09', '2026-01-14 07:16:37', '2026-01-14 07:24:19'),
	(104, 4, 6596.00, '2026-01-10', '2026-01-14', '2026-01-14 07:16:37', '2026-01-14 07:24:19'),
	(105, 4, 6213.00, '2026-01-15', '2026-01-20', '2026-01-14 07:16:37', '2026-01-14 07:24:19'),
	(106, 4, 6732.00, '2026-01-21', '2026-01-26', '2026-01-14 07:16:37', '2026-01-14 07:24:19'),
	(107, 4, 7278.00, '2026-01-27', '2026-02-01', '2026-01-14 07:16:37', '2026-01-14 07:24:19'),
	(182, 6, 5174.00, '2025-02-01', '2025-02-06', '2026-01-14 07:16:38', '2026-01-14 07:24:19'),
	(109, 4, 7204.00, '2026-02-08', '2026-02-12', '2026-01-14 07:16:37', '2026-01-14 07:24:19'),
	(110, 4, 7679.00, '2026-02-13', NULL, '2026-01-14 07:16:37', '2026-01-14 07:24:19'),
	(111, 5, 869.00, '2024-09-09', '2024-09-13', '2026-01-14 07:16:37', '2026-01-14 07:24:19'),
	(112, 5, 943.00, '2024-09-14', '2024-09-17', '2026-01-14 07:16:37', '2026-01-14 07:24:19'),
	(113, 5, 1021.00, '2024-09-18', '2024-09-21', '2026-01-14 07:16:37', '2026-01-14 07:24:19'),
	(114, 5, 957.00, '2024-09-22', '2024-09-25', '2026-01-14 07:16:37', '2026-01-14 07:24:19'),
	(115, 5, 1016.00, '2024-09-26', '2024-10-01', '2026-01-14 07:16:37', '2026-01-14 07:24:19'),
	(116, 5, 1091.00, '2024-10-02', '2024-10-06', '2026-01-14 07:16:37', '2026-01-14 07:24:19'),
	(118, 5, 1088.00, '2024-10-11', '2024-10-15', '2026-01-14 07:16:37', '2026-01-14 07:24:19'),
	(119, 5, 1186.00, '2024-10-16', NULL, '2026-01-14 07:16:37', '2026-01-14 07:24:19'),
	(120, 5, 868.00, '2024-12-25', '2024-12-30', '2026-01-14 07:16:37', '2026-01-14 07:24:19'),
	(121, 5, 922.00, '2024-12-31', '2025-01-04', '2026-01-14 07:16:37', '2026-01-14 07:24:19'),
	(122, 5, 990.00, '2025-01-05', '2025-01-09', '2026-01-14 07:16:37', '2026-01-14 07:24:19'),
	(123, 5, 906.00, '2025-01-10', '2025-01-14', '2026-01-14 07:16:37', '2026-01-14 07:24:19'),
	(124, 5, 984.00, '2025-01-15', '2025-01-20', '2026-01-14 07:16:37', '2026-01-14 07:24:19'),
	(125, 5, 1051.00, '2025-01-21', '2025-01-24', '2026-01-14 07:16:37', '2026-01-14 07:24:19'),
	(126, 5, 983.00, '2025-01-25', '2025-01-29', '2026-01-14 07:16:37', '2026-01-14 07:24:19'),
	(127, 5, 1034.00, '2025-01-30', '2025-02-03', '2026-01-14 07:16:37', '2026-01-14 07:24:19'),
	(128, 5, 847.00, '2025-02-01', '2025-02-04', '2026-01-14 07:16:37', '2026-01-14 07:24:19'),
	(129, 5, 1111.00, '2025-02-04', NULL, '2026-01-14 07:16:37', '2026-01-14 07:24:19'),
	(130, 5, 918.00, '2025-02-05', '2025-02-08', '2026-01-14 07:16:37', '2026-01-14 07:24:19'),
	(131, 5, 975.00, '2025-02-09', '2025-02-13', '2026-01-14 07:16:37', '2026-01-14 07:24:19'),
	(132, 5, 922.00, '2025-02-14', '2025-02-18', '2026-01-14 07:16:37', '2026-01-14 07:24:19'),
	(133, 5, 978.00, '2025-02-19', '2025-02-23', '2026-01-14 07:16:37', '2026-01-14 07:24:19'),
	(134, 5, 1039.00, '2025-02-24', '2025-02-28', '2026-01-14 07:16:37', '2026-01-14 07:24:19'),
	(135, 5, 985.00, '2025-03-01', '2025-03-05', '2026-01-14 07:16:37', '2026-01-14 07:24:19'),
	(137, 5, 1098.00, '2025-03-12', NULL, '2026-01-14 07:16:37', '2026-01-14 07:24:19'),
	(138, 5, 844.00, '2025-07-01', '2025-07-06', '2026-01-14 07:16:37', '2026-01-14 07:24:19'),
	(139, 5, 896.00, '2025-07-07', '2025-07-12', '2026-01-14 07:16:37', '2026-01-14 07:24:19'),
	(140, 5, 951.00, '2025-07-13', '2025-07-18', '2026-01-14 07:16:37', '2026-01-14 07:24:19'),
	(141, 5, 867.00, '2025-07-19', '2025-07-23', '2026-01-14 07:16:37', '2026-01-14 07:24:19'),
	(142, 5, 924.00, '2025-07-24', '2025-07-29', '2026-01-14 07:16:37', '2026-01-14 07:24:19'),
	(143, 5, 975.00, '2025-07-30', '2025-08-03', '2026-01-14 07:16:37', '2026-01-14 07:24:19'),
	(144, 5, 886.00, '2025-08-04', '2025-08-08', '2026-01-14 07:16:37', '2026-01-14 07:24:19'),
	(145, 5, 972.00, '2025-08-09', '2025-08-14', '2026-01-14 07:16:37', '2026-01-14 07:24:19'),
	(146, 5, 1052.00, '2025-08-15', NULL, '2026-01-14 07:16:37', '2026-01-14 07:24:19'),
	(147, 5, 848.00, '2025-09-01', '2025-09-04', '2026-01-14 07:16:37', '2026-01-14 07:24:19'),
	(148, 5, 929.00, '2025-09-05', '2025-09-09', '2026-01-14 07:16:37', '2026-01-14 07:24:19'),
	(149, 5, 1004.00, '2025-09-10', '2025-09-13', '2026-01-14 07:16:37', '2026-01-14 07:24:19'),
	(150, 5, 949.00, '2025-09-14', '2025-09-18', '2026-01-14 07:16:37', '2026-01-14 07:24:19'),
	(151, 5, 1009.00, '2025-09-19', '2025-09-24', '2026-01-14 07:16:37', '2026-01-14 07:24:19'),
	(152, 5, 1064.00, '2025-09-25', '2025-09-28', '2026-01-14 07:16:37', '2026-01-14 07:24:19'),
	(153, 5, 964.00, '2025-09-29', '2025-10-04', '2026-01-14 07:16:37', '2026-01-14 07:24:19'),
	(154, 5, 1045.00, '2025-10-05', '2025-10-09', '2026-01-14 07:16:37', '2026-01-14 07:24:19'),
	(156, 5, 870.00, '2026-01-01', '2026-01-05', '2026-01-14 07:16:37', '2026-01-14 07:24:19'),
	(157, 5, 942.00, '2026-01-06', '2026-01-10', '2026-01-14 07:16:37', '2026-01-14 07:24:19'),
	(158, 5, 1033.00, '2026-01-11', '2026-01-16', '2026-01-14 07:16:37', '2026-01-14 07:24:19'),
	(159, 5, 949.00, '2026-01-17', '2026-01-22', '2026-01-14 07:16:37', '2026-01-14 07:24:19'),
	(160, 5, 997.00, '2026-01-23', '2026-01-26', '2026-01-14 07:16:37', '2026-01-14 07:24:19'),
	(161, 5, 1092.00, '2026-01-27', '2026-01-30', '2026-01-14 07:16:37', '2026-01-14 07:24:19'),
	(162, 5, 1021.00, '2026-01-31', '2026-02-04', '2026-01-14 07:16:37', '2026-01-14 07:24:19'),
	(163, 5, 1103.00, '2026-02-05', '2026-02-09', '2026-01-14 07:16:37', '2026-01-14 07:24:19'),
	(164, 5, 1181.00, '2026-02-10', NULL, '2026-01-14 07:16:37', '2026-01-14 07:24:19'),
	(165, 6, 5064.00, '2024-09-09', '2024-09-14', '2026-01-14 07:16:38', '2026-01-14 07:24:19'),
	(166, 6, 5498.00, '2024-09-15', '2024-09-20', '2026-01-14 07:16:38', '2026-01-14 07:24:19'),
	(167, 6, 5786.00, '2024-09-21', '2024-09-26', '2026-01-14 07:16:38', '2026-01-14 07:24:19'),
	(168, 6, 5221.00, '2024-09-27', '2024-10-01', '2026-01-14 07:16:38', '2026-01-14 07:24:19'),
	(169, 6, 5675.00, '2024-10-02', '2024-10-06', '2026-01-14 07:16:38', '2026-01-14 07:24:19'),
	(170, 6, 6012.00, '2024-10-07', '2024-10-11', '2026-01-14 07:16:38', '2026-01-14 07:24:19'),
	(171, 6, 5688.00, '2024-10-12', '2024-10-15', '2026-01-14 07:16:38', '2026-01-14 07:24:19'),
	(172, 6, 6247.00, '2024-10-16', '2024-10-20', '2026-01-14 07:16:38', '2026-01-14 07:24:19'),
	(173, 6, 6741.00, '2024-10-21', NULL, '2026-01-14 07:16:38', '2026-01-14 07:24:19'),
	(175, 6, 5491.00, '2024-12-30', '2025-01-02', '2026-01-14 07:16:38', '2026-01-14 07:24:19'),
	(176, 6, 5822.00, '2025-01-03', '2025-01-08', '2026-01-14 07:16:38', '2026-01-14 07:24:19'),
	(177, 6, 5414.00, '2025-01-09', '2025-01-12', '2026-01-14 07:16:38', '2026-01-14 07:24:19'),
	(178, 6, 5808.00, '2025-01-13', '2025-01-17', '2026-01-14 07:16:38', '2026-01-14 07:24:19'),
	(179, 6, 6386.00, '2025-01-18', '2025-01-23', '2026-01-14 07:16:38', '2026-01-14 07:24:19'),
	(180, 6, 5829.00, '2025-01-24', '2025-01-27', '2026-01-14 07:16:38', '2026-01-14 07:24:19'),
	(181, 6, 6300.00, '2025-01-28', '2025-01-31', '2026-01-14 07:16:38', '2026-01-14 07:24:19'),
	(183, 6, 5618.00, '2025-02-07', '2025-02-12', '2026-01-14 07:16:38', '2026-01-14 07:24:19'),
	(184, 6, 6118.00, '2025-02-13', '2025-02-17', '2026-01-14 07:16:38', '2026-01-14 07:24:19'),
	(185, 6, 5661.00, '2025-02-18', '2025-02-21', '2026-01-14 07:16:38', '2026-01-14 07:24:19'),
	(186, 6, 6070.00, '2025-02-22', '2025-02-26', '2026-01-14 07:16:38', '2026-01-14 07:24:19'),
	(187, 6, 6583.00, '2025-02-27', '2025-03-04', '2026-01-14 07:16:38', '2026-01-14 07:24:19'),
	(188, 6, 6144.00, '2025-03-05', '2025-03-09', '2026-01-14 07:16:38', '2026-01-14 07:24:19'),
	(189, 6, 6551.00, '2025-03-10', '2025-03-15', '2026-01-14 07:16:38', '2026-01-14 07:24:19'),
	(190, 6, 7038.00, '2025-03-16', NULL, '2026-01-14 07:16:38', '2026-01-14 07:24:19'),
	(191, 6, 5093.00, '2025-07-01', '2025-07-04', '2026-01-14 07:16:38', '2026-01-14 07:24:19'),
	(192, 6, 5531.00, '2025-07-05', '2025-07-10', '2026-01-14 07:16:38', '2026-01-14 07:24:19'),
	(193, 6, 5925.00, '2025-07-11', '2025-07-16', '2026-01-14 07:16:38', '2026-01-14 07:24:19'),
	(195, 6, 5816.00, '2025-07-21', '2025-07-24', '2026-01-14 07:16:38', '2026-01-14 07:24:20'),
	(196, 6, 6323.00, '2025-07-25', '2025-07-30', '2026-01-14 07:16:38', '2026-01-14 07:24:20'),
	(197, 6, 5866.00, '2025-07-31', '2025-08-04', '2026-01-14 07:16:38', '2026-01-14 07:24:20'),
	(198, 6, 6345.00, '2025-08-05', '2025-08-09', '2026-01-14 07:16:38', '2026-01-14 07:24:20'),
	(199, 6, 6922.00, '2025-08-10', NULL, '2026-01-14 07:16:38', '2026-01-14 07:24:20'),
	(200, 6, 5109.00, '2025-09-01', '2025-09-04', '2026-01-14 07:16:38', '2026-01-14 07:24:20'),
	(201, 6, 5498.00, '2025-09-05', '2025-09-08', '2026-01-14 07:16:38', '2026-01-14 07:24:20'),
	(202, 6, 5996.00, '2025-09-09', '2025-09-14', '2026-01-14 07:16:38', '2026-01-14 07:24:20'),
	(203, 6, 5685.00, '2025-09-15', '2025-09-18', '2026-01-14 07:16:38', '2026-01-14 07:24:20'),
	(204, 6, 5971.00, '2025-09-19', '2025-09-24', '2026-01-14 07:16:38', '2026-01-14 07:24:20'),
	(205, 6, 6452.00, '2025-09-25', '2025-09-29', '2026-01-14 07:16:38', '2026-01-14 07:24:20'),
	(206, 6, 6017.00, '2025-09-30', '2025-10-04', '2026-01-14 07:16:38', '2026-01-14 07:24:20'),
	(207, 6, 6344.00, '2025-10-05', '2025-10-08', '2026-01-14 07:16:38', '2026-01-14 07:24:20'),
	(208, 6, 6900.00, '2025-10-09', NULL, '2026-01-14 07:16:38', '2026-01-14 07:24:20'),
	(209, 6, 5088.00, '2026-01-01', '2026-01-05', '2026-01-14 07:16:38', '2026-01-14 07:24:20'),
	(210, 6, 5478.00, '2026-01-06', '2026-01-10', '2026-01-14 07:16:38', '2026-01-14 07:24:20'),
	(211, 6, 5825.00, '2026-01-11', '2026-01-15', '2026-01-14 07:16:38', '2026-01-14 07:24:20'),
	(212, 6, 5331.00, '2026-01-16', '2026-01-20', '2026-01-14 07:16:38', '2026-01-14 07:24:20'),
	(214, 6, 6198.00, '2026-01-26', '2026-01-30', '2026-01-14 07:16:38', '2026-01-14 07:24:20'),
	(216, 6, 6213.00, '2026-02-06', '2026-02-11', '2026-01-14 07:16:38', '2026-01-14 07:24:20'),
	(217, 6, 6570.00, '2026-02-12', NULL, '2026-01-14 07:16:38', '2026-01-14 07:24:20'),
	(218, 7, 14289.00, '2024-09-09', '2024-09-12', '2026-01-14 07:16:38', '2026-01-14 07:24:20'),
	(219, 7, 15267.00, '2024-09-13', '2024-09-17', '2026-01-14 07:16:38', '2026-01-14 07:24:20'),
	(220, 7, 16585.00, '2024-09-18', '2024-09-23', '2026-01-14 07:16:38', '2026-01-14 07:24:20'),
	(221, 7, 15479.00, '2024-09-24', '2024-09-28', '2026-01-14 07:16:38', '2026-01-14 07:24:20'),
	(222, 7, 16315.00, '2024-09-29', '2024-10-02', '2026-01-14 07:16:38', '2026-01-14 07:24:20'),
	(223, 7, 17859.00, '2024-10-03', '2024-10-08', '2026-01-14 07:16:38', '2026-01-14 07:24:20'),
	(224, 7, 16213.00, '2024-10-09', '2024-10-14', '2026-01-14 07:16:38', '2026-01-14 07:24:20'),
	(226, 7, 18332.00, '2024-10-19', NULL, '2026-01-14 07:16:38', '2026-01-14 07:24:20'),
	(227, 7, 14217.00, '2024-12-25', '2024-12-28', '2026-01-14 07:16:38', '2026-01-14 07:24:20'),
	(228, 7, 15515.00, '2024-12-29', '2025-01-03', '2026-01-14 07:16:38', '2026-01-14 07:24:20'),
	(229, 7, 16921.00, '2025-01-04', '2025-01-08', '2026-01-14 07:16:38', '2026-01-14 07:24:20'),
	(230, 7, 15821.00, '2025-01-09', '2025-01-13', '2026-01-14 07:16:38', '2026-01-14 07:24:20'),
	(231, 7, 16926.00, '2025-01-14', '2025-01-18', '2026-01-14 07:16:38', '2026-01-14 07:24:20'),
	(232, 7, 17785.00, '2025-01-19', '2025-01-24', '2026-01-14 07:16:38', '2026-01-14 07:24:20'),
	(233, 7, 16878.00, '2025-01-25', '2025-01-28', '2026-01-14 07:16:38', '2026-01-14 07:24:20'),
	(234, 7, 18144.00, '2025-01-29', '2025-02-01', '2026-01-14 07:16:38', '2026-01-14 07:24:20'),
	(235, 7, 14634.00, '2025-02-01', '2025-02-06', '2026-01-14 07:16:38', '2026-01-14 07:24:20'),
	(236, 7, 19841.00, '2025-02-02', NULL, '2026-01-14 07:16:38', '2026-01-14 07:24:20'),
	(237, 7, 15642.00, '2025-02-07', '2025-02-10', '2026-01-14 07:16:38', '2026-01-14 07:24:20'),
	(238, 7, 16874.00, '2025-02-11', '2025-02-16', '2026-01-14 07:16:38', '2026-01-14 07:24:20'),
	(239, 7, 15455.00, '2025-02-17', '2025-02-22', '2026-01-14 07:16:38', '2026-01-14 07:24:20'),
	(240, 7, 16979.00, '2025-02-23', '2025-02-26', '2026-01-14 07:16:38', '2026-01-14 07:24:20'),
	(241, 7, 18227.00, '2025-02-27', '2025-03-03', '2026-01-14 07:16:38', '2026-01-14 07:24:20'),
	(242, 7, 16893.00, '2025-03-04', '2025-03-09', '2026-01-14 07:16:38', '2026-01-14 07:24:20'),
	(243, 7, 18567.00, '2025-03-10', '2025-03-14', '2026-01-14 07:16:38', '2026-01-14 07:24:20'),
	(245, 7, 14802.00, '2025-07-01', '2025-07-06', '2026-01-14 07:16:38', '2026-01-14 07:24:20'),
	(246, 7, 15911.00, '2025-07-07', '2025-07-10', '2026-01-14 07:16:38', '2026-01-14 07:24:20'),
	(247, 7, 17082.00, '2025-07-11', '2025-07-16', '2026-01-14 07:16:38', '2026-01-14 07:24:20'),
	(248, 7, 15513.00, '2025-07-17', '2025-07-22', '2026-01-14 07:16:38', '2026-01-14 07:24:20'),
	(249, 7, 16515.00, '2025-07-23', '2025-07-28', '2026-01-14 07:16:38', '2026-01-14 07:24:20'),
	(250, 7, 17904.00, '2025-07-29', '2025-08-03', '2026-01-14 07:16:38', '2026-01-14 07:24:20'),
	(251, 7, 16292.00, '2025-08-04', '2025-08-08', '2026-01-14 07:16:38', '2026-01-14 07:24:20'),
	(252, 7, 17900.00, '2025-08-09', '2025-08-13', '2026-01-14 07:16:38', '2026-01-14 07:24:20'),
	(253, 7, 19385.00, '2025-08-14', NULL, '2026-01-14 07:16:38', '2026-01-14 07:24:20'),
	(254, 7, 14477.00, '2025-09-01', '2025-09-04', '2026-01-14 07:16:38', '2026-01-14 07:24:20'),
	(255, 7, 15332.00, '2025-09-05', '2025-09-09', '2026-01-14 07:16:38', '2026-01-14 07:24:20'),
	(256, 7, 16677.00, '2025-09-10', '2025-09-15', '2026-01-14 07:16:38', '2026-01-14 07:24:20'),
	(257, 7, 15169.00, '2025-09-16', '2025-09-19', '2026-01-14 07:16:38', '2026-01-14 07:24:20'),
	(258, 7, 16184.00, '2025-09-20', '2025-09-23', '2026-01-14 07:16:38', '2026-01-14 07:24:20'),
	(259, 7, 17635.00, '2025-09-24', '2025-09-29', '2026-01-14 07:16:38', '2026-01-14 07:24:20'),
	(260, 7, 16715.00, '2025-09-30', '2025-10-04', '2026-01-14 07:16:38', '2026-01-14 07:24:20'),
	(261, 7, 18201.00, '2025-10-05', '2025-10-10', '2026-01-14 07:16:38', '2026-01-14 07:24:20'),
	(262, 7, 19339.00, '2025-10-11', NULL, '2026-01-14 07:16:38', '2026-01-14 07:24:20'),
	(264, 7, 15272.00, '2026-01-05', '2026-01-10', '2026-01-14 07:16:38', '2026-01-14 07:24:20'),
	(265, 7, 16207.00, '2026-01-11', '2026-01-16', '2026-01-14 07:16:38', '2026-01-14 07:24:20'),
	(266, 7, 15222.00, '2026-01-17', '2026-01-21', '2026-01-14 07:16:38', '2026-01-14 07:24:20'),
	(267, 7, 15989.00, '2026-01-22', '2026-01-26', '2026-01-14 07:16:38', '2026-01-14 07:24:20');
INSERT INTO public.medicine_prices VALUES
	(268, 7, 17524.00, '2026-01-27', '2026-01-30', '2026-01-14 07:16:38', '2026-01-14 07:24:20'),
	(269, 7, 16490.00, '2026-01-31', '2026-02-03', '2026-01-14 07:16:38', '2026-01-14 07:24:20'),
	(270, 7, 17411.00, '2026-02-04', '2026-02-09', '2026-01-14 07:16:38', '2026-01-14 07:24:20'),
	(271, 7, 19034.00, '2026-02-10', NULL, '2026-01-14 07:16:38', '2026-01-14 07:24:20'),
	(272, 8, 6576.00, '2024-09-09', '2024-09-14', '2026-01-14 07:16:39', '2026-01-14 07:24:20'),
	(273, 8, 6970.00, '2024-09-15', '2024-09-18', '2026-01-14 07:16:39', '2026-01-14 07:24:20'),
	(274, 8, 7373.00, '2024-09-19', '2024-09-22', '2026-01-14 07:16:39', '2026-01-14 07:24:20'),
	(275, 8, 6919.00, '2024-09-23', '2024-09-26', '2026-01-14 07:16:39', '2026-01-14 07:24:20'),
	(276, 8, 7397.00, '2024-09-27', '2024-09-30', '2026-01-14 07:16:39', '2026-01-14 07:24:20'),
	(277, 8, 7976.00, '2024-10-01', '2024-10-04', '2026-01-14 07:16:39', '2026-01-14 07:24:20'),
	(278, 8, 7227.00, '2024-10-05', '2024-10-10', '2026-01-14 07:16:39', '2026-01-14 07:24:20'),
	(279, 8, 7589.00, '2024-10-11', '2024-10-16', '2026-01-14 07:16:39', '2026-01-14 07:24:20'),
	(280, 8, 8061.00, '2024-10-17', NULL, '2026-01-14 07:16:39', '2026-01-14 07:24:20'),
	(281, 8, 6431.00, '2024-12-25', '2024-12-30', '2026-01-14 07:16:39', '2026-01-14 07:24:20'),
	(283, 8, 7476.00, '2025-01-05', '2025-01-10', '2026-01-14 07:16:39', '2026-01-14 07:24:20'),
	(284, 8, 7049.00, '2025-01-11', '2025-01-14', '2026-01-14 07:16:39', '2026-01-14 07:24:20'),
	(285, 8, 7723.00, '2025-01-15', '2025-01-20', '2026-01-14 07:16:39', '2026-01-14 07:24:20'),
	(286, 8, 8450.00, '2025-01-21', '2025-01-25', '2026-01-14 07:16:39', '2026-01-14 07:24:20'),
	(287, 8, 8011.00, '2025-01-26', '2025-01-30', '2026-01-14 07:16:39', '2026-01-14 07:24:20'),
	(288, 8, 8789.00, '2025-01-31', '2025-02-04', '2026-01-14 07:16:39', '2026-01-14 07:24:20'),
	(289, 8, 6638.00, '2025-02-01', '2025-02-06', '2026-01-14 07:16:39', '2026-01-14 07:24:20'),
	(290, 8, 9448.00, '2025-02-05', NULL, '2026-01-14 07:16:39', '2026-01-14 07:24:20'),
	(291, 8, 7201.00, '2025-02-07', '2025-02-10', '2026-01-14 07:16:39', '2026-01-14 07:24:20'),
	(292, 8, 7763.00, '2025-02-11', '2025-02-14', '2026-01-14 07:16:39', '2026-01-14 07:24:20'),
	(293, 8, 7212.00, '2025-02-15', '2025-02-19', '2026-01-14 07:16:39', '2026-01-14 07:24:20'),
	(294, 8, 7856.00, '2025-02-20', '2025-02-25', '2026-01-14 07:16:39', '2026-01-14 07:24:20'),
	(295, 8, 8529.00, '2025-02-26', '2025-03-02', '2026-01-14 07:16:39', '2026-01-14 07:24:20'),
	(296, 8, 7678.00, '2025-03-03', '2025-03-06', '2026-01-14 07:16:39', '2026-01-14 07:24:20'),
	(297, 8, 8440.00, '2025-03-07', '2025-03-12', '2026-01-14 07:16:39', '2026-01-14 07:24:20'),
	(298, 8, 9065.00, '2025-03-13', NULL, '2026-01-14 07:16:39', '2026-01-14 07:24:20'),
	(299, 8, 6561.00, '2025-07-01', '2025-07-05', '2026-01-14 07:16:39', '2026-01-14 07:24:20'),
	(300, 8, 6910.00, '2025-07-06', '2025-07-10', '2026-01-14 07:16:39', '2026-01-14 07:24:20'),
	(302, 8, 6979.00, '2025-07-17', '2025-07-20', '2026-01-14 07:16:39', '2026-01-14 07:24:20'),
	(303, 8, 7378.00, '2025-07-21', '2025-07-24', '2026-01-14 07:16:39', '2026-01-14 07:24:20'),
	(304, 8, 8097.00, '2025-07-25', '2025-07-29', '2026-01-14 07:16:39', '2026-01-14 07:24:20'),
	(305, 8, 7440.00, '2025-07-30', '2025-08-04', '2026-01-14 07:16:39', '2026-01-14 07:24:20'),
	(306, 8, 8043.00, '2025-08-05', '2025-08-10', '2026-01-14 07:16:39', '2026-01-14 07:24:20'),
	(307, 8, 8519.00, '2025-08-11', NULL, '2026-01-14 07:16:39', '2026-01-14 07:24:20'),
	(308, 8, 6485.00, '2025-09-01', '2025-09-05', '2026-01-14 07:16:39', '2026-01-14 07:24:20'),
	(309, 8, 6949.00, '2025-09-06', '2025-09-11', '2026-01-14 07:16:39', '2026-01-14 07:24:20'),
	(310, 8, 7371.00, '2025-09-12', '2025-09-17', '2026-01-14 07:16:39', '2026-01-14 07:24:20'),
	(311, 8, 6947.00, '2025-09-18', '2025-09-21', '2026-01-14 07:16:39', '2026-01-14 07:24:20'),
	(312, 8, 7582.00, '2025-09-22', '2025-09-25', '2026-01-14 07:16:39', '2026-01-14 07:24:20'),
	(313, 8, 8283.00, '2025-09-26', '2025-09-29', '2026-01-14 07:16:39', '2026-01-14 07:24:20'),
	(314, 8, 7713.00, '2025-09-30', '2025-10-05', '2026-01-14 07:16:39', '2026-01-14 07:24:20'),
	(315, 8, 8298.00, '2025-10-06', '2025-10-11', '2026-01-14 07:16:39', '2026-01-14 07:24:20'),
	(316, 8, 8867.00, '2025-10-12', NULL, '2026-01-14 07:16:39', '2026-01-14 07:24:20'),
	(317, 8, 6448.00, '2026-01-01', '2026-01-05', '2026-01-14 07:16:39', '2026-01-14 07:24:20'),
	(318, 8, 6818.00, '2026-01-06', '2026-01-11', '2026-01-14 07:16:39', '2026-01-14 07:24:20'),
	(319, 8, 7268.00, '2026-01-12', '2026-01-15', '2026-01-14 07:16:39', '2026-01-14 07:24:20'),
	(321, 8, 7292.00, '2026-01-22', '2026-01-27', '2026-01-14 07:16:39', '2026-01-14 07:24:20'),
	(342, 9, 4523.00, '2025-02-01', '2025-02-04', '2026-01-14 07:16:39', '2026-01-14 07:24:21'),
	(323, 8, 7254.00, '2026-02-01', '2026-02-06', '2026-01-14 07:16:39', '2026-01-14 07:24:20'),
	(324, 8, 7635.00, '2026-02-07', '2026-02-12', '2026-01-14 07:16:39', '2026-01-14 07:24:21'),
	(325, 8, 8359.00, '2026-02-13', NULL, '2026-01-14 07:16:39', '2026-01-14 07:24:21'),
	(326, 9, 4515.00, '2024-09-09', '2024-09-14', '2026-01-14 07:16:39', '2026-01-14 07:24:21'),
	(327, 9, 4772.00, '2024-09-15', '2024-09-19', '2026-01-14 07:16:39', '2026-01-14 07:24:21'),
	(328, 9, 5248.00, '2024-09-20', '2024-09-24', '2026-01-14 07:16:39', '2026-01-14 07:24:21'),
	(329, 9, 4809.00, '2024-09-25', '2024-09-28', '2026-01-14 07:16:39', '2026-01-14 07:24:21'),
	(330, 9, 5053.00, '2024-09-29', '2024-10-03', '2026-01-14 07:16:39', '2026-01-14 07:24:21'),
	(332, 9, 4974.00, '2024-10-09', '2024-10-12', '2026-01-14 07:16:39', '2026-01-14 07:24:21'),
	(333, 9, 5449.00, '2024-10-13', '2024-10-18', '2026-01-14 07:16:39', '2026-01-14 07:24:21'),
	(334, 9, 5937.00, '2024-10-19', NULL, '2026-01-14 07:16:39', '2026-01-14 07:24:21'),
	(335, 9, 4349.00, '2024-12-25', '2024-12-30', '2026-01-14 07:16:39', '2026-01-14 07:24:21'),
	(336, 9, 4685.00, '2024-12-31', '2025-01-03', '2026-01-14 07:16:39', '2026-01-14 07:24:21'),
	(337, 9, 5111.00, '2025-01-04', '2025-01-09', '2026-01-14 07:16:39', '2026-01-14 07:24:21'),
	(338, 9, 4807.00, '2025-01-10', '2025-01-14', '2026-01-14 07:16:39', '2026-01-14 07:24:21'),
	(339, 9, 5256.00, '2025-01-15', '2025-01-19', '2026-01-14 07:16:39', '2026-01-14 07:24:21'),
	(340, 9, 5697.00, '2025-01-20', '2025-01-25', '2026-01-14 07:16:39', '2026-01-14 07:24:21'),
	(341, 9, 5214.00, '2025-01-26', '2025-01-31', '2026-01-14 07:16:39', '2026-01-14 07:24:21'),
	(343, 9, 4834.00, '2025-02-05', '2025-02-10', '2026-01-14 07:16:39', '2026-01-14 07:24:21'),
	(344, 9, 5883.00, '2025-02-06', NULL, '2026-01-14 07:16:39', '2026-01-14 07:24:21'),
	(345, 9, 5159.00, '2025-02-11', '2025-02-16', '2026-01-14 07:16:39', '2026-01-14 07:24:21'),
	(346, 9, 4688.00, '2025-02-17', '2025-02-21', '2026-01-14 07:16:39', '2026-01-14 07:24:21'),
	(347, 9, 5073.00, '2025-02-22', '2025-02-27', '2026-01-14 07:16:39', '2026-01-14 07:24:21'),
	(348, 9, 5565.00, '2025-02-28', '2025-03-04', '2026-01-14 07:16:39', '2026-01-14 07:24:21'),
	(349, 9, 5127.00, '2025-03-05', '2025-03-08', '2026-01-14 07:16:39', '2026-01-14 07:24:21'),
	(350, 9, 5520.00, '2025-03-09', '2025-03-14', '2026-01-14 07:16:39', '2026-01-14 07:24:21'),
	(352, 9, 4400.00, '2025-07-01', '2025-07-04', '2026-01-14 07:16:39', '2026-01-14 07:24:21'),
	(353, 9, 4827.00, '2025-07-05', '2025-07-08', '2026-01-14 07:16:39', '2026-01-14 07:24:21'),
	(354, 9, 5077.00, '2025-07-09', '2025-07-12', '2026-01-14 07:16:39', '2026-01-14 07:24:21'),
	(355, 9, 4735.00, '2025-07-13', '2025-07-16', '2026-01-14 07:16:39', '2026-01-14 07:24:21'),
	(356, 9, 5136.00, '2025-07-17', '2025-07-21', '2026-01-14 07:16:39', '2026-01-14 07:24:21'),
	(357, 9, 5457.00, '2025-07-22', '2025-07-25', '2026-01-14 07:16:39', '2026-01-14 07:24:21'),
	(358, 9, 5155.00, '2025-07-26', '2025-07-29', '2026-01-14 07:16:39', '2026-01-14 07:24:21'),
	(359, 9, 5662.00, '2025-07-30', '2025-08-02', '2026-01-14 07:16:39', '2026-01-14 07:24:21'),
	(360, 9, 6108.00, '2025-08-03', NULL, '2026-01-14 07:16:39', '2026-01-14 07:24:21'),
	(361, 9, 4515.00, '2025-09-01', '2025-09-04', '2026-01-14 07:16:39', '2026-01-14 07:24:21'),
	(362, 9, 4888.00, '2025-09-05', '2025-09-09', '2026-01-14 07:16:39', '2026-01-14 07:24:21'),
	(363, 9, 5203.00, '2025-09-10', '2025-09-15', '2026-01-14 07:16:39', '2026-01-14 07:24:21'),
	(364, 9, 4759.00, '2025-09-16', '2025-09-21', '2026-01-14 07:16:39', '2026-01-14 07:24:21'),
	(365, 9, 5117.00, '2025-09-22', '2025-09-27', '2026-01-14 07:16:39', '2026-01-14 07:24:21'),
	(366, 9, 5503.00, '2025-09-28', '2025-10-03', '2026-01-14 07:16:39', '2026-01-14 07:24:21'),
	(367, 9, 4981.00, '2025-10-04', '2025-10-07', '2026-01-14 07:16:39', '2026-01-14 07:24:21'),
	(368, 9, 5379.00, '2025-10-08', '2025-10-12', '2026-01-14 07:16:39', '2026-01-14 07:24:21'),
	(369, 9, 5818.00, '2025-10-13', NULL, '2026-01-14 07:16:39', '2026-01-14 07:24:21'),
	(371, 9, 4786.00, '2026-01-05', '2026-01-08', '2026-01-14 07:16:39', '2026-01-14 07:24:21'),
	(372, 9, 5042.00, '2026-01-09', '2026-01-12', '2026-01-14 07:16:39', '2026-01-14 07:24:21'),
	(373, 9, 4755.00, '2026-01-13', '2026-01-17', '2026-01-14 07:16:39', '2026-01-14 07:24:21'),
	(374, 9, 5047.00, '2026-01-18', '2026-01-21', '2026-01-14 07:16:39', '2026-01-14 07:24:21'),
	(375, 9, 5437.00, '2026-01-22', '2026-01-27', '2026-01-14 07:16:39', '2026-01-14 07:24:21'),
	(376, 9, 5106.00, '2026-01-28', '2026-02-02', '2026-01-14 07:16:39', '2026-01-14 07:24:21'),
	(377, 9, 5490.00, '2026-02-03', '2026-02-08', '2026-01-14 07:16:39', '2026-01-14 07:24:21'),
	(378, 9, 5886.00, '2026-02-09', NULL, '2026-01-14 07:16:39', '2026-01-14 07:24:21'),
	(379, 10, 2081.00, '2024-09-09', '2024-09-12', '2026-01-14 07:16:39', '2026-01-14 07:24:21'),
	(380, 10, 2197.00, '2024-09-13', '2024-09-17', '2026-01-14 07:16:39', '2026-01-14 07:24:22'),
	(381, 10, 2341.00, '2024-09-18', '2024-09-23', '2026-01-14 07:16:39', '2026-01-14 07:24:22'),
	(382, 10, 2134.00, '2024-09-24', '2024-09-27', '2026-01-14 07:16:39', '2026-01-14 07:24:22'),
	(383, 10, 2254.00, '2024-09-28', '2024-10-02', '2026-01-14 07:16:39', '2026-01-14 07:24:22'),
	(384, 10, 2416.00, '2024-10-03', '2024-10-08', '2026-01-14 07:16:39', '2026-01-14 07:24:22'),
	(385, 10, 2178.00, '2024-10-09', '2024-10-13', '2026-01-14 07:16:39', '2026-01-14 07:24:22'),
	(386, 10, 2348.00, '2024-10-14', '2024-10-18', '2026-01-14 07:16:39', '2026-01-14 07:24:22'),
	(387, 10, 2559.00, '2024-10-19', NULL, '2026-01-14 07:16:39', '2026-01-14 07:24:22'),
	(388, 10, 2069.00, '2024-12-25', '2024-12-28', '2026-01-14 07:16:39', '2026-01-14 07:24:22'),
	(390, 10, 2459.00, '2025-01-03', '2025-01-08', '2026-01-14 07:16:39', '2026-01-14 07:24:22'),
	(391, 10, 2290.00, '2025-01-09', '2025-01-12', '2026-01-14 07:16:39', '2026-01-14 07:24:22'),
	(392, 10, 2451.00, '2025-01-13', '2025-01-18', '2026-01-14 07:16:39', '2026-01-14 07:24:22'),
	(393, 10, 2662.00, '2025-01-19', '2025-01-24', '2026-01-14 07:16:39', '2026-01-14 07:24:22'),
	(394, 10, 2526.00, '2025-01-25', '2025-01-30', '2026-01-14 07:16:39', '2026-01-14 07:24:22'),
	(395, 10, 2707.00, '2025-01-31', '2025-02-03', '2026-01-14 07:16:39', '2026-01-14 07:24:22'),
	(396, 10, 2093.00, '2025-02-01', '2025-02-06', '2026-01-14 07:16:39', '2026-01-14 07:24:22'),
	(397, 10, 2930.00, '2025-02-04', NULL, '2026-01-14 07:16:39', '2026-01-14 07:24:22'),
	(398, 10, 2291.00, '2025-02-07', '2025-02-12', '2026-01-14 07:16:39', '2026-01-14 07:24:22'),
	(399, 10, 2419.00, '2025-02-13', '2025-02-18', '2026-01-14 07:16:39', '2026-01-14 07:24:22'),
	(400, 10, 2189.00, '2025-02-19', '2025-02-24', '2026-01-14 07:16:39', '2026-01-14 07:24:22'),
	(401, 10, 2317.00, '2025-02-25', '2025-03-01', '2026-01-14 07:16:39', '2026-01-14 07:24:22'),
	(402, 10, 2514.00, '2025-03-02', '2025-03-07', '2026-01-14 07:16:39', '2026-01-14 07:24:22'),
	(403, 10, 2347.00, '2025-03-08', '2025-03-12', '2026-01-14 07:16:39', '2026-01-14 07:24:22'),
	(404, 10, 2481.00, '2025-03-13', '2025-03-18', '2026-01-14 07:16:39', '2026-01-14 07:24:22'),
	(405, 10, 2711.00, '2025-03-19', NULL, '2026-01-14 07:16:39', '2026-01-14 07:24:22'),
	(406, 10, 2066.00, '2025-07-01', '2025-07-04', '2026-01-14 07:16:39', '2026-01-14 07:24:22'),
	(407, 10, 2202.00, '2025-07-05', '2025-07-10', '2026-01-14 07:16:39', '2026-01-14 07:24:22'),
	(409, 10, 2139.00, '2025-07-17', '2025-07-20', '2026-01-14 07:16:39', '2026-01-14 07:24:22'),
	(410, 10, 2334.00, '2025-07-21', '2025-07-26', '2026-01-14 07:16:39', '2026-01-14 07:24:22'),
	(411, 10, 2516.00, '2025-07-27', '2025-08-01', '2026-01-14 07:16:39', '2026-01-14 07:24:22'),
	(412, 10, 2322.00, '2025-08-02', '2025-08-06', '2026-01-14 07:16:39', '2026-01-14 07:24:22'),
	(413, 10, 2524.00, '2025-08-07', '2025-08-12', '2026-01-14 07:16:39', '2026-01-14 07:24:22'),
	(414, 10, 2654.00, '2025-08-13', NULL, '2026-01-14 07:16:39', '2026-01-14 07:24:22'),
	(415, 10, 2024.00, '2025-09-01', '2025-09-05', '2026-01-14 07:16:39', '2026-01-14 07:24:22'),
	(416, 10, 2133.00, '2025-09-06', '2025-09-11', '2026-01-14 07:16:39', '2026-01-14 07:24:22'),
	(417, 10, 2261.00, '2025-09-12', '2025-09-15', '2026-01-14 07:16:39', '2026-01-14 07:24:22'),
	(418, 10, 2053.00, '2025-09-16', '2025-09-20', '2026-01-14 07:16:40', '2026-01-14 07:24:22'),
	(419, 10, 2238.00, '2025-09-21', '2025-09-26', '2026-01-14 07:16:40', '2026-01-14 07:24:22'),
	(420, 10, 2391.00, '2025-09-27', '2025-09-30', '2026-01-14 07:16:40', '2026-01-14 07:24:22'),
	(421, 10, 2156.00, '2025-10-01', '2025-10-06', '2026-01-14 07:16:40', '2026-01-14 07:24:22'),
	(422, 10, 2369.00, '2025-10-07', '2025-10-10', '2026-01-14 07:16:40', '2026-01-14 07:24:22'),
	(423, 10, 2593.00, '2025-10-11', NULL, '2026-01-14 07:16:40', '2026-01-14 07:24:22'),
	(424, 10, 2026.00, '2026-01-01', '2026-01-04', '2026-01-14 07:16:40', '2026-01-14 07:24:22'),
	(425, 10, 2222.00, '2026-01-05', '2026-01-08', '2026-01-14 07:16:40', '2026-01-14 07:24:22'),
	(426, 10, 2432.00, '2026-01-09', '2026-01-12', '2026-01-14 07:16:40', '2026-01-14 07:24:22'),
	(428, 10, 2433.00, '2026-01-18', '2026-01-21', '2026-01-14 07:16:40', '2026-01-14 07:24:22'),
	(430, 10, 2449.00, '2026-01-28', '2026-02-01', '2026-01-14 07:16:40', '2026-01-14 07:24:22'),
	(431, 10, 2676.00, '2026-02-02', '2026-02-06', '2026-01-14 07:16:40', '2026-01-14 07:24:22'),
	(432, 10, 2852.00, '2026-02-07', NULL, '2026-01-14 07:16:40', '2026-01-14 07:24:22'),
	(433, 11, 2596.00, '2024-09-09', '2024-09-12', '2026-01-14 07:16:40', '2026-01-14 07:24:22'),
	(434, 11, 2853.00, '2024-09-13', '2024-09-17', '2026-01-14 07:16:40', '2026-01-14 07:24:22'),
	(435, 11, 3049.00, '2024-09-18', '2024-09-21', '2026-01-14 07:16:40', '2026-01-14 07:24:22'),
	(436, 11, 2804.00, '2024-09-22', '2024-09-27', '2026-01-14 07:16:40', '2026-01-14 07:24:22'),
	(437, 11, 2995.00, '2024-09-28', '2024-10-01', '2026-01-14 07:16:40', '2026-01-14 07:24:22'),
	(438, 11, 3280.00, '2024-10-02', '2024-10-05', '2026-01-14 07:16:40', '2026-01-14 07:24:22'),
	(440, 11, 3171.00, '2024-10-10', '2024-10-13', '2026-01-14 07:16:40', '2026-01-14 07:24:22'),
	(441, 11, 3414.00, '2024-10-14', NULL, '2026-01-14 07:16:40', '2026-01-14 07:24:22'),
	(442, 11, 2592.00, '2024-12-25', '2024-12-29', '2026-01-14 07:16:40', '2026-01-14 07:24:22'),
	(443, 11, 2780.00, '2024-12-30', '2025-01-03', '2026-01-14 07:16:40', '2026-01-14 07:24:22'),
	(444, 11, 3054.00, '2025-01-04', '2025-01-07', '2026-01-14 07:16:40', '2026-01-14 07:24:22'),
	(445, 11, 2755.00, '2025-01-08', '2025-01-12', '2026-01-14 07:16:40', '2026-01-14 07:24:22'),
	(446, 11, 2937.00, '2025-01-13', '2025-01-18', '2026-01-14 07:16:40', '2026-01-14 07:24:22'),
	(447, 11, 3135.00, '2025-01-19', '2025-01-24', '2026-01-14 07:16:40', '2026-01-14 07:24:22'),
	(448, 11, 2872.00, '2025-01-25', '2025-01-29', '2026-01-14 07:16:40', '2026-01-14 07:24:22'),
	(449, 11, 3138.00, '2025-01-30', '2025-02-04', '2026-01-14 07:16:40', '2026-01-14 07:24:22'),
	(450, 11, 2594.00, '2025-02-01', '2025-02-05', '2026-01-14 07:16:40', '2026-01-14 07:24:22'),
	(451, 11, 3369.00, '2025-02-05', NULL, '2026-01-14 07:16:40', '2026-01-14 07:24:22'),
	(452, 11, 2850.00, '2025-02-06', '2025-02-10', '2026-01-14 07:16:40', '2026-01-14 07:24:22'),
	(453, 11, 3073.00, '2025-02-11', '2025-02-16', '2026-01-14 07:16:40', '2026-01-14 07:24:22'),
	(454, 11, 2780.00, '2025-02-17', '2025-02-21', '2026-01-14 07:16:40', '2026-01-14 07:24:22'),
	(455, 11, 2979.00, '2025-02-22', '2025-02-27', '2026-01-14 07:16:40', '2026-01-14 07:24:22'),
	(456, 11, 3249.00, '2025-02-28', '2025-03-03', '2026-01-14 07:16:40', '2026-01-14 07:24:22'),
	(457, 11, 3064.00, '2025-03-04', '2025-03-07', '2026-01-14 07:16:40', '2026-01-14 07:24:22'),
	(459, 11, 3511.00, '2025-03-14', NULL, '2026-01-14 07:16:40', '2026-01-14 07:24:22'),
	(460, 11, 2568.00, '2025-07-01', '2025-07-04', '2026-01-14 07:16:40', '2026-01-14 07:24:22'),
	(461, 11, 2714.00, '2025-07-05', '2025-07-09', '2026-01-14 07:16:40', '2026-01-14 07:24:22'),
	(462, 11, 2918.00, '2025-07-10', '2025-07-15', '2026-01-14 07:16:40', '2026-01-14 07:24:22'),
	(463, 11, 2733.00, '2025-07-16', '2025-07-19', '2026-01-14 07:16:40', '2026-01-14 07:24:22'),
	(464, 11, 2966.00, '2025-07-20', '2025-07-23', '2026-01-14 07:16:40', '2026-01-14 07:24:22'),
	(465, 11, 3145.00, '2025-07-24', '2025-07-29', '2026-01-14 07:16:40', '2026-01-14 07:24:22'),
	(466, 11, 2926.00, '2025-07-30', '2025-08-04', '2026-01-14 07:16:40', '2026-01-14 07:24:22'),
	(467, 11, 3128.00, '2025-08-05', '2025-08-08', '2026-01-14 07:16:40', '2026-01-14 07:24:22'),
	(468, 11, 3403.00, '2025-08-09', NULL, '2026-01-14 07:16:40', '2026-01-14 07:24:22'),
	(469, 11, 2595.00, '2025-09-01', '2025-09-06', '2026-01-14 07:16:40', '2026-01-14 07:24:22'),
	(470, 11, 2729.00, '2025-09-07', '2025-09-10', '2026-01-14 07:16:40', '2026-01-14 07:24:22'),
	(471, 11, 2975.00, '2025-09-11', '2025-09-14', '2026-01-14 07:16:40', '2026-01-14 07:24:22'),
	(472, 11, 2801.00, '2025-09-15', '2025-09-18', '2026-01-14 07:16:40', '2026-01-14 07:24:22'),
	(473, 11, 3032.00, '2025-09-19', '2025-09-22', '2026-01-14 07:16:40', '2026-01-14 07:24:22'),
	(474, 11, 3257.00, '2025-09-23', '2025-09-26', '2026-01-14 07:16:40', '2026-01-14 07:24:22'),
	(475, 11, 3032.00, '2025-09-27', '2025-10-02', '2026-01-14 07:16:40', '2026-01-14 07:24:22'),
	(476, 11, 3192.00, '2025-10-03', '2025-10-07', '2026-01-14 07:16:40', '2026-01-14 07:24:22'),
	(478, 11, 2661.00, '2026-01-01', '2026-01-04', '2026-01-14 07:16:40', '2026-01-14 07:24:22'),
	(479, 11, 2926.00, '2026-01-05', '2026-01-09', '2026-01-14 07:16:40', '2026-01-14 07:24:22'),
	(480, 11, 3094.00, '2026-01-10', '2026-01-14', '2026-01-14 07:16:40', '2026-01-14 07:24:22'),
	(481, 11, 2880.00, '2026-01-15', '2026-01-20', '2026-01-14 07:16:40', '2026-01-14 07:24:22'),
	(482, 11, 3100.00, '2026-01-21', '2026-01-25', '2026-01-14 07:16:40', '2026-01-14 07:24:22'),
	(483, 11, 3328.00, '2026-01-26', '2026-01-29', '2026-01-14 07:16:40', '2026-01-14 07:24:22'),
	(484, 11, 3065.00, '2026-01-30', '2026-02-03', '2026-01-14 07:16:40', '2026-01-14 07:24:22'),
	(485, 11, 3258.00, '2026-02-04', '2026-02-07', '2026-01-14 07:16:40', '2026-01-14 07:24:22'),
	(486, 11, 3455.00, '2026-02-08', NULL, '2026-01-14 07:16:40', '2026-01-14 07:24:22'),
	(487, 12, 5466.00, '2024-09-09', '2024-09-14', '2026-01-14 07:16:40', '2026-01-14 07:24:23'),
	(488, 12, 5825.00, '2024-09-15', '2024-09-19', '2026-01-14 07:16:40', '2026-01-14 07:24:23'),
	(489, 12, 6335.00, '2024-09-20', '2024-09-25', '2026-01-14 07:16:40', '2026-01-14 07:24:23'),
	(490, 12, 5973.00, '2024-09-26', '2024-10-01', '2026-01-14 07:16:40', '2026-01-14 07:24:23'),
	(491, 12, 6530.00, '2024-10-02', '2024-10-06', '2026-01-14 07:16:40', '2026-01-14 07:24:23'),
	(492, 12, 7047.00, '2024-10-07', '2024-10-11', '2026-01-14 07:16:40', '2026-01-14 07:24:23'),
	(493, 12, 6598.00, '2024-10-12', '2024-10-16', '2026-01-14 07:16:40', '2026-01-14 07:24:23'),
	(494, 12, 7059.00, '2024-10-17', '2024-10-20', '2026-01-14 07:16:40', '2026-01-14 07:24:23'),
	(495, 12, 7552.00, '2024-10-21', NULL, '2026-01-14 07:16:40', '2026-01-14 07:24:23'),
	(497, 12, 5624.00, '2024-12-31', '2025-01-05', '2026-01-14 07:16:40', '2026-01-14 07:24:23'),
	(498, 12, 6065.00, '2025-01-06', '2025-01-10', '2026-01-14 07:16:40', '2026-01-14 07:24:23'),
	(499, 12, 5620.00, '2025-01-11', '2025-01-15', '2026-01-14 07:16:40', '2026-01-14 07:24:23'),
	(500, 12, 6052.00, '2025-01-16', '2025-01-19', '2026-01-14 07:16:40', '2026-01-14 07:24:23'),
	(501, 12, 6595.00, '2025-01-20', '2025-01-25', '2026-01-14 07:16:40', '2026-01-14 07:24:23'),
	(502, 12, 6193.00, '2025-01-26', '2025-01-30', '2026-01-14 07:16:40', '2026-01-14 07:24:23'),
	(503, 12, 6593.00, '2025-01-31', '2025-02-04', '2026-01-14 07:16:40', '2026-01-14 07:24:23'),
	(504, 12, 5388.00, '2025-02-01', '2025-02-05', '2026-01-14 07:16:40', '2026-01-14 07:24:23'),
	(505, 12, 7205.00, '2025-02-05', NULL, '2026-01-14 07:16:40', '2026-01-14 07:24:23'),
	(506, 12, 5738.00, '2025-02-06', '2025-02-11', '2026-01-14 07:16:40', '2026-01-14 07:24:23'),
	(507, 12, 6254.00, '2025-02-12', '2025-02-15', '2026-01-14 07:16:40', '2026-01-14 07:24:23'),
	(508, 12, 5922.00, '2025-02-16', '2025-02-19', '2026-01-14 07:16:40', '2026-01-14 07:24:23'),
	(509, 12, 6294.00, '2025-02-20', '2025-02-25', '2026-01-14 07:16:40', '2026-01-14 07:24:23'),
	(510, 12, 6886.00, '2025-02-26', '2025-03-01', '2026-01-14 07:16:40', '2026-01-14 07:24:23'),
	(511, 12, 6304.00, '2025-03-02', '2025-03-05', '2026-01-14 07:16:40', '2026-01-14 07:24:23'),
	(512, 12, 6896.00, '2025-03-06', '2025-03-10', '2026-01-14 07:16:40', '2026-01-14 07:24:23'),
	(513, 12, 7432.00, '2025-03-11', NULL, '2026-01-14 07:16:40', '2026-01-14 07:24:23'),
	(514, 12, 5402.00, '2025-07-01', '2025-07-04', '2026-01-14 07:16:40', '2026-01-14 07:24:23'),
	(516, 12, 6277.00, '2025-07-09', '2025-07-12', '2026-01-14 07:16:40', '2026-01-14 07:24:23'),
	(517, 12, 5787.00, '2025-07-13', '2025-07-16', '2026-01-14 07:16:40', '2026-01-14 07:24:23'),
	(518, 12, 6133.00, '2025-07-17', '2025-07-22', '2026-01-14 07:16:40', '2026-01-14 07:24:23'),
	(519, 12, 6475.00, '2025-07-23', '2025-07-26', '2026-01-14 07:16:41', '2026-01-14 07:24:23'),
	(520, 12, 5859.00, '2025-07-27', '2025-07-30', '2026-01-14 07:16:41', '2026-01-14 07:24:23'),
	(521, 12, 6224.00, '2025-07-31', '2025-08-05', '2026-01-14 07:16:41', '2026-01-14 07:24:23'),
	(522, 12, 6783.00, '2025-08-06', NULL, '2026-01-14 07:16:41', '2026-01-14 07:24:23'),
	(523, 12, 5298.00, '2025-09-01', '2025-09-04', '2026-01-14 07:16:41', '2026-01-14 07:24:23'),
	(524, 12, 5617.00, '2025-09-05', '2025-09-09', '2026-01-14 07:16:41', '2026-01-14 07:24:23'),
	(525, 12, 6114.00, '2025-09-10', '2025-09-15', '2026-01-14 07:16:41', '2026-01-14 07:24:23'),
	(526, 12, 5591.00, '2025-09-16', '2025-09-21', '2026-01-14 07:16:41', '2026-01-14 07:24:23'),
	(527, 12, 5976.00, '2025-09-22', '2025-09-27', '2026-01-14 07:16:41', '2026-01-14 07:24:23'),
	(528, 12, 6563.00, '2025-09-28', '2025-10-03', '2026-01-14 07:16:41', '2026-01-14 07:24:23'),
	(529, 12, 6122.00, '2025-10-04', '2025-10-08', '2026-01-14 07:16:41', '2026-01-14 07:24:23'),
	(530, 12, 6692.00, '2025-10-09', '2025-10-14', '2026-01-14 07:16:41', '2026-01-14 07:24:23'),
	(531, 12, 7319.00, '2025-10-15', NULL, '2026-01-14 07:16:41', '2026-01-14 07:24:23'),
	(532, 12, 5452.00, '2026-01-01', '2026-01-05', '2026-01-14 07:16:41', '2026-01-14 07:24:23'),
	(533, 12, 5855.00, '2026-01-06', '2026-01-10', '2026-01-14 07:16:41', '2026-01-14 07:24:23');
INSERT INTO public.medicine_prices VALUES
	(535, 12, 6015.00, '2026-01-17', '2026-01-22', '2026-01-14 07:16:41', '2026-01-14 07:24:23'),
	(557, 13, 539.00, '2025-02-01', '2025-02-06', '2026-01-14 07:16:41', '2026-01-14 07:24:23'),
	(558, 13, 582.00, '2025-02-07', '2025-02-11', '2026-01-14 07:16:41', '2026-01-14 07:24:23'),
	(610, 14, 125.00, '2025-02-01', '2025-02-04', '2026-01-14 07:16:41', '2026-01-14 07:24:24'),
	(537, 12, 7097.00, '2026-01-29', '2026-02-03', '2026-01-14 07:16:41', '2026-01-14 07:24:23'),
	(538, 12, 6649.00, '2026-02-04', '2026-02-07', '2026-01-14 07:16:41', '2026-01-14 07:24:23'),
	(539, 12, 7130.00, '2026-02-08', '2026-02-12', '2026-01-14 07:16:41', '2026-01-14 07:24:23'),
	(540, 12, 7787.00, '2026-02-13', NULL, '2026-01-14 07:16:41', '2026-01-14 07:24:23'),
	(541, 13, 526.00, '2024-09-09', '2024-09-14', '2026-01-14 07:16:41', '2026-01-14 07:24:23'),
	(542, 13, 561.00, '2024-09-15', '2024-09-19', '2026-01-14 07:16:41', '2026-01-14 07:24:23'),
	(544, 13, 558.00, '2024-09-24', '2024-09-29', '2026-01-14 07:16:41', '2026-01-14 07:24:23'),
	(545, 13, 608.00, '2024-09-30', '2024-10-05', '2026-01-14 07:16:41', '2026-01-14 07:24:23'),
	(546, 13, 647.00, '2024-10-06', '2024-10-10', '2026-01-14 07:16:41', '2026-01-14 07:24:23'),
	(547, 13, 591.00, '2024-10-11', '2024-10-15', '2026-01-14 07:16:41', '2026-01-14 07:24:23'),
	(548, 13, 621.00, '2024-10-16', '2024-10-20', '2026-01-14 07:16:41', '2026-01-14 07:24:23'),
	(549, 13, 670.00, '2024-10-21', NULL, '2026-01-14 07:16:41', '2026-01-14 07:24:23'),
	(550, 13, 547.00, '2024-12-25', '2024-12-30', '2026-01-14 07:16:41', '2026-01-14 07:24:23'),
	(551, 13, 595.00, '2024-12-31', '2025-01-05', '2026-01-14 07:16:41', '2026-01-14 07:24:23'),
	(552, 13, 651.00, '2025-01-06', '2025-01-11', '2026-01-14 07:16:41', '2026-01-14 07:24:23'),
	(553, 13, 617.00, '2025-01-12', '2025-01-15', '2026-01-14 07:16:41', '2026-01-14 07:24:23'),
	(554, 13, 648.00, '2025-01-16', '2025-01-20', '2026-01-14 07:16:41', '2026-01-14 07:24:23'),
	(555, 13, 707.00, '2025-01-21', '2025-01-25', '2026-01-14 07:16:41', '2026-01-14 07:24:23'),
	(556, 13, 659.00, '2025-01-26', '2025-01-31', '2026-01-14 07:16:41', '2026-01-14 07:24:23'),
	(559, 13, 618.00, '2025-02-12', '2025-02-17', '2026-01-14 07:16:41', '2026-01-14 07:24:23'),
	(560, 13, 567.00, '2025-02-18', '2025-02-23', '2026-01-14 07:16:41', '2026-01-14 07:24:23'),
	(561, 13, 599.00, '2025-02-24', '2025-02-27', '2026-01-14 07:16:41', '2026-01-14 07:24:23'),
	(562, 13, 636.00, '2025-02-28', '2025-03-03', '2026-01-14 07:16:41', '2026-01-14 07:24:23'),
	(563, 13, 583.00, '2025-03-04', '2025-03-08', '2026-01-14 07:16:41', '2026-01-14 07:24:23'),
	(565, 13, 670.00, '2025-03-14', NULL, '2026-01-14 07:16:41', '2026-01-14 07:24:23'),
	(566, 13, 529.00, '2025-07-01', '2025-07-06', '2026-01-14 07:16:41', '2026-01-14 07:24:23'),
	(567, 13, 575.00, '2025-07-07', '2025-07-11', '2026-01-14 07:16:41', '2026-01-14 07:24:23'),
	(568, 13, 626.00, '2025-07-12', '2025-07-15', '2026-01-14 07:16:41', '2026-01-14 07:24:23'),
	(569, 13, 580.00, '2025-07-16', '2025-07-19', '2026-01-14 07:16:41', '2026-01-14 07:24:23'),
	(570, 13, 624.00, '2025-07-20', '2025-07-25', '2026-01-14 07:16:41', '2026-01-14 07:24:23'),
	(571, 13, 664.00, '2025-07-26', '2025-07-29', '2026-01-14 07:16:41', '2026-01-14 07:24:23'),
	(572, 13, 615.00, '2025-07-30', '2025-08-02', '2026-01-14 07:16:41', '2026-01-14 07:24:23'),
	(573, 13, 649.00, '2025-08-03', '2025-08-06', '2026-01-14 07:16:41', '2026-01-14 07:24:23'),
	(574, 13, 696.00, '2025-08-07', NULL, '2026-01-14 07:16:41', '2026-01-14 07:24:23'),
	(575, 13, 526.00, '2025-09-01', '2025-09-05', '2026-01-14 07:16:41', '2026-01-14 07:24:23'),
	(576, 13, 557.00, '2025-09-06', '2025-09-10', '2026-01-14 07:16:41', '2026-01-14 07:24:23'),
	(577, 13, 594.00, '2025-09-11', '2025-09-16', '2026-01-14 07:16:41', '2026-01-14 07:24:23'),
	(578, 13, 535.00, '2025-09-17', '2025-09-21', '2026-01-14 07:16:41', '2026-01-14 07:24:23'),
	(579, 13, 561.00, '2025-09-22', '2025-09-27', '2026-01-14 07:16:41', '2026-01-14 07:24:23'),
	(580, 13, 607.00, '2025-09-28', '2025-10-01', '2026-01-14 07:16:41', '2026-01-14 07:24:23'),
	(581, 13, 567.00, '2025-10-02', '2025-10-06', '2026-01-14 07:16:41', '2026-01-14 07:24:23'),
	(582, 13, 615.00, '2025-10-07', '2025-10-11', '2026-01-14 07:16:41', '2026-01-14 07:24:23'),
	(584, 13, 541.00, '2026-01-01', '2026-01-04', '2026-01-14 07:16:41', '2026-01-14 07:24:23'),
	(585, 13, 588.00, '2026-01-05', '2026-01-09', '2026-01-14 07:16:41', '2026-01-14 07:24:23'),
	(586, 13, 625.00, '2026-01-10', '2026-01-15', '2026-01-14 07:16:41', '2026-01-14 07:24:23'),
	(587, 13, 593.00, '2026-01-16', '2026-01-20', '2026-01-14 07:16:41', '2026-01-14 07:24:23'),
	(588, 13, 648.00, '2026-01-21', '2026-01-26', '2026-01-14 07:16:41', '2026-01-14 07:24:23'),
	(589, 13, 689.00, '2026-01-27', '2026-01-31', '2026-01-14 07:16:41', '2026-01-14 07:24:23'),
	(590, 13, 638.00, '2026-02-01', '2026-02-05', '2026-01-14 07:16:41', '2026-01-14 07:24:23'),
	(591, 13, 683.00, '2026-02-06', '2026-02-09', '2026-01-14 07:16:41', '2026-01-14 07:24:23'),
	(592, 13, 747.00, '2026-02-10', NULL, '2026-01-14 07:16:41', '2026-01-14 07:24:23'),
	(593, 14, 128.00, '2024-09-09', '2024-09-13', '2026-01-14 07:16:41', '2026-01-14 07:24:24'),
	(594, 14, 136.00, '2024-09-14', '2024-09-18', '2026-01-14 07:16:41', '2026-01-14 07:24:24'),
	(595, 14, 143.00, '2024-09-19', '2024-09-23', '2026-01-14 07:16:41', '2026-01-14 07:24:24'),
	(596, 14, 129.00, '2024-09-24', '2024-09-29', '2026-01-14 07:16:41', '2026-01-14 07:24:24'),
	(597, 14, 137.00, '2024-09-30', '2024-10-05', '2026-01-14 07:16:41', '2026-01-14 07:24:24'),
	(598, 14, 148.00, '2024-10-06', '2024-10-10', '2026-01-14 07:16:41', '2026-01-14 07:24:24'),
	(599, 14, 139.00, '2024-10-11', '2024-10-16', '2026-01-14 07:16:41', '2026-01-14 07:24:24'),
	(600, 14, 145.00, '2024-10-17', '2024-10-21', '2026-01-14 07:16:41', '2026-01-14 07:24:24'),
	(601, 14, 157.00, '2024-10-22', NULL, '2026-01-14 07:16:41', '2026-01-14 07:24:24'),
	(603, 14, 140.00, '2024-12-29', '2025-01-02', '2026-01-14 07:16:41', '2026-01-14 07:24:24'),
	(604, 14, 153.00, '2025-01-03', '2025-01-07', '2026-01-14 07:16:41', '2026-01-14 07:24:24'),
	(605, 14, 145.00, '2025-01-08', '2025-01-11', '2026-01-14 07:16:41', '2026-01-14 07:24:24'),
	(606, 14, 153.00, '2025-01-12', '2025-01-17', '2026-01-14 07:16:41', '2026-01-14 07:24:24'),
	(607, 14, 164.00, '2025-01-18', '2025-01-21', '2026-01-14 07:16:41', '2026-01-14 07:24:24'),
	(608, 14, 150.00, '2025-01-22', '2025-01-27', '2026-01-14 07:16:41', '2026-01-14 07:24:24'),
	(609, 14, 163.00, '2025-01-28', '2025-01-31', '2026-01-14 07:16:41', '2026-01-14 07:24:24'),
	(611, 14, 134.00, '2025-02-05', '2025-02-08', '2026-01-14 07:16:41', '2026-01-14 07:24:24'),
	(612, 14, 145.00, '2025-02-09', '2025-02-12', '2026-01-14 07:16:41', '2026-01-14 07:24:24'),
	(613, 14, 136.00, '2025-02-13', '2025-02-16', '2026-01-14 07:16:41', '2026-01-14 07:24:24'),
	(614, 14, 143.00, '2025-02-17', '2025-02-20', '2026-01-14 07:16:41', '2026-01-14 07:24:24'),
	(615, 14, 156.00, '2025-02-21', '2025-02-25', '2026-01-14 07:16:42', '2026-01-14 07:24:24'),
	(616, 14, 149.00, '2025-02-26', '2025-03-02', '2026-01-14 07:16:42', '2026-01-14 07:24:24'),
	(617, 14, 162.00, '2025-03-03', '2025-03-07', '2026-01-14 07:16:42', '2026-01-14 07:24:24'),
	(618, 14, 172.00, '2025-03-08', NULL, '2026-01-14 07:16:42', '2026-01-14 07:24:24'),
	(619, 14, 129.00, '2025-07-01', '2025-07-04', '2026-01-14 07:16:42', '2026-01-14 07:24:24'),
	(620, 14, 137.00, '2025-07-05', '2025-07-08', '2026-01-14 07:16:42', '2026-01-14 07:24:24'),
	(621, 14, 148.00, '2025-07-09', '2025-07-13', '2026-01-14 07:16:42', '2026-01-14 07:24:24'),
	(623, 14, 151.00, '2025-07-18', '2025-07-21', '2026-01-14 07:16:42', '2026-01-14 07:24:24'),
	(624, 14, 164.00, '2025-07-22', '2025-07-27', '2026-01-14 07:16:42', '2026-01-14 07:24:24'),
	(625, 14, 151.00, '2025-07-28', '2025-08-02', '2026-01-14 07:16:42', '2026-01-14 07:24:24'),
	(626, 14, 163.00, '2025-08-03', '2025-08-07', '2026-01-14 07:16:42', '2026-01-14 07:24:24'),
	(627, 14, 175.00, '2025-08-08', NULL, '2026-01-14 07:16:42', '2026-01-14 07:24:24'),
	(628, 14, 128.00, '2025-09-01', '2025-09-05', '2026-01-14 07:16:42', '2026-01-14 07:24:24'),
	(629, 14, 136.00, '2025-09-06', '2025-09-09', '2026-01-14 07:16:42', '2026-01-14 07:24:24'),
	(630, 14, 145.00, '2025-09-10', '2025-09-13', '2026-01-14 07:16:42', '2026-01-14 07:24:24'),
	(631, 14, 136.00, '2025-09-14', '2025-09-19', '2026-01-14 07:16:42', '2026-01-14 07:24:24'),
	(632, 14, 148.00, '2025-09-20', '2025-09-23', '2026-01-14 07:16:42', '2026-01-14 07:24:24'),
	(633, 14, 162.00, '2025-09-24', '2025-09-27', '2026-01-14 07:16:42', '2026-01-14 07:24:24'),
	(634, 14, 150.00, '2025-09-28', '2025-10-01', '2026-01-14 07:16:42', '2026-01-14 07:24:24'),
	(635, 14, 162.00, '2025-10-02', '2025-10-05', '2026-01-14 07:16:42', '2026-01-14 07:24:24'),
	(636, 14, 170.00, '2025-10-06', NULL, '2026-01-14 07:16:42', '2026-01-14 07:24:24'),
	(637, 14, 125.00, '2026-01-01', '2026-01-04', '2026-01-14 07:16:42', '2026-01-14 07:24:24'),
	(638, 14, 136.00, '2026-01-05', '2026-01-09', '2026-01-14 07:16:42', '2026-01-14 07:24:24'),
	(639, 14, 147.00, '2026-01-10', '2026-01-13', '2026-01-14 07:16:42', '2026-01-14 07:24:24'),
	(640, 14, 133.00, '2026-01-14', '2026-01-18', '2026-01-14 07:16:42', '2026-01-14 07:24:24'),
	(642, 14, 151.00, '2026-01-24', '2026-01-28', '2026-01-14 07:16:42', '2026-01-14 07:24:24'),
	(662, 15, 330.00, '2025-02-01', '2025-02-05', '2026-01-14 07:16:42', '2026-01-14 07:24:24'),
	(644, 14, 146.00, '2026-02-02', '2026-02-06', '2026-01-14 07:16:42', '2026-01-14 07:24:24'),
	(645, 14, 153.00, '2026-02-07', NULL, '2026-01-14 07:16:42', '2026-01-14 07:24:24'),
	(646, 15, 331.00, '2024-09-09', '2024-09-13', '2026-01-14 07:16:42', '2026-01-14 07:24:24'),
	(647, 15, 361.00, '2024-09-14', '2024-09-19', '2026-01-14 07:16:42', '2026-01-14 07:24:24'),
	(648, 15, 383.00, '2024-09-20', '2024-09-24', '2026-01-14 07:16:42', '2026-01-14 07:24:24'),
	(649, 15, 364.00, '2024-09-25', '2024-09-30', '2026-01-14 07:16:42', '2026-01-14 07:24:24'),
	(650, 15, 398.00, '2024-10-01', '2024-10-05', '2026-01-14 07:16:42', '2026-01-14 07:24:24'),
	(651, 15, 426.00, '2024-10-06', '2024-10-10', '2026-01-14 07:16:42', '2026-01-14 07:24:24'),
	(653, 15, 425.00, '2024-10-15', '2024-10-20', '2026-01-14 07:16:42', '2026-01-14 07:24:24'),
	(654, 15, 463.00, '2024-10-21', NULL, '2026-01-14 07:16:42', '2026-01-14 07:24:24'),
	(655, 15, 335.00, '2024-12-25', '2024-12-30', '2026-01-14 07:16:42', '2026-01-14 07:24:24'),
	(656, 15, 365.00, '2024-12-31', '2025-01-05', '2026-01-14 07:16:42', '2026-01-14 07:24:24'),
	(657, 15, 399.00, '2025-01-06', '2025-01-11', '2026-01-14 07:16:42', '2026-01-14 07:24:24'),
	(658, 15, 380.00, '2025-01-12', '2025-01-17', '2026-01-14 07:16:42', '2026-01-14 07:24:24'),
	(659, 15, 410.00, '2025-01-18', '2025-01-21', '2026-01-14 07:16:42', '2026-01-14 07:24:24'),
	(660, 15, 442.00, '2025-01-22', '2025-01-27', '2026-01-14 07:16:42', '2026-01-14 07:24:24'),
	(661, 15, 415.00, '2025-01-28', '2025-01-31', '2026-01-14 07:16:42', '2026-01-14 07:24:24'),
	(663, 15, 360.00, '2025-02-06', '2025-02-10', '2026-01-14 07:16:42', '2026-01-14 07:24:24'),
	(664, 15, 488.00, '2025-02-07', NULL, '2026-01-14 07:16:42', '2026-01-14 07:24:24'),
	(665, 15, 392.00, '2025-02-11', '2025-02-16', '2026-01-14 07:16:42', '2026-01-14 07:24:24'),
	(666, 15, 373.00, '2025-02-17', '2025-02-20', '2026-01-14 07:16:42', '2026-01-14 07:24:24'),
	(667, 15, 402.00, '2025-02-21', '2025-02-24', '2026-01-14 07:16:42', '2026-01-14 07:24:24'),
	(668, 15, 430.00, '2025-02-25', '2025-02-28', '2026-01-14 07:16:42', '2026-01-14 07:24:24'),
	(669, 15, 404.00, '2025-03-01', '2025-03-06', '2026-01-14 07:16:42', '2026-01-14 07:24:24'),
	(670, 15, 444.00, '2025-03-07', '2025-03-11', '2026-01-14 07:16:42', '2026-01-14 07:24:24'),
	(671, 15, 466.00, '2025-03-12', NULL, '2026-01-14 07:16:42', '2026-01-14 07:24:24'),
	(673, 15, 348.00, '2025-07-07', '2025-07-12', '2026-01-14 07:16:42', '2026-01-14 07:24:24'),
	(674, 15, 375.00, '2025-07-13', '2025-07-18', '2026-01-14 07:16:42', '2026-01-14 07:24:24'),
	(675, 15, 348.00, '2025-07-19', '2025-07-22', '2026-01-14 07:16:42', '2026-01-14 07:24:24'),
	(676, 15, 374.00, '2025-07-23', '2025-07-26', '2026-01-14 07:16:42', '2026-01-14 07:24:24'),
	(677, 15, 398.00, '2025-07-27', '2025-07-30', '2026-01-14 07:16:42', '2026-01-14 07:24:24'),
	(678, 15, 365.00, '2025-07-31', '2025-08-05', '2026-01-14 07:16:42', '2026-01-14 07:24:24'),
	(679, 15, 384.00, '2025-08-06', '2025-08-10', '2026-01-14 07:16:42', '2026-01-14 07:24:24'),
	(680, 15, 419.00, '2025-08-11', NULL, '2026-01-14 07:16:42', '2026-01-14 07:24:24'),
	(681, 15, 333.00, '2025-09-01', '2025-09-04', '2026-01-14 07:16:42', '2026-01-14 07:24:24'),
	(682, 15, 354.00, '2025-09-05', '2025-09-08', '2026-01-14 07:16:42', '2026-01-14 07:24:24'),
	(683, 15, 383.00, '2025-09-09', '2025-09-12', '2026-01-14 07:16:42', '2026-01-14 07:24:24'),
	(684, 15, 364.00, '2025-09-13', '2025-09-17', '2026-01-14 07:16:42', '2026-01-14 07:24:24'),
	(685, 15, 398.00, '2025-09-18', '2025-09-23', '2026-01-14 07:16:42', '2026-01-14 07:24:24'),
	(686, 15, 418.00, '2025-09-24', '2025-09-29', '2026-01-14 07:16:42', '2026-01-14 07:24:24'),
	(687, 15, 390.00, '2025-09-30', '2025-10-03', '2026-01-14 07:16:42', '2026-01-14 07:24:24'),
	(688, 15, 425.00, '2025-10-04', '2025-10-07', '2026-01-14 07:16:42', '2026-01-14 07:24:24'),
	(689, 15, 455.00, '2025-10-08', NULL, '2026-01-14 07:16:42', '2026-01-14 07:24:24'),
	(690, 15, 327.00, '2026-01-01', '2026-01-04', '2026-01-14 07:16:42', '2026-01-14 07:24:24'),
	(692, 15, 375.00, '2026-01-09', '2026-01-12', '2026-01-14 07:16:42', '2026-01-14 07:24:24'),
	(693, 15, 339.00, '2026-01-13', '2026-01-17', '2026-01-14 07:16:42', '2026-01-14 07:24:24'),
	(694, 15, 364.00, '2026-01-18', '2026-01-21', '2026-01-14 07:16:42', '2026-01-14 07:24:24'),
	(695, 15, 382.00, '2026-01-22', '2026-01-27', '2026-01-14 07:16:42', '2026-01-14 07:24:24'),
	(696, 15, 361.00, '2026-01-28', '2026-02-02', '2026-01-14 07:16:42', '2026-01-14 07:24:24'),
	(697, 15, 383.00, '2026-02-03', '2026-02-08', '2026-01-14 07:16:42', '2026-01-14 07:24:24'),
	(698, 15, 407.00, '2026-02-09', NULL, '2026-01-14 07:16:42', '2026-01-14 07:24:24'),
	(699, 16, 2489.00, '2024-09-09', '2024-09-13', '2026-01-14 07:16:42', '2026-01-14 07:24:25'),
	(700, 16, 2705.00, '2024-09-14', '2024-09-17', '2026-01-14 07:16:42', '2026-01-14 07:24:25'),
	(701, 16, 2862.00, '2024-09-18', '2024-09-22', '2026-01-14 07:16:42', '2026-01-14 07:24:25'),
	(702, 16, 2639.00, '2024-09-23', '2024-09-28', '2026-01-14 07:16:42', '2026-01-14 07:24:25'),
	(703, 16, 2847.00, '2024-09-29', '2024-10-04', '2026-01-14 07:16:42', '2026-01-14 07:24:25'),
	(704, 16, 3024.00, '2024-10-05', '2024-10-08', '2026-01-14 07:16:42', '2026-01-14 07:24:25'),
	(705, 16, 2821.00, '2024-10-09', '2024-10-12', '2026-01-14 07:16:42', '2026-01-14 07:24:25'),
	(706, 16, 3001.00, '2024-10-13', '2024-10-18', '2026-01-14 07:16:42', '2026-01-14 07:24:25'),
	(707, 16, 3215.00, '2024-10-19', NULL, '2026-01-14 07:16:42', '2026-01-14 07:24:25'),
	(708, 16, 2419.00, '2024-12-25', '2024-12-28', '2026-01-14 07:16:42', '2026-01-14 07:24:25'),
	(709, 16, 2547.00, '2024-12-29', '2025-01-02', '2026-01-14 07:16:42', '2026-01-14 07:24:25'),
	(711, 16, 2449.00, '2025-01-09', '2025-01-12', '2026-01-14 07:16:42', '2026-01-14 07:24:25'),
	(712, 16, 2616.00, '2025-01-13', '2025-01-17', '2026-01-14 07:16:42', '2026-01-14 07:24:25'),
	(713, 16, 2867.00, '2025-01-18', '2025-01-21', '2026-01-14 07:16:42', '2026-01-14 07:24:25'),
	(714, 16, 2691.00, '2025-01-22', '2025-01-27', '2026-01-14 07:16:42', '2026-01-14 07:24:25'),
	(715, 16, 2855.00, '2025-01-28', '2025-02-01', '2026-01-14 07:16:42', '2026-01-14 07:24:25'),
	(716, 16, 2516.00, '2025-02-01', '2025-02-06', '2026-01-14 07:16:42', '2026-01-14 07:24:25'),
	(717, 16, 3085.00, '2025-02-02', NULL, '2026-01-14 07:16:42', '2026-01-14 07:24:25'),
	(718, 16, 2720.00, '2025-02-07', '2025-02-11', '2026-01-14 07:16:42', '2026-01-14 07:24:25'),
	(719, 16, 2900.00, '2025-02-12', '2025-02-16', '2026-01-14 07:16:42', '2026-01-14 07:24:25'),
	(720, 16, 2719.00, '2025-02-17', '2025-02-20', '2026-01-14 07:16:42', '2026-01-14 07:24:25'),
	(721, 16, 2891.00, '2025-02-21', '2025-02-25', '2026-01-14 07:16:42', '2026-01-14 07:24:25'),
	(722, 16, 3137.00, '2025-02-26', '2025-03-03', '2026-01-14 07:16:42', '2026-01-14 07:24:25'),
	(723, 16, 2976.00, '2025-03-04', '2025-03-08', '2026-01-14 07:16:42', '2026-01-14 07:24:25'),
	(724, 16, 3158.00, '2025-03-09', '2025-03-13', '2026-01-14 07:16:42', '2026-01-14 07:24:25'),
	(725, 16, 3458.00, '2025-03-14', NULL, '2026-01-14 07:16:42', '2026-01-14 07:24:25'),
	(726, 16, 2467.00, '2025-07-01', '2025-07-05', '2026-01-14 07:16:43', '2026-01-14 07:24:25'),
	(727, 16, 2624.00, '2025-07-06', '2025-07-09', '2026-01-14 07:16:43', '2026-01-14 07:24:25'),
	(728, 16, 2796.00, '2025-07-10', '2025-07-14', '2026-01-14 07:16:43', '2026-01-14 07:24:25'),
	(730, 16, 2738.00, '2025-07-19', '2025-07-23', '2026-01-14 07:16:43', '2026-01-14 07:24:25'),
	(731, 16, 2898.00, '2025-07-24', '2025-07-28', '2026-01-14 07:16:43', '2026-01-14 07:24:25'),
	(732, 16, 2660.00, '2025-07-29', '2025-08-01', '2026-01-14 07:16:43', '2026-01-14 07:24:25'),
	(733, 16, 2815.00, '2025-08-02', '2025-08-06', '2026-01-14 07:16:43', '2026-01-14 07:24:25'),
	(734, 16, 2976.00, '2025-08-07', NULL, '2026-01-14 07:16:43', '2026-01-14 07:24:25'),
	(735, 16, 2465.00, '2025-09-01', '2025-09-04', '2026-01-14 07:16:43', '2026-01-14 07:24:25'),
	(736, 16, 2711.00, '2025-09-05', '2025-09-10', '2026-01-14 07:16:43', '2026-01-14 07:24:25'),
	(737, 16, 2857.00, '2025-09-11', '2025-09-16', '2026-01-14 07:16:43', '2026-01-14 07:24:25'),
	(738, 16, 2667.00, '2025-09-17', '2025-09-21', '2026-01-14 07:16:43', '2026-01-14 07:24:25'),
	(739, 16, 2844.00, '2025-09-22', '2025-09-25', '2026-01-14 07:16:43', '2026-01-14 07:24:25'),
	(740, 16, 3067.00, '2025-09-26', '2025-10-01', '2026-01-14 07:16:43', '2026-01-14 07:24:25'),
	(741, 16, 2837.00, '2025-10-02', '2025-10-07', '2026-01-14 07:16:43', '2026-01-14 07:24:25'),
	(742, 16, 3041.00, '2025-10-08', '2025-10-13', '2026-01-14 07:16:43', '2026-01-14 07:24:25'),
	(743, 16, 3336.00, '2025-10-14', NULL, '2026-01-14 07:16:43', '2026-01-14 07:24:25'),
	(744, 16, 2427.00, '2026-01-01', '2026-01-04', '2026-01-14 07:16:43', '2026-01-14 07:24:25'),
	(745, 16, 2662.00, '2026-01-05', '2026-01-10', '2026-01-14 07:16:43', '2026-01-14 07:24:25'),
	(746, 16, 2797.00, '2026-01-11', '2026-01-14', '2026-01-14 07:16:43', '2026-01-14 07:24:25'),
	(747, 16, 2603.00, '2026-01-15', '2026-01-18', '2026-01-14 07:16:43', '2026-01-14 07:24:25'),
	(749, 16, 2945.00, '2026-01-25', '2026-01-29', '2026-01-14 07:16:43', '2026-01-14 07:24:25'),
	(3, 3, 4574.00, '2024-09-09', '2024-09-13', '2026-01-14 07:16:36', '2026-01-14 07:24:18'),
	(13, 3, 4985.00, '2024-12-30', '2025-01-04', '2026-01-14 07:16:36', '2026-01-14 07:24:18'),
	(32, 3, 5497.00, '2025-07-11', '2025-07-16', '2026-01-14 07:16:36', '2026-01-14 07:24:18'),
	(51, 3, 4691.00, '2026-01-16', '2026-01-19', '2026-01-14 07:16:36', '2026-01-14 07:24:18'),
	(70, 4, 6362.00, '2025-01-12', '2025-01-15', '2026-01-14 07:16:37', '2026-01-14 07:24:18'),
	(89, 4, 6174.00, '2025-07-26', '2025-07-29', '2026-01-14 07:16:37', '2026-01-14 07:24:19'),
	(108, 4, 6657.00, '2026-02-02', '2026-02-07', '2026-01-14 07:16:37', '2026-01-14 07:24:19'),
	(117, 5, 998.00, '2024-10-07', '2024-10-10', '2026-01-14 07:16:37', '2026-01-14 07:24:19'),
	(136, 5, 1034.00, '2025-03-06', '2025-03-11', '2026-01-14 07:16:37', '2026-01-14 07:24:19'),
	(155, 5, 1098.00, '2025-10-10', NULL, '2026-01-14 07:16:37', '2026-01-14 07:24:19'),
	(174, 6, 5056.00, '2024-12-25', '2024-12-29', '2026-01-14 07:16:38', '2026-01-14 07:24:19'),
	(194, 6, 5394.00, '2025-07-17', '2025-07-20', '2026-01-14 07:16:38', '2026-01-14 07:24:20'),
	(213, 6, 5809.00, '2026-01-21', '2026-01-25', '2026-01-14 07:16:38', '2026-01-14 07:24:20'),
	(215, 6, 5815.00, '2026-01-31', '2026-02-05', '2026-01-14 07:16:38', '2026-01-14 07:24:20'),
	(225, 7, 17175.00, '2024-10-15', '2024-10-18', '2026-01-14 07:16:38', '2026-01-14 07:24:20'),
	(244, 7, 20000.00, '2025-03-15', NULL, '2026-01-14 07:16:38', '2026-01-14 07:24:20'),
	(263, 7, 14390.00, '2026-01-01', '2026-01-04', '2026-01-14 07:16:38', '2026-01-14 07:24:20'),
	(282, 8, 6996.00, '2024-12-31', '2025-01-04', '2026-01-14 07:16:39', '2026-01-14 07:24:20'),
	(301, 8, 7450.00, '2025-07-11', '2025-07-16', '2026-01-14 07:16:39', '2026-01-14 07:24:20'),
	(320, 8, 6687.00, '2026-01-16', '2026-01-21', '2026-01-14 07:16:39', '2026-01-14 07:24:20'),
	(322, 8, 7798.00, '2026-01-28', '2026-01-31', '2026-01-14 07:16:39', '2026-01-14 07:24:20'),
	(331, 9, 5425.00, '2024-10-04', '2024-10-08', '2026-01-14 07:16:39', '2026-01-14 07:24:21'),
	(351, 9, 6000.00, '2025-03-15', NULL, '2026-01-14 07:16:39', '2026-01-14 07:24:21'),
	(370, 9, 4429.00, '2026-01-01', '2026-01-04', '2026-01-14 07:16:39', '2026-01-14 07:24:21'),
	(389, 10, 2274.00, '2024-12-29', '2025-01-02', '2026-01-14 07:16:39', '2026-01-14 07:24:22'),
	(408, 10, 2346.00, '2025-07-11', '2025-07-16', '2026-01-14 07:16:39', '2026-01-14 07:24:22'),
	(427, 10, 2304.00, '2026-01-13', '2026-01-17', '2026-01-14 07:16:40', '2026-01-14 07:24:22'),
	(429, 10, 2589.00, '2026-01-22', '2026-01-27', '2026-01-14 07:16:40', '2026-01-14 07:24:22'),
	(439, 11, 2987.00, '2024-10-06', '2024-10-09', '2026-01-14 07:16:40', '2026-01-14 07:24:22'),
	(458, 11, 3308.00, '2025-03-08', '2025-03-13', '2026-01-14 07:16:40', '2026-01-14 07:24:22'),
	(477, 11, 3397.00, '2025-10-08', NULL, '2026-01-14 07:16:40', '2026-01-14 07:24:22'),
	(496, 12, 5354.00, '2024-12-25', '2024-12-30', '2026-01-14 07:16:40', '2026-01-14 07:24:23'),
	(515, 12, 5838.00, '2025-07-05', '2025-07-08', '2026-01-14 07:16:40', '2026-01-14 07:24:23'),
	(534, 12, 6364.00, '2026-01-11', '2026-01-16', '2026-01-14 07:16:41', '2026-01-14 07:24:23'),
	(536, 12, 6499.00, '2026-01-23', '2026-01-28', '2026-01-14 07:16:41', '2026-01-14 07:24:23'),
	(543, 13, 600.00, '2024-09-20', '2024-09-23', '2026-01-14 07:16:41', '2026-01-14 07:24:23'),
	(564, 13, 614.00, '2025-03-09', '2025-03-13', '2026-01-14 07:16:41', '2026-01-14 07:24:23'),
	(583, 13, 676.00, '2025-10-12', NULL, '2026-01-14 07:16:41', '2026-01-14 07:24:23'),
	(602, 14, 128.00, '2024-12-25', '2024-12-28', '2026-01-14 07:16:41', '2026-01-14 07:24:24'),
	(622, 14, 138.00, '2025-07-14', '2025-07-17', '2026-01-14 07:16:42', '2026-01-14 07:24:24'),
	(641, 14, 142.00, '2026-01-19', '2026-01-23', '2026-01-14 07:16:42', '2026-01-14 07:24:24'),
	(643, 14, 137.00, '2026-01-29', '2026-02-01', '2026-01-14 07:16:42', '2026-01-14 07:24:24'),
	(652, 15, 405.00, '2024-10-11', '2024-10-14', '2026-01-14 07:16:42', '2026-01-14 07:24:24'),
	(672, 15, 325.00, '2025-07-01', '2025-07-06', '2026-01-14 07:16:42', '2026-01-14 07:24:24'),
	(691, 15, 345.00, '2026-01-05', '2026-01-08', '2026-01-14 07:16:42', '2026-01-14 07:24:24'),
	(710, 16, 2694.00, '2025-01-03', '2025-01-08', '2026-01-14 07:16:42', '2026-01-14 07:24:25'),
	(729, 16, 2572.00, '2025-07-15', '2025-07-18', '2026-01-14 07:16:43', '2026-01-14 07:24:25'),
	(748, 16, 2742.00, '2026-01-19', '2026-01-24', '2026-01-14 07:16:43', '2026-01-14 07:24:25'),
	(750, 16, 2654.00, '2026-01-30', '2026-02-04', '2026-01-14 07:16:43', '2026-01-14 07:24:25');
INSERT INTO public.medicine_prices VALUES
	(751, 16, 2917.00, '2026-02-05', '2026-02-09', '2026-01-14 07:16:43', '2026-01-14 07:24:25'),
	(752, 16, 3169.00, '2026-02-10', NULL, '2026-01-14 07:16:43', '2026-01-14 07:24:25'),
	(753, 17, 3081.00, '2024-09-09', '2024-09-12', '2026-01-14 07:16:43', '2026-01-14 07:24:25'),
	(754, 17, 3365.00, '2024-09-13', '2024-09-16', '2026-01-14 07:16:43', '2026-01-14 07:24:25'),
	(755, 17, 3563.00, '2024-09-17', '2024-09-22', '2026-01-14 07:16:43', '2026-01-14 07:24:25'),
	(756, 17, 3298.00, '2024-09-23', '2024-09-28', '2026-01-14 07:16:43', '2026-01-14 07:24:25'),
	(757, 17, 3485.00, '2024-09-29', '2024-10-03', '2026-01-14 07:16:43', '2026-01-14 07:24:25'),
	(758, 17, 3817.00, '2024-10-04', '2024-10-08', '2026-01-14 07:16:43', '2026-01-14 07:24:25'),
	(759, 17, 3587.00, '2024-10-09', '2024-10-13', '2026-01-14 07:16:43', '2026-01-14 07:24:25'),
	(760, 17, 3916.00, '2024-10-14', '2024-10-19', '2026-01-14 07:16:43', '2026-01-14 07:24:25'),
	(761, 17, 4162.00, '2024-10-20', NULL, '2026-01-14 07:16:43', '2026-01-14 07:24:25'),
	(762, 17, 3061.00, '2024-12-25', '2024-12-29', '2026-01-14 07:16:43', '2026-01-14 07:24:25'),
	(763, 17, 3339.00, '2024-12-30', '2025-01-04', '2026-01-14 07:16:43', '2026-01-14 07:24:25'),
	(764, 17, 3596.00, '2025-01-05', '2025-01-09', '2026-01-14 07:16:43', '2026-01-14 07:24:25'),
	(765, 17, 3296.00, '2025-01-10', '2025-01-14', '2026-01-14 07:16:43', '2026-01-14 07:24:25'),
	(766, 17, 3554.00, '2025-01-15', '2025-01-18', '2026-01-14 07:16:43', '2026-01-14 07:24:25'),
	(767, 17, 3800.00, '2025-01-19', '2025-01-23', '2026-01-14 07:16:43', '2026-01-14 07:24:25'),
	(768, 17, 3575.00, '2025-01-24', '2025-01-28', '2026-01-14 07:16:43', '2026-01-14 07:24:25'),
	(769, 17, 3898.00, '2025-01-29', '2025-02-03', '2026-01-14 07:16:43', '2026-01-14 07:24:25'),
	(770, 17, 3070.00, '2025-02-01', '2025-02-05', '2026-01-14 07:16:43', '2026-01-14 07:24:25'),
	(771, 17, 4155.00, '2025-02-04', NULL, '2026-01-14 07:16:43', '2026-01-14 07:24:25'),
	(772, 17, 3282.00, '2025-02-06', '2025-02-10', '2026-01-14 07:16:43', '2026-01-14 07:24:25'),
	(773, 17, 3520.00, '2025-02-11', '2025-02-15', '2026-01-14 07:16:43', '2026-01-14 07:24:25'),
	(774, 17, 3283.00, '2025-02-16', '2025-02-20', '2026-01-14 07:16:43', '2026-01-14 07:24:25'),
	(775, 17, 3567.00, '2025-02-21', '2025-02-25', '2026-01-14 07:16:43', '2026-01-14 07:24:25'),
	(776, 17, 3919.00, '2025-02-26', '2025-03-01', '2026-01-14 07:16:43', '2026-01-14 07:24:25'),
	(777, 17, 3563.00, '2025-03-02', '2025-03-06', '2026-01-14 07:16:43', '2026-01-14 07:24:25'),
	(778, 17, 3830.00, '2025-03-07', '2025-03-10', '2026-01-14 07:16:43', '2026-01-14 07:24:25'),
	(780, 17, 3083.00, '2025-07-01', '2025-07-05', '2026-01-14 07:16:43', '2026-01-14 07:24:25'),
	(781, 17, 3379.00, '2025-07-06', '2025-07-09', '2026-01-14 07:16:43', '2026-01-14 07:24:25'),
	(782, 17, 3652.00, '2025-07-10', '2025-07-15', '2026-01-14 07:16:43', '2026-01-14 07:24:25'),
	(783, 17, 3390.00, '2025-07-16', '2025-07-20', '2026-01-14 07:16:43', '2026-01-14 07:24:25'),
	(784, 17, 3587.00, '2025-07-21', '2025-07-24', '2026-01-14 07:16:43', '2026-01-14 07:24:25'),
	(785, 17, 3854.00, '2025-07-25', '2025-07-30', '2026-01-14 07:16:43', '2026-01-14 07:24:25'),
	(786, 17, 3555.00, '2025-07-31', '2025-08-04', '2026-01-14 07:16:43', '2026-01-14 07:24:25'),
	(787, 17, 3808.00, '2025-08-05', '2025-08-10', '2026-01-14 07:16:43', '2026-01-14 07:24:25'),
	(788, 17, 4020.00, '2025-08-11', NULL, '2026-01-14 07:16:43', '2026-01-14 07:24:25'),
	(789, 17, 3136.00, '2025-09-01', '2025-09-04', '2026-01-14 07:16:43', '2026-01-14 07:24:25'),
	(790, 17, 3307.00, '2025-09-05', '2025-09-10', '2026-01-14 07:16:43', '2026-01-14 07:24:25'),
	(791, 17, 3533.00, '2025-09-11', '2025-09-14', '2026-01-14 07:16:43', '2026-01-14 07:24:25'),
	(792, 17, 3219.00, '2025-09-15', '2025-09-18', '2026-01-14 07:16:43', '2026-01-14 07:24:25'),
	(793, 17, 3386.00, '2025-09-19', '2025-09-23', '2026-01-14 07:16:43', '2026-01-14 07:24:25'),
	(794, 17, 3672.00, '2025-09-24', '2025-09-29', '2026-01-14 07:16:43', '2026-01-14 07:24:25'),
	(795, 17, 3323.00, '2025-09-30', '2025-10-05', '2026-01-14 07:16:43', '2026-01-14 07:24:25'),
	(796, 17, 3554.00, '2025-10-06', '2025-10-11', '2026-01-14 07:16:43', '2026-01-14 07:24:25'),
	(797, 17, 3829.00, '2025-10-12', NULL, '2026-01-14 07:16:43', '2026-01-14 07:24:25'),
	(799, 17, 3398.00, '2026-01-07', '2026-01-12', '2026-01-14 07:16:43', '2026-01-14 07:24:25'),
	(800, 17, 3727.00, '2026-01-13', '2026-01-18', '2026-01-14 07:16:43', '2026-01-14 07:24:25'),
	(801, 17, 3459.00, '2026-01-19', '2026-01-24', '2026-01-14 07:16:43', '2026-01-14 07:24:25'),
	(802, 17, 3742.00, '2026-01-25', '2026-01-29', '2026-01-14 07:16:43', '2026-01-14 07:24:25'),
	(803, 17, 3939.00, '2026-01-30', '2026-02-02', '2026-01-14 07:16:43', '2026-01-14 07:24:25'),
	(804, 17, 3721.00, '2026-02-03', '2026-02-07', '2026-01-14 07:16:43', '2026-01-14 07:24:25'),
	(805, 17, 3992.00, '2026-02-08', '2026-02-13', '2026-01-14 07:16:43', '2026-01-14 07:24:25'),
	(806, 17, 4192.00, '2026-02-14', NULL, '2026-01-14 07:16:43', '2026-01-14 07:24:25'),
	(779, 17, 4121.00, '2025-03-11', NULL, '2026-01-14 07:16:43', '2026-01-14 07:24:25'),
	(798, 17, 3110.00, '2026-01-01', '2026-01-06', '2026-01-14 07:16:43', '2026-01-14 07:24:25');


--
-- Data for Name: medicines; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.medicines VALUES
	(1, 'Paracetamol', 'm-001', '2026-01-14 06:49:25', '2026-01-14 06:49:25'),
	(2, 'Amoxicillin', 'm-002', '2026-01-14 06:49:25', '2026-01-14 06:49:25'),
	(3, 'Cholecalciferol 1000 IU Tablet Kunyah (PROVE D3-1000)', '9cf72984-047a-4c48-bc12-de0c6437b5ae', '2026-01-14 07:16:36', '2026-01-14 07:16:36'),
	(4, 'Desloratadine 5mg Tablet Salut Selaput (DEXA MEDICA)', '9cf72984-075b-464a-86ac-bd6d727763e3', '2026-01-14 07:16:36', '2026-01-14 07:16:36'),
	(5, 'Diazepam 5mg Tablet (VALISANBE)', '9cf72984-05b8-40d7-9cee-b326578d67f7', '2026-01-14 07:16:37', '2026-01-14 07:16:37'),
	(6, 'Divalproex Sodium 250mg Tablet Pelepasan Lambat (DEXA MEDICA)', '9cf72984-0689-497b-adb6-96a7d50931db', '2026-01-14 07:16:37', '2026-01-14 07:16:37'),
	(7, 'Esomeprazole Sodium 20mg Tablet (ESOFERR)', '9cf72984-01ed-46fa-8efc-04ce10eae2ed', '2026-01-14 07:16:38', '2026-01-14 07:16:38'),
	(8, 'Lorazepam 2mg Tablet Salut Selaput (MERLOPAM 2)', '9cf72984-04e0-4d4b-852c-8602ce4cb30b', '2026-01-14 07:16:38', '2026-01-14 07:16:38'),
	(9, 'Mecobalamin 500 mg Tablet (LAPIBAL)', '9cf72984-033d-4af8-95cb-2b4912602c8a', '2026-01-14 07:16:39', '2026-01-14 07:16:39'),
	(10, 'Mefenamic Acid 500mg Tablet Salut Selaput (MEFINAL 500)', '9cf72984-0411-4b11-969c-e13a4b116bec', '2026-01-14 07:16:39', '2026-01-14 07:16:39'),
	(11, 'Metamizole Sodium 500mg Tablet (NOVALGIN)', '9cf72984-054d-4925-b12e-2aaf8d613401', '2026-01-14 07:16:40', '2026-01-14 07:16:40'),
	(12, 'Methylprednisolone 8mg Tablet (SANEXON 8)', '9cf72984-0622-4a2b-81e8-1b92fbbdeb64', '2026-01-14 07:16:40', '2026-01-14 07:16:40'),
	(13, 'Paracetamol 500mg Tablet (SANMOL)', '9cf72984-0015-45a4-a2b4-dcf83e8fe144', '2026-01-14 07:16:41', '2026-01-14 07:16:41'),
	(14, 'Propranolol Hydrochloride 10mg Tablet (KIMIA FARMA)', '9cf72984-02d4-4270-b659-708bae3c5ca1', '2026-01-14 07:16:41', '2026-01-14 07:16:41'),
	(15, 'Ranitidine Hydrochloride 150mg Tablet Salut Selaput (HEXPHARM)', '9cf72984-0265-4a83-9eba-278eae10ca92', '2026-01-14 07:16:42', '2026-01-14 07:16:42'),
	(16, 'Tranexamic Acid 500mg Tablet Salut Selaput (BERNOFARM)', '9cf72984-06f4-40e2-b434-efea9ee0d622', '2026-01-14 07:16:42', '2026-01-14 07:16:42'),
	(17, 'Vitamin E 30 IU/ Vitamin C 750mg/ Vitamin B1 15mg (BECOM - ZET)', '9cf72984-03a8-43ad-9a57-41b8c6f2ba27', '2026-01-14 07:16:43', '2026-01-14 07:16:43');


--
-- Data for Name: migrations; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.migrations VALUES
	(1, '0001_01_01_000000_create_users_table', 1),
	(2, '0001_01_01_000001_create_cache_table', 1),
	(3, '0001_01_01_000002_create_jobs_table', 1),
	(4, '2026_01_14_033546_create_roles', 1),
	(5, '2026_01_14_033735_create_checkup_results', 1),
	(6, '2026_01_14_033806_create_patients', 1),
	(7, '2026_01_14_034001_create_medicines', 1),
	(8, '2026_01_14_034410_create_medicine_prices', 1),
	(9, '2026_01_14_034649_create_user_roles', 1),
	(10, '2026_01_14_040500_create_prescriptions', 1),
	(11, '2026_01_14_040510_create_prescription_items', 1),
	(12, '2026_01_14_040520_add_external_file_path_to_checkup_results', 1),
	(13, '2026_01_14_040530_add_user_roles_fk_to_users', 1),
	(14, '2026_01_14_040540_create_patient_visits', 1),
	(15, '2026_01_14_040550_add_visit_id_to_checkup_results', 1),
	(16, '2026_01_14_040560_add_is_nonactive_to_users', 1),
	(17, '2026_01_14_040570_create_activity_logs', 2);


--
-- Data for Name: password_reset_tokens; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: patient_visits; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.patient_visits VALUES
	(1, 2, 3, 1, 2, 'completed', '2026-01-14 07:06:34', '2026-01-14 07:06:34', '2026-01-14 07:15:45'),
	(2, 2, 3, 1, 2, 'completed', '2026-01-14 07:25:26', '2026-01-14 07:25:26', '2026-01-14 07:41:30');


--
-- Data for Name: patients; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.patients VALUES
	(1, 'Andi Wijaya', '1990-01-01', 'Laki-laki', 'Jl. Melati No. 1', '081234567890', '2026-01-14 06:49:25', '2026-01-14 06:49:25'),
	(2, 'Dhiemas Ganisha', '2026-01-14', 'Laki-laki', 'Bandung', '08383838', '2026-01-14 07:06:34', '2026-01-14 07:06:34');


--
-- Data for Name: prescription_items; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.prescription_items VALUES
	(1, 1, 1, '500mg', '3x sehari', '5 hari', 1, 'Setelah makan', '2026-01-14 06:49:25', '2026-01-14 06:49:25'),
	(2, 2, 1, 'Ok', '3x1', '5 hari', 1, 'setelah makan', '2026-01-14 07:15:21', '2026-01-14 07:15:21'),
	(3, 3, 3, '500mg', '1x1', '10', 1, 'Habiskan', '2026-01-14 07:39:08', '2026-01-14 07:39:08');


--
-- Data for Name: prescriptions; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.prescriptions VALUES
	(1, 1, 'pending', NULL, NULL, '2026-01-14 06:49:25', '2026-01-14 06:49:25'),
	(2, 2, 'served', '2026-01-14 07:15:45', 2, '2026-01-14 07:15:21', '2026-01-14 07:15:45'),
	(3, 3, 'served', '2026-01-14 07:41:30', 2, '2026-01-14 07:39:08', '2026-01-14 07:41:30');


--
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: sessions; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.sessions VALUES
	('b0ndll9uEhVq54ekQtHWFz8tu3izaeaip6LN0oTh', 2, '127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoidElkRG5aQTdSSTdSOUtnNnB0TDFpajdlelhHaExQZVJFU0d4Tkp0RSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6NDA6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9waGFybWFjeS8yL3JlY2VpcHQiO3M6NToicm91dGUiO3M6MTY6InBoYXJtYWN5LnJlY2VpcHQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX1zOjUwOiJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aToyO30=', 1768374952),
	('h7xVh8tXw4GFRMt3QyKP4ZxWBWEGrWLu4xn51bGM', 2, '127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiVExFYUk4OWRNYmJIT3ZaNFduNUtHeXFKcThjVG9xYnNNSmdVanl6UiI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9waGFybWFjeS8zIjtzOjU6InJvdXRlIjtzOjEzOiJwaGFybWFjeS5zaG93Ijt9czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6Mjt9', 1768376490);


--
-- Data for Name: user_roles; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.user_roles VALUES
	(1, 'Dokter', false, NULL, '2026-01-14 06:49:24', '2026-01-14 06:49:24'),
	(2, 'Apoteker', false, NULL, '2026-01-14 06:49:24', '2026-01-14 06:49:24'),
	(3, 'Pendaftaran', false, NULL, '2026-01-14 06:49:24', '2026-01-14 06:49:24'),
	(4, 'Administrator', false, NULL, '2026-01-14 06:49:24', '2026-01-14 06:49:24');


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.users VALUES
	(1, 'Dokter Demo', 'dokter@example.com', 1, NULL, '$2y$12$mL17n6BvcI4SVl2YzjN2nOTwJn1e8pHOq.ihFUlh6skChvgyWAA3i', NULL, '2026-01-14 06:49:24', '2026-01-14 06:49:24', false),
	(3, 'Pendaftaran Demo', 'pendaftaran@example.com', 3, NULL, '$2y$12$KVJuLGoLRIL2yH8JJxJoq.BlgspS7hchZ4JCIvlAkJ0P43fTcTkoK', NULL, '2026-01-14 06:49:25', '2026-01-14 06:49:25', false),
	(4, 'Administrator Demo', 'admin@example.com', 4, NULL, '$2y$12$vfxQDApu5grF7dr8uOxTkeLzFbrFTN.fm1Ebd7go4Br3iuvaqjYye', NULL, '2026-01-14 06:49:25', '2026-01-14 06:49:25', false),
	(2, 'Apoteker Demo', 'apoteker@example.com', 2, NULL, '$2y$12$4HT/TayAhbMtZhcTZC5cpuansGHoAh3mb/z9NyD9mxXl25hWTs.qe', NULL, '2026-01-14 06:49:25', '2026-01-14 06:50:12', false),
	(5, 'Tes User', 'tesuser@mail.com', 2, NULL, '$2y$12$k9.zhCUR0G/dm.hFOyNKgeOJPPZd3nLN9WBXzicWc4IuVV6iLkhdm', NULL, '2026-01-14 07:24:54', '2026-01-14 07:24:54', false);


--
-- Name: activity_logs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.activity_logs_id_seq', 12, true);


--
-- Name: checkup_results_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.checkup_results_id_seq', 3, true);


--
-- Name: failed_jobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.failed_jobs_id_seq', 1, false);


--
-- Name: jobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.jobs_id_seq', 1, false);


--
-- Name: medicine_prices_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.medicine_prices_id_seq', 806, true);


--
-- Name: medicines_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.medicines_id_seq', 17, true);


--
-- Name: migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.migrations_id_seq', 17, true);


--
-- Name: patient_visits_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.patient_visits_id_seq', 2, true);


--
-- Name: patients_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.patients_id_seq', 2, true);


--
-- Name: prescription_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.prescription_items_id_seq', 3, true);


--
-- Name: prescriptions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.prescriptions_id_seq', 3, true);


--
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.roles_id_seq', 1, false);


--
-- Name: user_roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.user_roles_id_seq', 4, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.users_id_seq', 5, true);


--
-- Name: activity_logs activity_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.activity_logs
    ADD CONSTRAINT activity_logs_pkey PRIMARY KEY (id);


--
-- Name: cache_locks cache_locks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cache_locks
    ADD CONSTRAINT cache_locks_pkey PRIMARY KEY (key);


--
-- Name: cache cache_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cache
    ADD CONSTRAINT cache_pkey PRIMARY KEY (key);


--
-- Name: checkup_results checkup_results_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.checkup_results
    ADD CONSTRAINT checkup_results_pkey PRIMARY KEY (id);


--
-- Name: failed_jobs failed_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.failed_jobs
    ADD CONSTRAINT failed_jobs_pkey PRIMARY KEY (id);


--
-- Name: failed_jobs failed_jobs_uuid_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.failed_jobs
    ADD CONSTRAINT failed_jobs_uuid_unique UNIQUE (uuid);


--
-- Name: job_batches job_batches_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.job_batches
    ADD CONSTRAINT job_batches_pkey PRIMARY KEY (id);


--
-- Name: jobs jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.jobs
    ADD CONSTRAINT jobs_pkey PRIMARY KEY (id);


--
-- Name: medicine_prices medicine_prices_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.medicine_prices
    ADD CONSTRAINT medicine_prices_pkey PRIMARY KEY (id);


--
-- Name: medicines medicines_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.medicines
    ADD CONSTRAINT medicines_pkey PRIMARY KEY (id);


--
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- Name: password_reset_tokens password_reset_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.password_reset_tokens
    ADD CONSTRAINT password_reset_tokens_pkey PRIMARY KEY (email);


--
-- Name: patient_visits patient_visits_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.patient_visits
    ADD CONSTRAINT patient_visits_pkey PRIMARY KEY (id);


--
-- Name: patients patients_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.patients
    ADD CONSTRAINT patients_pkey PRIMARY KEY (id);


--
-- Name: prescription_items prescription_items_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.prescription_items
    ADD CONSTRAINT prescription_items_pkey PRIMARY KEY (id);


--
-- Name: prescriptions prescriptions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.prescriptions
    ADD CONSTRAINT prescriptions_pkey PRIMARY KEY (id);


--
-- Name: roles roles_name_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_name_unique UNIQUE (name);


--
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- Name: user_roles user_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT user_roles_pkey PRIMARY KEY (id);


--
-- Name: users users_email_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_unique UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: jobs_queue_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX jobs_queue_index ON public.jobs USING btree (queue);


--
-- Name: sessions_last_activity_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX sessions_last_activity_index ON public.sessions USING btree (last_activity);


--
-- Name: sessions_user_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX sessions_user_id_index ON public.sessions USING btree (user_id);


--
-- Name: activity_logs activity_logs_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.activity_logs
    ADD CONSTRAINT activity_logs_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: checkup_results checkup_results_visit_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.checkup_results
    ADD CONSTRAINT checkup_results_visit_id_foreign FOREIGN KEY (visit_id) REFERENCES public.patient_visits(id) ON DELETE SET NULL;


--
-- Name: medicine_prices medicine_prices_medicine_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.medicine_prices
    ADD CONSTRAINT medicine_prices_medicine_id_foreign FOREIGN KEY (medicine_id) REFERENCES public.medicines(id) ON DELETE CASCADE;


--
-- Name: patient_visits patient_visits_handled_apoteker_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.patient_visits
    ADD CONSTRAINT patient_visits_handled_apoteker_id_foreign FOREIGN KEY (handled_apoteker_id) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: patient_visits patient_visits_handled_doctor_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.patient_visits
    ADD CONSTRAINT patient_visits_handled_doctor_id_foreign FOREIGN KEY (handled_doctor_id) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: patient_visits patient_visits_patient_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.patient_visits
    ADD CONSTRAINT patient_visits_patient_id_foreign FOREIGN KEY (patient_id) REFERENCES public.patients(id) ON DELETE CASCADE;


--
-- Name: patient_visits patient_visits_registered_by_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.patient_visits
    ADD CONSTRAINT patient_visits_registered_by_foreign FOREIGN KEY (registered_by) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: prescription_items prescription_items_medicine_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.prescription_items
    ADD CONSTRAINT prescription_items_medicine_id_foreign FOREIGN KEY (medicine_id) REFERENCES public.medicines(id) ON DELETE CASCADE;


--
-- Name: prescription_items prescription_items_prescription_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.prescription_items
    ADD CONSTRAINT prescription_items_prescription_id_foreign FOREIGN KEY (prescription_id) REFERENCES public.prescriptions(id) ON DELETE CASCADE;


--
-- Name: prescriptions prescriptions_checkup_result_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.prescriptions
    ADD CONSTRAINT prescriptions_checkup_result_id_foreign FOREIGN KEY (checkup_result_id) REFERENCES public.checkup_results(id) ON DELETE CASCADE;


--
-- Name: prescriptions prescriptions_served_by_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.prescriptions
    ADD CONSTRAINT prescriptions_served_by_foreign FOREIGN KEY (served_by) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: user_roles user_roles_roles_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT user_roles_roles_id_foreign FOREIGN KEY (roles_id) REFERENCES public.roles(id) ON DELETE SET NULL;


--
-- Name: users users_user_roles_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_user_roles_id_foreign FOREIGN KEY (user_roles_id) REFERENCES public.user_roles(id) ON DELETE SET NULL;


--
-- PostgreSQL database dump complete
--


DROP TABLE IF EXISTS databases;
DROP TABLE IF EXISTS database_media_types;
DROP TABLE IF EXISTS database_alternative_titles;
DROP TABLE IF EXISTS topics;
DROP TABLE IF EXISTS database_topics;
DROP TABLE IF EXISTS database_sub_topics;
DROP TABLE IF EXISTS publishers;
DROP TABLE IF EXISTS database_urls;
DROP TABLE IF EXISTS database_terms_of_use;
DROP TABLE IF EXISTS media_types;
DROP TABLE IF EXISTS media_type_for;
DROP TABLE IF EXISTS sub_topics;
DROP TABLE IF EXISTS database_publishers;

CREATE TABLE databases (
    id serial PRIMARY KEY,
    title_en text UNIQUE NOT NULL,
    title_sv text UNIQUE NOT NULL,
    description_en text,
    description_sv text,
    is_popular boolean,
    public_access boolean,
    malfunction_message_active boolean,
    malfunction_message text,
    access_information_code text NOT NULL
);

CREATE TABLE database_alternative_titles (
    id serial PRIMARY KEY,
    database_id int,
    title text
);



CREATE TABLE database_terms_of_use (
    id serial PRIMARY KEY,
    description_sv text,
    description_en text,
    permitted boolean,
    database_id int,
    code text NOT NULL
);

CREATE TABLE database_urls (
    id serial PRIMARY KEY,
    database_id int,
    title text,
    url text
);


CREATE TABLE topics (
    id serial PRIMARY KEY,
    name_en text UNIQUE NOT NULL,
    name_sv text UNIQUE NOT NULL,
    updated_at timestamp default now(),
    inserted_at timestamp default now()
);

CREATE TABLE sub_topics (
    id serial PRIMARY KEY,
    name_en text NOT NULL,
    name_sv text NOT NULL,
    topic_id int
);

CREATE UNIQUE INDEX sub_topic_name_en ON sub_topics (
    name_en,
    topic_id
);

CREATE UNIQUE INDEX sub_topic_name_sv ON sub_topics (
    name_sv,
    topic_id
);

CREATE TABLE database_topics (
    id serial PRIMARY KEY,
    database_id int,
    topic_id int,
    is_recommended boolean
);

CREATE TABLE database_sub_topics (
    id serial PRIMARY KEY,
    database_id int,
    topic_id int,
    sub_topic_id int,
    is_recommended boolean
);

CREATE TABLE publishers (
    id serial PRIMARY KEY,
    name text UNIQUE NOT NULL
);

CREATE TABLE database_publishers (
    id serial PRIMARY KEY,
    database_id int,
    publisher_id int
);

CREATE TABLE media_types (
    id serial PRIMARY KEY,
    name_en text UNIQUE NOT NULL,
    name_sv text UNIQUE NOT NULL
);

CREATE TABLE media_type_for (
    id serial PRIMARY KEY,
    database_id int,
    media_type_id int
);

CREATE TABLE database_media_types (
    id serial PRIMARY KEY,
    database_id int,
    media_type_id int
);

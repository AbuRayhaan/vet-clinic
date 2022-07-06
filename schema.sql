/* Database schema to keep the structure of entire database. */

--CREATE TABLE FEATURE
CREATE TABLE animals (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    name varchar(100),
    date_of_birth date,
    escape_attempts integer,
    neutered boolean,
    weight_kg decimal
);

--QUERY AND UPDATE TABLE FEATURE
ALTER TABLE animals ADD column species varchar(100);

--QUERY MULTIPLE TABLES FEATURE
CREATE TABLE owners (
    id SERIAL PRIMARY KEY,
    full_name varchar(100) NOT NULL,
    age integer
);
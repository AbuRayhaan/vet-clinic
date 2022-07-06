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

CREATE TABLE species (
    id SERIAL PRIMARY KEY,
    name varchar(100) NOT NULL
);

ALTER TABLE animals DROP column species;
ALTER TABLE animals ADD column species_id int REFERENCES species(id);
ALTER TABLE animals ADD column owner_id int REFERENCES owners(id);
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

--ADD JOIN TABLES FOR VISITS

CREATE TABLE vets (
    id SERIAL PRIMARY KEY,
    name varchar(100) NOT NULL,
    age int NOT NULL,
    date_of_graduation date NOT NULL
);

CREATE TABLE specializations (
    vets_id int NOT NULL,
    species_id int NOT NULL,
    FOREIGN KEY (vets_id) REFERENCES vets(id) ON DELETE RESTRICT ON UPDATE CASCADE
    FOREIGN KEY (species_id) REFERENCES species(id) ON DELETE RESTRICT ON UPDATE CASCADE
    PRIMARY KEY(vets_id, species_id)
);


DROP TABLE visits;

CREATE TABLE visits (
    id SERIAL PRIMARY KEY,
    animals_id int NOT NULL,
    vets_id int NOT NULL,
    date_of_visit date,
    FOREIGN KEY (animals_id) REFERENCES animals(id) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (vets_id) REFERENCES vets(id) ON DELETE RESTRICT ON UPDATE CASCADE,
);

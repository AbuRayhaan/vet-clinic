/*Queries that provide answers to the questions from all projects.*/

--CREATE TABLE FEATURE
SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth >= '2016-01-01' AND date_of_birth <= '2019-12-31';
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT name FROM animals WHERE neutered = true;
SELECT * FROM animals WHERE name != 'Gabumon';
SELECT name FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;

--QUERY AND UPDATE TABLE FEATURE
BEGIN;
UPDATE animals SET species = 'unspecified';
ROLLBACK;


UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species is NULL;
COMMIT;

BEGIN;
DELETE FROM animals;
ROLLBACK;

BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01'
SAVEPOINT animals_deleted;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK to animals_deleted;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;

SELECT COUNT(*) FROM animals;

SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;

SELECT ROUND(AVG(weight_kg)::numeric, 2) FROM animals;

SELECT name FROM animals WHERE escape_attempts = (SELECT MAX(escape_attempts) FROM animals);

SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;

SELECT species, ROUND(AVG(escape_attempts)::numeric, 0) FROM animals WHERE date_of_birth >= '1990-01-01' AND date_of_birth <= '2000-12-31' GROUP BY species;

--QUERY MULTIPLE TABLES FEATURE

SELECT name FROM animals JOIN owners ON animals.owner_id = owners.id WHERE owners.full_name = 'Melody Pond';

SELECT Animal, Species FROM (SELECT animals.name AS Animal, species.name as Species FROM animals, species WHERE animals.species_id = species.id) _ WHERE Species = 'Pokemon';

SELECT owners.full_name, animals.name FROM owners LEFT JOIN animals ON owners.id = animals.owner_id;

SELECT species.name, COUNT(*) FROM animals JOIN species ON animals.species_id = species.id GROUP BY species.name;

SELECT animals.name FROM animals JOIN owners ON animals.owner_id = owners.id JOIN species ON animals.species_id = species.id WHERE owners.full_name = 'Jennifer Orwell' AND species.name = 'Digimon';

SELECT animals.name FROM animals JOIN owners ON animals.owner_id = owners.id WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts = 0 GROUP BY animals.name;

SELECT owners.full_name, COUNT(*) FROM owners JOIN animals ON owners.id = animals.owner_id GROUP BY owners.full_name ORDER BY COUNT(*) DESC LIMIT 1;

--ADD JOIN TABLES FOR VISITS

SELECT vets.name, date_of_visit, animals.name FROM animals JOIN visits ON visits.animals_id = animals.id JOIN vets ON visits.vets_id = vets.id WHERE vets.name = 'William Tatcher' ORDER BY date_of_visit DESC LIMIT 1;

SELECT species.name FROM specializations s JOIN vets ON s.vets_id = vets.id JOIN visits ON visits.vets_id = vets.id JOIN species ON s.species_id = species.id WHERE vets.name = 'Stephanie Mendez' GROUP BY species.name;

SELECT vets.name AS vet_name, sp.name AS sp_name FROM vets FULL JOIN specializations s ON s.vets_id = vets.id LEFT JOIN species sp ON s.species_id = sp.id;

SELECT vt.name AS vet_name, a.name AS ani_name, date_of_visit FROM visits v JOIN animals a ON v.animals_id = a.id JOIN vets vt ON v.vets_id = vt.id WHERE vt.name = 'Stephanie Mendez' AND date_of_visit BETWEEN '2020-04-01' AND '2020-08-30';

SELECT name, COUNT(date_of_birth) FROM animals a JOIN visits v ON a.id = v.animals_id GROUP BY a.name ORDER BY count DESC LIMIT 1;

SELECT a.name, vt.name, date_of_visit FROM visits v JOIN vets vt ON v.vets_id = vt.id JOIN animals a ON v.animals_id = a.id WHERE vt.name = 'Maisy Smith' ORDER BY date_of_visit LIMIT 1;

SELECT a.name AS ani_name, vt.name AS vet_name, date_of_visit FROM visits v JOIN animals a ON v.animals_id = a.id JOIN vets vt ON v.vets_id = vt.id ORDER BY date_of_visit DESC LIMIT 1;

SELECT COUNT(sp.name), sp.name FROM visits v JOIN animals a ON v.animals_id = a.id JOIN species sp ON a.species_id = sp.id JOIN vets vt ON v.vets_id = vt.id WHERE vets_id = 2 GROUP BY(sp.name) limit 1;

SELECT COUNT(*) AS species FROM visits v FULL OUTER JOIN vets vt ON v.vets_id = vt.id FULL OUTER JOIN specializations s ON s.vets_id = vt.id WHERE species_id IS NULL;

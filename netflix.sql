CREATE SCHEMA NETFLIX_TITLE;

SET SEARCH_PATH TO NETFLIX_TITLE;

--Create table netflix_title
CREATE TABLE netflix_title(
	show_id text,
	show_type text,
	title text,
	director text,
	show_cast text,
	country text,
	date_added text, 
	release_year text,
	rating text, 
	duration text, 
	listed_in text, 
	description text
);

ALTER TABLE netflix_title RENAME TO netflix_titles;
ALTER TABLE netflix_titles RENAME TO netflix_titles_original;

-- Verify data was imported
SELECT * FROM netflix_titles LIMIT 3;

-- Rename columns
ALTER TABLE netflix_titles DROP COLUMN show_cast;
ALTER TABLE netflix_titles DROP COLUMN show_type;

ALTER TABLE netflix_titles RENAME COLUMN "cast" TO show_cast;
ALTER TABLE netflix_titles RENAME COLUMN "type" TO show_type;


-- Alter data types
--1. show_id
ALTER TABLE netflix_titles
ALTER COLUMN show_id TYPE varchar(20) USING show_id::varchar;

--2. show_type
ALTER TABLE netflix_titles
ALTER COLUMN show_type TYPE varchar(100) USING show_type::varchar;

--3. title
ALTER TABLE netflix_titles
ALTER COLUMN title TYPE varchar(200) USING title::varchar;

SELECT * FROM netflix_titles LIMIT 3;

--4. director
ALTER TABLE netflix_titles
ALTER COLUMN director TYPE varchar(300) USING director::varchar;

--6. country 
ALTER TABLE netflix_titles
ALTER COLUMN country TYPE varchar(200) USING country::varchar;

--7. date_added 
ALTER TABLE netflix_titles
ALTER COLUMN date_added TYPE DATE USING to_date(date_added, 'Month DD, YYYY');

--8. release_year
ALTER TABLE netflix_titles
ALTER COLUMN release_year TYPE INT USING release_year::int;

--9. rating 
ALTER TABLE netflix_titles
ALTER COLUMN rating TYPE varchar(100) USING rating::varchar;

--10. duration 
ALTER TABLE netflix_titles
ALTER COLUMN duration TYPE varchar(100) USING duration::varchar;

--11. listed_in 
ALTER TABLE netflix_titles
ALTER COLUMN listed_in TYPE varchar(200) USING listed_in::varchar;

-- Create a table to work 
CREATE TABLE netflix_titles_staging AS
SELECT * FROM netflix_titles;


--verify NEW TABLE has data
SELECT count(*) FROM netflix_titles_staging;

--CHECK distinct values
--1. show_type
SELECT show_type, COUNT(*) FROM netflix_titles_staging
GROUP BY show_type;

--2. rating
SELECT rating, COUNT(*) AS total_count
FROM netflix_titles_staging
GROUP BY rating
ORDER BY count(*) DESC;

UPDATE netflix_titles_staging
SET rating =  CASE
	WHEN TRIM(LOWER(rating)) IN ('74 min', '66 min', '84 min', 'ur', 'nr') OR TRIM(LOWER(rating)) = '' THEN 'NOT RATED'
	WHEN TRIM(LOWER(rating)) IN ('pg', 'tv-pg') THEN 'TV-PG'
	WHEN TRIM(LOWER(rating)) = 'g' THEN 'TV-G'
	WHEN TRIM(LOWER(rating)) IN ('r', 'tv-ma') THEN 'TV-MA'
	ELSE UPPER(LOWER(TRIM(rating)))
END;

--CHECK FOR duplicates 
SELECT show_id, COUNT(*) AS total_count
FROM netflix_titles_staging
GROUP BY show_id
ORDER BY COUNT(*) DESC;

SELECT * 
FROM (
	SELECT 
		show_id, show_type, title, director, show_cast, country, date_added, 
		release_year, rating, duration, listed_in, description, COUNT(*) AS records 
	FROM netflix_titles_staging
	GROUP BY 
		show_id, show_type, title, director, show_cast, country, date_added,
		release_year, rating, duration, listed_in, description ) a
WHERE records > 1;

-- Find Extra Spaces
SELECT *
FROM netflix_titles_staging
WHERE show_id <> TRIM(show_id)
	OR show_type <> TRIM(show_type),
	OR show_type <> TRIM(title
	OR show_type <> TRIM(director,)
	OR show_type <> TRIM(show_cast)
	OR show_type <> TRIM(country,
)OR show_type <> TRIM(date_adde), 
	OR show_type <> TRIM(release_y)ar,
	OR show_type <> TRIM(rating, 
)OR show_type <> TRIM(duration,)
	OR show_type <> TRIM(listed_in) 
	OR show_type <> TRIM(descripti)n,


SELECT * from movie_show_categories;

-- Total number of titles
SELECT COUNT(*) FROM netflix_titles_staging AS total_titles;

-- Movies vs TV Shows split
SELECT show_type, COUNT(*)
FROM netflix_titles_staging
GROUP BY show_type
ORDER BY COUNT(*) DESC;


-- Number of countries represented
SELECT DISTINCT country_name, COUNT(*)
FROM movie_show_countries
GROUP BY country_name
ORDER BY COUNT(*) DESC;

-- Average movie duration
SELECT ROUND(AVG(duration_value), 1) AS avg_duration
FROM netflix_titles_staging;

-- Most common rating
SELECT * FROM  netflix_titles_staging LIMIT 4;
SELECT rating, count(*)
FROM netflix_titles_staging 
GROUP By rating
ORDER BY count(*) DESC;

-- Titles by Year
SELECT EXTRACT(year FROM release_year) FROM  netflix_titles_staging;

-- Which countries produce the most content?
The United States

-- What are the most common genres?
SELECT * FROM  movie_show_categories;
SELECT category_name, count(*)
FROM movie_show_categories
GROUP By category_name
ORDER BY count(*) DESC;

-- Create backup 2
CREATE TABLE netflix_backup_2 AS
SELECT * FROM netflix_titles_staging;

SELECT * FROM netflix_titles_staging
WHERE country = '' OR country is NULL;

-- Set empty countries to Unknown
UPDATE netflix_titles_staging
SET country = 'Unknown'
WHERE country = '' OR country is NULL;

-- Set empty directors to Unknown
SELECT * FROM netflix_titles_staging
WHERE LENGTH(TRIM(director)) = 0;

UPDATE netflix_titles_staging
SET director = 'Not Stated'
WHERE TRIM(director) = '' OR director is NULL;

-- Fix null values in duration
SELECT * FROM netflix_titles_staging
WHERE duration IS NULL;

UPDATE netflix_titles_staging
SET duration = NULL
WHERE duration = '' OR duration is NULL;

-- Fix empty values in show_cast
SELECT * FROM netflix_titles_staging
WHERE show_cast = '' OR show_cast IS NULL;

UPDATE netflix_titles_staging
SET show_cast = 'Unknown'
WHERE show_cast = '' OR show_cast IS NULL;

-- Check empty values in listed_id
SELECT * FROM netflix_titles_staging
WHERE listed_in = '' OR listed_in IS NULL;

-- Create table movie_show_casts
CREATE TABLE  movie_show_casts1 AS
	SELECT show_id,
		TRIM(cast_name)
	FROM netflix_titles_staging,
	LATERAL UNNEST(STRING_TO_ARRAY(show_cast, ',')) AS cast_name;

-- Rename column name
ALTER TABLE movie_show_casts1 RENAME COLUMN btrim TO cast_name;

SELECT * FROM movie_show_casts1
where cast_name = 'Unknown';

-- Rename table 
ALTER TABLE movie_show_casts1 RENAME TO movie_show_casts;

-- Create table movie_show_categories
CREATE TABLE movie_show_categories1 AS
	SELECT show_id,
		TRIM(category_name)
		FROM netflix_titles_staging,
		LATERAL UNNEST(STRING_TO_ARRAY(listed_in, ',')) AS  category_name;

SELECT * FROM movie_show_categories1
where category_name = '';

-- Rename column
ALTER TABLE movie_show_categories1 RENAME COLUMN btrim TO category_name;

-- Rename table 
ALTER TABLE movie_show_categories1 RENAME TO movie_show_categories;

-- Create table movie_show_countries
CREATE TABLE movie_show_countries1 AS
	SELECT show_id,
		TRIM(country_name)
		FROM netflix_titles_staging,
		LATERAL UNNEST(STRING_TO_ARRAY(country, ',')) AS  country_name;

-- Rename column
ALTER TABLE movie_show_countries1 RENAME COLUMN btrim TO country_name;

SELECT * FROM movie_show_countries1
where country_name = 'Unknown';

DELETE FROM movie_show_countries1
where country_name = '';

-- Rename table 
ALTER TABLE movie_show_countries1 RENAME TO movie_show_countries;

-- Create table movie_show_directors
CREATE TABLE movie_show_directors1 AS
	SELECT show_id,
		TRIM(director_name)
		FROM netflix_titles_staging,
		LATERAL UNNEST(STRING_TO_ARRAY(director, ',')) AS  director_name;

-- Rename column
ALTER TABLE movie_show_directors1 RENAME COLUMN btrim TO director_name;

SELECT * FROM movie_show_directors
where director_name = '';

-- Rename table 
ALTER TABLE movie_show_directors1 RENAME TO movie_show_directors;

SELECT UNNEST(STRING_TO_ARRAY(director, ',')) AS  director_name, COUNT(*)
FROM netflix_titles_staging
GROUP BY director_name
HAVING UNNEST(STRING_TO_ARRAY(director, ',')) = ''
ORDER BY COUNT(*) DESC;

-- Check for empty dates
SELECT *
FROM netflix_titles_staging
WHERE date_added IS NULL;

SELECT COUNT(DISTINCT country_name)
FROM movie_show_countries;

-- Count of TV Shows Vs Movies
SELECT show_type, COUNT(*) 
FROM netflix_titles_staging
GROUP BY show_type
ORDER BY COUNT(*) DESC;

-- Average duration for Movies
SELECT AVG(duration_value)
FROM netflix_titles_staging
WHERE show_type = 'Movie';

-- Most Common Rating
SELECT rating, COUNT(*) 
FROM netflix_titles_staging
GROUP BY rating
ORDER BY COUNT(*) DESC;

-- count of shows by country
SELECT country_name, COUNT(*) 
FROM movie_show_countries
GROUP BY country_name
ORDER BY COUNT(*) DESC;

CREATE DATABASE netflix_analysis;
USE netflix_analysis;
CREATE TABLE netflix_titles (
    show_id VARCHAR(10) PRIMARY KEY,
    type VARCHAR(20),
    title VARCHAR(255),
    director TEXT,
    cast TEXT,
    country TEXT,
    date_added DATE NULL,
    release_year INT,
    rating VARCHAR(30),
    duration VARCHAR(30),
    listed_in TEXT,
    description TEXT,
    year_added INT NULL
);
LOAD DATA INFILE
'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/netflix_cleaned.csv'
INTO TABLE netflix_titles
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
    show_id, type, title, director, cast, country,
    @date_added, release_year, rating, duration,
    listed_in, description
)
SET date_added = STR_TO_DATE(NULLIF(@date_added, ''), '%Y-%m-%d'),
    year_added = YEAR(STR_TO_DATE(NULLIF(@date_added, ''), '%Y-%m-%d'));
SELECT COUNT(*) AS total_titles FROM netflix_titles;
SELECT type,COUNT(*) AS total_titles FROM netflix_titles GROUP BY type
ORDER BY total_titles DESC;
SELECT country, COUNT(*) AS total_titles FROM netflix_titles
WHERE country IS NOT NULL AND country <> ''AND country <> 'Unknown'
GROUP BY country ORDER BY total_titles DESC LIMIT 10;
WITH RECURSIVE country_split AS (SELECT show_id,TRIM(SUBSTRING_INDEX(country, ',', 1)) AS country_name,
        CASE WHEN country LIKE '%,%'
            THEN SUBSTRING(country, LENGTH(SUBSTRING_INDEX(country, ',', 1)) + 2)
            ELSE ''
        END AS remaining
    FROM netflix_titles
    WHERE country IS NOT NULL
      AND country <> ''
      AND country <> 'Unknown'
    UNION ALL SELECT show_id,TRIM(SUBSTRING_INDEX(remaining, ',', 1)),
        CASE
            WHEN remaining LIKE '%,%'
            THEN SUBSTRING(remaining, LENGTH(SUBSTRING_INDEX(remaining, ',', 1)) + 2)
            ELSE ''
        END
    FROM country_split
    WHERE remaining <> ''
)
SELECT
    country_name,
    COUNT(DISTINCT show_id) AS total_titles
FROM country_split
WHERE country_name <> ''
GROUP BY country_name
ORDER BY total_titles DESC
LIMIT 10;

SELECT
    rating,
    COUNT(*) AS total_titles
FROM netflix_titles
GROUP BY rating
ORDER BY total_titles DESC;

SELECT
    type,
    COUNT(*) AS total_titles,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM netflix_titles), 2) AS percentage
FROM netflix_titles
GROUP BY type
ORDER BY total_titles DESC;

SELECT
    release_year,
    COUNT(*) AS total_titles
FROM netflix_titles
GROUP BY release_year
ORDER BY total_titles DESC
LIMIT 10;

SELECT
    year_added,
    COUNT(*) AS total_titles
FROM netflix_titles
WHERE year_added IS NOT NULL
GROUP BY year_added
ORDER BY total_titles DESC;

WITH RECURSIVE genre_split AS (
    SELECT
        show_id,
        TRIM(SUBSTRING_INDEX(listed_in, ',', 1)) AS genre,
        CASE
            WHEN listed_in LIKE '%,%'
            THEN SUBSTRING(
                listed_in,
                LENGTH(SUBSTRING_INDEX(listed_in, ',', 1)) + 2
            )
            ELSE ''
        END AS remaining
    FROM netflix_titles
    WHERE listed_in IS NOT NULL
      AND listed_in <> ''

    UNION ALL

    SELECT
        show_id,
        TRIM(SUBSTRING_INDEX(remaining, ',', 1)),
        CASE
            WHEN remaining LIKE '%,%'
            THEN SUBSTRING(
                remaining,
                LENGTH(SUBSTRING_INDEX(remaining, ',', 1)) + 2
            )
            ELSE ''
        END
    FROM genre_split
    WHERE remaining <> ''
)
SELECT
    genre,
    COUNT(DISTINCT show_id) AS total_titles
FROM genre_split
WHERE genre <> ''
GROUP BY genre
ORDER BY total_titles DESC
LIMIT 10;
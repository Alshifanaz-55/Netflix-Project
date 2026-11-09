CREATE DATABASE Netflix

USE netflix

SELECT*FROM netflix_titles

--NULL CHECK

SELECT
SUM(CASE WHEN show_id IS NULL THEN 1 ELSE 0 END) AS null_id,
SUM(CASE WHEN type IS NULL THEN 1 ELSE 0 END) AS null_type,
SUM(CASE WHEN title IS NULL THEN 1 ELSE 0 END ) AS null_title,
SUM(CASE WHEN director IS NULL THEN 1 ELSE 0 END) AS null_dirctor,
SUM(CASE WHEN cast IS NULL THEN 1 ELSE 0 END) AS null_cast,
SUM(CASE WHEN country IS NULL THEN 1 ELSE 0 END) AS null_country,
SUM(CASE WHEN date_added IS NULL THEN 1 ELSE 0 END) AS null_date,
SUM(CASE WHEN release_year IS NULL THEN 1 ELSE 0 END) AS null_year,
SUM(CASE WHEN Rating IS NULL THEN 1 ELSE 0 END) AS null_rating,
SUM(CASE WHEN listed_in IS NULL THEN 1 ELSE 0 END) AS null_listing,
SUM(CASE WHEN description IS NULL THEN 1 ELSE 0 END) AS null_description
FROM netflix_titles

--REMOVING NULL

DELETE FROM netflix_titles
WHERE director IS NULL OR
cast IS NULL OR
country IS NULL OR
date_added IS NULL OR 
rating IS NULL OR 
duration IS NULL

--EMPTY STRINGS

SELECT*FROM netflix_titles
WHERE
show_id=''OR type=''OR title=''OR director=''OR cast=''OR country=''OR date_added='' OR release_year=''
OR Rating=''OR duration='' OR listed_in='' OR description=''

--DUPLICATE DETECTION

SELECT
Show_id,type,title,director,cast,Country,date_added,release_year,Rating,duration,listed_in, 
COUNT(*) AS Duplicate_count
FROM netflix_titles
GROUP BY Show_id,type,title,director,cast,Country,date_added,release_year,Rating,duration,listed_in 
HAVING COUNT(*)>1


SELECT*FROM netflix_titles

--Analysis

--1. Count the number of Movies vs TV Shows

     SELECT type , COUNT(*) AS total_count
     FROM netflix_titles
     GROUP BY type

--2. Find the most common rating for movies and TV shows

     with rating_count as (
     
     SELECT type, rating, count(*) as total_titles,
     rank()over(partition by type order by count(*) desc) as rank_no
     from netflix_titles
     group by type,rating
     )
     select type,rating,total_titles,rank_no
     from rating_count 
     where rank_no=1

--3. List all movies released in a specific year (e.g., 2020)

     SELECT *
     FROM netflix_titles
     WHERE release_year ='2020'AND type='Movie'

--4. Find the top 5 countries with the most content on Netflix 

     SELECT TOP 5 Country, COUNT(*) AS total_content
     FROM netflix_titles
     GROUP BY Country
     ORDER BY total_content DESC
     

--5. Identify the longest movie

    SELECT TOP 1 title,duration 
    FROM netflix_titles
    WHERE type='Movie'
    ORDER BY LEN(duration) DESC,duration desc
    

--6. Find content added in the last 5 years
     
     SELECT title ,director, cast, date_added 
     FROM netflix_titles
     WHERE TRY_CAST(date_added AS DATE) >= DATEADD(YEAR, -10,GETDATE())

--7. Find all the movies/TV shows by director 'Rajiv Chilaka'!

     SELECT * FROM netflix_titles
     WHERE director LIKE '%Rajiv chilaka%'

--8. List all TV shows with more than 5 seasons

     SELECT*FROM netflix_titles
     WHERE type='TV Show' AND duration >'5 seasons'

--9. Count the number of content items in each genre

     SELECT listed_in AS genre,COUNT(*) AS total_content
     FROM netflix_titles
     GROUP BY listed_in
     ORDER BY total_content DESC
     
--10.Find each year and the average numbers of content release in India on netflix. 
--return top 5 year with highest avg content release!

     SELECT TOP 5
    release_year, 
    COUNT(show_id) AS total_release,
    CAST(
        (COUNT(show_id) * 100.0) / (SELECT COUNT(*) FROM netflix_titles WHERE country = 'India') 
        AS DECIMAL(5,2)
    ) AS avg_release
FROM netflix_titles
WHERE country = 'India'
GROUP BY release_year
ORDER BY avg_release DESC

--11. List all movies that are documentaries

      SELECT*FROM netflix_titles
      WHERE type='Movie' AND listed_in LIKE '%documentaries%'

--12. Find all content without a director

      SELECT COUNT(*) AS no_director FROM netflix_titles
      where director = ''

--13. Find how many movies actor 'Salman Khan' appeared in last 10 years!

      SELECT COUNT(*) AS total_movies 
      FROM netflix_titles
      WHERE type = 'Movie' 
      AND CAST LIKE '%Salman Khan%' 
      AND release_year>=year(getdate())-15
--14. Find the top 10 actors who have appeared in the highest number of movies produced in India.

      SELECT TOP 10
      LTRIM (RTRIM(value)) AS actor_name,
      country,
      COUNT(*) AS total_movies
      FROM netflix_titles
      CROSS APPLY STRING_SPLIT(cast,',')
      WHERE type='Movie'
      AND country='India'
      GROUP BY LTRIM(RTRIM(value)),
      country
      ORDER BY total_movies DESC

--15. Categorize the content based on the presence of the keywords 'kill' and 'violence' in 
--the description field. Label content containing these keywords as 'Bad' and all other 
--content as 'Good'. Count how many items fall into each category.

       SELECT 
       CASE 
        WHEN description LIKE '%kill%' OR description LIKE '%violence%' 
        THEN 'Bad'
        ELSE 'Good'
       END AS category,
       COUNT(*) AS total_content
      FROM netflix_titles
      GROUP BY 
       CASE 
        WHEN description LIKE '%kill%' OR description LIKE '%violence%' 
        THEN 'Bad'
        ELSE 'Good'
      END











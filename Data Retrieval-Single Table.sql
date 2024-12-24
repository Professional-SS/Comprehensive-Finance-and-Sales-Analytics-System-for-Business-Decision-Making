

-- Simply print all the mymovies 
	SELECT * from mymovies;

-- Get movie movie_title and movie_industry for all the mymymovies
	SELECT movie_title, movie_industry from mymovies;

-- Print all moves from Hollywood 
	SELECT * from mymovies where movie_industry="Hollywood";
  
-- Print all moves from Bollywood 
	SELECT * from mymovies where movie_industry="Bollywood";

-- Get all the unique industries in the mymovies database
	SELECT DISTINCT movie_industry from mymovies;

-- Select all mymovies that starts with THOR
	SELECT * from mymovies where movie_title LIKE 'THOR%';

-- Select all mymovies that have 'America' word in it. That means to select all captain America mymovies
	SELECT * from mymovies where movie_title LIKE '%America%';

-- How many hollywood mymovies are present in the database?
	SELECT COUNT(*) from mymovies where movie_industry="Hollywood";

-- Print all  mymovies where we don't know the value of the studio
	SELECT * FROM mymovies WHERE studio='';


-- Which mymovies had greater than 9 imdb rating?
	SELECT * from mymovies where imdb_rating>9;

-- mymovies with rating between 6 and 8
	SELECT * from mymovies where imdb_rating>=6 and imdb_rating <=8;
	SELECT * from mymovies where imdb_rating BETWEEN 6 AND 8;

-- Select all mymovies whose release year can be 2018 or 2019 or 2022
	-- Approach1:
	SELECT * from mymovies where release_year=2022 
	or release_year=2019 or release_year=2018;

	-- Approach2:
	SELECT * from mymovies where release_year IN (2018,2019,2022);

-- All mymovies where imdb rating is not available (imagine the movie is just released)
	SELECT * from mymovies where imdb_rating IS NULL;

-- All mymovies where imdb rating is available 
	SELECT * from mymovies where imdb_rating IS NOT NULL;

-- Print all bollywood mymovies ordered by their imdb rating
	SELECT * 
        from mymovies WHERE movie_industry = "bollywood"
        ORDER BY imdb_rating ASC;

-- Print first 5 bollywood mymovies with highest rating
	SELECT * 
        from mymovies WHERE movie_industry = "bollywood"
        ORDER BY imdb_rating DESC LIMIT 5;

-- Select mymovies starting from second highest rating movie till next 5 mymovies for bollywood
	SELECT * 
        from mymovies WHERE movie_industry = "bollywood"
        ORDER BY imdb_rating DESC LIMIT 5 OFFSET 1;
        
 
-- How many total mymovies do we have in our mymovies table?
	SELECT COUNT(*) from mymovies;
	
-- Select highest imdb rating for bollywood mymovies
	SELECT MAX(imdb_rating) from mymovies where movie_industry="Bollywood";

-- Select lowest imdb rating for bollywood mymovies
	SELECT MIN(imdb_rating) from mymovies where movie_industry="Bollywood";

-- Print average rating of Marvel Studios mymovies
	SELECT AVG(imdb_rating) from mymovies where studio="Marvel Studios";
	SELECT ROUND(AVG(imdb_rating),2) from mymovies where studio="Marvel Studios";

-- Print min, max, avg rating of Marvel Studios mymovies
	SELECT 
           MIN(imdb_rating) as min_rating, 
           MAX(imdb_rating) as max_rating, 
           ROUND(AVG(imdb_rating),2) as avg_rating
        FROM mymovies 
        WHERE studio="Marvel Studios";

-- Print count of mymovies by movie_industry
	SELECT 
           movie_industry, count(movie_industry) 
        FROM mymovies
        GROUP BY movie_industry;

-- Same thing but add average rating
	SELECT 
            movie_industry, 
            count(movie_industry) as movie_count,
            avg(imdb_rating) as avg_rating
	FROM mymovies
	GROUP BY movie_industry;

-- Count number of mymovies released by a given production studio
	SELECT 
	    studio, count(studio) as mymovies_count 
        from mymovies WHERE studio != ''
	GROUP BY studio
	ORDER BY mymovies_count DESC;

-- What is the average rating of mymovies per studio and also order them by average rating in descending format?
	SELECT 
	   studio, 
	   count(studio) as cnt, 
	   round(avg(imdb_rating), 1) as avg_rating 
	from mymovies WHERE studio != ''
	GROUP BY studio
        order by avg_rating DESC;


-- Print all the years where more than 2 mymovies were released
	SELECT 
           release_year, 
           count(*) as mymovies_count
	FROM mymovies    
	GROUP BY release_year
	HAVING mymovies_count>2
	ORDER BY mymovies_count DESC;



-- Print actor name, their birth_year and age
	SELECT 
           name, birth_year, (YEAR(CURDATE())-birth_year) as age
	FROM actors;

-- Print profit for every movie
	SELECT 
	    *, 
           (revenue-budget) as profit 
	from financials;

-- Print revenue of all mymovies in INR currency
	SELECT 
           movie_id, 
	   revenue, 
           currency, 
           unit,
           IF (currency='USD', revenue*77, revenue) as revenue_inr
	FROM financials;

-- Get all the unique units from financial table
	select 
	   distinct unit 
	From financials;

-- Print revenue in millions 
	SELECT 
           movie_id, revenue, currency, unit,
           CASE
              WHEN unit="Thousands" THEN revenue/1000
              WHEN unit="Billions" THEN revenue*1000
             ELSE revenue
           END as revenue_mln
	FROM financials;


   
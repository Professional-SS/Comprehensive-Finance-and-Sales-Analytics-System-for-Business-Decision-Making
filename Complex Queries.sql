
-- Select a movie with highest imdb_rating
	-- without subquery
	select * from mymovies order by imdb_rating desc limit 1;
	
	-- with subquery
	select * from mymovies where imdb_rating=(select max(imdb_rating) from mymovies);

-- Select a movie with highest and lowest imdb_rating
	-- without subquery
	select * from mymovies where imdb_rating in (1.9, 9.3);

	-- with subquery
	select * from mymovies where imdb_rating in (
        				(select min(imdb_rating) from mymovies), 
    					(select max(imdb_rating) from mymovies)
						);

-- Select all the actors whose age is greater than 70 and less than 85
	select 
	    actor_name, age
	FROM 
  	    (Select
                name as actor_name,
                (year(curdate()) - birth_year) as age
    	     From actors
            ) AS actors_age_table
	WHERE age > 70 AND age < 85;



-- select actors who acted in any of these mymovies (101,110, 121)
	select * From actors WHERE actor_id = ANY(select actor_id From movie_actor where movie_id IN (101, 110, 121));

-- select all mymovies whose rating is greater than *any* of the marvel mymovies rating
	select * from mymovies where imdb_rating > ANY(select imdb_rating from mymovies where studio="Marvel studios");

-- Above, can be achieved in another way too (sub query, min)
	select * from mymovies where imdb_rating > (select min(imdb_rating) from mymovies where studio="Marvel studios");

-- select all mymovies whose rating is greater than *all* of the marvel mymovies rating
	select * from mymovies where imdb_rating > ALL(select imdb_rating from mymovies where studio="Marvel studios");

-- Above, can be achieved in another way too (sub query, max)
	select * from mymovies where imdb_rating > (select max(imdb_rating) from mymovies where studio="Marvel studios");



-- Get the actor id, actor name and the total number of mymovies they acted in.
	SELECT 
           actor_id, 
           name, 
	   (SELECT COUNT(*) FROM movie_actor WHERE actor_id = actors.actor_id) as mymovies_count
	FROM actors
	ORDER BY mymovies_count DESC;

-- Above, can be achieved by using Joins too!
	select 
	    a.actor_id, 
	    a.name, 
	    count(*) as movie_count
	from movie_actor ma
	join actors a
	on a.actor_id=ma.actor_id
	group by actor_id
	order by movie_count desc;



-- Select all the actors whose age is greater than 70 and less than 85
	select 
	   x.movie_id, y.movie_title, x.pct_profit, y.imdb_rating
	from ( 
              select
                  *, 
                  (revenue-budget)*100/budget as pct_profit
              from financials
	     ) x
	join 
	     (select * from mymovies where imdb_rating < (select avg(imdb_rating) from mymovies)) y
	on x.movie_id=y.movie_id
	where pct_profit>500;
    
  
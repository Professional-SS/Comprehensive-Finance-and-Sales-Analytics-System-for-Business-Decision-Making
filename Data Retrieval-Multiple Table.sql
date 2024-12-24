
-- Print all mymovies along with their movie_title, budget, revenue, currency and unit. [INNER JOIN]
	SELECT 
            m.m_id, movie_title, budget, revenue, currency, unit 
	FROM mymovies m
	INNER JOIN financials f
	ON m.m_id=f.m_id;

-- Perform LEFT JOIN on above discussed scenario
	SELECT 
            m.m_id, movie_title, budget, revenue, currency, unit 
	FROM mymovies m
	LEFT JOIN financials f
	ON m.m_id=f.m_id;

-- Perform RIGHT JOIN on above discussed scenario
	SELECT 
            m.m_id, movie_title, budget, revenue, currency, unit 
	FROM mymovies m
	RIGHT JOIN financials f
	ON m.m_id=f.m_id;

-- Perform FULL JOIN using 'Union' on above two tables [mymovies, financials]
	SELECT 
            m.m_id, movie_title, budget, revenue, currency, unit 
	FROM mymovies m
	LEFT JOIN financials f
	ON m.m_id=f.m_id

	UNION

	SELECT 
            m.m_id, movie_title, budget, revenue, currency, unit 
	FROM mymovies m
	RIGHT JOIN financials f
	ON m.m_id=f.m_id;

-- Interchanging the position of Left and Right Tables
	Select 
	    m.m_id, movie_title, revenue 
	from mymovies m 
        left join financials f
        on m.m_id = f.m_id;

	Select 
	    m.m_id, movie_title, revenue 
	from financials f 
        left join mymovies m
        on m.m_id = f.m_id;

-- Replacing 'ON' with 'USING' while joining conditions
	Select 
	   m.m_id, movie_title, revenue 
	from mymovies m 
        left join financials f
	USING (m_id);
      

   
	
-- Print a list of final menu items along with their price for a restaurant.
	SELECT 
           *, 
           CONCAT(name, " - ", variant_name) as full_name,
           (price+variant_price) as full_price
	FROM food_db.items
	CROSS JOIN food_db.variants;



-- Find profit for all mymovies 
	SELECT 
           m.m_id, movie_title, budget, revenue, currency, unit, 
	   (revenue-budget) as profit 
	FROM mymovies m
	JOIN financials f
	ON m.m_id=f.m_id;

-- Find profit for all mymovies in bollywood
	SELECT 
           m.m_id, movie_title, budget, revenue, currency, unit, 
	   (revenue-budget) as profit 
	FROM mymovies m
	JOIN financials f
	ON m.m_id=f.m_id
	WHERE m.industry="Bollywood";

-- Find profit of all bollywood mymovies and sort them by profit amount (Make sure the profit be in millions for better comparisons)
	SELECT 
    	    m.m_id, movie_title revenue, currency, unit, 
            CASE 
                WHEN unit="Thousands" THEN ROUND((revenue-budget)/1000,2)
        	WHEN unit="Billions" THEN ROUND((revenue-budget)*1000,2)
                ELSE revenue-budget
            END as profit_mln
	FROM mymovies m
	JOIN financials f 
	ON m.m_id=f.m_id
	WHERE m.industry="Bollywood"
	ORDER BY profit_mln DESC;






-- Show comma separated actor names for each movie
	SELECT 
            m.movie_title, group_concat(name separator " | ") as actors
	FROM mymovies m
	JOIN movie_actor ma ON m.m_id=ma.m_id
	JOIN actors a ON a.actor_id=ma.actor_id
	GROUP BY m.m_id;

-- Print actor name and all the mymovies they are part of
	SELECT 
            a.name, GROUP_CONCAT(m.movie_title SEPARATOR ' | ') as mymovies
	FROM actors a
	JOIN movie_actor ma ON a.actor_id=ma.actor_id
	JOIN mymovies m ON ma.m_id=m.m_id
	GROUP BY a.actor_id;

-- Print actor name and how many mymovies they acted in
	SELECT 
            a.name, 
            GROUP_CONCAT(m.movie_title SEPARATOR ' | ') as mymovies,
            COUNT(m.movie_title) as num_mymovies
	FROM actors a
	JOIN movie_actor ma ON a.actor_id=ma.actor_id
	JOIN mymovies m ON ma.m_id=m.m_id
	GROUP BY a.actor_id
	ORDER BY num_mymovies DESC;
    



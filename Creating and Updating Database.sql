


-- Simple insert for new record in mymovies
	INSERT INTO mymovies VALUES (121, "babul", "Bollywood", 2020, 8.0, "Arka Media Works", 2);

-- Insert with NULL or DEFAULT values
	INSERT INTO mymovies VALUES (142, "Thor 10", "Hollywood", NULL, DEFAULT, "Marvel Studios", 5);

-- Same insert with column names
	INSERT INTO mymovies (m_id, movie_title, movie_industry, lang_id) VALUES (143, "Pushpa 5", "Bollywood", 2);

-- Insert with invalid language_id. Foreign key constraint fails
	INSERT INTO mymovies (m_id, movie_title, movie_industry, lang_id) VALUES (144, "Pushpa 6", "Bollywood", 10);

-- Insert multiple rows
	INSERT INTO mymovies 
    	     (m_id, movie_title, movie_industry, lang_id)
	VALUES 
    	     (145, "Inception 2", "Hollywood", 5),
             (146, "Inception 3", "Hollywood", 5),
             (147, "Inception 4", "Hollywood", 5);


-- Say THOR 10 movie is released in 2050, and you want to update the rating now :)
	UPDATE mymovies 
	SET imdb_rating=8, release_year=2050
	WHERE m_id=142;

-- Update multiple records. [Update all studios with 'Warner Bros. Pictures' for all the Inception mymovies records] 
	UPDATE mymovies 
	SET studio='Warner Bros. Pictures'
	WHERE movie_title like "Inception %";

-- Delete all new inception mymovies
	DELETE FROM mymovies 
	WHERE  movie_title like "Inception %";

-- Another delete to restore the database to normal again
	DELETE FROM mymovies 
	WHERE m_id in (141, 142, 143);

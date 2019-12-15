-- --#SET TERMINATOR @@
-- CREATE TRIGGER JohnDirectorTrigger
-- 	BEFORE INSERT ON Cast
-- 	REFERENCING NEW ROW AS NewTuple
-- 	FOR EACH ROW

-- BEGIN 
-- IF ( NewTuple.actor = (SELECT p FROM Person WHERE name = 'John Malkovich')   AND NewTuple.actor NOT IN (SELECT p FROM director)  )  
-- THEN
-- INSERT INTO Director(p, dguild) values
-- (NewTuple.actor , 1)
-- ;END IF;

-- IF ( NewTuple.actor = (SELECT p FROM Person WHERE name = 'John Malkovich')  AND  (NewTuple.actor,NewTuple.Studio) NOT IN (SELECT * FROM Affiliated)  ) 
-- THEN
-- INSERT INTO Affiliated(director, studio) VALUES (NewTuple.actor, NewTuple.studio)
-- ;END IF;

-- IF (NewTuple.actor = (SELECT p FROM Person WHERE name = 'John Malkovich')) THEN
-- UPDATE MOVIE 
-- SET director = NewTuple.actor
-- where NewTuple.title = Movie.title AND NewTuple.year = Movie.year
-- ;END IF
-- ;END @@
-- --#SET TERMINATOR ;


--#SET TERMINATOR @@
CREATE TRIGGER JohnDirectorTrigger
	BEFORE INSERT ON Cast
	REFERENCING NEW ROW AS NewTuple
	FOR EACH ROW

BEGIN 
IF ( NewTuple.actor = (SELECT p FROM Person WHERE name = 'John Malkovich')   AND NewTuple.actor NOT IN (SELECT p FROM director)  )  
THEN
INSERT INTO Director(p, dguild) values
(NewTuple.actor , 1)
;END IF;

IF ( NewTuple.actor = (SELECT p FROM Person WHERE name = 'John Malkovich')  AND  (NewTuple.actor,NewTuple.Studio) NOT IN (SELECT * FROM Affiliated)  ) 
THEN
INSERT INTO Affiliated(director, studio) VALUES (NewTuple.actor, NewTuple.studio)
;END IF;

IF (NewTuple.actor = (SELECT p FROM Person WHERE name = 'John Malkovich')) THEN
UPDATE MOVIE 
SET director = NewTuple.actor
where NewTuple.title = Movie.title AND NewTuple.year = Movie.year
;END IF
;END @@
--#SET TERMINATOR ;



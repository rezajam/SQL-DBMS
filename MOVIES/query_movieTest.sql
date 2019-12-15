--Rules: **** means important and the main point.

--===========Q1==========================================
--the following query selects every tuple(because of confusion of question) 
--from Person table in which the name is John Malkovich
--even if its the same name but different p#
select *
from (select per.p 
	  from Person per where per.name = 'John Malkovich')AA, 	
	 Cast cas
where cas.actor = AA.p ;


--table:
--P           TITLE                                              STUDIO                                             YEAR        ROLE                                               ACTOR       MINUTES    
----------- -------------------------------------------------- -------------------------------------------------- ----------- -------------------------------------------------- ----------- -----------
  --         1 SHAQFU the return of shaq obviously                Jarek Studio                                              2006 is there                                                     1         115
  --        12 Drug Lord Man Guy                                  Jurassic Park Maker                                       2002 lead villian                                                12          50

  -- 2 record(s) selected.


--===========Q2==========================================
--The following queries are about the issue of having a solid director for any movie possible

--initially we can accept movies with no directors. (Director is null)
insert into Movie ( title, studio, year, genre, director, length ) values ('Marmoulak', 'DisKnee', 2222,'comedy', null, 180);

--following table shows the insertion of such tuples with null table. 
-- Looking at the following line of query, The 'Marmoulak' is clearly inserted with no directors.
select * from Movie;


--table:
-- TITLE                                              STUDIO                                             YEAR        GENRE                                              DIRECTOR    LENGTH     
-- -------------------------------------------------- -------------------------------------------------- ----------- -------------------------------------------------- ----------- -----------
-- Drug Lord Man Guy                                  Jurassic Park Maker                                       2002 romance                                                      7         110
-- Tin Tin                                            Lucas arts                                                2021 action                                                       8          20
-- SHAQFU the return of shaq obviously                Jarek Studio                                              2006 comedy                                                       1         130
-- THE                                                Jarek Studio                                              2020 horror                                                       6         110
-- Tin Tin                                            FOB co                                                    2021 horror                                                      11         110
-- Marmoulak                                          DisKnee                                                   2222 comedy                                                       -         180

--   6 record(s) selected.

--now we need to delete intially set null values of the directors in the Movie table 
--so by modifying the table's constraints or creating a trigger, table allow us to not accept any null values for director from any 
--future inserting tuples to the table.
delete from Movie where Movie.director is null;




-- with this we double check that the table is clear of director null values.
select * from Movie;

--table:
-- TITLE                                              STUDIO                                             YEAR        GENRE                                              DIRECTOR    LENGTH     
-- -------------------------------------------------- -------------------------------------------------- ----------- -------------------------------------------------- ----------- -----------
-- Drug Lord Man Guy                                  Jurassic Park Maker                                       2002 romance                                                      7         110
-- Tin Tin                                            Lucas arts                                                2021 action                                                       8          20
-- SHAQFU the return of shaq obviously                Jarek Studio                                              2006 comedy                                                       1         130
-- THE                                                Jarek Studio                                              2020 horror                                                       6         110
-- Tin Tin                                            FOB co                                                    2021 horror                                                      11         110

--   5 record(s) selected.




-- ****** Now this is the query that we need to insert in order to check if the inserting tuple is not null.
-- it does it by setting the foreign key of the Director to not null. So all of the existing tuples has a value and its not null.
-- therefore they are all coming from their parent table, Director. 
-- ( so every Movie has a Director. )
ALTER TABLE Movie
	ADD CONSTRAINT Movie_Director_Check check( Director is not null);

--now we can see that the above check constraint called Movie_Director_Check doesn't allow any tuples with null as director to be inserted 
-- as this bottom query of insert with the same null value doesn't work and give the error
-- DB21034E  The command was processed as an SQL statement because it was not a 
-- valid Command Line Processor command.  During SQL processing it returned:
-- SQL0545N  The requested operation is not allowed because a row does not 
-- satisfy the check constraint "REZAJAM.MOVIE.MOVIE_DIRECTOR_CHECK".
insert into Movie ( title, studio, year, genre, director, length ) values ('Marmoulak', 'DisKnee', 2222,'comedy', null, 180);

--===========Q3==========================================
--The following queries are about the fact that if we delete a director, therefore no movie with the same director should exist.

--this following query shows the initial state of both Director and Movie tables with all the inserted directors p#.
select * from Director;
select * from Movie;

--table:
-- P           DGUILD     
-- ----------- -----------
--           1           2
--           7           3
--           8           3
--          11          11
--           2          23
--           6           2

--   6 record(s) selected.



--table:
-- TITLE                                              STUDIO                                             YEAR        GENRE                                              DIRECTOR    LENGTH     
-- -------------------------------------------------- -------------------------------------------------- ----------- -------------------------------------------------- ----------- -----------
-- Drug Lord Man Guy                                  Jurassic Park Maker                                       2002 romance                                                      7         110
-- Tin Tin                                            Lucas arts                                                2021 action                                                       8          20
-- SHAQFU the return of shaq obviously                Jarek Studio                                              2006 comedy                                                       1         130
-- THE                                                Jarek Studio                                              2020 horror                                                       6         110
-- Tin Tin                                            FOB co                                                    2021 horror                                                      11         110

--   5 record(s) selected.




--***** now the following queries are the main point.
--this below query drops the already inserted by the schema constraint by using "alter table" and given the name of constraint.
ALTER TABLE Movie 
	DROP CONSTRAINT Movie_FK_director;

--*****this below query adds a new constraint to Movie table in order to make a foreign key for Director p# constraint with "ON DELETE CASCADE"
--the reason is so that upon deletion of director (parent table) the entire tuple from Movie(Child parent) table is deleted then.
-- (Hence there are no more Movies upon deletion of Director)
ALTER TABLE Movie
	ADD CONSTRAINT  Movie_FK_director_onDeleteCascade
	Foreign Key (Director) references Director(p)
	ON DELETE CASCADE;


--this below query goes drops the already inserted by the schema constraint by using "alter table" and given the name of constraint.
ALTER TABLE Affiliated
	DROP CONSTRAINT Affiliated_FK_director;

--*****this query as the results of deletion of Director(parent table) removes the Affiliated table (child) entire tuple, regarding that Director p#.
--the way it is possible is to add a new foreign key constraint and set the constarint as "on delete cascade".
--same way as above constraint addition query the Affiliated table will lose its entire tuple upon deletion of Director
ALTER TABLE Affiliated 
	ADD CONSTRAINT  Affiliated_FK_director_onDeleteCascade
	foreign key (director) references Director(p)
	ON DELETE CASCADE;


--*****this below query goes drops the already inserted by the schema constraint by using "alter table" and given the name of constraint.
ALTER TABLE Cast
	DROP CONSTRAINT Cast_FK_title_studio_year;

--*****this query as the results of deletion of Director(parent table) also remove the tuples from Cast table.
--it does it after deletion of the entire tuple from Movie and then as the repercotions of that, the Entire tuple related to 
--that movie's title, studio, year from cast.
--Again, like above add constraints, by "on delete cascade" it will delete all of the tuples from cast(child table), after the deletion from
--Movie (parent table)
ALTER TABLE Cast 
	ADD CONSTRAINT  Cast_FK_title_studio_year_onDeleteCascade
	foreign key (title, studio, year) references Movie
	ON DELETE CASCADE;

--*****now this is the test that delets the director with give p# form directors table entire tuple.
delete from director where p=7;

--this query shows the result of such deletion from Director and Movie table as it did as above and now we can see the changes of 
-- removal of tuples()

select * from Director;
select * from Movie;

--Table:
-- P           DGUILD     
-- ----------- -----------
--           1           2
--           8           3
--          11          11
--           2          23
--           6           2

--   5 record(s) selected.



--Table:
-- TITLE                                              STUDIO                                             YEAR        GENRE                                              DIRECTOR    LENGTH     
-- -------------------------------------------------- -------------------------------------------------- ----------- -------------------------------------------------- ----------- -----------
-- Tin Tin                                            Lucas arts                                                2021 action                                                       8          20
-- SHAQFU the return of shaq obviously                Jarek Studio                                              2006 comedy                                                       1         130
-- THE                                                Jarek Studio                                              2020 horror                                                       6         110
-- Tin Tin                                            FOB co                                                    2021 horror                                                      11         110

--   4 record(s) selected.




--===========Q4==========================================
--The following queries are about the fact that if a studio is making the movie it needs to have a director affiliated as well.

--the below query shows that we can insert a tuple with studio 'FOB co' and director p# 11 which are completely unrelated and not affiliated
--can be inserted without any errors inside the Movie table
insert into movie ( title, studio, year, genre, director, length ) values ('Marmoulak', 'FOB co',2222, 'horror', 11, 110);

--the select query here shows the results from the prior insertion in addition to initial mistaken insertions from insert_movie file as well
select * from Movie;

--table:
-- TITLE                                              STUDIO                                             YEAR        GENRE                                              DIRECTOR    LENGTH     
-- -------------------------------------------------- -------------------------------------------------- ----------- -------------------------------------------------- ----------- -----------
-- Marmoulak                                          FOB co                                                    2222 horror                                                      11         110
-- Tin Tin                                            Lucas arts                                                2021 action                                                       8          20
-- SHAQFU the return of shaq obviously                Jarek Studio                                              2006 comedy                                                       1         130
-- THE                                                Jarek Studio                                              2020 horror                                                       6         110
-- Tin Tin                                            FOB co                                                    2021 horror                                                      11         110

--   5 record(s) selected.


--here we delete all non affiliated tuples from the wrongly modified movie table above.
--this needs to be done otherwise the constraint will not work and since the inserted items are supposed to be correctly inserted
--the constraints will give us error if we already have some non affiliated tuples.
delete from Movie where (director, studio) not in (select * from Affiliated);

--****** so now we delete the current constraint from Movie for Director (added from query of question 3) using alter table.
ALTER TABLE Movie
	DROP CONSTRAINT Movie_FK_director_onDeleteCascade;

--****** we also remove the current Constraint for foreign key from Movie for studio using alter table
ALTER TABLE Movie
	DROP CONSTRAINT Movie_FK_studio;

--****** all of these constraints deletions were made in order to make a new Constraint with a tuple (director , studio) for Affiliated 
--******the reason is that this constraints will ensure that director and studio tuples are coming from their parent table in mind in 
--******this question Affiliated from Movie(child table), therefore the relation needed for this query is correct and ensured all the time.
ALTER TABLE Movie 
	ADD CONSTRAINT Movie_directorXstudio
		foreign key (director, studio) references Affiliated(director, studio);


--****** now by inserting the same wrong tuple, this time we get this error regarding the newly made constraint Movie_directorXstudio
--error:
-- DB21034E  The command was processed as an SQL statement because it was not a 
-- valid Command Line Processor command.  During SQL processing it returned:
-- SQL0530N  The insert or update value of the FOREIGN KEY 
-- "REZAJAM.MOVIE.MOVIE_DIRECTORXSTUDIO" is not equal to any value of the parent 
-- key of the parent table.  SQLSTATE=23503
insert into movie ( title, studio, year, genre, director, length ) values ('Marmoulak', 'FOB co',2222, 'horror', 11, 110);


--shows the table after all of the initial deletion and not allowing any nonaffiliated director and studios to be inserted.
select * from Movie;

--table:
-- TITLE                                              STUDIO                                             YEAR        GENRE                                              DIRECTOR    LENGTH     
-- -------------------------------------------------- -------------------------------------------------- ----------- -------------------------------------------------- ----------- -----------
-- Tin Tin                                            Lucas arts                                                2021 action                                                       8          20
-- SHAQFU the return of shaq obviously                Jarek Studio                                              2006 comedy                                                       1         130
-- THE                                                Jarek Studio                                              2020 horror                                                       6         110

--   3 record(s) selected.



--===========Q5==========================================
-- the following queries is about the fact that if we add 'John Malcovich' as the actor for a movie automatically that movie must be 
--also directed by him as well.
 


-- for this query I made a trigger named John Director Trigger

--this will give us the character to break the reading cycle of the trigger after all the IF statements.
--#SET TERMINATOR @@
CREATE TRIGGER JohnDirectorTrigger
	--upon insertion of the new tuple on cast 
	AFTER INSERT ON Cast
	--called New Tuple
	REFERENCING NEW ROW AS NewTuple
	--the changes in each tuple.
	FOR EACH ROW
-- I used begin, because there must be mutliple if statements used in order to make the tigger happen.
BEGIN 

-- now supposing if there are no John Malkovich as the director in our inserted table we need to insert them 
	IF ( NewTuple.actor = (SELECT p FROM Person WHERE name = 'John Malkovich')  AND NewTuple.actor NOT IN (SELECT p FROM director)  ) 
	THEN

--we insert the tuple with dguild# of 1 as the currently given actor p# of John Malcovitch to director table.
	INSERT INTO Director(p, dguild) values (NewTuple.actor , 1)
	;END IF



--we then need to consider the situation where the NewTuple are not in affiliated in which since the tuple inserted in movie is correct
--it must be inserted too.
	;IF   ( NewTuple.actor = (SELECT p FROM Person WHERE name = 'John Malkovich')  AND  (NewTuple.actor,NewTuple.Studio) NOT IN (SELECT * FROM Affiliated)  ) 
	THEN

-- the insertion happens by inserting the given actor p# of John Malcovitch and the studio given in movie tuple.(supposing it is correct)
	INSERT INTO Affiliated(director, studio) VALUES (NewTuple.actor, NewTuple.studio)
	;END IF


--******* now if the given tuple has the given actor p# of John Malcovitch then,
	;IF (NewTuple.actor = (SELECT p FROM Person WHERE name = 'John Malkovich'))
	THEN

--***** we update the Movie table and update(set) the director attribute in that tuple to given actor p# of John Malcovitch.
	UPDATE MOVIE 
	SET director = NewTuple.actor

--we do this only in case of having the same Primary key attibutes Year and Title.
	where NewTuple.title = Movie.title AND NewTuple.year = Movie.year
	;END IF

--we finish everything then by using the inistial charachters to stop reading again.
;END @@

-- now we set the character of finishig of reading of each query back to semicolon.
--#SET TERMINATOR ;


--shows the before insertion of requested type of tuple of tables cast and movie
select * from cast;
select * from movie;


-- TITLE                                              STUDIO                                             YEAR        ROLE                                               ACTOR       MINUTES    
-- -------------------------------------------------- -------------------------------------------------- ----------- -------------------------------------------------- ----------- -----------
-- Tin Tin                                            Lucas arts                                                2021 lead actor                                                   3         110
-- Tin Tin                                            Lucas arts                                                2021 lead actress                                                 5         105
-- Tin Tin                                            Lucas arts                                                2021 supporting actor                                             3          75
-- Tin Tin                                            Lucas arts                                                2021 supporting actress                                           6          85
-- SHAQFU the return of shaq obviously                Jarek Studio                                              2006 is there                                                     1         115
-- SHAQFU the return of shaq obviously                Jarek Studio                                              2006 why                                                          4         115
-- SHAQFU the return of shaq obviously                Jarek Studio                                              2006 not in the movie lol                                         6         115

--   7 record(s) selected.



-- TITLE                                              STUDIO                                             YEAR        GENRE                                              DIRECTOR    LENGTH     
-- -------------------------------------------------- -------------------------------------------------- ----------- -------------------------------------------------- ----------- -----------
-- Tin Tin                                            Lucas arts                                                2021 action                                                       8          20
-- SHAQFU the return of shaq obviously                Jarek Studio                                              2006 comedy                                                       1         130
-- THE                                                Jarek Studio                                              2020 horror                                                       6         110

--   3 record(s) selected.



--this insertion will give us the not only the already John Malcovich played but interestingly same named director but diff p# as 12.
insert into cast(title,studio,year,role,actor,minutes) values ('SHAQFU the return of shaq obviously', 'Jarek Studio', 2006, 'main', 12, 120);

--shows the after insertion of requested type of tuple of tables cast and movie
select * from cast;
select * from movie;



-- TITLE                                              STUDIO                                             YEAR        ROLE                                               ACTOR       MINUTES    
-- -------------------------------------------------- -------------------------------------------------- ----------- -------------------------------------------------- ----------- -----------
-- Tin Tin                                            Lucas arts                                                2021 lead actor                                                   3         110
-- Tin Tin                                            Lucas arts                                                2021 lead actress                                                 5         110
-- Tin Tin                                            Lucas arts                                                2021 supporting actor                                             3         110
-- Tin Tin                                            Lucas arts                                                2021 supporting actress                                           6         110
-- SHAQFU the return of shaq obviously                Jarek Studio                                              2006 is there                                                     1         120
-- SHAQFU the return of shaq obviously                Jarek Studio                                              2006 why                                                          4         120
-- SHAQFU the return of shaq obviously                Jarek Studio                                              2006 not in the movie                                             6         120
-- SHAQFU the return of shaq obviously                Jarek Studio                                              2006 main                                                        12         120

--   8 record(s) selected.




--as you see the records have been changed now to 12 from 1.
-- TITLE                                              STUDIO                                             YEAR        GENRE                                              DIRECTOR    LENGTH     
-- -------------------------------------------------- -------------------------------------------------- ----------- -------------------------------------------------- ----------- -----------
-- Tin Tin                                            Lucas arts                                                2021 action                                                       8          20
-- SHAQFU the return of shaq obviously                Jarek Studio                                              2006 comedy                                                      12         130
-- THE                                                Jarek Studio                                              2020 horror                                                       6         110

--   3 record(s) selected.




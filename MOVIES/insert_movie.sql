-- --=============================================================================================================
-- insert some data into the tables

 
--Person(p#,name,birthdate,nationality,gender)
--  PK (p)
insert into person (p#, name, birthdate, nationality, gender) values
 (1,'John Malkovich', '1995-12-12', 'Canada', 'Male'),
 (2,'Parviz Parastouie', '2001-08-13', 'Iran', 'Male'),
 (3,'Brad Pitbull', '2014-12-14', 'Japan', 'Male'),
 (4,'Damn Daniel', '2015-11-15', 'USA', 'Male'),
 (5,'Guy Fiery', '2016-12-16', 'Afghanistan', 'Female'),
 (6,'Kendrick Lamar', '2017-12-17', 'Dagestan', 'Female'),
 (7, 'Lebron Jordan', '1996-11-27', 'SpaceFam', 'Male'),
 (8,'Russell Peters', '1998-11-23', 'India', 'Male'),
 (9,'David Davidman', '1989-11-24', 'Davidstan', 'Male'),
 (10,'Mr Anderson', '1999-11-23', 'ThatMoviestan', 'Male'),
 (11,'Neo Anderson', '1993-12-22', 'theMAtrixstan', 'Female'),

 --mytest
 (12,'John Malkovich', '2016-12-14', 'YEEHAAA', 'Female');



-- Actor(p,aguild)
--  FK (p) refs Person
--  PK (p)
insert into actor(p#, aguild#) values
 (1,25),
 (2,1),
 (3,1),
 (4,1),
 (5,1),
 (6,1),
 (9,77),
 --mytest
 (12,null);
 

-- Writer(p#, wguild#)
--  FK (p#) refs Person
--  PK (p)
insert into writer(p#, wguild#) values
 (12,33),
 (6,8),
 (11,1),
 (10,2),
 (8,8);
 

-- Director(p#,dguild#)
--  FK (p#) refs Person
--  PK (p)
insert into director(p#, dguild#) values
 --(12,12),
 (1,2),
 (7,3),
 (8,3),
 (11,11),
 (2,23),


--testinn
 (6, 2);
 


-- Studio(name)
-- PK(name)
insert into studio(name) values
 ('DisKnee'),
 ('Jurassic Park Maker'),
 ('Jarek Studio'),
 ('Lucas arts'),
 ('FOB co'),

 --testinnn
 ('B'),
 --my test
 ('AAA');
 

-- ScreenPlay(title,year)
-- PK(title,year)
insert into screenplay( title, year) values
  ('Drug Lord Man Guy', 2002),
 ('SHAQFU the return of shaq obviously', 2006),
 ('THE', 2020),
 ('Tin Tin', 2021),
 ('MEME LORD', 1995),

 --testinnnnn
 ('Marmoulak' , 2222);
 
 --mytest wronngg
 -- ('THE1', 2021);
 



-- Authored(title,year,writer)
--  FK (title, year) refs ScreenPlay
--  FK (writer) refs Writer (p#)
--  PK (title, year, writer)
insert into authored(title, year, writer) values
 ('Drug Lord Man Guy', 2002, 10),
 ('Tin Tin', 2021, 11),
 ('SHAQFU the return of shaq obviously', 2006, 10),
 ('THE', 2020, 11),
 ('MEME LORD', 1995, 11),
 ('MEME LORD', 1995 ,12),
 ('Marmoulak',2222,8);
 --insert into movie ( title, studio, year, genre, director, length ) values ( 'MEME LORD', 'AAA',2019, 'horror', null, 110 )


-- Affiliated(director,studio)
--  FK (director) refs Director (p#)
--  FK (studio) refs Studio (name)
--  PK (director, studio)
insert into affiliated(director, studio) values
 (7, 'Jurassic Park Maker'),
 (8, 'Lucas arts'),
 (1, 'Jarek Studio'),
 (11,'DisKnee'),
 (2, 'DisKnee'),
 (7, 'FOB co'),


--testinnnn
 (6, 'Jarek Studio');
 --mytest wromg
 --(1, 'AAA');


-- Movie(title,studio,year,genre,director,length)
--  FK (studio) refs Studio (name)
--  FK (director) refs Director (p#)

--then=====
---- constraint Movie_directorXstudio
--     foreign key (director, studio) references Affiliated(director, studio)
--     on delete cascade

-- PK (title,studio,year)
-- FK (title, year) refs ScreenPlay
insert into movie(title, studio, year, genre, director, length) values
 ('Drug Lord Man Guy', 'Jurassic Park Maker',2002, 'romance', 7, 110),
 ('Tin Tin', 'Lucas arts',2021, 'action', 8, 20),
 ('SHAQFU the return of shaq obviously', 'Jarek Studio',2006, 'comedy', 1, 130),
 ('THE', 'Jarek Studio',2020, 'horror', 6, 110),
 -- ('Marmoulak', 'FOB co',2222, 'horror', 11, 110),
 ('Tin Tin', 'FOB co',2021, 'horror', 11, 110);
 -- ('MEME LORD','Disknee', 1995 ,'horror',12, 110);
 -- ('Marmoulak', 'DisKnee', 2222,'comedy', 11, 180);
 --('THE',null, 2020, 'wwww', null, 180 );
 --my test  wronnggg
 --('THE', 'AAA',2020, 'horror', 7, 110);
 --('THE1', 'AAA',2021, 'horror', 1, 110);



-- Cast(title,studio,year,role,actor,minutes)
--  FK (title, studio, year) refs Movie
--  FK (actor) refs Actor (p#)
--  PK (title,studio,year,role,actor)
insert into cast(title,studio,year,role,actor,minutes) values
  
  ('Tin Tin', 'Lucas arts', 2021, 'lead actor',3, 110),
  ('Tin Tin', 'Lucas arts', 2021, 'lead actress',5, 110),
  ('Tin Tin', 'Lucas arts', 2021, 'supporting actor',3, 110),
  ('Tin Tin', 'Lucas arts', 2021, 'supporting actress',6, 110),
  ('Drug Lord Man Guy', 'Jurassic Park Maker',2002,'main actor',9, 2),
  ('Drug Lord Man Guy', 'Jurassic Park Maker',2002,'supporting actor',4, 2),
  ('Drug Lord Man Guy', 'Jurassic Park Maker',2002,'lead actor',6, 2),
  ('Drug Lord Man Guy', 'Jurassic Park Maker',2002,'supporting actress',6, 2),
  ('Drug Lord Man Guy', 'Jurassic Park Maker',2002,'lead villian',12, 2),
  ('SHAQFU the return of shaq obviously', 'Jarek Studio', 2006, 'is there', 1, 120),
  ('SHAQFU the return of shaq obviously', 'Jarek Studio', 2006, 'why', 4, 120),
  ('SHAQFU the return of shaq obviously', 'Jarek Studio', 2006, 'not in the movie', 6, 120);
  -- ('Marmoulak', 'DisKnee',2222, 'main guy',2, 180),
  -- ('Marmoulak', 'DisKnee',2222, 'main other guy',5, 180);
  

  

  
 
 
 
 
 
 
 
 


--creating tables:


--Person(p#,name,birthdate,nationality,gender)
--	PK (p)
create table Person (  
	p int not null,
	name VARCHAR(50),
	birthdate DATE,
	nationality varchar(50),
	gender varchar(50),

	constraint Person_PK 
		primary key (p)  
);


-- Actor(p,aguild)
-- 	FK (p) refs Person
--	PK (p)
create table Actor(
	p  int not null,
	aguild int,

	constraint Actor_PK
		primary key (p),
	constraint Actor_FK_p
		foreign key (p) references Person
);


-- Director(p#,dguild#)
-- 	FK (p#) refs Person
--	PK (p)
create table Director(
	p int not null,
	dguild int,

	constraint Director_PK
		primary key (p),
	constraint Director_FK_p
		foreign key (p) references Person
);

-- Writer(p#, wguild#)
-- 	FK (p#) refs Person
--	PK (p)
create table Writer(
	p int not null,
	wguild VARCHAR(50),

	constraint Writer_PK
		primary key (p),
	constraint Writer_FK_p
		foreign key (p) references Person
);


-- Studio(name)
-- PK(name)
create table Studio(
	name VARCHAR(50) not null,

	constraint Studio_PK
		primary key (name)
);


-- ScreenPlay(title,year)
-- PK(title,year)
create table ScreenPlay (
	title VARCHAR(50) not null,
	year smallint not null,

	constraint ScreenPlay_PK
		primary key (title,year)
);


-- Authored(title,year,writer)
-- 	FK (title, year) refs ScreenPlay
-- 	FK (writer) refs Writer (p#)
--	PK (title, year, writer)
create table Authored(
	title VARCHAR(50) not null,
	year int not null,
	writer int not null,

	constraint Authored_PK
		primary key (title, year, writer),
	constraint Authored_FK_title_year
		foreign key (title, year) references ScreenPlay,
	constraint Authored_FK_writer
		foreign key (writer) references Writer(p)
);


-- Affiliated(director,studio)
-- 	FK (director) refs Director (p#)
-- 	FK (studio) refs Studio (name)
--	PK (director, studio)
create table Affiliated(
	director int not null,
	studio VARCHAR(50) not null,

	constraint Affiliated_PK
		primary key (director, studio),
	constraint Affiliated_FK_director
		foreign key (director) references Director(p),
		--Q3 on delete cascade
	constraint Affiliated_FK_studio
		foreign key (studio) references Studio(name)

);


-- Movie(title,studio,year,genre,director,length)
-- 	FK (studio) refs Studio (name)
-- 	FK (title, year) refs ScreenPlay
-- 	FK (director) refs Director (p#)
-- 	PK (title,studio,year)
create table Movie(
	title VARCHAR(50) not null,
	studio VARCHAR(50) not null,
	year int not null,
	genre VARCHAR(50),
	-- director smallint not null,
	director int,
	length int,

	constraint Movie_PK
		primary key (title, studio, year),
	constraint Movie_FK_studio
		foreign key (studio) references Studio(name),
	constraint Movie_FK_title_year
		foreign key (title, year) references ScreenPlay,
	constraint Movie_FK_director
		foreign key (director) references Director(p)
		--Q3 on delete cascade

	-- constraint Movie_directorXstudio
	--     foreign key (director, studio) references Affiliated(director, studio)
	--     on delete cascade


	
);
--select m.title, m.studio, m.year, m.genre, m.director, m.length from Movie m, affiliated aff where m.director = aff.director AND aff.studio = m.studio

-- Cast(title,studio,year,role,actor,minutes)
-- 	FK (title, studio, year) refs Movie
-- 	FK (actor) refs Actor (p#)
--  PK(title,studio,year,role,actor)
create table Cast(
	title VARCHAR(50) not null,
	studio VARCHAR(50) not null,
	year int not null,
	role VARCHAR(50) not null,
	actor int not null,
	minutes int,

	constraint Cast_PK
		primary key (title, studio, year, role, actor),
	constraint Cast_FK_title_studio_year
		foreign key (title, studio, year) references Movie,
		--Q3 on delete cascade
	constraint Cast_FK_actor
		foreign key (actor) references Actor(p)
);



-- CREATE TRIGGER John_trigger
-- AFTER INSERT ON Cast
-- REFERENCING NEW ROW AS NewTuple
-- FOR EACH ROW

-- BEGIN
-- IF (  ( NewTuple.actor = (select p from Person where name = 'John Malkovich') ) AND (NewTuple) )


-- --#set Terminator @@
-- CREATE TRIGGER JohnDirectorTrigger
-- 	after INSERT ON Cast
-- 	REFERENCING NEW ROW AS NewTuple
-- 	for each row

-- BEGIN 
-- IF ( (NewTuple.actor = (select p from Person where name = 'John Malkovich') )  AND (NewTuple.actor NOT IN (select p FROM director) ) ) 
-- 	THEN
-- 	INSERT INTO Director(p, dguild) 
-- 		VALUES (NewTuple.actor , 1)
-- ;END IF

-- ;IF ( (NewTuple.actor = (select p from Person where name = 'John Malkovich') ) AND ( (NewTuple.actor,NewTuple.Studio) NOT IN (select (director,studio) from Affiliated) ) ) 
-- 	THEN
-- 	INSERT INTO Affiliated(director, studio) 
-- 		VALUES (NewTuple.actor, NewTuple.studio)
-- ;END IF

-- ;IF(NewTuple.actor = (select p from Person where name = 'John Malkovich')) THEN
-- 	UPDATE MOVIE 
-- 	SET director = NewTuple.actor
-- 	where NewTuple.title = Movie.title AND NewTuple.year = Movie.year
-- ;END IF
-- ;END @@
--#set Terminator ;

-- CREATE TRIGGER JohnDirectorTrigger
--     after INSERT ON cast
--       REFERENCING NEW ROW AS NewTuple
--       for each row
--      begin
-- 		when(Newtuple.actor = 1)
-- 		update movie
-- 		set director = 1, studio = 'India Pictures'
-- 		where NewTuple.title = movie.title and NewTuple.year = movie.year;
-- 	end



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
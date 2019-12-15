--select *
--from (select per.p 
--	  from Person per where per.name = 'John Malkovich')AA, 	
--	 Cast cas
--where cas.actor = AA.p ;



SELECT (Aff.studio, aff.director)
						   FROM Affiliated Aff
						   WHERE Aff.director = Director AND aff.studio = studio


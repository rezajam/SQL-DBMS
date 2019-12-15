SELECT  c.name , p.day 
FROM pretty_purchase AS p, yrb_customer AS c 
where p.cid = c.cid AND p.day < '01/01/1998';

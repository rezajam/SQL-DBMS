select pur.cid, pur.title, pur.year from yrb_purchase pur GROUP BY pur.cid, pur.title, pur.year HAVING SUM(pur.qnty) = 2;
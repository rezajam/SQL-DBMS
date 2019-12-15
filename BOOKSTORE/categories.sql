SELECT cus.cid, 
       cus.NAME, 
       CC.cat, 
       CC.cost 
FROM   (SELECT BB.cid, 
               BB.cat, 
               Sum(BB.price) AS COST 
        FROM  (SELECT * 
               FROM   (SELECT OFF.club, 
                              OFF.title, 
                              OFF.year, 
                              OFF.price, 
                              boo.cat 
                       FROM   yrb_book boo, 
                              yrb_offer OFF 
                       WHERE  boo.title = OFF.title 
                              AND boo.year = OFF.year) AA, 
                      yrb_purchase pur 
               WHERE  pur.club = AA.club 
                      AND pur.year = AA.year 
                      AND pur.title = AA.title)BB 
        GROUP  BY BB.cid, 
                  BB.cat) CC, 
       yrb_customer cus 
WHERE  cus.cid = CC.cid; 

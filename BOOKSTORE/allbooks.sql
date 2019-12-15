SELECT cus.NAME, 
       ggg.cat, 
       ggg.language 
FROM   ( 
              SELECT bb.cid, 
                     gg.cat, 
                     gg.language 
              FROM  ( 
                              SELECT   aa.cid, 
                                       aa.cat, 
                                       aa.language , 
                                       Count(*) AS countbb 
                              FROM     ( 
                                                       SELECT DISTINCT pur.cid, 
                                                                       pur.title, 
                                                                       pur.year, 
                                                                       boo.cat, 
                                                                       boo.language 
                                                       FROM            yrb_purchase pur, 
                                                                       yrb_book boo 
                                                       WHERE           pur.title = boo.title 
                                                       AND             pur.year = boo.year 
                                                       AND             ( 
                                                                                       boo.cat , boo.language) IN
                                                                       ( 
                                                                                SELECT   cat, 
                                                                                         language 
                                                                                FROM     yrb_book boo
                                                                                GROUP BY cat, 
                                                                                         language 
                                                                                HAVING   Count(*)>1) ) AA
                              GROUP BY (aa.cid, aa.cat, aa.language)) bb, 
                     ( 
                              SELECT   cat, 
                                       language, 
                                       count(*) AS count 
                              FROM     yrb_book boo 
                              GROUP BY cat, 
                                       language 
                              HAVING   count(*)>1)gg 
              WHERE  gg.cat = bb.cat 
              AND    gg.language = bb.language 
              AND    bb.countbb = gg.count )ggg 
JOIN   yrb_customer cus 
ON     cus.cid = ggg.cid ;

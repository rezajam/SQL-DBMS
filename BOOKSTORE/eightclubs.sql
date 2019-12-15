SELECT o.title, o.year FROM yrb_book b, yrb_offer o WHERE o.title = b.title GROUP BY o.title, o.year HAVING COUNT(*) = 8;

select BB.club, BB.count FROM (select y.club ,COUNT(y.club) AS COUNT from yrb_member y GROUP BY y.club)BB WHERE BB.count = (select MIN (AA.count) FROM (select y.club ,COUNT(y.club) AS COUNT from yrb_member y GROUP BY y.club) AA)

select AA.CLUB , AA.COUNT from (select club, count(*) as count  from yrb_member group by club ) AA where AA.count <= ALL (select count(*) as count from yrb_member group by club)
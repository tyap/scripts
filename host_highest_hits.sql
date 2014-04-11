--Select app servers and times with the highest number of requests per minute in descenting order.
--
select c.name, to_date ('1970-01-01' , 'YYYY-MM-DD') + numtodsinterval (a.clock,'SECOND' ) time, max(a.value_max)
from trends_uint a, items b, hosts c
where a.itemid=b.itemid and b.TEMPLATEID = 46489 and b.hostid = c.HOSTID
group by c.name, to_date ('1970-01-01' , 'YYYY-MM-DD') + numtodsinterval (a.clock,'SECOND' )
order by 3 desc
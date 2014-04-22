--Select number of Tomcat requests per minute and load average per minute for a particular 
--client.

select to_date ('1970-01-01' , 'YYYY-MM-DD') + numtodsinterval (x.clock,'SECOND' ) time,
sum(x.value_min)/1000 min_req_per_min, sum(x.value_avg)/1000 avg_req_per_min, sum(x.value_max)/1000 max_req_per_min,
sum(y.value_min) min_ld_avg1, sum(y.value_avg) avg_ld_avg1, sum(y.value_max) max_ld_avg1
from
(
select b.hostid, a.clock, a.value_min, a.value_avg, a.value_max
from trends_uint a, items b, hosts c
where a.itemid=b.itemid and b.TEMPLATEID = 46489 and b.hostid = c.HOSTID and c.name like 'fgprd-200134-144956%'
) x,
(
select b.hostid, a.clock, a.value_min, a.value_avg, a.value_max
from trends a, items b, hosts c
where a.itemid=b.itemid and b.templateid = 23684 and b.hostid = c.HOSTID and c.name like 'fgprd-200134-144956%'
) y
Where x.hostid=y.hostid and x.clock=y.clock --and x.value_max between 100 and 4000 and y.value_max between 1 and 12
group by to_date ('1970-01-01' , 'YYYY-MM-DD') + numtodsinterval (x.clock,'SECOND')
order by 1

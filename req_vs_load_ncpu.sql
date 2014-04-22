--Select number of Tomcat requests per minute and load average per minute for all app servers
--with a specified number of CPUs.

select to_date ('1970-01-01' , 'YYYY-MM-DD') + numtodsinterval (x.clock,'SECOND' ) time,
sum(x.value_min)/1000 min_req_per_min, sum(x.value_avg)/1000 avg_req_per_min, sum(x.value_max)/1000 max_req_per_min,
sum(y.value_min) min_ld_avg1, sum(y.value_avg) avg_ld_avg1, sum(y.value_max) max_ld_avg1
from
(
select b.hostid, a.clock, a.value_min, a.value_avg, a.value_max
from trends_uint a, items b, hosts c
where a.itemid=b.itemid and b.TEMPLATEID = 46489 and b.hostid = c.HOSTID
) x,
(
select b.hostid, a.clock, a.value_min, a.value_avg, a.value_max
from trends a, items b, hosts c
where a.itemid=b.itemid and b.templateid = 23684 and b.hostid = c.HOSTID
) y,
(
select b.hostid, a.clock, a.value_min, a.value_avg, a.value_max
from trends_uint a, items b, hosts c
where a.itemid=b.itemid and b.templateid = 23671 and b.hostid = c.HOSTID and a.VALUE_MIN=6 and c.name like 'fgprd%'
) z
Where x.hostid=y.hostid and x.clock=y.clock and y.hostid=z.hostid and y.clock=z.clock
group by to_date ('1970-01-01' , 'YYYY-MM-DD') + numtodsinterval (x.clock,'SECOND')
order by 1

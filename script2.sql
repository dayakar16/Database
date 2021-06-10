SELECT p.person_name, l.location_address, DATE_FORMAT(d.delivery_time, "%W %M %e %Y") as delivery_date,
cast(d.delivery_time as time) as delivery_time, ifnull(r.overall_rating , 'No Rate') as overall_rating
FROM campus_eats_fall2020.order as o inner join
person as p on p.person_id=o.person_id left join
location as l on l.location_id=o.location_id left join
(select order_id, round(avg(overall_rating),2) as overall_rating 
from ratings group by order_id) as r on r.order_id=o.order_id left join
delivery d on d.delivery_id=o.delivery_id;
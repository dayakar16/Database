select d.driver_id, d.license_number, 
no_rate as number_of_rate, ontime_rating, courteous_rating
from driver d left join
(select driver_id, count(*) as no_rate, round(avg(ontime_rating),2) as ontime_rating,
round(avg(courteous_rating),2) as courteous_rating
from driver_rating
group by driver_id) as r on r.driver_id=d.driver_id
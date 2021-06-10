select p.person_name,
p.cell,
(case
when f.faculty_id is not null then 'Faculty'
when st.student_id is not null then 'Student'
when s.staff_id is not null then 'Staff'
else 'Other'
end) as person_kind,
ifnull((case
when f.faculty_id is not null then concat(f.title,' - ',f.highest_degree,' degree from ', f.degree_college)
when st.student_id is not null then concat(f.title,' - ',st.type,' of ', st.major)
when s.staff_id is not null then s.position
else 'Not Defined'
end),'Whitout Title') as title,
ifnull(price_rating, 'No Rate'),ifnull(food_rating, 'No Rate') as food_rating,
ifnull(courteous_rating, 'No Rate') as courteous_rating,ifnull(ontime_rating, 'No Rate') as ontime_rating
from person as p left join
faculty as f on f.person_id=p.person_id left join
student as st on st.person_id=p.person_id left join
staff as s on s.person_id=p.person_id left join
(
select o.person_id, round(avg(rr.price_rating),2) as price_rating, 
round(avg(rr.food_rating),2) as food_rating,
round(avg(dr.courteous_rating),2) as courteous_rating,
round(avg(dr.ontime_rating),2) as ontime_rating
from campus_eats_fall2020.order as o left join
restaurant_rating rr on rr.order_id=o.order_id left join
driver_rating dr on dr.order_id=o.order_id
group by o.person_id) as rate on rate.person_id=p.person_id;
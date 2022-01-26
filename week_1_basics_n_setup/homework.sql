
--3
select
count(*)
FROM public.yellow_tripdata
where to_char(tpep_pickup_datetime::date, 'MM-dd') = '01-15';

--4
with t as (
SELECT 
tpep_pickup_datetime,
max(tip_amount) as tipmax
FROM public.yellow_tripdata
group by tpep_pickup_datetime
)

select tpep_pickup_datetime
from public.yellow_tripdata
where tip_amount = (
select max(tipmax)
from t 
where to_char(tpep_pickup_datetime::date, 'MM') = '01'
);


--5
select dolocationid, count(*)
from public.yellow_tripdata
where to_char(tpep_pickup_datetime::date, 'MM-dd') = '01-14'
and pulocation = 'Central Park'
group by dolocationid
order by 2;

--6
select avg(total_amount), pulocation , dolocation
from public.yellow_tripdata
group by pulocationid , dolocationid 
order by 1 desc;
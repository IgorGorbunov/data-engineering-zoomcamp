
--3 53024
select
count(*)
FROM public.yellow_taxi_trips
where to_char(tpep_pickup_datetime::date, 'MM-dd') = '01-15';

--4 2021-01-20
with t as (
SELECT 
tpep_pickup_datetime,
max(tip_amount) as tipmax
FROM public.yellow_taxi_trips
group by tpep_pickup_datetime
)

select tpep_pickup_datetime::date
from public.yellow_taxi_trips
where tip_amount = (
select max(tipmax)
from t 
where to_char(tpep_pickup_datetime::date, 'MM') = '01'
);


--5 Upper East Side South
select zdo."Zone", count(*)
from public.yellow_taxi_trips t
inner join public.zones zpu on
    t."PULocationID" = zpu."LocationID"
inner join public.zones zdo on
    t."DOLocationID" = zdo."LocationID"
where to_char(t.tpep_pickup_datetime::date, 'MM-dd') = '01-14'
and zpu."Zone" = 'Central Park'
group by zdo."Zone"
order by 2 DESC
limit 1;

--6 Alphabet City / Unknown
select avg(total_amount), zpu."Zone" , zdo."Zone"
from public.yellow_taxi_trips t
inner join public.zones zpu on
    t."PULocationID" = zpu."LocationID"
inner join public.zones zdo on
    t."DOLocationID" = zdo."LocationID"
group by zpu."Zone" , zdo."Zone"
order by 1 desc
limit 1;

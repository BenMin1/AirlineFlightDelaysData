
-- 1 (NO GOOD) actually good cuz of timezone differences
select scheduled_departure, scheduled_arrival, (fv.scheduled_arrival - fv.scheduled_departure) as calc, (INTERVAL '1 minute' * fv.scheduled_time) as scheduled_time 
from flights_view fv
where (fv.scheduled_arrival - fv.scheduled_departure) != (INTERVAL '1 minute' * fv.scheduled_time)

select count(*)
from flights_view fv
where (fv.scheduled_arrival - fv.scheduled_departure) != (INTERVAL '1 minute' * fv.scheduled_time)
 
 -- 2 (GOOD)
select elapsed_time, taxi_out, air_time, taxi_in
from flights_view fv
where elapsed_time != taxi_out + air_time + taxi_in

 -- 3 (overnight issue)
 select fv.scheduled_departure, fv.departure_time, (fv.departure_time - fv.scheduled_departure) as calc, (INTERVAL '1 minute' * fv.departure_delay) as delay
 from flights_view fv
 where (fv.departure_time - fv.scheduled_departure) != (INTERVAL '1 minute' * fv.departure_delay)
 
 select count(*) from flights_view fv 
 where (fv.departure_time - fv.scheduled_departure) != (INTERVAL '1 minute' * fv.departure_delay)

  -- 4 (overnight issue)
 select fv.scheduled_arrival, fv.arrival_time, (fv.arrival_time - fv.scheduled_arrival) as calc, (INTERVAL '1 minute' * fv.arrival_delay) as delay
 from flights_view fv
 where (fv.arrival_time - fv.scheduled_arrival) != (INTERVAL '1 minute' * fv.arrival_delay)
 
 select count(*) from flights_view fv
 where (fv.arrival_time - fv.scheduled_arrival) != (INTERVAL '1 minute' * fv.arrival_delay)
 
 -- 5 (overnight issue)
 select fv.departure_time, (INTERVAL '1 minute' * fv.taxi_out) as taxi_out, fv.wheels_off
 from flights_view fv
 where fv.wheels_off - fv.departure_time != (INTERVAL '1 minute' * fv.taxi_out);
 
 select count(*) from flights_view fv
 where (fv.arrival_time - fv.scheduled_arrival) != (INTERVAL '1 minute' * fv.arrival_delay)
 
  -- 6 (overnight issue)
 select fv.wheels_on, (INTERVAL '1 minute' * fv.taxi_in) as taxi_in, fv.arrival_time
 from flights_view fv
 where fv.arrival_time - fv.wheels_on != (INTERVAL '1 minute' * fv.taxi_in);
 
 select count(*) from flights_view fv
 where (fv.arrival_time - fv.scheduled_arrival) != (INTERVAL '1 minute' * fv.arrival_delay)
 
 -- 7 (one off)
 select fv.scheduled_time, fv.elapsed_time, fv.departure_delay, fv.arrival_delay
 from flights_view fv
 where fv.elapsed_time - scheduled_time + departure_delay != arrival_delay
 
 -- 8 (overnight)
 select fv.scheduled_departure, fv.wheels_off, fv.departure_delay, fv.taxi_out
 from flights_view fv
 where (INTERVAL '1 minute' * (fv.departure_delay + fv.taxi_out)) != fv.wheels_off - fv.scheduled_departure;
 
 select count(*)
 from flights_view fv
 where (INTERVAL '1 minute' * (fv.departure_delay + fv.taxi_out)) != fv.wheels_off - fv.scheduled_departure

-- DESCRIPTIVE STATS ANALYSIS

-------------------------
-- CARDINALITY
-------------------------
select 'airports' as table_name, count(*) from airports
union
select 'airlines' as table_name, count(*) from airlines
union
select 'flights' as table_name, count(*) from flights
union
select 'cancellation_codes' as table_name, count(*) from cancellation_codes;

-- confirming each flight entry is distinct and from the year 2015
select 'total', count(*) as total
from flights
union
SELECT 'total distinct', count(*) AS total
FROM (SELECT DISTINCT * FROM flights) as distinct_flights
union
select 'total in 2015', count(*) as totalcount
from flights f 
where f."YEAR" = '2015';

-------------------------
-- PRIMARY KEYS
-------------------------
select 'airports' as table_name, 
		count(*) as total,
		'iata_code' as column_name,
		count(distinct iata_code) as iata_code
from airports
union
select 'airlines' as table_name,
		count(*) as total,
		'iata_code' as column_name,
		count(distinct iata_code) as iata_code
from airlines
union
select 'cancellation_codes' as table_name,
		count(*) as total,
		'cancellation_reason' as column_name,
count(distinct cancellation_reason) as cancellation_reason
from cancellation_codes
union
select 'flights' as table_name, 
		count(*) as total,
		'iata_code' as column_name,
		count(distinct concat(f."MONTH", f."DAY", f.airline, f.flight_number, f.origin_airport, f.destination_airport, f.scheduled_departure)) as iata_code
from flights as f;

-------------------------
-- FOREIGN KEYS
-------------------------

-- cancellation_reason in flights table is a foreign key to the primary key cancellation_reason in cancellation_codes table
-- except for the fact that some cancellation_reason in the flights table are the empty string
with cancellationreason as (
select cancellation_reason from flights
except
select cancellation_reason from cancellation_codes
)
select count(*) from cancellationreason where cancellation_reason != '';

-- airline in flights table is a foreign key to the primary key iata_code in airlines table
with airline as (
select airline from flights
except
select iata_code from airlines
)
select count(*) from airline;

-- there are 307 destination_airports not in airports table (486,165 flights)
with destinationinflightnotairport as (
select destination_airport from flights
except
select iata_code from airports
)
select count(*) from destinationinflightnotairport;

select count(*) from flights f 
where destination_airport ~ '^[0-9]+$';

-- there are 306 destination_airports not in airports table (486,165 flights)
with origininflightnotairport as (
select origin_airport from flights
except
select iata_code from airports
)
select count(*) from origininflightnotairport;

select count(*) from flights f 
where origin_airport  ~ '^[0-9]+$';

-------------------------
-- NULLS
-------------------------
with null_values as (
select 'year' as colmun, COUNT(*) as count from flights f
where f."YEAR" is null or f."YEAR" = ''
union
select 'month' as colmun, COUNT(*) as count from flights f
where f."MONTH" is null or f."MONTH" = ''
union
select 'day' as colmun, COUNT(*) as count from flights f
where f."DAY" is null or f."DAY" = ''
union
select 'day of week' as colmun, COUNT(*) as count from flights f
where f.day_of_week is null or f.day_of_week = ''
union
select 'airline' as colmun, COUNT(*) as count from flights f
where f.airline is null or f.airline = ''
union
select 'flight number' as colmun, COUNT(*) as count from flights f
where f.flight_number is null or f.flight_number = ''
union
select 'tail number' as colmun, COUNT(*) as count from flights f
where f.tail_number is null or f.tail_number = ''
union
select 'origin airport' as colmun, COUNT(*) as count from flights f
where f.origin_airport is null or f.origin_airport = ''
union
select 'destination airport' as colmun, COUNT(*) as count from flights f
where f.destination_airport is null or f.destination_airport = ''
union
select 'scheduled departure' as colmun, COUNT(*) as count from flights f
where f.scheduled_departure is null or f.scheduled_departure = ''
union
select 'departure time' as colmun, COUNT(*) as count from flights f
where f.departure_time is null or f.departure_time = ''
union
select 'departure delay' as colmun, COUNT(*) as count from flights f
where f.departure_delay is null or f.departure_delay = ''
union
select 'taxi out' as colmun, COUNT(*) as count from flights f
where f.taxi_out is null or f.taxi_out = ''
union
select 'wheels off' as colmun, COUNT(*) as count from flights f
where f.wheels_off is null or f.wheels_off = ''
union
select 'scheduled time' as colmun, COUNT(*) as count from flights f
where f.scheduled_time is null or f.scheduled_time = ''
union
select 'elapsed time' as colmun, COUNT(*) as count from flights f
where f.elapsed_time is null or f.elapsed_time = ''
union
select 'air time' as colmun, COUNT(*) as count from flights f
where f.air_time is null or f.air_time = ''
union
select 'distance' as colmun, COUNT(*) as count from flights f
where f.distance is null or f.distance = ''
union
select 'wheels on' as colmun, COUNT(*) as count from flights f
where f.wheels_on is null or f.wheels_on = ''
union
select 'taxi in' as colmun, COUNT(*) as count from flights f
where f.taxi_in is null or f.taxi_in = ''
union
select 'scheduled arrival' as colmun, COUNT(*) as count from flights f
where f.scheduled_arrival is null or f.scheduled_arrival = ''
union
select 'arrival time' as colmun, COUNT(*) as count from flights f
where f.arrival_time is null or f.arrival_time = ''
union
select 'arrival delay' as colmun, COUNT(*) as count from flights f
where f.arrival_delay is null or f.arrival_delay = ''
union
select 'diverted' as colmun, COUNT(*) as count from flights f
where f.diverted is null or f.diverted = ''
union
select 'cancelled' as colmun, COUNT(*) as count from flights f
where f.cancelled is null or f.cancelled = ''
union
select 'cancellation reason' as colmun, COUNT(*) as count from flights f
where f.cancellation_reason is null or f.cancellation_reason = ''
union
select 'air system delay' as colmun, COUNT(*) as count from flights f
where f.air_system_delay is null or f.air_system_delay = ''
union
select 'security delay' as colmun, COUNT(*) as count from flights f
where f.security_delay is null or f.security_delay = ''
union
select 'airline delay' as colmun, COUNT(*) as count from flights f
where f.airline_delay is null or f.airline_delay = ''
union
select 'late aircraft delay' as colmun, COUNT(*) as count from flights f
where f.late_aircraft_delay is null or f.late_aircraft_delay = ''
union
select 'weather delay' as colmun, COUNT(*) as count from flights f
where f.weather_delay is null
)
select * from null_values order by count;

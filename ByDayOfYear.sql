-- new

drop view flight_arrival_delays;
create view flight_arrival_delays as
	select 
		"YEAR",
		"MONTH",
		"DAY",
		CASE
        	WHEN ("MONTH", "DAY") IN ((1,1), (1,2), (1,3), (1,4), (1,5)) THEN 'New Years 2015'
        	WHEN ("MONTH", "DAY") IN ((1,15), (1,16), (1,17), (1,18), (1,19), (1,20)) THEN 'MLKJ Day'
        	WHEN ("MONTH", "DAY") IN ((2,12), (2,13), (2,14), (2,15), (2,16), (2,17)) THEN 'Presidents Day'
        	WHEN ("MONTH", "DAY") IN ((4,2), (4,3), (4,4), (4,5), (4,6), (4,7)) THEN 'Easter'
        	WHEN ("MONTH", "DAY") IN ((5,21), (5,22), (5,23), (5,24), (5,25), (5,26)) THEN 'Memorial Day'
        	WHEN ("MONTH", "DAY") IN ((7,2), (7,3), (7,4), (7,5), (7,6), (7,7)) THEN 'Independance Day'
        	WHEN ("MONTH", "DAY") IN ((9,3), (9,4), (9,5), (9,6), (9,7), (9,8)) THEN 'Labor Day'
        	WHEN ("MONTH", "DAY") IN ((10,8), (10,9), (10,10), (10,11), (10,12), (10,13)) THEN 'Columbus Day'
        	WHEN ("MONTH", "DAY") IN ((10,29), (10,30), (10,31), (11,1), (11,2), (11,3)) THEN 'Halloween'
        	WHEN ("MONTH", "DAY") IN ((11,9), (11,10), (11,11), (11,12), (11,13)) THEN 'Veterans Day'
        	WHEN ("MONTH", "DAY") IN ((11,25), (11,26), (11,27), (11,28), (11,29), (11,30)) THEN 'Thanksgiving'
        	WHEN ("MONTH", "DAY") IN ((12,24), (12,25), (12,26), (12,27), (12,28)) THEN 'Christmas'
        	WHEN ("MONTH", "DAY") IN ((12,29), (12,30), (12,31)) THEN 'New Years 2016'
        	ELSE 'none'
    	END AS federal_holiday,
		case 
			when arrival_delay < 1 then 0
			else arrival_delay 
		end as arrival_delay,
		cancelled
	from flights_view
	where diverted is false;

-- total average arrival delay
select avg(arrival_delay) 
from flight_arrival_delays;

-- average arrival delay of each day of the year ordered from worst to best
select
	"MONTH", 
	"DAY", 
	avg(arrival_delay) as ave_delay 
from flight_arrival_delays
group by "YEAR", "MONTH", "DAY"
order by ave_delay desc;

-- holidays (no Columbus Day)
select 'Total Average' as federal_holiday, 
		avg(arrival_delay) as delay, 
		(COUNT(CASE WHEN cancelled THEN 1 END) / COUNT(*)::DECIMAL) * 100 AS cancellation_rate
from flight_arrival_delays
union
select federal_holiday, 
	   avg(arrival_delay) as delay, 
	   (COUNT(CASE WHEN cancelled THEN 1 END) / COUNT(*)::DECIMAL) * 100 AS cancellation_rate
from flight_arrival_delays
group by federal_holiday
having federal_holiday != 'none'
order by federal_holiday;



















-- old

select * from flights_view fv;

drop view flight_arrival_delays;
create view flight_arrival_delays as
	select 
		"YEAR",
		"MONTH",
		"DAY",
		"day_of_week",
		case 
			when arrival_delay < 1 then 0
			else arrival_delay 
		end as arrival_delay
	from flights_view
	where cancelled is false and diverted is false;

-- total average arrival delay
select avg(arrival_delay) 
from flight_arrival_delays;

-- average arrival delay of each day of the year
select 
	"YEAR", 
	"MONTH", 
	"DAY", 
	avg(arrival_delay) as ave_delay 
from flight_arrival_delays
group by "YEAR", "MONTH", "DAY"
order by "YEAR", "MONTH", "DAY";

-- average arrival delay of each day of week
select 
	"day_of_week", 
	avg(arrival_delay) as ave_delay 
from flight_arrival_delays
group by "day_of_week"
order by "day_of_week";

-- holidays
select 'Total Average' as federal_holiday, avg(arrival_delay) as delay from flight_arrival_delays
union
select 'New Years 2015' as federal_holiday, avg(arrival_delay) as delay from flight_arrival_delays
where ("MONTH", "DAY") IN ((1,1), (1,2), (1,3), (1,4), (1,5))
union
select 'MLKJ Day' as federal_holiday, avg(arrival_delay) as delay from flight_arrival_delays
where ("MONTH", "DAY") IN ((1,15), (1,16), (1,17), (1,18), (1,19), (1,20))
union
select 'Presidents Day' as federal_holiday, avg(arrival_delay) as delay from flight_arrival_delays
where ("MONTH", "DAY") IN ((2,12), (2,13), (2,14), (2,15), (2,16), (2,17))
union
select 'Easter' as federal_holiday, avg(arrival_delay) as delay from flight_arrival_delays
where ("MONTH", "DAY") IN ((4,2), (4,3), (4,4), (4,5), (4,6), (4,7))
union
select 'Memorial Day' as federal_holiday, avg(arrival_delay) as delay from flight_arrival_delays
where ("MONTH", "DAY") IN ((5,21), (5,22), (5,23), (5,24), (5,25), (5,26))
union
select 'Independance Day' as federal_holiday, avg(arrival_delay) as delay from flight_arrival_delays
where ("MONTH", "DAY") IN ((7,2), (7,3), (7,4), (7,5), (7,6), (7,7))
union
select 'Labor Day' as federal_holiday, avg(arrival_delay) as delay from flight_arrival_delays
where ("MONTH", "DAY") IN ((9,3), (9,4), (9,5), (9,6), (9,7), (9,8))
union
select 'Columbus Day' as federal_holiday, avg(arrival_delay) as delay from flight_arrival_delays -- data was messed up
where ("MONTH", "DAY") IN ((10,8), (10,9), (10,10), (10,11), (10,12), (10,13))
union
select 'Halloween' as federal_holiday, avg(arrival_delay) as delay from flight_arrival_delays
where ("MONTH", "DAY") IN ((10,29), (10,30), (10,31), (11,1), (11,2), (11,3))
union
select 'Veterans Day' as federal_holiday, avg(arrival_delay) as delay from flight_arrival_delays
where ("MONTH", "DAY") IN ((11,9), (11,10), (11,11), (11,12), (11,13))
union
select 'Thanksgiving' as federal_holiday, avg(arrival_delay) as delay from flight_arrival_delays
where ("MONTH", "DAY") IN ((11,25), (11,26), (11,27), (11,28), (11,29), (11,30))
union
select 'Christmas' as federal_holiday, avg(arrival_delay) as delay from flight_arrival_delays
where ("MONTH", "DAY") IN ((12,24), (12,25), (12,26), (12,27), (12,28), (12,29))
union
select 'New Years 2016' as federal_holiday, avg(arrival_delay) as delay from flight_arrival_delays
where ("MONTH", "DAY") IN ((12,29), (12,30), (12,31));

SELECT 
    CASE
        WHEN ("MONTH", "DAY") IN ((1,1), (1,2), (1,3), (1,4), (1,5)) THEN 'New Years 2015'
        WHEN ("MONTH", "DAY") IN ((1,15), (1,16), (1,17), (1,18), (1,19), (1,20)) THEN 'MLKJ Day'
        WHEN ("MONTH", "DAY") IN ((2,12), (2,13), (2,14), (2,15), (2,16), (2,17)) THEN 'Presidents Day'
        WHEN ("MONTH", "DAY") IN ((4,2), (4,3), (4,4), (4,5), (4,6), (4,7)) THEN 'Easter'
        WHEN ("MONTH", "DAY") IN ((5,21), (5,22), (5,23), (5,24), (5,25), (5,26)) THEN 'Memorial Day'
        WHEN ("MONTH", "DAY") IN ((7,2), (7,3), (7,4), (7,5), (7,6), (7,7)) THEN 'Independance Day'
        WHEN ("MONTH", "DAY") IN ((9,3), (9,4), (9,5), (9,6), (9,7), (9,8)) THEN 'Labor Day'
        WHEN ("MONTH", "DAY") IN ((10,8), (10,9), (10,10), (10,11), (10,12), (10,13)) THEN 'Columbus Day'
        WHEN ("MONTH", "DAY") IN ((10,29), (10,30), (10,31), (11,1), (11,2), (11,3)) THEN 'Halloween'
        WHEN ("MONTH", "DAY") IN ((11,9), (11,10), (11,11), (11,12), (11,13)) THEN 'Veterans Day'
        WHEN ("MONTH", "DAY") IN ((11,25), (11,26), (11,27), (11,28), (11,29), (11,30)) THEN 'Thanksgiving'
        WHEN ("MONTH", "DAY") IN ((12,24), (12,25), (12,26), (12,27), (12,28), (12,29)) THEN 'Christmas'
        WHEN ("MONTH", "DAY") IN ((12,29), (12,30), (12,31)) THEN 'New Years 2016'
        ELSE 'Total Average'
    END AS federal_holiday,
    AVG(arrival_delay) AS delay
FROM flight_arrival_delays
GROUP BY federal_holiday;

-- worst 15 days
select 
	"MONTH", 
	"DAY", 
	avg(arrival_delay) as average_delay 
from flight_arrival_delays 
group by "YEAR", "MONTH", "DAY" 
order by average_delay desc 
limit 15;

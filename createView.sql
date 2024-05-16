drop view flights_view;
CREATE VIEW flights_view AS
SELECT
	CASE
    	WHEN TRIM("YEAR") = '' THEN NULL
    	ELSE CAST("YEAR" AS INTEGER)
  	END AS "YEAR",
  	CASE
  		WHEN TRIM("MONTH") = '' THEN NULL
    	ELSE CAST("MONTH" AS INTEGER)
  	END AS "MONTH",
    CASE
  	 	WHEN TRIM("DAY") = '' THEN NULL
    	ELSE CAST("DAY" AS INTEGER)
  	END AS "DAY",
    CASE
  		WHEN TRIM("day_of_week") = '' THEN NULL
    	ELSE CAST("day_of_week" AS INTEGER)
  	END AS "day_of_week",
  	CASE
  	 	WHEN TRIM("airline") = '' THEN NULL
    	ELSE "airline"
  	END AS "arline",
  	CASE
  	 	WHEN TRIM("flight_number") = '' THEN NULL
    	ELSE CAST("flight_number" AS INTEGER)
  	END AS "flight_number",
    CASE
  	 	WHEN TRIM("tail_number") = '' THEN NULL
    	ELSE "tail_number"
  	END AS "tail_number",
    CASE
  	 	WHEN TRIM("origin_airport") = '' THEN NULL
    	ELSE "origin_airport"
  	END AS "origin_airport",
  	CASE
  	 	WHEN TRIM("destination_airport") = '' THEN NULL
    	ELSE "destination_airport"
  	END AS "destination_airport",
  	CASE
		WHEN TRIM("scheduled_departure") = '' THEN NULL
		WHEN "scheduled_departure" = '2400' then TO_TIMESTAMP("YEAR" || '-' || LPAD("MONTH", 2, '0') || '-' || LPAD("DAY", 2, '0') || ' ' || LPAD('0000', 4, '0'), 'YYYY-MM-DD HH24MI')
		ELSE TO_TIMESTAMP("YEAR" || '-' || LPAD("MONTH", 2, '0') || '-' || LPAD("DAY", 2, '0') || ' ' || LPAD("scheduled_departure", 4, '0'), 'YYYY-MM-DD HH24MI')
  	END AS "scheduled_departure",
  	CASE
		WHEN TRIM("departure_time") = '' THEN NULL
		WHEN "departure_time" = '2400' then TO_TIMESTAMP("YEAR" || '-' || LPAD("MONTH", 2, '0') || '-' || LPAD("DAY", 2, '0') || ' ' || LPAD('0000', 4, '0'), 'YYYY-MM-DD HH24MI')
		ELSE TO_TIMESTAMP("YEAR" || '-' || LPAD("MONTH", 2, '0') || '-' || LPAD("DAY", 2, '0') || ' ' || LPAD("departure_time", 4, '0'), 'YYYY-MM-DD HH24MI')
  	END AS "departure_time",
  	CASE
  	 	WHEN TRIM("departure_delay") = '' THEN NULL
    	ELSE CAST("departure_delay" AS INTEGER)
  	END AS "departure_delay",
   	CASE
  	 	WHEN TRIM("taxi_out") = '' THEN NULL
    	ELSE CAST("taxi_out" AS INTEGER)
  	END AS "taxi_out",
  	CASE
	  	WHEN TRIM("wheels_off") = '' THEN NULL
		WHEN "wheels_off" = '2400' then TO_TIMESTAMP("YEAR" || '-' || LPAD("MONTH", 2, '0') || '-' || LPAD("DAY", 2, '0') || ' ' || LPAD('0000', 4, '0'), 'YYYY-MM-DD HH24MI')
		ELSE TO_TIMESTAMP("YEAR" || '-' || LPAD("MONTH", 2, '0') || '-' || LPAD("DAY", 2, '0') || ' ' || LPAD("wheels_off", 4, '0'), 'YYYY-MM-DD HH24MI')
  	END AS "wheels_off",
  	CASE
  	 	WHEN TRIM("scheduled_time") = '' THEN NULL
    	ELSE CAST("scheduled_time" AS INTEGER)
  	END AS "scheduled_time",
    CASE
  		WHEN TRIM("elapsed_time") = '' THEN NULL
    	ELSE CAST("elapsed_time" AS INTEGER)
  	END AS "elapsed_time",
  	CASE
  	 	WHEN TRIM("air_time") = '' THEN NULL
    	ELSE CAST("air_time" AS INTEGER)
  	END AS "air_time",
    CASE
  	 	WHEN TRIM("distance") = '' THEN NULL
    	ELSE CAST("distance" AS INTEGER)
  	END AS "distance",
  	CASE
	  	WHEN TRIM("wheels_on") = '' THEN NULL
		WHEN "wheels_on" = '2400' then TO_TIMESTAMP("YEAR" || '-' || LPAD("MONTH", 2, '0') || '-' || LPAD("DAY", 2, '0') || ' ' || LPAD('0000', 4, '0'), 'YYYY-MM-DD HH24MI')
		ELSE TO_TIMESTAMP("YEAR" || '-' || LPAD("MONTH", 2, '0') || '-' || LPAD("DAY", 2, '0') || ' ' || LPAD("wheels_on", 4, '0'), 'YYYY-MM-DD HH24MI')
  	END AS "wheels_on",
    CASE
  		WHEN TRIM("taxi_in") = '' THEN NULL
    	ELSE CAST("taxi_in" AS INTEGER)
  	END AS "taxi_in",
  	CASE
	  	WHEN TRIM("scheduled_arrival") = '' THEN NULL
		WHEN "scheduled_arrival" = '2400' then TO_TIMESTAMP("YEAR" || '-' || LPAD("MONTH", 2, '0') || '-' || LPAD("DAY", 2, '0') || ' ' || LPAD('0000', 4, '0'), 'YYYY-MM-DD HH24MI')
		ELSE TO_TIMESTAMP("YEAR" || '-' || LPAD("MONTH", 2, '0') || '-' || LPAD("DAY", 2, '0') || ' ' || LPAD("scheduled_arrival", 4, '0'), 'YYYY-MM-DD HH24MI')
  	END AS "scheduled_arrival",
  	CASE
	  	WHEN TRIM("arrival_time") = '' THEN NULL
		WHEN "arrival_time" = '2400' then TO_TIMESTAMP("YEAR" || '-' || LPAD("MONTH", 2, '0') || '-' || LPAD("DAY", 2, '0') || ' ' || LPAD('0000', 4, '0'), 'YYYY-MM-DD HH24MI')
		ELSE TO_TIMESTAMP("YEAR" || '-' || LPAD("MONTH", 2, '0') || '-' || LPAD("DAY", 2, '0') || ' ' || LPAD("arrival_time", 4, '0'), 'YYYY-MM-DD HH24MI')
  	END AS "arrival_time",
  	CASE
  	 	WHEN TRIM("arrival_delay") = '' THEN NULL
    	ELSE CAST("arrival_delay" AS INTEGER)
  	END AS "arrival_delay",
    CASE
  	 	WHEN TRIM("diverted") = '' THEN NULL
    	ELSE   CAST("diverted" AS BOOLEAN)
  	END AS "diverted",
    CASE
  	 	WHEN TRIM("cancelled") = '' THEN NULL
    	ELSE  CAST("cancelled" AS BOOLEAN)
  	END AS "cancelled",
    CASE
  	 	WHEN TRIM("cancellation_reason") = '' THEN NULL
    	ELSE "cancellation_reason"
  	END AS "cancellation_reason",
    CASE
  	 	WHEN TRIM("air_system_delay") = '' THEN NULL
    	ELSE CAST("air_system_delay" AS INTEGER)
  	END AS "air_system_delay",
    CASE
  	 	WHEN TRIM("security_delay") = '' THEN NULL
    	ELSE CAST("security_delay" AS INTEGER)
  	END AS "security_delay",
    CASE
  	 	WHEN TRIM("airline_delay") = '' THEN NULL
   		ELSE CAST("airline_delay" AS INTEGER)
  	END AS "airline_delay",
    CASE
  	 	WHEN TRIM("late_aircraft_delay") = '' THEN NULL
    	ELSE CAST("late_aircraft_delay" AS INTEGER)
  	END AS "late_aircraft_delay",
 	CAST(WEATHER_DELAY AS INTEGER)
FROM flights f
WHERE EXISTS (SELECT 1 FROM airports a WHERE f.origin_airport = a.iata_code)
  AND EXISTS (SELECT 1 FROM airports a2 WHERE f.destination_airport = a2.iata_code);

select * from flights_view fv;
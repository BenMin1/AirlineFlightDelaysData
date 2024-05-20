CREATE VIEW delta_ATL_airtime_flights_view AS
SELECT 
	origin_airport AS airport_from, 
	destination_airport AS airport_to,
	AVG(air_time) AS total_airtime_avg,
	AVG(CASE WHEN airline = 'DL' THEN (air_time) ELSE NULL END) AS delta_airtime_avg,
	AVG(CASE WHEN airline = 'DL' THEN (air_time) ELSE NULL END) - AVG(air_time) AS diff_delta_airtime_avg,
	COUNT(*) AS num_all_flights,
	count(CASE WHEN airline = 'DL' THEN (1) ELSE NULL END) AS num_delta_flights
FROM flights_view fv
GROUP BY origin_airport, destination_airport
	HAVING COUNT(DISTINCT airline) > 1 AND COUNT(DISTINCT(CASE WHEN airline = 'DL' THEN airline ELSE NULL END)) > 0
ORDER BY origin_airport, destination_airport, diff_delta_airtime_avg DESC;

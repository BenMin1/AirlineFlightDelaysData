---Only select rows from 'flights' table whose origin and destination airports can be found on 'airports' table
SELECT *
FROM flights f
WHERE EXISTS (SELECT 1 FROM airports a WHERE f.origin_airport = a.iata_code)
  AND EXISTS (SELECT 1 FROM airports a2 WHERE f.destination_airport = a2.iata_code);

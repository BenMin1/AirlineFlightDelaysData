create table airlines (
IATA_CODE varchar,
AIRLINE varchar
);

create table airports (
IATA_CODE varchar,
AIRPORT varchar,
CITY varchar,
STATE varchar,
COUNTRY varchar,
LATITUDE varchar,
LONGITUDE varchar
);

create table cancellation_codes (
CANCELLATION_REASON varchar,
CANCELATION_DESCRIPTION varchar
);

create table flights (
"YEAR" varchar,
"MONTH" varchar,
"DAY" varchar,
DAY_OF_WEEK varchar,
AIRLINE varchar,
FLIGHT_NUMBER varchar,
TAIL_NUMBER varchar,
ORIGIN_AIRPORT varchar,
DESTINATION_AIRPORT varchar,
SCHEDULED_DEPARTURE varchar,
DEPARTURE_TIME varchar,
DEPARTURE_DELAY varchar,
TAXI_OUT varchar,
WHEELS_OFF varchar,
SCHEDULED_TIME varchar,
ELAPSED_TIME varchar,
AIR_TIME varchar,
DISTANCE varchar,
WHEELS_ON varchar,
TAXI_IN varchar,
SCHEDULED_ARRIVAL varchar,
ARRIVAL_TIME varchar,
ARRIVAL_DELAY varchar,
DIVERTED varchar,
CANCELLED varchar,
CANCELLATION_REASON varchar,
AIR_SYSTEM_DELAY varchar,
SECURITY_DELAY varchar,
AIRLINE_DELAY varchar,
LATE_AIRCRAFT_DELAY varchar,
WHEATHER_DELAY varchar
);
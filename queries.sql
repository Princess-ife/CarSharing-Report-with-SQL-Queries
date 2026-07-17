The sql queries 

-- =====================================================
-- CarSharing Demand Analysis - SQL Queries
-- Database: carsharing.db
-- Tables: CarSharing_df (fact table), time, temperature, weather
-- Linked by: CarSharing_df.id -> time.id
--            CarSharing_df.temp_code -> temperature.temp_code
--            CarSharing_df.weather_code -> weather.weather_code
-- =====================================================


-- =====================================================
-- QUESTION (a): Which date and time had the highest
-- demand rate in 2017?
-- =====================================================
-- Joins CarSharing_df with time (to get the actual date/time),
-- filters to 2017 only, sorts demand from highest to lowest,
-- and takes the single top row.

SELECT time.timestamp, CarSharing_df.demand
FROM CarSharing_df
JOIN time ON CarSharing_df.id = time.id
WHERE time.timestamp >= '2017-01-01 00:00:00' AND time.timestamp < '2018-01-01 00:00:00'
ORDER BY CarSharing_df.demand DESC
LIMIT 1;

-- Result: Highest demand = 6.458338283, on 2017-06-15 17:00:00


-- =====================================================
-- QUESTION (b): Weekday, month, and season with the
-- highest AND lowest average demand in 2017
-- =====================================================
-- Uses GROUP BY to calculate average demand per category,
-- then ORDER BY + LIMIT 1 to isolate the highest (DESC)
-- and lowest (ASC) for each category.

-- --- Weekday: highest ---
SELECT time.weekday, AVG(CarSharing_df.demand) AS avg_demand
FROM CarSharing_df
JOIN time ON CarSharing_df.id = time.id
WHERE time.timestamp >= '2017-01-01 00:00:00' AND time.timestamp < '2018-01-01 00:00:00'
GROUP BY time.weekday
ORDER BY avg_demand DESC
LIMIT 1;
-- Result: Saturday, 4.4114...

-- --- Weekday: lowest ---
SELECT time.weekday, AVG(CarSharing_df.demand) AS avg_demand
FROM CarSharing_df
JOIN time ON CarSharing_df.id = time.id
WHERE time.timestamp >= '2017-01-01 00:00:00' AND time.timestamp < '2018-01-01 00:00:00'
GROUP BY time.weekday
ORDER BY avg_demand ASC
LIMIT 1;
-- Result: Thursday, 4.1193...

-- --- Month: highest ---
SELECT time.month, AVG(CarSharing_df.demand) AS avg_demand
FROM CarSharing_df
JOIN time ON CarSharing_df.id = time.id
WHERE time.timestamp >= '2017-01-01 00:00:00' AND time.timestamp < '2018-01-01 00:00:00'
GROUP BY time.month
ORDER BY avg_demand DESC
LIMIT 1;
-- Result: July, 4.7877...

-- --- Month: lowest ---
SELECT time.month, AVG(CarSharing_df.demand) AS avg_demand
FROM CarSharing_df
JOIN time ON CarSharing_df.id = time.id
WHERE time.timestamp >= '2017-01-01 00:00:00' AND time.timestamp < '2018-01-01 00:00:00'
GROUP BY time.month
ORDER BY avg_demand ASC
LIMIT 1;
-- Result: January, 3.3883...

-- --- Season: highest ---
SELECT time.season, AVG(CarSharing_df.demand) AS avg_demand
FROM CarSharing_df
JOIN time ON CarSharing_df.id = time.id
WHERE time.timestamp >= '2017-01-01 00:00:00' AND time.timestamp < '2018-01-01 00:00:00'
GROUP BY time.season
ORDER BY avg_demand DESC
LIMIT 1;
-- Result: Fall, 4.6603...

-- --- Season: lowest ---
SELECT time.season, AVG(CarSharing_df.demand) AS avg_demand
FROM CarSharing_df
JOIN time ON CarSharing_df.id = time.id
WHERE time.timestamp >= '2017-01-01 00:00:00' AND time.timestamp < '2018-01-01 00:00:00'
GROUP BY time.season
ORDER BY avg_demand ASC
LIMIT 1;
-- Result: Spring, 3.6069...


-- =====================================================
-- QUESTION (c): Average demand by hour, for the weekdays
-- found in (b) - Saturday (highest) and Thursday (lowest)
-- =====================================================
-- Uses IN to filter for both weekdays at once, groups by
-- weekday AND hour together, sorted by avg demand descending.

SELECT time.weekday, time.hour, AVG(CarSharing_df.demand) AS avg_demand
FROM CarSharing_df
JOIN time ON CarSharing_df.id = time.id
WHERE time.timestamp >= '2017-01-01 00:00:00' AND time.timestamp < '2018-01-01 00:00:00'
  AND time.weekday IN ('Saturday', 'Thursday')
GROUP BY time.weekday, time.hour
ORDER BY avg_demand DESC;

-- Result: 48 rows (24 hours x 2 weekdays).
-- Highest: Saturday 17:00 (5.895). Lowest: Thursday 4:00 (1.099).
-- Peak hours cluster around 8am and 5-6pm (rush hour pattern).


-- =====================================================
-- QUESTION (d): 2017 weather overview
-- =====================================================

-- --- (d.1) Was 2017 mostly cold, mild, or hot? ---
-- Joins temperature table to get temp_category, counts hours per category.
SELECT temperature.temp_category, COUNT(*) AS count_of_hours
FROM CarSharing_df
JOIN temperature ON CarSharing_df.temp_code = temperature.temp_code
JOIN time ON CarSharing_df.id = time.id
WHERE time.timestamp >= '2017-01-01 00:00:00' AND time.timestamp < '2018-01-01 00:00:00'
GROUP BY temperature.temp_category
ORDER BY count_of_hours DESC;
-- Result: Mild (2735), Hot (2297), Cold (390) -> 2017 was mostly Mild

-- --- (d.2) Most prevalent weather condition in 2017 ---
-- Joins weather table to get the weather description, counts hours per condition.
SELECT weather.weather, COUNT(*) AS count_of_hours
FROM CarSharing_df
JOIN weather ON CarSharing_df.weather_code = weather.weather_code
JOIN time ON CarSharing_df.id = time.id
WHERE time.timestamp >= '2017-01-01 00:00:00' AND time.timestamp < '2018-01-01 00:00:00'
GROUP BY weather.weather
ORDER BY count_of_hours DESC;
-- Result: Clear or partly cloudy (3583), Mist (1366), Light snow or rain (473)

-- --- (d.3) Monthly wind speed: average, highest, lowest ---
SELECT time.month,
       AVG(CarSharing_df.windspeed) AS avg_windspeed,
       MAX(CarSharing_df.windspeed) AS max_windspeed,
       MIN(CarSharing_df.windspeed) AS min_windspeed
FROM CarSharing_df
JOIN time ON CarSharing_df.id = time.id
WHERE time.timestamp >= '2017-01-01 00:00:00' AND time.timestamp < '2018-01-01 00:00:00'
GROUP BY time.month
ORDER BY avg_windspeed DESC;
-- Result: 12 rows. Windiest months: March (15.97), April (15.85), February (15.58)

-- --- (d.4) Monthly humidity: average, highest, lowest ---
SELECT time.month,
       AVG(CarSharing_df.humidity) AS avg_humidity,
       MAX(CarSharing_df.humidity) AS max_humidity,
       MIN(CarSharing_df.humidity) AS min_humidity
FROM CarSharing_df
JOIN time ON CarSharing_df.id = time.id
WHERE time.timestamp >= '2017-01-01 00:00:00' AND time.timestamp < '2018-01-01 00:00:00'
GROUP BY time.month
ORDER BY avg_humidity DESC;
-- Result: 12 rows. Most humid months: September (74.84), October (71.57), May (71.37)

-- --- (d.5) Average demand per temp_category (Cold/Mild/Hot), 2017 ---
SELECT temperature.temp_category, AVG(CarSharing_df.demand) AS avg_demand
FROM CarSharing_df
JOIN temperature ON CarSharing_df.temp_code = temperature.temp_code
JOIN time ON CarSharing_df.id = time.id
WHERE time.timestamp >= '2017-01-01 00:00:00' AND time.timestamp < '2018-01-01 00:00:00'
GROUP BY temperature.temp_category
ORDER BY avg_demand DESC;
-- Result: Hot (4.7982), Mild (4.0217), Cold (3.1903)


-- =====================================================
-- QUESTION (e): Same breakdown as (d), but for July only
-- (July = the month with highest average demand from question b)
-- =====================================================

-- --- (e.1) Was July mostly cold, mild, or hot? ---
SELECT temperature.temp_category, COUNT(*) AS count_of_hours
FROM CarSharing_df
JOIN temperature ON CarSharing_df.temp_code = temperature.temp_code
JOIN time ON CarSharing_df.id = time.id
WHERE time.timestamp >= '2017-01-01 00:00:00' AND time.timestamp < '2018-01-01 00:00:00'
  AND time.month = 'July'
GROUP BY temperature.temp_category
ORDER BY count_of_hours DESC;
-- Result: Hot (449), Mild (7), no Cold hours

-- --- (e.2) Most prevalent weather condition in July ---
SELECT weather.weather, COUNT(*) AS count_of_hours
FROM CarSharing_df
JOIN weather ON CarSharing_df.weather_code = weather.weather_code
JOIN time ON CarSharing_df.id = time.id
WHERE time.timestamp >= '2017-01-01 00:00:00' AND time.timestamp < '2018-01-01 00:00:00'
  AND time.month = 'July'
GROUP BY weather.weather
ORDER BY count_of_hours DESC;
-- Result: Clear or partly cloudy (386), Mist (56), Light snow or rain (14)

-- --- (e.3) July wind speed: average, highest, lowest ---
-- No GROUP BY needed since we already filtered down to a single month.
SELECT AVG(CarSharing_df.windspeed) AS avg_windspeed,
       MAX(CarSharing_df.windspeed) AS max_windspeed,
       MIN(CarSharing_df.windspeed) AS min_windspeed
FROM CarSharing_df
JOIN time ON CarSharing_df.id = time.id
WHERE time.timestamp >= '2017-01-01 00:00:00' AND time.timestamp < '2018-01-01 00:00:00'
  AND time.month = 'July';
-- Result: avg 12.02, max 56.997, min 0.0

-- --- (e.4) July humidity: average, highest, lowest ---
SELECT AVG(CarSharing_df.humidity) AS avg_humidity,
       MAX(CarSharing_df.humidity) AS max_humidity,
       MIN(CarSharing_df.humidity) AS min_humidity
FROM CarSharing_df
JOIN time ON CarSharing_df.id = time.id
WHERE time.timestamp >= '2017-01-01 00:00:00' AND time.timestamp < '2018-01-01 00:00:00'
  AND time.month = 'July';
-- Result: avg 60.29, max 94, min 17

-- --- (e.5) Average demand per temp_category, July only ---
SELECT temperature.temp_category, AVG(CarSharing_df.demand) AS avg_demand
FROM CarSharing_df
JOIN temperature ON CarSharing_df.temp_code = temperature.temp_code
JOIN time ON CarSharing_df.id = time.id
WHERE time.timestamp >= '2017-01-01 00:00:00' AND time.timestamp < '2018-01-01 00:00:00'
  AND time.month = 'July'
GROUP BY temperature.temp_category
ORDER BY avg_demand DESC;
-- Result: Mild (4.808) - based on only 7 hours, Hot (4.787) - based on 449 hours

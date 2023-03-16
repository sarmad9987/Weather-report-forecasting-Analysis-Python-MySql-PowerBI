-- Find the temperature as Cold / hot by values the given in data set

SELECT 
      date,temperature AS avg_temperature,
    CASE
        WHEN temperature >= 68 THEN 'Hot'
        ELSE 'Cold'
    END AS temperature
FROM
    weather_data order by date;


-- find the maximum number of days for which temperature dropped
SELECT 
    date, AVG(avg_humidity) AS avg_humidity
FROM
    weather_data
GROUP BY date
ORDER BY date;


-- Average Windspeed
SELECT 
    date, AVG(avg_windspeed) AS avg_windspeed
FROM
    weather_data
GROUP BY date
ORDER BY date;



-- Dates when maximum gust speed increases from 55mph

SELECT 
    date, gust_speed_max
FROM
    weather_data
WHERE
    gust_speed_max > 55
ORDER BY gust_speed_max;


-- number of days when the temperature went below 0 degrees Celsius 

SELECT 
    COUNT(*) AS number_of_days_below_zero
FROM
    weather_data
WHERE
    temperature_min < 32;



-- All 4 consecutive days when the temperature was below 30 Fahrenheit

select date, temperature
from (select t1.*,
             lag(temperature, 2) over (order by date) as temp_2p,
             lag(temperature, 1) over (order by date) as temp_1p,
             lead(temperature, 1) over (order by date) as temp_1l,
             lead(temperature, 2) over (order by date) as temp_2l
      from weather_data t1
     ) t1
where temperature < 30 and
      ((temp_2p < 30 and temp_1p < 30) or
       (temp_1p < 30 and temp_1l < 30) or
       (temp_1l < 30 and temp_2l < 30) 
      );
      
      
   
      
      

        


 






 

-- Question 1: Give the count of the minimum number of days for the time when temperature reduced
-- solved
SELECT DATEDIFF(lead_date, date) AS count_min_days_temp_reduced
FROM (
  SELECT 
    date, 
    temperature, 
    LEAD(date) OVER (ORDER BY date) AS lead_date, 
    Lag(temperature) OVER (ORDER BY date) AS lag_temp
  FROM weather_data
) w
WHERE temperature > lag_temp
ORDER BY count_min_days_temp_reduced;


-- Question 4:

                                                                                            CarSharing_SQL_Report 
For full result tables and screenshots, check out this Google Drive folder: https://drive.google.com/drive/folders/13pLBzUpDDkTZo7TXMmiIbRrjGMxkUxYS?usp=sharing 

=====================================================
Question A

Please tell me which date and time we had the highest demand rate in 2017.

---To answer this question, I joined the CarSharing_df table with the time table using the shared id column, since CarSharing_df holds the demand values while the actual date and time information lives in the time table.
Then, I filtered the results to only include timestamps within the year 2017, sorted the demand values from highest to lowest, and selected the single top result.
Answer
The highest demand rate recorded in 2017 was 6.458338283, which occurred on June 15, 2017, at 5:00 PM (2017-06-15 17:00:00). 


=====================================================
Question B

Give me a table containing the name of the weekday, month, and season in which we had the highest and lowest average demand throughout 2017. Please include the calculated average demand values as well.

---Answer

I joined CarSharing_df with the time table on id, filtered to 2017 only, then used GROUP BY to calculate the average demand for each weekday, month, and season separately. For each category, I ran two queries, one sorted descending to find the highest, and one sorted ascending to find the lowest.

---Results:

Weekday: Highest average demand was on Saturday (4.41), lowest was on Thursday (4.12).
Month: Highest average demand was in July (4.79), lowest was in January (3.39).
Season: Highest average demand was in Fall (4.66), lowest was in Spring (3.61).

=====================================================

Question c

For the weekday(s) selected in (b), please give me a table showing the average demand we had at different hours of that weekday throughout 2017. Please sort the results in descending order based on the average demand.

---Answer 

Using the two weekdays identified in question (b), Saturday (highest average demand) and Thursday (lowest average demand),  I joined CarSharing_df with time, filtered to 2017 and to just these two weekdays using the IN operator. 

Then, I grouped the results by both weekday and hour to calculate the average demand for each hour on each day. Results were sorted from highest to lowest average demand. 

---Result

The highest-demand hours on both days cluster around 5 PM (17:00) and 8 AM (8:00), suggesting rush-hour patterns drive peak demand regardless of whether it's a weekday (Thursday) or weekend (Saturday). 

Saturday at 5 PM had the single highest average demand of all 48 hour/weekday combinations (5.895). 

=====================================================

Question D

Please tell me what the weather was like in 2017. Was it mostly cold, mild, or hot? Which weather condition (shown in the weather column) was the most prevalent in 2017? What were the average, highest, and lowest wind speed and humidity for each month in 2017? Please organize this information in two tables for the wind speed and humidity. Please also give me a table showing the average demand for each cold, mild, and hot weather in 2017, sorted in descending order based on their average demand.

--- Answer 

I ran a series of queries joining CarSharing_df with temperature, weather, and time, filtering all results to 2017.

--Overall temperature profile: 2017 was mostly Mild (2,735 hours), followed by Hot (2,297 hours) and Cold (390 hours).

--Most common weather condition: "Clear or partly cloudy" was the dominant condition (3,583 hours), followed by Mist (1,366 hours) and Light snow or rain (473 hours).

--Monthly wind speed: Wind speeds were highest in March (avg 15.97), April (avg 15.85), and February (avg 15.58); the early-year months were notably windier than the rest of the year.

--Monthly humidity: Humidity peaked in September (avg 74.84), October (avg 71.57), and May (avg 71.37).

--Demand by temperature category: Average demand was highest during Hot conditions (4.80), followed by Mild (4.02), and lowest during Cold conditions (3.19), which confirms that warmer weather drives significantly more car-sharing activity.

=====================================================

Question E

Give me another table showing the information requested in (d) for the month with the highest average demand in 2017, so I can compare it with other months.

---Answer

Using the same structure as question (d), I filtered all queries to July 2017 specifically, since July had the highest average demand of any month.

--Temperature profile: July was overwhelmingly Hot (449 hours), with only a handful of Mild hours (7) and no Cold hours at all, a stark contrast to the yearly picture, where Mild dominated overall.

--Most common weather: Clear or partly cloudy remained dominant (386 hours), consistent with the yearly trend.

--Wind speed: Averaged 12.02, notably calmer than the windiest months of the year (March/April, ~15.9 average).

--Humidity: Averaged 60.29, moderate compared to the year's peak humidity months (September at 74.84).

--Demand by temp_category: Interestingly, within July specifically, Mild hours (4.808) slightly edged out Hot hours (4.787) in average demand, though this should be read cautiously, since there were only 7 Mild hours in July compared to 449 Hot hours, so the Mild average is based on a very small sample.

Overall comparison to the year

 July's near-total dominance by Hot conditions, combined with generally clear skies, aligns with why it had the highest average demand of any month in 2017; warm, dry conditions consistently correlate with higher car-sharing demand throughout the dataset.


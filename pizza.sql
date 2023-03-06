-- Reading my data and checking for nulls

SELECT *
FROM PizzaRestuarantSales..pizza_sales$

SELECT *
FROM PizzaRestuarantSales..pizza_sales$
WHERE order_time is NULL

-- GOAL 1: What time and day do we tend to be busiest? How many pizzas is the restaurant making during peak periods?

/* The first thing we need to do is get the weekdays and months from the order_date column,
and since we are interested in busiest hours as well, we will extract just the hour number 
from the order_time column.*/


-- cleaning colms by adding new date and time colms

SELECT CAST(order_time as time) [Time]
FROM PizzaRestuarantSales..pizza_sales$

ALTER TABLE PizzaRestuarantSales..pizza_sales$
ADD Time time;

UPDATE PizzaRestuarantSales..pizza_sales$
SET Time = CONVERT(time, order_time);

SELECT CONVERT(DATE, order_date) AS OrderDate
FROM PizzaRestuarantSales..pizza_sales$;

ALTER TABLE PizzaRestuarantSales..pizza_sales$
ADD OrderDate AS CONVERT(DATE, order_date);


-- months

SELECT DATEPART(MONTH, OrderDate) AS Month, COUNT(*) AS PizzaCount
FROM PizzaRestuarantSales..pizza_sales$
GROUP BY DATEPART(MONTH, OrderDate) 
ORDER BY PizzaCount desc;

-- weekdays

SELECT DATENAME(WEEKDAY, OrderDate) AS DayOfWeek, COUNT(*) AS DayCount
FROM PizzaRestuarantSales..pizza_sales$
GROUP BY DATENAME(WEEKDAY, OrderDate)
ORDER BY DayCount desc;


-- hours

SELECT DATEPART(HOUR, Time) AS Hour, COUNT(*) AS HourCount
FROM PizzaRestuarantSales..pizza_sales$
GROUP BY DATEPART(HOUR, Time)
ORDER BY DATEPART(HOUR, Time) desc;

/*
The busiest months throughout the year for the restaurant are April, July, and November, being July the month with the highest number of baked pizzas.
As expected, sales during the week reach a peak on Thursday, Friday, and Saturday. From these days, Fridays are the busiest.
We have two peaks when it comes to sales during the day. We can see an increase in the morning, around 11:30am, and it reaches its highest peak at 
noon (12pm), which coincides with lunch hours. The second peak is for dinner time, at 6:00pm. At 12pm, we have 6543 pizza made, and at 6pm we have
5359 pizza made. */

-- What are the best and worst selling pizzas?

SELECT pizza_id, COUNT(pizza_id) as PizzaCount
FROM PizzaRestuarantSales..pizza_sales$
GROUP BY pizza_id
ORDER BY PizzaCount DESC;

-- count of the quantity

SELECT DISTINCT quantity, COUNT(quantity) 
FROM PizzaRestuarantSales..pizza_sales$
GROUP BY quantity
Order BY quantity;

-- count of pizza in different sizes

SELECT DISTINCT pizza_size, COUNT(pizza_size) 
FROM PizzaRestuarantSales..pizza_sales$
GROUP BY pizza_size
Order By COUNT(pizza_size);

SELECT DISTINCT pizza_category, COUNT(pizza_category) 
FROM PizzaRestuarantSales..pizza_sales$
GROUP BY pizza_category
Order BY COUNT(pizza_category);

SELECT DISTINCT pizza_ingredients, COUNT(pizza_ingredients) 
FROM PizzaRestuarantSales..pizza_sales$
GROUP BY pizza_ingredients
Order BY COUNT(pizza_ingredients) desc;

SELECT DISTINCT pizza_name, COUNT(pizza_name) 
FROM PizzaRestuarantSales..pizza_sales$
GROUP BY pizza_name
Order BY COUNT(pizza_name) desc;

-- 4. What is the average order value?

SELECT AVG(total_price), AVG(quantity), SUM(quantity),
SUM(total_price), MAX(total_price)
FROM PizzaRestuarantSales..pizza_sales$

-- 5. How well is the restaurant utilizing its seating capacity?

SELECT  DISTINCT order_id, DATEPART(HOUR, Time) as Hour
FROM PizzaRestuarantSales..pizza_sales$
WHERE OrderDate = '2015-07-17'
GROUP BY order_id


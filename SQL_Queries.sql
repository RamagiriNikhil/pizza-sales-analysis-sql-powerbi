CREATE DATABASE pizza_sales;

use pizza_sales

SELECT * FROM pizza_sales;

-- KPI’s REQUIREMENT

-- 1.Total Revenue: The sum of the total price of all pizza orders.

SELECT SUM(total_price) AS Total_Revenue 
FROM pizza_sales;

-- 2.Average Order Value: The average amount spent per order, calculated by dividing the total revenue by the total number of orders.

SELECT (SUM(total_price)/COUNT(DISTINCT order_id)) AS Avg_order_value
FROM pizza_sales;

-- 3.Total Pizzas Sold: The sum of the quantities of all pizzas sold.

SELECT SUM(quantity) AS Total_pizza_slod 
FROM pizza_sales;

-- 4.Total Orders: The total number of orders placed.

SELECT COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales;

-- 5. Average Pizzas Per Order: The average number of pizzas sold per order,
--    calculated by dividing the total number of pizzas sold by the total number of orders.

SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) / 
CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS DECIMAL(10,2))
AS Avg_Pizzas_per_order
FROM pizza_sales


-- CHARTS REQUIREMENT ------------------------------------------------------------------------------------------------------------------------------

--  1. Hourly Trend for Orders

SELECT DATEPART(HOUR, order_time) as order_hours, COUNT(DISTINCT order_id) as total_orders
from pizza_sales
group by DATEPART(HOUR, order_time)
order by DATEPART(HOUR, order_time)


-- 2.Daily Trend for Total Orders :- 

SELECT DATENAME(DW,order_date) AS Order_day, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY DATENAME(DW,order_date);
		 
-- 3.Monthly Trend for Total Orders:-

SELECT DATENAME(MONTH,order_date) AS Month_Name, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY DATENAME(MONTH,order_date);


-- 4. Percentage of Sales by Pizza Category:

SELECT pizza_category,SUM(total_price) AS Total_sales,(SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales)) AS Percentage
FROM pizza_sales
GROUP BY pizza_category;

-- 5.Percentage of Sales by Pizza Size:

SELECT pizza_size,CAST(SUM(total_price) AS DECIMAL(10,2)) AS Total_sales,
       CAST((SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales)) AS DECIMAL(10,2)) AS Percentage
FROM pizza_sales
GROUP BY pizza_size
ORDER BY Percentage DESC

--  6.Total Pizzas Sold by Pizza Category

SELECT pizza_category, SUM(quantity) as Total_Quantity_Sold
FROM pizza_sales
GROUP BY pizza_category
ORDER BY Total_Quantity_Sold DESC


-- 7. Top 5 Best Sellers by Total Revenue

SELECT TOP 5 pizza_name,SUM(total_price) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue DESC

--  Bottom 5

SELECT TOP 5 pizza_name,SUM(total_price) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue ASC

-- 8. Top 5 Best Sellers by  Total quantity

SELECT TOP 5 pizza_name,SUM(quantity) AS Total_quantity
FROM pizza_sales
GROUP BY pizza_name
ORDER BY  Total_quantity DESC

--  Bottom 5

SELECT TOP 5 pizza_name,SUM(quantity) AS Total_quantity
FROM pizza_sales
GROUP BY pizza_name
ORDER BY  Total_quantity ASC


-- 9. Top 5 Best Sellers by Total_orders

SELECT TOP 5 pizza_name,COUNT(DISTINCT order_id)  AS Total_orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY  Total_orders DESC

--  Bottom 5

SELECT TOP 5 pizza_name,COUNT(DISTINCT order_id) AS Total_orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY  Total_orders ASC


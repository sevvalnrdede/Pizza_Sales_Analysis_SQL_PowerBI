SELECT * FROM pizza_sales

-- kpi's --

SELECT SUM(total_price) AS Total_Revenue from pizza_sales

SELECT SUM(total_price) / COUNT(DISTINCT order_id) as  Avg_Order_Value from pizza_sales

SELECT SUM(quantity) AS Total_Pizza_Sold from pizza_sales

SELECT CAST(CAST(SUM(quantity) AS DECIMAL (10,2)) / CAST(COUNT(DISTINCT order_id) AS DECIMAL (10,2)) AS DECIMAL(10,2)) AS Avg_Pizzas_Per_order from pizza_sales

--daily and monthly trend--

SELECT DATENAME(DW, order_date) as order_day, COUNT(DISTINCT order_id) AS Total_orders from pizza_sales GROUP BY DATENAME(DW, order_date)

SELECT DATENAME(MONTH, order_date) as order_day, COUNT(DISTINCT order_id) AS Total_orders from pizza_sales GROUP BY DATENAME(MONTH, order_date) ORDER BY Total_Orders DESC

-- % of Sales by Category & Size --

SELECT pizza_category, sum(total_price) as Total_Sales, sum(total_price) * 100 / (SELECT sum(total_price) from pizza_sales) AS PCT 
from pizza_sales 
WHERE MONTH(order_date) = 1
GROUP BY pizza_category

SELECT pizza_size, CAST(sum(total_price) AS DECIMAL(10,2)) Total_Sales, CAST(sum(total_price) * 100 / (SELECT sum(total_price) from pizza_sales WHERE DATEPART(quarter, order_date) = 1) AS DECIMAL(10,2)) AS PCT 
from pizza_sales 
WHERE DATEPART(quarter, order_date) = 1
GROUP BY pizza_size
ORDER BY PCT DESC

SELECT pizza_category, SUM(quantity) as Total_Quantity_Sold
FROM pizza_sales
WHERE MONTH(order_date) = 2
GROUP BY pizza_category
ORDER BY Total_Quantity_Sold DESC

-- TOP 5 & BOTTOM 5  --

SELECT TOP 5 pizza_name, SUM(total_price) AS Total_Revenue FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue ASC

SELECT TOP 5 pizza_name, SUM(quantity) AS Total_Quantity FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Quantity DESC

SELECT TOP 5 pizza_name, COUNT(DISTINCT order_id) AS Total_Orders FROM pizza_sales   -- top 5 pizzas by quantity --
GROUP BY pizza_name
ORDER BY Total_Orders 

SELECT TOP 5 pizza_name, SUM(quantity) AS Total_Pizza_Sold FROM pizza_sales   -- bottom 5 by quantity --
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold ASC

SELECT Top 5 pizza_name, COUNT(DISTINCT order_id) AS Total_Orders   -- top 5 by total orders--
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders DESC

SELECT Top 5 pizza_name, COUNT(DISTINCT order_id) AS Total_Orders  -- bottom 5 by total orders --
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders ASC


SELECT Top 5 pizza_name, COUNT(DISTINCT order_id) AS Total_Orders  -- applying filters like category --
FROM pizza_sales
WHERE pizza_category = 'Classic'
GROUP BY pizza_name
ORDER BY Total_Orders ASC
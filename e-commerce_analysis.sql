create DATABASE e_commerce; -- creating new database
USE e_commerce;

-- checking all tables are proper
DESC customers;
DESC orderdetails;
DESC orders;
DESC Products;

-- OBJECTIVE 1: Identifying cities with highest number of customers

SELECT
    location,
    COUNT(*) AS number_of_customers
FROM Customers
GROUP BY location
ORDER BY number_of_customers DESC
LIMIT 3;

-- OBJECTIVE 2: To determine how many customers fall into each order frequency category based on the number of orders they have placed.

WITH orderfreq AS(
	SELECT
		customer_id,
        COUNT(*) AS NumberOfOrders
	FROM orders
	GROUP BY customer_id
)
SELECT
	NumberOfOrders,
    COUNT(*) AS CustomerCount
FROM orderfreq
GROUP BY NumberOfOrders
ORDER BY NumberOfOrders;

-- OBJECTIVE 3: To find premium product trends (AvgQuantity = 2)

SELECT
	Product_id,
    AVG(quantity) AS AvgQuantity,
    SUM(quantity * price_per_unit) AS TotalRevenue
FROM orderdetails
GROUP BY Product_id
HAVING AvgQuantity = 2
ORDER BY AvgQuantity DESC, TotalRevenue DESC;

-- OBJECTIVE 4: To find categories which has wider appeal across the customer base.

SELECT
	p.category,
    COUNT(DISTINCT o.customer_id) AS unique_customers
FROM products p
JOIN orderdetails od
ON p.product_id = od.product_id
JOIN orders o
ON od.order_id = o.order_id
GROUP BY p.category
ORDER BY unique_customers DESC;

-- OBJECTIVE 5: To analyze m-o-m sales growth trend
DESC orders;

ALTER TABLE orders
MODIFY COLUMN order_date DATE; 
-- since the order_date column was in text data type, it changes to DATE type to ensure smooth calculation

WITH monthlysale AS(
	SELECT
		DATE_FORMAT(order_date, '%Y-%m') AS Month,
		SUM(total_amount) AS TotalSales
	FROM Orders
	GROUP BY 1
	ORDER BY 1
)
SELECT
	Month,
    TotalSales,
    ROUND(((TotalSales - LAG(TotalSales) OVER(ORDER BY Month))/LAG(TotalSales) OVER(ORDER BY Month))*100,2) AS PercentChange
FROM monthlysale;

-- OBJECTIVE 6: To analyze m-o-m avg order value

WITH monthlyavg AS(
	SELECT
		DATE_FORMAT(order_date, '%Y-%m') AS Month,
		ROUND(AVG(total_amount),2) AS AvgOrderValue
	FROM Orders
	GROUP BY 1
	ORDER BY 1
)
SELECT
	Month,
    AvgOrderValue,
    AvgOrderValue - LAG(AvgOrderValue) OVER(ORDER BY Month) AS ChangeInValue
FROM monthlyavg
ORDER BY ChangeInValue DESC;

-- OBJECTIVE 7: To identify top 5 products with the fastest turnover rates

SELECT
	product_id,
    COUNT(order_id) AS SalesFrequency
FROM orderdetails
GROUP BY product_id
ORDER BY SalesFrequency DESC
LIMIT 5;

-- OBJECTIVE 8: To find products purchased by less than 40% of the customer

SELECT
	p.Product_id,
    p.Name,
	COUNT(DISTINCT o.customer_id) AS UniqueCustomerCount
FROM products p
JOIN orderdetails od
ON p.product_id = od.product_id
JOIN orders o
ON od.order_id = o.order_id
JOIN customers c
ON c.customer_id = o.customer_id
GROUP BY 1,2
HAVING UniqueCustomerCount < (
	SELECT
		COUNT(*) * 0.4
	FROM customers
);

-- OBJECTIVE 9: To calculate number of new customers every month

WITH firstmonth AS(
	SELECT
		customer_id,
		MIN(DATE_FORMAT(order_date, '%Y-%m')) AS FirstPurchaseMonth
	FROM orders
	GROUP BY customer_id
)
SELECT
	FirstPurchaseMonth,
    COUNT(*) AS TotalNewCustomers
FROM firstmonth
GROUP BY FirstPurchaseMonth
ORDER BY FirstPurchaseMonth;

-- OBJECTIVE 10: To identify the months with the highest sales volume

SELECT
	DATE_FORMAT(order_date, '%Y-%m') AS Month,
    SUM(total_amount) AS TotalSales
FROM orders
GROUP BY 1
ORDER BY TotalSales DESC
LIMIT 3;
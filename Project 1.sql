-- Retail Sales Analysis Project 1--
CREATE database sql_project_1;

USE sql_project_1;

-- Create table--
DROP TABLE if exists retail_sales;
CREATE TABLE retail_sales
(
	transactions_iD INT PRIMARY KEY,
	sale_date DATE,
	sale_time TIME,
	customer_id INT,
	gender VARCHAR(40),
	age INT,
	category VARCHAR(40),
	quantiy INT,
	price_per_unit FLOAT,
	cogs FLOAT,
	total_sale FLOAT
    );
 
 -- Data Cleaning--
SELECT * FROM retail_sales
WHERE 
	transactions_id IS NULL
	OR
	sale_date is NULL
	OR
	sale_time is NULL
	OR
	gender is NULL
	OR
	category is NULL
	OR
	Quantiy is NULL
	OR
	cogs is NULL
	OR
	total_sale is NULL
    OR
    age IS NULL;

--
SET SQL_SAFE_UPDATES = 0;

DELETE from retail_sales
WHERE 
	transactions_id IS NULL
	OR
	sale_date is NULL
	OR
	sale_time is NULL
	OR
	gender is NULL
	OR
	category is NULL
	OR
	Quantiy is NULL
	OR
	cogs is NULL
	OR
	total_sale is NULL;

SET SQL_SAFE_UPDATES = 1;

-- Data Exploration--

-- How many sales we have?
SELECT COUNT(*) as total_sales FROM retail_sales;

-- How many unique customers do we have?
SELECT COUNT(DISTINCT customer_id) as total_sales FROM retail_sales;

-- How many categories do we have?
SELECT DISTINCT category FROM retail_sales

-- Data analysis & business key problems & answers 
 
	1. Write a SQL query to retrieve all columns for sales made on '2022-11-05' 

	2. Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022**:

	3. Write a SQL query to calculate the total sales (total_sale) for each category.

	4. Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

	5. Write a SQL query to find all transactions where the total_sale is greater than 1000.

	6. Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

	7. Write a SQL query to calculate the average sale for each month. 

	8. Write a SQL query to find the top 5 customers based on the highest total sales.

	9. Write a SQL query to find the number of unique customers who purchased items from each category.

	10. Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17) )--

-- Q.1: Write a SQL query to retrieve all columns for sales made on '2022-11-05' 

SELECT *
	FROM retail_sales
    WHERE sale_date = '2022-11-05' ;
    
-- Q.2:Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022.     

SELECT *
FROM retail_sales
WHERE category = 'clothing'
  AND quantiy >= 4
  AND DATE_FORMAT(sale_date, '%Y-%m') = '2022-11';

-- Q.3: Write a SQL query to calculate the total sales (total_sale) for each category.

SELECT 
	category,
	SUM(total_sale) as Net_Sale,
	COUNT(*) as total_order
FROM retail_sales
Group by 1
;
-- Q.4: Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

SELECT
	ROUND(AVG(age), 0) AS average_age
	FROM retail_sales
	WHERE category = 'Beauty';

-- Q.5: Write a SQL query to find all transactions where the total_sale is greater than 1000.

SELECT * 
FROM retail_sales
WHERE total_sale > '1000';

-- Q.6: Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

SELECT 
    category,
    gender,
    COUNT(*) as total_trans
FROM retail_sales
GROUP 
    BY 
    category,
    gender
ORDER BY 1;

-- Q.7: Write a SQL query to calculate the average sale for each month.

SELECT 
    DATE_FORMAT(MIN(sale_date), '%M %Y') AS formatted_month,
    ROUND(AVG(total_sale), 2) AS average_sale
FROM retail_sales
GROUP BY YEAR(sale_date), MONTH(sale_date)
ORDER BY YEAR(sale_date), MONTH(sale_date);

-- Q.8: Write a SQL query to find the top 5 customers based on the highest total sales.

SELECT 
    customer_id,
    SUM(total_sale) as total_sales
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

-- Q.9:  Write a SQL query to find the number of unique customers who purchased items from each category.

SELECT 
    category,    
    COUNT(DISTINCT customer_id) as cnt_unique_cs
FROM retail_sales
GROUP BY category;

-- Q.10: Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17) )--

SELECT 
    CASE 
        WHEN HOUR(sale_time) < 12 THEN 'Morning'
        WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS shift,
    COUNT(*) AS number_of_orders
FROM retail_sales
GROUP BY shift;

-- End of Project--
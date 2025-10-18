CREATE DATABASE retail_Sales

DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales
	(
		transactions_id INT PRIMARY KEY,
        sale_date DATE,
        sale_time TIME,
        customer_id INT,
        gender VARCHAR(15),
        age INT,
        category VARCHAR(15),
        quantiy INT,
        price_per_unit FLOAT,
        cogs FLOAT,
        total_sale FLOAT
	);

#Take a peak on the total number of rows of data to be analyzed
SELECT 
	COUNT(*)
FROM retail_sales;

#Take a description of the data by seeing the top 10 headers
SELECT *
FROM retail_sales
LIMIT 10;

-- Data Cleaning
#Check for null rows among the column values
SELECT *
FROM retail_sales
WHERE
	transactions_id is null
    or
    sale_date is null
    or
    sale_time is null
    or
    customer_id is null
    or
    gender is null
    or
    age is null
    or
    category is null
    or 
    quantiy is null
    or
    price_per_unit is null
    or
    cogs is null
    or
    total_sale is null;
    
    #Delete or Drop these null rows in our data set
    DELETE FROM retail_sales
    WHERE
	transactions_id is null
    or
    sale_date is null
    or
    sale_time is null
    or
    customer_id is null
    or
    gender is null
    or
    age is null
    or
    category is null
    or 
    quantiy is null
    or
    price_per_unit is null
    or
    cogs is null
    or
    total_sale is null;
    
-- Data Exploration

-- How many sales do we have?
SELECT COUNT(*) AS total_sales
FROM retail_sales;

-- How many Unique customers do we have?
SELECT count(distinct(customer_id)) as total_sales from retail_sales;

-- How many Categories do we have?
SELECT distinct(category) as total_sales from retail_sales;

-- Data Analysis & Business Key Problems & Answers
-- My Analysis and Findings
-- Q.1 Write an sql query to retrieve all columns for sales made in 05-11-2022?
-- Q.2 Write an sql query to retrieve all transaction where category is 'clothing' and the quantity sold is more than 10 in the month of Nov 2022
-- Q.3 Write an sql query to calculate the total sales (total-sale) for each category
-- Q.4 Write an sql query to find the average age of customers who purchased items from the 'Beauty' category
-- Q.5 Write an sql query to find all transaction where the total-sale is greater than 1000
-- Q.6 Write an sql query to find the total number of transaction (transaction_id) made by each gender in each category
-- Q.7 Write an sql query to calculate the average sale for each month. find out the best selling month in each year
-- Q.8 Write an sql query to find the top 5 customers based on the highest total sales
-- Q.9 Write an sql query to find the number of unique customers who purchased item from each category
-- Q.10 Write an sql query to create each shift and number of orders (example Morning <=12, Afternoon Between 12 and 17, Evening >17) 

-- Q.1 Write an sql query to retrieve all columns for sales made in 05-11-2022?
SELECT *
FROM retail_sales
WHERE sale_date = '2022/11/05';

-- Q.2 Write an sql query to retrieve all transaction where category is 'clothing' and the quantity sold is more than 10 in the month of Nov 2022
SELECT *
FROM retail_sales
WHERE 
	category = 'clothing'
    AND
    date_format(sale_date, '%Y-%M')='2022-11';
    
-- Q.3 Write an sql query to calculate the total sales (total-sale) for each category
SELECT  category,sum(total_sale) Total_Sales
from retail_sales
group by category;

-- Q.4 Write an sql query to find the average age of customers who purchased items from the 'Beauty' category
select avg(age) as Beauty_Avg_Age
from retail_sales
where category = 'Beauty';

-- Q.5 Write an sql query to find all transaction where the total-sale is greater than 1000
SELECT *
FROM retail_sales
WHERE total_sale > 1000;

-- Q.6 Write an sql query to find the total number of transaction (transaction_id) made by each gender in each category
SELECT  category, gender, count(transactions_id) Count_of_TransactionsBasedOnGender
from retail_sales
group by gender, category
order by Count_of_TransactionsBasedOnGender desc;

-- Q.7 Write an sql query to calculate the average sale for each month. find out the best selling month in each year

	-- Average sales across different months in the year 2022 and 2023
SELECT
	YEAR(sale_date) AS sale_year,
	MONTH(sale_date) AS sale_month,
	AVG(total_sale) AS avg_sale
FROM retail_sales
GROUP BY YEAR(sale_date), MONTH(sale_date)
order by sale_month asc

-- Average of the best sales month in 
SELECT *
FROM (
    SELECT
        YEAR(sale_date) AS sale_year,
        MONTH(sale_date) AS sale_month,
        AVG(total_sale) AS avg_sale,
        RANK() OVER (PARTITION BY YEAR(sale_date) ORDER BY AVG(total_sale) DESC) AS rnk
    FROM retail_sales
    GROUP BY YEAR(sale_date), MONTH(sale_date)
) AS t1
WHERE rnk = 1;




-- Q.8 Write an sql query to find the top 5 customers based on the highest total sales
SELECT
	customer_id, sum(total_sale) as customer_expenditure
FROM retail_sales
group by customer_id
order by customer_expenditure desc 
Limit 5

-- Q.9 Write an sql query to find the number of unique customers who purchased item from each category
SELECT
category,
count(distinct(customer_id)) as cnt_distict_cs
from retail_sales
group by category

-- Q.10 Write an sql query to create each shift and number of orders (example Morning <=12, Afternoon Between 12 and 17, Evening >17) 
WITH hourly_rate
AS
(
SELECT 
    *,
    CASE
        WHEN HOUR(sale_time) < 12 THEN 'Morning'
        WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS time_of_day
FROM retail_sales
)
SELECT
	time_of_day,
    count(*) as total_orders
    FROM hourly_rate
    GROUP BY time_of_day;
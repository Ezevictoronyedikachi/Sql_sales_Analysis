# Sql_sales_Analysis

## Project Overview
**Project Title:** Retail Sales Analysis

**Database:** retail_sales

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. 
The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. 
This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL.

## Objectives
1. Set up a retail sales database: Create and populate a retail sales database with the provided sales data.
2. Data Cleaning: Identify and remove any records with missing or null values.
3. Exploratory Data Analysis (EDA): Perform basic exploratory data analysis to understand the dataset.
4. Business Analysis: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure
**1. Database Setup**
> - Database Creation: The project starts by creating a database named retail_sales.
> - Table Creation: A table named retail_sales is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
CREATE DATABASE retail_Sales;

USE retail_Sales;

DROP TABLE IF EXISTS retail_sales;

CREATE TABLE retail_sales (
    transactions_id INT PRIMARY KEY,
    sale_date DATE,
    sale_time TIME,
    customer_id INT,
    gender VARCHAR(15),
    age INT,
    category VARCHAR(15),
    quantity INT,
    price_per_unit FLOAT,
    cogs FLOAT,
    total_sale FLOAT
);
```

2. Data Exploration & Cleaning
> - **Record Count:** Determine the total number of records in the dataset.
> - **Customer Count:** Find out how many unique customers are in the dataset.
> - **Category Count:** Identify all unique product categories in the dataset.
> - **Null Value Check:** Check for any null values in the dataset and delete records with missing data.

```sql
SELECT 
	COUNT(*)
FROM retail_sales;

-- Take a description of the data by seeing the top 10 headers
SELECT *
FROM retail_sales
LIMIT 10;

-- CHECK FOR THE UNIQUE CUSTOMERS
SELECT count(distinct(customer_id)) as total_sales from retail_sales;

-- CHECK FOR NULL VALUES
SELECT *
FROM retail_sales
WHERE	transactions_id is null or sale_date is null or sale_time is null or customer_id is null or gender is null or age is null or category is null
    or  quantiy is null or price_per_unit is null or cogs is null  or total_sale is null;

-- DELETE NULL ROWS
    DELETE FROM retail_sales
    WHERE
	transactions_id is null or sale_date is null or sale_time is null or  customer_id is null or  gender is null or age is null
    or category is null or  quantiy is null  or  price_per_unit is null or cogs is null  ortotal_sale is null;
    ```

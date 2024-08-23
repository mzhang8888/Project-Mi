-- 1. Database Creation
CREATE TABLE sales_sample(
	Product_Id INT,
	Region VARCHAR(50),
	Date DATE,
	Sales_Amount NUMERIC
);

-- 2. Data Creation
INSERT INTO sales_sample(Product_Id,Region,Date,Sales_Amount) VALUES
(101,'East','2021-01-07',3),
(105,'East','2021-01-13',2),
(101,'East','2021-03-07',9),
(104,'East','2021-04-09',4),
(103,'Central','2021-02-07',3),
(101,'Central','2021-01-23',7),
(105,'Central','2021-04-09',10),
(102,'West','2021-03-23',3),
(105,'West','2021-06-16',6),
(102,'South','2021-02-12',8);

SELECT * FROM sales_sample;

-- 3. Perform OLAP operations

-- a) Drill Down-Analyze sales data at a more detailed level. Write a query to perform drill down from region to product level to understand sales performance.
SELECT * FROM sales_sample
WHERE Region = 'East' AND Product_ID = 101;

-- b) Rollup- To summarize sales data at different levels of granularity. Write a query to perform roll up from product to region level to view total sales by region.
SELECT Region, Product_Id, SUM(sales_amount) AS total_sales
FROM sales_sample
GROUP BY ROLLUP(Region, Product_Id);

-- c) Cube - To analyze sales data from multiple dimensions simultaneously. Write a query to Explore sales data from different perspectives, such as product, region, and date.
SELECT Region, Product_Id, EXTRACT(QUARTER FROM Date) AS sales_quarter, SUM(sales_amount) AS total_sales
FROM sales_sample
GROUP BY CUBE(Region, Product_Id, sales_quarter);

-- d) Slice- To extract a subset of data based on specific criteria. Write a query to slice the data to view sales for a particular region or date range.
SELECT * FROM sales_sample
WHERE Region = 'Central';

SELECT * FROM sales_sample
WHERE Date BETWEEN '2021-02-01' AND '2021-02-28';


-- e) Dice - To extract data based on multiple criteria. Write a query to view sales for specific combinations of product, region, and date
SELECT * FROM sales_sample
WHERE Region = 'East'
AND Date BETWEEN '2021-03-01' AND '2021-03-31'
AND Product_Id = 101;

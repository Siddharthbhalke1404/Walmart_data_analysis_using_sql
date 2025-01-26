SELECT * FROM sales;

-- ****************************************FEATURE ENGINEERING*****************************************************************************
-- TIME_TYPE
SELECT time,
   (CASE 
    WHEN time BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
    WHEN time BETWEEN "12:01:00" AND"16:00:00" THEN "Afternoon"
    ELSE "Evening"
   END) AS time_date
FROM sales;

ALTER TABLE sales 
ADD COLUMN time_date VARCHAR(20);

UPDATE sales
	SET time_date=(CASE 
		WHEN time BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
		WHEN time BETWEEN "12:01:00" AND"16:00:00" THEN "Afternoon"
		ELSE "Evening"
	   END
);
-- --------------------------------------------------------------------------------------------------------------------------------
-- DAY_NAME
SELECT date,
	DAYNAME(date)
FROM sales;

ALTER TABLE sales 
ADD COLUMN Day_name VARCHAR(20);

UPDATE sales
	SET Day_name=DAYNAME(date); 
--------------------------------------------------------------------------------------------------------------------------------
-- MONTH_NAME
SELECT date,
	MONTHNAME(date)
FROM sales;    

ALTER TABLE sales
ADD COLUMN Month_name VARCHAR(20);

UPDATE sales
	SET Month_name=MONTHNAME(date);

SELECT * FROM sales;

-- *********************************EDA(Exploratory Data Analysis)************************************************************* 
-- Q1 How many unique cities does the data contain?
	SELECT DISTINCT(city)
	FROM sales;
    
-- Q2 How many unique branch does the data contain? 
	SELECT 
		DISTINCT(branch)
    FROM sales;
   
-- Q3 Which branch is located in which city
    SELECT 
		DISTINCT(city),
        branch
	FROM sales;

-- Q4 How many unique product lines does the data contains?     
	SELECT 
		DISTINCT(product_line)
	FROM sales;

-- Q5 What is the most common payment method
	SELECT 
		payment_method,
		COUNT(payment_method) AS TIMES
    FROM sales
    group by payment_method;
    
--  Q6 What is the most selling product line   
	SELECT 
		product_line,
        COUNT(quantity) AS QUANTITY
    FROM sales
    GROUP BY product_line
    ORDER BY QUANTITY DESC; 
    
--  Q7 What is the total revenue by month  
	SELECT 
		Month_name AS Month,
        SUM(total) AS revenue
    FROM sales
    GROUP BY Month_name
    ORDER BY revenue DESC;
    
-- Q8 WHat month had the largest COGS?     
	SELECT 
		Month_name,
		SUM(cogs) AS Total_COGS
    FROM sales
    GROUP BY Month_name
    ORDER BY Total_COGS DESC;
    
-- Q9 What product line had the largest revenue
	SELECT 
		product_line,
        ROUND(SUM(total),0) AS Revenue
    FROM sales
    GROUP BY product_line
    ORDER BY  Revenue DESC;
    
-- Q10 Which is the city with e largest revenue?
	SELECT 
		city,
        branch,
        ROUND(SUM(total),0) AS REVENUE
    FROM sales
    GROUP BY city,branch
    ORDER BY REVENUE DESC;
    
-- Q11 What product line had the largest VAT(TAX)?
	SELECT 
		product_line,
        ROUND(AVG(VAT),2) AS AVERAGE_TAX
    FROM sales
    GROUP BY product_line
    ORDER BY AVERAGE_TAX DESC;   
    
-- Q12 Which branch sold more product than average product sold?    
	SELECT 
		branch,
        SUM(quantity)
    FROM sales
    GROUP BY branch
    HAVING SUM(quantity)>(SELECT AVG(quantity) FROM sales);
   
-- Q13 What is the most common product line by gender 
	SELECT 
		gender,
		product_line,
        COUNT(gender) AS total_count
    FROM sales
    GROUP BY gender, product_line
    ORDER BY total_count DESC;
    
-- Q14 What is the AVerage rating of each product line?
	SELECT 
		product_line,
        ROUND(AVG(rating),1) AS Rating
    FROM sales
    GROUP BY product_line
    ORDER BY Rating DESC;
    
SELECT * FROM sales;  
  
    
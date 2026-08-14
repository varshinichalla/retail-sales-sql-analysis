

 -- 1) Total sales by category

SELECT product_category, SUM(total_amount) AS TotalSales
FROM retail_sales_dataset
GROUP BY product_category
ORDER BY TotalSales DESC

-- 2) Total sales by gender

SELECT gender , SUM(total_amount) AS totalamount
FROM retail_sales_dataset
GROUP BY Gender
ORDER BY totalamount DESC

 -- 3) Monthly sales trend

 SELECT MONTH(date) AS monthly , SUM(total_amount) AS totalamount
 FROM retail_sales_dataset
 GROUP BY MONTH(date) 
 ORDER BY monthly

 -- 4) Top 5 customers by spend
 
 SELECT TOP 5 customer_id , SUM(total_amount) AS totalamount
 FROM retail_sales_dataset
 GROUP BY Customer_ID
 ORDER BY totalamount DESC

 -- 5) Average order value by category

 SELECT product_category , AVG(Total_Amount) AS averagorder , COUNT(*) AS NumberOfOrders
 FROM retail_sales_dataset
 GROUP BY Product_Category

 -- 6) Sales by age group

 SELECT
 CASE 
    WHEN age BETWEEN 18 AND 25 THEN '18 - 25'
    WHEN age BETWEEN 26 AND 35 THEN '26 - 35'
    WHEN age BETWEEN 36 AND 45 THEN '36 - 45'
    WHEN age BETWEEN 46 AND 55 THEN '46 - 55'
    ELSE '56+'
  END AS AgeGroup,
    SUM(Total_Amount) AS TotalSales,
    COUNT(*) AS NumberOfOrders
FROM retail_sales_dataset
GROUP BY
CASE
    WHEN age BETWEEN 18 AND 25 THEN '18 - 25'
    WHEN age BETWEEN 26 AND 35 THEN '26 - 35'
    WHEN age BETWEEN 36 AND 45 THEN '36 - 45'
    WHEN age BETWEEN 46 AND 55 THEN '46 - 55'
    ELSE '56+'
    END
ORDER BY AgeGroup

-- 7) Running total of monthly sales

SELECT 
    MONTH(Date) AS SalesMonth,
    SUM(Total_Amount) AS MonthlySales,
    SUM(SUM(Total_Amount)) OVER (ORDER BY MONTH(Date)) AS RunningTotal
FROM retail_sales_dataset
GROUP BY MONTH(Date)
ORDER BY SalesMonth

-- 8) Repeat purchases: same customer, same category, different transaction

SELECT 
    r1.Customer_ID,
    r1.Product_Category,
    r1.Transaction_ID AS FirstPurchase,
    r1.Date AS FirstDate,
    r2.Transaction_ID AS RepeatPurchase,
    r2.Date AS RepeatDate
FROM retail_sales_dataset r1
JOIN retail_sales_dataset r2
    ON r1.Customer_ID = r2.Customer_ID
    AND r1.Product_Category = r2.Product_Category
    AND r1.Transaction_ID < r2.Transaction_ID
ORDER BY r1.Customer_ID
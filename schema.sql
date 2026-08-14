
CREATE TABLE retail_sales_dataset (
    Transaction_ID INT PRIMARY KEY,
    Date DATE,
    Customer_ID VARCHAR(20),
    Gender VARCHAR(10),
    Age INT,
    Product_Category VARCHAR(30),
    Quantity INT,
    Price_per_Unit DECIMAL(10,2),
    Total_Amount DECIMAL(10,2)
)
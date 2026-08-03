--- Create_Analytical_Tables ---


USE DATABASE ESP_DB;
USE SCHEMA ANALYTICS;

-----------------------------------------------
--  DASHBOARD SUMMARY
-----------------------------------------------

CREATE OR REPLACE VIEW VW_DASHBOARD_SUMMARY AS
SELECT
    SUM(TotalAmount) AS TotalRevenue,
    COUNT(OrderID) AS TotalOrders,
    COUNT(DISTINCT CustomerID) AS TotalCustomers,
    ROUND(AVG(TotalAmount), 2) AS AverageOrderValue,
    SUM(Quantity) AS TotalProductsSold
FROM CURATED.FACT_ORDERS;

SELECT *
FROM ANALYTICS.VW_DASHBOARD_SUMMARY;


----------------------------------------------------------
-- 2. MONTHLY REVENUE
----------------------------------------------------------

CREATE OR REPLACE VIEW VW_MONTHLY_REVENUE AS
SELECT
    D.Year,
    D.Month,
    SUM(F.TotalAmount) AS TotalRevenue,
    COUNT(F.OrderID) AS TotalOrders,
    SUM(F.Quantity) AS ProductsSold
FROM CURATED.FACT_ORDERS F
INNER JOIN CURATED.DIM_DATE D
    ON F.DateID = D.DateID
GROUP BY
    D.Year,
    D.Month
ORDER BY
    D.Year,
    CASE D.Month
        WHEN 'January' THEN 1
        WHEN 'February' THEN 2
        WHEN 'March' THEN 3
        WHEN 'April' THEN 4
        WHEN 'May' THEN 5
        WHEN 'June' THEN 6
        WHEN 'July' THEN 7
        WHEN 'August' THEN 8
        WHEN 'September' THEN 9
        WHEN 'October' THEN 10
        WHEN 'November' THEN 11
        WHEN 'December' THEN 12
    END;


SELECT *
FROM VW_MONTHLY_REVENUE;

----------------------------------------------------------
-- 3. CATEGORY PERFORMANCE
----------------------------------------------------------

CREATE OR REPLACE VIEW VW_CATEGORY_PERFORMANCE AS
SELECT
    P.Category,
    COUNT(F.OrderID) AS TotalOrders,
    SUM(F.Quantity) AS ProductsSold,
    SUM(F.TotalAmount) AS TotalRevenue,
    ROUND(AVG(F.TotalAmount), 2) AS AverageOrderValue
FROM CURATED.FACT_ORDERS F
INNER JOIN CURATED.DIM_PRODUCT P
    ON F.ProductID = P.ProductID
GROUP BY
    P.Category
ORDER BY
    TotalRevenue DESC;


SELECT *
FROM VW_CATEGORY_PERFORMANCE;

----------------------------------------------------------
-- 4. PRODUCT PERFORMANCE
----------------------------------------------------------

CREATE OR REPLACE VIEW VW_PRODUCT_PERFORMANCE AS
SELECT
    P.ProductName,
    P.Brand,
    P.Category,
    COUNT(F.OrderID) AS TotalOrders,
    SUM(F.Quantity) AS ProductsSold,
    SUM(F.TotalAmount) AS TotalRevenue
FROM CURATED.FACT_ORDERS F
INNER JOIN CURATED.DIM_PRODUCT P
    ON F.ProductID = P.ProductID
GROUP BY
    P.ProductName,
    P.Brand,
    P.Category
ORDER BY
    TotalRevenue DESC;


SELECT *
FROM VW_PRODUCT_PERFORMANCE
LIMIT 20;

----------------------------------------------------------
-- 5. STORE PERFORMANCE
----------------------------------------------------------

CREATE OR REPLACE VIEW VW_STORE_PERFORMANCE AS
SELECT
    S.StoreName,
    S.City,
    S.State,
    S.Region,
    COUNT(F.OrderID) AS TotalOrders,
    SUM(F.Quantity) AS ProductsSold,
    SUM(F.TotalAmount) AS TotalRevenue
FROM CURATED.FACT_ORDERS F
INNER JOIN CURATED.DIM_STORE S
    ON F.StoreID = S.StoreID
GROUP BY
    S.StoreName,
    S.City,
    S.State,
    S.Region
ORDER BY
    TotalRevenue DESC;


SELECT *
FROM VW_STORE_PERFORMANCE
LIMIT 20;

----------------------------------------------------------
-- 6. CUSTOMER INSIGHTS
----------------------------------------------------------

CREATE OR REPLACE VIEW VW_CUSTOMER_INSIGHTS AS
SELECT
    C.CustomerID,
    C.CustomerName,
    C.City,
    C.State,
    C.LoyaltyTier,
    COUNT(F.OrderID) AS TotalOrders,
    SUM(F.Quantity) AS ProductsPurchased,
    SUM(F.TotalAmount) AS TotalSpent
FROM CURATED.FACT_ORDERS F
INNER JOIN CURATED.DIM_CUSTOMER C
    ON F.CustomerID = C.CustomerID
GROUP BY
    C.CustomerID,
    C.CustomerName,
    C.City,
    C.State,
    C.LoyaltyTier
ORDER BY
    TotalSpent DESC;


SELECT *
FROM VW_CUSTOMER_INSIGHTS
LIMIT 20;

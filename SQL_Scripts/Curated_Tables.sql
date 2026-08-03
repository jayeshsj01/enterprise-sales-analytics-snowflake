--- Create_Curated_Tables ---

USE DATABASE ESP_DB;
USE SCHEMA CURATED;

CREATE OR REPLACE TABLE DIM_CUSTOMER AS
SELECT
    CustomerID,
    CONCAT(FirstName, ' ', LastName) AS CustomerName,
    Gender,
    DateOfBirth,
    Email,
    PhoneNumber,
    City,
    State,
    Country,
    LoyaltyTier,
    IsActive
FROM STAGING.STG_CUSTOMERS;

SELECT COUNT(*)
FROM CURATED.DIM_CUSTOMER;



CREATE OR REPLACE TABLE DIM_PRODUCT AS
SELECT
    ProductID,
    ProductName,
    Category,
    Brand,
    CostPrice,
    UnitPrice,
    Supplier,
    IsActive
FROM STAGING.STG_PRODUCTS;

SELECT COUNT(*)
FROM CURATED.DIM_PRODUCT;



CREATE OR REPLACE TABLE DIM_STORE AS
SELECT
    StoreID,
    StoreName,
    City,
    State,
    Region
FROM STAGING.STG_STORES;


SELECT COUNT(*)
FROM CURATED.DIM_STORE;



CREATE OR REPLACE TABLE DIM_DATE AS
SELECT
    DateID,
    Date,
    DayOfWeek,
    Month,
    Quarter,
    Year,
    IsWeekend
FROM STAGING.STG_DATES;


SELECT COUNT(*)
FROM CURATED.DIM_DATE;




CREATE OR REPLACE TABLE FACT_ORDERS AS
SELECT
    OrderID,
    CustomerID,
    ProductID,
    StoreID,
    DateID,
    Quantity,
    UnitPrice,
    Discount,
    ShippingCost,
    TotalAmount,
    PaymentMethod,
    OrderStatus
FROM STAGING.STG_ORDERS;


SELECT COUNT(*)
FROM CURATED.FACT_ORDERS;

--- Create-Stagging_tables ---


USE DATABASE ESP_DB;
USE SCHEMA STAGING;

CREATE OR REPLACE TABLE STG_CUSTOMERS AS

SELECT
    CustomerID,
    INITCAP(TRIM(FirstName)) AS FirstName,
    INITCAP(TRIM(LastName)) AS LastName,
    INITCAP(TRIM(Gender)) AS Gender,
    DateOfBirth,
    LOWER(TRIM(Email)) AS Email,
    TRIM(PhoneNumber) AS PhoneNumber,
    INITCAP(TRIM(City)) AS City,
    INITCAP(TRIM(State)) AS State,
    INITCAP(TRIM(Country)) AS Country,
    RegistrationDate,
    UPPER(TRIM(LoyaltyTier)) AS LoyaltyTier,
    IsActive,
    CURRENT_TIMESTAMP() AS LoadTimestamp,
    'S3' AS SourceSystem

FROM RAW.RAW_CUSTOMERS

-- Duplicate_handeling --

QUALIFY ROW_NUMBER() OVER (
    PARTITION BY CustomerID
    ORDER BY RegistrationDate DESC
)=1;

SELECT COUNT(*)
FROM STG_CUSTOMERS;

SELECT *
FROM STG_CUSTOMERS
LIMIT 10;




CREATE OR REPLACE TABLE STAGING.STG_PRODUCTS AS

SELECT
    ProductID,
    INITCAP(TRIM(ProductName)) AS ProductName,
    INITCAP(TRIM(Category)) AS Category,
    INITCAP(TRIM(Brand)) AS Brand,
    CostPrice,
    UnitPrice,
    INITCAP(TRIM(Supplier)) AS Supplier,
    IsActive,
    CURRENT_TIMESTAMP() AS LoadTimestamp,
    'S3' AS SourceSystem

FROM RAW.RAW_PRODUCTS

WHERE
    CostPrice > 0
    AND UnitPrice >= CostPrice

QUALIFY ROW_NUMBER() OVER (
    PARTITION BY ProductID
    ORDER BY ProductID
)=1;


SELECT COUNT(*)
FROM STAGING.STG_PRODUCTS;



CREATE OR REPLACE TABLE STG_STORES AS

SELECT

    StoreID,
    INITCAP(TRIM(StoreName)) AS StoreName,
    INITCAP(TRIM(City)) AS City,
    INITCAP(TRIM(State)) AS State,
    INITCAP(TRIM(Region)) AS Region,
    CURRENT_TIMESTAMP() AS LoadTimestamp,
    'S3' AS SourceSystem

FROM RAW.RAW_STORES

QUALIFY ROW_NUMBER() OVER (

    PARTITION BY StoreID
    ORDER BY StoreID

)=1;


SELECT COUNT(*)
FROM STAGING.STG_STORES;



CREATE OR REPLACE TABLE STG_DATES AS

SELECT

    DateID,
    Date,
    DayOfWeek,
    Month,
    Quarter,
    Year,
    IsWeekend,
    CURRENT_TIMESTAMP() AS LoadTimestamp,
    'S3' AS SourceSystem
FROM RAW.RAW_DATES
QUALIFY ROW_NUMBER() OVER (
PARTITION BY DateID
ORDER BY Date

)=1;

SELECT COUNT(*)
FROM STAGING.STG_DATES;



CREATE OR REPLACE TABLE STG_ORDERS AS
SELECT
    O.OrderID,
    O.CustomerID,
    O.ProductID,
    O.StoreID,
    O.DateID,
    O.Quantity,
    O.UnitPrice,
    O.Discount,
    O.ShippingCost,
    
    INITCAP(TRIM(O.PaymentMethod)) AS PaymentMethod,
    INITCAP(TRIM(O.OrderStatus)) AS OrderStatus,
    O.TotalAmount,
    
    CURRENT_TIMESTAMP() AS LoadTimestamp,
    'S3' AS SourceSystem

FROM RAW.RAW_ORDERS O

INNER JOIN STAGING.STG_CUSTOMERS C
    ON O.CustomerID = C.CustomerID
INNER JOIN STAGING.STG_PRODUCTS P
    ON O.ProductID = P.ProductID
INNER JOIN STAGING.STG_STORES S
    ON O.StoreID = S.StoreID
INNER JOIN STAGING.STG_DATES D
    ON O.DateID = D.DateID

WHERE O.Quantity > 0
  AND O.UnitPrice > 0
  AND O.Discount BETWEEN 0 AND 0.50
  AND O.ShippingCost >= 0
  AND O.TotalAmount > 0

QUALIFY ROW_NUMBER() OVER (
    PARTITION BY O.OrderID
    ORDER BY O.OrderID
) = 1;

SELECT COUNT(*)
FROM STAGING.STG_ORDERS;
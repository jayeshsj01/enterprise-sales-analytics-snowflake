--- Create_Raw_table ---


CREATE OR REPLACE TABLE RAW_CUSTOMERS (
    CustomerID INT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Gender VARCHAR(20),
    DateOfBirth DATE,
    Email VARCHAR(100),
    PhoneNumber VARCHAR(20),
    City VARCHAR(50),
    State VARCHAR(50),
    Country VARCHAR(50),
    RegistrationDate DATE,
    LoyaltyTier VARCHAR(20),
    IsActive BOOLEAN
);ESP_DB.RAW

COPY INTO RAW_CUSTOMERS
FROM @ESP_STAGE/landing/customers/
FILE_FORMAT = (FORMAT_NAME = CSV_FILE_FORMAT);

SELECT COUNT(*) AS Total_Customers
FROM RAW_CUSTOMERS;

SELECT *
FROM RAW_CUSTOMERS
LIMIT 10;


CREATE OR REPLACE TABLE RAW.RAW_PRODUCTS (

    ProductID INT,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Brand VARCHAR(50),
    UnitPrice NUMBER(10,2),
    CostPrice NUMBER(10,2),
    Supplier VARCHAR(100),
    IsActive BOOLEAN
);


COPY INTO RAW.RAW_PRODUCTS
FROM @RAW.ESP_STAGE/landing/products/
FILE_FORMAT = (FORMAT_NAME = RAW.CSV_FILE_FORMAT);

SELECT COUNT(*) FROM RAW.RAW_PRODUCTS;


CREATE OR REPLACE TABLE RAW_STORES (
    StoreID INT,
    StoreName VARCHAR(100),
    StoreType VARCHAR(50),
    City VARCHAR(50),
    State VARCHAR(50),
    Region VARCHAR(50),
    OpeningDate DATE
);

COPY INTO RAW_STORES
FROM @ESP_STAGE/landing/stores/
FILE_FORMAT = (FORMAT_NAME = CSV_FILE_FORMAT);

SELECT COUNT(*) FROM RAW_STORES;


CREATE OR REPLACE TABLE RAW_DATES (
    DateID INT,
    Date DATE,
    DayOfWeek VARCHAR(20),
    Month VARCHAR(20),
    Quarter INT,
    Year INT,
    IsWeekend BOOLEAN
);

COPY INTO RAW_DATES
FROM @ESP_STAGE/landing/dates/
FILE_FORMAT = (FORMAT_NAME = CSV_FILE_FORMAT);

SELECT COUNT(*) FROM RAW_DATES;


CREATE OR REPLACE TABLE RAW_ORDERS (
    OrderID INT,
    CustomerID INT,
    ProductID INT,
    StoreID INT,
    DateID INT,
    Quantity INT,
    UnitPrice NUMBER(10,2),
    Discount NUMBER(5,2),
    ShippingCost NUMBER(10,2),
    PaymentMethod VARCHAR(50),
    OrderStatus VARCHAR(50),
    TotalAmount NUMBER(12,2)
);

COPY INTO RAW_ORDERS
FROM @ESP_STAGE/landing/orders/
FILE_FORMAT = (FORMAT_NAME = CSV_FILE_FORMAT);

SELECT COUNT(*) FROM RAW_ORDERS;


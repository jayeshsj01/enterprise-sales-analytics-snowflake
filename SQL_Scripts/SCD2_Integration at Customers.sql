

USE DATABASE ESP_DB;
USE SCHEMA CURATED;



ALTER TABLE DIM_CUSTOMER
ADD COLUMN IF NOT EXISTS EffectiveStartDate TIMESTAMP;

ALTER TABLE DIM_CUSTOMER
ADD COLUMN IF NOT EXISTS EffectiveEndDate TIMESTAMP;

ALTER TABLE DIM_CUSTOMER
ADD COLUMN IF NOT EXISTS IsCurrent BOOLEAN;



UPDATE DIM_CUSTOMER
SET

EffectiveStartDate = CURRENT_TIMESTAMP(),
EffectiveEndDate   = NULL,
IsCurrent          = TRUE

WHERE IsCurrent IS NULL;



MERGE INTO DIM_CUSTOMER TARGET

USING STG_CUSTOMERS SOURCE

ON TARGET.CustomerID = SOURCE.CustomerID
AND TARGET.IsCurrent = TRUE

WHEN MATCHED

AND (

NVL(TARGET.Email,'')        <> NVL(SOURCE.Email,'')

OR NVL(TARGET.PhoneNumber,'') <> NVL(SOURCE.PhoneNumber,'')

OR NVL(TARGET.City,'')       <> NVL(SOURCE.City,'')

OR NVL(TARGET.State,'')      <> NVL(SOURCE.State,'')

OR NVL(TARGET.Country,'')    <> NVL(SOURCE.Country,'')

OR NVL(TARGET.LoyaltyTier,'')<> NVL(SOURCE.LoyaltyTier,'')

)

THEN UPDATE SET

EffectiveEndDate = CURRENT_TIMESTAMP(),

IsCurrent = FALSE;



INSERT INTO DIM_CUSTOMER
(

CustomerID,
CustomerName,
Gender,
DateOfBirth,
Email,
PhoneNumber,
City,
State,
Country,
LoyaltyTier,
IsActive,
EffectiveStartDate,
EffectiveEndDate,
IsCurrent

)

SELECT

S.CustomerID,

CONCAT(S.FirstName,' ',S.LastName),

S.Gender,
S.DateOfBirth,
S.Email,
S.PhoneNumber,
S.City,
S.State,
S.Country,
S.LoyaltyTier,
S.IsActive,
CURRENT_TIMESTAMP(),

NULL,

TRUE

FROM STG_CUSTOMERS S

LEFT JOIN DIM_CUSTOMER D

ON

S.CustomerID = D.CustomerID

AND D.IsCurrent = TRUE

WHERE

D.CustomerID IS NULL

OR

(

NVL(D.Email,'')         <> NVL(S.Email,'')

OR NVL(D.PhoneNumber,'') <> NVL(S.PhoneNumber,'')

OR NVL(D.City,'')        <> NVL(S.City,'')

OR NVL(D.State,'')       <> NVL(S.State,'')

OR NVL(D.Country,'')     <> NVL(S.Country,'')

OR NVL(D.LoyaltyTier,'') <> NVL(S.LoyaltyTier,'')

);


SELECT

CustomerID,
CustomerName,
City,
State,
LoyaltyTier,
EffectiveStartDate,
EffectiveEndDate,
IsCurrent

FROM DIM_CUSTOMER
ORDER BY
CustomerID,
EffectiveStartDate;
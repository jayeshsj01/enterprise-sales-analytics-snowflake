import random
from faker import Faker
import pandas as pd

fake = Faker("en_IN")
random.seed(42)

NUM_CUSTOMERS = 5000

LOYALTY_TIERS = [
    "Bronze",
    "Silver",
    "Gold",
    "Platinum"
]

STATES = [
    "Maharashtra",
    "Karnataka",
    "Tamil Nadu",
    "Delhi",
    "Gujarat",
    "Rajasthan",
    "West Bengal",
    "Uttar Pradesh"
]

def generate_customer(customer_id):

    customer = {
    "CustomerID": customer_id,

    "FirstName": fake.first_name(),

    "LastName": fake.last_name(),

    "Gender": random.choice(["Male", "Female"]),

    "DateOfBirth": fake.date_of_birth(
        minimum_age=18,
        maximum_age=70
    ),

    "Email": fake.email(),

    "PhoneNumber": fake.phone_number(),

    "City": fake.city(),

    "State": random.choice(STATES),

    "Country": "India",

    "RegistrationDate": fake.date_between(
        start_date="-5y",
        end_date="today"
    ),

    "LoyaltyTier": random.choices(
        LOYALTY_TIERS,
        weights=[50, 30, 15, 5]
    )[0],

    "IsActive": random.choice([True, True, True, False])
}

    return customer

customer = generate_customer(1)

print(customer)

customers = []

for customer_id in range(1, NUM_CUSTOMERS + 1):
    customer = generate_customer(customer_id)
    customers.append(customer)

customer_df = pd.DataFrame(customers)

customer_df.to_csv("c:/Users/jayes/OneDrive/Desktop/Snowflake Resorces/Projects/enterprise-sales-analytics-platform/Data/customers.csv", index=False)

print(customer_df.head())
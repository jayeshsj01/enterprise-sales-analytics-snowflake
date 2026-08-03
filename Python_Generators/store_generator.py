import random
import pandas as pd
from faker import Faker

fake = Faker("en_IN")
random.seed(42)

NUM_STORES = 100

STORE_TYPES = [
    "Retail Store",
    "Mall Outlet",
    "Supermarket",
    "Warehouse",
    "Online Fulfillment Center"
]

REGIONS = {
    "North": ["Delhi", "Uttar Pradesh"],
    "West": ["Maharashtra", "Gujarat", "Rajasthan"],
    "South": ["Karnataka", "Tamil Nadu"],
    "East": ["West Bengal"]
}


def generate_store(store_id):

    region = random.choice(list(REGIONS.keys()))

    state = random.choice(REGIONS[region])

    city = fake.city()

    store = {
        "StoreID": store_id,

        "StoreName": f"{city} Store",

        "StoreType": random.choice(STORE_TYPES),

        "City": city,

        "State": state,

        "Region": region,

        "OpeningDate": fake.date_between(
            start_date="-15y",
            end_date="-1y"
        )
    }

    return store


stores = []

for store_id in range(1, NUM_STORES + 1):

    store = generate_store(store_id)

    stores.append(store)

store_df = pd.DataFrame(stores)

store_df.to_csv("c:/Users/jayes/OneDrive/Desktop/Snowflake Resorces/Projects/enterprise-sales-analytics-platform/Data/stores.csv", index=False)

print(store_df.head())
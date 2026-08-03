import random
import pandas as pd

random.seed(42)

NUM_PRODUCTS = 1000

PRODUCT_CATALOG = {
    "Electronics": {
        "brands": ["Samsung", "Apple", "Sony", "Dell", "HP"],
        "products": ["Laptop", "Smartphone", "Tablet", "Monitor", "Smart Watch"]
    },
    "Fashion": {
        "brands": ["Nike", "Adidas", "Puma", "Levi's", "Zara"],
        "products": ["T-Shirt", "Jeans", "Jacket", "Sneakers", "Hoodie"]
    },
    "Home & Kitchen": {
        "brands": ["Prestige", "Philips", "Bajaj", "Hawkins", "LG"],
        "products": ["Mixer", "Pressure Cooker", "Microwave", "Cookware Set", "Air Fryer"]
    },
    "Beauty": {
        "brands": ["Lakme", "L'Oreal", "Mamaearth", "Nivea", "Maybelline"],
        "products": ["Face Wash", "Shampoo", "Serum", "Moisturizer", "Lipstick"]
    },
    "Sports": {
        "brands": ["Yonex", "Cosco", "Nivia", "Nike", "Adidas"],
        "products": ["Football", "Cricket Bat", "Badminton Racket", "Gym Bag", "Yoga Mat"]
    }
}


def generate_product(product_id):

    category = random.choice(list(PRODUCT_CATALOG.keys()))

    brand = random.choice(PRODUCT_CATALOG[category]["brands"])

    product_name = random.choice(PRODUCT_CATALOG[category]["products"])

    cost_price = round(random.uniform(10, 500), 2)

    profit_margin = random.uniform(0.20, 0.60)

    unit_price = round(cost_price * (1 + profit_margin), 2)

    supplier = f"Supplier_{random.randint(1,50)}"

    product = {
        "ProductID": product_id,
        "ProductName": product_name,
        "Category": category,
        "Brand": brand,
        "UnitPrice": unit_price,
        "CostPrice": cost_price,
        "Supplier": supplier,
        "IsActive": random.choice([True, True, True, False])
    }

    return product


products = []

for product_id in range(1, NUM_PRODUCTS + 1):

    product = generate_product(product_id)

    products.append(product)


product_df = pd.DataFrame(products)

product_df.to_csv("c:/Users/jayes/OneDrive/Desktop/Snowflake Resorces/Projects/enterprise-sales-analytics-platform/Data/products.csv", index=False)

print(product_df.head())
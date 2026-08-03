import random
import pandas as pd

random.seed(42)

NUM_ORDERS = 50000

customers = pd.read_csv("c:/Users/jayes/OneDrive/Desktop/Snowflake Resorces/Projects/enterprise-sales-analytics-platform/Data/customers.csv")
products = pd.read_csv("c:/Users/jayes/OneDrive/Desktop/Snowflake Resorces/Projects/enterprise-sales-analytics-platform/Data/products.csv")
stores = pd.read_csv("c:/Users/jayes/OneDrive/Desktop/Snowflake Resorces/Projects/enterprise-sales-analytics-platform/Data/stores.csv")
dates = pd.read_csv("c:/Users/jayes/OneDrive/Desktop/Snowflake Resorces/Projects/enterprise-sales-analytics-platform/Data/dates.csv")

PAYMENT_METHODS = [
    "UPI",
    "Credit Card",
    "Debit Card",
    "Cash on Delivery",
    "Net Banking"
]

ORDER_STATUS = [
    "Delivered",
    "Delivered",
    "Delivered",
    "Delivered",
    "Cancelled",
    "Returned"
]


def generate_order(order_id):

    customer = customers.sample(1).iloc[0]
    product = products.sample(1).iloc[0]
    store = stores.sample(1).iloc[0]
    order_date = dates.sample(1).iloc[0]

    quantity = random.randint(1, 5)

    unit_price = product["UnitPrice"]

    discount = round(random.uniform(0.00, 0.30), 2)

    shipping_cost = round(random.uniform(20, 200), 2)

    total_amount = round(
        (quantity * unit_price * (1 - discount)) + shipping_cost,
        2
    )

    order = {
        "OrderID": order_id,
        "CustomerID": customer["CustomerID"],
        "ProductID": product["ProductID"],
        "StoreID": store["StoreID"],
        "DateID": order_date["DateID"],
        "Quantity": quantity,
        "UnitPrice": unit_price,
        "Discount": discount,
        "ShippingCost": shipping_cost,
        "PaymentMethod": random.choice(PAYMENT_METHODS),
        "OrderStatus": random.choice(ORDER_STATUS),
        "TotalAmount": total_amount
    }

    return order


orders = []

for order_id in range(1, NUM_ORDERS + 1):
    order = generate_order(order_id)
    orders.append(order)

order_df = pd.DataFrame(orders)

order_df.to_csv("c:/Users/jayes/OneDrive/Desktop/Snowflake Resorces/Projects/enterprise-sales-analytics-platform/Data/orders.csv", index=False)

print(order_df.head())
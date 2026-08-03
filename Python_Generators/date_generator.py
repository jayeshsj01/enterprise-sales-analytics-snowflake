import pandas as pd
from datetime import datetime

START_DATE = "2020-01-01"
END_DATE = "2026-12-31"

dates = pd.date_range(start=START_DATE, end=END_DATE)

date_records = []

for current_date in dates:

    date = {
        "DateID": int(current_date.strftime("%Y%m%d")),

        "Date": current_date.date(),

        "DayOfWeek": current_date.strftime("%A"),

        "Month": current_date.strftime("%B"),

        "Quarter": current_date.quarter,

        "Year": current_date.year,

        "IsWeekend": current_date.weekday() >= 5
    }

    date_records.append(date)

date_df = pd.DataFrame(date_records)

date_df.to_csv("c:/Users/jayes/OneDrive/Desktop/Snowflake Resorces/Projects/enterprise-sales-analytics-platform/Data/dates.csv", index=False)

print(date_df.head())
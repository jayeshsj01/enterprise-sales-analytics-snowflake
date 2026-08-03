# 🚀 Enterprise Sales Analytics using Snowflake & Power BI

An end-to-end **Data Engineering and Business Intelligence** project that demonstrates how raw sales data can be transformed into actionable business insights using **Snowflake**, **Amazon S3**, **SQL**, and **Power BI**.

The project follows a modern layered architecture, starting from cloud-based data ingestion to an interactive executive dashboard designed for business decision-making.

---

## 📌 Project Overview

This project simulates an enterprise sales analytics platform by building a scalable data warehouse in Snowflake and developing an interactive Power BI dashboard.

The pipeline includes:

- Cloud-based data ingestion from Amazon S3
- Data validation and transformation
- Star Schema data modeling
- Analytical SQL Views
- Executive Power BI Dashboard

---

## 🏗️ Architecture

The project follows a layered Data Engineering architecture.

```
CSV Files
      │
      ▼
Amazon S3
      │
      ▼
Snowflake Stage
      │
      ▼
RAW Layer
      │
      ▼
STAGING Layer
      │
      ▼
CURATED Layer (Star Schema)
      │
      ▼
Analytical Views
      │
      ▼
Power BI Dashboard
```

📷 Detailed Architecture Diagram available in the **Architecture** folder.

---

## 🗂️ Data Warehouse Design

The warehouse follows a **Star Schema** consisting of:

### Fact Table
- FACT_ORDERS

### Dimension Tables
- DIM_CUSTOMER
- DIM_PRODUCT
- DIM_STORE
- DIM_DATE

📷 ER Diagram available in the **ER Diagram** folder.

---

## ⚙️ Tech Stack

| Technology | Purpose |
|------------|---------|
| ❄️ Snowflake   | Cloud Data Warehouse |
| ☁️ Amazon S3   | Cloud Storage |
| 🛢 SQL         | Data Transformation & Analytics |
| 📊 Power BI    | Dashboard & Visualization |
| Git & GitHub   | Version Control |

---

## 📊 Dashboard Highlights

The interactive dashboard provides insights into:

- 💰 Total Revenue
- 🛒 Total Orders
- 👥 Total Customers
- 📦 Products Sold
- 📈 Monthly Revenue Trend
- 🏷 Revenue by Brand
- 🛍 Revenue by Category
- 👤 Customer Insights
- 🏬 Store Performance
- 🎖 Customer Loyalty Distribution
- 💳 Orders by Payment Method

---

## 📂 Repository Structure

```
Architecture/
Dashboard Screenshots/
Dataset/
ER Diagram/
Power BI Dashboard/
Snowflake/
```

---

## ✨ Key Features

- Layered Data Warehouse Architecture
- ETL Pipeline using Snowflake
- Cloud Storage Integration with Amazon S3
- Data Cleaning & Validation
- Star Schema Modeling
- Analytical SQL Views
- Interactive Executive Dashboard
- Business Performance Analysis

---

## 📈 Business Insights

The dashboard enables organizations to:

- Monitor overall sales performance
- Analyze monthly revenue trends
- Identify top-performing products and brands
- Evaluate customer loyalty
- Compare store performance
- Understand customer purchasing behavior
- Support data-driven business decisions

---

## 📸 Dashboard Preview

> Dashboard screenshots are available in the **Dashboard Screenshots** folder.

---

## 👨‍💻 Author

**Jayesh Jadhav**

Bachelor of Engineering (Information Technology)

Data Engineering | Data Analytics | Business Intelligence

---

## ⭐ If you found this project helpful, consider giving it a Star!

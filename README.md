# sql-ecommerce-analysis
SQL-based e-commerce case study analyzing customer behavior, sales trends, product performance, and inventory insights to drive data-informed business decisions.

🔍 Project Overview

This project is a real-world e-commerce case study designed to demonstrate how SQL can be used to extract meaningful business insights from transactional data.
The analysis focuses on customer behavior, product performance, sales trends, and inventory dynamics, enabling stakeholders to make data-driven decisions across marketing, operations, and supply chain functions.

🎯 Business Objectives

The analysis addresses the following key business questions:
- Which cities contribute the highest number of customers?
- How engaged are customers based on order frequency?
- Which products generate high revenue despite low purchase quantities?
- Which product categories have the widest customer reach?
- How do sales and average order value change month-over-month?
- Which products have the fastest inventory turnover?
- Which products show low customer adoption?
- Is the customer base growing or declining over time?
- Which months experience peak sales volumes?

🗂️ Dataset Description
The project uses a relational e-commerce database consisting of four core tables:

1. Customers:
customer_id
name
location
2. Products:
product_id
name
category
price
3. Orders:
order_id
order_date
customer_id
total_amount
4. OrderDetails:
order_id
product_id
quantity
price_per_unit

🛠️ Tools & Technologies
- SQL (MySQL)
- Common Table Expressions (CTEs)
- Window Functions
- Aggregations & Joins
- Date & Time Analysis

📈 Key Insights & Findings
- Delhi, Chennai, and Jaipur are the top customer hubs, ideal for targeted marketing and logistics optimization.
- Customer engagement shows a strong skew toward occasional shoppers, indicating retention improvement opportunities.
- Certain products generate high revenue at low quantities, suggesting premium product positioning.
- The Electronics category has the highest customer reach across the platform.
- Sales experienced a major dip in February, followed by fluctuating performance through mid-year.
- December records the highest increase in Average Order Value (AOV).
- High-demand products exhibit fast inventory turnover, requiring frequent restocking.
- Some products are purchased by less than 40% of the customer base, highlighting potential mismatches in inventory strategy.
- Customer acquisition trends indicate a decline in new customers, suggesting the need for improved marketing effectiveness.
- September and December are peak sales months, requiring proactive inventory and staffing planning.

📌 Key SQL Concepts Demonstrated
- Multi-table joins for transactional analysis
- CTEs for modular and readable queries
- Window functions (LAG) for month-on-month trend analysis
- Distinct counts for customer reach metrics
- KPI calculation (AOV, sales growth, turnover rate)

# Project 3: SQL Data Analysis

Internship: DecodeLabs Data Analytics Industrial Training (Batch 2026)

##  Objective
Use SQL queries to extract business insights from the cleaned dataset  filtering, grouping, and aggregating raw records into actionable intelligence using Microsoft SQL Server.

##  Dataset
Database: Microsoft SQL Server
Table: `Dataset`
Rows: 1200 (verified via `COUNT(*)`)

##  Tools & Technologies
- Microsoft SQL Server (T-SQL)

##  Queries Performed

The full query script is provided in `Decodelabs_Project_3_SQL.sql`. It covers:

1. Data verification  row count check, preview of first rows.
2. View first 10 orders  basic `SELECT`.
3. High-value orders  orders with `TotalPrice > $2000`.
4. Product performance summary  order count, units sold, revenue, avg order value per product.
5. Order status distribution  count and revenue by `OrderStatus`.
6. Payment method analysis  count and revenue by `PaymentMethod`.
7. Monthly sales trend  revenue aggregated by month using `FORMAT(Date, 'yyyy-MM')`.
8. Coupon code analysis  order count and revenue by coupon.
9. Products with more than 30 orders using `HAVING`.
10. Top 10 customers by revenue using `GROUP BY` + `ORDER BY` + `TOP`.
11. Orders by day of week using `DATENAME(WEEKDAY, Date)`.
12. Delivered vs. Cancelled comparison.
13. Most expensive products top 10 by unit price.
14. Referral source analysis revenue by acquisition channel.
15. Average order value by month with min/max.
16. Top 5 products by order count.
17. Revenue by shipping address top 10 locations.
18. (Query 17 removed — Date column has no time component, so hourly analysis isn't possible.)
19. Cancellation rate by product using conditional aggregation (`CASE WHEN`).
20. Revenue contribution percentage by product each product's % share of total revenue.
21. Monthly growth rate (MoM) using a CTE + the `LAG()` window function.

##  Key SQL Concepts Applied
- Filtering with `WHERE`
- Aggregation: `COUNT`, `SUM`, `AVG`, `MIN`, `MAX`
- Grouping with `GROUP BY` and filtering aggregates with `HAVING`
- Sorting with `ORDER BY` and `TOP`
- Conditional aggregation with `CASE WHEN`
- Window functions: `LAG()` for month-over-month growth
- Common Table Expressions (CTEs)
- Understanding logical query execution order (`FROM` → `WHERE` → `GROUP BY` → `HAVING` → `SELECT` → `ORDER BY`), rather than the order SQL is written in

##  Deliverables
- `Decodelabs_Project_3_SQL.sql` — full script with all 20 queries.
- `Decodelabs_Project_3_SQL_Results.csv` — exported query results.

##  Key Skill Demonstrated
SQL fundamentals: querying, filtering, grouping, aggregation, and window functions for business intelligence reporting.

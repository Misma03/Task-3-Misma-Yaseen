-- ============================================================
-- PROJECT 3: SQL DATA ANALYSIS (MICROSOFT SQL SERVER)
-- TABLE: Dataset
-- ============================================================

-- ============================================================
-- PART 1: DATA VERIFICATION
-- ============================================================

-- Check total rows (should be 2000+)
SELECT COUNT(*) AS TotalOrders FROM Dataset;

-- View first 5 rows
SELECT TOP 5 * FROM Dataset;

-- ============================================================
-- QUERY 1: View First 10 Orders
-- ============================================================
SELECT TOP 10 
    OrderID, 
    Date, 
    Product, 
    Quantity, 
    UnitPrice, 
    TotalPrice
FROM Dataset;

-- ============================================================
-- QUERY 2: Orders with TotalPrice > $2000 (High-Value Orders)
-- ============================================================
SELECT 
    OrderID, 
    Product, 
    TotalPrice, 
    OrderStatus
FROM Dataset
WHERE TotalPrice > 2000
ORDER BY TotalPrice DESC;

-- ============================================================
-- QUERY 3: Product Performance Summary
-- ============================================================
SELECT 
    Product,
    COUNT(*) AS OrderCount,
    SUM(Quantity) AS TotalUnitsSold,
    SUM(TotalPrice) AS TotalRevenue,
    AVG(TotalPrice) AS AvgOrderValue
FROM Dataset
GROUP BY Product
ORDER BY TotalRevenue DESC;

-- ============================================================
-- QUERY 4: Order Status Distribution
-- ============================================================
SELECT 
    OrderStatus,
    COUNT(*) AS OrderCount,
    SUM(TotalPrice) AS TotalRevenue,
    AVG(TotalPrice) AS AvgOrderValue
FROM Dataset
GROUP BY OrderStatus
ORDER BY OrderCount DESC;

-- ============================================================
-- QUERY 5: Payment Method Analysis
-- ============================================================
SELECT 
    PaymentMethod,
    COUNT(*) AS OrderCount,
    SUM(TotalPrice) AS TotalRevenue,
    AVG(TotalPrice) AS AvgOrderValue
FROM Dataset
GROUP BY PaymentMethod
ORDER BY TotalRevenue DESC;

-- ============================================================
-- QUERY 6: Monthly Sales Trend
-- ============================================================
SELECT 
    FORMAT(Date, 'yyyy-MM') AS Month,
    COUNT(*) AS OrderCount,
    SUM(TotalPrice) AS TotalRevenue,
    AVG(TotalPrice) AS AvgOrderValue
FROM Dataset
GROUP BY FORMAT(Date, 'yyyy-MM')
ORDER BY Month;

-- ============================================================
-- QUERY 7: Coupon Code Analysis
-- ============================================================
SELECT 
    CouponCode,
    COUNT(*) AS OrderCount,
    SUM(TotalPrice) AS TotalRevenue,
    AVG(TotalPrice) AS AvgOrderValue
FROM Dataset
GROUP BY CouponCode
ORDER BY OrderCount DESC;

-- ============================================================
-- QUERY 8: Products with More Than 30 Orders (HAVING Clause)
-- ============================================================
SELECT 
    Product,
    COUNT(*) AS OrderCount,
    SUM(TotalPrice) AS TotalRevenue
FROM Dataset
GROUP BY Product
HAVING COUNT(*) > 30
ORDER BY OrderCount DESC;

-- ============================================================
-- QUERY 9: Top 10 Customers by Revenue
-- ============================================================
SELECT TOP 10
    CustomerID,
    COUNT(*) AS OrderCount,
    SUM(TotalPrice) AS TotalSpent,
    AVG(TotalPrice) AS AvgOrderValue
FROM Dataset
GROUP BY CustomerID
ORDER BY TotalSpent DESC;

-- ============================================================
-- QUERY 10: Orders by Day of Week
-- ============================================================
SELECT 
    DATENAME(WEEKDAY, Date) AS DayOfWeek,
    COUNT(*) AS OrderCount,
    SUM(TotalPrice) AS TotalRevenue
FROM Dataset
GROUP BY DATENAME(WEEKDAY, Date)
ORDER BY TotalRevenue DESC;

-- ============================================================
-- QUERY 11: Delivered vs Cancelled Comparison
-- ============================================================
SELECT 
    OrderStatus,
    COUNT(*) AS OrderCount,
    SUM(Quantity) AS TotalUnits,
    SUM(TotalPrice) AS TotalRevenue,
    AVG(TotalPrice) AS AvgOrderValue
FROM Dataset
WHERE OrderStatus IN ('Delivered', 'Cancelled')
GROUP BY OrderStatus;

-- ============================================================
-- QUERY 12: Most Expensive Products (Top 10 by UnitPrice)
-- ============================================================
SELECT DISTINCT TOP 10 
    Product, 
    UnitPrice
FROM Dataset
ORDER BY UnitPrice DESC;

-- ============================================================
-- QUERY 13: Referral Source Analysis
-- ============================================================
SELECT 
    ReferralSource,
    COUNT(*) AS OrderCount,
    SUM(TotalPrice) AS TotalRevenue
FROM Dataset
GROUP BY ReferralSource
ORDER BY TotalRevenue DESC;

-- ============================================================
-- QUERY 14: Average Order Value by Month (with Min/Max)
-- ============================================================
SELECT 
    FORMAT(Date, 'yyyy-MM') AS Month,
    AVG(TotalPrice) AS AvgOrderValue,
    MIN(TotalPrice) AS MinOrderValue,
    MAX(TotalPrice) AS MaxOrderValue
FROM Dataset
GROUP BY FORMAT(Date, 'yyyy-MM')
ORDER BY Month;

-- ============================================================
-- QUERY 15: Top 5 Products by Order Count
-- ============================================================
SELECT TOP 5
    Product,
    COUNT(*) AS OrderCount
FROM Dataset
GROUP BY Product
ORDER BY OrderCount DESC;

-- ============================================================
-- QUERY 16: Revenue by ShippingAddress (Top 10)
-- ============================================================
SELECT TOP 10
    ShippingAddress,
    SUM(TotalPrice) AS TotalRevenue
FROM Dataset
GROUP BY ShippingAddress
ORDER BY TotalRevenue DESC;

-- ============================================================
-- QUERY 17: REMOVED (Date column has no time, so hourly analysis is not possible)
-- ============================================================

-- ============================================================
-- QUERY 18: Cancellation Rate by Product
-- ============================================================
SELECT 
    Product,
    COUNT(*) AS TotalOrders,
    SUM(CASE WHEN OrderStatus = 'Cancelled' THEN 1 ELSE 0 END) AS CancelledOrders,
    CAST(SUM(CASE WHEN OrderStatus = 'Cancelled' THEN 1 ELSE 0 END) AS FLOAT) / COUNT(*) * 100 AS CancellationRate
FROM Dataset
GROUP BY Product
HAVING COUNT(*) > 10
ORDER BY CancellationRate DESC;

-- ============================================================
-- QUERY 19: Revenue Contribution by Product (Percentage)
-- ============================================================
SELECT 
    Product,
    SUM(TotalPrice) AS Revenue,
    CAST(SUM(TotalPrice) AS FLOAT) / (SELECT SUM(TotalPrice) FROM Dataset) * 100 AS RevenuePercentage
FROM Dataset
GROUP BY Product
ORDER BY Revenue DESC;

-- ============================================================
-- QUERY 20: Monthly Growth Rate (Month-over-Month Revenue)
-- ============================================================
WITH MonthlyRevenue AS (
    SELECT 
        FORMAT(Date, 'yyyy-MM') AS Month,
        SUM(TotalPrice) AS Revenue
    FROM Dataset
    GROUP BY FORMAT(Date, 'yyyy-MM')
)
SELECT 
    Month,
    Revenue,
    LAG(Revenue) OVER (ORDER BY Month) AS PreviousMonthRevenue,
    (Revenue - LAG(Revenue) OVER (ORDER BY Month)) / LAG(Revenue) OVER (ORDER BY Month) * 100 AS GrowthRate
FROM MonthlyRevenue
ORDER BY Month;

-- ============================================================
-- FINAL SUMMARY
-- ============================================================
SELECT '======= PROJECT 3 SQL ANALYSIS COMPLETED =======' AS Status;
SELECT GETDATE() AS ExecutionTime;
--3. Find the average sales per customer, considering only customers who have made more than one order.

--How much no of orders by Each customer Name

Select * from OrdersList

With CustomerAvgSales As(
Select CustomerName, Count(Distinct OL.OrderID) as NumberofOrders, AVG(Sales) as AvgSales
From OrdersList OL
Join EachOrderBreakdown OB
ON OL.OrderID = OB.OrderID
Group by CustomerName
)
Select CustomerName, AvgSales
From CustomerAvgSales
Where NumberofOrders > 1

--4. Identify the top-performing subcategory in each category based on total sales,
-- Include the sub-category name, total sales, and a ranking of sub-category within each category.

Select Category, SubCategory, Sum(Sales) as TotalSales,
Rank() OVER(Partition by Category Order by Sum(Sales) Desc ) as SUB_Cate_Rank
From EachOrderBreakdown
Group by Category, SubCategory

With TOP_SUB_CATEGORY AS(
Select Category, SubCategory, Sum(Sales) as TotalSales,
Rank() OVER(Partition by Category Order by Sum(Sales) Desc ) as SUB_Cate_Rank
From EachOrderBreakdown
Group by Category, SubCategory
)
Select *
from TOP_SUB_CATEGORY
Where SUB_Cate_Rank = 1 
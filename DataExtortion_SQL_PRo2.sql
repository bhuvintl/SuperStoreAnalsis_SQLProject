--Beginner

--List the Top 10 Orders with the highest sales from the EachOrderBreakdown table.
--Show the number of orders for each product category in the EachOrderBreakdown table.
--Find the Total profit for each sub-category in the EachorderBreak table. 

--Q1-List the Top 10 Orders with the highest sales from the EachOrderBreakdown table.
Select * from EachOrderBreakdown

Select Top 10 *
From EachOrderBreakdown
order by Sales desc

--Q2:Show the number of orders for each product category in the EachOrderBreakdown table.

Select Category, COUNT(*) as 'No of Orders' 
From EachOrderBreakdown
Group by Category

--Q3> Find the Total profit for each sub-category in the EachorderBreak table.

--by Me and Correct
Select SubCategory, Sum(Profit) as 'Total Profit'
from EachOrderBreakdown
Group by SubCategory

 
Select Top 10 SubCategory, Sum(Profit) as 'Total Profit'
from EachOrderBreakdown
Group by SubCategory
Order by [Total Profit] desc

--Intermediate
--1. Identify the customer with the highest total sales across all orders.
--2. Find the month with the highest average sales in the OrderList table.
--3. Find out the average quantity ordered by customers whose first name starts with an alphabet 'S'.

--Q1. Identify the customer with the highest total sales across all orders.

Select*from OrdersList
Select*from EachOrderBreakdown

--joining both table because data relatable with common Column OrderID

Select *
from OrdersList OL
Join EachOrderBreakdown OB
ON OL.OrderID = OB.OrderID

Select CustomerName, Sum(Sales) As 'Total Sales '
from OrdersList OL
Join EachOrderBreakdown OB
ON OL.OrderID = OB.OrderID
Group by CustomerName

Select Top 1 CustomerName, Sum(Sales) As 'Total Sales'
from OrdersList OL
Join EachOrderBreakdown OB
ON OL.OrderID = OB.OrderID
Group by CustomerName
Order by [Total Sales] desc

--Q2. Find the month with the highest average sales in the OrderList table.

Select Top 1 MONTH(OrderDate) AS Month, Avg(Sales) as Average_Sales 
from OrdersList OL
Join EachOrderBreakdown OB
ON OL.OrderID = OB.OrderID
Group by MONTH(OrderDate)
Order by Average_Sales Desc

--Q3:Find out the average quantity ordered by customers whose first name starts with an alphabet 'S'.

Select *
from OrdersList OL
Join EachOrderBreakdown OB
ON OL.OrderID = OB.OrderID

Select AVG(Quantity) as AVG_QTY
from OrdersList OL
Join EachOrderBreakdown OB
ON OL.OrderID = OB.OrderID
Where LEFT(CustomerName,1) = 'S'

--Advanced
--1. Find out how many new customers were acquired in the year 2014?
Select*from OrdersList

Select CustomerName, Min(OrderDate) as FirstOrderDate
from OrdersList
Group by CustomerName
Having YEAR(MIN(OrderDate)) = '2014'

--Using SUBQUERY

Select Count(*) AS Number_of_New_Cus_2014 From (
Select CustomerName, Min(OrderDate) as FirstOrderDate
from OrdersList
Group by CustomerName
Having YEAR(MIN(OrderDate)) = '2014') AS Count_of_NewCus_2014


--2. Calculate the percentage of total profit contributed by each sub-category to the overall profit.

Select SubCategory, Sum(Profit) AS SubCategory_Profit,
Sum(Profit)/(Select Sum(Profit) from EachOrderBreakdown)*100 As Percentage_of_total_Contribution_by_Each_SC
from EachOrderBreakdown
group by SubCategory


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




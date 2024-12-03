--Establish the relation Between the tables as per the ER Diagram.

Select*from OrdersList

--I made OrderID as Not Null in OrdersList because Primary key's Principle is Not Null and Unique ID
--OrderID was Null Preveiously in OrdersList
Alter Table OrdersList
Alter Column OrderID nvarchar(255) NOT NULL

-- we will Make Primary Key to OrderID in OrdersList

Alter Table OrdersList
ADD CONSTRAINT PK_OrderID Primary Key (OrderID)

--I made OrderID as Not Null in EachOrderBreakdown because Primary key's Principle is Not Null and Unique ID
--OrderID was Null Preveiously in EachOrderBreakdown.

Alter Table EachOrderBreakdown
Alter Column OrderID nvarchar(255) NOT NULL


Alter Table EachOrderBreakdown
ADD CONSTRAINT FK_OrderID Foreign Key (OrderID) REFERENCES OrdersList(OrderID

--Completed

--Split City State Country into 3 Individual Columns Namely ‘City’,’State’,’Country’?

Alter Table OrdersList
ADD City nvarchar(255),
    State nvarchar(255),
	Country nvarchar(255);

Select*from OrdersList
-- , is delimeter

Update OrdersList
SET City = PARSENAME(REPLACE([City State Country],',','.'),3),
    State = PARSENAME(REPLACE([City State Country],',','.'),2),
    Country = PARSENAME(REPLACE([City State Country],',','.'),1)

 --Country is 1,State is 2, City is 3, we want City thats why we wrote 3 
 --Parsh mai delemeter by default . hota hai. So we can replace deletemeter by dot.

 --We have Splited City State Country into 3 Individual Columns Namely ‘City’,’State’,’Country’ thats why we
 --Deleting Prevoius Column [City State Country].

 Alter Table OrdersList
 Drop Column [City State Country]

 Select*from OrdersList
 --Ok report

 --Q> 3-Add a new Category Column using the following mapping as per the first 3 characters in the
--Product Name Column:
--a.	Tec- Technology
--b.	OFS- Office Supplies
--c.	Fur- Furniture

Select*from EachOrderBreakdown

--Add New Column in table EachOrderBreakdown of Category with same data type
Alter Table EachOrderBreakdown
Add Category nvarchar(255)

Update EachOrderBreakdown
Set Category = Case When Left(ProductName,3) = 'OFS' Then 'Office Supplies'
                    When Left(ProductName,3) = 'TEC' Then 'Technology'
					When Left(ProductName,3) = 'FUR' Then 'Furniture'
			   END;

			   --Completed

--Q4- Delete the First 4 Characters from the ProductName Column.
--A> will use of Substring and update in same column.

Update EachOrderBreakdown
Set ProductName = SUBSTRING(ProductName,5,LEN(ProductName)-4)

Select*from EachOrderBreakdown

--Q5: Remove Duplicate rows from EachOrderBreakdown table, if all column Values are Matching?
--Ans: We will use window function 

Select *, ROW_NUMBER() Over(Partition by OrderID, ProductName, Discount, Sales, Profit, Quantity, Subcategory,
                      Category Order by OrderID) as Rn
        From EachOrderBreakdown

WITH CTE AS(
           Select *, ROW_NUMBER() Over(Partition by OrderID, ProductName, Discount, Sales, 
		       Profit, Quantity, Subcategory, Category Order by OrderID) as Rn
        From EachOrderBreakdown
)
DELETE FROM CTE
WHERE Rn > 1

--Q6 - Replace blank with NA in OrderPriority Column In OrderList Table?

Select*from OrdersList

--Method 1

Update OrdersList
Set OrderPriority = Case when OrderPriority = ' ' Then 'NA'
                    End;

--Method 2

Update OrdersList
Set OrderPriority = 'NA'
Where OrderPriority = ' '
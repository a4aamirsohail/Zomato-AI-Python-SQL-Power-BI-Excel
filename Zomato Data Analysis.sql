
--Standardize Date Format (DD-MM-YYYY HH:MM)

Update Zomato
set order_datetime =
	TRY_CONVERT(DATETIME, order_datetime, 105)


--Recalculate missing total_amount

Update Zomato
Set total_amount = (quantity * item_price) - discount_amount
where total_amount is null

--Standardize city names (trim + proper case)

Update Zomato
Set city = LTRIM(RTRIM(LOWER(city)))

-- Clean phone numbers (remove spaces, symbols)

UPDATE Zomato
SET customer_phone = REPLACE(REPLACE(REPLACE(customer_phone, ' ', ''), '-', ''), '(+91)', '91')

--Handle missing payment_method

Update Zomato
Set payment_method = 'Unknown'
where payment_method is null

--Standardize restaurant names (remove extra spaces)

Update Zomato
Set restaurant_name = LTRIM(RTRIM(restaurant_name))

----Standardize payment_method (trim + proper case)

Update Zomato
Set payment_method = LTRIM(RTRIM(payment_method))

--Handling Inapropriate Charcater 

UPDATE Zomato
SET payment_method = 'Credit Card'
WHERE payment_method IN ('creditcard', 'Credit Card');


UPDATE Zomato
SET payment_method = 'UPI'
WHERE payment_method IN ('U PI', 'upi');

UPDATE Zomato
SET payment_method = 'COD'
WHERE payment_method IN ('cod', 'COD', 'Cod');

--Removeing duplicate value with correct one 

UPDATE Zomato
SET city = 'Bengaluru'
WHERE city IN ('Bangalore');


--Handle missing customer_email

Update Zomato
Set customer_email = 'Unknown'
where customer_email is null

--Handle missing feedback

Update Zomato
Set feedback = 'No feedback Given'
where feedback is null

--Update all city names in a table

UPDATE Zomato
SET city = UPPER(LEFT(city, 1)) 
             + LOWER(SUBSTRING(city, 2, LEN(city)));


--Update all customer_name names in a table

UPDATE Zomato
SET customer_name = UPPER(LEFT(customer_name, 1)) 
             + LOWER(SUBSTRING(customer_name, 2, LEN(customer_name)));

--Update all area names in a table

UPDATE Zomato
SET area = UPPER(LEFT(area, 1)) 
             + LOWER(SUBSTRING(area, 2, LEN(area)));

--Update all Resturant name in a table

UPDATE Zomato
SET restaurant_name = UPPER(LEFT(restaurant_name, 1)) 
             + LOWER(SUBSTRING(restaurant_name, 2, LEN(restaurant_name)));


--Updateing wallet name in a table

UPDATE Zomato
SET payment_method = UPPER(LEFT(payment_method, 1)) + LOWER(SUBSTRING(payment_method, 2, LEN(payment_method)))
WHERE payment_method = 'wallet';


UPDATE Zomato
SET feedback = UPPER(LEFT(feedback, 1)) 
             + LOWER(SUBSTRING(feedback, 2, LEN(feedback)));

---KPI Queries

--Total Revenue

SELECT SUM(total_amount) AS Total_Revenue
FROM Zomato

--Top 5 Restaurants by Revenue

SELECT TOP 5 restaurant_name, SUM(total_amount) AS Revenue
FROM Zomato
GROUP BY restaurant_name
ORDER BY Revenue DESC

--Customer Retention (Repeat Customers)

SELECT customer_id, COUNT(DISTINCT order_id) AS Total_Orders
FROM Zomato
GROUP BY customer_id
HAVING COUNT(DISTINCT order_id) > 1

--Average Customer Rating

SELECT AVG(rating) AS Avg_Rating
FROM Zomato
WHERE rating IS NOT NULL

--Extracting day of week 
SELECT 
    order_id,
    restaurant_name,
    order_datetime,
	total_amount,
    DATENAME(WEEKDAY, order_datetime) AS Day_Of_Week
FROM Zomato;

--Created 3 Case statment for from Total Amount 
SELECT
	total_amount,
	CASE
		WHEN total_amount > 1200 THEN 'Gold'
		WHEN total_amount > 600  and  total_amount <= 1200 THEN 'Silver'
		WHEN total_amount > 0  and  total_amount <= 600 THEN 'Bronze'
		ELSE 'UNKNOWN'
	END as Customer_Segment
FROM Zomato


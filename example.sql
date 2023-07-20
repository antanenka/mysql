-- Task #1
-- A popular candy store, with a number of regular customers of 1 million users,
-- turned to our company to create an online store.
-- You need to design a database for this store and code on SQL.
--
-- After communicating with the customer, it became clear that it would be necessary
-- to store information about Customer with the required fields: first name, last name, phone number, address, email, personal discount
--
-- Also store information about candies: name, type (chocolates, lollipops, gum), description, price and quantity.
--
-- And save the orders information to display in your personal account and collect data for analytics,
-- Order should contains customer information, the quantity and what kind of candy he ordered, order date.
-- HINT: one order can contain several different candies with a different quantity for each candy
--
-- The business analyst analyzed the market and calculated that the number of
-- various candies will be about a million with different names, the number of
-- each type of candy will be approximately the same. He also noticed that it will be
-- necessary to filter by type of candy, search by the name of the candy
-- (only search by the beginning of a word or by a complete match) and sort by price.

-- This task have to be done on SQL.
-- ----------------------------------------------------------------------------
-- DROP DATABASE IF EXISTS candyShop; -- Creating database
CREATE DATABASE candyShop;
USE candyShop;

CREATE TABLE Customers ( -- Creating customers table
	CustomerID int NOT NULL AUTO_INCREMENT,
    FirstName varchar(255),
    LastName varchar(255) NOT NULL,
    PhoneNumber varchar(255) NOT NULL,
    Address varchar(255),
    Discount int,
    CONSTRAINT PK_Person PRIMARY KEY (CustomerID, LastName)
);

INSERT INTO Customers(FirstName, LastName, PhoneNumber, Address, Discount) -- Inserting customer's info
VALUES('Ivan', 'Ivanov', '+37012345678', 'Gedimino pr.', 10);
/*inserting more items*/

SELECT COUNT(CustomerID) AS 'Number of customers' -- Calculating number of customers
FROM Customers;

CREATE TABLE Candies ( -- Creating customers table
	CandyID int NOT NULL AUTO_INCREMENT,
    CandyName varchar(255) NOT NULL,
    CandyType varchar(255) NOT NULL,
    CandyDescription text(1000),
    Price int NOT NULL,
    Quantity int NOT NULL,
    CONSTRAINT PK_Candy PRIMARY KEY (CandyID, CandyName)
);

INSERT INTO Candies(CandyName, CandyType, CandyDescription, Price, Quantity) -- Inserting candy's info
VALUES('Alionka', 'Chocolate', 'Very tasty chocolate. The best in the world', 3, 100000);
/*inserting more items*/

SELECT COUNT(CandyName) AS 'Number of candies\' names' -- Calculating the number of names of candies
FROM Candies;

SELECT COUNT(CandyType) AS 'Number of candies\' types' -- Calculating the number of types of candies
FROM Candies;

CREATE TABLE Orders ( -- Creating orders table
	DetailID int NOT NULL AUTO_INCREMENT,
    OrderID int NOT NULL,
    CandyName varchar(255) NOT NULL,
    Quantity int NOT NULL, 
    CustomerID int NOT NULL,
    OrderDate date,
    PRIMARY KEY(DetailID)
);
/*Inserting orders' info*/
INSERT INTO Orders(OrderID, CandyName, Quantity, CustomerID, OrderDate)-- |
VALUES(2567, 'Alionka', 5, 1, '2023-03-08');                           -- | Same
INSERT INTO Orders(OrderID, CandyName, Quantity, CustomerID, OrderDate)-- | Order
VALUES(2567, 'Korovka', 7, 1, '2023-03-08');						   -- |
INSERT INTO Orders(OrderID, CandyName, Quantity, CustomerID, OrderDate) -- Different order
VALUES(6789, 'Lolipop', 10, 28, '2023-03-09');
/*inserting more items*/

/*Orders table with customers' information and candies'id*/
SELECT Orders.*, Customers.FirstName, Customers.LastName, Customers.PhoneNumber, Customers.Address, Candies.CandyID 
FROM ((Orders
JOIN Candies ON Candies.CandyName = Orders.CandyName)
JOIN Customers ON Orders.CustomerID = Customers.CustomerID);

SELECT * -- Filtering candies by candy type
FROM Candies 
WHERE CandyType = 'Çhocolate';

SELECT * -- Searching by the candy name 
FROM Candies
WHERE CandyName LIKE 'candyname%'; -- '%' is used to search by the beginning of a word

SELECT * -- Sorting candies by price
FROM Candies 
ORDER BY Price, CandyName;
-- ----------------------------------------------------------------------------


-- Task №2
-- Based on the previous task, write a query that returns the names and the number of ordered 10 most popular candies
-- for the current year, depending on the quantity of candies in the orders.

-- This task have to be done on SQL.
-- ----------------------------------------------------------------------------
SELECT SUM(Quantity) AS Quantity, CandyName
FROM Orders
WHERE YEAR(OrderDate) = '2023'
GROUP BY CandyName
ORDER BY SUM(Quantity) DESC, CandyName
LIMIT 10;
-- ----------------------------------------------------------------------------
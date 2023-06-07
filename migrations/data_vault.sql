
CREATE SCHEMA DEMO;

-- Customer Hub
CREATE TABLE Customer_Hub (
    Customer_Hub_Key INT PRIMARY KEY,
    Customer_ID INT,
    Name VARCHAR(100),
    Email VARCHAR(100)
);

-- Product Hub
CREATE TABLE Product_Hub (
    Product_Hub_Key INT PRIMARY KEY,
    Product_ID INT,
    Name VARCHAR(100),
    Category VARCHAR(100)
);

-- Order Link
CREATE TABLE Order_Link (
    Order_Link_Key INT PRIMARY KEY,
    Customer_Hub_Key INT,
    Product_Hub_Key INT,
    Order_ID INT,
    Order_Date DATE,
    FOREIGN KEY (Customer_Hub_Key) REFERENCES Customer_Hub (Customer_Hub_Key),
    FOREIGN KEY (Product_Hub_Key) REFERENCES Product_Hub (Product_Hub_Key)
);

-- Customer Satellite
CREATE TABLE Customer_Satellite (
    Customer_Sat_Key INT PRIMARY KEY,
    Customer_Hub_Key INT,
    Valid_From DATE,
    Valid_To DATE,
    Address VARCHAR(200),
    Phone VARCHAR(20),
    FOREIGN KEY (Customer_Hub_Key) REFERENCES Customer_Hub (Customer_Hub_Key)
);

-- Product Satellite
CREATE TABLE Product_Satellite (
    Product_Sat_Key INT PRIMARY KEY,
    Product_Hub_Key INT,
    Valid_From DATE,
    Valid_To DATE,
    Price DECIMAL(10, 2),
    FOREIGN KEY (Product_Hub_Key) REFERENCES Product_Hub (Product_Hub_Key)
);

-- Order Satellite
CREATE TABLE Order_Satellite (
    Order_Sat_Key INT PRIMARY KEY,
    Order_Link_Key INT,
    Valid_From DATE,
    Valid_To DATE,
    Quantity INT,
    Total_Price DECIMAL(10, 2),
    FOREIGN KEY (Order_Link_Key) REFERENCES Order_Link (Order_Link_Key)
);


-- Inserting data into Customer Hub
INSERT INTO Customer_Hub (Customer_Hub_Key, Customer_ID, Name, Email)
VALUES (1, 1001, 'John Doe', 'john@example.com');

INSERT INTO Customer_Hub (Customer_Hub_Key, Customer_ID, Name, Email)
VALUES (2, 1002, 'Jane Smith', 'jane@example.com');

-- Inserting data into Product Hub
INSERT INTO Product_Hub (Product_Hub_Key, Product_ID, Name, Category)
VALUES (1, 2001, 'iPhone 12', 'Electronics');

INSERT INTO Product_Hub (Product_Hub_Key, Product_ID, Name, Category)
VALUES (2, 2002, 'Samsung TV', 'Electronics');

-- Inserting data into Order Link
INSERT INTO Order_Link (Order_Link_Key, Customer_Hub_Key, Product_Hub_Key, Order_ID, Order_Date)
VALUES (1, 1, 1, 3001, '2023-05-01');

INSERT INTO Order_Link (Order_Link_Key, Customer_Hub_Key, Product_Hub_Key, Order_ID, Order_Date)
VALUES (2, 2, 2, 3002, '2023-05-02');

-- Inserting data into Customer Satellite
INSERT INTO Customer_Satellite (Customer_Sat_Key, Customer_Hub_Key, Valid_From, Valid_To, Address, Phone)
VALUES (1, 1, '2020-01-01', '2023-06-06', '123 Main St', '555-123-4567');

INSERT INTO Customer_Satellite (Customer_Sat_Key, Customer_Hub_Key, Valid_From, Valid_To, Address, Phone)
VALUES (2, 2, '2022-03-15', '2023-06-06', '456 Elm St', '555-987-6543');

-- Inserting data into Product Satellite
INSERT INTO Product_Satellite (Product_Sat_Key, Product_Hub_Key, Valid_From, Valid_To, Price)
VALUES (1, 1, '2020-01-01', '2023-06-06', 999.99);

INSERT INTO Product_Satellite (Product_Sat_Key, Product_Hub_Key, Valid_From, Valid_To, Price)
VALUES (2, 2, '2020-01-01', '2023-06-06', 799.99);

-- Inserting data into Order Satellite
INSERT INTO Order_Satellite (Order_Sat_Key, Order_Link_Key, Valid_From, Valid_To, Quantity, Total_Price)
VALUES (1, 1, '2023-05-01', '2023-06-06', 2, 1999.98);

INSERT INTO Order_Satellite (Order_Sat_Key, Order_Link_Key, Valid_From, Valid_To, Quantity, Total_Price)
VALUES (2, 2, '2023-05-02', '2023-06-06', 1, 799.99);

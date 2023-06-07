CREATE SCHEMA MDM;

USE SCHEMA MDM;

CREATE TABLE Customers_US (
    CustomerID INT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    Address VARCHAR(100),
    City VARCHAR(50),
    State VARCHAR(50),
    ZipCode VARCHAR(10),
    Country VARCHAR(50)
);

INSERT INTO Customers_US (CustomerID, FirstName, LastName, Email, Address, City, State, ZipCode, Country)
VALUES (1, 'John', 'Smith', 'john.smith@example.com', '123 Main St', 'Anytown', 'NY', '12345', 'USA'),
       (2, 'Jane', 'Doe', 'jane.doe@example.com', 
                                           '456 Maple Ave', 'Otherville', 'CA', '67890', 'United States'),
       (3, 'Bob', 'Johnson', 'bob.johnson@example.com', '789 Oak Blvd', 'Smalltown', 'TX', '23456', 'USA');


CREATE TABLE Customers_EU (
    CustomerID INT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    Address VARCHAR(100),
    City VARCHAR(50),
    State VARCHAR(50),
    ZipCode VARCHAR(10),
    Country VARCHAR(50)
);

INSERT INTO Customers_EU (CustomerID, FirstName, LastName, Email, Address, City, State, ZipCode, Country)
VALUES (4, 'Pierre', 'Dupont', 'pierre.dupont@example.com',
                                'Hauptstrasse 23', 'Berlin', '', '12345', 'Deutschland'),
       (5, 'Anna', 'Müller', 'anna.muller@example.com', 'Hauptstrasse 23', 'Berlin', '', '12345', 'Germany'),
       (6, 'Luca', 'Rossi', 'luca.rossi@example.com', 'Via Roma 7', 'Rome', '', '00185', 'Italy');


-- Create the Countries table
CREATE TABLE Countries (
  CountryName VARCHAR(50),
  StandardName VARCHAR(50)
);

-- Populate the Countries table with data from Customers_US
INSERT INTO Countries (CountryName, StandardName)
VALUES ('USA', 'United States'),
       ('United States', 'United States'),
       ('Canada', 'Canada'),
       ('Mexico', 'Mexico');

-- Populate the Countries table with data from Customers_EU
INSERT INTO Countries (CountryName, StandardName)
VALUES ('France', 'France'),
       ('Germany', 'Germany'),
       ('Deutschland', 'Germany'),
       ('Italy', 'Italy');


CREATE TABLE Customer (
  CustomerID INT PRIMARY KEY,
  FirstName VARCHAR(50),
  LastName VARCHAR(50),
  Email VARCHAR(100),
  Address VARCHAR(100),
  City VARCHAR(50),
  State VARCHAR(50),
  ZipCode VARCHAR(10),
  Country VARCHAR(50)
);

-- Load data from Customers_US table, using MDM to standardize country names
INSERT INTO Customer (CustomerID, FirstName, LastName, Email, Address, City, State, ZipCode, Country)
SELECT c.CustomerID, c.FirstName, c.LastName, c.Email, c.Address, c.City, c.State, c.ZipCode, cm.StandardName
FROM Customers_US c
LEFT JOIN Countries cm
ON c.Country = cm.CountryName;

-- Load data from Customers_EU table, using MDM to standardize country names
INSERT INTO Customer (CustomerID, FirstName, LastName, Email, Address, City, State, ZipCode, Country)
SELECT c.CustomerID, c.FirstName, c.LastName, c.Email, c.Address, c.City, c.State, c.ZipCode, cm.StandardName
FROM Customers_EU c
LEFT JOIN Countries cm
ON c.Country = cm.CountryName;

-- TRUNCATE TABLE CUSTOMER;

SELECT * FROM CUSTOMER;


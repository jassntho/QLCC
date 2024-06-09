CREATE DATABASE QLCC;
GO

USE QLCC;
GO

CREATE TABLE Unit (
    Unit_ID INT PRIMARY KEY,
    Property_ID INT,
    Number VARCHAR(50) NOT NULL,
    Floor INT,
    Rent DECIMAL(10,2),
    Status VARCHAR(50)
);
GO

CREATE TABLE Tenant (
    Tenant_ID INT PRIMARY KEY,
    Tenant_Name VARCHAR(50) NOT NULL,
    Phone_Number VARCHAR(10),
    Email VARCHAR(50),
    Date_of_Birth DATE,
    Unit_Owner INT
);
GO

CREATE TABLE Lease (
    Lease_ID INT PRIMARY KEY,
    Unit_ID INT FOREIGN KEY REFERENCES Unit(Unit_ID),
    Tenant_ID INT FOREIGN KEY REFERENCES Tenant(Tenant_ID),
    Start_Date DATE,
    End_Date DATE,
    Monthly_Rent DECIMAL(10,2),
    Deposit DECIMAL(10,2)
);
GO
CREATE TABLE Payment (
    Payment_ID INT PRIMARY KEY,
    Lease_ID INT FOREIGN KEY REFERENCES Lease(Lease_ID),
    Date DATE,
    Amount DECIMAL(10,2),
    Payment_Type VARCHAR(50)
);
GO

CREATE TABLE Property (
    Property_ID INT PRIMARY KEY,
    Property_Name VARCHAR(50)
);
GO

CREATE TABLE Amenity (
    Amenity_ID INT PRIMARY KEY,
    Property_ID INT FOREIGN KEY REFERENCES Property(Property_ID),
    Amenity_Name VARCHAR(50),
    A_Description TEXT
);
GO

CREATE TABLE Booking (
    Booking_ID INT PRIMARY KEY,
    Tenant_ID INT FOREIGN KEY REFERENCES Tenant(Tenant_ID),
    Amenity_ID INT FOREIGN KEY REFERENCES Amenity(Amenity_ID),
    Start_Time DATETIME,
    End_Time DATETIME
);
GO
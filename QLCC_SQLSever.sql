-- Tạo database
CREATE DATABASE QLCC;
GO

-- Chuyển sang database QLCC
USE QLCC;
GO

-- Tạo bảng Property
CREATE TABLE Property (
    Property_ID CHAR(4) PRIMARY KEY,
    Property_Name VARCHAR(50) NOT NULL,
    Address VARCHAR(50) NOT NULL,
    Manager_ID CHAR(4)
);
GO

-- Tạo bảng Vendor
CREATE TABLE Vendor (
    Vendor_ID CHAR(4) PRIMARY KEY,
    Vendor_Name VARCHAR(50) NOT NULL,
    Service_Type VARCHAR(50) NOT NULL,
    Vendor_Email VARCHAR(50) NOT NULL
);
GO

-- Tạo bảng Contract
CREATE TABLE Contract (
    Vendor_ID CHAR(4),
    Property_ID CHAR(4),
    Start_Date DATE,
    End_Date DATE,
    Cost DECIMAL(5,2),
    PRIMARY KEY (Vendor_ID, Property_ID),
    FOREIGN KEY (Vendor_ID) REFERENCES Vendor (Vendor_ID),
    FOREIGN KEY (Property_ID) REFERENCES Property (Property_ID)
);
GO

-- Tạo bảng Unit
CREATE TABLE Unit (
    Unit_ID CHAR(4) PRIMARY KEY,
    Property_ID CHAR(4),
    Number VARCHAR(5) NOT NULL,
    Floor INT,
    Rent DECIMAL(5,2),
    Status VARCHAR(10),
    FOREIGN KEY(Property_ID) REFERENCES Property(Property_ID)
);
GO

-- Tạo bảng Tenant
CREATE TABLE Tenant (
    Tenant_ID CHAR(4) PRIMARY KEY,
    Tenant_Name VARCHAR(50) NOT NULL,
    Phone_Number VARCHAR(10),
    Tenant_Email VARCHAR(50),
    Date_of_Birth DATE,
    Host INT
);
GO

-- Tạo bảng Lease
CREATE TABLE Lease (
    Lease_ID CHAR(4) PRIMARY KEY,
    Unit_ID CHAR(4),
    Tenant_ID CHAR(4),
    Start_Date DATE,
    End_Date DATE,
    Monthly_Rent DECIMAL(5,2),
    Deposit DECIMAL(5,2),
    FOREIGN KEY(Unit_ID) REFERENCES Unit(Unit_ID),
    FOREIGN KEY(Tenant_ID) REFERENCES Tenant(Tenant_ID)
);
GO

-- Tạo bảng Payment
CREATE TABLE Payment (
    Payment_ID CHAR(4) PRIMARY KEY,
    Lease_ID CHAR(4),
    Date DATE,
    Amount DECIMAL(5,2),
    Payment_Type VARCHAR(50),
    FOREIGN KEY(Lease_ID) REFERENCES Lease(Lease_ID)
);
GO

-- Tạo bảng Amenity
CREATE TABLE Amenity (
    Amenity_ID CHAR(4) PRIMARY KEY,
    Property_ID CHAR(4),
    Amenity_Name VARCHAR(50),
    Description TEXT,
    FOREIGN KEY(Property_ID) REFERENCES Property (Property_ID)
);
GO

-- Tạo bảng Booking
CREATE TABLE Booking (
    Tenant_ID CHAR(4),
    Amenity_ID CHAR(4),
    Start_Time DATETIME,
    End_Time DATETIME,
    Cost DECIMAL(5,2),
    PRIMARY KEY (Tenant_ID, Amenity_ID),
    FOREIGN KEY(Tenant_ID) REFERENCES Tenant (Tenant_ID),
    FOREIGN KEY(Amenity_ID) REFERENCES Amenity (Amenity_ID)
);
GO

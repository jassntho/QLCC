-- Create Database
CREATE DATABASE QLCC;
GO

USE QLCC;
GO

-- Create Tables
CREATE TABLE Property (
      Property_ID CHAR(4) PRIMARY KEY,
      Property_Name VARCHAR(50) NOT NULL UNIQUE,
      Address VARCHAR(50) NOT NULL,
      Manager_ID CHAR(4)
);

CREATE TABLE Vendor (
    Vendor_ID CHAR(4) PRIMARY KEY,
      Vendor_Name VARCHAR(50) NOT NULL,
      Service_Type VARCHAR(50) NOT NULL,
      Vendor_Email VARCHAR(50) NOT NULL
);

CREATE TABLE Contract (
      Vendor_ID CHAR(4),
      Property_ID CHAR(4),
      Start_Date DATE,
      End_Date DATE,
      Cost DECIMAL(5,2) CHECK (Cost >= 0),
      PRIMARY KEY (Vendor_ID, Property_ID),
    FOREIGN KEY (Vendor_ID) REFERENCES Vendor (Vendor_ID),
    FOREIGN KEY (Property_ID) REFERENCES Property (Property_ID),
    CHECK (Start_Date < End_Date)
);

CREATE TABLE Unit (
    Unit_ID CHAR(4) PRIMARY KEY,
    Property_ID CHAR(4),
    Number VARCHAR(5) NOT NULL UNIQUE,
    Floor INT CHECK (Floor >= 1),
    Rent DECIMAL(5,2) CHECK (Rent >= 0),
    Status VARCHAR(10),
    FOREIGN KEY(Property_ID) REFERENCES Property(Property_ID)
);

CREATE TABLE Tenant (
    Tenant_ID CHAR(4) PRIMARY KEY,
    Tenant_Name VARCHAR(50) NOT NULL,
    Phone_Number VARCHAR(10),
    Tenant_Email VARCHAR(50) CHECK (Tenant_Email LIKE '%@gmail.com'),
    Date_of_Birth DATE,
    Host INT
);

CREATE TABLE Lease (
    Lease_ID CHAR(4) PRIMARY KEY,
    Unit_ID CHAR(4),
    Tenant_ID CHAR(4),
    Start_Date DATE,
    End_Date DATE,
    Monthly_Rent DECIMAL(5,2) CHECK (Monthly_Rent >= 0),
    Deposit DECIMAL(5,2) CHECK (Deposit >= 0),
    FOREIGN KEY(Unit_ID) REFERENCES Unit(Unit_ID),
    FOREIGN KEY(Tenant_ID) REFERENCES Tenant(Tenant_ID),
    UNIQUE (Unit_ID, Start_Date),
    CHECK (Start_Date < End_Date)
);

CREATE TABLE Payment (
    Payment_ID CHAR(4) PRIMARY KEY,
    Lease_ID CHAR(4),
    Date DATE,
    Amount DECIMAL(5,2) CHECK (Amount >= 0),
    Payment_Type VARCHAR(50),
    FOREIGN KEY(Lease_ID) REFERENCES Lease(Lease_ID),
    UNIQUE (Lease_ID, Date)
);

CREATE TABLE Amenity (
    Amenity_ID CHAR(4) PRIMARY KEY,
    Property_ID CHAR(4),
    Amenity_Name VARCHAR(50),
    Description TEXT,
    FOREIGN KEY(Property_ID) REFERENCES Property(Property_ID)
);

CREATE TABLE Booking (
    Tenant_ID CHAR(4),
    Amenity_ID CHAR(4),
    Start_Date DATETIME,
    End_Date DATETIME,
    Cost DECIMAL(5,2) CHECK (Cost >= 0),
    PRIMARY KEY (Tenant_ID, Amenity_ID),
    FOREIGN KEY(Tenant_ID) REFERENCES Tenant(Tenant_ID),
    FOREIGN KEY(Amenity_ID) REFERENCES Amenity(Amenity_ID)
);
GO

-- Tạo ràng buộc UNIQUE cho cột Name trong bảng Property
ALTER TABLE Property
    ADD UNIQUE (Property_Name);
GO

-- Tạo ràng buộc CHECK cho cột Start_Date và End_Date trong bảng Contract
ALTER TABLE Contract
    ADD CHECK (Start_Date < End_Date);
GO

-- Tạo ràng buộc CHECK cho cột Cost trong bảng Contract
ALTER TABLE Contract
    ADD CHECK (Cost >= 0);
GO

-- Tạo ràng buộc CHECK cho cột Cost trong bảng Booking
ALTER TABLE Booking
    ADD CHECK (Cost >= 0);
GO

-- Tạo ràng buộc CHECK cho cột Start_Date và End_Date trong bảng Booking
-- ALTER TABLE Booking
-- ADD CHECK (Start_Date < End_Date);
-- GO

-- Tạo ràng buộc UNIQUE cho cột Number trong bảng Unit
ALTER TABLE Unit
    ADD UNIQUE (Number);
GO

-- Tạo ràng buộc UNIQUE cho cột Start_Date trong bảng Lease
ALTER TABLE Lease
    ADD UNIQUE (Unit_ID, Start_Date);
GO

-- Tạo ràng buộc UNIQUE cho cột Date trong bảng Payment
ALTER TABLE Payment
    ADD UNIQUE (Lease_ID, Date);
GO

-- Tạo ràng buộc CHECK cho cột Rent trong bảng Unit
ALTER TABLE Unit
    ADD CHECK (Rent >= 0);
GO

-- Tạo ràng buộc CHECK cho cột Floor trong bảng Unit
ALTER TABLE Unit
    ADD CHECK (Floor >= 1);
GO

-- Tạo ràng buộc CHECK cho cột Start_Date và End_Date trong bảng Lease
ALTER TABLE Lease
    ADD CHECK (Start_Date < End_Date);
GO

-- Tạo ràng buộc CHECK cho cột Monthly_Rent trong bảng Lease
ALTER TABLE Lease
    ADD CHECK (Monthly_Rent >= 0);
GO

-- Tạo ràng buộc CHECK cho cột Deposit trong bảng Lease
ALTER TABLE Lease
    ADD CHECK (Deposit >= 0);
GO

-- Tạo ràng buộc CHECK cho cột Amount trong bảng Payment
ALTER TABLE Payment
    ADD CHECK (Amount >= 0);
GO

-- Tạo ràng buộc CHECK cho cột Tenant_Email trong bảng Tenant
ALTER TABLE Tenant
    ADD CHECK (Tenant_Email LIKE '%@gmail.com');
GO

-- Insert Data into Property
INSERT INTO Property (Property_ID, Property_Name, Address, Manager_ID)
VALUES	('0001', 'A1', 'block A', '0001'),
        ('0002', 'A2', 'block A', '0001'),
        ('0003', 'A3', 'block A', '0001'),
        ('0004', 'B1', 'block B', '0002'),
        ('0005', 'B2', 'block B', '0002'),
        ('0006', 'B3', 'block B', '0002'),
        ('0007', 'C1', 'block C', '0003'),
        ('0008', 'C2', 'block C', '0003'),
        ('0009', 'C3', 'block C', '0003'),
        ('0010', 'A4', 'block A', '0001'),
        ('0011', 'A5', 'block A', '0001'),
        ('0012', 'A6', 'block A', '0001'),
        ('0013', 'B4', 'block B', '0002'),
        ('0014', 'B5', 'block B', '0002'),
        ('0015', 'B6', 'block B', '0002'),
        ('0016', 'C4', 'block C', '0003'),
        ('0017', 'C5', 'block C', '0003'),
        ('0018', 'C6', 'block C', '0003'),
        ('0019', 'A7', 'block A', '0001'),
        ('0020', 'A8', 'block A', '0001');
GO

-- Insert Data into Vendor
INSERT INTO Vendor (Vendor_ID, Vendor_Name, Service_Type, Vendor_Email)
VALUES	('0001', 'John Smith', 'Electricity', 'john.smith@example.com'),
        ('0002', 'Mary Johnson', 'Water', 'mary.johnson@example.com'),
        ('0003', 'Robert Brown', 'Waste', 'robert.brown@example.com'),
        ('0004', 'Patricia Davis', 'Security', 'patricia.davis@example.com'),
        ('0005', 'Michael Miller', 'Cleaning', 'michael.miller@example.com'),
        ('0006', 'Linda Wilson', 'Maintenance', 'linda.wilson@example.com'),
        ('0007', 'William Moore', 'Elevator', 'william.moore@example.com'),
        ('0008', 'Elizabeth Taylor', 'Engineering', 'elizabeth.taylor@example.com'),
        ('0009', 'David Anderson', 'Fire Safety', 'david.anderson@example.com'),
        ('0010', 'Jennifer Thomas', 'Internet', 'jennifer.thomas@example.com');
GO

-- Insert Data into Contract
INSERT INTO Contract (Vendor_ID, Property_ID, Start_Date, End_Date, Cost)
VALUES
    ('0001', '0001', CONVERT(DATE, '2023-01-01', 103), CONVERT(DATE, '2028-01-01', 103), 15.00),
    ('0001', '0002', CONVERT(DATE, '2023-02-01', 103), CONVERT(DATE, '2028-02-01', 103), 16.00),
    ('0001', '0003', CONVERT(DATE, '2023-03-01', 103), CONVERT(DATE, '2028-03-01', 103), 17.00),
    ('0001', '0004', CONVERT(DATE, '2023-04-01', 103), CONVERT(DATE, '2028-04-01', 103), 18.00),
    ('0001', '0005', CONVERT(DATE, '2023-05-01', 103), CONVERT(DATE, '2028-05-01', 103), 19.00),
    ('0001', '0006', CONVERT(DATE, '2023-06-01', 103), CONVERT(DATE, '2028-06-01', 103), 20.00),
    ('0001', '0007', CONVERT(DATE, '2023-07-01', 103), CONVERT(DATE, '2028-07-01', 103), 15.00),
    ('0001', '0008', CONVERT(DATE, '2023-08-01', 103), CONVERT(DATE, '2028-08-01', 103), 16.00),
    ('0001', '0009', CONVERT(DATE, '2023-09-01', 103), CONVERT(DATE, '2028-09-01', 103), 17.00),
    ('0001', '0010', CONVERT(DATE, '2023-10-01', 103), CONVERT(DATE, '2028-10-01', 103), 18.00),
    ('0001', '0011', CONVERT(DATE, '2023-11-01', 103), CONVERT(DATE, '2028-11-01', 103), 19.00),
    ('0001', '0012', CONVERT(DATE, '2023-12-01', 103), CONVERT(DATE, '2028-12-01', 103), 20.00),
    ('0001', '0013', CONVERT(DATE, '2023-01-01', 103), CONVERT(DATE, '2028-01-01', 103), 15.00),
    ('0001', '0014', CONVERT(DATE, '2023-02-01', 103), CONVERT(DATE, '2028-02-01', 103), 16.00),
    ('0001', '0015', CONVERT(DATE, '2023-03-01', 103), CONVERT(DATE, '2028-03-01', 103), 17.00),
    ('0001', '0016', CONVERT(DATE, '2023-04-01', 103), CONVERT(DATE, '2028-04-01', 103), 18.00),
    ('0001', '0017', CONVERT(DATE, '2023-05-01', 103), CONVERT(DATE, '2028-05-01', 103), 19.00),
    ('0001', '0018', CONVERT(DATE, '2023-06-01', 103), CONVERT(DATE, '2028-06-01', 103), 20.00),
    ('0001', '0019', CONVERT(DATE, '2023-07-01', 103), CONVERT(DATE, '2028-07-01', 103), 15.00),
    ('0001', '0020', CONVERT(DATE, '2023-08-01', 103), CONVERT(DATE, '2028-08-01', 103), 16.00),
    ('0002', '0001', CONVERT(DATE, '2023-01-01', 103), CONVERT(DATE, '2028-01-01', 103), 17.00),
    ('0002', '0002', CONVERT(DATE, '2023-02-01', 103), CONVERT(DATE, '2028-02-01', 103), 18.00),
    ('0002', '0003', CONVERT(DATE, '2023-03-01', 103), CONVERT(DATE, '2028-03-01', 103), 19.00),
    ('0002', '0004', CONVERT(DATE, '2023-04-01', 103), CONVERT(DATE, '2028-04-01', 103), 20.00),
    ('0002', '0005', CONVERT(DATE, '2023-05-01', 103), CONVERT(DATE, '2028-05-01', 103), 15.00),
    ('0002', '0006', CONVERT(DATE, '2023-06-01', 103), CONVERT(DATE, '2028-06-01', 103), 16.00),
    ('0002', '0007', CONVERT(DATE, '2023-07-01', 103), CONVERT(DATE, '2028-07-01', 103), 17.00),
    ('0002', '0008', CONVERT(DATE, '2023-08-01', 103), CONVERT(DATE, '2028-08-01', 103), 18.00),
    ('0002', '0009', CONVERT(DATE, '2023-09-01', 103), CONVERT(DATE, '2028-09-01', 103), 19.00),
    ('0002', '0010', CONVERT(DATE, '2023-10-01', 103), CONVERT(DATE, '2028-10-01', 103), 20.00),
    ('0002', '0011', CONVERT(DATE, '2023-11-01', 103), CONVERT(DATE, '2028-11-01', 103), 15.00),
    ('0002', '0012', CONVERT(DATE, '2023-12-01', 103), CONVERT(DATE, '2028-12-01', 103), 16.00),
    ('0002', '0013', CONVERT(DATE, '2023-01-01', 103), CONVERT(DATE, '2028-01-01', 103), 17.00),
    ('0002', '0014', CONVERT(DATE, '2023-02-01', 103), CONVERT(DATE, '2028-02-01', 103), 18.00),
    ('0002', '0015', CONVERT(DATE, '2023-03-01', 103), CONVERT(DATE, '2028-03-01', 103), 19.00),
    ('0002', '0016', CONVERT(DATE, '2023-04-01', 103), CONVERT(DATE, '2028-04-01', 103), 20.00),
    ('0002', '0017', CONVERT(DATE, '2023-05-01', 103), CONVERT(DATE, '2028-05-01', 103), 15.00),
    ('0002', '0018', CONVERT(DATE, '2023-06-01', 103), CONVERT(DATE, '2028-06-01', 103), 16.00),
    ('0002', '0019', CONVERT(DATE, '2023-07-01', 103), CONVERT(DATE, '2028-07-01', 103), 17.00),
    ('0002', '0020', CONVERT(DATE, '2023-08-01', 103), CONVERT(DATE, '2028-08-01', 103), 18.00),
    ('0003', '0001', CONVERT(DATE, '2023-01-01', 103), CONVERT(DATE, '2028-01-01', 103), 19.00),
    ('0003', '0002', CONVERT(DATE, '2023-02-01', 103), CONVERT(DATE, '2028-02-01', 103), 20.00),
    ('0003', '0003', CONVERT(DATE, '2023-03-01', 103), CONVERT(DATE, '2028-03-01', 103), 15.00),
	('0003', '0004', CONVERT(DATE, '2023-04-01', 103), CONVERT(DATE, '2028-04-01', 103), 16.00),
    ('0003', '0005', CONVERT(DATE, '2023-05-01', 103), CONVERT(DATE, '2028-05-01', 103), 17.00),
    ('0003', '0006', CONVERT(DATE, '2023-06-01', 103), CONVERT(DATE, '2028-06-01', 103), 18.00),
    ('0003', '0007', CONVERT(DATE, '2023-07-01', 103), CONVERT(DATE, '2028-07-01', 103), 19.00),
    ('0003', '0008', CONVERT(DATE, '2023-08-01', 103), CONVERT(DATE, '2028-08-01', 103), 20.00),
    ('0003', '0009', CONVERT(DATE, '2023-09-01', 103), CONVERT(DATE, '2028-09-01', 103), 15.00),
    ('0003', '0010', CONVERT(DATE, '2023-10-01', 103), CONVERT(DATE, '2028-10-01', 103), 16.00),
    ('0003', '0011', CONVERT(DATE, '2023-11-01', 103), CONVERT(DATE, '2028-11-01', 103), 17.00),
    ('0003', '0012', CONVERT(DATE, '2023-12-01', 103), CONVERT(DATE, '2028-12-01', 103), 18.00),
    ('0003', '0013', CONVERT(DATE, '2023-01-01', 103), CONVERT(DATE, '2028-01-01', 103), 19.00),
    ('0003', '0014', CONVERT(DATE, '2023-02-01', 103), CONVERT(DATE, '2028-02-01', 103), 20.00),
    ('0003', '0015', CONVERT(DATE, '2023-03-01', 103), CONVERT(DATE, '2028-03-01', 103), 15.00),
    ('0003', '0016', CONVERT(DATE, '2023-04-01', 103), CONVERT(DATE, '2028-04-01', 103), 16.00),
    ('0003', '0017', CONVERT(DATE, '2023-05-01', 103), CONVERT(DATE, '2028-05-01', 103), 17.00),
    ('0003', '0018', CONVERT(DATE, '2023-06-01', 103), CONVERT(DATE, '2028-06-01', 103), 18.00),
    ('0003', '0019', CONVERT(DATE, '2023-07-01', 103), CONVERT(DATE, '2028-07-01', 103), 19.00),
    ('0003', '0020', CONVERT(DATE, '2023-08-01', 103), CONVERT(DATE, '2028-08-01', 103), 20.00),
    ('0004', '0001', CONVERT(DATE, '2023-01-01', 103), CONVERT(DATE, '2028-01-01', 103), 15.00),
    ('0004', '0002', CONVERT(DATE, '2023-02-01', 103), CONVERT(DATE, '2028-02-01', 103), 16.00),
    ('0004', '0003', CONVERT(DATE, '2023-03-01', 103), CONVERT(DATE, '2028-03-01', 103), 17.00),
    ('0004', '0004', CONVERT(DATE, '2023-04-01', 103), CONVERT(DATE, '2028-04-01', 103), 18.00),
    ('0004', '0005', CONVERT(DATE, '2023-05-01', 103), CONVERT(DATE, '2028-05-01', 103), 19.00),
    ('0004', '0006', CONVERT(DATE, '2023-06-01', 103), CONVERT(DATE, '2028-06-01', 103), 20.00),
    ('0004', '0007', CONVERT(DATE, '2023-07-01', 103), CONVERT(DATE, '2028-07-01', 103), 15.00),
    ('0004', '0008', CONVERT(DATE, '2023-08-01', 103), CONVERT(DATE, '2028-08-01', 103), 16.00),
    ('0004', '0009', CONVERT(DATE, '2023-09-01', 103), CONVERT(DATE, '2028-09-01', 103), 17.00),
    ('0004', '0010', CONVERT(DATE, '2023-10-01', 103), CONVERT(DATE, '2028-10-01', 103), 18.00),
    ('0004', '0011', CONVERT(DATE, '2023-11-01', 103), CONVERT(DATE, '2028-11-01', 103), 19.00),
    ('0004', '0012', CONVERT(DATE, '2023-12-01', 103), CONVERT(DATE, '2028-12-01', 103), 20.00),
    ('0004', '0013', CONVERT(DATE, '2023-01-01', 103), CONVERT(DATE, '2028-01-01', 103), 15.00),
    ('0004', '0014', CONVERT(DATE, '2023-02-01', 103), CONVERT(DATE, '2028-02-01', 103), 16.00),
    ('0004', '0015', CONVERT(DATE, '2023-03-01', 103), CONVERT(DATE, '2028-03-01', 103), 17.00),
    ('0004', '0016', CONVERT(DATE, '2023-04-01', 103), CONVERT(DATE, '2028-04-01', 103), 18.00),
    ('0004', '0017', CONVERT(DATE, '2023-05-01', 103), CONVERT(DATE, '2028-05-01', 103), 19.00),
    ('0004', '0018', CONVERT(DATE, '2023-06-01', 103), CONVERT(DATE, '2028-06-01', 103), 20.00),
    ('0004', '0019', CONVERT(DATE, '2023-07-01', 103), CONVERT(DATE, '2028-07-01', 103), 15.00),
    ('0004', '0020', CONVERT(DATE, '2023-08-01', 103), CONVERT(DATE, '2028-08-01', 103), 16.00),
    ('0005', '0001', CONVERT(DATE, '2023-01-01', 103), CONVERT(DATE, '2028-01-01', 103), 17.00),
    ('0005', '0002', CONVERT(DATE, '2023-02-01', 103), CONVERT(DATE, '2028-02-01', 103), 18.00),
    ('0005', '0003', CONVERT(DATE, '2023-03-01', 103), CONVERT(DATE, '2028-03-01', 103), 19.00),
    ('0005', '0004', CONVERT(DATE, '2023-04-01', 103), CONVERT(DATE, '2028-04-01', 103), 20.00),
    ('0005', '0005', CONVERT(DATE, '2023-05-01', 103), CONVERT(DATE, '2028-05-01', 103), 15.00),
    ('0005', '0006', CONVERT(DATE, '2023-06-01', 103), CONVERT(DATE, '2028-06-01', 103), 16.00),
    ('0005', '0007', CONVERT(DATE, '2023-07-01', 103), CONVERT(DATE, '2028-07-01', 103), 17.00),
	('0005', '0008', CONVERT(DATE, '2023-08-01', 103), CONVERT(DATE, '2028-08-01', 103), 18.00),
    ('0005', '0009', CONVERT(DATE, '2023-09-01', 103), CONVERT(DATE, '2028-09-01', 103), 19.00),
    ('0005', '0010', CONVERT(DATE, '2023-10-01', 103), CONVERT(DATE, '2028-10-01', 103), 20.00),
    ('0005', '0011', CONVERT(DATE, '2023-11-01', 103), CONVERT(DATE, '2028-11-01', 103), 15.00),
    ('0005', '0012', CONVERT(DATE, '2023-12-01', 103), CONVERT(DATE, '2028-12-01', 103), 16.00),
    ('0005', '0013', CONVERT(DATE, '2023-01-01', 103), CONVERT(DATE, '2028-01-01', 103), 17.00),
    ('0005', '0014', CONVERT(DATE, '2023-02-01', 103), CONVERT(DATE, '2028-02-01', 103), 18.00),
    ('0005', '0015', CONVERT(DATE, '2023-03-01', 103), CONVERT(DATE, '2028-03-01', 103), 19.00),
    ('0005', '0016', CONVERT(DATE, '2023-04-01', 103), CONVERT(DATE, '2028-04-01', 103), 20.00),
    ('0005', '0017', CONVERT(DATE, '2023-05-01', 103), CONVERT(DATE, '2028-05-01', 103), 15.00),
    ('0005', '0018', CONVERT(DATE, '2023-06-01', 103), CONVERT(DATE, '2028-06-01', 103), 16.00),
    ('0005', '0019', CONVERT(DATE, '2023-07-01', 103), CONVERT(DATE, '2028-07-01', 103), 17.00),
    ('0005', '0020', CONVERT(DATE, '2023-08-01', 103), CONVERT(DATE, '2028-08-01', 103), 18.00),
    ('0006', '0001', CONVERT(DATE, '2023-01-01', 103), CONVERT(DATE, '2028-01-01', 103), 19.00),
    ('0006', '0002', CONVERT(DATE, '2023-02-01', 103), CONVERT(DATE, '2028-02-01', 103), 20.00),
    ('0006', '0003', CONVERT(DATE, '2023-03-01', 103), CONVERT(DATE, '2028-03-01', 103), 15.00),
    ('0006', '0004', CONVERT(DATE, '2023-04-01', 103), CONVERT(DATE, '2028-04-01', 103), 16.00),
    ('0006', '0005', CONVERT(DATE, '2023-05-01', 103), CONVERT(DATE, '2028-05-01', 103), 17.00),
    ('0006', '0006', CONVERT(DATE, '2023-06-01', 103), CONVERT(DATE, '2028-06-01', 103), 18.00),
    ('0006', '0007', CONVERT(DATE, '2023-07-01', 103), CONVERT(DATE, '2028-07-01', 103), 19.00),
    ('0006', '0008', CONVERT(DATE, '2023-08-01', 103), CONVERT(DATE, '2028-08-01', 103), 20.00),
    ('0006', '0009', CONVERT(DATE, '2023-09-01', 103), CONVERT(DATE, '2028-09-01', 103), 15.00),
    ('0006', '0010', CONVERT(DATE, '2023-10-01', 103), CONVERT(DATE, '2028-10-01', 103), 16.00),
    ('0006', '0011', CONVERT(DATE, '2023-11-01', 103), CONVERT(DATE, '2028-11-01', 103), 17.00),
    ('0006', '0012', CONVERT(DATE, '2023-12-01', 103), CONVERT(DATE, '2028-12-01', 103), 18.00),
    ('0006', '0013', CONVERT(DATE, '2023-01-01', 103), CONVERT(DATE, '2028-01-01', 103), 19.00),
    ('0006', '0014', CONVERT(DATE, '2023-02-01', 103), CONVERT(DATE, '2028-02-01', 103), 20.00),
    ('0006', '0015', CONVERT(DATE, '2023-03-01', 103), CONVERT(DATE, '2028-03-01', 103), 15.00),
    ('0006', '0016', CONVERT(DATE, '2023-04-01', 103), CONVERT(DATE, '2028-04-01', 103), 16.00),
    ('0006', '0017', CONVERT(DATE, '2023-05-01', 103), CONVERT(DATE, '2028-05-01', 103), 17.00),
    ('0006', '0018', CONVERT(DATE, '2023-06-01', 103), CONVERT(DATE, '2028-06-01', 103), 18.00),
    ('0006', '0019', CONVERT(DATE, '2023-07-01', 103), CONVERT(DATE, '2028-07-01', 103), 19.00),
    ('0006', '0020', CONVERT(DATE, '2023-08-01', 103), CONVERT(DATE, '2028-08-01', 103), 20.00),
    ('0007', '0001', CONVERT(DATE, '2023-01-01', 103), CONVERT(DATE, '2028-01-01', 103), 15.00),
    ('0007', '0002', CONVERT(DATE, '2023-02-01', 103), CONVERT(DATE, '2028-02-01', 103), 16.00),
    ('0007', '0003', CONVERT(DATE, '2023-03-01', 103), CONVERT(DATE, '2028-03-01', 103), 17.00),
    ('0007', '0004', CONVERT(DATE, '2023-04-01', 103), CONVERT(DATE, '2028-04-01', 103), 18.00),
    ('0007', '0005', CONVERT(DATE, '2023-05-01', 103), CONVERT(DATE, '2028-05-01', 103), 19.00),
    ('0007', '0006', CONVERT(DATE, '2023-06-01', 103), CONVERT(DATE, '2028-06-01', 103), 20.00),
    ('0007', '0007', CONVERT(DATE, '2023-07-01', 103), CONVERT(DATE, '2028-07-01', 103), 15.00),
    ('0007', '0008', CONVERT(DATE, '2023-08-01', 103), CONVERT(DATE, '2028-08-01', 103), 16.00),
    ('0007', '0009', CONVERT(DATE, '2023-09-01', 103), CONVERT(DATE, '2028-09-01', 103), 17.00),
    ('0007', '0010', CONVERT(DATE, '2023-10-01', 103), CONVERT(DATE, '2028-10-01', 103), 18.00),
    ('0007', '0011', CONVERT(DATE, '2023-11-01', 103), CONVERT(DATE, '2028-11-01', 103), 19.00),
	('0007', '0012', CONVERT(DATE, '2023-12-01', 103), CONVERT(DATE, '2028-12-01', 103), 20.00),
    ('0007', '0013', CONVERT(DATE, '2023-01-01', 103), CONVERT(DATE, '2028-01-01', 103), 15.00),
    ('0007', '0014', CONVERT(DATE, '2023-02-01', 103), CONVERT(DATE, '2028-02-01', 103), 16.00),
    ('0007', '0015', CONVERT(DATE, '2023-03-01', 103), CONVERT(DATE, '2028-03-01', 103), 17.00),
    ('0007', '0016', CONVERT(DATE, '2023-04-01', 103), CONVERT(DATE, '2028-04-01', 103), 18.00),
    ('0007', '0017', CONVERT(DATE, '2023-05-01', 103), CONVERT(DATE, '2028-05-01', 103), 19.00),
    ('0007', '0018', CONVERT(DATE, '2023-06-01', 103), CONVERT(DATE, '2028-06-01', 103), 20.00),
    ('0007', '0019', CONVERT(DATE, '2023-07-01', 103), CONVERT(DATE, '2028-07-01', 103), 15.00),
    ('0007', '0020', CONVERT(DATE, '2023-08-01', 103), CONVERT(DATE, '2028-08-01', 103), 16.00),
    ('0008', '0001', CONVERT(DATE, '2023-01-01', 103), CONVERT(DATE, '2028-01-01', 103), 17.00),
    ('0008', '0002', CONVERT(DATE, '2023-02-01', 103), CONVERT(DATE, '2028-02-01', 103), 18.00),
    ('0008', '0003', CONVERT(DATE, '2023-03-01', 103), CONVERT(DATE, '2028-03-01', 103), 19.00),
    ('0008', '0004', CONVERT(DATE, '2023-04-01', 103), CONVERT(DATE, '2028-04-01', 103), 20.00),
    ('0008', '0005', CONVERT(DATE, '2023-05-01', 103), CONVERT(DATE, '2028-05-01', 103), 15.00),
    ('0008', '0006', CONVERT(DATE, '2023-06-01', 103), CONVERT(DATE, '2028-06-01', 103), 16.00),
    ('0008', '0007', CONVERT(DATE, '2023-07-01', 103), CONVERT(DATE, '2028-07-01', 103), 17.00),
    ('0008', '0008', CONVERT(DATE, '2023-08-01', 103), CONVERT(DATE, '2028-08-01', 103), 18.00),
    ('0008', '0009', CONVERT(DATE, '2023-09-01', 103), CONVERT(DATE, '2028-09-01', 103), 19.00),
    ('0008', '0010', CONVERT(DATE, '2023-10-01', 103), CONVERT(DATE, '2028-10-01', 103), 20.00),
    ('0008', '0011', CONVERT(DATE, '2023-11-01', 103), CONVERT(DATE, '2028-11-01', 103), 15.00),
    ('0008', '0012', CONVERT(DATE, '2023-12-01', 103), CONVERT(DATE, '2028-12-01', 103), 16.00),
    ('0008', '0013', CONVERT(DATE, '2023-01-01', 103), CONVERT(DATE, '2028-01-01', 103), 17.00),
    ('0008', '0014', CONVERT(DATE, '2023-02-01', 103), CONVERT(DATE, '2028-02-01', 103), 18.00),
    ('0008', '0015', CONVERT(DATE, '2023-03-01', 103), CONVERT(DATE, '2028-03-01', 103), 19.00),
    ('0008', '0016', CONVERT(DATE, '2023-04-01', 103), CONVERT(DATE, '2028-04-01', 103), 20.00),
    ('0008', '0017', CONVERT(DATE, '2023-05-01', 103), CONVERT(DATE, '2028-05-01', 103), 15.00),
    ('0008', '0018', CONVERT(DATE, '2023-06-01', 103), CONVERT(DATE, '2028-06-01', 103), 16.00),
    ('0008', '0019', CONVERT(DATE, '2023-07-01', 103), CONVERT(DATE, '2028-07-01', 103), 17.00),
    ('0008', '0020', CONVERT(DATE, '2023-08-01', 103), CONVERT(DATE, '2028-08-01', 103), 18.00);
GO

-- Insert Data into Tenant
INSERT INTO Tenant (Tenant_ID, Tenant_Name, Phone_Number, Tenant_Email, Date_of_Birth, Host) VALUES
	('0001', 'John Smith', '0987654321', 'john.smith@gmail.com', CONVERT(DATE, '1985-12-08', 120), 0),
	('0002', 'Jane Doe', '0971234567', 'jane.doe@gmail.com', CONVERT(DATE, '1990-07-15', 120), 0),
	('0003', 'Michael Johnson', '0969876543', 'michael.johnson@gmail.com', CONVERT(DATE, '1982-02-02', 120), 0),
	('0004', 'Emily Davis', '0953456789', 'emily.davis@gmail.com', CONVERT(DATE, '1995-04-22', 120), 1),
	('0005', 'James Brown', '0945678901', 'james.brown@gmail.com', CONVERT(DATE, '1987-10-11', 120), 1),
	('0006', 'Mary Wilson', '0931230987', 'mary.wilson@gmail.com', CONVERT(DATE, '1993-03-30', 120), 0),
	('0007', 'Robert Miller', '0923456789', 'robert.miller@gmail.com', CONVERT(DATE, '1981-09-18', 120), 0),
	('0008', 'Patricia Moore', '0910987654', 'patricia.moore@gmail.com', CONVERT(DATE, '1978-12-25', 120), 0),
	('0009', 'William Anderson', '0907654321', 'william.anderson@gmail.com', CONVERT(DATE, '1984-05-14', 120), 1),
	('0010', 'Linda Taylor', '0899876543', 'linda.taylor@gmail.com', CONVERT(DATE, '1989-01-21', 120), 1),
	('0011', 'David Thomas', '0881234567', 'david.thomas@gmail.com', CONVERT(DATE, '1992-07-10', 120), 1),
	('0012', 'Barbara Jackson', '0873456789', 'barbara.jackson@gmail.com', CONVERT(DATE, '1980-06-29', 120), 0),
	('0013', 'Richard White', '0865678901', 'richard.white@gmail.com', CONVERT(DATE, '1985-03-03', 120), 1),
	('0014', 'Susan Harris', '0857654321', 'susan.harris@gmail.com', CONVERT(DATE, '1991-08-19', 120), 1),
	('0015', 'Charles Martin', '0841234567', 'charles.martin@gmail.com', CONVERT(DATE, '1975-12-28', 120), 0),
	('0016', 'Jessica Clark', '0833456789', 'jessica.clark@gmail.com', CONVERT(DATE, '1994-11-11', 120), 0),
	('0017', 'Joseph Lee', '0825678901', 'joseph.lee@gmail.com', CONVERT(DATE, '1988-05-06', 120), 1),
	('0018', 'Sarah Lewis', '0817654321', 'sarah.lewis@gmail.com', CONVERT(DATE, '1996-02-20', 120), 0),
	('0019', 'Christopher Walker', '0809876543', 'christopher.walker@gmail.com', CONVERT(DATE, '1983-08-09', 120), 0),
	('0020', 'Karen Young', '0791234567', 'karen.young@gmail.com', CONVERT(DATE, '1979-04-04', 120), 1),
	('0021', 'Daniel King', '0783456789', 'daniel.king@gmail.com', CONVERT(DATE, '1986-07-17', 120), 0),
	('0022', 'Lisa Wright', '0775678901', 'lisa.wright@gmail.com', CONVERT(DATE, '1992-01-24', 120), 1),
	('0023', 'Matthew Green', '0767654321', 'matthew.green@gmail.com', CONVERT(DATE, '1984-11-13', 120), 0),
	('0024', 'Nancy Adams', '0759876543', 'nancy.adams@gmail.com', CONVERT(DATE, '1991-05-27', 120), 0),
	('0025', 'Anthony Baker', '0741234567', 'anthony.baker@gmail.com', CONVERT(DATE, '1983-03-16', 120), 0),
	('0026', 'Margaret Hall', '0733456789', 'margaret.hall@gmail.com', CONVERT(DATE, '1986-09-10', 120), 0),
	('0027', 'Donald Scott', '0725678901', 'donald.scott@gmail.com', CONVERT(DATE, '1987-06-06', 120), 0),
	('0028', 'Betty Allen', '0717654321', 'betty.allen@gmail.com', CONVERT(DATE, '1974-12-09', 120), 0),
	('0029', 'Mark Parker', '0709876543', 'mark.parker@gmail.com', CONVERT(DATE, '1980-08-21', 120), 0),
	('0030', 'Sandra Mitchell', '0691234567', 'sandra.mitchell@gmail.com', CONVERT(DATE, '1992-03-12', 120), 1),
	('0031', 'Paul Campbell', '0683456789', 'paul.campbell@gmail.com', CONVERT(DATE, '1985-04-10', 120), 1),
	('0032', 'Ashley Evans', '0675678901', 'ashley.evans@gmail.com', CONVERT(DATE, '1990-06-13', 120), 0),
	('0033', 'Steven Carter', '0667654321', 'steven.carter@gmail.com', CONVERT(DATE, '1987-02-02', 120), 1),
	('0034', 'Kimberly Roberts', '0659876543', 'kimberly.roberts@gmail.com', CONVERT(DATE, '1995-01-04', 120), 0),
	('0035', 'Andrew Phillips', '0641234567', 'andrew.phillips@gmail.com', CONVERT(DATE, '1988-10-11', 120), 1),
	('0036', 'Laura Turner', '0633456789', 'laura.turner@gmail.com', CONVERT(DATE, '1991-05-05', 120), 0),
	('0037', 'Kenneth Perez', '0625678901', 'kenneth.perez@gmail.com', CONVERT(DATE, '1983-07-23', 120), 0),
	('0038', 'Megan Carter', '0617654321', 'megan.carter@gmail.com', CONVERT(DATE, '1996-09-14', 120), 1),
	('0039', 'Joshua Collins', '0609876543', 'joshua.collins@gmail.com', CONVERT(DATE, '1984-01-20', 120), 1),
	('0040', 'Sarah Rodriguez', '0591234567', 'sarah.rodriguez@gmail.com', CONVERT(DATE, '1989-11-11', 120), 1),
	('0041', 'Kevin Williams', '0583456789', 'kevin.williams@gmail.com', CONVERT(DATE, '1985-02-15', 120), 1),
	('0042', 'Donna Hernandez', '0575678901', 'donna.hernandez@gmail.com', CONVERT(DATE, '1993-10-26', 120), 0),
	('0043', 'Brian Washington', '0567654321', 'brian.washington@gmail.com', CONVERT(DATE, '1981-03-30', 120), 1),
	('0044', 'Amy Lee', '0559876543', 'amy.lee@gmail.com', CONVERT(DATE, '1992-07-19', 120), 1),
	('0045', 'George Nelson', '0541234567', 'george.nelson@gmail.com', CONVERT(DATE, '1984-12-22', 120), 1),
	('0046', 'Angela Martinez', '0533456789', 'angela.martinez@gmail.com', CONVERT(DATE, '1990-09-09', 120), 0),
	('0047', 'Edward Sanchez', '0525678901', 'edward.sanchez@gmail.com', CONVERT(DATE, '1986-12-17', 120), 1),
	('0048', 'Deborah Clark', '0517654321', 'deborah.clark@gmail.com', CONVERT(DATE, '1979-08-02', 120), 1),
	('0049', 'Ronald Collins', '0509876543', 'ronald.collins@gmail.com', CONVERT(DATE, '1981-11-25', 120), 0),
	('0050', 'Stephanie Walker', '0491234567', 'stephanie.walker@gmail.com', CONVERT(DATE, '1990-12-05', 120), 1),
	('0051', 'Timothy Shaw', '0483456789', 'timothy.shaw@gmail.com', CONVERT(DATE, '1988-07-03', 120), 0),
	('0052', 'Helen Brooks', '0475678901', 'helen.brooks@gmail.com', CONVERT(DATE, '1995-08-16', 120), 0),
	('0053', 'Jason Richardson', '0467654321', 'jason.richardson@gmail.com', CONVERT(DATE, '1982-06-13', 120), 1),
	('0054', 'Melissa Lee', '0459876543', 'melissa.lee@gmail.com', CONVERT(DATE, '1994-01-11', 120), 1),
	('0055', 'Jeffrey Stewart', '0441234567', 'jeffrey.stewart@gmail.com', CONVERT(DATE, '1985-03-04', 120), 0),
	('0056', 'Amanda Robinson', '0433456789', 'amanda.robinson@gmail.com', CONVERT(DATE, '1991-09-29', 120), 1),
	('0057', 'Ryan Perry', '0425678901', 'ryan.perry@gmail.com', CONVERT(DATE, '1986-10-18', 120), 0),
	('0058', 'Carolyn Powell', '0417654321', 'carolyn.powell@gmail.com', CONVERT(DATE, '1988-12-24', 120), 0),
	('0059', 'Jacob Peterson', '0409876543', 'jacob.peterson@gmail.com', CONVERT(DATE, '1992-08-15', 120), 1),
	('0060', 'Katherine Jenkins', '0391234567', 'katherine.jenkins@gmail.com', CONVERT(DATE, '1984-05-27', 120), 1),
	('0061', 'Gary Hayes', '0383456789', 'gary.hayes@gmail.com', CONVERT(DATE, '1983-04-04', 120), 1),
	('0062', 'Rebecca Evans', '0375678901', 'rebecca.evans@gmail.com', CONVERT(DATE, '1993-09-06', 120), 0),
	('0063', 'Nicholas Cooper', '0367654321', 'nicholas.cooper@gmail.com', CONVERT(DATE, '1991-07-21', 120), 0),
	('0064', 'Anna Rivera', '0359876543', 'anna.rivera@gmail.com', CONVERT(DATE, '1989-01-03', 120), 1),
	('0065', 'Eric Morris', '0341234567', 'eric.morris@gmail.com', CONVERT(DATE, '1982-05-26', 120), 1),
	('0066', 'Dorothy Murphy', '0333456789', 'dorothy.murphy@gmail.com', CONVERT(DATE, '1978-09-30', 120), 0),
	('0067', 'Stephen Rogers', '0325678901', 'stephen.rogers@gmail.com', CONVERT(DATE, '1990-05-12', 120), 0),
	('0068', 'Virginia Reed', '0317654321', 'virginia.reed@gmail.com', CONVERT(DATE, '1987-06-20', 120), 0),
	('0069', 'Jonathan Cook', '0309876543', 'jonathan.cook@gmail.com', CONVERT(DATE, '1982-01-22', 120), 0),
	('0070', 'Frances Price', '0291234567', 'frances.price@gmail.com', CONVERT(DATE, '1985-03-16', 120), 1),
	('0071', 'Larry Richardson', '0283456789', 'larry.richardson@gmail.com', CONVERT(DATE, '1994-11-18', 120), 0),
	('0072', 'Julie Cox', '0275678901', 'julie.cox@gmail.com', CONVERT(DATE, '1986-11-04', 120), 1),
	('0073', 'Justin Howard', '0267654321', 'justin.howard@gmail.com', CONVERT(DATE, '1981-09-20', 120), 1),
	('0074', 'Rachel Flores', '0259876543', 'rachel.flores@gmail.com', CONVERT(DATE, '1991-03-23', 120), 0),
	('0075', 'Scott Ward', '0241234567', 'scott.ward@gmail.com', CONVERT(DATE, '1983-10-10', 120), 1),
	('0076', 'Katherine Ramirez', '0233456789', 'katherine.ramirez@gmail.com', CONVERT(DATE, '1988-06-25', 120), 0),
	('0077', 'Brandon Brooks', '0225678901', 'brandon.brooks@gmail.com', CONVERT(DATE, '1985-02-12', 120), 0),
	('0078', 'Emily Bell', '0217654321', 'emily.bell@gmail.com', CONVERT(DATE, '1992-08-29', 120), 1),
	('0079', 'Aaron James', '0209876543', 'aaron.james@gmail.com', CONVERT(DATE, '1986-03-07', 120), 1),
	('0080', 'Diana Evans', '0191234567', 'diana.evans@gmail.com', CONVERT(DATE, '1987-09-18', 120), 0),
	('0081', 'Adam Edwards', '0183456789', 'adam.edwards@gmail.com', CONVERT(DATE, '1994-04-24', 120), 0),
	('0082', 'Stephanie Moore', '0175678901', 'stephanie.moore@gmail.com', CONVERT(DATE, '1989-10-14', 120), 1),
	('0083', 'Richard Sanders', '0167654321', 'richard.sanders@gmail.com', CONVERT(DATE, '1985-06-02', 120), 1),
	('0084', 'Cynthia Hughes', '0159876543', 'cynthia.hughes@gmail.com', CONVERT(DATE, '1992-11-17', 120), 1),
	('0085', 'Wayne Willis', '0141234567', 'wayne.willis@gmail.com', CONVERT(DATE, '1979-11-08', 120), 1),
	('0086', 'Teresa Foster', '0133456789', 'teresa.foster@gmail.com', CONVERT(DATE, '1982-08-03', 120), 1),
	('0087', 'Randy Jenkins', '0125678901', 'randy.jenkins@gmail.com', CONVERT(DATE, '1990-06-13', 120), 0),
	('0088', 'Pamela Gonzalez', '0117654321', 'pamela.gonzalez@gmail.com', CONVERT(DATE, '1993-01-22', 120), 0),
	('0089', 'Zachary Brown', '0109876543', 'zachary.brown@gmail.com', CONVERT(DATE, '1988-05-05', 120), 1),
	('0090', 'Denise Holmes', '0991234567', 'denise.holmes@gmail.com', CONVERT(DATE, '1984-12-20', 120), 1),
	('0091', 'Todd Martinez', '0983456789', 'todd.martinez@gmail.com', CONVERT(DATE, '1981-01-09', 120), 1),
	('0092', 'Carolyn Ward', '0975678901', 'carolyn.ward@gmail.com', CONVERT(DATE, '1992-10-14', 120), 1),
	('0093', 'Frank Watson', '0967654321', 'frank.watson@gmail.com', CONVERT(DATE, '1980-07-18', 120), 1),
	('0094', 'Brenda Ward', '0959876543', 'brenda.ward@gmail.com', CONVERT(DATE, '1989-04-23', 120), 1),
	('0095', 'Johnny Perry', '0941234567', 'johnny.perry@gmail.com', CONVERT(DATE, '1983-11-27', 120), 1),
	('0096', 'Amy Hughes', '0933456789', 'amy.hughes@gmail.com', CONVERT(DATE, '1991-07-03', 120), 0),
	('0097', 'Billy Hall', '0925678901', 'billy.hall@gmail.com', CONVERT(DATE, '1985-08-29', 120), 1),
	('0098', 'Kelly Riley', '0917654321', 'kelly.riley@gmail.com', CONVERT(DATE, '1994-06-06', 120), 0),
	('0099', 'Carl Brown', '0909876543', 'carl.brown@gmail.com', CONVERT(DATE, '1982-09-19', 120), 1),
	('0100', 'Laura Chavez', '0891234567', 'laura.chavez@gmail.com', CONVERT(DATE, '1986-12-30', 120), 1),
	('0101', 'Bobby Rivera', '0883456789', 'bobby.rivera@gmail.com', CONVERT(DATE, '1990-01-15', 120), 1),
	('0102', 'Julia Ramos', '0875678901', 'julia.ramos@gmail.com', CONVERT(DATE, '1992-03-21', 120), 0),
	('0103', 'Bruce Berry', '0867654321', 'bruce.berry@gmail.com', CONVERT(DATE, '1987-08-14', 120), 0),
	('0104', 'Sharon Mills', '0859876543', 'sharon.mills@gmail.com', CONVERT(DATE, '1984-04-11', 120), 1),
	('0105', 'Roger Howard', '0841234567', 'roger.howard@gmail.com', CONVERT(DATE, '1986-04-17', 120), 0),
	('0106', 'Katherine Adams', '0833456789', 'katherine.adams@gmail.com', CONVERT(DATE, '1990-08-06', 120), 1),
	('0107', 'Scott Hernandez', '0825678901', 'scott.hernandez@gmail.com', CONVERT(DATE, '1991-11-19', 120), 1),
	('0108', 'Amanda Fisher', '0817654321', 'amanda.fisher@gmail.com', CONVERT(DATE, '1993-12-02', 120), 0),
	('0109', 'Keith Butler', '0809876543', 'keith.butler@gmail.com', CONVERT(DATE, '1989-10-05', 120), 1),
	('0110', 'Jennifer Edwards', '0791234567', 'jennifer.edwards@gmail.com', CONVERT(DATE, '1988-02-03', 120), 1),
	('0111', 'Robert Kelly', '0783456789', 'robert.kelly@gmail.com', CONVERT(DATE, '1983-09-30', 120), 1),
	('0112', 'Theresa Coleman', '0775678901', 'theresa.coleman@gmail.com', CONVERT(DATE, '1990-12-16', 120), 0),
	('0113', 'Phillip Ward', '0767654321', 'phillip.ward@gmail.com', CONVERT(DATE, '1992-09-08', 120), 1),
	('0114', 'Barbara Hughes', '0759876543', 'barbara.hughes@gmail.com', CONVERT(DATE, '1984-05-22', 120), 1),
	('0115', 'John Jenkins', '0741234567', 'john.jenkins@gmail.com', CONVERT(DATE, '1981-03-07', 120), 0),
	('0116', 'Sandra Cox', '0733456789', 'sandra.cox@gmail.com', CONVERT(DATE, '1992-11-24', 120), 1),
	('0117', 'Zachary Lee', '0725678901', 'zachary.lee@gmail.com', CONVERT(DATE, '1987-07-08', 120), 1),
	('0118', 'Debra Richardson', '0717654321', 'debra.richardson@gmail.com', CONVERT(DATE, '1985-12-22', 120), 0),
	('0119', 'Patrick Nelson', '0709876543', 'patrick.nelson@gmail.com', CONVERT(DATE, '1989-01-28', 120), 0),
	('0120', 'Stephanie Ward', '0691234567', 'stephanie.ward@gmail.com', CONVERT(DATE, '1990-09-02', 120), 0),
	('0121', 'Larry Gonzales', '0683456789', 'larry.gonzales@gmail.com', CONVERT(DATE, '1983-11-21', 120), 1),
	('0122', 'Rebecca Martinez', '0675678901', 'rebecca.martinez@gmail.com', CONVERT(DATE, '1993-06-05', 120), 0),
	('0123', 'Ryan Reed', '0667654321', 'ryan.reed@gmail.com', CONVERT(DATE, '1992-03-09', 120), 1),
	('0124', 'Sandra Bailey', '0659876543', 'sandra.bailey@gmail.com', CONVERT(DATE, '1987-12-17', 120), 0),
	('0125', 'Brian Gonzalez', '0641234567', 'brian.gonzalez@gmail.com', CONVERT(DATE, '1991-10-14', 120), 0),
	('0126', 'Melissa Long', '0633456789', 'melissa.long@gmail.com', CONVERT(DATE, '1986-05-04', 120), 0),
	('0127', 'Richard Watson', '0625678901', 'richard.watson@gmail.com', CONVERT(DATE, '1989-11-07', 120), 0),
	('0128', 'Pamela Ross', '0617654321', 'pamela.ross@gmail.com', CONVERT(DATE, '1984-02-11', 120), 0),
	('0129', 'Eric Bennett', '0609876543', 'eric.bennett@gmail.com', CONVERT(DATE, '1992-06-19', 120), 0),
	('0130', 'Carol Russell', '0591234567', 'carol.russell@gmail.com', CONVERT(DATE, '1990-01-16', 120), 1),
	('0131', 'Jason Patterson', '0583456789', 'jason.patterson@gmail.com', CONVERT(DATE, '1987-09-23', 120), 1),
	('0132', 'Nicole Diaz', '0575678901', 'nicole.diaz@gmail.com', CONVERT(DATE, '1994-03-28', 120), 1),
	('0133', 'Benjamin Edwards', '0567654321', 'benjamin.edwards@gmail.com', CONVERT(DATE, '1985-08-13', 120), 0),
	('0134', 'Teresa Brooks', '0559876543', 'teresa.brooks@gmail.com', CONVERT(DATE, '1990-04-26', 120), 1),
	('0135', 'Samuel Ward', '0541234567', 'samuel.ward@gmail.com', CONVERT(DATE, '1983-12-22', 120), 1),
	('0136', 'Helen Powell', '0533456789', 'helen.powell@gmail.com', CONVERT(DATE, '1982-08-07', 120), 1),
	('0137', 'Joshua Kelly', '0525678901', 'joshua.kelly@gmail.com', CONVERT(DATE, '1994-10-11', 120), 0),
	('0138', 'Frances Torres', '0517654321', 'frances.torres@gmail.com', CONVERT(DATE, '1986-12-09', 120), 0),
	('0139', 'Gary Bailey', '0509876543', 'gary.bailey@gmail.com', CONVERT(DATE, '1983-06-29', 120), 1),
	('0140', 'Cynthia Fisher', '0999876543', 'cynthia.fisher@gmail.com', CONVERT(DATE, '1991-02-20', 120), 1),
	('0141', 'Justin Rivera', '0981234567', 'justin.rivera@gmail.com', CONVERT(DATE, '1989-04-09', 120), 0),
	('0142', 'Diana Martinez', '0978765432', 'diana.martinez@gmail.com', CONVERT(DATE, '1987-12-24', 120), 1),
	('0143', 'Albert Woods', '0962345678', 'albert.woods@gmail.com', CONVERT(DATE, '1984-11-05', 120), 0),
	('0144', 'Carolyn Jenkins', '0956789012', 'carolyn.jenkins@gmail.com', CONVERT(DATE, '1993-04-19', 120), 1),
	('0145', 'Anthony Harrison', '0949876543', 'anthony.harrison@gmail.com', CONVERT(DATE, '1988-09-08', 120), 0),
	('0146', 'Julia Bryant', '0938765432', 'julia.bryant@gmail.com', CONVERT(DATE, '1991-12-10', 120), 1),
	('0147', 'Steven Howard', '0927654321', 'steven.howard@gmail.com', CONVERT(DATE, '1986-07-03', 120), 0),
	('0148', 'Amy Powell', '0912345678', 'amy.powell@gmail.com', CONVERT(DATE, '1990-06-25', 120), 1),
	('0149', 'Joshua Butler', '0903456789', 'joshua.butler@gmail.com', CONVERT(DATE, '1985-11-13', 120), 1),
	('0150', 'Laura Ward', '0895678901', 'laura.ward@gmail.com', CONVERT(DATE, '1994-01-01', 120), 1);
GO

-- Insert Data into Unit
INSERT INTO Unit (Unit_ID, Property_ID, Number, Floor, Rent, Status) VALUES
    ('0001', '0001', 'A101', 1, 13.00, 'Available'),
    ('0002', '0001', 'A102', 2, 19.00, 'Rented'),
    ('0003', '0001', 'A103', 3, 15.00, 'Rented'),
    ('0004', '0001', 'A104', 4, 18.00, 'Available'),
    ('0005', '0001', 'A105', 5, 10.00, 'Rented'),
    ('0006', '0001', 'A106', 1, 14.00, 'Rented'),
    ('0007', '0001', 'A107', 2, 16.00, 'Available'),
    ('0008', '0002', 'A201', 1, 11.00, 'Rented'),
    ('0009', '0002', 'A202', 2, 17.00, 'Rented'),
    ('0010', '0002', 'A203', 3, 12.00, 'Available'),
    ('0011', '0002', 'A204', 4, 19.00, 'Rented'),
    ('0012', '0002', 'A205', 5, 10.00, 'Available'),
    ('0013', '0002', 'A206', 1, 15.00, 'Rented'),
    ('0014', '0002', 'A207', 2, 13.00, 'Rented'),
    ('0015', '0003', 'A301', 1, 14.00, 'Rented'),
    ('0016', '0003', 'A302', 2, 17.00, 'Available'),
    ('0017', '0003', 'A303', 3, 10.00, 'Available'),
    ('0018', '0003', 'A304', 4, 16.00, 'Available'),
    ('0019', '0003', 'A305', 5, 20.00, 'Rented'),
    ('0020', '0003', 'A306', 1, 13.00, 'Rented'),
    ('0021', '0003', 'A307', 2, 19.00, 'Rented'),
    ('0022', '0004', 'A401', 1, 18.00, 'Rented'),
    ('0023', '0004', 'A402', 2, 12.00, 'Rented'),
    ('0024', '0004', 'A403', 3, 14.00, 'Rented'),
    ('0025', '0004', 'A404', 4, 16.00, 'Available'),
    ('0026', '0004', 'A405', 5, 11.00, 'Available'),
    ('0027', '0004', 'A406', 1, 17.00, 'Rented'),
    ('0028', '0004', 'A407', 2, 15.00, 'Rented'),
    ('0029', '0005', 'A501', 1, 19.00, 'Rented'),
    ('0030', '0005', 'A502', 2, 13.00, 'Rented'),
    ('0031', '0005', 'A503', 3, 10.00, 'Rented'),
    ('0032', '0005', 'A504', 4, 18.00, 'Available'),
    ('0033', '0005', 'A505', 5, 12.00, 'Rented'),
    ('0034', '0005', 'A506', 1, 14.00, 'Available'),
    ('0035', '0005', 'A507', 2, 11.00, 'Rented'),
    ('0036', '0006', 'A601', 1, 20.00, 'Rented'),
    ('0037', '0006', 'A602', 2, 16.00, 'Rented'),
    ('0038', '0006', 'A603', 3, 15.00, 'Rented'),
    ('0039', '0006', 'A604', 4, 17.00, 'Available'),
    ('0040', '0006', 'A605', 5, 19.00, 'Available'),
    ('0041', '0006', 'A606', 1, 12.00, 'Rented'),
    ('0042', '0006', 'A607', 2, 13.00, 'Rented'),
    ('0043', '0007', 'A701', 1, 11.00, 'Available'),
    ('0044', '0007', 'A702', 2, 18.00, 'Available'),
    ('0045', '0007', 'A703', 3, 14.00, 'Available'),
    ('0046', '0007', 'A704', 4, 10.00, 'Available'),
    ('0047', '0007', 'A705', 5, 20.00, 'Rented'),
    ('0048', '0007', 'A706', 1, 17.00, 'Available'),
    ('0049', '0007', 'A707', 2, 15.00, 'Available'),
    ('0050', '0008', 'A801', 1, 13.00, 'Rented'),
    ('0051', '0008', 'A802', 2, 16.00, 'Rented'),
    ('0052', '0008', 'A803', 3, 19.00, 'Available'),
    ('0053', '0008', 'A804', 4, 11.00, 'Rented'),
    ('0054', '0008', 'A805', 5, 18.00, 'Rented'),
    ('0055', '0008', 'A806', 1, 12.00, 'Available'),
    ('0056', '0008', 'A807', 2, 17.00, 'Rented'),
    ('0057', '0009', 'A901', 1, 10.00, 'Rented'),
    ('0058', '0009', 'A902', 2, 14.00, 'Rented'),
    ('0059', '0009', 'A903', 3, 20.00, 'Available'),
    ('0060', '0009', 'A904', 4, 13.00, 'Rented'),
    ('0061', '0009', 'A905', 5, 19.00, 'Rented'),
    ('0062', '0009', 'A906', 1, 11.00, 'Rented'),
    ('0063', '0009', 'A907', 2, 16.00, 'Rented'),
    ('0064', '0010', 'A1001', 1, 15.00, 'Available'),
    ('0065', '0010', 'A1002', 2, 18.00, 'Rented'),
    ('0066', '0010', 'A1003', 3, 12.00, 'Rented'),
    ('0067', '0010', 'A1004', 4, 17.00, 'Available'),
    ('0068', '0010', 'A1005', 5, 10.00, 'Rented'),
    ('0069', '0010', 'A1006', 1, 14.00, 'Rented'),
    ('0070', '0010', 'A1007', 2, 20.00, 'Available'),
    ('0071', '0011', 'A1101', 1, 16.00, 'Rented'),
    ('0072', '0011', 'A1102', 2, 13.00, 'Rented'),
    ('0073', '0011', 'A1103', 3, 15.00, 'Rented'),
    ('0074', '0011', 'A1104', 4, 19.00, 'Rented'),
    ('0075', '0011', 'A1105', 5, 11.00, 'Rented'),
    ('0076', '0011', 'A1106', 1, 13.00, 'Available'),
    ('0077', '0011', 'A1107', 2, 19.00, 'Rented'),
    ('0078', '0011', 'A1108', 3, 15.00, 'Available'),
    ('0079', '0012', 'A1201', 1, 18.00, 'Rented'),
    ('0080', '0012', 'A1202', 2, 10.00, 'Rented'),
        ('0081', '0012', 'A1203', 3, 14.00, 'Available'),
    ('0082', '0012', 'A1204', 4, 16.00, 'Rented'),
    ('0083', '0012', 'A1205', 5, 11.00, 'Available'),
    ('0084', '0012', 'A1206', 1, 17.00, 'Rented'),
    ('0085', '0012', 'A1207', 2, 12.00, 'Rented'),
    ('0086', '0012', 'A1208', 3, 19.00, 'Available'),
    ('0087', '0013', 'A1301', 1, 10.00, 'Available'),
    ('0088', '0013', 'A1302', 2, 15.00, 'Available'),
    ('0089', '0013', 'A1303', 3, 13.00, 'Available'),
    ('0090', '0013', 'A1304', 4, 14.00, 'Available'),
    ('0091', '0013', 'A1305', 5, 17.00, 'Rented'),
    ('0092', '0013', 'A1306', 1, 10.00, 'Rented'),
    ('0093', '0013', 'A1307', 2, 16.00, 'Rented'),
    ('0094', '0013', 'A1308', 3, 20.00, 'Rented'),
    ('0095', '0014', 'A1401', 1, 13.00, 'Rented'),
    ('0096', '0014', 'A1402', 2, 19.00, 'Available'),
    ('0097', '0014', 'A1403', 3, 18.00, 'Rented'),
    ('0098', '0014', 'A1404', 4, 12.00, 'Rented'),
    ('0099', '0014', 'A1405', 5, 14.00, 'Rented'),
    ('0100', '0014', 'A1406', 1, 16.00, 'Available'),
    ('0101', '0014', 'A1407', 2, 11.00, 'Available'),
    ('0102', '0014', 'A1408', 3, 17.00, 'Rented'),
    ('0103', '0015', 'A1501', 1, 15.00, 'Rented'),
    ('0104', '0015', 'A1502', 2, 19.00, 'Rented'),
    ('0105', '0015', 'A1503', 3, 13.00, 'Rented'),
    ('0106', '0015', 'A1504', 4, 10.00, 'Rented'),
    ('0107', '0015', 'A1505', 5, 18.00, 'Rented'),
    ('0108', '0015', 'A1506', 1, 12.00, 'Rented'),
    ('0109', '0015', 'A1507', 2, 14.00, 'Rented'),
    ('0110', '0015', 'A1508', 3, 11.00, 'Available'),
    ('0111', '0016', 'A1601', 1, 20.00, 'Rented'),
    ('0112', '0016', 'A1602', 2, 16.00, 'Rented'),
    ('0113', '0016', 'A1603', 3, 15.00, 'Available'),
    ('0114', '0016', 'A1604', 4, 17.00, 'Rented'),
    ('0115', '0016', 'A1605', 5, 19.00, 'Available'),
    ('0116', '0016', 'A1606', 1, 12.00, 'Rented'),
    ('0117', '0016', 'A1607', 2, 13.00, 'Rented'),
    ('0118', '0016', 'A1608', 3, 11.00, 'Available'),
    ('0119', '0017', 'A1701', 1, 18.00, 'Rented'),
    ('0120', '0017', 'A1702', 2, 14.00, 'Rented'),
    ('0121', '0017', 'A1703', 3, 10.00, 'Available'),
    ('0122', '0017', 'A1704', 4, 20.00, 'Rented'),
    ('0123', '0017', 'A1705', 5, 17.00, 'Rented'),
    ('0124', '0017', 'A1706', 1, 15.00, 'Rented'),
    ('0125', '0017', 'A1707', 2, 13.00, 'Rented'),
    ('0126', '0017', 'A1708', 3, 16.00, 'Rented'),
    ('0127', '0018', 'A1801', 1, 19.00, 'Rented'),
    ('0128', '0018', 'A1802', 2, 11.00, 'Rented'),
    ('0129', '0018', 'A1803', 3, 18.00, 'Available'),
    ('0130', '0018', 'A1804', 4, 12.00, 'Available'),
    ('0131', '0018', 'A1805', 5, 17.00, 'Rented'),
    ('0132', '0018', 'A1806', 1, 10.00, 'Rented'),
    ('0133', '0018', 'A1807', 2, 14.00, 'Available'),
    ('0134', '0018', 'A1808', 3, 20.00, 'Rented'),
    ('0135', '0019', 'A1901', 1, 13.00, 'Rented'),
    ('0136', '0019', 'A1902', 2, 19.00, 'Rented'),
    ('0137', '0019', 'A1903', 3, 11.00, 'Available'),
    ('0138', '0019', 'A1904', 4, 16.00, 'Available'),
    ('0139', '0019', 'A1905', 5, 15.00, 'Rented'),
    ('0140', '0019', 'A1906', 1, 18.00, 'Available'),
    ('0141', '0019', 'A1907', 2, 12.00, 'Rented'),
    ('0142', '0019', 'A1908', 3, 17.00, 'Rented'),
    ('0143', '0020', 'A2001', 1, 10.00, 'Available'),
    ('0144', '0020', 'A2002', 2, 14.00, 'Rented'),
    ('0145', '0020', 'A2003', 3, 20.00, 'Rented'),
    ('0146', '0020', 'A2004', 4, 16.00, 'Rented'),
    ('0147', '0020', 'A2005', 5, 13.00, 'Rented'),
    ('0148', '0020', 'A2006', 1, 15.00, 'Rented'),
    ('0149', '0020', 'A2007', 2, 19.00, 'Rented'),
    ('0150', '0020', 'A2008', 3, 11.00, 'Rented');
GO

-- Insert Data into Lease
INSERT INTO Lease (Lease_ID, Unit_ID, Tenant_ID, Start_Date, End_Date, Monthly_Rent, Deposit) VALUES
    ('0001', '0001', '0001', CONVERT(DATE, '2023-01-01', 103), CONVERT(DATE, '2023-10-01', 103), 13.00, 14.00),
    ('0002', '0002', '0002', CONVERT(DATE, '2023-02-01', 103), CONVERT(DATE, '2023-10-01', 103), 19.00, 20.00),
    ('0003', '0003', '0003', CONVERT(DATE, '2023-03-01', 103), CONVERT(DATE, '2024-01-01', 103), 15.00, 16.00),
    ('0004', '0004', '0004', CONVERT(DATE, '2023-04-01', 103), CONVERT(DATE, '2023-12-01', 103), 18.00, 19.00),
    ('0005', '0005', '0005', CONVERT(DATE, '2023-05-01', 103), CONVERT(DATE, '2024-02-01', 103), 10.00, 11.00),
    ('0006', '0006', '0006', CONVERT(DATE, '2023-06-01', 103), CONVERT(DATE, '2024-05-01', 103), 14.00, 15.00),
    ('0007', '0007', '0007', CONVERT(DATE, '2023-07-01', 103), CONVERT(DATE, '2024-03-01', 103), 16.00, 17.00),
    ('0008', '0008', '0008', CONVERT(DATE, '2023-08-01', 103), CONVERT(DATE, '2024-07-01', 103), 11.00, 12.00),
    ('0009', '0009', '0009', CONVERT(DATE, '2023-09-01', 103), CONVERT(DATE, '2024-08-01', 103), 17.00, 18.00),
    ('0010', '0010', '0010', CONVERT(DATE, '2023-10-01', 103), CONVERT(DATE, '2024-05-01', 103), 12.00, 13.00),
    ('0011', '0011', '0011', CONVERT(DATE, '2023-11-01', 103), CONVERT(DATE, '2024-10-01', 103), 19.00, 20.00),
    ('0012', '0012', '0012', CONVERT(DATE, '2023-12-01', 103), CONVERT(DATE, '2024-06-01', 103), 10.00, 11.00),
    ('0013', '0013', '0013', CONVERT(DATE, '2023-01-01', 103), CONVERT(DATE, '2023-11-01', 103), 15.00, 16.00),
    ('0014', '0014', '0014', CONVERT(DATE, '2023-02-01', 103), CONVERT(DATE, '2023-09-01', 103), 13.00, 14.00),
    ('0015', '0015', '0015', CONVERT(DATE, '2023-03-01', 103), CONVERT(DATE, '2023-12-01', 103), 14.00, 15.00),
    ('0016', '0016', '0016', CONVERT(DATE, '2023-04-01', 103), CONVERT(DATE, '2023-10-01', 103), 17.00, 18.00),
    ('0017', '0017', '0017', CONVERT(DATE, '2023-05-01', 103), CONVERT(DATE, '2023-11-01', 103), 10.00, 11.00),
    ('0018', '0018', '0018', CONVERT(DATE, '2023-06-01', 103), CONVERT(DATE, '2024-04-01', 103), 16.00, 17.00),
    ('0019', '0019', '0019', CONVERT(DATE, '2023-07-01', 103), CONVERT(DATE, '2024-03-01', 103), 20.00, 20.00),
    ('0020', '0020', '0020', CONVERT(DATE, '2023-08-01', 103), CONVERT(DATE, '2024-06-01', 103), 13.00, 14.00),
    ('0021', '0021', '0021', CONVERT(DATE, '2023-09-01', 103), CONVERT(DATE, '2024-07-01', 103), 19.00, 20.00),
    ('0022', '0022', '0022', CONVERT(DATE, '2023-10-01', 103), CONVERT(DATE, '2024-03-01', 103), 18.00, 19.00),
    ('0023', '0023', '0023', CONVERT(DATE, '2023-11-01', 103), CONVERT(DATE, '2024-05-01', 103), 12.00, 13.00),
    ('0024', '0024', '0024', CONVERT(DATE, '2023-12-01', 103), CONVERT(DATE, '2024-06-01', 103), 14.00, 15.00),
    ('0025', '0025', '0025', CONVERT(DATE, '2023-01-01', 103), CONVERT(DATE, '2023-07-01', 103), 16.00, 17.00),
    ('0026', '0026', '0026', CONVERT(DATE, '2023-02-01', 103), CONVERT(DATE, '2023-11-01', 103), 11.00, 12.00),
    ('0027', '0027', '0027', CONVERT(DATE, '2023-03-01', 103), CONVERT(DATE, '2023-12-01', 103), 17.00, 18.00),
    ('0028', '0028', '0028', CONVERT(DATE, '2023-04-01', 103), CONVERT(DATE, '2024-03-01', 103), 15.00, 16.00),
    ('0029', '0029', '0029', CONVERT(DATE, '2023-05-01', 103), CONVERT(DATE, '2023-12-01', 103), 19.00, 20.00),
    ('0030', '0030', '0030', CONVERT(DATE, '2023-06-01', 103), CONVERT(DATE, '2023-12-01', 103), 13.00, 14.00),
    ('0031', '0031', '0031', CONVERT(DATE, '2023-07-01', 103), CONVERT(DATE, '2024-03-01', 103), 10.00, 11.00),
    ('0032', '0032', '0032', CONVERT(DATE, '2023-08-01', 103), CONVERT(DATE, '2024-03-01', 103), 18.00, 19.00),
    ('0033', '0033', '0033', CONVERT(DATE, '2023-09-01', 103), CONVERT(DATE, '2024-06-01', 103), 12.00, 13.00),
    ('0034', '0034', '0034', CONVERT(DATE, '2023-10-01', 103), CONVERT(DATE, '2024-05-01', 103), 14.00, 15.00),
    ('0035', '0035', '0035', CONVERT(DATE, '2023-11-01', 103), CONVERT(DATE, '2024-05-01', 103), 11.00, 12.00),
    ('0036', '0036', '0036', CONVERT(DATE, '2023-12-01', 103), CONVERT(DATE, '2024-10-01', 103), 20.00, 20.00),
    ('0037', '0037', '0037', CONVERT(DATE, '2023-01-01', 103), CONVERT(DATE, '2023-12-01', 103), 16.00, 17.00),
    ('0038', '0038', '0038', CONVERT(DATE, '2023-02-01', 103), CONVERT(DATE, '2023-12-01', 103), 15.00, 16.00),
    ('0039', '0039', '0039', CONVERT(DATE, '2023-03-01', 103), CONVERT(DATE, '2023-09-01', 103), 17.00, 18.00),
    ('0040', '0040', '0040', CONVERT(DATE, '2023-04-01', 103), CONVERT(DATE, '2023-10-01', 103), 19.00, 20.00),
    ('0041', '0041', '0041', CONVERT(DATE, '2023-05-01', 103), CONVERT(DATE, '2023-10-01', 103), 12.00, 13.00),
    ('0042', '0042', '0042', CONVERT(DATE, '2023-06-01', 103), CONVERT(DATE, '2024-05-01', 103), 13.00, 14.00),
    ('0043', '0043', '0043', CONVERT(DATE, '2023-07-01', 103), CONVERT(DATE, '2024-04-01', 103), 11.00, 12.00),
    ('0044', '0044', '0044', CONVERT(DATE, '2023-08-01', 103), CONVERT(DATE, '2024-03-01', 103), 18.00, 19.00),
    ('0045', '0045', '0045', CONVERT(DATE, '2023-09-01', 103), CONVERT(DATE, '2024-07-01', 103), 14.00, 15.00),
    ('0046', '0046', '0046', CONVERT(DATE, '2023-10-01', 103), CONVERT(DATE, '2024-04-01', 103), 10.00, 11.00),
    ('0047', '0047', '0047', CONVERT(DATE, '2023-11-01', 103), CONVERT(DATE, '2024-05-01', 103), 20.00, 20.00),
    ('0048', '0048', '0048', CONVERT(DATE, '2023-12-01', 103), CONVERT(DATE, '2024-09-01', 103), 17.00, 18.00),
    ('0049', '0049', '0049', CONVERT(DATE, '2023-01-01', 103), CONVERT(DATE, '2023-11-01', 103), 15.00, 16.00),
    ('0050', '0050', '0050', CONVERT(DATE, '2023-02-01', 103), CONVERT(DATE, '2023-10-01', 103), 13.00, 14.00),
    ('0051', '0051', '0051', CONVERT(DATE, '2023-03-01', 103), CONVERT(DATE, '2023-12-01', 103), 16.00, 17.00),
    ('0052', '0052', '0052', CONVERT(DATE, '2023-04-01', 103), CONVERT(DATE, '2024-01-01', 103), 19.00, 20.00),
    ('0053', '0053', '0053', CONVERT(DATE, '2023-05-01', 103), CONVERT(DATE, '2024-03-01', 103), 11.00, 12.00),
    ('0054', '0054', '0054', CONVERT(DATE, '2023-06-01', 103), CONVERT(DATE, '2024-05-01', 103), 18.00, 19.00),
    ('0055', '0055', '0055', CONVERT(DATE, '2023-07-01', 103), CONVERT(DATE, '2024-01-01', 103), 12.00, 13.00),
    ('0056', '0056', '0056', CONVERT(DATE, '2023-08-01', 103), CONVERT(DATE, '2024-02-01', 103), 17.00, 18.00),
    ('0057', '0057', '0057', CONVERT(DATE, '2023-09-01', 103), CONVERT(DATE, '2024-03-01', 103), 10.00, 11.00),
    ('0058', '0058', '0058', CONVERT(DATE, '2023-10-01', 103), CONVERT(DATE, '2024-07-01', 103), 14.00, 15.00),
    ('0059', '0059', '0059', CONVERT(DATE, '2023-11-01', 103), CONVERT(DATE, '2024-09-01', 103), 20.00, 20.00),
    ('0060', '0060', '0060', CONVERT(DATE, '2023-12-01', 103), CONVERT(DATE, '2024-07-01', 103), 13.00, 14.00),
    ('0061', '0061', '0061', CONVERT(DATE, '2023-01-01', 103), CONVERT(DATE, '2023-10-01', 103), 19.00, 20.00),
    ('0062', '0062', '0062', CONVERT(DATE, '2023-02-01', 103), CONVERT(DATE, '2024-02-01', 103), 11.00, 12.00),
    ('0063', '0063', '0063', CONVERT(DATE, '2023-03-01', 103), CONVERT(DATE, '2024-01-01', 103), 16.00, 17.00),
    ('0064', '0064', '0064', CONVERT(DATE, '2023-04-01', 103), CONVERT(DATE, '2023-10-01', 103), 15.00, 16.00),
    ('0065', '0065', '0065', CONVERT(DATE, '2023-05-01', 103), CONVERT(DATE, '2023-12-01', 103), 18.00, 19.00),
    ('0066', '0066', '0066', CONVERT(DATE, '2023-06-01', 103), CONVERT(DATE, '2023-12-01', 103), 12.00, 13.00),
    ('0067', '0067', '0067', CONVERT(DATE, '2023-07-01', 103), CONVERT(DATE, '2024-01-01', 103), 17.00, 18.00),
    ('0068', '0068', '0068', CONVERT(DATE, '2023-08-01', 103), CONVERT(DATE, '2024-06-01', 103), 10.00, 11.00),
    ('0069', '0069', '0069', CONVERT(DATE, '2023-09-01', 103), CONVERT(DATE, '2024-04-01', 103), 14.00, 15.00),
    ('0070', '0070', '0070', CONVERT(DATE, '2023-10-01', 103), CONVERT(DATE, '2024-09-01', 103), 20.00, 20.00),
    ('0071', '0071', '0071', CONVERT(DATE, '2023-11-01', 103), CONVERT(DATE, '2024-06-01', 103), 16.00, 17.00),
    ('0072', '0072', '0072', CONVERT(DATE, '2023-12-01', 103), CONVERT(DATE, '2024-10-01', 103), 13.00, 14.00),
    ('0073', '0073', '0073', CONVERT(DATE, '2023-01-01', 103), CONVERT(DATE, '2023-07-01', 103), 15.00, 16.00),
    ('0074', '0074', '0074', CONVERT(DATE, '2023-02-01', 103), CONVERT(DATE, '2023-11-01', 103), 19.00, 20.00),
    ('0075', '0075', '0075', CONVERT(DATE, '2023-03-01', 103), CONVERT(DATE, '2023-12-01', 103), 11.00, 12.00);
GO

-- Insert Data into Payment
INSERT INTO Payment (Payment_ID, Lease_ID, Date, Amount, Payment_Type)
VALUES
    ('0001', '0001', CONVERT(DATE, '2023-02-10', 105), 0, 'direct debit'),
    ('0002', '0001', CONVERT(DATE, '2023-05-15', 105), 0, 'mobile payment'),
    ('0003', '0002', CONVERT(DATE, '2023-03-10', 105), 0, 'direct debit'),
    ('0004', '0003', CONVERT(DATE, '2023-04-10', 105), 0, 'mobile payment'),
    ('0005', '0003', CONVERT(DATE, '2023-05-15', 105), 0, 'mobile payment'),
    ('0006', '0003', CONVERT(DATE, '2023-07-13', 105), 0, 'direct debit'),
    ('0007', '0004', CONVERT(DATE, '2023-05-10', 105), 0, 'mobile payment'),
    ('0008', '0004', CONVERT(DATE, '2023-06-12', 105), 0, 'mobile payment'),
    ('0009', '0004', CONVERT(DATE, '2023-08-12', 105), 0, 'electronic payment'),
    ('0010', '0004', CONVERT(DATE, '2023-09-15', 105), 0, 'direct debit'),
    ('0011', '0005', CONVERT(DATE, '2023-06-10', 105), 0, 'mobile payment'),
    ('0012', '0005', CONVERT(DATE, '2023-12-12', 105), 0, 'direct payment'),
    ('0013', '0006', CONVERT(DATE, '2023-07-12', 105), 0, 'electronic payment'),
    ('0014', '0006', CONVERT(DATE, '2023-09-15', 105), 0, 'mobile payment'),
    ('0015', '0007', CONVERT(DATE, '2023-07-10', 105), 0, 'mobile payment'),
    ('0016', '0007', CONVERT(DATE, '2023-12-15', 105), 0, 'direct payment'),
    ('0017', '0008', CONVERT(DATE, '2023-08-10', 105), 0, 'electronic payment'),
    ('0018', '0008', CONVERT(DATE, '2023-10-15', 105), 0, 'electronic payment'),
    ('0019', '0008', CONVERT(DATE, '2024-01-10', 105), 0, 'electronic payment'),
    ('0020', '0008', CONVERT(DATE, '2024-02-10', 105), 0, 'mobile payment'),
    ('0021', '0009', CONVERT(DATE, '2023-09-10', 105), 0, 'direct payment'),
    ('0022', '0009', CONVERT(DATE, '2023-10-12', 105), 0, 'electronic payment'),
    ('0023', '0009', CONVERT(DATE, '2023-11-12', 105), 0, 'direct debit'),
    ('0024', '0009', CONVERT(DATE, '2023-12-14', 105), 0, 'electronic payment'),
    ('0025', '0009', CONVERT(DATE, '2024-01-15', 105), 0, 'electronic payment'),
    ('0026', '0010', CONVERT(DATE, '2023-01-10', 105), 0, 'direct debit'),
    ('0027', '0010', CONVERT(DATE, '2023-02-10', 105), 0, 'electronic payment'),
    ('0028', '0010', CONVERT(DATE, '2023-03-12', 105), 0, 'direct payment'),
    ('0029', '0010', CONVERT(DATE, '2023-11-13', 105), 0, 'electronic payment'),
    ('0030', '0010', CONVERT(DATE, '2023-12-15', 105), 0, 'direct payment'),
    ('0031', '0011', CONVERT(DATE, '2024-06-12', 105), 0, 'direct payment'),
    ('0032', '0011', CONVERT(DATE, '2024-08-15', 105), 0, 'direct payment'),
    ('0033', '0011', CONVERT(DATE, '2024-09-10', 105), 0, 'direct payment'),
    ('0034', '0012', CONVERT(DATE, '2023-12-12', 105), 0, 'mobile payment'),
    ('0035', '0012', CONVERT(DATE, '2024-03-12', 105), 0, 'electronic payment'),
    ('0036', '0013', CONVERT(DATE, '2023-07-15', 105), 0, 'direct debit'),
    ('0037', '0013', CONVERT(DATE, '2023-09-10', 105), 0, 'direct payment'),
    ('0038', '0014', CONVERT(DATE, '2023-03-15', 105), 0, 'electronic payment'),
    ('0039', '0014', CONVERT(DATE, '2023-07-10', 105), 0, 'direct payment'),
    ('0040', '0014', CONVERT(DATE, '2023-08-15', 105), 0, 'electronic payment'),
    ('0041', '0015', CONVERT(DATE, '2023-04-10', 105), 0, 'electronic payment'),
    ('0042', '0015', CONVERT(DATE, '2023-05-10', 105), 0, 'mobile payment'),
    ('0043', '0016', CONVERT(DATE, '2023-05-10', 105), 0, 'mobile payment'),
    ('0044', '0016', CONVERT(DATE, '2023-06-12', 105), 0, 'direct debit'),
    ('0045', '0016', CONVERT(DATE, '2023-07-12', 105), 0, 'electronic payment'),
    ('0046', '0017', CONVERT(DATE, '2023-05-14', 105), 0, 'direct debit'),
    ('0047', '0017', CONVERT(DATE, '2023-07-10', 105), 0, 'direct payment'),
    ('0048', '0017', CONVERT(DATE, '2023-09-15', 105), 0, 'direct debit'),
    ('0049', '0018', CONVERT(DATE, '2023-07-13', 105), 0, 'direct debit'),
    ('0050', '0019', CONVERT(DATE, '2023-07-10', 105), 0, 'direct debit'),
    ('0051', '0019', CONVERT(DATE, '2023-08-12', 105), 0, 'mobile payment'),
    ('0052', '0019', CONVERT(DATE, '2023-09-12', 105), 0, 'electronic payment'),
    ('0053', '0019', CONVERT(DATE, '2023-10-15', 105), 0, 'electronic payment'),
    ('0054', '0019', CONVERT(DATE, '2023-11-10', 105), 0, 'mobile payment'),
    ('0055', '0020', CONVERT(DATE, '2023-09-12', 105), 0, 'electronic payment'),
    ('0056', '0020', CONVERT(DATE, '2023-10-12', 105), 0, 'direct debit'),
    ('0057', '0020', CONVERT(DATE, '2023-12-12', 105), 0, 'direct payment'),
    ('0058', '0021', CONVERT(DATE, '2023-09-10', 105), 0, 'direct payment'),
    ('0059', '0021', CONVERT(DATE, '2023-12-15', 105), 0, 'direct debit'),
    ('0060', '0022', CONVERT(DATE, '2023-10-10', 105), 0, 'mobile payment'),
    ('0061', '0022', CONVERT(DATE, '2023-11-15', 105), 0, 'mobile payment'),
    ('0062', '0022', CONVERT(DATE, '2024-01-10', 105), 0, 'mobile payment'),
    ('0063', '0022', CONVERT(DATE, '2024-02-10', 105), 0, 'direct payment'),
    ('0064', '0023', CONVERT(DATE, '2023-10-12', 105), 0, 'electronic payment'),
    ('0065', '0023', CONVERT(DATE, '2023-11-12', 105), 0, 'direct debit'),
    ('0066', '0023', CONVERT(DATE, '2023-12-12', 105), 0, 'direct payment'),
    ('0067', '0024', CONVERT(DATE, '2023-12-14', 105), 0, 'mobile payment'),
    ('0068', '0024', CONVERT(DATE, '2024-01-10', 105), 0, 'direct debit'),
    ('0069', '0024', CONVERT(DATE, '2024-02-15', 105), 0, 'mobile payment'),
    ('0070', '0024', CONVERT(DATE, '2024-04-13', 105), 0, 'mobile payment'),
    ('0071', '0024', CONVERT(DATE, '2024-05-10', 105), 0, 'direct debit'),
    ('0072', '0025', CONVERT(DATE, '2023-02-12', 105), 0, 'mobile payment'),
    ('0073', '0025', CONVERT(DATE, '2023-04-12', 105), 0, 'mobile payment'),
    ('0074', '0025', CONVERT(DATE, '2023-06-15', 105), 0, 'direct payment'),
    ('0075', '0026', CONVERT(DATE, '2023-06-10', 105), 0, 'mobile payment'),
    ('0076', '0026', CONVERT(DATE, '2023-10-12', 105), 0, 'direct payment'),
    ('0077', '0027', CONVERT(DATE, '2023-07-12', 105), 0, 'electronic payment'),
    ('0078', '0028', CONVERT(DATE, '2023-07-15', 105), 0, 'direct debit'),
    ('0079', '0028', CONVERT(DATE, '2023-08-10', 105), 0, 'direct payment'),
    ('0080', '0028', CONVERT(DATE, '2023-09-15', 105), 0, 'mobile payment'),
    ('0081', '0028', CONVERT(DATE, '2023-10-10', 105), 0, 'mobile payment'),
    ('0082', '0028', CONVERT(DATE, '2023-12-15', 105), 0, 'direct payment'),
    ('0083', '0029', CONVERT(DATE, '2023-06-10', 105), 0, 'mobile payment'),
    ('0084', '0029', CONVERT(DATE, '2023-07-10', 105), 0, 'direct debit'),
    ('0085', '0030', CONVERT(DATE, '2023-09-10', 105), 0, 'electronic payment'),
    ('0086', '0031', CONVERT(DATE, '2023-10-12', 105), 0, 'direct debit'),
    ('0087', '0031', CONVERT(DATE, '2023-11-12', 105), 0, 'direct debit'),
    ('0088', '0031', CONVERT(DATE, '2023-12-14', 105), 0, 'mobile payment'),
    ('0089', '0031', CONVERT(DATE, '2024-02-10', 105), 0, 'mobile payment'),
    ('0090', '0032', CONVERT(DATE, '2024-01-15', 105), 0, 'electronic payment'),
    ('0091', '0033', CONVERT(DATE, '2023-09-13', 105), 0, 'direct debit'),
    ('0092', '0033', CONVERT(DATE, '2023-10-10', 105), 0, 'direct payment'),
    ('0093', '0034', CONVERT(DATE, '2023-11-12', 105), 0, 'electronic payment'),
    ('0094', '0034', CONVERT(DATE, '2023-12-12', 105), 0, 'electronic payment'),
    ('0095', '0034', CONVERT(DATE, '2024-01-15', 105), 0, 'direct debit'),
    ('0096', '0034', CONVERT(DATE, '2024-02-10', 105), 0, 'electronic payment'),
    ('0097', '0035', CONVERT(DATE, '2023-12-12', 105), 0, 'direct payment'),
    ('0098', '0035', CONVERT(DATE, '2024-02-12', 105), 0, 'electronic payment'),
    ('0099', '0036', CONVERT(DATE, '2024-07-15', 105), 0, 'direct debit'),
    ('0100', '0036', CONVERT(DATE, '2024-09-10', 105), 0, 'direct debit'),
    ('0101', '0037', CONVERT(DATE, '2023-08-10', 105), 0, 'direct payment'),
    ('0102', '0037', CONVERT(DATE, '2023-10-15', 105), 0, 'electronic payment'),
    ('0103', '0037', CONVERT(DATE, '2023-11-15', 105), 0, 'direct payment'),
    ('0104', '0038', CONVERT(DATE, '2023-02-10', 105), 0, 'electronic payment'),
    ('0105', '0038', CONVERT(DATE, '2023-03-10', 105), 0, 'direct payment'),
    ('0106', '0038', CONVERT(DATE, '2023-09-10', 105), 0, 'electronic payment'),
    ('0107', '0039', CONVERT(DATE, '2023-05-12', 105), 0, 'mobile payment'),
    ('0108', '0039', CONVERT(DATE, '2023-06-12', 105), 0, 'electronic payment'),
    ('0109', '0040', CONVERT(DATE, '2023-06-14', 105), 0, 'mobile payment'),
    ('0110', '0041', CONVERT(DATE, '2023-06-10', 105), 0, 'mobile payment'),
    ('0111', '0041', CONVERT(DATE, '2023-05-15', 105), 0, 'direct debit'),
    ('0112', '0042', CONVERT(DATE, '2023-07-13', 105), 0, 'electronic payment'),
    ('0113', '0042', CONVERT(DATE, '2023-08-10', 105), 0, 'direct debit'),
    ('0114', '0042', CONVERT(DATE, '2023-09-12', 105), 0, 'electronic payment'),
    ('0115', '0043', CONVERT(DATE, '2023-08-12', 105), 0, 'direct payment'),
    ('0116', '0043', CONVERT(DATE, '2023-09-15', 105), 0, 'direct payment'),
    ('0117', '0043', CONVERT(DATE, '2023-10-10', 105), 0, 'direct payment'),
    ('0118', '0043', CONVERT(DATE, '2023-12-12', 105), 0, 'direct debit'),
    ('0119', '0043', CONVERT(DATE, '2023-11-12', 105), 0, 'mobile payment'),
    ('0120', '0044', CONVERT(DATE, '2023-09-15', 105), 0, 'direct debit'),
    ('0121', '0044', CONVERT(DATE, '2023-10-10', 105), 0, 'electronic payment'),
    ('0122', '0044', CONVERT(DATE, '2023-12-15', 105), 0, 'mobile payment'),
    ('0123', '0045', CONVERT(DATE, '2023-09-10', 105), 0, 'electronic payment'),
    ('0124', '0045', CONVERT(DATE, '2023-10-15', 105), 0, 'direct debit'),
    ('0125', '0045', CONVERT(DATE, '2024-01-10', 105), 0, 'mobile payment'),
    ('0126', '0045', CONVERT(DATE, '2024-02-10', 105), 0, 'direct payment'),
    ('0127', '0046', CONVERT(DATE, '2023-10-12', 105), 0, 'direct debit'),
    ('0128', '0046', CONVERT(DATE, '2023-11-12', 105), 0, 'electronic payment'),
    ('0129', '0046', CONVERT(DATE, '2023-12-12', 105), 0, 'direct payment'),
    ('0130', '0047', CONVERT(DATE, '2023-12-14', 105), 0, 'direct payment'),
    ('0131', '0047', CONVERT(DATE, '2024-03-10', 105), 0, 'direct debit'),
    ('0132', '0048', CONVERT(DATE, '2024-05-15', 105), 0, 'direct payment'),
    ('0133', '0048', CONVERT(DATE, '2024-07-13', 105), 0, 'mobile payment'),
    ('0134', '0049', CONVERT(DATE, '2023-05-10', 105), 0, 'direct debit'),
    ('0135', '0049', CONVERT(DATE, '2023-06-12', 105), 0, 'mobile payment'),
    ('0136', '0050', CONVERT(DATE, '2023-08-12', 105), 0, 'direct payment'),
    ('0137', '0050', CONVERT(DATE, '2023-09-15', 105), 0, 'electronic payment'),
    ('0138', '0051', CONVERT(DATE, '2023-06-10', 105), 0, 'direct payment'),
    ('0139', '0051', CONVERT(DATE, '2023-07-12', 105), 0, 'direct payment'),
    ('0140', '0052', CONVERT(DATE, '2023-07-12', 105), 0, 'direct debit'),
    ('0141', '0052', CONVERT(DATE, '2023-09-15', 105), 0, 'direct debit'),
    ('0142', '0053', CONVERT(DATE, '2023-07-10', 105), 0, 'direct payment'),
    ('0143', '0053', CONVERT(DATE, '2023-08-10', 105), 0, 'mobile payment'),
    ('0144', '0053', CONVERT(DATE, '2023-12-15', 105), 0, 'electronic payment'),
    ('0145', '0054', CONVERT(DATE, '2023-09-10', 105), 0, 'mobile payment'),
    ('0146', '0054', CONVERT(DATE, '2023-10-10', 105), 0, 'direct payment'),
    ('0147', '0054', CONVERT(DATE, '2024-01-10', 105), 0, 'direct payment'),
    ('0148', '0054', CONVERT(DATE, '2024-02-10', 105), 0, 'electronic payment'),
    ('0149', '0055', CONVERT(DATE, '2023-10-12', 105), 0, 'direct debit'),
    ('0150', '0056', CONVERT(DATE, '2023-09-10', 105), 0, 'mobile payment'),
    ('0151', '0056', CONVERT(DATE, '2023-10-11', 105), 0, 'direct debit'),
    ('0152', '0056', CONVERT(DATE, '2023-11-12', 105), 0, 'direct debit'),
    ('0153', '0056', CONVERT(DATE, '2023-12-14', 105), 0, 'direct debit'),
    ('0154', '0056', CONVERT(DATE, '2024-01-13', 105), 0, 'direct debit'),
    ('0155', '0057', CONVERT(DATE, '2023-09-10', 105), 0, 'mobile payment'),
    ('0156', '0058', CONVERT(DATE, '2023-10-12', 105), 0, 'electronic payment'),
    ('0157', '0058', CONVERT(DATE, '2023-11-12', 105), 0, 'direct debit'),
    ('0158', '0058', CONVERT(DATE, '2023-12-15', 105), 0, 'mobile payment'),
    ('0159', '0059', CONVERT(DATE, '2023-12-10', 105), 0, 'direct debit'),
    ('0160', '0059', CONVERT(DATE, '2024-06-12', 105), 0, 'direct payment'),
    ('0161', '0060', CONVERT(DATE, '2024-01-12', 105), 0, 'direct debit'),
    ('0162', '0060', CONVERT(DATE, '2024-02-15', 105), 0, 'direct debit'),
    ('0163', '0060', CONVERT(DATE, '2024-05-10', 105), 0, 'direct debit'),
    ('0164', '0060', CONVERT(DATE, '2024-06-15', 105), 0, 'electronic payment'),
    ('0165', '0061', CONVERT(DATE, '2023-03-10', 105), 0, 'direct debit'),
    ('0166', '0061', CONVERT(DATE, '2023-05-10', 105), 0, 'mobile payment'),
    ('0167', '0061', CONVERT(DATE, '2023-08-15', 105), 0, 'mobile payment'),
    ('0168', '0062', CONVERT(DATE, '2023-09-10', 105), 0, 'mobile payment'),
    ('0169', '0062', CONVERT(DATE, '2023-10-10', 105), 0, 'direct debit'),
    ('0170', '0062', CONVERT(DATE, '2024-01-12', 105), 0, 'electronic payment'),
    ('0171', '0063', CONVERT(DATE, '2023-11-12', 105), 0, 'direct payment'),
    ('0172', '0063', CONVERT(DATE, '2023-12-14', 105), 0, 'electronic payment'),
    ('0173', '0064', CONVERT(DATE, '2023-04-10', 105), 0, 'electronic payment'),
    ('0174', '0064', CONVERT(DATE, '2023-05-15', 105), 0, 'mobile payment'),
    ('0175', '0065', CONVERT(DATE, '2023-05-13', 105), 0, 'direct payment'),
    ('0176', '0065', CONVERT(DATE, '2023-07-10', 105), 0, 'electronic payment'),
    ('0177', '0066', CONVERT(DATE, '2023-06-12', 105), 0, 'mobile payment'),
    ('0178', '0066', CONVERT(DATE, '2023-08-12', 105), 0, 'mobile payment'),
    ('0179', '0067', CONVERT(DATE, '2023-09-15', 105), 0, 'direct debit'),
    ('0180', '0068', CONVERT(DATE, '2023-08-10', 105), 0, 'electronic payment'),
    ('0181', '0068', CONVERT(DATE, '2023-09-12', 105), 0, 'direct debit'),
    ('0182', '0068', CONVERT(DATE, '2023-10-12', 105), 0, 'direct payment'),
    ('0183', '0068', CONVERT(DATE, '2023-12-12', 105), 0, 'direct debit'),
    ('0184', '0069', CONVERT(DATE, '2023-12-10', 105), 0, 'mobile payment'),
    ('0185', '0070', CONVERT(DATE, '2023-10-15', 105), 0, 'direct debit'),
    ('0186', '0070', CONVERT(DATE, '2023-12-10', 105), 0, 'electronic payment'),
    ('0187', '0070', CONVERT(DATE, '2024-01-10', 105), 0, 'electronic payment'),
    ('0188', '0070', CONVERT(DATE, '2024-02-10', 105), 0, 'mobile payment'),
    ('0189', '0071', CONVERT(DATE, '2024-08-15', 105), 0, 'direct payment'),
    ('0190', '0072', CONVERT(DATE, '2024-09-10', 105), 0, 'direct payment'),
    ('0191', '0073', CONVERT(DATE, '2023-02-12', 105), 0, 'electronic payment'),
    ('0192', '0073', CONVERT(DATE, '2023-03-12', 105), 0, 'direct payment'),
    ('0193', '0073', CONVERT(DATE, '2023-04-14', 105), 0, 'direct debit'),
    ('0194', '0073', CONVERT(DATE, '2023-05-10', 105), 0, 'electronic payment'),
    ('0195', '0074', CONVERT(DATE, '2023-05-15', 105), 0, 'direct payment'),
    ('0196', '0075', CONVERT(DATE, '2023-07-13', 105), 0, 'direct payment'),
    ('0197', '0075', CONVERT(DATE, '2023-05-10', 105), 0, 'mobile payment'),
    ('0198', '0075', CONVERT(DATE, '2023-06-12', 105), 0, 'direct payment'),
    ('0199', '0075', CONVERT(DATE, '2023-08-12', 105), 0, 'direct payment'),
    ('0200', '0075', CONVERT(DATE, '2023-09-15', 105), 0, 'direct payment');
GO

-- Insert Data into Amenity
INSERT INTO Amenity (Amenity_ID, Property_ID, Amenity_Name, Description)
VALUES
    ('0001', '0001', 'Swimming Pool', NULL),
    ('0002', '0002', 'Fitness Center', NULL),
    ('0003', '0003', 'Playground', 'In door'),
    ('0004', '0004', 'Community Room', NULL),
    ('0005', '0005', 'Convenience Store', NULL),
    ('0006', '0006', 'Restaurant', NULL),
    ('0007', '0007', 'Pharmacy', NULL),
    ('0008', '0008', 'Café', NULL),
    ('0009', '0009', 'Security System', '24/7'),
    ('0010', '0010', 'Park', NULL),
    ('0011', '0011', 'Parking Garage', NULL),
    ('0012', '0012', 'Laundry Services', NULL),
    ('0013', '0013', 'Spa', NULL),
    ('0014', '0014', 'Sports Courts', 'Tennis, Basketball, etc.');
GO

-- Insert Data into Booking
INSERT INTO Booking (Tenant_ID, Amenity_ID, Start_Date, End_Date, Cost)
VALUES
    ('0001', '0001', CONVERT(DATE, '2023-04-01', 103), CONVERT(DATE, '2023-05-01', 103), '12.00'),
    ('0003', '0014', CONVERT(DATE, '2023-05-01', 103), CONVERT(DATE, '2023-06-01', 103), '10.00'),
    ('0003', '0004', CONVERT(DATE, '2023-07-01', 103), CONVERT(DATE, '2023-08-01', 103), '7.00'),
    ('0006', '0004', CONVERT(DATE, '2023-05-01', 103), CONVERT(DATE, '2023-06-01', 103), '7.00'),
    ('0008', '0010', CONVERT(DATE, '2023-06-01', 103), CONVERT(DATE, '2023-07-01', 103), '13.00'),
    ('0008', '0001', CONVERT(DATE, '2023-08-01', 103), CONVERT(DATE, '2023-09-01', 103), '12.00'),
    ('0013', '0006', CONVERT(DATE, '2023-09-01', 103), CONVERT(DATE, '2023-10-01', 103), '15.00'),
    ('0018', '0012', CONVERT(DATE, '2023-06-01', 103), CONVERT(DATE, '2023-07-01', 103), '5.00'),
    ('0018', '0005', CONVERT(DATE, '2023-12-01', 103), CONVERT(DATE, '2024-01-01', 103), '6.00'),
    ('0022', '0013', CONVERT(DATE, '2023-07-01', 103), CONVERT(DATE, '2023-08-01', 103), '18.00'),
    ('0022', '0001', CONVERT(DATE, '2023-09-01', 103), CONVERT(DATE, '2023-10-01', 103), '12.00'),
    ('0023', '0010', CONVERT(DATE, '2023-07-01', 103), CONVERT(DATE, '2023-08-01', 103), '13.00'),
    ('0025', '0001', CONVERT(DATE, '2023-12-01', 103), CONVERT(DATE, '2024-01-01', 103), '12.00'),
    ('0028', '0008', CONVERT(DATE, '2023-08-01', 103), CONVERT(DATE, '2023-09-01', 103), '14.00'),
    ('0029', '0007', CONVERT(DATE, '2023-10-01', 103), CONVERT(DATE, '2023-11-01', 103), '16.00'),
    ('0029', '0012', CONVERT(DATE, '2024-01-01', 103), CONVERT(DATE, '2024-02-01', 103), '5.00'),
    ('0030', '0010', CONVERT(DATE, '2024-02-01', 103), CONVERT(DATE, '2024-03-01', 103), '13.00'),
    ('0035', '0006', CONVERT(DATE, '2023-09-01', 103), CONVERT(DATE, '2023-10-01', 103), '15.00'),
    ('0037', '0004', CONVERT(DATE, '2023-10-01', 103), CONVERT(DATE, '2023-11-01', 103), '7.00'),
    ('0038', '0006', CONVERT(DATE, '2023-11-01', 103), CONVERT(DATE, '2023-12-01', 103), '15.00'),
    ('0039', '0011', CONVERT(DATE, '2023-12-01', 103), CONVERT(DATE, '2024-01-01', 103), '11.00'),
    ('0040', '0002', CONVERT(DATE, '2024-01-01', 103), CONVERT(DATE, '2024-02-01', 103), '20.00'),
    ('0042', '0006', CONVERT(DATE, '2023-04-01', 103), CONVERT(DATE, '2023-05-01', 103), '15.00'),
    ('0042', '0007', CONVERT(DATE, '2023-05-01', 103), CONVERT(DATE, '2023-06-01', 103), '16.00'),
    ('0044', '0007', CONVERT(DATE, '2023-07-01', 103), CONVERT(DATE, '2023-08-01', 103), '16.00'),
    ('0044', '0011', CONVERT(DATE, '2023-05-01', 103), CONVERT(DATE, '2023-06-01', 103), '11.00'),
    ('0044', '0004', CONVERT(DATE, '2023-06-01', 103), CONVERT(DATE, '2023-07-01', 103), '7.00'),
    ('0046', '0013', CONVERT(DATE, '2023-08-01', 103), CONVERT(DATE, '2023-09-01', 103), '18.00'),
    ('0047', '0008', CONVERT(DATE, '2023-09-01', 103), CONVERT(DATE, '2023-10-01', 103), '14.00'),
    ('0048', '0007', CONVERT(DATE, '2023-06-01', 103), CONVERT(DATE, '2023-07-01', 103), '16.00'),
    ('0048', '0002', CONVERT(DATE, '2023-12-01', 103), CONVERT(DATE, '2024-01-01', 103), '20.00'),
    ('0057', '0004', CONVERT(DATE, '2023-07-01', 103), CONVERT(DATE, '2023-08-01', 103), '7.00'),
    ('0059', '0008', CONVERT(DATE, '2023-09-01', 103), CONVERT(DATE, '2023-10-01', 103), '14.00'),
    ('0065', '0014', CONVERT(DATE, '2023-07-01', 103), CONVERT(DATE, '2023-08-01', 103), '10.00'),
    ('0067', '0013', CONVERT(DATE, '2023-12-01', 103), CONVERT(DATE, '2024-01-01', 103), '18.00'),
    ('0068', '0012', CONVERT(DATE, '2023-08-01', 103), CONVERT(DATE, '2023-09-01', 103), '5.00'),
    ('0070', '0008', CONVERT(DATE, '2023-10-01', 103), CONVERT(DATE, '2023-11-01', 103), '14.00'),
    ('0070', '0011', CONVERT(DATE, '2024-01-01', 103), CONVERT(DATE, '2024-02-01', 103), '11.00'),
    ('0070', '0012', CONVERT(DATE, '2024-02-01', 103), CONVERT(DATE, '2024-03-01', 103), '5.00'),
    ('0071', '0011', CONVERT(DATE, '2023-09-01', 103), CONVERT(DATE, '2023-10-01', 103), '11.00'),
    ('0071', '0006', CONVERT(DATE, '2023-10-01', 103), CONVERT(DATE, '2023-11-01', 103), '15.00'),
    ('0071', '0012', CONVERT(DATE, '2023-11-01', 103), CONVERT(DATE, '2023-12-01', 103), '5.00'),
    ('0080', '0002', CONVERT(DATE, '2023-12-01', 103), CONVERT(DATE, '2024-01-01', 103), '20.00'),
        ('0082', '0013', CONVERT(DATE, '2024-01-01', 103), CONVERT(DATE, '2024-02-01', 103), '18.00'),
    ('0083', '0011', CONVERT(DATE, '2023-04-01', 103), CONVERT(DATE, '2023-05-01', 103), '11.00'),
    ('0092', '0010', CONVERT(DATE, '2023-05-01', 103), CONVERT(DATE, '2023-06-01', 103), '13.00'),
    ('0092', '0013', CONVERT(DATE, '2023-07-01', 103), CONVERT(DATE, '2023-08-01', 103), '18.00'),
    ('0092', '0011', CONVERT(DATE, '2023-05-01', 103), CONVERT(DATE, '2023-06-01', 103), '11.00'),
    ('0093', '0009', CONVERT(DATE, '2023-06-01', 103), CONVERT(DATE, '2023-07-01', 103), '9.00'),
    ('0094', '0003', CONVERT(DATE, '2023-08-01', 103), CONVERT(DATE, '2023-09-01', 103), '19.00'),
    ('0094', '0008', CONVERT(DATE, '2023-09-01', 103), CONVERT(DATE, '2023-10-01', 103), '14.00'),
    ('0098', '0006', CONVERT(DATE, '2023-06-01', 103), CONVERT(DATE, '2023-07-01', 103), '15.00'),
    ('0101', '0003', CONVERT(DATE, '2023-12-01', 103), CONVERT(DATE, '2024-01-01', 103), '19.00'),
    ('0103', '0014', CONVERT(DATE, '2023-07-01', 103), CONVERT(DATE, '2023-08-01', 103), '10.00'),
    ('0103', '0011', CONVERT(DATE, '2023-09-01', 103), CONVERT(DATE, '2023-10-01', 103), '11.00'),
    ('0104', '0003', CONVERT(DATE, '2023-07-01', 103), CONVERT(DATE, '2023-08-01', 103), '19.00'),
    ('0106', '0010', CONVERT(DATE, '2023-12-01', 103), CONVERT(DATE, '2024-01-01', 103), '13.00'),
    ('0110', '0009', CONVERT(DATE, '2023-08-01', 103), CONVERT(DATE, '2023-09-01', 103), '9.00'),
    ('0119', '0013', CONVERT(DATE, '2023-10-01', 103), CONVERT(DATE, '2023-11-01', 103), '18.00'),
    ('0119', '0014', CONVERT(DATE, '2024-01-01', 103), CONVERT(DATE, '2024-02-01', 103), '10.00'),
    ('0121', '0008', CONVERT(DATE, '2024-02-01', 103), CONVERT(DATE, '2024-03-01', 103), '14.00'),
    ('0122', '0008', CONVERT(DATE, '2023-09-01', 103), CONVERT(DATE, '2023-10-01', 103), '14.00'),
    ('0123', '0002', CONVERT(DATE, '2023-10-01', 103), CONVERT(DATE, '2023-11-01', 103), '20.00'),
    ('0130', '0009', CONVERT(DATE, '2023-11-01', 103), CONVERT(DATE, '2023-12-01', 103), '9.00'),
    ('0131', '0001', CONVERT(DATE, '2023-12-01', 103), CONVERT(DATE, '2024-01-01', 103), '12.00'),
    ('0133', '0001', CONVERT(DATE, '2024-01-01', 103), CONVERT(DATE, '2024-02-01', 103), '12.00'),
    ('0134', '0011', CONVERT(DATE, '2023-04-01', 103), CONVERT(DATE, '2023-05-01', 103), '11.00'),
    ('0135', '0006', CONVERT(DATE, '2024-05-01', 103), CONVERT(DATE, '2023-06-01', 103), '15.00'),
    ('0139', '0009', CONVERT(DATE, '2023-02-01', 103), CONVERT(DATE, '2023-03-01', 103), '9.00'),
    ('0141', '0010', CONVERT(DATE, '2023-04-01', 103), CONVERT(DATE, '2023-05-01', 103), '13.00'),
    ('0142', '0006', CONVERT(DATE, '2023-06-01', 103), CONVERT(DATE, '2023-07-01', 103), '15.00'),
    ('0145', '0008', CONVERT(DATE, '2023-06-01', 103), CONVERT(DATE, '2023-07-01', 103), '14.00'),
    ('0145', '0009', CONVERT(DATE, '2023-10-01', 103), CONVERT(DATE, '2023-11-01', 103), '9.00'),
    ('0146', '0006', CONVERT(DATE, '2023-07-01', 103), CONVERT(DATE, '2023-08-01', 103), '15.00'),
    ('0150', '0008', CONVERT(DATE, '2023-07-01', 103), CONVERT(DATE, '2023-08-01', 103), '14.00');
GO

-- Trigger to update unit status after a lease is inserted
CREATE TRIGGER TR_UNIT_UPDATE_STATUS
ON Lease
AFTER INSERT
AS
BEGIN
    -- Update the status of the unit after a lease starts
    UPDATE Unit
    SET Status = 'Rented'
    FROM inserted
    WHERE Unit.Unit_ID = inserted.Unit_ID;
END
GO

-- Trigger to update contract details before a vendor is deleted
CREATE TRIGGER TR_VENDOR_BeforeDelete
ON Vendor
INSTEAD OF DELETE
AS
BEGIN
    -- Update the cost and set Vendor_ID to NULL before deleting a vendor
    UPDATE Contract
    SET Vendor_ID = NULL, Cost = 0
    WHERE Vendor_ID IN (SELECT Vendor_ID FROM deleted);

    -- Proceed to delete the vendor
    DELETE FROM Vendor
    WHERE Vendor_ID IN (SELECT Vendor_ID FROM deleted);
END
GO

-- Trigger to check tenant age before inserting a new tenant
CREATE TRIGGER TR_Tenant_BeforeInsert
ON Tenant
INSTEAD OF INSERT
AS
BEGIN
    DECLARE @CurrentDate DATE = GETDATE();
    DECLARE @DateOfBirth DATE;
    DECLARE @TenantID CHAR(4);

    SELECT @DateOfBirth = Date_of_Birth, @TenantID = Tenant_ID FROM inserted;

    IF DATEDIFF(DAY, @DateOfBirth, @CurrentDate) < 6570 -- 6570 days = 18 years
    BEGIN
        RAISERROR ('Tenant must be at least 18 years old.', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END

    -- Proceed to insert the new tenant
    INSERT INTO Tenant (Tenant_ID, Tenant_Name, Phone_Number, Tenant_Email, Date_of_Birth, Host)
    SELECT Tenant_ID, Tenant_Name, Phone_Number, Tenant_Email, Date_of_Birth, Host
    FROM inserted;
END
GO

-- Trigger to check tenant age before updating tenant details
CREATE TRIGGER TR_Tenant_BeforeUpdate
ON Tenant
INSTEAD OF UPDATE
AS
BEGIN
    DECLARE @CurrentDate DATE = GETDATE();
    DECLARE @DateOfBirth DATE;
    DECLARE @TenantID CHAR(4);

    SELECT @DateOfBirth = Date_of_Birth, @TenantID = Tenant_ID FROM inserted;

    IF DATEDIFF(DAY, @DateOfBirth, @CurrentDate) < 6570 -- 6570 days = 18 years
    BEGIN
        RAISERROR ('Tenant must be at least 18 years old.', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END

    -- Proceed to update the tenant details
    UPDATE Tenant
    SET Tenant_Name = inserted.Tenant_Name,
        Phone_Number = inserted.Phone_Number,
        Tenant_Email = inserted.Tenant_Email,
        Date_of_Birth = inserted.Date_of_Birth,
        Host = inserted.Host
    FROM inserted
    WHERE Tenant.Tenant_ID = inserted.Tenant_ID;
END
GO

-- Trigger to check if the payment date is not before the lease start date
CREATE TRIGGER Check_Payment_Date
ON Payment
INSTEAD OF INSERT
AS
BEGIN
    DECLARE @lease_start_date DATE;
    DECLARE @payment_date DATE;
    DECLARE @lease_id CHAR(4);

    SELECT @payment_date = Date, @lease_id = Lease_ID FROM inserted;

    SELECT @lease_start_date = Start_Date
    FROM Lease
    WHERE Lease_ID = @lease_id;

    IF @payment_date < @lease_start_date
    BEGIN
        RAISERROR ('Payment date cannot be before lease start date', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END

    -- Proceed to insert the payment
    INSERT INTO Payment (Payment_ID, Lease_ID, Date, Amount, Payment_Type)
    SELECT Payment_ID, Lease_ID, Date, Amount, Payment_Type
    FROM inserted;
END
GO

-- Trigger to update booking information before deleting an amenity
CREATE TRIGGER TR_AMENITY_BeforeDelete
ON Amenity
INSTEAD OF DELETE
AS
BEGIN
    -- Update booking information before deleting an amenity
    UPDATE Booking
    SET Amenity_ID = NULL, Tenant_ID = NULL, Cost = 0
    WHERE Amenity_ID IN (SELECT Amenity_ID FROM deleted);

    -- Proceed to delete the amenity
    DELETE FROM Amenity
    WHERE Amenity_ID IN (SELECT Amenity_ID FROM deleted);
END
GO

-- Function to get the resident count for a building in a specific year
CREATE FUNCTION GetResidentCountForBuilding (@BuildingID INT, @p_year INT)
RETURNS INT
AS
BEGIN
    DECLARE @sltenant_count INT;

    -- Calculate the number of residents by counting the number of tenants with leases in the building in the specified year
    SELECT @sltenant_count = COUNT(DISTINCT Tenant_ID)
    FROM Lease
    WHERE Unit_ID IN (
        SELECT Unit_ID
        FROM Unit
        WHERE Property_ID = @BuildingID
    ) AND YEAR(Start_Date) = @p_year;

    RETURN @sltenant_count;
END
GO

-- Function to get the tenant count by month and year
CREATE FUNCTION Tenant_CountByMonth (@t_month INT, @t_year INT)
RETURNS INT
AS
BEGIN
    DECLARE @tenant_count INT;

    SELECT @tenant_count = COUNT(*)
    FROM Lease
    WHERE YEAR(Start_Date) = @t_year
    AND MONTH(Start_Date) = @t_month;

    RETURN @tenant_count;
END
GO

-- Function to get the count of rented units by year
CREATE FUNCTION Rented_Unit_CountByYear (@target_year INT)
RETURNS INT
AS
BEGIN
    DECLARE @total_rented INT;

    SELECT @total_rented = COUNT(*)
    FROM Lease
    WHERE YEAR(Start_Date) = @target_year;

    RETURN @total_rented;
END
GO

-- Stored procedure to add an amenity and update booking cost if the amenity exists
CREATE PROCEDURE AddAmenity
    @p_Amenity_ID CHAR(4),
    @p_Property_ID CHAR(4),
    @p_Amenity_Name VARCHAR(50),
    @p_Description TEXT,
    @p_Cost DECIMAL(5,2)
AS
BEGIN
    -- Add new amenity
    INSERT INTO Amenity (Amenity_ID, Property_ID, Amenity_Name, Description)
    VALUES (@p_Amenity_ID, @p_Property_ID, @p_Amenity_Name, @p_Description);

    -- Update cost in the Booking table if the amenity exists
    UPDATE Booking
    SET Cost = @p_Cost
    WHERE Amenity_ID = @p_Amenity_ID;
END
GO

-- Procedure to add an amenity and cost
CREATE PROCEDURE AddAmenityAndCost
    @p_Amenity_ID CHAR(4),
    @p_Property_ID CHAR(4),
    @p_Amenity_Name VARCHAR(50),
    @p_Description TEXT,
    @p_Tenant_ID CHAR(4),
    @p_Start_Date DATETIME,
    @p_End_Date DATETIME,
    @p_Cost DECIMAL(5,2)
AS
BEGIN
    -- Add new amenity to the Amenity table
    INSERT INTO Amenity (Amenity_ID, Property_ID, Amenity_Name, Description)
    VALUES (@p_Amenity_ID, @p_Property_ID, @p_Amenity_Name, @p_Description);

    -- Add new cost to the Booking table
    INSERT INTO Booking (Tenant_ID, Amenity_ID, Start_Date, End_Date, Cost)
    VALUES (@p_Tenant_ID, @p_Amenity_ID, @p_Start_Date, @p_End_Date, @p_Cost);
END
GO

-- Procedure to get the list of tenants with active leases
CREATE PROCEDURE Tenant_GetList
AS
BEGIN
    -- Get the list of residents from active leases
    SELECT Tenant.Tenant_ID, Tenant.Tenant_Name, Tenant.Phone_Number, Tenant.Tenant_Email
    FROM Tenant
    JOIN Lease ON Tenant.Tenant_ID = Lease.Tenant_ID
    WHERE Lease.Start_Date <= GETDATE() AND Lease.End_Date >= GETDATE();
END
GO

-- Procedure to add a lease
CREATE PROCEDURE add_lease
    @lease_id CHAR(4),
    @unit_id CHAR(4),
    @tenant_id CHAR(4),
    @start_date DATE,
    @end_date DATE,
    @monthly_rent DECIMAL(10,2),
    @deposit DECIMAL(10,2)
AS
BEGIN
    DECLARE @Unit_Available INT;

    -- Check if the unit exists and is available
    SELECT @Unit_Available = COUNT(*)
    FROM Unit
    WHERE Unit_ID = @unit_id
    AND Status = 'Available';

    IF @Unit_Available = 0
    BEGIN
        RAISERROR ('Unit is not available for lease', 16, 1);
        RETURN;
    END
    ELSE
    BEGIN
        -- Add new lease record
        INSERT INTO Lease (
            Lease_ID,
            Unit_ID,
            Tenant_ID,
            Start_Date,
            End_Date,
            Monthly_Rent,
            Deposit
        ) VALUES (
            @lease_id,
            @unit_id,
            @tenant_id,
            @start_date,
            @end_date,
            @monthly_rent,
            @deposit
        );

        -- Update the status of the unit to 'Rented'
        UPDATE Unit
        SET Status = 'Rented'
        WHERE Unit_ID = @unit_id;
    END
END
GO

-- Procedure to get the list of available units
CREATE PROCEDURE UnitAvailable_GetList
AS
BEGIN
    -- Display the list of available units
    SELECT Unit_ID, Property_ID, Number, Floor, Rent
    FROM Unit
    WHERE Status = 'Available';
END
GO

-- Procedure to get the top 2 booking amenities for a given month and year
CREATE PROCEDURE Top2BookingAmenities
    @p_month INT,
    @p_year INT
AS
BEGIN
    -- Create a temporary table to store the results
    CREATE TABLE #temp_top_amenities (
        Amenity_ID CHAR(4),
        Amenity_Name VARCHAR(50),
        Booking_Count INT
    );

    -- Insert booking counts for each amenity into the temporary table
    INSERT INTO #temp_top_amenities (Amenity_ID, Amenity_Name, Booking_Count)
    SELECT 
        a.Amenity_ID,
        a.Amenity_Name,
        COUNT(b.Amenity_ID) AS Booking_Count
    FROM 
        Amenity a
    LEFT JOIN 
        Booking b ON a.Amenity_ID = b.Amenity_ID
        AND MONTH(b.Start_Date) = @p_month
        AND YEAR(b.Start_Date) = @p_year
    GROUP BY 
        a.Amenity_ID, a.Amenity_Name;

    -- Select the top 2 amenities with the highest booking counts
    SELECT TOP 2 Amenity_ID, Amenity_Name, Booking_Count
    FROM #temp_top_amenities
    ORDER BY Booking_Count DESC;

    -- Drop the temporary table
    DROP TABLE #temp_top_amenities;
END
GO

-- Procedure to cancel leases and update units
CREATE PROCEDURE CancelLeasesAndUpdateUnits
AS
BEGIN
    -- Declare variables to store values from each row
    DECLARE @v_lease_id CHAR(4);
    DECLARE @v_unit_id CHAR(4);

    -- Declare a cursor for expired leases
    DECLARE lease_cursor CURSOR FOR 
        SELECT Lease_ID, Unit_ID 
        FROM Lease 
        WHERE End_Date < GETDATE();

    -- Open the cursor
    OPEN lease_cursor;

    -- Fetch the first row
    FETCH NEXT FROM lease_cursor INTO @v_lease_id, @v_unit_id;

    -- Loop through the cursor
    WHILE @@FETCH_STATUS = 0
    BEGIN
        -- Delete related rows in the Payment table
        DELETE FROM Payment WHERE Lease_ID = @v_lease_id;

        -- Cancel the lease by deleting the row
        DELETE FROM Lease WHERE Lease_ID = @v_lease_id;

        -- Update the status of the unit to 'Available'
        UPDATE Unit
        SET Status = 'Available'
        WHERE Unit_ID = @v_unit_id;

        -- Fetch the next row
        FETCH NEXT FROM lease_cursor INTO @v_lease_id, @v_unit_id;
    END

    -- Close and deallocate the cursor
    CLOSE lease_cursor;
    DEALLOCATE lease_cursor;
END
GO

-- Procedure to update payment amounts
CREATE PROCEDURE UpdatePaymentAmounts
AS
BEGIN
    DECLARE @v_Lease_ID CHAR(4);
    DECLARE @v_Date DATE;
    DECLARE @v_Property_ID CHAR(4);
    DECLARE @v_Monthly_Rent DECIMAL(10,2);
    DECLARE @v_Total_Contract_Cost DECIMAL(10,2) = 0;
    DECLARE @v_Total_Booking_Cost DECIMAL(10,2) = 0;
    DECLARE @v_Tenant_ID CHAR(4);

    -- Declare a cursor to iterate through the Payment table
    DECLARE payment_cursor CURSOR FOR
        SELECT Lease_ID, Date
        FROM Payment;

    -- Open the cursor
    OPEN payment_cursor;

    -- Fetch the first row
    FETCH NEXT FROM payment_cursor INTO @v_Lease_ID, @v_Date;

    -- Loop through the cursor
    WHILE @@FETCH_STATUS = 0
    BEGIN
        -- Reset total costs for each iteration
        SET @v_Total_Contract_Cost = 0;
        SET @v_Total_Booking_Cost = 0;

        -- Get Monthly Rent, Property_ID, and Tenant_ID from Lease and Unit tables
        SELECT L.Tenant_ID, L.Monthly_Rent, U.Property_ID
        INTO @v_Tenant_ID, @v_Monthly_Rent, @v_Property_ID
        FROM Lease L
        JOIN Unit U ON L.Unit_ID = U.Unit_ID
        WHERE L.Lease_ID = @v_Lease_ID;

        -- Calculate total contract cost for the property
        SELECT @v_Total_Contract_Cost = SUM(C.Cost)
        FROM Contract C
        WHERE C.Property_ID = @v_Property_ID
          AND @v_Date BETWEEN C.Start_Date AND C.End_Date;

        -- Calculate total booking cost for the tenant
        SELECT @v_Total_Booking_Cost = SUM(B.Cost)
        FROM Booking B
        WHERE B.Tenant_ID = @v_Tenant_ID
          AND @v_Date BETWEEN B.Start_Date AND B.End_Date;

        -- Update the Payment amount
        UPDATE Payment
        SET Amount = @v_Monthly_Rent + ISNULL(@v_Total_Contract_Cost, 0) + ISNULL(@v_Total_Booking_Cost, 0)
        WHERE Lease_ID = @v_Lease_ID
          AND Date = @v_Date;

        -- Fetch the next row
        FETCH NEXT FROM payment_cursor INTO @v_Lease_ID, @v_Date;
    END

    -- Close and deallocate the cursor
    CLOSE payment_cursor;
    DEALLOCATE payment_cursor;
END
GO

-- Create a role for Manager
CREATE ROLE manager_role;
GO

-- Create a role for Tenant
CREATE ROLE tenant_role;
GO

-- Create Manager user and assign Manager role
CREATE LOGIN manager_user WITH PASSWORD = 'manager';
CREATE USER manager_user FOR LOGIN manager_user;
ALTER ROLE manager_role ADD MEMBER manager_user;

-- Create Tenant user and assign Tenant role
CREATE LOGIN tenant_user WITH PASSWORD = 'tenant';
CREATE USER tenant_user FOR LOGIN tenant_user;
ALTER ROLE tenant_role ADD MEMBER tenant_user;

-- Grant permissions to manager_role
GRANT SELECT, INSERT, UPDATE ON qlcc.dbo.Property TO manager_role;
GRANT SELECT, INSERT, UPDATE, DELETE ON qlcc.dbo.Vendor TO manager_role;
GRANT SELECT, INSERT, UPDATE ON qlcc.dbo.Unit TO manager_role;
GRANT SELECT, INSERT, UPDATE, DELETE ON qlcc.dbo.Lease TO manager_role;
GRANT SELECT, INSERT, UPDATE, DELETE ON qlcc.dbo.Payment TO manager_role;
GRANT SELECT, INSERT, UPDATE, DELETE ON qlcc.dbo.Tenant TO manager_role;
GRANT SELECT, INSERT, UPDATE, DELETE ON qlcc.dbo.Amenity TO manager_role;
GRANT SELECT, INSERT, UPDATE ON qlcc.dbo.Booking TO manager_role;
GRANT SELECT, INSERT, UPDATE ON qlcc.dbo.Contract TO manager_role;

-- Grant permissions to tenant_role
GRANT SELECT ON qlcc.dbo.Property TO tenant_role;
GRANT SELECT ON qlcc.dbo.Vendor TO tenant_role;
GRANT SELECT ON qlcc.dbo.Unit TO tenant_role;
GRANT SELECT ON qlcc.dbo.Lease TO tenant_role;
GRANT SELECT ON qlcc.dbo.Payment TO tenant_role;
GRANT SELECT ON qlcc.dbo.Tenant TO tenant_role;
GRANT SELECT ON qlcc.dbo.Amenity TO tenant_role;
GRANT SELECT, INSERT, UPDATE, DELETE ON qlcc.dbo.Booking TO tenant_role;
GRANT SELECT, INSERT, UPDATE, DELETE ON qlcc.dbo.Contract TO tenant_role;

-- Grant execute permissions on procedures and functions to manager_role
GRANT EXECUTE ON OBJECT::qlcc.dbo.Bill_unit_month TO manager_role;
GRANT EXECUTE ON OBJECT::qlcc.dbo.UnitAvailable_GetList TO manager_role;
GRANT EXECUTE ON OBJECT::qlcc.dbo.Tenant_GetList TO manager_role;
GRANT EXECUTE ON OBJECT::qlcc.dbo.Amenity_Add TO manager_role;
GRANT EXECUTE ON OBJECT::qlcc.dbo.BookAmenity TO manager_role;
GRANT EXECUTE ON OBJECT::qlcc.dbo.Add_Lease TO manager_role;
GRANT EXECUTE ON OBJECT::qlcc.dbo.Rented_Unit_CountByYear TO manager_role;
GRANT EXECUTE ON OBJECT::qlcc.dbo.GetResidentCountForBuilding TO manager_role;
GRANT EXECUTE ON OBJECT::qlcc.dbo.Tenant_CountByMonth TO manager_role;

-- Grant execute permissions on procedures and functions to tenant_role
GRANT EXECUTE ON OBJECT::qlcc.dbo.Bill_unit_month TO tenant_role;
GRANT EXECUTE ON OBJECT::qlcc.dbo.UnitAvailable_GetList TO tenant_role;
GRANT EXECUTE ON OBJECT::qlcc.dbo.BookAmenity TO tenant_role;
GRANT EXECUTE ON OBJECT::qlcc.dbo.Rented_Unit_CountByYear TO tenant_role;
GRANT EXECUTE ON OBJECT::qlcc.dbo.GetResidentCountForBuilding TO tenant_role;
GRANT EXECUTE ON OBJECT::qlcc.dbo.Tenant_CountByMonth TO tenant_role;

-- Add column salt into table Tenant
ALTER TABLE Tenant
ADD salt VARCHAR(20) NOT NULL;

-- Create procedure to add tenant
CREATE PROCEDURE Tenant_Add
    @p_host INT,
    @p_name VARCHAR(50),
    @p_phone VARCHAR(10),
    @p_email VARCHAR(50),
    @p_birthdate DATE,
    @p_password VARCHAR(20)
AS
BEGIN
    DECLARE @salt_value VARCHAR(20);
    -- Generate a new salt value
    SET @salt_value = CONVERT(VARCHAR(20), NEWID());
    -- Hash the password with the salt
    SET @p_password = HASHBYTES('SHA2_256', CONCAT(@p_password, @salt_value));
    -- Insert new tenant with hashed password and salt
    INSERT INTO Tenant (Host, Tenant_Name, Phone_Number, Tenant_Email, Date_of_Birth, accPassword, salt)
    VALUES (@p_host, @p_name, @p_phone, @p_email, @p_birthdate, @p_password, @salt_value);
END
GO

-- View to hide password for Tenant
CREATE VIEW Tenant_View AS
SELECT Tenant_ID, Tenant_Name, Phone_Number, Tenant_Email, Date_of_Birth, Host
FROM Tenant;

-- Revoke SELECT on Tenant table from tenant_role
REVOKE SELECT ON qlcc.dbo.Tenant FROM tenant_role;

-- Grant SELECT on Tenant_View to tenant_role
GRANT SELECT ON qlcc.dbo.Tenant_View TO tenant_role;

-- View to hide Payment amount for Tenant
CREATE VIEW Payment_View AS
SELECT Payment_ID, Lease_ID, Date, Payment_Type
FROM Payment;

-- Revoke SELECT on Payment table from tenant_role
REVOKE SELECT ON qlcc.dbo.Payment FROM tenant_role;

-- Grant SELECT on Payment_View to tenant_role
GRANT SELECT ON qlcc.dbo.Payment_View TO tenant_role;

-- View to see current tenants
CREATE VIEW Current_Tenants AS
SELECT t.Tenant_ID, t.Tenant_Name, t.Phone_Number, t.Tenant_Email, t.Date_of_Birth, l.Unit_ID, l.Start_Date, l.End_Date
FROM Tenant t
JOIN Lease l ON t.Tenant_ID = l.Tenant_ID
WHERE l.End_Date >= GETDATE();

-- Grant SELECT on Current_Tenants to tenant_role
GRANT SELECT ON qlcc.dbo.Current_Tenants TO tenant_role;

-- View to see booking count for each Amenity
CREATE VIEW Amenity_Booking_Count AS
SELECT a.Amenity_ID, a.Amenity_Name, COUNT(b.Booking_ID) AS Booking_Count
FROM Amenity a
LEFT JOIN Booking b ON a.Amenity_ID = b.Amenity_ID
GROUP BY a.Amenity_ID, a.Amenity_Name;

-- Grant SELECT on Amenity_Booking_Count to tenant_role
GRANT SELECT ON qlcc.dbo.Amenity_Booking_Count TO tenant_role;

-- View to see invoice details
CREATE VIEW Invoice_Details AS
SELECT p.Payment_ID, p.Date AS Payment_Date, p.Amount AS Payment_Amount, p.Payment_Type, l.Lease_ID, t.Tenant_ID, t.Tenant_Name, t.Phone_Number, t.Tenant_Email, u.Unit_ID, u.Number AS Unit_Number, u.Floor AS Unit_Floor, u.Rent AS Unit_Rent
FROM Payment p
JOIN Lease l ON p.Lease_ID = l.Lease_ID
JOIN Tenant t ON l.Tenant_ID = t.Tenant_ID
JOIN Unit u ON l.Unit_ID = u.Unit_ID;

-- Grant SELECT on Invoice_Details to tenant_role
GRANT SELECT ON qlcc.dbo.Invoice_Details TO tenant_role;

-- View to see amenity details
CREATE VIEW Amenity_Details AS
SELECT a.Amenity_ID, a.Amenity_Name, a.Description, p.Property_ID, p.Property_Name, p.Address AS Property_Address
FROM Amenity a
JOIN Property p ON a.Property_ID = p.Property_ID;

-- Grant SELECT on Amenity_Details to tenant_role
GRANT SELECT ON qlcc.dbo.Amenity_Details TO tenant_role;

-- View to see tenant payment details
CREATE VIEW Tenant_Payment_Details AS
SELECT p.Payment_ID, p.Date AS Payment_Date, p.Amount AS Payment_Amount, p.Payment_Type, t.Tenant_ID, t.Tenant_Name, t.Phone_Number, t.Tenant_Email
FROM Payment p
JOIN Lease l ON p.Lease_ID = l.Lease_ID
JOIN Tenant t ON l.Tenant_ID = t.Tenant_ID;

-- Grant SELECT on Tenant_Payment_Details to tenant_role
GRANT SELECT ON qlcc.dbo.Tenant_Payment_Details TO tenant_role;

CREATE DATABASE QLCC;

USE QLCC;

CREATE TABLE Property (
  	Property_ID CHAR(4) PRIMARY KEY,
  	Property_Name VARCHAR(50) NOT NULL,
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
  	Cost DECIMAL(5,2),
  	PRIMARY KEY (Vendor_ID, Property_ID),
	FOREIGN KEY (Vendor_ID) REFERENCES Vendor (Vendor_ID),
	FOREIGN KEY (Property_ID) REFERENCES Property (Property_ID)
);

CREATE TABLE Unit (
	Unit_ID CHAR(4) PRIMARY KEY,
	Property_ID CHAR(4),
	Number VARCHAR(5) NOT NULL,
	Floor INT,
	Rent DECIMAL(5,2),
	Status VARCHAR(10),
    FOREIGN KEY(Property_ID) REFERENCES Property(Property_ID)
);

CREATE TABLE Tenant (
	Tenant_ID CHAR(4) PRIMARY KEY,
	Tenant_Name VARCHAR(50) NOT NULL,
	Phone_Number VARCHAR(10),
	Tenant_Email VARCHAR(50),
	Date_of_Birth DATE,
	Host INT
);

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

CREATE TABLE Payment (
	Payment_ID CHAR(4) PRIMARY KEY,
	Lease_ID CHAR(4),
	Date DATE,
	Amount DECIMAL(5,2),
    Payment_Type VARCHAR(50),
    FOREIGN KEY(Lease_ID) REFERENCES Lease(Lease_ID)
);

CREATE TABLE Amenity (
	Amenity_ID CHAR(4) PRIMARY KEY,
	Property_ID CHAR(4) ,
	Amenity_Name VARCHAR(50),
	Description TEXT,
    FOREIGN KEY(Property_ID) REFERENCES Property(Property_ID)
);

CREATE TABLE Booking (
	Tenant_ID CHAR(4) ,
	Amenity_ID CHAR(4) ,
	Start_Date DATETIME,
	End_Date DATETIME,
	Cost DECIMAL(5,2),
    PRIMARY KEY (Tenant_ID, Amenity_ID),
	FOREIGN KEY(Tenant_ID) REFERENCES Tenant(Tenant_ID),
    FOREIGN KEY(Amenity_ID) REFERENCES Amenity(Amenity_ID)
);

-- Tạo ràng buộc UNIQUE cho cột Name trong bảng Property
ALTER TABLE Property
		ADD UNIQUE (Property_Name);
-- Tạo ràng buộc CHECK cho cột Start_Date và End_Date trong bảng Contact
ALTER TABLE Contract
	ADD CHECK (Start_Date < End_Date);
-- Tạo ràng buộc CHECK cho cột Cost trong bảng Contract
ALTER TABLE Contract
	ADD CHECK (Cost >= 0);
-- Tạo ràng buộc CHECK cho cột Cost trong bảng Booking
ALTER TABLE Booking
	ADD CHECK (Cost >= 0);
-- Tạo ràng buộc CHECK cho cột Start_Date và End_Date trong bảng Booking
-- ALTER TABLE Booking
-- ADD CHECK (Start_Date < End_Date);
-- Tạo ràng buộc UNIQUE cBill_unit_monthho cột Number trong bảng Unit
ALTER TABLE Unit
	ADD UNIQUE (Number);
-- Tạo ràng buộc UNIQUE cho cột Start_Date trong bảng Lease
ALTER TABLE Lease
	ADD UNIQUE (Unit_ID, Start_Date);
-- Tạo ràng buộc UNIQUE cho cột Date trong bảng Payment
ALTER TABLE Payment
     ADD UNIQUE (Lease_ID, Date);
-- Tạo ràng buộc CHECK cho cột Rent trong bảng Unit
ALTER TABLE Unit
     ADD CHECK (Rent >= 0);
-- Tạo ràng buộc CHECK cho cột Floor trong bảng Unit
ALTER TABLE Unit
     ADD CHECK (Floor >= 1);
-- Tạo ràng buộc CHECK cho cột Start_Date và End_Date trong bảng Lease
ALTER TABLE Lease
     ADD CHECK (Start_Date < End_Date);
-- Tạo ràng buộc CHECK cho cột Monthly Rent trong bảng Lease
ALTER TABLE Lease
     ADD CHECK (Monthly_Rent >= 0);
-- Tạo ràng buộc CHECK cho cột Deposit trong bảng Lease
ALTER TABLE Lease
     ADD CHECK (Deposit >= 0);
-- Tạo ràng buộc CHECK cho cột Amount trong bảng Payment
ALTER TABLE Payment
	ADD CHECK (Amount >= 0);
-- Tạo ràng buộc CHECK cho cột Email trong bảng Tenant
ALTER TABLE Tenant
	ADD CHECK (Tenant_Email LIKE '%@gmail.com');

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

INSERT INTO Contract (Vendor_ID, Property_ID, Start_Date, End_Date, Cost)
VALUES
    ('0001', '0001', STR_TO_DATE('01-01-2023', '%d-%m-%Y'), STR_TO_DATE('01-01-2028', '%d-%m-%Y'), 15.00),
    ('0001', '0002', STR_TO_DATE('01-02-2023', '%d-%m-%Y'), STR_TO_DATE('01-02-2028', '%d-%m-%Y'), 16.00),
    ('0001', '0003', STR_TO_DATE('01-03-2023', '%d-%m-%Y'), STR_TO_DATE('01-03-2028', '%d-%m-%Y'), 17.00),
    ('0001', '0004', STR_TO_DATE('01-04-2023', '%d-%m-%Y'), STR_TO_DATE('01-04-2028', '%d-%m-%Y'), 18.00),
    ('0001', '0005', STR_TO_DATE('01-05-2023', '%d-%m-%Y'), STR_TO_DATE('01-05-2028', '%d-%m-%Y'), 19.00),
    ('0001', '0006', STR_TO_DATE('01-06-2023', '%d-%m-%Y'), STR_TO_DATE('01-06-2028', '%d-%m-%Y'), 20.00),
    ('0001', '0007', STR_TO_DATE('01-07-2023', '%d-%m-%Y'), STR_TO_DATE('01-07-2028', '%d-%m-%Y'), 15.00),
    ('0001', '0008', STR_TO_DATE('01-08-2023', '%d-%m-%Y'), STR_TO_DATE('01-08-2028', '%d-%m-%Y'), 16.00),
    ('0001', '0009', STR_TO_DATE('01-09-2023', '%d-%m-%Y'), STR_TO_DATE('01-09-2028', '%d-%m-%Y'), 17.00),
    ('0001', '0010', STR_TO_DATE('01-10-2023', '%d-%m-%Y'), STR_TO_DATE('01-10-2028', '%d-%m-%Y'), 18.00),
    ('0001', '0011', STR_TO_DATE('01-11-2023', '%d-%m-%Y'), STR_TO_DATE('01-11-2028', '%d-%m-%Y'), 19.00),
    ('0001', '0012', STR_TO_DATE('01-12-2023', '%d-%m-%Y'), STR_TO_DATE('01-12-2028', '%d-%m-%Y'), 20.00),
    ('0001', '0013', STR_TO_DATE('01-01-2023', '%d-%m-%Y'), STR_TO_DATE('01-01-2028', '%d-%m-%Y'), 15.00),
    ('0001', '0014', STR_TO_DATE('01-02-2023', '%d-%m-%Y'), STR_TO_DATE('01-02-2028', '%d-%m-%Y'), 16.00),
    ('0001', '0015', STR_TO_DATE('01-03-2023', '%d-%m-%Y'), STR_TO_DATE('01-03-2028', '%d-%m-%Y'), 17.00),
    ('0001', '0016', STR_TO_DATE('01-04-2023', '%d-%m-%Y'), STR_TO_DATE('01-04-2028', '%d-%m-%Y'), 18.00),
    ('0001', '0017', STR_TO_DATE('01-05-2023', '%d-%m-%Y'), STR_TO_DATE('01-05-2028', '%d-%m-%Y'), 19.00),
    ('0001', '0018', STR_TO_DATE('01-06-2023', '%d-%m-%Y'), STR_TO_DATE('01-06-2028', '%d-%m-%Y'), 20.00),
    ('0001', '0019', STR_TO_DATE('01-07-2023', '%d-%m-%Y'), STR_TO_DATE('01-07-2028', '%d-%m-%Y'), 15.00),
    ('0001', '0020', STR_TO_DATE('01-08-2023', '%d-%m-%Y'), STR_TO_DATE('01-08-2028', '%d-%m-%Y'), 16.00),
    ('0002', '0001', STR_TO_DATE('01-01-2023', '%d-%m-%Y'), STR_TO_DATE('01-01-2028', '%d-%m-%Y'), 17.00),
    ('0002', '0002', STR_TO_DATE('01-02-2023', '%d-%m-%Y'), STR_TO_DATE('01-02-2028', '%d-%m-%Y'), 18.00),
    ('0002', '0003', STR_TO_DATE('01-03-2023', '%d-%m-%Y'), STR_TO_DATE('01-03-2028', '%d-%m-%Y'), 19.00),
    ('0002', '0004', STR_TO_DATE('01-04-2023', '%d-%m-%Y'), STR_TO_DATE('01-04-2028', '%d-%m-%Y'), 20.00),
    ('0002', '0005', STR_TO_DATE('01-05-2023', '%d-%m-%Y'), STR_TO_DATE('01-05-2028', '%d-%m-%Y'), 15.00),
    ('0002', '0006', STR_TO_DATE('01-06-2023', '%d-%m-%Y'), STR_TO_DATE('01-06-2028', '%d-%m-%Y'), 16.00),
    ('0002', '0007', STR_TO_DATE('01-07-2023', '%d-%m-%Y'), STR_TO_DATE('01-07-2028', '%d-%m-%Y'), 17.00),
    ('0002', '0008', STR_TO_DATE('01-08-2023', '%d-%m-%Y'), STR_TO_DATE('01-08-2028', '%d-%m-%Y'), 18.00),
    ('0002', '0009', STR_TO_DATE('01-09-2023', '%d-%m-%Y'), STR_TO_DATE('01-09-2028', '%d-%m-%Y'), 19.00),
    ('0002', '0010', STR_TO_DATE('01-10-2023', '%d-%m-%Y'), STR_TO_DATE('01-10-2028', '%d-%m-%Y'), 20.00),
    ('0002', '0011', STR_TO_DATE('01-11-2023', '%d-%m-%Y'), STR_TO_DATE('01-11-2028', '%d-%m-%Y'), 15.00),
    ('0002', '0012', STR_TO_DATE('01-12-2023', '%d-%m-%Y'), STR_TO_DATE('01-12-2028', '%d-%m-%Y'), 16.00),
    ('0002', '0013', STR_TO_DATE('01-01-2023', '%d-%m-%Y'), STR_TO_DATE('01-01-2028', '%d-%m-%Y'), 17.00),
    ('0002', '0014', STR_TO_DATE('01-02-2023', '%d-%m-%Y'), STR_TO_DATE('01-02-2028', '%d-%m-%Y'), 18.00),
    ('0002', '0015', STR_TO_DATE('01-03-2023', '%d-%m-%Y'), STR_TO_DATE('01-03-2028', '%d-%m-%Y'), 19.00),
    ('0002', '0016', STR_TO_DATE('01-04-2023', '%d-%m-%Y'), STR_TO_DATE('01-04-2028', '%d-%m-%Y'), 20.00),
    ('0002', '0017', STR_TO_DATE('01-05-2023', '%d-%m-%Y'), STR_TO_DATE('01-05-2028', '%d-%m-%Y'), 15.00),
    ('0002', '0018', STR_TO_DATE('01-06-2023', '%d-%m-%Y'), STR_TO_DATE('01-06-2028', '%d-%m-%Y'), 16.00),
    ('0002', '0019', STR_TO_DATE('01-07-2023', '%d-%m-%Y'), STR_TO_DATE('01-07-2028', '%d-%m-%Y'), 17.00),
    ('0002', '0020', STR_TO_DATE('01-08-2023', '%d-%m-%Y'), STR_TO_DATE('01-08-2028', '%d-%m-%Y'), 18.00),
    ('0003', '0001', STR_TO_DATE('01-01-2023', '%d-%m-%Y'), STR_TO_DATE('01-01-2028', '%d-%m-%Y'), 19.00),
    ('0003', '0002', STR_TO_DATE('01-02-2023', '%d-%m-%Y'), STR_TO_DATE('01-02-2028', '%d-%m-%Y'), 20.00),
    ('0003', '0003', STR_TO_DATE('01-03-2023', '%d-%m-%Y'), STR_TO_DATE('01-03-2028', '%d-%m-%Y'), 15.00),
    ('0003', '0004', STR_TO_DATE('01-04-2023', '%d-%m-%Y'), STR_TO_DATE('01-04-2028', '%d-%m-%Y'), 16.00),
    ('0003', '0005', STR_TO_DATE('01-05-2023', '%d-%m-%Y'), STR_TO_DATE('01-05-2028', '%d-%m-%Y'), 17.00),
    ('0003', '0006', STR_TO_DATE('01-06-2023', '%d-%m-%Y'), STR_TO_DATE('01-06-2028', '%d-%m-%Y'), 18.00),
    ('0003', '0007', STR_TO_DATE('01-07-2023', '%d-%m-%Y'), STR_TO_DATE('01-07-2028', '%d-%m-%Y'), 19.00),
    ('0003', '0008', STR_TO_DATE('01-08-2023', '%d-%m-%Y'), STR_TO_DATE('01-08-2028', '%d-%m-%Y'), 20.00),
    ('0003', '0009', STR_TO_DATE('01-09-2023', '%d-%m-%Y'), STR_TO_DATE('01-09-2028', '%d-%m-%Y'), 15.00),
    ('0003', '0010', STR_TO_DATE('01-10-2023', '%d-%m-%Y'), STR_TO_DATE('01-10-2028', '%d-%m-%Y'), 16.00),
    ('0003', '0011', STR_TO_DATE('01-11-2023', '%d-%m-%Y'), STR_TO_DATE('01-11-2028', '%d-%m-%Y'), 17.00),
    ('0003', '0012', STR_TO_DATE('01-12-2023', '%d-%m-%Y'), STR_TO_DATE('01-12-2028', '%d-%m-%Y'), 18.00),
    ('0003', '0013', STR_TO_DATE('01-01-2023', '%d-%m-%Y'), STR_TO_DATE('01-01-2028', '%d-%m-%Y'), 19.00),
    ('0003', '0014', STR_TO_DATE('01-02-2023', '%d-%m-%Y'), STR_TO_DATE('01-02-2028', '%d-%m-%Y'), 20.00),
    ('0003', '0015', STR_TO_DATE('01-03-2023', '%d-%m-%Y'), STR_TO_DATE('01-03-2028', '%d-%m-%Y'), 15.00),
    ('0003', '0016', STR_TO_DATE('01-04-2023', '%d-%m-%Y'), STR_TO_DATE('01-04-2028', '%d-%m-%Y'), 16.00),
    ('0003', '0017', STR_TO_DATE('01-05-2023', '%d-%m-%Y'), STR_TO_DATE('01-05-2028', '%d-%m-%Y'), 17.00),
    ('0003', '0018', STR_TO_DATE('01-06-2023', '%d-%m-%Y'), STR_TO_DATE('01-06-2028', '%d-%m-%Y'), 18.00),
    ('0003', '0019', STR_TO_DATE('01-07-2023', '%d-%m-%Y'), STR_TO_DATE('01-07-2028', '%d-%m-%Y'), 19.00),
    ('0003', '0020', STR_TO_DATE('01-08-2023', '%d-%m-%Y'), STR_TO_DATE('01-08-2028', '%d-%m-%Y'), 20.00),
    ('0004', '0001', STR_TO_DATE('01-01-2023', '%d-%m-%Y'), STR_TO_DATE('01-01-2028', '%d-%m-%Y'), 15.00),
    ('0004', '0002', STR_TO_DATE('01-02-2023', '%d-%m-%Y'), STR_TO_DATE('01-02-2028', '%d-%m-%Y'), 16.00),
    ('0004', '0003', STR_TO_DATE('01-03-2023', '%d-%m-%Y'), STR_TO_DATE('01-03-2028', '%d-%m-%Y'), 17.00),
    ('0004', '0004', STR_TO_DATE('01-04-2023', '%d-%m-%Y'), STR_TO_DATE('01-04-2028', '%d-%m-%Y'), 18.00),
    ('0004', '0005', STR_TO_DATE('01-05-2023', '%d-%m-%Y'), STR_TO_DATE('01-05-2028', '%d-%m-%Y'), 19.00),
    ('0004', '0006', STR_TO_DATE('01-06-2023', '%d-%m-%Y'), STR_TO_DATE('01-06-2028', '%d-%m-%Y'), 20.00),
    ('0004', '0007', STR_TO_DATE('01-07-2023', '%d-%m-%Y'), STR_TO_DATE('01-07-2028', '%d-%m-%Y'), 15.00),
    ('0004', '0008', STR_TO_DATE('01-08-2023', '%d-%m-%Y'), STR_TO_DATE('01-08-2028', '%d-%m-%Y'), 16.00),
    ('0004', '0009', STR_TO_DATE('01-09-2023', '%d-%m-%Y'), STR_TO_DATE('01-09-2028', '%d-%m-%Y'), 17.00),
    ('0004', '0010', STR_TO_DATE('01-10-2023', '%d-%m-%Y'), STR_TO_DATE('01-10-2028', '%d-%m-%Y'), 18.00),
    ('0004', '0011', STR_TO_DATE('01-11-2023', '%d-%m-%Y'), STR_TO_DATE('01-11-2028', '%d-%m-%Y'), 19.00),
    ('0004', '0012', STR_TO_DATE('01-12-2023', '%d-%m-%Y'), STR_TO_DATE('01-12-2028', '%d-%m-%Y'), 20.00),
    ('0004', '0013', STR_TO_DATE('01-01-2023', '%d-%m-%Y'), STR_TO_DATE('01-01-2028', '%d-%m-%Y'), 15.00),
    ('0004', '0014', STR_TO_DATE('01-02-2023', '%d-%m-%Y'), STR_TO_DATE('01-02-2028', '%d-%m-%Y'), 16.00),
    ('0004', '0015', STR_TO_DATE('01-03-2023', '%d-%m-%Y'), STR_TO_DATE('01-03-2028', '%d-%m-%Y'), 17.00),
    ('0004', '0016', STR_TO_DATE('01-04-2023', '%d-%m-%Y'), STR_TO_DATE('01-04-2028', '%d-%m-%Y'), 18.00),
    ('0004', '0017', STR_TO_DATE('01-05-2023', '%d-%m-%Y'), STR_TO_DATE('01-05-2028', '%d-%m-%Y'), 19.00),
    ('0004', '0018', STR_TO_DATE('01-06-2023', '%d-%m-%Y'), STR_TO_DATE('01-06-2028', '%d-%m-%Y'), 20.00),
    ('0004', '0019', STR_TO_DATE('01-07-2023', '%d-%m-%Y'), STR_TO_DATE('01-07-2028', '%d-%m-%Y'), 15.00),
    ('0004', '0020', STR_TO_DATE('01-08-2023', '%d-%m-%Y'), STR_TO_DATE('01-08-2028', '%d-%m-%Y'), 16.00),
    ('0005', '0001', STR_TO_DATE('01-01-2023', '%d-%m-%Y'), STR_TO_DATE('01-01-2028', '%d-%m-%Y'), 17.00),
    ('0005', '0002', STR_TO_DATE('01-02-2023', '%d-%m-%Y'), STR_TO_DATE('01-02-2028', '%d-%m-%Y'), 18.00),
    ('0005', '0003', STR_TO_DATE('01-03-2023', '%d-%m-%Y'), STR_TO_DATE('01-03-2028', '%d-%m-%Y'), 19.00),
    ('0005', '0004', STR_TO_DATE('01-04-2023', '%d-%m-%Y'), STR_TO_DATE('01-04-2028', '%d-%m-%Y'), 20.00),
    ('0005', '0005', STR_TO_DATE('01-05-2023', '%d-%m-%Y'), STR_TO_DATE('01-05-2028', '%d-%m-%Y'), 15.00),
    ('0005', '0006', STR_TO_DATE('01-06-2023', '%d-%m-%Y'), STR_TO_DATE('01-06-2028', '%d-%m-%Y'), 16.00),
    ('0005', '0007', STR_TO_DATE('01-07-2023', '%d-%m-%Y'), STR_TO_DATE('01-07-2028', '%d-%m-%Y'), 17.00),
    ('0005', '0008', STR_TO_DATE('01-08-2023', '%d-%m-%Y'), STR_TO_DATE('01-08-2028', '%d-%m-%Y'), 18.00),
    ('0005', '0009', STR_TO_DATE('01-09-2023', '%d-%m-%Y'), STR_TO_DATE('01-09-2028', '%d-%m-%Y'), 19.00),
    ('0005', '0010', STR_TO_DATE('01-10-2023', '%d-%m-%Y'), STR_TO_DATE('01-10-2028', '%d-%m-%Y'), 20.00),
    ('0005', '0011', STR_TO_DATE('01-11-2023', '%d-%m-%Y'), STR_TO_DATE('01-11-2028', '%d-%m-%Y'), 15.00),
    ('0005', '0012', STR_TO_DATE('01-12-2023', '%d-%m-%Y'), STR_TO_DATE('01-12-2028', '%d-%m-%Y'), 16.00),
    ('0005', '0013', STR_TO_DATE('01-01-2023', '%d-%m-%Y'), STR_TO_DATE('01-01-2028', '%d-%m-%Y'), 17.00),
    ('0005', '0014', STR_TO_DATE('01-02-2023', '%d-%m-%Y'), STR_TO_DATE('01-02-2028', '%d-%m-%Y'), 18.00),
    ('0005', '0015', STR_TO_DATE('01-03-2023', '%d-%m-%Y'), STR_TO_DATE('01-03-2028', '%d-%m-%Y'), 19.00),
    ('0005', '0016', STR_TO_DATE('01-04-2023', '%d-%m-%Y'), STR_TO_DATE('01-04-2028', '%d-%m-%Y'), 20.00),
    ('0005', '0017', STR_TO_DATE('01-05-2023', '%d-%m-%Y'), STR_TO_DATE('01-05-2028', '%d-%m-%Y'), 15.00),
    ('0005', '0018', STR_TO_DATE('01-06-2023', '%d-%m-%Y'), STR_TO_DATE('01-06-2028', '%d-%m-%Y'), 16.00),
    ('0005', '0019', STR_TO_DATE('01-07-2023', '%d-%m-%Y'), STR_TO_DATE('01-07-2028', '%d-%m-%Y'), 17.00),
    ('0005', '0020', STR_TO_DATE('01-08-2023', '%d-%m-%Y'), STR_TO_DATE('01-08-2028', '%d-%m-%Y'), 18.00),
    ('0006', '0001', STR_TO_DATE('01-01-2023', '%d-%m-%Y'), STR_TO_DATE('01-01-2028', '%d-%m-%Y'), 19.00),
    ('0006', '0002', STR_TO_DATE('01-02-2023', '%d-%m-%Y'), STR_TO_DATE('01-02-2028', '%d-%m-%Y'), 20.00),
    ('0006', '0003', STR_TO_DATE('01-03-2023', '%d-%m-%Y'), STR_TO_DATE('01-03-2028', '%d-%m-%Y'), 15.00),
    ('0006', '0004', STR_TO_DATE('01-04-2023', '%d-%m-%Y'), STR_TO_DATE('01-04-2028', '%d-%m-%Y'), 16.00),
    ('0006', '0005', STR_TO_DATE('01-05-2023', '%d-%m-%Y'), STR_TO_DATE('01-05-2028', '%d-%m-%Y'), 17.00),
    ('0006', '0006', STR_TO_DATE('01-06-2023', '%d-%m-%Y'), STR_TO_DATE('01-06-2028', '%d-%m-%Y'), 18.00),
    ('0006', '0007', STR_TO_DATE('01-07-2023', '%d-%m-%Y'), STR_TO_DATE('01-07-2028', '%d-%m-%Y'), 19.00),
    ('0006', '0008', STR_TO_DATE('01-08-2023', '%d-%m-%Y'), STR_TO_DATE('01-08-2028', '%d-%m-%Y'), 20.00),
    ('0006', '0009', STR_TO_DATE('01-09-2023', '%d-%m-%Y'), STR_TO_DATE('01-09-2028', '%d-%m-%Y'), 15.00),
    ('0006', '0010', STR_TO_DATE('01-10-2023', '%d-%m-%Y'), STR_TO_DATE('01-10-2028', '%d-%m-%Y'), 16.00),
    ('0006', '0011', STR_TO_DATE('01-11-2023', '%d-%m-%Y'), STR_TO_DATE('01-11-2028', '%d-%m-%Y'), 17.00),
    ('0006', '0012', STR_TO_DATE('01-12-2023', '%d-%m-%Y'), STR_TO_DATE('01-12-2028', '%d-%m-%Y'), 18.00),
    ('0006', '0013', STR_TO_DATE('01-01-2023', '%d-%m-%Y'), STR_TO_DATE('01-01-2028', '%d-%m-%Y'), 19.00),
    ('0006', '0014', STR_TO_DATE('01-02-2023', '%d-%m-%Y'), STR_TO_DATE('01-02-2028', '%d-%m-%Y'), 20.00),
    ('0006', '0015', STR_TO_DATE('01-03-2023', '%d-%m-%Y'), STR_TO_DATE('01-03-2028', '%d-%m-%Y'), 15.00),
    ('0006', '0016', STR_TO_DATE('01-04-2023', '%d-%m-%Y'), STR_TO_DATE('01-04-2028', '%d-%m-%Y'), 16.00),
    ('0006', '0017', STR_TO_DATE('01-05-2023', '%d-%m-%Y'), STR_TO_DATE('01-05-2028', '%d-%m-%Y'), 17.00),
    ('0006', '0018', STR_TO_DATE('01-06-2023', '%d-%m-%Y'), STR_TO_DATE('01-06-2028', '%d-%m-%Y'), 18.00),
    ('0006', '0019', STR_TO_DATE('01-07-2023', '%d-%m-%Y'), STR_TO_DATE('01-07-2028', '%d-%m-%Y'), 19.00),
    ('0006', '0020', STR_TO_DATE('01-08-2023', '%d-%m-%Y'), STR_TO_DATE('01-08-2028', '%d-%m-%Y'), 20.00),
    ('0007', '0001', STR_TO_DATE('01-01-2023', '%d-%m-%Y'), STR_TO_DATE('01-01-2028', '%d-%m-%Y'), 15.00),
    ('0007', '0002', STR_TO_DATE('01-02-2023', '%d-%m-%Y'), STR_TO_DATE('01-02-2028', '%d-%m-%Y'), 16.00),
    ('0007', '0003', STR_TO_DATE('01-03-2023', '%d-%m-%Y'), STR_TO_DATE('01-03-2028', '%d-%m-%Y'), 17.00),
    ('0007', '0004', STR_TO_DATE('01-04-2023', '%d-%m-%Y'), STR_TO_DATE('01-04-2028', '%d-%m-%Y'), 18.00),
    ('0007', '0005', STR_TO_DATE('01-05-2023', '%d-%m-%Y'), STR_TO_DATE('01-05-2028', '%d-%m-%Y'), 19.00),
    ('0007', '0006', STR_TO_DATE('01-06-2023', '%d-%m-%Y'), STR_TO_DATE('01-06-2028', '%d-%m-%Y'), 20.00),
    ('0007', '0007', STR_TO_DATE('01-07-2023', '%d-%m-%Y'), STR_TO_DATE('01-07-2028', '%d-%m-%Y'), 15.00),
    ('0007', '0008', STR_TO_DATE('01-08-2023', '%d-%m-%Y'), STR_TO_DATE('01-08-2028', '%d-%m-%Y'), 16.00),
    ('0007', '0009', STR_TO_DATE('01-09-2023', '%d-%m-%Y'), STR_TO_DATE('01-09-2028', '%d-%m-%Y'), 17.00),
    ('0007', '0010', STR_TO_DATE('01-10-2023', '%d-%m-%Y'), STR_TO_DATE('01-10-2028', '%d-%m-%Y'), 18.00),
    ('0007', '0011', STR_TO_DATE('01-11-2023', '%d-%m-%Y'), STR_TO_DATE('01-11-2028', '%d-%m-%Y'), 19.00),
    ('0007', '0012', STR_TO_DATE('01-12-2023', '%d-%m-%Y'), STR_TO_DATE('01-12-2028', '%d-%m-%Y'), 20.00),
    ('0007', '0013', STR_TO_DATE('01-01-2023', '%d-%m-%Y'), STR_TO_DATE('01-01-2028', '%d-%m-%Y'), 15.00),
    ('0007', '0014', STR_TO_DATE('01-02-2023', '%d-%m-%Y'), STR_TO_DATE('01-02-2028', '%d-%m-%Y'), 16.00),
    ('0007', '0015', STR_TO_DATE('01-03-2023', '%d-%m-%Y'), STR_TO_DATE('01-03-2028', '%d-%m-%Y'), 17.00),
    ('0007', '0016', STR_TO_DATE('01-04-2023', '%d-%m-%Y'), STR_TO_DATE('01-04-2028', '%d-%m-%Y'), 18.00),
    ('0007', '0017', STR_TO_DATE('01-05-2023', '%d-%m-%Y'), STR_TO_DATE('01-05-2028', '%d-%m-%Y'), 19.00),
    ('0007', '0018', STR_TO_DATE('01-06-2023', '%d-%m-%Y'), STR_TO_DATE('01-06-2028', '%d-%m-%Y'), 20.00),
    ('0007', '0019', STR_TO_DATE('01-07-2023', '%d-%m-%Y'), STR_TO_DATE('01-07-2028', '%d-%m-%Y'), 15.00),
    ('0007', '0020', STR_TO_DATE('01-08-2023', '%d-%m-%Y'), STR_TO_DATE('01-08-2028', '%d-%m-%Y'), 16.00),
    ('0008', '0001', STR_TO_DATE('01-01-2023', '%d-%m-%Y'), STR_TO_DATE('01-01-2028', '%d-%m-%Y'), 17.00),
    ('0008', '0002', STR_TO_DATE('01-02-2023', '%d-%m-%Y'), STR_TO_DATE('01-02-2028', '%d-%m-%Y'), 18.00),
    ('0008', '0003', STR_TO_DATE('01-03-2023', '%d-%m-%Y'), STR_TO_DATE('01-03-2028', '%d-%m-%Y'), 19.00),
    ('0008', '0004', STR_TO_DATE('01-04-2023', '%d-%m-%Y'), STR_TO_DATE('01-04-2028', '%d-%m-%Y'), 20.00),
    ('0008', '0005', STR_TO_DATE('01-05-2023', '%d-%m-%Y'), STR_TO_DATE('01-05-2028', '%d-%m-%Y'), 15.00),
    ('0008', '0006', STR_TO_DATE('01-06-2023', '%d-%m-%Y'), STR_TO_DATE('01-06-2028', '%d-%m-%Y'), 16.00),
    ('0008', '0007', STR_TO_DATE('01-07-2023', '%d-%m-%Y'), STR_TO_DATE('01-07-2028', '%d-%m-%Y'), 17.00),
    ('0008', '0008', STR_TO_DATE('01-08-2023', '%d-%m-%Y'), STR_TO_DATE('01-08-2028', '%d-%m-%Y'), 18.00),
    ('0008', '0009', STR_TO_DATE('01-09-2023', '%d-%m-%Y'), STR_TO_DATE('01-09-2028', '%d-%m-%Y'), 19.00),
    ('0008', '0010', STR_TO_DATE('01-10-2023', '%d-%m-%Y'), STR_TO_DATE('01-10-2028', '%d-%m-%Y'), 20.00),
    ('0008', '0011', STR_TO_DATE('01-11-2023', '%d-%m-%Y'), STR_TO_DATE('01-11-2028', '%d-%m-%Y'), 15.00),
    ('0008', '0012', STR_TO_DATE('01-12-2023', '%d-%m-%Y'), STR_TO_DATE('01-12-2028', '%d-%m-%Y'), 16.00),
    ('0008', '0013', STR_TO_DATE('01-01-2023', '%d-%m-%Y'), STR_TO_DATE('01-01-2028', '%d-%m-%Y'), 17.00),
    ('0008', '0014', STR_TO_DATE('01-02-2023', '%d-%m-%Y'), STR_TO_DATE('01-02-2028', '%d-%m-%Y'), 18.00),
    ('0008', '0015', STR_TO_DATE('01-03-2023', '%d-%m-%Y'), STR_TO_DATE('01-03-2028', '%d-%m-%Y'), 19.00),
    ('0008', '0016', STR_TO_DATE('01-04-2023', '%d-%m-%Y'), STR_TO_DATE('01-04-2028', '%d-%m-%Y'), 20.00),
    ('0008', '0017', STR_TO_DATE('01-05-2023', '%d-%m-%Y'), STR_TO_DATE('01-05-2028', '%d-%m-%Y'), 15.00),
    ('0008', '0018', STR_TO_DATE('01-06-2023', '%d-%m-%Y'), STR_TO_DATE('01-06-2028', '%d-%m-%Y'), 16.00),
    ('0008', '0019', STR_TO_DATE('01-07-2023', '%d-%m-%Y'), STR_TO_DATE('01-07-2028', '%d-%m-%Y'), 17.00),
    ('0008', '0020', STR_TO_DATE('01-08-2023', '%d-%m-%Y'), STR_TO_DATE('01-08-2028', '%d-%m-%Y'), 18.00);

INSERT INTO Tenant (Tenant_ID, Tenant_Name, Phone_Number, Tenant_Email, Date_of_Birth, Host) VALUES
('0001', 'John Smith', '0987654321', 'john.smith@gmail.com', STR_TO_DATE('08-12-1985', '%d-%m-%Y'), 0),
('0002', 'Jane Doe', '0971234567', 'jane.doe@gmail.com', STR_TO_DATE('15-07-1990', '%d-%m-%Y'), 0),
('0003', 'Michael Johnson', '0969876543', 'michael.johnson@gmail.com', STR_TO_DATE('02-02-1982', '%d-%m-%Y'), 0),
('0004', 'Emily Davis', '0953456789', 'emily.davis@gmail.com', STR_TO_DATE('22-04-1995', '%d-%m-%Y'), 1),
('0005', 'James Brown', '0945678901', 'james.brown@gmail.com', STR_TO_DATE('11-10-1987', '%d-%m-%Y'), 1),
('0006', 'Mary Wilson', '0931230987', 'mary.wilson@gmail.com', STR_TO_DATE('30-03-1993', '%d-%m-%Y'), 0),
('0007', 'Robert Miller', '0923456789', 'robert.miller@gmail.com', STR_TO_DATE('18-09-1981', '%d-%m-%Y'), 0),
('0008', 'Patricia Moore', '0910987654', 'patricia.moore@gmail.com', STR_TO_DATE('25-12-1978', '%d-%m-%Y'), 0),
('0009', 'William Anderson', '0907654321', 'william.anderson@gmail.com', STR_TO_DATE('14-05-1984', '%d-%m-%Y'), 1),
('0010', 'Linda Taylor', '0899876543', 'linda.taylor@gmail.com', STR_TO_DATE('21-01-1989', '%d-%m-%Y'), 1),
('0011', 'David Thomas', '0881234567', 'david.thomas@gmail.com', STR_TO_DATE('10-07-1992', '%d-%m-%Y'), 1),
('0012', 'Barbara Jackson', '0873456789', 'barbara.jackson@gmail.com', STR_TO_DATE('29-06-1980', '%d-%m-%Y'), 0),
('0013', 'Richard White', '0865678901', 'richard.white@gmail.com', STR_TO_DATE('03-03-1985', '%d-%m-%Y'), 1),
('0014', 'Susan Harris', '0857654321', 'susan.harris@gmail.com', STR_TO_DATE('19-08-1991', '%d-%m-%Y'), 1),
('0015', 'Charles Martin', '0841234567', 'charles.martin@gmail.com', STR_TO_DATE('28-12-1975', '%d-%m-%Y'), 0),
('0016', 'Jessica Clark', '0833456789', 'jessica.clark@gmail.com', STR_TO_DATE('11-11-1994', '%d-%m-%Y'), 0),
('0017', 'Joseph Lee', '0825678901', 'joseph.lee@gmail.com', STR_TO_DATE('06-05-1988', '%d-%m-%Y'), 1),
('0018', 'Sarah Lewis', '0817654321', 'sarah.lewis@gmail.com', STR_TO_DATE('20-02-1996', '%d-%m-%Y'), 0),
('0019', 'Christopher Walker', '0809876543', 'christopher.walker@gmail.com', STR_TO_DATE('09-08-1983', '%d-%m-%Y'), 0),
('0020', 'Karen Young', '0791234567', 'karen.young@gmail.com', STR_TO_DATE('04-04-1979', '%d-%m-%Y'), 1),
('0021', 'Daniel King', '0783456789', 'daniel.king@gmail.com', STR_TO_DATE('17-07-1986', '%d-%m-%Y'), 0),
('0022', 'Lisa Wright', '0775678901', 'lisa.wright@gmail.com', STR_TO_DATE('24-01-1992', '%d-%m-%Y'), 1),
('0023', 'Matthew Green', '0767654321', 'matthew.green@gmail.com', STR_TO_DATE('13-11-1984', '%d-%m-%Y'), 0),
('0024', 'Nancy Adams', '0759876543', 'nancy.adams@gmail.com', STR_TO_DATE('27-05-1991', '%d-%m-%Y'), 0),
('0025', 'Anthony Baker', '0741234567', 'anthony.baker@gmail.com', STR_TO_DATE('16-03-1983', '%d-%m-%Y'), 0),
('0026', 'Margaret Hall', '0733456789', 'margaret.hall@gmail.com', STR_TO_DATE('10-09-1986', '%d-%m-%Y'), 0),
('0027', 'Donald Scott', '0725678901', 'donald.scott@gmail.com', STR_TO_DATE('06-06-1987', '%d-%m-%Y'), 0),
('0028', 'Betty Allen', '0717654321', 'betty.allen@gmail.com', STR_TO_DATE('09-12-1974', '%d-%m-%Y'), 0),
('0029', 'Mark Parker', '0709876543', 'mark.parker@gmail.com', STR_TO_DATE('21-08-1980', '%d-%m-%Y'), 0),
('0030', 'Sandra Mitchell', '0691234567', 'sandra.mitchell@gmail.com', STR_TO_DATE('12-03-1992', '%d-%m-%Y'), 1),
('0031', 'Paul Campbell', '0683456789', 'paul.campbell@gmail.com', STR_TO_DATE('10-04-1985', '%d-%m-%Y'), 1),
('0032', 'Ashley Evans', '0675678901', 'ashley.evans@gmail.com', STR_TO_DATE('13-06-1990', '%d-%m-%Y'), 0),
('0033', 'Steven Carter', '0667654321', 'steven.carter@gmail.com', STR_TO_DATE('02-02-1987', '%d-%m-%Y'), 1),
('0034', 'Kimberly Roberts', '0659876543', 'kimberly.roberts@gmail.com', STR_TO_DATE('04-01-1995', '%d-%m-%Y'), 0),
('0035', 'Andrew Phillips', '0641234567', 'andrew.phillips@gmail.com', STR_TO_DATE('11-10-1988', '%d-%m-%Y'), 1),
('0036', 'Laura Turner', '0633456789', 'laura.turner@gmail.com', STR_TO_DATE('05-05-1991', '%d-%m-%Y'), 0),
('0037', 'Kenneth Perez', '0625678901', 'kenneth.perez@gmail.com', STR_TO_DATE('23-07-1983', '%d-%m-%Y'), 0),
('0038', 'Megan Carter', '0617654321', 'megan.carter@gmail.com', STR_TO_DATE('14-09-1996', '%d-%m-%Y'), 1),
('0039', 'Joshua Collins', '0609876543', 'joshua.collins@gmail.com', STR_TO_DATE('20-01-1984', '%d-%m-%Y'), 1),
('0040', 'Sarah Rodriguez', '0591234567', 'sarah.rodriguez@gmail.com', STR_TO_DATE('11-11-1989', '%d-%m-%Y'), 1),
('0041', 'Kevin Williams', '0583456789', 'kevin.williams@gmail.com', STR_TO_DATE('15-02-1985', '%d-%m-%Y'), 1),
('0042', 'Donna Hernandez', '0575678901', 'donna.hernandez@gmail.com', STR_TO_DATE('26-10-1993', '%d-%m-%Y'), 0),
('0043', 'Brian Washington', '0567654321', 'brian.washington@gmail.com', STR_TO_DATE('30-03-1981', '%d-%m-%Y'), 1),
('0044', 'Amy Lee', '0559876543', 'amy.lee@gmail.com', STR_TO_DATE('19-07-1992', '%d-%m-%Y'), 1),
('0045', 'George Nelson', '0541234567', 'george.nelson@gmail.com', STR_TO_DATE('22-12-1984', '%d-%m-%Y'), 1),
('0046', 'Angela Martinez', '0533456789', 'angela.martinez@gmail.com', STR_TO_DATE('09-09-1990', '%d-%m-%Y'), 0),
('0047', 'Edward Sanchez', '0525678901', 'edward.sanchez@gmail.com', STR_TO_DATE('17-12-1986', '%d-%m-%Y'), 1),
('0048', 'Deborah Clark', '0517654321', 'deborah.clark@gmail.com', STR_TO_DATE('02-08-1979', '%d-%m-%Y'), 1),
('0049', 'Ronald Collins', '0509876543', 'ronald.collins@gmail.com', STR_TO_DATE('25-11-1981', '%d-%m-%Y'), 0),
('0050', 'Stephanie Walker', '0491234567', 'stephanie.walker@gmail.com', STR_TO_DATE('05-12-1990', '%d-%m-%Y'), 1),
('0051', 'Timothy Shaw', '0483456789', 'timothy.shaw@gmail.com', STR_TO_DATE('03-07-1988', '%d-%m-%Y'), 0),
('0052', 'Helen Brooks', '0475678901', 'helen.brooks@gmail.com', STR_TO_DATE('16-08-1995', '%d-%m-%Y'), 0),
('0053', 'Jason Richardson', '0467654321', 'jason.richardson@gmail.com', STR_TO_DATE('13-06-1982', '%d-%m-%Y'), 1),
('0054', 'Melissa Lee', '0459876543', 'melissa.lee@gmail.com', STR_TO_DATE('11-01-1994', '%d-%m-%Y'), 1),
('0055', 'Jeffrey Stewart', '0441234567', 'jeffrey.stewart@gmail.com', STR_TO_DATE('04-03-1985', '%d-%m-%Y'), 0),
('0056', 'Amanda Robinson', '0433456789', 'amanda.robinson@gmail.com', STR_TO_DATE('29-09-1991', '%d-%m-%Y'), 1),
('0057', 'Ryan Perry', '0425678901', 'ryan.perry@gmail.com', STR_TO_DATE('18-10-1986', '%d-%m-%Y'), 0),
('0058', 'Carolyn Powell', '0417654321', 'carolyn.powell@gmail.com', STR_TO_DATE('24-12-1988', '%d-%m-%Y'), 0),
('0059', 'Jacob Peterson', '0409876543', 'jacob.peterson@gmail.com', STR_TO_DATE('15-08-1992', '%d-%m-%Y'), 1),
('0060', 'Katherine Jenkins', '0391234567', 'katherine.jenkins@gmail.com', STR_TO_DATE('27-05-1984', '%d-%m-%Y'), 1),
('0061', 'Gary Hayes', '0383456789', 'gary.hayes@gmail.com', STR_TO_DATE('04-04-1983', '%d-%m-%Y'), 1),
('0062', 'Rebecca Evans', '0375678901', 'rebecca.evans@gmail.com', STR_TO_DATE('06-09-1993', '%d-%m-%Y'), 0),
('0063', 'Nicholas Cooper', '0367654321', 'nicholas.cooper@gmail.com', STR_TO_DATE('21-07-1991', '%d-%m-%Y'), 0),
('0064', 'Anna Rivera', '0359876543', 'anna.rivera@gmail.com', STR_TO_DATE('03-01-1989', '%d-%m-%Y'), 1),
('0065', 'Eric Morris', '0341234567', 'eric.morris@gmail.com', STR_TO_DATE('26-05-1982', '%d-%m-%Y'), 1),
('0066', 'Dorothy Murphy', '0333456789', 'dorothy.murphy@gmail.com', STR_TO_DATE('30-09-1978', '%d-%m-%Y'), 0),
('0067', 'Stephen Rogers', '0325678901', 'stephen.rogers@gmail.com', STR_TO_DATE('12-05-1990', '%d-%m-%Y'), 0),
('0068', 'Virginia Reed', '0317654321', 'virginia.reed@gmail.com', STR_TO_DATE('20-06-1987', '%d-%m-%Y'), 0),
('0069', 'Jonathan Cook', '0309876543', 'jonathan.cook@gmail.com', STR_TO_DATE('22-01-1982', '%d-%m-%Y'), 0),
('0070', 'Frances Price', '0291234567', 'frances.price@gmail.com', STR_TO_DATE('16-03-1985', '%d-%m-%Y'), 1),
('0071', 'Larry Richardson', '0283456789', 'larry.richardson@gmail.com', STR_TO_DATE('18-11-1994', '%d-%m-%Y'), 0),
('0072', 'Julie Cox', '0275678901', 'julie.cox@gmail.com', STR_TO_DATE('04-11-1986', '%d-%m-%Y'), 1),
('0073', 'Justin Howard', '0267654321', 'justin.howard@gmail.com', STR_TO_DATE('20-09-1981', '%d-%m-%Y'), 1),
('0074', 'Rachel Flores', '0259876543', 'rachel.flores@gmail.com', STR_TO_DATE('23-03-1991', '%d-%m-%Y'), 0),
('0075', 'Scott Ward', '0241234567', 'scott.ward@gmail.com', STR_TO_DATE('10-10-1983', '%d-%m-%Y'), 1),
('0076', 'Katherine Ramirez', '0233456789', 'katherine.ramirez@gmail.com', STR_TO_DATE('25-06-1988', '%d-%m-%Y'), 0),
('0077', 'Brandon Brooks', '0225678901', 'brandon.brooks@gmail.com', STR_TO_DATE('12-02-1985', '%d-%m-%Y'), 0),
('0078', 'Emily Bell', '0217654321', 'emily.bell@gmail.com', STR_TO_DATE('29-08-1992', '%d-%m-%Y'), 1),
('0079', 'Aaron James', '0209876543', 'aaron.james@gmail.com', STR_TO_DATE('07-03-1986', '%d-%m-%Y'), 1),
('0080', 'Diana Evans', '0191234567', 'diana.evans@gmail.com', STR_TO_DATE('18-09-1987', '%d-%m-%Y'), 0),
('0081', 'Adam Edwards', '0183456789', 'adam.edwards@gmail.com', STR_TO_DATE('24-04-1994', '%d-%m-%Y'), 0),
('0082', 'Stephanie Moore', '0175678901', 'stephanie.moore@gmail.com', STR_TO_DATE('14-10-1989', '%d-%m-%Y'), 1),
('0083', 'Richard Sanders', '0167654321', 'richard.sanders@gmail.com', STR_TO_DATE('02-06-1985', '%d-%m-%Y'), 1),
('0084', 'Cynthia Hughes', '0159876543', 'cynthia.hughes@gmail.com', STR_TO_DATE('17-11-1992', '%d-%m-%Y'), 1),
('0085', 'Wayne Willis', '0141234567', 'wayne.willis@gmail.com', STR_TO_DATE('08-11-1979', '%d-%m-%Y'), 1),
('0086', 'Teresa Foster', '0133456789', 'teresa.foster@gmail.com', STR_TO_DATE('03-08-1982', '%d-%m-%Y'), 1),
('0087', 'Randy Jenkins', '0125678901', 'randy.jenkins@gmail.com', STR_TO_DATE('13-06-1990', '%d-%m-%Y'), 0),
('0088', 'Pamela Gonzalez', '0117654321', 'pamela.gonzalez@gmail.com', STR_TO_DATE('22-01-1993', '%d-%m-%Y'), 0),
('0089', 'Zachary Brown', '0109876543', 'zachary.brown@gmail.com', STR_TO_DATE('05-05-1988', '%d-%m-%Y'), 1),
('0090', 'Denise Holmes', '0991234567', 'denise.holmes@gmail.com', STR_TO_DATE('20-12-1984', '%d-%m-%Y'), 1),
('0091', 'Todd Martinez', '0983456789', 'todd.martinez@gmail.com', STR_TO_DATE('09-01-1981', '%d-%m-%Y'), 1),
('0092', 'Carolyn Ward', '0975678901', 'carolyn.ward@gmail.com', STR_TO_DATE('14-10-1992', '%d-%m-%Y'), 1),
('0093', 'Frank Watson', '0967654321', 'frank.watson@gmail.com', STR_TO_DATE('18-07-1980', '%d-%m-%Y'), 1),
('0094', 'Brenda Ward', '0959876543', 'brenda.ward@gmail.com', STR_TO_DATE('23-04-1989', '%d-%m-%Y'), 1),
('0095', 'Johnny Perry', '0941234567', 'johnny.perry@gmail.com', STR_TO_DATE('27-11-1983', '%d-%m-%Y'), 1),
('0096', 'Amy Hughes', '0933456789', 'amy.hughes@gmail.com', STR_TO_DATE('03-07-1991', '%d-%m-%Y'), 0),
('0097', 'Billy Hall', '0925678901', 'billy.hall@gmail.com', STR_TO_DATE('29-08-1985', '%d-%m-%Y'), 1),
('0098', 'Kelly Riley', '0917654321', 'kelly.riley@gmail.com', STR_TO_DATE('06-06-1994', '%d-%m-%Y'), 0),
('0099', 'Carl Brown', '0909876543', 'carl.brown@gmail.com', STR_TO_DATE('19-09-1982', '%d-%m-%Y'), 1),
('0100', 'Laura Chavez', '0891234567', 'laura.chavez@gmail.com', STR_TO_DATE('30-12-1986', '%d-%m-%Y'), 1),
('0101', 'Bobby Rivera', '0883456789', 'bobby.rivera@gmail.com', STR_TO_DATE('15-01-1990', '%d-%m-%Y'), 1),
('0102', 'Julia Ramos', '0875678901', 'julia.ramos@gmail.com', STR_TO_DATE('21-03-1992', '%d-%m-%Y'), 0),
('0103', 'Bruce Berry', '0867654321', 'bruce.berry@gmail.com', STR_TO_DATE('14-08-1987', '%d-%m-%Y'), 0),
('0104', 'Sharon Mills', '0859876543', 'sharon.mills@gmail.com', STR_TO_DATE('11-04-1984', '%d-%m-%Y'), 1),
('0105', 'Roger Howard', '0841234567', 'roger.howard@gmail.com', STR_TO_DATE('17-04-1986', '%d-%m-%Y'), 0),
('0106', 'Katherine Adams', '0833456789', 'katherine.adams@gmail.com', STR_TO_DATE('06-08-1990', '%d-%m-%Y'), 1),
('0107', 'Scott Hernandez', '0825678901', 'scott.hernandez@gmail.com', STR_TO_DATE('19-11-1991', '%d-%m-%Y'), 1),
('0108', 'Amanda Fisher', '0817654321', 'amanda.fisher@gmail.com', STR_TO_DATE('02-12-1993', '%d-%m-%Y'), 0),
('0109', 'Keith Butler', '0809876543', 'keith.butler@gmail.com', STR_TO_DATE('05-10-1989', '%d-%m-%Y'), 1),
('0110', 'Jennifer Edwards', '0791234567', 'jennifer.edwards@gmail.com', STR_TO_DATE('03-02-1988', '%d-%m-%Y'), 1),
('0111', 'Robert Kelly', '0783456789', 'robert.kelly@gmail.com', STR_TO_DATE('30-09-1983', '%d-%m-%Y'), 1),
('0112', 'Theresa Coleman', '0775678901', 'theresa.coleman@gmail.com', STR_TO_DATE('16-12-1990', '%d-%m-%Y'), 0),
('0113', 'Phillip Ward', '0767654321', 'phillip.ward@gmail.com', STR_TO_DATE('08-09-1992', '%d-%m-%Y'), 1),
('0114', 'Barbara Hughes', '0759876543', 'barbara.hughes@gmail.com', STR_TO_DATE('22-05-1984', '%d-%m-%Y'), 1),
('0115', 'John Jenkins', '0741234567', 'john.jenkins@gmail.com', STR_TO_DATE('07-03-1981', '%d-%m-%Y'), 0),
('0116', 'Sandra Cox', '0733456789', 'sandra.cox@gmail.com', STR_TO_DATE('24-11-1992', '%d-%m-%Y'), 1),
('0117', 'Zachary Lee', '0725678901', 'zachary.lee@gmail.com', STR_TO_DATE('08-07-1987', '%d-%m-%Y'), 1),
('0118', 'Debra Richardson', '0717654321', 'debra.richardson@gmail.com', STR_TO_DATE('22-12-1985', '%d-%m-%Y'), 0),
('0119', 'Patrick Nelson', '0709876543', 'patrick.nelson@gmail.com', STR_TO_DATE('28-01-1989', '%d-%m-%Y'), 0),
('0120', 'Stephanie Ward', '0691234567', 'stephanie.ward@gmail.com', STR_TO_DATE('02-09-1990', '%d-%m-%Y'), 0),
('0121', 'Larry Gonzales', '0683456789', 'larry.gonzales@gmail.com', STR_TO_DATE('21-11-1983', '%d-%m-%Y'), 1),
('0122', 'Rebecca Martinez', '0675678901', 'rebecca.martinez@gmail.com', STR_TO_DATE('05-06-1993', '%d-%m-%Y'), 0),
('0123', 'Ryan Reed', '0667654321', 'ryan.reed@gmail.com', STR_TO_DATE('09-03-1992', '%d-%m-%Y'), 1),
('0124', 'Sandra Bailey', '0659876543', 'sandra.bailey@gmail.com', STR_TO_DATE('17-12-1987', '%d-%m-%Y'), 0),
('0125', 'Brian Gonzalez', '0641234567', 'brian.gonzalez@gmail.com', STR_TO_DATE('14-10-1991', '%d-%m-%Y'), 0),
('0126', 'Melissa Long', '0633456789', 'melissa.long@gmail.com', STR_TO_DATE('04-05-1986', '%d-%m-%Y'), 0),
('0127', 'Richard Watson', '0625678901', 'richard.watson@gmail.com', STR_TO_DATE('07-11-1989', '%d-%m-%Y'), 0),
('0128', 'Pamela Ross', '0617654321', 'pamela.ross@gmail.com', STR_TO_DATE('11-02-1984', '%d-%m-%Y'), 0),
('0129', 'Eric Bennett', '0609876543', 'eric.bennett@gmail.com', STR_TO_DATE('19-06-1992', '%d-%m-%Y'), 0),
('0130', 'Carol Russell', '0591234567', 'carol.russell@gmail.com', STR_TO_DATE('16-01-1990', '%d-%m-%Y'), 1),
('0131', 'Jason Patterson', '0583456789', 'jason.patterson@gmail.com', STR_TO_DATE('23-09-1987', '%d-%m-%Y'), 1),
('0132', 'Nicole Diaz', '0575678901', 'nicole.diaz@gmail.com', STR_TO_DATE('28-03-1994', '%d-%m-%Y'), 1),
('0133', 'Benjamin Edwards', '0567654321', 'benjamin.edwards@gmail.com', STR_TO_DATE('13-08-1985', '%d-%m-%Y'), 0),
('0134', 'Teresa Brooks', '0559876543', 'teresa.brooks@gmail.com', STR_TO_DATE('26-04-1990', '%d-%m-%Y'), 1),
('0135', 'Samuel Ward', '0541234567', 'samuel.ward@gmail.com', STR_TO_DATE('22-12-1983', '%d-%m-%Y'), 1),
('0136', 'Helen Powell', '0533456789', 'helen.powell@gmail.com', STR_TO_DATE('07-08-1982', '%d-%m-%Y'), 1),
('0137', 'Joshua Kelly', '0525678901', 'joshua.kelly@gmail.com', STR_TO_DATE('11-10-1994', '%d-%m-%Y'), 0),
('0138', 'Frances Torres', '0517654321', 'frances.torres@gmail.com', STR_TO_DATE('09-12-1986', '%d-%m-%Y'), 0),
('0139', 'Gary Bailey', '0509876543', 'gary.bailey@gmail.com', STR_TO_DATE('29-06-1983', '%d-%m-%Y'), 1),
('0140', 'Cynthia Fisher', '0999876543', 'cynthia.fisher@gmail.com', STR_TO_DATE('20-02-1991', '%d-%m-%Y'), 1),
('0141', 'Justin Rivera', '0981234567', 'justin.rivera@gmail.com', STR_TO_DATE('09-04-1989', '%d-%m-%Y'), 0),
('0142', 'Diana Martinez', '0978765432', 'diana.martinez@gmail.com', STR_TO_DATE('24-12-1987', '%d-%m-%Y'), 1),
('0143', 'Albert Woods', '0962345678', 'albert.woods@gmail.com', STR_TO_DATE('05-11-1984', '%d-%m-%Y'), 0),
('0144', 'Carolyn Jenkins', '0956789012', 'carolyn.jenkins@gmail.com', STR_TO_DATE('19-04-1993', '%d-%m-%Y'), 1),
('0145', 'Anthony Harrison', '0949876543', 'anthony.harrison@gmail.com', STR_TO_DATE('08-09-1988', '%d-%m-%Y'), 0),
('0146', 'Julia Bryant', '0938765432', 'julia.bryant@gmail.com', STR_TO_DATE('10-12-1991', '%d-%m-%Y'), 1),
('0147', 'Steven Howard', '0927654321', 'steven.howard@gmail.com', STR_TO_DATE('03-07-1986', '%d-%m-%Y'), 0),
('0148', 'Amy Powell', '0912345678', 'amy.powell@gmail.com', STR_TO_DATE('25-06-1990', '%d-%m-%Y'), 1),
('0149', 'Joshua Butler', '0903456789', 'joshua.butler@gmail.com', STR_TO_DATE('13-11-1985', '%d-%m-%Y'), 1),
('0150', 'Laura Ward', '0895678901', 'laura.ward@gmail.com', STR_TO_DATE('01-01-1994', '%d-%m-%Y'), 1);

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


INSERT INTO Lease (Lease_ID, Unit_ID, Tenant_ID, Start_Date, End_Date, Monthly_Rent, Deposit) VALUES
('0001', '0001', '0001', STR_TO_DATE('01/01/2023', '%d/%m/%Y'), STR_TO_DATE('01/10/2023', '%d/%m/%Y'), 13.00, 14.00),
('0002', '0002', '0002', STR_TO_DATE('01/02/2023', '%d/%m/%Y'), STR_TO_DATE('01/10/2023', '%d/%m/%Y'), 19.00, 20.00),
('0003', '0003', '0003', STR_TO_DATE('01/03/2023', '%d/%m/%Y'), STR_TO_DATE('01/01/2024', '%d/%m/%Y'), 15.00, 16.00),
('0004', '0004', '0004', STR_TO_DATE('01/04/2023', '%d/%m/%Y'), STR_TO_DATE('01/12/2023', '%d/%m/%Y'), 18.00, 19.00),
('0005', '0005', '0005', STR_TO_DATE('01/05/2023', '%d/%m/%Y'), STR_TO_DATE('01/02/2024', '%d/%m/%Y'), 10.00, 11.00),
('0006', '0006', '0006', STR_TO_DATE('01/06/2023', '%d/%m/%Y'), STR_TO_DATE('01/05/2024', '%d/%m/%Y'), 14.00, 15.00),
('0007', '0007', '0007', STR_TO_DATE('01/07/2023', '%d/%m/%Y'), STR_TO_DATE('01/03/2024', '%d/%m/%Y'), 16.00, 17.00),
('0008', '0008', '0008', STR_TO_DATE('01/08/2023', '%d/%m/%Y'), STR_TO_DATE('01/07/2024', '%d/%m/%Y'), 11.00, 12.00),
('0009', '0009', '0009', STR_TO_DATE('01/09/2023', '%d/%m/%Y'), STR_TO_DATE('01/08/2024', '%d/%m/%Y'), 17.00, 18.00),
('0010', '0010', '0010', STR_TO_DATE('01/10/2023', '%d/%m/%Y'), STR_TO_DATE('01/05/2024', '%d/%m/%Y'), 12.00, 13.00),
('0011', '0011', '0011', STR_TO_DATE('01/11/2023', '%d/%m/%Y'), STR_TO_DATE('01/10/2024', '%d/%m/%Y'), 19.00, 20.00),
('0012', '0012', '0012', STR_TO_DATE('01/12/2023', '%d/%m/%Y'), STR_TO_DATE('01/06/2024', '%d/%m/%Y'), 10.00, 11.00),
('0013', '0013', '0013', STR_TO_DATE('01/01/2023', '%d/%m/%Y'), STR_TO_DATE('01/11/2023', '%d/%m/%Y'), 15.00, 16.00),
('0014', '0014', '0014', STR_TO_DATE('01/02/2023', '%d/%m/%Y'), STR_TO_DATE('01/09/2023', '%d/%m/%Y'), 13.00, 14.00),
('0015', '0015', '0015', STR_TO_DATE('01/03/2023', '%d/%m/%Y'), STR_TO_DATE('01/12/2023', '%d/%m/%Y'), 14.00, 15.00),
('0016', '0016', '0016', STR_TO_DATE('01/04/2023', '%d/%m/%Y'), STR_TO_DATE('01/10/2023', '%d/%m/%Y'), 17.00, 18.00),
('0017', '0017', '0017', STR_TO_DATE('01/05/2023', '%d/%m/%Y'), STR_TO_DATE('01/11/2023', '%d/%m/%Y'), 10.00, 11.00),
('0018', '0018', '0018', STR_TO_DATE('01/06/2023', '%d/%m/%Y'), STR_TO_DATE('01/04/2024', '%d/%m/%Y'), 16.00, 17.00),
('0019', '0019', '0019', STR_TO_DATE('01/07/2023', '%d/%m/%Y'), STR_TO_DATE('01/03/2024', '%d/%m/%Y'), 20.00, 20.00),
('0020', '0020', '0020', STR_TO_DATE('01/08/2023', '%d/%m/%Y'), STR_TO_DATE('01/06/2024', '%d/%m/%Y'), 13.00, 14.00),
('0021', '0021', '0021', STR_TO_DATE('01/09/2023', '%d/%m/%Y'), STR_TO_DATE('01/07/2024', '%d/%m/%Y'), 19.00, 20.00),
('0022', '0022', '0022', STR_TO_DATE('01/10/2023', '%d/%m/%Y'), STR_TO_DATE('01/03/2024', '%d/%m/%Y'), 18.00, 19.00),
('0023', '0023', '0023', STR_TO_DATE('01/11/2023', '%d/%m/%Y'), STR_TO_DATE('01/05/2024', '%d/%m/%Y'), 12.00, 13.00),
('0024', '0024', '0024', STR_TO_DATE('01/12/2023', '%d/%m/%Y'), STR_TO_DATE('01/06/2024', '%d/%m/%Y'), 14.00, 15.00),
('0025', '0025', '0025', STR_TO_DATE('01/01/2023', '%d/%m/%Y'), STR_TO_DATE('01/07/2023', '%d/%m/%Y'), 16.00, 17.00),
('0026', '0026', '0026', STR_TO_DATE('01/02/2023', '%d/%m/%Y'), STR_TO_DATE('01/11/2023', '%d/%m/%Y'), 11.00, 12.00),
('0027', '0027', '0027', STR_TO_DATE('01/03/2023', '%d/%m/%Y'), STR_TO_DATE('01/12/2023', '%d/%m/%Y'), 17.00, 18.00),
('0028', '0028', '0028', STR_TO_DATE('01/04/2023', '%d/%m/%Y'), STR_TO_DATE('01/03/2024', '%d/%m/%Y'), 15.00, 16.00),
('0029', '0029', '0029', STR_TO_DATE('01/05/2023', '%d/%m/%Y'), STR_TO_DATE('01/12/2023', '%d/%m/%Y'), 19.00, 20.00),
('0030', '0030', '0030', STR_TO_DATE('01/06/2023', '%d/%m/%Y'), STR_TO_DATE('01/12/2023', '%d/%m/%Y'), 13.00, 14.00),
('0031', '0031', '0031', STR_TO_DATE('01/07/2023', '%d/%m/%Y'), STR_TO_DATE('01/03/2024', '%d/%m/%Y'), 10.00, 11.00),
('0032', '0032', '0032', STR_TO_DATE('01/08/2023', '%d/%m/%Y'), STR_TO_DATE('01/03/2024', '%d/%m/%Y'), 18.00, 19.00),
('0033', '0033', '0033', STR_TO_DATE('01/09/2023', '%d/%m/%Y'), STR_TO_DATE('01/06/2024', '%d/%m/%Y'), 12.00, 13.00),
('0034', '0034', '0034', STR_TO_DATE('01/10/2023', '%d/%m/%Y'), STR_TO_DATE('01/05/2024', '%d/%m/%Y'), 14.00, 15.00),
('0035', '0035', '0035', STR_TO_DATE('01/11/2023', '%d/%m/%Y'), STR_TO_DATE('01/05/2024', '%d/%m/%Y'), 11.00, 12.00),
('0036', '0036', '0036', STR_TO_DATE('01/12/2023', '%d/%m/%Y'), STR_TO_DATE('01/10/2024', '%d/%m/%Y'), 20.00, 20.00),
('0037', '0037', '0037', STR_TO_DATE('01/01/2023', '%d/%m/%Y'), STR_TO_DATE('01/12/2023', '%d/%m/%Y'), 16.00, 17.00),
('0038', '0038', '0038', STR_TO_DATE('01/02/2023', '%d/%m/%Y'), STR_TO_DATE('01/12/2023', '%d/%m/%Y'), 15.00, 16.00),
('0039', '0039', '0039', STR_TO_DATE('01/03/2023', '%d/%m/%Y'), STR_TO_DATE('01/09/2023', '%d/%m/%Y'), 17.00, 18.00),
('0040', '0040', '0040', STR_TO_DATE('01/04/2023', '%d/%m/%Y'), STR_TO_DATE('01/10/2023', '%d/%m/%Y'), 19.00, 20.00),
('0041', '0041', '0041', STR_TO_DATE('01/05/2023', '%d/%m/%Y'), STR_TO_DATE('01/10/2023', '%d/%m/%Y'), 12.00, 13.00),
('0042', '0042', '0042', STR_TO_DATE('01/06/2023', '%d/%m/%Y'), STR_TO_DATE('01/05/2024', '%d/%m/%Y'), 13.00, 14.00),
('0043', '0043', '0043', STR_TO_DATE('01/07/2023', '%d/%m/%Y'), STR_TO_DATE('01/04/2024', '%d/%m/%Y'), 11.00, 12.00),
('0044', '0044', '0044', STR_TO_DATE('01/08/2023', '%d/%m/%Y'), STR_TO_DATE('01/03/2024', '%d/%m/%Y'), 18.00, 19.00),
('0045', '0045', '0045', STR_TO_DATE('01/09/2023', '%d/%m/%Y'), STR_TO_DATE('01/07/2024', '%d/%m/%Y'), 14.00, 15.00),
('0046', '0046', '0046', STR_TO_DATE('01/10/2023', '%d/%m/%Y'), STR_TO_DATE('01/04/2024', '%d/%m/%Y'), 10.00, 11.00),
('0047', '0047', '0047', STR_TO_DATE('01/11/2023', '%d/%m/%Y'), STR_TO_DATE('01/05/2024', '%d/%m/%Y'), 20.00, 20.00),
('0048', '0048', '0048', STR_TO_DATE('01/12/2023', '%d/%m/%Y'), STR_TO_DATE('01/09/2024', '%d/%m/%Y'), 17.00, 18.00),
('0049', '0049', '0049', STR_TO_DATE('01/01/2023', '%d/%m/%Y'), STR_TO_DATE('01/11/2023', '%d/%m/%Y'), 15.00, 16.00),
('0050', '0050', '0050', STR_TO_DATE('01/02/2023', '%d/%m/%Y'), STR_TO_DATE('01/10/2023', '%d/%m/%Y'), 13.00, 14.00),
('0051', '0051', '0051', STR_TO_DATE('01/03/2023', '%d/%m/%Y'), STR_TO_DATE('01/12/2023', '%d/%m/%Y'), 16.00, 17.00),
('0052', '0052', '0052', STR_TO_DATE('01/04/2023', '%d/%m/%Y'), STR_TO_DATE('01/01/2024', '%d/%m/%Y'), 19.00, 20.00),
('0053', '0053', '0053', STR_TO_DATE('01/05/2023', '%d/%m/%Y'), STR_TO_DATE('01/03/2024', '%d/%m/%Y'), 11.00, 12.00),
('0054', '0054', '0054', STR_TO_DATE('01/06/2023', '%d/%m/%Y'), STR_TO_DATE('01/05/2024', '%d/%m/%Y'), 18.00, 19.00),
('0055', '0055', '0055', STR_TO_DATE('01/07/2023', '%d/%m/%Y'), STR_TO_DATE('01/01/2024', '%d/%m/%Y'), 12.00, 13.00),
('0056', '0056', '0056', STR_TO_DATE('01/08/2023', '%d/%m/%Y'), STR_TO_DATE('01/02/2024', '%d/%m/%Y'), 17.00, 18.00),
('0057', '0057', '0057', STR_TO_DATE('01/09/2023', '%d/%m/%Y'), STR_TO_DATE('01/03/2024', '%d/%m/%Y'), 10.00, 11.00),
('0058', '0058', '0058', STR_TO_DATE('01/10/2023', '%d/%m/%Y'), STR_TO_DATE('01/07/2024', '%d/%m/%Y'), 14.00, 15.00),
('0059', '0059', '0059', STR_TO_DATE('01/11/2023', '%d/%m/%Y'), STR_TO_DATE('01/09/2024', '%d/%m/%Y'), 20.00, 20.00),
('0060', '0060', '0060', STR_TO_DATE('01/12/2023', '%d/%m/%Y'), STR_TO_DATE('01/07/2024', '%d/%m/%Y'), 13.00, 14.00),
('0061', '0061', '0061', STR_TO_DATE('01/01/2023', '%d/%m/%Y'), STR_TO_DATE('01/10/2023', '%d/%m/%Y'), 19.00, 20.00),
('0062', '0062', '0062', STR_TO_DATE('01/02/2023', '%d/%m/%Y'), STR_TO_DATE('01/02/2024', '%d/%m/%Y'), 11.00, 12.00),
('0063', '0063', '0063', STR_TO_DATE('01/03/2023', '%d/%m/%Y'), STR_TO_DATE('01/01/2024', '%d/%m/%Y'), 16.00, 17.00),
('0064', '0064', '0064', STR_TO_DATE('01/04/2023', '%d/%m/%Y'), STR_TO_DATE('01/10/2023', '%d/%m/%Y'), 15.00, 16.00),
('0065', '0065', '0065', STR_TO_DATE('01/05/2023', '%d/%m/%Y'), STR_TO_DATE('01/12/2023', '%d/%m/%Y'), 18.00, 19.00),
('0066', '0066', '0066', STR_TO_DATE('01/06/2023', '%d/%m/%Y'), STR_TO_DATE('01/12/2023', '%d/%m/%Y'), 12.00, 13.00),
('0067', '0067', '0067', STR_TO_DATE('01/07/2023', '%d/%m/%Y'), STR_TO_DATE('01/01/2024', '%d/%m/%Y'), 17.00, 18.00),
('0068', '0068', '0068', STR_TO_DATE('01/08/2023', '%d/%m/%Y'), STR_TO_DATE('01/06/2024', '%d/%m/%Y'), 10.00, 11.00),
('0069', '0069', '0069', STR_TO_DATE('01/09/2023', '%d/%m/%Y'), STR_TO_DATE('01/04/2024', '%d/%m/%Y'), 14.00, 15.00),
('0070', '0070', '0070', STR_TO_DATE('01/10/2023', '%d/%m/%Y'), STR_TO_DATE('01/09/2024', '%d/%m/%Y'), 20.00, 20.00),
('0071', '0071', '0071', STR_TO_DATE('01/11/2023', '%d/%m/%Y'), STR_TO_DATE('01/06/2024', '%d/%m/%Y'), 16.00, 17.00),
('0072', '0072', '0072', STR_TO_DATE('01/12/2023', '%d/%m/%Y'), STR_TO_DATE('01/10/2024', '%d/%m/%Y'), 13.00, 14.00),
('0073', '0073', '0073', STR_TO_DATE('01/01/2023', '%d/%m/%Y'), STR_TO_DATE('01/07/2023', '%d/%m/%Y'), 15.00, 16.00),
('0074', '0074', '0074', STR_TO_DATE('01/02/2023', '%d/%m/%Y'), STR_TO_DATE('01/11/2023', '%d/%m/%Y'), 19.00, 20.00),
('0075', '0075', '0075', STR_TO_DATE('01/03/2023', '%d/%m/%Y'), STR_TO_DATE('01/12/2023', '%d/%m/%Y'), 11.00, 12.00);

INSERT INTO Payment (Payment_ID, Lease_ID, Date, Amount, Payment_Type)
VALUES
('0001', '0001', STR_TO_DATE('10-02-2023', '%d-%m-%Y'), '0', 'direct debit'),
('0002', '0001', STR_TO_DATE('15-05-2023', '%d-%m-%Y'), '0', 'mobile payment'),
('0003', '0002', STR_TO_DATE('10-03-2023', '%d-%m-%Y'), '0', 'direct debit'),
('0004', '0003', STR_TO_DATE('10-04-2023', '%d-%m-%Y'), '0', 'mobile payment'),
('0005', '0003', STR_TO_DATE('15-05-2023', '%d-%m-%Y'), '0', 'mobile payment'),
('0006', '0003', STR_TO_DATE('13-07-2023', '%d-%m-%Y'), '0', 'direct debit'),
('0007', '0004', STR_TO_DATE('10-05-2023', '%d-%m-%Y'), '0', 'mobile payment'),
('0008', '0004', STR_TO_DATE('12-06-2023', '%d-%m-%Y'), '0', 'mobile payment'),
('0009', '0004', STR_TO_DATE('12-08-2023', '%d-%m-%Y'), '0', 'electronic payment'),
('0010', '0004', STR_TO_DATE('15-09-2023', '%d-%m-%Y'), '0', 'direct debit'),
('0011', '0005', STR_TO_DATE('10-06-2023', '%d-%m-%Y'), '0', 'mobile payment'),
('0012', '0005', STR_TO_DATE('12-12-2023', '%d-%m-%Y'), '0', 'direct payment'),
('0013', '0006', STR_TO_DATE('12-07-2023', '%d-%m-%Y'), '0', 'electronic payment'),
('0014', '0006', STR_TO_DATE('15-09-2023', '%d-%m-%Y'), '0', 'mobile payment'),
('0015', '0007', STR_TO_DATE('10-07-2023', '%d-%m-%Y'), '0', 'mobile payment'),
('0016', '0007', STR_TO_DATE('15-12-2023', '%d-%m-%Y'), '0', 'direct payment'),
('0017', '0008', STR_TO_DATE('10-08-2023', '%d-%m-%Y'), '0', 'electronic payment'),
('0018', '0008', STR_TO_DATE('15-10-2023', '%d-%m-%Y'), '0', 'electronic payment'),
('0019', '0008', STR_TO_DATE('10-01-2024', '%d-%m-%Y'), '0', 'electronic payment'),
('0020', '0008', STR_TO_DATE('10-02-2024', '%d-%m-%Y'), '0', 'mobile payment'),
('0021', '0009', STR_TO_DATE('10-09-2023', '%d-%m-%Y'), '0', 'direct payment'),
('0022', '0009', STR_TO_DATE('12-10-2023', '%d-%m-%Y'), '0', 'electronic payment'),
('0023', '0009', STR_TO_DATE('12-11-2023', '%d-%m-%Y'), '0', 'direct debit'),
('0024', '0009', STR_TO_DATE('14-12-2023', '%d-%m-%Y'), '0', 'electronic payment'),
('0025', '0009', STR_TO_DATE('15-01-2024', '%d-%m-%Y'), '0', 'electronic payment'),
('0026', '0010', STR_TO_DATE('10-01-2023', '%d-%m-%Y'), '0', 'direct debit'),
('0027', '0010', STR_TO_DATE('10-02-2023', '%d-%m-%Y'), '0', 'electronic payment'),
('0028', '0010', STR_TO_DATE('12-03-2023', '%d-%m-%Y'), '0', 'direct payment'),
('0029', '0010', STR_TO_DATE('13-11-2023', '%d-%m-%Y'), '0', 'electronic payment'),
('0030', '0010', STR_TO_DATE('15-12-2023', '%d-%m-%Y'), '0', 'direct payment'),
('0031', '0011', STR_TO_DATE('12-06-2024', '%d-%m-%Y'), '0', 'direct payment'),
('0032', '0011', STR_TO_DATE('15-08-2024', '%d-%m-%Y'), '0', 'direct payment'),
('0033', '0011', STR_TO_DATE('10-09-2024', '%d-%m-%Y'), '0', 'direct payment'),
('0034', '0012', STR_TO_DATE('12-12-2023', '%d-%m-%Y'), '0', 'mobile payment'),
('0035', '0012', STR_TO_DATE('12-03-2024', '%d-%m-%Y'), '0', 'electronic payment'),
('0036', '0013', STR_TO_DATE('15-07-2023', '%d-%m-%Y'), '0', 'direct debit'),
('0037', '0013', STR_TO_DATE('10-09-2023', '%d-%m-%Y'), '0', 'direct payment'),
('0038', '0014', STR_TO_DATE('15-03-2023', '%d-%m-%Y'), '0', 'electronic payment'),
('0039', '0014', STR_TO_DATE('10-07-2023', '%d-%m-%Y'), '0', 'direct payment'),
('0040', '0014', STR_TO_DATE('15-08-2023', '%d-%m-%Y'), '0', 'electronic payment'),
('0041', '0015', STR_TO_DATE('10-04-2023', '%d-%m-%Y'), '0', 'electronic payment'),
('0042', '0015', STR_TO_DATE('10-05-2023', '%d-%m-%Y'), '0', 'mobile payment'),
('0043', '0016', STR_TO_DATE('10-05-2023', '%d-%m-%Y'), '0', 'mobile payment'),
('0044', '0016', STR_TO_DATE('12-06-2023', '%d-%m-%Y'), '0', 'direct debit'),
('0045', '0016', STR_TO_DATE('12-07-2023', '%d-%m-%Y'), '0', 'electronic payment'),
('0046', '0017', STR_TO_DATE('14-05-2023', '%d-%m-%Y'), '0', 'direct debit'),
('0047', '0017', STR_TO_DATE('10-07-2023', '%d-%m-%Y'), '0', 'direct payment'),
('0048', '0017', STR_TO_DATE('15-09-2023', '%d-%m-%Y'), '0', 'direct debit'),
('0049', '0018', STR_TO_DATE('13-07-2023', '%d-%m-%Y'), '0', 'direct debit'),
('0050', '0019', STR_TO_DATE('10-07-2023', '%d-%m-%Y'), '0', 'direct debit'),
('0051', '0019', STR_TO_DATE('12-08-2023', '%d-%m-%Y'), '0', 'mobile payment'),
('0052', '0019', STR_TO_DATE('12-09-2023', '%d-%m-%Y'), '0', 'electronic payment'),
('0053', '0019', STR_TO_DATE('15-10-2023', '%d-%m-%Y'), '0', 'electronic payment'),
('0054', '0019', STR_TO_DATE('10-11-2023', '%d-%m-%Y'), '0', 'mobile payment'),
('0055', '0020', STR_TO_DATE('12-09-2023', '%d-%m-%Y'), '0', 'electronic payment'),
('0056', '0020', STR_TO_DATE('12-10-2023', '%d-%m-%Y'), '0', 'direct debit'),
('0057', '0020', STR_TO_DATE('12-12-2023', '%d-%m-%Y'), '0', 'direct payment'),
('0058', '0021', STR_TO_DATE('10-09-2023', '%d-%m-%Y'), '0', 'direct payment'),
('0059', '0021', STR_TO_DATE('15-12-2023', '%d-%m-%Y'), '0', 'direct debit'),
('0060', '0022', STR_TO_DATE('10-10-2023', '%d-%m-%Y'), '0', 'mobile payment'),
('0061', '0022', STR_TO_DATE('15-11-2023', '%d-%m-%Y'), '0', 'mobile payment'),
('0062', '0022', STR_TO_DATE('10-01-2024', '%d-%m-%Y'), '0', 'mobile payment'),
('0063', '0022', STR_TO_DATE('10-02-2024', '%d-%m-%Y'), '0', 'direct payment'),
('0064', '0023', STR_TO_DATE('12-10-2023', '%d-%m-%Y'), '0', 'electronic payment'),
('0065', '0023', STR_TO_DATE('12-11-2023', '%d-%m-%Y'), '0', 'direct debit'),
('0066', '0023', STR_TO_DATE('12-12-2023', '%d-%m-%Y'), '0', 'direct payment'),
('0067', '0024', STR_TO_DATE('14-12-2023', '%d-%m-%Y'), '0', 'mobile payment'),
('0068', '0024', STR_TO_DATE('10-01-2024', '%d-%m-%Y'), '0', 'direct debit'),
('0069', '0024', STR_TO_DATE('15-02-2024', '%d-%m-%Y'), '0', 'mobile payment'),
('0070', '0024', STR_TO_DATE('13-04-2024', '%d-%m-%Y'), '0', 'mobile payment'),
('0071', '0024', STR_TO_DATE('10-05-2024', '%d-%m-%Y'), '0', 'direct debit'),
('0072', '0025', STR_TO_DATE('12-02-2023', '%d-%m-%Y'), '0', 'mobile payment'),
('0073', '0025', STR_TO_DATE('12-04-2023', '%d-%m-%Y'), '0', 'mobile payment'),
('0074', '0025', STR_TO_DATE('15-06-2023', '%d-%m-%Y'), '0', 'direct payment'),
('0075', '0026', STR_TO_DATE('10-06-2023', '%d-%m-%Y'), '0', 'mobile payment'),
('0076', '0026', STR_TO_DATE('12-10-2023', '%d-%m-%Y'), '0', 'direct payment'),
('0077', '0027', STR_TO_DATE('12-07-2023', '%d-%m-%Y'), '0', 'electronic payment'),
('0078', '0028', STR_TO_DATE('15-07-2023', '%d-%m-%Y'), '0', 'direct debit'),
('0079', '0028', STR_TO_DATE('10-08-2023', '%d-%m-%Y'), '0', 'direct payment'),
('0080', '0028', STR_TO_DATE('15-09-2023', '%d-%m-%Y'), '0', 'mobile payment'),
('0081', '0028', STR_TO_DATE('10-10-2023', '%d-%m-%Y'), '0', 'mobile payment'),
('0082', '0028', STR_TO_DATE('15-12-2023', '%d-%m-%Y'), '0', 'direct payment'),
('0083', '0029', STR_TO_DATE('10-06-2023', '%d-%m-%Y'), '0', 'mobile payment'),
('0084', '0029', STR_TO_DATE('10-07-2023', '%d-%m-%Y'), '0', 'direct debit'),
('0085', '0030', STR_TO_DATE('10-09-2023', '%d-%m-%Y'), '0', 'electronic payment'),
('0086', '0031', STR_TO_DATE('12-10-2023', '%d-%m-%Y'), '0', 'direct debit'),
('0087', '0031', STR_TO_DATE('12-11-2023', '%d-%m-%Y'), '0', 'direct debit'),
('0088', '0031', STR_TO_DATE('14-12-2023', '%d-%m-%Y'), '0', 'mobile payment'),
('0089', '0031', STR_TO_DATE('10-02-2024', '%d-%m-%Y'), '0', 'mobile payment'),
('0090', '0032', STR_TO_DATE('15-01-2024', '%d-%m-%Y'), '0', 'electronic payment'),
('0091', '0033', STR_TO_DATE('13-09-2023', '%d-%m-%Y'), '0', 'direct debit'),
('0092', '0033', STR_TO_DATE('10-10-2023', '%d-%m-%Y'), '0', 'direct payment'),
('0093', '0034', STR_TO_DATE('12-11-2023', '%d-%m-%Y'), '0', 'electronic payment'),
('0094', '0034', STR_TO_DATE('12-12-2023', '%d-%m-%Y'), '0', 'electronic payment'),
('0095', '0034', STR_TO_DATE('15-01-2024', '%d-%m-%Y'), '0', 'direct debit'),
('0096', '0034', STR_TO_DATE('10-02-2024', '%d-%m-%Y'), '0', 'electronic payment'),
('0097', '0035', STR_TO_DATE('12-12-2023', '%d-%m-%Y'), '0', 'direct payment'),
('0098', '0035', STR_TO_DATE('12-02-2024', '%d-%m-%Y'), '0', 'electronic payment'),
('0099', '0036', STR_TO_DATE('15-07-2024', '%d-%m-%Y'), '0', 'direct debit'),
('0100', '0036', STR_TO_DATE('10-09-2024', '%d-%m-%Y'), '0', 'direct debit'),
('0101', '0037', STR_TO_DATE('10-08-2023', '%d-%m-%Y'), '0', 'direct payment'),
('0102', '0037', STR_TO_DATE('15-10-2023', '%d-%m-%Y'), '0', 'electronic payment'),
('0103', '0037', STR_TO_DATE('15-11-2023', '%d-%m-%Y'), '0', 'direct payment'),
('0104', '0038', STR_TO_DATE('10-02-2023', '%d-%m-%Y'), '0', 'electronic payment'),
('0105', '0038', STR_TO_DATE('10-03-2023', '%d-%m-%Y'), '0', 'direct payment'),
('0106', '0038', STR_TO_DATE('10-09-2023', '%d-%m-%Y'), '0', 'electronic payment'),
('0107', '0039', STR_TO_DATE('12-05-2023', '%d-%m-%Y'), '0', 'mobile payment'),
('0108', '0039', STR_TO_DATE('12-06-2023', '%d-%m-%Y'), '0', 'electronic payment'),
('0109', '0040', STR_TO_DATE('14-06-2023', '%d-%m-%Y'), '0', 'mobile payment'),
('0110', '0041', STR_TO_DATE('10-06-2023', '%d-%m-%Y'), '0', 'mobile payment'),
('0111', '0041', STR_TO_DATE('15-05-2023', '%d-%m-%Y'), '0', 'direct debit'),
('0112', '0042', STR_TO_DATE('13-07-2023', '%d-%m-%Y'), '0', 'electronic payment'),
('0113', '0042', STR_TO_DATE('10-08-2023', '%d-%m-%Y'), '0', 'direct debit'),
('0114', '0042', STR_TO_DATE('12-09-2023', '%d-%m-%Y'), '0', 'electronic payment'),
('0115', '0043', STR_TO_DATE('12-08-2023', '%d-%m-%Y'), '0', 'direct payment'),
('0116', '0043', STR_TO_DATE('15-09-2023', '%d-%m-%Y'), '0', 'direct payment'),
('0117', '0043', STR_TO_DATE('10-10-2023', '%d-%m-%Y'), '0', 'direct payment'),
('0118', '0043', STR_TO_DATE('12-12-2023', '%d-%m-%Y'), '0', 'direct debit'),
('0119', '0043', STR_TO_DATE('12-11-2023', '%d-%m-%Y'), '0', 'mobile payment'),
('0120', '0044', STR_TO_DATE('15-09-2023', '%d-%m-%Y'), '0', 'direct debit'),
('0121', '0044', STR_TO_DATE('10-10-2023', '%d-%m-%Y'), '0', 'electronic payment'),
('0122', '0044', STR_TO_DATE('15-12-2023', '%d-%m-%Y'), '0', 'mobile payment'),
('0123', '0045', STR_TO_DATE('10-09-2023', '%d-%m-%Y'), '0', 'electronic payment'),
('0124', '0045', STR_TO_DATE('15-10-2023', '%d-%m-%Y'), '0', 'direct debit'),
('0125', '0045', STR_TO_DATE('10-01-2024', '%d-%m-%Y'), '0', 'mobile payment'),
('0126', '0045', STR_TO_DATE('10-02-2024', '%d-%m-%Y'), '0', 'direct payment'),
('0127', '0046', STR_TO_DATE('12-10-2023', '%d-%m-%Y'), '0', 'direct debit'),
('0128', '0046', STR_TO_DATE('12-11-2023', '%d-%m-%Y'), '0', 'electronic payment'),
('0129', '0046', STR_TO_DATE('12-12-2023', '%d-%m-%Y'), '0', 'direct payment'),
('0130', '0047', STR_TO_DATE('14-12-2023', '%d-%m-%Y'), '0', 'direct payment'),
('0131', '0047', STR_TO_DATE('10-03-2024', '%d-%m-%Y'), '0', 'direct debit'),
('0132', '0048', STR_TO_DATE('15-05-2024', '%d-%m-%Y'), '0', 'direct payment'),
('0133', '0048', STR_TO_DATE('13-07-2024', '%d-%m-%Y'), '0', 'mobile payment'),
('0134', '0049', STR_TO_DATE('10-05-2023', '%d-%m-%Y'), '0', 'direct debit'),
('0135', '0049', STR_TO_DATE('12-06-2023', '%d-%m-%Y'), '0', 'mobile payment'),
('0136', '0050', STR_TO_DATE('12-08-2023', '%d-%m-%Y'), '0', 'direct payment'),
('0137', '0050', STR_TO_DATE('15-09-2023', '%d-%m-%Y'), '0', 'electronic payment'),
('0138', '0051', STR_TO_DATE('10-06-2023', '%d-%m-%Y'), '0', 'direct payment'),
('0139', '0051', STR_TO_DATE('12-07-2023', '%d-%m-%Y'), '0', 'direct payment'),
('0140', '0052', STR_TO_DATE('12-07-2023', '%d-%m-%Y'), '0', 'direct debit'),
('0141', '0052', STR_TO_DATE('15-09-2023', '%d-%m-%Y'), '0', 'direct debit'),
('0142', '0053', STR_TO_DATE('10-07-2023', '%d-%m-%Y'), '0', 'direct payment'),
('0143', '0053', STR_TO_DATE('10-08-2023', '%d-%m-%Y'), '0', 'mobile payment'),
('0144', '0053', STR_TO_DATE('15-12-2023', '%d-%m-%Y'), '0', 'electronic payment'),
('0145', '0054', STR_TO_DATE('10-09-2023', '%d-%m-%Y'), '0', 'mobile payment'),
('0146', '0054', STR_TO_DATE('10-10-2023', '%d-%m-%Y'), '0', 'direct payment'),
('0147', '0054', STR_TO_DATE('10-01-2024', '%d-%m-%Y'), '0', 'direct payment'),
('0148', '0054', STR_TO_DATE('10-02-2024', '%d-%m-%Y'), '0', 'electronic payment'),
('0149', '0055', STR_TO_DATE('12-10-2023', '%d-%m-%Y'), '0', 'direct debit'),
('0150', '0056', STR_TO_DATE('10-09-2023', '%d-%m-%Y'), '0', 'mobile payment'),
('0151', '0056', STR_TO_DATE('11-10-2023', '%d-%m-%Y'), '0', 'direct debit'),
('0152', '0056', STR_TO_DATE('12-11-2023', '%d-%m-%Y'), '0', 'direct debit'),
('0153', '0056', STR_TO_DATE('14-12-2023', '%d-%m-%Y'), '0', 'direct debit'),
('0154', '0056', STR_TO_DATE('13-01-2024', '%d-%m-%Y'), '0', 'direct debit'),
('0155', '0057', STR_TO_DATE('10-09-2023', '%d-%m-%Y'), '0', 'mobile payment'),
('0156', '0058', STR_TO_DATE('12-10-2023', '%d-%m-%Y'), '0', 'electronic payment'),
('0157', '0058', STR_TO_DATE('12-11-2023', '%d-%m-%Y'), '0', 'direct debit'),
('0158', '0058', STR_TO_DATE('15-12-2023', '%d-%m-%Y'), '0', 'mobile payment'),
('0159', '0059', STR_TO_DATE('10-12-2023', '%d-%m-%Y'), '0', 'direct debit'),
('0160', '0059', STR_TO_DATE('12-06-2024', '%d-%m-%Y'), '0', 'direct payment'),
('0161', '0060', STR_TO_DATE('12-01-2024', '%d-%m-%Y'), '0', 'direct debit'),
('0162', '0060', STR_TO_DATE('15-02-2024', '%d-%m-%Y'), '0', 'direct debit'),
('0163', '0060', STR_TO_DATE('10-05-2024', '%d-%m-%Y'), '0', 'direct debit'),
('0164', '0060', STR_TO_DATE('15-06-2024', '%d-%m-%Y'), '0', 'electronic payment'),
('0165', '0061', STR_TO_DATE('10-03-2023', '%d-%m-%Y'), '0', 'direct debit'),
('0166', '0061', STR_TO_DATE('10-05-2023', '%d-%m-%Y'), '0', 'mobile payment'),
('0167', '0061', STR_TO_DATE('15-08-2023', '%d-%m-%Y'), '0', 'mobile payment'),
('0168', '0062', STR_TO_DATE('10-09-2023', '%d-%m-%Y'), '0', 'mobile payment'),
('0169', '0062', STR_TO_DATE('10-10-2023', '%d-%m-%Y'), '0', 'direct debit'),
('0170', '0062', STR_TO_DATE('12-01-2024', '%d-%m-%Y'), '0', 'electronic payment'),
('0171', '0063', STR_TO_DATE('12-11-2023', '%d-%m-%Y'), '0', 'direct payment'),
('0172', '0063', STR_TO_DATE('14-12-2023', '%d-%m-%Y'), '0', 'electronic payment'),
('0173', '0064', STR_TO_DATE('10-04-2023', '%d-%m-%Y'), '0', 'electronic payment'),
('0174', '0064', STR_TO_DATE('15-05-2023', '%d-%m-%Y'), '0', 'mobile payment'),
('0175', '0065', STR_TO_DATE('13-05-2023', '%d-%m-%Y'), '0', 'direct payment'),
('0176', '0065', STR_TO_DATE('10-07-2023', '%d-%m-%Y'), '0', 'electronic payment'),
('0177', '0066', STR_TO_DATE('12-06-2023', '%d-%m-%Y'), '0', 'mobile payment'),
('0178', '0066', STR_TO_DATE('12-08-2023', '%d-%m-%Y'), '0', 'mobile payment'),
('0179', '0067', STR_TO_DATE('15-09-2023', '%d-%m-%Y'), '0', 'direct debit'),
('0180', '0068', STR_TO_DATE('10-08-2023', '%d-%m-%Y'), '0', 'electronic payment'),
('0181', '0068', STR_TO_DATE('12-09-2023', '%d-%m-%Y'), '0', 'direct debit'),
('0182', '0068', STR_TO_DATE('12-10-2023', '%d-%m-%Y'), '0', 'direct payment'),
('0183', '0068', STR_TO_DATE('12-12-2023', '%d-%m-%Y'), '0', 'direct debit'),
('0184', '0069', STR_TO_DATE('10-12-2023', '%d-%m-%Y'), '0', 'mobile payment'),
('0185', '0070', STR_TO_DATE('15-10-2023', '%d-%m-%Y'), '0', 'direct debit'),
('0186', '0070', STR_TO_DATE('10-12-2023', '%d-%m-%Y'), '0', 'electronic payment'),
('0187', '0070', STR_TO_DATE('10-01-2024', '%d-%m-%Y'), '0', 'electronic payment'),
('0188', '0070', STR_TO_DATE('10-02-2024', '%d-%m-%Y'), '0', 'mobile payment'),
('0189', '0071', STR_TO_DATE('15-08-2024', '%d-%m-%Y'), '0', 'direct payment'),
('0190', '0072', STR_TO_DATE('10-09-2024', '%d-%m-%Y'), '0', 'direct payment'),
('0191', '0073', STR_TO_DATE('12-02-2023', '%d-%m-%Y'), '0', 'electronic payment'),
('0192', '0073', STR_TO_DATE('12-03-2023', '%d-%m-%Y'), '0', 'direct payment'),
('0193', '0073', STR_TO_DATE('14-04-2023', '%d-%m-%Y'), '0', 'direct debit'),
('0194', '0073', STR_TO_DATE('10-05-2023', '%d-%m-%Y'), '0', 'electronic payment'),
('0195', '0074', STR_TO_DATE('15-05-2023', '%d-%m-%Y'), '0', 'direct payment'),
('0196', '0075', STR_TO_DATE('13-07-2023', '%d-%m-%Y'), '0', 'direct payment'),
('0197', '0075', STR_TO_DATE('10-05-2023', '%d-%m-%Y'), '0', 'mobile payment'),
('0198', '0075', STR_TO_DATE('12-06-2023', '%d-%m-%Y'), '0', 'direct payment'),
('0199', '0075', STR_TO_DATE('12-08-2023', '%d-%m-%Y'), '0', 'direct payment'),
('0200', '0075', STR_TO_DATE('15-09-2023', '%d-%m-%Y'), '0', 'direct payment');

INSERT INTO Amenity (Amenity_ID, Property_ID, Amenity_Name, Description)
VALUES
('0001', '0001', 'Swimming Pool', 'NULL'),
('0002', '0002', 'Fitness Center', 'NULL'),
('0003', '0003', 'Playground', 'In door'),
('0004', '0004', 'Community Room', 'NULL'),
('0005', '0005', 'Convenience Store', 'NULL'),
('0006', '0006', 'Restaurant', 'NULL'),
('0007', '0007', 'Pharmacy', 'NULL'),
('0008', '0008', 'Café', 'NULL'),
('0009', '0009', 'Security System ', '24/7'),
('0010', '0010', 'Park', 'NULL'),
('0011', '0011', 'Parking Garage', 'NULL'),
('0012', '0012', 'Laundry Services', 'NULL'),
('0013', '0013', 'Spa', 'NULL'),
('0014', '0014', 'Sports Courts', 'Tennis, Basketball, etc.');

INSERT INTO Booking (Tenant_ID, Amenity_ID, Start_Date, End_Date, Cost)
VALUES
( '0001', '0001', STR_TO_DATE('01-04-2023', '%d-%m-%Y'), STR_TO_DATE('01-05-2023', '%d-%m-%Y'), '12.00'),
( '0003', '0014', STR_TO_DATE('01-05-2023', '%d-%m-%Y'), STR_TO_DATE('01-06-2023', '%d-%m-%Y'), '10.00'),
( '0003', '0004', STR_TO_DATE('01-07-2023', '%d-%m-%Y'), STR_TO_DATE('01-08-2023', '%d-%m-%Y'), '7.00'),
( '0006', '0004', STR_TO_DATE('01-05-2023', '%d-%m-%Y'), STR_TO_DATE('01-06-2023', '%d-%m-%Y'), '7.00'),
( '0008', '0010', STR_TO_DATE('01-06-2023', '%d-%m-%Y'), STR_TO_DATE('01-07-2023', '%d-%m-%Y'), '13.00'),
( '0008', '0001', STR_TO_DATE('01-08-2023', '%d-%m-%Y'), STR_TO_DATE('01-09-2023', '%d-%m-%Y'), '12.00'),
( '0013', '0006', STR_TO_DATE('01-09-2023', '%d-%m-%Y'), STR_TO_DATE('01-10-2023', '%d-%m-%Y'), '15.00'),
( '0018', '0012', STR_TO_DATE('01-06-2023', '%d-%m-%Y'), STR_TO_DATE('01-07-2023', '%d-%m-%Y'), '5.00'),
( '0018', '0005', STR_TO_DATE('01-12-2023', '%d-%m-%Y'), STR_TO_DATE('01-01-2024', '%d-%m-%Y'), '6.00'),
( '0022', '0013', STR_TO_DATE('01-07-2023', '%d-%m-%Y'), STR_TO_DATE('01-08-2023', '%d-%m-%Y'), '18.00'),
( '0022', '0001', STR_TO_DATE('01-09-2023', '%d-%m-%Y'), STR_TO_DATE('01-10-2023', '%d-%m-%Y'), '12.00'),
( '0023', '0010', STR_TO_DATE('01-07-2023', '%d-%m-%Y'), STR_TO_DATE('01-08-2023', '%d-%m-%Y'), '13.00'),
( '0025', '0001', STR_TO_DATE('01-12-2023', '%d-%m-%Y'), STR_TO_DATE('01-01-2024', '%d-%m-%Y'), '12.00'),
( '0028', '0008', STR_TO_DATE('01-08-2023', '%d-%m-%Y'), STR_TO_DATE('01-09-2023', '%d-%m-%Y'), '14.00'),
( '0029', '0007', STR_TO_DATE('01-10-2023', '%d-%m-%Y'), STR_TO_DATE('01-11-2023', '%d-%m-%Y'), '16.00'),
( '0029', '0012', STR_TO_DATE('01-01-2024', '%d-%m-%Y'), STR_TO_DATE('01-02-2024', '%d-%m-%Y'), '5.00'),
( '0030', '0010', STR_TO_DATE('01-02-2024', '%d-%m-%Y'), STR_TO_DATE('01-03-2024', '%d-%m-%Y'), '13.00'),
( '0035', '0006', STR_TO_DATE('01-09-2023', '%d-%m-%Y'), STR_TO_DATE('01-10-2023', '%d-%m-%Y'), '15.00'),
( '0037', '0004', STR_TO_DATE('01-10-2023', '%d-%m-%Y'), STR_TO_DATE('01-11-2023', '%d-%m-%Y'), '7.00'),
( '0038', '0006', STR_TO_DATE('01-11-2023', '%d-%m-%Y'), STR_TO_DATE('01-12-2023', '%d-%m-%Y'), '15.00'),
( '0039', '0011', STR_TO_DATE('01-12-2023', '%d-%m-%Y'), STR_TO_DATE('01-01-2024', '%d-%m-%Y'), '11.00'),
( '0040', '0002', STR_TO_DATE('01-01-2024', '%d-%m-%Y'), STR_TO_DATE('01-02-2024', '%d-%m-%Y'), '20.00'),
( '0042', '0006', STR_TO_DATE('01-04-2023', '%d-%m-%Y'), STR_TO_DATE('01-05-2023', '%d-%m-%Y'), '15.00'),
( '0042', '0007', STR_TO_DATE('01-05-2023', '%d-%m-%Y'), STR_TO_DATE('01-06-2023', '%d-%m-%Y'), '16.00'),
( '0044', '0007', STR_TO_DATE('01-07-2023', '%d-%m-%Y'), STR_TO_DATE('01-08-2023', '%d-%m-%Y'), '16.00'),
( '0044', '0011', STR_TO_DATE('01-05-2023', '%d-%m-%Y'), STR_TO_DATE('01-06-2023', '%d-%m-%Y'), '11.00'),
( '0044', '0004', STR_TO_DATE('01-06-2023', '%d-%m-%Y'), STR_TO_DATE('01-07-2023', '%d-%m-%Y'), '7.00'),
( '0046', '0013', STR_TO_DATE('01-08-2023', '%d-%m-%Y'), STR_TO_DATE('01-09-2023', '%d-%m-%Y'), '18.00'),
( '0047', '0008', STR_TO_DATE('01-09-2023', '%d-%m-%Y'), STR_TO_DATE('01-10-2023', '%d-%m-%Y'), '14.00'),
( '0048', '0007', STR_TO_DATE('01-06-2023', '%d-%m-%Y'), STR_TO_DATE('01-07-2023', '%d-%m-%Y'), '16.00'),
( '0048', '0002', STR_TO_DATE('01-12-2023', '%d-%m-%Y'), STR_TO_DATE('01-01-2024', '%d-%m-%Y'), '20.00'),
( '0057', '0004', STR_TO_DATE('01-07-2023', '%d-%m-%Y'), STR_TO_DATE('01-08-2023', '%d-%m-%Y'), '7.00'),
( '0059', '0008', STR_TO_DATE('01-09-2023', '%d-%m-%Y'), STR_TO_DATE('01-10-2023', '%d-%m-%Y'), '14.00'),
( '0065', '0014', STR_TO_DATE('01-07-2023', '%d-%m-%Y'), STR_TO_DATE('01-08-2023', '%d-%m-%Y'), '10.00'),
( '0067', '0013', STR_TO_DATE('01-12-2023', '%d-%m-%Y'), STR_TO_DATE('01-01-2024', '%d-%m-%Y'), '18.00'),
( '0068', '0012', STR_TO_DATE('01-08-2023', '%d-%m-%Y'), STR_TO_DATE('01-09-2023', '%d-%m-%Y'), '5.00'),
( '0070', '0008', STR_TO_DATE('01-10-2023', '%d-%m-%Y'), STR_TO_DATE('01-11-2023', '%d-%m-%Y'), '14.00'),
( '0070', '0011', STR_TO_DATE('01-01-2024', '%d-%m-%Y'), STR_TO_DATE('01-02-2024', '%d-%m-%Y'), '11.00'),
( '0070', '0012', STR_TO_DATE('01-02-2024', '%d-%m-%Y'), STR_TO_DATE('01-03-2024', '%d-%m-%Y'), '5.00'),
( '0071', '0011', STR_TO_DATE('01-09-2023', '%d-%m-%Y'), STR_TO_DATE('01-10-2023', '%d-%m-%Y'), '11.00'),
( '0071', '0006', STR_TO_DATE('01-10-2023', '%d-%m-%Y'), STR_TO_DATE('01-11-2023', '%d-%m-%Y'), '15.00'),
( '0071', '0012', STR_TO_DATE('01-11-2023', '%d-%m-%Y'), STR_TO_DATE('01-12-2023', '%d-%m-%Y'), '5.00'),
( '0080', '0002', STR_TO_DATE('01-12-2023', '%d-%m-%Y'), STR_TO_DATE('01-01-2024', '%d-%m-%Y'), '20.00'),
( '0082', '0013', STR_TO_DATE('01-01-2024', '%d-%m-%Y'), STR_TO_DATE('01-02-2024', '%d-%m-%Y'), '18.00'),
( '0083', '0011', STR_TO_DATE('01-04-2023', '%d-%m-%Y'), STR_TO_DATE('01-05-2023', '%d-%m-%Y'), '11.00'),
( '0092', '0010', STR_TO_DATE('01-05-2023', '%d-%m-%Y'), STR_TO_DATE('01-06-2023', '%d-%m-%Y'), '13.00'),
( '0092', '0013', STR_TO_DATE('01-07-2023', '%d-%m-%Y'), STR_TO_DATE('01-08-2023', '%d-%m-%Y'), '18.00'),
( '0092', '0011', STR_TO_DATE('01-05-2023', '%d-%m-%Y'), STR_TO_DATE('01-06-2023', '%d-%m-%Y'), '11.00'),
( '0093', '0009', STR_TO_DATE('01-06-2023', '%d-%m-%Y'), STR_TO_DATE('01-07-2023', '%d-%m-%Y'), '9.00'),
( '0094', '0003', STR_TO_DATE('01-08-2023', '%d-%m-%Y'), STR_TO_DATE('01-09-2023', '%d-%m-%Y'), '19.00'),
( '0094', '0008', STR_TO_DATE('01-09-2023', '%d-%m-%Y'), STR_TO_DATE('01-10-2023', '%d-%m-%Y'), '14.00'),
( '0098', '0006', STR_TO_DATE('01-06-2023', '%d-%m-%Y'), STR_TO_DATE('01-07-2023', '%d-%m-%Y'), '15.00'),
( '0101', '0003', STR_TO_DATE('01-12-2023', '%d-%m-%Y'), STR_TO_DATE('01-01-2024', '%d-%m-%Y'), '19.00'),
( '0103', '0014', STR_TO_DATE('01-07-2023', '%d-%m-%Y'), STR_TO_DATE('01-08-2023', '%d-%m-%Y'), '10.00'),
( '0103', '0011', STR_TO_DATE('01-09-2023', '%d-%m-%Y'), STR_TO_DATE('01-10-2023', '%d-%m-%Y'), '11.00'),
( '0104', '0003', STR_TO_DATE('01-07-2023', '%d-%m-%Y'), STR_TO_DATE('01-08-2023', '%d-%m-%Y'), '19.00'),
( '0106', '0010', STR_TO_DATE('01-12-2023', '%d-%m-%Y'), STR_TO_DATE('01-01-2024', '%d-%m-%Y'), '13.00'),
( '0110', '0009', STR_TO_DATE('01-08-2023', '%d-%m-%Y'), STR_TO_DATE('01-09-2023', '%d-%m-%Y'), '9.00'),
( '0119', '0013', STR_TO_DATE('01-10-2023', '%d-%m-%Y'), STR_TO_DATE('01-11-2023', '%d-%m-%Y'), '18.00'),
( '0119', '0014', STR_TO_DATE('01-01-2024', '%d-%m-%Y'), STR_TO_DATE('01-02-2024', '%d-%m-%Y'), '10.00'),
( '0121', '0008', STR_TO_DATE('01-02-2024', '%d-%m-%Y'), STR_TO_DATE('01-03-2024', '%d-%m-%Y'), '14.00'),
( '0122', '0008', STR_TO_DATE('01-09-2023', '%d-%m-%Y'), STR_TO_DATE('01-10-2023', '%d-%m-%Y'), '14.00'),
( '0123', '0002', STR_TO_DATE('01-10-2023', '%d-%m-%Y'), STR_TO_DATE('01-11-2023', '%d-%m-%Y'), '20.00'),
( '0130', '0009', STR_TO_DATE('01-11-2023', '%d-%m-%Y'), STR_TO_DATE('01-12-2023', '%d-%m-%Y'), '09.00'),
( '0131', '0001', STR_TO_DATE('01-12-2023', '%d-%m-%Y'), STR_TO_DATE('01-01-2024', '%d-%m-%Y'), '12.00'),
( '0133', '0001', STR_TO_DATE('01-01-2024', '%d-%m-%Y'), STR_TO_DATE('01-02-2024', '%d-%m-%Y'), '12.00'),
( '0134', '0011', STR_TO_DATE('01-04-2023', '%d-%m-%Y'), STR_TO_DATE('01-05-2023', '%d-%m-%Y'), '11.00'),
( '0135', '0006', STR_TO_DATE('01-05-2024', '%d-%m-%Y'), STR_TO_DATE('01-06-2023', '%d-%m-%Y'), '15.00'),
( '0139', '0009', STR_TO_DATE('01-02-2023', '%d-%m-%Y'), STR_TO_DATE('01-03-2023', '%d-%m-%Y'), '9.00'),
( '0141', '0010', STR_TO_DATE('01-04-2023', '%d-%m-%Y'), STR_TO_DATE('01-05-2023', '%d-%m-%Y'), '13.00'),
( '0142', '0006', STR_TO_DATE('01-06-2023', '%d-%m-%Y'), STR_TO_DATE('01-07-2023', '%d-%m-%Y'), '15.00'),
( '0145', '0008', STR_TO_DATE('01-06-2023', '%d-%m-%Y'), STR_TO_DATE('01-07-2023', '%d-%m-%Y'), '14.00'),
( '0145', '0009', STR_TO_DATE('01-10-2023', '%d-%m-%Y'), STR_TO_DATE('01-11-2023', '%d-%m-%Y'), '9.00'),
( '0146', '0006', STR_TO_DATE('01-07-2023', '%d-%m-%Y'), STR_TO_DATE('01-08-2023', '%d-%m-%Y'), '15.00'),
( '0150', '0008', STR_TO_DATE('01-07-2023', '%d-%m-%Y'), STR_TO_DATE('01-08-2023', '%d-%m-%Y'), '14.00');

DELIMITER //
CREATE TRIGGER TR_UNIT_UPDATE_STATUS
AFTER INSERT ON Lease
FOR EACH ROW
BEGIN
	-- CAP NHAT LAI TRANG THAI CAN HO SAU KHI HOP DONG THUE BAT DAU
    UPDATE Unit 
    SET Status = 'Rented'
    WHERE Unit_ID = NEW.Unit_ID;
END//
DELIMITER ;

DELIMITER //
CREATE TRIGGER TR_VENDOR_BeforeDelete
BEFORE DELETE ON Vendor
FOR EACH ROW
BEGIN
-- Cập nhật lại giá tiền sau khi một nhà cung cấp bị xóa
UPDATE Contract
SET Vendor_ID = NULL, Cost = 0
WHERE Vendor_ID = OLD.Vendor_ID;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER TR_Tenant_BeforeInsert
BEFORE INSERT ON Tenant
FOR EACH ROW
BEGIN
 IF DATEDIFF(CURDATE(), NEW.Date_of_Birth) < 6570 THEN
 SIGNAL SQLSTATE '45000'
 SET MESSAGE_TEXT = 'Tenant must be at least 18 years old.';
 END IF;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER TR_Tenant_BeforeUpdate
BEFORE UPDATE ON Tenant
FOR EACH ROW
BEGIN
 IF DATEDIFF(CURDATE(), NEW.Date_of_Birth) < 6570 THEN
 -- Mã trạng thái thông báo lỗi --
 SIGNAL SQLSTATE '45000'
 SET MESSAGE_TEXT = 'Tenant must be at least 18 years old.';
 END IF;
END //
DELIMITER ;

-- Trigger này sẽ kiểm tra xem ngày thanh toán không được trước ngày bắt đầu của hợp đồng thuê.
DELIMITER //
CREATE TRIGGER Check_Payment_Date 
BEFORE INSERT ON Payment
FOR EACH ROW
BEGIN
    DECLARE lease_start_date DATE;
    SELECT Start_Date INTO lease_start_date
    FROM Lease
    WHERE Lease_ID = NEW.Lease_ID;
    IF NEW.Date < lease_start_date THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Payment date cannot be before lease start date';
    END IF;
END//
DELIMITER ;

DELIMITER //
CREATE TRIGGER TR_AMENITY_BeforeDelete
BEFORE DELETE ON Amenity
FOR EACH ROW
BEGIN
-- Update information for all products supplied by the deleted supplier
	UPDATE Booking
	SET Amenity_ID = NULL, Tenant_ID = NULL, Cost = 0
	WHERE Amenity_ID = OLD.Amenity_ID;
END //
DELIMITER ;

DELIMITER //
CREATE FUNCTION GetResidentCountForBuilding(BuildingID INT, p_year INT) 
RETURNS INT
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE sltenant_count INT;
    -- Tính số lượng cư dân bằng cách đếm số lượng tenant mà có hợp đồng thuê tại các unit của tòa nhà trong năm
    SELECT COUNT(DISTINCT Tenant_ID) INTO sltenant_count
    FROM Lease
    WHERE Unit_ID IN (
        SELECT Unit_ID
        FROM Unit
        WHERE Property_ID = buildingID
    ) AND YEAR(Start_Date) = p_year;
    RETURN sltenant_count;
END //
DELIMITER ;

DELIMITER //
CREATE FUNCTION Tenant_CountByMonth(t_month INT, t_year INT)
RETURNS INT
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE tenant_count INT;
    SELECT COUNT(*) INTO tenant_count
    FROM Lease
    WHERE YEAR(Start_Date) = t_year
    AND MONTH(Start_Date) = t_month;
    RETURN tenant_count;
END//
DELIMITER ;

-- target_year dai dien cho nam ma muon tinh so luong can ho dc thue
DELIMITER //
CREATE FUNCTION Rented_Unit_CountByYear(target_year INT)
RETURNS INT
DETERMINISTIC -- ket qua ham chi phu thuoc vao target_year
READS SQL DATA
BEGIN
	DECLARE total_rented INT;
    SELECT COUNT(*) INTO total_rented
    FROM Lease
    WHERE year(Start_Date) = target_year;
    RETURN total_rented;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE AddAmenity(
    IN p_Amenity_ID CHAR(4),
    IN p_Property_ID CHAR(4),
    IN p_Amenity_Name VARCHAR(50),
    IN p_Description TEXT,
    IN p_Cost DECIMAL(5,2)
)
BEGIN
    -- Thêm tiện ích mới
    INSERT INTO Amenity (Amenity_ID, Property_ID, Amenity_Name, Description)
    VALUES (p_Amenity_ID, p_Property_ID, p_Amenity_Name, p_Description);

    -- Cập nhật giá trong bảng Booking nếu tiện ích đã tồn tại
    UPDATE Booking
    SET Cost = p_Cost
    WHERE Amenity_ID = p_Amenity_ID;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE AddAmenityAndCost(
    IN p_Amenity_ID CHAR(4),
    IN p_Property_ID CHAR(4),
    IN p_Amenity_Name VARCHAR(50),
    IN p_Description TEXT,
    IN p_Tenant_ID CHAR(4),
    IN p_Start_Date DATETIME,
    IN p_End_Date DATETIME,
    IN p_Cost DECIMAL(5,2)
)
BEGIN
    -- Thêm amenity mới vào bảng Amenity
    INSERT INTO Amenity (Amenity_ID, Property_ID, Amenity_Name, Description)
    VALUES (p_Amenity_ID, p_Property_ID, p_Amenity_Name, p_Description);
    -- Thêm cost mới vào bảng Booking
    INSERT INTO Booking (Tenant_ID, Amenity_ID, Start_Date, End_Date, Cost)
    VALUES (p_Tenant_ID, p_Amenity_ID, p_Start_Date, p_End_Date, p_Cost);
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE Tenant_GetList()
BEGIN
    -- Lấy danh sách cư dân từ các hợp đồng thuê đang hoạt động
    SELECT Tenant.Tenant_ID, Tenant.Tenant_Name, Tenant.Phone_Number, Tenant.Tenant_Email
    FROM Tenant
    JOIN Lease ON Tenant.Tenant_ID = Lease.Tenant_ID
    WHERE Lease.Start_Date <= CURDATE() AND Lease.End_Date >= CURDATE();
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE add_lease (
  IN lease_id CHAR(4),
  IN unit_id CHAR(4),
  IN tenant_id CHAR(4),
  IN start_date DATE,
  IN end_date DATE,
  IN monthly_rent DECIMAL(10,2),
  IN deposit DECIMAL(10,2)
)
BEGIN
  DECLARE Unit_Available INT;
  -- Kiểm tra xem Unit có tồn tại và có sẵn không
  SELECT COUNT(*) INTO Unit_Available
  FROM Unit
  WHERE Unit_ID = unit_id
    AND Status = 'Available';
  IF Unit_Available = 0 THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Unit is not available for lease';
  ELSE
    -- Thêm bản ghi lease mới
    INSERT INTO Lease (
      Lease_ID,
      Unit_ID,
      Tenant_ID,
      Start_Date,
      End_Date,
      Monthly_Rent,
      Deposit
    ) VALUES (
      lease_id,
      unit_id,
      tenant_id,
      start_date,
      end_date,
      monthly_rent,
      deposit
    );
    -- Cập nhật trạng thái của Unit thành 'Rented'
    UPDATE Unit
    SET Status = 'Rented'
    WHERE Unit_ID = unit_id;
  END IF;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE UnitAvailable_GetList()
BEGIN
-- Hiển thị danh sách căn hộ còn trống
SELECT Unit_ID, Property_ID, Number, Floor, Rent
FROM Unit
WHERE Status = 'Available';
END
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE Top2BookingAmenities(IN p_month INT, IN p_year INT)
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE amenityID INT;
    DECLARE amenityName VARCHAR(50);
    DECLARE bookingCount INT;
    DECLARE cur CURSOR FOR
        SELECT Amenity_ID, Amenity_Name
        FROM Amenity;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    -- Tạo bảng tạm thời để lưu trữ kết quả
    CREATE TEMPORARY TABLE IF NOT EXISTS temp_top_amenities (
        Amenity_ID INT,
        Amenity_Name VARCHAR(50),
        Booking_Count INT
    );
	-- Mở cursor
    OPEN cur;
    read_loop: LOOP
        FETCH cur INTO amenityID, amenityName;
        IF done THEN
            LEAVE read_loop;
        END IF;
        -- Đếm số lượng booking cho mỗi tiện ích trong tháng được chỉ định
        SET bookingCount = (
            SELECT COUNT(*)
            FROM Booking
            WHERE Amenity_ID = amenityID
            AND MONTH(Start_Date) = p_month
            AND YEAR(Start_Date) = P_year
        );
        -- Thêm kết quả vào bảng tạm thời
        INSERT INTO temp_top_amenities (Amenity_ID, Amenity_Name, Booking_Count)
        VALUES (amenityID, amenityName, bookingCount);
    END LOOP;
    CLOSE cur;
    -- Lấy ra top 2 tiện ích có số lượng booking cao nhất
    SELECT Amenity_ID, Amenity_Name, Booking_Count
    FROM temp_top_amenities
    ORDER BY Booking_Count DESC
    LIMIT 2;
    -- Xóa bảng tạm thời sau khi sử dụng
    DROP TEMPORARY TABLE IF EXISTS temp_top_amenities;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE CancelLeasesAndUpdateUnits()
BEGIN
    -- Định nghĩa biến để lưu giá trị từ mỗi hàng
    DECLARE v_lease_id INT;
	DECLARE v_unit_id INT;
    -- Biến kiểm soát vòng lặp
    DECLARE done INT DEFAULT FALSE;
    -- Khai báo cursor cho các hợp đồng thuê hết hạn
    DECLARE lease_cursor CURSOR FOR 
        SELECT Lease_ID, Unit_ID 
        FROM Lease 
        WHERE End_Date < CURDATE();
    -- Khai báo handler để kết thúc vòng lặp khi cursor đến cuối tập kết quả
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    -- Mở cursor
    OPEN lease_cursor;
    lease_loop: LOOP
        FETCH lease_cursor INTO v_lease_id, v_unit_id;
        IF done THEN
            LEAVE lease_loop;
        END IF;
	-- Xóa các hàng liên quan trong bảng Payment
	DELETE FROM Payment WHERE Lease_ID = v_lease_id;
	-- Hủy hợp đồng thuê bằng cách cập nhật trạng thái
	DELETE FROM Lease
	WHERE Lease_ID = v_lease_id;
	-- Cập nhật trạng thái của căn hộ thành 'Available'
	UPDATE Unit
	SET Status = 'Available'
	WHERE Unit_ID = v_unit_id;
    END LOOP;
    -- Đóng cursor
    CLOSE lease_cursor;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE UpdatePaymentAmounts()
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE v_Lease_ID CHAR(4);
    DECLARE v_Date DATE;
    DECLARE v_Property_ID CHAR(4);
    DECLARE v_Monthly_Rent DECIMAL(5,2);
    DECLARE v_Total_Contract_Cost DECIMAL(10,2) DEFAULT 0;
    DECLARE v_Total_Booking_Cost DECIMAL(10,2) DEFAULT 0;
    DECLARE v_Tenant_ID CHAR(4);
    -- Declare a cursor to iterate through the Payment table
    DECLARE payment_cursor CURSOR FOR
        SELECT Lease_ID, Date
        FROM Payment;
    -- Declare a handler to set the done flag
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    -- Open the cursor
    OPEN payment_cursor;
    payment_loop: LOOP
        -- Fetch the next row from the cursor
        FETCH payment_cursor INTO v_Lease_ID, v_Date;
        -- Exit the loop if no more rows
        IF done THEN
            LEAVE payment_loop;
        END IF;
        -- Reset total costs for each iteration
        SET v_Total_Contract_Cost = 0;
        SET v_Total_Booking_Cost = 0;
        -- Get Monthly Rent, Property_ID, and Tenant_ID from Lease and Unit tables
        SELECT L.Unit_ID, L.Monthly_Rent, U.Property_ID
        INTO v_Tenant_ID, v_Monthly_Rent, v_Property_ID
        FROM Lease L
        JOIN Unit U ON L.Unit_ID = U.Unit_ID
        WHERE L.Lease_ID = v_Lease_ID;
        -- Calculate total contract cost for the property
        SELECT SUM(C.Cost)
        INTO v_Total_Contract_Cost
        FROM Contract C
        WHERE C.Property_ID = v_Property_ID
          AND v_Date BETWEEN C.Start_Date AND C.End_Date;
        -- Calculate total booking cost for the tenant
        SELECT SUM(B.Cost)
        INTO v_Total_Booking_Cost
        FROM Booking B
        WHERE B.Tenant_ID = v_Tenant_ID
          AND v_Date BETWEEN B.Start_Date AND B.End_Date;
        -- Update the Payment amount
        UPDATE Payment
        SET Amount = v_Monthly_Rent + IFNULL(v_Total_Contract_Cost, 0) + IFNULL(v_Total_Booking_Cost, 0)
        WHERE Lease_ID = v_Lease_ID
          AND Date = v_Date;
    END LOOP;
    -- Close the cursor
    CLOSE payment_cursor;
END //
DELIMITER ;

DELIMITER //
-- Create a role for Manager
CREATE ROLE 'manager_role';
-- Create a role for Tenant
CREATE ROLE 'tenant_role';
//
DELIMITER ;

-- Create Manager user and assign Manager role
CREATE USER 'manager_user'@'localhost' IDENTIFIED BY 'manager';
GRANT 'manager_role' TO 'manager_user'@'localhost';
SET DEFAULT ROLE 'manager_role' TO 'manager_user'@'localhost';
-- Create Tenant user and assign Tenant role
CREATE USER 'tenant_user'@'localhost' IDENTIFIED BY 'tenant';
GRANT 'tenant_role' TO 'tenant_user'@'localhost';
SET DEFAULT ROLE 'tenant_role' TO 'tenant_user'@'localhost';
-- Tables by manager
GRANT SELECT, INSERT, UPDATE ON qlcc.Property TO manager_role WITH GRANT OPTION;
GRANT SELECT, INSERT, UPDATE, DELETE ON qlcc.Vendor TO manager_role WITH GRANT OPTION;
GRANT SELECT, INSERT, UPDATE ON qlcc.Unit TO manager_role WITH GRANT OPTION;
GRANT SELECT, INSERT, UPDATE, DELETE ON qlcc.Lease TO manager_role WITH GRANT OPTION;
GRANT SELECT, INSERT, UPDATE, DELETE ON qlcc.Payment TO manager_role WITH GRANT OPTION;
GRANT SELECT, INSERT, UPDATE, DELETE ON qlcc.Tenant TO manager_role WITH GRANT OPTION;
GRANT SELECT, INSERT, UPDATE, DELETE ON qlcc.Amenity TO manager_role WITH GRANT OPTION;
GRANT SELECT, INSERT, UPDATE ON qlcc.Booking TO manager_role WITH GRANT OPTION;
GRANT SELECT, INSERT, UPDATE ON qlcc.Contract TO manager_role WITH GRANT OPTION;
-- Tables by tenant
GRANT SELECT ON qlcc.Property TO tenant_role WITH GRANT OPTION;
GRANT SELECT ON qlcc.Vendor TO tenant_role WITH GRANT OPTION;
GRANT SELECT ON qlcc.Unit TO tenant_role WITH GRANT OPTION;
GRANT SELECT ON qlcc.Lease TO tenant_role WITH GRANT OPTION;
GRANT SELECT ON qlcc.Payment TO tenant_role WITH GRANT OPTION;
GRANT SELECT ON qlcc.Tenant TO tenant_role WITH GRANT OPTION;
GRANT SELECT ON qlcc.Amenity TO tenant_role WITH GRANT OPTION;
GRANT SELECT, INSERT, UPDATE, DELETE ON qlcc.Booking TO tenant_role WITH GRANT OPTION;
GRANT SELECT, INSERT, UPDATE, DELETE ON qlcc.Contract TO tenant_role WITH GRANT OPTION;

-- manager_role
-- Store Procedures, WITH GRANT OPTION: duoc cap quyen va co the cap quyen lai cho nguoi khac
GRANT EXECUTE ON PROCEDURE QLCC.Bill_unit_month TO manager_role WITH GRANT OPTION;
GRANT EXECUTE ON PROCEDURE QLCC.UnitAvailable_GetList TO manager_role WITH GRANT OPTION;
GRANT EXECUTE ON PROCEDURE QLCC.Tenant_GetList TO manager_role WITH GRANT OPTION;
GRANT EXECUTE ON PROCEDURE QLCC.Amenity_Add TO manager_role WITH GRANT OPTION;
GRANT EXECUTE ON PROCEDURE QLCC.BookAmenity TO manager_role WITH GRANT OPTION;
GRANT EXECUTE ON PROCEDURE QLCC.Add_Lease TO manager_role WITH GRANT OPTION;
-- functions 
GRANT EXECUTE ON FUNCTION QLCC.Rented_Unit_CountByYear TO manager_role WITH GRANT OPTION;
GRANT EXECUTE ON FUNCTION QLCC.GetResidentCountForBuilding TO manager_role WITH GRANT OPTION;
GRANT EXECUTE ON FUNCTION QLCC.Tenant_CountByMonth TO manager_role WITH GRANT OPTION;

-- tenant-role
-- Store Procedures
GRANT EXECUTE ON PROCEDURE QLCC.Bill_unit_month TO tenant_role;
GRANT EXECUTE ON PROCEDURE QLCC.UnitAvailable_GetList TO tenant_role;
GRANT EXECUTE ON PROCEDURE QLCC.BookAmenity TO tenant_role;
-- functions 
GRANT EXECUTE ON FUNCTION QLCC.Rented_Unit_CountByYear TO tenant_role;
GRANT EXECUTE ON FUNCTION QLCC.GetResidentCountForBuilding TO tenant_role;
GRANT EXECUTE ON FUNCTION QLCC.Tenant_CountByMonth TO tenant_role;

-- Add column salt into table Tenant
ALTER TABLE Tenant
ADD COLUMN salt VARCHAR(20) NOT NULL;
DELIMITER //
CREATE PROCEDURE Tenant_Add(
    IN p_host INT,
    IN p_name VARCHAR(50),
    IN p_phone VARCHAR(10),
    IN p_email VARCHAR(50),
    IN p_birthdate DATE,
    IN p_password VARCHAR(20)
)
BEGIN
    DECLARE salt_value VARCHAR(20);
    -- Generate a new salt value
    SET salt_value = SHA2(UUID(), 256);
    -- Hash the password with the salt
    SET p_password = SHA2(CONCAT(p_password, salt_value), 256);
    -- Insert new tenant with hashed password and salt
    INSERT INTO Tenant (Host, Tenant_Name, Phone_Number, Tenant_Email, Date_of_Birth, accPassword, salt)
    VALUES (p_host, p_name, p_phone, p_email, p_birthdate, p_password, salt_value);
END //
DELIMITER ;

-- View
-- View để ẩn mật khẩu cho Tenant
	﻿ALTER TABLE Tenant ADD COLUMN Password VARCHAR(255);
	CREATE VIEW Tenant_View AS
	SELECT Tenant_ID, Tenant_Name, Phone_Number, Email, Date_of_Birth, Unit_Owner
	FROM Tenant;
	-- Thu hồi quyền SELECT trên bảng Tenant từ tenant_role
	REVOKE SELECT ON qlcc.Tenant FROM tenant_role;
	-- Cấp quyền SELECT trên view Tenant_View cho tenant_role
	GRANT SELECT ON qlcc.Tenant_View TO tenant_role;
-- View để ẩn giá của Payment cho Tenant
	﻿CREATE VIEW Payment_View AS
	SELECT Payment_ID, Lease_ID, Date, Payment_Type
	FROM Payment;
	-- Thu hồi quyền SELECT trên bảng Payment từ tenant_role
	REVOKE SELECT ON qlcc.Payment FROM tenant_role;
	-- Cấp quyền SELECT trên view Payment_View cho tenant_role
	GRANT SELECT ON qlcc.Payment_View TO tenant_role;
-- View để xem số Tenant còn ở
	CREATE VIEW Current_Tenants AS
	SELECT t.Tenant_ID, t.Tenant_Name, t.Phone_Number, t.Email, t.Date_of_Birth, t.Unit_Owner, l.Unit_ID, l.Start_Date, l.End_Date
	FROM Tenant t
	JOIN Lease l ON t.Tenant_ID = l.Tenant_ID
	WHERE l.End_Date >= CURDATE();
	GRANT SELECT ON qlcc.Current_Tenants TO tenant_role;
-- View xem số lượng booking cho mỗi Amenity dựa trên khoảng thời gian booking
	CREATE VIEW Amenity_Booking_Count AS
	SELECT a.Amenity_ID, a.Amenity_Name, COUNT(b.Booking_ID) AS Booking_Count
	FROM Amenity a
	LEFT JOIN Booking b ON a.Amenity_ID = b.Amenity_ID
	GROUP BY a.Amenity_ID, a.Amenity_Name;
	GRANT SELECT ON qlcc.Amenity_Booking_Count TO tenant_role;
-- View để xem chi tiết hóa đơn
	CREATE VIEW Invoice_Details AS
	SELECT p.Payment_ID, p.Date AS Payment_Date, p.Amount AS Payment_Amount, p.Payment_Type, l.Lease_ID, t.Tenant_ID, t.Tenant_Name, t.Phone_Number, t.Email, u.Unit_ID, u.Number AS Unit_Number, u.Floor AS Unit_Floor, u.Rent AS Unit_Rent
	FROM Payment p
	JOIN Lease l ON p.Lease_ID = l.Lease_ID
	JOIN Tenant t ON l.Tenant_ID = t.Tenant_ID
	JOIN Unit u ON l.Unit_ID = u.Unit_ID;
	GRANT SELECT ON qlcc.Invoice_Details TO tenant_role;
-- View để xem chi tiết thông tin của dịch vụ
	CREATE VIEW Amenity_Details AS
	SELECT a.Amenity_ID, a.Amenity_Name, a.A_Description, p.Property_ID, p.Property_Name, p.Property_Address
	FROM Amenity a
	JOIN Property p ON a.Property_ID = p.Property_ID;
	GRANT SELECT ON qlcc.Amenity_Details TO tenant_role;
-- View xem thông tin thanh toán của cư dân
	CREATE VIEW Tenant_Payment_Details AS
	SELECT p.Payment_ID, p.Date AS Payment_Date, p.Amount AS Payment_Amount, p.Payment_Type, t.Tenant_ID, t.Tenant_Name, t.Phone_Number, t.Email
	FROM Payment p
	JOIN Lease l ON p.Lease_ID = l.Lease_ID
	JOIN Tenant t ON l.Tenant_ID = t.Tenant_ID;
	GRANT SELECT ON qlcc.Tenant_Payment_Details TO tenant_role;


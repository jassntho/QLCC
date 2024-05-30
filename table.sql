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
	Booking_ID CHAR(4) PRIMARY KEY,
	Tenant_ID CHAR(4) ,
	Amenity_ID CHAR(4) ,
	Start_Time DATETIME,
	End_Time DATETIME,
	Cost DECIMAL(5,2),
	FOREIGN KEY(Tenant_ID) REFERENCES Tenant(Tenant_ID),
    FOREIGN KEY(Amenity_ID) REFERENCES Amenity(Amenity_ID)
);
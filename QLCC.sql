CREATE DATABASE QLCC
USE QLCC

CREATE TABLE Tenant (
	Tenant_ID INT PRIMARY KEY,
	Name VARCHAR(50) NOT NULL,
	Phone_Number VARCHAR(10),
	Email VARCHAR(50),
	Date_of_Birth DATE,
	Host INT
);

CREATE TABLE Amenity (
	Amenity_ID INT PRIMARY KEY,
Property_ID INT FOREIGN KEY REFERENCES    Property(Property_ID),
	Name VARCHAR(50),
	Description TEXT
);

CREATE TABLE Booking (
	Booking_ID INT PRIMARY KEY,
Tenant_ID INT FOREIGN KEY REFERENCES Tenant(Tenant_ID),
Amenity_ID INT FOREIGN KEY REFERENCES Amenity(Amenity_ID),
	Start_Time DATETIME,
	End_Time DATETIME,
          Cost DECIMAL(10,2)
);

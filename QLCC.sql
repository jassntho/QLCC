CREATE DATABASE QLCC
USE QLCC

CREATE TABLE Tenant (
	Tenant_ID INT PRIMARY KEY,
	Tenant_Name VARCHAR(50) NOT NULL,
	Phone_Number VARCHAR(10),
	Email VARCHAR(50),
	Date_of_Birth DATE,
	Unit_Owner INT
);

CREATE TABLE Amenity (
	Amenity_ID INT PRIMARY KEY,
	Property_ID INT FOREIGN KEY REFERENCES Property(Property_ID),
	Amenity_Name VARCHAR(50),
	A_Description TEXT
);


CREATE TABLE Booking (
	Booking_ID INT PRIMARY KEY,
	Tenant_ID INT FOREIGN KEY REFERENCES Tenant(Tenant_ID),
	Amenity_ID INT FOREIGN KEY REFERENCES Amenity(Amenity_ID),
	Start_Time DATETIME,
	End_Time DATETIME
);

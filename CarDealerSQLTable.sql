--Setup the CarDealership Database
USE CarDealership
GO

--ENSURE NO TABLES EXIST INITIALLY IN DATABASE
--drop tables that are having foreign keys first
DROP TABLE IF EXISTS Invoice
DROP TABLE IF EXISTS ServiceTicket

--drop tables that has no foreign keys
DROP TABLE IF EXISTS Car
DROP TABLE IF EXISTS Customer
DROP TABLE IF EXISTS Employee
DROP TABLE IF EXISTS Service

GO
-- TABLE CREATION 
-- Create all tables or entities

-- Car Table
CREATE TABLE Car (CarId int Identity(1,1),
	CarSerialNo char(12) NOT NULL UNIQUE, 
	RegistrationNo varchar(15) NOT NULL,
	Make varchar(40) NOT NULL, 
	Model varchar(40) NOT NULL, 
	Color varchar(30) NOT NULL, 
	Status char(10) NOT NULL, 
	ForSale char(1) NOT NULL,
PRIMARY KEY (CarId),
CONSTRAINT CK_CarStatus CHECK (Status IN ('NEW','USED','SRV')),
CONSTRAINT CK_CarForSale CHECK (ForSale IN ('Y','N')))
GO

-- Customer Table
CREATE TABLE Customer (CustomerId int Identity(1,1),
	FirstName varchar(40),
	LastName varchar(40) ,
	Address varchar(50),
	City varchar(20),
	State varchar(20),
	Postcode varchar(8),
	PhoneNumber varchar(15),
	MobileNumber varchar(15),
	Email varchar(100),
	Active char(1) NOT NULL,
PRIMARY KEY (CustomerId),
CONSTRAINT CK_CustActive CHECK (Active IN ('Y','N')))
GO 

-- Employee Table
CREATE TABLE Employee (EmployeeNo char(9),
	FirstName varchar(40) NOT NULL,
	LastName varchar(40) NOT NULL,
	Job varchar(15) NOT NULL,
	DateStarted datetime NOT NULL,
PRIMARY KEY (EmployeeNo),
CONSTRAINT CK_Job CHECK (Job IN ('MECHANIC','SALESMAN')))
GO 

-- Invoice Table
CREATE TABLE Invoice (InvoiceNo int Identity(100,1),
	CustomerId int NOT NULL,
	CarId int NOT NULL,
	EmployeeNo char(9) NOT NULL,
	TicketId int,
	InvoiceDate datetime NOT NULL,
	InvoiceType char(10) NOT NULL,
	InvoiceAmount decimal(10,2) NOT NULL
PRIMARY KEY (InvoiceNo),
FOREIGN KEY (CustomerId) REFERENCES Customer(CustomerId),
FOREIGN KEY (CarId) REFERENCES Car(CarId),
FOREIGN KEY (EmployeeNo) REFERENCES Employee(EmployeeNo),
CONSTRAINT CK_InvoiceType CHECK (InvoiceType IN ('SALESINV','SERVICEINV')))
GO 

-- Service Table 
CREATE TABLE Service (ServiceId int Identity(1,1),
	ServiceName varchar(50) NOT NULL,
	ServiceType char(8) NOT NULL,
	ServiceRate decimal(7,2) NOT NULL,
	ServiceDesc varchar(200) NOT NULL,
PRIMARY KEY (ServiceId), 
CONSTRAINT CK_ServiceType CHECK (ServiceType IN ('SERVICE','REPAIR')))
GO

-- ServiceTicket Table
CREATE TABLE ServiceTicket(TicketId int Identity(1,1),   	
	TicketNumber AS 'SRV' + RIGHT('0000000000'+ CONVERT(VARCHAR(10),TicketId),10) PERSISTED,
	CustomerId int NOT NULL,
	CarId int NOT NULL, 
	MechanicId char(9) NOT NULL,
	ServiceId int NOT NULL,
	TicketDate datetime NOT NULL,	
	DateReceive datetime NOT NULL,
	DateReturn datetime,
	Comment varchar(200),
PRIMARY KEY (TicketId),
FOREIGN KEY (CustomerId) REFERENCES Customer(CustomerId),
FOREIGN KEY (CarId) REFERENCES Car(CarId),
FOREIGN KEY (MechanicId) REFERENCES Employee(EmployeeNo),
FOREIGN KEY (ServiceId) REFERENCES Service(ServiceId))
GO 



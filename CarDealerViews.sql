--SETTING UP OF REQUIRED VIEWS FOR CARDEALERSHIP DATABASE
USE CarDealership
GO 

--Ensure that views are not existed initially 
DROP VIEW IF EXISTS ViewServiceTicketLastqtr
DROP VIEW IF EXISTS ViewServiceTicketAll
DROP VIEW IF EXISTS ViewInactiveCust 
DROP VIEW IF EXISTS ViewAllCust
GO 
--CREATING VIEWS 

-- CREATE VIEWS FOR LAST QUARTER OR LAST 3 MONTHS SERVICE TICKET TRANSACTIONS
CREATE VIEW ViewServiceTicketLastqtr
AS 
SELECT e.EmployeeNo, e.FirstName+' '+e.LastName AS 'Mechanic Name' ,e.Job,
	   st.TicketId, st.TicketNumber,st.TicketDate,st.CarId,st.CustomerId,
	   cust.FirstName+' '+cust.LastName as 'Customer Name', 
	   st.ServiceId,st.DateReceive,st.DateReturn,st.Comment,
	   s.ServiceType,s.ServiceName,s.ServiceRate,
	   c.CarSerialNo,c.Color,c.Make,c.Model,c.RegistrationNo,c.Status
	FROM  ServiceTicket st
		INNER JOIN Employee e ON st.MechanicId=e.EmployeeNo
		INNER JOIN Service s ON st.ServiceId=s.ServiceId
		INNER JOIN Car c ON st.CarId=c.CarId
		INNER JOIN Customer cust ON st.CustomerId=cust.CustomerId
WHERE e.Job='MECHANIC' AND DATEDIFF(MONTH, st.TicketDate,GETDATE()) <=3
GO 

SELECT * FROM ViewServiceTicketLastqtr

GO 

---CREATE VIEW ALL SERVICE TICKET
CREATE VIEW ViewServiceTicketAll
AS 
SELECT e.EmployeeNo, e.FirstName+' '+e.LastName AS 'Mechanic Name' ,e.Job,
	   st.TicketId, st.TicketNumber,st.TicketDate,st.CarId,st.CustomerId,
	   cust.FirstName+' '+cust.LastName as 'Customer Name', 
	   st.ServiceId,st.DateReceive,st.DateReturn,st.Comment,
	   s.ServiceType,s.ServiceName,s.ServiceRate,
	   c.CarSerialNo,c.Color,c.Make,c.Model,c.RegistrationNo,c.Status
	FROM  ServiceTicket st
		INNER JOIN Employee e ON st.MechanicId=e.EmployeeNo
		INNER JOIN Service s ON st.ServiceId=s.ServiceId
		INNER JOIN Car c ON st.CarId=c.CarId
		INNER JOIN Customer cust ON st.CustomerId=cust.CustomerId
WHERE e.Job='MECHANIC' 
GO

SELECT * FROM ViewServiceTicketAll

GO

--CREATE VIEW FOR INACTIVE CUSTOMER INACTIVE CUSTOMER DATA VIEW NO TRANSACTIONS FOR THE LAST 13 MONTHS
CREATE VIEW ViewInactiveCust
AS 
SELECT cust.FirstName+' '+cust.LastName AS 'Customer Name', inactive.*, cust.Email,cust.MobileNumber,cust.PhoneNumber,
	cust.Address,cust.City
	FROM 
   (SELECT inv.CustomerId, COUNT(inv.InvoiceNo) as InvoiceCount, (MAX(inv.InvoiceNo)) as LastInv#, 
		MAX(inv.InvoiceDate) as LastInvDate, 
		DATEDIFF(MONTH,MAX(inv.InvoiceDate),GETDATE()) AS MonthsNoTrans
	FROM Invoice inv 		 
	    GROUP BY inv.CustomerId HAVING DATEDIFF(MONTH,MAX(inv.InvoiceDate),GETDATE()) >=13) inactive 
	INNER JOIN Customer cust ON cust.CustomerId=inactive.CustomerId
GO	
SELECT * FROM ViewInactiveCust

GO 

--CREATE VIEW FOR ALL CUSTOMERS ACTIVE OR INACTIVE INCLUDING ALL THAT HAVE BEEN ANONYMIZE
--SHOWING NUMBER OF MONTHS WITHOUT TRANSACTIONS
CREATE VIEW ViewAllCust
AS 
SELECT cust.FirstName+' '+cust.LastName AS 'Customer Name', trans.*, cust.Email,cust.MobileNumber,cust.PhoneNumber,
	cust.Address, cust.City
	FROM 
   (SELECT inv.CustomerId, COUNT(inv.InvoiceNo) as InvoiceCount, (MAX(inv.InvoiceNo)) as LastInv#, 
		MAX(inv.InvoiceDate) as LastInvDate, 
		DATEDIFF(MONTH,MAX(inv.InvoiceDate),GETDATE()) AS MonthsNoTrans
	FROM Invoice inv 		 
	    GROUP BY inv.CustomerId ) trans 
	INNER JOIN Customer cust ON cust.CustomerId=trans.CustomerId
GO	
SELECT * FROM ViewAllCust
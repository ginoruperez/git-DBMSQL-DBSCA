-- TEST THE STORED PROCEDURES 
USE CarDealership
GO 

-- TEST OF CUSTOMERS STORED PROCEDURES

-- AddNewCustomer 
-- Test and Execute the AddNewCustomer Procedure
BEGIN TRY 
	EXEC AddNewCustomer 'Amanda','Page','123 Meadows St','Celbridge','Leinster',
					    'WD3 T38','012546712','0851463657','amandapage@mail.com','Y'
END TRY 
BEGIN CATCH  
    SELECT   
        ERROR_NUMBER() AS ErrorNumber,ERROR_MESSAGE() AS ErrorMessage;  
END CATCH
GO
SELECT * FROM Customer
GO 

-- DeleteCustomer Stored Procedure
-- Test and execute the DeleteCustomer Procedure
BEGIN TRY
	EXEC DeleteCustomer 6
END TRY
BEGIN CATCH
	SELECT ERROR_NUMBER() AS ErrNo, ERROR_MESSAGE() AS ErrMsg
END CATCH
GO
SELECT * FROM Customer
GO

-- UpdateCustomer Stored Procedure
-- Test the Customer Update Stored Procedure 
BEGIN TRY
	EXEC UpdateCustomer 5,'Francis','Perez','','','','','','','francis.perez@mail.com',''	
END TRY
BEGIN CATCH
	SELECT ERROR_NUMBER() AS ErrNo, ERROR_MESSAGE() AS ErrMsg
END CATCH
GO
SELECT * FROM Customer
GO


-- CAR STORED PROCEDURE TEST
-- Test the AddCar Stored Procedure
BEGIN TRY
	EXEC AddCar 'SERP04022015',	'2015-PORS-4','Porsche','2015-Porsche Cayenne','Crimson Red','SRV','N'
END TRY
BEGIN CATCH
	SELECT ERROR_NUMBER() AS ErrorNumber, ERROR_MESSAGE() AS ErrorMessage
END CATCH 
go
SELECT * FROM Car
GO


-- Test of DeleteCar
BEGIN TRY
	EXEC DeleteCar 3
END TRY
BEGIN CATCH
	SELECT ERROR_NUMBER() AS ErrorNumber, ERROR_MESSAGE() AS ErrorMessage
END CATCH 
GO
SELECT * FROM Car
GO 

--EMPLOYEE STORED PROCEDURE TEST
--Test the AddNewEmployee Stored Procedure
BEGIN TRY
	  EXEC AddNewEmployee '3786SDSMX','Alex','Antonio','MECHANIC','06/28/1998'
END TRY 
BEGIN CATCH
	SELECT ERROR_NUMBER() AS ErrorNo, ERROR_MESSAGE() AS ErrorMsg
END CATCH
GO 
SELECT * FROM Employee
GO 

--Test DELETE EMPLOYEE
BEGIN TRY
	  EXEC DeleteEmployee '3567882QR'
END TRY 
BEGIN CATCH
	SELECT ERROR_NUMBER() AS ErrorNo, ERROR_MESSAGE() AS ErrorMsg
END CATCH
GO 
SELECT * FROM Employee
GO 

-- SERVICE STORED PROCEDURE
-- Test Add Service 
BEGIN TRY 
	EXEC AddService 'Diagnostic Computer Scan', 'SERVICE',110.50,'Services include engine inspection'
END TRY 
BEGIN CATCH
	SELECT ERROR_NUMBER() AS ErrorNo, ERROR_MESSAGE() AS ErrorMsg
END CATCH 
GO 
SELECT * FROM Service
GO 

--SERVICE TICKET STORED PROCEDURE

--Test the AddServiceTicket Stored Procedure
BEGIN TRY 
	EXEC AddServiceTicket 7,7,'4573685DM',4,'5/4/2019','5/10/2021','5/11/2021','NEED FOR REPAIR'
END TRY 
BEGIN CATCH
	SELECT ERROR_NUMBER() AS ErrNo, ERROR_MESSAGE() AS ErrMsg
END CATCH 
GO
SELECT * FROM ServiceTicket
GO 


-- INVOICE STORED PROCEDURE

--Test the AddInvoice Stored Procedure
BEGIN TRY 
    EXEC AddInvoice 7,10,'4573685DM',4,'05/10/2021','SERVICEINV',20
END TRY
BEGIN CATCH
	SELECT ERROR_NUMBER() AS ErrNo, ERROR_MESSAGE() AS ErrMsg
END CATCH
GO
SELECT * FROM Invoice
GO 


-- GDPR
--Test the CustomerGdpr Stored Procedure
BEGIN TRY
	EXEC CustomerGdpr 2
END TRY	
BEGIN CATCH
	SELECT ERROR_NUMBER() AS ErrNo, ERROR_MESSAGE() AS ErrMsg
END CATCH
GO
SELECT * FROM Customer
GO



--SETTING UP OF REQUIRED STORED PROCEDURES FOR CARDEALERSHIP DATABASE 
USE CarDealership
GO 

--Ensure that stored procedures are not existed initially
DROP PROC IF EXISTS AddNewCustomer
DROP PROC IF EXISTS DeleteCustomer
DROP PROC IF EXISTS UpdateCustomer 

DROP PROC IF EXISTS AddCar
DROP PROC IF EXISTS DeleteCar

DROP PROC IF EXISTS AddNewEmployee
DROP PROC IF EXISTS DeleteEmployee

DROP PROC IF EXISTS AddService
DROP PROC IF EXISTS AddServiceTicket
DROP PROC IF EXISTS AddInvoice
DROP PROC IF EXISTS CustomerGdpr
 
GO 
--CREATE STORED PROCEDURES FOR CARDEALERSHIP DATABASE

--CUSTOMER STORED PROCEDURES
--Add New Customer Stored Procedure
CREATE PROCEDURE AddNewCustomer 
	@FirstName varchar(40),
	@LastName  varchar(40),
	@Address varchar(50),
	@City varchar(20),
	@State varchar(20),
	@PostCode varchar(8),
	@PhoneNumber varchar(15),
	@MobileNumber varchar(15),
	@Email varchar(100),
	@Active char(1)
AS 
BEGIN TRAN 
INSERT INTO Customer values
	(@FirstName ,@LastName  ,@Address,@City,@State ,@PostCode ,
	 @PhoneNumber ,@MobileNumber ,@Email ,@Active )

-- Check if there's an error or no record is added
IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
	BEGIN 
		PRINT 'An Error has occured, no record is added!'
		ROLLBACK TRAN 
		RETURN -1
	END
ELSE
	BEGIN
		PRINT 'New customer is successfully added!'
		COMMIT TRAN 
		RETURN 0
	END

GO 



-- Delete Customer Stored Procedure
-- Note that customer should be non existed or has been deleted to all transaction table like Invoice and service ticket
CREATE PROCEDURE DeleteCustomer 
	@CustomerId int
AS 
-- Declare variables used in error checking.  
DECLARE @ErrorVar INT;  
DECLARE @RowCountVar INT;  
IF @CustomerId is null OR @CustomerId=0 
	BEGIN 
		PRINT 'Invalid Customer Id!'
		RETURN -1
	END
ELSE
	BEGIN 
		BEGIN TRAN 
		DELETE Customer WHERE CustomerId=@CustomerId

		-- Save the @@ERROR and @@ROWCOUNT values in local   
		-- variables before they are cleared.  
		SELECT @ErrorVar = @@ERROR  
			,@RowCountVar = @@ROWCOUNT;  

		-- check for any error 

		IF @ErrorVar <> 0 OR @RowCountVar <> 1
			BEGIN
				PRINT 'An error has occured!'
				ROLLBACK TRAN 
				RETURN -1
			END
		ELSE
			BEGIN
				PRINT 'Customer ID '+ CONVERT(varchar(10),@CustomerId) + ' is successfully deleted!'
				COMMIT TRAN 
				RETURN 0
			END
	END
GO


-- Update Customer Stored Procedure
CREATE PROC UpdateCustomer 
	@CustomerId int,
	@FirstName varchar(40),
	@LastName  varchar(40),
	@Address varchar(50),
	@City varchar(20),
	@State varchar(20),
	@PostCode varchar(8),
	@PhoneNumber varchar(15),
	@MobileNumber varchar(15),
	@Email varchar(100),
	@Active char(1)
AS
-- Declare variables used in error checking.  
DECLARE @ErrorVar INT;  
DECLARE @RowCountVar INT;  

IF @CustomerId IS NULL OR @CustomerId=0
	BEGIN 
		PRINT 'Invalid Customer ID!'
		RETURN -1
	END
ELSE
	BEGIN 
		BEGIN TRAN 
		--Execute the UPDATE statement. 
		--If NULL '' value is passed in any of the parameter, the column will retain its value
		UPDATE Customer SET
			FirstName = (CASE WHEN @FirstName='' THEN Firstname ELSE @FirstName END), 
			LastName  = (CASE WHEN @LastName='' THEN LastName ELSE @LastName END),
			Address   = (CASE WHEN @Address='' THEN Address ELSE @Address END),
			City	  = (CASE WHEN @City='' THEN City ELSE @City END),
			State	  = (CASE WHEN @State='' THEN State ELSE @State END),
			PostCode  = (CASE WHEN @PostCode='' THEN Postcode ELSE @PostCode END), 
			PhoneNumber = (CASE WHEN @PhoneNumber='' THEN PhoneNumber ELSE @PhoneNumber END), 
			MobileNumber =(CASE WHEN @MobileNumber='' THEN MobileNumber ELSE @MobileNumber END), 
			Email = (CASE WHEN @Email='' THEN Email ELSE @Email END),
			Active = (CASE WHEN @Active='' THEN Active ELSE @Active END)
		WHERE CustomerId=@CustomerId
		-- Save the @@ERROR and @@ROWCOUNT values in local   
		-- variables before they are cleared.  
		SELECT @ErrorVar = @@ERROR  
			,@RowCountVar = @@ROWCOUNT;  
		--Check for errors

		IF @ErrorVar <> 0 OR @RowCountVar<>1
			BEGIN 
				PRINT 'An error has occured!'
				ROLLBACK TRAN 
				RETURN -1
			END
		ELSE
			BEGIN
				PRINT 'Customer ID '+ CONVERT(varchar(10),@CustomerId) + ' is successfully Updated!'
				COMMIT TRAN 
				RETURN 0
			END
	END
GO 



--CAR STORED PROCEDURES

--AddNew or Used Car stored procedure
CREATE PROCEDURE AddCar 
	@CarSerialNo char(12),
	@RegistrationNo varchar(15),
	@Make varchar(40),
	@Model varchar(40),
	@Color varchar(30),
	@Status char(10),
	@ForSale char(1)
AS
BEGIN TRAN 
INSERT INTO Car values
	(@CarSerialNo,@RegistrationNo,@Make,@Model,@Color,@Status,@ForSale)

-- Check for any error or if no record is added. 
IF @@ERROR<>0 OR @@ROWCOUNT<>1
	BEGIN
		PRINT 'An Error has occured, no record is added!'
		ROLLBACK TRAN 
		RETURN -1
	END
ELSE
	BEGIN 
		PRINT 'Car is successfully added!'
		COMMIT TRAN 
		RETURN 0
	END

GO 

--DeleteCar Stored Procedure 
CREATE PROC DeleteCar
@CarId int
AS 
-- Declare variables used in error checking.  
DECLARE @ErrorVar INT;  
DECLARE @RowCountVar INT;  
BEGIN TRAN 
-- DELETE statement 
DELETE Car WHERE CarId=@CarId
-- save the ERROR CODE before it is cleared
SELECT @ErrorVar = @@ERROR,
	 @RowCountVar = @@ROWCOUNT
--check for error 
IF @ErrorVar <> 0 OR @RowCountVar <> 1
	BEGIN 
		PRINT 'An Error has occured, record is not deleted!'
		ROLLBACK TRAN
		RETURN -1
	END
ELSE 
	BEGIN 
		PRINT 'Car ID '+ CONVERT(varchar(10),@CarId) + ' is successfully deleted!'
		COMMIT TRAN 
		RETURN 0
	END
GO 




--EMPLOYEE STORED PROCEDURE

--Add New Employee PROCEDURE
CREATE PROC AddNewEmployee
	@PPSNo char(9), 
	@FirstName varchar(40), 
	@LastName varchar(40), 
	@Job varchar(15), 
	@DateStarted datetime
AS
BEGIN TRAN 
INSERT INTO Employee VALUES 
	(@PPSNo,@FirstName,@LastName,@Job,@DateStarted)

-- Check for any error or if no record is added
IF @@ERROR<>0 OR @@ROWCOUNT<>1
	BEGIN 
		PRINT 'An Error has occured, no record is added!'
		ROLLBACK TRAN 
		RETURN -1
	END
ELSE
	BEGIN
		PRINT 'New Employee is successfully added!'
		COMMIT TRAN 
		RETURN 0
	END
GO

--DeleteEmployee Stored Procedure 
CREATE PROC DeleteEmployee
@EmployeeNo char(9)
AS 
IF @EmployeeNo is null  OR @EmployeeNo=''
	BEGIN
		PRINT 'Cannot delete, No Employee given'
		RETURN -1 
	END
ELSE
	BEGIN TRAN 
	-- Declare variables used in error checking.  
	DECLARE @ErrorVar INT;  
	DECLARE @RowCountVar INT;  
	-- DELETE statement 
	DELETE Employee WHERE EmployeeNo=@EmployeeNo
	-- save the ERROR CODE before it is cleared
	SELECT @ErrorVar = @@ERROR,
		 @RowCountVar = @@ROWCOUNT

	--check for error 
	IF @ErrorVar <> 0 OR @RowCountVar <> 1
		BEGIN 
			PRINT 'An Error has occured, record is not deleted!'
			ROLLBACK TRAN
			RETURN -1
		END
	ELSE 
		BEGIN 
			PRINT 'Employee No '+ CONVERT(varchar(10),@EmployeeNo) + ' is successfully deleted!'
			COMMIT TRAN 
			RETURN 0
		END
GO 

-- SERVICE STORED PROCEDURE
-- Add New Service
CREATE PROC AddService
	@ServiceName varchar(50),
	@ServiceType char(8),
	@ServiceRate decimal(7,2),
	@ServiceDesc varchar(200)
AS 
BEGIN TRAN 
INSERT INTO Service VALUES 
	(@ServiceName,@ServiceType,@ServiceRate,@ServiceDesc)
IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
	BEGIN
		PRINT 'An error has occured, no record is added!'
		ROLLBACK TRAN 
		RETURN -1
	END
ELSE
	BEGIN
		PRINT 'New service is successfully added!'
		COMMIT TRAN 
		RETURN 0
	END
GO 


-- SERVICE TICKET STORED PROCEDURE
-- Add New Service Ticket
CREATE PROC AddServiceTicket
	@CustomerId int,
	@CarId int,
	@MechanicId char(9),
	@Serviceid int, 
	@TicketDate datetime,
	@DateReceive datetime,
	@DateReturn datetime, 
	@Comment varchar(200)
AS
BEGIN TRAN 
INSERT INTO ServiceTicket VALUES 
	(@CustomerId,@CarId,@MechanicId,@Serviceid,@TicketDate,@DateReceive,@DateReturn,@Comment)
--Check for any error or no record is added
IF @@ERROR<>0 OR @@ROWCOUNT <> 1
	BEGIN
		PRINT 'An Error has occured, no record is added!'
		ROLLBACK TRAN 
		RETURN -1
	END
ELSE
	BEGIN 
		PRINT 'New Service Ticket is successfully added!'
		COMMIT TRAN 
		RETURN 0
	END
GO


--INVOICE STORED PROCEDURE
-- Add New Invoice Stored Procedure 
CREATE PROC AddInvoice
   @CustomerId int,
   @CarId int, 
   @EmployeeNo char(9),
   @TicketId int, 
   @InvoiceDate datetime,
   @InvoiceType char(10),
   @InvoiceAmount decimal(10,2)
AS
BEGIN TRAN 
INSERT INTO Invoice VALUES
	(@CustomerId,@CarId,@EmployeeNo,
	 @TicketId,@InvoiceDate,
	 @InvoiceType,@InvoiceAmount)
-- check for any error if no record is added
IF @@ERROR <> 0 OR @@ROWCOUNT<>1
	BEGIN
		PRINT 'An error has occured, no record is added!'
		ROLLBACK TRAN
		RETURN -1
	END
ELSE
	BEGIN 
		PRINT 'New invoice is successfully added!'
		COMMIT TRAN 
		RETURN 0
	END
GO




--PROCEDURE FOR GDPR ANONYMIZE
CREATE PROC CustomerGdpr
	@CustomerId int	
AS 
-- Declare variables used in error checking.  
DECLARE @ErrorVar INT;  
DECLARE @RowCountVar INT;  


-- Check if @CustomerId has invalid value
IF @CustomerId is null OR @CustomerId='' OR @CustomerId=0 
	BEGIN
		PRINT 'Error : Customer ID cannot be null or 0'		
		RETURN -1
	END

ELSE
	BEGIN 
		BEGIN TRAN 
		-- Execute the UPDATE statement.  
		UPDATE Customer SET 
			FirstName='GDPR',
			LastName='GDPR',
			Address='GDPR',
			City='GDPR',
			State='GDPR',
			Postcode='GDPR',
			PhoneNumber='GDPR',
			MobileNumber='GDPR',
			Email='GDPR',
			Active='N'
		WHERE CustomerId=@CustomerId

		-- Save the @@ERROR and @@ROWCOUNT values in local   
		-- variables before they are cleared.  
		SELECT @ErrorVar = @@ERROR  
			,@RowCountVar = @@ROWCOUNT;  
	
		-- Check if there is an error with the update
		IF @ErrorVar <> 0 
			BEGIN 
				PRINT 'An Error has occured!'	
				ROLLBACK TRAN 
				RETURN -1
			END

		-- Check the row count. @RowCountVar is set to 0   
		-- if an invalid @CustomerId was specified and no record affected.  
		IF @RowCountVar=0
			BEGIN
				PRINT 'Error: Invalid Customer ID, No record is anonimized!'	
				ROLLBACK TRAN 
				RETURN -1
			END
		ELSE 
			BEGIN
				PRINT 'Customer ID ' + CONVERT(varchar(10),@CustomerId) +' is Successfully Anonimized!'
				COMMIT TRAN 
				RETURN 0
			END
	END

GO

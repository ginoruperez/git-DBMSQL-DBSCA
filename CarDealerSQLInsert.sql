
-- SETUP THE INITIAL TEST DATA
-- Populate all tables with test data
USE CarDealership
GO 

-- Car Table 
INSERT INTO Car values 
	('SERF02281978','19782-FXYZ-1','Ford','1978-Fiesta','Blue','USED','Y'),
	('SERT12102021','20193-TWB-2' ,'Toyota','2019-Toyota Yaris','White','NEW','Y'),
	('SERB06051998','19984-BMW-3','BMW','1998-Sports Compact Car','Black','USED','N'),
	('SERM21102020','202010-MTB-4','Mitsubishi','Mitsubishi Gallant','Golden Brown','NEW','Y'),
	('SERT04081995','199504-TYT-5','Toyota','1995-Toyota Corolla','Red','SRV','N'),
	('SERK02072015','201502-VLV-6','Volvo','2015-Volvo V60','Silver Gray','SRV','N'),
    ('SERH05322021','20215-HNC-2','Honda',  '2021-Honda Civic','Red','NEW','Y'),
	('SERR08042020','2020-RENL-8','Renault','2020-Renault Clio','Golden Brown','NEW','Y'),
	('SERPG0901199','1998-PEGT-9','Peugeot','1998-Peugeot 504','Pearl White','USED','N'),
	('SERPG0242467','20203-TYT-3','Toyota','2020-Toyota XA','Yellow','NEW','Y')
GO
SELECT * FROM Car
GO

-- Customer Table 
INSERT INTO Customer values
	('John','Smith','145 Priory Square St. Raphaels Manor','Celbridge','Kildare',
		'W23 DE47','012354891','0892216657','johnsmith@mail.com','Y'),
	('Stephen','Jacobs','Apt 12 The Old Oak Town','Dublin','Dublin',
		'DU1 TE34','016235889','0831583364','stephen.jacobs@abc.com','Y'),
	('Corazon','De Ocampo','12th Main Street Palace Square','Dundulk','Louth',
		'L56 QT90','013259988','0824515568','cora_de_ocampo@xyz.com','Y'),
	('Ma. Teresa','Villafuerte','25 Santiago Street Old Mill','Lucan','Dublin',
		'M27 LU89','015554879','0894572835','materesavillafuerte@mail.com','Y'),
	('Francisco','De Chavez','33 Henry Street Siena Villa','Dublin','Dublin',
		'H21 V72','019782257','0852645527','pacodechavez@gmail.com','Y'),
	('Wilfredo','Aquino','Apt 3 Twin Tower','Waterford','Munster',
		'A36 M92','013352936','0871795064','willieaquino@yahoo.ie','N'),
	('Barry','Pierce','72 East Riverdock House','Limirick','Munster',
					    'L23 M38','012567412','0831463351','barry_pierce@outlook.com','Y')

GO
SELECT * from customer
GO 

-- Employee Table 
INSERT INTO Employee values 
	('1998236XY','John','Ireland','SALESMAN','03/31/2000'),
	('1172590TG','David John Andrew','Walker','MECHANIC','02/25/2002'),
	('3567882QR','Gerry','Benson','SALESMAN','08/12/2015'),
	('7891759KL','Philip','Stewart','MECHANIC','06/02/2010'),
	('8563391PH','Katherine','Jones','SALESMAN','07/29/2018'),
	('4573685DM','Dante','Macaraeg','MECHANIC','06/30/2012'),
	('451SDSDMX','Quintin','Tarantino','MECHANIC','02/28/1992')

GO 
SELECT * from Employee
GO 

-- Service Table 
INSERT INTO Service values 
('Full Car Service','SERVICE',100,'Services : Change Oil, Change Filter, Sparks plug Replacement, Lights, Tyres, Electrical, wheel bearing, A/C and brake inspection'),
('Basic Car Service','SERVICE',50,'Services : Change Oil, Change Filter, Lights and Tyres Inspection'),
('Tyres Repair','REPAIR',40,''),
('Spark Plug Replacement','REPAIR',20,''),
('Fuel Cap Tightening','SERVICE',10,'')
GO
SELECT * from Service
GO 

-- ServiceTicket Table 
INSERT INTO ServiceTicket values	
(5,5,'7891759KL',3,'4/17/2021','4/17/2021','4/20/2021','NEED TO RETURN AFTER A MONTH'),
(5,5,'1172590TG',1,'8/15/2020','8/15/2020','8/16/2020','PREFERRED TO HAVE A FULL SERVICE'),
(4,6,'7891759KL',2,'1/31/2020','1/31/2020','1/31/2020','AVAILING OF BASIC SERVICE'),
(2,4,'451SDSDMX',5,'5/4/2021','5/4/2021','5/5/2021','Loose fuel cap, need tightening')
GO
SELECT * FROM ServiceTicket
GO

-- Invoice Table
INSERT INTO Invoice values
	(1,1,'1998236XY',0,'01/03/2021','SALESINV',500.00),
	(2,2,'1172590TG',0,'12/11/2020','SALESINV',45000.00),
	(5,5,'7891759KL',1,'04/20/2021','SERVICEINV',40),
	(5,5,'1172590TG',2,'08/16/2020','SERVICEINV',100),
	(4,6,'7891759KL',3,'01/31/2020','SERVICEINV',50),
	(3,9,'8563391PH',0,'03/28/2021','SALESINV',10000),
	(2,4,'451SDSDMX',4,'05/05/2021','SERVICEINV',10)
GO	

SELECT * from Invoice

GO
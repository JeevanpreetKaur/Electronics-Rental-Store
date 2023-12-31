CREATE SCHEMA `projectalpha` ;

CREATE TABLE `projectalpha`.`staff` (
    `SID` INT NOT NULL AUTO_INCREMENT ,
    `fName` VARCHAR(45) NOT NULL,
    `lName` VARCHAR(45) NULL,
    `SupervisorID` INT NULL ,
    `StoreID` INT NULL,
    PRIMARY KEY (`SID`)
);
  ALTER TABLE `projectalpha`.`staff` 
CHANGE COLUMN `SID` `SID` INT NOT NULL ,
CHANGE COLUMN `fName` `fName` VARCHAR(45) NULL ,
CHANGE COLUMN `SupervisorID` `SupervisorID` INT NULL DEFAULT NULL ,
CHANGE COLUMN `StoreID` `StoreID` INT NULL DEFAULT NULL;


CREATE TABLE `projectalpha`.`product` (
    `ProductID` int NOT NULL AUTO_INCREMENT ,
    `Product_Title` VARCHAR(45) NOT NULL,
    `Product_Name` VARCHAR(45) NOT NULL,
    `BrandID` INT NOT NULL ,
    `SID` INT NULL,
    PRIMARY KEY (`ProductID`)
);
  
  
CREATE TABLE `projectalpha`.`brand` (
    `BrandID` int NOT NULL AUTO_INCREMENT,
    `Name` VARCHAR(20) NULL,
    `Model` VARCHAR(15) NULL,
    PRIMARY KEY (`BrandID`)
);

CREATE TABLE `projectalpha`.`category` (
    `CatID` int NOT NULL AUTO_INCREMENT ,
    `type` VARCHAR(45) NULL,
    PRIMARY KEY (`CatID`)
);

CREATE TABLE `projectalpha`.`store` (
    `StoreID` int NOT NULL AUTO_INCREMENT ,
    `Country` VARCHAR(45) NULL,
    `City` VARCHAR(45) NULL,
    `PostCode` VARCHAR(7) NULL,
    `Province` VARCHAR(45) NULL,
    PRIMARY KEY (`StoreID`)
);

CREATE TABLE `projectalpha`.`customer` (
    `CusID` int NOT NULL AUTO_INCREMENT,
    `fName` VARCHAR(45) NULL,
    `lName` VARCHAR(45) NULL,
    `D.O.B` VARCHAR(45) NULL,
    `Identity_Proof` INT NULL,
    `Street` VARCHAR(45) NULL,
    `City` VARCHAR(45) NULL,
    `Postcode` VARCHAR(45) NULL,
    `telNo` CHAR(14) NULL,
    PRIMARY KEY (`CusID`)
);

CREATE TABLE `projectalpha`.`product_category` (
    `ProductID` INT NULL,
    `CatID` INT NULL
);

CREATE TABLE `projectalpha`.`product_in_store` (
    `ProductID` INT NULL,
    `StoreID` INT NULL
);

CREATE TABLE `projectalpha`.`rent` (
    `RentID` int NOT NULL AUTO_INCREMENT ,
    `PaymentMethod` VARCHAR(45) NULL,
    `Paydate` VARCHAR(45) NULL,
    `CusID` INT NOT NULL,
    PRIMARY KEY (`RentID`),
    FOREIGN KEY (`CusID`)
        REFERENCES `projectalpha`.`customer` (`CusID`)
);

CREATE TABLE `projectalpha`.`booking` (
    `BookingID` int NOT NULL AUTO_INCREMENT ,
    `ReturnDate` VARCHAR(45) NULL,
    `PickupDate` VARCHAR(45) NULL,
    `CusID` INT NULL,
    `ProductID` INT NULL,
    PRIMARY KEY (`BookingID`)
);

ALTER TABLE `projectalpha`.`booking` 
ADD INDEX `CusID_idx` (`CusID` ASC) VISIBLE,
ADD INDEX `ProductID_idx` (`ProductID` ASC) VISIBLE;
;
ALTER TABLE `projectalpha`.`booking` 
ADD CONSTRAINT `CusID`
  FOREIGN KEY (`CusID`)
  REFERENCES `projectalpha`.`customer` (`CusID`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `ProductID`
  FOREIGN KEY (`ProductID`)
  REFERENCES `projectalpha`.`product` (`ProductID`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
  
  ALTER TABLE `projectalpha`.`staff` 
ADD CONSTRAINT `StoreID1`
  FOREIGN KEY (`StoreID`)
  REFERENCES `projectalpha`.`store` (`StoreID`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
ALTER TABLE `projectalpha`.`product` 
ADD INDEX `SID_idx` (`SID` ASC) VISIBLE;
;
ALTER TABLE `projectalpha`.`product` 
ADD CONSTRAINT `SID`
  FOREIGN KEY (`SID`)
  REFERENCES `projectalpha`.`staff` (`SID`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
  ALTER TABLE `projectalpha`.`staff` 
ADD CONSTRAINT `StoreID`
  FOREIGN KEY (`StoreID`)
  REFERENCES `projectalpha`.`store` (`StoreID`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
  
ALTER TABLE `projectalpha`.`brand` 
CHANGE COLUMN `BrandID` `BrandID` int NOT NULL ;

ALTER TABLE `projectalpha`.`product` 
ADD INDEX `BrandID_idx` (`BrandID` ASC) VISIBLE;
;
ALTER TABLE `projectalpha`.`product` 
ADD CONSTRAINT `BrandID1`
  FOREIGN KEY (`BrandID`)
  REFERENCES `projectalpha`.`brand` (`BrandID`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
  
  ALTER TABLE `projectalpha`.`product_category` 
ADD CONSTRAINT `ProductID_1`
  FOREIGN KEY (`ProductID`)
  REFERENCES `projectalpha`.`product` (`ProductID`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

ALTER TABLE `projectalpha`.`product_category` 
ADD CONSTRAINT `CatID_1`
  FOREIGN KEY (`CatID`)
  REFERENCES `projectalpha`.`category` (`CatID`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

ALTER TABLE `projectalpha`.`product_in_store` 
ADD CONSTRAINT `ProductID_2`
  FOREIGN KEY (`ProductID`)
  REFERENCES `projectalpha`.`product` (`ProductID`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

ALTER TABLE `projectalpha`.`product_in_store` 
ADD CONSTRAINT `Store_ID`
  FOREIGN KEY (`StoreID`)
  REFERENCES `projectalpha`.`store` (`StoreID`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
  
  ALTER TABLE `projectalpha`.`rent` 
ADD COLUMN `Rent Amount` VARCHAR(10) NULL AFTER `CusID`;

ALTER TABLE `projectalpha`.`staff` 
ADD CONSTRAINT `SupervisorID_1`
  FOREIGN KEY (`SupervisorID`)
  REFERENCES `projectalpha`.`staff` (`SID`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
  
  ALTER TABLE `projectalpha`.`staff` 
DROP FOREIGN KEY `StoreID`,
DROP FOREIGN KEY `SupervisorID_1`;
ALTER TABLE `projectalpha`.`staff` 
ADD CONSTRAINT `StoreID`
  FOREIGN KEY (`StoreID`)
  REFERENCES `projectalpha`.`store` (`StoreID`)
  ON DELETE CASCADE
  ON UPDATE CASCADE,
ADD CONSTRAINT `SupervisorID_1`
  FOREIGN KEY (`SupervisorID`)
  REFERENCES `projectalpha`.`staff` (`SID`)
  ON DELETE CASCADE
  ON UPDATE CASCADE;

ALTER TABLE `projectalpha`.`product` 
ADD CONSTRAINT `BrandID`
  FOREIGN KEY (`BrandID`)
  REFERENCES `projectalpha`.`brand` (`BrandID`)
  ON DELETE CASCADE
  ON UPDATE CASCADE,
ADD CONSTRAINT `SID1`
  FOREIGN KEY (`SID`)
  REFERENCES `projectalpha`.`staff` (`SID`)
  ON DELETE CASCADE
  ON UPDATE CASCADE;
ALTER TABLE `projectalpha`.`product_category` 
DROP FOREIGN KEY `CatID_1`,
DROP FOREIGN KEY `ProductID_1`;
ALTER TABLE `projectalpha`.`product_category` 
ADD CONSTRAINT `CatID_1`
  FOREIGN KEY (`CatID`)
  REFERENCES `projectalpha`.`category` (`CatID`)
  ON DELETE CASCADE
  ON UPDATE CASCADE,
ADD CONSTRAINT `ProductID_1`
  FOREIGN KEY (`ProductID`)
  REFERENCES `projectalpha`.`product` (`ProductID`)
  ON DELETE CASCADE
  ON UPDATE CASCADE;
ALTER TABLE `projectalpha`.`product_in_store` 
DROP FOREIGN KEY `ProductID_2`,
DROP FOREIGN KEY `Store_ID`;
ALTER TABLE `projectalpha`.`product_in_store` 
ADD CONSTRAINT `ProductID_2`
  FOREIGN KEY (`ProductID`)
  REFERENCES `projectalpha`.`product` (`ProductID`)
  ON DELETE CASCADE
  ON UPDATE CASCADE,
ADD CONSTRAINT `Store_ID`
  FOREIGN KEY (`StoreID`)
  REFERENCES `projectalpha`.`store` (`StoreID`)
  ON DELETE CASCADE
  ON UPDATE CASCADE;
ALTER TABLE `projectalpha`.`rent` 
DROP FOREIGN KEY `rent_ibfk_1`;
ALTER TABLE `projectalpha`.`rent` 
ADD CONSTRAINT `rent_ibfk_1`
  FOREIGN KEY (`CusID`)
  REFERENCES `projectalpha`.`customer` (`CusID`)
  ON DELETE CASCADE
  ON UPDATE CASCADE;
ALTER TABLE `projectalpha`.`booking` 
DROP FOREIGN KEY `CusID`,
DROP FOREIGN KEY `ProductID`;
ALTER TABLE `projectalpha`.`booking` 
ADD CONSTRAINT `CusID`
  FOREIGN KEY (`CusID`)
  REFERENCES `projectalpha`.`customer` (`CusID`)
  ON DELETE CASCADE
  ON UPDATE CASCADE,
ADD CONSTRAINT `ProductID`
  FOREIGN KEY (`ProductID`)
  REFERENCES `projectalpha`.`product` (`ProductID`)
  ON DELETE CASCADE
  ON UPDATE CASCADE;
ALTER TABLE `projectalpha`.`product_in_store` 
DROP FOREIGN KEY `ProductID_2`,
DROP FOREIGN KEY `Store_ID`;
ALTER TABLE `projectalpha`.`product_in_store` 
CHANGE COLUMN `ProductID` `ProductID` INT NOT NULL ,
CHANGE COLUMN `StoreID` `StoreID` INT NOT NULL ,
ADD PRIMARY KEY (`StoreID`, `ProductID`);
;
ALTER TABLE `projectalpha`.`product_in_store` 
ADD CONSTRAINT `ProductID_2`
  FOREIGN KEY (`ProductID`)
  REFERENCES `projectalpha`.`product` (`ProductID`)
  ON DELETE CASCADE
  ON UPDATE CASCADE,
ADD CONSTRAINT `Store_ID`
  FOREIGN KEY (`StoreID`)
  REFERENCES `projectalpha`.`store` (`StoreID`)
  ON DELETE CASCADE
  ON UPDATE CASCADE;

 
ALTER TABLE `projectalpha`.`customer` 
CHANGE COLUMN `Identity_Proof` `Identity_Proof` VARCHAR(20) NULL DEFAULT NULL ;

INSERT INTO `projectalpha`.`customer` (`CusID`, `fName`, `lName`, `D.O.B`, `Identity_Proof`, `Street`, `City`, `Postcode`, `telNo`) VALUES ('1', 'Lewis', 'Hamilton', '12/24/2001', 'Driving lisence ', '252 Hudson Street', 'Birmingham', '141001', '0161-421-1452');
INSERT INTO `projectalpha`.`customer` (`CusID`, `fName`, `lName`, `D.O.B`, `Identity_Proof`, `Street`, `City`, `Postcode`, `telNo`) VALUES ('2', 'Justeen', 'Bieber', '08/22/1990', 'ID Card', '2220 Kingsway', 'California', 'V5N7K8', '0178-678-9875');
INSERT INTO `projectalpha`.`customer` (`CusID`, `fName`, `lName`, `D.O.B`, `Identity_Proof`, `Street`, `City`, `Postcode`, `telNo`) VALUES ('3', 'Kim', 'Kardashin', '01/05/2001', 'BCID ', '9258 124ST ', 'Surrey', 'V3V4S3', '+16046667896');
INSERT INTO `projectalpha`.`customer` (`CusID`, `fName`, `lName`, `D.O.B`, `Identity_Proof`, `Street`, `City`, `Postcode`, `telNo`) VALUES ('4', 'Nick ', 'Jonas', '12/05/1990', 'Passport', '1452 Bakersfield st ', 'California', 'D4R3F4', '+1125394752');
INSERT INTO `projectalpha`.`customer` (`CusID`, `fName`, `lName`, `D.O.B`, `Identity_Proof`, `Street`, `City`, `Postcode`, `telNo`) VALUES ('5', 'Vishu ', 'Bhalla', '12/06/1999', 'Aadhaar card', '124 Bajwa colony', 'Punjab', '13096', '+91807050031');


INSERT INTO `projectalpha`.`store` (`StoreID`, `Country`, `City`, `PostCode`, `Province`) VALUES ('5111', 'Canada', 'Vancouver', 'V4C2T5', 'BC');
INSERT INTO `projectalpha`.`store` (`StoreID`, `Country`, `City`, `PostCode`, `Province`) VALUES ('5853', 'America', 'Boston', 'Y4C8W5', 'Massachusetts');


INSERT INTO `projectalpha`.`staff` (`SID`, `fName`, `lName`, `SupervisorID`, `StoreID`) VALUES ('1', 'Jane', 'Ruper', NULL, '5853');
INSERT INTO `projectalpha`.`staff` (`SID`, `fName`, `lName`, `StoreID`) VALUES ('2', 'Andy', 'Lo', '5111');
INSERT INTO `projectalpha`.`staff` (`SID`, `fName`, `lName`, `SupervisorID`, `StoreID`) VALUES ('3', 'Jake', 'Gilbert', null, '5111');
INSERT INTO `projectalpha`.`staff` (`SID`, `fName`, `lName`, `SupervisorID`, `StoreID`) VALUES ('4', 'Rahul', 'Sharma',NULL, '5111');
INSERT INTO `projectalpha`.`staff` (`SID`, `fName`, `lName`, `SupervisorID`, `StoreID`) VALUES ('5', 'Sam', 'Croften', NULL, '5853');


UPDATE `projectalpha`.`staff` SET `SupervisorID` = '2' WHERE (`SID` = '3');
UPDATE `projectalpha`.`staff` SET `SupervisorID` = '5' WHERE (`SID` = '4');

ALTER TABLE `projectalpha`.`brand` 
DROP COLUMN `Model`;

INSERT INTO `projectalpha`.`brand` (`BrandID`, `Name`) VALUES ('1', 'Apple');
INSERT INTO `projectalpha`.`brand` (`BrandID`, `Name`) VALUES ('2', 'Samsung');
INSERT INTO `projectalpha`.`brand` (`BrandID`, `Name`) VALUES ('3', 'Asus');
INSERT INTO `projectalpha`.`brand` (`BrandID`, `Name`) VALUES ('4', 'Acer');
INSERT INTO `projectalpha`.`brand` (`BrandID`, `Name`) VALUES ('5', 'Sony');
INSERT INTO `projectalpha`.`brand` (`BrandID`, `Name`) VALUES ('6', 'Nikkon');
INSERT INTO `projectalpha`.`brand` (`BrandID`, `Name`) VALUES ('7', 'Alienware');
INSERT INTO `projectalpha`.`brand` (`BrandID`, `Name`) VALUES ('8', 'Hp');

INSERT INTO `projectalpha`.`product` (`ProductID`, `Product_Title`, `Product_Name`, `BrandID`, `SID`) VALUES ('1', 'Phone', 'Iphone 13 pro', '1', '2');
INSERT INTO `projectalpha`.`product` (`ProductID`, `Product_Title`, `Product_Name`, `BrandID`, `SID`) VALUES ('2', 'Phone', 'S22 Ultra', '2', '4');
INSERT INTO `projectalpha`.`product` (`ProductID`, `Product_Title`, `Product_Name`, `BrandID`, `SID`) VALUES ('3', 'Laptop', 'TUF gaming', '3', '3');
INSERT INTO `projectalpha`.`product` (`ProductID`, `Product_Title`, `Product_Name`, `BrandID`, `SID`) VALUES ('4', 'Laptop', 'Nitro 5', '4', '1');
INSERT INTO `projectalpha`.`product` (`ProductID`, `Product_Title`, `Product_Name`, `BrandID`, `SID`) VALUES ('5', 'Tablet', 'Ipad Air', '1', '2');
INSERT INTO `projectalpha`.`product` (`ProductID`, `Product_Title`, `Product_Name`, `BrandID`, `SID`) VALUES ('6', 'Tablet', 'Galaxy Tab', '2', '5');
INSERT INTO `projectalpha`.`product` (`ProductID`, `Product_Title`, `Product_Name`, `BrandID`, `SID`) VALUES ('7', 'Camera', 'A6600x', '5', '1');
INSERT INTO `projectalpha`.`product` (`ProductID`, `Product_Title`, `Product_Name`, `BrandID`, `SID`) VALUES ('8', 'Camera', '5500x', '6', '3');
INSERT INTO `projectalpha`.`product` (`ProductID`, `Product_Title`, `Product_Name`, `BrandID`, `SID`) VALUES ('9', 'PC', 'A56 custom', '7', '4');
INSERT INTO `projectalpha`.`product` (`ProductID`, `Product_Title`, `Product_Name`, `BrandID`, `SID`) VALUES ('10', 'PC', 'Spectre rig', '8', '5');

ALTER TABLE `projectalpha`.`product_category` 
DROP FOREIGN KEY `CatID_1`,
DROP FOREIGN KEY `ProductID_1`;
ALTER TABLE `projectalpha`.`product_category` 
CHANGE COLUMN `ProductID` `ProductID` INT NOT NULL ,
CHANGE COLUMN `CatID` `CatID` INT NOT NULL ,
ADD PRIMARY KEY (`CatID`, `ProductID`);
;
ALTER TABLE `projectalpha`.`product_category` 
ADD CONSTRAINT `CatID_1`
  FOREIGN KEY (`CatID`)
  REFERENCES `projectalpha`.`category` (`CatID`)
  ON DELETE CASCADE
  ON UPDATE CASCADE,
ADD CONSTRAINT `ProductID_1`
  FOREIGN KEY (`ProductID`)
  REFERENCES `projectalpha`.`product` (`ProductID`)
  ON DELETE CASCADE
  ON UPDATE CASCADE;


INSERT INTO `projectalpha`.`category` (`CatID`, `type`) VALUES ('1', 'Phone');
INSERT INTO `projectalpha`.`category` (`CatID`, `type`) VALUES ('2', 'Laptop');
INSERT INTO `projectalpha`.`category` (`CatID`, `type`) VALUES ('3', 'Tablet');
INSERT INTO `projectalpha`.`category` (`CatID`, `type`) VALUES ('4', 'PC');
INSERT INTO `projectalpha`.`category` (`CatID`, `type`) VALUES ('5', 'Camera');


INSERT INTO `projectalpha`.`product_category` (`ProductID`, `CatID`) VALUES ('1', '1');
INSERT INTO `projectalpha`.`product_category` (`ProductID`, `CatID`) VALUES ('2', '1');
INSERT INTO `projectalpha`.`product_category` (`ProductID`, `CatID`) VALUES ('3', '2');
INSERT INTO `projectalpha`.`product_category` (`ProductID`, `CatID`) VALUES ('4', '2');
INSERT INTO `projectalpha`.`product_category` (`ProductID`, `CatID`) VALUES ('5', '3');
INSERT INTO `projectalpha`.`product_category` (`ProductID`, `CatID`) VALUES ('6', '3');
INSERT INTO `projectalpha`.`product_category` (`ProductID`, `CatID`) VALUES ('7', '5');
INSERT INTO `projectalpha`.`product_category` (`ProductID`, `CatID`) VALUES ('8', '5');
INSERT INTO `projectalpha`.`product_category` (`ProductID`, `CatID`) VALUES ('9', '4');
INSERT INTO `projectalpha`.`product_category` (`ProductID`, `CatID`) VALUES ('10', '4');


INSERT INTO `projectalpha`.`product_in_store` (`ProductID`, `StoreID`) VALUES ('1', '5853');
INSERT INTO `projectalpha`.`product_in_store` (`ProductID`, `StoreID`) VALUES ('2', '5111');
INSERT INTO `projectalpha`.`product_in_store` (`ProductID`, `StoreID`) VALUES ('3', '5111');
INSERT INTO `projectalpha`.`product_in_store` (`ProductID`, `StoreID`) VALUES ('4', '5111');
INSERT INTO `projectalpha`.`product_in_store` (`ProductID`, `StoreID`) VALUES ('5', '5853');
INSERT INTO `projectalpha`.`product_in_store` (`ProductID`, `StoreID`) VALUES ('6', '5853');
INSERT INTO `projectalpha`.`product_in_store` (`ProductID`, `StoreID`) VALUES ('7', '5111');
INSERT INTO `projectalpha`.`product_in_store` (`ProductID`, `StoreID`) VALUES ('8', '5853');
INSERT INTO `projectalpha`.`product_in_store` (`ProductID`, `StoreID`) VALUES ('9', '5111');
INSERT INTO `projectalpha`.`product_in_store` (`ProductID`, `StoreID`) VALUES ('10', '5853');

INSERT INTO `projectalpha`.`rent` (`RentID`, `PaymentMethod`, `Paydate`, `CusID`, `Rent Amount`) VALUES ('3423', 'Debit', '05/10/2022', '3', '$150');
INSERT INTO `projectalpha`.`rent` (`RentID`, `PaymentMethod`, `Paydate`, `CusID`, `Rent Amount`) VALUES ('4356', 'Cash', '07/12/2022', '5', '$200');
INSERT INTO `projectalpha`.`rent` (`RentID`, `PaymentMethod`, `Paydate`, `CusID`, `Rent Amount`) VALUES ('4213', 'Cash', '11/12/2022', '1', '$600');
INSERT INTO `projectalpha`.`rent` (`RentID`, `PaymentMethod`, `Paydate`, `CusID`, `Rent Amount`) VALUES ('1042', 'Debit', '11/07/2022', '2', '$320');
INSERT INTO `projectalpha`.`rent` (`RentID`, `PaymentMethod`, `Paydate`, `CusID`, `Rent Amount`) VALUES ('4235', 'Debit', '12/1/2022', '4', '$500');

INSERT INTO `projectalpha`.`booking` (`BookingID`, `ReturnDate`, `PickupDate`, `CusID`, `ProductID`) VALUES ('21', '06/11/2022', '05/11/2022', '3', '7');
INSERT INTO `projectalpha`.`booking` (`BookingID`, `ReturnDate`, `PickupDate`, `CusID`, `ProductID`) VALUES ('24', '07/30/2022', '07/14/2022', '5', '2');
INSERT INTO `projectalpha`.`booking` (`BookingID`, `ReturnDate`, `PickupDate`, `CusID`, `ProductID`) VALUES ('56', '12/31/2022', '11/13/2022', '1', '9');
INSERT INTO `projectalpha`.`booking` (`BookingID`, `ReturnDate`, `PickupDate`, `CusID`, `ProductID`) VALUES ('32', '12/07/2022', '11/08/2022', '2', '3');
INSERT INTO `projectalpha`.`booking` (`BookingID`, `ReturnDate`, `PickupDate`, `CusID`, `ProductID`) VALUES ('34', '01/3/2023', '12/4/2022', '4', '10');



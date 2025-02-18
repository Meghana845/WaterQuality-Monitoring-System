-- Step 1: Create Database
CREATE DATABASE WaterQualityManagement;
USE WaterQualityManagement;

-- Step 2: Create State Table
CREATE TABLE State (
    StateID INT AUTO_INCREMENT PRIMARY KEY,
    StateName VARCHAR(50) UNIQUE NOT NULL
);

-- Step 3: Create Location Table
CREATE TABLE Location (
    LocationID INT AUTO_INCREMENT PRIMARY KEY,
    StateID INT,
    CountyName VARCHAR(100) UNIQUE NOT NULL,
    Latitude DECIMAL(9,6),
    Longitude DECIMAL(9,6),
    FOREIGN KEY (StateID) REFERENCES State(StateID)
);

-- Step 4: Create Station Table
CREATE TABLE Station (
    StationID INT AUTO_INCREMENT PRIMARY KEY,
    StationNumber VARCHAR(50) UNIQUE NOT NULL,
    StationType VARCHAR(50) NOT NULL,
    LocationID INT,
    FOREIGN KEY (LocationID) REFERENCES Location(LocationID)
);

-- Step 5: Create Sample Status Table
CREATE TABLE SampleStatus (
    SampleStatusID INT AUTO_INCREMENT PRIMARY KEY,
    StatusName VARCHAR(50) UNIQUE NOT NULL
);

-- Step 6: Create Sample Table
CREATE TABLE Sample (
    SampleID INT AUTO_INCREMENT PRIMARY KEY,
    StationID INT,
    SampleCode VARCHAR(50) UNIQUE NOT NULL,
    SampleDate DATE NOT NULL,
    SampleDepth DECIMAL(5,2),
    SampleDepthUnits VARCHAR(10),
    SampleStatusID INT,
    FOREIGN KEY (StationID) REFERENCES Station(StationID),
    FOREIGN KEY (SampleStatusID) REFERENCES SampleStatus(SampleStatusID)
);

-- Step 7: Create Parameter Types Table
CREATE TABLE ParameterTypes (
    ParameterTypeID INT AUTO_INCREMENT PRIMARY KEY,
    TypeName VARCHAR(50) UNIQUE NOT NULL
);

-- Step 8: Create Parameter Table
CREATE TABLE Parameter (
    ParameterID INT AUTO_INCREMENT PRIMARY KEY,
    ParameterName VARCHAR(100) UNIQUE NOT NULL,
    ParameterTypeID INT,
    FdrResult DECIMAL(10,2),
    FdrReportingLimit DECIMAL(10,2),
    FOREIGN KEY (ParameterTypeID) REFERENCES ParameterTypes(ParameterTypeID)
);

-- Step 9: Create Analysis Table
CREATE TABLE Analysis (
    AnalysisID INT AUTO_INCREMENT PRIMARY KEY,
    SampleID INT,
    ParameterID INT,
    Result DECIMAL(10,2),
    Units VARCHAR(20),
    FOREIGN KEY (SampleID) REFERENCES Sample(SampleID),
    FOREIGN KEY (ParameterID) REFERENCES Parameter(ParameterID)
);

-- Step 10: Create Water Quality Standard Table
CREATE TABLE WaterQualityStandard (
    StandardID INT AUTO_INCREMENT PRIMARY KEY,
    ParameterID INT,
    MaximumAllowedValue DECIMAL(10,2),
    StandardSource VARCHAR(100),
    FOREIGN KEY (ParameterID) REFERENCES Parameter(ParameterID)
);

-- Step 11: Create Method Types Table
CREATE TABLE MethodTypes (
    MethodTypeID INT AUTO_INCREMENT PRIMARY KEY,
    TypeName VARCHAR(50) UNIQUE NOT NULL
);

-- Step 12: Create Method Table
CREATE TABLE Method (
    MethodID INT AUTO_INCREMENT PRIMARY KEY,
    MethodName VARCHAR(100) UNIQUE NOT NULL,
    MethodTypeID INT,
    FOREIGN KEY (MethodTypeID) REFERENCES MethodTypes(MethodTypeID)
);

-- Step 13: Create Sample_Parameter (Bridge Table)
CREATE TABLE Sample_Parameter (
    SampleID INT,
    ParameterID INT,
    PRIMARY KEY (SampleID, ParameterID),
    FOREIGN KEY (SampleID) REFERENCES Sample(SampleID),
    FOREIGN KEY (ParameterID) REFERENCES Parameter(ParameterID)
);

-- Step 14: Create Analysis_Method (Bridge Table)
CREATE TABLE Analysis_Method (
    AnalysisID INT,
    MethodID INT,
    PRIMARY KEY (AnalysisID, MethodID),
    FOREIGN KEY (AnalysisID) REFERENCES Analysis(AnalysisID),
    FOREIGN KEY (MethodID) REFERENCES Method(MethodID)
);



-- Show databases
SHOW DATABASES;

-- Use the correct database
USE WaterQualityManagement;

-- Show all tables
SHOW TABLES;

-- Describe key tables
DESCRIBE Sample;
DESCRIBE Analysis;
DESCRIBE Parameter;
DESCRIBE WaterQualityStandard;


SELECT * FROM State;
SELECT * FROM Sample;
SELECT * FROM Analysis;
SELECT * FROM Parameter;

SHOW DATABASES;

USE WaterQualityManagement;
SHOW TABLES;

INSERT INTO Location (StateID, CountyName, Latitude, Longitude) VALUES
(@CaliforniaID, 'Yolo_1', 33.000000, -121.000000),
(@CaliforniaID, 'Contra Costa_1', 37.886800, -121.868200),
(@CaliforniaID, 'Contra Costa_2', 37.958300, -121.966900),
(@CaliforniaID, 'Contra Costa_3', 37.966300, -121.973400),
(@CaliforniaID, 'Contra Costa_4', 37.946000, -122.015500),
(@CaliforniaID, 'Humboldt_1', 40.476200, -124.125900),
(@CaliforniaID, 'Humboldt_2', 40.476200, -124.130700),
(@CaliforniaID, 'Contra Costa_5', 37.904900, -121.996300),
(@CaliforniaID, 'Contra Costa_6', 37.962700, -121.708100);



INSERT INTO State (StateName) VALUES
('California'),
('Texas'),
('Florida'),
('New York'),
('Illinois'),
('Ohio'),
('Georgia'),
('North Carolina'),
('Michigan'),
('Pennsylvania');



INSERT INTO Station (StationNumber, StationType, LocationID)  
VALUES  
('01N01E01A001M_1', 'Groundwater', NULL),  
('01N01E01A001M_2', 'Groundwater', NULL),  
('01N01E01A001M_3', 'Groundwater', NULL),  
('01N01E01A001M_4', 'Groundwater', NULL),  
('01N01E01A001M_5', 'Groundwater', NULL),  
('01N01E01A001M_6', 'Groundwater', NULL),  
('01N01E01A001M_7', 'Groundwater', NULL),  
('01N01E01A001M_8', 'Groundwater', NULL),  
('01N01E01A001M_9', 'Groundwater', NULL);


INSERT INTO sample (SampleID, StationID, SampleCode, SampleDate, SampleDepth, SampleDepthUnits, SampleStatusID) 
VALUES 
(1, 1, 'OM0168A0001', '1968-04-01', 1.00, 'Feet', 1),
(2, 1, 'WDIS_0719152', '2008-06-23', 2.00, 'Meters', 2),
(3, 2, 'OM0268A0006', '1968-01-02', 1.00, 'Feet', 1),
(4, 1, 'OM0168A0003', '1968-04-01', 1.00, 'Feet', 1),
(5, 2, 'OM0268A0007', '1968-01-02', 2.00, 'Feet', 2);

INSERT INTO SampleStatus (StatusName)  
VALUES  
('Active'),
('Inactive'),
('Pending'),
('Completed'),
('Rejected'),
('Expired');

INSERT INTO Sample_Parameter (SampleID, ParameterID)
VALUES 
(1, 101),
(2, 102),
(3, 103),
(4, 104),
(5, 105),
(6, 106);

INSERT INTO Analysis (SampleID, ParameterID, Result, Units)  
VALUES  
(1, 101, 3480, 'uS/cm'),
(2, 102, 7.7, 'mg/L'),
(3, 103, 68, 'mg/L'),
(4, 104, 758, 'mg/L'),
(5, 105, 59, 'mg/L'),
(6, 106, 510, 'mg/L'),
(7, 107, 270, 'mg/L as CaCO3'),
(8, 108, 412, 'mg/L as CaCO3'),
(9, 109, 8, 'pH Units');

INSERT INTO Analysis_Method (AnalysisID, MethodID)  
VALUES  
(1, 101),  
(2, 102),  
(3, 103),  
(4, 104),  
(5, 105),  
(6, 106);

INSERT INTO WaterQualityStandard (ParameterID, MaximumAllowedValue, StandardSource)
VALUES
(1, 0.50, 'EPA Water Quality Standards'),
(2, 0.10, 'WHO Drinking Water Guidelines'),
(3, 2.00, 'BIS IS 10500:2012'),
(4, 0.30, 'EU Water Framework Directive'),
(5, 0.05, 'US Safe Drinking Water Act'),
(6, 0.10, 'ISO 14000 Environmental Management');


INSERT INTO MethodTypes (MethodTypeID, TypeName) 
VALUES 
(1, 'Chemical'),
(2, 'Physical'),
(3, 'Thermal'),
(4, 'pH Measurement'),
(5, 'Repetitive Chemical');



INSERT INTO parameter (ParameterName, FdrResult, FdrReportingLimit)
VALUES
('Dissolved Aluminum', 3480, 1),
('Dissolved Antimony', 7.7, 0.1),
('Dissolved Arsenic', 68, 1),
('Dissolved Barium', 758, 0.1),
('Dissolved Beryllium', 59, 0.1),
('Dissolved Oxygen', 510, 1),
('Electrical Conductance', 270, 1),
('Water Temperature', 412, 1),
('pH', 8, 0.1);

INSERT INTO ParameterTypes (TypeName) VALUES
('Dissolved Oxygen'),
('Electrical Conductance'),
('Water Temperature'),
('pH');


INSERT INTO WaterQualityStandard (ParameterID, MaximumAllowedValue, StandardSource)
VALUES
(1, 0.50, 'EPA Water Quality Standards'),
(2, 0.10, 'WHO Drinking Water Guidelines'),
(3, 2.00, 'BIS IS 10500:2012'),
(4, 0.30, 'EU Water Framework Directive'),
(5, 0.05, 'US Safe Drinking Water Act'),
(6, 0.10, 'ISO 14000 Environmental Management');


INSERT INTO Method (MethodName, UnsName)
VALUES
    ('EPA 360.2 (Field)', 'mg/L'),
    ('EPA 170.1 (Field)', '°C'),
    ('EPA 150.1 (Field)', 'pH Units'),
    ('Std Method 2510-B (Field)', 'uS/cm'),
    ('°C EPA 170.1 (Field)', '°C'),
    ('pH Units EPA 150.1 (Field)', 'pH Units');


SELECT * FROM Location;
SELECT * FROM Station;
SELECT * FROM sample;
SELECT * FROM Parameter;
SELECT * FROM method;
SELECT * FROM ParameterTypes;
SELECT * FROM Analysis;


SHOW DATABASES;

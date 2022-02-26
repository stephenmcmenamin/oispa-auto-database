/*
This script creates tables for the "OispaAuto" case database, and inserts test data in all tables
*/
-- -----------------------------------------------------------------------

-- Drop table in case it exist in the database
DROP TABLE IF EXISTS Auto;
DROP TABLE IF EXISTS Varaus;
DROP TABLE IF EXISTS Asiakas;

-- Table structure for table Asiakas
CREATE TABLE Asiakas (
	AsiakasID INT PRIMARY KEY,
    Etunimi VARCHAR(30) NOT NULL,
    Sukunimi VARCHAR(30) NOT NULL,
    Email  VARCHAR(40) NOT NULL,
    Puhelinnumero VARCHAR(20) NOT NULL,
    Kotiosoite VARCHAR(40) NOT NULL,
    Postinumero CHAR(5) NOT NULL,
    
    CHECK (Email LIKE '%@%.%')
);

-- Inserting new test records for table
INSERT INTO Asiakas VALUES
(1, 'Matti', 'Meikalainen', 'mat.mei@gmail.com', '0405040232', 'Matinkatu 1', '33000'),
(2, 'Maija', 'Meikalainen', 'mai.mei@gmail.com', '0405040234', 'Maijankatu 1', '33100'),
(3, 'Paavo', 'Koskinen', 'pvkoskinen@outlook.com', '0501040232', 'Paavonkuja 7', '35100'),
(4, 'Marjatta', 'Joki', 'marjatta.joki@yritys.fi', '0400040238', 'Rahakatu 30', '36300'),
(5, 'Kyllikki', 'Gimenez', 'kylligimme@gmail.com', '0409045234', 'Kyllikinkuja 789', '31100'),
(6, 'Esko', 'Lappi', 'e.lappi@gmail.com', '0500987232', 'Ojatie 5 B 2', '00300'),
(7, 'Pentti', 'Kuru', 'pentti.kuru@gmail.com', '0405039270', 'Keskuskatu 4 A 25', '00310');

-- Table structure for table Varaus
CREATE TABLE Varaus (
	VarausID INT PRIMARY KEY,
    AsiakasID INT NOT NULL,
    VarausAlku DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    VarausLoppu DATETIME,
    KuljettuMatka FLOAT NOT NULL DEFAULT 0.0,
    
    FOREIGN KEY (AsiakasID) REFERENCES Asiakas(AsiakasID),
    
    CHECK (KuljettuMatka >= 0.0)
);

-- Inserting new test records for table
INSERT INTO Varaus VALUES
(1, 3, '2022-02-17 15:31:20', NULL, 301),
(2, 2, DEFAULT, NULL, DEFAULT),
(3, 5, '2022-02-18 18:45:10', '2022-02-18 19:30:21', 5.1),
(4, 1, DEFAULT, NULL, DEFAULT),
(5, 4, '2022-02-27 20:10:15', NULL, DEFAULT);


-- Table structure for table Auto
CREATE TABLE Auto (
	AutoID INT PRIMARY KEY,
    VarausID INT,
    VarausTila VARCHAR(7) NOT NULL DEFAULT 'Vapaa',
    Rekisterinumero CHAR(7) NOT NULL,
    Leveysaste FLOAT NOT NULL,
    Pituusaste FLOAT NOT NULL,
    Akku INT NOT NULL,
    
    FOREIGN KEY (VarausID) REFERENCES Varaus(VarausID),
    
    CHECK (Varaustila IN ('Vapaa', 'Varattu')),
    CHECK (Rekisterinumero LIKE '___-___'),
    CHECK (Akku >= 0)
);

-- Inserting new test records for table
INSERT INTO Auto VALUES
(1, 3, 'Vapaa', 'TLH-587', 61.504303, 23.741795, 388),
(2, 5, 'Varattu', 'GLT-624', 61.473332, 23.791822, 280),
(3, 1, 'Varattu', 'BFM-741', 61.304203, 23.641795, 40),
(4, 2, DEFAULT, 'PER-195', 61.804303, 23.141795, 150),
(5, 4, DEFAULT, 'JKL-325', 62.904303, 24.141795, 98),
(6, NULL, DEFAULT, 'WTR-855', 63.904303, 25.141795, 412),
(7, NULL, DEFAULT, 'YHJ-852', 60.904303, 22.141795, 415);

-- -----------------------------------------------------------------------
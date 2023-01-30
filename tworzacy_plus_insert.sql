

IF OBJECT_ID (N'Bialka') IS NOT NULL
DROP TABLE Bialka
IF OBJECT_ID (N'Batony') IS NOT NULL
DROP TABLE Batony
IF OBJECT_ID (N'Napoje') IS NOT NULL
DROP TABLE Napoje
IF OBJECT_ID (N'Produkt') IS NOT NULL
DROP TABLE Produkt


IF OBJECT_ID (N'Trener') IS NOT NULL
DROP TABLE Trener
IF OBJECT_ID (N'Sprzataczka') IS NOT NULL
DROP TABLE Sprzataczka
IF OBJECT_ID (N'Ochrona') IS NOT NULL
DROP TABLE Ochrona
IF OBJECT_ID (N'Pracownik') IS NOT NULL
DROP TABLE Pracownik


IF OBJECT_ID (N'Gumy') IS NOT NULL
DROP TABLE Gumy
IF OBJECT_ID (N'Pasy') IS NOT NULL
DROP TABLE Pasy
IF OBJECT_ID (N'Pilki') IS NOT NULL
DROP TABLE Pilki
IF OBJECT_ID (N'Maty') IS NOT NULL
DROP TABLE Maty
IF OBJECT_ID (N'Kamizelki') IS NOT NULL
DROP TABLE Kamizelki
IF OBJECT_ID (N'Obciazenia') IS NOT NULL
DROP TABLE Obciazenia
IF OBJECT_ID (N'Maszyny') IS NOT NULL
DROP TABLE Maszyny
IF OBJECT_ID (N'Drazki') IS NOT NULL
DROP TABLE Drazki
IF OBJECT_ID (N'Hantle') IS NOT NULL
DROP TABLE Hantle
IF OBJECT_ID (N'Sprzet') IS NOT NULL
DROP TABLE Sprzet


IF OBJECT_ID (N'Szafki') IS NOT NULL
DROP TABLE Szafki


IF OBJECT_ID (N'Przelew') IS NOT NULL
DROP TABLE Przelew


IF OBJECT_ID (N'Klienci') IS NOT NULL
DROP TABLE Klienci


IF OBJECT_ID (N'Bilety_Wejsciowe') IS NOT NULL
DROP TABLE Bilety_Wejsciowe;
IF OBJECT_ID (N'Bilety_Czasowe') IS NOT NULL
DROP TABLE Bilety_Czasowe;
IF OBJECT_ID (N'Oferta') IS NOT NULL
DROP TABLE Oferta;


IF OBJECT_ID (N'Placowka') IS NOT NULL
DROP TABLE Placowka;

IF OBJECT_ID (N'Dolar') IS NOT NULL
DROP TABLE Dolar;


CREATE TABLE Dolar (
	ID_Dolara int IDENTITY(1, 1) PRIMARY KEY,
	Kurs int not Null,
)

CREATE TABLE Oferta (
	ID_oferty int IDENTITY(1, 1) PRIMARY KEY,
	Nazwa nvarchar(50) NOT NULL,
	Cena_Dynamiczna Float NOT NULL
);

CREATE TABLE Bilety_Wejsciowe (
	ID_oferty int not null	
	constraint PK_wejsciowe primary Key (ID_oferty)
	constraint SK_wejsciowe foreign Key (ID_oferty) references Oferta(ID_oferty) ON DELETE CASCADE,
	Ilosc_Wejsc int not null,
);

CREATE TABLE Bilety_Czasowe (
	ID_oferty int not null	
	constraint PK_czasowe primary Key (ID_oferty)
	constraint SK_czasowe foreign Key (ID_oferty) references Oferta(ID_oferty) ON DELETE CASCADE,
	Czas_trwania int NOT NULL, 
);

/* ------------------------------------------------------------------------------------------------------------------------------------------ */

CREATE TABLE Klienci (
   ID_klienta int IDENTITY(1, 1) PRIMARY KEY,
   Imie nvarchar(50) NOT NULL,
   Nazwisko nvarchar(50) NOT NULL,
   Id_biletu int constraint SK_klienci foreign Key (Id_biletu) references Oferta(ID_oferty) ON DELETE SET NULL
);

/* ------------------------------------------------------------------------------------------------------------------------------------------ */


CREATE TABLE Placowka (
	ID_Placowki int IDENTITY(1,1) PRIMARY KEY,
	City NVarChar(255),
	Street NVarChar(255),
	YearOfOpening int
);

/* ------------------------------------------------------------------------------------------------------------------------------------------ */

CREATE TABLE Przelew (
	ID_Przelewu int PRIMARY KEY,
	ID_Klienta int constraint SK_Przelew foreign Key (ID_Klienta) references Klienci(ID_klienta),
	Kwota INT,
	DataPrzelewu int,
);

/* ------------------------------------------------------------------------------------------------------------------------------------------ */

CREATE TABLE Szafki (
	ID_Szafki int PRIMARY KEY,
	ID_Placowki int constraint SK_Szafki foreign Key (ID_Placowki) references Placowka(ID_Placowki) ON DELETE CASCADE,
	Zajeta BIT DEFAULT 0
);

/* ------------------------------------------------------------------------------------------------------------------------------------------ */



CREATE TABLE Sprzet (
   ID_Sprzetu int IDENTITY(1, 1) PRIMARY KEY,
   ID_Placowki int foreign Key (ID_Placowki) references Placowka(ID_Placowki) ON DELETE CASCADE,
   Nazwa nvarchar(50) NOT NULL,
   Ilosc int NOT NULL
);

CREATE TABLE Obciazenia (
	ID_Sprzetu int not null	
	constraint PK_Obciazenia primary Key (ID_Sprzetu)
	constraint SK_Obciazenia foreign Key (ID_Sprzetu) references Sprzet(ID_Sprzetu) ON DELETE CASCADE,
	Masa int NOT NULL,
	Srednia_Otworu int NOT NULL
);


CREATE TABLE Hantle (
	ID_Sprzetu int not null	
	constraint PK_Hantle primary Key (ID_Sprzetu)
	constraint SK_Hantle foreign Key (ID_Sprzetu) references Sprzet(ID_Sprzetu) ON DELETE CASCADE,
	Masa int NOT NULL,
	Typ VARCHAR(15) NOT NULL,
	CHECK (Typ IN ('winylowe','gumowe','żeliwne'))
);



CREATE TABLE Drazki (
	ID_Sprzetu int not null	
	constraint PK_Drazki primary Key (ID_Sprzetu)
	constraint SK_Drazki foreign Key (ID_Sprzetu) references Sprzet(ID_Sprzetu) ON DELETE CASCADE,
	Szerokosc int NOT NULL,
	Srednica int NOT NULL,
);

CREATE TABLE Maszyny (
	ID_Sprzetu int not null	
	constraint PK_Maszyny primary Key (ID_Sprzetu)
	constraint SK_Maszyny foreign Key (ID_Sprzetu) references Sprzet(ID_Sprzetu) ON DELETE CASCADE,
	Max_waga int not null,
	Zwiekszenie int not null, -- co ile mozna zwiekszyc ciezar --
);

CREATE TABLE Gumy (
   	ID_Sprzetu int not null	
	constraint PK_Gumy primary Key (ID_Sprzetu)
	constraint SK_Gumy foreign Key (ID_Sprzetu) references Sprzet(ID_Sprzetu) ON DELETE CASCADE,
	Min_oporowsc int not null,
	Max_oporowsc int not null
);

CREATE TABLE Pasy (
   	ID_Sprzetu int not null	
	constraint PK_Pasy primary Key (ID_Sprzetu)
	constraint SK_Pasy foreign Key (ID_Sprzetu) references Sprzet(ID_Sprzetu) ON DELETE CASCADE,
	Size NVarChar(255) not null,
);

CREATE TABLE Pilki(
	ID_Sprzetu int not null	
	constraint PK_Pilki primary Key (ID_Sprzetu)
	constraint SK_Pilki foreign Key (ID_Sprzetu) references Sprzet(ID_Sprzetu) ON DELETE CASCADE,
	Size NVarChar(255) not null,
	Colour NVarChar(255) not null,
	Typ NVarChar(255) not null,
	CHECK (Typ IN ('winylowa','gumowa'))
)

CREATE TABLE Maty (
	ID_Sprzetu int not null	
	constraint PK_Maty primary Key (ID_Sprzetu)
	constraint SK_Maty foreign Key (ID_Sprzetu) references Sprzet(ID_Sprzetu) ON DELETE CASCADE,
	Dlugosc int not null,
	Szerokosc int not null
);

CREATE TABLE Kamizelki (
	ID_Sprzetu int not null	
	constraint PK_Kamizelki primary Key (ID_Sprzetu)
	constraint SK_Kamizelki foreign Key (ID_Sprzetu) references Sprzet(ID_Sprzetu) ON DELETE CASCADE,
	Ilosc_kieszonek int not null,
	Max_obciazenie int not null,
	Size NVarChar(255) not null
);

/* ------------------------------------------------------------------------------------------------------------------------------------------ */

Create Table Pracownik(
	ID_Pracownika int PRIMARY KEY,
	ID_Placowki int foreign Key (ID_Placowki) references Placowka(ID_Placowki) ON DELETE CASCADE,
	FirstName NVarChar(255) not null,
	LastName NVarChar(255) not null,
	DateOfBirth int not null,
	Zawod NVarChar(255) not null,
	CHECK (Zawod IN ('Trener','Sprzataczka','Ochrona'))
)

Create Table Trener(
	ID_Pracownika int not null	
	constraint PK_Trener primary Key (ID_Pracownika)
	constraint SK_Trener foreign Key (ID_Pracownika) references Pracownik(ID_Pracownika) ON DELETE CASCADE,
	Specjalizacja  VARCHAR(10) NOT NULL,
	CHECK (Specjalizacja IN ('Aesthetics','Legs','Hands', 'Chest', 'Cardio', 'StrongMan')),
	CenaZaGodzine Int,
)

Create Table Sprzataczka(
	ID_Pracownika int not null	
	constraint PK_Sprzataczka primary Key (ID_Pracownika)
	constraint SK_Sprzataczka foreign Key (ID_Pracownika) references Pracownik(ID_Pracownika) ON DELETE CASCADE,
	Liczba_Godzin Int not null,
	Wyplata_Godzinowa Int not null,
)

Create Table Ochrona(
	ID_Pracownika int not null	
	constraint PK_Ochrona primary Key (ID_Pracownika)
	constraint SK_Ochrona foreign Key (ID_Pracownika) references Pracownik(ID_Pracownika) ON DELETE CASCADE,
	Liczba_Godzin Int not null,
	Wyplata_Godzinowa Int not null,
	Srodki_Przymusu_Bezposredniego BIT not null, --Czy moze stosowac przemoc
	Rozmiar_Bicepsu	Int not null
)
/* ------------------------------------------------------------------------------------------------------------------------------------------ */

Create Table Produkt(
    Id_Produktu int IDENTITY(1, 1) PRIMARY KEY,
	ID_Placowki int foreign Key (ID_Placowki) references Placowka(ID_Placowki) ON DELETE CASCADE,
	Nazwa nvarchar(50) NOT NULL,
	Ilosc int NOT NULL,
    Cena_Dynamiczna Float NOT NULL,
);

Create Table Napoje(
	ID_Produktu int not null	
	constraint PK_Napoje primary Key (ID_Produktu)
	constraint SK_Napoje foreign Key (ID_Produktu) references Produkt(ID_Produktu) ON DELETE CASCADE,
    Pojemnosc INT not NULL,
	Opakowanie NVARChar(255) NOT NULL
	CHECK (Opakowanie IN ('karton','plastik'))
)
Create Table Batony(
	ID_Produktu int not null	
	constraint PK_Batony primary Key (ID_Produktu)
	constraint SK_Batony foreign Key (ID_Produktu) references Produkt(ID_Produktu) ON DELETE CASCADE,
    Waga Int not NULL,
    Smak NVarChar(255),
    Kalorie Int not NULL,
)

Create Table Bialka(
	ID_Produktu int not null	
	constraint PK_Bialka primary Key (ID_Produktu)
	constraint SK_Bialka foreign Key (ID_Produktu) references Produkt(ID_Produktu) ON DELETE CASCADE,
    Waga Int not null,
    Smak NVarChar(255) not null,
    Przelicznik Int not null, -- ile bialka rzeczywiscie w 100 gram
)

INSERT INTO Placowka VALUES
  ('Springfield', 'Huntz Lane', 1991),
  ('Clarkrange', 'Angus Road', 2010),
  ('Markle', 'Drainer Avenue', 2021),
  ('Springfield', 'Central Avenue', 1994),
  ('Seattle', 'Franklin Street', 1999),
  ('Lexington', 'Maple Street', 2018),
  ('Redmond', 'Johnstown Road', 1997),
  ('Markle', 'Maple Street', 2004),
  ('Markle', 'Steve Hunt Road', 2007),
  ('Bonham', 'Hamilton Drive', 2012),
  ('Dallas', 'Hartway Street', 1992),
  ('Providence', 'Lynn Avenue', 1991),
  ('Kingsport', 'Huntz Lane', 2020);
INSERT INTO Pracownik VALUES
(1,9,'Kurtis', 'Odonnell', 1979,'Trener'),
(2,6,'Annabelle', 'Wyatt', 1988,'Trener'),
(3,2,'Aadam', 'Campbell', 1978,'Trener'),
(4,6,'Brett', 'Ochoa', 1977,'Trener'),
(5,10,'Maryam', 'Dawson', 1968,'Trener'),
(6,3,'Wayne', 'Bartlett', 1961,'Trener'),
(7,3,'Abdullahi', 'Singleton', 1979,'Trener'),
(8,9,'Maisha', 'John', 1975,'Trener'),
(9,4,'Umair', 'Lopez', 1971,'Trener'),
(10,10,'Libbie', 'Larsen', 1979,'Trener'),
(11,10,'Tori', 'Jennings', 1972,'Trener'),
(12,6,'Dylan', 'Glenn', 1965,'Trener'),
(13,8,'Keanu', 'Horn', 1965,'Trener'),
(14,2,'Hermione', 'Reyes', 1962,'Trener'),
(15,11,'Rehan', 'Rosario', 1998,'Trener'),
(16,1,'Kamal', 'Bauer', 1990,'Trener'),
(17,5,'Krishan', 'Espinoza', 1973,'Trener'),
(18,11,'Hari', 'Hale', 1969,'Trener'),
(19,1,'Alys', 'Maxwell', 1978,'Trener'),
(20,2,'Willie', 'Bridges', 1996,'Trener'),
(21,7,'Ridwan', 'Riggs', 1996,'Trener'),
(22,10,'Taya', 'Chang', 1997,'Trener'),
(23,10,'Jonathan', 'Mack', 1995,'Trener'),
(24,2,'Fahad', 'Wise', 1977,'Trener'),
(25,7,'Faiza', 'Carey', 1983,'Trener'),
(26,8,'Summer', 'Callahan', 1978,'Trener'),
(27,8,'Haris', 'Friedman', 1961,'Trener'),
(28,8,'Rohan', 'Gould', 1985,'Trener'),
(29,6,'Trystan', 'Watson', 1992,'Trener'),
(30,3,'Isra', 'Harrington', 1982,'Trener'),
(31,6,'Lawson', 'Bass', 1999,'Sprzataczka'),
(32,3,'Chester', 'Melton', 1997,'Sprzataczka'),
(33,8,'Albert', 'Rivas', 1998,'Sprzataczka'),
(34,1,'Fiona', 'Small', 1971,'Sprzataczka'),
(35,3,'Harold', 'Solis', 1989,'Sprzataczka'),
(36,8,'Rosalind', 'Zimmerman', 1962,'Sprzataczka'),
(37,9,'Dawn', 'Mckenzie', 1992,'Sprzataczka'),
(38,8,'Krystal', 'Galvan', 1970,'Sprzataczka'),
(39,3,'Milo', 'Donaldson', 1991,'Sprzataczka'),
(40,1,'Charlotte', 'Carrillo', 1969,'Sprzataczka'),
(41,4,'Mitchell', 'Robertson', 1981,'Sprzataczka'),
(42,5,'Gemma', 'Li', 1987,'Sprzataczka'),
(43,7,'Fannie', 'Fuller', 1964,'Sprzataczka'),
(44,10,'Justin', 'Whitaker', 1989,'Sprzataczka'),
(45,7,'Zach', 'Hayden', 1967,'Sprzataczka'),
(46,1,'Macie', 'Jefferson', 1974,'Sprzataczka'),
(47,5,'Wesley', 'Wells', 1977,'Sprzataczka'),
(48,6,'Katie', 'Bloggs', 1975,'Sprzataczka'),
(49,3,'Dexter', 'Chandler', 1972,'Sprzataczka'),
(50,9,'Eugene', 'Bruce', 1973,'Ochrona'),
(51,4,'Seren', 'Hughes', 1971,'Ochrona'),
(52,9,'Umar', 'Benton', 1965,'Ochrona'),
(53,6,'Harris', 'Medina', 1964,'Ochrona'),
(54,6,'Rodney', 'Skinner', 1967,'Ochrona'),
(55,10,'Cecily', 'Cherry', 1960,'Ochrona'),
(56,1,'Mariya', 'Hunt', 1998,'Ochrona'),
(57,10,'Faye', 'Hawkins', 1990,'Ochrona'),
(58,9,'Aishah', 'Blake', 1991,'Ochrona'),
(59,3,'Lester', 'Floyd', 1999,'Ochrona'),
(60,4,'Marina', 'Christian', 1991,'Ochrona'),
(61,9,'Myles', 'Cain', 1987,'Ochrona'),
(62,11,'Ellie-May', 'Waller', 1962,'Ochrona'),
(63,9,'Eliot', 'Osborne', 1979,'Ochrona'),
(64,1,'Ophelia', 'Hartman', 1986,'Ochrona'),
(65,10,'Simon', 'Allison', 1968,'Ochrona'),
(66,2,'Carla', 'Holden', 1973,'Ochrona'),
(67,4,'Cindy', 'Aguilar', 1989,'Ochrona'),
(68,10,'Otis', 'Hickman', 1970,'Ochrona'),
(69,10,'Sandra', 'Reeves', 1984,'Ochrona'),
(70,11,'Katerina', 'Wheeler', 1989,'Ochrona'),
(71,1,'Theresa', 'Padilla', 1975,'Ochrona'),
(72,10,'Tyrese', 'Meyers', 1969,'Ochrona'),
(73,11,'Lacey', 'Donovan', 1984,'Ochrona'),
(74,5,'Beau', 'Fuentes', 1989,'Ochrona'),
(75,7,'Saba', 'Jarvis', 1969,'Ochrona'),
(76,7,'Muhammad', 'Webster', 1962,'Ochrona'),
(77,2,'Elinor', 'Joseph', 1978,'Ochrona'),
(78,3,'Zackary', 'Mclean', 1988,'Ochrona'),
(79,8,'Beatrice', 'Pitts', 1983,'Ochrona'),
(80,11,'Ioan', 'Tanner', 1975,'Ochrona'),
(81,8,'Amaan', 'Flores', 1995,'Ochrona'),
(82,2,'Bianca', 'Olsen', 1996,'Ochrona'),
(83,1,'Heidi', 'Walker', 1977,'Ochrona'),
(84,4,'Montgomery', 'Moses', 1995,'Ochrona'),
(85,4,'Brayden', 'Beard', 1996,'Ochrona');


INSERT INTO Trener VALUES
(1,'Aesthetics',27),
(2,'Aesthetics',48),
(3,'Aesthetics',32),
(4,'Aesthetics',61),
(5,'Aesthetics',22),
(6,'Legs',25),      
(7,'Legs',45),      
(8,'Legs',43),      
(9,'Legs',48),      
(10,'Legs',19),     
(11,'Hands',61),        
(12,'Hands',42),        
(13,'Hands',66),
(14,'Hands',44),
(15,'Hands',58),
(16,'Chest',26),
(17,'Chest',65),
(18,'Chest',21),
(19,'Chest',34),
(20,'Chest',33),
(21,'Cardio',46),
(22,'Cardio',56),
(23,'Cardio',46),
(24,'Cardio',27),
(25,'Cardio',50),
(26,'StrongMan',66),
(27,'StrongMan',54),
(28,'StrongMan',65),
(29,'StrongMan',35),
(30,'StrongMan',46);


INSERT INTO Sprzataczka VALUES
(31,34,15),
(32,25,24),
(33,29,25),
(34,30,23),
(35,29,18),
(36,23,22),
(37,21,36),
(38,25,31),
(39,33,30),
(40,15,36),
(41,34,13),
(42,34,27),
(43,24,17),
(44,34,14),
(45,28,33),
(46,20,23),
(47,25,25),
(48,17,22),
(49,29,35);

INSERT INTO Ochrona VALUES
(50,28,23,1, 46),
(51,25,34,1, 47),
(52,23,12,1, 39),
(53,20,22,1, 28),
(54,15,37,1, 28),
(55,32,36,1, 32),
(56,18,37,1, 23),
(57,27,11,1, 45),
(58,17,28,1, 35),
(59,19,37,1, 49),
(60,21,38,1, 40),
(61,17,33,0, 35),
(62,30,35,0, 48),
(63,26,13,1, 29),
(64,34,29,1, 41),
(65,21,15,1, 22),
(66,27,31,0, 32),
(67,15,12,0, 36),
(68,26,34,1, 28),
(69,17,30,0, 47),
(70,29,17,1, 36),
(71,26,30,0, 29),
(72,30,30,0, 35),
(73,26,25,0, 20),
(74,26,27,1, 34),
(75,24,29,1, 31),
(76,27,20,0, 43),
(77,34,32,0, 47),
(78,29,26,0, 29),
(79,20,35,0, 29),
(80,25,36,1, 26),
(81,32,39,1, 44),
(82,33,39,1, 30),
(83,32,34,1, 44),
(84,26,12,0, 46),
(85,26,11,1, 49);

INSERT INTO Oferta VALUES
('studentSauna1', 20),
('studentSilownia1', 30),
('studentBasen1', 35),
('studentSauna5', 75),
('studentSilownia5', 95),
('studentBasen5', 105),
('studentSauna10', 115),
('studentSilownia10', 120),
('studentBasen10', 125),
('studentSauna30', 80),
('studentSilownia30', 95),
('studentBasen30', 105),
('studentSauna90', 250),
('studentSilownia90', 275),
('studentBasen90', 290),
('studentSauna365', 750),
('studentSilownia365', 810),
('studentBasen365', 860),

('emerytSauna1', 25),
('emerytSilownia1', 35),
('emerytBasen1', 40),
('emerytSauna5', 80),
('emerytSilownia5', 100),
('emerytBasen5', 110),
('emerytSauna10', 120),
('emerytSilownia10', 125),
('emerytBasen10', 130),
('emerytSauna30', 100),
('emerytSilownia30', 115),
('emerytBasen30', 125),
('emerytSauna90', 270),
('emerytSilownia90', 295),
('emerytBasen90', 310),
('emerytSauna365', 770),
('emerytSilownia365', 830),
('emerytBasen365', 880),

('normalnySauna1', 30),
('normalnySilownia1', 40),
('normalnyBasen1', 45),
('normalnySauna5', 85),
('normalnySilownia5', 105),
('normalnyBasen5', 115),
('normalnySauna10', 125),
('normalnySilownia10', 130),
('normalnyBasen10', 135),
('normalnySauna30', 110),
('normalnySilownia30', 125),
('normalnyBasen30', 135),
('normalnySauna90', 290),
('normalnySilownia90', 325),
('normalnyBasen90', 370),
('normalnySauna365', 920),
('normalnySilownia365', 970),
('normalnyBasen365', 990);


InSERT INTO Bilety_Wejsciowe VALUES
(1,1),
(2,1),
(3,1),
(4,5),
(5,5),
(6,5),
(7,10),
(8,10),
(9,10),
(19,1),
(20,1),
(21,1),
(22,5),
(23,5),
(24,5),
(25,10),
(26,10),
(27,10),
(37,1),
(38,1),
(39,1),
(40,5),
(41,5),
(42,5),
(43,10),
(44,10),
(45,10);

INSERT INTO Bilety_Czasowe VALUES
(10,30),
(11,30),
(12,30),
(13,90),
(14,90),
(15,90),
(16,365),
(17,365),
(18,365),

(28,30),
(29,30),
(30,30),
(31,90),
(32,90),
(33,90),
(34,365),
(35,365),
(36,365),

(46,30),
(47,30),
(48,30),
(49,90),
(50,90),
(51,90),
(52,365),
(53,365),
(54,365);


INSERT INTO Klienci VALUES
('Thomas', 'Jones', 8),    
('Tamara', 'Caldwell', 9),  
('Calvin', 'Peterson', 48), 
('Andrew', 'Hall', 51),     
('Allison', 'Roberts', 17), 
('Marc', 'Romero', 35),     
('Jennifer', 'Alvarez', 16),
('Stacey', 'Fernandez', 44),
('Jessica', 'Zavala', 25),  
('Heather', 'Mcdonald', 6), 
('David', 'Gould', 19),     
('Laura', 'Hall', 20),      
('Daniel', 'Silva', 11),    
('Jason', 'Sampson', 26),   
('Melissa', 'Jones', 17),   
('Paul', 'Diaz', 17),       
('Michael', 'Greer', 8),
('Jesse', 'Li', 27),
('James', 'Wong', 51),
('Rebecca', 'Kelley', 20),
('Pamela', 'Lam', 14),
('Michael', 'Keller', 23),
('Wayne', 'Cohen', 45),
('Kelly', 'David', 40),
('Michael', 'George', 1),
('Catherine', 'Small', 43),
('Matthew', 'Rivera', 10),
('Peter', 'Clark', 9),
('Julie', 'Wright', 37),
('Nathan', 'Weeks', 51),
('Michael', 'Anderson', 42),
('Amy', 'Carter', 23),
('Craig', 'Harris', 2),
('Linda', 'Spears', 48),
('Felicia', 'Santiago', 2),
('Michael', 'Bonilla', 51),
('Anthony', 'Coleman', 51),
('Jamie', 'Mcgrath', 17),
('Melissa', 'Henderson', 49),
('Darren', 'Cordova', 1),
('Jasmine', 'Underwood', 52),
('John', 'Foster', 54),
('Billy', 'Anderson', 44),
('Erin', 'Davis', 19),
('Derrick', 'Woods', 10),
('Danny', 'Peterson', 47),
('Caroline', 'Martin', 3),
('Angela', 'Graves', 22),
('Diane', 'Decker', 7),
('Cynthia', 'Mccarty', 9),
('Crystal', 'Cruz', 32),
('Steven', 'Anderson', 52),
('Jon', 'Williams', 23),
('DDS', 'Christina', 24),
('Preston', 'Paula', 23),
('Vega', 'Angela', 13),
('Smith', 'Sabrina', 22),
('Harding', 'Miguel', 9),
('Harper', 'Savannah', 9),
('Rose', 'Katherine', 15),
('Shaw', 'Richard', 9),
('Myers', 'Debra', 16),
('Sanders', 'Thomas', 18),
('Brady', 'DVM', 7),
('Lori', 'Williams', 18),
('Chelsea', 'Parsons', 24),
('Curtis', 'Roberts', 54),
('Brent', 'Atkins', 22),
('Colleen', 'Nguyen', 7),
('Angela', 'Dean', 6),
('Ryan', 'Hernandez', 9),
('Angelica', 'Mason', 23),
('Melinda', 'Rollins', 4),
('Roy', 'Arellano', 37),
('Marissa', 'Ortiz', 45),
('Nicole', 'Knight', 31),
('Christopher', 'Skinner', 40),
('Daniel', 'Hammond', 31),
('Megan', 'Burns', 1),
('Anthony', 'Miller', 12),
('Alan', 'Olsen', 41),
('Eric', 'Greene', 16),
('Michelle', 'Mann', 51),
('Mandy', 'Nolan', 19),
('David', 'Pena', 48),
('David', 'Mora', 47),
('Donna', 'Strickland', 15),
('Richard', 'Ramos', 4),
('Michael', 'Gates', 6),
('Adrian', 'Anderson', 2),
('William', 'Mullen', 24),
('Laura', 'Pace', 21),
('Lucas', 'Ortiz', 51),
('Angel', 'Hall', 12),
('Richard', 'Velazquez', 21),
('Melissa', 'Porter', 2),
('Steven', 'Nguyen', 22),
('Betty', 'Mejia', 36),
('Kathryn', 'Mills', 17),
('Kimberly', 'Myers', 31),
('Angelica', 'Yang', 54),
('Zachary', 'Marquez', 54),
('Harry', 'Khan', 1),
('Joseph', 'Dickson', 38),
('Dustin', 'Curtis', 40),
('Shannon', 'Cruz', 46),
('Oscar', 'Barnes', 19),
('Christine', 'Fisher', 26),
('Melissa', 'Malone', 4),
('Rose', 'Foster', 54),
('Jimmy', 'Duncan', 12),
('Jennifer', 'Sanchez', 13),
('Steven', 'George', 20),
('Tony', 'Cox', 45),
('Jennifer', 'Flores', 13),
('Karen', 'Daugherty', 26),
('Dr.', 'Seth', 3),
('Lowery', 'Brooke', 16),
('Villarreal', 'Brian', 14),
('Martin', 'Darren', 29),
('Harper', 'Kathleen', 17),
('Hernandez', 'Jason', 19),
('Villegas', 'Donald', 14),
('Lee', 'Jesus', 39),
('Hampton', 'Larry', 54),
('Edwards', 'Scott', 41),
('Reynolds', 'Angela', 26),
('Baxter', 'Ian', 29),
('Cox', 'Peter', 36),
('Monroe', 'Kelli', 53),
('Stanley', 'Justin', 18),
('Brown', 'Bryan', 17),
('Mcconnell', 'Matthew', 16),
('Mason', 'Amanda', 53),
('Maddox', 'William', 54),
('Dyer', 'Anthony', 24),
('Hobbs', 'DDS', 20),
('Aaron', 'Perez', 38),
('Timothy', 'Wright', 27),
('Julia', 'Johnson', 11),
('Connie', 'Potter', 17),
('Karen', 'Jackson', 23),
('Jasmine', 'Davis', 32),
('Amanda', 'Espinoza', 20),
('Jack', 'Parker', 50),
('Rebecca', 'Erickson', 29),
('Kristina', 'Kennedy', 38),
('Mr.', 'Mark', 34),
('Nunez', 'Lauren', 34),
('Jenkins', 'Daniel', 7),
('Clark', 'Amy', 39),
('Waters', 'Julie', 24),
('Walker', 'Brandy', 25),
('Tapia', 'Garrett', 28),
('Smith', 'Amy', 2),
('Sanchez', 'Brandon', 31),
('Benton', 'John', 6),
('Torres', 'Ashley', 30),
('Washington', 'Alexander', 10),
('Grant', 'Dawn', 50),
('Mendez', 'Virginia', 4),
('Mcgrath', 'Jacqueline', 38),
('Roth', 'Timothy', 28),
('Hall', 'Collin', 4),
('Martin', 'Zachary', 2),
('Ramos', 'Chad', 15),
('Blake', 'Kathryn', 20),
('Adams', 'Juan', 25),
('Mckenzie', 'Dr.', 24),
('Eileen', 'Wallace', 52),
('Patricia', 'Bell', 9),
('Rachael', 'James', 21),
('Cynthia', 'Molina', 51),
('Mr.', 'Steven', 26),
('Nelson', 'Jasmine', 46),
('Clark', 'Eric', 6),
('Savage', 'Christopher', 15),
('Parker', 'William', 1),
('Li', 'Robert', 49),
('Ramirez', 'Michael', 41),
('Simmons', 'Brett', 44),
('Gordon', 'Heather', 41),
('Carroll', 'Ryan', 16),
('Schneider', 'Vickie', 52),
('Johnson', 'Joseph', 14),
('Horn', 'DVM', 25),
('Mary', 'Kirk', 17),
('Andrea', 'Parker', 17),
('Stephanie', 'Everett', 53),
('Mackenzie', 'Barajas', 36),
('Emily', 'Lowery', 8),
('Kevin', 'Torres', 2),
('Melissa', 'Garcia', 50),
('Katherine', 'Roberson', 16),
('Eric', 'Jenkins', 8),
('Ronald', 'Delgado', 53),
('Jo', 'Harris', 8),
('Ryan', 'Wheeler', 16),
('Crystal', 'Baldwin', 30),
('Brittney', 'Garcia', 53),
('Jonathon', 'Porter', 49),
('Erica', 'Martinez', 37),
('Samuel', 'Huffman', 20),
('PhD', 'Renee', 54),
('Cook', 'William', 24),
('Lopez', 'Patricia', 37),
('Collins', 'Mary', 36),
('Roberts', 'Charles', 41),
('Jackson', 'Steven', 30),
('Simpson', 'Robert', 22),
('Wright', 'Christine', 54),
('Vance', 'Rachel', 31),
('King', 'Melvin', 53),
('Cox', 'Patricia', 14),
('Cordova', 'Katie', 21),
('Huynh', 'Candice', 16),
('Carpenter', 'Samuel', 26),
('Maynard', 'Amber', 1),
('Sutton', 'Lori', 34),
('Gould', 'Kathleen', 37),
('Bennett', 'Justin', 40),
('Petersen', 'Victoria', 1),
('Oneal', 'Rachel', 47),
('Turner', 'Taylor', 40),
('Hansen', 'Jillian', 19),
('Norris', 'William', 24),
('Short', 'John', 14),
('Miller', 'Bob', 37),
('Bates', 'Michele', 53),
('Woodard', 'Tara', 48),
('Murphy', 'Dr.', 21),
('John', 'Pratt', 28),
('David', 'Coleman', 28),
('Christina', 'Dawson', 42),
('Lisa', 'Edwards', 50),
('Janet', 'Potter', 7),
('Daniel', 'Ruiz', 45),
('David', 'Perez', 25),
('Raymond', 'Cline', 5),
('Matthew', 'Stewart', 4),
('Bobby', 'Diaz', 25),
('Brian', 'Young', 19),
('Johnathan', 'Cook', 14),
('Rebecca', 'Payne', 15),
('Anthony', 'Clark', 13),
('Ethan', 'Williams', 44),
('Earl', 'Robertson', 43),
('Debbie', 'Hoffman', 45),
('Martin', 'Hart', 10),
('Jr.', 'Sonya', 51),
('Lewis', 'Fred', 14),
('Elliott', 'Keith', 50),
('Brown', 'Mark', 30),
('James', 'Jerome', 25),
('Fowler', 'Kristen', 40),
('Owen', 'Skywalker', 28);
INSERT INTO Szafki VALUES 
(1,6, 1),
(2,11, 0),
(3,6, 0),
(4,7, 0),
(5,11, 0),
(6,6, 1),
(7,2, 1),
(8,2, 1),
(9,8, 0),
(10,4, 0),
(11,4, 0),
(12,3, 1),
(13,5, 0),
(14,10, 0),
(15,3, 1),
(16,12, 0),
(17,12, 0),
(18,10, 0),
(19,12, 1),
(20,8, 0),
(21,12, 1),
(22,3, 1),
(23,10, 0),
(24,10, 1),
(25,6, 0),
(26,12, 0),
(27,11, 1),
(28,10, 1),
(29,12, 1),
(30,2, 0),
(31,5, 1),
(32,3, 0),
(33,1, 0),
(34,5, 0),
(35,5, 0),
(36,3, 1),
(37,3, 1),
(38,11, 0),
(39,7, 1),
(40,10, 0),
(41,10, 1),
(42,1, 0),
(43,1, 0),
(44,11, 0),
(45,12, 0),
(46,1, 1),
(47,3, 1),
(48,6, 0),
(49,3, 0),
(50,10, 1),
(51,10, 1),
(52,8, 0),
(53,1, 0),
(54,10, 0),
(55,6, 0),
(56,6, 1),
(57,9, 0),
(58,7, 1),
(59,6, 1),
(60,10, 0),
(61,11, 0),
(62,6, 0),
(63,12, 1),
(64,4, 0),
(65,12, 0),
(66,3, 0),
(67,10, 0),
(68,11, 0),
(69,4, 1),
(70,8, 1),
(71,2, 1),
(72,10, 1),
(73,6, 1),
(74,2, 0),
(75,6, 0),
(76,3, 0),
(77,3, 0),
(78,10, 0),
(79,1, 1),
(80,7, 1),
(81,11, 1),
(82,1, 1),
(83,9, 1),
(84,8, 1),
(85,3, 0),
(86,8, 0),
(87,3, 0),
(88,1, 1),
(89,1, 1),
(90,1, 0),
(91,2, 0),
(92,6, 1),
(93,7, 0),
(94,1, 0),
(95,8, 1),
(96,9, 1),
(97,1, 1),
(98,12, 1),
(99,7, 1),
(100,2, 0),
(101,6, 0),
(102,12, 1),
(103,9, 1),
(104,8, 0),
(105,11, 1),
(106,9, 0),
(107,1, 1),
(108,2, 0),
(109,4, 1),
(110,10, 1),
(111,8, 1),
(112,11, 1),
(113,9, 0),
(114,7, 0),
(115,1, 0),
(116,3, 1),
(117,6, 0),
(118,2, 1),
(119,1, 0),
(120,11, 0),
(121,3, 1),
(122,11, 1),
(123,3, 1),
(124,4, 0),
(125,5, 1),
(126,3, 0),
(127,9, 1),
(128,1, 0),
(129,11, 0),
(130,12, 1),
(131,2, 0),
(132,1, 0),
(133,6, 0),
(134,3, 1),
(135,2, 1),
(136,6, 0),
(137,5, 1),
(138,12, 0),
(139,9, 0),
(140,4, 1),
(141,6, 0),
(142,10, 1),
(143,4, 1),
(144,11, 1),
(145,3, 1),
(146,5, 0),
(147,10, 1),
(148,5, 0),
(149,6, 0),
(150,6, 1),
(151,9, 1),
(152,5, 0),
(153,6, 1),
(154,3, 1),
(155,2, 0),
(156,2, 0),
(157,11, 1),
(158,12, 1),
(159,8, 0),
(160,8, 1),
(161,2, 1),
(162,7, 1),
(163,2, 1),
(164,10, 0),
(165,3, 1),
(166,9, 0),
(167,12, 0),
(168,7, 1),
(169,9, 1),
(170,3, 1),
(171,6, 1),
(172,10, 1),
(173,1, 0),
(174,9, 1),
(175,6, 0),
(176,2, 0),
(177,7, 0),
(178,2, 0),
(179,1, 0),
(180,2, 1),
(181,4, 0),
(182,2, 0),
(183,9, 1),
(184,1, 1),
(185,10, 0),
(186,7, 0),
(187,6, 1),
(188,11, 1),
(189,11, 0),
(190,9, 0),
(191,8, 1),
(192,7, 1),
(193,3, 1),
(194,6, 0),
(195,3, 0),
(196,7, 0),
(197,1, 1),
(198,2, 0),
(199,12, 1);
/*	(1, 'small', 1),
	(2, 'small', 1),
	(3, 'small', 1),
	(4, 'small', 1),
	(5, 'small', 1),
	(6, 'small', 1),
	(7, 'small', 1),
	(8, 'small', 1),
	(9, 'small', 1),
	(10, 'small', 1),
	(11, 'medium', 1),
	(12, 'medium', 1),
	(13, 'medium', 1),
	(14, 'medium', 1),
	(15, 'medium', 1),
	(16, 'medium', 1),
	(17, 'medium', 1),
	(18, 'medium', 1),
	(19, 'medium', 1),
	(20, 'medium', 1),
	(21, 'large', 1),
	(22, 'large', 1),
	(23, 'large', 1),
	(24, 'large', 1),
	(25, 'large', 1),
	(26, 'large', 1),
	(27, 'large', 1),
	(28, 'large', 1),
	(29, 'large', 1),
	(30, 'large', 1),
	(1, 'small', 2),
	(2, 'small', 2),
	(3, 'small', 2),
	(4, 'small', 2),
	(5, 'small', 2),
	(6, 'small', 2),
	(7, 'small', 2),
	(8, 'small', 2),
	(9, 'small', 2),
	(10, 'small', 2),
	(11, 'medium', 2),
	(12, 'medium', 2),
	(13, 'medium', 2),
	(14, 'medium', 2),
	(15, 'medium', 2),
	(16, 'medium', 2),
	(17, 'medium', 2),
	(18, 'medium', 2),
	(19, 'medium', 2),
	(20, 'medium', 2),
	(21, 'large', 2),
	(22, 'large', 2),
	(23, 'large', 2),
	(24, 'large', 2),
	(25, 'large', 2),
	(26, 'large', 2),
	(27, 'large', 2),
	(28, 'large', 2),
	(29, 'large', 2),
	(30, 'large', 2);*/



INSERT INTO PRZELEW VALUES 
(1,5,49, 2014),
(2,19,48, 2013),
(3,18,155, 2013),
(4,24,32, 2002),
(5,7,52, 2004),
(6,12,100, 2017),
(7,14,250, 2012),
(8,12,125, 2014),
(9,25,28, 2010),
(10,16,151, 2012),
(11,6,187, 2016),
(12,29,96, 2004),
(13,37,79, 2013),
(14,4,72, 2005),
(15,6,156, 2004),
(16,26,2, 2021),
(17,12,125, 2012),
(18,34,50, 2014),
(19,11,110, 2014),
(20,19,244, 2017),
(21,29,19, 2017),
(22,4,152, 2014),
(23,10,221, 2003),
(24,8,81, 2020),
(25,32,19, 2015),
(26,2,140, 2015),
(27,5,249, 2012),
(28,34,132, 2017),
(29,16,210, 2012),
(30,2,186, 2013),
(31,6,232, 2007),
(32,25,69, 2001),
(33,10,173, 2020),
(34,9,157, 2008),
(35,16,182, 2016),
(36,38,11, 2016),
(37,16,43, 2005),
(38,39,32, 2016),
(39,20,80, 2016),
(40,26,236, 2007),
(41,27,202, 2009),
(42,23,12, 2020),
(43,9,10, 2003),
(44,7,169, 2015),
(45,32,158, 2013),
(46,23,164, 2008),
(47,22,232, 2014),
(48,30,20, 2010),
(49,25,195, 2003),
(50,13,236, 2001),
(51,20,133, 2018),
(52,32,201, 2001),
(53,30,101, 2011),
(54,19,186, 2012),
(55,31,214, 2020),
(56,18,31, 2006),
(57,28,177, 2019),
(58,5,123, 2004),
(59,21,122, 2017),
(60,19,51, 2007),
(61,38,117, 2006),
(62,25,46, 2011),
(63,18,184, 2005),
(64,39,216, 2018),
(65,3,6, 2003),
(66,31,182, 2017),
(67,26,94, 2015),
(68,34,159, 2014),
(69,32,169, 2014),
(70,25,12, 2007),
(71,31,42, 2011),
(72,29,68, 2011),
(73,15,206, 2020),
(74,12,239, 2002),
(75,5,34, 2018),
(76,13,58, 2013),
(77,39,156, 2002),
(78,8,85, 2018),
(79,4,65, 2003),
(80,13,198, 2014),
(81,13,49, 2016),
(82,37,203, 2013),
(83,21,29, 2008),
(84,25,132, 2020),
(85,18,184, 2001),
(86,15,115, 2001),
(87,23,0, 2018),
(88,21,205, 2021),
(89,14,18, 2010),
(90,27,181, 2005),
(91,11,60, 2004),
(92,4,184, 2009),
(93,21,137, 2014),
(94,18,5, 2009),
(95,6,165, 2002),
(96,6,103, 2020),
(97,32,218, 2021),
(98,30,61, 2021),
(99,39,196, 2003),
(100,4,20, 2010),
(101,15,5, 2009),
(102,12,78, 2007),
(103,33,116, 2014),
(104,38,73, 2017),
(105,20,161, 2018),
(106,33,110, 2015),
(107,3,99, 2021),
(108,16,19, 2004),
(109,27,201, 2015),
(110,31,135, 2011),
(111,13,9, 2016),
(112,2,57, 2015),
(113,24,192, 2016),
(114,34,122, 2009),
(115,28,205, 2008),
(116,27,30, 2011),
(117,17,106, 2007),
(118,6,116, 2020),
(119,1,203, 2009),
(120,17,124, 2011),
(121,13,189, 2002),
(122,12,140, 2011),
(123,22,64, 2020),
(124,39,161, 2000),
(125,36,79, 2000),
(126,22,178, 2002),
(127,3,88, 2000),
(128,27,45, 2000),
(129,9,129, 2020),
(130,15,79, 2013),
(131,31,116, 2014),
(132,29,43, 2003),
(133,28,140, 2018),
(134,6,57, 2013),
(135,10,189, 2001),
(136,4,117, 2005),
(137,36,115, 2004),
(138,36,132, 2006),
(139,9,246, 2000),
(140,23,70, 2002),
(141,36,165, 2018),
(142,5,114, 2000),
(143,35,52, 2013),
(144,38,197, 2004),
(145,36,16, 2000),
(146,4,131, 2003),
(147,3,138, 2021),
(148,17,16, 2016),
(149,27,47, 2011),
(150,10,156, 2011),
(151,30,78, 2003);


INSERT INTO Produkt
VALUES     (1,'Fanta', 10,5.99),
    (1,'Muller',10, 8.99),
    (1,'Bakoma', 10,2.59),
    (1,'Hortex',10, 2.99),
    (1,'Hortex',10, 4.00),
    (1,'Oshee', 10,3.59),
    (1,'Cisowianka',10, 1.59),
    (1,'Żywiec Zdrój', 10,1.99),
    (1,'Cisowianka',10, 1.59),
    (1,'Żywiec Zdrój',10, 1.99),
    (1,'Pawełek',10, 2.55),
    (1,'Bounty',10, 3.00),
    (1,'Snickers',10, 3.99),
    (1,'Michałek',10, 3.50),
    (1,'Twix',10, 3.45),
    (1,'Flips',10, 1.99),
    (1,'Knoppers',10, 3.50),
    (1,'GoOn',10, 6.79),
    (1,'KFD',10, 69.00),
	    (2,'Fanta', 10,5.99),
    (2,'Muller',10, 8.99),
    (2,'Bakoma', 10,2.59),
    (2,'Hortex',10, 2.99),
    (2,'Hortex',10, 4.00),
    (2,'Oshee', 10,3.59),
    (2,'Cisowianka',10, 1.59),
    (2,'Żywiec Zdrój', 10,1.99),
    (2,'Cisowianka',10, 1.59),
    (2,'Żywiec Zdrój',10, 1.99),
    (2,'Pawełek',10, 2.55),
    (2,'Bounty',10, 3.00),
    (2,'Snickers',10, 3.99),
    (2,'Michałek',10, 3.50),
    (2,'Twix',10, 3.45),
    (2,'Flips',10, 1.99),
    (2,'Knoppers',10, 3.50),
    (2,'GoOn',10, 6.79),
    (2,'KFD',10, 69.00),
	(3,'Fanta', 10,5.99),
    (3,'Muller',10, 8.99),
    (3,'Bakoma', 10,2.59),
    (3,'Hortex',10, 2.99),
    (3,'Hortex',10, 4.00),
    (3,'Oshee', 10,3.59),
    (3,'Cisowianka',10, 1.59),
    (3,'Żywiec Zdrój', 10,1.99),
    (3,'Cisowianka',10, 1.59),
    (3,'Żywiec Zdrój',10, 1.99),
    (3,'Pawełek',10, 2.55),
    (3,'Bounty',10, 3.00),
    (3,'Snickers',10, 3.99),
    (3,'Michałek',10, 3.50),
    (3,'Twix',10, 3.45),
    (3,'Flips',10, 1.99),
    (3,'Knoppers',10, 3.50),
    (3,'GoOn',10, 6.79),
    (3,'KFD',10, 69.00),
    (3,'Fanta', 10,5.99),
	  (3,'Fanta', 10,5.99),
    (4,'Muller',10, 8.99),
    (5,'Bakoma', 10,2.59),
    (6,'Hortex',10, 2.99),
    (7,'Hortex',10, 4.00),
    (8,'Oshee', 10,3.59),
    (9,'Cisowianka',10, 1.59),
    (10,'Żywiec Zdrój', 10,1.99),
    (11,'Cisowianka',10, 1.59),
	(6,'Flips',10, 1.99),
    (6,'Knoppers',10, 3.50),
    (9,'GoOn',10, 6.79),
    (8,'KFD',10, 69.00),
	(3,'Fanta', 10,5.99),
    (7,'Muller',10, 8.99),
    (8,'Bakoma', 10,2.59),
    (8,'Hortex',10, 2.99),
    (7,'Hortex',10, 4.00),
    (5,'Oshee', 10,3.59);

/*INSERT INTO NAPOJE
VALUES (1, 250, 'Kawowy', 'Kawa'),
    (2, 500, 'grejpfrutowa', 'WodaGaz'),
    (3, 500, 'cytrynowa', 'WodaGaz'),
    (4, 500, 'pomarańczowa', 'WodaGaz'),
    (5, 1000, 'czekoladowy', 'NapojMlecz'),
    (6, 250, 'mleczny', 'NapojMlecz'),
    (7, 350, 'brzoskwiniowa', 'Sok'),
    (8, 500, 'malinowa', 'Sok'),
    (9, 750, 'cytrynowy', 'Izotonik'),
    (10, 1000, 'brak', 'WodaGaz'),
    (11, 1000, 'brak', 'WodaGaz'),
    (12, 1000, 'brak', 'WodaNieGaz'),
    (13, 1000, 'brak', 'WodaNieGaz');*/

INSERT INTO BATONY
VALUES (14, 50, 'czekoladowy', 250),
    (15, 55, 'kokosowy', 280),
    (16, 75, 'toffee', 310),
    (17, 90, 'waniliowy', 345),
    (18, 100, 'karmelowy', 380),
    (19, 125, 'kokosowy', 420),
    (21, 175, 'orzechowy', 500);

INSERT INTO BIALKA
VALUES (22, 750, 'kokosowy', 80),
    (23, 750, 'bananowo-truskawkowy', 75),
    (24, 750, 'solony karmel', 79),
    (25, 750, 'czekoladowy', 85),
    (26, 750, 'creme brule', 82),
    (27, 750, 'karmelowo mleczny', 83),
    (28, 750, 'lody waniliowe', 70),
    (29, 750, 'jogurtowo-wiśniowy', 88),
    (30, 750, 'biała czekolada-malina', 81),
    (31, 500, 'kokosowy', 80),
    (32, 500, 'bananowo-truskawkowy', 75),
    (33, 500, 'solony karmel', 79),
    (34, 500, 'czekoladowy', 85),
    (35, 500, 'creme brule', 82),
    (36, 500, 'karmelowo mleczny', 83),
    (37, 500, 'lody waniliowe', 70),
    (38, 500, 'jogurtowo-wiśniowy', 88),
    (39, 500, 'biała czekolada-malina', 81),
    (40, 750, 'kokosowy', 80),
    (41, 750, 'bananowo-truskawkowy', 75),
    (42, 750, 'solony karmel', 79),
    (43, 750, 'czekoladowy', 85),
    (44, 750, 'creme brule', 82),
    (45, 750, 'karmelowo mleczny', 83),
    (46, 750, 'lody waniliowe', 70),
    (47, 750, 'jogurtowo-wiśniowy', 88),
    (48, 750, 'biała czekolada-malina', 81),
    (49, 500, 'kokosowy', 80),
    (50, 500, 'bananowo-truskawkowy', 75),
    (51, 500, 'solony karmel', 79),
    (52, 500, 'czekoladowy', 85),
    (53, 500, 'creme brule', 82),
    (54, 500, 'karmelowo mleczny', 83),
    (55, 500, 'lody waniliowe', 70),
    (56, 500, 'jogurtowo-wiśniowy', 88),
    (57, 500, 'biała czekolada-malina', 81);

/*INSERT INTO DODATKI
VALUES (58, 'Guma Oporowa'),
    (59, 'Drążek'),
    (60, 'Magnezja'),
    (61, 'Kreatyna'),
    (62, 'Testosteron'),
    (63, 'Metanabol'),
    (64, 'Hormon Wzrostu'),
    (65, 'Kamizelka Obciążeniowa'),
    (66, 'Roller'),
    (67, 'Gripper'),
    (68, 'Pas');*/


	  DECLARE @counter as INT = 1;
	WHILE @counter < 14
	BEGIN
		INSERT INTO Sprzet VALUES
		(@counter, 'obciazenia', 10),
		(@counter, 'obciazenia', 10),
		(@counter, 'obciazenia', 10),
		(@counter, 'obciazenia', 10),
		(@counter, 'obciazenia', 10),
		(@counter, 'obciazenia', 10),
		(@counter, 'obciazenia', 10),
		(@counter, 'obciazenia', 10),
		(@counter, 'obciazenia', 10),
		(@counter, 'obciazenia', 10),
		(@counter, 'obciazenia', 10),
		(@counter, 'obciazenia', 10),
		(@counter, 'obciazenia', 10),
		(@counter, 'obciazenia', 10),
		(@counter, 'obciazenia', 10),
		(@counter, 'obciazenia', 10),
		(@counter, 'obciazenia', 10),
		(@counter, 'obciazenia', 10),
		(@counter, 'obciazenia', 10),
		(@counter, 'obciazenia', 10),
		(@counter, 'obciazenia', 10),
		(@counter, 'obciazenia', 10),
		(@counter, 'obciazenia', 10),
		(@counter, 'obciazenia', 10),
		(@counter, 'obciazenia', 10),
		(@counter, 'obciazenia', 10),
		(@counter, 'obciazenia', 10),
		(@counter, 'obciazenia', 10),
		(@counter, 'obciazenia', 10),
		(@counter, 'obciazenia', 10),
		(@counter, 'obciazenia', 10),
		(@counter, 'obciazenia', 10),
		(@counter, 'obciazenia', 10),
		(@counter, 'obciazenia', 10),
		(@counter, 'obciazenia', 10),
		(@counter, 'obciazenia', 10),
		(@counter, 'obciazenia', 10),
		(@counter, 'obciazenia', 10),
		(@counter, 'obciazenia', 10),
		(@counter, 'obciazenia', 10),
		(@counter, 'hantle', 2),
		(@counter, 'hantle', 2),
		(@counter, 'hantle', 2),
		(@counter, 'hantle', 3),
		(@counter, 'hantle', 3),
		(@counter, 'hantle', 3),
		(@counter, 'hantle', 3),
		(@counter, 'hantle', 3),
		(@counter, 'hantle', 2),
		(@counter, 'hantle', 2),
		(@counter, 'drazki', 1),
		(@counter, 'drazki', 1),
		(@counter, 'drazki', 1),
		(@counter, 'drazki', 1),
		(@counter, 'drazki', 2),
		(@counter, 'drazki', 2),
		(@counter, 'drazki', 2),
		(@counter, 'drazki', 2),
		(@counter, 'drazki', 3),
		(@counter, 'drazki', 2),
		(@counter, 'drazki', 2),
		(@counter, 'drazki', 2),
		(@counter, 'bieznia',15),
		(@counter, 'rowerek',20),
		(@counter, 'laweczka', 10),
		(@counter, 'laweczka_z_asekuracja', 5),
		(@counter, 'orbitrek', 7),
		(@counter, 'schodki', 4),
		(@counter, 'pudla', 8),
		(@counter, 'stojak_na_ciezary', 14),
		(@counter, 'suwnica', 3),
		(@counter, 'stojak_do_przysiadow', 6),
		(@counter, 'wyciag_pojedynczy', 6),
		(@counter, 'wyciag_podwojny', 3),
		(@counter, 'atlas_wielofunkcyjny', 4),
		(@counter, 'urzadzenie_masujace', 1),
		(@counter, 'wyciag_do_miesni_grzbietu', 3),
		(@counter, 'maszyna_do_miesni_czworoglowych', 2),
		(@counter, 'maszyna_do_miesni_dwuglowych', 2),
		(@counter, 'maszyna_do_miesni_brzucha', 1),
		(@counter, 'drazkiazek_z_asekuracja',  3),
		(@counter, 'lawka_regulowana', 10),
		(@counter, 'klatka_treningowa', 3),
		(@counter, 'weiszak_na_gryfy', 8),
		(@counter, 'maszyna_na_triceps', 3),
		(@counter, 'mazyna_na_biceps', 2),
		(@counter, 'drazkiazek_z_workiem_bokserskim', 2),
		(@counter, 'lawka_skosna', 9),
		(@counter, 'lawka_olmipijska', 2),
		(@counter, 'Gumy', 10),
		(@counter, 'Gumy', 10),
		(@counter, 'Gumy', 10),
		(@counter, 'Gumy', 10),
		(@counter, 'Gumy', 10),
		(@counter, 'Gumy', 10),
		(@counter, 'Gumy', 10),
		(@counter, 'Gumy', 10),
		(@counter, 'Gumy', 10),
		(@counter, 'Pasy', 10),
		(@counter, 'Pasy', 10),
		(@counter, 'Pasy', 10),
		(@counter, 'Pasy', 10),
		(@counter, 'Pasy', 10),
		(@counter, 'Pasy', 10),
		(@counter, 'Pasy', 10),
		(@counter, 'Pasy', 10),
		(@counter, 'Pasy', 10),
		(@counter, 'Pasy', 10),
		(@counter, 'Pasy', 10),
		(@counter, 'Pilki', 10),
		(@counter, 'Pilki', 10),
		(@counter, 'Pilki', 10),
		(@counter, 'Pilki', 10),
		(@counter, 'Pilki', 10),
		(@counter, 'Pilki', 10),
		(@counter, 'Pilki', 10),
		(@counter, 'Pilki', 10),
		(@counter, 'Pilki', 10),
		(@counter, 'Pilki', 10),
		(@counter, 'Maty', 10),
		(@counter, 'Maty', 10),
		(@counter, 'Maty', 10),
		(@counter, 'Maty', 10),
		(@counter, 'Maty', 10),
		(@counter, 'Maty', 10),
		(@counter, 'Maty', 10),
		(@counter, 'Maty', 10),
		(@counter, 'Maty', 10),
		(@counter, 'Maty', 10),
		(@counter, 'Kamizelki', 2),
		(@counter, 'Kamizelki', 2),
		(@counter, 'Kamizelki', 2),
		(@counter, 'Kamizelki', 3),
		(@counter, 'Kamizelki', 3),
		(@counter, 'Kamizelki', 3),
		(@counter, 'Kamizelki', 3),
		(@counter, 'Kamizelki', 3),
		(@counter, 'Kamizelki', 2),
		(@counter, 'Kamizelki', 2)

		INSERT INTO Obciazenia VALUES
		((@counter - 1) * 139 + 1, 2, 1),
		((@counter - 1) * 139 + 2, 5, 4),
		((@counter - 1) * 139 + 3, 7.5, 4),
		((@counter - 1) * 139 + 4, 8, 2),
		((@counter - 1) * 139 + 5, 12.5, 6),
		((@counter - 1) * 139 + 6, 12, 6),
		((@counter - 1) * 139 + 7, 17.5, 3),
		((@counter - 1) * 139 + 8, 20, 5),
		((@counter - 1) * 139 + 9, 22.5, 0),
		((@counter - 1) * 139 + 10, 20, 3),
		((@counter - 1) * 139 + 11, 22, 5),
		((@counter - 1) * 139 + 12, 30, 0),
		((@counter - 1) * 139 + 13, 26, 1),
		((@counter - 1) * 139 + 14, 28, 4),
		((@counter - 1) * 139 + 15, 30, 3),
		((@counter - 1) * 139 + 16, 40, 2),
		((@counter - 1) * 139 + 17, 42.5, 5),
		((@counter - 1) * 139 + 18, 36, 1),
		((@counter - 1) * 139 + 19, 38, 6),
		((@counter - 1) * 139 + 20, 50, 4),
		((@counter - 1) * 139 + 21, 52.5, 0),
		((@counter - 1) * 139 + 22, 44, 3),
		((@counter - 1) * 139 + 23, 57.5, 5),
		((@counter - 1) * 139 + 24, 48, 5),
		((@counter - 1) * 139 + 25, 50, 4),
		((@counter - 1) * 139 + 26, 65, 6),
		((@counter - 1) * 139 + 27, 54, 3),
		((@counter - 1) * 139 + 28, 56, 3),
		((@counter - 1) * 139 + 29, 58, 5),
		((@counter - 1) * 139 + 30, 75, 1),
		((@counter - 1) * 139 + 31, 62, 4),
		((@counter - 1) * 139 + 32, 80, 4),
		((@counter - 1) * 139 + 33, 82.5, 4),
		((@counter - 1) * 139 + 34, 68, 3),
		((@counter - 1) * 139 + 35, 70, 2),
		((@counter - 1) * 139 + 36, 90, 6),
		((@counter - 1) * 139 + 37, 74, 4),
		((@counter - 1) * 139 + 38, 95, 0),
		((@counter - 1) * 139 + 39, 78, 1),
		((@counter - 1) * 139 + 40, 100, 5);

		INSERT INTO Hantle VALUES
		((@counter - 1) * 139 + 41, 1, 'gumowe'),
		((@counter - 1) * 139 + 42, 3, 'winylowe'),
		((@counter - 1) * 139 + 43, 5, 'winylowe'),
		((@counter - 1) * 139 + 44, 7, 'gumowe'),
		((@counter - 1) * 139 + 45, 9, 'winylowe'),
		((@counter - 1) * 139 + 46, 11, 'żeliwne'),
		((@counter - 1) * 139 + 47, 13, 'żeliwne'),
		((@counter - 1) * 139 + 48, 15, 'gumowe'),
		((@counter - 1) * 139 + 49, 17, 'winylowe'),
		((@counter - 1) * 139 + 50, 19, 'winylowe');

		INSERT INTO Drazki VALUES
		((@counter - 1) * 139 + 51, 150, 2),
		((@counter - 1) * 139 + 52, 155, 2.125),
		((@counter - 1) * 139 + 53, 160, 2.25),
		((@counter - 1) * 139 + 54, 165, 2.375),
		((@counter - 1) * 139 + 55, 170, 2.5),
		((@counter - 1) * 139 + 56, 175, 2.625),
		((@counter - 1) * 139 + 57, 180, 2.75),
		((@counter - 1) * 139 + 58, 185, 2.875),
		((@counter - 1) * 139 + 59, 190, 3),
		((@counter - 1) * 139 + 60, 195, 3.125),
		((@counter - 1) * 139 + 61, 200, 3.25),
		((@counter - 1) * 139 + 62, 205, 3.375);

		INSERT INTO Maszyny VALUES
		((@counter - 1) * 139 + 64, 120, 6),
		((@counter - 1) * 139 + 65, 80, 10),
		((@counter - 1) * 139 + 66, 90, 10),
		((@counter - 1) * 139 + 67, 110, 8),
		((@counter - 1) * 139 + 68, 90, 2),
		((@counter - 1) * 139 + 69, 80, 6),
		((@counter - 1) * 139 + 70, 120, 2),
		((@counter - 1) * 139 + 71, 90, 8),
		((@counter - 1) * 139 + 72, 80, 8),
		((@counter - 1) * 139 + 73, 120, 4),
		((@counter - 1) * 139 + 74, 80, 4),
		((@counter - 1) * 139 + 75, 120, 4),
		((@counter - 1) * 139 + 76, 120, 10),
		((@counter - 1) * 139 + 77, 80, 6),
		((@counter - 1) * 139 + 78, 100, 10),
		((@counter - 1) * 139 + 79, 110, 10),
		((@counter - 1) * 139 + 80, 120, 8),
		((@counter - 1) * 139 + 81, 110, 2),
		((@counter - 1) * 139 + 82, 100, 8),
		((@counter - 1) * 139 + 83, 100, 6),
		((@counter - 1) * 139 + 84, 120, 4),
		((@counter - 1) * 139 + 85, 110, 4),
		((@counter - 1) * 139 + 86, 100, 4),
		((@counter - 1) * 139 + 87, 110, 6),
		((@counter - 1) * 139 + 88, 80, 4),
		((@counter - 1) * 139 + 89, 80, 4);

		INSERT INTO Gumy VALUES
		((@counter - 1) * 139 + 90, 2, 4),
		((@counter - 1) * 139 + 91, 2, 6),
		((@counter - 1) * 139 + 92, 4, 8),
		((@counter - 1) * 139 + 93, 4, 12),
		((@counter - 1) * 139 + 94, 6, 12),
		((@counter - 1) * 139 + 95, 6, 18),
		((@counter - 1) * 139 + 96, 8, 16),
		((@counter - 1) * 139 + 97, 8, 24),
		((@counter - 1) * 139 + 98, 10, 30);

		INSERT INTO Pasy VALUES
		((@counter - 1) * 139 + 99, 'S-'),
		((@counter - 1) * 139 + 100, 'S'),
		((@counter - 1) * 139 + 101, 'S+'),
		((@counter - 1) * 139 + 102, 'S++'),
		((@counter - 1) * 139 + 103, 'M-'),
		((@counter - 1) * 139 + 104, 'M'),
		((@counter - 1) * 139 + 105, 'M+'),
		((@counter - 1) * 139 + 106, 'L-'),
		((@counter - 1) * 139 + 107, 'L'),
		((@counter - 1) * 139 + 108, 'L+'),
		((@counter - 1) * 139 + 109, 'L++');

		INSERT INTO Pilki VALUES
		((@counter - 1) * 139 + 110, 'S-', 'czerwona', 'winylowa'),
		((@counter - 1) * 139 + 111, 'S', 'zielona', 'gumowa'),
		((@counter - 1) * 139 + 112, 'S+', 'niebieska', 'winylowa'),
		((@counter - 1) * 139 + 113, 'S++', 'czerwona', 'gumowa'),
		((@counter - 1) * 139 + 114, 'M-', 'zielona', 'winylowa'),
		((@counter - 1) * 139 + 115, 'M', 'niebieska', 'gumowa'),
		((@counter - 1) * 139 + 116, 'M+', 'czerwona', 'winylowa'),
		((@counter - 1) * 139 + 117, 'L-', 'zielona', 'gumowa'),
		((@counter - 1) * 139 + 118, 'L', 'niebieska', 'winylowa'),
		((@counter - 1) * 139 + 119, 'L+', 'czerwona', 'gumowa');

		INSERT INTO Maty VALUES
		((@counter - 1) * 139 + 120, 60, 30),
		((@counter - 1) * 139 + 121, 60, 45),
		((@counter - 1) * 139 + 122, 80, 40),
		((@counter - 1) * 139 + 123, 80, 60),
		((@counter - 1) * 139 + 124, 100, 50),
		((@counter - 1) * 139 + 125, 100, 75),
		((@counter - 1) * 139 + 126, 120, 60),
		((@counter - 1) * 139 + 127, 120, 90),
		((@counter - 1) * 139 + 128, 140, 70),
		((@counter - 1) * 139 + 129, 140, 105);

		INSERT INTO Kamizelki VALUES
		((@counter - 1) * 139 + 130, 2, 10, 'S'),
		((@counter - 1) * 139 + 131, 2, 10, 'M'),
		((@counter - 1) * 139 + 132, 4, 10, 'L'),
		((@counter - 1) * 139 + 133, 2, 15, 'S'),
		((@counter - 1) * 139 + 134, 2, 15, 'M'),
		((@counter - 1) * 139 + 135, 4, 15, 'L'),
		((@counter - 1) * 139 + 136, 2, 20, 'S'),
		((@counter - 1) * 139 + 137, 2, 20, 'M'),
		((@counter - 1) * 139 + 138, 4, 20, 'L'),
		((@counter - 1) * 139 + 139, 12, 30, 'L');


		SET @counter = @counter + 1;
	END;


INSERT INTO DOLAR VALUES (2);

IF OBJECT_ID ('dbo.Opened_new_location') IS NOT NULL
	DROP TRIGGER Opened_new_location;

IF OBJECT_ID ('dbo.Make_Payment') IS NOT NULL
	DROP TRIGGER Make_Payment;

IF OBJECT_ID ('dbo.Register_fee') IS NOT NULL
	DROP TRIGGER Register_fee;

IF OBJECT_ID ('dbo.trgPodwyzkaSprzataczka') IS NOT NULL
	DROP TRIGGER trgPodwyzkaSprzataczka;

IF OBJECT_ID ('dbo.trgPodwyzkaOchroniarz') IS NOT NULL
	DROP TRIGGER trgPodwyzkaOchroniarz;

GO
CREATE TRIGGER Opened_new_location ON Placowka 
	AFTER INSERT
	AS
	BEGIN
	 UPDATE Dolar
	 Set Kurs = Kurs + 1
END

GO
CREATE TRIGGER Make_Payment ON Klienci
	AFTER Update 
	AS
	BEGIN 
		DECLARE @A int, @C int;

		SELECT @A = ID_klienta, @C = CAST(A.Cena_Dynamiczna * B.Kurs as int) FROM Inserted
			LEFT JOIN Oferta A ON ID_oferty = Id_biletu 
			LEFT JOIN Dolar B ON ID_Dolara = 1 

		INSERT INTO Przelew VALUES(@A,@C,getdate());
	END

GO
CREATE TRIGGER Register_fee ON KLIENCI
	AFTER INSERT 
	AS
	BEGIN 
		DECLARE @A int, @C int;

		SELECT @A = ID_klienta, @C = 5 * B.Kurs FROM Inserted
			LEFT JOIN Dolar B ON ID_Dolara = 1 

		INSERT INTO Przelew VALUES(@A,@C,getdate());
	END

GO
CREATE TRIGGER trgPodwyzkaSprzataczka ON Sprzataczka
	AFTER UPDATE
	AS
	BEGIN
		UPDATE Sprzataczka
		SET Sprzataczka.Wyplata_Godzinowa = Sprzataczka.Wyplata_Godzinowa - 1
	END

GO
CREATE TRIGGER trgPodwyzkaOchroniarz ON Ochrona
	AFTER UPDATE
	AS
	BEGIN
		UPDATE Ochrona
		SET Ochrona.Wyplata_Godzinowa = Ochrona.Wyplata_Godzinowa - 1
	END
GO

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
	ID_Przelewu int IDENTITY(1, 1) PRIMARY KEY,
	ID_Klienta int constraint SK_Przelew foreign Key (ID_Klienta) references Klienci(ID_klienta),
	Kwota INT,
	DataPrzelewu DATE DEFAULT GETDATE(),
);

/* ------------------------------------------------------------------------------------------------------------------------------------------ */

CREATE TABLE Szafki (
	ID_Szafki int IDENTITY(1, 1) PRIMARY KEY,
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
	ID_Pracownika int not null	
	constraint PK_Napoje primary Key (ID_Pracownika)
	constraint SK_Napoje foreign Key (ID_Pracownika) references Pracownik(ID_Pracownika) ON DELETE CASCADE,
    Pojemnosc INT not NULL,
	Opakowanie NVARChar(255) NOT NULL
	CHECK (Opakowanie IN ('karton','plastik'))
)
Create Table Batony(
	ID_Pracownika int not null	
	constraint PK_Batony primary Key (ID_Pracownika)
	constraint SK_Batony foreign Key (ID_Pracownika) references Pracownik(ID_Pracownika) ON DELETE CASCADE,
    Waga Int not NULL,
    Smak NVarChar(255),
    Kalorie Int not NULL,
)

Create Table Bialka(
	ID_Pracownika int not null	
	constraint PK_Bialka primary Key (ID_Pracownika)
	constraint SK_Bialka foreign Key (ID_Pracownika) references Pracownik(ID_Pracownika) ON DELETE CASCADE,
    Waga Int not null,
    Smak NVarChar(255) not null,
    Przelicznik Int not null, -- ile bialka rzeczywiscie w 100 gram
)
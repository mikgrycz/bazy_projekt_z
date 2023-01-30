IF OBJECT_ID(N'kupObciazenia') IS NOT NULL
DROP PROC kupObciazenia
IF OBJECT_ID(N'kupHantle') IS NOT NULL
DROP PROC kupHantle
IF OBJECT_ID(N'kupDrazki') IS NOT NULL
DROP PROC kupDrazki
IF OBJECT_ID(N'kupMaszyny') IS NOT NULL
DROP PROC kupMaszyny
IF OBJECT_ID(N'kupGumy') IS NOT NULL
DROP PROC kupGumy
IF OBJECT_ID(N'kupPasy') IS NOT NULL
DROP PROC kupPasy
IF OBJECT_ID(N'kupPilki') IS NOT NULL
DROP PROC kupPilki
IF OBJECT_ID(N'kupMaty') IS NOT NULL
DROP PROC kupMaty
IF OBJECT_ID(N'kupKamizelki') IS NOT NULL
DROP PROC kupKamizelki

CREATE PROC kupObciazenia @masa INT, @otwor INT, @idPlacowki INT, @ilosc INT
AS
	DECLARE @nextIndex AS INT
	SET @nextIndex = (SELECT MAX(ID_Sprzetu) FROM Sprzet)
	SET @nextIndex = @nextIndex + 1
	INSERT INTO Sprzet VALUES (@idPlacowki, 'obciazenia', @ilosc)
	INSERT INTO Obciazenia VALUES (@nextIndex, @masa, @otwor)
GO

EXEC kupObciazenia @masa = 14, @otwor = 8, @idPlacowki = 8, @ilosc = 12

CREATE PROC kupHantle @masa INT, @typ NVARCHAR(15), @idPlacowki INT, @ilosc INT
AS
	DECLARE @nextIndex AS INT
	SET @nextIndex = (SELECT MAX(ID_Sprzetu) FROM Sprzet)
	SET @nextIndex = @nextIndex + 1
	IF @typ IN ('winylowe','gumowe','żeliwne')
	BEGIN
		INSERT INTO Sprzet VALUES (@idPlacowki, 'hantle', @ilosc)
		INSERT INTO Hantle VALUES (@nextIndex, @masa, @typ)
	END
GO

CREATE PROC kupDrazki @szerokosc INT, @srednica INT, @idPlacowki INT, @ilosc INT
AS
	DECLARE @nextIndex AS INT
	SET @nextIndex = (SELECT MAX(ID_Sprzetu) FROM Sprzet)
	SET @nextIndex = @nextIndex + 1
	INSERT INTO Sprzet VALUES (@idPlacowki, 'drazki', @ilosc)
	INSERT INTO Drazki VALUES (@nextIndex, @szerokosc, @srednica)
GO

CREATE PROC kupMaszyny @maxWaga INT, @zwiekszenie INT, @idPlacowki INT, @ilosc INT, @nazwa NVARCHAR(50)
AS
	DECLARE @nextIndex AS INT
	SET @nextIndex = (SELECT MAX(ID_Sprzetu) FROM Sprzet)
	SET @nextIndex = @nextIndex + 1
	INSERT INTO Sprzet VALUES (@idPlacowki,@nazwa , @ilosc)
	INSERT INTO Maszyny VALUES (@nextIndex, @maxWaga, @zwiekszenie)
GO

CREATE PROC kupGumy @min INT, @max INT, @idPlacowki INT, @ilosc INT
AS
	DECLARE @nextIndex AS INT
	SET @nextIndex = (SELECT MAX(ID_Sprzetu) FROM Sprzet)
	SET @nextIndex = @nextIndex + 1
	INSERT INTO Sprzet VALUES (@idPlacowki, 'gumy', @ilosc)
	INSERT INTO Gumy VALUES (@nextIndex, @min, @max)
GO

CREATE PROC kupPasy @size NVARCHAR(255), @idPlacowki INT, @ilosc INT
AS
	DECLARE @nextIndex AS INT
	SET @nextIndex = (SELECT MAX(ID_Sprzetu) FROM Sprzet)
	SET @nextIndex = @nextIndex + 1
	INSERT INTO Sprzet VALUES (@idPlacowki, 'pasy', @ilosc)
	INSERT INTO Pasy VALUES (@nextIndex, @size)
GO

CREATE PROC kupPilki @size NVARCHAR(255), @kolor NVARCHAR(255), @typ NVARCHAR(255), @idPlacowki INT, @ilosc INT
AS
	DECLARE @nextIndex AS INT
	SET @nextIndex = (SELECT MAX(ID_Sprzetu) FROM Sprzet)
	SET @nextIndex = @nextIndex + 1
	IF @typ IN ('winylowa','gumowa')
	BEGIN
		INSERT INTO Sprzet VALUES (@idPlacowki, 'pilki', @ilosc)
		INSERT INTO Pilki VALUES (@nextIndex, @size, @kolor, @typ)
	END
GO

CREATE PROC kupMaty @dlugosc INT, @szerokosc INT, @idPlacowki INT, @ilosc INT
AS
	DECLARE @nextIndex AS INT
	SET @nextIndex = (SELECT MAX(ID_Sprzetu) FROM Sprzet)
	SET @nextIndex = @nextIndex + 1
	INSERT INTO Sprzet VALUES (@idPlacowki, 'maty', @ilosc)
	INSERT INTO Maty VALUES (@nextIndex, @dlugosc, @szerokosc)
GO

CREATE PROC kupKamizelki @kieszonki INT, @max INT, @size NVARCHAR(255), @idPlacowki INT, @ilosc INT
AS
	DECLARE @nextIndex AS INT
	SET @nextIndex = (SELECT MAX(ID_Sprzetu) FROM Sprzet)
	SET @nextIndex = @nextIndex + 1
	INSERT INTO Sprzet VALUES (@idPlacowki, 'kamizelki', @ilosc)
	INSERT INTO Kamizelki VALUES (@nextIndex, @kieszonki, @max, @size)
GO

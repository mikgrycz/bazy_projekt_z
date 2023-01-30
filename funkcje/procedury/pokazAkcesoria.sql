IF OBJECT_ID(N'pokaz_akcesoria') IS NOT NULL
DROP VIEW pokaz_akcesoria
CREATE PROC pokaz_akcesoria @idPlacowki INT
AS
	SELECT * FROM Sprzet
	WHERE Sprzet.ID_Placowki = @idPlacowki
GO

EXEC pokaz_akcesoria @idPlacowki = 8

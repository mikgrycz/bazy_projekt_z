CREATE PROC pokaz_akcesoria @idPlacowki INT
AS
	SELECT * FROM Sprzet
	WHERE Sprzet.ID_Placowki = @idPlacowki
GO

EXEC pokaz_akcesoria @idPlacowki = 8

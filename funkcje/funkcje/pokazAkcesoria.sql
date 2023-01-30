IF OBJECT_ID(N'pokaz_akcesoria') IS NOT NULL
DROP FUNCTION pokaz_akcesoria

GO
CREATE FUNCTION pokaz_akcesoria (@idPlacowki INT)
RETURNS TABLE
AS
	RETURN (SELECT * FROM Sprzet
	WHERE Sprzet.ID_Placowki = @idPlacowki)
GO
SELECT * FROM pokaz_akcesoria(1)

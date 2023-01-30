IF OBJECT_ID(N'zarezerwujSzafke') IS NOT NULL
DROP PROC zarezerwujszafke
CREATE PROC zarezerwujSzafke @id INT
AS
	UPDATE Szafki
	SET Szafki.Zajeta = 1
	WHERE Szafki.ID_Szafki = @id
GO

EXEC zarezerwujSzafke @id = 5

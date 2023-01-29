CREATE PROC zarezerwujSzafke @id INT
AS
	UPDATE Szafki
	SET Szafki.Zajeta = 1
	WHERE Szafki.ID_Szafki = @id
GO

EXEC zarezerwujSzafke @id = 5

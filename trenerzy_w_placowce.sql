
CREATE VIEW Trenerzy_w_placowce
AS
	SELECT FirstName, LastName FROM (Trener  JOIN Pracownik  ON Trener.ID_Pracownika = Pracownik.ID_Pracownika )
	WHERE ID_Placowki = 1

GO

SELECT * FROM Trenerzy_w_placowce WHERE FirstName = 'Chad' OR FirstName = 'Tyron'

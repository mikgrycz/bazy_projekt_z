IF OBJECT_ID('Najsilniejszy_ochroniarz') IS NOT NULL
DROP VIEW Najsilniejszy_ochroniarz
CREATE VIEW Najsilniejszy_ochroniarz
AS
	 SELECT TOP 1 WITH TIES Rozmiar_Bicepsu FROM Ochrona JOIN Pracownik 
	 ON Ochrona.ID_Pracownika = Pracownik.ID_Pracownika WHERE Pracownik.ID_Placowki = 1
	  GROUP BY Rozmiar_Bicepsu ORDER BY Rozmiar_Bicepsu DESC
GO

SELECT * FROM Najsilniejszy_ochroniarz

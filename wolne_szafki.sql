IF OBJECT_ID('wolne_szafki') IS NOT NULL
DROP VIEW wolne_szafki
CREATE VIEW wolne_szafki
AS
	 SELECT ID_szafki, placowka.ID_Placowki FROM Szafki JOIN Placowka
	 ON Szafki.ID_Placowki = Placowka.ID_Placowki WHERE Szafki.Zajeta = 0
GO

SELECT ID_szafki FROM wolne_szafki WHERE ID_Placowki = 2

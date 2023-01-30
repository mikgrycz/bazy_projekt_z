IF OBJECT_ID(N'Najlepsze_bialko') IS NOT NULL
DROP VIEW Najlepsze_bialko
CREATE VIEW Najlepsze_bialko
AS
SELECT * FROM Bialka WHERE Bialka.Przelicznik IN (SELECT TOP 2 WITH TIES Przelicznik FROM Bialka GROUP BY Przelicznik ORDER BY Przelicznik) 
GO

SELECT * FROM Najlepsze_bialko

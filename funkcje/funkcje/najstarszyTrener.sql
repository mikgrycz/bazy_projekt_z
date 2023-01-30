IF OBJECT_ID(N'najstarszyTrener') IS NOT NULL
DROP FUNCTION najstarszyTrener

CREATE FUNCTION dbo.najstarszyTrener()
RETURNS int
AS
BEGIN
RETURN 
	(SELECT TOP 1 Pracownik.ID_Pracownika FROM Pracownik
	WHERE Pracownik.DateOfBirth = (
		SELECT MIN(Pracownik.DateOfBirth) FROM Trener JOIN Pracownik 
		ON Trener.ID_Pracownika = Pracownik.ID_Pracownika
		)
	)
END;
GO

CREATE FUNCTION dbo.najczesciejKupowanyKarnet()
RETURNS int
AS
BEGIN
	DECLARE @wynik AS INT
    	SET @wynik = (
		SELECT TOP 1 COUNT(Klienci.Id_biletu) FROM Oferta JOIN Klienci
		ON Oferta.ID_oferty = Klienci.Id_biletu
		GROUP BY Oferta.ID_oferty
		ORDER BY COUNT(Klienci.Id_biletu) DESC
	)
    	RETURN @wynik;
END;
GO
SELECT dbo.najczesciejKupowanyKarne

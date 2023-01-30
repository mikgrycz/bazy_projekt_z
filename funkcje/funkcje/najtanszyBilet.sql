CREATE FUNCTION dbo.najtanszyKarnet()
RETURNS int
AS
BEGIN
    RETURN (SELECT MIN(Cena_Dynamiczna) FROM Oferta);
END;
GO
SELECT dbo.najtanszyKarnet();

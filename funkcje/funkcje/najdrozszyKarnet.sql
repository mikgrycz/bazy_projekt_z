CREATE FUNCTION dbo.najdrozszyKarnet()
RETURNS int
AS
BEGIN
    RETURN (SELECT MAX(Cena_Dynamiczna) FROM Oferta);
END;
GO
SELECT dbo.najdrozszyKarnet();

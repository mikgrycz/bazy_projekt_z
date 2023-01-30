IF OBJECT_ID(N'najdrozszyKarnet') IS NOT NULL
DROP FUNCTION najdrozszyKarnet

CREATE FUNCTION dbo.najdrozszyKarnet()
RETURNS INT
AS
BEGIN
    RETURN (SELECT MAX(Cena_Dynamiczna) FROM Oferta);
END;
GO
SELECT dbo.najdrozszyKarnet();

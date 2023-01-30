IF OBJECT_ID(N'podwyzka_sprzataczka') IS NOT NULL
DROP PROC podwyzka_sprzataczka
IF OBJECT_ID(N'podwyzka_ochrona') IS NOT NULL
DROP PROC podwyzka_ochrona

CREATE PROC podwyzka_sprzataczka @id NVARCHAR(50), @nowaWyplata INT
AS
	IF (NOT EXISTS
	(SELECT * FROM Sprzataczka WHERE Sprzataczka.ID_Pracownika = @id) OR
	(SELECT Sprzataczka.Wyplata_Godzinowa FROM Sprzataczka WHERE Sprzataczka.ID_Pracownika = @id) > @nowaWyplata)
		RETURN
	UPDATE Sprzataczka
	SET Sprzataczka.Wyplata_Godzinowa = @nowaWyplata + 1
	WHERE Sprzataczka.ID_Pracownika = @id
GO

CREATE PROC podwyzka_ochrona @id NVARCHAR(50), @nowaWyplata INT
AS
	IF (NOT EXISTS
	(SELECT * FROM Ochrona WHERE Ochrona.ID_Pracownika = @id) OR
	(SELECT Ochrona.Wyplata_Godzinowa FROM Ochrona WHERE Ochrona.ID_Pracownika = @id) > @nowaWyplata)
		RETURN
	UPDATE Ochrona
	SET Ochrona.Wyplata_Godzinowa = @nowaWyplata + 1
	WHERE Ochrona.ID_Pracownika = @id
GO

CREATE PROC podwyzka_sprzataczka @id NVARCHAR(50), @nowaWyplata INT
AS
	UPDATE Sprzataczka
	SET Sprzataczka.Wyplata_Godzinowa = @nowaWyplata
	WHERE Sprzataczka.ID_Pracownika = @id
GO

CREATE PROC podwyzka_ochrona @id NVARCHAR(50), @nowaWyplata INT
AS
	UPDATE Ochrona
	SET Ochrona.Wyplata_Godzinowa = @nowaWyplata
	WHERE Ochrona.ID_Pracownika = @id
GO

CREATE PROC aktualizuj_cene_karnetu @nazwa NVARCHAR(50), @nowaCena INT
AS
	UPDATE Oferta
	SET Oferta.Cena_Dynamiczna = @nowaCena
	WHERE Oferta.Nazwa = @nazwa
GO

EXEC aktualizuj_cene_karnetu @nazwa = 'studentSauna1', @nowaC

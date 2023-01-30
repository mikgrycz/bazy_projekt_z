IF OBJECT_ID(N'aktualizuj_cene_karnetu') IS NOT NULL
DROP PROC aktualizuj_cene_karnetu
CREATE PROC aktualizuj_cene_karnetu @nazwa NVARCHAR(50), @nowaCena INT
AS
	UPDATE Oferta
	SET Oferta.Cena_Dynamiczna = @nowaCena
	WHERE Oferta.Nazwa = @nazwa
GO

EXEC aktualizuj_cene_karnetu @nazwa = 'studentSauna1', @nowaCena = 123

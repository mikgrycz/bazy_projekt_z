IF OBJECT_ID(N'dodaj_pracownika') IS NOT NULL
DROP PROC dodaj_pracownika
IF OBJECT_ID(N'dodaj_trenera') IS NOT NULL
DROP PROC dodaj_trenera
IF OBJECT_ID(N'dodaj_sprzataczke') IS NOT NULL
DROP PROC dodaj_sprzataczke
IF OBJECT_ID(N'dodaj_ochroniarza') IS NOT NULL
DROP PROC dodaj_ochroniarza
CREATE PROCEDURE dbo.dodaj_pracownika @id int, @plac int, @imie nvarchar(255), @nazwisko nvarchar(255), @data int, @zawod nvarchar(255)
AS 
	INSERT INTO
	dbo.Pracownik VALUES  (@id, @plac, @imie, @nazwisko, @data, @zawod);
GO

 EXEC dbo.dodaj_pracownika @id = 1000, @plac = 2, @imie = 'Zbigniew', @nazwisko = 'Nowatorski', @data = 1969 , @zawod = 'Ochrona'

CREATE PROCEDURE dbo.dodaj_trenera @ID_Pracownika int, @Specjalizacja  VARCHAR(10),	@CenaZaGodzine Int
AS 
	INSERT INTO
	dbo.Trener VALUES  (@ID_Pracownika, @Specjalizacja, @CenaZaGodzine);
GO

CREATE PROCEDURE dbo.dodaj_sprzataczke @ID_Pracownika int, @LiczbaGodzin  VARCHAR(10),	@CenaZaGodzine Int
AS 
	INSERT INTO
	dbo.Sprzataczka VALUES  (@ID_Pracownika, @LiczbaGodzin, @CenaZaGodzine);
GO

CREATE PROCEDURE dbo.dodaj_Ochroniarza @ID_Pracownika int, @LiczbaGodzin  VARCHAR(10),	@CenaZaGodzine Int, @Srodki_Przymusu_Bezposredniego BIT,
				@Rozmiar_Biceps	Int
AS 
	INSERT INTO
	dbo.Ochrona VALUES  (@ID_Pracownika, @LiczbaGodzin, @CenaZaGodzine, @Srodki_Przymusu_Bezposredniego, @Rozmiar_Biceps);
GO

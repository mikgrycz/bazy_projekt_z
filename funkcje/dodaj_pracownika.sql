
CREATE PROCEDURE dbo.dodaj_pracownika @plac int, @imie nvarchar(255), @nazwisko nvarchar(255), @data Date, @zawod nvarchar(255)
AS 
	INSERT INTO
	dbo.Pracownik VALUES  (@plac, @imie, @nazwisko, @data, @zawod);
GO

 EXEC dbo.dodaj_pracownika @plac = 2, @imie = 'Zbigniew', @nazwisko = 'Nowatorski', @data = '1969-04-20' , @zawod = 'Ochrona'

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

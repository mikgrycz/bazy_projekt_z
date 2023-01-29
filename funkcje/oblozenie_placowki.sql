IF OBJECT_ID('oblozenie') IS NOT NULL
DROP PROC oblozenie
CREATE PROC oblozenie @idplacowki INT
AS
	DECLARE @wolne FLOAT;
	DECLARE @wszystkie FLOAT;
	SET @wolne = (SELECT COUNT(ID_szafki) FROM Szafki JOIN Placowka
	 ON Szafki.ID_Placowki = Placowka.ID_Placowki WHERE Szafki.Zajeta = 0)
	SET @wszystkie = (SELECT COUNT(ID_szafki) FROM Szafki JOIN Placowka
	 ON Szafki.ID_Placowki = Placowka.ID_Placowki)

	DECLARE @wynik FLOAT
	if @wszystkie = 0
	begin
		set @wynik = 0
	end
	else
		begin
	SET @wynik = @wolne / @wszystkie
	end
	set @wynik = @wynik * 100
	print @wynik
GO

EXEC dbo.oblozenie @idplacowki = 1


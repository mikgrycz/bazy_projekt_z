IF OBJECT_ID('czy_placowka_tu_istnieje') IS NOT NULL
DROP PROC czy_placowka_tu_istnieje
CREATE PROC dbo.czy_placowka_tu_istnieje @miasto varchar(255)
AS
	if exists (SELECT Placowka.City FROM Placowka WHERE Placowka.City LIKE @miasto) 
	begin
		print 'Oto nasze placowki w podanym miescie'
		SELECT * FROM Placowka WHERE Placowka.City LIKE @miasto
	end	
	if not exists(SELECT Placowka.City FROM Placowka WHERE Placowka.City LIKE @miasto)
	begin
		print 'Niestety w podanym miescie nie istnieje zadna nasza placowka'
	end
GO 

 EXEC dbo.czy_placowka_tu_istnieje @miasto = 'Springfield'

  EXEC dbo.czy_placowka_tu_istnieje @miasto = 'Warszawa'


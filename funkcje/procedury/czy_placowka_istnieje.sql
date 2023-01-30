IF OBJECT_ID('czy_placowka_tu_istnieje') IS NOT NULL
DROP PROC czy_placowka_tu_istnieje

CREATE PROC dbo.czy_placowka_tu_istnieje @miasto varchar(255)
AS
	IF EXISTS (SELECT Placowka.City FROM Placowka WHERE Placowka.City LIKE @miasto) 
	BEGIN
		PRINT 'Oto nasze placowki w podanym miescie'
		SELECT * FROM Placowka WHERE Placowka.City LIKE @miasto
	END	
	IF NOT EXISTS(SELECT Placowka.City FROM Placowka WHERE Placowka.City LIKE @miasto)
	BEGIN
		PRINT 'Niestety w podanym miescie nie istnieje zadna nasza placowka'
	END
GO 

 EXEC dbo.czy_placowka_tu_istnieje @miasto = 'Springfield'

  EXEC dbo.czy_placowka_tu_istnieje @miasto = 'Warszawa'


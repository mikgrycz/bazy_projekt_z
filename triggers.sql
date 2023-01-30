IF OBJECT_ID ('dbo.Opened_new_location') IS NOT NULL
	DROP TRIGGER Opened_new_location;

IF OBJECT_ID ('dbo.Make_Payment') IS NOT NULL
	DROP TRIGGER Make_Payment;

IF OBJECT_ID ('dbo.Register_fee') IS NOT NULL
	DROP TRIGGER Register_fee;

Go
CREATE TRIGGER Opened_new_location ON Placowka 
	AFTER INSERT
	AS
	BEGIN
	 UPDATE Dolar
	 Set Kurs = Kurs + 1
END

Go
CREATE TRIGGER Make_Payment ON Klienci
	AFTER Update 
	AS
	BEGIN 
		DECLARE @A int, @C int;

		SELECT @A = ID_klienta, @C = CAST(A.Cena_Dynamiczna * B.Kurs as int) FROM Inserted
			LEFT JOIN Oferta A ON ID_oferty = Id_biletu 
			LEFT JOIN Dolar B ON ID_Dolara = 1 

		INSERT INTO Przelew VALUES(@A,@C,getdate());
	END

GO


Go
CREATE TRIGGER Register_fee ON KLIENCI
	AFTER INSERT 
	AS
	BEGIN 
		DECLARE @A int, @C int;

		SELECT @A = ID_klienta, @C = 5 * B.Kurs FROM Inserted
			LEFT JOIN Dolar B ON ID_Dolara = 1 

		INSERT INTO Przelew VALUES(@A,@C,getdate());
	END

Go

CREATE TRIGGER trgPodwyzkaSprzataczka ON Sprzataczka
	AFTER UPDATE
	AS
	BEGIN
		UPDATE Sprzataczka
		SET Sprzataczka.Wyplata_Godzinowa = Sprzataczka.Wyplata_Godzinowa - 1
	END

CREATE TRIGGER trgPodwyzkaOchroniarz ON Ochrona
	AFTER UPDATE
	AS
	BEGIN
		UPDATE Ochrona
		SET Ochrona.Wyplata_Godzinowa = Ochrona.Wyplata_Godzinowa - 1
	END


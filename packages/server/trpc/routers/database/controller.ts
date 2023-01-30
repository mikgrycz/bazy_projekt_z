import { TRPCError } from "@trpc/server";
import { db } from "../../../utils";
import dotenv from "dotenv";

dotenv.config();

export const fetchWorkers = async () => {
    const Workers = await db.getall<IWorker>('SELECT * FROM Pracownik');
    const Trainers = await db.getall<ITrainers>(`
    SELECT P.*, T.Specjalizacja, T.CenaZaGodzine FROM Pracownik P
    INNER JOIN Trener T ON T.ID_Pracownika = P.ID_Pracownika;
    `);
    const Cleaners = await db.getall<ICleaner>(`
    SELECT P.*, S.Liczba_Godzin, S.Wyplata_Godzinowa FROM Pracownik P
    INNER JOIN Sprzataczka  S ON S.ID_Pracownika = P.ID_Pracownika;
    `);
    const Guards = await db.getall<IGuard>(`
    SELECT P.*, O.Liczba_Godzin, O.Wyplata_Godzinowa, O.Rozmiar_bicepsu, O.Srodki_Przymusu_Bezposredniego FROM Pracownik P
    INNER JOIN Ochrona O ON O.ID_Pracownika = P.ID_Pracownika;
    `);
    const Locs = await db.getall('SELECT ID_Placowki FROM Placowka');
    const locations = Locs.map((l) => { return l?.ID_Placowki as number })

    const sortedWorkers = Workers.sort((a, b) => {
        if (a.ID_Placowki === b.ID_Placowki) return a.ID_Pracownika > b.ID_Pracownika ? 1 : -1;
        return a.ID_Placowki > b.ID_Placowki ? 1 : -1;
    })
    const sortedTrainers = Trainers.sort((a, b) => {
        if (a.ID_Placowki === b.ID_Placowki) return a.ID_Pracownika > b.ID_Pracownika ? 1 : -1;
        return a.ID_Placowki > b.ID_Placowki ? 1 : -1;
    })
    const sortedCleaners = Cleaners.sort((a, b) => {
        if (a.ID_Placowki === b.ID_Placowki) return a.ID_Pracownika > b.ID_Pracownika ? 1 : -1;
        return a.ID_Placowki > b.ID_Placowki ? 1 : -1;
    })
    const sortedGuards = Guards.sort((a, b) => {
        if (a.ID_Placowki === b.ID_Placowki) return a.ID_Pracownika > b.ID_Pracownika ? 1 : -1;
        return a.ID_Placowki > b.ID_Placowki ? 1 : -1;
    })
    return {
        workers: sortedWorkers,
        trainers: sortedTrainers,
        cleaners: sortedCleaners,
        guards: sortedGuards,
        locations
    };
}

export const hireTrainer = async ({
    ID_Placowki,
    FirstName,
    LastName,
    Specjalizacja,
    DateOfBirth,
    CenaZaGodzine,
    ID_pracownika
}: {
    ID_pracownika: string,
    ID_Placowki: string,
    FirstName: string,
    LastName: string,
    Specjalizacja: Specialization,
    DateOfBirth: string,
    CenaZaGodzine: string
}) => {
    try {
        console.log('tworze klienta',
        `INSERT INTO Pracownik VALUES (${ID_pracownika},${ID_Placowki},'${FirstName}','${LastName}',${DateOfBirth},'Trener')`);
        const workerID = await db.insert(`INSERT INTO Pracownik VALUES (${ID_pracownika},${ID_Placowki},'${FirstName}','${LastName}',${DateOfBirth},'Trener')`)
        console.log('utworzylem klienta')
        await db.insert(`INSERT INTO Trener VALUES ('${ID_pracownika}','${Specjalizacja}','${CenaZaGodzine}')`);
        return {
            id: workerID,
            FirstName,
            LastName,
            Specjalizacja,
            DateOfBirth,
            CenaZaGodzine,
            ID_Placowki,
            Zawod: "Trener",
            message: "Dodano Pracownika"
        };
    } catch {
        (err: any) => {
            console.log(err)
            return new TRPCError({
                code: "INTERNAL_SERVER_ERROR",
                message: err
            })
        }
    }
}

export const hireGuard = async ({
    ID_Placowki,
    FirstName,
    LastName,
    Rozmiar_bicepsu,
    DateOfBirth,
    Liczba_Godzin,
    Wyplata_Godzinowa,
    Srodki_Przymusu_Bezposredniego
}: {
    ID_Placowki: string,
    FirstName: string,
    LastName: string,
    Rozmiar_bicepsu: string,
    DateOfBirth: string,
    Liczba_Godzin: string,
    Wyplata_Godzinowa: string,
    Srodki_Przymusu_Bezposredniego: boolean
}) => {
    try {
        const workerID = await db.insert(`INSERT INTO Pracownik VALUES (${ID_Placowki},'${FirstName}','${LastName}',${DateOfBirth},'Ochrona')`)
        await db.insert(`INSERT INTO Ochrona VALUES ('${workerID}','${Liczba_Godzin}','${Wyplata_Godzinowa}','${Srodki_Przymusu_Bezposredniego ? '1' : '0'}','${Rozmiar_bicepsu}')`);
        return {
            id: workerID,
            ID_Placowki,
            FirstName,
            LastName,
            Rozmiar_bicepsu,
            Liczba_Godzin,
            Wyplata_Godzinowa,
            Srodki_Przymusu_Bezposredniego,
            DateOfBirth,
            Zawod: "Ochrona",
            message: "Dodano Pracownika"
        };
    } catch {
        (err: any) => {
            return new TRPCError({
                code: "INTERNAL_SERVER_ERROR",
                message: err
            })
        }
    }
}

export const hireCleaner = async ({
    ID_Placowki,
    FirstName,
    LastName,
    Liczba_Godzin,
    Wyplata_Godzinowa,
    DateOfBirth,
}: {
    ID_Placowki: string,
    FirstName: string,
    LastName: string,
    Liczba_Godzin: string,
    Wyplata_Godzinowa: string,
    DateOfBirth: string
}) => {
    try {
        const workerID = await db.insert(`INSERT INTO Pracownik VALUES (${ID_Placowki},'${FirstName}','${LastName}',${DateOfBirth},'Sprzataczka')`)
        await db.insert(`INSERT INTO Sprzataczka VALUES ('${workerID}','${Liczba_Godzin}','${Wyplata_Godzinowa}')`);
        return {
            id: workerID,
            ID_Placowki,
            FirstName,
            LastName,
            Liczba_Godzin,
            Wyplata_Godzinowa,
            DateOfBirth,
            Zawod: "Sprzataczka",
            message: "Dodano Pracownika"
        };
    } catch {
        (err: any) => {
            return new TRPCError({
                code: "INTERNAL_SERVER_ERROR",
                message: err
            })
        }
    }
}

export const fireWorker = async ({
    ID,
    Zawod
}: {
    ID: string,
    Zawod: string,
}) => {
    try {
        await db.execute(`DELETE Pracownik WHERE ID_Pracownika = ${ID}`)
        return {
            ID,
            Zawod,
            message: "Usunieto Pracownika"
        };
    } catch {
        (err: any) => {
            return new TRPCError({
                code: "INTERNAL_SERVER_ERROR",
                message: err
            })
        }
    }
}

export const createBackup = async() => {
    const Time = new Date();
    return await db.execute(`BACKUP DATABASE ${process.env.database} TO DISK = '${process.env.backup_path}\\Backup-${Time.getSeconds()}-${Time.getMinutes()}-${Time.getHours()}-${Time.getDate()}-${Time.getMonth()+1}-${Time.getFullYear()}.bak';`);
}


interface IWorker {
    ID_Pracownika: string,
    ID_Placowki: string,
    Zawod: Job,
    FirstName: string,
    LastName: string,
    DateOfBirth: string
  }
  
  interface ITrainers extends IWorker {
    Specjalizacja: Specialization,
    CenaZaGodzine: string
  }
  
  interface ICleaner extends IWorker {
    Liczba_Godzin: string,
    Wyplata_Godzinowa: string,
  }
  
  interface IGuard extends IWorker {
    Liczba_Godzin: string,
    Wyplata_Godzinowa: string,
    Rozmiar_bicepsu: string,
    Srodki_Przymusu_Bezposredniego: boolean
  }
  
  type Job = "Trener" | "Sprzataczka" | "Ochrona";
  type Specialization = 'Aesthetics' | 'Legs' | 'Hands' | 'Chest' | 'Cardio' | 'StrongMan';
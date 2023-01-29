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
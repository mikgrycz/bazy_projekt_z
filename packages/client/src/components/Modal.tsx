import React, { useEffect, useState } from 'react'
import DatePicker from "react-datepicker";

import { trpc } from '../trpc'

import zustand from "../zustand";

import "react-datepicker/dist/react-datepicker.css";

type Job = "Trener" | "Sprzataczka" | "Ochrona";
type Specialization = 'Aesthetics' | 'Legs' | 'Hands' | 'Chest' | 'Cardio' | 'StrongMan';

export default function () {
    const [Zawod, setZawod] = useState<null | Job>(null);
    const [FirstName, setFirstName] = useState("")
    const [LastName, setLastName] = useState("")
    const [ID_Placowki, setID_Placowki] = useState<string | null>();
    const [DateOfBirth, setDateOfBirth] = useState('2000');


    const [Specjalizacja, setSpecjalizacja] = useState<null | Specialization>(null);
    const [CenaZaGodzine, setCenaZaGodzine] = useState('0');

    const [Wyplata_Godzinowa, setWyplata_Godzinowa] = useState('0');
    const [Liczba_Godzin, setLiczba_Godzin] = useState('0');
    const [Rozmiar_bicepsu, setRozmiar_bicepsu] = useState('0');
    const [Srodki_Przymusu_Bezposredniego, setSrodki_Przymusu_Bezposredniego] = useState(false);

    const store = zustand();

    const hireTrainer = trpc.database.hireTrainer.useMutation({
        onSuccess: (data) => {
            if (data.data)
                store.addTrainer({
                    ID_Pracownika: data.data.id.toString(),
                    CenaZaGodzine: data.data.CenaZaGodzine,
                    DateOfBirth: data.data.DateOfBirth,
                    FirstName: data.data.FirstName,
                    LastName: data.data.LastName,
                    ID_Placowki: data.data.ID_Placowki,
                    Specjalizacja: data.data.Specjalizacja,
                    Zawod: 'Trener',
                })
        }
    })

    const hireGuard = trpc.database.hireGuard.useMutation({
        onSuccess: (data) => {
            if (data.data)
                store.addGuard({
                    ID_Pracownika: data.data.id.toString(),
                    DateOfBirth: data.data.DateOfBirth,
                    FirstName: data.data.FirstName,
                    LastName: data.data.LastName,
                    ID_Placowki: data.data.ID_Placowki,
                    Zawod: 'Ochrona',
                    Liczba_Godzin: data.data.Liczba_Godzin,
                    Rozmiar_bicepsu: data.data.Rozmiar_bicepsu,
                    Srodki_Przymusu_Bezposredniego: data.data.Srodki_Przymusu_Bezposredniego,
                    Wyplata_Godzinowa: data.data.Wyplata_Godzinowa,
                })
        }
    })

    const hireCleaner = trpc.database.hireCleaner.useMutation({
        onSuccess: (data) => {
            if (data.data)
                store.addCleaner({
                    ID_Pracownika: data.data.id.toString(),
                    DateOfBirth: data.data.DateOfBirth,
                    FirstName: data.data.FirstName,
                    LastName: data.data.LastName,
                    ID_Placowki: data.data.ID_Placowki,
                    Zawod: 'Sprzataczka',
                    Wyplata_Godzinowa: data.data.Wyplata_Godzinowa,
                    Liczba_Godzin: data.data.Liczba_Godzin,
                })
        }
    })

    return (
        <div>
            <input type="checkbox" id="my-modal" className="modal-toggle" />
            <div className="modal">
                <div className="relative flex flex-col h-screen modal-box">
                    <span className='grow'>

                        <input type="text" placeholder="First Name" className="w-full input input-bordered " value={FirstName} onChange={(e) => setFirstName(e.currentTarget.value)} />
                        <input type="text" placeholder="Last Name" className="w-full my-2 input input-bordered " value={LastName} onChange={(e) => setLastName(e.currentTarget.value)} />

                        <span className='flex items-center justify-between'>
                            <input type="int" placeholder="Birth" className="w-full my-2 input input-bordered " value={DateOfBirth} onChange={(e) => setDateOfBirth(e.currentTarget.value)} />
                            <select className="select select-ghost" onChange={(e) => setID_Placowki(e.target.value)}>
                                <option disabled selected>Wybierz Placowke</option>
                                {
                                    store.locations.map((el) => {
                                        return (
                                            <option value={el}>
                                                {el}
                                            </option>
                                        )
                                    })
                                }
                            </select>

                        </span>

                        <select className="w-full mb-4 select select-ghost focus:outline-none" onChange={(e) => {
                            setZawod(e.target.value as Job)
                        }}>
                            <option disabled selected>Wybierz kogo Zatrudniasz</option>
                            <option value="Trener">Trener</option>
                            <option value="Sprzataczka">Sprzataczka</option>
                            <option value="Ochrona">Ochrona</option>
                        </select>

                        {
                            Zawod === "Trener" ? <div>
                                <select className="w-full select select-ghost focus:outline-none " onChange={(e) => setSpecjalizacja(e.target.value as Specialization)}>
                                    <option disabled selected>Specjalizacja</option>
                                    <option value="Aesthetics">Aesthetics</option>
                                    <option value="Legs">Legs</option>
                                    <option value="Hands">Arms</option>
                                    <option value="Chest">Chest</option>
                                    <option value="Cardio">Cardio</option>
                                    <option value="StrongMan">StrongMan</option>
                                </select>
                                <input type="number" placeholder="Cena za godzine w dolarach" className="w-full my-2 input input-bordered " value={CenaZaGodzine} onChange={(e) => setCenaZaGodzine(e.currentTarget.value)} />
                            </div> : ""
                        }
                        {
                            Zawod === "Sprzataczka" ? <div>
                                <input type="number" placeholder="Cena za godzine" className="w-full my-2 input input-bordered " value={Wyplata_Godzinowa} onChange={(e) => setWyplata_Godzinowa(e.currentTarget.value)} />
                                <input type="number" placeholder="Liczba godzin" className="w-full my-2 input input-bordered " value={Liczba_Godzin} onChange={(e) => setLiczba_Godzin(e.currentTarget.value)} />
                            </div> : ""
                        }
                        {
                            Zawod === "Ochrona" ? <div>
                                <input type="number" placeholder="Cena za godzine" className="w-full my-2 input input-bordered " value={Wyplata_Godzinowa} onChange={(e) => setWyplata_Godzinowa(e.currentTarget.value)} />
                                <input type="number" placeholder="Liczba godzin" className="w-full my-2 input input-bordered " value={Liczba_Godzin} onChange={(e) => setLiczba_Godzin(e.currentTarget.value)} />
                                <input type="number" placeholder="Rozmiar Bicepsa" className="w-full my-2 input input-bordered " value={Rozmiar_bicepsu} onChange={(e) => setRozmiar_bicepsu(e.currentTarget.value)} />
                                <div className="form-control">
                                    <label className="cursor-pointer label">
                                        <span className="label-text">Can use Force?</span>
                                        <input type="checkbox" className="checkbox checkbox-primary" checked={Srodki_Przymusu_Bezposredniego} onChange={e => setSrodki_Przymusu_Bezposredniego(e.currentTarget.checked)} />
                                    </label>
                                </div>
                            </div> : ""
                        }

                    </span>
                    {
                        Zawod ?
                            <button className='self-center btn btn-success' onClick={async (e) => {
                                if (Zawod === 'Trener') {
                                    if (!FirstName || !LastName || !ID_Placowki || !Specjalizacja || !CenaZaGodzine) return;
                                    hireTrainer.mutate({
                                        CenaZaGodzine,
                                        Specjalizacja,
                                        FirstName,
                                        LastName,
                                        ID_Placowki,
                                        DateOfBirth
                                    })
                                }
                                if (Zawod === 'Ochrona') {
                                    console.log('ochrona')
                                    if (!FirstName || !LastName || !ID_Placowki || !Wyplata_Godzinowa || !Liczba_Godzin || !Rozmiar_bicepsu || !Srodki_Przymusu_Bezposredniego) return;
                                    hireGuard.mutate({
                                        DateOfBirth,
                                        FirstName,
                                        ID_Placowki,
                                        LastName,
                                        Liczba_Godzin,
                                        Rozmiar_bicepsu,
                                        Srodki_Przymusu_Bezposredniego,
                                        Wyplata_Godzinowa
                                    })
                                }

                                if (Zawod === 'Sprzataczka') {
                                    if (!FirstName || !LastName || !ID_Placowki || !Wyplata_Godzinowa || !Liczba_Godzin) return;
                                    hireCleaner.mutate({
                                        Liczba_Godzin,
                                        Wyplata_Godzinowa,
                                        FirstName,
                                        LastName,
                                        ID_Placowki,
                                        DateOfBirth: DateOfBirth,
                                    })
                                }
                            }}>
                                Dodaj Pracownika
                            </button>
                            : ""
                    }
                    <label htmlFor="my-modal" className="absolute bottom-0 right-0 px-4 py-4">Close</label>

                </div>
            </div>
        </div >
    )
}

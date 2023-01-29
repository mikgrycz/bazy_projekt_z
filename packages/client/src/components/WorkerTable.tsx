import React, { useEffect, useState } from 'react'

import { trpc } from "../trpc";
import zustand from '../zustand';

export default function WorkerTabel({ select }: { select: number }) {
    const store = zustand();

    return (
        <table className="table w-full table-zebra">
            <thead>
                {
                    select === 0 ?
                        <tr className="font-medium text-gray-400">
                            <th>ID_Placowki</th>
                            <th>ID_Pracownika</th>
                            <th>First Name</th>
                            <th>Last Name</th>
                            <th>Job</th>
                            <th>Actions</th>
                        </tr> : ""
                }
                {
                    select === 1 ?
                        <tr>
                            <th>ID_Placowki</th>
                            <th>ID_Pracownika</th>
                            <th>First Name</th>
                            <th>Last Name</th>
                            <th>Godzinowka</th>
                            <th>Godziny</th>
                            <th>Biceps</th>
                            <th>Przymus Bezp.</th>
                            <th>Actions</th>
                        </tr> : ""
                }
                {
                    select === 2 ?
                        <tr>
                            <th>ID_Placowki</th>
                            <th>ID_Pracownika</th>
                            <th>First Name</th>
                            <th>Last Name</th>
                            <th>Godzinowka</th>
                            <th>Godziny</th>
                            <th>Actions</th>
                        </tr> : ""
                }
                {
                    select === 3 ?
                        <tr>
                            <th>ID_Placowki</th>
                            <th>ID_Pracownika</th>
                            <th>First Name</th>
                            <th>Last Name</th>
                            <th>Specjalizacja</th>
                            <th>Godzinowka</th>
                            <th>Actions</th>
                        </tr> : ""
                }
            </thead>
            <tbody>
                {
                    select === 0 ?
                        store.workers.map((el, i) => {
                            return (
                                <tr className={`${i % 2 ? "" : "bg-gray-700"}`} key={el.ID_Pracownika}>
                                    <td>{el.ID_Placowki}</td>
                                    <td>{el.ID_Pracownika}</td>
                                    <td>{el.FirstName}</td>
                                    <td>{el.LastName}</td>
                                    <td>{el.Zawod}</td>
                                    <td>
                                        <FireWorkerButton ID={el.ID_Pracownika} Zawod={el.Zawod} />
                                    </td>
                                </tr>
                            )
                        }) : ""
                }
                {
                    select === 1 ?
                        store.guards.map((el, i) => {
                            return (
                                <tr className={`${i % 2 ? "" : "bg-gray-700"}`} key={el.ID_Pracownika}>
                                    <td>{el.ID_Placowki}</td>
                                    <td>{el.ID_Pracownika}</td>
                                    <td>{el.FirstName}</td>
                                    <td>{el.LastName}</td>
                                    <td>{el.Wyplata_Godzinowa}</td>
                                    <td>{el.Liczba_Godzin}</td>
                                    <td>{el.Rozmiar_bicepsu}</td>
                                    <td>{el.Srodki_Przymusu_Bezposredniego ? "True" : "False"}</td>
                                    <td>
                                        <FireWorkerButton ID={el.ID_Pracownika} Zawod={el.Zawod} />
                                    </td>
                                </tr>
                            )
                        }) : ""
                }
                {
                    select === 2 ?
                        store.cleaners.map((el, i) => {
                            return (
                                <tr className={`${i % 2 ? "" : "bg-gray-700"}`} key={el.ID_Pracownika}>
                                    <td>{el.ID_Placowki}</td>
                                    <td>{el.ID_Pracownika}</td>
                                    <td>{el.FirstName}</td>
                                    <td>{el.LastName}</td>
                                    <td>{el.Wyplata_Godzinowa}</td>
                                    <td>{el.Liczba_Godzin}</td>

                                    <td>
                                        <FireWorkerButton ID={el.ID_Pracownika} Zawod={el.Zawod} />
                                    </td>
                                </tr>
                            )
                        }) : ""
                }
                {
                    select === 3 ?
                        store.trainers.map((el, i) => {
                            return (
                                <tr className={`${i % 2 ? "" : "bg-gray-700"}`} key={el.ID_Pracownika}>
                                    <td>{el.ID_Placowki}</td>
                                    <td>{el.ID_Pracownika}</td>
                                    <td>{el.FirstName}</td>
                                    <td>{el.LastName}</td>
                                    <td>{el.Specjalizacja}</td>
                                    <td>{el.CenaZaGodzine}</td>
                                    <td>
                                        <FireWorkerButton ID={el.ID_Pracownika} Zawod={el.Zawod} />
                                    </td>
                                </tr>
                            )
                        }) : ""
                }
            </tbody>
        </table>
    )
}

const FireWorkerButton = ({ ID, Zawod }: { ID: string, Zawod: string }) => {
    const store = zustand();

    const fireWorker = trpc.database.fireWorker.useMutation({
        onSuccess: (data) => {
            if (data.data) store.fireWorker(data.data.ID, data.data.Zawod)
        }
    });

    return (
        <button className='btn btn-error' onClick={async (e) => {
            fireWorker.mutate({ ID: ID.toString(), Zawod });
        }}>Delete</button>

    )
}
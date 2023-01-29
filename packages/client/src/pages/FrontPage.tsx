import React, { useState } from "react";


import Modal from "../components/Modal";
import WorkerTabel from "../components/WorkerTable";
import { trpc } from "../trpc";
import zustand from "../zustand";


const App = () => {
  const store = zustand();
  const { data } = trpc.database.init.useQuery({}, {
    onSuccess: (data) => {
      store.setCleaners(data.data.cleaners);
      store.setTrainers(data.data.trainers);
      store.setGuards(data.data.guards);
      store.setLocations(data.data.locations);
      store.setWorkers(data.data.workers);
    }
  })
  const createBackup = trpc.database.createBackup.useMutation();
  const [select, setSelect] = useState(0);

  return (
    <div className="flex flex-col h-screen px-32 py-8 text-white">
      <Modal />
      <div className="flex items-center justify-center">
        <ul className="flex py-12">
          {['Pracownik', 'Ochroniarz', 'Sprzataczka', 'Trener'].map((el, index) =>
            <li
              key={`Cathegory-${index}`}
              onClick={() => {
                setSelect(index)
              }}>
              <span className={`text-xl px-2 py-1 font-bold ${select === index ? "text-gray-400" : ""}`}>
                {el}
              </span>
            </li>
          )}
        </ul>
        <label htmlFor="my-modal" className="mx-2 btn">Add Worker</label>
        <button className="btn btn-success" onClick={() => {
          createBackup.mutate();
        }}>
          Create Backup
        </button>
      </div>
      <WorkerTabel select={select} />

    </div>
  )
}

export default App;

import create from 'zustand'

const store = create<IWorkerStore>()(
    (set,get) => ({
        locations: [],
        workers:[],
        guards:[],
        cleaners:[],
        trainers: [],

        setLocations: (data) => {
            set((state) => ({
                ...state,
                locations:data
            }))
        },
        setWorkers: (data) => {
            set((state) => ({
                ...state,
                workers: data
            }))
        },
        setGuards: (data) => {
            set((state) => ({
                ...state,
                guards: data
            }))
        },
        setCleaners: (data) => {
            set((state) => ({
                ...state,
                cleaners: data
            }))
        },
        setTrainers: (data) => {
            set((state) => ({
                ...state,
                trainers: data
            }))
        },

        fireWorker: (id,type) => {
            const workers = get().workers.filter((person) => person.ID_Pracownika != id);
            if(type === 'Ochrona') {
                const guards = get().guards.filter((person) => person.ID_Pracownika != id);
                set((state) => ({
                    ...state,
                    workers,
                    guards
                }))
            }
            if(type === 'Trener') {
                const trainers = get().trainers.filter((person) => person.ID_Pracownika != id);
                set((state) => ({
                    ...state,
                    workers,
                    trainers
                }))
            }
            if(type === 'Sprzataczka') {
                const cleaners = get().cleaners.filter((person) => person.ID_Pracownika != id);
                set((state) => ({
                    ...state,
                    workers,
                    cleaners
                }))
            }
        },

        addTrainer: (person) => {
            const workers = get().workers;
            const trainers = get().trainers;
            set((state) => ({
                ...state,
                workers: [...workers, {
                    ID_Pracownika: person.ID_Pracownika,
                    ID_Placowki: person.ID_Placowki,
                    FirstName: person.FirstName,
                    LastName: person.LastName,
                    DateOfBirth: person.DateOfBirth,
                    Zawod: "Trener"
                }],
                trainers: [...trainers, person]
            }))
        },
        addCleaner: (person) => {
            const workers = get().workers;
            const cleaners = get().cleaners;
            set((state) => ({
                ...state,
                workers: [...workers, {
                    ID_Pracownika: person.ID_Pracownika,
                    ID_Placowki: person.ID_Placowki,
                    FirstName: person.FirstName,
                    LastName: person.LastName,
                    DateOfBirth: person.DateOfBirth,
                    Zawod: "Sprzataczka"
                }],
                cleaners: [...cleaners, person]
            }))
        },
        addGuard: (person) => {
            const workers = get().workers;
            const guards = get().guards;
            set((state) => ({
                ...state,
                workers: [...workers, {
                    ID_Pracownika: person.ID_Pracownika,
                    ID_Placowki: person.ID_Placowki,
                    FirstName: person.FirstName,
                    LastName: person.LastName,
                    DateOfBirth: person.DateOfBirth,
                    Zawod: "Ochrona"
                }],
                guards: [...guards, person]
            }))
        }
    })
)

export interface IWorkerStore {
    locations: number[],
    workers: IWorker[],
    guards: IGuard[],
    cleaners: ICleaner[],
    trainers: ITrainers[],
    
    setLocations: (data: number[]) => void,
    setWorkers: (data: IWorker[]) => void,
    setGuards: (data: IGuard[]) => void,
    setCleaners: (data: ICleaner[]) => void,
    setTrainers: (data: ITrainers[]) => void,

    fireWorker: (id: string,type: string) => void,

    addTrainer: (data: ITrainers) => void,
    addCleaner: (data: ICleaner) => void,
    addGuard: (data: IGuard) => void,
}


export default store;
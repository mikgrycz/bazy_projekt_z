import { initTRPC } from "@trpc/server";
import { z } from "zod";
import { createBackup, fetchWorkers, fireWorker, hireCleaner, hireGuard, hireTrainer } from "./controller"

const t = initTRPC.create();

const databaseRouter = t.router({
    init: t.procedure
        .input(z.object({}))
        .query(async ({}) => {
            const init = await fetchWorkers();
            return {
                status: 'success',
                data: init
            }
        }),

    hireTrainer: t.procedure
        .input(
            z.object({
                FirstName: z.string(),
                LastName: z.string(),
                Specjalizacja: z.string(),
                CenaZaGodzine: z.string(),
                DateOfBirth: z.string(),
                ID_Placowki: z.string()
            })
        )
        .mutation(async ({ input }) => {
            const trainer = await hireTrainer({
                ID_pracownika:'600',
                CenaZaGodzine: input.CenaZaGodzine,
                ID_Placowki: input.ID_Placowki,
                FirstName: input.FirstName,
                LastName: input.LastName,
                Specjalizacja: input.Specjalizacja as Specialization,
                DateOfBirth: input.DateOfBirth
            })
            return {
                status:'success',
                data: trainer
            }
        }),

    hireGuard: t.procedure
        .input(
            z.object({
                FirstName: z.string(),
                LastName: z.string(),
                DateOfBirth: z.string(),
                ID_Placowki: z.string(),
                Liczba_Godzin: z.string(),
                Wyplata_Godzinowa: z.string(),
                Rozmiar_bicepsu: z.string(),
                Srodki_Przymusu_Bezposredniego: z.boolean()
            })
        )
        .mutation(async ({ input }) => {
            const guard = await hireGuard({
                ID_Placowki: input.ID_Placowki,
                FirstName: input.FirstName,
                LastName: input.LastName,
                DateOfBirth: input.DateOfBirth,
                Liczba_Godzin: input.Liczba_Godzin,
                Wyplata_Godzinowa: input.Wyplata_Godzinowa,
                Rozmiar_bicepsu: input.Rozmiar_bicepsu,
                Srodki_Przymusu_Bezposredniego: input.Srodki_Przymusu_Bezposredniego
            })
            return {
                status:'success',
                data: guard
            }
        }),

    hireCleaner: t.procedure
        .input(
            z.object({
                FirstName: z.string(),
                LastName: z.string(),
                DateOfBirth: z.string(),
                ID_Placowki: z.string(),
                Liczba_Godzin: z.string(),
                Wyplata_Godzinowa: z.string(),
            })
        )
        .mutation(async ({ input }) => {
            const cleaner = await hireCleaner({
                ID_Placowki: input.ID_Placowki,
                FirstName: input.FirstName,
                LastName: input.LastName,
                DateOfBirth: input.DateOfBirth,
                Liczba_Godzin: input.Liczba_Godzin,
                Wyplata_Godzinowa: input.Wyplata_Godzinowa
            })
            return {
                status:'success',
                data: cleaner
            }
        }),

    fireWorker: t.procedure
        .input(z.object({
            ID:  z.string(),
            Zawod: z.string(),
        }))
        .mutation(async ({ input }) => {
            const data = await fireWorker({ ID:input.ID, Zawod:input.Zawod })
            return {
                status:'success',
                data: data
            }
        }),
    createBackup: t.procedure
        .mutation(async ({ }) => {
            await createBackup();
            return ({
                status:'success',
                data: "Created Backup"
            })
        })
});

export default databaseRouter;
type Specialization = 'Aesthetics' | 'Legs' | 'Hands' | 'Chest' | 'Cardio' | 'StrongMan';
import { inferAsyncReturnType, initTRPC } from '@trpc/server';
import * as trpcExpress from '@trpc/server/adapters/express';
import databaseRouter from './routers/database';

export const createContext = ({
    req,
    res,
  }: trpcExpress.CreateExpressContextOptions) => ({}); 

export type Context = inferAsyncReturnType<typeof createContext>;

export const t = initTRPC.context<Context>().create();

const appRouter = t.router({
    database: databaseRouter,
});

export default appRouter;
// export type definition of API
export type AppRouter = typeof appRouter;
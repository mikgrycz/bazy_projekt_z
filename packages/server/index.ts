import cors from "cors";
import express from "express";
import * as trpcExpress from '@trpc/server/adapters/express';
import appRouter, { createContext } from "./trpc/trpc";

const app = express();
const port = 8080;

app.use(cors({
  origin: [true, "http://localhost:3000"],
  credentials: true,
  methods: ['POST', "GET", "DELETE", "MODIFY"]
}));

app.get("/", (req, res) => {
  res.send("Hello from server");
});

app.listen(port, () => {
  console.log(`server listening at http://localhost:${port}`);
});

app.use(
  '/trpc',
  trpcExpress.createExpressMiddleware({
    router: appRouter,
    createContext,
  }),
);
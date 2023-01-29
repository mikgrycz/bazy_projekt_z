import Db from 'mssql-async';
import dotenv from "dotenv";

dotenv.config();


export const db = new Db({
    database: process.env.database as string,
    server: process.env.server as string,
    password: process.env.password as string,
    user: process.env.user as string,
    options: {
        trustServerCertificate: true,
    }
})

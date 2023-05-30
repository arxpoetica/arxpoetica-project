import postgres from 'postgres'
import { drizzle } from 'drizzle-orm/postgres-js'


const client = postgres(connection_string)
const db = drizzle(client, { logger: false })

// import { users } from './schema'
// const allUsers = await db.select().from(users)

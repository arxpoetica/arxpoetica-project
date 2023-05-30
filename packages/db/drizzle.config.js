import { get_db_connection_string } from './utils.js'

/** @type { import("drizzle-kit").Config } */
export default {
	schema: './src/schema.ts',
	out: './drizzle',
	connectionString: get_db_connection_string(),
}

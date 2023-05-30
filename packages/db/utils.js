const { PGHOST, PGPORT, PGDATABASE, PGUSER, PGPASSWORD, ENDPOINT_ID } = process.env

export const get_db_connection_string = () => {
	let url = `postgres://${PGUSER}:${PGPASSWORD}@${PGHOST}`
	if (PGPORT) { url += `:${PGPORT}` }
	url += `/${PGDATABASE}`
	if (ENDPOINT_ID) { url += `?options=project%3D${ENDPOINT_ID}` }
	return url
}

const sql = require('mssql')
require('dotenv').config()

const config = {
  user: process.env.DB_USER || 'sa',
  password: process.env.DB_PASSWORD || 'your_password',
  server: process.env.DB_SERVER || 'localhost',
  database: process.env.DB_NAME || 'VNCultureBridge',
  options: {
    encrypt: true,
    trustServerCertificate: true,
    instanceName: process.env.DB_INSTANCE || 'SQLEXPRESS'
  },
}

const poolPromise = new sql.ConnectionPool(config)
  .connect()
  .then((pool) => {
    console.log('Connected to SQL Server')
    return pool
  })
  .catch((err) => console.log('Database Connection Failed! Bad Config: ', err))

async function query(queryString, params = []) {
  try {
    const pool = await poolPromise
    const request = pool.request()

    if (params) {
      if (Array.isArray(params)) {
        params.forEach((param, index) => {
          request.input(`p${index}`, param.value)
        })
      } else {
        Object.keys(params).forEach((key) => {
          request.input(key, params[key])
        })
      }
    }

    const result = await request.query(queryString)
    return result.recordset
  } catch (err) {
    console.error('SQL error', err)
    throw err
  }
}

module.exports = {
  sql,
  poolPromise,
  query,
}

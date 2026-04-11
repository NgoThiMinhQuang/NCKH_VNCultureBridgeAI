let mssql
let poolPromise

function getMssqlDriver() {
  if (mssql) return mssql

  try {
    mssql = isWindowsAuth()
      ? require('mssql/msnodesqlv8')
      : require('mssql')

    return mssql
  } catch (error) {
    if (isWindowsAuth() && error.code === 'ERR_DLOPEN_FAILED') {
      throw new Error(
        'Windows Authentication hiện đang dùng msnodesqlv8 nhưng package này không tương thích với Node.js hiện tại. Hãy dùng Node 20 LTS hoặc chuyển DB_WINDOWS_AUTH=false để dùng SQL account.'
      )
    }

    throw error
  }
}

function isWindowsAuth() {
  return String(process.env.DB_WINDOWS_AUTH || 'false') === 'true'
}

function escapeSqlString(value) {
  return String(value).replace(/'/g, "''")
}

function toSqlLiteral(value) {
  if (value === null || value === undefined) return 'NULL'
  if (typeof value === 'number') return String(value)
  if (typeof value === 'boolean') return value ? '1' : '0'
  return `N'${escapeSqlString(value)}'`
}

function buildDeclarations(bindings = {}) {
  return Object.entries(bindings)
    .map(([key, value]) => `DECLARE @${key} NVARCHAR(MAX) = ${toSqlLiteral(value)};`)
    .join('\n')
}

function getMssqlConfig() {
  const rawServer = process.env.DB_SERVER || 'localhost'
  const useWindowsAuth = isWindowsAuth()
  const database = process.env.DB_NAME || 'VNCultureBridgeAI'
  const encrypt = String(process.env.DB_ENCRYPT || 'false') === 'true'
  const trustServerCertificate = String(process.env.DB_TRUST_CERT || 'true') === 'true'

  return {
    server: rawServer,
    port: useWindowsAuth ? undefined : Number(process.env.DB_PORT || 1433),
    user: useWindowsAuth ? undefined : process.env.DB_USER,
    password: useWindowsAuth ? undefined : process.env.DB_PASSWORD,
    database,
    driver: useWindowsAuth ? 'msnodesqlv8' : undefined,
    connectionString: useWindowsAuth
      ? `Driver={ODBC Driver 17 for SQL Server};Server=${rawServer};Database=${database};Trusted_Connection=Yes;Encrypt=${encrypt ? 'Yes' : 'No'};TrustServerCertificate=${trustServerCertificate ? 'Yes' : 'No'};`
      : undefined,
    options: {
      encrypt,
      trustServerCertificate,
      trustedConnection: useWindowsAuth,
    },
    pool: {
      max: 10,
      min: 0,
      idleTimeoutMillis: 30000,
    },
  }
}

function getPool() {
  if (!poolPromise) {
    const driver = getMssqlDriver()
    poolPromise = driver.connect(getMssqlConfig())
      .catch((error) => {
        poolPromise = undefined
        throw error
      })
  }

  return poolPromise
}

async function queryWithMssql(statement, bindings = {}) {
  const pool = await getPool()
  const request = pool.request()

  for (const [key, value] of Object.entries(bindings)) {
    request.input(key, value)
  }

  const result = await request.query(statement)
  return result.recordset
}

async function query(statement, bindings = {}) {
  return queryWithMssql(statement, bindings)
}

async function testConnection() {
  const rows = await query('SELECT DB_NAME() AS databaseName')
  return rows[0] || { databaseName: null }
}

module.exports = {
  getPool,
  query,
  testConnection,
}

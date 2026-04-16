const path = require('path')
require('dotenv').config({ path: path.join(__dirname, '..', '.env') })

let mssql
let poolPromise

function getMssqlDriver() {
  if (mssql) return mssql

  try {
    const useWindowsAuth = isWindowsAuth()
    mssql = useWindowsAuth
      ? require('mssql/msnodesqlv8')
      : require('mssql')

    console.log(`[DB] Using ${useWindowsAuth ? 'msnodesqlv8 (Windows Auth)' : 'tedious (SQL Auth)'} driver`)
    return mssql
  } catch (error) {
    console.error('[DB] Driver load error:', error.message)
    if (isWindowsAuth() && error.code === 'ERR_DLOPEN_FAILED') {
      throw new Error(
        'Windows Authentication hiện đang dùng msnodesqlv8 nhưng package này không tương thích với Node.js hiện tại. Hãy dùng Node 20 LTS hoặc chuyển DB_WINDOWS_AUTH=false để dùng SQL account.'
      )
    }

    throw error
  }
}

function isWindowsAuth() {
  const val = String(process.env.DB_WINDOWS_AUTH || 'false').toLowerCase()
  return val === 'true' || val === '1' || val === 'yes'
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

function getMssqlConfig() {
  const rawServer = process.env.DB_SERVER || 'localhost'
  const useWindowsAuth = isWindowsAuth()
  const database = process.env.DB_NAME || 'VNCultureBridgeAI'
  const encrypt = String(process.env.DB_ENCRYPT || 'false') === 'true'
  const trustServerCertificate = String(process.env.DB_TRUST_CERT || 'true') === 'true'

  // Handle named instances like 'HOST\SQLEXPRESS'
  let server = rawServer
  let instanceName = process.env.DB_INSTANCE
  
  if (rawServer.includes('\\')) {
    const parts = rawServer.split('\\')
    server = parts[0]
    instanceName = parts[1]
  }

  const config = {
    server: server === 'localhost' ? '127.0.0.1' : server,
    port: useWindowsAuth ? undefined : Number(process.env.DB_PORT || 1433),
    user: useWindowsAuth ? undefined : process.env.DB_USER,
    password: useWindowsAuth ? undefined : process.env.DB_PASSWORD,
    database,
    options: {
      encrypt,
      trustServerCertificate,
      instanceName,
      trustedConnection: useWindowsAuth,
    },
    pool: {
      max: 10,
      min: 0,
      idleTimeoutMillis: 30000,
    },
  }

  // If using msnodesqlv8, we need to specify the driver explicitly for reliability
  if (useWindowsAuth) {
    const driverName = process.env.DB_DRIVER || 'ODBC Driver 17 for SQL Server'
    // Format connection string for named instances with Windows Auth
    const serverPart = server + (instanceName ? `\\${instanceName}` : '')
    const connStr = `Server=${serverPart};Database=${database};Trusted_Connection=Yes;Driver={${driverName}};`
    
    console.log(`[DB] Using Windows Auth connection string: ${connStr}`)
    
    return {
      connectionString: connStr,
      driver: driverName,
      options: {
        trustedConnection: true,
        instanceName: undefined // Let connection string handle it
      },
      pool: config.pool
    }
  }

  // Print redacted config for debugging (for SQL Auth)
  console.log('[DB] Connecting with SQL Auth config:', {
    server: config.server,
    instanceName: config.options.instanceName,
    database: config.database,
    useWindowsAuth
  })

  return config
}

function getPool() {
  if (!poolPromise) {
    const driver = getMssqlDriver()
    const config = getMssqlConfig()
    
    poolPromise = driver.connect(config)
      .then(pool => {
        console.log('[DB] SQL Server Connected Successfully')
        return pool
      })
      .catch((error) => {
        console.error('[DB] Connection Error:', error)
        if (error.code) console.error('[DB] Error Code:', error.code)
        poolPromise = undefined
        throw error
      })
  }

  return poolPromise
}

async function query(statement, bindings = {}) {
  try {
    const pool = await getPool()
    const request = pool.request()

    for (const [key, value] of Object.entries(bindings)) {
      request.input(key, value)
    }

    const result = await request.query(statement)
    return result.recordset
  } catch (err) {
    console.error('[DB] Query Error:', err.message)
    throw err
  }
}

async function testConnection() {
  try {
    const dbInfo = await query('SELECT DB_NAME() AS databaseName, @@VERSION as version')
    
    // Check if some key tables exist
    const tables = await query("SELECT table_name FROM information_schema.tables WHERE table_name IN ('DanToc', 'VanHoa', 'AmThuc')")
    
    return { 
      connected: true,
      databaseName: dbInfo[0].databaseName,
      version: dbInfo[0].version,
      tablesFound: tables.map(t => t.table_name)
    }
  } catch (error) {
    console.error('[DB] Test Connection Failed:', error.message)
    return { connected: false, error: error.message }
  }
}

module.exports = {
  getPool,
  query,
  testConnection,
}

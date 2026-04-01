const { execFile } = require('child_process')
const { promisify } = require('util')
const mssql = require('mssql')

const execFileAsync = promisify(execFile)
let poolPromise

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

async function queryWithSqlCmd(statement, bindings = {}) {
  const declarations = buildDeclarations(bindings)
  const wrappedQuery = `SET NOCOUNT ON;\n${declarations}\n${statement}`

  const server = (process.env.DB_SERVER || 'localhost').replace(/'/g, "''")
  const database = (process.env.DB_NAME || 'VNCultureBridgeAI').replace(/'/g, "''")

  const buildScript = (useTrustCert) => `
    $ErrorActionPreference = 'Stop'
    Import-Module SqlServer -ErrorAction SilentlyContinue
    
    [Console]::OutputEncoding = [System.Text.Encoding]::UTF8
    $OutputEncoding = [System.Text.Encoding]::UTF8

    $rows = Invoke-Sqlcmd -ServerInstance '${server}' -Database '${database}' ${useTrustCert ? '-TrustServerCertificate' : ''} -Query @'
${wrappedQuery}
'@

    $normalized = @(
      $rows | Select-Object * -ExcludeProperty RowError, RowState, Table, ItemArray, HasErrors
    )

    $normalized | ConvertTo-Json -Compress -Depth 10
  `

  const run = async (script) => {
    return execFileAsync(
      'powershell',
      [
        '-ExecutionPolicy', 'Bypass', // 🔥 luôn bật để tránh bị block
        '-NoProfile',
        '-Command',
        script
      ],
      {
        windowsHide: true,
        maxBuffer: 10 * 1024 * 1024,
      }
    )
  }

  let stdout = ''

  try {
    // 🟢 Thử không dùng TrustCert trước
    const res = await run(buildScript(false))
    stdout = res.stdout
  } catch (err) {
    // 🔴 Nếu lỗi → thử lại với TrustCert
    const res = await run(buildScript(true))
    stdout = res.stdout
  }

  const output = stdout.trim()

  if (!output) return []

  try {
    const parsed = JSON.parse(output)
    return Array.isArray(parsed) ? parsed : [parsed]
  } catch (e) {
    console.error('❌ Parse JSON lỗi từ PowerShell:', output)
    throw e
  }
}

function getMssqlConfig() {
  const rawServer = process.env.DB_SERVER || 'localhost'
  const [server, instanceName] = rawServer.split('\\')

  return {
    server,
    port: instanceName ? undefined : Number(process.env.DB_PORT || 1433),
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME || 'VNCultureBridgeAI',
    options: {
      encrypt: String(process.env.DB_ENCRYPT || 'false') === 'true',
      trustServerCertificate: String(process.env.DB_TRUST_CERT || 'true') === 'true',
      instanceName,
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
    poolPromise = mssql.connect(getMssqlConfig())
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
  if (isWindowsAuth()) {
    return queryWithSqlCmd(statement, bindings)
  }

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

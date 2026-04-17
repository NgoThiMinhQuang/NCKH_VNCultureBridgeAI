const fs = require('fs')
const path = require('path')
const db = require('./db/sql')

async function resetDb() {
  try {
    console.log('--- Starting Database Reset ---')
    
    const fullScriptPath = path.join(__dirname, 'db', 'vn_culture_bridge_data.sql')
    
    const fullSql = fs.readFileSync(fullScriptPath, 'utf8')
    
    console.log('Executing vn_culture_bridge_data.sql (Full DB Build)...')
    await db.query(fullSql)
    
    console.log('Database reset SUCCESSFUL!')
    process.exit(0)
  } catch (error) {
    console.error('Database reset FAILED:', error)
    process.exit(1)
  }
}

resetDb()

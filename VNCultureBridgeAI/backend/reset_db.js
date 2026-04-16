const fs = require('fs')
const path = require('path')
const db = require('./db/sql')

async function resetDb() {
  try {
    console.log('--- Starting Database Reset ---')
    
    const schemaPath = path.join(__dirname, 'db', 'schema.sql')
    const seedsPath = path.join(__dirname, 'db', 'seeds.sql')
    
    const schemaSql = fs.readFileSync(schemaPath, 'utf8')
    const seedsSql = fs.readFileSync(seedsPath, 'utf8')
    
    console.log('Executing schema.sql...')
    await db.query(schemaSql)
    
    console.log('Executing seeds.sql...')
    await db.query(seedsSql)
    
    console.log('Database reset SUCCESSFUL!')
    process.exit(0)
  } catch (error) {
    console.error('Database reset FAILED:', error)
    process.exit(1)
  }
}

resetDb()

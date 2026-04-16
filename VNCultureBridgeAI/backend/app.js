const path = require('path')
const express = require('express')
const cors = require('cors')
require('dotenv').config({ path: path.join(__dirname, '.env') })

const homepageRoutes = require('./routes/homepage.routes')
const contentRoutes = require('./routes/content.routes')
const authRoutes = require('./routes/auth.routes')
const { testConnection } = require('./db/sql')

const app = express()
const PORT = Number(process.env.PORT || 3001)

app.use(cors())
app.use(express.json())

app.get('/api/health', async (req, res) => {
  try {
    const db = await testConnection()

    res.json({
      ok: true,
      service: 'vnculturebridge-backend-v2',
      db,
      timestamp: new Date().toISOString(),
    })
  } catch (error) {
    res.status(500).json({
      ok: false,
      service: 'vnculturebridge-backend',
      error: error.message,
      timestamp: new Date().toISOString(),
    })
  }
})

app.use('/api/homepage', homepageRoutes)
app.use('/api/auth', authRoutes)
app.use('/api', contentRoutes)

app.use((error, req, res, next) => {
  console.error(error)

  res.status(error.status || 500).json({
    ok: false,
    message: error.message || 'Internal server error',
  })
})

app.listen(PORT, () => {
  console.log(`VNCultureBridge backend listening on port ${PORT}`)
})

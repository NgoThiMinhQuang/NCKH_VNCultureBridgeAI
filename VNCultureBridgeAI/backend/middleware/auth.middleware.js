const jwt = require('jsonwebtoken')

function authMiddleware(req, res, next) {
  const authHeader = req.headers.authorization
  const secret = process.env.JWT_SECRET || 'vnculturebridge-dev-secret'

  if (!authHeader || !authHeader.startsWith('Bearer ')) {
    return res.status(401).json({ ok: false, message: 'Unauthorized: No token provided' })
  }

  const token = authHeader.split(' ')[1]

  try {
    const decoded = jwt.verify(token, secret)
    req.user = decoded
    next()
  } catch (error) {
    return res.status(401).json({ ok: false, message: 'Unauthorized: Invalid token' })
  }
}

function adminMiddleware(req, res, next) {
  authMiddleware(req, res, (err) => {
    if (err) return next(err)

    if (req.user && (req.user.role === 'ADMIN' || req.user.role === 'STAFF')) {
      next()
    } else {
      res.status(403).json({ ok: false, message: 'Forbidden: Admin access required' })
    }
  })
}

module.exports = {
  authMiddleware,
  adminMiddleware,
}

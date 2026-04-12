const authService = require('../services/auth.service')

async function register(req, res, next) {
  try {
    const data = await authService.register({
      fullName: req.body.fullName,
      email: req.body.email,
      password: req.body.password,
    })

    res.status(201).json({ ok: true, data })
  } catch (error) {
    next(error)
  }
}

async function login(req, res, next) {
  try {
    const data = await authService.login({
      email: req.body.email,
      password: req.body.password,
    })

    res.json({ ok: true, data })
  } catch (error) {
    next(error)
  }
}

module.exports = {
  register,
  login,
}

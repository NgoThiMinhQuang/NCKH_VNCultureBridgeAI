const homepageService = require('../services/homepage.service')
const { normalizeLang } = require('../utils/locale')

async function getHomepage(req, res, next) {
  try {
    const lang = normalizeLang(req.query.lang)
    const homepage = await homepageService.getHomepage(lang)
    res.json({ ok: true, data: homepage })
  } catch (error) {
    next(error)
  }
}

module.exports = {
  getHomepage,
}

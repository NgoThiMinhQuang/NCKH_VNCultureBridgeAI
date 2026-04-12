const contentService = require('../services/content.service')
const { normalizeLang } = require('../utils/locale')

async function listArticles(req, res, next) {
  try {
    const lang = normalizeLang(req.query.lang)
    const data = await contentService.listArticles(req.query, lang)
    res.json({ ok: true, data })
  } catch (error) {
    next(error)
  }
}

async function getArticle(req, res, next) {
  try {
    const lang = normalizeLang(req.query.lang)
    const data = await contentService.getArticle(req.params.code, lang)

    if (!data) {
      return res.status(404).json({ ok: false, message: 'Article not found' })
    }

    return res.json({ ok: true, data })
  } catch (error) {
    next(error)
  }
}

async function listRegions(req, res, next) {
  try {
    const lang = normalizeLang(req.query.lang)
    const data = await contentService.listRegions(lang)
    res.json({ ok: true, data })
  } catch (error) {
    next(error)
  }
}

async function getRegion(req, res, next) {
  try {
    const lang = normalizeLang(req.query.lang)
    const data = await contentService.getRegion(req.params.code, lang)

    if (!data) {
      return res.status(404).json({ ok: false, message: 'Region not found' })
    }

    return res.json({ ok: true, data })
  } catch (error) {
    next(error)
  }
}

async function listProvinces(req, res, next) {
  try {
    const lang = normalizeLang(req.query.lang)
    const data = await contentService.listProvinces(req.query, lang)
    res.json({ ok: true, data })
  } catch (error) {
    next(error)
  }
}

async function getProvince(req, res, next) {
  try {
    const lang = normalizeLang(req.query.lang)
    const data = await contentService.getProvince(req.params.code, lang)

    if (!data) {
      return res.status(404).json({ ok: false, message: 'Province not found' })
    }

    return res.json({ ok: true, data })
  } catch (error) {
    next(error)
  }
}

async function listFestivals(req, res, next) {
  try {
    const lang = normalizeLang(req.query.lang)
    const data = await contentService.listFestivals(lang)
    res.json({ ok: true, data })
  } catch (error) {
    next(error)
  }
}

async function getFestival(req, res, next) {
  try {
    const lang = normalizeLang(req.query.lang)
    const data = await contentService.getFestival(req.params.id, lang)

    if (!data) {
      return res.status(404).json({ ok: false, message: 'Festival not found' })
    }

    return res.json({ ok: true, data })
  } catch (error) {
    next(error)
  }
}

async function listCuisines(req, res, next) {
  try {
    const lang = normalizeLang(req.query.lang)
    const data = await contentService.listCuisines(req.query, lang)
    res.json({ ok: true, data })
  } catch (error) {
    next(error)
  }
}

async function getCuisine(req, res, next) {
  try {
    const lang = normalizeLang(req.query.lang)
    const data = await contentService.getCuisineDetail(req.params.code, lang)

    if (!data) {
      return res.status(404).json({ ok: false, message: 'Cuisine not found' })
    }

    return res.json({ ok: true, data })
  } catch (error) {
    next(error)
  }
}

async function listCuisineGallery(req, res, next) {
  try {
    const lang = normalizeLang(req.query.lang)
    const data = await contentService.getCuisineGallery(lang)
    return res.json({ ok: true, data })
  } catch (error) {
    next(error)
  }
}

async function listEthnicities(req, res, next) {
  try {
    const lang = normalizeLang(req.query.lang)
    const data = await contentService.listEthnicities(lang)
    res.json({ ok: true, data })
  } catch (error) {
    next(error)
  }
}

async function getEthnicity(req, res, next) {
  try {
    const lang = normalizeLang(req.query.lang)
    const data = await contentService.getEthnicity(req.params.code, lang)

    if (!data) {
      return res.status(404).json({ ok: false, message: 'Ethnic group not found' })
    }

    return res.json({ ok: true, data })
  } catch (error) {
    next(error)
  }
}

async function askAi(req, res, next) {
  try {
    const lang = normalizeLang(req.body.lang || req.query.lang)
    const data = await contentService.askAi({
      question: req.body.question || '',
      lang,
    })
    res.json({ ok: true, data })
  } catch (error) {
    next(error)
  }
}

module.exports = {
  listArticles,
  getArticle,
  listRegions,
  getRegion,
  listProvinces,
  getProvince,
  listFestivals,
  getFestival,
  listCuisines,
  getCuisine,
  listCuisineGallery,
  listEthnicities,
  getEthnicity,
  askAi,
}

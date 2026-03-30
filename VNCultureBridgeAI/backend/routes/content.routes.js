const express = require('express')
const contentController = require('../controllers/content.controller')

const router = express.Router()

router.get('/articles', contentController.listArticles)
router.get('/articles/:code', contentController.getArticle)
router.get('/regions', contentController.listRegions)
router.get('/regions/:code', contentController.getRegion)
router.get('/ethnicities', contentController.listEthnicities)
router.get('/ethnicities/:code', contentController.getEthnicity)

module.exports = router

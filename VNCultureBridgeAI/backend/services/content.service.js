const contentRepository = require('../repositories/content.repository')
const { pickLocalized } = require('../utils/locale')

function mapArticle(row, lang) {
  return {
    id: row.BaiVietID,
    code: row.MaBaiViet,
    title: pickLocalized(row, 'TieuDeVI', 'TieuDeEN', lang),
    description: pickLocalized(row, 'MoTaNganVI', 'MoTaNganEN', lang),
    intro: pickLocalized(row, 'GioiThieuVI', 'GioiThieuEN', lang),
    origin: pickLocalized(row, 'NguonGocVI', 'NguonGocEN', lang),
    meaning: pickLocalized(row, 'YNghiaVanHoaVI', 'YNghiaVanHoaEN', lang),
    context: pickLocalized(row, 'BoiCanhVI', 'BoiCanhEN', lang),
    content: pickLocalized(row, 'NoiDungChinhVI', 'NoiDungChinhEN', lang),
    aiSummary: pickLocalized(row, 'TomTatChoAIVI', 'TomTatChoAIEN', lang),
    imageUrl: row.ImageUrl || null,
    imageAlt: pickLocalized(row, 'AltTextVI', 'AltTextEN', lang),
    publishedAt: row.NgayXuatBan || null,
  }
}

async function listArticles(filters, lang) {
  const rows = await contentRepository.getArticles(filters)
  return rows.map((row) => mapArticle(row, lang))
}

async function getArticle(code, lang) {
  const row = await contentRepository.getArticleByCode(code)
  return row ? mapArticle(row, lang) : null
}

async function listRegions(lang) {
  const rows = await contentRepository.getRegions()
  return rows.map((row) => ({
    id: row.VungID,
    code: row.MaVung,
    name: pickLocalized(row, 'TenVI', 'TenEN', lang),
    type: row.LoaiVung,
  }))
}

async function getRegion(code, lang) {
  const row = await contentRepository.getRegionByCode(code)
  if (!row) return null

  return {
    id: row.VungID,
    code: row.MaVung,
    name: pickLocalized(row, 'TenVI', 'TenEN', lang),
    type: row.LoaiVung,
  }
}

async function listEthnicities(lang) {
  const rows = await contentRepository.getEthnicities()
  return rows.map((row) => ({
    id: row.DanTocID,
    code: row.MaDanToc,
    name: pickLocalized(row, 'TenVI', 'TenEN', lang),
    description: pickLocalized(row, 'MoTaVI', 'MoTaEN', lang),
  }))
}

async function getEthnicity(code, lang) {
  const row = await contentRepository.getEthnicityByCode(code)
  if (!row) return null

  return {
    id: row.DanTocID,
    code: row.MaDanToc,
    name: pickLocalized(row, 'TenVI', 'TenEN', lang),
    description: pickLocalized(row, 'MoTaVI', 'MoTaEN', lang),
  }
}

module.exports = {
  listArticles,
  getArticle,
  listRegions,
  getRegion,
  listEthnicities,
  getEthnicity,
}

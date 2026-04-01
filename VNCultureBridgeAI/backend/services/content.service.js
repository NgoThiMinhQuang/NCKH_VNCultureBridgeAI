const contentRepository = require('../repositories/content.repository')
const homepageRepository = require('../repositories/homepage.repository')
const { pickLocalized } = require('../utils/locale')

function mapArticleCard(row, lang) {
  return {
    id: row.BaiVietID,
    code: row.MaBaiViet,
    title: pickLocalized(row, 'TieuDeVI', 'TieuDeEN', lang),
    description: pickLocalized(row, 'MoTaNganVI', 'MoTaNganEN', lang),
    imageUrl: row.ImageUrl || null,
    imageAlt: pickLocalized(row, 'AltTextVI', 'AltTextEN', lang),
    publishedAt: row.NgayXuatBan || null,
  }
}

function mapArticle(row, lang) {
  return {
    ...mapArticleCard(row, lang),
    intro: pickLocalized(row, 'GioiThieuVI', 'GioiThieuEN', lang),
    origin: pickLocalized(row, 'NguonGocVI', 'NguonGocEN', lang),
    meaning: pickLocalized(row, 'YNghiaVanHoaVI', 'YNghiaVanHoaEN', lang),
    context: pickLocalized(row, 'BoiCanhVI', 'BoiCanhEN', lang),
    content: pickLocalized(row, 'NoiDungChinhVI', 'NoiDungChinhEN', lang),
    aiSummary: pickLocalized(row, 'TomTatChoAIVI', 'TomTatChoAIEN', lang),
  }
}

async function listArticles(filters, lang) {
  const rows = await contentRepository.getArticles(filters)
  return rows.map((row) => mapArticleCard(row, lang))
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

async function askAi({ question, lang }) {
  const [articles, prompts] = await Promise.all([
    contentRepository.getArticleSearchMatches({ q: question, limit: 3 }),
    homepageRepository.getPromptSamples(),
  ])
  const mappedArticles = articles.map((row) => mapArticle(row, lang))

  const answer = mappedArticles.length
    ? `${lang === 'vi' ? 'Dựa trên dữ liệu hiện có, bạn có thể bắt đầu từ:' : 'Based on the current verified data, you can start with:'} ${mappedArticles
        .map((item) => item.title)
        .join(', ')}.`
    : lang === 'vi'
      ? 'Hiện mình chưa có đủ dữ liệu xác thực cho câu hỏi này. Bạn có thể thử hỏi về Tết, áo dài, phở hoặc múa rối nước.'
      : 'I do not have enough verified data for that question yet. You can ask about Tet, Ao Dai, pho, or water puppetry.'

  return {
    answer,
    prompts: prompts.map((prompt) => ({
      code: prompt.MaPrompt,
      type: prompt.LoaiPrompt,
      title: prompt.TenPrompt,
    })),
    relatedArticles: mappedArticles,
  }
}

module.exports = {
  listArticles,
  getArticle,
  listRegions,
  getRegion,
  listEthnicities,
  getEthnicity,
  askAi,
}

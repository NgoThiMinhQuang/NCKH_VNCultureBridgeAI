const homepageRepository = require('../repositories/homepage.repository')
const { getStaticContent } = require('./static-content.service')
const { pickLocalized } = require('../utils/locale')

function mapCard(row, lang) {
  return {
    id: row.BaiVietID || row.VungID || row.DanTocID || row.DanhMucID,
    code: row.MaBaiViet || row.MaVung || row.MaDanToc || row.MaDanhMuc,
    title: pickLocalized(row, 'TieuDeVI', 'TieuDeEN', lang) || pickLocalized(row, 'TenVI', 'TenEN', lang),
    description:
      pickLocalized(row, 'MoTaNganVI', 'MoTaNganEN', lang) ||
      pickLocalized(row, 'MoTaVI', 'MoTaEN', lang),
    imageUrl: row.ImageUrl || null,
    imageAlt: pickLocalized(row, 'AltTextVI', 'AltTextEN', lang),
    articleCount: row.ArticleCount || 0,
    publishedAt: row.NgayXuatBan || null,
    category: pickLocalized(row, 'CategoryTenVI', 'CategoryTenEN', lang),
  }
}

async function getHomepage(lang = 'vi') {
  const [regions, ethnicGroups, festivals, cuisine, arts, blogPosts, categories, prompts] =
    await Promise.all([
      homepageRepository.getFeaturedRegions(),
      homepageRepository.getFeaturedEthnicGroups(),
      homepageRepository.getFeaturedArticlesByCategory('LE_HOI', 3),
      homepageRepository.getFeaturedArticlesByCategory('AM_THUC', 3),
      homepageRepository.getFeaturedArticlesByCategory('NGHE_THUAT_DAN_GIAN', 3),
      homepageRepository.getLatestArticles(3),
      homepageRepository.getCategories(),
      homepageRepository.getPromptSamples(),
    ])

  const staticContent = getStaticContent(lang)

  return {
    meta: {
      lang,
      generatedAt: new Date().toISOString(),
    },
    hero: staticContent.hero,
    intro: staticContent.intro,
    stats: staticContent.stats,
    regions: regions.map((row) => mapCard(row, lang)),
    ethnicGroups: ethnicGroups.map((row) => mapCard(row, lang)),
    festivals: festivals.map((row) => mapCard(row, lang)),
    cuisine: cuisine.map((row) => mapCard(row, lang)),
    arts: arts.map((row) => mapCard(row, lang)),
    blogPosts: blogPosts.map((row) => mapCard(row, lang)),
    categories: categories.map((row) => mapCard(row, lang)),
    aiGuide: {
      ...staticContent.aiGuide,
      prompts: prompts.map((prompt) => ({
        code: prompt.MaPrompt,
        type: prompt.LoaiPrompt,
        title: prompt.TenPrompt,
        content: prompt.NoiDungPrompt,
      })),
    },
    footer: staticContent.footer,
  }
}

module.exports = {
  getHomepage,
}

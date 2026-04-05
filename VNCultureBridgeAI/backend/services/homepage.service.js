const homepageRepository = require('../repositories/homepage.repository')
const { getStaticContent } = require('./static-content.service')
const { pickLocalized } = require('../utils/locale')

const HOMEPAGE_CACHE_TTL_MS = 60 * 1000
const homepageCache = new Map()

function mergeUniqueCards(primaryRows, fallbackRows, limit = 6) {
  const seen = new Set()
  const merged = []

  for (const row of [...primaryRows, ...fallbackRows]) {
    const key = row.BaiVietID || row.MaBaiViet || row.DanhMucID || row.MaDanhMuc
    if (!key || seen.has(key)) continue
    seen.add(key)
    merged.push(row)
    if (merged.length >= limit) break
  }

  return merged
}

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

function parseHighlights(value) {
  if (!value) return []

  try {
    const parsed = JSON.parse(value)
    return Array.isArray(parsed) ? parsed : []
  } catch {
    return []
  }
}

function mapHomepageRegion(row, lang) {
  return {
    id: row.VungID,
    code: row.MaVung,
    displayOrder: row.HomepageDisplayOrder || 0,
    badge: row.HomepageBadgeVI || pickLocalized(row, 'TenVI', 'TenEN', lang),
    title: row.HomepageTitleVI || pickLocalized(row, 'TenVI', 'TenEN', lang),
    description: row.HomepageDescriptionVI || pickLocalized(row, 'TenVI', 'TenEN', lang),
    highlights: parseHighlights(row.HomepageHighlightsVI),
    cta: row.HomepageCtaVI || `Khám phá ${pickLocalized(row, 'TenVI', 'TenEN', lang)}`,
    imageUrl: row.ImageUrl || null,
    imageAlt: row.HomepageImageAltVI || row.AltTextVI || pickLocalized(row, 'TenVI', 'TenEN', lang),
    articleCount: row.ArticleCount || 0,
    accentClass:
      row.MaVung === 'BAC_BO'
        ? 'is-north'
        : row.MaVung === 'TRUNG_BO'
          ? 'is-central'
          : row.MaVung === 'NAM_BO'
            ? 'is-south'
            : '',
    number: String(row.HomepageDisplayOrder || '').padStart(2, '0'),
  }
}

async function getHomepage(lang = 'vi') {
  const now = Date.now()
  const cached = homepageCache.get(lang)

  if (cached && cached.expiresAt > now) {
    return cached.data
  }

  const [regions, ethnicGroups, festivals, cuisine, arts, blogPosts, categories, prompts, latestFallbackArticles] =
    await Promise.all([
      homepageRepository.getFeaturedRegions(),
      homepageRepository.getFeaturedEthnicGroups(),
      homepageRepository.getFeaturedArticlesByCategory('LE_HOI', 3),
      homepageRepository.getFeaturedArticlesByCategory('AM_THUC', 3),
      homepageRepository.getFeaturedArticlesByCategory('NGHE_THUAT_DAN_GIAN', 6),
      homepageRepository.getLatestArticles(3),
      homepageRepository.getCategories(),
      homepageRepository.getPromptSamples(),
      homepageRepository.getLatestArticles(12),
    ])

  const homepageArts = mergeUniqueCards(arts, latestFallbackArticles, 6)

  const staticContent = getStaticContent(lang)

  const data = {
    meta: {
      lang,
      generatedAt: new Date().toISOString(),
    },
    hero: staticContent.hero,
    intro: staticContent.intro,
    stats: staticContent.stats,
    regions: regions.map((row) => mapHomepageRegion(row, lang)),
    ethnicGroups: ethnicGroups.map((row) => mapCard(row, lang)),
    festivals: festivals.map((row) => mapCard(row, lang)),
    cuisine: cuisine.map((row) => mapCard(row, lang)),
    arts: homepageArts.map((row) => mapCard(row, lang)),
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

  homepageCache.set(lang, {
    data,
    expiresAt: now + HOMEPAGE_CACHE_TTL_MS,
  })

  return data
}

module.exports = {
  getHomepage,
}

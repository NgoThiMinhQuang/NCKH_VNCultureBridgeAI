const homepageRepository = require('../repositories/homepage.repository')
const { getStaticContent } = require('./static-content.service')
const { pickLocalized } = require('../utils/locale')

const HOMEPAGE_CACHE_TTL_MS = 60 * 1000
const homepageCache = new Map()

function fixMojibake(value) {
  if (typeof value !== 'string' || !value) return value
  if (!/[ÃÂáàảãạăắằẳẵặâấầẩẫậđêếềểễệíìỉĩịóòỏõọôốồổỗộơớờởỡợúùủũụưứừửữựýỳỷỹỵ]/.test(value)) {
    return value
  }

  try {
    return Buffer.from(value, 'latin1').toString('utf8')
  } catch {
    return value
  }
}

function fixMojibakeArray(values) {
  return Array.isArray(values) ? values.map((item) => fixMojibake(item)) : values
}

function fixMojibakeRow(row, fields) {
  const nextRow = { ...row }

  for (const field of fields) {
    nextRow[field] = fixMojibake(nextRow[field])
  }

  return nextRow
}

function normalizeHomepageRegionRow(row) {
  const normalized = fixMojibakeRow(row, [
    'TenVI',
    'HomepageBadgeVI',
    'HomepageTitleVI',
    'HomepageDescriptionVI',
    'HomepageHighlightsVI',
    'HomepageCtaVI',
    'HomepageImageAltVI',
    'AltTextVI',
  ])

  normalized._fixedHighlights = fixMojibakeArray(parseHighlights(normalized.HomepageHighlightsVI))

  return normalized
}

function normalizeCardRow(row) {
  return fixMojibakeRow(row, [
    'TenVI',
    'MoTaVI',
    'TieuDeVI',
    'MoTaNganVI',
    'AltTextVI',
    'CategoryTenVI',
  ])
}

function normalizePromptRow(row) {
  return fixMojibakeRow(row, ['TenPrompt', 'NoiDungPrompt'])
}

function normalizeRows(rows, mapper) {
  return rows.map(mapper)
}

function clearHomepageCache() {
  homepageCache.clear()
}

clearHomepageCache()

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
    highlights: row._fixedHighlights || parseHighlights(row.HomepageHighlightsVI),
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

  let [regions, ethnicGroups, festivals, cuisine, arts, categories, prompts, latestArticles] =
    await Promise.all([
      homepageRepository.getFeaturedRegions(),
      homepageRepository.getFeaturedEthnicGroups(),
      homepageRepository.getFeaturedArticlesByCategory('LE_HOI', 3),
      homepageRepository.getFeaturedArticlesByCategory('AM_THUC', 3),
      homepageRepository.getFeaturedArticlesByCategory('NGHE_THUAT_DAN_GIAN', 6),
      homepageRepository.getCategories(),
      homepageRepository.getPromptSamples(),
      homepageRepository.getLatestArticles(12),
    ])

  regions = normalizeRows(regions, normalizeHomepageRegionRow)
  ethnicGroups = normalizeRows(ethnicGroups, normalizeCardRow)
  festivals = normalizeRows(festivals, normalizeCardRow)
  cuisine = normalizeRows(cuisine, normalizeCardRow)
  arts = normalizeRows(arts, normalizeCardRow)
  categories = normalizeRows(categories, normalizeCardRow)
  prompts = normalizeRows(prompts, normalizePromptRow)
  latestArticles = normalizeRows(latestArticles, normalizeCardRow)

  const homepageArts = mergeUniqueCards(arts, latestArticles, 6)
  const blogPosts = latestArticles.slice(0, 3)

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

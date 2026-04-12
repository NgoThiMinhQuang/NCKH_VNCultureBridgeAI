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

function hasBrokenText(value) {
  return typeof value === 'string' && /[�\u0011]/.test(value)
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

function parseHighlights(value) {
  if (!value) return []

  try {
    const parsed = JSON.parse(value)
    return Array.isArray(parsed) ? parsed : []
  } catch {
    return []
  }
}

const HOMEPAGE_REGION_COPY_VI = {
  BAC_BO: {
    badge: 'Miền Bắc',
    title: 'Miền Bắc',
    description: 'Khám phá Hà Nội, Hạ Long và những ruộng bậc thang hùng vĩ của vùng núi phía Bắc.',
    highlights: ['Hà Nội', 'Hạ Long', 'Sa Pa', 'Hà Giang'],
    cta: 'Khám phá Miền Bắc',
    imageAlt: 'Cảnh sắc ruộng bậc thang miền Bắc Việt Nam',
  },
  TRUNG_BO: {
    badge: 'Miền Trung',
    title: 'Miền Trung',
    description: 'Từ Huế, Hội An đến Đà Nẵng, miền Trung mang vẻ đẹp giao hòa giữa lịch sử và thiên nhiên.',
    highlights: ['Huế', 'Hội An', 'Đà Nẵng', 'Mỹ Sơn'],
    cta: 'Khám phá Miền Trung',
    imageAlt: 'Đèn lồng phố cổ Hội An về đêm',
  },
  NAM_BO: {
    badge: 'Miền Nam',
    title: 'Miền Nam',
    description: 'Miền Nam nổi bật với TP.HCM, miền Tây sông nước và hành trình ẩm thực, chợ nổi, biển đảo.',
    highlights: ['TP.HCM', 'Cần Thơ', 'Mekong', 'Phú Quốc'],
    cta: 'Khám phá Miền Nam',
    imageAlt: 'Khung cảnh sông nước miền Nam Việt Nam',
  },
}

const CATEGORY_COPY = {
  AM_THUC: { vi: 'Ẩm thực', en: 'Cuisine' },
  LE_HOI: { vi: 'Lễ hội', en: 'Festivals' },
  NGHE_THUAT_DAN_GIAN: { vi: 'Nghệ thuật dân gian', en: 'Folk arts' },
}

function resolveCategory(row, lang, value) {
  const fixedValue = fixMojibake(value)

  if (fixedValue && !hasBrokenText(fixedValue)) {
    return fixedValue
  }

  const fallback = CATEGORY_COPY[row.MaDanhMuc]
  if (!fallback) {
    return fixedValue || value || null
  }

  return lang === 'en' ? fallback.en : fallback.vi
}

function resolveCardTitle(row, lang, value) {
  const fixedValue = fixMojibake(value)

  if (fixedValue && !hasBrokenText(fixedValue)) {
    return fixedValue
  }

  return lang === 'vi'
    ? fixMojibake(row.TieuDeEN || row.TenEN || fixedValue)
    : fixMojibake(row.TieuDeVI || row.TenVI || fixedValue)
}

function resolveCardDescription(row, lang, value) {
  const fixedValue = fixMojibake(value)

  if (fixedValue && !hasBrokenText(fixedValue)) {
    return fixedValue
  }

  return lang === 'vi'
    ? fixMojibake(row.MoTaNganEN || row.MoTaEN || fixedValue)
    : fixMojibake(row.MoTaNganVI || row.MoTaVI || fixedValue)
}

function resolveImageAlt(row, lang, value, title) {
  const fixedValue = fixMojibake(value)

  if (fixedValue && !hasBrokenText(fixedValue)) {
    return fixedValue
  }

  return lang === 'vi'
    ? fixMojibake(row.AltTextEN || title)
    : fixMojibake(row.AltTextVI || title)
}

function resolvePublishedAt(row) {
  return row.NgayXuatBan || null
}

function getFallbackArticleCount(row) {
  return row.ArticleCount || 0
}

function resolveCardCode(row) {
  return row.MaBaiViet || row.MaVung || row.MaDanToc || row.MaDanhMuc
}

function resolveCardId(row) {
  return row.BaiVietID || row.VungID || row.DanTocID || row.DanhMucID
}

function resolveCardImage(row) {
  return row.ImageUrl || null
}

function resolveCardTitleAndDescription(row, lang) {
  const rawTitle = pickLocalized(row, 'TieuDeVI', 'TieuDeEN', lang) || pickLocalized(row, 'TenVI', 'TenEN', lang)
  const rawDescription =
    pickLocalized(row, 'MoTaNganVI', 'MoTaNganEN', lang) ||
    pickLocalized(row, 'MoTaVI', 'MoTaEN', lang)

  return {
    title: resolveCardTitle(row, lang, rawTitle),
    description: resolveCardDescription(row, lang, rawDescription),
  }
}

function resolveCardMeta(row, lang, title) {
  const rawCategory = pickLocalized(row, 'CategoryTenVI', 'CategoryTenEN', lang)
  const rawImageAlt = pickLocalized(row, 'AltTextVI', 'AltTextEN', lang)

  return {
    category: resolveCategory(row, lang, rawCategory),
    imageAlt: resolveImageAlt(row, lang, rawImageAlt, title),
  }
}

function mapCard(row, lang) {
  const { title, description } = resolveCardTitleAndDescription(row, lang)
  const { category, imageAlt } = resolveCardMeta(row, lang, title)

  return {
    id: resolveCardId(row),
    code: resolveCardCode(row),
    title,
    description,
    imageUrl: resolveCardImage(row),
    imageAlt,
    articleCount: getFallbackArticleCount(row),
    publishedAt: resolvePublishedAt(row),
    category,
  }
}

function mapHomepageRegion(row, lang) {
  const fallbackVi = lang === 'vi' ? HOMEPAGE_REGION_COPY_VI[row.MaVung] || {} : {}

  const badge = row.HomepageBadgeVI || pickLocalized(row, 'TenVI', 'TenEN', lang)
  const title = row.HomepageTitleVI || pickLocalized(row, 'TenVI', 'TenEN', lang)
  const description = row.HomepageDescriptionVI || pickLocalized(row, 'TenVI', 'TenEN', lang)
  const highlights = row._fixedHighlights || parseHighlights(row.HomepageHighlightsVI)
  const cta = row.HomepageCtaVI || `Khám phá ${pickLocalized(row, 'TenVI', 'TenEN', lang)}`
  const imageAlt = row.HomepageImageAltVI || row.AltTextVI || pickLocalized(row, 'TenVI', 'TenEN', lang)

  const resolvedBadge = lang === 'vi' && /[�\u0011]/.test(badge || '') ? fallbackVi.badge || badge : badge
  const resolvedTitle = lang === 'vi' && /[�\u0011]/.test(title || '') ? fallbackVi.title || title : title
  const resolvedDescription = lang === 'vi' && /[�\u0011]/.test(description || '') ? fallbackVi.description || description : description
  const resolvedHighlights = lang === 'vi' && (!highlights.length || highlights.some((item) => /[�\u0011]/.test(item || '')))
    ? fallbackVi.highlights || highlights
    : highlights
  const resolvedCta = lang === 'vi' && /[�\u0011]/.test(cta || '') ? fallbackVi.cta || cta : cta
  const resolvedImageAlt = lang === 'vi' && /[�\u0011]/.test(imageAlt || '') ? fallbackVi.imageAlt || imageAlt : imageAlt

  return {
    id: row.VungID,
    code: row.MaVung,
    displayOrder: row.HomepageDisplayOrder || 0,
    badge: resolvedBadge,
    title: resolvedTitle,
    description: resolvedDescription,
    highlights: resolvedHighlights,
    cta: resolvedCta,
    imageUrl: row.ImageUrl || null,
    imageAlt: resolvedImageAlt,
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

function parseJson(value, fallback = []) {
  if (!value) return fallback
  try {
    const parsed = JSON.parse(value)
    return Array.isArray(fallback)
      ? (Array.isArray(parsed) ? parsed : fallback)
      : (parsed && typeof parsed === 'object' ? parsed : fallback)
  } catch {
    return fallback
  }
}

function resolveLocalizedContent(row, viKey, enKey, lang) {
  const value = pickLocalized(row, viKey, enKey, lang)
  return fixMojibake(value)
}

async function getHomepage(lang = 'vi') {
  const now = Date.now()
  const cached = homepageCache.get(lang)

  if (cached && cached.expiresAt > now) {
    return cached.data
  }

  let [regions, ethnicGroups, festivals, cuisine, arts, categories, prompts, latestArticles, artPage] =
    await Promise.all([
      homepageRepository.getFeaturedRegions(),
      homepageRepository.getFeaturedEthnicGroups(),
      homepageRepository.getFeaturedArticlesByCategory('LE_HOI', 3),
      homepageRepository.getFeaturedArticlesByCategory('AM_THUC', 3),
      homepageRepository.getFeaturedArticlesByCategory('NGHE_THUAT_DAN_GIAN', 6),
      homepageRepository.getCategories(),
      homepageRepository.getPromptSamples(),
      homepageRepository.getLatestArticles(12),
      homepageRepository.getArtPageContent(),
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
  const artLanding = artPage
    ? {
        hero: {
          badge: resolveLocalizedContent(artPage, 'HeroBadgeVI', 'HeroBadgeEN', lang),
          titleLine1: resolveLocalizedContent(artPage, 'HeroTitleLine1VI', 'HeroTitleLine1EN', lang),
          titleAccent: resolveLocalizedContent(artPage, 'HeroTitleAccentVI', 'HeroTitleAccentEN', lang),
          titleLine3: resolveLocalizedContent(artPage, 'HeroTitleLine3VI', 'HeroTitleLine3EN', lang),
          subtitle: resolveLocalizedContent(artPage, 'HeroSubtitleVI', 'HeroSubtitleEN', lang),
          imageUrl: artPage.HeroImageUrl || null,
          imageAlt: resolveLocalizedContent(artPage, 'HeroImageAltVI', 'HeroImageAltEN', lang),
          imageBadge: resolveLocalizedContent(artPage, 'HeroImageBadgeVI', 'HeroImageBadgeEN', lang),
          imageBadgeIcon: artPage.HeroImageBadgeIcon || '🏔️',
        },
        stats: parseJson(resolveLocalizedContent(artPage, 'StatsJsonVI', 'StatsJsonEN', lang), []),
        heritage: {
          title: resolveLocalizedContent(artPage, 'HeritageTitleVI', 'HeritageTitleEN', lang),
          subtitle: resolveLocalizedContent(artPage, 'HeritageSubtitleVI', 'HeritageSubtitleEN', lang),
          cards: parseJson(resolveLocalizedContent(artPage, 'HeritageCardsJsonVI', 'HeritageCardsJsonEN', lang), []),
        },
        featuredArtwork: {
          badge: resolveLocalizedContent(artPage, 'FeaturedBadgeVI', 'FeaturedBadgeEN', lang),
          title: resolveLocalizedContent(artPage, 'FeaturedTitleVI', 'FeaturedTitleEN', lang),
          body: parseJson(resolveLocalizedContent(artPage, 'FeaturedBodyJsonVI', 'FeaturedBodyJsonEN', lang), []),
          stats: parseJson(resolveLocalizedContent(artPage, 'FeaturedStatsJsonVI', 'FeaturedStatsJsonEN', lang), []),
          imageUrl: artPage.FeaturedImageUrl || null,
          imageAlt: resolveLocalizedContent(artPage, 'FeaturedImageAltVI', 'FeaturedImageAltEN', lang),
        },
        gallery: {
          title: resolveLocalizedContent(artPage, 'GalleryTitleVI', 'GalleryTitleEN', lang),
          subtitle: resolveLocalizedContent(artPage, 'GallerySubtitleVI', 'GallerySubtitleEN', lang),
          images: parseJson(resolveLocalizedContent(artPage, 'GalleryImagesJsonVI', 'GalleryImagesJsonEN', lang), []),
        },
        story: {
          badge: resolveLocalizedContent(artPage, 'StoryBadgeVI', 'StoryBadgeEN', lang),
          title: resolveLocalizedContent(artPage, 'StoryTitleVI', 'StoryTitleEN', lang),
          body: parseJson(resolveLocalizedContent(artPage, 'StoryBodyJsonVI', 'StoryBodyJsonEN', lang), []),
          features: parseJson(resolveLocalizedContent(artPage, 'StoryFeaturesJsonVI', 'StoryFeaturesJsonEN', lang), []),
          images: parseJson(resolveLocalizedContent(artPage, 'StoryImagesJsonVI', 'StoryImagesJsonEN', lang), []),
        },
      }
    : null

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
    artLanding,
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

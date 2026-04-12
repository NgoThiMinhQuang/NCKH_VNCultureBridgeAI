const contentRepository = require('../repositories/content.repository')
const homepageRepository = require('../repositories/homepage.repository')
const { pickLocalized, fixMojibake } = require('../utils/locale')

function fixText(value) {
  return typeof value === 'string' ? fixMojibake(value) : value
}

function mapText(row, viKey, enKey, lang) {
  return fixText(pickLocalized(row, viKey, enKey, lang))
}

function mapArrayText(values) {
  return Array.isArray(values)
    ? values.map((item) => {
        if (typeof item === 'string') return fixText(item)
        if (item && typeof item === 'object') {
          return Object.fromEntries(
            Object.entries(item).map(([key, value]) => [key, typeof value === 'string' ? fixText(value) : value]),
          )
        }
        return item
      })
    : values
}

function parseLocalizedJson(row, viKey, enKey, lang, fallback = []) {
  const value = mapText(row, viKey, enKey, lang)

  if (!value) return fallback

  try {
    const parsed = JSON.parse(value)
    return Array.isArray(parsed) ? mapArrayText(parsed) : fallback
  } catch {
    return fallback
  }
}

function mapArticleCard(row, lang) {
  return {
    id: row.BaiVietID,
    code: row.MaBaiViet,
    title: mapText(row, 'TieuDeVI', 'TieuDeEN', lang),
    description: mapText(row, 'MoTaNganVI', 'MoTaNganEN', lang),
    imageUrl: row.ImageUrl || null,
    imageAlt: mapText(row, 'AltTextVI', 'AltTextEN', lang),
    publishedAt: row.NgayXuatBan || null,
  }
}

function mapArticle(row, lang) {
  return {
    ...mapArticleCard(row, lang),
    intro: mapText(row, 'GioiThieuVI', 'GioiThieuEN', lang),
    origin: mapText(row, 'NguonGocVI', 'NguonGocEN', lang),
    meaning: mapText(row, 'YNghiaVanHoaVI', 'YNghiaVanHoaEN', lang),
    context: mapText(row, 'BoiCanhVI', 'BoiCanhEN', lang),
    content: mapText(row, 'NoiDungChinhVI', 'NoiDungChinhEN', lang),
    aiSummary: mapText(row, 'TomTatChoAIVI', 'TomTatChoAIEN', lang),
  }
}

const REGION_NAME_COPY = {
  BAC_BO: { vi: 'Miền Bắc', en: 'Northern Vietnam' },
  TRUNG_BO: { vi: 'Miền Trung', en: 'Central Vietnam' },
  NAM_BO: { vi: 'Miền Nam', en: 'Southern Vietnam' },
  TAY_NGUYEN: { vi: 'Tây Nguyên', en: 'Central Highlands' },
  DBSCL: { vi: 'Đồng bằng sông Cửu Long', en: 'Mekong Delta' },
}

function resolveRegionName(code, lang, currentValue) {
  if (currentValue) {
    if (lang === 'vi' && REGION_NAME_COPY[code]?.en === currentValue) {
      return REGION_NAME_COPY[code].vi
    }

    return currentValue
  }

  const fallback = REGION_NAME_COPY[code]
  if (!fallback) return currentValue || null
  return lang === 'en' ? fallback.en : fallback.vi
}

function getProvinceDescription(row, lang, type, subRegion, name) {
  const subtitle = mapText(row, 'TieuDePhuVI', 'TieuDePhuEN', lang)
  if (subtitle) return subtitle

  const overview = mapText(row, 'TongQuanVI', 'TongQuanEN', lang)
  if (overview) {
    const excerpt = overview.split(/(?<=[.!?])\s+/)[0]?.trim() || overview.trim()
    if (excerpt) return excerpt
  }

  if (type && subRegion) {
    return lang === 'en'
      ? `${name} is a ${type.toLowerCase()} in ${subRegion}.`
      : `${name} là ${type.toLowerCase()} thuộc ${subRegion}.`
  }

  return ''
}

function mapProvinceCard(row, lang) {
  const name = mapText(row, 'TenVI', 'TenEN', lang) || row.MaTinh || ''
  const region = resolveRegionName(row.MaVung, lang, mapText(row, 'VungTenVI', 'VungTenEN', lang)) || ''
  const subRegion = mapText(row, 'TieuVungVI', 'TieuVungEN', lang) || ''
  const type = mapText(row, 'LoaiTinhVI', 'LoaiTinhEN', lang) || ''
  const tags = parseLocalizedJson(row, 'TagsJsonVI', 'TagsJsonEN', lang)
  const area = mapText(row, 'AreaDisplayVI', 'AreaDisplayEN', lang) || ''
  const pop = mapText(row, 'PopulationDisplayVI', 'PopulationDisplayEN', lang) || ''
  const imageAlt = mapText(row, 'AnhDaiDienAltVI', 'AnhDaiDienAltEN', lang) || name || null

  return {
    id: row.TinhThanhID,
    code: row.MaTinh,
    name,
    region,
    subRegion,
    type,
    description: getProvinceDescription(row, lang, type, subRegion, name),
    tags: Array.isArray(tags) ? tags : [],
    area,
    pop,
    imageUrl: row.AnhDaiDienUrl || null,
    imageAlt,
  }
}

function mapProvince(row, lang) {
  const provinceCard = mapProvinceCard(row, lang)
  const overviewContent = mapText(row, 'TongQuanVI', 'TongQuanEN', lang) || provinceCard.description

  return {
    ...provinceCard,
    regionCode: row.MaVung || null,
    subtitle: mapText(row, 'TieuDePhuVI', 'TieuDePhuEN', lang) || provinceCard.description,
    heroImageUrl: row.HeroImageUrl || row.AnhDaiDienUrl || null,
    heroImageAlt:
      mapText(row, 'HeroImageAltVI', 'HeroImageAltEN', lang) ||
      provinceCard.imageAlt,
    breadcrumbLabel: provinceCard.name,
    metrics: {
      weather: mapText(row, 'ThoiTietMacDinhVI', 'ThoiTietMacDinhEN', lang) || '',
      bestTime: mapText(row, 'ThoiDiemDepVI', 'ThoiDiemDepEN', lang) || '',
      population: provinceCard.pop,
      area: provinceCard.area,
    },
    overview: {
      content: overviewContent || '',
      quickInfo: {
        founded: mapText(row, 'ThongTinThanhLapVI', 'ThongTinThanhLapEN', lang) || '',
        administrative: mapText(row, 'ThongTinHanhChinhVI', 'ThongTinHanhChinhEN', lang) || '',
        timezone: row.MuiGio || 'UTC+7',
        dialCode: row.MaVungDienThoai || '',
      },
      sidebarImageUrl: row.SidebarImageUrl || row.AnhDaiDienUrl || null,
      sidebarImageAlt:
        mapText(row, 'SidebarImageAltVI', 'SidebarImageAltEN', lang) ||
        provinceCard.imageAlt,
    },
    places: parseLocalizedJson(row, 'DiaDiemJsonVI', 'DiaDiemJsonEN', lang),
    culture: parseLocalizedJson(row, 'VanHoaJsonVI', 'VanHoaJsonEN', lang),
    cuisine: parseLocalizedJson(row, 'AmThucJsonVI', 'AmThucJsonEN', lang),
    itinerary: parseLocalizedJson(row, 'LichTrinhJsonVI', 'LichTrinhJsonEN', lang),
  }
}

function parseRegionHighlights(row) {
  const rawValue = fixText(row?.HomepageHighlightsVI)
  if (!rawValue) return []

  try {
    const parsed = JSON.parse(rawValue)
    return Array.isArray(parsed) ? mapArrayText(parsed) : []
  } catch {
    return []
  }
}

function getRegionKey(code) {
  if (code === 'BAC_BO') return 'north'
  if (code === 'TRUNG_BO') return 'central'
  if (code === 'NAM_BO') return 'south'
  return String(code || '').toLowerCase()
}

function mapRegion(row, lang) {
  const name = resolveRegionName(row.MaVung, lang, mapText(row, 'TenVI', 'TenEN', lang))
  const type = fixText(row.LoaiVung)
  const badge = fixText(row.HomepageBadgeVI) || name
  const title = fixText(row.HomepageTitleVI) || name
  const description = fixText(row.HomepageDescriptionVI) || type || name

  return {
    id: row.VungID,
    code: row.MaVung,
    key: getRegionKey(row.MaVung),
    name,
    type,
    badge,
    title,
    headline: title,
    description,
    highlights: parseRegionHighlights(row),
    cta: fixText(row.HomepageCtaVI) || null,
    imageUrl: row.ImageUrl || row.HomepageImageUrl || null,
    imageAlt: mapText(row, 'HomepageImageAltVI', 'AltTextEN', lang) || name,
    articleCount: row.ArticleCount || 0,
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
  return rows.map((row) => mapRegion(row, lang))
}

async function getRegion(code, lang) {
  const row = await contentRepository.getRegionByCode(code)
  return row ? mapRegion(row, lang) : null
}

async function listProvinces(filters, lang) {
  const rows = await contentRepository.getProvinces(filters)
  return rows.map((row) => mapProvinceCard(row, lang))
}

async function getProvince(code, lang) {
  const row = await contentRepository.getProvinceByCode(code)
  return row ? mapProvince(row, lang) : null
}

function mapEthnicityCard(row, lang) {
  const name = mapText(row, 'TenVI', 'TenEN', lang) || row.MaDanToc || ''
  const description = mapText(row, 'MoTaVI', 'MoTaEN', lang) || ''
  const regionName = resolveRegionName(row.PrimaryRegionCode, lang, mapText(row, 'PrimaryRegionNameVI', 'PrimaryRegionNameEN', lang)) || ''

  return {
    id: row.DanTocID,
    code: String(row.MaDanToc || '').toLowerCase(),
    rawCode: row.MaDanToc,
    name,
    description,
    cardImageUrl: row.CardImageUrl || null,
    cardImageAlt: mapText(row, 'CardImageAltVI', 'CardImageAltEN', lang) || name,
    heroBackgroundImageUrl: row.HeroBackgroundImageUrl || null,
    heroBackgroundImageAlt: mapText(row, 'HeroBackgroundAltVI', 'HeroBackgroundAltEN', lang) || name,
    heroForegroundImageUrl: row.HeroForegroundImageUrl || row.CardImageUrl || null,
    heroForegroundImageAlt: mapText(row, 'HeroForegroundAltVI', 'HeroForegroundAltEN', lang) || name,
    articleCount: row.ArticleCount || 0,
    location: regionName,
    region: regionName,
    status: (row.ArticleCount || 0) >= 2 ? (lang === 'vi' ? 'Nổi bật' : 'Featured') : '',
  }
}

function mapEthnicitySectionItem(row, lang, fallbackSize = 'small') {
  return {
    id: row.DanTocSectionItemID,
    code: row.MaBaiViet || '',
    title: mapText(row, 'TieuDeVI', 'TieuDeEN', lang) || '',
    description: mapText(row, 'MoTaVI', 'MoTaEN', lang) || '',
    imageUrl: row.ImageUrl || null,
    imageAlt: mapText(row, 'ImageAltVI', 'ImageAltEN', lang) || '',
    size: row.LayoutSize || fallbackSize,
    tag: mapText(row, 'TagVI', 'TagEN', lang) || '',
    publishedAt: row.NgayXuatBan || null,
  }
}

async function listEthnicities(lang) {
  const [rows, featureRows, storyRows, galleryRows] = await Promise.all([
    contentRepository.getEthnicities(),
    contentRepository.getEthnicityFeatureArticles(6),
    contentRepository.getEthnicityStoryItems(6),
    contentRepository.getEthnicityGallery(null, 7),
  ])

  const ethnicities = rows.map((row) => mapEthnicityCard(row, lang))

  return {
    hero: {
      backgroundImageUrl: ethnicities[0]?.heroBackgroundImageUrl || null,
      backgroundImageAlt: ethnicities[0]?.heroBackgroundImageAlt || '',
      foregroundImageUrl: ethnicities[0]?.heroForegroundImageUrl || null,
      foregroundImageAlt: ethnicities[0]?.heroForegroundImageAlt || '',
    },
    stats: {
      ethnicGroupCount: ethnicities.length,
      regionCount: [...new Set(ethnicities.map((item) => item.region).filter(Boolean))].length,
      articleCount: ethnicities.reduce((sum, item) => sum + (item.articleCount || 0), 0),
      galleryCount: galleryRows.length,
    },
    ethnicities,
    filters: {
      regions: [lang === 'vi' ? 'Tất cả vùng' : 'All regions', ...new Set(ethnicities.map((item) => item.region).filter(Boolean))],
      ethnicities: [lang === 'vi' ? 'Tất cả dân tộc' : 'All ethnic groups', ...ethnicities.map((item) => item.name)],
    },
    sections: {
      features: featureRows.slice(0, 3).map((row) => mapEthnicitySectionItem(row, lang, 'small')),
      stories: storyRows.slice(0, 3).map((row) => mapEthnicitySectionItem(row, lang, 'small')),
      gallery: galleryRows.map((row) => mapEthnicitySectionItem(row, lang, row.LayoutSize || 'small')),
    },
  }
}

async function getEthnicity(code, lang) {
  const normalizedCode = String(code || '').toUpperCase()
  const [row, festivals, cuisine, arts, textiles, gallery, relatedArticles] = await Promise.all([
    contentRepository.getEthnicityByCode(normalizedCode),
    contentRepository.getEthnicitySectionItems(normalizedCode, 'FESTIVALS', 6),
    contentRepository.getEthnicitySectionItems(normalizedCode, 'CUISINE', 6),
    contentRepository.getEthnicitySectionItems(normalizedCode, 'ARTS', 6),
    contentRepository.getEthnicitySectionItems(normalizedCode, 'TEXTILES', 6),
    contentRepository.getEthnicityGallery(normalizedCode, 7),
    contentRepository.getArticles({ ethnicity: normalizedCode, limit: 6 }),
  ])

  if (!row) return null

  const card = mapEthnicityCard(row, lang)
  const primaryRegion = resolveRegionName(row.PrimaryRegionCode, lang, mapText(row, 'PrimaryRegionLabelVI', 'PrimaryRegionLabelEN', lang) || mapText(row, 'PrimaryRegionNameVI', 'PrimaryRegionNameEN', lang)) || ''

  return {
    id: card.id,
    code: card.code,
    rawCode: row.MaDanToc,
    name: card.name,
    description: card.description,
    hero: {
      badge: lang === 'vi' ? 'Dân tộc Việt Nam' : 'Ethnic Cultures of Vietnam',
      title: card.name,
      subtitle: mapText(row, 'HeroSubtitleVI', 'HeroSubtitleEN', lang) || card.description,
      backgroundImageUrl: row.HeroBackgroundImageUrl || null,
      backgroundImageAlt: mapText(row, 'HeroBackgroundAltVI', 'HeroBackgroundAltEN', lang) || card.name,
      foregroundImageUrl: row.HeroForegroundImageUrl || row.CardImageUrl || null,
      foregroundImageAlt: mapText(row, 'HeroForegroundAltVI', 'HeroForegroundAltEN', lang) || card.name,
      stats: [
        { value: mapText(row, 'PopulationLabelVI', 'PopulationLabelEN', lang) || String(card.articleCount || 0), label: lang === 'vi' ? 'Quy mô tư liệu' : 'Content scale' },
        { value: primaryRegion || (lang === 'vi' ? 'Đang cập nhật' : 'Updating'), label: lang === 'vi' ? 'Khu vực chính' : 'Primary region' },
      ],
    },
    overview: {
      title: mapText(row, 'OverviewTitleVI', 'OverviewTitleEN', lang) || (lang === 'vi' ? `Giới thiệu về ${card.name}` : `Introduction to ${card.name}`),
      content: mapText(row, 'OverviewBodyVI', 'OverviewBodyEN', lang) || card.description,
      imageUrl: row.IntroImageUrl || row.HeroForegroundImageUrl || row.CardImageUrl || null,
      imageAlt: mapText(row, 'IntroImageAltVI', 'IntroImageAltEN', lang) || card.name,
    },
    featureHighlight: {
      imageUrl: row.FeatureHighlightImageUrl || null,
      imageAlt: mapText(row, 'FeatureHighlightAltVI', 'FeatureHighlightAltEN', lang) || card.name,
    },
    sections: {
      history: {
        title: mapText(row, 'HistoryTitleVI', 'HistoryTitleEN', lang) || (lang === 'vi' ? 'Lịch sử & nguồn gốc' : 'History & Origins'),
        content: mapText(row, 'HistoryBodyVI', 'HistoryBodyEN', lang) || card.description,
      },
      culture: {
        title: mapText(row, 'CultureTitleVI', 'CultureTitleEN', lang) || (lang === 'vi' ? 'Đặc trưng văn hóa' : 'Cultural Identity'),
        content: mapText(row, 'CultureBodyVI', 'CultureBodyEN', lang) || card.description,
      },
      architecture: {
        title: mapText(row, 'ArchitectureTitleVI', 'ArchitectureTitleEN', lang) || (lang === 'vi' ? 'Không gian sống' : 'Living Space'),
        content: mapText(row, 'ArchitectureBodyVI', 'ArchitectureBodyEN', lang) || card.description,
        imageUrl: row.ArchitectureImageUrl || null,
        imageAlt: mapText(row, 'ArchitectureImageAltVI', 'ArchitectureImageAltEN', lang) || card.name,
      },
      textiles: textiles.map((item) => mapEthnicitySectionItem(item, lang, 'square')),
      festivals: festivals.map((item) => mapEthnicitySectionItem(item, lang, 'small')),
      cuisine: cuisine.map((item) => mapEthnicitySectionItem(item, lang, 'portrait')),
      arts: arts.map((item) => mapEthnicitySectionItem(item, lang, 'small')),
      music: {
        title: lang === 'vi' ? 'Âm thanh & nghệ thuật trình diễn' : 'Music & Performing Arts',
        content: mapText(row, 'CultureBodyVI', 'CultureBodyEN', lang) || card.description,
        imageUrl: row.MusicImageUrl || null,
        imageAlt: mapText(row, 'MusicImageAltVI', 'MusicImageAltEN', lang) || card.name,
      },
    },
    gallery: gallery.map((item) => mapEthnicitySectionItem(item, lang, item.LayoutSize || 'small')),
    relatedArticles: relatedArticles.map((item) => mapArticleCard(item, lang)),
    meta: {
      articleCount: card.articleCount,
      primaryRegion,
      sparseSections: [
        ...(festivals.length ? [] : ['festivals']),
        ...(cuisine.length ? [] : ['cuisine']),
        ...(arts.length ? [] : ['arts']),
        ...(gallery.length ? [] : ['gallery']),
      ],
    },
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
      title: fixText(prompt.TenPrompt),
    })),
    relatedArticles: mappedArticles,
  }
}

module.exports = {
  listArticles,
  getArticle,
  listRegions,
  getRegion,
  listProvinces,
  getProvince,
  listEthnicities,
  getEthnicity,
  askAi,
}

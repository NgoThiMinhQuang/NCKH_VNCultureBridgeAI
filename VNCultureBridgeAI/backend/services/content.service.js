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

function mapProvinceCard(row, lang) {
  return {
    id: row.TinhThanhID,
    code: row.MaTinh,
    name: mapText(row, 'TenVI', 'TenEN', lang),
    region: resolveRegionName(row.MaVung, lang, mapText(row, 'VungTenVI', 'VungTenEN', lang)),
    subRegion: mapText(row, 'TieuVungVI', 'TieuVungEN', lang),
    type: mapText(row, 'LoaiTinhVI', 'LoaiTinhEN', lang),
    tags: parseLocalizedJson(row, 'TagsJsonVI', 'TagsJsonEN', lang),
    area: mapText(row, 'AreaDisplayVI', 'AreaDisplayEN', lang),
    pop: mapText(row, 'PopulationDisplayVI', 'PopulationDisplayEN', lang),
    imageUrl: row.AnhDaiDienUrl || null,
    imageAlt: mapText(row, 'AnhDaiDienAltVI', 'AnhDaiDienAltEN', lang),
  }
}

function mapProvince(row, lang) {
  const provinceCard = mapProvinceCard(row, lang)

  return {
    ...provinceCard,
    subtitle: mapText(row, 'TieuDePhuVI', 'TieuDePhuEN', lang),
    heroImageUrl: row.HeroImageUrl || row.AnhDaiDienUrl || null,
    heroImageAlt:
      mapText(row, 'HeroImageAltVI', 'HeroImageAltEN', lang) ||
      mapText(row, 'AnhDaiDienAltVI', 'AnhDaiDienAltEN', lang),
    breadcrumbLabel: mapText(row, 'TenVI', 'TenEN', lang),
    metrics: {
      weather: mapText(row, 'ThoiTietMacDinhVI', 'ThoiTietMacDinhEN', lang),
      bestTime: mapText(row, 'ThoiDiemDepVI', 'ThoiDiemDepEN', lang),
      population: mapText(row, 'PopulationDisplayVI', 'PopulationDisplayEN', lang),
      area: mapText(row, 'AreaDisplayVI', 'AreaDisplayEN', lang),
    },
    overview: {
      content: mapText(row, 'TongQuanVI', 'TongQuanEN', lang),
      quickInfo: {
        founded: mapText(row, 'ThongTinThanhLapVI', 'ThongTinThanhLapEN', lang),
        administrative: mapText(row, 'ThongTinHanhChinhVI', 'ThongTinHanhChinhEN', lang),
        timezone: row.MuiGio || 'UTC+7',
        dialCode: row.MaVungDienThoai || '',
      },
      sidebarImageUrl: row.SidebarImageUrl || row.AnhDaiDienUrl || null,
      sidebarImageAlt:
        mapText(row, 'SidebarImageAltVI', 'SidebarImageAltEN', lang) ||
        mapText(row, 'AnhDaiDienAltVI', 'AnhDaiDienAltEN', lang),
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

async function listEthnicities(lang) {
  const rows = await contentRepository.getEthnicities()
  return rows.map((row) => ({
    id: row.DanTocID,
    code: row.MaDanToc,
    name: mapText(row, 'TenVI', 'TenEN', lang),
    description: mapText(row, 'MoTaVI', 'MoTaEN', lang),
  }))
}

async function getEthnicity(code, lang) {
  const row = await contentRepository.getEthnicityByCode(code)
  if (!row) return null

  return {
    id: row.DanTocID,
    code: row.MaDanToc,
    name: mapText(row, 'TenVI', 'TenEN', lang),
    description: mapText(row, 'MoTaVI', 'MoTaEN', lang),
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

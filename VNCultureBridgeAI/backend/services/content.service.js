const contentRepository = require('../repositories/content.repository')
const homepageRepository = require('../repositories/homepage.repository')
const { pickLocalized, fixMojibake } = require('../utils/locale')

function parseJson(value, fallback = []) {
  if (!value) return fallback
  try {
    const parsed = JSON.parse(value)
    if (Array.isArray(fallback)) {
      return Array.isArray(parsed) ? parsed : fallback
    }
    return parsed && typeof parsed === 'object' ? parsed : fallback
  } catch {
    return fallback
  }
}

function mapFestivalListItem(row, lang) {
  return {
    id: row.LeHoiID,
    code: row.MaLeHoi,
    title: fixText(pickLocalized(row, 'TieuDeVI', 'TieuDeEN', lang)),
    enTitle: fixText(pickLocalized(row, 'TieuDePhuVI', 'TieuDePhuEN', lang)),
    desc: fixText(pickLocalized(row, 'MoTaNganVI', 'MoTaNganEN', lang)),
    location: fixText(pickLocalized(row, 'ViTriVI', 'ViTriEN', lang)),
    date: fixText(pickLocalized(row, 'NgayLeVI', 'NgayLeEN', lang)),
    tag: fixText(pickLocalized(row, 'TagVI', 'TagEN', lang)),
    tagColor: row.TagColor || '#ce112d',
    image: row.ImageUrl || null,
  }
}

function mapFestivalTimelineItem(row, lang) {
  return {
    id: row.LeHoiID,
    code: row.MaLeHoi,
    month: fixText(pickLocalized(row, 'TimelineMonthVI', 'TimelineMonthEN', lang)),
    title: fixText(pickLocalized(row, 'ShortTitleVI', 'ShortTitleEN', lang)) || fixText(pickLocalized(row, 'TieuDeVI', 'TieuDeEN', lang)),
    season: fixText(pickLocalized(row, 'TimelineSeasonVI', 'TimelineSeasonEN', lang)),
    color: row.TimelineColor || row.TagColor || '#ce112d',
    image: row.TimelineImageUrl || row.ImageUrl || null,
  }
}

function mapFestivalPageContent(row, lang) {
  if (!row) return null
  return {
    badge: fixText(pickLocalized(row, 'PageBadgeVI', 'PageBadgeEN', lang)),
    titleLine1: fixText(pickLocalized(row, 'PageTitleLine1VI', 'PageTitleLine1EN', lang)),
    titleAccent: fixText(pickLocalized(row, 'PageTitleAccentVI', 'PageTitleAccentEN', lang)),
    titleLine3: fixText(pickLocalized(row, 'PageTitleLine3VI', 'PageTitleLine3EN', lang)),
    subtitle: fixText(pickLocalized(row, 'PageSubtitleVI', 'PageSubtitleEN', lang)),
    stats: parseJson(pickLocalized(row, 'PageStatsJsonVI', 'PageStatsJsonEN', lang), []),
    heroImageUrl: row.PageHeroImageUrl || null,
    heroImageAlt: fixText(pickLocalized(row, 'PageHeroImageAltVI', 'PageHeroImageAltEN', lang)),
    searchPlaceholder: fixText(pickLocalized(row, 'SearchPlaceholderVI', 'SearchPlaceholderEN', lang)),
    filterButton: fixText(pickLocalized(row, 'FilterButtonVI', 'FilterButtonEN', lang)),
    filters: {
      regions: [fixText(pickLocalized(row, 'AllRegionsVI', 'AllRegionsEN', lang)), 'north', 'central', 'south'],
      months: [fixText(pickLocalized(row, 'AllMonthsVI', 'AllMonthsEN', lang))],
      categories: [fixText(pickLocalized(row, 'AllCategoriesVI', 'AllCategoriesEN', lang))],
      ethnicGroups: [fixText(pickLocalized(row, 'AllEthnicGroupsVI', 'AllEthnicGroupsEN', lang))],
    },
    major: {
      badge: fixText(pickLocalized(row, 'MajorBadgeVI', 'MajorBadgeEN', lang)),
      title: fixText(pickLocalized(row, 'MajorTitleVI', 'MajorTitleEN', lang)),
      subtitle: fixText(pickLocalized(row, 'MajorSubtitleVI', 'MajorSubtitleEN', lang)),
    },
    all: {
      title: fixText(pickLocalized(row, 'AllTitleVI', 'AllTitleEN', lang)),
      subtitle: fixText(pickLocalized(row, 'AllSubtitleVI', 'AllSubtitleEN', lang)),
    },
    timeline: {
      badge: fixText(pickLocalized(row, 'TimelineBadgeVI', 'TimelineBadgeEN', lang)),
      title: fixText(pickLocalized(row, 'TimelineTitleVI', 'TimelineTitleEN', lang)),
      subtitle: fixText(pickLocalized(row, 'TimelineSubtitleVI', 'TimelineSubtitleEN', lang)),
      hint: fixText(pickLocalized(row, 'TimelineHintVI', 'TimelineHintEN', lang)),
    },
    gallery: {
      badge: fixText(pickLocalized(row, 'GalleryBadgeVI', 'GalleryBadgeEN', lang)),
      title: fixText(pickLocalized(row, 'GalleryTitleVI', 'GalleryTitleEN', lang)),
      subtitle: fixText(pickLocalized(row, 'GallerySubtitleVI', 'GallerySubtitleEN', lang)),
    },
    meaning: {
      badge: fixText(pickLocalized(row, 'MeaningBadgeVI', 'MeaningBadgeEN', lang)),
      title: fixText(pickLocalized(row, 'MeaningTitleVI', 'MeaningTitleEN', lang)),
      paragraphs: parseJson(pickLocalized(row, 'MeaningParagraphsJsonVI', 'MeaningParagraphsJsonEN', lang), []),
      button: fixText(pickLocalized(row, 'MeaningButtonVI', 'MeaningButtonEN', lang)),
      buttonHref: row.MeaningButtonHref || '/articles',
    },
    timelineItems: parseJson(pickLocalized(row, 'TimelineItemsJsonVI', 'TimelineItemsJsonEN', lang), []),
    galleryImages: parseJson(pickLocalized(row, 'GalleryImagesJsonVI', 'GalleryImagesJsonEN', lang), []),
    quote: {
      title: fixText(pickLocalized(row, 'QuoteTitleVI', 'QuoteTitleEN', lang)),
      subtitle: fixText(pickLocalized(row, 'QuoteSubtitleVI', 'QuoteSubtitleEN', lang)),
      desc: fixText(pickLocalized(row, 'QuoteDescVI', 'QuoteDescEN', lang)),
      button: fixText(pickLocalized(row, 'QuoteButtonVI', 'QuoteButtonEN', lang)),
      backgroundImageUrl: row.QuoteBackgroundImageUrl || row.PageHeroImageUrl || null,
      backgroundImageAlt: fixText(pickLocalized(row, 'QuoteBackgroundImageAltVI', 'QuoteBackgroundImageAltEN', lang)),
    },
  }
}

function buildFestivalFallbackContent(row, lang) {
  const title = fixText(pickLocalized(row, 'TieuDeVI', 'TieuDeEN', lang))
  const subtitle = fixText(pickLocalized(row, 'TieuDePhuVI', 'TieuDePhuEN', lang))
  const description = fixText(pickLocalized(row, 'HeroDescVI', 'HeroDescEN', lang)) || fixText(pickLocalized(row, 'MoTaNganVI', 'MoTaNganEN', lang))
  const location = fixText(pickLocalized(row, 'ViTriVI', 'ViTriEN', lang))
  const date = fixText(pickLocalized(row, 'NgayLeVI', 'NgayLeEN', lang))
  const tag = fixText(pickLocalized(row, 'TagVI', 'TagEN', lang))
  const baseImage = row.ImageUrl || row.TimelineImageUrl || null
  const timelineImage = row.TimelineImageUrl || row.ImageUrl || null

  return {
    whatIsItContext: [
      `${title} là một lễ hội tiêu biểu trong đời sống văn hóa Việt Nam, gắn với cộng đồng, ký ức truyền thống và các nghi thức được lưu truyền qua nhiều thế hệ.`,
      `${title} thường được nhắc đến với không khí ${tag ? tag.toLowerCase() : 'văn hóa'} đặc sắc tại ${location || 'nhiều địa phương'}, nơi người dân cùng tham gia các hoạt động nghi lễ, trình diễn và sinh hoạt cộng đồng.`
    ],
    quickFacts: {
      date: date || 'Đang cập nhật',
      location: location || 'Đang cập nhật',
      participants: 'Cộng đồng địa phương và du khách',
    },
    whyItMattersCards: [
      { icon: '🏛️', colorClass: 'highlight-red', title: 'Gìn giữ di sản', desc: `${title} giúp bảo tồn ký ức văn hóa, nghi lễ và những giá trị truyền thống của cộng đồng.` },
      { icon: '🤝', colorClass: 'highlight-orange', title: 'Kết nối cộng đồng', desc: 'Lễ hội là dịp để người dân sum họp, cùng tham gia sinh hoạt tập thể và tăng cường sự gắn kết.' },
      { icon: '✨', colorClass: 'highlight-yellow', title: 'Lan tỏa bản sắc', desc: `${title} góp phần giới thiệu vẻ đẹp văn hóa vùng miền đến thế hệ trẻ và du khách gần xa.` },
    ],
    whyItMatterConclusionHTML: `<strong>${title}</strong> không chỉ là một sự kiện văn hóa mà còn là nơi các giá trị về cội nguồn, cộng đồng và bản sắc được tái hiện sống động qua từng mùa lễ hội.`,
    inspiringQuote: `${title} là nhịp cầu nối giữa ký ức truyền thống, đời sống cộng đồng và niềm tự hào văn hóa Việt Nam.`,
    howItIsCelebrated: [
      {
        phase: 'Chuẩn bị',
        title: `Chuẩn bị cho ${title}`,
        desc: [
          `Trước khi lễ hội diễn ra, cộng đồng tại ${location || 'địa phương'} thường dọn dẹp không gian, chuẩn bị lễ vật và sắp xếp các hoạt động nghi thức.`,
          'Công tác chuẩn bị thể hiện sự trân trọng đối với truyền thống và mong muốn gìn giữ lễ hội một cách trang trọng.'
        ],
        image: baseImage,
        align: 'left'
      },
      {
        phase: 'Nghi lễ chính',
        title: 'Nghi thức và sinh hoạt cộng đồng',
        desc: [
          `${title} thường có các nghi thức tưởng niệm, cầu chúc hoặc tôn vinh những giá trị gắn với lịch sử, tín ngưỡng hay đời sống bản địa.`,
          'Bên cạnh phần lễ, người dân còn tham gia các hoạt động trình diễn, giao lưu và sinh hoạt văn hóa mang đậm bản sắc địa phương.'
        ],
        image: timelineImage,
        align: 'right'
      },
      {
        phase: 'Lan tỏa',
        title: 'Trải nghiệm của người tham dự',
        desc: [
          'Du khách có thể cảm nhận rõ bầu không khí náo nhiệt, tính cộng đồng và chiều sâu biểu tượng của lễ hội qua từng hoạt động.',
          `Thông qua ${title}, những câu chuyện về lịch sử, phong tục và tinh thần vùng miền được kể lại một cách trực quan và sinh động.`
        ],
        image: baseImage,
        align: 'left'
      },
    ],
    whatTetFeelsLike: {
      leftText: [
        `Không gian: ${location || 'Địa phương tổ chức'} trở nên rộn ràng với cờ, sắc màu lễ hội và dòng người cùng đổ về tham dự.`,
        'Âm thanh: Tiếng trò chuyện, nhạc lễ, tiếng trống hoặc lời xướng nghi thức tạo nên bầu không khí giàu cảm xúc.',
        `Nhịp điệu: ${title} mang đến cảm giác vừa trang nghiêm, vừa gần gũi và đầy sức sống cộng đồng.`
      ],
      rightText: [
        'Con người: Người dân địa phương, nghệ nhân và du khách cùng góp phần làm nên một bức tranh lễ hội đa sắc.',
        'Cảm xúc: Đó là sự hòa quyện giữa niềm tự hào về cội nguồn, tinh thần sum họp và sự trân trọng dành cho di sản.',
        `Ấn tượng: ${title} để lại dấu ấn qua cả nghi thức, cảnh sắc lẫn sự hiếu khách của cộng đồng bản địa.`
      ],
      image: baseImage,
    },
    keyTraditionsDocs: [
      { image: baseImage, title: 'Không gian nghi lễ', desc: `Không gian tổ chức ${title} thường được chuẩn bị trang trọng, phản ánh niềm tôn kính và ý thức gìn giữ truyền thống.` },
      { image: timelineImage, title: 'Sinh hoạt cộng đồng', desc: 'Các hoạt động tập thể là phần không thể thiếu, giúp kết nối người dân và lan tỏa tinh thần lễ hội.' },
      { image: baseImage, title: 'Biểu tượng văn hóa', desc: `Mỗi chi tiết trong ${title} đều gắn với câu chuyện riêng về lịch sử, tín ngưỡng hoặc phong tục vùng miền.` },
    ],
    traditionalFoods: [
      { image: baseImage, title: 'Món ăn truyền thống', desc: `Ẩm thực trong ${title} góp phần thể hiện hương vị địa phương và sự hiếu khách của cộng đồng.` },
      { image: timelineImage, title: 'Món cúng lễ', desc: 'Nhiều món ăn được chuẩn bị như một phần của nghi thức dâng cúng và tưởng nhớ.' },
      { image: baseImage, title: 'Đặc sản địa phương', desc: 'Du khách thường tìm thấy trong lễ hội những món ăn tiêu biểu gắn với vùng đất tổ chức.' },
    ],
    regionalFoods: {
      north: [{ image: baseImage, title: 'Hương vị miền Bắc', desc: 'Những món ăn mang tính thanh nhã, cân bằng và gắn với truyền thống mùa vụ.' }],
      central: [{ image: timelineImage, title: 'Hương vị miền Trung', desc: 'Ẩm thực đậm đà, chỉn chu và giàu sắc thái văn hóa bản địa.' }],
      south: [{ image: baseImage, title: 'Hương vị miền Nam', desc: 'Các món ăn phong phú, gần gũi và mang tinh thần cởi mở của đời sống phương Nam.' }],
    },
    culturalMeaningsDocs: [
      { icon: '🌿', title: 'Gắn kết với cội nguồn', desc: `${title} giúp cộng đồng nhớ về lịch sử, tổ tiên hoặc những giá trị tinh thần được lưu truyền lâu dài.`, colorClass: 'highlight-red' },
      { icon: '🎎', title: 'Giữ nhịp sống văn hóa', desc: 'Lễ hội là nơi những phong tục, biểu tượng và ký ức cộng đồng tiếp tục được thực hành trong đời sống hiện đại.', colorClass: 'highlight-orange' },
      { icon: '💞', title: 'Củng cố tinh thần cộng đồng', desc: 'Việc cùng nhau tham gia phần lễ và phần hội tạo ra cảm giác thuộc về và tự hào chung.', colorClass: 'highlight-yellow' },
    ],
    interestingFactsDocs: [
      { icon: '📍', title: 'Dấu ấn vùng miền', desc: `${title} mang những nét riêng gắn với ${location || 'địa phương tổ chức'}, từ nghi thức đến cách trình bày không gian.` },
      { icon: '🧭', title: 'Giàu tính trải nghiệm', desc: 'Người tham dự không chỉ quan sát mà còn có thể cảm nhận trực tiếp nhịp sống văn hóa qua từng hoạt động.' },
      { icon: '📷', title: 'Hấp dẫn du khách', desc: 'Màu sắc, âm thanh và bầu không khí của lễ hội tạo nên nhiều khoảnh khắc giàu cảm xúc và tính thị giác.' },
    ],
    galleryHero: baseImage,
    galleryGrid: [baseImage, timelineImage, baseImage, timelineImage, baseImage, timelineImage].filter(Boolean),
    inShortText: `${title} là một lát cắt sinh động của văn hóa Việt Nam, nơi cộng đồng cùng gìn giữ ký ức, nghi lễ và vẻ đẹp bản sắc qua từng mùa lễ hội.`,
    discoverMore: [
      { image: baseImage, title: `Nghi thức trong ${title}`, desc: 'Khám phá ý nghĩa biểu tượng và cách cộng đồng chuẩn bị cho những thời khắc quan trọng của lễ hội.' },
      { image: timelineImage, title: 'Không gian và con người', desc: 'Tìm hiểu bối cảnh địa phương, những người tham gia và nhịp sống văn hóa xoay quanh lễ hội.' },
      { image: baseImage, title: 'Ẩm thực và ký ức cộng đồng', desc: 'Những món ăn, tập quán tiếp đón và trải nghiệm chung góp phần làm nên linh hồn của mỗi lễ hội.' },
    ],
    labels: {
      whatIsItTitle: `${title} là gì?`,
      dateLabel: 'Thời gian',
      locationLabel: 'Địa điểm',
      participantsLabel: 'Thành phần tham gia',
      culturalContextTitle: 'Bối cảnh văn hóa',
      celebrationTitle: `${title} được tổ chức như thế nào?`,
      feelsLikeTitle: `Trải nghiệm không khí ${title}`,
      keyTraditionsTitle: 'Những nét truyền thống nổi bật',
      traditionalFoodsTitle: `Ẩm thực gắn với ${title}`,
      traditionalFoodsSubtitle: 'Hương vị lễ hội góp phần kể câu chuyện về vùng đất, cộng đồng và ký ức văn hóa.',
      northRegionLabel: 'Miền Bắc',
      centralRegionLabel: 'Miền Trung',
      southRegionLabel: 'Miền Nam',
      culturalMeaningsTitle: 'Ý nghĩa văn hóa',
      interestingFactsTitle: `Điều thú vị về ${title}`,
      galleryTitle: `${title} qua hình ảnh`,
      inShortTitle: 'Tóm lược',
      discoverMoreTitle: `Khám phá thêm về ${title}`,
    },
  }
}

function mapFestivalDetail(row, lang) {
  if (!row) return null
  const content = parseJson(pickLocalized(row, 'NoiDungJsonVI', 'NoiDungJsonEN', lang), {})
  const fallback = buildFestivalFallbackContent(row, lang)
  return {
    id: row.LeHoiID,
    code: row.MaLeHoi,
    title: fixText(pickLocalized(row, 'TieuDeVI', 'TieuDeEN', lang)),
    enTitle: fixText(pickLocalized(row, 'TieuDePhuVI', 'TieuDePhuEN', lang)),
    heroDesc: fixText(pickLocalized(row, 'HeroDescVI', 'HeroDescEN', lang)),
    heroImage: row.ImageUrl || null,
    tag: fixText(pickLocalized(row, 'TagVI', 'TagEN', lang)),
    whatIsItContext: content.whatIsItContext || fallback.whatIsItContext,
    infoImage: content.infoImage || fallback.infoImage,
    quickFacts: content.quickFacts || fallback.quickFacts,
    whyItMattersCards: content.whyItMattersCards || fallback.whyItMattersCards,
    whyItMatterConclusionHTML: content.whyItMatterConclusionHTML || fallback.whyItMatterConclusionHTML,
    inspiringQuote: content.inspiringQuote || fallback.inspiringQuote,
    howItIsCelebrated: content.howItIsCelebrated || fallback.howItIsCelebrated,
    whatTetFeelsLike: content.whatTetFeelsLike || fallback.whatTetFeelsLike,
    keyTraditionsDocs: content.keyTraditionsDocs || fallback.keyTraditionsDocs,
    traditionalFoods: content.traditionalFoods || fallback.traditionalFoods,
    regionalFoods: content.regionalFoods || fallback.regionalFoods,
    culturalMeaningsDocs: content.culturalMeaningsDocs || fallback.culturalMeaningsDocs,
    interestingFactsDocs: content.interestingFactsDocs || fallback.interestingFactsDocs,
    galleryHero: content.galleryHero || fallback.galleryHero,
    galleryGrid: content.galleryGrid || fallback.galleryGrid,
    inShortText: content.inShortText || fallback.inShortText,
    discoverMore: content.discoverMore || fallback.discoverMore,
    labels: content.labels || fallback.labels,
  }
}

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

function splitParagraphs(value) {
  return String(value || '')
    .split(/\n+/)
    .map((line) => line.trim())
    .filter(Boolean)
}

function normalizeGallerySize(size, fallback = 'small') {
  const normalized = String(size || '').toLowerCase()
  if (normalized === 'large' || normalized === 'tall' || normalized === 'wide' || normalized === 'small') {
    return normalized
  }
  return fallback
}

function mapCuisineMediaItem(row, lang, fallbackSize = 'small') {
  const title = mapText(row, 'TieuDeVI', 'TieuDeEN', lang)
  return {
    id: row.MediaID,
    code: row.MaBaiViet,
    title,
    description: mapText(row, 'ChuThichVI', 'ChuThichEN', lang) || '',
    imageUrl: row.UrlFile || null,
    imageAlt: mapText(row, 'AltTextVI', 'AltTextEN', lang) || title,
    isMain: Boolean(row.LaAnhChinh),
    size: normalizeGallerySize(row.LayoutSize, fallbackSize),
    regionCode: row.RegionCode || null,
    regionName: resolveRegionName(row.RegionCode, lang, mapText(row, 'RegionNameVI', 'RegionNameEN', lang)) || '',
  }
}

function mapCuisineCard(row, lang) {
  const title = mapText(row, 'TieuDeVI', 'TieuDeEN', lang)
  const region = resolveRegionName(row.RegionCode, lang, mapText(row, 'RegionNameVI', 'RegionNameEN', lang)) || ''
  return {
    id: row.MaBaiViet,
    code: row.MaBaiViet,
    name: title,
    location: region,
    region,
    imgUrl: row.ImageUrl || null,
    imageAlt: mapText(row, 'AltTextVI', 'AltTextEN', lang) || title,
    status: region || '',
  }
}

function mapCuisineDetail(row, mediaRows, relatedRows, lang) {
  if (!row) return null

  const title = mapText(row, 'TieuDeVI', 'TieuDeEN', lang)
  const subtitle = mapText(row, 'MoTaNganVI', 'MoTaNganEN', lang)
  const region = resolveRegionName(row.RegionCode, lang, mapText(row, 'RegionNameVI', 'RegionNameEN', lang)) || ''
  const mainImage = row.ImageUrl || mediaRows[0]?.imageUrl || null
  const mainAlt = mapText(row, 'AltTextVI', 'AltTextEN', lang) || title
  const mediaImages = mediaRows.filter((item) => item.imageUrl)

  const paragraphs = splitParagraphs(mapText(row, 'NoiDungChinhVI', 'NoiDungChinhEN', lang))
  const introText = mapText(row, 'GioiThieuVI', 'GioiThieuEN', lang) || subtitle
  const originText = mapText(row, 'NguonGocVI', 'NguonGocEN', lang) || paragraphs[0] || subtitle
  const meaningText = mapText(row, 'YNghiaVanHoaVI', 'YNghiaVanHoaEN', lang) || paragraphs[1] || subtitle
  const contextText = mapText(row, 'BoiCanhVI', 'BoiCanhEN', lang) || paragraphs[2] || subtitle
  const stepsSource = paragraphs.length ? paragraphs : [introText, originText, meaningText].filter(Boolean)
  const steps = stepsSource.map((paragraph, index) => ({
    stepLabel: `${index + 1}`,
    title: `${lang === 'vi' ? 'Bước' : 'Step'} ${index + 1}`,
    desc: paragraph,
    imageUrl: mediaImages[index % Math.max(mediaImages.length, 1)]?.imageUrl || mainImage,
    imageAlt: mediaImages[index % Math.max(mediaImages.length, 1)]?.imageAlt || title,
  }))

  const gallery = mediaImages.map((item, index) => ({
    id: item.id,
    imageUrl: item.imageUrl,
    imageAlt: item.imageAlt,
    size: item.size || ['large', 'small', 'small', 'tall', 'small', 'wide'][index % 6] || 'small',
  }))

  const relatedArticles = relatedRows
    .filter((item) => item.MaBaiViet !== row.MaBaiViet)
    .slice(0, 3)
    .map((item) => ({
      id: item.MaBaiViet,
      title: mapText(item, 'TieuDeVI', 'TieuDeEN', lang),
      imageUrl: item.ImageUrl || null,
      imageAlt: mapText(item, 'AltTextVI', 'AltTextEN', lang) || mapText(item, 'TieuDeVI', 'TieuDeEN', lang),
    }))

  return {
    id: row.MaBaiViet,
    code: row.MaBaiViet,
    name: title,
    region,
    categoryLabel: lang === 'vi' ? 'Ẩm thực' : 'Cuisine',
    subtitle,
    heroImageUrl: mainImage,
    heroImageAlt: mainAlt,
    stats: {
      prepTime: lang === 'vi' ? 'Đang cập nhật' : 'Updating',
      difficulty: lang === 'vi' ? 'Đang cập nhật' : 'Updating',
      calories: lang === 'vi' ? 'Đang cập nhật' : 'Updating',
    },
    intro: {
      badge: lang === 'vi' ? 'Hương vị truyền thống' : 'Traditional flavor',
      title: mapText(row, 'TieuDeVI', 'TieuDeEN', lang),
      paragraphs: introText ? [introText, originText] : [],
      imageUrl: mainImage,
      imageAlt: mainAlt,
    },
    ingredients: {
      badge: lang === 'vi' ? 'Nguyên liệu chọn lọc' : 'Selected ingredients',
      title: lang === 'vi' ? 'Tinh Hoa Đất Trời Trên Mâm' : 'Essence on the table',
      subtitle: subtitle || introText,
      images: mediaImages.slice(0, 3).map((item) => item.imageUrl),
      summary: originText,
    },
    recipeSteps: steps,
    howToEnjoy: {
      badge: lang === 'vi' ? 'Nghệ thuật ẩm thực' : 'Culinary art',
      title: lang === 'vi' ? 'Cách Thưởng Thức' : 'How to enjoy',
      body: meaningText || contextText,
      imageUrl: mediaImages[1]?.imageUrl || mainImage,
      imageAlt: mediaImages[1]?.imageAlt || mainAlt,
    },
    secretTip: {
      badge: lang === 'vi' ? 'Góc ẩm thực' : 'Kitchen tip',
      title: lang === 'vi' ? 'Bí Quyết Nấu Ngon' : 'Cooking tip',
      body: contextText || meaningText,
      imageUrl: mediaImages[2]?.imageUrl || mainImage,
      imageAlt: mediaImages[2]?.imageAlt || mainAlt,
    },
    similarFoods: relatedArticles.slice(0, 3),
    gallery,
    article: {
      intro: introText,
      origin: originText,
      meaning: meaningText,
      context: contextText,
      content: mapText(row, 'NoiDungChinhVI', 'NoiDungChinhEN', lang),
      aiSummary: mapText(row, 'TomTatChoAIVI', 'TomTatChoAIEN', lang),
    },
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

async function listFestivals(lang) {
  const [pageRow, festivalRows] = await Promise.all([
    contentRepository.getFestivalPageContent(),
    contentRepository.getFestivals(),
  ])

  const festivals = festivalRows.map((row) => mapFestivalListItem(row, lang))
  const timeline = festivalRows
    .filter((row) => row.TimelineMonthVI || row.TimelineMonthEN)
    .map((row) => mapFestivalTimelineItem(row, lang))

  return {
    page: mapFestivalPageContent(pageRow, lang),
    festivals,
    timeline,
  }
}

async function getFestival(id, lang) {
  const row = await contentRepository.getFestivalById(String(id || ''))
  return row ? mapFestivalDetail(row, lang) : null
}

async function listCuisines(filters, lang) {
  const [rows, galleryRows] = await Promise.all([
    contentRepository.getCuisineArticles(filters?.limit || 50),
    contentRepository.getCuisineGalleryMedia(8),
  ])

  const cards = rows.map((row) => mapCuisineCard(row, lang))
  const regions = [...new Set(cards.map((item) => item.region).filter(Boolean))]
  const heroCuisines = [...new Set(cards.map((item) => item.name).filter(Boolean))]
  const heroRow = rows[0] || null

  return {
    hero: {
      badge: lang === 'vi' ? 'Khám phá ẩm thực 3 miền' : 'Discover Vietnamese cuisine',
      titleLine1: lang === 'vi' ? 'Tinh Hoa' : 'Essence',
      titleAccent: lang === 'vi' ? 'Ẩm Thực' : 'Cuisine',
      titleLine3: lang === 'vi' ? 'Việt Nam' : 'of Vietnam',
      subtitle: mapText(heroRow, 'MoTaNganVI', 'MoTaNganEN', lang) || (lang === 'vi' ? 'Khám phá những món ăn tiêu biểu được lưu giữ và kể lại từ dữ liệu CSDL.' : 'Explore signature dishes preserved and narrated from the database.'),
      stats: [
        { value: String(regions.length || 0), label: lang === 'vi' ? 'Vùng miền' : 'Regions' },
        { value: String(cards.length || 0), label: lang === 'vi' ? 'Món ăn' : 'Dishes' },
        { value: String(rows.reduce((sum, row) => sum + (row.TomTatChoAIVI || row.TomTatChoAIEN ? 1 : 0), 0) || cards.length || 0), label: lang === 'vi' ? 'Bài viết' : 'Articles' },
      ],
      heroImageUrl: heroRow?.ImageUrl || null,
      heroImageAlt: mapText(heroRow, 'AltTextVI', 'AltTextEN', lang) || mapText(heroRow, 'TieuDeVI', 'TieuDeEN', lang) || '',
    },
    regions: [lang === 'vi' ? 'Tất cả vùng' : 'All regions', ...regions],
    heroCuisines: [lang === 'vi' ? 'Tất cả món' : 'All dishes', ...heroCuisines],
    cards,
    features: rows.slice(0, 3).map((row, index) => ({
      id: row.BaiVietID || index + 1,
      title: mapText(row, 'TieuDeVI', 'TieuDeEN', lang),
      imgUrl: row.ImageUrl || null,
      tag: mapText(row, 'RegionNameVI', 'RegionNameEN', lang) || mapText(row, 'MoTaNganVI', 'MoTaNganEN', lang) || '',
      desc: mapText(row, 'GioiThieuVI', 'GioiThieuEN', lang) || mapText(row, 'YNghiaVanHoaVI', 'YNghiaVanHoaEN', lang) || mapText(row, 'MoTaNganVI', 'MoTaNganEN', lang) || '',
    })),
    stories: rows.slice(3, 6).map((row, index) => ({
      id: row.BaiVietID || index + 1,
      title: mapText(row, 'TieuDeVI', 'TieuDeEN', lang),
      desc: mapText(row, 'TomTatChoAIVI', 'TomTatChoAIEN', lang) || mapText(row, 'GioiThieuVI', 'GioiThieuEN', lang) || mapText(row, 'YNghiaVanHoaVI', 'YNghiaVanHoaEN', lang) || '',
      imgUrl: row.ImageUrl || null,
      code: row.MaBaiViet,
    })),
    gallery: galleryRows.map((row, index) => mapCuisineMediaItem(row, lang, ['large', 'small', 'small', 'tall', 'small', 'wide'][index % 6] || 'small')),
  }
}

async function getCuisine(code, lang) {
  const [row, mediaRows, relatedRows] = await Promise.all([
    contentRepository.getCuisineArticleByCode(code),
    contentRepository.getCuisineArticleMedia(code, 12),
    contentRepository.getCuisineArticles(8),
  ])

  return row
    ? mapCuisineDetail(
        row,
        mediaRows.map((item) => mapCuisineMediaItem(item, lang)),
        relatedRows,
        lang,
      )
    : null
}

async function getCuisineGallery(lang) {
  const rows = await contentRepository.getCuisineGalleryMedia(8)
  return rows.map((row, index) => mapCuisineMediaItem(row, lang, ['large', 'small', 'small', 'tall', 'small', 'wide'][index % 6] || 'small'))
}

async function getCuisineDetail(code, lang) {
  return getCuisine(code, lang)
}

function mapEthnicityCard(row, lang) {
  const name = mapText(row, 'TenVI', 'TenEN', lang) || row.MaDanToc || ''
  const description = mapText(row, 'MoTaVI', 'MoTaEN', lang) || ''
  const regionName = resolveRegionName(row.PrimaryRegionCode, lang, mapText(row, 'PrimaryRegionNameVI', 'PrimaryRegionNameEN', lang)) || ''

  const badge = mapText(row, 'ListBadgeVI', 'ListBadgeEN', lang)
  const isNew = Boolean(row.IsNew)

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
    sortOrder: row.DisplayOrder ?? 9999,
    location: regionName,
    region: regionName,
    status: badge || (isNew ? (lang === 'vi' ? 'Mới' : 'New') : ''),
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
  listFestivals,
  getFestival,
  listCuisines,
  getCuisine,
  getCuisineGallery,
  getCuisineDetail,
  listEthnicities,
  getEthnicity,
  askAi,
}

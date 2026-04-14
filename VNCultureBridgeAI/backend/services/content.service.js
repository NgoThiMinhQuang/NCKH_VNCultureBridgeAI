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

const ETHNICITY_DETAIL_OVERRIDES = {
  KINH: {
    overviewTitle: 'Giới thiệu về dân tộc Kinh',
    overviewBody: 'Người Kinh là cộng đồng chiếm đa số dân cư ở Việt Nam, phân bố rộng khắp cả nước. Đời sống văn hóa của người Kinh gắn với làng quê, phố thị, tín ngưỡng thờ cúng tổ tiên, áo dài, dân ca và nhiều lớp phong tục đã định hình diện mạo văn hóa Việt Nam.',
    heroSubtitle: 'Người Kinh sinh sống rộng khắp cả nước, nổi bật với văn hóa làng xã, tín ngưỡng thờ cúng tổ tiên, dân ca, áo dài và những thực hành văn hóa có ảnh hưởng sâu rộng trong đời sống Việt Nam.',
    cultureTitle: 'Đặc trưng văn hóa',
    cultureBody: 'Bản sắc văn hóa Kinh thể hiện qua tín ngưỡng thờ cúng tổ tiên, lễ tết truyền thống, áo dài, dân ca vùng miền, ẩm thực phong phú và nếp sinh hoạt gia đình - làng xã bền chặt.',
    historyTitle: 'Lịch sử & nguồn gốc',
    historyBody: 'Người Kinh có quá trình hình thành và phát triển lâu dài trên dải đất Việt Nam, gắn với nền văn minh lúa nước, đời sống làng xã và những biến đổi lịch sử từ nông thôn đến đô thị.',
    architectureTitle: 'Không gian sống',
    architectureBody: 'Không gian sống của người Kinh trải rộng từ làng quê đồng bằng, ven sông đến đô thị hiện đại. Nhà ở, đình chùa, chợ và không gian sinh hoạt cộng đồng phản ánh rõ nhịp sống và cấu trúc xã hội truyền thống lẫn đương đại.',
    musicTitle: 'Âm thanh & nghệ thuật trình diễn',
    musicBody: 'Âm nhạc và nghệ thuật trình diễn của người Kinh rất đa dạng, từ quan họ, chèo, ca trù đến nhã nhạc, cải lương và nhiều hình thức sân khấu dân gian, phản ánh chiều sâu văn hóa qua nhiều vùng miền.',
    populationLabel: 'Cộng đồng chiếm đa số dân cư Việt Nam',
    heroBackgroundAlt: 'Không gian đời sống văn hóa của người Kinh',
    heroForegroundAlt: 'Hình ảnh đại diện văn hóa dân tộc Kinh',
    introImageAlt: 'Sinh hoạt văn hóa của người Kinh',
    featureHighlightAlt: 'Nét văn hóa tiêu biểu của người Kinh',
    musicImageAlt: 'Âm nhạc và nghệ thuật trình diễn của người Kinh',
    architectureImageAlt: 'Không gian sống của người Kinh',
  },
  TAY: {
    overviewTitle: 'Giới thiệu về dân tộc Tày',
    overviewBody: 'Người Tày là một trong những cộng đồng dân tộc có dân số đông ở vùng trung du và miền núi phía Bắc. Đời sống văn hóa của người Tày gắn với nhà sàn, hát then, đàn tính, lễ hội Lồng Tồng và những nếp sinh hoạt cộng đồng bền chặt.',
    heroSubtitle: 'Người Tày sinh sống chủ yếu ở vùng Đông Bắc và trung du miền núi phía Bắc, nổi bật với hát then, đàn tính, nhà sàn và đời sống bản làng gắn bó với ruộng nước, thung lũng và sườn núi.',
    cultureTitle: 'Đặc trưng văn hóa',
    cultureBody: 'Bản sắc văn hóa Tày thể hiện rõ qua tiếng nói thuộc nhóm ngôn ngữ Tày - Thái, làn điệu then, lễ hội Lồng Tồng, trang phục chàm truyền thống và không gian nhà sàn gắn với sinh hoạt cộng đồng.',
    historyTitle: 'Lịch sử & nguồn gốc',
    historyBody: 'Người Tày có lịch sử cư trú lâu đời ở các tỉnh miền núi phía Bắc như Cao Bằng, Lạng Sơn, Bắc Kạn, Thái Nguyên, Tuyên Quang và Hà Giang. Trong quá trình sinh sống, cộng đồng đã hình thành tri thức bản địa phong phú về canh tác ruộng nước, cư trú ven thung lũng và tổ chức đời sống bản làng.',
    architectureTitle: 'Không gian sống',
    architectureBody: 'Không gian sống của người Tày gắn với các bản làng ven suối, chân núi và thung lũng. Nhà sàn là hình thức cư trú tiêu biểu, vừa thích ứng với điều kiện tự nhiên vừa phản ánh nếp sống gia đình và cộng đồng.',
    musicTitle: 'Âm thanh & nghệ thuật trình diễn',
    musicBody: 'Hát then và tiếng đàn tính là những biểu tượng nổi bật trong đời sống tinh thần của người Tày. Các làn điệu dân ca, nghi lễ và trình diễn dân gian góp phần lưu giữ ký ức cộng đồng qua nhiều thế hệ.',
    populationLabel: 'Cộng đồng đông dân ở miền núi phía Bắc',
    heroBackgroundAlt: 'Không gian bản làng của người Tày ở vùng núi phía Bắc',
    heroForegroundAlt: 'Hình ảnh đại diện văn hóa dân tộc Tày',
    introImageAlt: 'Sinh hoạt văn hóa của người Tày',
    featureHighlightAlt: 'Nét văn hóa tiêu biểu của người Tày',
    musicImageAlt: 'Âm nhạc và nghệ thuật trình diễn của người Tày',
    architectureImageAlt: 'Nhà sàn và không gian sống của người Tày',
  },
  HMONG: {
    overviewTitle: 'Giới thiệu về dân tộc H’Mông',
    overviewBody: 'Người H’Mông sinh sống chủ yếu ở các vùng núi cao phía Bắc. Bản sắc văn hóa của cộng đồng thể hiện qua nghề dệt lanh, trang phục rực rỡ, khèn Mông, chợ phiên và các lễ tục gắn với vòng đời, mùa vụ và cộng đồng bản làng.',
    heroSubtitle: 'Người H’Mông cư trú nhiều ở các tỉnh núi cao phía Bắc, nổi bật với khèn Mông, nghề dệt lanh, chợ phiên và những thực hành văn hóa gắn với núi rừng.',
    cultureBody: 'Đời sống văn hóa H’Mông gắn với tiếng khèn, nghề dệt lanh, kỹ thuật in sáp ong trên vải, chợ vùng cao và hệ thống lễ nghi phản ánh mối quan hệ chặt chẽ giữa con người với núi rừng.',
    architectureBody: 'Người H’Mông thường cư trú tại các vùng núi cao, nhà ở bố trí theo địa hình sườn núi hoặc triền dốc, phản ánh kinh nghiệm thích nghi lâu đời với điều kiện tự nhiên.',
    musicBody: 'Khèn Mông là nhạc cụ tiêu biểu trong đời sống tinh thần của người H’Mông, xuất hiện trong lễ hội, giao duyên và nhiều nghi lễ cộng đồng.',
    populationLabel: 'Cộng đồng cư trú ở vùng núi cao phía Bắc',
    heroBackgroundAlt: 'Không gian sống của người H’Mông ở vùng núi cao',
    heroForegroundAlt: 'Hình ảnh đại diện văn hóa dân tộc H’Mông',
    introImageAlt: 'Đời sống văn hóa của người H’Mông',
    featureHighlightAlt: 'Nét văn hóa tiêu biểu của người H’Mông',
    musicImageAlt: 'Khèn và nghệ thuật trình diễn của người H’Mông',
    architectureImageAlt: 'Không gian sống vùng cao của người H’Mông',
  },
  DAO: {
    overviewTitle: 'Giới thiệu về dân tộc Dao',
    overviewBody: 'Người Dao sinh sống ở nhiều tỉnh miền núi phía Bắc, nổi bật với trang phục thêu hoa văn tinh xảo, lễ cấp sắc, tri thức dân gian và kho tàng văn hóa gắn với đời sống cộng đồng.',
    heroSubtitle: 'Người Dao được biết đến với lễ cấp sắc, trang phục truyền thống, tri thức bản địa phong phú và đời sống văn hóa đậm bản sắc ở các vùng núi phía Bắc.',
    cultureBody: 'Bản sắc văn hóa Dao thể hiện qua lễ cấp sắc, nghề thêu may trang phục, nghi lễ dân gian, chữ viết cổ và kho tri thức bản địa về đời sống, chữa bệnh, cư trú và canh tác.',
    architectureBody: 'Không gian sống của người Dao phân bố theo các sườn núi, thung lũng và vùng đồi cao. Nhà ở phản ánh cách thích nghi với điều kiện địa hình và nếp sinh hoạt gia đình, dòng họ.',
    musicBody: 'Âm nhạc và trình diễn dân gian của người Dao gắn với nghi lễ, sinh hoạt cộng đồng và nhiều dịp lễ tục quan trọng trong năm.',
    populationLabel: 'Cộng đồng cư trú ở nhiều tỉnh miền núi phía Bắc',
    heroBackgroundAlt: 'Không gian sống của người Dao',
    heroForegroundAlt: 'Hình ảnh đại diện văn hóa dân tộc Dao',
    introImageAlt: 'Sinh hoạt văn hóa của người Dao',
    featureHighlightAlt: 'Nét văn hóa tiêu biểu của người Dao',
    musicImageAlt: 'Âm nhạc và nghi lễ trình diễn của người Dao',
    architectureImageAlt: 'Không gian nhà ở và bản làng của người Dao',
  },
  KHMER: {
    overviewTitle: 'Giới thiệu về dân tộc Khmer',
    overviewBody: 'Người Khmer sinh sống tập trung ở Nam Bộ, đặc biệt tại đồng bằng sông Cửu Long. Bản sắc văn hóa của cộng đồng gắn với chùa Khmer, nghệ thuật sân khấu, lễ hội truyền thống và đời sống nông nghiệp vùng sông nước.',
    heroSubtitle: 'Người Khmer Nam Bộ nổi bật với hệ thống chùa Khmer, lễ hội truyền thống, nghệ thuật trình diễn và đời sống văn hóa gắn với đồng bằng sông Cửu Long.',
    cultureBody: 'Đời sống văn hóa Khmer thể hiện qua kiến trúc chùa, lễ hội như Chol Chnam Thmay, Ok Om Bok, nghệ thuật múa, nhạc ngũ âm và những tập quán sinh hoạt cộng đồng ở vùng Nam Bộ.',
    architectureBody: 'Không gian sống của người Khmer gắn với đồng bằng, kênh rạch, phum sóc và hệ thống chùa chiền - nơi vừa là trung tâm tín ngưỡng vừa là không gian văn hóa cộng đồng.',
    musicBody: 'Âm nhạc và nghệ thuật trình diễn Khmer nổi bật với dàn nhạc ngũ âm, múa dân gian, sân khấu truyền thống và các tiết mục gắn với lễ hội cộng đồng.',
    populationLabel: 'Cộng đồng tiêu biểu của vùng Nam Bộ',
    heroBackgroundAlt: 'Không gian văn hóa Khmer Nam Bộ',
    heroForegroundAlt: 'Hình ảnh đại diện văn hóa dân tộc Khmer',
    introImageAlt: 'Sinh hoạt văn hóa của người Khmer',
    featureHighlightAlt: 'Nét văn hóa tiêu biểu của người Khmer',
    musicImageAlt: 'Âm nhạc và nghệ thuật trình diễn của người Khmer',
    architectureImageAlt: 'Phum sóc và chùa Khmer Nam Bộ',
  },
  CHAM: {
    overviewTitle: 'Giới thiệu về dân tộc Chăm',
    overviewBody: 'Người Chăm sinh sống chủ yếu ở khu vực Nam Trung Bộ. Bản sắc văn hóa Chăm nổi bật qua hệ thống tháp Chăm, nghề gốm, dệt thổ cẩm, lễ hội Katê và đời sống cộng đồng gắn với truyền thống lâu đời.',
    heroSubtitle: 'Người Chăm nổi bật với di sản tháp Chăm, lễ hội Katê, nghề gốm, dệt thổ cẩm và những sinh hoạt văn hóa đặc sắc ở vùng Nam Trung Bộ.',
    cultureBody: 'Văn hóa Chăm thể hiện qua tín ngưỡng, kiến trúc tháp, lễ hội Katê, nghề gốm Bàu Trúc, dệt Mỹ Nghiệp và những thực hành cộng đồng được lưu giữ qua nhiều thế hệ.',
    architectureBody: 'Không gian sống của người Chăm gắn với các làng nghề, khu dân cư ở Nam Trung Bộ và hệ thống di tích tháp Chăm phản ánh chiều sâu lịch sử - văn hóa của cộng đồng.',
    musicBody: 'Âm nhạc và trình diễn dân gian của người Chăm gắn liền với lễ hội, nhạc cụ truyền thống và đời sống tín ngưỡng cộng đồng.',
    populationLabel: 'Cộng đồng giàu di sản ở Nam Trung Bộ',
    heroBackgroundAlt: 'Không gian văn hóa Chăm ở Nam Trung Bộ',
    heroForegroundAlt: 'Hình ảnh đại diện văn hóa dân tộc Chăm',
    introImageAlt: 'Sinh hoạt văn hóa của người Chăm',
    featureHighlightAlt: 'Nét văn hóa tiêu biểu của người Chăm',
    musicImageAlt: 'Âm nhạc và nghệ thuật trình diễn của người Chăm',
    architectureImageAlt: 'Không gian di sản và cư trú của người Chăm',
  },
}

function getEthnicityDetailOverride(code) {
  if (!code) return null
  return ETHNICITY_DETAIL_OVERRIDES[String(code).toUpperCase()] || null
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
    category: mapText(row, 'CategoryTenVI', 'CategoryTenEN', lang) || null,
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
    title: `Bước ${index + 1}`,
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
      code: item.MaBaiViet,
      title: mapText(item, 'TieuDeVI', 'TieuDeEN', lang),
      imageUrl: item.ImageUrl || null,
      imageAlt: mapText(item, 'AltTextVI', 'AltTextEN', lang) || mapText(item, 'TieuDeVI', 'TieuDeEN', lang),
    }))

  return {
    id: row.MaBaiViet,
    code: row.MaBaiViet,
    name: title,
    region,
    categoryLabel: 'Ẩm thực',
    subtitle,
    heroImageUrl: mainImage,
    heroImageAlt: mainAlt,
    stats: {
      prepTime: 'Đang cập nhật',
      difficulty: 'Đang cập nhật',
      calories: 'Đang cập nhật',
    },
    intro: {
      badge: 'Hương vị truyền thống',
      title: mapText(row, 'TieuDeVI', 'TieuDeEN', lang),
      paragraphs: introText ? [introText, originText].filter(Boolean) : [originText].filter(Boolean),
      imageUrl: mainImage,
      imageAlt: mainAlt,
    },
    ingredients: {
      badge: 'Nguyên liệu chọn lọc',
      title: 'Tinh hoa đất trời trên mâm',
      subtitle: subtitle || introText,
      images: mediaImages.slice(0, 3).map((item) => item.imageUrl),
      summary: originText,
    },
    recipeSteps: steps,
    howToEnjoy: {
      badge: 'Nghệ thuật ẩm thực',
      title: 'Cách thưởng thức',
      body: meaningText || contextText,
      imageUrl: mediaImages[1]?.imageUrl || mainImage,
      imageAlt: mediaImages[1]?.imageAlt || mainAlt,
    },
    secretTip: {
      badge: 'Góc ẩm thực',
      title: 'Bí quyết nấu ngon',
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
  const overviewDetails = parseLocalizedJson(row, 'OverviewDetailsJsonVI', 'OverviewDetailsJsonEN', lang, [])

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
    overviewTitle: mapText(row, 'OverviewTitleVI', 'OverviewTitleEN', lang) || title,
    overviewDescription: mapText(row, 'OverviewDescriptionVI', 'OverviewDescriptionEN', lang) || description,
    overviewDetails,
  }
}

async function listArticles(filters, lang) {
  const rows = await contentRepository.getArticles(filters)
  return rows.map((row) => mapArticleCard(row, lang))
}

function splitParagraphs(value) {
  return String(value || '')
    .split(/\n+/)
    .map((line) => line.trim())
    .filter(Boolean)
}

function mapArticleMedia(row, lang) {
  return {
    id: row.MediaID,
    code: row.MaBaiViet,
    type: row.LoaiMedia,
    url: row.UrlFile,
    alt: mapText(row, 'AltTextVI', 'AltTextEN', lang),
    caption: mapText(row, 'ChuThichVI', 'ChuThichEN', lang),
    isMain: Boolean(row.LaAnhChinh),
    order: row.ThuTuHienThi || 0,
  }
}

function formatArticleDate(value, lang) {
  if (!value) return lang === 'vi' ? 'Mới đây' : 'Recently'
  const date = new Date(value)
  if (Number.isNaN(date.getTime())) return value
  return date.toLocaleDateString(lang === 'vi' ? 'vi-VN' : 'en-US', {
    month: 'long',
    day: 'numeric',
    year: 'numeric',
  })
}

function estimateReadingTime(text, lang) {
  const wordCount = String(text || '').trim().split(/\s+/).filter(Boolean).length
  const minutes = Math.max(4, Math.round(wordCount / 180) || 4)
  return lang === 'vi' ? `${minutes} phút đọc` : `${minutes} min read`
}

function getArticleAuthorMeta(code, lang) {
  const authors = {
    BV_SON_MAI: {
      vi: { name: 'Trần Minh Khoa', role: 'Chuyên gia nghệ thuật', initials: 'TK' },
      en: { name: 'Tran Minh Khoa', role: 'Art specialist', initials: 'TK' },
    },
    BV_TRANH_DONG_HO: {
      vi: { name: 'Nguyễn Hương Lan', role: 'Nhà nghiên cứu dân gian', initials: 'NL' },
      en: { name: 'Nguyen Huong Lan', role: 'Folk culture researcher', initials: 'NL' },
    },
    BV_GOM_BAT_TRANG: {
      vi: { name: 'Phạm Đức Thành', role: 'Nhà nghiên cứu thủ công', initials: 'PT' },
      en: { name: 'Pham Duc Thanh', role: 'Craft heritage researcher', initials: 'PT' },
    },
    BV_LUA_HA_DONG: {
      vi: { name: 'Lê Thị Thu Hà', role: 'Biên tập viên văn hóa', initials: 'LH' },
      en: { name: 'Le Thi Thu Ha', role: 'Culture editor', initials: 'LH' },
    },
    BV_AO_DAI: {
      vi: { name: 'Vũ Minh Châu', role: 'Chuyên gia trang phục', initials: 'VC' },
      en: { name: 'Vu Minh Chau', role: 'Costume specialist', initials: 'VC' },
    },
    BV_NHA_NHAC_CUNG_DINH: {
      vi: { name: 'Hoàng Văn Bình', role: 'Nhà nghiên cứu âm nhạc', initials: 'HB' },
      en: { name: 'Hoang Van Binh', role: 'Music researcher', initials: 'HB' },
    },
    BV_MUA_ROI_NUOC: {
      vi: { name: 'Nguyễn Quang Hải', role: 'Nhà nghiên cứu sân khấu dân gian', initials: 'NH' },
      en: { name: 'Nguyen Quang Hai', role: 'Folk theatre researcher', initials: 'NH' },
    },
    BV_KIEN_TRUC_HOI_AN: {
      vi: { name: 'Trương Thị Mai', role: 'Nhà nghiên cứu kiến trúc', initials: 'TM' },
      en: { name: 'Truong Thi Mai', role: 'Architecture researcher', initials: 'TM' },
    },
  }

  const meta = authors[code]?.[lang === 'vi' ? 'vi' : 'en'] || {
    name: lang === 'vi' ? 'Biên tập văn hoá' : 'Cultural editorial',
    role: lang === 'vi' ? 'Bài viết được xây dựng từ dữ liệu CSDL' : 'Article built from database content',
    initials: 'VH',
  }

  return {
    ...meta,
    bio: lang === 'vi'
      ? 'Nội dung biên soạn từ dữ liệu nghệ thuật dân gian, được đồng bộ trực tiếp từ CSDL.'
      : 'Content compiled from folk-art records synchronized directly from the database.',
    stats: { posts: '—', followers: '—', comments: '—' },
    email: 'content@vnculturebridge.ai',
    website: 'vnculturebridge.ai',
  }
}

function mapArticleDetail(row, mediaRows, relatedRows, lang) {
  if (!row) return null

  const title = mapText(row, 'TieuDeVI', 'TieuDeEN', lang)
  const category = mapText(row, 'CategoryTenVI', 'CategoryTenEN', lang) || (lang === 'vi' ? 'Nghệ thuật dân gian' : 'Folk arts')
  const heroMedia = mediaRows.find((item) => item.isMain) || mediaRows[0] || null
  const bodySections = splitParagraphs(mapText(row, 'NoiDungChinhVI', 'NoiDungChinhEN', lang))
  const intro = mapText(row, 'GioiThieuVI', 'GioiThieuEN', lang)
  const origin = mapText(row, 'NguonGocVI', 'NguonGocEN', lang)
  const meaning = mapText(row, 'YNghiaVanHoaVI', 'YNghiaVanHoaEN', lang)
  const context = mapText(row, 'BoiCanhVI', 'BoiCanhEN', lang)
  const quoteText = meaning || intro || bodySections[0] || ''
  const sideImages = mediaRows.filter((item) => !item.isMain).map((item) => item.url)
  const contentBody = mapText(row, 'NoiDungChinhVI', 'NoiDungChinhEN', lang)

  return {
    id: row.BaiVietID,
    code: row.MaBaiViet,
    title,
    category,
    author: getArticleAuthorMeta(row.MaBaiViet, lang),
    publishedAt: formatArticleDate(row.NgayXuatBan, lang),
    readingTime: estimateReadingTime(contentBody, lang),
    heroImage: heroMedia?.url || row.ImageUrl || null,
    heroImageAlt: heroMedia?.alt || mapText(row, 'AltTextVI', 'AltTextEN', lang) || title,
    intro: intro || mapText(row, 'MoTaNganVI', 'MoTaNganEN', lang),
    quote: {
      text: quoteText,
      author: lang === 'vi' ? 'Tư liệu văn hóa Việt Nam' : 'Vietnamese cultural archive',
    },
    sections: [
      {
        id: 'origin',
        title: lang === 'vi' ? 'Nguồn Gốc & Lịch Sử' : 'Origin & History',
        paragraphs: [origin].filter(Boolean),
      },
      {
        id: 'meaning',
        title: lang === 'vi' ? 'Ý Nghĩa Văn Hóa' : 'Cultural Meaning',
        paragraphs: [meaning, context].filter(Boolean),
      },
      {
        id: 'content',
        title: lang === 'vi' ? 'Nội Dung Chính' : 'Main Content',
        paragraphs: bodySections.filter(Boolean),
      },
    ].filter((section) => section.paragraphs.length > 0),
    techniques: bodySections.slice(0, 4).map((paragraph, index) => ({
      id: String(index + 1).padStart(2, '0'),
      title: lang === 'vi' ? `Điểm nhấn ${index + 1}` : `Highlight ${index + 1}`,
      desc: paragraph,
      icon: ['🎨', '✨', '🪵', '🏺'][index % 4],
    })),
    sideImages,
    conclusion: bodySections[bodySections.length - 1] || meaning || context || '',
    tags: [category],
    relatedArticles: relatedRows.map((item) => ({
      title: mapText(item, 'TieuDeVI', 'TieuDeEN', lang),
      date: formatArticleDate(item.NgayXuatBan, lang),
      category: mapText(item, 'CategoryTenVI', 'CategoryTenEN', lang) || category,
      image: item.ImageUrl || null,
      code: item.MaBaiViet,
    })),
    media: mediaRows,
  }
}

async function getArticle(code, lang) {
  const row = await contentRepository.getArticleByCode(code)
  if (!row) return null

  const [mediaRows, relatedRows] = await Promise.all([
    contentRepository.getArticleMedia(code),
    contentRepository.getArticleRelated(code, row.MaDanhMuc || null, 3),
  ])

  return mapArticleDetail(row, mediaRows.map((item) => mapArticleMedia(item, lang)), relatedRows, lang)
}

async function getArticle(code, lang) {
  const row = await contentRepository.getArticleByCode(code)
  if (!row) return null

  const [mediaRows, relatedRows] = await Promise.all([
    contentRepository.getArticleMedia(code),
    contentRepository.getArticleRelated(code, row.MaDanhMuc || null, 3),
  ])

  return mapArticleDetail(row, mediaRows.map((item) => mapArticleMedia(item, lang)), relatedRows, lang)
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
    contentRepository.getCuisineArticles(filters?.limit || 100),
    contentRepository.getCuisineGalleryMedia(12),
  ])

  const cards = rows.map((row) => mapCuisineCard(row, lang))
  const regions = [...new Set(cards.map((item) => item.region).filter(Boolean))]
  const heroCuisines = [...new Set(cards.map((item) => item.name).filter(Boolean))]
  const heroRow = rows[0] || null
  const heroSubtitle = mapText(heroRow, 'MoTaNganVI', 'MoTaNganEN', lang)
  const curatedFeatures = []
  const usedFeatureRegions = new Set()

  for (const row of rows) {
    const region = resolveRegionName(row.RegionCode, lang, mapText(row, 'RegionNameVI', 'RegionNameEN', lang)) || ''
    const regionKey = row.RegionCode || region || row.BaiVietID
    if (!usedFeatureRegions.has(regionKey)) {
      usedFeatureRegions.add(regionKey)
      curatedFeatures.push(row)
    }
    if (curatedFeatures.length === 3) break
  }

  const featureSource = curatedFeatures.length ? curatedFeatures : rows.slice(0, 3)
  const storySource = rows.filter((row) => !featureSource.includes(row)).slice(0, 3)

  return {
    hero: {
      badge: 'Khám phá ẩm thực 3 miền',
      titleLine1: 'Tinh Hoa',
      titleAccent: 'Ẩm Thực',
      titleLine3: 'Việt Nam',
      subtitle: heroSubtitle || 'Khám phá những món ăn tiêu biểu được lưu giữ và kể lại từ dữ liệu văn hóa Việt Nam.',
      stats: [
        { value: String(regions.length || 0), label: 'Vùng miền' },
        { value: String(cards.length || 0), label: 'Món ăn' },
        { value: String(rows.length || 0), label: 'Bài viết' },
      ],
      heroImageUrl: heroRow?.ImageUrl || null,
      heroImageAlt: mapText(heroRow, 'AltTextVI', 'AltTextEN', lang) || mapText(heroRow, 'TieuDeVI', 'TieuDeEN', lang) || '',
    },
    regions: ['Tất cả vùng', ...regions],
    heroCuisines: ['Tất cả món', ...heroCuisines],
    cards,
    features: featureSource.map((row, index) => ({
      id: row.BaiVietID || index + 1,
      title: mapText(row, 'TieuDeVI', 'TieuDeEN', lang),
      imgUrl: row.ImageUrl || null,
      tag: resolveRegionName(row.RegionCode, lang, mapText(row, 'RegionNameVI', 'RegionNameEN', lang)) || mapText(row, 'MoTaNganVI', 'MoTaNganEN', lang) || '',
      desc: mapText(row, 'GioiThieuVI', 'GioiThieuEN', lang) || mapText(row, 'YNghiaVanHoaVI', 'YNghiaVanHoaEN', lang) || mapText(row, 'MoTaNganVI', 'MoTaNganEN', lang) || '',
    })),
    stories: storySource.map((row, index) => ({
      id: row.BaiVietID || index + 1,
      title: mapText(row, 'TieuDeVI', 'TieuDeEN', lang),
      desc: mapText(row, 'TomTatChoAIVI', 'TomTatChoAIEN', lang) || mapText(row, 'GioiThieuVI', 'GioiThieuEN', lang) || mapText(row, 'YNghiaVanHoaVI', 'YNghiaVanHoaEN', lang) || '',
      imgUrl: row.ImageUrl || null,
      code: row.MaBaiViet,
    })),
    gallery: galleryRows.map((row, index) => {
      const item = mapCuisineMediaItem(row, lang, ['large', 'small', 'small', 'tall', 'small', 'wide'][index % 6] || 'small')
      return {
        ...item,
        imgUrl: item.imageUrl,
      }
    }),
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
  const override = getEthnicityDetailOverride(row.MaDanToc)
  const firstFestival = festivals[0] || null
  const firstCuisine = cuisine[0] || null
  const firstTextile = textiles[0] || null
  const ethnicityName = card.name || 'cộng đồng dân tộc Việt Nam'
  const regionText = primaryRegion || 'nhiều vùng văn hóa Việt Nam'
  const descriptionVi = fixText(row.MoTaVI) || ''
  const heroSubtitleVi = fixText(row.HeroSubtitleVI) || ''
  const overviewTitleVi = fixText(row.OverviewTitleVI) || ''
  const overviewBodyVi = fixText(row.OverviewBodyVI) || ''
  const historyTitleVi = fixText(row.HistoryTitleVI) || ''
  const historyBodyVi = fixText(row.HistoryBodyVI) || ''
  const cultureTitleVi = fixText(row.CultureTitleVI) || ''
  const cultureBodyVi = fixText(row.CultureBodyVI) || ''
  const architectureTitleVi = fixText(row.ArchitectureTitleVI) || ''
  const architectureBodyVi = fixText(row.ArchitectureBodyVI) || ''
  const populationLabelVi = fixText(row.PopulationLabelVI) || ''
  const introAltVi = fixText(row.IntroImageAltVI) || ''
  const heroBgAltVi = fixText(row.HeroBackgroundAltVI) || ''
  const heroFgAltVi = fixText(row.HeroForegroundAltVI) || ''
  const featureAltVi = fixText(row.FeatureHighlightAltVI) || ''
  const architectureAltVi = fixText(row.ArchitectureImageAltVI) || ''
  const musicAltVi = fixText(row.MusicImageAltVI) || ''
  const overviewFallback = override?.overviewBody || descriptionVi || `${ethnicityName} là một cộng đồng dân tộc có bản sắc văn hóa riêng, gắn với đời sống sinh hoạt, ký ức cộng đồng và tri thức bản địa được lưu truyền qua nhiều thế hệ.`
  const heroSubtitle = override?.heroSubtitle || heroSubtitleVi || descriptionVi || `${ethnicityName} là một trong những cộng đồng dân tộc góp phần làm nên sự phong phú của văn hóa Việt Nam, với đời sống gắn bó cùng ${regionText}.`
  const overviewTitle = override?.overviewTitle || overviewTitleVi || `Giới thiệu về ${ethnicityName}`
  const historyTitle = override?.historyTitle || historyTitleVi || 'Lịch sử & nguồn gốc'
  const historyContent = override?.historyBody || historyBodyVi || `${ethnicityName} có lịch sử cư trú lâu đời tại ${regionText}, hình thành nên bản sắc riêng qua quá trình thích nghi với môi trường sống, lao động sản xuất và giao lưu văn hóa.`
  const cultureTitle = override?.cultureTitle || cultureTitleVi || 'Đặc trưng văn hóa'
  const cultureContent = override?.cultureBody || cultureBodyVi || firstTextile?.MoTaVI || firstFestival?.MoTaVI || `${ethnicityName} nổi bật với các thực hành văn hóa gắn với ngôn ngữ, trang phục, lễ nghi, tri thức dân gian và sinh hoạt cộng đồng được gìn giữ qua nhiều thế hệ.`
  const architectureTitle = override?.architectureTitle || architectureTitleVi || 'Không gian sống'
  const architectureContent = override?.architectureBody || architectureBodyVi || `${ethnicityName} thường cư trú tại ${regionText}, nơi không gian sống phản ánh rõ điều kiện tự nhiên, tập quán sinh hoạt gia đình và cách tổ chức cộng đồng.`
  const musicTitle = override?.musicTitle || (lang === 'vi' ? 'Âm thanh & nghệ thuật trình diễn' : 'Music & Performing Arts')
  const musicContent = override?.musicBody || cultureBodyVi || firstFestival?.MoTaVI || `Âm nhạc và nghệ thuật trình diễn của ${ethnicityName} gắn liền với lễ hội, sinh hoạt cộng đồng và đời sống tinh thần của người dân.`
  const populationLabel = override?.populationLabel || populationLabelVi || mapText(row, 'PopulationLabelVI', 'PopulationLabelEN', lang) || String(card.articleCount || 0)
  const heroBackgroundAlt = override?.heroBackgroundAlt || heroBgAltVi || mapText(row, 'HeroBackgroundAltVI', 'HeroBackgroundAltEN', lang) || `Không gian văn hóa của ${ethnicityName}`
  const heroForegroundAlt = override?.heroForegroundAlt || heroFgAltVi || mapText(row, 'HeroForegroundAltVI', 'HeroForegroundAltEN', lang) || `Chân dung đại diện của ${ethnicityName}`
  const introImageAlt = override?.introImageAlt || introAltVi || mapText(row, 'IntroImageAltVI', 'IntroImageAltEN', lang) || `Hình giới thiệu về ${ethnicityName}`
  const featureHighlightAlt = override?.featureHighlightAlt || featureAltVi || mapText(row, 'FeatureHighlightAltVI', 'FeatureHighlightAltEN', lang) || `Nét văn hóa tiêu biểu của ${ethnicityName}`
  const architectureImageAlt = override?.architectureImageAlt || architectureAltVi || mapText(row, 'ArchitectureImageAltVI', 'ArchitectureImageAltEN', lang) || `Không gian sống của ${ethnicityName}`
  const musicImageAlt = override?.musicImageAlt || musicAltVi || mapText(row, 'MusicImageAltVI', 'MusicImageAltEN', lang) || `Âm nhạc và nghệ thuật trình diễn của ${ethnicityName}`
  const cuisineFallbackTitle = firstCuisine?.TieuDeVI || ''
  const cuisineFallbackDescription = firstCuisine?.MoTaVI || ''
  const cuisineFallbackTag = firstCuisine?.TagVI || ''
  const cuisineFallbackImage = firstCuisine?.ImageUrl || row.CardImageUrl || null
  const cuisineFallbackAlt = firstCuisine?.ImageAltVI || `Món ăn truyền thống của ${ethnicityName}`
  const festivalFallbackTitle = firstFestival?.TieuDeVI || ''
  const festivalFallbackDescription = firstFestival?.MoTaVI || ''
  const festivalFallbackTag = firstFestival?.TagVI || 'Lễ hội'
  const festivalFallbackImage = firstFestival?.ImageUrl || row.FeatureHighlightImageUrl || row.CardImageUrl || null
  const festivalFallbackAlt = firstFestival?.ImageAltVI || `Lễ hội truyền thống của ${ethnicityName}`
  const textileFallbackTitle = firstTextile?.TieuDeVI || 'Trang phục & thủ công truyền thống'
  const textileFallbackDescription = firstTextile?.MoTaVI || cultureContent
  const textileFallbackTag = firstTextile?.TagVI || 'Di sản'
  const textileFallbackImage = firstTextile?.ImageUrl || row.FeatureHighlightImageUrl || row.CardImageUrl || null
  const textileFallbackAlt = firstTextile?.ImageAltVI || featureHighlightAlt
  const fallbackFestivals = festivals.length ? festivals : (festivalFallbackImage ? [{
    DanTocSectionItemID: `${row.MaDanToc || 'ethnicity'}-festival-fallback`,
    TieuDeVI: festivalFallbackTitle || `Lễ hội của ${ethnicityName}`,
    MoTaVI: festivalFallbackDescription || `${ethnicityName} lưu giữ nhiều nghi lễ và lễ hội gắn với vòng đời, mùa vụ và đời sống cộng đồng.`,
    ImageUrl: festivalFallbackImage,
    ImageAltVI: festivalFallbackAlt,
    TagVI: festivalFallbackTag,
    LayoutSize: 'small',
    MaBaiViet: '',
    NgayXuatBan: null,
  }] : [])
  const fallbackCuisine = cuisine.length ? cuisine : (cuisineFallbackImage ? [{
    DanTocSectionItemID: `${row.MaDanToc || 'ethnicity'}-cuisine-fallback`,
    TieuDeVI: cuisineFallbackTitle || `Ẩm thực của ${ethnicityName}`,
    MoTaVI: cuisineFallbackDescription || `Ẩm thực của ${ethnicityName} phản ánh môi trường sống, tập quán canh tác và khẩu vị truyền thống của cộng đồng.`,
    ImageUrl: cuisineFallbackImage,
    ImageAltVI: cuisineFallbackAlt,
    TagVI: cuisineFallbackTag,
    LayoutSize: 'portrait',
    MaBaiViet: '',
    NgayXuatBan: null,
  }] : [])
  const fallbackTextiles = textiles.length ? textiles : (textileFallbackImage ? [{
    DanTocSectionItemID: `${row.MaDanToc || 'ethnicity'}-textile-fallback`,
    TieuDeVI: textileFallbackTitle,
    MoTaVI: textileFallbackDescription,
    ImageUrl: textileFallbackImage,
    ImageAltVI: textileFallbackAlt,
    TagVI: textileFallbackTag,
    LayoutSize: 'square',
    MaBaiViet: '',
    NgayXuatBan: null,
  }] : [])
  const fallbackGallery = gallery.length ? gallery : [festivalFallbackImage, textileFallbackImage, row.HeroBackgroundImageUrl, row.HeroForegroundImageUrl, row.CardImageUrl]
    .filter(Boolean)
    .map((imageUrl, index) => ({
      DanTocSectionItemID: `${row.MaDanToc || 'ethnicity'}-gallery-${index}`,
      ImageUrl: imageUrl,
      ImageAltVI: index === 0 ? festivalFallbackAlt : index === 1 ? textileFallbackAlt : `Hình ảnh văn hóa của ${ethnicityName}`,
      LayoutSize: index === 0 ? 'large' : 'small',
      MoTaVI: cultureContent,
      MaBaiViet: '',
    }))
  const fallbackRelatedArticles = relatedArticles.length ? relatedArticles : [{
    id: `${row.MaDanToc || 'ethnicity'}-article-fallback`,
    code: '',
    title: `Khám phá văn hóa ${ethnicityName}`,
    description: cultureContent,
    imageUrl: row.CardImageUrl || row.FeatureHighlightImageUrl || row.HeroForegroundImageUrl || null,
    imageAlt: `Hình minh họa về ${ethnicityName}`,
  }]

  const finalFestivals = fallbackFestivals
  const finalCuisine = fallbackCuisine
  const finalTextiles = fallbackTextiles
  const finalGallery = fallbackGallery
  const finalRelatedArticles = fallbackRelatedArticles
  const sparseSections = [
    ...(finalFestivals.length ? [] : ['festivals']),
    ...(finalCuisine.length ? [] : ['cuisine']),
    ...(arts.length ? [] : ['arts']),
    ...(finalGallery.length ? [] : ['gallery']),
  ]

  const hasGeneratedFallbackData = !festivals.length || !cuisine.length || !textiles.length || !gallery.length || !relatedArticles.length

  return {
    id: card.id,
    code: card.code,
    rawCode: row.MaDanToc,
    name: card.name,
    description: card.description,
    hero: {
      badge: lang === 'vi' ? 'Dân tộc Việt Nam' : 'Ethnic Cultures of Vietnam',
      title: card.name,
      subtitle: heroSubtitle,
      backgroundImageUrl: row.HeroBackgroundImageUrl || row.FeatureHighlightImageUrl || row.CardImageUrl || null,
      backgroundImageAlt: heroBackgroundAlt,
      foregroundImageUrl: row.HeroForegroundImageUrl || row.CardImageUrl || row.FeatureHighlightImageUrl || null,
      foregroundImageAlt: heroForegroundAlt,
      stats: [
        { value: populationLabel, label: lang === 'vi' ? 'Quy mô tư liệu' : 'Content scale' },
        { value: primaryRegion || (lang === 'vi' ? 'Đang cập nhật' : 'Updating'), label: lang === 'vi' ? 'Khu vực chính' : 'Primary region' },
      ],
    },
    overview: {
      title: overviewTitle,
      content: overviewBodyVi || overviewFallback,
      imageUrl: row.IntroImageUrl || row.HeroForegroundImageUrl || row.CardImageUrl || row.FeatureHighlightImageUrl || null,
      imageAlt: introImageAlt,
    },
    featureHighlight: {
      imageUrl: row.FeatureHighlightImageUrl || row.MusicImageUrl || row.CardImageUrl || textileFallbackImage || festivalFallbackImage || null,
      imageAlt: featureHighlightAlt,
    },
    sections: {
      history: {
        title: historyTitle,
        content: historyContent,
      },
      culture: {
        title: cultureTitle,
        content: cultureContent,
      },
      architecture: {
        title: architectureTitle,
        content: architectureContent,
        imageUrl: row.ArchitectureImageUrl || row.HeroBackgroundImageUrl || row.CardImageUrl || festivalFallbackImage || null,
        imageAlt: architectureImageAlt,
      },
      textiles: finalTextiles.map((item) => mapEthnicitySectionItem(item, lang, 'square')),
      festivals: finalFestivals.map((item) => mapEthnicitySectionItem(item, lang, 'small')),
      cuisine: finalCuisine.map((item) => mapEthnicitySectionItem(item, lang, 'portrait')),
      arts: arts.map((item) => mapEthnicitySectionItem(item, lang, 'small')),
      music: {
        title: musicTitle,
        content: musicContent,
        imageUrl: row.MusicImageUrl || row.FeatureHighlightImageUrl || row.CardImageUrl || textileFallbackImage || festivalFallbackImage || null,
        imageAlt: musicImageAlt,
      },
    },
    gallery: finalGallery.map((item) => mapEthnicitySectionItem(item, lang, item.LayoutSize || 'small')),
    relatedArticles: relatedArticles.length ? relatedArticles.map((item) => mapArticleCard(item, lang)) : finalRelatedArticles,
    meta: {
      articleCount: card.articleCount,
      primaryRegion,
      sparseSections,
      generatedFallbackData: hasGeneratedFallbackData,
      ethnicityOverrideApplied: Boolean(override),
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

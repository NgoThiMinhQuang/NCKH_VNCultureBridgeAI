import { useEffect, useMemo, useRef, useState } from 'react'
import { Link } from 'react-router-dom'
import PageHeader from '../../components/layout/PageHeader/PageHeader'
import Footer from '../../components/layout/Footer/Footer'
import { getHomepage } from '../../services/homepage.service'
import { searchArticles } from '../../services/content.service'
import './ArticlePage.css'
import heroBg from '../../assets/ruong-bac-thang.jpg'
import img2 from '../../assets/banner2.jpg'
import img3 from '../../assets/banner3.jpg'
import img4 from '../../assets/cham.jpg'
import img5 from '../../assets/dao.jpg'
import img6 from '../../assets/ede.jpg'
import img7 from '../../assets/hmong.jpg'
import img8 from '../../assets/khmer.jpg'
import img9 from '../../assets/muong.jpg'
import img10 from '../../assets/thai.jpg'

const ARTICLE_ORDER = [
  'BV_SON_MAI',
  'BV_TRANH_DONG_HO',
  'BV_GOM_BAT_TRANG',
  'BV_LUA_HA_DONG',
  'BV_AO_DAI',
  'BV_NHA_NHAC_CUNG_DINH',
  'BV_MUA_ROI_NUOC',
  'BV_KIEN_TRUC_HOI_AN',
]

const ARTICLE_META = {
  BV_SON_MAI: {
    categoryVi: 'Nghệ Thuật',
    categoryEn: 'Fine Arts',
    authorVi: 'Trần Minh Khoa',
    authorEn: 'Tran Minh Khoa',
    readVi: '10 phút đọc',
    readEn: '10 min read',
    image: img4,
    titleVi: 'Nghệ Thuật Sơn Mài: Tinh Hoa Hội Họa Việt Nam Nghìn Năm',
    titleEn: 'Lacquer Art: A Thousand-Year Pinnacle of Vietnamese Painting',
    descVi: 'Khám phá bí mật đằng sau những lớp sơn huyền ảo, nơi vật liệu tự nhiên và bàn tay nghệ nhân tạo nên kiệt tác trường tồn theo thời gian.',
    descEn: 'Discover the secrets behind mysterious lacquer layers, where natural materials and artisan hands create masterpieces that stand the test of time.',
  },
  BV_TRANH_DONG_HO: {
    categoryVi: 'Hội Họa',
    categoryEn: 'Painting',
    authorVi: 'Nguyễn Hương Lan',
    authorEn: 'Nguyen Huong Lan',
    readVi: '7 phút đọc',
    readEn: '7 min read',
    image: img5,
    titleVi: 'Tranh Đông Hồ: Nét Dân Gian Trong Từng Bức Khắc',
    titleEn: 'Dong Ho Painting: Folk Art in Every Wood Block',
    descVi: 'Từ giấy điệp óng ánh đến màu sắc thiên nhiên, tranh Đông Hồ là lời kể chuyện đời sống làng quê Việt Nam qua những bản khắc gỗ độc đáo.',
    descEn: 'From shimmering do paper to natural colors, Dong Ho paintings narrate Vietnamese village life through unique woodblock prints.',
  },
  BV_GOM_BAT_TRANG: {
    categoryVi: 'Thủ Công',
    categoryEn: 'Crafts',
    authorVi: 'Phạm Đức Thành',
    authorEn: 'Pham Duc Thanh',
    readVi: '8 phút đọc',
    readEn: '8 min read',
    image: img6,
    titleVi: 'Gốm Bát Tràng: Di Sản 500 Năm Bên Dòng Sông Hồng',
    titleEn: 'Bat Trang Pottery: 500-Year Heritage on Red River Bank',
    descVi: 'Làng gốm cổ nhất Việt Nam vẫn giữ nguyên bí quyết nung đất sét trắng làm nên những sản phẩm tinh xảo nổi tiếng khắp thế giới.',
    descEn: 'Vietnam\'s oldest pottery village still preserves the secret of firing white clay into exquisitely crafted products famous worldwide.',
  },
  BV_LUA_HA_DONG: {
    categoryVi: 'Dệt May',
    categoryEn: 'Textiles',
    authorVi: 'Lê Thị Thu Hà',
    authorEn: 'Le Thi Thu Ha',
    readVi: '6 phút đọc',
    readEn: '6 min read',
    image: img7,
    titleVi: 'Lụa Hà Đông: Tinh Hoa Bền Vững Qua Nghìn Năm',
    titleEn: 'Ha Dong Silk: Enduring Craft Through A Millennium',
    descVi: 'Những sợi lụa mỏng manh từ làng Vạn Phúc mang theo cả nghìn năm tri thức dệt lụa, tạo nên vẻ đẹp sang trọng không thể nhầm lẫn.',
    descEn: 'Delicate silk threads from Van Phuc village carry a thousand years of weaving knowledge, creating unmistakably elegant beauty.',
  },
  BV_AO_DAI: {
    categoryVi: 'Trang Phục',
    categoryEn: 'Costume',
    authorVi: 'Vũ Minh Châu',
    authorEn: 'Vu Minh Chau',
    readVi: '9 phút đọc',
    readEn: '9 min read',
    image: img8,
    titleVi: 'Áo Dài: Linh Hồn Của Người Phụ Nữ Việt Nam',
    titleEn: 'Ao Dai: The Soul of Vietnamese Women',
    descVi: 'Tà áo dài thanh lịch không chỉ là trang phục truyền thống mà còn là biểu tượng văn hóa, sự duyên dáng và bản sắc riêng của người Việt.',
    descEn: 'The elegant Ao Dai is not merely traditional attire but a cultural symbol of grace and the unique identity of Vietnamese people.',
  },
  BV_NHA_NHAC_CUNG_DINH: {
    categoryVi: 'Âm Nhạc',
    categoryEn: 'Music',
    authorVi: 'Hoàng Văn Bình',
    authorEn: 'Hoang Van Binh',
    readVi: '11 phút đọc',
    readEn: '11 min read',
    image: img9,
    titleVi: 'Nhã Nhạc Cung Đình Huế: Di Sản Âm Nhạc UNESCO',
    titleEn: 'Hue Royal Court Music: UNESCO Musical Heritage',
    descVi: 'Những giai điệu trang trọng từ cung đình Huế đã được UNESCO công nhận là di sản văn hóa phi vật thể, mang âm hưởng nghìn năm lịch sử.',
    descEn: 'The solemn melodies from Hue Imperial Palace have been recognized by UNESCO as intangible cultural heritage, resonating with a millennium of history.',
  },
  BV_MUA_ROI_NUOC: {
    categoryVi: 'Nghệ Thuật',
    categoryEn: 'Fine Arts',
    authorVi: 'Nguyễn Quang Hải',
    authorEn: 'Nguyen Quang Hai',
    readVi: '8 phút đọc',
    readEn: '8 min read',
    image: img10,
    titleVi: 'Múa Rối Nước: Nghệ Thuật Độc Đáo Trên Mặt Nước',
    titleEn: 'Water Puppetry: A Unique Art Form on the Water',
    descVi: 'Xuất phát từ đồng bằng sông Hồng, múa rối nước là hình thức biểu diễn nghệ thuật truyền thống duy nhất trên thế giới dùng mặt nước làm sân khấu.',
    descEn: 'Originating from the Red River Delta, water puppetry is the world\'s only traditional art form using the water surface as its stage.',
  },
  BV_KIEN_TRUC_HOI_AN: {
    categoryVi: 'Kiến Trúc',
    categoryEn: 'Architecture',
    authorVi: 'Trương Thị Mai',
    authorEn: 'Truong Thi Mai',
    readVi: '12 phút đọc',
    readEn: '12 min read',
    image: img2,
    titleVi: 'Kiến Trúc Hội An: Giao Thoa Văn Hóa Đông-Tây',
    titleEn: 'Hoi An Architecture: East-West Cultural Fusion',
    descVi: 'Phố cổ Hội An là minh chứng sống động cho sự giao thoa văn hóa Việt-Hoa-Nhật-Pháp, tạo nên một di sản kiến trúc độc đáo không nơi nào có.',
    descEn: 'Hoi An Ancient Town is a vivid testament to the cultural fusion of Vietnamese-Chinese-Japanese-French, creating a unique architectural heritage found nowhere else.',
  },
}

const TITLE_TO_CODE = {
  'Nghệ Thuật Sơn Mài: Tinh Hoa Hội Họa Việt Nam Nghìn Năm': 'BV_SON_MAI',
  'Lacquer Art: A Thousand-Year Pinnacle of Vietnamese Painting': 'BV_SON_MAI',
  'Tranh Đông Hồ: Nét Dân Gian Trong Từng Bức Khắc': 'BV_TRANH_DONG_HO',
  'Dong Ho Painting: Folk Art in Every Wood Block': 'BV_TRANH_DONG_HO',
  'Gốm Bát Tràng: Di Sản 500 Năm Bên Dòng Sông Hồng': 'BV_GOM_BAT_TRANG',
  'Bat Trang Pottery: 500-Year Heritage on Red River Bank': 'BV_GOM_BAT_TRANG',
  'Lụa Hà Đông: Tinh Hoa Bền Vững Qua Nghìn Năm': 'BV_LUA_HA_DONG',
  'Ha Dong Silk: Enduring Craft Through A Millennium': 'BV_LUA_HA_DONG',
  'Áo dài Việt Nam': 'BV_AO_DAI',
  'Vietnamese Ao Dai': 'BV_AO_DAI',
  'Nhã Nhạc Cung Đình Huế: Di Sản Âm Nhạc UNESCO': 'BV_NHA_NHAC_CUNG_DINH',
  'Hue Royal Court Music: UNESCO Musical Heritage': 'BV_NHA_NHAC_CUNG_DINH',
  'Múa rối nước': 'BV_MUA_ROI_NUOC',
  'Water Puppetry': 'BV_MUA_ROI_NUOC',
  'Kiến Trúc Hội An: Giao Thoa Văn Hóa Đông-Tây': 'BV_KIEN_TRUC_HOI_AN',
  'Hoi An Architecture: East-West Cultural Fusion': 'BV_KIEN_TRUC_HOI_AN',
}

const DEFAULT_ART_LANDING = {
  hero: {
    badge: 'Văn hoá · Di sản · Nghệ thuật',
    titleLine1Vi: 'Nghệ Thuật',
    titleAccentVi: '& Di Sản',
    titleLine3Vi: 'Việt Nam',
    titleLine1En: 'Vietnamese',
    titleAccentEn: 'Arts & Heritage',
    titleLine3En: '',
    subtitleVi: 'Nơi truyền thống cổ xưa hòa quyện cùng biểu đạt hiện đại — mang theo câu chuyện ngàn năm trong từng nét vẽ, từng điệu múa.',
    subtitleEn: 'Where ancient traditions weave through modern expression — carrying stories of a thousand years in every brushstroke and dance.',
    imageUrl: heroBg,
    imageAltVi: 'Ruộng bậc thang Việt Nam',
    imageAltEn: 'Vietnamese rice terraces',
    imageBadgeVi: 'Ruộng bậc thang Tây Bắc',
    imageBadgeEn: 'Northwestern Terraces',
    imageBadgeIcon: '🏔️',
  },
  stats: [
    { value: '4.000+', labelVi: 'Năm lịch sử', labelEn: 'Years of history' },
    { value: '54', labelVi: 'Dân tộc anh em', labelEn: 'Ethnic groups' },
    { value: '8', labelVi: 'Di sản UNESCO', labelEn: 'UNESCO Heritages' },
  ],
  heritage: {
    titleVi: 'Khám Phá Di Sản',
    titleEn: 'Explore Our Heritage',
    subtitleVi: 'Khám phá vẻ đẹp vượt thời gian của tinh hoa thủ công Việt Nam',
    subtitleEn: 'Discover the timeless beauty of Vietnamese craftsmanship',
    cards: [
      { img: heroBg, titleVi: 'Nghệ Thuật Lụa', titleEn: 'Silk Art', subVi: 'Lụa Truyền Thống', subEn: 'Traditional Silk' },
      { img: img2, titleVi: 'Nghệ Thuật Gốm', titleEn: 'Pottery', subVi: 'Gốm Bát Tràng', subEn: 'Bat Trang Pottery' },
      { img: img3, titleVi: 'Tranh Dân Gian', titleEn: 'Traditional Painting', subVi: 'Tranh Dân Gian', subEn: 'Traditional Painting' },
      { img: img4, titleVi: 'Điêu Khắc', titleEn: 'Sculpture', subVi: 'Điêu Khắc', subEn: 'Sculpture' },
    ],
  },
  featuredArtwork: {
    badgeVi: 'TÁC PHẨM NỔI BẬT',
    badgeEn: 'FEATURED ARTWORK',
    titleVi: 'Nghệ thuật Sơn Mài',
    titleEn: 'The Art of Sơn Mài',
    bodyVi: [
      'Nghệ thuật sơn mài Việt Nam là một quá trình chế tác công phu đã được hoàn thiện qua nhiều thế kỷ. Mỗi tác phẩm đòi hỏi nhiều tháng tỉ mỉ sơn từng lớp, với sự khéo léo của nghệ nhân khi phủ lên đến 12 lớp nhựa từ cây sơn.',
      'Giữa các lớp, bề mặt được chà nhám và đánh bóng cẩn thận, tạo ra độ sâu và độ sáng rực rỡ như phát quang từ bên trong. Các sắc tố tự nhiên cùng vật liệu như vỏ trứng, vàng lá và bạc tạo ra hiệu ứng lấp lánh tinh tế khiến mỗi tác phẩm đều là độc nhất.',
    ],
    bodyEn: [
      'Vietnamese lacquer art, known as Sơn Mài, is a painstaking craft that has been perfected over centuries. Each piece requires months of meticulous layering, with artisans applying up to twelve coats of resin derived from the sơn tree.',
      'Between each layer, the surface is carefully sanded and polished, creating depth and luminosity that seems to glow from within. Natural pigments and materials like eggshell, gold leaf, and silver create the distinctive shimmer that makes each piece unique.',
    ],
    stats: [
      { value: '12+', labelVi: 'Lớp sơn mài', labelEn: 'Layers of lacquer' },
      { value: '3-6', labelVi: 'Tháng hoàn thiện', labelEn: 'Months to complete' },
      { value: '100+', labelVi: 'Năm truyền thống', labelEn: 'Years of tradition' },
    ],
    imageUrl: img4,
    imageAltVi: 'Sơn Mài Art',
    imageAltEn: 'Son Mai Art',
  },
  gallery: {
    titleVi: 'Thư Viện Ảnh',
    titleEn: 'Our Gallery',
    subtitleVi: 'Hành trình thị giác qua di sản nghệ thuật Việt Nam',
    subtitleEn: 'A visual journey through Vietnam\'s artistic legacy',
    images: [img5, img6, img7, img8, img9, img10],
  },
  story: {
    badgeVi: 'CÂU CHUYỆN CỦA CHÚNG TÔI',
    badgeEn: 'OUR STORY',
    titleVi: 'Sợi Chỉ Thời Gian, Dệt Bằng Tâm Hồn',
    titleEn: 'Threads of Time, Woven with Soul',
    bodyVi: [
      'Trong hơn một thiên niên kỷ, các nghệ nhân Việt Nam đã gìn giữ và nâng tầm nghề thủ công của mình, truyền lại các kỹ thuật qua nhiều thế hệ như những di vật quý giá. Từ những dải lụa tinh xảo của Hà Đông đến vẻ đẹp mộc mạc của gốm sứ Bát Tràng, mỗi truyền thống đều mang trong mình linh hồn của đất nước.',
      'Những bản khắc gỗ Đông Hồ rực rỡ kể những câu chuyện về sự thịnh vượng và may mắn, trong khi chiều sâu lung linh của các bức tranh sơn mài ghi lại những khoảnh khắc đóng băng trong thời gian. Những môn nghệ thuật này không chỉ đơn thuần là trang trí - chúng là chứng nhân sống động cho sự kiên cường, sáng tạo và tinh thần bền bỉ của Việt Nam.',
    ],
    bodyEn: [
      'For over a millennium, Vietnamese artisans have preserved and elevated their crafts, passing down techniques through generations like precious heirlooms. From the delicate silks of Hà Đông to the earthen beauty of Bat Trang ceramics, each tradition carries the soul of the land.',
      'The vibrant Đông Hồ woodblock prints tell stories of prosperity and luck, while the shimmering depths of lacquer paintings capture moments frozen in time. These arts are not merely decorative—they are living testimonies to resilience, creativity, and the enduring spirit of Vietnam.',
    ],
    features: [
      {
        color: '#b91c1c',
        titleVi: 'Bảo tồn di sản',
        titleEn: 'Heritage Preservation',
        textVi: 'Bảo vệ các kỹ thuật cổ xưa cho thế hệ tương lai',
        textEn: 'Protecting ancient techniques for future generations',
      },
      {
        color: '#f59e0b',
        titleVi: 'Biểu đạt đương đại',
        titleEn: 'Contemporary Expression',
        textVi: 'Kết hợp truyền thống với tầm nhìn nghệ thuật hiện đại',
        textEn: 'Blending tradition with modern artistic vision',
      },
      {
        color: '#10b981',
        titleVi: 'Kết nối văn hóa',
        titleEn: 'Cultural Connection',
        textVi: 'Chia sẻ di sản nghệ thuật của Việt Nam với thế giới',
        textEn: 'Sharing Vietnam\'s artistic legacy with the world',
      },
    ],
    images: [img3, img6, img2, img5],
  },
}

function formatPublishedDate(value, lang) {
  if (!value) return lang === 'vi' ? 'Mới đây' : 'Recently'
  const date = new Date(value)
  if (Number.isNaN(date.getTime())) return value
  return date.toLocaleDateString(lang === 'vi' ? 'vi-VN' : 'en-US', {
    month: 'long',
    day: 'numeric',
    year: 'numeric',
  })
}

function localizeLandingText(item, lang, viKey, enKey) {
  if (!item) return ''
  return lang === 'vi' ? item[viKey] || item[enKey] || '' : item[enKey] || item[viKey] || ''
}

function buildLanding(artLanding) {
  return {
    hero: artLanding?.hero || DEFAULT_ART_LANDING.hero,
    stats: artLanding?.stats?.length ? artLanding.stats : DEFAULT_ART_LANDING.stats,
    heritage: {
      titleVi: artLanding?.heritage?.title || DEFAULT_ART_LANDING.heritage.titleVi,
      titleEn: artLanding?.heritage?.title || DEFAULT_ART_LANDING.heritage.titleEn,
      subtitleVi: artLanding?.heritage?.subtitle || DEFAULT_ART_LANDING.heritage.subtitleVi,
      subtitleEn: artLanding?.heritage?.subtitle || DEFAULT_ART_LANDING.heritage.subtitleEn,
      cards: artLanding?.heritage?.cards?.length ? artLanding.heritage.cards : DEFAULT_ART_LANDING.heritage.cards,
    },
    featuredArtwork: {
      badgeVi: artLanding?.featuredArtwork?.badge || DEFAULT_ART_LANDING.featuredArtwork.badgeVi,
      badgeEn: artLanding?.featuredArtwork?.badge || DEFAULT_ART_LANDING.featuredArtwork.badgeEn,
      titleVi: artLanding?.featuredArtwork?.title || DEFAULT_ART_LANDING.featuredArtwork.titleVi,
      titleEn: artLanding?.featuredArtwork?.title || DEFAULT_ART_LANDING.featuredArtwork.titleEn,
      bodyVi: artLanding?.featuredArtwork?.body?.length ? artLanding.featuredArtwork.body : DEFAULT_ART_LANDING.featuredArtwork.bodyVi,
      bodyEn: artLanding?.featuredArtwork?.body?.length ? artLanding.featuredArtwork.body : DEFAULT_ART_LANDING.featuredArtwork.bodyEn,
      stats: artLanding?.featuredArtwork?.stats?.length ? artLanding.featuredArtwork.stats : DEFAULT_ART_LANDING.featuredArtwork.stats,
      imageUrl: artLanding?.featuredArtwork?.imageUrl || DEFAULT_ART_LANDING.featuredArtwork.imageUrl,
      imageAltVi: artLanding?.featuredArtwork?.imageAlt || DEFAULT_ART_LANDING.featuredArtwork.imageAltVi,
      imageAltEn: artLanding?.featuredArtwork?.imageAlt || DEFAULT_ART_LANDING.featuredArtwork.imageAltEn,
    },
    gallery: {
      titleVi: artLanding?.gallery?.title || DEFAULT_ART_LANDING.gallery.titleVi,
      titleEn: artLanding?.gallery?.title || DEFAULT_ART_LANDING.gallery.titleEn,
      subtitleVi: artLanding?.gallery?.subtitle || DEFAULT_ART_LANDING.gallery.subtitleVi,
      subtitleEn: artLanding?.gallery?.subtitle || DEFAULT_ART_LANDING.gallery.subtitleEn,
      images: artLanding?.gallery?.images?.length
        ? artLanding.gallery.images.map((item) => item.url || item.imageUrl || item)
        : DEFAULT_ART_LANDING.gallery.images,
    },
    story: {
      badgeVi: artLanding?.story?.badge || DEFAULT_ART_LANDING.story.badgeVi,
      badgeEn: artLanding?.story?.badge || DEFAULT_ART_LANDING.story.badgeEn,
      titleVi: artLanding?.story?.title || DEFAULT_ART_LANDING.story.titleVi,
      titleEn: artLanding?.story?.title || DEFAULT_ART_LANDING.story.titleEn,
      bodyVi: artLanding?.story?.body?.length ? artLanding.story.body : DEFAULT_ART_LANDING.story.bodyVi,
      bodyEn: artLanding?.story?.body?.length ? artLanding.story.body : DEFAULT_ART_LANDING.story.bodyEn,
      features: artLanding?.story?.features?.length ? artLanding.story.features : DEFAULT_ART_LANDING.story.features,
      images: artLanding?.story?.images?.length
        ? artLanding.story.images.map((item) => item.url || item.imageUrl || item)
        : DEFAULT_ART_LANDING.story.images,
    },
  }
}

function buildArticles(apiRows) {
  const rowsByCode = new Map()
  for (const row of apiRows) {
    const code = row.code || TITLE_TO_CODE[row.title]
    if (code) rowsByCode.set(code, row)
  }

  return ARTICLE_ORDER.map((code) => {
    const api = rowsByCode.get(code) || {}
    const meta = ARTICLE_META[code]
    return {
      code,
      titleVi: meta.titleVi,
      titleEn: meta.titleEn,
      categoryVi: meta.categoryVi,
      categoryEn: meta.categoryEn,
      authorVi: meta.authorVi,
      authorEn: meta.authorEn,
      readVi: meta.readVi,
      readEn: meta.readEn,
      dateVi: formatPublishedDate(api.publishedAt, 'vi'),
      dateEn: formatPublishedDate(api.publishedAt, 'en'),
      descVi: meta.descVi,
      descEn: meta.descEn,
      image: meta.image,
    }
  })
}

export default function ArticlePage() {
  const [lang, setLang] = useState('vi')
  const [activeCategory, setActiveCategory] = useState(lang === 'vi' ? 'Tất cả' : 'All')
  const [homepage, setHomepage] = useState(null)
  const articlesRef = useRef(null)

  useEffect(() => {
    let ignore = false

    async function loadData() {
      try {
        const [homepageData, articleData] = await Promise.all([
          getHomepage(lang),
          searchArticles({ lang, category: 'NGHE_THUAT_DAN_GIAN', limit: 50 }),
        ])
        if (!ignore) {
          setHomepage({
            ...homepageData,
            articleCards: Array.isArray(articleData) ? articleData : [],
          })
        }
      } catch {
        if (!ignore) setHomepage({ articleCards: [] })
      }
    }

    loadData()
    return () => { ignore = true }
  }, [lang])

  useEffect(() => {
    setActiveCategory(lang === 'vi' ? 'Tất cả' : 'All')
  }, [lang])

  const landing = useMemo(() => buildLanding(homepage?.artLanding || null), [homepage?.artLanding])
  const allArticles = useMemo(() => buildArticles(homepage?.articleCards || []), [homepage?.articleCards])
  const categories = useMemo(
    () => (lang === 'vi'
      ? ['Tất cả', 'Nghệ Thuật', 'Hội Họa', 'Thủ Công', 'Dệt May', 'Trang Phục', 'Âm Nhạc', 'Kiến Trúc']
      : ['All', 'Fine Arts', 'Painting', 'Crafts', 'Textiles', 'Costume', 'Music', 'Architecture']),
    [lang],
  )

  const filtered = useMemo(() => {
    const allLabel = lang === 'vi' ? 'Tất cả' : 'All'
    if (activeCategory === allLabel) return allArticles
    return allArticles.filter((article) => (lang === 'vi' ? article.categoryVi : article.categoryEn) === activeCategory)
  }, [activeCategory, allArticles, lang])

  const featured = filtered[0] || null
  const gridArticles = filtered.slice(1, 5)
  const heroLines = lang === 'vi'
    ? [landing.hero.titleLine1Vi, landing.hero.titleAccentVi, landing.hero.titleLine3Vi]
    : [landing.hero.titleLine1En, landing.hero.titleAccentEn, landing.hero.titleLine3En].filter(Boolean)

  const galleryColumns = [
    landing.gallery.images.slice(0, 2),
    landing.gallery.images.slice(2, 4),
    landing.gallery.images.slice(4, 6),
  ]

  return (
    <div className="page-shell">
      <PageHeader
        lang={lang}
        onLangChange={setLang}
        breadcrumb={[
          { label: lang === 'vi' ? 'Nghệ thuật & Di sản Việt Nam' : 'Vietnamese Arts & Heritage' },
        ]}
      />

      <main>
        <section className="article-hero">
          <div className="article-hero__bg" style={{ backgroundImage: `url(${landing.hero.imageUrl || heroBg})` }}></div>
          <div className="article-hero__overlay"></div>
          <div className="article-hero__ornament article-hero__ornament--tl"></div>
          <div className="article-hero__ornament article-hero__ornament--br"></div>

          <div className="article-hero__inner">
            <div className="article-hero__left fade-up">
              <div className="article-hero__badge">
                <span className="article-hero__badge-dot"></span>
                {landing.hero.badge || DEFAULT_ART_LANDING.hero.badge}
              </div>

              <h1 className="article-hero__title">
                {heroLines.map((line, index) => (
                  <span key={`${line}-${index}`} className={index === 1 ? 'article-hero__title-accent' : 'article-hero__title-line'}>{line}</span>
                ))}
              </h1>

              <div className="article-hero__divider-row">
                <span className="article-hero__divider-line"></span>
                <span className="article-hero__divider-diamond">◆</span>
                <span className="article-hero__divider-line"></span>
              </div>

              <p className="article-hero__subtitle">
                {landing.hero.subtitle || (lang === 'vi' ? DEFAULT_ART_LANDING.hero.subtitleVi : DEFAULT_ART_LANDING.hero.subtitleEn)}
              </p>

              <div className="article-hero__stats">
                {landing.stats.map((stat, index) => (
                  <div key={`${stat.value}-${index}`} className="article-hero__stat">
                    <strong>{stat.value}</strong>
                    <span>{localizeLandingText(stat, lang, 'labelVi', 'labelEn') || stat.label}</span>
                    {index < landing.stats.length - 1 ? <div className="article-hero__stat-sep">|</div> : null}
                  </div>
                ))}
              </div>
            </div>

            <div className="article-hero__right fade-up">
              <div className="article-hero__img-frame">
                <img src={landing.hero.imageUrl || heroBg} alt={landing.hero.imageAlt || (lang === 'vi' ? DEFAULT_ART_LANDING.hero.imageAltVi : DEFAULT_ART_LANDING.hero.imageAltEn)} className="article-hero__img-main" />
                <div className="article-hero__img-badge">
                  <span className="article-hero__img-badge-icon">{landing.hero.imageBadgeIcon || '🏔️'}</span>
                  <span>{landing.hero.imageBadge || (lang === 'vi' ? DEFAULT_ART_LANDING.hero.imageBadgeVi : DEFAULT_ART_LANDING.hero.imageBadgeEn)}</span>
                </div>
                <div className="article-hero__img-ring"></div>
              </div>
            </div>
          </div>

          <div className="article-hero__scroll">
            <div className="mouse-icon"></div>
          </div>
        </section>

        <section className="ap-articles-section" ref={articlesRef}>
          <div className="section-container">
            <div className="ap-articles__header fade-up">
              <h2 className="ap-articles__title">{lang === 'vi' ? 'Bài Viết Văn Hóa' : 'Cultural Articles'}</h2>
              <p className="ap-articles__subtitle">
                {lang === 'vi'
                  ? 'Khám phá kho tri thức phong phú về văn hóa, nghệ thuật và di sản Việt Nam'
                  : 'Explore a rich treasury of knowledge about Vietnamese culture, arts, and heritage'}
              </p>
            </div>

            <div className="ap-filter fade-up">
              {categories.map((cat) => (
                <button
                  key={cat}
                  className={`ap-filter__btn${activeCategory === cat ? ' active' : ''}`}
                  onClick={() => setActiveCategory(cat)}
                >
                  {cat}
                </button>
              ))}
            </div>

            {featured ? (
              <Link to={`/articles/${featured.code}`} className="ap-featured-card fade-up">
                <div className="ap-featured-card__img">
                  <img src={featured.image} alt={lang === 'vi' ? featured.titleVi : featured.titleEn} />
                  <span className="ap-featured-card__badge">{lang === 'vi' ? '✦ Nổi Bật' : '✦ Featured'}</span>
                </div>
                <div className="ap-featured-card__body">
                  <span className="ap-cat-tag">{lang === 'vi' ? featured.categoryVi : featured.categoryEn}</span>
                  <h3 className="ap-featured-card__title">{lang === 'vi' ? featured.titleVi : featured.titleEn}</h3>
                  <p className="ap-featured-card__desc">{lang === 'vi' ? featured.descVi : featured.descEn}</p>
                  <div className="ap-featured-card__meta">
                    <span className="ap-meta-author">
                      <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
                        <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2" />
                        <circle cx="12" cy="7" r="4" />
                      </svg>
                      {lang === 'vi' ? featured.authorVi : featured.authorEn}
                    </span>
                    <span className="ap-meta-dot">·</span>
                    <span>{lang === 'vi' ? featured.dateVi : featured.dateEn}</span>
                    <span className="ap-meta-dot">·</span>
                    <span>
                      <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" style={{ marginRight: '4px', verticalAlign: 'middle' }}>
                        <circle cx="12" cy="12" r="10" />
                        <polyline points="12 6 12 12 16 14" />
                      </svg>
                      {lang === 'vi' ? featured.readVi : featured.readEn}
                    </span>
                  </div>
                  <div className="ap-featured-card__cta">
                    {lang === 'vi' ? 'Đọc bài viết' : 'Read article'}
                    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
                      <path d="M5 12h14M12 5l7 7-7 7" />
                    </svg>
                  </div>
                </div>
              </Link>
            ) : null}

            <div className="ap-grid fade-up">
              {gridArticles.map((article) => (
                <Link to={`/articles/${article.code}`} key={article.code} className="ap-card">
                  <div className="ap-card__img">
                    <img src={article.image} alt={lang === 'vi' ? article.titleVi : article.titleEn} loading="lazy" />
                    <span className="ap-cat-tag ap-cat-tag--overlay">{lang === 'vi' ? article.categoryVi : article.categoryEn}</span>
                  </div>
                  <div className="ap-card__body">
                    <h3 className="ap-card__title">{lang === 'vi' ? article.titleVi : article.titleEn}</h3>
                    <p className="ap-card__desc">{lang === 'vi' ? article.descVi : article.descEn}</p>
                    <div className="ap-card__footer">
                      <span className="ap-card__author">{lang === 'vi' ? article.authorVi : article.authorEn}</span>
                      <span className="ap-card__read">{lang === 'vi' ? article.readVi : article.readEn}</span>
                    </div>
                  </div>
                </Link>
              ))}
            </div>

            <div className="ap-pagination fade-up">
              <button className="ap-pagination__btn active">1</button>
            </div>
          </div>
        </section>

        <section className="heritage-categories-section">
          <div className="section-container">
            <div className="heritage-categories__header fade-up">
              <h2 className="heritage-categories__title">{lang === 'vi' ? landing.heritage.titleVi : landing.heritage.titleEn}</h2>
              <p className="heritage-categories__subtitle">{lang === 'vi' ? landing.heritage.subtitleVi : landing.heritage.subtitleEn}</p>
            </div>

            <div className="heritage-grid fade-up" style={{ animationDelay: '0.1s' }}>
              {landing.heritage.cards.map((card, i) => (
                <div className="heritage-card" key={i}>
                  <div className="heritage-card__bg" style={{ backgroundImage: `url(${card.img || card.imageUrl || heroBg})` }}></div>
                  <div className="heritage-card__overlay"></div>
                  <div className="heritage-card__content">
                    <h3>{lang === 'vi' ? (card.titleVi || card.title) : (card.titleEn || card.title)}</h3>
                    <span>{lang === 'vi' ? (card.subVi || card.subtitle || card.sub) : (card.subEn || card.subtitle || card.sub)}</span>
                  </div>
                </div>
              ))}
            </div>
          </div>
        </section>

        <section className="featured-artwork-section fade-up">
          <div className="featured-artwork__container">
            <div className="featured-artwork__image-wrapper">
              <img src={landing.featuredArtwork.imageUrl || img4} alt={lang === 'vi' ? landing.featuredArtwork.imageAltVi : landing.featuredArtwork.imageAltEn} className="featured-artwork__image" />
            </div>
            <div className="featured-artwork__content">
              <div className="featured-badge">{lang === 'vi' ? landing.featuredArtwork.badgeVi : landing.featuredArtwork.badgeEn}</div>
              <h2 className="featured-artwork__title">{lang === 'vi' ? landing.featuredArtwork.titleVi : landing.featuredArtwork.titleEn}</h2>
              <div className="featured-artwork__divider"></div>

              <div className="featured-artwork__body">
                {(lang === 'vi' ? landing.featuredArtwork.bodyVi : landing.featuredArtwork.bodyEn).map((paragraph, index) => (
                  <p key={index}>{paragraph}</p>
                ))}
              </div>

              <div className="featured-stats">
                {landing.featuredArtwork.stats.map((stat, index) => (
                  <div className="featured-stat" key={`${stat.value}-${index}`}>
                    <strong>{stat.value}</strong>
                    <span>{localizeLandingText(stat, lang, 'labelVi', 'labelEn') || stat.label}</span>
                  </div>
                ))}
              </div>
            </div>
          </div>
        </section>

        <section className="article-gallery-section fade-up">
          <div className="section-container">
            <div className="article-gallery__header">
              <h2 className="article-gallery__title">{lang === 'vi' ? landing.gallery.titleVi : landing.gallery.titleEn}</h2>
              <p className="article-gallery__subtitle">{lang === 'vi' ? landing.gallery.subtitleVi : landing.gallery.subtitleEn}</p>
            </div>

            <div className="article-gallery__grid">
              {galleryColumns.map((column, columnIndex) => (
                <div className="gallery-col" key={columnIndex}>
                  {column.map((image, imageIndex) => (
                    <div className="gallery-item" key={`${columnIndex}-${imageIndex}`}>
                      <img src={image || img5} alt="Vietnam Culture" loading="lazy" />
                    </div>
                  ))}
                </div>
              ))}
            </div>
          </div>
        </section>

        <section className="article-story-section fade-up">
          <div className="article-story__container">
            <div className="article-story__content">
              <div className="featured-badge">{lang === 'vi' ? landing.story.badgeVi : landing.story.badgeEn}</div>
              <h2 className="article-story__title">{lang === 'vi' ? landing.story.titleVi : landing.story.titleEn}</h2>
              <div className="featured-artwork__divider"></div>

              <div className="article-story__body">
                {(lang === 'vi' ? landing.story.bodyVi : landing.story.bodyEn).map((paragraph, index) => (
                  <p key={index}>{paragraph}</p>
                ))}
              </div>

              <div className="article-story__features">
                {landing.story.features.map((feature, index) => (
                  <div className="story-feature" key={index}>
                    <div className="story-feature__icon" style={{ backgroundColor: feature.color || '#b91c1c' }}></div>
                    <div className="story-feature__text">
                      <strong>{localizeLandingText(feature, lang, 'titleVi', 'titleEn') || feature.title}</strong>
                      <span>{localizeLandingText(feature, lang, 'textVi', 'textEn') || feature.text}</span>
                    </div>
                  </div>
                ))}
              </div>
            </div>

            <div className="article-story__images">
              <div className="story-images-grid">
                <div className="story-img-col">
                  <div className="story-img-item"><img src={landing.story.images[0] || img3} alt="Heritage" /></div>
                  <div className="story-img-item"><img src={landing.story.images[1] || img6} alt="Heritage" /></div>
                </div>
                <div className="story-img-col">
                  <div className="story-img-item tall"><img src={landing.story.images[2] || img2} alt="Heritage" /></div>
                  <div className="story-img-item"><img src={landing.story.images[3] || img5} alt="Heritage" /></div>
                </div>
              </div>
            </div>
          </div>
        </section>
      </main>

      <Footer lang={lang} />
    </div>
  )
}

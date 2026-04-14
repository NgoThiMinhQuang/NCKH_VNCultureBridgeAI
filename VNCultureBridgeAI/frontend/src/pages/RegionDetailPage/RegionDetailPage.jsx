import { useEffect, useMemo, useState } from 'react'
import { Link, useParams } from 'react-router-dom'
import { getRegion } from '../../services/region.service'
import { getProvincesByRegion } from '../../services/province.service'
import { useDetailLoader } from '../../hooks/useDetailLoader'
import LoadingState from '../../components/common/LoadingState/LoadingState'
import PageHeader from '../../components/layout/PageHeader/PageHeader'
import Footer from '../../components/layout/Footer/Footer'
import imgRegionNorth from '../../assets/images/regions/region_overview_north.png'
import imgRegionCentral from '../../assets/images/regions/region_overview_central.png'
import imgRegionSouth from '../../assets/images/regions/region_overview_south.png'
import imgProvinceCaoBang from '../../assets/images/regions/province_caobang.png'
import imgProvinceDienBien from '../../assets/images/regions/province_dienbien.png'
import imgProvinceHaGiang from '../../assets/images/regions/province_hagiang.png'
import imgProvinceLaiChau from '../../assets/images/regions/province_laichau.png'
import imgProvinceLaoCai from '../../assets/images/regions/province_laocai.png'
import imgProvinceSonLa from '../../assets/images/regions/province_sonla.png'
import imgHighlightHanoi from '../../assets/images/regions/highlight_hanoi.png'
import imgHighlightSapa from '../../assets/images/regions/highlight_sapa.png'
import imgHighlightTrangAn from '../../assets/images/regions/highlight_trangan.png'
import imgHighlightHue from '../../assets/images/regions/highlight_hue.png'
import imgHighlightHoiAn from '../../assets/images/regions/highlight_hoian.png'
import imgHighlightDaNang from '../../assets/images/regions/highlight_danang.png'
import imgHighlightCanTho from '../../assets/images/regions/highlight_cantho.png'
import imgHighlightNamBo from '../../assets/images/regions/highlight_nambo.png'
import imgHeroRegions from '../../assets/images/regions/regions_hero_bg.png'
import '../NorthRegionPage/NorthRegionPage.css'
import './RegionDetailPage.css'

const REGION_THEME = {
  BAC_BO: {
    pageClass: 'north-page',
    badge: 'Vẻ đẹp vùng cao',
    accent: 'Hồn thiêng sông núi',
    primaryCta: 'Khám phá ngay',
    secondaryCta: 'Lên lộ trình',
    mapTitle: 'Bản đồ văn hóa',
    experiencesTitle: 'Trải nghiệm đặc trưng',
    experiencesSubtitle: 'Khám phá những nét văn hoá độc đáo không thể bỏ qua tại miền Bắc',
    seasonsTitle: 'Vẻ đẹp theo mùa',
    layersTitle: 'Những lớp văn hóa của vùng',
    itineraryTitle: 'Hành trình gợi ý',
    ctaTitle: 'Chinh phục ngay',
    ctaDesc: 'Đăng ký để nhận thông tin về các hành trình khám phá và ưu đãi mới nhất từ VietCultura',
  },
  TRUNG_BO: {
    pageClass: 'north-page',
    badge: 'Di sản miền Trung',
    accent: 'Dải đất di sản',
    primaryCta: 'Khám phá ngay',
    secondaryCta: 'Lên lộ trình',
    mapTitle: 'Bản đồ văn hóa',
    experiencesTitle: 'Trải nghiệm đặc trưng',
    experiencesSubtitle: 'Khám phá những nét văn hoá, di sản và biển trời đặc trưng của miền Trung',
    seasonsTitle: 'Vẻ đẹp theo mùa',
    layersTitle: 'Những lớp văn hóa của vùng',
    itineraryTitle: 'Hành trình gợi ý',
    ctaTitle: 'Khám phá miền Trung',
    ctaDesc: 'Đăng ký để nhận thông tin về những hành trình di sản và trải nghiệm biển miền Trung.',
  },
  NAM_BO: {
    pageClass: 'north-page',
    badge: 'Sắc màu phương Nam',
    accent: 'Sông nước và đô thị',
    primaryCta: 'Khám phá ngay',
    secondaryCta: 'Lên lộ trình',
    mapTitle: 'Bản đồ văn hóa',
    experiencesTitle: 'Trải nghiệm đặc trưng',
    experiencesSubtitle: 'Khám phá những nhịp sống sông nước, ẩm thực và văn hoá đặc trưng của miền Nam',
    seasonsTitle: 'Vẻ đẹp theo mùa',
    layersTitle: 'Những lớp văn hóa của vùng',
    itineraryTitle: 'Hành trình gợi ý',
    ctaTitle: 'Về phương Nam',
    ctaDesc: 'Đăng ký để nhận thông tin về các hành trình sông nước, ẩm thực và trải nghiệm miền Nam.',
  },
}

const SEASON_COPY = {
  BAC_BO: [
    { id: 'spring', name: 'Mùa Xuân', desc: 'Lễ hội đầu năm, sắc đào và không khí rộn ràng của mùa đoàn viên.', image: 'https://images.unsplash.com/photo-1498194847464-32b904cf10a6?q=80&w=400&auto=format&fit=crop' },
    { id: 'summer', name: 'Mùa Hạ', desc: 'Biển xanh Hạ Long, ruộng đồng rực nắng và những hành trình miền núi.', image: 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?q=80&w=400&auto=format&fit=crop' },
    { id: 'autumn', name: 'Mùa Thu', desc: 'Mùa lúa vàng, tiết trời dịu nhẹ và những cung đường đẹp nhất năm.', image: 'https://images.unsplash.com/photo-1476514525535-07fb3b4ae5f1?q=80&w=400&auto=format&fit=crop' },
    { id: 'winter', name: 'Mùa Đông', desc: 'Sương mù, giá lạnh vùng cao và vẻ trầm mặc của miền Bắc.', image: 'https://images.unsplash.com/photo-1444491741275-3747c03c996.jpg?q=80&w=400&auto=format&fit=crop' },
  ],
  TRUNG_BO: [
    { id: 'spring', name: 'Mùa Xuân', desc: 'Di sản bừng sáng trong tiết trời êm và lễ hội đầu năm.', image: 'https://images.unsplash.com/photo-1498194847464-32b904cf10a6?q=80&w=400&auto=format&fit=crop' },
    { id: 'summer', name: 'Mùa Hạ', desc: 'Mùa biển đẹp, nắng vàng và nhịp sống sôi động trên dải duyên hải.', image: 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?q=80&w=400&auto=format&fit=crop' },
    { id: 'autumn', name: 'Mùa Thu', desc: 'Sự giao hòa giữa mưa nhẹ, biển xanh và chiều sâu di sản.', image: 'https://images.unsplash.com/photo-1476514525535-07fb3b4ae5f1?q=80&w=400&auto=format&fit=crop' },
    { id: 'winter', name: 'Mùa Đông', desc: 'Những ngày se lạnh và vẻ tĩnh lặng của đô thị, làng biển và di tích.', image: 'https://images.unsplash.com/photo-1444491741275-3747c03c996.jpg?q=80&w=400&auto=format&fit=crop' },
  ],
  NAM_BO: [
    { id: 'spring', name: 'Mùa Xuân', desc: 'Không khí tươi mới, chợ hoa và nhịp sống phương Nam rộn ràng.', image: 'https://images.unsplash.com/photo-1498194847464-32b904cf10a6?q=80&w=400&auto=format&fit=crop' },
    { id: 'summer', name: 'Mùa Hạ', desc: 'Trái cây chín rộ, sông nước trù phú và hành trình miệt vườn đặc sắc.', image: 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?q=80&w=400&auto=format&fit=crop' },
    { id: 'autumn', name: 'Mùa Thu', desc: 'Sông nước hiền hòa, đồng bằng phóng khoáng và nhịp sống đô thị giao thoa.', image: 'https://images.unsplash.com/photo-1476514525535-07fb3b4ae5f1?q=80&w=400&auto=format&fit=crop' },
    { id: 'winter', name: 'Mùa Đông', desc: 'Khô ráo, dễ chịu, thích hợp cho những hành trình dài ngày ở phương Nam.', image: 'https://images.unsplash.com/photo-1444491741275-3747c03c996.jpg?q=80&w=400&auto=format&fit=crop' },
  ],
}

const LAYER_COPY = {
  BAC_BO: [
    { icon: '🏮', title: 'Lễ hội', desc: 'Hội Lim, Chùa Hương, Lễ hội Đền Hùng và không khí lễ hội đầu năm.' },
    { icon: '🍚', title: 'Ẩm thực', desc: 'Phở, bún chả, nem rán, bánh cuốn và các món ăn đậm dấu ấn Bắc Bộ.' },
    { icon: '🏺', title: 'Làng nghề', desc: 'Gốm Bát Tràng, lụa Vạn Phúc, tranh Đông Hồ và nghề thủ công lâu đời.' },
    { icon: '🎻', title: 'Nghệ thuật', desc: 'Ca trù, quan họ, múa rối nước và không gian trình diễn dân gian.' },
    { icon: '🏘️', title: 'Kiến trúc', desc: 'Phố cổ, đình làng, nhà sàn và dấu ấn kiến trúc truyền thống miền Bắc.' },
    { icon: '👗', title: 'Trang phục', desc: 'Áo tứ thân, khăn mỏ quạ và những lớp phục trang gắn với văn hóa Bắc Bộ.' },
  ],
  TRUNG_BO: [
    { icon: '🏮', title: 'Lễ hội', desc: 'Festival Huế, lễ hội cầu ngư và các sinh hoạt tín ngưỡng ven biển miền Trung.' },
    { icon: '🍜', title: 'Ẩm thực', desc: 'Bún bò Huế, mì Quảng, nem lụi, bánh xèo và hải sản miền Trung.' },
    { icon: '🏛️', title: 'Di sản', desc: 'Không gian cung đình, kiến trúc cổ và những lớp di sản văn hóa đặc sắc.' },
    { icon: '🎶', title: 'Nghệ thuật', desc: 'Nhã nhạc cung đình, bài chòi và các hình thức diễn xướng dân gian miền Trung.' },
    { icon: '🏖️', title: 'Biển & làng chài', desc: 'Đời sống biển, làng chài, ghe thuyền và nhịp sinh hoạt ven duyên hải.' },
    { icon: '🧵', title: 'Thủ công', desc: 'Thêu, mộc, đèn lồng và các làng nghề gắn với lịch sử đô thị cổ.' },
  ],
  NAM_BO: [
    { icon: '🏮', title: 'Lễ hội', desc: 'Ok Om Bok, Nghinh Ông, Chol Chnam Thmay và các lễ hội cộng đồng phương Nam.' },
    { icon: '🍲', title: 'Ẩm thực', desc: 'Cơm tấm, hủ tiếu, lẩu mắm, cá lóc nướng trui và món ăn sông nước.' },
    { icon: '🚤', title: 'Sông nước', desc: 'Chợ nổi, ghe thuyền, miệt vườn và nhịp sống gắn với những con sông lớn.' },
    { icon: '🎼', title: 'Âm nhạc', desc: 'Đờn ca tài tử và tinh thần phóng khoáng trong đời sống văn hóa Nam Bộ.' },
    { icon: '🏙️', title: 'Đô thị', desc: 'TPHCM năng động, các trung tâm công nghiệp và sự giao thoa hiện đại - truyền thống.' },
    { icon: '🧺', title: 'Làng nghề', desc: 'Lụa Tân Châu, thủ công dân gian, đan lát và các nghề truyền thống ven sông.' },
  ],
}

function getTheme(code) {
  return REGION_THEME[code] || REGION_THEME.BAC_BO
}

function normalizeRegionCode(code) {
  if (code === 'north') return 'BAC_BO'
  if (code === 'central') return 'TRUNG_BO'
  if (code === 'south') return 'NAM_BO'
  return code
}

function getProvinceRegionCode(code) {
  const normalizedCode = normalizeRegionCode(code)
  if (normalizedCode === 'BAC_BO') return 'BAC_BO'
  if (normalizedCode === 'TRUNG_BO') return 'TRUNG_BO'
  if (normalizedCode === 'NAM_BO') return 'NAM_BO'
  return normalizedCode
}

const FALLBACK_IMAGE_BY_CODE = {
  'ha-noi': imgHighlightHanoi,
  'quang-ninh': imgHighlightHanoi,
  'ninh-binh': imgHighlightTrangAn,
  'lao-cai': imgProvinceLaoCai,
  'sapa': imgHighlightSapa,
  'ha-giang': imgProvinceHaGiang,
  'cao-bang': imgProvinceCaoBang,
  'dien-bien': imgProvinceDienBien,
  'lai-chau': imgProvinceLaiChau,
  'son-la': imgProvinceSonLa,
  'lang-son': imgProvinceCaoBang,
  'bac-kan': imgProvinceHaGiang,
  'tuyen-quang': imgProvinceHaGiang,
  'yen-bai': imgHighlightSapa,
  'thai-nguyen': imgHighlightHanoi,
  'phu-tho': imgHighlightTrangAn,
  'bac-ninh': imgHighlightHanoi,
  'hai-duong': imgHighlightHanoi,
  'hai-phong': imgHighlightHanoi,
  'hung-yen': imgHighlightHanoi,
  'nam-dinh': imgHighlightTrangAn,
  'thai-binh': imgHighlightTrangAn,
  'vinh-phuc': imgHighlightHanoi,
  'ha-nam': imgHighlightTrangAn,
  'nghe-an': imgHighlightHue,
  'ha-tinh': imgHighlightHue,
  'quang-binh': imgHighlightHue,
  'quang-tri': imgHighlightHue,
  'thua-thien-hue': imgHighlightHue,
  'hue': imgHighlightHue,
  'da-nang': imgHighlightDaNang,
  'quang-nam': imgHighlightHoiAn,
  'quang-ngai': imgHighlightDaNang,
  'binh-dinh': imgHighlightDaNang,
  'phu-yen': imgHighlightDaNang,
  'khanh-hoa': imgHighlightDaNang,
  'ninh-thuan': imgHighlightDaNang,
  'binh-thuan': imgHighlightDaNang,
  'kon-tum': imgRegionCentral,
  'gia-lai': imgRegionCentral,
  'dak-lak': imgRegionCentral,
  'dak-nong': imgRegionCentral,
  'lam-dong': imgRegionCentral,
  'tp-ho-chi-minh': imgHighlightNamBo,
  'ho-chi-minh': imgHighlightNamBo,
  'can-tho': imgHighlightCanTho,
  'an-giang': imgHighlightCanTho,
  'kien-giang': imgHighlightCanTho,
  'ca-mau': imgHighlightNamBo,
  'bac-lieu': imgHighlightNamBo,
  'soc-trang': imgHighlightCanTho,
  'tra-vinh': imgHighlightCanTho,
  'vinh-long': imgHighlightCanTho,
  'dong-thap': imgHighlightCanTho,
  'ben-tre': imgHighlightCanTho,
  'tien-giang': imgHighlightCanTho,
  'long-an': imgHighlightNamBo,
  'tay-ninh': imgHighlightNamBo,
  'binh-phuoc': imgHighlightNamBo,
  'dong-nai': imgHighlightNamBo,
  'ba-ria-vung-tau': imgHighlightNamBo,
}

const FALLBACK_IMAGE_BY_REGION = {
  BAC_BO: imgRegionNorth,
  TRUNG_BO: imgRegionCentral,
  NAM_BO: imgRegionSouth,
}

function getSafeImage(value, regionCode = 'BAC_BO') {
  return value || FALLBACK_IMAGE_BY_REGION[regionCode] || imgHeroRegions || imgRegionNorth
}

function getProvinceFallbackImage(province, regionCode = 'BAC_BO') {
  return FALLBACK_IMAGE_BY_CODE[province?.code] || FALLBACK_IMAGE_BY_REGION[regionCode] || imgHeroRegions || imgRegionNorth
}

function getSafeTags(tags) {
  return Array.isArray(tags) ? tags : []
}

function toMapCards(provinces) {
  return provinces.slice(0, 3).map((province, index) => ({
    ...province,
    active: index === 1,
    shortDesc: province.description,
  }))
}

function toExperienceCards(provinces, regionCode) {
  return provinces.slice(0, 6).map((province) => ({
    id: province.code,
    title: province.name,
    image: province.imageUrl || getProvinceFallbackImage(province, regionCode),
    desc: province.description,
  }))
}

function toProvinceCards(provinces, regionCode) {
  return provinces.slice(0, 4).map((province) => ({
    id: province.code,
    name: province.name,
    image: province.imageUrl || getProvinceFallbackImage(province, regionCode),
    desc: province.description,
    tags: getSafeTags(province.tags),
    code: province.code,
    region: province.region,
  }))
}

function toItineraries(provinces, regionCode) {
  const first = provinces.slice(0, 3)
  const second = provinces.slice(3, 6)
  return [
    {
      id: `${regionCode}-itinerary-1`,
      duration: '3 NGÀY',
      title: 'Khám phá chiều sâu văn hóa',
      image: first[0]?.imageUrl || null,
      steps: first.map((province) => province.name),
    },
    {
      id: `${regionCode}-itinerary-2`,
      duration: '5 NGÀY',
      title: 'Hành trình trải nghiệm mở rộng',
      image: second[0]?.imageUrl || first[0]?.imageUrl || null,
      steps: (second.length ? second : first).map((province) => province.name),
    },
  ]
}

export default function RegionDetailPage() {
  const { code } = useParams()
  const normalizedCode = normalizeRegionCode(code)
  const [lang, setLang] = useState('vi')
  const [provinceState, setProvinceState] = useState({ status: 'loading', data: [], error: '' })
  const { status, data, error } = useDetailLoader(getRegion, lang, normalizedCode)

  useEffect(() => {
    let ignore = false

    async function loadProvinces() {
      try {
        setProvinceState({ status: 'loading', data: [], error: '' })
        const provinces = await getProvincesByRegion(getProvinceRegionCode(normalizedCode), lang)
        if (!ignore) {
          setProvinceState({ status: 'success', data: provinces, error: '' })
        }
      } catch (provinceError) {
        if (!ignore) {
          setProvinceState({ status: 'error', data: [], error: provinceError.message })
        }
      }
    }

    loadProvinces()
    return () => {
      ignore = true
    }
  }, [normalizedCode, lang])

  const theme = getTheme(normalizedCode)
  const provinces = useMemo(() => provinceState.data || [], [provinceState.data])
  const mapCards = useMemo(() => toMapCards(provinces), [provinces])
  const experiences = useMemo(() => toExperienceCards(provinces, normalizedCode), [provinces, normalizedCode])
  const provinceCards = useMemo(() => toProvinceCards(provinces, normalizedCode), [provinces, normalizedCode])
  const itineraries = useMemo(() => toItineraries(provinces, normalizedCode), [provinces, normalizedCode])
  const seasons = useMemo(() => SEASON_COPY[normalizedCode] || [], [normalizedCode])
  const layers = useMemo(() => LAYER_COPY[normalizedCode] || [], [normalizedCode])
  const provinceCount = provinces.length || 0
  const highlightCount = data?.highlights?.length || 0
  const stats = [
    { value: String(provinceCount), label: lang === 'vi' ? 'Tỉnh thành' : 'Provinces' },
    { value: String(data?.articleCount || 0), label: lang === 'vi' ? 'Bài viết' : 'Articles' },
    { value: String(highlightCount), label: lang === 'vi' ? 'Điểm nhấn' : 'Highlights' },
  ]

  if (status === 'loading') return <LoadingState message={lang === 'vi' ? 'Đang tải vùng miền...' : 'Loading region...'} />
  if (status === 'error') return <LoadingState type="error" message={error} />

  return (
    <div className={theme.pageClass}>
      <PageHeader
        lang={lang}
        onLangChange={setLang}
        breadcrumb={[
          { label: lang === 'vi' ? 'Vùng miền' : 'Regions', to: '/regions' },
          { label: data?.name || code },
        ]}
      />

      <main>
        <section className="north-hero">
          <div className="north-hero__bg">
            <img src={getSafeImage(data?.imageUrl, normalizedCode)} alt={data?.imageAlt || data?.name} onError={(event) => { event.currentTarget.src = getSafeImage('', normalizedCode) }} />
            <div className="north-hero__overlay"></div>
          </div>
          <div className="north-hero__content">
            <span className="north-hero__badge">{theme.badge}</span>
            <h1 className="north-hero__title">
              {data?.name}
              <span className="north-hero__title-accent">{theme.accent}</span>
            </h1>
            <p className="north-hero__lead">{data?.overviewDescription || data?.description}</p>
            <div className="north-hero__actions">
              <Link to="/regions" className="north-hero__btn north-hero__btn--primary">{theme.primaryCta}</Link>
              <Link to="/provinces" className="north-hero__btn north-hero__btn--secondary">{theme.secondaryCta}</Link>
            </div>

            <div className="north-hero__stats">
              {stats.map((stat) => (
                <div key={stat.label} className="north-hero__stat">
                  <strong>{stat.value}</strong>
                  <span>{stat.label}</span>
                </div>
              ))}
            </div>
          </div>
        </section>

        <section className="north-story content-section">
          <div className="container">
            <div className="north-story__inner">
              <div className="north-story__image">
                <img src={getSafeImage(data?.imageUrl, normalizedCode)} alt={data?.imageAlt || data?.name} onError={(event) => { event.currentTarget.src = getSafeImage('', normalizedCode) }} />
                <div className="north-story__image-decoration"></div>
              </div>
              <div className="north-story__content">
                <h2 className="section-title">{data?.overviewTitle || data?.title || data?.name}</h2>
                <div className="section-divider"></div>
                <p>{data?.overviewDescription || data?.description}</p>
                {(data?.overviewDetails || []).map((detail, index) => (
                  <p key={`${detail.label}-${index}`}><strong>{detail.label}:</strong> {detail.value}</p>
                ))}
                <Link to="/articles" className="btn-text-icon">Đọc thêm câu chuyện <span aria-hidden="true">→</span></Link>
              </div>
            </div>
          </div>
        </section>

        <section className="north-map-section content-section alternate-bg">
          <div className="container">
            <h2 className="section-title text-center">{theme.mapTitle}</h2>
            <div className="north-map-inner">
              <div className="north-map__visual">
                <div className="map-placeholder">
                  <div className="map-label">{data?.name}</div>
                </div>
              </div>
              <div className="north-map__list">
                {mapCards.map((card) => (
                  <div key={card.code} className={`map-info-card ${card.active ? 'active' : ''}`}>
                    <h3>{card.name}</h3>
                    <p>{card.shortDesc}</p>
                  </div>
                ))}
              </div>
            </div>
          </div>
        </section>

        <section className="north-experiences content-section">
          <div className="container">
            <div className="section-header text-center">
              <h2 className="section-title">{theme.experiencesTitle}</h2>
              <p>{theme.experiencesSubtitle}</p>
            </div>
            <div className="experience-grid">
              {experiences.map((experience) => (
                <div key={experience.id} className="experience-card">
                  <div className="experience-card__img">
                    <img src={experience.image} alt={experience.title} onError={(event) => { event.currentTarget.src = getProvinceFallbackImage({ code: experience.id }, normalizedCode) }} />
                  </div>
                  <div className="experience-card__body">
                    <h3>{experience.title}</h3>
                    <p>{experience.desc}</p>
                  </div>
                </div>
              ))}
            </div>
          </div>
        </section>

        <section className="north-provinces content-section alternate-bg">
          <div className="container">
            <div className="section-header text-center">
              <h2 className="section-title">Từ vùng miền đến từng tỉnh thành</h2>
            </div>
            <div className="province-grid">
              {provinceCards.map((province) => (
                <div key={province.id} className="province-mini-card">
                  <div className="province-mini__img">
                    <img src={province.image} alt={province.name} onError={(event) => { event.currentTarget.src = getProvinceFallbackImage(province, normalizedCode) }} />
                    <span className="province-mini__tag">{data?.name}</span>
                  </div>
                  <div className="province-mini__body">
                    <h3>{province.name}</h3>
                    <p>{province.desc}</p>
                    <div className="province-mini__tags">
                      {province.tags.map((tag) => <span key={tag}>{tag}</span>)}
                    </div>
                    <Link to={`/provinces/${province.code}`} className="mini-cta">Xem chi tiết →</Link>
                  </div>
                </div>
              ))}
            </div>
          </div>
        </section>

        <section className="north-seasons content-section">
          <div className="container">
            <h2 className="section-title text-center">{theme.seasonsTitle}</h2>
            <div className="season-vertical-grid">
              {seasons.map((season) => (
                <div key={season.id} className="season-v-card">
                  <img src={season.image} alt={season.name} />
                  <div className="season-v-content">
                    <h3>{season.name}</h3>
                    <p>{season.desc}</p>
                  </div>
                </div>
              ))}
            </div>
          </div>
        </section>

        <section className="north-layers content-section alternate-bg">
          <div className="container">
            <h2 className="section-title text-center">{theme.layersTitle}</h2>
            <div className="layers-grid">
              {layers.map((layer) => (
                <div key={layer.title} className="layer-card">
                  <span className="layer-icon">{layer.icon}</span>
                  <h3>{layer.title}</h3>
                  <p>{layer.desc}</p>
                </div>
              ))}
            </div>
          </div>
        </section>

        <section className="north-itinerary content-section">
          <div className="container">
            <h2 className="section-title text-center">{theme.itineraryTitle}</h2>
            <div className="itinerary-grid">
              {itineraries.map((itinerary, index) => (
                <div key={itinerary.id} className={`itinerary-card ${index === 0 ? 'primary' : ''}`}>
                  <div className="itinerary-image">
                    {itinerary.image ? <img src={itinerary.image} alt={itinerary.title} /> : null}
                    <span className="itinerary-badge">{itinerary.duration}</span>
                  </div>
                  <div className="itinerary-body">
                    <h3>{itinerary.title}</h3>
                    <ul className="itinerary-steps">
                      {itinerary.steps.map((step) => <li key={step}>{step}</li>)}
                    </ul>
                    <Link to="/provinces" className="btn-full">Xem lộ trình chi tiết</Link>
                  </div>
                </div>
              ))}
            </div>
          </div>
        </section>

        <section className="north-cta">
          <div className="north-cta__bg"></div>
          <div className="container">
            <div className="north-cta__content">
              <span className="cta-icon">📮</span>
              <h2>{theme.ctaTitle}</h2>
              <p>{theme.ctaDesc}</p>
              <form className="cta-form">
                <input type="email" placeholder="Địa chỉ email của bạn" />
                <button type="submit">ĐĂNG KÝ NGAY</button>
              </form>
            </div>
          </div>
        </section>
      </main>

      <Footer lang={lang} />
    </div>
  )
}

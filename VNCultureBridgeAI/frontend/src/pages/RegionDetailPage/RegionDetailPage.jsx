import { useEffect, useMemo, useState } from 'react'
import { useLanguage } from '../../context/LanguageContext'
import { Link, useParams } from 'react-router-dom'
import { getRegion } from '../../services/region.service'
import { useDetailLoader } from '../../hooks/useDetailLoader'
import LoadingState from '../../components/common/LoadingState/LoadingState'
import PageHeader from '../../components/layout/PageHeader/PageHeader'
import Footer from '../../components/layout/Footer/Footer'
import Pagination from '../../components/common/Pagination/Pagination'
import './RegionDetailPage.css'

const REGION_THEME = {
  BAC_BO: {
    vi: { badge: 'Vẻ đẹp vùng cao', accent: 'Hồn thiêng sông núi' },
    en: { badge: 'Highland Beauty', accent: 'Sacred Soul of Mountains' }
  },
  TRUNG_BO: {
    vi: { badge: 'Di sản miền Trung', accent: 'Dải đất di sản' },
    en: { badge: 'Central Heritage', accent: 'The Land of Legacy' }
  },
  NAM_BO: {
    vi: { badge: 'Sắc màu phương Nam', accent: 'Sông nước và đô thị' },
    en: { badge: 'Southern Colors', accent: 'Rivers & Urban Life' }
  }
}

const SEASON_COPY = {
  BAC_BO: {
    vi: [
      { id: 'sp', name: 'Mùa Xuân', icon: '🌸', desc: 'Lễ hội & Sắc hoa' },
      { id: 'su', name: 'Mùa Hạ', icon: '☀️', desc: 'Nắng vàng & Biển' },
      { id: 'au', name: 'Mùa Thu', icon: '🍂', desc: 'Lúa chín & Dịu mát' },
      { id: 'wi', name: 'Mùa Đông', icon: '❄️', desc: 'Sương mù & Trầm mặc' }
    ],
    en: [
      { id: 'sp', name: 'Spring', icon: '🌸', desc: 'Festivals & Blossoms' },
      { id: 'su', name: 'Summer', icon: '☀️', desc: 'Golden Sun & Sea' },
      { id: 'au', name: 'Autumn', icon: '🍂', desc: 'Harvest & Cool Air' },
      { id: 'wi', name: 'Winter', icon: '❄️', desc: 'Mist & Serenity' }
    ]
  },
  TRUNG_BO: {
    vi: [
      { id: 'sp', name: 'Mùa Xuân', icon: '🌸', desc: 'Di sản bừng sáng' },
      { id: 'su', name: 'Mùa Hạ', icon: '☀️', desc: 'Biển xanh nắng vàng' },
      { id: 'au', name: 'Mùa Thu', icon: '🍂', desc: 'Dịu dàng cố đô' },
      { id: 'wi', name: 'Mùa Đông', icon: '❄️', desc: 'Trầm mặc di tích' }
    ],
    en: [
      { id: 'sp', name: 'Spring', icon: '🌸', desc: 'Luminous Heritage' },
      { id: 'su', name: 'Summer', icon: '☀️', desc: 'Blue Sea & Sun' },
      { id: 'au', name: 'Autumn', icon: '🍂', desc: 'Gentle Ancient Capital' },
      { id: 'wi', name: 'Winter', icon: '❄️', desc: 'Serene Monuments' }
    ]
  },
  NAM_BO: {
    vi: [
      { id: 'sp', name: 'Mùa Xuân', icon: '🌸', desc: 'Chợ hoa & Sắc xuân' },
      { id: 'su', name: 'Mùa Hạ', icon: '☀️', desc: 'Miệt vườn trái cây' },
      { id: 'au', name: 'Mùa Thu', icon: '🍂', desc: 'Sông lướt sóng hiền' },
      { id: 'wi', name: 'Mùa Đông', icon: '❄️', desc: 'Nắng ấm phương Nam' }
    ],
    en: [
      { id: 'sp', name: 'Spring', icon: '🌸', desc: 'Flower Markets' },
      { id: 'su', name: 'Summer', icon: '☀️', desc: 'Fruit Orchards' },
      { id: 'au', name: 'Autumn', icon: '🍂', desc: 'Gentle River Life' },
      { id: 'wi', name: 'Winter', icon: '❄️', desc: 'Southern Sunshine' }
    ]
  }
}

function normalizeRegionCode(code) {
  if (code === 'north') return 'BAC_BO'
  if (code === 'central') return 'TRUNG_BO'
  if (code === 'south') return 'NAM_BO'
  return code
}

export default function RegionDetailPage() {
  const { lang, setLang } = useLanguage()
  const { code } = useParams()
  const normalizedCode = useMemo(() => normalizeRegionCode(code), [code])

  const { status, data, error } = useDetailLoader(getRegion, lang, normalizedCode)

  const [provincePage, setProvincePage] = useState(1)
  const [cuisinePage, setCuisinePage] = useState(1)
  const [isProvincePaginated, setIsProvincePaginated] = useState(true)
  const [isCuisinePaginated, setIsCuisinePaginated] = useState(true)
  const ITEMS_PER_PAGE = 8

  useEffect(() => {
    window.scrollTo(0, 0)
    if (data?.name) {
      document.title = `${data.name} - VNCultureBridgeAI`
    }
  }, [normalizedCode, data?.name])

  const theme = useMemo(() => REGION_THEME[normalizedCode]?.[lang] || REGION_THEME.BAC_BO[lang], [normalizedCode, lang])
  const seasonCopy = useMemo(() => SEASON_COPY[normalizedCode]?.[lang] || SEASON_COPY.BAC_BO[lang], [normalizedCode, lang])

  const provinces = useMemo(() => data?.provinces || [], [data])
  const cuisine = useMemo(() => data?.culturalHighlights?.cuisine || [], [data])
  const festivals = useMemo(() => data?.culturalHighlights?.festivals || [], [data])
  const articles = useMemo(() => data?.articles || [], [data])

  const stats = useMemo(() => [
    { value: String(data?.statistics?.provinceCount || 0), label: lang === 'vi' ? 'Tỉnh thành' : 'Provinces' },
    { value: String(data?.articles?.length || 0), label: lang === 'vi' ? 'Bài viết' : 'Articles' },
    { value: String(data?.culturalHighlights?.cuisine?.length || 0), label: lang === 'vi' ? 'Món ăn' : 'Cuisine' },
  ], [data, lang])

  // Pagination Logic - Provinces
  const paginatedProvinces = useMemo(() => {
    if (!isProvincePaginated) return provinces
    const start = (provincePage - 1) * ITEMS_PER_PAGE
    return provinces.slice(start, start + ITEMS_PER_PAGE)
  }, [provinces, provincePage, isProvincePaginated])

  const totalProvincePages = Math.ceil(provinces.length / ITEMS_PER_PAGE)

  // Pagination Logic - Cuisine
  const paginatedCuisine = useMemo(() => {
    if (!isCuisinePaginated) return cuisine
    const start = (cuisinePage - 1) * ITEMS_PER_PAGE
    return cuisine.slice(start, start + ITEMS_PER_PAGE)
  }, [cuisine, cuisinePage, isCuisinePaginated])

  const totalCuisinePages = Math.ceil(cuisine.length / ITEMS_PER_PAGE)

  const handleOpenChatbot = (e) => {
    e.preventDefault();
    window.dispatchEvent(new CustomEvent('vnc-open-chatbot'));
  };

  if (status === 'loading') return <LoadingState message={lang === 'vi' ? 'Đang tải vùng miền...' : 'Loading region...'} />
  if (status === 'error') return <LoadingState type="error" message={error} />
  if (!data) return null

  return (
    <div className={`region-detail-page ${normalizedCode.toLowerCase()}`}>
      <PageHeader
        lang={lang}
        onLangChange={setLang}
        breadcrumb={[
          { label: lang === 'vi' ? 'Vùng miền' : 'Regions', to: '/regions' },
          { label: data?.name || code },
        ]}
      />

      <main>
        {/* ENHANCED HERO */}
        <section className="region-hero">
          <div className="region-hero__bg">
            <img src={data.imageUrl} alt={data.name} />
            <div className="region-hero__overlay"></div>
          </div>
          <div className="region-hero__content hero-content--animated">
            <span className="region-hero__badge">{theme.badge}</span>
            <h1 className="region-hero__title">
              {data.name}
              <span className="region-hero__title-accent">{theme.accent}</span>
            </h1>
            <p className="region-hero__lead">{data.description}</p>

            <div className="region-hero__stats">
              {stats.map((stat) => (
                <div key={stat.label} className="region-hero__stat">
                  <strong>{stat.value}</strong>
                  <span>{stat.label}</span>
                </div>
              ))}
            </div>
          </div>
        </section>

        {/* SECTION 1: CULTURAL MOSAIC (CUISINE & FESTIVALS) */}
        <section className="cultural-mosaic fade-up">
          <div className="container">
            <div className="section-header">
              <h2 className="section-title">{lang === 'vi' ? 'Bản sắc văn hóa' : 'Cultural Highlights'}</h2>
            </div>

            <div className="mosaic-grid">
              {cuisine.slice(0, 2).map((item, idx) => (
                <div key={item.id} className={`mosaic-item ${idx === 0 ? 'mosaic-item--lg' : 'mosaic-item--sm'}`}>
                  <div className="mosaic-item__img">
                    <img src={item.imageUrl} alt={item.title} />
                  </div>
                  <div className="mosaic-content">
                    <h3>{item.title}</h3>
                    <p>{item.description}</p>
                  </div>
                </div>
              ))}
              {festivals.slice(0, 2).map((item) => (
                <div key={item.id} className="mosaic-item mosaic-item--md">
                  <div className="mosaic-item__img">
                    <img src={item.imageUrl} alt={item.title} />
                  </div>
                  <div className="mosaic-content">
                    <h3>{item.title}</h3>
                    <p>{item.date} • {item.description}</p>
                  </div>
                </div>
              ))}
            </div>
          </div>
        </section>

        <section className="province-hub fade-up" style={{ animationDelay: '0.2s' }}>
          <div className="container">
            <div className="section-header">
              <span className="section-badge">{lang === 'vi' ? 'Khám phá' : 'Explore'}</span>
              <h2 className="section-title">{lang === 'vi' ? 'Tỉnh thành' : 'Provinces'}</h2>
              <div className="section-actions">
                <button
                  className="btn-outline-sm"
                  onClick={() => setIsProvincePaginated(!isProvincePaginated)}
                >
                  {isProvincePaginated
                    ? (lang === 'vi' ? 'Xem tất cả' : 'See All')
                    : (lang === 'vi' ? 'Phân trang' : 'Show Paginated')}
                </button>
              </div>
            </div>

            <div className="hub-grid">
              {paginatedProvinces.map((province) => (
                <Link to={`/provinces/${province.code}`} key={province.id} className="hub-card">
                  <div className="hub-card__img">
                    <img src={province.imageUrl} alt={province.name} />
                  </div>
                  <div className="hub-card__overlay"></div>
                  <div className="hub-card__content">
                    <h3>{province.name}</h3>
                    <p>{province.description}</p>
                  </div>
                </Link>
              ))}
            </div>

            {isProvincePaginated && totalProvincePages > 1 && (
              <div className="pagination-wrapper">
                <Pagination
                  currentPage={provincePage}
                  totalPages={totalProvincePages}
                  onPageChange={(page) => {
                    setProvincePage(page)
                    document.querySelector('.province-hub').scrollIntoView({ behavior: 'smooth' })
                  }}
                />
              </div>
            )}
          </div>
        </section>

        {/* SECTION 2.5: CUISINE HUB */}
        <section className="cuisine-hub fade-up alternate-bg">
          <div className="container">
            <div className="section-header">
              <span className="section-badge">{lang === 'vi' ? 'Hương vị' : 'Taste'}</span>
              <h2 className="section-title">{lang === 'vi' ? 'Tinh hoa ẩm thực' : 'Culinary Highlights'}</h2>
              <div className="section-actions">
                <button
                  className="btn-outline-sm"
                  onClick={() => setIsCuisinePaginated(!isCuisinePaginated)}
                >
                  {isCuisinePaginated
                    ? (lang === 'vi' ? 'Xem tất cả' : 'See All')
                    : (lang === 'vi' ? 'Phân trang' : 'Show Paginated')}
                </button>
              </div>
            </div>

            <div className="hub-grid">
              {paginatedCuisine.map((item) => (
                <Link to={`/cuisine/${item.code}`} key={item.id} className="hub-card hub-card--cuisine">
                  <div className="hub-card__img">
                    <img src={item.imageUrl} alt={item.title} />
                  </div>
                  <div className="hub-card__overlay"></div>
                  <div className="hub-card__content">
                    <h3>{item.title}</h3>
                    <p>{item.description}</p>
                  </div>
                </Link>
              ))}
            </div>

            {isCuisinePaginated && totalCuisinePages > 1 && (
              <div className="pagination-wrapper">
                <Pagination
                  currentPage={cuisinePage}
                  totalPages={totalCuisinePages}
                  onPageChange={(page) => {
                    setCuisinePage(page)
                    document.querySelector('.cuisine-hub').scrollIntoView({ behavior: 'smooth' })
                  }}
                />
              </div>
            )}
          </div>
        </section>

        {/* SECTION 3: REGIONAL STORIES */}
        <section className="regional-stories alternate-bg fade-up" style={{ animationDelay: '0.4s' }}>
          <div className="container">
            <div className="section-header">
              <h2 className="section-title">{lang === 'vi' ? 'Câu chuyện vùng miền' : 'Regional Stories'}</h2>
            </div>

            <div className="stories-row">
              {articles.map((article) => (
                <Link to={`/blog/${article.code}`} key={article.id} className="story-card">
                  {article.imageUrl && (
                    <div className="story-card__img">
                      <img src={article.imageUrl} alt={article.title} />
                    </div>
                  )}
                  <div className="story-card__content">
                    <span className="story-card__tag">{article.category}</span>
                    <h4>{article.title}</h4>
                    <p className="btn-text-icon">{lang === 'vi' ? 'Đọc tiếp' : 'Read more'} →</p>
                  </div>
                </Link>
              ))}
            </div>
          </div>
        </section>

        {/* SECTION 4: TRAVEL PLANNING */}
        <section className="travel-planning">
          <div className="container">
            <div className="planning-grid">
              <div className="planning-content">
                <h2 className="section-title">{lang === 'vi' ? 'Lên kế hoạch cho chuyến đi' : 'Plan Your Visit'}</h2>
                <p style={{ marginBottom: '32px', color: 'var(--text-muted)' }}>
                  {lang === 'vi'
                    ? 'Mỗi mùa vùng đất này lại mang một vẻ đẹp khác nhau. Hãy chọn thời điểm phù hợp để tận hưởng trọn vẹn tinh hoa văn hóa và thiên nhiên.'
                    : 'Each season brings a different beauty to this land. Choose the right time to fully enjoy the cultural essence and nature.'}
                </p>
                <button onClick={handleOpenChatbot} className="btn-full">
                  {lang === 'vi' ? 'Hỏi AI tư vấn ngay' : 'Consult AI Now'}
                </button>
              </div>

              <div className="seasons-display">
                {seasonCopy.map(s => (
                  <div key={s.id} className="season-mini">
                    <span className="icon">{s.icon}</span>
                    <h5>{s.name}</h5>
                    <p>{s.desc}</p>
                  </div>
                ))}
              </div>
            </div>
          </div>
        </section>

      </main>

      <Footer lang={lang} />
    </div>
  )
}

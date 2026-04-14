import { useEffect, useMemo, useState } from 'react'
import { Link, useNavigate } from 'react-router-dom'
import { LuChevronDown, LuSearch } from 'react-icons/lu'
import './CuisinePage.css'
import PageHeader from '../../components/layout/PageHeader/PageHeader'
import Footer from '../../components/layout/Footer/Footer'
import banner3 from '../../assets/banner3.jpg'
import { getCuisines } from '../../services/cuisine.service'
import { getCuisineLocalImage } from '../../utils/cuisineMedia'

function StarIcon(props) {
  return (
    <svg viewBox="0 0 24 24" fill="currentColor" {...props}>
      <path d="m12 2.5 3.09 6.26 6.91 1.01-5 4.87 1.18 6.88L12 18.3 5.82 21.52 7 14.64 2 9.77l6.91-1.01L12 2.5z" />
    </svg>
  )
}

function CoffeeIcon(props) {
  return (
    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" {...props}>
      <path d="M4 8h13a3 3 0 0 1 0 6H4z" />
      <path d="M4 8v7a4 4 0 0 0 4 4h5a4 4 0 0 0 4-4v-1" />
      <path d="M18 9h2a2 2 0 0 1 0 4h-2" />
    </svg>
  )
}

function BookOpenIcon(props) {
  return (
    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" {...props}>
      <path d="M12 7v14" />
      <path d="M3 6a3 3 0 0 1 3-3h8v15H6a3 3 0 0 0-3 3z" />
      <path d="M21 6a3 3 0 0 0-3-3h-8v15h8a3 3 0 0 1 3 3z" />
    </svg>
  )
}

const DEFAULT_REGIONS = ['Tất cả vùng', 'Miền Bắc', 'Miền Trung', 'Miền Nam']
const DEFAULT_HERO_CUISINES = ['Tất cả món']
const DEFAULT_STATS = [
  { value: '3', label: 'Vùng miền' },
  { value: '100+', label: 'Món ăn' },
  { value: '54', label: 'Dân tộc' },
]

export default function CuisinePage() {
  const [lang, setLang] = useState('vi')
  const navigate = useNavigate()
  const [pageData, setPageData] = useState(null)
  const [status, setStatus] = useState('loading')
  const [error, setError] = useState('')
  const [searchQuery, setSearchQuery] = useState('')
  const [activeFilter, setActiveFilter] = useState(DEFAULT_REGIONS[0])
  const [isDropdownOpen, setIsDropdownOpen] = useState(false)
  const [activeRegion, setActiveRegion] = useState(DEFAULT_REGIONS[0])
  const [isRegionOpen, setIsRegionOpen] = useState(false)
  const [activeHeroCuisine, setActiveHeroCuisine] = useState(DEFAULT_HERO_CUISINES[0])
  const [isHeroCuisineOpen, setIsHeroCuisineOpen] = useState(false)
  const [currentPage, setCurrentPage] = useState(1)

  const ITEMS_PER_PAGE = 6

  useEffect(() => {
    let ignore = false

    async function loadCuisinePage() {
      try {
        setStatus('loading')
        setError('')
        const data = await getCuisines(lang)
        if (!ignore) {
          setPageData(data)
          setStatus('success')
          document.documentElement.lang = lang
        }
      } catch (err) {
        if (!ignore) {
          setError(err.message)
          setStatus('error')
          setPageData(null)
        }
      }
    }

    loadCuisinePage()

    return () => {
      ignore = true
    }
  }, [lang])

  const hero = pageData?.hero || null
  const regions = pageData?.regions?.length ? pageData.regions : DEFAULT_REGIONS
  const heroCuisines = pageData?.heroCuisines?.length ? pageData.heroCuisines : DEFAULT_HERO_CUISINES
  const cards = pageData?.cards || []
  const featuredCards = pageData?.features || []
  const storyCards = pageData?.stories || []
  const masonryImages = pageData?.gallery || []
  const heroStats = hero?.stats?.length ? hero.stats : DEFAULT_STATS

  useEffect(() => {
    if (!regions.includes(activeFilter)) {
      setActiveFilter(regions[0] || DEFAULT_REGIONS[0])
    }
    if (!regions.includes(activeRegion)) {
      setActiveRegion(regions[0] || DEFAULT_REGIONS[0])
    }
  }, [regions, activeFilter, activeRegion])

  useEffect(() => {
    if (!heroCuisines.includes(activeHeroCuisine)) {
      setActiveHeroCuisine(heroCuisines[0] || DEFAULT_HERO_CUISINES[0])
    }
  }, [heroCuisines, activeHeroCuisine])

  useEffect(() => {
    setCurrentPage(1)
  }, [activeFilter, activeHeroCuisine, searchQuery])

  const filteredCards = useMemo(() => {
    const activeRegionLabel = activeFilter === (regions[0] || DEFAULT_REGIONS[0]) ? '' : activeFilter
    const activeCuisineLabel = activeHeroCuisine === (heroCuisines[0] || DEFAULT_HERO_CUISINES[0]) ? '' : activeHeroCuisine
    const query = searchQuery.trim().toLowerCase()

    return cards.filter((card) => {
      const region = (card.region || card.location || '').trim()
      const name = (card.name || '').trim()
      const haystack = [name, region, card.status || '', card.code || ''].join(' ').toLowerCase()

      if (activeRegionLabel && region !== activeRegionLabel) return false
      if (activeCuisineLabel && !name.toLowerCase().includes(activeCuisineLabel.toLowerCase())) return false
      if (query && !haystack.includes(query)) return false
      return true
    })
  }, [cards, activeFilter, activeHeroCuisine, regions, heroCuisines, searchQuery])

  const heroImage = getCuisineLocalImage(hero?.code, hero?.title, hero?.heroImageAlt)
  const resolvedCards = useMemo(
    () => cards.map((card) => ({
      ...card,
      imgUrl: getCuisineLocalImage(card.code, card.name, card.imageAlt),
    })),
    [cards],
  )
  const resolvedFeatures = useMemo(
    () => featuredCards.map((feature) => ({
      ...feature,
      imgUrl: getCuisineLocalImage(feature.code, feature.title, feature.tag, feature.desc),
    })),
    [featuredCards],
  )
  const resolvedStories = useMemo(
    () => storyCards.map((story) => ({
      ...story,
      imgUrl: getCuisineLocalImage(story.code, story.title, story.desc),
    })),
    [storyCards],
  )
  const resolvedGallery = useMemo(
    () => masonryImages.map((img) => ({
      ...img,
      imgUrl: getCuisineLocalImage(img.code, img.title, img.imageAlt),
    })),
    [masonryImages],
  )
  const filteredResolvedCards = useMemo(
    () => filteredCards.map((card) => ({
      ...card,
      imgUrl: getCuisineLocalImage(card.code, card.name, card.imageAlt),
    })),
    [filteredCards],
  )

  const totalPages = Math.max(1, Math.ceil(filteredResolvedCards.length / ITEMS_PER_PAGE))
  const startIndex = (currentPage - 1) * ITEMS_PER_PAGE
  const currentCards = filteredResolvedCards.slice(startIndex, startIndex + ITEMS_PER_PAGE)
  const featureBullets = resolvedFeatures.slice(0, 3)
  const highlightImage = featureBullets[0]?.imgUrl || heroImage || banner3
  const highlightTitle = featureBullets[0]?.title || 'Hương vị của sự giao thoa'
  const highlightText = featureBullets[0]?.desc || hero?.subtitle || 'Mỗi món ăn là một câu chuyện văn hóa được kể bằng hương vị, nguyên liệu và ký ức vùng miền.'
  const hasNoResults = status === 'success' && filteredResolvedCards.length === 0
  const hasLoadedData = status === 'success' && !!pageData

  const handlePageChange = (page) => {
    setCurrentPage(page)
    window.scrollTo({
      top: document.getElementById('cuisine-grid-section')?.offsetTop - 80 || 0,
      behavior: 'smooth',
    })
  }

  const setRegionFilter = (value) => {
    setActiveRegion(value)
    setActiveFilter(value)
    setIsRegionOpen(false)
  }

  const setCuisineFilter = (value) => {
    setActiveHeroCuisine(value)
    setSearchQuery(value === (heroCuisines[0] || DEFAULT_HERO_CUISINES[0]) ? '' : value)
    setIsHeroCuisineOpen(false)
  }

  if (status === 'error' && !pageData) {
    return (
      <div className="cp-page-shell">
        <PageHeader lang={lang} onLangChange={setLang} />
        <main className="cp-main">
          <section className="cp-section cp-section--light">
            <div className="cp-container cp-center">
              <span className="cp-section-eyebrow">Ẩm thực</span>
              <h2 className="cp-section-title cp-serif">Không tải được dữ liệu</h2>
              <p className="cp-section-desc">{error || 'Đã xảy ra lỗi khi tải dữ liệu ẩm thực.'}</p>
            </div>
          </section>
        </main>
        <Footer lang={lang} />
      </div>
    )
  }

  return (
    <div className="cp-page-shell">
      <PageHeader lang={lang} onLangChange={setLang} />

      <main className="cp-main">
        <section className="cp-hero">
          <div className="cp-hero__bg" style={{ backgroundImage: `url(${heroImage || banner3})` }}></div>
          <div className="cp-hero__overlay"></div>

          <div className="cp-hero__ornament cp-hero__ornament--tl"></div>
          <div className="cp-hero__ornament cp-hero__ornament--br"></div>

          <div className="cp-hero__inner">
            <div className="cp-hero__left fade-up">
              <div className="cp-hero__badge">
                <span className="cp-hero__badge-dot"></span>
                {hero?.badge || 'Khám phá ẩm thực 3 miền'}
              </div>

              <h1 className="cp-hero__title">
                <span className="cp-hero__title-accent">{hero?.titleLine1 || 'Tinh Hoa'}</span>
                <span className="cp-hero__title-line">{hero?.titleAccent || 'Ẩm Thực'}</span>
                <span className="cp-hero__title-line">{hero?.titleLine3 || 'Việt Nam'}</span>
              </h1>

              <div className="cp-hero__divider-row">
                <span className="cp-hero__divider-line"></span>
                <span className="cp-hero__divider-diamond">◆</span>
                <span className="cp-hero__divider-line"></span>
              </div>

              <p className="cp-hero__subtitle">
                {hero?.subtitle || 'Từ Bắc tinh tế, Trung đậm đà đến Nam ngọt ngào — mỗi món ăn đều mang theo một câu chuyện văn hóa riêng.'}
              </p>

              <div className="cp-hero__stats">
                {heroStats.map((stat, idx) => (
                  <div key={`${stat.label}-${idx}`} style={{ display: 'contents' }}>
                    <div className="cp-hero__stat">
                      <strong>{stat.value}</strong>
                      <span>{stat.label}</span>
                    </div>
                    {idx < heroStats.length - 1 && <div className="cp-hero__stat-sep">|</div>}
                  </div>
                ))}
              </div>

              <div className="cp-hero__search-bar">
                <div className="cp-search-field-wrapper" style={{ flex: 1.2 }}>
                  <div className="cp-search-field" style={{ paddingLeft: '24px' }}>
                    <LuSearch className="cp-search-icon" />
                    <input
                      type="text"
                      placeholder="Tìm kiếm món ăn..."
                      value={searchQuery}
                      onChange={(event) => setSearchQuery(event.target.value)}
                    />
                  </div>
                </div>

                <div className="cp-search-divider" />

                <div className="cp-search-field-wrapper">
                  <div
                    className={`cp-search-field ${isRegionOpen ? 'active' : ''}`}
                    onClick={() => {
                      setIsRegionOpen(!isRegionOpen)
                      setIsHeroCuisineOpen(false)
                    }}
                  >
                    <span>{activeRegion === (regions[0] || DEFAULT_REGIONS[0]) ? 'Vùng' : activeRegion}</span>
                    <LuChevronDown className={`cp-chevron-icon ${isRegionOpen ? 'rotate' : ''}`} />
                  </div>

                  {isRegionOpen && (
                    <ul className="cp-hero-dropdown">
                      {regions.map((region) => (
                        <li
                          key={region}
                          className={`cp-hero-dropdown-item ${activeRegion === region ? 'selected' : ''}`}
                          onClick={() => setRegionFilter(region)}
                        >
                          {region}
                        </li>
                      ))}
                    </ul>
                  )}
                </div>

                <div className="cp-search-divider" />

                <div className="cp-search-field-wrapper">
                  <div
                    className={`cp-search-field ${isHeroCuisineOpen ? 'active' : ''}`}
                    onClick={() => {
                      setIsHeroCuisineOpen(!isHeroCuisineOpen)
                      setIsRegionOpen(false)
                    }}
                  >
                    <span>{activeHeroCuisine === (heroCuisines[0] || DEFAULT_HERO_CUISINES[0]) ? 'Món ăn' : activeHeroCuisine}</span>
                    <LuChevronDown className={`cp-chevron-icon ${isHeroCuisineOpen ? 'rotate' : ''}`} />
                  </div>

                  {isHeroCuisineOpen && (
                    <ul className="cp-hero-dropdown">
                      {heroCuisines.map((dish) => (
                        <li
                          key={dish}
                          className={`cp-hero-dropdown-item ${activeHeroCuisine === dish ? 'selected' : ''}`}
                          onClick={() => setCuisineFilter(dish)}
                        >
                          {dish}
                        </li>
                      ))}
                    </ul>
                  )}
                </div>

                <button className="cp-hero__cta-btn" type="button" onClick={() => handlePageChange(1)}>
                  Tìm kiếm
                </button>
              </div>
            </div>

            <div className="cp-hero__right fade-up">
              <div className="cp-hero__img-frame">
                <img src={heroImage || highlightImage} alt={hero?.heroImageAlt || 'Ẩm thực'} className="cp-hero__img-main" />
                <div className="cp-hero__img-ring"></div>
                <div className="cp-hero__img-badge">
                  <span className="cp-hero__img-badge-icon">🍲</span>
                  {hero?.badge || 'Bản sắc Việt Nam'}
                </div>
              </div>
            </div>
          </div>

          <div className="cp-section-wave cp-section-wave--bottom">
            <svg data-name="Layer 1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1200 120" preserveAspectRatio="none">
              <path d="M321.39,56.44c58-10.79,114.16-30.13,172-41.86,82.39-16.72,168.19-17.73,250.45-.39C823.78,31,906.67,72,985.66,92.83c70.05,18.48,146.53,26.09,214.34,3V0H0V27.35A600.21,600.21,0,0,0,321.39,56.44Z" fill="#ffffff"></path>
            </svg>
          </div>
        </section>

        <section className="cp-section cp-section--light" id="cuisine-grid-section">
          <div className="cp-container">
            <div className="cp-section-header cp-center">
              <div className="cp-section-title-wrap">
                <span className="cp-section-eyebrow cp-eyebrow-capsule">TINH HOA 3 MIỀN</span>
                <h2 className="cp-section-title cp-serif">Món ăn tiêu biểu</h2>
                <p className="cp-section-desc">
                  <>
                    Mỗi món ăn là một kho tàng hương vị độc đáo, góp phần tạo nên
                    <br />
                    sự đặc sắc của nền ẩm thực đất Việt
                  </>
                </p>
                <div className="cp-divider-ornament" aria-hidden="true">
                  <span className="cp-line-main" />
                  <span className="cp-dot" />
                  <span className="cp-dot" />
                </div>
              </div>
            </div>

            <div className="cp-filters">
              <div style={{ display: 'flex', flexDirection: 'column', gap: '12px', width: '100%' }}>
                <div className="cp-section-desc" style={{ maxWidth: 'none', margin: 0, textAlign: 'left', fontSize: '0.95rem' }}>
                  {`Hiển thị ${filteredResolvedCards.length === 0 ? 0 : startIndex + 1}-${Math.min(startIndex + currentCards.length, filteredResolvedCards.length)} trên ${filteredResolvedCards.length} món ăn${filteredResolvedCards.length < resolvedCards.length ? ` (tổng ${resolvedCards.length} món)` : ''}`}
                </div>
                <div className="cp-custom-dropdown">
                <div
                  className={`cp-dropdown-header ${isDropdownOpen ? 'open' : ''}`}
                  onClick={() => setIsDropdownOpen(!isDropdownOpen)}
                >
                  {activeFilter}
                  <span className="cp-dropdown-arrow">▼</span>
                </div>
                {isDropdownOpen && (
                  <ul className="cp-dropdown-list">
                    {regions.map((region) => (
                      <li
                        key={region}
                        className={`cp-dropdown-item ${activeFilter === region ? 'selected' : ''}`}
                        onClick={() => {
                          setRegionFilter(region)
                          setIsDropdownOpen(false)
                          handlePageChange(1)
                        }}
                      >
                        {region}
                      </li>
                    ))}
                  </ul>
                )}
                </div>
              </div>
            </div>

            {hasNoResults ? (
              <div className="cp-center" style={{ padding: '32px 0' }}>
                <p className="cp-section-desc">Không tìm thấy món ăn phù hợp với bộ lọc hiện tại.</p>
              </div>
            ) : (
              <div className="cp-grid cp-grid--4cols fade-up">
                {currentCards.map((card) => (
                  <div onClick={() => navigate(`/cuisine/${card.code || card.id}`)} className="cp-card cursor-pointer" key={card.code || card.id}>
                    <div className="cp-card__img-wrap">
                      {card.status && <span className="cp-card__status">{card.status}</span>}
                      <img src={card.imgUrl || heroImage || banner3} alt={card.imageAlt || card.name} loading="lazy" />
                    </div>
                    <div className="cp-card__content">
                      <p className="cp-card__loc">
                        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2"><path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z"></path><circle cx="12" cy="10" r="3"></circle></svg>
                        {card.location || card.region}
                      </p>
                      <h3 className="cp-card__title">{card.name}</h3>
                      <span className="cp-card__link">Xem chi tiết</span>
                    </div>
                  </div>
                ))}
              </div>
            )}

            {totalPages > 1 && !hasNoResults && (
              <div className="cp-pagination fade-up">
                <button
                  className="cp-pagination__btn cp-pagination__nav"
                  disabled={currentPage === 1}
                  onClick={() => handlePageChange(Math.max(1, currentPage - 1))}
                >
                  <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
                    <polyline points="15 18 9 12 15 6" />
                  </svg>
                </button>

                <div className="cp-pagination__pages">
                  {Array.from({ length: totalPages }, (_, i) => i + 1).map((page) => (
                    <button
                      key={page}
                      className={`cp-pagination__btn ${currentPage === page ? 'active' : ''}`}
                      onClick={() => handlePageChange(page)}
                      aria-label={`Trang ${page}`}
                      title={`Trang ${page}`}
                    >
                      {page}
                    </button>
                  ))}
                </div>

                <button
                  className="cp-pagination__btn cp-pagination__nav"
                  disabled={currentPage === totalPages}
                  onClick={() => handlePageChange(Math.min(totalPages, currentPage + 1))}
                >
                  <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
                    <polyline points="9 18 15 12 9 6" />
                  </svg>
                </button>
              </div>
            )}
          </div>
        </section>

        {hasLoadedData && featureBullets.length > 0 && (
          <section className="cp-section cp-section--cream cp-section--wavy">
            <div className="cp-section-wave cp-section-wave--top">
              <svg data-name="Layer 1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1200 120" preserveAspectRatio="none">
                <path d="M321.39,56.44c58-10.79,114.16-30.13,172-41.86,82.39-16.72,168.19-17.73,250.45-.39C823.78,31,906.67,72,985.66,92.83c70.05,18.48,146.53,26.09,214.34,3V0H0V27.35A600.21,600.21,0,0,0,321.39,56.44Z" fill="#ffffff"></path>
              </svg>
            </div>

            <div className="cp-container cp-feature-split">
              <div className="cp-feature-img-wrapper fade-up">
                <div className="cp-feature-img-frame">
                  <img src={highlightImage} alt={highlightTitle} />
                </div>
                <div className="cp-feature-img-tag glass-panel">
                  <div className="cp-tag-icon"><StarIcon /></div>
                  <div className="cp-tag-text">
                    <strong>{featureBullets[0]?.title || hero?.badge || 'Ẩm thực Việt'}</strong>
                    <span>{featureBullets[0]?.tag || hero?.subtitle || 'Linh hồn của nền ẩm thực'}</span>
                  </div>
                </div>
              </div>

              <div className="cp-feature-text fade-up delay-1">
                <span className="cp-badge cp-badge--accent">Câu chuyện ẩm thực</span>
                <h2 className="cp-section-title">{highlightTitle}</h2>
                <p className="cp-feature-desc">{highlightText}</p>

                <ul className="cp-feature-list">
                  {featureBullets.map((item, idx) => (
                    <li className="cp-feature-item" key={item.id || idx}>
                      <div className={`cp-fi-icon ${idx === 0 ? 'cp-fi-icon--red' : idx === 1 ? 'cp-fi-icon--orange' : 'cp-fi-icon--brown'}`}>
                        {idx === 0 ? <CoffeeIcon /> : idx === 1 ? <StarIcon /> : <BookOpenIcon />}
                      </div>
                      <div className="cp-fi-content">
                        <h4>{item.title}</h4>
                        <p>{item.desc || highlightText}</p>
                      </div>
                    </li>
                  ))}
                </ul>
              </div>
            </div>

            <div className="cp-section-wave cp-section-wave--bottom">
              <svg data-name="Layer 1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1200 120" preserveAspectRatio="none">
                <path d="M321.39,56.44c58-10.79,114.16-30.13,172-41.86,82.39-16.72,168.19-17.73,250.45-.39C823.78,31,906.67,72,985.66,92.83c70.05,18.48,146.53,26.09,214.34,3V0H0V27.35A600.21,600.21,0,0,0,321.39,56.44Z" fill="#ffffff"></path>
              </svg>
            </div>
          </section>
        )}

        {hasLoadedData && resolvedFeatures.length > 0 && (
          <section className="cp-section cp-section--light">
            <div className="cp-container">
              <div className="cp-section-header cp-flex-header">
                <div>
                  <span className="cp-section-eyebrow">Khám phá</span>
                  <h2 className="cp-section-title">
                    <>
                      Ba miền ẩm thực
                      <br />
                      đặc sắc
                    </>
                  </h2>
                </div>
                <div className="cp-nav-buttons">
                  <button className="cp-nav-btn disable" type="button">&larr;</button>
                  <button className="cp-nav-btn cp-nav-btn--active" type="button">&rarr;</button>
                </div>
              </div>

              <div className="cp-grid cp-grid--3cols fade-up">
                {resolvedFeatures.map((feature) => (
                  <div className="cp-hcard" key={feature.id || feature.title}>
                    <div className="cp-hcard__img">
                      {feature.tag && <span className="cp-card__status">{feature.tag}</span>}
                      <img src={feature.imgUrl || banner3} alt={feature.title} loading="lazy" />
                    </div>
                    <div className="cp-hcard__content">
                      <h3 className="cp-hcard__title">{feature.title}</h3>
                      <p className="cp-hcard__desc">{feature.desc || 'Cùng chiêm nghiệm và khám phá phong vị đặc trưng phản ánh nét đẹp và lối sống qua nghệ thuật ẩm thực.'}</p>
                      <span className="cp-card__link">Tìm hiểu</span>
                    </div>
                  </div>
                ))}
              </div>
            </div>
          </section>
        )}

        {hasLoadedData && resolvedGallery.length > 0 && (
          <section className="cp-section cp-section--cream cp-section--wavy">
            <div className="cp-section-wave cp-section-wave--top">
              <svg data-name="Layer 1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1200 120" preserveAspectRatio="none">
                <path d="M321.39,56.44c58-10.79,114.16-30.13,172-41.86,82.39-16.72,168.19-17.73,250.45-.39C823.78,31,906.67,72,985.66,92.83c70.05,18.48,146.53,26.09,214.34,3V0H0V27.35A600.21,600.21,0,0,0,321.39,56.44Z" fill="#ffffff"></path>
              </svg>
            </div>
            <div className="cp-container">
              <div className="cp-section-header cp-center">
                <span className="cp-section-eyebrow">Thư viện ảnh</span>
                <h2 className="cp-section-title">
                  <>
                    Khoảnh khắc ẩm thực
                    <br />
                    sống động
                  </>
                </h2>
                <p className="cp-section-desc">Những góc máy chân thực nhất làm khơi dậy sự thèm ăn và vẻ rực rỡ của ẩm thực.</p>
              </div>

              <div className="cp-masonry fade-up">
                {resolvedGallery.map((img, idx) => (
                  <div key={img.id || idx} className={`cp-masonry-item cp-masonry-item--${img.size || 'small'}`}>
                    <img src={img.imgUrl || img.imageUrl || banner3} alt={img.imageAlt || 'Khoảnh khắc ẩm thực'} loading="lazy" />
                    <div className="cp-masonry-overlay">
                      <span className="cp-btn-icon">🔍</span>
                    </div>
                  </div>
                ))}
              </div>
            </div>
            <div className="cp-section-wave cp-section-wave--bottom">
              <svg data-name="Layer 1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1200 120" preserveAspectRatio="none">
                <path d="M321.39,56.44c58-10.79,114.16-30.13,172-41.86,82.39-16.72,168.19-17.73,250.45-.39C823.78,31,906.67,72,985.66,92.83c70.05,18.48,146.53,26.09,214.34,3V0H0V27.35A600.21,600.21,0,0,0,321.39,56.44Z" fill="#ffffff"></path>
              </svg>
            </div>
          </section>
        )}

        {hasLoadedData && resolvedStories.length > 0 && (
          <section className="cp-section cp-section--light">
            <div className="cp-container">
              <div className="cp-section-header cp-flex-header">
                <div>
                  <span className="cp-section-eyebrow">Trải nghiệm</span>
                  <h2 className="cp-section-title">
                    <>
                      Chuyện kể
                      <br />
                      ẩm thực
                    </>
                  </h2>
                </div>
                <Link to="/blog" className="cp-link-more">Xem tất cả bài viết &rsaquo;</Link>
              </div>

              <div className="cp-grid cp-grid--3cols fade-up">
                {resolvedStories.map((story, idx) => {
                  const storyLink = story.code ? `/cuisine/${story.code}` : '/cuisine'
                  return (
                    <Link to={storyLink} className="cp-scard" key={story.id || story.code || idx}>
                      <div className="cp-scard__img">
                        <img src={story.imgUrl || banner3} alt={story.title} loading="lazy" />
                      </div>
                      <div className="cp-scard__content">
                        <h3 className="cp-scard__title">{story.title}</h3>
                        <p className="cp-scard__desc">{story.desc}</p>
                        <div className="cp-scard__meta">
                          <span className="cp-meta-author">
                            <div className="cp-avatar"></div> VNCulture
                          </span>
                          <span className="cp-meta-date">24 Mar, 2026</span>
                        </div>
                      </div>
                    </Link>
                  )
                })}
              </div>
            </div>
          </section>
        )}
      </main>

      <Footer lang={lang} />
    </div>
  )
}

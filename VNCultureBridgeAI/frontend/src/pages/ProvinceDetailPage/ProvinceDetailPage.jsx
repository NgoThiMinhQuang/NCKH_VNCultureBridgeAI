import { useMemo, useState, useEffect } from 'react'
import { useParams, Link } from 'react-router-dom'
import { ui } from '../../i18n/messages'
import './ProvinceDetailPage.css'
import PageHeader from '../../components/layout/PageHeader/PageHeader'
import Footer from '../../components/layout/Footer/Footer'
import { getProvince } from '../../services/province.service'
import { useDetailLoader } from '../../hooks/useDetailLoader'
import hanoiStreet from '../../assets/hanoi_street.png'

const FALLBACK_CULTURE_ITEMS = [
  { icon: '🎭', label: 'Múa rối nước' },
  { icon: '📜', label: 'Thư pháp' },
  { icon: '🍶', label: 'Gốm sứ' },
  { icon: '🎻', label: 'Hát Xẩm' },
  { icon: '👗', label: 'Áo dài' },
]

const FALLBACK_CUISINE_ITEMS = [
  { title: 'Phở bò Hà Nội', imageUrl: 'https://images.unsplash.com/photo-1582878826629-29b7ad1cdc43?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=800' },
  { title: 'Bún chả', imageUrl: 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=800' },
  { title: 'Chả cá Lã Vọng', imageUrl: 'https://images.unsplash.com/photo-1512058564366-18510be2db19?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=800' },
]

const FALLBACK_ITINERARY = [
  { time: '07:30', task: 'Bắt đầu ngày mới với một bát phở nóng hổi tại khu Phố Cổ.' },
  { time: '09:00', task: 'Ghé thăm Lăng Bác, Chùa Một Cột và dạo bước tại Quảng trường Ba Đình.' },
  { time: '14:00', task: 'Khám phá Văn Miếu - Quốc Tử Giám, biểu tượng của giáo dục Việt Nam.' },
  { time: '17:00', task: 'Đón hoàng hôn tại Hồ Tây và thưởng thức bánh tôm đặc sản.' },
]

function parseCultureItem(item) {
  if (typeof item === 'string') {
    const match = item.match(/^(.+?)\s+(.+)$/)
    return match ? { icon: match[1], label: match[2] } : { icon: '✨', label: item }
  }

  return item
}

function buildFallbackProvince(copy) {
  const data = copy.provinceDetail.hanoi

  return {
    title: data.title,
    subtitle: data.subtitle,
    heroImageUrl: hanoiStreet,
    heroImageAlt: data.title,
    breadcrumbLabel: data.title,
    region: 'Miền Bắc',
    subRegion: 'Đồng bằng sông Hồng',
    tags: ['Thủ đô', 'Văn hiến', 'Hồ Gươm'],
    metrics: {
      weather: data.metro,
      bestTime: data.bestTimeVal,
      population: data.popVal,
      area: data.areaVal,
    },
    overview: {
      content: data.desc,
      quickInfo: {
        founded: data.foundedVal,
        administrative: data.adminVal,
        timezone: 'UTC+7',
        dialCode: '024',
      },
      sidebarImageUrl: 'https://images.unsplash.com/photo-1543783230-dc081f2163b2?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&q=800',
      sidebarImageAlt: 'Hanoi Journey',
    },
    places: data.places,
    culture: FALLBACK_CULTURE_ITEMS,
    cuisine: FALLBACK_CUISINE_ITEMS,
    itinerary: FALLBACK_ITINERARY,
  }
}

function formatProvinceData(remoteData, fallbackData) {
  if (!remoteData) return null

  return {
    ...fallbackData,
    ...remoteData,
    title: remoteData.name || remoteData.title || fallbackData.title,
    subtitle: remoteData.subtitle || fallbackData.subtitle,
    region: remoteData.region || fallbackData.region,
    subRegion: remoteData.subRegion || fallbackData.subRegion,
    tags: remoteData.tags?.length ? remoteData.tags : fallbackData.tags,
    heroImageUrl: remoteData.heroImageUrl || remoteData.imageUrl || fallbackData.heroImageUrl,
    heroImageAlt: remoteData.heroImageAlt || remoteData.imageAlt || fallbackData.heroImageAlt,
    overview: {
      ...fallbackData.overview,
      ...(remoteData.overview || {}),
      quickInfo: {
        ...fallbackData.overview.quickInfo,
        ...(remoteData.overview?.quickInfo || {}),
      },
    },
    metrics: {
      ...fallbackData.metrics,
      ...(remoteData.metrics || {}),
    },
    places: remoteData.places?.length ? remoteData.places : fallbackData.places,
    culture: remoteData.culture?.length ? remoteData.culture : fallbackData.culture,
    cuisine: remoteData.cuisine?.length ? remoteData.cuisine : fallbackData.cuisine,
    itinerary: remoteData.itinerary?.length ? remoteData.itinerary : fallbackData.itinerary,
  }
}

function getProvinceBadge(data, lang) {
  return data.region || (lang === 'vi' ? 'Khám phá tỉnh thành' : 'Explore Province')
}

function getHeroDescription(data) {
  return String(data.overview?.content || '').split(/\n+/)[0]
}

function getAttractionDescription(place) {
  return place.desc || place.description || ''
}

function getCuisineDescription(dish, data, lang) {
  if (dish.description) return dish.description
  return lang === 'vi'
    ? `Một trong những đặc sản không thể bỏ qua tại ${data.title}.`
    : `One of the signature dishes you should try in ${data.title}.`
}

function getGuideCards(lang, data) {
  return [
    {
      icon: '✈️',
      title: lang === 'vi' ? 'Di chuyển' : 'Getting Around',
      body: data.overview?.quickInfo?.administrative || (lang === 'vi' ? 'Thông tin hành chính và kết nối liên tỉnh.' : 'Administrative and inter-province access information.'),
    },
    {
      icon: '🏨',
      title: lang === 'vi' ? 'Lưu trú' : 'Stays',
      body: data.subRegion || (lang === 'vi' ? 'Lựa chọn lưu trú theo khu vực trung tâm và điểm tham quan.' : 'Choose stays around the center and key attractions.'),
    },
    {
      icon: '🎒',
      title: lang === 'vi' ? 'Trải nghiệm' : 'Experiences',
      body: data.metrics?.bestTime || (lang === 'vi' ? 'Xem mùa đẹp để lên lịch trải nghiệm phù hợp.' : 'Check the best season to plan your experience.'),
    },
    {
      icon: '🛍️',
      title: lang === 'vi' ? 'Đặc trưng địa phương' : 'Local Highlights',
      body: (data.tags || []).join(', ') || (lang === 'vi' ? 'Khám phá những điểm nhấn văn hóa và đặc sản địa phương.' : 'Discover local cultural highlights and specialties.'),
    },
  ]
}

export default function ProvinceDetailPage() {
  const { code = 'ha-noi' } = useParams()
  const [lang, setLang] = useState('vi')
  const copy = useMemo(() => ui[lang], [lang])
  const fallbackData = useMemo(() => buildFallbackProvince(copy), [copy])
  const { status, data: remoteData, error } = useDetailLoader(getProvince, lang, code)
  const data = useMemo(() => formatProvinceData(remoteData, fallbackData), [remoteData, fallbackData])
  const cultureItems = useMemo(() => (data?.culture || []).map(parseCultureItem), [data])
  const guideCards = useMemo(() => (data ? getGuideCards(lang, data) : []), [lang, data])

  useEffect(() => {
    window.scrollTo(0, 0)
  }, [code])

  useEffect(() => {
    if (data?.title) {
      document.title = `${data.title} - VietCultura`
    }
  }, [data?.title])

  if (status === 'loading') {
    return (
      <div className="province-detail">
        <PageHeader lang={lang} onLangChange={setLang} />
        <div className="province-detail__status province-detail__status--loading">
          {lang === 'vi' ? 'Đang tải dữ liệu tỉnh...' : 'Loading province data...'}
        </div>
        <Footer lang={lang} />
      </div>
    )
  }

  if (status === 'error') {
    const isNotFound = /not found/i.test(error || '')

    return (
      <div className="province-detail">
        <PageHeader lang={lang} onLangChange={setLang} />
        <div className="province-detail__status province-detail__status--error">
          {isNotFound
            ? 'Không tìm thấy tỉnh thành phù hợp.'
            : `Không tải được dữ liệu tỉnh. ${error}`}
        </div>
        <div className="province-top-nav">
          <Link to="/" className="breadcrumb-link">Trang chủ</Link>
          <span className="breadcrumb-separator">›</span>
          <Link to="/provinces" className="breadcrumb-link">Tỉnh thành</Link>
        </div>
        <section className="province-section bg-light">
          <div className="section-title center">
            <h2>{isNotFound ? 'Mã tỉnh không tồn tại' : 'Không thể tải dữ liệu tỉnh'}</h2>
            <p>
              {isNotFound
                ? 'Hãy quay lại danh sách tỉnh thành và chọn một địa phương hợp lệ.'
                : 'Vui lòng thử lại hoặc quay về danh sách tỉnh thành.'}
            </p>
            <Link to="/provinces" className="btn-primary">Quay lại danh sách tỉnh thành</Link>
          </div>
        </section>
        <Footer lang={lang} />
      </div>
    )
  }

  if (!data) {
    return null
  }

  return (
    <div className="province-detail">
      <PageHeader lang={lang} onLangChange={setLang} />

      <div className="province-top-nav">
        <Link to="/" className="breadcrumb-link">{lang === 'vi' ? 'Trang chủ' : 'Home'}</Link>
        <span className="breadcrumb-separator">›</span>
        <Link to="/provinces" className="breadcrumb-link">{lang === 'vi' ? 'Tỉnh thành' : 'Provinces'}</Link>
        <span className="breadcrumb-separator">›</span>
        <span className="breadcrumb-current">{data.title}</span>
      </div>

      <section className="province-hero">
        <img
          src={data.heroImageUrl || hanoiStreet}
          alt={data.heroImageAlt || data.title}
          className="province-hero__img"
        />
        <div className="province-hero__overlay">
          <div className="hero-content-wrapper">
            <span className="province-hero__badge">{getProvinceBadge(data, lang)}</span>
            <h1>{data.title}</h1>
            <p className="hero-subtitle">{data.subtitle}</p>
            <p className="hero-desc">{getHeroDescription(data)}</p>
            <div className="hero-actions">
              <Link to="#places" className="btn-primary">{lang === 'vi' ? 'Khám phá điểm đến' : 'Explore places'}</Link>
              <Link to="#itinerary" className="btn-ghost">Lưu hành trình</Link>
            </div>
          </div>
        </div>
      </section>

      <div className="province-metrics-bar">
        <div className="metric-item">
          <div className="metric-item__icon">
            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z"></path><circle cx="12" cy="10" r="3"></circle></svg>
          </div>
          <div className="metric-item__info">
            <span className="metric-item__label">{lang === 'vi' ? 'THUỘC VÙNG' : 'REGION'}</span>
            <span className="metric-item__value">{data.region}</span>
          </div>
        </div>
        <div className="metric-item">
          <div className="metric-item__icon">
            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect><line x1="16" y1="2" x2="16" y2="6"></line><line x1="8" y1="2" x2="8" y2="6"></line><line x1="3" y1="10" x2="21" y2="10"></line></svg>
          </div>
          <div className="metric-item__info">
            <span className="metric-item__label">{lang === 'vi' ? 'MÙA ĐẸP' : 'BEST TIME'}</span>
            <span className="metric-item__value">{data.metrics.bestTime}</span>
          </div>
        </div>
        <div className="metric-item">
          <div className="metric-item__icon">
            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"></path><circle cx="9" cy="7" r="4"></circle><path d="M23 21v-2a4 4 0 0 0-3-3.87"></path><path d="M16 3.13a4 4 0 0 1 0 7.75"></path></svg>
          </div>
          <div className="metric-item__info">
            <span className="metric-item__label">{lang === 'vi' ? 'DÂN SỐ' : 'POPULATION'}</span>
            <span className="metric-item__value">{data.metrics.population}</span>
          </div>
        </div>
        <div className="metric-item">
          <div className="metric-item__icon">
            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><circle cx="12" cy="12" r="10"></circle><polyline points="12 6 12 12 16 14"></polyline></svg>
          </div>
          <div className="metric-item__info">
            <span className="metric-item__label">{lang === 'vi' ? 'DIỆN TÍCH' : 'AREA'}</span>
            <span className="metric-item__value">{data.metrics.area}</span>
          </div>
        </div>
      </div>

      <section className="province-section">
        <div className="overview-layout">
          <div className="overview-main">
            <h2>{lang === 'vi' ? 'Tổng quan vùng đất' : 'Overview'}</h2>
            {String(data.overview.content || '')
              .split(/\n+/)
              .filter(Boolean)
              .map((paragraph, index) => (
                <p key={index}>{paragraph}</p>
              ))}
          </div>
          <div className="overview-sidebar">
            <div className="fact-card">
              <div className="fact-card__icon">
                <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z"></path><circle cx="12" cy="10" r="3"></circle></svg>
              </div>
              <div className="fact-card__info">
                <label>{lang === 'vi' ? 'Vị trí' : 'Administrative'}</label>
                <span>{data.overview.quickInfo.administrative}</span>
              </div>
            </div>
            <div className="fact-card">
              <div className="fact-card__icon">
                <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><circle cx="12" cy="12" r="10"></circle><line x1="2" y1="12" x2="22" y2="12"></line><path d="M12 2a15.3 15.3 0 0 1 4 10 15.3 15.3 0 0 1-4 10 15.3 15.3 0 0 1-4-10 15.3 15.3 0 0 1 4-10z"></path></svg>
              </div>
              <div className="fact-card__info">
                <label>{lang === 'vi' ? 'Diện tích / Dân số' : 'Area / Population'}</label>
                <span>{data.metrics.area} / {data.metrics.population}</span>
              </div>
            </div>
            <div className="fact-card">
              <div className="fact-card__icon">
                <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect><line x1="16" y1="2" x2="16" y2="6"></line><line x1="8" y1="2" x2="8" y2="6"></line><line x1="3" y1="10" x2="21" y2="10"></line></svg>
              </div>
              <div className="fact-card__info">
                <label>{lang === 'vi' ? 'Thời gian lý tưởng' : 'Best Time'}</label>
                <span>{data.metrics.bestTime}</span>
              </div>
            </div>
            <img src={data.overview.sidebarImageUrl || data.imageUrl || hanoiStreet} alt={data.overview.sidebarImageAlt || data.title} className="sidebar-img" />
          </div>
        </div>
      </section>

      <section className="province-section" id="places">
        <div className="section-title center">
          <h2>{lang === 'vi' ? `Đi đâu ở ${data.title}` : `Where to go in ${data.title}`}</h2>
          <p>{lang === 'vi' ? 'Khám phá những địa danh biểu tượng làm nên linh hồn của vùng đất này' : 'Discover the landmarks that define the spirit of this place'}</p>
        </div>
        <div className="attractions-grid">
          {data.places.map((place, idx) => (
            <div key={`${place.title}-${idx}`} className="attraction-card">
              <img
                src={place.imageUrl || `https://images.unsplash.com/photo-1${555939594 + idx}-58d7cb561ad1?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80`}
                alt={place.title}
                className="attraction-card__img"
              />
              <div className="attraction-card__content">
                <h4>{place.title}</h4>
                <p>{getAttractionDescription(place)}</p>
                <div className="attraction-card__meta">
                  <span className="dot">•</span>
                  <span className="meta-text">{lang === 'vi' ? 'Tham quan / Di tích' : 'Visit / Heritage'}</span>
                </div>
              </div>
            </div>
          ))}
        </div>
      </section>

      <section className="province-section culture-section">
        <div className="section-title center white">
          <h2>{lang === 'vi' ? 'Văn hóa và di sản' : 'Culture and Heritage'}</h2>
          <p>{lang === 'vi' ? 'Gìn giữ bản sắc truyền thống qua từng thế hệ' : 'Preserving identity across generations'}</p>
        </div>
        <div className="culture-items">
          {cultureItems.map((item, idx) => (
            <div key={`${item.label}-${idx}`} className="culture-box">
              <div className="culture-box__icon-wrapper">
                <i>{item.icon}</i>
              </div>
              <div className="culture-box__text">
                <span>{item.label}</span>
                <p>{lang === 'vi' ? 'Di sản văn hóa phi vật thể' : 'Intangible cultural heritage'}</p>
              </div>
            </div>
          ))}
        </div>
      </section>

      <section className="province-section">
        <div className="section-title center">
          <h2>{lang === 'vi' ? `Ăn gì ở ${data.title}` : `What to eat in ${data.title}`}</h2>
          <p>{lang === 'vi' ? 'Tinh hoa ẩm thực kỳ công trong từng hương vị' : 'Culinary highlights in every flavor'}</p>
        </div>
        <div className="cuisine-grid">
          {data.cuisine.map((dish, idx) => (
            <div key={`${dish.title}-${idx}`} className="cuisine-card">
              <div className="cuisine-card__img-wrapper">
                <img src={dish.imageUrl} alt={dish.title} />
              </div>
              <div className="cuisine-card__body">
                <h4>{dish.title}</h4>
                <p>{getCuisineDescription(dish, data, lang)}</p>
              </div>
            </div>
          ))}
        </div>
      </section>

      <section className="province-section itinerary-section" id="itinerary">
        <div className="section-title center">
          <h2>{lang === 'vi' ? 'Lịch trình gợi ý' : 'Suggested Itinerary'}</h2>
          <p>{lang === 'vi' ? 'Gợi ý hành trình cho những trải nghiệm trọn vẹn nhất' : 'A suggested route for a complete experience'}</p>
        </div>
        <div className="itinerary-tabs">
          <button className="tab-btn active">1 {lang === 'vi' ? 'ngày' : 'day'}</button>
          <button className="tab-btn">2 {lang === 'vi' ? 'ngày' : 'days'}</button>
          <button className="tab-btn">3 {lang === 'vi' ? 'ngày' : 'days'}</button>
        </div>
        <div className="itinerary-container">
          <div className="timeline-line"></div>
          {data.itinerary.map((item, idx) => (
            <div key={`${item.time}-${idx}`} className="itinerary-step">
              <div className="step-marker"><span></span></div>
              <div className="step-content">
                <strong>{item.time}</strong>
                <p>{item.task}</p>
              </div>
            </div>
          ))}
        </div>
      </section>

      <section className="province-section bg-light">
        <div className="section-title center">
          <h2>{lang === 'vi' ? 'Cẩm nang nhanh' : 'Quick Guide'}</h2>
          <p>{lang === 'vi' ? 'Những thông tin cần biết trước khi đến thăm' : 'Things to know before you visit'}</p>
        </div>
        <div className="guide-grid">
          {guideCards.map((card) => (
            <div key={card.title} className="guide-card">
              <div className="guide-icon">{card.icon}</div>
              <h4>{card.title}</h4>
              <p>{card.body}</p>
            </div>
          ))}
        </div>
      </section>

      <Footer lang={lang} />
    </div>
  )
}

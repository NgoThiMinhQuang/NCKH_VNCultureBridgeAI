import React, { useMemo, useState, useEffect } from 'react'
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
  if (!remoteData) return fallbackData

  return {
    ...fallbackData,
    ...remoteData,
    heroImageUrl: remoteData.heroImageUrl || fallbackData.heroImageUrl,
    heroImageAlt: remoteData.heroImageAlt || fallbackData.heroImageAlt,
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

export default function ProvinceDetailPage() {
  const { code = 'ha-noi' } = useParams()
  const [lang, setLang] = useState('vi')
  const copy = useMemo(() => ui[lang], [lang])
  const t = useMemo(() => copy.provinceDetail, [copy])
  const fallbackData = useMemo(() => buildFallbackProvince(copy), [copy])
  const { status, data: remoteData, error } = useDetailLoader(getProvince, lang, code)
  const data = useMemo(() => formatProvinceData(remoteData, fallbackData), [remoteData, fallbackData])

  useEffect(() => {
    window.scrollTo(0, 0)
  }, [code])

  const cultureItems = data.culture.map(parseCultureItem)

  return (
    <div className="province-detail">
      <PageHeader lang={lang} onLangChange={setLang} />

      {status === 'error' && (
        <div className="province-detail__status province-detail__status--error">
          {lang === 'vi' ? `Không tải được dữ liệu tỉnh. ${error}` : `Could not load province data. ${error}`}
        </div>
      )}

      {status === 'loading' && (
        <div className="province-detail__status province-detail__status--loading">
          {lang === 'vi' ? 'Đang tải dữ liệu tỉnh...' : 'Loading province data...'}
        </div>
      )}

      <section className="province-hero">
        <img
          src={data.heroImageUrl || hanoiStreet}
          alt={data.heroImageAlt || data.title}
          className="province-hero__img"
        />
        <div className="province-hero__overlay">
          <span className="province-hero__breadcrumb">TRANG CHỦ  /  VÙNG MIỀN  /  {data.breadcrumbLabel || data.title}</span>
          <h1>{data.title}</h1>
          <p>{data.subtitle}</p>
          <div className="hero-actions">
            <Link to="#" className="btn-primary">KHÁM PHÁ NGAY</Link>
            <Link to="#" className="btn-ghost">XEM BẢN ĐỒ</Link>
          </div>
        </div>
      </section>

      <div className="province-metrics-bar">
        <div className="metric-item">
          <div className="metric-item__icon">☁️</div>
          <div className="metric-item__info">
            <span className="metric-item__label">{t.metrics.weather}</span>
            <span className="metric-item__value">{data.metrics.weather}</span>
          </div>
        </div>
        <div className="metric-item">
          <div className="metric-item__icon">🍂</div>
          <div className="metric-item__info">
            <span className="metric-item__label">{t.metrics.bestTime}</span>
            <span className="metric-item__value">{data.metrics.bestTime}</span>
          </div>
        </div>
        <div className="metric-item">
          <div className="metric-item__icon">👥</div>
          <div className="metric-item__info">
            <span className="metric-item__label">{t.metrics.population}</span>
            <span className="metric-item__value">{data.metrics.population}</span>
          </div>
        </div>
        <div className="metric-item">
          <div className="metric-item__icon">📏</div>
          <div className="metric-item__info">
            <span className="metric-item__label">{t.metrics.area}</span>
            <span className="metric-item__value">{data.metrics.area}</span>
          </div>
        </div>
      </div>

      <section className="province-section">
        <div className="overview-layout">
          <div className="overview-main">
            <h2>{t.overview.title}</h2>
            {String(data.overview.content || '')
              .split(/\n+/)
              .filter(Boolean)
              .map((paragraph, index) => (
                <p key={index}>{paragraph}</p>
              ))}
          </div>
          <div className="overview-sidebar">
            <div className="sidebar-facts">
              <h3>{t.overview.quickInfo}</h3>
              <div className="fact-row">
                <label>{t.overview.founded}</label>
                <span>{data.overview.quickInfo.founded}</span>
              </div>
              <div className="fact-row">
                <label>{t.overview.administrative}</label>
                <span>{data.overview.quickInfo.administrative}</span>
              </div>
              <div className="fact-row">
                <label>Múi giờ</label>
                <span>{data.overview.quickInfo.timezone}</span>
              </div>
              <div className="fact-row">
                <label>Mã vùng</label>
                <span>{data.overview.quickInfo.dialCode}</span>
              </div>
            </div>
            <img
              src={data.overview.sidebarImageUrl}
              alt={data.overview.sidebarImageAlt || data.title}
              className="sidebar-img"
            />
          </div>
        </div>
      </section>

      <section className="province-section">
        <div className="section-title">
          <h2>{`Đi đâu ở ${data.title}`}</h2>
          <p>Khám phá những địa danh biểu tượng làm nên linh hồn của vùng đất này</p>
        </div>
        <div className="attractions-grid">
          {data.places.map((place, idx) => (
            <div key={`${place.title}-${idx}`} className="attraction-card">
              <img
                src={place.imageUrl || `https://images.unsplash.com/photo-1${555939594 + idx}-58d7cb561ad1?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80`}
                alt={place.title}
                className="attraction-card__img"
              />
              <div className="attraction-card__body">
                <h4>{place.title}</h4>
                <p>{place.desc}</p>
              </div>
            </div>
          ))}
        </div>
      </section>

      <section className="province-section culture-section">
        <div className="section-title">
          <h2 style={{ color: '#fff' }}>Văn hóa và Di sản</h2>
          <p style={{ color: 'rgba(255,255,255,0.7)' }}>Gìn giữ bản sắc truyền thống giữa lòng thành phố hiện đại</p>
        </div>
        <div className="culture-items">
          {cultureItems.map((item, idx) => (
            <div key={`${item.label}-${idx}`} className="culture-box">
              <i>{item.icon}</i>
              <span>{item.label}</span>
            </div>
          ))}
        </div>
      </section>

      <section className="province-section">
        <div className="section-title">
          <h2>{`Ăn gì ở ${data.title}`}</h2>
          <p>Tinh hoa ẩm thực kỳ công trong từng hương vị</p>
        </div>
        <div className="cuisine-grid">
          {data.cuisine.map((dish, idx) => (
            <div key={`${dish.title}-${idx}`} className="cuisine-item">
              <img src={dish.imageUrl} alt={dish.title} />
              <div className="cuisine-item__info">
                <h4>{dish.title}</h4>
                <Link to="#" style={{ color: 'var(--color-secondary)', fontWeight: '700' }}>Khám phá thêm →</Link>
              </div>
            </div>
          ))}
        </div>
      </section>

      <section className="province-section" style={{ background: '#fdf7f2' }}>
        <div className="section-title">
          <h2>Lịch trình gợi ý</h2>
          <p>Gợi ý hành trình cho những trải nghiệm trọn vẹn nhất</p>
        </div>
        <div className="itinerary-container">
          {data.itinerary.map((item, idx) => (
            <div key={`${item.time}-${idx}`} className="itinerary-step">
              <div className="step-marker"></div>
              <div className="step-content">
                <strong>{item.time}</strong>
                <p>{item.task}</p>
              </div>
            </div>
          ))}
        </div>
      </section>

      <section className="province-section" style={{ background: 'var(--color-dark-section)', color: '#fff', textAlign: 'center' }}>
        <div style={{ maxWidth: '800px', margin: '0 auto' }}>
          <h2 style={{ fontFamily: 'var(--font-heading)', fontSize: '3rem', marginBottom: '24px' }}>Cảm hứng gửi đến bạn mỗi tuần</h2>
          <p style={{ color: 'rgba(255,255,255,0.7)', fontSize: '1.2rem', marginBottom: '48px' }}>
            Đăng ký để nhận những thông tin mới nhất về di sản, lễ hội và cẩm nang du lịch Việt Nam qua email.
          </p>
          <div style={{ display: 'flex', gap: '12px', justifyContent: 'center' }}>
            <input
              type="email"
              placeholder="Email của bạn"
              style={{ padding: '18px 24px', borderRadius: '12px', border: '1px solid rgba(255,255,255,0.2)', background: 'rgba(255,255,255,0.05)', color: '#fff', width: '400px' }}
            />
            <button className="btn-primary">ĐĂNG KÝ</button>
          </div>
        </div>
      </section>

      <Footer lang={lang} />
    </div>
  )
}

import { useEffect, useMemo, useState } from 'react'
import { Link } from 'react-router-dom'
import './RegionsPage.css'
import { getHomepage, getRegions } from '../services/api'
import { ui } from '../i18n/messages'

const regionMeta = {
  vi: [
    {
      key: 'north',
      badge: 'Miền Bắc',
      mapLabel: 'Bắc Bộ',
      headline: 'Sắc màu núi rừng và di sản ngàn năm',
      description: 'Từ Hà Nội, vịnh Hạ Long đến những cung đường Tây Bắc, miền Bắc mang đậm chiều sâu lịch sử và thiên nhiên hùng vĩ.',
      highlights: ['Hà Nội', 'Hạ Long', 'Sa Pa'],
    },
    {
      key: 'central',
      badge: 'Miền Trung',
      mapLabel: 'Trung Bộ',
      headline: 'Dải đất di sản giữa biển và núi',
      description: 'Miền Trung nổi bật với cố đô Huế, phố cổ Hội An, Đà Nẵng và những bãi biển trải dài đầy nắng gió.',
      highlights: ['Huế', 'Đà Nẵng', 'Hội An'],
    },
    {
      key: 'south',
      badge: 'Miền Nam',
      mapLabel: 'Nam Bộ',
      headline: 'Nhịp sống sông nước và đô thị sôi động',
      description: 'Miền Nam gợi mở năng lượng trẻ trung của TP.HCM, miền Tây sông nước và các hành trình xanh phương Nam.',
      highlights: ['TP.HCM', 'Cần Thơ', 'Phú Quốc'],
    },
  ],
  en: [
    {
      key: 'north',
      badge: 'Northern Region',
      mapLabel: 'North',
      headline: 'Mountains, heritage, and timeless capital culture',
      description: 'Northern Vietnam blends Hanoi, Ha Long Bay, and the dramatic highlands into a region rich in history and scenery.',
      highlights: ['Hanoi', 'Ha Long', 'Sa Pa'],
    },
    {
      key: 'central',
      badge: 'Central Region',
      mapLabel: 'Central',
      headline: 'A heritage corridor between coast and mountains',
      description: 'Central Vietnam brings together Hue, Hoi An, Da Nang, and a long ribbon of beaches and cultural landmarks.',
      highlights: ['Hue', 'Da Nang', 'Hoi An'],
    },
    {
      key: 'south',
      badge: 'Southern Region',
      mapLabel: 'South',
      headline: 'River life, tropical islands, and modern energy',
      description: 'Southern Vietnam combines Ho Chi Minh City, Mekong Delta experiences, and vibrant journeys across the south.',
      highlights: ['Ho Chi Minh City', 'Can Tho', 'Phu Quoc'],
    },
  ],
}

const featuredMapPoints = {
  vi: {
    north: [
      { id: 'hn', label: 'Hà Nội', x: 58, y: 20, labelX: 78, labelY: 19 },
      { id: 'hl', label: 'Hạ Long', x: 70, y: 24, labelX: 80, labelY: 27 },
      { id: 'sp', label: 'Sa Pa', x: 39, y: 18, labelX: 16, labelY: 18 },
    ],
    central: [
      { id: 'hue', label: 'Huế', x: 57, y: 50, labelX: 76, labelY: 49 },
      { id: 'dn', label: 'Đà Nẵng', x: 58, y: 56, labelX: 78, labelY: 56 },
      { id: 'ha', label: 'Hội An', x: 57, y: 60, labelX: 76, labelY: 61 },
    ],
    south: [
      { id: 'hcm', label: 'TP.HCM', x: 45, y: 81, labelX: 65, labelY: 80 },
      { id: 'ct', label: 'Cần Thơ', x: 37, y: 84, labelX: 13, labelY: 84 },
      { id: 'pq', label: 'Phú Quốc', x: 22, y: 77, labelX: 2, labelY: 76 },
    ],
  },
  en: {
    north: [
      { id: 'hn', label: 'Hanoi', x: 58, y: 20, labelX: 78, labelY: 19 },
      { id: 'hl', label: 'Ha Long', x: 70, y: 24, labelX: 81, labelY: 27 },
      { id: 'sp', label: 'Sa Pa', x: 39, y: 18, labelX: 16, labelY: 18 },
    ],
    central: [
      { id: 'hue', label: 'Hue', x: 57, y: 50, labelX: 77, labelY: 49 },
      { id: 'dn', label: 'Da Nang', x: 58, y: 56, labelX: 79, labelY: 56 },
      { id: 'ha', label: 'Hoi An', x: 57, y: 60, labelX: 77, labelY: 61 },
    ],
    south: [
      { id: 'hcm', label: 'Ho Chi Minh City', x: 45, y: 81, labelX: 64, labelY: 80 },
      { id: 'ct', label: 'Can Tho', x: 37, y: 84, labelX: 14, labelY: 84 },
      { id: 'pq', label: 'Phu Quoc', x: 22, y: 77, labelX: 2, labelY: 76 },
    ],
  },
}

function mergeRegionContent(featuredRegions, listRegions, lang) {
  const meta = regionMeta[lang] || regionMeta.vi
  const baseItems = featuredRegions.length
    ? featuredRegions.slice(0, 3)
    : listRegions.slice(0, 3).map((item) => ({
        ...item,
        title: item.name,
        description: item.type,
      }))

  return meta.map((item, index) => {
    const region = baseItems[index] || listRegions[index] || {}
    return {
      ...item,
      ...region,
      title: region.title || region.name || item.badge,
      description: region.description || item.description,
      imageAlt: region.imageAlt || region.title || region.name || item.badge,
      mapLabel: item.mapLabel,
      highlights: item.highlights,
    }
  })
}

function VietnamMap({ items, activeKey, activePointId, onSelectRegion, onSelectPoint, lang }) {
  const activeItem = items.find((item) => item.key === activeKey)
  const points = featuredMapPoints[lang]?.[activeKey] || []

  return (
    <div className="regions-map">
      <div className="regions-map__canvas">
        <div className="regions-map__country" aria-label="Vietnam regions map">
          <img src="/maps/vietnam-map-base.png" alt="Vietnam map" className="regions-map__base" />
          <button
            type="button"
            className={`regions-map__overlay regions-map__overlay--north${activeKey === 'north' ? ' is-active' : ''}`}
            onMouseEnter={() => onSelectRegion('north')}
            onClick={() => onSelectRegion('north')}
            aria-label="Northern Vietnam"
          >
            <img src="/maps/vietnam-map-north-active.png" alt="Northern Vietnam" />
          </button>
          <button
            type="button"
            className={`regions-map__overlay regions-map__overlay--central${activeKey === 'central' ? ' is-active' : ''}`}
            onMouseEnter={() => onSelectRegion('central')}
            onClick={() => onSelectRegion('central')}
            aria-label="Central Vietnam"
          >
            <img src="/maps/vietnam-map-central-active.png" alt="Central Vietnam" />
          </button>
          <button
            type="button"
            className={`regions-map__overlay regions-map__overlay--south${activeKey === 'south' ? ' is-active' : ''}`}
            onMouseEnter={() => onSelectRegion('south')}
            onClick={() => onSelectRegion('south')}
            aria-label="Southern Vietnam"
          >
            <img src="/maps/vietnam-map-south-active.png" alt="Southern Vietnam" />
          </button>

          {points.map((point) => (
            <div key={point.id} className={`regions-map__point-group${activePointId === point.id ? ' is-active' : ''}`} style={{ left: `${point.x}%`, top: `${point.y}%` }}>
              <button
                type="button"
                className="regions-map__point"
                onMouseEnter={() => onSelectPoint(point.id)}
                onClick={() => onSelectPoint(point.id)}
                aria-label={point.label}
              />
              <span className="regions-map__pulse" aria-hidden="true" />
              <span className="regions-map__connector" style={{ width: `${Math.max(Math.abs(point.labelX - point.x) * 1.2, 22)}%` }} aria-hidden="true" />
              <button
                type="button"
                className="regions-map__point-label"
                style={{ left: `${point.labelX - point.x}%`, top: `${point.labelY - point.y}%` }}
                onMouseEnter={() => onSelectPoint(point.id)}
                onClick={() => onSelectPoint(point.id)}
              >
                {point.label}
              </button>
            </div>
          ))}
        </div>

        <div className={`regions-map__title regions-map__title--north${activeKey === 'north' ? ' is-active' : ''}`}>NORTHERN VIETNAM</div>
        <div className={`regions-map__title regions-map__title--central${activeKey === 'central' ? ' is-active' : ''}`}>CENTRAL VIETNAM</div>
        <div className={`regions-map__title regions-map__title--south${activeKey === 'south' ? ' is-active' : ''}`}>SOUTHERN VIETNAM</div>
      </div>

      <div className="regions-map__mobile-caption">{activeItem?.badge}</div>
    </div>
  )
}

export default function RegionsPage() {
  const [lang, setLang] = useState('vi')
  const [state, setState] = useState({ status: 'loading', data: null, error: '' })
  const [activeKey, setActiveKey] = useState('north')
  const [activePointId, setActivePointId] = useState('hn')
  const copy = useMemo(() => ui[lang], [lang])

  function handleSelectRegion(regionKey) {
    setActiveKey(regionKey)
    const nextPoints = featuredMapPoints[lang]?.[regionKey] || []
    setActivePointId(nextPoints[0]?.id || '')
  }

  useEffect(() => {
    const nextPoints = featuredMapPoints[lang]?.[activeKey] || []
    setActivePointId(nextPoints[0]?.id || '')
  }, [lang, activeKey])

  useEffect(() => {
    let ignore = false

    async function loadRegions() {
      try {
        setState({ status: 'loading', data: null, error: '' })
        const [homepage, regions] = await Promise.all([getHomepage(lang), getRegions(lang)])
        if (!ignore) {
          setState({ status: 'success', data: { homepage, regions }, error: '' })
          document.documentElement.lang = lang
          document.title = lang === 'vi' ? 'VietCultura - Khám phá vùng miền' : 'VietCultura - Explore regions'
        }
      } catch (error) {
        if (!ignore) {
          setState({ status: 'error', data: null, error: error.message })
        }
      }
    }

    loadRegions()
    return () => {
      ignore = true
    }
  }, [lang])

  if (state.status === 'loading') return <div className="page-state">{copy.loading}</div>
  if (state.status === 'error') return <div className="page-state"><p>{copy.error}</p><small>{state.error}</small></div>

  const homepageRegions = state.data?.homepage?.regions || []
  const regions = state.data?.regions || []
  const mappedRegions = mergeRegionContent(homepageRegions, regions, lang)
  const activeRegion = mappedRegions.find((item) => item.key === activeKey) || mappedRegions[0]

  return (
    <div className="regions-page">
      <div className="regions-page__shell">
        <div className="regions-page__hero fade-up">
          <div className="regions-page__hero-copy">
            <span className="regions-page__eyebrow">{copy.regionSectionBadge}</span>
            <h1>{lang === 'vi' ? 'Khám phá Việt Nam qua 3 vùng miền' : 'Discover Vietnam through its three regions'}</h1>
            <p>{lang === 'vi'
              ? 'Tham khảo cách trình bày map-led explorer từ các trang du lịch lớn, rồi tối giản lại cho dự án này: mở đầu bằng bản đồ Việt Nam, chọn 1 trong 3 miền và xem nhanh điểm nhấn từng vùng.'
              : 'Inspired by map-led destination explorers, this page starts with a Vietnam map so visitors can quickly move across the country’s three major cultural regions.'}</p>
          </div>
          <div className="regions-page__hero-actions">
            <div className="lang-toggle" aria-label={copy.language}>
              <button type="button" className={lang === 'vi' ? 'active' : ''} onClick={() => setLang('vi')}>VI</button>
              <button type="button" className={lang === 'en' ? 'active' : ''} onClick={() => setLang('en')}>EN</button>
            </div>
            <Link to="/" className="regions-page__back">{lang === 'vi' ? '← Về trang chủ' : '← Back home'}</Link>
          </div>
        </div>

        <div className="regions-map-stage fade-up">
          <h2>{lang === 'vi' ? 'Bản đồ văn hóa' : 'Cultural map'}</h2>
          <p>{lang === 'vi'
            ? 'Chạm hoặc rê chuột vào từng vùng để khám phá những nét văn hóa đặc trưng từ Bắc chí Nam.'
            : 'Hover or tap each region to explore the cultural identity of Vietnam from north to south.'}</p>
          <VietnamMap items={mappedRegions} activeKey={activeKey} activePointId={activePointId} onSelectRegion={handleSelectRegion} onSelectPoint={setActivePointId} lang={lang} />
        </div>

        <div className="regions-explorer fade-up">
          <div className="regions-explorer__panel">
            <span className="regions-explorer__badge">{activeRegion.badge}</span>
            <div className="regions-explorer__image">
              {activeRegion.imageUrl ? (
                <img src={activeRegion.imageUrl} alt={activeRegion.imageAlt} />
              ) : (
                <div className="regions-explorer__placeholder">{activeRegion.title}</div>
              )}
            </div>
            <div className="regions-explorer__content">
              <h2>{activeRegion.title}</h2>
              <h3>{activeRegion.headline}</h3>
              <p>{activeRegion.description}</p>
              <div className="regions-explorer__chips">
                {activeRegion.highlights.map((highlight) => (
                  <span key={highlight}>{highlight}</span>
                ))}
              </div>
              <div className="regions-explorer__actions">
                <Link to={`/regions/${activeRegion.code || ''}`} className="regions-explorer__cta">
                  {lang === 'vi' ? 'Khám phá vùng này' : 'Explore this region'}
                </Link>
              </div>
            </div>
          </div>

          <div className="regions-explorer__legend-wrap">
            <div className="regions-explorer__legend">
              {mappedRegions.map((item) => (
                <button
                  key={item.key}
                  type="button"
                  className={`regions-explorer__legend-item${activeKey === item.key ? ' is-active' : ''}`}
                  onMouseEnter={() => handleSelectRegion(item.key)}
                  onClick={() => handleSelectRegion(item.key)}
                >
                  <span className={`regions-explorer__legend-dot regions-explorer__legend-dot--${item.key}`} />
                  <strong>{item.badge}</strong>
                  <small>{item.title}</small>
                </button>
              ))}
            </div>
          </div>
        </div>
      </div>
    </div>
  )
}

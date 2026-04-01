import { useEffect, useMemo, useState } from 'react'
import { Link } from 'react-router-dom'
import './RegionsPage.css'
import { getRegions } from '../../services/region.service'
import { ui } from '../../i18n/messages'
import { featuredMapPoints } from '../../components/features/regions/VietnamMap'
import VietnamMap from '../../components/features/regions/VietnamMap'
import LoadingState from '../../components/common/LoadingState/LoadingState'
import PageHeader from '../../components/layout/PageHeader/PageHeader'

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

function mergeRegionContent(listRegions, lang) {
  const meta = regionMeta[lang] || regionMeta.vi
  const baseItems = listRegions.slice(0, 3).map((item) => ({
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
        const regions = await getRegions(lang)
        if (!ignore) {
          setState({ status: 'success', data: { regions }, error: '' })
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
    return () => { ignore = true }
  }, [lang])

  if (state.status === 'loading') return <LoadingState message={copy.loading} />
  if (state.status === 'error') return <LoadingState type="error" message={copy.error} detail={state.error} />

  const regions = state.data?.regions || []
  const mappedRegions = mergeRegionContent(regions, lang)
  const activeRegion = mappedRegions.find((item) => item.key === activeKey) || mappedRegions[0]

  return (
    <div className="regions-page">
      <PageHeader
        lang={lang}
        onLangChange={setLang}
        breadcrumb={[
          { label: lang === 'vi' ? 'Khám phá vùng miền' : 'Explore Regions' },
        ]}
      />

      <div className="regions-page__shell">
        <div className="regions-page__hero fade-up">
          <div className="regions-page__hero-copy">
            <span className="regions-page__eyebrow">{copy.regionSectionBadge}</span>
            <h1>{lang === 'vi' ? 'Khám phá Việt Nam qua 3 vùng miền' : 'Discover Vietnam through its three regions'}</h1>
            <p>{lang === 'vi'
              ? 'Tham khảo cách trình bày map-led explorer từ các trang du lịch lớn, rồi tối giản lại cho dự án này: mở đầu bằng bản đồ Việt Nam, chọn 1 trong 3 miền và xem nhanh điểm nhấn từng vùng.'
              : 'Inspired by map-led destination explorers, this page starts with a Vietnam map so visitors can quickly move across the country\'s three major cultural regions.'}</p>
          </div>
        </div>

        <div className="regions-map-stage fade-up">
          <h2>{lang === 'vi' ? 'Bản đồ văn hóa' : 'Cultural map'}</h2>
          <p>{lang === 'vi'
            ? 'Chạm hoặc rê chuột vào từng vùng để khám phá những nét văn hóa đặc trưng từ Bắc chí Nam.'
            : 'Hover or tap each region to explore the cultural identity of Vietnam from north to south.'}</p>
          <VietnamMap
            items={mappedRegions}
            activeKey={activeKey}
            activePointId={activePointId}
            onSelectRegion={handleSelectRegion}
            onSelectPoint={setActivePointId}
            lang={lang}
          />
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

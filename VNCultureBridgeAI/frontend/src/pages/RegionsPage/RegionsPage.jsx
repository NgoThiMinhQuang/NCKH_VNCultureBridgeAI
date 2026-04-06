import { useEffect, useMemo, useState } from 'react'
import { Link } from 'react-router-dom'
import './RegionsPage.css'
import { getRegions } from '../../services/region.service'
import { ui } from '../../i18n/messages'

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
      experiences: 'Núi non hùng vĩ, văn hóa bản địa, ẩm thực tinh tế',
      atmosphere: 'Cổ kính, đậm đà bản sắc, nhịp sống chậm rãi'
    },
    {
      key: 'central',
      badge: 'Miền Trung',
      mapLabel: 'Trung Bộ',
      headline: 'Dải đất di sản giữa biển và núi',
      description: 'Vùng đất giao thoa giữa di sản, biển xanh và chiều sâu lịch sử tạo nên một bản sắc rất riêng trong hành trình khám phá Việt Nam.',
      highlights: ['Huế', 'Đà Nẵng', 'Hội An'],
      experiences: 'Di sản, biển, kiến trúc cổ',
      atmosphere: 'Sâu lắng, duyên dáng, giàu chiều sâu văn hóa'
    },
    {
      key: 'south',
      badge: 'Miền Nam',
      mapLabel: 'Nam Bộ',
      headline: 'Nhịp sống sông nước và đô thị sôi động',
      description: 'Miền Nam gợi mở năng lượng trẻ trung của TP.HCM, miền Tây sông nước và các hành trình xanh phương Nam.',
      highlights: ['TP.HCM', 'Cần Thơ', 'Phú Quốc'],
      experiences: 'Sông nước mênh mông, chợ nổi, sự giao thoa văn hóa',
      atmosphere: 'Năng động, phóng khoáng, chân tình'
    },
  ],
  en: [
    {
      key: 'north',
      badge: 'Northern',
      mapLabel: 'North',
      headline: 'Mountains, heritage, and timeless capital culture',
      description: 'Northern Vietnam blends Hanoi, Ha Long Bay, and the dramatic highlands into a region rich in history and scenery.',
      highlights: ['Hanoi', 'Ha Long', 'Sa Pa'],
      experiences: 'Majestic mountains, indigenous culture, refined cuisine',
      atmosphere: 'Ancient, rich in identity, slow-paced life'
    },
    {
      key: 'central',
      badge: 'Central',
      mapLabel: 'Central',
      headline: 'A heritage corridor between coast and mountains',
      description: 'A land where heritage, blue seas, and historical depth intersect, creating a very unique identity in the journey to discover Vietnam.',
      highlights: ['Hue', 'Da Nang', 'Hoi An'],
      experiences: 'Heritage, beaches, ancient architecture',
      atmosphere: 'Profound, graceful, culturally rich'
    },
    {
      key: 'south',
      badge: 'Southern',
      mapLabel: 'South',
      headline: 'River life, tropical islands, and modern energy',
      description: 'Southern Vietnam combines Ho Chi Minh City, Mekong Delta experiences, and vibrant journeys across the south.',
      highlights: ['Ho Chi Minh City', 'Can Tho', 'Phu Quoc'],
      experiences: 'Vast rivers, floating markets, cultural intersection',
      atmosphere: 'Dynamic, liberal, sincere'
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
  const copy = useMemo(() => ui[lang], [lang])

  function handleSelectRegion(regionKey) {
    setActiveKey(regionKey)
  }

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
        <div className="regions-split-layout fade-up">
          <div className="regions-split-layout__map">
            <h2>{lang === 'vi' ? 'Bản đồ văn hóa' : 'Cultural map'}</h2>
            <p className="regions-split-layout__map-desc">{lang === 'vi'
              ? 'Chạm hoặc rê chuột vào từng vùng để khám phá những nét văn hóa đặc trưng từ Bắc chí Nam.'
              : 'Hover or tap each region to explore the cultural identity of Vietnam from north to south.'}</p>
            <VietnamMap
              activeKey={activeKey}
              onSelectRegion={handleSelectRegion}
              lang={lang}
            />
          </div>

          <div className="regions-split-layout__content">
            <div className="region-card-wrapper">
              <div className="region-tabs">
                {mappedRegions.map((item) => (
                  <button
                    key={item.key}
                    type="button"
                    className={`region-tab ${activeKey === item.key ? 'is-active' : ''}`}
                    onClick={() => handleSelectRegion(item.key)}
                  >
                    {item.badge}
                  </button>
                ))}
              </div>

              <div className="region-card">
                <div className="region-card__header">
                  <span className="region-card__decorator"></span>
                  <h2>{activeRegion.badge}</h2>
                </div>

                <p className="region-card__desc">{activeRegion.description}</p>

                <div className="region-card__details">
                  <div className="region-card__detail-item">
                    <div className="region-card__detail-icon">
                      <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z"></path><circle cx="12" cy="10" r="3"></circle></svg>
                    </div>
                    <div className="region-card__detail-text">
                      <strong>{lang === 'vi' ? 'Điểm đến nổi bật' : 'Highlighted Destinations'}</strong>
                      <span>{activeRegion.highlights.join(', ')}</span>
                    </div>
                  </div>

                  <div className="region-card__detail-item">
                    <div className="region-card__detail-icon">
                      <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2"></polygon></svg>
                    </div>
                    <div className="region-card__detail-text">
                      <strong>{lang === 'vi' ? 'Trải nghiệm đặc trưng' : 'Signature Experiences'}</strong>
                      <span>{activeRegion.experiences}</span>
                    </div>
                  </div>

                  <div className="region-card__detail-item">
                    <div className="region-card__detail-icon">
                      <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><circle cx="12" cy="12" r="5"></circle><line x1="12" y1="1" x2="12" y2="3"></line><line x1="12" y1="21" x2="12" y2="23"></line><line x1="4.22" y1="4.22" x2="5.64" y2="5.64"></line><line x1="18.36" y1="18.36" x2="19.78" y2="19.78"></line><line x1="1" y1="12" x2="3" y2="12"></line><line x1="21" y1="12" x2="23" y2="12"></line><line x1="4.22" y1="19.78" x2="5.64" y2="18.36"></line><line x1="18.36" y1="5.64" x2="19.78" y2="4.22"></line></svg>
                    </div>
                    <div className="region-card__detail-text">
                      <strong>{lang === 'vi' ? 'Không khí' : 'Atmosphere'}</strong>
                      <span>{activeRegion.atmosphere}</span>
                    </div>
                  </div>
                </div>

                <div className="region-card__actions">
                  <Link to={`/regions/${activeRegion.code || ''}`} className="region-card__btn">
                    {lang === 'vi' ? 'Xem chi tiết vùng miền' : 'Explore this region'} →
                  </Link>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  )
}

import { useEffect, useMemo, useState } from 'react'
import { Link } from 'react-router-dom'
import './RegionsPage.css'
import { getRegions } from '../../services/region.service'
import { ui } from '../../i18n/messages'

import VietnamMap from '../../components/features/regions/VietnamMap'
import PageHeader from '../../components/layout/PageHeader/PageHeader'

// Import Region Overviews
import imgOverviewNorth from '../../assets/images/regions/region_overview_north.png'
import imgOverviewCentral from '../../assets/images/regions/region_overview_central.png'
import imgOverviewSouth from '../../assets/images/regions/region_overview_south.png'

// Import Provinces
import imgProvHaGiang from '../../assets/images/regions/province_hagiang.png'
import imgProvCaoBang from '../../assets/images/regions/province_caobang.png'
import imgProvLaiChau from '../../assets/images/regions/province_laichau.png'
import imgProvLaoCai from '../../assets/images/regions/province_laocai.png'
import imgProvDienBien from '../../assets/images/regions/province_dienbien.png'
import imgProvSonLa from '../../assets/images/regions/province_sonla.png'

// Import Highlights
import imgHlHanoi from '../../assets/images/regions/highlight_hanoi.png'
import imgHlSapa from '../../assets/images/regions/highlight_sapa.png'
import imgHlTrangAn from '../../assets/images/regions/highlight_trangan.png'
import imgHlHue from '../../assets/images/regions/highlight_hue.png'
import imgHlHoiAn from '../../assets/images/regions/highlight_hoian.png'
import imgHlDaNang from '../../assets/images/regions/highlight_danang.png'
import imgHlCanTho from '../../assets/images/regions/highlight_cantho.png'
import imgHlNamBo from '../../assets/images/regions/highlight_nambo.png'

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

const overviewRegions = [
  {
    id: 'north',
    badge: 'Miền Bắc',
    title: 'Núi rừng hùng vĩ, văn hiến nghìn năm',
    desc: 'Từ Hà Giang đến Hạ Long, miền Bắc mang trong mình vẻ đẹp của núi non hùng vĩ, ruộng bậc thang nghìn tầng, và nền văn hóa Kinh Bắc lâu đời. Phố cổ, hồ sen, làng nghề và những món ăn đậm đà tạo nên bản sắc riêng.',
    tags: ['Hà Nội', 'Hạ Long', 'Sa Pa', 'Ninh Bình'],
    image: imgOverviewNorth, 
  },
  {
    id: 'central',
    badge: 'Miền Trung',
    title: 'Di sản hoàng triều, biển xanh cát trắng',
    desc: 'Miền Trung là nơi giao thoa giữa di sản văn hóa thế giới và vẻ đẹp thiên nhiên tuyệt mỹ. Từ cố đô Huế, phố cổ Hội An đến hang động Sơn Đoòng, mỗi điểm đến đều là một câu chuyện lịch sử sống động.',
    tags: ['Huế', 'Hội An', 'Đà Nẵng', 'Phong Nha'],
    image: imgOverviewCentral,
  },
  {
    id: 'south',
    badge: 'Miền Nam',
    title: 'Sông nước mênh mông, nhịp sống năng động',
    desc: 'Đồng bằng sông Cửu Long với những chợ nổi rực rỡ, vườn trái cây trĩu quả, và nét văn hóa đặc trưng. Từ Sài Gòn sôi động đến Phú Quốc thơ mộng, miền Nam là điểm đến của sự năng động và hiếu khách.',
    tags: ['TP. HCM', 'Cần Thơ', 'Phú Quốc', 'Vũng Tàu'],
    image: imgOverviewSouth,
  }
];

const provincesData = [
  { id: 1, name: 'Hà Giang', desc: 'Cao nguyên đá, hoa tam giác mạch, đèo Mã Pí Lèng', tags: ['Cao nguyên đá Đồng Văn', 'Đèo Mã Pì Lèng', 'Hoa tam giác mạch'], region: 'Tây Bắc', image: imgProvHaGiang },
  { id: 2, name: 'Cao Bằng', desc: 'Thác Bản Giốc, động Ngườm Ngao, núi non hùng vĩ', tags: ['Thác Bản Giốc', 'Động Ngườm Ngao', 'Hồ Ba Bể'], region: 'Tây Bắc', image: imgProvCaoBang },
  { id: 3, name: 'Lai Châu', desc: 'Mù Cang Chải, ruộng bậc thang, văn hóa Thái', tags: ['Ruộng bậc thang', 'Đỉnh Phan Xi Păng', 'Làng văn hóa'], region: 'Tây Bắc', image: imgProvLaiChau },
  { id: 4, name: 'Lào Cai', desc: 'Sa Pa, Fansipan, thị trấn sương mù', tags: ['Sa Pa', 'Đỉnh Phan Xi Păng', 'Bản Cát Cát'], region: 'Tây Bắc', image: imgProvLaoCai },
  { id: 5, name: 'Điện Biên', desc: 'Điện Biên Phủ, di tích lịch sử, văn hóa Thái', tags: ['Điện Biên Phủ', 'Đồi A1', 'Thung lũng Mường Thanh'], region: 'Tây Bắc', image: imgProvDienBien },
  { id: 6, name: 'Sơn La', desc: 'Mộc Châu, đồi chè, thác Dải Yếm', tags: ['Cao nguyên Mộc Châu', 'Đồi chè', 'Thác Dải Yếm'], region: 'Tây Bắc', image: imgProvSonLa }
];

const highlightsData = [
  { id: 1, name: 'Phố cổ Hà Nội', desc: 'Không gian cổ kính, nhịp sống chậm rãi và chiều sâu lịch sử tạo nên sức hút rất riêng...', region: 'Miền Bắc', tag: 'Thiên nhiên', image: imgHlHanoi },
  { id: 2, name: 'Ruộng bậc thang Sa Pa', desc: 'Vẻ đẹp thiên nhiên hùng vĩ cùng đời sống bản địa tạo nên trải nghiệm khó quên...', region: 'Miền Bắc', tag: 'Thiên nhiên', image: imgHlSapa },
  { id: 3, name: 'Tràng An Ninh Bình', desc: 'Cảnh quan núi non hùng vĩ và dòng sông uốn lượn tạo nên bức tranh thiên nhiên tuyệt mỹ...', region: 'Miền Bắc', tag: 'Di sản', image: imgHlTrangAn },
  { id: 4, name: 'Cố đô Huế', desc: 'Di sản, ẩm thực và cảnh sắc cùng tôn lên câu chuyện rất riêng của vùng đất này...', region: 'Miền Trung', tag: 'Cố đô', image: imgHlHue },
  { id: 5, name: 'Phố cổ Hội An', desc: 'Ánh đèn lồng lung linh và kiến trúc cổ kính tạo nên không gian thơ mộng độc đáo...', region: 'Miền Trung', tag: 'Phố cổ', image: imgHlHoiAn },
  { id: 6, name: 'Biển Đà Nẵng', desc: 'Bờ biển trải dài cùng không gian hiện đại mang đến trải nghiệm nghỉ dưỡng hoàn hảo...', region: 'Miền Trung', tag: 'Biển', image: imgHlDaNang },
  { id: 7, name: 'Chợ nổi Cần Thơ', desc: 'Nhịp sống sông nước sôi động và màu sắc rực rỡ của miền Tây Nam Bộ...', region: 'Miền Nam', tag: 'Sông nước', image: imgHlCanTho },
  { id: 8, name: 'Miệt vườn Nam Bộ', desc: 'Đời sống bình yên giữa vườn trái cây trĩu quả và dòng sông hiền hòa...', region: 'Miền Nam', tag: 'Đời sống', image: imgHlNamBo },
  { id: 9, name: 'Phú Quốc biển đảo', desc: 'Thiên đường biển xanh cát trắng với vẻ đẹp hoang sơ quyến rũ...', region: 'Miền Nam', tag: 'Biển đảo', image: imgHlDaNang }
];

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

  const isLoading = state.status === 'loading'
  const isError = state.status === 'error'

  const regions = state.data?.regions || []
  const mappedRegions = mergeRegionContent(regions, lang)
  const fallbackRegion = regionMeta[lang]?.[0] || regionMeta.vi[0]
  const activeRegion = mappedRegions.find((item) => item.key === activeKey) || mappedRegions[0] || fallbackRegion

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
            {isLoading ? <div className="regions-loading-inline">{copy.loading}</div> : null}
            {isError ? <div className="regions-loading-inline regions-loading-inline--error">{copy.error}</div> : null}
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
                      <span>{(activeRegion.highlights || []).join(', ')}</span>
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

        {/* Section 1: Overview Regions */}
        <section className="regions-overview-section">
          <div className="regions-overview__container fade-up">
            {overviewRegions.map((region, idx) => {
              const isReversed = idx % 2 !== 0;
              return (
                <div key={region.id} className={`regions-overview__card ${isReversed ? 'is-reversed' : ''}`}>
                  <div className="regions-overview__image-col">
                    <div className="regions-overview__image">
                      {region.image ? (
                        <img src={region.image} alt={region.title} />
                      ) : (
                        <div className="placeholder-image">Ảnh {region.badge}</div>
                      )}
                    </div>
                  </div>
                  <div className="regions-overview__content-col">
                    <span className="regions-overview__badge">{region.badge}</span>
                    <h3 className="regions-overview__title">{region.title}</h3>
                    <p className="regions-overview__desc">{region.desc}</p>
                    <div className="regions-overview__tags">
                      {region.tags.map(tag => (
                        <span key={tag} className="regions-overview__tag">{tag}</span>
                      ))}
                    </div>
                    <Link to="/provinces" state={{ search: region.badge }} className="regions-overview__cta">
                      Xem tỉnh thành trong vùng <span aria-hidden="true">→</span>
                    </Link>
                  </div>
                </div>
              );
            })}
          </div>
          <div className="section-view-all">
            <Link to="/regions" className="provinces__button view-all-btn">Xem tất cả vùng miền →</Link>
          </div>
        </section>

        {/* Section 2: Provinces Grid */}
        <section className="provinces-section">
          <div className="provinces__container fade-up">
            <div className="provinces__header">
              <h2>Khám phá tỉnh thành</h2>
              <p>63 tỉnh thành với những câu chuyện độc đáo và trải nghiệm khó quên</p>
              <Link to="/provinces" className="provinces__button">Xem tất cả tỉnh thành →</Link>
            </div>
            
            <div className="provinces__grid">
              {provincesData.map(prov => (
                <div key={prov.id} className="province-card">
                  <div className="province-card__image-wrapper">
                    {prov.image ? (
                      <img src={prov.image} alt={prov.name} style={{ width: '100%', height: '100%', objectFit: 'cover', borderRadius: '12px' }} />
                    ) : (
                      <div className="province-card__image-placeholder">
                        <svg width="60" height="60" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1" strokeLinecap="round" strokeLinejoin="round" style={{color: '#bcbcbc'}}>
                          <rect x="3" y="3" width="18" height="18" rx="2" ry="2"></rect>
                          <circle cx="8.5" cy="8.5" r="1.5"></circle>
                          <polyline points="21 15 16 10 5 21"></polyline>
                        </svg>
                      </div>
                    )}
                    <span className="province-card__badge">Miền Bắc</span>
                  </div>
                  <div className="province-card__content">
                    <h3>{prov.name}</h3>
                    <p>{prov.desc}</p>
                    <div className="province-card__tags">
                      {prov.tags.map(tag => (
                        <span key={tag} className="province-card__tag-chip">{tag}</span>
                      ))}
                    </div>
                  </div>
                  <div className="province-card__footer">
                    <span className="province-card__location">
                      <span aria-hidden="true">📍</span>
                      {prov.region}
                    </span>
                    <Link to="/provinces" state={{ search: prov.name }} className="province-card__cta">Xem chi tiết <span aria-hidden="true">→</span></Link>
                  </div>
                </div>
              ))}
            </div>
            <div className="section-view-all">
              <Link to="/provinces" className="provinces__button view-all-btn">Xem tất cả tỉnh thành →</Link>
            </div>
          </div>
        </section>

        {/* Section 3: Highlights Grid */}
        <section className="highlights-section fade-up">
          <div className="highlights__container">
            <div className="highlights__header">
              <h2>Điểm nổi bật theo vùng</h2>
              <p>Những trải nghiệm tiêu biểu giúp bạn cảm nhận rõ nét tinh thần của từng miền đất</p>
            </div>
            
            <div className="highlights__grid">
              {highlightsData.map(item => (
                <div key={item.id} className="highlight-card">
                  <div className="highlight-card__image-wrapper">
                    {item.image ? (
                      <img src={item.image} alt={item.name} style={{ width: '100%', height: '100%', objectFit: 'cover' }} />
                    ) : (
                      <div className="highlight-card__image-placeholder">
                        Ảnh {item.name}
                      </div>
                    )}
                    <div className="highlight-card__top-labels">
                      <span className="highlight-card__label-region">{item.region}</span>
                      <span className="highlight-card__label-cat">{item.tag}</span>
                    </div>
                  </div>
                  <div className="highlight-card__content">
                    <h3>{item.name}</h3>
                    <p>{item.desc}</p>
                    <Link to="#" className="highlight-card__cta">Xem chi tiết <span aria-hidden="true">→</span></Link>
                  </div>
                </div>
              ))}
            </div>
            <div className="section-view-all">
              <Link to="/highlights" className="provinces__button view-all-btn">Xem tất cả địa danh →</Link>
            </div>
          </div>
        </section>
      </div>
    </div>
  )
}

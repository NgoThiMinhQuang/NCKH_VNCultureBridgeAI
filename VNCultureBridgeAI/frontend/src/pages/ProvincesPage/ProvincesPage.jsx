import { useState, useMemo, useEffect } from 'react'
import { useLanguage } from '../../context/LanguageContext'
import { Link, useLocation } from 'react-router-dom'
import './ProvincesPage.css'
import PageHeader from '../../components/layout/PageHeader/PageHeader'
import { getProvinces } from '../../services/province.service'
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

const REGION_ORDER_VI = ['Miền Bắc', 'Miền Trung', 'Miền Nam', 'Tây Nguyên', 'Đồng bằng sông Cửu Long']
const REGION_ORDER_EN = ['Northern Vietnam', 'Central Vietnam', 'Southern Vietnam', 'Central Highlands', 'Mekong Delta']

function parseAreaValue(value) {
  if (!value) return 0
  const normalized = String(value).replace(/[^\d.,]/g, '').replace(/\.(?=\d{3}(\D|$))/g, '').replace(',', '.')
  return Number(normalized) || 0
}

function sortRegions(regions, lang) {
  const preferredOrder = lang === 'en' ? REGION_ORDER_EN : REGION_ORDER_VI

  return [...regions].sort((a, b) => {
    const indexA = preferredOrder.indexOf(a)
    const indexB = preferredOrder.indexOf(b)
    if (indexA === -1 && indexB === -1) return a.localeCompare(b, lang === 'vi' ? 'vi' : 'en')
    if (indexA === -1) return 1
    if (indexB === -1) return -1
    return indexA - indexB
  })
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
  'Miền Bắc': imgRegionNorth,
  'Northern Vietnam': imgRegionNorth,
  'Miền Trung': imgRegionCentral,
  'Central Vietnam': imgRegionCentral,
  'Miền Nam': imgRegionSouth,
  'Southern Vietnam': imgRegionSouth,
  'Tây Nguyên': imgRegionCentral,
  'Central Highlands': imgRegionCentral,
  'Đồng bằng sông Cửu Long': imgRegionSouth,
  'Mekong Delta': imgRegionSouth,
}

function getProvinceImage(province) {
  return FALLBACK_IMAGE_BY_CODE[province.code] || FALLBACK_IMAGE_BY_REGION[province.region] || imgHeroRegions || imgRegionNorth
}

export default function ProvincesPage() {
  const { lang, setLang } = useLanguage()
  const location = useLocation()
  const [searchTerm, setSearchTerm] = useState('')
  const [sortBy, setSortBy] = useState('name')
  const [viewMode, setViewMode] = useState('grid')
  const [activeRegion, setActiveRegion] = useState('all')
  const [state, setState] = useState({ status: 'loading', data: [], error: '' })

  useEffect(() => {
    if (location.state?.search) {
      setSearchTerm(location.state.search)
    }
  }, [location.state])

  useEffect(() => {
    let ignore = false

    async function load() {
      try {
        setState({ status: 'loading', data: [], error: '' })
        const provinces = await getProvinces(lang)
        if (!ignore) {
          setState({ status: 'success', data: provinces, error: '' })
        }
      } catch (error) {
        if (!ignore) {
          setState({ status: 'error', data: [], error: error.message })
        }
      }
    }

    load()
    return () => {
      ignore = true
    }
  }, [lang])

  useEffect(() => {
    document.title = 'VietCultura - Tất cả tỉnh thành'
    window.scrollTo(0, 0)
  }, [lang])

  const provinces = state.data || []

  const regionTabs = useMemo(() => {
    const uniqueRegions = [...new Set(provinces.map((province) => province.region).filter(Boolean))]
    return sortRegions(uniqueRegions, lang)
  }, [provinces, lang])

  const filteredData = useMemo(() => {
    let result = provinces.filter((province) => {
      const search = searchTerm.trim().toLowerCase()
      const matchRegion = activeRegion === 'all' || province.region === activeRegion
      if (!search) return matchRegion

      return matchRegion && (
        province.name.toLowerCase().includes(search) ||
        province.region.toLowerCase().includes(search) ||
        province.subRegion.toLowerCase().includes(search) ||
        province.tags.some((tag) => tag.toLowerCase().includes(search))
      )
    })

    result = [...result]
    if (sortBy === 'name') {
      result.sort((a, b) => a.name.localeCompare(b.name, lang === 'vi' ? 'vi' : 'en'))
    } else if (sortBy === 'area') {
      result.sort((a, b) => parseAreaValue(b.area) - parseAreaValue(a.area))
    }

    return result
  }, [provinces, searchTerm, sortBy, activeRegion, lang])

  const groupedData = useMemo(() => {
    return sortRegions([...new Set(filteredData.map((province) => province.region))], lang).reduce((groups, regionName) => {
      groups[regionName] = filteredData.filter((province) => province.region === regionName)
      return groups
    }, {})
  }, [filteredData, lang])

  const stats = useMemo(() => {
    const subRegions = new Set(provinces.map((province) => province.subRegion).filter(Boolean))
    const tags = new Set(provinces.flatMap((province) => province.tags || []))

    return {
      provinceCount: provinces.length,
      regionCount: regionTabs.length,
      subRegionCount: subRegions.size,
      tagCount: tags.size,
    }
  }, [provinces, regionTabs])

  return (
    <div className="provinces-page">
      <PageHeader
        lang={lang}
        onLangChange={setLang}
        breadcrumb={[
          { label: 'Khám phá vùng miền', path: '/regions' },
          { label: 'Tất cả tỉnh thành' },
        ]}
      />

      <main className="provinces-page__content">
        <section className="provinces-hero fade-up">
          <div className="container">
            <h1 className="provinces-hero__title">
              Tất cả tỉnh thành Việt Nam
            </h1>
            <p className="provinces-hero__subtitle">
              Dữ liệu tỉnh thành được tải động từ hệ thống nội dung, hiển thị đúng theo từng địa phương và điều hướng thẳng đến trang chi tiết tương ứng.
            </p>

            <div className="provinces-stats">
              <div className="provinces-stats__card">
                <div className="provinces-stats__icon">🏙️</div>
                <div className="provinces-stats__info">
                  <span className="provinces-stats__value">{stats.provinceCount}</span>
                  <span className="provinces-stats__label">Tỉnh thành</span>
                </div>
              </div>
              <div className="provinces-stats__card">
                <div className="provinces-stats__icon">🗺️</div>
                <div className="provinces-stats__info">
                  <span className="provinces-stats__value">{stats.regionCount}</span>
                  <span className="provinces-stats__label">Vùng hiển thị</span>
                </div>
              </div>
              <div className="provinces-stats__card">
                <div className="provinces-stats__icon">🧭</div>
                <div className="provinces-stats__info">
                  <span className="provinces-stats__value">{stats.subRegionCount}</span>
                  <span className="provinces-stats__label">Tiểu vùng</span>
                </div>
              </div>
              <div className="provinces-stats__card">
                <div className="provinces-stats__icon">🏷️</div>
                <div className="provinces-stats__info">
                  <span className="provinces-stats__value">{stats.tagCount}</span>
                  <span className="provinces-stats__label">Nhãn chủ đề</span>
                </div>
              </div>
            </div>
          </div>
        </section>

        <section className="provinces-filters sticky-top">
          <div className="container">
            <div className="provinces-filters__wrapper">
              <div className="provinces-search">
                <svg className="provinces-search__icon" width="20" height="20" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
                </svg>
                <input
                  type="text"
                  placeholder="Tìm kiếm tỉnh thành, địa danh..."
                  value={searchTerm}
                  onChange={(e) => setSearchTerm(e.target.value)}
                />
                {state.status === 'loading' && (
                  <span className="provinces-search__status">Đang tải dữ liệu động...</span>
                )}
                {state.status === 'error' && (
                  <span className="provinces-search__status">Không tải được dữ liệu tỉnh thành.</span>
                )}
              </div>

              <div className="provinces-sort">
                <div className="provinces-view-toggle">
                  <button
                    className={`provinces-view-btn ${viewMode === 'grid' ? 'is-active' : ''}`}
                    onClick={() => setViewMode('grid')}
                    aria-label="Chế độ lưới"
                  >
                    <svg width="20" height="20" fill="currentColor" viewBox="0 0 24 24"><path d="M4 4h4v4H4V4zm6 0h4v4h-4V4zm6 0h4v4h-4V4zM4 10h4v4H4v-4zm6 0h4v4h-4v-4zm6 0h4v4h-4v-4zM4 16h4v4H4v-4zm6 0h4v4h-4v-4zm6 0h4v4h-4v-4z" /></svg>
                  </button>
                  <button
                    className={`provinces-view-btn ${viewMode === 'list' ? 'is-active' : ''}`}
                    onClick={() => setViewMode('list')}
                    aria-label="Chế độ danh sách"
                  >
                    <svg width="20" height="20" fill="currentColor" viewBox="0 0 24 24"><path d="M4 6h16v2H4V6zm0 5h16v2H4v-2zm0 5h16v2H4v-2z" /></svg>
                  </button>
                </div>
                <span className="provinces-sort__label">Sắp xếp:</span>
                <select value={sortBy} onChange={(e) => setSortBy(e.target.value)}>
                  <option value="name">Tên A-Z</option>
                  <option value="area">Diện tích</option>
                </select>
              </div>
            </div>
          </div>
        </section>

        <div className="provinces-region-nav sticky-top-secondary">
          <div className="container">
            <div className="provinces-region-tabs">
              <button className={activeRegion === 'all' ? 'is-active' : ''} onClick={() => setActiveRegion('all')}>
                Tất cả
              </button>
              {regionTabs.map((region) => (
                <button key={region} className={activeRegion === region ? 'is-active' : ''} onClick={() => setActiveRegion(region)}>
                  {region}
                </button>
              ))}
            </div>
          </div>
        </div>

        <div className="container">
          {Object.entries(groupedData).map(([regionName, regionProvinces]) => (
            regionProvinces.length > 0 && (
              <section key={regionName} className="provinces-region-section fade-up">
                <div className="provinces-region-header">
                  <h2 className="provinces-region-title">{regionName}</h2>
                  <span className="provinces-region-count">
                    {regionProvinces.length} tỉnh thành
                  </span>
                </div>

                <div className={`provinces-grid is-${viewMode}`}>
                  {regionProvinces.map((province) => (
                    <div key={province.id || province.code} className={`province-card-v2 is-${viewMode}`}>
                      <div className="province-card-v2__image">
                        <img
                          src={province.imageUrl || getProvinceImage(province)}
                          alt={province.imageAlt || province.name}
                          onError={(event) => {
                            const fallbackImage = getProvinceImage(province)
                            if (event.currentTarget.src !== fallbackImage) {
                              event.currentTarget.src = fallbackImage
                            }
                          }}
                        />
                        <span className="province-card-v2__badge">{province.subRegion}</span>
                      </div>
                      <div className="province-card-v2__content">
                        <div className="province-card-v2__main">
                          <div className="province-card-v2__title-row">
                            <h3 className="province-card-v2__title">{province.name}</h3>
                            <span className="province-card-v2__type">{province.type}</span>
                          </div>
                        </div>
                        {viewMode === 'grid' && (
                          <div className="province-card-v2__tags">
                            {(province.tags || []).map((tag) => <span key={tag} className="province-card-v2__tag">#{tag}</span>)}
                          </div>
                        )}
                        <div className="province-card-v2__meta">
                          <div className="province-card-v2__meta-item">
                            <span className="icon" title="Diện tích">📐</span>
                            <span className="label">DT:</span>
                            <span className="value">{province.area}</span>
                          </div>
                          <div className="province-card-v2__meta-item">
                            <span className="icon" title="Dân số">👨‍👩‍👧‍👦</span>
                            <span className="label">DS:</span>
                            <span className="value">{province.pop}</span>
                          </div>
                        </div>
                        {viewMode === 'list' && (
                          <div className="province-card-v2__tags">
                            {(province.tags || []).map((tag) => <span key={tag} className="province-card-v2__tag">#{tag}</span>)}
                          </div>
                        )}
                        <Link to={`/provinces/${province.code}`} className="province-card-v2__btn">
                          Xem chi tiết
                          <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
                            <path d="M5 12h14M12 5l7 7-7 7" />
                          </svg>
                        </Link>
                      </div>
                    </div>
                  ))}
                </div>
              </section>
            )
          ))}

          {!filteredData.length && state.status !== 'loading' && (
            <div className="provinces-empty">
              <p>Không tìm thấy tỉnh thành phù hợp.</p>
              <button className="provinces-empty__reset" onClick={() => { setSearchTerm(''); setActiveRegion('all') }}>
                Xóa tìm kiếm
              </button>
            </div>
          )}
        </div>
      </main>
    </div>
  )
}

import { useState, useMemo, useEffect } from 'react'
import { Link, useLocation } from 'react-router-dom'
import './ProvincesPage.css'
import PageHeader from '../../components/layout/PageHeader/PageHeader'
import { getProvinces } from '../../services/province.service'

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

export default function ProvincesPage() {
  const location = useLocation()
  const [lang, setLang] = useState('vi')
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
    document.title = lang === 'vi' ? 'VietCultura - Tất cả tỉnh thành' : 'VietCultura - All Provinces'
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
          { label: lang === 'vi' ? 'Khám phá vùng miền' : 'Explore Regions', path: '/regions' },
          { label: lang === 'vi' ? 'Tất cả tỉnh thành' : 'All Provinces' },
        ]}
      />

      <main className="provinces-page__content">
        <section className="provinces-hero fade-up">
          <div className="container">
            <h1 className="provinces-hero__title">
              {lang === 'vi' ? 'Tất cả tỉnh thành Việt Nam' : 'All Provinces of Vietnam'}
            </h1>
            <p className="provinces-hero__subtitle">
              {lang === 'vi'
                ? 'Dữ liệu tỉnh thành được tải động từ hệ thống nội dung, hiển thị đúng theo từng địa phương và điều hướng thẳng đến trang chi tiết tương ứng.'
                : 'Province data is loaded dynamically from the content system, with correct information for each locality and direct navigation to its matching detail page.'}
            </p>

            <div className="provinces-stats">
              <div className="provinces-stats__card">
                <div className="provinces-stats__icon">🏙️</div>
                <div className="provinces-stats__info">
                  <span className="provinces-stats__value">{stats.provinceCount}</span>
                  <span className="provinces-stats__label">{lang === 'vi' ? 'Tỉnh thành' : 'Provinces'}</span>
                </div>
              </div>
              <div className="provinces-stats__card">
                <div className="provinces-stats__icon">🗺️</div>
                <div className="provinces-stats__info">
                  <span className="provinces-stats__value">{stats.regionCount}</span>
                  <span className="provinces-stats__label">{lang === 'vi' ? 'Vùng hiển thị' : 'Displayed Regions'}</span>
                </div>
              </div>
              <div className="provinces-stats__card">
                <div className="provinces-stats__icon">🧭</div>
                <div className="provinces-stats__info">
                  <span className="provinces-stats__value">{stats.subRegionCount}</span>
                  <span className="provinces-stats__label">{lang === 'vi' ? 'Tiểu vùng' : 'Sub-regions'}</span>
                </div>
              </div>
              <div className="provinces-stats__card">
                <div className="provinces-stats__icon">🏷️</div>
                <div className="provinces-stats__info">
                  <span className="provinces-stats__value">{stats.tagCount}</span>
                  <span className="provinces-stats__label">{lang === 'vi' ? 'Nhãn chủ đề' : 'Topic Tags'}</span>
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
                  placeholder={lang === 'vi' ? 'Tìm kiếm tỉnh thành, địa danh...' : 'Search provinces, landmarks...'}
                  value={searchTerm}
                  onChange={(e) => setSearchTerm(e.target.value)}
                />
                {state.status === 'loading' && (
                  <span className="provinces-search__status">{lang === 'vi' ? 'Đang tải dữ liệu động...' : 'Loading dynamic data...'}</span>
                )}
                {state.status === 'error' && (
                  <span className="provinces-search__status">{lang === 'vi' ? 'Không tải được dữ liệu tỉnh thành.' : 'Could not load province data.'}</span>
                )}
              </div>

              <div className="provinces-sort">
                <div className="provinces-view-toggle">
                  <button
                    className={`provinces-view-btn ${viewMode === 'grid' ? 'is-active' : ''}`}
                    onClick={() => setViewMode('grid')}
                    aria-label="Grid view"
                  >
                    <svg width="20" height="20" fill="currentColor" viewBox="0 0 24 24"><path d="M4 4h4v4H4V4zm6 0h4v4h-4V4zm6 0h4v4h-4V4zM4 10h4v4H4v-4zm6 0h4v4h-4v-4zm6 0h4v4h-4v-4zM4 16h4v4H4v-4zm6 0h4v4h-4v-4zm6 0h4v4h-4v-4z"/></svg>
                  </button>
                  <button
                    className={`provinces-view-btn ${viewMode === 'list' ? 'is-active' : ''}`}
                    onClick={() => setViewMode('list')}
                    aria-label="List view"
                  >
                    <svg width="20" height="20" fill="currentColor" viewBox="0 0 24 24"><path d="M4 6h16v2H4V6zm0 5h16v2H4v-2zm0 5h16v2H4v-2z"/></svg>
                  </button>
                </div>
                <span className="provinces-sort__label">{lang === 'vi' ? 'Sắp xếp:' : 'Sort by:'}</span>
                <select value={sortBy} onChange={(e) => setSortBy(e.target.value)}>
                  <option value="name">{lang === 'vi' ? 'Tên A-Z' : 'Name A-Z'}</option>
                  <option value="area">{lang === 'vi' ? 'Diện tích' : 'Area'}</option>
                </select>
              </div>
            </div>
          </div>
        </section>

        <div className="provinces-region-nav sticky-top-secondary">
          <div className="container">
            <div className="provinces-region-tabs">
              <button className={activeRegion === 'all' ? 'is-active' : ''} onClick={() => setActiveRegion('all')}>
                {lang === 'vi' ? 'Tất cả' : 'All'}
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
                    {regionProvinces.length} {lang === 'vi' ? 'tỉnh thành' : 'provinces'}
                  </span>
                </div>

                <div className={`provinces-grid is-${viewMode}`}>
                  {regionProvinces.map((province) => (
                    <div key={province.id || province.code} className={`province-card-v2 is-${viewMode}`}>
                      <div className="province-card-v2__image">
                        {province.imageUrl ? (
                          <img src={province.imageUrl} alt={province.imageAlt || province.name} />
                        ) : (
                          <div className="province-card-v2__placeholder">{province.name}</div>
                        )}
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
                            <span className="icon" title="Area">📐</span>
                            <span className="label">DT:</span>
                            <span className="value">{province.area}</span>
                          </div>
                          <div className="province-card-v2__meta-item">
                            <span className="icon" title="Population">👨‍👩‍👧‍👦</span>
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
                          {lang === 'vi' ? 'Xem chi tiết' : 'View Detail'}
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
              <p>{lang === 'vi' ? 'Không tìm thấy tỉnh thành phù hợp.' : 'No provinces found match your search.'}</p>
              <button className="provinces-empty__reset" onClick={() => { setSearchTerm(''); setActiveRegion('all') }}>
                {lang === 'vi' ? 'Xóa tìm kiếm' : 'Clear search'}
              </button>
            </div>
          )}
        </div>
      </main>
    </div>
  )
}

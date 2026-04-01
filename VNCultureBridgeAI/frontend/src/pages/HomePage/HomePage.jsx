import { useEffect, useMemo, useState } from 'react'
import { Link } from 'react-router-dom'
import './HomePage.css'
import banner3 from '../../assets/banner3.jpg'
import { getHomepage } from '../../services/homepage.service'
import { searchArticles } from '../../services/content.service'
import { ui } from '../../i18n/messages'
import CardGrid from '../../components/common/CardGrid/CardGrid'
import SectionHeading from '../../components/common/SectionHeading/SectionHeading'
import LoadingState from '../../components/common/LoadingState/LoadingState'
import PageHeader from '../../components/layout/PageHeader/PageHeader'
import Footer from '../../components/layout/Footer/Footer'

const homepageRegionMeta = [
  {
    key: 'north',
    badge: 'Miền Bắc',
    number: '01',
    title: 'Miền Bắc',
    headline: 'Di sản ngàn năm và sắc màu miền núi',
    description: 'Khám phá Hà Nội, Hạ Long và những ruộng bậc thang hùng vĩ của vùng núi phía Bắc.',
    highlights: ['Hà Nội', 'Hạ Long', 'Sa Pa', 'Hà Giang'],
    accentClass: 'is-north',
    cta: 'Khám phá Miền Bắc',
  },
  {
    key: 'central',
    badge: 'Miền Trung',
    number: '02',
    title: 'Miền Trung',
    headline: 'Dải đất di sản, đèn lồng và biển xanh',
    description: 'Từ Huế, Hội An đến Đà Nẵng, miền Trung mang vẻ đẹp giao hòa giữa lịch sử và thiên nhiên.',
    highlights: ['Huế', 'Hội An', 'Đà Nẵng', 'Mỹ Sơn'],
    accentClass: 'is-central',
    cta: 'Khám phá Miền Trung',
  },
  {
    key: 'south',
    badge: 'Miền Nam',
    number: '03',
    title: 'Miền Nam',
    headline: 'Sông nước phương Nam và nhịp sống hiện đại',
    description: 'Miền Nam nổi bật với TP.HCM, miền Tây sông nước và hành trình ẩm thực, chợ nổi, biển đảo.',
    highlights: ['TP.HCM', 'Cần Thơ', 'Mekong', 'Phú Quốc'],
    accentClass: 'is-south',
    cta: 'Khám phá Miền Nam',
  },
]

function buildHomepageRegions(regions = []) {
  return homepageRegionMeta.map((meta, index) => {
    const region = regions[index] || {}
    return {
      ...meta,
      code: region.code || '',
      imageUrl: region.imageUrl || null,
      imageAlt: region.imageAlt || meta.title,
      fallbackTitle: region.title || meta.title,
    }
  })
}

export default function HomePage() {
  const [lang, setLang] = useState('vi')
  const [homepage, setHomepage] = useState(null)
  const [status, setStatus] = useState('loading')
  const [error, setError] = useState('')
  const [search, setSearch] = useState('')
  const [results, setResults] = useState([])
  const [searching, setSearching] = useState(false)

  const copy = useMemo(() => ui[lang], [lang])

  useEffect(() => {
    let ignore = false
    async function loadHomepage() {
      try {
        setStatus('loading')
        setError('')
        const data = await getHomepage(lang)
        if (!ignore) {
          setHomepage(data)
          setStatus('success')
          document.documentElement.lang = lang
          document.title = lang === 'vi' ? 'VietCultura - Khám phá Việt Nam' : 'VietCultura - Discover Vietnam'
        }
      } catch (err) {
        if (!ignore) {
          setError(err.message)
          setStatus('error')
        }
      }
    }
    loadHomepage()
    return () => { ignore = true }
  }, [lang])

  async function handleSearch(event) {
    event.preventDefault()
    try {
      setSearching(true)
      const data = await searchArticles({ lang, q: search, limit: 6 })
      setResults(data)
    } finally {
      setSearching(false)
    }
  }

  if (status === 'loading') return <LoadingState message={copy.loading} />
  if (status === 'error') return <LoadingState type="error" message={copy.error} detail={error} />

  const homepageRegions = buildHomepageRegions(homepage.regions)

  return (
    <div className="page-shell">
      <PageHeader
        lang={lang}
        onLangChange={setLang}
        renderNav={() => (
          <nav className="ph__nav" aria-label="Main navigation">
            <a href="#hero" className="ph__nav-link">{copy.nav[0]}</a>

            {/* Link trang vùng miền thay vì mega-menu */}
            <Link to="/regions" className="ph__nav-link">{copy.nav[1]}</Link>


            <Link to="/ethnic-groups" className="ph__nav-link">{copy.nav[2]}</Link>
            <a href="#festivals" className="ph__nav-link">{copy.nav[3]}</a>
            <a href="#cuisine" className="ph__nav-link">{copy.nav[4]}</a>
            <Link to="/articles" className="ph__nav-link">{copy.nav[5]}</Link>
            <a href="#blog" className="ph__nav-link">{copy.nav[6]}</a>
          </nav>
        )}
      />


      <main>
        <section
          className="hero-section"
          id="hero"
          style={{
            backgroundImage: `linear-gradient(rgba(30, 15, 10, 0.26), rgba(30, 15, 10, 0.4)), url(${banner3})`,
          }}
        >
          <div className="hero-content hero-content--animated">
            <span className="section-badge">{homepage.hero.badge}</span>
            <h1>{homepage.hero.title}</h1>
            <p>{homepage.hero.subtitle}</p>
            <div className="hero-actions">
              <Link to="/regions" className="primary-button nav-link-button">{homepage.hero.primaryCta}</Link>
              <a href="#festivals" className="secondary-button nav-link-button">{homepage.hero.secondaryCta}</a>
            </div>
            <form className="ai-guide__composer search-bar glass-panel" onSubmit={handleSearch}>
              <input
                value={search}
                onChange={(e) => setSearch(e.target.value)}
                placeholder={lang === 'vi' ? 'Tìm kiếm bài viết, vùng miền, món ăn...' : 'Search articles, regions, dishes...'}
              />
              <button type="submit" className="gradient-button nav-link-button" disabled={searching}>
                {searching ? '...' : copy.search}
              </button>
            </form>
            {results.length ? (
              <div className="search-results fade-up">
                <CardGrid items={results} variant="blog-grid" actionLabel={copy.learnMore} lang={lang} basePath="/articles" />
              </div>
            ) : null}
            <div className="stats-row">
              {homepage.stats.map((stat) => (
                <div key={stat.label} className="stat-card float-card">
                  <strong>{stat.value}</strong>
                  <span>{stat.label}</span>
                </div>
              ))}
            </div>
          </div>
        </section>

        <div className="page-content-shell">
          <section className="content-section regions-section regions-showcase" id="regions">
            <div className="regions-showcase__heading fade-up">
              <span className="regions-showcase__eyebrow">Khám phá Việt Nam</span>
              <h2>Ba miền văn hóa đặc sắc</h2>
              <p>
                Từ miền núi phía Bắc đến dải đất miền Trung và vùng sông nước phương Nam, mỗi miền đều có bản sắc,
                nhịp sống và vẻ đẹp riêng để bạn khám phá.
              </p>
            </div>

            <div className="regions-showcase__grid">
              {homepageRegions.map((region) => (
                <article key={region.key} className={`region-showcase-card fade-up ${region.accentClass}`}>
                  {region.imageUrl ? (
                    <img src={region.imageUrl} alt={region.imageAlt} className="region-showcase-card__image" />
                  ) : (
                    <div className="region-showcase-card__image region-showcase-card__image--placeholder">
                      {region.fallbackTitle}
                    </div>
                  )}

                  <div className="region-showcase-card__overlay" />

                  <div className="region-showcase-card__content">
                    <div className="region-showcase-card__top">
                      <span className="region-showcase-card__badge">{region.badge}</span>
                      <span className="region-showcase-card__number">{region.number}</span>
                    </div>

                    <div className="region-showcase-card__body">
                      <h3>{region.title}</h3>
                      <p className="region-showcase-card__description">{region.description}</p>

                      <div className="region-showcase-card__chips">
                        {region.highlights.map((item) => (
                          <span key={item}>{item}</span>
                        ))}
                      </div>
                    </div>

                    <Link to={`/regions/${region.code}`} className="region-showcase-card__cta">
                      {region.cta}
                      <span aria-hidden="true">→</span>
                    </Link>
                  </div>
                </article>
              ))}
            </div>
          </section>

          <section className="content-section dark-section" id="ethnic-groups">
            <SectionHeading badge={copy.ethnicSectionBadge} title={copy.ethnicSectionTitle} description={copy.ethnicSectionDescription} />
            <CardGrid items={homepage.ethnicGroups} variant="ethnic-grid" actionLabel={copy.learnMore} lang={lang} basePath="/ethnic-groups" />
          </section>

          <section className="content-section light-section" id="festivals">
            <SectionHeading badge={copy.festivalSectionBadge} title={copy.festivalSectionTitle} description={copy.festivalSectionDescription} />
            <CardGrid items={homepage.festivals} variant="festival-grid" actionLabel={copy.learnMore} lang={lang} basePath="/articles" />
          </section>

          <section className="content-section light-section" id="cuisine">
            <SectionHeading badge={copy.cuisineSectionBadge} title={copy.cuisineSectionTitle} description={copy.cuisineSectionDescription} />
            <CardGrid items={homepage.cuisine} variant="cuisine-grid" actionLabel={copy.learnMore} lang={lang} basePath="/articles" />
          </section>

          <section className="content-section light-section arts-layout" id="arts">
            <SectionHeading badge={copy.artsSectionBadge} title={copy.artsSectionTitle} description={copy.artsSectionDescription} />
            <CardGrid items={homepage.arts} variant="arts-grid" actionLabel={copy.learnMore} lang={lang} basePath="/articles" />
          </section>

          <section className="content-section light-section" id="blog">
            <SectionHeading badge={copy.blogSectionBadge} title={copy.blogSectionTitle} description={copy.blogSectionDescription} />
            <CardGrid items={homepage.blogPosts} variant="blog-grid" actionLabel={copy.viewAll} lang={lang} basePath="/articles" />
          </section>
        </div>
      </main>

      <Footer lang={lang} />
    </div>
  )
}

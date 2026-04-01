import { useEffect, useMemo, useState } from 'react'
import { Link } from 'react-router-dom'
import { getHomepage } from '../../services/homepage.service'
import { searchArticles } from '../../services/content.service'
import { ui } from '../../i18n/messages'
import CardGrid from '../../components/common/CardGrid/CardGrid'
import SectionHeading from '../../components/common/SectionHeading/SectionHeading'
import LoadingState from '../../components/common/LoadingState/LoadingState'
import PageHeader from '../../components/layout/PageHeader/PageHeader'
import Footer from '../../components/layout/Footer/Footer'

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


            <a href="#ethnic-groups" className="ph__nav-link">{copy.nav[2]}</a>
            <a href="#festivals" className="ph__nav-link">{copy.nav[3]}</a>
            <a href="#cuisine" className="ph__nav-link">{copy.nav[4]}</a>
            <Link to="/articles" className="ph__nav-link">{copy.nav[5]}</Link>
            <a href="#blog" className="ph__nav-link">{copy.nav[6]}</a>
          </nav>
        )}
      />


      <main>
        <section className="hero-section" id="hero">
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

        <section className="intro-strip fade-up">
          <h2>{homepage.intro.title}</h2>
          <p>{homepage.intro.body}</p>
        </section>

        <section className="content-section regions-section" id="regions">
          <SectionHeading badge={copy.regionSectionBadge} title={copy.regionSectionTitle} description={copy.regionSectionDescription} />
          <CardGrid items={homepage.regions} variant="region-grid" actionLabel={copy.learnMore} lang={lang} basePath="/regions" />
          <div className="region-map-cta-wrap fade-up">
            <Link to="/regions" className="region-map-cta">
              <span>{copy.regionMapCta}</span>
              <span className="region-map-cta__icon" aria-hidden="true">⌖</span>
            </Link>
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
      </main>

      <Footer lang={lang} />
    </div>
  )
}

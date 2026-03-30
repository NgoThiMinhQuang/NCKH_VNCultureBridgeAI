import { useEffect, useMemo, useState } from 'react'
import { BrowserRouter, Link, Route, Routes, useParams } from 'react-router-dom'
import './App.css'
import { getArticle, getEthnicity, getHomepage, getRegion } from './services/api'
import { ui } from './i18n/messages'

function formatDate(value, lang) {
  if (!value) return ''

  const match = String(value).match(/\/(?:Date)\((\d+)\)\//)
  const timestamp = match ? Number(match[1]) : Date.parse(value)

  if (Number.isNaN(timestamp)) return ''

  return new Intl.DateTimeFormat(lang === 'vi' ? 'vi-VN' : 'en-US', {
    day: '2-digit',
    month: 'short',
    year: 'numeric',
  }).format(new Date(timestamp))
}

function SectionHeading({ badge, title, description }) {
  return (
    <div className="section-heading">
      <span className="section-badge">{badge}</span>
      <h2>{title}</h2>
      <p>{description}</p>
    </div>
  )
}

function CardGrid({ items, variant = 'default', actionLabel, lang, basePath }) {
  return (
    <div className={`card-grid ${variant}`}>
      {items.map((item) => (
        <article key={`${variant}-${item.code}`} className="content-card">
          <div className="content-card__media">
            {item.imageUrl ? (
              <img src={item.imageUrl} alt={item.imageAlt || item.title} />
            ) : (
              <div className="content-card__placeholder">{item.title}</div>
            )}
          </div>
          <div className="content-card__body">
            <div className="content-card__meta">
              {item.category && <span>{item.category}</span>}
              {item.publishedAt ? <span>{formatDate(item.publishedAt, lang)}</span> : null}
              {!item.publishedAt && item.articleCount ? <span>{item.articleCount}+</span> : null}
            </div>
            <h3>{item.title}</h3>
            {item.description && <p>{item.description}</p>}
            <Link to={`${basePath}/${item.code}`} className="text-link">
              {actionLabel}
            </Link>
          </div>
        </article>
      ))}
    </div>
  )
}

function useDetailLoader(loader, lang, code) {
  const [state, setState] = useState({ status: 'loading', data: null, error: '' })

  useEffect(() => {
    let ignore = false

    async function load() {
      try {
        setState({ status: 'loading', data: null, error: '' })
        const data = await loader(code, lang)
        if (!ignore) {
          setState({ status: 'success', data, error: '' })
        }
      } catch (error) {
        if (!ignore) {
          setState({ status: 'error', data: null, error: error.message })
        }
      }
    }

    load()

    return () => {
      ignore = true
    }
  }, [loader, code, lang])

  return state
}

function ArticleDetailPage({ lang = 'vi' }) {
  const { code } = useParams()
  const { status, data, error } = useDetailLoader(getArticle, lang, code)

  if (status === 'loading') return <div className="page-state">Loading article...</div>
  if (status === 'error') return <div className="page-state">{error}</div>

  return (
    <div className="detail-page">
      <div className="detail-page__inner">
        <Link to="/" className="text-link back-link">← Back home</Link>
        <div className="detail-hero">
          {data.imageUrl ? <img src={data.imageUrl} alt={data.imageAlt || data.title} /> : null}
        </div>
        <div className="detail-meta">{formatDate(data.publishedAt, lang)}</div>
        <h1>{data.title}</h1>
        <p className="detail-lead">{data.description}</p>
        {data.intro && <section><h2>Intro</h2><p>{data.intro}</p></section>}
        {data.origin && <section><h2>Origin</h2><p>{data.origin}</p></section>}
        {data.meaning && <section><h2>Cultural meaning</h2><p>{data.meaning}</p></section>}
        {data.context && <section><h2>Context</h2><p>{data.context}</p></section>}
        {data.content && <section><h2>Main content</h2><p>{data.content}</p></section>}
      </div>
    </div>
  )
}

function RegionDetailPage({ lang = 'vi' }) {
  const { code } = useParams()
  const { status, data, error } = useDetailLoader(getRegion, lang, code)

  if (status === 'loading') return <div className="page-state">Loading region...</div>
  if (status === 'error') return <div className="page-state">{error}</div>

  return (
    <div className="detail-page">
      <div className="detail-page__inner">
        <Link to="/" className="text-link back-link">← Back home</Link>
        <h1>{data.name}</h1>
        <p className="detail-lead">{data.type}</p>
      </div>
    </div>
  )
}

function EthnicityDetailPage({ lang = 'vi' }) {
  const { code } = useParams()
  const { status, data, error } = useDetailLoader(getEthnicity, lang, code)

  if (status === 'loading') return <div className="page-state">Loading ethnic group...</div>
  if (status === 'error') return <div className="page-state">{error}</div>

  return (
    <div className="detail-page">
      <div className="detail-page__inner">
        <Link to="/" className="text-link back-link">← Back home</Link>
        <h1>{data.name}</h1>
        <p className="detail-lead">{data.description}</p>
      </div>
    </div>
  )
}

function AIGuidePage() {
  return (
    <div className="detail-page">
      <div className="detail-page__inner">
        <Link to="/" className="text-link back-link">← Back home</Link>
        <h1>AI Guide</h1>
        <p className="detail-lead">
          Trang AI Guide riêng đã sẵn route. Bước sau có thể mở rộng thành giao diện chat thật nối với logs và prompt templates.
        </p>
      </div>
    </div>
  )
}

function HomePage() {
  const [lang, setLang] = useState('vi')
  const [homepage, setHomepage] = useState(null)
  const [status, setStatus] = useState('loading')
  const [error, setError] = useState('')

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

    return () => {
      ignore = true
    }
  }, [lang])

  if (status === 'loading') {
    return <div className="page-state">{copy.loading}</div>
  }

  if (status === 'error') {
    return (
      <div className="page-state">
        <p>{copy.error}</p>
        <small>{error}</small>
        <button type="button" onClick={() => setLang((current) => (current === 'vi' ? 'en' : 'vi'))}>
          {copy.retry}
        </button>
      </div>
    )
  }

  return (
    <div className="page-shell">
      <header className="site-header">
        <div className="brand-mark">
          <div className="brand-logo">VC</div>
          <div>
            <strong>VietCultura</strong>
            <span>{lang === 'vi' ? 'Khám phá Việt Nam' : 'Discover Vietnam'}</span>
          </div>
        </div>

        <nav className="site-nav">
          {copy.nav.map((item, index) => (
            <a key={item} href={index === 0 ? '#hero' : '#'}>
              {item}
            </a>
          ))}
        </nav>

        <div className="site-actions">
          <button type="button" className="ghost-button">
            {copy.search}
          </button>
          <Link to="/ai-guide" className="gradient-button nav-link-button">
            {copy.aiGuide}
          </Link>
          <button type="button" className="outline-button">
            {copy.login}
          </button>
          <div className="lang-toggle" aria-label={copy.language}>
            <button type="button" className={lang === 'vi' ? 'active' : ''} onClick={() => setLang('vi')}>VI</button>
            <button type="button" className={lang === 'en' ? 'active' : ''} onClick={() => setLang('en')}>EN</button>
          </div>
        </div>
      </header>

      <main>
        <section className="hero-section" id="hero">
          <div className="hero-overlay" />
          <div className="hero-content">
            <span className="section-badge">{homepage.hero.badge}</span>
            <h1>{homepage.hero.title}</h1>
            <p>{homepage.hero.subtitle}</p>
            <div className="hero-actions">
              <a href="#regions" className="primary-button nav-link-button">{homepage.hero.primaryCta}</a>
              <a href="#festivals" className="secondary-button nav-link-button">{homepage.hero.secondaryCta}</a>
            </div>
            <div className="stats-row">
              {homepage.stats.map((stat) => (
                <div key={stat.label} className="stat-card">
                  <strong>{stat.value}</strong>
                  <span>{stat.label}</span>
                </div>
              ))}
            </div>
          </div>
        </section>

        <section className="intro-strip">
          <h2>{homepage.intro.title}</h2>
          <p>{homepage.intro.body}</p>
        </section>

        <section className="content-section" id="regions">
          <SectionHeading badge={copy.regionSectionBadge} title={copy.regionSectionTitle} description={copy.regionSectionDescription} />
          <CardGrid items={homepage.regions} variant="region-grid" actionLabel={copy.learnMore} lang={lang} basePath="/regions" />
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

        <section className="ai-guide-section">
          <div className="ai-guide__header">
            <span className="section-badge">{homepage.aiGuide.badge}</span>
            <h2>{homepage.aiGuide.title}</h2>
            <p>{homepage.aiGuide.body}</p>
          </div>

          <div className="ai-guide__panel">
            <div className="ai-guide__status">
              <div>
                <strong>VietCultura AI</strong>
                <span>{copy.online}</span>
              </div>
              <button type="button" className="ghost-button small">{homepage.aiGuide.reset}</button>
            </div>

            <div className="ai-guide__message">{homepage.aiGuide.sample}</div>

            <div className="ai-guide__prompts">
              {homepage.aiGuide.prompts.map((prompt) => (
                <span key={prompt.code}>{prompt.title}</span>
              ))}
            </div>

            <div className="ai-guide__composer">
              <input type="text" placeholder={homepage.aiGuide.placeholder} readOnly />
              <Link to="/ai-guide" className="gradient-button nav-link-button">{homepage.aiGuide.button}</Link>
            </div>
          </div>
        </section>
      </main>

      <footer className="site-footer">
        <div className="footer-brand">
          <strong>VietCultura</strong>
          <p>{homepage.footer.description}</p>
        </div>
        <div className="footer-columns">
          {Object.entries(homepage.footer.columns).map(([key, label]) => (
            <div key={key}>
              <h4>{label}</h4>
              <a href="#">{label}</a>
              <a href="#">{copy.learnMore}</a>
              <a href="#">{copy.viewAll}</a>
            </div>
          ))}
        </div>
      </footer>
    </div>
  )
}

function App() {
  return (
    <BrowserRouter>
      <Routes>
        <Route path="/" element={<HomePage />} />
        <Route path="/articles/:code" element={<ArticleDetailPage />} />
        <Route path="/regions/:code" element={<RegionDetailPage />} />
        <Route path="/ethnic-groups/:code" element={<EthnicityDetailPage />} />
        <Route path="/ai-guide" element={<AIGuidePage />} />
      </Routes>
    </BrowserRouter>
  )
}

export default App

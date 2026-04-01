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

  const homepageRegions = homepage.regions || []
  const ethnicShowcaseStats = copy.ethnicShowcaseStats || []
  const featuredEthnicGroups = (homepage.ethnicGroups || []).slice(0, 6)
  const festivalShowcaseCards = (homepage.festivals || []).slice(0, 3).map((item, index) => ({
    ...item,
    ...(copy.festivalShowcaseCards?.[index] || {}),
  }))
  const cuisineShowcaseCards = (homepage.cuisine || []).slice(0, 3).map((item, index) => ({
    ...item,
    ...(copy.cuisineShowcaseCards?.[index] || {}),
  }))

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
            <span className="regions-showcase__eyebrow">
              <span className="regions-showcase__eyebrow-star" aria-hidden="true">✦</span>
              <span>Khám phá Việt Nam</span>
              <span className="regions-showcase__eyebrow-star" aria-hidden="true">✦</span>
            </span>
            <h2>Ba miền văn hóa đặc sắc</h2>
            <p>
              Từ miền núi phía Bắc đến dải đất miền Trung và vùng sông nước phương Nam, mỗi miền đều có bản sắc,
              nhịp sống và vẻ đẹp riêng để bạn khám phá.
            </p>
          </div>

          <div className="regions-showcase__grid">
            {homepageRegions.map((region) => (
              <article key={region.code || region.id} className={`region-showcase-card fade-up ${region.accentClass || ''}`}>
                {region.imageUrl ? (
                  <img src={region.imageUrl} alt={region.imageAlt} className="region-showcase-card__image" />
                ) : (
                  <div className="region-showcase-card__image region-showcase-card__image--placeholder">
                    {region.title}
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

        <section className="content-section dark-section ethnic-showcase" id="ethnic-groups">
          <div className="ethnic-showcase__header fade-up">
            <span className="ethnic-showcase__eyebrow">
              <span className="ethnic-showcase__eyebrow-star" aria-hidden="true">✦</span>
              <span>{copy.ethnicShowcaseBadge}</span>
              <span className="ethnic-showcase__eyebrow-star" aria-hidden="true">✦</span>
            </span>
            <h2>{copy.ethnicShowcaseTitle}</h2>
            <p>{copy.ethnicShowcaseDescription}</p>
          </div>

          <div className="ethnic-showcase__stats">
            {ethnicShowcaseStats.map((stat) => (
              <div key={stat.label} className="ethnic-stat-card float-card">
                <div className="ethnic-stat-card__value">
                  <span className="ethnic-stat-card__icon" aria-hidden="true">{stat.icon}</span>
                  <strong>{stat.value}</strong>
                </div>
                <span className="ethnic-stat-card__label">{stat.label}</span>
              </div>
            ))}
          </div>

          <div className="ethnic-showcase__grid">
            {featuredEthnicGroups.map((item, index) => (
              <article key={item.code || item.id || index} className="ethnic-card fade-up">
                {item.imageUrl ? (
                  <img src={item.imageUrl} alt={item.imageAlt || item.title} className="ethnic-card__image" />
                ) : (
                  <div className="ethnic-card__image ethnic-card__image--placeholder">{item.title}</div>
                )}

                <div className="ethnic-card__overlay" />

                <div className="ethnic-card__content">
                  <div className="ethnic-card__top">
                    <span className="ethnic-card__count">{item.articleCount ? `${item.articleCount}+ ${copy.ethnicShowcaseCountLabel}` : copy.ethnicShowcaseCountLabel}</span>
                  </div>

                  <div className="ethnic-card__body">
                    <h3>{item.title}</h3>
                    {item.description ? <p>{item.description}</p> : null}
                  </div>

                  <Link to={`/ethnic-groups/${item.code}`} className="ethnic-card__cta">
                    {copy.ethnicShowcaseSecondaryCta}
                    <span aria-hidden="true">→</span>
                  </Link>
                </div>
              </article>
            ))}
          </div>

          <div className="ethnic-showcase__footer fade-up">
            <Link to="/ethnic-groups" className="ethnic-showcase__button">
              <span>{copy.ethnicShowcasePrimaryCta}</span>
              <span aria-hidden="true">→</span>
            </Link>
          </div>
        </section>

        <section className="content-section light-section festival-showcase" id="festivals">
          <div className="festival-showcase__header fade-up">
            <span className="festival-showcase__eyebrow">
              <span className="festival-showcase__eyebrow-star" aria-hidden="true">✦</span>
              <span>{copy.festivalShowcaseBadge}</span>
              <span className="festival-showcase__eyebrow-star" aria-hidden="true">✦</span>
            </span>
            <h2>
              <span>{copy.festivalShowcaseTitle}</span>{' '}
              <span className="festival-showcase__title-accent">{copy.festivalShowcaseTitleAccent}</span>
            </h2>
            <div className="festival-showcase__divider" aria-hidden="true">
              <span />
              <i />
              <b />
              <span />
            </div>
            <p>{copy.festivalShowcaseDescription}</p>
          </div>

          <div className="festival-showcase__grid">
            {festivalShowcaseCards.map((item, index) => (
              <article key={item.code || item.id || index} className={`festival-card fade-up is-${item.accent || 'red'}`}>
                <div className="festival-card__media">
                  {item.imageUrl ? (
                    <img src={item.imageUrl} alt={item.imageAlt || item.title} className="festival-card__image" />
                  ) : (
                    <div className="festival-card__image festival-card__image--placeholder">{item.title}</div>
                  )}

                  <span className="festival-card__badge">
                    <span aria-hidden="true">{item.badgeIcon}</span>
                    <span>{item.badge || item.category}</span>
                  </span>

                  <span className="festival-card__corner-icon" aria-hidden="true">{item.badgeIcon}</span>
                </div>

                <div className="festival-card__body">
                  <h3>{item.title}</h3>
                  <p className="festival-card__subtitle">{item.subtitle}</p>
                  {item.description ? <p className="festival-card__description">{item.description}</p> : null}

                  <div className="festival-card__meta">
                    <span>{item.metaPrimary}</span>
                    <span>{item.metaSecondary}</span>
                  </div>

                  <div className="festival-card__chips">
                    {(item.tags || []).map((tag) => (
                      <span key={tag}>{tag}</span>
                    ))}
                  </div>

                  <div className="festival-card__footer">
                    <Link to={`/articles/${item.code}`} className="festival-card__cta">
                      {copy.learnMore}
                      <span aria-hidden="true">→</span>
                    </Link>
                    <span className="festival-card__rating" aria-hidden="true">{item.footerIcon}</span>
                  </div>
                </div>
              </article>
            ))}
          </div>
        </section>

        <section className="content-section light-section cuisine-showcase" id="cuisine">
          <div className="cuisine-showcase__header fade-up">
            <span className="cuisine-showcase__eyebrow">
              <span className="cuisine-showcase__eyebrow-star" aria-hidden="true">✦</span>
              <span>{copy.cuisineShowcaseBadge}</span>
              <span className="cuisine-showcase__eyebrow-star" aria-hidden="true">✦</span>
            </span>
            <h2>
              <span>{copy.cuisineShowcaseTitle}</span>{' '}
              <span className="cuisine-showcase__title-accent">{copy.cuisineShowcaseTitleAccent}</span>
            </h2>
            <div className="cuisine-showcase__divider" aria-hidden="true">
              <span />
              <i />
              <b />
              <span />
            </div>
            <p>{copy.cuisineShowcaseDescription}</p>
            <div className="cuisine-showcase__filters">
              <span className="cuisine-showcase__filters-label">{copy.cuisineShowcaseFilterLabel}</span>
              {copy.cuisineShowcaseFilters.map((filter) => (
                <span key={filter} className="cuisine-showcase__filter-pill">{filter}</span>
              ))}
            </div>
          </div>

          <div className="cuisine-showcase__grid">
            {cuisineShowcaseCards.map((item, index) => (
              <article key={item.code || item.id || index} className="cuisine-card fade-up">
                <div className="cuisine-card__media">
                  {item.imageUrl ? (
                    <img src={item.imageUrl} alt={item.imageAlt || item.title} className="cuisine-card__image" />
                  ) : (
                    <div className="cuisine-card__image cuisine-card__image--placeholder">{item.title}</div>
                  )}

                  <span className="cuisine-card__score">❤️ {item.score}</span>
                  <button type="button" className="cuisine-card__favorite" aria-label="Favorite dish">
                    ♡
                  </button>
                  <span className="cuisine-card__spice">
                    {'🔥'.repeat(item.spiceLevel || 1)}
                    {'🖤'.repeat(Math.max(0, 5 - (item.spiceLevel || 1)))}
                  </span>
                </div>

                <div className="cuisine-card__body">
                  <h3>{item.title}</h3>
                  <p className="cuisine-card__subtitle">{item.subtitle}</p>
                  {item.description ? <p className="cuisine-card__description">{item.description}</p> : null}

                  <div className="cuisine-card__meta">
                    <span>{item.metaPrimary}</span>
                    <span>{item.metaSecondary}</span>
                  </div>

                  <div className="cuisine-card__chips">
                    {(item.tags || []).map((tag) => (
                      <span key={tag}>{tag}</span>
                    ))}
                  </div>
                </div>
              </article>
            ))}
          </div>

          <div className="cuisine-showcase__footer fade-up">
            <Link to="/articles" className="cuisine-showcase__button">
              <span>{copy.cuisineShowcaseSectionCta}</span>
              <span aria-hidden="true">→</span>
            </Link>
          </div>
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

import { Link } from 'react-router-dom'
import './HeroSection.css'
import banner3 from '../../../assets/banner3.jpg'
import CardGrid from '../../../components/common/CardGrid/CardGrid'

export default function HeroSection({
  hero,
  stats,
  search,
  setSearch,
  handleSearch,
  searching,
  results,
  isLoading,
  copy,
  lang
}) {
  if (!hero) return null

  // Split title carefully to maintain the majestic typography flow
  const titleLines = hero.title.includes('<br/>')
    ? hero.title.split('<br/>')
    : [hero.title]

  return (
    <section className="home-hero-majestic" id="hero">
      <div className="home-hero-majestic__bg" style={{ backgroundImage: `url(${banner3})` }}></div>
      <div className="home-hero-majestic__overlay"></div>

      {/* Ornaments for corner aesthetics */}
      <div className="home-hero-majestic__ornament home-hero-majestic__ornament--tl"></div>
      <div className="home-hero-majestic__ornament home-hero-majestic__ornament--br"></div>

      <div className="home-hero-majestic__inner fade-up">
        <div className="home-hero-majestic__content">

          <div className="home-hero-majestic__badge">
            <span className="home-hero-majestic__badge-dot"></span>
            {hero.badge || copy?.heroBadge}
          </div>

          <h1 className="home-hero-majestic__title">
            {titleLines.map((line, index) => (
              <span
                key={`${line}-${index}`}
                className={index === 1 ? 'home-hero-majestic__title-accent' : 'home-hero-majestic__title-line'}
              >
                {line}
              </span>
            ))}
          </h1>

          <div className="home-hero-majestic__divider">
            <span className="home-hero-majestic__divider-line"></span>
            <span className="home-hero-majestic__divider-diamond">◆</span>
            <span className="home-hero-majestic__divider-line"></span>
          </div>

          <p className="home-hero-majestic__subtitle">
            {hero.subtitle}
          </p>

          <form className="home-hero-majestic__search" onSubmit={handleSearch}>
            <div className="search-input-box">
              <i className="search-icon-silk">🔍</i>
              <input
                value={search}
                onChange={(e) => setSearch(e.target.value)}
                placeholder={copy?.heroSearchPlaceholder || 'Tìm kiếm di sản...'}
              />
            </div>
            <button
              type="submit"
              className="search-submit-silk"
              disabled={searching}
            >
              {searching ? '...' : (
                <>
                  <span>{copy?.search || 'Tìm kiếm'}</span>
                  <span className="btn-arrow">→</span>
                </>
              )}
            </button>
          </form>

          {/* Quick CTA if they don't want to search */}
          <div className="hero-cta-group" style={{ marginTop: '30px', justifyContent: 'center' }}>
            <Link to="/regions" className="primary-button">
              <span>{hero.primaryCta}</span>
              <span className="btn-arrow-silk">→</span>
            </Link>
          </div>
        </div>
      </div>

      {/* Floating immersive stats replacing the right-side visual */}
      {stats && stats.length > 0 && !results?.length && (
        <div className="home-hero-majestic__floating-stats fade-up" style={{ animationDelay: '0.3s' }}>
          {stats.slice(0, 2).map((stat, index) => (
            <div key={`${stat.value}-${index}`} className={`immersive-stat immersive-stat--${index}`}>
              <div className="immersive-stat__inner">
                <span className="immersive-stat__icon">{index === 0 ? '🏛️' : '✨'}</span>
                <strong>{stat.value}</strong>
                <span>{stat.label}</span>
              </div>
            </div>
          ))}
        </div>
      )}

      {/* Search results overlay (if user searches) */}
      {results && results.length > 0 && (
        <div className="home-hero-majestic__results fade-up">
          <div className="results-panel-header">
            <h3>{copy?.searchResults}</h3>
            <div className="header-line" />
            <button className="results-close-btn" onClick={() => setResults([])} type="button">✕</button>
          </div>
          <CardGrid items={results} variant="blog-grid" actionLabel={copy?.learnMore} lang={lang} basePath="/blog" />
        </div>
      )}

      <div className="home-hero-majestic__scroll">
        <div className="mouse-icon"></div>
      </div>

      {isLoading && (
        <div className="hero-shimmer-overlay">
          <div className="shimmer-silk" />
        </div>
      )}
    </section>
  )
}

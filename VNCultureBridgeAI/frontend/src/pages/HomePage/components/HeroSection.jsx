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
  isError, 
  copy, 
  lang 
}) {
  if (!hero) return null

  function getHeroTitleLines(title) {
    if (!title) return []
    if (title === 'Khám phá vẻ đẹp văn hóa Việt Nam') {
      return ['Khám phá vẻ đẹp', 'văn hóa Việt Nam']
    }
    if (title === 'Discover the beauty of Vietnamese culture') {
      return ['Discover the beauty', 'of Vietnamese culture']
    }
    if (title.includes(' Việt Nam')) {
      return [title.replace(' Việt Nam', ''), 'Việt Nam']
    }
    if (title.includes(' Vietnam')) {
      return [title.replace(' Vietnam', ''), 'Vietnam']
    }
    const words = title.trim().split(/\s+/)
    const middle = Math.ceil(words.length / 2)
    return [words.slice(0, middle).join(' '), words.slice(middle).join(' ')]
  }

  const heroTitleLines = getHeroTitleLines(hero.title)

  return (
    <section
      className="hero-section"
      id="hero"
      style={{
        backgroundImage: `linear-gradient(rgba(30, 15, 10, 0.26), rgba(30, 15, 10, 0.4)), url(${banner3})`,
      }}
    >
      <div className="hero-content hero-content--animated">
        <span className="section-badge">{hero.badge || copy?.heroBadge}</span>
        <h1>
          {heroTitleLines.map((line, index) => (
            <span key={`${line}-${index}`} className="hero-title-line">
              {line}
            </span>
          ))}
        </h1>
        <p>{hero.subtitle}</p>
        <div className="hero-actions">
          <Link to="/regions" className="primary-button nav-link-button hero-action-button">
            {hero.primaryCta}
          </Link>
          <a href="#festivals" className="secondary-button nav-link-button hero-action-button">
            {hero.secondaryCta}
          </a>
        </div>
        <form className="ai-guide__composer search-bar glass-panel hero-search-bar" onSubmit={handleSearch}>
          <input
            value={search}
            onChange={(e) => setSearch(e.target.value)}
            placeholder={copy?.heroSearchPlaceholder}
          />
          <button
            type="submit"
            className="gradient-button nav-link-button hero-search-submit"
            disabled={searching}
            aria-label={copy?.search}
          >
            <svg viewBox="0 0 24 24" focusable="false" aria-hidden="true">
              <path d="M10.5 4a6.5 6.5 0 1 0 4.03 11.6l4.43 4.43 1.06-1.06-4.43-4.43A6.5 6.5 0 0 0 10.5 4Zm0 1.5a5 5 0 1 1 0 10 5 5 0 0 1 0-10Z" />
            </svg>
          </button>
        </form>
        {isLoading ? <div className="home-loading-inline">{copy?.loading}</div> : null}
        {isError ? <div className="home-loading-inline home-loading-inline--error">{copy?.error}</div> : null}
        {results?.length ? (
          <div className="search-results fade-up">
            <CardGrid items={results} variant="blog-grid" actionLabel={copy?.learnMore} lang={lang} basePath="/articles" />
          </div>
        ) : null}
        <div className="stats-row">
          {(stats || []).map((stat) => (
            <div key={stat.label} className="stat-card float-card">
              <strong>{stat.value}</strong>
              <span>{stat.label}</span>
            </div>
          ))}
        </div>
      </div>
    </section>
  )
}

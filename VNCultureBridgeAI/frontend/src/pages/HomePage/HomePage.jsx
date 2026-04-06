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

  function getHeroTitleLines(title) {
    if (!title) return []

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
  const heroTitleLines = getHeroTitleLines(homepage.hero.title)
  const festivalShowcaseCards = (homepage.festivals || []).slice(0, 3)
  const cuisineShowcaseCards = (homepage.cuisine || []).slice(0, 3)
  const artsShowcaseCards = homepage.arts || []
  const featuredArt = artsShowcaseCards[0]
  const additionalArts = artsShowcaseCards.slice(1, 7)

  function localizeArtCategory(category) {
    if (!category) return ''

    const normalized = category.trim().toLowerCase()
    if (normalized === 'performing arts') return 'Nghệ thuật trình diễn'
    if (normalized === 'visual arts') return 'Mỹ thuật'
    if (normalized === 'musical heritage') return 'Di sản âm nhạc'
    if (normalized === 'folk arts') return 'Nghệ thuật dân gian'
    return category
  }

  function localizeArtTitle(title) {
    if (!title) return ''

    const normalized = title.trim().toLowerCase()
    if (normalized === 'water puppetry') return 'Múa rối nước'
    if (normalized === 'lacquerware') return 'Sơn mài'
    if (normalized === 'bamboo crafts') return 'Thủ công tre'
    if (normalized === 'ao dai design') return 'Thiết kế áo dài'
    return title
  }

  function localizeCuisineTitle(title) {
    if (!title) return ''

    const normalized = title.trim().toLowerCase()
    if (normalized === 'vietnamese banh mi') return 'Bánh mì Việt Nam'
    if (normalized === 'vietnamese pho') return 'Phở Việt Nam'
    return title
  }

  function localizeEthnicityTitle(title) {
    if (!title) return ''

    const normalized = title.trim().toLowerCase()
    if (normalized === 'khmer') return 'Khmer'
    if (normalized === 'cham') return 'Chăm'
    return title
  }

  function localizeEthnicityDescription(description) {
    if (!description) return ''

    if (description.includes('The Khmer community is concentrated in southern Vietnam')) {
      return 'Cộng đồng Khmer tập trung chủ yếu ở Nam Bộ, nổi bật với chùa Phật giáo Nam tông, lễ hội truyền thống và nghệ thuật diễn xướng dân gian.'
    }

    return description
  }

  function localizeCuisineDescription(description) {
    if (!description) return ''

    if (description.includes('A famous sandwich born from the meeting of French baguette')) {
      return 'Món bánh mì trứ danh kết hợp tinh hoa baguette Pháp với nguyên liệu và hương vị rất Việt Nam.'
    }

    if (description.includes('An iconic Vietnamese dish known for clear broth')) {
      return 'Món phở biểu tượng của Việt Nam, nổi tiếng với nước dùng thanh, bánh phở mềm và hương vị hài hòa.'
    }

    return description
  }

  function localizeArtDescription(description) {
    if (!description) return ''

    if (description.includes('A distinctive performance art in which wooden puppets are controlled on water')) {
      return 'Loại hình nghệ thuật độc đáo nơi những con rối gỗ được điều khiển trên mặt nước, gắn với đời sống và trí tưởng tượng dân gian Việt.'
    }

    return description
  }

  function localizeFestivalTitle(title) {
    if (!title) return ''

    const normalized = title.trim().toLowerCase()
    if (normalized === 'hue festival') return 'Festival Huế'
    if (normalized === 'mid-autumn festival') return 'Tết Trung Thu'
    return title
  }

  function localizeFestivalSubtitle(subtitle) {
    if (!subtitle) return ''

    const normalized = subtitle.trim().toLowerCase()
    if (normalized === 'lunar new year') return 'Tết Nguyên Đán'
    if (normalized === 'mid-autumn festival') return 'Tết Trung Thu'
    if (normalized === 'hue festival') return 'Festival Huế'
    return subtitle
  }

  function localizeFestivalDescription(description) {
    if (!description) return ''

    if (description.includes('A large-scale cultural event honoring Hue heritage')) {
      return 'Sự kiện văn hóa quy mô lớn tôn vinh di sản Huế cùng các chương trình nghệ thuật đương đại đặc sắc.'
    }

    if (description.includes('A children-centered festival filled with lanterns')) {
      return 'Lễ hội dành cho thiếu nhi với đèn lồng, múa lân, bánh trung thu và không khí sum vầy dưới trăng rằm.'
    }

    return description
  }

  function localizeFestivalMeta(value) {
    if (!value) return ''

    const normalized = value.trim().toLowerCase()
    if (normalized === 'festival season') return 'Mùa lễ hội'
    if (normalized === 'central vietnam') return 'Miền Trung'
    if (normalized === 'nationwide') return 'Toàn quốc'
    return value
  }

  function localizeFestivalTag(tag) {
    if (!tag) return ''

    const normalized = tag.trim().toLowerCase()
    if (normalized === 'lantern parade') return 'Rước đèn'
    if (normalized === 'lion dance') return 'Múa lân'
    if (normalized === 'mooncakes') return 'Bánh trung thu'
    if (normalized === 'moon gazing') return 'Ngắm trăng'
    if (normalized === 'royal arts') return 'Nghệ thuật cung đình'
    if (normalized === 'night shows') return 'Trình diễn đêm'
    if (normalized === 'ao dai') return 'Áo dài'
    if (normalized === 'heritage performances') return 'Trình diễn di sản'
    return tag
  }

  function localizeFestivalBadge(badge) {
    if (!badge) return ''

    const normalized = badge.trim().toLowerCase()
    if (normalized === 'most important') return 'Nổi bật nhất'
    if (normalized === "children's festival") return 'Lễ hội thiếu nhi'
    if (normalized === 'cultural showcase') return 'Di sản trình diễn'
    return badge
  }

  function withSafeImage(item) {
    if (!item) return item

    return {
      ...item,
      imageUrl: item.imageUrl && /^https?:\/\//.test(item.imageUrl) ? item.imageUrl : null,
    }
  }

  function localizeEthnicityItem(item) {
    return {
      ...withSafeImage(item),
      title: localizeEthnicityTitle(item.title),
      description: localizeEthnicityDescription(item.description),
    }
  }

  function localizeCuisineItem(item) {
    return {
      ...withSafeImage(item),
      title: localizeCuisineTitle(item.title),
      description: localizeCuisineDescription(item.description),
    }
  }

  function localizeFestivalItem(item) {
    return {
      ...withSafeImage(item),
      title: localizeFestivalTitle(item.title),
      subtitle: localizeFestivalSubtitle(item.subtitle),
      description: localizeFestivalDescription(item.description),
      metaPrimary: localizeFestivalMeta(item.metaPrimary),
      metaSecondary: localizeFestivalMeta(item.metaSecondary),
      badge: localizeFestivalBadge(item.badge),
      tags: (item.tags || []).map(localizeFestivalTag),
    }
  }

  function localizeArtItem(item) {
    return {
      ...withSafeImage(item),
      title: localizeArtTitle(item.title),
      category: localizeArtCategory(item.category),
      description: localizeArtDescription(item.description),
    }
  }

  const localizedCuisineShowcaseCards = cuisineShowcaseCards.map(localizeCuisineItem)
  const localizedFestivalShowcaseCards = festivalShowcaseCards.map(localizeFestivalItem)
  const localizedFeaturedEthnicGroups = featuredEthnicGroups.map(localizeEthnicityItem)
  const localizedFeaturedArt = featuredArt ? localizeArtItem(featuredArt) : null
  const localizedAdditionalArts = additionalArts.map(localizeArtItem)
  const localizedArtsTabs = artsShowcaseCards.slice(0, 3).map(localizeArtItem)

  return (
    <div className="page-shell">
      <PageHeader
        lang={lang}
        onLangChange={setLang}
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
            <h1>
              {heroTitleLines.map((line, index) => (
                <span key={`${line}-${index}`} className="hero-title-line">
                  {line}
                </span>
              ))}
            </h1>
            <p>{homepage.hero.subtitle}</p>
            <div className="hero-actions">
              <Link to="/regions" className="primary-button nav-link-button hero-action-button">{homepage.hero.primaryCta}</Link>
              <a href="#festivals" className="secondary-button nav-link-button hero-action-button">{homepage.hero.secondaryCta}</a>
            </div>
            <form className="ai-guide__composer search-bar glass-panel hero-search-bar" onSubmit={handleSearch}>
              <input
                value={search}
                onChange={(e) => setSearch(e.target.value)}
                placeholder={lang === 'vi' ? 'Tìm kiếm bài viết, vùng miền, món ăn...' : 'Search articles, regions, dishes...'}
              />
              <button
                type="submit"
                className="gradient-button nav-link-button hero-search-submit"
                disabled={searching}
                aria-label={copy.search}
              >
                <svg viewBox="0 0 24 24" focusable="false" aria-hidden="true">
                  <path d="M10.5 4a6.5 6.5 0 1 0 4.03 11.6l4.43 4.43 1.06-1.06-4.43-4.43A6.5 6.5 0 0 0 10.5 4Zm0 1.5a5 5 0 1 1 0 10 5 5 0 0 1 0-10Z" />
                </svg>
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

            <div className="regions-showcase__footer fade-up">
              <Link to="/regions" className="regions-showcase__button">
                <span>Xem bản đồ đầy đủ</span>
                <svg viewBox="0 0 24 24" focusable="false" aria-hidden="true">
                  <path d="M12 22s7-4.35 7-11a7 7 0 1 0-14 0c0 6.65 7 11 7 11Zm0-9a2 2 0 1 1 0-4 2 2 0 0 1 0 4Z" />
                </svg>
              </Link>
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
              {localizedFeaturedEthnicGroups.map((item, index) => (
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
              {localizedFestivalShowcaseCards.map((item, index) => (
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
              {localizedCuisineShowcaseCards.map((item, index) => (
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

          <section className="content-section light-section arts-layout arts-showcase" id="arts">
            {localizedFeaturedArt ? (
              <>
                <div className="arts-showcase__header fade-up">
                  <span className="arts-showcase__eyebrow">
                    <span className="arts-showcase__eyebrow-star" aria-hidden="true">✦</span>
                    <span>{copy.artsSectionBadge}</span>
                    <span className="arts-showcase__eyebrow-star" aria-hidden="true">✦</span>
                  </span>
                  <h2>{copy.artsSectionTitle}</h2>
                  <div className="arts-showcase__divider" aria-hidden="true">
                    <span />
                    <i />
                    <b />
                    <span />
                  </div>
                  <p>{copy.artsSectionDescription}</p>
                </div>

                <div className="arts-showcase__tabs fade-up">
                  {localizedArtsTabs.map((item, index) => (
                    <button
                      key={item.code || item.id || index}
                      type="button"
                      className={`arts-showcase__tab ${index === 0 ? 'is-active' : ''}`}
                    >
                      <span className="arts-showcase__tab-title">{item.title}</span>
                      {item.category ? <span className="arts-showcase__tab-category">{item.category}</span> : null}
                    </button>
                  ))}
                </div>

                <div className="arts-showcase__hero fade-up">
                  <div className="arts-showcase__hero-media">
                    {localizedFeaturedArt.imageUrl ? (
                      <img src={localizedFeaturedArt.imageUrl} alt={localizedFeaturedArt.imageAlt || localizedFeaturedArt.title} className="arts-showcase__hero-image" />
                    ) : (
                      <div className="arts-showcase__hero-image arts-showcase__hero-image--placeholder">{localizedFeaturedArt.title}</div>
                    )}
                    {localizedFeaturedArt.category ? <span className="arts-showcase__hero-badge">{localizedFeaturedArt.category}</span> : null}
                    <button type="button" className="arts-showcase__hero-play" aria-label="Phát video giới thiệu">
                      ▶
                    </button>
                  </div>

                  <div className="arts-showcase__hero-body">
                    {localizedFeaturedArt.category ? <span className="arts-showcase__hero-kicker">{localizedFeaturedArt.category}</span> : null}
                    <h2>{localizedFeaturedArt.title}</h2>
                    <span className="arts-showcase__hero-line" aria-hidden="true" />
                    {localizedFeaturedArt.description ? <p>{localizedFeaturedArt.description}</p> : null}

                    <div className="arts-showcase__hero-chips">
                      {[
                        localizedFeaturedArt.category,
                        localizedFeaturedArt.publishedAt ? 'Tư liệu nổi bật' : null,
                        localizedFeaturedArt.articleCount ? `${localizedFeaturedArt.articleCount}+ bài viết` : 'Khám phá di sản',
                      ].filter(Boolean).slice(0, 3).map((chip) => (
                        <span key={chip}>{chip}</span>
                      ))}
                    </div>

                    <Link to={`/articles/${localizedFeaturedArt.code}`} className="arts-showcase__hero-cta">
                      {`Xem ${localizedFeaturedArt.title}`}
                      <span aria-hidden="true">→</span>
                    </Link>
                  </div>
                </div>

                {localizedAdditionalArts.length ? (
                  <div className="arts-showcase__more fade-up">
                    <h3>Thêm nghệ thuật & thủ công truyền thống</h3>
                    <div className="arts-showcase__mini-grid">
                      {localizedAdditionalArts.map((item, index) => (
                        <Link
                          key={item.code || item.id || index}
                          to={`/articles/${item.code}`}
                          className="arts-showcase__mini-card"
                        >
                          <span className={`arts-showcase__mini-icon arts-showcase__mini-icon--${index + 1}`} aria-hidden="true">
                            <span className="arts-showcase__mini-icon-mark" />
                          </span>
                          <strong>{item.title}</strong>
                          {item.description ? <span>{item.description}</span> : null}
                        </Link>
                      ))}
                    </div>
                  </div>
                ) : null}
              </>
            ) : null}
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

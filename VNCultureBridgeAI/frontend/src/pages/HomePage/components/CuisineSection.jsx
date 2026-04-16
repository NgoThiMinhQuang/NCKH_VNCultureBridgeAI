import { Link } from 'react-router-dom'
import './CuisineSection.css'

export default function CuisineSection({ cuisine, copy }) {
  if (!cuisine || cuisine.length === 0) return null

  return (
    <section className="content-section light-section cuisine-showcase" id="cuisine">
      <div className="cuisine-showcase__header fade-up">
        <span className="cuisine-showcase__eyebrow">
          <span className="cuisine-showcase__eyebrow-star" aria-hidden="true">✦</span>
          <span>{copy?.cuisineShowcaseBadge}</span>
          <span className="cuisine-showcase__eyebrow-star" aria-hidden="true">✦</span>
        </span>
        <h2>
          <span>{copy?.cuisineShowcaseTitle}</span>{' '}
          <span className="cuisine-showcase__title-accent">{copy?.cuisineShowcaseTitleAccent}</span>
        </h2>
        <div className="cuisine-showcase__divider" aria-hidden="true">
          <span />
          <i />
          <b />
          <span />
        </div>
        <p>{copy?.cuisineShowcaseDescription}</p>
      </div>

      <div className="cuisine-showcase__grid">
        {(cuisine || []).map((item, index) => {
          const tags = item.tags || []
          const subtitle = item.subtitle || item.category
          const score = item.score || (item.articleCount ? `${item.articleCount}+` : 'Top')

          return (
            <article key={item.code || item.id || index} className="cuisine-card fade-up">
              <div className="cuisine-card__media">
                {item.imageUrl ? (
                  <img src={item.imageUrl} alt={item.imageAlt || item.title} className="cuisine-card__image" loading="lazy" decoding="async" />
                ) : (
                  <div className="cuisine-card__image cuisine-card__image--placeholder">{item.title}</div>
                )}

                <div className="cuisine-card__badges-top">
                  <span className="cuisine-card__popularity-badge">
                    <span className="heart-icon">♥</span> {score}
                  </span>
                  <button className="cuisine-card__favorite-btn" aria-label="Add to favorites">
                    <span className="heart-icon">♥</span>
                  </button>
                </div>

                {item.spiceLevel && (
                  <div className="cuisine-card__spice-overlay">
                    <span className="spice-flames">{'🌶️'.repeat(item.spiceLevel)}</span>
                  </div>
                )}
              </div>

              <div className="cuisine-card__body">
                <span className="cuisine-card__red-subtitle">{subtitle}</span>
                <h3>{item.title}</h3>
                {item.description ? <p className="cuisine-card__description">{item.description}</p> : null}

                <div className="cuisine-card__info-row">
                  <div className="info-item">
                    <span className="info-icon">🍽️</span>
                    <span>{item.metaSecondary || copy?.featuredDish}</span>
                  </div>
                  <div className="info-item">
                    <span className="info-icon">⭐</span>
                    <span>{item.footerIcon || '★★★★★'}</span>
                  </div>
                </div>

                {tags.length > 0 && (
                  <div className="cuisine-card__chips">
                    {tags.map((tag, tagIndex) => (
                      <span key={`${tag}-${tagIndex}`}>{tag}</span>
                    ))}
                  </div>
                )}

                <div className="cuisine-card__footer">
                  <Link to={`/articles/${item.code}`} className="cuisine-card__cta">
                    {copy?.learnMore}
                    <span aria-hidden="true">→</span>
                  </Link>
                </div>
              </div>
            </article>
          )
        })}
      </div>

      <div className="cuisine-showcase__footer fade-up">
        <Link to="/articles?category=AM_THUC" className="cuisine-showcase__button">
          <span>{copy?.cuisineShowcasePrimaryCta}</span>
          <span aria-hidden="true">→</span>
        </Link>
      </div>
    </section>
  )
}

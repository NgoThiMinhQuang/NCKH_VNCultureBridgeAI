import { Link } from 'react-router-dom'
import './CuisineSection.css'

export default function CuisineSection({ cuisine, copy }) {
  if (!cuisine || cuisine.length === 0) return null

  return (
    <section className="content-section light-section cuisine-showcase" id="cuisine">
      <div className="cuisine-showcase__header ec-center fade-up">
        <span className="section-eyebrow">{copy?.cuisineShowcaseBadge}</span>
        <h2 className="section-title" style={{ marginBottom: '0px' }}>
          <span>{copy?.cuisineShowcaseTitle}</span>{' '}
          <span className="cuisine-showcase__title-accent">{copy?.cuisineShowcaseTitleAccent}</span>
        </h2>
        <p className="section-desc">{copy?.cuisineShowcaseDescription}</p>

        <div className="heritage-divider">
          <span className="heritage-divider-line" />
          <span className="heritage-divider-icon">⚜️</span>
          <span className="heritage-divider-line" />
        </div>
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
                  <img src={item.imageUrl} alt={item.imageAlt || item.title} className="cuisine-card__image" loading="lazy" />
                ) : (
                  <div className="cuisine-card__image cuisine-card__image--placeholder">{item.title}</div>
                )}

                <div className="cuisine-card__badges-top">
                  <span className="cuisine-card__popularity-badge">
                    <span className="heart-icon">♥</span> {score}
                  </span>
                </div>
              </div>

              <div className="cuisine-card__body">
                <span className="cuisine-card__badge-pill">{subtitle}</span>
                <h3 className="cuisine-card__title">{item.title}</h3>
                {item.description ? <p className="cuisine-card__description">{item.description}</p> : null}

                <div className="cuisine-card__meta">
                  <div className="meta-item">
                    <span className="meta-icon">🍽️</span>
                    <span className="meta-text">{item.metaSecondary || copy?.featuredDish}</span>
                  </div>

                </div>

                {tags.length > 0 && (
                  <div className="tag-chips-container">
                    {tags.map((tag, tagIndex) => (
                      <span key={`${tag}-${tagIndex}`} className="tag-chip">{tag}</span>
                    ))}
                  </div>
                )}

                <div className="cuisine-card__footer">
                  <Link to={`/cuisine/${item.code}`} className="cuisine-card__cta">
                    <span>{copy?.learnMore}</span>
                    <span aria-hidden="true">→</span>
                  </Link>
                </div>
              </div>
            </article>
          )
        })}
      </div>

      <div className="cuisine-showcase__footer fade-up">
        <Link to="/blog" className="primary-button">
          <span>{copy?.cuisineShowcasePrimaryCta}</span>
          <span aria-hidden="true" className="btn-arrow-silk">{copy?.viewMore} →</span>
        </Link>
      </div>
    </section>
  )
}

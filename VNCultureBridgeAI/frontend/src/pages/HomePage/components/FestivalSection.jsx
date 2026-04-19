import { Link } from 'react-router-dom'
import './FestivalSection.css'

export default function FestivalSection({ festivals, copy }) {
  if (!festivals || festivals.length === 0) return null

  return (
    <section className="content-section light-section festival-showcase" id="festivals">
      <div className="festival-showcase__header ec-center fade-up">
        <span className="section-eyebrow">{copy?.festivalShowcaseBadge}</span>
        <h2 className="section-title" style={{ marginBottom: '0px' }}>
          <span>{copy?.festivalShowcaseTitle}</span>{' '}
          <span className="festival-showcase__title-accent">{copy?.festivalShowcaseTitleAccent}</span>
        </h2>
        <p className="section-desc">{copy?.festivalShowcaseDescription}</p>

        <div className="heritage-divider">
          <span className="heritage-divider-line" />
          <span className="heritage-divider-icon">⚜️</span>
          <span className="heritage-divider-line" />
        </div>
      </div>

      <div className="festival-showcase__grid">
        {(festivals || []).map((item, index) => {
          const accent = item.accent || ['red', 'gold', 'purple'][index % 3]
          const badgeIcon = item.badgeIcon || '✦'
          const badgeLabel = item.badge || item.category || copy?.festivalShowcaseBadge
          const metaItems = [
            item.metaPrimary ? { key: 'primary', icon: '🗓️', value: item.metaPrimary } : null,
            item.metaSecondary ? { key: 'secondary', icon: '📍', value: item.metaSecondary } : null,
          ].filter(Boolean)
          const tags = item.tags || []
          const rating = item.footerIcon && typeof item.footerIcon === 'string' ? item.footerIcon : ''

          return (
            <article key={item.code || item.id || index} className={`festival-card fade-up is-${accent}`}>
              <div className="festival-card__media">
                {item.imageUrl ? (
                  <img src={item.imageUrl} alt={item.imageAlt || item.title} className="festival-card__image" loading="lazy" />
                ) : (
                  <div className="festival-card__image festival-card__image--placeholder">{item.title}</div>
                )}

                {badgeLabel ? (
                  <span className="festival-card__badge" aria-label={badgeLabel}>
                    <span aria-hidden="true">{badgeIcon}</span>
                    <span>{badgeLabel}</span>
                  </span>
                ) : null}
              </div>

              <div className="festival-card__body">
                <h3 className="festival-card__title">{item.title}</h3>
                {item.subtitle ? <p className="festival-card__subtitle">{item.subtitle}</p> : null}
                {item.description ? <p className="festival-card__description">{item.description}</p> : null}

                {metaItems.length > 0 && (
                  <div className="festival-card__meta">
                    {metaItems.map((meta) => (
                      <span key={meta.key} className="meta-item">
                        <span className="meta-icon" aria-hidden="true">{meta.icon}</span>
                        <span className="meta-text">{meta.value}</span>
                      </span>
                    ))}
                  </div>
                )}

                {tags.length > 0 && (
                  <div className="festival-card__chips">
                    {tags.map((tag, tagIndex) => (
                      <span key={`${tag}-${tagIndex}`} className="tag-chip">{tag}</span>
                    ))}
                  </div>
                )}

                {item.code && (
                  <div className="festival-card__footer">
                    <Link to={`/festivals/${item.code}`} className="festival-card__cta">
                      <span>{copy?.learnMore}</span>
                      <span aria-hidden="true">→</span>
                    </Link>
                    {rating ? <span className="festival-card__rating" aria-hidden="true">{rating}</span> : null}
                  </div>
                )}
              </div>
            </article>
          )
        })}
      </div>
    </section>
  )
}

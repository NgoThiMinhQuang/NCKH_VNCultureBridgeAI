import { Link } from 'react-router-dom'
import './EthnicGroupSection.css'

export default function EthnicGroupSection({ ethnicGroups, stats, copy }) {
  if (!ethnicGroups || ethnicGroups.length === 0) return null

  return (
    <section className="content-section dark-section ethnic-showcase" id="ethnic-groups">
      <div className="ethnic-showcase__header ec-center fade-up">
        <span className="section-eyebrow" >{copy?.ethnicShowcaseBadge}</span>
        <h2 className="section-title" style={{ marginBottom: '0px' }}>{copy?.ethnicShowcaseTitle}</h2>
        <p className="section-desc">{copy?.ethnicShowcaseDescription}</p>

        <div className="heritage-divider">
          <span className="heritage-divider-line" />
          <span className="heritage-divider-icon">⚜️</span>
          <span className="heritage-divider-line" />
        </div>
      </div>

      <div className="ethnic-showcase__stats">
        {(stats || []).map((stat) => (
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
        {ethnicGroups.map((item, index) => (
          <article key={item.code || item.id || index} className="ethnic-card fade-up">
            <div className="ethnic-card__image-container">
              {item.imageUrl ? (
                <img src={item.imageUrl} alt={item.imageAlt || item.title} className="ethnic-card__image" loading="lazy" />
              ) : (
                <div className="ethnic-card__image ethnic-card__image--placeholder">{item.title}</div>
              )}
              <div className="ethnic-card__overlay" />
            </div>

            <div className="ethnic-card__content">
              <div className="ethnic-card__top">
                <span className="ethnic-card__count">{item.articleCount ? `${item.articleCount}+ ${copy?.ethnicShowcaseCountLabel}` : copy?.ethnicShowcaseCountLabel}</span>
              </div>

              <div className="ethnic-card__body">
                <h3 className="ethnic-card__title">{item.title}</h3>
                {item.description ? <p className="ethnic-card__desc">{item.description}</p> : null}
              </div>

              <Link to={`/ethnic-groups/${item.code}`} className="ethnic-card__cta">
                <span>{copy?.ethnicShowcaseSecondaryCta}</span>
                <span className="cta-arrow" aria-hidden="true">→</span>
              </Link>
            </div>
          </article>
        ))}
      </div>

      <div className="ethnic-showcase__footer fade-up">
        <Link to="/ethnic-groups" className="primary-button">
          <span>{copy?.ethnicShowcasePrimaryCta}</span>
          <span aria-hidden="true" className="btn-arrow-silk">→</span>
        </Link>
      </div>
    </section>
  )
}

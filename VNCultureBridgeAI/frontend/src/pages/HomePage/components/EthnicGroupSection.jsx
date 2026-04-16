import { Link } from 'react-router-dom'
import './EthnicGroupSection.css'

export default function EthnicGroupSection({ ethnicGroups, stats, copy }) {
  if (!ethnicGroups || ethnicGroups.length === 0) return null

  return (
    <section className="content-section dark-section ethnic-showcase" id="ethnic-groups">
      <div className="ethnic-showcase__header fade-up">
        <span className="ethnic-showcase__eyebrow">
          <span className="ethnic-showcase__eyebrow-star" aria-hidden="true">✦</span>
          <span>{copy?.ethnicShowcaseBadge}</span>
          <span className="ethnic-showcase__eyebrow-star" aria-hidden="true">✦</span>
        </span>
        <h2>{copy?.ethnicShowcaseTitle}</h2>
        <p>{copy?.ethnicShowcaseDescription}</p>
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
            {item.imageUrl ? (
              <img src={item.imageUrl} alt={item.imageAlt || item.title} className="ethnic-card__image" loading="lazy" decoding="async" />
            ) : (
              <div className="ethnic-card__image ethnic-card__image--placeholder">{item.title}</div>
            )}

            <div className="ethnic-card__overlay" />

            <div className="ethnic-card__content">
              <div className="ethnic-card__top">
                <span className="ethnic-card__count">{item.articleCount ? `${item.articleCount}+ ${copy?.ethnicShowcaseCountLabel}` : copy?.ethnicShowcaseCountLabel}</span>
              </div>

              <div className="ethnic-card__body">
                <h3>{item.title}</h3>
                {item.description ? <p>{item.description}</p> : null}
              </div>

              <Link to={`/ethnic-groups/${item.code}`} className="ethnic-card__cta">
                {copy?.ethnicShowcaseSecondaryCta}
                <span aria-hidden="true">→</span>
              </Link>
            </div>
          </article>
        ))}
      </div>

      <div className="ethnic-showcase__footer fade-up">
        <Link to="/ethnic-groups" className="ethnic-showcase__button">
          <span>{copy?.ethnicShowcasePrimaryCta}</span>
          <span aria-hidden="true">→</span>
        </Link>
      </div>
    </section>
  )
}

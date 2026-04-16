import { Link } from 'react-router-dom'
import './RegionSection.css'

export default function RegionSection({ regions, copy }) {
  if (!regions || regions.length === 0) return null

  return (
    <section className="region-showcase" id="regions">
      <div className="region-showcase__header fade-up">
        <span className="region-showcase__eyebrow">{copy?.regionShowcaseBadge || 'Khám phá Vùng Miền'}</span>
        <h2>{copy?.regionShowcaseTitle || 'Văn hóa ba miền Bắc - Trung - Nam'}</h2>
        <p>{copy?.regionShowcaseDescription || 'Mỗi vùng miền mang một bản sắc riêng biệt, tạo nên bức tranh văn hóa đa dạng của Việt Nam.'}</p>
      </div>

      <div className="region-showcase__grid">
        {regions.map((region, index) => (
          <article
            key={region.code || region.id || index}
            className={`region-card ${region.id || ''} fade-up`}
          >
            <div className="region-card__media">
              {region.imageUrl ? (
                <img
                  src={region.imageUrl}
                  alt={region.imageAlt || region.title}
                  className="region-card__image"
                  loading="lazy"
                  decoding="async"
                />
              ) : (
                <div className="region-card__image-placeholder">{region.title}</div>
              )}
              <div className="region-card__overlay" />
              <div className="region-card__badge-top">
                <span className="region-card__number">{region.number || `0${index + 1}`}</span>
                <span className="region-card__category">{region.badge || region.title}</span>
              </div>
            </div>

            <div className="region-card__content">
              <div className="region-card__header">
                <span className="region-card__icon" aria-hidden="true">{region.icon || '📍'}</span>
                <h3>{region.title}</h3>
              </div>
              
              <div className="region-card__details">
                <div className="region-card__highlights">
                  {region.highlights && region.highlights.map((item) => (
                    <span key={item} className="region-card__tag">
                      {item}
                    </span>
                  ))}
                </div>
                <Link to={`/regions/${region.code}`} className="region-card__cta">
                  {copy?.regionShowcaseCta || 'Khám phá di sản'}
                  <span aria-hidden="true">→</span>
                </Link>
              </div>
            </div>
          </article>
        ))}
      </div>
    </section>
  )
}

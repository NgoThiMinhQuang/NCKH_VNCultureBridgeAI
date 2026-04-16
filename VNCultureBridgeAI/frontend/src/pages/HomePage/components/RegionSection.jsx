import { Link } from 'react-router-dom'
import './RegionSection.css'

export default function RegionSection({ regions, copy }) {
  if (!regions || regions.length === 0) return null

  return (
    <section className="content-section cream-section region-showcase" id="regions">
      <div className="region-showcase__header ec-center fade-up">
        <span className="section-eyebrow">{copy?.regionShowcaseBadge || 'Khám phá Vùng Miền'}</span>
        <h2 className="section-title" style={{ margin: '0' }}>{copy?.regionShowcaseTitle || 'Văn hóa ba miền Bắc - Trung - Nam'}</h2>
        <p className="section-desc">{copy?.regionShowcaseDescription || 'Mỗi vùng miền mang một bản sắc riêng biệt, tạo nên bức tranh văn hóa đa dạng của Việt Nam.'}</p>

        <div className="heritage-divider">
          <span className="heritage-divider-line" />
          <span className="heritage-divider-icon">⚜️</span>
          <span className="heritage-divider-line" />
        </div>
      </div>

      <div className="region-showcase__grid">
        {regions.map((region, index) => (
          <article
            key={region.code || region.id || index}
            className={`region-card is-accent-${index % 3} fade-up`}
          >
            <div className="region-card__media">
              <div className="region-card__accent-line" />
              {region.imageUrl ? (
                <img
                  src={region.imageUrl}
                  alt={region.imageAlt || region.title}
                  className="region-card__image"
                  loading="lazy"
                />
              ) : (
                <div className="region-card__image-placeholder">{region.title}</div>
              )}
              <div className="region-card__overlay" />
              <div className="region-card__badge-top">
                <span className="region-card__number">{region.number || `0${index + 1}`}</span>
              </div>
            </div>

            <div className="region-card__content">
              <div className="region-card__header">
                <span className="region-card__badge-pill">{region.badge || region.title}</span>
                <h3 className="region-card__title">{region.title}</h3>
              </div>

              <div className="region-card__tags">
                {region.highlights && region.highlights.map((item) => (
                  <span key={item} className="tag-chip">
                    {item}
                  </span>
                ))}
              </div>

              <Link to={`/regions/${region.code}`} className="region-card__explore-link">
                {copy?.regionShowcaseCta || 'Khám phá'}
                <span aria-hidden="true">→</span>
              </Link>
            </div>
          </article>
        ))}
      </div>
    </section>
  )
}

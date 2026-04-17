import { Link } from 'react-router-dom'
import './ArtsSection.css'

export default function ArtsSection({ featuredArt, additionalArts, copy, lang }) {
  if (!featuredArt) return null

  function getArtTileIcon(item, index) {
    const title = item?.title || ''
    const category = item?.category || ''
    const normalized = `${title} ${category}`.toLowerCase()

    if (normalized.includes('đông hồ') || normalized.includes('dong ho')) return '🎨'
    if (normalized.includes('lụa') || normalized.includes('silk')) return '🧵'
    if (normalized.includes('chèo') || normalized.includes('cheo')) return '🎭'
    if (normalized.includes('sơn mài') || normalized.includes('lacquer')) return '🏺'
    if (normalized.includes('tre') || normalized.includes('bamboo')) return '🎍'
    if (normalized.includes('áo dài') || normalized.includes('ao dai')) return '👘'
    if (normalized.includes('múa rối nước') || normalized.includes('water puppetry')) return '🎎'
    if (normalized.includes('thư pháp') || normalized.includes('calligraphy')) return '✒️'

    return ['🎨', '🧵', '🎭', '🏺', '🎍', '👘'][index % 6]
  }

  return (
    <section className="content-section dark-section arts-showcase" id="arts">
      <div className="arts-showcase__header ec-center fade-up">
        <span className="section-eyebrow">{copy?.artsTabTitle || 'Nghệ thuật & Thủ công'}</span>
        <h2 className="section-title" style={{ marginBottom: '0px' }}>{copy?.moreArtsTitle}</h2>
        <p className="section-desc">{copy?.artsDescription || (lang === 'vi' ? 'Khám phá sự tinh xảo trong các sản phẩm thủ công và nghệ thuật biểu diễn truyền thống Việt Nam.' : 'Discover the sophistication in Vietnamese traditional crafts and performing arts.')}</p>

        <div className="heritage-divider">
          <span className="heritage-divider-line" />
          <span className="heritage-divider-icon">⚜️</span>
          <span className="heritage-divider-line" />
        </div>
      </div>

      <div className="arts-showcase__hero fade-up">
        <div className="arts-showcase__hero-media">
          {featuredArt.imageUrl ? (
            <img src={featuredArt.imageUrl} alt={featuredArt.imageAlt || featuredArt.title} className="arts-showcase__hero-image" />
          ) : (
            <div className="arts-showcase__hero-image--placeholder">{featuredArt.title}</div>
          )}
          <div className="arts-showcase__hero-overlay" />
          <span className="arts-showcase__hero-badge">{featuredArt.category || copy?.featuredContent}</span>
        </div>

        <div className="arts-showcase__hero-body">
          <div className="arts-showcase__hero-kicker">{copy?.featuredArchive || 'Tư liệu nổi bật'}</div>
          <h2 className="arts-showcase__hero-title">{featuredArt.title}</h2>
          <p className="arts-showcase__hero-desc">{featuredArt.description}</p>

          <div className="tag-chips-container">
            {featuredArt.tags && featuredArt.tags.map(tag => (
              <span key={tag} className="tag-chip tag-chip--amber">{tag}</span>
            ))}
          </div>

          <Link to={`/blog/${featuredArt.code}`} className="primary-button">
            <span>{copy?.learnMore}</span>
            <span aria-hidden="true" className="btn-arrow-silk">→</span>
          </Link>
        </div>
      </div>

      <div className="arts-showcase__more fade-up">
        <div className="arts-showcase__mini-grid">
          {(additionalArts || []).map((item, index) => (
            <Link
              key={item.code || item.id || index}
              to={`/blog/${item.code}`}
              className="arts-mini-card"
            >
              <div className="arts-mini-card__icon">
                <span aria-hidden="true">{getArtTileIcon(item, index)}</span>
              </div>
              <div className="arts-mini-card__content">
                <strong>{item.title}</strong>
                <span>{item.category || item.subtitle}</span>
              </div>
              <span className="arts-mini-card__arrow">→</span>
            </Link>
          ))}
        </div>
      </div>
    </section>
  )
}

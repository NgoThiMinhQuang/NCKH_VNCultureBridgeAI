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
    <section className="content-section arts-showcase" id="arts">
      <div className="arts-showcase__header fade-up">
        <h2>{copy?.moreArtsTitle}</h2>
        <p>{copy?.artsDescription || (lang === 'vi' ? 'Khám phá sự tinh xảo trong các sản phẩm thủ công và nghệ thuật biểu diễn truyền thống Việt Nam.' : 'Discover the sophistication in Vietnamese traditional crafts and performing arts.')}</p>
      </div>

      <div className="arts-showcase__hero fade-up">
        <div className="arts-showcase__hero-media">
          {featuredArt.imageUrl ? (
            <img src={featuredArt.imageUrl} alt={featuredArt.imageAlt || featuredArt.title} className="arts-showcase__hero-image" />
          ) : (
            <div className="arts-showcase__hero-image--placeholder">{featuredArt.title}</div>
          )}
          <span className="arts-showcase__hero-badge">{featuredArt.category || copy?.featuredContent}</span>
        </div>

        <div className="arts-showcase__hero-body">
          <div className="arts-showcase__hero-kicker">{copy?.featuredArchive || 'Tư liệu nổi bật'}</div>
          <h2>{featuredArt.title}</h2>
          <div className="arts-showcase__hero-line" />
          <p>{featuredArt.description}</p>
          
          <div className="arts-showcase__hero-chips">
            {featuredArt.tags && featuredArt.tags.map(tag => (
              <span key={tag} className="tag-chip">{tag}</span>
            ))}
          </div>

          <Link to={`/articles/${featuredArt.code}`} className="primary-button arts-showcase__hero-cta">
            {copy?.learnMore} →
          </Link>
        </div>
      </div>

      <div className="arts-showcase__more fade-up">
        <h3>{copy?.artsTabTitle || 'Khám phá thêm'}</h3>
        <div className="arts-showcase__mini-grid">
          {(additionalArts || []).map((item, index) => (
            <Link 
              key={item.code || item.id || index} 
              to={`/articles/${item.code}`} 
              className="arts-showcase__mini-card"
            >
              <div className="arts-showcase__mini-icon">
                <span className="arts-showcase__mini-icon-text">{getArtTileIcon(item, index)}</span>
              </div>
              <strong>{item.title}</strong>
              <span>{item.category || item.subtitle}</span>
            </Link>
          ))}
        </div>
      </div>
    </section>
  )
}

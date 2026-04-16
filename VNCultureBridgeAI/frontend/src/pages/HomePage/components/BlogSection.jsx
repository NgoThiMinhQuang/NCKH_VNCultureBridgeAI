import { Link } from 'react-router-dom'
import './BlogSection.css'

export default function BlogSection({ featuredPost, secondaryPosts, copy, lang }) {
  if (!featuredPost) return null

  function formatBlogDate(dateStr) {
    if (!dateStr) return ''
    try {
      const date = new Date(dateStr)
      return date.toLocaleDateString(lang === 'vi' ? 'vi-VN' : 'en-US', {
        day: 'numeric',
        month: 'long',
        year: 'numeric',
      })
    } catch (e) {
      return dateStr
    }
  }

  function getBlogCategoryLabel(cat) {
    const labels = {
      VAN_HOA: lang === 'vi' ? 'Văn Hóa' : 'Culture',
      AM_THUC: lang === 'vi' ? 'Ẩm Thực' : 'Cuisine',
      DU_LICH: lang === 'vi' ? 'Du Lịch' : 'Travel',
      CON_NGUOI: lang === 'vi' ? 'Con Người' : 'People',
      NGHE_THUAT: lang === 'vi' ? 'Nghệ Thuật' : 'Arts',
      LE_HOI: lang === 'vi' ? 'Lễ Hội' : 'Festival',
    }
    return labels[cat] || cat
  }

  function getBlogAccent(index) {
    return ['red', 'gold', 'emerald', 'purple'][index % 4]
  }

  return (
    <section className="content-section cream-section blog-showcase" id="blog">
      <div className="blog-showcase__header ec-center fade-up">
        <span className="section-eyebrow">{copy?.blogShowcaseBadge}</span>
        <h2 className="section-title">
          <span>{copy?.blogShowcaseTitle}</span>{' '}
          <span className="blog-showcase__title-accent">{copy?.blogShowcaseTitleAccent}</span>
        </h2>
        <p className="section-desc">{copy?.blogShowcaseDescription}</p>

        <div className="heritage-divider">
          <span className="heritage-divider-line" />
          <span className="heritage-divider-icon">⚜️</span>
          <span className="heritage-divider-line" />
        </div>
      </div>

      <div className="blog-showcase__featured fade-up">
        <div className="blog-showcase__featured-media">
          {featuredPost.imageUrl ? (
            <img src={featuredPost.imageUrl} alt={featuredPost.imageAlt || featuredPost.title} className="blog-showcase__featured-image" />
          ) : (
            <div className="blog-showcase__featured-image--placeholder">{featuredPost.title}</div>
          )}
          <span className="blog-showcase__featured-badge">{copy?.featuredArchive}</span>
        </div>

        <div className="blog-showcase__featured-body">
          <div className="blog-showcase__featured-meta-top">
            <span className="blog-card__category-pill">{getBlogCategoryLabel(featuredPost.category)}</span>
            <span className="blog-showcase__featured-read">
              {featuredPost.readTime || (lang === 'vi' ? '8 phút đọc' : '8 min read')}
            </span>
          </div>
          <h3 className="blog-showcase__featured-title">{featuredPost.title}</h3>
          <p className="blog-showcase__featured-excerpt">{featuredPost.description}</p>

          <div className="blog-showcase__featured-footer">
            <div className="blog-showcase__author">
              <div className="blog-showcase__author-avatar" aria-hidden="true">
                {featuredPost.authorName ? featuredPost.authorName.charAt(0) : 'A'}
              </div>
              <div className="blog-showcase__author-info">
                <strong>{featuredPost.authorName || copy?.guestAuthor}</strong>
                <span>{formatBlogDate(featuredPost.createdAt)}</span>
              </div>
            </div>

            <Link to={`/articles/${featuredPost.code}`} className="blog-card__cta">
              <span>{copy?.learnMore}</span>
              <span aria-hidden="true">→</span>
            </Link>
          </div>
        </div>
      </div>

      <div className="blog-showcase__grid">
        {(secondaryPosts || []).map((post, index) => {
          const accentClass = `is-${getBlogAccent(index)}`
          return (
            <article key={post.code || post.id || index} className={`blog-card fade-up ${accentClass}`}>
              <div className="blog-card__media">
                {post.imageUrl ? (
                  <img src={post.imageUrl} alt={post.imageAlt || post.title} className="blog-card__image" loading="lazy" />
                ) : (
                  <div className="blog-card__image blog-card__image--placeholder">{post.title}</div>
                )}
                <span className="blog-card__category-pill">{getBlogCategoryLabel(post.category)}</span>
              </div>

              <div className="blog-card__body">
                <div className="blog-card__meta-top">
                  <span className="blog-card__date">{formatBlogDate(post.createdAt)}</span>
                  <span className="blog-card__read">{post.readTime || (lang === 'vi' ? '5 phút' : '5 min')}</span>
                </div>
                <h4 className="blog-card__title">{post.title}</h4>
                <p className="blog-card__excerpt">{post.description}</p>
                <Link to={`/articles/${post.code}`} className="blog-card__cta">
                  <span>{copy?.learnMore}</span>
                  <span aria-hidden="true">→</span>
                </Link>
              </div>
            </article>
          )
        })}
      </div>

      <div className="blog-showcase__cta-row fade-up">
        <Link to="/articles" className="primary-button">
          <span>{copy?.blogShowcasePrimaryCta}</span>
          <span aria-hidden="true" className="btn-arrow-silk">Xem thêm →</span>
        </Link>
      </div>
    </section>
  )
}

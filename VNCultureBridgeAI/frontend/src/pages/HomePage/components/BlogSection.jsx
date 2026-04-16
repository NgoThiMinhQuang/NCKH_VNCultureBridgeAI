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
    <section className="content-section blog-showcase" id="blog">
      <div className="blog-showcase__header fade-up">
        <span className="blog-showcase__eyebrow">
          <span>{copy?.blogShowcaseBadge}</span>
        </span>
        <h2>
          <span>{copy?.blogShowcaseTitle}</span>{' '}
          <span className="blog-showcase__title-accent">{copy?.blogShowcaseTitleAccent}</span>
        </h2>
        <div className="blog-showcase__divider" aria-hidden="true">
          <span />
          <i />
          <b />
          <span />
        </div>
        <p>{copy?.blogShowcaseDescription}</p>
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
            <span className="blog-showcase__featured-category">{getBlogCategoryLabel(featuredPost.category)}</span>
            <span className="blog-showcase__featured-read">
              {featuredPost.readTime || (lang === 'vi' ? '8 phút đọc' : '8 min read')}
            </span>
          </div>
          <h3>{featuredPost.title}</h3>
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
            
            <Link to={`/articles/${featuredPost.code}`} className="blog-showcase__featured-cta">
              {copy?.learnMore} →
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
                  <img src={post.imageUrl} alt={post.imageAlt || post.title} className="blog-card__image" loading="lazy" decoding="async" />
                ) : (
                  <div className="blog-card__image blog-card__image--placeholder">{post.title}</div>
                )}
                <span className="blog-card__category-badge">{getBlogCategoryLabel(post.category)}</span>
              </div>
              
              <div className="blog-card__body">
                <div className="blog-card__meta-top">
                  <span className="blog-card__date">{formatBlogDate(post.createdAt)}</span>
                  <span className="blog-card__read">{post.readTime || (lang === 'vi' ? '5 phút' : '5 min')}</span>
                </div>
                <h4>{post.title}</h4>
                <p>{post.description}</p>
                <Link to={`/articles/${post.code}`} className="blog-card__cta">
                   {copy?.learnMore} →
                </Link>
              </div>
            </article>
          )
        })}
      </div>

      <div className="blog-showcase__cta-row fade-up">
        <Link to="/articles" className="blog-showcase__button">
          <span>{copy?.blogShowcasePrimaryCta}</span>
          <span aria-hidden="true">→</span>
        </Link>
      </div>
    </section>
  )
}

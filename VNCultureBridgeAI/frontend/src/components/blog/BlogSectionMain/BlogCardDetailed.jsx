import { Link } from 'react-router-dom'
import { formatDate } from '../../../utils/formatDate'

/**
 * Detailed Blog Card for the main blog grid.
 */
export default function BlogCardDetailed({ article, lang }) {
  return (
    <article className="blog-card-detailed float-card fade-up">
      <Link to={`/articles/${article.code}`} className="blog-card-detailed__media">
        <img src={article.imageUrl} alt={article.title} />
        {article.category && (
          <span className="blog-card-detailed__badge">{article.category}</span>
        )}
      </Link>
      
      <div className="blog-card-detailed__body">
        <div className="blog-card-detailed__meta">
          <div className="blog-card-detailed__meta-item">
            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
              <rect x="3" y="4" width="18" height="18" rx="2" ry="2" />
              <line x1="16" y1="2" x2="16" y2="6" />
              <line x1="8" y1="2" x2="8" y2="6" />
              <line x1="3" y1="10" x2="21" y2="10" />
            </svg>
            <span>{formatDate(article.publishedAt, lang)}</span>
          </div>
          <div className="blog-card-detailed__meta-item">
            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
              <circle cx="12" cy="12" r="10" />
              <polyline points="12 6 12 12 16 14" />
            </svg>
            <span>{article.readingTime || '5 phút'}</span>
          </div>
        </div>

        <Link to={`/articles/${article.code}`}>
          <h3 className="blog-card-detailed__title">{article.title}</h3>
        </Link>
        
        <p className="blog-card-detailed__excerpt">{article.description}</p>
        
        <div className="blog-card-detailed__author">
          <div className="blog-card-detailed__author-avatar">
            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
              <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2" />
              <circle cx="12" cy="7" r="4" />
            </svg>
          </div>
          <span>{article.author || 'Người đóng góp'}</span>
        </div>
      </div>
    </article>
  )
}

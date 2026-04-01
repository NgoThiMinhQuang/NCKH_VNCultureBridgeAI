import { Link } from 'react-router-dom'
import { formatDate } from '../../../utils/formatDate'
import './CardGrid.css'

/**
 * Grid hiển thị danh sách cards.
 * @param {{ items: object[], variant?: string, actionLabel: string, lang: string, basePath: string }} props
 */
export default function CardGrid({ items, variant = 'default', actionLabel, lang, basePath }) {
  return (
    <div className={`card-grid ${variant}`}>
      {items.map((item) => (
        <article key={`${variant}-${item.code}`} className="content-card float-card fade-up">
          <div className="content-card__media">
            {item.imageUrl ? (
              <img src={item.imageUrl} alt={item.imageAlt || item.title} />
            ) : (
              <div className="content-card__placeholder">{item.title}</div>
            )}
          </div>
          <div className="content-card__body">
            <div className="content-card__meta">
              {item.category && <span>{item.category}</span>}
              {item.publishedAt ? <span>{formatDate(item.publishedAt, lang)}</span> : null}
              {!item.publishedAt && item.articleCount ? <span>{item.articleCount}+</span> : null}
            </div>
            <h3>{item.title}</h3>
            {item.description && <p>{item.description}</p>}
            <Link to={`${basePath}/${item.code}`} className="text-link">
              {actionLabel}
            </Link>
          </div>
        </article>
      ))}
    </div>
  )
}

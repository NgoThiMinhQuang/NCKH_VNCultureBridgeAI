import { useMemo } from 'react'
import { Link } from 'react-router-dom'
import { ui } from '../../../i18n/messages'
import './FeaturedArticles.css'

/**
 * FeaturedArticles component for the Blog page.
 * Props:
 *   lang - 'vi' | 'en'
 *   articles - Array of article objects
 */
export default function FeaturedArticles({ lang, articles }) {
  const copy = useMemo(() => ui[lang].blogFeatured, [lang])

  if (!articles || articles.length === 0) return null

  const mainArticle = articles[0]
  const sideArticles = articles.slice(1, 4)

  return (
    <section className="featured-articles">
      <div className="featured-articles__container">
        <div className="featured-articles__header">
          <span className="featured-articles__badge">{copy.badge}</span>
          <h2 className="featured-articles__title">{copy.title}</h2>
        </div>

        <div className="featured-articles__grid">
          {/* Main Large Article */}
          <div className="featured-articles__main">
            <Link to={`/blog/${mainArticle.code}`} className="featured-card featured-card--large">

              <div className="featured-card__image-wrapper">
                <img src={mainArticle.imageUrl} alt={mainArticle.title} className="featured-card__image" />
                <div className="featured-card__overlay" />
              </div>
              <div className="featured-card__content">
                <span className="featured-card__category">{mainArticle.category}</span>
                <h3 className="featured-card__title">{mainArticle.title}</h3>
                <p className="featured-card__description">{mainArticle.description}</p>
                <div className="featured-card__footer">
                   <span className="featured-card__date">{mainArticle.publishedAt}</span>
                   <span className="featured-card__read-more">{copy.readNow} →</span>
                </div>
              </div>
            </Link>
          </div>

          {/* Side Articles */}
          <div className="featured-articles__side">
            {sideArticles.map((article) => (
              <Link key={article.id} to={`/blog/${article.code}`} className="featured-card featured-card--small">

                <div className="featured-card__image-wrapper">
                  <img src={article.imageUrl} alt={article.title} className="featured-card__image" />
                </div>
                <div className="featured-card__content">
                  <span className="featured-card__category">{article.category}</span>
                  <h3 className="featured-card__title">{article.title}</h3>
                  <span className="featured-card__date">{article.publishedAt}</span>
                </div>
              </Link>
            ))}
          </div>
        </div>
      </div>
    </section>
  )
}

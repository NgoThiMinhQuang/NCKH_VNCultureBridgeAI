import { useState, useMemo } from 'react'
import { ui } from '../../../i18n/messages'
import BlogCardDetailed from './BlogCardDetailed'
import BlogSidebar from './BlogSidebar'
import './BlogSectionMain.css'

/**
 * Main Content Section for the Blog page (2 columns: Grid + Sidebar).
 */
export default function BlogSectionMain({ lang, articles, popularPosts, trendingTopics }) {
  const [activeCategory, setActiveCategory] = useState(0)
  const categories = useMemo(() => ui[lang].blogCategories, [lang])
  const copy = useMemo(() => ui[lang].blogSidebar, [lang])

  const filteredArticles = useMemo(() => {
    if (activeCategory === 0) return articles
    const categoryName = categories[activeCategory]
    return articles.filter(article => article.category === categoryName)
  }, [articles, activeCategory, categories])

  return (
    <section className="blog-section-main">
      <div className="blog-section-main__container">
        
        {/* Category Filters */}
        <div className="blog-categories">
          {categories.map((cat, index) => (
            <button 
              key={cat} 
              className={`category-pill ${activeCategory === index ? 'is-active' : ''}`}
              onClick={() => setActiveCategory(index)}
            >
              {cat}
              {index === 0 && <span className="cat-count">({articles.length})</span>}
            </button>
          ))}
        </div>

        <div className="blog-layout-grid">
          {/* Main Column */}
          <div className="blog-main-col">
            <div className="blog-detailed-grid">
              {filteredArticles.map((article) => (
                <BlogCardDetailed key={article.id} article={article} lang={lang} />
              ))}
            </div>
            
            {/* Load More Button */}
            <div className="blog-load-more">
              <button className="outline-button blog-load-more-btn">
                {copy.readMore}
              </button>
            </div>
          </div>

          {/* Sidebar */}
          <BlogSidebar 
            lang={lang} 
            popularPosts={popularPosts} 
            trendingTopics={trendingTopics} 
          />
        </div>
      </div>
    </section>
  )
}

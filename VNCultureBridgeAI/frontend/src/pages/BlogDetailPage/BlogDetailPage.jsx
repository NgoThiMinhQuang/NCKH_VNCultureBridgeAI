import { useState, useMemo, useEffect } from 'react'
import { useLanguage } from '../../context/LanguageContext'
import { useParams, Link, useNavigate } from 'react-router-dom'
import PageHeader from '../../components/layout/PageHeader/PageHeader'
import Footer from '../../components/layout/Footer/Footer'
import { getBlogDetail } from '../../services/blog.service'
import './BlogDetailPage.css'

/**
 * BlogDetailPage component.
 * Displays a detailed view of a blog post with premium "Cream & Red" styling.
 */
export default function BlogDetailPage() {
  const { lang, setLang } = useLanguage()
  const { code } = useParams()
  const navigate = useNavigate()
  const [blogData, setBlogData] = useState(null)
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState(null)

  // Fetch data from backend
  useEffect(() => {
    let isMounted = true
    const fetchData = async () => {
      setLoading(true)
      try {
        const response = await getBlogDetail(code, lang)
        if (isMounted) {
          setBlogData(response)
          setError(null)
        }
      } catch (err) {
        if (isMounted) {
          setError(err.message || 'Failed to load article')
          console.error('Error fetching blog detail:', err)
        }
      } finally {
        if (isMounted) setLoading(false)
      }
    }

    fetchData()
    window.scrollTo(0, 0)
    return () => { isMounted = false }
  }, [code, lang])




  if (loading) {
    return (
      <div className="blog-detail-page is-loading">
        <PageHeader lang={lang} onLangChange={setLang} />
        <div className="blog-loading-container">
          <div className="loading-spinner"></div>
          <p>{lang === 'vi' ? 'Đang tải bài viết...' : 'Loading article...'}</p>
        </div>
        <Footer lang={lang} />
      </div>
    )
  }

  if (error || !blogData) {
    return (
      <div className="blog-detail-page has-error">
        <PageHeader lang={lang} onLangChange={setLang} />
        <div className="blog-error-container">
          <h2>{lang === 'vi' ? 'Oops! Không tìm thấy bài viết' : 'Oops! Article not found'}</h2>
          <p>{error || (lang === 'vi' ? 'Bài viết có thể đã bị gỡ bỏ hoặc link không chính xác.' : 'The article might have been moved or the link is incorrect.')}</p>
          <Link to="/blog" className="back-to-blog-btn">{lang === 'vi' ? 'Quay lại Blog' : 'Back to Blog'}</Link>
        </div>
        <Footer lang={lang} />
      </div>
    )
  }

  return (
    <div className="blog-detail-page">
      <PageHeader
        lang={lang}
        onLangChange={setLang}
        breadcrumb={[
          { label: 'Blog', to: '/blog' },
          { label: blogData.title }
        ]}
      />

      <main className="blog-detail-content">
        <div className="container-narrow">
          {/* Back button */}
          <Link to="/blog" className="blog-detail__back">
            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
              <path d="M15 18l-6-6 6-6" />
            </svg>
            <span>Quay lại Blog</span>
          </Link>

          {/* Header Section */}
          <header className="blog-detail__header fade-up">
            <span className="blog-detail__category">{blogData.category}</span>
            <h1 className="blog-detail__title">{blogData.title}</h1>

            <div className="blog-detail__meta">
              <div className="blog-detail__info">
                <div className="blog-detail__divider"></div>
                <div className="blog-detail__info-item">
                  <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                    <rect x="3" y="4" width="18" height="18" rx="2" ry="2" />
                    <line x1="16" y1="2" x2="16" y2="6" />
                    <line x1="8" y1="2" x2="8" y2="6" />
                    <line x1="3" y1="10" x2="21" y2="10" />
                  </svg>
                  <span>{blogData.publishedAt}</span>
                </div>
                <div className="blog-detail__info-item">
                  <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                    <circle cx="12" cy="12" r="10" />
                    <polyline points="12 6 12 12 16 14" />
                  </svg>
                  <span>{blogData.readingTime}</span>
                </div>
                <div className="blog-detail__divider"></div>
              </div>

              <div className="blog-detail__actions">
                <button className="blog-detail__action-btn" aria-label="Lưu bài viết">
                  <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                    <path d="M19 21l-7-5-7 5V5a2 2 0 0 1 2-2h10a2 2 0 0 1 2 2z" />
                  </svg>
                </button>
                <button className="blog-detail__action-btn" aria-label="Chia sẻ bài viết">
                  <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                    <circle cx="18" cy="5" r="3" />
                    <circle cx="6" cy="12" r="3" />
                    <circle cx="18" cy="19" r="3" />
                    <line x1="8.59" y1="13.51" x2="15.42" y2="17.49" />
                    <line x1="15.41" y1="6.51" x2="8.6" y2="10.49" />
                  </svg>
                </button>
              </div>
            </div>
          </header>

          {/* Featured Image */}
          <div className="blog-detail__featured-image fade-up">
            <img src={blogData.imageUrl} alt={blogData.title} />
          </div>

          {/* New Two-Column Layout */}
          <div className="blog-detail__layout">
            <div className="blog-detail__main fade-up">
              <div className="blog-detail__main-card">
                <section className="blog-detail__section intro">
                  <p>{blogData.intro}</p>
                  
                  <div className="blog-detail__separator">
                    <span>✧ ✧ ✧</span>
                  </div>

                  {blogData.mainContent && (
                    <div className="blog-detail__main-text">
                      {blogData.mainContent.split('\n\n').map((para, idx) => (
                        <p key={idx}>{para}</p>
                      ))}
                    </div>
                  )}
                </section>

                <blockquote className="blog-detail__quote">
                  <div className="blog-detail__quote-inner">
                    <div className="blog-detail__quote-icon">
                      <svg width="48" height="48" viewBox="0 0 24 24" fill="currentColor">
                        <path d="M14.017 21L14.017 18C14.017 16.8954 14.9124 16 16.017 16H19.017C19.5693 16 20.017 15.5523 20.017 15V9C20.017 8.44772 19.5693 8 19.017 8H15.017C14.4647 8 14.017 8.44772 14.017 9V12C14.017 12.5523 13.5693 13 13.017 13H11.017C10.4647 13 10.017 12.5523 10.017 12V9C10.017 6.79086 11.8079 5 14.017 5H19.017C21.2261 5 23.017 6.79086 23.017 9V15C23.017 18.3137 20.3307 21 17.017 21H14.017ZM1.0166 21L1.0166 18C1.0166 16.8954 1.91203 16 3.0166 16H6.0166C6.56889 16 7.0166 15.5523 7.0166 15V9C7.0166 8.44772 6.56889 8 6.0166 8H2.0166C1.46432 8 1.0166 8.44772 1.0166 9V12C1.0166 12.5523 0.568887 13 0.0166016 13H-1.9834C-2.53569 13 -2.9834 12.5523 -2.9834 12V9C-2.9834 6.79086 -1.19254 5 1.0166 5H6.0166C8.22574 5 10.0166 6.79086 10.0166 9V15C10.0166 18.3137 7.33031 21 4.0166 21H1.0166Z" opacity="0.15" />
                      </svg>
                    </div>
                    <p className="blog-detail__quote-text">{blogData.quote.text}</p>
                    <cite className="blog-detail__quote-author">— {blogData.quote.author}</cite>
                  </div>
                </blockquote>

                {blogData.gallery && blogData.gallery.length > 0 && (
                  <section className="blog-detail__section gallery">
                    <h2 className="blog-detail__sub-title">{lang === 'vi' ? 'Thư viện hình ảnh' : 'Image Gallery'}</h2>
                    <div className="blog-detail__content-gallery">
                      {blogData.gallery.map((img, idx) => (
                        <div key={idx} className="gallery-item-wrap">
                          <img src={img.url} alt={img.caption || blogData.title} />
                          {img.caption && <p className="gallery-caption">{img.caption}</p>}
                        </div>
                      ))}
                    </div>
                  </section>
                )}

                <section className="blog-detail__section conclusion">
                  <div className="blog-detail__conclusion">
                    <h3 className="blog-detail__conclusion-title">{lang === 'vi' ? 'Tổng kết' : 'Conclusion'}</h3>
                    <p>{blogData.conclusion}</p>
                  </div>
                </section>
              </div>

            </div>

            <aside className="blog-detail__sidebar fade-up">


              {/* Related Posts */}
              {blogData.relatedPosts && blogData.relatedPosts.length > 0 && (
                <div className="related-section">
                  <h3 className="sidebar-title">{lang === 'vi' ? 'Bài Viết Liên Quan' : 'Related Posts'}</h3>
                  <div className="related-list">
                    {blogData.relatedPosts.map((post, index) => (
                      <Link to={`/blog/${post.code || post.id}`} key={index} className="related-item">
                        <div className="related-item__image">
                          <img src={post.imageUrl} alt={post.title} />
                          <span className="related-item__tag">{post.category}</span>
                        </div>
                        <div className="related-item__info">
                          <h4 className="related-item__title">{post.title}</h4>
                          <span className="related-item__date">{new Date(post.publishedAt).toLocaleDateString(lang === 'vi' ? 'vi-VN' : 'en-US')}</span>
                        </div>
                      </Link>
                    ))}
                  </div>
                </div>
              )}
            </aside>
          </div>

        </div>
      </main>

      <Footer lang={lang} />
    </div>
  )
}

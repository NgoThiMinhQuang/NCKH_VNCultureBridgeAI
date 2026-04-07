import { useMemo } from 'react'
import { Link } from 'react-router-dom'
import { ui } from '../../../i18n/messages'

/**
 * Blog Sidebar component with Newsletter, Popular Posts, Topics, and Social Follow.
 */
export default function BlogSidebar({ lang, popularPosts, trendingTopics }) {
  const copy = useMemo(() => ui[lang].blogSidebar, [lang])

  return (
    <aside className="blog-sidebar">
      {/* Newsletter Widget */}
      <div className="sidebar-widget sidebar-widget--newsletter fade-up">
        <div className="newsletter-box">
          <div className="newsletter-box__icon">
            <svg width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
              <path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z" />
              <polyline points="22,6 12,13 2,6" />
            </svg>
          </div>
          <h3>{copy.newsletterTitle}</h3>
          <p>{copy.newsletterDesc}</p>
          <form className="newsletter-form" onSubmit={(e) => e.preventDefault()}>
            <input type="email" placeholder="Email của bạn..." required />
            <button type="submit">{copy.newsletterBtn}</button>
          </form>
        </div>
      </div>

      {/* Popular Posts Widget */}
      <div className="sidebar-widget fade-up">
        <h3 className="sidebar-widget__title">{copy.popularTitle}</h3>
        <div className="popular-posts">
          {popularPosts.map((post) => (
            <Link key={post.id} to={`/articles/${post.code}`} className="popular-post-item">
              <div className="popular-post-item__thumb">
                <img src={post.imageUrl} alt={post.title} />
              </div>
              <div className="popular-post-item__info">
                <h4>{post.title}</h4>
                <div className="popular-post-item__meta">
                   <span>{post.publishedAt}</span>
                   <span>•</span>
                   <span>{post.views} {copy.views}</span>
                </div>
              </div>
            </Link>
          ))}
        </div>
      </div>

      {/* Topics Widget */}
      <div className="sidebar-widget fade-up">
        <h3 className="sidebar-widget__title">{copy.topicsTitle}</h3>
        <div className="topic-cloud">
          {trendingTopics.map((topic) => (
            <Link key={topic} to={`/blog?category=${topic}`} className="topic-tag">
              #{topic}
            </Link>
          ))}
        </div>
      </div>

      {/* Social Follow Widget */}
      <div className="sidebar-widget fade-up">
        <h3 className="sidebar-widget__title">{copy.followTitle}</h3>
        <div className="social-follow">
          <a href="https://facebook.com" target="_blank" rel="noopener noreferrer" className="social-icon social-icon--fb" title="Facebook">
            <svg width="20" height="20" viewBox="0 0 24 24" fill="currentColor">
              <path d="M18 2h-3a5 5 0 0 0-5 5v3H7v4h3v8h4v-8h3l1-4h-4V7a1 1 0 0 1 1-1h3z" />
            </svg>
          </a>
          <a href="https://youtube.com" target="_blank" rel="noopener noreferrer" className="social-icon social-icon--yt" title="YouTube">
             <svg width="20" height="20" viewBox="0 0 24 24" fill="currentColor">
               <path d="M22.54 6.42a2.78 2.78 0 0 0-1.94-1.94C18.88 4 12 4 12 4s-6.88 0-8.6.46a2.78 2.78 0 0 0-1.94 1.94C1 8.12 1 12 1 12s0 3.88.46 5.58a2.78 2.78 0 0 0 1.94 1.94c1.72.46 8.6.46 8.6.46s6.88 0 8.6-.46a2.78 2.78 0 0 0 1.94-1.94C23 15.88 23 12 23 12s0-3.88-.46-5.58zM9.75 15.02V8.98L15 12l-5.25 3.02z" />
             </svg>
          </a>
          <a href="https://twitter.com" target="_blank" rel="noopener noreferrer" className="social-icon social-icon--tw" title="Twitter">
             <svg width="20" height="20" viewBox="0 0 24 24" fill="currentColor">
               <path d="M23 3a10.9 10.9 0 0 1-3.14 1.53 4.48 4.48 0 0 0-7.86 3v1A10.66 10.66 0 0 1 3 4s-4 9 5 13a11.64 11.64 0 0 1-7 2c9 5 20 0 20-11.5a4.5 4.5 0 0 0-.08-.83A7.72 7.72 0 0 0 23 3z" />
             </svg>
          </a>
        </div>
      </div>
    </aside>
  )
}

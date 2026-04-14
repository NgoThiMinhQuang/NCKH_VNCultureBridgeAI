import { useEffect, useState } from 'react'
import { useParams, Link } from 'react-router-dom'
import PageHeader from '../../components/layout/PageHeader/PageHeader'
import Footer from '../../components/layout/Footer/Footer'
import { getArticle } from '../../services/content.service'
import './ArticleDetailPage.css'

export default function ArticleDetailPage() {
  const { code } = useParams()
  const [lang, setLang] = useState('vi')
  const [articleData, setArticleData] = useState(null)
  const [comments, setComments] = useState([])
  const [newComment, setNewComment] = useState('')

  useEffect(() => {
    let ignore = false

    async function loadArticle() {
      try {
        const data = await getArticle(code, lang)
        if (!ignore) {
          setArticleData(data)
          setComments([
            {
              id: 1,
              name: lang === 'vi' ? 'Phạm Thị Lan' : 'Pham Thi Lan',
              date: lang === 'vi' ? '21 Tháng 3, 2026' : 'March 21, 2026',
              content: lang === 'vi'
                ? 'Bài viết rất chi tiết và đầy đủ!'
                : 'Very detailed and comprehensive article!',
              avatar: 'PL',
            },
          ])
        }
      } catch {
        if (!ignore) {
          setArticleData(null)
        }
      }
    }

    loadArticle()
    return () => { ignore = true }
  }, [code, lang])

  const handleCommentSubmit = (e) => {
    e.preventDefault()
    if (!newComment.trim()) return
    setComments([
      {
        id: Date.now(),
        name: lang === 'vi' ? 'Bạn' : 'You',
        date: lang === 'vi' ? 'Vừa xong' : 'Just now',
        content: newComment,
        avatar: 'B',
      },
      ...comments,
    ])
    setNewComment('')
  }

  const fallback = {
    title: lang === 'vi' ? 'Nghệ thuật dân gian Việt Nam' : 'Vietnamese folk arts',
    category: lang === 'vi' ? 'Nghệ Thuật' : 'Fine Arts',
    author: {
      name: lang === 'vi' ? 'Biên tập văn hoá' : 'Cultural editorial',
      role: lang === 'vi' ? 'Bài viết từ dữ liệu CSDL' : 'Database-driven article',
      initials: 'VH',
      bio: lang === 'vi'
        ? 'Nội dung biên soạn từ dữ liệu nghệ thuật dân gian.'
        : 'Content assembled from folk art database records.',
      stats: { posts: '—', followers: '—', comments: '—' },
      email: 'content@vnculturebridge.ai',
      website: 'vnculturebridge.ai',
    },
    publishedAt: '',
    readingTime: lang === 'vi' ? 'Đang cập nhật' : 'Updating',
    heroImage: '',
    heroImageAlt: '',
    intro: '',
    quote: { text: '', author: '' },
    sections: [],
    techniques: [],
    sideImages: [],
    conclusion: '',
    relatedArticles: [],
  }

  const article = {
    ...fallback,
    ...(articleData || {}),
    author: {
      ...fallback.author,
      ...(articleData?.author || {}),
      stats: {
        ...fallback.author.stats,
        ...(articleData?.author?.stats || {}),
      },
    },
    quote: {
      ...fallback.quote,
      ...(articleData?.quote || {}),
    },
    sections: Array.isArray(articleData?.sections) ? articleData.sections : fallback.sections,
    techniques: Array.isArray(articleData?.techniques) ? articleData.techniques : fallback.techniques,
    sideImages: Array.isArray(articleData?.sideImages) ? articleData.sideImages : fallback.sideImages,
    relatedArticles: Array.isArray(articleData?.relatedArticles) ? articleData.relatedArticles : fallback.relatedArticles,
  }

  const heroImage = article.heroImage || 'https://images.unsplash.com/photo-1579783901586-d88db74b4fe4?w=1600'
  const heroAlt = article.heroImageAlt || article.title
  const canRenderSections = Array.isArray(article.sections) && article.sections.length > 0
  const canRenderTechniques = Array.isArray(article.techniques) && article.techniques.length > 0
  const canRenderRelated = Array.isArray(article.relatedArticles) && article.relatedArticles.length > 0

  return (
    <div className="article-detail-page">
      <PageHeader
        lang={lang}
        onLangChange={setLang}
        breadcrumb={[
          { label: lang === 'vi' ? 'Bài Viết' : 'Articles', to: '/articles' },
          { label: article.title },
        ]}
      />

      <main className="article-detail-content">
        <div className="adc-container">
          <Link to="/articles" className="adc__back">
            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
              <path d="M15 18l-6-6 6-6" />
            </svg>
            <span>{lang === 'vi' ? 'Quay lại Bài Viết' : 'Back to Articles'}</span>
          </Link>

          <header className="adc__header fade-up">
            <span className="adc__category">{article.category}</span>
            <h1 className="adc__title">{article.title}</h1>

            <div className="adc__meta">
              <div className="adc__author">
                <div className="adc__avatar">{article.author.initials}</div>
                <div className="adc__author-info">
                  <span className="adc__author-name">{article.author.name}</span>
                  <span className="adc__author-role">{article.author.role}</span>
                </div>
              </div>

              <div className="adc__info">
                <div className="adc__divider" />
                <div className="adc__info-item">
                  <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
                    <rect x="3" y="4" width="18" height="18" rx="2" ry="2" />
                    <line x1="16" y1="2" x2="16" y2="6" />
                    <line x1="8" y1="2" x2="8" y2="6" />
                    <line x1="3" y1="10" x2="21" y2="10" />
                  </svg>
                  <span>{article.publishedAt}</span>
                </div>
                <div className="adc__info-item">
                  <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
                    <circle cx="12" cy="12" r="10" />
                    <polyline points="12 6 12 12 16 14" />
                  </svg>
                  <span>{article.readingTime}</span>
                </div>
                <div className="adc__divider" />
              </div>
            </div>
          </header>

          <div className="adc__hero-image fade-up">
            <img src={heroImage} alt={heroAlt} loading="lazy" />
            <div className="adc__hero-caption">
              {article.heroImageAlt || article.title}
            </div>
          </div>

          <div className="adc__layout">
            <div className="adc__main fade-up">
              <div className="adc__main-card">
                <section className="adc__section">
                  <p className="adc__lead">{article.intro}</p>
                  <div className="adc__separator"><span>✧ ✧ ✧</span></div>
                </section>

                {canRenderSections ? article.sections.map((sec, idx) => (
                  <section key={sec.id || idx} className="adc__section">
                    <h2 className="adc__sub-title">{sec.title}</h2>
                    {(Array.isArray(sec.paragraphs) ? sec.paragraphs : []).map((p, i) => <p key={i}>{p}</p>)}
                    {idx === 0 && article.sideImages.length ? (
                      <div className="adc__side-images">
                        {article.sideImages.map((src, i) => (
                          <img key={i} src={src} alt={`art-${i}`} loading="lazy" />
                        ))}
                      </div>
                    ) : null}
                  </section>
                )) : null}

                {article.quote.text ? (
                  <blockquote className="adc__quote">
                    <div className="adc__quote-inner">
                      <div className="adc__quote-icon">
                        <svg width="48" height="48" viewBox="0 0 24 24" fill="currentColor">
                          <path d="M14.017 21L14.017 18C14.017 16.8954 14.9124 16 16.017 16H19.017C19.5693 16 20.017 15.5523 20.017 15V9C20.017 8.44772 19.5693 8 19.017 8H15.017C14.4647 8 14.017 8.44772 14.017 9V12C14.017 12.5523 13.5693 13 13.017 13H11.017C10.4647 13 10.017 12.5523 10.017 12V9C10.017 6.79086 11.8079 5 14.017 5H19.017C21.2261 5 23.017 6.79086 23.017 9V15C23.017 18.3137 20.3307 21 17.017 21H14.017ZM1.0166 21L1.0166 18C1.0166 16.8954 1.91203 16 3.0166 16H6.0166C6.56889 16 7.0166 15.5523 7.0166 15V9C7.0166 8.44772 6.56889 8 6.0166 8H2.0166C1.46432 8 1.0166 8.44772 1.0166 9V12C1.0166 12.5523 0.568887 13 0.0166016 13H-1.9834C-2.53569 13 -2.9834 12.5523 -2.9834 12V9C-2.9834 6.79086 -1.19254 5 1.0166 5H6.0166C8.22574 5 10.0166 6.79086 10.0166 9V15C10.0166 18.3137 7.33031 21 4.0166 21H1.0166Z" opacity="0.15" />
                        </svg>
                      </div>
                      <p className="adc__quote-text">{article.quote.text}</p>
                      <cite className="adc__quote-author">— {article.quote.author}</cite>
                    </div>
                  </blockquote>
                ) : null}

                {canRenderTechniques ? (
                  <section className="adc__section">
                    <h2 className="adc__sub-title">
                      {lang === 'vi' ? 'Những Điểm Nhấn Nội Dung' : 'Key Content Highlights'}
                    </h2>
                    <p>{lang === 'vi' ? 'Các ý chính nổi bật được tóm lược từ bài viết tương ứng:' : 'The main highlights summarized from the corresponding article:'}</p>
                    <div className="adc__techniques">
                      {article.techniques.map((t, i) => (
                        <div className="adc__technique-card" key={i}>
                          <div className="adc__technique-icon">{t.icon}</div>
                          <div className="adc__technique-num">{t.id}</div>
                          <div className="adc__technique-body">
                            <h3 className="adc__technique-title">{t.title}</h3>
                            <p className="adc__technique-desc">{t.desc}</p>
                          </div>
                        </div>
                      ))}
                    </div>
                  </section>
                ) : null}

                <div className="adc__conclusion">
                  <h3 className="adc__conclusion-title">{lang === 'vi' ? 'Kết Luận' : 'Conclusion'}</h3>
                  <p>{article.conclusion}</p>
                </div>
              </div>

              <div className="adc__footer-card fade-up">
                <div className="adc__tags">
                  <span className="adc__label">{lang === 'vi' ? 'Thẻ:' : 'Tags:'}</span>
                  <div className="adc__tags-list">
                    <span className="adc-tag">#Sơn Mài</span>
                    <span className="adc-tag">#Nghệ Thuật</span>
                    <span className="adc-tag">#Di Sản</span>
                    <span className="adc-tag">#Thủ Công</span>
                  </div>
                </div>
              </div>

              <div className="adc__comments-card fade-up">
                <h3 className="adc__comments-title">
                  <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" style={{ marginRight: '12px' }}>
                    <path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z" />
                  </svg>
                  {`Bình luận (${comments.length})`}
                </h3>

                <div className="adc__comment-list">
                  {comments.map((c) => (
                    <div className="adc-comment" key={c.id}>
                      <div className="adc-comment__avatar">{c.avatar}</div>
                      <div className="adc-comment__body">
                        <div className="adc-comment__header">
                          <span className="adc-comment__name">{c.name}</span>
                          <span className="adc-comment__date">{c.date}</span>
                        </div>
                        <p className="adc-comment__text">{c.content}</p>
                      </div>
                    </div>
                  ))}
                </div>

                <form className="adc__comment-form" onSubmit={handleCommentSubmit}>
                  <textarea
                    placeholder="Chia sẻ cảm nhận của bạn về bài viết này..."
                    value={newComment}
                    onChange={(e) => setNewComment(e.target.value)}
                  />
                  <div className="adc__comment-actions">
                    <button type="submit" className="adc__comment-submit">Gửi bình luận</button>
                  </div>
                </form>
              </div>
            </div>

            <aside className="adc__sidebar fade-up">
              <div className="adc-author-card">
                <div className="adc-author-card__top" />
                <div className="adc-author-card__body">
                  <div className="adc-author-card__avatar">{article.author.initials}</div>
                  <h3 className="adc-author-card__name">{article.author.name}</h3>
                  <p className="adc-author-card__role">{article.author.role}</p>
                  <p className="adc-author-card__bio">{article.author.bio}</p>

                  <div className="adc-author-card__stats">
                    {[
                      { val: article.author.stats.posts, label: 'Bài viết' },
                      { val: article.author.stats.followers, label: 'Theo dõi' },
                      { val: article.author.stats.comments, label: 'Bình luận' },
                    ].map((s, i) => (
                      <div className="adc-author-card__stat" key={i}>
                        <span className="adc-author-card__stat-val">{s.val}</span>
                        <span className="adc-author-card__stat-label">{s.label}</span>
                      </div>
                    ))}
                  </div>

                  <div className="adc-author-card__contact">
                    <div className="adc-author-card__contact-item">
                      <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
                        <path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z" />
                        <polyline points="22,6 12,13 2,6" />
                      </svg>
                      <span>{article.author.email}</span>
                    </div>
                    <div className="adc-author-card__contact-item">
                      <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
                        <circle cx="12" cy="12" r="10" />
                        <line x1="2" y1="12" x2="22" y2="12" />
                        <path d="M12 2a15.3 15.3 0 0 1 4 10 15.3 15.3 0 0 1-4 10 15.3 15.3 0 0 1-4-10 15.3 15.3 0 0 1 4-10z" />
                      </svg>
                      <span>{article.author.website}</span>
                    </div>
                  </div>

                  <button className="adc-author-card__follow">Theo dõi tác giả</button>
                </div>
              </div>

              <div className="adc__stats-card">
                <h3 className="adc__sidebar-title">{lang === 'vi' ? 'Thống Kê Nghề' : 'Craft Statistics'}</h3>
                {[
                  { label: lang === 'vi' ? 'Số lớp sơn tối thiểu' : 'Min. lacquer layers', val: '10–15', pct: 85 },
                  { label: lang === 'vi' ? 'Thời gian hoàn thiện' : 'Completion time', val: '3–6 tháng', pct: 70 },
                  { label: lang === 'vi' ? 'Làng nghề còn hoạt động' : 'Active craft villages', val: '~40+', pct: 60 },
                ].map((s, i) => (
                  <div className="adc__stat-row" key={i}>
                    <div className="adc__stat-top">
                      <span className="adc__stat-label">{s.label}</span>
                      <span className="adc__stat-val">{s.val}</span>
                    </div>
                    <div className="adc__stat-bar">
                      <div className="adc__stat-fill" style={{ width: `${s.pct}%` }} />
                    </div>
                  </div>
                ))}
              </div>

              {canRenderRelated ? (
                <div className="adc__related">
                  <h3 className="adc__sidebar-title">{lang === 'vi' ? 'Bài Viết Liên Quan' : 'Related Articles'}</h3>
                  <div className="adc__related-list">
                    {article.relatedArticles.map((post, i) => (
                      <Link to={post.code ? `/articles/${post.code}` : '#'} key={i} className="adc-related-item">
                        <div className="adc-related-item__img">
                          <img src={post.image || 'https://images.unsplash.com/photo-1579783901586-d88db74b4fe4?w=400'} alt={post.title} loading="lazy" />
                          <span className="adc-related-item__tag">{post.category}</span>
                        </div>
                        <div className="adc-related-item__info">
                          <h4 className="adc-related-item__title">{post.title}</h4>
                          <span className="adc-related-item__date">{post.date}</span>
                        </div>
                      </Link>
                    ))}
                  </div>
                </div>
              ) : null}
            </aside>
          </div>
        </div>
      </main>

      <Footer lang={lang} />
    </div>
  )
}

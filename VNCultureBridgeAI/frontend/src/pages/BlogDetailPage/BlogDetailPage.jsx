import { useState, useMemo } from 'react'
import { useParams, Link } from 'react-router-dom'
import PageHeader from '../../components/layout/PageHeader/PageHeader'
import Footer from '../../components/layout/Footer/Footer'
import './BlogDetailPage.css'

/**
 * BlogDetailPage component.
 * Displays a detailed view of a blog post with premium "Cream & Red" styling.
 */
export default function BlogDetailPage() {
  const { code } = useParams()
  const [lang, setLang] = useState('vi')

  // Mock data matching the user's reference image
  const blogData = useMemo(() => ({
    title: lang === 'vi' ? 'Tết Nguyên Đán: Nét Văn Hóa Nghìn Năm Của Người Việt' : 'Lunar New Year: A Thousand-Year Culture of the Vietnamese',
    category: lang === 'vi' ? 'Lễ Hội' : 'Festival',
    author: {
      name: 'Mai Anh',
      role: lang === 'vi' ? 'Biên Tập Viên Văn Hóa' : 'Cultural Editor',
      initials: 'MA',
      bio: lang === 'vi' ? 'Người yêu và nghiên cứu văn hóa Việt Nam, với đam mê chia sẻ những giá trị truyền thống đến mọi người.' : 'Vietnamese culture lover and researcher, with a passion for sharing traditional values with everyone.',
      stats: {
        posts: '48',
        followers: '2.5k',
        comments: '120'
      },
      email: 'maianh@vnculture.vn',
      website: 'maianh.blog.vn'
    },
    publishedAt: lang === 'vi' ? '15 Tháng 3, 2026' : 'March 15, 2026',
    readingTime: lang === 'vi' ? '8 phút đọc' : '8 min read',
    imageUrl: 'https://images.unsplash.com/photo-1614704104921-995221021644?mw=1600',
    intro: lang === 'vi' 
      ? 'Tết Nguyên Đán, hay còn gọi đơn giản là Tết, không chỉ là dịp lễ quan trọng nhất trong năm của người Việt Nam mà còn là biểu tượng văn hóa sâu sắc, gắn liền với lịch sử hàng nghìn năm của dân tộc. Đây là thời điểm mà mọi người dành thời gian sum họp gia đình, tưởng nhớ tổ tiên và đón chào một năm mới tràn đầy hy vọng.'
      : 'Lunar New Year, or simply Tet, is not only the most important holiday of the year for Vietnamese people but also a profound cultural symbol, associated with the country\'s thousands of years of history. This is the time when people spend time reuniting with their families, remembering their ancestors, and welcoming a new year full of hope.',
    quote: {
      text: lang === 'vi' ? 'Tết đến, xuân về, nhà nhà sum họp, người người vui vẻ. Đó là khoảnh khắc thiêng liêng nhất trong tâm thức người Việt.' : 'Tet comes, spring arrives, every family reunites, everyone is happy. That is the most sacred moment in the Vietnamese mindset.',
      author: lang === 'vi' ? 'Ca dao dân gian Việt Nam' : 'Vietnamese Folk Proverb'
    },
    customsTitle: lang === 'vi' ? 'Phong Tục Truyền Thống' : 'Traditional Customs',
    customsDescription: lang === 'vi' ? 'Tết Nguyên Đán gắn liền với nhiều phong tục truyền thống đặc sắc, mỗi phong tục đều mang ý nghĩa riêng:' : 'Lunar New Year is associated with many unique traditional customs, each carrying its own meaning:',
    customs: [
      {
        id: '01',
        title: lang === 'vi' ? 'Cúng Ông Công, Ông Táo' : 'Offerings to Land Genie and Kitchen Gods',
        desc: lang === 'vi' ? 'Vào ngày 23 tháng Chạp, người Việt cúng Ông Công Ông Táo về trời báo cáo với Ngọc Hoàng về những việc làm của gia đình trong năm qua.' : 'On the 23rd day of the last lunar month, Vietnamese people make offerings to the Land Genie and Kitchen Gods to report to the Jade Emperor about the family\'s activities over the year.'
      },
      {
        id: '02',
        title: lang === 'vi' ? 'Trang Trí Nhà Cửa' : 'Home Decoration',
        desc: lang === 'vi' ? 'Người ta dọn dẹp nhà cửa sạch sẽ, trang trí với hoa mai, hoa đào, câu đối đỏ và các vật phẩm mang ý nghĩa may mắn.' : 'People clean their houses and decorate them with apricot flowers, peach blossoms, red couplets, and items that symbolize luck.'
      },
      {
        id: '03',
        title: lang === 'vi' ? 'Bánh Chưng, Bánh Tét' : 'Banh Chung, Banh Tet',
        desc: lang === 'vi' ? 'Món ăn truyền thống không thể thiếu trong mâm cỗ Tết, tượng trưng cho đất trời và lòng biết ơn của con người với thiên nhiên.' : 'Traditional dishes that cannot be missing from the Tet feast, symbolizing the earth and sky and human gratitude to nature.'
      },
      {
        id: '04',
        title: lang === 'vi' ? 'Xông Đất Đầu Năm' : 'First Footer',
        desc: lang === 'vi' ? 'Người đầu tiên bước vào nhà vào sáng mùng 1 Tết được cho là mang lại vận may cho cả năm.' : 'The first person to enter a house on the morning of the 1st day of Tet is believed to bring luck for the entire year.'
      }
    ],
    relatedPostsTitle: lang === 'vi' ? 'Bài Viết Liên Quan' : 'Related Posts',
    relatedPosts: [
      {
        title: lang === 'vi' ? 'Bánh Chưng: Linh Hồn Mâm Cổ Tết' : 'Banh Chung: The Soul of Tet Feast',
        date: lang === 'vi' ? '10 Tháng 3, 2026' : 'March 10, 2026',
        category: lang === 'vi' ? 'Ẩm thực' : 'Cuisine',
        image: 'https://images.unsplash.com/photo-1599940824399-b87987ceb72a?mw=1000'
      },
      {
        title: lang === 'vi' ? 'Hoa Mai Vàng: Biểu Tượng Của Mùa Xuân' : 'Yellow Apricot: Symbol of Spring',
        date: lang === 'vi' ? '8 Tháng 3, 2026' : 'March 8, 2026',
        category: lang === 'vi' ? 'Truyền thống' : 'Tradition',
        image: 'https://images.unsplash.com/photo-1614704104921-995221021644?mw=1000'
      },
      {
        title: lang === 'vi' ? 'Lì Xì Đầu Năm: Ý Nghĩa Và Văn Hóa' : 'New Year Lucky Money: Meaning and Culture',
        date: lang === 'vi' ? '5 Tháng 3, 2026' : 'March 5, 2026',
        category: lang === 'vi' ? 'Lễ hội' : 'Festival',
        image: 'https://images.unsplash.com/photo-1582230842845-6f6eb3906385?mw=1000'
      }
    ]
  }), [lang])

  // Comment State
  const [comments, setComments] = useState([
    {
      id: 1,
      name: 'Nguyễn Văn An',
      date: lang === 'vi' ? '16 Tháng 3, 2026' : 'March 16, 2026',
      content: lang === 'vi' ? 'Bài viết rất hay và ý nghĩa! Tôi đã hiểu thêm nhiều về phong tục xông đất đầu năm.' : 'Great and meaningful article! I learned more about the custom of the first footer at the beginning of the year.',
      avatar: 'NA'
    },
    {
      id: 2,
      name: 'Lê Thị Bình',
      date: lang === 'vi' ? '15 Tháng 3, 2026' : 'March 15, 2026',
      content: lang === 'vi' ? 'Mâm cỗ Tết miền Bắc và miền Nam có nhiều sự khác biệt thú vị thật.' : 'The Tet feast in the North and South has many interesting differences.',
      avatar: 'LB'
    }
  ])
  const [newComment, setNewComment] = useState('')

  const handleCommentSubmit = (e) => {
    e.preventDefault()
    if (!newComment.trim()) return

    const comment = {
      id: Date.now(),
      name: 'Bạn',
      date: lang === 'vi' ? 'Vừa xong' : 'Just now',
      content: newComment,
      avatar: 'U'
    }

    setComments([comment, ...comments])
    setNewComment('')
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
              <div className="blog-detail__author">
                <div className="blog-detail__avatar">{blogData.author.initials}</div>
                <div className="blog-detail__author-info">
                  <span className="blog-detail__author-name">{blogData.author.name}</span>
                  <span className="blog-detail__author-role">{blogData.author.role}</span>
                </div>
              </div>

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

                  <h2 className="blog-detail__sub-title">Nguồn gốc và ý nghĩa</h2>
                  <p>
                    {lang === 'vi' 
                      ? 'Tết Nguyên Đán bắt nguồn từ nền văn minh nông nghiệp lúa nước, đánh dấu sự chuyển giao giữa mùa đông và mùa xuân, giữa năm cũ và năm mới. Theo quan niệm của người Việt, đây là thời điểm thiên nhiên thay đổi, vạn vật sinh sôi và con người bắt đầu một chu kỳ mới đầy hứa hẹn.' 
                      : 'Lunar New Year originates from the wet rice agricultural civilization, marking the transition between winter and spring, between the old year and the new year. According to Vietnamese belief, this is the time when nature changes, everything thrives, and people begin a new promising cycle.'}
                  </p>
                  <p>
                    {lang === 'vi'
                      ? 'Tết không chỉ là dịp để nghỉ ngơi, thư giãn sau một năm làm việc vất vả mà còn là dịp để mọi người nhìn lại những gì đã qua, đồng thời hướng tới tương lai với những kỳ vọng tốt đẹp. Đây cũng là thời gian để thực hiện các nghi lễ truyền thống như cúng ông bà, tổ tiên, cầu may mắn và bình an cho năm mới.'
                      : 'Tet is not only an opportunity to rest and relax after a hard-working year but also a time for everyone to look back at the past and look forward to the future with good expectations. This is also the time to perform traditional rituals such as offerings to ancestors, praying for luck and peace for the new year.'}
                  </p>
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

                <section className="blog-detail__section customs">
                  <h2 className="blog-detail__sub-title">{blogData.customsTitle}</h2>
                  <p>{blogData.customsDescription}</p>
                  
                  <div className="blog-detail__customs-list">
                    {blogData.customs.map((item, index) => (
                      <div className="blog-detail__custom-card" key={index}>
                        <div className="blog-detail__custom-num">{index + 1}.</div>
                        <div className="blog-detail__custom-content">
                          <h3 className="blog-detail__custom-title">{item.title}</h3>
                          <p className="blog-detail__custom-desc">{item.desc}</p>
                        </div>
                      </div>
                    ))}
                  </div>
                </section>

                <section className="blog-detail__section modern">
                  <h2 className="blog-detail__sub-title">Tết trong thời hiện đại</h2>
                  <div className="blog-detail__side-images">
                    <img src="https://images.unsplash.com/photo-1582230842845-6f6eb3906385?mw=800" alt="Múa lân ngày Tết" />
                    <img src="https://images.unsplash.com/photo-1599940824399-b87987ceb72a?mw=800" alt="Nghi thức ngày Tết" />
                  </div>
                  <p>
                    {lang === 'vi' 
                      ? 'Mặc dù xã hội hiện đại đã thay đổi nhiều, nhưng Tết Nguyên Đán vẫn giữ được vị trí đặc biệt trong lòng người Việt. Những giá trị truyền thống như sum họp gia đình, lễ nghi tôn giáo, và tinh thần đoàn kết cộng đồng vẫn được lưu giữ và phát huy.' 
                      : 'Although modern society has changed much, Lunar New Year still holds a special place in the hearts of Vietnamese people. Traditional values such as family reunion, religious rituals, and the spirit of community solidarity are still preserved and promoted.'}
                  </p>
                  <p>
                    {lang === 'vi'
                      ? 'Ngày nay, Tết không chỉ là dịp lễ của riêng người Việt mà còn được nhiều quốc gia trên thế giới công nhận và tôn vinh. Đây là minh chứng cho sức sống mãnh liệt của văn hóa Việt Nam và sự tự hào của mỗi người con đất Việt.'
                      : 'Today, Tet is not only a celebration for Vietnamese people but is also recognized and honored by many countries around the world. This is evidence of the intense vitality of Vietnamese culture and the pride of every Vietnamese child.'}
                  </p>

                  <div className="blog-detail__conclusion">
                    <h3 className="blog-detail__conclusion-title">Kết luận</h3>
                    <p>
                      {lang === 'vi'
                        ? 'Tết Nguyên Đán là di sản văn hóa quý báu, là niềm tự hào của dân tộc Việt Nam. Dù thời gian có trôi qua, những giá trị cốt lõi của Tết - tinh thần, lòng hiếu thảo, và hy vọng về một năm mới tốt đẹp - vẫn luôn được gìn giữ và truyền đạt qua các thế hệ. Hãy cùng nhau bảo tồn và phát huy những giá trị truyền thống tốt đẹp này để Tết mãi mãi là dịp lễ ý nghĩa nhất trong lòng mỗi người Việt.'
                        : 'Lunar New Year is a precious cultural heritage, a pride of the Vietnamese nation. No matter how much time passes, the core values of Tet - spirit, filial piety, and hope for a better new year - are always preserved and transmitted through generations. Let us together preserve and promote these good traditional values so that Tet remains the most meaningful holiday in the heart of every Vietnamese person.'}
                    </p>
                  </div>
                </section>
              </div>

              {/* Tag & Share Card */}
              <div className="blog-detail__footer-card fade-up">
                <div className="blog-detail__tags">
                  <span className="blog-detail__tags-label">Thẻ:</span>
                  <div className="blog-detail__tags-list">
                    <span className="tag-item">#Tết Nguyên Đán</span>
                    <span className="tag-item">#Văn hóa</span>
                    <span className="tag-item">#Truyền thống</span>
                    <span className="tag-item">#Lễ hội</span>
                  </div>
                </div>
                <div className="blog-detail__share">
                  <span className="blog-detail__share-label">Chia sẻ:</span>
                  <div className="blog-detail__share-list">
                    <button className="share-btn"><i className="fab fa-facebook-f"></i></button>
                    <button className="share-btn"><i className="fab fa-twitter"></i></button>
                    <button className="share-btn"><i className="fab fa-linkedin-in"></i></button>
                    <button className="share-btn"><i className="fas fa-link"></i></button>
                  </div>
                </div>
              </div>

              {/* Comments Section */}
              <div className="blog-detail__comments-card fade-up">
                <h3 className="blog-detail__comments-title">
                  <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" style={{marginRight: '12px'}}>
                    <path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z" />
                  </svg>
                  {`Bình luận (${comments.length})`}
                </h3>
                
                {/* Comment List */}
                <div className="blog-detail__comment-list">
                  {comments.map((comment) => (
                    <div className="comment-item" key={comment.id}>
                      <div className="comment-item__avatar">{comment.avatar}</div>
                      <div className="comment-item__content">
                        <div className="comment-item__header">
                          <span className="comment-item__name">{comment.name}</span>
                          <span className="comment-item__date">{comment.date}</span>
                        </div>
                        <p className="comment-item__text">{comment.content}</p>
                      </div>
                    </div>
                  ))}
                </div>

                {/* Comment Input */}
                <form className="comment-input-wrapper" onSubmit={handleCommentSubmit}>
                  <textarea 
                    placeholder="Chia sẻ suy nghĩ của bạn về bài viết..."
                    value={newComment}
                    onChange={(e) => setNewComment(e.target.value)}
                  ></textarea>
                  <div className="comment-input__actions">
                    <button type="submit" className="comment-submit-btn">
                      Gửi bình luận
                    </button>
                  </div>
                </form>
              </div>
            </div>

            <aside className="blog-detail__sidebar fade-up">
              {/* Author Card */}
              <div className="author-card">
                <div className="author-card__content">
                  <div className="author-card__avatar">{blogData.author.initials}</div>
                  <h3 className="author-card__name">{blogData.author.name}</h3>
                  <p className="author-card__role">{blogData.author.role}</p>
                  <p className="author-card__bio">{blogData.author.bio}</p>
                  
                  <div className="author-card__stats">
                    <div className="author-card__stat">
                      <span className="author-card__stat-val">{blogData.author.stats.posts}</span>
                      <span className="author-card__stat-label">Bài viết</span>
                    </div>
                    <div className="author-card__stat">
                      <span className="author-card__stat-val">{blogData.author.stats.followers}</span>
                      <span className="author-card__stat-label">Người theo dõi</span>
                    </div>
                    <div className="author-card__stat">
                      <span className="author-card__stat-val">{blogData.author.stats.comments}</span>
                      <span className="author-card__stat-label">Bình luận</span>
                    </div>
                  </div>

                  <div className="author-card__contact">
                    <div className="author-card__contact-item">
                      <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
                        <path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z" />
                        <polyline points="22,6 12,13 2,6" />
                      </svg>
                      <span>{blogData.author.email}</span>
                    </div>
                    <div className="author-card__contact-item">
                      <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
                        <circle cx="12" cy="12" r="10" />
                        <line x1="2" y1="12" x2="22" y2="12" />
                        <path d="M12 2a15.3 15.3 0 0 1 4 10 15.3 15.3 0 0 1-4 10 15.3 15.3 0 0 1-4-10 15.3 15.3 0 0 1 4-10z" />
                      </svg>
                      <span>{blogData.author.website}</span>
                    </div>
                  </div>

                  <button className="author-card__follow">
                    Theo dõi
                  </button>
                </div>
              </div>

              {/* Related Posts */}
              <div className="related-section">
                <h3 className="sidebar-title">{blogData.relatedPostsTitle}</h3>
                <div className="related-list">
                  {blogData.relatedPosts.map((post, index) => (
                    <Link to="#" key={index} className="related-item">
                      <div className="related-item__image">
                        <img src={post.image} alt={post.title} />
                        <span className="related-item__tag">{post.category}</span>
                      </div>
                      <div className="related-item__info">
                        <h4 className="related-item__title">{post.title}</h4>
                        <span className="related-item__date">{post.date}</span>
                      </div>
                    </Link>
                  ))}
                </div>
              </div>
            </aside>
          </div>

        </div>
      </main>

      <Footer lang={lang} />
    </div>
  )
}

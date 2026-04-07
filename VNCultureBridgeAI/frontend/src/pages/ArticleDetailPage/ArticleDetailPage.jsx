import { useState, useMemo } from 'react'
import { useParams, Link } from 'react-router-dom'
import PageHeader from '../../components/layout/PageHeader/PageHeader'
import Footer from '../../components/layout/Footer/Footer'
import './ArticleDetailPage.css'

/**
 * ArticleDetailPage component.
 * Hiển thị chi tiết một bài viết văn hóa với giao diện "Cream & Red" cao cấp.
 */
export default function ArticleDetailPage() {
  const { code } = useParams()
  const [lang, setLang] = useState('vi')

  // ─── Mock data ────────────────────────────────────────────────────────────
  const articleData = useMemo(() => ({
    title: lang === 'vi'
      ? 'Nghệ Thuật Sơn Mài: Tinh Hoa Hội Họa Việt Nam Nghìn Năm'
      : 'Lacquer Art: A Thousand-Year Pinnacle of Vietnamese Painting',
    category: lang === 'vi' ? 'Nghệ Thuật' : 'Fine Arts',
    author: {
      name: 'Trần Minh Khoa',
      role: lang === 'vi' ? 'Chuyên Gia Nghệ Thuật' : 'Art Specialist',
      initials: 'TK',
      bio: lang === 'vi'
        ? 'Nhà nghiên cứu nghệ thuật truyền thống Việt Nam, với hơn 15 năm khám phá và gìn giữ các giá trị thủ công mỹ nghệ dân tộc.'
        : 'Vietnamese traditional art researcher with over 15 years of exploring and preserving national craftsmanship values.',
      stats: { posts: '63', followers: '4.1k', comments: '310' },
      email: 'minhkhoa@vnculture.vn',
      website: 'tranhsonmai.vn'
    },
    publishedAt: lang === 'vi' ? '20 Tháng 3, 2026' : 'March 20, 2026',
    readingTime: lang === 'vi' ? '10 phút đọc' : '10 min read',
    heroImage: 'https://images.unsplash.com/photo-1579783901586-d88db74b4fe4?w=1600',
    intro: lang === 'vi'
      ? 'Sơn mài là một trong những loại hình nghệ thuật độc đáo và tinh tế nhất của Việt Nam, bắt nguồn từ truyền thống sử dụng nhựa cây sơn (Rhus succedanea) để tạo ra những tác phẩm có vẻ đẹp lấp lánh, huyền bí và bền vững theo thời gian. Đây không chỉ là một nghề thủ công, mà còn là biểu tượng của trí tuệ và tâm hồn người Việt.'
      : 'Lacquer art is one of the most unique and refined art forms in Vietnam, originating from the tradition of using lacquer resin (Rhus succedanea) to create works of shimmering, mysterious, and enduring beauty. This is not merely a craft but a symbol of the wisdom and spirit of the Vietnamese people.',
    quote: {
      text: lang === 'vi'
        ? 'Mỗi lớp sơn là một trang sử, mỗi tác phẩm là một cuộc hành trình qua nghìn năm văn hóa Việt.'
        : 'Each layer of lacquer is a page of history; each work is a journey through a thousand years of Vietnamese culture.',
      author: lang === 'vi' ? 'Nghệ Nhân Làng Bình Dương' : 'Artisan of Binh Duong Village'
    },
    sections: [
      {
        id: 'origin',
        title: lang === 'vi' ? 'Nguồn Gốc & Lịch Sử' : 'Origin & History',
        paragraphs: [
          lang === 'vi'
            ? 'Nghề sơn mài ở Việt Nam có lịch sử lâu đời, trải dài hơn 2.000 năm. Những di chỉ khảo cổ tại Đông Sơn cho thấy người Việt cổ đã biết sử dụng nhựa sơn để trang trí và bảo quản đồ vật ngay từ thời kỳ đầu của nền văn minh. Tại làng Đình Bảng (Bắc Ninh) và các làng nghề truyền thống ở miền Bắc, nghề sơn mài đã được truyền từ đời này sang đời khác, gìn giữ những bí quyết pha chế và kỹ thuật tô sơn tinh xảo.'
            : 'Lacquer crafting in Vietnam has a long history spanning over 2,000 years. Archaeological sites at Dong Son show that ancient Vietnamese people were already using lacquer resin to decorate and preserve objects in the early stages of their civilization. In Dinh Bang village (Bac Ninh) and other traditional craft villages in the North, the lacquer craft has been passed down from generation to generation, preserving secret formulas and sophisticated painting techniques.',
          lang === 'vi'
            ? 'Bước vào thế kỷ XX, phong trào nghệ thuật hiện đại đã mang đến làn gió mới cho sơn mài Việt Nam. Các họa sĩ trường Mỹ thuật Đông Dương như Nguyễn Gia Trí, Trần Văn Cẩn đã sáng tạo ra một ngôn ngữ hội họa sơn mài chưa từng có, kết hợp giữa kỹ thuật sơn cổ truyền với tư duy thẩm mỹ hiện đại phương Tây.'
            : 'Entering the 20th century, the modern art movement brought a new breeze to Vietnamese lacquer art. Painters from the Indochina Fine Arts School such as Nguyen Gia Tri and Tran Van Can created an unprecedented lacquer painting language, combining traditional lacquer techniques with modern Western aesthetic thinking.'
        ]
      },
      {
        id: 'technique',
        title: lang === 'vi' ? 'Kỹ Thuật Chế Tác' : 'Crafting Technique',
        paragraphs: [
          lang === 'vi'
            ? 'Quy trình làm một bức tranh sơn mài chuẩn mực đòi hỏi sự tỉ mỉ và kiên nhẫn đặc biệt. Đầu tiên, người thợ chuẩn bị vóc (ván gỗ hoặc vải) bằng cách phết nhiều lớp sơn sống lên để tạo nền cứng, bền. Tiếp theo, họ vẽ phác thảo và bắt đầu quá trình đắp nổi với vỏ trứng, vỏ ốc, vàng lá, bạc lá...'
            : 'The process of creating a standard lacquer painting requires exceptional meticulousness and patience. First, the craftsman prepares the voc (wooden board or fabric) by applying multiple coats of raw lacquer to create a firm, durable base. Next, they sketch and begin the embossing process with eggshell, snail shells, gold leaf, silver leaf...',
          lang === 'vi'
            ? 'Sau khi vẽ xong, bức tranh được phủ nhiều lớp sơn bóng, mài và đánh bóng qua nhiều lần. Quá trình này có thể kéo dài từ 3 đến 6 tháng cho một tác phẩm hoàn chỉnh. Kết quả cuối cùng là một bức tranh có chiều sâu không gian tuyệt vời, ánh sáng như phát ra từ bên trong và màu sắc rực rỡ, bền màu theo thời gian.'
            : 'After painting, the work is covered with multiple coats of glossy lacquer, ground and polished multiple times. This process can take 3 to 6 months for a completed work. The final result is a painting with extraordinary spatial depth, light seemingly emanating from within, and vibrant, long-lasting colors.'
        ]
      }
    ],
    techniques: [
      {
        id: '01',
        title: lang === 'vi' ? 'Chuẩn Bị Vóc & Nền' : 'Preparing the Base',
        desc: lang === 'vi'
          ? 'Phủ 5-7 lớp sơn sống lên ván gỗ hoặc vải bố, mài phẳng giữa mỗi lớp để tạo nền cứng chắc, không nứt vỡ.'
          : 'Apply 5-7 coats of raw lacquer onto wood or burlap, sanding between each coat to create a firm, crack-resistant base.',
        icon: '🎨'
      },
      {
        id: '02',
        title: lang === 'vi' ? 'Đắp Nổi & Dát Vàng' : 'Embossing & Gold Leafing',
        desc: lang === 'vi'
          ? 'Sử dụng vỏ trứng, vỏ trai và vàng bạc lá để tạo hiệu ứng lấp lánh, ba chiều cho từng mảng màu.'
          : 'Use eggshell, mother-of-pearl, and gold and silver leaf to create shimmering, three-dimensional effects for each color field.',
        icon: '✨'
      },
      {
        id: '03',
        title: lang === 'vi' ? 'Phủ Sơn & Mài Sơn' : 'Lacquering & Sanding',
        desc: lang === 'vi'
          ? 'Phủ liên tục 10-15 lớp sơn bóng, đan xen với mài bằng đá ướt để lộ dần các lớp màu và tạo chiều sâu.'
          : 'Continuously apply 10-15 coats of glossy lacquer, interspersed with wet-stone sanding to gradually reveal color layers and create depth.',
        icon: '🪨'
      },
      {
        id: '04',
        title: lang === 'vi' ? 'Đánh Bóng Hoàn Thiện' : 'Final Polishing',
        desc: lang === 'vi'
          ? 'Dùng than củi nghiền mịn và lòng bàn tay để đánh bóng cuối cùng, tạo độ bóng như gương phản chiếu ánh sáng.'
          : 'Use finely ground charcoal and the palm of the hand for the final polishing, creating a mirror-like shine that reflects light.',
        icon: '💎'
      }
    ],
    sideImages: [
      'https://images.unsplash.com/photo-1567689265664-3bc6e1e4b07b?w=800',
      'https://images.unsplash.com/photo-1619164601044-90e0e1d0e87b?w=800'
    ],
    conclusion: lang === 'vi'
      ? 'Nghệ thuật sơn mài Việt Nam là một kho báu văn hóa cần được bảo tồn và phát huy. Trong thời đại toàn cầu hóa, hội họa sơn mài không những không lỗi thời mà còn được các nghệ sĩ trẻ tái diễn giải, mang lại những tác phẩm đương đại mang đậm bản sắc dân tộc. Đây là bằng chứng cho sức sống mãnh liệt của một nền văn hóa biết giữ gốc mà vẫn vươn cành.'
      : 'Vietnamese lacquer art is a cultural treasure that needs to be preserved and promoted. In the age of globalization, lacquer painting is not only not outdated but is being reinterpreted by young artists, producing contemporary works deeply imbued with national identity. This is proof of the resilient vitality of a culture that knows how to keep its roots while reaching new branches.',
    relatedArticles: [
      {
        title: lang === 'vi' ? 'Tranh Đông Hồ: Nét Dân Gian Trong Từng Bức Khắc' : 'Dong Ho Painting: Folk Art in Every Wood Block',
        date: lang === 'vi' ? '15 Tháng 3, 2026' : 'March 15, 2026',
        category: lang === 'vi' ? 'Hội Họa' : 'Painting',
        image: 'https://images.unsplash.com/photo-1567689265664-3bc6e1e4b07b?w=400'
      },
      {
        title: lang === 'vi' ? 'Gốm Bát Tràng: Di Sản 500 Năm Bên Dòng Sông Hồng' : 'Bat Trang Pottery: 500-Year Heritage on Red River Bank',
        date: lang === 'vi' ? '10 Tháng 3, 2026' : 'March 10, 2026',
        category: lang === 'vi' ? 'Thủ Công' : 'Crafts',
        image: 'https://images.unsplash.com/photo-1619164601044-90e0e1d0e87b?w=400'
      },
      {
        title: lang === 'vi' ? 'Lụa Hà Đông: Tinh Hoa Bền Vững Qua Nghìn Năm' : 'Ha Dong Silk: Enduring Craft Through A Millennium',
        date: lang === 'vi' ? '5 Tháng 3, 2026' : 'March 5, 2026',
        category: lang === 'vi' ? 'Dệt May' : 'Textiles',
        image: 'https://images.unsplash.com/photo-1565958011703-44f9829ba187?w=400'
      }
    ]
  }), [lang])

  // ─── Comments state ───────────────────────────────────────────────────────
  const [comments, setComments] = useState([
    {
      id: 1,
      name: 'Phạm Thị Lan',
      date: lang === 'vi' ? '21 Tháng 3, 2026' : 'March 21, 2026',
      content: lang === 'vi'
        ? 'Bài viết rất chi tiết và đầy đủ! Tôi chưa biết rằng quy trình làm một bức tranh sơn mài lại phức tạp và tốn thời gian đến vậy. Cảm ơn tác giả đã chia sẻ.'
        : 'Very detailed and comprehensive article! I did not know that the process of making a lacquer painting was so complex and time-consuming. Thank you to the author for sharing.',
      avatar: 'PL'
    },
    {
      id: 2,
      name: 'Vũ Hoàng Anh',
      date: lang === 'vi' ? '20 Tháng 3, 2026' : 'March 20, 2026',
      content: lang === 'vi'
        ? 'Tôi đã từng đến thăm các làng nghề sơn mài ở Bình Dương, thực sự ấn tượng với sự kiên nhẫn và tài năng của các nghệ nhân. Mong rằng nghề truyền thống này sẽ được tiếp tục phát huy.'
        : 'I once visited lacquer craft villages in Binh Duong, truly impressed by the patience and talent of the artisans. I hope this traditional craft will continue to be promoted.',
      avatar: 'VA'
    }
  ])
  const [newComment, setNewComment] = useState('')

  const handleCommentSubmit = (e) => {
    e.preventDefault()
    if (!newComment.trim()) return
    setComments([
      {
        id: Date.now(),
        name: lang === 'vi' ? 'Bạn' : 'You',
        date: lang === 'vi' ? 'Vừa xong' : 'Just now',
        content: newComment,
        avatar: 'B'
      },
      ...comments
    ])
    setNewComment('')
  }

  // ─── Render ───────────────────────────────────────────────────────────────
  return (
    <div className="article-detail-page">
      <PageHeader
        lang={lang}
        onLangChange={setLang}
        breadcrumb={[
          { label: lang === 'vi' ? 'Bài Viết' : 'Articles', to: '/articles' },
          { label: articleData.title }
        ]}
      />

      <main className="article-detail-content">
        <div className="adc-container">

          {/* Back Button */}
          <Link to="/articles" className="adc__back">
            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
              <path d="M15 18l-6-6 6-6" />
            </svg>
            <span>{lang === 'vi' ? 'Quay lại Bài Viết' : 'Back to Articles'}</span>
          </Link>

          {/* ── Hero Header ─────────────────────────────────────────── */}
          <header className="adc__header fade-up">
            <span className="adc__category">{articleData.category}</span>
            <h1 className="adc__title">{articleData.title}</h1>

            <div className="adc__meta">
              <div className="adc__author">
                <div className="adc__avatar">{articleData.author.initials}</div>
                <div className="adc__author-info">
                  <span className="adc__author-name">{articleData.author.name}</span>
                  <span className="adc__author-role">{articleData.author.role}</span>
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
                  <span>{articleData.publishedAt}</span>
                </div>
                <div className="adc__info-item">
                  <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
                    <circle cx="12" cy="12" r="10" />
                    <polyline points="12 6 12 12 16 14" />
                  </svg>
                  <span>{articleData.readingTime}</span>
                </div>
                <div className="adc__divider" />
              </div>

              <div className="adc__actions">
                <button className="adc__action-btn" aria-label="Bookmark">
                  <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
                    <path d="M19 21l-7-5-7 5V5a2 2 0 0 1 2-2h10a2 2 0 0 1 2 2z" />
                  </svg>
                </button>
                <button className="adc__action-btn" aria-label="Share">
                  <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
                    <circle cx="18" cy="5" r="3" /><circle cx="6" cy="12" r="3" /><circle cx="18" cy="19" r="3" />
                    <line x1="8.59" y1="13.51" x2="15.42" y2="17.49" />
                    <line x1="15.41" y1="6.51" x2="8.6" y2="10.49" />
                  </svg>
                </button>
              </div>
            </div>
          </header>

          {/* Hero Image */}
          <div className="adc__hero-image fade-up">
            <img src={articleData.heroImage} alt={articleData.title} loading="lazy" />
            <div className="adc__hero-caption">
              {lang === 'vi'
                ? 'Nghệ nhân đang mài bức tranh sơn mài tại xưởng truyền thống Hà Nội'
                : 'An artisan grinding a lacquer painting at a traditional Hanoi workshop'}
            </div>
          </div>

          {/* ── Two-column Layout ────────────────────────────────────── */}
          <div className="adc__layout">

            {/* ── Main Column ── */}
            <div className="adc__main fade-up">
              <div className="adc__main-card">

                {/* Intro */}
                <section className="adc__section">
                  <p className="adc__lead">{articleData.intro}</p>
                  <div className="adc__separator"><span>✧ ✧ ✧</span></div>
                </section>

                {/* Dynamic content sections */}
                {articleData.sections.map((sec, idx) => (
                  <section key={sec.id} className="adc__section">
                    <h2 className="adc__sub-title">{sec.title}</h2>
                    {sec.paragraphs.map((p, i) => <p key={i}>{p}</p>)}

                    {/* Insert side images after first section */}
                    {idx === 0 && (
                      <div className="adc__side-images">
                        {articleData.sideImages.map((src, i) => (
                          <img key={i} src={src} alt={`art-${i}`} loading="lazy" />
                        ))}
                      </div>
                    )}
                  </section>
                ))}

                {/* Quote */}
                <blockquote className="adc__quote">
                  <div className="adc__quote-inner">
                    <div className="adc__quote-icon">
                      <svg width="48" height="48" viewBox="0 0 24 24" fill="currentColor">
                        <path d="M14.017 21L14.017 18C14.017 16.8954 14.9124 16 16.017 16H19.017C19.5693 16 20.017 15.5523 20.017 15V9C20.017 8.44772 19.5693 8 19.017 8H15.017C14.4647 8 14.017 8.44772 14.017 9V12C14.017 12.5523 13.5693 13 13.017 13H11.017C10.4647 13 10.017 12.5523 10.017 12V9C10.017 6.79086 11.8079 5 14.017 5H19.017C21.2261 5 23.017 6.79086 23.017 9V15C23.017 18.3137 20.3307 21 17.017 21H14.017ZM1.0166 21L1.0166 18C1.0166 16.8954 1.91203 16 3.0166 16H6.0166C6.56889 16 7.0166 15.5523 7.0166 15V9C7.0166 8.44772 6.56889 8 6.0166 8H2.0166C1.46432 8 1.0166 8.44772 1.0166 9V12C1.0166 12.5523 0.568887 13 0.0166016 13H-1.9834C-2.53569 13 -2.9834 12.5523 -2.9834 12V9C-2.9834 6.79086 -1.19254 5 1.0166 5H6.0166C8.22574 5 10.0166 6.79086 10.0166 9V15C10.0166 18.3137 7.33031 21 4.0166 21H1.0166Z" opacity="0.15" />
                      </svg>
                    </div>
                    <p className="adc__quote-text">{articleData.quote.text}</p>
                    <cite className="adc__quote-author">— {articleData.quote.author}</cite>
                  </div>
                </blockquote>

                {/* Techniques list */}
                <section className="adc__section">
                  <h2 className="adc__sub-title">
                    {lang === 'vi' ? 'Quy Trình 4 Bước Làm Tranh Sơn Mài' : '4-Step Lacquer Painting Process'}
                  </h2>
                  <p>{lang === 'vi'
                    ? 'Mỗi bước trong quy trình đòi hỏi tay nghề cao và sự hiểu biết sâu sắc về vật liệu:'
                    : 'Each step in the process requires high skill and a deep understanding of materials:'}
                  </p>
                  <div className="adc__techniques">
                    {articleData.techniques.map((t, i) => (
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

                {/* Conclusion */}
                <div className="adc__conclusion">
                  <h3 className="adc__conclusion-title">
                    {lang === 'vi' ? 'Kết Luận' : 'Conclusion'}
                  </h3>
                  <p>{articleData.conclusion}</p>
                </div>
              </div>

              {/* Tags & Share card */}
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
                <div className="adc__share">
                  <span className="adc__label">{lang === 'vi' ? 'Chia sẻ:' : 'Share:'}</span>
                  <div className="adc__share-list">
                    <button className="adc-share-btn" aria-label="Facebook">
                      <svg width="18" height="18" viewBox="0 0 24 24" fill="currentColor">
                        <path d="M18 2h-3a5 5 0 0 0-5 5v3H7v4h3v8h4v-8h3l1-4h-4V7a1 1 0 0 1 1-1h3z" />
                      </svg>
                    </button>
                    <button className="adc-share-btn" aria-label="Twitter">
                      <svg width="18" height="18" viewBox="0 0 24 24" fill="currentColor">
                        <path d="M22 4s-.7 2.1-2 3.4c1.6 10-9.4 17.3-18 11.6 2.2.1 4.4-.6 6-2C3 15.5.5 9.6 3 5c2.2 2.6 5.6 4.1 9 4-.9-4.2 4-6.6 7-3.8 1.1 0 3-1.2 3-1.2z" />
                      </svg>
                    </button>
                    <button className="adc-share-btn" aria-label="LinkedIn">
                      <svg width="18" height="18" viewBox="0 0 24 24" fill="currentColor">
                        <path d="M16 8a6 6 0 0 1 6 6v7h-4v-7a2 2 0 0 0-2-2 2 2 0 0 0-2 2v7h-4v-7a6 6 0 0 1 6-6zM2 9h4v12H2z" />
                        <circle cx="4" cy="4" r="2" />
                      </svg>
                    </button>
                    <button className="adc-share-btn" aria-label="Copy link">
                      <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
                        <path d="M10 13a5 5 0 0 0 7.54.54l3-3a5 5 0 0 0-7.07-7.07l-1.72 1.71" />
                        <path d="M14 11a5 5 0 0 0-7.54-.54l-3 3a5 5 0 0 0 7.07 7.07l1.71-1.71" />
                      </svg>
                    </button>
                  </div>
                </div>
              </div>

              {/* Comments */}
              <div className="adc__comments-card fade-up">
                <h3 className="adc__comments-title">
                  <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" style={{ marginRight: '12px' }}>
                    <path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z" />
                  </svg>
                  {lang === 'vi' ? `Bình Luận (${comments.length})` : `Comments (${comments.length})`}
                </h3>

                <div className="adc__comment-list">
                  {comments.map(c => (
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
                    placeholder={lang === 'vi'
                      ? 'Chia sẻ cảm nhận của bạn về bài viết này...'
                      : 'Share your thoughts about this article...'}
                    value={newComment}
                    onChange={e => setNewComment(e.target.value)}
                  />
                  <div className="adc__comment-actions">
                    <button type="submit" className="adc__comment-submit">
                      {lang === 'vi' ? 'Gửi bình luận' : 'Post Comment'}
                    </button>
                  </div>
                </form>
              </div>
            </div>

            {/* ── Sidebar ── */}
            <aside className="adc__sidebar fade-up">
              {/* Author card */}
              <div className="adc-author-card">
                <div className="adc-author-card__top" />
                <div className="adc-author-card__body">
                  <div className="adc-author-card__avatar">{articleData.author.initials}</div>
                  <h3 className="adc-author-card__name">{articleData.author.name}</h3>
                  <p className="adc-author-card__role">{articleData.author.role}</p>
                  <p className="adc-author-card__bio">{articleData.author.bio}</p>

                  <div className="adc-author-card__stats">
                    {[
                      { val: articleData.author.stats.posts, label: lang === 'vi' ? 'Bài viết' : 'Posts' },
                      { val: articleData.author.stats.followers, label: lang === 'vi' ? 'Theo dõi' : 'Followers' },
                      { val: articleData.author.stats.comments, label: lang === 'vi' ? 'Bình luận' : 'Comments' }
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
                      <span>{articleData.author.email}</span>
                    </div>
                    <div className="adc-author-card__contact-item">
                      <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
                        <circle cx="12" cy="12" r="10" />
                        <line x1="2" y1="12" x2="22" y2="12" />
                        <path d="M12 2a15.3 15.3 0 0 1 4 10 15.3 15.3 0 0 1-4 10 15.3 15.3 0 0 1-4-10 15.3 15.3 0 0 1 4-10z" />
                      </svg>
                      <span>{articleData.author.website}</span>
                    </div>
                  </div>

                  <button className="adc-author-card__follow">
                    {lang === 'vi' ? 'Theo dõi tác giả' : 'Follow Author'}
                  </button>
                </div>
              </div>

              {/* Progress stats */}
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

              {/* Related Articles */}
              <div className="adc__related">
                <h3 className="adc__sidebar-title">
                  {lang === 'vi' ? 'Bài Viết Liên Quan' : 'Related Articles'}
                </h3>
                <div className="adc__related-list">
                  {articleData.relatedArticles.map((post, i) => (
                    <Link to="#" key={i} className="adc-related-item">
                      <div className="adc-related-item__img">
                        <img src={post.image} alt={post.title} loading="lazy" />
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
            </aside>
          </div>
        </div>
      </main>

      <Footer lang={lang} />
    </div>
  )
}

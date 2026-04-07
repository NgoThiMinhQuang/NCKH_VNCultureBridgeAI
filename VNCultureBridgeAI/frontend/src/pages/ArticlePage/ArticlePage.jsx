import { useState, useMemo } from 'react'
import { Link } from 'react-router-dom'
import PageHeader from '../../components/layout/PageHeader/PageHeader'
import Footer from '../../components/layout/Footer/Footer'
import './ArticlePage.css'
import heroBg from '../../assets/banner1.jpg'
import img2 from '../../assets/banner2.jpg'
import img3 from '../../assets/banner3.jpg'
import img4 from '../../assets/cham.jpg'
import img5 from '../../assets/dao.jpg'
import img6 from '../../assets/ede.jpg'
import img7 from '../../assets/hmong.jpg'
import img8 from '../../assets/khmer.jpg'
import img9 from '../../assets/muong.jpg'
import img10 from '../../assets/thai.jpg'

export default function ArticlePage() {
    const [lang, setLang] = useState('vi')
    const [activeCategory, setActiveCategory] = useState('all')

    // ── Mock articles list ──────────────────────────────────────────────────
    const allArticles = useMemo(() => [
        {
            code: 'son-mai',
            titleVi: 'Nghệ Thuật Sơn Mài: Tinh Hoa Hội Họa Việt Nam Nghìn Năm',
            titleEn: 'Lacquer Art: A Thousand-Year Pinnacle of Vietnamese Painting',
            categoryVi: 'Nghệ Thuật', categoryEn: 'Fine Arts',
            authorVi: 'Trần Minh Khoa', authorEn: 'Tran Minh Khoa',
            dateVi: '20 Tháng 3, 2026', dateEn: 'March 20, 2026',
            readVi: '10 phút đọc', readEn: '10 min read',
            descVi: 'Khám phá bí mật đằng sau những lớp sơn huyền ảo, nơi vật liệu tự nhiên và bàn tay nghệ nhân tạo nên kiệt tác trường tồn theo thời gian.',
            descEn: 'Discover the secrets behind mysterious lacquer layers, where natural materials and artisan hands create masterpieces that stand the test of time.',
            image: img4,
            featured: true
        },
        {
            code: 'tranh-dong-ho',
            titleVi: 'Tranh Đông Hồ: Nét Dân Gian Trong Từng Bức Khắc',
            titleEn: 'Dong Ho Painting: Folk Art in Every Wood Block',
            categoryVi: 'Hội Họa', categoryEn: 'Painting',
            authorVi: 'Nguyễn Hương Lan', authorEn: 'Nguyen Huong Lan',
            dateVi: '15 Tháng 3, 2026', dateEn: 'March 15, 2026',
            readVi: '7 phút đọc', readEn: '7 min read',
            descVi: 'Từ giấy điệp óng ánh đến màu sắc thiên nhiên, tranh Đông Hồ là lời kể chuyện đời sống làng quê Việt Nam qua những bản khắc gỗ độc đáo.',
            descEn: 'From shimmering do paper to natural colors, Dong Ho paintings narrate Vietnamese village life through unique woodblock prints.',
            image: img5,
            featured: false
        },
        {
            code: 'gom-bat-trang',
            titleVi: 'Gốm Bát Tràng: Di Sản 500 Năm Bên Dòng Sông Hồng',
            titleEn: 'Bat Trang Pottery: 500-Year Heritage on Red River Bank',
            categoryVi: 'Thủ Công', categoryEn: 'Crafts',
            authorVi: 'Phạm Đức Thành', authorEn: 'Pham Duc Thanh',
            dateVi: '10 Tháng 3, 2026', dateEn: 'March 10, 2026',
            readVi: '8 phút đọc', readEn: '8 min read',
            descVi: 'Làng gốm cổ nhất Việt Nam vẫn giữ nguyên bí quyết nung đất sét trắng làm nên những sản phẩm tinh xảo nổi tiếng khắp thế giới.',
            descEn: 'Vietnam\'s oldest pottery village still preserves the secret of firing white clay into exquisitely crafted products famous worldwide.',
            image: img6,
            featured: false
        },
        {
            code: 'lua-ha-dong',
            titleVi: 'Lụa Hà Đông: Tinh Hoa Bền Vững Qua Nghìn Năm',
            titleEn: 'Ha Dong Silk: Enduring Craft Through A Millennium',
            categoryVi: 'Dệt May', categoryEn: 'Textiles',
            authorVi: 'Lê Thị Thu Hà', authorEn: 'Le Thi Thu Ha',
            dateVi: '5 Tháng 3, 2026', dateEn: 'March 5, 2026',
            readVi: '6 phút đọc', readEn: '6 min read',
            descVi: 'Những sợi lụa mỏng manh từ làng Vạn Phúc mang theo cả nghìn năm tri thức dệt lụa, tạo nên vẻ đẹp sang trọng không thể nhầm lẫn.',
            descEn: 'Delicate silk threads from Van Phuc village carry a thousand years of weaving knowledge, creating unmistakably elegant beauty.',
            image: img7,
            featured: false
        },
        {
            code: 'ao-dai',
            titleVi: 'Áo Dài: Linh Hồn Của Người Phụ Nữ Việt Nam',
            titleEn: 'Ao Dai: The Soul of Vietnamese Women',
            categoryVi: 'Trang Phục', categoryEn: 'Costume',
            authorVi: 'Vũ Minh Châu', authorEn: 'Vu Minh Chau',
            dateVi: '28 Tháng 2, 2026', dateEn: 'February 28, 2026',
            readVi: '9 phút đọc', readEn: '9 min read',
            descVi: 'Tà áo dài thanh lịch không chỉ là trang phục truyền thống mà còn là biểu tượng văn hóa, sự duyên dáng và bản sắc riêng của người Việt.',
            descEn: 'The elegant Ao Dai is not merely traditional attire but a cultural symbol of grace and the unique identity of Vietnamese people.',
            image: img8,
            featured: false
        },
        {
            code: 'nha-nhac-cung-dinh',
            titleVi: 'Nhã Nhạc Cung Đình Huế: Di Sản Âm Nhạc UNESCO',
            titleEn: 'Hue Royal Court Music: UNESCO Musical Heritage',
            categoryVi: 'Âm Nhạc', categoryEn: 'Music',
            authorVi: 'Hoàng Văn Bình', authorEn: 'Hoang Van Binh',
            dateVi: '20 Tháng 2, 2026', dateEn: 'February 20, 2026',
            readVi: '11 phút đọc', readEn: '11 min read',
            descVi: 'Những giai điệu trang trọng từ cung đình Huế đã được UNESCO công nhận là di sản văn hóa phi vật thể, mang âm hưởng nghìn năm lịch sử.',
            descEn: 'The solemn melodies from Hue Imperial Palace have been recognized by UNESCO as intangible cultural heritage, resonating with a millennium of history.',
            image: img9,
            featured: false
        },
        {
            code: 'mua-rong-viet',
            titleVi: 'Múa Rối Nước: Nghệ Thuật Độc Đáo Trên Mặt Nước',
            titleEn: 'Water Puppetry: A Unique Art Form on the Water',
            categoryVi: 'Nghệ Thuật', categoryEn: 'Fine Arts',
            authorVi: 'Nguyễn Quang Hải', authorEn: 'Nguyen Quang Hai',
            dateVi: '10 Tháng 2, 2026', dateEn: 'February 10, 2026',
            readVi: '8 phút đọc', readEn: '8 min read',
            descVi: 'Xuất phát từ đồng bằng sông Hồng, múa rối nước là hình thức biểu diễn nghệ thuật truyền thống duy nhất trên thế giới dùng mặt nước làm sân khấu.',
            descEn: 'Originating from the Red River Delta, water puppetry is the world\'s only traditional art form using the water surface as its stage.',
            image: img10,
            featured: false
        },
        {
            code: 'kien-truc-hoi-an',
            titleVi: 'Kiến Trúc Hội An: Giao Thoa Văn Hóa Đông-Tây',
            titleEn: 'Hoi An Architecture: East-West Cultural Fusion',
            categoryVi: 'Kiến Trúc', categoryEn: 'Architecture',
            authorVi: 'Trương Thị Mai', authorEn: 'Truong Thi Mai',
            dateVi: '1 Tháng 2, 2026', dateEn: 'February 1, 2026',
            readVi: '12 phút đọc', readEn: '12 min read',
            descVi: 'Phố cổ Hội An là minh chứng sống động cho sự giao thoa văn hóa Việt-Hoa-Nhật-Pháp, tạo nên một di sản kiến trúc độc đáo không nơi nào có.',
            descEn: 'Hoi An Ancient Town is a vivid testament to the cultural fusion of Vietnamese-Chinese-Japanese-French, creating a unique architectural heritage found nowhere else.',
            image: img2,
            featured: false
        },
    ], [])

    const categories = useMemo(() => {
        const cats = ['all', ...new Set(allArticles.map(a => lang === 'vi' ? a.categoryVi : a.categoryEn))]
        return cats
    }, [lang, allArticles])

    const filtered = useMemo(() => {
        if (activeCategory === 'all') return allArticles
        return allArticles.filter(a => (lang === 'vi' ? a.categoryVi : a.categoryEn) === activeCategory)
    }, [activeCategory, allArticles, lang])

    return (
        <div className="page-shell">
            <PageHeader
                lang={lang}
                onLangChange={setLang}
                breadcrumb={[
                    { label: lang === 'vi' ? 'Bài viết văn hóa' : 'Cultural Articles' },
                ]}
            />

            <main>
                <section className="article-hero">
                    <div className="article-hero__bg" style={{ backgroundImage: `url(${heroBg})` }}></div>
                    <div className="article-hero__overlay"></div>
                    <div className="article-hero__content fade-up">
                        <h1 className="article-hero__title">
                            {lang === 'vi' ? (
                                <>
                                    Nghệ thuật <span className="article-hero__divider"></span> & Di sản Việt Nam
                                </>
                            ) : (
                                <>
                                    Vietnamese Arts <span className="article-hero__divider"></span> & Heritage
                                </>
                            )}
                        </h1>
                        <p className="article-hero__subtitle">
                            {lang === 'vi' ? (
                                <>
                                    Nơi truyền thống cổ xưa hòa quyện cùng biểu đạt hiện đại,<br />
                                    mang theo câu chuyện ngàn năm trong từng nét vẽ
                                </>
                            ) : (
                                <>
                                    Where ancient traditions weave through modern expression,<br />
                                    carrying stories of a thousand years in every brushstroke
                                </>
                            )}
                        </p>
                    </div>
                    <div className="article-hero__scroll">
                        <div className="mouse-icon"></div>
                    </div>
                </section>

                {/* ── Article Listing Section ───────────────────────────── */}
                <section className="ap-articles-section">
                    <div className="section-container">
                        <div className="ap-articles__header fade-up">
                            <h2 className="ap-articles__title">
                                {lang === 'vi' ? 'Bài Viết Văn Hóa' : 'Cultural Articles'}
                            </h2>
                            <p className="ap-articles__subtitle">
                                {lang === 'vi'
                                    ? 'Khám phá kho tri thức phong phú về văn hóa, nghệ thuật và di sản Việt Nam'
                                    : 'Explore a rich treasury of knowledge about Vietnamese culture, arts, and heritage'}
                            </p>
                        </div>

                        {/* Category filter */}
                        <div className="ap-filter fade-up">
                            {categories.map(cat => (
                                <button
                                    key={cat}
                                    className={`ap-filter__btn${activeCategory === cat ? ' active' : ''}`}
                                    onClick={() => setActiveCategory(cat)}
                                >
                                    {cat === 'all' ? (lang === 'vi' ? 'Tất cả' : 'All') : cat}
                                </button>
                            ))}
                        </div>

                        {/* Featured article (first one) */}
                        {filtered[0] && (
                            <Link to={`/articles/${filtered[0].code}`} className="ap-featured-card fade-up">
                                <div className="ap-featured-card__img">
                                    <img src={filtered[0].image} alt={lang === 'vi' ? filtered[0].titleVi : filtered[0].titleEn} />
                                    <span className="ap-featured-card__badge">
                                        {lang === 'vi' ? '✦ Nổi Bật' : '✦ Featured'}
                                    </span>
                                </div>
                                <div className="ap-featured-card__body">
                                    <span className="ap-cat-tag">{lang === 'vi' ? filtered[0].categoryVi : filtered[0].categoryEn}</span>
                                    <h3 className="ap-featured-card__title">
                                        {lang === 'vi' ? filtered[0].titleVi : filtered[0].titleEn}
                                    </h3>
                                    <p className="ap-featured-card__desc">
                                        {lang === 'vi' ? filtered[0].descVi : filtered[0].descEn}
                                    </p>
                                    <div className="ap-featured-card__meta">
                                        <span className="ap-meta-author">
                                            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
                                                <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2" />
                                                <circle cx="12" cy="7" r="4" />
                                            </svg>
                                            {lang === 'vi' ? filtered[0].authorVi : filtered[0].authorEn}
                                        </span>
                                        <span className="ap-meta-dot">·</span>
                                        <span>{lang === 'vi' ? filtered[0].dateVi : filtered[0].dateEn}</span>
                                        <span className="ap-meta-dot">·</span>
                                        <span>
                                            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" style={{marginRight:'4px', verticalAlign:'middle'}}>
                                                <circle cx="12" cy="12" r="10" />
                                                <polyline points="12 6 12 12 16 14" />
                                            </svg>
                                            {lang === 'vi' ? filtered[0].readVi : filtered[0].readEn}
                                        </span>
                                    </div>
                                    <div className="ap-featured-card__cta">
                                        {lang === 'vi' ? 'Đọc bài viết' : 'Read article'}
                                        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
                                            <path d="M5 12h14M12 5l7 7-7 7" />
                                        </svg>
                                    </div>
                                </div>
                            </Link>
                        )}

                        {/* Regular grid */}
                        <div className="ap-grid fade-up">
                            {filtered.slice(1).map((art) => (
                                <Link to={`/articles/${art.code}`} key={art.code} className="ap-card">
                                    <div className="ap-card__img">
                                        <img src={art.image} alt={lang === 'vi' ? art.titleVi : art.titleEn} loading="lazy" />
                                        <span className="ap-cat-tag ap-cat-tag--overlay">
                                            {lang === 'vi' ? art.categoryVi : art.categoryEn}
                                        </span>
                                    </div>
                                    <div className="ap-card__body">
                                        <h3 className="ap-card__title">
                                            {lang === 'vi' ? art.titleVi : art.titleEn}
                                        </h3>
                                        <p className="ap-card__desc">
                                            {lang === 'vi' ? art.descVi : art.descEn}
                                        </p>
                                        <div className="ap-card__footer">
                                            <span className="ap-card__author">{lang === 'vi' ? art.authorVi : art.authorEn}</span>
                                            <span className="ap-card__read">{lang === 'vi' ? art.readVi : art.readEn}</span>
                                        </div>
                                    </div>
                                </Link>
                            ))}
                        </div>
                    </div>
                </section>

                <section className="heritage-categories-section">
                    <div className="section-container">
                        <div className="heritage-categories__header fade-up">
                            <h2 className="heritage-categories__title">
                                {lang === 'vi' ? 'Khám Phá Di Sản' : 'Explore Our Heritage'}
                            </h2>
                            <p className="heritage-categories__subtitle">
                                {lang === 'vi' ? 'Khám phá vẻ đẹp vượt thời gian của tinh hoa thủ công Việt Nam' : 'Discover the timeless beauty of Vietnamese craftsmanship'}
                            </p>
                        </div>

                        <div className="heritage-grid fade-up" style={{ animationDelay: '0.1s' }}>
                            {[
                                { img: heroBg, titleEn: 'Silk Art', titleVi: 'Nghệ Thuật Lụa', sub: 'Lụa Truyền Thống' },
                                { img: img2, titleEn: 'Pottery', titleVi: 'Nghệ Thuật Gốm', sub: 'Gốm Bát Tràng' },
                                { img: img3, titleEn: 'Traditional Painting', titleVi: 'Tranh Dân Gian', sub: 'Tranh Dân Gian' },
                                { img: img4, titleEn: 'Sculpture', titleVi: 'Điêu Khắc', sub: 'Điêu Khắc' }
                            ].map((card, i) => (
                                <div className="heritage-card" key={i}>
                                    <div className="heritage-card__bg" style={{ backgroundImage: `url(${card.img})` }}></div>
                                    <div className="heritage-card__overlay"></div>
                                    <div className="heritage-card__content">
                                        <h3>{lang === 'vi' ? card.titleVi : card.titleEn}</h3>
                                        <span>{card.sub}</span>
                                    </div>
                                </div>
                            ))}
                        </div>
                    </div>
                </section>


                <section className="featured-artwork-section fade-up">
                    <div className="featured-artwork__container">
                        <div className="featured-artwork__image-wrapper">
                            <img src={img4} alt="Sơn Mài Art" className="featured-artwork__image" />
                        </div>
                        <div className="featured-artwork__content">
                            <div className="featured-badge">
                                {lang === 'vi' ? 'TÁC PHẨM NỔI BẬT' : 'FEATURED ARTWORK'}
                            </div>
                            <h2 className="featured-artwork__title">
                                {lang === 'vi' ? 'Nghệ thuật Sơn Mài' : 'The Art of Sơn Mài'}
                            </h2>
                            <div className="featured-artwork__divider"></div>

                            <div className="featured-artwork__body">
                                <p>
                                    {lang === 'vi'
                                        ? 'Nghệ thuật sơn mài Việt Nam là một quá trình chế tác công phu đã được hoàn thiện qua nhiều thế kỷ. Mỗi tác phẩm đòi hỏi nhiều tháng tỉ mỉ sơn từng lớp, với sự khéo léo của nghệ nhân khi phủ lên đến 12 lớp nhựa từ cây sơn.'
                                        : 'Vietnamese lacquer art, known as Sơn Mài, is a painstaking craft that has been perfected over centuries. Each piece requires months of meticulous layering, with artisans applying up to twelve coats of resin derived from the sơn tree.'}
                                </p>
                                <p>
                                    {lang === 'vi'
                                        ? 'Giữa các lớp, bề mặt được chà nhám và đánh bóng cẩn thận, tạo ra độ sâu và độ sáng rực rỡ như phát quang từ bên trong. Các sắc tố tự nhiên cùng vật liệu như vỏ trứng, vàng lá và bạc tạo ra hiệu ứng lấp lánh tinh tế khiến mỗi tác phẩm đều là độc nhất.'
                                        : 'Between each layer, the surface is carefully sanded and polished, creating depth and luminosity that seems to glow from within. Natural pigments and materials like eggshell, gold leaf, and silver create the distinctive shimmer that makes each piece unique.'}
                                </p>
                            </div>

                            <div className="featured-stats">
                                <div className="featured-stat">
                                    <strong>12+</strong>
                                    <span>{lang === 'vi' ? 'Lớp sơn mài' : 'Layers of lacquer'}</span>
                                </div>
                                <div className="featured-stat">
                                    <strong>3-6</strong>
                                    <span>{lang === 'vi' ? 'Tháng hoàn thiện' : 'Months to complete'}</span>
                                </div>
                                <div className="featured-stat">
                                    <strong>100+</strong>
                                    <span>{lang === 'vi' ? 'Năm truyền thống' : 'Years of tradition'}</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>

                <section className="article-gallery-section fade-up">
                    <div className="section-container">
                        <div className="article-gallery__header">
                            <h2 className="article-gallery__title">
                                {lang === 'vi' ? 'Thư Viện Ảnh' : 'Our Gallery'}
                            </h2>
                            <p className="article-gallery__subtitle">
                                {lang === 'vi' ? 'Hành trình thị giác qua di sản nghệ thuật Việt Nam' : 'A visual journey through Vietnam\'s artistic legacy'}
                            </p>
                        </div>

                        <div className="article-gallery__grid">
                            <div className="gallery-col">
                                <div className="gallery-item"><img src={img5} alt="Vietnam Culture" loading="lazy" /></div>
                                <div className="gallery-item"><img src={img6} alt="Vietnam Culture" loading="lazy" /></div>
                            </div>
                            <div className="gallery-col">
                                <div className="gallery-item"><img src={img7} alt="Vietnam Culture" loading="lazy" /></div>
                                <div className="gallery-item"><img src={img8} alt="Vietnam Culture" loading="lazy" /></div>
                            </div>
                            <div className="gallery-col">
                                <div className="gallery-item"><img src={img9} alt="Vietnam Culture" loading="lazy" /></div>
                                <div className="gallery-item"><img src={img10} alt="Vietnam Culture" loading="lazy" /></div>
                            </div>
                        </div>
                    </div>
                </section>
                <section className="article-story-section fade-up">
                    <div className="article-story__container">
                        <div className="article-story__content">
                            <div className="featured-badge">
                                {lang === 'vi' ? 'CÂU CHUYỆN CỦA CHÚNG TÔI' : 'OUR STORY'}
                            </div>
                            <h2 className="article-story__title">
                                {lang === 'vi' ? 'Sợi Chỉ Thời Gian, Dệt Bằng Tâm Hồn' : 'Threads of Time, Woven with Soul'}
                            </h2>
                            <div className="featured-artwork__divider"></div>

                            <div className="article-story__body">
                                <p>
                                    {lang === 'vi'
                                        ? 'Trong hơn một thiên niên kỷ, các nghệ nhân Việt Nam đã gìn giữ và nâng tầm nghề thủ công của mình, truyền lại các kỹ thuật qua nhiều thế hệ như những di vật quý giá. Từ những dải lụa tinh xảo của Hà Đông đến vẻ đẹp mộc mạc của gốm sứ Bát Tràng, mỗi truyền thống đều mang trong mình linh hồn của đất nước.'
                                        : 'For over a millennium, Vietnamese artisans have preserved and elevated their crafts, passing down techniques through generations like precious heirlooms. From the delicate silks of Hà Đông to the earthen beauty of Bat Trang ceramics, each tradition carries the soul of the land.'}
                                </p>
                                <p>
                                    {lang === 'vi'
                                        ? 'Những bản khắc gỗ Đông Hồ rực rỡ kể những câu chuyện về sự thịnh vượng và may mắn, trong khi chiều sâu lung linh của các bức tranh sơn mài ghi lại những khoảnh khắc đóng băng trong thời gian. Những môn nghệ thuật này không chỉ đơn thuần là trang trí - chúng là chứng nhân sống động cho sự kiên cường, sáng tạo và tinh thần bền bỉ của Việt Nam.'
                                        : 'The vibrant Đông Hồ woodblock prints tell stories of prosperity and luck, while the shimmering depths of lacquer paintings capture moments frozen in time. These arts are not merely decorative—they are living testimonies to resilience, creativity, and the enduring spirit of Vietnam.'}
                                </p>
                            </div>

                            <div className="article-story__features">
                                <div className="story-feature">
                                    <div className="story-feature__icon" style={{ backgroundColor: '#b91c1c' }}></div>
                                    <div className="story-feature__text">
                                        <strong>{lang === 'vi' ? 'Bảo tồn di sản' : 'Heritage Preservation'}</strong>
                                        <span>{lang === 'vi' ? 'Bảo vệ các kỹ thuật cổ xưa cho thế hệ tương lai' : 'Protecting ancient techniques for future generations'}</span>
                                    </div>
                                </div>
                                <div className="story-feature">
                                    <div className="story-feature__icon" style={{ backgroundColor: '#f59e0b' }}></div>
                                    <div className="story-feature__text">
                                        <strong>{lang === 'vi' ? 'Biểu đạt đương đại' : 'Contemporary Expression'}</strong>
                                        <span>{lang === 'vi' ? 'Kết hợp truyền thống với tầm nhìn nghệ thuật hiện đại' : 'Blending tradition with modern artistic vision'}</span>
                                    </div>
                                </div>
                                <div className="story-feature">
                                    <div className="story-feature__icon" style={{ backgroundColor: '#10b981' }}></div>
                                    <div className="story-feature__text">
                                        <strong>{lang === 'vi' ? 'Kết nối văn hóa' : 'Cultural Connection'}</strong>
                                        <span>{lang === 'vi' ? 'Chia sẻ di sản nghệ thuật của Việt Nam với thế giới' : 'Sharing Vietnam\'s artistic legacy with the world'}</span>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div className="article-story__images">
                            <div className="story-images-grid">
                                <div className="story-img-col">
                                    <div className="story-img-item"><img src={img3} alt="Heritage" /></div>
                                    <div className="story-img-item"><img src={img6} alt="Heritage" /></div>
                                </div>
                                <div className="story-img-col">
                                    <div className="story-img-item tall"><img src={img2} alt="Heritage" /></div>
                                    <div className="story-img-item"><img src={img5} alt="Heritage" /></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>


            </main>

            <Footer lang={lang} />
        </div>
    )
}

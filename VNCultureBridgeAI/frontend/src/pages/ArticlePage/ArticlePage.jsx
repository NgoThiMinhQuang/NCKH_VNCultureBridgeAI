import { useState, useEffect } from 'react'
import { searchArticles } from '../../services/content.service'
import LoadingState from '../../components/common/LoadingState/LoadingState'
import PageHeader from '../../components/layout/PageHeader/PageHeader'
import Footer from '../../components/layout/Footer/Footer'
import CardGrid from '../../components/common/CardGrid/CardGrid'
import SectionHeading from '../../components/common/SectionHeading/SectionHeading'
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
    const [status, setStatus] = useState('loading')
    const [articles, setArticles] = useState([])
    const [error, setError] = useState(null)

    useEffect(() => {
        let ignore = false;
        setStatus('loading')
        searchArticles({ lang, limit: 12 })
            .then(data => {
                if (!ignore) {
                    setArticles(data)
                    setStatus('success')
                }
            })
            .catch(err => {
                if (!ignore) {
                    setError(err.message)
                    setStatus('error')
                }
            })
        return () => { ignore = true }
    }, [lang])

    if (status === 'loading') return <LoadingState message={lang === 'vi' ? 'Đang tải bài viết...' : 'Loading articles...'} />
    if (status === 'error') return <LoadingState type="error" message={error} />

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

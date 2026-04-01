import PageHeader from "../../components/layout/PageHeader/PageHeader";
import Footer from "../../components/layout/Footer/Footer";
import { useEffect, useMemo, useState } from 'react'
import { Link } from 'react-router-dom'
import { ui } from '../../i18n/messages'
import bannerImg from '../../assets/festival_banner.jpg'
import banner1Img from '../../assets/banner1.jpg'
import "./FestivalsPage.css"

export default function FestivalsPage() {
    const [lang, setLang] = useState('vi');
    const copy = useMemo(() => ui[lang], [lang])


    return (
        <>
            {/* Header */}
            <PageHeader
                lang={lang}
                onLangChange={setLang}
                renderNav={() => (
                    <nav className="ph__nav" aria-label="Main navigation">
                        <Link to="/" className="ph__nav-link">{copy.nav[0]}</Link>
                        {/* Link trang vùng miền thay vì mega-menu */}
                        <Link to="/regions" className="ph__nav-link">{copy.nav[1]}</Link>
                        <Link to="/ethnic-groups" className="ph__nav-link">{copy.nav[2]}</Link>
                        <Link to="/festivals" className="ph__nav-link">{copy.nav[3]}</Link>
                        <Link to="/cuisine" className="ph__nav-link">{copy.nav[4]}</Link>
                        <Link to="/articles" className="ph__nav-link">{copy.nav[5]}</Link>
                        <Link to="/blog" className="ph__nav-link">{copy.nav[6]}</Link>
                    </nav>
                )} />


            <main className="festivals-main">
                {/* festival hero */}
                <section className="festivals-hero" style={{ backgroundImage: `url(${bannerImg})` }}>
                    <div className="festivals-hero__overlay"></div>
                    <div className="festivals-hero__content">
                        <h1 className="festivals-hero__title">Vietnamese<br />Festivals</h1>
                        <p className="festivals-hero__subtitle">
                            Experience the vibrant traditions of Vietnam through<br />
                            celebrations that have endured for centuries
                        </p>
                        <div className="festivals-hero__actions">
                            <a href="#explore" className="festivals-btn festivals-btn--primary">Explore Festivals</a>
                            <Link to="/ai-guide" className="festivals-btn festivals-btn--secondary">Ask AI Guide</Link>
                        </div>
                    </div>
                </section>

                {/* --- Major Festivals Section --- */}
                <section className="festivals-major" id="explore">
                    <div className="festivals-major__container">
                        <div className="festivals-major__header fade-up">
                            <div className="festivals-major__badge">
                                <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.5" strokeLinecap="round" strokeLinejoin="round">
                                    <path d="M12 2l2.4 7.6 7.6 2.4-7.6 2.4L12 22l-2.4-7.6L2 12l7.6-2.4L12 2z" />
                                </svg>
                                FEATURED CELEBRATIONS
                            </div>
                            <h2 className="festivals-major__title">Major Festivals</h2>
                            <p className="festivals-major__subtitle">Discover Vietnam's most important cultural celebrations</p>
                        </div>

                        <div className="festivals-major__grid">
                            {/* Card 1 */}
                            <article className="festivals-card fade-up">
                                <div className="festivals-card__media">
                                    <img src={banner1Img} alt="Lunar New Year" loading="lazy" />
                                    <span className="festivals-card__tag">Major</span>
                                </div>
                                <div className="festivals-card__body">
                                    <h3>Tết Nguyên Đán (Lunar New Year)</h3>
                                    <p>The most important celebration in Vietnamese culture, marking the arrival of spring based on the Lunar calendar. It's a time for family reunions, traditional foods, and vibrant festivals.</p>
                                </div>
                            </article>

                            {/* Card 2 */}
                            <article className="festivals-card fade-up" style={{ animationDelay: "0.1s" }}>
                                <div className="festivals-card__media">
                                    <img src={bannerImg} alt="Mid-Autumn Festival" loading="lazy" />
                                    <span className="festivals-card__tag text-purple">Cultural</span>
                                </div>
                                <div className="festivals-card__body">
                                    <h3>Tết Trung Thu (Mid-Autumn Festival)</h3>
                                    <p>A joyous occasion celebrated under the full moon, featuring colorful lanterns, mooncakes, and lion dances. Families gather to admire the moon and celebrate the harvest.</p>
                                </div>
                            </article>
                        </div>
                    </div>
                </section>

                {/* Scroll to Top button */}
                <button
                    className="festivals-scroll-top"
                    onClick={() => window.scrollTo({ top: 0, behavior: 'smooth' })}
                    aria-label="Scroll to top"
                >
                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.5" strokeLinecap="round" strokeLinejoin="round">
                        <path d="m18 15-6-6-6 6" />
                    </svg>
                </button>
            </main>

            {/* Footer */}
            <Footer />
        </>
    )
}

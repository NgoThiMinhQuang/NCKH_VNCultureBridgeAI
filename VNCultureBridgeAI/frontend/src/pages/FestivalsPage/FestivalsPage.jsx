import PageHeader from "../../components/layout/PageHeader/PageHeader";
import Footer from "../../components/layout/Footer/Footer";
import { useEffect, useMemo, useState } from 'react'
import { Link } from 'react-router-dom'
import { ui } from '../../i18n/messages'
import bannerImg from '../../assets/festival_banner.jpg'
import banner1Img from '../../assets/banner1.jpg'
import banner2Img from '../../assets/banner2.jpg'
import banner3Img from '../../assets/banner3.jpg'
import anhtet1 from '../../assets/anhtet1.PNG'
import giotohungvuong from "../../assets/giotohungvuong1.PNG"
import festivel_hue from "../../assets/festival_hue.png"
import "./FestivalsPage.css"
import "../../App.css"

const ALL_FESTIVALS = [
    {
        id: 1,
        title: "Tết Nguyên Đán",
        enTitle: "Lunar New Year",
        desc: "The most important celebration in Vietnamese culture, marking the arrival of spring and the beginning of a new year.",
        location: "Nationwide",
        date: "January/February",
        tag: "Major",
        tagColor: "#ce112d",
        image: banner1Img,
    },
    {
        id: 2,
        title: "Tết Trung Thu",
        enTitle: "Mid-Autumn Festival",
        desc: "A magical celebration for children featuring lanterns, mooncakes, and lion dances under the full harvest moon.",
        location: "Nationwide",
        date: "September",
        tag: "Major",
        tagColor: "#ce112d",
        image: bannerImg,
    },
    {
        id: 3,
        title: "Hội An Lantern Festival",
        enTitle: "Hoi An Lantern Festival",
        desc: "Monthly full moon celebration where ancient town transforms into an enchanting sea of colorful lanterns.",
        location: "Central",
        date: "Monthly",
        tag: "Cultural",
        tagColor: "#ce112d",
        image: banner1Img,
    },
    {
        id: 4,
        title: "Lễ Hội Hoa Ban",
        enTitle: "Ban Flower Festival",
        desc: "Northwestern highlands celebration welcoming spring with white Ban flowers blooming across the mountains.",
        location: "North",
        date: "March",
        tag: "Ethnic",
        tagColor: "#e11d48",
        image: null,
    },
    {
        id: 5,
        title: "Kate Festival",
        enTitle: "Kate Festival",
        desc: "Sacred Cham festival honoring ancestors and deities with vibrant processions and traditional tower ceremonies.",
        location: "Central",
        date: "October",
        tag: "Ethnic",
        tagColor: "#e11d48",
        image: null,
    },
    {
        id: 6,
        title: "Gầu Tào Festival",
        enTitle: "Gau Tao Festival",
        desc: "Hmong spiritual festival praying for good harvests and community prosperity in the highlands.",
        location: "North",
        date: "January",
        tag: "Religious",
        tagColor: "#ce112d",
        image: null,
    },
    {
        id: 7,
        title: "Lễ Hội Đền Hùng",
        enTitle: "Hung Kings Temple Festival",
        desc: "National commemoration honoring legendary founders of Vietnam and celebrating national identity.",
        location: "Nationwide",
        date: "April",
        tag: "Major",
        tagColor: "#ce112d",
        image: null,
    },
    {
        id: 8,
        title: "Lễ Hội Chùa Hương",
        enTitle: "Perfume Pagoda Festival",
        desc: "Buddhist pilgrimage to sacred cave temples in the Huong Tich mountains, attracting millions.",
        location: "North",
        date: "February",
        tag: "Religious",
        tagColor: "#ce112d",
        image: null,
    },
    {
        id: 9,
        title: "Lễ Hội Cầu Ngư",
        enTitle: "Fishermen Festival",
        desc: "Coastal celebration where fishing communities pray for safety and bountiful catches.",
        location: "South",
        date: "April",
        tag: "Cultural",
        tagColor: "#ce112d",
        image: null,
    },
    {
        id: 10,
        title: "Nghinh Ông Festival",
        enTitle: "Whale Worshipping Festival",
        desc: "Southern coastal festival honoring whales as sacred protectors of fishermen.",
        location: "South",
        date: "December",
        tag: "Religious",
        tagColor: "#ce112d",
        image: bannerImg,
    }
];

const TIMELINE_DATA = [
    { id: 1, month: "January", title: "Tết Nguyên Đán", season: "Spring", color: "#e11d48", image: banner1Img },
    { id: 2, month: "February", title: "Lim Festival", season: "Spring", color: "#eab308", image: bannerImg },
    { id: 3, month: "March", title: "Perfume Pagoda", season: "Spring", color: "#8b5cf6", image: banner1Img },
    { id: 4, month: "April", title: "Hùng Kings Temple", season: "Spring", color: "#ea580c", image: bannerImg },
    { id: 5, month: "May", title: "Ba Chúa Xứ", season: "Summer", color: "#10b981", image: banner1Img },
    { id: 6, month: "June", title: "Đoan Ngọ", season: "Summer", color: "#14b8a6", image: bannerImg },
    { id: 7, month: "July", title: "Vu Lan", season: "Autumn", color: "#06b6d4", image: banner1Img },
    { id: 8, month: "August", title: "Hội An Lantern", season: "Autumn", color: "#f43f5e", image: bannerImg },
    { id: 9, month: "September", title: "Mid-Autumn", season: "Autumn", color: "#d946ef", image: banner1Img },
    { id: 10, month: "October", title: "Kate Festival", season: "Autumn", color: "#f59e0b", image: bannerImg },
    { id: 11, month: "November", title: "Ok Om Bok", season: "Winter", color: "#3b82f6", image: banner1Img },
    { id: 12, month: "December", title: "Nghinh Ông", season: "Winter", color: "#6366f1", image: bannerImg }
];

export default function FestivalsPage() {
    const [lang, setLang] = useState('vi');
    const [isFiltersOpen, setIsFiltersOpen] = useState(false);
    const copy = useMemo(() => ui[lang], [lang])

    return (
        <>
            {/* Header */}
            <PageHeader
                lang={lang}
                onLangChange={setLang}
            />


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

                {/* --- Search & Filter Section --- */}
                <section className="festivals-search-section">
                    <div className="festivals-search-container">
                        <div className="festivals-search-row">
                            <div className="festivals-search-bar">
                                <svg className="search-icon" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="#ce112d" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                                    <circle cx="11" cy="11" r="8"></circle>
                                    <line x1="21" y1="21" x2="16.65" y2="16.65"></line>
                                </svg>
                                <input
                                    type="text"
                                    placeholder="Discover festivals, traditions, and cultures..."
                                    className="festivals-search-input"
                                />
                            </div>
                            <button
                                className={`festivals-filter-btn ${isFiltersOpen ? 'active' : ''}`}
                                onClick={() => setIsFiltersOpen(!isFiltersOpen)}
                            >
                                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="#ce112d" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                                    <polygon points="22 3 2 3 10 12.46 10 19 14 21 14 12.46 22 3"></polygon>
                                </svg>
                                <span>Advanced Filters</span>
                                <svg
                                    width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#ce112d" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"
                                    style={{ transform: isFiltersOpen ? 'rotate(180deg)' : 'none', transition: 'transform 0.3s ease' }}
                                >
                                    <polyline points="6 9 12 15 18 9"></polyline>
                                </svg>
                            </button>
                        </div>

                        {/* Expandable Filters Grid */}
                        <div className={`festivals-filters-grid ${isFiltersOpen ? 'open' : ''}`}>
                            {/* Region Filter */}
                            <div className="festivals-filter-item">
                                <span className="festivals-filter-icon">📍</span>
                                <select className="festivals-filter-select">
                                    <option value="">All Regions</option>
                                    <option value="north">North Vietnam</option>
                                    <option value="central">Central Vietnam</option>
                                    <option value="south">South Vietnam</option>
                                </select>
                                <svg className="festivals-filter-chevron" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#ce112d" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><polyline points="6 9 12 15 18 9"></polyline></svg>
                            </div>

                            {/* Month Filter */}
                            <div className="festivals-filter-item">
                                <span className="festivals-filter-icon">🗓️</span>
                                <select className="festivals-filter-select">
                                    <option value="">All Months</option>
                                    <option value="1">January</option>
                                    <option value="2">February</option>
                                    <option value="3">March</option>
                                    <option value="4">April</option>
                                    <option value="5">May</option>
                                </select>
                                <svg className="festivals-filter-chevron" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#ce112d" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><polyline points="6 9 12 15 18 9"></polyline></svg>
                            </div>

                            {/* Category Filter */}
                            <div className="festivals-filter-item">
                                <span className="festivals-filter-icon">🎭</span>
                                <select className="festivals-filter-select">
                                    <option value="">All Categories</option>
                                    <option value="traditional">Traditional</option>
                                    <option value="religious">Religious</option>
                                    <option value="historical">Historical</option>
                                </select>
                                <svg className="festivals-filter-chevron" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#ce112d" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><polyline points="6 9 12 15 18 9"></polyline></svg>
                            </div>

                            {/* Ethnic Group Filter */}
                            <div className="festivals-filter-item">
                                <span className="festivals-filter-icon">👥</span>
                                <select className="festivals-filter-select">
                                    <option value="">All Ethnic Groups</option>
                                    <option value="kinh">Kinh</option>
                                    <option value="tay">Tay</option>
                                    <option value="thai">Thai</option>
                                    <option value="muong">Muong</option>
                                </select>
                                <svg className="festivals-filter-chevron" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#ce112d" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><polyline points="6 9 12 15 18 9"></polyline></svg>
                            </div>
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
                                {/* ảnh */}
                                <div className="festivals-card__img">
                                    <img src={anhtet1} alt="Lunar New Year" loading="lazy" />
                                    <span className="festivals-card__tag">Major</span>
                                </div>
                                {/* body */}
                                <div className="festivals-card__body">
                                    <div className="festivals-card__times">
                                        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect><line x1="16" y1="2" x2="16" y2="6"></line><line x1="8" y1="2" x2="8" y2="6"></line><line x1="3" y1="10" x2="21" y2="10"></line></svg>
                                        February
                                    </div>
                                    {/* content */}
                                    <div className="festival-card__content">
                                        <h3 className="festivals-card__title">Lunar New Year</h3>
                                        <span className="festivals-card__en-title">Traditional Vietnamese Tet</span>
                                        <p className="festivals-card__desc">The most significant festival in Vietnam. Families reunite to honor ancestors, enjoy traditional dishes like Banh Chung, and exchange best wishes for a prosperous New Year.</p>
                                        <div className="festivals-card__meta">
                                            <div className="festivals-card__meta-item">
                                                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z"></path><circle cx="12" cy="10" r="3"></circle></svg>
                                                Nationwide
                                            </div>
                                            <div className="festivals-card__meta-item">
                                                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"></path><circle cx="9" cy="7" r="4"></circle><path d="M23 21v-2a4 4 0 0 0-3-3.87"></path><path d="M16 3.13a4 4 0 0 1 0 7.75"></path></svg>
                                                All Vietnamese People
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </article>

                            {/* Card 2 */}
                            <article className="festivals-card fade-up" style={{ animationDelay: "0.1s" }}>
                                {/* ảnh */}
                                <div className="festivals-card__img">
                                    <img src={giotohungvuong} alt="Mid-Autumn Festival" loading="lazy" />
                                    <span className="festivals-card__tag text-purple">Cultural</span>
                                </div>
                                {/* body */}
                                <div className="festivals-card__body">
                                    <div className="festivals-card__times">
                                        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect><line x1="16" y1="2" x2="16" y2="6"></line><line x1="8" y1="2" x2="8" y2="6"></line><line x1="3" y1="10" x2="21" y2="10"></line></svg>
                                        The 10th day of the 3rd lunar month
                                    </div>
                                    {/* content */}
                                    <div className="festival-card__content">
                                        <h3 className="festivals-card__title">Hung Kings' Temple Festival</h3>
                                        <span className="festivals-card__en-title">Ancestors' Memorial Day</span>
                                        <p className="festivals-card__desc">A profound national pilgrimage honoring the Hung Kings, the legendary founding fathers of Vietnam. This sacred event unites millions in a display of solemn rituals, vibrant processions, and traditional folk games, all echoing a deep sense of gratitude and enduring national pride</p>
                                        <div className="festivals-card__meta">
                                            <div className="festivals-card__meta-item">
                                                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z"></path><circle cx="12" cy="10" r="3"></circle></svg>
                                                Phu Tho Province
                                            </div>
                                            <div className="festivals-card__meta-item">
                                                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"></path><circle cx="9" cy="7" r="4"></circle><path d="M23 21v-2a4 4 0 0 0-3-3.87"></path><path d="M16 3.13a4 4 0 0 1 0 7.75"></path></svg>
                                                Kinh & Others
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </article>

                            {/* Card 3 */}
                            <article className="festivals-card fade-up" style={{ animationDelay: "0.1s" }}>
                                {/* ảnh */}
                                <div className="festivals-card__img">
                                    <img src={festivel_hue} alt="Mid-Autumn Festival" loading="lazy" />
                                    <span className="festivals-card__tag text-purple">Cultural</span>
                                </div>
                                {/* body */}
                                <div className="festivals-card__body">
                                    <div className="festivals-card__times">
                                        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect><line x1="16" y1="2" x2="16" y2="6"></line><line x1="8" y1="2" x2="8" y2="6"></line><line x1="3" y1="10" x2="21" y2="10"></line></svg>
                                        Every 2 years, April to June
                                    </div>
                                    {/* content */}
                                    <div className="festival-card__content">
                                        <h3 className="festivals-card__title">Hue Festival</h3>
                                        <span className="festivals-card__en-title">Imperial Cultural Celebration</span>
                                        <p className="festivals-card__desc">Experience the royal grandeur of Vietnam’s former imperial capital. This world-class cultural event brings history to life through majestic re-enactments of court ceremonies, traditional arts, and vibrant street performances that celebrate the soul of Hue's heritage</p>
                                        <div className="festivals-card__meta">
                                            <div className="festivals-card__meta-item">
                                                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z"></path><circle cx="12" cy="10" r="3"></circle></svg>
                                                Hue City, Thua Thien Hue
                                            </div>
                                            <div className="festivals-card__meta-item">
                                                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"></path><circle cx="9" cy="7" r="4"></circle><path d="M23 21v-2a4 4 0 0 0-3-3.87"></path><path d="M16 3.13a4 4 0 0 1 0 7.75"></path></svg>
                                                All Communities
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </article>
                        </div>
                    </div>
                </section>

                {/* --- Cultural Meaning Section --- */}
                <section className="festivals-meaning">
                    <div className="festivals-meaning__container">
                        <div className="festivals-meaning__gallery">
                            <div className="gallery-col">
                                <img src={bannerImg} alt="Lanterns" className="img-tall fade-up" />
                                <img src={banner1Img} alt="Portrait" className="img-square fade-up" style={{ animationDelay: "0.1s" }} />
                                <div className="gallery-placeholder img-square fade-up" style={{ animationDelay: "0.2s" }}>
                                    <svg width="60" height="60" viewBox="0 0 24 24" fill="none" stroke="#a1a1aa" strokeWidth="1"><rect x="3" y="3" width="18" height="18" rx="2" ry="2"></rect><circle cx="8.5" cy="8.5" r="1.5"></circle><polyline points="21 15 16 10 5 21"></polyline></svg>
                                </div>
                            </div>
                            <div className="gallery-col gallery-col--offset">
                                <div className="gallery-placeholder img-square fade-up" style={{ animationDelay: "0.3s" }}>
                                    <svg width="60" height="60" viewBox="0 0 24 24" fill="none" stroke="#a1a1aa" strokeWidth="1"><rect x="3" y="3" width="18" height="18" rx="2" ry="2"></rect><circle cx="8.5" cy="8.5" r="1.5"></circle><polyline points="21 15 16 10 5 21"></polyline></svg>
                                </div>
                                <div className="gallery-placeholder img-square fade-up" style={{ animationDelay: "0.4s" }}>
                                    <svg width="60" height="60" viewBox="0 0 24 24" fill="none" stroke="#a1a1aa" strokeWidth="1"><rect x="3" y="3" width="18" height="18" rx="2" ry="2"></rect><circle cx="8.5" cy="8.5" r="1.5"></circle><polyline points="21 15 16 10 5 21"></polyline></svg>
                                </div>
                                <img src={bannerImg} alt="Beach" className="img-landscape fade-up" style={{ animationDelay: "0.5s" }} />
                            </div>
                        </div>

                        <div className="festivals-meaning__content fade-up">
                            <div className="festivals-meaning__tag">
                                <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.5" strokeLinecap="round" strokeLinejoin="round"><path d="M12 2l2.4 7.6 7.6 2.4-7.6 2.4L12 22l-2.4-7.6L2 12l7.6-2.4L12 2z" /></svg>
                                CULTURAL MEANING
                            </div>
                            <h2 className="festivals-meaning__title">The Soul of<br />Vietnamese<br />Festivals</h2>

                            <div className="festivals-meaning__desc">
                                <p>Vietnamese festivals are more than celebrations—they are living connections to our ancestors, our land, and our collective spirit. Each festival carries centuries of wisdom, tradition, and cultural identity.</p>
                                <p>From the red envelopes of Tết symbolizing good fortune to the glowing lanterns of Trung Thu representing hope and reunion, every ritual holds deep meaning. These celebrations unite communities, honor heritage, and pass timeless values to future generations.</p>
                                <p>Whether you're witnessing the spectacle of dragon dances, savoring traditional foods, or participating in ancient ceremonies, you're not just observing—you're experiencing the heartbeat of Vietnam.</p>
                            </div>

                            <button className="festivals-btn festivals-btn--primary festivals-meaning__btn">Learn More About Our Culture</button>
                        </div>
                    </div>
                </section>

                {/* --- All Celebrations Section --- */}
                <section className="festivals-all" id="all-celebrations">
                    <div className="festivals-all__header fade-up">
                        <h2 className="festivals-all__title">Explore Vietnamese Festivals</h2>
                        <p className="festivals-all__subtitle">Discover unique cultural celebrations across Vietnam</p>
                    </div>

                    <div className="festivals-all__grid">
                        {ALL_FESTIVALS.map((fest, index) => {
                            if (index === 0) {
                                return (
                                    <article className="festival-featured-card fade-up" key={fest.id}>
                                        <div className="festival-featured-card__bg" style={{ backgroundImage: `url(${fest.image || bannerImg})` }}></div>
                                        <div className="festival-featured-card__overlay"></div>

                                        <div className="festival-featured-card__content">
                                            <div className="festival-tags">
                                                <span className="festival-tag festival-tag--featured">
                                                    <svg width="14" height="14" viewBox="0 0 24 24" fill="currentColor" stroke="none"><polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2"></polygon></svg>
                                                    FEATURED
                                                </span>
                                                <span className="festival-tag festival-tag--category">{fest.tag}</span>
                                            </div>

                                            <h3 className="festival-featured-card__title">{fest.title}</h3>
                                            <p className="festival-featured-card__en-title">{fest.enTitle}</p>

                                            <div className="festival-meta-group">
                                                <div className="festival-meta-item">
                                                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z"></path><circle cx="12" cy="10" r="3"></circle></svg>
                                                    {fest.location}
                                                </div>
                                                <div className="festival-meta-item">
                                                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect><line x1="16" y1="2" x2="16" y2="6"></line><line x1="8" y1="2" x2="8" y2="6"></line><line x1="3" y1="10" x2="21" y2="10"></line></svg>
                                                    {fest.date}
                                                </div>
                                            </div>

                                            <p className="festival-featured-card__desc">{fest.desc}</p>

                                            <button className="festival-btn-explore">
                                                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><circle cx="12" cy="12" r="10"></circle><polygon points="10 8 16 12 10 16 10 8"></polygon></svg>
                                                Explore Now
                                                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><polyline points="9 18 15 12 9 6"></polyline></svg>
                                            </button>
                                        </div>
                                    </article>
                                );
                            }

                            return (
                                <article className="festival-regular-card fade-up" style={{ animationDelay: `${(index % 3) * 0.1}s` }} key={fest.id}>
                                    <div className="festival-regular-card__img-wrapper">
                                        {fest.image ? (
                                            <img src={fest.image} alt={fest.title} loading="lazy" />
                                        ) : (
                                            <div className="festival-regular-card__img-placeholder">
                                                <svg width="48" height="48" viewBox="0 0 24 24" fill="none" stroke="#4a3020" strokeWidth="1.5"><rect x="3" y="3" width="18" height="18" rx="2" ry="2"></rect><circle cx="8.5" cy="8.5" r="1.5"></circle><polyline points="21 15 16 10 5 21"></polyline></svg>
                                            </div>
                                        )}
                                        <span className="festival-regular-card__tag">{fest.tag}</span>
                                    </div>
                                    <div className="festival-regular-card__content">
                                        <h3 className="festival-regular-card__title">{fest.title}</h3>
                                        <p className="festival-regular-card__en-title">{fest.enTitle}</p>

                                        <div className="festival-meta-group">
                                            <div className="festival-meta-item">
                                                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z"></path><circle cx="12" cy="10" r="3"></circle></svg>
                                                {fest.location}
                                            </div>
                                            <div className="festival-meta-item">
                                                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect><line x1="16" y1="2" x2="16" y2="6"></line><line x1="8" y1="2" x2="8" y2="6"></line><line x1="3" y1="10" x2="21" y2="10"></line></svg>
                                                {fest.date}
                                            </div>
                                        </div>

                                        <p className="festival-regular-card__desc">{fest.desc}</p>

                                        <button className="festival-btn-discover">
                                            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2"></polygon></svg>
                                            Discover Story
                                            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" style={{ marginLeft: '4px' }}><polyline points="9 18 15 12 9 6"></polyline></svg>
                                        </button>
                                    </div>
                                </article>
                            );
                        })}
                    </div>

                    {/* View More Button */}
                    <div className="festivals-all__actions">
                        <button className="festivals-btn festivals-btn--primary">View More</button>
                    </div>
                </section>

                {/* --- Festival Timeline Section --- */}
                <section className="festivals-timeline">
                    <div className="festivals-timeline__header fade-up">
                        <div className="festivals-timeline__tag">YEAR-ROUND CELEBRATIONS</div>
                        <h2 className="festivals-timeline__title">Festival Timeline</h2>
                        <p className="festivals-timeline__subtitle">Experience the rhythm of Vietnamese culture throughout the year</p>
                        <div className="festivals-timeline__scroll-hint">Scroll horizontally →</div>
                    </div>

                    <div className="festivals-timeline__track-container fade-up">
                        <div className="festivals-timeline__track">
                            <div className="festivals-timeline__line"></div>
                            {TIMELINE_DATA.map((item, index) => (
                                <div className="timeline-item" key={item.id} style={{ animationDelay: `${index * 0.1}s` }}>
                                    <div className="timeline-item__top-dot" style={{ backgroundColor: item.color, boxShadow: `0 0 10px ${item.color}` }}></div>
                                    <div className="timeline-item__circle" style={{
                                        border: `2px solid ${item.color}`,
                                        boxShadow: `0 0 30px ${item.color}40, inset 0 0 20px ${item.color}20`
                                    }}>
                                        <svg width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect><line x1="16" y1="2" x2="16" y2="6"></line><line x1="8" y1="2" x2="8" y2="6"></line><line x1="3" y1="10" x2="21" y2="10"></line></svg>
                                        <span>{item.month}</span>
                                    </div>
                                    <div className="timeline-card">
                                        <h3 className="timeline-card__title">{item.title}</h3>
                                        <img src={item.image} alt={item.title} className="timeline-card__image" />
                                        <div className="timeline-card__season">
                                            <span className="timeline-card__season-dot" style={{ backgroundColor: item.color }}></span>
                                            {item.season}
                                        </div>
                                        <div className="timeline-card__bottom-line" style={{ background: `linear-gradient(90deg, transparent, ${item.color}, transparent)` }}></div>
                                    </div>
                                </div>
                            ))}
                        </div>
                    </div>
                </section>

                {/* --- Gallery of Moments Section --- */}
                <section className="festivals-gallery">
                    <div className="festivals-gallery__header fade-up">
                        <div className="festivals-gallery__tag">VISUAL JOURNEY</div>
                        <h2 className="festivals-gallery__title">Gallery of Moments</h2>
                        <p className="festivals-gallery__subtitle">Immerse yourself in the atmosphere and emotion of Vietnamese festivals</p>
                    </div>

                    <div className="festivals-gallery__grid fade-up">
                        {/* Col 1 equivalent */}
                        <img src={banner2Img} alt="Festival Moment" className="gallery-1-1" />
                        <img src={banner1Img} alt="Festival Moment" className="gallery-1-2" />
                        <img src={bannerImg} alt="Festival Moment" className="gallery-1-3" />

                        {/* Col 2 equivalent */}
                        <img src={banner3Img} alt="Festival Moment" className="gallery-2-1" />
                        <img src={bannerImg} alt="Festival Moment" className="gallery-2-2" />
                        <img src={banner1Img} alt="Festival Moment" className="gallery-2-3" />
                        <img src={banner2Img} alt="Festival Moment" className="gallery-2-4" />

                        {/* Col 3 equivalent */}
                        <img src={bannerImg} alt="Festival Moment" className="gallery-3-1" />
                        <img src={banner2Img} alt="Festival Moment" className="gallery-3-2" />
                        <img src={banner3Img} alt="Festival Moment" className="gallery-3-3" />
                    </div>
                </section>

                {/* --- Cultural Quote Section --- */}
                <section className="festivals-quote" style={{ backgroundImage: `url(${banner1Img})` }}>
                    <div className="festivals-quote__overlay"></div>
                    <div className="festivals-quote__content fade-up">
                        <div className="festivals-quote__decoration">
                            <span className="quote-mark">“</span>
                        </div>
                        <h2 className="festivals-quote__title">Uống nước nhớ nguồn</h2>
                        <p className="festivals-quote__subtitle">"When drinking water, remember the source"</p>
                        
                        <div className="festivals-quote__divider">
                            <svg className="festivals-quote__icon" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                                <path d="M12 2L2 12l10 10 10-10L12 2z" />
                                <circle cx="12" cy="12" r="3" />
                            </svg>
                        </div>

                        <p className="festivals-quote__desc">
                            This timeless proverb captures the profound gratitude and respect Vietnamese people hold for their ancestors and heritage. It is the spiritual foundation of countless festivals across the nation.
                        </p>

                        <button className="festivals-btn festivals-btn--primary festivals-quote__btn">Discover Culture</button>
                    </div>
                    
                    {/* Optional floating particles effect - simple CSS version */}
                    <div className="festivals-quote__particles"></div>
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

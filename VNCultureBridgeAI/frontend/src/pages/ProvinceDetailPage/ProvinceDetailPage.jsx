import { useMemo, useState, useEffect } from 'react'
import { useLanguage } from '../../context/LanguageContext'
import { useParams, Link } from 'react-router-dom'
import './ProvinceDetailPage.css'
import PageHeader from '../../components/layout/PageHeader/PageHeader'
import Footer from '../../components/layout/Footer/Footer'
import LoadingState from '../../components/common/LoadingState/LoadingState'
import { getProvince } from '../../services/province.service'
import { useDetailLoader } from '../../hooks/useDetailLoader'

export default function ProvinceDetailPage() {
  const { lang, setLang } = useLanguage()
  const { code } = useParams()

  const { status, data, error } = useDetailLoader(getProvince, lang, code)

  useEffect(() => {
    window.scrollTo(0, 0)
    if (data?.title) {
      document.title = `${data.title} - VNCultureBridgeAI`
    }
  }, [code, data?.title])

  const handleOpenChatbot = (e) => {
    e.preventDefault();
    window.dispatchEvent(new CustomEvent('vnc-open-chatbot'));
  };

  if (status === 'loading') return <LoadingState message={lang === 'vi' ? 'Đang tải tỉnh thành...' : 'Loading province...'} />
  if (status === 'error') return <LoadingState type="error" message={error} />
  if (!data) return null

  const cuisine = data.cuisine || []
  const festivals = data.festivals || []
  const articles = data.articles || []

  return (
    <div className="province-detail">
      <PageHeader lang={lang} onLangChange={setLang} />

      <main>
        {/* PREMIUM HERO */}
        <section className="province-hero">
          <img src={data.heroImageUrl} alt={data.title} className="province-hero__img" />
          <div className="province-hero__overlay">
            <div className="hero-content-wrapper">
              <span className="province-hero__badge">{data.region}</span>
              <h1>{data.title}</h1>
              <p className="hero-subtitle">{data.subtitle}</p>
              <p className="hero-desc">{data.description}</p>
            </div>
          </div>
        </section>

        {/* METRICS BAR */}
        <div className="province-metrics-bar">
          <div className="metric-item">
            <div className="metric-item__icon">📍</div>
            <div className="metric-item__info">
              <span className="metric-item__label">{lang === 'vi' ? 'Khí hậu' : 'Climate'}</span>
              <span className="metric-item__value">{data.metrics.bestTime}</span>
            </div>
          </div>
          <div className="metric-item">
            <div className="metric-item__icon">👥</div>
            <div className="metric-item__info">
              <span className="metric-item__label">{lang === 'vi' ? 'Dân số' : 'Population'}</span>
              <span className="metric-item__value">~2.5M</span>
            </div>
          </div>
          <div className="metric-item">
            <div className="metric-item__icon">📏</div>
            <div className="metric-item__info">
              <span className="metric-item__label">{lang === 'vi' ? 'Diện tích' : 'Area'}</span>
              <span className="metric-item__value">3,358 km²</span>
            </div>
          </div>
        </div>

        {/* SECTION 1: CULTURAL QUINTESSENCE */}
        <section className="province-section">
          <div className="section-header">
            <span className="province-hero__badge" style={{ background: 'none', color: 'var(--primary-red)', border: '1px solid currentColor' }}>
              {lang === 'vi' ? 'Tinh hoa' : 'Quintessence'}
            </span>
            <h2 className="section-title">{lang === 'vi' ? 'Hương vị & Lễ hội đặc thù' : 'Local Taste & Traditions'}</h2>
            <div className="section-divider"></div>
          </div>

          <div className="cultural-hub-grid">
            {cuisine.slice(0, 2).map((item, idx) => (
              <div key={item.id} className={`cultural-card ${idx === 0 ? 'card-lg' : 'card-sm'}`}>
                <div className="cultural-card__img">
                  <img src={item.imageUrl} alt={item.title} />
                </div>
                <div className="cultural-card__overlay">
                  <h3>{item.title}</h3>
                  <p>{item.description}</p>
                </div>
              </div>
            ))}
            {festivals.slice(0, 2).map((item) => (
              <div key={item.id} className="cultural-card card-md">
                <div className="cultural-card__img">
                  <img src={item.imageUrl} alt={item.title} />
                </div>
                <div className="cultural-card__overlay">
                  <h3>{item.title}</h3>
                  <p>{item.date} • {item.description}</p>
                </div>
              </div>
            ))}
          </div>
        </section>

        {/* SECTION 2: LOCAL STORIES */}
        <section className="local-stories alternate-bg">
          <div className="container">
            <div className="section-header">
              <h2 className="section-title">{lang === 'vi' ? 'Ghi chép từ địa phương' : 'Local Stories'}</h2>
              <div className="section-divider"></div>
            </div>

            <div className="stories-row">
              {articles.map((article) => (
                <Link to={`/blog/${article.code}`} key={article.id} className="story-card">
                  <span className="story-card__tag">{article.category}</span>
                  <h4>{article.title}</h4>
                  <p style={{ color: 'var(--primary-red)', fontWeight: 700 }}>
                    {lang === 'vi' ? 'Xem chi tiết' : 'View details'} →
                  </p>
                </Link>
              ))}
            </div>
          </div>
        </section>

        {/* CTA */}
        <section className="province-section text-center" style={{ background: 'var(--primary-red)', color: '#fff', padding: '80px 5%' }}>
          <h2 style={{ fontSize: '2.5rem', marginBottom: '20px' }}>
            {lang === 'vi' ? 'Bạn muốn khám phá thêm?' : 'Want to explore more?'}
          </h2>
          <p style={{ opacity: 0.9, marginBottom: '35px' }}>
            {lang === 'vi' ? 'Liên hệ với chuyên gia văn hóa hoặc hỏi AI để biết thêm chi tiết.' : 'Contact our cultural experts or ask AI for more details.'}
          </p>
          <div style={{ display: 'flex', gap: '20px', justifyContent: 'center' }}>
            <button onClick={handleOpenChatbot} className="btn-primary" style={{ background: '#fff', color: 'var(--primary-red)', border: 'none', cursor: 'pointer' }}>
              {lang === 'vi' ? 'Hỏi AI ngay' : 'Ask AI Now'}
            </button>
            <Link to="/provinces" className="btn-primary" style={{ border: '1px solid #fff' }}>
              {lang === 'vi' ? 'Danh sách tỉnh thành' : 'Province List'}
            </Link>
          </div>
        </section>
      </main>

      <Footer lang={lang} />
    </div>
  )
}

import React, { useState } from 'react';
import { Link, useParams } from 'react-router-dom';
import './EthnicCulturesDetailPage.css';
import PageHeader from '../../components/layout/PageHeader/PageHeader';
import Footer from '../../components/layout/Footer/Footer';
import LoadingState from '../../components/common/LoadingState/LoadingState';
import { getEthnicity } from '../../services/ethnicity.service';
import { useDetailLoader } from '../../hooks/useDetailLoader';
import { useLanguage } from '../../context/LanguageContext';
import { getGeminiChatSession } from '../../services/gemini';
import {
  FiClock,
  FiMusic,
  FiImage,
  FiGlobe,
  FiArrowLeft,
} from 'react-icons/fi';

export default function EthnicCulturesDetailPage() {
  const { lang, setLang } = useLanguage();
  const { code = 'hmong' } = useParams();
  const { status, data, error } = useDetailLoader(getEthnicity, lang, code);

  const [aiInsight, setAiInsight] = useState('');
  const [aiLoading, setAiLoading] = useState(false);

  // Hook for AI Insight
  React.useEffect(() => {
    async function fetchAiInsight() {
      if (!data?.name || aiInsight) return;

      const apiKey = localStorage.getItem('GEMINI_API_KEY') || import.meta.env.VITE_GEMINI_API_KEY;
      if (!apiKey) return;

      try {
        setAiLoading(true);
        const chat = getGeminiChatSession(apiKey);
        const prompt = lang === 'vi'
          ? `Hãy viết một đoạn văn ngắn (khoảng 150 chữ) kể về bản sắc độc đáo nhất và "linh hồn" văn hóa của dân tộc ${data.name}. Hãy dùng ngôn từ giàu hình ảnh, đậm chất di sản.`
          : `Write a short paragraph (about 150 words) about the most unique identity and cultural "soul" of the ${data.name} people. Use evocative and heritage-rich language.`;

        const result = await chat.sendMessage(prompt);
        setAiInsight(result.response.text());
      } catch (err) {
        console.error("AI Insight Error:", err);
      } finally {
        setAiLoading(false);
      }
    }

    if (data) {
      fetchAiInsight();
    }
  }, [data, lang, aiInsight]);

  if (status === 'loading') return <LoadingState message={lang === 'vi' ? "Đang tải di sản dân tộc..." : "Loading ethnic heritage..."} />;
  if (status === 'error' || !data) return <LoadingState type="error" message={lang === 'vi' ? "Không tìm thấy dữ liệu dân tộc." : "Ethnic data not found."} detail={error} />;

  const { hero, identity, overview, history, sections, gallery, relatedArticles } = data;

  const navItems = [
    { icon: <FiClock />, label: lang === 'vi' ? 'Lịch sử' : 'History', id: 'history' },
    { icon: <FiGlobe />, label: lang === 'vi' ? 'Bản sắc' : 'Identity', id: 'identity' },
    { icon: <FiMusic />, label: lang === 'vi' ? 'Nghệ thuật' : 'Arts', id: 'arts' },
    { icon: <FiImage />, label: lang === 'vi' ? 'Thư viện' : 'Gallery', id: 'gallery' },
  ];

  return (
    <div className="page-shell">
      <PageHeader lang={lang} onLangChange={setLang} breadcrumb={[
        { label: lang === 'vi' ? 'Dân tộc Việt Nam' : 'Vietnamese Ethnic Groups', path: '/ethnic-groups' },
        { label: data.name }
      ]} />

      <main className="ed-main">
        {/* HERO SECTION */}
        <section className="ed-hero">
          <div className="ed-hero__bg" style={{ backgroundImage: `url(${hero.backgroundImageUrl})` }}></div>
          <div className="ed-hero__overlay"></div>
          <div className="ed-hero__ornament ed-hero__ornament--tl"></div>
          <div className="ed-hero__ornament ed-hero__ornament--br"></div>

          <div className="ed-hero__inner">
            <div className="ed-hero__left fade-up">
              <Link to="/ethnic-groups" className="ed-back-btn">
                <FiArrowLeft /> <span>{lang === 'vi' ? 'Quay lại' : 'Back'}</span>
              </Link>

              <div className="ed-hero__badge">
                <span className="ed-hero__badge-dot"></span>
                {hero.badge}
              </div>

              <h1 className="ed-hero__title">{hero.title}</h1>
              <p className="ed-hero__subtitle">{hero.subtitle}</p>

              {(hero.stats || []).length ? (
                <div className="ed-hero__stats">
                  {(hero.stats || []).map((item, index) => (
                    <div key={index} className="ed-hero__stat">
                      <strong>{item.value}</strong>
                      <span>{item.label}</span>
                    </div>
                  ))}
                </div>
              ) : null}

              <div className="ed-hero__nav-inline">
                {navItems.map((nav, idx) => (
                  <div key={idx} className="ed-nav-item" onClick={() => document.getElementById(nav.id)?.scrollIntoView({ behavior: 'smooth' })}>
                    <div className="ed-nav-icon">{nav.icon}</div>
                    <span className="ed-nav-label">{nav.label}</span>
                  </div>
                ))}
              </div>
            </div>

            <div className="ed-hero__right fade-up delay-1">
              <div className="ed-hero__img-frame">
                <img src={hero.foregroundImageUrl} alt={data.name} className="ed-hero__img-main" />
                <div className="ed-hero__img-ring"></div>
              </div>
            </div>
          </div>
        </section>

        {/* IDENTITY CARD CONTAINER */}
        <div className="ed-container ed-identity-container">
          <div className="ed-identity-card fade-up delay-2">
            <div className="ed-identity-item">
              <span className="ed-identity-label">{lang === 'vi' ? 'Dân số' : 'Population'}</span>
              <span className="ed-identity-value">{identity.population}</span>
            </div>
            <div className="ed-identity-item">
              <span className="ed-identity-label">{lang === 'vi' ? 'Nhóm ngôn ngữ' : 'Language Group'}</span>
              <span className="ed-identity-value">{identity.classification}</span>
            </div>
            <div className="ed-identity-item">
              <span className="ed-identity-label">{lang === 'vi' ? 'Cư trú chính' : 'Main Distribution'}</span>
              <span className="ed-identity-value">{identity.locationSummary}</span>
            </div>
            <div className="ed-identity-item">
              <span className="ed-identity-label">{lang === 'vi' ? 'Ngôn ngữ' : 'Language'}</span>
              <span className="ed-identity-value">{identity.language}</span>
            </div>
          </div>
        </div>

        {/* OVERVIEW SECTION */}
        <section id="identity" className="ed-section ed-section--light">
          <div className="ed-container">
            <div className="ed-intro__grid">
              <div className="ed-intro__text fade-up">
                <header className="ed-section-header" style={{ textAlign: 'left', marginBottom: '40px' }}>
                  <span className="ed-section-badge">{lang === 'vi' ? 'Dấu ấn di sản' : 'Heritage Mark'}</span>
                  <h2 className="ed-section-title">{overview.title}</h2>
                </header>
                <span className="ed-drop-cap">{(data.name || 'D')[0]}</span>
                <div className="ed-intro__body">
                  <p>{overview.content}</p>
                </div>
              </div>
              <div className="ed-intro__image fade-up delay-1">
                <img src={overview.imageUrl} alt={overview.title} />
              </div>
            </div>
          </div>
        </section>

        {/* HISTORY & TRADITION SECTION */}
        <section id="history" className="ed-section ed-section--cream">
          <div className="ed-container">
            <div className="ed-section-header fade-up">
              <span className="ed-section-badge">{lang === 'vi' ? 'Dòng chảy lịch sử' : 'Flow of History'}</span>
              <h2 className="ed-section-title">{history.title}</h2>
            </div>
            <div className="ed-history-text fade-up">
              {history.content ? history.content.split('\n').map((para, i) => para.trim() && <p key={i} style={{marginBottom: '20px'}}>{para}</p>) : (
                <p>{lang === 'vi' ? 'Thông tin đang được cập nhật.' : 'Updating information...'}</p>
              )}
            </div>

            <div className="ed-fun-facts fade-up" style={{marginTop: '60px'}}>
              <div className="ed-fun-fact">
                <h4>{lang === 'vi' ? 'Phong tục tập quán' : 'Traditional Customs'}</h4>
                <p>{lang === 'vi' ? 'Những nét văn hóa tâm linh và ứng xử cộng đồng đặc sắc.' : 'Unique spiritual and community cultural features.'}</p>
              </div>
              <div className="ed-fun-fact">
                <h4>{lang === 'vi' ? 'Không gian sống' : 'Living Space'}</h4>
                <p>{lang === 'vi' ? 'Kiến trúc nhà ở phản ánh sự thích nghi tuyệt vời với thiên nhiên.' : 'Housing architecture reflecting great adaptation to nature.'}</p>
              </div>
            </div>
          </div>
        </section>

        {/* AI INSIGHT SECTION */}
        <section className="ed-section">
          <div className="ed-container">
            <div className="ed-ai-insight fade-up">
              <div className="ed-ai-header">
                <div className="ed-ai-avatar">✨</div>
                <div>
                  <h3 style={{ margin: 0, fontSize: '1.8rem', color: '#fbbf24', fontFamily: 'var(--font-heading)' }}>
                    {lang === 'vi' ? 'Linh hồn văn hóa' : 'Cultural Soul'}
                  </h3>
                  <small style={{ color: 'rgba(255,255,255,0.6)', letterSpacing: '1px', textTransform: 'uppercase' }}>
                    {lang === 'vi' ? 'Phân tích bởi Trí tuệ văn hóa AI' : 'Analyzed by AI Cultural Intelligence'}
                  </small>
                </div>
              </div>
              <div className="ed-ai-body">
                {aiLoading ? (
                  <span>{lang === 'vi' ? 'Đang kết nối tri thức...' : 'Connecting knowledge...'}</span>
                ) : aiInsight ? (
                  <p>"{aiInsight}"</p>
                ) : (
                  <p>{lang === 'vi' ? 'Lời nhắn từ ngàn xưa...' : 'Message from ancient times...'}</p>
                )}
              </div>
            </div>
          </div>
        </section>

        {/* ARTS & FESTIVALS SECTION */}
        <section id="arts" className="ed-section ed-section--light">
          <div className="ed-container">
            <div className="ed-section-header fade-up">
              <span className="ed-section-badge">{lang === 'vi' ? 'Nghệ thuật & Lễ hội' : 'Arts & Festivals'}</span>
              <h2 className="ed-section-title">{lang === 'vi' ? 'Di sản tinh thần sống động' : 'Vibrant Spiritual Heritage'}</h2>
            </div>
            
            <div className="ed-festival-grid">
              {(sections.festivals || []).slice(0, 3).map((lh, idx) => (
                <div className="ed-fest-card fade-up" key={lh.id || idx} style={{animationDelay: `${idx * 0.2}s`}}>
                  <img src={lh.imageUrl} alt={lh.title} className="ed-fest-img" />
                  <div className="ed-fest-content">
                    <h3 className="ed-fest-title">{lh.title}</h3>
                    <p style={{color: 'var(--text-secondary)', fontSize: '0.95rem'}}>{lh.description}</p>
                  </div>
                </div>
              ))}
              {(sections.festivals || []).length === 0 && (
                 <p className="fade-up" style={{textAlign: 'center', gridColumn: 'span 3', color: 'var(--text-secondary)'}}>
                    {lang === 'vi' ? 'Đang cập nhật các lễ hội đặc sắc.' : 'Updating unique festivals...'}
                 </p>
              )}
            </div>
          </div>
        </section>

        {/* GALLERY SECTION */}
        <section id="gallery" className="ed-section ed-section--cream">
          <div className="ed-container">
            <div className="ed-section-header fade-up">
              <span className="ed-section-badge">{lang === 'vi' ? 'Khoảnh khắc di sản' : 'Heritage Moments'}</span>
              <h2 className="ed-section-title">{lang === 'vi' ? 'Thư viện hình ảnh' : 'Photo Gallery'}</h2>
            </div>

            <div className="ed-gallery-grid">
              {(gallery || []).map((img, idx) => (
                <div key={img.id || idx} className={`ed-gallery-item fade-up ${idx === 0 ? 'large' : ''}`} style={{animationDelay: `${idx * 0.1}s`}}>
                  <img src={img.imageUrl} alt={img.imageAlt} />
                </div>
              ))}
              {(gallery || []).length === 0 && (
                 <p className="fade-up" style={{textAlign: 'center', gridColumn: 'span 4', color: 'var(--text-secondary)'}}>
                    {lang === 'vi' ? 'Đang cập nhật hình ảnh di sản.' : 'Updating heritage photos...'}
                 </p>
              )}
            </div>
          </div>
        </section>

        {/* RELATED ARTICLES */}
        {relatedArticles?.length > 0 && (
          <section className="ed-section ed-section--light">
            <div className="ed-container">
              <div className="ed-section-header fade-up">
                <h2 className="ed-section-title">{lang === 'vi' ? 'Bài viết liên quan' : 'Related Articles'}</h2>
              </div>
              <div className="ed-festival-grid">
                {relatedArticles.slice(0, 3).map((article, idx) => (
                  <Link to={`/blog/${article.code}`} key={article.id || idx} className="ed-fest-card fade-up">
                    <img src={article.imageUrl} alt={article.title} className="ed-fest-img" />
                    <div className="ed-fest-content">
                      <h3 className="ed-fest-title" style={{fontSize: '1.25rem'}}>{article.title}</h3>
                      <p style={{color: 'var(--text-secondary)', fontSize: '0.9rem'}}>{article.description}</p>
                    </div>
                  </Link>
                ))}
              </div>
            </div>
          </section>
        )}

        {/* BOTTOM CTA */}
        <section className="ed-section" style={{background: 'var(--dark-wood)', textAlign: 'center', padding: '80px 0'}}>
          <div className="ed-container">
            <h2 className="ed-section-title" style={{color: 'white', marginBottom: '40px'}}>
              {lang === 'vi' ? 'Khám phá những bản sắc khác' : 'Explore Other Identities'}
            </h2>
            <Link to="/ethnic-groups" className="ed-back-btn" style={{background: 'var(--heritage-red)', border: 'none', margin: '0 auto'}}>
              {lang === 'vi' ? 'Xem tất cả dân tộc' : 'View All Ethnic Groups'}
            </Link>
          </div>
        </section>
      </main>

      <Footer lang={lang} />
    </div>
  );
}

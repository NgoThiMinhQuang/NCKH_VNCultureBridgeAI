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
  FiSunrise,
  FiInfo,
  FiLayers,
  FiAperture
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
    { icon: <FiGlobe />, label: lang === 'vi' ? 'Bản sắc' : 'Identity', id: 'pillars' },
    { icon: <FiMusic />, label: lang === 'vi' ? 'Lễ hội' : 'Festivals', id: 'arts' },
    { icon: <FiImage />, label: lang === 'vi' ? 'Thư viện' : 'gallery' },
  ];

  // Pillar categories for internal data mapping
  const pillars = [
    {
      icon: <FiSunrise />,
      title: lang === 'vi' ? 'Trang phục' : 'Costume',
      desc: lang === 'vi' ? 'Hoa văn thủ công truyền thống, phản ánh kỹ thuật dệt nhuộm cầu kỳ.' : 'Traditional handcrafted patterns, reflecting sophisticated weaving and dyeing techniques.',
      img: gallery?.[1]?.imageUrl || overview.imageUrl
    },
    {
      icon: <FiLayers />,
      title: lang === 'vi' ? 'Kiến trúc' : 'Architecture',
      desc: lang === 'vi' ? 'Không gian sống hài hòa với thiên nhiên, ẩn chứa triết lý thích nghi.' : 'Living spaces in harmony with nature, containing adaptation philosophies.',
      img: gallery?.[2]?.imageUrl || hero.backgroundImageUrl
    },
    {
      icon: <FiAperture />,
      title: lang === 'vi' ? 'Tín ngưỡng' : 'Beliefs',
      desc: lang === 'vi' ? 'Những phong tục thờ cúng tổ tiên và triết lý tâm linh ngàn đời.' : 'Ancient ancestor worship customs and spiritual philosophies.',
      img: gallery?.[3]?.imageUrl || sections.festivals?.[0]?.imageUrl || overview.imageUrl
    }
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
                <FiArrowLeft /> <span>{lang === 'vi' ? 'Khám phá tất cả' : 'Explore All'}</span>
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
              <span className="ed-identity-label">{lang === 'vi' ? 'Quy mô dân số' : 'Population Size'}</span>
              <span className="ed-identity-value">{identity.population}</span>
            </div>
            <div className="ed-identity-item">
              <span className="ed-identity-label">{lang === 'vi' ? 'Hệ ngôn ngữ' : 'Language Family'}</span>
              <span className="ed-identity-value">{identity.classification}</span>
            </div>
            <div className="ed-identity-item">
              <span className="ed-identity-label">{lang === 'vi' ? 'Cư trú' : 'Distribution'}</span>
              <span className="ed-identity-value">{identity.locationSummary}</span>
            </div>
            <div className="ed-identity-item">
              <span className="ed-identity-label">{lang === 'vi' ? 'Tiếng nói' : 'Dialect'}</span>
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
                  <span className="ed-section-badge">{lang === 'vi' ? 'Hành trình di sản' : 'Heritage Journey'}</span>
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

        {/* CULTURAL PILLARS SECTION */}
        <section id="pillars" className="ed-section ed-section--cream">
          <div className="ed-container">
            <div className="ed-section-header fade-up">
              <span className="ed-section-badge">{lang === 'vi' ? 'Trụ cột văn hóa' : 'Cultural Pillars'}</span>
              <h2 className="ed-section-title">{lang === 'vi' ? 'Tinh hoa bản sắc' : 'Essence of Identity'}</h2>
            </div>
            
            <div className="ed-pillars-grid">
              {pillars.map((pillar, idx) => (
                <div className="ed-pillar-card fade-up" key={idx} style={{animationDelay: `${idx * 0.2}s`}}>
                  <img src={pillar.img} alt={pillar.title} className="ed-pillar-img" />
                  <div className="ed-pillar-overlay">
                    <div className="ed-pillar-icon">{pillar.icon}</div>
                    <h3>{pillar.title}</h3>
                    <p>{pillar.desc}</p>
                  </div>
                </div>
              ))}
            </div>
          </div>
        </section>

        {/* HISTORY & TRADITION SECTION */}
        <section id="history" className="ed-section ed-section--light">
          <div className="ed-container">
            <div className="ed-section-header fade-up">
              <span className="ed-section-badge">{lang === 'vi' ? 'Dấu ấn thời gian' : 'Time Markings'}</span>
              <h2 className="ed-section-title">{history.title}</h2>
            </div>
            <div className="ed-history-text fade-up">
              {history.content ? history.content.split('\n').map((para, i) => para.trim() && <p key={i} style={{marginBottom: '28px'}}>{para}</p>) : (
                <p>{lang === 'vi' ? 'Thông tin lịch sử đang được số hóa...' : 'Historical data being digitized...'}</p>
              )}
            </div>

            <div className="ed-fun-facts fade-up" style={{marginTop: '80px'}}>
              <div className="ed-fun-fact">
                <FiInfo style={{fontSize: '2rem', color: 'var(--heritage-red)', marginBottom: '20px'}} />
                <h4>{lang === 'vi' ? 'Phong tục tập quán' : 'Traditional Customs'}</h4>
                <p style={{lineHeight: '1.6', opacity: 0.8}}>{lang === 'vi' ? 'Những nét văn hóa tâm linh và quy tắc ứng xử cộng đồng đặc trưng mang tính biểu tượng.' : 'Unique spiritual cultural features and community etiquette rules with symbolic characteristics.'}</p>
              </div>
              <div className="ed-fun-fact">
                <FiSunrise style={{fontSize: '2rem', color: 'var(--heritage-red)', marginBottom: '20px'}} />
                <h4>{lang === 'vi' ? 'Triết lý sống' : 'Life Philosophy'}</h4>
                <p style={{lineHeight: '1.6', opacity: 0.8}}>{lang === 'vi' ? 'Sự hòa hợp tuyệt đối giữa con người và thiên nhiên núi rừng, thể hiện qua kiến trúc và sinh hoạt.' : 'Absolute harmony between humans and the forest nature, shown through architecture and daily life.'}</p>
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
                  <h3 style={{ margin: 0, fontSize: '2rem', color: '#fbbf24', fontFamily: 'var(--font-heading)' }}>
                    {lang === 'vi' ? 'Linh hồn di sản' : 'Soul of Heritage'}
                  </h3>
                  <small style={{ color: 'rgba(255,255,255,0.6)', letterSpacing: '2px', textTransform: 'uppercase', fontWeight: 600 }}>
                    {lang === 'vi' ? 'Phân tích bởi Trí tuệ văn hóa VNCulture' : 'Analyzed by VNCulture AI'}
                  </small>
                </div>
              </div>
              <div className="ed-ai-body">
                {aiLoading ? (
                  <span>{lang === 'vi' ? 'AI đang kết nối tri thức bản địa...' : 'AI connecting native knowledge...'}</span>
                ) : aiInsight ? (
                  <p>"{aiInsight}"</p>
                ) : (
                  <p>{lang === 'vi' ? 'Không gian tri thức đang mở ra...' : 'Knowledge space opening...'}</p>
                )}
              </div>
            </div>
          </div>
        </section>

        {/* ARTS & FESTIVALS SECTION */}
        <section id="arts" className="ed-section ed-section--cream">
          <div className="ed-container">
            <div className="ed-section-header fade-up">
              <span className="ed-section-badge">{lang === 'vi' ? 'Nhịp sống văn hóa' : 'Cultural Pulse'}</span>
              <h2 className="ed-section-title">{lang === 'vi' ? 'Lễ hội & Nghệ thuật' : 'Festivals & Arts'}</h2>
            </div>
            
            <div className="ed-festival-grid">
              {(sections.festivals || []).slice(0, 3).map((lh, idx) => (
                <Link to={`/festivals/${lh.code || idx}`} className="ed-fest-card fade-up" key={lh.id || idx} style={{animationDelay: `${idx * 0.2}s`}}>
                  <img src={lh.imageUrl} alt={lh.title} className="ed-fest-img" />
                  <div className="ed-fest-content">
                    <h3 className="ed-fest-title">{lh.title}</h3>
                    <p style={{color: 'var(--text-secondary)', fontSize: '1rem', lineHeight: '1.6'}}>{lh.description}</p>
                  </div>
                </Link>
              ))}
              {(sections.festivals || []).length === 0 && (
                 <p className="fade-up" style={{textAlign: 'center', gridColumn: 'span 3', color: 'var(--text-secondary)', fontStyle: 'italic'}}>
                    {lang === 'vi' ? 'Dữ liệu lễ hội đang được thu thập thêm.' : 'More festival data being gathered...'}
                 </p>
              )}
            </div>
          </div>
        </section>

        {/* GALLERY SECTION */}
        <section id="gallery" className="ed-section ed-section--light">
          <div className="ed-container">
            <div className="ed-section-header fade-up">
              <span className="ed-section-badge">{lang === 'vi' ? 'Thị giác di sản' : 'Heritage Vision'}</span>
              <h2 className="ed-section-title">{lang === 'vi' ? 'Thư viện hình ảnh' : 'Photo Gallery'}</h2>
            </div>

            <div className="ed-gallery-grid">
              {(gallery || []).map((img, idx) => (
                <div key={img.id || idx} className={`ed-gallery-item fade-up ${idx === 0 ? 'large' : idx % 5 === 0 ? 'tall' : ''}`} style={{animationDelay: `${idx * 0.1}s`}}>
                  <img src={img.imageUrl} alt={img.imageAlt} />
                </div>
              ))}
              {(gallery || []).length === 0 && (
                 <p className="fade-up" style={{textAlign: 'center', gridColumn: 'span 4', color: 'var(--text-secondary)'}}>
                    {lang === 'vi' ? 'Thư viện ảnh đang được làm giàu dữ liệu.' : 'Gallery being enriched with data...'}
                 </p>
              )}
            </div>
          </div>
        </section>

        {/* RELATED ARTICLES */}
        {relatedArticles?.length > 0 && (
          <section className="ed-section ed-section--cream">
            <div className="ed-container">
              <div className="ed-section-header fade-up">
                <span className="ed-section-badge">{lang === 'vi' ? 'Tiếp nối hành trình' : 'Continue Journey'}</span>
                <h2 className="ed-section-title">{lang === 'vi' ? 'Khám phá thêm' : 'Discovery More'}</h2>
              </div>
              <div className="ed-festival-grid">
                {relatedArticles.slice(0, 3).map((article, idx) => (
                  <Link to={`/blog/${article.code}`} key={article.id || idx} className="ed-fest-card fade-up">
                    <img src={article.imageUrl} alt={article.title} className="ed-fest-img" />
                    <div className="ed-fest-content">
                      <h3 className="ed-fest-title" style={{fontSize: '1.4rem'}}>{article.title}</h3>
                      <p style={{color: 'var(--text-secondary)', fontSize: '0.95rem', lineHeight: '1.6'}}>{article.description}</p>
                    </div>
                  </Link>
                ))}
              </div>
            </div>
          </section>
        )}

        {/* BOTTOM CTA */}
        <section className="ed-section" style={{background: 'var(--dark-wood)', textAlign: 'center', padding: '120px 0'}}>
          <div className="ed-container">
            <div className="fade-up">
              <h2 className="ed-section-title" style={{color: 'white', marginBottom: '40px'}}>
                {lang === 'vi' ? 'Khám phá những sắc màu di sản khác' : 'Explore Other Heritage Colors'}
              </h2>
              <div style={{display: 'flex', gap: '24px', justifyContent: 'center'}}>
                <Link to="/ethnic-groups" className="ed-back-btn" style={{background: 'var(--heritage-red)', border: 'none', margin: '0'}}>
                  {lang === 'vi' ? 'Xem 54 Dân tộc' : 'View 54 Ethnic Groups'}
                </Link>
                <Link to="/" className="ed-back-btn" style={{background: 'transparent', borderColor: 'rgba(255,255,255,0.3)', margin: '0'}}>
                  {lang === 'vi' ? 'Về Trang chủ' : 'Home'}
                </Link>
              </div>
            </div>
          </div>
        </section>
      </main>

      <Footer lang={lang} />
    </div>
  );
}

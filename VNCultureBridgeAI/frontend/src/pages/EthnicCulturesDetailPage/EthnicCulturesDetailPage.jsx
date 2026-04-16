import React, { useMemo, useState } from 'react';
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
  FiCoffee,
  FiHome,
  FiImage,
  FiGlobe,
  FiArrowLeft,
} from 'react-icons/fi';
import hmongImg from '../../assets/hmong.jpg';
import daoImg from '../../assets/dao.jpg';
import edeImg from '../../assets/ede.jpg';
import khmerImg from '../../assets/khmer.jpg';
import chamImg from '../../assets/cham.jpg';
import muongImg from '../../assets/muong.jpg';
import kinhImg from '../../assets/anhtet1.PNG';
import ruongBacThangImg from '../../assets/ruong-bac-thang.jpg';
import congChiengImg from '../../assets/cong_chieng.png';
import leCapSacImg from '../../assets/le-cap-sac.jpg';
import detThoCamImg from '../../assets/det-tho-cam.jpg';
import muaTrongImg from '../../assets/mua-trong-sadam.jpg';
import phoImg from '../../assets/cuisine_pho.png';
import hatQuanHoImg from '../../assets/hat-quan-ho.png';
import artAoDaiImg from '../../assets/anhtet1.PNG';
import banner3 from '../../assets/banner3.jpg';

const defaultFallback = {
  heroBackground: banner3,
  cuisine: phoImg,
  architecture: ruongBacThangImg,
};

const localEthnicImageByCode = {
  kinh: kinhImg, tay: ruongBacThangImg, hmong: hmongImg, dao: daoImg,
  ede: edeImg, khmer: khmerImg, cham: chamImg, muong: muongImg,
};

const sectionFallbackByCode = {
  kinh: { ...defaultFallback, heroForeground: kinhImg, overview: kinhImg, feature: artAoDaiImg, music: hatQuanHoImg, festival: banner3, gallery: kinhImg },
  tay: { ...defaultFallback, heroBackground: ruongBacThangImg, heroForeground: ruongBacThangImg, overview: ruongBacThangImg, feature: ruongBacThangImg, music: ruongBacThangImg, festival: ruongBacThangImg, gallery: ruongBacThangImg },
  hmong: { ...defaultFallback, heroForeground: hmongImg, overview: hmongImg, feature: detThoCamImg, music: congChiengImg, festival: leCapSacImg, gallery: hmongImg },
  dao: { ...defaultFallback, heroForeground: daoImg, overview: daoImg, feature: leCapSacImg, music: leCapSacImg, festival: leCapSacImg, gallery: daoImg },
  khmer: { ...defaultFallback, heroForeground: khmerImg, overview: khmerImg, feature: muaTrongImg, music: muaTrongImg, festival: muaTrongImg, gallery: khmerImg },
  cham: { ...defaultFallback, heroForeground: chamImg, overview: chamImg, feature: detThoCamImg, music: detThoCamImg, festival: chamImg, gallery: chamImg },
  ede: { ...defaultFallback, heroForeground: edeImg, overview: edeImg, feature: congChiengImg, music: congChiengImg, festival: congChiengImg, gallery: edeImg },
};

const normalizeValue = (v) => String(v || '').normalize('NFD').replace(/[\u0300-\u036f]/g, '').replace(/đ/g, 'd').replace(/Đ/g, 'D').toLowerCase().trim();

const getLocalFallbackSet = (data, code) => {
  const ethnicCode = normalizeValue(data?.code || data?.rawCode || code || '');
  const specific = sectionFallbackByCode[ethnicCode];
  if (specific) return specific;

  const img = localEthnicImageByCode[ethnicCode] || hmongImg;
  return { ...defaultFallback, heroForeground: img, overview: img, feature: img, music: img, festival: img, gallery: img };
};

const handleImageError = (e, fallback) => { if (fallback && e.currentTarget.src !== fallback) e.currentTarget.src = fallback; };

export default function EthnicCulturesDetailPage() {
  const { lang, setLang } = useLanguage();
  const { code = 'hmong' } = useParams();
  const { status, data, error } = useDetailLoader(getEthnicity, lang, code);

  const [aiInsight, setAiInsight] = useState('');
  const [aiLoading, setAiLoading] = useState(false);

  // 1. Hook for AI Insight
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

  // 2. Early returns for Loading/Error states (Hooks MUST be before this)
  if (status === 'loading') return <LoadingState message="Đang tải dữ liệu dân tộc..." />;
  if (status === 'error') return <LoadingState type="error" message="Không tải được dữ liệu." detail={error} />;
  if (!data) return <LoadingState type="error" message="Không tìm thấy dữ liệu dân tộc." />;

  // 3. Data derivation (Regular constants, no useMemo here for simplicity and safety)
  const fallbacks = getLocalFallbackSet(data, code);
  const {
    hero: rawHero,
    overview: rawOverview,
    featureHighlight: rawFeature,
    stats: rawStats,
    sections: rawSections,
    name: rawName,
    description: rawDesc
  } = data;

  const fbName = rawName || (lang === 'vi' ? 'dân tộc Việt Nam' : 'Vietnamese ethnic group');

  const navItems = [
    { icon: <FiClock />, label: lang === 'vi' ? 'Lịch sử' : 'History', id: 'history' },
    { icon: <FiGlobe />, label: lang === 'vi' ? 'Bản sắc' : 'Identity', id: 'customs' },
    { icon: <FiMusic />, label: lang === 'vi' ? 'Lễ hội' : 'Festivals', id: 'festivals' },
    { icon: <FiHome />, label: lang === 'vi' ? 'Điểm đến' : 'Gallery', id: 'gallery' },
  ];

  const page = {
    hero: {
      bg: rawHero?.backgroundImageUrl || fallbacks.heroBackground,
      fg: rawHero?.foregroundImageUrl || fallbacks.heroForeground,
      bgAlt: rawHero?.backgroundImageAlt || (lang === 'vi' ? `Không gian văn hóa của ${fbName}` : `Cultural space of ${fbName}`),
      fgAlt: rawHero?.foregroundImageAlt || (lang === 'vi' ? `Hình ảnh đại diện của ${fbName}` : `Representative image of ${fbName}`),
      badge: rawHero?.badge || (lang === 'vi' ? 'Dân tộc Việt Nam' : 'Ethnic Group'),
      title: rawHero?.title || rawName || (lang === 'vi' ? 'Dân tộc Việt Nam' : 'Vietnamese Ethnic'),
      subtitle: rawHero?.subtitle || rawDesc || (lang === 'vi' ? 'Khám phá bản sắc, ký ức và không gian sống của cộng đồng dân tộc Việt Nam.' : 'Discover the identity, memories, and living spaces of the Vietnamese ethnic communities.'),
      stats: rawHero?.stats || []
    },
    identity: data.identity || {
      population: rawStats?.[0]?.value || 'TBD',
      classification: lang === 'vi' ? 'Đang cập nhật' : 'Processing...',
      locationSummary: lang === 'vi' ? 'Toàn quốc' : 'National',
      language: lang === 'vi' ? 'Ngôn ngữ riêng' : 'Native language'
    },
    overview: {
      title: rawOverview?.title || rawName || (lang === 'vi' ? 'Giới thiệu' : 'Overview'),
      content: rawOverview?.content || rawDesc || (lang === 'vi' ? 'Thông tin đang được cập nhật.' : 'Information is being updated.'),
      img: rawOverview?.imageUrl || rawHero?.foregroundImageUrl || fallbacks.overview,
      alt: rawOverview?.imageAlt || (lang === 'vi' ? `Hình giới thiệu về ${fbName}` : `Introduction image of ${fbName}`)
    },
    history: data.history || { title: lang === 'vi' ? 'Lịch sử' : 'History', content: '' },
    customs: data.customs || { title: lang === 'vi' ? 'Phong tục' : 'Customs', content: '' },
    geography: data.geography || { title: lang === 'vi' ? 'Vị trí' : 'Geography', content: '' },
    culture: {
      title: rawSections?.culture?.title || (lang === 'vi' ? 'Đặc trưng văn hóa' : 'Cultural Features'),
      content: rawSections?.culture?.content || (lang === 'vi' ? 'Những giá trị văn hóa nổi bật đang được lưu giữ qua nhiều thế hệ.' : 'Outstanding cultural values preserved through generations.'),
      imgHighlight: rawFeature?.imageUrl || fallbacks.feature,
      imgAlt: rawFeature?.imageAlt || (lang === 'vi' ? `Nét văn hóa tiêu biểu của ${fbName}` : `Typical culture of ${fbName}`)
    },
    sections: {
      textiles: (rawSections?.textiles || []).filter(i => i?.imageUrl || rawFeature?.imageUrl || fallbacks.feature),
      festivals: (rawSections?.festivals || []).filter(i => i?.title || i?.description || i?.imageUrl),
      cuisine: (rawSections?.cuisine || []).filter(i => i?.title || i?.imageUrl),
      music: rawSections?.music || { title: lang === 'vi' ? 'Âm thanh & nghệ thuật trình diễn' : 'Sounds & Performing Arts', content: lang === 'vi' ? 'Những âm thanh và tiết mục trình diễn gắn liền với đời sống cộng đồng.' : 'Sounds and performances associated with community life.' },
      architecture: rawSections?.architecture || { title: lang === 'vi' ? 'Không gian sống' : 'Living Space', content: lang === 'vi' ? 'Không gian cư trú phản ánh điều kiện tự nhiên và tập quán sống của cộng đồng.' : 'Living spaces reflect natural conditions and community habits.' }
    },
    gallery: (data.gallery || []).filter(i => i?.imageUrl),
    related: (data.relatedArticles || []).filter(i => i?.title || i?.description || i?.imageUrl)
  };

  const { hero, identity, overview, history, customs, geography, culture, sections, gallery, related } = page;

  return (
    <div className="page-shell">
      <PageHeader lang={lang} onLangChange={setLang} breadcrumb={[
        { label: lang === 'vi' ? 'Dân tộc Việt Nam' : 'Vietnamese Ethnic Groups' },
      ]} />

      <main className="ed-main">
        <section className="ed-hero">
          {hero.bg ? <div className="ed-hero__bg" style={{ backgroundImage: `url(${hero.bg})` }} aria-label={hero.bgAlt}></div> : null}
          <div className="ed-hero__overlay"></div>
          <div className="ed-hero__ornament ed-hero__ornament--tl"></div>
          <div className="ed-hero__ornament ed-hero__ornament--br"></div>

          <div className="ed-hero__inner">
            <div className="ed-hero__left fade-up">
              <Link to="/ethnic-groups" className="ed-back-btn" aria-label="Quay lại danh sách dân tộc" style={{ position: 'relative', top: 0, left: 0, display: 'inline-flex', marginBottom: '24px', width: 'fit-content' }}>
                <FiArrowLeft /> <span>Quay lại</span>
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
                    <React.Fragment key={`${item.label}-${index}`}>
                      <div className="ed-hero__stat">
                        <strong>{item.value}</strong>
                        <span>{item.label}</span>
                      </div>
                      {index < (hero.stats?.length || 0) - 1 ? <div className="ed-hero__stat-sep"></div> : null}
                    </React.Fragment>
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

            {hero.fg ? (
              <div className="ed-hero__right fade-up delay-1">
                <div className="ed-hero__img-frame">
                  <img src={hero.fg} alt={hero.fgAlt} className="ed-hero__img-main" onError={(event) => handleImageError(event, fallbacks.heroForeground)} />
                  <div className="ed-hero__img-ring"></div>
                </div>
              </div>
            ) : null}
          </div>

          <div className="ed-section-wave">
            <svg data-name="Layer 1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1200 120" preserveAspectRatio="none">
              <path d="M321.39,56.44c58-10.79,114.16-30.13,172-41.86,82.39-16.72,168.19-17.73,250.45-.39C823.78,31,906.67,72,985.66,92.83c70.05,18.48,146.53,26.09,214.34,3V0H0V27.35A600.21,600.21,0,0,0,321.39,56.44Z" fill="#ffffff"></path>
            </svg>
          </div>
        </section>

        {/* IDENTITY CARD - NEW RICH CONTENT */}
        <div className="ed-container">
          <div className="ed-identity-card">
            <div className="ed-identity-item">
              <span className="ed-identity-label">{lang === 'vi' ? 'Dân số ước đạt' : 'Population Est.'}</span>
              <span className="ed-identity-value">{identity.population}</span>
            </div>
            <div className="ed-identity-item">
              <span className="ed-identity-label">{lang === 'vi' ? 'Họ hàng gần' : 'Classification'}</span>
              <span className="ed-identity-value">{identity.classification}</span>
            </div>
            <div className="ed-identity-item">
              <span className="ed-identity-label">{lang === 'vi' ? 'Cư trú chính' : 'Main Region'}</span>
              <span className="ed-identity-value">{identity.locationSummary}</span>
            </div>
            <div className="ed-identity-item">
              <span className="ed-identity-label">{lang === 'vi' ? 'Ngôn ngữ' : 'Language'}</span>
              <span className="ed-identity-value">{identity.language}</span>
            </div>
          </div>
        </div>

        <section className="ed-section ed-section--light ed-intro">
          <div className="ed-container">
            <div className="ed-intro__grid">
              <div className="ed-intro__text">
                <header className="ed-intro__header fade-up" style={{ marginBottom: '32px' }}>
                  <span className="ed-section-badge" style={{ margin: 0 }}>Hành trình di sản</span>
                  <h2 className="ed-section-title" style={{ textAlign: 'left', marginTop: '8px' }}>{overview.title}</h2>
                </header>
                <span className="ed-drop-cap">{(data.name || 'D')[0]}</span>
                <div className="ed-intro__body">
                  <p>{overview.content}</p>
                </div>
              </div>
              {overview.img ? (
                <div className="ed-intro__image">
                  <img src={overview.img} alt={overview.alt} onError={(event) => handleImageError(event, fallbacks.overview)} />
                </div>
              ) : null}
            </div>
          </div>
        </section>

        {/* HISTORY SECTION - NEW RICH CONTENT */}
        <section id="history" className="ed-section ed-section--cream">
          <div className="ed-container">
            <div className="ed-section-header">
              <span className="ed-section-badge">{lang === 'vi' ? 'Nguồn gốc' : 'Origin'}</span>
              <h2 className="ed-section-title">{history.title}</h2>
            </div>
            <div className="ed-section-content">
              <div className="ed-history-text">
                {history.content ? history.content.split('\n').map((para, i) => para.trim() && <p key={i}>{para}</p>) : (
                  <p>{lang === 'vi' ? `Lịch sử của ${fbName} là một hành trình dài gắn liền với sự hình thành và phát triển của vùng đất Việt Nam.` : `The history of the ${fbName} is a long journey associated with the formation and development of the Vietnamese land.`}</p>
                )}
              </div>

              <div className="ed-fun-facts">
                <div className="ed-fun-fact">
                  <h4>{lang === 'vi' ? 'Nhóm ngôn ngữ' : 'Language Group'}</h4>
                  <p>{identity.classification}</p>
                </div>
                <div className="ed-fun-fact">
                  <h4>{lang === 'vi' ? 'Nhà ở truyền thống' : 'Traditional Housing'}</h4>
                  <p>{sections.architecture.title || (lang === 'vi' ? 'Nhà sàn gỗ bền chắc, hòa hợp với thiên nhiên.' : 'Durable wooden stilt houses, in harmony with nature.')}</p>
                </div>
              </div>
            </div>
          </div>
        </section>

        {/* AI INSIGHT SECTION - NEW RICH CONTENT */}
        <section className="ed-section">
          <div className="ed-container">
            <div className="ed-ai-insight">
              <div className="ed-ai-header">
                <div className="ed-ai-avatar">✨</div>
                <div>
                  <h3 style={{ margin: 0, fontSize: '1.5rem', color: '#f59e0b' }}>{lang === 'vi' ? 'Góc nhìn từ Chuyên gia Văn hóa AI' : 'AI Cultural Expert Insight'}</h3>
                  <small style={{ color: 'rgba(255,255,255,0.6)' }}>{lang === 'vi' ? 'Phân tích tự động dựa trên tri thức di sản' : 'Automated analysis based on heritage knowledge'}</small>
                </div>
              </div>
              <div className="ed-ai-body">
                {aiLoading ? (
                  <div className="ed-ai-loading">{lang === 'vi' ? 'Đang kết nối với trí tuệ văn hóa...' : 'Connecting to cultural intelligence...'}</div>
                ) : aiInsight ? (
                  <p>"{aiInsight}"</p>
                ) : (
                  <p>{lang === 'vi' ? `Đang chuẩn bị những góc nhìn sâu sắc về di sản của ${fbName}...` : `Preparing deep insights into the heritage of ${fbName}...`}</p>
                )}
              </div>
            </div>
          </div>
        </section>

        {culture.imgHighlight || sections.textiles.length ? (
          <section className="ed-section ed-section--cream ed-textiles">
            <div className="ed-container">
              <header className="ed-section-header">
                <span className="ed-section-badge">Nghệ thuật đặc trưng</span>
                <h2 className="ed-section-title">{culture.title}</h2>
                <p className="ed-section-subtitle">{culture.content}</p>
              </header>

              {sections.textiles.length ? (
                <div className="ed-textiles-grid">
                  {sections.textiles.slice(0, 3).map((item, index) => (
                    <img key={item.id || index} src={item.imageUrl || culture.imgHighlight} alt={item.imageAlt || item.title || culture.imgAlt} className="ed-textile-img" onError={(event) => handleImageError(event, fallbacks.feature)} />
                  ))}
                </div>
              ) : culture.imgHighlight ? (
                <div className="ed-textiles-grid">
                  <img src={culture.imgHighlight} alt={culture.imgAlt} className="ed-textile-img" onError={(event) => handleImageError(event, fallbacks.feature)} />
                </div>
              ) : null}
            </div>
          </section>
        ) : null}

        {sections.festivals.length ? (
          <section className="ed-section ed-section--light ed-festivals">
            <div className="ed-container">
              <header className="ed-section-header">
                <span className="ed-section-badge">Di sản sống</span>
                <h2 className="ed-section-title">Lễ hội đặc sắc</h2>
              </header>

              <div className="ed-festival-grid">
                {sections.festivals.map((item, index) => (
                  <div className="ed-fest-card" key={item.id || item.code || index}>
                    {item.imageUrl ? <img src={item.imageUrl} alt={item.imageAlt || item.title || `Hình ảnh văn hóa ${fbName}`} className="ed-fest-img" onError={(event) => handleImageError(event, fallbacks.festival)} /> : null}
                    <div className="ed-fest-content">
                      <span className="ed-fest-tag">{item.tag || 'Lễ hội'}</span>
                      <h3 className="ed-fest-title">{item.title || 'Lễ hội truyền thống'}</h3>
                      <p className="ed-fest-desc">{item.description || 'Đây là một thực hành văn hóa quan trọng trong đời sống cộng đồng.'}</p>
                    </div>
                  </div>
                ))}
              </div>
            </div>
          </section>
        ) : null}

        {(sections.music?.imageUrl || fallbacks.music || customs.content) ? (
          <section id="customs" className="ed-section ed-section--cream ed-music">
            <div className="ed-container">
              <div className="ed-arch__grid">
                <div className="ed-arch-text">
                  <span className="ed-section-badge">{lang === 'vi' ? 'Bản sắc văn hóa' : 'Cultural Identity'}</span>
                  <h2 className="ed-section-title">{customs.title || (lang === 'vi' ? 'Phong tục & Tập quán' : 'Customs & Habits')}</h2>
                  <div className="ed-customs-text">
                    {customs.content ? customs.content.split('\n').map((para, i) => para.trim() && <p key={i}>{para}</p>) : (
                      <p>{sections.music.content}</p>
                    )}
                  </div>
                </div>
                <div className="ed-arch-image">
                  <img src={sections.music?.imageUrl || overview.img} alt={customs.title} className="ed-arch-img" onError={(event) => handleImageError(event, fallbacks.music)} />
                </div>
              </div>
            </div>
          </section>
        ) : null}

        {sections.cuisine.length ? (
          <section className="ed-section ed-section--light ed-cuisine">
            <div className="ed-container">
              <div className="ed-cuisine-grid">
                {sections.cuisine.slice(0, 3).map((item, index) => (
                  <div className="ed-cuisine-item" key={item.id || item.code || index}>
                    {item.imageUrl ? <img src={item.imageUrl} alt={item.imageAlt || item.title || `Hình ảnh văn hóa ${fbName}`} className="ed-cuisine-img" onError={(event) => handleImageError(event, fallbacks.cuisine)} /> : null}
                    <h3 className="ed-cuisine-title">{item.title || 'Món ăn truyền thống'}</h3>
                  </div>
                ))}
              </div>
            </div>
          </section>
        ) : null}

        {(sections.architecture?.imageUrl || geography.content) ? (
          <section id="geography" className="ed-section ed-section--cream ed-architecture">
            <div className="ed-container">
              <div className="ed-arch__grid">
                <div className="ed-arch-image">
                  <img src={sections.architecture?.imageUrl || overview.img} alt="Geography" className="ed-arch-img" />
                </div>
                <div className="ed-arch-text">
                  <span className="ed-section-badge">{lang === 'vi' ? 'Không gian sinh tồn' : 'Living Space'}</span>
                  <h2 className="ed-section-title">{geography.title}</h2>
                  <div className="ed-geography-text">
                    <p>{geography.content || identity.locationSummary}</p>
                    <p style={{ marginTop: '20px', fontStyle: 'italic', color: '#666' }}>
                      {lang === 'vi' ? `Vùng đất này đã nuôi dưỡng tâm hồn và bản sắc của người ${fbName} qua bao đời.` : `This land has nurtured the soul and identity of the ${fbName} for generations.`}
                    </p>
                  </div>
                </div>
              </div>
            </div>
          </section>
        ) : null}

        {gallery.length ? (
          <section className="ed-section ed-section--light ed-gallery">
            <div className="ed-container">
              <header className="ed-section-header">
                <h2 className="ed-section-title">Thư viện hình ảnh</h2>
                <p className="ed-section-subtitle">Những khoảnh khắc chân thực về đời sống và văn hóa của cộng đồng này.</p>
              </header>

              <div className="ed-gallery-grid">
                {gallery.map((item, index) => (
                  <div key={item.id || index} className={`ed-gallery-item ${item.size || ''}`.trim()}>
                    <img src={item.imageUrl} alt={item.imageAlt || `Hình ảnh văn hóa ${fbName}`} onError={(event) => handleImageError(event, fallbacks.gallery)} />
                  </div>
                ))}
              </div>
            </div>
          </section>
        ) : null}

        {related.length ? (
          <section className="ed-section ed-section--light">
            <div className="ed-container">
              <header className="ed-section-header">
                <h2 className="ed-section-title">Bài viết liên quan</h2>
              </header>
              <div className="ec-grid ec-grid--3cols fade-up">
                {related.slice(0, 3).map((article, index) => (
                  <Link to={article.code ? `/articles/${article.code}` : '/articles'} className="ec-scard" key={article.id || article.code || index}>
                    <div className="ec-scard__img">
                      {article.imageUrl ? <img src={article.imageUrl} alt={article.imageAlt || article.title || 'Hình minh họa bài viết liên quan'} loading="lazy" onError={(event) => handleImageError(event, fallbacks.gallery)} /> : null}
                    </div>
                    <div className="ec-scard__content">
                      <h3 className="ec-scard__title">{article.title}</h3>
                      <p className="ec-scard__desc">{article.description || 'Khám phá thêm những lát cắt văn hóa đặc sắc của cộng đồng dân tộc Việt Nam.'}</p>
                    </div>
                  </Link>
                ))}
              </div>
            </div>
          </section>
        ) : null}

        <section className="ed-cta-banner">
          <div className="ed-container">
            <h2 className="ed-cta-title" style={{ fontSize: '2.5rem' }}>{lang === 'vi' ? `Bạn muốn khám phá thêm các dân tộc khác?` : `Want to explore other ethnic groups?`}</h2>
            <Link to="/ethnic-groups" className="ed-back-btn" style={{ margin: '30px auto 0', background: '#f59e0b', color: '#1a0a04', padding: '15px 40px', fontSize: '1.1rem' }}>
              {lang === 'vi' ? 'Trở lại thư viện dân tộc' : 'Back to Ethnic Library'}
            </Link>
          </div>
        </section>
      </main>

      <Footer lang={lang} />
    </div>
  );
}

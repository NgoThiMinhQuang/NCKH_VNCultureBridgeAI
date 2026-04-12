import React, { useMemo, useState } from 'react';
import { Link, useParams } from 'react-router-dom';
import './EthnicCulturesDetailPage.css';
import PageHeader from '../../components/layout/PageHeader/PageHeader';
import Footer from '../../components/layout/Footer/Footer';
import LoadingState from '../../components/common/LoadingState/LoadingState';
import { getEthnicity } from '../../services/ethnicity.service';
import { useDetailLoader } from '../../hooks/useDetailLoader';
import {
  FiClock,
  FiMusic,
  FiCoffee,
  FiHome,
  FiImage,
  FiGlobe,
  FiArrowLeft,
} from 'react-icons/fi';

function getSectionTitle(section, fallback) {
  return section?.title || fallback;
}

export default function EthnicCulturesDetailPage() {
  const [lang, setLang] = useState('vi');
  const { code = 'hmong' } = useParams();
  const { status, data, error } = useDetailLoader(getEthnicity, lang, code);

  const navItems = useMemo(() => ([
    { icon: <FiClock />, label: lang === 'vi' ? 'Lịch sử' : 'History' },
    { icon: <FiGlobe />, label: lang === 'vi' ? 'Văn hóa' : 'Culture' },
    { icon: <FiMusic />, label: lang === 'vi' ? 'Lễ hội' : 'Festivals' },
    { icon: <FiCoffee />, label: lang === 'vi' ? 'Ẩm thực' : 'Cuisine' },
    { icon: <FiHome />, label: lang === 'vi' ? 'Kiến trúc' : 'Living Space' },
    { icon: <FiImage />, label: lang === 'vi' ? 'Thư viện' : 'Gallery' },
  ]), [lang]);

  if (status === 'loading') {
    return <LoadingState message={lang === 'vi' ? 'Đang tải dữ liệu dân tộc...' : 'Loading ethnic culture data...'} />;
  }

  if (status === 'error') {
    return <LoadingState type="error" message={lang === 'vi' ? 'Không tải được dữ liệu dân tộc.' : 'Could not load ethnic culture data.'} detail={error} />;
  }

  if (!data) {
    return <LoadingState type="error" message={lang === 'vi' ? 'Không tìm thấy dữ liệu dân tộc.' : 'Ethnic culture data not found.'} />;
  }

  const heroBackground = data.hero?.backgroundImageUrl || null;
  const heroForeground = data.hero?.foregroundImageUrl || null;
  const overviewImage = data.overview?.imageUrl || heroForeground || null;
  const featureHighlightImage = data.featureHighlight?.imageUrl || null;
  const textiles = data.sections?.textiles || [];
  const festivals = data.sections?.festivals || [];
  const cuisine = data.sections?.cuisine || [];
  const gallery = data.gallery || [];
  const relatedArticles = data.relatedArticles || [];
  const music = data.sections?.music || null;
  const architecture = data.sections?.architecture || null;

  return (
    <div className="page-shell">
      <PageHeader lang={lang} onLangChange={setLang} />

      <main className="ed-main">
        <section className="ed-hero">
          {heroBackground ? <div className="ed-hero__bg" style={{ backgroundImage: `url(${heroBackground})` }} aria-label={data.hero?.backgroundImageAlt || data.name}></div> : null}
          <div className="ed-hero__overlay"></div>
          <div className="ed-hero__ornament ed-hero__ornament--tl"></div>
          <div className="ed-hero__ornament ed-hero__ornament--br"></div>

          <div className="ed-hero__inner">
            <div className="ed-hero__left fade-up">
              <Link to="/ethnic-groups" className="ed-back-btn" aria-label="Quay lại" style={{ position: 'relative', top: 0, left: 0, display: 'inline-flex', marginBottom: '24px', width: 'fit-content' }}>
                <FiArrowLeft /> <span>{lang === 'vi' ? 'Quay lại' : 'Back'}</span>
              </Link>

              <div className="ed-hero__badge">
                <span className="ed-hero__badge-dot"></span>
                {data.hero?.badge || (lang === 'vi' ? 'Dân tộc Việt Nam' : 'Ethnic Cultures of Vietnam')}
              </div>

              <h1 className="ed-hero__title">{data.hero?.title || data.name}</h1>
              <p className="ed-hero__subtitle">{data.hero?.subtitle || data.description}</p>

              <div className="ed-hero__stats">
                {(data.hero?.stats || []).map((item, index) => (
                  <React.Fragment key={`${item.label}-${index}`}>
                    <div className="ed-hero__stat">
                      <strong>{item.value}</strong>
                      <span>{item.label}</span>
                    </div>
                    {index < (data.hero?.stats?.length || 0) - 1 ? <div className="ed-hero__stat-sep"></div> : null}
                  </React.Fragment>
                ))}
              </div>

              <nav className="ed-hero__nav-inline">
                {navItems.map((item, idx) => (
                  <div key={idx} className="ed-nav-item">
                    <div className="ed-nav-icon">{item.icon}</div>
                    <span className="ed-nav-label">{item.label}</span>
                  </div>
                ))}
              </nav>
            </div>

            {heroForeground ? (
              <div className="ed-hero__right fade-up delay-1">
                <div className="ed-hero__img-frame">
                  <img src={heroForeground} alt={data.hero?.foregroundImageAlt || data.name} className="ed-hero__img-main" />
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

        <section className="ed-section ed-section--light ed-intro">
          <div className="ed-container">
            <div className="ed-intro__grid">
              <div className="ed-intro__text">
                <header className="ed-intro__header fade-up" style={{ marginBottom: '32px' }}>
                  <span className="ed-section-badge" style={{ margin: 0 }}>Hành trình di sản</span>
                  <h2 className="ed-section-title" style={{ textAlign: 'left', marginTop: '8px' }}>{data.overview?.title || data.name}</h2>
                </header>
                <span className="ed-drop-cap">{(data.name || 'D')[0]}</span>
                <div className="ed-intro__body">
                  <p>{data.overview?.content || data.description}</p>
                </div>
              </div>
              {overviewImage ? (
                <div className="ed-intro__image">
                  <img src={overviewImage} alt={data.overview?.imageAlt || data.name} />
                </div>
              ) : null}
            </div>
          </div>
        </section>

        {featureHighlightImage ? (
          <section className="ed-section ed-section--cream ed-textiles">
            <div className="ed-container">
              <header className="ed-section-header">
                <span className="ed-section-badge">Nghệ thuật đặc trưng</span>
                <h2 className="ed-section-title">{getSectionTitle(data.sections?.culture, lang === 'vi' ? 'Đặc trưng văn hóa' : 'Cultural Identity')}</h2>
                <p className="ed-section-subtitle">{data.sections?.culture?.content || data.description}</p>
              </header>

              {textiles.length ? (
                <div className="ed-textiles-grid">
                  {textiles.slice(0, 3).map((item, index) => (
                    <img key={item.id || index} src={item.imageUrl} alt={item.imageAlt || item.title || data.name} className="ed-textile-img" />
                  ))}
                </div>
              ) : (
                <div className="ed-textiles-grid">
                  <img src={featureHighlightImage} alt={data.featureHighlight?.imageAlt || data.name} className="ed-textile-img" />
                </div>
              )}
            </div>
          </section>
        ) : null}

        {festivals.length ? (
          <section className="ed-section ed-section--light ed-festivals">
            <div className="ed-container">
              <header className="ed-section-header">
                <span className="ed-section-badge">Di sản sống</span>
                <h2 className="ed-section-title">{lang === 'vi' ? 'Lễ hội đặc sắc' : 'Featured Festivals'}</h2>
              </header>

              <div className="ed-festival-grid">
                {festivals.map((item, index) => (
                  <div className="ed-fest-card" key={item.id || item.code || index}>
                    {item.imageUrl ? <img src={item.imageUrl} alt={item.imageAlt || item.title} className="ed-fest-img" /> : null}
                    <div className="ed-fest-content">
                      <span className="ed-fest-tag">{item.tag || (lang === 'vi' ? 'Lễ hội' : 'Festival')}</span>
                      <h3 className="ed-fest-title">{item.title}</h3>
                      <p className="ed-fest-desc">{item.description}</p>
                    </div>
                  </div>
                ))}
              </div>
            </div>
          </section>
        ) : null}

        {music?.imageUrl ? (
          <section className="ed-section ed-section--cream ed-music">
            <div className="ed-container">
              <div className="ed-arch__grid">
                <div className="ed-arch-text">
                  <span className="ed-section-badge">Âm vang núi rừng</span>
                  <h2 className="ed-section-title">{music.title || (lang === 'vi' ? 'Âm thanh & nghệ thuật trình diễn' : 'Music & Performing Arts')}</h2>
                  <p className="ed-intro__body">{music.content || data.description}</p>
                </div>
                <div className="ed-arch-image">
                  <img src={music.imageUrl} alt={music.imageAlt || data.name} className="ed-arch-img" />
                </div>
              </div>
            </div>
          </section>
        ) : null}

        {cuisine.length ? (
          <section className="ed-section ed-section--light ed-cuisine">
            <div className="ed-container">
              <div className="ed-cuisine-grid">
                {cuisine.slice(0, 3).map((item, index) => (
                  <div className="ed-cuisine-item" key={item.id || item.code || index}>
                    {item.imageUrl ? <img src={item.imageUrl} alt={item.imageAlt || item.title} className="ed-cuisine-img" /> : null}
                    <h3 className="ed-cuisine-title">{item.title}</h3>
                  </div>
                ))}
              </div>
            </div>
          </section>
        ) : null}

        {architecture?.imageUrl ? (
          <section className="ed-section ed-section--cream ed-architecture">
            <div className="ed-container">
              <div className="ed-arch__grid">
                <div className="ed-arch-image">
                  <img src={architecture.imageUrl} alt={architecture.imageAlt || data.name} className="ed-arch-img" />
                </div>
                <div className="ed-arch-text">
                  <span className="ed-section-badge">Không gian sống</span>
                  <h2 className="ed-section-title">{getSectionTitle(architecture, lang === 'vi' ? 'Không gian sống' : 'Living Space')}</h2>
                  <p className="ed-intro__body">{architecture.content || data.description}</p>
                </div>
              </div>
            </div>
          </section>
        ) : null}

        {gallery.length ? (
          <section className="ed-section ed-section--light ed-gallery">
            <div className="ed-container">
              <header className="ed-section-header">
                <h2 className="ed-section-title">{lang === 'vi' ? 'Thư viện hình ảnh' : 'Image Gallery'}</h2>
                <p className="ed-section-subtitle">{lang === 'vi' ? 'Những khoảnh khắc chân thực về đời sống và văn hóa của cộng đồng này.' : 'Authentic moments from the life and culture of this community.'}</p>
              </header>

              <div className="ed-gallery-grid">
                {gallery.map((item, index) => (
                  <div key={item.id || index} className={`ed-gallery-item ${item.size || ''}`.trim()}>
                    {item.imageUrl ? <img src={item.imageUrl} alt={item.imageAlt || data.name} /> : null}
                  </div>
                ))}
              </div>
            </div>
          </section>
        ) : null}

        {relatedArticles.length ? (
          <section className="ed-section ed-section--light">
            <div className="ed-container">
              <header className="ed-section-header">
                <h2 className="ed-section-title">{lang === 'vi' ? 'Bài viết liên quan' : 'Related Articles'}</h2>
              </header>
              <div className="ec-grid ec-grid--3cols fade-up">
                {relatedArticles.slice(0, 3).map((article, index) => (
                  <Link to={`/articles/${article.code}`} className="ec-scard" key={article.id || article.code || index}>
                    <div className="ec-scard__img">
                      {article.imageUrl ? <img src={article.imageUrl} alt={article.imageAlt || article.title} loading="lazy" /> : null}
                    </div>
                    <div className="ec-scard__content">
                      <h3 className="ec-scard__title">{article.title}</h3>
                      <p className="ec-scard__desc">{article.description}</p>
                    </div>
                  </Link>
                ))}
              </div>
            </div>
          </section>
        ) : null}

        <section className="ed-cta-banner">
          <div className="ed-container">
            <h2 className="ed-cta-title">{lang === 'vi' ? 'Khám phá thêm các dân tộc khác' : 'Explore More Ethnic Groups'}</h2>
            <Link to="/ethnic-groups" className="primary-button" style={{ marginTop: '20px', display: 'inline-flex' }}>
              {lang === 'vi' ? 'Trở lại thư viện dân tộc' : 'Back to ethnic library'}
            </Link>
          </div>
        </section>
      </main>

      <Footer lang={lang} />
    </div>
  );
}

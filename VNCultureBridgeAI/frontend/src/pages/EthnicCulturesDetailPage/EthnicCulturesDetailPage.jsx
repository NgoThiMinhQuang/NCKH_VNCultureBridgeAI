import React, { useMemo } from 'react';
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

const localEthnicImageByCode = {
  kinh: kinhImg,
  tay: ruongBacThangImg,
  hmong: hmongImg,
  dao: daoImg,
  ede: edeImg,
  khmer: khmerImg,
  cham: chamImg,
  muong: muongImg,
};

const sectionFallbackByCode = {
  kinh: {
    heroBackground: banner3,
    heroForeground: kinhImg,
    overview: kinhImg,
    feature: artAoDaiImg,
    music: hatQuanHoImg,
    cuisine: phoImg,
    architecture: ruongBacThangImg,
    festival: banner3,
    gallery: kinhImg,
  },
  tay: {
    heroBackground: ruongBacThangImg,
    heroForeground: ruongBacThangImg,
    overview: ruongBacThangImg,
    feature: ruongBacThangImg,
    music: ruongBacThangImg,
    cuisine: phoImg,
    architecture: ruongBacThangImg,
    festival: ruongBacThangImg,
    gallery: ruongBacThangImg,
  },
  hmong: {
    heroBackground: banner3,
    heroForeground: hmongImg,
    overview: hmongImg,
    feature: detThoCamImg,
    music: congChiengImg,
    cuisine: phoImg,
    architecture: ruongBacThangImg,
    festival: leCapSacImg,
    gallery: hmongImg,
  },
  dao: {
    heroBackground: banner3,
    heroForeground: daoImg,
    overview: daoImg,
    feature: leCapSacImg,
    music: leCapSacImg,
    cuisine: phoImg,
    architecture: ruongBacThangImg,
    festival: leCapSacImg,
    gallery: daoImg,
  },
  khmer: {
    heroBackground: banner3,
    heroForeground: khmerImg,
    overview: khmerImg,
    feature: muaTrongImg,
    music: muaTrongImg,
    cuisine: phoImg,
    architecture: ruongBacThangImg,
    festival: muaTrongImg,
    gallery: khmerImg,
  },
  cham: {
    heroBackground: banner3,
    heroForeground: chamImg,
    overview: chamImg,
    feature: detThoCamImg,
    music: detThoCamImg,
    cuisine: phoImg,
    architecture: ruongBacThangImg,
    festival: chamImg,
    gallery: chamImg,
  },
  ede: {
    heroBackground: banner3,
    heroForeground: edeImg,
    overview: edeImg,
    feature: congChiengImg,
    music: congChiengImg,
    cuisine: phoImg,
    architecture: ruongBacThangImg,
    festival: congChiengImg,
    gallery: edeImg,
  },
};

function normalizeValue(value) {
  return String(value || '')
    .normalize('NFD')
    .replace(/[\u0300-\u036f]/g, '')
    .replace(/đ/g, 'd')
    .replace(/Đ/g, 'D')
    .toLowerCase()
    .trim();
}

function getSectionTitle(section, fallback) {
  return section?.title || fallback;
}

function getEthnicCode(data, code) {
  return normalizeValue(data?.code || data?.rawCode || code || '');
}

function getLocalFallbackSet(data, code) {
  const ethnicCode = getEthnicCode(data, code);
  return sectionFallbackByCode[ethnicCode] || {
    heroBackground: banner3,
    heroForeground: localEthnicImageByCode[ethnicCode] || hmongImg,
    overview: localEthnicImageByCode[ethnicCode] || hmongImg,
    feature: localEthnicImageByCode[ethnicCode] || hmongImg,
    music: localEthnicImageByCode[ethnicCode] || hmongImg,
    cuisine: phoImg,
    architecture: ruongBacThangImg,
    festival: localEthnicImageByCode[ethnicCode] || hmongImg,
    gallery: localEthnicImageByCode[ethnicCode] || hmongImg,
  };
}

function handleImageError(event, fallbackSrc) {
  if (fallbackSrc && event.currentTarget.src !== fallbackSrc) {
    event.currentTarget.src = fallbackSrc;
  }
}

export default function EthnicCulturesDetailPage() {
  const lang = 'vi';
  const { code = 'hmong' } = useParams();
  const { status, data, error } = useDetailLoader(getEthnicity, lang, code);

  const navItems = useMemo(() => ([
    { icon: <FiClock />, label: 'Lịch sử' },
    { icon: <FiGlobe />, label: 'Văn hóa' },
    { icon: <FiMusic />, label: 'Lễ hội' },
    { icon: <FiCoffee />, label: 'Ẩm thực' },
    { icon: <FiHome />, label: 'Kiến trúc' },
    { icon: <FiImage />, label: 'Thư viện' },
  ]), []);

  if (status === 'loading') {
    return <LoadingState message="Đang tải dữ liệu dân tộc..." />;
  }

  if (status === 'error') {
    return <LoadingState type="error" message="Không tải được dữ liệu dân tộc." detail={error} />;
  }

  if (!data) {
    return <LoadingState type="error" message="Không tìm thấy dữ liệu dân tộc." />;
  }

  const fallbackSet = getLocalFallbackSet(data, code);

  const heroBackground = data.hero?.backgroundImageUrl || fallbackSet.heroBackground;
  const heroForeground = data.hero?.foregroundImageUrl || fallbackSet.heroForeground;
  const overviewImage = data.overview?.imageUrl || heroForeground || fallbackSet.overview;
  const featureHighlightImage = data.featureHighlight?.imageUrl || fallbackSet.feature;
  const textiles = (data.sections?.textiles || []).filter((item) => item?.imageUrl || featureHighlightImage);
  const festivals = (data.sections?.festivals || []).filter((item) => item?.title || item?.description || item?.imageUrl);
  const cuisine = (data.sections?.cuisine || []).filter((item) => item?.title || item?.imageUrl);
  const gallery = (data.gallery || []).filter((item) => item?.imageUrl);
  const relatedArticles = (data.relatedArticles || []).filter((item) => item?.title || item?.description || item?.imageUrl);
  const music = data.sections?.music || null;
  const architecture = data.sections?.architecture || null;

  const fallbackName = data.name || 'dân tộc Việt Nam';
  const heroBadge = data.hero?.badge || 'Dân tộc Việt Nam';
  const heroTitle = data.hero?.title || data.name || 'Dân tộc Việt Nam';
  const heroSubtitle = data.hero?.subtitle || data.description || 'Khám phá bản sắc, ký ức và không gian sống của cộng đồng dân tộc Việt Nam.';
  const heroBackgroundAlt = data.hero?.backgroundImageAlt || `Không gian văn hóa của ${fallbackName}`;
  const heroForegroundAlt = data.hero?.foregroundImageAlt || `Hình ảnh đại diện của ${fallbackName}`;
  const overviewTitle = data.overview?.title || data.name || 'Giới thiệu';
  const overviewContent = data.overview?.content || data.description || 'Thông tin đang được cập nhật.';
  const overviewImageAlt = data.overview?.imageAlt || `Hình giới thiệu về ${fallbackName}`;
  const cultureTitle = getSectionTitle(data.sections?.culture, 'Đặc trưng văn hóa');
  const cultureContent = data.sections?.culture?.content || data.description || 'Những giá trị văn hóa nổi bật đang được lưu giữ qua nhiều thế hệ.';
  const featureImageAlt = data.featureHighlight?.imageAlt || `Nét văn hóa tiêu biểu của ${fallbackName}`;
  const musicTitle = music?.title || 'Âm thanh & nghệ thuật trình diễn';
  const musicContent = music?.content || data.description || 'Những âm thanh và tiết mục trình diễn gắn liền với đời sống cộng đồng.';
  const architectureTitle = getSectionTitle(architecture, 'Không gian sống');
  const architectureContent = architecture?.content || data.description || 'Không gian cư trú phản ánh điều kiện tự nhiên và tập quán sống của cộng đồng.';
  const architectureImageAlt = architecture?.imageAlt || `Không gian sống của ${fallbackName}`;
  const musicImageAlt = music?.imageAlt || `Âm nhạc và nghệ thuật trình diễn của ${fallbackName}`;
  const fallbackGalleryAlt = `Hình ảnh văn hóa ${fallbackName}`;
  const fallbackArticleAlt = 'Hình minh họa bài viết liên quan';

  return (
    <div className="page-shell">
      <PageHeader lang={lang} onLangChange={() => {}} />

      <main className="ed-main">
        <section className="ed-hero">
          {heroBackground ? <div className="ed-hero__bg" style={{ backgroundImage: `url(${heroBackground})` }} aria-label={heroBackgroundAlt}></div> : null}
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
                {heroBadge}
              </div>

              <h1 className="ed-hero__title">{heroTitle}</h1>
              <p className="ed-hero__subtitle">{heroSubtitle}</p>

              {(data.hero?.stats || []).length ? (
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
              ) : null}

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
                  <img src={heroForeground} alt={heroForegroundAlt} className="ed-hero__img-main" onError={(event) => handleImageError(event, fallbackSet.heroForeground)} />
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
                  <h2 className="ed-section-title" style={{ textAlign: 'left', marginTop: '8px' }}>{overviewTitle}</h2>
                </header>
                <span className="ed-drop-cap">{(data.name || 'D')[0]}</span>
                <div className="ed-intro__body">
                  <p>{overviewContent}</p>
                </div>
              </div>
              {overviewImage ? (
                <div className="ed-intro__image">
                  <img src={overviewImage} alt={overviewImageAlt} onError={(event) => handleImageError(event, fallbackSet.overview)} />
                </div>
              ) : null}
            </div>
          </div>
        </section>

        {featureHighlightImage || textiles.length ? (
          <section className="ed-section ed-section--cream ed-textiles">
            <div className="ed-container">
              <header className="ed-section-header">
                <span className="ed-section-badge">Nghệ thuật đặc trưng</span>
                <h2 className="ed-section-title">{cultureTitle}</h2>
                <p className="ed-section-subtitle">{cultureContent}</p>
              </header>

              {textiles.length ? (
                <div className="ed-textiles-grid">
                  {textiles.slice(0, 3).map((item, index) => (
                    <img key={item.id || index} src={item.imageUrl || featureHighlightImage} alt={item.imageAlt || item.title || featureImageAlt} className="ed-textile-img" onError={(event) => handleImageError(event, fallbackSet.feature)} />
                  ))}
                </div>
              ) : featureHighlightImage ? (
                <div className="ed-textiles-grid">
                  <img src={featureHighlightImage} alt={featureImageAlt} className="ed-textile-img" onError={(event) => handleImageError(event, fallbackSet.feature)} />
                </div>
              ) : null}
            </div>
          </section>
        ) : null}

        {festivals.length ? (
          <section className="ed-section ed-section--light ed-festivals">
            <div className="ed-container">
              <header className="ed-section-header">
                <span className="ed-section-badge">Di sản sống</span>
                <h2 className="ed-section-title">Lễ hội đặc sắc</h2>
              </header>

              <div className="ed-festival-grid">
                {festivals.map((item, index) => (
                  <div className="ed-fest-card" key={item.id || item.code || index}>
                    {item.imageUrl ? <img src={item.imageUrl} alt={item.imageAlt || item.title || fallbackGalleryAlt} className="ed-fest-img" onError={(event) => handleImageError(event, fallbackSet.festival)} /> : null}
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

        {(music?.imageUrl || fallbackSet.music) ? (
          <section className="ed-section ed-section--cream ed-music">
            <div className="ed-container">
              <div className="ed-arch__grid">
                <div className="ed-arch-text">
                  <span className="ed-section-badge">Âm vang núi rừng</span>
                  <h2 className="ed-section-title">{musicTitle}</h2>
                  <p className="ed-intro__body">{musicContent}</p>
                </div>
                <div className="ed-arch-image">
                  <img src={music?.imageUrl || fallbackSet.music} alt={musicImageAlt} className="ed-arch-img" onError={(event) => handleImageError(event, fallbackSet.music)} />
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
                    {item.imageUrl ? <img src={item.imageUrl} alt={item.imageAlt || item.title || fallbackGalleryAlt} className="ed-cuisine-img" onError={(event) => handleImageError(event, fallbackSet.cuisine)} /> : null}
                    <h3 className="ed-cuisine-title">{item.title || 'Món ăn truyền thống'}</h3>
                  </div>
                ))}
              </div>
            </div>
          </section>
        ) : null}

        {(architecture?.imageUrl || fallbackSet.architecture) ? (
          <section className="ed-section ed-section--cream ed-architecture">
            <div className="ed-container">
              <div className="ed-arch__grid">
                <div className="ed-arch-image">
                  <img src={architecture?.imageUrl || fallbackSet.architecture} alt={architectureImageAlt} className="ed-arch-img" onError={(event) => handleImageError(event, fallbackSet.architecture)} />
                </div>
                <div className="ed-arch-text">
                  <span className="ed-section-badge">Không gian sống</span>
                  <h2 className="ed-section-title">{architectureTitle}</h2>
                  <p className="ed-intro__body">{architectureContent}</p>
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
                    <img src={item.imageUrl} alt={item.imageAlt || fallbackGalleryAlt} onError={(event) => handleImageError(event, fallbackSet.gallery)} />
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
                <h2 className="ed-section-title">Bài viết liên quan</h2>
              </header>
              <div className="ec-grid ec-grid--3cols fade-up">
                {relatedArticles.slice(0, 3).map((article, index) => (
                  <Link to={article.code ? `/articles/${article.code}` : '/articles'} className="ec-scard" key={article.id || article.code || index}>
                    <div className="ec-scard__img">
                      {article.imageUrl ? <img src={article.imageUrl} alt={article.imageAlt || article.title || fallbackArticleAlt} loading="lazy" onError={(event) => handleImageError(event, fallbackSet.gallery)} /> : null}
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
            <h2 className="ed-cta-title">Khám phá thêm các dân tộc khác</h2>
            <Link to="/ethnic-groups" className="primary-button" style={{ marginTop: '20px', display: 'inline-flex' }}>
              Trở lại thư viện dân tộc
            </Link>
          </div>
        </section>
      </main>

      <Footer lang={lang} />
    </div>
  );
}

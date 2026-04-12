import React, { useEffect, useMemo, useState } from 'react';
import { Link } from 'react-router-dom';
import { LuSearch, LuChevronDown, LuShirt, LuStar, LuUtensils, LuBookOpen } from 'react-icons/lu';
import './EthnicCulturesPage.css';
import PageHeader from '../../components/layout/PageHeader/PageHeader';
import Footer from '../../components/layout/Footer/Footer';
import { getEthnicities } from '../../services/ethnicity.service';

function getFeatureIcon(index) {
  const icons = [LuShirt, LuStar, LuUtensils, LuBookOpen];
  return icons[index % icons.length];
}

export default function EthnicCultures() {
  const [lang, setLang] = useState('vi');
  const [payload, setPayload] = useState(null);
  const [status, setStatus] = useState('loading');
  const [error, setError] = useState('');
  const [activeFilter, setActiveFilter] = useState('Tất cả vùng');
  const [isDropdownOpen, setIsDropdownOpen] = useState(false);
  const [activeRegion, setActiveRegion] = useState('Tất cả vùng');
  const [isRegionOpen, setIsRegionOpen] = useState(false);
  const [activeHeroEthnic, setActiveHeroEthnic] = useState('Tất cả dân tộc');
  const [isHeroEthnicOpen, setIsHeroEthnicOpen] = useState(false);
  const [searchQuery, setSearchQuery] = useState('');
  const [currentPage, setCurrentPage] = useState(1);
  const ITEMS_PER_PAGE = 8;

  useEffect(() => {
    let ignore = false;

    async function load() {
      try {
        setStatus('loading');
        setError('');
        const data = await getEthnicities(lang);
        if (!ignore) {
          setPayload(data);
          setStatus('success');
        }
      } catch (err) {
        if (!ignore) {
          setError(err.message || 'Không thể tải dữ liệu dân tộc.');
          setStatus('error');
        }
      }
    }

    load();
    return () => {
      ignore = true;
    };
  }, [lang]);

  const safePayload = payload || {
    hero: {
      backgroundImageUrl: null,
      backgroundImageAlt: '',
      foregroundImageUrl: null,
      foregroundImageAlt: '',
    },
    stats: {
      ethnicGroupCount: 0,
      regionCount: 0,
      articleCount: 0,
      galleryCount: 0,
    },
    ethnicities: [],
    filters: {
      regions: ['Tất cả vùng'],
      ethnicities: ['Tất cả dân tộc'],
    },
    sections: {
      features: [],
      stories: [],
      gallery: [],
    },
  };

  const stats = useMemo(() => ([
    { value: String(safePayload.stats.ethnicGroupCount || 0), label: 'Dân tộc', subtext: 'đa dạng và phong phú bản sắc văn hóa' },
    { value: String(safePayload.stats.regionCount || 0), label: 'Vùng văn hóa', subtext: 'với những đặc trưng địa hình, khí hậu' },
    { value: String(safePayload.stats.articleCount || 0), label: 'Bài viết', subtext: 'phản ánh đời sống và ký ức cộng đồng' },
    { value: String(safePayload.stats.galleryCount || 0), label: 'Hình ảnh', subtext: 'ghi lại những khoảnh khắc văn hóa sống động' },
  ]), [safePayload.stats]);

  const heroSubtitle = safePayload.hero?.subtitle || 'Từ những đỉnh núi mờ sương Tây Bắc đến những bản làng yên bình nơi đồng bằng, khám phá sự đa dạng và giàu có của văn hóa 54 dân tộc anh em.';

  const regions = safePayload.filters?.regions?.length ? safePayload.filters.regions : ['Tất cả vùng'];
  const heroEthnicGroups = safePayload.filters?.ethnicities?.length ? safePayload.filters.ethnicities : ['Tất cả dân tộc'];
  const ethnicCards = safePayload.ethnicities || [];
  const features = safePayload.sections?.features || [];
  const stories = safePayload.sections?.stories || [];
  const masonryImages = safePayload.sections?.gallery || [];

  const filteredCards = ethnicCards.filter((item) => {
    const name = String(item.name || '').toLowerCase();
    const region = String(item.region || '').toLowerCase();
    const query = searchQuery.trim().toLowerCase();
    const filterRegion = activeFilter.toLowerCase();
    const heroRegion = activeRegion.toLowerCase();
    const heroEthnic = activeHeroEthnic.toLowerCase();

    const matchRegionFilter = filterRegion === 'tất cả vùng' || filterRegion === 'all regions' ? true : region === filterRegion;
    const matchHeroRegion = heroRegion === 'tất cả vùng' || heroRegion === 'all regions' ? true : region === heroRegion;
    const matchHeroEthnic = heroEthnic === 'tất cả dân tộc' || heroEthnic === 'all ethnic groups' ? true : name.includes(heroEthnic);
    const matchSearchQuery = query === '' ? true : name.includes(query) || region.includes(query);

    return matchRegionFilter && matchHeroRegion && matchHeroEthnic && matchSearchQuery;
  });

  const totalPages = Math.ceil(filteredCards.length / ITEMS_PER_PAGE) || 1;
  const startIndex = (currentPage - 1) * ITEMS_PER_PAGE;
  const currentCards = filteredCards.slice(startIndex, startIndex + ITEMS_PER_PAGE);
  const featureHighlight = features[0] || null;
  const featureList = features.slice(0, 4);
  const heroBackground = safePayload.hero?.backgroundImageUrl || null;
  const heroForeground = safePayload.hero?.foregroundImageUrl || null;

  const handlePageChange = (page) => {
    setCurrentPage(page);
    window.scrollTo({
      top: document.getElementById('ethnic-grid-section')?.offsetTop - 80 || 0,
      behavior: 'smooth',
    });
  };

  return (
    <div className="ec-page-shell">
      <PageHeader lang={lang} onLangChange={setLang} />

      <main className="ec-main">
        <section className="ec-hero">
          {heroBackground ? <div className="ec-hero__bg" style={{ backgroundImage: `url(${heroBackground})` }} aria-label={safePayload.hero?.backgroundImageAlt || 'Ethnic cultures background'}></div> : null}
          <div className="ec-hero__overlay"></div>
          <div className="ec-hero__ornament ec-hero__ornament--tl"></div>
          <div className="ec-hero__ornament ec-hero__ornament--br"></div>

          <div className="ec-hero__inner">
            <div className="ec-hero__left fade-up">
              <div className="ec-hero__badge">
                <span className="ec-hero__badge-dot"></span>
                Khám phá dải đất hình chữ S
              </div>

              <h1 className="ec-hero__title">
                <span className="ec-hero__title-line">Văn Hóa</span>
                <span className="ec-hero__title-accent">Các Dân Tộc</span>
                <span className="ec-hero__title-line">Việt Nam</span>
              </h1>

              <div className="ec-hero__divider-row">
                <span className="ec-hero__divider-line"></span>
                <span className="ec-hero__divider-diamond">◆</span>
                <span className="ec-hero__divider-line"></span>
              </div>

              <p className="ec-hero__subtitle">
                {heroSubtitle}
              </p>

              <div className="ec-hero__stats">
                {stats.slice(0, 3).map((item, index) => (
                  <React.Fragment key={item.label}>
                    <div className="ec-hero__stat">
                      <strong>{item.value}</strong>
                      <span>{item.label}</span>
                    </div>
                    {index < 2 ? <div className="ec-hero__stat-sep">|</div> : null}
                  </React.Fragment>
                ))}
              </div>

              <div className="ec-hero__search-bar">
                <div className="ec-search-field-wrapper" style={{ flex: 1.2 }}>
                  <div className="ec-search-field" style={{ paddingLeft: '24px' }}>
                    <LuSearch className="ec-search-icon" />
                    <input
                      type="text"
                      placeholder="Tìm kiếm dân tộc..."
                      value={searchQuery}
                      onChange={(e) => {
                        setSearchQuery(e.target.value);
                        setCurrentPage(1);
                      }}
                    />
                  </div>
                </div>

                <div className="ec-search-divider" />

                <div className="ec-search-field-wrapper">
                  <div
                    className={`ec-search-field ${isRegionOpen ? 'active' : ''}`}
                    onClick={() => {
                      setIsRegionOpen(!isRegionOpen);
                      setIsHeroEthnicOpen(false);
                    }}
                  >
                    <span>{activeRegion === 'Tất cả vùng' ? 'Vùng' : activeRegion}</span>
                    <LuChevronDown className={`ec-chevron-icon ${isRegionOpen ? 'rotate' : ''}`} />
                  </div>

                  {isRegionOpen && (
                    <ul className="ec-hero-dropdown">
                      {regions.map((region) => (
                        <li
                          key={region}
                          onClick={() => {
                            setActiveRegion(region);
                            setCurrentPage(1);
                            setIsRegionOpen(false);
                          }}
                        >
                          {region}
                        </li>
                      ))}
                    </ul>
                  )}
                </div>

                <div className="ec-search-divider" />

                <div className="ec-search-field-wrapper">
                  <div
                    className={`ec-search-field ${isHeroEthnicOpen ? 'active' : ''}`}
                    onClick={() => {
                      setIsHeroEthnicOpen(!isHeroEthnicOpen);
                      setIsRegionOpen(false);
                    }}
                  >
                    <span>{activeHeroEthnic === 'Tất cả dân tộc' ? 'Dân tộc' : activeHeroEthnic}</span>
                    <LuChevronDown className={`ec-chevron-icon ${isHeroEthnicOpen ? 'rotate' : ''}`} />
                  </div>

                  {isHeroEthnicOpen && (
                    <ul className="ec-hero-dropdown">
                      {heroEthnicGroups.map((ethnicity) => (
                        <li
                          key={ethnicity}
                          onClick={() => {
                            setActiveHeroEthnic(ethnicity);
                            setCurrentPage(1);
                            setIsHeroEthnicOpen(false);
                          }}
                        >
                          {ethnicity}
                        </li>
                      ))}
                    </ul>
                  )}
                </div>
              </div>

              {status === 'error' ? <p className="ec-text-light-muted" style={{ marginTop: '16px' }}>{error}</p> : null}
            </div>

            {heroForeground ? (
              <div className="ec-hero__right fade-up delay-1">
                <div className="ec-hero__img-frame">
                  <img src={heroForeground} alt={safePayload.hero?.foregroundImageAlt || 'Ethnic cultures hero'} className="ec-hero__img-main" />
                  <div className="ec-hero__img-ring"></div>
                </div>
              </div>
            ) : null}
          </div>
        </section>

        <section className="ec-section ec-section--light" id="ethnic-grid-section">
          <div className="ec-container">
            <div className="ec-section-header ec-center">
              <span className="ec-section-eyebrow">Cộng đồng 54 dân tộc</span>
              <h2 className="ec-section-title">Các dân tộc Việt Nam</h2>
              <p className="ec-section-desc">
                Mỗi dân tộc là một nét riêng về văn hóa độc đáo, góp phần tạo nên sự đa dạng và phong phú của đất nước.
              </p>
            </div>

            <div className="ec-center-action" style={{ marginTop: '8px', marginBottom: '32px' }}>
              <div className="ec-dropdown-wrap">
                <div className={`ec-dropdown-trigger ${isDropdownOpen ? 'active' : ''}`} onClick={() => setIsDropdownOpen(!isDropdownOpen)}>
                  {activeFilter}
                  <span className="ec-dropdown-arrow">▼</span>
                </div>
                {isDropdownOpen && (
                  <ul className="ec-dropdown-list">
                    {regions.map((r) => (
                      <li
                        key={r}
                        className={`ec-dropdown-item ${activeFilter === r ? 'selected' : ''}`}
                        onClick={() => {
                          setActiveFilter(r);
                          setCurrentPage(1);
                          setIsDropdownOpen(false);
                        }}
                      >
                        {r}
                      </li>
                    ))}
                  </ul>
                )}
              </div>
            </div>

            {status === 'loading' ? <p className="ec-section-desc">Đang mở ra kho tư liệu về các dân tộc Việt Nam...</p> : null}

            <div className="ec-grid ec-grid--4cols fade-up">
              {currentCards.map((c) => (
                <Link to={`/ethnic-groups/${c.code || c.id}`} className="ec-card" key={c.code || c.id}>
                  <div className="ec-card__img-wrap">
                    {c.status ? <span className="ec-card__status">{c.status}</span> : null}
                    {c.cardImageUrl ? <img src={c.cardImageUrl} alt={c.cardImageAlt || c.name} loading="lazy" /> : null}
                  </div>
                  <div className="ec-card__content">
                    <p className="ec-card__loc">
                      <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2"><path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z"></path><circle cx="12" cy="10" r="3"></circle></svg>
                      {c.location || 'Đang cập nhật'}
                    </p>
                    <h3 className="ec-card__title">{c.name}</h3>
                    <span className="ec-card__link">Xem chi tiết</span>
                  </div>
                </Link>
              ))}
            </div>

            {!currentCards.length && status === 'success' ? (
              <p className="ec-section-desc" style={{ marginTop: '32px' }}>Không tìm thấy dân tộc phù hợp với bộ lọc hiện tại.</p>
            ) : null}

            {totalPages > 1 && (
              <div className="ec-pagination fade-up">
                <button
                  className="ec-pagination__btn ec-pagination__nav"
                  disabled={currentPage === 1}
                  onClick={() => handlePageChange(Math.max(1, currentPage - 1))}
                  aria-label="Trang trước"
                >
                  ‹
                </button>

                <div className="ec-pagination__pages">
                  {Array.from({ length: totalPages }, (_, i) => i + 1)
                    .filter((page) => page <= 2 || page === totalPages || Math.abs(page - currentPage) <= 1)
                    .map((page, index, arr) => (
                      <React.Fragment key={page}>
                        {index > 0 && page - arr[index - 1] > 1 ? <span className="ec-pagination__ellipsis">…</span> : null}
                        <button className={`ec-pagination__btn ${currentPage === page ? 'active' : ''}`} onClick={() => handlePageChange(page)}>
                          {page}
                        </button>
                      </React.Fragment>
                    ))}
                </div>

                <button
                  className="ec-pagination__btn ec-pagination__nav"
                  disabled={currentPage === totalPages}
                  onClick={() => handlePageChange(Math.min(totalPages, currentPage + 1))}
                  aria-label="Trang sau"
                >
                  ›
                </button>
              </div>
            )}
          </div>
        </section>

        {featureHighlight?.imageUrl ? (
          <section className="ec-section ec-section--cream ec-section--wavy">
            <div className="ec-section-wave ec-section-wave--top">
              <svg data-name="Layer 1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1200 120" preserveAspectRatio="none">
                <path d="M321.39,56.44c58-10.79,114.16-30.13,172-41.86,82.39-16.72,168.19-17.73,250.45-.39C823.78,31,906.67,72,985.66,92.83c70.05,18.48,146.53,26.09,214.34,3V0H0V27.35A600.21,600.21,0,0,0,321.39,56.44Z" fill="#ffffff"></path>
              </svg>
            </div>

            <div className="ec-container ec-feature-split">
              <div className="ec-feature-img-wrapper fade-up">
                <div className="ec-feature-img-frame">
                  <img src={featureHighlight.imageUrl} alt={featureHighlight.imageAlt || featureHighlight.title} />
                </div>
                <div className="ec-feature-img-tag glass-panel">
                  <div className="ec-tag-icon"><LuStar /></div>
                  <div className="ec-tag-text">
                    <strong>{featureHighlight.title || 'Di sản văn hóa tiêu biểu'}</strong>
                    <span>{featureHighlight.description || 'Những lớp ký ức và tri thức truyền đời được gìn giữ qua không gian sống, nghi lễ và tập quán cộng đồng.'}</span>
                  </div>
                </div>
              </div>

              <div className="ec-feature-text fade-up delay-1">
                <span className="ec-badge ec-badge--accent">Văn hóa tiêu biểu</span>
                <h2 className="ec-section-title">Nét văn hóa tiêu biểu<br />của các dân tộc</h2>
                <p className="ec-feature-desc">Mỗi dân tộc Việt Nam mang trong mình một kho tàng văn hóa vô giá, được bồi đắp qua nhiều thế hệ. Từ trang phục, lễ hội đến phong tục và nghệ thuật, mỗi nét riêng đều góp phần làm nên diện mạo phong phú của văn hóa Việt Nam.</p>

                <ul className="ec-feature-list">
                  {featureList.map((item, index) => {
                    const Icon = getFeatureIcon(index);
                    return (
                      <li className="ec-feature-item" key={item.id || item.code || index}>
                        <div className={`ec-fi-icon ec-fi-icon--${['red', 'orange', 'brown', 'green'][index % 4]}`}><Icon /></div>
                        <div className="ec-fi-content">
                          <h4>{item.title}</h4>
                          <p>{item.description || 'Những thực hành văn hóa này phản ánh cách cộng đồng lưu giữ ký ức, nếp sống và quan niệm thẩm mỹ trong đời sống thường nhật.'}</p>
                        </div>
                      </li>
                    );
                  })}
                </ul>
              </div>
            </div>

            <div className="ec-section-wave ec-section-wave--bottom">
              <svg data-name="Layer 1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1200 120" preserveAspectRatio="none">
                <path d="M321.39,56.44c58-10.79,114.16-30.13,172-41.86,82.39-16.72,168.19-17.73,250.45-.39C823.78,31,906.67,72,985.66,92.83c70.05,18.48,146.53,26.09,214.34,3V0H0V27.35A600.21,600.21,0,0,0,321.39,56.44Z" fill="#ffffff"></path>
              </svg>
            </div>
          </section>
        ) : null}

        {features.length ? (
          <section className="ec-section ec-section--light">
            <div className="ec-container">
              <div className="ec-section-header ec-flex-header">
                <div>
                  <span className="ec-section-eyebrow">Di sản độc đáo</span>
                  <h2 className="ec-section-title">Những nét văn hóa<br />đặc sắc nhất</h2>
                </div>
              </div>

              <div className="ec-grid ec-grid--3cols fade-up">
                {features.map((f, index) => (
                  <div className="ec-hcard" key={f.id || f.code || index}>
                    <div className="ec-hcard__img">
                      {f.tag ? <span className="ec-card__status">{f.tag}</span> : null}
                      {f.imageUrl ? <img src={f.imageUrl} alt={f.imageAlt || f.title} loading="lazy" /> : null}
                    </div>
                    <div className="ec-hcard__content">
                      <h3 className="ec-hcard__title">{f.title}</h3>
                      <p className="ec-hcard__desc">{f.description || 'Khám phá nét độc đáo trong đời sống và tinh thần của cộng đồng dân tộc.'}</p>
                      {f.code ? <Link to={`/articles/${f.code}`} className="ec-card__link">Tìm hiểu</Link> : <span className="ec-card__link">Tìm hiểu</span>}
                    </div>
                  </div>
                ))}
              </div>
            </div>
          </section>
        ) : null}

        {masonryImages.length ? (
          <section className="ec-section ec-section--cream ec-section--wavy" id="ethnic-gallery-section">
            <div className="ec-section-wave ec-section-wave--top">
              <svg data-name="Layer 1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1200 120" preserveAspectRatio="none">
                <path d="M321.39,56.44c58-10.79,114.16-30.13,172-41.86,82.39-16.72,168.19-17.73,250.45-.39C823.78,31,906.67,72,985.66,92.83c70.05,18.48,146.53,26.09,214.34,3V0H0V27.35A600.21,600.21,0,0,0,321.39,56.44Z" fill="#ffffff"></path>
              </svg>
            </div>
            <div className="ec-container">
              <div className="ec-section-header ec-center">
                <span className="ec-section-eyebrow">Thư viện ảnh</span>
                <h2 className="ec-section-title">Khoảnh khắc văn hóa<br />sống động</h2>
                <p className="ec-section-desc">Những góc nhìn chân thật, chớp lấy vẻ đẹp rực rỡ và nhịp sống đời thường của các cộng đồng dân tộc trên khắp Việt Nam.</p>
              </div>

              <div className="ec-masonry fade-up">
                {masonryImages.map((img, idx) => (
                  <div key={img.id || idx} className={`ec-masonry-item ec-masonry-item--${img.size || 'small'}`}>
                    <img src={img.imageUrl} alt={img.imageAlt || 'Khoảnh khắc văn hóa'} loading="lazy" />
                    <div className="ec-masonry-overlay">
                      <span className="ec-btn-icon">🔍</span>
                    </div>
                  </div>
                ))}
              </div>
            </div>
            <div className="ec-section-wave ec-section-wave--bottom">
              <svg data-name="Layer 1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1200 120" preserveAspectRatio="none">
                <path d="M321.39,56.44c58-10.79,114.16-30.13,172-41.86,82.39-16.72,168.19-17.73,250.45-.39C823.78,31,906.67,72,985.66,92.83c70.05,18.48,146.53,26.09,214.34,3V0H0V27.35A600.21,600.21,0,0,0,321.39,56.44Z" fill="#ffffff"></path>
              </svg>
            </div>
          </section>
        ) : null}

        {stories.length ? (
          <section className="ec-section ec-section--light">
            <div className="ec-container">
              <div className="ec-section-header ec-flex-header">
                <div>
                  <span className="ec-section-eyebrow">Góc nhìn cận cảnh</span>
                  <h2 className="ec-section-title">Chuyện kể từ<br />bản làng xa</h2>
                </div>
                <Link to="/articles" className="ec-link-more">Xem tất cả bài viết &rsaquo;</Link>
              </div>

              <div className="ec-grid ec-grid--3cols fade-up">
                {stories.map((s, index) => (
                  <Link to={s.code ? `/articles/${s.code}` : '/articles'} className="ec-scard" key={s.id || s.code || index}>
                    <div className="ec-scard__img">
                      {s.imageUrl ? <img src={s.imageUrl} alt={s.imageAlt || s.title} loading="lazy" /> : null}
                    </div>
                    <div className="ec-scard__content">
                      <h3 className="ec-scard__title">{s.title}</h3>
                      <p className="ec-scard__desc">{s.description || 'Từ bản làng, lễ hội đến những sinh hoạt đời thường, mỗi câu chuyện đều mở ra một lát cắt chân thật về đời sống văn hóa của cộng đồng.'}</p>
                      <div className="ec-scard__meta">
                        <span className="ec-meta-author">
                          <div className="ec-avatar"></div> VNCulture
                        </span>
                        <span className="ec-meta-date">{s.publishedAt ? new Date(s.publishedAt).toLocaleDateString(lang === 'vi' ? 'vi-VN' : 'en-US') : '—'}</span>
                      </div>
                    </div>
                  </Link>
                ))}
              </div>
            </div>
          </section>
        ) : null}
      </main>

      <Footer lang={lang} />
    </div>
  );
}

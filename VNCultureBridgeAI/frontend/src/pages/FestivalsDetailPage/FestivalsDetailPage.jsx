import React, { useMemo, useState } from 'react';
import { Link, useParams } from 'react-router-dom';
import PageHeader from '../../components/layout/PageHeader/PageHeader';
import Footer from '../../components/layout/Footer/Footer';
import LoadingState from '../../components/common/LoadingState/LoadingState';
import { getFestival } from '../../services/festival.service';
import { useDetailLoader } from '../../hooks/useDetailLoader';
import { useLanguage } from '../../context/LanguageContext';
import './FestivalsDetailPage.css';
import '../../App.css';

function getLabel(labels, key, fallback) {
  return labels?.[key] || fallback;
}

export default function FestivalsDetailPage() {
  const { lang, setLang } = useLanguage();
  const [foodPage, setFoodPage] = useState(1);
  const { id = 'tet-nguyen-dan' } = useParams();
  const { status, data, error } = useDetailLoader(getFestival, lang, id);

  const labels = useMemo(() => data?.labels || {}, [data]);

  if (status === 'loading') {
    return <LoadingState message="Đang tải dữ liệu lễ hội..." />;
  }

  if (status === 'error') {
    return <LoadingState type="error" message="Không tải được dữ liệu lễ hội." detail={error} />;
  }

  if (!data) {
    return <LoadingState type="error" message="Không tìm thấy dữ liệu lễ hội." />;
  }

  const festivalData = data;

  return (
    <div className="festival-detail-page">
      <PageHeader lang={lang} onLangChange={setLang} />

      <main>
        <section className="festival-hero" style={{ backgroundImage: `url(${festivalData.heroImage})` }}>
          <div className="hero-overlay"></div>
          <div className="hero-content">
            <span className="hero-tag">{festivalData.tag}</span>
            <h1 className="hero-title">{festivalData.title}</h1>
            <h2 className="hero-subtitle">{festivalData.enTitle}</h2>
            <p className="hero-desc">{festivalData.heroDesc}</p>
            <div className="hero-stats">
              <div className="hero-stat">
                <span className="hero-stat-val">{festivalData.quickFacts.date}</span>
                <span className="hero-stat-lbl">{getLabel(labels, 'dateLabel', 'Thời gian')}</span>
              </div>
              <div className="hero-stat">
                <span className="hero-stat-val">{festivalData.quickFacts.location}</span>
                <span className="hero-stat-lbl">{getLabel(labels, 'locationLabel', 'Địa điểm')}</span>
              </div>
              <div className="hero-stat">
                <span className="hero-stat-val">{festivalData.quickFacts.participants}</span>
                <span className="hero-stat-lbl">{getLabel(labels, 'participantsLabel', 'Tham gia')}</span>
              </div>
            </div>
          </div>
        </section>

        <div className="festival-container">
          <section className="festival-section what-is-it">
            <div className="text-content">
              <h2 className="section-title">{getLabel(labels, 'whatIsItTitle', `${festivalData.title} là gì?`)}</h2>
              {festivalData.whatIsItContext.map((para, index) => (
                <p key={index}>{para}</p>
              ))}

            </div>
            <div className="image-content">
              <img src={festivalData.infoImage} alt={`${festivalData.title} Celebration`} />
            </div>
          </section>

          {festivalData.culturalContextMain && festivalData.culturalContextHighlights && (
            <section className="festival-section cultural-context-section">
              <h2 className="section-title center">{getLabel(labels, 'culturalContextTitle', 'Bối cảnh văn hóa')}</h2>
              <div className="cultural-context-grid">
                <div className="cultural-context-left">
                  {festivalData.culturalContextMain.map((item, index) => (
                    <p key={index}>
                      <strong>{item.title}:</strong> {item.desc}
                    </p>
                  ))}
                </div>
                <div className="cultural-context-right">
                  <div className="context-highlight-card">
                    {festivalData.culturalContextHighlights.map((highlight, idx) => (
                      <div className="context-highlight-item" key={idx}>
                        <span className={`highlight-icon-box ${highlight.colorClass}`}>{highlight.icon}</span>
                        <div>
                          <h4>{highlight.title}</h4>
                          <p>{highlight.desc}</p>
                        </div>
                      </div>
                    ))}
                  </div>
                </div>
              </div>
            </section>
          )}

          {festivalData.inspiringQuote && (
            <section className="festival-quote-banner">
              <div className="quote-icon-top">
                <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="#e63946" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                  <path d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z"></path>
                </svg>
              </div>
              <h3 className="quote-text">"{festivalData.inspiringQuote}"</h3>
            </section>
          )}

          {festivalData.howItIsCelebrated && (
            <section className="festival-section how-celebrated-section">
              <h2 className="section-title center">{getLabel(labels, 'celebrationTitle', `${festivalData.title} được tổ chức như thế nào?`)}</h2>
              <div className="how-celebrated-list">
                {festivalData.howItIsCelebrated.map((step, idx) => (
                  <div className={`celebration-card ${step.align === 'left' ? 'image-left' : 'image-right'}`} key={idx}>
                    <div className="celebration-text">
                      <span className="celebration-badge">{step.phase}</span>
                      <h3 className="celebration-title">{step.title}</h3>
                      {step.desc.map((para, pIdx) => (
                        <p key={pIdx}>{para}</p>
                      ))}
                    </div>
                    <div className="celebration-image">
                      <img src={step.image} alt={step.title} />
                    </div>
                  </div>
                ))}
              </div>
            </section>
          )}

          {festivalData.whatTetFeelsLike && (
            <section className="festival-section feels-like-section">
              <h2 className="section-title center">{getLabel(labels, 'feelsLikeTitle', `Trải nghiệm không khí ${festivalData.title}`)}</h2>
              <div className="feels-like-text-grid">
                <div className="feels-like-col">
                  {festivalData.whatTetFeelsLike.leftText.map((p, idx) => (
                    <p key={idx} dangerouslySetInnerHTML={{ __html: p.replace(/(^.*?:)/, '<strong>$1</strong>') }}></p>
                  ))}
                </div>
                <div className="feels-like-col">
                  {festivalData.whatTetFeelsLike.rightText.map((p, idx) => (
                    <p key={idx} dangerouslySetInnerHTML={{ __html: p.replace(/(^.*?:)/, '<strong>$1</strong>') }}></p>
                  ))}
                </div>
              </div>
              <div className="feels-like-banner">
                <img src={festivalData.whatTetFeelsLike.image} alt="Atmosphere Banner" />
              </div>
            </section>
          )}

          {festivalData.keyTraditionsDocs && (
            <section className="festival-section key-traditions-section">
              <h2 className="section-title center">{getLabel(labels, 'keyTraditionsTitle', 'Những nét truyền thống nổi bật')}</h2>
              <div className="key-traditions-grid">
                {festivalData.keyTraditionsDocs.map((item, idx) => (
                  <div className="key-tradition-card" key={idx}>
                    <img src={item.image} alt={item.title} className="key-tradition-img" />
                    <div className="key-tradition-content">
                      <h4>{item.title}</h4>
                      <p>{item.desc}</p>
                    </div>
                  </div>
                ))}
              </div>
            </section>
          )}

          {festivalData.traditionalFoods && (
            <section className="festival-section traditional-foods-section">
              <div className="section-intro center">
                <h2 className="section-title">{getLabel(labels, 'traditionalFoodsTitle', `Ẩm thực gắn với ${festivalData.title}`)}</h2>
                <p>{getLabel(labels, 'traditionalFoodsSubtitle', 'Hương vị lễ hội góp phần kể câu chuyện về vùng đất, cộng đồng và ký ức văn hóa.')}</p>
              </div>

              <div className="foods-container">
                {foodPage === 1 && (
                  <div className="traditional-foods-grid animation-fade-in">
                    {festivalData.traditionalFoods.map((food, idx) => (
                      <div className="food-card" key={idx}>
                        <div className="food-img-wrap">
                          <img src={food.image} alt={food.title} />
                        </div>
                        <div className="food-content">
                          <h4>{food.title}</h4>
                          <p>{food.desc}</p>
                        </div>
                      </div>
                    ))}
                  </div>
                )}

                {foodPage === 2 && festivalData.regionalFoods && (
                  <div className="regional-foods-grid animation-fade-in">
                    <div className="region-col">
                      <span className="region-badge highlight-red">{getLabel(labels, 'northRegionLabel', 'Miền Bắc')}</span>
                      <div className="region-food-list">
                        {festivalData.regionalFoods.north.map((item, idx) => (
                          <div className="food-card small" key={idx}>
                            <div className="food-img-wrap">
                              <img src={item.image} alt={item.title} />
                            </div>
                            <div className="food-content">
                              <h4>{item.title}</h4>
                              <p>{item.desc}</p>
                            </div>
                          </div>
                        ))}
                      </div>
                    </div>
                    <div className="region-col">
                      <span className="region-badge highlight-yellow">{getLabel(labels, 'centralRegionLabel', 'Miền Trung')}</span>
                      <div className="region-food-list">
                        {festivalData.regionalFoods.central.map((item, idx) => (
                          <div className="food-card small" key={idx}>
                            <div className="food-img-wrap">
                              <img src={item.image} alt={item.title} />
                            </div>
                            <div className="food-content">
                              <h4>{item.title}</h4>
                              <p>{item.desc}</p>
                            </div>
                          </div>
                        ))}
                      </div>
                    </div>
                    <div className="region-col">
                      <span className="region-badge highlight-orange">{getLabel(labels, 'southRegionLabel', 'Miền Nam')}</span>
                      <div className="region-food-list">
                        {festivalData.regionalFoods.south.map((item, idx) => (
                          <div className="food-card small" key={idx}>
                            <div className="food-img-wrap">
                              <img src={item.image} alt={item.title} />
                            </div>
                            <div className="food-content">
                              <h4>{item.title}</h4>
                              <p>{item.desc}</p>
                            </div>
                          </div>
                        ))}
                      </div>
                    </div>
                  </div>
                )}
              </div>

              {festivalData.regionalFoods && (
                <div className="food-pagination">
                  <button className="pagination-btn" onClick={() => setFoodPage(1)} disabled={foodPage === 1}>
                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><polyline points="15 18 9 12 15 6"></polyline></svg>
                  </button>
                  <button className={`pagination-btn ${foodPage === 1 ? 'active' : ''}`} onClick={() => setFoodPage(1)}>1</button>
                  <button className={`pagination-btn ${foodPage === 2 ? 'active' : ''}`} onClick={() => setFoodPage(2)}>2</button>
                  <button className="pagination-btn" onClick={() => setFoodPage(2)} disabled={foodPage === 2}>
                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><polyline points="9 18 15 12 9 6"></polyline></svg>
                  </button>
                </div>
              )}
            </section>
          )}

          {festivalData.culturalMeaningsDocs && (
            <section className="festival-section cultural-meanings-section">
              <h2 className="section-title center">{getLabel(labels, 'culturalMeaningsTitle', 'Ý nghĩa văn hóa')}</h2>
              <div className="cultural-meanings-grid">
                {festivalData.culturalMeaningsDocs.map((item, idx) => (
                  <div className="cultural-meaning-card" key={idx}>
                    <div className={`meaning-icon ${item.colorClass}`}>{item.icon}</div>
                    <div className="meaning-content">
                      <h4>{item.title}</h4>
                      <p>{item.desc}</p>
                    </div>
                  </div>
                ))}
              </div>
            </section>
          )}

          {festivalData.interestingFactsDocs && (
            <section className="festival-section interesting-facts-section">
              <h2 className="section-title center">{getLabel(labels, 'interestingFactsTitle', `Điều thú vị về ${festivalData.title}`)}</h2>
              <div className="interesting-facts-grid">
                {festivalData.interestingFactsDocs.map((item, idx) => (
                  <div className="interesting-fact-card" key={idx}>
                    <div className="fact-badge">{item.icon}</div>
                    <div className="fact-content">
                      <h4>{item.title}</h4>
                      <p>{item.desc}</p>
                    </div>
                  </div>
                ))}
              </div>
            </section>
          )}

          {festivalData.galleryHero && festivalData.galleryGrid && (
            <section className="festival-section tet-pictures-section">
              <h2 className="section-title center">{getLabel(labels, 'galleryTitle', `${festivalData.title} qua hình ảnh`)}</h2>
              <div className="tet-pictures-container">
                <div className="picture-hero">
                  <img src={festivalData.galleryHero} alt="Hero Event" />
                </div>
                <div className="picture-grid-small">
                  {festivalData.galleryGrid.map((img, idx) => (
                    <div className="picture-tile" key={idx}>
                      <img src={img} alt={`Gallery tile ${idx}`} />
                    </div>
                  ))}
                </div>
              </div>
            </section>
          )}

          {festivalData.inShortText && (
            <section className="festival-section in-short-section">
              <h2 className="section-title center">{getLabel(labels, 'inShortTitle', 'Tóm lược')}</h2>
              <p className="in-short-text">{festivalData.inShortText}</p>
            </section>
          )}

          {festivalData.discoverMore && (
            <section className="festival-section discover-more-section">
              <h2 className="section-title center">{getLabel(labels, 'discoverMoreTitle', `Khám phá thêm về ${festivalData.title}`)}</h2>
              <div className="discover-more-grid">
                {festivalData.discoverMore.map((item, idx) => (
                  <div className="discover-card" key={idx}>
                    <div className="discover-img-wrap">
                      <img src={item.image} alt={item.title} />
                    </div>
                    <div className="discover-content">
                      <h4>{item.title}</h4>
                      <p>{item.desc}</p>
                    </div>
                  </div>
                ))}
              </div>
            </section>
          )}

          <div style={{ marginTop: '24px' }}>
            <Link to="/festivals" className="festival-btn-discover">Quay lại danh sách lễ hội</Link>
          </div>
        </div>
      </main>

      <Footer />
    </div>
  );
}

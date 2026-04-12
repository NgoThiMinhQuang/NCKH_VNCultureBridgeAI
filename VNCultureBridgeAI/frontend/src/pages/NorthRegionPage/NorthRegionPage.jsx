import React, { useState, useEffect } from 'react';
import { Link } from 'react-router-dom';
import PageHeader from '../../components/layout/PageHeader/PageHeader';
import Footer from '../../components/layout/Footer/Footer';
import './NorthRegionPage.css';

// Import generated/placeholder images
import northHeroImg from '../../assets/images/regions/regions_hero_bg.png'; // Will replace with actual generated one if needed
import hanoiStoryImg from '../../assets/images/regions/province_hagiang.png'; // Placeholder

const EXPERIENCES = [
  { id: 1, title: 'Đỉnh Fansipan', image: 'https://images.unsplash.com/photo-1509316975850-ff9c5deb0cd9?q=80&w=1000&auto=format&fit=crop', desc: 'Nóc nhà Đông Dương mờ sương' },
  { id: 2, title: 'Hội Lim', image: 'https://images.unsplash.com/photo-1528127269322-539801943592?q=80&w=1000&auto=format&fit=crop', desc: 'Di sản Quan họ Bắc Ninh' },
  { id: 3, title: 'Ẩm thực Tây Bắc', image: 'https://images.unsplash.com/photo-1583000215173-989643445579?q=80&w=1000&auto=format&fit=crop', desc: 'Hương vị mắc khén độc bản' },
  { id: 4, title: 'Sa Pa mờ sương', image: 'https://images.unsplash.com/photo-1596394516093-501ba68a0ba6?q=80&w=1000&auto=format&fit=crop', desc: 'Vẻ đẹp vùng cao quanh năm' },
  { id: 5, title: 'Tràng An - Bái Đính', image: 'https://images.unsplash.com/photo-1589308078059-be1415eab4c3?q=80&w=1000&auto=format&fit=crop', desc: 'Di sản kép thế giới' },
  { id: 6, title: 'Vịnh Hạ Long', image: 'https://images.unsplash.com/photo-1524231757912-21f4fe3a7200?q=80&w=1000&auto=format&fit=crop', desc: 'Kỳ quan thiên nhiên thế giới' }
];

const PROVINCES = [
  { id: 1, name: 'Hà Nội', image: 'https://images.unsplash.com/photo-1555939594-58d7cb561ad1?q=80&w=800&auto=format&fit=crop', desc: 'Thủ đô nghìn năm văn hiến', tags: ['Phố cổ', 'Vân hóa'] },
  { id: 2, name: 'Hà Giang', image: 'https://images.unsplash.com/photo-1509130298739-651801c76e96?q=80&w=800&auto=format&fit=crop', desc: 'Cao nguyên đá hùng vĩ', tags: ['Núi rừng', 'Địa chất'] },
  { id: 3, name: 'Lào Cai', image: 'https://images.unsplash.com/photo-1596394516093-501ba68a0ba6?q=80&w=800&auto=format&fit=crop', desc: 'Đỉnh Fansipan & Sa Pa mờ sương', tags: ['Sa Pa', 'Ruộng bậc thang'] },
  { id: 4, name: 'Ninh Bình', image: 'https://images.unsplash.com/photo-1589308078059-be1415eab4c3?q=80&w=800&auto=format&fit=crop', desc: 'Cố đô Hoa Lư, Tràng An', tags: ['Hang động', 'Lịch sử'] }
];

const SEASONS = [
  { id: 'spring', name: 'Mùa Xuân', image: 'https://images.unsplash.com/photo-1498194847464-32b904cf10a6?q=80&w=400&auto=format&fit=crop', desc: 'Sắc xuân vùng cao rực rỡ' },
  { id: 'summer', name: 'Mùa Hạ', image: 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?q=80&w=400&auto=format&fit=crop', desc: 'Biển xanh và nắng vàng' },
  { id: 'autumn', name: 'Mùa Thu', image: 'https://images.unsplash.com/photo-1476514525535-07fb3b4ae5f1?q=80&w=400&auto=format&fit=crop', desc: 'Mùa lúa vàng óng ả' },
  { id: 'winter', name: 'Mùa Đông', image: 'https://images.unsplash.com/photo-1444491741275-3747c03c996.jpg?q=80&w=400&auto=format&fit=crop', desc: 'Sương mù bao phủ núi rừng' }
];

export default function NorthRegionPage() {
  const [lang, setLang] = useState('vi');

  useEffect(() => {
    window.scrollTo(0, 0);
    document.title = 'Miền Bắc - VietCultura';
  }, []);

  return (
    <div className="north-page">
      <PageHeader lang={lang} onLangChange={setLang} breadcrumb={[{ label: 'Vùng miền', to: '/regions' }, { label: 'Miền Bắc' }]} />

      <main>
        {/* --- HERO SECTION --- */}
        <section className="north-hero">
          <div className="north-hero__bg">
            <img src={northHeroImg} alt="North Vietnam Terraces" />
            <div className="north-hero__overlay"></div>
          </div>
          <div className="north-hero__content">
            <span className="north-hero__badge">Vẻ đẹp vùng cao</span>
            <h1 className="north-hero__title">
              Miền Bắc
              <span className="north-hero__title-accent">Hồn thiêng sông núi</span>
            </h1>
            <div className="north-hero__actions">
              <button className="north-hero__btn north-hero__btn--primary">Khám phá ngay</button>
              <button className="north-hero__btn north-hero__btn--secondary">Lên lộ trình</button>
            </div>
            
            <div className="north-hero__stats">
              <div className="north-hero__stat">
                <strong>25+</strong>
                <span>Tỉnh thành</span>
              </div>
              <div className="north-hero__stat">
                <strong>100+</strong>
                <span>Lễ hội</span>
              </div>
              <div className="north-hero__stat">
                <strong>500+</strong>
                <span>Món ăn</span>
              </div>
            </div>
          </div>
          
          {/* WAVE DIVIDER */}
          <div className="section-wave section-wave--bottom">
            <svg viewBox="0 0 1440 120" preserveAspectRatio="none">
              <path d="M0,32L60,42.7C120,53,240,75,360,80C480,85,600,75,720,58.7C840,43,1200,21,1320,10.7L1440,0L1440,120L1320,120C1200,120,840,120,720,120C600,120,480,120,360,120C240,120,120,120,60,120L0,120Z"></path>
            </svg>
          </div>
        </section>

        {/* --- STORY SECTION --- */}
        <section className="north-story content-section">
          <div className="container">
            <div className="north-story__inner">
              <div className="north-story__image">
                <img src={hanoiStoryImg} alt="Hanoi Story" />
                <div className="north-story__image-decoration"></div>
              </div>
              <div className="north-story__content">
                <h2 className="section-title">Câu chuyện của vùng đất</h2>
                <div className="section-divider"></div>
                <p>Miền Bắc mang trong mình chiều sâu của hàng nghìn năm lịch sử, là cái nôi của nền văn minh lúa nước và bản sắc dân tộc Việt. Từ những khu phố cổ sầm uất của Hà Nội đến những đỉnh núi cao mây phủ của Hà Giang, mỗi dải đất đều kể một câu chuyện về sức sống bền bỉ và vẻ đẹp văn hóa trường tồn.</p>
                <p>Nơi đây không chỉ có cảnh quan thiên nhiên hùng vĩ mà còn là vùng đất của những di sản tinh thần vô giá, những làng nghề truyền thống và những lễ hội đậm đà bản sắc.</p>
                <button className="btn-text-icon">Đọc thêm câu chuyện <span aria-hidden="true">→</span></button>
              </div>
            </div>
          </div>
        </section>

        {/* --- CULTURAL MAP SECTION --- */}
        <section className="north-map-section content-section alternate-bg">
          <div className="container">
            <h2 className="section-title text-center">Bản đồ văn hóa</h2>
            <div className="north-map-inner">
              <div className="north-map__visual">
                <div className="map-placeholder">
                  <div className="map-label">MAP INTERACTIVE AREA</div>
                </div>
              </div>
              <div className="north-map__list">
                <div className="map-info-card">
                  <h3>Hà Nội</h3>
                  <p>Trung tâm văn hóa nghìn năm văn hiến</p>
                </div>
                <div className="map-info-card active">
                  <h3>Vịnh Hạ Long</h3>
                  <p>Kỳ quan thiên nhiên thế giới</p>
                </div>
                <div className="map-info-card">
                  <h3>Sa Pa</h3>
                  <p>Vẻ đẹp vùng cao sương mù</p>
                </div>
              </div>
            </div>
          </div>
          
          <div className="section-wave section-wave--top">
              <svg viewBox="0 0 1440 120" preserveAspectRatio="none">
                <path d="M0,64L80,58.7C160,53,320,43,480,53.3C640,64,800,96,960,96C1120,96,1280,64,1360,48L1440,32L1440,0L1360,0C1280,0,1120,0,960,0C800,0,640,0,480,0C320,0,160,0,80,0L0,0Z"></path>
              </svg>
          </div>
        </section>

        {/* --- EXPERIENCES SECTION --- */}
        <section className="north-experiences content-section">
          <div className="container">
            <div className="section-header text-center">
              <h2 className="section-title">Trải nghiệm đặc trưng</h2>
              <p>Khám phá mười nét văn hoá độc đáo không thể bỏ qua tại miền Bắc</p>
            </div>
            <div className="experience-grid">
              {EXPERIENCES.map(ex => (
                <div key={ex.id} className="experience-card">
                  <div className="experience-card__img">
                    <img src={ex.image} alt={ex.title} />
                  </div>
                  <div className="experience-card__body">
                    <h3>{ex.title}</h3>
                    <p>{ex.desc}</p>
                  </div>
                </div>
              ))}
            </div>
          </div>
        </section>

        {/* --- PROVINCES SECTION --- */}
        <section className="north-provinces content-section alternate-bg">
          <div className="container">
            <div className="section-header text-center">
              <h2 className="section-title">Từ vùng miền đến từng tỉnh thành</h2>
              <div className="search-filter-row">
                <div className="search-box">
                  <input type="text" placeholder="Tìm tỉnh thành..." />
                  <span className="search-icon">🔍</span>
                </div>
                <div className="filter-chips">
                  <span className="active">Tất cả</span>
                  <span>Thiên nhiên</span>
                  <span>Văn hóa</span>
                  <span>Lịch sử</span>
                </div>
              </div>
            </div>
            
            <div className="province-grid">
              {PROVINCES.map(prov => (
                <div key={prov.id} className="province-mini-card">
                  <div className="province-mini__img">
                    <img src={prov.image} alt={prov.name} />
                    <span className="province-mini__tag">Miền Bắc</span>
                  </div>
                  <div className="province-mini__body">
                    <h3>{prov.name}</h3>
                    <p>{prov.desc}</p>
                    <div className="province-mini__tags">
                      {prov.tags.map(t => <span key={t}>{t}</span>)}
                    </div>
                    <Link to={`/provinces/${prov.id}`} className="mini-cta">Xem chi tiết →</Link>
                  </div>
                </div>
              ))}
            </div>
          </div>
        </section>

        {/* --- SEASONS SECTION --- */}
        <section className="north-seasons content-section">
          <div className="container">
            <h2 className="section-title text-center">Vẻ đẹp theo mùa</h2>
            <div className="season-vertical-grid">
              {SEASONS.map(s => (
                <div key={s.id} className="season-v-card">
                  <img src={s.image} alt={s.name} />
                  <div className="season-v-content">
                    <h3>{s.name}</h3>
                    <p>{s.desc}</p>
                  </div>
                </div>
              ))}
            </div>
          </div>
        </section>

        {/* --- CULTURAL LAYERS --- */}
        <section className="north-layers content-section alternate-bg">
          <div className="container">
              <h2 className="section-title text-center">Những lớp văn hóa của vùng</h2>
              <div className="layers-grid">
                <div className="layer-card">
                  <span className="layer-icon">🏮</span>
                  <h3>Lễ hội</h3>
                  <p>Hội Lim, Chùa Hương, Lễ hội Đền Hùng</p>
                </div>
                <div className="layer-card">
                  <span className="layer-icon">🍚</span>
                  <h3>Ẩm thực</h3>
                  <p>Phở, Bún chả, chả cá Lã Vọng</p>
                </div>
                <div className="layer-card">
                  <span className="layer-icon">🏺</span>
                  <h3>Làng nghề</h3>
                  <p>Gốm Bát Tràng, lụa Vạn Phúc</p>
                </div>
                <div className="layer-card">
                  <span className="layer-icon">🎻</span>
                  <h3>Nghệ thuật</h3>
                  <p>Ca trù, quan họ Bắc Ninh, múa rối nước</p>
                </div>
                <div className="layer-card">
                  <span className="layer-icon">🏘️</span>
                  <h3>Kiến trúc</h3>
                  <p>Nhà sàn, nhà ống phố cổ, đình làng</p>
                </div>
                <div className="layer-card">
                  <span className="layer-icon">👗</span>
                  <h3>Trang phục</h3>
                  <p>Áo tứ thân, khăn mỏ quạ, yếm đào</p>
                </div>
              </div>
          </div>
        </section>

        {/* --- ITINERARY SECTION --- */}
        <section className="north-itinerary content-section">
          <div className="container">
            <h2 className="section-title text-center">Hành trình gợi ý</h2>
            <div className="itinerary-grid">
              <div className="itinerary-card primary">
                <div className="itinerary-image">
                  <img src="https://images.unsplash.com/photo-1555431189-d58b41230ab0?q=80&w=800&auto=format&fit=crop" alt="Hanoi Discovery" />
                  <span className="itinerary-badge">3 NGÀY</span>
                </div>
                <div className="itinerary-body">
                  <h3>Khám phá Thủ đô Ngàn năm</h3>
                  <ul className="itinerary-steps">
                    <li>Hà Nội - Phố Cổ</li>
                    <li>Làng cổ Đường Lâm</li>
                    <li>Chùa Hương linh thiêng</li>
                  </ul>
                  <button className="btn-full">Xem lộ trình chi tiết</button>
                </div>
              </div>
              <div className="itinerary-card">
                <div className="itinerary-image">
                  <img src="https://images.unsplash.com/photo-1596394516093-501ba68a0ba6?q=80&w=800&auto=format&fit=crop" alt="North West" />
                  <span className="itinerary-badge">5 NGÀY</span>
                </div>
                <div className="itinerary-body">
                  <h3>Cung đường Tây Bắc hùng vĩ</h3>
                  <ul className="itinerary-steps">
                    <li>Sa Pa - Đỉnh Fansipan</li>
                    <li>Ô Quy Hồ - Lai Châu</li>
                    <li>Điện Biên Phủ lịch sử</li>
                  </ul>
                  <button className="btn-full">Xem lộ trình chi tiết</button>
                </div>
              </div>
            </div>
          </div>
        </section>

        {/* --- CTA SECTION --- */}
        <section className="north-cta">
          <div className="north-cta__bg"></div>
          <div className="container">
            <div className="north-cta__content">
              <span className="cta-icon">📮</span>
              <h2>Chinh phục ngay</h2>
              <p>Đăng ký để nhận thông tin về các hành trình khám phá và ưu đãi mới nhất từ VietCultura</p>
              <form className="cta-form">
                <input type="email" placeholder="Địa chỉ email của bạn" />
                <button type="submit">ĐĂNG KÝ NGAY</button>
              </form>
            </div>
          </div>
        </section>
      </main>

      <Footer lang={lang} />
    </div>
  );
}

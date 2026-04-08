import React, { useState } from 'react';
import { Link, useParams } from 'react-router-dom';
import './EthnicCulturesDetailPage.css';
import PageHeader from '../../components/layout/PageHeader/PageHeader';
import Footer from '../../components/layout/Footer/Footer';
import { 
  FiClock, 
  FiMapPin, 
  FiMusic, 
  FiCoffee, 
  FiHome, 
  FiImage, 
  FiChevronRight,
  FiGlobe,
  FiLayers,
  FiArrowLeft
} from 'react-icons/fi';

// Image Imports - Verified paths
import hmongHero from '../../assets/hmong_hero_landscape_1775575827859.png';
import hmongIntro from '../../assets/hmong_intro_portrait_1775575846120.png';
import textile1 from '../../assets/hmong_textile_grid_1775575869410.png';
import textile2 from '../../assets/hmong_textile_close_up_1775576097396.png';
import textile3 from '../../assets/hmong_batik_process_1775576116027.png';
import fest1 from '../../assets/hmong_festival_gau_tao_1775575986843.png';
import food1 from '../../assets/hmong_cuisine_thang_co_1775576005757.png';
import arch1 from '../../assets/hmong_architecture_house_1775576026757.png';

export default function EthnicCulturesDetailPage() {
  const [lang, setLang] = useState('vi');
  const { code } = useParams();

  const navItems = [
    { icon: <FiClock />, label: "Lịch sử" },
    { icon: <FiGlobe />, label: "Văn hóa" },
    { icon: <FiMusic />, label: "Lễ hội" },
    { icon: <FiCoffee />, label: "Ẩm thực" },
    { icon: <FiHome />, label: "Kiến trúc" },
    { icon: <FiImage />, label: "Thư viện" }
  ];

  return (
    <div className="page-shell">
      <PageHeader lang={lang} onLangChange={setLang} />

      <main className="ed-main">
        {/* HERO SECTION */}
        <section 
          className="ed-hero" 
          style={{ backgroundImage: `url(${hmongHero})` }}
        >
          <Link to="/ethnic-groups" className="ed-back-btn" aria-label="Quay lại">
            <FiArrowLeft /> <span>Quay lại</span>
          </Link>
          <div className="ed-hero__content">
            <h1 className="ed-hero__title">Dân tộc H'Mông</h1>
            <p className="ed-hero__desc">
              Một trong những cộng đồng dân tộc lâu đời và có nền văn hóa phong phú nhất tại vùng núi cao phía Bắc Việt Nam.
            </p>

            <nav className="ed-hero__nav">
              {navItems.map((item, idx) => (
                <div key={idx} className="ed-nav-item">
                  <div className="ed-nav-icon">{item.icon}</div>
                  <span className="ed-nav-label">{item.label}</span>
                </div>
              ))}
            </nav>
          </div>
        </section>

        {/* INTRODUCTION */}
        <section className="ed-section ed-intro">
          <div className="ed-container">
            <div className="ed-intro__grid">
              <div className="ed-intro__text">
                <header className="ed-intro__header fade-up" style={{ marginBottom: '32px' }}>
                  <span className="ed-section-badge" style={{ margin: 0 }}>Hành trình di sản</span>
                  <h2 className="ed-section-title" style={{ textAlign: 'left', marginTop: '8px' }}>Giới thiệu về người H'Mông</h2>
                </header>
                <span className="ed-drop-cap">H</span>
                <div className="ed-intro__body">
                  <p>
                    Dân tộc H'Mông (hay còn gọi là Mông) là một trong những dân tộc thiểu số có dân số đông nhất tại Việt Nam, chủ yếu cư trú ở các vùng núi cao phía Bắc từ Hà Giang đến Thanh Hóa.
                  </p>
                  <p style={{ marginTop: '20px' }}>
                    Với lịch sử di cư lâu đời, người H'Mông đã tạo nên một bản sắc văn hóa độc đáo, thích nghi mạnh mẽ với điều kiện thiên nhiên khắc nghiệt của vùng cao nguyên đá.
                  </p>
                </div>
              </div>
              <div className="ed-intro__image">
                <img src={hmongIntro} alt="Người H'Mông" />
              </div>
            </div>
          </div>
        </section>

        {/* TEXTILES */}
        <section className="ed-section ed-textiles">
          <div className="ed-container">
            <header className="ed-section-header">
              <span className="ed-section-badge">Nghệ thuật đặc trưng</span>
              <h2 className="ed-section-title">Vẻ đẹp thổ cẩm & Sáp ong</h2>
              <p className="ed-section-subtitle">Mỗi tấm vải là một tác phẩm nghệ thuật, kết tinh từ sự khéo léo và tâm hồn của người phụ nữ H'Mông.</p>
            </header>
            
            <div className="ed-textiles-grid">
              <img src={textile1} alt="T1" className="ed-textile-img" />
              <img src={textile2} alt="T2" className="ed-textile-img" />
              <img src={textile3} alt="T3" className="ed-textile-img" />
            </div>
            
            <p className="ed-textiles-footer">
              Kỹ thuật vẽ sáp ong và dệt lanh truyền thống đã được lưu giữ qua hàng đời, tạo nên những hoa văn cổ kính mang ý nghĩa tâm linh và lịch sử sâu sắc.
            </p>
          </div>
        </section>

        {/* FESTIVALS */}
        <section className="ed-section ed-festivals">
          <div className="ed-container">
            <header className="ed-section-header">
              <span className="ed-section-badge">Di sản sống</span>
              <h2 className="ed-section-title">Lễ hội đặc sắc</h2>
            </header>

            <div className="ed-festival-grid">
              <div className="ed-fest-card">
                <img src={fest1} alt="F1" className="ed-fest-img" />
                <div className="ed-fest-content">
                  <span className="ed-fest-tag">Di sản</span>
                  <h3 className="ed-fest-title">Lễ hội Gầu Tào</h3>
                  <p className="ed-fest-desc">Lễ hội lớn nhất của người H'Mông, cầu chúc cho sức khỏe, may mắn và mùa màng tươi tốt.</p>
                </div>
              </div>
              
              <div className="ed-fest-card">
                <img src={hmongHero} alt="F2" className="ed-fest-img" />
                <div className="ed-fest-content">
                  <span className="ed-fest-tag">Văn hóa</span>
                  <h3 className="ed-fest-title">Chợ tình Khâu Vai</h3>
                  <p className="ed-fest-desc">Nơi hòm thư kết duyên và lưu giữ những giá trị tâm hồn cao đẹp của đồng bào vùng cao.</p>
                </div>
              </div>

              <div className="ed-fest-card">
                <img src={hmongIntro} alt="F3" className="ed-fest-img" />
                <div className="ed-fest-content">
                  <span className="ed-fest-tag">Nghi lễ</span>
                  <h3 className="ed-fest-title">Tết Nào Pênh Chà</h3>
                  <p className="ed-fest-desc">Dịp sum họp gia đình và tạ ơn thần linh sau một năm miệt mài lao động trên nương rẫy.</p>
                </div>
              </div>
            </div>
          </div>
        </section>

        {/* MUSIC & ARTS */}
        <section className="ed-section ed-music">
          <div className="ed-container">
            <div className="ed-arch__grid">
              <div className="ed-arch-text">
                <span className="ed-section-badge">Âm vang núi rừng</span>
                <h2 className="ed-section-title">Tiếng Khèn & Câu hát</h2>
                <p className="ed-intro__body">
                  Cây khèn không chỉ là một nhạc cụ, mà là linh hồn của người H'Mông. Tiếng khèn vang vọng khắp núi rừng, là lời tỏ tình của chàng trai, là tiếng lòng gửi đến tổ tiên trong các dịp lễ hội quan trọng. Bên cạnh đó, những điệu múa khèn điêu luyện cũng là một nét văn hóa độc nhất vô nhị.
                </p>
              </div>
              <div className="ed-arch-image">
                <img src={hmongHero} alt="Tiếng Khèn" className="ed-arch-img" />
              </div>
            </div>
          </div>
        </section>

        {/* CUISINE */}
        <section className="ed-section ed-cuisine">
          <div className="ed-container">
            <div className="ed-cuisine-grid">
              <div className="ed-cuisine-item">
                <img src={food1} alt="Food1" className="ed-cuisine-img" />
                <h3 className="ed-cuisine-title">Thắng cố cổ truyền</h3>
              </div>
              <div className="ed-cuisine-item">
                <img src={hmongHero} alt="Food2" className="ed-cuisine-img" />
                <h3 className="ed-cuisine-title">Mèn mén</h3>
              </div>
              <div className="ed-cuisine-item">
                <img src={hmongIntro} alt="Food3" className="ed-cuisine-img" />
                <h3 className="ed-cuisine-title">Rượu ngô hạ thổ</h3>
              </div>
            </div>
          </div>
        </section>

        {/* ARCHITECTURE */}
        <section className="ed-section ed-architecture">
          <div className="ed-container">
            <div className="ed-arch__grid">
              <div className="ed-arch-image">
                <img src={arch1} alt="Arch1" className="ed-arch-img" />
              </div>
              <div className="ed-arch-text">
                <span className="ed-section-badge">Không gian sống</span>
                <h2 className="ed-section-title">Kiến trúc Nhà Trình Tường</h2>
                <p className="ed-intro__body">
                  Hệ thống nhà trình tường bằng đất sét của người H'Mông là minh chứng cho sự thích nghi tuyệt vời với khí hậu giá lạnh. Những bức tường dày không chỉ giữ ấm mùa đông mà còn giúp ngôi nhà mát mẻ giữa mùa hè vùng cao.
                </p>
              </div>
            </div>
          </div>
        </section>

        {/* GALLERY */}
        <section className="ed-section ed-gallery">
          <div className="ed-container">
            <header className="ed-section-header">
              <h2 className="ed-section-title">Thư viện hình ảnh</h2>
              <p className="ed-section-subtitle">Những khoảnh khắc chân thực về cuộc sống và con người H'Mông.</p>
            </header>
            
            <div className="ed-gallery-grid">
              <div className="ed-gallery-item large"><img src={hmongIntro} alt="G1" /></div>
              <div className="ed-gallery-item"><img src={textile2} alt="G2" /></div>
              <div className="ed-gallery-item tall"><img src={hmongHero} alt="G3" /></div>
              <div className="ed-gallery-item"><img src={textile1} alt="G4" /></div>
              <div className="ed-gallery-item wide"><img src={arch1} alt="G5" /></div>
              <div className="ed-gallery-item"><img src={food1} alt="G6" /></div>
            </div>
          </div>
        </section>

        {/* CTA BANNER */}
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

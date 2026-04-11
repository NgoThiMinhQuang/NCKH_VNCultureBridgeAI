import React, { useState, useEffect } from 'react';
import { Link, useNavigate, useParams } from 'react-router-dom';
import './CuisineDetailPage.css';
import PageHeader from '../../components/layout/PageHeader/PageHeader';
import Footer from '../../components/layout/Footer/Footer';
import {
  FiClock,
  FiGlobe,
  FiBookOpen,
  FiCoffee,
  FiHome,
  FiImage,
  FiArrowLeft
} from 'react-icons/fi';

export default function CuisineDetailPage() {
  const [lang, setLang] = useState('vi');
  const { id } = useParams();
  const navigate = useNavigate();

  useEffect(() => {
    window.scrollTo(0, 0);
  }, []);

  const navItems = [
    { icon: <FiClock />, label: "Giới thiệu" },
    { icon: <FiBookOpen />, label: "Nguyên liệu" },
    { icon: <FiGlobe />, label: "Cách làm" },
    { icon: <FiCoffee />, label: "Thưởng thức" },
    { icon: <FiHome />, label: "Góc bếp" },
    { icon: <FiImage />, label: "Thư viện" }
  ];

  return (
    <div className="page-shell">
      <PageHeader lang={lang} onLangChange={setLang} />

      <main className="cdp-main">
        {/* HERO SECTION */}
        <section className="cdp-hero">
          <div className="cdp-hero__bg" style={{ backgroundImage: "url('https://images.unsplash.com/photo-1547592166-23ac45744acd?q=80&w=2071&auto=format&fit=crop')" }}></div>
          <div className="cdp-hero__overlay"></div>

          {/* Ornamental Motif */}
          <div className="cdp-hero__ornament cdp-hero__ornament--tl"></div>
          <div className="cdp-hero__ornament cdp-hero__ornament--br"></div>

          <div className="cdp-hero__inner">
            <div className="cdp-hero__left fade-up">
              <button onClick={() => navigate(-1)} className="cdp-back-btn" aria-label="Quay lại" style={{ position: 'relative', top: 0, left: 0, display: 'inline-flex', marginBottom: '24px', width: 'fit-content', background: 'transparent', border: 'none', color: '#f8c97a', cursor: 'pointer', alignItems: 'center', gap: '8px', fontSize: '1rem' }}>
                <FiArrowLeft /> <span>Quay lại</span>
              </button>

              <div className="cdp-hero__badge">
                <span className="cdp-hero__badge-dot"></span>
                Ẩm thực miền Bắc
              </div>

              <h1 className="cdp-hero__title">
                Phở Bò Hà Nội
              </h1>

              <p className="cdp-hero__subtitle">
                Món ăn linh hồn của nền ẩm thực Việt Nam, nước dùng thanh ngọt từ xương bò, bánh phở mềm mại cùng hương thơm độc đáo của hồi và quế.
              </p>

              <div className="cdp-hero__stats">
                <div className="cdp-hero__stat">
                  <strong>4 giờ</strong>
                  <span>Thời gian chế biến</span>
                </div>
                <div className="cdp-hero__stat-sep"></div>
                <div className="cdp-hero__stat">
                  <strong>Trung bình</strong>
                  <span>Độ khó</span>
                </div>
                <div className="cdp-hero__stat-sep"></div>
                <div className="cdp-hero__stat">
                  <strong>450 kcal</strong>
                  <span>Năng lượng</span>
                </div>
              </div>

              <nav className="cdp-hero__nav-inline">
                {navItems.map((item, idx) => (
                  <div key={idx} className="cdp-nav-item">
                    <div className="cdp-nav-icon">{item.icon}</div>
                    <span className="cdp-nav-label">{item.label}</span>
                  </div>
                ))}
              </nav>
            </div>

            <div className="cdp-hero__right fade-up delay-1">
              <div className="cdp-hero__img-frame">
                <img src="https://images.unsplash.com/photo-1582878826629-29b7ad1cb431?w=600&q=80" alt="Phở Bò" className="cdp-hero__img-main" />
                <div className="cdp-hero__img-ring"></div>
              </div>
            </div>
          </div>

          <div className="cdp-section-wave">
            <svg data-name="Layer 1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1200 120" preserveAspectRatio="none">
              <path d="M321.39,56.44c58-10.79,114.16-30.13,172-41.86,82.39-16.72,168.19-17.73,250.45-.39C823.78,31,906.67,72,985.66,92.83c70.05,18.48,146.53,26.09,214.34,3V0H0V27.35A600.21,600.21,0,0,0,321.39,56.44Z" fill="#ffffff"></path>
            </svg>
          </div>
        </section>

        {/* INTRODUCTION */}
        <section className="cdp-section cdp-section--light cdp-intro">
          <div className="cdp-container">
            <div className="cdp-intro__grid">
              <div className="cdp-intro__text">
                <header className="cdp-intro__header fade-up" style={{ marginBottom: '32px' }}>
                  <span className="cdp-section-badge" style={{ margin: 0 }}>Hương vị truyền thống</span>
                  <h2 className="cdp-section-title" style={{ textAlign: 'left', marginTop: '8px' }}>Giới thiệu về Phở Bò</h2>
                </header>
                <span className="cdp-drop-cap">P</span>
                <div className="cdp-intro__body">
                  <p>
                    Phở bò là món ăn linh hồn của ẩm thực Việt Nam, có nguồn gốc từ Hà Nội. Hương vị đặc trưng của phở nằm ở nước dùng được ninh từ xương bò trong nhiều giờ đồng hồ, kết hợp cùng các gia vị như hồi, quế, gừng và mộc qua.
                  </p>
                  <p style={{ marginTop: '20px' }}>
                    Bánh phở mềm mại, thịt bò tươi ngon và rau thơm tạo nên một tô phở hoàn hảo. Mỗi buổi sáng sớm, hình ảnh những quán phở nghi ngút khói đã trở thành biểu tượng văn hóa bình dị mà khó phai trong tâm trí người Việt.
                  </p>
                </div>
              </div>
              <div className="cdp-intro__image">
                <img src="https://images.unsplash.com/photo-1547592166-23ac45744acd?q=80&w=2071&auto=format&fit=crop" alt="Phở Bò Hà Nội" />
              </div>
            </div>
          </div>
        </section>

        {/* INGREDIENTS (Textiles Layout) */}
        <section className="cdp-section cdp-section--cream cdp-textiles">
          <div className="cdp-container">
            <header className="cdp-section-header">
              <span className="cdp-section-badge">Nguyên liệu chọn lọc</span>
              <h2 className="cdp-section-title">Tinh Hoa Đất Trời Trên Mâm Phở</h2>
              <p className="cdp-section-subtitle">Chất lượng của tô phở phụ thuộc vào sự tươi ngon của nguyên liệu và tỷ lệ gia truyền hoàn hảo.</p>
            </header>

            <div className="cdp-textiles-grid">
              <img src="https://images.unsplash.com/photo-1626242372480-164c673ba718?w=600&q=80" alt="Xương bò" className="cdp-textile-img" />
              <img src="https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=600&q=80" alt="Gia vị" className="cdp-textile-img" />
              <img src="https://images.unsplash.com/photo-1555126634-323283e090fa?w=600&q=80" alt="Bánh phở tươi" className="cdp-textile-img" />
            </div>

            <p className="cdp-textiles-footer">
              1kg xương ống bò, thịt nạm, bánh phở tươi, hành tây, gừng nướng, hoa hồi, quế, thảo quả... Tất cả hòa quyện tạo nên nước dùng thanh ngọt mặn mà khó quên.
            </p>
          </div>
        </section>

        {/* RECIPE STEPS (Festivals Layout) */}
        <section className="cdp-section cdp-section--light cdp-festivals">
          <div className="cdp-container">
            <header className="cdp-section-header">
              <span className="cdp-section-badge">Các bước thực hiện</span>
              <h2 className="cdp-section-title">Cách Chế Biến</h2>
            </header>

            <div className="cdp-festival-grid">
              <div className="cdp-fest-card">
                <img src="https://images.unsplash.com/photo-1582878826629-29b7ad1cb431?w=600&q=80" alt="Bước 1" className="cdp-fest-img" />
                <div className="cdp-fest-content">
                  <span className="cdp-fest-tag">Bước 1</span>
                  <h3 className="cdp-fest-title">Sơ chế nguyên liệu</h3>
                  <p className="cdp-fest-desc">Rửa sạch xương và thịt bò, chần qua nước sôi loại bỏ bọt bẩn. Nướng hành tây và gừng trên bếp củi đến khi thơm phức.</p>
                </div>
              </div>

              <div className="cdp-fest-card">
                <img src="https://images.unsplash.com/photo-1583096114844-06ce6a5f2171?w=600&q=80" alt="Bước 2" className="cdp-fest-img" />
                <div className="cdp-fest-content">
                  <span className="cdp-fest-tag">Bước 2</span>
                  <h3 className="cdp-fest-title">Ninh nước dùng</h3>
                  <p className="cdp-fest-desc">Cho xương bò vào nồi lớn, đun với lửa liu riu 3-4 giờ. Rang thơm hồi, quế, thảo quả rồi cho vào nồi cùng đường phèn, muối, nước mắm.</p>
                </div>
              </div>

              <div className="cdp-fest-card">
                <img src="https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=600&q=80" alt="Bước 3" className="cdp-fest-img" />
                <div className="cdp-fest-content">
                  <span className="cdp-fest-tag">Bước 3</span>
                  <h3 className="cdp-fest-title">Trình bày & Hoàn thiện</h3>
                  <p className="cdp-fest-desc">Luộc thịt nạm chín, vớt ra để nguội. Trụng bánh phở, xếp thịt bò nạm và tái lên trên, chan nước dùng rực nóng, thêm hành ngò.</p>
                </div>
              </div>
            </div>
          </div>
        </section>

        {/* HOW TO ENJOY (Music/Arts Layout) */}
        <section className="cdp-section cdp-section--cream cdp-music">
          <div className="cdp-container">
            <div className="cdp-arch__grid">
              <div className="cdp-arch-text">
                <span className="cdp-section-badge">Nghệ thuật ẩm thực</span>
                <h2 className="cdp-section-title">Cách Thưởng Thức</h2>
                <p className="cdp-intro__body">
                  Ăn nóng khi nước dùng còn đang sủi tăm để phần thịt tái chín tới. Vắt một lát chanh tươi, thêm vài lát ớt chỉ thiên cay nồng và ăn kèm theo bánh quẩy giòn tan. Dùng nước mắm pha chanh ớt để chấm những miếng thịt nạm giòn mềm, ngập ngụa hương vị béo ngậy mặn mòi.
                </p>
              </div>
              <div className="cdp-arch-image">
                <img src="https://images.unsplash.com/photo-1555939594-58d7cb561ad1?w=600&q=80" alt="Thưởng thức Phở" className="cdp-arch-img" />
              </div>
            </div>
          </div>
        </section>

        {/* SIMILAR FOODS (Cuisine Layout) */}
        <section className="cdp-section cdp-section--light cdp-cuisine">
          <div className="cdp-container">
            <header className="cdp-section-header">
              <span className="cdp-section-badge">Gợi ý thêm</span>
              <h2 className="cdp-section-title">Món ăn tương tự</h2>
            </header>
            <div className="cdp-cuisine-grid">
              <div className="cdp-cuisine-item" onClick={() => navigate('/cuisine/bun-bo-hue')} style={{ cursor: 'pointer' }}>
                <img src="https://images.unsplash.com/photo-1582878826629-29b7ad1cb438?q=80&w=1964&auto=format&fit=crop" alt="Bún Bò Huế" className="cdp-cuisine-img" />
                <h3 className="cdp-cuisine-title">Bún Bò Huế</h3>
              </div>
              <div className="cdp-cuisine-item" onClick={() => navigate('/cuisine/bun-cha')} style={{ cursor: 'pointer' }}>
                <img src="https://images.unsplash.com/photo-1555126634-ba092c2ddf7f?q=80&w=2070&auto=format&fit=crop" alt="Bún Chả" className="cdp-cuisine-img" />
                <h3 className="cdp-cuisine-title">Bún Chả Hà Nội</h3>
              </div>
              <div className="cdp-cuisine-item" onClick={() => navigate('/cuisine/banh-mi')} style={{ cursor: 'pointer' }}>
                <img src="https://images.unsplash.com/photo-1509722747041-616f39b57569?q=80&w=2070&auto=format&fit=crop" alt="Bánh Mì" className="cdp-cuisine-img" />
                <h3 className="cdp-cuisine-title">Bánh Mì</h3>
              </div>
            </div>
          </div>
        </section>

        {/* SECRET TIP (Architecture Layout) */}
        <section className="cdp-section cdp-section--cream cdp-architecture">
          <div className="cdp-container">
            <div className="cdp-arch__grid">
              <div className="cdp-arch-image">
                <img src="https://images.unsplash.com/photo-1547592166-23ac45744acd?q=80&w=2071&auto=format&fit=crop" alt="Bí quyết nấu ăn" className="cdp-arch-img" />
              </div>
              <div className="cdp-arch-text">
                <span className="cdp-section-badge">Góc ẩm thực</span>
                <h2 className="cdp-section-title">Bí Quyết Nước Dùng Vàng</h2>
                <p className="cdp-intro__body">
                  Để nước phở trong mà không bị đục, cốt yếu phải ngâm rửa xương sạch sẽ. Trong lúc ninh tuyệt đối không được đậy nắp kín và phớt bỏ lớp bọt nổi lên liên tục. Phần hoa hồi quế thảo quả nhớ phải rang hoặc nướng chín, và cho vào túi vải để mảnh vụn không bị lẫn vào nồi.
                </p>
              </div>
            </div>
          </div>
        </section>

        {/* GALLERY */}
        <section className="cdp-section cdp-section--light cdp-gallery">
          <div className="cdp-container">
            <header className="cdp-section-header">
              <h2 className="cdp-section-title">Thư viện hình ảnh</h2>
              <p className="cdp-section-subtitle">Góc nhìn chân thực, tinh tế về độ ngon của phở.</p>
            </header>

            <div className="cdp-gallery-grid">
              <div className="cdp-gallery-item large"><img src="https://images.unsplash.com/photo-1547592166-23ac45744acd?q=80&w=2071&auto=format&fit=crop" alt="G1" /></div>
              <div className="cdp-gallery-item"><img src="https://images.unsplash.com/photo-1582878826629-29b7ad1cb431?w=600&q=80" alt="G2" /></div>
              <div className="cdp-gallery-item tall"><img src="https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=600&q=80" alt="G3" /></div>
              <div className="cdp-gallery-item"><img src="https://images.unsplash.com/photo-1555939594-58d7cb561ad1?w=600&q=80" alt="G4" /></div>
              <div className="cdp-gallery-item wide"><img src="https://images.unsplash.com/photo-1555126634-323283e090fa?w=600&q=80" alt="G5" /></div>
              <div className="cdp-gallery-item"><img src="https://images.unsplash.com/photo-1626242372480-164c673ba718?w=600&q=80" alt="G6" /></div>
            </div>
          </div>
        </section>

        {/* CTA BANNER */}
        <section className="cdp-cta-banner">
          <div className="cdp-container" style={{ textAlign: 'center' }}>
            <h2 className="cdp-cta-title" style={{ fontSize: '2rem', marginBottom: '24px', color: '#1a0a04' }}>Khám phá nền ẩm thực Việt</h2>
            <Link to="/cuisine" className="primary-button" style={{
              display: 'inline-flex', padding: '12px 32px', background: 'linear-gradient(90deg, #d97706, #dc2626)',
              color: 'white', borderRadius: '50px', fontWeight: 'bold', textDecoration: 'none'
            }}>
              Trở lại danh sách món ăn
            </Link>
          </div>
        </section>
      </main>

      <Footer lang={lang} />
    </div>
  );
}

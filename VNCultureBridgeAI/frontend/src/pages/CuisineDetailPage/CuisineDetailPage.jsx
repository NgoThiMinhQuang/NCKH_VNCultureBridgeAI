import React, { useState, useEffect } from 'react';
import { useNavigate, useParams, Link } from 'react-router-dom';
import PageHeader from '../../components/layout/PageHeader/PageHeader';
import Footer from '../../components/layout/Footer/Footer';
import './CuisineDetailPage.css';

export default function CuisineDetailPage() {
  const [lang, setLang] = useState('vi');
  const navigate = useNavigate();
  const { id } = useParams();

  // Scroll to top on mount
  useEffect(() => {
    window.scrollTo(0, 0);
  }, []);

  const copy = {
    vi: {
      nav: ['Trang chủ', 'Khám phá vùng miền', 'Văn hóa dân tộc', 'Lễ hội', 'Ẩm thực', 'Tìm hiểu', 'Blog'],
    },
    en: {
      nav: ['Home', 'Regions', 'Ethnic', 'Festivals', 'Cuisine', 'Explore', 'Blog'],
    }
  };

  const currentCopy = copy[lang];

  return (
    <div className="cdp-shell">
      <PageHeader
        lang={lang}
        onLangChange={setLang}
        renderNav={() => (
          <nav className="ph__nav" aria-label="Main navigation">
            <Link to="/" className="ph__nav-link">{currentCopy.nav[0]}</Link>
            <Link to="/regions" className="ph__nav-link">{currentCopy.nav[1]}</Link>
            <Link to="/ethnic-groups" className="ph__nav-link">{currentCopy.nav[2]}</Link>
            <Link to="/festivals" className="ph__nav-link">{currentCopy.nav[3]}</Link>
            <Link to="/cuisine" className="ph__nav-link" aria-current="page">{currentCopy.nav[4]}</Link>
            <Link to="/articles" className="ph__nav-link">{currentCopy.nav[5]}</Link>
            <Link to="/blog" className="ph__nav-link">{currentCopy.nav[6]}</Link>
          </nav>
        )}
      />

      <main className="cdp-main fade-up">
        <div className="cdp-container">
          {/* Back button */}
          <button className="cdp-back-btn" onClick={() => navigate(-1)}>
            &lt; Quay lại
          </button>

          {/* Top Section */}
          <div className="cdp-top-section">
            <div className="cdp-image-wrapper">
              <img 
                src="https://images.unsplash.com/photo-1547592166-23ac45744acd?q=80&w=2071&auto=format&fit=crop" 
                alt="Phở Bò" 
                className="cdp-main-img" 
              />
            </div>
            
            <div className="cdp-top-info">
              <div className="cdp-badges">
                <span className="cdp-badge-type">Món chính</span>
                <span className="cdp-badge-rating">★ 4.9</span>
              </div>
              
              <h1 className="cdp-title">Phở Bò</h1>
              <p className="cdp-short-desc">
                Món ăn truyền thống nổi tiếng của Việt Nam với nước dùng thanh ngọt từ xương bò.
              </p>

              <div className="cdp-stats-grid">
                <div className="cdp-stat-card">
                  <div className="cdp-stat-icon">⏱</div>
                  <div className="cdp-stat-text">
                    <span className="cdp-stat-label">Thời gian</span>
                    <span className="cdp-stat-value">4 giờ</span>
                  </div>
                </div>
                <div className="cdp-stat-card">
                  <div className="cdp-stat-icon">🔥</div>
                  <div className="cdp-stat-text">
                    <span className="cdp-stat-label">Độ khó</span>
                    <span className="cdp-stat-value">Trung bình</span>
                  </div>
                </div>
                <div className="cdp-stat-card">
                  <div className="cdp-stat-icon">⚡</div>
                  <div className="cdp-stat-text">
                    <span className="cdp-stat-label">Năng lượng</span>
                    <span className="cdp-stat-value">450 kcal</span>
                  </div>
                </div>
                <div className="cdp-stat-card">
                  <div className="cdp-stat-icon">📌</div>
                  <div className="cdp-stat-text">
                    <span className="cdp-stat-label">Khẩu vị</span>
                    <span className="cdp-stat-value">Miền Bắc</span>
                  </div>
                </div>
              </div>
            </div>
          </div>

          {/* Cards Section */}
          <div className="cdp-content-cards">
            {/* Intro */}
            <div className="cdp-card">
              <h2 className="cdp-card-title">
                <span className="cdp-card-icon">🍲</span> Giới thiệu món ăn
              </h2>
              <div className="cdp-card-body">
                <p>Phở bò là món ăn linh hồn của ẩm thực Việt Nam, có nguồn gốc từ Hà Nội. Hương vị đặc trưng của phở nằm ở nước dùng được ninh từ xương bò trong nhiều giờ đồng hồ, kết hợp cùng các gia vị như hồi, quế, gừng và mộc qua. Bánh phở mềm mại, thịt bò tươi ngon và rau thơm tạo nên một tô phở hoàn hảo.</p>
              </div>
            </div>

            {/* Ingredients */}
            <div className="cdp-card">
              <h2 className="cdp-card-title">
                <span className="cdp-card-icon">✓</span> Nguyên liệu
              </h2>
              <div className="cdp-card-body cdp-ingredients-grid">
                <div>
                  <h3 className="cdp-ing-category">Nguyên liệu chính</h3>
                  <ul className="cdp-ing-list">
                    <li><span>✓</span> 1kg xương ống bò</li>
                    <li><span>✓</span> 500g thịt bò nạm</li>
                    <li><span>✓</span> 300g thịt bò tái</li>
                    <li><span>✓</span> 500g bánh phở tươi</li>
                    <li><span>✓</span> 1 củ hành tây</li>
                    <li><span>✓</span> 100g gừng</li>
                  </ul>
                </div>
                <div>
                  <h3 className="cdp-ing-category">Gia vị</h3>
                  <ul className="cdp-ing-list">
                    <li><span>✓</span> 2 hoa hồi</li>
                    <li><span>✓</span> 1 thanh quế</li>
                    <li><span>✓</span> 1 hạt thảo quả</li>
                    <li><span>✓</span> Vài nụ đinh hương</li>
                    <li><span>✓</span> Nước mắm, muối, đường phèn</li>
                    <li><span>✓</span> Bột ngọt (tùy chọn)</li>
                  </ul>
                </div>
                <div>
                  <h3 className="cdp-ing-category">Rau ăn kèm</h3>
                  <ul className="cdp-ing-list">
                    <li><span>✓</span> Hành lá, ngò rí</li>
                    <li><span>✓</span> Hành tây thái mỏng</li>
                    <li><span>✓</span> Giá đỗ tươi</li>
                    <li><span>✓</span> Húng quế, ngò gai</li>
                    <li><span>✓</span> Chanh, ớt tươi</li>
                  </ul>
                </div>
              </div>
            </div>

            {/* Instructions */}
            <div className="cdp-card">
              <h2 className="cdp-card-title">
                <span className="cdp-card-icon">📋</span> Cách chế biến
              </h2>
              <div className="cdp-card-body">
                <div className="cdp-step">
                  <span className="cdp-step-num">1</span>
                  <p>Rửa sạch xương và thịt bò, chần qua nước sôi để loại bỏ bọt bẩn.</p>
                </div>
                <div className="cdp-step">
                  <span className="cdp-step-num">2</span>
                  <p>Nướng hành tây và gừng trên bếp đến khi thơm.</p>
                </div>
                <div className="cdp-step">
                  <span className="cdp-step-num">3</span>
                  <p>Cho xương bò vào nồi nước lớn, ninh trong thơi gian 3-4 giờ với lửa nhỏ.</p>
                </div>
                <div className="cdp-step">
                  <span className="cdp-step-num">4</span>
                  <p>Rang thơm hồi, quế, thảo quả, đinh hương rồi cho vào nồi nước dùng.</p>
                </div>
                <div className="cdp-step">
                  <span className="cdp-step-num">5</span>
                  <p>Nêm nếm nước dùng với nước mắm, muối, đường cho vừa khẩu vị.</p>
                </div>
                <div className="cdp-step">
                  <span className="cdp-step-num">6</span>
                  <p>Luộc thịt nạm chín, vớt ra để nguội. Thái thịt bò tái mỏng.</p>
                </div>
                <div className="cdp-step">
                  <span className="cdp-step-num">7</span>
                  <p>Trụng bánh phở qua nước sôi, cho vào tô.</p>
                </div>
                <div className="cdp-step">
                  <span className="cdp-step-num">8</span>
                  <p>Xếp thịt bò nạm và tái lên trên, chan nước dùng nóng, thêm hành ngò.</p>
                </div>
              </div>
            </div>

            {/* How to enjoy */}
            <div className="cdp-card cdp-card-accent">
              <h2 className="cdp-card-title cdp-text-white">
                <span className="cdp-card-icon">🥢</span> Cách thưởng thức
              </h2>
              <div className="cdp-card-body">
                <ul className="cdp-enjoy-list">
                  <li>Ăn nóng khi nước dùng còn sôi để thịt tái chín tới.</li>
                  <li>Ăn kèm với giá đỗ, húng quế, ngò gai, chanh và ớt tùy khẩu vị.</li>
                  <li>Nêm thêm tương ớt hoặc sa tế nếu thích ăn cay.</li>
                  <li>Dùng nước mắm pha chanh ớt để chấm thịt bò.</li>
                </ul>
              </div>
            </div>
          </div>

          {/* Similar Foods */}
          <div className="cdp-similar-section">
            <h2 className="cdp-similar-title">Món ăn tương tự</h2>
            <div className="cdp-similar-grid">
              {/* Similar 1 */}
              <div className="cdp-dish-card">
                <div className="cdp-dish-image-wrapper">
                  <img 
                    src="https://images.unsplash.com/photo-1582878826629-29b7ad1cb438?q=80&w=1964&auto=format&fit=crop" 
                    alt="Bún Bò Huế" 
                    className="cdp-dish-img" 
                  />
                </div>
                <div className="cdp-dish-info">
                  <div className="cdp-dish-meta">
                    <span className="cdp-badge-trung">Miền Trung</span>
                    <span className="cdp-rating">★ 4.8</span>
                  </div>
                  <h3>Bún Bò Huế</h3>
                  <p>Bún sợi to, nước dùng thơm xả, ruốc, cay nồng đậm vị.</p>
                  <div className="cdp-dish-footer">
                    <span className="cdp-dish-time">⏱ 3 giờ</span>
                    <button className="cdp-action-btn-sm" onClick={() => navigate('/cuisine/bun-bo-hue')}>Xem chi tiết</button>
                  </div>
                </div>
              </div>

              {/* Similar 2 */}
              <div className="cdp-dish-card">
                <div className="cdp-dish-image-wrapper">
                  <img 
                    src="https://images.unsplash.com/photo-1555126634-ba092c2ddf7f?q=80&w=2070&auto=format&fit=crop" 
                    alt="Bún Chả" 
                    className="cdp-dish-img" 
                  />
                </div>
                <div className="cdp-dish-info">
                  <div className="cdp-dish-meta">
                    <span className="cdp-badge-bac">Miền Bắc</span>
                    <span className="cdp-rating">★ 4.9</span>
                  </div>
                  <h3>Bún Chả</h3>
                  <p>Thịt lợn nướng chả chấm nước mắm pha chua ngọt thanh nhẹ.</p>
                  <div className="cdp-dish-footer">
                    <span className="cdp-dish-time">⏱ 1.5 giờ</span>
                    <button className="cdp-action-btn-sm" onClick={() => navigate('/cuisine/bun-cha')}>Xem chi tiết</button>
                  </div>
                </div>
              </div>

              {/* Similar 3 */}
              <div className="cdp-dish-card">
                <div className="cdp-dish-image-wrapper">
                  <img 
                    src="https://images.unsplash.com/photo-1509722747041-616f39b57569?q=80&w=2070&auto=format&fit=crop" 
                    alt="Bánh Mì" 
                    className="cdp-dish-img" 
                  />
                </div>
                <div className="cdp-dish-info">
                  <div className="cdp-dish-meta">
                    <span className="cdp-badge-nam">Miền Nam</span>
                    <span className="cdp-rating">★ 4.7</span>
                  </div>
                  <h3>Bánh Mì Việt Nam</h3>
                  <p>Vỏ bánh giòn rụm, nhân thịt nguội, bơ, pâté và dưa góp.</p>
                  <div className="cdp-dish-footer">
                    <span className="cdp-dish-time">⏱ 30 phút</span>
                    <button className="cdp-action-btn-sm" onClick={() => navigate('/cuisine/banh-mi')}>Xem chi tiết</button>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </main>

      <Footer lang={lang} />
    </div>
  );
}

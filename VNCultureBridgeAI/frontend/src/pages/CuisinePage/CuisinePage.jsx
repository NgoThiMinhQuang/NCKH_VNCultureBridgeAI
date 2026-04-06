import React, { useState } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import PageHeader from '../../components/layout/PageHeader/PageHeader';
import Footer from '../../components/layout/Footer/Footer';
import './CuisinePage.css';

export default function CuisinePage() {
  const [lang, setLang] = useState('vi');
  const navigate = useNavigate();

  // Hardcoded layout properties to match exactly what is in the Figma image.
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
    <div className="page-shell cuisine-page">
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

      <main>
        {/* HERO SECTION */}
        <section className="cp-hero fade-up">
          <div className="cp-hero__content">
            <h1>Khám phá ẩm thực 3 miền<br />Việt Nam</h1>
            <p>
              Từ miền Bắc tinh tế, miền Trung đậm đà đến miền Nam ngọt ngào - mỗi vùng<br />miền mang một linh hồn và câu chuyện vần hương vị khác nhau.
            </p>
            <button className="cp-primary-btn">Khám phá ngay</button>
          </div>
        </section>

        {/* REGIONS SECTION */}
        <section className="cp-section cp-regions">
          <div className="cp-section-header">
            <h2>Ba miền ẩm thực đặc sắc</h2>
            <p>Khám phá mâm cơm tương trưng cho triết lý âm dương, ngũ hành tinh hoa của 3 miền đất nước.</p>
          </div>

          <div className="cp-grid-3">
            <div className="cp-region-card cp-card-bac">
              <div className="cp-region-overlay"></div>
              <div className="cp-region-content">
                <h3>Miền Bắc</h3>
                <p>Ẩm thực tinh tế, nhẹ nhàng đề cao hương vị tự nhiên của nguyên liệu. Vị thanh tao, vừa phải.</p>
                <div className="cp-tags">
                  <span>Tinh tế</span>
                  <span>Nhẹ nhàng</span>
                  <span>Thanh tao</span>
                </div>
              </div>
            </div>

            <div className="cp-region-card cp-card-trung">
              <div className="cp-region-overlay"></div>
              <div className="cp-region-content">
                <h3>Miền Trung</h3>
                <p>Mặn mòi, đậm đà với những gia vị cay nồng mang linh hồn của dải đất quanh năm nắng gió.</p>
                <div className="cp-tags">
                  <span>Đậm đà</span>
                  <span>Cay nồng</span>
                  <span>Đặc sắc</span>
                </div>
              </div>
            </div>

            <div className="cp-region-card cp-card-nam">
              <div className="cp-region-overlay"></div>
              <div className="cp-region-content">
                <h3>Miền Nam</h3>
                <p>Ngọt ngào, béo ngậy với vị cốt dừa đặc trưng, phóng khoáng như chính con người nơi đây.</p>
                <div className="cp-tags">
                  <span>Ngọt thanh</span>
                  <span>Đa dạng</span>
                  <span>Phóng khoáng</span>
                </div>
              </div>
            </div>
          </div>
        </section>

        {/* SIGNATURE DISHES SECTION */}
        <section className="cp-section cp-dishes cp-section-alternate">
          <div className="cp-section-header">
            <span className="cp-divider"></span>
            <h2>Món ăn tiêu biểu</h2>
            <span className="cp-divider"></span>
            <p className="cp-subline">Những món ăn đặc trưng định danh văn hóa ẩm thực của từng vùng miền.</p>
          </div>

          <div className="cp-grid-3 cp-dishes-grid">
            <div className="cp-dish-card">
              <div className="cp-dish-image dish-1">
                <span className="cp-badge-bac">Bắc</span>
              </div>
              <div className="cp-dish-info">
                <h3>Phở Hà Nội</h3>
                <p>Nước dùng thanh tao được ninh từ xương bò cùng các loại gia vị đại hồi, thảo quả, quế hương đem lại hương thơm đặc biệt.</p>
                <button className="cp-action-btn" onClick={() => navigate('/cuisine/pho-ha-noi')}>Xem chi tiết</button>
              </div>
            </div>

            <div className="cp-dish-card">
              <div className="cp-dish-image dish-2">
                <span className="cp-badge-bac">Bắc</span>
              </div>
              <div className="cp-dish-info">
                <h3>Bún Chả Hà Nội</h3>
                <p>Thịt lợn nướng chả nướng thơm lừng ăn kèm với bún gạo trắng và nước mắm chua ngọt thanh đạm, rau thơm thanh nhẹ.</p>
                <button className="cp-action-btn" onClick={() => navigate('/cuisine/bun-cha')}>Xem chi tiết</button>
              </div>
            </div>

            <div className="cp-dish-card">
              <div className="cp-dish-image dish-3">
                <span className="cp-badge-trung">Trung</span>
              </div>
              <div className="cp-dish-info">
                <h3>Bún Bò Huế</h3>
                <p>Nước dùng thơm nồng mùi mắm ruốc xả, sơi bún to dai, bò bắp thái mỏng, giò heo đậm đà đặc trưng vùng Huế.</p>
                <button className="cp-action-btn" onClick={() => navigate('/cuisine/bun-bo-hue')}>Xem chi tiết</button>
              </div>
            </div>

            <div className="cp-dish-card">
              <div className="cp-dish-image dish-4">
                <span className="cp-badge-trung">Trung</span>
              </div>
              <div className="cp-dish-info">
                <h3>Mì Quảng</h3>
                <p>Sợi mì vàng ươm nghệ, tôm thịt đậm đà rim mềm, phong vị đặc trưng của vùng Quảng Nam, Đà Nẵng.</p>
                <button className="cp-action-btn" onClick={() => navigate('/cuisine/mi-quang')}>Xem chi tiết</button>
              </div>
            </div>

            <div className="cp-dish-card">
              <div className="cp-dish-image dish-5">
                <span className="cp-badge-nam">Nam</span>
              </div>
              <div className="cp-dish-info">
                <h3>Hủ Tiếu Nam Vang</h3>
                <p>Sợi hủ tiếu dai ngon, tôm càng xanh, thịt băm, gan heo lòng heo tạo nên hương vị đặc trưng miền sông nước.</p>
                <button className="cp-action-btn" onClick={() => navigate('/cuisine/hu-tieu')}>Xem chi tiết</button>
              </div>
            </div>

            <div className="cp-dish-card">
              <div className="cp-dish-image dish-6">
                <span className="cp-badge-nam">Nam</span>
              </div>
              <div className="cp-dish-info">
                <h3>Cơm Tấm Sài Gòn</h3>
                <p>Cơm tấm mềm dẻo cùng sườn nướng mỡ hành thơm nức vức, bì chả dai giòn, nét văn hóa đặc sắc Sài Gòn.</p>
                <button className="cp-action-btn" onClick={() => navigate('/cuisine/com-tam')}>Xem chi tiết</button>
              </div>
            </div>
          </div>
        </section>

        {/* FEATURED STORY */}
        <section className="cp-section cp-story">
          <div className="cp-section-header">
            <span className="cp-divider"></span>
            <h2>Câu chuyện ẩm thực</h2>
            <span className="cp-divider"></span>
          </div>

          <div className="cp-story-container">
            <div className="cp-story-image"></div>
            <div className="cp-story-content">
              <span className="cp-story-tag">Văn hóa Truyền thống</span>
              <h3>Bàn tay người phụ nữ Việt và hồn ẩm thực</h3>
              <p>Trải qua bao thăng trầm định hình văn hóa, hình ảnh người phụ nữ Việt tảo tần trong gian bếp luôn là minh chứng cho sự gìn giữ bếp lửa truyền thống, hương vị gia đình.</p>
              <p>Mỗi món ăn mang ra mâm cơm không chỉ là sự kết hợp của nguyên vật liệu, của món ăn đặc sản vùng miền, mà còn là tâm tình sâu sắc yêu mến của người phụ nữ Việt.</p>
              <button className="cp-action-btn cp-action-btn-sm">Đọc thêm</button>
            </div>
          </div>
        </section>

        {/* EXPERIENCES (BLOG) */}
        <section className="cp-section cp-experiences cp-section-alternate">
          <div className="cp-section-header">
            <h2>Trải nghiệm ẩm thực</h2>
            <p className="cp-subline">Những bài viết mộc mạc và chân thực về nét đẹp văn hóa ẩm thực Việt Nam.</p>
          </div>

          <div className="cp-grid-3">
            <div className="cp-exp-card">
              <div className="cp-exp-image exp-1">
                <span className="cp-exp-badge">Review</span>
              </div>
              <div className="cp-exp-info">
                <span className="cp-exp-date">15 Tháng 5, 2024</span>
                <h3>Văn hóa ẩm thực đường phố Hà Nội</h3>
                <p>Khám phá nhịp sống hối hả cùng những gánh hàng rong, quán vỉa hè quen thuộc mang đậm vẻ đẹp văn hóa ngàn năm văn hiến.</p>
                <a href="#" className="cp-readmore">Đọc câu chuyện →</a>
              </div>
            </div>

            <div className="cp-exp-card">
              <div className="cp-exp-image exp-2">
                <span className="cp-exp-badge">Blog</span>
              </div>
              <div className="cp-exp-info">
                <span className="cp-exp-date">21 Tháng 8, 2024</span>
                <h3>Lễ hội ẩm thực cung nhã đình Huế</h3>
                <p>Tái hiện lại những bữa tiệc cung đình Huế trong cái nôi tinh hoa một nền văn hóa xưa, nơi ẩm thực đỉnh cao nghệ thuật.</p>
                <a href="#" className="cp-readmore">Đọc câu chuyện →</a>
              </div>
            </div>

            <div className="cp-exp-card">
              <div className="cp-exp-image exp-3">
                <span className="cp-exp-badge">Truyền thống</span>
              </div>
              <div className="cp-exp-info">
                <span className="cp-exp-date">02 Tháng 9, 2024</span>
                <h3>Bữa cơm gia đình - Linh hồn ẩm thực Việt</h3>
                <p>Nét đẹp mộc mạc, đậm đà tình thân xoay quanh mâm cơm của một gia đình trọn vẹn yêu thương từ những điều rất đỗi giản dị.</p>
                <a href="#" className="cp-readmore">Đọc câu chuyện →</a>
              </div>
            </div>
          </div>
        </section>
      </main>

      <Footer lang={lang} />
    </div>
  );
}

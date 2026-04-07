import React, { useState } from 'react';
import { Link } from 'react-router-dom';
import './EthnicCulturesPage.css';
import PageHeader from '../../components/layout/PageHeader/PageHeader';
import Footer from '../../components/layout/Footer/Footer';
import banner3 from '../../assets/banner3.jpg';
import hmongImg from '../../assets/hmong.jpg';
import daoImg from '../../assets/dao.jpg';
import thaiImg from '../../assets/thai.jpg';
import edeImg from '../../assets/ede.jpg';
import banaImg from '../../assets/bana.jpg';
import khmerImg from '../../assets/khmer.jpg';
import chamImg from '../../assets/cham.jpg';
import muongImg from '../../assets/muong.jpg';
import ruongBacThangImg from '../../assets/ruong-bac-thang.jpg';
import duaBoImg from '../../assets/dua-bo.jpg';
import xoeThaiImg from '../../assets/xoe_thai.png';
import congChiengImg from '../../assets/cong_chieng.png';
import leCapSacImg from '../../assets/le-cap-sac.jpg';
import detThoCamImg from '../../assets/det-tho-cam.jpg';
import muaTrongImg from '../../assets/mua-trong-sadam.jpg';

// Fake Data for mockups
const stats = [
  { value: '54', label: 'Dân tộc', subtext: 'đa dạng và phong phú bản sắc văn hóa' },
  { value: '8', label: 'Vùng văn hóa', subtext: 'với những đặc trưng địa hình, khí hậu' },
  { value: '5,000+', label: 'Lễ hội truyền thống', subtext: 'được tổ chức hằng năm trên cả nước' },
  { value: '1,000,000+', label: 'Hiện vật', subtext: 'về văn hóa các dân tộc đang được lưu giữ' }
];

const filters = [
  "Tất cả dân tộc", "Mường", "Thái", "H'Mông", "Dao", "Kinh", "Khmer"
];

const ethnicCards = [
  { id: 1, name: "Dân tộc Mông", location: "Hà Giang, Sơn La,...", imgUrl: hmongImg, status: "Nổi bật" },
  { id: 2, name: "Dân tộc Dao", location: "Lào Cai, Yên Bái,...", imgUrl: daoImg, status: "" },
  { id: 3, name: "Dân tộc Thái", location: "Điện Biên, Lai Châu,...", imgUrl: thaiImg, status: "" },
  { id: 4, name: "Dân tộc Ê Đê", location: "Đắk Lắk, Đắk Nông,...", imgUrl: edeImg, status: "Mới" },
  { id: 5, name: "Dân tộc Ba Na", location: "Gia Lai, Kon Tum,...", imgUrl: banaImg, status: "" },
  { id: 6, name: "Dân tộc Khmer", location: "Sóc Trăng, Trà Vinh,...", imgUrl: khmerImg, status: "" },
  { id: 7, name: "Dân tộc Chăm", location: "Ninh Thuận, Bình Thuận,...", imgUrl: chamImg, status: "Nổi bật" },
  { id: 8, name: "Dân tộc Mường", location: "Hòa Bình, Thanh Hóa,...", imgUrl: muongImg, status: "" },
];

const features = [
  { id: 1, title: "Lễ hội đua bò Bảy Núi", imgUrl: duaBoImg, tag: "Nổi bật" },
  { id: 2, title: "Nghệ thuật xòe Thái", imgUrl: xoeThaiImg, tag: "" },
  { id: 3, title: "Không gian văn hóa Cồng Chiêng", imgUrl: congChiengImg, tag: "Di sản" },
];

const stories = [
  { id: 1, title: "Lễ Cấp sắc của người Dao đỏ ở Bắc Kạn", desc: "Lễ cấp sắc là một nghi lễ quan trọng đánh dấu sự trưởng thành của người đàn ông dân tộc Dao đỏ.", imgUrl: leCapSacImg },
  { id: 2, title: "Khám phá dệt thổ cẩm của người Lô Lô", desc: "Nghề dệt thổ cẩm truyền thống của người Lô Lô mang đậm nét văn hóa độc đáo với những họa tiết sặc sỡ.", imgUrl: detThoCamImg },
  { id: 3, title: "Nét đặc sắc múa trống Sadam của người Khmer", desc: "Trống Sadam không chỉ là nhạc cụ mà còn là linh hồn trong các lễ hội truyền thống của người Khmer Nam Bộ.", imgUrl: muaTrongImg },
];

const masonryImages = [
  { size: "large", imgUrl: ruongBacThangImg },
  { size: "small", imgUrl: hmongImg },
  { size: "small", imgUrl: chamImg },
  { size: "tall", imgUrl: xoeThaiImg },
  { size: "small", imgUrl: edeImg },
  { size: "wide", imgUrl: duaBoImg },
  { size: "small", imgUrl: congChiengImg },
];

export default function EthnicCultures() {
  const [lang, setLang] = useState('vi');
  const [activeFilter, setActiveFilter] = useState("Tất cả dân tộc");
  const [isDropdownOpen, setIsDropdownOpen] = useState(false);

  return (
    <div className="ec-page-shell">
      <PageHeader
        lang={lang}
        onLangChange={setLang}
      />

      <main className="ec-main">
        {/* HERO SECTION */}
        <section
          className="ec-hero"
          style={{ backgroundImage: `linear-gradient(rgba(30, 15, 10, 0.4), rgba(30, 15, 10, 0.7)), url(${banner3})` }}
        >
          <div className="ec-hero__content fade-up">
            <span className="ec-badge">Khám phá dải đất hình chữ S</span>
            <h1 className="ec-hero__title">Khám phá văn hóa <br />các dân tộc Việt Nam</h1>
            <p className="ec-hero__subtitle">Từ những đỉnh núi mờ sương Tây Bắc đến những bản làng yên bình nơi đồng bằng, khám phá sự đa dạng và giàu có của văn hóa 54 dân tộc anh em.</p>

            <div className="ec-hero__search-opts">
              <button className="ec-opt-btn active">Dân tộc theo nhóm ngôn ngữ</button>
              <button className="ec-opt-btn">Phân bố</button>
              <button className="ec-opt-btn">Thời điểm nổi bật</button>
              <button className="ec-opt-btn">Tìm kiếm</button>
            </div>
          </div>
        </section>

        {/* STATS SECTION */}
        <div className="ec-stats-wrapper">
          <div className="ec-stats fade-up">
            {stats.map((s, idx) => (
              <div className="ec-stat-card" key={idx}>
                <div className="ec-stat-icon"></div>
                <h3 className="ec-stat-val">{s.value}</h3>
                <p className="ec-stat-label">{s.label}</p>
                <span className="ec-stat-sub">{s.subtext}</span>
              </div>
            ))}
          </div>
        </div>

        {/* MAIN GRID - CÁC DÂN TỘC VIỆT NAM */}
        <section className="ec-section ec-section--light">
          <div className="ec-container">
            <div className="ec-section-header ec-center">
              <div className="ec-section-title-wrap">
                <span className="ec-section-eyebrow">Khám phá 54 dân tộc</span>
                <h2 className="ec-section-title">
                  Các dân tộc <span className="ec-text-accent">Việt Nam</span>
                </h2>
                <div className="ec-divider" aria-hidden="true">
                  <span /> <i /> <b /> <span />
                </div>
                <p className="ec-section-desc">Cộng đồng 54 dân tộc thiểu số và người Kinh sinh sống trải dài trên hình chữ S, tạo nên bản sắc văn hóa Việt Nam đa dạng, phong phú.</p>
              </div>
            </div>

            <div className="ec-filters">
              <div className="ec-custom-dropdown">
                <div
                  className={`ec-dropdown-header ${isDropdownOpen ? 'open' : ''}`}
                  onClick={() => setIsDropdownOpen(!isDropdownOpen)}
                >
                  {activeFilter}
                  <span className="ec-dropdown-arrow">▼</span>
                </div>
                {isDropdownOpen && (
                  <ul className="ec-dropdown-list">
                    {filters.map(f => (
                      <li
                        key={f}
                        className={`ec-dropdown-item ${activeFilter === f ? 'selected' : ''}`}
                        onClick={() => {
                          setActiveFilter(f);
                          setIsDropdownOpen(false);
                        }}
                      >
                        {f}
                      </li>
                    ))}
                  </ul>
                )}
              </div>
            </div>

            <div className="ec-grid ec-grid--4cols fade-up">
              {ethnicCards.map(c => (
                <Link to={`/ethnic-groups/${c.id}`} className="ec-card" key={c.id}>
                  <div className="ec-card__img-wrap">
                    {c.status && <span className="ec-card__status">{c.status}</span>}
                    <img src={c.imgUrl} alt={c.name} loading="lazy" />
                  </div>
                  <div className="ec-card__content">
                    <p className="ec-card__loc">
                      <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2"><path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z"></path><circle cx="12" cy="10" r="3"></circle></svg>
                      {c.location}
                    </p>
                    <h3 className="ec-card__title">{c.name}</h3>
                    <span className="ec-card__link">Xem chi tiết</span>
                  </div>
                </Link>
              ))}
            </div>

            <div className="ec-center-action">
              <button className="ec-btn-outline">Xem tất cả dân tộc</button>
            </div>
          </div>
        </section>

        {/* FEATURE HIGHLIGHT - NÉT VĂN HÓA TIÊU BIỂU */}
        <section className="ec-section ec-section--dark">
          <div className="ec-container ec-feature-split">
            <div className="ec-feature-img fade-up">
              <img src={ruongBacThangImg} alt="Nét văn hóa tiêu biểu: Ruộng bậc thang" />
              <div className="ec-feature-img-caption">
                <strong>Ruộng bậc thang Mù Cang Chải</strong>
                <span>Kiệt tác kiến trúc nông nghiệp của đồng bào Mông</span>
              </div>
            </div>
            <div className="ec-feature-text fade-up delay-1">
              <span className="ec-section-eyebrow">Đặc trưng văn hóa</span>
              <h2 className="ec-section-title">Nét văn hóa tiêu biểu<br />của các dân tộc</h2>
              <p className="ec-feature-desc">Mỗi dân tộc có một kho tàng văn hóa riêng biệt, được thể hiện độc đáo qua các khía cạnh phong phú của đời sống: Kiến trúc nhà ở, trang phục truyền thống, lễ hội, hay ẩm thực...</p>

              <ul className="ec-feature-list">
                <li>
                  <div className="ec-fl-icon">🏛️</div>
                  <div className="ec-fl-content">
                    <h4>Kiến trúc</h4>
                    <p>Nhà rông uy nghi, nhà dài mộc mạc, kiến trúc nhà trệt cổ kính mang đậm lối thiết kế bản địa.</p>
                  </div>
                </li>
                <li>
                  <div className="ec-fl-icon">👗</div>
                  <div className="ec-fl-content">
                    <h4>Trang phục</h4>
                    <p>Mỗi hoa văn, chất liệu, màu sắc trang phục đều gửi gắm những câu chuyện văn hóa.</p>
                  </div>
                </li>
                <li>
                  <div className="ec-fl-icon">🎉</div>
                  <div className="ec-fl-content">
                    <h4>Lễ hội</h4>
                    <p>Đồng bào dân tộc tự hào với vô vàn lễ hội phản ánh đời sống tâm linh, nghệ thuật phong phú.</p>
                  </div>
                </li>
                <li>
                  <div className="ec-fl-icon">🍲</div>
                  <div className="ec-fl-content">
                    <h4>Ẩm thực</h4>
                    <p>Hương vị đặc trưng từ rau rừng, thịt sấy, cá suối làm nức lòng du khách.</p>
                  </div>
                </li>
              </ul>
              <button className="ec-btn-primary">Tìm hiểu thêm</button>
            </div>
          </div>
        </section>

        {/* HORIZONTAL GRID - NHỮNG NÉT VĂN HÓA ĐẶC SẮC NHẤT */}
        <section className="ec-section ec-section--light">
          <div className="ec-container">
            <div className="ec-section-header ec-flex-header">
              <div>
                <span className="ec-section-eyebrow">Di sản độc đáo</span>
                <h2 className="ec-section-title">Những nét văn hóa<br />đặc sắc nhất</h2>
              </div>
              <div className="ec-nav-buttons">
                <button className="ec-nav-btn disable">&larr;</button>
                <button className="ec-nav-btn ec-nav-btn--active">&rarr;</button>
              </div>
            </div>

            <div className="ec-grid ec-grid--3cols fade-up">
              {features.map(f => (
                <div className="ec-hcard" key={f.id}>
                  <div className="ec-hcard__img">
                    {f.tag && <span className="ec-card__status">{f.tag}</span>}
                    <img src={f.imgUrl} alt={f.title} loading="lazy" />
                  </div>
                  <div className="ec-hcard__content">
                    <h3 className="ec-hcard__title">{f.title}</h3>
                    <p className="ec-hcard__desc">Khám phá nét độc đáo trong đời sống và tinh thần truyền tải qua hoạt động này.</p>
                    <span className="ec-card__link">Tìm hiểu</span>
                  </div>
                </div>
              ))}
            </div>
          </div>
        </section>

        {/* MASONRY COLLAGE - KHOẢNH KHẮC VĂN HÓA SỐNG ĐỘNG */}
        <section className="ec-section ec-section--dark-alt">
          <div className="ec-container">
            <div className="ec-section-header ec-center">
              <span className="ec-section-eyebrow">Thư viện ảnh</span>
              <h2 className="ec-section-title ec-text-light">Khoảnh khắc văn hóa<br />sống động</h2>
              <p className="ec-section-desc ec-text-light-muted">Những góc nhìn chân thật, chớp lấy vẻ đẹp rực rỡ và nhịp sống đời thường.</p>
            </div>

            <div className="ec-masonry fade-up">
              {masonryImages.map((img, idx) => (
                <div key={idx} className={`ec-masonry-item ec-masonry-item--${img.size}`}>
                  <img src={img.imgUrl} alt="Khoảnh khắc văn hóa" loading="lazy" />
                  <div className="ec-masonry-overlay">
                    <span className="ec-btn-icon">🔍</span>
                  </div>
                </div>
              ))}
            </div>

            <div className="ec-center-action">
              <button className="ec-btn-outline ec-btn-outline--light">Xem thêm thư viện ảnh</button>
            </div>
          </div>
        </section>

        {/* STORIES - CHUYỆN KỂ TỪ BẢN LÀNG XA */}
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
              {stories.map(s => (
                <Link to="/articles/1" className="ec-scard" key={s.id}>
                  <div className="ec-scard__img">
                    <img src={s.imgUrl} alt={s.title} loading="lazy" />
                  </div>
                  <div className="ec-scard__content">
                    <h3 className="ec-scard__title">{s.title}</h3>
                    <p className="ec-scard__desc">{s.desc}</p>
                    <div className="ec-scard__meta">
                      <span className="ec-meta-author">
                        <div className="ec-avatar"></div> VNCulture
                      </span>
                      <span className="ec-meta-date">24 Mar, 2026</span>
                    </div>
                  </div>
                </Link>
              ))}
            </div>
          </div>
        </section>

      </main>

      <Footer lang={lang} />
    </div>
  );
}

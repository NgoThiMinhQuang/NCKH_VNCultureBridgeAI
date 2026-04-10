import React, { useState } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { LuChevronDown, LuSearch } from 'react-icons/lu';
import './CuisinePage.css';
import PageHeader from '../../components/layout/PageHeader/PageHeader';
import Footer from '../../components/layout/Footer/Footer';
import banner3 from '../../assets/banner3.jpg';
import ruongBacThangImg from '../../assets/ruong-bac-thang.jpg';

function SearchIcon(props) {
  return (
    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" {...props}>
      <circle cx="11" cy="11" r="8" />
      <path d="m21 21-4.35-4.35" />
    </svg>
  );
}

function ChevronDownIcon(props) {
  return (
    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" {...props}>
      <path d="m6 9 6 6 6-6" />
    </svg>
  );
}

function VectorDishIcon(props) {
  return (
    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" {...props}>
      <path d="M4 14l3.5 3.5 7-7" />
    </svg>
  );
}

function StarIcon(props) {
  return (
    <svg viewBox="0 0 24 24" fill="currentColor" {...props}>
      <path d="m12 2.5 3.09 6.26 6.91 1.01-5 4.87 1.18 6.88L12 18.3 5.82 21.52 7 14.64 2 9.77l6.91-1.01L12 2.5z" />
    </svg>
  );
}

function CoffeeIcon(props) {
  return (
    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" {...props}>
      <path d="M4 8h13a3 3 0 0 1 0 6H4z" />
      <path d="M4 8v7a4 4 0 0 0 4 4h5a4 4 0 0 0 4-4v-1" />
      <path d="M18 9h2a2 2 0 0 1 0 4h-2" />
    </svg>
  );
}

function BookOpenIcon(props) {
  return (
    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" {...props}>
      <path d="M12 7v14" />
      <path d="M3 6a3 3 0 0 1 3-3h8v15H6a3 3 0 0 0-3 3z" />
      <path d="M21 6a3 3 0 0 0-3-3h-8v15h8a3 3 0 0 1 3 3z" />
    </svg>
  );
}

// Fake Data for Cuisine
const stats = [
  { value: '3', label: 'Vùng miền', subtext: 'ẩm thực mang nét đặc trưng' },
  { value: '100+', label: 'Món ăn', subtext: 'hương vị truyền thống đa dạng' },
  { value: '54', label: 'Dân tộc', subtext: 'giao thoa nhiều màu sắc' },
  { value: '1000+', label: 'Hương vị', subtext: 'tinh hoa đất Việt' }
];

const regions = [
  "Tất cả vùng", "Miền Bắc", "Miền Trung", "Miền Nam"
];

const heroCuisines = [
  "Tất cả món", "Phở", "Bún chả", "Bún bò Huế", "Mì Quảng", "Cơm tấm", "Hủ tiếu"
];

const cuisineCards = [
  { id: "pho-ha-noi", name: "Phở Hà Nội", location: "Miền Bắc", imgUrl: "https://images.unsplash.com/photo-1582878826629-29b7ad1cb431?w=600&q=80", status: "Nổi bật", region: "Miền Bắc" },
  { id: "bun-cha", name: "Bún chả Hà Nội", location: "Miền Bắc", imgUrl: "https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=600&q=80", status: "", region: "Miền Bắc" },
  { id: "bun-bo-hue", name: "Bún bò Huế", location: "Miền Trung", imgUrl: "https://images.unsplash.com/photo-1583096114844-06ce6a5f2171?w=600&q=80", status: "Đặc sắc", region: "Miền Trung" },
  { id: "mi-quang", name: "Mì Quảng", location: "Miền Trung", imgUrl: "https://images.unsplash.com/photo-1555939594-58d7cb561ad1?w=600&q=80", status: "", region: "Miền Trung" },
  { id: "hu-tieu", name: "Hủ tiếu Nam Vang", location: "Miền Nam", imgUrl: "https://images.unsplash.com/photo-1626242372480-164c673ba718?w=600&q=80", status: "Phổ biến", region: "Miền Nam" },
  { id: "com-tam", name: "Cơm tấm Sài Gòn", location: "Miền Nam", imgUrl: "https://images.unsplash.com/photo-1625944525533-473f1a3d54de?w=600&q=80", status: "Nổi bật", region: "Miền Nam" },
  { id: "banh-xeo", name: "Bánh xèo miền Tây", location: "Miền Nam", imgUrl: "https://images.unsplash.com/photo-1555126634-323283e090fa?w=600&q=80", status: "", region: "Miền Nam" },
  { id: "nem-lui", name: "Nem lụi Huế", location: "Miền Trung", imgUrl: "https://images.unsplash.com/photo-1564834724105-918b73d1b9e0?w=600&q=80", status: "", region: "Miền Trung" }
];

const features = [
  { id: 1, title: "Sự tinh tế miền Bắc", imgUrl: "https://images.unsplash.com/photo-1582878826629-29b7ad1cb431?w=600&q=80", tag: "Thanh tao" },
  { id: 2, title: "Đậm đà miền Trung", imgUrl: "https://images.unsplash.com/photo-1583096114844-06ce6a5f2171?w=600&q=80", tag: "Cay nồng" },
  { id: 3, title: "Ngọt ngào miền Nam", imgUrl: "https://images.unsplash.com/photo-1626242372480-164c673ba718?w=600&q=80", tag: "Hào sảng" },
];

const stories = [
  { id: 1, title: "Văn hóa ẩm thực đường phố Hà Nội", desc: "Khám phá nhịp sống hối hả cùng những gánh hàng rong, quán vỉa hè quen thuộc mang đậm vẻ đẹp văn hóa ngàn năm văn hiến.", imgUrl: "https://images.unsplash.com/photo-1625944230945-1af5744bbcc6?w=600&q=80" },
  { id: 2, title: "Lễ hội ẩm thực cung nhã đình Huế", desc: "Tái hiện lại những bữa tiệc cung đình Huế trong cái nôi tinh hoa một nền văn hóa xưa, nơi ẩm thực đỉnh cao nghệ thuật.", imgUrl: "https://images.unsplash.com/photo-1582878826629-29b7ad1cb431?w=600&q=80" },
  { id: 3, title: "Bữa cơm gia đình - Linh hồn ẩm thực Việt", desc: "Nét đẹp mộc mạc, đậm đà tình thân xoay quanh mâm cơm của một gia đình trọn vẹn yêu thương từ những điều rất đỗi giản dị.", imgUrl: "https://images.unsplash.com/photo-1555126634-323283e090fa?w=600&q=80" },
];

const masonryImages = [
  { size: "large", imgUrl: "https://images.unsplash.com/photo-1582878826629-29b7ad1cb431?w=600&q=80" },
  { size: "small", imgUrl: "https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=600&q=80" },
  { size: "small", imgUrl: "https://images.unsplash.com/photo-1583096114844-06ce6a5f2171?w=600&q=80" },
  { size: "tall", imgUrl: "https://images.unsplash.com/photo-1555939594-58d7cb561ad1?w=600&q=80" },
  { size: "small", imgUrl: "https://images.unsplash.com/photo-1626242372480-164c673ba718?w=600&q=80" },
  { size: "wide", imgUrl: "https://images.unsplash.com/photo-1625944525533-473f1a3d54de?w=600&q=80" },
  { size: "small", imgUrl: "https://images.unsplash.com/photo-1564834724105-918b73d1b9e0?w=600&q=80" },
];

export default function CuisinePage() {
  const [lang, setLang] = useState('vi');
  const navigate = useNavigate();
  const [activeFilter, setActiveFilter] = useState("Tất cả vùng");
  const [isDropdownOpen, setIsDropdownOpen] = useState(false);
  const [activeRegion, setActiveRegion] = useState("Tất cả vùng");
  const [isRegionOpen, setIsRegionOpen] = useState(false);
  const [activeHeroCuisine, setActiveHeroCuisine] = useState("Tất cả món");
  const [isHeroCuisineOpen, setIsHeroCuisineOpen] = useState(false);

  // Pagination Logic
  const [currentPage, setCurrentPage] = useState(1);
  const ITEMS_PER_PAGE = 8;
  
  const filteredCards = cuisineCards.filter(c => 
    activeFilter === "Tất cả vùng" ? true : c.region === activeFilter
  );
  const totalPages = Math.ceil(filteredCards.length / ITEMS_PER_PAGE);
  const startIndex = (currentPage - 1) * ITEMS_PER_PAGE;
  const currentCards = filteredCards.slice(startIndex, startIndex + ITEMS_PER_PAGE);

  const handlePageChange = (page) => {
    setCurrentPage(page);
    window.scrollTo({
      top: document.getElementById('cuisine-grid-section')?.offsetTop - 80 || 0,
      behavior: 'smooth'
    });
  };

  return (
    <div className="cp-page-shell">
      <PageHeader
        lang={lang}
        onLangChange={setLang}
      />

      <main className="cp-main">
        {/* HERO SECTION */}
        <section className="cp-hero">
          <div className="cp-hero__bg" style={{ backgroundImage: `url(${banner3})` }}></div>
          <div className="cp-hero__overlay"></div>

          {/* Ornamental Motif */}
          <div className="cp-hero__ornament cp-hero__ornament--tl"></div>
          <div className="cp-hero__ornament cp-hero__ornament--br"></div>

          <div className="cp-hero__inner">
            {/* LEFT: Content & Search */}
            <div className="cp-hero__left fade-up">
              <div className="cp-hero__badge">
                <span className="cp-hero__badge-dot"></span>
                Khám phá ẩm thực 3 miền
              </div>

              <h1 className="cp-hero__title">
                <span className="cp-hero__title-accent">Tinh Hoa</span>
                <span className="cp-hero__title-line">Ẩm Thực</span>
                <span className="cp-hero__title-line">Việt Nam</span>
              </h1>

              <div className="cp-hero__divider-row">
                <span className="cp-hero__divider-line"></span>
                <span className="cp-hero__divider-diamond">◆</span>
                <span className="cp-hero__divider-line"></span>
              </div>

              <p className="cp-hero__subtitle">
                Từ Bắc tinh tế, Trung đậm đà đến Nam ngọt ngào — khám phá mâm cơm tượng trưng triết lý âm dương, ngũ hành, mỗi món ăn là một câu chuyện tình sâu sắc.
              </p>

              {/* Cultural stats */}
              <div className="cp-hero__stats">
                <div className="cp-hero__stat">
                  <strong>3</strong>
                  <span>Vùng miền</span>
                </div>
                <div className="cp-hero__stat-sep">|</div>
                <div className="cp-hero__stat">
                  <strong>100+</strong>
                  <span>Món ăn</span>
                </div>
                <div className="cp-hero__stat-sep">|</div>
                <div className="cp-hero__stat">
                  <strong>1.000+</strong>
                  <span>Hương vị</span>
                </div>
              </div>

              {/* Search Bar Restyled */}
              <div className="cp-hero__search-bar">
                <div className="cp-search-field-wrapper" style={{ flex: 1.2 }}>
                  <div className="cp-search-field" style={{ paddingLeft: '24px' }}>
                    <LuSearch className="cp-search-icon" />
                    <input type="text" placeholder="Tìm kiếm món ăn..." />
                  </div>
                </div>

                <div className="cp-search-divider" />

                <div className="cp-search-field-wrapper">
                  <div
                    className={`cp-search-field ${isRegionOpen ? 'active' : ''}`}
                    onClick={() => {
                      setIsRegionOpen(!isRegionOpen);
                      setIsHeroCuisineOpen(false);
                    }}
                  >
                    <span>{activeRegion === 'Tất cả vùng' ? 'Vùng' : activeRegion}</span>
                    <LuChevronDown className={`cp-chevron-icon ${isRegionOpen ? 'rotate' : ''}`} />
                  </div>

                  {isRegionOpen && (
                    <ul className="cp-hero-dropdown">
                      {regions.map(r => (
                        <li
                          key={r}
                          className={`cp-hero-dropdown-item ${activeRegion === r ? 'selected' : ''}`}
                          onClick={() => {
                            setActiveRegion(r);
                            setIsRegionOpen(false);
                          }}
                        >
                          {r}
                        </li>
                      ))}
                    </ul>
                  )}
                </div>

                <div className="cp-search-divider" />

                <div className="cp-search-field-wrapper">
                  <div
                    className={`cp-search-field ${isHeroCuisineOpen ? 'active' : ''}`}
                    onClick={() => {
                      setIsHeroCuisineOpen(!isHeroCuisineOpen);
                      setIsRegionOpen(false);
                    }}
                  >
                    <span>{activeHeroCuisine === 'Tất cả món' ? 'Món ăn' : activeHeroCuisine}</span>
                    <LuChevronDown className={`cp-chevron-icon ${isHeroCuisineOpen ? 'rotate' : ''}`} />
                  </div>

                  {isHeroCuisineOpen && (
                    <ul className="cp-hero-dropdown">
                      {heroCuisines.map(e => (
                        <li
                          key={e}
                          className={`cp-hero-dropdown-item ${activeHeroCuisine === e ? 'selected' : ''}`}
                          onClick={() => {
                            setActiveHeroCuisine(e);
                            setIsHeroCuisineOpen(false);
                          }}
                        >
                          {e}
                        </li>
                      ))}
                    </ul>
                  )}
                </div>

                <button className="cp-hero__cta-btn">
                  Tìm kiếm
                </button>
              </div>

            </div>

            {/* RIGHT: Image Frame */}
            <div className="cp-hero__right fade-up">
              <div className="cp-hero__img-frame">
                <img src="https://images.unsplash.com/photo-1555126634-323283e090fa?w=600&q=80" alt="Ẩm thực" className="cp-hero__img-main" />
                <div className="cp-hero__img-ring"></div>
                <div className="cp-hero__img-badge">
                  <span className="cp-hero__img-badge-icon">🍲</span>
                  Bản sắc việt nam
                </div>
              </div>
            </div>
          </div>

          <div className="cp-section-wave cp-section-wave--bottom">
            <svg data-name="Layer 1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1200 120" preserveAspectRatio="none">
              <path d="M321.39,56.44c58-10.79,114.16-30.13,172-41.86,82.39-16.72,168.19-17.73,250.45-.39C823.78,31,906.67,72,985.66,92.83c70.05,18.48,146.53,26.09,214.34,3V0H0V27.35A600.21,0,0,0,321.39,56.44Z" fill="#ffffff"></path>
            </svg>
          </div>
        </section>

        {/* MAIN GRID - ẨM THỰC VIỆT NAM */}
        <section className="cp-section cp-section--light" id="cuisine-grid-section">
          <div className="cp-container">
            <div className="cp-section-header cp-center">
              <div className="cp-section-title-wrap">
                <span className="cp-section-eyebrow cp-eyebrow-capsule">TINH HOA 3 MIỀN</span>
                <h2 className="cp-section-title cp-serif">
                  Món ăn tiêu biểu
                </h2>
                <p className="cp-section-desc">Mỗi món ăn là một kho tàng hương vị độc đáo, góp phần tạo nên <br /> sự đặc sắc của nền ẩm thực đất Việt</p>
                <div className="cp-divider-ornament" aria-hidden="true">
                  <span className="cp-line-main" />
                  <span className="cp-dot" />
                  <span className="cp-dot" />
                </div>
              </div>
            </div>

            <div className="cp-filters">
              <div className="cp-custom-dropdown">
                <div
                  className={`cp-dropdown-header ${isDropdownOpen ? 'open' : ''}`}
                  onClick={() => setIsDropdownOpen(!isDropdownOpen)}
                >
                  {activeFilter}
                  <span className="cp-dropdown-arrow">▼</span>
                </div>
                {isDropdownOpen && (
                  <ul className="cp-dropdown-list">
                    {regions.map(r => (
                      <li
                        key={r}
                        className={`cp-dropdown-item ${activeFilter === r ? 'selected' : ''}`}
                        onClick={() => {
                          setActiveFilter(r);
                          setIsDropdownOpen(false);
                          handlePageChange(1);
                        }}
                      >
                        {r}
                      </li>
                    ))}
                  </ul>
                )}
              </div>
            </div>

            <div className="cp-grid cp-grid--4cols fade-up">
              {currentCards.map(c => (
                <div onClick={() => navigate(`/cuisine/${c.id}`)} className="cp-card cursor-pointer" key={c.id}>
                  <div className="cp-card__img-wrap">
                    {c.status && <span className="cp-card__status">{c.status}</span>}
                    <img src={c.imgUrl} alt={c.name} loading="lazy" />
                  </div>
                  <div className="cp-card__content">
                    <p className="cp-card__loc">
                      <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2"><path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z"></path><circle cx="12" cy="10" r="3"></circle></svg>
                      {c.location}
                    </p>
                    <h3 className="cp-card__title">{c.name}</h3>
                    <span className="cp-card__link">Xem chi tiết</span>
                  </div>
                </div>
              ))}
            </div>

            {/* Pagination Controls */}
            {totalPages > 1 && (
              <div className="cp-pagination fade-up">
                <button
                  className="cp-pagination__btn cp-pagination__nav"
                  disabled={currentPage === 1}
                  onClick={() => handlePageChange(Math.max(1, currentPage - 1))}
                >
                  <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
                    <polyline points="15 18 9 12 15 6" />
                  </svg>
                </button>
                                
                <div className="cp-pagination__pages">
                  {Array.from({ length: totalPages }, (_, i) => i + 1).map(page => (
                    <button
                      key={page}
                      className={`cp-pagination__btn ${currentPage === page ? 'active' : ''}`}
                      onClick={() => handlePageChange(page)}
                    >
                      {page}
                    </button>
                  ))}
                </div>

                <button
                  className="cp-pagination__btn cp-pagination__nav"
                  disabled={currentPage === totalPages}
                  onClick={() => handlePageChange(Math.min(totalPages, currentPage + 1))}
                >
                  <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
                    <polyline points="9 18 15 12 9 6" />
                  </svg>
                </button>
              </div>
            )}
          </div>
        </section>

        {/* FEATURE HIGHLIGHT */}
        <section className="cp-section cp-section--cream cp-section--wavy">
          <div className="cp-section-wave cp-section-wave--top">
            <svg data-name="Layer 1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1200 120" preserveAspectRatio="none">
              <path d="M321.39,56.44c58-10.79,114.16-30.13,172-41.86,82.39-16.72,168.19-17.73,250.45-.39C823.78,31,906.67,72,985.66,92.83c70.05,18.48,146.53,26.09,214.34,3V0H0V27.35A600.21,600.21,0,0,0,321.39,56.44Z" fill="#ffffff"></path>
            </svg>
          </div>

          <div className="cp-container cp-feature-split">
            <div className="cp-feature-img-wrapper fade-up">
              <div className="cp-feature-img-frame">
                <img src="https://images.unsplash.com/photo-1555126634-323283e090fa?w=600&q=80" alt="Nét văn hóa tiêu biểu" />
              </div>
              <div className="cp-feature-img-tag glass-panel">
                <div className="cp-tag-icon"><StarIcon /></div>
                <div className="cp-tag-text">
                  <strong>Bàn tay người phụ nữ Việt</strong>
                  <span>Linh hồn của nền ẩm thực</span>
                </div>
              </div>
            </div>

            <div className="cp-feature-text fade-up delay-1">
              <span className="cp-badge cp-badge--accent">Câu chuyện ẩm thực</span>
              <h2 className="cp-section-title">Hương vị của sự<br />giao thoa</h2>
              <p className="cp-feature-desc">Mỗi mâm cơm Việt Nam mang trong mình triết lý âm dương ngũ hành vô giá, một nét văn hóa bồi đắp từ ngàn đời truyền lại trong gian bếp cổ truyền.</p>

              <ul className="cp-feature-list">
                <li className="cp-feature-item">
                  <div className="cp-fi-icon cp-fi-icon--red"><CoffeeIcon /></div>
                  <div className="cp-fi-content">
                    <h4>Vị ngon đậm đà</h4>
                    <p>Sự cân bằng hoàn hảo giữa chua, cay, mặn, ngọt tẩm ướp cùng những gia vị đặc trưng.</p>
                  </div>
                </li>
                <li className="cp-feature-item">
                  <div className="cp-fi-icon cp-fi-icon--orange"><StarIcon /></div>
                  <div className="cp-fi-content">
                    <h4>Nguyên liệu tươi sạch</h4>
                    <p>Ưu tiên sử dụng nguyên liệu đồng quê, kết hợp cùng các loại rau thơm miền Bắc, Trung, Nam.</p>
                  </div>
                </li>
                <li className="cp-feature-item">
                  <div className="cp-fi-icon cp-fi-icon--brown"><BookOpenIcon /></div>
                  <div className="cp-fi-content">
                    <h4>Triết lý văn hóa</h4>
                    <p>Tính cộng đồng trên mâm cơm hay chiếc mâm tròn thể hiện sự gắn kết, chia sẻ trong gia đình.</p>
                  </div>
                </li>
              </ul>

              <div className="cp-feature-actions">
                <button className="cp-btn-primary">Đọc thêm</button>
                <button className="cp-btn-outline">Khám phá vùng miền</button>
              </div>
            </div>
          </div>

          <div className="cp-section-wave cp-section-wave--bottom">
            <svg data-name="Layer 1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1200 120" preserveAspectRatio="none">
              <path d="M321.39,56.44c58-10.79,114.16-30.13,172-41.86,82.39-16.72,168.19-17.73,250.45-.39C823.78,31,906.67,72,985.66,92.83c70.05,18.48,146.53,26.09,214.34,3V0H0V27.35A600.21,600.21,0,0,0,321.39,56.44Z" fill="#ffffff"></path>
            </svg>
          </div>
        </section>

        {/* HORIZONTAL GRID - NHỮNG NÉT VĂN HÓA ĐẶC SẮC NHẤT */}
        <section className="cp-section cp-section--light">
          <div className="cp-container">
            <div className="cp-section-header cp-flex-header">
              <div>
                <span className="cp-section-eyebrow">Khám phá</span>
                <h2 className="cp-section-title">Ba miền ẩm thực<br />đặc sắc</h2>
              </div>
              <div className="cp-nav-buttons">
                <button className="cp-nav-btn disable">&larr;</button>
                <button className="cp-nav-btn cp-nav-btn--active">&rarr;</button>
              </div>
            </div>

            <div className="cp-grid cp-grid--3cols fade-up">
              {features.map(f => (
                <div className="cp-hcard" key={f.id}>
                  <div className="cp-hcard__img">
                    {f.tag && <span className="cp-card__status">{f.tag}</span>}
                    <img src={f.imgUrl} alt={f.title} loading="lazy" />
                  </div>
                  <div className="cp-hcard__content">
                    <h3 className="cp-hcard__title">{f.title}</h3>
                    <p className="cp-hcard__desc">Cùng chiêm nghiệm và khám phá phong vị đặc trưng phản ánh nét đẹp và lối sống qua nghệ thuật ẩm thực.</p>
                    <span className="cp-card__link">Tìm hiểu</span>
                  </div>
                </div>
              ))}
            </div>
          </div>
        </section>

        {/* MASONRY COLLAGE - KHOẢNH KHẮC VĂN HÓA SỐNG ĐỘNG */}
        <section className="cp-section cp-section--cream cp-section--wavy">
          <div className="cp-section-wave cp-section-wave--top">
            <svg data-name="Layer 1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1200 120" preserveAspectRatio="none">
              <path d="M321.39,56.44c58-10.79,114.16-30.13,172-41.86,82.39-16.72,168.19-17.73,250.45-.39C823.78,31,906.67,72,985.66,92.83c70.05,18.48,146.53,26.09,214.34,3V0H0V27.35A600.21,600.21,0,0,0,321.39,56.44Z" fill="#ffffff"></path>
            </svg>
          </div>
          <div className="cp-container">
            <div className="cp-section-header cp-center">
              <span className="cp-section-eyebrow">Thư viện ảnh</span>
              <h2 className="cp-section-title">Khoảnh khắc ẩm thực<br />sống động</h2>
              <p className="cp-section-desc">Những góc máy chân thực nhất làm khơi dậy sự thèm ăn và vẻ rực rỡ của ẩm thực.</p>
            </div>

            <div className="cp-masonry fade-up">
              {masonryImages.map((img, idx) => (
                <div key={idx} className={`cp-masonry-item cp-masonry-item--${img.size}`}>
                  <img src={img.imgUrl} alt="Khoảnh khắc ẩm thực" loading="lazy" />
                  <div className="cp-masonry-overlay">
                    <span className="cp-btn-icon">🔍</span>
                  </div>
                </div>
              ))}
            </div>

            <div className="cp-center-action">
              <button className="cp-btn-outline">Xem thêm thư viện ảnh</button>
            </div>
          </div>
          <div className="cp-section-wave cp-section-wave--bottom">
            <svg data-name="Layer 1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1200 120" preserveAspectRatio="none">
              <path d="M321.39,56.44c58-10.79,114.16-30.13,172-41.86,82.39-16.72,168.19-17.73,250.45-.39C823.78,31,906.67,72,985.66,92.83c70.05,18.48,146.53,26.09,214.34,3V0H0V27.35A600.21,600.21,0,0,0,321.39,56.44Z" fill="#ffffff"></path>
            </svg>
          </div>
        </section>

        {/* STORIES - CHUYỆN KỂ TỪ BẢN LÀNG XA */}
        <section className="cp-section cp-section--light">
          <div className="cp-container">
            <div className="cp-section-header cp-flex-header">
              <div>
                <span className="cp-section-eyebrow">Trải nghiệm</span>
                <h2 className="cp-section-title">Chuyện kể<br />ẩm thực</h2>
              </div>
              <Link to="/blog" className="cp-link-more">Xem tất cả bài viết &rsaquo;</Link>
            </div>

            <div className="cp-grid cp-grid--3cols fade-up">
              {stories.map(s => (
                <Link to="/blog/1" className="cp-scard" key={s.id}>
                  <div className="cp-scard__img">
                    <img src={s.imgUrl} alt={s.title} loading="lazy" />
                  </div>
                  <div className="cp-scard__content">
                    <h3 className="cp-scard__title">{s.title}</h3>
                    <p className="cp-scard__desc">{s.desc}</p>
                    <div className="cp-scard__meta">
                      <span className="cp-meta-author">
                        <div className="cp-avatar"></div> VNCulture
                      </span>
                      <span className="cp-meta-date">24 Mar, 2026</span>
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

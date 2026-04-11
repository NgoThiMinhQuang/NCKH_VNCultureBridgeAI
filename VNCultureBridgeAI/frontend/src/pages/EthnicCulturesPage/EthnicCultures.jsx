<<<<<<< HEAD
import React, { useState } from "react";
import { Link } from "react-router-dom";
import "./EthnicCulturesPage.css";
import {
  LuSearch,
  LuChevronDown,
  LuShirt,
  LuStar,
  LuUtensils,
  LuBookOpen,
} from "react-icons/lu";
import PageHeader from "../../components/layout/PageHeader/PageHeader";
import Footer from "../../components/layout/Footer/Footer";
import banner3 from "../../assets/banner3.jpg";
import hmongImg from "../../assets/hmong.jpg";
import daoImg from "../../assets/dao.jpg";
import thaiImg from "../../assets/thai.jpg";
import edeImg from "../../assets/ede.jpg";
import banaImg from "../../assets/bana.jpg";
import khmerImg from "../../assets/khmer.jpg";
import chamImg from "../../assets/cham.jpg";
import muongImg from "../../assets/muong.jpg";
import ruongBacThangImg from "../../assets/ruong-bac-thang.jpg";
import duaBoImg from "../../assets/dua-bo.jpg";
import xoeThaiImg from "../../assets/xoe_thai.png";
import congChiengImg from "../../assets/cong_chieng.png";
import leCapSacImg from "../../assets/le-cap-sac.jpg";
import detThoCamImg from "../../assets/det-tho-cam.jpg";
import muaTrongImg from "../../assets/mua-trong-sadam.jpg";
=======
import React, { useState } from 'react';
import { Link } from 'react-router-dom';
import { LuSearch, LuChevronDown, LuShirt, LuStar, LuUtensils, LuBookOpen } from 'react-icons/lu';
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
>>>>>>> 72cd07afe48c7c243da0dce38dfd5a47239cdb61
function SearchIcon(props) {
  return (
    <svg
      viewBox="0 0 24 24"
      fill="none"
      stroke="currentColor"
      strokeWidth="2"
      strokeLinecap="round"
      strokeLinejoin="round"
      {...props}
    >
      <circle cx="11" cy="11" r="8" />
      <path d="m21 21-4.35-4.35" />
    </svg>
  );
}

function ChevronDownIcon(props) {
  return (
    <svg
      viewBox="0 0 24 24"
      fill="none"
      stroke="currentColor"
      strokeWidth="2"
      strokeLinecap="round"
      strokeLinejoin="round"
      {...props}
    >
      <path d="m6 9 6 6 6-6" />
    </svg>
  );
}

function ShirtIcon(props) {
  return (
    <svg
      viewBox="0 0 24 24"
      fill="none"
      stroke="currentColor"
      strokeWidth="2"
      strokeLinecap="round"
      strokeLinejoin="round"
      {...props}
    >
      <path d="m4 7 5-3 2 3 2-3 5 3" />
      <path d="M7 4h10l2 5-2 2v9H7v-9L5 9z" />
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
    <svg
      viewBox="0 0 24 24"
      fill="none"
      stroke="currentColor"
      strokeWidth="2"
      strokeLinecap="round"
      strokeLinejoin="round"
      {...props}
    >
      <path d="M4 8h13a3 3 0 0 1 0 6H4z" />
      <path d="M4 8v7a4 4 0 0 0 4 4h5a4 4 0 0 0 4-4v-1" />
      <path d="M18 9h2a2 2 0 0 1 0 4h-2" />
    </svg>
  );
}

function BookOpenIcon(props) {
  return (
    <svg
      viewBox="0 0 24 24"
      fill="none"
      stroke="currentColor"
      strokeWidth="2"
      strokeLinecap="round"
      strokeLinejoin="round"
      {...props}
    >
      <path d="M12 7v14" />
      <path d="M3 6a3 3 0 0 1 3-3h8v15H6a3 3 0 0 0-3 3z" />
      <path d="M21 6a3 3 0 0 0-3-3h-8v15h8a3 3 0 0 1 3 3z" />
    </svg>
  );
}

// Fake Data for mockups
const stats = [
  {
    value: "54",
    label: "Dân tộc",
    subtext: "đa dạng và phong phú bản sắc văn hóa",
  },
  {
    value: "8",
    label: "Vùng văn hóa",
    subtext: "với những đặc trưng địa hình, khí hậu",
  },
  {
    value: "5,000+",
    label: "Lễ hội truyền thống",
    subtext: "được tổ chức hằng năm trên cả nước",
  },
  {
    value: "1,000,000+",
    label: "Hiện vật",
    subtext: "về văn hóa các dân tộc đang được lưu giữ",
  },
];

const regions = [
  "Tất cả vùng",
  "Miền Bắc",
  "Miền Trung",
  "Miền Nam",
  "Tây Nguyên",
];

const heroEthnicGroups = [
  "Tất cả dân tộc",
  "Kinh",
  "Tày",
  "H'Mông",
  "Khmer",
  "Chăm",
  "Dao",
  "Ê Đê",
  "Mường",
];

const filters = [
  "Tất cả dân tộc",
  "Mường",
  "Thái",
  "H'Mông",
  "Dao",
  "Kinh",
  "Khmer",
];

const ethnicCards = [
  {
    id: "hmong",
    name: "Dân tộc Mông",
    location: "Hà Giang, Sơn La,...",
    imgUrl: hmongImg,
    status: "Nổi bật",
    region: "Miền Bắc",
  },
  {
    id: "dao",
    name: "Dân tộc Dao",
    location: "Lào Cai, Yên Bái,...",
    imgUrl: daoImg,
    status: "",
    region: "Miền Bắc",
  },
  {
    id: "thai",
    name: "Dân tộc Thái",
    location: "Điện Biên, Lai Châu,...",
    imgUrl: thaiImg,
    status: "",
    region: "Miền Bắc",
  },
  {
    id: "ede",
    name: "Dân tộc Ê Đê",
    location: "Đắk Lắk, Đắk Nông,...",
    imgUrl: edeImg,
    status: "Mới",
    region: "Tây Nguyên",
  },
  {
    id: "bana",
    name: "Dân tộc Ba Na",
    location: "Gia Lai, Kon Tum,...",
    imgUrl: banaImg,
    status: "",
    region: "Tây Nguyên",
  },
  {
    id: "khmer",
    name: "Dân tộc Khmer",
    location: "Sóc Trăng, Trà Vinh,...",
    imgUrl: khmerImg,
    status: "",
    region: "Miền Nam",
  },
  {
    id: "cham",
    name: "Dân tộc Chăm",
    location: "Ninh Thuận, Bình Thuận,...",
    imgUrl: chamImg,
    status: "Nổi bật",
    region: "Miền Nam",
  },
  {
    id: "muong",
    name: "Dân tộc Mường",
    location: "Hòa Bình, Thanh Hóa,...",
    imgUrl: muongImg,
    status: "",
    region: "Miền Bắc",
  },
  {
    id: "tày",
    name: "Dân tộc Tày",
    location: "Cao Bằng, Lạng Sơn,...",
    imgUrl: thaiImg,
    status: "",
    region: "Miền Bắc",
  },
  {
    id: "nung",
    name: "Dân tộc Nùng",
    location: "Lạng Sơn, Cao Bằng,...",
    imgUrl: daoImg,
    status: "",
    region: "Miền Bắc",
  },
  {
    id: "hà-nhì",
    name: "Dân tộc Hà Nhì",
    location: "Lai Châu, Lào Cai,...",
    imgUrl: hmongImg,
    status: "",
    region: "Miền Bắc",
  },
  {
    id: "ta-oi",
    name: "Dân tộc Tà Ôi",
    location: "Thừa Thiên Huế,...",
    imgUrl: banaImg,
    status: "",
    region: "Miền Trung",
  },
  {
    id: "churu",
    name: "Dân tộc Chu Ru",
    location: "Lâm Đồng, Ninh Thuận,...",
    imgUrl: edeImg,
    status: "",
    region: "Tây Nguyên",
  },
  {
    id: "san-diu",
    name: "Dân tộc Sán Dìu",
    location: "Vĩnh Phúc, Thái Nguyên,...",
    imgUrl: chamImg,
    status: "",
    region: "Miền Bắc",
  },
  {
    id: "co-tu",
    name: "Dân tộc Cơ Tu",
    location: "Quảng Nam, Đà Nẵng,...",
    imgUrl: muongImg,
    status: "",
    region: "Miền Trung",
  },
  {
    id: "jrai",
    name: "Dân tộc J'rai",
    location: "Gia Lai, Kon Tum,...",
    imgUrl: edeImg,
    status: "",
    region: "Tây Nguyên",
  },
];

const features = [
  { id: 1, title: "Lễ hội đua bò Bảy Núi", imgUrl: duaBoImg, tag: "Nổi bật" },
  { id: 2, title: "Nghệ thuật xòe Thái", imgUrl: xoeThaiImg, tag: "" },
  {
    id: 3,
    title: "Không gian văn hóa Cồng Chiêng",
    imgUrl: congChiengImg,
    tag: "Di sản",
  },
];

const stories = [
  {
    id: 1,
    title: "Lễ Cấp sắc của người Dao đỏ ở Bắc Kạn",
    desc: "Lễ cấp sắc là một nghi lễ quan trọng đánh dấu sự trưởng thành của người đàn ông dân tộc Dao đỏ.",
    imgUrl: leCapSacImg,
  },
  {
    id: 2,
    title: "Khám phá dệt thổ cẩm của người Lô Lô",
    desc: "Nghề dệt thổ cẩm truyền thống của người Lô Lô mang đậm nét văn hóa độc đáo với những họa tiết sặc sỡ.",
    imgUrl: detThoCamImg,
  },
  {
    id: 3,
    title: "Nét đặc sắc múa trống Sadam của người Khmer",
    desc: "Trống Sadam không chỉ là nhạc cụ mà còn là linh hồn trong các lễ hội truyền thống của người Khmer Nam Bộ.",
    imgUrl: muaTrongImg,
  },
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
  const [lang, setLang] = useState("vi");
  const [activeFilter, setActiveFilter] = useState("Tất cả vùng");
  const [isDropdownOpen, setIsDropdownOpen] = useState(false);
  const [activeRegion, setActiveRegion] = useState("Tất cả vùng");
  const [isRegionOpen, setIsRegionOpen] = useState(false);
  const [activeHeroEthnic, setActiveHeroEthnic] = useState("Tất cả dân tộc");
  const [isHeroEthnicOpen, setIsHeroEthnicOpen] = useState(false);
  const [searchQuery, setSearchQuery] = useState("");

  // Pagination Logic
  const [currentPage, setCurrentPage] = useState(1);
  const ITEMS_PER_PAGE = 8;

  const filteredCards = ethnicCards.filter((c) => {
    const matchRegionFilter =
      activeFilter === "Tất cả vùng" ? true : c.region === activeFilter;
    const matchHeroRegion =
      activeRegion === "Tất cả vùng" ? true : c.region === activeRegion;
    const matchHeroEthnic =
      activeHeroEthnic === "Tất cả dân tộc"
        ? true
        : c.name.toLowerCase().includes(activeHeroEthnic.toLowerCase());
    const matchSearchQuery =
      searchQuery === ""
        ? true
        : c.name.toLowerCase().includes(searchQuery.toLowerCase());

    return (
      matchRegionFilter &&
      matchHeroRegion &&
      matchHeroEthnic &&
      matchSearchQuery
    );
  });
  const totalPages = Math.ceil(filteredCards.length / ITEMS_PER_PAGE);
  const startIndex = (currentPage - 1) * ITEMS_PER_PAGE;
  const currentCards = filteredCards.slice(
    startIndex,
    startIndex + ITEMS_PER_PAGE,
  );

  const handlePageChange = (page) => {
    setCurrentPage(page);
    window.scrollTo({
      top: document.getElementById("ethnic-grid-section")?.offsetTop - 80 || 0,
      behavior: "smooth",
    });
  };

  return (
    <div className="ec-page-shell">
      <PageHeader lang={lang} onLangChange={setLang} />

      <main className="ec-main">
        {/* HERO SECTION */}
        <section className="ec-hero">
          <div
            className="ec-hero__bg"
            style={{ backgroundImage: `url(${banner3})` }}
          ></div>
          <div className="ec-hero__overlay"></div>

          {/* Ornamental Motif */}
          <div className="ec-hero__ornament ec-hero__ornament--tl"></div>
          <div className="ec-hero__ornament ec-hero__ornament--br"></div>

          <div className="ec-hero__inner">
            {/* LEFT: Content & Search */}
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
                Từ những đỉnh núi mờ sương Tây Bắc đến những bản làng yên bình
                nơi đồng bằng, khám phá sự đa dạng và giàu có của văn hóa 54 dân
                tộc anh em.
              </p>

              {/* Cultural stats */}
              <div className="ec-hero__stats">
                <div className="ec-hero__stat">
                  <strong>54</strong>
                  <span>Dân tộc</span>
                </div>
                <div className="ec-hero__stat-sep">|</div>
                <div className="ec-hero__stat">
                  <strong>8</strong>
                  <span>Vùng văn hóa</span>
                </div>
                <div className="ec-hero__stat-sep">|</div>
                <div className="ec-hero__stat">
                  <strong>5.000+</strong>
                  <span>Lễ hội</span>
                </div>
              </div>

              {/* Search Bar Restyled */}
              <div className="ec-hero__search-bar">
                <div className="ec-search-field-wrapper" style={{ flex: 1.2 }}>
                  <div
                    className="ec-search-field"
                    style={{ paddingLeft: "24px" }}
                  >
                    <LuSearch className="ec-search-icon" />
                    <input
                      type="text"
                      placeholder="Tìm kiếm dân tộc..."
                      value={searchQuery}
                      onChange={(e) => setSearchQuery(e.target.value)}
                    />
                  </div>
                </div>

                <div className="ec-search-divider" />

                <div className="ec-search-field-wrapper">
                  <div
                    className={`ec-search-field ${isRegionOpen ? "active" : ""}`}
                    onClick={() => {
                      setIsRegionOpen(!isRegionOpen);
                      setIsHeroEthnicOpen(false);
                    }}
                  >
                    <span>
                      {activeRegion === "Tất cả vùng" ? "Vùng" : activeRegion}
                    </span>
                    <LuChevronDown
                      className={`ec-chevron-icon ${isRegionOpen ? "rotate" : ""}`}
                    />
                  </div>

                  {isRegionOpen && (
                    <ul className="ec-hero-dropdown">
                      {regions.map((r) => (
                        <li
                          key={r}
                          className={`ec-hero-dropdown-item ${activeRegion === r ? "selected" : ""}`}
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

                <div className="ec-search-divider" />

                <div className="ec-search-field-wrapper">
                  <div
                    className={`ec-search-field ${isHeroEthnicOpen ? "active" : ""}`}
                    onClick={() => {
                      setIsHeroEthnicOpen(!isHeroEthnicOpen);
                      setIsRegionOpen(false);
                    }}
                  >
                    <span>
                      {activeHeroEthnic === "Tất cả dân tộc"
                        ? "Dân tộc"
                        : activeHeroEthnic}
                    </span>
                    <LuChevronDown
                      className={`ec-chevron-icon ${isHeroEthnicOpen ? "rotate" : ""}`}
                    />
                  </div>

                  {isHeroEthnicOpen && (
                    <ul className="ec-hero-dropdown">
                      {heroEthnicGroups.map((e) => (
                        <li
                          key={e}
                          className={`ec-hero-dropdown-item ${activeHeroEthnic === e ? "selected" : ""}`}
                          onClick={() => {
                            setActiveHeroEthnic(e);
                            setIsHeroEthnicOpen(false);
                          }}
                        >
                          {e}
                        </li>
                      ))}
                    </ul>
                  )}
                </div>

                <button className="ec-hero__cta-btn">Tìm kiếm</button>
              </div>
            </div>

            {/* RIGHT: Image Frame */}
            <div className="ec-hero__right fade-up">
              <div className="ec-hero__img-frame">
                <img
                  src={hmongImg}
                  alt="Dân tộc"
                  className="ec-hero__img-main"
                />
                <div className="ec-hero__img-ring"></div>
                <div className="ec-hero__img-badge">
                  <span className="ec-hero__img-badge-icon">🌟</span>
                  Bản sắc độc đáo
                </div>
              </div>
            </div>
          </div>

          <div className="ec-section-wave ec-section-wave--bottom">
            <svg
              data-name="Layer 1"
              xmlns="http://www.w3.org/2000/svg"
              viewBox="0 0 1200 120"
              preserveAspectRatio="none"
            >
              <path
                d="M321.39,56.44c58-10.79,114.16-30.13,172-41.86,82.39-16.72,168.19-17.73,250.45-.39C823.78,31,906.67,72,985.66,92.83c70.05,18.48,146.53,26.09,214.34,3V0H0V27.35A600.21,0,0,0,321.39,56.44Z"
                fill="#ffffff"
              ></path>
            </svg>
          </div>
        </section>

        {/* MAIN GRID - CÁC DÂN TỘC VIỆT NAM */}
        <section
          className="ec-section ec-section--light"
          id="ethnic-grid-section"
        >
          <div className="ec-container">
            <div className="ec-section-header ec-center">
              <div className="ec-section-title-wrap">
                <span className="ec-section-eyebrow ec-eyebrow-capsule">
                  CỘNG ĐỒNG 54 DÂN TỘC
                </span>
                <h2 className="ec-section-title ec-serif">
                  Các dân tộc Việt Nam
                </h2>
                <p className="ec-section-desc">
                  Mỗi dân tộc là một kho tàng văn hóa độc đáo, góp phần tạo nên
                  sự đa dạng <br /> và phong phú của đất nước
                </p>
                <div className="ec-divider-ornament" aria-hidden="true">
                  <span className="ec-line-main" />
                  <span className="ec-dot" />
                  <span className="ec-dot" />
                </div>
              </div>
            </div>

            <div className="ec-filters">
              <div className="ec-custom-dropdown">
                <div
                  className={`ec-dropdown-header ${isDropdownOpen ? "open" : ""}`}
                  onClick={() => setIsDropdownOpen(!isDropdownOpen)}
                >
                  {activeFilter}
                  <span className="ec-dropdown-arrow">▼</span>
                </div>
                {isDropdownOpen && (
                  <ul className="ec-dropdown-list">
                    {regions.map((r) => (
                      <li
                        key={r}
                        className={`ec-dropdown-item ${activeFilter === r ? "selected" : ""}`}
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

            <div className="ec-grid ec-grid--4cols fade-up">
              {currentCards.map((c) => (
                <Link
                  to={`/ethnic-groups/${c.id}`}
                  className="ec-card"
                  key={c.id}
                >
                  <div className="ec-card__img-wrap">
                    {c.status && (
                      <span className="ec-card__status">{c.status}</span>
                    )}
                    <img src={c.imgUrl} alt={c.name} loading="lazy" />
                  </div>
                  <div className="ec-card__content">
                    <p className="ec-card__loc">
                      <svg
                        width="14"
                        height="14"
                        viewBox="0 0 24 24"
                        fill="none"
                        stroke="currentColor"
                        strokeWidth="2"
                      >
                        <path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z"></path>
                        <circle cx="12" cy="10" r="3"></circle>
                      </svg>
                      {c.location}
                    </p>
                    <h3 className="ec-card__title">{c.name}</h3>
                    <span className="ec-card__link">Xem chi tiết</span>
                  </div>
                </Link>
              ))}
            </div>

            {/* Pagination Controls */}
            {totalPages > 1 && (
              <div className="ec-pagination fade-up">
                <button
                  className="ec-pagination__btn ec-pagination__nav"
                  disabled={currentPage === 1}
                  onClick={() => handlePageChange(Math.max(1, currentPage - 1))}
                >
                  <svg
                    width="20"
                    height="20"
                    viewBox="0 0 24 24"
                    fill="none"
                    stroke="currentColor"
                    strokeWidth="2"
                  >
                    <polyline points="15 18 9 12 15 6" />
                  </svg>
                </button>

                <div className="ec-pagination__pages">
                  {Array.from({ length: totalPages }, (_, i) => i + 1).map(
                    (page) => (
                      <button
                        key={page}
                        className={`ec-pagination__btn ${currentPage === page ? "active" : ""}`}
                        onClick={() => handlePageChange(page)}
                      >
                        {page}
                      </button>
                    ),
                  )}
                </div>

                <button
                  className="ec-pagination__btn ec-pagination__nav"
                  disabled={currentPage === totalPages}
                  onClick={() =>
                    handlePageChange(Math.min(totalPages, currentPage + 1))
                  }
                >
                  <svg
                    width="20"
                    height="20"
                    viewBox="0 0 24 24"
                    fill="none"
                    stroke="currentColor"
                    strokeWidth="2"
                  >
                    <polyline points="9 18 15 12 9 6" />
                  </svg>
                </button>
              </div>
            )}
          </div>
        </section>

        {/* FEATURE HIGHLIGHT - NÉT VĂN HÓA TIÊU BIỂU */}
        <section className="ec-section ec-section--cream ec-section--wavy">
          <div className="ec-section-wave ec-section-wave--top">
            <svg
              data-name="Layer 1"
              xmlns="http://www.w3.org/2000/svg"
              viewBox="0 0 1200 120"
              preserveAspectRatio="none"
            >
              <path
                d="M321.39,56.44c58-10.79,114.16-30.13,172-41.86,82.39-16.72,168.19-17.73,250.45-.39C823.78,31,906.67,72,985.66,92.83c70.05,18.48,146.53,26.09,214.34,3V0H0V27.35A600.21,600.21,0,0,0,321.39,56.44Z"
                fill="#ffffff"
              ></path>
            </svg>
          </div>

          <div className="ec-container ec-feature-split">
            {/* ... contents ... */}
            <div className="ec-feature-img-wrapper fade-up">
              <div className="ec-feature-img-frame">
                <img
                  src={ruongBacThangImg}
                  alt="Nét văn hóa tiêu biểu: Ruộng bậc thang"
                />
              </div>
              <div className="ec-feature-img-tag glass-panel">
                <div className="ec-tag-icon">
                  <LuStar />
                </div>
                <div className="ec-tag-text">
                  <strong>Di sản văn hóa phi vật thể</strong>
                  <span>UNESCO công nhận - Bảo tồn và phát huy</span>
                </div>
              </div>
            </div>

            <div className="ec-feature-text fade-up delay-1">
              <span className="ec-badge ec-badge--accent">
                Văn hóa tiêu biểu
              </span>
              <h2 className="ec-section-title">
                Nét văn hóa tiêu biểu
                <br />
                của các dân tộc
              </h2>
              <p className="ec-feature-desc">
                Mỗi dân tộc Việt Nam mang trong mình một kho tàng văn hóa vô giá
                — được bồi đắp qua hàng nghìn năm lịch sử, gắn liền với đất đai,
                sông núi và tâm hồn con người nơi đó.
              </p>

              <ul className="ec-feature-list">
                <li className="ec-feature-item">
                  <div className="ec-fi-icon ec-fi-icon--red">
                    <LuShirt />
                  </div>
                  <div className="ec-fi-content">
                    <h4>Trang phục</h4>
                    <p>
                      Thổ cẩm thêu tay rực rỡ, mỗi hoa văn mang ý nghĩa tâm linh
                      sâu sắc, truyền từ đời này sang đời khác.
                    </p>
                  </div>
                </li>
                <li className="ec-feature-item">
                  <div className="ec-fi-icon ec-fi-icon--orange">
                    <LuStar />
                  </div>
                  <div className="ec-fi-content">
                    <h4>Lễ hội</h4>
                    <p>
                      Hơn 500 lễ hội truyền thống diễn ra quanh năm, từ Tết
                      Nguyên Đán đến các lễ hội cồng chiêng Tây Nguyên.
                    </p>
                  </div>
                </li>
                <li className="ec-feature-item">
                  <div className="ec-fi-icon ec-fi-icon--brown">
                    <LuUtensils />
                  </div>
                  <div className="ec-fi-content">
                    <h4>Ẩm thực</h4>
                    <p>
                      Mỗi vùng miền có đặc sản riêng – từ phở Bắc, bún bò Huế
                      đến cơm tấm Nam Bộ và canh thụt Tây Nguyên.
                    </p>
                  </div>
                </li>
                <li className="ec-feature-item">
                  <div className="ec-fi-icon ec-fi-icon--green">
                    <LuBookOpen />
                  </div>
                  <div className="ec-fi-content">
                    <h4>Phong tục</h4>
                    <p>
                      Nghi lễ vòng đời, hôn nhân, tang ma mang đậm bản sắc từng
                      dân tộc, phản ánh triết lý sống hài hòa với thiên nhiên.
                    </p>
                  </div>
                </li>
              </ul>

              <div className="ec-feature-actions">
                <button className="ec-btn-primary">Khám phá văn hóa</button>
                <button className="ec-btn-outline">Xem thư viện ảnh</button>
              </div>
            </div>
          </div>

          <div className="ec-section-wave ec-section-wave--bottom">
            <svg
              data-name="Layer 1"
              xmlns="http://www.w3.org/2000/svg"
              viewBox="0 0 1200 120"
              preserveAspectRatio="none"
            >
              <path
                d="M321.39,56.44c58-10.79,114.16-30.13,172-41.86,82.39-16.72,168.19-17.73,250.45-.39C823.78,31,906.67,72,985.66,92.83c70.05,18.48,146.53,26.09,214.34,3V0H0V27.35A600.21,600.21,0,0,0,321.39,56.44Z"
                fill="#ffffff"
              ></path>
            </svg>
          </div>
        </section>

        {/* HORIZONTAL GRID - NHỮNG NÉT VĂN HÓA ĐẶC SẮC NHẤT */}
        <section className="ec-section ec-section--light">
          <div className="ec-container">
            <div className="ec-section-header ec-flex-header">
              <div>
                <span className="ec-section-eyebrow">Di sản độc đáo</span>
                <h2 className="ec-section-title">
                  Những nét văn hóa
                  <br />
                  đặc sắc nhất
                </h2>
              </div>
              <div className="ec-nav-buttons">
                <button className="ec-nav-btn disable">&larr;</button>
                <button className="ec-nav-btn ec-nav-btn--active">
                  &rarr;
                </button>
              </div>
            </div>

            <div className="ec-grid ec-grid--3cols fade-up">
              {features.map((f) => (
                <div className="ec-hcard" key={f.id}>
                  <div className="ec-hcard__img">
                    {f.tag && <span className="ec-card__status">{f.tag}</span>}
                    <img src={f.imgUrl} alt={f.title} loading="lazy" />
                  </div>
                  <div className="ec-hcard__content">
                    <h3 className="ec-hcard__title">{f.title}</h3>
                    <p className="ec-hcard__desc">
                      Khám phá nét độc đáo trong đời sống và tinh thần truyền
                      tải qua hoạt động này.
                    </p>
                    <span className="ec-card__link">Tìm hiểu</span>
                  </div>
                </div>
              ))}
            </div>
          </div>
        </section>

        {/* MASONRY COLLAGE - KHOẢNH KHẮC VĂN HÓA SỐNG ĐỘNG */}
        <section className="ec-section ec-section--cream ec-section--wavy">
          <div className="ec-section-wave ec-section-wave--top">
            <svg
              data-name="Layer 1"
              xmlns="http://www.w3.org/2000/svg"
              viewBox="0 0 1200 120"
              preserveAspectRatio="none"
            >
              <path
                d="M321.39,56.44c58-10.79,114.16-30.13,172-41.86,82.39-16.72,168.19-17.73,250.45-.39C823.78,31,906.67,72,985.66,92.83c70.05,18.48,146.53,26.09,214.34,3V0H0V27.35A600.21,600.21,0,0,0,321.39,56.44Z"
                fill="#ffffff"
              ></path>
            </svg>
          </div>
          <div className="ec-container">
            {/* ... contents ... */}
            <div className="ec-section-header ec-center">
              <span className="ec-section-eyebrow">Thư viện ảnh</span>
              <h2 className="ec-section-title">
                Khoảnh khắc văn hóa
                <br />
                sống động
              </h2>
              <p className="ec-section-desc">
                Những góc nhìn chân thật, chớp lấy vẻ đẹp rực rỡ và nhịp sống
                đời thường.
              </p>
            </div>

            <div className="ec-masonry fade-up">
              {masonryImages.map((img, idx) => (
                <div
                  key={idx}
                  className={`ec-masonry-item ec-masonry-item--${img.size}`}
                >
                  <img
                    src={img.imgUrl}
                    alt="Khoảnh khắc văn hóa"
                    loading="lazy"
                  />
                  <div className="ec-masonry-overlay">
                    <span className="ec-btn-icon">🔍</span>
                  </div>
                </div>
              ))}
            </div>

            <div className="ec-center-action">
              <button className="ec-btn-outline">Xem thêm thư viện ảnh</button>
            </div>
          </div>
          <div className="ec-section-wave ec-section-wave--bottom">
            <svg
              data-name="Layer 1"
              xmlns="http://www.w3.org/2000/svg"
              viewBox="0 0 1200 120"
              preserveAspectRatio="none"
            >
              <path
                d="M321.39,56.44c58-10.79,114.16-30.13,172-41.86,82.39-16.72,168.19-17.73,250.45-.39C823.78,31,906.67,72,985.66,92.83c70.05,18.48,146.53,26.09,214.34,3V0H0V27.35A600.21,600.21,0,0,0,321.39,56.44Z"
                fill="#ffffff"
              ></path>
            </svg>
          </div>
        </section>

        {/* STORIES - CHUYỆN KỂ TỪ BẢN LÀNG XA */}
        <section className="ec-section ec-section--light">
          <div className="ec-container">
            <div className="ec-section-header ec-flex-header">
              <div>
                <span className="ec-section-eyebrow">Góc nhìn cận cảnh</span>
                <h2 className="ec-section-title">
                  Chuyện kể từ
                  <br />
                  bản làng xa
                </h2>
              </div>
              <Link to="/articles" className="ec-link-more">
                Xem tất cả bài viết &rsaquo;
              </Link>
            </div>

            <div className="ec-grid ec-grid--3cols fade-up">
              {stories.map((s) => (
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

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
import { useLanguage } from "../../context/LanguageContext";
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

// Localized Data Helper
const getI18nData = (lang) => {
  const isVi = lang === "vi";
  
  return {
    hero: {
      badge: isVi ? "Khám phá dải đất hình chữ S" : "Explore the S-shaped land",
      titleLine1: isVi ? "Văn Hóa" : "Cultural",
      titleAccent: isVi ? "Các Dân Tộc" : "Ethnic Groups",
      titleLine2: isVi ? "Việt Nam" : "of Vietnam",
      subtitle: isVi 
        ? "Từ những đỉnh núi mờ sương Tây Bắc đến những bản làng yên bình nơi đồng bằng, khám phá sự đa dạng và giàu có của văn hóa 54 dân tộc anh em."
        : "From the misty peaks of the Northwest to the peaceful villages in the plains, discover the diversity and richness of the culture of 54 ethnic groups.",
      searchPlaceholder: isVi ? "Tìm kiếm dân tộc, vùng miền..." : "Search ethnic groups, regions...",
      filterRegion: isVi ? "Vùng miền" : "Regions",
      filterEthnic: isVi ? "Dân tộc" : "Ethnic Groups",
      btnSearch: isVi ? "Tìm ngay" : "Search now",
    },
    stats: [
      {
        value: "54",
        label: isVi ? "Dân tộc" : "Ethnic groups",
        subtext: isVi ? "đa dạng và phong phú bản sắc văn hóa" : "diverse and rich cultural identity",
      },
      {
        value: "8",
        label: isVi ? "Vùng văn hóa" : "Cultural regions",
        subtext: isVi ? "với những đặc trưng địa hình, khí hậu" : "with unique terrain and climate",
      },
      {
        value: "5,000+",
        label: isVi ? "Lễ hội" : "Festivals",
        subtext: isVi ? "được tổ chức hằng năm trên cả nước" : "held annually across the country",
      },
      {
        value: "1,000,000+",
        label: isVi ? "Hiện vật" : "Artifacts",
        subtext: isVi ? "về văn hóa các dân tộc đang lưu giữ" : "of ethnic cultures being preserved",
      },
    ],
    regions: isVi 
      ? ["Tất cả vùng", "Miền Bắc", "Miền Trung", "Miền Nam", "Tây Nguyên"]
      : ["All regions", "North", "Central", "South", "Central Highlands"],
    heroEthnicGroups: isVi
      ? ["Tất cả dân tộc", "Kinh", "Tày", "H'Mông", "Khmer", "Chăm", "Dao", "Ê Đê", "Mường"]
      : ["All ethnic groups", "Kinh", "Tay", "H'Mong", "Khmer", "Cham", "Dao", "E De", "Muong"],
    filters: isVi
      ? ["Tất cả dân tộc", "Mường", "Thái", "H'Mông", "Dao", "Kinh", "Khmer"]
      : ["All ethnic groups", "Muong", "Thai", "H'Mong", "Dao", "Kinh", "Khmer"],
    gridTitle: isVi ? "Cộng Đồng 54 Dân Tộc" : "Community of 54 Ethnic Groups",
    gridDesc: isVi ? "Mỗi dân tộc là một mảnh ghép rực rỡ trong bức tranh văn hóa Việt." : "Each ethnic group is a vibrant piece in the Vietnamese cultural tapestry.",
    ethnicCards: [
      {
        id: "hmong",
        name: isVi ? "Dân tộc Mông" : "H'Mong People",
        location: isVi ? "Hà Giang, Sơn La,..." : "Ha Giang, Son La,...",
        imgUrl: hmongImg,
        status: isVi ? "Nổi bật" : "Featured",
        region: "Miền Bắc",
        enRegion: "North",
      },
      {
        id: "dao",
        name: isVi ? "Dân tộc Dao" : "Dao People",
        location: isVi ? "Lào Cai, Yên Bái,..." : "Lao Cai, Yen Bai,...",
        imgUrl: daoImg,
        status: "",
        region: "Miền Bắc",
        enRegion: "North",
      },
      {
        id: "thai",
        name: isVi ? "Dân tộc Thái" : "Thai People",
        location: isVi ? "Điện Biên, Lai Châu,..." : "Dien Bien, Lai Chau,...",
        imgUrl: thaiImg,
        status: "",
        region: "Miền Bắc",
        enRegion: "North",
      },
      {
        id: "ede",
        name: isVi ? "Dân tộc Ê Đê" : "E De People",
        location: isVi ? "Đắk Lắk, Đắk Nông,..." : "Dak Lak, Dak Nong,...",
        imgUrl: edeImg,
        status: isVi ? "Mới" : "New",
        region: "Tây Nguyên",
        enRegion: "Central Highlands",
      },
      {
        id: "bana",
        name: isVi ? "Dân tộc Ba Na" : "Ba Na People",
        location: isVi ? "Gia Lai, Kon Tum,..." : "Gia Lai, Kon Tum,...",
        imgUrl: banaImg,
        status: "",
        region: "Tây Nguyên",
        enRegion: "Central Highlands",
      },
      {
        id: "khmer",
        name: isVi ? "Dân tộc Khmer" : "Khmer People",
        location: isVi ? "Sóc Trăng, Trà Vinh,..." : "Soc Trang, Tra Vinh,...",
        imgUrl: khmerImg,
        status: "",
        region: "Miền Nam",
        enRegion: "South",
      },
      {
        id: "cham",
        name: isVi ? "Dân tộc Chăm" : "Cham People",
        location: isVi ? "Ninh Thuận, Bình Thuận,..." : "Ninh Thuan, Binh Thuan,...",
        imgUrl: chamImg,
        status: isVi ? "Nổi bật" : "Featured",
        region: "Miền Nam",
        enRegion: "South",
      },
      {
        id: "muong",
        name: isVi ? "Dân tộc Mường" : "Muong People",
        location: isVi ? "Hòa Bình, Thanh Hóa,..." : "Hoa Binh, Thanh Hoa,...",
        imgUrl: muongImg,
        status: "",
        region: "Miền Bắc",
        enRegion: "North",
      },
      {
        id: "tày",
        name: isVi ? "Dân tộc Tày" : "Tay People",
        location: isVi ? "Cao Bằng, Lạng Sơn,..." : "Cao Bang, Lang Son,...",
        imgUrl: thaiImg,
        status: "",
        region: "Miền Bắc",
        enRegion: "North",
      },
      {
        id: "nung",
        name: isVi ? "Dân tộc Nùng" : "Nung People",
        location: isVi ? "Lạng Sơn, Cao Bằng,..." : "Lang Son, Cao Bang,...",
        imgUrl: daoImg,
        status: "",
        region: "Miền Bắc",
        enRegion: "North",
      },
      {
        id: "hà-nhì",
        name: isVi ? "Dân tộc Hà Nhì" : "Ha Nhi People",
        location: isVi ? "Lai Châu, Lào Cai,..." : "Lai Chau, Lao Cai,...",
        imgUrl: hmongImg,
        status: "",
        region: "Miền Bắc",
        enRegion: "North",
      },
      {
        id: "ta-oi",
        name: isVi ? "Dân tộc Tà Ôi" : "Ta Oi People",
        location: isVi ? "Thừa Thiên Huế,..." : "Thua Thien Hue,...",
        imgUrl: banaImg,
        status: "",
        region: "Miền Trung",
        enRegion: "Central",
      },
      {
        id: "churu",
        name: isVi ? "Dân tộc Chu Ru" : "Chu Ru People",
        location: isVi ? "Lâm Đồng, Ninh Thuận,..." : "Lam Dong, Ninh Thuan,...",
        imgUrl: edeImg,
        status: "",
        region: "Tây Nguyên",
        enRegion: "Central Highlands",
      },
      {
        id: "san-diu",
        name: isVi ? "Dân tộc Sán Dìu" : "San Diu People",
        location: isVi ? "Vĩnh Phúc, Thái Nguyên,..." : "Vinh Phuc, Thai Nguyen,...",
        imgUrl: chamImg,
        status: "",
        region: "Miền Bắc",
        enRegion: "North",
      },
      {
        id: "co-tu",
        name: isVi ? "Dân tộc Cơ Tu" : "Co Tu People",
        location: isVi ? "Quảng Nam, Đà Nẵng,..." : "Quang Nam, Da Nang,...",
        imgUrl: muongImg,
        status: "",
        region: "Miền Trung",
        enRegion: "Central",
      },
      {
        id: "jrai",
        name: isVi ? "Dân tộc J'rai" : "J'rai People",
        location: isVi ? "Gia Lai, Kon Tum,..." : "Gia Lai, Kon Tum,...",
        imgUrl: edeImg,
        status: "",
        region: "Tây Nguyên",
        enRegion: "Central Highlands",
      },
    ],
    featuresTitle: isVi ? "Những nét văn hóa đặc sắc nhất" : "Key Cultural Highlights",
    featuresEyebrow: isVi ? "Di sản độc đáo" : "Unique Heritage",
    features: [
      { id: 1, title: isVi ? "Lễ hội đua bò Bảy Núi" : "An Giang Bull Racing", imgUrl: duaBoImg, tag: isVi ? "Nổi bật" : "Featured" },
      { id: 2, title: isVi ? "Nghệ thuật xòe Thái" : "Thai Folk Dance", imgUrl: xoeThaiImg, tag: "" },
      { id: 3, title: isVi ? "Không gian văn hóa Cồng Chiêng" : "Gong Culture", imgUrl: congChiengImg, tag: isVi ? "Di sản" : "Heritage" },
    ],
    storiesTitle: isVi ? "Chuyện kể từ bản làng xa" : "Village Tales",
    storiesEyebrow: isVi ? "Góc nhìn cận cảnh" : "Close-up",
    storiesMore: isVi ? "Xem tất cả bài viết" : "View all articles",
    stories: [
      {
        id: 1,
        title: isVi ? "Lễ Cấp sắc người Dao đỏ" : "Inititation of Red Dao",
        desc: isVi 
          ? "Lễ cấp sắc là một nghi lễ quan trọng đánh dấu sự trưởng thành của người đàn ông dân tộc Dao đỏ."
          : "Cap Sac is an important ritual marking maturity for Red Dao men.",
        imgUrl: leCapSacImg,
      },
      {
        id: 2,
        title: isVi ? "Dệt thổ cẩm người Lô Lô" : "Lo Lo Brocade Weaving",
        desc: isVi
          ? "Nghề dệt thổ cẩm truyền thống của người Lô Lô mang đậm nét văn hóa độc đáo với những họa tiết sặc sỡ."
          : "The traditional brocade weaving of Lo Lo people carries unique artistic patterns.",
        imgUrl: detThoCamImg,
      },
      {
        id: 3,
        title: isVi ? "Múa trống Sadam người Khmer" : "Khmer Sadam Drum Dance",
        desc: isVi
          ? "Trống Sadam không chỉ là nhạc cụ mà còn là linh hồn trong các lễ hội truyền thống của người Khmer."
          : "Sadam drum is the soul of traditional Khmer festivals in Southern Vietnam.",
        imgUrl: muaTrongImg,
      },
    ],
    details: {
      location: isVi ? "Vị trí" : "Location",
      status: isVi ? "Tìm hiểu" : "Learn more",
      noResults: isVi ? "Không tìm thấy kết quả phù hợp" : "No results found",
      allArticles: isVi ? "Xem tất cả bài viết ›" : "View all articles ›",
      photoGallery: isVi ? "Thư viện ảnh" : "Photo Gallery",
      momentsTitle: isVi ? "Khoảnh khắc văn hóa sống động" : "Vivid Cultural Moments",
      momentsDesc: isVi ? "Những góc nhìn chân thật, chớp lấy vẻ đẹp rực rỡ và nhịp sống đời thường." : "Authentic perspectives, capturing vibrant beauty and daily life.",
      viewMorePhoto: isVi ? "Xem thêm thư viện ảnh" : "View more photos",
      backToList: isVi ? "Quay lại danh sách" : "Back to list",
    },
    featuresTitle: isVi ? "Nét văn hóa tiêu biểu của các dân tộc" : "Key Cultural Highlights",
    featuresEyebrow: isVi ? "Văn hóa tiêu biểu" : "Cultural Highlights",
    featuresDescription: isVi 
      ? "Mỗi dân tộc Việt Nam mang trong mình một kho tàng văn hóa vô giá — được bồi đắp qua hàng nghìn năm lịch sử, gắn liền với đất đai, sông núi và tâm hồn con người nơi đó."
      : "Each ethnic group in Vietnam carries an invaluable cultural treasure — built over thousands of years of history, tied to the land, mountains, rivers, and the human soul.",
    featureItems: [
      { 
        title: isVi ? "Trang phục" : "Costumes", 
        desc: isVi 
          ? "Thổ cẩm thêu tay rực rỡ, mỗi hoa văn mang ý nghĩa tâm linh sâu sắc, truyền từ đời này sang đời khác." 
          : "Vibrant hand-embroidered brocade, each pattern carries deep spiritual meaning, passed down through generations." 
      },
      { 
        title: isVi ? "Lễ hội" : "Festivals", 
        desc: isVi 
          ? "Hơn 500 lễ hội truyền thống diễn ra quanh năm, từ Tết Nguyên Đán đến các lễ hội cồng chiêng Tây Nguyên." 
          : "Over 500 traditional festivals take place year-round, from Lunar New Year to Central Highlands gong festivals." 
      },
      { 
        title: isVi ? "Ẩm thực" : "Cuisine", 
        desc: isVi 
          ? "Mỗi vùng miền có đặc sản riêng – từ phở Bắc, bún bò Huế đến cơm tấm Nam Bộ và canh thụt Tây Nguyên." 
          : "Each region has its own specialties – from Northern Pho, Hue beef noodles to Southern broken rice." 
      },
      { 
        title: isVi ? "Phong tục" : "Customs", 
        desc: isVi 
          ? "Nghi lễ vòng đời, hôn nhân, tang ma mang đậm bản sắc từng dân tộc, phản ánh triết lý sống hài hòa với thiên nhiên." 
          : "Rituals of life cycles, marriage, and funerals bear deep ethnic identities, reflecting a philosophy of living in harmony with nature." 
      }
    ],
    featuresGridTitle: isVi ? "Những nét văn hóa đặc sắc nhất" : "Most Unique Cultural Traits",
    featuresGridDesc: isVi ? "Khám phá nét độc đáo trong đời sống và tinh thần truyền tải qua hoạt động này." : "Explore the uniqueness in life and spirit conveyed through these activities.",
    galleryEyebrow: isVi ? "Thư viện ảnh" : "Photo Gallery",
    galleryTitle: isVi ? "Khoảnh khắc văn hóa sống động" : "Vivid Cultural Moments",
    galleryDesc: isVi ? "Những góc nhìn chân thật, chớp lấy vẻ đẹp rực rỡ và nhịp sống đời thường." : "Authentic perspectives, capturing vibrant beauty and daily life.",
    galleryMore: isVi ? "Xem thêm thư viện ảnh" : "View more photos",
    learnMore: isVi ? "Tìm hiểu thêm" : "Learn more",
    exploreCulture: isVi ? "Khám phá văn hóa" : "Explore Culture",
    featureHighlight: {
      title: isVi ? "Di sản văn hóa phi vật thể" : "Intangible Cultural Heritage",
      desc: isVi ? "UNESCO công nhận - Bảo tồn và phát huy" : "UNESCO Recognized - Preserving and Promoting"
    }
  };
};

// Masonry Data
const masonryImages = [
  { size: "large", imgUrl: ruongBacThangImg },
  { size: "small", imgUrl: chamImg },
  { size: "tall", imgUrl: xoeThaiImg },
  { size: "small", imgUrl: edeImg },
  { size: "wide", imgUrl: duaBoImg },
  { size: "small", imgUrl: congChiengImg },
];

export default function EthnicCultures() {
  const { lang, setLang } = useLanguage()
  const i18n = getI18nData(lang);
  const isVi = lang === "vi";
  
  const [activeFilter, setActiveFilter] = useState(i18n.regions[0]);
  const [isDropdownOpen, setIsDropdownOpen] = useState(false);
  const [activeRegion, setActiveRegion] = useState(i18n.regions[0]);
  const [isRegionOpen, setIsRegionOpen] = useState(false);
  const [activeHeroEthnic, setActiveHeroEthnic] = useState(i18n.heroEthnicGroups[0]);
  const [isHeroEthnicOpen, setIsHeroEthnicOpen] = useState(false);
  const [searchQuery, setSearchQuery] = useState("");

  // Pagination Logic
  const [currentPage, setCurrentPage] = useState(1);
  const ITEMS_PER_PAGE = 8;
  const regions = i18n.regions;

  // Reset filters when language changes
  React.useEffect(() => {
    setActiveFilter(i18n.regions[0]);
    setActiveRegion(i18n.regions[0]);
    setActiveHeroEthnic(i18n.heroEthnicGroups[0]);
  }, [lang]);

  const filteredCards = i18n.ethnicCards.filter((c) => {
    const matchRegionFilter =
      activeFilter === i18n.regions[0] ? true : (lang === "vi" ? c.region === activeFilter : c.enRegion === activeFilter);
    const matchHeroRegion =
      activeRegion === i18n.regions[0] ? true : (lang === "vi" ? c.region === activeRegion : c.enRegion === activeRegion);
    const matchHeroEthnic =
      activeHeroEthnic === i18n.heroEthnicGroups[0]
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
                {i18n.hero.badge}
              </div>

              <h1 className="ec-hero__title">
                <span className="ec-hero__title-line">{i18n.hero.titleLine1}</span>
                <span className="ec-hero__title-accent">{i18n.hero.titleAccent}</span>
                <span className="ec-hero__title-line">{i18n.hero.titleLine2}</span>
              </h1>

              <div className="ec-hero__divider-row">
                <span className="ec-hero__divider-line"></span>
                <span className="ec-hero__divider-diamond">◆</span>
                <span className="ec-hero__divider-line"></span>
              </div>

              <p className="ec-hero__subtitle">
                {i18n.hero.subtitle}
              </p>

              {/* Cultural stats */}
              <div className="ec-hero__stats">
                <div className="ec-hero__stat">
                  <strong>{i18n.stats[0].value}</strong><span>{i18n.stats[0].label}</span>
                </div>
                <div className="ec-hero__stat-sep">|</div>
                <div className="ec-hero__stat">
                  <strong>{i18n.stats[1].value}</strong><span>{i18n.stats[1].label}</span>
                </div>
                <div className="ec-hero__stat-sep">|</div>
                <div className="ec-hero__stat">
                  <strong>{i18n.stats[2].value}</strong><span>{i18n.stats[2].label}</span>
                </div>
              </div>

              {/* Search Bar Restyled */}
              <div className="ec-hero__search-bar">
                <div 
                  className={`ec-search-field-wrapper ${searchQuery ? "active" : ""}`}
                >
                  <div className="ec-search-main">
                    <span className="ec-search-label">{isVi ? "Dân tộc & Vùng miền" : "Ethnicities & Regions"}</span>
                    <div className="ec-search-field">
                      <LuSearch className="ec-search-icon" />
                      <input
                        type="text"
                        placeholder={i18n.hero.searchPlaceholder}
                        value={searchQuery}
                        onChange={(e) => setSearchQuery(e.target.value)}
                      />
                    </div>
                  </div>
                </div>

                <div className="ec-search-divider" />

                <div 
                  className={`ec-search-field-wrapper ${isRegionOpen ? "active" : ""}`}
                  onClick={() => {
                    setIsRegionOpen(!isRegionOpen);
                    setIsHeroEthnicOpen(false);
                  }}
                >
                  <div className="ec-search-main">
                    <span className="ec-search-label">{i18n.hero.filterRegion}</span>
                    <div className="ec-search-field">
                      <span>
                        {activeRegion === i18n.regions[0] ? (isVi ? "Tất cả vùng" : "All regions") : activeRegion}
                      </span>
                      <LuChevronDown
                        className={`ec-chevron-icon ${isRegionOpen ? "rotate" : ""}`}
                      />
                    </div>
                  </div>

                  {isRegionOpen && (
                    <ul className="ec-hero-dropdown">
                      {i18n.regions.map((r) => (
                        <li
                          key={r}
                          className={`ec-hero-dropdown-item ${activeRegion === r ? "selected" : ""}`}
                          onClick={(e) => {
                            e.stopPropagation();
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

                <div 
                  className={`ec-search-field-wrapper ${isHeroEthnicOpen ? "active" : ""}`}
                  onClick={() => {
                    setIsHeroEthnicOpen(!isHeroEthnicOpen);
                    setIsRegionOpen(false);
                  }}
                >
                  <div className="ec-search-main">
                    <span className="ec-search-label">{i18n.hero.filterEthnic}</span>
                    <div className="ec-search-field">
                      <span>
                        {activeHeroEthnic === i18n.heroEthnicGroups[0]
                          ? (isVi ? "Tất cả dân tộc" : "All ethnicities")
                          : activeHeroEthnic}
                      </span>
                      <LuChevronDown
                        className={`ec-chevron-icon ${isHeroEthnicOpen ? "rotate" : ""}`}
                      />
                    </div>
                  </div>

                  {isHeroEthnicOpen && (
                    <ul className="ec-hero-dropdown">
                      {i18n.heroEthnicGroups.map((e) => (
                        <li
                          key={e}
                          className={`ec-hero-dropdown-item ${activeHeroEthnic === e ? "selected" : ""}`}
                          onClick={(ev) => {
                            ev.stopPropagation();
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

                <button className="ec-hero__cta-btn">
                  <LuSearch />
                  {isVi ? "Tìm ngay" : "Search"}
                </button>
              </div>
            </div>

            {/* RIGHT: Image Frame */}
            <div className="ec-hero__right fade-up">
              <div className="ec-hero__img-frame">
                <img
                  src={hmongImg}
                  alt={isVi ? "Dân tộc" : "Ethnic Group"}
                  className="ec-hero__img-main"
                />
                <div className="ec-hero__img-ring"></div>
                <div className="ec-hero__img-badge">
                  <span className="ec-hero__img-badge-icon">🌟</span>
                  {isVi ? "Bản sắc độc đáo" : "Unique Identity"}
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
                  {isVi ? "CỘNG ĐỒNG 54 DÂN TỘC" : "COMMUNITY OF 54 GROUPS"}
                </span>
                <h2 className="ec-section-title ec-serif">{i18n.gridTitle}</h2>
                <p className="ec-section-desc">{i18n.gridDesc}</p>
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
                    <span className="ec-card__link">{i18n.details.status}</span>
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
                  <strong>{i18n.featureHighlight.title}</strong>
                  <span>{i18n.featureHighlight.desc}</span>
                </div>
              </div>
            </div>

            <div className="ec-feature-text fade-up delay-1">
              <span className="ec-badge ec-badge--accent">
                {i18n.featuresEyebrow}
              </span>
              <h2 className="ec-section-title">
                {i18n.featuresTitle}
              </h2>
              <p className="ec-feature-desc">
                {i18n.featuresDescription}
              </p>

              <ul className="ec-feature-list">
                <li className="ec-feature-item">
                  <div className="ec-fi-icon ec-fi-icon--red">
                    <LuShirt />
                  </div>
                  <div className="ec-fi-content">
                    <h4>{i18n.featureItems[0].title}</h4>
                    <p>
                      {i18n.featureItems[0].desc}
                    </p>
                  </div>
                </li>
                <li className="ec-feature-item">
                  <div className="ec-fi-icon ec-fi-icon--orange">
                    <LuStar />
                  </div>
                  <div className="ec-fi-content">
                    <h4>{i18n.featureItems[1].title}</h4>
                    <p>
                      {i18n.featureItems[1].desc}
                    </p>
                  </div>
                </li>
                <li className="ec-feature-item">
                  <div className="ec-fi-icon ec-fi-icon--brown">
                    <LuUtensils />
                  </div>
                  <div className="ec-fi-content">
                    <h4>{i18n.featureItems[2].title}</h4>
                    <p>
                      {i18n.featureItems[2].desc}
                    </p>
                  </div>
                </li>
                <li className="ec-feature-item">
                  <div className="ec-fi-icon ec-fi-icon--green">
                    <LuBookOpen />
                  </div>
                  <div className="ec-fi-content">
                    <h4>{i18n.featureItems[3].title}</h4>
                    <p>
                      {i18n.featureItems[3].desc}
                    </p>
                  </div>
                </li>
              </ul>

              <div className="ec-feature-actions">
                <button className="ec-btn-primary">{i18n.exploreCulture}</button>
                <button className="ec-btn-outline">{i18n.galleryMore}</button>
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
                <span className="ec-section-eyebrow">{i18n.featuresEyebrow}</span>
                <h2 className="ec-section-title">
                  {i18n.featuresGridTitle}
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
              {i18n.features.map((f) => (
                <div className="ec-hcard" key={f.id}>
                  <div className="ec-hcard__img">
                    {f.tag && <span className="ec-card__status">{f.tag}</span>}
                    <img src={f.imgUrl} alt={f.title} loading="lazy" />
                  </div>
                  <div className="ec-hcard__content">
                    <h3 className="ec-hcard__title">{f.title}</h3>
                    <p className="ec-hcard__desc">
                      {i18n.featuresGridDesc}
                    </p>
                    <span className="ec-card__link">{i18n.learnMore}</span>
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
            <div className="ec-section-header ec-center">
              <span className="ec-section-eyebrow">{i18n.galleryEyebrow}</span>
              <h2 className="ec-section-title">
                {i18n.galleryTitle}
              </h2>
              <p className="ec-section-desc">
                {i18n.galleryDesc}
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
              <button className="ec-btn-outline">{i18n.galleryMore}</button>
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
                <span className="ec-section-eyebrow">{i18n.storiesEyebrow}</span>
                <h2 className="ec-section-title">
                  {i18n.storiesTitle}
                </h2>
              </div>
              <Link to="/articles" className="ec-link-more">
                {i18n.details.allArticles}
              </Link>
            </div>

            <div className="ec-grid ec-grid--3cols fade-up">
              {i18n.stories.map((s) => (
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

import { useEffect, useMemo, useState } from "react";
import { Link } from "react-router-dom";
import PageHeader from "../../components/layout/PageHeader/PageHeader";
import Footer from "../../components/layout/Footer/Footer";
import LoadingState from "../../components/common/LoadingState/LoadingState";
import { getFestivals } from "../../services/festival.service";
import "./FestivalsPage.css";
import "../../App.css";

const REGION_OPTIONS = [
  { value: "", label: "Tất cả khu vực" },
  { value: "north", label: "Miền Bắc" },
  { value: "central", label: "Miền Trung" },
  { value: "south", label: "Miền Nam" },
];

const MONTH_OPTIONS = [
  { value: "", label: "Tất cả tháng" },
  { value: "1", label: "Tháng 1" },
  { value: "2", label: "Tháng 2" },
  { value: "3", label: "Tháng 3" },
  { value: "4", label: "Tháng 4" },
  { value: "5", label: "Tháng 5" },
  { value: "6", label: "Tháng 6" },
  { value: "7", label: "Tháng 7" },
  { value: "8", label: "Tháng 8" },
  { value: "9", label: "Tháng 9" },
  { value: "10", label: "Tháng 10" },
  { value: "11", label: "Tháng 11" },
  { value: "12", label: "Tháng 12" },
];

const CATEGORY_OPTIONS = [
  { value: "", label: "Tất cả loại hình" },
  { value: "major", label: "Lễ hội lớn" },
  { value: "cultural", label: "Văn hóa" },
  { value: "religious", label: "Tín ngưỡng" },
  { value: "ethnic", label: "Dân tộc" },
];

function getImageUrl(value) {
  return value || "https://placehold.co/1200x800/f4e4d4/7a4b2f?text=Le+hoi+Viet+Nam";
}

export default function FestivalsPage() {
  const [lang, setLang] = useState("vi");
  const [isFiltersOpen, setIsFiltersOpen] = useState(false);
  const [searchText, setSearchText] = useState("");
  const [selectedRegion, setSelectedRegion] = useState("");
  const [selectedMonth, setSelectedMonth] = useState("");
  const [selectedCategory, setSelectedCategory] = useState("");
  const [selectedEthnicGroup, setSelectedEthnicGroup] = useState("");
  const [state, setState] = useState({ status: "loading", data: null, error: "" });

  useEffect(() => {
    let ignore = false;

    async function load() {
      try {
        setState({ status: "loading", data: null, error: "" });
        const data = await getFestivals(lang);
        if (!ignore) {
          setState({ status: "success", data, error: "" });
        }
      } catch (error) {
        if (!ignore) {
          setState({ status: "error", data: null, error: error.message });
        }
      }
    }

    load();
    return () => {
      ignore = true;
    };
  }, [lang]);

  const page = state.data?.page || {};
  const rawFestivals = state.data?.festivals;
  const festivals = useMemo(() => rawFestivals || [], [rawFestivals]);
  const rawTimeline = page.timelineItems?.length ? page.timelineItems : state.data?.timeline;
  const timeline = useMemo(() => rawTimeline || [], [rawTimeline]);
  const rawGalleryImages = page.galleryImages;
  const galleryImages = useMemo(() => rawGalleryImages || [], [rawGalleryImages]);
  const featuredCards = festivals.slice(0, 3);
  const fanCards = festivals.slice(0, 5);

  const ethnicOptions = useMemo(() => {
    const values = [...new Set(festivals.map((item) => item.tag).filter(Boolean))];
    return [{ value: "", label: "Tất cả nhóm trải nghiệm" }, ...values.map((value) => ({ value, label: value }))];
  }, [festivals]);

  const filteredFestivals = useMemo(() => {
    return festivals.filter((fest) => {
      const matchesSearch = !searchText || [fest.title, fest.enTitle, fest.desc, fest.location, fest.date]
        .filter(Boolean)
        .join(" ")
        .toLowerCase()
        .includes(searchText.toLowerCase());

      const matchesRegion = !selectedRegion || (fest.location || "").toLowerCase().includes(
        selectedRegion === "north" ? "bắc" : selectedRegion === "central" ? "trung" : "nam",
      );

      const matchesMonth = !selectedMonth || (fest.date || "").includes(`Tháng ${selectedMonth}`) || (fest.date || "").includes(`/${selectedMonth}`);
      const matchesCategory = !selectedCategory || (fest.tag || "").toLowerCase().includes(selectedCategory === "major" ? "lớn" : selectedCategory === "cultural" ? "văn hóa" : selectedCategory === "religious" ? "tín ngưỡng" : "dân tộc");
      const matchesEthnic = !selectedEthnicGroup || fest.tag === selectedEthnicGroup;

      return matchesSearch && matchesRegion && matchesMonth && matchesCategory && matchesEthnic;
    });
  }, [festivals, searchText, selectedRegion, selectedMonth, selectedCategory, selectedEthnicGroup]);

  if (state.status === "loading") {
    return <LoadingState message="Đang tải dữ liệu lễ hội..." />;
  }

  if (state.status === "error") {
    return <LoadingState type="error" message="Không tải được dữ liệu lễ hội." detail={state.error} />;
  }

  return (
    <>
      <PageHeader lang={lang} onLangChange={setLang} />

      <main className="festivals-main">
        <section className="festivals-hero">
          <div className="festivals-hero__bg" style={{ backgroundImage: `url(${getImageUrl(page.heroImageUrl)})` }}></div>
          <div className="festivals-hero__overlay"></div>
          <div className="festivals-hero__ornament festivals-hero__ornament--tl"></div>
          <div className="festivals-hero__ornament festivals-hero__ornament--br"></div>

          <div className="festivals-hero__inner">
            <div className="festivals-hero__left">
              <div className="festivals-hero__badge">
                <span className="festivals-hero__badge-dot"></span>
                {page.badge || "Lễ hội · Văn hóa · Truyền thống"}
              </div>

              <h1 className="festivals-hero__title">
                <span className="festivals-hero__title-line">{page.titleLine1 || "Tinh hoa"}</span>
                <span className="festivals-hero__title-accent">{page.titleAccent || "Lễ hội"}</span>
                <span className="festivals-hero__title-line">{page.titleLine3 || "Việt Nam"}</span>
              </h1>

              <div className="festivals-hero__divider-row">
                <span className="festivals-hero__divider-line"></span>
                <span className="festivals-hero__divider-diamond">◆</span>
                <span className="festivals-hero__divider-line"></span>
              </div>

              <p className="festivals-hero__subtitle">
                {page.subtitle || "Hàng nghìn năm truyền thống hội tụ trong từng lễ hội — nơi sắc màu, âm thanh và tâm hồn Việt hòa quyện thành một."}
              </p>

              <div className="festivals-hero__stats">
                {(page.stats || [
                  { value: "8.000+", label: "Lễ hội hàng năm" },
                  { value: "54", label: "Dân tộc anh em" },
                  { value: "63", label: "Tỉnh thành" },
                ]).map((item, index) => (
                  <div key={`${item.label}-${index}`} style={{ display: "contents" }}>
                    <div className="festivals-hero__stat">
                      <strong>{item.value}</strong>
                      <span>{item.label}</span>
                    </div>
                    {index < (page.stats || []).length - 1 ? <div className="festivals-hero__stat-sep">|</div> : null}
                  </div>
                ))}
              </div>
            </div>

            <div className="festivals-hero__right">
              <div className="festivals-fan">
                {fanCards[0] ? (
                  <div className="festivals-fan__card festivals-fan__card--fl">
                    <img src={getImageUrl(fanCards[0].image)} alt={fanCards[0].title} />
                    <div className="festivals-fan__card-label">
                      <span className="festivals-fan__card-dot"></span>
                      {fanCards[0].title}
                    </div>
                  </div>
                ) : null}

                {fanCards[1] ? (
                  <div className="festivals-fan__card festivals-fan__card--fr">
                    <img src={getImageUrl(fanCards[1].image)} alt={fanCards[1].title} />
                    <div className="festivals-fan__card-label">
                      <span className="festivals-fan__card-dot"></span>
                      {fanCards[1].title}
                    </div>
                  </div>
                ) : null}

                {fanCards[2] ? (
                  <div className="festivals-fan__card festivals-fan__card--l">
                    <img src={getImageUrl(fanCards[2].image)} alt={fanCards[2].title} />
                    <div className="festivals-fan__card-label">
                      <span className="festivals-fan__card-dot"></span>
                      {fanCards[2].title}
                    </div>
                  </div>
                ) : null}

                {fanCards[3] ? (
                  <div className="festivals-fan__card festivals-fan__card--r">
                    <img src={getImageUrl(fanCards[3].image)} alt={fanCards[3].title} />
                    <div className="festivals-fan__card-label">
                      <span className="festivals-fan__card-dot"></span>
                      {fanCards[3].title}
                    </div>
                  </div>
                ) : null}

                {fanCards[4] ? (
                  <div className="festivals-fan__card festivals-fan__card--c">
                    <img src={getImageUrl(fanCards[4].image)} alt={fanCards[4].title} />
                    <div className="festivals-fan__card-label">
                      <span className="festivals-fan__card-dot"></span>
                      {fanCards[4].title}
                    </div>
                  </div>
                ) : null}

                <div className="festivals-fan__badge">
                  <span>🎏</span>
                  <span>{page.stats?.[0]?.value || "8.000+"} lễ hội</span>
                </div>
              </div>
            </div>
          </div>

          <div className="festivals-hero__scroll">
            <div className="festivals-mouse-icon"></div>
          </div>
        </section>

        <section className="festivals-search-section">
          <div className="festivals-search-container">
            <div className="festivals-search-row">
              <div className="festivals-search-bar">
                <svg className="search-icon" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="#ce112d" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                  <circle cx="11" cy="11" r="8"></circle>
                  <line x1="21" y1="21" x2="16.65" y2="16.65"></line>
                </svg>
                <input
                  type="text"
                  placeholder={page.searchPlaceholder || "Tìm kiếm lễ hội, nghi lễ và truyền thống..."}
                  className="festivals-search-input"
                  value={searchText}
                  onChange={(event) => setSearchText(event.target.value)}
                />
              </div>
              <button
                className={`festivals-filter-btn ${isFiltersOpen ? "active" : ""}`}
                onClick={() => setIsFiltersOpen(!isFiltersOpen)}
              >
                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="#ce112d" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                  <polygon points="22 3 2 3 10 12.46 10 19 14 21 14 12.46 22 3"></polygon>
                </svg>
                <span>{page.filterButton || "Bộ lọc nâng cao"}</span>
                <svg
                  width="18"
                  height="18"
                  viewBox="0 0 24 24"
                  fill="none"
                  stroke="#ce112d"
                  strokeWidth="2"
                  strokeLinecap="round"
                  strokeLinejoin="round"
                  style={{ transform: isFiltersOpen ? "rotate(180deg)" : "none", transition: "transform 0.3s ease" }}
                >
                  <polyline points="6 9 12 15 18 9"></polyline>
                </svg>
              </button>
            </div>

            <div className={`festivals-filters-grid ${isFiltersOpen ? "open" : ""}`}>
              <div className="festivals-filter-item">
                <span className="festivals-filter-icon">📍</span>
                <select className="festivals-filter-select" value={selectedRegion} onChange={(event) => setSelectedRegion(event.target.value)}>
                  {REGION_OPTIONS.map((option) => (
                    <option key={option.value || "all-regions"} value={option.value}>{option.label}</option>
                  ))}
                </select>
                <svg className="festivals-filter-chevron" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#ce112d" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                  <polyline points="6 9 12 15 18 9"></polyline>
                </svg>
              </div>

              <div className="festivals-filter-item">
                <span className="festivals-filter-icon">🗓️</span>
                <select className="festivals-filter-select" value={selectedMonth} onChange={(event) => setSelectedMonth(event.target.value)}>
                  {MONTH_OPTIONS.map((option) => (
                    <option key={option.value || "all-months"} value={option.value}>{option.label}</option>
                  ))}
                </select>
                <svg className="festivals-filter-chevron" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#ce112d" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                  <polyline points="6 9 12 15 18 9"></polyline>
                </svg>
              </div>

              <div className="festivals-filter-item">
                <span className="festivals-filter-icon">🎭</span>
                <select className="festivals-filter-select" value={selectedCategory} onChange={(event) => setSelectedCategory(event.target.value)}>
                  {CATEGORY_OPTIONS.map((option) => (
                    <option key={option.value || "all-categories"} value={option.value}>{option.label}</option>
                  ))}
                </select>
                <svg className="festivals-filter-chevron" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#ce112d" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                  <polyline points="6 9 12 15 18 9"></polyline>
                </svg>
              </div>

              <div className="festivals-filter-item">
                <span className="festivals-filter-icon">👥</span>
                <select className="festivals-filter-select" value={selectedEthnicGroup} onChange={(event) => setSelectedEthnicGroup(event.target.value)}>
                  {ethnicOptions.map((option) => (
                    <option key={option.value || "all-ethnic-groups"} value={option.value}>{option.label}</option>
                  ))}
                </select>
                <svg className="festivals-filter-chevron" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#ce112d" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                  <polyline points="6 9 12 15 18 9"></polyline>
                </svg>
              </div>
            </div>
          </div>
        </section>

        <section className="festivals-major" id="explore">
          <div className="festivals-major__container">
            <div className="festivals-major__header fade-up">
              <div className="festivals-major__badge">{page.major?.badge || "Lễ hội nổi bật"}</div>
              <h2 className="festivals-major__title">{page.major?.title || "Lễ hội tiêu biểu"}</h2>
              <p className="festivals-major__subtitle">{page.major?.subtitle || "Khám phá những lễ hội nổi bật và có sức lan tỏa mạnh mẽ trong văn hóa Việt Nam"}</p>
            </div>

            <div className="festivals-major__grid">
              {featuredCards.map((fest, index) => (
                <article className="festivals-card fade-up" style={{ animationDelay: `${index * 0.1}s` }} key={fest.id}>
                  <div className="festivals-card__img">
                    <img src={getImageUrl(fest.image)} alt={fest.title} loading="lazy" />
                    <span className="festivals-card__tag">{fest.tag}</span>
                  </div>
                  <div className="festivals-card__body">
                    <div className="festivals-card__times">{fest.date}</div>
                    <div className="festival-card__content">
                      <h3 className="festivals-card__title">{fest.title}</h3>
                      <span className="festivals-card__en-title">{fest.enTitle}</span>
                      <p className="festivals-card__desc">{fest.desc}</p>
                      <div className="festivals-card__meta">
                        <div className="festivals-card__meta-item">{fest.location}</div>
                        <div className="festivals-card__meta-item">{fest.tag}</div>
                      </div>
                    </div>
                  </div>
                </article>
              ))}
            </div>
          </div>
        </section>

        <section className="festivals-meaning">
          <div className="festivals-meaning__container">
            <div className="festivals-meaning__gallery">
              <div className="gallery-col">
                <img src={getImageUrl(galleryImages[0]?.imageUrl || filteredFestivals[0]?.image)} alt={galleryImages[0]?.alt || filteredFestivals[0]?.title || "Khoảnh khắc lễ hội"} className="img-tall fade-up" />
                <img src={getImageUrl(galleryImages[1]?.imageUrl || filteredFestivals[1]?.image)} alt={galleryImages[1]?.alt || filteredFestivals[1]?.title || "Khoảnh khắc lễ hội"} className="img-square fade-up" style={{ animationDelay: "0.1s" }} />
                <img src={getImageUrl(galleryImages[2]?.imageUrl || filteredFestivals[2]?.image)} alt={galleryImages[2]?.alt || filteredFestivals[2]?.title || "Khoảnh khắc lễ hội"} className="img-square fade-up" style={{ animationDelay: "0.2s" }} />
              </div>
              <div className="gallery-col gallery-col--offset">
                <img src={getImageUrl(galleryImages[3]?.imageUrl || filteredFestivals[3]?.image)} alt={galleryImages[3]?.alt || filteredFestivals[3]?.title || "Khoảnh khắc lễ hội"} className="img-square fade-up" style={{ animationDelay: "0.3s" }} />
                <img src={getImageUrl(galleryImages[4]?.imageUrl || filteredFestivals[4]?.image)} alt={galleryImages[4]?.alt || filteredFestivals[4]?.title || "Khoảnh khắc lễ hội"} className="img-square fade-up" style={{ animationDelay: "0.4s" }} />
                <img src={getImageUrl(galleryImages[5]?.imageUrl || filteredFestivals[5]?.image)} alt={galleryImages[5]?.alt || filteredFestivals[5]?.title || "Khoảnh khắc lễ hội"} className="img-landscape fade-up" style={{ animationDelay: "0.5s" }} />
              </div>
            </div>

            <div className="festivals-meaning__content fade-up">
              <div className="festivals-meaning__tag">{page.meaning?.badge || "Ý nghĩa văn hóa"}</div>
              <h2 className="festivals-meaning__title">{page.meaning?.title || "Linh hồn của lễ hội Việt"}</h2>
              <div className="festivals-meaning__desc">
                {(page.meaning?.paragraphs || [
                  "Lễ hội Việt Nam không chỉ là những ngày vui mà còn là nơi kết nối con người với cội nguồn, vùng đất và ký ức cộng đồng.",
                  "Mỗi nghi thức, biểu tượng và hoạt động trong lễ hội đều phản ánh chiều sâu văn hóa, niềm tin và tinh thần gắn kết của người Việt.",
                  "Khi tham gia lễ hội, chúng ta không chỉ quan sát mà còn trực tiếp cảm nhận nhịp sống văn hóa đang tiếp tục được lưu truyền qua nhiều thế hệ.",
                ]).map((paragraph, index) => (
                  <p key={index}>{paragraph}</p>
                ))}
              </div>
              <Link to={page.meaning?.buttonHref || "/articles"} className="festivals-btn festivals-btn--primary festivals-meaning__btn">
                {page.meaning?.button || "Tìm hiểu thêm về văn hóa Việt"}
              </Link>
            </div>
          </div>
        </section>

        <section className="festivals-all" id="all-celebrations">
          <div className="festivals-all__header fade-up">
            <h2 className="festivals-all__title">{page.all?.title || "Khám phá các lễ hội Việt Nam"}</h2>
            <p className="festivals-all__subtitle">{page.all?.subtitle || "Mở từng trang để xem nội dung lễ hội tương ứng được tải động từ hệ thống"}</p>
          </div>

          <div className="festivals-all__grid">
            {filteredFestivals.map((fest, index) => {
              if (index === 0) {
                return (
                  <article className="festival-featured-card fade-up" key={fest.id}>
                    <div className="festival-featured-card__bg" style={{ backgroundImage: `url(${getImageUrl(fest.image)})` }}></div>
                    <div className="festival-featured-card__overlay"></div>
                    <div className="festival-featured-card__content">
                      <div className="festival-tags">
                        <span className="festival-tag festival-tag--featured">Nổi bật</span>
                        <span className="festival-tag festival-tag--category">{fest.tag}</span>
                      </div>
                      <h3 className="festival-featured-card__title">{fest.title}</h3>
                      <p className="festival-featured-card__en-title">{fest.enTitle}</p>
                      <div className="festival-meta-group">
                        <div className="festival-meta-item">{fest.location}</div>
                        <div className="festival-meta-item">{fest.date}</div>
                      </div>
                      <p className="festival-featured-card__desc">{fest.desc}</p>
                      <Link to={`/festivals/${fest.code || fest.id}`} className="festival-btn-explore">
                        Khám phá ngay
                      </Link>
                    </div>
                  </article>
                );
              }

              return (
                <article className="festival-regular-card fade-up" style={{ animationDelay: `${(index % 3) * 0.1}s` }} key={fest.id}>
                  <div className="festival-regular-card__img-wrapper">
                    <img src={getImageUrl(fest.image)} alt={fest.title} loading="lazy" />
                    <span className="festival-regular-card__tag">{fest.tag}</span>
                  </div>
                  <div className="festival-regular-card__content">
                    <h3 className="festival-regular-card__title">{fest.title}</h3>
                    <p className="festival-regular-card__en-title">{fest.enTitle}</p>
                    <div className="festival-meta-group">
                      <div className="festival-meta-item">{fest.location}</div>
                      <div className="festival-meta-item">{fest.date}</div>
                    </div>
                    <p className="festival-regular-card__desc">{fest.desc}</p>
                    <Link to={`/festivals/${fest.code || fest.id}`} className="festival-btn-discover">
                      Xem câu chuyện lễ hội
                    </Link>
                  </div>
                </article>
              );
            })}
          </div>

          <div className="festivals-all__actions">
            <button className="festivals-btn festivals-btn--primary">Tổng số: {filteredFestivals.length} lễ hội</button>
          </div>
        </section>

        <section className="festivals-timeline">
          <div className="festivals-timeline__header fade-up">
            <div className="festivals-timeline__tag">{page.timeline?.badge || "Lễ hội quanh năm"}</div>
            <h2 className="festivals-timeline__title">{page.timeline?.title || "Dòng thời gian lễ hội"}</h2>
            <p className="festivals-timeline__subtitle">{page.timeline?.subtitle || "Khám phá nhịp điệu văn hóa Việt Nam qua từng mùa trong năm"}</p>
            <div className="festivals-timeline__scroll-hint">{page.timeline?.hint || "Cuộn ngang để xem thêm →"}</div>
          </div>

          <div className="festivals-timeline__track-container fade-up">
            <div className="festivals-timeline__track">
              <div className="festivals-timeline__line"></div>
              {timeline.map((item, index) => (
                <div className="timeline-item" key={item.id || index} style={{ animationDelay: `${index * 0.1}s` }}>
                  <div className="timeline-item__top-dot" style={{ backgroundColor: item.color, boxShadow: `0 0 10px ${item.color}` }}></div>
                  <div className="timeline-item__circle" style={{ border: `2px solid ${item.color}`, boxShadow: `0 0 30px ${item.color}40, inset 0 0 20px ${item.color}20` }}>
                    <span>{item.month}</span>
                  </div>
                  <div className="timeline-card">
                    <h3 className="timeline-card__title">{item.title}</h3>
                    <img src={getImageUrl(item.image || item.imageUrl)} alt={item.title} className="timeline-card__image" />
                    <div className="timeline-card__season">
                      <span className="timeline-card__season-dot" style={{ backgroundColor: item.color }}></span>
                      {item.season}
                    </div>
                    <div className="timeline-card__bottom-line" style={{ background: `linear-gradient(90deg, transparent, ${item.color}, transparent)` }}></div>
                  </div>
                </div>
              ))}
            </div>
          </div>
        </section>

        <section className="festivals-gallery">
          <div className="festivals-gallery__header fade-up">
            <div className="festivals-gallery__tag">{page.gallery?.badge || "Hành trình thị giác"}</div>
            <h2 className="festivals-gallery__title">{page.gallery?.title || "Khoảnh khắc lễ hội"}</h2>
            <p className="festivals-gallery__subtitle">{page.gallery?.subtitle || "Đắm mình trong bầu không khí và cảm xúc của những mùa lễ hội Việt Nam"}</p>
          </div>

          <div className="festivals-gallery__grid fade-up">
            {galleryImages.slice(0, 10).map((image, index) => (
              <img
                key={`${image.imageUrl}-${index}`}
                src={getImageUrl(image.imageUrl)}
                alt={image.alt || `Khoảnh khắc lễ hội ${index + 1}`}
                className={`gallery-${Math.floor(index / 3) + 1}-${(index % 3) + 1}`}
              />
            ))}
          </div>
        </section>

        <section className="festivals-quote" style={{ backgroundImage: `url(${getImageUrl(page.quote?.backgroundImageUrl)})` }}>
          <div className="festivals-quote__overlay"></div>
          <div className="festivals-quote__content fade-up">
            <div className="festivals-quote__decoration">
              <span className="quote-mark">“</span>
            </div>
            <h2 className="festivals-quote__title">{page.quote?.title || "Uống nước nhớ nguồn"}</h2>
            <p className="festivals-quote__subtitle">{page.quote?.subtitle || "Nhớ về cội nguồn để gìn giữ giá trị văn hóa"}</p>
            <div className="festivals-quote__divider"></div>
            <p className="festivals-quote__desc">{page.quote?.desc || "Tinh thần biết ơn cội nguồn chính là nền tảng để các lễ hội Việt Nam tiếp tục sống động trong đời sống hôm nay."}</p>
            <Link to="/articles" className="festivals-btn festivals-btn--primary festivals-quote__btn">
              {page.quote?.button || "Khám phá văn hóa"}
            </Link>
          </div>
          <div className="festivals-quote__particles"></div>
        </section>

        <button className="festivals-scroll-top" onClick={() => window.scrollTo({ top: 0, behavior: "smooth" })} aria-label="Cuộn lên đầu trang">
          <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.5" strokeLinecap="round" strokeLinejoin="round">
            <path d="m18 15-6-6-6 6" />
          </svg>
        </button>
      </main>

      <Footer />
    </>
  );
}

import React from "react";
import { Link } from "react-router-dom";
import { getImageUrl } from "../FestivalsPage.constants";

const FestivalGridSection = ({
  page,
  featuredFestivals,
  paginatedFestivals,
  totalPages,
  safeCurrentPage,
  goToPage,
  canGoPrev,
  canGoNext
}) => {
  return (
    <>
      <section className="festivals-major" id="explore">
        <div className="festivals-major__container">
          <div className="festivals-major__header fade-up">
            <div className="festivals-major__badge">{page.major?.badge || "Lễ hội nổi bật"}</div>
            <h2 className="festivals-major__title">{page.major?.title || "Lễ hội tiêu biểu"}</h2>
            <p className="festivals-major__subtitle">{page.major?.subtitle || "Khám phá những lễ hội nổi bật và có sức lan tỏa mạnh mẽ trong văn hóa Việt Nam"}</p>
          </div>

          <div className="festivals-major__grid">
            {featuredFestivals.map((fest, index) => (
              <Link to={`/festivals/${fest.code || fest.id}`} className="festivals-card fade-up" style={{ animationDelay: `${index * 0.1}s` }} key={fest.id}>
                <div className="festivals-card__img">
                  <img src={getImageUrl(fest.image)} alt={fest.title} loading="lazy" />
                  <span className="festivals-card__tag">{fest.tag}</span>
                  <div className="festivals-card__explore-overlay">
                    <span>Khám phá ngay</span>
                  </div>
                </div>
                <div className="festivals-card__body">
                  <div className="festivals-card__times">{fest.date}</div>
                  <div className="festival-card__content">
                    <h3 className="festivals-card__title">{fest.title}</h3>
                    <span className="festivals-card__en-title">{fest.enTitle && fest.enTitle !== fest.title ? fest.enTitle : ''}</span>
                    <p className="festivals-card__desc">{fest.desc}</p>
                    <div className="festivals-card__meta">
                      <div className="festivals-card__meta-item">{fest.location}</div>
                      <div className="festivals-card__meta-item">{fest.tag}</div>
                    </div>
                  </div>
                </div>
              </Link>
            ))}
          </div>
        </div>
      </section>

      <section className="festivals-all" id="all-celebrations">
        <div className="festivals-all__header fade-up">
          <h2 className="festivals-all__title">{page.all?.title || "Khám phá các lễ hội Việt Nam"}</h2>
          <p className="festivals-all__subtitle">{page.all?.subtitle || "Mở từng trang để xem nội dung lễ hội tương ứng được tải động từ hệ thống"}</p>
        </div>

        <div className="festivals-all__grid">
          {paginatedFestivals.map((fest, index) => {
            if (index === 0 && safeCurrentPage === 1) {
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
                    <p className="festival-featured-card__en-title">{fest.enTitle && fest.enTitle !== fest.title ? fest.enTitle : ''}</p>
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
                  <p className="festival-regular-card__en-title">{fest.enTitle && fest.enTitle !== fest.title ? fest.enTitle : ''}</p>
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

        {totalPages > 1 && (
          <div className="festivals-all__actions" style={{ display: "flex", justifyContent: "center", alignItems: "center", gap: "14px", marginTop: "40px" }}>
            <button
              className="festivals-btn festivals-btn--primary"
              onClick={() => goToPage(safeCurrentPage - 1)}
              disabled={!canGoPrev}
              style={{
                width: "52px",
                height: "52px",
                borderRadius: "999px",
                padding: 0,
                display: "inline-flex",
                alignItems: "center",
                justifyContent: "center",
                opacity: canGoPrev ? 1 : 0.5,
              }}
            >
              ‹
            </button>

            {Array.from({ length: totalPages }, (_, index) => index + 1).map((pageNumber) => {
              // Simple pagination logic: show current, prev, next, first, last if many pages
              if (totalPages > 7) {
                 if (pageNumber !== 1 && pageNumber !== totalPages && Math.abs(pageNumber - safeCurrentPage) > 2) {
                   if (Math.abs(pageNumber - safeCurrentPage) === 3) return <span key={pageNumber}>...</span>;
                   return null;
                 }
              }
              
              return (
                <button
                  key={pageNumber}
                  className="festivals-btn festivals-btn--primary"
                  onClick={() => goToPage(pageNumber)}
                  style={{
                    width: "52px",
                    height: "52px",
                    borderRadius: "999px",
                    padding: 0,
                    display: "inline-flex",
                    alignItems: "center",
                    justifyContent: "center",
                    background: safeCurrentPage === pageNumber ? undefined : "transparent",
                    color: safeCurrentPage === pageNumber ? undefined : "#4a3020",
                    border: safeCurrentPage === pageNumber ? undefined : "2px solid rgba(122, 75, 47, 0.2)",
                    boxShadow: safeCurrentPage === pageNumber ? undefined : "none",
                  }}
                >
                  {pageNumber}
                </button>
              );
            })}

            <button
              className="festivals-btn festivals-btn--primary"
              onClick={() => goToPage(safeCurrentPage + 1)}
              disabled={!canGoNext}
              style={{
                width: "52px",
                height: "52px",
                borderRadius: "999px",
                padding: 0,
                display: "inline-flex",
                alignItems: "center",
                justifyContent: "center",
                opacity: canGoNext ? 1 : 0.5,
              }}
            >
              ›
            </button>
          </div>
        )}
      </section>
    </>
  );
};

export default FestivalGridSection;

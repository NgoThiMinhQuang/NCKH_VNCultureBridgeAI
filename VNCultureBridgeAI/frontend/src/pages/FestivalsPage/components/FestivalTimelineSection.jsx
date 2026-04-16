import React from "react";
import { getImageUrl } from "../FestivalsPage.constants";

const FestivalTimelineSection = ({ page, timeline }) => {
  const section = page.timeline || {};
  
  return (
    <section className="festivals-timeline">
      <div className="festivals-timeline__header fade-up">
        <div className="festivals-timeline__tag">{section.badge || "Lễ hội quanh năm"}</div>
        <h2 className="festivals-timeline__title">{section.title || "Dòng thời gian lễ hội"}</h2>
        <p className="festivals-timeline__subtitle">{section.subtitle || "Khám phá nhịp điệu văn hóa Việt Nam qua từng mùa trong năm"}</p>
        <div className="festivals-timeline__scroll-hint">{section.hint || "Cuộn ngang để xem thêm →"}</div>
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
  );
};

export default FestivalTimelineSection;

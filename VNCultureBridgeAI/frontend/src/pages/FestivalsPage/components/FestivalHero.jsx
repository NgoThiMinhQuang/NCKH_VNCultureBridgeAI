import React from "react";
import { getImageUrl } from "../FestivalsPage.constants";

const FestivalHero = ({ page, fanCards }) => {
  const hero = page.hero || {};
  
  return (
    <section className="festivals-hero">
      <div className="festivals-hero__content">
        <div className="festivals-hero__badge">{hero.badge || "Di sản văn hóa"}</div>
        <h1 className="festivals-hero__title">{hero.title}</h1>
        <p className="festivals-hero__subtitle">{hero.subtitle}</p>
        <div className="festivals-hero__actions">
          <button className="festivals-btn festivals-btn--primary" onClick={() => document.getElementById('explore')?.scrollIntoView({ behavior: 'smooth' })}>
            Khám phá ngay
          </button>
          <button className="festivals-btn festivals-btn--outline">
            Xem video giới thiệu
          </button>
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
      
      <div className="festivals-hero__scroll">
        <div className="festivals-mouse-icon"></div>
      </div>
    </section>
  );
};

export default FestivalHero;

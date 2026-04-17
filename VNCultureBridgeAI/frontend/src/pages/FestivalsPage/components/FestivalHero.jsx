import React from "react";
import { getImageUrl } from "../FestivalsPage.constants";
import SectionWave from "../../../components/common/SectionWave/SectionWave";
import imgHeroBg from "../../../assets/images/trong-dong-bg.png";
import { useLanguage } from "../../../context/LanguageContext";
import { ui } from "../../../i18n/messages";

const FestivalHero = ({ page, fanCards, lang = "vi" }) => {
  const { lang: currentLang } = useLanguage();
  const copy = ui[currentLang];
  
  const hero = page.hero || {};
  const stats = page.stats || [];

  const scrollToExplore = () => {
    document.getElementById('explore')?.scrollIntoView({ behavior: 'smooth' });
  };

  return (
    <section className="festivals-hero">
      {/* Background image */}
      <div className="festivals-hero__bg">
        <img src={imgHeroBg} alt="Vietnamese Cultural Festivals" />
        <div className="festivals-hero__overlay"></div>
      </div>

      {/* Ornamental corners */}
      <div className="festivals-hero__ornament festivals-hero__ornament--tl"></div>
      <div className="festivals-hero__ornament festivals-hero__ornament--br"></div>

      {/* Hero Inner Split Layout */}
      <div className="festivals-hero__inner">

        {/* LEFT: Text & Content */}
        <div className="festivals-hero__left">
          <div className="festivals-hero__badge">
            <span className="festivals-hero__badge-dot"></span>
            {hero.badge}
          </div>

          <h1 className="festivals-hero__title">
            <span className="festivals-hero__title-line">{hero.titleLine}</span>
            <span className="festivals-hero__title-accent">{hero.titleAccent}</span>
            <span className="festivals-hero__title-line">{hero.titleLine2}</span>
          </h1>

          {/* Ornamental divider */}
          <div className="festivals-hero__divider-row">
            <span className="festivals-hero__divider-line"></span>
            <span className="festivals-hero__divider-diamond">◆</span>
            <span className="festivals-hero__divider-line"></span>
          </div>

          <p className="festivals-hero__subtitle">
            {hero.subtitle}
          </p>

          {/* Stats section */}
          <div className="festivals-hero__stats">
            <div className="festivals-hero__stat">
              <strong>{stats[0]?.value || "8,000+"}</strong>
              <span>{stats[0]?.label}</span>
            </div>
            <div className="festivals-hero__stat-sep">|</div>
            <div className="festivals-hero__stat">
              <strong>{stats[1]?.value || "54"}</strong>
              <span>{stats[1]?.label}</span>
            </div>
            <div className="festivals-hero__stat-sep">|</div>
            <div className="festivals-hero__stat">
              <strong>{stats[2]?.value || "3"}</strong>
              <span>{stats[2]?.label}</span>
            </div>
          </div>

          <div className="festivals-hero__actions">
            <button className="festivals-hero__btn festivals-hero__btn--primary" onClick={scrollToExplore}>
              {copy.festivals?.exploreNow || "Khám phá ngay"}
              <span className="btn-icon">→</span>
            </button>
            <button className="festivals-hero__btn festivals-hero__btn--secondary" onClick={() => window.open('https://www.youtube.com/results?search_query=le+hoi+viet+nam', '_blank')}>
              <span className="btn-icon">🎥</span>
              {copy.festivals?.watchDocumentaries || "Xem phim tư liệu"}
            </button>
          </div>
        </div>

        {/* RIGHT: Fan Card Stack */}
        <div className="festivals-hero__right">
          <div className="festivals-fan">
            {fanCards.slice(0, 5).map((card, idx) => {
              const positions = ['fl', 'fr', 'l', 'r', 'c'];
              const posClass = positions[idx];
              return (
                <div key={card.id || idx} className={`festivals-fan__card festivals-fan__card--${posClass}`}>
                  <img src={getImageUrl(card.image)} alt={card.title} />
                  <div className="festivals-fan__card-label">
                    <span className="festivals-fan__card-dot"></span>
                    {card.title}
                  </div>
                </div>
              );
            })}

            {/* Floating badge */}
            <div className="festivals-fan__badge">
              <span>🎏</span>
              <span>{stats[0]?.value || "8.000+"} {stats[0]?.label}</span>
            </div>
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

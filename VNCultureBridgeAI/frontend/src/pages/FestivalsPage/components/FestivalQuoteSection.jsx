import React from "react";
import { Link } from "react-router-dom";
import { getImageUrl } from "../FestivalsPage.constants";

const FestivalQuoteSection = ({ page }) => {
  const section = page.quote || {};
  
  return (
    <section 
      className="festivals-quote" 
      style={{ backgroundImage: `url(${getImageUrl(section.backgroundImageUrl || "https://images.unsplash.com/photo-1542332213-31f87348057f?auto=format&fit=crop&w=1200&q=80")})` }}
    >
      <div className="festivals-quote__overlay"></div>
      <div className="festivals-quote__content fade-up">
        <div className="festivals-quote__decoration">
          <span className="quote-mark">“</span>
        </div>
        <h2 className="festivals-quote__title">{section.title || "Uống nước nhớ nguồn"}</h2>
        <p className="festivals-quote__subtitle">{section.subtitle || "Nhớ về cội nguồn để gìn giữ giá trị văn hóa"}</p>
        <div className="festivals-quote__divider"></div>
        <p className="festivals-quote__desc">{section.desc || "Tinh thần biết ơn cội nguồn chính là nền tảng để các lễ hội Việt Nam tiếp tục sống động trong đời sống hôm nay."}</p>
        <Link to="/blog" className="festivals-btn festivals-btn--primary festivals-quote__btn">
          {section.button || "Khám phá văn hóa"}
        </Link>
      </div>
      <div className="festivals-quote__particles"></div>
    </section>
  );
};

export default FestivalQuoteSection;

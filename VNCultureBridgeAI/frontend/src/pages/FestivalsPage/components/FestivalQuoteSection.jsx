import React from "react";
import { Link } from "react-router-dom";
import { getImageUrl } from "../FestivalsPage.constants";
import { useLanguage } from "../../../context/LanguageContext";
import { ui } from "../../../i18n/messages";

const FestivalQuoteSection = ({ page }) => {
  const { lang } = useLanguage();
  const copy = ui[lang];
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
        <h2 className="festivals-quote__title">{section.title || (lang === 'vi' ? "Uống nước nhớ nguồn" : "Remember the Source")}</h2>
        <p className="festivals-quote__subtitle">{section.subtitle || (lang === 'vi' ? "Nhớ về cội nguồn để gìn giữ giá trị văn hóa" : "Remember the source to preserve cultural values")}</p>
        <div className="festivals-quote__divider"></div>
        <p className="festivals-quote__desc">{section.desc || (lang === 'vi' ? "Tinh thần biết ơn cội nguồn chính là nền tảng để các lễ hội Việt Nam tiếp tục sống động trong đời sống hôm nay." : "The spirit of gratitude to the roots is the foundation for Vietnamese festivals to continue being vibrant in today's life.")}</p>
        <Link to="/blog" className="festivals-btn festivals-btn--primary festivals-quote__btn">
          {section.button || (lang === 'vi' ? "Khám phá văn hóa" : "Explore Culture")}
        </Link>
      </div>
      <div className="festivals-quote__particles"></div>
    </section>
  );
};

export default FestivalQuoteSection;

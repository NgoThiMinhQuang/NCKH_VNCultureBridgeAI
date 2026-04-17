import React from "react";
import { Link } from "react-router-dom";
import { getImageUrl } from "../FestivalsPage.constants";
import { useLanguage } from "../../../context/LanguageContext";
import { ui } from "../../../i18n/messages";

const FestivalMeaningSection = ({ page, galleryImages, filteredFestivals }) => {
  const { lang } = useLanguage();
  const copy = ui[lang];
  const meaning = page.meaning || {};
  const fallbackAlt = lang === 'vi' ? "Khoảnh khắc lễ hội" : "Festival moments";
  
  return (
    <section className="festivals-meaning">
      <div className="festivals-meaning__container">
        <div className="festivals-meaning__gallery">
          <div className="gallery-col">
            <img src={getImageUrl(galleryImages[0]?.imageUrl || filteredFestivals[0]?.image)} alt={galleryImages[0]?.alt || filteredFestivals[0]?.title || fallbackAlt} className="img-tall fade-up" />
            <img src={getImageUrl(galleryImages[1]?.imageUrl || filteredFestivals[1]?.image)} alt={galleryImages[1]?.alt || filteredFestivals[1]?.title || fallbackAlt} className="img-square fade-up" style={{ animationDelay: "0.1s" }} />
            <img src={getImageUrl(galleryImages[2]?.imageUrl || filteredFestivals[2]?.image)} alt={galleryImages[2]?.alt || filteredFestivals[2]?.title || fallbackAlt} className="img-square fade-up" style={{ animationDelay: "0.2s" }} />
          </div>
          <div className="gallery-col gallery-col--offset">
            <img src={getImageUrl(galleryImages[3]?.imageUrl || filteredFestivals[3]?.image)} alt={galleryImages[3]?.alt || filteredFestivals[3]?.title || fallbackAlt} className="img-square fade-up" style={{ animationDelay: "0.3s" }} />
            <img src={getImageUrl(galleryImages[4]?.imageUrl || filteredFestivals[4]?.image)} alt={galleryImages[4]?.alt || filteredFestivals[4]?.title || fallbackAlt} className="img-square fade-up" style={{ animationDelay: "0.4s" }} />
            <img src={getImageUrl(galleryImages[5]?.imageUrl || filteredFestivals[5]?.image)} alt={galleryImages[5]?.alt || filteredFestivals[5]?.title || fallbackAlt} className="img-landscape fade-up" style={{ animationDelay: "0.5s" }} />
          </div>
        </div>

        <div className="festivals-meaning__content fade-up">
          <div className="festivals-meaning__tag">{meaning.badge || (lang === 'vi' ? "Ý nghĩa văn hóa" : "Cultural Meaning")}</div>
          <h2 className="festivals-meaning__title">{meaning.title || (lang === 'vi' ? "Linh hồn của lễ hội Việt" : "The Soul of Vietnamese Festivals")}</h2>
          <div className="festivals-meaning__desc">
            {(meaning.paragraphs || (lang === 'vi' ? [
              "Lễ hội Việt Nam không chỉ là những ngày vui mà còn là nơi kết nối con người với cội nguồn, vùng đất và ký ức cộng đồng.",
              "Mỗi nghi thức, biểu tượng và hoạt động trong lễ hội đều phản ánh chiều sâu văn hóa, niềm tin và tinh thần gắn kết của người Việt.",
              "Khi tham gia lễ hội, chúng ta không chỉ quan sát mà còn trực tiếp cảm nhận nhịp sống văn hóa đang tiếp tục được lưu truyền qua nhiều thế hệ.",
            ] : [
              "Vietnamese festivals are not just joyful days but also places connecting people with their roots, the land, and community memory.",
              "Each ritual, symbol, and activity in the festival reflects the depth of culture, belief, and the cohesive spirit of the Vietnamese people.",
              "When participating in a festival, we do not only observe but also directly feel the rhythm of cultural life being passed down through generations.",
            ])).map((paragraph, index) => (
              <p key={index}>{paragraph}</p>
            ))}
          </div>
          <Link to={meaning.buttonHref || "/blog"} className="festivals-btn festivals-btn--primary festivals-meaning__btn">
            {meaning.button || (lang === 'vi' ? "Tìm hiểu thêm về văn hóa Việt" : "Learn more about Vietnamese culture")}
          </Link>
        </div>
      </div>
    </section>
  );
};

export default FestivalMeaningSection;

import React from "react";
import { getImageUrl } from "../FestivalsPage.constants";

const FestivalGallerySection = ({ page, galleryImages }) => {
  const section = page.gallery || {};
  
  return (
    <section className="festivals-gallery">
      <div className="festivals-gallery__header fade-up">
        <div className="festivals-gallery__tag">{section.badge || "Hành trình thị giác"}</div>
        <h2 className="festivals-gallery__title">{section.title || "Khoảnh khắc lễ hội"}</h2>
        <p className="festivals-gallery__subtitle">{section.subtitle || "Đắm mình trong bầu không khí và cảm xúc của những mùa lễ hội Việt Nam"}</p>
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
  );
};

export default FestivalGallerySection;

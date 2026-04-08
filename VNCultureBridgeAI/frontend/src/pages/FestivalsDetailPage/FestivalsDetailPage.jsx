import React, { useState } from 'react';
import PageHeader from "../../components/layout/PageHeader/PageHeader";
import Footer from "../../components/layout/Footer/Footer";
import { Link, useParams } from 'react-router-dom';
import bannerImg from '../../assets/festival_banner.jpg';
import banner1Img from '../../assets/banner1.jpg';
import banner2Img from '../../assets/banner2.jpg';
import banner3Img from '../../assets/banner3.jpg';
import anhtet1 from '../../assets/anhtet1.PNG';
import giotohungvuong from "../../assets/giotohungvuong1.PNG";
import "./FestivalsDetailPage.css";
import "../../App.css";

// MOCK DATA: You can move this to a separate file, or fetch from an API later.
const FESTIVALS_DB = {
  "1": {
    id: "1",
    tag: "Major Festival",
    title: "Tết Nguyên Đán",
    enTitle: "Vietnamese Lunar New Year",
    heroDesc: "The most important celebration in Vietnamese culture, honoring family, ancestors, and new beginnings.",
    heroImage: banner1Img,
    whatIsItContext: [
      "Tết Nguyên Đán, commonly known simply as Tết, marks the arrival of spring based on the Vietnamese calendar. It is a time for family reunions, paying respect to ancestors, and hoping for a better upcoming year.",
      "During Tết, Vietnamese people return to their hometowns, clean their homes to get rid of bad luck, and prepare special holiday foods. The streets are filled with blooming peach blossoms (in the North) and yellow apricot blossoms (in the South)."
    ],
    infoImage: anhtet1,
    quickFacts: {
      date: "Late January or Early February",
      location: "Nationwide",
      participants: "Everyone"
    },
    whyItMattersCards: [
      { icon: "👥", colorClass: "highlight-red", title: "Family Reunion", desc: "Tết is when families come together no matter how far apart they live. It's a sacred time for reunions, strengthening bonds across generations and creating memories that last a lifetime." },
      { icon: "🔥", colorClass: "highlight-orange", title: "Ancestor Worship", desc: "Vietnamese people honor their ancestors through special ceremonies and offerings. This maintains spiritual connections with those who came before and teaches younger generations about respect and gratitude." },
      { icon: "💖", colorClass: "highlight-yellow", title: "Cultural Identity", desc: "Tết embodies Vietnamese values of respect, gratitude, hope, and renewal. It's a celebration of who Vietnamese people are as a culture and a way to preserve traditions for future generations." }
    ],
    whyItMatterConclusionHTML: "<strong>The festival typically lasts three days officially</strong>, but preparations begin weeks in advance, and celebrations can continue for up to a week or more. During this time, the values of family, tradition, and community take center stage in Vietnamese life.",
    inspiringQuote: "Tết is the heartbeat of Vietnamese culture — the moment when the entire nation pauses to celebrate family, honor the past, and welcome new beginnings with hope",
    howItIsCelebrated: [
      {
        phase: "Early Preparation",
        title: "Kitchen Gods Ceremony (23rd of Lunar December)",
        desc: [
          "Before Tết officially begins, Vietnamese families perform the Kitchen Gods Ceremony on the 23rd day of the last lunar month.",
          "According to tradition, the Kitchen Gods return to heaven to report the family's activities over the past year.",
          "Families prepare offerings such as food, fruits, and paper items, and release carp fish as a symbolic vehicle for the gods' journey.",
          "This ritual marks the spiritual beginning of Tết and reflects the deep connection between daily life and ancestral beliefs in Vietnamese culture."
        ],
        image: anhtet1,
        align: "left"
      },
      {
        phase: "Before Tết",
        title: "Preparation & Cleaning",
        desc: [
          "Families thoroughly clean their homes to sweep away bad luck from the old year. This cleaning ritual is believed to make room for good fortune in the coming year.",
          "People shop for new clothes, buy flowers (peach blossoms in the North, apricot blossoms in the South), and prepare special foods. Markets become incredibly busy with people buying kumquat trees and traditional treats.",
          "Families also prepare offerings for ancestors and decorate their homes with red banners featuring calligraphy wishes for prosperity, health, and happiness."
        ],
        image: banner3Img,
        align: "right"
      },
      {
        phase: "During Tết",
        title: "Family Gathering & New Year's Eve",
        desc: [
          "The most important moment of Tết arrives on New Year's Eve. Families gather for a reunion dinner featuring traditional dishes, sharing stories and laughter.",
          "At midnight, people set up altar offerings for ancestors, including food, drinks, and incense. This ceremony honors those who came before and invites their blessings for the new year.",
          "The first moments of the new year are considered especially significant for setting the tone for the entire year ahead. Families stay together, watch fireworks, and exchange wishes for good fortune."
        ],
        image: bannerImg,
        align: "left"
      },
      {
        phase: "First Days of Tết",
        title: "Visiting & Celebrating",
        desc: [
          "People visit relatives, friends, and temples to give New Year greetings. The first visitor to a home (called 'xông đất') is very important, as they're believed to influence the household's luck for the entire year.",
          "Children and unmarried adults receive lucky money in red envelopes from elders. Streets are filled with people in new clothes, dragon dances, lion dances, and festive atmosphere.",
          "Traditional games and activities bring communities together. People avoid negative words or actions, focusing on positivity and good wishes to ensure a fortunate year ahead."
        ],
        image: banner2Img,
        align: "right"
      }
    ],
    whatTetFeelsLike: {
      leftText: [
        "The Streets: Bustling with motorcycles carrying giant peach blossom branches. Local markets bursting with bright reds, pinks, and yellows. The crisp scent of incense lingering in the air, mixed with roasted seeds and candied fruits.",
        "The Nights: Fireworks light up the sky over major cities, while rural areas glow with the warm light of outdoor fires used to boil Bánh Chưng. Temples hum with the sounds of chanting and bells ringing.",
        "The Sounds: Cheerful greetings of \"Chúc Mừng Năm Mới\" everywhere. The loud, rhythmic drumming of dragon and lion dances echoing down the streets. Traditional music plays joyfully from homes."
      ],
      rightText: [
        "The Homes: Spotlessly clean and meticulously decorated. Vibrant flowers in every corner. Bright red parallel sentences hanging by the door. A beautifully arranged \"mâm ngũ quả\" (five-fruit tray) sits proudly on the ancestral altar.",
        "The Atmosphere: Days of intense, chaotic rush giving way to sudden, profound stillness on the first day of the year. Empty streets briefly reclaimed by calm before family gatherings bring the noise back.",
        "The Feelings: A mix of nostalgia for the past and hope for the future. The warmth of being among loved ones. The deep sense of cultural belonging and renewal."
      ],
      image: bannerImg
    },
    keyTraditionsDocs: [
      { image: banner2Img, title: "Hoa Đào (Peach Blossoms)", desc: "A symbol of bravery, good luck, and spring in the North. Families display large branches to invite positive energy and prosperity." },
      { image: banner1Img, title: "Lì Xì (Lucky Money)", desc: "Elders give children and unmarried youths money in red envelopes, wishing them health, luck, and success." },
      { image: banner3Img, title: "Bánh Chưng", desc: "A savory square cake made of glutinous rice, mung bean, and fatty pork. It represents the Earth and gratitude to ancestors." },
      { image: anhtet1, title: "Mâm Ngũ Quả (Five-Fruit Tray)", desc: "Displayed on every family altar, representing the five basic elements (metal, wood, water, fire, earth) and the wish for prosperity." },
      { image: banner1Img, title: "Xông Đất (First Caller)", desc: "The first person to enter a home after midnight dictates the family's luck for the year. This person is carefully chosen based on zodiac sign compatibility." },
      { image: banner3Img, title: "Chơi Chữ (Calligraphy)", desc: "People ask scholars for meaningful Han-Nom characters written in beautiful calligraphy to hang at home for blessings." }
    ],
    traditionalFoods: [
      { image: banner3Img, title: "Bánh Chưng", desc: "Savory square sticky rice cakes representing the Earth." },
      { image: banner2Img, title: "Thịt Kho Hột Vịt", desc: "Caramelized braised pork belly and eggs symbolizing harmony." },
      { image: anhtet1, title: "Giò Chả", desc: "Vietnamese pork sausage wrapped in banana leaves." },
      { image: banner1Img, title: "Dưa Hành", desc: "Pickled onions to balance the rich fatty flavors." },
      { image: bannerImg, title: "Mứt Tết", desc: "Candied fruits and roasted seeds offered to guests." },
      { image: banner3Img, title: "Gà Luộc", desc: "Whole boiled chicken acting as a pure offering to ancestors." }
    ],
    regionalFoods: {
      north: [
        { image: banner2Img, title: "Xôi Gấc", desc: "Sweet red sticky rice representing luck and joy." },
        { image: banner1Img, title: "Nem Rán", desc: "Crispy fried spring rolls filled with pork and mushrooms." },
        { image: anhtet1, title: "Canh Măng", desc: "A slow-cooked bamboo shoot soup with tender pork ribs." }
      ],
      central: [
        { image: banner3Img, title: "Bánh Tét", desc: "Cylindrical sticky rice cakes wrapped in banana leaves." },
        { image: banner2Img, title: "Chả Bò", desc: "A delicious, slightly spicy premium beef sausage." },
        { image: bannerImg, title: "Bánh Tổ", desc: "Sweet, sticky brown sugar cake offered to ancestors." }
      ],
      south: [
        { image: anhtet1, title: "Khổ Qua Nhồi Thịt", desc: "Stuffed bitter melon soup, hoping hardships will pass." },
        { image: banner3Img, title: "Lạp Xưởng", desc: "Chewy, sweet and savory Chinese-style sausages." },
        { image: banner1Img, title: "Tôm Khô Củ Kiệu", desc: "Sun-dried shrimp served with sweet pickled leeks." }
      ]
    },
    culturalMeaningsDocs: [
      { icon: "✨", title: "A New Start", desc: "Tết is a collective reset button. All debts are paid off, arguments are forgiven, and houses are cleaned. Everyone steps into the new year with a fresh slate.", colorClass: "highlight-red" },
      { icon: "👨‍👩‍👧‍👦", title: "Family Above All", desc: "No matter where they are, Vietnamese people try to return home for Tết. It reinforces the importance of family bonds and filial piety in society.", colorClass: "highlight-orange" },
      { icon: "🙏", title: "Honoring Ancestors", desc: "Tết is deeply spiritual. The presence of ancestors is strongly felt, and ceremonies are held to invite them back to celebrate with the living.", colorClass: "highlight-yellow" },
      { icon: "🌱", title: "Harmony with Nature", desc: "Occurring between winter and spring, Tết celebrates the renewal of Earth. Traditions heavily involve flowers, trees, and earth-based offerings.", colorClass: "highlight-red" }
    ],
    interestingFactsDocs: [
      { icon: "🧧", title: "Red Everywhere", desc: "Red is the dominant color of Tết, representing luck, joy, and prosperity. You'll see red envelopes, red clothes, and red decorations everywhere." },
      { icon: "🚫", title: "Taboos & Superstitions", desc: "People avoid sweeping the floor on the first day so they don't 'sweep away' their luck. Negative words and breaking glass are also avoided." },
      { icon: "🐉", title: "Zodiac Animals", desc: "Each Lunar Year is associated with a zodiac animal in a 12-year cycle, which influences the predictions and themes of the year." },
      { icon: "🍜", title: "Dietary Restrictions", desc: "Many people choose to eat vegetarian food on the exact morning of the new year out of respect for all living beings." },
      { icon: "🌸", title: "National Vacation", desc: "It is the longest public holiday in Vietnam. Most businesses, schools, and offices close down entirely for at least one full week." },
      { icon: "🎭", title: "Festive Games", desc: "Tết features numerous traditional folk games like wrestling, tug-of-war, human chess, and cockfighting in rural areas." }
    ],
    galleryHero: bannerImg,
    galleryGrid: [banner2Img, banner3Img, anhtet1, banner1Img, banner2Img, banner3Img],
    inShortText: "Tết is the definitive essence of Vietnamese culture—a time for family reunion, honoring ancestors, and welcoming new beginnings with joy and gratitude. To truly know Vietnam, one must experience the magic of Tết.",
    discoverMore: [
      {
        image: banner3Img,
        title: "Tet Traditional Foods",
        desc: "Discover the rich flavors of Bánh Chưng, Mứt Tết, and the deep cultural significance behind every holiday dish."
      },
      {
        image: anhtet1,
        title: "Tet Customs",
        desc: "Learn about the vibrant traditions of giving lucky money (Lì xì), spring cleaning, and the first footstep (Xông đất)."
      },
      {
        image: bannerImg,
        title: "Family & Ancestor Worship",
        desc: "Understand the spiritual core of Tết, from setting up the ancestral altar to the profound joy of family reunions."
      }
    ]
  }
}

export default function FestivalsDetailPage() {
  const [lang, setLang] = useState('vi');
  const [showMoreFood, setShowMoreFood] = useState(false);
  const { id } = useParams();

  // Find festival by ID from params. If not found or no ID is provided, default to ID 1 (Tết)
  const festivalData = FESTIVALS_DB[id] || FESTIVALS_DB["1"];

  // If we couldn't find ANY data at all
  if (!festivalData) {
    return <div>Festival not found!</div>;
  }

  return (
    <div className="festival-detail-page">
      {/* Header */}
      <PageHeader
        lang={lang}
        onLangChange={setLang}
      />

      <main>
        {/* 1. HERO SECTION */}
        <section className="festival-hero" style={{ backgroundImage: `url(${festivalData.heroImage})` }}>
          <div className="hero-overlay"></div>
          <div className="hero-content">
            <span className="hero-tag">{festivalData.tag}</span>
            <h1 className="hero-title">{festivalData.title}</h1>
            <h2 className="hero-subtitle">{festivalData.enTitle}</h2>
            <p className="hero-desc">{festivalData.heroDesc}</p>
          </div>
        </section>

        <div className="festival-container">

          {/* 2. QUICK FACTS / WHAT IS IT */}
          <section className="festival-section what-is-it">
            <div className="text-content">
              <h2 className="section-title">What is {festivalData.title.split(' ')[0]}?</h2>
              {festivalData.whatIsItContext.map((para, index) => (
                <p key={index}>{para}</p>
              ))}

              <div className="info-badges">
                <div className="badge">
                  <span className="badge-icon">🗓️</span>
                  <div>
                    <span className="badge-label">Date</span>
                    <span className="badge-value">{festivalData.quickFacts.date}</span>
                  </div>
                </div>
                <div className="badge">
                  <span className="badge-icon">📍</span>
                  <div>
                    <span className="badge-label">Location</span>
                    <span className="badge-value">{festivalData.quickFacts.location}</span>
                  </div>
                </div>
                <div className="badge">
                  <span className="badge-icon">👥</span>
                  <div>
                    <span className="badge-label">Participants</span>
                    <span className="badge-value">{festivalData.quickFacts.participants}</span>
                  </div>
                </div>
              </div>
            </div>
            <div className="image-content">
              <img src={festivalData.infoImage} alt={`${festivalData.title} Celebration`} />
            </div>
          </section>

          {/* NEW: CULTURAL CONTEXT */}
          {festivalData.culturalContextMain && festivalData.culturalContextHighlights && (
            <section className="festival-section cultural-context-section">
              <h2 className="section-title center">Cultural Context</h2>

              <div className="cultural-context-grid">
                <div className="cultural-context-left">
                  {festivalData.culturalContextMain.map((item, index) => (
                    <p key={index}>
                      <strong>{item.title}:</strong> {item.desc}
                    </p>
                  ))}
                </div>

                <div className="cultural-context-right">
                  <div className="context-highlight-card">
                    {festivalData.culturalContextHighlights.map((highlight, idx) => (
                      <div className="context-highlight-item" key={idx}>
                        <span className={`highlight-icon-box ${highlight.colorClass}`}>
                          {highlight.icon}
                        </span>
                        <div>
                          <h4>{highlight.title}</h4>
                          <p>{highlight.desc}</p>
                        </div>
                      </div>
                    ))}
                  </div>
                </div>
              </div>
            </section>
          )}


          {/* QUOTE BANNER */}
          {festivalData.inspiringQuote && (
            <section className="festival-quote-banner">
              <div className="quote-icon-top">
                <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="#e63946" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                  <path d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z"></path>
                </svg>
              </div>
              <h3 className="quote-text">"{festivalData.inspiringQuote}"</h3>
            </section>
          )}

          {/* 5. HOW IT IS CELEBRATED */}
          {festivalData.howItIsCelebrated && (
            <section className="festival-section how-celebrated-section">
              <h2 className="section-title center">How {festivalData.title.split(' ')[0]} is Celebrated</h2>
              <div className="how-celebrated-list">
                {festivalData.howItIsCelebrated.map((step, idx) => (
                  <div className={`celebration-card ${step.align === 'left' ? 'image-left' : 'image-right'}`} key={idx}>
                    <div className="celebration-text">
                      <span className="celebration-badge">{step.phase}</span>
                      <h3 className="celebration-title">{step.title}</h3>
                      {step.desc.map((para, pIdx) => (
                        <p key={pIdx}>{para}</p>
                      ))}
                    </div>
                    <div className="celebration-image">
                      <img src={step.image} alt={step.title} />
                    </div>
                  </div>
                ))}
              </div>
            </section>
          )}

          {/* 6. WHAT TET FEELS LIKE */}
          {festivalData.whatTetFeelsLike && (
            <section className="festival-section feels-like-section">
              <h2 className="section-title center">What {festivalData.title.split(' ')[0]} Feels Like</h2>
              <div className="feels-like-text-grid">
                <div className="feels-like-col">
                  {festivalData.whatTetFeelsLike.leftText.map((p, idx) => (
                    <p key={idx} dangerouslySetInnerHTML={{ __html: p.replace(/(^.*?:)/, '<strong>$1</strong>') }}></p>
                  ))}
                </div>
                <div className="feels-like-col">
                  {festivalData.whatTetFeelsLike.rightText.map((p, idx) => (
                    <p key={idx} dangerouslySetInnerHTML={{ __html: p.replace(/(^.*?:)/, '<strong>$1</strong>') }}></p>
                  ))}
                </div>
              </div>
              <div className="feels-like-banner">
                <img src={festivalData.whatTetFeelsLike.image} alt="Atmosphere Banner" />
              </div>
            </section>
          )}

          {/* 7. KEY TRADITIONS */}
          {festivalData.keyTraditionsDocs && (
            <section className="festival-section key-traditions-section">
              <h2 className="section-title center">Key Traditions</h2>
              <div className="key-traditions-grid">
                {festivalData.keyTraditionsDocs.map((item, idx) => (
                  <div className="key-tradition-card" key={idx}>
                    <img src={item.image} alt={item.title} className="key-tradition-img" />
                    <div className="key-tradition-content">
                      <h4>{item.title}</h4>
                      <p>{item.desc}</p>
                    </div>
                  </div>
                ))}
              </div>
            </section>
          )}

          {/* 7.5 TRADITIONAL FOODS */}
          {festivalData.traditionalFoods && (
            <section className="festival-section traditional-foods-section">
              <div className="section-intro center">
                <h2 className="section-title">Traditional Foods of {festivalData.title.split(' ')[0]}</h2>
                <p>Taste the essence of the new year with indispensable holiday delicacies that tell stories of earth, heaven, and ancestors.</p>
              </div>
              
              <div className="traditional-foods-grid">
                {festivalData.traditionalFoods.map((food, idx) => (
                  <div className="food-card" key={idx}>
                    <div className="food-img-wrap">
                      <img src={food.image} alt={food.title} />
                    </div>
                    <div className="food-content">
                      <h4>{food.title}</h4>
                      <p>{food.desc}</p>
                    </div>
                  </div>
                ))}
              </div>

              {festivalData.regionalFoods && (
                <div className="food-expand-wrapper">
                  <button 
                    className="view-more-btn"
                    onClick={() => setShowMoreFood(!showMoreFood)}
                  >
                    {showMoreFood ? 'Hide Regional Guide' : 'View More Regional Dishes'}
                  </button>

                  <div className={`regional-foods-container ${showMoreFood ? 'expanded' : ''}`}>
                    <div className="regional-foods-grid">
                      <div className="region-col">
                        <span className="region-badge highlight-red">Northern</span>
                        <div className="region-food-list">
                          {festivalData.regionalFoods.north.map((item, idx) => (
                            <div className="food-card small" key={idx}>
                              <div className="food-img-wrap">
                                <img src={item.image} alt={item.title} />
                              </div>
                              <div className="food-content">
                                <h4>{item.title}</h4>
                                <p>{item.desc}</p>
                              </div>
                            </div>
                          ))}
                        </div>
                      </div>
                      <div className="region-col">
                        <span className="region-badge highlight-yellow">Central</span>
                        <div className="region-food-list">
                          {festivalData.regionalFoods.central.map((item, idx) => (
                            <div className="food-card small" key={idx}>
                              <div className="food-img-wrap">
                                <img src={item.image} alt={item.title} />
                              </div>
                              <div className="food-content">
                                <h4>{item.title}</h4>
                                <p>{item.desc}</p>
                              </div>
                            </div>
                          ))}
                        </div>
                      </div>
                      <div className="region-col">
                        <span className="region-badge highlight-orange">Southern</span>
                        <div className="region-food-list">
                          {festivalData.regionalFoods.south.map((item, idx) => (
                            <div className="food-card small" key={idx}>
                              <div className="food-img-wrap">
                                <img src={item.image} alt={item.title} />
                              </div>
                              <div className="food-content">
                                <h4>{item.title}</h4>
                                <p>{item.desc}</p>
                              </div>
                            </div>
                          ))}
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              )}
            </section>
          )}

          {/* 8. CULTURAL MEANINGS */}
          {festivalData.culturalMeaningsDocs && (
            <section className="festival-section cultural-meanings-section">
              <h2 className="section-title center">Cultural Meanings</h2>
              <div className="cultural-meanings-grid">
                {festivalData.culturalMeaningsDocs.map((item, idx) => (
                  <div className="cultural-meaning-card" key={idx}>
                    <div className={`meaning-icon ${item.colorClass}`}>{item.icon}</div>
                    <div className="meaning-content">
                      <h4>{item.title}</h4>
                      <p>{item.desc}</p>
                    </div>
                  </div>
                ))}
              </div>
            </section>
          )}

          {/* 9. INTERESTING FACTS */}
          {festivalData.interestingFactsDocs && (
            <section className="festival-section interesting-facts-section">
              <h2 className="section-title center">Interesting Facts About {festivalData.title.split(' ')[0]}</h2>
              <div className="interesting-facts-grid">
                {festivalData.interestingFactsDocs.map((item, idx) => (
                  <div className="interesting-fact-card" key={idx}>
                    <div className="fact-badge">{item.icon}</div>
                    <div className="fact-content">
                      <h4>{item.title}</h4>
                      <p>{item.desc}</p>
                    </div>
                  </div>
                ))}
              </div>
            </section>
          )}

          {/* 10. TET IN PICTURES (GALLERY) */}
          {festivalData.galleryHero && festivalData.galleryGrid && (
            <section className="festival-section tet-pictures-section">
              <h2 className="section-title center">{festivalData.title.split(' ')[0]} in Pictures</h2>
              <div className="tet-pictures-container">
                <div className="picture-hero">
                  <img src={festivalData.galleryHero} alt="Hero Event" />
                </div>
                <div className="picture-grid-small">
                  {festivalData.galleryGrid.map((img, idx) => (
                    <div className="picture-tile" key={idx}>
                      <img src={img} alt={`Gallery tile ${idx}`} />
                    </div>
                  ))}
                </div>
              </div>
            </section>
          )}

          {/* 11. IN SHORT */}
          {festivalData.inShortText && (
            <section className="festival-section in-short-section">
              <h2 className="section-title center">In Short</h2>
              <p className="in-short-text">{festivalData.inShortText}</p>
            </section>
          )}

          {/* 12. DISCOVER MORE ABOUT TET */}
          {festivalData.discoverMore && (
            <section className="festival-section discover-more-section">
              <h2 className="section-title center">Discover More About {festivalData.title.split(' ')[0]}</h2>
              <div className="discover-more-grid">
                {festivalData.discoverMore.map((item, idx) => (
                  <div className="discover-card" key={idx}>
                    <div className="discover-img-wrap">
                      <img src={item.image} alt={item.title} />
                    </div>
                    <div className="discover-content">
                      <h4>{item.title}</h4>
                      <p>{item.desc}</p>
                    </div>
                  </div>
                ))}
              </div>
            </section>
          )}

        </div>
      </main>

      {/* Footer */}
      <Footer />
    </div>
  );
}


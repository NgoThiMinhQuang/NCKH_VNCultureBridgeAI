import React, { useMemo, useState, useEffect } from 'react';
import { useParams, Link } from 'react-router-dom';
import { ui } from '../../i18n/messages';
import './ProvinceDetailPage.css';
import PageHeader from '../../components/layout/PageHeader/PageHeader';
import Footer from '../../components/layout/Footer/Footer';

// Assets
import hanoiStreet from '../../assets/hanoi_street.png';

export default function ProvinceDetailPage() {
  const { code = 'ha-noi' } = useParams();
  const [lang, setLang] = useState('vi');
  const [activeItinerary, setActiveItinerary] = useState(0);

  const copy = useMemo(() => ui[lang], [lang]);
  const data = useMemo(() => copy.provinceDetail.hanoi, [copy]);
  const t = useMemo(() => copy.provinceDetail, [copy]);

  useEffect(() => {
    window.scrollTo(0, 0);
  }, []);

  return (
    <div className="province-detail">
      <PageHeader lang={lang} onLangChange={setLang} />

      {/* --- HERO SECTION --- */}
      <section className="province-hero">
        <img 
          src={hanoiStreet} 
          alt={data.title} 
          className="province-hero__img" 
        />
        <div className="province-hero__overlay">
          <span className="province-hero__breadcrumb">TRANG CHỦ  /  VÙNG MIỀN  /  HÀ NỘI</span>
          <h1>{data.title}</h1>
          <p>{data.subtitle}</p>
          <div className="hero-actions">
            <Link to="#" className="btn-primary">KHÁM PHÁ NGAY</Link>
            <Link to="#" className="btn-ghost">XEM BẢN ĐỒ</Link>
          </div>
        </div>
      </section>

      {/* --- FLOATING METRICS BAR --- */}
      <div className="province-metrics-bar">
        <div className="metric-item">
          <div className="metric-item__icon">☁️</div>
          <div className="metric-item__info">
            <span className="metric-item__label">{t.metrics.weather}</span>
            <span className="metric-item__value">{data.metro}</span>
          </div>
        </div>
        <div className="metric-item">
          <div className="metric-item__icon">🍂</div>
          <div className="metric-item__info">
            <span className="metric-item__label">{t.metrics.bestTime}</span>
            <span className="metric-item__value">{data.bestTimeVal}</span>
          </div>
        </div>
        <div className="metric-item">
          <div className="metric-item__icon">👥</div>
          <div className="metric-item__info">
            <span className="metric-item__label">{t.metrics.population}</span>
            <span className="metric-item__value">{data.popVal}</span>
          </div>
        </div>
        <div className="metric-item">
          <div className="metric-item__icon">📏</div>
          <div className="metric-item__info">
            <span className="metric-item__label">{t.metrics.area}</span>
            <span className="metric-item__value">{data.areaVal}</span>
          </div>
        </div>
      </div>

      {/* --- OVERVIEW --- */}
      <section className="province-section">
        <div className="overview-layout">
          <div className="overview-main">
            <h2>{t.overview.title}</h2>
            <p>
              Hà Nội, thủ đô nghìn năm văn hiến, là trung tâm chính trị, văn hóa và giáo dục quan trọng nhất của Việt Nam. 
              Nơi đây không chỉ lưu giữ những giá trị lịch sử qua từng ngõ phố, nếp nhà mà còn là sự giao thoa tuyệt vời 
              giữa nét cổ kính của phương Đông và sự hiện đại của xu thế hội nhập.
            </p>
            <p>
              Từ hồ Gươm thơ mộng, phố cổ sầm uất đến những di tích như Văn Miếu - Quốc Tử Giám, Hà Nội luôn mang trong mình 
              một sức hút riêng biệt, thanh lịch và ấm áp, khiến bất kỳ ai ghé thăm cũng đều lưu luyến khôn nguôi.
            </p>
          </div>
          <div className="overview-sidebar">
            <div className="sidebar-facts">
              <h3>{t.overview.quickInfo}</h3>
              <div className="fact-row">
                <label>{t.overview.founded}</label>
                <span>{data.foundedVal}</span>
              </div>
              <div className="fact-row">
                <label>{t.overview.administrative}</label>
                <span>{data.adminVal}</span>
              </div>
              <div className="fact-row">
                <label>Múi giờ</label>
                <span>UTC+7</span>
              </div>
              <div className="fact-row">
                <label>Mã vùng</label>
                <span>024</span>
              </div>
            </div>
            {/* Using a portrait aspect ratio image for the sidebar */}
            <img 
              src="https://images.unsplash.com/photo-1543783230-dc081f2163b2?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&q=800" 
              alt="Hanoi Journey" 
              className="sidebar-img"
            />
          </div>
        </div>
      </section>

      {/* --- PLACES --- */}
      <section className="province-section">
        <div className="section-title">
          <h2>Đi đâu ở Hà Nội</h2>
          <p>Khám phá những địa danh biểu tượng làm nên linh hồn của Thủ đô</p>
        </div>
        <div className="attractions-grid">
          {data.places.map((place, idx) => (
            <div key={idx} className="attraction-card">
              <img 
                src={`https://images.unsplash.com/photo-1${555939594+idx}-58d7cb561ad1?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80`} 
                alt={place.title} 
                className="attraction-card__img" 
              />
              <div className="attraction-card__body">
                <h4>{place.title}</h4>
                <p>{place.desc}</p>
              </div>
            </div>
          ))}
        </div>
      </section>

      {/* --- CULTURE --- */}
      <section className="province-section culture-section">
        <div className="section-title">
          <h2 style={{color: '#fff'}}>Văn hóa và Di sản</h2>
          <p style={{color: 'rgba(255,255,255,0.7)'}}>Gìn giữ bản sắc truyền thống giữa lòng thành phố hiện đại</p>
        </div>
        <div className="culture-items">
          {[
            { icon: '🎭', label: 'Múa rối nước' },
            { icon: '📜', label: 'Thư pháp' },
            { icon: '🍶', label: 'Gốm sứ' },
            { icon: '🎻', label: 'Hát Xẩm' },
            { icon: '👗', label: 'Áo dài' }
          ].map((item, idx) => (
            <div key={idx} className="culture-box">
              <i>{item.icon}</i>
              <span>{item.label}</span>
            </div>
          ))}
        </div>
      </section>

      {/* --- CUISINE --- */}
      <section className="province-section">
        <div className="section-title">
          <h2>Ăn gì ở Hà Nội</h2>
          <p>Tinh hoa ẩm thực kỳ công trong từng hương vị</p>
        </div>
        <div className="cuisine-grid">
          {[
            { title: 'Phở bò Hà Nội', img: 'https://images.unsplash.com/photo-1582878826629-29b7ad1cdc43?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=800' },
            { title: 'Bún chả', img: 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=800' },
            { title: 'Chả cá Lã Vọng', img: 'https://images.unsplash.com/photo-1512058564366-18510be2db19?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=800' }
          ].map((dish, idx) => (
            <div key={idx} className="cuisine-item">
              <img src={dish.img} alt={dish.title} />
              <div className="cuisine-item__info">
                <h4>{dish.title}</h4>
                <Link to="#" style={{color: 'var(--color-secondary)', fontWeight: '700'}}>Khám phá thêm →</Link>
              </div>
            </div>
          ))}
        </div>
      </section>

      {/* --- ITINERARY --- */}
      <section className="province-section" style={{background: '#fdf7f2'}}>
        <div className="section-title">
          <h2>Lịch trình gợi ý</h2>
          <p>Gợi ý hành trình cho những trải nghiệm trọn vẹn nhất</p>
        </div>
        <div className="itinerary-container">
           {[
             { time: '07:30', task: 'Bắt đầu ngày mới với một bát phở nóng hổi tại khu Phố Cổ.' },
             { time: '09:00', task: 'Ghé thăm Lăng Bác, Chùa Một Cột và dạo bước tại Quảng trường Ba Đình.' },
             { time: '14:00', task: 'Khám phá Văn Miếu - Quốc Tử Giám, biểu tượng của giáo dục Việt Nam.' },
             { time: '17:00', task: 'Đón hoàng hôn tại Hồ Tây và thưởng thức bánh tôm đặc sản.' }
           ].map((item, idx) => (
             <div key={idx} className="itinerary-step">
                <div className="step-marker"></div>
                <div className="step-content">
                  <strong>{item.time}</strong>
                  <p>{item.task}</p>
                </div>
             </div>
           ))}
        </div>
      </section>

      {/* --- NEWSLETTER --- */}
      <section className="province-section" style={{background: 'var(--color-dark-section)', color: '#fff', textAlign: 'center'}}>
        <div style={{maxWidth: '800px', margin: '0 auto'}}>
          <h2 style={{fontFamily: 'var(--font-heading)', fontSize: '3rem', marginBottom: '24px'}}>Cảm hứng gửi đến bạn mỗi tuần</h2>
          <p style={{color: 'rgba(255,255,255,0.7)', fontSize: '1.2rem', marginBottom: '48px'}}>
            Đăng ký để nhận những thông tin mới nhất về di sản, lễ hội và cẩm nang du lịch Việt Nam qua email.
          </p>
          <div style={{display: 'flex', gap: '12px', justifyContent: 'center'}}>
            <input 
              type="email" 
              placeholder="Email của bạn" 
              style={{padding: '18px 24px', borderRadius: '12px', border: '1px solid rgba(255,255,255,0.2)', background: 'rgba(255,255,255,0.05)', color: '#fff', width: '400px'}} 
            />
            <button className="btn-primary">ĐĂNG KÝ</button>
          </div>
        </div>
      </section>

      <Footer lang={lang} />
    </div>
  );
}

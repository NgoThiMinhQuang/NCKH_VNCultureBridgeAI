import { useState, useMemo, useEffect } from 'react'
import { Link, useLocation } from 'react-router-dom'
import './ProvincesPage.css'
import PageHeader from '../../components/layout/PageHeader/PageHeader'

const PROVINCES_DATA = [
  // Miền Bắc
  { id: 1, name: 'Hà Nội', region: 'Miền Bắc', subRegion: 'Đồng bằng sông Hồng', type: 'Thành phố trực thuộc TW', tags: ['Thủ đô', 'Văn hiến', 'Hồ Gươm'], area: '3.359 km²', pop: '8.33 Triệu' },
  { id: 2, name: 'Hải Phòng', region: 'Miền Bắc', subRegion: 'Đồng bằng sông Hồng', type: 'Thành phố trực thuộc TW', tags: ['Cảng biển', 'Hoa phượng đỏ'], area: '1.562 km²', pop: '2.07 Triệu' },
  { id: 3, name: 'Hà Giang', region: 'Miền Bắc', subRegion: 'Tây Bắc', type: 'Tỉnh', tags: ['Cao nguyên đá', 'Mã Pì Lèng'], area: '7.929 km²', pop: '0.87 Triệu' },
  { id: 4, name: 'Lào Cai', region: 'Miền Bắc', subRegion: 'Tây Bắc', type: 'Tỉnh', tags: ['Sa Pa', 'Fansipan'], area: '6.364 km²', pop: '0.74 Triệu' },
  { id: 5, name: 'Quảng Ninh', region: 'Miền Bắc', subRegion: 'Đông Bắc', type: 'Tỉnh', tags: ['Vịnh Hạ Long', 'Than đá'], area: '6.178 km²', pop: '1.34 Triệu' },
  { id: 6, name: 'Ninh Bình', region: 'Miền Bắc', subRegion: 'Đồng bằng sông Hồng', type: 'Tỉnh', tags: ['Tràng An', 'Cố đô Hoa Lư'], area: '1.387 km²', pop: '0.99 Triệu' },
  { id: 7, name: 'Sơn La', region: 'Miền Bắc', subRegion: 'Tây Bắc', type: 'Tỉnh', tags: ['Mộc Châu', 'Thủy điện'], area: '14.123 km²', pop: '1.25 Triệu' },
  { id: 8, name: 'Điện Biên', region: 'Miền Bắc', subRegion: 'Tây Bắc', type: 'Tỉnh', tags: ['Lịch sử', 'Hoa ban'], area: '9.541 km²', pop: '0.61 Triệu' },
  { id: 9, name: 'Lai Châu', region: 'Miền Bắc', subRegion: 'Tây Bắc', type: 'Tỉnh', tags: ['Núi cao', 'Văn hóa Thái'], area: '9.068 km²', pop: '0.47 Triệu' },
  { id: 10, name: 'Yên Bái', region: 'Miền Bắc', subRegion: 'Tây Bắc', type: 'Tỉnh', tags: ['Mù Cang Chải', 'Ruộng bậc thang'], area: '6.887 km²', pop: '0.83 Triệu' },
  { id: 11, name: 'Hòa Bình', region: 'Miền Bắc', subRegion: 'Tây Bắc', type: 'Tỉnh', tags: ['Thủy điện', 'Văn hóa Mường'], area: '4.591 km²', pop: '0.86 Triệu' },
  { id: 12, name: 'Lạng Sơn', region: 'Miền Bắc', subRegion: 'Đông Bắc', type: 'Tỉnh', tags: ['Mẫu Sơn', 'Cửa khẩu'], area: '8.310 km²', pop: '0.79 Triệu' },
  { id: 13, name: 'Tuyên Quang', region: 'Miền Bắc', subRegion: 'Đông Bắc', type: 'Tỉnh', tags: ['Thủ đô kháng chiến'], area: '5.867 km²', pop: '0.79 Triệu' },
  { id: 14, name: 'Cao Bằng', region: 'Miền Bắc', subRegion: 'Đông Bắc', type: 'Tỉnh', tags: ['Thác Bản Giốc', 'Pác Bó'], area: '6.700 km²', pop: '0.53 Triệu' },
  { id: 15, name: 'Bắc Kạn', region: 'Miền Bắc', subRegion: 'Đông Bắc', type: 'Tỉnh', tags: ['Hồ Ba Bể'], area: '4.859 km²', pop: '0.31 Triệu' },
  { id: 16, name: 'Thái Nguyên', region: 'Miền Bắc', subRegion: 'Đông Bắc', type: 'Tỉnh', tags: ['Trà Tân Cương'], area: '3.536 km²', pop: '1.30 Triệu' },
  { id: 17, name: 'Phú Thọ', region: 'Miền Bắc', subRegion: 'Đông Bắc', type: 'Tỉnh', tags: ['Đền Hùng', 'Giỗ Tổ'], area: '3.533 km²', pop: '1.48 Triệu' },
  { id: 18, name: 'Bắc Giang', region: 'Miền Bắc', subRegion: 'Đông Bắc', type: 'Tỉnh', tags: ['Vải thiều', 'Tây Yên Tử'], area: '3.895 km²', pop: '1.83 Triệu' },
  { id: 19, name: 'Bắc Ninh', region: 'Miền Bắc', subRegion: 'Đồng bằng sông Hồng', type: 'Tỉnh', tags: ['Quan họ', 'Kinh Bắc'], area: '822 km²', pop: '1.40 Triệu' },
  { id: 20, name: 'Vĩnh Phúc', region: 'Miền Bắc', subRegion: 'Đồng bằng sông Hồng', type: 'Tỉnh', tags: ['Tam Đảo', 'Tây Thiên'], area: '1.235 km²', pop: '1.17 Triệu' },
  { id: 21, name: 'Hưng Yên', region: 'Miền Bắc', subRegion: 'Đồng bằng sông Hồng', type: 'Tỉnh', tags: ['Phố Hiến', 'Nhãn lồng'], area: '930 km²', pop: '1.27 Triệu' },
  { id: 22, name: 'Hải Dương', region: 'Miền Bắc', subRegion: 'Đồng bằng sông Hồng', type: 'Tỉnh', tags: ['Bánh đậu xanh', 'Côn Sơn'], area: '1.668 km²', pop: '1.91 Triệu' },
  { id: 23, name: 'Thái Bình', region: 'Miền Bắc', subRegion: 'Đồng bằng sông Hồng', type: 'Tỉnh', tags: ['Chùa Keo', 'Quê lúa'], area: '1.570 km²', pop: '1.86 Triệu' },
  { id: 24, name: 'Hà Nam', region: 'Miền Bắc', subRegion: 'Đồng bằng sông Hồng', type: 'Tỉnh', tags: ['Tam Chúc'], area: '862 km²', pop: '0.85 Triệu' },
  { id: 25, name: 'Nam Định', region: 'Miền Bắc', subRegion: 'Đồng bằng sông Hồng', type: 'Tỉnh', tags: ['Đền Trần', 'Phở'], area: '1.668 km²', pop: '1.78 Triệu' },

  // Miền Trung
  { id: 26, name: 'Đà Nẵng', region: 'Miền Trung', subRegion: 'Nam Trung Bộ', type: 'Thành phố trực thuộc TW', tags: ['Cầu Rồng', 'Biển Mỹ Khê'], area: '1.285 km²', pop: '1.16 Triệu' },
  { id: 27, name: 'Thừa Thiên Huế', region: 'Miền Trung', subRegion: 'Bắc Trung Bộ', type: 'Tỉnh', tags: ['Cố đô', 'Sông Hương'], area: '5.033 km²', pop: '1.13 Triệu' },
  { id: 28, name: 'Quảng Nam', region: 'Miền Trung', subRegion: 'Nam Trung Bộ', type: 'Tỉnh', tags: ['Hội An', 'Mỹ Sơn'], area: '10.574 km²', pop: '1.50 Triệu' },
  { id: 29, name: 'Thanh Hóa', region: 'Miền Trung', subRegion: 'Bắc Trung Bộ', type: 'Tỉnh', tags: ['Sầm Sơn', 'Thành Nhà Hồ'], area: '11.120 km²', pop: '3.67 Triệu' },
  { id: 30, name: 'Nghệ An', region: 'Miền Trung', subRegion: 'Bắc Trung Bộ', type: 'Tỉnh', tags: ['Quê Bác', 'Cửa Lò'], area: '16.490 km²', pop: '3.37 Triệu' },
  { id: 31, name: 'Hà Tĩnh', region: 'Miền Trung', subRegion: 'Bắc Trung Bộ', type: 'Tỉnh', tags: ['Ngã ba Đồng Lộc'], area: '5.997 km²', pop: '1.29 Triệu' },
  { id: 32, name: 'Quảng Bình', region: 'Miền Trung', subRegion: 'Bắc Trung Bộ', type: 'Tỉnh', tags: ['Phong Nha', 'Sơn Đoòng'], area: '8.065 km²', pop: '0.90 Triệu' },
  { id: 33, name: 'Quảng Trị', region: 'Miền Trung', subRegion: 'Bắc Trung Bộ', type: 'Tỉnh', tags: ['Thành cổ', 'Vĩ tuyến 17'], area: '4.737 km²', pop: '0.64 Triệu' },
  { id: 34, name: 'Quảng Ngãi', region: 'Miền Trung', subRegion: 'Nam Trung Bộ', type: 'Tỉnh', tags: ['Lý Sơn', 'Thiên Ấn'], area: '5.135 km²', pop: '1.23 Triệu' },
  { id: 35, name: 'Bình Định', region: 'Miền Trung', subRegion: 'Nam Trung Bộ', type: 'Tỉnh', tags: ['Quy Nhơn', 'Đất võ'], area: '6.066 km²', pop: '1.49 Triệu' },
  { id: 36, name: 'Phú Yên', region: 'Miền Trung', subRegion: 'Nam Trung Bộ', type: 'Tỉnh', tags: ['Gành Đá Đĩa'], area: '5.023 km²', pop: '0.87 Triệu' },
  { id: 37, name: 'Khánh Hòa', region: 'Miền Trung', subRegion: 'Nam Trung Bộ', type: 'Tỉnh', tags: ['Nha Trang', 'Trầm hương'], area: '5.137 km²', pop: '1.24 Triệu' },
  { id: 38, name: 'Ninh Thuận', region: 'Miền Trung', subRegion: 'Nam Trung Bộ', type: 'Tỉnh', tags: ['Nho Ninh Thuận', 'Tháp Chăm'], area: '3.355 km²', pop: '0.59 Triệu' },
  { id: 39, name: 'Bình Thuận', region: 'Miền Trung', subRegion: 'Nam Trung Bộ', type: 'Tỉnh', tags: ['Mũi Né', 'Thanh long'], area: '7.943 km²', pop: '1.24 Triệu' },
  { id: 40, name: 'Kon Tum', region: 'Miền Trung', subRegion: 'Tây Nguyên', type: 'Tỉnh', tags: ['Nhà rông', 'Măng Đen'], area: '9.674 km²', pop: '0.55 Triệu' },
  { id: 41, name: 'Gia Lai', region: 'Miền Trung', subRegion: 'Tây Nguyên', type: 'Tỉnh', tags: ['Pleiku', 'Biển Hồ'], area: '15.510 km²', pop: '1.53 Triệu' },
  { id: 42, name: 'Đắk Lắk', region: 'Miền Trung', subRegion: 'Tây Nguyên', type: 'Tỉnh', tags: ['Cà phê', 'Buôn Ma Thuột'], area: '13.125 km²', pop: '1.89 Triệu' },
  { id: 43, name: 'Đắk Nông', region: 'Miền Trung', subRegion: 'Tây Nguyên', type: 'Tỉnh', tags: ['Gia Nghĩa', 'Công viên địa chất'], area: '6.509 km²', pop: '0.63 Triệu' },
  { id: 44, name: 'Lâm Đồng', region: 'Miền Trung', subRegion: 'Tây Nguyên', type: 'Tỉnh', tags: ['Đà Lạt', 'Cao nguyên'], area: '9.783 km²', pop: '1.31 Triệu' },

  // Miền Nam
  { id: 45, name: 'TP. Hồ Chí Minh', region: 'Miền Nam', subRegion: 'Đông Nam Bộ', type: 'Thành phố trực thuộc TW', tags: ['Sài Gòn', 'Kinh tế'], area: '2.061 km²', pop: '9.17 Triệu' },
  { id: 46, name: 'Cần Thơ', region: 'Miền Nam', subRegion: 'Tây Nam Bộ', type: 'Thành phố trực thuộc TW', tags: ['Chợ nổi', 'Gạo trắng nước trong'], area: '1.439 km²', pop: '1.24 Triệu' },
  { id: 47, name: 'Bình Phước', region: 'Miền Nam', subRegion: 'Đông Nam Bộ', type: 'Tỉnh', tags: ['Cao su', 'Hồ tiêu'], area: '6.877 km²', pop: '1.00 Triệu' },
  { id: 48, name: 'Tây Ninh', region: 'Miền Nam', subRegion: 'Đông Nam Bộ', type: 'Tỉnh', tags: ['Núi Bà Đen', 'Tòa thánh'], area: '4.041 km²', pop: '1.18 Triệu' },
  { id: 49, name: 'Bình Dương', region: 'Miền Nam', subRegion: 'Đông Nam Bộ', type: 'Tỉnh', tags: ['Công nghiệp'], area: '2.694 km²', pop: '2.62 Triệu' },
  { id: 50, name: 'Đồng Nai', region: 'Miền Nam', subRegion: 'Đông Nam Bộ', type: 'Tỉnh', tags: ['Khu công nghiệp'], area: '5.903 km²', pop: '3.17 Triệu' },
  { id: 51, name: 'Bà Rịa - Vũng Tàu', region: 'Miền Nam', subRegion: 'Đông Nam Bộ', type: 'Tỉnh', tags: ['Biển Vũng Tàu', 'Dầu khí'], area: '1.980 km²', pop: '1.16 Triệu' },
  { id: 52, name: 'Long An', region: 'Miền Nam', subRegion: 'Tây Nam Bộ', type: 'Tỉnh', tags: ['Cửa ngõ miền Tây'], area: '4.494 km²', pop: '1.69 Triệu' },
  { id: 53, name: 'Đồng Tháp', region: 'Miền Nam', subRegion: 'Tây Nam Bộ', type: 'Tỉnh', tags: ['Sa Đéc', 'Đất sen hồng'], area: '3.383 km²', pop: '1.59 Triệu' },
  { id: 54, name: 'An Giang', region: 'Miền Nam', subRegion: 'Tây Nam Bộ', type: 'Tỉnh', tags: ['Thất Sơn', 'Miếu Bà'], area: '3.536 km²', pop: '1.90 Triệu' },
  { id: 55, name: 'Tiền Giang', region: 'Miền Nam', subRegion: 'Tây Nam Bộ', type: 'Tỉnh', tags: ['Chợ nổi Cái Bè'], area: '2.510 km²', pop: '1.77 Triệu' },
  { id: 56, name: 'Vĩnh Long', region: 'Miền Nam', subRegion: 'Tây Nam Bộ', type: 'Tỉnh', tags: ['Trái cây'], area: '1.525 km²', pop: '1.02 Triệu' },
  { id: 57, name: 'Bến Tre', region: 'Miền Nam', subRegion: 'Tây Nam Bộ', type: 'Tỉnh', tags: ['Xứ dừa'], area: '2.394 km²', pop: '1.29 Triệu' },
  { id: 58, name: 'Kiên Giang', region: 'Miền Nam', subRegion: 'Tây Nam Bộ', type: 'Tỉnh', tags: ['Phú Quốc', 'Hà Tiên'], area: '6.348 km²', pop: '1.73 Triệu' },
  { id: 59, name: 'Hậu Giang', region: 'Miền Nam', subRegion: 'Tây Nam Bộ', type: 'Tỉnh', tags: ['Chợ nổi'], area: '1.621 km²', pop: '0.73 Triệu' },
  { id: 60, name: 'Trà Vinh', region: 'Miền Nam', subRegion: 'Tây Nam Bộ', type: 'Tỉnh', tags: ['Văn hóa Khmer'], area: '2.358 km²', pop: '1.01 Triệu' },
  { id: 61, name: 'Sóc Trăng', region: 'Miền Nam', subRegion: 'Tây Nam Bộ', type: 'Tỉnh', tags: ['Chùa Dơi', 'Đua ghe Ngo'], area: '3.311 km²', pop: '1.20 Triệu' },
  { id: 62, name: 'Bạc Liêu', region: 'Miền Nam', subRegion: 'Tây Nam Bộ', type: 'Tỉnh', tags: ['Công tử Bạc Liêu'], area: '2.668 km²', pop: '0.91 Triệu' },
  { id: 63, name: 'Cà Mau', region: 'Miền Nam', subRegion: 'Tây Nam Bộ', type: 'Tỉnh', tags: ['Đất mũi', 'Cuối bản đồ'], area: '5.294 km²', pop: '1.19 Triệu' },
];

export default function ProvincesPage() {
  const location = useLocation();
  const [lang, setLang] = useState('vi');
  const [searchTerm, setSearchTerm] = useState('');
  const [sortBy, setSortBy] = useState('name');
  const [viewMode, setViewMode] = useState('grid');

  useEffect(() => {
    if (location.state?.search) {
      setSearchTerm(location.state.search);
    }
  }, [location.state]);
  
  const filteredData = useMemo(() => {
    let result = PROVINCES_DATA.filter(p => 
      p.name.toLowerCase().includes(searchTerm.toLowerCase()) || 
      p.region.toLowerCase().includes(searchTerm.toLowerCase()) ||
      p.tags.some(t => t.toLowerCase().includes(searchTerm.toLowerCase()))
    );

    if (sortBy === 'name') {
      result.sort((a, b) => a.name.localeCompare(b.name, 'vi'));
    } else if (sortBy === 'area') {
      result.sort((a, b) => parseFloat(b.area) - parseFloat(a.area));
    }
    
    return result;
  }, [searchTerm, sortBy]);

  const groupedData = useMemo(() => {
    const groups = {
      'Miền Bắc': [],
      'Miền Trung': [],
      'Miền Nam': []
    };
    filteredData.forEach(p => {
      if (groups[p.region]) groups[p.region].push(p);
    });
    return groups;
  }, [filteredData]);

  useEffect(() => {
    document.title = lang === 'vi' ? 'VietCultura - Tất cả tỉnh thành' : 'VietCultura - All Provinces';
    window.scrollTo(0, 0);
  }, [lang]);

  return (
    <div className="provinces-page">
      <PageHeader 
        lang={lang} 
        onLangChange={setLang}
        breadcrumb={[
          { label: lang === 'vi' ? 'Khám phá vùng miền' : 'Explore Regions', path: '/regions' },
          { label: lang === 'vi' ? 'Tất cả tỉnh thành' : 'All Provinces' }
        ]}
      />

      <main className="provinces-page__content">
        {/* Header Section */}
        <section className="provinces-hero fade-up">
          <div className="container">
            <h1 className="provinces-hero__title">
              {lang === 'vi' ? 'Tất cả tỉnh thành Việt Nam' : 'All Provinces of Vietnam'}
            </h1>
            <p className="provinces-hero__subtitle">
              {lang === 'vi' 
                ? 'Khám phá 63 tỉnh thành với những nét văn hóa đặc sắc và phong cảnh hữu tình từ Bắc chí Nam.' 
                : 'Explore 63 provinces with unique cultural features and charming landscapes from North to South.'}
            </p>

            {/* Stats Cards */}
            <div className="provinces-stats">
              <div className="provinces-stats__card">
                <div className="provinces-stats__icon">🏙️</div>
                <div className="provinces-stats__info">
                  <span className="provinces-stats__value">63</span>
                  <span className="provinces-stats__label">{lang === 'vi' ? 'Tỉnh thành' : 'Provinces'}</span>
                </div>
              </div>
              <div className="provinces-stats__card">
                <div className="provinces-stats__icon">🗺️</div>
                <div className="provinces-stats__info">
                  <span className="provinces-stats__value">03</span>
                  <span className="provinces-stats__label">{lang === 'vi' ? 'Miền chính' : 'Main Regions'}</span>
                </div>
              </div>
              <div className="provinces-stats__card">
                <div className="provinces-stats__icon">💠</div>
                <div className="provinces-stats__info">
                  <span className="provinces-stats__value">07</span>
                  <span className="provinces-stats__label">{lang === 'vi' ? 'Vùng kinh tế' : 'Eco-regions'}</span>
                </div>
              </div>
              <div className="provinces-stats__card">
                <div className="provinces-stats__icon">👥</div>
                <div className="provinces-stats__info">
                  <span className="provinces-stats__value">54</span>
                  <span className="provinces-stats__label">{lang === 'vi' ? 'Dân tộc' : 'Ethnic groups'}</span>
                </div>
              </div>
            </div>
          </div>
        </section>

        {/* Filter Bar */}
        <section className="provinces-filters sticky-top">
          <div className="container">
            <div className="provinces-filters__wrapper">
              <div className="provinces-search">
                <svg className="provinces-search__icon" width="20" height="20" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
                </svg>
                <input 
                  type="text" 
                  placeholder={lang === 'vi' ? 'Tìm kiếm tỉnh thành, địa danh...' : 'Search provinces, landmarks...'}
                  value={searchTerm}
                  onChange={(e) => setSearchTerm(e.target.value)}
                />
              </div>
              
              <div className="provinces-sort">
                <div className="provinces-view-toggle">
                  <button 
                    className={`provinces-view-btn ${viewMode === 'grid' ? 'is-active' : ''}`}
                    onClick={() => setViewMode('grid')}
                    aria-label="Grid view"
                  >
                    <svg width="20" height="20" fill="currentColor" viewBox="0 0 24 24"><path d="M4 4h4v4H4V4zm6 0h4v4h-4V4zm6 0h4v4h-4V4zM4 10h4v4H4v-4zm6 0h4v4h-4v-4zm6 0h4v4h-4v-4zM4 16h4v4H4v-4zm6 0h4v4h-4v-4zm6 0h4v4h-4v-4z"/></svg>
                  </button>
                  <button 
                    className={`provinces-view-btn ${viewMode === 'list' ? 'is-active' : ''}`}
                    onClick={() => setViewMode('list')}
                    aria-label="List view"
                  >
                    <svg width="20" height="20" fill="currentColor" viewBox="0 0 24 24"><path d="M4 6h16v2H4V6zm0 5h16v2H4v-2zm0 5h16v2H4v-2z"/></svg>
                  </button>
                </div>
                <span className="provinces-sort__label">{lang === 'vi' ? 'Sắp xếp:' : 'Sort by:'}</span>
                <select value={sortBy} onChange={(e) => setSortBy(e.target.value)}>
                  <option value="name">{lang === 'vi' ? 'Tên A-Z' : 'Name A-Z'}</option>
                  <option value="area">{lang === 'vi' ? 'Diện tích' : 'Area'}</option>
                </select>
              </div>
            </div>
          </div>
        </section>

        {/* Region Quick Navigation */}
        <div className="provinces-region-nav sticky-top-secondary">
          <div className="container">
            <div className="provinces-region-tabs">
              <button className={searchTerm === '' ? 'is-active' : ''} onClick={() => setSearchTerm('')}>
                {lang === 'vi' ? 'Tất cả' : 'All'}
              </button>
              <button className={searchTerm === 'Miền Bắc' ? 'is-active' : ''} onClick={() => setSearchTerm('Miền Bắc')}>
                {lang === 'vi' ? 'Miền Bắc' : 'Northern'}
              </button>
              <button className={searchTerm === 'Miền Trung' ? 'is-active' : ''} onClick={() => setSearchTerm('Miền Trung')}>
                {lang === 'vi' ? 'Miền Trung' : 'Central'}
              </button>
              <button className={searchTerm === 'Miền Nam' ? 'is-active' : ''} onClick={() => setSearchTerm('Miền Nam')}>
                {lang === 'vi' ? 'Miền Nam' : 'Southern'}
              </button>
            </div>
          </div>
        </div>

        {/* Regions Listing */}
        <div className="container">
          {Object.entries(groupedData).map(([regionName, provinces]) => (
            provinces.length > 0 && (
              <section key={regionName} className="provinces-region-section fade-up">
                <div className="provinces-region-header">
                  <h2 className="provinces-region-title">{regionName}</h2>
                  <span className="provinces-region-count">{provinces.length} {lang === 'vi' ? 'tỉnh thành' : 'provinces'}</span>
                </div>
                
                <div className={`provinces-grid is-${viewMode}`}>
                  {provinces.map(p => (
                    <div key={p.id} className={`province-card-v2 is-${viewMode}`}>
                      <div className="province-card-v2__image">
                        <div className="province-card-v2__placeholder">
                          <img 
                            src={`https://images.unsplash.com/photo-1599708153386-62e2d369607f?auto=format&fit=crop&w=800&q=80&sig=${p.id}`} 
                            alt={p.name}
                          />
                        </div>
                        <span className="province-card-v2__badge">{p.subRegion}</span>
                      </div>
                      <div className="province-card-v2__content">
                        <div className="province-card-v2__main">
                          <div className="province-card-v2__title-row">
                            <h3 className="province-card-v2__title">{p.name}</h3>
                            <span className="province-card-v2__type">{p.type}</span>
                          </div>
                        </div>
                        {viewMode === 'grid' && (
                          <div className="province-card-v2__tags">
                            {p.tags.map(t => <span key={t} className="province-card-v2__tag">#{t}</span>)}
                          </div>
                        )}
                        <div className="province-card-v2__meta">
                          <div className="province-card-v2__meta-item">
                            <span className="icon" title="Area">📐</span>
                            <span className="label">DT:</span>
                            <span className="value">{p.area}</span>
                          </div>
                          <div className="province-card-v2__meta-item">
                            <span className="icon" title="Population">👨‍👩‍👧‍👦</span>
                            <span className="label">DS:</span>
                            <span className="value">{p.pop}</span>
                          </div>
                        </div>
                        {viewMode === 'list' && (
                          <div className="province-card-v2__tags">
                            {p.tags.map(t => <span key={t} className="province-card-v2__tag">#{t}</span>)}
                          </div>
                        )}
                        <Link to={`/regions/provinces/${p.id}`} className="province-card-v2__btn">
                          {lang === 'vi' ? 'Xem chi tiết' : 'View Detail'}
                          <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
                            <path d="M5 12h14M12 5l7 7-7 7" />
                          </svg>
                        </Link>
                      </div>
                    </div>
                  ))}
                </div>
              </section>
            )
          ))}

          {filteredData.length === 0 && (
            <div className="provinces-empty">
              <p>{lang === 'vi' ? 'Không tìm thấy tỉnh thành phù hợp.' : 'No provinces found match your search.'}</p>
              <button className="provinces-empty__reset" onClick={() => setSearchTerm('')}>
                {lang === 'vi' ? 'Xóa tìm kiếm' : 'Clear search'}
              </button>
            </div>
          )}
        </div>
      </main>
    </div>
  )
}

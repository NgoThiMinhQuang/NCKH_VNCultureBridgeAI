import { API_BASE_URL } from "../../utils/constants";

export const FESTIVALS_PER_PAGE = 9;

export const REGION_OPTIONS = [
  { value: "", label: "Tất cả vùng miền" },
  { value: "BAC_BO", label: "Bắc Bộ" },
  { value: "TRUNG_BO", label: "Trung Bộ" },
  { value: "NAM_BO", label: "Nam Bộ" },
];

export const MONTH_OPTIONS = [
  { value: "", label: "Tất cả các tháng" },
  { value: "01", label: "Tháng 01" },
  { value: "02", label: "Tháng 02" },
  { value: "03", label: "Tháng 03" },
  { value: "04", label: "Tháng 04" },
  { value: "05", label: "Tháng 05" },
  { value: "06", label: "Tháng 06" },
  { value: "07", label: "Tháng 07" },
  { value: "08", label: "Tháng 08" },
  { value: "09", label: "Tháng 09" },
  { value: "10", label: "Tháng 10" },
  { value: "11", label: "Tháng 11" },
  { value: "12", label: "Tháng 12" },
];

export const CATEGORY_OPTIONS = [
  { value: "", label: "Tất cả loại hình" },
  { value: "DAN_GIAN", label: "Lễ hội dân gian" },
  { value: "TON_GIAO", label: "Lễ hội tôn giáo" },
  { value: "LICH_SU", label: "Lễ hội lịch sử" },
  { value: "VAN_HOA", label: "Lễ hội văn hóa" },
];

export const getImageUrl = (url) => {
  if (!url) return "https://images.unsplash.com/photo-1542332213-31f87348057f?auto=format&fit=crop&w=800&q=80"; // Fallback
  if (url.startsWith("http")) return url;
  // Giả sử url là đường dẫn tương đối từ backend
  const baseUrl = API_BASE_URL.replace("/api", "");
  return `${baseUrl}${url}`;
};

export const buildFestivalData = (apiData, lang) => {
  if (!apiData) return { festivals: [], page: {}, gallery: [], timeline: [] };

  const festivals = (apiData.festivals || []).map((item) => ({
    id: item.id,
    code: item.code,
    title: item.title,
    date: item.date,
    location: item.location,
    desc: item.desc,
    image: item.image,
    region: item.region,
    tag: item.tagName,
    category: item.category,
  }));

  const stats = [
    { label: lang === 'vi' ? 'Lễ hội' : 'Festivals', value: apiData.stats?.festivalCount || '8.000+' },
    { label: lang === 'vi' ? 'Dân tộc' : 'Ethnic Groups', value: apiData.stats?.ethnicGroupCount?.toString() || '54' },
    { label: lang === 'vi' ? 'Vùng miền' : 'Regions', value: apiData.stats?.regionCount?.toString() || '3' }
  ];

  const gallery = (apiData.sections?.gallery || []).map(g => ({
    imageUrl: g.imageUrl,
    alt: g.imageAlt
  }));
  return {
    page: {
      hero: {
        badge: lang === "vi" ? "Di sản văn hóa phi vật thể" : "Intangible Cultural Heritage",
        titleLine: lang === "vi" ? "Tinh hoa" : "The Essence of",
        titleAccent: lang === "vi" ? "Lễ hội" : "Festivals",
        titleLine2: lang === "vi" ? "Việt Nam" : "Vietnam",
        subtitle: apiData.hero?.subtitle || (lang === "vi" ? "Khám phá bản sắc văn hóa và tinh thần cộng đồng qua những mùa lễ hội truyền thống đặc sắc." : "Explore cultural identity and community spirit through unique traditional festivals."),
      },
      stats,
      major: {
        badge: lang === "vi" ? "Lễ hội nổi bật" : "Featured Festivals",
        title: lang === "vi" ? "Lễ hội tiêu biểu" : "Representative Festivals",
        subtitle: lang === "vi" ? "Khám phá những lễ hội nổi bật và có sức lan tỏa mạnh mẽ" : "Discover outstanding and influential festivals",
      },
      meaning: {
        badge: lang === "vi" ? "Ý nghĩa văn hóa" : "Cultural Meaning",
        title: apiData.sections?.meaning?.title || (lang === "vi" ? "Linh hồn của lễ hội Việt" : "The Soul of Vietnamese Festivals"),
        desc: apiData.sections?.meaning?.desc || (lang === "vi" ? "Mỗi lễ hội là một bức tranh sống động về lòng biết ơn cội nguồn" : "Each festival is a vibrant picture of gratitude to the roots"),
      },
      all: {
        title: lang === "vi" ? "Khám phá các lễ hội Việt Nam" : "Discover Vietnamese Festivals",
        subtitle: lang === "vi" ? "Mở từng trang để xem nội dung lễ hội tương ứng" : "Open each page to see the corresponding festival content",
      },
      timeline: {
        badge: lang === "vi" ? "Lễ hội quanh năm" : "Year-round Festivals",
        title: lang === "vi" ? "Dòng thời gian lễ hội" : "Festival Timeline",
      },
      gallery: {
        badge: lang === "vi" ? "Hành trình thị giác" : "Visual Journey",
        title: lang === "vi" ? "Khoảnh khắc lễ hội" : "Festival Moments",
      },
      quote: {
        title: apiData.sections?.quote?.text || (lang === "vi" ? "Uống nước nhớ nguồn" : "Remember the Source"),
        desc: apiData.sections?.quote?.author || (lang === "vi" ? "Tinh thần biết ơn cội nguồn chính là nền tảng." : "The spirit of gratitude to the roots is the foundation."),
      }
    },
    festivals,
    gallery: gallery.length > 0 ? gallery : festivals.slice(0, 10).map(f => ({ imageUrl: f.image, alt: f.title })),
    timeline: [
      { id: 1, month: "01", title: lang === "vi" ? "Lễ hội Xuân" : "Spring Festival", season: lang === "vi" ? "Mùa Xuân" : "Spring", color: "#e63946", image: "https://images.unsplash.com/photo-1579624538806-259837f4876b?auto=format&fit=crop&w=400&q=80" },
      { id: 2, month: "03", title: lang === "vi" ? "Lễ hội Phú Thọ" : "Phu Tho Festival", season: lang === "vi" ? "Mùa Xuân" : "Spring", color: "#f1faee", image: "https://images.unsplash.com/photo-1542332213-31f87348057f?auto=format&fit=crop&w=400&q=80" },
      { id: 3, month: "05", title: lang === "vi" ? "Lễ hội Biển" : "Sea Festival", season: lang === "vi" ? "Mùa Hạ" : "Summer", color: "#a8dadc", image: "https://images.unsplash.com/photo-1507525428034-b723cf961d3e?auto=format&fit=crop&w=400&q=80" },
      { id: 4, month: "08", title: lang === "vi" ? "Lễ hội Trăng Rằm" : "Full Moon Festival", season: lang === "vi" ? "Mùa Thu" : "Autumn", color: "#457b9d", image: "https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=400&q=80" },
      { id: 5, month: "10", title: lang === "vi" ? "Lễ hội Khmer" : "Khmer Festival", season: lang === "vi" ? "Mùa Thu" : "Autumn", color: "#1d3557", image: "https://images.unsplash.com/photo-1585223126786-9316d5ba4b17?auto=format&fit=crop&w=400&q=80" },
      { id: 6, month: "12", title: lang === "vi" ? "Lễ hội Cuối Năm" : "Year End Festival", season: lang === "vi" ? "Mùa Đông" : "Winter", color: "#2b2d42", image: "https://images.unsplash.com/photo-1483728642387-6c3bdd6c93e5?auto=format&fit=crop&w=400&q=80" },
    ],
  };
};

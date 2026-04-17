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
      {
        id: 1,
        month: "01",
        title: lang === "vi" ? "Tết Nguyên Đán" : "Lunar New Year",
        date: lang === "vi" ? "Mùng 1/1 Âm lịch" : "1st Day of 1st Lunar Month",
        location: lang === "vi" ? "Toàn quốc" : "Nationwide",
        season: lang === "vi" ? "Mùa Xuân" : "Spring",
        color: "#ce112d",
        image: "https://images.unsplash.com/photo-1533227268408-a77469319204?auto=format&fit=crop&w=600&q=80",
        desc: lang === "vi" ? "Lễ hội lớn nhất và quan trọng nhất, khởi đầu năm mới với niềm vui và may mắn." : "The largest and most important festival, starting the new year with joy and luck."
      },
      {
        id: 2,
        month: "02",
        title: lang === "vi" ? "Lễ hội Chùa Hương" : "Huong Pagoda Festival",
        date: lang === "vi" ? "Tháng 1 - Tháng 3 Âm lịch" : "1st to 3rd Lunar Month",
        location: lang === "vi" ? "Hà Nội" : "Hanoi",
        season: lang === "vi" ? "Mùa Xuân" : "Spring",
        color: "#f8c97a",
        image: "https://images.unsplash.com/photo-1579624538806-259837f4876b?auto=format&fit=crop&w=600&q=80",
        desc: lang === "vi" ? "Hành trình tâm linh về miền đất Phật, chiêm ngưỡng vẻ đẹp sơn thủy hữu tình." : "A spiritual journey to the Buddhist land, admiring the romantic landscape."
      },
      {
        id: 3,
        month: "03",
        title: lang === "vi" ? "Lễ hội Đền Hùng" : "Hung Kings Temple Festival",
        date: lang === "vi" ? "Mùng 10/3 Âm lịch" : "10th Day of 3rd Lunar Month",
        location: lang === "vi" ? "Phú Thọ" : "Phu Tho",
        season: lang === "vi" ? "Mùa Xuân" : "Spring",
        color: "#ffcc00",
        image: "https://images.unsplash.com/photo-1522031754407-28d88e07246b?auto=format&fit=crop&w=600&q=80",
        desc: lang === "vi" ? "Ngày quốc giỗ thiêng liêng tưởng nhớ công lao của các Vua Hùng dựng nước." : "The sacred national anniversary commemorating the contributions of the Hung Kings."
      },
      {
        id: 4,
        month: "04",
        title: lang === "vi" ? "Lễ hội Tháp Bà" : "Po Nagar Tower Festival",
        date: lang === "vi" ? "20 - 23/3 Âm lịch" : "20th to 23rd of 3rd Lunar Month",
        location: lang === "vi" ? "Nha Trang" : "Nha Trang",
        season: lang === "vi" ? "Mùa Hạ" : "Summer",
        color: "#ff6b35",
        image: "https://images.unsplash.com/photo-1596422846543-75c6fc183f27?auto=format&fit=crop&w=600&q=80",
        desc: lang === "vi" ? "Lễ hội lớn nhất miền Trung tôn vinh Mẹ Xứ Sở (Thiên Y Thánh Mẫu)." : "The largest festival in Central Vietnam honoring the Mother of the Realm."
      },
      {
        id: 5,
        month: "06",
        title: lang === "vi" ? "Festival Huế" : "Hue Festival",
        date: lang === "vi" ? "Tháng 6 Dương lịch" : "June (Biennial)",
        location: lang === "vi" ? "Huế" : "Hue",
        season: lang === "vi" ? "Mùa Hạ" : "Summer",
        color: "#9b5de5",
        image: "https://images.unsplash.com/photo-1559592413-7ece759ca441?auto=format&fit=crop&w=600&q=80",
        desc: lang === "vi" ? "Lễ hội văn hóa nghệ thuật quy mô quốc tế tại Cố đô Huế xinh đẹp." : "A grand international cultural and artistic festival in the beautiful Imperial City."
      },
      {
        id: 6,
        month: "08",
        title: lang === "vi" ? "Tết Trung Thu" : "Mid-Autumn Festival",
        date: lang === "vi" ? "15/8 Âm lịch" : "15th Day of 8th Lunar Month",
        location: lang === "vi" ? "Toàn quốc" : "Nationwide",
        season: lang === "vi" ? "Mùa Thu" : "Autumn",
        color: "#fb5607",
        image: "https://images.unsplash.com/photo-1571407970349-bc81e7e96d47?auto=format&fit=crop&w=600&q=80",
        desc: lang === "vi" ? "Lễ hội trăng rằm rực rỡ lồng đèn và tiếng trống lân rộn rã." : "A vibrant full-moon festival with lanterns and joyous lion dances."
      },
      {
        id: 7,
        month: "10",
        title: lang === "vi" ? "Lễ hội Ok Om Bok" : "Ok Om Bok Festival",
        date: lang === "vi" ? "Tháng 10 Âm lịch" : "10th Lunar Month",
        location: lang === "vi" ? "Trà Vinh, Sóc Trăng" : "Tra Vinh, Soc Trang",
        season: lang === "vi" ? "Mùa Thu" : "Autumn",
        color: "#6a4c93",
        image: "https://images.unsplash.com/photo-1585223126786-9316d5ba4b17?auto=format&fit=crop&w=600&q=80",
        desc: lang === "vi" ? "Lễ cúng trăng truyền thống của người Khmer Nam Bộ với đua ghe Ngo." : "Traditional moon worship of the Khmer people with dragon boat racing."
      },
      {
        id: 8,
        month: "12",
        title: lang === "vi" ? "Lễ hội Hoa" : "Flower Festival",
        date: lang === "vi" ? "Cuối năm Dương lịch" : "Late December",
        location: lang === "vi" ? "Đà Lạt" : "Da Lat",
        season: lang === "vi" ? "Mùa Đông" : "Winter",
        color: "#00b4d8",
        image: "https://images.unsplash.com/photo-1520114056694-91897e93da27?auto=format&fit=crop&w=600&q=80",
        desc: lang === "vi" ? "Tôn vinh vẻ đẹp ngàn hoa và khí hậu đặc trưng của thành phố ngàn thông." : "Honoring the beauty of thousands of flowers and the characteristic climate of Da Lat."
      },
    ],
  };
};

import { useEffect, useMemo, useState } from 'react'
import { Link } from 'react-router-dom'
import './RegionsPage.css'
import { getRegions } from '../../services/region.service'
import { getProvinces } from '../../services/province.service'
import { ui } from '../../i18n/messages'

import VietnamMap from '../../components/features/regions/VietnamMap'
import PageHeader from '../../components/layout/PageHeader/PageHeader'
import Footer from '../../components/layout/Footer/Footer'

// Import Region Overviews
import imgOverviewNorth from '../../assets/images/regions/region_overview_north.png'
import imgOverviewCentral from '../../assets/images/regions/region_overview_central.png'
import imgOverviewSouth from '../../assets/images/regions/region_overview_south.png'

// Import Provinces
import imgProvHaGiang from '../../assets/images/regions/province_hagiang.png'
import imgProvCaoBang from '../../assets/images/regions/province_caobang.png'
import imgProvLaiChau from '../../assets/images/regions/province_laichau.png'
import imgProvLaoCai from '../../assets/images/regions/province_laocai.png'
import imgProvDienBien from '../../assets/images/regions/province_dienbien.png'
import imgProvSonLa from '../../assets/images/regions/province_sonla.png'

// Import Highlights
import imgHlHanoi from '../../assets/images/regions/highlight_hanoi.png'
import imgHlSapa from '../../assets/images/regions/highlight_sapa.png'
import imgHlTrangAn from '../../assets/images/regions/highlight_trangan.png'
import imgHlHue from '../../assets/images/regions/highlight_hue.png'
import imgHlHoiAn from '../../assets/images/regions/highlight_hoian.png'
import imgHlDaNang from '../../assets/images/regions/highlight_danang.png'
import imgHlCanTho from '../../assets/images/regions/highlight_cantho.png'
import imgHlNamBo from '../../assets/images/regions/highlight_nambo.png'

// Import Hero BG
import imgHeroBg from '../../assets/images/regions/regions_hero_bg.png'

const regionMeta = {
  vi: [
    {
      key: 'north',
      badge: 'Miền Bắc',
      mapLabel: 'Bắc Bộ',
      headline: 'Sắc màu núi rừng và di sản ngàn năm',
      description: 'Từ Hà Nội, vịnh Hạ Long đến những cung đường Tây Bắc, miền Bắc mang đậm chiều sâu lịch sử và thiên nhiên hùng vĩ.',
      highlights: ['Hà Nội', 'Hạ Long', 'Sa Pa'],
      experiences: 'Núi non hùng vĩ, văn hóa bản địa, ẩm thực tinh tế',
      atmosphere: 'Cổ kính, đậm đà bản sắc, nhịp sống chậm rãi'
    },
    {
      key: 'central',
      badge: 'Miền Trung',
      mapLabel: 'Trung Bộ',
      headline: 'Dải đất di sản giữa biển và núi',
      description: 'Vùng đất giao thoa giữa di sản, biển xanh và chiều sâu lịch sử tạo nên một bản sắc rất riêng trong hành trình khám phá Việt Nam.',
      highlights: ['Huế', 'Đà Nẵng', 'Hội An'],
      experiences: 'Di sản, biển, kiến trúc cổ',
      atmosphere: 'Sâu lắng, duyên dáng, giàu chiều sâu văn hóa'
    },
    {
      key: 'south',
      badge: 'Miền Nam',
      mapLabel: 'Nam Bộ',
      headline: 'Nhịp sống sông nước và đô thị sôi động',
      description: 'Miền Nam gợi mở năng lượng trẻ trung của TP.HCM, miền Tây sông nước và các hành trình xanh phương Nam.',
      highlights: ['TP.HCM', 'Cần Thơ', 'Phú Quốc'],
      experiences: 'Sông nước mênh mông, chợ nổi, sự giao thoa văn hóa',
      atmosphere: 'Năng động, phóng khoáng, chân tình'
    },
  ],
  en: [
    {
      key: 'north',
      badge: 'Northern',
      mapLabel: 'North',
      headline: 'Mountains, heritage, and timeless capital culture',
      description: 'Northern Vietnam blends Hanoi, Ha Long Bay, and the dramatic highlands into a region rich in history and scenery.',
      highlights: ['Hanoi', 'Ha Long', 'Sa Pa'],
      experiences: 'Majestic mountains, indigenous culture, refined cuisine',
      atmosphere: 'Ancient, rich in identity, slow-paced life'
    },
    {
      key: 'central',
      badge: 'Central',
      mapLabel: 'Central',
      headline: 'A heritage corridor between coast and mountains',
      description: 'A land where heritage, blue seas, and historical depth intersect, creating a very unique identity in the journey to discover Vietnam.',
      highlights: ['Hue', 'Da Nang', 'Hoi An'],
      experiences: 'Heritage, beaches, ancient architecture',
      atmosphere: 'Profound, graceful, culturally rich'
    },
    {
      key: 'south',
      badge: 'Southern',
      mapLabel: 'South',
      headline: 'River life, tropical islands, and modern energy',
      description: 'Southern Vietnam combines Ho Chi Minh City, Mekong Delta experiences, and vibrant journeys across the south.',
      highlights: ['Ho Chi Minh City', 'Can Tho', 'Phu Quoc'],
      experiences: 'Vast rivers, floating markets, cultural intersection',
      atmosphere: 'Dynamic, liberal, sincere'
    },
  ],
}

function mergeRegionContent(listRegions, lang) {
  const meta = regionMeta[lang] || regionMeta.vi
  const baseItems = listRegions.slice(0, 3).map((item) => ({
    ...item,
    title: item.name,
    description: item.type,
  }))

  return meta.map((item, index) => {
    const region = baseItems[index] || listRegions[index] || {}
    return {
      ...item,
      ...region,
      title: region.title || region.name || item.badge,
      description: region.description || item.description,
      imageAlt: region.imageAlt || region.title || region.name || item.badge,
      mapLabel: item.mapLabel,
      highlights: item.highlights,
    }
  })
}

const overviewRegions = [
  {
    id: 'north',
    badge: 'Miền Bắc',
    title: 'Nơi mây núi tích tụ từng lớp lịch sử',
    desc: 'Miền Bắc mang trong mình sự trầm lắng, kín đáo như tầng tầng lớp lớp ruộng bậc thang. Từ thủ đô nghìn năm văn hiến đến những bản làng cao nguyên, mỗi góc đất đều thấm đượm hồn văn hiến và sức sống bền bỉ của con người vùng núi.',
    details: [
      { label: 'CẢNH QUAN ĐẶC TRƯNG', value: 'Ruộng bậc thang Mù Cang Chải, núi non Hà Giang, vịnh Hạ Long, Ninh Bình tiên cảnh, đồng bằng sông Hồng' },
      { label: 'NÉT ẨM THỰC', value: 'Phở Hà Nội, bún chả, nem rán, bánh cuốn, cà phê trứng, đặc sản vùng cao' },
      { label: 'LỄ HỘI TIÊU BIỂU', value: 'Hội Lim, Chùa Hương, Lễ hội Đền Hùng, Tết Nguyên Đán, Hội Gióng' },
      { label: 'NGHỆ THUẬT & THỦ CÔNG', value: 'Gốm Bát Tràng, lụa Vạn Phúc, tranh Đông Hồ, ca trù, quan họ Bắc Ninh' }
    ],
    image: imgOverviewNorth, 
    link: '/regions/bac-bo'
  },
  {
    id: 'central',
    badge: 'Miền Trung',
    title: 'Dải đất di sản giữa núi và biển',
    desc: 'Miền Trung là nơi hội tụ của núi non hùng vĩ và biển cả mênh mông. Từ cố đô Huế với hoàng cung nguy nga đến phố cổ Hội An thơ mộng, vùng đất này chứa đựng những di sản văn hoá vật thể và phi vật thể quý giá nhất của Việt Nam.',
    details: [
      { label: 'CẢNH QUAN ĐẶC TRƯNG', value: 'Cố đô Huế, phố cổ Hội An, thánh địa Mỹ Sơn, động Phong Nha, bán đảo Sơn Trà, Quy Nhơn biển xanh' },
      { label: 'NÉT ẨM THỰC', value: 'Bún bò Huế, cao lầu, mì Quảng, bánh xèo, nem lụi, ẩm thực cung đình Huế' },
      { label: 'LỄ HỘI TIÊU BIỂU', value: 'Festival Huế, Lễ hội Hoa đăng Hội An, Lễ hội Cầu Ngư, Tết Nguyên Tiêu' },
      { label: 'NGHỆ THUẬT & THỦ CÔNG', value: 'Thêu tay Huế, mộc điêu khắc, đèn lồng Hội An, tranh cát Mộc Nghệ, nhã nhạc cung đình' }
    ],
    image: imgOverviewCentral,
    link: '/regions/trung-bo'
  },
  {
    id: 'south',
    badge: 'Miền Nam',
    title: 'Vùng sông nước bao la, lòng người rộng mở',
    desc: 'Miền Nam là vùng đất của những dòng sông giao thoa, nơi nhịp sống chảy theo dòng nước. Từ Sài Gòn sôi động đến đồng bằng sông Cửu Long thơ mộng, miền Nam toát lên sự rộng mở, phóng khoáng và lòng mến khách.',
    details: [
      { label: 'CẢNH QUAN ĐẶC TRƯNG', value: 'Đồng bằng sông Cửu Long, chợ nổi Cái Răng, rừng tràm Trà Sư, Phú Quốc đảo ngọc, Côn Đảo hoang sơ' },
      { label: 'NÉT ẨM THỰC', value: 'Hủ tiếu Nam Vang, bánh tráng trộn, lẩu mắm, cá lóc nướng trui, trái cây miệt vườn, cơm tấm' },
      { label: 'LỄ HỘI TIÊU BIỂU', value: 'Lễ hội Ok Om Bok, Lễ hội Nghinh Ông, Tết Chol Chnam Thmay, Lễ hội Cầu Bông' },
      { label: 'NGHỆ THUẬT & THỦ CÔNG', value: 'Lụa Tân Châu, đan lát cói, gốm sứ Biên Hoà, đờn ca tài tử, hát bội Nam Bộ' }
    ],
    image: imgOverviewSouth,
    link: '/regions/nam-bo'
  }
];

const inspirationCards = [
  {
    title: 'Miền núi và mây',
    desc: 'Khám phá những cao nguyên mờ sương, bản làng dân tộc và những thửa ruộng bậc thang trải dài như tranh.',
    image: imgHlSapa
  },
  {
    title: 'Di sản và ký ức',
    desc: 'Những cố đô hoàng triều, đền chùa nghìn năm, kiến trúc cổ kính lưu giữ linh hồn của dân tộc.',
    image: imgHlHue
  },
  {
    title: 'Sông nước và chợ quê',
    desc: 'Nhịp sống chảy theo dòng sông, chợ nổi, lòng chài và cuộc sống gắn bó với lúa nước.',
    image: imgHlCanTho
  },
  {
    title: 'Biển xanh và làng chài',
    desc: 'Những bãi biển hoang sơ, làng chài yên bình và cuộc sống gắn liền với biển cả.',
    image: imgHlDaNang
  },
  {
    title: 'Ẩm thực địa phương',
    desc: 'Từ phở Hà Nội, bún bò Huế đến hủ tiếu Nam Vang - hành trình khám phá hương vị từng vùng miền.',
    image: imgHlHanoi
  },
  {
    title: 'Làng nghề và thủ công',
    desc: 'Khám phá các làng nghề truyền thống: gốm sứ, lụa tơ tằm, tranh dân gian và tay nghề thủ công tinh xảo.',
    image: imgHlNamBo
  }
];

const provincesData = [
  { id: 1, name: 'Hà Nội', code: 'ha-noi', desc: 'Thủ đô nghìn năm văn bản cùng phố cổ, hồ Hoàn Kiếm và nền văn hóa truyền thống đậm đà', tags: ['Phố cổ', 'Di sản', 'Ẩm thực'], region: 'Miền Bắc', image: imgHlHanoi },
  { id: 2, name: 'Huế', code: 'hue', desc: 'Cố đô với hoàng cung, lăng tẩm và ẩm thực cung đình tinh tế', tags: ['Hoàng cung', 'Di sản UNESCO', 'Văn hóa'], region: 'Miền Trung', image: imgHlHue },
  { id: 3, name: 'Hội An', code: 'hoi-an', desc: 'Phố cổ đèn lồng với kiến trúc giao thoa văn hóa Việt - Nhật - Hoa', tags: ['Phố cổ', 'Đèn lồng', 'Kiến trúc'], region: 'Miền Trung', image: imgHlHoiAn },
  { id: 4, name: 'Sapa', code: 'sapa', desc: 'Cao nguyên mờ sương với ruộng bậc thang và văn hóa dân tộc đa dạng', tags: ['Núi rừng', 'Ruộng bậc thang', 'Dân tộc'], region: 'Miền Bắc', image: imgHlSapa },
  { id: 5, name: 'Cần Thơ', code: 'can-tho', desc: 'Thủ phụ miền Tây với chợ nổi Cái Răng và vườn trái cây miệt vườn', tags: ['Chợ nổi', 'Sông nước', 'Ẩm thực'], region: 'Miền Nam', image: imgHlCanTho },
  { id: 6, name: 'Phú Quốc', code: 'phu-quoc', desc: 'Đảo ngọc với bãi biển hoang sơ, rừng nguyên sinh và hải sản tươi ngon', tags: ['Biển đảo', 'Thiên nhiên', 'Nghỉ dưỡng'], region: 'Miền Nam', image: imgHlNamBo }
];

const highlightsData = [
  { id: 1, name: 'Phố cổ Hà Nội', desc: 'Không gian cổ kính, nhịp sống chậm rãi và chiều sâu lịch sử tạo nên sức hút rất riêng...', region: 'Miền Bắc', tag: 'Thiên nhiên', image: imgHlHanoi },
  { id: 2, name: 'Ruộng bậc thang Sa Pa', desc: 'Vẻ đẹp thiên nhiên hùng vĩ cùng đời sống bản địa tạo nên trải nghiệm khó quên...', region: 'Miền Bắc', tag: 'Thiên nhiên', image: imgHlSapa },
  { id: 3, name: 'Tràng An Ninh Bình', desc: 'Cảnh quan núi non hùng vĩ và dòng sông uốn lượn tạo nên bức tranh thiên nhiên tuyệt mỹ...', region: 'Miền Bắc', tag: 'Di sản', image: imgHlTrangAn },
  { id: 4, name: 'Cố đô Huế', desc: 'Di sản, ẩm thực và cảnh sắc cùng tôn lên câu chuyện rất riêng của vùng đất này...', region: 'Miền Trung', tag: 'Cố đô', image: imgHlHue },
  { id: 5, name: 'Phố cổ Hội An', desc: 'Ánh đèn lồng lung linh và kiến trúc cổ kính tạo nên không gian thơ mộng độc đáo...', region: 'Miền Trung', tag: 'Phố cổ', image: imgHlHoiAn },
  { id: 6, name: 'Biển Đà Nẵng', desc: 'Bờ biển trải dài cùng không gian hiện đại mang đến trải nghiệm nghỉ dưỡng hoàn hảo...', region: 'Miền Trung', tag: 'Biển', image: imgHlDaNang },
  { id: 7, name: 'Chợ nổi Cần Thơ', desc: 'Nhịp sống sông nước sôi động và màu sắc rực rỡ của miền Tây Nam Bộ...', region: 'Miền Nam', tag: 'Sông nước', image: imgHlCanTho },
  { id: 8, name: 'Miệt vườn Nam Bộ', desc: 'Đời sống bình yên giữa vườn trái cây trĩu quả và dòng sông hiền hòa...', region: 'Miền Nam', tag: 'Đời sống', image: imgHlNamBo },
  { id: 9, name: 'Phú Quốc biển đảo', desc: 'Thiên đường biển xanh cát trắng với vẻ đẹp hoang sơ quyến rũ...', region: 'Miền Nam', tag: 'Biển đảo', image: imgHlDaNang }
];
const seasonsData = [
  {
    id: 'spring',
    title: 'Mùa xuân',
    months: 'THÁNG 1 - 3',
    desc: 'Hoa nở, lễ hội Tết, không khí tươi mới.',
    details: [
      { region: 'Miền Bắc', text: 'Hoa đào, mai nở rộ' },
      { region: 'Miền Trung', text: 'Tiết trời ấm áp' },
      { region: 'Miền Nam', text: 'Vườn trái cây đầu mùa' }
    ],
    image: imgHlTrangAn
  },
  {
    id: 'summer',
    title: 'Mùa hè',
    months: 'THÁNG 4 - 6',
    desc: 'Biển xanh, núi mát, lễ hội mùa màng.',
    details: [
      { region: 'Miền Bắc', text: 'Mùa lúa xanh' },
      { region: 'Miền Trung', text: 'Biển đẹp nhất năm' },
      { region: 'Miền Nam', text: 'Trái cây chín rộ' }
    ],
    image: imgOverviewSouth
  },
  {
    id: 'autumn',
    title: 'Mùa thu',
    months: 'THÁNG 7 - 9',
    desc: 'Lúa chín vàng, trời trong xanh, se se lạnh.',
    details: [
      { region: 'Miền Bắc', text: 'Mùa lúa chín vàng' },
      { region: 'Miền Trung', text: 'Mùa mưa bão' },
      { region: 'Miền Nam', text: 'Nước nổi đồng bằng' }
    ],
    image: imgProvLaoCai
  },
  {
    id: 'winter',
    title: 'Mùa đông',
    months: 'THÁNG 10 - 12',
    desc: 'Sương mù, se lạnh, không khí tĩnh lặng.',
    details: [
      { region: 'Miền Bắc', text: 'Sương mù, băng giá Sapa' },
      { region: 'Miền Trung', text: 'Nắng ấm dần' },
      { region: 'Miền Nam', text: 'Khô ráo, dễ chịu' }
    ],
    image: imgProvHaGiang
  }
];

const culturalCategories = [
  { id: 'culinary', title: 'Ẩm thực', icon: '🍴', desc: 'Từ phở Bắc, bún Huế đến hủ tiếu Nam - ẩm thực là linh hồn vùng miền' },
  { id: 'festival', title: 'Lễ hội', icon: '🏮', desc: 'Tết Nguyên Đán, Festival Huế, lễ hội đền chùa - văn hóa tín ngưỡng đa dạng' },
  { id: 'architecture', title: 'Kiến trúc', icon: '🏠', desc: 'Từ nhà sàn, nhà rường đến kiến trúc cung đình và phố cổ' },
  { id: 'craft', title: 'Nghệ thủ công', icon: '🎨', desc: 'Gốm sứ, lụa tơ tằm, tranh dân gian - tay nghề tinh xảo qua thế hệ' },
  { id: 'music', title: 'Âm nhạc dân gian', icon: '🎻', desc: 'Ca trù, quan họ, đờn ca tài tử - điệu nhạc của từng vùng miền' },
  { id: 'custom', title: 'Phong tục', icon: '🧺', desc: 'Tục lệ cưới hỏi, tang lễ, lễ nghi - giá trị truyền thống' },
  { id: 'fashion', title: 'Trang phục', icon: '👗', desc: 'Áo dài, áo tứ thân, trang phục dân tộc - bản sắc qua trang phục' },
  { id: 'community', title: 'Sinh hoạt cộng đồng', icon: '👥', desc: 'Làng xã, hội làng, tương thân tương ái - tinh thần cộng đồng' }
];

const filterOptions = [
  { id: 'all', label: 'Tất cả' },
  { id: 'regions', label: 'Vùng miền' },
  { id: 'nature', label: 'Thiên nhiên' },
  { id: 'heritage', label: 'Di sản' },
  { id: 'food', label: 'Ẩm thực' },
  { id: 'sea', label: 'Biển đảo' },
  { id: 'mountains', label: 'Núi rừng' },
  { id: 'oldtown', label: 'Phố cổ' },
  { id: 'craft', label: 'Làng nghề' }
];

export default function RegionsPage() {
  const [lang, setLang] = useState('vi')
  const [state, setState] = useState({ status: 'loading', data: null, error: '' })
  const [activeKey, setActiveKey] = useState('north')
  const [searchQuery, setSearchQuery] = useState('')
  const [activeFilter, setActiveFilter] = useState('all')
  const [provinceState, setProvinceState] = useState({ status: 'loading', data: [], error: '' })
  const copy = useMemo(() => ui[lang], [lang])

  function handleSelectRegion(regionKey) {
    setActiveKey(regionKey)
  }

  useEffect(() => {
    let ignore = false

    async function loadRegions() {
      try {
        setState({ status: 'loading', data: null, error: '' })
        const regions = await getRegions(lang)
        if (!ignore) {
          setState({ status: 'success', data: { regions }, error: '' })
          document.documentElement.lang = lang
          document.title = lang === 'vi' ? 'VietCultura - Khám phá vùng miền' : 'VietCultura - Explore regions'
        }
      } catch (error) {
        if (!ignore) {
          setState({ status: 'error', data: null, error: error.message })
        }
      }
    }

    async function loadProvinces() {
      try {
        setProvinceState({ status: 'loading', data: [], error: '' })
        const provinces = await getProvinces(lang)
        if (!ignore) {
          setProvinceState({ status: 'success', data: provinces.slice(0, 6), error: '' })
        }
      } catch (error) {
        if (!ignore) {
          setProvinceState({ status: 'error', data: provincesData, error: error.message })
        }
      }
    }

    loadRegions()
    loadProvinces()
    return () => { ignore = true }
  }, [lang])

  const isLoading = state.status === 'loading'
  const isError = state.status === 'error'

  const regions = state.data?.regions || []
  const mappedRegions = mergeRegionContent(regions, lang)
  const fallbackRegion = regionMeta[lang]?.[0] || regionMeta.vi[0]
  const activeRegion = mappedRegions.find((item) => item.key === activeKey) || mappedRegions[0] || fallbackRegion

  return (
    <div className="page-shell">
      <PageHeader
        lang={lang}
        onLangChange={setLang}
        breadcrumb={[
          { label: lang === 'vi' ? 'Khám phá vùng miền' : 'Explore Regions' },
        ]}
      />

      <main className="regions-page">
        <section className="regions-hero">
        <div className="regions-hero__bg">
          <img src={imgHeroBg} alt="Vietnam Cultural Heritage" />
          <div className="regions-hero__overlay"></div>
        </div>
        
        <div className="regions-hero__content fade-up">
          <div className="regions-hero__badge">
            <span className="regions-hero__badge-icon">✨</span>
            <span>{lang === 'vi' ? 'Hành trình qua những miền đất Việt' : 'A journey through Vietnamese lands'}</span>
          </div>
          
          <h1 className="regions-hero__title">
            {lang === 'vi' ? 'Khám phá vùng miền' : 'Discover the Regions of'}
            <span className="regions-hero__title-accent"> {lang === 'vi' ? 'Việt Nam' : 'Vietnam'}</span>
          </h1>
          
          <p className="regions-hero__desc">
            {lang === 'vi' 
              ? 'Mỗi vùng đất là một nịp sống, một lớp ký ức, một sắc màu văn hoá riêng đang chờ được cảm nhận.'
              : 'Each land is a heartbeat, a layer of memory, a unique cultural color waiting to be felt.'}
          </p>
          
          <div className="regions-hero__actions">
            <button 
              className="regions-hero__btn regions-hero__btn--primary"
              onClick={() => document.querySelector('.regions-split-layout')?.scrollIntoView({ behavior: 'smooth' })}
            >
              {lang === 'vi' ? 'Khám phá ngay' : 'Explore Now'} 
              <span className="btn-icon">→</span>
            </button>
            <button 
              className="regions-hero__btn regions-hero__btn--secondary"
              onClick={() => document.querySelector('.regions-split-layout__map')?.scrollIntoView({ behavior: 'smooth' })}
            >
              <span className="btn-icon">🗺️</span>
              {lang === 'vi' ? 'Xem bản đồ vùng miền' : 'View Region Map'}
            </button>
          </div>
        </div>

        <div className="regions-hero__categories fade-up-delayed">
          {[
            { vi: 'Di sản đặc sắc', en: 'Unique Heritage' },
            { vi: 'Ẩm thực bản địa', en: 'Local Cuisine' },
            { vi: 'Lễ hội bốn mùa', en: 'Four Seasons Festivals' },
            { vi: 'Bản sắc cộng đồng', en: 'Community Identity' }
          ].map((cat, idx) => (
            <div key={idx} className="hero-category-tag">
              {lang === 'vi' ? cat.vi : cat.en}
            </div>
          ))}
        </div>
      </section>

      <div className="regions-page__shell">
        <div className="regions-split-layout fade-up">
          <div className="regions-split-layout__map">
            {isLoading ? <div className="regions-loading-inline">{copy.loading}</div> : null}
            {isError ? <div className="regions-loading-inline regions-loading-inline--error">{copy.error}</div> : null}
            <h2>{lang === 'vi' ? 'Bản đồ văn hóa' : 'Cultural map'}</h2>
            <p className="regions-split-layout__map-desc">{lang === 'vi'
              ? 'Chạm hoặc rê chuột vào từng vùng để khám phá những nét văn hóa đặc trưng từ Bắc chí Nam.'
              : 'Hover or tap each region to explore the cultural identity of Vietnam from north to south.'}</p>
            <VietnamMap
              activeKey={activeKey}
              onSelectRegion={handleSelectRegion}
              lang={lang}
            />
          </div>

          <div className="regions-split-layout__content">
            <div className="region-card-wrapper">
              <div className="region-tabs">
                {mappedRegions.map((item) => (
                  <button
                    key={item.key}
                    type="button"
                    className={`region-tab ${activeKey === item.key ? 'is-active' : ''}`}
                    onClick={() => handleSelectRegion(item.key)}
                  >
                    {item.badge}
                  </button>
                ))}
              </div>

              <div className="region-card">
                <div className="region-card__header">
                  <span className="region-card__decorator"></span>
                  <h2>{activeRegion.badge}</h2>
                </div>

                <p className="region-card__desc">{activeRegion.description}</p>

                <div className="region-card__details">
                  <div className="region-card__detail-item">
                    <div className="region-card__detail-icon">
                      <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z"></path><circle cx="12" cy="10" r="3"></circle></svg>
                    </div>
                    <div className="region-card__detail-text">
                      <strong>{lang === 'vi' ? 'Điểm đến nổi bật' : 'Highlighted Destinations'}</strong>
                      <span>{(activeRegion.highlights || []).join(', ')}</span>
                    </div>
                  </div>

                  <div className="region-card__detail-item">
                    <div className="region-card__detail-icon">
                      <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2"></polygon></svg>
                    </div>
                    <div className="region-card__detail-text">
                      <strong>{lang === 'vi' ? 'Trải nghiệm đặc trưng' : 'Signature Experiences'}</strong>
                      <span>{activeRegion.experiences}</span>
                    </div>
                  </div>

                  <div className="region-card__detail-item">
                    <div className="region-card__detail-icon">
                      <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><circle cx="12" cy="12" r="5"></circle><line x1="12" y1="1" x2="12" y2="3"></line><line x1="12" y1="21" x2="12" y2="23"></line><line x1="4.22" y1="4.22" x2="5.64" y2="5.64"></line><line x1="18.36" y1="18.36" x2="19.78" y2="19.78"></line><line x1="1" y1="12" x2="3" y2="12"></line><line x1="21" y1="12" x2="23" y2="12"></line><line x1="4.22" y1="19.78" x2="5.64" y2="18.36"></line><line x1="18.36" y1="5.64" x2="19.78" y2="4.22"></line></svg>
                    </div>
                    <div className="region-card__detail-text">
                      <strong>{lang === 'vi' ? 'Không khí' : 'Atmosphere'}</strong>
                      <span>{activeRegion.atmosphere}</span>
                    </div>
                  </div>
                </div>

                <div className="region-card__actions">
                  <Link to={`/regions/${activeRegion.code || ''}`} className="region-card__btn">
                    {lang === 'vi' ? 'Xem chi tiết vùng miền' : 'Explore this region'} →
                  </Link>
                </div>
              </div>
            </div>
          </div>
        </div>

        <section className="regions-overview-section">
          <div className="regions-overview__header fade-up">
            <h2>{lang === 'vi' ? 'Câu chuyện từng vùng đất' : 'Stories of every land'}</h2>
            <p>{lang === 'vi' 
              ? 'Mỗi vùng miền là một bản giao hưởng văn hoá riêng, được tạo nên từ phong cảnh, ẩm thực, lễ hội và tâm hồn con người.' 
              : 'Each region is a unique cultural symphony, created from landscape, cuisine, festivals, and human soul.'}
            </p>
          </div>
          <div className="regions-overview__container fade-up">
            {overviewRegions.map((region, idx) => {
              const isReversed = idx % 2 !== 0;
              return (
                <div key={region.id} className={`regions-overview__card ${isReversed ? 'is-reversed' : ''}`}>
                  <div className="regions-overview__image-col">
                    <div className="regions-overview__image">
                      {region.image ? (
                        <img src={region.image} alt={region.title} />
                      ) : (
                        <div className="placeholder-image">Ảnh {region.badge}</div>
                      )}
                    </div>
                  </div>
                  <div className="regions-overview__content-col">
                    <span className="regions-overview__badge">{region.badge}</span>
                    <h3 className="regions-overview__title">{region.title}</h3>
                    <p className="regions-overview__desc">{region.desc}</p>
                    
                    <div className="regions-overview__details">
                      {(region.details || []).map((detail, dIdx) => (
                        <div key={dIdx} className="regions-overview__detail-row">
                          <span className="regions-overview__detail-label">{detail.label}</span>
                          <span className="regions-overview__detail-value">{detail.value}</span>
                        </div>
                      ))}
                    </div>

                    <Link to={region.link || "/provinces"} className="regions-overview__cta-btn">
                      {lang === 'vi' ? 'Xem sâu hơn' : 'View more'} <span aria-hidden="true">→</span>
                    </Link>
                  </div>
                </div>
              );
            })}
          </div>
          <div className="section-view-all">
            <Link to="/regions" className="provinces__button view-all-btn">Xem tất cả vùng miền →</Link>
          </div>
        </section>

        {/* Section 2: Inspiration Section */}
        <section className="inspiration-section">
          <div className="inspiration__container fade-up">
            <div className="inspiration__header">
              <h2>{lang === 'vi' ? 'Khám phá theo cảm hứng' : 'Explore by Inspiration'}</h2>
              <p>{lang === 'vi' 
                ? 'Hãy để trái tim dẫn lối - chọn những chủ đề để gợi cảm xúc và khám phá vùng đất phù hợp với tâm trạng của bạn.'
                : 'Let your heart lead the way - choose themes to evoke emotions and discover land that fits your mood.'}
              </p>
            </div>
            
            <div className="inspiration__grid">
              {inspirationCards.map((card, idx) => (
                <div key={idx} className="inspiration-card">
                  <div className="inspiration-card__bg">
                    <img src={card.image} alt={card.title} />
                    <div className="inspiration-card__overlay"></div>
                  </div>
                  <div className="inspiration-card__content">
                    <h3>{card.title}</h3>
                    <p>{card.desc}</p>
                  </div>
                </div>
              ))}
            </div>
          </div>
        </section>

        {/* Section: Searchable Provinces */}
        <section className="provinces-search-section">
          <div className="provinces-search__container fade-up">
            <div className="provinces-search__header">
              <h2>Từ vùng miền đến từng tỉnh thành</h2>
              <p>Khám phá chi tiết từng điểm đến, lên kế hoạch hành trình riêng của bạn.</p>
            </div>

            <div className="provinces-search__controls">
              <div className="search-bar-wrapper">
                <span className="search-icon">🔍</span>
                <input 
                  type="text" 
                  placeholder="Tìm tỉnh, thành phố..." 
                  value={searchQuery}
                  onChange={(e) => setSearchQuery(e.target.value)}
                />
              </div>

              <div className="filter-chips">
                <span className="filter-label">📍 Lọc theo:</span>
                {filterOptions.map(filter => (
                  <button 
                    key={filter.id}
                    className={`filter-chip ${activeFilter === filter.id ? 'is-active' : ''}`}
                    onClick={() => setActiveFilter(filter.id)}
                  >
                    {filter.label}
                  </button>
                ))}
              </div>
            </div>

            <div className="provinces-search__grid">
              {(provinceState.data.length ? provinceState.data : provincesData)
                .filter((p) => p.name.toLowerCase().includes(searchQuery.toLowerCase()))
                .map((prov) => (
                  <div key={prov.id} className="province-item-card">
                    <div className="province-item__image">
                      {prov.imageUrl || prov.image ? (
                        <img src={prov.imageUrl || prov.image} alt={prov.name} />
                      ) : (
                        <div className="province-item__placeholder">Ảnh {prov.name}</div>
                      )}
                      <span className="province-item__badge">{prov.region}</span>
                    </div>
                    <div className="province-item__content">
                      <div className="province-item__title-row">
                        <h3>{prov.name}</h3>
                        <span className="location-icon">📍</span>
                      </div>
                      <p className="province-item__desc">{prov.desc || `${prov.type} thuộc ${prov.subRegion}`}</p>
                      <div className="province-item__tags">
                        {(prov.tags || []).map((tag) => (
                          <span key={tag} className="province-item__tag">{tag}</span>
                        ))}
                      </div>
                      <Link to={`/provinces/${prov.code}`} className="province-item__cta">Xem chi tiết <span aria-hidden="true">→</span></Link>
                    </div>
                  </div>
                ))}
            </div>

            <div className="provinces-search__footer">
              <Link to="/provinces" className="view-all-provinces-btn">Xem thêm tỉnh thành</Link>
            </div>
          </div>
        </section>

        {/* Section: Seasons Showcase */}
        <section className="seasons-section">
          <div className="seasons__container fade-up">
            <div className="seasons__header">
              <h2>Vẻ đẹp theo mùa</h2>
              <p>Mỗi mùa mang một sắc thái riêng, khám phá vùng miền Việt Nam qua bốn mùa thay đổi.</p>
            </div>
            
            <div className="seasons__grid">
              {seasonsData.map(season => (
                <div key={season.id} className="season-card">
                  <div className="season-card__bg">
                    <img src={season.image} alt={season.title} />
                    <div className="season-card__overlay"></div>
                  </div>
                  <div className="season-card__content">
                    <div className="season-card__top">
                      <h3>{season.title}</h3>
                      <span className="season-card__months">{season.months}</span>
                    </div>
                    <p className="season-card__desc">{season.desc}</p>
                    <div className="season-card__details">
                      {season.details.map((d, i) => (
                        <div key={i} className="season-card__detail-item">
                          <strong>{d.region}:</strong> {d.text}
                        </div>
                      ))}
                    </div>
                  </div>
                </div>
              ))}
            </div>
          </div>
        </section>

        {/* Section: Cultural Layers */}
        <section className="cultural-layers-section">
          <div className="cultural-layers__container fade-up">
            <div className="cultural-layers__header">
              <h2>Những lớp văn hoá tạo nên một vùng đất</h2>
              <p>Văn hoá không phải một khối đơn thuần mà là sự giao thoa của nhiều chiều kích - từ ẩm thực, lễ hội, kiến trúc đến nghệ thuật và phong tục.</p>
            </div>

            <div className="cultural-layers__grid">
              {culturalCategories.map(cat => (
                <div key={cat.id} className="culture-layer-card">
                  <div className="culture-layer__icon-box">{cat.icon}</div>
                  <h3>{cat.title}</h3>
                  <p>{cat.desc}</p>
                </div>
              ))}
            </div>

            <div className="cultural-layers__summary">
              <p>"Mỗi vùng đất là một bản giao hưởng văn hoá"</p>
              <span>Khám phá chi tiết từng chiều kích văn hoá để hiểu sâu hơn về tinh thần và bản sắc của từng vùng miền Việt Nam.</span>
            </div>
          </div>
        </section>
      </div>
      </main>

      <Footer lang={lang} />
    </div>
  )
}

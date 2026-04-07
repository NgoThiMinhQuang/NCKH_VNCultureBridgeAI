import { useState, useMemo } from 'react'
import PageHeader from '../../components/layout/PageHeader/PageHeader'
import Footer from '../../components/layout/Footer/Footer'
import BlogHero from '../../components/blog/BlogHero/BlogHero'
import FeaturedArticles from '../../components/blog/FeaturedArticles/FeaturedArticles'
import BlogSectionMain from '../../components/blog/BlogSectionMain/BlogSectionMain'
import SectionHeading from '../../components/common/SectionHeading/SectionHeading'
import CardGrid from '../../components/common/CardGrid/CardGrid'
import { ui } from '../../i18n/messages'
import './BlogPage.css'

/**
 * BlogPage component.
 * Displays the blog hero and a collection of blog posts.
 */
export default function BlogPage() {
  const [lang, setLang] = useState('vi')
  const copy = useMemo(() => ui[lang], [lang])

  // Mock blog post data (in a real app, this would come from a service)
  const blogPosts = [
    {
      id: 1,
      code: 'tet-nguyen-dan',
      title: lang === 'vi' ? 'Tết Nguyên Đán: Nét đẹp văn hóa truyền thống' : 'Lunar New Year: Traditional Cultural Beauty',
      description: lang === 'vi' ? 'Khám phá những phong tục tập quán và ý nghĩa thiêng liêng của ngày Tết cổ truyền.' : 'Explore the customs and sacred meaning of traditional Tet.',
      imageUrl: '/img/festivals/tet.jpg',
      category: lang === 'vi' ? 'Lễ hội' : 'Festivals',
      publishedAt: '2026-02-15',
    },
    {
      id: 2,
      code: 'ao-dai-viet-nam',
      title: lang === 'vi' ? 'Áo dài - Biểu tượng tâm hồn Việt' : 'Ao Dai - Symbol of the Vietnamese Soul',
      description: lang === 'vi' ? 'Hành trình phát triển và vẻ đẹp trường tồn của trang phục truyền thống Việt Nam.' : 'The journey of development and the enduring beauty of traditional Vietnamese attire.',
      imageUrl: '/img/arts/aodai.jpg',
      category: lang === 'vi' ? 'Nghệ thuật' : 'Arts',
      publishedAt: '2026-03-10',
    },
    {
      id: 3,
      code: 'am-thuc-hue',
      title: lang === 'vi' ? 'Tinh hoa ẩm thực Cung đình Huế' : 'Essence of Hue Royal Cuisine',
      description: lang === 'vi' ? 'Vẻ đẹp tinh tế và cầu kỳ trong từng món ăn của vùng đất Cố đô.' : 'The delicate and sophisticated beauty in every dish of the Ancient Capital.',
      imageUrl: '/img/cuisine/hue-food.jpg',
      category: lang === 'vi' ? 'Ẩm thực' : 'Cuisine',
      publishedAt: '2026-03-25',
    },
    {
      id: 4,
      code: 'hat-quan-ho',
      title: lang === 'vi' ? 'Dân ca Quan họ Bắc Ninh' : 'Quan Ho Folk Songs of Bac Ninh',
      description: lang === 'vi' ? 'Di sản văn hóa phi vật thể đại diện của nhân loại với những câu hát giao duyên tình tứ.' : 'A representative intangible cultural heritage of humanity with romantic folk songs.',
      imageUrl: '/img/arts/quanho.jpg',
      category: lang === 'vi' ? 'Nghệ thuật' : 'Arts',
      publishedAt: '2026-03-30',
    },
    {
      id: 5,
      code: 'chu-nom',
      title: lang === 'vi' ? 'Chữ Nôm - Ký ức văn chương Việt' : 'Chu Nom - Vietnamese Literary Memory',
      description: lang === 'vi' ? 'Tìm hiểu về hệ thống chữ viết cổ của người Việt và kho tàng văn học trung đại.' : 'Learn about the ancient Vietnamese writing system and medieval literature.',
      imageUrl: '/img/arts/chunom.jpg',
      category: lang === 'vi' ? 'Nghệ thuật' : 'Arts',
      publishedAt: '2026-04-02',
      author: 'Quang Minh',
      readingTime: '5 phút'
    },
    {
      id: 6,
      code: 'vinh-ha-long',
      title: lang === 'vi' ? 'Vịnh Hạ Long: Kỳ Quan Thiên Nhiên Thế Giới' : 'Ha Long Bay: World Natural Wonder',
      description: lang === 'vi' ? 'Khám phá vẻ đẹp hùng vĩ của hàng ngàn đảo đá vôi nhô lên từ làn nước xanh ngắt.' : 'Discover the majestic beauty of thousands of limestone islands rising from the azure waters.',
      imageUrl: '/assets/banner2.jpg',
      category: lang === 'vi' ? 'Vùng miền' : 'Regions',
      publishedAt: '2026-03-08',
      author: 'Thu Hà',
      readingTime: '7 phút'
    }
  ]

  const popularPosts = [
    { id: 101, code: 'ruong-bac-thang', title: 'Ruộng Bậc Thang Sapa: Kiệt Tác Thiên Nhiên', publishedAt: '28 Tháng 2, 2026', views: '2.3k', imageUrl: '/assets/banner1.jpg' },
    { id: 102, code: 'cho-viet-nam', title: 'Chợ Việt Nam: Nhịp Sống Bình Dị', publishedAt: '25 Tháng 2, 2026', views: '1.8k', imageUrl: '/assets/banner3.jpg' },
    { id: 103, code: 'le-hoi-truyen-thong', title: 'Lễ Hội Truyền Thống Việt Nam', publishedAt: '22 Tháng 2, 2026', views: '1.5k', imageUrl: '/assets/anhtet1.PNG' },
  ]

  const trendingTopics = ['Văn hóa', 'Ẩm thực', 'Du lịch', 'Lễ hội', 'Nghệ thuật', 'Truyền thống', 'Vùng miền', 'Di sản', 'Kiến trúc', 'Làng nghề', 'Tết Nguyên Đán', 'Áo dài']

  const featuredArticles = blogPosts.slice(0, 4)
  const recentArticles = blogPosts

  return (
    <div className="blog-page">
      <PageHeader
        lang={lang}
        onLangChange={setLang}
      />

      <main>
        {/* Blog Hero Section */}
        <div className="section-layer section-layer--hero">
          <BlogHero lang={lang} />
        </div>

        {/* Featured Articles Section */}
        <div className="section-layer section-layer--featured">
          <FeaturedArticles lang={lang} articles={featuredArticles} />
        </div>

        {/* Main Content & Sidebar Section */}
        <div className="section-layer section-layer--main">
          <BlogSectionMain 
            lang={lang} 
            articles={recentArticles} 
            popularPosts={popularPosts}
            trendingTopics={trendingTopics}
          />
        </div>
      </main>

      <Footer lang={lang} />
    </div>
  )
}

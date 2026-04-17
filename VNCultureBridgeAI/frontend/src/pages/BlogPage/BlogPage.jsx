import { useState, useMemo, useEffect, useRef } from 'react'
import { getBlogOverview } from '../../services/blog.service'
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
  const [currentPage, setCurrentPage] = useState(1)
  const resultsRef = useRef(null)
  const [blogData, setBlogData] = useState({
    featured: [],
    recent: [],
    popular: [],
    trending: [],
    pagination: {
      totalItems: 0,
      totalPages: 1,
      currentPage: 1,
      itemsPerPage: 6
    }
  })
  const [loading, setLoading] = useState(true)

  useEffect(() => {
    let isMounted = true
    const fetchData = async () => {
      setLoading(true)
      try {
        const data = await getBlogOverview(lang, currentPage, 6)
        if (isMounted) {
          setBlogData(data)
        }
      } catch (error) {
        console.error('Error fetching blog data:', error)
      } finally {
        if (isMounted) setLoading(false)
      }
    }

    fetchData()
    return () => { isMounted = false }
  }, [lang, currentPage])

  // Precise scrolling after data is loaded and DOM is ready
  useEffect(() => {
    if (!loading && currentPage > 1 && resultsRef.current) {
      const yOffset = -100 // Sticky header offset
      const element = resultsRef.current
      const y = element.getBoundingClientRect().top + window.pageYOffset + yOffset
      
      window.scrollTo({ top: y, behavior: 'smooth' })
    }
  }, [loading, currentPage])

  const handlePageChange = (newPage) => {
    setCurrentPage(newPage)
  }

  const featuredArticles = blogData.featured
  const recentArticles = blogData.recent
  const popularPosts = blogData.popular
  const trendingTopics = blogData.trending

  if (loading) {
    return (
      <div className="blog-page is-loading">
        <PageHeader lang={lang} onLangChange={setLang} breadcrumb={[{ label: '...' }]} />
        <div className="blog-loading-spinner">
          <div className="spinner-accent"></div>
          <p>{lang === 'vi' ? 'Đang tải bài viết...' : 'Loading articles...'}</p>
        </div>
        <Footer lang={lang} />
      </div>
    )
  }

  return (
    <div className="blog-page">
      <PageHeader
        lang={lang}
        onLangChange={setLang}
        breadcrumb={[
          { label: lang === 'vi' ? 'Bài viết văn hóa' : 'Cultural Articles' },
        ]}
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
        <div className="section-layer section-layer--main" ref={resultsRef}>
          <BlogSectionMain
            lang={lang}
            articles={recentArticles}
            popularPosts={popularPosts}
            trendingTopics={trendingTopics}
            pagination={blogData.pagination}
            onPageChange={handlePageChange}
          />
        </div>
      </main>

      <Footer lang={lang} />
    </div>
  )
}

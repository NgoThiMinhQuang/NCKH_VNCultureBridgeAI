import { BrowserRouter, Route, Routes } from 'react-router-dom'
import HomePage from '../pages/HomePage/HomePage'
import ArticleDetailPage from '../pages/ArticleDetailPage/ArticleDetailPage'
import RegionsPage from '../pages/RegionsPage/RegionsPage'
import RegionDetailPage from '../pages/RegionDetailPage/RegionDetailPage'
import EthnicityDetailPage from '../pages/EthnicityDetailPage/EthnicityDetailPage'
import AIGuidePage from '../pages/AIGuidePage/AIGuidePage'
import ArticlePage from '../pages/ArticlePage/ArticlePage'
import FestivalsPage from '../pages/FestivalsPage/FestivalsPage'

/**
 * Cấu hình routing tập trung của ứng dụng.
 * Thêm route mới tại đây.
 */
export default function AppRouter() {
  return (
    <BrowserRouter>
      <Routes>
        <Route path="/" element={<HomePage />} />
        <Route path="/articles/:code" element={<ArticleDetailPage />} />
        <Route path="/regions" element={<RegionsPage />} />
        <Route path="/regions/:code" element={<RegionDetailPage />} />
        <Route path="/ethnic-groups/:code" element={<EthnicityDetailPage />} />
        <Route path="/ai-guide" element={<AIGuidePage />} />
        <Route path="/articles" element={<ArticlePage />} />
        <Route path="/festivals" element={<FestivalsPage />} />
      </Routes>
    </BrowserRouter>
  )
}

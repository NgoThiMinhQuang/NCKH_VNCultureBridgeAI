import { BrowserRouter, Route, Routes } from 'react-router-dom'
import HomePage from '../pages/HomePage/HomePage'
import ArticleDetailPage from '../pages/ArticleDetailPage/ArticleDetailPage'
import RegionsPage from '../pages/RegionsPage/RegionsPage'
import RegionDetailPage from '../pages/RegionDetailPage/RegionDetailPage'
import EthnicityDetailPage from '../pages/EthnicityDetailPage/EthnicityDetailPage'
import AIGuidePage from '../pages/AIGuidePage/AIGuidePage'

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
      </Routes>
    </BrowserRouter>
  )
}

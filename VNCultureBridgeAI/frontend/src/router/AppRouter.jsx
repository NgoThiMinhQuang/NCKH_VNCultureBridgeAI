import { BrowserRouter, Route, Routes } from "react-router-dom";
import HomePage from "../pages/HomePage/HomePage";
import ArticleDetailPage from "../pages/ArticleDetailPage/ArticleDetailPage";
import RegionsPage from "../pages/RegionsPage/RegionsPage";
import RegionDetailPage from "../pages/RegionDetailPage/RegionDetailPage";
import EthnicityDetailPage from "../pages/EthnicityDetailPage/EthnicityDetailPage";
import AIGuidePage from "../pages/AIGuidePage/AIGuidePage";
import ArticlePage from "../pages/ArticlePage/ArticlePage";
import FestivalsPage from "../pages/FestivalsPage/FestivalsPage";
import BlogPage from "../pages/BlogPage/BlogPage";

import EthnicCultures from "../pages/EthnicCulturesPage/EthnicCultures";
import CuisinePage from "../pages/CuisinePage/CuisinePage";
import CuisineDetailPage from "../pages/CuisineDetailPage/CuisineDetailPage";
import BlogDetailPage from "../pages/BlogDetailPage/BlogDetailPage";
import ProvincesPage from "../pages/ProvincesPage/ProvincesPage";


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
        <Route path="/ethnic-groups" element={<EthnicCultures />} />
        <Route path="/ethnic-groups/:code" element={<EthnicityDetailPage />} />
        <Route path="/ai-guide" element={<AIGuidePage />} />
        <Route path="/articles" element={<ArticlePage />} />
        <Route path="/festivals" element={<FestivalsPage />} />
        <Route path="/blog" element={<BlogPage />} />
        <Route path="/blog/:code" element={<BlogDetailPage />} />
        <Route path="/cuisine" element={<CuisinePage />} />

        <Route path="/cuisine/:id" element={<CuisineDetailPage />} />
        <Route path="/provinces" element={<ProvincesPage />} />
      </Routes>
    </BrowserRouter>
  );
}

import { BrowserRouter, Route, Routes } from "react-router-dom";
import HomePage from "../pages/HomePage/HomePage";
import ArticleDetailPage from "../pages/ArticleDetailPage/ArticleDetailPage";
import RegionsPage from "../pages/RegionsPage/RegionsPage";
import RegionDetailPage from "../pages/RegionDetailPage/RegionDetailPage";
import EthnicCulturesDetailPage from "../pages/EthnicCulturesDetailPage/EthnicCulturesDetailPage";
import AIGuidePage from "../pages/AIGuidePage/AIGuidePage";
import ArticlePage from "../pages/ArticlePage/ArticlePage";
import FestivalsPage from "../pages/FestivalsPage/FestivalsPage";
import FestivalsDetailPage from "../pages/FestivalsDetailPage/FestivalsDetailPage";
import BlogPage from "../pages/BlogPage/BlogPage";
import EthnicCultures from "../pages/EthnicCulturesPage/EthnicCultures";
import CuisinePage from "../pages/CuisinePage/CuisinePage";
import CuisineDetailPage from "../pages/CuisineDetailPage/CuisineDetailPage";
import BlogDetailPage from "../pages/BlogDetailPage/BlogDetailPage";
import ProvincesPage from "../pages/ProvincesPage/ProvincesPage";
import ProvinceDetailPage from "../pages/ProvinceDetailPage/ProvinceDetailPage";


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
        <Route path="/ethnic-groups/:code" element={<EthnicCulturesDetailPage />} />
        <Route path="/ai-guide" element={<AIGuidePage />} />
        <Route path="/articles" element={<ArticlePage />} />
        <Route path="/festivals" element={<FestivalsPage />} />
        <Route path="/festivals/:id" element={<FestivalsDetailPage />} />
        <Route path="/blog" element={<BlogPage />} />
        <Route path="/blog/:code" element={<BlogDetailPage />} />
        <Route path="/cuisine" element={<CuisinePage />} />
        <Route path="/cuisine/:id" element={<CuisineDetailPage />} />
        <Route path="/provinces" element={<ProvincesPage />} />
        <Route path="/provinces/:code" element={<ProvinceDetailPage />} />
      </Routes>
    </BrowserRouter>
  );
}

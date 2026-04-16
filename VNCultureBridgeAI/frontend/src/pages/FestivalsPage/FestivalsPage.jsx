import { useEffect, useMemo, useState } from "react";
import "./FestivalsPage.css";

// Layout & Common
import PageHeader from "../../components/layout/PageHeader/PageHeader";
import Footer from "../../components/layout/Footer/Footer";
import LoadingState from "../../components/common/LoadingState/LoadingState";

// Sub-components
import FestivalHero from "./components/FestivalHero";
import FestivalSearchSection from "./components/FestivalSearchSection";
import FestivalGridSection from "./components/FestivalGridSection";
import FestivalMeaningSection from "./components/FestivalMeaningSection";
import FestivalTimelineSection from "./components/FestivalTimelineSection";
import FestivalGallerySection from "./components/FestivalGallerySection";
import FestivalQuoteSection from "./components/FestivalQuoteSection";

// Services & Constants
import { getFestivals } from "../../services/festival.service";
import {
  FESTIVALS_PER_PAGE,
  buildFestivalData
} from "./FestivalsPage.constants";

export default function FestivalsPage() {
  const [lang, setLang] = useState("vi");
  const [isFiltersOpen, setIsFiltersOpen] = useState(false);
  const [searchText, setSearchText] = useState("");
  const [selectedRegion, setSelectedRegion] = useState("");
  const [selectedMonth, setSelectedMonth] = useState("");
  const [selectedCategory, setSelectedCategory] = useState("");
  const [selectedEthnicGroup, setSelectedEthnicGroup] = useState("");
  const [currentPage, setCurrentPage] = useState(1);
  const [state, setState] = useState({ status: "loading", data: null, error: "" });

  useEffect(() => {
    let ignore = false;
    async function load() {
      try {
        setState({ status: "loading", data: null, error: "" });
        const data = await getFestivals(lang);
        if (!ignore) {
          setState({ status: "success", data, error: "" });
        }
      } catch (error) {
        if (!ignore) {
          setState({ status: "error", data: null, error: error.message });
        }
      }
    }
    load();
    return () => { ignore = true; };
  }, [lang]);

  /* ── Data Processing ── */
  const data = useMemo(() => buildFestivalData(state.data, lang), [state.data, lang]);

  /* ── Derived Lists ── */
  const ethnicOptions = useMemo(() => {
    const values = [...new Set(data.festivals.map((item) => item.tag).filter(Boolean))];
    return [{ value: "", label: "Tất cả nhóm trải nghiệm" }, ...values.map((value) => ({ value, label: value }))];
  }, [data.festivals]);

  const filteredFestivals = useMemo(() => {
    return data.festivals.filter((fest) => {
      const searchStr = [fest.title, fest.enTitle, fest.desc, fest.location, fest.date]
        .filter(Boolean).join(" ").toLowerCase();

      const matchesSearch = !searchText || searchStr.includes(searchText.toLowerCase());
      const matchesRegion = !selectedRegion || fest.region === selectedRegion;
      const matchesMonth = !selectedMonth ||
        (fest.date || "").includes(`Tháng ${selectedMonth}`) ||
        (fest.date || "").includes(`/${selectedMonth}`);
      const matchesCategory = !selectedCategory || fest.category === selectedCategory;
      const matchesEthnic = !selectedEthnicGroup || fest.tag === selectedEthnicGroup;

      return matchesSearch && matchesRegion && matchesMonth && matchesCategory && matchesEthnic;
    });
  }, [data.festivals, searchText, selectedRegion, selectedMonth, selectedCategory, selectedEthnicGroup]);

  /* ── Pagination ── */
  const totalPages = Math.max(1, Math.ceil(filteredFestivals.length / FESTIVALS_PER_PAGE));
  const safeCurrentPage = Math.min(currentPage, totalPages);
  const paginatedFestivals = useMemo(() => {
    const startIndex = (safeCurrentPage - 1) * FESTIVALS_PER_PAGE;
    return filteredFestivals.slice(startIndex, startIndex + FESTIVALS_PER_PAGE);
  }, [filteredFestivals, safeCurrentPage]);

  /* ── Handlers ── */
  const handleFilterChange = (setter) => (event) => {
    setter(event.target.value);
    setCurrentPage(1);
  };

  const handleSearchChange = (event) => {
    setSearchText(event.target.value);
    setCurrentPage(1);
  };

  const goToPage = (pageNumber) => {
    setCurrentPage(Math.min(Math.max(pageNumber, 1), totalPages));
    const el = document.getElementById('all-celebrations');
    window.scrollTo({ top: (el?.offsetTop ?? 0) - 80, behavior: 'smooth' });
  };

  if (state.status === "loading") {
    return <LoadingState message="Đang tải dữ liệu lễ hội..." />;
  }

  if (state.status === "error") {
    return <LoadingState type="error" message="Không tải được dữ liệu lễ hội." detail={state.error} />;
  }

  return (
    <div className="festivals-page-shell">
      <PageHeader
        lang={lang}
        onLangChange={setLang}
        breadcrumb={[{ label: lang === 'vi' ? 'Lễ hội Việt Nam' : 'Vietnamese Festivals' }]}
      />

      <main className="festivals-main">
        <FestivalHero
          page={data.page}
          fanCards={data.festivals.slice(0, 5)}
        />

        <FestivalSearchSection
          page={data.page}
          isFiltersOpen={isFiltersOpen}
          setIsFiltersOpen={setIsFiltersOpen}
          searchText={searchText}
          handleSearchChange={handleSearchChange}
          selectedRegion={selectedRegion}
          handleRegionChange={handleFilterChange(setSelectedRegion)}
          selectedMonth={selectedMonth}
          handleMonthChange={handleFilterChange(setSelectedMonth)}
          selectedCategory={selectedCategory}
          handleCategoryChange={handleFilterChange(setSelectedCategory)}
          selectedEthnicGroup={selectedEthnicGroup}
          handleEthnicChange={handleFilterChange(setSelectedEthnicGroup)}
          ethnicOptions={ethnicOptions}
        />

        <FestivalGridSection
          page={data.page}
          featuredFestivals={data.festivals.slice(0, 3)}
          paginatedFestivals={paginatedFestivals}
          totalPages={totalPages}
          safeCurrentPage={safeCurrentPage}
          goToPage={goToPage}
          canGoPrev={safeCurrentPage > 1}
          canGoNext={safeCurrentPage < totalPages}
        />

        <FestivalMeaningSection
          page={data.page}
          galleryImages={data.gallery}
          filteredFestivals={filteredFestivals}
        />

        <FestivalTimelineSection
          page={data.page}
          timeline={data.timeline}
        />

        <FestivalGallerySection
          page={data.page}
          galleryImages={data.gallery}
        />

        <FestivalQuoteSection page={data.page} />

        <button
          className="festivals-scroll-top"
          onClick={() => window.scrollTo({ top: 0, behavior: "smooth" })}
          aria-label="Cuộn lên đầu trang"
        >
          <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.5" strokeLinecap="round" strokeLinejoin="round">
            <path d="m18 15-6-6-6 6" />
          </svg>
        </button>
      </main>

      <Footer lang={lang} />
    </div>
  );
}

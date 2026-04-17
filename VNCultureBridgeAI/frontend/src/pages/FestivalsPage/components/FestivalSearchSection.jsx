import React from "react";
import { REGION_OPTIONS, MONTH_OPTIONS, CATEGORY_OPTIONS } from "../FestivalsPage.constants";

const FestivalSearchSection = ({
  page,
  filters,
  isFiltersOpen,
  setIsFiltersOpen,
  searchText,
  handleSearchChange,
  selectedRegion,
  handleRegionChange,
  selectedMonth,
  handleMonthChange,
  selectedCategory,
  handleCategoryChange,
  selectedEthnicGroup,
  handleEthnicChange,
  ethnicOptions
}) => {
  const regions = filters?.regions || [];
  const months = filters?.months || [];
  const categories = filters?.categories || [];
  return (
    <section className="festivals-search-section">
      <div className="festivals-search-container">
        <div className="festivals-search-row">
          <div className="festivals-search-bar">
            <svg className="search-icon" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="#ce112d" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
              <circle cx="11" cy="11" r="8"></circle>
              <line x1="21" y1="21" x2="16.65" y2="16.65"></line>
            </svg>
            <input
              type="text"
              placeholder={page.searchPlaceholder || "Tìm kiếm lễ hội, nghi lễ và truyền thống..."}
              className="festivals-search-input"
              value={searchText}
              onChange={handleSearchChange}
            />
          </div>
          <button
            className={`festivals-filter-btn ${isFiltersOpen ? "active" : ""}`}
            onClick={() => setIsFiltersOpen(!isFiltersOpen)}
          >
            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="#ce112d" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
              <polygon points="22 3 2 3 10 12.46 10 19 14 21 14 12.46 22 3"></polygon>
            </svg>
            <span>{page.filterButton || "Bộ lọc nâng cao"}</span>
            <svg
              width="18"
              height="18"
              viewBox="0 0 24 24"
              fill="none"
              stroke="#ce112d"
              strokeWidth="2"
              strokeLinecap="round"
              strokeLinejoin="round"
              style={{ transform: isFiltersOpen ? "rotate(180deg)" : "none", transition: "transform 0.3s ease" }}
            >
              <polyline points="6 9 12 15 18 9"></polyline>
            </svg>
          </button>
        </div>

        <div className={`festivals-filters-grid ${isFiltersOpen ? "open" : ""}`}>
          <div className="festivals-filter-item">
            <span className="festivals-filter-icon">📍</span>
            <select className="festivals-filter-select" value={selectedRegion} onChange={handleRegionChange}>
              {regions.map((option) => (
                <option key={option.value || "all-regions"} value={option.value}>{option.label}</option>
              ))}
            </select>
            <svg className="festivals-filter-chevron" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#ce112d" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
              <polyline points="6 9 12 15 18 9"></polyline>
            </svg>
          </div>

          <div className="festivals-filter-item">
            <span className="festivals-filter-icon">🗓️</span>
            <select className="festivals-filter-select" value={selectedMonth} onChange={handleMonthChange}>
              {months.map((option) => (
                <option key={option.value || "all-months"} value={option.value}>{option.label}</option>
              ))}
            </select>
            <svg className="festivals-filter-chevron" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#ce112d" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
              <polyline points="6 9 12 15 18 9"></polyline>
            </svg>
          </div>

          <div className="festivals-filter-item">
            <span className="festivals-filter-icon">🎭</span>
            <select className="festivals-filter-select" value={selectedCategory} onChange={handleCategoryChange}>
              {categories.map((option) => (
                <option key={option.value || "all-categories"} value={option.value}>{option.label}</option>
              ))}
            </select>
            <svg className="festivals-filter-chevron" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#ce112d" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
              <polyline points="6 9 12 15 18 9"></polyline>
            </svg>
          </div>

          <div className="festivals-filter-item">
            <span className="festivals-filter-icon">👥</span>
            <select className="festivals-filter-select" value={selectedEthnicGroup} onChange={handleEthnicChange}>
              {ethnicOptions.map((option) => (
                <option key={option.value || "all-ethnic-groups"} value={option.value}>{option.label}</option>
              ))}
            </select>
            <svg className="festivals-filter-chevron" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#ce112d" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
              <polyline points="6 9 12 15 18 9"></polyline>
            </svg>
          </div>
        </div>
      </div>
    </section>
  );
};

export default FestivalSearchSection;

import React from 'react'
import './Pagination.css'

/**
 * Premium Pagination Component
 * @param {object} props
 * @param {number} props.currentPage
 * @param {number} props.totalPages
 * @param {function} props.onPageChange
 */
export default function Pagination({ currentPage, totalPages, onPageChange }) {
  if (totalPages <= 1) return null

  const getPageNumbers = () => {
    const pages = []
    const showMax = 5
    
    let start = Math.max(1, currentPage - 2)
    let end = Math.min(totalPages, start + showMax - 1)
    
    if (end === totalPages) {
      start = Math.max(1, end - showMax + 1)
    }

    for (let i = start; i <= end; i++) {
      pages.push(i)
    }
    return pages
  }

  return (
    <nav className="pagination-container" aria-label="Pagination">
      <button 
        className="pagination-btn pagination-btn--prev"
        onClick={() => onPageChange(currentPage - 1)}
        disabled={currentPage === 1}
      >
        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
          <polyline points="15 18 9 12 15 6" />
        </svg>
      </button>

      <div className="pagination-numbers">
        {getPageNumbers().map(page => (
          <button
            key={page}
            className={`pagination-number ${currentPage === page ? 'is-active' : ''}`}
            onClick={() => onPageChange(page)}
          >
            {page}
          </button>
        ))}
      </div>

      <button 
        className="pagination-btn pagination-btn--next"
        onClick={() => onPageChange(currentPage + 1)}
        disabled={currentPage === totalPages}
      >
        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
          <polyline points="9 18 15 12 9 6" />
        </svg>
      </button>
    </nav>
  )
}

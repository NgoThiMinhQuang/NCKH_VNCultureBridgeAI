import { useMemo } from 'react'
import { Link, useLocation } from 'react-router-dom'
import { ui } from '../../../i18n/messages'
import './PageHeader.css'

const NAV_LINKS = [
  { labelKey: 1, path: '/regions' },    // Khám phá vùng miền
  { labelKey: 2, path: '/ethnic-groups' }, // Văn hoá dân tộc
  { labelKey: 3, path: '/festivals' },  // Lễ hội
  { labelKey: 4, path: '/cuisine' },    // Ẩm thực
  { labelKey: 5, path: '/arts' },       // Nghệ thuật
  { labelKey: 6, path: '/blog' },       // Blog
]

/**
 * Header dùng chung cho các trang chi tiết (không phải trang chủ).
 * Mang đậm phong cách sơn mài Việt Nam: nền đỏ thẫm, vàng kim, hoạ tiết hoa văn.
 *
 * @param {{
 *   lang: string,
 *   onLangChange: (lang: string) => void,
 *   breadcrumb?: { label: string, to?: string }[]
 * }} props
 */
export default function PageHeader({ lang, onLangChange, breadcrumb }) {
  const copy = useMemo(() => ui[lang], [lang])
  const location = useLocation()

  return (
    <header className="page-header">
      {/* Hoạ tiết trang trí trên cùng */}
      <div className="page-header__ornament" aria-hidden="true">
        <span />
        <span />
        <span />
        <span />
        <span />
      </div>

      <div className="page-header__inner">
        {/* Logo + Brand */}
        <Link to="/" className="page-header__brand">
          <div className="page-header__logo" aria-hidden="true">
            <span className="page-header__logo-mark">VC</span>
            <span className="page-header__logo-star">✦</span>
          </div>
          <div className="page-header__brand-text">
            <strong>VietCultura</strong>
            <span>{lang === 'vi' ? 'Khám phá Việt Nam' : 'Discover Vietnam'}</span>
          </div>
        </Link>

        {/* Navigation */}
        <nav className="page-header__nav" aria-label="Main navigation">
          {NAV_LINKS.map(({ labelKey, path }) => {
            const label = copy.nav[labelKey]
            const isActive = location.pathname.startsWith(path)
            return (
              <Link
                key={path}
                to={path}
                className={`page-header__nav-link${isActive ? ' is-active' : ''}`}
              >
                {label}
              </Link>
            )
          })}
        </nav>

        {/* Actions: AI Guide + Lang toggle */}
        <div className="page-header__actions">
          <Link to="/ai-guide" className={`page-header__ai-btn${location.pathname === '/ai-guide' ? ' is-active' : ''}`}>
            <span className="page-header__ai-icon" aria-hidden="true">✦</span>
            {copy.aiGuide}
          </Link>
          <div className="page-header__lang" aria-label={copy.language}>
            <button
              type="button"
              className={lang === 'vi' ? 'is-active' : ''}
              onClick={() => onLangChange('vi')}
            >
              VI
            </button>
            <span aria-hidden="true">|</span>
            <button
              type="button"
              className={lang === 'en' ? 'is-active' : ''}
              onClick={() => onLangChange('en')}
            >
              EN
            </button>
          </div>
        </div>
      </div>

      {/* Breadcrumb */}
      {breadcrumb && breadcrumb.length > 0 && (
        <div className="page-header__breadcrumb">
          <div className="page-header__breadcrumb-inner">
            <Link to="/" className="page-header__breadcrumb-home">
              <span aria-hidden="true">⌂</span>
              {lang === 'vi' ? 'Trang chủ' : 'Home'}
            </Link>
            {breadcrumb.map((crumb, i) => (
              <span key={i} className="page-header__breadcrumb-item">
                <span className="page-header__breadcrumb-sep" aria-hidden="true">›</span>
                {crumb.to ? (
                  <Link to={crumb.to}>{crumb.label}</Link>
                ) : (
                  <span className="page-header__breadcrumb-current">{crumb.label}</span>
                )}
              </span>
            ))}
          </div>
        </div>
      )}
    </header>
  )
}

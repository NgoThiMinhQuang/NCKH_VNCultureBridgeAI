import { useEffect, useMemo, useState } from 'react'
import { Link, useLocation } from 'react-router-dom'
import { ui } from '../../../i18n/messages'
import './PageHeader.css'

const NAV_LINKS = [
  { labelKey: 0, path: '/' },
  { labelKey: 1, path: '/regions' },
  { labelKey: 2, path: '/ethnic-groups' },
  { labelKey: 3, path: '/festivals' },
  { labelKey: 4, path: '/cuisine' },
  { labelKey: 5, path: '/blog' },
]

/**
 * Header dùng chung — nền kem, logo ảnh thật, nav gạch chân đỏ.
 * Props:
 *   lang           — 'vi' | 'en'
 *   onLangChange   — (lang) => void
 *   breadcrumb?    — [{ label, to? }]
 */
export default function PageHeader({ lang, onLangChange, breadcrumb, renderNav }) {
  const copy = useMemo(() => ui[lang], [lang])
  const [currentUser, setCurrentUser] = useState(null)
  const location = useLocation()

  useEffect(() => {
    function readUser() {
      try {
        const raw = localStorage.getItem('currentUser')
        setCurrentUser(raw ? JSON.parse(raw) : null)
      } catch {
        setCurrentUser(null)
      }
    }

    readUser()
    window.addEventListener('storage', readUser)
    window.addEventListener('auth-changed', readUser)

    return () => {
      window.removeEventListener('storage', readUser)
      window.removeEventListener('auth-changed', readUser)
    }
  }, [])

  function isActive(path) {
    if (path === '/') return location.pathname === '/'
    return location.pathname.startsWith(path)
  }

  function handleNavClick(e, path) {
    if (path === '/' && location.pathname === '/') {
      e.preventDefault()
      window.scrollTo({ top: 0, behavior: 'smooth' })
    }
  }

  function handleLogout() {
    const confirmed = window.confirm('Bạn có chắc chắn muốn đăng xuất không?')

    if (!confirmed) return

    localStorage.removeItem('authToken')
    localStorage.removeItem('currentUser')
    localStorage.removeItem('isAuthenticated')
    setCurrentUser(null)
    window.dispatchEvent(new Event('auth-changed'))
    window.alert('Đăng xuất thành công.')
  }

  return (
    <header className="ph">
      <div className="ph__bar">

        {/* ── Logo ── */}
        <Link to="/" className="ph__brand">
          <img
            src="/img/Logo.png"
            alt="Biểu trưng VNCulture"
            className="ph__logo-img"
          />
          <div className="ph__brand-text">
            <strong>VNCulture</strong>
            <span>Di sản & Văn hoá</span>
          </div>
        </Link>

        {/* ── Navigation ── */}
        {renderNav ? renderNav() : (
          <nav className="ph__nav" aria-label="Điều hướng chính">
            {NAV_LINKS.map(({ labelKey, path }) => (
              <Link
                key={path + labelKey}
                to={path}
                className={`ph__nav-link${isActive(path) ? ' is-active' : ''}`}
                onClick={(e) => handleNavClick(e, path)}
              >
                {copy.nav[labelKey]}
              </Link>
            ))}
          </nav>
        )}

        {/* ── Actions ── */}
        <div className="ph__actions">
          {/* Language toggle: VI | EN */}
          <div className="ph__lang" aria-label="Chọn ngôn ngữ">
            <button 
              type="button" 
              className={lang === 'vi' ? 'is-active' : ''} 
              onClick={() => onLangChange('vi')}
            >
              VI
            </button>
            <span>|</span>
            <button 
              type="button" 
              className={lang === 'en' ? 'is-active' : ''} 
              onClick={() => onLangChange('en')}
            >
              EN
            </button>
          </div>

          {currentUser ? (
            <>
              <div className="ph__user-chip" title={currentUser.fullName}>
                <span className="ph__user-chip-label">Xin chào</span>
                <strong className="ph__user-chip-name">{currentUser.fullName}</strong>
              </div>
              <button type="button" className="ph__btn-logout" onClick={handleLogout}>
                Đăng xuất
              </button>
            </>
          ) : (
            <>
              {/* Đăng nhập */}
              <Link to="/login" className="ph__btn-login">
                Đăng nhập
              </Link>

              {/* Đăng ký */}
              <Link to="/register" className="ph__btn-register">
                Đăng ký
              </Link>
            </>
          )}
        </div>
      </div>

      {/* ── Breadcrumb ── */}
      {breadcrumb && breadcrumb.length > 0 && (
        <div className="ph__crumb">
          <div className="ph__crumb-inner">
            <Link to="/" className="ph__crumb-link">Trang chủ</Link>
            {breadcrumb.map((item, i) => (
              <span key={i} className="ph__crumb-item">
                <span className="ph__crumb-sep" aria-hidden="true">›</span>
                {item.to
                  ? <Link to={item.to} className="ph__crumb-link">{item.label}</Link>
                  : <span className="ph__crumb-current">{item.label}</span>
                }
              </span>
            ))}
          </div>
        </div>
      )}
    </header>
  )
}

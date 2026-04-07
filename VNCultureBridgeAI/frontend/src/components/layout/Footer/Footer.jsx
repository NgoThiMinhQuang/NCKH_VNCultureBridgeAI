import { Link } from 'react-router-dom'
import { ui } from '../../../i18n/messages'
import './Footer.css'

export default function Footer({ lang = 'vi' }) {
  const copy = ui[lang]?.footer;
  if (!copy) return null;

  return (
    <footer className="vnc-footer fade-up">
      <div className="vnc-footer-overlay"></div>

      <div className="vnc-footer-container">
        <div className="vnc-footer-top">

          {/* LEFT: BRAND & NEWSLETTER */}
          <div className="vnc-footer-col vnc-brand-col">
            {/* ── Logo ── */}
            <Link to="/" className="ph__brand">
              <img
                src="/img/Logo.png"
                alt="VNCulture logo"
                className="ph__logo-img"
              />
              <div className="ph__brand-text">
                <strong>VNCulture</strong>
                <span>{lang === 'vi' ? 'Di sản & Văn hoá' : 'Heritage & Culture'}</span>
              </div>
            </Link>
            <p className="vnc-desc">
              {copy.description}
            </p>
            <p className="vnc-quote">{copy.quote}</p>

            <div className="vnc-newsletter">
              <h5>{copy.newsletterTitle}</h5>
              <form className="vnc-form" onSubmit={(e) => e.preventDefault()}>
                <input type="email" placeholder={copy.newsletterPlaceholder} required />
                <button type="submit">{copy.newsletterBtn}</button>
              </form>
            </div>
          </div>

          {/* MIDDLE: LINKS */}
          <div className="vnc-footer-col vnc-links-col">
            <h4>{copy.columns?.explore || 'Khám Phá'}</h4>
            <div className="vnc-links-grid">
              <div className="vnc-links-group">
                <Link to="/">{ui[lang].nav[0]}</Link>
                <Link to="/#ethnic-groups">{ui[lang].nav[2]}</Link>
                <Link to="/#cuisine">{ui[lang].nav[4]}</Link>
                <Link to="/#blog">{ui[lang].nav[6] || 'Blog'}</Link>
              </div>
              <div className="vnc-links-group">
                <Link to="/regions">{ui[lang].nav[1]}</Link>
                <Link to="/#festivals">{ui[lang].nav[3]}</Link>
                <Link to="/provinces">{lang === 'vi' ? 'Tỉnh thành' : 'Provinces'}</Link>
                <Link to="/articles">{ui[lang].nav[5] || 'Articles'}</Link>
              </div>
            </div>
          </div>

          {/* RIGHT: CONTACT & SOCIAL */}
          <div className="vnc-footer-col vnc-contact-col">
            <h4>{copy.contactTitle}</h4>
            <ul className="vnc-contact-list">
              <li>
                <span className="vnc-icon">
                  <svg width="18" height="18" fill="none" stroke="currentColor" strokeWidth="2" viewBox="0 0 24 24"><path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0118 0z" /><circle cx="12" cy="10" r="3" /></svg>
                </span>
                {copy.contactAddress}
              </li>
              <li>
                <span className="vnc-icon">
                  <svg width="18" height="18" fill="none" stroke="currentColor" strokeWidth="2" viewBox="0 0 24 24"><path d="M22 16.92v3a2 2 0 01-2.18 2 19.79 19.79 0 01-8.63-3.07 19.5 19.5 0 01-6-6 19.79 19.79 0 01-3.07-8.67A2 2 0 014.11 2h3a2 2 0 012 1.72 12.84 12.84 0 00.7 2.81 2 2 0 01-.45 2.11L8.09 9.91a16 16 0 006 6l1.27-1.27a2 2 0 012.11-.45 12.84 12.84 0 002.81.7A2 2 0 0122 16.92z" /></svg>
                </span>
                +84 969.577.360
              </li>
              <li>
                <span className="vnc-icon">
                  <svg width="18" height="18" fill="none" stroke="currentColor" strokeWidth="2" viewBox="0 0 24 24"><path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z" /><polyline points="22,6 12,13 2,6" /></svg>
                </span>
                vnculture@gmail.com
              </li>
            </ul>

            <div className="vnc-social">
              <h5>{copy.socialTitle}</h5>
              <div className="vnc-social-icons">
                <a href="#" className="vnc-social-btn" aria-label="Facebook">
                  <svg width="18" height="18" fill="currentColor" viewBox="0 0 24 24"><path d="M18 2h-3a5 5 0 00-5 5v3H7v4h3v8h4v-8h3l1-4h-4V7a1 1 0 011-1h3z" /></svg>
                </a>
                <a href="#" className="vnc-social-btn" aria-label="YouTube">
                  <svg width="18" height="18" fill="currentColor" viewBox="0 0 24 24"><path d="M22.54 6.42a2.78 2.78 0 00-1.94-2C18.88 4 12 4 12 4s-6.88 0-8.6.46a2.78 2.78 0 00-1.94 2A29 29 0 001 11.75a29 29 0 00.46 5.33A2.78 2.78 0 003.4 19c1.72.46 8.6.46 8.6.46s6.88 0 8.6-.46a2.78 2.78 0 001.94-2 29 29 0 00.46-5.25 29 29 0 00-.46-5.33zM9.75 15.02V8.4l5.73 3.3-5.73 3.32z" /></svg>
                </a>
                <a href="#" className="vnc-social-btn" aria-label="TikTok">
                  <svg width="18" height="18" fill="currentColor" viewBox="0 0 24 24"><path d="M12.53.02C13.84 0 15.14.01 16.44 0c.08 1.53.63 3.09 1.75 4.17 1.12 1.11 2.7 1.62 4.24 1.79v4.03c-1.44-.05-2.89-.35-4.2-.97-.57-.26-1.1-.59-1.62-.93v5.8c0 1.96-.54 3.93-1.6 5.6-2.12 3.35-6.27 4.75-10.03 3.51-3.69-1.2-6.2-4.66-6.19-8.52.01-3.79 2.56-7.14 6.22-8.25 2.1-.64 4.4-.33 6.26.85.03.02.04.04.07.06v4.18c-1.47-1.1-3.41-1.3-5.07-.63-1.78.71-2.91 2.4-3 4.28-.09 1.83.82 3.65 2.41 4.48 1.62.84 3.65.65 5.09-.45 1.1-.85 1.78-2.16 1.8-3.56l.01-15.42z" /></svg>
                </a>
              </div>
            </div>
          </div>
        </div>

        <div className="vnc-footer-bottom">
          <div className="vnc-copyright">
            {copy.copyright}
          </div>
          <div className="vnc-legal">
            <a href="#">{copy.privacy}</a>
            <a href="#">{copy.terms}</a>
            <a href="#">{copy.contact}</a>
          </div>
        </div>
      </div>
    </footer>
  )
}
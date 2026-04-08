import { useMemo } from 'react'
import { Link } from 'react-router-dom'
import { ui } from '../../../i18n/messages'
import blogHeroBg from '../../../assets/blog_hero_bg.png'
import './BlogHero.css'

/**
 * BlogHero component for the Blog page.
 * Props:
 *   lang - 'vi' | 'en'
 */
export default function BlogHero({ lang }) {
  const copy = useMemo(() => ui[lang].blogHero, [lang])

  return (
    <section
      className="blog-hero"
      style={{ backgroundImage: `url(${blogHeroBg})` }}
    >
      <div className="blog-hero__overlay"></div>
      <div className="blog-hero__container">


        {/* Badge */}
        <div className="blog-hero__badge">
          {copy.badge}
        </div>

        {/* Title */}
        <h1 className="blog-hero__title">
          {copy.title}
        </h1>

        {/* Subtitle */}
        <p className="blog-hero__subtitle">
          {copy.subtitle}
        </p>

        {/* Divider */}
        <div className="blog-hero__divider" aria-hidden="true">
          <span className="blog-hero__line"></span>
          <span className="blog-hero__dot"></span>
          <span className="blog-hero__line"></span>
        </div>

        {/* Search Bar */}
        <div className="blog-hero__search">
          <form className="blog-hero__search-form" onSubmit={(e) => e.preventDefault()}>
            <input
              type="text"
              className="blog-hero__search-input"
              placeholder={copy.searchPlaceholder}
            />
            <button type="submit" className="blog-hero__search-btn">
              {copy.searchBtn}
            </button>
          </form>
        </div>
      </div>
    </section>
  )
}

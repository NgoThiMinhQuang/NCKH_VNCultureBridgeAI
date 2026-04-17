import { useEffect, useMemo, useState } from 'react'
import { useLanguage } from '../../context/LanguageContext'
import { Link, useNavigate, useParams } from 'react-router-dom'
import './CuisineDetailPage.css'
import PageHeader from '../../components/layout/PageHeader/PageHeader'
import Footer from '../../components/layout/Footer/Footer'
import { getCuisine } from '../../services/cuisine.service'
import { getCuisineImageSet, getCuisineLocalImage } from '../../utils/cuisineMedia'
import { ui } from '../../i18n/messages'
import {
  FiClock,
  FiCoffee,
  FiHome,
  FiImage,
  FiArrowLeft,
} from 'react-icons/fi'

function buildNavItems(copy) {
  return [
    { icon: <FiClock />, label: copy.introduction },
    { icon: <FiCoffee />, label: copy.enjoyment },
    { icon: <FiHome />, label: copy.kitchen },
    { icon: <FiImage />, label: copy.gallery },
  ]
}

export default function CuisineDetailPage() {
  const { lang, setLang } = useLanguage()
  const copy = ui[lang]
  const dCopy = copy.cuisineDetail
  const [detail, setDetail] = useState(null)
  const [status, setStatus] = useState('loading')
  const [error, setError] = useState('')
  const { id } = useParams()
  const navigate = useNavigate()
  const imageSet = getCuisineImageSet(detail?.code, detail?.name, id)

  useEffect(() => {
    window.scrollTo(0, 0)
  }, [id])

  useEffect(() => {
    let ignore = false

    async function loadCuisineDetail() {
      try {
        setStatus('loading')
        setError('')
        const data = await getCuisine(id, lang)
        if (!ignore) {
          setDetail(data)
          setStatus('success')
          document.documentElement.lang = lang
        }
      } catch (err) {
        if (!ignore) {
          setError(err.message)
          setDetail(null)
          setStatus('error')
        }
      }
    }

    if (id) {
      loadCuisineDetail()
    }

    return () => {
      ignore = true
    }
  }, [id, lang])

  const navItems = useMemo(() => buildNavItems(dCopy), [dCopy])

  if (status === 'error' && !detail) {
    return (
      <div className="page-shell">
        <PageHeader lang={lang} onLangChange={setLang} />
        <main className="cdp-main">
          <section className="cdp-section cdp-section--light">
            <div className="cdp-container" style={{ textAlign: 'center', padding: '80px 0' }}>
              <h2 className="cdp-section-title">{dCopy.failedToLoad}</h2>
              <p className="cdp-section-subtitle">{error || dCopy.errorLoading}</p>
              <Link to="/cuisine" className="primary-button" style={{ display: 'inline-flex', marginTop: '24px', padding: '12px 32px', background: 'linear-gradient(90deg, #d97706, #dc2626)', color: 'white', borderRadius: '50px', fontWeight: 'bold', textDecoration: 'none' }}>
                {dCopy.backToList}
              </Link>
            </div>
          </section>
        </main>
        <Footer lang={lang} />
      </div>
    )
  }

  if (status === 'success' && !detail) {
    return (
      <div className="page-shell">
        <PageHeader lang={lang} onLangChange={setLang} />
        <main className="cdp-main">
          <section className="cdp-section cdp-section--light">
            <div className="cdp-container" style={{ textAlign: 'center', padding: '80px 0' }}>
              <h2 className="cdp-section-title">{dCopy.notFound}</h2>
              <p className="cdp-section-subtitle">{dCopy.notFoundDesc}</p>
              <Link to="/cuisine" className="primary-button" style={{ display: 'inline-flex', marginTop: '24px', padding: '12px 32px', background: 'linear-gradient(90deg, #d97706, #dc2626)', color: 'white', borderRadius: '50px', fontWeight: 'bold', textDecoration: 'none' }}>
                {dCopy.backToList}
              </Link>
            </div>
          </section>
        </main>
        <Footer lang={lang} />
      </div>
    )
  }

  if (!detail) {
    return (
      <div className="page-shell">
        <PageHeader lang={lang} onLangChange={setLang} />
        <main className="cdp-main">
          <section className="cdp-section cdp-section--light">
            <div className="cdp-container" style={{ textAlign: 'center', padding: '80px 0' }}>
              <p className="cdp-section-subtitle">{dCopy.loading}</p>
            </div>
          </section>
        </main>
        <Footer lang={lang} />
      </div>
    )
  }

  const heroImage = detail?.imageUrl || getCuisineLocalImage(detail?.code, detail?.name, id)
  const galleryItems = detail.gallery?.length
    ? detail.gallery.map((item) => ({
        ...item,
        imageUrl: item.imageUrl || getCuisineLocalImage(item.code, item.title, item.imageAlt, detail?.code, detail?.name),
      }))
    : imageSet.gallery.map((imageUrl, index) => ({
        id: `gallery-${index + 1}`,
        imageUrl,
        imageAlt: detail.heroImageAlt,
        size: index === 0 ? 'large' : 'small',
      }))

  const similarFoods = (detail.similarFoods?.slice(0, 3) || []).map((food) => ({
    ...food,
    imageUrl: food.imageUrl || getCuisineLocalImage(food.code, food.title, food.imageAlt),
  }))
  const introImage = detail.intro?.imageUrl || imageSet.intro || heroImage
  const howToEnjoyImage = detail.howToEnjoy?.imageUrl || imageSet.enjoy || heroImage
  const secretTipImage = detail.secretTip?.imageUrl || imageSet.tip || heroImage

  return (
    <div className="page-shell">
      <PageHeader lang={lang} onLangChange={setLang} />

      <main className="cdp-main">
        <section className="cdp-hero">
          <div className="cdp-hero__bg" style={{ backgroundImage: `url('${heroImage}')` }}></div>
          <div className="cdp-hero__overlay"></div>

          <div className="cdp-hero__ornament cdp-hero__ornament--tl"></div>
          <div className="cdp-hero__ornament cdp-hero__ornament--br"></div>

          <div className="cdp-hero__inner">
            <div className="cdp-hero__left fade-up">
              <button onClick={() => navigate(-1)} className="cdp-back-btn" aria-label={dCopy.back} style={{ position: 'relative', top: 0, left: 0, display: 'inline-flex', marginBottom: '24px', width: 'fit-content', background: 'transparent', border: 'none', color: '#f8c97a', cursor: 'pointer', alignItems: 'center', gap: '8px', fontSize: '1rem' }}>
                <FiArrowLeft /> <span>{dCopy.back}</span>
              </button>

              <div className="cdp-hero__badge">
                <span className="cdp-hero__badge-dot"></span>
                {detail.region ? `${detail.categoryLabel} ${detail.region}` : detail.categoryLabel}
              </div>

              <h1 className="cdp-hero__title">{detail.name}</h1>
              <p className="cdp-hero__subtitle">{detail.subtitle}</p>

              <div className="cdp-hero__stats">
                <div className="cdp-hero__stat">
                  <strong>{detail.stats?.prepTime || dCopy.updating}</strong>
                  <span>{dCopy.prepTime}</span>
                </div>
                <div className="cdp-hero__stat-sep"></div>
                <div className="cdp-hero__stat">
                  <strong>{detail.stats?.difficulty || dCopy.updating}</strong>
                  <span>{dCopy.difficulty}</span>
                </div>
                <div className="cdp-hero__stat-sep"></div>
                <div className="cdp-hero__stat">
                  <strong>{detail.stats?.calories || dCopy.updating}</strong>
                  <span>{dCopy.calories}</span>
                </div>
              </div>

              <nav className="cdp-hero__nav-inline">
                {navItems.map((item, idx) => (
                  <div key={idx} className="cdp-nav-item">
                    <div className="cdp-nav-icon">{item.icon}</div>
                    <span className="cdp-nav-label">{item.label}</span>
                  </div>
                ))}
              </nav>
            </div>

            <div className="cdp-hero__right fade-up delay-1">
              <div className="cdp-hero__img-frame">
                <img src={heroImage} alt={detail.heroImageAlt} className="cdp-hero__img-main" />
                <div className="cdp-hero__img-ring"></div>
              </div>
            </div>
          </div>

          <div className="cdp-section-wave">
            <svg data-name="Layer 1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1200 120" preserveAspectRatio="none">
              <path d="M321.39,56.44c58-10.79,114.16-30.13,172-41.86,82.39-16.72,168.19-17.73,250.45-.39C823.78,31,906.67,72,985.66,92.83c70.05,18.48,146.53,26.09,214.34,3V0H0V27.35A600.21,600.21,0,0,0,321.39,56.44Z" fill="#ffffff"></path>
            </svg>
          </div>
        </section>

        <section className="cdp-section cdp-section--light cdp-intro">
          <div className="cdp-container">
            <div className="cdp-intro__grid">
              <div className="cdp-intro__text">
                <header className="cdp-intro__header fade-up" style={{ marginBottom: '32px' }}>
                  <span className="cdp-section-badge" style={{ margin: 0 }}>{detail.intro?.badge}</span>
                  <h2 className="cdp-section-title" style={{ textAlign: 'left', marginTop: '8px' }}>{detail.intro?.title}</h2>
                </header>
                <span className="cdp-drop-cap">{(detail.name || 'A').charAt(0)}</span>
                <div className="cdp-intro__body">
                  {(detail.intro?.paragraphs || []).map((paragraph, index) => (
                    <p key={index} style={index > 0 ? { marginTop: '20px' } : undefined}>{paragraph}</p>
                  ))}
                </div>
              </div>
              <div className="cdp-intro__image">
                <img src={introImage} alt={detail.intro?.imageAlt || detail.heroImageAlt} />
              </div>
            </div>
          </div>
        </section>

        <section className="cdp-section cdp-section--cream cdp-music">
          <div className="cdp-container">
            <div className="cdp-arch__grid">
              <div className="cdp-arch-text">
                <span className="cdp-section-badge">{detail.howToEnjoy?.badge}</span>
                <h2 className="cdp-section-title">{detail.howToEnjoy?.title}</h2>
                <p className="cdp-intro__body">{detail.howToEnjoy?.body}</p>
              </div>
              <div className="cdp-arch-image">
                <img src={howToEnjoyImage} alt={detail.howToEnjoy?.imageAlt || detail.heroImageAlt} className="cdp-arch-img" />
              </div>
            </div>
          </div>
        </section>

        {similarFoods.length > 0 && (
          <section className="cdp-section cdp-section--light cdp-cuisine">
            <div className="cdp-container">
              <header className="cdp-section-header">
                <span className="cdp-section-badge">{dCopy.moreSuggestions}</span>
                <h2 className="cdp-section-title">{dCopy.similarDishes}</h2>
              </header>
              <div className="cdp-cuisine-grid">
                {similarFoods.map((food) => (
                  <div className="cdp-cuisine-item" onClick={() => navigate(`/cuisine/${food.code || food.id}`)} style={{ cursor: 'pointer' }} key={food.code || food.id}>
                    <img src={food.imageUrl || getCuisineLocalImage(food.code, food.title, food.imageAlt)} alt={food.imageAlt || food.title} className="cdp-cuisine-img" />
                    <h3 className="cdp-cuisine-title">{food.title}</h3>
                  </div>
                ))}
              </div>
            </div>
          </section>
        )}

        <section className="cdp-section cdp-section--cream cdp-architecture">
          <div className="cdp-container">
            <div className="cdp-arch__grid">
              <div className="cdp-arch-image">
                <img src={secretTipImage} alt={detail.secretTip?.imageAlt || detail.heroImageAlt} className="cdp-arch-img" />
              </div>
              <div className="cdp-arch-text">
                <span className="cdp-section-badge">{detail.secretTip?.badge}</span>
                <h2 className="cdp-section-title">{detail.secretTip?.title}</h2>
                <p className="cdp-intro__body">{detail.secretTip?.body}</p>
              </div>
            </div>
          </div>
        </section>

        {galleryItems.length > 0 && (
          <section className="cdp-section cdp-section--light cdp-gallery">
            <div className="cdp-container">
              <header className="cdp-section-header">
                <h2 className="cdp-section-title">{dCopy.imageGallery}</h2>
                <p className="cdp-section-subtitle">{dCopy.galleryDesc.replace('{name}', detail.name)}</p>
              </header>

              <div className="cdp-gallery-grid">
                {galleryItems.map((item, index) => (
                  <div key={item.id || index} className={`cdp-gallery-item ${item.size || ''}`.trim()}>
                    <img src={item.imageUrl || heroImage} alt={item.imageAlt || detail.heroImageAlt} />
                  </div>
                ))}
              </div>
            </div>
          </section>
        )}

        <section className="cdp-cta-banner">
          <div className="cdp-container" style={{ textAlign: 'center' }}>
            <h2 className="cdp-cta-title" style={{ fontSize: '2rem', marginBottom: '24px', color: '#1a0a04' }}>{dCopy.exploreBanner}</h2>
            <Link to="/cuisine" className="primary-button" style={{
              display: 'inline-flex', padding: '12px 32px', background: 'linear-gradient(90deg, #d97706, #dc2626)',
              color: 'white', borderRadius: '50px', fontWeight: 'bold', textDecoration: 'none'
            }}>
              {dCopy.backToList}
            </Link>
          </div>
        </section>
      </main>

      <Footer lang={lang} />
    </div>
  )
}

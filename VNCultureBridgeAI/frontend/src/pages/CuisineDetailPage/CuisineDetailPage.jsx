import { useEffect, useMemo, useState } from 'react'
import { Link, useNavigate, useParams } from 'react-router-dom'
import './CuisineDetailPage.css'
import PageHeader from '../../components/layout/PageHeader/PageHeader'
import Footer from '../../components/layout/Footer/Footer'
import { getCuisine } from '../../services/cuisine.service'
import {
  FiClock,
  FiGlobe,
  FiBookOpen,
  FiCoffee,
  FiHome,
  FiImage,
  FiArrowLeft,
} from 'react-icons/fi'

const DEFAULT_DETAIL = {
  categoryLabel: 'Ẩm thực Việt Nam',
  name: 'Món ăn truyền thống',
  subtitle: 'Khám phá hương vị đặc trưng của ẩm thực Việt Nam từ dữ liệu văn hóa số.',
  heroImageUrl: 'https://images.unsplash.com/photo-1547592166-23ac45744acd?q=80&w=2071&auto=format&fit=crop',
  heroImageAlt: 'Ẩm thực Việt Nam',
  stats: {
    prepTime: 'Đang cập nhật',
    difficulty: 'Đang cập nhật',
    calories: 'Đang cập nhật',
  },
  intro: {
    badge: 'Hương vị truyền thống',
    title: 'Giới thiệu món ăn',
    paragraphs: ['Nội dung đang được cập nhật từ cơ sở dữ liệu.'],
    imageUrl: 'https://images.unsplash.com/photo-1547592166-23ac45744acd?q=80&w=2071&auto=format&fit=crop',
    imageAlt: 'Ẩm thực Việt Nam',
  },
  ingredients: {
    badge: 'Nguyên liệu chọn lọc',
    title: 'Tinh hoa nguyên liệu',
    subtitle: 'Thông tin nguyên liệu sẽ được cập nhật sớm.',
    images: [
      'https://images.unsplash.com/photo-1626242372480-164c673ba718?w=600&q=80',
      'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=600&q=80',
      'https://images.unsplash.com/photo-1555126634-323283e090fa?w=600&q=80',
    ],
    summary: 'Dữ liệu thành phần đang được đồng bộ từ hệ thống nội dung.',
  },
  recipeSteps: [
    {
      stepLabel: '1',
      title: 'Chuẩn bị',
      desc: 'Nội dung hướng dẫn đang được cập nhật.',
      imageUrl: 'https://images.unsplash.com/photo-1582878826629-29b7ad1cb431?w=600&q=80',
      imageAlt: 'Bước chuẩn bị',
    },
  ],
  howToEnjoy: {
    badge: 'Nghệ thuật ẩm thực',
    title: 'Cách thưởng thức',
    body: 'Gợi ý thưởng thức sẽ được cập nhật từ cơ sở dữ liệu.',
    imageUrl: 'https://images.unsplash.com/photo-1555939594-58d7cb561ad1?w=600&q=80',
    imageAlt: 'Cách thưởng thức',
  },
  secretTip: {
    badge: 'Góc ẩm thực',
    title: 'Bí quyết đặc biệt',
    body: 'Mẹo chế biến sẽ được cập nhật từ cơ sở dữ liệu.',
    imageUrl: 'https://images.unsplash.com/photo-1547592166-23ac45744acd?q=80&w=2071&auto=format&fit=crop',
    imageAlt: 'Bí quyết nấu ăn',
  },
  similarFoods: [],
  gallery: [],
}

function buildNavItems(lang) {
  return [
    { icon: <FiClock />, label: lang === 'vi' ? 'Giới thiệu' : 'Intro' },
    { icon: <FiBookOpen />, label: lang === 'vi' ? 'Nguyên liệu' : 'Ingredients' },
    { icon: <FiGlobe />, label: lang === 'vi' ? 'Cách làm' : 'Method' },
    { icon: <FiCoffee />, label: lang === 'vi' ? 'Thưởng thức' : 'Enjoy' },
    { icon: <FiHome />, label: lang === 'vi' ? 'Góc bếp' : 'Kitchen' },
    { icon: <FiImage />, label: lang === 'vi' ? 'Thư viện' : 'Gallery' },
  ]
}

export default function CuisineDetailPage() {
  const [lang, setLang] = useState('vi')
  const [detail, setDetail] = useState(null)
  const [status, setStatus] = useState('loading')
  const [error, setError] = useState('')
  const { id } = useParams()
  const navigate = useNavigate()

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

  const cuisine = useMemo(() => {
    const source = detail || DEFAULT_DETAIL
    const introParagraphs = source.intro?.paragraphs?.length ? source.intro.paragraphs : DEFAULT_DETAIL.intro.paragraphs
    const ingredientImages = source.ingredients?.images?.filter(Boolean)?.length
      ? source.ingredients.images.filter(Boolean).slice(0, 3)
      : DEFAULT_DETAIL.ingredients.images
    const recipeSteps = source.recipeSteps?.length ? source.recipeSteps : DEFAULT_DETAIL.recipeSteps
    const gallery = source.gallery?.length ? source.gallery : DEFAULT_DETAIL.gallery

    return {
      ...DEFAULT_DETAIL,
      ...source,
      intro: {
        ...DEFAULT_DETAIL.intro,
        ...source.intro,
        paragraphs: introParagraphs,
      },
      ingredients: {
        ...DEFAULT_DETAIL.ingredients,
        ...source.ingredients,
        images: ingredientImages,
      },
      recipeSteps,
      howToEnjoy: {
        ...DEFAULT_DETAIL.howToEnjoy,
        ...source.howToEnjoy,
      },
      secretTip: {
        ...DEFAULT_DETAIL.secretTip,
        ...source.secretTip,
      },
      gallery,
      similarFoods: source.similarFoods || [],
      stats: {
        ...DEFAULT_DETAIL.stats,
        ...source.stats,
      },
    }
  }, [detail])

  const navItems = useMemo(() => buildNavItems(lang), [lang])
  const galleryItems = cuisine.gallery.length ? cuisine.gallery : cuisine.ingredients.images.map((imageUrl, index) => ({
    id: `fallback-${index}`,
    imageUrl,
    imageAlt: cuisine.name,
    size: ['large', 'small', 'tall', 'small', 'wide', 'small'][index % 6] || 'small',
  }))

  const similarFoods = cuisine.similarFoods.length ? cuisine.similarFoods.slice(0, 3) : []

  return (
    <div className="page-shell">
      <PageHeader lang={lang} onLangChange={setLang} />

      <main className="cdp-main">
        {status === 'error' && !detail && (
          <section className="cdp-section cdp-section--light">
            <div className="cdp-container">
              <p className="cdp-section-subtitle">{error || 'Không tải được dữ liệu món ăn.'}</p>
            </div>
          </section>
        )}

        <section className="cdp-hero">
          <div className="cdp-hero__bg" style={{ backgroundImage: `url('${cuisine.heroImageUrl}')` }}></div>
          <div className="cdp-hero__overlay"></div>

          <div className="cdp-hero__ornament cdp-hero__ornament--tl"></div>
          <div className="cdp-hero__ornament cdp-hero__ornament--br"></div>

          <div className="cdp-hero__inner">
            <div className="cdp-hero__left fade-up">
              <button onClick={() => navigate(-1)} className="cdp-back-btn" aria-label={lang === 'vi' ? 'Quay lại' : 'Go back'} style={{ position: 'relative', top: 0, left: 0, display: 'inline-flex', marginBottom: '24px', width: 'fit-content', background: 'transparent', border: 'none', color: '#f8c97a', cursor: 'pointer', alignItems: 'center', gap: '8px', fontSize: '1rem' }}>
                <FiArrowLeft /> <span>{lang === 'vi' ? 'Quay lại' : 'Go back'}</span>
              </button>

              <div className="cdp-hero__badge">
                <span className="cdp-hero__badge-dot"></span>
                {cuisine.region ? `${cuisine.categoryLabel} ${cuisine.region}` : cuisine.categoryLabel}
              </div>

              <h1 className="cdp-hero__title">{cuisine.name}</h1>

              <p className="cdp-hero__subtitle">{cuisine.subtitle}</p>

              <div className="cdp-hero__stats">
                <div className="cdp-hero__stat">
                  <strong>{cuisine.stats.prepTime}</strong>
                  <span>{lang === 'vi' ? 'Thời gian chế biến' : 'Prep time'}</span>
                </div>
                <div className="cdp-hero__stat-sep"></div>
                <div className="cdp-hero__stat">
                  <strong>{cuisine.stats.difficulty}</strong>
                  <span>{lang === 'vi' ? 'Độ khó' : 'Difficulty'}</span>
                </div>
                <div className="cdp-hero__stat-sep"></div>
                <div className="cdp-hero__stat">
                  <strong>{cuisine.stats.calories}</strong>
                  <span>{lang === 'vi' ? 'Năng lượng' : 'Calories'}</span>
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
                <img src={cuisine.heroImageUrl} alt={cuisine.heroImageAlt} className="cdp-hero__img-main" />
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
                  <span className="cdp-section-badge" style={{ margin: 0 }}>{cuisine.intro.badge}</span>
                  <h2 className="cdp-section-title" style={{ textAlign: 'left', marginTop: '8px' }}>{cuisine.intro.title}</h2>
                </header>
                <span className="cdp-drop-cap">{(cuisine.name || 'A').charAt(0)}</span>
                <div className="cdp-intro__body">
                  {cuisine.intro.paragraphs.map((paragraph, index) => (
                    <p key={index} style={index > 0 ? { marginTop: '20px' } : undefined}>{paragraph}</p>
                  ))}
                </div>
              </div>
              <div className="cdp-intro__image">
                <img src={cuisine.intro.imageUrl || cuisine.heroImageUrl} alt={cuisine.intro.imageAlt || cuisine.heroImageAlt} />
              </div>
            </div>
          </div>
        </section>

        <section className="cdp-section cdp-section--cream cdp-textiles">
          <div className="cdp-container">
            <header className="cdp-section-header">
              <span className="cdp-section-badge">{cuisine.ingredients.badge}</span>
              <h2 className="cdp-section-title">{cuisine.ingredients.title}</h2>
              <p className="cdp-section-subtitle">{cuisine.ingredients.subtitle}</p>
            </header>

            <div className="cdp-textiles-grid">
              {cuisine.ingredients.images.map((imageUrl, index) => (
                <img key={`${imageUrl}-${index}`} src={imageUrl} alt={`${cuisine.name} ${index + 1}`} className="cdp-textile-img" />
              ))}
            </div>

            <p className="cdp-textiles-footer">{cuisine.ingredients.summary}</p>
          </div>
        </section>

        <section className="cdp-section cdp-section--light cdp-festivals">
          <div className="cdp-container">
            <header className="cdp-section-header">
              <span className="cdp-section-badge">{lang === 'vi' ? 'Các bước thực hiện' : 'Steps'}</span>
              <h2 className="cdp-section-title">{lang === 'vi' ? 'Cách Chế Biến' : 'Preparation'}</h2>
            </header>

            <div className="cdp-festival-grid">
              {cuisine.recipeSteps.map((step, index) => (
                <div className="cdp-fest-card" key={`${step.stepLabel}-${index}`}>
                  <img src={step.imageUrl || cuisine.heroImageUrl} alt={step.imageAlt || step.title} className="cdp-fest-img" />
                  <div className="cdp-fest-content">
                    <span className="cdp-fest-tag">{step.stepLabel}</span>
                    <h3 className="cdp-fest-title">{step.title}</h3>
                    <p className="cdp-fest-desc">{step.desc}</p>
                  </div>
                </div>
              ))}
            </div>
          </div>
        </section>

        <section className="cdp-section cdp-section--cream cdp-music">
          <div className="cdp-container">
            <div className="cdp-arch__grid">
              <div className="cdp-arch-text">
                <span className="cdp-section-badge">{cuisine.howToEnjoy.badge}</span>
                <h2 className="cdp-section-title">{cuisine.howToEnjoy.title}</h2>
                <p className="cdp-intro__body">{cuisine.howToEnjoy.body}</p>
              </div>
              <div className="cdp-arch-image">
                <img src={cuisine.howToEnjoy.imageUrl || cuisine.heroImageUrl} alt={cuisine.howToEnjoy.imageAlt || cuisine.heroImageAlt} className="cdp-arch-img" />
              </div>
            </div>
          </div>
        </section>

        <section className="cdp-section cdp-section--light cdp-cuisine">
          <div className="cdp-container">
            <header className="cdp-section-header">
              <span className="cdp-section-badge">{lang === 'vi' ? 'Gợi ý thêm' : 'More to explore'}</span>
              <h2 className="cdp-section-title">{lang === 'vi' ? 'Món ăn tương tự' : 'Similar dishes'}</h2>
            </header>
            <div className="cdp-cuisine-grid">
              {similarFoods.map((food) => (
                <div className="cdp-cuisine-item" onClick={() => navigate(`/cuisine/${food.id}`)} style={{ cursor: 'pointer' }} key={food.id}>
                  <img src={food.imageUrl || cuisine.heroImageUrl} alt={food.imageAlt || food.title} className="cdp-cuisine-img" />
                  <h3 className="cdp-cuisine-title">{food.title}</h3>
                </div>
              ))}
            </div>
          </div>
        </section>

        <section className="cdp-section cdp-section--cream cdp-architecture">
          <div className="cdp-container">
            <div className="cdp-arch__grid">
              <div className="cdp-arch-image">
                <img src={cuisine.secretTip.imageUrl || cuisine.heroImageUrl} alt={cuisine.secretTip.imageAlt || cuisine.heroImageAlt} className="cdp-arch-img" />
              </div>
              <div className="cdp-arch-text">
                <span className="cdp-section-badge">{cuisine.secretTip.badge}</span>
                <h2 className="cdp-section-title">{cuisine.secretTip.title}</h2>
                <p className="cdp-intro__body">{cuisine.secretTip.body}</p>
              </div>
            </div>
          </div>
        </section>

        <section className="cdp-section cdp-section--light cdp-gallery">
          <div className="cdp-container">
            <header className="cdp-section-header">
              <h2 className="cdp-section-title">{lang === 'vi' ? 'Thư viện hình ảnh' : 'Image gallery'}</h2>
              <p className="cdp-section-subtitle">{lang === 'vi' ? `Góc nhìn chân thực, tinh tế về ${cuisine.name.toLowerCase()}.` : `A vivid visual look at ${cuisine.name}.`}</p>
            </header>

            <div className="cdp-gallery-grid">
              {galleryItems.map((item, index) => (
                <div key={item.id || index} className={`cdp-gallery-item ${item.size || ''}`.trim()}>
                  <img src={item.imageUrl || cuisine.heroImageUrl} alt={item.imageAlt || cuisine.heroImageAlt} />
                </div>
              ))}
            </div>
          </div>
        </section>

        <section className="cdp-cta-banner">
          <div className="cdp-container" style={{ textAlign: 'center' }}>
            <h2 className="cdp-cta-title" style={{ fontSize: '2rem', marginBottom: '24px', color: '#1a0a04' }}>{lang === 'vi' ? 'Khám phá nền ẩm thực Việt' : 'Explore Vietnamese cuisine'}</h2>
            <Link to="/cuisine" className="primary-button" style={{
              display: 'inline-flex', padding: '12px 32px', background: 'linear-gradient(90deg, #d97706, #dc2626)',
              color: 'white', borderRadius: '50px', fontWeight: 'bold', textDecoration: 'none'
            }}>
              {lang === 'vi' ? 'Trở lại danh sách món ăn' : 'Back to cuisine list'}
            </Link>
          </div>
        </section>
      </main>

      <Footer lang={lang} />
    </div>
  )
}

import { useEffect, useMemo, useState } from 'react'
import './HomePage.css'
import { getHomepage } from '../../services/homepage.service'
import { searchArticles } from '../../services/content.service'
import { ui } from '../../i18n/messages'
import PageHeader from '../../components/layout/PageHeader/PageHeader'
import Footer from '../../components/layout/Footer/Footer'

// Components
import HeroSection from './components/HeroSection'
import RegionSection from './components/RegionSection'
import EthnicGroupSection from './components/EthnicGroupSection'
import FestivalSection from './components/FestivalSection'
import CuisineSection from './components/CuisineSection'
import ArtsSection from './components/ArtsSection'

export default function HomePage() {
  const [lang, setLang] = useState('vi')
  const [homepage, setHomepage] = useState(null)
  const [status, setStatus] = useState('loading')
  const [error, setError] = useState('')
  const [search, setSearch] = useState('')
  const [results, setResults] = useState([])
  const [searching, setSearching] = useState(false)

  const copy = useMemo(() => ui[lang], [lang])
  const homepageData = homepage || {}
  const pageTitle = copy?.pageTitle || 'VietCultura'

  useEffect(() => {
    let ignore = false

    async function loadHomepage() {
      try {
        if (!homepageData.hero) setStatus('loading')
        setError('')

        const data = await getHomepage(lang)
        if (!ignore) {
          setHomepage(data)
          setStatus('success')
        }
      } catch (err) {
        if (!ignore) {
          setError(err?.message || 'Không thể tải trang chủ')
          setStatus('error')
        }
      }
    }

    loadHomepage()

    return () => { ignore = true }
  }, [lang, homepageData.hero])

  useEffect(() => {
    document.documentElement.lang = lang
    document.title = pageTitle
  }, [lang, pageTitle])

  async function handleSearch(event) {
    if (event) event.preventDefault()
    try {
      setSearching(true)
      const data = await searchArticles({ lang, q: search, limit: 6 })
      setResults(data)
    } finally {
      setSearching(false)
    }
  }

  const isLoading = status === 'loading'
  const isError = status === 'error'

  if (isError) {
    return (
      <div className="homepage-error">
        <h1>Error</h1>
        <p>{error}</p>
        <button onClick={() => window.location.reload()}>Retry</button>
      </div>
    )
  }

  if (isLoading && !homepage) {
    return (
      <div className="homepage-loader">
        <div className="spinner"></div>
        <p>{copy?.loading || 'Đang tải...'}</p>
      </div>
    )
  }

  return (
    <div className="homepage-root">
      <PageHeader lang={lang} onLangChange={setLang} />

      <main>
        <HeroSection
          hero={homepageData.hero}
          stats={homepageData.stats || []}
          search={search}
          setSearch={setSearch}
          handleSearch={handleSearch}
          searching={searching}
          results={results}
          copy={copy}
        />

        <RegionSection
          regions={homepageData.regions || []}
          copy={copy}
        />

        <EthnicGroupSection
          ethnicGroups={homepageData.ethnicGroups || []}
          stats={copy.ethnicShowcaseStats || []}
          copy={copy}
        />

        <FestivalSection
          festivals={homepageData.festivals || []}
          copy={copy}
        />

        <CuisineSection
          cuisine={homepageData.cuisine || []}
          copy={copy}
        />

        <ArtsSection
          featuredArt={(homepageData.arts || [])[0]}
          additionalArts={(homepageData.arts || []).slice(1, 7)}
          copy={copy}
          lang={lang}
        />

      </main>

      <Footer lang={lang} />
    </div>
  )
}

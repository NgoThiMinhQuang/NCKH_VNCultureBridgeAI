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
import BlogSection from './components/BlogSection'

export default function HomePage() {
  const [lang, setLang] = useState('vi')
  const [homepage, setHomepage] = useState(null)
  const [status, setStatus] = useState('loading')
  const [error, setError] = useState('')
  const [search, setSearch] = useState('')
  const [results, setResults] = useState([])
  const [searching, setSearching] = useState(false)

  const copy = useMemo(() => ui[lang], [lang])

  useEffect(() => {
    let ignore = false
    async function loadHomepage() {
      try {
        if (!homepage) setStatus('loading')
        setError('')
        const data = await getHomepage(lang)
        if (!ignore) {
          setHomepage(data)
          setStatus('success')
          document.documentElement.lang = lang
          document.title = copy.pageTitle
        }
      } catch (err) {
        if (!ignore) {
          setError(err.message)
          setStatus('error')
        }
      }
    }
    loadHomepage()
    return () => { ignore = true }
  }, [lang])

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

  const h = homepage || {}

  return (
    <div className="homepage-root">
      <PageHeader lang={lang} setLang={setLang} />
      
      <main className="page-content-shell">
        <HeroSection 
          hero={h.hero} 
          stats={h.stats || []}
          search={search}
          setSearch={setSearch}
          handleSearch={handleSearch}
          searching={searching}
          results={results}
          copy={copy}
        />

        <RegionSection 
          regions={h.regions || []} 
          copy={copy} 
        />

        <EthnicGroupSection 
          ethnicGroups={h.ethnicGroups || []} 
          stats={copy.ethnicShowcaseStats || []}
          copy={copy}
        />

        <FestivalSection 
          festivals={h.festivals || []} 
          copy={copy}
        />

        <CuisineSection 
          cuisine={h.cuisine || []} 
          copy={copy}
        />

        <ArtsSection 
          featuredArt={(h.arts || [])[0]}
          additionalArts={(h.arts || []).slice(1, 7)}
          copy={copy}
          lang={lang}
        />

        <BlogSection 
          featuredPost={(h.blogPosts || [])[0]}
          secondaryPosts={(h.blogPosts || []).slice(1, 4)}
          copy={copy}
          lang={lang}
        />
      </main>

      <Footer lang={lang} />
    </div>
  )
}

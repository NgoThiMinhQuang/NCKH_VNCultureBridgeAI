import { createContext, useCallback, useContext, useEffect, useMemo, useState } from 'react'
import { DEFAULT_LANGUAGE } from '../utils/constants'

/** @type {React.Context<{ lang: string, setLang: (lang: string) => void }>} */
const LanguageContext = createContext(null)

/**
 * Provider quản lý ngôn ngữ toàn cục (VI/EN).
 * Wrap quanh <App> hoặc <BrowserRouter>.
 */
export function LanguageProvider({ children }) {
  const [lang, setLangState] = useState(DEFAULT_LANGUAGE)

  useEffect(() => {
    document.documentElement.lang = lang
  }, [lang])

  const setLang = useCallback((nextLang) => {
    setLangState(nextLang)
  }, [])

  const value = useMemo(() => ({ lang, setLang }), [lang, setLang])

  return <LanguageContext.Provider value={value}>{children}</LanguageContext.Provider>
}

/**
 * Hook tiện ích để dùng LanguageContext.
 * @returns {{ lang: string, setLang: (lang: string) => void }}
 */
export function useLanguage() {
  const ctx = useContext(LanguageContext)
  if (!ctx) throw new Error('useLanguage phải được dùng bên trong <LanguageProvider>')
  return ctx
}

import { useEffect, useState } from 'react'

/**
 * Generic hook để load dữ liệu chi tiết từ một async loader function.
 * @template T
 * @param {(code: string, lang: string) => Promise<T>} loader
 * @param {string} lang
 * @param {string} code
 * @returns {{ status: 'loading'|'success'|'error', data: T|null, error: string }}
 */
export function useDetailLoader(loader, lang, code) {
  const [state, setState] = useState({ status: 'loading', data: null, error: '' })

  useEffect(() => {
    let ignore = false

    async function load() {
      try {
        setState({ status: 'loading', data: null, error: '' })
        const data = await loader(code, lang)
        if (!ignore) setState({ status: 'success', data, error: '' })
      } catch (error) {
        if (!ignore) setState({ status: 'error', data: null, error: error.message })
      }
    }

    load()
    return () => {
      ignore = true
    }
  }, [loader, code, lang])

  return state
}

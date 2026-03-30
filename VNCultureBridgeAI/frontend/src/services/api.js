const API_BASE = import.meta.env.VITE_API_BASE_URL || 'http://localhost:3001/api'

async function request(path) {
  const response = await fetch(`${API_BASE}${path}`)
  const payload = await response.json()

  if (!response.ok || !payload.ok) {
    throw new Error(payload.message || 'Request failed')
  }

  return payload.data
}

export function getHomepage(lang) {
  return request(`/homepage?lang=${lang}`)
}

export function getArticle(code, lang) {
  return request(`/articles/${code}?lang=${lang}`)
}

export function getRegion(code, lang) {
  return request(`/regions/${code}?lang=${lang}`)
}

export function getEthnicity(code, lang) {
  return request(`/ethnicities/${code}?lang=${lang}`)
}

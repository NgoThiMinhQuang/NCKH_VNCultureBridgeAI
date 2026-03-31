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

export function getRegions(lang) {
  return request(`/regions?lang=${lang}`)
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

export function searchArticles(params) {
  const query = new URLSearchParams(params).toString()
  return request(`/articles?${query}`)
}

export async function askAi(payload) {
  const response = await fetch(`${API_BASE}/ai/ask`, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
    },
    body: JSON.stringify(payload),
  })

  const result = await response.json()

  if (!response.ok || !result.ok) {
    throw new Error(result.message || 'Request failed')
  }

  return result.data
}

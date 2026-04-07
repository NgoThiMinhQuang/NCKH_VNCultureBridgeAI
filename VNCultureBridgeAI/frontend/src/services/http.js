import { API_BASE_URL } from '../utils/constants'

const getResponseCache = new Map()
const pendingGetRequests = new Map()

/**
 * Base HTTP GET request helper.
 * @param {string} path - API path (bắt đầu bằng /)
 * @param {{ cacheTtlMs?: number }} [options]
 * @returns {Promise<any>}
 */
export async function get(path, options = {}) {
  const url = `${API_BASE_URL}${path}`
  const cacheTtlMs = options.cacheTtlMs || 0
  const now = Date.now()

  if (cacheTtlMs > 0) {
    const cached = getResponseCache.get(url)
    if (cached && cached.expiresAt > now) {
      return cached.data
    }

    const pending = pendingGetRequests.get(url)
    if (pending) {
      return pending
    }
  }

  const request = fetch(url)
    .then(async (response) => {
      const payload = await response.json()
      if (!response.ok || !payload.ok) {
        throw new Error(payload.message || 'Request failed')
      }

      if (cacheTtlMs > 0) {
        getResponseCache.set(url, {
          data: payload.data,
          expiresAt: Date.now() + cacheTtlMs,
        })
      }

      return payload.data
    })
    .finally(() => {
      pendingGetRequests.delete(url)
    })

  if (cacheTtlMs > 0) {
    pendingGetRequests.set(url, request)
  }

  return request
}

/**
 * Base HTTP POST request helper.
 * @param {string} path
 * @param {object} body
 * @returns {Promise<any>}
 */
export async function post(path, body) {
  const response = await fetch(`${API_BASE_URL}${path}`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify(body),
  })
  const payload = await response.json()
  if (!response.ok || !payload.ok) {
    throw new Error(payload.message || 'Request failed')
  }
  return payload.data
}

import { API_BASE_URL } from '../utils/constants'

/**
 * Base HTTP GET request helper.
 * @param {string} path - API path (bắt đầu bằng /)
 * @returns {Promise<any>}
 */
export async function get(path) {
  const response = await fetch(`${API_BASE_URL}${path}`)
  const payload = await response.json()
  if (!response.ok || !payload.ok) {
    throw new Error(payload.message || 'Request failed')
  }
  return payload.data
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

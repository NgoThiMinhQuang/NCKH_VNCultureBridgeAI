import { get } from './http'

/**
 * Fetches blog overview data (featured, recent, popular).
 * @param {string} lang - 'vi' | 'en'
 * @param {number} page - Current page
 * @param {number} limit - Items per page
 */
export function getBlogOverview(lang = 'vi', page = 1, limit = 6) {
  return get(`/blog/data?lang=${lang}&page=${page}&limit=${limit}`)
}

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

/**
 * Fetches specific blog article detail.
 * @param {string} code - Article slug/code
 * @param {string} lang - 'vi' | 'en'
 */
export function getBlogDetail(code, lang = 'vi') {
  return get(`/articles/${code}?lang=${lang}`)
}

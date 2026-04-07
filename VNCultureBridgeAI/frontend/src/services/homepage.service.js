import { get } from './http'

const HOMEPAGE_CACHE_TTL_MS = 60 * 1000

export function getHomepage(lang) {
  return get(`/homepage?lang=${lang}`, { cacheTtlMs: HOMEPAGE_CACHE_TTL_MS })
}

import { get } from './http'

export function getRegions(lang) {
  return get(`/regions?lang=${lang}`)
}

export function getRegion(code, lang) {
  return get(`/regions/${code}?lang=${lang}`)
}

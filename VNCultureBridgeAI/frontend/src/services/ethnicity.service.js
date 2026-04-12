import { get } from './http'

export function getEthnicities(lang) {
  return get(`/ethnicities?lang=${lang}`)
}

export function getEthnicity(code, lang) {
  return get(`/ethnicities/${code}?lang=${lang}`)
}

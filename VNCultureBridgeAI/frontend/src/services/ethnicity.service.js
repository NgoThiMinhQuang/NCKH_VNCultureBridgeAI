import { get } from './http'

export function getEthnicity(code, lang) {
  return get(`/ethnicities/${code}?lang=${lang}`)
}

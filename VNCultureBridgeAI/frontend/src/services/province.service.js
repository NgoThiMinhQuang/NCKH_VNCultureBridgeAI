import { get } from './http'

export function getProvinces(lang) {
  return get(`/provinces?lang=${lang}`)
}

export function getProvince(code, lang) {
  return get(`/provinces/${code}?lang=${lang}`)
}

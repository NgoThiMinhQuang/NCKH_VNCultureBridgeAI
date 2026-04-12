import { get } from './http'

export function getProvinces(lang) {
  return get(`/provinces?lang=${lang}`)
}

export function getProvincesByRegion(region, lang) {
  return get(`/provinces?lang=${lang}&region=${region}`)
}

export function getProvince(code, lang) {
  return get(`/provinces/${code}?lang=${lang}`)
}

import { get } from './http'

export function getFestivals(lang) {
  return get(`/festivals?lang=${lang}`)
}

export function getFestival(id, lang) {
  return get(`/festivals/${id}?lang=${lang}`)
}

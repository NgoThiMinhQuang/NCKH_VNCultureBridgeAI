import { get } from './http'

export function getCuisines(lang) {
  return get(`/cuisines?lang=${lang}`)
}

export function getCuisine(code, lang) {
  return get(`/cuisines/${code}?lang=${lang}`)
}

export function getCuisineGallery(lang) {
  return get(`/cuisines/gallery?lang=${lang}`)
}

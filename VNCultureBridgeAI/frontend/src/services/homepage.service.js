import { get } from './http'

export function getHomepage(lang) {
  return get(`/homepage?lang=${lang}`)
}

import { get } from './http'

export function getArticle(code, lang) {
  return get(`/articles/${code}?lang=${lang}`)
}

export function searchArticles(params) {
  const query = new URLSearchParams(params).toString()
  return get(`/articles?${query}`)
}

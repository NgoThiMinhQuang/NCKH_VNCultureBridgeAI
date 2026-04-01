import { post } from './http'

export function askAi(payload) {
  return post('/ai/ask', payload)
}

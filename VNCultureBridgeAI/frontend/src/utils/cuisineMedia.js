import banner3 from '../assets/banner3.jpg'
import phoImg from '../assets/cuisine_pho.png'
import bunChaImg from '../assets/cuisine_bun_cha.png'
import banhMiImg from '../assets/cuisine_banh_mi.png'

const CUISINE_IMAGE_BY_KEY = {
  pho: phoImg,
  buncha: bunChaImg,
  bunchahanoi: bunChaImg,
  banhmi: banhMiImg,
}

function normalizeValue(value) {
  return String(value || '')
    .normalize('NFD')
    .replace(/[\u0300-\u036f]/g, '')
    .replace(/đ/g, 'd')
    .replace(/Đ/g, 'D')
    .replace(/[^a-zA-Z0-9]+/g, '')
    .toLowerCase()
    .trim()
}

function resolveCuisineKey(...values) {
  for (const value of values) {
    const normalized = normalizeValue(value)
    if (!normalized) continue

    if (CUISINE_IMAGE_BY_KEY[normalized]) {
      return normalized
    }

    if (normalized.includes('pho')) return 'pho'
    if (normalized.includes('buncha')) return 'buncha'
    if (normalized.includes('banhmi')) return 'banhmi'
  }

  return ''
}

export function getCuisineLocalImage(...values) {
  const key = resolveCuisineKey(...values)
  return CUISINE_IMAGE_BY_KEY[key] || banner3
}

export function getCuisineImageSet(...values) {
  const primaryImage = getCuisineLocalImage(...values)

  return {
    hero: primaryImage,
    intro: primaryImage,
    ingredients: [primaryImage, primaryImage, primaryImage],
    steps: [primaryImage, primaryImage, primaryImage],
    enjoy: primaryImage,
    tip: primaryImage,
    gallery: [primaryImage, primaryImage, primaryImage],
    similar: primaryImage,
    fallback: banner3,
  }
}

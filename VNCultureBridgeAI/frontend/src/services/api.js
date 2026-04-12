/**
 * Barrel export — re-exports tất cả API functions từ các service files.
 * Import từ đây vẫn hoạt động bình thường (backward-compatible).
 *
 * Nếu muốn import trực tiếp theo domain:
 *   import { getHomepage } from './homepage.service'
 *   import { getRegion } from './region.service'
 */
export { getHomepage } from './homepage.service'
export { getArticle, searchArticles } from './content.service'
export { getRegions, getRegion } from './region.service'
export { getFestivals, getFestival } from './festival.service'
export { getCuisines, getCuisine, getCuisineGallery } from './cuisine.service'
export { getEthnicity } from './ethnicity.service'
export { askAi } from './ai.service'

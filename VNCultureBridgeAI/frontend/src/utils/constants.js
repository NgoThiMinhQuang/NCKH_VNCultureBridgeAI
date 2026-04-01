/** Base URL của backend API */
export const API_BASE_URL = import.meta.env.VITE_API_BASE_URL || 'http://localhost:3001/api'

/** Các ngôn ngữ hỗ trợ */
export const LANGUAGES = /** @type {const} */ (['vi', 'en'])

/** Ngôn ngữ mặc định */
export const DEFAULT_LANGUAGE = 'vi'

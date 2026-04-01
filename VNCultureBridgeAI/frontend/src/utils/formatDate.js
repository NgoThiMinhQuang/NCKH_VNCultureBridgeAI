/**
 * Format a date value (ISO string or WCF /Date(...)/ format) to a locale string.
 * @param {string|number} value
 * @param {'vi'|'en'} lang
 * @returns {string}
 */
export function formatDate(value, lang) {
  if (!value) return ''
  const match = String(value).match(/\/(?:Date)\((\d+)\)\//)
  const timestamp = match ? Number(match[1]) : Date.parse(value)
  if (Number.isNaN(timestamp)) return ''
  return new Intl.DateTimeFormat(lang === 'vi' ? 'vi-VN' : 'en-US', {
    day: '2-digit',
    month: 'short',
    year: 'numeric',
  }).format(new Date(timestamp))
}

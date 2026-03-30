function looksBrokenEncoding(value) {
  if (typeof value !== 'string') return false

  return /[�?]/.test(value)
}

function safeString(value) {
  if (typeof value !== 'string') return value
  return value.trim()
}

function pickLocalized(row, viKey, enKey, lang = 'vi') {
  if (!row) return null

  const viValue = safeString(row[viKey])
  const enValue = safeString(row[enKey])
  const viBroken = looksBrokenEncoding(viValue)

  if (lang === 'en') {
    return enValue || viValue || null
  }

  if (viValue && !viBroken) {
    return viValue
  }

  return enValue || viValue || null
}

function normalizeLang(lang) {
  return String(lang || 'vi').toLowerCase() === 'en' ? 'en' : 'vi'
}

module.exports = {
  pickLocalized,
  normalizeLang,
  looksBrokenEncoding,
}

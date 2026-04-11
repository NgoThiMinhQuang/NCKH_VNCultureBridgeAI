function looksBrokenEncoding(value) {
  if (typeof value !== 'string') return false

  return /[�?]/.test(value) || /(Ã.|Ä.|áº|á»|Æ°|Ä‘|Æ¡|Æ¯)/.test(value)
}

function safeString(value) {
  if (typeof value !== 'string') return value
  return value.trim()
}

function fixMojibake(value) {
  if (typeof value !== 'string' || !value) return value
  if (!/(Ã.|Ä.|áº|á»|Æ°|Ä‘|Æ¡|Æ¯)/.test(value)) return value

  try {
    return Buffer.from(value, 'latin1').toString('utf8')
  } catch {
    return value
  }
}

function normalizeString(value) {
  if (typeof value !== 'string') return value
  return safeString(fixMojibake(value))
}

function pickLocalized(row, viKey, enKey, lang = 'vi') {
  if (!row) return null

  const viValue = normalizeString(row[viKey])
  const enValue = normalizeString(row[enKey])
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
  fixMojibake,
}

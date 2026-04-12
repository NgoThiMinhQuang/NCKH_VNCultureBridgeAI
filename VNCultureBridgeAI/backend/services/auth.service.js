const bcrypt = require('bcrypt')
const jwt = require('jsonwebtoken')
const authRepository = require('../repositories/auth.repository')

const EMAIL_REGEX = /^[^\s@]+@[^\s@]+\.[^\s@]+$/
const FULL_NAME_REGEX = /^[\p{L} ]+$/u
const SALT_ROUNDS = 10
const JWT_EXPIRES_IN = '7d'
const MIN_PASSWORD_LENGTH = 8
const PASSWORD_LETTER_REGEX = /[A-Za-z]/
const PASSWORD_NUMBER_REGEX = /\d/

function createHttpError(status, message) {
  const error = new Error(message)
  error.status = status
  return error
}

function normalizeEmail(email) {
  return String(email || '').trim().toLowerCase()
}

function normalizeFullName(fullName) {
  return String(fullName || '').trim().replace(/\s+/g, ' ')
}

function validateEmail(email) {
  return EMAIL_REGEX.test(email)
}

function validateFullName(fullName) {
  return fullName.length >= 2 && fullName.length <= 150 && FULL_NAME_REGEX.test(fullName)
}

function validatePassword(password) {
  return (
    password.length >= MIN_PASSWORD_LENGTH &&
    PASSWORD_LETTER_REGEX.test(password) &&
    PASSWORD_NUMBER_REGEX.test(password) &&
    !/\s/.test(password)
  )
}

function sanitizeUser(user, accountType) {
  return {
    id: user.id,
    fullName: user.fullName,
    email: user.email,
    accountType,
    role: accountType === 'staff' ? user.role : 'CUSTOMER',
    status: user.status,
  }
}

function signToken(user) {
  const secret = process.env.JWT_SECRET || 'vnculturebridge-dev-secret'

  return jwt.sign(
    {
      sub: String(user.id),
      email: user.email,
      accountType: user.accountType,
      role: user.role,
      status: user.status,
    },
    secret,
    { expiresIn: JWT_EXPIRES_IN },
  )
}

async function register({ fullName, email, password }) {
  const normalizedFullName = normalizeFullName(fullName)
  const normalizedEmail = normalizeEmail(email)
  const rawPassword = String(password || '')

  if (!normalizedFullName) {
    throw createHttpError(400, 'Họ và tên không được để trống')
  }

  if (!validateFullName(normalizedFullName)) {
    throw createHttpError(400, 'Họ và tên phải từ 2-150 ký tự và không chứa số hoặc ký tự đặc biệt')
  }

  if (!validateEmail(normalizedEmail)) {
    throw createHttpError(400, 'Email không hợp lệ')
  }

  if (!validatePassword(rawPassword)) {
    throw createHttpError(400, 'Mật khẩu phải có ít nhất 8 ký tự, gồm chữ và số, không chứa khoảng trắng')
  }

  const alreadyExists = await authRepository.emailExistsAnywhere(normalizedEmail)
  if (alreadyExists) {
    throw createHttpError(409, 'Email đã tồn tại trong hệ thống')
  }

  const passwordHash = await bcrypt.hash(rawPassword, SALT_ROUNDS)
  const customer = await authRepository.createCustomer({
    fullName: normalizedFullName,
    email: normalizedEmail,
    passwordHash,
  })

  if (!customer) {
    throw createHttpError(500, 'Không thể tạo tài khoản')
  }

  const user = sanitizeUser(customer, 'customer')
  return {
    token: signToken(user),
    user,
  }
}

async function login({ email, password }) {
  const normalizedEmail = normalizeEmail(email)
  const rawPassword = String(password || '')

  if (!validateEmail(normalizedEmail)) {
    throw createHttpError(400, 'Email không hợp lệ')
  }

  if (!rawPassword) {
    throw createHttpError(400, 'Mật khẩu không được để trống')
  }

  const staff = await authRepository.findStaffByEmail(normalizedEmail)
  const account = staff || await authRepository.findCustomerByEmail(normalizedEmail)
  const accountType = staff ? 'staff' : 'customer'

  if (!account) {
    throw createHttpError(401, 'Email hoặc mật khẩu không đúng')
  }

  if (account.status !== 'ACTIVE') {
    throw createHttpError(403, 'Tài khoản hiện không thể đăng nhập')
  }

  const passwordMatches = await bcrypt.compare(rawPassword, account.passwordHash)
  if (!passwordMatches) {
    throw createHttpError(401, 'Email hoặc mật khẩu không đúng')
  }

  const user = sanitizeUser(account, accountType)
  return {
    token: signToken(user),
    user,
  }
}

module.exports = {
  register,
  login,
}

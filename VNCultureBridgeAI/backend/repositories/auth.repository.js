const { query } = require('../db/sql')

async function findUserByEmail(email) {
  const rows = await query(`
    SELECT TOP 1
      NguoiDungID AS id,
      MaNguoiDung AS code,
      TenDangNhap AS username,
      HoTen AS fullName,
      Email AS email,
      MatKhau AS passwordHash,
      VaiTro AS role,
      TrangThai AS status
    FROM dbo.NguoiDung
    WHERE Email = @email OR TenDangNhap = @email
  `, { email })

  return rows[0] || null
}

async function emailExists(email) {
  const rows = await query(`
    SELECT TOP 1 Email
    FROM dbo.NguoiDung
    WHERE Email = @email
  `, { email })

  return rows.length > 0
}

async function createUser({ fullName, email, passwordHash, username }) {
  const code = 'U' + Date.now().toString().slice(-7)
  const rows = await query(`
    INSERT INTO dbo.NguoiDung (MaNguoiDung, TenDangNhap, HoTen, Email, MatKhau, VaiTro, TrangThai)
    OUTPUT INSERTED.NguoiDungID AS id, INSERTED.HoTen AS fullName, INSERTED.Email AS email, INSERTED.TrangThai AS status, INSERTED.VaiTro AS role
    VALUES (@code, @username, @fullName, @email, @passwordHash, 'USER', 'ACTIVE')
  `, { code, username: username || email, fullName, email, passwordHash })

  return rows[0] || null
}

module.exports = {
  findUserByEmail,
  emailExists,
  createUser,
  // Aliases for compatibility
  findStaffByEmail: findUserByEmail,
  findCustomerByEmail: findUserByEmail,
  emailExistsAnywhere: emailExists,
  createCustomer: createUser
}

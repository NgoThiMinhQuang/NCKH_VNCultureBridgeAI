const { query } = require('../db/sql')

async function findStaffByEmail(email) {
  const rows = await query(`
    SELECT TOP 1
      NguoiDungID AS id,
      HoTen AS fullName,
      Email AS email,
      MatKhauHash AS passwordHash,
      VaiTro AS role,
      TrangThai AS status
    FROM dbo.NguoiDung
    WHERE Email = @email
  `, { email })

  return rows[0] || null
}

async function findCustomerByEmail(email) {
  const rows = await query(`
    SELECT TOP 1
      KhachHangID AS id,
      HoTen AS fullName,
      Email AS email,
      MatKhauHash AS passwordHash,
      TrangThai AS status
    FROM dbo.KhachHang
    WHERE Email = @email
  `, { email })

  return rows[0] || null
}

async function emailExistsAnywhere(email) {
  const rows = await query(`
    SELECT TOP 1 Email
    FROM (
      SELECT Email FROM dbo.NguoiDung WHERE Email = @email
      UNION ALL
      SELECT Email FROM dbo.KhachHang WHERE Email = @email
    ) AS ExistingEmails
  `, { email })

  return rows.length > 0
}

async function createCustomer({ fullName, email, passwordHash }) {
  const rows = await query(`
    INSERT INTO dbo.KhachHang (HoTen, Email, MatKhauHash, TrangThai)
    OUTPUT INSERTED.KhachHangID AS id, INSERTED.HoTen AS fullName, INSERTED.Email AS email, INSERTED.TrangThai AS status
    VALUES (@fullName, @email, @passwordHash, 'ACTIVE')
  `, { fullName, email, passwordHash })

  return rows[0] || null
}

module.exports = {
  findStaffByEmail,
  findCustomerByEmail,
  emailExistsAnywhere,
  createCustomer,
}

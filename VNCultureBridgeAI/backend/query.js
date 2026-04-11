const sql = require('mssql');

const config = {
  server: 'DESKTOP-4AI2SO6\\SQLEXPRESS',
  database: 'VNCultureBridgeAI',
  options: {
    trustedConnection: true,
    encrypt: false,
    trustServerCertificate: true
  }
};

async function run() {
  try {
    await sql.connect(config);
    const res1 = await sql.query('SELECT DanTocID, MaDanToc, TenVI, ImageUrl FROM DanToc');
    console.log('DanToc:', res1.recordset);
    const res2 = await sql.query("SELECT BaiVietID, MaBaiViet, TieuDeVI, ImageUrl FROM BaiViet WHERE DanhMucID = (SELECT DanhMucID FROM DanhMuc WHERE MaDanhMuc = 'LE_HOI')");
    console.log('Festivals:', res2.recordset);
    const res3 = await sql.query("SELECT BaiVietID, MaBaiViet, TieuDeVI, ImageUrl FROM BaiViet WHERE DanhMucID = (SELECT DanhMucID FROM DanhMuc WHERE MaDanhMuc = 'AM_THUC')");
    console.log('Cuisine:', res3.recordset);
    const res4 = await sql.query("SELECT BaiVietID, MaBaiViet, TieuDeVI, ImageUrl FROM BaiViet WHERE DanhMucID = (SELECT DanhMucID FROM DanhMuc WHERE MaDanhMuc = 'NGHE_THUAT_DAN_GIAN')");
    console.log('Arts:', res4.recordset);
  } catch (e) {
    console.error(e);
  } finally {
    sql.close();
  }
}
run();

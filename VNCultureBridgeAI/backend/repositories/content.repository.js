const { query } = require('../db/sql')

function buildArticleFilters({ category, region, ethnicity, q }) {
  const filters = [
    `bv.TrangThaiDuyet = 'APPROVED'`,
    `bv.TrangThaiXuatBan = 'PUBLISHED'`,
  ]

  if (category) {
    filters.push(`dm.MaDanhMuc = @category`)
  }

  if (region) {
    filters.push(`vv.MaVung = @region`)
  }

  if (ethnicity) {
    filters.push(`dt.MaDanToc = @ethnicity`)
  }

  if (q) {
    filters.push(`(
      bv.TieuDeVI LIKE '%' + @q + '%' OR
      bv.TieuDeEN LIKE '%' + @q + '%' OR
      bv.MoTaNganVI LIKE '%' + @q + '%' OR
      bv.MoTaNganEN LIKE '%' + @q + '%'
    )`)
  }

  return filters.join('\n      AND ')
}

async function getArticles({ category, region, ethnicity, q, limit = 12 }) {
  const whereClause = buildArticleFilters({ category, region, ethnicity, q })

  return query(`
    SELECT TOP (${Number(limit) || 12})
      bv.BaiVietID,
      bv.MaBaiViet,
      bv.TieuDeVI,
      bv.TieuDeEN,
      bv.MoTaNganVI,
      bv.MoTaNganEN,
      bv.NgayXuatBan,
      MAX(CASE WHEN m.LaAnhChinh = 1 THEN m.UrlFile END) AS ImageUrl,
      MAX(CASE WHEN m.LaAnhChinh = 1 THEN m.AltTextVI END) AS AltTextVI,
      MAX(CASE WHEN m.LaAnhChinh = 1 THEN m.AltTextEN END) AS AltTextEN
    FROM dbo.BaiViet bv
    LEFT JOIN dbo.BaiViet_DanhMuc bvdm ON bvdm.BaiVietID = bv.BaiVietID
    LEFT JOIN dbo.DanhMuc dm ON dm.DanhMucID = bvdm.DanhMucID
    LEFT JOIN dbo.BaiViet_Vung bvv ON bvv.BaiVietID = bv.BaiVietID
    LEFT JOIN dbo.VungVanHoa vv ON vv.VungID = bvv.VungID
    LEFT JOIN dbo.BaiViet_DanToc bvdt ON bvdt.BaiVietID = bv.BaiVietID
    LEFT JOIN dbo.DanToc dt ON dt.DanTocID = bvdt.DanTocID
    LEFT JOIN dbo.Media m ON m.BaiVietID = bv.BaiVietID
    WHERE ${whereClause}
    GROUP BY bv.BaiVietID, bv.MaBaiViet, bv.TieuDeVI, bv.TieuDeEN, bv.MoTaNganVI, bv.MoTaNganEN, bv.NgayXuatBan
    ORDER BY bv.NgayXuatBan DESC, bv.BaiVietID DESC
  `, { category, region, ethnicity, q })
}

async function getArticleSearchMatches({ q, limit = 3 }) {
  const whereClause = buildArticleFilters({ q })

  return query(`
    SELECT TOP (${Number(limit) || 3})
      bv.BaiVietID,
      bv.MaBaiViet,
      bv.TieuDeVI,
      bv.TieuDeEN,
      bv.MoTaNganVI,
      bv.MoTaNganEN,
      bv.GioiThieuVI,
      bv.GioiThieuEN,
      bv.NguonGocVI,
      bv.NguonGocEN,
      bv.YNghiaVanHoaVI,
      bv.YNghiaVanHoaEN,
      bv.BoiCanhVI,
      bv.BoiCanhEN,
      bv.NoiDungChinhVI,
      bv.NoiDungChinhEN,
      bv.TomTatChoAIVI,
      bv.TomTatChoAIEN,
      bv.NgayXuatBan,
      MAX(CASE WHEN m.LaAnhChinh = 1 THEN m.UrlFile END) AS ImageUrl,
      MAX(CASE WHEN m.LaAnhChinh = 1 THEN m.AltTextVI END) AS AltTextVI,
      MAX(CASE WHEN m.LaAnhChinh = 1 THEN m.AltTextEN END) AS AltTextEN
    FROM dbo.BaiViet bv
    LEFT JOIN dbo.BaiViet_DanhMuc bvdm ON bvdm.BaiVietID = bv.BaiVietID
    LEFT JOIN dbo.DanhMuc dm ON dm.DanhMucID = bvdm.DanhMucID
    LEFT JOIN dbo.BaiViet_Vung bvv ON bvv.BaiVietID = bv.BaiVietID
    LEFT JOIN dbo.VungVanHoa vv ON vv.VungID = bvv.VungID
    LEFT JOIN dbo.BaiViet_DanToc bvdt ON bvdt.BaiVietID = bv.BaiVietID
    LEFT JOIN dbo.DanToc dt ON dt.DanTocID = bvdt.DanTocID
    LEFT JOIN dbo.Media m ON m.BaiVietID = bv.BaiVietID
    WHERE ${whereClause}
    GROUP BY bv.BaiVietID, bv.MaBaiViet, bv.TieuDeVI, bv.TieuDeEN, bv.MoTaNganVI, bv.MoTaNganEN, bv.GioiThieuVI, bv.GioiThieuEN, bv.NguonGocVI, bv.NguonGocEN, bv.YNghiaVanHoaVI, bv.YNghiaVanHoaEN, bv.BoiCanhVI, bv.BoiCanhEN, bv.NoiDungChinhVI, bv.NoiDungChinhEN, bv.TomTatChoAIVI, bv.TomTatChoAIEN, bv.NgayXuatBan
    ORDER BY bv.NgayXuatBan DESC, bv.BaiVietID DESC
  `, { q })
}

async function getArticleByCode(code) {
  const rows = await query(`
    SELECT TOP 1
      bv.BaiVietID,
      bv.MaBaiViet,
      bv.TieuDeVI,
      bv.TieuDeEN,
      bv.MoTaNganVI,
      bv.MoTaNganEN,
      bv.GioiThieuVI,
      bv.GioiThieuEN,
      bv.NguonGocVI,
      bv.NguonGocEN,
      bv.YNghiaVanHoaVI,
      bv.YNghiaVanHoaEN,
      bv.BoiCanhVI,
      bv.BoiCanhEN,
      bv.NoiDungChinhVI,
      bv.NoiDungChinhEN,
      bv.TomTatChoAIVI,
      bv.TomTatChoAIEN,
      bv.NgayXuatBan,
      MAX(CASE WHEN m.LaAnhChinh = 1 THEN m.UrlFile END) AS ImageUrl,
      MAX(CASE WHEN m.LaAnhChinh = 1 THEN m.AltTextVI END) AS AltTextVI,
      MAX(CASE WHEN m.LaAnhChinh = 1 THEN m.AltTextEN END) AS AltTextEN
    FROM dbo.BaiViet bv
    LEFT JOIN dbo.Media m ON m.BaiVietID = bv.BaiVietID
    WHERE bv.MaBaiViet = @code
      AND bv.TrangThaiDuyet = 'APPROVED'
      AND bv.TrangThaiXuatBan = 'PUBLISHED'
    GROUP BY bv.BaiVietID, bv.MaBaiViet, bv.TieuDeVI, bv.TieuDeEN, bv.MoTaNganVI, bv.MoTaNganEN, bv.GioiThieuVI, bv.GioiThieuEN, bv.NguonGocVI, bv.NguonGocEN, bv.YNghiaVanHoaVI, bv.YNghiaVanHoaEN, bv.BoiCanhVI, bv.BoiCanhEN, bv.NoiDungChinhVI, bv.NoiDungChinhEN, bv.TomTatChoAIVI, bv.TomTatChoAIEN, bv.NgayXuatBan
  `, { code })

  return rows[0] || null
}

async function getRegions() {
  return query(`
    SELECT VungID, MaVung, TenVI, TenEN, LoaiVung
    FROM dbo.VungVanHoa
    WHERE HoatDong = 1
    ORDER BY VungID ASC
  `)
}

async function getRegionByCode(code) {
  const rows = await query(`
    SELECT TOP 1 VungID, MaVung, TenVI, TenEN, LoaiVung
    FROM dbo.VungVanHoa
    WHERE HoatDong = 1 AND MaVung = @code
  `, { code })

  return rows[0] || null
}

async function getEthnicities() {
  return query(`
    SELECT DanTocID, MaDanToc, TenVI, TenEN, MoTaVI, MoTaEN
    FROM dbo.DanToc
    WHERE HoatDong = 1
    ORDER BY DanTocID ASC
  `)
}

async function getEthnicityByCode(code) {
  const rows = await query(`
    SELECT TOP 1 DanTocID, MaDanToc, TenVI, TenEN, MoTaVI, MoTaEN
    FROM dbo.DanToc
    WHERE HoatDong = 1 AND MaDanToc = @code
  `, { code })

  return rows[0] || null
}

module.exports = {
  getArticles,
  getArticleSearchMatches,
  getArticleByCode,
  getRegions,
  getRegionByCode,
  getEthnicities,
  getEthnicityByCode,
}

const { query } = require('../db/sql')

async function getFeaturedRegions() {
  return query(`
    SELECT
      vv.*,
      (SELECT COUNT(*) FROM dbo.BaiViet bv WHERE bv.VungID = vv.VungID) AS ArticleCount
    FROM dbo.VungVanHoa vv
    ORDER BY VungID ASC
  `)
}

async function getFeaturedEthnicGroups(limit = 6) {
  return query(`
    SELECT TOP (${Number(limit)})
      dt.*,
      (SELECT COUNT(*) FROM dbo.BaiViet bv WHERE bv.DanTocID = dt.DanTocID) AS ArticleCount
    FROM dbo.DanToc dt
    ORDER BY ThuTuHienThi ASC, ArticleCount DESC, DanTocID ASC
  `)
}

async function getLatestArticles(limit = 3) {
  return query(`
    SELECT TOP (${Number(limit)})
      bv.*,
      vv.TenVI AS CategoryTenVI, vv.TenEN AS CategoryTenEN -- Using ChuyenMuc mapping in service
    FROM dbo.BaiViet bv
    LEFT JOIN dbo.VungVanHoa vv ON bv.VungID = vv.VungID
    ORDER BY bv.NgayXuatBan DESC, bv.BaiVietID DESC
  `)
}

async function getFeaturedAmThuc(limit = 4) {
    return query(`
        SELECT TOP (${Number(limit)})
            at.*,
            at.MaMonAn as Ma -- Alias for compatibility
        FROM dbo.AmThuc at
        ORDER BY at.NgayTao DESC, at.AmThucID ASC
    `)
}

async function getFeaturedLeHoi(limit = 3) {
    return query(`
        SELECT TOP (${Number(limit)})
            lh.*
        FROM dbo.LeHoi lh
        ORDER BY lh.NgayTao DESC, lh.LeHoiID ASC
    `)
}

async function getFeaturedVanHoa(loai, limit = 6) {
    return query(`
        SELECT TOP (${Number(limit)})
            vh.*,
            (SELECT COUNT(*) FROM dbo.BaiViet bv WHERE bv.VanHoaID = vh.VanHoaID) AS ArticleCount
        FROM dbo.VanHoa vh
        WHERE @loai IS NULL OR vh.Loai = @loai
        ORDER BY vh.NgayTao DESC, vh.VanHoaID ASC
    `, { loai })
}

async function getPromptSamples() {
  return query(`
    SELECT TOP 3
      MaPrompt,
      LoaiPrompt,
      TenPrompt,
      NoiDungPrompt
    FROM dbo.MauPrompt
    ORDER BY MauPromptID ASC
  `)
}

module.exports = {
  getFeaturedRegions,
  getFeaturedEthnicGroups,
  getLatestArticles,
  getFeaturedAmThuc,
  getFeaturedLeHoi,
  getFeaturedVanHoa,
  getPromptSamples
}

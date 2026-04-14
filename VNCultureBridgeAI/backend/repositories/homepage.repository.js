const { query } = require('../db/sql')

async function getFeaturedRegions() {
  return query(`
    SELECT
      vv.VungID,
      vv.MaVung,
      vv.TenVI,
      vv.TenEN,
      vv.HomepageDisplayOrder,
      vv.HomepageBadgeVI,
      vv.HomepageTitleVI,
      vv.HomepageDescriptionVI,
      vv.HomepageHighlightsVI,
      vv.HomepageCtaVI,
      vv.HomepageImageUrl,
      vv.HomepageImageAltVI,
      COUNT(DISTINCT bv.BaiVietID) AS ArticleCount,
      COALESCE(vv.HomepageImageUrl, MAX(CASE WHEN m.LaAnhChinh = 1 THEN m.UrlFile END)) AS ImageUrl,
      COALESCE(vv.HomepageImageAltVI, MAX(CASE WHEN m.LaAnhChinh = 1 THEN m.AltTextVI END)) AS AltTextVI
    FROM dbo.VungVanHoa vv
    LEFT JOIN dbo.BaiViet_Vung bvv ON bvv.VungID = vv.VungID
    LEFT JOIN dbo.BaiViet bv ON bv.BaiVietID = bvv.BaiVietID
      AND bv.TrangThaiDuyet = 'APPROVED'
      AND bv.TrangThaiXuatBan = 'PUBLISHED'
    LEFT JOIN dbo.Media m ON m.BaiVietID = bv.BaiVietID
    WHERE vv.HoatDong = 1
      AND vv.HomepageEnabled = 1
    GROUP BY
      vv.VungID,
      vv.MaVung,
      vv.TenVI,
      vv.TenEN,
      vv.HomepageDisplayOrder,
      vv.HomepageBadgeVI,
      vv.HomepageTitleVI,
      vv.HomepageDescriptionVI,
      vv.HomepageHighlightsVI,
      vv.HomepageCtaVI,
      vv.HomepageImageUrl,
      vv.HomepageImageAltVI
    ORDER BY vv.HomepageDisplayOrder ASC, vv.VungID ASC
  `)
}

async function getFeaturedEthnicGroups() {
  return query(`
    SELECT TOP 6
      dt.DanTocID,
      dt.MaDanToc,
      dt.TenVI,
      dt.TenEN,
      dt.MoTaVI,
      dt.MoTaEN,
      COUNT(DISTINCT bv.BaiVietID) AS ArticleCount,
      COALESCE(dp.CardImageUrl, MAX(CASE WHEN m.LaAnhChinh = 1 THEN m.UrlFile END)) AS ImageUrl,
      COALESCE(dp.CardImageAltVI, MAX(CASE WHEN m.LaAnhChinh = 1 THEN m.AltTextVI END)) AS AltTextVI,
      COALESCE(dp.CardImageAltEN, MAX(CASE WHEN m.LaAnhChinh = 1 THEN m.AltTextEN END)) AS AltTextEN
    FROM dbo.DanToc dt
    LEFT JOIN dbo.DanTocProfile dp ON dp.DanTocID = dt.DanTocID AND dp.HoatDong = 1
    LEFT JOIN dbo.BaiViet_DanToc bvdt ON bvdt.DanTocID = dt.DanTocID
    LEFT JOIN dbo.BaiViet bv ON bv.BaiVietID = bvdt.BaiVietID
      AND bv.TrangThaiDuyet = 'APPROVED'
      AND bv.TrangThaiXuatBan = 'PUBLISHED'
    LEFT JOIN dbo.Media m ON m.BaiVietID = bv.BaiVietID
    WHERE dt.HoatDong = 1
    GROUP BY dt.DanTocID, dt.MaDanToc, dt.TenVI, dt.TenEN, dt.MoTaVI, dt.MoTaEN, dp.CardImageUrl, dp.CardImageAltVI, dp.CardImageAltEN
    ORDER BY ArticleCount DESC, dt.DanTocID ASC
  `)
}

async function getFeaturedArticlesByCategory(categoryCode, limit = 3) {
  return query(`
    SELECT TOP (${limit})
      bv.BaiVietID,
      bv.MaBaiViet,
      bv.TieuDeVI,
      bv.TieuDeEN,
      bv.MoTaNganVI,
      bv.MoTaNganEN,
      bv.NgayXuatBan,
      dm.MaDanhMuc,
      dm.TenVI AS CategoryTenVI,
      dm.TenEN AS CategoryTenEN,
      MAX(CASE WHEN m.LaAnhChinh = 1 THEN m.UrlFile END) AS ImageUrl,
      MAX(CASE WHEN m.LaAnhChinh = 1 THEN m.AltTextVI END) AS AltTextVI,
      MAX(CASE WHEN m.LaAnhChinh = 1 THEN m.AltTextEN END) AS AltTextEN
    FROM dbo.BaiViet bv
    JOIN dbo.BaiViet_DanhMuc bvdm ON bvdm.BaiVietID = bv.BaiVietID
    JOIN dbo.DanhMuc dm ON dm.DanhMucID = bvdm.DanhMucID
    LEFT JOIN dbo.Media m ON m.BaiVietID = bv.BaiVietID
    WHERE dm.MaDanhMuc = @categoryCode
      AND bv.TrangThaiDuyet = 'APPROVED'
      AND bv.TrangThaiXuatBan = 'PUBLISHED'
    GROUP BY bv.BaiVietID, bv.MaBaiViet, bv.TieuDeVI, bv.TieuDeEN, bv.MoTaNganVI, bv.MoTaNganEN, bv.NgayXuatBan, dm.MaDanhMuc, dm.TenVI, dm.TenEN
    ORDER BY
      MAX(CASE WHEN m.LaAnhChinh = 1 AND m.UrlFile IS NOT NULL AND LTRIM(RTRIM(m.UrlFile)) <> '' THEN 1 ELSE 0 END) DESC,
      CASE WHEN COALESCE(NULLIF(LTRIM(RTRIM(bv.MoTaNganVI)), ''), NULLIF(LTRIM(RTRIM(bv.MoTaNganEN)), '')) IS NOT NULL THEN 1 ELSE 0 END DESC,
      bv.NgayXuatBan DESC,
      bv.BaiVietID DESC
  `, { categoryCode })
}

async function getLatestArticles(limit = 3) {
  return query(`
    SELECT TOP (${limit})
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
    LEFT JOIN dbo.Media m ON m.BaiVietID = bv.BaiVietID
    WHERE bv.TrangThaiDuyet = 'APPROVED'
      AND bv.TrangThaiXuatBan = 'PUBLISHED'
    GROUP BY bv.BaiVietID, bv.MaBaiViet, bv.TieuDeVI, bv.TieuDeEN, bv.MoTaNganVI, bv.MoTaNganEN, bv.NgayXuatBan
    ORDER BY
      MAX(CASE WHEN m.LaAnhChinh = 1 AND m.UrlFile IS NOT NULL AND LTRIM(RTRIM(m.UrlFile)) <> '' THEN 1 ELSE 0 END) DESC,
      CASE WHEN COALESCE(NULLIF(LTRIM(RTRIM(bv.MoTaNganVI)), ''), NULLIF(LTRIM(RTRIM(bv.MoTaNganEN)), '')) IS NOT NULL THEN 1 ELSE 0 END DESC,
      bv.NgayXuatBan DESC,
      bv.BaiVietID DESC
  `)
}

async function getCategories() {
  return query(`
    SELECT
      dm.DanhMucID,
      dm.MaDanhMuc,
      dm.TenVI,
      dm.TenEN,
      dm.MoTaVI,
      dm.MoTaEN,
      COUNT(DISTINCT bv.BaiVietID) AS ArticleCount
    FROM dbo.DanhMuc dm
    LEFT JOIN dbo.BaiViet_DanhMuc bvdm ON bvdm.DanhMucID = dm.DanhMucID
    LEFT JOIN dbo.BaiViet bv ON bv.BaiVietID = bvdm.BaiVietID
      AND bv.TrangThaiDuyet = 'APPROVED'
      AND bv.TrangThaiXuatBan = 'PUBLISHED'
    WHERE dm.HoatDong = 1
    GROUP BY dm.DanhMucID, dm.MaDanhMuc, dm.TenVI, dm.TenEN, dm.MoTaVI, dm.MoTaEN
    ORDER BY ArticleCount DESC, dm.DanhMucID ASC
  `)
}

async function getPromptSamples() {
  return query(`
    SELECT TOP 3
      MaPrompt,
      LoaiPrompt,
      TenPrompt,
      NoiDungPrompt
    FROM dbo.MauPrompt
    WHERE HoatDong = 1
    ORDER BY MauPromptID ASC
  `)
}

async function getArtPageContent() {
  try {
    const rows = await query(`
      SELECT TOP 1 *
      FROM dbo.NgheThuatPage
      WHERE MaTrang = 'NGHE_THUAT'
        AND HoatDong = 1
      ORDER BY NgheThuatPageID DESC
    `)

    return rows[0] || null
  } catch (error) {
    if (error?.message?.includes("Invalid object name 'dbo.NgheThuatPage'")) {
      return null
    }
    throw error
  }
}

module.exports = {
  getFeaturedRegions,
  getFeaturedEthnicGroups,
  getFeaturedArticlesByCategory,
  getLatestArticles,
  getCategories,
  getPromptSamples,
  getArtPageContent,
}

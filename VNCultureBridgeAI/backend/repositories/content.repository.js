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
      MAX(dm.TenVI) AS CategoryTenVI,
      MAX(dm.TenEN) AS CategoryTenEN,
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
      dm.DanhMucID,
      dm.MaDanhMuc,
      dm.TenVI AS CategoryTenVI,
      dm.TenEN AS CategoryTenEN,
      MAX(CASE WHEN m.LaAnhChinh = 1 THEN m.UrlFile END) AS ImageUrl,
      MAX(CASE WHEN m.LaAnhChinh = 1 THEN m.AltTextVI END) AS AltTextVI,
      MAX(CASE WHEN m.LaAnhChinh = 1 THEN m.AltTextEN END) AS AltTextEN
    FROM dbo.BaiViet bv
    LEFT JOIN dbo.BaiViet_DanhMuc bvdm ON bvdm.BaiVietID = bv.BaiVietID AND bvdm.LaDanhMucChinh = 1
    LEFT JOIN dbo.DanhMuc dm ON dm.DanhMucID = bvdm.DanhMucID
    LEFT JOIN dbo.Media m ON m.BaiVietID = bv.BaiVietID
    WHERE bv.MaBaiViet = @code
      AND bv.TrangThaiDuyet = 'APPROVED'
      AND bv.TrangThaiXuatBan = 'PUBLISHED'
    GROUP BY bv.BaiVietID, bv.MaBaiViet, bv.TieuDeVI, bv.TieuDeEN, bv.MoTaNganVI, bv.MoTaNganEN, bv.GioiThieuVI, bv.GioiThieuEN, bv.NguonGocVI, bv.NguonGocEN, bv.YNghiaVanHoaVI, bv.YNghiaVanHoaEN, bv.BoiCanhVI, bv.BoiCanhEN, bv.NoiDungChinhVI, bv.NoiDungChinhEN, bv.TomTatChoAIVI, bv.TomTatChoAIEN, bv.NgayXuatBan, dm.DanhMucID, dm.MaDanhMuc, dm.TenVI, dm.TenEN
  `, { code })

  return rows[0] || null
}

async function getArticleMedia(code) {
  return query(`
    SELECT
      m.MediaID,
      m.BaiVietID,
      bv.MaBaiViet,
      m.LoaiMedia,
      m.UrlFile,
      m.AltTextVI,
      m.AltTextEN,
      m.ChuThichVI,
      m.ChuThichEN,
      m.LaAnhChinh,
      m.ThuTuHienThi
    FROM dbo.Media m
    JOIN dbo.BaiViet bv ON bv.BaiVietID = m.BaiVietID
    WHERE bv.MaBaiViet = @code
    ORDER BY m.LaAnhChinh DESC, m.ThuTuHienThi ASC, m.MediaID ASC
  `, { code })
}

async function getArticleRelated(code, categoryCode, limit = 3) {
  return query(`
    SELECT TOP (${Number(limit) || 3})
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
    LEFT JOIN dbo.Media m ON m.BaiVietID = bv.BaiVietID
    WHERE bv.TrangThaiDuyet = 'APPROVED'
      AND bv.TrangThaiXuatBan = 'PUBLISHED'
      AND bv.MaBaiViet <> @code
      AND (@categoryCode IS NULL OR dm.MaDanhMuc = @categoryCode)
    GROUP BY bv.BaiVietID, bv.MaBaiViet, bv.TieuDeVI, bv.TieuDeEN, bv.MoTaNganVI, bv.MoTaNganEN, bv.NgayXuatBan
    ORDER BY bv.NgayXuatBan DESC, bv.BaiVietID DESC
  `, { code, categoryCode })
}

async function getRegions() {
  return query(`
    SELECT
      vv.VungID,
      vv.MaVung,
      vv.TenVI,
      vv.TenEN,
      vv.LoaiVung,
      vv.HomepageBadgeVI,
      vv.HomepageTitleVI,
      vv.HomepageDescriptionVI,
      vv.HomepageHighlightsVI,
      vv.HomepageCtaVI,
      vv.HomepageImageUrl,
      vv.HomepageImageAltVI,
      vv.OverviewTitleVI,
      vv.OverviewTitleEN,
      vv.OverviewDescriptionVI,
      vv.OverviewDescriptionEN,
      vv.OverviewDetailsJsonVI,
      vv.OverviewDetailsJsonEN,
      COUNT(DISTINCT bv.BaiVietID) AS ArticleCount,
      COALESCE(vv.HomepageImageUrl, MAX(CASE WHEN m.LaAnhChinh = 1 THEN m.UrlFile END)) AS ImageUrl,
      COALESCE(vv.HomepageImageAltVI, MAX(CASE WHEN m.LaAnhChinh = 1 THEN m.AltTextVI END)) AS AltTextVI,
      MAX(CASE WHEN m.LaAnhChinh = 1 THEN m.AltTextEN END) AS AltTextEN
    FROM dbo.VungVanHoa vv
    LEFT JOIN dbo.BaiViet_Vung bvv ON bvv.VungID = vv.VungID
    LEFT JOIN dbo.BaiViet bv ON bv.BaiVietID = bvv.BaiVietID
      AND bv.TrangThaiDuyet = 'APPROVED'
      AND bv.TrangThaiXuatBan = 'PUBLISHED'
    LEFT JOIN dbo.Media m ON m.BaiVietID = bv.BaiVietID
    WHERE vv.HoatDong = 1
      AND vv.MaVung IN ('BAC_BO', 'TRUNG_BO', 'NAM_BO')
    GROUP BY
      vv.VungID,
      vv.MaVung,
      vv.TenVI,
      vv.TenEN,
      vv.LoaiVung,
      vv.HomepageBadgeVI,
      vv.HomepageTitleVI,
      vv.HomepageDescriptionVI,
      vv.HomepageHighlightsVI,
      vv.HomepageCtaVI,
      vv.HomepageImageUrl,
      vv.HomepageImageAltVI,
      vv.OverviewTitleVI,
      vv.OverviewTitleEN,
      vv.OverviewDescriptionVI,
      vv.OverviewDescriptionEN,
      vv.OverviewDetailsJsonVI,
      vv.OverviewDetailsJsonEN
    ORDER BY vv.VungID ASC
  `)
}

async function getRegionByCode(code) {
  const rows = await query(`
    SELECT TOP 1
      vv.VungID,
      vv.MaVung,
      vv.TenVI,
      vv.TenEN,
      vv.LoaiVung,
      vv.HomepageBadgeVI,
      vv.HomepageTitleVI,
      vv.HomepageDescriptionVI,
      vv.HomepageHighlightsVI,
      vv.HomepageCtaVI,
      vv.HomepageImageUrl,
      vv.HomepageImageAltVI,
      vv.OverviewTitleVI,
      vv.OverviewTitleEN,
      vv.OverviewDescriptionVI,
      vv.OverviewDescriptionEN,
      vv.OverviewDetailsJsonVI,
      vv.OverviewDetailsJsonEN,
      COUNT(DISTINCT bv.BaiVietID) AS ArticleCount,
      COALESCE(vv.HomepageImageUrl, MAX(CASE WHEN m.LaAnhChinh = 1 THEN m.UrlFile END)) AS ImageUrl,
      COALESCE(vv.HomepageImageAltVI, MAX(CASE WHEN m.LaAnhChinh = 1 THEN m.AltTextVI END)) AS AltTextVI,
      MAX(CASE WHEN m.LaAnhChinh = 1 THEN m.AltTextEN END) AS AltTextEN
    FROM dbo.VungVanHoa vv
    LEFT JOIN dbo.BaiViet_Vung bvv ON bvv.VungID = vv.VungID
    LEFT JOIN dbo.BaiViet bv ON bv.BaiVietID = bvv.BaiVietID
      AND bv.TrangThaiDuyet = 'APPROVED'
      AND bv.TrangThaiXuatBan = 'PUBLISHED'
    LEFT JOIN dbo.Media m ON m.BaiVietID = bv.BaiVietID
    WHERE vv.HoatDong = 1
      AND vv.MaVung IN ('BAC_BO', 'TRUNG_BO', 'NAM_BO')
      AND vv.MaVung = @code
    GROUP BY
      vv.VungID,
      vv.MaVung,
      vv.TenVI,
      vv.TenEN,
      vv.LoaiVung,
      vv.HomepageBadgeVI,
      vv.HomepageTitleVI,
      vv.HomepageDescriptionVI,
      vv.HomepageHighlightsVI,
      vv.HomepageCtaVI,
      vv.HomepageImageUrl,
      vv.HomepageImageAltVI,
      vv.OverviewTitleVI,
      vv.OverviewTitleEN,
      vv.OverviewDescriptionVI,
      vv.OverviewDescriptionEN,
      vv.OverviewDetailsJsonVI,
      vv.OverviewDetailsJsonEN
  `, { code })

  return rows[0] || null
}

async function getProvinces({ region, q, limit = 200 } = {}) {
  const filters = [`tt.HoatDong = 1`]

  if (region) {
    filters.push(`vv.MaVung = @region`)
  }

  if (q) {
    filters.push(`(
      tt.TenVI LIKE '%' + @q + '%' OR
      tt.TenEN LIKE '%' + @q + '%' OR
      vv.TenVI LIKE '%' + @q + '%' OR
      vv.TenEN LIKE '%' + @q + '%' OR
      tt.TagsTextVI LIKE '%' + @q + '%' OR
      tt.TagsTextEN LIKE '%' + @q + '%'
    )`)
  }

  return query(`
    SELECT TOP (${Number(limit) || 200})
      tt.TinhThanhID,
      tt.MaTinh,
      tt.TenVI,
      tt.TenEN,
      tt.LoaiTinhVI,
      tt.LoaiTinhEN,
      tt.TieuVungVI,
      tt.TieuVungEN,
      tt.AreaDisplayVI,
      tt.AreaDisplayEN,
      tt.PopulationDisplayVI,
      tt.PopulationDisplayEN,
      tt.TagsJsonVI,
      tt.TagsJsonEN,
      tt.TieuDePhuVI,
      tt.TieuDePhuEN,
      tt.TongQuanVI,
      tt.TongQuanEN,
      tt.AnhDaiDienUrl,
      tt.AnhDaiDienAltVI,
      tt.AnhDaiDienAltEN,
      vv.MaVung,
      vv.TenVI AS VungTenVI,
      vv.TenEN AS VungTenEN,
      tt.ThuTuHienThi
    FROM dbo.TinhThanh tt
    JOIN dbo.VungVanHoa vv ON vv.VungID = tt.VungID
    WHERE ${filters.join('\n      AND ')}
    ORDER BY tt.ThuTuHienThi ASC, tt.TinhThanhID ASC
  `, { region, q })
}

async function getProvinceByCode(code) {
  const rows = await query(`
    SELECT TOP 1
      tt.TinhThanhID,
      tt.MaTinh,
      tt.TenVI,
      tt.TenEN,
      tt.LoaiTinhVI,
      tt.LoaiTinhEN,
      tt.TieuVungVI,
      tt.TieuVungEN,
      tt.AreaDisplayVI,
      tt.AreaDisplayEN,
      tt.PopulationDisplayVI,
      tt.PopulationDisplayEN,
      tt.TagsJsonVI,
      tt.TagsJsonEN,
      tt.AnhDaiDienUrl,
      tt.AnhDaiDienAltVI,
      tt.AnhDaiDienAltEN,
      tt.TieuDePhuVI,
      tt.TieuDePhuEN,
      tt.TongQuanVI,
      tt.TongQuanEN,
      tt.ThoiTietMacDinhVI,
      tt.ThoiTietMacDinhEN,
      tt.ThoiDiemDepVI,
      tt.ThoiDiemDepEN,
      tt.ThongTinThanhLapVI,
      tt.ThongTinThanhLapEN,
      tt.ThongTinHanhChinhVI,
      tt.ThongTinHanhChinhEN,
      tt.MuiGio,
      tt.MaVungDienThoai,
      tt.HeroImageUrl,
      tt.HeroImageAltVI,
      tt.HeroImageAltEN,
      tt.SidebarImageUrl,
      tt.SidebarImageAltVI,
      tt.SidebarImageAltEN,
      tt.DiaDiemJsonVI,
      tt.DiaDiemJsonEN,
      tt.VanHoaJsonVI,
      tt.VanHoaJsonEN,
      tt.AmThucJsonVI,
      tt.AmThucJsonEN,
      tt.LichTrinhJsonVI,
      tt.LichTrinhJsonEN,
      vv.MaVung,
      vv.TenVI AS VungTenVI,
      vv.TenEN AS VungTenEN
    FROM dbo.TinhThanh tt
    JOIN dbo.VungVanHoa vv ON vv.VungID = tt.VungID
    WHERE tt.HoatDong = 1 AND tt.MaTinh = @code
  `, { code })

  return rows[0] || null
}

async function getEthnicities() {
  return query(`
    SELECT
      dt.DanTocID,
      dt.MaDanToc,
      dt.TenVI,
      dt.TenEN,
      dt.MoTaVI,
      dt.MoTaEN,
      COALESCE(dp.PrimaryRegionLabelVI, MAX(vv.TenVI)) AS PrimaryRegionNameVI,
      COALESCE(dp.PrimaryRegionLabelEN, MAX(vv.TenEN)) AS PrimaryRegionNameEN,
      MAX(vv.MaVung) AS PrimaryRegionCode,
      COALESCE(dp.CardImageUrl, MAX(CASE WHEN m.LaAnhChinh = 1 THEN m.UrlFile END)) AS CardImageUrl,
      COALESCE(dp.CardImageAltVI, MAX(CASE WHEN m.LaAnhChinh = 1 THEN m.AltTextVI END)) AS CardImageAltVI,
      COALESCE(dp.CardImageAltEN, MAX(CASE WHEN m.LaAnhChinh = 1 THEN m.AltTextEN END)) AS CardImageAltEN,
      dp.HeroBackgroundImageUrl,
      dp.HeroBackgroundAltVI,
      dp.HeroBackgroundAltEN,
      dp.HeroForegroundImageUrl,
      dp.HeroForegroundAltVI,
      dp.HeroForegroundAltEN,
      dp.ListBadgeVI,
      dp.ListBadgeEN,
      dp.IsNew,
      dp.DisplayOrder,
      COUNT(DISTINCT bv.BaiVietID) AS ArticleCount
    FROM dbo.DanToc dt
    LEFT JOIN dbo.DanTocProfile dp ON dp.DanTocID = dt.DanTocID AND dp.HoatDong = 1
    LEFT JOIN dbo.BaiViet_DanToc bvdt ON bvdt.DanTocID = dt.DanTocID
    LEFT JOIN dbo.BaiViet bv ON bv.BaiVietID = bvdt.BaiVietID
      AND bv.TrangThaiDuyet = 'APPROVED'
      AND bv.TrangThaiXuatBan = 'PUBLISHED'
    LEFT JOIN dbo.Media m ON m.BaiVietID = bv.BaiVietID
    LEFT JOIN dbo.BaiViet_Vung bvv ON bvv.BaiVietID = bv.BaiVietID
    LEFT JOIN dbo.VungVanHoa vv ON vv.VungID = bvv.VungID
    WHERE dt.HoatDong = 1
    GROUP BY
      dt.DanTocID,
      dt.MaDanToc,
      dt.TenVI,
      dt.TenEN,
      dt.MoTaVI,
      dt.MoTaEN,
      dp.PrimaryRegionLabelVI,
      dp.PrimaryRegionLabelEN,
      dp.CardImageUrl,
      dp.CardImageAltVI,
      dp.CardImageAltEN,
      dp.HeroBackgroundImageUrl,
      dp.HeroBackgroundAltVI,
      dp.HeroBackgroundAltEN,
      dp.HeroForegroundImageUrl,
      dp.HeroForegroundAltVI,
      dp.HeroForegroundAltEN,
      dp.ListBadgeVI,
      dp.ListBadgeEN,
      dp.IsNew,
      dp.DisplayOrder
    ORDER BY COALESCE(dp.DisplayOrder, 9999) ASC, ArticleCount DESC, dt.DanTocID ASC
  `)
}

async function getEthnicityByCode(code) {
  const rows = await query(`
    SELECT TOP 1
      dt.DanTocID,
      dt.MaDanToc,
      dt.TenVI,
      dt.TenEN,
      dt.MoTaVI,
      dt.MoTaEN,
      dp.HeroBackgroundImageUrl,
      dp.HeroBackgroundAltVI,
      dp.HeroBackgroundAltEN,
      dp.HeroForegroundImageUrl,
      dp.HeroForegroundAltVI,
      dp.HeroForegroundAltEN,
      dp.IntroImageUrl,
      dp.IntroImageAltVI,
      dp.IntroImageAltEN,
      dp.FeatureHighlightImageUrl,
      dp.FeatureHighlightAltVI,
      dp.FeatureHighlightAltEN,
      dp.MusicImageUrl,
      dp.MusicImageAltVI,
      dp.MusicImageAltEN,
      dp.ArchitectureImageUrl,
      dp.ArchitectureImageAltVI,
      dp.ArchitectureImageAltEN,
      dp.CardImageUrl,
      dp.CardImageAltVI,
      dp.CardImageAltEN,
      dp.HeroSubtitleVI,
      dp.HeroSubtitleEN,
      dp.OverviewTitleVI,
      dp.OverviewTitleEN,
      dp.OverviewBodyVI,
      dp.OverviewBodyEN,
      dp.HistoryTitleVI,
      dp.HistoryTitleEN,
      dp.HistoryBodyVI,
      dp.HistoryBodyEN,
      dp.CultureTitleVI,
      dp.CultureTitleEN,
      dp.CultureBodyVI,
      dp.CultureBodyEN,
      dp.ArchitectureTitleVI,
      dp.ArchitectureTitleEN,
      dp.ArchitectureBodyVI,
      dp.ArchitectureBodyEN,
      dp.PrimaryRegionLabelVI,
      dp.PrimaryRegionLabelEN,
      dp.PopulationLabelVI,
      dp.PopulationLabelEN,
      COUNT(DISTINCT bv.BaiVietID) AS ArticleCount,
      MAX(vv.MaVung) AS PrimaryRegionCode,
      MAX(vv.TenVI) AS PrimaryRegionNameVI,
      MAX(vv.TenEN) AS PrimaryRegionNameEN,
      MAX(CASE WHEN m.LaAnhChinh = 1 THEN m.UrlFile END) AS ArticleImageUrl,
      MAX(CASE WHEN m.LaAnhChinh = 1 THEN m.AltTextVI END) AS ArticleAltTextVI,
      MAX(CASE WHEN m.LaAnhChinh = 1 THEN m.AltTextEN END) AS ArticleAltTextEN
    FROM dbo.DanToc dt
    LEFT JOIN dbo.DanTocProfile dp ON dp.DanTocID = dt.DanTocID AND dp.HoatDong = 1
    LEFT JOIN dbo.BaiViet_DanToc bvdt ON bvdt.DanTocID = dt.DanTocID
    LEFT JOIN dbo.BaiViet bv ON bv.BaiVietID = bvdt.BaiVietID
      AND bv.TrangThaiDuyet = 'APPROVED'
      AND bv.TrangThaiXuatBan = 'PUBLISHED'
    LEFT JOIN dbo.Media m ON m.BaiVietID = bv.BaiVietID
    LEFT JOIN dbo.BaiViet_Vung bvv ON bvv.BaiVietID = bv.BaiVietID
    LEFT JOIN dbo.VungVanHoa vv ON vv.VungID = bvv.VungID
    WHERE dt.HoatDong = 1 AND UPPER(dt.MaDanToc) = UPPER(@code)
    GROUP BY
      dt.DanTocID,
      dt.MaDanToc,
      dt.TenVI,
      dt.TenEN,
      dt.MoTaVI,
      dt.MoTaEN,
      dp.HeroBackgroundImageUrl,
      dp.HeroBackgroundAltVI,
      dp.HeroBackgroundAltEN,
      dp.HeroForegroundImageUrl,
      dp.HeroForegroundAltVI,
      dp.HeroForegroundAltEN,
      dp.IntroImageUrl,
      dp.IntroImageAltVI,
      dp.IntroImageAltEN,
      dp.FeatureHighlightImageUrl,
      dp.FeatureHighlightAltVI,
      dp.FeatureHighlightAltEN,
      dp.MusicImageUrl,
      dp.MusicImageAltVI,
      dp.MusicImageAltEN,
      dp.ArchitectureImageUrl,
      dp.ArchitectureImageAltVI,
      dp.ArchitectureImageAltEN,
      dp.CardImageUrl,
      dp.CardImageAltVI,
      dp.CardImageAltEN,
      dp.HeroSubtitleVI,
      dp.HeroSubtitleEN,
      dp.OverviewTitleVI,
      dp.OverviewTitleEN,
      dp.OverviewBodyVI,
      dp.OverviewBodyEN,
      dp.HistoryTitleVI,
      dp.HistoryTitleEN,
      dp.HistoryBodyVI,
      dp.HistoryBodyEN,
      dp.CultureTitleVI,
      dp.CultureTitleEN,
      dp.CultureBodyVI,
      dp.CultureBodyEN,
      dp.ArchitectureTitleVI,
      dp.ArchitectureTitleEN,
      dp.ArchitectureBodyVI,
      dp.ArchitectureBodyEN,
      dp.PrimaryRegionLabelVI,
      dp.PrimaryRegionLabelEN,
      dp.PopulationLabelVI,
      dp.PopulationLabelEN
  `, { code })

  return rows[0] || null
}

async function getEthnicityFeatureArticles(limit = 6) {
  return query(`
    SELECT TOP (${Number(limit) || 6})
      item.DanTocSectionItemID,
      item.TieuDeVI,
      item.TieuDeEN,
      item.MoTaVI,
      item.MoTaEN,
      item.ImageUrl,
      item.ImageAltVI,
      item.ImageAltEN,
      item.TagVI,
      item.TagEN,
      item.LayoutSize,
      dt.MaDanToc,
      dt.TenVI AS EthnicityTenVI,
      dt.TenEN AS EthnicityTenEN,
      bv.MaBaiViet,
      bv.NgayXuatBan
    FROM dbo.DanTocSectionItem item
    JOIN dbo.DanToc dt ON dt.DanTocID = item.DanTocID
    LEFT JOIN dbo.BaiViet bv ON bv.BaiVietID = item.LienKetBaiVietID
    WHERE item.HoatDong = 1
      AND item.LoaiSection = 'FEATURES'
    ORDER BY item.ThuTuHienThi ASC, item.DanTocSectionItemID ASC
  `)
}

async function getEthnicityStoryItems(limit = 6) {
  return query(`
    SELECT TOP (${Number(limit) || 6})
      item.DanTocSectionItemID,
      item.TieuDeVI,
      item.TieuDeEN,
      item.MoTaVI,
      item.MoTaEN,
      item.ImageUrl,
      item.ImageAltVI,
      item.ImageAltEN,
      item.TagVI,
      item.TagEN,
      item.LayoutSize,
      dt.MaDanToc,
      dt.TenVI AS EthnicityTenVI,
      dt.TenEN AS EthnicityTenEN,
      bv.MaBaiViet,
      bv.NgayXuatBan
    FROM dbo.DanTocSectionItem item
    JOIN dbo.DanToc dt ON dt.DanTocID = item.DanTocID
    LEFT JOIN dbo.BaiViet bv ON bv.BaiVietID = item.LienKetBaiVietID
    WHERE item.HoatDong = 1
      AND item.LoaiSection = 'STORIES'
    ORDER BY item.ThuTuHienThi ASC, item.DanTocSectionItemID ASC
  `)
}

async function getEthnicitySectionItems(code, sectionType, limit = 10) {
  return query(`
    SELECT TOP (${Number(limit) || 10})
      item.DanTocSectionItemID,
      item.LoaiSection,
      item.TieuDeVI,
      item.TieuDeEN,
      item.MoTaVI,
      item.MoTaEN,
      item.ImageUrl,
      item.ImageAltVI,
      item.ImageAltEN,
      item.LayoutSize,
      item.TagVI,
      item.TagEN,
      item.ThuTuHienThi,
      bv.MaBaiViet,
      bv.NgayXuatBan
    FROM dbo.DanTocSectionItem item
    JOIN dbo.DanToc dt ON dt.DanTocID = item.DanTocID
    LEFT JOIN dbo.BaiViet bv ON bv.BaiVietID = item.LienKetBaiVietID
    WHERE item.HoatDong = 1
      AND item.LoaiSection = @sectionType
      AND UPPER(dt.MaDanToc) = UPPER(@code)
    ORDER BY item.ThuTuHienThi ASC, item.DanTocSectionItemID ASC
  `, { code, sectionType })
}

async function getEthnicityGallery(code, limit = 7) {
  return query(`
    SELECT TOP (${Number(limit) || 7})
      item.DanTocSectionItemID,
      item.ImageUrl,
      item.ImageAltVI,
      item.ImageAltEN,
      item.LayoutSize,
      item.MoTaVI,
      item.MoTaEN,
      bv.MaBaiViet
    FROM dbo.DanTocSectionItem item
    JOIN dbo.DanToc dt ON dt.DanTocID = item.DanTocID
    LEFT JOIN dbo.BaiViet bv ON bv.BaiVietID = item.LienKetBaiVietID
    WHERE item.HoatDong = 1
      AND item.LoaiSection = 'GALLERY'
      AND (@code IS NULL OR UPPER(dt.MaDanToc) = UPPER(@code))
    ORDER BY item.ThuTuHienThi ASC, item.DanTocSectionItemID ASC
  `, { code })
}

async function getFestivalPageContent() {
  const rows = await query(`
    SELECT TOP 1
      lh.LeHoiID,
      lh.MaLeHoi,
      lh.ThuTuHienThi,
      lh.PageBadgeVI,
      lh.PageBadgeEN,
      lh.PageTitleLine1VI,
      lh.PageTitleLine1EN,
      lh.PageTitleAccentVI,
      lh.PageTitleAccentEN,
      lh.PageTitleLine3VI,
      lh.PageTitleLine3EN,
      lh.PageSubtitleVI,
      lh.PageSubtitleEN,
      lh.PageStatsJsonVI,
      lh.PageStatsJsonEN,
      lh.TimelineItemsJsonVI,
      lh.TimelineItemsJsonEN,
      lh.GalleryImagesJsonVI,
      lh.GalleryImagesJsonEN,
      lh.PageHeroImageUrl,
      lh.PageHeroImageAltVI,
      lh.PageHeroImageAltEN,
      lh.SearchPlaceholderVI,
      lh.SearchPlaceholderEN,
      lh.FilterButtonVI,
      lh.FilterButtonEN,
      lh.AllRegionsVI,
      lh.AllRegionsEN,
      lh.AllMonthsVI,
      lh.AllMonthsEN,
      lh.AllCategoriesVI,
      lh.AllCategoriesEN,
      lh.AllEthnicGroupsVI,
      lh.AllEthnicGroupsEN,
      lh.MajorBadgeVI,
      lh.MajorBadgeEN,
      lh.MajorTitleVI,
      lh.MajorTitleEN,
      lh.MajorSubtitleVI,
      lh.MajorSubtitleEN,
      lh.AllTitleVI,
      lh.AllTitleEN,
      lh.AllSubtitleVI,
      lh.AllSubtitleEN,
      lh.TimelineBadgeVI,
      lh.TimelineBadgeEN,
      lh.TimelineTitleVI,
      lh.TimelineTitleEN,
      lh.TimelineSubtitleVI,
      lh.TimelineSubtitleEN,
      lh.TimelineHintVI,
      lh.TimelineHintEN,
      lh.GalleryBadgeVI,
      lh.GalleryBadgeEN,
      lh.GalleryTitleVI,
      lh.GalleryTitleEN,
      lh.GallerySubtitleVI,
      lh.GallerySubtitleEN,
      lh.MeaningBadgeVI,
      lh.MeaningBadgeEN,
      lh.MeaningTitleVI,
      lh.MeaningTitleEN,
      lh.MeaningParagraphsJsonVI,
      lh.MeaningParagraphsJsonEN,
      lh.MeaningButtonVI,
      lh.MeaningButtonEN,
      lh.MeaningButtonHref,
      lh.QuoteTitleVI,
      lh.QuoteTitleEN,
      lh.QuoteSubtitleVI,
      lh.QuoteSubtitleEN,
      lh.QuoteDescVI,
      lh.QuoteDescEN,
      lh.QuoteButtonVI,
      lh.QuoteButtonEN,
      lh.QuoteBackgroundImageUrl,
      lh.QuoteBackgroundImageAltVI,
      lh.QuoteBackgroundImageAltEN
    FROM dbo.LeHoi lh
    WHERE lh.HoatDong = 1 AND lh.LoaiBanGhi = 'PAGE'
    ORDER BY lh.ThuTuHienThi ASC, lh.LeHoiID ASC
  `)

  return rows[0] || null
}

async function getFestivals() {
  return query(`
    SELECT
      lh.LeHoiID,
      lh.MaLeHoi,
      lh.ThuTuHienThi,
      lh.ShortTitleVI,
      lh.ShortTitleEN,
      lh.TieuDeVI,
      lh.TieuDeEN,
      lh.TieuDePhuVI,
      lh.TieuDePhuEN,
      lh.MoTaNganVI,
      lh.MoTaNganEN,
      lh.ViTriVI,
      lh.ViTriEN,
      lh.NgayLeVI,
      lh.NgayLeEN,
      lh.TagVI,
      lh.TagEN,
      lh.TagColor,
      lh.ImageUrl,
      lh.ImageAltVI,
      lh.ImageAltEN,
      lh.TimelineMonthVI,
      lh.TimelineMonthEN,
      lh.TimelineSeasonVI,
      lh.TimelineSeasonEN,
      lh.TimelineImageUrl,
      lh.TimelineImageAltVI,
      lh.TimelineImageAltEN,
      lh.TimelineColor,
      lh.HeroDescVI,
      lh.HeroDescEN,
      lh.NoiDungJsonVI,
      lh.NoiDungJsonEN
    FROM dbo.LeHoi lh
    WHERE lh.HoatDong = 1 AND lh.LoaiBanGhi = 'FESTIVAL'
    ORDER BY lh.ThuTuHienThi ASC, lh.LeHoiID ASC
  `)
}

async function getFestivalById(id) {
  const rows = await query(`
    SELECT TOP 1
      lh.LeHoiID,
      lh.MaLeHoi,
      lh.ThuTuHienThi,
      lh.ShortTitleVI,
      lh.ShortTitleEN,
      lh.TieuDeVI,
      lh.TieuDeEN,
      lh.TieuDePhuVI,
      lh.TieuDePhuEN,
      lh.MoTaNganVI,
      lh.MoTaNganEN,
      lh.ViTriVI,
      lh.ViTriEN,
      lh.NgayLeVI,
      lh.NgayLeEN,
      lh.TagVI,
      lh.TagEN,
      lh.TagColor,
      lh.ImageUrl,
      lh.ImageAltVI,
      lh.ImageAltEN,
      lh.TimelineMonthVI,
      lh.TimelineMonthEN,
      lh.TimelineSeasonVI,
      lh.TimelineSeasonEN,
      lh.TimelineImageUrl,
      lh.TimelineImageAltVI,
      lh.TimelineImageAltEN,
      lh.TimelineColor,
      lh.HeroDescVI,
      lh.HeroDescEN,
      lh.NoiDungJsonVI,
      lh.NoiDungJsonEN
    FROM dbo.LeHoi lh
    WHERE lh.HoatDong = 1
      AND lh.LoaiBanGhi = 'FESTIVAL'
      AND (CAST(lh.LeHoiID AS NVARCHAR(50)) = @id OR lh.MaLeHoi = @id)
  `, { id })

  return rows[0] || null
}

async function getCuisineArticles(limit = 50) {
  return query(`
    SELECT TOP (${Number(limit) || 50})
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
      MAX(CASE WHEN m.LaAnhChinh = 1 THEN m.AltTextEN END) AS AltTextEN,
      MAX(vv.MaVung) AS RegionCode,
      MAX(vv.TenVI) AS RegionNameVI,
      MAX(vv.TenEN) AS RegionNameEN
    FROM dbo.BaiViet bv
    JOIN dbo.BaiViet_DanhMuc bvdm ON bvdm.BaiVietID = bv.BaiVietID
    JOIN dbo.DanhMuc dm ON dm.DanhMucID = bvdm.DanhMucID AND dm.MaDanhMuc = 'AM_THUC'
    LEFT JOIN dbo.BaiViet_Vung bvv ON bvv.BaiVietID = bv.BaiVietID AND bvv.LaVungChinh = 1
    LEFT JOIN dbo.VungVanHoa vv ON vv.VungID = bvv.VungID
    LEFT JOIN dbo.Media m ON m.BaiVietID = bv.BaiVietID
    WHERE bv.TrangThaiDuyet = 'APPROVED'
      AND bv.TrangThaiXuatBan = 'PUBLISHED'
    GROUP BY
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
      bv.NgayXuatBan
    ORDER BY bv.NgayXuatBan DESC, bv.BaiVietID DESC
  `)
}

async function getCuisineArticleByCode(code) {
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
      MAX(CASE WHEN m.LaAnhChinh = 1 THEN m.AltTextEN END) AS AltTextEN,
      MAX(vv.MaVung) AS RegionCode,
      MAX(vv.TenVI) AS RegionNameVI,
      MAX(vv.TenEN) AS RegionNameEN
    FROM dbo.BaiViet bv
    JOIN dbo.BaiViet_DanhMuc bvdm ON bvdm.BaiVietID = bv.BaiVietID
    JOIN dbo.DanhMuc dm ON dm.DanhMucID = bvdm.DanhMucID AND dm.MaDanhMuc = 'AM_THUC'
    LEFT JOIN dbo.BaiViet_Vung bvv ON bvv.BaiVietID = bv.BaiVietID AND bvv.LaVungChinh = 1
    LEFT JOIN dbo.VungVanHoa vv ON vv.VungID = bvv.VungID
    LEFT JOIN dbo.Media m ON m.BaiVietID = bv.BaiVietID
    WHERE bv.TrangThaiDuyet = 'APPROVED'
      AND bv.TrangThaiXuatBan = 'PUBLISHED'
      AND bv.MaBaiViet = @code
    GROUP BY
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
      bv.NgayXuatBan
  `, { code })

  return rows[0] || null
}

async function getCuisineArticleMedia(code, limit = 12) {
  return query(`
    SELECT TOP (${Number(limit) || 12})
      m.MediaID,
      m.BaiVietID,
      m.LoaiMedia,
      m.UrlFile,
      m.AltTextVI,
      m.AltTextEN,
      m.ChuThichVI,
      m.ChuThichEN,
      m.LaAnhChinh,
      m.ThuTuHienThi,
      bv.MaBaiViet,
      bv.TieuDeVI,
      bv.TieuDeEN,
      MAX(vv.MaVung) AS RegionCode,
      MAX(vv.TenVI) AS RegionNameVI,
      MAX(vv.TenEN) AS RegionNameEN
    FROM dbo.BaiViet bv
    JOIN dbo.BaiViet_DanhMuc bvdm ON bvdm.BaiVietID = bv.BaiVietID
    JOIN dbo.DanhMuc dm ON dm.DanhMucID = bvdm.DanhMucID AND dm.MaDanhMuc = 'AM_THUC'
    LEFT JOIN dbo.BaiViet_Vung bvv ON bvv.BaiVietID = bv.BaiVietID AND bvv.LaVungChinh = 1
    LEFT JOIN dbo.VungVanHoa vv ON vv.VungID = bvv.VungID
    JOIN dbo.Media m ON m.BaiVietID = bv.BaiVietID
    WHERE bv.TrangThaiDuyet = 'APPROVED'
      AND bv.TrangThaiXuatBan = 'PUBLISHED'
      AND bv.MaBaiViet = @code
      AND m.LoaiMedia = 'IMAGE'
    GROUP BY
      m.MediaID,
      m.BaiVietID,
      m.LoaiMedia,
      m.UrlFile,
      m.AltTextVI,
      m.AltTextEN,
      m.ChuThichVI,
      m.ChuThichEN,
      m.LaAnhChinh,
      m.ThuTuHienThi,
      bv.MaBaiViet,
      bv.TieuDeVI,
      bv.TieuDeEN
    ORDER BY m.LaAnhChinh DESC, m.ThuTuHienThi ASC, m.MediaID ASC
  `, { code })
}

async function getCuisineGalleryMedia(limit = 8) {
  return query(`
    SELECT TOP (${Number(limit) || 8})
      m.MediaID,
      m.BaiVietID,
      m.LoaiMedia,
      m.UrlFile,
      m.AltTextVI,
      m.AltTextEN,
      m.ChuThichVI,
      m.ChuThichEN,
      m.LaAnhChinh,
      m.ThuTuHienThi,
      bv.MaBaiViet,
      bv.TieuDeVI,
      bv.TieuDeEN,
      bv.NgayXuatBan,
      MAX(vv.MaVung) AS RegionCode,
      MAX(vv.TenVI) AS RegionNameVI,
      MAX(vv.TenEN) AS RegionNameEN
    FROM dbo.BaiViet bv
    JOIN dbo.BaiViet_DanhMuc bvdm ON bvdm.BaiVietID = bv.BaiVietID
    JOIN dbo.DanhMuc dm ON dm.DanhMucID = bvdm.DanhMucID AND dm.MaDanhMuc = 'AM_THUC'
    LEFT JOIN dbo.BaiViet_Vung bvv ON bvv.BaiVietID = bv.BaiVietID AND bvv.LaVungChinh = 1
    LEFT JOIN dbo.VungVanHoa vv ON vv.VungID = bvv.VungID
    JOIN dbo.Media m ON m.BaiVietID = bv.BaiVietID
    WHERE bv.TrangThaiDuyet = 'APPROVED'
      AND bv.TrangThaiXuatBan = 'PUBLISHED'
      AND m.LoaiMedia = 'IMAGE'
    GROUP BY
      m.MediaID,
      m.BaiVietID,
      m.LoaiMedia,
      m.UrlFile,
      m.AltTextVI,
      m.AltTextEN,
      m.ChuThichVI,
      m.ChuThichEN,
      m.LaAnhChinh,
      m.ThuTuHienThi,
      bv.MaBaiViet,
      bv.TieuDeVI,
      bv.TieuDeEN,
      bv.NgayXuatBan
    ORDER BY m.LaAnhChinh DESC, m.ThuTuHienThi ASC, bv.NgayXuatBan DESC, m.MediaID ASC
  `)
}

module.exports = {
  getArticles,
  getArticleSearchMatches,
  getArticleByCode,
  getRegions,
  getRegionByCode,
  getProvinces,
  getProvinceByCode,
  getEthnicities,
  getEthnicityByCode,
  getEthnicityFeatureArticles,
  getEthnicityStoryItems,
  getEthnicitySectionItems,
  getEthnicityGallery,
  getFestivalPageContent,
  getFestivals,
  getFestivalById,
  getCuisineArticles,
  getCuisineArticleByCode,
  getCuisineArticleMedia,
  getCuisineGalleryMedia,
}

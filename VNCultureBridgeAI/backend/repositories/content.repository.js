const { query } = require('../db/sql')

/**
 * Common filters for articles, cuisines, festivals, etc.
 */
function buildWhereClause(tableAlias, filters = {}) {
    const { region, ethnicity, category, q } = filters
    const conditions = []
    
    if (category) conditions.push(`${tableAlias}.ChuyenMuc = @category`)
    if (region) conditions.push(`${tableAlias}.VungID IN (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = @region)`)
    if (ethnicity) conditions.push(`${tableAlias}.DanTocID IN (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = @ethnicity)`)
    
    if (q) {
        conditions.push(`(${tableAlias}.TenVI LIKE '%' + @q + '%' OR ${tableAlias}.TenEN LIKE '%' + @q + '%' OR ${tableAlias}.MoTaNganVI LIKE '%' + @q + '%')`)
    }
    
    return conditions.length > 0 ? `WHERE ${conditions.join(' AND ')}` : ''
}

// 1. ARTICLES (BaiViet)
async function getArticles(filters = {}) {
    const { limit = 12, offset = 0 } = filters
    const where = buildWhereClause('bv', filters)
    
    return query(`
        SELECT 
            bv.*,
            vv.TenVI AS VungTenVI, vv.TenEN AS VungTenEN,
            dt.TenVI AS DanTocTenVI, dt.TenEN AS DanTocTenEN
        FROM dbo.BaiViet bv
        LEFT JOIN dbo.VungVanHoa vv ON bv.VungID = vv.VungID
        LEFT JOIN dbo.DanToc dt ON bv.DanTocID = dt.DanTocID
        ${where}
        ORDER BY bv.NgayXuatBan DESC, bv.BaiVietID DESC
        OFFSET ${Number(offset)} ROWS
        FETCH NEXT ${Number(limit)} ROWS ONLY
    `, filters)
}

async function countArticles(filters = {}) {
    const where = buildWhereClause('bv', filters)
    const rows = await query(`SELECT COUNT(*) as total FROM dbo.BaiViet bv ${where}`, filters)
    return rows[0]?.total || 0
}

async function getArticleByCode(code) {
    const rows = await query(`
        SELECT TOP 1
            bv.*,
            vv.TenVI AS VungTenVI, vv.TenEN AS VungTenEN,
            dt.TenVI AS DanTocTenVI, dt.TenEN AS DanTocTenEN
        FROM dbo.BaiViet bv
        LEFT JOIN dbo.VungVanHoa vv ON bv.VungID = vv.VungID
        LEFT JOIN dbo.DanToc dt ON bv.DanTocID = dt.DanTocID
        WHERE bv.MaBaiViet = @code
    `, { code })
    return rows[0] || null
}

// 2. REGIONS (VungVanHoa)
async function getVungVanHoa() {
    return query(`SELECT * FROM dbo.VungVanHoa ORDER BY VungID ASC`)
}

async function getVungByCode(code) {
    const rows = await query(`SELECT TOP 1 * FROM dbo.VungVanHoa WHERE MaVung = @code`, { code })
    return rows[0] || null
}

// 3. ETHNICITIES (DanToc)
async function getEthnics() {
    return query(`SELECT * FROM dbo.DanToc ORDER BY ThuTuHienThi ASC, DanTocID ASC`)
}

async function getEthnicityByCode(code) {
    const rows = await query(`SELECT TOP 1 * FROM dbo.DanToc WHERE MaDanToc = @code`, { code })
    return rows[0] || null
}

// 4. PROVINCES (TinhThanh)
async function getAllProvinces() {
    return query(`
        SELECT 
            tt.*, 
            vv.MaVung, 
            vv.TenVI AS VungTenVI, 
            vv.TenEN AS VungTenEN 
        FROM dbo.TinhThanh tt 
        JOIN dbo.VungVanHoa vv ON tt.VungID = vv.VungID 
        ORDER BY tt.ThuTuHienThi ASC
    `)
}

async function getProvincesByVung(vungId) {
    return query(`SELECT * FROM dbo.TinhThanh WHERE VungID = @vungId ORDER BY ThuTuHienThi ASC`, { vungId })
}

async function getProvinceByCode(code) {
    const rows = await query(`SELECT TOP 1 * FROM dbo.TinhThanh WHERE MaTinh = @code`, { code })
    return rows[0] || null
}

// 5. CUISINE (AmThuc)
async function getAmThucExtended(filters = {}) {
    const { limit = 50 } = filters
    const where = buildWhereClause('at', filters)
    
    return query(`
        SELECT TOP (${Number(limit)})
            at.*,
            vv.TenVI AS VungTenVI, vv.TenEN AS VungTenEN,
            tt.TenVI AS TinhTenVI, tt.TenEN AS TinhTenEN,
            dt.TenVI AS DanTocTenVI, dt.TenEN AS DanTocTenEN
        FROM dbo.AmThuc at
        LEFT JOIN dbo.VungVanHoa vv ON at.VungID = vv.VungID
        LEFT JOIN dbo.TinhThanh tt ON at.TinhThanhID = tt.TinhThanhID
        LEFT JOIN dbo.DanToc dt ON at.DanTocID = dt.DanTocID
        ${where}
        ORDER BY at.NgayTao DESC, at.AmThucID DESC
    `, filters)
}

// 6. FESTIVALS (LeHoi)
async function getFestivalsExtended(filters = {}) {
    const { limit = 50 } = filters
    return query(`
        SELECT TOP (${Number(limit)})
            lh.*,
            vv.MaVung, vv.TenVI AS VungTenVI, vv.TenEN AS VungTenEN,
            dt.TenVI AS DanTocTenVI, dt.TenEN AS DanTocTenEN
        FROM dbo.LeHoi lh
        LEFT JOIN dbo.VungVanHoa vv ON lh.VungID = vv.VungID
        LEFT JOIN dbo.DanToc dt ON lh.DanTocID = dt.DanTocID
        ORDER BY lh.NgayTao DESC, lh.LeHoiID DESC
    `)
}

// 7. GALLERY & MEDIA
async function getGalleryForArticle(baiVietId) {
    return query(`SELECT * FROM dbo.HinhAnh WHERE BaiVietID = @baiVietId ORDER BY ThuTu ASC`, { baiVietId })
}

async function getGalleryByDanTocId(danTocId, limit = 12) {
    return query(`SELECT TOP (${Number(limit)}) * FROM dbo.HinhAnh WHERE DanTocID = @danTocId ORDER BY ThuTu ASC`, { danTocId })
}

async function getGlobalGallery(limit = 12) {
    return query(`SELECT TOP (${Number(limit)}) Url as imageUrl, MoTaVI as altVI, MoTaEN as altEN FROM dbo.HinhAnh ORDER BY HinhAnhID DESC`)
}

// 8. STATS
async function getGlobalStats() {
    const [counts] = await query(`
        SELECT 
            (SELECT COUNT(*) FROM dbo.DanToc) as ethnicGroupCount,
            (SELECT COUNT(*) FROM dbo.VungVanHoa) as regionCount,
            (SELECT COUNT(*) FROM dbo.BaiViet) as articleCount,
            (SELECT COUNT(*) FROM dbo.HinhAnh) as galleryCount
    `)
    return counts
}

// 9. CROSS-REFERENCE HELPERS
async function getLeHoiByMaDanToc(danTocId) {
    return query(`SELECT * FROM dbo.LeHoi WHERE DanTocID = @danTocId`, { danTocId })
}

async function getAmThucByMaDanToc(danTocId) {
    return query(`SELECT * FROM dbo.AmThuc WHERE DanTocID = @danTocId`, { danTocId })
}

async function getVanHoaByMaDanToc(danTocId) {
    return query(`SELECT * FROM dbo.VanHoa WHERE DanTocID = @danTocId`, { danTocId })
}

async function getArticlesByDanTocId(danTocId, limit = 5) {
    return query(`SELECT TOP (${Number(limit)}) * FROM dbo.BaiViet WHERE DanTocID = @danTocId ORDER BY NgayXuatBan DESC`, { danTocId })
}

module.exports = {
    getArticles,
    countArticles,
    getArticleByCode,
    getVungVanHoa,
    getVungByCode,
    getEthnics,
    getEthnicityByCode,
    getAllProvinces,
    getProvincesByVung,
    getProvinceByCode,
    getAmThucExtended,
    getFestivalsExtended,
    getGalleryForArticle,
    getGalleryByDanTocId,
    getGlobalGallery,
    getGlobalStats,
    getLeHoiByMaDanToc,
    getAmThucByMaDanToc,
    getVanHoaByMaDanToc,
    getArticlesByDanTocId
}

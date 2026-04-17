const contentRepository = require('../repositories/content.repository')
const { pickLocalized } = require('../utils/locale')

function mapText(row, viKey, enKey, lang) {
    return pickLocalized(row, viKey, enKey, lang)
}

function mapArticleCard(row, lang) {
    if (!row) return null
    
    const categoryMap = {
        'NGHE_THUAT_DAN_GIAN': lang === 'vi' ? 'Nghệ thuật & Di sản' : 'Arts & Heritage',
        'AM_THUC': lang === 'vi' ? 'Ẩm thực' : 'Cuisine',
        'LE_HOI': lang === 'vi' ? 'Lễ hội' : 'Festivals',
        'VAN_HOA': lang === 'vi' ? 'Văn hóa' : 'Culture'
    }

    return {
        id: row.BaiVietID,
        code: row.MaBaiViet,
        title: mapText(row, 'TieuDeVI', 'TieuDeEN', lang),
        description: mapText(row, 'MoTaNganVI', 'MoTaNganEN', lang),
        imageUrl: row.ImageUrl || '/img/default-article.jpg',
        publishedAt: row.NgayXuatBan || new Date().toISOString(),
        category: categoryMap[row.ChuyenMuc] || (lang === 'vi' ? 'Văn hóa' : 'Culture'),
        author: row.TacGia || (lang === 'vi' ? 'Ban biên tập' : 'Editorial team'),
        readingTime: row.ThoiGianDoc || (lang === 'vi' ? '5 phút' : '5 min')
    }
}

async function getBlogData(req, res) {
    try {
        const lang = req.query.lang || 'vi'
        const page = parseInt(req.query.page) || 1
        const limit = parseInt(req.query.limit) || 6
        const offset = (page - 1) * limit
        
        // Fetch total count for pagination
        const totalItems = await contentRepository.countArticles()
        
        // Fetch paged articles for the "Recent" section
        const pagedArticles = await contentRepository.getArticles({ limit, offset })
        const recent = pagedArticles.map(a => mapArticleCard(a, lang))
        
        // Fetch 4 featured articles (always from start or separate logic)
        const featuredRaw = await contentRepository.getArticles({ limit: 4, offset: 0 })
        const featured = featuredRaw.map(a => mapArticleCard(a, lang))
        
        // Popular Articles (placeholder: take 3)
        const popularRaw = await contentRepository.getArticles({ limit: 3, offset: 0 })
        const popular = popularRaw.map(a => ({
            id: a.BaiVietID,
            code: a.MaBaiViet,
            title: mapText(a, 'TieuDeVI', 'TieuDeEN', lang),
            publishedAt: a.NgayXuatBan,
            views: '1.2k',
            imageUrl: a.ImageUrl
        }))
        
        // Trending Topics
        const trending = lang === 'vi' 
            ? ['Văn hóa', 'Ẩm thực', 'Du lịch', 'Lễ hội', 'Nghệ thuật', 'Truyền thống', 'Vùng miền', 'Di sản']
            : ['Culture', 'Cuisine', 'Travel', 'Festivals', 'Arts', 'Tradition', 'Regions', 'Heritage']

        res.json({
            ok: true,
            data: {
                featured,
                recent,
                popular,
                trending,
                pagination: {
                    totalItems,
                    totalPages: Math.ceil(totalItems / limit),
                    currentPage: page,
                    itemsPerPage: limit
                }
            }
        })
    } catch (error) {
        console.error('Error in getBlogData:', error)
        res.status(500).json({
            ok: false,
            message: 'Internal server error'
        })
    }
}

module.exports = {
    getBlogData
}

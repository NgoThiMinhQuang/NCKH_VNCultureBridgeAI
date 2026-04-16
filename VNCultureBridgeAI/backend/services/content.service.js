const contentRepository = require('../repositories/content.repository')
const homepageRepository = require('../repositories/homepage.repository')
const { pickLocalized } = require('../utils/locale')

function mapText(row, viKey, enKey, lang) {
    return pickLocalized(row, viKey, enKey, lang)
}

/**
 * Maps a basic article card for lists
 */
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
        imageUrl: row.ImageUrl || null,
        publishedAt: row.NgayXuatBan || null,
        category: categoryMap[row.ChuyenMuc] || (lang === 'vi' ? 'Văn hóa' : 'Culture'),
        author: row.TacGia || (lang === 'vi' ? 'Ban biên tập' : 'Editorial team')
    }
}

async function getHomepageData(lang) {
    const [regions, ethnics, latestArticles, amThuc, festivals, arts, promptSamples] = await Promise.all([
        homepageRepository.getFeaturedRegions(),
        homepageRepository.getFeaturedEthnicGroups(6),
        homepageRepository.getLatestArticles(3),
        homepageRepository.getFeaturedAmThuc(4),
        homepageRepository.getFeaturedLeHoi(3),
        homepageRepository.getFeaturedVanHoa('NGHE_THUAT', 6),
        homepageRepository.getPromptSamples()
    ])

    const stats = lang === 'vi' ? [
        { label: 'Dân tộc', value: '54' },
        { label: 'Di sản', value: '100+' },
        { label: 'Người dùng', value: '200+' }
    ] : [
        { label: 'Ethnicities', value: '54' },
        { label: 'Heritages', value: '100+' },
        { label: 'Users', value: '200+' }
    ]

    return {
        hero: {
            badge: lang === 'vi' ? 'Hành trình di sản' : 'Heritage Journey',
            title: lang === 'vi' ? 'Khám Phá Di Sản Văn Hóa Việt Nam' : 'Discover Vietnam\'s Cultural Heritage',
            subtitle: lang === 'vi' ? 'Kết nối 54 dân tộc anh em qua những câu chuyện, lễ hội và tinh hoa ẩm thực.' : 'Connecting 54 ethnic groups through stories, festivals, and culinary arts.',
            primaryCta: lang === 'vi' ? 'Khám phá ngay' : 'Explore Now',
            secondaryCta: lang === 'vi' ? 'Xem lễ hội' : 'View Festivals'
        },
        stats,
        regions: regions.map(r => ({
            id: r.VungID,
            code: r.MaVung,
            title: mapText(r, 'TenVI', 'TenEN', lang),
            description: mapText(r, 'MoTaVI', 'MoTaEN', lang),
            imageUrl: r.ImageUrl,
            icon: r.Icon || '⛰️',
            articleCount: r.ArticleCount
        })),
        ethnicGroups: ethnics.map(e => ({
            id: e.DanTocID,
            code: e.MaDanToc,
            title: mapText(e, 'TenVI', 'TenEN', lang),
            description: mapText(e, 'OverviewVI', 'OverviewEN', lang),
            imageUrl: e.ImageUrl,
            articleCount: e.ArticleCount
        })),
        festivals: festivals.map((l, index) => ({
            id: l.LeHoiID,
            code: l.MaLeHoi,
            title: mapText(l, 'TenVI', 'TenEN', lang),
            description: mapText(l, 'MoTaNganVI', 'MoTaNganEN', lang),
            badge: lang === 'vi' ? 'Lễ hội' : 'Festival',
            subtitle: mapText(l, 'ThoiGianVI', 'ThoiGianEN', lang),
            metaPrimary: mapText(l, 'DiaDiemVI', 'DiaDiemEN', lang),
            imageUrl: l.ImageUrl,
            accent: ['red', 'gold', 'purple'][index % 3]
        })),
        cuisine: amThuc.map(at => ({
            id: at.AmThucID,
            code: at.Ma,
            title: mapText(at, 'TenVI', 'TenEN', lang),
            subtitle: lang === 'vi' ? 'Tinh hoa ẩm thực' : 'Culinary Essence',
            description: mapText(at, 'MoTaNganVI', 'MoTaNganEN', lang),
            imageUrl: at.ImageUrl,
            tags: lang === 'vi' ? ['Đặc sản', 'Truyền thống'] : ['Specialty', 'Traditional'],
            footerIcon: '⭐⭐⭐⭐⭐'
        })),
        arts: arts.map(v => ({
            id: v.VanHoaID,
            code: v.Ma,
            title: mapText(v, 'TenVI', 'TenEN', lang),
            category: lang === 'vi' ? 'Nghệ thuật' : 'Art',
            description: mapText(v, 'MoTaNganVI', 'MoTaNganEN', lang),
            imageUrl: v.ImageUrl,
            articleCount: v.ArticleCount
        })),
        blogPosts: latestArticles.map(a => mapArticleCard(a, lang)),
        aiGuide: {
            prompts: promptSamples.map(p => ({
                id: p.MaPrompt,
                title: p.TenPrompt,
                text: p.NoiDungPrompt
            }))
        }
    }
}

// STANDARD LIST/DETAIL FUNCTIONS
async function getArticles(filters, lang) {
    const rows = await contentRepository.getArticles(filters)
    return rows.map(r => mapArticleCard(r, lang))
}

async function getArticleDetail(code, lang) {
    const row = await contentRepository.getArticleByCode(code)
    if (!row) return null
    const gallery = await contentRepository.getGalleryForArticle(row.BaiVietID)
    
    return {
        ...mapArticleCard(row, lang),
        content: mapText(row, 'NoiDungVI', 'NoiDungEN', lang),
        vung: mapText(row, 'VungTenVI', 'VungTenEN', lang),
        danToc: mapText(row, 'DanTocTenVI', 'DanTocTenEN', lang),
        gallery: gallery.map(g => ({ url: g.Url, caption: mapText(g, 'MoTaVI', 'MoTaEN', lang) }))
    }
}

async function getEthnicityDetail(code, lang) {
    const ethnicity = await contentRepository.getEthnicityByCode(code)
    if (!ethnicity) return null

    const [vanHoa, leHoi, amThuc, articles, dbGallery] = await Promise.all([
        contentRepository.getVanHoaByMaDanToc(ethnicity.DanTocID),
        contentRepository.getLeHoiByMaDanToc(ethnicity.DanTocID),
        contentRepository.getAmThucByMaDanToc(ethnicity.DanTocID),
        contentRepository.getArticlesByDanTocId(ethnicity.DanTocID, 4),
        contentRepository.getGalleryByDanTocId(ethnicity.DanTocID, 12)
    ])

    return {
        id: ethnicity.DanTocID,
        code: ethnicity.MaDanToc,
        name: mapText(ethnicity, 'TenVI', 'TenEN', lang),
        hero: {
            badge: mapText(ethnicity, 'PhanLoaiVI', 'PhanLoaiEN', lang) || (lang === 'vi' ? 'Dân tộc Việt Nam' : 'Vietnamese Ethnic Group'),
            title: mapText(ethnicity, 'TenVI', 'TenEN', lang),
            subtitle: mapText(ethnicity, 'OverviewVI', 'OverviewEN', lang)?.substring(0, 200) + '...',
            backgroundImageUrl: ethnicity.BannerUrl || ethnicity.ImageUrl,
            foregroundImageUrl: ethnicity.ImageUrl,
            stats: [
                { label: lang === 'vi' ? 'Dân số' : 'Population', value: ethnicity.DanSo || '---' },
                { label: lang === 'vi' ? 'Lễ hội' : 'Festivals', value: leHoi.length.toString() },
                { label: lang === 'vi' ? 'Bài viết' : 'Articles', value: articles.length.toString() }
            ]
        },
        overview: {
            title: lang === 'vi' ? `Hành trình di sản ${ethnicity.TenVI}` : `The Heritage of ${ethnicity.TenEN}`,
            content: mapText(ethnicity, 'OverviewVI', 'OverviewEN', lang),
            imageUrl: ethnicity.ImageUrl
        },
        history: {
            title: lang === 'vi' ? 'Nguồn gốc & Lịch sử' : 'Origin & History',
            content: mapText(ethnicity, 'LichSuVI', 'LichSuEN', lang)
        },
        sections: {
            cuisine: amThuc.map(at => ({ id: at.AmThucID, title: mapText(at, 'TenVI', 'TenEN', lang), imageUrl: at.ImageUrl })),
            festivals: leHoi.map(lh => ({ id: lh.LeHoiID, title: mapText(lh, 'TenVI', 'TenEN', lang), imageUrl: lh.ImageUrl })),
            arts: vanHoa.map(vh => ({ id: vh.VanHoaID, title: mapText(vh, 'TenVI', 'TenEN', lang), imageUrl: vh.ImageUrl }))
        },
        gallery: dbGallery.map((g, idx) => ({ id: g.HinhAnhID, imageUrl: g.Url, imageAlt: mapText(g, 'MoTaVI', 'MoTaEN', lang) })),
        relatedArticles: articles.map(a => mapArticleCard(a, lang))
    }
}

async function listRegions(lang) {
    const rows = await contentRepository.getVungVanHoa()
    return rows.map(r => ({
        id: r.MaVung,
        code: r.MaVung,
        name: mapText(r, 'TenVI', 'TenEN', lang),
        title: mapText(r, 'TenVI', 'TenEN', lang),
        description: mapText(r, 'MoTaVI', 'MoTaEN', lang),
        imageUrl: r.ImageUrl,
        icon: r.Icon
    }))
}

async function getRegion(code, lang) {
    const r = await contentRepository.getVungByCode(code)
    if (!r) return null
    const stats = await contentRepository.getGlobalStats()
    return {
        id: r.MaVung,
        code: r.MaVung,
        name: mapText(r, 'TenVI', 'TenEN', lang),
        title: mapText(r, 'TenVI', 'TenEN', lang),
        imageUrl: r.ImageUrl,
        description: mapText(r, 'MoTaVI', 'MoTaEN', lang),
        articleCount: stats.articleCount
    }
}

async function listProvinces(options, lang) {
    const rows = await contentRepository.getAllProvinces()
    return rows.map(r => ({
        id: r.MaTinh,
        code: r.MaTinh,
        name: mapText(r, 'TenVI', 'TenEN', lang),
        description: mapText(r, 'TongQuanVI', 'TongQuanEN', lang),
        imageUrl: r.HeroImageUrl || r.AnhDaiDienUrl,
        regionCode: r.MaVung,
        region: lang === 'vi' ? r.VungTenVI : r.VungTenEN
    }))
}

async function listEthnicities(lang) {
    const rows = await contentRepository.getEthnics()
    return {
        ethnicities: rows.map(r => ({
            id: r.MaDanToc,
            name: mapText(r, 'TenVI', 'TenEN', lang),
            image: r.ImageUrl,
            region: mapText(r, 'PhanLoaiVI', 'PhanLoaiEN', lang)
        }))
    }
}

async function listFestivals(lang) {
    const rows = await contentRepository.getFestivalsExtended()
    const stats = await contentRepository.getGlobalStats()
    return {
        festivals: rows.map(f => ({
            id: f.LeHoiID,
            code: f.MaLeHoi,
            title: mapText(f, 'TenVI', 'TenEN', lang),
            desc: mapText(f, 'MoTaNganVI', 'MoTaNganEN', lang),
            location: mapText(f, 'DiaDiemVI', 'DiaDiemEN', lang),
            date: mapText(f, 'ThoiGianVI', 'ThoiGianEN', lang),
            image: f.ImageUrl,
            region: f.MaVung?.toLowerCase()
        })),
        page: {
            titleLine1: lang === 'vi' ? 'Tinh hoa' : 'Essence of',
            titleAccent: lang === 'vi' ? 'Lễ hội' : 'Festivals',
            stats: [
                { value: '8,000+', label: lang === 'vi' ? 'Lễ hội hàng năm' : 'Annual Festivals' },
                { value: stats.ethnicGroupCount.toString(), label: lang === 'vi' ? 'Dân tộc' : 'Ethnic Groups' }
            ]
        }
    }
}

async function listCuisines(filters, lang) {
    const rows = await contentRepository.getAmThucExtended(filters)
    return {
        cards: rows.map(r => ({
            id: r.AmThucID,
            code: r.MaMonAn,
            name: mapText(r, 'TenVI', 'TenEN', lang),
            location: mapText(r, 'TinhTenVI', 'TinhTenEN', lang),
            imageUrl: r.ImageUrl
        }))
    }
}

async function askAi({ question, lang }) {
    return {
        answer: lang === 'vi' 
            ? `Tôi là trợ lý AI Văn hóa Việt Nam. Bạn vừa hỏi về "${question}".`
            : `I am your Vietnam Culture AI assistant. You asked about "${question}".`
    }
}

module.exports = {
    getArticles,
    getArticleDetail,
    getEthnicityDetail,
    getHomepageData,
    listRegions,
    getRegion,
    listProvinces,
    listEthnicities,
    listFestivals,
    listCuisines,
    askAi,
    // Aliases
    listArticles: getArticles,
    getArticle: getArticleDetail,
    getEthnicity: getEthnicityDetail,
    getProvince: async (code, lang) => {
        const r = await contentRepository.getProvinceByCode(code)
        return r ? { id: r.MaTinh, name: mapText(r, 'TenVI', 'TenEN', lang), desc: mapText(r, 'TongQuanVI', 'TongQuanEN', lang), image: r.HeroImageUrl } : null
    },
    getFestival: async (id, lang) => {
        const rows = await contentRepository.getFestivalsExtended()
        const row = rows.find(r => r.MaLeHoi === id || r.LeHoiID.toString() === id)
        return row ? { id: row.LeHoiID, title: mapText(row, 'TenVI', 'TenEN', lang), content: mapText(row, 'NoiDungChiTietVI', 'NoiDungChiTietEN', lang), image: row.ImageUrl } : null
    },
    getCuisineDetail: async (code, lang) => {
        const rows = await contentRepository.getAmThucExtended()
        const row = rows.find(r => r.MaMonAn === code)
        return row ? { id: row.AmThucID, title: mapText(row, 'TenVI', 'TenEN', lang), content: mapText(row, 'NoiDungChiTietVI', 'NoiDungChiTietEN', lang), imageUrl: row.ImageUrl } : null
    }
}

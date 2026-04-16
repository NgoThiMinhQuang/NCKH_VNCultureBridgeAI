const homepageRepository = require('../repositories/homepage.repository')
const { pickLocalized } = require('../utils/locale')

function mapText(row, viKey, enKey, lang) {
    return pickLocalized(row, viKey, enKey, lang)
}

/**
 * Simplified homepage service for Schema v5.0
 */
async function getHomepage(lang = 'vi') {
    const [regions, ethnics, articles, amThuc, festivals, arts, prompts] = await Promise.all([
        homepageRepository.getFeaturedRegions(),
        homepageRepository.getFeaturedEthnicGroups(8),
        homepageRepository.getLatestArticles(12),
        homepageRepository.getFeaturedAmThuc(4),
        homepageRepository.getFeaturedLeHoi(3),
        homepageRepository.getFeaturedVanHoa(null, 6),
        homepageRepository.getPromptSamples()
    ])
    console.log('DEBUG: Fetched ethnics count:', ethnics.length);

    // Hero section (static fallback as used in previous logic or from DB if available)
    const hero = lang === 'vi' ? {
        badge: 'Hành trình di sản',
        title: 'Khám Phá Di Sản Văn Hóa Việt Nam',
        subtitle: 'Kết nối 54 dân tộc anh em qua những câu chuyện, lễ hội và tinh hoa ẩm thực.',
        primaryCta: 'Khám phá ngay',
        secondaryCta: 'Xem lễ hội'
    } : {
        badge: 'Heritage Journey',
        title: 'Discover Vietnam\'s Cultural Heritage',
        subtitle: 'Connecting 54 ethnic groups through stories, festivals, and culinary arts.',
        primaryCta: 'Explore Now',
        secondaryCta: 'View Festivals'
    }

    const stats = lang === 'vi' ? [
        { label: 'Dân tộc', value: '54' },
        { label: 'Di sản', value: '100+' },
        { label: 'Người dùng', value: '250+' }
    ] : [
        { label: 'Ethnicities', value: '54' },
        { label: 'Heritages', value: '100+' },
        { label: 'Users', value: '250+' }
    ]

    return {
        hero,
        stats,
        regions: regions.map((r, idx) => ({
            id: r.VungID,
            code: r.MaVung,
            number: String(idx + 1).padStart(2, '0'),
            badge: mapText(r, 'TenVI', 'TenEN', lang),
            title: mapText(r, 'TenVI', 'TenEN', lang),
            description: mapText(r, 'MoTaVI', 'MoTaEN', lang),
            imageUrl: r.ImageUrl,
            highlights: lang === 'vi' ? ['Văn hóa', 'Ẩm thực', 'Con người'] : ['Culture', 'Cuisine', 'People'],
            cta: lang === 'vi' ? `Khám phá ${r.TenVI}` : `Explore ${r.TenEN}`,
            accentClass: r.MaVung === 'BAC_BO' ? 'is-north' : r.MaVung === 'TRUNG_BO' ? 'is-central' : 'is-south'
        })),
        ethnicGroups: ethnics.map(e => ({
            id: e.DanTocID,
            code: e.MaDanToc,
            title: mapText(e, 'TenVI', 'TenEN', lang),
            description: mapText(e, 'OverviewVI', 'OverviewEN', lang)?.substring(0, 100) + '...',
            imageUrl: e.ImageUrl,
            articleCount: e.ArticleCount
        })),
        festivals: festivals.map((l, idx) => ({
            id: l.LeHoiID,
            code: l.MaLeHoi,
            title: mapText(l, 'TenVI', 'TenEN', lang),
            subtitle: mapText(l, 'ThoiGianVI', 'ThoiGianEN', lang),
            description: mapText(l, 'MoTaNganVI', 'MoTaNganEN', lang),
            imageUrl: l.ImageUrl,
            badge: lang === 'vi' ? 'Lễ hội' : 'Festival',
            metaPrimary: mapText(l, 'DiaDiemVI', 'DiaDiemEN', lang),
            accent: ['red', 'gold', 'purple'][idx % 3]
        })),
        cuisine: amThuc.map(at => ({
            id: at.AmThucID,
            code: at.Ma,
            title: mapText(at, 'TenVI', 'TenEN', lang),
            description: mapText(at, 'MoTaNganVI', 'MoTaNganEN', lang),
            imageUrl: at.ImageUrl,
            subtitle: lang === 'vi' ? 'Đặc sản vùng miền' : 'Regional Specialty'
        })),
        arts: arts.map(v => ({
            id: v.VanHoaID,
            code: v.Ma,
            title: mapText(v, 'TenVI', 'TenEN', lang),
            description: mapText(v, 'MoTaNganVI', 'MoTaNganEN', lang),
            imageUrl: v.ImageUrl,
            category: v.Loai === 'NGHE_THUAT' ? (lang === 'vi' ? 'Nghệ thuật' : 'Art') : (lang === 'vi' ? 'Di sản' : 'Heritage')
        })),
        blogPosts: articles.slice(0, 3).map(a => ({
            id: a.BaiVietID,
            code: a.MaBaiViet,
            title: mapText(a, 'TieuDeVI', 'TieuDeEN', lang),
            description: mapText(a, 'MoTaNganVI', 'MoTaNganEN', lang),
            imageUrl: a.ImageUrl,
            publishedAt: a.NgayXuatBan,
            category: lang === 'vi' ? 'Văn hóa' : 'Culture'
        })),
        aiGuide: {
            title: lang === 'vi' ? 'Trợ lý AI Văn hóa' : 'Culture AI Assistant',
            subtitle: lang === 'vi' ? 'Hỏi bất cứ điều gì về 54 dân tộc Việt Nam' : 'Ask anything about Vietnam\'s 54 ethnic groups',
            prompts: prompts.map(p => ({
                id: p.MaPrompt,
                title: p.TenPrompt,
                text: p.NoiDungPrompt
            }))
        },
        footer: {
            title: 'VN Culture Bridge',
            description: lang === 'vi' ? 'Kết nối giá trị văn hóa truyền thống Việt Nam.' : 'Connecting traditional Vietnamese cultural values.'
        }
    }
}

module.exports = {
    getHomepage
}

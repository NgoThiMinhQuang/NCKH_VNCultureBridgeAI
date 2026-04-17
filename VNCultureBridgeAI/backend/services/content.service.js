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
            badge: lang === 'vi' ? 'Việt Nam' : 'Vietnam',
            title: lang === 'vi' ? 'VNCultureBridgeAI' : 'VNCultureBridgeAI',
            subtitle: lang === 'vi' ? 'Khám phá di sản văn hóa Việt Nam' : 'Discover Vietnam\'s Cultural Heritage',
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

async function getGlobalStats() {
    return await contentRepository.getGlobalStats()
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

    // Group VanHoa by common categories if possible
    // For now we map them as arts
    const arts = vanHoa.map(vh => ({ 
        id: vh.VanHoaID, 
        title: mapText(vh, 'TenVI', 'TenEN', lang), 
        description: mapText(vh, 'MoTaNganVI', 'MoTaNganEN', lang),
        imageUrl: vh.ImageUrl 
    }))

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
        identity: {
            population: ethnicity.DanSo || (lang === 'vi' ? 'Đang cập nhật' : 'TBD'),
            classification: mapText(ethnicity, 'PhanLoaiVI', 'PhanLoaiEN', lang) || (lang === 'vi' ? 'Nhóm ngôn ngữ' : 'Language Group'),
            locationSummary: mapText(ethnicity, 'DiaBanCuTruVI', 'DiaBanCuTruEN', lang) || (lang === 'vi' ? 'Toàn quốc' : 'National'),
            language: lang === 'vi' ? 'Tiếng mẹ đẻ' : 'Native Language'
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
            cuisine: amThuc.map(at => ({ id: at.AmThucID, title: mapText(at, 'TenVI', 'TenEN', lang), description: mapText(at, 'MoTaNganVI', 'MoTaNganEN', lang), imageUrl: at.ImageUrl })),
            festivals: leHoi.map(lh => ({ id: lh.LeHoiID, title: mapText(lh, 'TenVI', 'TenEN', lang), description: mapText(lh, 'MoTaNganVI', 'MoTaNganEN', lang), imageUrl: lh.ImageUrl })),
            arts: arts
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

    // Fetch related data concurrently
    const [provinces, articles, cuisineRows, festivalRows] = await Promise.all([
        contentRepository.getProvincesByVung(r.VungID),
        contentRepository.getArticles({ region: code, limit: 6 }),
        contentRepository.getAmThucExtended({ region: code, limit: 100 }),
        contentRepository.getFestivalsExtended({ region: code, limit: 3 })
    ])

    return {
        id: r.MaVung,
        code: r.MaVung,
        name: mapText(r, 'TenVI', 'TenEN', lang),
        title: mapText(r, 'TenVI', 'TenEN', lang),
        description: mapText(r, 'MoTaVI', 'MoTaEN', lang),
        imageUrl: r.ImageUrl,
        // Detailed data for sections
        provinces: provinces.map(p => ({
            id: p.MaTinh,
            code: p.MaTinh,
            name: mapText(p, 'TenVI', 'TenEN', lang),
            description: mapText(p, 'TongQuanVI', 'TongQuanEN', lang),
            imageUrl: p.HeroImageUrl || p.AnhDaiDienUrl,
            tags: []
        })),
        articles: articles.map(a => mapArticleCard(a, lang)),
        culturalHighlights: {
            cuisine: cuisineRows.map(at => ({
                id: at.AmThucID,
                code: at.MaMonAn,
                title: mapText(at, 'TenVI', 'TenEN', lang),
                description: mapText(at, 'MoTaNganVI', 'MoTaNganEN', lang),
                imageUrl: at.ImageUrl
            })),
            festivals: festivalRows.map(f => ({
                id: f.LeHoiID,
                code: f.MaLeHoi,
                title: mapText(f, 'TenVI', 'TenEN', lang),
                description: mapText(f, 'MoTaNganVI', 'MoTaNganEN', lang),
                date: mapText(f, 'ThoiGianVI', 'ThoiGianEN', lang),
                imageUrl: f.ImageUrl
            }))
        },
        statistics: {
            provinceCount: provinces.length,
            articleCount: articles.length,
            highlightCount: cuisineRows.length + festivalRows.length
        }
    }
}

async function listProvinces(options, lang) {
    const rows = await contentRepository.getAllProvinces()
    
    // Add thematic tags to improve filtering logic
    const provinceTags = {
        'HA_NOI': ['food', 'heritage', 'oldtown', 'capital'],
        'HA_GIANG': ['nature', 'mountains', 'adventure'],
        'HUE': ['heritage', 'food', 'oldtown', 'history'],
        'DA_NANG': ['sea', 'nature', 'modern'],
        'TPHCM': ['food', 'modern', 'history'],
        'CAN_THO': ['food', 'nature', 'river']
    }

    return rows.map(r => ({
        id: r.MaTinh,
        code: r.MaTinh,
        name: mapText(r, 'TenVI', 'TenEN', lang),
        description: mapText(r, 'TongQuanVI', 'TongQuanEN', lang),
        imageUrl: r.HeroImageUrl || r.AnhDaiDienUrl,
        regionCode: r.MaVung,
        region: lang === 'vi' ? r.VungTenVI : r.VungTenEN,
        tags: provinceTags[r.MaTinh] || []
    }))
}

async function listEthnicities(lang) {
    const [stats, rows, regions, gallery, stories, vanHoa] = await Promise.all([
        contentRepository.getGlobalStats(),
        contentRepository.getEthnics(),
        contentRepository.getVungVanHoa(),
        contentRepository.getGlobalGallery(7),
        homepageRepository.getLatestArticles(4),
        homepageRepository.getFeaturedVanHoa(null, 4)
    ])

    return {
        stats: {
            ethnicGroupCount: stats.ethnicGroupCount,
            regionCount: stats.regionCount,
            articleCount: stats.articleCount,
            galleryCount: stats.galleryCount
        },
        hero: {
            subtitle: lang === 'vi' 
                ? 'Từ những đỉnh núi mờ sương Tây Bắc đến những bản làng yên bình nơi đồng bằng, khám phá sự đa dạng và giàu có của văn hóa 54 dân tộc anh em.'
                : 'From the misty peaks of the Northwest to peaceful villages in the plains, discover the diversity and richness of Vietnam\'s 54 ethnic groups.'
        },
        ethnicities: rows.map(r => {
            // Smart region mapping since VungID is missing in DanToc table
            let region = mapText(r, 'PhanLoaiVI', 'PhanLoaiEN', lang);
            const code = r.MaDanToc;
            
            if (code === 'KINH') region = lang === 'vi' ? 'Tất cả vùng' : 'All Regions';
            else if (['HMONG', 'TAY', 'THAI', 'DAO', 'MUONG'].includes(code)) region = lang === 'vi' ? 'Bắc Bộ' : 'Northern Vietnam';
            else if (['CHAM', 'EDE', 'BANA'].includes(code)) region = lang === 'vi' ? 'Trung Bộ' : 'Central Vietnam';
            else if (code === 'KHMER') region = lang === 'vi' ? 'Nam Bộ' : 'Southern Vietnam';

            return {
                id: r.DanTocID,
                code: r.MaDanToc,
                name: mapText(r, 'TenVI', 'TenEN', lang),
                location: mapText(r, 'DiaBanCuTruVI', 'DiaBanCuTruEN', lang) || (lang === 'vi' ? 'Toàn quốc' : 'National'),
                cardImageUrl: r.ImageUrl,
                status: r.ThuTuHienThi <= 3 ? (lang === 'vi' ? 'Nổi bật' : 'Featured') : '',
                region: region,
                sortOrder: r.ThuTuHienThi
            }
        }),
        filters: {
            regions: [
                lang === 'vi' ? 'Tất cả vùng' : 'All Regions', 
                ...regions.map(r => mapText(r, 'TenVI', 'TenEN', lang))
            ],
            ethnicities: [
                lang === 'vi' ? 'Tất cả dân tộc' : 'All Ethnicities', 
                ...rows.slice(0, 10).map(r => mapText(r, 'TenVI', 'TenEN', lang))
            ]
        },
        sections: {
            features: vanHoa.map(vh => ({
                id: vh.VanHoaID,
                code: vh.Ma,
                title: mapText(vh, 'TenVI', 'TenEN', lang),
                description: mapText(vh, 'MoTaNganVI', 'MoTaNganEN', lang),
                imageUrl: vh.ImageUrl,
                tag: lang === 'vi' ? 'Văn hóa' : 'Culture'
            })),
            stories: stories.map(s => mapArticleCard(s, lang)),
            gallery: gallery.map((g, idx) => ({
                id: idx,
                imageUrl: g.imageUrl,
                imageAlt: mapText(g, 'altVI', 'altEN', lang),
                size: ['large', 'small', 'small', 'tall', 'small', 'wide', 'small'][idx % 7]
            }))
        }
    }
}

async function listFestivals(lang) {
    const [stats, rows, regions, gallery] = await Promise.all([
        contentRepository.getGlobalStats(),
        contentRepository.getFestivalsExtended(),
        contentRepository.getVungVanHoa(),
        contentRepository.getGlobalGallery(10)
    ])

    return {
        stats: {
            festivalCount: '8.000+', // Traditional value
            ethnicGroupCount: stats.ethnicGroupCount,
            regionCount: stats.regionCount
        },
        hero: {
            title: lang === 'vi' ? 'Lễ hội Việt Nam' : 'Vietnamese Festivals',
            subtitle: lang === 'vi' 
                ? 'Khám phá bản sắc văn hóa và tinh thần cộng đồng qua những mùa lễ hội truyền thống đặc sắc trên khắp dải đất hình chữ S.'
                : 'Explore cultural identity and community spirit through unique traditional festivals across the S-shaped land.'
        },
        festivals: rows.map(f => ({
            id: f.LeHoiID,
            code: f.MaLeHoi,
            title: mapText(f, 'TenVI', 'TenEN', lang),
            desc: mapText(f, 'MoTaNganVI', 'MoTaNganEN', lang),
            location: mapText(f, 'DiaDiemVI', 'DiaDiemEN', lang),
            date: mapText(f, 'ThoiGianVI', 'ThoiGianEN', lang),
            image: f.ImageUrl,
            region: mapText(f, 'MaVung', 'MaVung', lang), // Use code for logical mapping
            tagName: mapText(f, 'DanTocTenVI', 'DanTocTenEN', lang) || (lang === 'vi' ? 'Dân gian' : 'Folk'),
            category: f.LoaiLeHoi || (lang === 'vi' ? 'DAN_GIAN' : 'FOLK')
        })),
        filters: {
            regions: [
                { value: "", label: lang === 'vi' ? "Tất cả vùng miền" : "All Regions" },
                ...regions.map(r => ({ value: r.MaVung, label: mapText(r, 'TenVI', 'TenEN', lang) }))
            ],
            months: [
                { value: "", label: lang === 'vi' ? "Tất cả các tháng" : "All Months" },
                ...Array.from({ length: 12 }, (_, i) => ({ 
                    value: (i + 1).toString().padStart(2, '0'), 
                    label: lang === 'vi' ? `Tháng ${(i + 1).toString().padStart(2, '0')}` : `Month ${(i + 1).toString().padStart(2, '0')}` 
                }))
            ],
            categories: [
                { value: "", label: lang === 'vi' ? "Tất cả loại hình" : "All Categories" },
                { value: "DAN_GIAN", label: lang === 'vi' ? "Lễ hội dân gian" : "Folk Festival" },
                { value: "TON_GIAO", label: lang === 'vi' ? "Lễ hội tôn giáo" : "Religious Festival" },
                { value: "LICH_SU", label: lang === 'vi' ? "Lễ hội lịch sử" : "Historical Festival" },
                { value: "VAN_HOA", label: lang === 'vi' ? "Lễ hội văn hóa" : "Cultural Festival" }
            ]
        },
        sections: {
            meaning: {
                title: lang === 'vi' ? 'Linh hồn của lễ hội Việt' : 'The Soul of Vietnamese Festivals',
                desc: lang === 'vi' 
                    ? 'Mỗi lễ hội là một bức tranh sống động về lòng biết ơn cội nguồn, niềm tin vào những điều tốt đẹp và khát vọng gắn kết cộng đồng.'
                    : 'Each festival is a vibrant picture of gratitude to the roots, belief in good things and the desire for community cohesion.'
            },
            quote: {
                text: lang === 'vi' ? 'Uống nước nhớ nguồn' : 'Remembering the Source',
                author: lang === 'vi' ? 'Tục ngữ Việt Nam' : 'Vietnamese Proverb'
            },
            gallery: gallery.map((g, idx) => ({
                id: idx,
                imageUrl: g.imageUrl,
                imageAlt: mapText(g, 'altVI', 'altEN', lang)
            }))
        }
    }
}

async function listCuisines(filters, lang) {
    const [stats, allCuisines, regions, gallery, featured, stories] = await Promise.all([
        contentRepository.getGlobalStats(),
        contentRepository.getAmThucExtended(filters),
        contentRepository.getVungVanHoa(),
        contentRepository.getGlobalGallery(7),
        homepageRepository.getFeaturedAmThuc(3),
        homepageRepository.getLatestArticles(3)
    ])

    const cuisineHeroStats = [
        { label: lang === 'vi' ? 'Vùng miền' : 'Regions', value: stats.regionCount.toString() },
        { label: lang === 'vi' ? 'Món ăn' : 'Dishes', value: '100+' },
        { label: lang === 'vi' ? 'Dân tộc' : 'Ethnicities', value: stats.ethnicGroupCount.toString() }
    ]

    return {
        hero: {
            badge: lang === 'vi' ? 'Hành trình vị giác 3 miền' : 'A Journey of 3 Regional Tastes',
            titleLine1: lang === 'vi' ? 'Tinh Hoa' : 'The Essence',
            titleAccent: lang === 'vi' ? 'Ẩm Thực' : 'of Cuisine',
            titleLine3: lang === 'vi' ? 'Việt Nam' : 'Vietnam',
            subtitle: lang === 'vi' 
                ? 'Từ Bắc tinh tế, Trung đậm đà đến Nam ngọt ngào — mỗi món ăn đều mang theo một câu chuyện văn hóa, bản sắc cốt cách của con người Việt.'
                : 'From the delicate North, the flavorful Central to the sweet South — each dish carries a cultural story, the identity and character of the Vietnamese people.',
            stats: cuisineHeroStats
        },
        regions: [
            lang === 'vi' ? 'Tất cả vùng' : 'All Regions',
            ...regions.map(r => mapText(r, 'TenVI', 'TenEN', lang))
        ],
        heroCuisines: [
            lang === 'vi' ? 'Tất cả món' : 'All Dishes',
            'Phở', 'Bún chả', 'Bánh mì', 'Lẩu mắm', 'Bánh xèo'
        ],
        cards: allCuisines.map(r => ({
            id: r.AmThucID,
            code: r.MaMonAn,
            name: mapText(r, 'TenVI', 'TenEN', lang),
            region: mapText(r, 'VungTenVI', 'VungTenEN', lang),
            location: mapText(r, 'TinhTenVI', 'TinhTenEN', lang),
            imageUrl: r.ImageUrl,
            imageAlt: mapText(r, 'TenVI', 'TenEN', lang),
            status: r.AmThucID <= 3 ? (lang === 'vi' ? 'Phổ biến' : 'Popular') : ''
        })),
        features: featured.map(f => ({
            id: f.AmThucID,
            code: f.Ma,
            title: mapText(f, 'TenVI', 'TenEN', lang),
            tag: lang === 'vi' ? 'Đặc sản' : 'Specialty',
            desc: mapText(f, 'MoTaNganVI', 'MoTaNganEN', lang)
        })),
        stories: stories.map(s => mapArticleCard(s, lang)),
        gallery: gallery.map((g, idx) => ({
            id: idx,
            imageUrl: g.imageUrl,
            imageAlt: mapText(g, 'altVI', 'altEN', lang),
            size: ['large', 'small', 'small', 'tall', 'small', 'wide', 'small'][idx % 7]
        })),
        philosophy: {
            title: lang === 'vi' ? 'Triết lý mâm cơm Việt' : 'Vietnamese Culinary Philosophy',
            subtitle: lang === 'vi' ? 'Sự cân bằng hoàn mỹ của Ngũ hành và Âm dương' : 'The Perfect Balance of Five Elements and Yin-Yang',
            content: lang === 'vi' 
                ? 'Ẩm thực Việt Nam không chỉ là việc ăn uống mà còn là triết lý sống. Sự kết hợp giữa Kim - Mộc - Thủy - Hỏa - Thổ qua 5 vị: Cay - Chua - Mặn - Đắng - Ngọt tạo nên sự hài hòa tuyệt đối cho sức khỏe và tâm hồn.'
                : 'Vietnamese cuisine is not just about eating; it is a philosophy of life. The combination of Metal - Wood - Water - Fire - Earth through 5 flavors: Spicy - Sour - Salty - Bitter - Sweet creates absolute harmony for health and soul.'
        },
        regionalHighlights: [
            {
                region: lang === 'vi' ? 'Miền Bắc' : 'Northern Vietnam',
                title: lang === 'vi' ? 'Sự tinh tế & Thanh tao' : 'Delicacy & Elegance',
                desc: lang === 'vi' ? 'Gia vị trung tính, tôn vinh độ tươi ngon nguyên bản của nguyên liệu.' : 'Neutral spices, honoring the original freshness of ingredients.',
                image: 'https://images.unsplash.com/photo-1593361427131-0164c09d5718?auto=format&fit=crop&w=800&q=80'
            },
            {
                region: lang === 'vi' ? 'Miền Trung' : 'Central Vietnam',
                title: lang === 'vi' ? 'Sự đậm đà & Sâu lắng' : 'Richness & Depth',
                desc: lang === 'vi' ? 'Vị cay nồng, mặn mà phản ánh sự kiên cường của con người dải đất miền Trung.' : 'Spicy and salty flavors reflecting the resilience of the people in the Central region.',
                image: 'https://images.unsplash.com/photo-1574484284002-952d92456975?auto=format&fit=crop&w=800&q=80'
            },
            {
                region: lang === 'vi' ? 'Miền Nam' : 'Southern Vietnam',
                title: lang === 'vi' ? 'Sự hào sảng & Trù phú' : 'Generosity & Abundance',
                desc: lang === 'vi' ? 'Vị ngọt và béo của cốt dừa, đa dạng loại rau sông nước đặc trưng.' : 'Sweet and fatty taste of coconut milk, diverse types of characteristic river vegetables.',
                image: 'https://images.unsplash.com/photo-1528612991054-9469db38a14b?auto=format&fit=crop&w=800&q=80'
            }
        ]
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
        if (!r) return null

        // Fetch related data concurrently
        const [cuisine, festivals, articles] = await Promise.all([
            contentRepository.getAmThucExtended({ province: r.TinhThanhID, limit: 4 }),
            contentRepository.getFestivalsExtended({ region: r.VungID, limit: 3 }), // Use Region for festivals if no Province filter exists
            contentRepository.getArticles({ region: r.VungID, limit: 6 }) // Regional fallback for articles
        ])

        return {
            id: r.MaTinh,
            code: r.MaTinh,
            title: mapText(r, 'TenVI', 'TenEN', lang),
            name: mapText(r, 'TenVI', 'TenEN', lang),
            subtitle: lang === 'vi' ? 'Hành trình di sản' : 'A Heritage Journey',
            description: mapText(r, 'TongQuanVI', 'TongQuanEN', lang),
            heroImageUrl: r.HeroImageUrl || r.AnhDaiDienUrl,
            region: lang === 'vi' ? 'Vùng miền' : 'Region', // Can be refined with Join
            metrics: {
                population: '---', // From DB if added later
                area: '---',
                bestTime: lang === 'vi' ? 'Quanh năm' : 'Year-round'
            },
            cuisine: cuisine.map(at => ({
                id: at.AmThucID,
                title: mapText(at, 'TenVI', 'TenEN', lang),
                description: mapText(at, 'MoTaNganVI', 'MoTaNganEN', lang),
                imageUrl: at.ImageUrl
            })),
            festivals: festivals.map(f => ({
                id: f.LeHoiID,
                title: mapText(f, 'TenVI', 'TenEN', lang),
                description: mapText(f, 'MoTaNganVI', 'MoTaNganEN', lang),
                date: mapText(f, 'ThoiGianVI', 'ThoiGianEN', lang),
                imageUrl: f.ImageUrl
            })),
            articles: articles.map(a => mapArticleCard(a, lang))
        }
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

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
    
    // Map DB category keys to localized names
    const categoryMap = {
        'NGHE_THUAT_DAN_GIAN': lang === 'vi' ? 'Nghệ thuật & Di sản' : 'Arts & Heritage',
        'AM_THUC': lang === 'vi' ? 'Ẩm thực' : 'Cuisine',
        'LE_HOI': lang === 'vi' ? 'Lễ hội' : 'Festivals',
        'AM_NHAC': lang === 'vi' ? 'Âm nhạc' : 'Music',
        'TRANG_PHUC': lang === 'vi' ? 'Trang phục' : 'Costume',
        'VAN_HOA': lang === 'vi' ? 'Văn hóa' : 'Culture'
    }

    return {
        id: row.BaiVietID,
        code: row.MaBaiViet,
        title: mapText(row, 'TieuDeVI', 'TieuDeEN', lang),
        titleVi: row.TieuDeVI,
        titleEn: row.TieuDeEN,
        description: mapText(row, 'MoTaNganVI', 'MoTaNganEN', lang),
        descriptionVi: row.MoTaNganVI,
        descriptionEn: row.MoTaNganEN,
        imageUrl: row.ImageUrl || null,
        publishedAt: row.NgayXuatBan || null,
        category: categoryMap[row.ChuyenMuc] || row.ChuyenMuc || (lang === 'vi' ? 'Văn hóa' : 'Culture'),
        categoryVi: categoryMap[row.ChuyenMuc] || row.ChuyenMuc,
        categoryEn: categoryMap[row.ChuyenMuc] || row.ChuyenMuc, // Simple mapping for now
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
        regions: regions.map((r, index) => ({
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
        festivals: festivals.map((l, index) => {
            const accents = ['red', 'gold', 'purple']
            return {
                id: l.LeHoiID,
                code: l.MaLeHoi,
                title: mapText(l, 'TenVI', 'TenEN', lang),
                description: mapText(l, 'MoTaNganVI', 'MoTaNganEN', lang),
                badge: lang === 'vi' ? 'Lễ hội' : 'Festival',
                subtitle: l.ThoiGianVI, // Simplified for now
                metaPrimary: l.DiaDiemVI,
                imageUrl: l.ImageUrl,
                accent: accents[index % 3]
            }
        }),
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
        },
        artLanding: {
            hero: {
                badge: lang === 'vi' ? 'Văn hoá · Di sản · Nghệ thuật' : 'Culture · Heritage · Art',
                titleLine1Vi: 'Nghệ Thuật',
                titleAccentVi: '& Di Sản',
                titleLine3Vi: 'Việt Nam',
                titleLine1En: 'Vietnamese',
                titleAccentEn: 'Arts & Heritage',
                titleLine3En: '',
                subtitleVi: 'Nơi truyền thống cổ xưa hòa quyện cùng biểu đạt hiện đại — mang theo câu chuyện ngàn năm trong từng nét vẽ, từng điệu múa.',
                subtitleEn: 'Where ancient traditions blend with modern expression — carrying a thousand-year story in every stroke and dance.',
                imageUrl: arts[0]?.ImageUrl || 'https://vnculture.ai/assets/hero-art.jpg',
                imageAltVi: 'Nghệ thuật Việt Nam',
                imageAltEn: 'Vietnamese Arts',
                imageBadgeVi: 'Di sản văn hóa',
                imageBadgeEn: 'Cultural Heritage',
                imageBadgeIcon: '🏛️'
            },
            stats: lang === 'vi' ? [
                { value: '4.000+', labelVi: 'Năm lịch sử', labelEn: 'Years of history' },
                { value: '54', labelVi: 'Dân tộc anh em', labelEn: 'Ethnic groups' },
                { value: '8', labelVi: 'Di sản UNESCO', labelEn: 'UNESCO Heritages' }
            ] : [
                { value: '4,000+', labelVi: 'Năm lịch sử', labelEn: 'Years of history' },
                { value: '54', labelVi: 'Dân tộc anh em', labelEn: 'Ethnic groups' },
                { value: '8', labelVi: 'UNESCO Heritages', labelEn: 'UNESCO Heritages' }
            ],
            heritage: {
                titleVi: 'Khám Phá Di Sản',
                titleEn: 'Explore Our Heritage',
                subtitleVi: 'Khám phá vẻ đẹp vượt thời gian của tinh hoa thủ công Việt Nam',
                subtitleEn: 'Discover the timeless beauty of Vietnamese craftsmanship',
                cards: arts.slice(0, 4).map(v => ({
                    imageUrl: v.ImageUrl,
                    titleVi: v.TenVI,
                    titleEn: v.TenEN,
                    subVi: v.Loai === 'NGHE_THUAT' ? 'Nghệ thuật' : v.Loai,
                    subEn: v.Loai === 'NGHE_THUAT' ? 'Art' : v.Loai
                }))
            },
            featuredArtwork: arts[0] ? {
                badgeVi: 'TÁC PHẨM NỔI BẬT',
                badgeEn: 'FEATURED ARTWORK',
                titleVi: arts[0].TenVI,
                titleEn: arts[0].TenEN,
                bodyVi: [
                    arts[0].MoTaNganVI,
                    arts[0].NoiDungChiTietVI
                ].filter(Boolean),
                bodyEn: [
                    arts[0].MoTaNganEN,
                    arts[0].NoiDungChiTietEN
                ].filter(Boolean),
                stats: [
                    { value: arts[0].ArticleCount || '0', labelVi: 'Bài viết liên quan', labelEn: 'Related articles' },
                    { value: 'UNESCO', labelVi: 'Công nhận', labelEn: 'Recognition' },
                    { value: '100+', labelVi: 'Năm truyền thống', labelEn: 'Years of tradition' }
                ],
                imageUrl: arts[0].ImageUrl,
                imageAltVi: arts[0].TenVI,
                imageAltEn: arts[0].TenEN
            } : null,
            gallery: {
                titleVi: 'Thư Viện Ảnh',
                titleEn: 'Our Gallery',
                subtitleVi: 'Hành trình thị giác qua di sản nghệ thuật Việt Nam',
                subtitleEn: 'A visual journey through Vietnamese artistic legacy',
                images: arts.slice(0, 6).map(v => v.ImageUrl)
            },
            story: {
                badgeVi: 'CÂU CHUYỆN CỦA CHÚNG TÔI',
                badgeEn: 'OUR STORY',
                titleVi: 'Sợi Chỉ Thời Gian, Dệt Bằng Tâm Hồn',
                titleEn: 'Threads of Time, Woven with Soul',
                bodyVi: [
                    'Trong hơn một thiên niên kỷ, các nghệ nhân Việt Nam đã gìn giữ và nâng tầm nghề thủ công của mình, truyền lại các kỹ thuật qua nhiều thế hệ như những di vật quý giá. Từ những dải lụa tinh xảo đến vẻ đẹp mộc mạc của gốm sứ, mỗi truyền thống đều mang trong mình linh hồn của đất nước.'
                ],
                bodyEn: [
                    'For over a millennium, Vietnamese artisans have preserved and elevated their crafts, passing down techniques through generations like precious heirlooms. From delicate silks to the earthen beauty of ceramics, each tradition carries the soul of the land.'
                ],
                features: [
                    { titleVi: 'Bảo tồn di sản', titleEn: 'Heritage Preservation', textVi: 'Bảo vệ các kỹ thuật cổ xưa', textEn: 'Protecting ancient techniques', color: '#b91c1c' },
                    { titleVi: 'Biểu đạt đương đại', titleEn: 'Contemporary Expression', textVi: 'Kết hợp truyền thống và hiện đại', textEn: 'Blending tradition and modernity', color: '#f59e0b' },
                    { titleVi: 'Kết nối cộng đồng', titleEn: 'Community Connection', textVi: 'Gắn kết các giá trị nhân văn', textEn: 'Connecting human values', color: '#10b981' }
                ],
                images: arts.slice(0, 4).map(v => v.ImageUrl)
            }
        }

    }
}


/**
 * Standard list and detail functions
 */
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
        author: row.TacGia,
        vung: mapText(row, 'VungTenVI', 'VungTenEN', lang),
        danToc: mapText(row, 'DanTocTenVI', 'DanTocTenEN', lang),
        gallery: gallery.map(g => ({ url: g.Url, caption: mapText(g, 'MoTaVI', 'MoTaEN', lang) }))
    }
}

async function getEthnicityDetail(code, lang) {
    const ethnicity = await contentRepository.getEthnicityByCode(code)
    if (!ethnicity) return null

    const danTocId = ethnicity.DanTocID
    const maDanToc = ethnicity.MaDanToc

    const [vanHoa, leHoi, amThuc, articles, dbGallery] = await Promise.all([
        contentRepository.getVanHoaByMaDanToc(danTocId),
        contentRepository.getLeHoiByMaDanToc(danTocId),
        contentRepository.getAmThucByMaDanToc(danTocId),
        contentRepository.getArticlesByDanTocId(danTocId, 4),
        contentRepository.getGalleryByDanTocId(danTocId, 12)
    ])

    // Fallback strategy: If specific sections are empty, try to populate them from articles
    let festivals = leHoi.map(l => ({
        id: l.LeHoiID,
        code: l.MaLeHoi,
        title: mapText(l, 'TenVI', 'TenEN', lang),
        description: mapText(l, 'MoTaNganVI', 'MoTaNganEN', lang),
        imageUrl: l.ImageUrl,
        tag: lang === 'vi' ? 'Lễ hội' : 'Festival'
    }))

    if (festivals.length === 0) {
        // Try to fetch articles in LE_HOI category
        const festArticles = await contentRepository.getArticles({ category: 'LE_HOI', ethnicity: maDanToc, limit: 3 })
        festivals = festArticles.map(a => ({
            id: a.BaiVietID,
            code: a.MaBaiViet,
            title: mapText(a, 'TieuDeVI', 'TieuDeEN', lang),
            description: mapText(a, 'MoTaNganVI', 'MoTaNganEN', lang),
            imageUrl: a.ImageUrl,
            tag: lang === 'vi' ? 'Lễ hội' : 'Festival'
        }))
    }

    let cuisine = amThuc.map(a => ({
        id: a.AmThucID,
        title: mapText(a, 'TenVI', 'TenEN', lang),
        imageUrl: a.ImageUrl
    }))

    if (cuisine.length === 0) {
        const foodArticles = await contentRepository.getArticles({ category: 'AM_THUC', ethnicity: maDanToc, limit: 3 })
        cuisine = foodArticles.map(a => ({
            id: a.BaiVietID,
            title: mapText(a, 'TieuDeVI', 'TieuDeEN', lang),
            imageUrl: a.ImageUrl
        }))
    }

    // Cultural highlights (Music, Architecture, Textiles)
    const musicItems = vanHoa.filter(v => v.Loai === 'AM_NHAC' || v.Loai === 'NGHE_THUAT')
    const archItems = vanHoa.filter(v => v.Loai === 'KIEN_TRUC')
    const textileItems = vanHoa.filter(v => v.Loai === 'TRANG_PHUC' || v.Loai === 'THO_CAM')
    const otherFeatures = vanHoa.filter(v => !['AM_NHAC', 'NGHE_THUAT', 'KIEN_TRUC', 'TRANG_PHUC', 'THO_CAM'].includes(v.Loai))

    // Build Overview with multiple fallbacks
    const overviewContent = mapText(ethnicity, 'OverviewVI', 'OverviewEN', lang) 
        || mapText(ethnicity, 'VanHoaVI', 'VanHoaEN', lang)
        || (lang === 'vi' ? 'Thông tin đang được cập nhật.' : 'Information is being updated.')

    const stats = [
        { 
            label: lang === 'vi' ? 'Dân số' : 'Population', 
            value: (function() {
                if (!ethnicity.DanSo) return lang === 'vi' ? 'Đang cập nhật' : 'TBD';
                const s = ethnicity.DanSo.toString().trim();
                const pureDigits = s.replace(/[,.]/g, '');
                if (pureDigits && /^\d+$/.test(pureDigits)) {
                    return Number(pureDigits).toLocaleString(lang === 'vi' ? 'vi-VN' : 'en-US');
                }
                return s;
            })()
        },
        { 
            label: lang === 'vi' ? 'Lễ hội' : 'Festivals', 
            value: festivals.length > 0 ? festivals.length.toString() : (lang === 'vi' ? 'Đa dạng' : 'Diverse')
        },
        { 
            label: lang === 'vi' ? 'Bài viết' : 'Articles', 
            value: (articles.length + (festivals.length > 0 ? festivals.length : 0)).toString()
        }
    ]

    // Construct Gallery from multiple sources
    let gallery = dbGallery.map((g, idx) => ({
        id: `g-${idx}`,
        imageUrl: g.Url,
        imageAlt: mapText(g, 'MoTaVI', 'MoTaEN', lang),
        size: ['large', 'small', 'small', 'tall', 'small', 'wide', 'small', 'small'][idx % 8]
    }))

    if (gallery.length === 0) {
        // Fallback gallery from available features and cuisine
        const combined = [...vanHoa, ...amThuc, ...articles]
        gallery = combined.slice(0, 8).map((item, idx) => ({
            id: `fb-${idx}`,
            imageUrl: item.ImageUrl,
            imageAlt: mapText(item, 'TenVI', 'TieuDeVI', lang),
            size: ['large', 'small', 'small', 'tall', 'small', 'wide', 'small', 'small'][idx % 8]
        }))
    }

    return {
        id: ethnicity.DanTocID,
        code: ethnicity.MaDanToc,
        name: mapText(ethnicity, 'TenVI', 'TenEN', lang),
        hero: {
            badge: mapText(ethnicity, 'PhanLoaiVI', 'PhanLoaiEN', lang) || (lang === 'vi' ? 'Dân tộc Việt Nam' : 'Vietnamese Ethnic Group'),
            title: mapText(ethnicity, 'TenVI', 'TenEN', lang),
            subtitle: ethnicity.OverviewVI ? mapText(ethnicity, 'OverviewVI', 'OverviewEN', lang).substring(0, 200) + '...' : (lang === 'vi' ? 'Khám phá bản sắc độc đáo của cộng đồng này.' : 'Discover the unique identity of this community.'),
            backgroundImageUrl: ethnicity.BannerUrl || ethnicity.ImageUrl,
            foregroundImageUrl: ethnicity.ImageUrl,
            stats
        },
        identity: {
            population: ethnicity.DanSo || (lang === 'vi' ? 'Đang cập nhật' : 'TBD'),
            classification: mapText(ethnicity, 'PhanLoaiVI', 'PhanLoaiEN', lang),
            locationSummary: mapText(ethnicity, 'DiaBanCuTruVI', 'DiaBanCuTruEN', lang),
            language: ethnicity.PhanLoaiVI || (lang === 'vi' ? 'Ngôn ngữ riêng' : 'Native Language')
        },
        overview: {
            title: lang === 'vi' ? `Hành trình di sản ${ethnicity.TenVI}` : `The Heritage of ${ethnicity.TenEN}`,
            content: overviewContent,
            imageUrl: ethnicity.ImageUrl
        },
        history: {
            title: lang === 'vi' ? 'Nguồn gốc & Lịch sử' : 'Origin & History',
            content: mapText(ethnicity, 'LichSuVI', 'LichSuEN', lang) || (lang === 'vi' ? 'Dữ liệu lịch sử đang được số hóa...' : 'Historical data is being digitized...')
        },
        customs: {
            title: lang === 'vi' ? 'Phong tục & Bản sắc' : 'Customs & Identity',
            content: mapText(ethnicity, 'VanHoaVI', 'VanHoaEN', lang) || mapText(ethnicity, 'OverviewVI', 'OverviewEN', lang)
        },
        geography: {
            title: lang === 'vi' ? 'Địa bàn cư trú' : 'Geographical Distribution',
            content: mapText(ethnicity, 'DiaBanCuTruVI', 'DiaBanCuTruEN', lang) || (lang === 'vi' ? 'Cư trú chủ yếu tại các vùng núi và cao nguyên.' : 'Mainly residing in mountainous regions and highlands.')
        },
        featureHighlight: otherFeatures[0] ? {
            title: mapText(otherFeatures[0], 'TenVI', 'TenEN', lang),
            imageUrl: otherFeatures[0].ImageUrl,
            imageAlt: mapText(otherFeatures[0], 'TenVI', 'TenEN', lang)
        } : null,
        sections: {
            textiles: textileItems.map(t => ({
                id: t.VanHoaID,
                title: mapText(t, 'TenVI', 'TenEN', lang),
                description: mapText(t, 'MoTaNganVI', 'MoTaNganEN', lang),
                imageUrl: t.ImageUrl
            })),
            festivals,
            cuisine,
            music: musicItems[0] ? {
                title: mapText(musicItems[0], 'TenVI', 'TenEN', lang),
                content: mapText(musicItems[0], 'MoTaNganVI', 'MoTaNganEN', lang) || mapText(musicItems[0], 'NoiDungChiTietVI', 'NoiDungChiTietEN', lang),
                imageUrl: musicItems[0].ImageUrl,
                imageAlt: mapText(musicItems[0], 'TenVI', 'TenEN', lang)
            } : null,
            architecture: archItems[0] ? {
                title: mapText(archItems[0], 'TenVI', 'TenEN', lang),
                content: mapText(archItems[0], 'MoTaNganVI', 'MoTaNganEN', lang) || mapText(archItems[0], 'NoiDungChiTietVI', 'NoiDungChiTietEN', lang),
                imageUrl: archItems[0].ImageUrl,
                imageAlt: mapText(archItems[0], 'TenVI', 'TenEN', lang)
            } : null
        },
        gallery,
        relatedArticles: articles.map(a => mapArticleCard(a, lang))
    }
}

async function getRegions(lang) {
    const rows = await contentRepository.getVungVanHoa()
    return rows.map(r => ({
        id: r.MaVung,
        name: mapText(r, 'TenVI', 'TenEN', lang),
        image: r.ImageUrl
    }))
}

async function getEthnics(lang) {
    const [rows, vanHoa, articles, stats] = await Promise.all([
        contentRepository.getEthnics(),
        homepageRepository.getFeaturedVanHoa('NGHE_THUAT', 4),
        homepageRepository.getLatestArticles(3),
        contentRepository.getGlobalStats()
    ])

    const ethnicities = rows.map(r => ({
        id: r.MaDanToc,
        name: mapText(r, 'TenVI', 'TenEN', lang),
        cardImageUrl: r.ImageUrl,
        image: r.ImageUrl,
        location: mapText(r, 'DanSo', 'DanSo', lang) || 'Đang cập nhật',
        region: mapText(r, 'PhanLoaiVI', 'PhanLoaiEN', lang),
        status: r.Status || '',
        sortOrder: r.ThuTuHienThi || 9999
    }))

    const firstEthnic = rows[0] || {}
    const heroBg = firstEthnic.BannerUrl || firstEthnic.ImageUrl || 'https://vj-prod-website-cms.s3.ap-southeast-1.amazonaws.com/2294820181canhdepmienbac-1711070654909.jpg'
    const heroFg = firstEthnic.ImageUrl || 'https://dienbientv.vn/dataimages/201212/original/images799031_2.jpg'

    return {
        hero: {
            subtitle: lang === 'vi' 
                ? 'Từ những đỉnh núi mờ sương Tây Bắc đến những bản làng yên bình nơi đồng bằng, khám phá sự đa dạng và giàu có của văn hóa 54 dân tộc anh em.'
                : 'From the misty peaks of the Northwest to the peaceful villages of the delta, explore the diversity and richness of 54 ethnic cultures.',
            backgroundImageUrl: heroBg,
            foregroundImageUrl: heroFg,
            badge: lang === 'vi' ? 'Hành trình di sản' : 'Heritage Journey'
        },
        stats: {
            ethnicGroupCount: stats.ethnicGroupCount || 54,
            regionCount: stats.regionCount || 8,
            articleCount: stats.articleCount || '5,000+',
            galleryCount: stats.galleryCount || '1,000+'
        },
        ethnicities,
        sections: {
            features: vanHoa.map(vh => ({
                id: vh.VanHoaID,
                code: vh.Ma,
                title: mapText(vh, 'TenVI', 'TenEN', lang),
                description: mapText(vh, 'MoTaNganVI', 'MoTaNganEN', lang),
                imageUrl: vh.ImageUrl,
                tag: vh.Loai === 'NGHE_THUAT' ? (lang === 'vi' ? 'Nghệ thuật' : 'Art') : vh.Loai
            })),
            stories: articles.map(a => mapArticleCard(a, lang)),
            gallery: vanHoa.concat(articles).slice(0, 7).map((item, idx) => ({
                id: idx,
                size: ['large', 'small', 'small', 'tall', 'small', 'wide', 'small'][idx % 7],
                imageUrl: item.ImageUrl,
                imageAlt: mapText(item, 'TenVI', 'TieuDeVI', lang)
            }))
        }
    }
}

async function getProvinceDetail(code, lang) {
    const row = await contentRepository.getProvinceByCode(code)
    if (!row) return null
    return {
        id: row.MaTinh,
        name: mapText(row, 'TenVI', 'TenEN', lang),
        desc: mapText(row, 'TongQuanVI', 'TongQuanEN', lang),
        image: row.HeroImageUrl
    }
}

async function getCuisineDetail(code, lang) {
    const row = await contentRepository.getArticleByCode(code) || {} 
    if (row.ChuyenMuc === 'AM_THUC') return getArticleDetail(code, lang)
    return null
}

async function askAi({ question, lang }) {
    return {
        answer: lang === 'vi' 
            ? `Tôi là trợ lý AI Văn hóa Việt Nam. Bạn vừa hỏi: "${question}". Đây là một câu hỏi rất hay về di sản của chúng ta.`
            : `I am your Vietnam Culture AI assistant. You asked: "${question}". This is a fascinating question about our heritage.`
    }
}

async function listFestivals(lang) {
    const [festivalsRows, galleryRows, stats] = await Promise.all([
        contentRepository.getFestivalsExtended(),
        contentRepository.getGlobalGallery(),
        contentRepository.getGlobalStats()
    ]);

    const mappedFestivals = festivalsRows.map(f => {
        // Map region MaVung to frontend filter codes (north, central, south)
        let regionCode = '';
        if (f.MaVung === 'BAC_BO') regionCode = 'north';
        else if (f.MaVung === 'TRUNG_BO') regionCode = 'central';
        else if (f.MaVung === 'NAM_BO') regionCode = 'south';

        // Categorize based on metadata or default to ethnic
        let category = 'ethnic';
        if (f.MaLeHoi === 'GIO_TO_HUNG_VUONG' || f.MaLeHoi === 'FESTIVAL_HUE') category = 'major';
        else if (f.Loai?.includes('TON_GIAO')) category = 'religious';
        
        return {
            id: f.LeHoiID,
            code: f.MaLeHoi,
            title: mapText(f, 'TenVI', 'TenEN', lang),
            enTitle: f.TenEN,
            desc: mapText(f, 'MoTaNganVI', 'MoTaNganEN', lang),
            location: mapText(f, 'DiaDiemVI', 'DiaDiemEN', lang),
            date: mapText(f, 'ThoiGianVI', 'ThoiGianEN', lang),
            region: regionCode, // Matches REGION_OPTIONS values
            category: category, // For categorical filtering
            image: f.ImageUrl,
            tag: f.DanTocTenVI || (lang === 'vi' ? 'Lễ hội lớn' : 'Major Festival')
        };
    });

    // Group festivals by month for the timeline
    const timeline = festivalsRows.slice(0, 6).map((f, index) => {
        const colors = ['#ce112d', '#daa520', '#7e22ce', '#1d4ed8', '#059669', '#ea580c'];
        const seasons = lang === 'vi' 
            ? ['Mùa Xuân', 'Mùa Xuân', 'Mùa Hạ', 'Mùa Thu', 'Mùa Đông', 'Mùa Xuân']
            : ['Spring', 'Spring', 'Summer', 'Autumn', 'Winter', 'Spring'];
        
        // Try to extract month from strings like "10/3", "Tháng 7", "Rằm tháng 10"
        let monthLabel = f.ThoiGianVI;
        const monthMatch = f.ThoiGianVI?.match(/tháng\s+(\d+)/i) || f.ThoiGianVI?.match(/\/(\d+)/);
        if (monthMatch) {
            monthLabel = lang === 'vi' ? `Tháng ${monthMatch[1]}` : `Month ${monthMatch[1]}`;
        }
        
        return {
            id: f.LeHoiID,
            month: monthLabel,
            title: mapText(f, 'TenVI', 'TenEN', lang),
            season: seasons[index % seasons.length],
            image: f.ImageUrl,
            color: colors[index % colors.length]
        };
    });

    return {
        festivals: mappedFestivals,
        page: {
            badge: lang === 'vi' ? 'Lễ hội · Văn hóa · Truyền thống' : 'Festivals · Culture · Tradition',
            titleLine1: lang === 'vi' ? 'Tinh hoa' : 'Essence of',
            titleAccent: lang === 'vi' ? 'Lễ hội' : 'Festivals',
            titleLine3: lang === 'vi' ? 'Việt Nam' : 'Vietnam',
            subtitle: lang === 'vi' 
                ? 'Hàng nghìn năm truyền thống hội tụ trong từng lễ hội — nơi sắc màu, âm thanh và tâm hồn Việt hòa quyện thành một.'
                : 'Thousands of years of tradition converge in each festival — where colors, sounds, and the Vietnamese soul blend as one.',
            stats: lang === 'vi' ? [
                { value: '8.000+', label: 'Lễ hội hàng năm' },
                { value: stats.ethnicGroupCount.toString(), label: 'Dân tộc anh em' },
                { value: '63', label: 'Tỉnh thành' }
            ] : [
                { value: '8,000+', label: 'Annual Festivals' },
                { value: stats.ethnicGroupCount.toString(), label: 'Ethnic Groups' },
                { value: '63', label: 'Provinces' }
            ],
            searchPlaceholder: lang === 'vi' ? 'Tìm kiếm lễ hội, nghi lễ và truyền thống...' : 'Search for festivals, rituals, and traditions...',
            filterButton: lang === 'vi' ? 'Bộ lọc nâng cao' : 'Advanced Filters',
            major: {
                badge: lang === 'vi' ? 'Lễ hội nổi bật' : 'Featured Festivals',
                title: lang === 'vi' ? 'Lễ hội tiêu biểu' : 'Typical Festivals',
                subtitle: lang === 'vi' 
                    ? 'Khám phá những lễ hội nổi bật và có sức lan tỏa mạnh mẽ trong văn hóa Việt Nam'
                    : 'Discover prominent and highly influential festivals in Vietnamese culture'
            },
            meaning: {
                badge: lang === 'vi' ? 'Ý nghĩa văn hóa' : 'Cultural Meaning',
                title: lang === 'vi' ? 'Linh hồn của lễ hội Việt' : 'Soul of Vietnamese Festivals',
                paragraphs: lang === 'vi' ? [
                    'Lễ hội Việt Nam không chỉ là những ngày vui mà còn là nơi kết nối con người với cội nguồn, vùng đất và ký ức cộng đồng.',
                    'Mỗi nghi thức, biểu tượng và hoạt động trong lễ hội đều phản ánh chiều sâu văn hóa, niềm tin và tinh thần gắn kết của người Việt.',
                    'Khi tham gia lễ hội, chúng ta không chỉ quan sát mà còn trực tiếp cảm nhận nhịp sống văn hóa đang tiếp tục được lưu truyền qua nhiều thế hệ.'
                ] : [
                    'Vietnamese festivals are not just joyful days but also places connecting people with their roots, land, and community memories.',
                    'Every ritual, symbol, and activity in the festival reflects the cultural depth, beliefs, and bonding spirit of the Vietnamese people.',
                    'When participating in a festival, we do not just observe but directly feel the cultural rhythm still being passed down through generations.'
                ],
                button: lang === 'vi' ? 'Tìm hiểu thêm về văn hóa Việt' : 'Learn more about Vietnamese culture',
                buttonHref: '/articles'
            },
            all: {
                title: lang === 'vi' ? 'Khám phá các lễ hội Việt Nam' : 'Explore Vietnamese Festivals',
                subtitle: lang === 'vi' 
                    ? 'Mở từng trang để xem nội dung lễ hội tương ứng được tải động từ hệ thống'
                    : 'Open each page to see corresponding festival content loaded dynamically from the system'
            },
            timeline: {
                badge: lang === 'vi' ? 'Lễ hội quanh năm' : 'Year-round Festivals',
                title: lang === 'vi' ? 'Dòng thời gian lễ hội' : 'Festival Timeline',
                subtitle: lang === 'vi' 
                    ? 'Khám phá nhịp điệu văn hóa Việt Nam qua từng mùa trong năm'
                    : 'Discover the cultural rhythm of Vietnam through the seasons',
                hint: lang === 'vi' ? 'Cuộn ngang để xem thêm →' : 'Scroll horizontally to see more →'
            },
            gallery: {
                badge: lang === 'vi' ? 'Hành trình thị giác' : 'Visual Journey',
                title: lang === 'vi' ? 'Khoảnh khắc lễ hội' : 'Festival Moments',
                subtitle: lang === 'vi' 
                    ? 'Đắm mình trong bầu không khí và cảm xúc của những mùa lễ hội Việt Nam'
                    : 'Immerse yourself in the atmosphere and emotions of Vietnamese festival seasons'
            },
            quote: {
                title: lang === 'vi' ? 'Uống nước nhớ nguồn' : 'When drinking water, remember its source',
                subtitle: lang === 'vi' ? 'Nhớ về cội nguồn để gìn giữ giá trị văn hóa' : 'Remember your roots to preserve cultural values',
                desc: lang === 'vi' 
                    ? 'Tinh thần biết ơn cội nguồn chính là nền tảng để các lễ hội Việt Nam tiếp tục sống động trong đời sống hôm nay.'
                    : 'The spirit of gratitude towards roots is the foundation for Vietnamese festivals to continue living vividly in today\'s life.',
                button: lang === 'vi' ? 'Khám phá văn hóa' : 'Explore Culture',
                backgroundImageUrl: 'https://vcdn1-dulich.vnecdn.net/2022/05/12/Hanoi2-1652338755-3632-1652338809.jpg'
            },
            galleryImages: galleryRows.map(g => ({
                imageUrl: g.imageUrl,
                alt: lang === 'vi' ? g.altVI : g.altEN
            }))
        },
        timeline
    };
}

async function listCuisines(filters, lang) {
  const [cuisineRows, regionRows, articleRows, stats] = await Promise.all([
    contentRepository.getAmThucExtended(),
    contentRepository.getVungVanHoa(),
    contentRepository.getArticles({ category: 'AM_THUC' }, lang),
    contentRepository.getGlobalStats()
  ]);

  const allCuisines = cuisineRows.map(r => ({
    id: r.AmThucID,
    code: r.MaMonAn,
    name: mapText(r, 'TenVI', 'TenEN', lang),
    status: mapText(r, 'LoaiMonAnVI', 'LoaiMonAnEN', lang) || (lang === 'vi' ? 'Đặc sản' : 'Specialty'),
    location: mapText(r, 'TinhTenVI', 'TinhTenEN', lang) || mapText(r, 'VungTenVI', 'VungTenEN', lang),
    region: mapText(r, 'VungTenVI', 'VungTenEN', lang),
    imageAlt: mapText(r, 'TenVI', 'TenEN', lang),
    imageUrl: r.ImageUrl
  }));

  // Regions for filter (with 'Tất cả vùng' as first item)
  const regions = [
    lang === 'vi' ? 'Tất cả vùng' : 'All Regions',
    ...regionRows.map(r => mapText(r, 'TenVI', 'TenEN', lang))
  ];

  // Specific cuisine names for hero filter
  const heroCuisines = [
    lang === 'vi' ? 'Tất cả món' : 'All Dishes',
    ...allCuisines.slice(0, 8).map(at => at.name)
  ];

  return {
    hero: {
      badge: lang === 'vi' ? 'Khám phá ẩm thực 3 miền' : 'Explore 3-region Cuisine',
      titleLine1: lang === 'vi' ? 'Tinh Hoa' : 'Essence of',
      titleAccent: lang === 'vi' ? 'Ẩm Thực' : 'Cuisine',
      titleLine3: lang === 'vi' ? 'Việt Nam' : 'Vietnam',
      subtitle: lang === 'vi' 
        ? 'Từ Bắc tinh tế, Trung đậm đà đến Nam ngọt ngào — mỗi món ăn đều mang theo một câu chuyện văn hóa riêng.'
        : 'From delicate North, savory Central to sweet South — each dish carries its own cultural story.',
      stats: lang === 'vi' ? [
        { value: stats.regionCount.toString(), label: 'Vùng miền' },
        { value: cuisineRows.length.toString() + '+', label: 'Món ăn' },
        { value: stats.ethnicGroupCount.toString(), label: 'Dân tộc' }
      ] : [
        { value: stats.regionCount.toString(), label: 'Regions' },
        { value: cuisineRows.length.toString() + '+', label: 'Dishes' },
        { value: stats.ethnicGroupCount.toString(), label: 'Ethnicities' }
      ],
      heroImageAlt: lang === 'vi' ? 'Ẩm thực Việt Nam' : 'Vietnamese Cuisine'
    },
    cards: allCuisines,
    features: allCuisines.slice(0, 3).map(at => ({
      ...at,
      title: at.name,
      desc: mapText(cuisineRows.find(r => r.AmThucID === at.id), 'MoTaNganVI', 'MoTaNganEN', lang),
      tag: lang === 'vi' ? 'Món ngon tiêu biểu' : 'Featured Dish'
    })),
    stories: articleRows.map(a => mapArticleCard(a, lang)),
    gallery: allCuisines.slice(0, 6).map((at, idx) => ({
      id: at.id,
      code: at.code,
      title: at.name,
      size: ['large', 'small', 'small', 'tall', 'small', 'wide'][idx % 6],
      imageUrl: at.imageUrl,
      imageAlt: at.imageAlt
    })),
    regions,
    heroCuisines
  };
}

async function getCuisineDetail(code, lang) {
  const row = await contentRepository.getArticleByCode(code) || {} 
  if (row.ChuyenMuc === 'AM_THUC') return getArticleDetail(code, lang)
  return null
}

module.exports = {
    getArticles,
    getArticleDetail,
    getEthnicityDetail,
    getHomepageData,
    getRegions,
    getEthnics,
    getProvinceDetail,
    getCuisineDetail,
    askAi,
    // Aliases for controller compatibility
    listArticles: getArticles,
    getArticle: getArticleDetail,
    listRegions: getRegions,
    getRegion: async (code, lang) => {
        let normalizedCode = code.toUpperCase();
        if (normalizedCode === 'NORTH') normalizedCode = 'BAC_BO';
        if (normalizedCode === 'CENTRAL') normalizedCode = 'TRUNG_BO';
        if (normalizedCode === 'SOUTH') normalizedCode = 'NAM_BO';
        const r = await contentRepository.getVungByCode(normalizedCode);
        const stats = await contentRepository.getGlobalStats(); // Approximate for now
        return r ? { 
            id: r.MaVung, 
            name: mapText(r, 'TenVI', 'TenEN', lang),
            imageUrl: r.ImageUrl,
            imageAlt: mapText(r, 'TenVI', 'TenEN', lang),
            description: mapText(r, 'MoTaVI', 'MoTaEN', lang),
            overviewDescription: mapText(r, 'MoTaVI', 'MoTaEN', lang),
            articleCount: stats.articleCount || 5000, // Placeholder
            highlights: [] 
        } : null;
    },
    listProvinces: async (options, lang) => {
        let rows;
        if (options.region) {
            let vungCode = options.region.toUpperCase();
            if (vungCode === 'NORTH') vungCode = 'BAC_BO';
            if (vungCode === 'CENTRAL') vungCode = 'TRUNG_BO';
            if (vungCode === 'SOUTH') vungCode = 'NAM_BO';
            
            const vung = await contentRepository.getVungByCode(vungCode);
            rows = vung ? await contentRepository.getProvincesByVung(vung.VungID) : [];
        } else {
            rows = await contentRepository.getAllProvinces();
        }
        
        return rows.map(r => ({ 
            id: r.MaTinh, 
            code: r.MaTinh.toLowerCase().replace(/_/g, '-'),
            name: mapText(r, 'TenVI', 'TenEN', lang),
            description: mapText(r, 'TongQuanVI', 'TongQuanEN', lang),
            imageUrl: r.HeroImageUrl || r.AnhDaiDienUrl,
            vungId: r.VungID
        }));
    },
    getProvince: getProvinceDetail,
    listFestivals,
    getFestival: (id, lang) => contentRepository.getFestivalsExtended().then(rows => {
        const row = rows.find(r => r.MaLeHoi === id || r.LeHoiID.toString() === id);
        return row ? { 
            id: row.LeHoiID, 
            code: row.MaLeHoi,
            title: mapText(row, 'TenVI', 'TenEN', lang),
            description: mapText(row, 'MoTaNganVI', 'MoTaNganEN', lang),
            content: mapText(row, 'NoiDungChiTietVI', 'NoiDungChiTietEN', lang),
            location: mapText(row, 'DiaDiemVI', 'DiaDiemEN', lang),
            date: mapText(row, 'ThoiGianVI', 'ThoiGianEN', lang),
            image: row.ImageUrl,
            banner: row.BannerUrl
        } : null;
    }),
    listCuisines,
    // (Other exports remain as they were)
    getCuisineGallery: (lang) => Promise.resolve([]),
    listEthnicities: getEthnics,
    getEthnicity: getEthnicityDetail
}

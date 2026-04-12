UPDATE dbo.VungVanHoa
SET HomepageBadgeVI = N'Miền Bắc',
    HomepageTitleVI = N'Miền Bắc',
    HomepageDescriptionVI = N'Khám phá Hà Nội, Hạ Long và những ruộng bậc thang hùng vĩ của vùng núi phía Bắc.',
    HomepageHighlightsVI = N'["Hà Nội","Hạ Long","Sa Pa","Tuyên Quang"]',
    HomepageCtaVI = N'Khám phá Miền Bắc',
    HomepageImageAltVI = N'Cảnh sắc ruộng bậc thang miền Bắc Việt Nam'
WHERE MaVung = 'BAC_BO';

UPDATE dbo.VungVanHoa
SET HomepageBadgeVI = N'Miền Trung',
    HomepageTitleVI = N'Miền Trung',
    HomepageDescriptionVI = N'Từ Huế, Đà Nẵng đến Quảng Ngãi, miền Trung mang vẻ đẹp giao hòa giữa lịch sử và thiên nhiên.',
    HomepageHighlightsVI = N'["Huế","Đà Nẵng","Quảng Ngãi","Gia Lai"]',
    HomepageCtaVI = N'Khám phá Miền Trung',
    HomepageImageAltVI = N'Đèn lồng phố cổ và di sản miền Trung'
WHERE MaVung = 'TRUNG_BO';

UPDATE dbo.VungVanHoa
SET HomepageBadgeVI = N'Miền Nam',
    HomepageTitleVI = N'Miền Nam',
    HomepageDescriptionVI = N'Miền Nam nổi bật với TPHCM, đồng bằng sông Cửu Long và hành trình ẩm thực, chợ nổi, biển đảo.',
    HomepageHighlightsVI = N'["TPHCM","Cần Thơ","Vĩnh Long","An Giang"]',
    HomepageCtaVI = N'Khám phá Miền Nam',
    HomepageImageAltVI = N'Khung cảnh sông nước miền Nam Việt Nam'
WHERE MaVung = 'NAM_BO';

UPDATE dbo.VungVanHoa
SET OverviewTitleVI = CASE MaVung
        WHEN 'BAC_BO' THEN N'Nơi mây núi tích tụ từng lớp lịch sử'
        WHEN 'TRUNG_BO' THEN N'Dải đất di sản giữa núi và biển'
        WHEN 'NAM_BO' THEN N'Vùng sông nước bao la, lòng người rộng mở'
        ELSE OverviewTitleVI
    END,
    OverviewDescriptionVI = CASE MaVung
        WHEN 'BAC_BO' THEN N'Miền Bắc mang trong mình sự trầm lắng, kín đáo như tầng tầng lớp lớp ruộng bậc thang. Từ thủ đô nghìn năm văn hiến đến những bản làng cao nguyên, mỗi góc đất đều thấm đượm hồn văn hiến và sức sống bền bỉ của con người vùng núi.'
        WHEN 'TRUNG_BO' THEN N'Miền Trung là nơi hội tụ của núi non hùng vĩ và biển cả mênh mông. Từ cố đô Huế đến thành phố biển Đà Nẵng và dải duyên hải giàu di sản, vùng đất này lưu giữ chiều sâu lịch sử và vẻ đẹp giao thoa văn hóa.'
        WHEN 'NAM_BO' THEN N'Miền Nam là vùng đất của những dòng sông giao thoa, nơi nhịp sống chảy theo dòng nước. Từ TPHCM năng động đến đồng bằng sông Cửu Long trù phú, miền Nam toát lên sự rộng mở, phóng khoáng và lòng mến khách.'
        ELSE OverviewDescriptionVI
    END,
    OverviewDetailsJsonVI = CASE MaVung
        WHEN 'BAC_BO' THEN N'[{"label":"CẢNH QUAN ĐẶC TRƯNG","value":"Ruộng bậc thang Mù Cang Chải, vịnh Hạ Long, núi non Đông Bắc và đồng bằng sông Hồng"},{"label":"NÉT ẨM THỰC","value":"Phở Hà Nội, bún chả, nem rán, bánh cuốn, cà phê trứng và đặc sản vùng cao"},{"label":"LỄ HỘI TIÊU BIỂU","value":"Hội Lim, Chùa Hương, Lễ hội Đền Hùng, Tết Nguyên Đán, Hội Gióng"},{"label":"NGHỆ THUẬT & THỦ CÔNG","value":"Gốm Bát Tràng, lụa Vạn Phúc, tranh Đông Hồ, ca trù và quan họ Bắc Ninh"}]'
        WHEN 'TRUNG_BO' THEN N'[{"label":"CẢNH QUAN ĐẶC TRƯNG","value":"Cố đô Huế, bán đảo Sơn Trà, biển Đà Nẵng, đảo Lý Sơn và dải duyên hải miền Trung"},{"label":"NÉT ẨM THỰC","value":"Bún bò Huế, mì Quảng, bánh xèo, nem lụi, hải sản miền Trung và ẩm thực cung đình"},{"label":"LỄ HỘI TIÊU BIỂU","value":"Festival Huế, Lễ hội Cầu Ngư, lễ hội đình làng ven biển và các sinh hoạt tín ngưỡng miền Trung"},{"label":"NGHỆ THUẬT & THỦ CÔNG","value":"Nhã nhạc cung đình, thêu tay Huế, mộc điêu khắc, đèn lồng và các làng nghề ven biển"}]'
        WHEN 'NAM_BO' THEN N'[{"label":"CẢNH QUAN ĐẶC TRƯNG","value":"TPHCM sôi động, chợ nổi Cái Răng, đồng bằng sông Cửu Long, rừng ngập mặn và vùng biên giới An Giang"},{"label":"NÉT ẨM THỰC","value":"Cơm tấm, hủ tiếu, lẩu mắm, cá lóc nướng trui, trái cây miệt vườn và món ăn sông nước"},{"label":"LỄ HỘI TIÊU BIỂU","value":"Lễ hội Ok Om Bok, Nghinh Ông, Chol Chnam Thmay, lễ hội miệt vườn và sinh hoạt cộng đồng Nam Bộ"},{"label":"NGHỆ THUẬT & THỦ CÔNG","value":"Đờn ca tài tử, lụa Tân Châu, đan lát thủ công, gốm Biên Hòa và văn hóa chợ nổi"}]'
        ELSE OverviewDetailsJsonVI
    END
WHERE MaVung IN ('BAC_BO','TRUNG_BO','NAM_BO');

SELECT MaVung, HomepageTitleVI, HomepageCtaVI, HomepageHighlightsVI
FROM dbo.VungVanHoa
WHERE MaVung IN ('BAC_BO', 'TRUNG_BO', 'NAM_BO')
ORDER BY HomepageDisplayOrder;

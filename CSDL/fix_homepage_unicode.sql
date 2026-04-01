UPDATE dbo.VungVanHoa
SET HomepageBadgeVI = N'Miền Bắc',
    HomepageTitleVI = N'Miền Bắc',
    HomepageDescriptionVI = N'Khám phá Hà Nội, Hạ Long và những ruộng bậc thang hùng vĩ của vùng núi phía Bắc.',
    HomepageHighlightsVI = N'["Hà Nội","Hạ Long","Sa Pa","Hà Giang"]',
    HomepageCtaVI = N'Khám phá Miền Bắc',
    HomepageImageAltVI = N'Cảnh sắc ruộng bậc thang miền Bắc Việt Nam'
WHERE MaVung = 'BAC_BO';

UPDATE dbo.VungVanHoa
SET HomepageBadgeVI = N'Miền Trung',
    HomepageTitleVI = N'Miền Trung',
    HomepageDescriptionVI = N'Từ Huế, Hội An đến Đà Nẵng, miền Trung mang vẻ đẹp giao hòa giữa lịch sử và thiên nhiên.',
    HomepageHighlightsVI = N'["Huế","Hội An","Đà Nẵng","Mỹ Sơn"]',
    HomepageCtaVI = N'Khám phá Miền Trung',
    HomepageImageAltVI = N'Đèn lồng phố cổ Hội An về đêm'
WHERE MaVung = 'TRUNG_BO';

UPDATE dbo.VungVanHoa
SET HomepageBadgeVI = N'Miền Nam',
    HomepageTitleVI = N'Miền Nam',
    HomepageDescriptionVI = N'Miền Nam nổi bật với TP.HCM, miền Tây sông nước và hành trình ẩm thực, chợ nổi, biển đảo.',
    HomepageHighlightsVI = N'["TP.HCM","Cần Thơ","Mekong","Phú Quốc"]',
    HomepageCtaVI = N'Khám phá Miền Nam',
    HomepageImageAltVI = N'Khung cảnh sông nước miền Nam Việt Nam'
WHERE MaVung = 'NAM_BO';

SELECT MaVung, HomepageTitleVI, HomepageCtaVI, HomepageHighlightsVI
FROM dbo.VungVanHoa
WHERE MaVung IN ('BAC_BO', 'TRUNG_BO', 'NAM_BO')
ORDER BY HomepageDisplayOrder;

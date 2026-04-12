SET NOCOUNT ON;
GO

IF OBJECT_ID('dbo.LeHoi', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.LeHoi (
        LeHoiID                   INT IDENTITY(1,1) PRIMARY KEY,
        MaLeHoi                   VARCHAR(50) NOT NULL UNIQUE,
        LoaiBanGhi                VARCHAR(20) NOT NULL DEFAULT 'FESTIVAL',
        ThuTuHienThi              INT NOT NULL DEFAULT 0,
        TieuDeVI                  NVARCHAR(300) NULL,
        TieuDeEN                  NVARCHAR(300) NULL,
        TieuDePhuVI               NVARCHAR(300) NULL,
        TieuDePhuEN               NVARCHAR(300) NULL,
        ShortTitleVI              NVARCHAR(200) NULL,
        ShortTitleEN              NVARCHAR(200) NULL,
        MoTaNganVI                NVARCHAR(1500) NULL,
        MoTaNganEN                NVARCHAR(1500) NULL,
        HeroDescVI                NVARCHAR(1500) NULL,
        HeroDescEN                NVARCHAR(1500) NULL,
        ViTriVI                   NVARCHAR(300) NULL,
        ViTriEN                   NVARCHAR(300) NULL,
        NgayLeVI                  NVARCHAR(200) NULL,
        NgayLeEN                  NVARCHAR(200) NULL,
        TagVI                     NVARCHAR(150) NULL,
        TagEN                     NVARCHAR(150) NULL,
        TagColor                  VARCHAR(20) NULL,
        TimelineMonthVI           NVARCHAR(100) NULL,
        TimelineMonthEN           NVARCHAR(100) NULL,
        TimelineSeasonVI          NVARCHAR(100) NULL,
        TimelineSeasonEN          NVARCHAR(100) NULL,
        TimelineColor             VARCHAR(20) NULL,
        ImageUrl                  NVARCHAR(1000) NULL,
        ImageAltVI                NVARCHAR(500) NULL,
        ImageAltEN                NVARCHAR(500) NULL,
        TimelineImageUrl          NVARCHAR(1000) NULL,
        TimelineImageAltVI        NVARCHAR(500) NULL,
        TimelineImageAltEN        NVARCHAR(500) NULL,
        PageBadgeVI               NVARCHAR(200) NULL,
        PageBadgeEN               NVARCHAR(200) NULL,
        PageTitleLine1VI          NVARCHAR(200) NULL,
        PageTitleLine1EN          NVARCHAR(200) NULL,
        PageTitleAccentVI         NVARCHAR(200) NULL,
        PageTitleAccentEN         NVARCHAR(200) NULL,
        PageTitleLine3VI          NVARCHAR(200) NULL,
        PageTitleLine3EN          NVARCHAR(200) NULL,
        PageSubtitleVI            NVARCHAR(1500) NULL,
        PageSubtitleEN            NVARCHAR(1500) NULL,
        PageStatsJsonVI           NVARCHAR(MAX) NULL,
        PageStatsJsonEN           NVARCHAR(MAX) NULL,
        TimelineItemsJsonVI       NVARCHAR(MAX) NULL,
        TimelineItemsJsonEN       NVARCHAR(MAX) NULL,
        GalleryImagesJsonVI       NVARCHAR(MAX) NULL,
        GalleryImagesJsonEN       NVARCHAR(MAX) NULL,
        PageHeroImageUrl          NVARCHAR(1000) NULL,
        PageHeroImageAltVI        NVARCHAR(500) NULL,
        PageHeroImageAltEN        NVARCHAR(500) NULL,
        SearchPlaceholderVI       NVARCHAR(300) NULL,
        SearchPlaceholderEN       NVARCHAR(300) NULL,
        FilterButtonVI            NVARCHAR(200) NULL,
        FilterButtonEN            NVARCHAR(200) NULL,
        AllRegionsVI              NVARCHAR(100) NULL,
        AllRegionsEN              NVARCHAR(100) NULL,
        AllMonthsVI               NVARCHAR(100) NULL,
        AllMonthsEN               NVARCHAR(100) NULL,
        AllCategoriesVI           NVARCHAR(100) NULL,
        AllCategoriesEN           NVARCHAR(100) NULL,
        AllEthnicGroupsVI         NVARCHAR(150) NULL,
        AllEthnicGroupsEN         NVARCHAR(150) NULL,
        MajorBadgeVI              NVARCHAR(200) NULL,
        MajorBadgeEN              NVARCHAR(200) NULL,
        MajorTitleVI              NVARCHAR(300) NULL,
        MajorTitleEN              NVARCHAR(300) NULL,
        MajorSubtitleVI           NVARCHAR(1500) NULL,
        MajorSubtitleEN           NVARCHAR(1500) NULL,
        AllTitleVI                NVARCHAR(300) NULL,
        AllTitleEN                NVARCHAR(300) NULL,
        AllSubtitleVI             NVARCHAR(1500) NULL,
        AllSubtitleEN             NVARCHAR(1500) NULL,
        TimelineBadgeVI           NVARCHAR(200) NULL,
        TimelineBadgeEN           NVARCHAR(200) NULL,
        TimelineTitleVI           NVARCHAR(300) NULL,
        TimelineTitleEN           NVARCHAR(300) NULL,
        TimelineSubtitleVI        NVARCHAR(1500) NULL,
        TimelineSubtitleEN        NVARCHAR(1500) NULL,
        TimelineHintVI            NVARCHAR(200) NULL,
        TimelineHintEN            NVARCHAR(200) NULL,
        GalleryBadgeVI            NVARCHAR(200) NULL,
        GalleryBadgeEN            NVARCHAR(200) NULL,
        GalleryTitleVI            NVARCHAR(300) NULL,
        GalleryTitleEN            NVARCHAR(300) NULL,
        GallerySubtitleVI         NVARCHAR(1500) NULL,
        GallerySubtitleEN         NVARCHAR(1500) NULL,
        MeaningBadgeVI            NVARCHAR(200) NULL,
        MeaningBadgeEN            NVARCHAR(200) NULL,
        MeaningTitleVI            NVARCHAR(300) NULL,
        MeaningTitleEN            NVARCHAR(300) NULL,
        MeaningParagraphsJsonVI   NVARCHAR(MAX) NULL,
        MeaningParagraphsJsonEN   NVARCHAR(MAX) NULL,
        MeaningButtonVI           NVARCHAR(200) NULL,
        MeaningButtonEN           NVARCHAR(200) NULL,
        MeaningButtonHref         NVARCHAR(300) NULL,
        QuoteTitleVI              NVARCHAR(300) NULL,
        QuoteTitleEN              NVARCHAR(300) NULL,
        QuoteSubtitleVI           NVARCHAR(300) NULL,
        QuoteSubtitleEN           NVARCHAR(300) NULL,
        QuoteDescVI               NVARCHAR(1500) NULL,
        QuoteDescEN               NVARCHAR(1500) NULL,
        QuoteButtonVI             NVARCHAR(200) NULL,
        QuoteButtonEN             NVARCHAR(200) NULL,
        QuoteBackgroundImageUrl   NVARCHAR(1000) NULL,
        QuoteBackgroundImageAltVI NVARCHAR(500) NULL,
        QuoteBackgroundImageAltEN NVARCHAR(500) NULL,
        NoiDungJsonVI             NVARCHAR(MAX) NULL,
        NoiDungJsonEN             NVARCHAR(MAX) NULL,
        HoatDong                  BIT NOT NULL DEFAULT 1,
        NgayTao                   DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
        NgayCapNhat               DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME()
    );
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.LeHoi WHERE MaLeHoi = 'LE_HOI_PAGE')
BEGIN
INSERT INTO dbo.LeHoi (
    MaLeHoi, LoaiBanGhi, ThuTuHienThi,
    PageBadgeVI, PageTitleLine1VI, PageTitleAccentVI, PageTitleLine3VI, PageSubtitleVI,
    PageStatsJsonVI, TimelineItemsJsonVI, GalleryImagesJsonVI,
    PageHeroImageUrl, PageHeroImageAltVI,
    SearchPlaceholderVI, FilterButtonVI,
    AllRegionsVI, AllMonthsVI, AllCategoriesVI, AllEthnicGroupsVI,
    MajorBadgeVI, MajorTitleVI, MajorSubtitleVI,
    AllTitleVI, AllSubtitleVI,
    TimelineBadgeVI, TimelineTitleVI, TimelineSubtitleVI, TimelineHintVI,
    GalleryBadgeVI, GalleryTitleVI, GallerySubtitleVI,
    MeaningBadgeVI, MeaningTitleVI, MeaningParagraphsJsonVI, MeaningButtonVI, MeaningButtonHref,
    QuoteTitleVI, QuoteSubtitleVI, QuoteDescVI, QuoteButtonVI,
    QuoteBackgroundImageUrl, QuoteBackgroundImageAltVI, HoatDong
)
VALUES (
    'LE_HOI_PAGE', 'PAGE', 0,
    N'Lễ hội · Văn hóa · Truyền thống', N'Tinh hoa', N'Lễ hội', N'Việt Nam', N'Hàng nghìn năm truyền thống hội tụ trong từng lễ hội — nơi sắc màu, âm thanh và tâm hồn Việt hòa quyện thành một.',
    N'[{"value":"8.000+","label":"Lễ hội hàng năm"},{"value":"54","label":"Dân tộc anh em"},{"value":"63","label":"Tỉnh thành"}]',
    N'[{"id":1,"month":"Tháng 1","title":"Tết Nguyên Đán","season":"Mùa xuân","color":"#e11d48","image":"/images/banner1.jpg"},{"id":2,"month":"Tháng 4","title":"Giỗ Tổ Hùng Vương","season":"Mùa xuân","color":"#ea580c","image":"/images/giotohungvuong1.PNG"},{"id":3,"month":"Tháng 6","title":"Festival Huế","season":"Mùa hạ","color":"#10b981","image":"/images/festival_hue.png"},{"id":4,"month":"Tháng 9","title":"Tết Trung Thu","season":"Mùa thu","color":"#d946ef","image":"/images/banner2.jpg"},{"id":5,"month":"Tháng 10","title":"Lễ hội Katê","season":"Mùa thu","color":"#f59e0b","image":"/images/cham.jpg"},{"id":6,"month":"Tháng 12","title":"Nghinh Ông","season":"Mùa đông","color":"#6366f1","image":"/images/banner3.jpg"}]',
    N'[{"imageUrl":"/images/banner2.jpg","alt":"Khoảnh khắc lễ hội"},{"imageUrl":"/images/banner1.jpg","alt":"Không gian lễ hội mùa xuân"},{"imageUrl":"/images/festival_banner.jpg","alt":"Cảnh lễ hội Việt Nam"},{"imageUrl":"/images/banner3.jpg","alt":"Nghi thức lễ hội"},{"imageUrl":"/images/festival_hue.png","alt":"Festival Huế"},{"imageUrl":"/images/giotohungvuong1.PNG","alt":"Giỗ Tổ Hùng Vương"},{"imageUrl":"/images/hmong_festival_gau_tao_1775575986843.png","alt":"Lễ hội Gầu Tào"},{"imageUrl":"/images/hat-quan-ho.png","alt":"Quan họ"},{"imageUrl":"/images/cham.jpg","alt":"Không gian lễ hội Katê"}]',
    N'/images/festival_banner.jpg', N'Ảnh bìa trang lễ hội',
    N'Tìm kiếm lễ hội, nghi lễ và truyền thống...', N'Bộ lọc nâng cao',
    N'Tất cả khu vực', N'Tất cả tháng', N'Tất cả loại hình', N'Tất cả nhóm trải nghiệm',
    N'Lễ hội nổi bật', N'Lễ hội tiêu biểu', N'Khám phá những lễ hội nổi bật và có sức lan tỏa mạnh mẽ trong văn hóa Việt Nam.',
    N'Khám phá các lễ hội Việt Nam', N'Mở từng trang để xem nội dung lễ hội tương ứng được tải động từ hệ thống.',
    N'Lễ hội quanh năm', N'Dòng thời gian lễ hội', N'Khám phá nhịp điệu văn hóa Việt Nam qua từng mùa trong năm.', N'Cuộn ngang để xem thêm →',
    N'Hành trình thị giác', N'Khoảnh khắc lễ hội', N'Đắm mình trong bầu không khí và cảm xúc của những mùa lễ hội Việt Nam.',
    N'Ý nghĩa văn hóa', N'Linh hồn của lễ hội Việt', N'["Lễ hội Việt Nam không chỉ là những ngày vui mà còn là nơi kết nối con người với cội nguồn, vùng đất và ký ức cộng đồng.","Mỗi nghi thức, biểu tượng và hoạt động trong lễ hội đều phản ánh chiều sâu văn hóa, niềm tin và tinh thần gắn kết của người Việt.","Khi tham gia lễ hội, chúng ta không chỉ quan sát mà còn trực tiếp cảm nhận nhịp sống văn hóa đang tiếp tục được lưu truyền qua nhiều thế hệ."]', N'Tìm hiểu thêm về văn hóa Việt', N'/articles',
    N'Uống nước nhớ nguồn', N'Nhớ về cội nguồn để gìn giữ giá trị văn hóa', N'Tinh thần biết ơn cội nguồn chính là nền tảng để các lễ hội Việt Nam tiếp tục sống động trong đời sống hôm nay.', N'Khám phá văn hóa',
    N'/images/banner1.jpg', N'Ảnh nền trích dẫn trang lễ hội', 1
);
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.LeHoi WHERE MaLeHoi = 'tet-nguyen-dan')
BEGIN
INSERT INTO dbo.LeHoi (
    MaLeHoi, LoaiBanGhi, ThuTuHienThi, TieuDeVI, TieuDePhuVI, ShortTitleVI, MoTaNganVI, HeroDescVI,
    ViTriVI, NgayLeVI, TagVI, TagColor, ImageUrl, ImageAltVI,
    TimelineMonthVI, TimelineSeasonVI, TimelineImageUrl, TimelineImageAltVI, TimelineColor,
    NoiDungJsonVI, HoatDong
) VALUES (
    'tet-nguyen-dan','FESTIVAL',1,N'Tết Nguyên Đán',N'Tết cổ truyền Việt Nam',N'Tết',
    N'Lễ tết quan trọng nhất trong năm của người Việt, gắn với đoàn viên gia đình và khởi đầu năm mới.',
    N'Lễ hội lớn nhất trong năm, tôn vinh đoàn viên, tổ tiên và khởi đầu mới.',
    N'Toàn quốc',N'Tháng 1 - Tháng 2',N'Lễ hội lớn','#ce112d',N'/images/banner1.jpg',N'Tết Nguyên Đán',
    N'Tháng 1',N'Mùa xuân',N'/images/banner1.jpg',N'Tết Nguyên Đán', '#e11d48',
    N'{"whatIsItContext":["Tết Nguyên Đán là dịp chuyển giao giữa năm cũ và năm mới theo âm lịch, gắn với tinh thần đoàn viên, tưởng nhớ tổ tiên và khởi đầu một chu kỳ sống mới.","Trong những ngày Tết, các gia đình dọn dẹp nhà cửa, chuẩn bị mâm cỗ, trang hoàng không gian sống và dành thời gian sum họp bên nhau."],"quickFacts":{"date":"Cuối tháng Chạp đến đầu tháng Giêng âm lịch","location":"Toàn quốc","participants":"Mọi gia đình và cộng đồng"},"howItIsCelebrated":[{"phase":"Chuẩn bị","title":"Dọn dẹp và sắm Tết","desc":["Người Việt sửa soạn nhà cửa, mua hoa, gói bánh và chuẩn bị lễ vật cúng ông bà.","Không khí Tết bắt đầu từ những ngày cuối năm khi chợ hoa, phố phường và từng gia đình đều rộn ràng chuẩn bị."],"image":"/images/anhtet1.PNG","align":"left"},{"phase":"Giao thừa","title":"Khoảnh khắc chuyển năm","desc":["Đêm giao thừa là thời khắc linh thiêng để cúng tổ tiên, cầu bình an và chào đón năm mới.","Nhiều gia đình quây quần bên nhau, nghe lời chúc đầu năm và tận hưởng cảm giác mở đầu mới mẻ."],"image":"/images/banner2.jpg","align":"right"},{"phase":"Đầu xuân","title":"Chúc Tết và du xuân","desc":["Mọi người thăm hỏi họ hàng, lì xì trẻ em, đi lễ chùa và tham gia các hoạt động hội xuân.","Những nghi thức đầu năm thể hiện sự gắn kết gia đình, niềm tin vào may mắn và ước vọng tốt đẹp."],"image":"/images/banner3.jpg","align":"left"}],"whatTetFeelsLike":{"leftText":["Đường phố: Ngập tràn sắc đỏ, đào, mai và không khí nô nức đón xuân.","Âm thanh: Tiếng chúc Tết, tiếng cười nói, tiếng nhạc xuân và nhịp điệu hội hè vang lên khắp nơi.","Nhịp sống: Từ tất bật chuẩn bị chuyển sang khoảnh khắc sum họp, ấm áp và đầy hy vọng."],"rightText":["Mái nhà: Được trang hoàng sạch đẹp với mâm ngũ quả, câu đối và bàn thờ tổ tiên tươm tất.","Cảm xúc: Là sự hòa quyện giữa hoài niệm, biết ơn và mong ước cho một năm bình an hơn.","Trải nghiệm: Dù ở thành thị hay nông thôn, Tết luôn tạo cảm giác thuộc về và gắn kết rất sâu sắc."],"image":"/images/festival_banner.jpg"},"keyTraditionsDocs":[{"image":"/images/banner2.jpg","title":"Lì xì đầu năm","desc":"Phong tục mừng tuổi mang lời chúc may mắn, sức khỏe và thành công."},{"image":"/images/banner3.jpg","title":"Bánh chưng - bánh tét","desc":"Món ăn biểu tượng của Tết, thể hiện sự biết ơn với đất trời và tổ tiên."},{"image":"/images/anhtet1.PNG","title":"Cúng gia tiên","desc":"Nghi thức quan trọng giúp kết nối các thế hệ trong gia đình."}],"traditionalFoods":[{"image":"/images/banner3.jpg","title":"Bánh chưng","desc":"Món bánh truyền thống gắn với Tết miền Bắc."},{"image":"/images/banner2.jpg","title":"Thịt kho trứng","desc":"Món ăn quen thuộc trong mâm cơm Tết nhiều gia đình."},{"image":"/images/festival_banner.jpg","title":"Mứt Tết","desc":"Hương vị ngọt ngào thường dùng để tiếp khách đầu xuân."}],"regionalFoods":{"north":[{"image":"/images/banner1.jpg","title":"Dưa hành","desc":"Món ăn giúp cân bằng hương vị trong mâm cỗ Tết."}],"central":[{"image":"/images/banner2.jpg","title":"Bánh tét","desc":"Hương vị đậm đà thường gặp ở miền Trung và miền Nam."}],"south":[{"image":"/images/banner3.jpg","title":"Canh khổ qua nhồi thịt","desc":"Món ăn gửi gắm mong muốn khó khăn qua đi."}]},"culturalMeaningsDocs":[{"icon":"✨","title":"Khởi đầu mới","desc":"Tết tượng trưng cho sự đổi mới, tái tạo và hy vọng.","colorClass":"highlight-red"},{"icon":"👨‍👩‍👧‍👦","title":"Đoàn viên gia đình","desc":"Đây là dịp sum họp thiêng liêng nhất trong năm của người Việt.","colorClass":"highlight-orange"},{"icon":"🙏","title":"Biết ơn tổ tiên","desc":"Tinh thần uống nước nhớ nguồn được thể hiện sâu sắc trong mỗi nghi thức đầu năm.","colorClass":"highlight-yellow"}],"interestingFactsDocs":[{"icon":"🧧","title":"Sắc đỏ may mắn","desc":"Màu đỏ xuất hiện dày đặc trong trang trí ngày Tết như biểu tượng của phúc lộc."},{"icon":"🎇","title":"Khoảnh khắc giao thừa","desc":"Nhiều người xem giao thừa là thời khắc quan trọng nhất để gửi gắm mong ước đầu năm."},{"icon":"🌸","title":"Hoa xuân ba miền","desc":"Miền Bắc chuộng hoa đào, miền Nam yêu hoa mai, tạo nên bản sắc xuân rất riêng."}],"galleryHero":"/images/festival_banner.jpg","galleryGrid":["/images/banner1.jpg","/images/banner2.jpg","/images/banner3.jpg","/images/anhtet1.PNG","/images/banner1.jpg","/images/banner2.jpg"],"inShortText":"Tết Nguyên Đán là lát cắt rõ nét nhất của văn hóa Việt Nam — nơi gia đình, ký ức tổ tiên và niềm hy vọng đầu năm giao hòa trong cùng một không khí lễ hội.","discoverMore":[{"image":"/images/banner3.jpg","title":"Món ăn ngày Tết","desc":"Tìm hiểu ý nghĩa văn hóa đằng sau các món ăn truyền thống trong dịp đầu năm."},{"image":"/images/anhtet1.PNG","title":"Phong tục đầu xuân","desc":"Khám phá những tập quán quen thuộc như lì xì, chúc Tết, xông đất và du xuân."},{"image":"/images/festival_banner.jpg","title":"Không khí đoàn viên","desc":"Cảm nhận chiều sâu cảm xúc và tinh thần gia đình trong những ngày Tết Việt."}],"labels":{"whatIsItTitle":"Tết Nguyên Đán là gì?","dateLabel":"Thời gian","locationLabel":"Địa điểm","participantsLabel":"Thành phần tham gia","celebrationTitle":"Tết Nguyên Đán được tổ chức như thế nào?","feelsLikeTitle":"Trải nghiệm không khí Tết","keyTraditionsTitle":"Những nét truyền thống nổi bật","traditionalFoodsTitle":"Ẩm thực gắn với Tết Nguyên Đán","traditionalFoodsSubtitle":"Những món ăn ngày Tết không chỉ ngon mà còn mang theo nhiều lớp ý nghĩa văn hóa.","northRegionLabel":"Miền Bắc","centralRegionLabel":"Miền Trung","southRegionLabel":"Miền Nam","culturalMeaningsTitle":"Ý nghĩa văn hóa","interestingFactsTitle":"Điều thú vị về Tết Nguyên Đán","galleryTitle":"Tết Nguyên Đán qua hình ảnh","inShortTitle":"Tóm lược","discoverMoreTitle":"Khám phá thêm về Tết Nguyên Đán"}}',
    1
);
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.LeHoi WHERE MaLeHoi = 'tet-trung-thu')
INSERT INTO dbo.LeHoi (MaLeHoi,LoaiBanGhi,ThuTuHienThi,TieuDeVI,TieuDePhuVI,ShortTitleVI,MoTaNganVI,HeroDescVI,ViTriVI,NgayLeVI,TagVI,TagColor,ImageUrl,ImageAltVI,TimelineMonthVI,TimelineSeasonVI,TimelineImageUrl,TimelineImageAltVI,TimelineColor,HoatDong)
VALUES ('tet-trung-thu','FESTIVAL',2,N'Tết Trung Thu',N'Lễ hội trăng rằm',N'Trung Thu',N'Lễ hội dành cho thiếu nhi với lồng đèn, múa lân, bánh trung thu và không khí sum họp gia đình.',N'Lễ hội trăng rằm gắn với ký ức tuổi thơ, lồng đèn và tinh thần đoàn viên.',N'Toàn quốc',N'Tháng 8 âm lịch',N'Lễ hội lớn','#d946ef',N'/images/banner2.jpg',N'Tết Trung Thu',N'Tháng 9',N'Mùa thu',N'/images/banner2.jpg',N'Tết Trung Thu','#d946ef',1);
GO

IF NOT EXISTS (SELECT 1 FROM dbo.LeHoi WHERE MaLeHoi = 'gio-to-hung-vuong')
INSERT INTO dbo.LeHoi (MaLeHoi,LoaiBanGhi,ThuTuHienThi,TieuDeVI,TieuDePhuVI,ShortTitleVI,MoTaNganVI,HeroDescVI,ViTriVI,NgayLeVI,TagVI,TagColor,ImageUrl,ImageAltVI,TimelineMonthVI,TimelineSeasonVI,TimelineImageUrl,TimelineImageAltVI,TimelineColor,HoatDong)
VALUES ('gio-to-hung-vuong','FESTIVAL',3,N'Giỗ Tổ Hùng Vương',N'Lễ tưởng niệm các Vua Hùng',N'Đền Hùng',N'Ngày lễ lớn để tưởng nhớ các Vua Hùng, gắn với đạo lý uống nước nhớ nguồn và bản sắc dân tộc.',N'Lễ hội tưởng niệm nguồn cội dân tộc với nghi thức dâng hương và sinh hoạt cộng đồng.',N'Phú Thọ',N'Mùng 10 tháng 3 âm lịch',N'Văn hóa','#ea580c',N'/images/giotohungvuong1.PNG',N'Giỗ Tổ Hùng Vương',N'Tháng 4',N'Mùa xuân',N'/images/giotohungvuong1.PNG',N'Giỗ Tổ Hùng Vương','#ea580c',1);
GO

IF NOT EXISTS (SELECT 1 FROM dbo.LeHoi WHERE MaLeHoi = 'festival-hue')
INSERT INTO dbo.LeHoi (MaLeHoi,LoaiBanGhi,ThuTuHienThi,TieuDeVI,TieuDePhuVI,ShortTitleVI,MoTaNganVI,HeroDescVI,ViTriVI,NgayLeVI,TagVI,TagColor,ImageUrl,ImageAltVI,TimelineMonthVI,TimelineSeasonVI,TimelineImageUrl,TimelineImageAltVI,TimelineColor,HoatDong)
VALUES ('festival-hue','FESTIVAL',4,N'Festival Huế',N'Lễ hội di sản cố đô',N'Huế',N'Sự kiện văn hóa quy mô lớn tái hiện vẻ đẹp cung đình, nghệ thuật trình diễn và di sản cố đô Huế.',N'Lễ hội văn hóa kết nối di sản cung đình, nghệ thuật đương đại và trải nghiệm cộng đồng.',N'Huế',N'Tháng 6',N'Văn hóa','#10b981',N'/images/festival_hue.png',N'Festival Huế',N'Tháng 6',N'Mùa hạ',N'/images/festival_hue.png',N'Festival Huế','#10b981',1);
GO

IF NOT EXISTS (SELECT 1 FROM dbo.LeHoi WHERE MaLeHoi = 'gau-tao')
INSERT INTO dbo.LeHoi (MaLeHoi,LoaiBanGhi,ThuTuHienThi,TieuDeVI,TieuDePhuVI,ShortTitleVI,MoTaNganVI,HeroDescVI,ViTriVI,NgayLeVI,TagVI,TagColor,ImageUrl,ImageAltVI,TimelineMonthVI,TimelineSeasonVI,TimelineImageUrl,TimelineImageAltVI,TimelineColor,HoatDong)
VALUES ('gau-tao','FESTIVAL',5,N'Lễ hội Gầu Tào',N'Lễ hội cầu phúc của người H''Mông',N'Gầu Tào',N'Lễ hội mùa xuân của người H''Mông, cầu bình an, sức khỏe và mùa màng thuận lợi cho cộng đồng.',N'Lễ hội cộng đồng giàu bản sắc vùng cao, gắn với khèn, trò chơi dân gian và lời cầu chúc đầu năm.',N'Miền núi phía Bắc',N'Tháng 1',N'Dân tộc','#8b5cf6',N'/images/hmong_festival_gau_tao_1775575986843.png',N'Lễ hội Gầu Tào',N'Tháng 1',N'Mùa xuân',N'/images/hmong_festival_gau_tao_1775575986843.png',N'Lễ hội Gầu Tào','#8b5cf6',1);
GO

IF NOT EXISTS (SELECT 1 FROM dbo.LeHoi WHERE MaLeHoi = 'kate')
INSERT INTO dbo.LeHoi (MaLeHoi,LoaiBanGhi,ThuTuHienThi,TieuDeVI,TieuDePhuVI,ShortTitleVI,MoTaNganVI,HeroDescVI,ViTriVI,NgayLeVI,TagVI,TagColor,ImageUrl,ImageAltVI,TimelineMonthVI,TimelineSeasonVI,TimelineImageUrl,TimelineImageAltVI,TimelineColor,HoatDong)
VALUES ('kate','FESTIVAL',6,N'Lễ hội Katê',N'Lễ hội đặc sắc của người Chăm',N'Katê',N'Lễ hội lớn của người Chăm nhằm tưởng nhớ tổ tiên, thần linh và tôn vinh bản sắc văn hóa cộng đồng.',N'Lễ hội gắn với đền tháp, âm nhạc, trang phục và nghi thức cộng đồng của người Chăm.',N'Ninh Thuận - Bình Thuận',N'Tháng 10',N'Dân tộc','#f59e0b',N'/images/cham.jpg',N'Lễ hội Katê',N'Tháng 10',N'Mùa thu',N'/images/cham.jpg',N'Lễ hội Katê','#f59e0b',1);
GO

IF NOT EXISTS (SELECT 1 FROM dbo.LeHoi WHERE MaLeHoi = 'nghinh-ong')
INSERT INTO dbo.LeHoi (MaLeHoi,LoaiBanGhi,ThuTuHienThi,TieuDeVI,TieuDePhuVI,ShortTitleVI,MoTaNganVI,HeroDescVI,ViTriVI,NgayLeVI,TagVI,TagColor,ImageUrl,ImageAltVI,TimelineMonthVI,TimelineSeasonVI,TimelineImageUrl,TimelineImageAltVI,TimelineColor,HoatDong)
VALUES ('nghinh-ong','FESTIVAL',7,N'Lễ hội Nghinh Ông',N'Lễ hội tín ngưỡng vùng biển',N'Nghinh Ông',N'Lễ hội của cư dân vùng biển nhằm cầu mong bình an, mưa thuận gió hòa và mùa đánh bắt thuận lợi.',N'Lễ hội phản ánh đời sống tín ngưỡng của ngư dân và mối gắn bó giữa con người với biển cả.',N'Nam Bộ ven biển',N'Tháng 12',N'Tín ngưỡng','#6366f1',N'/images/banner3.jpg',N'Lễ hội Nghinh Ông',N'Tháng 12',N'Mùa đông',N'/images/banner3.jpg',N'Lễ hội Nghinh Ông','#6366f1',1);
GO

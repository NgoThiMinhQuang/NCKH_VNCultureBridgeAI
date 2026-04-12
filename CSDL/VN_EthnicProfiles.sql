/* =========================================================
   ETHNIC PROFILE + SECTION IMAGE DATA
   Phục vụ giao diện Văn hóa dân tộc với ảnh riêng cho từng section
   ========================================================= */

SET NOCOUNT ON;

IF OBJECT_ID('dbo.DanTocProfile', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.DanTocProfile (
        DanTocID                    INT NOT NULL PRIMARY KEY,
        HeroBackgroundImageUrl      NVARCHAR(1000) NULL,
        HeroBackgroundAltVI         NVARCHAR(500) NULL,
        HeroBackgroundAltEN         NVARCHAR(500) NULL,
        HeroForegroundImageUrl      NVARCHAR(1000) NULL,
        HeroForegroundAltVI         NVARCHAR(500) NULL,
        HeroForegroundAltEN         NVARCHAR(500) NULL,
        IntroImageUrl               NVARCHAR(1000) NULL,
        IntroImageAltVI             NVARCHAR(500) NULL,
        IntroImageAltEN             NVARCHAR(500) NULL,
        FeatureHighlightImageUrl    NVARCHAR(1000) NULL,
        FeatureHighlightAltVI       NVARCHAR(500) NULL,
        FeatureHighlightAltEN       NVARCHAR(500) NULL,
        MusicImageUrl               NVARCHAR(1000) NULL,
        MusicImageAltVI             NVARCHAR(500) NULL,
        MusicImageAltEN             NVARCHAR(500) NULL,
        ArchitectureImageUrl        NVARCHAR(1000) NULL,
        ArchitectureImageAltVI      NVARCHAR(500) NULL,
        ArchitectureImageAltEN      NVARCHAR(500) NULL,
        CardImageUrl                NVARCHAR(1000) NULL,
        CardImageAltVI              NVARCHAR(500) NULL,
        CardImageAltEN              NVARCHAR(500) NULL,
        HeroSubtitleVI              NVARCHAR(1000) NULL,
        HeroSubtitleEN              NVARCHAR(1000) NULL,
        OverviewTitleVI             NVARCHAR(300) NULL,
        OverviewTitleEN             NVARCHAR(300) NULL,
        OverviewBodyVI              NVARCHAR(MAX) NULL,
        OverviewBodyEN              NVARCHAR(MAX) NULL,
        HistoryTitleVI              NVARCHAR(300) NULL,
        HistoryTitleEN              NVARCHAR(300) NULL,
        HistoryBodyVI               NVARCHAR(MAX) NULL,
        HistoryBodyEN               NVARCHAR(MAX) NULL,
        CultureTitleVI              NVARCHAR(300) NULL,
        CultureTitleEN              NVARCHAR(300) NULL,
        CultureBodyVI               NVARCHAR(MAX) NULL,
        CultureBodyEN               NVARCHAR(MAX) NULL,
        ArchitectureTitleVI         NVARCHAR(300) NULL,
        ArchitectureTitleEN         NVARCHAR(300) NULL,
        ArchitectureBodyVI          NVARCHAR(MAX) NULL,
        ArchitectureBodyEN          NVARCHAR(MAX) NULL,
        PrimaryRegionLabelVI        NVARCHAR(200) NULL,
        PrimaryRegionLabelEN        NVARCHAR(200) NULL,
        PopulationLabelVI           NVARCHAR(200) NULL,
        PopulationLabelEN           NVARCHAR(200) NULL,
        ListBadgeVI                 NVARCHAR(150) NULL,
        ListBadgeEN                 NVARCHAR(150) NULL,
        IsNew                       BIT NOT NULL DEFAULT 0,
        DisplayOrder                INT NOT NULL DEFAULT 0,
        HoatDong                    BIT NOT NULL DEFAULT 1,
        NgayTao                     DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
        NgayCapNhat                 DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
        CONSTRAINT FK_DanTocProfile_DanToc FOREIGN KEY (DanTocID) REFERENCES dbo.DanToc(DanTocID) ON DELETE CASCADE
    );
END
GO

IF COL_LENGTH('dbo.DanTocProfile', 'ListBadgeVI') IS NULL
    ALTER TABLE dbo.DanTocProfile ADD ListBadgeVI NVARCHAR(150) NULL;
GO

IF COL_LENGTH('dbo.DanTocProfile', 'ListBadgeEN') IS NULL
    ALTER TABLE dbo.DanTocProfile ADD ListBadgeEN NVARCHAR(150) NULL;
GO

IF COL_LENGTH('dbo.DanTocProfile', 'IsNew') IS NULL
    ALTER TABLE dbo.DanTocProfile ADD IsNew BIT NOT NULL CONSTRAINT DF_DanTocProfile_IsNew DEFAULT 0;
GO

IF OBJECT_ID('dbo.DanTocSectionItem', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.DanTocSectionItem (
        DanTocSectionItemID         INT IDENTITY(1,1) PRIMARY KEY,
        DanTocID                    INT NOT NULL,
        LoaiSection                 VARCHAR(30) NOT NULL,
        TieuDeVI                    NVARCHAR(300) NULL,
        TieuDeEN                    NVARCHAR(300) NULL,
        MoTaVI                      NVARCHAR(MAX) NULL,
        MoTaEN                      NVARCHAR(MAX) NULL,
        ImageUrl                    NVARCHAR(1000) NULL,
        ImageAltVI                  NVARCHAR(500) NULL,
        ImageAltEN                  NVARCHAR(500) NULL,
        LayoutSize                  VARCHAR(20) NULL,
        TagVI                       NVARCHAR(150) NULL,
        TagEN                       NVARCHAR(150) NULL,
        LienKetBaiVietID            INT NULL,
        ThuTuHienThi                INT NOT NULL DEFAULT 0,
        HoatDong                    BIT NOT NULL DEFAULT 1,
        NgayTao                     DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
        NgayCapNhat                 DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
        CONSTRAINT CK_DanTocSectionItem_Loai CHECK (LoaiSection IN ('TEXTILES','FESTIVALS','CUISINE','ARTS','GALLERY','FEATURES','STORIES')),
        CONSTRAINT FK_DanTocSectionItem_DanToc FOREIGN KEY (DanTocID) REFERENCES dbo.DanToc(DanTocID) ON DELETE CASCADE,
        CONSTRAINT FK_DanTocSectionItem_BaiViet FOREIGN KEY (LienKetBaiVietID) REFERENCES dbo.BaiViet(BaiVietID)
    );
END
GO

MERGE dbo.DanTocProfile AS target
USING (
    SELECT dt.DanTocID, dt.MaDanToc,
        v.HeroBackgroundImageUrl, v.HeroBackgroundAltVI, v.HeroBackgroundAltEN,
        v.HeroForegroundImageUrl, v.HeroForegroundAltVI, v.HeroForegroundAltEN,
        v.IntroImageUrl, v.IntroImageAltVI, v.IntroImageAltEN,
        v.FeatureHighlightImageUrl, v.FeatureHighlightAltVI, v.FeatureHighlightAltEN,
        v.MusicImageUrl, v.MusicImageAltVI, v.MusicImageAltEN,
        v.ArchitectureImageUrl, v.ArchitectureImageAltVI, v.ArchitectureImageAltEN,
        v.CardImageUrl, v.CardImageAltVI, v.CardImageAltEN,
        v.HeroSubtitleVI, v.HeroSubtitleEN,
        v.OverviewTitleVI, v.OverviewTitleEN, v.OverviewBodyVI, v.OverviewBodyEN,
        v.HistoryTitleVI, v.HistoryTitleEN, v.HistoryBodyVI, v.HistoryBodyEN,
        v.CultureTitleVI, v.CultureTitleEN, v.CultureBodyVI, v.CultureBodyEN,
        v.ArchitectureTitleVI, v.ArchitectureTitleEN, v.ArchitectureBodyVI, v.ArchitectureBodyEN,
        v.PrimaryRegionLabelVI, v.PrimaryRegionLabelEN, v.PopulationLabelVI, v.PopulationLabelEN,
        v.DisplayOrder
    FROM dbo.DanToc dt
    JOIN (VALUES
        ('HMONG',
         N'https://images.unsplash.com/photo-1500530855697-b586d89ba3ee?auto=format&fit=crop&w=1600&q=80', N'Phong cảnh vùng cao phía Bắc gắn với người H''Mông', N'Northern highland landscape associated with the Hmong people',
         N'https://images.unsplash.com/photo-1518546305927-5a555bb7020d?auto=format&fit=crop&w=900&q=80', N'Chân dung người H''Mông trong trang phục truyền thống', N'Hmong portrait in traditional attire',
         N'https://images.unsplash.com/photo-1518546305927-5a555bb7020d?auto=format&fit=crop&w=900&q=80', N'Người H''Mông trong đời sống thường nhật', N'Hmong daily life portrait',
         N'https://images.unsplash.com/photo-1500534314209-a25ddb2bd429?auto=format&fit=crop&w=1200&q=80', N'Không gian văn hóa vùng cao của người H''Mông', N'Hmong highland cultural scene',
         N'https://images.unsplash.com/photo-1500534314209-a25ddb2bd429?auto=format&fit=crop&w=1200&q=80', N'Nghệ thuật trình diễn của cộng đồng H''Mông', N'Hmong performing arts scene',
         N'https://images.unsplash.com/photo-1466721591366-2d5fba72006d?auto=format&fit=crop&w=1200&q=80', N'Không gian nhà ở vùng núi đá của người H''Mông', N'Hmong mountain dwelling space',
         N'https://images.unsplash.com/photo-1518546305927-5a555bb7020d?auto=format&fit=crop&w=900&q=80', N'Ảnh đại diện dân tộc H''Mông', N'Hmong card image',
         N'Một cộng đồng dân tộc tiêu biểu của vùng núi phía Bắc với sắc màu trang phục, chợ phiên và nghệ thuật trình diễn giàu bản sắc.',
         N'A northern highland ethnic community known for colorful dress, upland markets, and vibrant performance traditions.',
         N'Giới thiệu về người H''Mông', N'Introduction to the Hmong people',
         N'Người H''Mông sinh sống chủ yếu ở các tỉnh miền núi phía Bắc Việt Nam, nổi bật với văn hóa chợ phiên, nghề dệt lanh, kỹ thuật batik sáp ong và nhạc cụ khèn. Bản sắc của cộng đồng được lưu giữ qua ngôn ngữ, trang phục và nghi lễ vòng đời.',
         N'The Hmong people live mainly in northern Vietnam and are known for upland markets, linen weaving, beeswax batik, and the khen flute. Their identity is preserved through language, dress, and life-cycle rituals.',
         N'Lịch sử & nguồn gốc', N'History & Origins',
         N'Cộng đồng H''Mông có lịch sử cư trú lâu đời tại vùng núi cao, thích nghi với địa hình đá vôi, khí hậu lạnh và nhịp sống nương rẫy. Quá trình di cư và định cư đã tạo nên nhiều nhóm địa phương với sắc thái văn hóa đa dạng.',
         N'The Hmong have a long history of life in mountain environments, adapting to limestone terrain, cool climates, and upland farming. Migration and resettlement shaped several local sub-groups with varied cultural expression.',
         N'Đặc trưng văn hóa', N'Cultural Identity',
         N'Trang phục thêu tay, kỹ thuật sáp ong, tiếng khèn, chợ tình và các lễ nghi cộng đồng là những biểu tượng nổi bật của người H''Mông. Mỗi chi tiết hoa văn và nghi thức đều gắn với ký ức tổ tiên và quan niệm sống hòa hợp với núi rừng.',
         N'Embroidery, beeswax batik, the khen flute, love markets, and community rituals are among the Hmong''s most distinctive cultural symbols. Motifs and ceremonies are deeply tied to ancestral memory and mountain life.',
         N'Không gian sống', N'Living Space',
         N'Nhà ở của người H''Mông thường thích ứng với điều kiện vùng núi, sử dụng vật liệu địa phương và bố trí gắn với sản xuất nương rẫy. Không gian sống thể hiện rõ mối liên hệ giữa gia đình, cộng đồng và cảnh quan tự nhiên.',
         N'Hmong dwellings are adapted to mountain environments, using local materials and layouts closely tied to upland farming. The home reflects the bond between family, community, and the surrounding landscape.',
         N'Miền núi phía Bắc', N'Northern Highlands', N'Hơn 1,3 triệu người', N'Over 1.3 million people', 1),
        ('KHMER',
         N'https://images.unsplash.com/photo-1528127269322-539801943592?auto=format&fit=crop&w=1600&q=80', N'Không gian chùa Khmer Nam Bộ', N'Southern Khmer temple scene',
         N'https://images.unsplash.com/photo-1517486808906-6ca8b3f04846?auto=format&fit=crop&w=900&q=80', N'Chân dung sinh hoạt văn hóa Khmer', N'Khmer cultural portrait',
         N'https://images.unsplash.com/photo-1517486808906-6ca8b3f04846?auto=format&fit=crop&w=900&q=80', N'Nghi lễ và đời sống văn hóa Khmer', N'Khmer ritual and cultural life',
         N'https://images.unsplash.com/photo-1528127269322-539801943592?auto=format&fit=crop&w=1200&q=80', N'Kiến trúc chùa Khmer Nam Bộ', N'Southern Khmer temple architecture',
         N'https://images.unsplash.com/photo-1517486808906-6ca8b3f04846?auto=format&fit=crop&w=1200&q=80', N'Nghệ thuật sân khấu Khmer', N'Khmer performance arts',
         N'https://images.unsplash.com/photo-1528127269322-539801943592?auto=format&fit=crop&w=1200&q=80', N'Không gian cư trú của cộng đồng Khmer', N'Khmer living space',
         N'https://images.unsplash.com/photo-1517486808906-6ca8b3f04846?auto=format&fit=crop&w=900&q=80', N'Ảnh đại diện dân tộc Khmer', N'Khmer card image',
         N'Cộng đồng Khmer Nam Bộ nổi bật với Phật giáo Nam tông, lễ hội truyền thống và nghệ thuật sân khấu dân gian.',
         N'The Khmer community of southern Vietnam is known for Theravada Buddhism, traditional festivals, and folk stage arts.',
         N'Giới thiệu về người Khmer', N'Introduction to the Khmer people',
         N'Người Khmer sinh sống tập trung tại đồng bằng sông Cửu Long, nơi văn hóa cộng đồng gắn bó chặt chẽ với chùa chiền, lịch nông nghiệp và nghệ thuật lễ hội. Bản sắc Khmer hiện diện rõ trong ngôn ngữ, tín ngưỡng và sinh hoạt cộng đồng.',
         N'The Khmer people are concentrated in the Mekong Delta, where community life is closely tied to temples, agricultural rhythms, and festival arts. Their identity is reflected in language, belief systems, and communal life.',
         N'Lịch sử & nguồn gốc', N'History & Origins',
         N'Người Khmer là một trong những cộng đồng cư trú lâu đời ở Nam Bộ, góp phần hình thành bản sắc văn hóa đa dạng của vùng đất sông nước. Những lớp trầm tích lịch sử này được phản ánh qua kiến trúc, lễ hội và đời sống tâm linh.',
         N'The Khmer are among the long-established communities of southern Vietnam, helping shape the diverse cultural identity of the Mekong Delta. These historical layers are reflected in architecture, festivals, and spiritual life.',
         N'Đặc trưng văn hóa', N'Cultural Identity',
         N'Phật giáo Nam tông, nghệ thuật Rô băm - Dù kê, lễ hội Oóc Om Bóc và hệ thống chùa Khmer tạo nên diện mạo văn hóa đặc sắc của cộng đồng. Văn hóa Khmer vừa mang tính bản địa vừa gắn với mạng lưới giao lưu khu vực.',
         N'Theravada Buddhism, Robam and Dù kê theatre, the Ok Om Bok festival, and Khmer temples form the community''s distinctive cultural landscape. Khmer culture is both deeply local and regionally connected.',
         N'Không gian sống', N'Living Space',
         N'Làng Khmer Nam Bộ thường quần tụ quanh chùa và hệ thống kênh rạch, phản ánh sự gắn bó giữa tín ngưỡng, canh tác và cộng đồng. Không gian sống cũng là nơi bảo tồn nghề thủ công và nghệ thuật trình diễn.',
         N'Southern Khmer settlements often cluster around temples and canal networks, reflecting the close relationship between belief, farming, and community life. These spaces also preserve crafts and performing arts.',
         N'Đồng bằng sông Cửu Long', N'Mekong Delta', N'Hơn 1,3 triệu người', N'Over 1.3 million people', 2),
        ('CHAM',
         N'https://images.unsplash.com/photo-1565967511849-76a60a516170?auto=format&fit=crop&w=1600&q=80', N'Di sản kiến trúc Chăm ở miền Trung', N'Cham architectural heritage in central Vietnam',
         N'https://images.unsplash.com/photo-1500530855697-b586d89ba3ee?auto=format&fit=crop&w=900&q=80', N'Chân dung cộng đồng Chăm', N'Cham community portrait',
         N'https://images.unsplash.com/photo-1500530855697-b586d89ba3ee?auto=format&fit=crop&w=900&q=80', N'Sinh hoạt văn hóa của người Chăm', N'Cham cultural life portrait',
         N'https://images.unsplash.com/photo-1565967511849-76a60a516170?auto=format&fit=crop&w=1200&q=80', N'Tháp Chăm và di sản kiến trúc', N'Cham towers and architectural heritage',
         N'https://images.unsplash.com/photo-1500530855697-b586d89ba3ee?auto=format&fit=crop&w=1200&q=80', N'Nghệ thuật thủ công Chăm', N'Cham craft and performance traditions',
         N'https://images.unsplash.com/photo-1565967511849-76a60a516170?auto=format&fit=crop&w=1200&q=80', N'Không gian sinh sống của người Chăm', N'Cham living space',
         N'https://images.unsplash.com/photo-1500530855697-b586d89ba3ee?auto=format&fit=crop&w=900&q=80', N'Ảnh đại diện dân tộc Chăm', N'Cham card image',
         N'Người Chăm có bề dày lịch sử ở miền Trung, gắn với kiến trúc, tín ngưỡng và nghề dệt thủ công.',
         N'The Cham people have a long history in central Vietnam, associated with architecture, spirituality, and textile craftsmanship.',
         N'Giới thiệu về người Chăm', N'Introduction to the Cham people',
         N'Cộng đồng Chăm lưu giữ một hệ thống di sản kiến trúc, tín ngưỡng và nghề thủ công độc đáo tại miền Trung. Dệt thổ cẩm, nghi lễ truyền thống và các cụm tháp gạch là những dấu ấn văn hóa nổi bật.',
         N'The Cham community preserves a distinctive architectural, spiritual, and craft heritage in central Vietnam. Textile weaving, traditional rituals, and brick tower complexes are among its most visible cultural markers.',
         N'Lịch sử & nguồn gốc', N'History & Origins',
         N'Người Chăm gắn với chiều sâu lịch sử của miền Trung và di sản Champa, phản ánh qua các cụm tháp, thần thoại và nghi lễ cộng đồng. Dấu ấn lịch sử ấy vẫn hiện diện trong nhiều thực hành văn hóa đương đại.',
         N'The Cham are closely tied to the historical depth of central Vietnam and the legacy of Champa, reflected in towers, mythology, and community rituals. That history remains visible in present-day cultural practices.',
         N'Đặc trưng văn hóa', N'Cultural Identity',
         N'Nghề dệt thổ cẩm, lễ hội Katê, không gian tháp Chăm và tín ngưỡng dân gian tạo nên diện mạo văn hóa riêng của người Chăm. Đây là một trong những cộng đồng có bản sắc thị giác mạnh mẽ nhất trong văn hóa Việt Nam.',
         N'Textile weaving, the Katê festival, Cham tower spaces, and folk belief traditions define Cham cultural identity. It is one of the most visually distinctive communities in Vietnamese culture.',
         N'Không gian sống', N'Living Space',
         N'Các cộng đồng Chăm tại Ninh Thuận, Bình Thuận và lân cận vẫn duy trì nhiều hình thức cư trú, thủ công và nghi lễ gắn với cảnh quan khô hạn miền Trung. Không gian sống và tín ngưỡng gắn bó chặt chẽ với nhau.',
         N'Cham communities in Ninh Thuan, Binh Thuan, and neighboring areas maintain settlement patterns, crafts, and rituals tied to the dry landscape of central Vietnam. Living space and belief remain closely connected.',
         N'Miền Trung', N'Central Vietnam', N'Hơn 170 nghìn người', N'Over 170 thousand people', 3),
        ('DAO',
         N'https://images.unsplash.com/photo-1500530855697-b586d89ba3ee?auto=format&fit=crop&w=1600&q=80', N'Không gian núi rừng gắn với người Dao', N'Mountain landscapes associated with the Dao community',
         N'https://images.unsplash.com/photo-1515886657613-9f3515b0c78f?auto=format&fit=crop&w=900&q=80', N'Chân dung người Dao trong trang phục truyền thống', N'Dao portrait in traditional attire',
         N'https://images.unsplash.com/photo-1515886657613-9f3515b0c78f?auto=format&fit=crop&w=900&q=80', N'Sinh hoạt văn hóa của người Dao', N'Dao cultural life portrait',
         N'https://images.unsplash.com/photo-1521572267360-ee0c2909d518?auto=format&fit=crop&w=1200&q=80', N'Không gian văn hóa thêu dệt của người Dao', N'Dao embroidery and textile culture',
         N'https://images.unsplash.com/photo-1500534314209-a25ddb2bd429?auto=format&fit=crop&w=1200&q=80', N'Nghệ thuật nghi lễ của người Dao', N'Dao ritual and performance arts',
         N'https://images.unsplash.com/photo-1466721591366-2d5fba72006d?auto=format&fit=crop&w=1200&q=80', N'Không gian nhà ở của cộng đồng Dao', N'Dao living space',
         N'https://images.unsplash.com/photo-1515886657613-9f3515b0c78f?auto=format&fit=crop&w=900&q=80', N'Ảnh đại diện dân tộc Dao', N'Dao card image',
         N'Người Dao nổi bật với trang phục thêu tay, nghi lễ cấp sắc và tri thức dân gian về dược liệu.',
         N'The Dao people are known for embroidered attire, initiation rituals, and traditional herbal knowledge.',
         N'Giới thiệu về người Dao', N'Introduction to the Dao people',
         N'Người Dao sinh sống ở nhiều tỉnh miền núi phía Bắc, lưu giữ những giá trị văn hóa phong phú qua trang phục, nghi lễ vòng đời và tri thức bản địa. Nét đặc sắc của cộng đồng thể hiện rõ qua thêu thùa, lễ thức và sinh hoạt gắn với núi rừng.',
         N'The Dao live across northern mountain provinces and preserve rich cultural values through dress, life-cycle rituals, and indigenous knowledge. Their identity is especially visible in embroidery, ceremonies, and mountain life.',
         N'Lịch sử & nguồn gốc', N'History & Origins',
         N'Người Dao có lịch sử cư trú lâu dài tại các vùng núi phía Bắc, với nhiều nhóm địa phương khác nhau nhưng vẫn chia sẻ nhiều yếu tố văn hóa cốt lõi. Sự đa dạng đó tạo nên chiều sâu lịch sử và sự phong phú trong sinh hoạt cộng đồng.',
         N'The Dao have long lived in northern upland areas, with several local groups that still share core cultural traits. This diversity gives depth to their history and community life.',
         N'Đặc trưng văn hóa', N'Cultural Identity',
         N'Trang phục đỏ rực, nghi lễ cấp sắc và các bài thuốc dân gian là những dấu ấn rõ nét của người Dao. Bản sắc cộng đồng được truyền qua ký ức gia đình, lễ nghi và sinh hoạt bản làng.',
         N'Red ceremonial attire, initiation rituals, and herbal knowledge are among the Dao people''s strongest cultural markers. Their identity is passed down through family memory, ritual, and village life.',
         N'Không gian sống', N'Living Space',
         N'Không gian sống của người Dao gắn với nương rẫy, nhà ở vùng đồi núi và các sinh hoạt cộng đồng mang tính liên kết cao. Môi trường tự nhiên và tri thức dân gian luôn song hành trong đời sống thường nhật.',
         N'Dao living spaces are closely tied to hillside farming, mountain homes, and highly connected village life. Natural surroundings and traditional knowledge remain central to everyday living.',
         N'Miền núi phía Bắc', N'Northern Highlands', N'Hơn 890 nghìn người', N'Over 890 thousand people', 4),
        ('EDE',
         N'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=1600&q=80', N'Không gian Tây Nguyên gắn với người Ê Đê', N'Central Highlands landscape associated with the Ede people',
         N'https://images.unsplash.com/photo-1500534314209-a25ddb2bd429?auto=format&fit=crop&w=900&q=80', N'Chân dung cộng đồng Ê Đê', N'Ede community portrait',
         N'https://images.unsplash.com/photo-1500534314209-a25ddb2bd429?auto=format&fit=crop&w=900&q=80', N'Sinh hoạt văn hóa của người Ê Đê', N'Ede cultural life portrait',
         N'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=1200&q=80', N'Không gian cồng chiêng Tây Nguyên', N'Central Highlands gong culture scene',
         N'https://images.unsplash.com/photo-1500534314209-a25ddb2bd429?auto=format&fit=crop&w=1200&q=80', N'Nghệ thuật trình diễn của người Ê Đê', N'Ede performance culture',
         N'https://images.unsplash.com/photo-1466721591366-2d5fba72006d?auto=format&fit=crop&w=1200&q=80', N'Nhà dài của cộng đồng Ê Đê', N'Ede longhouse space',
         N'https://images.unsplash.com/photo-1500534314209-a25ddb2bd429?auto=format&fit=crop&w=900&q=80', N'Ảnh đại diện dân tộc Ê Đê', N'Ede card image',
         N'Cộng đồng Ê Đê gắn với không gian văn hóa cồng chiêng, nhà dài và đời sống Tây Nguyên.',
         N'The Ede community is associated with gong culture, longhouses, and Central Highlands life.',
         N'Giới thiệu về người Ê Đê', N'Introduction to the Ede people',
         N'Người Ê Đê là một trong những cộng đồng tiêu biểu của Tây Nguyên, nổi bật với văn hóa nhà dài, cồng chiêng và các thực hành cộng đồng đậm tính bản địa. Không gian sống và nghệ thuật truyền thống phản ánh rõ mối liên hệ với núi rừng cao nguyên.',
         N'The Ede are one of the emblematic peoples of the Central Highlands, known for longhouses, gong culture, and community practices rooted in local traditions. Their living space and arts reflect a deep connection to upland landscapes.',
         N'Lịch sử & nguồn gốc', N'History & Origins',
         N'Người Ê Đê cư trú lâu đời tại Tây Nguyên, nơi đời sống cộng đồng gắn với rừng, nương rẫy và không gian lễ nghi chung. Những tập quán này đã tạo nên chiều sâu lịch sử và cấu trúc xã hội đặc thù của cộng đồng.',
         N'The Ede have long lived in the Central Highlands, where community life is tied to forests, upland fields, and shared ritual spaces. These traditions shaped the group''s social structure and historical depth.',
         N'Đặc trưng văn hóa', N'Cultural Identity',
         N'Nhà dài, cồng chiêng, sử thi và sinh hoạt mẫu hệ là những dấu ấn nổi bật của người Ê Đê. Văn hóa cộng đồng được thể hiện qua nghi lễ, âm nhạc và sự gắn bó chặt chẽ giữa các thành viên trong buôn làng.',
         N'Longhouses, gong ensembles, epics, and matrilineal traditions are among the Ede people''s defining cultural features. Community identity is expressed through ritual, music, and close ties within the village.',
         N'Không gian sống', N'Living Space',
         N'Không gian sống của người Ê Đê gắn với buôn làng, nhà dài và nhịp sống nông nghiệp cao nguyên. Tổ chức cộng đồng và cảnh quan tự nhiên hòa vào nhau thành một chỉnh thể văn hóa đặc trưng.',
         N'Ede living space is organized around villages, longhouses, and the agricultural rhythm of the highlands. Community organization and the natural environment form a distinctive cultural whole.',
         N'Tây Nguyên', N'Central Highlands', N'Hơn 390 nghìn người', N'Over 390 thousand people', 5),
        ('BANA',
         N'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=1600&q=80', N'Không gian Tây Nguyên gắn với người Ba Na', N'Central Highlands landscape associated with the Ba Na people',
         N'https://images.unsplash.com/photo-1500534314209-a25ddb2bd429?auto=format&fit=crop&w=900&q=80', N'Chân dung cộng đồng Ba Na', N'Ba Na community portrait',
         N'https://images.unsplash.com/photo-1500534314209-a25ddb2bd429?auto=format&fit=crop&w=900&q=80', N'Sinh hoạt văn hóa của người Ba Na', N'Ba Na cultural life portrait',
         N'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=1200&q=80', N'Không gian cồng chiêng Tây Nguyên', N'Central Highlands gong culture scene',
         N'https://images.unsplash.com/photo-1500534314209-a25ddb2bd429?auto=format&fit=crop&w=1200&q=80', N'Nghệ thuật trình diễn của người Ba Na', N'Ba Na performance culture',
         N'https://images.unsplash.com/photo-1466721591366-2d5fba72006d?auto=format&fit=crop&w=1200&q=80', N'Nhà rông của cộng đồng Ba Na', N'Ba Na communal house',
         N'https://images.unsplash.com/photo-1500534314209-a25ddb2bd429?auto=format&fit=crop&w=900&q=80', N'Ảnh đại diện dân tộc Ba Na', N'Ba Na card image',
         N'Cộng đồng Ba Na nổi bật với nhà rông, cồng chiêng và đời sống buôn làng Tây Nguyên.',
         N'The Ba Na community is known for communal houses, gong culture, and Central Highlands village life.',
         N'Giới thiệu về người Ba Na', N'Introduction to the Ba Na people',
         N'Người Ba Na sinh sống chủ yếu ở Tây Nguyên, nơi cộng đồng gắn với nhà rông, sử thi và âm nhạc cồng chiêng. Những không gian này tạo nên bản sắc văn hóa mạnh mẽ và bền vững qua thời gian.',
         N'The Ba Na live mainly in the Central Highlands, where community life is shaped by communal houses, epics, and gong music. These spaces create a strong and enduring cultural identity.',
         N'Lịch sử & nguồn gốc', N'History & Origins',
         N'Người Ba Na có lịch sử cư trú lâu dài ở cao nguyên, gắn với canh tác nương rẫy và đời sống cộng đồng chặt chẽ. Qua nhiều thế hệ, họ vẫn giữ được những thực hành nghi lễ và tổ chức xã hội giàu tính bản địa.',
         N'The Ba Na have long inhabited the highlands, tied to upland farming and close-knit community life. Across generations, they have preserved rituals and social structures rooted in local traditions.',
         N'Đặc trưng văn hóa', N'Cultural Identity',
         N'Nhà rông, cồng chiêng, sử thi và lễ hội cộng đồng là những điểm nhấn của văn hóa Ba Na. Đây là những thực hành giúp gắn kết các thế hệ trong buôn làng.',
         N'Communal houses, gong ensembles, epics, and community festivals are key features of Ba Na culture. These practices connect generations within the village.',
         N'Không gian sống', N'Living Space',
         N'Không gian sống của người Ba Na trải rộng trên các buôn làng Tây Nguyên, với nhà rông giữ vai trò trung tâm sinh hoạt. Kiến trúc và cảnh quan địa phương hòa quyện thành một chỉnh thể văn hóa độc đáo.',
         N'Ba Na living space spans Central Highlands villages, with the communal house at the center of social life. Architecture and local landscape blend into a distinctive cultural whole.',
         N'Tây Nguyên', N'Central Highlands', N'Hơn 300 nghìn người', N'Over 300 thousand people', 6),
        ('MUONG',
         N'https://images.unsplash.com/photo-1605518215584-5ea1ebda40c0?auto=format&fit=crop&w=1600&q=80', N'Không gian miền núi gắn với người Mường', N'Mountain landscape associated with the Muong people',
         N'https://images.unsplash.com/photo-1515886657613-9f3515b0c78f?auto=format&fit=crop&w=900&q=80', N'Chân dung cộng đồng Mường', N'Muong community portrait',
         N'https://images.unsplash.com/photo-1515886657613-9f3515b0c78f?auto=format&fit=crop&w=900&q=80', N'Sinh hoạt văn hóa của người Mường', N'Muong cultural life portrait',
         N'https://images.unsplash.com/photo-1605518215584-5ea1ebda40c0?auto=format&fit=crop&w=1200&q=80', N'Không gian bản Mường', N'Muong village scene',
         N'https://images.unsplash.com/photo-1500534314209-a25ddb2bd429?auto=format&fit=crop&w=1200&q=80', N'Nghệ thuật trình diễn của người Mường', N'Muong performance culture',
         N'https://images.unsplash.com/photo-1466721591366-2d5fba72006d?auto=format&fit=crop&w=1200&q=80', N'Nhà sàn của cộng đồng Mường', N'Muong stilt house',
         N'https://images.unsplash.com/photo-1515886657613-9f3515b0c78f?auto=format&fit=crop&w=900&q=80', N'Ảnh đại diện dân tộc Mường', N'Muong card image',
         N'Cộng đồng Mường gắn với nhà sàn, sử thi và đời sống nông nghiệp miền núi phía Bắc.',
         N'The Muong community is associated with stilt houses, epics, and mountain agricultural life in northern Vietnam.',
         N'Giới thiệu về người Mường', N'Introduction to the Muong people',
         N'Người Mường cư trú chủ yếu ở trung du và miền núi Bắc Bộ, nơi văn hóa bản làng, nhà sàn và hệ thống sử thi được gìn giữ qua nhiều thế hệ. Bản sắc Mường hiện rõ trong lời mo, âm nhạc và sinh hoạt cộng đồng.',
         N'The Muong live mainly in the northern midlands and uplands, where village culture, stilt houses, and epic traditions are preserved across generations. Muong identity appears in ritual chants, music, and community life.',
         N'Lịch sử & nguồn gốc', N'History & Origins',
         N'Người Mường có lịch sử cư trú lâu đời ở vùng núi Bắc Bộ, gắn với canh tác ruộng nước và quan hệ cộng đồng bền chặt. Các lớp lịch sử được phản ánh qua sử thi, mo và hệ thống phong tục truyền đời.',
         N'The Muong have long lived in northern mountain areas, tied to wet-rice farming and strong communal bonds. Historical layers are reflected in epics, ritual chants, and inherited customs.',
         N'Đặc trưng văn hóa', N'Cultural Identity',
         N'Nhà sàn, mo Mường, cồng chiêng và trang phục truyền thống là những nét đặc trưng của cộng đồng. Những thực hành này thể hiện mối liên hệ giữa con người, gia đình và không gian bản làng.',
         N'Stilt houses, Muong ritual chants, gong culture, and traditional dress define the community. These practices express the relationship between people, family, and village space.',
         N'Không gian sống', N'Living Space',
         N'Không gian sống của người Mường gắn với thung lũng, chân núi và hệ thống ruộng nước ven suối. Cảnh quan và nếp sống cộng đồng hòa thành một bản sắc riêng biệt.',
         N'Muong living space is shaped by valleys, mountain foothills, and rice fields along streams. Landscape and community life blend into a distinctive identity.',
         N'Miền núi phía Bắc', N'Northern Highlands', N'Hơn 1,4 triệu người', N'Over 1.4 million people', 7),
        ('TAY',
         N'https://images.unsplash.com/photo-1605518215584-5ea1ebda40c0?auto=format&fit=crop&w=1600&q=80', N'Không gian bản làng vùng Đông Bắc gắn với người Tày', N'Northeastern village landscape associated with the Tay people',
         N'https://images.unsplash.com/photo-1515886657613-9f3515b0c78f?auto=format&fit=crop&w=900&q=80', N'Chân dung người Tày trong trang phục truyền thống', N'Tay portrait in traditional attire',
         N'https://images.unsplash.com/photo-1515886657613-9f3515b0c78f?auto=format&fit=crop&w=900&q=80', N'Sinh hoạt cộng đồng của người Tày', N'Tay community life portrait',
         N'https://images.unsplash.com/photo-1605518215584-5ea1ebda40c0?auto=format&fit=crop&w=1200&q=80', N'Không gian Then và bản làng người Tày', N'Then singing and Tay village culture',
         N'https://images.unsplash.com/photo-1500534314209-a25ddb2bd429?auto=format&fit=crop&w=1200&q=80', N'Nghệ thuật Then của người Tày', N'Tay Then performance scene',
         N'https://images.unsplash.com/photo-1466721591366-2d5fba72006d?auto=format&fit=crop&w=1200&q=80', N'Nhà sàn của cộng đồng Tày', N'Tay stilt house space',
         N'https://images.unsplash.com/photo-1515886657613-9f3515b0c78f?auto=format&fit=crop&w=900&q=80', N'Ảnh đại diện dân tộc Tày', N'Tay card image',
         N'Người Tày là một trong những cộng đồng lớn ở miền núi phía Bắc, nổi bật với hát Then, đàn tính và nếp sống bản làng ven suối.',
         N'The Tay are one of the largest northern ethnic communities, known for Then singing, the tinh lute, and village life by streams and valleys.',
         N'Giới thiệu về người Tày', N'Introduction to the Tay people',
         N'Người Tày cư trú chủ yếu ở vùng Đông Bắc và trung du miền núi phía Bắc, nơi đời sống gắn với nhà sàn, ruộng nước và sinh hoạt cộng đồng. Bản sắc Tày hiện rõ qua hát Then, đàn tính và các lễ tục gắn với nông nghiệp.',
         N'The Tay live mainly in the northeastern and midland uplands of northern Vietnam, where life is tied to stilt houses, wet-rice farming, and village traditions. Their identity is strongly expressed through Then singing, the tinh lute, and agrarian rituals.',
         N'Lịch sử & nguồn gốc', N'History & Origins',
         N'Người Tày có lịch sử cư trú lâu đời ở vùng núi phía Bắc, góp phần tạo nên diện mạo văn hóa bản làng vùng Đông Bắc. Qua nhiều thế hệ, cộng đồng vẫn duy trì ngôn ngữ, nghệ thuật và các nghi lễ mang tính bản địa sâu sắc.',
         N'The Tay have a long history in northern upland areas and helped shape the cultural landscape of northeastern village life. Across generations, they have maintained language, arts, and deeply local rituals.',
         N'Đặc trưng văn hóa', N'Cultural Identity',
         N'Hát Then, đàn tính, lễ hội Lồng Tồng và kiến trúc nhà sàn là những yếu tố nổi bật trong đời sống người Tày. Không gian cộng đồng và thiên nhiên luôn hiện diện trong nhạc điệu, nghi lễ và nếp sống thường ngày.',
         N'Then singing, the tinh lute, Long Tong festivals, and stilt-house architecture are central to Tay cultural identity. Community space and the natural environment are reflected in their music, rituals, and everyday life.',
         N'Không gian sống', N'Living Space',
         N'Người Tày sống tập trung trong các bản làng ven suối, thung lũng và ruộng nước, với nhà sàn giữ vai trò trung tâm trong đời sống gia đình và cộng đồng.',
         N'Tay communities live in villages near streams, valleys, and rice fields, with stilt houses at the center of family and communal life.',
         N'Vùng Đông Bắc và trung du miền núi phía Bắc', N'Northeastern and northern midland uplands', N'Hơn 1,8 triệu người', N'Over 1.8 million people', 6),
        ('KINH',
         N'https://images.unsplash.com/photo-1543783230-dc081f2163b2?auto=format&fit=crop&w=1600&q=80', N'Không gian đời sống của người Kinh', N'Kinh cultural life scene',
         N'https://images.unsplash.com/photo-1604908812752-60b7c7d1d7ab?auto=format&fit=crop&w=900&q=80', N'Chân dung đời sống văn hóa người Kinh', N'Kinh cultural portrait',
         N'https://images.unsplash.com/photo-1604908812752-60b7c7d1d7ab?auto=format&fit=crop&w=900&q=80', N'Sinh hoạt cộng đồng của người Kinh', N'Kinh community life portrait',
         N'https://images.unsplash.com/photo-1543783230-dc081f2163b2?auto=format&fit=crop&w=1200&q=80', N'Không gian văn hóa người Kinh', N'Kinh cultural setting',
         N'https://images.unsplash.com/photo-1517486808906-6ca8b3f04846?auto=format&fit=crop&w=1200&q=80', N'Nghệ thuật trình diễn gắn với người Kinh', N'Kinh performance arts scene',
         N'https://images.unsplash.com/photo-1466721591366-2d5fba72006d?auto=format&fit=crop&w=1200&q=80', N'Không gian làng quê người Kinh', N'Kinh village space',
         N'https://images.unsplash.com/photo-1604908812752-60b7c7d1d7ab?auto=format&fit=crop&w=900&q=80', N'Ảnh đại diện dân tộc Kinh', N'Kinh card image',
         N'Người Kinh là cộng đồng chiếm đa số ở Việt Nam, có ảnh hưởng rộng trong đời sống văn hóa quốc gia.',
         N'The Kinh are the majority population in Vietnam and have broad influence on national cultural life.',
         N'Giới thiệu về người Kinh', N'Introduction to the Kinh people',
         N'Người Kinh phân bố rộng khắp cả nước và đóng vai trò trung tâm trong nhiều thực hành văn hóa, tín ngưỡng và lễ tục phổ biến của Việt Nam. Đời sống người Kinh phản ánh mạnh mẽ sự giao thoa giữa làng quê, đô thị, truyền thống và hiện đại.',
         N'The Kinh are spread throughout Vietnam and play a central role in many of the country''s widespread cultural practices, beliefs, and rituals. Kinh life reflects the interplay between village, city, tradition, and modernity.',
         N'Lịch sử & nguồn gốc', N'History & Origins',
         N'Người Kinh hình thành và phát triển cùng các nền văn minh nông nghiệp lúa nước tại đồng bằng châu thổ. Dấu ấn lịch sử ấy vẫn còn hiện diện trong kiến trúc làng, tín ngưỡng tổ tiên và nếp sống cộng đồng.',
         N'The Kinh developed alongside wet-rice civilizations in delta regions. That history remains visible in village architecture, ancestor worship, and communal life.',
         N'Đặc trưng văn hóa', N'Cultural Identity',
         N'Tín ngưỡng thờ cúng tổ tiên, lễ Tết, áo dài, ẩm thực vùng miền và nghệ thuật dân gian là những yếu tố quen thuộc của văn hóa Kinh. Đây cũng là lớp văn hóa có mức độ lan tỏa rộng trong đời sống xã hội Việt Nam.',
         N'Ancestor worship, Tet, Ao Dai, regional cuisine, and folk arts are among the familiar markers of Kinh culture. It is also the cultural layer with wide social influence across Vietnam.',
         N'Không gian sống', N'Living Space',
         N'Không gian sống của người Kinh trải rộng từ làng quê đồng bằng đến đô thị lớn, phản ánh khả năng thích ứng linh hoạt với nhiều bối cảnh kinh tế - xã hội khác nhau.',
         N'Kinh living space ranges from delta villages to large cities, reflecting strong adaptability to many social and economic settings.',
         N'Phân bố khắp cả nước', N'Nationwide distribution', N'Hơn 82 triệu người', N'Over 82 million people', 7)
    ) AS v(MaDanToc,
        HeroBackgroundImageUrl, HeroBackgroundAltVI, HeroBackgroundAltEN,
        HeroForegroundImageUrl, HeroForegroundAltVI, HeroForegroundAltEN,
        IntroImageUrl, IntroImageAltVI, IntroImageAltEN,
        FeatureHighlightImageUrl, FeatureHighlightAltVI, FeatureHighlightAltEN,
        MusicImageUrl, MusicImageAltVI, MusicImageAltEN,
        ArchitectureImageUrl, ArchitectureImageAltVI, ArchitectureImageAltEN,
        CardImageUrl, CardImageAltVI, CardImageAltEN,
        HeroSubtitleVI, HeroSubtitleEN,
        OverviewTitleVI, OverviewTitleEN, OverviewBodyVI, OverviewBodyEN,
        HistoryTitleVI, HistoryTitleEN, HistoryBodyVI, HistoryBodyEN,
        CultureTitleVI, CultureTitleEN, CultureBodyVI, CultureBodyEN,
        ArchitectureTitleVI, ArchitectureTitleEN, ArchitectureBodyVI, ArchitectureBodyEN,
        PrimaryRegionLabelVI, PrimaryRegionLabelEN, PopulationLabelVI, PopulationLabelEN, DisplayOrder)
      ON v.MaDanToc = dt.MaDanToc
) AS source
ON target.DanTocID = source.DanTocID
WHEN MATCHED THEN
    UPDATE SET
        HeroBackgroundImageUrl = source.HeroBackgroundImageUrl,
        HeroBackgroundAltVI = source.HeroBackgroundAltVI,
        HeroBackgroundAltEN = source.HeroBackgroundAltEN,
        HeroForegroundImageUrl = source.HeroForegroundImageUrl,
        HeroForegroundAltVI = source.HeroForegroundAltVI,
        HeroForegroundAltEN = source.HeroForegroundAltEN,
        IntroImageUrl = source.IntroImageUrl,
        IntroImageAltVI = source.IntroImageAltVI,
        IntroImageAltEN = source.IntroImageAltEN,
        FeatureHighlightImageUrl = source.FeatureHighlightImageUrl,
        FeatureHighlightAltVI = source.FeatureHighlightAltVI,
        FeatureHighlightAltEN = source.FeatureHighlightAltEN,
        MusicImageUrl = source.MusicImageUrl,
        MusicImageAltVI = source.MusicImageAltVI,
        MusicImageAltEN = source.MusicImageAltEN,
        ArchitectureImageUrl = source.ArchitectureImageUrl,
        ArchitectureImageAltVI = source.ArchitectureImageAltVI,
        ArchitectureImageAltEN = source.ArchitectureImageAltEN,
        CardImageUrl = source.CardImageUrl,
        CardImageAltVI = source.CardImageAltVI,
        CardImageAltEN = source.CardImageAltEN,
        HeroSubtitleVI = source.HeroSubtitleVI,
        HeroSubtitleEN = source.HeroSubtitleEN,
        OverviewTitleVI = source.OverviewTitleVI,
        OverviewTitleEN = source.OverviewTitleEN,
        OverviewBodyVI = source.OverviewBodyVI,
        OverviewBodyEN = source.OverviewBodyEN,
        HistoryTitleVI = source.HistoryTitleVI,
        HistoryTitleEN = source.HistoryTitleEN,
        HistoryBodyVI = source.HistoryBodyVI,
        HistoryBodyEN = source.HistoryBodyEN,
        CultureTitleVI = source.CultureTitleVI,
        CultureTitleEN = source.CultureTitleEN,
        CultureBodyVI = source.CultureBodyVI,
        CultureBodyEN = source.CultureBodyEN,
        ArchitectureTitleVI = source.ArchitectureTitleVI,
        ArchitectureTitleEN = source.ArchitectureTitleEN,
        ArchitectureBodyVI = source.ArchitectureBodyVI,
        ArchitectureBodyEN = source.ArchitectureBodyEN,
        PrimaryRegionLabelVI = source.PrimaryRegionLabelVI,
        PrimaryRegionLabelEN = source.PrimaryRegionLabelEN,
        PopulationLabelVI = source.PopulationLabelVI,
        PopulationLabelEN = source.PopulationLabelEN,
        DisplayOrder = source.DisplayOrder,
        HoatDong = 1,
        NgayCapNhat = SYSUTCDATETIME()
WHEN NOT MATCHED THEN
    INSERT (
        DanTocID,
        HeroBackgroundImageUrl, HeroBackgroundAltVI, HeroBackgroundAltEN,
        HeroForegroundImageUrl, HeroForegroundAltVI, HeroForegroundAltEN,
        IntroImageUrl, IntroImageAltVI, IntroImageAltEN,
        FeatureHighlightImageUrl, FeatureHighlightAltVI, FeatureHighlightAltEN,
        MusicImageUrl, MusicImageAltVI, MusicImageAltEN,
        ArchitectureImageUrl, ArchitectureImageAltVI, ArchitectureImageAltEN,
        CardImageUrl, CardImageAltVI, CardImageAltEN,
        HeroSubtitleVI, HeroSubtitleEN,
        OverviewTitleVI, OverviewTitleEN, OverviewBodyVI, OverviewBodyEN,
        HistoryTitleVI, HistoryTitleEN, HistoryBodyVI, HistoryBodyEN,
        CultureTitleVI, CultureTitleEN, CultureBodyVI, CultureBodyEN,
        ArchitectureTitleVI, ArchitectureTitleEN, ArchitectureBodyVI, ArchitectureBodyEN,
        PrimaryRegionLabelVI, PrimaryRegionLabelEN, PopulationLabelVI, PopulationLabelEN,
        DisplayOrder, HoatDong
    )
    VALUES (
        source.DanTocID,
        source.HeroBackgroundImageUrl, source.HeroBackgroundAltVI, source.HeroBackgroundAltEN,
        source.HeroForegroundImageUrl, source.HeroForegroundAltVI, source.HeroForegroundAltEN,
        source.IntroImageUrl, source.IntroImageAltVI, source.IntroImageAltEN,
        source.FeatureHighlightImageUrl, source.FeatureHighlightAltVI, source.FeatureHighlightAltEN,
        source.MusicImageUrl, source.MusicImageAltVI, source.MusicImageAltEN,
        source.ArchitectureImageUrl, source.ArchitectureImageAltVI, source.ArchitectureImageAltEN,
        source.CardImageUrl, source.CardImageAltVI, source.CardImageAltEN,
        source.HeroSubtitleVI, source.HeroSubtitleEN,
        source.OverviewTitleVI, source.OverviewTitleEN, source.OverviewBodyVI, source.OverviewBodyEN,
        source.HistoryTitleVI, source.HistoryTitleEN, source.HistoryBodyVI, source.HistoryBodyEN,
        source.CultureTitleVI, source.CultureTitleEN, source.CultureBodyVI, source.CultureBodyEN,
        source.ArchitectureTitleVI, source.ArchitectureTitleEN, source.ArchitectureBodyVI, source.ArchitectureBodyEN,
        source.PrimaryRegionLabelVI, source.PrimaryRegionLabelEN, source.PopulationLabelVI, source.PopulationLabelEN,
        source.DisplayOrder, 1
    );
GO

INSERT INTO dbo.DanTocSectionItem (DanTocID, LoaiSection, TieuDeVI, TieuDeEN, MoTaVI, MoTaEN, ImageUrl, ImageAltVI, ImageAltEN, LayoutSize, TagVI, TagEN, ThuTuHienThi, HoatDong)
SELECT dt.DanTocID, x.LoaiSection, x.TieuDeVI, x.TieuDeEN, x.MoTaVI, x.MoTaEN, x.ImageUrl, x.ImageAltVI, x.ImageAltEN, x.LayoutSize, x.TagVI, x.TagEN, x.ThuTuHienThi, 1
FROM dbo.DanToc dt
JOIN (VALUES
    ('HMONG','TEXTILES',N'Hoa văn sáp ong',N'Beeswax Batik Motifs',N'Kỹ thuật vẽ sáp ong tạo nên những hoa văn đậm tính biểu tượng trên nền vải lanh.',N'Beeswax batik creates symbolic motifs on handwoven linen.',N'https://images.unsplash.com/photo-1521572267360-ee0c2909d518?auto=format&fit=crop&w=800&q=80',N'Hoa văn sáp ong H''Mông',N'Hmong beeswax batik motifs','square',NULL,NULL,1),
    ('HMONG','TEXTILES',N'Nghề dệt lanh',N'Linen Weaving',N'Nghề dệt lanh là nền tảng tạo nên trang phục truyền thống của người H''Mông.',N'Linen weaving is central to Hmong traditional dress.',N'https://images.unsplash.com/photo-1483985988355-763728e1935b?auto=format&fit=crop&w=800&q=80',N'Dệt lanh truyền thống của người H''Mông',N'Hmong traditional linen weaving','square',NULL,NULL,2),
    ('HMONG','TEXTILES',N'Trang phục lễ hội',N'Festival Attire',N'Trang phục rực rỡ xuất hiện trong chợ phiên và lễ hội, phản ánh bản sắc cộng đồng.',N'Festival attire reflects communal identity through color and embroidery.',N'https://images.unsplash.com/photo-1515886657613-9f3515b0c78f?auto=format&fit=crop&w=800&q=80',N'Trang phục lễ hội của người H''Mông',N'Hmong festival attire','square',NULL,NULL,3),
    ('HMONG','FESTIVALS',N'Lễ hội Gầu Tào',N'Gau Tao Festival',N'Lễ hội cầu phúc, cầu sức khỏe và sinh sôi của cộng đồng H''Mông.',N'A festival praying for well-being, health, and renewal in Hmong communities.',N'https://images.unsplash.com/photo-1517457373958-b7bdd4587205?auto=format&fit=crop&w=900&q=80',N'Lễ hội Gầu Tào của người H''Mông',N'Hmong Gau Tao festival','small',N'Di sản',N'Heritage',4),
    ('HMONG','FESTIVALS',N'Chợ tình Khâu Vai',N'Khau Vai Love Market',N'Không gian giao lưu văn hóa nổi tiếng của đồng bào vùng cao.',N'A well-known cultural gathering space in the northern highlands.',N'https://images.unsplash.com/photo-1524492449090-c4d22f9bb7a4?auto=format&fit=crop&w=900&q=80',N'Chợ tình vùng cao',N'Highland love market','small',N'Văn hóa',N'Culture',5),
    ('HMONG','FESTIVALS',N'Tết truyền thống người H''Mông',N'Hmong New Year',N'Dịp đoàn tụ và tái khẳng định bản sắc cộng đồng vùng cao.',N'A time of reunion and renewal of community identity.',N'https://images.unsplash.com/photo-1513151233558-d860c5398176?auto=format&fit=crop&w=900&q=80',N'Tết của cộng đồng H''Mông',N'Hmong New Year celebration','small',N'Nghi lễ',N'Ritual',6),
    ('HMONG','CUISINE',N'Thắng cố',N'Thang Co',N'Món ăn đặc trưng của vùng cao, thường xuất hiện trong chợ phiên và lễ hội.',N'A signature highland dish often served at markets and festivals.',N'https://images.unsplash.com/photo-1547592180-85f173990554?auto=format&fit=crop&w=800&q=80',N'Món thắng cố vùng cao',N'Thang Co dish','portrait',NULL,NULL,7),
    ('HMONG','CUISINE',N'Mèn mén',N'Men Men',N'Món ăn làm từ ngô xay, gắn với đời sống thường nhật của đồng bào H''Mông.',N'A corn-based staple tied to everyday Hmong life.',N'https://images.unsplash.com/photo-1504754524776-8f4f37790ca0?auto=format&fit=crop&w=800&q=80',N'Món mèn mén',N'Men Men dish','portrait',NULL,NULL,8),
    ('HMONG','CUISINE',N'Rượu ngô',N'Corn Wine',N'Đồ uống quen thuộc trong các cuộc gặp cộng đồng và nghi lễ.',N'A familiar drink at communal gatherings and rituals.',N'https://images.unsplash.com/photo-1514362545857-3bc16c4c7d1b?auto=format&fit=crop&w=800&q=80',N'Rượu ngô của người H''Mông',N'Hmong corn wine','portrait',NULL,NULL,9),
    ('HMONG','ARTS',N'Tiếng khèn',N'Khen Flute',N'Tiếng khèn là biểu tượng âm nhạc và đời sống tinh thần của người H''Mông.',N'The khen flute symbolizes Hmong music and spiritual life.',N'https://images.unsplash.com/photo-1500534314209-a25ddb2bd429?auto=format&fit=crop&w=900&q=80',N'Nghệ thuật khèn H''Mông',N'Hmong khen performance','small',NULL,NULL,10),
    ('HMONG','GALLERY',N'Chợ phiên vùng cao',N'Highland Market',N'Khoảnh khắc sinh hoạt cộng đồng tại chợ phiên vùng cao.',N'A community scene at a highland market.',N'https://images.unsplash.com/photo-1518546305927-5a555bb7020d?auto=format&fit=crop&w=1200&q=80',N'Chợ phiên vùng cao',N'Highland market','large',NULL,NULL,11),
    ('HMONG','GALLERY',N'Trang phục truyền thống',N'Traditional Dress',N'Chi tiết trang phục thêu tay đầy màu sắc.',N'Colorful details of embroidered traditional clothing.',N'https://images.unsplash.com/photo-1515886657613-9f3515b0c78f?auto=format&fit=crop&w=800&q=80',N'Trang phục truyền thống H''Mông',N'Hmong traditional attire','small',NULL,NULL,12),
    ('HMONG','GALLERY',N'Không gian núi đá',N'Karst Highlands',N'Cảnh quan núi đá gắn với đời sống người H''Mông.',N'Karst landscapes associated with Hmong life.',N'https://images.unsplash.com/photo-1500530855697-b586d89ba3ee?auto=format&fit=crop&w=900&q=80',N'Không gian núi đá vùng cao',N'Karst highlands','tall',NULL,NULL,13),
    ('HMONG','GALLERY',N'Bàn tay dệt vải',N'Hands at Work',N'Hình ảnh lao động thủ công truyền thống.',N'An image of traditional manual craftwork.',N'https://images.unsplash.com/photo-1483985988355-763728e1935b?auto=format&fit=crop&w=800&q=80',N'Bàn tay dệt vải',N'Hands weaving','small',NULL,NULL,14),
    ('HMONG','GALLERY',N'Nhà ở vùng cao',N'Mountain Home',N'Không gian cư trú gắn với cảnh quan vùng cao.',N'A dwelling integrated with the mountain landscape.',N'https://images.unsplash.com/photo-1466721591366-2d5fba72006d?auto=format&fit=crop&w=1200&q=80',N'Nhà ở vùng cao',N'Mountain home','wide',NULL,NULL,15),
    ('HMONG','GALLERY',N'Ẩm thực bản địa',N'Local Cuisine',N'Những món ăn dân tộc trong đời sống thường nhật.',N'Ethnic dishes in everyday life.',N'https://images.unsplash.com/photo-1547592180-85f173990554?auto=format&fit=crop&w=800&q=80',N'Ẩm thực bản địa',N'Local cuisine','small',NULL,NULL,16),
    ('HMONG','FEATURES',N'Nghệ thuật thổ cẩm H''Mông',N'Hmong Textile Art',N'Những lớp hoa văn và màu sắc tạo nên diện mạo thị giác đặc sắc của cộng đồng.',N'Patterns and colors form a visually rich Hmong identity.',N'https://images.unsplash.com/photo-1521572267360-ee0c2909d518?auto=format&fit=crop&w=900&q=80',N'Nghệ thuật thổ cẩm H''Mông',N'Hmong textile art','small',N'Nổi bật',N'Featured',17),
    ('HMONG','STORIES',N'Chuyện kể từ chợ phiên',N'Stories from the Highland Market',N'Nhịp sống vùng cao hiện lên qua mỗi phiên chợ và cuộc gặp gỡ cộng đồng.',N'Highland life unfolds through market gatherings and shared community moments.',N'https://images.unsplash.com/photo-1518546305927-5a555bb7020d?auto=format&fit=crop&w=900&q=80',N'Chuyện kể từ chợ phiên H''Mông',N'Stories from the Hmong market','small',NULL,NULL,18),
    ('KHMER','FEATURES',N'Không gian chùa Khmer',N'Khmer Temple Space',N'Kiến trúc chùa Khmer là điểm neo quan trọng của đời sống tinh thần và cộng đồng.',N'Khmer temple architecture anchors both spiritual and communal life.',N'https://images.unsplash.com/photo-1528127269322-539801943592?auto=format&fit=crop&w=900&q=80',N'Không gian chùa Khmer',N'Khmer temple space','small',N'Nổi bật',N'Featured',19),
    ('KHMER','STORIES',N'Âm vang lễ hội Oóc Om Bóc',N'Voices of Ok Om Bok',N'Lễ hội truyền thống phản ánh nhịp sống cộng đồng và tín ngưỡng Nam Bộ.',N'A traditional festival reflecting communal rhythms and beliefs in the south.',N'https://images.unsplash.com/photo-1517486808906-6ca8b3f04846?auto=format&fit=crop&w=900&q=80',N'Lễ hội Oóc Om Bóc',N'Ok Om Bok festival','small',NULL,NULL,20),
    ('KHMER','GALLERY',N'Chùa Khmer',N'Khmer Temple',N'Kiến trúc tôn giáo đặc trưng của cộng đồng Khmer.',N'A characteristic religious architecture of the Khmer community.',N'https://images.unsplash.com/photo-1528127269322-539801943592?auto=format&fit=crop&w=1200&q=80',N'Chùa Khmer Nam Bộ',N'Southern Khmer temple','large',NULL,NULL,21),
    ('CHAM','FEATURES',N'Di sản tháp Chăm',N'Cham Tower Heritage',N'Không gian tháp Chăm ghi dấu chiều sâu lịch sử và tín ngưỡng miền Trung.',N'Cham towers embody the historical and spiritual depth of central Vietnam.',N'https://images.unsplash.com/photo-1565967511849-76a60a516170?auto=format&fit=crop&w=900&q=80',N'Di sản tháp Chăm',N'Cham tower heritage','small',N'Di sản',N'Heritage',22),
    ('CHAM','STORIES',N'Nghề dệt và ký ức cộng đồng',N'Weaving and Community Memory',N'Những câu chuyện văn hóa được lưu giữ qua khung cửi và nghi lễ truyền thống.',N'Cultural memory is preserved through weaving and ritual practice.',N'https://images.unsplash.com/photo-1500530855697-b586d89ba3ee?auto=format&fit=crop&w=900&q=80',N'Nghề dệt Chăm',N'Cham weaving tradition','small',NULL,NULL,23),
    ('CHAM','GALLERY',N'Kiến trúc Chăm',N'Cham Architecture',N'Dấu ấn kiến trúc đặc sắc của cộng đồng Chăm.',N'A distinctive architectural mark of the Cham community.',N'https://images.unsplash.com/photo-1565967511849-76a60a516170?auto=format&fit=crop&w=1200&q=80',N'Kiến trúc Chăm',N'Cham architecture','large',NULL,NULL,24),
    ('DAO','FEATURES',N'Nghi lễ cấp sắc',N'Initiation Ritual',N'Nghi lễ cấp sắc là dấu mốc quan trọng trong đời sống tinh thần của người Dao.',N'The initiation ritual is a major spiritual milestone in Dao cultural life.',N'https://images.unsplash.com/photo-1515886657613-9f3515b0c78f?auto=format&fit=crop&w=900&q=80',N'Nghi lễ cấp sắc của người Dao',N'Dao initiation ritual','small',N'Nổi bật',N'Featured',25),
    ('DAO','STORIES',N'Chuyện thuốc nam nơi vùng cao',N'Herbal Knowledge in the Highlands',N'Tri thức dân gian của người Dao gắn chặt với cây rừng và chữa bệnh cộng đồng.',N'Dao indigenous knowledge links forest plants to community healing traditions.',N'https://images.unsplash.com/photo-1471193945509-9ad0617afabf?auto=format&fit=crop&w=900&q=80',N'Tri thức thuốc nam của người Dao',N'Dao herbal knowledge','small',NULL,NULL,26),
    ('DAO','GALLERY',N'Trang phục Dao đỏ',N'Red Dao Attire',N'Trang phục thêu tay là dấu ấn thị giác nổi bật của nhiều nhóm Dao.',N'Hand-embroidered attire is a strong visual marker of many Dao groups.',N'https://images.unsplash.com/photo-1515886657613-9f3515b0c78f?auto=format&fit=crop&w=1200&q=80',N'Trang phục Dao đỏ',N'Red Dao attire','large',NULL,NULL,27),
    ('EDE','FEATURES',N'Không gian cồng chiêng',N'Gong Culture',N'Cồng chiêng là biểu tượng âm nhạc và nghi lễ của cộng đồng Ê Đê.',N'Gong ensembles symbolize music and ritual in Ede community life.',N'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=900&q=80',N'Không gian cồng chiêng Tây Nguyên',N'Central Highlands gong culture','small',N'Nổi bật',N'Featured',28),
    ('EDE','STORIES',N'Nhà dài và đời sống buôn làng',N'Longhouse and Village Life',N'Nhà dài là trung tâm của nhịp sống, ký ức và tổ chức cộng đồng Ê Đê.',N'The longhouse sits at the center of memory, daily rhythm, and village organization.',N'https://images.unsplash.com/photo-1466721591366-2d5fba72006d?auto=format&fit=crop&w=900&q=80',N'Nhà dài Ê Đê',N'Ede longhouse','small',NULL,NULL,29),
    ('EDE','GALLERY',N'Nhà dài Tây Nguyên',N'Central Highlands Longhouse',N'Không gian nhà dài phản ánh rõ tổ chức buôn làng của người Ê Đê.',N'The longhouse clearly reflects Ede village organization.',N'https://images.unsplash.com/photo-1466721591366-2d5fba72006d?auto=format&fit=crop&w=1200&q=80',N'Nhà dài Tây Nguyên',N'Central Highlands longhouse','large',NULL,NULL,30),
    ('TAY','FEATURES',N'Điệu Then và đàn tính',N'Then Singing and Tinh Lute',N'Điệu Then và tiếng đàn tính là hồn cốt trong sinh hoạt văn hóa người Tày.',N'Then singing and the tinh lute are central to Tay cultural expression.',N'https://images.unsplash.com/photo-1605518215584-5ea1ebda40c0?auto=format&fit=crop&w=900&q=80',N'Điệu Then của người Tày',N'Tay Then singing','small',N'Nổi bật',N'Featured',31),
    ('TAY','STORIES',N'Nhịp sống bản làng ven suối',N'Life in Tay Villages',N'Những bản làng người Tày gắn với ruộng nước, suối nguồn và nhịp sống cộng đồng bền chặt.',N'Tay villages are shaped by rice fields, streams, and close-knit communal life.',N'https://images.unsplash.com/photo-1605518215584-5ea1ebda40c0?auto=format&fit=crop&w=900&q=80',N'Bản làng người Tày',N'Tay village life','small',NULL,NULL,32),
    ('TAY','GALLERY',N'Nhà sàn người Tày',N'Tay Stilt House',N'Kiến trúc nhà sàn là dấu ấn nổi bật trong không gian sống của người Tày.',N'Stilt-house architecture is a defining visual feature of Tay living space.',N'https://images.unsplash.com/photo-1466721591366-2d5fba72006d?auto=format&fit=crop&w=1200&q=80',N'Nhà sàn người Tày',N'Tay stilt house','large',NULL,NULL,33),
    ('KINH','FEATURES',N'Tín ngưỡng thờ cúng tổ tiên',N'Ancestor Worship',N'Một trong những thực hành văn hóa phổ biến và bền vững nhất của người Kinh.',N'One of the most enduring and widespread practices in Kinh culture.',N'https://images.unsplash.com/photo-1543783230-dc081f2163b2?auto=format&fit=crop&w=900&q=80',N'Tín ngưỡng thờ cúng tổ tiên của người Kinh',N'Kinh ancestor worship','small',N'Nổi bật',N'Featured',34),
    ('KINH','STORIES',N'Nhịp sống từ làng quê đến đô thị',N'From Village to City',N'Đời sống người Kinh trải dài từ làng quê đồng bằng đến không gian đô thị hiện đại.',N'Kinh life spans from delta villages to modern urban spaces.',N'https://images.unsplash.com/photo-1543783230-dc081f2163b2?auto=format&fit=crop&w=900&q=80',N'Đời sống người Kinh',N'Kinh daily life','small',NULL,NULL,35),
    ('KINH','GALLERY',N'Không gian làng quê Bắc Bộ',N'Northern Village Scene',N'Khung cảnh làng quê phản ánh sâu sắc đời sống truyền thống của người Kinh.',N'Village scenery strongly reflects traditional Kinh life.',N'https://images.unsplash.com/photo-1543783230-dc081f2163b2?auto=format&fit=crop&w=1200&q=80',N'Không gian làng quê người Kinh',N'Kinh village scene','large',NULL,NULL,36)
) AS x(MaDanToc, LoaiSection, TieuDeVI, TieuDeEN, MoTaVI, MoTaEN, ImageUrl, ImageAltVI, ImageAltEN, LayoutSize, TagVI, TagEN, ThuTuHienThi)
  ON dt.MaDanToc = x.MaDanToc
WHERE NOT EXISTS (
    SELECT 1
    FROM dbo.DanTocSectionItem existing
    WHERE existing.DanTocID = dt.DanTocID
      AND existing.LoaiSection = x.LoaiSection
      AND ISNULL(existing.TieuDeVI, N'') = ISNULL(x.TieuDeVI, N'')
);

INSERT INTO dbo.DanTocProfile (
    DanTocID,
    HeroBackgroundImageUrl, HeroBackgroundAltVI, HeroBackgroundAltEN,
    HeroForegroundImageUrl, HeroForegroundAltVI, HeroForegroundAltEN,
    IntroImageUrl, IntroImageAltVI, IntroImageAltEN,
    FeatureHighlightImageUrl, FeatureHighlightAltVI, FeatureHighlightAltEN,
    MusicImageUrl, MusicImageAltVI, MusicImageAltEN,
    ArchitectureImageUrl, ArchitectureImageAltVI, ArchitectureImageAltEN,
    CardImageUrl, CardImageAltVI, CardImageAltEN,
    HeroSubtitleVI, HeroSubtitleEN,
    OverviewTitleVI, OverviewTitleEN, OverviewBodyVI, OverviewBodyEN,
    HistoryTitleVI, HistoryTitleEN, HistoryBodyVI, HistoryBodyEN,
    CultureTitleVI, CultureTitleEN, CultureBodyVI, CultureBodyEN,
    ArchitectureTitleVI, ArchitectureTitleEN, ArchitectureBodyVI, ArchitectureBodyEN,
    PrimaryRegionLabelVI, PrimaryRegionLabelEN, PopulationLabelVI, PopulationLabelEN,
    DisplayOrder, HoatDong
)
SELECT
    dt.DanTocID,
    v.HeroBackgroundImageUrl, v.HeroBackgroundAltVI, v.HeroBackgroundAltEN,
    v.HeroForegroundImageUrl, v.HeroForegroundAltVI, v.HeroForegroundAltEN,
    v.IntroImageUrl, v.IntroImageAltVI, v.IntroImageAltEN,
    v.FeatureHighlightImageUrl, v.FeatureHighlightAltVI, v.FeatureHighlightAltEN,
    v.MusicImageUrl, v.MusicImageAltVI, v.MusicImageAltEN,
    v.ArchitectureImageUrl, v.ArchitectureImageAltVI, v.ArchitectureImageAltEN,
    v.CardImageUrl, v.CardImageAltVI, v.CardImageAltEN,
    v.HeroSubtitleVI, v.HeroSubtitleEN,
    v.OverviewTitleVI, v.OverviewTitleEN, v.OverviewBodyVI, v.OverviewBodyEN,
    v.HistoryTitleVI, v.HistoryTitleEN, v.HistoryBodyVI, v.HistoryBodyEN,
    v.CultureTitleVI, v.CultureTitleEN, v.CultureBodyVI, v.CultureBodyEN,
    v.ArchitectureTitleVI, v.ArchitectureTitleEN, v.ArchitectureBodyVI, v.ArchitectureBodyEN,
    v.PrimaryRegionLabelVI, v.PrimaryRegionLabelEN, v.PopulationLabelVI, v.PopulationLabelEN,
    v.DisplayOrder, 1
FROM dbo.DanToc dt
JOIN (VALUES
    ('NUNG',
     N'https://images.unsplash.com/photo-1500530855697-b586d89ba3ee?auto=format&fit=crop&w=1600&q=80', N'Không gian vùng núi Đông Bắc gắn với người Nùng', N'Northwestern mountain landscape associated with the Nung people',
     N'https://images.unsplash.com/photo-1518546305927-5a555bb7020d?auto=format&fit=crop&w=900&q=80', N'Chân dung cộng đồng Nùng', N'Nung community portrait',
     N'https://images.unsplash.com/photo-1518546305927-5a555bb7020d?auto=format&fit=crop&w=900&q=80', N'Sinh hoạt văn hóa của người Nùng', N'Nung cultural life portrait',
     N'https://images.unsplash.com/photo-1605518215584-5ea1ebda40c0?auto=format&fit=crop&w=1200&q=80', N'Không gian chợ phiên của người Nùng', N'Nung market space',
     N'https://images.unsplash.com/photo-1500534314209-a25ddb2bd429?auto=format&fit=crop&w=1200&q=80', N'Nghệ thuật hát sli của người Nùng', N'Nung sli singing',
     N'https://images.unsplash.com/photo-1466721591366-2d5fba72006d?auto=format&fit=crop&w=1200&q=80', N'Nhà sàn của cộng đồng Nùng', N'Nung stilt house',
     N'https://images.unsplash.com/photo-1518546305927-5a555bb7020d?auto=format&fit=crop&w=900&q=80', N'Ảnh đại diện dân tộc Nùng', N'Nung card image',
     N'Cộng đồng Nùng nổi bật với chợ phiên, hát sli và nếp nhà sàn gắn bó với núi đồi Đông Bắc.',
     N'The Nung community is known for market life, sli singing, and stilt houses tied to northeastern hills.',
     N'Giới thiệu về người Nùng', N'Introduction to the Nung people',
     N'Người Nùng sinh sống chủ yếu ở các tỉnh Đông Bắc, nơi văn hóa bản làng, chợ phiên và hát sli được gìn giữ qua nhiều thế hệ. Sự hiện diện của nhà sàn, ruộng bậc thang và sinh hoạt cộng đồng tạo nên bản sắc riêng cho cộng đồng.',
     N'The Nung live mainly in northeastern provinces, where village culture, market life, and sli singing have been preserved across generations. Stilt houses, terraced fields, and communal life shape their distinct identity.',
     N'Lịch sử & nguồn gốc', N'History & Origins',
     N'Người Nùng có lịch sử cư trú lâu đời ở vùng núi phía Bắc và gắn với canh tác nông nghiệp trên địa hình đồi núi. Dấu ấn lịch sử ấy thể hiện trong tổ chức bản làng, trang phục và các nghi thức truyền thống.',
     N'The Nung have long lived in northern upland areas and are tied to farming on hilly terrain. That history is visible in village organization, dress, and traditional rituals.',
     N'Đặc trưng văn hóa', N'Cultural Identity',
     N'Hát sli, lễ hội Lồng Tồng, trang phục chàm và nhà sàn là những dấu ấn tiêu biểu của văn hóa Nùng. Các giá trị ấy vừa mang tính cộng đồng vừa phản ánh mối quan hệ gần gũi với thiên nhiên.',
     N'Sli singing, Long Tong festivals, indigo clothing, and stilt houses are hallmarks of Nung culture. These values are communal and closely linked to nature.',
     N'Không gian sống', N'Living Space',
     N'Không gian sống của người Nùng thường ở các thung lũng, chân núi và ven suối, nơi nhà sàn và ruộng nước tạo thành một chỉnh thể sinh hoạt bền chặt.',
     N'Nung living space is often located in valleys, mountain foothills, and streamsides, where stilt houses and rice fields create a cohesive way of life.',
     N'Miền Bắc', N'Northern Vietnam', N'Hơn 1 triệu người', N'Over 1 million people', 8),
    ('GIAY',
     N'https://images.unsplash.com/photo-1605518215584-5ea1ebda40c0?auto=format&fit=crop&w=1600&q=80', N'Không gian ruộng bậc thang gắn với người Giấy', N'Terraced landscape associated with the Giay people',
     N'https://images.unsplash.com/photo-1515886657613-9f3515b0c78f?auto=format&fit=crop&w=900&q=80', N'Chân dung cộng đồng Giấy', N'Giay community portrait',
     N'https://images.unsplash.com/photo-1515886657613-9f3515b0c78f?auto=format&fit=crop&w=900&q=80', N'Sinh hoạt văn hóa của người Giấy', N'Giay cultural life portrait',
     N'https://images.unsplash.com/photo-1605518215584-5ea1ebda40c0?auto=format&fit=crop&w=1200&q=80', N'Không gian lễ hội cầu mùa của người Giấy', N'Giay harvest ritual space',
     N'https://images.unsplash.com/photo-1500534314209-a25ddb2bd429?auto=format&fit=crop&w=1200&q=80', N'Dân ca và điệu múa của người Giấy', N'Giay folk song and dance',
     N'https://images.unsplash.com/photo-1466721591366-2d5fba72006d?auto=format&fit=crop&w=1200&q=80', N'Nhà ở của cộng đồng Giấy', N'Giay dwelling space',
     N'https://images.unsplash.com/photo-1515886657613-9f3515b0c78f?auto=format&fit=crop&w=900&q=80', N'Ảnh đại diện dân tộc Giấy', N'Giay card image',
     N'Cộng đồng Giấy gắn với lễ hội cầu mùa, dân ca và nếp sống ruộng nước vùng núi phía Bắc.',
     N'The Giay community is associated with harvest rituals, folk songs, and wet-rice life in the northern highlands.',
     N'Giới thiệu về người Giấy', N'Introduction to the Giay people',
     N'Người Giấy cư trú ở nhiều tỉnh vùng núi phía Bắc, nơi truyền thống nông nghiệp ruộng nước, dân ca và lễ hội cộng đồng được lưu giữ bền bỉ. Đời sống văn hóa của họ phản ánh sự gắn kết giữa canh tác, gia đình và làng bản.',
     N'The Giay live in several northern mountain provinces, where wet-rice traditions, folk songs, and communal festivals are preserved. Their cultural life reflects a strong bond between farming, family, and village life.',
     N'Lịch sử & nguồn gốc', N'History & Origins',
     N'Người Giấy là một cộng đồng có lịch sử lâu dài ở vùng núi, với đời sống gắn chặt vào ruộng nước và các nghi thức nông nghiệp. Những thực hành ấy góp phần định hình bản sắc văn hóa qua nhiều thế hệ.',
     N'The Giay have a long history in the mountains, with life closely tied to wet-rice fields and agrarian rituals. These practices have shaped their identity across generations.',
     N'Đặc trưng văn hóa', N'Cultural Identity',
     N'Lễ hội cầu mùa, dân ca, trang phục truyền thống và kiến trúc nhà ở là những nét đặc trưng của văn hóa Giấy. Các yếu tố ấy tạo nên một đời sống cộng đồng giàu màu sắc.',
     N'Harvest rituals, folk songs, traditional dress, and vernacular architecture define Giay culture. These elements create a vibrant communal life.',
     N'Không gian sống', N'Living Space',
     N'Không gian sống của người Giấy thường là thung lũng, sườn đồi và các vùng ruộng bậc thang, nơi nếp sống cộng đồng và cảnh quan tự nhiên hòa hợp với nhau.',
     N'Giay living space is often made up of valleys, hillsides, and terraced fields, where community life and natural landscapes blend together.',
     N'Miền Bắc', N'Northern Vietnam', N'Hơn 0,9 triệu người', N'Over 0.9 million people', 9),
    ('CHURU',
     N'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=1600&q=80', N'Không gian Tây Nguyên và Nam Trung Bộ gắn với người Chu Ru', N'Central Highlands and south-central landscape associated with the Chu Ru people',
     N'https://images.unsplash.com/photo-1500534314209-a25ddb2bd429?auto=format&fit=crop&w=900&q=80', N'Chân dung cộng đồng Chu Ru', N'Chu Ru community portrait',
     N'https://images.unsplash.com/photo-1500534314209-a25ddb2bd429?auto=format&fit=crop&w=900&q=80', N'Sinh hoạt văn hóa của người Chu Ru', N'Chu Ru cultural life portrait',
     N'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=1200&q=80', N'Không gian lễ mừng lúa mới của người Chu Ru', N'Chu Ru new rice celebration space',
     N'https://images.unsplash.com/photo-1500534314209-a25ddb2bd429?auto=format&fit=crop&w=1200&q=80', N'Nghề dệt thổ cẩm của người Chu Ru', N'Chu Ru textile weaving',
     N'https://images.unsplash.com/photo-1466721591366-2d5fba72006d?auto=format&fit=crop&w=1200&q=80', N'Nhà ở của cộng đồng Chu Ru', N'Chu Ru dwelling space',
     N'https://images.unsplash.com/photo-1500534314209-a25ddb2bd429?auto=format&fit=crop&w=900&q=80', N'Ảnh đại diện dân tộc Chu Ru', N'Chu Ru card image',
     N'Cộng đồng Chu Ru gắn với lễ mừng lúa mới, dệt thổ cẩm và nhịp sống bản làng miền cao nguyên.',
     N'The Chu Ru community is associated with the new rice festival, textile weaving, and highland village life.',
     N'Giới thiệu về người Chu Ru', N'Introduction to the Chu Ru people',
     N'Người Chu Ru sinh sống tại Lâm Đồng và Ninh Thuận, nơi văn hóa nông nghiệp, lễ hội và nghề dệt tạo nên bản sắc riêng. Nếp sống cộng đồng và tri thức bản địa vẫn được truyền nối qua nhiều thế hệ.',
     N'The Chu Ru live in Lam Dong and Ninh Thuan, where agricultural culture, festivals, and weaving shape their identity. Community life and indigenous knowledge continue across generations.',
     N'Lịch sử & nguồn gốc', N'History & Origins',
     N'Người Chu Ru có lịch sử cư trú gắn với vùng cao nguyên và dải đất chuyển tiếp giữa Tây Nguyên và duyên hải miền Trung. Lịch sử cộng đồng thể hiện qua nghi lễ, canh tác và quan hệ làng bản.',
     N'The Chu Ru have a history linked to the highlands and the transition zone between the Central Highlands and the south-central coast. Their history is expressed in rituals, farming, and village relations.',
     N'Đặc trưng văn hóa', N'Cultural Identity',
     N'Lễ mừng lúa mới, dệt thổ cẩm, âm nhạc dân gian và hình thức cư trú cộng đồng là những dấu ấn quan trọng của văn hóa Chu Ru.',
     N'The new rice festival, textile weaving, folk music, and communal settlement patterns are key markers of Chu Ru culture.',
     N'Không gian sống', N'Living Space',
     N'Không gian sống của người Chu Ru gắn với nhà dài, ruộng nương và những thung lũng màu mỡ của miền cao nguyên.',
     N'Chu Ru living space is associated with longhouses, upland fields, and fertile highland valleys.',
     N'Tây Nguyên', N'Central Highlands', N'Hơn 0,25 triệu người', N'Over 0.25 million people', 10)
) AS v(MaDanToc,
    HeroBackgroundImageUrl, HeroBackgroundAltVI, HeroBackgroundAltEN,
    HeroForegroundImageUrl, HeroForegroundAltVI, HeroForegroundAltEN,
    IntroImageUrl, IntroImageAltVI, IntroImageAltEN,
    FeatureHighlightImageUrl, FeatureHighlightAltVI, FeatureHighlightAltEN,
    MusicImageUrl, MusicImageAltVI, MusicImageAltEN,
    ArchitectureImageUrl, ArchitectureImageAltVI, ArchitectureImageAltEN,
    CardImageUrl, CardImageAltVI, CardImageAltEN,
    HeroSubtitleVI, HeroSubtitleEN,
    OverviewTitleVI, OverviewTitleEN, OverviewBodyVI, OverviewBodyEN,
    HistoryTitleVI, HistoryTitleEN, HistoryBodyVI, HistoryBodyEN,
    CultureTitleVI, CultureTitleEN, CultureBodyVI, CultureBodyEN,
    ArchitectureTitleVI, ArchitectureTitleEN, ArchitectureBodyVI, ArchitectureBodyEN,
    PrimaryRegionLabelVI, PrimaryRegionLabelEN, PopulationLabelVI, PopulationLabelEN,
    DisplayOrder)
  ON v.MaDanToc = dt.MaDanToc
WHERE NOT EXISTS (
    SELECT 1 FROM dbo.DanTocProfile existing WHERE existing.DanTocID = dt.DanTocID
);

INSERT INTO dbo.DanTocSectionItem (DanTocID, LoaiSection, TieuDeVI, TieuDeEN, MoTaVI, MoTaEN, ImageUrl, ImageAltVI, ImageAltEN, LayoutSize, TagVI, TagEN, ThuTuHienThi, HoatDong)
SELECT dt.DanTocID, x.LoaiSection, x.TieuDeVI, x.TieuDeEN, x.MoTaVI, x.MoTaEN, x.ImageUrl, x.ImageAltVI, x.ImageAltEN, x.LayoutSize, x.TagVI, x.TagEN, x.ThuTuHienThi, 1
FROM dbo.DanToc dt
JOIN (VALUES
    ('NUNG','FEATURES',N'Hát sli và lượn',N'Sli Singing and Luon Songs',N'Hát sli và lượn là làn điệu dân gian quan trọng trong giao tiếp và sinh hoạt cộng đồng.',N'Sli and luon songs are important folk melodies in community interaction and everyday life.',N'https://images.unsplash.com/photo-1605518215584-5ea1ebda40c0?auto=format&fit=crop&w=900&q=80',N'Hát sli của người Nùng',N'Nung sli singing','small',N'Nổi bật',N'Featured',37),
    ('NUNG','STORIES',N'Lễ hội Lồng Tồng',N'Long Tong Festival',N'Lễ hội cầu mùa, cầu phúc được tổ chức đầu năm tại nhiều bản làng.',N'A harvest and blessing festival held at the beginning of the year in many villages.',N'https://images.unsplash.com/photo-1518546305927-5a555bb7020d?auto=format&fit=crop&w=900&q=80',N'Lễ hội Lồng Tồng của người Nùng',N'Nung Long Tong festival','small',NULL,NULL,38),
    ('NUNG','GALLERY',N'Nhà sàn người Nùng',N'Nung Stilt House',N'Không gian cư trú truyền thống gắn với núi đồi và ruộng nương.',N'Traditional dwelling space tied to hills and upland fields.',N'https://images.unsplash.com/photo-1466721591366-2d5fba72006d?auto=format&fit=crop&w=1200&q=80',N'Nhà sàn người Nùng',N'Nung stilt house','large',NULL,NULL,39),
    ('GIAY','FEATURES',N'Pí lè và dân ca',N'Pi Le and Folk Songs',N'Âm nhạc dân gian là một phần quan trọng trong đời sống cộng đồng Giấy.',N'Folk music is an important part of Giay community life.',N'https://images.unsplash.com/photo-1500534314209-a25ddb2bd429?auto=format&fit=crop&w=900&q=80',N'Âm nhạc dân gian của người Giấy',N'Giay folk music','small',N'Nổi bật',N'Featured',40),
    ('GIAY','STORIES',N'Lễ hội cầu mùa',N'Harvest Ritual',N'Lễ hội cầu mùa phản ánh niềm tin nông nghiệp và sự gắn kết cộng đồng.',N'Harvest rituals reflect agrarian beliefs and community cohesion.',N'https://images.unsplash.com/photo-1513151233558-d860c5398176?auto=format&fit=crop&w=900&q=80',N'Lễ hội cầu mùa của người Giấy',N'Giay harvest ritual','small',NULL,NULL,41),
    ('GIAY','GALLERY',N'Ruộng bậc thang',N'Terraced Fields',N'Phong cảnh ruộng bậc thang gắn với nếp sống vùng cao.',N'Terraced scenery tied to upland life.',N'https://images.unsplash.com/photo-1500530855697-b586d89ba3ee?auto=format&fit=crop&w=1200&q=80',N'Ruộng bậc thang vùng cao',N'Highland terraced fields','large',NULL,NULL,42),
    ('CHURU','FEATURES',N'Lễ mừng lúa mới',N'New Rice Festival',N'Lễ mừng lúa mới là một nghi lễ trọng đại trong đời sống tinh thần của người Chu Ru.',N'The new rice festival is a major ritual in Chu Ru spiritual life.',N'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=900&q=80',N'Lễ mừng lúa mới của người Chu Ru',N'Chu Ru new rice festival','small',N'Nổi bật',N'Featured',43),
    ('CHURU','STORIES',N'Dệt thổ cẩm Chu Ru',N'Chu Ru Textile Weaving',N'Những hoa văn thổ cẩm phản ánh ký ức và thẩm mỹ của cộng đồng.',N'Textile motifs reflect the memory and aesthetics of the community.',N'https://images.unsplash.com/photo-1521572267360-ee0c2909d518?auto=format&fit=crop&w=900&q=80',N'Dệt thổ cẩm Chu Ru',N'Chu Ru textile weaving','small',NULL,NULL,44),
    ('CHURU','GALLERY',N'Nhà dài Chu Ru',N'Chu Ru Longhouse',N'Kiến trúc nhà dài thể hiện sự kết nối giữa gia đình và cộng đồng.',N'Longhouse architecture expresses the connection between family and community.',N'https://images.unsplash.com/photo-1466721591366-2d5fba72006d?auto=format&fit=crop&w=1200&q=80',N'Nhà dài Chu Ru',N'Chu Ru longhouse','large',NULL,NULL,45)
) AS x(MaDanToc, LoaiSection, TieuDeVI, TieuDeEN, MoTaVI, MoTaEN, ImageUrl, ImageAltVI, ImageAltEN, LayoutSize, TagVI, TagEN, ThuTuHienThi)
  ON dt.MaDanToc = x.MaDanToc
WHERE NOT EXISTS (
    SELECT 1
    FROM dbo.DanTocSectionItem existing
    WHERE existing.DanTocID = dt.DanTocID
      AND existing.LoaiSection = x.LoaiSection
      AND ISNULL(existing.TieuDeVI, N'') = ISNULL(x.TieuDeVI, N'')
);

UPDATE dp
SET
  ListBadgeVI = CASE
    WHEN dt.MaDanToc IN ('HMONG', 'CHAM', 'EDE', 'TAY', 'KINH') THEN N'Nổi bật'
    WHEN dt.MaDanToc IN ('BANA', 'MUONG', 'NUNG', 'GIAY', 'CHURU') THEN N'Mới'
    ELSE ListBadgeVI
  END,
  ListBadgeEN = CASE
    WHEN dt.MaDanToc IN ('HMONG', 'CHAM', 'EDE', 'TAY', 'KINH') THEN N'Featured'
    WHEN dt.MaDanToc IN ('BANA', 'MUONG', 'NUNG', 'GIAY', 'CHURU') THEN N'New'
    ELSE ListBadgeEN
  END,
  IsNew = CASE
    WHEN dt.MaDanToc IN ('BANA', 'MUONG', 'NUNG', 'GIAY', 'CHURU') THEN 1
    ELSE ISNULL(dp.IsNew, 0)
  END,
  DisplayOrder = CASE dt.MaDanToc
    WHEN 'KINH' THEN 1
    WHEN 'TAY' THEN 2
    WHEN 'HMONG' THEN 3
    WHEN 'EDE' THEN 4
    WHEN 'CHAM' THEN 5
    WHEN 'KHMER' THEN 6
    WHEN 'DAO' THEN 7
    WHEN 'BANA' THEN 8
    WHEN 'MUONG' THEN 9
    WHEN 'NUNG' THEN 10
    WHEN 'GIAY' THEN 11
    WHEN 'CHURU' THEN 12
    ELSE dp.DisplayOrder
  END
FROM dbo.DanTocProfile dp
JOIN dbo.DanToc dt ON dt.DanTocID = dp.DanTocID;

SELECT COUNT(*) AS EthnicProfilesCount FROM dbo.DanTocProfile;
SELECT COUNT(*) AS EthnicSectionItemsCount FROM dbo.DanTocSectionItem;
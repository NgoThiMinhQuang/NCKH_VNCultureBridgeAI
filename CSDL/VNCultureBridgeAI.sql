/* =========================================================
   CSDL RÚT GỌN - VNCultureBridgeAI
   Vẫn giữ đúng nghiệp vụ cốt lõi
   ========================================================= */

IF DB_ID(N'VNCultureBridgeAI') IS NULL
BEGIN
    CREATE DATABASE VNCultureBridgeAI;
END
GO

USE VNCultureBridgeAI;
GO

/* =========================================================
   1. NGƯỜI DÙNG QUẢN TRỊ
   ========================================================= */

CREATE TABLE dbo.NguoiDung (
    NguoiDungID         INT IDENTITY(1,1) PRIMARY KEY,
    HoTen               NVARCHAR(150) NOT NULL,
    Email               VARCHAR(255) NOT NULL UNIQUE,
    MatKhauHash         VARCHAR(255) NOT NULL,
    VaiTro              VARCHAR(30) NOT NULL,
    TrangThai           VARCHAR(20) NOT NULL DEFAULT 'ACTIVE',
    NgayTao             DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
    NgayCapNhat         DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
    CONSTRAINT CK_NguoiDung_VaiTro CHECK (VaiTro IN ('ADMIN','CONTENT_MANAGER','REVIEWER','AI_MANAGER')),
    CONSTRAINT CK_NguoiDung_TrangThai CHECK (TrangThai IN ('ACTIVE','LOCKED','INACTIVE'))
);
GO

CREATE TABLE dbo.KhachHang (
    KhachHangID          INT IDENTITY(1,1) PRIMARY KEY,
    HoTen                NVARCHAR(150) NOT NULL,
    Email                VARCHAR(255) NOT NULL UNIQUE,
    MatKhauHash          VARCHAR(255) NOT NULL,
    TrangThai            VARCHAR(20) NOT NULL DEFAULT 'ACTIVE',
    NgayTao              DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
    NgayCapNhat          DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
    CONSTRAINT CK_KhachHang_TrangThai CHECK (TrangThai IN ('ACTIVE','LOCKED','INACTIVE'))
);
GO

/* =========================================================
   2. DANH MỤC TRI THỨC
   Gộp song ngữ VI/EN vào cùng bảng để giảm số bảng
   ========================================================= */

CREATE TABLE dbo.DanhMuc (
    DanhMucID           INT IDENTITY(1,1) PRIMARY KEY,
    MaDanhMuc           VARCHAR(50) NOT NULL UNIQUE,
    TenVI               NVARCHAR(200) NOT NULL,
    TenEN               NVARCHAR(200) NOT NULL,
    MoTaVI              NVARCHAR(1000) NULL,
    MoTaEN              NVARCHAR(1000) NULL,
    HoatDong            BIT NOT NULL DEFAULT 1
);
GO

CREATE TABLE dbo.VungVanHoa (
    VungID                  INT IDENTITY(1,1) PRIMARY KEY,
    MaVung                  VARCHAR(50) NOT NULL UNIQUE,
    TenVI                   NVARCHAR(200) NOT NULL,
    TenEN                   NVARCHAR(200) NOT NULL,
    LoaiVung                VARCHAR(30) NOT NULL DEFAULT 'CULTURAL_ZONE',
    GeoJson                 NVARCHAR(MAX) NULL,
    HomepageEnabled         BIT NOT NULL DEFAULT 0,
    HomepageDisplayOrder    INT NULL,
    HomepageBadgeVI         NVARCHAR(100) NULL,
    HomepageTitleVI         NVARCHAR(200) NULL,
    HomepageDescriptionVI   NVARCHAR(1000) NULL,
    HomepageHighlightsVI    NVARCHAR(MAX) NULL,
    HomepageCtaVI           NVARCHAR(150) NULL,
    HomepageImageUrl        NVARCHAR(1000) NULL,
    HomepageImageAltVI      NVARCHAR(500) NULL,
    HoatDong                BIT NOT NULL DEFAULT 1,
    CONSTRAINT CK_VungVanHoa_Loai CHECK (LoaiVung IN ('NORTH','CENTRAL','SOUTH','HIGHLAND','DELTA','CULTURAL_ZONE','OTHER'))
);
GO

IF COL_LENGTH('dbo.VungVanHoa', 'HomepageEnabled') IS NULL
BEGIN
    ALTER TABLE dbo.VungVanHoa ADD HomepageEnabled BIT NOT NULL CONSTRAINT DF_VungVanHoa_HomepageEnabled DEFAULT 0;
END
GO

IF COL_LENGTH('dbo.VungVanHoa', 'HomepageDisplayOrder') IS NULL
BEGIN
    ALTER TABLE dbo.VungVanHoa ADD HomepageDisplayOrder INT NULL;
END
GO

IF COL_LENGTH('dbo.VungVanHoa', 'HomepageBadgeVI') IS NULL
BEGIN
    ALTER TABLE dbo.VungVanHoa ADD HomepageBadgeVI NVARCHAR(100) NULL;
END
GO

IF COL_LENGTH('dbo.VungVanHoa', 'HomepageTitleVI') IS NULL
BEGIN
    ALTER TABLE dbo.VungVanHoa ADD HomepageTitleVI NVARCHAR(200) NULL;
END
GO

IF COL_LENGTH('dbo.VungVanHoa', 'HomepageDescriptionVI') IS NULL
BEGIN
    ALTER TABLE dbo.VungVanHoa ADD HomepageDescriptionVI NVARCHAR(1000) NULL;
END
GO

IF COL_LENGTH('dbo.VungVanHoa', 'HomepageHighlightsVI') IS NULL
BEGIN
    ALTER TABLE dbo.VungVanHoa ADD HomepageHighlightsVI NVARCHAR(MAX) NULL;
END
GO

IF COL_LENGTH('dbo.VungVanHoa', 'HomepageCtaVI') IS NULL
BEGIN
    ALTER TABLE dbo.VungVanHoa ADD HomepageCtaVI NVARCHAR(150) NULL;
END
GO

IF COL_LENGTH('dbo.VungVanHoa', 'HomepageImageUrl') IS NULL
BEGIN
    ALTER TABLE dbo.VungVanHoa ADD HomepageImageUrl NVARCHAR(1000) NULL;
END
GO

IF COL_LENGTH('dbo.VungVanHoa', 'HomepageImageAltVI') IS NULL
BEGIN
    ALTER TABLE dbo.VungVanHoa ADD HomepageImageAltVI NVARCHAR(500) NULL;
END
GO

IF COL_LENGTH('dbo.VungVanHoa', 'OverviewTitleVI') IS NULL
BEGIN
    ALTER TABLE dbo.VungVanHoa ADD OverviewTitleVI NVARCHAR(300) NULL;
END
GO

IF COL_LENGTH('dbo.VungVanHoa', 'OverviewTitleEN') IS NULL
BEGIN
    ALTER TABLE dbo.VungVanHoa ADD OverviewTitleEN NVARCHAR(300) NULL;
END
GO

IF COL_LENGTH('dbo.VungVanHoa', 'OverviewDescriptionVI') IS NULL
BEGIN
    ALTER TABLE dbo.VungVanHoa ADD OverviewDescriptionVI NVARCHAR(MAX) NULL;
END
GO

IF COL_LENGTH('dbo.VungVanHoa', 'OverviewDescriptionEN') IS NULL
BEGIN
    ALTER TABLE dbo.VungVanHoa ADD OverviewDescriptionEN NVARCHAR(MAX) NULL;
END
GO

IF COL_LENGTH('dbo.VungVanHoa', 'OverviewDetailsJsonVI') IS NULL
BEGIN
    ALTER TABLE dbo.VungVanHoa ADD OverviewDetailsJsonVI NVARCHAR(MAX) NULL;
END
GO

IF COL_LENGTH('dbo.VungVanHoa', 'OverviewDetailsJsonEN') IS NULL
BEGIN
    ALTER TABLE dbo.VungVanHoa ADD OverviewDetailsJsonEN NVARCHAR(MAX) NULL;
END
GO

IF NOT EXISTS (
    SELECT 1
    FROM sys.indexes
    WHERE name = 'IX_VungVanHoa_Homepage'
      AND object_id = OBJECT_ID('dbo.VungVanHoa')
)
BEGIN
    CREATE INDEX IX_VungVanHoa_Homepage ON dbo.VungVanHoa (HomepageEnabled, HomepageDisplayOrder, HoatDong);
END
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
        NgayCapNhat               DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
        CONSTRAINT CK_LeHoi_LoaiBanGhi CHECK (LoaiBanGhi IN ('PAGE', 'FESTIVAL'))
    );
END
GO

IF NOT EXISTS (
    SELECT 1 FROM sys.indexes
    WHERE name = 'IX_LeHoi_LoaiBanGhi_ThuTu'
      AND object_id = OBJECT_ID('dbo.LeHoi')
)
BEGIN
    CREATE INDEX IX_LeHoi_LoaiBanGhi_ThuTu ON dbo.LeHoi (LoaiBanGhi, HoatDong, ThuTuHienThi);
END
GO

CREATE TABLE dbo.DanToc (
    DanTocID            INT IDENTITY(1,1) PRIMARY KEY,
    MaDanToc            VARCHAR(50) NOT NULL UNIQUE,
    TenVI               NVARCHAR(200) NOT NULL,
    TenEN               NVARCHAR(200) NOT NULL,
    MoTaVI              NVARCHAR(1000) NULL,
    MoTaEN              NVARCHAR(1000) NULL,
    HoatDong            BIT NOT NULL DEFAULT 1
);
GO

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
        DisplayOrder                INT NOT NULL DEFAULT 0,
        HoatDong                    BIT NOT NULL DEFAULT 1,
        NgayTao                     DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
        NgayCapNhat                 DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
        CONSTRAINT FK_DanTocProfile_DanToc FOREIGN KEY (DanTocID) REFERENCES dbo.DanToc(DanTocID) ON DELETE CASCADE
    );
END
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

IF NOT EXISTS (
    SELECT 1 FROM sys.indexes
    WHERE name = 'IX_DanTocProfile_DisplayOrder'
      AND object_id = OBJECT_ID('dbo.DanTocProfile')
)
BEGIN
    CREATE INDEX IX_DanTocProfile_DisplayOrder ON dbo.DanTocProfile (DisplayOrder, HoatDong);
END
GO

IF NOT EXISTS (
    SELECT 1 FROM sys.indexes
    WHERE name = 'IX_DanTocSectionItem_DanToc_Section'
      AND object_id = OBJECT_ID('dbo.DanTocSectionItem')
)
BEGIN
    CREATE INDEX IX_DanTocSectionItem_DanToc_Section ON dbo.DanTocSectionItem (DanTocID, LoaiSection, ThuTuHienThi, HoatDong);
END
GO

IF NOT EXISTS (
    SELECT 1 FROM sys.indexes
    WHERE name = 'IX_DanTocSectionItem_BaiViet'
      AND object_id = OBJECT_ID('dbo.DanTocSectionItem')
)
BEGIN
    CREATE INDEX IX_DanTocSectionItem_BaiViet ON dbo.DanTocSectionItem (LienKetBaiVietID);
END
GO

CREATE TABLE dbo.TuKhoa (
    TuKhoaID            INT IDENTITY(1,1) PRIMARY KEY,
    MaTuKhoa            VARCHAR(50) NOT NULL UNIQUE,
    GiaTriVI            NVARCHAR(150) NOT NULL,
    GiaTriEN            NVARCHAR(150) NOT NULL,
    HoatDong            BIT NOT NULL DEFAULT 1
);
GO

/* =========================================================
   3. BÀI VIẾT VĂN HOÁ
   Gộp nội dung VI/EN vào cùng bảng để đơn giản
   ========================================================= */

CREATE TABLE dbo.BaiViet (
    BaiVietID               INT IDENTITY(1,1) PRIMARY KEY,
    MaBaiViet               VARCHAR(50) NOT NULL UNIQUE,

    TieuDeVI                NVARCHAR(300) NOT NULL,
    TieuDeEN                NVARCHAR(300) NOT NULL,
    MoTaNganVI              NVARCHAR(1000) NULL,
    MoTaNganEN              NVARCHAR(1000) NULL,

    GioiThieuVI             NVARCHAR(MAX) NULL,
    GioiThieuEN             NVARCHAR(MAX) NULL,
    NguonGocVI              NVARCHAR(MAX) NULL,
    NguonGocEN              NVARCHAR(MAX) NULL,
    YNghiaVanHoaVI          NVARCHAR(MAX) NULL,
    YNghiaVanHoaEN          NVARCHAR(MAX) NULL,
    BoiCanhVI               NVARCHAR(MAX) NULL,
    BoiCanhEN               NVARCHAR(MAX) NULL,
    NoiDungChinhVI          NVARCHAR(MAX) NOT NULL,
    NoiDungChinhEN          NVARCHAR(MAX) NOT NULL,

    TrangThaiDuyet          VARCHAR(20) NOT NULL DEFAULT 'DRAFT',
    TrangThaiXuatBan        VARCHAR(20) NOT NULL DEFAULT 'PRIVATE',
    MucDoNhayCam            TINYINT NOT NULL DEFAULT 1,

    -- Phần phục vụ AI
    TrangThaiDongBoAI       VARCHAR(20) NOT NULL DEFAULT 'PENDING',
    AIChoPhep               BIT NOT NULL DEFAULT 0,
    TomTatChoAIVI           NVARCHAR(MAX) NULL,
    TomTatChoAIEN           NVARCHAR(MAX) NULL,
    SanSangChoAI            BIT NOT NULL DEFAULT 0,

    NgayGuiDuyet            DATETIME2 NULL,
    NgayDuyet               DATETIME2 NULL,
    NgayXuatBan             DATETIME2 NULL,

    TaoBoi                  INT NOT NULL,
    CapNhatBoi              INT NOT NULL,
    DuyetBoi                INT NULL,

    NgayTao                 DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
    NgayCapNhat             DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),

    CONSTRAINT CK_BaiViet_TrangThaiDuyet CHECK (TrangThaiDuyet IN ('DRAFT','PENDING_REVIEW','APPROVED','REJECTED')),
    CONSTRAINT CK_BaiViet_TrangThaiXuatBan CHECK (TrangThaiXuatBan IN ('PRIVATE','PUBLISHED','HIDDEN','ARCHIVED')),
    CONSTRAINT CK_BaiViet_DongBoAI CHECK (TrangThaiDongBoAI IN ('PENDING','PROCESSING','READY','FAILED')),
    CONSTRAINT CK_BaiViet_NhayCam CHECK (MucDoNhayCam BETWEEN 1 AND 3),

    CONSTRAINT FK_BaiViet_TaoBoi FOREIGN KEY (TaoBoi) REFERENCES dbo.NguoiDung(NguoiDungID),
    CONSTRAINT FK_BaiViet_CapNhatBoi FOREIGN KEY (CapNhatBoi) REFERENCES dbo.NguoiDung(NguoiDungID),
    CONSTRAINT FK_BaiViet_DuyetBoi FOREIGN KEY (DuyetBoi) REFERENCES dbo.NguoiDung(NguoiDungID)
);
GO

/* =========================================================
   4. BẢNG LIÊN KẾT NGHIỆP VỤ
   ========================================================= */

CREATE TABLE dbo.BaiViet_DanhMuc (
    BaiVietID           INT NOT NULL,
    DanhMucID           INT NOT NULL,
    LaDanhMucChinh      BIT NOT NULL DEFAULT 0,
    PRIMARY KEY (BaiVietID, DanhMucID),
    CONSTRAINT FK_BVDM_BaiViet FOREIGN KEY (BaiVietID) REFERENCES dbo.BaiViet(BaiVietID) ON DELETE CASCADE,
    CONSTRAINT FK_BVDM_DanhMuc FOREIGN KEY (DanhMucID) REFERENCES dbo.DanhMuc(DanhMucID)
);
GO

CREATE TABLE dbo.BaiViet_Vung (
    BaiVietID           INT NOT NULL,
    VungID              INT NOT NULL,
    LaVungChinh         BIT NOT NULL DEFAULT 0,
    PRIMARY KEY (BaiVietID, VungID),
    CONSTRAINT FK_BVV_BaiViet FOREIGN KEY (BaiVietID) REFERENCES dbo.BaiViet(BaiVietID) ON DELETE CASCADE,
    CONSTRAINT FK_BVV_Vung FOREIGN KEY (VungID) REFERENCES dbo.VungVanHoa(VungID)
);
GO

CREATE TABLE dbo.BaiViet_DanToc (
    BaiVietID           INT NOT NULL,
    DanTocID            INT NOT NULL,
    LaDanTocChinh       BIT NOT NULL DEFAULT 0,
    PRIMARY KEY (BaiVietID, DanTocID),
    CONSTRAINT FK_BVDT_BaiViet FOREIGN KEY (BaiVietID) REFERENCES dbo.BaiViet(BaiVietID) ON DELETE CASCADE,
    CONSTRAINT FK_BVDT_DanToc FOREIGN KEY (DanTocID) REFERENCES dbo.DanToc(DanTocID)
);
GO

CREATE TABLE dbo.BaiViet_TuKhoa (
    BaiVietID           INT NOT NULL,
    TuKhoaID            INT NOT NULL,
    PRIMARY KEY (BaiVietID, TuKhoaID),
    CONSTRAINT FK_BVTK_BaiViet FOREIGN KEY (BaiVietID) REFERENCES dbo.BaiViet(BaiVietID) ON DELETE CASCADE,
    CONSTRAINT FK_BVTK_TuKhoa FOREIGN KEY (TuKhoaID) REFERENCES dbo.TuKhoa(TuKhoaID)
);
GO

CREATE TABLE dbo.BaiViet_LienQuan (
    BaiVietID               INT NOT NULL,
    BaiVietLienQuanID       INT NOT NULL,
    LoaiLienQuan            VARCHAR(20) NOT NULL DEFAULT 'RELATED',
    PRIMARY KEY (BaiVietID, BaiVietLienQuanID),
    CONSTRAINT CK_BaiViet_LienQuan_KhacNhau CHECK (BaiVietID <> BaiVietLienQuanID),
    CONSTRAINT CK_BaiViet_LienQuan_Loai CHECK (LoaiLienQuan IN ('RELATED','SIMILAR','COMPARE','EXPAND')),
    CONSTRAINT FK_BVLQ_BaiViet FOREIGN KEY (BaiVietID) REFERENCES dbo.BaiViet(BaiVietID) ON DELETE CASCADE,
    CONSTRAINT FK_BVLQ_BaiViet2 FOREIGN KEY (BaiVietLienQuanID) REFERENCES dbo.BaiViet(BaiVietID)
);
GO

/* =========================================================
   5. MEDIA VÀ NGUỒN THAM KHẢO
   Rút gọn: gắn trực tiếp về bài viết
   ========================================================= */

CREATE TABLE dbo.Media (
    MediaID              INT IDENTITY(1,1) PRIMARY KEY,
    BaiVietID            INT NOT NULL,
    LoaiMedia            VARCHAR(20) NOT NULL,
    UrlFile              NVARCHAR(1000) NOT NULL,
    AltTextVI            NVARCHAR(500) NULL,
    AltTextEN            NVARCHAR(500) NULL,
    ChuThichVI           NVARCHAR(1000) NULL,
    ChuThichEN           NVARCHAR(1000) NULL,
    LaAnhChinh           BIT NOT NULL DEFAULT 0,
    ThuTuHienThi         INT NOT NULL DEFAULT 1,
    NgayTao              DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
    CONSTRAINT CK_Media_Loai CHECK (LoaiMedia IN ('IMAGE','VIDEO','AUDIO','DOCUMENT')),
    CONSTRAINT FK_Media_BaiViet FOREIGN KEY (BaiVietID) REFERENCES dbo.BaiViet(BaiVietID) ON DELETE CASCADE
);
GO

CREATE TABLE dbo.NgheThuatPage (
    NgheThuatPageID         INT IDENTITY(1,1) PRIMARY KEY,
    MaTrang                 VARCHAR(50) NOT NULL UNIQUE,
    HeroBadgeVI             NVARCHAR(200) NULL,
    HeroBadgeEN             NVARCHAR(200) NULL,
    HeroTitleLine1VI        NVARCHAR(200) NULL,
    HeroTitleLine1EN        NVARCHAR(200) NULL,
    HeroTitleAccentVI       NVARCHAR(200) NULL,
    HeroTitleAccentEN       NVARCHAR(200) NULL,
    HeroTitleLine3VI        NVARCHAR(200) NULL,
    HeroTitleLine3EN        NVARCHAR(200) NULL,
    HeroSubtitleVI          NVARCHAR(MAX) NULL,
    HeroSubtitleEN          NVARCHAR(MAX) NULL,
    HeroImageUrl            NVARCHAR(1000) NULL,
    HeroImageAltVI          NVARCHAR(500) NULL,
    HeroImageAltEN          NVARCHAR(500) NULL,
    HeroImageBadgeVI        NVARCHAR(200) NULL,
    HeroImageBadgeEN        NVARCHAR(200) NULL,
    HeroImageBadgeIcon      NVARCHAR(20) NULL,
    StatsJsonVI             NVARCHAR(MAX) NULL,
    StatsJsonEN             NVARCHAR(MAX) NULL,
    HeritageTitleVI         NVARCHAR(200) NULL,
    HeritageTitleEN         NVARCHAR(200) NULL,
    HeritageSubtitleVI      NVARCHAR(MAX) NULL,
    HeritageSubtitleEN      NVARCHAR(MAX) NULL,
    HeritageCardsJsonVI     NVARCHAR(MAX) NULL,
    HeritageCardsJsonEN     NVARCHAR(MAX) NULL,
    FeaturedBadgeVI         NVARCHAR(200) NULL,
    FeaturedBadgeEN         NVARCHAR(200) NULL,
    FeaturedTitleVI         NVARCHAR(200) NULL,
    FeaturedTitleEN         NVARCHAR(200) NULL,
    FeaturedBodyJsonVI      NVARCHAR(MAX) NULL,
    FeaturedBodyJsonEN      NVARCHAR(MAX) NULL,
    FeaturedStatsJsonVI     NVARCHAR(MAX) NULL,
    FeaturedStatsJsonEN     NVARCHAR(MAX) NULL,
    FeaturedImageUrl        NVARCHAR(1000) NULL,
    FeaturedImageAltVI      NVARCHAR(500) NULL,
    FeaturedImageAltEN      NVARCHAR(500) NULL,
    GalleryTitleVI          NVARCHAR(200) NULL,
    GalleryTitleEN          NVARCHAR(200) NULL,
    GallerySubtitleVI       NVARCHAR(MAX) NULL,
    GallerySubtitleEN       NVARCHAR(MAX) NULL,
    GalleryImagesJsonVI     NVARCHAR(MAX) NULL,
    GalleryImagesJsonEN     NVARCHAR(MAX) NULL,
    StoryBadgeVI            NVARCHAR(200) NULL,
    StoryBadgeEN            NVARCHAR(200) NULL,
    StoryTitleVI            NVARCHAR(200) NULL,
    StoryTitleEN            NVARCHAR(200) NULL,
    StoryBodyJsonVI         NVARCHAR(MAX) NULL,
    StoryBodyJsonEN         NVARCHAR(MAX) NULL,
    StoryFeaturesJsonVI     NVARCHAR(MAX) NULL,
    StoryFeaturesJsonEN     NVARCHAR(MAX) NULL,
    StoryImagesJsonVI       NVARCHAR(MAX) NULL,
    StoryImagesJsonEN       NVARCHAR(MAX) NULL,
    HoatDong                BIT NOT NULL DEFAULT 1,
    NgayTao                 DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
    NgayCapNhat             DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME()
);
GO

CREATE TABLE dbo.NguonThamKhao (
    NguonID              INT IDENTITY(1,1) PRIMARY KEY,
    BaiVietID            INT NOT NULL,
    TieuDeNguon          NVARCHAR(500) NOT NULL,
    TacGia               NVARCHAR(300) NULL,
    LoaiNguon            VARCHAR(30) NOT NULL,
    UrlNguon             NVARCHAR(1000) NULL,
    GhiChu               NVARCHAR(1000) NULL,
    LaNguonChinh         BIT NOT NULL DEFAULT 0,
    CONSTRAINT CK_NguonThamKhao_Loai CHECK (LoaiNguon IN ('BOOK','JOURNAL','RESEARCH','MUSEUM','LIBRARY','GOVERNMENT','WEBSITE','OTHER')),
    CONSTRAINT FK_NguonThamKhao_BaiViet FOREIGN KEY (BaiVietID) REFERENCES dbo.BaiViet(BaiVietID) ON DELETE CASCADE
);
GO

/* =========================================================
   6. AI CHATBOT
   ========================================================= */

CREATE TABLE dbo.MauPrompt (
    MauPromptID          INT IDENTITY(1,1) PRIMARY KEY,
    MaPrompt             VARCHAR(50) NOT NULL UNIQUE,
    LoaiPrompt           VARCHAR(40) NOT NULL,
    TenPrompt            NVARCHAR(200) NOT NULL,
    NoiDungPrompt        NVARCHAR(MAX) NOT NULL,
    HoatDong             BIT NOT NULL DEFAULT 1,
    NgayTao              DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
    CONSTRAINT CK_MauPrompt_Loai CHECK (LoaiPrompt IN ('CONCEPT_EXPLAIN','CULTURAL_MEANING','ORIGIN','COMPARE_REGION','RECOMMENDATION','SOFT_REFUSAL','GENERAL_QA'))
);
GO

CREATE TABLE dbo.NhatKyCauHoiAI (
    CauHoiID             BIGINT IDENTITY(1,1) PRIMARY KEY,
    SessionID            UNIQUEIDENTIFIER NOT NULL DEFAULT NEWSEQUENTIALID(),
    BaiVietNguCanhID     INT NULL,
    NgonNguCauHoi        VARCHAR(5) NOT NULL,
    NoiDungCauHoi        NVARCHAR(MAX) NOT NULL,
    LoaiYDinh            VARCHAR(40) NOT NULL,
    CauTraLoi            NVARCHAR(MAX) NULL,
    TrangThaiTraLoi      VARCHAR(25) NOT NULL DEFAULT 'SUCCESS',
    DiemTinCay           DECIMAL(5,2) NULL,
    MauPromptID          INT NULL,
    CanBoSungNoiDung     BIT NOT NULL DEFAULT 0,
    HoiLuc               DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
    CONSTRAINT CK_NhatKyCauHoiAI_NgonNgu CHECK (NgonNguCauHoi IN ('VI','EN')),
    CONSTRAINT CK_NhatKyCauHoiAI_LoaiYDinh CHECK (LoaiYDinh IN ('DEFINE','ORIGIN','MEANING','COMPARE','RECOMMEND','GENERAL','OUT_OF_SCOPE')),
    CONSTRAINT CK_NhatKyCauHoiAI_TrangThai CHECK (TrangThaiTraLoi IN ('SUCCESS','SOFT_REFUSAL','NO_DATA','LOW_CONFIDENCE','FAILED')),
    CONSTRAINT FK_NhatKyCauHoiAI_BaiViet FOREIGN KEY (BaiVietNguCanhID) REFERENCES dbo.BaiViet(BaiVietID),
    CONSTRAINT FK_NhatKyCauHoiAI_MauPrompt FOREIGN KEY (MauPromptID) REFERENCES dbo.MauPrompt(MauPromptID)
);
GO

/* =========================================================
   7. FEEDBACK VÀ THỐNG KÊ
   ========================================================= */

CREATE TABLE dbo.PhanHoiNguoiDung (
    PhanHoiID            BIGINT IDENTITY(1,1) PRIMARY KEY,
    BaiVietID            INT NULL,
    CauHoiID             BIGINT NULL,
    DoiTuongPhanHoi      VARCHAR(20) NOT NULL,
    DiemDanhGia          TINYINT NULL,
    HuuIch               BIT NULL,
    NoiDungPhanHoi       NVARCHAR(2000) NULL,
    TrangThaiXuLy        VARCHAR(20) NOT NULL DEFAULT 'OPEN',
    GuiLuc               DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
    CONSTRAINT CK_PhanHoiNguoiDung_DoiTuong CHECK (DoiTuongPhanHoi IN ('ARTICLE','AI_ANSWER')),
    CONSTRAINT CK_PhanHoiNguoiDung_TrangThai CHECK (TrangThaiXuLy IN ('OPEN','IN_PROGRESS','RESOLVED','REJECTED')),
    CONSTRAINT CK_PhanHoiNguoiDung_Diem CHECK (DiemDanhGia IS NULL OR DiemDanhGia BETWEEN 1 AND 5),
    CONSTRAINT FK_PhanHoiNguoiDung_BaiViet FOREIGN KEY (BaiVietID) REFERENCES dbo.BaiViet(BaiVietID),
    CONSTRAINT FK_PhanHoiNguoiDung_CauHoi FOREIGN KEY (CauHoiID) REFERENCES dbo.NhatKyCauHoiAI(CauHoiID)
);
GO

CREATE TABLE dbo.NhatKyTimKiem (
    TimKiemID            BIGINT IDENTITY(1,1) PRIMARY KEY,
    SessionID            UNIQUEIDENTIFIER NOT NULL DEFAULT NEWSEQUENTIALID(),
    TuKhoaTimKiem        NVARCHAR(500) NOT NULL,
    NgonNguTimKiem       VARCHAR(5) NULL,
    SoKetQua             INT NOT NULL DEFAULT 0,
    TimLuc               DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME()
);
GO

CREATE TABLE dbo.NhatKyXemBaiViet (
    XemID                BIGINT IDENTITY(1,1) PRIMARY KEY,
    SessionID            UNIQUEIDENTIFIER NOT NULL DEFAULT NEWSEQUENTIALID(),
    BaiVietID            INT NOT NULL,
    NgonNguXem           VARCHAR(5) NULL,
    XemLuc               DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
    CONSTRAINT FK_NhatKyXemBaiViet_BaiViet FOREIGN KEY (BaiVietID) REFERENCES dbo.BaiViet(BaiVietID)
);
GO

/* =========================================================
   8. LỊCH SỬ DUYỆT / TRUY VẾT
   ========================================================= */

CREATE TABLE dbo.LichSuDuyetBaiViet (
    LichSuID             INT IDENTITY(1,1) PRIMARY KEY,
    BaiVietID            INT NOT NULL,
    HanhDong             VARCHAR(30) NOT NULL,
    TuTrangThai          VARCHAR(20) NULL,
    DenTrangThai         VARCHAR(20) NULL,
    GhiChu               NVARCHAR(1000) NULL,
    ThucHienBoi          INT NOT NULL,
    ThucHienLuc          DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
    CONSTRAINT CK_LichSuDuyetBaiViet_HanhDong CHECK (HanhDong IN ('CREATE','SUBMIT_REVIEW','APPROVE','REJECT','PUBLISH','HIDE','UPDATE')),
    CONSTRAINT FK_LichSuDuyetBaiViet_BaiViet FOREIGN KEY (BaiVietID) REFERENCES dbo.BaiViet(BaiVietID) ON DELETE CASCADE,
    CONSTRAINT FK_LichSuDuyetBaiViet_NguoiDung FOREIGN KEY (ThucHienBoi) REFERENCES dbo.NguoiDung(NguoiDungID)
);
GO

/* =========================================================
   9. INDEX CƠ BẢN
   ========================================================= */

CREATE INDEX IX_BaiViet_TrangThai
ON dbo.BaiViet (TrangThaiDuyet, TrangThaiXuatBan, TrangThaiDongBoAI);
GO

CREATE INDEX IX_BaiViet_TieuDeVI
ON dbo.BaiViet (TieuDeVI);
GO

CREATE INDEX IX_BaiViet_TieuDeEN
ON dbo.BaiViet (TieuDeEN);
GO

CREATE INDEX IX_NhatKyCauHoiAI_HoiLuc
ON dbo.NhatKyCauHoiAI (HoiLuc DESC);
GO

CREATE INDEX IX_PhanHoiNguoiDung_TrangThai
ON dbo.PhanHoiNguoiDung (TrangThaiXuLy, GuiLuc DESC);
GO

/* =========================================================
   10. DỮ LIỆU MẪU CƠ BẢN
   ========================================================= */

INSERT INTO dbo.NguoiDung (HoTen, Email, MatKhauHash, VaiTro)
SELECT N'Quản trị viên Nguyễn Văn A', 'admin.vnculturebridge@gmail.com', '$2b$10$LMgvDe.HngByMtMZmcwjjO1FF6EU0lx0IHFkhQ1iy//LTOFV4Nwza', 'ADMIN'
WHERE NOT EXISTS (
    SELECT 1 FROM dbo.NguoiDung WHERE Email = 'admin.vnculturebridge@gmail.com'
);
GO

INSERT INTO dbo.KhachHang (HoTen, Email, MatKhauHash, TrangThai)
SELECT N'Nguyễn Thị Lan', 'khachhang.vnculturebridge@gmail.com', '$2b$10$fy2F2cDPNwhEQi3wli86tulJG2MtJvV/Z.W3ZUbsNJ2hu.XV/VT2i', 'ACTIVE'
WHERE NOT EXISTS (
    SELECT 1 FROM dbo.KhachHang WHERE Email = 'khachhang.vnculturebridge@gmail.com'
);
GO

/* =========================================================
   11. VIEW BÀI VIẾT CÔNG KHAI
   ========================================================= */

CREATE OR ALTER VIEW dbo.vw_BaiVietCongKhai
AS
SELECT
    BaiVietID,
    MaBaiViet,
    TieuDeVI,
    TieuDeEN,
    MoTaNganVI,
    MoTaNganEN,
    NoiDungChinhVI,
    NoiDungChinhEN,
    NgayXuatBan
FROM dbo.BaiViet
WHERE TrangThaiDuyet = 'APPROVED'
  AND TrangThaiXuatBan = 'PUBLISHED';
GO

/* =========================================================
   12. STORED PROCEDURE CỐT LÕI
   ========================================================= */

CREATE OR ALTER PROCEDURE dbo.sp_GuiDuyetBaiViet
    @BaiVietID INT,
    @NguoiDungID INT,
    @GhiChu NVARCHAR(1000) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @TrangThaiCu VARCHAR(20);

    SELECT @TrangThaiCu = TrangThaiDuyet
    FROM dbo.BaiViet
    WHERE BaiVietID = @BaiVietID;

    IF @TrangThaiCu IS NULL
        THROW 50001, N'Không tìm thấy bài viết.', 1;

    IF @TrangThaiCu NOT IN ('DRAFT','REJECTED')
        THROW 50002, N'Chỉ bài viết nháp hoặc bị từ chối mới được gửi duyệt.', 1;

    UPDATE dbo.BaiViet
    SET TrangThaiDuyet = 'PENDING_REVIEW',
        NgayGuiDuyet = SYSUTCDATETIME(),
        CapNhatBoi = @NguoiDungID,
        NgayCapNhat = SYSUTCDATETIME()
    WHERE BaiVietID = @BaiVietID;

    INSERT INTO dbo.LichSuDuyetBaiViet(BaiVietID, HanhDong, TuTrangThai, DenTrangThai, GhiChu, ThucHienBoi)
    VALUES(@BaiVietID, 'SUBMIT_REVIEW', @TrangThaiCu, 'PENDING_REVIEW', @GhiChu, @NguoiDungID);
END
GO

CREATE OR ALTER PROCEDURE dbo.sp_DuyetBaiViet
    @BaiVietID INT,
    @NguoiDungID INT
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE dbo.BaiViet
    SET TrangThaiDuyet = 'APPROVED',
        NgayDuyet = SYSUTCDATETIME(),
        DuyetBoi = @NguoiDungID,
        CapNhatBoi = @NguoiDungID,
        NgayCapNhat = SYSUTCDATETIME()
    WHERE BaiVietID = @BaiVietID;

    INSERT INTO dbo.LichSuDuyetBaiViet(BaiVietID, HanhDong, TuTrangThai, DenTrangThai, ThucHienBoi)
    VALUES(@BaiVietID, 'APPROVE', 'PENDING_REVIEW', 'APPROVED', @NguoiDungID);
END
GO

CREATE OR ALTER PROCEDURE dbo.sp_XuatBanBaiViet
    @BaiVietID INT,
    @NguoiDungID INT
AS
BEGIN
    SET NOCOUNT ON;

    IF NOT EXISTS (
        SELECT 1 FROM dbo.BaiViet
        WHERE BaiVietID = @BaiVietID
          AND TrangThaiDuyet = 'APPROVED'
    )
        THROW 50003, N'Bài viết chưa được duyệt.', 1;

    IF NOT EXISTS (
        SELECT 1 FROM dbo.BaiViet_DanhMuc WHERE BaiVietID = @BaiVietID
    )
        THROW 50004, N'Bài viết phải có ít nhất một danh mục.', 1;

    IF NOT EXISTS (
        SELECT 1 FROM dbo.BaiViet_Vung WHERE BaiVietID = @BaiVietID
    )
    AND NOT EXISTS (
        SELECT 1 FROM dbo.BaiViet_DanToc WHERE BaiVietID = @BaiVietID
    )
        THROW 50005, N'Bài viết phải gắn ít nhất một vùng hoặc một dân tộc.', 1;

    IF EXISTS (
        SELECT 1 FROM dbo.BaiViet
        WHERE BaiVietID = @BaiVietID
          AND (
                TieuDeVI IS NULL OR LTRIM(RTRIM(TieuDeVI)) = N'' OR
                TieuDeEN IS NULL OR LTRIM(RTRIM(TieuDeEN)) = N'' OR
                NoiDungChinhVI IS NULL OR LTRIM(RTRIM(NoiDungChinhVI)) = N'' OR
                NoiDungChinhEN IS NULL OR LTRIM(RTRIM(NoiDungChinhEN)) = N''
              )
    )
        THROW 50006, N'Bài viết phải có đủ nội dung tiếng Việt và tiếng Anh.', 1;

    UPDATE dbo.BaiViet
    SET TrangThaiXuatBan = 'PUBLISHED',
        NgayXuatBan = SYSUTCDATETIME(),
        TrangThaiDongBoAI = 'PENDING',
        CapNhatBoi = @NguoiDungID,
        NgayCapNhat = SYSUTCDATETIME()
    WHERE BaiVietID = @BaiVietID;

    INSERT INTO dbo.LichSuDuyetBaiViet(BaiVietID, HanhDong, TuTrangThai, DenTrangThai, ThucHienBoi)
    VALUES(@BaiVietID, 'PUBLISH', 'APPROVED', 'PUBLISHED', @NguoiDungID);
END
GO

/* =========================================================
   13. TRIGGER:
   NẾU BÀI VIẾT ĐÃ PUBLISH MÀ SỬA NỘI DUNG => AI PHẢI ĐỒNG BỘ LẠI
   ========================================================= */

CREATE OR ALTER TRIGGER dbo.trg_BaiViet_CapNhatAI
ON dbo.BaiViet
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    IF UPDATE(TieuDeVI) OR UPDATE(TieuDeEN)
       OR UPDATE(NoiDungChinhVI) OR UPDATE(NoiDungChinhEN)
       OR UPDATE(GioiThieuVI) OR UPDATE(GioiThieuEN)
       OR UPDATE(NguonGocVI) OR UPDATE(NguonGocEN)
       OR UPDATE(YNghiaVanHoaVI) OR UPDATE(YNghiaVanHoaEN)
    BEGIN
        UPDATE bv
        SET TrangThaiDongBoAI = 'PENDING',
            SanSangChoAI = 0,
            NgayCapNhat = SYSUTCDATETIME()
        FROM dbo.BaiViet bv
        JOIN inserted i ON bv.BaiVietID = i.BaiVietID
        WHERE bv.TrangThaiXuatBan = 'PUBLISHED';
    END
END
GO

/* =========================================================
   14. TỈNH THÀNH / THÀNH PHỐ
   Phục vụ giao diện động cho danh sách và chi tiết tỉnh thành
   ========================================================= */

IF OBJECT_ID('dbo.TinhThanh', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.TinhThanh (
        TinhThanhID              INT IDENTITY(1,1) PRIMARY KEY,
        MaTinh                   VARCHAR(80) NOT NULL UNIQUE,
        TenVI                    NVARCHAR(200) NOT NULL,
        TenEN                    NVARCHAR(200) NOT NULL,
        LoaiTinhVI               NVARCHAR(100) NOT NULL,
        LoaiTinhEN               NVARCHAR(100) NOT NULL,
        VungID                   INT NOT NULL,
        TieuVungVI               NVARCHAR(200) NULL,
        TieuVungEN               NVARCHAR(200) NULL,
        DienTichKm2              DECIMAL(12,2) NULL,
        DanSo                    BIGINT NULL,
        AreaDisplayVI            NVARCHAR(100) NULL,
        AreaDisplayEN            NVARCHAR(100) NULL,
        PopulationDisplayVI      NVARCHAR(100) NULL,
        PopulationDisplayEN      NVARCHAR(100) NULL,
        TagsJsonVI               NVARCHAR(MAX) NULL,
        TagsJsonEN               NVARCHAR(MAX) NULL,
        TagsTextVI               NVARCHAR(1000) NULL,
        TagsTextEN               NVARCHAR(1000) NULL,
        AnhDaiDienUrl            NVARCHAR(1000) NULL,
        AnhDaiDienAltVI          NVARCHAR(500) NULL,
        AnhDaiDienAltEN          NVARCHAR(500) NULL,
        TieuDePhuVI              NVARCHAR(300) NULL,
        TieuDePhuEN              NVARCHAR(300) NULL,
        TongQuanVI               NVARCHAR(MAX) NULL,
        TongQuanEN               NVARCHAR(MAX) NULL,
        ThoiTietMacDinhVI        NVARCHAR(100) NULL,
        ThoiTietMacDinhEN        NVARCHAR(100) NULL,
        ThoiDiemDepVI            NVARCHAR(200) NULL,
        ThoiDiemDepEN            NVARCHAR(200) NULL,
        ThongTinThanhLapVI       NVARCHAR(200) NULL,
        ThongTinThanhLapEN       NVARCHAR(200) NULL,
        ThongTinHanhChinhVI      NVARCHAR(300) NULL,
        ThongTinHanhChinhEN      NVARCHAR(300) NULL,
        MuiGio                   NVARCHAR(50) NULL,
        MaVungDienThoai          NVARCHAR(20) NULL,
        HeroImageUrl             NVARCHAR(1000) NULL,
        HeroImageAltVI           NVARCHAR(500) NULL,
        HeroImageAltEN           NVARCHAR(500) NULL,
        SidebarImageUrl          NVARCHAR(1000) NULL,
        SidebarImageAltVI        NVARCHAR(500) NULL,
        SidebarImageAltEN        NVARCHAR(500) NULL,
        DiaDiemJsonVI            NVARCHAR(MAX) NULL,
        DiaDiemJsonEN            NVARCHAR(MAX) NULL,
        VanHoaJsonVI             NVARCHAR(MAX) NULL,
        VanHoaJsonEN             NVARCHAR(MAX) NULL,
        AmThucJsonVI             NVARCHAR(MAX) NULL,
        AmThucJsonEN             NVARCHAR(MAX) NULL,
        LichTrinhJsonVI          NVARCHAR(MAX) NULL,
        LichTrinhJsonEN          NVARCHAR(MAX) NULL,
        HoatDong                 BIT NOT NULL DEFAULT 1,
        ThuTuHienThi             INT NOT NULL DEFAULT 0,
        NgayTao                  DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
        NgayCapNhat              DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
        CONSTRAINT FK_TinhThanh_VungVanHoa FOREIGN KEY (VungID) REFERENCES dbo.VungVanHoa(VungID)
    );
END
GO

IF NOT EXISTS (
    SELECT 1
    FROM sys.indexes
    WHERE name = 'IX_TinhThanh_Vung_ThuTu'
      AND object_id = OBJECT_ID('dbo.TinhThanh')
)
BEGIN
    CREATE INDEX IX_TinhThanh_Vung_ThuTu ON dbo.TinhThanh (VungID, ThuTuHienThi, HoatDong);
END
GO

IF NOT EXISTS (
    SELECT 1
    FROM sys.indexes
    WHERE name = 'IX_TinhThanh_MaTinh'
      AND object_id = OBJECT_ID('dbo.TinhThanh')
)
BEGIN
    CREATE INDEX IX_TinhThanh_MaTinh ON dbo.TinhThanh (MaTinh, HoatDong);
END
GO



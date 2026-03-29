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
    VungID              INT IDENTITY(1,1) PRIMARY KEY,
    MaVung              VARCHAR(50) NOT NULL UNIQUE,
    TenVI               NVARCHAR(200) NOT NULL,
    TenEN               NVARCHAR(200) NOT NULL,
    LoaiVung            VARCHAR(30) NOT NULL DEFAULT 'CULTURAL_ZONE',
    GeoJson             NVARCHAR(MAX) NULL,
    HoatDong            BIT NOT NULL DEFAULT 1,
    CONSTRAINT CK_VungVanHoa_Loai CHECK (LoaiVung IN ('NORTH','CENTRAL','SOUTH','HIGHLAND','DELTA','CULTURAL_ZONE','OTHER'))
);
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
SELECT N'Quản trị viên', 'admin@vnculturebridge.ai', '123456HASH', 'ADMIN'
WHERE NOT EXISTS (
    SELECT 1 FROM dbo.NguoiDung WHERE Email = 'admin@vnculturebridge.ai'
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



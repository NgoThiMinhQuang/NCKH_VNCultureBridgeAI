-- SCHEMA CHO VN CULTURE BRIDGE AI (MSSQL) - VERSION 5.0 (CLEAN STANDARD)
-- Dựa trên sơ đồ thực thể (ER Diagram) và yêu cầu tinh gọn, thêm module Ẩm thực

-- Xóa các bảng cũ nếu tồn tại (theo thứ tự ràng buộc khóa ngoại)
IF OBJECT_ID('dbo.MauPrompt', 'U') IS NOT NULL DROP TABLE dbo.MauPrompt;
IF OBJECT_ID('dbo.BinhLuan', 'U') IS NOT NULL DROP TABLE dbo.BinhLuan;
IF OBJECT_ID('dbo.HinhAnh', 'U') IS NOT NULL DROP TABLE dbo.HinhAnh;
IF OBJECT_ID('dbo.Media', 'U') IS NOT NULL DROP TABLE dbo.Media;
IF OBJECT_ID('dbo.DanTocSectionItem', 'U') IS NOT NULL DROP TABLE dbo.DanTocSectionItem;
IF OBJECT_ID('dbo.DanTocProfile', 'U') IS NOT NULL DROP TABLE dbo.DanTocProfile;
IF OBJECT_ID('dbo.BaiViet', 'U') IS NOT NULL DROP TABLE dbo.BaiViet;
IF OBJECT_ID('dbo.VanHoa', 'U') IS NOT NULL DROP TABLE dbo.VanHoa;
IF OBJECT_ID('dbo.LeHoi', 'U') IS NOT NULL DROP TABLE dbo.LeHoi;
IF OBJECT_ID('dbo.AmThuc', 'U') IS NOT NULL DROP TABLE dbo.AmThuc;
IF OBJECT_ID('dbo.TinhThanh', 'U') IS NOT NULL DROP TABLE dbo.TinhThanh;
IF OBJECT_ID('dbo.DanToc', 'U') IS NOT NULL DROP TABLE dbo.DanToc;
IF OBJECT_ID('dbo.VungVanHoa', 'U') IS NOT NULL DROP TABLE dbo.VungVanHoa;
IF OBJECT_ID('dbo.DanhMuc', 'U') IS NOT NULL DROP TABLE dbo.DanhMuc;
IF OBJECT_ID('dbo.NguoiDung', 'U') IS NOT NULL DROP TABLE dbo.NguoiDung;

-- 1. Bảng Người dùng
CREATE TABLE dbo.NguoiDung (
    NguoiDungID INT IDENTITY(1,1) PRIMARY KEY,
    TenDangNhap NVARCHAR(100) UNIQUE NOT NULL,
    MatKhau NVARCHAR(255) NOT NULL,
    HoTen NVARCHAR(255),
    Email NVARCHAR(255),
    VaiTro NVARCHAR(50) DEFAULT 'USER',
    AvatarUrl NVARCHAR(512),
    NgayThamGia DATETIME DEFAULT GETDATE()
);

-- 2. Bảng Vùng Văn Hóa
CREATE TABLE dbo.VungVanHoa (
    VungID INT PRIMARY KEY IDENTITY(1,1),
    MaVung NVARCHAR(50) UNIQUE NOT NULL,
    TenVI NVARCHAR(100) NOT NULL,
    TenEN NVARCHAR(100),
    MoTaVI NVARCHAR(MAX),
    MoTaEN NVARCHAR(MAX),
    ImageUrl NVARCHAR(512),
    Icon NVARCHAR(50)
);

-- 3. Bảng Dân Tộc
CREATE TABLE dbo.DanToc (
    DanTocID INT PRIMARY KEY IDENTITY(1,1),
    MaDanToc NVARCHAR(50) UNIQUE NOT NULL,
    TenVI NVARCHAR(100) NOT NULL,
    TenEN NVARCHAR(100),
    PhanLoaiVI NVARCHAR(100),
    PhanLoaiEN NVARCHAR(100),
    DanSo NVARCHAR(100),
    DiaBanCuTruVI NVARCHAR(255),
    DiaBanCuTruEN NVARCHAR(255),
    OverviewVI NVARCHAR(MAX),
    OverviewEN NVARCHAR(MAX),
    LichSuVI NVARCHAR(MAX),
    LichSuEN NVARCHAR(MAX),
    VanHoaVI NVARCHAR(MAX),
    VanHoaEN NVARCHAR(MAX),
    AmThucVI NVARCHAR(MAX),
    AmThucEN NVARCHAR(MAX),
    KienTrucVI NVARCHAR(MAX),
    KienTrucEN NVARCHAR(MAX),
    ImageUrl NVARCHAR(512),
    BannerUrl NVARCHAR(512),
    ThuTuHienThi INT DEFAULT 0
);

-- 4. Bảng Tỉnh Thành
CREATE TABLE dbo.TinhThanh (
    TinhThanhID INT PRIMARY KEY IDENTITY(1,1),
    MaTinh NVARCHAR(50) UNIQUE NOT NULL,
    VungID INT FOREIGN KEY REFERENCES dbo.VungVanHoa(VungID),
    TenVI NVARCHAR(100) NOT NULL,
    TenEN NVARCHAR(100),
    TieuDePhuVI NVARCHAR(255),
    TieuDePhuEN NVARCHAR(255),
    TongQuanVI NVARCHAR(MAX),
    TongQuanEN NVARCHAR(MAX),
    ThoiDiemDepVI NVARCHAR(MAX),
    ThoiDiemDepEN NVARCHAR(MAX),
    AnhDaiDienUrl NVARCHAR(512),
    HeroImageUrl NVARCHAR(512),
    ThuTuHienThi INT DEFAULT 0
);

-- 5. Bảng Ẩm Thực (AmThuc)
CREATE TABLE dbo.AmThuc (
    AmThucID INT PRIMARY KEY IDENTITY(1,1),
    MaMonAn NVARCHAR(50) UNIQUE NOT NULL,
    TenVI NVARCHAR(255) NOT NULL,
    TenEN NVARCHAR(255),
    LoaiMonAnVI NVARCHAR(100),
    LoaiMonAnEN NVARCHAR(100),
    MoTaNganVI NVARCHAR(MAX),
    MoTaNganEN NVARCHAR(MAX),
    NoiDungChiTietVI NVARCHAR(MAX),
    NoiDungChiTietEN NVARCHAR(MAX),
    VungID INT FOREIGN KEY REFERENCES dbo.VungVanHoa(VungID),
    TinhThanhID INT FOREIGN KEY REFERENCES dbo.TinhThanh(TinhThanhID),
    DanTocID INT FOREIGN KEY REFERENCES dbo.DanToc(DanTocID),
    ImageUrl NVARCHAR(512),
    NgayTao DATETIME DEFAULT GETDATE()
);

-- 6. Bảng Lễ Hội (LeHoi)
CREATE TABLE dbo.LeHoi (
    LeHoiID INT PRIMARY KEY IDENTITY(1,1),
    MaLeHoi NVARCHAR(50) UNIQUE NOT NULL,
    TenVI NVARCHAR(255) NOT NULL,
    TenEN NVARCHAR(255),
    ThoiGianVI NVARCHAR(255),
    ThoiGianEN NVARCHAR(255),
    DiaDiemVI NVARCHAR(255),
    DiaDiemEN NVARCHAR(255),
    MoTaNganVI NVARCHAR(MAX),
    MoTaNganEN NVARCHAR(MAX),
    NoiDungChiTietVI NVARCHAR(MAX),
    NoiDungChiTietEN NVARCHAR(MAX),
    VungID INT FOREIGN KEY REFERENCES dbo.VungVanHoa(VungID),
    TinhThanhID INT FOREIGN KEY REFERENCES dbo.TinhThanh(TinhThanhID),
    DanTocID INT FOREIGN KEY REFERENCES dbo.DanToc(DanTocID),
    ImageUrl NVARCHAR(512),
    BannerUrl NVARCHAR(512),
    NgayTao DATETIME DEFAULT GETDATE()
);

-- 7. Bảng Văn Hóa (VanHoa)
CREATE TABLE dbo.VanHoa (
    VanHoaID INT PRIMARY KEY IDENTITY(1,1),
    Ma NVARCHAR(50) UNIQUE NOT NULL,
    Loai NVARCHAR(50), -- KIEN_TRUC, NGHE_THUAT, TRANG_PHUC
    TenVI NVARCHAR(255) NOT NULL,
    TenEN NVARCHAR(255),
    MoTaNganVI NVARCHAR(MAX),
    MoTaNganEN NVARCHAR(MAX),
    NoiDungChiTietVI NVARCHAR(MAX),
    NoiDungChiTietEN NVARCHAR(MAX),
    VungID INT FOREIGN KEY REFERENCES dbo.VungVanHoa(VungID),
    DanTocID INT FOREIGN KEY REFERENCES dbo.DanToc(DanTocID),
    ImageUrl NVARCHAR(512),
    TagsVI NVARCHAR(255),
    TagsEN NVARCHAR(255),
    NgayTao DATETIME DEFAULT GETDATE()
);

-- 8. Bảng Bài Viết (BaiViet)
CREATE TABLE dbo.BaiViet (
    BaiVietID INT PRIMARY KEY IDENTITY(1,1),
    MaBaiViet NVARCHAR(50) UNIQUE NOT NULL,
    TieuDeVI NVARCHAR(255) NOT NULL,
    TieuDeEN NVARCHAR(255),
    MoTaNganVI NVARCHAR(MAX),
    MoTaNganEN NVARCHAR(MAX),
    NoiDungVI NVARCHAR(MAX),
    NoiDungEN NVARCHAR(MAX),
    TacGia NVARCHAR(100),
    NgayXuatBan DATETIME DEFAULT GETDATE(),
    ImageUrl NVARCHAR(512),
    ChuyenMuc NVARCHAR(50), -- DU_LICH, VAN_HOA, AM_THUC, TIN_TUC
    VungID INT FOREIGN KEY REFERENCES dbo.VungVanHoa(VungID),
    TinhThanhID INT FOREIGN KEY REFERENCES dbo.TinhThanh(TinhThanhID),
    DanTocID INT FOREIGN KEY REFERENCES dbo.DanToc(DanTocID),
    LeHoiID INT FOREIGN KEY REFERENCES dbo.LeHoi(LeHoiID),
    VanHoaID INT FOREIGN KEY REFERENCES dbo.VanHoa(VanHoaID),
    AmThucID INT FOREIGN KEY REFERENCES dbo.AmThuc(AmThucID)
);

-- 9. Bảng Hình Ảnh (HinhAnh)
CREATE TABLE dbo.HinhAnh (
    HinhAnhID INT PRIMARY KEY IDENTITY(1,1),
    Url NVARCHAR(512) NOT NULL,
    MoTaVI NVARCHAR(MAX),
    MoTaEN NVARCHAR(MAX),
    ThuTu INT DEFAULT 0,
    VungID INT FOREIGN KEY REFERENCES dbo.VungVanHoa(VungID),
    TinhThanhID INT FOREIGN KEY REFERENCES dbo.TinhThanh(TinhThanhID),
    DanTocID INT FOREIGN KEY REFERENCES dbo.DanToc(DanTocID),
    LeHoiID INT FOREIGN KEY REFERENCES dbo.LeHoi(LeHoiID),
    VanHoaID INT FOREIGN KEY REFERENCES dbo.VanHoa(VanHoaID),
    BaiVietID INT FOREIGN KEY REFERENCES dbo.BaiViet(BaiVietID),
    AmThucID INT FOREIGN KEY REFERENCES dbo.AmThuc(AmThucID)
);

-- 10. Bảng Bình Luận (BinhLuan)
CREATE TABLE dbo.BinhLuan (
    BinhLuanID INT IDENTITY(1,1) PRIMARY KEY,
    NguoiDungID INT FOREIGN KEY REFERENCES dbo.NguoiDung(NguoiDungID),
    BaiVietID INT FOREIGN KEY REFERENCES dbo.BaiViet(BaiVietID),
    NoiDung NVARCHAR(MAX) NOT NULL,
    NgayBinhLuan DATETIME DEFAULT GETDATE(),
    TrangThai NVARCHAR(50) DEFAULT 'APPROVED'
);

-- 11. Bảng Mẫu Prompt AI
CREATE TABLE dbo.MauPrompt (
    MauPromptID INT IDENTITY(1,1) PRIMARY KEY,
    MaPrompt NVARCHAR(50) UNIQUE NOT NULL,
    LoaiPrompt NVARCHAR(50),
    TenPrompt NVARCHAR(255),
    NoiDungPrompt NVARCHAR(MAX)
);

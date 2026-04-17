<<<<<<< HEAD
-- FILE DA CHUAN HOA: schema + seed data + dong bo quan he theo ma nghiep vu
=======
﻿-- FILE DA CHUAN HOA: schema + seed data + dong bo quan he theo ma nghiep vu
>>>>>>> 8bd5aa804c68e4ff099328f85cdcf7830e074494

-- SCHEMA CHO VN CULTURE BRIDGE AI (MSSQL) - VERSION 5.0 (CLEAN STANDARD)
-- Dựa trên sơ đồ thực thể (ER Diagram) và yêu cầu tinh gọn, thêm module Ẩm thực

-- Xóa các bảng cũ nếu tồn tại (theo thứ tự ràng buộc khóa ngoại)
<<<<<<< HEAD
DECLARE @Sql NVARCHAR(MAX) = '';
SELECT @Sql += 'ALTER TABLE ' + QUOTENAME(OBJECT_SCHEMA_NAME(parent_object_id)) + '.' + QUOTENAME(OBJECT_NAME(parent_object_id)) + 
    ' DROP CONSTRAINT ' + QUOTENAME(name) + ';'
FROM sys.foreign_keys;
EXEC sp_executesql @Sql;
=======
>>>>>>> 8bd5aa804c68e4ff099328f85cdcf7830e074494
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

<<<<<<< HEAD
=======
EXEC sp_MSforeachtable 'ALTER TABLE ? NOCHECK CONSTRAINT ALL';
EXEC sp_MSforeachtable 'DELETE FROM ?';
EXEC sp_MSforeachtable 'ALTER TABLE ? CHECK CONSTRAINT ALL';

ALTER TABLE dbo.BaiViet
ALTER COLUMN MaBaiViet NVARCHAR(100)

>>>>>>> 8bd5aa804c68e4ff099328f85cdcf7830e074494
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
<<<<<<< HEAD
    MaBaiViet NVARCHAR(255) UNIQUE NOT NULL,
=======
    MaBaiViet NVARCHAR(50) UNIQUE NOT NULL,
>>>>>>> 8bd5aa804c68e4ff099328f85cdcf7830e074494
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

<<<<<<< HEAD
=======

>>>>>>> 8bd5aa804c68e4ff099328f85cdcf7830e074494
INSERT INTO dbo.VungVanHoa (MaVung, TenVI, TenEN, MoTaVI, MoTaEN, ImageUrl, Icon) VALUES
('BAC_BO', N'Bắc Bộ', 'Northern Vietnam', 
N'Vùng đất ngàn năm văn hiến, nơi lưu giữ tinh hoa văn hóa lúa nước và các di sản lịch sử lâu đời.', 
'A millennium-old land of civilization, preserving the essence of wet rice culture and long-standing historical heritage.', 
'https://vj-prod-website-cms.s3.ap-southeast-1.amazonaws.com/2294820181canhdepmienbac-1711070654909.jpg', '⛰️'),
('TRUNG_BO', N'Trung Bộ', 'Central Vietnam', 
N'Mảnh đất di sản miền Trung với những cố đô cổ kính, hang động kỳ vĩ và bờ biển tuyệt đẹp.', 
'The heritage land of Central Vietnam with ancient capitals, majestic caves, and stunning beaches.', 
'https://ktmt.vnmediacdn.com/images/2020/11/08/9-1604805974-da-nang.jpg', '🏮'),
('NAM_BO', N'Nam Bộ', 'Southern Vietnam', 
N'Vùng đất chín rồng trù phú, năng động với văn hóa sông nước đặc trưng và tính cách con người hào sảng.', 
'The fertile and dynamic Land of Nine Dragons, featuring unique river culture and generous personalities.', 
'https://baocantho.com.vn/image/fckeditor/upload/2024/20240724/images/L%201.webp', '🌿');


----------------------------------------------- THÊM DỮ LIỆU CHO BẢNG DÂN TỘC ---------------------------------------------------------------

INSERT INTO dbo.DanToc
(
    MaDanToc,
    TenVI,
    TenEN,
    PhanLoaiVI,
    PhanLoaiEN,
    DanSo,
    DiaBanCuTruVI,
    DiaBanCuTruEN,
    OverviewVI,
    OverviewEN,
    LichSuVI,
    LichSuEN,
    VanHoaVI,
    VanHoaEN,
    AmThucVI,
    AmThucEN,
    KienTrucVI,
    KienTrucEN,
    ImageUrl,
    BannerUrl,
    ThuTuHienThi
)
VALUES
(
    'KINH',
    N'Kinh',
    N'Kinh',
    N'Dân tộc đa số',
    N'Majority ethnic group',
    N'82.1M+',
    N'Phân bố rộng khắp trên toàn lãnh thổ Việt Nam, tập trung đông tại các đồng bằng lớn, vùng ven biển, các trung tâm đô thị và hầu hết các khu vực kinh tế trọng điểm của cả nước.',
    N'Widely distributed throughout Vietnam, with major concentrations in the country''s large deltas, coastal areas, urban centers, and most key economic regions.',
    N'Dân tộc Kinh là cộng đồng cư dân chiếm số lượng lớn nhất trong cơ cấu dân số Việt Nam và giữ vai trò trung tâm trong tiến trình hình thành, phát triển của quốc gia Việt Nam qua nhiều thời kỳ lịch sử. Người Kinh gắn bó mật thiết với nền văn minh lúa nước, với các vùng châu thổ lớn như đồng bằng sông Hồng và đồng bằng sông Cửu Long, đồng thời có mặt ở hầu hết các không gian cư trú, từ nông thôn, miền biển đến đô thị hiện đại. Trong đời sống đương đại, người Kinh không chỉ là lực lượng dân cư đông đảo nhất mà còn là cộng đồng có ảnh hưởng sâu rộng trong các lĩnh vực chính trị, kinh tế, giáo dục, ngôn ngữ, văn học nghệ thuật và tổ chức xã hội. Hệ thống phong tục, tín ngưỡng, lễ hội, nếp sống gia đình và văn hóa vật chất của người Kinh có vai trò rất lớn trong việc tạo nên diện mạo chung của văn hóa Việt Nam.',
    N'The Kinh are the largest ethnic community in Vietnam and have played a central role in the formation and development of the Vietnamese nation across many historical periods. They are closely associated with wet-rice civilization and with major delta regions such as the Red River Delta and the Mekong Delta, while also being present in nearly all settlement environments, from rural plains and coastal zones to modern urban centers. In contemporary life, the Kinh are not only the largest population group but also the community with the widest influence on politics, economy, education, language, literature, the arts, and social institutions. Their customs, beliefs, festivals, family patterns, and material culture contribute significantly to the overall cultural identity of Vietnam.',
    N'Lịch sử của người Kinh gắn chặt với sự phát triển lâu dài của các cộng đồng cư dân nông nghiệp ở lưu vực sông Hồng và quá trình hình thành các nhà nước sơ khai của người Việt cổ. Từ thời Văn Lang, Âu Lạc cho đến các triều đại phong kiến độc lập, cộng đồng cư dân mà về sau phát triển thành người Kinh đã đóng vai trò nòng cốt trong việc hình thành nhà nước, phát triển nông nghiệp lúa nước, mở rộng hệ thống làng xã, phát triển thủ công nghiệp và xây dựng các trung tâm văn hóa - chính trị quan trọng. Trong tiến trình lịch sử, người Kinh cũng là lực lượng chủ đạo trong quá trình Nam tiến, mở rộng không gian cư trú về miền Trung và Nam Bộ, đồng thời diễn ra quá trình giao lưu văn hóa sâu rộng với nhiều cộng đồng cư dân khác. Qua thời kỳ cận đại và hiện đại, người Kinh tiếp tục giữ vai trò chủ lực trong các phong trào chống ngoại xâm, trong công cuộc hiện đại hóa và trong việc hình thành bản sắc quốc gia Việt Nam ngày nay.',
    N'The history of the Kinh is closely tied to the long development of agricultural communities in the Red River basin and to the formation of early Vietnamese states. From the era of Van Lang and Au Lac to the independent dynastic periods, the population that later became known as the Kinh played a core role in state formation, wet-rice agriculture, village development, craft production, and the rise of major political and cultural centers. Over the centuries, the Kinh were also central to the southward expansion of settlement into Central and Southern Vietnam, a process accompanied by extensive cultural interaction with many other communities. In the modern era, the Kinh remained the leading social force in anti-colonial struggles, national development, and the shaping of contemporary Vietnamese identity.',
    N'Văn hóa Kinh có nền tảng sâu đậm từ văn minh nông nghiệp lúa nước và cấu trúc làng xã truyền thống. Nhiều yếu tố tiêu biểu của văn hóa Việt Nam như tục thờ cúng tổ tiên, đình làng, chùa, đền, các lễ hội đầu xuân, nghi lễ vòng đời, dân ca quan họ, chèo, tuồng, ca trù, áo dài và nếp sống gia đình nhiều thế hệ đều gắn bó mạnh mẽ với người Kinh. Văn hóa Kinh vừa có tính kế thừa lâu dài, vừa có khả năng tiếp nhận và chuyển hóa ảnh hưởng từ Phật giáo, Nho giáo, Đạo giáo, văn hóa phương Tây và các dòng chảy hiện đại. Nhờ đó, đây là một nền văn hóa có tính liên tục cao nhưng cũng rất linh hoạt trong quá trình phát triển.',
    N'Kinh culture is deeply rooted in wet-rice civilization and traditional village organization. Many iconic features of Vietnamese culture, such as ancestor worship, communal houses, pagodas, temples, spring festivals, life-cycle rituals, quan ho singing, cheo, tuong, ca tru, the ao dai, and multi-generational family life, are strongly associated with the Kinh. Kinh culture combines long-term continuity with a strong capacity to absorb and transform influences from Buddhism, Confucianism, Taoism, Western culture, and modern currents. As a result, it is both highly continuous and highly adaptive.',
    N'Ẩm thực của người Kinh rất đa dạng theo vùng miền và được xem là nền tảng quan trọng của bản đồ ẩm thực Việt Nam. Ở miền Bắc, ẩm thực thường thiên về sự thanh nhã, cân bằng và tinh tế, với các món tiêu biểu như phở, bún chả, bánh cuốn, chả cá, bánh chưng. Ở miền Trung, món ăn thường đậm đà hơn, chú trọng gia vị, cách trình bày và cấu trúc bữa ăn, tiêu biểu như bún bò Huế, mì Quảng, bánh bèo, bánh nậm, bánh lọc. Ở miền Nam, ẩm thực Kinh có xu hướng phong phú, hào sảng, sử dụng nhiều nguyên liệu sông nước, vườn cây và hải sản, với các món như cơm tấm, hủ tiếu, cá kho tộ, lẩu mắm, bánh xèo Nam Bộ. Nhìn chung, ẩm thực Kinh thể hiện rất rõ khả năng thích nghi với điều kiện địa lý và sự tinh tế trong tổ chức đời sống thường nhật.',
    N'Kinh cuisine varies widely by region and forms a major foundation of Vietnamese culinary identity. In the North, it is often marked by elegance, balance, and restraint, with dishes such as pho, bun cha, banh cuon, cha ca, and banh chung. In Central Vietnam, cuisine tends to be more intense and elaborate in seasoning and presentation, with dishes such as bun bo Hue, mi Quang, banh beo, banh nam, and banh loc. In the South, Kinh cuisine is generally more abundant and open in style, making rich use of river produce, fruits, and seafood, with dishes such as com tam, hu tieu, braised fish in clay pot, fermented fish hotpot, and southern banh xeo. Overall, it reflects both environmental adaptation and refined everyday food culture.',
    N'Kiến trúc của người Kinh rất đa dạng, từ nhà ở dân gian đến công trình tín ngưỡng, hành chính và cung đình. Ở đồng bằng Bắc Bộ, nhà ba gian hai chái, sân gạch, vườn cây là mô hình cư trú quen thuộc. Ở miền Trung có nhà rường với kết cấu gỗ chặt chẽ, còn Nam Bộ có kiểu nhà thoáng hơn, thích nghi với khí hậu nóng ẩm và hệ thống sông rạch. Trong đời sống cộng đồng, người Kinh xây dựng hệ thống đình, chùa, đền, miếu, văn miếu và lăng tẩm rất phong phú. Đặc biệt, kiến trúc cung đình của các triều đại Việt Nam, nhất là thời Nguyễn, là một thành tựu nổi bật về nghệ thuật và tổ chức không gian kiến trúc.',
    N'Kinh architecture is highly varied, ranging from vernacular housing to religious, administrative, and royal structures. In the northern delta, the familiar model is the three-compartment house with tiled roof, brick courtyard, and garden. In Central Vietnam, timber ruong houses are notable for their refined structural systems, while in the South housing tends to be more open and adapted to humid weather and canal environments. In communal life, the Kinh developed a rich system of communal houses, pagodas, temples, shrines, literary sanctuaries, and royal tombs. Court architecture, especially under the Nguyen dynasty, remains one of the most significant achievements in Vietnamese architectural history.',
    N'https://cdn.haitrieu.com/wp-content/uploads/2021/07/Hinh-anh-y-nghia-ta-ao-dai-truyen-thong-viet-nam.png',
    N'https://routine-db.s3.amazonaws.com/prod/media/ao-dai-viet-nam-jpg-mfx4.webp',
    1
),
(
    'KHMER',
    N'Khmer',
    N'Khmer',
    N'Dân tộc thiểu số',
    N'Ethnic minority',
    N'1.3M+',
    N'Phân bố chủ yếu tại đồng bằng sông Cửu Long, đặc biệt ở Sóc Trăng, Trà Vinh, Cần Thơ, An Giang, Kiên Giang và một số địa bàn lân cận.',
    N'Primarily distributed in the Mekong Delta, especially in Soc Trang, Tra Vinh, Can Tho, An Giang, Kien Giang, and nearby areas.',
    N'Người Khmer là một trong những cộng đồng dân tộc thiểu số có ảnh hưởng văn hóa sâu đậm nhất ở Nam Bộ. Với lịch sử cư trú lâu đời tại đồng bằng sông Cửu Long, người Khmer đã hình thành nên các phum, sóc, hệ thống chùa Nam tông, tập quán sinh hoạt cộng đồng và một kho tàng lễ hội, nghệ thuật dân gian rất phong phú. Sự hiện diện của cộng đồng Khmer góp phần tạo nên diện mạo đa dạng, nhiều lớp lang của văn hóa miền Tây Nam Bộ. Trong đời sống hiện đại, người Khmer vừa bảo tồn được bản sắc riêng về ngôn ngữ, tôn giáo, trang phục và nghi lễ, vừa có vai trò ngày càng tích cực trong các lĩnh vực kinh tế, giáo dục và văn hóa ở địa phương.',
    N'The Khmer are one of the most culturally influential ethnic minority communities in Southern Vietnam. With a long history of settlement in the Mekong Delta, they established village clusters, Theravada Buddhist temples, communal traditions, and a rich body of festivals and folk arts. Their presence contributes strongly to the layered cultural identity of the southwestern region. In modern life, Khmer communities continue to preserve their distinctive language, religion, dress, and ritual practices while also taking an increasingly active role in local economy, education, and public life.',
    N'Lịch sử của người Khmer ở Việt Nam gắn với vùng hạ lưu sông Mekong và các khu vực đồng bằng, ven sông, ven biển thuộc Nam Bộ. Đây là một cộng đồng cư trú lâu đời, từng hình thành nhiều trung tâm sinh hoạt văn hóa và tôn giáo ổn định trước khi các quá trình giao lưu dân cư diễn ra mạnh mẽ như hiện nay. Qua nhiều biến động lịch sử, người Khmer vẫn duy trì được hệ thống chữ viết, ngôn ngữ, chùa chiền và các thực hành tín ngưỡng riêng, cho thấy sức sống bền bỉ của bản sắc văn hóa cộng đồng. Lịch sử của người Khmer cũng là một phần không thể tách rời trong lịch sử hình thành vùng Nam Bộ hiện đại.',
    N'The history of the Khmer in Vietnam is closely linked to the lower Mekong and the riverine, deltaic, and coastal zones of Southern Vietnam. They are a long-established community that created stable cultural and religious centers before the more intensive population interactions of later centuries. Through many historical changes, the Khmer preserved their writing system, language, temple institutions, and distinctive ritual practices, showing the resilience of their communal identity. Khmer history is therefore an inseparable part of the historical formation of the modern South of Vietnam.',
    N'Văn hóa Khmer nổi bật ở hệ thống chùa Phật giáo Nam tông, nơi vừa là không gian tôn giáo vừa là trung tâm giáo dục, bảo tồn tri thức và tổ chức sinh hoạt cộng đồng. Các lễ hội lớn như Chol Chnam Thmay, Sen Dolta, Ok Om Bok và đua ghe Ngo là những biểu hiện tập trung nhất của bản sắc Khmer Nam Bộ. Bên cạnh đó, người Khmer còn có nghệ thuật sân khấu Dù kê, Rô băm, nhạc ngũ âm, múa truyền thống, trang phục lễ nghi và nhiều nghề thủ công dân gian mang dấu ấn rõ rệt. Văn hóa Khmer có sự kết hợp hài hòa giữa tính cộng đồng, tín ngưỡng Phật giáo và nhịp sống nông nghiệp của vùng đồng bằng.',
    N'Khmer culture is especially distinguished by Theravada Buddhist temples, which function not only as religious institutions but also as centers of education, knowledge preservation, and communal life. Major festivals such as Chol Chnam Thmay, Sen Dolta, Ok Om Bok, and ngo boat racing are among the clearest expressions of Southern Khmer identity. In addition, Khmer communities maintain Dù kê and Rô băm theater, five-tone music, traditional dance, ceremonial dress, and a range of local crafts. Khmer culture combines communal life, Buddhist belief, and the agricultural rhythms of the delta in a highly integrated way.',
    N'Ẩm thực Khmer mang dấu ấn riêng với việc sử dụng nhiều nguyên liệu đồng bằng, thủy sản nước ngọt, dừa, các loại mắm và gia vị có hương vị đậm đà. Một số món ăn tiêu biểu như bún nước lèo, cốm dẹp, cà ri Khmer, bánh ống, các món mắm và nhiều loại bánh dùng trong dịp lễ phản ánh rất rõ lối sống cộng đồng và không gian văn hóa Nam Bộ. Nhiều món ăn không chỉ mang giá trị dinh dưỡng mà còn gắn chặt với nghi lễ, chùa chiền và các dịp lễ hội truyền thống. Vì vậy, ẩm thực Khmer vừa là một hệ món phong phú, vừa là một phần quan trọng của ký ức văn hóa cộng đồng.',
    N'Khmer cuisine has a distinctive identity shaped by delta ingredients, freshwater resources, coconut, fermented products, and strongly flavored local seasonings. Representative dishes such as bun nuoc leo, flattened young rice, Khmer curry, tube cakes, fermented specialties, and ritual pastries reflect communal life and the broader cultural setting of Southern Vietnam. Many foods are not only everyday dishes but are also deeply tied to festivals, temple life, and ceremonial occasions. Khmer cuisine is therefore both a rich culinary system and a major part of communal cultural memory.',
    N'Kiến trúc Khmer nổi bật nhất ở hệ thống chùa Nam tông với mái nhiều tầng, đầu đao cong, phù điêu trang trí, tháp cốt và màu sắc rực rỡ. Mỗi ngôi chùa thường là một quần thể gồm chánh điện, sala, cổng, tháp và không gian sinh hoạt cộng đồng. Không chỉ có giá trị tôn giáo, kiến trúc Khmer còn thể hiện trình độ thẩm mỹ cao, trí tưởng tượng phong phú và một hệ biểu tượng riêng gắn với Phật giáo và văn hóa bản địa. Đây là một trong những kiểu kiến trúc dễ nhận biết nhất ở đồng bằng sông Cửu Long.',
    N'Khmer architecture is most clearly expressed in Theravada temple complexes with multi-tiered roofs, curved finials, decorative reliefs, cremation towers, and vivid colors. A typical temple complex includes a main sanctuary, community hall, ceremonial gate, towers, and spaces for communal activity. Beyond religious value, Khmer architecture demonstrates sophisticated aesthetics, rich symbolic imagination, and a visual language tied to Buddhism and local tradition. It is one of the most recognizable architectural forms in the Mekong Delta.',
    N'https://img.cand.com.vn/resize/800x800/NewFiles/Images/2023/09/03/Khmer_7-1693700278917.jpg',
    N'https://ati.net.vn/wp-content/uploads/2023/06/trang-phuc-dan-toc-khmer.jpg',
    2
),
(
    'CHAM',
    N'Chăm',
    N'Cham',
    N'Dân tộc thiểu số',
    N'Ethnic minority',
    N'179K+',
    N'Phân bố chủ yếu tại khu vực Nam Trung Bộ, đặc biệt ở vùng Ninh Thuận cũ, Bình Thuận cũ; ngoài ra còn có một bộ phận cư trú tại An Giang và một số địa bàn khác.',
    N'Primarily distributed in South Central Vietnam, especially in the former Ninh Thuan and Binh Thuan areas, with additional communities in An Giang and several other places.',
    N'Người Chăm là một trong những cộng đồng dân tộc có bản sắc văn hóa rõ nét và có chiều sâu lịch sử rất đặc biệt ở Việt Nam. Gắn với di sản của vương quốc Champa, người Chăm hiện nay vẫn bảo tồn được nhiều yếu tố quan trọng về ngôn ngữ, tín ngưỡng, lễ hội, nghệ thuật trình diễn, nghề thủ công và cấu trúc cộng đồng. Cộng đồng Chăm tạo nên một lớp văn hóa đặc sắc cho miền Trung và một phần Nam Bộ, đặc biệt ở những vùng còn lưu giữ hệ thống tháp Chăm, làng nghề truyền thống và các nghi lễ đặc trưng. Đây là một trong những cộng đồng có mức độ nhận diện văn hóa cao nhất trong bức tranh dân tộc học Việt Nam.',
    N'The Cham are one of the ethnic communities in Vietnam with the most distinctive cultural identity and one of the deepest historical backgrounds. Linked to the legacy of the Champa kingdom, Cham communities today continue to preserve important elements of language, religion, festivals, performance traditions, craft production, and communal organization. They add a distinctive cultural layer to Central Vietnam and parts of the South, especially in areas where Cham towers, traditional craft villages, and ceremonial life remain strong. The Cham are among the most culturally recognizable ethnic communities in Vietnam.',
    N'Lịch sử của người Chăm gắn với vương quốc Champa từng tồn tại trong nhiều thế kỷ dọc dải đất miền Trung. Đây là một cộng đồng có truyền thống phát triển nhà nước, thương mại biển, nghệ thuật, tôn giáo và kiến trúc rất đặc sắc trong lịch sử khu vực Đông Nam Á. Sau những biến động về chính trị và lãnh thổ, người Chăm không còn tồn tại như một vương quốc độc lập, nhưng nhiều yếu tố của nền văn minh Champa vẫn tiếp tục được duy trì trong cộng đồng hiện nay. Tháp Chăm, lễ hội, tín ngưỡng Bàlamôn, Bani và Hồi giáo, cùng các nghề thủ công và âm nhạc truyền thống là những minh chứng sống động cho sức bền của di sản đó.',
    N'The history of the Cham is tied to the Champa kingdom, which existed for centuries along the central coast of present-day Vietnam. It was a community with strong traditions of statehood, maritime trade, religion, art, and architecture in the wider Southeast Asian context. After major political and territorial changes, the Cham no longer existed as an independent kingdom, yet many features of Champa civilization survived within present-day communities. Cham towers, festivals, Brahman, Bani, and Islamic traditions, as well as crafts and music, remain vivid evidence of that enduring heritage.',
    N'Văn hóa Chăm nổi bật với tính đa dạng tôn giáo và chiều sâu nghi lễ. Trong cộng đồng Chăm hiện nay có các nhóm Chăm Bàlamôn, Chăm Bani và Chăm theo Hồi giáo, tạo nên nhiều khác biệt trong lễ nghi, lịch sinh hoạt tôn giáo và đời sống cộng đồng. Các lễ hội lớn như Kate, Ramawan là những thời điểm tập trung cao độ của đời sống văn hóa Chăm. Bên cạnh đó là nghệ thuật múa Chăm, âm nhạc lễ nghi, nghề gốm, dệt thổ cẩm, trang phục truyền thống và một hệ thống biểu tượng gắn chặt với tháp, thần linh, tổ tiên. Văn hóa Chăm vừa có tính linh thiêng, vừa giàu chất thẩm mỹ và ký ức lịch sử.',
    N'Cham culture is distinguished by religious diversity and ritual depth. Contemporary Cham communities include Brahman, Bani, and Muslim groups, creating different ceremonial calendars, religious practices, and forms of communal life. Major festivals such as Kate and Ramawan are concentrated expressions of Cham cultural life. Alongside these are Cham dance, ritual music, pottery, brocade weaving, traditional dress, and a rich symbolic system connected with towers, deities, and ancestors. Cham culture is both deeply sacred and aesthetically powerful, while also carrying strong historical memory.',
    N'Ẩm thực Chăm mang dấu ấn khí hậu khô nóng của miền Trung, cùng với ảnh hưởng rõ rệt của tôn giáo và sinh hoạt cộng đồng. Nhiều món ăn sử dụng gia vị riêng, các loại bánh truyền thống, thịt, cá và các nguyên liệu địa phương theo mùa. Ẩm thực Chăm không chỉ hiện diện trong bữa ăn thường ngày mà còn gắn với nghi lễ, lễ hội và đời sống gia đình. Vì vậy, nó thể hiện không chỉ kỹ thuật nấu nướng mà còn phản ánh nhịp sống tôn giáo, điều kiện tự nhiên và cấu trúc xã hội của cộng đồng Chăm.',
    N'Cham cuisine reflects the dry climate of Central Vietnam together with the influence of religion and communal life. Many dishes feature distinctive seasonings, ceremonial cakes, meat, fish, and seasonal local ingredients. Cham food is not limited to everyday meals but is also strongly tied to rituals, festivals, and family life. It therefore reflects not only culinary technique but also religious rhythm, ecological adaptation, and social structure within Cham communities.',
    N'Kiến trúc Chăm là một trong những thành tựu nổi bật nhất của di sản văn hóa Việt Nam, đặc biệt qua hệ thống tháp Chăm xây bằng gạch với kỹ thuật xây dựng và nghệ thuật trang trí rất đặc sắc. Các cụm tháp vừa là trung tâm tôn giáo, vừa là biểu tượng của ký ức lịch sử Champa. Ngoài ra, không gian cư trú của người Chăm cũng phản ánh rõ điều kiện tự nhiên khô nóng, cấu trúc gia đình và nhịp sống cộng đồng. Kiến trúc Chăm có giá trị đặc biệt vì vừa mang ý nghĩa lịch sử, vừa có giá trị mỹ thuật và khảo cổ rất cao.',
    N'Cham architecture is among the most remarkable achievements of Vietnamese cultural heritage, especially in its brick tower complexes with highly distinctive construction techniques and decorative programs. These towers functioned as religious centers and remain symbols of Champa historical memory. Beyond monumental architecture, Cham domestic space also reflects dry environmental conditions, family patterns, and communal life. Cham architecture is especially important because it carries historical meaning while also possessing major artistic and archaeological value.',
    N'https://files.bdttg.gov.vn/contentfolder/ubdt/source_files/2015/11/04/10261048_ng%C6%B0%E1%BB%9Di%20ch%C4%83m_15-11-04.jpg',
    N'https://file.hstatic.net/200000503583/file/trang-phuc-dan-toc-cham-3_0e3dad4924b940bd8c976eadecdf5de0.jpg',
    3
),
(
    'MONG',
    N'Mông',
    N'Hmong',
    N'Dân tộc thiểu số',
    N'Ethnic minority',
    N'1.4M+',
    N'Phân bố chủ yếu tại các tỉnh miền núi cao phía Bắc như Lào Cai, Điện Biên, Lai Châu, Sơn La và nhiều khu vực núi cao khác.',
    N'Primarily distributed in northern high mountain provinces such as Lao Cai, Dien Bien, Lai Chau, Son La, and other upland areas.',
    N'Người Mông là một trong những cộng đồng dân tộc thiểu số có bản sắc nổi bật nhất ở vùng núi cao phía Bắc Việt Nam. Cộng đồng này thường cư trú tại những khu vực địa hình cao, dốc và khí hậu khắc nghiệt, từ đó hình thành nên một lối sống có khả năng thích nghi rất mạnh với môi trường tự nhiên. Người Mông nổi bật với trang phục truyền thống nhiều màu sắc, kỹ thuật vẽ sáp ong, chợ phiên vùng cao, tiếng khèn, lễ hội đầu năm và đời sống cộng đồng gắn bó với núi rừng. Trong bức tranh văn hóa vùng cao Việt Nam, người Mông là một trong những cộng đồng có sức nhận diện mạnh cả về hình ảnh lẫn chiều sâu phong tục.',
    N'The Hmong are one of the most distinctive ethnic minority communities in the high mountains of northern Vietnam. They usually inhabit elevated, steep, and climatically difficult areas, which has shaped a way of life strongly adapted to the natural environment. The Hmong are especially known for colorful traditional dress, batik techniques, upland markets, khen music, early-year festivals, and a communal life deeply tied to mountain landscapes. Within the cultural map of upland Vietnam, they are one of the most recognizable communities in both visual identity and social tradition.',
    N'Lịch sử của người Mông ở Việt Nam gắn với quá trình cư trú lâu dài tại các vùng núi cao phía Bắc, nơi cộng đồng phát triển những phương thức sản xuất, tổ chức xã hội và thực hành văn hóa phù hợp với địa hình khắc nghiệt. Trong suốt nhiều thế hệ, người Mông đã hình thành các bản làng tương đối biệt lập, từ đó duy trì được tiếng nói, phong tục, tập quán và hệ giá trị cộng đồng rất riêng. Dù chịu tác động mạnh của các biến đổi kinh tế - xã hội hiện đại, người Mông vẫn là một trong những cộng đồng giữ được bản sắc rất rõ ràng trong trang phục, nghi lễ, âm nhạc và cấu trúc đời sống gia đình.',
    N'The history of the Hmong in Vietnam is tied to long-term settlement in the northern highlands, where communities developed forms of production, social organization, and cultural practice suited to rugged terrain. Over many generations, the Hmong formed relatively distinct villages and were able to preserve their language, customs, and communal values. Despite strong pressures from modern socio-economic change, the Hmong remain one of the communities that have maintained a particularly clear identity in dress, ritual, music, and family structure.',
    N'Văn hóa Mông nổi bật với trang phục thổ cẩm, nghệ thuật vẽ sáp ong, chợ phiên vùng cao, khèn Mông, múa khèn, lễ hội Gầu Tào và nhiều phong tục gắn với vòng đời con người. Không gian văn hóa Mông vừa mạnh mẽ vừa giàu tính biểu tượng, phản ánh đời sống trên núi đá, nương rẫy, nhà trình tường và những cộng đồng gắn kết chặt chẽ. Các hình thức sinh hoạt cộng đồng của người Mông thường thể hiện rõ tính tự chủ, tinh thần bền bỉ và ý thức giữ gìn bản sắc. Đây là một trong những nền văn hóa dân tộc có sức hấp dẫn rất lớn về chiều sâu nhân học và hình ảnh.',
    N'Hmong culture is especially known for brocade clothing, batik wax-resist decoration, upland market traditions, the Hmong khen, khen dance, the Gau Tao Festival, and many customs related to the life cycle. Hmong cultural space is both powerful and highly symbolic, reflecting life among rocky mountains, upland fields, rammed-earth houses, and tightly bonded communities. Their communal practices often show a high degree of autonomy, resilience, and commitment to preserving identity. It is one of the most compelling ethnic cultures in Vietnam from both anthropological and visual perspectives.',
    N'Ẩm thực Mông phản ánh điều kiện sinh thái vùng núi cao và lối sống nông nghiệp - chăn nuôi. Ngô là lương thực quan trọng, thể hiện qua các món như mèn mén, bánh ngô, rượu ngô. Ngoài ra, các món như thắng cố, thịt hun khói, canh rau rừng, thực phẩm sấy hoặc treo gác bếp cho thấy cách cộng đồng thích nghi với khí hậu lạnh và điều kiện đi lại khó khăn. Ẩm thực Mông nhìn chung không cầu kỳ trong trình bày nhưng có chiều sâu về công năng, ký ức cộng đồng và môi trường sống.',
    N'Hmong cuisine reflects high-mountain ecology and an agro-pastoral way of life. Corn is a key staple, as seen in foods such as men men, corn cakes, and corn wine. Dishes such as thang co, smoked meat, forest vegetable soups, and dried or smoke-preserved foods reveal how the community adapted to cold weather and difficult mobility conditions. Hmong cuisine is generally not elaborate in presentation, but it is rich in practical value, communal memory, and environmental adaptation.',
    N'Kiến trúc Mông tiêu biểu với nhà trình tường, nhà gỗ và các kiểu nhà ở phù hợp với địa hình núi cao, khí hậu lạnh và nhu cầu bảo vệ con người, vật nuôi, lương thực. Nhà thường có kết cấu chắc chắn, không gian khép kín hơn và cách tổ chức nội thất gắn với cấu trúc gia đình, tín ngưỡng tổ tiên và sinh hoạt thường nhật. Kiến trúc Mông thể hiện rõ sự thực dụng, độ bền và khả năng thích nghi với môi trường khắc nghiệt. Đây là một trong những kiểu kiến trúc dân tộc có bản sắc vùng cao rõ nhất ở Việt Nam.',
    N'Hmong architecture is especially represented by rammed-earth houses, timber houses, and dwelling forms adapted to steep terrain, cold climate, and the need to protect people, livestock, and food supplies. These houses are usually solidly built, relatively enclosed, and internally organized in relation to family structure, ancestor belief, and daily life. Hmong architecture clearly expresses practicality, durability, and adaptation to a demanding environment. It is one of the clearest examples of upland ethnic architecture in Vietnam.',
    N'https://mia.vn/media/uploads/blog-du-lich/trang-phuc-dan-toc-hmong-hoa-1726418370.jpg',
    N'https://www.dienbientv.vn/dataimages/201212/original/images799023_01160006.JPG',
    4
),
(
    'TAY',
    N'Tày',
    N'Tay',
    N'Dân tộc thiểu số',
    N'Ethnic minority',
    N'1.8M+',
    N'Phân bố nhiều tại các tỉnh trung du và miền núi phía Bắc như Cao Bằng, Lạng Sơn, Tuyên Quang, Thái Nguyên và các khu vực lân cận.',
    N'Widely distributed in northern midland and mountain provinces such as Cao Bang, Lang Son, Tuyen Quang, Thai Nguyen, and surrounding areas.',
    N'Người Tày là một trong những cộng đồng dân tộc thiểu số đông dân nhất ở miền núi phía Bắc và có lịch sử cư trú lâu đời tại các vùng thung lũng, chân núi, ven suối và những khu vực thuận lợi cho nông nghiệp lúa nước. Nhờ điều kiện cư trú tương đối ổn định, người Tày đã hình thành một hệ thống văn hóa gắn chặt với bản làng, ruộng nước, nhà sàn và các sinh hoạt cộng đồng giàu tính bền vững. Trong không gian văn hóa phía Bắc, người Tày là một cộng đồng có vị trí rất quan trọng, vừa đông dân, vừa có ảnh hưởng rõ trong âm nhạc dân gian, lễ hội nông nghiệp, cấu trúc cư trú và đời sống tín ngưỡng.',
    N'The Tay are one of the most populous ethnic minority communities in northern Vietnam and have a long history of settlement in valleys, foothills, streamside areas, and places favorable to wet-rice agriculture. Because of this relatively stable settlement pattern, they developed a cultural system closely tied to village life, paddy cultivation, stilt houses, and durable communal traditions. Within northern cultural space, the Tay are especially important due to both their population size and their influence in folk music, agricultural festivals, settlement patterns, and belief systems.',
    N'Lịch sử của người Tày gắn với quá trình cư trú lâu dài tại các vùng chân núi và thung lũng, nơi có điều kiện thuận lợi cho nông nghiệp lúa nước, chăn nuôi và xây dựng bản làng ổn định. Trong nhiều giai đoạn lịch sử, người Tày vừa duy trì được ngôn ngữ, phong tục, tín ngưỡng riêng, vừa có sự giao lưu lâu dài với các cộng đồng lân cận như Nùng, Dao, Kinh. Nhờ sự ổn định về địa bàn cư trú và cấu trúc cộng đồng, người Tày bảo tồn được nhiều yếu tố văn hóa có chiều sâu, đồng thời đóng vai trò quan trọng trong tiến trình văn hóa - xã hội của vùng miền núi phía Bắc.',
    N'The history of the Tay is linked to long-term settlement in foothill and valley regions where conditions favored wet-rice cultivation, animal husbandry, and the formation of stable villages. Across many historical periods, the Tay preserved their own language, customs, and beliefs while also engaging in long-term interaction with neighboring groups such as the Nung, Dao, and Kinh. Because of the relative stability of their settlements and communal structures, they retained many deep cultural traditions and played an important role in the social and cultural history of northern upland Vietnam.',
    N'Văn hóa Tày nổi bật với hát then, đàn tính, lễ hội Lồng Tồng, tín ngưỡng dân gian và lối sống bản làng gắn với ruộng nước. Hát then không chỉ là nghệ thuật trình diễn mà còn là một thực hành mang tính nghi lễ, tâm linh và cộng đồng. Trang phục Tày thường giản dị với màu chàm làm chủ đạo, phản ánh sự kín đáo, tinh tế và phù hợp với sinh hoạt hàng ngày. Không gian văn hóa của người Tày nhìn chung mang vẻ yên ổn, hài hòa, sâu lắng, phản ánh một đời sống nông nghiệp có tính bền vững và cấu trúc xã hội chặt chẽ.',
    N'Tay culture is particularly known for then singing, the tinh lute, the Long Tong agricultural festival, folk belief, and village life rooted in wet-rice cultivation. Then singing is not only a performance art but also a ritual and spiritual practice closely tied to communal life. Tay clothing is generally simple and indigo-toned, reflecting restraint, refinement, and practicality. Overall, Tay cultural space tends to feel calm, harmonious, and reflective, expressing a stable agricultural way of life and cohesive social organization.',
    N'Ẩm thực Tày gắn với sản vật đồng ruộng, núi đồi, suối và nhịp sống bản làng. Nhiều món ăn tiêu biểu như xôi ngũ sắc, bánh khảo, thịt quay lá mắc mật, thịt hun khói, cá suối, rau rừng và rượu men lá phản ánh rõ sự kết hợp giữa nông nghiệp, chăn nuôi và khai thác sản vật địa phương. Cách nấu của người Tày thường thiên về sự mộc mạc, giữ hương vị tự nhiên của nguyên liệu, nhưng vẫn có sự tinh tế trong cách phối hợp món ăn cho các dịp lễ tết, cưới hỏi và hội làng.',
    N'Tay cuisine is tied to field produce, hills, streams, and village rhythms. Representative foods such as five-color sticky rice, banh khao, roasted pork with mắc mật leaves, smoked meats, stream fish, wild vegetables, and herbal-fermented rice wine clearly reflect a combination of agriculture, animal husbandry, and local natural resources. Tay cooking tends to be rustic and focused on preserving natural flavors, while still showing refinement in festive meals prepared for New Year, weddings, and communal celebrations.',
    N'Kiến trúc Tày tiêu biểu nhất là nhà sàn, thường được dựng ở chân núi, ven suối hoặc gần ruộng nước. Kiểu nhà này phù hợp với điều kiện khí hậu, địa hình và lối sống gia đình - cộng đồng của người Tày. Không gian nhà sàn vừa phục vụ sinh hoạt hàng ngày, vừa phản ánh quan niệm về tổ chức gia đình, tiếp khách, cúng tổ tiên và bảo quản nông sản. Kiến trúc Tày có giá trị cao ở cả phương diện sử dụng, thẩm mỹ và bản sắc văn hóa, là một trong những hình ảnh rất đặc trưng của vùng trung du và miền núi phía Bắc.',
    N'Tay architecture is most characteristically expressed in stilt houses, usually built near foothills, streams, or wet-rice fields. This house type is well suited to climate, terrain, and the family-communal life of the Tay. The house serves everyday domestic needs while also reflecting ideas about family organization, hospitality, ancestor worship, and agricultural storage. Tay architecture is valuable not only in practical terms but also in its aesthetic and cultural significance, and it remains one of the most characteristic images of the northern midlands and mountains.',
    N'https://topasecolodge.com/wp-content/uploads/2022/07/Dan-toc-Tay-Tay-minority-Vietnam.jpg',
    N'https://lh4.googleusercontent.com/proxy/0qmCw4AWTPzVfXgiEcgg4mFo57SiwbNM_kw7innCugcGGUpzCHKCboexOy4zKPY4fLcSH73uASDJLZvP9a7u6aGLY1_5cvkLNdQ3',
    5
),
(
    'NUNG',
    N'Nùng',
    N'Nung',
    N'Dân tộc thiểu số',
    N'Ethnic minority',
    N'1.1M+',
    N'Phân bố chủ yếu tại các tỉnh miền núi phía Bắc, đặc biệt ở Lạng Sơn, Cao Bằng, Thái Nguyên, Bắc Kạn cũ và các khu vực lân cận.',
    N'Primarily distributed in northern mountain provinces, especially Lang Son, Cao Bang, Thai Nguyen, the former Bac Kan area, and nearby localities.',
    N'Người Nùng là một trong những cộng đồng dân tộc thiểu số đông dân và có vai trò đáng kể trong không gian văn hóa vùng Đông Bắc Việt Nam. Cộng đồng này cư trú lâu đời tại các vùng núi thấp, thung lũng và chân núi, nơi thuận lợi cho canh tác nông nghiệp, chăn nuôi và hình thành bản làng ổn định. Trong đời sống văn hóa vùng biên và trung du phía Bắc, người Nùng nổi bật với tiếng nói, trang phục, dân ca, phong tục và hệ thống tri thức dân gian gắn với sản xuất nông nghiệp. Sự hiện diện của người Nùng góp phần quan trọng vào diện mạo văn hóa đa dạng của khu vực miền núi phía Bắc.',
    N'The Nung are one of the more populous ethnic minority communities and play an important role in the cultural landscape of northeastern Vietnam. They have long settled in low mountains, valleys, and foothill areas favorable for agriculture, livestock raising, and stable village formation. In the northern border and midland cultural zone, the Nung are known for their language, dress, folk songs, customs, and local knowledge related to agriculture. Their presence contributes significantly to the cultural diversity of northern Vietnam.',
    N'Lịch sử của người Nùng gắn với quá trình cư trú lâu dài tại vùng Đông Bắc, nơi cộng đồng từng bước hình thành các bản làng, phương thức canh tác và cấu trúc xã hội tương đối ổn định. Trong suốt nhiều giai đoạn lịch sử, người Nùng vừa duy trì được ngôn ngữ, phong tục và tín ngưỡng riêng, vừa có sự giao lưu sâu sắc với các cộng đồng như Tày, Dao, Kinh và các nhóm cư dân vùng biên khác. Cộng đồng Nùng có truyền thống gắn bó với đất đai, canh tác lúa nước kết hợp nương rẫy, đồng thời phát triển đời sống làng bản có tính cố kết cao. Quá trình lịch sử ấy giúp người Nùng giữ được bản sắc rõ rệt cho đến ngày nay.',
    N'The history of the Nung is tied to long-term settlement in the northeastern region, where communities gradually formed stable villages, farming methods, and social structures. Across many historical periods, the Nung preserved their language, customs, and beliefs while also engaging in deep interaction with groups such as the Tay, Dao, Kinh, and other borderland communities. They have long been associated with land-based livelihoods, combining wet-rice cultivation with upland farming and developing closely bonded village life. This historical continuity has helped preserve a clear Nung identity into the present.',
    N'Văn hóa Nùng nổi bật với dân ca sli, lượn, các lễ hội nông nghiệp, nghi lễ dân gian và phong tục gắn với chu kỳ mùa vụ. Trong đời sống tinh thần, người Nùng có hệ thống tín ngưỡng dân gian tương đối phong phú, gắn với tổ tiên, thần đất, thần núi và các yếu tố tự nhiên. Trang phục truyền thống của người Nùng thường thiên về màu chàm, giản dị nhưng có sự tinh tế trong cách may mặc và sử dụng trong nghi lễ. Không gian văn hóa Nùng nhìn chung mang sắc thái đằm, chắc và bền, phản ánh một cộng đồng có nền tảng nông nghiệp lâu đời và quan hệ làng bản bền chặt.',
    N'Nung culture is especially known for sli and luon folk songs, agricultural festivals, folk rituals, and customs tied to seasonal cycles. In spiritual life, the Nung maintain a rich system of folk belief linked to ancestors, land spirits, mountain spirits, and natural forces. Their traditional clothing is often indigo-toned, simple in appearance but refined in use and ceremonial meaning. Overall, Nung cultural space has a grounded and durable character, reflecting a community with long agricultural traditions and strong village relationships.',
    N'Ẩm thực Nùng gắn với sản vật miền núi, lúa nước, nương rẫy và chăn nuôi gia đình. Nhiều món ăn mang đặc trưng vùng Đông Bắc như khâu nhục, vịt quay lá mắc mật, các món bánh truyền thống, xôi ngũ sắc, thịt hun khói và các món chế biến theo mùa. Cách ăn của người Nùng thường thiên về sự đậm đà nhưng không quá cầu kỳ, đề cao nguyên liệu địa phương và tính cộng đồng trong bữa ăn. Ẩm thực Nùng phản ánh rõ sự kết hợp giữa điều kiện sinh thái miền núi và lối sống bản làng ổn định.',
    N'Nung cuisine is closely tied to mountain produce, wet-rice cultivation, upland farming, and household livestock. Many dishes are characteristic of the northeastern region, including khau nhuc, roasted duck with mắc mật leaves, traditional cakes, five-color sticky rice, smoked meat, and seasonal preparations. Nung foodways tend to be robust without being overly elaborate, emphasizing local ingredients and the communal nature of meals. Their cuisine clearly reflects the meeting point of mountain ecology and stable village life.',
    N'Kiến trúc của người Nùng thường bao gồm nhà sàn và một số kiểu nhà đất hoặc nhà nửa sàn nửa đất tùy theo địa hình và tập quán từng nhóm địa phương. Nhà ở thường được bố trí gọn gàng, phù hợp với sinh hoạt gia đình, chăn nuôi và bảo quản nông sản. Không gian cư trú của người Nùng phản ánh rõ sự thích nghi với vùng núi thấp, khí hậu theo mùa và nhịp sống gắn với sản xuất nông nghiệp. Kiến trúc Nùng nhìn chung không quá cầu kỳ nhưng có tính thực dụng cao và thể hiện rõ bản sắc vùng Đông Bắc.',
    N'Nung architecture includes stilt houses as well as earth-based or semi-stilt forms depending on terrain and local tradition. Houses are usually arranged efficiently to support family life, livestock, and crop storage. Their settlement patterns reflect adaptation to low mountain environments, seasonal climate, and agricultural rhythms. Nung architecture is generally not highly ornate, but it is strongly practical and clearly expresses northeastern upland identity.',
    N'https://dulichhobabe.com/UserFiles/image/Hat%20then1.JPG',
    N'https://images.baodantoc.vn/uploads/2020/Th%C3%A1ng%207/Ng%C3%A0y_30/img_20200518142229.jpg',
    6
),
(
    'DAO',
    N'Dao',
    N'Dao',
    N'Dân tộc thiểu số',
    N'Ethnic minority',
    N'891K+',
    N'Phân bố chủ yếu tại các tỉnh miền núi phía Bắc như Lào Cai, Hà Giang cũ, Tuyên Quang, Thái Nguyên, Quảng Ninh và nhiều vùng cao khác.',
    N'Primarily distributed in northern mountain provinces such as Lao Cai, the former Ha Giang area, Tuyen Quang, Thai Nguyen, Quang Ninh, and other upland regions.',
    N'Người Dao là một trong những cộng đồng dân tộc thiểu số có bản sắc văn hóa rất nổi bật ở vùng núi phía Bắc Việt Nam. Cộng đồng này cư trú ở nhiều dạng địa hình khác nhau, từ núi cao đến vùng trung du, tạo nên sự phong phú trong lối sống, trang phục, tập quán và tổ chức xã hội. Người Dao được biết đến với hệ thống tri thức dân gian phong phú, các nghi lễ trưởng thành, tín ngưỡng dân gian, nghề thuốc nam và nhiều hình thức thực hành văn hóa đặc sắc. Đây là một cộng đồng có mức độ bảo tồn bản sắc rất cao và có vai trò đáng kể trong việc tạo nên sự đa dạng văn hóa của miền núi phía Bắc.',
    N'The Dao are one of the most culturally distinctive ethnic minority communities in northern Vietnam. They live across varied terrains, from high mountains to midland zones, which contributes to diversity in lifestyle, dress, custom, and social organization. The Dao are known for their rich body of local knowledge, coming-of-age rituals, folk beliefs, herbal medicine traditions, and many distinctive cultural practices. They are a community with a strong degree of cultural preservation and play an important role in the diversity of northern upland culture.',
    N'Lịch sử của người Dao ở Việt Nam gắn với quá trình cư trú lâu dài tại các vùng núi phía Bắc, nơi cộng đồng hình thành những đơn vị cư trú và đời sống xã hội phù hợp với điều kiện địa hình phức tạp. Trong quá trình phát triển, người Dao phân thành nhiều nhóm địa phương với những nét riêng về trang phục, nghi lễ và tiếng nói, nhưng vẫn có những nền tảng văn hóa chung rất rõ. Người Dao duy trì được chữ viết cổ trong một số nhóm, đồng thời bảo tồn nhiều nghi lễ quan trọng như lễ cấp sắc, thể hiện cấu trúc văn hóa rất bền vững. Lịch sử của người Dao vì vậy không chỉ là lịch sử cư trú mà còn là lịch sử bảo tồn tri thức và nghi lễ cộng đồng.',
    N'The history of the Dao in Vietnam is tied to long-term settlement in northern mountainous areas, where they formed social and residential units suited to complex terrain. Over time, the Dao developed into several local subgroups with distinctions in dress, ritual, and speech, while still sharing important cultural foundations. Some Dao groups preserved old writing traditions, and major ceremonies such as the cấp sắc initiation rite remain central to communal life. Their history is therefore not only a history of settlement but also one of preserving ritual systems and local knowledge.',
    N'Văn hóa Dao nổi bật với trang phục truyền thống nhiều chi tiết thêu, hệ thống tín ngưỡng dân gian, lễ cấp sắc, nghệ thuật dân gian, lễ tết và tri thức chữa bệnh bằng cây thuốc. Mỗi nhóm Dao có thể có những khác biệt nhất định về trang phục và nghi lễ, nhưng nhìn chung đều thể hiện rất rõ tính cộng đồng, sự tôn trọng tổ tiên và quan niệm chặt chẽ về đời sống tinh thần. Không gian văn hóa Dao thường gắn với núi rừng, bản làng, ruộng bậc thang, nghi lễ trong gia đình và các dịp lễ quan trọng của cộng đồng. Đây là một trong những nền văn hóa dân tộc có chiều sâu biểu tượng và tính nghi lễ rất cao.',
    N'Dao culture is notable for richly decorated traditional clothing, folk belief systems, initiation rites, expressive folk practices, seasonal celebrations, and herbal healing knowledge. Individual Dao subgroups may differ in dress and ceremonial detail, but they generally share strong communal values, deep respect for ancestors, and carefully structured spiritual life. Dao cultural space is closely associated with mountains, forests, villages, terraced fields, household rituals, and major communal ceremonies. It is one of Vietnam’s ethnic traditions with especially strong symbolic and ritual depth.',
    N'Ẩm thực Dao gắn với điều kiện sinh thái miền núi và đời sống gắn bó với nương rẫy, rừng và chăn nuôi. Nhiều món ăn sử dụng rau rừng, thịt hun khói, rượu men lá và các nguyên liệu bản địa theo mùa. Một số cộng đồng Dao còn nổi bật với tri thức về thực phẩm gắn với sức khỏe, dược liệu và tắm lá thuốc. Ẩm thực Dao không chỉ phản ánh sinh kế mà còn cho thấy cách cộng đồng kết hợp giữa ăn uống, chữa bệnh và thích nghi với môi trường sống.',
    N'Dao cuisine reflects mountain ecology and a way of life tied to upland fields, forests, and small-scale animal husbandry. Many foods rely on wild vegetables, smoked meat, herbal-fermented alcohol, and seasonal local ingredients. Some Dao communities are also especially known for knowledge linking food, health, medicinal plants, and herbal bathing traditions. Dao cuisine therefore reflects not only livelihood but also a close relationship between food, healing, and environmental adaptation.',
    N'Kiến trúc Dao khá đa dạng, gồm nhà đất, nhà nửa sàn nửa đất hoặc nhà sàn tùy theo nhóm địa phương và điều kiện cư trú. Nhà ở thường gắn với yêu cầu thích nghi với sườn núi, khí hậu lạnh ẩm, sinh hoạt gia đình và sản xuất. Không gian cư trú của người Dao phản ánh rõ mối liên hệ giữa con người với núi rừng và các yếu tố tâm linh trong đời sống. Kiến trúc Dao thiên về công năng nhưng vẫn mang bản sắc rõ thông qua cách chọn địa điểm, bố trí không gian và gắn kết với cảnh quan tự nhiên.',
    N'Dao architecture is varied and may include earth houses, semi-stilt forms, or full stilt houses depending on subgroup and settlement conditions. Dwellings are closely adapted to mountain slopes, cool and humid climate, household life, and productive activity. Dao settlement space clearly reflects the relationship between people, forested landscapes, and spiritual considerations. Although primarily functional, Dao architecture still carries a strong identity through site selection, internal arrangement, and integration with the natural environment.',
    N'https://vovworld.vn/sites/default/files/world/Uploaded/hoanghuong/2014_05_13/dao2.jpg',
    N'https://topasecolodge.com/wp-content/uploads/2022/07/dan-toc-dao-do-red-dao-minority-vietnam.jpeg',
    7
),
(
    'THAI',
    N'Thái',
    N'Thai',
    N'Dân tộc thiểu số',
    N'Ethnic minority',
    N'1.8M+',
    N'Phân bố chủ yếu tại vùng Tây Bắc và một số khu vực Bắc Trung Bộ, đặc biệt ở Sơn La, Điện Biên, Lai Châu và các thung lũng miền núi.',
    N'Primarily distributed in the Northwest and parts of North Central Vietnam, especially in Son La, Dien Bien, Lai Chau, and mountain valleys.',
    N'Người Thái là một trong những cộng đồng dân tộc thiểu số đông dân và có ảnh hưởng sâu sắc tại vùng Tây Bắc Việt Nam. Cộng đồng này cư trú chủ yếu ở các thung lũng, cánh đồng giữa núi, ven suối và những khu vực có điều kiện thuận lợi cho lúa nước. Với lịch sử cư trú lâu dài và trình độ tổ chức cộng đồng khá cao, người Thái đã hình thành nên một không gian văn hóa đặc sắc, gắn với nhà sàn, váy áo truyền thống, dân ca, múa xòe và các lễ hội nông nghiệp. Trong bản đồ văn hóa vùng cao, người Thái giữ một vị trí rất quan trọng nhờ sự phong phú cả về vật chất lẫn tinh thần.',
    N'The Thai are one of the most populous and culturally influential ethnic minority communities in northwestern Vietnam. They mainly inhabit valleys, basins, streamside areas, and locations suitable for wet-rice cultivation. With a long history of settlement and relatively advanced communal organization, the Thai developed a distinctive cultural world associated with stilt houses, traditional dress, folk songs, xòe dance, and agricultural festivals. In the cultural geography of upland Vietnam, they hold a particularly important place because of the richness of both material and spiritual life.',
    N'Lịch sử của người Thái ở Việt Nam gắn với quá trình cư trú lâu dài tại các vùng thung lũng Tây Bắc, nơi cộng đồng tổ chức đời sống dựa trên nông nghiệp lúa nước kết hợp với khai thác rừng, suối và trao đổi nội vùng. Người Thái hình thành các mường, bản và cơ cấu xã hội có mức độ tổ chức tương đối cao, phản ánh truyền thống cộng đồng bền vững. Qua các giai đoạn lịch sử, người Thái duy trì được tiếng nói, chữ viết ở một số địa phương, phong tục cưới hỏi, lễ nghi tín ngưỡng và nhiều hình thức sinh hoạt cộng đồng đặc sắc. Điều này làm cho lịch sử của người Thái không chỉ gắn với cư trú mà còn gắn với sự phát triển của một không gian văn hóa vùng rất rõ nét.',
    N'The history of the Thai in Vietnam is tied to long-term settlement in the valleys of the Northwest, where communities built their lives around wet-rice agriculture together with forest use, stream resources, and regional exchange. The Thai developed muong and village structures with relatively high levels of social organization, reflecting durable communal traditions. Across historical periods, they preserved their language, local scripts in some areas, marriage customs, ritual life, and many forms of collective practice. This gives Thai history a strong connection not only to settlement but also to the development of a clearly defined regional cultural space.',
    N'Văn hóa Thái nổi bật với múa xòe, khắp Thái, dân ca, truyện thơ, trang phục phụ nữ Thái và đời sống cộng đồng gắn với bản, mường. Xòe Thái là một trong những biểu tượng tiêu biểu nhất của văn hóa Tây Bắc, thể hiện tinh thần cộng đồng, niềm vui sinh hoạt tập thể và bản sắc nghệ thuật dân gian. Người Thái cũng có hệ thống nghi lễ nông nghiệp, tín ngưỡng dân gian và các tập quán sinh hoạt rất phong phú. Không gian văn hóa của họ thường mang sắc thái mềm mại, hài hòa, gắn với sông suối, cánh đồng, nhà sàn và quan hệ cộng đồng bền chặt.',
    N'Thai culture is especially known for xòe dance, khắp singing, folk songs, verse narratives, women’s traditional dress, and communal life centered on villages and muong units. Thai xòe is one of the best-known cultural symbols of the Northwest, expressing collective spirit, shared joy, and strong folk artistic identity. Thai communities also maintain rich agricultural rituals, folk beliefs, and communal customs. Their cultural world is often characterized by harmony and grace, closely tied to streams, rice fields, stilt houses, and strong social bonds.',
    N'Ẩm thực Thái mang đặc trưng vùng núi nhưng có trình độ tổ chức bữa ăn rất tinh tế. Nhiều món ăn tiêu biểu như cơm lam, cá suối nướng, pa pỉnh tộp, thịt gác bếp, xôi nếp, các loại rau rừng và gia vị thơm đặc trưng phản ánh rõ điều kiện sinh thái Tây Bắc. Cách chế biến của người Thái thường chú trọng hương thơm tự nhiên, độ tươi của nguyên liệu và sự hòa hợp giữa món nướng, hấp, đồ và chấm. Ẩm thực Thái là một trong những hệ ẩm thực dân tộc có bản sắc rõ nhất ở vùng núi phía Bắc.',
    N'Thai cuisine is distinctly upland in character yet highly refined in meal organization. Representative foods such as bamboo-tube rice, grilled stream fish, pa pỉnh tộp, smoked meat, sticky rice, wild vegetables, and aromatic local seasonings clearly reflect Northwestern ecology. Thai cooking often emphasizes natural fragrance, freshness of ingredients, and balance among grilled, steamed, and sticky-rice-based dishes with dipping sauces. It is one of the most clearly defined ethnic culinary traditions in northern Vietnam.',
    N'Kiến trúc Thái tiêu biểu với nhà sàn lớn, mái cao, không gian mở và bố trí hợp lý cho sinh hoạt gia đình cũng như cộng đồng. Nhà thường dựng ở khu vực thung lũng hoặc ven suối, thích ứng với khí hậu, lũ lụt theo mùa và yêu cầu bảo quản nông sản. Không gian dưới gầm sàn, cầu thang, bếp lửa, khu tiếp khách và nơi thờ cúng đều phản ánh rất rõ cấu trúc xã hội và quan niệm sống của người Thái. Đây là một trong những hình thức kiến trúc dân tộc có giá trị cao cả về công năng và thẩm mỹ.',
    N'Thai architecture is especially represented by large stilt houses with high roofs, open layouts, and a careful organization of family and communal space. These houses are typically built in valleys or near streams and are well adapted to climate, seasonal flooding, and crop storage needs. The underfloor space, stairways, hearth, guest area, and ancestral or ritual spaces all reflect Thai social structure and concepts of domestic life. It is one of the most valued forms of ethnic architecture in Vietnam in both practical and aesthetic terms.',
    N'https://trekking-camping.com/wp-content/uploads/2020/09/dan-toc-Thai.jpg',
    N'https://wondertour.vn/wp-content/uploads/2022/01/dan-toc-thai-wondertour.jpg',
    8
),
(
    'MUONG',
    N'Mường',
    N'Muong',
    N'Dân tộc thiểu số',
    N'Ethnic minority',
    N'1.5M+',
    N'Phân bố chủ yếu tại vùng trung du và miền núi thấp, đặc biệt ở Hòa Bình cũ, Thanh Hóa và một số khu vực lân cận.',
    N'Primarily distributed in the midlands and lower mountain areas, especially the former Hoa Binh area, Thanh Hoa, and nearby regions.',
    N'Người Mường là một trong những cộng đồng dân tộc thiểu số đông dân và có mối liên hệ rất gần gũi với không gian văn hóa Bắc Bộ. Cộng đồng này cư trú chủ yếu ở vùng trung du và núi thấp, nơi thuận lợi cho nông nghiệp lúa nước, làm vườn, chăn nuôi và hình thành các xóm, mường ổn định. Người Mường vừa mang những nét tương đồng nhất định với người Kinh ở tầng sâu văn hóa nông nghiệp, vừa có hệ thống phong tục, ngôn ngữ, sử thi, lễ hội và nếp sống cộng đồng riêng biệt. Điều đó khiến văn hóa Mường có vị trí rất quan trọng trong nghiên cứu lịch sử văn hóa vùng Bắc Bộ.',
    N'The Muong are one of the more populous ethnic minority communities and have a particularly close connection with the broader cultural world of northern Vietnam. They mainly inhabit midland and low-mountain areas favorable for wet-rice agriculture, gardens, small-scale livestock, and stable village formation. While sharing certain deep agricultural-cultural traits with the Kinh, the Muong also maintain their own language, customs, epics, festivals, and communal life. This gives Muong culture an especially important place in the study of northern Vietnamese cultural history.',
    N'Lịch sử của người Mường gắn với quá trình cư trú lâu dài tại các vùng đồi núi thấp và thung lũng chuyển tiếp giữa đồng bằng với miền núi. Trong không gian đó, người Mường hình thành nên các mường, xóm và cấu trúc cộng đồng khá bền vững, dựa trên nông nghiệp lúa nước và quan hệ làng bản. Nhiều nhà nghiên cứu xem cộng đồng Mường là một trong những nhóm có ý nghĩa rất quan trọng trong việc hiểu về sự phát triển lịch sử - văn hóa của cư dân Việt cổ. Qua nhiều giai đoạn, người Mường vẫn bảo lưu được ngôn ngữ, sử thi, tín ngưỡng và nhiều yếu tố văn hóa dân gian có giá trị lớn.',
    N'The history of the Muong is tied to long-term settlement in low hills and transitional valleys between the delta and the mountains. In this setting, they developed muong units, villages, and relatively stable communal structures based on wet-rice cultivation and local social organization. Many scholars consider the Muong especially important for understanding the historical and cultural development of ancient Viet-related populations. Across historical periods, the Muong have preserved their language, epic traditions, beliefs, and many valuable forms of folk culture.',
    N'Văn hóa Mường nổi bật với các mo Mường, sử thi “Đẻ đất đẻ nước”, cồng chiêng, lễ hội nông nghiệp, tục lệ gia đình và đời sống cộng đồng gắn với xóm, mường. Đây là một nền văn hóa có chiều sâu rất lớn về tín ngưỡng, diễn xướng và tri thức dân gian. Người Mường bảo tồn được nhiều phong tục cổ trong tang ma, cưới hỏi, tín ngưỡng thờ tổ tiên và quan niệm về vũ trụ, con người. Không gian văn hóa Mường nhìn chung mang tính bền chắc, gần gũi với tự nhiên và có giá trị rất cao trong nghiên cứu văn hóa dân gian Việt Nam.',
    N'Muong culture is especially known for mo chanting, the epic tradition of “De Dat De Nuoc,” gong culture, agricultural festivals, family customs, and communal life centered on hamlets and muong units. It is a cultural tradition of considerable depth in belief, performance, and local knowledge. The Muong preserve many older customs related to funerary rites, marriage, ancestor worship, and cosmological ideas. Overall, Muong cultural space is marked by continuity, closeness to nature, and major significance for the study of Vietnamese folk culture.',
    N'Ẩm thực Mường gắn với nông nghiệp lúa nước, sản vật đồi núi thấp và sinh hoạt cộng đồng. Nhiều món ăn tiêu biểu như cơm lam, thịt chua, cá suối, rau rừng, rượu cần và các món chế biến trong dịp lễ hội phản ánh rõ lối sống gần gũi với thiên nhiên. Cách chế biến của người Mường thường đề cao độ tươi của nguyên liệu, sự giản dị nhưng đậm đà trong hương vị và tính cộng đồng trong cách ăn uống. Ẩm thực Mường có giá trị đặc biệt vì vừa quen thuộc với văn hóa Bắc Bộ, vừa giữ nhiều nét riêng của cư dân miền đồi núi.',
    N'Muong cuisine is tied to wet-rice agriculture, low-hill produce, and communal life. Representative foods such as bamboo-tube rice, fermented pork, stream fish, wild vegetables, rice wine in jars, and festival dishes clearly reflect a way of life closely connected to nature. Muong cooking often emphasizes fresh ingredients, simple but rich flavor, and the communal character of eating. It is culturally significant because it is both connected to broader northern foodways and still distinctively rooted in hill-country life.',
    N'Kiến trúc Mường tiêu biểu với nhà sàn, thường dựng ở khu vực đồi thấp, ven suối hoặc thung lũng. Nhà sàn Mường vừa thích nghi với địa hình, khí hậu và đời sống sản xuất, vừa phản ánh tổ chức gia đình, quan niệm cộng đồng và nếp sống truyền thống. Không gian nhà thường được tổ chức hợp lý với bếp, nơi tiếp khách, nơi thờ cúng và khu sinh hoạt. Kiến trúc Mường có sự gần gũi nhất định với một số cộng đồng vùng núi khác, nhưng vẫn giữ được bản sắc riêng ở bố cục, tập quán sử dụng và môi trường cư trú.',
    N'Muong architecture is especially represented by stilt houses, often built in low-hill areas, near streams, or in valleys. These houses are well adapted to terrain, climate, and productive life, while also reflecting family organization, communal values, and traditional domestic patterns. Interior space is usually arranged around the hearth, guest area, worship space, and everyday living areas. Muong architecture shares certain affinities with other upland communities, yet maintains its own identity through layout, use patterns, and settlement environment.',
    N'https://maichauhideaway.com/Data/Sites/1/News/424/ng%C6%B0%E1%BB%9Di-m%C6%B0%E1%BB%9Dng-s%E1%BB%91ng-%E1%BB%9F-%C4%91%C3%A2u-(3).png',
    N'https://images.baodantoc.vn/uploads/2025/Thang-8/Ngay-27/1742870645793/a2.jpg',
    9
),
(
    'HOA',
    N'Hoa',
    N'Hoa',
    N'Dân tộc thiểu số',
    N'Ethnic minority',
    N'749K+',
    N'Phân bố tại nhiều đô thị và trung tâm thương mại, tập trung đáng kể ở TP. Hồ Chí Minh, các tỉnh Nam Bộ và một số thành phố lớn khác.',
    N'Distributed across many urban and commercial centers, with major concentrations in Ho Chi Minh City, Southern Vietnam, and several other large cities.',
    N'Người Hoa là một cộng đồng dân tộc có dấu ấn rất rõ trong đời sống đô thị, thương mại và văn hóa Việt Nam, đặc biệt ở khu vực Nam Bộ. Cộng đồng này hiện diện ở nhiều địa phương, nhưng nổi bật nhất là tại TP. Hồ Chí Minh và các trung tâm kinh tế lớn, nơi họ đã đóng vai trò quan trọng trong buôn bán, thủ công, dịch vụ, ẩm thực và kiến trúc cộng đồng. Người Hoa không phải là một cộng đồng đồng nhất tuyệt đối mà bao gồm nhiều nhóm ngôn ngữ, nguồn gốc và truyền thống địa phương khác nhau, tạo nên một đời sống văn hóa nội tại rất phong phú. Sự hiện diện của người Hoa là một thành tố quan trọng trong bản đồ văn hóa đô thị và thương mại của Việt Nam.',
    N'The Hoa are an ethnic community with a highly visible presence in the urban, commercial, and cultural life of Vietnam, especially in the South. They are found in many localities, but are most prominent in Ho Chi Minh City and major economic centers, where they have played important roles in trade, crafts, services, cuisine, and community architecture. The Hoa are not a completely uniform community but include multiple language groups, regional origins, and local traditions, making their internal cultural life especially rich. Their presence is a major component of Vietnam’s urban and commercial cultural landscape.',
    N'Lịch sử của người Hoa ở Việt Nam gắn với nhiều làn sóng di cư, định cư và hình thành cộng đồng tại các cảng thị, đô thị và trung tâm giao thương. Qua nhiều giai đoạn lịch sử, người Hoa đã đóng vai trò quan trọng trong thương mại, thủ công nghiệp, dịch vụ và quá trình hình thành các khu phố buôn bán sầm uất. Đồng thời, họ cũng xây dựng được hệ thống bang hội, hội quán, chùa miếu và mạng lưới tương trợ cộng đồng khá chặt chẽ. Trải qua thời gian dài cư trú tại Việt Nam, người Hoa vừa duy trì được nhiều yếu tố văn hóa riêng, vừa có sự giao thoa mạnh mẽ với đời sống bản địa.',
    N'The history of the Hoa in Vietnam is tied to multiple waves of migration, settlement, and community formation in ports, towns, and trade centers. Across different historical periods, the Hoa played major roles in commerce, handicrafts, services, and the development of vibrant commercial districts. At the same time, they created a dense network of associations, assembly halls, temples, and systems of mutual support. Over long periods of residence in Vietnam, Hoa communities preserved many of their own cultural features while also engaging deeply with local society.',
    N'Văn hóa Hoa nổi bật với hội quán, chùa miếu, lễ hội cộng đồng, tập quán tín ngưỡng, nghệ thuật trang trí và đời sống gia tộc, bang hội. Nhiều khu phố người Hoa còn lưu giữ được những hình thức sinh hoạt thương mại, tín ngưỡng và văn hóa rất đặc sắc, tạo nên diện mạo riêng cho đô thị. Các dịp lễ như Tết Nguyên đán, Nguyên tiêu, các nghi lễ tại hội quán và sinh hoạt cộng đồng mang màu sắc văn hóa Hoa rất rõ nét. Văn hóa Hoa ở Việt Nam vì vậy vừa có tính bảo tồn nguồn gốc, vừa có tính thích nghi cao trong môi trường đa văn hóa.',
    N'Hoa culture is especially visible in assembly halls, temples, community festivals, religious customs, decorative traditions, and clan- or association-based life. Many Hoa districts preserve distinctive forms of commercial, religious, and communal organization that give urban spaces their own character. Celebrations such as Lunar New Year, the Lantern Festival, rituals at assembly halls, and other community observances clearly express Hoa cultural identity. Hoa culture in Vietnam therefore combines a strong sense of origin with high adaptability within a multicultural environment.',
    N'Ẩm thực Hoa có ảnh hưởng rất lớn đến đời sống ẩm thực đô thị ở Việt Nam, đặc biệt tại Nam Bộ. Nhiều món ăn quen thuộc như hủ tiếu, sủi cảo, vịt quay, há cảo, xá xíu, mì, chè và các món tiệm ăn kiểu Hoa đã trở thành một phần của ẩm thực đường phố và ẩm thực gia đình ở nhiều thành phố. Ẩm thực Hoa thường chú trọng kỹ thuật chế biến, độ cân bằng hương vị và tính đa dạng theo nhóm địa phương. Đây là một trong những cộng đồng có đóng góp rất rõ trong việc định hình diện mạo ẩm thực đô thị Việt Nam.',
    N'Hoa cuisine has had major influence on urban food culture in Vietnam, especially in the South. Familiar foods such as hu tieu, dumplings, roast duck, dim sum, char siu, noodles, sweet soups, and many Chinese-style eatery dishes have become part of both street food and household cooking in many cities. Hoa cuisine typically emphasizes culinary technique, flavor balance, and internal variation among regional subgroups. It is one of the clearest ethnic contributions to the shaping of Vietnamese urban cuisine.',
    N'Kiến trúc của người Hoa nổi bật với hội quán, chùa miếu, nhà phố buôn bán và các công trình cộng đồng trong khu đô thị. Những công trình này thường có mặt tiền trang trí công phu, màu sắc nổi bật, mái ngói cong, phù điêu và không gian nội thất gắn với tín ngưỡng hoặc sinh hoạt bang hội. Ở nhiều đô thị, kiến trúc Hoa tạo nên một lớp di sản rất rõ nét trong diện mạo phố thị. Đây là một trong những biểu hiện dễ nhận biết nhất của sự hiện diện lâu dài và có tổ chức của cộng đồng Hoa tại Việt Nam.',
    N'Hoa architecture is especially visible in assembly halls, temples, shop houses, and urban community buildings. These structures often feature elaborate façades, vivid color, curved tiled roofs, relief decoration, and interior spaces tied to religion or association life. In many cities, Hoa architecture forms a clearly recognizable layer of urban heritage. It is one of the most visible expressions of the Hoa community’s long-term and organized presence in Vietnam.',
    N'https://imgnvsk.vnanet.vn/MediaUpload/Medium/2024/02/28/dan-toc-hoa-128-13-45-27.jpg',
    N'https://images.baodantoc.vn/uploads/2022/Th%C3%A1ng%205/Ng%C3%A0y_19/NG%C3%82N/d%C3%A2n%20t%E1%BB%99c%20hoa/hoa1.jpg',
    10
),
(
    'EDE',
    N'Ê Đê',
    N'Ede',
    N'Dân tộc thiểu số',
    N'Ethnic minority',
    N'398K+',
    N'Phân bố chủ yếu tại Tây Nguyên, đặc biệt ở Đắk Lắk và các khu vực lân cận.',
    N'Primarily distributed in the Central Highlands, especially in Dak Lak and nearby areas.',
    N'Người Ê Đê là một trong những cộng đồng dân tộc thiểu số tiêu biểu của Tây Nguyên, với bản sắc văn hóa đặc trưng gắn liền với không gian rừng, nhà dài và chế độ mẫu hệ. Cộng đồng này có đời sống xã hội mang tính cộng đồng cao, gắn bó với buôn làng và các nghi lễ truyền thống. Trong bức tranh văn hóa Tây Nguyên, người Ê Đê giữ một vị trí quan trọng với các giá trị đặc trưng về âm nhạc, kiến trúc, tín ngưỡng và sinh hoạt cộng đồng.',
    N'The Ede are one of the most representative ethnic communities of the Central Highlands, with a distinctive cultural identity tied to forest space, longhouses, and matrilineal social organization. Their social life is highly communal, centered around village life and traditional rituals. Within the cultural landscape of the Central Highlands, the Ede hold an important position through their music, architecture, belief systems, and communal practices.',
    N'Lịch sử của người Ê Đê gắn với quá trình cư trú lâu dài tại vùng cao nguyên, nơi cộng đồng phát triển lối sống thích nghi với rừng, sông suối và đất bazan màu mỡ. Người Ê Đê duy trì chế độ mẫu hệ, trong đó phụ nữ giữ vai trò trung tâm trong gia đình và tài sản được truyền theo dòng mẹ. Qua nhiều thế hệ, cộng đồng này vẫn bảo tồn được tiếng nói, phong tục và cấu trúc xã hội đặc trưng.',
    N'The history of the Ede is tied to long-term settlement in the highlands, where they developed a way of life adapted to forests, rivers, and fertile basalt soil. The Ede maintain a matrilineal system in which women hold central roles and inheritance follows the maternal line. Over generations, they have preserved their language, customs, and distinctive social structure.',
    N'Văn hóa Ê Đê nổi bật với nhà dài, cồng chiêng, sử thi, lễ hội và tín ngưỡng đa thần. Không gian văn hóa buôn làng, các nghi lễ vòng đời và lễ hội nông nghiệp thể hiện rõ tính cộng đồng và mối quan hệ hài hòa với thiên nhiên.',
    N'Ede culture is characterized by longhouses, gong music, epics, festivals, and animistic beliefs. Village space, life-cycle rituals, and agricultural festivals reflect strong communal bonds and harmony with nature.',
    N'Ẩm thực Ê Đê gắn với sản vật rừng và nương rẫy, với các món nướng, cơm lam, canh thụt và rượu cần. Cách chế biến đơn giản nhưng đậm đà, phản ánh rõ môi trường sống và tập quán sinh hoạt cộng đồng.',
    N'Ede cuisine is based on forest and upland resources, with grilled dishes, bamboo rice, stews, and rice wine. Cooking methods are simple yet flavorful, reflecting environmental adaptation and communal life.',
    N'Kiến trúc Ê Đê tiêu biểu với nhà dài – nơi sinh sống của nhiều thế hệ trong một dòng họ. Nhà dài không chỉ là nơi ở mà còn là biểu tượng của chế độ mẫu hệ và cấu trúc xã hội đặc trưng.',
    N'Ede architecture is best represented by longhouses, where multiple generations of a matrilineal family live together. These houses are not only dwellings but also symbols of social structure and cultural identity.',
    N'https://media-cdn-v2.laodong.vn/Storage/NewsPortal/2022/11/21/1119054/Z3896084920631_A9ee4.jpg',
    N'https://daktip.com.vn/wp-content/uploads/2021/09/nguoi-e-de-tay-nguyen.jpeg',
    11
),
(
    'GIA_RAI',
    N'Gia Rai',
    N'Gia Rai',
    N'Dân tộc thiểu số',
    N'Ethnic minority',
    N'513K+',
    N'Phân bố chủ yếu tại Gia Lai, Kon Tum và một số vùng Tây Nguyên.',
    N'Primarily distributed in Gia Lai, Kon Tum, and parts of the Central Highlands.',
    N'Người Gia Rai là một cộng đồng dân tộc lớn ở Tây Nguyên, nổi bật với truyền thống văn hóa gắn với buôn làng, rừng núi và hệ thống tín ngưỡng đa thần.',
    N'The Gia Rai are a major ethnic group in the Central Highlands, known for their village-based culture, forest environment, and animistic belief systems.',
    N'Lịch sử của người Gia Rai gắn với quá trình cư trú lâu dài tại cao nguyên, nơi họ phát triển nền kinh tế nương rẫy và đời sống cộng đồng gắn kết chặt chẽ.',
    N'The history of the Gia Rai is tied to long-term settlement in the highlands, where they developed swidden agriculture and strong communal life.',
    N'Văn hóa Gia Rai nổi bật với nhà rông, tượng nhà mồ, lễ hội bỏ mả và không gian cồng chiêng. Đây là một trong những nền văn hóa giàu tính biểu tượng nhất Tây Nguyên.',
    N'Gia Rai culture is known for communal houses, grave sculptures, funeral ceremonies, and gong culture, making it one of the most symbolic traditions in the Central Highlands.',
    N'Ẩm thực Gia Rai gồm các món nướng, cơm lam, thịt rừng và rượu cần, phản ánh lối sống gắn với thiên nhiên.',
    N'Gia Rai cuisine includes grilled foods, bamboo rice, wild meats, and rice wine, reflecting a nature-based lifestyle.',
    N'Kiến trúc Gia Rai tiêu biểu với nhà rông cao lớn, là trung tâm sinh hoạt cộng đồng.',
    N'Gia Rai architecture is characterized by tall communal houses that serve as the center of village life.',
    N'https://ati.net.vn/wp-content/uploads/2023/06/trang-phuc-dan-toc-gia-rai.jpg',
    N'https://ati.net.vn/wp-content/uploads/2023/06/le-ttes-dan-toc-gia-rai.jpg',
    12
),
(
    'BA_NA',
    N'Ba Na',
    N'Ba Na',
    N'Dân tộc thiểu số',
    N'Ethnic minority',
    N'286K+',
    N'Phân bố tại Kon Tum, Gia Lai và các khu vực Tây Nguyên.',
    N'Distributed in Kon Tum, Gia Lai, and the Central Highlands.',
    N'Người Ba Na là một cộng đồng dân tộc thiểu số tiêu biểu ở Tây Nguyên với đời sống gắn bó chặt chẽ với buôn làng và thiên nhiên.',
    N'The Ba Na are a representative ethnic group of the Central Highlands, with a lifestyle closely tied to village life and nature.',
    N'Lịch sử của người Ba Na gắn với cư trú lâu dài tại vùng cao nguyên, nơi họ phát triển nông nghiệp và đời sống cộng đồng.',
    N'The Ba Na have long inhabited the highlands, developing agriculture and communal traditions.',
    N'Văn hóa Ba Na nổi bật với nhà rông, cồng chiêng, lễ hội và nghệ thuật dân gian.',
    N'Ba Na culture features communal houses, gong music, festivals, and folk arts.',
    N'Ẩm thực Ba Na gồm cơm lam, thịt nướng và rượu cần.',
    N'Ba Na cuisine includes bamboo rice, grilled meat, and rice wine.',
    N'Kiến trúc Ba Na tiêu biểu với nhà rông cao lớn.',
    N'Ba Na architecture is known for tall communal houses.',
    N'https://vietnamtourism.vn/imguploads/tourist/2014/VNDatNuocConNguoi/01Khaiquatchung/03Dancu/01Dantocbana.jpg',
    N'https://images.baodantoc.vn/uploads/2022/Th%C3%A1ng%206/Ng%C3%A0y_27/To%20Oanh/Ba%20Na/8.jpg',
    13
),
(
    'XO_DANG',
    N'Xơ Đăng',
    N'Xo Dang',
    N'Dân tộc thiểu số',
    N'Ethnic minority',
    N'212K+',
    N'Phân bố tại Kon Tum và các vùng lân cận.',
    N'Distributed in Kon Tum and nearby regions.',
    N'Người Xơ Đăng là cộng đồng dân tộc thiểu số ở Tây Nguyên với đời sống gắn với núi rừng.',
    N'The Xo Dang are an ethnic group in the Central Highlands with a forest-based lifestyle.',
    N'Lịch sử gắn với cư trú lâu dài tại vùng núi.',
    N'History tied to long-term mountain settlement.',
    N'Văn hóa nổi bật với lễ hội, cồng chiêng.',
    N'Culture includes festivals and gong traditions.',
    N'Ẩm thực đơn giản, gắn với nương rẫy.',
    N'Simple cuisine tied to upland farming.',
    N'Nhà sàn là đặc trưng kiến trúc.',
    N'Stilt houses are characteristic.',
    N'https://cly.1cdn.vn/2023/11/17/mot-le-hoi-cua-nguoi-xo-dang.jpg',
    N'https://images.baodantoc.vn/uploads/2021/Th%C3%A1ng_11/Ng%C3%A0y_19/ng%C3%A2n/thi%E1%BA%BFu%20n%E1%BB%AF%20X%C6%A1%20%C4%90%C4%83ng/H3%20(1).jpg',
    14
),
(
    'CO_HO',
    N'Cơ Ho',
    N'Co Ho',
    N'Dân tộc thiểu số',
    N'Ethnic minority',
    N'200K+',
    N'Phân bố tại Lâm Đồng và khu vực Tây Nguyên.',
    N'Distributed in Lam Dong and the Central Highlands.',
    N'Người Cơ Ho là một cộng đồng dân tộc thiểu số gắn với vùng cao nguyên Nam Tây Nguyên.',
    N'The Co Ho are an ethnic group associated with the southern Central Highlands.',
    N'Lịch sử gắn với cư trú lâu đời tại cao nguyên.',
    N'History tied to long-term highland settlement.',
    N'Văn hóa gồm lễ hội, cồng chiêng.',
    N'Culture includes festivals and gong traditions.',
    N'Ẩm thực gồm cơm lam, thịt nướng.',
    N'Cuisine includes bamboo rice and grilled meat.',
    N'Nhà dài, nhà sàn là đặc trưng.',
    N'Longhouses and stilt houses are typical.',
    N'https://i.ytimg.com/vi/pwsBWRsZfr8/maxresdefault.jpg',
    N'https://cly.1cdn.vn/2023/11/19/anh-bai-nguoi-co-ho-tren-dat-tay-nguyen-2.jpg',
    15
),
(
    'MNONG',
    N'M’nông',
    N'Mnong',
    N'Dân tộc thiểu số',
    N'Ethnic minority',
    N'127K+',
    N'Phân bố chủ yếu tại khu vực Tây Nguyên, đặc biệt ở Đắk Nông, Đắk Lắk, Lâm Đồng và một số địa bàn lân cận thuộc miền núi Nam Trung Bộ và Đông Nam Bộ.',
    N'Primarily distributed in the Central Highlands, especially in Dak Nong, Dak Lak, Lam Dong, and nearby upland areas of South Central and Southeastern Vietnam.',
    N'Người M’nông là một trong những cộng đồng dân tộc thiểu số tiêu biểu của Tây Nguyên, có bản sắc văn hóa rất rõ và gắn bó sâu sắc với không gian rừng, voi, buôn làng, nương rẫy và đời sống cộng đồng truyền thống. Trong bức tranh văn hóa Tây Nguyên, người M’nông nổi bật bởi kho tàng sử thi, tín ngưỡng dân gian, luật tục, lễ hội, tri thức bản địa về rừng và mối quan hệ bền chặt giữa con người với thiên nhiên. Đây là cộng đồng có vai trò rất quan trọng trong việc hình thành diện mạo văn hóa đặc trưng của vùng cao nguyên phía Nam. Trong đời sống hiện đại, người M’nông vẫn duy trì được nhiều yếu tố cốt lõi của bản sắc văn hóa, đồng thời thích nghi với những biến đổi về kinh tế, xã hội và môi trường sống.',
    N'The Mnong are one of the most representative ethnic minority communities of the Central Highlands, with a highly distinctive cultural identity deeply connected to forests, elephants, village life, swidden fields, and traditional communal organization. Within the cultural landscape of the Central Highlands, the Mnong stand out for their epic traditions, folk belief systems, customary law, festivals, indigenous forest knowledge, and their strong relationship with nature. They play a major role in shaping the distinctive cultural profile of the southern highlands. In contemporary life, the Mnong continue to preserve many core aspects of their cultural identity while adapting to economic, social, and environmental change.',
    N'Lịch sử của người M’nông gắn với quá trình cư trú lâu dài tại không gian rừng núi và cao nguyên phía Nam, nơi cộng đồng phát triển đời sống dựa vào nương rẫy, săn bắt, hái lượm, chăn nuôi và khai thác sản vật rừng. Trong quá khứ, người M’nông sống thành các buôn làng có tính tự quản tương đối cao, duy trì luật tục và nhiều quy tắc xã hội gắn với môi trường tự nhiên. Cộng đồng này có mối quan hệ đặc biệt với voi trong đời sống sản xuất, di chuyển và nghi lễ, điều đã tạo nên một dấu ấn riêng rất mạnh trong lịch sử văn hóa Tây Nguyên. Dù trải qua nhiều biến động do chiến tranh, di cư, thay đổi mô hình kinh tế và thu hẹp không gian rừng, người M’nông vẫn bảo tồn được nhiều giá trị truyền thống có ý nghĩa rất lớn về mặt văn hóa và nhân học.',
    N'The history of the Mnong is tied to long-term settlement in the forests and southern highlands, where communities developed ways of life based on swidden farming, hunting, gathering, livestock keeping, and the use of forest resources. In the past, Mnong communities lived in villages with relatively strong self-governance, maintaining customary law and social rules closely linked to the natural environment. They also had a particularly important relationship with elephants in transport, livelihood, and ritual life, which created one of the strongest cultural signatures in the history of the Central Highlands. Despite major changes caused by war, migration, economic transformation, and forest loss, the Mnong have preserved many traditional values of great cultural and anthropological significance.',
    N'Văn hóa M’nông nổi bật với sử thi, cồng chiêng, lễ hội cộng đồng, tín ngưỡng đa thần, luật tục và tri thức bản địa về rừng. Cộng đồng M’nông quan niệm thiên nhiên có linh hồn, vì vậy nhiều nghi lễ liên quan đến đất, rừng, nước, mùa màng, sức khỏe và các giai đoạn quan trọng của vòng đời con người được tổ chức với tính cộng đồng rất cao. Một trong những yếu tố đặc biệt của văn hóa M’nông là không gian gắn với voi, đặc biệt tại các khu vực như Buôn Đôn và những vùng có truyền thống săn bắt, thuần dưỡng, chăm sóc voi. Ngoài ra, người M’nông còn có kho tàng truyện kể, dân ca, nhạc cụ và hình thức sinh hoạt cộng đồng phản ánh rất rõ tư duy biểu tượng của cư dân Tây Nguyên. Đây là một nền văn hóa giàu tính sử thi, giàu chiều sâu tinh thần và có mối liên hệ rất mật thiết với môi trường sống.',
    N'Mnong culture is especially known for epic traditions, gong music, communal festivals, animistic belief systems, customary law, and indigenous forest knowledge. Mnong communities often understand nature as spiritually inhabited, so many rituals related to land, forest, water, crops, health, and life-cycle events are organized with a strong communal character. One of the most distinctive elements of Mnong culture is its association with elephants, especially in areas such as Buon Don and other places with traditions of elephant capture, taming, and care. In addition, the Mnong maintain rich traditions of storytelling, folk singing, musical instruments, and communal practices that clearly reflect the symbolic imagination of Central Highlands society. It is a culture rich in epic character, spiritual depth, and close connection to its ecological setting.',
    N'Ẩm thực M’nông gắn với đời sống nương rẫy, rừng núi và sinh hoạt cộng đồng của Tây Nguyên. Nhiều món ăn sử dụng nguyên liệu địa phương như gạo nếp, ngô, sắn, rau rừng, cá suối, thịt nướng và các loại gia vị bản địa. Các phương thức chế biến phổ biến gồm nướng, đồ, nấu trong ống tre, phơi hoặc hun khói, tạo nên hương vị mộc mạc nhưng đậm đà. Rượu cần giữ vai trò rất quan trọng trong đời sống cộng đồng, thường xuất hiện trong lễ hội, nghi lễ và các dịp sum họp. Ẩm thực M’nông không chỉ phản ánh điều kiện sinh thái của vùng cao nguyên mà còn cho thấy tính cộng đồng rất mạnh trong cách ăn uống và tổ chức sinh hoạt.',
    N'Mnong cuisine is closely tied to swidden life, forest ecology, and communal traditions in the Central Highlands. Many dishes make use of local ingredients such as sticky rice, corn, cassava, wild vegetables, stream fish, grilled meats, and indigenous seasonings. Common cooking methods include grilling, steaming, cooking in bamboo tubes, drying, and smoking, resulting in flavors that are rustic yet intense. Jar rice wine plays a particularly important role in communal life and is frequently present in festivals, rituals, and gatherings. Mnong cuisine reflects both the ecological conditions of the highlands and the strong communal character of food culture.',
    N'Kiến trúc M’nông thường gắn với nhà dài hoặc các kiểu nhà sàn, nhà đất phù hợp với điều kiện cư trú, tập quán sinh hoạt và tổ chức buôn làng của từng nhóm địa phương. Không gian ở của người M’nông phản ánh rõ tính cộng đồng, mối quan hệ gia đình và nhu cầu thích nghi với môi trường rừng núi. Bên cạnh nhà ở, không gian buôn làng, bếp lửa, kho lúa và những địa điểm tổ chức nghi lễ cũng có ý nghĩa rất quan trọng trong cấu trúc văn hóa. Kiến trúc M’nông không thiên về sự cầu kỳ trong trang trí mà nổi bật ở tính thích nghi, sự gắn kết với vật liệu tự nhiên và khả năng phản ánh rõ lối sống của cư dân Tây Nguyên.',
    N'Mnong architecture is commonly associated with longhouses as well as stilt-house and earth-house forms suited to local settlement conditions, domestic customs, and village organization. Mnong dwelling space clearly reflects communal values, family relationships, and adaptation to forested highland environments. Beyond the house itself, village layout, hearth space, granaries, and ceremonial locations all hold important places in cultural structure. Mnong architecture is not especially ornate in decoration, but it stands out for its environmental adaptation, use of natural materials, and its strong expression of Central Highlands ways of life.',
    N'https://imagevietnam.vnanet.vn//MediaUpload/Org/2022/08/26/1726-10-41-14.jpg',
    N'https://static-images.vanhoanghethuat.vn/datasite///201807/BAI_VIET_17551/Untitledmj.jpg?width=0&s=81kzuxtYq0-PxUOktuTjKg',
    16
);

-----------------------------------------------------------------------------------------------------------------------------------------










------------------------------------------------------- Thêm dữ liệu cho bảng tỉnh thành ----------------------------------------------

INSERT INTO dbo.TinhThanh
(
    MaTinh,
    VungID,
    TenVI,
    TenEN,
    TieuDePhuVI,
    TieuDePhuEN,
    TongQuanVI,
    TongQuanEN,
    ThoiDiemDepVI,
    ThoiDiemDepEN,
    AnhDaiDienUrl,
    HeroImageUrl,
    ThuTuHienThi
)
VALUES
(
    'HA_NOI',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'BAC_BO'),
    N'Hà Nội',
    N'Hanoi',
    N'Thủ đô ngàn năm văn hiến',
    N'The thousand-year-old capital',
    N'Hà Nội là thủ đô của Việt Nam, đồng thời là trung tâm lớn về chính trị, hành chính, văn hóa, giáo dục và lịch sử của cả nước. Thành phố nổi bật với sự giao thoa giữa nét cổ kính và nhịp sống hiện đại, thể hiện qua khu phố cổ, hồ Hoàn Kiếm, Văn Miếu - Quốc Tử Giám, Hoàng thành Thăng Long cùng nhiều công trình kiến trúc có giá trị. Không chỉ là nơi lưu giữ chiều sâu lịch sử, Hà Nội còn là không gian văn hóa đặc sắc với nghệ thuật truyền thống, ẩm thực phong phú và đời sống đô thị mang bản sắc riêng. Trong bức tranh du lịch Việt Nam, Hà Nội thường được xem là điểm đến tiêu biểu cho những ai muốn tìm hiểu chiều sâu văn hóa, nhịp sống đô thị miền Bắc và các giá trị lịch sử lâu đời.',
    N'Hanoi is the capital of Vietnam and one of the country''s most important centers for politics, administration, culture, education, and history. The city is known for its blend of historical depth and modern urban life, reflected in the Old Quarter, Hoan Kiem Lake, the Temple of Literature, the Imperial Citadel of Thang Long, and many architecturally significant sites. Beyond its role as a political capital, Hanoi preserves a distinctive cultural atmosphere through traditional arts, a rich culinary scene, and a lifestyle that reflects Northern Vietnamese identity. In the broader tourism landscape of Vietnam, Hanoi is often seen as a key destination for travelers seeking historical understanding, cultural experience, and a strong sense of place.',
    N'Thời điểm đẹp nhất để khám phá Hà Nội thường rơi vào mùa thu, từ khoảng tháng 9 đến tháng 11, khi thời tiết mát mẻ, khô ráo, trời trong và nhiệt độ khá dễ chịu cho các hoạt động tham quan ngoài trời. Đây cũng là thời gian Hà Nội có vẻ đẹp rất riêng với không khí dịu nhẹ, nhiều tuyến phố rợp bóng cây và nhịp sống đô thị trở nên dễ cảm nhận hơn. Ngoài mùa thu, mùa xuân từ khoảng tháng 2 đến tháng 4 cũng là giai đoạn phù hợp để du lịch, khi thời tiết nhìn chung ôn hòa, cây cối xanh tươi và nhiều lễ hội truyền thống diễn ra sau Tết. Mùa hè ở Hà Nội thường nóng và ẩm, có thể xuất hiện mưa lớn theo đợt, trong khi mùa đông khá lạnh và khô, phù hợp hơn với những ai muốn trải nghiệm một Hà Nội trầm lắng, mang sắc thái mùa rõ rệt.',
    N'The most pleasant time to explore Hanoi is usually during autumn, from around September to November, when the weather is cool, dry, and comfortable for outdoor activities. This is also the season when Hanoi takes on a particularly distinctive beauty, with gentle air, tree-lined streets, and an urban rhythm that feels especially memorable. In addition to autumn, spring from around February to April is also a good period for travel, thanks to generally mild weather, fresh greenery, and the presence of many traditional festivals after the Lunar New Year. Summer in Hanoi is typically hot and humid, with periods of heavy rain, while winter can be cold and dry, making it more suitable for travelers who want to experience a quieter and more seasonal side of the city.',
    N'https://imagevietnam.vnanet.vn//MediaUpload/Org/2023/05/18/vna-potal-lang-bac-noi-hoi-tu-niem-tin-tinh-cam-kinh-yeu-cua-nhan-dan-ca-nuoc-doi-voi-chu-tich-ho-chi-minh-673742918-9-47-2.jpg',
    N'https://hoanghamobile.com/tin-tuc/wp-content/uploads/2024/04/anh-ha-noi.jpg',
    1
),
(
    'HUE',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'TRUNG_BO'),
    N'Huế',
    N'Hue',
    N'Cố đô di sản và chiều sâu văn hóa cung đình',
    N'The former imperial capital with deep heritage and royal culture',
    N'Huế là một trong những địa phương có chiều sâu lịch sử và văn hóa nổi bật nhất của miền Trung Việt Nam. Từng là kinh đô của triều Nguyễn, Huế hiện vẫn lưu giữ hệ thống di tích cung đình, lăng tẩm, đền đài và không gian kiến trúc mang giá trị đặc biệt trong lịch sử dân tộc. Bên cạnh quần thể di sản vật thể, Huế còn nổi tiếng với nhã nhạc cung đình, lễ hội truyền thống, phong cách sống trầm lắng và nền ẩm thực tinh tế. Thành phố mang đến cảm giác riêng biệt nhờ sự hòa quyện giữa sông Hương, núi Ngự, các công trình cổ và nhịp sống nhẹ nhàng. Trong hệ thống điểm đến của Việt Nam, Huế thường được xem là nơi thể hiện rõ nhất vẻ đẹp của di sản, ký ức lịch sử và bản sắc văn hóa cung đình.',
    N'Hue is one of the most historically and culturally significant destinations in Central Vietnam. As the former imperial capital of the Nguyen Dynasty, it still preserves an extensive system of royal citadels, tombs, temples, and architectural complexes of major national value. Beyond its tangible heritage, Hue is also well known for royal court music, traditional festivals, a calm urban rhythm, and a refined culinary tradition. The city offers a distinct atmosphere shaped by the Perfume River, Ngu Binh Mountain, historical monuments, and a gentle pace of life. In Vietnam''s tourism landscape, Hue is often regarded as the place that most clearly embodies heritage, historical memory, and royal cultural identity.',
    N'Thời điểm đẹp để tham quan Huế thường kéo dài từ khoảng tháng 1 đến tháng 4, khi tiết trời tương đối mát, ít nắng gắt, lượng mưa không quá lớn và thuận lợi cho việc khám phá các di tích ngoài trời. Đây cũng là giai đoạn cảnh quan thành phố khá dễ chịu, phù hợp với việc đi bộ, tham quan lăng tẩm, chùa chiền và trải nghiệm nhịp sống bên sông Hương. Ngoài ra, khoảng cuối xuân đến đầu hè, đặc biệt vào tháng 4 hoặc đầu tháng 5, cũng thường là thời gian thích hợp để kết hợp du lịch văn hóa với hoạt động lễ hội. Từ khoảng tháng 9 đến tháng 12, Huế bước vào mùa mưa, thời tiết ẩm và có thể có mưa kéo dài, trong khi mùa hè từ tháng 5 đến tháng 8 thường nắng nóng hơn, phù hợp với những ai chịu được nhiệt độ cao và muốn kết hợp tham quan vùng lân cận.',
    N'The most suitable time to visit Hue is generally from around January to April, when the weather is relatively cool, rainfall is moderate, and outdoor sightseeing is more comfortable. This period is especially favorable for exploring royal tombs, pagodas, heritage sites, and the riverside atmosphere of the city. Late spring to early summer, especially around April and early May, can also be a good time to combine cultural sightseeing with seasonal festivals and local events. From around September to December, Hue enters its rainy season, with humid conditions and the possibility of prolonged rain, while the months from May to August are hotter and sunnier, better suited to travelers who do not mind higher temperatures and want to combine Hue with nearby destinations.',
    N'https://cdn.daidoanket.vn/w1200/uploaded/images/2025/09/08/5aa109a2-bf3d-4a7e-b24f-34cc0fa93c7e.jpg',
    N'https://dulichhangkhong.com.vn/tour/vnt_upload/tour/06_Tour_du_lich_Hue_1.jpg',
    2
),
(
    'DA_NANG',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'TRUNG_BO'),
    N'Đà Nẵng',
    N'Da Nang',
    N'Thành phố biển năng động của miền Trung',
    N'A dynamic coastal city in Central Vietnam',
    N'Đà Nẵng là một trong những thành phố phát triển năng động nhất của miền Trung, nổi bật với sự kết hợp giữa hạ tầng hiện đại, bãi biển đẹp và vị trí kết nối thuận lợi với nhiều điểm di sản nổi tiếng. Thành phố được biết đến với các bãi biển dài, cảnh quan ven sông, cầu hiện đại, bán đảo Sơn Trà, Ngũ Hành Sơn và vai trò cửa ngõ đến Hội An, Huế hay Mỹ Sơn. Bên cạnh yếu tố đô thị hiện đại, Đà Nẵng vẫn giữ được sức hấp dẫn riêng nhờ môi trường tương đối thông thoáng, nhịp sống dễ tiếp cận và hệ thống dịch vụ du lịch phát triển. Trong bức tranh du lịch miền Trung, Đà Nẵng thường được xem là điểm đến tiêu biểu cho nghỉ dưỡng biển, du lịch gia đình và các hành trình kết hợp giữa thiên nhiên, thành phố và di sản.',
    N'Da Nang is one of the most dynamic cities in Central Vietnam, known for its combination of modern infrastructure, attractive beaches, and convenient access to major heritage destinations. The city is recognized for its long coastline, riverfront scenery, modern bridges, Son Tra Peninsula, Marble Mountains, and its role as a gateway to Hoi An, Hue, and My Son. Alongside its urban development, Da Nang maintains a strong appeal through its open environment, approachable rhythm of life, and well-developed tourism services. In the broader picture of Central Vietnam, Da Nang is often regarded as a representative destination for beach holidays, family travel, and itineraries that combine nature, city experiences, and heritage exploration.',
    N'Thời điểm đẹp nhất để du lịch Đà Nẵng thường kéo dài từ khoảng tháng 2 đến tháng 8, khi thời tiết khô ráo, nắng nhiều, biển trong và điều kiện thuận lợi cho các hoạt động ngoài trời như tắm biển, tham quan bán đảo Sơn Trà, Ngũ Hành Sơn hoặc du lịch kết hợp nghỉ dưỡng. Trong giai đoạn này, thành phố có khí hậu tương đối ổn định và dễ sắp xếp lịch trình. Từ khoảng tháng 9 đến tháng 12, Đà Nẵng bước vào mùa mưa, có thể xuất hiện những đợt mưa lớn hoặc thời tiết bất ổn, ảnh hưởng đến các hoạt động biển. Dù vậy, nếu mục tiêu chính là nghỉ ngơi trong đô thị hoặc khám phá ẩm thực, thành phố vẫn có thể được trải nghiệm quanh năm tùy nhu cầu.',
    N'The best time to visit Da Nang is generally from around February to August, when the weather is dry, sunny, and well suited to beach activities, sightseeing, and resort travel. During this period, sea conditions are usually favorable, and it is convenient to explore places such as Son Tra Peninsula, Marble Mountains, and nearby attractions. From around September to December, the city enters its rainy season, and periods of heavy rain or unstable weather may affect beach travel and outdoor plans. Even so, if the focus is on urban leisure, food experiences, or shorter stays, Da Nang can still be visited year-round depending on travel preferences.',
    N'https://cdnphoto.dantri.com.vn/TU79ri3KFMjhoSctnXOq3H7YS3U=/thumb_w/1360/2023/09/09/da-nang-docx-1694226826808.jpeg',
    N'https://bcp.cdnchinhphu.vn/334894974524682240/2025/9/18/cdhoian5-17581621538711341831070.jpeg',
    3
),
(
    'CAN_THO',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'NAM_BO'),
    N'Cần Thơ',
    N'Can Tho',
    N'Thủ phủ miền Tây và nhịp sống sông nước đặc trưng',
    N'The heart of the Mekong Delta and its distinctive river life',
    N'Cần Thơ là trung tâm lớn của đồng bằng sông Cửu Long, giữ vai trò quan trọng về kinh tế, giáo dục, giao thương và văn hóa của toàn vùng. Thành phố nổi tiếng với chợ nổi, bến sông, miệt vườn, các tuyến du lịch sinh thái và nhịp sống gắn liền với hệ thống kênh rạch. Không gian của Cần Thơ thể hiện rõ bản sắc sông nước Nam Bộ thông qua hoạt động buôn bán trên sông, ẩm thực miền Tây phong phú và sự gần gũi trong đời sống thường nhật. Bên cạnh đó, thành phố cũng là điểm trung chuyển thuận lợi để kết nối tới nhiều địa phương khác trong vùng. Trong hệ thống điểm đến Nam Bộ, Cần Thơ thường được xem là nơi tiêu biểu nhất để cảm nhận đời sống đồng bằng sông Cửu Long trong cả chiều sâu văn hóa lẫn trải nghiệm du lịch.',
    N'Can Tho is one of the major centers of the Mekong Delta and plays an important role in the region''s economy, education, commerce, and culture. The city is widely known for its floating markets, riverfront life, orchards, ecological tourism routes, and everyday activities shaped by canals and waterways. Can Tho clearly expresses the identity of Southern river culture through water-based trade, rich Mekong cuisine, and a warm everyday atmosphere. It also serves as a convenient hub for traveling to many other destinations in the delta. In the tourism landscape of Southern Vietnam, Can Tho is often regarded as the most representative place to experience the cultural depth and travel character of the Mekong Delta.',
    N'Thời điểm đẹp để khám phá Cần Thơ thường là vào mùa khô, từ khoảng tháng 12 đến tháng 4 năm sau, khi thời tiết tương đối ít mưa, di chuyển thuận lợi và phù hợp cho các hoạt động tham quan chợ nổi, đi xuồng, thăm miệt vườn hoặc trải nghiệm sinh thái. Đây cũng là giai đoạn nhiều loại trái cây trong vùng bắt đầu vào mùa, góp phần làm phong phú thêm trải nghiệm du lịch. Từ khoảng tháng 5 đến tháng 11 là mùa mưa, không khí ẩm hơn và có thể xuất hiện mưa theo cơn, nhưng đổi lại cảnh quan sông nước và vườn cây thường xanh tốt hơn. Nếu yêu thích sự trù phú của miền Tây và không ngại mưa ngắn, du khách vẫn có thể đến Cần Thơ vào mùa này.',
    N'The most suitable time to explore Can Tho is usually during the dry season, from around December to April, when rainfall is lower, transportation is easier, and conditions are favorable for visiting floating markets, taking boat trips, exploring orchards, and enjoying ecological tourism. This period also coincides with the availability of many seasonal fruits in the region, which adds depth to the travel experience. From around May to November, Can Tho enters the rainy season, with more humidity and occasional showers, but the river landscape and orchards are often greener and more vibrant. Travelers who enjoy the lush character of the delta and do not mind brief rain can still have a rewarding experience during this period.',
    N'https://mia.vn/media/uploads/blog-du-lich/kham-pha-net-dac-sac-cua-cho-noi-cai-rang-chon-mien-tay-song-nuoc-12-1649149954.jpeg',
    N'https://statics.vinpearl.com/dia-diem-du-lich-can-tho-2.jpg',
    4
),
(
    'LAM_DONG',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'TRUNG_BO'),
    N'Lâm Đồng',
    N'Lam Dong',
    N'Vùng cao nguyên mát lành với thành phố hoa và cảnh quan đồi núi đặc sắc',
    N'A cool highland region known for flower cities and distinctive mountain scenery',
    N'Lâm Đồng là tỉnh thuộc khu vực Tây Nguyên, nổi bật với địa hình cao nguyên, khí hậu mát mẻ và cảnh quan tự nhiên đa dạng. Đây là địa phương gắn liền với Đà Lạt - thành phố du lịch nổi tiếng, đồng thời cũng sở hữu nhiều vùng trồng chè, cà phê, rau hoa và các khu sinh thái đồi núi, hồ thác đặc sắc. Nhờ điều kiện khí hậu và địa hình riêng, Lâm Đồng mang đến một sắc thái khác biệt so với nhiều tỉnh thành khác ở miền Trung và miền Nam. Không chỉ có giá trị nghỉ dưỡng, địa phương này còn hấp dẫn bởi đời sống nông nghiệp công nghệ cao, không gian cao nguyên và hệ sinh thái du lịch thiên nhiên, văn hóa, canh nông khá phong phú. Trong bản đồ du lịch Việt Nam, Lâm Đồng thường được xem là điểm đến tiêu biểu cho khí hậu mát lành, du lịch cảnh quan và trải nghiệm vùng cao nguyên.',
    N'Lam Dong is a province in the Central Highlands, distinguished by its plateau terrain, cool climate, and diverse natural scenery. It is closely associated with Da Lat, one of Vietnam''s best-known tourist cities, and is also home to extensive tea, coffee, flower, and vegetable cultivation areas as well as mountain landscapes, lakes, and waterfalls. Because of its specific climate and topography, Lam Dong offers an atmosphere that differs markedly from many other provinces in Central and Southern Vietnam. Beyond its value as a resort destination, the province is also attractive for its high-tech agriculture, highland setting, and its combination of nature, culture, and agricultural tourism. In Vietnam''s travel map, Lam Dong is often regarded as a representative destination for cool weather, scenic travel, and highland experiences.',
    N'Thời điểm đẹp để du lịch Lâm Đồng có thể kéo dài gần như quanh năm, nhưng thường thuận lợi nhất từ khoảng tháng 11 đến tháng 4 năm sau, khi thời tiết khô ráo hơn, trời trong và phù hợp cho các hoạt động tham quan cảnh quan, nghỉ dưỡng và chụp ảnh. Đây cũng là giai đoạn nhiều khu vực tại Đà Lạt và vùng phụ cận bước vào mùa hoa, tạo thêm sức hút cho du lịch. Từ khoảng tháng 5 đến tháng 10 là mùa mưa, cây cối xanh tốt và cảnh quan cao nguyên có vẻ mềm hơn, nhưng việc di chuyển ngoài trời có thể bị ảnh hưởng bởi mưa. Tùy mục đích chuyến đi, du khách có thể chọn mùa khô để thuận tiện tham quan hoặc mùa mưa nhẹ để cảm nhận vẻ tươi mát, trầm lắng của vùng cao nguyên.',
    N'Lam Dong can be visited almost year-round, but the most convenient period is generally from around November to April, when the weather is drier, skies are clearer, and conditions are favorable for sightseeing, resort travel, and photography. This is also the time when many flower seasons begin in Da Lat and surrounding areas, adding to the appeal of the region. From around May to October, the province enters its rainy season; vegetation becomes lush and highland scenery feels softer and greener, though outdoor movement may be affected by rain. Depending on travel goals, visitors may choose the dry season for convenience or the rainy period for a fresher and more atmospheric highland experience.',
    N'https://www.dambri.com.vn/uploads/news/2020_07/nong-truong-che-tam-chau-dep-moc-mac-va-tho-mong.jpg',
    N'https://storage.googleapis.com/blogvxr-uploads/2025/03/854cefdb-lang-biang-da-lat-8351819.jpg',
    5
),
(
    'QUANG_NINH',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'BAC_BO'),
    N'Quảng Ninh',
    N'Quang Ninh',
    N'Vùng đất di sản và kỳ quan thiên nhiên',
    N'A land of heritage and natural wonders',
    N'Quảng Ninh là một trong những địa phương nổi bật nhất ở miền Bắc với lợi thế về biển đảo và tài nguyên du lịch đặc sắc. Nơi đây nổi tiếng với Vịnh Hạ Long – di sản thiên nhiên thế giới, cùng hệ thống đảo, bãi biển và cảnh quan ven biển đa dạng. Bên cạnh đó, Quảng Ninh còn có vai trò quan trọng về kinh tế biển, khai thác khoáng sản và giao thương quốc tế. Sự kết hợp giữa thiên nhiên kỳ vĩ và hệ thống đô thị phát triển đã tạo nên một điểm đến vừa mang giá trị nghỉ dưỡng, vừa có ý nghĩa về văn hóa và kinh tế.',
    N'Quang Ninh is one of the most prominent northern provinces, known for its coastal geography and remarkable tourism resources. It is home to Ha Long Bay, a UNESCO World Heritage Site, along with a wide system of islands, beaches, and coastal landscapes. In addition, Quang Ninh plays a key role in the marine economy, mining, and international trade. The combination of dramatic natural scenery and developed urban areas makes it a destination that blends leisure, cultural value, and economic significance.',
    N'Thời điểm đẹp để du lịch Quảng Ninh thường kéo dài từ khoảng tháng 10 đến tháng 4 năm sau, khi thời tiết mát mẻ, ít mưa, thuận lợi cho việc tham quan vịnh, đi tàu và khám phá các điểm du lịch ngoài trời. Đây là giai đoạn không khí trong lành, biển êm hơn và phù hợp cho các hoạt động nghỉ dưỡng nhẹ nhàng. Từ tháng 5 đến tháng 9 là mùa hè, thích hợp cho du lịch biển nhưng có thể xuất hiện nắng nóng và mưa bão theo từng đợt, cần theo dõi thời tiết khi lên kế hoạch.',
    N'The best time to visit Quang Ninh is generally from October to April, when the weather is cooler, drier, and more suitable for cruising Ha Long Bay and outdoor exploration. During this period, the air is clearer and sea conditions are often calmer. From May to September is summer, which is ideal for beach tourism but may include heat waves and occasional storms, so weather conditions should be monitored when planning a trip.',
    N'https://mia.vn/media/uploads/blog-du-lich/bien-quang-ninh-ti-top-1700870279.jpg',
    N'https://static.vinwonders.com/production/bien-quang-ninh-banner.jpeg',
    6
),
(
    'HAI_PHONG',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'BAC_BO'),
    N'Hải Phòng',
    N'Hai Phong',
    N'Thành phố cảng năng động miền Bắc',
    N'A dynamic northern port city',
    N'Hải Phòng là thành phố cảng quan trọng của miền Bắc, giữ vai trò trung tâm công nghiệp, logistics và giao thương quốc tế. Thành phố nổi bật với hệ thống cảng biển lớn, đồng thời sở hữu nhiều điểm du lịch hấp dẫn như Đồ Sơn, Cát Bà và vịnh Lan Hạ. Không chỉ có giá trị kinh tế, Hải Phòng còn mang nét đặc trưng riêng với văn hóa đô thị ven biển, ẩm thực phong phú và nhịp sống sôi động. Đây là điểm đến kết hợp giữa du lịch biển đảo và khám phá đô thị công nghiệp hiện đại.',
    N'Hai Phong is a major port city in northern Vietnam, playing a key role in industry, logistics, and international trade. It is known for its large seaport system and popular destinations such as Do Son, Cat Ba Island, and Lan Ha Bay. Beyond its economic importance, Hai Phong has a distinctive coastal urban culture, diverse cuisine, and a vibrant pace of life. It offers a combination of island tourism and modern industrial city exploration.',
    N'Thời điểm thích hợp để du lịch Hải Phòng thường từ tháng 10 đến tháng 4, khi thời tiết mát mẻ và ít mưa, phù hợp cho việc tham quan thành phố và khám phá các đảo. Mùa hè từ tháng 5 đến tháng 8 là thời gian cao điểm du lịch biển, đặc biệt tại Cát Bà và Đồ Sơn, tuy nhiên có thể xuất hiện nắng nóng hoặc mưa bão. Việc lựa chọn thời điểm phụ thuộc vào mục tiêu nghỉ dưỡng biển hay tham quan tổng thể.',
    N'The most suitable time to visit Hai Phong is from October to April, when the weather is cooler and drier, making it ideal for city tours and island exploration. Summer from May to August is peak beach season, especially in Cat Ba and Do Son, though it may include heat and occasional storms. The best timing depends on whether the focus is coastal relaxation or general sightseeing.',
    N'https://mia.vn/media/uploads/blog-du-lich/du-lich-do-son-hai-phong-02-1702344203.jpeg',
    N'https://images.vietnamtourism.gov.vn/vn//images/2024/thang_6/2606.cat_ba_1.jpg',
    7
),
(
    'THANH_HOA',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'TRUNG_BO'),
    N'Thanh Hóa',
    N'Thanh Hoa',
    N'Vùng đất rộng lớn với nhiều giá trị lịch sử',
    N'A large province rich in historical value',
    N'Thanh Hóa là một trong những tỉnh có diện tích và dân số lớn của Việt Nam, nằm ở khu vực Bắc Trung Bộ. Địa phương này sở hữu sự đa dạng về địa hình từ miền núi, đồng bằng đến ven biển, cùng nhiều di tích lịch sử và danh lam thắng cảnh. Thanh Hóa cũng là nơi gắn với nhiều sự kiện quan trọng trong lịch sử dân tộc. Bên cạnh yếu tố lịch sử, tỉnh còn có tiềm năng du lịch biển, sinh thái và văn hóa.',
    N'Thanh Hoa is one of the largest provinces in Vietnam in terms of both area and population, located in the North Central region. It features diverse landscapes ranging from mountains and plains to coastal areas, along with numerous historical sites and natural attractions. The province is associated with many important historical events and also offers strong potential for coastal, ecological, and cultural tourism.',
    N'Thời điểm đẹp để du lịch Thanh Hóa thường từ tháng 3 đến tháng 8, đặc biệt phù hợp với du lịch biển như Sầm Sơn hoặc Hải Tiến. Trong khoảng thời gian này, thời tiết ấm áp, nắng nhiều và thuận lợi cho các hoạt động ngoài trời. Mùa thu và mùa đông từ tháng 9 đến tháng 2 thời tiết mát hơn, thích hợp cho tham quan văn hóa và di tích, nhưng không phải thời điểm lý tưởng cho du lịch biển.',
    N'The best time to visit Thanh Hoa is from March to August, especially for coastal tourism such as Sam Son and Hai Tien. During this period, the weather is warm and sunny, suitable for outdoor activities. From September to February, the climate is cooler and better for cultural and historical exploration, though less ideal for beach travel.',
    N'https://cdn3.ivivu.com/2023/09/pu-luong-retreat-thanh-hoa-ivivu-1.jpg',
    N'https://image.plo.vn/w1000/Uploaded/2026/meyxqdbexq/2023_11_04/sam-son-mua-bien-vang-20-3615-2362.jpg.webp',
    8
),
(
    'NGHE_AN',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'TRUNG_BO'),
    N'Nghệ An',
    N'Nghe An',
    N'Vùng đất rộng lớn giàu truyền thống',
    N'A vast land with strong traditions',
    N'Nghệ An là tỉnh có diện tích lớn nhất cả nước, nằm ở khu vực Bắc Trung Bộ, với địa hình đa dạng từ miền núi, trung du đến ven biển. Đây là vùng đất có bề dày lịch sử, văn hóa và truyền thống hiếu học. Nghệ An cũng là nơi có nhiều khu sinh thái, bãi biển và các điểm du lịch văn hóa gắn với danh nhân lịch sử. Với quy mô rộng và tài nguyên đa dạng, tỉnh đóng vai trò quan trọng trong khu vực.',
    N'Nghe An is the largest province in Vietnam by area, located in the North Central region with diverse terrain including mountains, midlands, and coastal areas. It has a rich historical and cultural background, known for its strong educational traditions. The province also features ecological zones, beaches, and cultural destinations associated with historical figures. Its scale and resources make it an important region in central Vietnam.',
    N'Thời điểm thích hợp để du lịch Nghệ An thường từ tháng 11 đến tháng 4, khi thời tiết mát mẻ, ít nắng nóng và thuận tiện cho việc tham quan. Mùa hè từ tháng 5 đến tháng 8 có thể khá nóng, nhưng lại phù hợp cho du lịch biển như Cửa Lò. Tùy mục đích chuyến đi, du khách có thể lựa chọn thời gian phù hợp để trải nghiệm cả thiên nhiên và văn hóa.',
    N'The most suitable time to visit Nghe An is from November to April, when the weather is cooler and more comfortable for sightseeing. Summer from May to August can be quite hot but is ideal for beach destinations such as Cua Lo. Travel timing depends on whether the focus is coastal leisure or cultural exploration.',
    N'https://cdn-media.sforum.vn/storage/app/media/ctvseo_MH/%E1%BA%A3nh%20%C4%91%E1%BA%B9p%20ngh%E1%BB%87%20an/anh-dep-nghe-an-thumbnail.jpg',
    N'https://static.vinwonders.com/production/nghe-an-co-gi-7.jpg',
    9
),
(
    'KHANH_HOA',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'TRUNG_BO'),
    N'Khánh Hòa',
    N'Khanh Hoa',
    N'Thiên đường biển đảo miền Trung',
    N'A coastal paradise in Central Vietnam',
    N'Khánh Hòa là tỉnh ven biển miền Trung nổi tiếng với thành phố Nha Trang và hệ thống vịnh, đảo đẹp. Địa phương này có lợi thế lớn về du lịch biển, nghỉ dưỡng và dịch vụ, đồng thời cũng là trung tâm kinh tế biển quan trọng. Với khí hậu nhiều nắng, bãi biển dài và nước biển trong xanh, Khánh Hòa là điểm đến hấp dẫn cho du lịch trong và ngoài nước.',
    N'Khanh Hoa is a coastal province in Central Vietnam, best known for Nha Trang and its beautiful bays and islands. It has strong advantages in marine tourism, resort development, and services, while also serving as an important marine economic hub. With sunny weather, long beaches, and clear water, Khanh Hoa attracts both domestic and international visitors.',
    N'Thời điểm đẹp nhất để du lịch Khánh Hòa thường từ tháng 1 đến tháng 8, khi thời tiết khô ráo, biển êm và nắng đẹp, rất phù hợp cho các hoạt động tắm biển, lặn biển và nghỉ dưỡng. Từ tháng 9 đến tháng 12 có thể xuất hiện mưa và thời tiết không ổn định hơn, ảnh hưởng đến các hoạt động ngoài trời.',
    N'The best time to visit Khanh Hoa is from January to August, when the weather is dry, sunny, and the sea is calm, making it ideal for beach activities, diving, and resort stays. From September to December, rainfall and unstable weather may affect outdoor activities.',
    N'https://images2.thanhnien.vn/528068263637045248/2025/9/7/photo-1757250264974-17572502657161997023439.jpeg',
    N'https://media-cdn-v2.laodong.vn/storage/newsportal/2025/5/2/1500459/Khanh_Hoa.jpg',
    10
),
(
    'HO_CHI_MINH',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'NAM_BO'),
    N'TP. Hồ Chí Minh',
    N'Ho Chi Minh City',
    N'Đô thị lớn nhất và trung tâm kinh tế năng động',
    N'The largest and most dynamic economic hub',
    N'TP. Hồ Chí Minh là trung tâm kinh tế, tài chính và dịch vụ lớn nhất của Việt Nam, đồng thời là một trong những đô thị năng động nhất Đông Nam Á. Thành phố có nhịp sống nhanh, hiện đại, kết hợp với các giá trị lịch sử thể hiện qua hệ thống di tích, bảo tàng và kiến trúc thời thuộc địa. Bên cạnh đó, nơi đây còn nổi bật với nền ẩm thực phong phú, đời sống văn hóa đa dạng và khả năng kết nối mạnh mẽ với các tỉnh thành trong cả nước.',
    N'Ho Chi Minh City is the largest economic, financial, and service center in Vietnam, and one of the most dynamic cities in Southeast Asia. It features a fast-paced modern lifestyle combined with historical elements reflected in colonial architecture, museums, and landmarks. The city is also known for its diverse culinary scene, vibrant culture, and strong connectivity with other regions.',
    N'Thời điểm thích hợp để du lịch TP. Hồ Chí Minh thường là vào mùa khô, từ tháng 12 đến tháng 4, khi thời tiết ít mưa, nắng nhẹ và thuận tiện cho việc di chuyển, tham quan. Đây là giai đoạn phù hợp để khám phá thành phố, tham quan các địa điểm lịch sử và trải nghiệm ẩm thực. Từ tháng 5 đến tháng 11 là mùa mưa, thường có mưa theo cơn vào chiều hoặc tối, nhưng không kéo dài, vẫn có thể du lịch nếu linh hoạt lịch trình.',
    N'The most suitable time to visit Ho Chi Minh City is during the dry season, from December to April, when rainfall is minimal and travel is more convenient. This period is ideal for city exploration, historical sightseeing, and food experiences. From May to November is the rainy season, with short afternoon or evening showers, but travel is still possible with flexible planning.',
    N'https://dulichsaigon.edu.vn/wp-content/uploads/2024/01/dinh-doc-lap-di-tich-lich-su-tai-tphcm-luu-giu-nhieu-su-kien.jpg',
    N'https://static.vinwonders.com/production/ben-nha-rong-1.jpg',
    11
),
(
    'DONG_NAI',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'NAM_BO'),
    N'Đồng Nai',
    N'Dong Nai',
    N'Vùng công nghiệp và cửa ngõ Đông Nam Bộ',
    N'An industrial gateway of Southeast Vietnam',
    N'Đồng Nai là một trong những tỉnh phát triển mạnh về công nghiệp tại khu vực Đông Nam Bộ, giữ vai trò cửa ngõ kết nối TP. Hồ Chí Minh với các vùng lân cận. Ngoài thế mạnh kinh tế, Đồng Nai còn có hệ thống sông ngòi, rừng và khu sinh thái đa dạng, trong đó nổi bật là Vườn quốc gia Cát Tiên. Tỉnh mang đặc trưng của một địa phương vừa phát triển công nghiệp, vừa giữ được các không gian tự nhiên đáng chú ý.',
    N'Dong Nai is a rapidly developing industrial province in Southeast Vietnam, serving as a gateway connecting Ho Chi Minh City with surrounding regions. In addition to its economic strength, the province features rivers, forests, and ecological areas, notably Cat Tien National Park. It represents a balance between industrial growth and natural conservation.',
    N'Thời điểm phù hợp để tham quan Đồng Nai thường là mùa khô, từ tháng 12 đến tháng 4, khi thời tiết ít mưa và thuận tiện cho các hoạt động ngoài trời, đặc biệt là du lịch sinh thái. Mùa mưa từ tháng 5 đến tháng 11 có cảnh quan xanh hơn nhưng việc di chuyển có thể bị ảnh hưởng bởi mưa.',
    N'The best time to visit Dong Nai is during the dry season from December to April, when weather conditions are favorable for outdoor and eco-tourism activities. The rainy season from May to November brings greener landscapes but may affect travel plans.',
    N'https://vcdn1-dulich.vnecdn.net/2024/08/06/CT-8620-1722936588.jpg?w=0&h=0&q=100&dpr=2&fit=crop&s=XpLDEq84TuE4WkRPgCshzA',
    N'https://media-cdn-v2.laodong.vn/storage/newsportal/2023/9/24/1245797/Du-Lich-Dong-Nai-2-2.jpg',
    12
),
(
    'TAY_NINH',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'NAM_BO'),
    N'Tây Ninh',
    N'Tay Ninh',
    N'Vùng đất tâm linh và núi non đặc trưng',
    N'A spiritual land with unique mountain landscapes',
    N'Tây Ninh là tỉnh thuộc Đông Nam Bộ, nổi bật với núi Bà Đen – một trong những điểm du lịch tâm linh và sinh thái nổi tiếng. Ngoài ra, tỉnh còn có hệ thống hồ Dầu Tiếng và các khu vực nông nghiệp rộng lớn. Tây Ninh mang đặc trưng của vùng đất giao thoa giữa văn hóa, tôn giáo và thiên nhiên.',
    N'Tay Ninh is a province in Southeast Vietnam, known for Ba Den Mountain, a major spiritual and ecological destination. It also features Dau Tieng Lake and vast agricultural areas. The province reflects a blend of culture, religion, and natural landscapes.',
    N'Thời điểm đẹp để du lịch Tây Ninh thường từ tháng 12 đến tháng 4, khi thời tiết khô ráo, thích hợp cho leo núi, tham quan và du lịch tâm linh. Mùa mưa từ tháng 5 đến tháng 11 có thể gây khó khăn cho việc di chuyển, nhưng cảnh quan thiên nhiên lại xanh hơn.',
    N'The most suitable time to visit Tay Ninh is from December to April, when the weather is dry and ideal for mountain climbing and spiritual tourism. The rainy season from May to November may affect travel but offers greener landscapes.',
    N'https://cdn3.ivivu.com/2024/05/Sun-World-nui-Ba-Den-ivivu-1.jpg',
    N'https://images.vietnamtourism.gov.vn/vn//images/2019/CNMN/5.12.Ho_Dau_Tieng_-_diem_den_hap_dan_tai_Tay_Ninh_3.jpg',
    13
),
(
    'AN_GIANG',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'NAM_BO'),
    N'An Giang',
    N'An Giang',
    N'Vùng đất sông nước và văn hóa đa dạng',
    N'A region of waterways and diverse cultures',
    N'An Giang là tỉnh thuộc đồng bằng sông Cửu Long, nổi bật với hệ thống sông ngòi, núi non và đời sống văn hóa đa dạng của nhiều cộng đồng dân tộc. Tỉnh có nhiều điểm du lịch như Núi Sam, rừng tràm Trà Sư và các khu vực biên giới đặc trưng. An Giang mang đến trải nghiệm kết hợp giữa thiên nhiên, văn hóa và tín ngưỡng.',
    N'An Giang is a Mekong Delta province known for its rivers, mountains, and diverse cultural communities. It features attractions such as Sam Mountain, Tra Su cajuput forest, and unique border regions. The province offers a mix of nature, culture, and spiritual experiences.',
    N'Thời điểm đẹp để du lịch An Giang thường từ tháng 12 đến tháng 4, khi thời tiết khô ráo, thuận lợi cho tham quan. Ngoài ra, mùa nước nổi từ khoảng tháng 8 đến tháng 11 cũng mang đến trải nghiệm đặc trưng của miền Tây với cảnh quan ngập nước và sinh thái phong phú.',
    N'The best time to visit An Giang is from December to April during the dry season. The flooding season from August to November also offers unique Mekong Delta experiences with rich ecosystems and water landscapes.',
    N'https://images.baoangiang.com.vn/image/media/2024/20240325/video/thumbnail/690x420/4591_base64-17085713050892030784264copy.jpg',
    N'https://cdn3.ivivu.com/2025/12/du-lich-an-giang-ivivu-1.png',
    14
),
(
    'CA_MAU',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'NAM_BO'),
    N'Cà Mau',
    N'Ca Mau',
    N'Điểm cực Nam với hệ sinh thái rừng ngập mặn',
    N'The southernmost point with mangrove ecosystems',
    N'Cà Mau là tỉnh nằm ở cực Nam của Việt Nam, nổi bật với hệ sinh thái rừng ngập mặn rộng lớn và vùng biển giàu tài nguyên. Đây là nơi có Mũi Cà Mau – điểm cực Nam của Tổ quốc, cùng nhiều khu dự trữ sinh quyển và hệ sinh thái đặc thù. Cà Mau mang đến trải nghiệm thiên nhiên hoang sơ và văn hóa miền biển đặc trưng.',
    N'Ca Mau is the southernmost province of Vietnam, known for its extensive mangrove forests and rich marine resources. It is home to Cape Ca Mau, the southern tip of the country, along with biosphere reserves and unique ecosystems. The province offers raw natural experiences and distinctive coastal culture.',
    N'Thời điểm thích hợp để du lịch Cà Mau thường từ tháng 12 đến tháng 4, khi thời tiết khô ráo và thuận tiện cho việc di chuyển. Mùa mưa từ tháng 5 đến tháng 11 có thể ảnh hưởng đến lịch trình nhưng lại làm cho hệ sinh thái trở nên xanh tốt hơn.',
    N'The best time to visit Ca Mau is from December to April during the dry season, when travel conditions are more convenient. The rainy season from May to November may affect plans but enhances the lushness of the ecosystem.',
    N'https://vcdn1-dulich.vnecdn.net/2022/04/06/dulichCaMau01-1649220925-3009-1649240147.jpg?w=0&h=0&q=100&dpr=2&fit=crop&s=__uuV0wfll0lZgX01LNRsA',
    N'https://mia.vn/media/uploads/blog-du-lich/cho-noi-ca-mau-net-doc-dao-cua-mien-tay-song-nuoc-3-1663303247.jpg',
    15
),
(
    'CAO_BANG',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'BAC_BO'),
    N'Cao Bằng',
    N'Cao Bang',
    N'Vùng non nước biên cương với cảnh quan hùng vĩ',
    N'A northern borderland of majestic mountain landscapes',
    N'Cao Bằng là tỉnh miền núi phía Bắc nổi bật với cảnh quan tự nhiên hùng vĩ, hệ thống núi đá, sông suối và các điểm đến giàu giá trị sinh thái, lịch sử. Đây là vùng đất có bản sắc văn hóa dân tộc đậm nét, đồng thời giữ vai trò quan trọng ở khu vực biên giới phía Bắc. Những địa danh như thác Bản Giốc, động Ngườm Ngao và các tuyến du lịch cộng đồng đã góp phần tạo nên hình ảnh một Cao Bằng vừa hoang sơ vừa giàu chiều sâu văn hóa.',
    N'Cao Bang is a northern mountainous province known for its dramatic natural landscapes, limestone formations, rivers, and destinations of ecological and historical value. It is also a land of strong ethnic cultural identity and an important border province in northern Vietnam. Attractions such as Ban Gioc Waterfall, Nguom Ngao Cave, and community-based tourism routes shape the image of Cao Bang as both pristine and culturally rich.',
    N'Thời điểm đẹp để du lịch Cao Bằng thường từ tháng 9 đến tháng 11, khi thời tiết mát mẻ, ít mưa và cảnh quan miền núi trở nên trong trẻo, thuận lợi cho việc di chuyển và tham quan. Đây cũng là giai đoạn thác Bản Giốc thường có lượng nước đẹp và khung cảnh thiên nhiên rất ấn tượng. Ngoài ra, mùa xuân từ khoảng tháng 2 đến tháng 4 cũng phù hợp với những ai muốn trải nghiệm không khí vùng cao và các sinh hoạt văn hóa địa phương. Mùa đông có thể lạnh rõ rệt, trong khi mùa hè dễ xuất hiện mưa, cần cân nhắc khi đi các cung đường đèo núi.',
    N'The best time to visit Cao Bang is usually from September to November, when the weather is cool, rainfall is lower, and mountain scenery becomes especially clear and appealing for travel and sightseeing. This is also a favorable period for seeing Ban Gioc Waterfall in impressive condition. Spring, from around February to April, is also suitable for travelers interested in highland atmosphere and local cultural life. Winter can be quite cold, while summer often brings rain that may affect mountain-road travel.',
    N'https://images.vietnamtourism.gov.vn/vn//images/2019/CNMN/16.10._Thac_Ban_gioc_ve_dep_ky_vi_giua_non_nuoc_cao_bang_3.jpg',
    N'https://www.vietnamairlines.com/content/dam/legacy-site-assets/SEO-images/2025%20SEO/Traffic%20TA/MB/nguom-ngao-cave/dramatic-limestone-formations-twist-and-curve-like-sculptural-masterpieces-shaped-by-millions-of-years.jpg',
    16
),
(
    'LANG_SON',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'BAC_BO'),
    N'Lạng Sơn',
    N'Lang Son',
    N'Cửa ngõ biên giới với bản sắc Đông Bắc',
    N'A northeastern border gateway with distinct regional identity',
    N'Lạng Sơn là tỉnh biên giới thuộc vùng Đông Bắc, nổi bật với vai trò cửa ngõ giao thương, địa hình núi đá và văn hóa địa phương đậm chất xứ Lạng. Bên cạnh giá trị kinh tế từ hoạt động biên mậu, địa phương còn có nhiều thắng cảnh, di tích và đặc sản gắn với đời sống vùng núi. Thành phố Lạng Sơn cùng các vùng phụ cận tạo nên một không gian vừa mang tính giao thương vừa mang đậm sắc thái văn hóa bản địa.',
    N'Lang Son is a border province in northeastern Vietnam, known as a gateway for trade, with limestone mountain terrain and a strong local cultural identity. Besides its economic importance in cross-border commerce, the province also offers scenic spots, historical sites, and specialties rooted in mountain life. Lang Son City and its surrounding areas create a landscape shaped by both trade and local cultural character.',
    N'Thời điểm đẹp để khám phá Lạng Sơn thường là vào mùa thu và đầu mùa đông, từ khoảng tháng 9 đến tháng 12, khi thời tiết mát, khô và thuận tiện cho việc tham quan cảnh quan miền núi cũng như trải nghiệm đời sống địa phương. Mùa xuân cũng là giai đoạn đáng chú ý với không khí lễ hội và cảnh sắc vùng cao tươi mới. Mùa hè có thể nóng hơn và có mưa theo đợt, ảnh hưởng phần nào đến việc di chuyển ngoài trời.',
    N'The most pleasant time to explore Lang Son is usually from September to December, when the weather is cool, dry, and well suited to mountain sightseeing and local cultural experiences. Spring is also attractive thanks to festive atmosphere and fresh highland scenery. Summer can be hotter and may include periods of rain that affect outdoor travel.',
    N'https://cdn-media.sforum.vn/storage/app/media/ctvseo_16/danh%20lam%20th%E1%BA%AFng%20c%E1%BA%A3nh%20L%E1%BA%A1ng%20S%C6%A1n/danh-lam-thang-canh-lang-son-1.jpg',
    N'https://statics.vinpearl.com/Anh%2017%20dia%20diem%20du%20lich%20lang%20son.jpg',
    17
),
(
    'TUYEN_QUANG',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'BAC_BO'),
    N'Tuyên Quang',
    N'Tuyen Quang',
    N'Vùng đất lịch sử và sinh thái miền núi',
    N'A mountainous land of history and eco-tourism',
    N'Tuyên Quang là tỉnh có vị trí quan trọng ở khu vực trung du và miền núi phía Bắc, đồng thời là địa phương mang đậm dấu ấn lịch sử cách mạng. Với không gian đồi núi, hồ, sông và các vùng cư trú của nhiều cộng đồng dân tộc, tỉnh có tiềm năng rõ về du lịch sinh thái, văn hóa và lịch sử. Tuyên Quang cũng là nơi phù hợp để phát triển các loại hình du lịch trải nghiệm gắn với thiên nhiên và đời sống vùng cao.',
    N'Tuyen Quang is an important province in the northern midlands and mountains and is also strongly associated with revolutionary history. With its landscape of hills, lakes, rivers, and settlements of diverse ethnic communities, the province has clear potential in eco-tourism, cultural tourism, and historical travel. It is well suited to forms of experiential tourism connected to nature and upland life.',
    N'Thời điểm phù hợp để du lịch Tuyên Quang thường từ tháng 9 đến tháng 4 năm sau, khi thời tiết mát hơn, thuận tiện cho việc tham quan cảnh quan thiên nhiên, di tích và các điểm du lịch cộng đồng. Mùa thu và đầu đông mang lại cảm giác dễ chịu cho các hành trình vùng núi. Mùa hè xanh hơn và giàu sức sống nhưng có thể kèm mưa, cần linh hoạt kế hoạch nếu di chuyển nhiều.',
    N'The suitable period to visit Tuyen Quang is usually from September to April, when the weather is cooler and more convenient for visiting natural landscapes, historical sites, and community tourism destinations. Autumn and early winter are especially comfortable for mountain itineraries. Summer is greener and more vibrant but may include rain, so travel plans should remain flexible.',
    N'https://statics.vinpearl.com/khu-du-lich-sinh-thai-na-hang-tuyen-quang_1736327122.jpg',
    N'https://tuyenquang.dcs.vn/Image/Large/202110228345_54978.jpg',
    18
),
(
    'LAO_CAI',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'BAC_BO'),
    N'Lào Cai',
    N'Lao Cai',
    N'Cửa ngõ vùng cao và du lịch núi phía Bắc',
    N'A northern highland gateway for mountain tourism',
    N'Lào Cai là tỉnh miền núi phía Bắc nổi bật với địa hình cao, khí hậu đa dạng và vai trò cửa ngõ giao thương vùng biên. Đây là địa phương gắn với nhiều điểm đến vùng cao nổi tiếng, đồng thời có bản sắc văn hóa dân tộc rất rõ nét. Từ các khu vực đô thị đến vùng núi, Lào Cai thể hiện sự kết hợp giữa hoạt động kinh tế biên giới, du lịch nghỉ dưỡng vùng cao và đời sống văn hóa cộng đồng.',
    N'Lao Cai is a northern mountainous province distinguished by high terrain, varied climate, and its role as a border trade gateway. It is associated with several of Vietnam''s best-known highland destinations and has a strong ethnic cultural identity. From urban areas to mountain districts, Lao Cai combines border economy, highland tourism, and community-based cultural life.',
    N'Thời điểm đẹp để du lịch Lào Cai thường từ tháng 9 đến tháng 11 và từ tháng 3 đến tháng 5, khi thời tiết khá dễ chịu, ít mưa lớn và phù hợp cho việc ngắm cảnh, đi lại vùng núi cũng như trải nghiệm khí hậu cao nguyên. Mùa đông có thể rất lạnh ở một số khu vực cao, phù hợp với những ai muốn cảm nhận không khí vùng núi rõ nét. Mùa hè xanh và giàu sức sống nhưng có thể xuất hiện mưa nhiều hơn.',
    N'The best time to visit Lao Cai is usually from September to November and from March to May, when the weather is relatively comfortable, heavy rain is less common, and conditions are favorable for mountain travel and scenic exploration. Winter can be quite cold in higher areas, appealing to those who want a stronger highland atmosphere. Summer is lush and vibrant but may bring more rain.',
    N'https://puolotrip.com/uploads/images/2023/09/mount-Fansipan-summit-view-1-jpg.webp',
    N'https://vcdn1-dulich.vnecdn.net/2024/02/20/Caotoc-3017-1708419387.jpg?w=0&h=0&q=100&dpr=2&fit=crop&s=2djLV-2NGoYJkcEY4tcMRg',
    19
),
(
    'DIEN_BIEN',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'BAC_BO'),
    N'Điện Biên',
    N'Dien Bien',
    N'Vùng đất lịch sử của Tây Bắc',
    N'A historic land of the Northwest',
    N'Điện Biên là tỉnh miền núi Tây Bắc gắn liền với giá trị lịch sử đặc biệt của chiến thắng Điện Biên Phủ, đồng thời sở hữu cảnh quan cao nguyên và thung lũng rộng lớn. Địa phương này mang đậm sắc thái vùng cao với hệ thống bản làng, văn hóa dân tộc và những tuyến đường đèo núi đặc trưng. Điện Biên là điểm đến phù hợp cho cả du lịch lịch sử lẫn trải nghiệm cảnh quan Tây Bắc.',
    N'Dien Bien is a northwestern mountainous province strongly associated with the historical significance of the Dien Bien Phu victory while also featuring broad valleys and highland landscapes. The province reflects a strong upland identity through its villages, ethnic culture, and characteristic mountain roads. Dien Bien is suitable for both historical tourism and scenic exploration in the Northwest.',
    N'Thời điểm đẹp để đến Điện Biên thường từ tháng 10 đến tháng 4, khi thời tiết khô ráo, nhiệt độ dễ chịu hơn và thuận tiện cho việc đi lại trên các tuyến vùng núi. Mùa xuân là giai đoạn mang lại cảnh sắc khá đẹp và không khí dễ chịu ở nhiều khu vực. Mùa mưa có thể làm việc di chuyển khó khăn hơn trên một số tuyến đường.',
    N'The best time to visit Dien Bien is usually from October to April, when the weather is drier, temperatures are more comfortable, and mountain travel is easier. Spring brings particularly pleasant scenery and atmosphere in many areas. The rainy season can make travel more difficult on some mountain routes.',
    N'https://example.com/dienbien-thumb.jpg',
    N'https://example.com/dienbien-hero.jpg',
    20
),
(
    'LAI_CHAU',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'BAC_BO'),
    N'Lai Châu',
    N'Lai Chau',
    N'Không gian núi cao và bản sắc vùng biên',
    N'A high-mountain borderland with strong local identity',
    N'Lai Châu là một tỉnh miền núi cao thuộc Tây Bắc, có địa hình hiểm trở, cảnh quan tự nhiên rộng lớn và bản sắc văn hóa dân tộc đậm nét. Địa phương này nổi bật với các cung đường đèo, thung lũng, ruộng bậc thang và đời sống cộng đồng vùng cao. Lai Châu phù hợp với các hành trình khám phá thiên nhiên, trải nghiệm văn hóa bản địa và du lịch gắn với vùng núi biên giới.',
    N'Lai Chau is a high mountainous province in the Northwest, known for rugged terrain, expansive natural scenery, and strong ethnic cultural identity. It is notable for mountain passes, valleys, terraced fields, and upland community life. Lai Chau is well suited to nature exploration, local cultural experience, and travel linked to border highlands.',
    N'Thời điểm phù hợp để du lịch Lai Châu thường từ tháng 9 đến tháng 4, khi thời tiết ít mưa hơn và thuận lợi cho việc di chuyển trên các cung đường miền núi. Mùa thu thường mang đến cảnh quan đẹp, trong khi mùa xuân tạo cảm giác tươi mới và dễ chịu. Mùa mưa có thể khiến việc đi lại phức tạp hơn ở một số khu vực cao.',
    N'The suitable time to visit Lai Chau is generally from September to April, when rainfall is lower and travel on mountain routes is more manageable. Autumn often offers beautiful scenery, while spring feels fresh and pleasant. The rainy season may complicate movement in higher areas.',
    N'https://dulich9.com/wp-content/uploads/2023/05/Kinh-nghiem-du-lich-Dien-Bien-Bao-tang-chien-thang-dien-Bien-Phu.jpg',
    N'https://vcdn1-dulich.vnecdn.net/2023/12/18/pha1-1702890533-1702890552-9831-1702890727.jpg?w=1200&h=0&q=100&dpr=1&fit=crop&s=FPXv_7prFzt29Pp9A-Z4ZQ',
    21
),
(
    'SON_LA',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'BAC_BO'),
    N'Sơn La',
    N'Son La',
    N'Cao nguyên, lòng hồ và văn hóa Tây Bắc',
    N'Plateaus, reservoirs, and Northwestern culture',
    N'Sơn La là tỉnh thuộc vùng Tây Bắc với không gian cao nguyên, đồi núi và lòng hồ rộng lớn, đồng thời có bản sắc dân tộc phong phú. Địa phương này nổi bật nhờ các cao nguyên, vùng cây ăn quả, hồ thủy điện và các điểm du lịch cộng đồng mang đậm nét miền núi. Sơn La là điểm đến thích hợp cho những ai quan tâm đến thiên nhiên, khí hậu vùng cao và trải nghiệm đời sống văn hóa Tây Bắc.',
    N'Son La is a Northwestern province characterized by plateaus, mountain landscapes, large reservoirs, and rich ethnic identity. It stands out through its plateaus, fruit-growing areas, hydropower lakes, and community-based tourism destinations that reflect mountain life. Son La is suitable for travelers interested in nature, highland climate, and Northwestern cultural experience.',
    N'Thời điểm đẹp để du lịch Sơn La thường là mùa xuân và mùa thu, khi thời tiết tương đối dễ chịu và cảnh quan có nhiều thay đổi theo mùa. Từ khoảng tháng 9 đến tháng 11 là giai đoạn phù hợp cho các chuyến đi ngắm cảnh và trải nghiệm vùng cao. Mùa xuân cũng hấp dẫn nhờ không khí mát và hoạt động văn hóa địa phương. Mùa hè xanh hơn nhưng có thể có mưa theo đợt.',
    N'The best time to visit Son La is usually in spring and autumn, when the weather is relatively pleasant and the landscape changes beautifully with the seasons. From around September to November is a favorable period for scenic travel and highland experiences. Spring is also attractive for its cool weather and local cultural activities. Summer is greener but may include periodic rain.',
    N'https://tiimtravel.vn/uploads/files/2023/05/17/moc-chau.jpg',
    N'https://cdn-media.sforum.vn/storage/app/media/ctvseo_MH/%E1%BA%A3nh%20%C4%91%E1%BA%B9p%20S%C6%A1n%20La/anh-dep-son-la-thumb.jpg',
    22
),
(
    'THAI_NGUYEN',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'BAC_BO'),
    N'Thái Nguyên',
    N'Thai Nguyen',
    N'Trung tâm công nghiệp và văn hóa trung du',
    N'An industrial and cultural center of the northern midlands',
    N'Thái Nguyên là một địa phương quan trọng ở vùng trung du miền núi phía Bắc, nổi bật với vai trò về công nghiệp, giáo dục và kết nối vùng. Bên cạnh đó, tỉnh còn được biết đến với không gian đồi chè, hồ đập, di tích lịch sử và bản sắc văn hóa trung du. Sự kết hợp giữa phát triển đô thị - công nghiệp và cảnh quan nông nghiệp, sinh thái tạo nên diện mạo khá riêng cho Thái Nguyên.',
    N'Thai Nguyen is an important province in the northern midlands and mountains, known for its roles in industry, education, and regional connectivity. It is also recognized for tea hills, lakes, historical sites, and the cultural identity of the midlands. The combination of urban-industrial development with agricultural and ecological landscapes gives Thai Nguyen a distinctive profile.',
    N'Thời điểm phù hợp để du lịch Thái Nguyên thường từ tháng 9 đến tháng 4 năm sau, khi thời tiết mát hơn, thuận lợi cho việc tham quan, trải nghiệm không gian chè và các điểm sinh thái. Mùa xuân cũng là thời gian khá đẹp để cảm nhận không khí trung du và các hoạt động văn hóa. Mùa hè nóng hơn và có thể kèm mưa theo đợt.',
    N'The suitable time to visit Thai Nguyen is generally from September to April, when the weather is cooler and more favorable for sightseeing, tea-landscape experiences, and ecological destinations. Spring is also a good time to enjoy the atmosphere of the midlands and local cultural activities. Summer can be hotter and may include periods of rain.',
    N'https://vcdn1-vnexpress.vnecdn.net/2025/11/28/8-2-1764298785-7087-1764299325.jpg?w=680&h=0&q=100&dpr=2&fit=crop&s=r3rNRcka0uzxaR0Dc5QCfg',
    N'https://loctancuong.vn/wp-content/uploads/2021/08/doi-che-tan-cuong-32.jpg',
    23
),
(
    'PHU_THO',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'BAC_BO'),
    N'Phú Thọ',
    N'Phu Tho',
    N'Đất Tổ và không gian trung du Bắc Bộ',
    N'The ancestral land and the northern midland region',
    N'Phú Thọ là vùng đất có ý nghĩa đặc biệt trong lịch sử và văn hóa Việt Nam, thường được nhắc đến với vai trò Đất Tổ gắn với tín ngưỡng thờ cúng Hùng Vương. Bên cạnh yếu tố tâm linh - lịch sử, địa phương còn mang đặc trưng của không gian trung du với đồi thấp, làng quê và các khu sinh thái, nghỉ dưỡng. Đây là điểm đến phù hợp cho các hành trình tìm hiểu lịch sử, văn hóa và trải nghiệm cảnh quan vùng chuyển tiếp giữa đồng bằng và miền núi.',
    N'Phu Tho holds special significance in Vietnamese history and culture, especially as the ancestral land associated with the Hung Kings and the related spiritual tradition. Beyond its historical and sacred dimension, the province also reflects the character of the northern midlands through low hills, rural landscapes, and ecological or leisure destinations. It is suitable for travelers interested in history, culture, and the transitional scenery between delta and mountain regions.',
    N'Thời điểm đẹp để đến Phú Thọ thường là mùa xuân, đặc biệt trong khoảng diễn ra các hoạt động lễ hội văn hóa, khi không khí sôi động và thời tiết tương đối dễ chịu. Ngoài ra, mùa thu cũng thích hợp cho việc tham quan và di chuyển. Mùa hè có thể nóng hơn, trong khi mùa đông khá khô và phù hợp với lịch trình ngắn.',
    N'The best time to visit Phu Tho is usually in spring, especially during cultural festival periods, when the atmosphere is vibrant and the weather is relatively pleasant. Autumn is also suitable for sightseeing and travel. Summer can be hotter, while winter is drier and suitable for shorter itineraries.',
    N'https://static.kinhtedouong.vn/w640/images/upload/12172025/6b53b98b-3878-43cf-bfa8-55e60b8edc39_5ca2ef49.jpg',
    N'https://upload.wikimedia.org/wikipedia/commons/3/3f/Trung_t%C3%A2m_Th%E1%BB%8B_x%C3%A3_Ph%C3%BA_Th%E1%BB%8D.png',
    24
),
(
    'BAC_NINH',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'BAC_BO'),
    N'Bắc Ninh',
    N'Bac Ninh',
    N'Kinh Bắc xưa và nhịp phát triển hiện đại',
    N'Historic Kinh Bac and modern development',
    N'Bắc Ninh là vùng đất gắn với không gian văn hóa Kinh Bắc, nổi bật với truyền thống làng nghề, dân ca quan họ và mật độ di tích lịch sử cao. Đồng thời, đây cũng là một trong những địa phương có tốc độ công nghiệp hóa nhanh ở miền Bắc. Sự kết hợp giữa nền tảng văn hóa lâu đời và nhịp phát triển hiện đại tạo nên bản sắc riêng cho địa phương này.',
    N'Bac Ninh is closely associated with the cultural space of Kinh Bac, known for craft villages, quan ho folk singing, and a high concentration of historical sites. At the same time, it is also one of the rapidly industrializing provinces in northern Vietnam. The combination of long-standing cultural foundations and modern development gives the province a distinctive identity.',
    N'Thời điểm phù hợp để khám phá Bắc Ninh thường là mùa xuân và mùa thu. Mùa xuân gắn với không khí lễ hội và các sinh hoạt văn hóa truyền thống, trong khi mùa thu có thời tiết dễ chịu, phù hợp cho tham quan các làng nghề, di tích và không gian văn hóa địa phương. Mùa hè nóng hơn và có thể có mưa.',
    N'The suitable time to explore Bac Ninh is usually in spring and autumn. Spring is associated with festivals and traditional cultural activities, while autumn offers pleasant weather for visiting craft villages, heritage sites, and local cultural spaces. Summer is hotter and may include rain.',
    N'https://cdn3.ivivu.com/2025/03/du-lich-bac-ninh-ivivu-1-1024x683.jpg',
    N'https://images.baodantoc.vn/uploads/2022/12/16/bbbb.jpg',
    25
),
(
    'HUNG_YEN',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'BAC_BO'),
    N'Hưng Yên',
    N'Hung Yen',
    N'Vùng đồng bằng giàu truyền thống văn hóa',
    N'A delta province rich in cultural traditions',
    N'Hưng Yên là tỉnh thuộc đồng bằng sông Hồng, nổi bật với truyền thống lịch sử, văn hóa và không gian nông nghiệp trù phú. Địa phương này gắn với Phố Hiến xưa và nhiều giá trị văn hóa vùng đồng bằng Bắc Bộ. Bên cạnh đó, Hưng Yên còn có lợi thế vị trí trong vùng thủ đô, tạo điều kiện thuận lợi cho phát triển kinh tế và du lịch ngắn ngày.',
    N'Hung Yen is a Red River Delta province known for its historical and cultural traditions as well as its fertile agricultural landscape. The province is associated with the old trading center of Pho Hien and many values typical of the northern delta. In addition, Hung Yen benefits from its location within the capital region, supporting both economic development and short-trip tourism.',
    N'Thời điểm đẹp để thăm Hưng Yên thường vào mùa xuân và mùa thu, khi thời tiết ôn hòa, thuận tiện cho việc đi lại và trải nghiệm không gian làng quê, di tích, lễ hội. Mùa hè nóng hơn, còn mùa đông nhìn chung khô và thích hợp cho các chuyến đi ngắn.',
    N'The best time to visit Hung Yen is usually in spring and autumn, when the weather is mild and suitable for exploring villages, historical sites, and festivals. Summer is hotter, while winter is generally dry and works well for shorter trips.',
    N'https://media-cdn-v2.laodong.vn/storage/newsportal/2021/2/15/880490/Van-Mieu-Pho-Hien.jpg?w=800&h=496&crop=auto&scale=both',
    N'https://cdn.tuoitrethudo.vn/stores/news_dataimages/tuoitrethudocomvn/112018/17/18/hung-yen-cong-nhan-do-thi-loai-v-cho-khu-vuc-8-xa-03-.3519.jpg',
    26
),
(
    'NINH_BINH',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'BAC_BO'),
    N'Ninh Bình',
    N'Ninh Binh',
    N'Vùng đất di sản, núi đá và chiều sâu lịch sử',
    N'A heritage land of limestone mountains and historical depth',
    N'Ninh Bình là một địa phương nổi bật của miền Bắc với cảnh quan núi đá vôi, hệ thống hang động, sông nước và di sản lịch sử đặc sắc. Đây là nơi thường được nhắc đến với các quần thể danh thắng, chùa chiền và không gian văn hóa lâu đời. Ninh Bình vừa có giá trị về du lịch cảnh quan, vừa có chiều sâu lịch sử, khiến địa phương này trở thành điểm đến quan trọng của vùng đồng bằng Bắc Bộ mở rộng.',
    N'Ninh Binh is a prominent northern destination known for limestone mountain scenery, cave systems, waterways, and remarkable historical heritage. It is often associated with scenic complexes, temples, and long-standing cultural spaces. Ninh Binh combines landscape tourism with strong historical depth, making it an important destination in the broader northern delta region.',
    N'Thời điểm đẹp để du lịch Ninh Bình thường là mùa xuân và mùa thu. Mùa xuân thuận lợi cho tham quan di tích, lễ chùa và tận hưởng không khí lễ hội đầu năm, trong khi mùa thu có thời tiết dịu hơn, thuận tiện cho các hành trình ngoài trời. Cuối xuân và đầu hè cũng là giai đoạn cảnh quan xanh tốt, thích hợp cho du lịch sinh thái.',
    N'The best time to visit Ninh Binh is usually in spring and autumn. Spring is favorable for visiting temples, heritage sites, and seasonal festivals, while autumn offers milder weather for outdoor itineraries. Late spring and early summer can also be attractive thanks to greener scenery and ecological travel opportunities.',
    N'',
    N'',
    27
),
(
    'HA_TINH',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'TRUNG_BO'),
    N'Hà Tĩnh',
    N'Ha Tinh',
    N'Dải đất Bắc Trung Bộ với biển và núi',
    N'A North Central land of coast and mountains',
    N'Hà Tĩnh là tỉnh thuộc khu vực Bắc Trung Bộ, có đặc trưng địa hình kết hợp giữa dãy núi, đồng bằng hẹp và vùng ven biển. Địa phương này mang đậm chiều sâu văn hóa, lịch sử và truyền thống học hành, đồng thời sở hữu nhiều không gian thiên nhiên có giá trị nghỉ dưỡng và khám phá. Hà Tĩnh là điểm đến phù hợp cho những hành trình tìm hiểu miền Trung theo hướng nhẹ nhàng, gần gũi và mang bản sắc địa phương rõ rệt.',
    N'Ha Tinh is a province in North Central Vietnam, characterized by a landscape that combines mountains, narrow plains, and coastal areas. It has strong cultural and historical depth, a tradition of learning, and several natural spaces suitable for leisure and exploration. Ha Tinh is a fitting destination for travelers seeking a quieter and more locally rooted Central Vietnam experience.',
    N'Thời điểm phù hợp để đến Hà Tĩnh thường là mùa xuân và đầu hè, khi thời tiết tương đối ổn định và thuận lợi cho các hoạt động tham quan, nghỉ dưỡng biển hoặc khám phá địa phương. Từ cuối hè đến cuối năm có thể xuất hiện mưa nhiều hơn, ảnh hưởng đến lịch trình ngoài trời. Nếu mục tiêu là đi biển, nên ưu tiên giai đoạn từ khoảng tháng 4 đến tháng 8.',
    N'The suitable time to visit Ha Tinh is generally in spring and early summer, when the weather is relatively stable and favorable for sightseeing, beach leisure, and local exploration. From late summer to the end of the year, rainfall may increase and affect outdoor plans. If the main goal is coastal travel, the period from around April to August is preferable.',
    N'https://cdn3.ivivu.com/2024/05/du-lich-ninh-binh-ivivu-4-1536x1016.jpg',
    N'https://media.vietravel.com/images/Content/du-lich-ninh-binh-pho-co-hoa-lu-1229.png',
    28
),
(
    'QUANG_TRI',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'TRUNG_BO'),
    N'Quảng Trị',
    N'Quang Tri',
    N'Vùng đất ký ức lịch sử và biển miền Trung',
    N'A land of historical memory and Central Vietnamese coast',
    N'Quảng Trị là địa phương mang dấu ấn lịch sử sâu sắc trong ký ức hiện đại của Việt Nam, đồng thời cũng sở hữu không gian biển, đồi cát và các tuyến giao thương quan trọng của miền Trung. Bên cạnh giá trị lịch sử, tỉnh còn có tiềm năng phát triển du lịch biển, du lịch hoài niệm và du lịch văn hóa. Đây là vùng đất phù hợp với những hành trình tìm hiểu lịch sử kết hợp trải nghiệm cảnh quan miền Trung.',
    N'Quang Tri is a province marked by deep historical significance in modern Vietnamese memory, while also offering coastal spaces, sandy landscapes, and important transport links in Central Vietnam. Beyond its historical value, it also has potential for beach tourism, remembrance travel, and cultural tourism. It is well suited to itineraries that combine historical learning with Central Vietnamese landscapes.',
    N'Thời điểm đẹp để đến Quảng Trị thường từ tháng 3 đến tháng 8, khi thời tiết khô ráo hơn và thuận lợi cho việc tham quan biển cũng như các điểm ngoài trời. Mùa mưa từ khoảng tháng 9 đến cuối năm có thể ảnh hưởng đến việc di chuyển và tham quan. Nếu muốn kết hợp biển và lịch sử, giai đoạn đầu hè là lựa chọn tương đối phù hợp.',
    N'The best time to visit Quang Tri is usually from March to August, when the weather is drier and more favorable for coastal travel and outdoor sightseeing. The rainy period from around September to the end of the year may affect mobility and travel plans. If the goal is to combine beach destinations with historical sites, early summer is a relatively suitable choice.',
    N'https://images.vietnamtourism.gov.vn/vn//images/2023/thang_7/0507.chuyen-doi-so-chia-khoa-phat-trien-du-lich-quang-tri-1.jpeg',
    N'https://special.nhandan.vn/Du-lich-bien-Cua-Tung/assets/BV4Tn21mkj/77-4096x2304.jpg',
    29
),
(
    'QUANG_NGAI',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'TRUNG_BO'),
    N'Quảng Ngãi',
    N'Quang Ngai',
    N'Vùng duyên hải miền Trung với biển và cao nguyên kết nối',
    N'A Central coastal region linking sea and highlands',
    N'Quảng Ngãi là địa phương thuộc miền Trung có lợi thế về không gian duyên hải, đồng thời kết nối với vùng cao nguyên ở phía Tây. Tỉnh có cảnh quan biển, đảo, đồng bằng ven biển và nhiều giá trị lịch sử, văn hóa gắn với miền Trung. Sự kết hợp giữa yếu tố biển, địa hình chuyển tiếp và đời sống văn hóa địa phương tạo cho Quảng Ngãi một bản sắc tương đối đa dạng trong hệ thống điểm đến miền Trung.',
    N'Quang Ngai is a Central Vietnamese province with strengths in coastal geography and links toward the highlands in the west. It includes seaside scenery, islands, coastal plains, and various cultural and historical values associated with Central Vietnam. The combination of marine features, transitional terrain, and local cultural life gives Quang Ngai a relatively diverse identity within the region''s destinations.',
    N'Thời điểm đẹp để du lịch Quảng Ngãi thường từ tháng 2 đến tháng 8, khi thời tiết khô hơn, nắng nhiều và phù hợp với các hoạt động biển đảo cũng như tham quan ngoài trời. Cuối năm là thời gian mưa nhiều hơn, có thể ảnh hưởng đến kế hoạch đi lại. Nếu ưu tiên du lịch biển, đầu hè là giai đoạn thuận lợi nhất.',
    N'The best time to visit Quang Ngai is generally from February to August, when the weather is drier, sunnier, and better suited to coastal and outdoor activities. The later part of the year tends to be wetter and may affect travel plans. For marine tourism, early summer is usually the most favorable period.',
    N'https://statics.vinpearl.com/du-lich-dao-ly-son_1742399380.jpg',
    N'https://static.vinwonders.com/production/dong-muoi-sa-huynh-1.jpg',
    30
),
(
    'GIA_LAI',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'TRUNG_BO'),
    N'Gia Lai',
    N'Gia Lai',
    N'Không gian từ cao nguyên đến duyên hải',
    N'A region stretching from highlands to the coast',
    N'Gia Lai là địa phương có không gian trải dài từ khu vực cao nguyên đến vùng duyên hải sau quá trình sắp xếp mới, tạo nên một cấu trúc địa lý và phát triển khá đặc biệt. Tỉnh mang cả sắc thái cao nguyên với núi đồi, khí hậu tương đối mát ở một số khu vực, lẫn yếu tố biển và đồng bằng ven duyên hải. Sự kết hợp này khiến Gia Lai trở thành một địa phương có tính đa dạng cao về cảnh quan, văn hóa và tiềm năng phát triển du lịch.',
    N'Gia Lai now spans a space that stretches from the highlands to the coast after the new administrative arrangement, giving it a distinctive geographic and developmental structure. The province contains both highland features such as mountains and relatively cool upland zones, as well as coastal and lowland characteristics. This combination makes Gia Lai highly diverse in landscape, culture, and tourism potential.',
    N'Thời điểm thuận lợi để khám phá Gia Lai thường từ tháng 11 đến tháng 4, khi khu vực cao nguyên bước vào mùa khô, thời tiết mát hơn và việc di chuyển tương đối thuận tiện. Tùy khu vực cụ thể, các thời điểm khác trong năm vẫn có giá trị trải nghiệm riêng, đặc biệt nếu muốn cảm nhận sự đa dạng giữa vùng cao và vùng duyên hải. Mùa mưa có thể khiến một số hành trình ngoài trời kém thuận tiện hơn.',
    N'The favorable time to explore Gia Lai is usually from November to April, when the highland areas enter the dry season, the weather is cooler, and travel is relatively easier. Depending on the exact area, other times of the year may still offer valuable experiences, especially for those interested in the contrast between uplands and coastal zones. The rainy season can make some outdoor itineraries less convenient.',
    N'https://www.vietnambooking.com/wp-content/uploads/2024/01/dia-diem-du-lich-gia-lai-1.jpg',
    N'https://images.vietnamtourism.gov.vn/vn/images/2021/Thang_6/nui_lua_chu_dang_ya__gia_lai_1572025654_resize.jpeg',
    31
),
(
    'DAK_LAK',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'TRUNG_BO'),
    N'Đắk Lắk',
    N'Dak Lak',
    N'Không gian kết nối Tây Nguyên và duyên hải',
    N'A space linking the Central Highlands and the coast',
    N'Đắk Lắk là địa phương có vai trò quan trọng trong khu vực Tây Nguyên và sau sắp xếp mới còn mang thêm không gian kết nối với vùng duyên hải. Tỉnh vốn nổi bật với cao nguyên bazan, cà phê, văn hóa bản địa và cảnh quan hồ, thác, rừng. Khi mở rộng không gian phát triển, Đắk Lắk càng thể hiện rõ tính đa dạng địa lý và tiềm năng du lịch - kinh tế trên cả trục cao nguyên và ven biển.',
    N'Dak Lak is an important province in the Central Highlands and, after the new arrangement, also gains stronger spatial links to the coastal region. It has long been known for basalt plateaus, coffee cultivation, indigenous culture, and landscapes of lakes, waterfalls, and forests. With its expanded development space, Dak Lak shows even greater geographic diversity and stronger tourism and economic potential across both highland and coastal axes.',
    N'Thời điểm đẹp để đến Đắk Lắk thường từ tháng 11 đến tháng 4, khi thời tiết khô ráo hơn, thuận lợi cho việc tham quan, trải nghiệm cao nguyên và di chuyển ngoài trời. Đây cũng là giai đoạn thích hợp để cảm nhận không gian Tây Nguyên rõ nét hơn. Mùa mưa từ khoảng tháng 5 đến tháng 10 làm cảnh quan xanh hơn nhưng có thể ảnh hưởng đến một số hoạt động.',
    N'The best time to visit Dak Lak is usually from November to April, when the weather is drier and more suitable for sightseeing, highland experiences, and outdoor travel. This is also a good time to appreciate the Central Highlands atmosphere more clearly. The rainy season from around May to October makes the landscape greener but may affect some activities.',
    N'https://cdn.realtech.com.vn/uploads/1/news/2025/9/du-lich-dak-lak-tay-nguyen.jpeg',
    N'https://booking.muongthanh.com/upload_images/images/H%60/thac-dray-nur-dray-sap.jpg',
    32
),
(
    'VINH_LONG',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'NAM_BO'),
    N'Vĩnh Long',
    N'Vinh Long',
    N'Không gian sông nước, vườn cây và văn hóa Nam Bộ',
    N'A riverine region of orchards and Southern culture',
    N'Vĩnh Long là địa phương mang đậm bản sắc sông nước Nam Bộ, nổi bật với hệ thống kênh rạch, vườn cây ăn trái và đời sống miệt vườn đặc trưng. Sau sắp xếp mới, không gian của tỉnh càng mở rộng hơn về chiều sâu văn hóa và sinh thái. Đây là vùng đất phù hợp với các loại hình du lịch sinh thái, trải nghiệm làng quê, ẩm thực địa phương và nhịp sống miền Tây gần gũi.',
    N'Vinh Long is a province deeply rooted in the river culture of Southern Vietnam, known for canals, orchards, and characteristic garden-based rural life. After the new administrative arrangement, its cultural and ecological space becomes even broader. It is well suited to ecological tourism, countryside experiences, local cuisine, and the approachable rhythm of the Mekong Delta.',
    N'Thời điểm thích hợp để du lịch Vĩnh Long thường là mùa khô từ tháng 12 đến tháng 4, khi thời tiết ổn định hơn và thuận tiện cho việc di chuyển bằng đường bộ lẫn đường thủy. Đây cũng là giai đoạn phù hợp để tham quan miệt vườn, trải nghiệm đời sống sông nước và khám phá ẩm thực địa phương. Mùa mưa làm cảnh quan xanh hơn và cây trái phong phú hơn ở một số thời điểm, nhưng có thể ảnh hưởng đến lịch trình ngoài trời.',
    N'The suitable time to visit Vinh Long is usually the dry season from December to April, when the weather is more stable and travel by road or water is more convenient. This period is also favorable for orchard visits, river-life experiences, and local culinary exploration. The rainy season brings greener scenery and, at times, richer fruit harvests, though it may affect outdoor plans.',
    N'https://etrip4utravel.s3-ap-southeast-1.amazonaws.com/images/tinymce/2021/07/9a7c62de-48cb-4bf0-a98f-b0a318c5440b.jpg',
    N'https://images.baodantoc.vn/uploads/2024/Thang-8/Ngay-25/Anh/vinh-long-10-1.jpg',
    33
),
(
    'DONG_THAP',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'NAM_BO'),
    N'Đồng Tháp',
    N'Dong Thap',
    N'Vùng đất sông nước, nông nghiệp trù phú và bản sắc miệt vườn Nam Bộ',
    N'A fertile riverine land of agriculture and Mekong garden culture',
    N'Đồng Tháp là tỉnh thuộc vùng đồng bằng sông Cửu Long, được hình thành trên cơ sở sắp xếp tỉnh Tiền Giang và tỉnh Đồng Tháp, với trung tâm hành chính đặt tại thành phố Mỹ Tho hiện nay. Địa phương này mang đậm đặc trưng của miền Tây Nam Bộ với hệ thống sông ngòi, kênh rạch, vườn cây ăn trái, vùng nông nghiệp trù phú và đời sống gắn chặt với sông nước. Không gian của tỉnh kết hợp giữa vùng cù lao, vùng ven sông Tiền, các khu vực sản xuất nông nghiệp quy mô lớn và những đô thị có vai trò trung tâm của khu vực. Nhờ sự kết hợp giữa điều kiện tự nhiên màu mỡ, mạng lưới giao thông thủy bộ thuận lợi và chiều sâu văn hóa miệt vườn, Đồng Tháp mới có tiềm năng rõ rệt về nông nghiệp, du lịch sinh thái, du lịch cộng đồng và phát triển kinh tế vùng. Trong bức tranh Nam Bộ, đây là một địa phương thể hiện khá rõ tinh thần sông nước, tính hiền hòa của cảnh quan đồng bằng và sự phong phú của đời sống nông nghiệp gắn với cây trái, hoa màu và đặc sản địa phương.',
    N'Dong Thap is a province in the Mekong Delta, formed through the reorganization of Tien Giang and Dong Thap provinces, with its administrative center located in present-day My Tho City. The province strongly reflects the character of Southern river-based culture through its dense network of rivers and canals, orchard areas, fertile agricultural zones, and a way of life closely tied to waterways. Its overall space combines islets, riverfront areas along the Tien River, large-scale farming regions, and urban centers that play an important role in the wider delta. With fertile natural conditions, convenient land and water transport, and a deep garden-based cultural identity, the new Dong Thap has strong potential in agriculture, eco-tourism, community-based tourism, and regional economic development. Within the broader landscape of Southern Vietnam, it stands out as a province that clearly represents river life, the gentle scenery of the delta, and the richness of an economy rooted in fruit cultivation, agricultural production, and local specialties.',
    N'Thời điểm đẹp để khám phá Đồng Tháp thường là vào mùa khô, từ khoảng tháng 12 đến tháng 4 năm sau, khi thời tiết ổn định hơn, ít mưa, thuận lợi cho việc di chuyển bằng cả đường bộ lẫn đường thủy. Đây là giai đoạn phù hợp để tham quan các đô thị trung tâm, trải nghiệm miệt vườn, du lịch sinh thái, ngắm cảnh sông nước và kết hợp khám phá ẩm thực địa phương. Ngoài ra, một số thời điểm trong mùa nước nổi và mùa trái cây cũng mang lại trải nghiệm rất đặc trưng của vùng đồng bằng, khi cảnh quan trở nên sinh động hơn, hệ sinh thái phong phú hơn và đời sống sông nước thể hiện rõ nét hơn. Tuy nhiên, từ khoảng tháng 5 đến tháng 11, thời tiết có thể mưa nhiều hơn và cần linh hoạt lịch trình nếu ưu tiên các hoạt động ngoài trời. Nhìn chung, Đồng Tháp có thể được trải nghiệm quanh năm, nhưng mùa khô vẫn là thời gian thuận tiện và dễ tiếp cận nhất đối với phần lớn hành trình du lịch.',
    N'The most suitable time to explore Dong Thap is usually during the dry season, from around December to April, when the weather is more stable, rainfall is lower, and travel by both road and water is more convenient. This is an ideal period for visiting urban centers, enjoying orchard-based experiences, exploring eco-tourism destinations, viewing river scenery, and discovering local cuisine. In addition, certain periods during the flood season and fruit seasons also offer very distinctive Mekong Delta experiences, when the landscape becomes more dynamic, ecosystems are richer, and river-based life is more vividly expressed. However, from around May to November, rainfall can be heavier, so outdoor itineraries may require greater flexibility. Overall, Dong Thap can be experienced throughout the year, but the dry season remains the most convenient and accessible period for most travel plans.',
    N'https://cdn-media.sforum.vn/storage/app/media/thanhhuyen/%E1%BA%A3nh%20%C4%91%E1%BA%B9p%20%C4%91%E1%BB%93ng%20th%C3%A1p/2/anh-dep-dong-thap-18.jpg',
    N'https://cdn2.fptshop.com.vn/unsafe/1920x0/filters:format(webp):quality(75)/tinh_dong_thap_e3c78c615b.jpg',
    34
);

INSERT INTO dbo.LeHoi
(
    MaLeHoi,
    TenVI,
    TenEN,
    ThoiGianVI,
    ThoiGianEN,
    DiaDiemVI,
    DiaDiemEN,
    MoTaNganVI,
    MoTaNganEN,
    NoiDungChiTietVI,
    NoiDungChiTietEN,
    VungID,
    TinhThanhID,
    DanTocID,
    ImageUrl,
    BannerUrl,
    NgayTao
)
VALUES
(
    'HOI_GIONG_SOC_SON',
    N'Hội Gióng Sóc Sơn',
    N'Giong Festival in Soc Son',
    N'Thường diễn ra vào tháng Giêng âm lịch, cao điểm từ mùng 6 đến mùng 8 tháng Giêng.',
    N'Usually held in the first lunar month, with peak activities from the 6th to the 8th day.',
    N'Khu di tích đền Sóc, Sóc Sơn, Hà Nội.',
    N'Soc Temple historical complex, Soc Son, Ha Noi.',
    N'Lễ hội truyền thống tiêu biểu tôn vinh Thánh Gióng, anh hùng huyền thoại trong tín ngưỡng dân gian Việt Nam.',
    N'A representative traditional festival honoring Saint Giong, the legendary hero in Vietnamese folk belief.',
    N'Hội Gióng Sóc Sơn là một trong những lễ hội truyền thống tiêu biểu của miền Bắc, gắn với tín ngưỡng thờ Thánh Gióng, vị anh hùng huyền thoại đã đánh giặc cứu nước rồi bay về trời tại vùng Sóc Sơn. Lễ hội không chỉ mang ý nghĩa tưởng niệm công lao của Thánh Gióng mà còn thể hiện tinh thần thượng võ, lòng yêu nước và niềm tự hào dân tộc trong đời sống văn hóa cộng đồng. Không gian lễ hội gắn chặt với đền Sóc, nơi được xem là điểm linh thiêng có ý nghĩa đặc biệt trong truyền thuyết dân gian.

Phần nghi lễ của hội thường diễn ra trang trọng với các hoạt động dâng hương, tế lễ, rước lễ và nhiều nghi thức truyền thống mang tính biểu tượng. Phần hội lại sôi động với các hoạt động tái hiện không khí hào hùng của truyền thuyết, thu hút đông đảo người dân địa phương và du khách. Sự kết hợp giữa nghi lễ linh thiêng và sinh hoạt hội hè dân gian tạo nên sức sống bền vững cho lễ hội này.

Trong hệ thống lễ hội Việt Nam, Hội Gióng Sóc Sơn là đại diện tiêu biểu cho loại hình lễ hội gắn với truyền thuyết lịch sử và tín ngưỡng anh hùng. Lễ hội góp phần bảo tồn ký ức cộng đồng, nghi lễ dân gian và các giá trị văn hóa phi vật thể của vùng đồng bằng Bắc Bộ.',
    N'The Giong Festival in Soc Son is one of the most representative traditional festivals of northern Vietnam, associated with the worship of Saint Giong, the legendary hero who defeated invaders and ascended to the heavens from the Soc Son area. The festival is not only a commemoration of his merit but also an expression of martial spirit, patriotism, and collective pride in Vietnamese cultural life. Its sacred setting is closely tied to Soc Temple, which holds special meaning in local legend.

The ceremonial section is solemn and usually includes incense offerings, processions, and traditional rites with strong symbolic meaning. The festive section is more vibrant, with activities that evoke the heroic spirit of the legend and attract both local residents and visitors. The balance between sacred ritual and folk celebration is what gives the festival its enduring vitality.

Within the wider system of Vietnamese festivals, the Giong Festival in Soc Son is a representative example of a festival rooted in heroic legend and folk belief. It helps preserve communal memory, ritual traditions, and intangible cultural values of the northern delta.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'BAC_BO'),
    (SELECT TinhThanhID FROM dbo.TinhThanh WHERE MaTinh = 'HA_NOI'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KINH'),
    N'https://mia.vn/media/uploads/blog-du-lich/hoi-giong-soc-son-dac-sac-di-san-van-hoa-phi-vat-the-duoc-unesco-cong-nhan-1639044254.jpg',
    N'https://cdn-media.sforum.vn/storage/app/media/wp-content/uploads/2023/12/le-hoi-den-giong-soc-son-thumb.jpg',
    GETDATE()
),
(
    'LE_HOI_CHUA_HUONG',
    N'Lễ hội Chùa Hương',
    N'Huong Pagoda Festival',
    N'Thường kéo dài từ tháng Giêng đến hết tháng Ba âm lịch.',
    N'Usually lasts from the first to the third lunar month.',
    N'Quần thể danh thắng Hương Sơn, Hà Nội.',
    N'Huong Son scenic and spiritual complex, Ha Noi.',
    N'Một trong những lễ hội hành hương lớn nhất Việt Nam, kết hợp tín ngưỡng Phật giáo với cảnh quan thiên nhiên.',
    N'One of the largest pilgrimage festivals in Vietnam, combining Buddhist devotion with natural scenery.',
    N'Lễ hội Chùa Hương là một trong những lễ hội hành hương lớn và nổi tiếng nhất ở Việt Nam, diễn ra trong quần thể thắng cảnh Hương Sơn. Đây là lễ hội mang đậm màu sắc Phật giáo nhưng đồng thời cũng là một hành trình du xuân, vãn cảnh và tìm về không gian tâm linh đầu năm. Không gian lễ hội trải rộng qua suối Yến, chùa Thiên Trù, động Hương Tích và nhiều điểm thờ tự khác, tạo nên một quần thể vừa linh thiêng vừa giàu giá trị cảnh quan.

Điểm đặc sắc của lễ hội nằm ở trải nghiệm hành hương kết hợp giữa đường thủy và đường bộ. Người tham gia thường đi đò trên suối Yến, sau đó tiếp tục hành trình vào các khu chùa, động để lễ Phật, dâng hương và tham quan. Không khí lễ hội vừa trang nghiêm vừa nhộn nhịp, phản ánh rõ truyền thống du xuân và đời sống tín ngưỡng của người Việt.

Trong bối cảnh văn hóa Việt Nam, lễ hội Chùa Hương là đại diện tiêu biểu cho loại hình lễ hội tâm linh gắn với thắng cảnh tự nhiên. Lễ hội có giá trị lớn về mặt văn hóa, du lịch và tinh thần, đồng thời góp phần duy trì một trong những không gian hành hương nổi tiếng nhất của miền Bắc.',
    N'The Huong Pagoda Festival is one of the largest and most famous pilgrimage festivals in Vietnam, held within the scenic Huong Son complex. It is deeply associated with Buddhist devotion, but it is also a spring journey through sacred landscapes. The festival space stretches across Yen Stream, Thien Tru Pagoda, Huong Tich Cave, and many other sacred sites, forming a setting that is both spiritual and visually impressive.

Its most distinctive feature is the combination of pilgrimage by both water and land. Participants usually travel by boat along Yen Stream and then continue on foot to pagodas and caves for worship, incense offerings, and sightseeing. The atmosphere is at once solemn and lively, clearly reflecting Vietnamese springtime pilgrimage traditions.

In Vietnamese cultural life, the Huong Pagoda Festival is a representative example of a spiritual festival closely linked with a natural scenic complex. It holds significant cultural, tourism, and spiritual value and helps preserve one of the best-known pilgrimage spaces in northern Vietnam.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'BAC_BO'),
    (SELECT TinhThanhID FROM dbo.TinhThanh WHERE MaTinh = 'HA_NOI'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KINH'),
    N'https://statics.vinpearl.com/le-hoi-chua-huong-4_1672157136.jpg',
    N'https://xdcs.cdnchinhphu.vn/446259493575335936/2025/1/20/khai-hoi-16748031489321955462578-173735362889132575682.jpg',
    GETDATE()
),
(
    'FESTIVAL_HUE',
    N'Festival Huế',
    N'Hue Festival',
    N'Tổ chức định kỳ theo chương trình lễ hội văn hóa của thành phố Huế.',
    N'Organized periodically according to Hue’s official cultural festival program.',
    N'Thành phố Huế.',
    N'Hue City.',
    N'Sự kiện văn hóa nghệ thuật lớn tôn vinh di sản cố đô, nghệ thuật cung đình và giao lưu quốc tế.',
    N'A major cultural event celebrating imperial heritage, court arts, and international exchange.',
    N'Festival Huế là sự kiện văn hóa nghệ thuật tiêu biểu gắn với thành phố Huế, được tổ chức nhằm tôn vinh giá trị của cố đô và quảng bá di sản văn hóa đặc sắc của miền Trung Việt Nam. Khác với nhiều lễ hội dân gian truyền thống có nguồn gốc tín ngưỡng, Festival Huế mang tính chất hiện đại trong cách tổ chức nhưng vẫn đặt nền tảng trên các giá trị lịch sử, kiến trúc, âm nhạc và mỹ thuật cung đình. Đây là dịp để Huế thể hiện vai trò của mình như một trung tâm di sản văn hóa lớn của cả nước.

Nội dung của Festival Huế thường rất phong phú, bao gồm các chương trình biểu diễn nghệ thuật, tái hiện không gian cung đình, lễ hội đường phố, trình diễn áo dài, triển lãm, hoạt động cộng đồng và giao lưu quốc tế. Nhờ sự đa dạng này, sự kiện không chỉ phục vụ nhu cầu thưởng thức nghệ thuật mà còn tạo điều kiện để di sản được tiếp cận theo cách sinh động, gần gũi hơn với công chúng hiện đại.

Trong hệ thống sự kiện văn hóa ở Việt Nam, Festival Huế là một đại diện tiêu biểu cho mô hình lễ hội đương đại dựa trên nền tảng di sản. Sự kiện góp phần quảng bá hình ảnh Huế, làm sống dậy các giá trị văn hóa truyền thống và tạo ra không gian giao lưu rộng mở giữa văn hóa Việt Nam với bạn bè quốc tế.',
    N'Hue Festival is a representative cultural and artistic event associated with Hue City, organized to honor the value of the former imperial capital and promote the outstanding heritage of Central Vietnam. Unlike many folk festivals rooted in local belief, Hue Festival is modern in structure while remaining firmly grounded in historical, architectural, musical, and courtly artistic values. It serves as an opportunity for Hue to affirm its role as one of Vietnam’s leading heritage centers.

The content of Hue Festival is typically diverse, including artistic performances, reconstructions of royal spaces, street celebrations, ao dai showcases, exhibitions, community activities, and international cultural exchange. Because of this variety, the event not only satisfies artistic appreciation but also helps present heritage in a more vivid and accessible way to contemporary audiences.

Within Vietnam’s cultural event system, Hue Festival stands as a representative example of a modern heritage-based festival. It promotes Hue’s image, revitalizes traditional cultural values, and creates an open platform for exchange between Vietnamese culture and international communities.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'TRUNG_BO'),
    (SELECT TinhThanhID FROM dbo.TinhThanh WHERE MaTinh = 'HUE'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KINH'),
    N'https://upload.wikimedia.org/wikipedia/commons/b/b2/Festival_Hu%E1%BA%BF_2008-14.JPG',
    N'https://baovephapluat.vn/data/images/0/2022/06/26/binhtt/3.jpg?dpi=150&quality=100&w=820',
    GETDATE()
),
(
    'LE_HOI_CAU_NGU_DA_NANG',
    N'Lễ hội Cầu Ngư Đà Nẵng',
    N'Whale Worship Festival in Da Nang',
    N'Thường diễn ra vào mùa xuân hoặc đầu mùa đánh bắt, tùy theo lệ làng và cộng đồng ngư dân địa phương.',
    N'Usually held in spring or at the beginning of the fishing season, depending on local custom.',
    N'Các làng chài ven biển Đà Nẵng.',
    N'Fishing villages along the coast of Da Nang.',
    N'Lễ hội truyền thống của ngư dân ven biển, cầu cho mưa thuận gió hòa, đánh bắt thuận lợi và bình an trên biển.',
    N'A traditional coastal fishermen’s festival praying for calm seas, good harvests, and safety at sea.',
    N'Lễ hội Cầu Ngư là một sinh hoạt tín ngưỡng quan trọng của cộng đồng ngư dân ven biển Đà Nẵng, gắn với tục thờ cá Ông và niềm tin cầu mong biển yên, sóng lặng, đánh bắt thuận lợi. Đây là loại hình lễ hội phản ánh rõ mối quan hệ giữa con người với biển cả, nơi yếu tố tâm linh và đời sống mưu sinh hòa quyện chặt chẽ với nhau. Lễ hội thường được tổ chức tại các lăng Ông hoặc khu vực làng chài có truyền thống lâu đời.

Phần nghi lễ thường bao gồm các nghi thức cúng tế, dâng hương, nghinh thần, cầu an và tri ân cá Ông như vị thần bảo hộ ngư dân. Bên cạnh đó là các hoạt động cộng đồng, biểu diễn dân gian, hát bả trạo hoặc những hình thức diễn xướng mang đậm sắc thái văn hóa biển. Không gian lễ hội vừa trang trọng vừa đậm chất làng chài, thể hiện tinh thần đoàn kết và niềm tin của cộng đồng cư dân ven biển.

Trong hệ thống lễ hội miền Trung, lễ hội Cầu Ngư Đà Nẵng là đại diện tiêu biểu cho văn hóa biển và tín ngưỡng ngư dân. Lễ hội có giá trị lớn trong việc bảo tồn ký ức cộng đồng, tập quán sinh hoạt truyền thống và các hình thức diễn xướng đặc thù của vùng duyên hải.',
    N'The Whale Worship Festival is an important ritual event of Da Nang’s coastal fishing communities, associated with the worship of the whale spirit and the belief in calm seas, safe voyages, and successful fishing seasons. It is a festival that clearly reflects the bond between people and the sea, where spiritual belief and livelihood are closely intertwined. The event is typically held at whale temples or in long-established fishing villages.

The ritual section usually includes offerings, incense ceremonies, spiritual processions, prayers for safety, and expressions of gratitude toward the whale as a guardian spirit of fishermen. Alongside the ceremonies are community activities, folk performances, bả trạo singing, and other forms of coastal performance traditions. The atmosphere is both solemn and deeply rooted in fishing-village life, expressing solidarity and shared belief.

Within the festival traditions of Central Vietnam, the Whale Worship Festival in Da Nang is a representative example of coastal culture and fishermen’s religious practice. It plays an important role in preserving community memory, maritime traditions, and distinctive performance forms of the central coast.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'TRUNG_BO'),
    (SELECT TinhThanhID FROM dbo.TinhThanh WHERE MaTinh = 'DA_NANG'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KINH'),
    N'https://baotangdanang.vn/wp-content/uploads/2024/03/h2.png',
    N'https://mia.vn/media/uploads/blog-du-lich/le-hoi-cau-ngu-da-nang-kham-pha-net-dac-sac-trong-van-hoa-ngu-dan-vung-bien-da-nang-04-1636815746.jpg',
    GETDATE()
),
(
    'LE_HOI_VIA_BA_CHUA_XU',
    N'Lễ hội Vía Bà Chúa Xứ Núi Sam',
    N'Lady Xu Festival at Sam Mountain',
    N'Thường diễn ra vào khoảng cuối tháng Tư âm lịch, cao điểm từ ngày 23 đến 27 tháng Tư âm lịch.',
    N'Usually held in the fourth lunar month, with peak activities from the 23rd to the 27th day.',
    N'Khu vực Núi Sam, Châu Đốc, An Giang.',
    N'Sam Mountain area, Chau Doc, An Giang.',
    N'Lễ hội tín ngưỡng lớn của Nam Bộ, thu hút đông đảo người hành hương và thể hiện rõ đời sống tâm linh vùng biên giới Tây Nam.',
    N'A major Southern spiritual festival attracting large numbers of pilgrims and reflecting the religious life of the southwestern border region.',
    N'Lễ hội Vía Bà Chúa Xứ Núi Sam là một trong những lễ hội tín ngưỡng nổi bật nhất ở Nam Bộ, gắn với miếu Bà Chúa Xứ tại khu vực Núi Sam, Châu Đốc. Lễ hội phản ánh sâu sắc đời sống tâm linh của cư dân miền Tây Nam Bộ, đặc biệt trong không gian giao thoa văn hóa vùng biên giới. Đối với đông đảo người dân, đây không chỉ là dịp hành hương mà còn là thời điểm cầu bình an, tài lộc và may mắn cho gia đình cũng như công việc làm ăn.

Lễ hội bao gồm nhiều nghi thức quan trọng như lễ tắm tượng, lễ thỉnh sắc, lễ túc yết, lễ xây chầu và các hoạt động cúng bái kéo dài trong nhiều ngày. Trong mùa lễ hội, khu vực quanh miếu Bà trở nên rất nhộn nhịp với dòng người hành hương từ nhiều nơi đổ về. Không gian này vừa mang sắc thái linh thiêng vừa phản ánh rõ sinh hoạt cộng đồng, thương mại, ẩm thực và văn hóa lễ hội vùng Nam Bộ.

Trong hệ thống lễ hội Việt Nam, lễ hội Vía Bà Chúa Xứ Núi Sam là đại diện tiêu biểu cho loại hình lễ hội tín ngưỡng dân gian có tầm ảnh hưởng lớn. Lễ hội không chỉ mang ý nghĩa tâm linh mà còn là biểu hiện sinh động của niềm tin cộng đồng, bản sắc vùng miền và sức sống bền vững của tín ngưỡng truyền thống trong đời sống hiện đại.',
    N'The Lady Xu Festival at Sam Mountain is one of the most prominent religious festivals in Southern Vietnam, associated with Lady Xu Temple in the Sam Mountain area of Chau Doc. The festival strongly reflects the spiritual life of the Mekong Delta, especially within the culturally diverse setting of the southwestern border region. For many participants, it is not only a pilgrimage but also a time to pray for peace, prosperity, and good fortune for family and livelihood.

The festival includes important rituals such as the bathing of the statue, sacred processions, solemn offerings, ceremonial performances, and many days of worship activities. During the festival season, the area around the temple becomes extremely lively as pilgrims arrive from many regions. The atmosphere is both sacred and socially vibrant, reflecting religious practice, community exchange, commerce, food culture, and festive life in Southern Vietnam.

Within the system of Vietnamese festivals, the Lady Xu Festival at Sam Mountain is a representative example of a large-scale folk religious festival. It carries strong spiritual significance while also serving as a vivid expression of collective belief, regional identity, and the enduring vitality of traditional worship in contemporary life.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'NAM_BO'),
    (SELECT TinhThanhID FROM dbo.TinhThanh WHERE MaTinh = 'AN_GIANG'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KINH'),
    N'https://file3.qdnd.vn/data/images/0/2024/12/07/upload_2049/via-ba.jpg?dpi=150&quality=100&w=870',
    N'https://phunuvietnam.mediacdn.vn/thumb_w/1098/179072216278405120/2024/12/4/z5487866133815086680702377f18f0da598dddc50c128-17333321511991857394191-0-89-534-944-crop-1733332175586686752618.jpg',
    GETDATE()
),
(
    'LE_HOI_DEN_HUNG',
    N'Lễ hội Đền Hùng',
    N'Hung Kings Temple Festival',
    N'Thường diễn ra vào tháng Ba âm lịch, chính hội vào ngày mùng 10 tháng Ba âm lịch.',
    N'Usually held in the third lunar month, with the main celebration on the 10th day of the third lunar month.',
    N'Khu di tích lịch sử Đền Hùng, Phú Thọ.',
    N'Hung Kings Temple Historical Site, Phu Tho.',
    N'Lễ hội quan trọng tưởng niệm các Vua Hùng, thể hiện đạo lý uống nước nhớ nguồn và ý thức về cội nguồn dân tộc.',
    N'A major festival honoring the Hung Kings, expressing gratitude to ancestors and awareness of national origins.',
    N'Lễ hội Đền Hùng là một trong những lễ hội có ý nghĩa sâu sắc nhất trong đời sống tinh thần của người Việt, gắn với tín ngưỡng thờ cúng Hùng Vương và truyền thống hướng về cội nguồn dân tộc. Lễ hội được tổ chức tại khu di tích Đền Hùng, nơi được xem là không gian linh thiêng gắn với các Vua Hùng – những nhân vật biểu tượng cho buổi đầu dựng nước trong tâm thức cộng đồng. Đây không chỉ là một sự kiện tín ngưỡng mà còn là dịp để khẳng định ý thức lịch sử, tinh thần đoàn kết và lòng biết ơn đối với tổ tiên.

Phần lễ của sự kiện được tổ chức trang trọng với các nghi thức dâng hương, dâng lễ, rước kiệu và tế lễ truyền thống. Trong thời gian diễn ra lễ hội, đông đảo người dân từ nhiều vùng miền hành hương về Đền Hùng để tưởng niệm và tham gia không khí linh thiêng của ngày giỗ Tổ. Bên cạnh phần nghi lễ, phần hội thường có các hoạt động văn hóa dân gian, biểu diễn nghệ thuật truyền thống, trò chơi dân gian và các hình thức sinh hoạt cộng đồng đậm bản sắc vùng trung du Bắc Bộ.

Trong hệ thống lễ hội Việt Nam, lễ hội Đền Hùng giữ vị trí rất đặc biệt vì gắn với biểu tượng cội nguồn của quốc gia. Lễ hội không chỉ có giá trị về tín ngưỡng mà còn có ý nghĩa lớn về lịch sử, giáo dục và bản sắc văn hóa. Đây là một trong những lễ hội tiêu biểu nhất thể hiện chiều sâu tinh thần của văn hóa Việt Nam.',
    N'The Hung Kings Temple Festival is one of the most meaningful festivals in the spiritual life of the Vietnamese people, closely associated with the worship of the Hung Kings and the tradition of honoring national origins. It is held at the Hung Kings Temple Historical Site, a sacred place linked to the legendary founders of the nation in Vietnamese cultural memory. More than a religious event, the festival is also an occasion to affirm historical consciousness, national unity, and gratitude toward ancestors.

Its ceremonial section is conducted with solemnity and includes incense offerings, ritual presentations, processions, and formal worship. During the festival period, large numbers of people from many regions travel to the site to pay tribute and take part in the sacred atmosphere of the ancestral commemoration day. Alongside the ritual section, the festive part often includes folk cultural activities, traditional performances, games, and community practices strongly associated with the northern midland region.

Within the system of Vietnamese festivals, the Hung Kings Temple Festival holds an especially important place because it is tied to the symbolic origin of the nation. It carries not only religious meaning but also strong historical, educational, and cultural value. It is one of the clearest festival expressions of the spiritual depth of Vietnamese culture.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'BAC_BO'),
    (SELECT TinhThanhID FROM dbo.TinhThanh WHERE MaTinh = 'PHU_THO'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KINH'),
    N'https://statics.vinpearl.com/le-hoi-den-hung-7_1740022946.jpg',
    N'https://dulichphutho.gov.vn/content-uploads/2025/02/2022-11-17-09-53-52-tin-nguong-tho-cung-hung-vuong-636319299650371334.png',
    GETDATE()
),
(
    'HOI_LIM',
    N'Hội Lim',
    N'Lim Festival',
    N'Thường diễn ra vào ngày 12 và 13 tháng Giêng âm lịch.',
    N'Usually held on the 12th and 13th days of the first lunar month.',
    N'Khu vực núi Lim và các làng quan họ, Bắc Ninh.',
    N'Lim Hill area and quan ho villages, Bac Ninh.',
    N'Lễ hội nổi tiếng của vùng Kinh Bắc, gắn với dân ca quan họ và không gian văn hóa làng truyền thống.',
    N'A famous Kinh Bac festival associated with quan ho folk singing and traditional village culture.',
    N'Hội Lim là một trong những lễ hội tiêu biểu nhất của vùng văn hóa Kinh Bắc, nổi tiếng với dân ca quan họ – loại hình nghệ thuật dân gian đặc sắc của miền Bắc Việt Nam. Lễ hội được tổ chức tại khu vực núi Lim và các làng lân cận, nơi sinh hoạt quan họ có truyền thống lâu đời. Đây không chỉ là một dịp hội xuân mà còn là không gian văn hóa đặc biệt để tôn vinh nghệ thuật hát đối đáp, phong tục làng xã và nếp sống cộng đồng của vùng Bắc Ninh.

Trong lễ hội, phần hấp dẫn nhất thường là các canh hát quan họ giữa liền anh, liền chị trong trang phục truyền thống, diễn ra trên thuyền, trong sân đình hoặc tại các điểm sinh hoạt văn hóa. Bên cạnh đó còn có các nghi lễ tế lễ, dâng hương và nhiều hoạt động hội hè như trò chơi dân gian, thi đấu, giao lưu cộng đồng. Không khí lễ hội vừa trang trọng vừa tươi vui, thể hiện đậm nét vẻ thanh lịch, tinh tế và giàu tính nghệ thuật của văn hóa Kinh Bắc.

Trong bức tranh lễ hội Việt Nam, Hội Lim là đại diện nổi bật cho loại hình lễ hội gắn với di sản diễn xướng dân gian. Giá trị lớn nhất của lễ hội nằm ở việc duy trì, thực hành và lan tỏa dân ca quan họ trong đời sống hiện đại. Đây là lễ hội có bản sắc rất rõ, vừa mang ý nghĩa vui xuân vừa có vai trò quan trọng trong bảo tồn văn hóa phi vật thể.',
    N'The Lim Festival is one of the most representative festivals of the Kinh Bac cultural region and is especially famous for quan ho folk singing, one of northern Vietnam’s most distinctive traditional art forms. The festival is held in the Lim Hill area and surrounding villages, where quan ho has been practiced for generations. It is not only a spring celebration but also a special cultural space for honoring responsive singing, village customs, and community life in Bac Ninh.

The most attractive part of the festival is usually the quan ho performances by male and female singers in traditional dress, held on boats, in communal-house yards, or at cultural gathering places. In addition, the festival includes ritual offerings, incense ceremonies, and many festive activities such as folk games, competitions, and community exchange. The atmosphere is both solemn and joyful, clearly reflecting the elegance, refinement, and artistic richness of Kinh Bac culture.

Within the broader picture of Vietnamese festivals, the Lim Festival is a prominent example of a festival linked to intangible performance heritage. Its greatest value lies in maintaining, practicing, and spreading quan ho singing in modern life. It is a highly distinctive festival that combines spring celebration with an important role in preserving intangible cultural heritage.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'BAC_BO'),
    (SELECT TinhThanhID FROM dbo.TinhThanh WHERE MaTinh = 'BAC_NINH'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KINH'),
    N'https://cafefcdn.com/203337114487263232/2024/2/20/hoi-lim-bac-ninh-01-1708313532253-17083135324491458662185-1708387397037-1708387397144378172565.jpeg',
    N'https://file3.qdnd.vn/data/images/0/2024/02/20/upload_2072/hat%20quan%20ho.webp',
    GETDATE()
),
(
    'LE_HOI_YEN_TU',
    N'Lễ hội Yên Tử',
    N'Yen Tu Festival',
    N'Thường khai hội từ tháng Giêng âm lịch và kéo dài trong mùa xuân.',
    N'Usually opens in the first lunar month and continues through the spring season.',
    N'Khu danh thắng Yên Tử, Quảng Ninh.',
    N'Yen Tu scenic and spiritual complex, Quang Ninh.',
    N'Lễ hội hành hương nổi tiếng gắn với Thiền phái Trúc Lâm và không gian Phật giáo núi Yên Tử.',
    N'A renowned pilgrimage festival associated with the Truc Lam Zen tradition and the Buddhist landscape of Yen Tu Mountain.',
    N'Lễ hội Yên Tử là một trong những lễ hội hành hương quan trọng của miền Bắc, gắn với núi Yên Tử – trung tâm Phật giáo lớn có ý nghĩa đặc biệt trong lịch sử văn hóa Việt Nam. Đây là nơi gắn với vua Trần Nhân Tông sau khi xuất gia, sáng lập Thiền phái Trúc Lâm, nên không gian lễ hội mang chiều sâu tôn giáo, triết lý và lịch sử rất rõ nét. Hành trình lên Yên Tử không chỉ là một chuyến vãn cảnh đầu xuân mà còn được xem như một cuộc hành hương về với cõi tâm linh và truyền thống Phật giáo Việt.

Trong mùa lễ hội, người dân và du khách hành hương lên các chùa, am, tháp trên núi để dâng hương, lễ Phật và chiêm bái. Ngoài yếu tố tín ngưỡng, hành trình này còn gắn với trải nghiệm cảnh quan núi rừng, mây trời và hệ thống di tích Phật giáo nằm dọc đường lên đỉnh. Sự hòa quyện giữa thiên nhiên hùng vĩ và không khí tĩnh tại, linh thiêng đã tạo nên sức hấp dẫn bền vững của lễ hội Yên Tử.

Trong hệ thống lễ hội Việt Nam, lễ hội Yên Tử là đại diện tiêu biểu cho loại hình lễ hội hành hương Phật giáo gắn với núi thiêng và di sản lịch sử tôn giáo. Lễ hội không chỉ có giá trị tâm linh mà còn góp phần nhắc nhớ truyền thống Trúc Lâm, tinh thần tu hành nhập thế và chiều sâu văn hóa Phật giáo Việt Nam.',
    N'The Yen Tu Festival is one of the most important pilgrimage festivals in northern Vietnam, associated with Yen Tu Mountain, a major Buddhist center of special significance in Vietnamese cultural history. It is linked to King Tran Nhan Tong, who later became a monk and founded the Truc Lam Zen tradition, so the festival space carries strong religious, philosophical, and historical depth. The journey to Yen Tu is not simply a spring excursion, but is also seen as a pilgrimage into spiritual life and Vietnamese Buddhist heritage.

During the festival season, pilgrims and visitors travel to the temples, shrines, and towers on the mountain to offer incense, worship, and pay respects. Beyond its spiritual dimension, the route is also valued for its mountain scenery, clouds, forests, and the Buddhist architectural sites located along the ascent. The combination of majestic nature and a serene sacred atmosphere gives the Yen Tu Festival its lasting appeal.

Within Vietnamese festival culture, the Yen Tu Festival is a representative example of a Buddhist pilgrimage festival associated with a sacred mountain and a religious historical legacy. It carries not only spiritual value but also helps preserve the memory of the Truc Lam tradition, engaged Buddhist practice, and the depth of Vietnamese Buddhist culture.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'BAC_BO'),
    (SELECT TinhThanhID FROM dbo.TinhThanh WHERE MaTinh = 'QUANG_NINH'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KINH'),
    N'https://statics.vinpearl.com/le-hoi-yen-tu-2_1638981927.jpg',
    N'https://uongbi.gov.vn/ckfinder/userfiles/images/Du%20khach%20ve%20Yen%20Tu.jpg',
    GETDATE()
),
(
    'LE_HOI_CAFE_BUON_MA_THUOT',
    N'Lễ hội Cà phê Buôn Ma Thuột',
    N'Buon Ma Thuot Coffee Festival',
    N'Tổ chức định kỳ, thường vào tháng 3.',
    N'Organized periodically, usually in March.',
    N'Thành phố Buôn Ma Thuột và các khu vực liên quan tại Đắk Lắk.',
    N'Buon Ma Thuot City and related locations in Dak Lak.',
    N'Sự kiện văn hóa - kinh tế tôn vinh cà phê, bản sắc Tây Nguyên và vai trò của Đắk Lắk trong ngành cà phê Việt Nam.',
    N'A cultural and economic event celebrating coffee, Central Highlands identity, and Dak Lak’s role in Vietnam’s coffee industry.',
    N'Lễ hội Cà phê Buôn Ma Thuột là một sự kiện văn hóa - kinh tế tiêu biểu của Đắk Lắk, được tổ chức nhằm tôn vinh giá trị của cà phê, quảng bá hình ảnh vùng đất Tây Nguyên và khẳng định vị thế của Buôn Ma Thuột trong ngành cà phê Việt Nam. Không giống các lễ hội dân gian cổ truyền, sự kiện này mang tính đương đại rõ rệt nhưng vẫn gắn chặt với bản sắc địa phương, với đời sống nông nghiệp và văn hóa của vùng cao nguyên.

Lễ hội thường bao gồm nhiều hoạt động như hội chợ, triển lãm, trưng bày sản phẩm cà phê, biểu diễn nghệ thuật, giao lưu văn hóa, quảng bá du lịch và các chương trình tôn vinh người làm cà phê. Trong nhiều kỳ lễ hội, yếu tố văn hóa Tây Nguyên cũng được nhấn mạnh thông qua âm nhạc, không gian cộng đồng, hình ảnh nhà dài, cồng chiêng và các sắc thái văn hóa bản địa. Nhờ vậy, lễ hội không chỉ giới thiệu một mặt hàng nông sản mà còn kể câu chuyện về một vùng đất và con người gắn bó với cây cà phê.

Trong bối cảnh văn hóa và kinh tế hiện đại, Lễ hội Cà phê Buôn Ma Thuột là đại diện tiêu biểu cho mô hình lễ hội gắn với sản vật địa phương và thương hiệu vùng. Sự kiện này góp phần quảng bá hình ảnh Đắk Lắk, thúc đẩy du lịch, thương mại và đồng thời tạo ra một không gian văn hóa có sức lan tỏa lớn đối với Tây Nguyên.',
    N'The Buon Ma Thuot Coffee Festival is a representative cultural and economic event of Dak Lak, organized to honor the value of coffee, promote the image of the Central Highlands, and affirm Buon Ma Thuot’s position within Vietnam’s coffee industry. Unlike older folk festivals rooted in communal belief, this event is clearly contemporary in structure, yet it remains closely tied to local identity, agricultural life, and highland culture.

The festival usually includes fairs, exhibitions, coffee showcases, art performances, cultural exchange, tourism promotion, and programs honoring coffee growers and producers. In many editions of the festival, Central Highlands culture is also highlighted through music, communal spaces, long-house imagery, gong culture, and indigenous cultural elements. As a result, the event does not merely present an agricultural product but tells the story of a land and a people shaped by coffee cultivation.

In the context of modern culture and economy, the Buon Ma Thuot Coffee Festival is a representative example of a regional product-based festival. It promotes Dak Lak’s image, supports tourism and trade, and creates a cultural platform with broad influence across the Central Highlands.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'TRUNG_BO'),
    (SELECT TinhThanhID FROM dbo.TinhThanh WHERE MaTinh = 'DAK_LAK'),
    NULL,
    N'https://daklak.gov.vn/documents/10181/3435120/km6-IMhQY540.jpg/b242c8af-00d3-4e42-ad3f-0d5f8a9a09fd?version=1.0&t=1739863856300',
    N'https://trungnguyenlegend.com/wp-content/uploads/2025/03/dauanlehoi.jpg',
    GETDATE()
),
(
    'FESTIVAL_HOA_DA_LAT',
    N'Festival Hoa Đà Lạt',
    N'Da Lat Flower Festival',
    N'Tổ chức định kỳ, thường vào cuối năm theo chương trình của địa phương.',
    N'Organized periodically, often toward the end of the year according to the local program.',
    N'Thành phố Đà Lạt, Lâm Đồng.',
    N'Da Lat City, Lam Dong.',
    N'Sự kiện văn hóa - du lịch tôn vinh hoa, cảnh quan Đà Lạt và bản sắc thành phố cao nguyên.',
    N'A cultural and tourism event celebrating flowers, Da Lat’s landscape, and the identity of the highland city.',
    N'Festival Hoa Đà Lạt là một trong những sự kiện văn hóa - du lịch đặc sắc nhất của Lâm Đồng, gắn với hình ảnh Đà Lạt như thành phố hoa và trung tâm du lịch nổi bật của vùng cao nguyên. Sự kiện được tổ chức nhằm tôn vinh nghề trồng hoa, vẻ đẹp cảnh quan, khí hậu đặc trưng và đời sống văn hóa của đô thị cao nguyên. Đây là lễ hội mang màu sắc hiện đại nhưng có khả năng thể hiện rất rõ bản sắc địa phương.

Nội dung của festival thường bao gồm các không gian trưng bày hoa, tiểu cảnh, trình diễn nghệ thuật, hoạt động đường phố, hội chợ, quảng bá sản phẩm địa phương và các chương trình gắn với du lịch nghỉ dưỡng. Hoa không chỉ xuất hiện như yếu tố trang trí mà còn trở thành ngôn ngữ biểu đạt vẻ đẹp của thành phố, của khí hậu cao nguyên và của đời sống sản xuất nông nghiệp công nghệ cao. Nhờ vậy, sự kiện tạo ra trải nghiệm hấp dẫn cho du khách đồng thời nâng cao hình ảnh thương hiệu của Đà Lạt và Lâm Đồng.

Trong hệ thống các lễ hội và sự kiện văn hóa Việt Nam, Festival Hoa Đà Lạt là đại diện tiêu biểu cho mô hình lễ hội gắn với cảnh quan, sản vật và thương hiệu đô thị. Sự kiện không chỉ thúc đẩy du lịch mà còn góp phần định hình bản sắc thành phố Đà Lạt như một không gian lãng mạn, sinh thái và giàu giá trị thẩm mỹ.',
    N'The Da Lat Flower Festival is one of the most distinctive cultural and tourism events in Lam Dong, closely associated with Da Lat’s image as the city of flowers and a leading highland destination. The event is organized to celebrate flower cultivation, natural beauty, the region’s characteristic climate, and the cultural life of the highland city. It is modern in form, yet highly effective in expressing local identity.

The festival usually includes flower exhibitions, decorative landscape spaces, artistic performances, street activities, fairs, local product promotion, and programs connected with resort tourism. Flowers appear not only as decorative elements but as a symbolic language expressing the beauty of the city, the highland climate, and the agricultural life of the region. In this way, the event creates an attractive experience for visitors while strengthening the image and brand of Da Lat and Lam Dong.

Within the broader system of Vietnamese festivals and cultural events, the Da Lat Flower Festival is a representative example of a festival built around landscape, local products, and urban identity. It not only promotes tourism but also helps shape Da Lat’s image as a romantic, ecological, and aesthetically rich city.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'TRUNG_BO'),
    (SELECT TinhThanhID FROM dbo.TinhThanh WHERE MaTinh = 'LAM_DONG'),
    NULL,
    N'https://nads.1cdn.vn/2024/09/20/5.-dalat-tp-festival-hoa-ha-huu-net.jpg',
    N'https://cdn.tcdulichtphcm.vn/upload/3-2024/images/2024-08-13/1723529072-z3970339397547_bcd43fe65ad8f334e06f34d8a90a3ede.jpg',
    GETDATE()
),
(
    'LE_HOI_HOA_BAN_DIEN_BIEN',
    N'Lễ hội Hoa Ban Điện Biên',
    N'Dien Bien Ban Flower Festival',
    N'Thường tổ chức vào tháng 3 hằng năm, vào mùa hoa ban nở.',
    N'Usually held in March, during the ban flower blooming season.',
    N'Tỉnh Điện Biên.',
    N'Dien Bien Province.',
    N'Lễ hội văn hóa đặc sắc tôn vinh hoa ban, thiên nhiên Tây Bắc và bản sắc các dân tộc vùng cao.',
    N'A distinctive cultural festival celebrating ban flowers, Northwestern nature, and the identity of upland ethnic communities.',
    N'Lễ hội Hoa Ban Điện Biên là một sự kiện văn hóa tiêu biểu của vùng Tây Bắc, gắn với hình ảnh hoa ban – loài hoa đặc trưng của núi rừng và có vị trí đặc biệt trong đời sống tinh thần của nhiều cộng đồng dân tộc. Lễ hội được tổ chức vào thời điểm hoa ban nở rộ, khi cảnh quan Điện Biên trở nên nổi bật với sắc trắng và tím nhạt trải khắp sườn núi, bản làng và các tuyến đường. Đây không chỉ là dịp tôn vinh vẻ đẹp thiên nhiên mà còn là cơ hội để giới thiệu chiều sâu văn hóa vùng cao tới du khách trong và ngoài nước.

Nội dung lễ hội thường bao gồm các chương trình nghệ thuật dân gian, trình diễn trang phục truyền thống, giới thiệu ẩm thực địa phương, sinh hoạt cộng đồng và các hoạt động gắn với bản sắc của nhiều dân tộc sinh sống tại Điện Biên. Không gian lễ hội vừa mang tính trình diễn vừa mang tính cộng đồng, nơi con người, thiên nhiên và văn hóa kết nối chặt chẽ với nhau. Hình ảnh hoa ban vì thế không chỉ đơn thuần là biểu tượng cảnh quan mà còn trở thành biểu tượng của ký ức, tình cảm và đời sống văn hóa vùng Tây Bắc.

Trong bức tranh lễ hội Việt Nam, Lễ hội Hoa Ban Điện Biên là đại diện tiêu biểu cho mô hình lễ hội hiện đại dựa trên biểu tượng thiên nhiên và nền tảng văn hóa dân tộc. Lễ hội góp phần quảng bá hình ảnh Điện Biên, tôn vinh miền núi Tây Bắc và tạo ra một không gian giao lưu văn hóa có giá trị thẩm mỹ, du lịch và cộng đồng rất rõ rệt.',
    N'The Dien Bien Ban Flower Festival is a representative cultural event of the Northwest, associated with the ban flower, a blossom deeply characteristic of the mountain landscape and spiritually meaningful to many upland ethnic communities. The festival is held during the blooming season, when Dien Bien’s scenery becomes especially striking with white and pale purple flowers spreading across hillsides, villages, and roads. It is not only an occasion to celebrate natural beauty but also an opportunity to introduce the cultural depth of the highlands to domestic and international visitors.

The festival usually includes folk art performances, traditional costume showcases, local culinary presentations, community activities, and programs expressing the identity of the many ethnic groups living in Dien Bien. Its atmosphere is both performative and communal, creating a space where people, nature, and culture are closely connected. In this context, the ban flower becomes more than a landscape symbol; it becomes a symbol of memory, affection, and highland cultural life.

Within the wider picture of Vietnamese festivals, the Dien Bien Ban Flower Festival is a representative example of a modern festival built around natural symbolism and ethnic cultural foundations. It helps promote the image of Dien Bien, honor the Northwestern highlands, and create a cultural exchange space with clear aesthetic, tourism, and community value.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'BAC_BO'),
    (SELECT TinhThanhID FROM dbo.TinhThanh WHERE MaTinh = 'DIEN_BIEN'),
    NULL,
    N'https://booking.muongthanh.com/upload_images/images/H%60/le-hoi-hoa-ban.jpg',
    N'https://media.baovanhoa.vn/zoom/1000/Uploaded/nguyenviethung/2025_02_12/hoaban_PSGV.jpg',
    GETDATE()
),
(
    'LE_HOI_LAM_KINH',
    N'Lễ hội Lam Kinh',
    N'Lam Kinh Festival',
    N'Thường tổ chức vào tháng 8 âm lịch, gắn với ngày giỗ Lê Thái Tổ.',
    N'Usually held in the eighth lunar month, associated with the death anniversary of Le Thai To.',
    N'Khu di tích Lam Kinh, Thanh Hóa.',
    N'Lam Kinh Historical Site, Thanh Hoa.',
    N'Lễ hội lịch sử tưởng niệm Lê Lợi và triều Hậu Lê, mang đậm giá trị truyền thống và tinh thần dựng nước, giữ nước.',
    N'A historical festival honoring Le Loi and the Later Le Dynasty, reflecting tradition and the spirit of nation-building and defense.',
    N'Lễ hội Lam Kinh là một lễ hội lịch sử quan trọng của Thanh Hóa, gắn với khu di tích Lam Kinh – nơi có ý nghĩa đặc biệt trong lịch sử triều Hậu Lê và cuộc khởi nghĩa Lam Sơn. Lễ hội nhằm tưởng niệm Anh hùng dân tộc Lê Lợi cùng các nhân vật có công trong quá trình dựng nghiệp và giữ nước. Đây là dịp để nhắc nhớ về một giai đoạn lịch sử lớn, đồng thời khẳng định niềm tự hào đối với truyền thống yêu nước và tinh thần độc lập dân tộc.

Phần lễ thường được tổ chức trong không khí trang nghiêm với các nghi thức dâng hương, tế lễ, rước kiệu và những hoạt động tưởng niệm gắn với không gian di tích. Phần hội có thể bao gồm các chương trình nghệ thuật truyền thống, trình diễn văn hóa dân gian, trò chơi cổ truyền và các hoạt động giáo dục lịch sử. Sự kết hợp giữa nghi lễ và sinh hoạt cộng đồng giúp lễ hội vừa giữ được chiều sâu trang trọng, vừa tạo sự kết nối với người dân đương đại.

Trong hệ thống lễ hội Việt Nam, lễ hội Lam Kinh là đại diện tiêu biểu cho loại hình lễ hội lịch sử gắn với di tích quốc gia và ký ức về triều đại phong kiến lớn. Lễ hội có giá trị đặc biệt trong việc bảo tồn truyền thống, giáo dục lịch sử và nuôi dưỡng ý thức cộng đồng về cội nguồn và các anh hùng dân tộc.',
    N'The Lam Kinh Festival is an important historical festival of Thanh Hoa, associated with the Lam Kinh historical site, a place of great significance in the history of the Later Le Dynasty and the Lam Son uprising. The festival is held to honor national hero Le Loi and other figures who contributed to the founding and defense of the nation. It is an occasion to remember a major historical period and to reaffirm pride in the traditions of patriotism and national independence.

The ceremonial section is usually conducted in a solemn atmosphere with incense offerings, formal rites, processions, and commemorative activities linked to the historical site. The festive section may include traditional performances, folk culture programs, old-style games, and historical education activities. The combination of ritual and community celebration allows the festival to preserve its dignity while remaining meaningful to contemporary participants.

Within the system of Vietnamese festivals, the Lam Kinh Festival is a representative example of a historical festival associated with a national heritage site and the memory of a major royal dynasty. It has special value in preserving tradition, educating the public about history, and nurturing collective awareness of national origins and heroic figures.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'TRUNG_BO'),
    (SELECT TinhThanhID FROM dbo.TinhThanh WHERE MaTinh = 'THANH_HOA'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KINH'),
    N'https://thanhnien.mediacdn.vn/Uploaded/minhhai/2022_09_17/dsc09014-2023.jpg',
    N'https://cellphones.com.vn/sforum/wp-content/uploads/2023/12/le-hoi-lam-kinh-4.jpg',
    GETDATE()
),
(
    'LE_HOI_HOA_PHUONG_DO',
    N'Lễ hội Hoa Phượng Đỏ',
    N'Red Flamboyant Flower Festival',
    N'Thường tổ chức vào khoảng tháng 5, thời điểm hoa phượng nở rực tại Hải Phòng.',
    N'Usually held around May, when flamboyant flowers bloom brightly in Hai Phong.',
    N'Thành phố Hải Phòng.',
    N'Hai Phong City.',
    N'Sự kiện văn hóa - du lịch tôn vinh biểu tượng hoa phượng và hình ảnh thành phố cảng năng động.',
    N'A cultural and tourism event celebrating the flamboyant flower and the image of the dynamic port city.',
    N'Lễ hội Hoa Phượng Đỏ là một sự kiện văn hóa - du lịch tiêu biểu của Hải Phòng, gắn với hình ảnh hoa phượng đỏ – loài hoa đã trở thành biểu tượng giàu cảm xúc của thành phố cảng. Mỗi khi vào mùa hoa nở, Hải Phòng mang một diện mạo rất riêng với sắc đỏ phủ khắp các tuyến phố, góp phần tạo nên bản sắc thị giác và tinh thần cho đô thị ven biển này. Lễ hội ra đời như một cách tôn vinh vẻ đẹp thành phố, quảng bá hình ảnh địa phương và tạo ra không gian sinh hoạt văn hóa quy mô lớn.

Các hoạt động trong lễ hội thường bao gồm biểu diễn nghệ thuật, chương trình cộng đồng, trình diễn đường phố, hoạt động quảng bá du lịch và nhiều nội dung gắn với hình ảnh thành phố Hải Phòng hiện đại, trẻ trung và năng động. Không khí lễ hội thường mang sắc thái tươi vui, cởi mở và giàu tính đô thị, khác với nhiều lễ hội truyền thống thuần tín ngưỡng. Tuy vậy, sự kiện vẫn có chiều sâu biểu tượng rõ rệt khi gắn với loài hoa quen thuộc đã ăn sâu vào ký ức của nhiều thế hệ người dân Hải Phòng.

Trong hệ thống lễ hội và sự kiện văn hóa đương đại của Việt Nam, Lễ hội Hoa Phượng Đỏ là đại diện tiêu biểu cho mô hình sự kiện đô thị mang tính biểu tượng địa phương. Nó góp phần định vị thương hiệu thành phố, thúc đẩy du lịch và tạo ra niềm tự hào cộng đồng gắn với một biểu tượng rất riêng của Hải Phòng.',
    N'The Red Flamboyant Flower Festival is a representative cultural and tourism event of Hai Phong, closely associated with the flamboyant flower, which has become one of the most emotional and recognizable symbols of the port city. During the blooming season, Hai Phong takes on a distinctive appearance as red blossoms line streets throughout the city, creating a strong visual and cultural identity. The festival was developed as a way to celebrate the city’s beauty, promote its image, and create a large-scale cultural space for residents and visitors.

Festival activities usually include artistic performances, community programs, street events, tourism promotion, and many elements linked to the image of Hai Phong as a modern, youthful, and dynamic city. The atmosphere is often lively, open, and urban in character, different from many traditional festivals rooted mainly in religious belief. Even so, the event retains strong symbolic meaning because it is associated with a flower deeply embedded in the memory of generations of Hai Phong residents.

Within the broader system of modern Vietnamese festivals and cultural events, the Red Flamboyant Flower Festival is a representative example of a city-based symbolic event. It helps position the city’s brand, supports tourism, and fosters community pride around an image that is uniquely associated with Hai Phong.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'BAC_BO'),
    (SELECT TinhThanhID FROM dbo.TinhThanh WHERE MaTinh = 'HAI_PHONG'),
    NULL,
    N'https://baovephapluat.vn/data/images/0/2023/02/02/hunghv/657f90f2-74fc-4d92-8b7c-76b4316405b1-1549185f24bb4343adb885eb6bf196fc.jpeg?dpi=150&quality=100&w=820',
    N'https://cdn2.fptshop.com.vn/unsafe/1920x0/filters:format(webp):quality(75)/le_hoi_hoa_phuong_do_la_gi_0_b0d4c74dd5.png',
    GETDATE()
),
(
    'LE_HOI_DUA_VOI_BUON_DON',
    N'Lễ hội Đua voi Buôn Đôn',
    N'Buon Don Elephant Racing Festival',
    N'Thường diễn ra vào mùa khô, tùy theo chương trình văn hóa của địa phương.',
    N'Usually held in the dry season, depending on the local cultural program.',
    N'Khu vực Buôn Đôn, Đắk Lắk.',
    N'Buon Don area, Dak Lak.',
    N'Lễ hội mang đậm bản sắc Tây Nguyên, tôn vinh voi, văn hóa bản địa và mối quan hệ giữa con người với thiên nhiên.',
    N'A Central Highlands festival celebrating elephants, indigenous culture, and the bond between people and nature.',
    N'Lễ hội Đua voi Buôn Đôn là một trong những sự kiện văn hóa nổi bật của Đắk Lắk, gắn với hình ảnh voi và đời sống văn hóa đặc trưng của vùng Tây Nguyên. Buôn Đôn từ lâu đã nổi tiếng là vùng đất gắn với nghề săn bắt, thuần dưỡng voi và các truyền thống sinh hoạt của cộng đồng bản địa. Lễ hội vì thế không chỉ mang màu sắc vui hội mà còn phản ánh chiều sâu lịch sử và văn hóa của một vùng đất từng xem voi như một phần quan trọng trong đời sống vật chất lẫn tinh thần.

Điểm nhấn đặc biệt của lễ hội là các hoạt động trình diễn, tôn vinh voi và những chương trình cộng đồng gắn với không gian văn hóa Tây Nguyên. Tùy từng kỳ tổ chức, lễ hội có thể đi kèm với biểu diễn cồng chiêng, sinh hoạt cộng đồng, giới thiệu ẩm thực, trang phục và các yếu tố văn hóa bản địa khác. Không khí lễ hội thường mạnh mẽ, sống động, thể hiện tinh thần phóng khoáng và mối gắn bó giữa cư dân cao nguyên với thiên nhiên, muông thú và không gian rừng núi.

Trong hệ thống lễ hội Việt Nam, Lễ hội Đua voi Buôn Đôn là đại diện tiêu biểu cho loại hình lễ hội gắn với văn hóa cộng đồng bản địa và biểu tượng động vật đặc trưng. Dù ngày nay cách tiếp cận với việc bảo tồn động vật có nhiều thay đổi, lễ hội vẫn mang giá trị lớn trong việc phản ánh bản sắc lịch sử - văn hóa của Tây Nguyên và ghi nhớ một lớp ký ức cộng đồng rất riêng của Đắk Lắk.',
    N'The Buon Don Elephant Racing Festival is one of Dak Lak’s most distinctive cultural events, closely associated with elephants and the characteristic cultural life of the Central Highlands. Buon Don has long been known as a land linked to elephant capture, taming traditions, and the way of life of indigenous communities. For this reason, the festival is not merely a joyful celebration but also a reflection of the historical and cultural depth of a region where elephants once played an important role in both practical and spiritual life.

A central highlight of the festival is the set of activities that honor elephants and connect them with the broader cultural space of the Central Highlands. Depending on the specific edition, the event may also include gong performances, communal gatherings, local cuisine, traditional clothing, and other indigenous cultural expressions. Its atmosphere is often vibrant and powerful, reflecting the openness of highland life and the close relationship between local people, nature, animals, and forest space.

Within the Vietnamese festival system, the Buon Don Elephant Racing Festival is a representative example of a festival linked to indigenous communal culture and a distinctive animal symbol. Although contemporary approaches to animal conservation have evolved, the festival still holds strong value in reflecting the historical and cultural identity of the Central Highlands and preserving a unique layer of collective memory in Dak Lak.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'TRUNG_BO'),
    (SELECT TinhThanhID FROM dbo.TinhThanh WHERE MaTinh = 'DAK_LAK'),
    NULL,
    N'https://thinhvuongvietnam.com/Content/UploadFiles/EditorFiles/images/2024/Quy4/le-hoi-dua-voi29112024123951.jpg',
    N'https://mtcs.1cdn.vn/2023/02/20/nhung-con-voi-dung-manh-cua-buon-don-dang-tren-tren-duong-dua.jpg',
    GETDATE()
),
(
    'LE_HOI_NGHINH_ONG_CAN_GIO',
    N'Lễ hội Nghinh Ông Cần Giờ',
    N'Can Gio Whale Worship Festival',
    N'Thường diễn ra vào khoảng tháng 8 âm lịch.',
    N'Usually held around the eighth lunar month.',
    N'Huyện Cần Giờ, TP. Hồ Chí Minh.',
    N'Can Gio District, Ho Chi Minh City.',
    N'Lễ hội của cộng đồng ngư dân ven biển, cầu mong mưa thuận gió hòa, đánh bắt thuận lợi và bình an.',
    N'A coastal fishermen’s festival praying for calm seas, good catches, and safety.',
    N'Lễ hội Nghinh Ông Cần Giờ là một trong những lễ hội tiêu biểu của cộng đồng ngư dân vùng biển phía Nam, gắn với tục thờ cá Ông – vị thần bảo hộ biển cả trong tâm thức dân gian. Tại Cần Giờ, nơi đời sống cư dân gắn chặt với sông nước, rừng ngập mặn và biển, lễ hội mang ý nghĩa rất lớn về tinh thần cộng đồng và niềm tin vào sự che chở của biển. Đây là dịp để ngư dân bày tỏ lòng biết ơn, cầu mong mùa đánh bắt thuận lợi và cầu bình an cho những chuyến ra khơi.

Lễ hội thường bao gồm các nghi thức rước, tế, dâng hương, cúng bái và nhiều hoạt động sinh hoạt cộng đồng mang sắc thái vùng biển. Không gian lễ hội vừa trang nghiêm vừa sôi nổi, với sự tham gia của đông đảo người dân địa phương. Ngoài phần lễ, các hoạt động văn nghệ, giao lưu, dịch vụ hội hè và đời sống vùng lễ hội cũng tạo nên sức hấp dẫn riêng cho sự kiện.

Trong hệ thống lễ hội miền Nam, Nghinh Ông Cần Giờ là đại diện tiêu biểu cho văn hóa biển và tín ngưỡng ngư dân. Lễ hội góp phần bảo tồn truyền thống thờ cá Ông, phản ánh niềm tin dân gian và lưu giữ bản sắc sinh hoạt của cộng đồng cư dân ven biển Nam Bộ.',
    N'The Can Gio Whale Worship Festival is one of the representative festivals of Southern coastal fishing communities, associated with the worship of the whale spirit as a protector of the sea in folk belief. In Can Gio, where local life is closely connected to waterways, mangrove forests, and the sea, the festival carries major communal and spiritual meaning. It is an occasion for fishermen to express gratitude, pray for a successful fishing season, and seek protection for voyages at sea.

The festival usually includes processions, offerings, incense rites, worship ceremonies, and many community activities with a clear maritime character. Its atmosphere is both solemn and lively, with broad participation from local residents. In addition to the ritual section, performances, social exchange, festive services, and the general rhythm of the festival season all contribute to its appeal.

Within the wider system of Southern Vietnamese festivals, the Can Gio Whale Worship Festival is a representative example of coastal culture and fishermen’s religious practice. It helps preserve whale worship traditions, reflect folk belief, and maintain the lifestyle identity of Southern coastal communities.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'NAM_BO'),
    (SELECT TinhThanhID FROM dbo.TinhThanh WHERE MaTinh = 'HO_CHI_MINH'),
    NULL,
    N'https://cdn.xanhsm.com/2025/02/d5c40645-le-hoi-nghinh-ong-8.jpg',
    N'https://tphcm.cdnchinhphu.vn/334895287454388224/2025/10/5/hinh-tiet-muc-ngu-dan-175967814701878588687.jpg',
    GETDATE()
),
(
    'LE_HOI_OK_OM_BOK',
    N'Lễ hội Ok Om Bok',
    N'Ok Om Bok Festival',
    N'Thường diễn ra vào rằm tháng Mười âm lịch.',
    N'Usually held on the full moon of the tenth lunar month.',
    N'Cần Thơ và nhiều địa phương Nam Bộ có cộng đồng Khmer sinh sống.',
    N'Can Tho and other Southern localities with Khmer communities.',
    N'Lễ hội truyền thống của đồng bào Khmer, gắn với nghi thức cúng trăng và đời sống nông nghiệp vùng Nam Bộ.',
    N'A traditional Khmer festival associated with moon worship and agricultural life in Southern Vietnam.',
    N'Lễ hội Ok Om Bok là một trong những lễ hội truyền thống quan trọng của đồng bào Khmer Nam Bộ, gắn với tín ngưỡng cúng trăng và niềm tin về sự che chở của thiên nhiên đối với mùa màng, cuộc sống và cộng đồng. Lễ hội thường diễn ra vào thời điểm kết thúc mùa vụ chính trong năm, khi người dân bày tỏ lòng biết ơn đối với thần Mặt Trăng vì đã phù hộ cho sản xuất nông nghiệp thuận lợi. Đây là lễ hội có chiều sâu tín ngưỡng, đồng thời phản ánh rất rõ đời sống văn hóa và nhịp sinh hoạt nông nghiệp của cộng đồng Khmer.

Phần nghi lễ thường bao gồm việc chuẩn bị mâm cúng với các sản vật như cốm dẹp, khoai, dừa, chuối và nhiều loại nông sản khác. Trong không khí trang trọng nhưng gần gũi, người lớn trong gia đình hoặc các bậc cao niên sẽ thực hiện nghi thức cúng trăng, cầu mong bình an, mùa màng tốt tươi và cuộc sống ấm no. Sau nghi thức cúng là phần sinh hoạt cộng đồng với các hoạt động văn nghệ, vui chơi và giao lưu văn hóa, tạo nên một không gian lễ hội vừa linh thiêng vừa đậm tính cộng đồng.

Trong hệ thống lễ hội Việt Nam, Ok Om Bok là đại diện tiêu biểu cho loại hình lễ hội nông nghiệp - tín ngưỡng của đồng bào Khmer Nam Bộ. Lễ hội có giá trị lớn trong việc bảo tồn bản sắc văn hóa dân tộc, duy trì nghi lễ truyền thống và làm nổi bật sự đa dạng văn hóa của vùng đồng bằng sông Cửu Long.',
    N'Ok Om Bok is one of the most important traditional festivals of the Khmer communities in Southern Vietnam, closely associated with moon worship and the belief that natural forces protect crops, livelihoods, and communal well-being. The festival usually takes place at the end of a major agricultural season, when people express gratitude to the Moon God for favorable harvests. It has deep spiritual meaning while also clearly reflecting the agricultural rhythm and cultural life of Khmer communities.

The ritual section usually includes offerings prepared with products such as flattened young rice, sweet potatoes, coconuts, bananas, and other agricultural goods. In a solemn yet intimate atmosphere, elders or family heads perform the moon-worship ceremony, praying for peace, prosperity, and abundant harvests. After the ritual comes the communal celebration, including music, entertainment, and cultural exchange, creating a festival space that is both sacred and strongly communal.

Within the wider system of Vietnamese festivals, Ok Om Bok is a representative example of an agricultural and spiritual festival of the Southern Khmer people. It carries significant value in preserving ethnic cultural identity, maintaining traditional rites, and highlighting the cultural diversity of the Mekong Delta.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'NAM_BO'),
    (SELECT TinhThanhID FROM dbo.TinhThanh WHERE MaTinh = 'CAN_THO'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KHMER'),
    N'https://cdn.tcdulichtphcm.vn/upload/4-2024/images/2024-11-14/1731566894-dinh_oob-ao-b---om_21-a.jpg',
    N'https://images.baodantoc.vn/uploads/2022/Th%C3%A1ng%208/Ng%C3%A0y_19/Anh/441_thang_11_ve_tra_vinh_tham_gia_le_hoi_ok_om_bok_nam.jpg',
    GETDATE()
),
(
    'LE_HOI_DUA_GHE_NGO',
    N'Lễ hội Đua ghe Ngo',
    N'Ngo Boat Racing Festival',
    N'Thường diễn ra vào dịp lễ Ok Om Bok, khoảng rằm tháng Mười âm lịch.',
    N'Usually held during the Ok Om Bok period, around the full moon of the tenth lunar month.',
    N'Cần Thơ và các địa phương Nam Bộ có đông đồng bào Khmer.',
    N'Can Tho and Southern provinces with large Khmer communities.',
    N'Lễ hội thể thao - văn hóa đặc sắc của đồng bào Khmer, nổi bật với những cuộc đua ghe Ngo sôi động trên sông nước.',
    N'A distinctive Khmer cultural and sporting festival featuring lively long-boat races on waterways.',
    N'Lễ hội Đua ghe Ngo là một hoạt động văn hóa cộng đồng rất nổi bật của đồng bào Khmer Nam Bộ, thường gắn với mùa lễ Ok Om Bok và đời sống sông nước của vùng đồng bằng. Ghe Ngo là loại thuyền dài truyền thống, có kết cấu đặc biệt để phục vụ đua trên sông, đồng thời cũng mang ý nghĩa biểu tượng về tinh thần đoàn kết, sức mạnh tập thể và niềm tự hào cộng đồng. Các đội ghe không chỉ đại diện cho một nhóm vận động viên mà còn là hình ảnh của cả phum, sóc hoặc cộng đồng địa phương.

Không khí lễ hội thường rất sôi động với sự tập trung của đông đảo người dân hai bên bờ sông, tiếng trống, tiếng hò reo và tinh thần cổ vũ mạnh mẽ. Mỗi cuộc đua là sự kết hợp giữa thể lực, kỹ thuật, khả năng phối hợp nhịp nhàng và ý chí tập thể. Ngoài yếu tố thi đấu, lễ hội còn mang tính trình diễn văn hóa rất rõ, góp phần làm nổi bật bản sắc sông nước và truyền thống sinh hoạt cộng đồng của đồng bào Khmer.

Trong bức tranh lễ hội Việt Nam, Đua ghe Ngo là đại diện tiêu biểu cho loại hình lễ hội thể thao dân gian gắn với nghi lễ và đời sống văn hóa dân tộc. Lễ hội không chỉ hấp dẫn ở mặt hình ảnh và không khí mà còn có giá trị bảo tồn rất lớn đối với văn hóa Khmer Nam Bộ và truyền thống lễ hội vùng sông nước.',
    N'The Ngo Boat Racing Festival is a highly prominent communal cultural activity of the Khmer people in Southern Vietnam, often associated with the Ok Om Bok season and the river-based life of the Mekong Delta. The ngo boat is a traditional long racing boat with a distinctive structure designed for river competition, and it also symbolizes collective strength, solidarity, and communal pride. Racing teams represent not only a group of rowers but also an entire village, settlement, or local community.

The atmosphere is usually extremely lively, with large crowds gathered along riverbanks, drumbeats, cheering, and strong public enthusiasm. Each race combines physical endurance, technique, coordination, and collective determination. Beyond competition, the festival also has a clear performative cultural dimension, helping to highlight river-based identity and the communal traditions of Khmer life.

Within Vietnamese festival culture, ngo boat racing is a representative example of a folk sporting festival linked with ritual life and ethnic culture. Its appeal lies not only in visual spectacle and excitement but also in its major role in preserving Southern Khmer heritage and the traditions of river-region celebrations.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'NAM_BO'),
    (SELECT TinhThanhID FROM dbo.TinhThanh WHERE MaTinh = 'CAN_THO'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KHMER'),
    N'https://file3.qdnd.vn/data/images/0/2022/11/07/thuyan/2%201.jpg',
    N'https://images.baodantoc.vn/uploads/2020/Th%C3%A1ng_10/ng%C3%A0y_29/tin%20bi%C3%AAn%20t%E1%BA%ADp/ghe%20ngo%20.jpg',
    GETDATE()
),
(
    'LE_HOI_KATE',
    N'Lễ hội Kate',
    N'Kate Festival',
    N'Thường diễn ra vào khoảng tháng 7 theo lịch Chăm, tương ứng khoảng tháng 9 hoặc 10 dương lịch.',
    N'Usually held in the seventh month of the Cham calendar, corresponding roughly to September or October.',
    N'Các tháp Chăm và cộng đồng người Chăm tại khu vực Ninh Thuận cũ, nay thuộc Khánh Hòa mới.',
    N'Cham towers and Cham communities in the former Ninh Thuan area, now part of the new Khanh Hoa.',
    N'Lễ hội lớn của đồng bào Chăm theo đạo Bàlamôn, tôn vinh tổ tiên, thần linh và bản sắc văn hóa Chăm.',
    N'A major festival of Cham Brahman communities honoring ancestors, deities, and Cham cultural identity.',
    N'Lễ hội Kate là một trong những lễ hội quan trọng nhất của đồng bào Chăm theo đạo Bàlamôn, gắn với việc tưởng nhớ tổ tiên, các vị thần và những nhân vật có công trong truyền thống cộng đồng. Lễ hội thường diễn ra tại các tháp Chăm và sau đó lan tỏa vào không gian làng xóm, gia đình, tạo nên một chuỗi sinh hoạt văn hóa - tín ngưỡng vừa trang nghiêm vừa giàu bản sắc. Đây là dịp rất quan trọng để người Chăm thể hiện sự gắn kết với cội nguồn, tôn giáo và những giá trị truyền thống được lưu giữ qua nhiều thế hệ.

Trong phần nghi lễ, lễ hội thường bao gồm rước y phục thần, mở cửa tháp, dâng lễ, cầu nguyện và các nghi thức tôn giáo đặc trưng. Sau phần lễ là không gian văn hóa cộng đồng với âm nhạc, múa truyền thống, trang phục dân tộc, giao lưu và sinh hoạt làng. Toàn bộ lễ hội mang màu sắc riêng biệt, thể hiện rõ chiều sâu văn hóa Chăm thông qua kiến trúc tháp, nhạc cụ, nghi thức và tính cố kết cộng đồng.

Trong hệ thống lễ hội Việt Nam, Kate là đại diện tiêu biểu cho lễ hội dân tộc gắn với tín ngưỡng tôn giáo và di sản văn hóa đặc thù. Lễ hội có ý nghĩa rất lớn trong việc duy trì bản sắc Chăm, bảo tồn nghi thức truyền thống và làm nổi bật sự đa dạng văn hóa của dải đất miền Trung.',
    N'The Kate Festival is one of the most important festivals of the Cham Brahman community, associated with honoring ancestors, deities, and culturally significant figures in communal tradition. The festival is usually held at Cham towers and later extends into villages and households, creating a sequence of cultural and spiritual activities that is both solemn and highly distinctive. It is a very important occasion for the Cham people to express their connection to ancestry, religion, and traditional values preserved across generations.

Its ritual section commonly includes the procession of sacred garments, the opening of tower sanctuaries, offerings, prayers, and other specific religious practices. After the ritual portion, the festival expands into a communal cultural space with music, traditional dance, ethnic costume, social exchange, and village-based celebration. The entire event has a highly distinctive character, expressing the depth of Cham culture through tower architecture, musical instruments, rituals, and communal cohesion.

Within the wider system of Vietnamese festivals, Kate is a representative example of an ethnic festival rooted in religious belief and unique cultural heritage. It plays a major role in maintaining Cham identity, preserving traditional ritual practices, and highlighting the cultural diversity of Central Vietnam.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'TRUNG_BO'),
    (SELECT TinhThanhID FROM dbo.TinhThanh WHERE MaTinh = 'KHANH_HOA'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'CHAM'),
    N'https://images.baodantoc.vn/uploads/2024/Thang-9/Ngay-17/Anh/untitled%20folder/z3666171023314-cb39daf1ae3370337730751d83cf3b84-_1__1.jpg',
    N'https://lalago.vn/wp-content/uploads/2025/07/le-hoi-Kate-1.jpg',
    GETDATE()
),
(
    'LE_HOI_GAU_TAO',
    N'Lễ hội Gầu Tào',
    N'Gau Tao Festival',
    N'Thường diễn ra vào đầu năm, sau Tết Nguyên đán, tùy theo phong tục của từng cộng đồng.',
    N'Usually held in the early part of the year after Lunar New Year, depending on local custom.',
    N'Các vùng đồng bào Mông tại Lào Cai.',
    N'Hmong communities in Lao Cai.',
    N'Lễ hội truyền thống của người Mông, cầu phúc, cầu mệnh, cầu mùa và gắn kết cộng đồng vùng cao.',
    N'A traditional Hmong festival praying for blessing, health, fertility, harvest, and communal unity.',
    N'Lễ hội Gầu Tào là một lễ hội truyền thống tiêu biểu của người Mông, thường được tổ chức vào dịp đầu năm mới với ý nghĩa cầu phúc, cầu mệnh, cầu con, cầu sức khỏe hoặc cầu cho mùa màng thuận lợi. Đây là một trong những sinh hoạt văn hóa cộng đồng quan trọng của người Mông, phản ánh thế giới quan, tín ngưỡng dân gian và nhu cầu gắn kết cộng đồng trong đời sống vùng cao. Lễ hội không chỉ mang màu sắc tâm linh mà còn là dịp để các bản làng gặp gỡ, giao lưu và củng cố mối quan hệ xã hội.

Phần nghi lễ của lễ hội thường có cây nêu, các nghi thức khấn cúng và không gian sinh hoạt mang tính biểu tượng rất rõ. Bên cạnh đó là nhiều hoạt động hội như hát múa, giao lưu, trò chơi dân gian, thi tài, biểu diễn khèn và các sinh hoạt cộng đồng mang đậm sắc thái văn hóa Mông. Không khí lễ hội thường rất rộn ràng nhưng vẫn giữ được chiều sâu tín ngưỡng và sự tôn trọng đối với truyền thống.

Trong bức tranh lễ hội Việt Nam, Gầu Tào là đại diện nổi bật cho lễ hội dân tộc vùng cao gắn với tín ngưỡng, cộng đồng và đời sống nông nghiệp - chăn nuôi. Lễ hội có vai trò quan trọng trong việc bảo tồn bản sắc người Mông, duy trì nghi lễ dân gian và truyền lại các giá trị văn hóa cho thế hệ sau.',
    N'The Gau Tao Festival is a representative traditional festival of the Hmong people, usually held in the early part of the new year with meanings related to prayers for blessing, health, children, and favorable harvests. It is one of the most important communal cultural practices of the Hmong, reflecting their worldview, folk belief, and the need for social cohesion in upland life. The festival is not only spiritual in character but also an occasion for villages to meet, interact, and strengthen social ties.

Its ritual section often includes a ceremonial pole, offerings, and highly symbolic acts of prayer and worship. Alongside the ritual portion are many festive activities such as singing, dancing, community games, competitions, khen performances, and social gatherings that strongly express Hmong cultural identity. The atmosphere is lively yet still preserves spiritual depth and respect for tradition.

Within the broader landscape of Vietnamese festivals, Gau Tao is a prominent example of an upland ethnic festival connected with belief, community, and agricultural-pastoral life. It plays an important role in preserving Hmong identity, maintaining folk rituals, and transmitting cultural values to future generations.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'BAC_BO'),
    (SELECT TinhThanhID FROM dbo.TinhThanh WHERE MaTinh = 'LAO_CAI'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'MONG'),
    N'https://maichauhideaway.com/Data/Sites/1/News/344/le-hoi-gau-tao-1.jpg',
    N'https://maichauhideaway.com/Data/Sites/1/media/tin-tuc/%E1%BA%A3nh-b%C3%A0i-vi%E1%BA%BFt/t122024/le-hoi-gau-tao/le-hoi-gau-tao-11.jpg',
    GETDATE()
),
(
    'LE_HOI_HOA_LU',
    N'Lễ hội Hoa Lư',
    N'Hoa Lu Festival',
    N'Thường tổ chức vào tháng Ba âm lịch.',
    N'Usually held in the third lunar month.',
    N'Khu di tích Cố đô Hoa Lư, Ninh Bình.',
    N'Hoa Lu Ancient Capital historical site, Ninh Binh.',
    N'Lễ hội lịch sử - văn hóa tưởng niệm các vị vua đầu tiên của nhà nước phong kiến tập quyền Việt Nam.',
    N'A historical and cultural festival honoring the first kings of Vietnam’s centralized feudal state.',
    N'Lễ hội Hoa Lư là một lễ hội lịch sử quan trọng của Ninh Bình, gắn với khu di tích Cố đô Hoa Lư – kinh đô đầu tiên của nhà nước phong kiến tập quyền ở Việt Nam. Lễ hội nhằm tưởng niệm vua Đinh Tiên Hoàng và vua Lê Đại Hành, những nhân vật có vai trò đặc biệt trong việc củng cố nền độc lập dân tộc và xây dựng nhà nước thời kỳ đầu. Đây là sự kiện vừa mang giá trị tâm linh, vừa có ý nghĩa lịch sử sâu sắc trong ký ức cộng đồng.

Phần lễ thường bao gồm các nghi thức dâng hương, tế lễ, rước kiệu và những hoạt động tưởng niệm diễn ra trong không gian di tích cổ. Phần hội có thể có biểu diễn nghệ thuật truyền thống, tái hiện lịch sử, trò chơi dân gian và các chương trình văn hóa cộng đồng. Chính sự kết hợp giữa tính trang nghiêm của lễ tưởng niệm với không khí hội hè đầu xuân đã tạo nên sức hấp dẫn lâu bền cho lễ hội này.

Trong hệ thống lễ hội Việt Nam, lễ hội Hoa Lư là đại diện tiêu biểu cho loại hình lễ hội lịch sử gắn với cố đô và các triều đại đầu tiên của nhà nước Việt Nam độc lập. Lễ hội góp phần bảo tồn ký ức lịch sử, giáo dục truyền thống và làm nổi bật vai trò đặc biệt của Ninh Bình trong tiến trình lịch sử dân tộc.',
    N'The Hoa Lu Festival is an important historical festival of Ninh Binh, associated with the Hoa Lu Ancient Capital historical complex, the first capital of Vietnam’s centralized feudal state. The festival honors King Dinh Tien Hoang and King Le Dai Hanh, figures of special importance in consolidating national independence and building the early Vietnamese state. It is an event that combines spiritual meaning with deep historical significance in collective memory.

The ceremonial section usually includes incense offerings, formal rites, processions, and commemorative activities held within the ancient heritage space. The festive section may feature traditional performances, historical reenactments, folk games, and community cultural programs. The combination of solemn remembrance and the joyful atmosphere of spring celebration gives this festival its enduring appeal.

Within the wider system of Vietnamese festivals, the Hoa Lu Festival is a representative example of a historical festival linked to an ancient capital and the earliest dynasties of independent Vietnam. It helps preserve historical memory, educate later generations, and highlight Ninh Binh’s special role in the nation’s historical development.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'BAC_BO'),
    (SELECT TinhThanhID FROM dbo.TinhThanh WHERE MaTinh = 'NINH_BINH'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KINH'),
    N'https://media-cdn-v2.laodong.vn/Storage/NewsPortal/2023/4/30/1186575/Hoa-Lu-9.jpg',
    N'https://media-cdn-v2.laodong.vn/storage/newsportal/2024/4/19/1329220/Nghi-Le-BLD-Min-04.jpg',
    GETDATE()
),
(
    'LE_HOI_CHOI_TRAU_DO_SON',
    N'Lễ hội chọi trâu Đồ Sơn',
    N'Do Son Buffalo Fighting Festival',
    N'Thường tổ chức vào ngày mùng 9 tháng 8 âm lịch, với các hoạt động chuẩn bị kéo dài trước đó nhiều tháng.',
    N'Usually held on the 9th day of the eighth lunar month, with preparations taking place for months in advance.',
    N'Quận Đồ Sơn, Hải Phòng.',
    N'Do Son District, Hai Phong.',
    N'Lễ hội dân gian nổi tiếng của vùng biển Hải Phòng, kết hợp nghi lễ tín ngưỡng và hoạt động hội hè mang tính cộng đồng cao.',
    N'A famous folk festival of coastal Hai Phong, combining spiritual ritual with highly communal festive activities.',
    N'Lễ hội chọi trâu Đồ Sơn là một trong những lễ hội dân gian nổi tiếng nhất của miền Bắc, gắn với đời sống tín ngưỡng và văn hóa cộng đồng cư dân vùng biển Hải Phòng. Mặc dù được công chúng biết đến nhiều qua hoạt động chọi trâu, bản chất của lễ hội không chỉ nằm ở yếu tố thi đấu mà còn gắn với nghi lễ cầu may, cầu phúc, cầu mùa và sự bình an cho cộng đồng ngư dân, cư dân ven biển. Đây là lễ hội có lịch sử lâu đời, phản ánh mối quan hệ giữa đời sống lao động, tín ngưỡng dân gian và tinh thần cố kết cộng đồng.

Quá trình chuẩn bị cho lễ hội thường bắt đầu từ rất sớm, với việc tuyển chọn, chăm sóc và huấn luyện trâu chọi theo những quy chuẩn riêng. Trong ngày hội, ngoài phần chọi trâu thu hút đông đảo người xem, phần lễ cũng giữ vai trò quan trọng với các nghi thức rước, tế thần, dâng hương và sinh hoạt tín ngưỡng gắn với làng xã ven biển. Không khí lễ hội vừa sôi động, mạnh mẽ, vừa mang sắc thái linh thiêng, thể hiện rõ tính biểu tượng và sự đầu tư tinh thần của cộng đồng địa phương.

Trong hệ thống lễ hội Việt Nam, lễ hội chọi trâu Đồ Sơn là đại diện rất tiêu biểu cho loại hình lễ hội dân gian mang tính nghi lễ - cộng đồng cao, đồng thời có sức hút mạnh về hình ảnh và du lịch. Giá trị của lễ hội không chỉ ở tính đặc sắc của hoạt động chọi trâu mà còn ở chiều sâu văn hóa, niềm tin dân gian và ký ức cộng đồng được truyền qua nhiều thế hệ.',
    N'The Do Son Buffalo Fighting Festival is one of the most famous folk festivals in northern Vietnam, deeply associated with the spiritual life and communal culture of the coastal population of Hai Phong. Although widely recognized for the buffalo fights themselves, the festival is not defined only by competition. At its core, it is connected with rituals for good fortune, well-being, favorable seasons, and peace for fishing and coastal communities. It is a long-standing festival that reflects the relationship between labor, folk belief, and communal solidarity.

Preparation for the festival usually begins well in advance, including the careful selection, care, and training of buffaloes according to specific traditional standards. On the main festival day, the fighting events attract large crowds, but the ceremonial section remains equally important, with processions, ritual offerings, incense ceremonies, and spiritual practices connected with the coastal village community. The atmosphere is both energetic and sacred, clearly showing the symbolic force and emotional investment of local people.

Within the broader system of Vietnamese festivals, the Do Son Buffalo Fighting Festival is a particularly representative example of a folk festival with strong ritual and communal dimensions, while also having major visual and tourism appeal. Its importance lies not only in the uniqueness of the fighting event itself but also in the cultural depth, folk beliefs, and communal memory preserved across generations.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'BAC_BO'),
    (SELECT TinhThanhID FROM dbo.TinhThanh WHERE MaTinh = 'HAI_PHONG'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KINH'),
    N'https://media-cdn-v2.laodong.vn/Storage/NewsPortal/2022/8/9/1079058/Le-Hoi-Choi-Trau-2.jpg',
    N'https://thanhphohaiphong.gov.vn/wp-content/uploads/2023/09/20230923_650e8664bebd7.jpg',
    GETDATE()
),
(
    'LE_HOI_DEN_TRAN',
    N'Lễ hội đền Trần',
    N'Tran Temple Festival',
    N'Thường diễn ra vào tháng Giêng âm lịch, nổi bật với nghi thức khai ấn đầu xuân.',
    N'Usually held in the first lunar month, especially known for the early-spring seal-opening ritual.',
    N'Khu di tích đền Trần, vùng Nam Định cũ, nay thuộc tỉnh Ninh Bình theo dữ liệu tỉnh thành hiện tại.',
    N'Tran Temple historical site in the former Nam Dinh area, now under Ninh Binh according to the current province dataset.',
    N'Lễ hội lịch sử - tín ngưỡng gắn với triều Trần, nổi bật với nghi thức khai ấn và truyền thống tôn vinh công danh, đạo lý, lịch sử.',
    N'A historical-spiritual festival associated with the Tran Dynasty, especially known for the seal-opening ritual and the honoring of merit, morality, and history.',
    N'Lễ hội đền Trần là một trong những lễ hội đầu xuân nổi tiếng và có sức lan tỏa lớn ở miền Bắc, gắn với di tích thờ các vua Trần và các nhân vật có công của triều Trần. Lễ hội mang đậm sắc thái lịch sử và tín ngưỡng, đồng thời phản ánh sâu sắc tâm thức coi trọng đạo lý, công danh, học hành và truyền thống dựng nước, giữ nước. Hình ảnh đền Trần trong đời sống văn hóa đương đại không chỉ gắn với ký ức về một triều đại hưng thịnh mà còn gắn với niềm tin cầu mong hanh thông, thuận lợi trong năm mới.

Một trong những điểm nổi bật nhất của lễ hội là nghi thức khai ấn đầu xuân, thu hút rất đông người dân và du khách tham gia. Bên cạnh đó, lễ hội còn có các nghi thức dâng hương, tế lễ, rước kiệu và nhiều hoạt động văn hóa cộng đồng. Không khí lễ hội thường rất sôi động nhưng vẫn mang chiều sâu linh thiêng, thể hiện sự kết hợp giữa nhu cầu hành hương, tín ngưỡng dân gian và ý thức lịch sử.

Trong hệ thống lễ hội Việt Nam, lễ hội đền Trần là đại diện tiêu biểu cho loại hình lễ hội lịch sử gắn với một triều đại phong kiến lớn và một không gian tín ngưỡng có sức hút mạnh trong đời sống hiện nay. Lễ hội góp phần duy trì ký ức về triều Trần, nuôi dưỡng truyền thống tôn sư trọng đạo, trọng nghĩa khí và khẳng định vai trò của lễ hội trong đời sống tinh thần cộng đồng.',
    N'The Tran Temple Festival is one of the most famous early-spring festivals in northern Vietnam, associated with the worship of the Tran kings and important historical figures of the Tran Dynasty. It carries a strong historical and spiritual character, while also reflecting the Vietnamese cultural emphasis on moral values, education, achievement, and the traditions of founding and defending the nation. In contemporary cultural life, the Tran Temple is tied not only to the memory of a flourishing royal dynasty but also to hopes for smooth beginnings and success in the new year.

One of the festival’s most distinctive elements is the spring seal-opening ritual, which attracts very large numbers of participants and visitors. In addition, the festival includes incense offerings, ceremonial worship, processions, and various community cultural activities. The overall atmosphere is lively yet deeply sacred, showing the interaction between pilgrimage, folk belief, and historical consciousness.

Within the wider system of Vietnamese festivals, the Tran Temple Festival is a representative example of a historical festival linked to a major royal dynasty and a spiritually influential sacred site. It helps preserve memory of the Tran Dynasty, sustain traditions of respect for virtue and honor, and affirm the continuing role of festivals in communal spiritual life.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'BAC_BO'),
    (SELECT TinhThanhID FROM dbo.TinhThanh WHERE MaTinh = 'NINH_BINH'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KINH'),
    N'https://cellphones.com.vn/sforum/wp-content/uploads/2023/12/le-hoi-den-tran-1.jpg',
    N'https://cdn-media.sforum.vn/storage/app/media/wp-content/uploads/2023/12/le-hoi-den-tran-thumbnail.jpg',
    GETDATE()
),
(
    'HOI_XUAN_NUI_BA_DEN',
    N'Hội xuân Núi Bà Đen',
    N'Ba Den Mountain Spring Festival',
    N'Thường diễn ra vào mùa xuân, đặc biệt sôi động từ sau Tết Nguyên đán đến hết tháng Giêng âm lịch.',
    N'Usually takes place in spring, especially vibrant from after Lunar New Year through the first lunar month.',
    N'Khu du lịch và quần thể tâm linh Núi Bà Đen, Tây Ninh.',
    N'Ba Den Mountain spiritual and tourism complex, Tay Ninh.',
    N'Lễ hội đầu xuân nổi bật của Nam Bộ, kết hợp hành hương, tín ngưỡng dân gian và du xuân nơi núi thiêng.',
    N'A major Southern spring festival combining pilgrimage, folk belief, and spring travel at a sacred mountain.',
    N'Hội xuân Núi Bà Đen là một trong những lễ hội đầu năm nổi bật nhất của khu vực Nam Bộ, gắn với quần thể tâm linh Núi Bà Đen – điểm hành hương rất quan trọng của Tây Ninh. Đây là lễ hội mang sắc thái du xuân và tín ngưỡng rất rõ, nơi người dân và du khách tìm đến để lễ bái, cầu bình an, cầu may mắn và khởi đầu một năm mới với niềm tin tốt lành. Không gian núi thiêng kết hợp với hệ thống chùa, điện, miếu và cảnh quan tự nhiên đã tạo nên sức hút rất riêng cho lễ hội.

Trong mùa hội, lượng người hành hương thường rất đông, tạo nên bầu không khí nhộn nhịp nhưng vẫn đậm chất tâm linh. Các hoạt động chính xoay quanh việc dâng hương, cầu lễ, tham quan không gian núi và tham gia sinh hoạt cộng đồng đầu năm. Bên cạnh giá trị tín ngưỡng, lễ hội còn cho thấy truyền thống du xuân của người Việt ở Nam Bộ, nơi yếu tố tâm linh và trải nghiệm cảnh quan hòa quyện trong cùng một hành trình.

Trong hệ thống lễ hội Việt Nam, Hội xuân Núi Bà Đen là đại diện tiêu biểu cho loại hình lễ hội hành hương đầu năm ở khu vực phía Nam. Lễ hội có sức hút lớn đối với cộng đồng, góp phần làm nổi bật vai trò của Tây Ninh như một không gian du lịch tâm linh quan trọng và bền vững.',
    N'The Ba Den Mountain Spring Festival is one of the most prominent early-year festivals in Southern Vietnam, associated with the Ba Den Mountain spiritual complex, an important pilgrimage destination in Tay Ninh. It is clearly both a spring outing and a religious festival, where residents and visitors come to worship, pray for peace and good fortune, and begin the new year with positive hopes. The sacred mountain setting, together with temples, shrines, and natural scenery, gives the festival its distinctive appeal.

During the festival season, the number of pilgrims is usually very large, creating an atmosphere that is lively yet still strongly spiritual. Main activities revolve around incense offerings, prayers, mountain visits, and communal springtime gatherings. In addition to its spiritual value, the festival also reflects the Southern Vietnamese tradition of spring pilgrimage, in which sacred practice and scenic travel are combined in a single journey.

Within the wider system of Vietnamese festivals, the Ba Den Mountain Spring Festival is a representative example of an early-year pilgrimage festival in the South. It has strong communal appeal and helps highlight Tay Ninh’s role as an important and sustainable spiritual tourism destination.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'NAM_BO'),
    (SELECT TinhThanhID FROM dbo.TinhThanh WHERE MaTinh = 'TAY_NINH'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KINH'),
    N'https://cdn3.ivivu.com/2026/02/Hoi-xuan-nui-Ba-Den-ivivu-9.jpg',
    N'https://mia.vn/media/uploads/blog-du-lich/hoi-xuan-nui-ba-den-10-1770568130.jpg',
    GETDATE()
),
(
    'FESTIVAL_BIEN_NHA_TRANG',
    N'Festival Biển Nha Trang',
    N'Nha Trang Sea Festival',
    N'Tổ chức định kỳ theo chương trình văn hóa - du lịch của địa phương, thường vào mùa hè.',
    N'Organized periodically according to the local cultural and tourism program, often in summer.',
    N'Thành phố Nha Trang và khu vực ven biển Khánh Hòa.',
    N'Nha Trang City and coastal areas of Khanh Hoa.',
    N'Sự kiện văn hóa - du lịch lớn tôn vinh biển, đảo, đời sống duyên hải và hình ảnh Nha Trang - Khánh Hòa.',
    N'A major cultural and tourism event celebrating the sea, islands, coastal life, and the image of Nha Trang - Khanh Hoa.',
    N'Festival Biển Nha Trang là một trong những sự kiện văn hóa - du lịch tiêu biểu nhất của Khánh Hòa, gắn với hình ảnh biển xanh, cát trắng, nắng vàng và đời sống đô thị ven biển năng động của Nha Trang. Sự kiện được tổ chức nhằm quảng bá tiềm năng du lịch biển đảo, tôn vinh văn hóa vùng duyên hải và giới thiệu những giá trị đặc trưng của địa phương đến du khách trong và ngoài nước. Đây là lễ hội hiện đại, có quy mô lớn và giàu tính trình diễn, nhưng vẫn gắn chặt với không gian biển đảo làm nền tảng bản sắc.

Festival thường bao gồm nhiều hoạt động như biểu diễn nghệ thuật, trình diễn đường phố, giao lưu văn hóa, quảng bá ẩm thực, thể thao biển, triển lãm và các chương trình cộng đồng. Không khí lễ hội sôi động, cởi mở và mang đậm sắc thái của một đô thị biển du lịch. Bên cạnh yếu tố giải trí và quảng bá, sự kiện còn có vai trò khẳng định bản sắc văn hóa biển, cách sống duyên hải và hình ảnh Nha Trang như một thành phố nghỉ dưỡng nổi bật của Việt Nam.

Trong hệ thống sự kiện văn hóa đương đại của Việt Nam, Festival Biển Nha Trang là đại diện tiêu biểu cho mô hình lễ hội đô thị gắn với biển và thương hiệu điểm đến. Sự kiện góp phần thúc đẩy du lịch, quảng bá địa phương và làm rõ vai trò của biển đảo trong đời sống văn hóa - kinh tế của Khánh Hòa.',
    N'The Nha Trang Sea Festival is one of the most representative cultural and tourism events of Khanh Hoa, closely linked to the image of blue sea, white sand, sunshine, and the dynamic coastal urban life of Nha Trang. The event is organized to promote marine and island tourism potential, celebrate coastal culture, and introduce local values to both domestic and international visitors. It is a large-scale modern festival with strong visual and performative elements, yet it remains firmly grounded in maritime identity.

The festival usually includes artistic performances, street events, cultural exchange, food promotion, marine sports, exhibitions, and community programs. Its atmosphere is open, lively, and strongly reflective of a seaside tourism city. Beyond entertainment and promotion, the event also plays a role in affirming coastal cultural identity, maritime ways of life, and the image of Nha Trang as one of Vietnam’s leading resort cities.

Within the system of contemporary Vietnamese cultural events, the Nha Trang Sea Festival is a representative example of an urban festival built around the sea and destination branding. It helps stimulate tourism, promote the locality, and highlight the importance of marine space in the cultural and economic life of Khanh Hoa.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'TRUNG_BO'),
    (SELECT TinhThanhID FROM dbo.TinhThanh WHERE MaTinh = 'KHANH_HOA'),
    NULL,
    N'https://lalago.vn/wp-content/uploads/2025/10/le-hoi-festival-bien-nha-trang-1.jpg',
    N'https://statics.vinpearl.com/Festival%20bi%E1%BB%83n%20Nha%20Trang_1679026957.jpg',
    GETDATE()
),
(
    'LE_HOI_DUA_BO_BAY_NUI',
    N'Lễ hội đua bò Bảy Núi',
    N'Bay Nui Ox Racing Festival',
    N'Thường diễn ra vào dịp lễ Sen Dolta hoặc mùa lễ hội của đồng bào Khmer Nam Bộ.',
    N'Usually held during Sen Dolta or the festival season of Southern Khmer communities.',
    N'Khu vực Bảy Núi, An Giang.',
    N'Bay Nui area, An Giang.',
    N'Lễ hội dân gian đặc sắc của đồng bào Khmer Nam Bộ, kết hợp tín ngưỡng, lao động nông nghiệp và sinh hoạt cộng đồng.',
    N'A distinctive folk festival of the Southern Khmer community, combining belief, agricultural life, and communal celebration.',
    N'Lễ hội đua bò Bảy Núi là một trong những lễ hội đặc sắc nhất của An Giang và cũng là một hình ảnh tiêu biểu của văn hóa Khmer Nam Bộ. Lễ hội gắn với vùng Bảy Núi, nơi cộng đồng Khmer sinh sống lâu đời và gìn giữ nhiều nét sinh hoạt văn hóa, tín ngưỡng, lễ nghi độc đáo. Đua bò vốn xuất phát từ đời sống nông nghiệp, từ việc sử dụng bò trong lao động đồng áng, sau đó phát triển thành một hình thức sinh hoạt lễ hội đầy tính cộng đồng và giàu sức hấp dẫn.

Các cuộc đua thường diễn ra trong không khí sôi động, với sự tham gia của những đôi bò được huấn luyện kỹ và những người điều khiển có kinh nghiệm. Đây không chỉ là cuộc thi sức mạnh và kỹ thuật mà còn là dịp thể hiện tinh thần thi đua, niềm vui hội hè và niềm tự hào của cộng đồng địa phương. Khán giả bị cuốn hút bởi tốc độ, bùn nước, tiếng reo hò và bầu không khí rộn ràng mang đậm sắc thái miền biên giới Tây Nam.

Trong hệ thống lễ hội Việt Nam, đua bò Bảy Núi là đại diện tiêu biểu cho loại hình lễ hội thể thao dân gian có nguồn gốc từ lao động nông nghiệp và đời sống văn hóa dân tộc. Lễ hội góp phần làm nổi bật bản sắc Khmer Nam Bộ, bảo tồn ký ức cộng đồng và tạo nên một dấu ấn rất riêng cho vùng đất An Giang.',
    N'The Bay Nui Ox Racing Festival is one of the most distinctive festivals of An Giang and also a highly representative image of Southern Khmer culture. The festival is associated with the Bay Nui region, where Khmer communities have lived for generations and preserved many unique cultural practices, beliefs, and rituals. Ox racing originally emerged from agricultural life and the use of oxen in farming, later developing into a festive communal activity full of excitement and strong social meaning.

The races usually take place in a highly energetic atmosphere, with pairs of well-trained oxen and experienced handlers. More than a competition of strength and technique, the event is an occasion to express competitive spirit, festive joy, and communal pride. Spectators are drawn in by the speed, mud, cheering, and the lively atmosphere characteristic of the southwestern borderland.

Within the wider system of Vietnamese festivals, the Bay Nui Ox Racing Festival is a representative example of a folk sporting festival rooted in agricultural labor and ethnic cultural life. It helps highlight Southern Khmer identity, preserve communal memory, and create a very distinctive mark for the land of An Giang.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'NAM_BO'),
    (SELECT TinhThanhID FROM dbo.TinhThanh WHERE MaTinh = 'AN_GIANG'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KHMER'),
    N'https://media-cdn-v2.laodong.vn/Storage/NewsPortal/2022/9/18/1094659/Hoi-Dua-Bo-Bay-Nui-1.JPG',
    N'https://image.sggp.org.vn/w1000/Uploaded/2026/zagtba/2024_09_29/nai-bo-kheo-leo-dieu-khien-doi-tro-tranh-tai-3222.jpg.webp',
    GETDATE()
),
(
    'LE_HOI_CO_LOA',
    N'Lễ hội Cổ Loa',
    N'Co Loa Festival',
    N'Thường diễn ra vào đầu xuân, chính hội vào ngày mùng 6 tháng Giêng âm lịch.',
    N'Usually held in early spring, with the main celebration on the 6th day of the first lunar month.',
    N'Khu di tích Cổ Loa, Hà Nội.',
    N'Co Loa historical site, Ha Noi.',
    N'Lễ hội lịch sử gắn với An Dương Vương và kinh đô Cổ Loa, thể hiện chiều sâu văn hóa - lịch sử của vùng đất kinh kỳ.',
    N'A historical festival associated with King An Duong Vuong and the ancient capital of Co Loa, reflecting the deep cultural and historical significance of the old capital region.',
    N'Lễ hội Cổ Loa là một lễ hội lịch sử quan trọng gắn với khu di tích Cổ Loa, nơi được xem là kinh đô của nước Âu Lạc dưới thời An Dương Vương. Lễ hội mang ý nghĩa tưởng niệm vị vua gắn với quá trình dựng nước buổi đầu, đồng thời gợi nhắc về một giai đoạn rất sớm của lịch sử dân tộc Việt Nam. Không gian lễ hội vì thế vừa mang chiều sâu lịch sử, vừa gắn chặt với đời sống tín ngưỡng và ký ức cộng đồng của cư dân vùng đồng bằng Bắc Bộ.

Phần lễ thường bao gồm các nghi thức dâng hương, rước kiệu, tế lễ và các hoạt động tưởng niệm diễn ra trong không gian thành cổ, đền thờ và những điểm linh thiêng liên quan đến truyền thuyết Cổ Loa. Phần hội có thể gồm các trò chơi dân gian, biểu diễn văn hóa cộng đồng và những hình thức sinh hoạt hội xuân đặc trưng của vùng Bắc Bộ. Sự kết hợp giữa yếu tố lịch sử, truyền thuyết và tín ngưỡng đã làm cho lễ hội trở thành một không gian văn hóa có giá trị rất rõ nét.

Trong hệ thống lễ hội Việt Nam, lễ hội Cổ Loa là đại diện tiêu biểu cho loại hình lễ hội gắn với kinh đô cổ và huyền sử dựng nước. Lễ hội có ý nghĩa lớn trong việc bảo tồn ký ức lịch sử, truyền thuyết dân gian và giáo dục tinh thần hướng về cội nguồn dân tộc.',
    N'The Co Loa Festival is an important historical festival associated with the Co Loa relic complex, regarded as the capital of Au Lac under King An Duong Vuong. The festival commemorates a ruler connected with the earliest period of state formation in Vietnamese history and evokes one of the oldest layers of national memory. For this reason, the festival space combines historical depth with the spiritual life and collective memory of the northern delta community.

Its ceremonial section usually includes incense offerings, processions, formal rites, and commemorative activities taking place within the ancient citadel, temple grounds, and sacred points associated with the Co Loa legend. The festive section may include folk games, community cultural performances, and spring celebration activities characteristic of northern Vietnam. The fusion of history, legend, and belief gives this festival a particularly meaningful cultural presence.

Within the wider system of Vietnamese festivals, the Co Loa Festival is a representative example of a festival associated with an ancient capital and foundational national legend. It has strong value in preserving historical memory, folk tradition, and awareness of national origins.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'BAC_BO'),
    (SELECT TinhThanhID FROM dbo.TinhThanh WHERE MaTinh = 'HA_NOI'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KINH'),
    N'https://images.baodantoc.vn/uploads/2023/Th%C3%A1ng%201/Ng%C3%A0y_20/TRUNG/C%E1%BB%95%20Loa/1.jpg',
    N'https://file3.qdnd.vn/data/images/0/2023/02/04/vuhuyen/6.jpg',
    GETDATE()
),
(
    'LE_HOI_HUYEN_TRAN',
    N'Lễ hội đền Huyền Trân',
    N'Huyen Tran Temple Festival',
    N'Thường tổ chức vào đầu năm, gắn với mùa xuân và các hoạt động văn hóa đầu năm tại Huế.',
    N'Usually held in early spring as part of Hue’s beginning-of-year cultural activities.',
    N'Trung tâm văn hóa Huyền Trân, Huế.',
    N'Huyen Tran Cultural Center, Hue.',
    N'Lễ hội văn hóa tưởng niệm công chúa Huyền Trân, tôn vinh lịch sử mở cõi và chiều sâu văn hóa vùng đất Huế.',
    N'A cultural festival honoring Princess Huyen Tran, celebrating the history of territorial expansion and the cultural depth of Hue.',
    N'Lễ hội đền Huyền Trân là một hoạt động văn hóa có ý nghĩa đặc biệt tại Huế, gắn với việc tưởng niệm công chúa Huyền Trân – nhân vật lịch sử được nhắc đến nhiều trong ký ức văn hóa dân tộc và quá trình mở rộng không gian lãnh thổ về phương Nam. Lễ hội mang màu sắc tưởng niệm, tri ân và tôn vinh lịch sử, đồng thời góp phần làm nổi bật chiều sâu văn hóa của vùng đất cố đô. Đây là sự kiện vừa có yếu tố tâm linh, vừa có giá trị giáo dục lịch sử và biểu tượng rõ nét.

Trong thời gian lễ hội, các nghi thức dâng hương, tế lễ, tưởng niệm thường được tổ chức trong không gian trang trọng. Bên cạnh đó là các hoạt động văn hóa nghệ thuật, trình diễn truyền thống, thư pháp, triển lãm và sinh hoạt cộng đồng, tạo nên một không gian lễ hội mang đậm bản sắc Huế. Không khí sự kiện thường nhẹ nhàng, sâu lắng hơn nhiều lễ hội hội hè khác, phù hợp với sắc thái văn hóa riêng của cố đô.

Trong hệ thống lễ hội miền Trung, lễ hội đền Huyền Trân là một đại diện tiêu biểu cho loại hình lễ hội tưởng niệm nhân vật lịch sử gắn với ý nghĩa văn hóa - chính trị lớn. Lễ hội góp phần giữ gìn ký ức lịch sử, lan tỏa giá trị văn hóa Huế và nuôi dưỡng sự trân trọng đối với những nhân vật có vai trò trong tiến trình dân tộc.',
    N'The Huyen Tran Temple Festival is a cultural event of special significance in Hue, associated with the commemoration of Princess Huyen Tran, a historical figure deeply remembered in Vietnamese cultural memory and in the story of southward territorial expansion. The festival carries themes of remembrance, gratitude, and historical honor, while also highlighting the cultural depth of the former imperial capital. It combines spiritual elements with clear historical and symbolic educational value.

During the festival period, incense offerings, memorial rites, and commemorative ceremonies are usually held in a solemn setting. These are accompanied by cultural performances, traditional showcases, calligraphy, exhibitions, and community activities, creating a festival atmosphere rich in Hue identity. Compared with more festive folk celebrations, the tone of this event is often gentler and more reflective, in keeping with Hue’s characteristic cultural style.

Within the festival landscape of Central Vietnam, the Huyen Tran Temple Festival is a representative example of a commemorative festival centered on a historical figure of major cultural and political significance. It helps preserve historical memory, promote Hue’s cultural values, and foster respect for those who contributed to the nation’s historical development.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'TRUNG_BO'),
    (SELECT TinhThanhID FROM dbo.TinhThanh WHERE MaTinh = 'HUE'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KINH'),
    N'https://khamphahue.com.vn/Portals/0/Medias/Nam2025/T2/Khamphahue-LeHoiDenHuyenTran_2025.jpg',
    N'https://media-cdn-v2.laodong.vn/storage/newsportal/2026/2/25/1660344/Le-Hoi-4.jpg',
    GETDATE()
),
(
    'HOI_CHE_THAI_NGUYEN',
    N'Hội chè Thái Nguyên',
    N'Thai Nguyen Tea Festival',
    N'Tổ chức định kỳ theo chương trình xúc tiến văn hóa, du lịch và sản phẩm địa phương.',
    N'Organized periodically as part of cultural, tourism, and local product promotion programs.',
    N'Thái Nguyên.',
    N'Thai Nguyen.',
    N'Sự kiện văn hóa - kinh tế tôn vinh cây chè, nghề chè và bản sắc vùng trung du Thái Nguyên.',
    N'A cultural and economic event celebrating tea, tea craftsmanship, and the identity of the Thai Nguyen midlands.',
    N'Hội chè Thái Nguyên là một sự kiện văn hóa - kinh tế tiêu biểu gắn với hình ảnh chè như một sản vật nổi bật và giàu giá trị biểu tượng của vùng trung du Bắc Bộ. Thái Nguyên từ lâu đã nổi tiếng với các vùng chè, nghề chè và văn hóa thưởng trà, vì vậy việc tổ chức hội chè không chỉ nhằm quảng bá sản phẩm mà còn để tôn vinh một lớp văn hóa sinh hoạt đã trở thành bản sắc của địa phương. Đây là sự kiện thể hiện khá rõ mối liên hệ giữa nông nghiệp, làng nghề, kinh tế địa phương và đời sống văn hóa cộng đồng.

Nội dung sự kiện thường bao gồm giới thiệu sản phẩm chè, trình diễn quy trình chế biến, không gian thưởng trà, hoạt động giao lưu văn hóa, nghệ thuật và quảng bá du lịch. Ngoài khía cạnh thương mại, hội chè còn nhấn mạnh chiều sâu tinh thần của trà trong đời sống người Việt, đặc biệt ở vùng trung du nơi cây chè gắn chặt với sinh kế và ký ức địa phương. Không khí của sự kiện thường mang sắc thái vừa trang nhã, vừa gần gũi, thể hiện rõ hình ảnh một vùng đất hiền hòa, cần mẫn và giàu truyền thống.

Trong hệ thống lễ hội và sự kiện văn hóa Việt Nam, Hội chè Thái Nguyên là đại diện tiêu biểu cho mô hình lễ hội gắn với đặc sản địa phương và thương hiệu vùng. Sự kiện góp phần quảng bá hình ảnh Thái Nguyên, tôn vinh nghề chè và làm nổi bật bản sắc văn hóa trà trong đời sống hiện đại.',
    N'The Thai Nguyen Tea Festival is a representative cultural and economic event associated with tea as one of the most symbolic and valuable local products of the northern midlands. Thai Nguyen has long been famous for its tea-growing areas, tea craft traditions, and tea-drinking culture. For this reason, the festival is not only a means of promoting local products but also a way to honor a layer of everyday culture that has become central to the province’s identity. It clearly reflects the connection between agriculture, craft traditions, local economy, and communal cultural life.

The event usually includes tea exhibitions, demonstrations of tea processing, tea-tasting spaces, cultural exchange activities, performances, and tourism promotion. Beyond its commercial aspect, the festival also emphasizes the spiritual and cultural depth of tea in Vietnamese life, especially in the midland region where tea is deeply tied to livelihood and memory. Its atmosphere is often refined yet approachable, reflecting the image of a peaceful, hardworking, and tradition-rich locality.

Within the broader system of Vietnamese festivals and cultural events, the Thai Nguyen Tea Festival is a representative example of a specialty-based regional celebration. It helps promote Thai Nguyen’s image, honor tea craftsmanship, and highlight tea culture as an important part of contemporary Vietnamese life.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'BAC_BO'),
    (SELECT TinhThanhID FROM dbo.TinhThanh WHERE MaTinh = 'THAI_NGUYEN'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KINH'),
    N'https://photo.znews.vn/w660/Uploaded/mzdgi/2024_07_23/z5656315338284_a3f34a54f6daf680d.jpg',
    N'https://bizweb.dktcdn.net/100/201/525/files/danh-tra-thai-nguyen-6.jpg?v=1593654651760',
    GETDATE()
),
(
    'CARNAVAL_HA_LONG',
    N'Carnaval Hạ Long',
    N'Ha Long Carnival',
    N'Thường tổ chức vào mùa hè theo chương trình du lịch của Quảng Ninh.',
    N'Usually held in summer as part of Quang Ninh’s tourism program.',
    N'Thành phố Hạ Long, Quảng Ninh.',
    N'Ha Long City, Quang Ninh.',
    N'Sự kiện văn hóa - du lịch quy mô lớn, quảng bá hình ảnh Hạ Long và không gian biển đảo của Quảng Ninh.',
    N'A large-scale cultural and tourism event promoting the image of Ha Long and Quang Ninh’s coastal and island space.',
    N'Carnaval Hạ Long là một trong những sự kiện văn hóa - du lịch đương đại nổi bật nhất của Quảng Ninh, gắn với hình ảnh Hạ Long như một điểm đến biển đảo hàng đầu của Việt Nam. Sự kiện mang tính trình diễn cao, sôi động và hiện đại, đồng thời góp phần xây dựng thương hiệu du lịch cho địa phương. Không gian tổ chức thường gắn với bờ biển, quảng trường, các trục đường trung tâm và bầu không khí lễ hội mở rộng ra toàn đô thị du lịch.

Carnaval thường bao gồm các màn diễu hành, biểu diễn nghệ thuật, vũ hội đường phố, sân khấu ngoài trời và nhiều nội dung quảng bá hình ảnh văn hóa - du lịch của Quảng Ninh. Tùy từng năm, sự kiện có thể kết hợp các yếu tố văn hóa địa phương, biển đảo, giao lưu quốc tế và công nghệ trình diễn hiện đại. Điều này làm cho Carnaval Hạ Long không chỉ đơn thuần là một đêm hội mà còn là một biểu tượng của thành phố du lịch hiện đại hướng ra biển.

Trong hệ thống các sự kiện văn hóa đương đại của Việt Nam, Carnaval Hạ Long là đại diện tiêu biểu cho mô hình lễ hội đô thị hiện đại gắn với du lịch biển. Sự kiện có vai trò quan trọng trong việc quảng bá hình ảnh Hạ Long, tăng cường sức hút cho du lịch Quảng Ninh và thể hiện diện mạo năng động của một địa phương biển đảo phát triển mạnh.',
    N'Ha Long Carnival is one of the most prominent contemporary cultural and tourism events of Quang Ninh, closely associated with the image of Ha Long as one of Vietnam’s leading coastal and island destinations. The event is highly performative, vibrant, and modern, and it plays an important role in shaping the province’s tourism brand. The festival space is usually linked to the seaside, public squares, main streets, and the wider atmosphere of a coastal tourism city.

The carnival often includes parades, artistic performances, street festivities, outdoor stages, and many forms of tourism and cultural promotion related to Quang Ninh. Depending on the year, the event may combine local cultural elements, marine themes, international exchange, and modern performance technology. This makes Ha Long Carnival more than just a festive evening; it becomes a symbol of a modern city opening itself toward the sea.

Within the broader system of contemporary Vietnamese cultural events, Ha Long Carnival is a representative example of a modern urban festival associated with coastal tourism. It plays an important role in promoting Ha Long’s image, strengthening Quang Ninh’s tourism appeal, and expressing the dynamic identity of a strongly developing maritime locality.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'BAC_BO'),
    (SELECT TinhThanhID FROM dbo.TinhThanh WHERE MaTinh = 'QUANG_NINH'),
    NULL,
    N'https://tanthoidai.com.vn/images/products/2020/11/14/132497961408302481.jpg',
    N'https://cdn.xanhsm.com/2025/02/0c169822-carnaval-ha-long-1-min.jpg',
    GETDATE()
),
(
    'LE_HOI_NGHINH_ONG_SONG_DOC',
    N'Lễ hội Nghinh Ông Sông Đốc',
    N'Song Doc Whale Worship Festival',
    N'Thường diễn ra hằng năm theo lịch lễ hội ngư dân địa phương, gắn với mùa biển.',
    N'Usually held annually according to the local fishermen’s festival calendar, linked with the maritime season.',
    N'Thị trấn Sông Đốc, Cà Mau.',
    N'Song Doc Town, Ca Mau.',
    N'Lễ hội đặc trưng của cư dân biển Cà Mau, thể hiện tín ngưỡng thờ cá Ông và đời sống văn hóa ngư dân vùng cực Nam.',
    N'A characteristic festival of coastal Ca Mau, expressing whale worship and the cultural life of fishermen in Vietnam’s southernmost region.',
    N'Lễ hội Nghinh Ông Sông Đốc là một trong những lễ hội tiêu biểu của cư dân biển Cà Mau, gắn với tín ngưỡng thờ cá Ông – vị thần được ngư dân tin là che chở cho người đi biển. Trong không gian vùng biển cực Nam, nơi đời sống cộng đồng phụ thuộc lớn vào nghề đánh bắt và môi trường biển, lễ hội mang ý nghĩa tinh thần rất sâu sắc. Đây là dịp để người dân bày tỏ lòng tri ân, cầu cho những chuyến ra khơi an toàn, mùa cá thuận lợi và cuộc sống yên ổn.

Lễ hội thường có các nghi thức rước, cúng, dâng hương và nhiều hoạt động sinh hoạt cộng đồng gắn với cảng biển, tàu thuyền và không gian cư dân ven biển. Không khí lễ hội vừa linh thiêng vừa đậm sắc thái lao động biển, phản ánh niềm tin dân gian, tình đoàn kết cộng đồng và tinh thần bám biển của người dân Cà Mau. Ngoài phần lễ, các hoạt động giao lưu, văn nghệ, hội chợ hoặc sinh hoạt cộng đồng cũng góp phần làm cho lễ hội trở nên sống động và gần gũi.

Trong hệ thống lễ hội miền Nam, Nghinh Ông Sông Đốc là đại diện rất tiêu biểu cho loại hình lễ hội ngư dân vùng biển. Lễ hội góp phần lưu giữ truyền thống thờ cá Ông, bảo tồn đời sống văn hóa biển và làm nổi bật bản sắc cộng đồng cư dân vùng cực Nam của Tổ quốc.',
    N'The Song Doc Whale Worship Festival is one of the representative festivals of the coastal communities of Ca Mau, associated with the worship of the whale spirit, believed by fishermen to protect those who go to sea. In the far-southern maritime environment, where community life depends heavily on fishing and the sea itself, the festival carries profound spiritual meaning. It is an occasion for local people to express gratitude and pray for safe voyages, abundant catches, and peaceful lives.

The festival usually includes processions, worship ceremonies, incense offerings, and community activities connected with harbors, boats, and coastal settlement life. Its atmosphere is both sacred and deeply marked by maritime labor, reflecting folk belief, communal solidarity, and the seafaring spirit of Ca Mau residents. In addition to ritual practice, exchange programs, performances, fairs, and community gatherings often add vitality and accessibility to the event.

Within the festival system of Southern Vietnam, the Song Doc Whale Worship Festival is a highly representative example of a fishermen’s coastal festival. It helps preserve whale worship traditions, maintain maritime cultural life, and highlight the identity of communities living in the southernmost region of the country.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'NAM_BO'),
    (SELECT TinhThanhID FROM dbo.TinhThanh WHERE MaTinh = 'CA_MAU'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KINH'),
    N'https://mia.vn/media/uploads/blog-du-lich/le-hoi-nghinh-ong-song-doc-nghi-thuc-cau-ngu-doc-dao-tai-ca-mau-01-1663079332.jpeg',
    N'https://media-cdn-v2.laodong.vn/Storage/NewsPortal/2021/2/5/878035/Le-Hoi-1.jpg',
    GETDATE()
);
-----------------------------------------------------------------------------------------------------------------------------------






-------------------------------------------------------------- Thêm dữ liệu bảng  Văn Hóa ------------------------------------------

INSERT INTO dbo.VanHoa
(
    Ma,
    Loai,
    TenVI,
    TenEN,
    MoTaNganVI,
    MoTaNganEN,
    NoiDungChiTietVI,
    NoiDungChiTietEN,
    VungID,
    DanTocID,
    ImageUrl,
    TagsVI,
    TagsEN,
    NgayTao
)
VALUES
(
    N'TIN_NGUONG_THO_CUNG_TO_TIEN',
    N'TinNguong',
    N'Tín ngưỡng thờ cúng tổ tiên của người Việt',
    N'Ancestor Worship in Vietnamese Culture',
    N'Tín ngưỡng thờ cúng tổ tiên là một giá trị tinh thần cốt lõi trong văn hóa Việt Nam, thể hiện đạo lý uống nước nhớ nguồn, lòng hiếu kính với ông bà tổ tiên và sự gắn kết bền chặt giữa các thế hệ trong gia đình.',
    N'Ancestor worship is a core spiritual value in Vietnamese culture, expressing gratitude toward forebears, filial piety, and the enduring bond between generations within the family.',
    N'Tín ngưỡng thờ cúng tổ tiên từ lâu đã trở thành một phần không thể tách rời trong đời sống văn hóa và tinh thần của người Việt. Đây không chỉ là một tập tục dân gian được truyền lại qua nhiều thế hệ, mà còn là biểu hiện sâu sắc của đạo lý “uống nước nhớ nguồn”, nhắc nhở con cháu luôn ghi nhớ công lao sinh thành, dưỡng dục và nền nếp gia phong mà ông bà, cha mẹ đã dày công vun đắp. Trong quan niệm truyền thống, tổ tiên tuy đã khuất nhưng vẫn luôn hiện diện trong đời sống tinh thần của con cháu, dõi theo, chở che và nhắc nhở mỗi người sống sao cho xứng đáng với cội nguồn của mình.

Trong không gian gia đình Việt, bàn thờ tổ tiên thường được đặt ở vị trí trang trọng nhất của ngôi nhà. Đó là nơi hội tụ sự thành kính, lòng biết ơn và ý thức về sự tiếp nối giữa quá khứ, hiện tại và tương lai. Trên bàn thờ thường có bát hương, ảnh thờ, chân nến, mâm quả, lọ hoa và nhiều vật phẩm mang ý nghĩa tưởng niệm. Vào những dịp quan trọng như ngày giỗ, Tết Nguyên đán, lễ thanh minh, ngày sóc vọng hoặc khi gia đình có sự kiện lớn, con cháu thường sửa soạn lễ vật, thắp hương và dâng cúng với lòng thành kính. Những nghi lễ này không chỉ mang ý nghĩa tâm linh mà còn là dịp để các thành viên trong gia đình sum họp, tưởng nhớ về người đi trước và cùng nhau gìn giữ nề nếp gia phong.

Giá trị của tín ngưỡng thờ cúng tổ tiên không nằm ở sự cầu kỳ về hình thức hay vật phẩm cúng lễ, mà nằm ở chiều sâu đạo đức và ý nghĩa nhân văn mà nó mang lại. Thông qua việc thờ cúng tổ tiên, con cháu được giáo dục về lòng hiếu thảo, tinh thần biết ơn, trách nhiệm với gia đình và sự trân trọng đối với nguồn cội. Đây cũng là cách để mỗi gia đình lưu giữ ký ức, truyền lại gia phả, truyền thống sống và những bài học làm người cho thế hệ sau. Trong bối cảnh xã hội hiện đại với nhiều biến đổi về nhịp sống và lối sinh hoạt, tín ngưỡng này vẫn được duy trì bền bỉ, cho thấy sức sống mạnh mẽ của một giá trị văn hóa lâu đời. Chính vì vậy, thờ cúng tổ tiên không chỉ là nét đẹp trong đời sống gia đình mà còn là một trụ cột quan trọng làm nên bản sắc văn hóa Việt Nam.',
    N'Ancestor worship has long been an inseparable part of Vietnamese cultural and spiritual life. It is not simply a folk custom passed down from generation to generation, but a profound expression of gratitude, filial duty, and the moral principle of remembering one’s roots. In traditional Vietnamese thought, ancestors are not regarded as entirely absent after death; rather, they remain spiritually present in the lives of their descendants, watching over the family, offering guidance, and reminding each generation to live honorably and responsibly.

Within a Vietnamese household, the ancestral altar is usually placed in the most solemn and respected area of the home. It serves as a sacred focal point where reverence, remembrance, and family continuity are brought together. The altar often includes incense burners, ancestor portraits, candles, fruit offerings, flowers, and ceremonial objects associated with remembrance. On important occasions such as death anniversaries, Lunar New Year, the Qingming season, the first and full moon days of the lunar month, or major family milestones, descendants prepare offerings, burn incense, and perform rituals with deep sincerity. These acts are not merely symbolic. They create moments for family members to gather, remember those who came before them, and reaffirm the values that have shaped the family over time.

The significance of ancestor worship does not lie in elaborate ceremonies or material offerings, but in the ethical and humanistic values it preserves. Through this practice, younger generations learn filial piety, gratitude, humility, and a sense of responsibility toward their family and community. It is also a way for families to preserve memory, maintain genealogical awareness, and pass on moral teachings from one generation to the next. Even in contemporary society, where lifestyles and family structures have undergone many changes, ancestor worship remains widely practiced among Vietnamese people both inside the country and abroad. Its enduring presence reflects the resilience of a cultural tradition that continues to define Vietnamese identity, placing family, remembrance, and moral continuity at the heart of social life.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'BAC_BO'),
    NULL,
    N'https://admin.vov.gov.vn/UploadFolder/KhoTin/Images/UploadFolder/VOVVN/Images/sites/default/files/styles/large/public/2024-02/chuan_muc_tin_nguong_tho_cung_to_tien_cua_nguoi_viet.jpg',
    N'tín ngưỡng,thờ cúng tổ tiên,văn hóa Việt,uống nước nhớ nguồn,gia đình,truyền thống',
    N'belief,ancestor worship,Vietnamese culture,filial piety,family,tradition',
    GETDATE()
),
(
    N'KHONG_GIAN_CONG_CHIENG_TAY_NGUYEN',
    N'NgheThuat',
    N'Không gian văn hóa cồng chiêng Tây Nguyên',
    N'The Cultural Space of Gong Music in the Central Highlands',
    N'Không gian văn hóa cồng chiêng Tây Nguyên là một di sản văn hóa đặc sắc, phản ánh đời sống tinh thần, nghi lễ cộng đồng và mối quan hệ hài hòa giữa con người với thiên nhiên của các dân tộc Tây Nguyên.',
    N'The cultural space of gong music in the Central Highlands is a remarkable heritage that reflects spiritual life, communal rituals, and the harmonious relationship between people and nature among the ethnic groups of the region.',
    N'Không gian văn hóa cồng chiêng Tây Nguyên là một trong những biểu tượng tiêu biểu và giàu bản sắc nhất của đời sống văn hóa các dân tộc tại khu vực Tây Nguyên như Ê Đê, Ba Na, Gia Rai, M’Nông, Xơ Đăng và nhiều cộng đồng khác. Đối với người dân nơi đây, cồng chiêng không chỉ là nhạc cụ dùng để biểu diễn mà còn là vật thiêng gắn bó mật thiết với đời sống tâm linh, với cộng đồng và với thế giới tự nhiên. Âm thanh cồng chiêng vang lên trong nhiều thời khắc quan trọng của đời người và buôn làng, từ lễ mừng lúa mới, lễ cúng bến nước, lễ cưới, lễ bỏ mả đến những dịp đón khách quý hay sinh hoạt cộng đồng. Mỗi nhịp chiêng, mỗi bài chiêng đều hàm chứa tâm tư, niềm tin và tri thức văn hóa được tích lũy qua nhiều thế hệ.

Điểm đặc sắc của di sản này không chỉ nằm ở bản thân nhạc cụ hay kỹ thuật trình diễn, mà còn nằm ở toàn bộ không gian văn hóa bao quanh nó. Cồng chiêng gắn với lễ hội, nhà rông, bếp lửa, ché rượu cần, điệu múa xoang, trang phục truyền thống và các nghi thức cộng đồng. Khi tiếng chiêng cất lên, cả buôn làng cùng hòa vào một không gian vừa linh thiêng vừa gắn kết, nơi con người giao tiếp với thần linh, với tổ tiên và với nhau. Chính vì vậy, cồng chiêng không tồn tại tách biệt như một loại hình nghệ thuật biểu diễn đơn lẻ, mà là một phần trong cấu trúc văn hóa tổng thể của cộng đồng.

Ở nhiều buôn làng, bộ cồng chiêng được xem là tài sản quý giá, có giá trị tinh thần và biểu tượng rất lớn. Số lượng chiêng, chất lượng âm thanh, cách phối hợp giữa các chiếc chiêng và kỹ năng của người đánh chiêng đều phản ánh trình độ nghệ thuật, sự am hiểu văn hóa và vị thế của cộng đồng. Việc truyền dạy cồng chiêng thường được thực hiện bằng hình thức truyền khẩu và thực hành trực tiếp, qua đó thế hệ trẻ học được không chỉ kỹ năng diễn tấu mà còn cả cách ứng xử, phong tục, nghi lễ và tinh thần cộng đồng. Trong bối cảnh hiện đại, khi nhiều giá trị truyền thống đứng trước nguy cơ mai một, việc bảo tồn không gian văn hóa cồng chiêng càng có ý nghĩa quan trọng. Gìn giữ cồng chiêng không chỉ là bảo tồn âm nhạc dân gian mà còn là giữ gìn ký ức tập thể, tri thức bản địa và bản lĩnh văn hóa của các dân tộc Tây Nguyên.',
    N'The cultural space of gong music in the Central Highlands is one of the most distinctive and representative expressions of the cultural identity of ethnic communities such as the Ede, Ba Na, Gia Rai, M’Nong, Xo Dang, and others. For these communities, gongs are not merely musical instruments used for entertainment or performance. They are sacred objects deeply connected to spiritual life, communal rituals, and the natural world. The sound of the gongs accompanies important moments in both individual and collective life, including harvest celebrations, water source rituals, weddings, funerary ceremonies, receptions for honored guests, and major village gatherings. Each rhythm, sequence, and style of performance embodies emotional meaning, spiritual belief, and accumulated cultural knowledge.

What makes this heritage especially remarkable is that its value extends far beyond the instruments themselves. Gong culture exists within a larger cultural environment that includes festivals, communal houses, sacred fires, jars of rice wine, circle dances, traditional costumes, and ritual practices. When the gongs are played, the entire community becomes part of a shared space that is at once sacred, artistic, and social. In this setting, people communicate not only with one another, but also with their ancestors, protective spirits, and the forces of nature. Gong music therefore cannot be separated from the broader ceremonial and communal life in which it is embedded.

In many villages, a gong set is considered a treasured possession with both material and symbolic value. The number of gongs, the quality of their sound, the way they are coordinated in ensemble performance, and the skill of the players all reflect a community’s cultural refinement and social prestige. Knowledge of gong performance is traditionally passed down through oral instruction and hands-on participation, allowing younger generations to inherit not only musical ability but also ritual knowledge, ethical values, and communal identity. In modern times, as traditional ways of life face increasing pressure from social and economic change, preserving the cultural space of gong music has become especially important. To protect this heritage is not simply to preserve a musical tradition, but to safeguard collective memory, indigenous knowledge, and the cultural strength of the peoples of the Central Highlands.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'TRUNG_BO'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'EDE'),
    N'https://images.baodantoc.vn/uploads/2021/Th%C3%A1ng%204/Ng%C3%A0y_15/Thanh/images2711623_118.jpg',
    N'cồng chiêng,Tây Nguyên,di sản văn hóa,lễ hội,dân tộc,nghệ thuật dân gian',
    N'gongs,Central Highlands,cultural heritage,festival,ethnic culture,folk art',
    GETDATE()
),
(
    N'AO_DAI_TRUYEN_THONG_VIET_NAM',
    N'TrangPhuc',
    N'Áo dài truyền thống Việt Nam',
    N'The Vietnamese Traditional Ao Dai',
    N'Áo dài là trang phục truyền thống tiêu biểu của Việt Nam, thể hiện vẻ đẹp thanh lịch, kín đáo, duyên dáng và sự giao hòa giữa truyền thống với hiện đại trong bản sắc dân tộc.',
    N'The ao dai is a representative traditional costume of Vietnam, embodying elegance, modesty, grace, and the harmony between tradition and modernity within national identity.',
    N'Áo dài từ lâu đã được xem là một trong những biểu tượng văn hóa tiêu biểu nhất của Việt Nam. Với thiết kế ôm dáng, cổ cao, hai tà dài mềm mại kết hợp cùng quần dài, áo dài tôn lên vẻ đẹp thanh lịch, kín đáo nhưng vẫn rất duyên dáng của người mặc. Không chỉ là một loại trang phục, áo dài còn là hình ảnh gắn liền với tâm thức thẩm mỹ, phong cách ứng xử và niềm tự hào văn hóa của người Việt. Qua nhiều giai đoạn lịch sử, áo dài đã có những biến đổi nhất định về kiểu dáng, chất liệu, màu sắc và họa tiết, nhưng vẫn giữ được tinh thần cốt lõi là tôn vinh nét đẹp nền nã, tinh tế và giàu bản sắc dân tộc.

Trong đời sống xã hội, áo dài hiện diện trong nhiều hoàn cảnh quan trọng và mang nhiều tầng ý nghĩa khác nhau. Áo dài được mặc trong lễ cưới, dịp lễ Tết, ngày khai giảng, các chương trình nghệ thuật, sự kiện ngoại giao, cuộc thi nhan sắc và nhiều hoạt động văn hóa cộng đồng. Hình ảnh nữ sinh trong tà áo dài trắng, cô dâu trong áo dài truyền thống hay đại diện quốc gia mặc áo dài trong các dịp đối ngoại đã trở thành những biểu tượng quen thuộc, gợi nhắc mạnh mẽ về vẻ đẹp Việt Nam. Đối với nhiều người, mặc áo dài không chỉ là lựa chọn về trang phục mà còn là cách thể hiện sự trân trọng truyền thống, sự tự tin về bản sắc và tinh thần hướng về những giá trị văn hóa lâu bền.

Điểm đặc biệt của áo dài là khả năng thích nghi và phát triển cùng thời đại mà không đánh mất hồn cốt truyền thống. Ngày nay, áo dài được sáng tạo với nhiều chất liệu mới, cách cắt may hiện đại và họa tiết lấy cảm hứng từ thiên nhiên, nghệ thuật dân gian, di sản vùng miền hoặc biểu tượng lịch sử. Tuy nhiên, dù đổi mới đến đâu, áo dài vẫn được nhìn nhận như một biểu tượng của sự mềm mại, thanh cao và bản lĩnh văn hóa Việt Nam. Chính sự kết hợp hài hòa giữa yếu tố cổ truyền và tinh thần đương đại đã giúp áo dài giữ được vị trí đặc biệt trong đời sống văn hóa dân tộc, đồng thời tạo nên sức hấp dẫn riêng trong mắt bạn bè quốc tế.',
    N'The ao dai has long been regarded as one of the most iconic cultural symbols of Vietnam. With its fitted bodice, high collar, flowing panels, and elegant trousers, it creates a silhouette that is both graceful and modest, highlighting the wearer’s refinement and poise. More than a form of clothing, the ao dai represents an entire aesthetic philosophy rooted in dignity, restraint, and cultural pride. Although its design has evolved across historical periods in terms of tailoring, fabric, color, and decorative motifs, it has consistently preserved its essential spirit: the celebration of Vietnamese elegance and identity.

In social life, the ao dai appears in many important settings and carries multiple layers of meaning. It is worn at weddings, during the Lunar New Year, at school ceremonies, in artistic performances, diplomatic events, beauty pageants, and numerous cultural celebrations. The image of female students in white ao dai, brides in traditional ceremonial dress, and national representatives wearing ao dai in international contexts has become deeply associated with Vietnamese beauty and cultural dignity. For many people, wearing the ao dai is not simply a stylistic choice. It is a way of honoring tradition, expressing self-respect, and affirming a connection to enduring cultural values.

One of the most remarkable qualities of the ao dai is its ability to adapt to changing times without losing its traditional essence. Today, designers continue to reinterpret the garment through new materials, contemporary tailoring techniques, and motifs inspired by nature, folk art, regional heritage, or historical symbolism. Yet despite these innovations, the ao dai remains widely recognized as an emblem of softness, elegance, and Vietnamese cultural confidence. Its lasting appeal lies precisely in this balance between heritage and modern expression, which allows it to remain relevant in contemporary life while continuing to represent the soul of Vietnamese tradition.',
    NULL,
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KINH'),
    N'https://special.vietnamplus.vn/wp-content/uploads/2021/03/2909aodai2-1601344550-91-1568x1226.jpg',
    N'áo dài,trang phục truyền thống,Việt Nam,văn hóa,bản sắc,duyên dáng',
    N'ao dai,traditional costume,Vietnam,culture,identity,elegance',
    GETDATE()
),
(
    N'NHA_SAN_TRONG_VAN_HOA_MIEN_NUI',
    N'NhaO',
    N'Nhà sàn trong văn hóa dân tộc miền núi',
    N'Stilt Houses in Highland Ethnic Culture',
    N'Nhà sàn là kiểu kiến trúc truyền thống phổ biến ở nhiều cộng đồng dân tộc miền núi, phản ánh sự thích nghi với môi trường tự nhiên, lối sống cộng đồng và tri thức bản địa phong phú.',
    N'Stilt houses are a traditional architectural form common among many highland ethnic communities, reflecting adaptation to the natural environment, communal living, and rich indigenous knowledge.',
    N'Nhà sàn là một loại hình kiến trúc truyền thống tiêu biểu của nhiều cộng đồng dân tộc sinh sống tại vùng trung du và miền núi Việt Nam. Với kết cấu được nâng cao khỏi mặt đất bằng hệ thống cột chắc chắn, nhà sàn là kết quả của quá trình thích nghi lâu dài với điều kiện địa hình, khí hậu và môi trường sống đặc thù. Việc dựng nhà cao giúp tránh ẩm thấp, thú dữ, côn trùng, đồng thời tạo độ thông thoáng phù hợp với điều kiện khí hậu nóng ẩm hoặc khu vực có mưa nhiều. Các vật liệu dùng để dựng nhà như gỗ, tre, nứa, lá cọ hay tranh thường được lấy từ tự nhiên, thể hiện sự khéo léo và hiểu biết sâu sắc của cư dân bản địa trong việc tận dụng nguồn lực sẵn có.

Không gian bên trong nhà sàn thường được bố trí một cách khoa học và hài hòa với nếp sống của từng cộng đồng. Mỗi khu vực trong nhà có thể mang một chức năng riêng như nơi tiếp khách, chỗ sinh hoạt chung, khu vực bếp lửa, nơi ngủ nghỉ hoặc nơi cất giữ lương thực. Ở nhiều dân tộc, bếp lửa không chỉ dùng để nấu nướng mà còn là trung tâm của đời sống gia đình, nơi mọi người quây quần, trò chuyện, truyền dạy kinh nghiệm và gắn kết tình cảm. Nhà sàn vì thế không đơn thuần là nơi ở, mà còn là không gian lưu giữ ký ức, phong tục tập quán, mối quan hệ gia đình và cộng đồng.

Ngoài chức năng sinh hoạt, nhà sàn còn mang đậm dấu ấn văn hóa và thẩm mỹ của từng tộc người. Từ cách chọn hướng nhà, số bậc cầu thang, kiểu mái, hình thức chạm khắc cho đến những quy định liên quan đến khách, chủ, nam nữ hay người lớn tuổi, tất cả đều phản ánh quan niệm sống và tổ chức xã hội của cộng đồng. Trong bối cảnh hiện đại, nhiều nơi đã thay đổi vật liệu và phương thức xây dựng để phù hợp với nhu cầu mới, nhưng nhà sàn truyền thống vẫn giữ giá trị đặc biệt về văn hóa, kiến trúc và lịch sử. Việc bảo tồn nhà sàn không chỉ là giữ lại một kiểu nhà cổ truyền mà còn là bảo vệ một không gian sống chứa đựng tri thức bản địa, sự gắn bó cộng đồng và bản sắc riêng của các dân tộc miền núi Việt Nam.',
    N'Stilt houses are among the most representative traditional architectural forms found in the upland and midland regions of Vietnam. Raised above the ground on sturdy pillars, they are the result of a long process of adaptation to the terrain, climate, and ecological conditions of mountain life. Elevating the living space helps protect inhabitants from dampness, wild animals, insects, and seasonal flooding, while also improving ventilation in humid or rainy environments. The materials used to build these houses, such as timber, bamboo, rattan, palm leaves, and thatch, are typically sourced from the surrounding environment, demonstrating the practical wisdom and craftsmanship of local communities.

The interior of a stilt house is usually arranged in a way that reflects both functionality and cultural order. Different sections of the house may be reserved for receiving guests, communal family activities, cooking, sleeping, or storing grain and household items. In many ethnic communities, the hearth is especially important. It is not only used for preparing food, but also serves as the emotional center of the home, where family members gather, share stories, transmit experience, and strengthen social bonds. For this reason, the stilt house is far more than a shelter. It is a living cultural space where memory, custom, kinship, and communal values are preserved and practiced.

Beyond its practical uses, the stilt house also reflects the cultural identity and aesthetic sensibilities of each ethnic group. The orientation of the house, the number of steps on the staircase, the design of the roof, decorative carvings, and even rules governing the use of space often carry symbolic and social meaning. These features reveal how each community understands hierarchy, gender roles, hospitality, spirituality, and its relationship with the natural world. In the modern era, building materials and construction methods have changed in many places, yet the traditional stilt house continues to hold profound cultural, architectural, and historical value. Preserving it means preserving not only a form of indigenous housing, but also a way of life shaped by environmental knowledge, communal solidarity, and ethnic identity.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'BAC_BO'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'THAI'),
    N'https://images.baodantoc.vn/uploads/2023/Th%C3%A1ng%206/Nga%CC%80y%2028/Man%20On/zaaa.jpg',
    N'nhà sàn,kiến trúc truyền thống,miền núi,dân tộc,bản địa,không gian sống',
    N'stilt house,traditional architecture,highland,ethnic culture,indigenous,living space',
    GETDATE()
),
(
    N'HAT_THEN_TRONG_DOI_SONG_TAY_NUNG_THAI',
    N'AmNhac',
    N'Hát then trong đời sống văn hóa Tày, Nùng, Thái',
    N'Then Singing in the Cultural Life of Tay, Nung, and Thai Communities',
    N'Hát then là loại hình diễn xướng dân gian đặc sắc kết hợp âm nhạc, lời ca, nghi lễ và đời sống tinh thần, phản ánh chiều sâu văn hóa của cộng đồng Tày, Nùng và Thái ở Việt Nam.',
    N'Then singing is a distinctive form of folk performance that combines music, poetry, ritual, and spiritual life, reflecting the cultural depth of Tay, Nung, and Thai communities in Vietnam.',
    N'Hát then là một loại hình diễn xướng dân gian đặc sắc gắn bó mật thiết với đời sống tinh thần của người Tày, Nùng và một bộ phận người Thái ở Việt Nam. Trong thực hành truyền thống, hát then thường đi cùng tiếng đàn tính, tạo nên một không gian nghệ thuật vừa trữ tình, sâu lắng vừa linh thiêng, huyền ảo. Lời then thường giàu chất thơ, mang tính kể chuyện, khuyên răn, cầu chúc hoặc bày tỏ ước vọng về cuộc sống bình an, mùa màng tốt tươi, gia đình hạnh phúc và con người khỏe mạnh. Chính vì thế, hát then không chỉ là âm nhạc để thưởng thức mà còn là phương tiện chuyển tải tâm tư, niềm tin và tri thức văn hóa của cộng đồng.

Trong nhiều hoàn cảnh, hát then gắn với các nghi lễ quan trọng như cầu an, cầu mùa, giải hạn, mừng nhà mới, chúc phúc hoặc các sinh hoạt cộng đồng. Người thực hành then thường là những người có hiểu biết sâu về lời ca, nghi lễ, phong tục và cách sử dụng đàn tính. Qua giọng hát, nhịp đàn và lối diễn xướng, họ kết nối con người với thế giới tinh thần, đồng thời mang lại sự an ủi, khích lệ và niềm tin cho cộng đồng. Không gian hát then vì vậy vừa mang tính nghệ thuật, vừa mang tính tín ngưỡng, nơi người nghe không chỉ thưởng thức âm thanh mà còn cảm nhận được chiều sâu tâm linh và bản sắc văn hóa riêng biệt của tộc người.

Ngày nay, hát then không còn chỉ tồn tại trong khuôn khổ nghi lễ mà còn được biểu diễn trong các lễ hội, chương trình giao lưu văn hóa và hoạt động bảo tồn di sản. Tuy nhiên, giá trị cốt lõi của hát then vẫn nằm ở khả năng lưu giữ tiếng nói tâm hồn của cộng đồng, phản ánh thế giới quan, nhân sinh quan và khát vọng sống tốt đẹp của con người. Việc bảo tồn và truyền dạy hát then cho thế hệ trẻ có ý nghĩa rất lớn trong việc giữ gìn bản sắc văn hóa dân tộc, đồng thời góp phần làm phong phú thêm kho tàng di sản văn hóa Việt Nam.',
    N'Then singing is a distinctive form of folk performance deeply embedded in the spiritual and cultural life of the Tay, Nung, and some Thai communities in Vietnam. Traditionally, it is performed together with the tinh lute, creating an artistic atmosphere that is at once lyrical, meditative, and sacred. The lyrics of then are often poetic and narrative in nature, offering blessings, moral guidance, prayers for peace, hopes for abundant harvests, and wishes for family well-being and personal health. In this sense, then singing is not merely music for entertainment, but a medium through which communal emotions, beliefs, and cultural knowledge are expressed and transmitted.

In many contexts, then singing is associated with important rituals such as ceremonies for peace, agricultural prosperity, spiritual protection, house blessings, and communal celebrations. Those who perform then are often individuals with deep knowledge of ritual language, local customs, spiritual practice, and musical expression. Through their voice, instrumental accompaniment, and ceremonial presence, they create a bridge between the human world and the spiritual realm, while also offering comfort, encouragement, and a sense of collective meaning to the community. The space of then performance therefore operates on both artistic and spiritual levels, allowing audiences to experience not only melody and poetry, but also the depth of an inherited cultural worldview.

Today, then singing is no longer confined solely to ritual settings. It also appears in festivals, cultural exchange programs, stage performances, and heritage preservation activities. Even so, its core value remains unchanged: it continues to preserve the inner voice of the community, reflecting its worldview, moral outlook, and aspirations for a good life. Efforts to preserve and transmit then singing to younger generations are essential for safeguarding ethnic identity and ensuring that this rich tradition remains a living part of Vietnam’s cultural heritage.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'BAC_BO'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'TAY'),
    N'https://images.baodantoc.vn/uploads/2023/Thang-12/Ngay-4/Van-Hoa/Then%202/6.jpg',
    N'hát then,đàn tính,Tày,Nùng,Thái,di sản văn hóa,âm nhạc dân gian',
    N'then singing,tinh lute,Tay,Nung,Thai,cultural heritage,folk music',
    GETDATE()
),
(
    N'LE_HOI_OK_OM_BOK_CUA_NGUOI_KHMER',
    N'LeHoi',
    N'Lễ hội Ok Om Bok của người Khmer',
    N'Ok Om Bok Festival of the Khmer Community',
    N'Lễ hội Ok Om Bok là một sinh hoạt văn hóa đặc sắc của người Khmer Nam Bộ, gắn với tín ngưỡng nông nghiệp, lòng biết ơn đối với thiên nhiên và khát vọng về mùa màng no đủ.',
    N'The Ok Om Bok Festival is a distinctive cultural celebration of the Khmer community in Southern Vietnam, closely linked to agricultural beliefs, gratitude toward nature, and hopes for prosperity.',
    N'Lễ hội Ok Om Bok là một trong những lễ hội truyền thống tiêu biểu của cộng đồng Khmer Nam Bộ, thường được tổ chức vào thời điểm kết thúc mùa mưa và chuẩn bị bước sang vụ mùa mới. Đây là dịp để người dân bày tỏ lòng biết ơn đối với mặt trăng, thiên nhiên và các lực lượng đã phù hộ cho mùa màng sinh trưởng, cuộc sống yên ổn và cộng đồng được no đủ. Trong đời sống văn hóa của người Khmer, lễ hội không chỉ mang ý nghĩa tín ngưỡng nông nghiệp mà còn là thời điểm quan trọng để cộng đồng sum họp, vui chơi, thắt chặt tình đoàn kết và cùng hướng về những giá trị truyền thống.

Một trong những nghi thức đặc sắc nhất của lễ hội là lễ cúng trăng. Khi trăng lên cao và sáng rõ, người dân chuẩn bị lễ vật như cốm dẹp, khoai, dừa, chuối và nhiều sản vật khác để dâng cúng với lòng thành kính. Trẻ em thường được người lớn đút cốm dẹp trong không khí vui tươi, gửi gắm mong ước về sức khỏe, sự trưởng thành và một tương lai tốt đẹp. Bên cạnh phần nghi lễ, lễ hội còn có nhiều hoạt động văn hóa sôi nổi như múa hát, biểu diễn nghệ thuật dân gian, các trò chơi cộng đồng và đặc biệt là đua ghe ngo ở nhiều địa phương. Những hoạt động này tạo nên bầu không khí rộn ràng, giàu bản sắc và phản ánh sức sống mạnh mẽ của văn hóa Khmer.

Giá trị của lễ hội Ok Om Bok không chỉ nằm ở hình thức sinh hoạt cộng đồng mà còn ở ý nghĩa giáo dục và gìn giữ bản sắc văn hóa. Thông qua lễ hội, các thế hệ trẻ được tiếp cận với phong tục truyền thống, hiểu hơn về đời sống tinh thần của dân tộc mình và nuôi dưỡng niềm tự hào về cội nguồn. Trong bối cảnh hiện đại, khi nhiều sinh hoạt truyền thống có nguy cơ bị mai một, lễ hội Ok Om Bok vẫn giữ được sức hấp dẫn và vai trò quan trọng trong đời sống cộng đồng. Đây không chỉ là một lễ hội dân gian đặc sắc mà còn là biểu hiện sinh động của mối quan hệ hài hòa giữa con người, thiên nhiên và niềm tin văn hóa của người Khmer Nam Bộ.',
    N'The Ok Om Bok Festival is one of the most representative traditional celebrations of the Khmer community in Southern Vietnam. It is usually held at the end of the rainy season, at a time when agricultural communities prepare to enter a new production cycle. The festival is an occasion for people to express gratitude to the moon, to nature, and to the forces believed to have protected the crops, ensured peace, and sustained communal well-being. In Khmer cultural life, the festival is not only tied to agricultural belief systems but also serves as an important opportunity for gathering, celebration, social bonding, and the reaffirmation of shared traditions.

One of the most distinctive parts of the festival is the moon worship ceremony. When the moon rises high and bright, families prepare offerings such as flattened rice, sweet potatoes, coconuts, bananas, and other agricultural products to present with sincerity and reverence. Children are often fed flattened rice by their elders in a joyful ritual gesture that carries wishes for health, growth, and a fortunate future. Alongside the ceremonial aspects, the festival also includes vibrant cultural activities such as singing, dancing, folk performances, communal games, and in many places the famous ngo boat races. Together, these elements create a lively and memorable atmosphere that reflects the vitality and uniqueness of Khmer culture.

The value of the Ok Om Bok Festival lies not only in its communal celebrations, but also in its role in cultural preservation and intergenerational education. Through the festival, younger generations become familiar with traditional customs, gain a deeper understanding of their community’s spiritual life, and develop pride in their heritage. In the modern era, when many traditional practices face the risk of fading, Ok Om Bok continues to maintain its relevance and attraction. It stands not only as a remarkable folk festival, but also as a vivid expression of the harmonious relationship between human beings, nature, and the cultural beliefs of the Khmer people in Southern Vietnam.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'NAM_BO'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KHMER'),
    N'https://cly.1cdn.vn/2023/11/12/anh-2.jpg',
    N'Ok Om Bok,lễ hội Khmer,cúng trăng,Nam Bộ,đua ghe ngo,văn hóa dân tộc',
    N'Ok Om Bok,Khmer festival,moon worship,Southern Vietnam,ngo boat race,ethnic culture',
    GETDATE()
),
(
    N'NHA_NHAC_CUNG_DINH_HUE',
    N'NgheThuat',
    N'Nhã nhạc cung đình Huế',
    N'Hue Royal Court Music',
    N'Nhã nhạc cung đình Huế là loại hình âm nhạc bác học tiêu biểu của triều đình phong kiến Việt Nam, thể hiện vẻ đẹp trang trọng, tinh tế và đậm chiều sâu lịch sử văn hóa dân tộc.',
    N'Hue Royal Court Music is a distinguished form of classical ceremonial music of the Vietnamese feudal court, embodying solemnity, refinement, and deep historical-cultural significance.',
    N'Nhã nhạc cung đình Huế là một loại hình âm nhạc bác học đặc sắc gắn liền với đời sống cung đình Việt Nam, đặc biệt phát triển rực rỡ dưới triều Nguyễn. Đây không chỉ là âm nhạc dùng trong các nghi lễ của triều đình mà còn là biểu hiện tập trung của tư tưởng chính trị, lễ nghi, mỹ học và trật tự xã hội trong chế độ quân chủ. Nhã nhạc thường được trình diễn trong những dịp trọng đại như lễ đăng quang, tế giao, lễ tế miếu, tiếp sứ thần, sinh nhật vua và các nghi lễ quan trọng khác của hoàng gia. Vì vậy, loại hình âm nhạc này mang tính trang nghiêm, chuẩn mực và đòi hỏi sự chỉn chu rất cao trong cả âm thanh, tiết tấu lẫn hình thức biểu diễn.

Điểm nổi bật của nhã nhạc nằm ở sự kết hợp hài hòa giữa âm nhạc, ca xướng, múa cung đình, trang phục, nghi thức và không gian trình diễn. Dàn nhạc sử dụng nhiều loại nhạc cụ truyền thống như đàn tỳ bà, đàn nguyệt, đàn nhị, sáo, trống, kèn và các nhạc cụ gõ, tạo nên âm hưởng vừa uy nghi vừa thanh nhã. Các bài bản trong nhã nhạc được xây dựng theo khuôn thức chặt chẽ, phản ánh tư duy nghệ thuật tinh luyện và khả năng tổ chức âm nhạc ở trình độ cao. Không chỉ dừng lại ở chức năng phục vụ triều đình, nhã nhạc còn cho thấy trình độ phát triển của văn hóa Việt Nam trong việc hình thành một hệ thống nghệ thuật mang tính bác học, có quy chuẩn và tính biểu tượng rõ rệt.

Ngày nay, nhã nhạc cung đình Huế không còn tồn tại trong môi trường cung đình như trước, nhưng giá trị của nó vẫn được bảo tồn và phát huy thông qua các chương trình biểu diễn, nghiên cứu, đào tạo và hoạt động quảng bá di sản. Việc gìn giữ nhã nhạc không chỉ là bảo tồn một loại hình âm nhạc cổ truyền quý giá mà còn là cách lưu giữ ký ức lịch sử, tinh thần lễ nhạc và vẻ đẹp văn hóa cung đình Việt Nam. Đây là một di sản có giá trị đặc biệt, giúp thế hệ hôm nay hiểu rõ hơn về chiều sâu văn hiến của dân tộc và sức sáng tạo của nghệ thuật truyền thống.',
    N'Hue Royal Court Music is a remarkable form of classical ceremonial music closely associated with the royal life of Vietnam, especially during the Nguyen Dynasty. It was not merely music performed for entertainment within the palace, but an artistic form deeply connected to state rituals, political symbolism, court etiquette, aesthetics, and social order in the imperial system. Royal court music was performed on important occasions such as coronations, heaven and earth rituals, ancestral worship ceremonies, receptions for foreign envoys, royal birthdays, and other major events of the monarchy. As a result, it carried a highly formal and solemn character, requiring precision, discipline, and refinement in every aspect of performance.

One of the defining features of Hue Royal Court Music is its integration of instrumental performance, vocal elements, ceremonial dance, costumes, ritual context, and architectural space. The orchestra includes a range of traditional instruments such as the pipa, moon lute, two-string fiddle, flute, drums, oboes, and percussion instruments, producing an atmosphere that is both majestic and elegant. Its musical compositions are carefully structured, reflecting a sophisticated artistic system and a highly developed sense of musical organization. Beyond its ceremonial role, this musical tradition also demonstrates the intellectual and cultural maturity of Vietnamese court civilization in creating a refined performing art with codified forms and symbolic meaning.

Although the original court environment no longer exists, the value of Hue Royal Court Music continues to be preserved through performances, academic research, educational efforts, and heritage promotion activities. Safeguarding this art form means preserving more than a historical musical genre; it means protecting a cultural memory shaped by ritual, beauty, and the ceremonial worldview of traditional Vietnam. As a heritage of exceptional significance, Hue Royal Court Music offers contemporary generations a deeper understanding of the nation’s cultural sophistication and the enduring creativity of its traditional arts.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'TRUNG_BO'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KINH'),
    N'https://khamphahue.com.vn/Portals/0/Medias/Nam2022/T10/Khamphahue_NhaNhacCungDinhHue_DiSanPhiVatTheTruyenKhauCuaNhanLoai-1.jpg',
    N'nhã nhạc,Huế,cung đình,âm nhạc truyền thống,di sản văn hóa,triều Nguyễn',
    N'royal court music,Hue,imperial court,traditional music,cultural heritage,Nguyen Dynasty',
    GETDATE()
),
(
    N'DAN_CA_QUAN_HO_BAC_NINH',
    N'AmNhac',
    N'Dân ca quan họ Bắc Ninh',
    N'Quan Ho Folk Songs of Bac Ninh',
    N'Dân ca quan họ Bắc Ninh là loại hình hát giao duyên đặc sắc của vùng Kinh Bắc, thể hiện vẻ đẹp trong lời ca, ứng xử văn hóa và tình cảm cộng đồng.',
    N'Quan Ho folk songs of Bac Ninh are a distinctive form of antiphonal love duet singing from the Kinh Bac region, reflecting lyrical beauty, cultural etiquette, and communal affection.',
    N'Dân ca quan họ Bắc Ninh là một loại hình nghệ thuật dân gian đặc sắc gắn liền với vùng văn hóa Kinh Bắc, nơi có truyền thống lâu đời về lối sống thanh lịch, trọng tình nghĩa và giàu chất thơ. Quan họ nổi bật với hình thức hát đối đáp giữa liền anh và liền chị, trong đó mỗi bên cất lên những câu hát giao duyên để bày tỏ tình cảm, sự mến khách, trí tuệ và tài ứng đối. Những làn điệu quan họ thường có giai điệu mượt mà, sâu lắng, lời ca trau chuốt, giàu hình ảnh và cảm xúc, thể hiện rõ vẻ đẹp tinh tế trong tâm hồn người dân vùng đồng bằng Bắc Bộ.

Không gian diễn xướng của quan họ rất phong phú, có thể diễn ra ở sân đình, bến nước, cửa chùa, trong hội làng hoặc tại những buổi gặp gỡ mang tính kết chạ giữa các làng quan họ. Điểm đặc sắc của quan họ không chỉ nằm ở âm nhạc mà còn ở phong cách ứng xử. Người hát quan họ coi trọng lễ nghĩa, sự nhã nhặn, tinh thần tôn trọng bạn hát và sự trong sáng trong giao tiếp. Trang phục truyền thống như áo tứ thân, nón quai thao, khăn xếp, áo the góp phần tạo nên vẻ đẹp riêng cho loại hình nghệ thuật này. Tất cả hòa quyện thành một không gian văn hóa mà trong đó âm nhạc, lời nói, cử chỉ và đạo ứng xử cùng góp phần làm nên giá trị của quan họ.

Ngày nay, dân ca quan họ không chỉ hiện diện trong các lễ hội truyền thống mà còn được bảo tồn, truyền dạy trong trường học, câu lạc bộ văn hóa và nhiều hoạt động nghệ thuật cộng đồng. Việc gìn giữ quan họ có ý nghĩa rất lớn trong việc bảo vệ một di sản mang đậm bản sắc vùng miền và giá trị nhân văn sâu sắc. Quan họ không chỉ là tiếng hát giao duyên mà còn là biểu hiện sinh động của một lối sống trọng tình, trọng nghĩa, trọng vẻ đẹp của ngôn từ và sự hài hòa trong quan hệ giữa con người với con người.',
    N'Quan Ho folk songs are a distinctive form of traditional performance deeply rooted in the Kinh Bac cultural region, an area long known for its elegance, emotional richness, and poetic sensibility. Quan Ho is especially recognized for its antiphonal style of singing between male and female counterparts, known as liền anh and liền chị, who exchange lyrical verses in a spirit of affection, hospitality, intelligence, and graceful interaction. The melodies are typically gentle and expressive, while the lyrics are refined, image-rich, and emotionally nuanced, revealing the subtle beauty of the people of the northern delta.

The performance setting of Quan Ho is diverse and culturally meaningful. It can take place in village courtyards, at communal houses, near pagodas, by riversides, during spring festivals, or in the context of ceremonial friendship exchanges between Quan Ho villages. What makes Quan Ho truly special is that its value lies not only in the music itself, but also in the way it embodies a code of conduct. Singers are expected to show politeness, sincerity, mutual respect, and emotional restraint. Traditional costumes such as four-panel dresses, flat palm hats, turbans, and ceremonial tunics add to the unique visual identity of the genre. Together, music, language, gesture, and etiquette form a complete cultural space that gives Quan Ho its enduring charm.

Today, Quan Ho folk singing continues to live on not only in traditional festivals but also in schools, community clubs, and cultural preservation initiatives. Protecting this tradition is important not only because it is a valuable artistic heritage, but also because it preserves a regional way of life rooted in emotional depth, mutual respect, and the beauty of human connection. Quan Ho is more than a form of duet singing; it is a vivid expression of social grace, poetic culture, and the harmonious values that have shaped northern Vietnamese identity.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'BAC_BO'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KINH'),
    N'https://hoangthanhthanglong.vn/wp-content/uploads/2023/05/quanho1.jpg',
    N'quan họ,Bắc Ninh,Kinh Bắc,dân ca,hát giao duyên,di sản văn hóa',
    N'Quan Ho,Bac Ninh,Kinh Bac,folk songs,duet singing,cultural heritage',
    GETDATE()
),
(
    N'DON_CA_TAI_TU_NAM_BO',
    N'AmNhac',
    N'Đờn ca tài tử Nam Bộ',
    N'Southern Amateur Music of Vietnam',
    N'Đờn ca tài tử Nam Bộ là loại hình âm nhạc truyền thống mang đậm chất trữ tình, phản ánh tâm hồn phóng khoáng, tinh tế và giàu cảm xúc của con người vùng sông nước phương Nam.',
    N'Southern amateur music of Vietnam is a traditional musical form rich in lyrical expression, reflecting the open-hearted, refined, and emotional spirit of the people of the southern river region.',
    N'Đờn ca tài tử Nam Bộ là một loại hình nghệ thuật âm nhạc đặc sắc hình thành và phát triển trong không gian văn hóa sông nước Nam Bộ. Đây là loại hình âm nhạc mang tính bác học dân gian, vừa kế thừa tinh hoa của nhạc lễ, nhạc cung đình, vừa được sáng tạo và biến đổi để phù hợp với đời sống tinh thần gần gũi, phóng khoáng của người dân phương Nam. Đờn ca tài tử thường được biểu diễn trong những buổi gặp gỡ bạn bè, sinh hoạt gia đình, lễ hội, đám tiệc hoặc những lúc thư nhàn, qua đó thể hiện sự giao cảm, chia sẻ và thưởng thức nghệ thuật trong cộng đồng.

Điểm đặc sắc của đờn ca tài tử nằm ở tính ngẫu hứng, khả năng biến tấu linh hoạt và sự hòa quyện giữa tiếng đàn với lời ca. Các nhạc cụ thường dùng gồm đàn kìm, đàn tranh, đàn cò, đàn bầu, sáo và đặc biệt là guitar phím lõm, một sáng tạo rất riêng của Nam Bộ. Người biểu diễn không chỉ cần nắm vững bài bản mà còn phải có khả năng cảm nhận tinh tế để diễn tả trọn vẹn sắc thái tình cảm trong từng câu nhạc, từng hơi điệu. Nội dung của đờn ca tài tử thường gắn với tình yêu quê hương, nỗi niềm con người, đạo lý sống, tình cảm gia đình và những rung động sâu kín trong tâm hồn.

Không chỉ là một hình thức giải trí tao nhã, đờn ca tài tử còn phản ánh thế giới tinh thần phong phú và nhân sinh quan của cư dân Nam Bộ. Trong không gian miệt vườn, trên ghe thuyền hay trong những căn nhà truyền thống, tiếng đờn tiếng ca vang lên như một phần tự nhiên của cuộc sống, giúp con người xích lại gần nhau hơn. Ngày nay, dù đời sống hiện đại có nhiều thay đổi, đờn ca tài tử vẫn được bảo tồn và thực hành rộng rãi trong nhiều câu lạc bộ, lễ hội và chương trình nghệ thuật. Việc gìn giữ loại hình này không chỉ góp phần bảo vệ di sản âm nhạc dân tộc mà còn gìn giữ tâm hồn và bản sắc văn hóa của vùng đất Nam Bộ.',
    N'Southern amateur music, known as đờn ca tài tử, is a distinctive musical tradition that emerged and flourished in the cultural landscape of southern Vietnam. It represents a refined yet intimate form of traditional music, inheriting elements from ceremonial and court music while adapting them to the open, expressive, and emotionally rich lifestyle of the southern people. This genre is commonly performed in friendly gatherings, family occasions, festivals, celebrations, or moments of leisure, creating a musical setting where people connect through shared feeling and aesthetic appreciation.

One of the most remarkable features of đờn ca tài tử is its flexibility, improvisational spirit, and close relationship between instrumental performance and vocal expression. Common instruments include the moon lute, zither, two-string fiddle, monochord, flute, and most notably the modified “guitar with recessed frets,” a uniquely southern innovation. Performers must not only master established melodies, but also possess emotional sensitivity and interpretive skill in order to convey the subtle shades of each phrase and mode. The themes of the songs often revolve around love for the homeland, moral reflection, family affection, human longing, and the inner emotional life of ordinary people.

More than an elegant pastime, đờn ca tài tử expresses the worldview, emotional richness, and cultural identity of the people of the Mekong region. Whether heard in orchards, on boats, or in traditional homes, its melodies seem to arise naturally from the rhythms of everyday life, drawing people closer together through music and shared emotion. Although modern society has changed many aspects of daily life, this art form continues to be practiced and preserved through community clubs, festivals, and stage performances. Safeguarding đờn ca tài tử means preserving not only a musical heritage, but also the soul and cultural character of southern Vietnam.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'NAM_BO'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KINH'),
    N'https://images.baodantoc.vn/uploads/2020/Th%C3%A1ng_11/Ng%C3%A0y_21_22/8.jpg',
    N'đờn ca tài tử,Nam Bộ,âm nhạc truyền thống,sông nước,di sản văn hóa,dân gian',
    N'southern amateur music,South Vietnam,traditional music,river culture,cultural heritage,folk art',
    GETDATE()
),
(
    N'NGHE_DET_THO_CAM_TAY_NGUYEN',
    N'NgheThuCong',
    N'Nghề dệt thổ cẩm Tây Nguyên',
    N'Traditional Brocade Weaving in the Central Highlands',
    N'Nghề dệt thổ cẩm Tây Nguyên là một nghề thủ công truyền thống đặc sắc, phản ánh sự khéo léo, tư duy thẩm mỹ và bản sắc văn hóa của nhiều dân tộc trong khu vực.',
    N'Traditional brocade weaving in the Central Highlands is a distinctive handicraft that reflects the skill, aesthetic thought, and cultural identity of many ethnic communities in the region.',
    N'Nghề dệt thổ cẩm là một trong những nghề thủ công truyền thống tiêu biểu của nhiều dân tộc ở Tây Nguyên như Ê Đê, M’Nông, Gia Rai, Ba Na và nhiều cộng đồng khác. Không chỉ tạo ra trang phục và vật dụng phục vụ đời sống, nghề dệt còn là nơi lưu giữ tri thức bản địa, quan niệm thẩm mỹ và ký ức văn hóa của cộng đồng. Từ khâu chọn sợi, nhuộm màu, mắc khung đến dệt hoa văn, mỗi công đoạn đều đòi hỏi sự kiên nhẫn, khéo léo và kinh nghiệm được truyền dạy từ thế hệ này sang thế hệ khác. Những tấm vải thổ cẩm không chỉ có giá trị sử dụng mà còn mang giá trị biểu tượng, gắn với đời sống tinh thần, lễ hội, hôn nhân và vị thế xã hội.

Hoa văn trên thổ cẩm Tây Nguyên thường lấy cảm hứng từ thiên nhiên, đời sống lao động, con người, con vật, cây cỏ, núi rừng hoặc các biểu tượng tâm linh quen thuộc trong đời sống của từng tộc người. Mỗi màu sắc, đường nét và bố cục đều thể hiện một cách nhìn riêng về thế giới xung quanh, đồng thời phản ánh óc sáng tạo và bản sắc riêng biệt của cộng đồng làm ra nó. Trong nhiều trường hợp, chỉ cần nhìn vào họa tiết, màu nền hay kiểu phối màu, người am hiểu có thể nhận ra nguồn gốc dân tộc hoặc vùng miền của sản phẩm. Chính vì vậy, thổ cẩm không chỉ là sản phẩm thủ công mà còn là một dạng “ngôn ngữ văn hóa” được thể hiện bằng sợi vải và hoa văn.

Ngày nay, nghề dệt thổ cẩm vừa đứng trước nhiều thách thức do sự thay đổi của đời sống hiện đại, vừa có cơ hội mới trong lĩnh vực bảo tồn di sản, du lịch và sáng tạo thiết kế. Nhiều địa phương và nghệ nhân đã nỗ lực truyền dạy nghề cho lớp trẻ, phục dựng kỹ thuật cổ truyền và đưa thổ cẩm vào các sản phẩm đương đại. Việc gìn giữ nghề dệt thổ cẩm không chỉ giúp bảo tồn một nghề thủ công quý giá mà còn góp phần duy trì bản sắc văn hóa, nâng cao vai trò của phụ nữ trong cộng đồng và tạo sinh kế bền vững gắn với giá trị truyền thống.',
    N'Traditional brocade weaving is one of the most representative handicrafts practiced by many ethnic groups in the Central Highlands, including the Ede, M’Nong, Gia Rai, Ba Na, and others. Beyond producing garments and everyday items, weaving serves as a repository of indigenous knowledge, aesthetic philosophy, and collective memory. From selecting fibers and preparing dyes to setting up the loom and weaving intricate motifs, every stage of the process requires patience, dexterity, and experience handed down through generations. Brocade textiles are not only practical products but also cultural objects with symbolic significance, often associated with ritual life, marriage, festivals, and social identity.

The motifs found in Central Highlands brocade are often inspired by nature, daily labor, human figures, animals, plants, mountain landscapes, and spiritual symbols familiar to each community. Every color combination, line, and pattern arrangement expresses a particular way of seeing the world and reflects the creativity and identity of the people who make it. In many cases, those familiar with the tradition can identify an ethnic group or locality simply by looking at the motifs, color palette, or compositional style of a textile. For this reason, brocade is far more than a handmade fabric. It functions as a cultural language woven into cloth.

Today, brocade weaving faces many challenges as modern lifestyles and industrial products reshape traditional practices. At the same time, it also holds new opportunities in heritage preservation, cultural tourism, and contemporary design. Many communities and artisans are making efforts to pass on weaving skills to younger generations, revive traditional techniques, and integrate brocade into modern products. Preserving this craft means protecting not only a valuable handmade tradition, but also sustaining cultural identity, strengthening the role of women in community life, and creating livelihoods rooted in heritage and creativity.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'TRUNG_BO'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'EDE'),
    N'https://cdn-i2.congthuong.vn/stores/news_dataimages/2023/022023/28/07/220230228075939.jpg?rt=20230228080023',
    N'thổ cẩm,Tây Nguyên,dệt thủ công,nghề truyền thống,dân tộc,bản sắc văn hóa',
    N'brocade,Central Highlands,traditional weaving,handicraft,ethnic culture,cultural identity',
    GETDATE()
),
(
    N'LE_HOI_GAU_TAO_CUA_NGUOI_MONG',
    N'LeHoi',
    N'Lễ hội Gầu Tào của người Mông',
    N'Gau Tao Festival of the Hmong People',
    N'Lễ hội Gầu Tào là lễ hội truyền thống tiêu biểu của người Mông, mang ý nghĩa cầu phúc, cầu sức khỏe, cầu con cái và cầu một năm mới bình an, thuận lợi.',
    N'The Gau Tao Festival is a representative traditional celebration of the Hmong people, held to pray for blessings, health, children, and a peaceful, prosperous new year.',
    N'Lễ hội Gầu Tào là một trong những lễ hội truyền thống quan trọng và đặc sắc nhất của người Mông ở các tỉnh miền núi phía Bắc Việt Nam. Theo phong tục, lễ hội thường được tổ chức vào đầu năm mới tại một khu đất rộng, thoáng đãng, như một dịp để cộng đồng cầu mong phúc lành, sức khỏe, mùa màng tốt tươi, gia đình hạnh phúc và cuộc sống thuận lợi hơn trong năm sắp tới. Trong nhiều trường hợp, lễ hội còn gắn với lời nguyện ước của một gia đình khi mong muốn có con, cầu sức khỏe hoặc vượt qua khó khăn, và khi điều mong cầu thành hiện thực thì họ tổ chức lễ hội để tạ ơn trời đất, thần linh và chia vui cùng cộng đồng.

Không gian lễ hội Gầu Tào thường rất rộn ràng, náo nhiệt và giàu màu sắc văn hóa. Một trong những hình ảnh biểu tượng của lễ hội là cây nêu cao được dựng lên ở trung tâm, thể hiện sự kết nối giữa con người với trời đất và thế giới linh thiêng. Trong lễ hội, người dân mặc trang phục truyền thống đẹp nhất, tham gia các nghi thức cúng lễ, ca hát, múa khèn, thổi sáo, giao lưu trai gái và nhiều trò chơi dân gian như đánh quay, ném pao, kéo co, leo cột hay thi tài khéo léo. Những hoạt động này không chỉ tạo không khí vui tươi đầu xuân mà còn là dịp để cộng đồng gắn kết, thanh niên nam nữ gặp gỡ, thể hiện tài năng và nuôi dưỡng tình cảm.

Giá trị của lễ hội Gầu Tào không chỉ nằm ở khía cạnh tín ngưỡng mà còn ở vai trò bảo tồn văn hóa cộng đồng. Thông qua lễ hội, người Mông truyền lại cho thế hệ trẻ những phong tục, nghi lễ, nghệ thuật trình diễn, tiếng nói, trang phục và quan niệm sống của dân tộc mình. Đây là không gian để bản sắc văn hóa được tái hiện một cách sinh động và đầy tự hào. Trong bối cảnh hiện đại, việc gìn giữ lễ hội Gầu Tào có ý nghĩa rất lớn trong việc bảo tồn di sản văn hóa phi vật thể, duy trì sức sống cộng đồng và khẳng định giá trị riêng của văn hóa người Mông trong bức tranh đa dạng của văn hóa Việt Nam.',
    N'The Gau Tao Festival is one of the most important and distinctive traditional festivals of the Hmong people in the northern mountainous regions of Vietnam. According to custom, it is usually held at the beginning of the new year in a spacious open area, serving as an occasion for the community to pray for blessings, good health, fertile harvests, family happiness, and greater well-being in the year ahead. In many cases, the festival is also linked to a vow made by a particular family, such as a wish for children, health, or relief from hardship. When that wish is fulfilled, the family organizes the festival as an act of thanksgiving to heaven, spirits, and the community.

The festival space is vibrant, festive, and rich in cultural expression. One of its symbolic features is the tall ceremonial pole erected at the center of the gathering area, representing a connection between human life, the heavens, and the sacred world. During the festival, people wear their finest traditional clothing and take part in ritual offerings, singing, flute playing, khèn dancing, courtship exchanges, and various folk games such as top spinning, pao throwing, tug of war, pole climbing, and skill competitions. These activities not only create a joyful atmosphere for the new year, but also strengthen community ties and provide opportunities for young men and women to meet, express themselves, and form new relationships.

The significance of the Gau Tao Festival goes far beyond its spiritual dimension. It also plays an important role in preserving Hmong cultural identity. Through the festival, older generations pass on customs, rituals, performance arts, language, clothing traditions, and social values to the young. It is a living cultural space where ethnic identity is expressed with vitality and pride. In the modern era, preserving the Gau Tao Festival is essential for safeguarding intangible heritage, sustaining communal life, and affirming the distinct place of Hmong culture within the broader diversity of Vietnamese cultural traditions.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'BAC_BO'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'MONG'),
    N'https://ik.imagekit.io/tvlk/dam/i/01kcgv83ndk01st48cjdz45838.jpeg?tr=q-70,c-at_max,w-1000,h-600',
    N'Gầu Tào,người Mông,lễ hội truyền thống,miền núi phía Bắc,văn hóa dân tộc,mùa xuân',
    N'Gau Tao,Hmong,traditional festival,northern highlands,ethnic culture,spring',
    GETDATE()
),
(
    N'NGHI_LE_CAP_SAC_CUA_NGUOI_DAO',
    N'LeNghia',
    N'Nghi lễ cấp sắc của người Dao',
    N'The Cap Sac Initiation Ceremony of the Dao People',
    N'Nghi lễ cấp sắc là nghi lễ truyền thống quan trọng của người Dao, đánh dấu sự trưởng thành về mặt xã hội, tinh thần và trách nhiệm của người đàn ông trong gia đình và cộng đồng.',
    N'The Cap Sac ceremony is an important traditional ritual of the Dao people, marking a man’s maturity in terms of social standing, spiritual recognition, and responsibility within the family and community.',
    N'Nghi lễ cấp sắc là một trong những nghi lễ truyền thống quan trọng bậc nhất trong đời sống văn hóa của người Dao. Đối với nhiều nhóm Dao, đây không chỉ là một nghi thức mang ý nghĩa tôn giáo hay tín ngưỡng, mà còn là dấu mốc khẳng định sự trưởng thành của người đàn ông trong cộng đồng. Sau khi được cấp sắc, người đàn ông mới được xem là đã thực sự đủ tư cách về mặt tinh thần và xã hội để tham gia trọn vẹn vào các công việc hệ trọng của gia đình, dòng họ và bản làng. Nghi lễ này vì thế mang ý nghĩa rất sâu sắc, phản ánh quan niệm sống, hệ giá trị đạo đức và trật tự văn hóa của người Dao.

Trong quá trình thực hành nghi lễ, người được cấp sắc phải trải qua nhiều bước với sự chủ trì của thầy cúng và sự chứng kiến của gia đình, họ hàng, cộng đồng. Tùy theo từng nhóm Dao và phong tục địa phương, nghi lễ có thể kéo dài trong nhiều giờ hoặc nhiều ngày, bao gồm các phần như chuẩn bị lễ vật, hành lễ trước bàn thờ tổ tiên, đọc lời cúng, truyền dạy giáo huấn và thực hiện những nghi thức mang tính biểu tượng. Người được cấp sắc không chỉ nhận sự thừa nhận của thần linh và tổ tiên mà còn được trao gửi những chuẩn mực về đạo đức, cách ứng xử, trách nhiệm với gia đình và nghĩa vụ với cộng đồng. Đây là nghi lễ có tính giáo dục rất cao, giúp cá nhân ý thức rõ hơn về vị trí của mình trong đời sống xã hội.

Nghi lễ cấp sắc còn cho thấy chiều sâu trong đời sống tâm linh và cấu trúc văn hóa của người Dao. Thông qua nghi lễ, thế hệ trẻ được tiếp xúc với ngôn ngữ nghi lễ, lời cúng, trang phục truyền thống, âm nhạc, biểu tượng tín ngưỡng và các tri thức dân gian được lưu truyền từ đời này sang đời khác. Trong bối cảnh hiện đại, khi nhiều tập quán cổ truyền đứng trước nguy cơ mai một, việc bảo tồn nghi lễ cấp sắc có ý nghĩa quan trọng trong việc gìn giữ bản sắc dân tộc và duy trì mạch nối văn hóa giữa các thế hệ. Đây không chỉ là một nghi lễ trưởng thành, mà còn là biểu hiện rõ nét của thế giới quan, nhân sinh quan và bản lĩnh văn hóa của người Dao.',
    N'The Cap Sac initiation ceremony is one of the most important traditional rituals in the cultural life of the Dao people. For many Dao groups, it is not merely a religious observance, but a major rite of passage that confirms a man’s maturity and his recognized status within the community. Only after undergoing Cap Sac is a man considered spiritually and socially qualified to take full part in important family matters, ancestral responsibilities, and communal affairs. The ceremony therefore carries deep meaning, reflecting the Dao people’s ethical values, worldview, and cultural order.

During the ritual process, the initiate passes through multiple ceremonial stages under the guidance of ritual specialists and in the presence of family members, relatives, and the wider community. Depending on the Dao subgroup and local customs, the ceremony may last for many hours or even several days. It often includes the preparation of offerings, worship before the ancestral altar, the chanting of ritual texts, the transmission of moral teachings, and symbolic acts that formally recognize the initiate’s new status. Through this process, the individual is not only acknowledged by ancestors and spiritual forces, but is also entrusted with moral expectations, codes of conduct, duties toward the family, and obligations to the community. In this way, the ceremony serves an important educational function as well as a spiritual one.

The Cap Sac ceremony also reveals the richness of Dao spiritual life and the complexity of their cultural structure. Through participation in the ritual, younger generations are introduced to ritual language, sacred chants, traditional costumes, ceremonial music, religious symbols, and layers of indigenous knowledge handed down over time. In the modern era, when many traditional customs face the risk of decline, preserving Cap Sac has become especially meaningful as a way of safeguarding ethnic identity and maintaining cultural continuity across generations. It is not simply a coming-of-age ritual, but a vivid expression of the Dao people’s worldview, moral philosophy, and cultural resilience.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'BAC_BO'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'DAO'),
    N'https://thinhvuongvietnam.com/Content/UploadFiles/EditorFiles/images/2024/Quy4/le-cap-sac25122024092908.jpg',
    N'cấp sắc,người Dao,nghi lễ trưởng thành,văn hóa dân tộc,tín ngưỡng,bản sắc',
    N'Cap Sac,Dao people,initiation ritual,ethnic culture,belief,identity',
    GETDATE()
),
(
    N'NGHE_THUAT_MUA_XOE_THAI',
    N'NgheThuat',
    N'Nghệ thuật múa xòe Thái',
    N'The Art of Thai Xoe Dance',
    N'Múa xòe Thái là loại hình nghệ thuật dân gian tiêu biểu của người Thái, thể hiện tinh thần cộng đồng, niềm vui lao động và vẻ đẹp gắn kết trong đời sống văn hóa vùng Tây Bắc.',
    N'Thai Xoe dance is a representative folk art of the Thai people, expressing communal spirit, joy in life and labor, and the beauty of social connection in the cultural life of northwestern Vietnam.',
    N'Nghệ thuật múa xòe là một trong những biểu tượng văn hóa đặc sắc nhất của người Thái ở vùng Tây Bắc Việt Nam. Trong đời sống cộng đồng, xòe không chỉ đơn thuần là một điệu múa để biểu diễn mà còn là hình thức sinh hoạt văn hóa mang tính gắn kết cao, phản ánh tâm hồn cởi mở, lối sống chan hòa và tinh thần cộng đồng bền chặt của người Thái. Xòe thường xuất hiện trong những dịp lễ hội, mừng nhà mới, đón khách, mừng mùa, đám cưới và nhiều sinh hoạt tập thể khác. Khi tiếng trống, tiếng chiêng hay nhạc cụ dân tộc vang lên, mọi người nắm tay nhau thành vòng tròn, cùng di chuyển trong nhịp điệu mềm mại, nhịp nhàng, tạo nên một không gian vừa vui tươi vừa đậm tính biểu tượng.

Điểm đặc sắc của múa xòe nằm ở tính cộng đồng và khả năng cuốn hút mọi người cùng tham gia. Xòe không phân biệt già trẻ, trai gái, khách hay chủ; chỉ cần hòa vào vòng xòe là đã trở thành một phần của niềm vui chung. Những động tác múa tưởng chừng đơn giản nhưng lại chứa đựng nhiều ý nghĩa về sự đoàn kết, mến khách, gắn bó với thiên nhiên và ước vọng về cuộc sống ấm no, hạnh phúc. Trong quá trình phát triển, múa xòe đã hình thành nhiều điệu xòe khác nhau, từ những điệu cổ mang tính nền tảng đến các hình thức biểu diễn phong phú hơn, nhưng tinh thần cốt lõi vẫn là sự kết nối con người với con người trong một không gian văn hóa chan chứa tình cảm.

Không chỉ là một loại hình nghệ thuật dân gian, múa xòe còn là nơi hội tụ của âm nhạc, trang phục, nghi lễ và cách ứng xử cộng đồng. Hình ảnh những cô gái Thái trong trang phục truyền thống uyển chuyển trong vòng xòe đã trở thành dấu ấn sâu đậm trong đời sống văn hóa Tây Bắc. Trong bối cảnh hiện đại, việc bảo tồn và truyền dạy múa xòe cho thế hệ trẻ có ý nghĩa quan trọng trong việc giữ gìn bản sắc dân tộc và phát huy giá trị di sản. Múa xòe vì thế không chỉ là điệu múa của niềm vui, mà còn là biểu tượng sống động của tinh thần đoàn kết, lòng hiếu khách và vẻ đẹp văn hóa của người Thái.',
    N'Thai Xoe dance is one of the most distinctive cultural symbols of the Thai people in northwestern Vietnam. In community life, Xoe is far more than a performance dance. It is a form of collective cultural practice that reflects openness, harmony, and the strong communal spirit of the Thai people. Xoe is commonly performed during festivals, housewarming celebrations, harvest festivities, weddings, ceremonies for welcoming guests, and many other community gatherings. When drums, gongs, or traditional instruments begin to sound, people join hands in a circle and move together in graceful, rhythmic patterns, creating an atmosphere that is both joyful and deeply symbolic.

One of the most remarkable features of Xoe dance is its communal inclusiveness. It welcomes everyone, regardless of age, gender, social role, or whether one is a local resident or a guest. Once a person enters the Xoe circle, they become part of a shared celebration. The dance movements may appear simple, but they carry meaningful ideas about unity, hospitality, harmony with nature, and aspirations for prosperity and happiness. Over time, Xoe has developed into many forms, ranging from ancient foundational dances to more elaborate performance styles, yet its core spirit has remained the same: it is a dance of human connection and shared cultural belonging.

Beyond being a folk art, Xoe dance brings together music, costume, ritual, and social interaction into a single cultural space. The image of Thai women in traditional dress moving gracefully in the dance circle has become one of the most memorable symbols of the cultural life of the Northwest. In the modern era, preserving and teaching Xoe to younger generations is essential for safeguarding ethnic identity and sustaining an important living heritage. Xoe is therefore not only a dance of celebration, but also a vivid symbol of solidarity, hospitality, and the enduring beauty of Thai culture.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'BAC_BO'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'THAI'),
    N'https://dulichdienbien.vietnaminfo.net/DataFiles/2022/07/Nodes/20220718-152607-ysFVGrDI.jpg',
    N'múa xòe,người Thái,Tây Bắc,nghệ thuật dân gian,lễ hội,tinh thần cộng đồng',
    N'Xoe dance,Thai people,Northwest Vietnam,folk art,festival,community spirit',
    GETDATE()
),
(
    N'TUC_AN_TRAU_CUA_NGUOI_VIET',
    N'PhongTuc',
    N'Tục ăn trầu của người Việt',
    N'The Betel Chewing Custom of the Vietnamese',
    N'Tục ăn trầu là một phong tục lâu đời của người Việt, gắn với giao tiếp, lễ nghi, hôn nhân và những giá trị văn hóa truyền thống về tình nghĩa, sự kính trọng và kết nối cộng đồng.',
    N'The betel chewing custom is a long-standing Vietnamese tradition associated with social interaction, ritual practice, marriage, and cultural values of affection, respect, and community connection.',
    N'Tục ăn trầu là một trong những phong tục lâu đời và giàu ý nghĩa trong văn hóa truyền thống của người Việt. Miếng trầu từ lâu không chỉ là một thức dùng trong sinh hoạt thường ngày mà còn mang nhiều tầng ý nghĩa biểu tượng trong giao tiếp xã hội, nghi lễ gia đình và đời sống tinh thần. Hình ảnh “miếng trầu là đầu câu chuyện” đã trở thành một cách nói quen thuộc, thể hiện vai trò của trầu cau trong việc mở đầu giao tiếp, gắn kết tình cảm và thể hiện sự hiếu khách. Trong nhiều cộng đồng người Việt xưa, mời nhau miếng trầu là cách bày tỏ sự trân trọng, thân tình và thiện ý trong các mối quan hệ.

Tục ăn trầu còn gắn chặt với các nghi lễ cưới hỏi, giỗ chạp, lễ Tết và nhiều sinh hoạt văn hóa truyền thống khác. Trong hôn nhân, trầu cau mang ý nghĩa đặc biệt sâu sắc, gắn với tích truyện về tình anh em, nghĩa vợ chồng và lòng thủy chung son sắt. Vì vậy, trầu cau thường hiện diện trong lễ dạm ngõ, lễ ăn hỏi, lễ cưới như một sính lễ không thể thiếu, tượng trưng cho sự gắn bó bền chặt và lời chúc phúc cho đôi lứa. Không chỉ trong chuyện hôn nhân, trầu cau còn xuất hiện trên bàn thờ tổ tiên, trong các dịp lễ cúng và trong nhiều nghi thức mang tính trang trọng, cho thấy vị trí bền vững của phong tục này trong đời sống văn hóa Việt Nam.

Ngày nay, tục ăn trầu không còn phổ biến như trước trong sinh hoạt hằng ngày, nhưng giá trị văn hóa của nó vẫn còn được lưu giữ trong ký ức cộng đồng, trong lễ nghi và trong nhiều biểu tượng văn hóa dân gian. Miếng trầu là nơi kết tinh của sự khéo léo, tình cảm, phép lịch sự và tinh thần coi trọng nghĩa tình của người Việt. Việc tìm hiểu và bảo tồn phong tục này không chỉ giúp thế hệ hôm nay hiểu rõ hơn về nếp sống xưa mà còn góp phần giữ gìn những giá trị nhân văn từng làm nên vẻ đẹp của văn hóa truyền thống dân tộc.',
    N'The betel chewing custom is one of the oldest and most meaningful traditions in Vietnamese cultural life. Betel was not simply a substance for daily use; it carried many layers of symbolic meaning in social interaction, family ritual, and spiritual life. The well-known saying that “a betel quid begins the conversation” reflects the important role of betel and areca in opening communication, creating warmth, and expressing hospitality. In traditional Vietnamese society, offering betel was a gesture of respect, friendliness, and goodwill, helping to strengthen bonds between people and communities.

This custom was also deeply associated with weddings, ancestor rituals, the Lunar New Year, commemorative ceremonies, and many other traditional practices. In marriage customs, betel and areca held especially profound significance because of their connection to the famous folk tale about brotherhood, marital fidelity, and enduring affection. For this reason, betel and areca were indispensable in engagement visits, betrothal ceremonies, and weddings, where they symbolized lasting union and conveyed blessings for the couple. Beyond marriage, betel offerings also appeared on ancestral altars, in ritual ceremonies, and in formal occasions, demonstrating the enduring role of this custom in Vietnamese cultural tradition.

Although betel chewing is no longer as common in everyday life as it once was, its cultural value remains preserved in collective memory, ritual practice, and folk symbolism. The betel quid embodies craftsmanship, emotional warmth, courtesy, and the Vietnamese emphasis on meaningful human relationships. Studying and preserving this custom helps contemporary generations better understand traditional ways of life while also safeguarding the humanistic values that contributed to the beauty and depth of Vietnamese culture.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'BAC_BO'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KINH'),
    N'https://www.caidinh.com/images/images2021/traucau_6.jpg',
    N'ăn trầu,trầu cau,phong tục Việt,cưới hỏi,lễ nghi,văn hóa truyền thống',
    N'betel chewing,betel and areca,Vietnamese custom,wedding rituals,tradition,cultural heritage',
    GETDATE()
),
(
    N'CHO_NOI_MIEN_TAY',
    N'DoiSong',
    N'Chợ nổi miền Tây',
    N'Floating Markets of the Mekong Delta',
    N'Chợ nổi miền Tây là nét văn hóa đặc trưng của vùng sông nước Nam Bộ, phản ánh phương thức sinh hoạt, giao thương và lối sống thích ứng với hệ thống kênh rạch của cư dân đồng bằng.',
    N'The floating markets of the Mekong Delta are a distinctive cultural feature of southern river life, reflecting patterns of trade, daily living, and adaptation to a dense network of waterways.',
    N'Chợ nổi miền Tây là một hình ảnh văn hóa đặc trưng và giàu sức gợi của vùng đồng bằng sông Cửu Long. Hình thành trong điều kiện sông ngòi, kênh rạch chằng chịt, chợ nổi không chỉ là nơi mua bán hàng hóa mà còn là không gian sinh hoạt phản ánh rõ nét đời sống của cư dân miền sông nước. Từ sáng sớm, hàng chục, hàng trăm ghe thuyền tụ họp trên sông, mang theo đủ loại nông sản, trái cây, thực phẩm và hàng hóa thiết yếu. Hoạt động trao đổi diễn ra ngay trên mặt nước, tạo nên một khung cảnh vừa nhộn nhịp vừa gần gũi, thể hiện sự năng động và khả năng thích ứng linh hoạt của con người Nam Bộ với môi trường tự nhiên.

Một trong những điểm đặc sắc của chợ nổi là cách thức giới thiệu hàng hóa bằng “cây bẹo”, tức là treo sản phẩm lên một cây sào cao trên ghe để người mua dễ nhận biết từ xa. Hình thức buôn bán này vừa thực tế vừa độc đáo, thể hiện sự sáng tạo của cư dân trong điều kiện giao thương trên sông. Bên cạnh vai trò là nơi trao đổi hàng hóa, chợ nổi còn là nơi gặp gỡ, giao tiếp, chia sẻ thông tin và duy trì các mối quan hệ xã hội. Tiếng gọi mời, tiếng máy ghe, tiếng cười nói hòa cùng nhịp sống sông nước đã tạo nên một không gian văn hóa rất riêng, không thể trộn lẫn với những loại hình chợ trên đất liền.

Trong bối cảnh hiện đại, khi hệ thống giao thông đường bộ phát triển mạnh và phương thức buôn bán thay đổi, nhiều chợ nổi truyền thống đã thu hẹp quy mô hoặc không còn nhộn nhịp như trước. Tuy nhiên, chợ nổi vẫn là biểu tượng quan trọng của văn hóa miền Tây, gắn với ký ức cộng đồng, bản sắc vùng miền và hình ảnh đời sống sông nước Nam Bộ. Việc bảo tồn và phát huy giá trị chợ nổi không chỉ phục vụ phát triển du lịch mà còn góp phần gìn giữ một hình thức văn hóa sinh hoạt độc đáo, phản ánh mối quan hệ mật thiết giữa con người với môi trường sông nước của đồng bằng sông Cửu Long.',
    N'The floating markets of the Mekong Delta are among the most evocative and recognizable cultural images of southern Vietnam. Formed in a landscape defined by dense rivers, canals, and waterways, these markets are not only places of trade but also living spaces that vividly reflect the daily life of river-based communities. From early morning, dozens or even hundreds of boats gather on the water carrying fruits, vegetables, agricultural products, food, and essential goods. Buying and selling take place directly on the river, creating a scene that is both lively and intimate, revealing the dynamism and remarkable adaptability of southern people to their natural environment.

One of the most distinctive features of floating markets is the use of the “cây bẹo,” a tall pole on which vendors hang samples of the goods they are selling so that buyers can identify them from a distance. This method of displaying products is both practical and highly original, demonstrating the ingenuity of river communities in organizing commerce on water. Beyond its commercial role, the floating market is also a place of social interaction, information exchange, and the maintenance of community relationships. The calls of traders, the sounds of engines, and the conversations drifting across the river all combine to create a cultural atmosphere unlike that of any land-based market.

In modern times, as road transport has expanded and trade patterns have changed, many traditional floating markets have become smaller or less active than in the past. Even so, they remain powerful symbols of the Mekong Delta’s cultural identity, deeply connected to regional memory and the image of southern river life. Preserving and promoting the value of floating markets is important not only for tourism but also for safeguarding a unique cultural practice that reflects the close relationship between human life and the waterways of the delta.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'NAM_BO'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KINH'),
    N'https://pystravel.vn/_next/image?url=https%3A%2F%2Fobjectstorage.omzcloud.vn%2Fpys-object-storage%2Fweb%2Fuploads%2Fposts%2Favatar%2F1565846242.jpg&w=3840&q=75',
    N'chợ nổi,miền Tây,sông nước,Nam Bộ,giao thương,văn hóa vùng miền',
    N'floating market,Mekong Delta,river culture,South Vietnam,trade,regional identity',
    GETDATE()
),
(
    N'TET_CHOL_CHNAM_THMAY_CUA_NGUOI_KHMER',
    N'LeHoi',
    N'Tết Chôl Chnăm Thmây của người Khmer',
    N'Chol Chnam Thmay New Year Festival of the Khmer People',
    N'Tết Chôl Chnăm Thmây là lễ mừng năm mới truyền thống của người Khmer, thể hiện niềm vui đoàn tụ, lòng hướng thiện và những ước vọng về một năm mới bình an, hạnh phúc.',
    N'Chol Chnam Thmay is the traditional New Year festival of the Khmer people, expressing joy in reunion, moral aspiration, and hopes for a peaceful and prosperous new year.',
    N'Tết Chôl Chnăm Thmây là lễ mừng năm mới truyền thống quan trọng nhất trong đời sống văn hóa của cộng đồng Khmer Nam Bộ. Đây là dịp đánh dấu thời khắc chuyển giao năm cũ sang năm mới theo lịch cổ truyền của người Khmer, đồng thời là khoảng thời gian để mọi người tạm gác công việc thường ngày, sum họp gia đình, hướng về chùa chiền và thực hiện những nghi lễ cầu mong điều tốt lành. Không khí năm mới diễn ra trang trọng nhưng cũng rất vui tươi, thể hiện niềm tin vào sự khởi đầu mới, sự thanh sạch trong tâm hồn và khát vọng về một năm an lành, no đủ.

Trong những ngày Tết, người Khmer thường dọn dẹp nhà cửa, chuẩn bị lễ vật, mặc trang phục đẹp và đến chùa để làm lễ. Các nghi thức trong dịp này mang nhiều ý nghĩa nhân văn như dâng cơm cho các vị sư, tắm Phật, đắp núi cát, cầu phúc cho ông bà cha mẹ và tưởng nhớ tổ tiên. Đây cũng là dịp để con cháu thể hiện lòng hiếu kính đối với người lớn tuổi, cùng nhau vun đắp tình cảm gia đình và cộng đồng. Bên cạnh phần nghi lễ, Tết Chôl Chnăm Thmây còn có nhiều hoạt động văn hóa vui chơi, ca múa, trò chơi dân gian và các hình thức sinh hoạt tập thể, tạo nên một bầu không khí đậm đà bản sắc.

Giá trị của Tết Chôl Chnăm Thmây không chỉ nằm ở ý nghĩa đón năm mới mà còn ở khả năng kết nối cộng đồng và gìn giữ truyền thống văn hóa dân tộc. Thông qua dịp lễ này, các thế hệ trẻ được tiếp xúc trực tiếp với ngôn ngữ, trang phục, ẩm thực, âm nhạc, nghi lễ và đạo lý sống của người Khmer. Trong bối cảnh hiện đại, lễ Tết này vẫn giữ vai trò rất quan trọng như một trụ cột của đời sống tinh thần và bản sắc cộng đồng. Tết Chôl Chnăm Thmây vì thế không chỉ là một lễ hội theo lịch thời gian, mà còn là không gian văn hóa nơi niềm tin, tình thân và truyền thống được tái hiện và tiếp nối qua từng thế hệ.',
    N'Chol Chnam Thmay is the most important traditional New Year celebration in the cultural life of the Khmer community in southern Vietnam. It marks the transition from the old year to the new one according to the traditional Khmer calendar and serves as a period when people set aside their ordinary routines to reunite with family, visit pagodas, and perform rituals for blessings and renewal. The atmosphere of the festival is both solemn and joyful, reflecting a belief in fresh beginnings, inner purification, and hopes for a peaceful and prosperous year ahead.

During the festival days, Khmer families clean and decorate their homes, prepare offerings, wear their finest clothes, and go to the temple to participate in ceremonies. The rituals carried out during this time are rich in moral and spiritual meaning, including offering food to monks, bathing Buddha statues, building symbolic sand mounds, praying for parents and elders, and remembering ancestors. It is also an occasion for younger generations to show respect to their elders and for families and neighbors to strengthen their bonds. In addition to the religious elements, Chol Chnam Thmay includes singing, dancing, folk games, and community activities that create a lively and culturally distinctive festive environment.

The value of Chol Chnam Thmay lies not only in welcoming a new year but also in its power to unite the community and preserve ethnic traditions. Through this celebration, younger generations gain direct exposure to Khmer language, clothing, cuisine, music, ritual practice, and moral values. In modern society, the festival continues to play a vital role as a pillar of communal identity and spiritual life. Chol Chnam Thmay is therefore more than a calendar-based celebration; it is a cultural space where faith, kinship, and tradition are renewed and passed on from one generation to the next.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'NAM_BO'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KHMER'),
    N'https://nhandan.vn/special/Chaul-Chnam-Thmay/assets/Hdb3EZsvx9/kho-me-1-1585842188628566903511-640x425.jpeg',
    N'Chôl Chnăm Thmây,người Khmer,tết cổ truyền,Nam Bộ,lễ hội,dân tộc',
    N'Chol Chnam Thmay,Khmer people,traditional new year,Southern Vietnam,festival,ethnic culture',
    GETDATE()
),
(
    N'LE_HOI_LONG_TONG_CUA_NGUOI_TAY',
    N'LeHoi',
    N'Lễ hội Lồng Tồng của người Tày',
    N'Long Tong Festival of the Tay People',
    N'Lễ hội Lồng Tồng là lễ xuống đồng truyền thống của người Tày, thể hiện ước vọng về mùa màng bội thu, cuộc sống no đủ và sự hài hòa giữa con người với thiên nhiên.',
    N'The Long Tong Festival is a traditional field-opening festival of the Tay people, expressing hopes for abundant harvests, prosperity, and harmony between human beings and nature.',
    N'Lễ hội Lồng Tồng, còn gọi là lễ xuống đồng, là một trong những lễ hội nông nghiệp tiêu biểu và có ý nghĩa sâu sắc trong đời sống văn hóa của người Tày ở vùng trung du và miền núi phía Bắc. Lễ hội thường được tổ chức vào đầu xuân, khi cộng đồng bắt đầu một chu kỳ sản xuất nông nghiệp mới. Đây là dịp để người dân bày tỏ lòng biết ơn đối với trời đất, thần linh, tổ tiên đã phù hộ cho bản làng, đồng thời cầu mong mưa thuận gió hòa, mùa màng tốt tươi, cuộc sống ấm no và gia đình mạnh khỏe. Trong tư duy nông nghiệp truyền thống, việc xuống đồng đầu năm không chỉ mang ý nghĩa mở đầu cho một vụ mùa mới mà còn thể hiện mối quan hệ gắn bó giữa con người với tự nhiên, với đất đai và với quy luật sinh trưởng của cuộc sống.

Phần nghi lễ của Lồng Tồng thường được chuẩn bị rất chu đáo và trang trọng. Người dân đem theo nhiều lễ vật như xôi, gà, rượu, bánh, hương, hoa và các sản vật địa phương để dâng cúng. Những lời khấn cầu mùa, cầu phúc được thực hiện với lòng thành, gửi gắm niềm hy vọng về một năm sản xuất thuận lợi. Một trong những nghi thức giàu ý nghĩa biểu tượng nhất là nghi thức cày những đường cày đầu tiên hoặc gieo những hạt giống đầu tiên trên ruộng. Hành động này vừa mang tính nghi lễ, vừa thể hiện niềm tin vào sự khởi đầu tốt đẹp, sự sinh sôi nảy nở và sự bền vững của đời sống cư dân nông nghiệp.

Bên cạnh phần lễ, phần hội diễn ra sôi nổi với nhiều hoạt động văn hóa cộng đồng như hát lượn, hát then, ném còn, kéo co, múa hát dân gian và các trò chơi truyền thống. Chính sự kết hợp hài hòa giữa tín ngưỡng, lao động nông nghiệp và sinh hoạt cộng đồng đã tạo nên giá trị đặc sắc của lễ hội Lồng Tồng. Đây không chỉ là ngày hội mở đầu mùa vụ mà còn là không gian văn hóa để cộng đồng gắn kết, để thế hệ trẻ hiểu thêm về phong tục tập quán của dân tộc mình và để những giá trị truyền thống tiếp tục được gìn giữ trong đời sống hiện đại.',
    N'The Long Tong Festival, also known as the field-opening festival, is one of the most representative and meaningful agricultural festivals in the cultural life of the Tay people in the northern midland and mountainous regions of Vietnam. It is usually held in early spring, when the community begins a new agricultural cycle. On this occasion, people express gratitude to heaven, earth, deities, and ancestors for protecting the village, while praying for favorable weather, healthy crops, family well-being, and prosperity in the year ahead. In traditional agricultural thinking, going to the field at the beginning of the year is not merely the start of a farming season. It also symbolizes the close relationship between human beings, nature, the land, and the life-giving rhythms of the natural world.

The ritual part of the festival is prepared with great care and solemnity. Villagers bring offerings such as sticky rice, chicken, rice wine, cakes, incense, flowers, and local produce for ceremonial worship. Prayers for harvest, blessings, and communal peace are spoken with sincerity and hope. One of the most symbolic ritual moments is the plowing of the first furrows or the sowing of the first seeds in the field. This act is both ceremonial and meaningful, representing a wish for good beginnings, fertility, growth, and long-term abundance in agricultural life.

Alongside the ritual elements, the festive part of Long Tong includes a variety of community activities such as lượn singing, then singing, con throwing, tug of war, folk dances, and traditional games. The special value of the festival lies in its harmonious combination of belief, farming life, and communal celebration. It is not only the opening festival of a new cultivation season, but also a cultural space where solidarity is strengthened, younger generations learn about the customs of their people, and traditional values continue to live on in the modern world.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'BAC_BO'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'TAY'),
    N'https://maichauhideaway.com/Data/Sites/1/News/334/le-hoi-long-tong-1.jpg',
    N'Lồng Tồng,lễ xuống đồng,người Tày,lễ hội nông nghiệp,cầu mùa,văn hóa dân tộc',
    N'Long Tong,field-opening festival,Tay people,agricultural festival,harvest prayer,ethnic culture',
    GETDATE()
),
(
    N'NGHE_THUAT_KHEN_CUA_NGUOI_MONG',
    N'NgheThuat',
    N'Nghệ thuật khèn của người Mông',
    N'The Art of Khen Performance of the Hmong People',
    N'Nghệ thuật khèn là một biểu hiện văn hóa đặc sắc của người Mông, kết hợp âm nhạc, trình diễn và đời sống tinh thần, phản ánh tâm hồn mạnh mẽ và giàu cảm xúc của cộng đồng.',
    N'The art of khen performance is a distinctive cultural expression of the Hmong people, combining music, movement, and spiritual life while reflecting the community’s emotional depth and inner strength.',
    N'Khèn là một trong những biểu tượng văn hóa tiêu biểu và giàu sức gợi nhất trong đời sống tinh thần của người Mông. Không chỉ là một nhạc cụ dân tộc, khèn còn là phương tiện để con người bày tỏ cảm xúc, truyền tải tâm tư và kết nối với cộng đồng. Âm thanh của khèn có thể xuất hiện trong nhiều hoàn cảnh khác nhau như lễ hội mùa xuân, những buổi gặp gỡ giao duyên, sinh hoạt cộng đồng hay các nghi lễ mang tính thiêng liêng. Vì vậy, khèn không đơn thuần là công cụ tạo ra âm nhạc mà còn là tiếng nói của tâm hồn, là một phần quan trọng trong bản sắc văn hóa của người Mông.

Điểm đặc sắc của nghệ thuật khèn nằm ở sự kết hợp chặt chẽ giữa âm nhạc và trình diễn cơ thể. Người thổi khèn thường đồng thời thực hiện những động tác múa như xoay người, nghiêng mình, bước nhịp nhàng, bật nhảy hoặc di chuyển linh hoạt theo tiếng nhạc. Chính sự phối hợp giữa hơi thở, kỹ thuật điều khiển nhạc cụ và động tác hình thể đã tạo nên một loại hình biểu đạt độc đáo, mạnh mẽ mà vẫn giàu cảm xúc. Mỗi điệu khèn có thể mang những sắc thái rất khác nhau: có khi vui tươi, rộn ràng trong ngày hội; có khi tha thiết, sâu lắng trong giao duyên; có khi trầm buồn, da diết trong những khoảnh khắc chia ly hay tưởng niệm. Vì thế, người nghe không chỉ thưởng thức giai điệu mà còn cảm nhận được chiều sâu tâm trạng và tinh thần của người biểu diễn.

Trong đời sống truyền thống, học thổi khèn còn là quá trình học làm người, học giữ gìn phong tục và học cách thể hiện niềm tự hào dân tộc. Qua từng làn điệu, người trẻ tiếp nhận không chỉ kỹ thuật âm nhạc mà còn cả lối sống, ký ức cộng đồng và sự gắn bó với cội nguồn. Ngày nay, nghệ thuật khèn vẫn hiện diện trong các lễ hội văn hóa, hoạt động du lịch cộng đồng, chương trình bảo tồn di sản và đời sống sinh hoạt của người Mông ở nhiều địa phương. Việc bảo tồn nghệ thuật khèn không chỉ nhằm lưu giữ một nhạc cụ truyền thống mà còn là cách bảo vệ một hình thức biểu đạt văn hóa độc đáo, nơi âm nhạc, cảm xúc và bản sắc dân tộc hòa quyện làm một.',
    N'The khen is one of the most powerful and recognizable cultural symbols in the spiritual life of the Hmong people. More than a traditional musical instrument, it serves as a means for expressing emotion, conveying inner thoughts, and connecting individuals with their community. The sound of the khen can be heard in many different settings, including spring festivals, courtship gatherings, communal events, and sacred rituals. For this reason, the khen is not simply a tool for making music. It is a voice of the soul and an essential part of Hmong cultural identity.

What makes the art of khen performance especially distinctive is the close relationship between music and bodily movement. A khen player often performs dance-like motions while playing, including turning, bending, stepping rhythmically, jumping, and moving fluidly in time with the melody. This combination of breath control, instrumental skill, and physical expression creates a unique art form that is both powerful and deeply emotional. Different khen melodies can convey different moods: some are joyful and energetic during festivals, some are tender and expressive in courtship, while others are solemn and moving in moments of parting or remembrance. As a result, listeners experience not only the music itself but also the emotional and spiritual world of the performer.

In traditional life, learning to play the khen is also a way of learning cultural values, preserving customs, and nurturing ethnic pride. Through each melody, younger generations inherit not only musical techniques but also community memory, cultural behavior, and a sense of connection to their roots. Today, khen performance continues to appear in cultural festivals, community-based tourism, heritage preservation programs, and the everyday cultural life of Hmong communities in many regions. Preserving the art of the khen means more than protecting a traditional instrument. It means safeguarding a unique cultural language in which music, emotion, and ethnic identity are inseparably woven together.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'BAC_BO'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'MONG'),
    N'https://images.baodantoc.vn/uploads/2020/Th%C3%A1ng%207/Ng%C3%A0y_23/nhac-cu-truyen-thong-cua-nguoi-mong-1-min(1).jpg',
    N'khèn,người Mông,nhạc cụ dân tộc,nghệ thuật trình diễn,văn hóa vùng cao,lễ hội',
    N'khen,Hmong people,traditional instrument,performance art,highland culture,festival',
    GETDATE()
),
(
    N'LE_HOI_KATE_CUA_NGUOI_CHAM',
    N'LeHoi',
    N'Lễ hội Katê của người Chăm',
    N'Kate Festival of the Cham People',
    N'Lễ hội Katê là một trong những lễ hội quan trọng nhất của người Chăm theo đạo Bà La Môn, thể hiện lòng tôn kính tổ tiên, thần linh và niềm tự hào về truyền thống văn hóa dân tộc.',
    N'The Kate Festival is one of the most important celebrations of the Cham people who follow Brahmanism, expressing reverence toward ancestors, deities, and pride in ethnic cultural heritage.',
    N'Lễ hội Katê là một trong những lễ hội truyền thống tiêu biểu và thiêng liêng nhất của cộng đồng người Chăm theo đạo Bà La Môn, đặc biệt ở khu vực Ninh Thuận và Bình Thuận. Lễ hội thường được tổ chức hằng năm tại các đền tháp Chăm và trong từng gia đình, nhằm tưởng nhớ các vị thần, các vị vua có công, tổ tiên và cầu mong cho cộng đồng được bình an, mùa màng thuận lợi, cuộc sống ấm no. Đây là dịp vô cùng quan trọng trong năm, khi người Chăm cùng nhau hướng về cội nguồn, khẳng định bản sắc văn hóa và làm mới lại mối liên kết giữa đời sống tâm linh với đời sống cộng đồng.

Phần nghi lễ của Katê diễn ra trang trọng với nhiều nghi thức đặc trưng như rước y phục thần, mở cửa tháp, tắm tượng thần, dâng lễ vật, đọc kinh lễ và thực hiện các nghi thức truyền thống tại đền tháp. Không khí lễ hội vừa linh thiêng vừa rộn ràng, bởi bên cạnh phần nghi lễ là những hoạt động văn hóa nghệ thuật phong phú như múa Chăm, hát dân ca, biểu diễn trống ginăng, kèn saranai và các tiết mục mang đậm bản sắc địa phương. Trang phục truyền thống rực rỡ, âm nhạc dồn dập và sự tham gia đông đảo của cộng đồng đã tạo nên một không gian lễ hội giàu màu sắc, thể hiện chiều sâu văn hóa lâu đời của người Chăm.

Giá trị của lễ hội Katê không chỉ nằm ở yếu tố tín ngưỡng mà còn ở vai trò bảo tồn ký ức lịch sử, nghệ thuật dân gian, ngôn ngữ, phong tục và tinh thần cộng đồng. Thông qua lễ hội, thế hệ trẻ có cơ hội hiểu hơn về truyền thống dân tộc mình, về những biểu tượng văn hóa gắn với đền tháp, nghi lễ, trang phục và âm nhạc. Trong bối cảnh hiện đại, lễ hội Katê vẫn giữ vai trò đặc biệt trong việc duy trì bản sắc văn hóa Chăm và làm phong phú thêm bức tranh đa dạng của văn hóa Việt Nam. Đây không chỉ là một dịp hội hè mà còn là không gian thiêng liêng, nơi quá khứ, niềm tin và bản sắc được tái hiện một cách sống động.',
    N'The Kate Festival is one of the most representative and sacred traditional celebrations of the Cham community who follow Brahmanism, especially in Ninh Thuan and Binh Thuan provinces. It is held annually at Cham temple towers and within family settings to honor deities, revered kings, ancestors, and to pray for peace, favorable harvests, and prosperity for the community. This is one of the most important occasions of the year, when Cham people collectively turn toward their roots, affirm their cultural identity, and renew the connection between spiritual life and communal existence.

The ritual part of Kate is conducted with great solemnity through distinctive ceremonies such as carrying sacred garments, opening the temple tower, bathing the deity statue, presenting offerings, reciting ritual prayers, and performing traditional observances at the sacred site. The festival atmosphere is both sacred and vibrant, because alongside the ritual elements there are rich artistic and cultural activities such as Cham dances, folk songs, performances with ginang drums, saranai oboes, and many other forms of local expression. Colorful traditional costumes, energetic music, and broad community participation create a festive environment full of visual and spiritual richness, reflecting the long historical depth of Cham culture.

The value of the Kate Festival lies not only in its religious meaning but also in its role in preserving historical memory, folk arts, language, customs, and communal solidarity. Through this celebration, younger generations gain a deeper understanding of their heritage, including the symbolic importance of temple towers, rituals, costumes, and music. In the modern era, Kate continues to play a vital role in maintaining Cham cultural identity and enriching the diversity of Vietnamese culture as a whole. It is not merely a festive occasion, but a sacred cultural space where history, faith, and identity are brought vividly to life.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'TRUNG_BO'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'CHAM'),
    N'https://cdn-media.sforum.vn/storage/app/media/wp-content/uploads/2023/12/le-hoi-kate-thumbnail.jpg',
    N'Katê,người Chăm,lễ hội Chăm,đền tháp,tín ngưỡng,văn hóa dân tộc',
    N'Kate,Cham people,Cham festival,temple towers,belief,ethnic culture',
    GETDATE()
),
(
    N'NGHE_THUAT_BAI_CHOI_TRUNG_BO',
    N'NgheThuat',
    N'Nghệ thuật Bài Chòi Trung Bộ',
    N'The Art of Bai Choi in Central Vietnam',
    N'Nghệ thuật Bài Chòi là loại hình sinh hoạt văn hóa dân gian đặc sắc của miền Trung, kết hợp trò chơi, âm nhạc, diễn xướng và giao tiếp cộng đồng trong một không gian nghệ thuật vui tươi, gần gũi.',
    N'Bai Choi is a distinctive folk cultural practice of Central Vietnam, combining game play, music, performance, and community interaction in a lively and intimate artistic space.',
    N'Nghệ thuật Bài Chòi là một hình thức sinh hoạt văn hóa dân gian độc đáo phổ biến ở nhiều tỉnh miền Trung Việt Nam. Đây là loại hình kết hợp giữa trò chơi dân gian, ca hát, diễn xướng và giao tiếp cộng đồng, tạo nên một không gian văn hóa vừa giải trí vừa giàu giá trị nghệ thuật. Trong Bài Chòi, người chơi ngồi trong những chòi nhỏ, tham gia một hình thức chơi bài đặc biệt, còn anh hiệu hoặc chị hiệu sẽ hô thai bằng những câu hát, câu nói có vần điệu, ẩn dụ và giàu tính dí dỏm để thông báo lá bài. Chính sự kết hợp giữa trò chơi và ngôn ngữ nghệ thuật đã tạo cho Bài Chòi sức hấp dẫn riêng, khiến người tham gia không chỉ chờ đợi kết quả thắng thua mà còn thưởng thức cái hay của lời ca, tài ứng đối và không khí hội hè.

Điểm độc đáo của Bài Chòi nằm ở vai trò trung tâm của người hô bài. Họ không chỉ gọi tên quân bài mà còn sáng tạo những câu hát ngẫu hứng, lồng ghép tiếng cười, kinh nghiệm sống, lời khuyên đạo lý hay những nhận xét hóm hỉnh về con người và cuộc sống. Vì thế, Bài Chòi không đơn thuần là một trò chơi mà còn là một hình thức diễn xướng dân gian rất giàu tính trí tuệ và gắn bó mật thiết với đời sống cộng đồng. Trong những dịp Tết đến xuân về, hội làng hay các sự kiện văn hóa, tiếng hô bài, tiếng trống phách và tiếng cười nói của người xem đã tạo nên một bầu không khí vui tươi, đậm đà bản sắc miền Trung.

Ngoài giá trị giải trí, Bài Chòi còn là nơi lưu giữ ngôn ngữ dân gian, lối nói ví von, khiếu hài hước và tinh thần gắn kết cộng đồng của người dân miền Trung. Qua những câu hát hô thai, người nghe có thể cảm nhận được tính cách cởi mở, thông minh, dí dỏm nhưng cũng rất sâu sắc của cư dân nơi đây. Trong xã hội hiện đại, việc bảo tồn nghệ thuật Bài Chòi có ý nghĩa rất lớn trong việc gìn giữ một loại hình di sản vừa mang tính nghệ thuật vừa mang tính cộng đồng. Đây là minh chứng sinh động cho sức sáng tạo dân gian và cho khả năng biến những sinh hoạt đời thường thành một không gian văn hóa giàu giá trị tinh thần.',
    N'Bai Choi is a unique form of folk cultural life widely practiced in many provinces of Central Vietnam. It combines a traditional card game, singing, performance, and communal interaction into a cultural space that is both entertaining and artistically rich. In Bai Choi, participants sit in small huts and take part in a special form of card playing, while the caller, known as the announcer, sings or chants poetic and witty lines to indicate the cards being drawn. This creative blending of game play and artistic language gives Bai Choi its special appeal, allowing participants to enjoy not only the suspense of the game but also the beauty of verbal expression, improvisation, and festive atmosphere.

One of the most remarkable aspects of Bai Choi is the central role of the caller. Rather than simply naming the cards, the caller creates spontaneous verses filled with humor, metaphor, folk wisdom, moral reflection, and lively commentary on everyday life. For this reason, Bai Choi is far more than a game. It is an intellectually rich form of folk performance closely tied to the social life of the community. During Lunar New Year celebrations, village festivals, and cultural gatherings, the sound of the verses, drums, clappers, and laughter creates a joyful environment that reflects the distinctive cultural spirit of Central Vietnam.

Beyond entertainment, Bai Choi also preserves folk language, figurative expression, humor, and the strong sense of social connection found among central Vietnamese communities. Through its sung verses, listeners can sense the openness, cleverness, warmth, and depth of local people. In modern society, preserving Bai Choi is highly meaningful because it safeguards a heritage form that is both artistic and communal in nature. It stands as a vivid example of folk creativity and of the ability of ordinary daily practices to become a rich cultural art form filled with spiritual and social value.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'TRUNG_BO'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KINH'),
    N'https://file3.qdnd.vn/data/images/0/2018/05/07/thuha/070518ha103.jpg',
    N'Bài Chòi,miền Trung,trò chơi dân gian,diễn xướng dân gian,ca hát,văn hóa cộng đồng',
    N'Bai Choi,Central Vietnam,folk game,folk performance,singing,community culture',
    GETDATE()
),
(
    N'NGHE_LAM_GOM_TRUYEN_THONG_CUA_NGUOI_CHAM',
    N'NgheThuCong',
    N'Nghề làm gốm truyền thống của người Chăm',
    N'Traditional Pottery Craft of the Cham People',
    N'Nghề làm gốm truyền thống của người Chăm là một nghề thủ công lâu đời, phản ánh sự khéo léo, tri thức bản địa và đời sống văn hóa gắn với đất, lửa và cộng đồng.',
    N'The traditional pottery craft of the Cham people is a long-standing handicraft that reflects skill, indigenous knowledge, and a cultural life closely connected to earth, fire, and community.',
    N'Nghề làm gốm truyền thống của người Chăm là một trong những nghề thủ công cổ truyền tiêu biểu, gắn bó chặt chẽ với đời sống sinh hoạt và văn hóa của cộng đồng. Từ lâu, người Chăm đã biết tận dụng đất sét địa phương, kết hợp với kinh nghiệm được tích lũy qua nhiều thế hệ để tạo ra những sản phẩm phục vụ đời sống hằng ngày như nồi, chum, vại, bình, bát và nhiều vật dụng khác. Không chỉ đơn thuần là sản phẩm sử dụng, gốm còn mang trong mình dấu ấn về quan niệm thẩm mỹ, tri thức nghề và mối liên hệ bền chặt giữa con người với tự nhiên. Chính từ đất, nước, lửa và bàn tay con người mà những vật dụng tưởng như giản dị đã trở thành biểu hiện sinh động của một truyền thống văn hóa lâu đời.

Điểm đặc sắc của nghề gốm Chăm nằm ở kỹ thuật chế tác thủ công rất riêng. Nhiều công đoạn được thực hiện hoàn toàn bằng tay, không phụ thuộc quá nhiều vào bàn xoay như ở một số dòng gốm khác. Người thợ dùng đôi tay khéo léo để tạo hình, làm nhẵn, trang trí hoa văn rồi đem phơi khô trước khi nung. Quá trình nung gốm cũng mang những nét đặc thù, cho thấy sự hiểu biết tinh tế về chất liệu, nhiệt độ và kinh nghiệm nghề truyền thống. Mỗi sản phẩm ra đời đều có sự khác biệt nhất định, không hoàn toàn giống nhau, và chính điều đó tạo nên vẻ đẹp mộc mạc, chân thật nhưng giàu tính nghệ thuật của gốm Chăm.

Không chỉ là nghề thủ công, làm gốm còn là không gian truyền dạy văn hóa trong cộng đồng, đặc biệt gắn với vai trò của phụ nữ trong việc duy trì kỹ năng và nếp nghề. Qua từng công đoạn, thế hệ sau học được không chỉ cách làm ra một sản phẩm mà còn hiểu thêm về lối sống, sự kiên nhẫn, tinh thần sáng tạo và sự tôn trọng đối với nghề tổ. Trong bối cảnh hiện đại, nghề làm gốm truyền thống của người Chăm vừa đứng trước thách thức của thị trường và sản xuất công nghiệp, vừa có cơ hội được bảo tồn và phát huy thông qua du lịch, làng nghề và hoạt động quảng bá di sản. Việc gìn giữ nghề gốm không chỉ nhằm bảo tồn một nghề cổ truyền mà còn là cách giữ lại một phần linh hồn của văn hóa Chăm.',
    N'The traditional pottery craft of the Cham people is one of the most representative long-standing handicrafts closely associated with everyday life and cultural identity in the community. For generations, Cham artisans have made use of local clay and accumulated knowledge passed down over time to create household items such as pots, jars, vases, bowls, and many other utensils. These products are not only practical objects. They also carry aesthetic values, artisanal knowledge, and a deep relationship between human beings and the natural elements of earth, water, and fire. Through the hands of skilled craftspeople, simple materials are transformed into vivid expressions of an enduring cultural tradition.

One of the most distinctive characteristics of Cham pottery lies in its unique handmade techniques. Many stages of production are done entirely by hand, without relying heavily on a potter’s wheel as in some other ceramic traditions. Artisans carefully shape the clay, smooth the surfaces, add decorative motifs, allow the pieces to dry, and then fire them using traditional methods. The firing process itself reflects subtle knowledge of materials, heat, and inherited craft experience. Because each piece is individually formed, no two products are exactly alike, and this gives Cham pottery its rustic, honest, and artistically rich character.

Pottery making is not only a craft but also a space for cultural transmission within the community, especially through the important role of women in maintaining techniques and passing on professional knowledge. Through each stage of the process, younger generations learn not only how to make an object but also how to value patience, creativity, craftsmanship, and respect for ancestral occupations. In the modern era, traditional Cham pottery faces challenges from industrial production and changing markets, yet it also has opportunities for preservation through craft villages, tourism, and heritage promotion. Safeguarding this pottery tradition means more than protecting an old craft. It means preserving an essential part of the spirit and cultural memory of the Cham people.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'TRUNG_BO'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'CHAM'),
    N'https://images2.thanhnien.vn/zoom/1200_630/Uploaded/quangpho/2022_11_29/gomcham1-5697.jpg',
    N'gốm Chăm,nghề thủ công,làng nghề,đất nung,văn hóa Chăm,nghề truyền thống',
    N'Cham pottery,traditional craft,craft village,earthenware,Cham culture,handicraft heritage',
    GETDATE()
);

-----------------------------------
INSERT INTO dbo.BaiViet
(
    MaBaiViet,
    TieuDeVI,
    TieuDeEN,
    MoTaNganVI,
    MoTaNganEN,
    NoiDungVI,
    NoiDungEN,
    TacGia,
    NgayXuatBan,
    ImageUrl,
    ChuyenMuc,
    VungID,
    TinhThanhID,
    DanTocID,
    LeHoiID,
    VanHoaID,
    AmThucID
)
VALUES
(
    'BAI_VIET_GIA_TRI_CUA_TIN_NGUONG_THO_CUNG_TO_TIEN',
    N'Giá trị của tín ngưỡng thờ cúng tổ tiên trong đời sống người Việt',
    N'The Value of Ancestor Worship in Vietnamese Life',
    N'Tín ngưỡng thờ cúng tổ tiên là một nền tảng tinh thần bền vững trong văn hóa Việt Nam, góp phần nuôi dưỡng đạo hiếu, gìn giữ nề nếp gia phong và kết nối các thế hệ trong gia đình.',
    N'Ancestor worship is an enduring spiritual foundation in Vietnamese culture, nurturing filial piety, preserving family traditions, and connecting generations within the household.',
    N'Tín ngưỡng thờ cúng tổ tiên từ lâu đã trở thành một phần quan trọng trong đời sống tinh thần của người Việt. Đây không chỉ là một tập tục mang tính tâm linh mà còn là biểu hiện sâu sắc của đạo lý “uống nước nhớ nguồn”, nhắc nhở mỗi người luôn ghi nhớ công lao của ông bà, cha mẹ và những người đi trước. Trong mỗi gia đình, bàn thờ tổ tiên thường được đặt ở vị trí trang trọng nhất, thể hiện lòng thành kính, sự biết ơn và niềm tin vào sự gắn kết bền chặt giữa quá khứ, hiện tại và tương lai.

Vào những dịp quan trọng như ngày giỗ, Tết Nguyên đán, lễ thanh minh hay những sự kiện lớn của gia đình, con cháu thường cùng nhau dâng hương, chuẩn bị lễ vật và tưởng nhớ tổ tiên. Những nghi thức ấy không chỉ mang ý nghĩa tâm linh mà còn là dịp để gia đình sum họp, nhắc lại truyền thống, giáo dục con cháu về nguồn cội và duy trì nền nếp gia phong. Chính trong những khoảnh khắc tưởng niệm đó, tình cảm gia đình được bồi đắp, ký ức dòng họ được lưu giữ và ý thức trách nhiệm của mỗi thành viên đối với gia đình cũng trở nên rõ nét hơn.

Trong bối cảnh hiện đại, dù đời sống có nhiều thay đổi, tín ngưỡng thờ cúng tổ tiên vẫn giữ nguyên giá trị sâu sắc. Điều làm nên sức sống bền vững của tín ngưỡng này không nằm ở hình thức cúng lễ cầu kỳ mà nằm ở tinh thần hiếu kính, lòng biết ơn và sự trân trọng cội nguồn. Đây là một nét đẹp văn hóa giàu tính nhân văn, góp phần làm nên chiều sâu bản sắc Việt Nam và khẳng định vai trò trung tâm của gia đình trong đời sống đạo đức, tinh thần của dân tộc.',
    N'Ancestor worship has long been an important part of the spiritual life of Vietnamese people. It is not merely a religious custom, but a profound expression of gratitude and the moral principle of remembering one’s roots. In many Vietnamese families, the ancestral altar is placed in the most respected area of the home, representing reverence, remembrance, and a lasting connection between past, present, and future generations.

On important occasions such as death anniversaries, Lunar New Year, the Qingming season, and major family milestones, descendants gather to offer incense, prepare food, and honor their ancestors. These rituals carry not only spiritual meaning but also social and educational value. They create opportunities for family reunion, storytelling, and the transmission of family traditions and moral values to younger generations. Through such practices, family bonds are reinforced and a sense of belonging is deepened.

In modern life, although social habits and lifestyles have changed, ancestor worship continues to retain its significance. Its lasting value lies not in elaborate offerings or formal ceremony, but in the spirit of filial respect, gratitude, and remembrance. As a deeply humanistic cultural tradition, ancestor worship contributes to the richness of Vietnamese identity and affirms the central role of family in the moral and spiritual life of the nation.',
    N'Admin',
    GETDATE(),
    N'https://chuaxaloi.vn/upload/hinhanh/tu_quang_18/43_Tin_ngng_th_cung_t_tien__Vit_Nam.jpg',
    N'VAN_HOA',
    NULL,
    NULL,
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KINH'),
    NULL,
    (SELECT VanHoaID FROM dbo.VanHoa WHERE Ma = 'TIN_NGUONG_THO_CUNG_TO_TIEN'),
    NULL
),
(
    'BAI_VIET_KHONG_GIAN_VAN_HOA_CONG_CHIENG_TAY_NGUYEN',
    N'Không gian văn hóa cồng chiêng Tây Nguyên và giá trị cần được gìn giữ',
    N'The Cultural Space of Gong Music in the Central Highlands and the Values Worth Preserving',
    N'Không gian văn hóa cồng chiêng Tây Nguyên là một di sản đặc sắc, phản ánh thế giới tinh thần, nghi lễ cộng đồng và bản sắc văn hóa lâu đời của nhiều dân tộc tại khu vực Tây Nguyên.',
    N'The cultural space of gong music in the Central Highlands is a remarkable heritage reflecting the spiritual world, communal rituals, and long-standing cultural identity of many ethnic groups in the region.',
    N'Không gian văn hóa cồng chiêng Tây Nguyên là một trong những di sản văn hóa đặc sắc và giàu bản sắc nhất của Việt Nam. Đối với nhiều cộng đồng dân tộc ở Tây Nguyên, cồng chiêng không chỉ là nhạc cụ mà còn là vật thiêng gắn bó chặt chẽ với đời sống tinh thần, tín ngưỡng và sinh hoạt cộng đồng. Âm thanh cồng chiêng vang lên trong nhiều dịp quan trọng như lễ mừng lúa mới, lễ cúng bến nước, lễ cưới, lễ bỏ mả và các sự kiện lớn của buôn làng, tạo nên một không gian vừa linh thiêng vừa gắn kết.

Điểm độc đáo của di sản này nằm ở chỗ cồng chiêng không tồn tại đơn lẻ như một hình thức biểu diễn âm nhạc, mà gắn với toàn bộ không gian văn hóa xung quanh nó. Đó là nhà rông, bếp lửa, ché rượu cần, điệu múa cộng đồng, lễ phục truyền thống và những nghi lễ mang đậm dấu ấn của từng tộc người. Khi tiếng chiêng cất lên, cả cộng đồng cùng tham gia trong một không gian cộng cảm mạnh mẽ, nơi con người giao tiếp với nhau, với tổ tiên và với thần linh. Chính điều đó làm cho cồng chiêng trở thành một di sản sống, được nuôi dưỡng bởi chính cộng đồng thực hành nó.

Trong bối cảnh hiện đại, việc bảo tồn không gian văn hóa cồng chiêng đang trở nên đặc biệt quan trọng. Sự thay đổi lối sống, tác động của đô thị hóa và khoảng cách thế hệ có thể khiến nhiều giá trị truyền thống bị mai một. Vì vậy, gìn giữ cồng chiêng không chỉ là bảo tồn âm nhạc dân gian mà còn là bảo vệ ký ức tập thể, tri thức bản địa và bản lĩnh văn hóa của các dân tộc Tây Nguyên. Đây là một di sản cần được trân trọng, truyền dạy và phát huy bền vững trong đời sống đương đại.',
    N'The cultural space of gong music in the Central Highlands is one of the most distinctive and identity-rich forms of Vietnamese cultural heritage. For many ethnic communities in the region, gongs are not merely musical instruments. They are sacred objects closely connected to spiritual life, belief systems, and communal activities. The sound of the gongs is heard during important events such as harvest celebrations, water source rituals, weddings, funerary ceremonies, and major village occasions, creating an atmosphere that is both sacred and socially unifying.

What makes this heritage unique is that gong culture does not exist as an isolated musical performance. It is closely linked to an entire cultural environment that includes communal houses, hearth fires, jars of rice wine, circle dances, traditional clothing, and ritual practices specific to each community. When the gongs are played, the whole community takes part in a shared emotional and spiritual space where people connect with one another, with ancestors, and with sacred forces. This is what makes gong culture a living heritage sustained by the very communities that practice it.

In modern times, preserving the cultural space of gong music has become increasingly important. Social change, urbanization, and generational shifts may threaten the continuity of many traditional values. For this reason, safeguarding gong culture means more than preserving folk music. It also means protecting collective memory, indigenous knowledge, and the cultural strength of the ethnic peoples of the Central Highlands. It is a heritage that deserves respect, transmission, and sustainable development in contemporary life.',
    N'Admin',
    GETDATE(),
    N'https://www.vwu.vn/documents/20182/3932764/27_Jun_2022_015425_GMTPyang.jpg/11caffcc-2e08-40fd-8cd7-ed4d0febcf3d',
    N'VAN_HOA',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'TAY_NGUYEN'),
    NULL,
    (SELECT DanTocID FROM dbo.VanHoa WHERE Ma = 'KHONG_GIAN_CONG_CHIENG_TAY_NGUYEN'),
    NULL,
    (SELECT VanHoaID FROM dbo.VanHoa WHERE Ma = 'KHONG_GIAN_CONG_CHIENG_TAY_NGUYEN'),
    NULL
),
(
    'BAI_VIET_AO_DAI_TRONG_BAN_SAC_VIET',
    N'Áo dài trong bản sắc văn hóa Việt Nam',
    N'The Ao Dai in Vietnamese Cultural Identity',
    N'Áo dài là biểu tượng tiêu biểu của vẻ đẹp Việt Nam, thể hiện sự thanh lịch, kín đáo, duyên dáng và khả năng dung hòa giữa truyền thống với hiện đại.',
    N'The ao dai is a representative symbol of Vietnamese beauty, expressing elegance, modesty, grace, and the harmony between tradition and modernity.',
    N'Áo dài từ lâu đã được xem là một biểu tượng văn hóa đặc sắc của Việt Nam. Với thiết kế mềm mại, ôm dáng nhưng vẫn kín đáo và thanh nhã, áo dài không chỉ tôn lên vẻ đẹp hình thể mà còn thể hiện phong cách thẩm mỹ tinh tế của người Việt. Trải qua nhiều giai đoạn lịch sử, chiếc áo dài đã có những biến đổi nhất định về kiểu dáng, chất liệu và họa tiết, nhưng vẫn giữ được tinh thần cốt lõi là sự duyên dáng, nền nã và đậm đà bản sắc dân tộc.

Trong đời sống xã hội, áo dài xuất hiện trong nhiều dịp quan trọng như lễ cưới, lễ Tết, ngày khai giảng, các chương trình biểu diễn nghệ thuật, sự kiện văn hóa và hoạt động đối ngoại. Hình ảnh nữ sinh trong tà áo dài trắng, cô dâu trong áo dài truyền thống hay đại diện Việt Nam mặc áo dài trong các sự kiện quốc tế đã trở thành những hình ảnh quen thuộc, mang đậm tính biểu tượng. Với nhiều người, áo dài không chỉ là trang phục mà còn là niềm tự hào văn hóa, là cách để thể hiện sự trân trọng đối với truyền thống dân tộc.

Điều đáng quý ở áo dài là khả năng thích nghi với thời đại mà không đánh mất bản sắc. Ngày nay, áo dài được sáng tạo với nhiều chất liệu mới, đường cắt hiện đại và họa tiết phong phú hơn, nhưng vẫn giữ nguyên tinh thần Việt Nam trong từng đường nét. Chính sự giao hòa giữa truyền thống và hiện đại đã giúp áo dài tiếp tục sống động trong đời sống đương đại, trở thành một biểu tượng bền vững của vẻ đẹp, sự tinh tế và bản lĩnh văn hóa Việt Nam.',
    N'The ao dai has long been regarded as one of the most iconic cultural symbols of Vietnam. With its graceful silhouette, fitted shape, and refined modesty, it highlights not only the wearer’s physical beauty but also the aesthetic sensibility of Vietnamese culture. Throughout history, the ao dai has changed in terms of materials, tailoring, and decoration, yet it has consistently preserved its essential spirit: elegance, restraint, and deep national identity.

In social life, the ao dai appears in many important settings such as weddings, Lunar New Year celebrations, school ceremonies, artistic performances, cultural events, and diplomatic activities. The image of female students in white ao dai, brides in traditional dress, or Vietnamese representatives wearing ao dai at international occasions has become highly symbolic. For many people, the ao dai is more than clothing. It is a source of cultural pride and a visible expression of respect for national tradition.

What makes the ao dai especially remarkable is its ability to adapt to changing times without losing its cultural essence. Today, designers continue to experiment with new fabrics, modern tailoring, and diverse patterns, while still preserving the unmistakable Vietnamese spirit of the garment. This harmony between tradition and modernity is what allows the ao dai to remain vibrant in contemporary life and to endure as a symbol of beauty, sophistication, and Vietnamese cultural confidence.',
    N'Admin',
    GETDATE(),
    N'https://bizweb.dktcdn.net/100/326/676/files/ao-dai-truyen-thong-6.webp?v=1727877987647',
    N'VAN_HOA',
    NULL,
    NULL,
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KINH'),
    NULL,
    (SELECT VanHoaID FROM dbo.VanHoa WHERE Ma = 'AO_DAI_TRUYEN_THONG_VIET_NAM'),
    NULL
),
(
    'BAI_VIET_Y_NGHIA_CUA_HAT_THEN',
    N'Ý nghĩa của hát then trong đời sống văn hóa dân tộc',
    N'The Significance of Then Singing in Ethnic Cultural Life',
    N'Hát then là loại hình diễn xướng dân gian giàu chất thơ, kết hợp âm nhạc, nghi lễ và đời sống tinh thần, phản ánh chiều sâu văn hóa của cộng đồng Tày, Nùng và Thái.',
    N'Then singing is a poetic form of folk performance that combines music, ritual, and spiritual life, reflecting the cultural depth of Tay, Nung, and Thai communities.',
    N'Hát then là một loại hình diễn xướng dân gian đặc sắc gắn bó mật thiết với đời sống tinh thần của các cộng đồng Tày, Nùng và một bộ phận người Thái. Trong không gian truyền thống, hát then thường đi cùng đàn tính, tạo nên một thế giới âm nhạc vừa sâu lắng, vừa linh thiêng, vừa giàu chất tự sự. Lời then thường mang tính kể chuyện, cầu chúc, khuyên răn hoặc bày tỏ tâm nguyện về cuộc sống bình an, gia đình hạnh phúc và mùa màng thuận lợi. Chính vì vậy, hát then không chỉ là âm nhạc để thưởng thức mà còn là phương tiện chuyển tải niềm tin, ký ức và tâm hồn của cộng đồng.

Trong nhiều hoàn cảnh, hát then gắn với các nghi lễ cầu an, cầu mùa, mừng nhà mới, chúc phúc hoặc những dịp sinh hoạt cộng đồng. Người thực hành then thường là những người có hiểu biết sâu sắc về lời ca, phong tục và nghi lễ. Thông qua giọng hát, tiếng đàn và lối diễn xướng, họ tạo nên một sự kết nối giữa con người với đời sống tinh thần và những giá trị văn hóa thiêng liêng của dân tộc mình. Người nghe không chỉ cảm nhận âm thanh mà còn cảm nhận được chiều sâu tâm linh và tính nhân văn trong từng lời then.

Ngày nay, hát then không còn chỉ hiện diện trong nghi lễ mà còn được biểu diễn trong nhiều lễ hội, chương trình giao lưu văn hóa và hoạt động bảo tồn di sản. Tuy nhiên, giá trị cốt lõi của hát then vẫn nằm ở khả năng gìn giữ tiếng nói tâm hồn của cộng đồng, phản ánh nhân sinh quan, thế giới quan và khát vọng sống tốt đẹp của con người. Việc bảo tồn và truyền dạy hát then cho thế hệ trẻ là một việc làm cần thiết để duy trì bản sắc dân tộc và làm phong phú thêm kho tàng văn hóa Việt Nam.',
    N'Then singing is a distinctive form of folk performance closely tied to the spiritual life of Tay, Nung, and some Thai communities in Vietnam. In traditional settings, it is often accompanied by the tinh lute, creating a musical world that is reflective, sacred, and rich in narrative quality. The lyrics of then often tell stories, offer blessings, give moral advice, or express wishes for peace, family happiness, and agricultural prosperity. For this reason, then is not simply music for entertainment. It is also a medium for carrying belief, memory, and the emotional life of the community.

In many contexts, then singing is associated with rituals for peace, good harvests, house blessings, communal celebrations, and ceremonial occasions. Those who perform then usually possess deep knowledge of lyrics, customs, and ritual practice. Through voice, instrumental accompaniment, and performance style, they create a connection between human life and the sacred cultural values of their people. Audiences experience not only the sound but also the spiritual depth and humanity contained within each verse.

Today, then singing appears not only in ritual contexts but also in festivals, cultural exchange programs, and heritage preservation efforts. Even so, its core value remains the same: it preserves the inner voice of the community and reflects its worldview, moral outlook, and aspirations for a good life. Preserving and transmitting then singing to younger generations is essential for maintaining ethnic identity and enriching the cultural heritage of Vietnam.',
    N'Admin',
    GETDATE(),
    N'https://baochauelec.com/cdn/images/hat-then-la-gi-1.jpg',
    N'VAN_HOA',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'BAC_BO'),
    NULL,
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'TAY'),
    NULL,
    (SELECT VanHoaID FROM dbo.VanHoa WHERE Ma = 'HAT_THEN_TRONG_DOI_SONG_TAY_NUNG_THAI'),
    NULL
),
(
    'BAI_VIET_CHO_NOI_MIEN_TAY_NET_DEP_SONG_NUOC',
    N'Chợ nổi miền Tây – nét đẹp của văn hóa sông nước Nam Bộ',
    N'Floating Markets of the Mekong Delta – A Beauty of Southern River Culture',
    N'Chợ nổi miền Tây là một nét văn hóa đặc trưng của đồng bằng sông Cửu Long, phản ánh lối sống thích ứng với sông nước, tinh thần giao thương và bản sắc vùng miền Nam Bộ.',
    N'The floating markets of the Mekong Delta are a distinctive cultural feature of southern Vietnam, reflecting river-based adaptation, trading life, and regional identity.',
    N'Chợ nổi miền Tây là một trong những hình ảnh tiêu biểu nhất của vùng đồng bằng sông Cửu Long. Được hình thành trong điều kiện sông ngòi, kênh rạch chằng chịt, chợ nổi không chỉ là nơi buôn bán mà còn là không gian sinh hoạt phản ánh rõ nét đời sống của cư dân miền sông nước. Từ sáng sớm, ghe thuyền từ nhiều nơi tụ họp trên sông, chở theo trái cây, rau củ, nông sản, thực phẩm và hàng hóa phục vụ đời sống thường nhật. Hoạt động giao thương diễn ra ngay trên mặt nước, tạo nên một cảnh quan sống động, gần gũi và mang đậm hơi thở của miền Tây Nam Bộ.

Một trong những đặc trưng thú vị của chợ nổi là hình thức treo hàng lên “cây bẹo” để người mua có thể nhận biết từ xa ghe đang bán gì. Cách giới thiệu hàng hóa ấy vừa giản dị, thực tế, vừa cho thấy sự sáng tạo của cư dân sông nước trong điều kiện buôn bán trên ghe thuyền. Tuy nhiên, chợ nổi không chỉ có giá trị kinh tế. Đây còn là nơi gặp gỡ, trò chuyện, chia sẻ thông tin và duy trì các mối quan hệ xã hội. Tiếng máy ghe, tiếng gọi mời, tiếng nói cười trên sông đã tạo thành một không gian văn hóa độc đáo mà khó nơi nào có được.

Ngày nay, khi giao thông đường bộ ngày càng phát triển, vai trò thương mại của nhiều chợ nổi đã thay đổi. Dù vậy, chợ nổi vẫn là biểu tượng văn hóa quan trọng của miền Tây, gắn với ký ức cộng đồng và hình ảnh đời sống sông nước Nam Bộ. Việc bảo tồn và phát huy giá trị chợ nổi không chỉ góp phần phát triển du lịch mà còn là cách gìn giữ một hình thức sinh hoạt văn hóa đặc sắc, thể hiện sự thích ứng linh hoạt của con người với môi trường tự nhiên và khẳng định bản sắc riêng của vùng đất phương Nam.',
    N'The floating markets of the Mekong Delta are among the most iconic images of southern Vietnam. Formed in a landscape shaped by dense rivers and canals, these markets are not only places of trade but also living spaces that vividly reflect the life of river-based communities. From early morning, boats from many areas gather on the water carrying fruits, vegetables, crops, food, and daily necessities. Commercial activity takes place directly on the river, creating a lively and intimate scene full of the character of the Mekong region.

One of the most interesting features of the floating market is the use of a tall display pole known as a “cây bẹo,” on which sellers hang examples of the goods they offer so that buyers can identify them from afar. This method is simple, practical, and highly creative, reflecting the ingenuity of river communities in adapting trade to a water-based environment. Yet the market’s value is not only economic. It is also a place of encounter, conversation, information exchange, and social connection. The sound of boat engines, trading calls, and human voices drifting across the river creates a cultural atmosphere unlike any land-based market.

Today, as road transportation has expanded, the commercial role of many floating markets has changed. Even so, they remain powerful cultural symbols of the Mekong Delta, closely tied to collective memory and the image of southern river life. Preserving and promoting floating markets is important not only for tourism but also for safeguarding a unique cultural way of life that reflects human adaptability to the natural environment and affirms the distinct identity of southern Vietnam.',
    N'Admin',
    GETDATE(),
    N'https://media-cdn-v2.laodong.vn/Storage/NewsPortal/2022/10/21/1107813/Chonoiphongdien5_637.jpg',
    N'VAN_HOA',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'NAM_BO'),
    (SELECT TinhThanhID FROM dbo.TinhThanh WHERE MaTinh = 'CAN_THO'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KINH'),
    NULL,
    (SELECT VanHoaID FROM dbo.VanHoa WHERE Ma = 'CHO_NOI_MIEN_TAY'),
    NULL
),
(
    'BAI_VIET_NHA_NHAC_CUNG_DINH_HUE_TINH_HOA_AM_NHAC_CUNG_DINH',
    N'Nhã nhạc cung đình Huế – tinh hoa âm nhạc cung đình Việt Nam',
    N'Hue Royal Court Music – The Essence of Vietnamese Court Music',
    N'Nhã nhạc cung đình Huế là loại hình âm nhạc bác học tiêu biểu của triều đình phong kiến Việt Nam, phản ánh vẻ đẹp trang trọng, tinh tế và chiều sâu văn hóa của một thời kỳ lịch sử đặc biệt.',
    N'Hue Royal Court Music is a representative form of classical ceremonial music of the Vietnamese imperial court, reflecting solemn beauty, refinement, and the cultural depth of a remarkable historical era.',
    N'Nhã nhạc cung đình Huế là một trong những loại hình nghệ thuật truyền thống tiêu biểu và đặc sắc nhất của văn hóa Việt Nam. Gắn liền với đời sống cung đình, đặc biệt dưới triều Nguyễn, nhã nhạc không chỉ đơn thuần là âm nhạc dùng để thưởng thức mà còn là thành tố quan trọng trong hệ thống lễ nghi của nhà nước phong kiến. Loại hình âm nhạc này thường được trình diễn trong những dịp trọng đại như lễ đăng quang, tế giao, tế miếu, lễ tiếp đón sứ thần, lễ mừng thọ vua hoặc các nghi lễ lớn trong cung đình. Chính vì vậy, nhã nhạc mang tính trang trọng, chuẩn mực và đòi hỏi mức độ tinh luyện rất cao trong cách biểu diễn.

Điểm đặc biệt của nhã nhạc cung đình Huế là sự kết hợp hài hòa giữa âm nhạc, ca xướng, múa cung đình, trang phục lễ nghi và không gian trình diễn. Dàn nhạc sử dụng nhiều nhạc cụ truyền thống như đàn nguyệt, đàn tỳ bà, đàn nhị, sáo, trống, kèn và các nhạc cụ gõ khác, tạo nên âm hưởng vừa uy nghi vừa thanh nhã. Mỗi bài bản trong nhã nhạc đều được xây dựng theo quy tắc chặt chẽ, phản ánh trình độ tổ chức nghệ thuật cao và tư duy thẩm mỹ tinh tế của văn hóa cung đình Việt Nam. Bên cạnh giá trị âm nhạc, nhã nhạc còn thể hiện rõ trật tự xã hội, quan niệm lễ nhạc và tinh thần tôn nghiêm của một nền văn hiến lâu đời.

Ngày nay, dù môi trường cung đình xưa không còn nguyên vẹn, nhã nhạc vẫn giữ được giá trị to lớn trong đời sống văn hóa đương đại. Những chương trình biểu diễn, hoạt động nghiên cứu, giảng dạy và bảo tồn đã góp phần đưa nhã nhạc đến gần hơn với công chúng. Việc gìn giữ loại hình này không chỉ là bảo tồn một di sản âm nhạc quý giá mà còn là cách lưu giữ ký ức lịch sử, tinh thần thẩm mỹ và chiều sâu văn hóa của dân tộc Việt Nam. Nhã nhạc cung đình Huế vì thế luôn được xem là một phần tinh hoa của bản sắc văn hóa truyền thống.',
    N'Hue Royal Court Music is one of the most distinguished and representative traditional art forms in Vietnamese culture. Closely associated with court life, especially during the Nguyen Dynasty, it was not simply music for entertainment but an essential component of the ceremonial system of the imperial state. This musical form was commonly performed during important occasions such as coronations, heaven and earth rituals, ancestral ceremonies, receptions for foreign envoys, royal longevity celebrations, and other major court events. For that reason, it carries a formal, solemn, and highly refined character in every aspect of performance.

One of the defining features of Hue Royal Court Music is the harmonious integration of instrumental music, singing, ceremonial dance, formal costumes, and performance space. The ensemble includes traditional instruments such as the moon lute, pipa, two-string fiddle, flute, drums, oboes, and percussion instruments, creating a sound world that is both majestic and elegant. Each composition follows carefully structured principles, reflecting the high level of artistic organization and refined aesthetic thinking of Vietnamese court culture. Beyond its musical value, royal court music also reveals the social order, ritual philosophy, and ceremonial dignity of a long-standing civilization.

Today, even though the original court environment no longer exists in its historical form, Hue Royal Court Music continues to hold great cultural significance. Performances, academic studies, teaching programs, and preservation activities have helped bring this art form closer to contemporary audiences. Safeguarding it means more than protecting a valuable musical heritage. It also means preserving historical memory, aesthetic sensibility, and the cultural depth of the Vietnamese nation. Hue Royal Court Music is therefore regarded as one of the finest treasures of Vietnam’s traditional cultural identity.',
    N'Admin',
    GETDATE(),
    N'https://statics.vinpearl.com/nha-nhac-cung-dinh-hue-2_1690183133.jpg',
    N'VAN_HOA',
    (SELECT VungID FROM dbo.VanHoa WHERE Ma = 'NHA_NHAC_CUNG_DINH_HUE'),
    NULL,
    (SELECT DanTocID FROM dbo.VanHoa WHERE Ma = 'NHA_NHAC_CUNG_DINH_HUE'),
    NULL,
    (SELECT VanHoaID FROM dbo.VanHoa WHERE Ma = 'NHA_NHAC_CUNG_DINH_HUE'),
    NULL
),
(
    'BAI_VIET_DAN_CA_QUAN_HO_BAC_NINH_NET_DEP_GIAO_DUYEN_KINH_BAC',
    N'Dân ca quan họ Bắc Ninh – nét đẹp giao duyên của vùng Kinh Bắc',
    N'Quan Ho Folk Songs of Bac Ninh – The Grace of Courtship Singing in Kinh Bac',
    N'Dân ca quan họ Bắc Ninh là loại hình hát đối đáp đặc sắc, thể hiện vẻ đẹp trong lời ca, phong cách ứng xử thanh lịch và đời sống tinh thần phong phú của người dân vùng Kinh Bắc.',
    N'Quan Ho folk songs of Bac Ninh are a distinctive form of antiphonal singing, expressing lyrical beauty, elegant social manners, and the rich spiritual life of the people of Kinh Bac.',
    N'Dân ca quan họ Bắc Ninh là một loại hình nghệ thuật dân gian đặc sắc gắn bó mật thiết với vùng văn hóa Kinh Bắc, nơi nổi tiếng với truyền thống văn hiến, lối sống thanh lịch và đời sống tinh thần giàu chất thơ. Quan họ nổi bật với hình thức hát đối đáp giữa liền anh và liền chị, trong đó những câu hát giao duyên được cất lên để bày tỏ tình cảm, sự mến khách, tài ứng đối và vẻ đẹp trong giao tiếp. Những làn điệu quan họ thường mượt mà, sâu lắng, giàu cảm xúc và mang tính biểu cảm cao, làm nên sức sống bền bỉ của loại hình nghệ thuật này trong lòng người yêu văn hóa dân gian.

Không gian diễn xướng của quan họ rất phong phú, có thể là sân đình, bến nước, cửa chùa, hội làng hay những dịp gặp gỡ kết chạ giữa các làng quan họ. Điều làm nên giá trị đặc biệt của quan họ không chỉ nằm ở âm nhạc mà còn ở phong cách ứng xử. Người hát quan họ rất coi trọng lễ nghĩa, sự nhã nhặn, tinh thần tôn trọng bạn hát và sự tinh tế trong lời ăn tiếng nói. Trang phục truyền thống như áo tứ thân, nón quai thao, khăn xếp, áo the cũng góp phần làm nổi bật vẻ đẹp riêng của quan họ. Tất cả những yếu tố ấy hòa quyện thành một không gian văn hóa vừa đậm chất nghệ thuật, vừa thấm đẫm tính cộng đồng và nhân văn.

Trong bối cảnh hiện đại, dân ca quan họ vẫn giữ một vị trí đặc biệt trong đời sống văn hóa Bắc Ninh nói riêng và Việt Nam nói chung. Nhiều câu lạc bộ, trường học và chương trình văn hóa đã tích cực bảo tồn, truyền dạy và quảng bá quan họ đến với công chúng trẻ. Việc gìn giữ dân ca quan họ không chỉ là bảo tồn một làn điệu dân gian mà còn là cách giữ gìn một lối sống đẹp, một phong cách ứng xử giàu tình nghĩa và một phần hồn cốt của văn hóa Kinh Bắc.',
    N'Quan Ho folk songs of Bac Ninh are a distinctive form of traditional performance deeply rooted in the cultural region of Kinh Bac, an area long known for its scholarship, elegance, and poetic spirit. Quan Ho is best recognized through its antiphonal singing style between male and female partners, known as liền anh and liền chị, who exchange lyrical verses to express affection, hospitality, verbal skill, and grace in communication. The melodies are usually soft, expressive, and emotionally rich, which is one reason why this art form has retained its vitality over time.

The performance space of Quan Ho is highly diverse, ranging from communal courtyards and riversides to pagoda grounds, village festivals, and ceremonial friendship exchanges between Quan Ho villages. What gives this art form its special cultural value is not only the music itself, but also the code of conduct it embodies. Quan Ho singers place great importance on courtesy, refinement, mutual respect, and delicacy in speech and behavior. Traditional costumes such as four-panel dresses, flat palm hats, turbans, and ceremonial tunics further enhance the distinctive beauty of the tradition. Together, these elements create a cultural space that is both artistic and deeply humane.

In the modern era, Quan Ho continues to hold a special place in the cultural life of Bac Ninh and of Vietnam more broadly. Many clubs, schools, and cultural programs have actively worked to preserve, teach, and promote this tradition to younger generations. Protecting Quan Ho means more than preserving a folk singing style. It also means safeguarding a beautiful way of life, a refined social ethic, and an essential part of the spirit of Kinh Bac culture.',
    N'Admin',
    GETDATE(),
    N'https://statics.vinpearl.com/nhung-nghe-sy-hat-quan-ho-bac-ninh_1753065397.jpg',
    N'VAN_HOA',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'BAC_BO'),
    (SELECT TinhThanhID FROM dbo.TinhThanh WHERE MaTinh = 'BAC_NINH'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KINH'),
    NULL,
    (SELECT VanHoaID FROM dbo.VanHoa WHERE Ma = 'DAN_CA_QUAN_HO_BAC_NINH'),
    NULL
),
(
    'BAI_VIET_DON_CA_TAI_TU_NAM_BO_AM_HUONG_CUA_MIEN_SONG_NUOC',
    N'Đờn ca tài tử Nam Bộ – âm hưởng của miền sông nước phương Nam',
    N'Southern Amateur Music – The Sound of the Southern River World',
    N'Đờn ca tài tử Nam Bộ là loại hình âm nhạc truyền thống giàu tính trữ tình, phản ánh tâm hồn phóng khoáng, tinh tế và tình cảm sâu nặng của con người vùng sông nước Nam Bộ.',
    N'Southern amateur music is a lyrical traditional musical form that reflects the open-hearted, refined, and deeply emotional spirit of the people of the Mekong region.',
    N'Đờn ca tài tử Nam Bộ là một loại hình nghệ thuật âm nhạc đặc sắc hình thành và phát triển trong không gian văn hóa sông nước của miền Nam Việt Nam. Đây là loại hình âm nhạc vừa mang tính bác học dân gian, vừa gần gũi với đời sống thường nhật, phản ánh rất rõ tâm hồn phóng khoáng, tinh tế và giàu cảm xúc của con người phương Nam. Đờn ca tài tử thường được biểu diễn trong những buổi gặp gỡ bạn bè, sinh hoạt gia đình, ngày lễ, đám tiệc hoặc những lúc thư nhàn, tạo nên một không gian nghệ thuật thân mật, nơi con người chia sẻ cảm xúc và thưởng thức cái đẹp bằng sự đồng điệu tâm hồn.

Điểm nổi bật của đờn ca tài tử nằm ở sự kết hợp giữa tiếng đàn và lời ca, giữa khuôn mẫu truyền thống với sự ứng biến linh hoạt của người biểu diễn. Các nhạc cụ quen thuộc như đàn kìm, đàn tranh, đàn cò, đàn bầu, sáo và đặc biệt là guitar phím lõm đã tạo nên âm hưởng rất riêng cho loại hình này. Người nghệ nhân đờn ca tài tử không chỉ cần nắm chắc bài bản mà còn phải có khả năng cảm thụ tinh tế để thể hiện từng cung bậc cảm xúc trong mỗi câu hát, mỗi điệu đàn. Nội dung của đờn ca tài tử thường xoay quanh tình yêu quê hương, tình nghĩa gia đình, nỗi niềm con người và những rung động sâu kín của tâm hồn.

Trong nhịp sống hiện đại, đờn ca tài tử vẫn giữ vai trò quan trọng trong đời sống văn hóa Nam Bộ. Nhiều câu lạc bộ, liên hoan, chương trình biểu diễn và hoạt động bảo tồn đã góp phần giữ cho loại hình nghệ thuật này tiếp tục sống trong cộng đồng. Đờn ca tài tử không chỉ là âm nhạc để thưởng thức, mà còn là nơi lưu giữ tâm hồn, ký ức và bản sắc của vùng đất phương Nam. Việc trân trọng và gìn giữ loại hình này chính là cách bảo vệ một phần quý giá trong kho tàng văn hóa truyền thống Việt Nam.',
    N'Southern amateur music, known as đờn ca tài tử, is a distinctive musical tradition that emerged and flourished in the river-based cultural world of southern Vietnam. It is both refined and intimate, blending the sophistication of learned music with the closeness of everyday life. This genre clearly reflects the open-hearted, sensitive, and emotionally rich character of the people of the South. It is commonly performed at friendly gatherings, family occasions, festive events, celebrations, or moments of leisure, creating a warm artistic space in which people share feelings and appreciate beauty through emotional resonance.

A defining feature of this musical tradition is the relationship between instrumental performance and vocal expression, as well as the balance between established melodic structures and improvisational creativity. Instruments such as the moon lute, zither, two-string fiddle, monochord, flute, and especially the recessed-fret guitar give the genre its distinctive sonic character. Performers must not only master the musical framework, but also possess deep emotional sensitivity in order to convey the full range of feeling in every phrase and melodic mode. The content of the songs often centers on love of homeland, family affection, human longing, and the subtle inner life of ordinary people.

In modern life, southern amateur music continues to hold an important place in the cultural world of the South. Many clubs, festivals, performances, and preservation activities have helped keep this art form alive within the community. It is not merely music for listening. It is also a repository of memory, identity, and the emotional world of southern Vietnam. Respecting and preserving this tradition means protecting a precious part of the broader heritage of Vietnamese culture.',
    N'Admin',
    GETDATE(),
    N'https://upload.wikimedia.org/wikipedia/commons/a/a8/Ban_nh%E1%BA%A1c_%C4%91%E1%BB%9Dn_ca_t%C3%A0i_t%E1%BB%AD_S%C3%A0i_G%C3%B2n_%281911%29.jpeg',
    N'VAN_HOA',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'NAM_BO'),
    (SELECT TinhThanhID FROM dbo.TinhThanh WHERE MaTinh = 'CAN_THO'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KINH'),
    NULL,
    (SELECT VanHoaID FROM dbo.VanHoa WHERE Ma = 'DON_CA_TAI_TU_NAM_BO'),
    NULL
),
(
    'BAI_VIET_MUA_XOE_THAI_BIEU_TUONG_CUA_TINH_DOAN_KET',
    N'Múa xòe Thái – biểu tượng của tinh thần đoàn kết cộng đồng',
    N'Thai Xoe Dance – A Symbol of Community Solidarity',
    N'Múa xòe Thái là loại hình nghệ thuật dân gian đặc sắc của người Thái, thể hiện niềm vui, sự gắn kết cộng đồng và vẻ đẹp văn hóa vùng Tây Bắc Việt Nam.',
    N'Thai Xoe dance is a distinctive folk art of the Thai people, expressing joy, communal connection, and the cultural beauty of northwestern Vietnam.',
    N'Múa xòe là một trong những biểu tượng văn hóa tiêu biểu nhất của người Thái ở vùng Tây Bắc. Trong đời sống cộng đồng, xòe không chỉ là một điệu múa để biểu diễn mà còn là hình thức sinh hoạt văn hóa mang tính kết nối sâu sắc. Xòe thường xuất hiện trong các dịp lễ hội, mừng nhà mới, đón khách, mừng mùa, đám cưới và nhiều sự kiện cộng đồng quan trọng khác. Khi vòng xòe được mở ra, mọi người cùng nắm tay nhau, hòa vào nhịp điệu uyển chuyển, tạo nên một không gian văn hóa ấm áp, vui tươi và giàu tính biểu tượng.

Điều làm nên sức sống đặc biệt của múa xòe là tính cộng đồng rất cao. Trong vòng xòe, không có khoảng cách giữa người với người, giữa chủ với khách, giữa người già với người trẻ. Bất kỳ ai tham gia cũng trở thành một phần của niềm vui chung. Những động tác múa tuy mềm mại và giản dị nhưng ẩn chứa những ý nghĩa sâu sắc về sự đoàn kết, lòng hiếu khách, ước vọng no ấm và sự hòa hợp giữa con người với thiên nhiên. Qua thời gian, múa xòe đã phát triển thành nhiều điệu múa khác nhau, nhưng tinh thần cốt lõi vẫn là sự sẻ chia và gắn kết.

Ngày nay, múa xòe không chỉ là niềm tự hào của người Thái mà còn trở thành một biểu tượng văn hóa rộng lớn của vùng Tây Bắc. Việc tổ chức truyền dạy, biểu diễn và giới thiệu múa xòe trong các hoạt động văn hóa, du lịch và giáo dục đã góp phần làm cho giá trị của loại hình nghệ thuật này được lan tỏa sâu rộng hơn. Múa xòe vì thế không chỉ là điệu múa của ngày hội mà còn là hình ảnh sống động của tinh thần đoàn kết, bản sắc dân tộc và vẻ đẹp nhân văn trong văn hóa Việt Nam.',
    N'Xoe dance is one of the most representative cultural symbols of the Thai people in northwestern Vietnam. In community life, it is far more than a dance performed for entertainment. It is a deeply connective form of cultural participation that appears during festivals, housewarming ceremonies, harvest celebrations, weddings, receptions for guests, and many other important communal occasions. When the Xoe circle begins, people join hands and move together in graceful rhythms, creating a warm, joyful, and highly symbolic cultural space.

The special vitality of Xoe dance comes from its strong communal nature. Within the dance circle, there is no barrier between host and guest, old and young, local people and visitors. Anyone who joins becomes part of a shared celebration. The movements may appear simple and flowing, yet they carry profound meanings related to solidarity, hospitality, hopes for prosperity, and harmony between human life and nature. Over time, Xoe has developed into many different dance forms, but its central spirit has always remained one of sharing and connection.

Today, Xoe dance is not only a source of pride for the Thai people but also a broader cultural symbol of the Northwest region. Efforts to teach, perform, and introduce Xoe through cultural, educational, and tourism activities have helped expand its value to wider audiences. Xoe is therefore not only a dance of celebration, but also a vivid representation of social unity, ethnic identity, and the humanistic beauty found in Vietnamese culture.',
    N'Admin',
    GETDATE(),
    N'https://media-cdn-v2.laodong.vn/storage/newsportal/2022/9/22/1096335/1-4.jpg?w=800&h=420&crop=auto&scale=both',
    N'VAN_HOA',
   (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'BAC_BO'),
    NULL,
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'THAI'),
    NULL,
    (SELECT VanHoaID FROM dbo.VanHoa WHERE Ma = 'NGHE_THUAT_MUA_XOE_THAI'),
    NULL
),
(
    'BAI_VIET_TUC_AN_TRAU_NET_DUYEN_TRONG_VAN_HOA_GIAO_TIEP_VIET',
    N'Tục ăn trầu – nét duyên trong văn hóa giao tiếp của người Việt',
    N'The Betel Chewing Custom – A Graceful Part of Vietnamese Social Culture',
    N'Tục ăn trầu là một phong tục lâu đời của người Việt, gắn với giao tiếp, lễ nghi, hôn nhân và những giá trị văn hóa về tình nghĩa, sự kính trọng và kết nối cộng đồng.',
    N'The betel chewing custom is a long-standing Vietnamese tradition associated with social interaction, rituals, marriage, and cultural values of affection, respect, and community connection.',
    N'Tục ăn trầu là một trong những phong tục lâu đời và giàu ý nghĩa trong văn hóa truyền thống của người Việt. Từ xa xưa, miếng trầu không chỉ là một vật phẩm dùng trong sinh hoạt mà còn là biểu tượng của sự thân tình, hiếu khách và mối quan hệ gắn bó giữa con người với con người. Câu nói “miếng trầu là đầu câu chuyện” đã phản ánh rất rõ vai trò của trầu cau trong đời sống giao tiếp, khi một miếng trầu có thể mở đầu cho cuộc trò chuyện, tạo nên sự gần gũi và bày tỏ thành ý của người mời.

Tục ăn trầu còn gắn bó chặt chẽ với nhiều nghi lễ quan trọng như cưới hỏi, giỗ chạp, lễ Tết và các nghi thức thờ cúng. Đặc biệt trong hôn nhân, trầu cau mang ý nghĩa biểu tượng rất sâu sắc, gắn với câu chuyện về tình nghĩa anh em, vợ chồng và sự thủy chung son sắt. Chính vì thế, trầu cau thường xuất hiện như một sính lễ quan trọng trong lễ dạm ngõ, lễ ăn hỏi và lễ cưới. Không chỉ hiện diện trong đời sống gia đình, trầu cau còn xuất hiện trên bàn thờ tổ tiên, trong các dịp cúng lễ, cho thấy phong tục này có vị trí bền vững trong đời sống tinh thần của người Việt.

Ngày nay, tục ăn trầu không còn phổ biến như trước trong sinh hoạt thường ngày, nhưng giá trị văn hóa của nó vẫn còn hiện diện rõ trong ký ức cộng đồng và trong nhiều hình thức lễ nghi truyền thống. Tìm hiểu về tục ăn trầu là cách để hiểu sâu hơn về lối sống trọng nghĩa tình, sự tinh tế trong giao tiếp và những giá trị nhân văn đã làm nên vẻ đẹp của văn hóa Việt Nam. Đây là một phong tục tuy mộc mạc nhưng chứa đựng chiều sâu lịch sử và tâm hồn dân tộc.',
    N'The betel chewing custom is one of the oldest and most meaningful traditions in Vietnamese cultural life. In the past, a betel quid was not simply an everyday item, but a symbol of friendliness, hospitality, and human connection. The well-known saying that “a betel quid begins the conversation” clearly expresses the role of betel and areca in social interaction, where the offering of betel could open a dialogue, create intimacy, and show sincere respect toward others.

This custom was also closely connected to important rituals such as weddings, memorial ceremonies, Lunar New Year celebrations, and ancestral worship. In marriage in particular, betel and areca carry profound symbolic value because of their connection to the story of brotherhood, conjugal loyalty, and enduring affection. For this reason, betel and areca often appear as important gifts in engagement visits, betrothal ceremonies, and weddings. Beyond the family sphere, they are also placed on ancestral altars and used in ritual offerings, showing the lasting place of this custom in Vietnamese spiritual and social life.

Today, betel chewing is no longer as common in daily life as it once was, yet its cultural meaning remains clearly preserved in collective memory and in many traditional rites. Learning about this custom helps people better understand the Vietnamese emphasis on affection, courtesy, and the refined nature of social interaction. Though simple in form, it carries historical depth and reveals the emotional and cultural spirit of the nation.',
    N'Admin',
    GETDATE(),
    N'https://baocantho.com.vn/image/fckeditor/upload/2022/20220101/images/T10-a1.png',
    N'VAN_HOA',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'BAC_BO'),
    NULL,
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KINH'),
    NULL,
    (SELECT VanHoaID FROM dbo.VanHoa WHERE Ma = 'TUC_AN_TRAU_CUA_NGUOI_VIET'),
    NULL
);







------------------------------------------------------------------ Thêm dữ liệu ẩm thực --------------------------------------
INSERT INTO dbo.AmThuc
(
    MaMonAn,
    TenVI,
    TenEN,
    LoaiMonAnVI,
    LoaiMonAnEN,
    MoTaNganVI,
    MoTaNganEN,
    NoiDungChiTietVI,
    NoiDungChiTietEN,
    VungID,
    TinhThanhID,
    DanTocID,
    ImageUrl
)
VALUES
(
    'PHO_BO',
    N'Phở Bò',
    N'Beef Pho',
    N'Món nước',
    N'Noodle soup',
    N'Tinh hoa ẩm thực Việt.',
    N'An iconic Vietnamese noodle dish.',
    N'Phở bò là một trong những món ăn tiêu biểu nhất của ẩm thực Việt Nam, được biết đến rộng rãi trong nước và quốc tế như một biểu tượng của sự tinh tế trong nghệ thuật nấu ăn truyền thống. Món ăn này nổi bật bởi sự kết hợp hài hòa giữa nước dùng trong, thanh nhưng đậm đà, bánh phở mềm, thịt bò được chế biến đa dạng và các loại rau thơm, gia vị ăn kèm. Điểm cốt lõi làm nên giá trị của phở bò nằm ở phần nước dùng, thường được ninh trong nhiều giờ từ xương bò để tạo độ ngọt tự nhiên, kết hợp cùng các loại gia vị đặc trưng như quế, hồi, thảo quả, gừng nướng và hành nướng. Quá trình nấu nước dùng đòi hỏi sự kiên nhẫn, cân đối trong định lượng nguyên liệu và khả năng kiểm soát hương vị để đạt được độ trong, thơm và hài hòa.

Trong một bát phở bò truyền thống, bánh phở làm từ gạo có dạng sợi dẹt, mềm nhưng vẫn giữ được độ dai vừa phải. Phần thịt bò có thể được lựa chọn theo nhiều cách khác nhau như thịt tái, thịt chín, nạm, gầu, gân, bắp bò hoặc bò viên, giúp món ăn phong phú hơn về kết cấu và khẩu vị. Khi dùng, phở thường được chan nước dùng đang sôi lên trên để làm nóng toàn bộ nguyên liệu, sau đó ăn kèm với hành lá, hành tây, rau mùi, hạt tiêu, chanh, ớt tươi, tương ớt hoặc giấm tỏi tùy sở thích. Ở mỗi địa phương, cách nêm nếm và trình bày có thể khác nhau đôi chút, nhưng nhìn chung phở bò vẫn giữ được đặc trưng là thanh vị, thơm dịu và dễ ăn.

Phở bò không chỉ đơn thuần là một món ăn phổ biến trong bữa sáng mà còn hiện diện trong nhiều thời điểm khác nhau của đời sống thường nhật. Món ăn này phản ánh rõ nét khả năng tận dụng nguyên liệu, sự cầu kỳ trong chế biến và gu thưởng thức tinh tế của người Việt. Trong bối cảnh văn hóa ẩm thực, phở bò thường được xem là một đại diện tiêu biểu của bản sắc ẩm thực dân tộc, vừa gần gũi trong đời sống hàng ngày, vừa đủ đặc sắc để trở thành món ăn được giới thiệu rộng rãi với bạn bè quốc tế. Giá trị của phở bò không chỉ nằm ở hương vị mà còn ở vai trò như một biểu tượng văn hóa, gắn với ký ức, thói quen sinh hoạt và niềm tự hào ẩm thực của nhiều thế hệ người Việt.',
    N'Beef pho is one of the most representative dishes of Vietnamese cuisine and is widely recognized both within Vietnam and internationally as a symbol of refinement in traditional cooking. The dish is distinguished by the harmonious combination of a clear yet flavorful broth, soft rice noodles, carefully prepared beef, and a variety of fresh herbs and condiments. The defining element of beef pho is its broth, which is typically simmered for many hours from beef bones to develop natural sweetness, then infused with aromatic spices such as cinnamon, star anise, black cardamom, grilled ginger, and charred onion. Preparing the broth requires patience, balance in ingredient proportions, and close attention to flavor in order to achieve clarity, aroma, and depth without overwhelming heaviness.

In a traditional bowl of beef pho, the rice noodles are flat, smooth, and tender while still retaining a pleasant chew. The beef may be served in several forms, including rare slices, well-done beef, brisket, flank, tendon, shank, or beef meatballs, allowing the dish to offer a variety of textures and flavor profiles. When served, the ingredients are usually topped with boiling broth so that the entire bowl is heated evenly, then enjoyed with scallions, onion, cilantro, black pepper, lime, fresh chili, chili sauce, or pickled garlic vinegar according to personal taste. Although seasoning styles and presentation may vary slightly from one locality to another, the overall character of beef pho remains consistent: fragrant, balanced, delicate, and approachable.

Beef pho is not merely a common breakfast food but also a dish enjoyed at many different times throughout the day. It reflects the Vietnamese ability to make thoughtful use of ingredients, apply careful cooking techniques, and appreciate subtle yet layered flavors. In the broader context of food culture, beef pho is often regarded as one of the clearest expressions of Vietnamese culinary identity. It is both familiar in daily life and distinctive enough to be introduced to international diners as a hallmark of the country’s cuisine. The value of beef pho lies not only in its taste, but also in its role as a cultural symbol connected to memory, everyday habits, and the culinary pride of many generations of Vietnamese people.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'BAC_BO'),
    (SELECT TinhThanhID FROM dbo.TinhThanh WHERE MaTinh = 'HA_NOI'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KINH'),
    N'https://cdn2.fptshop.com.vn/unsafe/1920x0/filters:format(webp):quality(75)/2024_1_26_638418715174070559_pho-bo-anh-dai-dien.jpg'
),
(
    'BUN_RIEU',
    N'Bún Riêu',
    N'Bun Rieu',
    N'Món nước',
    N'Noodle soup',
    N'Đậm đà vị cua đồng dân dã.',
    N'A rustic crab-based noodle soup.',
    N'Bún riêu là món ăn quen thuộc của miền Bắc, nổi bật với nước dùng có vị chua thanh và vị ngọt tự nhiên từ cua đồng. Thành phần đặc trưng của món ăn là riêu cua được làm từ cua đồng giã hoặc xay nhuyễn, lọc lấy nước rồi nấu thành từng mảng riêu mềm, thơm và béo nhẹ. Ngoài riêu cua, bún riêu thường có thêm đậu phụ rán, cà chua, hành lá, rau sống và đôi khi ăn kèm chả hoặc giò tùy từng cách chế biến. Nước dùng thường được điều vị bằng giấm bỗng hoặc các nguyên liệu tạo chua thanh, giúp món ăn có hương vị hài hòa, dễ ăn và giàu bản sắc.

Sự hấp dẫn của bún riêu nằm ở tính mộc mạc nhưng đậm đà. Phần nước dùng có màu sắc đẹp mắt từ cà chua, mùi thơm của cua đồng và độ thanh dịu rất riêng. Riêu cua là linh hồn của món ăn, cần được làm khéo để giữ được độ tơi, mềm và hương thơm tự nhiên. Khi ăn, thực khách thường thêm rau sống, rau muống chẻ, kinh giới, tía tô, ớt và chút mắm tôm tùy khẩu vị, từ đó tạo nên trải nghiệm vị giác phong phú hơn.

Bún riêu là món ăn gắn bó với đời sống thường nhật, xuất hiện từ quán nhỏ dân dã đến bữa ăn gia đình. Đây là món ăn thể hiện rõ khả năng tận dụng nguyên liệu đồng quê và sự tinh tế trong cách nêm nếm của người miền Bắc. Dù ngày nay có nhiều biến tấu theo từng vùng và phong cách phục vụ, bún riêu truyền thống vẫn giữ được bản sắc là thanh, thơm, dân dã và đậm dấu ấn ẩm thực Việt Nam.',
    N'Bun rieu is a familiar Northern Vietnamese noodle soup known for its gently sour broth and the natural sweetness of freshwater crab. The defining element of the dish is crab roe mixture made from pounded or ground field crab, strained and cooked into soft, fragrant clusters floating in the broth. In addition to crab roe, bun rieu commonly includes fried tofu, tomatoes, scallions, fresh herbs, and sometimes Vietnamese sausage or pork rolls depending on local style. The broth is often seasoned with rice vinegar or other mild souring ingredients, giving the dish a balanced, refreshing, and highly distinctive flavor.

Its appeal lies in its rustic yet rich character. The broth has an attractive color from tomatoes, an unmistakable aroma from crab, and a clean, gentle finish. The crab component is the soul of the dish and must be prepared carefully so that it remains fluffy, tender, and naturally aromatic. When served, diners often add fresh herbs, water spinach, Vietnamese balm, perilla, chili, and sometimes fermented shrimp paste according to personal preference, creating a more layered flavor experience.

Bun rieu is deeply rooted in everyday life, from humble street stalls to home kitchens. It clearly reflects the Northern Vietnamese ability to make skillful use of countryside ingredients while maintaining balance and finesse in seasoning. Although many regional variations exist today, the traditional version remains valued for being light, fragrant, rustic, and unmistakably Vietnamese.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'BAC_BO'),
    (SELECT TinhThanhID FROM dbo.TinhThanh WHERE MaTinh = 'HA_NOI'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KINH'),
    N'https://cdn2.fptshop.com.vn/unsafe/1920x0/filters:format(webp):quality(75)/cach_nau_bun_rieu_thit_0c047cb9d3.jpg'
),
(
    'CHA_CA_LA_VONG',
    N'Chả Cá Lã Vọng',
    N'Cha Ca La Vong',
    N'Món cá',
    N'Fish dish',
    N'Đặc sản trứ danh của Hà Nội.',
    N'A legendary specialty of Hanoi.',
    N'Chả cá Lã Vọng là một trong những món ăn nổi tiếng nhất của Hà Nội, gắn với truyền thống ẩm thực lâu đời và phong cách thưởng thức rất đặc trưng của đất kinh kỳ. Món ăn được chế biến chủ yếu từ cá lăng hoặc các loại cá thịt chắc, ít xương, được ướp với nghệ, riềng, mẻ và nhiều gia vị khác trước khi nướng hoặc áp chảo. Khi ăn, cá được đảo nóng cùng thì là và hành lá trong chảo nhỏ, sau đó dùng kèm bún, lạc rang, rau thơm và mắm tôm pha chanh, ớt. Sự kết hợp của cá thơm, rau thơm nóng, vị bùi của lạc và hương vị đậm đà của nước chấm tạo nên trải nghiệm ẩm thực rất riêng.

Một trong những nét độc đáo của chả cá Lã Vọng là cách phục vụ mang tính tương tác cao. Món ăn thường không dọn sẵn hoàn chỉnh mà được làm nóng ngay trên bàn, giúp thực khách cảm nhận rõ hương thơm của cá, thì là và hành lá khi đang chín tới. Phần cá sau khi ướp có màu vàng hấp dẫn nhờ nghệ, thịt chắc nhưng vẫn mềm, thơm mà không tanh. Mắm tôm, nếu được dùng đúng lượng và pha chuẩn vị, đóng vai trò quan trọng trong việc hoàn thiện hương vị của món ăn, dù thực khách cũng có thể thay bằng nước mắm tùy khẩu vị.

Chả cá Lã Vọng không chỉ là món ăn ngon mà còn là một dấu ấn văn hóa của Hà Nội. Món ăn thể hiện sự cầu kỳ trong lựa chọn nguyên liệu, kỹ thuật tẩm ướp và nghệ thuật phối hợp gia vị. Trải qua nhiều năm, chả cá Lã Vọng vẫn giữ vị thế là một đặc sản tiêu biểu, thường được giới thiệu như một món ăn mà thực khách nên trải nghiệm khi tìm hiểu ẩm thực truyền thống miền Bắc.',
    N'Cha ca La Vong is one of Hanoi’s most celebrated dishes, closely associated with the city’s long-standing culinary tradition and distinctive dining style. The dish is typically made from hemibagrus fish or other firm, low-bone fish, marinated with turmeric, galangal, fermented rice, and various seasonings before being grilled or pan-fried. At the table, the fish is heated with dill and scallions in a small pan, then eaten with rice vermicelli, roasted peanuts, fresh herbs, and fermented shrimp paste mixed with lime and chili. The combination of aromatic fish, hot herbs, nutty peanuts, and bold dipping sauce creates a highly distinctive culinary experience.

One of its unique features is its interactive way of serving. Rather than arriving fully plated, the dish is often finished at the table, allowing diners to enjoy the aroma of fish, dill, and scallions as they cook. The marinated fish has an appealing golden color from turmeric, with flesh that is firm yet tender and flavorful without any unpleasant fishiness. Fermented shrimp paste, when mixed properly and used in moderation, plays an important role in completing the flavor profile, although fish sauce may also be used depending on personal preference.

Cha ca La Vong is not only delicious but also culturally significant in Hanoi. It reflects careful ingredient selection, skilled marination techniques, and a refined use of herbs and seasonings. Over time, it has remained one of the capital’s signature specialties and is often recommended to anyone exploring the traditional cuisine of Northern Vietnam.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'BAC_BO'),
    (SELECT TinhThanhID FROM dbo.TinhThanh WHERE MaTinh = 'HA_NOI'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KINH'),
    N'https://giadinh.mediacdn.vn/296230595582509056/2022/11/27/6quanchacalavonghanoingonkhachnuomnuopravao8-1669560240972-1669560241404371625420.png'
),
(
    'BANH_CUON',
    N'Bánh Cuốn',
    N'Steamed Rice Rolls',
    N'Món bánh',
    N'Rice rolls',
    N'Mềm mỏng, thanh nhẹ và tinh tế.',
    N'Soft, delicate, and refined.',
    N'Bánh cuốn là món ăn phổ biến của miền Bắc, đặc biệt được ưa chuộng trong bữa sáng nhờ hương vị nhẹ nhàng và dễ ăn. Món ăn được làm từ bột gạo xay pha loãng, tráng thành lớp bánh mỏng trên mặt nồi hấp, sau đó cuộn với nhân thường gồm thịt heo băm và mộc nhĩ. Bánh cuốn thường được ăn kèm chả lụa, hành phi, rau thơm và nước mắm pha chua ngọt nhẹ. Điểm đặc trưng của món ăn nằm ở lớp bánh mịn, mỏng, mềm nhưng không nát, kết hợp cùng phần nhân thơm, đậm vị vừa phải và nước chấm cân bằng.

Để làm được bánh cuốn ngon, người chế biến cần kiểm soát tốt độ loãng của bột, độ nóng của nồi hấp và kỹ thuật tráng bánh. Lớp bánh phải đủ mỏng để tạo cảm giác mềm mượt nhưng vẫn giữ được độ dai nhẹ. Nhân bánh không nên quá nặng mùi mà cần vừa vặn để tôn lên độ thanh của phần vỏ. Khi dùng, hành phi giòn và chả lụa góp phần bổ sung kết cấu và hương vị, trong khi nước mắm pha đóng vai trò gắn kết toàn bộ món ăn.

Bánh cuốn thể hiện rõ tinh thần ẩm thực miền Bắc: giản dị, tiết chế nhưng tinh tế trong từng chi tiết. Món ăn này phù hợp với nhiều thời điểm trong ngày, song phổ biến nhất vẫn là bữa sáng hoặc bữa nhẹ. Với sự mềm mại, thanh vị và cách trình bày nhã nhặn, bánh cuốn đã trở thành một phần quen thuộc trong văn hóa ẩm thực đô thị lẫn nông thôn của miền Bắc.',
    N'Banh cuon is a popular dish in Northern Vietnam, especially favored for breakfast because of its light and gentle flavor. It is made from finely ground rice batter spread into thin sheets over a steaming surface, then rolled with a filling typically made of minced pork and wood ear mushrooms. Banh cuon is commonly served with Vietnamese pork sausage, crispy fried shallots, fresh herbs, and lightly sweet-and-sour fish sauce. Its defining characteristic is the smooth, thin, tender wrapper that remains intact, paired with a fragrant filling and a balanced dipping sauce.

Making excellent banh cuon requires careful control of batter consistency, steaming temperature, and rolling technique. The rice sheet must be thin enough to feel delicate while still retaining slight elasticity. The filling should be flavorful but not overpowering so that it complements the mild taste of the wrapper. Crispy shallots and pork sausage add texture and depth, while the fish sauce ties all the components together.

Banh cuon clearly reflects the spirit of Northern Vietnamese cuisine: simple, restrained, yet refined in every detail. It is suitable at many times of day, though most commonly enjoyed as breakfast or a light meal. With its softness, clean flavor, and elegant presentation, banh cuon has become a familiar part of both urban and rural food culture in the North.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'BAC_BO'),
    (SELECT TinhThanhID FROM dbo.TinhThanh WHERE MaTinh = 'HA_NOI'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KINH'),
    N'https://cdn.zsoft.solutions/poseidon-web/app/media/Kham-pha-am-thuc/11.2023/241123-banh-cuon-buffet-poseidon-4.jpg'
),
(
    'XOI_XEO',
    N'Xôi Xéo',
    N'Sticky Rice with Mung Bean and Fried Shallots',
    N'Món xôi',
    N'Sticky rice',
    N'Món xôi quen thuộc của Hà Nội.',
    N'A familiar Hanoi sticky rice dish.',
    N'Xôi xéo là món ăn dân dã nhưng rất được yêu thích ở miền Bắc, đặc biệt phổ biến tại Hà Nội như một lựa chọn quen thuộc cho bữa sáng. Món ăn gồm xôi nếp dẻo thơm, đỗ xanh đồ chín rồi giã nhuyễn hoặc thái mỏng thành lát, ăn kèm hành phi vàng giòn và thường có thêm mỡ gà hoặc mỡ hành để tăng độ béo. Dù nguyên liệu không nhiều, xôi xéo lại tạo được ấn tượng nhờ sự kết hợp hài hòa giữa độ dẻo của nếp, vị bùi của đỗ xanh và hương thơm đặc trưng của hành phi.

Điểm quan trọng của xôi xéo là chất lượng gạo nếp và cách đồ xôi. Gạo phải được chọn loại ngon để khi chín có độ dẻo, hạt tơi nhưng không nát. Đỗ xanh cần được nấu chín vừa phải để giữ được vị bùi tự nhiên mà không bị khô. Hành phi phải vàng đều, thơm và giòn để tạo điểm nhấn cả về mùi lẫn kết cấu. Nhiều nơi còn thêm chả, ruốc hoặc trứng để làm món ăn no và phong phú hơn, nhưng phiên bản truyền thống với đỗ xanh và hành phi vẫn là hình thức phổ biến nhất.

Xôi xéo thể hiện nét đẹp của ẩm thực bình dân miền Bắc, nơi những nguyên liệu quen thuộc có thể tạo nên món ăn vừa ngon, vừa tinh tế. Món ăn gắn liền với nhịp sống buổi sáng của đô thị, từ những gánh hàng rong đến quán nhỏ ven đường. Với hương vị mộc mạc, dễ ăn và giàu cảm giác thân thuộc, xôi xéo đã trở thành một phần ký ức ẩm thực của nhiều thế hệ.',
    N'Xoi xeo is a humble yet beloved Northern Vietnamese dish, especially common in Hanoi as a familiar breakfast choice. It consists of fragrant sticky rice, cooked mung bean that is mashed or pressed into slices, crispy fried shallots, and often a small amount of chicken fat or scallion oil for added richness. Although the ingredient list is simple, the dish stands out through the harmony between the chewy glutinous rice, the nutty taste of mung bean, and the unmistakable aroma of fried shallots.

The quality of the glutinous rice and the steaming technique are essential to a good serving of xoi xeo. The rice must be of high quality so that it cooks into distinct grains that are sticky but not mushy. The mung bean should be cooked just enough to preserve its natural richness without becoming dry. The shallots must be evenly golden, fragrant, and crisp, providing both aroma and texture. Some versions include pork floss, sausage, or egg for a more filling meal, but the traditional form with mung bean and fried shallots remains the most widely recognized.

Xoi xeo reflects the charm of Northern everyday cooking, where familiar ingredients can be transformed into something both comforting and refined. It is closely tied to the rhythm of morning life, from street vendors to small roadside shops. With its rustic flavor, satisfying texture, and sense of familiarity, xoi xeo has become part of the culinary memory of many generations.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'BAC_BO'),
    (SELECT TinhThanhID FROM dbo.TinhThanh WHERE MaTinh = 'HA_NOI'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KINH'),
    N'https://statics.vinpearl.com/xoi-xeo-01%20(2)_1632322118.jpg'
),
(
    'MIEN_LUON',
    N'Miến Lươn',
    N'Eel Glass Noodle Soup',
    N'Món nước',
    N'Noodle soup',
    N'Đậm đà đặc sản xứ Nghệ, phổ biến ở miền Bắc.',
    N'A rich eel noodle dish enjoyed in the North.',
    N'Miến lươn là món ăn được nhiều thực khách miền Bắc yêu thích nhờ hương vị đậm đà, thơm và giàu dinh dưỡng. Thành phần chính của món ăn là lươn đồng được sơ chế kỹ, làm sạch và chế biến thành lươn xào hoặc lươn chiên giòn, ăn cùng miến dong và nước dùng ninh ngọt. Món ăn có thể được phục vụ dưới dạng nước hoặc trộn, nhưng phiên bản nước thường tạo cảm giác tròn vị hơn khi kết hợp được vị ngọt của nước dùng với độ dai của miến và vị thơm béo của lươn.

Điểm đặc trưng của miến lươn nằm ở cách xử lý lươn để giữ được độ săn chắc, không tanh và giàu hương vị. Lươn thường được xào với hành, tiêu, nghệ hoặc một số gia vị khác để tạo màu và mùi thơm hấp dẫn. Miến dong có độ dai, trong và không quá nở, giúp cân bằng tốt với phần lươn. Rau thơm, hành lá, rau răm và tiêu xay thường được thêm vào để tăng hương vị và làm món ăn trở nên tròn đầy hơn.

Miến lươn là món ăn có tính linh hoạt cao, có thể dùng vào bữa sáng, bữa trưa hoặc bữa tối. Món ăn thể hiện sự khéo léo trong cách chế biến nguyên liệu đồng quê và khả năng tạo nên hương vị đậm đà từ những thành phần quen thuộc. Với mùi thơm đặc trưng, cấu trúc phong phú và giá trị dinh dưỡng cao, miến lươn đã trở thành một lựa chọn phổ biến trong đời sống ẩm thực miền Bắc.',
    N'Mien luon is a dish appreciated by many diners in Northern Vietnam for its rich flavor, aroma, and nutritional value. Its main ingredient is freshwater eel, carefully cleaned and prepared either as stir-fried eel or crispy fried eel, served with mung bean glass noodles and a naturally sweet broth. The dish may appear as either a soup or a dry mixed version, but the soup format often offers a more rounded experience by combining the sweetness of the broth, the chewiness of the noodles, and the rich fragrance of the eel.

Its defining feature lies in how the eel is handled to preserve firmness, remove any fishy smell, and enhance flavor. The eel is often stir-fried with shallots, pepper, turmeric, and selected seasonings to create an appealing aroma and color. The glass noodles are transparent, pleasantly chewy, and not overly swollen, which helps them pair well with the eel. Fresh herbs, scallions, Vietnamese coriander, and ground pepper are usually added to complete the dish.

Mien luon is highly versatile and can be enjoyed for breakfast, lunch, or dinner. It demonstrates skill in transforming countryside ingredients into a dish with bold flavor and satisfying depth. With its distinctive aroma, varied textures, and high nutritional value, mien luon has become a popular choice in Northern Vietnamese food culture.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'BAC_BO'),
    (SELECT TinhThanhID FROM dbo.TinhThanh WHERE MaTinh = 'HUE'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KINH'),
    N'https://i-giadinh.vnecdn.net/2022/11/10/Buoc-6-thanh-pham-6-4302-1668073404.jpg'
),
(
    'BUN_OC',
    N'Bún Ốc',
    N'Snail Vermicelli Soup',
    N'Món nước',
    N'Noodle soup',
    N'Chua thanh, đậm đà hương vị Bắc Bộ.',
    N'Tangy and distinctive Northern snail soup.',
    N'Bún ốc là món ăn đặc trưng của miền Bắc, nổi bật với vị chua thanh của nước dùng, độ giòn của ốc và hương thơm của các loại rau gia vị. Thành phần chính của món ăn là bún, ốc luộc hoặc ốc xào, cà chua, hành lá, tía tô và nước dùng được điều vị bằng giấm bỗng hoặc các nguyên liệu tạo chua truyền thống. Nước dùng của bún ốc thường không quá béo mà thiên về vị thanh, trong và thơm, giúp làm nổi bật vị ngọt tự nhiên của ốc.

Ốc dùng trong món ăn cần được làm sạch kỹ để giữ được vị thơm và độ giòn đặc trưng. Tùy cách chế biến, ốc có thể được luộc chín rồi để nguyên con hoặc xào sơ với gia vị để tăng độ đậm đà. Cà chua được dùng để tạo màu sắc và thêm vị chua nhẹ, trong khi các loại rau thơm như tía tô, hành lá và rau mùi giúp món ăn dậy mùi hơn. Khi ăn, nhiều người thích thêm ớt chưng hoặc chút mắm tôm để tăng hương vị theo khẩu vị cá nhân.

Bún ốc là món ăn dân dã nhưng rất có chiều sâu văn hóa, phản ánh cách người miền Bắc sử dụng nguyên liệu quen thuộc từ sông nước, ao hồ và đồng ruộng. Món ăn này vừa gần gũi, vừa có cá tính rõ ràng, đặc biệt phù hợp với những ai yêu thích vị thanh chua và cảm giác nhẹ bụng sau khi ăn. Trong đời sống ẩm thực thường nhật, bún ốc là một lựa chọn quen thuộc và giàu bản sắc.',
    N'Bun oc is a distinctive Northern Vietnamese dish known for its mildly sour broth, the crisp texture of snails, and the fragrance of fresh herbs. Its main components are rice vermicelli, boiled or stir-fried snails, tomatoes, scallions, perilla, and broth seasoned with rice vinegar or other traditional souring agents. The broth is usually light rather than fatty, allowing the natural sweetness of the snails to remain clear and prominent.

The snails must be thoroughly cleaned to preserve their aroma and characteristic firmness. Depending on the style, they may be simply boiled and served whole or lightly stir-fried with seasonings for extra depth. Tomatoes contribute color and gentle acidity, while herbs such as perilla, scallions, and cilantro add fragrance. Many diners also enjoy adding chili paste or a small amount of fermented shrimp paste according to personal preference.

Bun oc is a rustic dish with notable cultural depth, reflecting how Northern Vietnamese cooking makes use of familiar ingredients from ponds, rivers, and farmland. It is both approachable and highly distinctive, especially suitable for those who enjoy light sourness and a clean finish. In everyday food culture, bun oc remains a familiar and characterful choice.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'BAC_BO'),
    (SELECT TinhThanhID FROM dbo.TinhThanh WHERE MaTinh = 'HA_NOI'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KINH'),
    N'https://i-giadinh.vnecdn.net/2022/08/06/Thnhphm22-1659778295-5035-1659778478.jpg'
),
(
    'NEM_RAN',
    N'Nem Rán',
    N'Fried Spring Rolls',
    N'Món cuốn',
    N'Rolled dish',
    N'Giòn rụm, đậm đà và quen thuộc.',
    N'Crispy, savory, and familiar.',
    N'Nem rán là món ăn truyền thống rất phổ biến ở miền Bắc, thường xuất hiện trong mâm cơm gia đình, dịp lễ tết và những bữa cỗ quan trọng. Món ăn được làm từ bánh đa nem cuốn với nhân gồm thịt băm, miến, mộc nhĩ, nấm hương, cà rốt, hành tây và trứng, sau đó chiên vàng giòn. Nem rán hấp dẫn ở lớp vỏ giòn rụm bên ngoài và phần nhân mềm, thơm, đậm đà bên trong. Khi ăn, món này thường được dùng kèm rau sống và nước mắm pha chua ngọt, tạo nên sự cân bằng giữa độ béo, giòn và vị tươi mát.

Điểm làm nên sức hấp dẫn của nem rán là tỷ lệ phối trộn nguyên liệu trong phần nhân và kỹ thuật chiên. Nhân nem cần vừa đủ độ kết dính, không quá khô cũng không quá ướt để giữ được hình dáng và tạo cảm giác ngon miệng. Khi chiên, nem phải đạt màu vàng đều, lớp vỏ giòn mà không bị ngấm dầu quá nhiều. Nước chấm đi kèm cũng rất quan trọng, thường được pha từ nước mắm, đường, giấm hoặc chanh, tỏi và ớt để tạo hương vị hài hòa.

Nem rán không chỉ là món ăn ngon mà còn mang giá trị biểu tượng trong văn hóa ẩm thực gia đình miền Bắc. Món ăn này gắn với tinh thần sum họp, sự chuẩn bị công phu và niềm vui quây quần bên mâm cơm. Với hương vị đậm đà, hình thức đẹp mắt và khả năng phù hợp với nhiều dịp khác nhau, nem rán đã trở thành một món ăn quen thuộc và được yêu thích rộng rãi.',
    N'Nem ran is a traditional Northern Vietnamese dish commonly found at family meals, festive occasions, and important celebratory feasts. It is made by wrapping a filling of minced meat, glass noodles, wood ear mushrooms, shiitake, carrot, onion, and egg in thin rice paper wrappers, then frying until golden and crisp. The dish is appreciated for its crunchy exterior and its fragrant, savory, and tender filling. It is usually served with fresh herbs and a lightly sweet-and-sour fish sauce, creating balance between richness, crispness, and freshness.

Its appeal depends greatly on the filling ratio and frying technique. The filling should be cohesive but not too wet or too dry, so that each roll keeps its shape and remains satisfying to eat. During frying, the rolls should become evenly golden and crisp without absorbing too much oil. The dipping sauce is equally important and is typically made from fish sauce, sugar, vinegar or lime, garlic, and chili for a balanced flavor.

Nem ran is more than just a delicious dish; it carries symbolic value in Northern family food culture. It is closely tied to gatherings, careful preparation, and the joy of sharing food around the table. With its rich flavor, attractive appearance, and versatility across occasions, nem ran has become one of the most familiar and beloved dishes in Vietnamese cuisine.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'BAC_BO'),
    (SELECT TinhThanhID FROM dbo.TinhThanh WHERE MaTinh = 'HA_NOI'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KINH'),
    N'https://cooponline.vn/tin-tuc/wp-content/uploads/2025/12/cach-lam-nem-ran-mien-bac-chuan-vi-gion-lau-ngay-tet.jpg'
),
(
    'PHO_CUON',
    N'Phở Cuốn',
    N'Pho Rolls',
    N'Món cuốn',
    N'Rolled dish',
    N'Thanh mát, hiện đại nhưng vẫn đậm chất Hà Nội.',
    N'Fresh and distinctly Hanoi in style.',
    N'Phở cuốn là món ăn đặc trưng của Hà Nội, được phát triển từ nguyên liệu quen thuộc của món phở nhưng mang cách thưởng thức hoàn toàn khác. Thay vì dùng bánh phở với nước dùng nóng, phở cuốn sử dụng lá bánh phở bản lớn để cuộn thịt bò xào, rau thơm và xà lách thành từng cuốn gọn gàng. Món ăn thường được chấm với nước mắm pha nhẹ, tạo cảm giác thanh mát, dễ ăn và phù hợp với nhiều thời điểm trong ngày. Phở cuốn vừa giữ được nét quen thuộc của nguyên liệu truyền thống, vừa mang đến sự mới mẻ trong hình thức và trải nghiệm.

Điểm quan trọng của phở cuốn là chất lượng của lá bánh phở và phần nhân bò xào. Lá phở cần mềm, mịn nhưng đủ dai để không rách khi cuốn. Thịt bò thường được xào nhanh trên lửa lớn với tỏi và gia vị để giữ độ mềm ngọt. Rau thơm và xà lách tạo độ tươi, giúp cân bằng vị thịt. Nước chấm đóng vai trò kết nối, cần có vị mặn, ngọt, chua hài hòa mà không lấn át vị tự nhiên của phần cuốn.

Phở cuốn phản ánh khả năng sáng tạo của ẩm thực đô thị Hà Nội, nơi những nguyên liệu cũ có thể được biến đổi thành món ăn mới mà vẫn giữ được dấu ấn bản địa. Món ăn này được nhiều người yêu thích bởi sự nhẹ nhàng, thuận tiện và cảm giác sạch vị khi thưởng thức. Trong đời sống hiện đại, phở cuốn đã trở thành một lựa chọn phổ biến cho bữa nhẹ, bữa trưa hoặc những buổi gặp gỡ thân mật.',
    N'Pho cuon is a distinctive Hanoi dish developed from the familiar ingredients of pho but presented in a completely different way. Instead of serving rice noodles in hot broth, pho cuon uses wide sheets of fresh pho noodle to wrap stir-fried beef, herbs, and lettuce into neat rolls. The rolls are typically dipped in a lightly seasoned fish sauce, creating a fresh, clean, and approachable dish suitable for many times of day. Pho cuon preserves the recognizable ingredients of traditional pho while offering a new format and eating experience.

The quality of the noodle sheet and the beef filling is especially important. The noodle wrapper must be soft and smooth while still elastic enough not to tear. The beef is usually stir-fried quickly over high heat with garlic and seasonings to preserve tenderness and natural sweetness. Lettuce and herbs provide freshness and help balance the richness of the meat. The dipping sauce connects all the elements and should be balanced in saltiness, sweetness, and acidity without overpowering the roll itself.

Pho cuon reflects the creativity of Hanoi’s urban food culture, where familiar ingredients can be transformed into new dishes without losing local identity. It is widely appreciated for its lightness, convenience, and clean finish. In modern daily life, pho cuon has become a popular option for light meals, lunch, or casual gatherings.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'BAC_BO'),
    (SELECT TinhThanhID FROM dbo.TinhThanh WHERE MaTinh = 'HA_NOI'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KINH'),
    N'https://mms.img.susercontent.com/vn-11134513-7r98o-lsu9abg9fbfd2a@resize_ss1242x600!@crop_w1242_h600_cT0'
),
(
    'BANH_DUC_NONG',
    N'Bánh Đúc Nóng',
    N'Hot Savory Rice Cake',
    N'Món bánh',
    N'Rice cake',
    N'Mềm mượt, nóng hổi và đậm vị.',
    N'Soft, warm, and savory.',
    N'Bánh đúc nóng là món ăn dân dã phổ biến ở miền Bắc, thường được dùng như một bữa quà chiều hoặc bữa ăn nhẹ trong những ngày se lạnh. Phần bánh được làm từ bột gạo khuấy chín, có kết cấu mềm mượt, dẻo nhẹ và nóng hổi khi ăn. Món ăn thường được chan với nước mắm pha, thêm thịt băm xào mộc nhĩ, hành phi, rau mùi và đôi khi có cả đậu phụ hoặc tóp mỡ tùy cách chế biến. Sự kết hợp giữa phần bánh mềm, phần nhân đậm đà và nước chan nóng tạo nên cảm giác ấm áp, dễ chịu và rất đặc trưng.

Để bánh đúc nóng ngon, phần bột phải được khuấy đều tay để đạt độ sánh mịn, không vón cục và không quá đặc. Phần nhân thịt thường được xào vừa tới với mộc nhĩ để giữ độ thơm, không khô. Nước mắm pha phải nhẹ nhưng đủ vị để làm nổi bật phần bánh vốn có vị thanh. Hành phi vàng giòn và rau mùi là hai yếu tố nhỏ nhưng rất quan trọng trong việc hoàn thiện hương vị tổng thể của món ăn.

Bánh đúc nóng phản ánh nét đẹp của ẩm thực bình dân miền Bắc, nơi các món ăn đơn giản vẫn được chăm chút để tạo nên sự hài hòa và ngon miệng. Món ăn này không cầu kỳ về nguyên liệu nhưng lại mang đến cảm giác thân thuộc và ấm áp, đặc biệt phù hợp với tiết trời mát lạnh. Đây là một trong những món quà vặt truyền thống được nhiều người yêu thích bởi tính giản dị và dễ gợi nhớ.',
    N'Banh duc nong is a rustic Northern Vietnamese dish often enjoyed as an afternoon snack or a light meal on cool days. The cake itself is made from cooked rice flour batter, resulting in a soft, smooth, gently elastic texture that is served hot. It is usually topped with seasoned minced pork and wood ear mushrooms, fried shallots, cilantro, and a light fish sauce mixture, with some versions including tofu or pork cracklings. The contrast between the soft rice cake, savory topping, and warm sauce creates a comforting and distinctive experience.

For a good bowl of banh duc nong, the batter must be stirred carefully to achieve a smooth consistency without lumps and without becoming too thick. The meat topping should be cooked just enough with mushrooms to remain fragrant and moist. The sauce must be lightly seasoned but flavorful enough to bring out the subtle taste of the rice cake. Crispy shallots and cilantro, though simple, are essential in completing the dish.

Banh duc nong reflects the charm of Northern everyday cuisine, where simple dishes are prepared with care to create balance and satisfaction. It does not rely on luxurious ingredients, yet it offers warmth, familiarity, and comfort, especially in cooler weather. It remains one of the traditional snacks that many people appreciate for its simplicity and nostalgic appeal.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'BAC_BO'),
    (SELECT TinhThanhID FROM dbo.TinhThanh WHERE MaTinh = 'HA_NOI'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KINH'),
    N'https://i-giadinh.vnecdn.net/2024/11/02/Bc7Thnhphm17-1730530097-3638-1730530219.jpg'
),
(
    'GA_TAN',
    N'Gà Tần',
    N'Herbal Stewed Chicken',
    N'Món hầm',
    N'Stewed dish',
    N'Bổ dưỡng, thơm vị thuốc bắc.',
    N'Nourishing chicken stew with herbs.',
    N'Gà tần là món ăn bổ dưỡng phổ biến ở miền Bắc, thường được dùng như món bồi bổ sức khỏe hoặc món ăn nóng phù hợp với thời tiết se lạnh. Món ăn thường sử dụng gà ác hoặc gà nhỏ hầm cùng các vị thuốc bắc, hạt sen, táo tàu, ngải cứu hoặc một số nguyên liệu bổ dưỡng khác. Nước hầm có vị ngọt tự nhiên từ thịt gà, hòa với mùi thơm đặc trưng của thảo dược, tạo nên hương vị đậm nhưng không gắt. Món ăn vừa có giá trị dinh dưỡng, vừa mang đặc điểm của sự kết hợp giữa ẩm thực và kinh nghiệm bồi bổ trong dân gian.

Để món gà tần ngon, gà cần được làm sạch kỹ và hầm đủ thời gian để thịt mềm nhưng không nát. Các vị thuốc bắc phải được sử dụng với lượng phù hợp để tạo mùi thơm hài hòa, tránh lấn át vị tự nhiên của thịt. Ngải cứu thường được thêm vào để tăng hương thơm và tạo dấu ấn đặc trưng, dù một số người có thể điều chỉnh theo khẩu vị. Nước hầm là phần quan trọng nhất, cần trong, thơm và có chiều sâu vị ngọt.

Gà tần thường xuất hiện trong các quán ăn chuyên món bồi bổ, các bữa ăn gia đình hoặc những thời điểm cần món ăn nóng, giàu năng lượng. Món ăn phản ánh rõ một nhánh ẩm thực coi trọng yếu tố dưỡng thân, sử dụng nguyên liệu quen thuộc kết hợp cùng thảo dược để tạo nên giá trị vượt ra ngoài cảm giác no bụng. Trong đời sống ẩm thực miền Bắc, gà tần được xem là món ăn vừa ngon, vừa giàu ý nghĩa chăm sóc sức khỏe.',
    N'Ga tan is a nourishing Northern Vietnamese dish commonly enjoyed as a restorative meal or a warm dish suitable for cool weather. It is usually prepared with black chicken or a small chicken stewed together with medicinal herbs, lotus seeds, red dates, mugwort, and other nutritious ingredients. The broth carries a natural sweetness from the chicken combined with the characteristic aroma of herbs, resulting in a flavor that is rich but not harsh. The dish is valued not only for taste but also for its place at the intersection of food and traditional ideas of nourishment.

To prepare ga tan well, the chicken must be cleaned thoroughly and simmered long enough for the meat to become tender without falling apart. The medicinal herbs need to be used in balanced amounts so that their aroma complements rather than overwhelms the chicken. Mugwort is often included to add fragrance and a recognizable identity, though some versions adjust this according to taste. The broth is the most important element and should be clear, aromatic, and deeply sweet.

Ga tan is commonly found in eateries specializing in nourishing dishes, in family meals, or whenever a hot, energy-rich food is desired. It represents a branch of cuisine that values bodily well-being, using familiar ingredients together with herbs to create benefits beyond simple satiety. In Northern food culture, ga tan is regarded as both flavorful and meaningful as a dish associated with care and health.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'BAC_BO'),
    (SELECT TinhThanhID FROM dbo.TinhThanh WHERE MaTinh = 'HA_NOI'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KINH'),
    N'https://cdn2.fptshop.com.vn/unsafe/1920x0/filters:format(webp):quality(75)/2023_10_25_638338466426734307_ga-ham-ngai-cuu-thumb.JPG'
),
(
    'LAU_CUA_DONG',
    N'Lẩu Cua Đồng',
    N'Field Crab Hotpot',
    N'Món lẩu',
    N'Hotpot',
    N'Đậm đà vị đồng quê Bắc Bộ.',
    N'A rich Northern countryside crab hotpot.',
    N'Lẩu cua đồng là món ăn được nhiều người miền Bắc yêu thích, đặc biệt trong những buổi sum họp gia đình hoặc gặp gỡ bạn bè. Nước lẩu được nấu từ cua đồng giã lọc, tạo nên vị ngọt tự nhiên và hương thơm đặc trưng rất riêng. Thành phần ăn kèm thường khá phong phú, bao gồm thịt bò, đậu phụ, giò, rau xanh, nấm, bún và các loại rau dân dã như rau muống, mồng tơi hoặc hoa chuối. Phần riêu cua nổi lên trên mặt nước lẩu là điểm nhấn cả về hương vị lẫn hình thức, mang đến cảm giác đậm đà mà vẫn thanh sạch.

Điểm hấp dẫn của lẩu cua đồng nằm ở sự hòa quyện giữa vị ngọt cua, vị chua dịu từ cà chua hoặc giấm bỗng và độ tươi của các loại rau ăn kèm. Nước lẩu thường không quá nặng mà thiên về vị đậm vừa phải, rất phù hợp để ăn lâu và ăn cùng nhiều nguyên liệu khác nhau. Đậu phụ chiên, rau xanh và bún giúp tạo sự cân bằng, trong khi thịt bò hoặc giò góp phần làm món ăn trở nên đầy đặn hơn. Mỗi thành phần đều góp phần làm rõ hơn vị nền đặc trưng của cua đồng.

Lẩu cua đồng thể hiện rõ nét phong vị đồng quê Bắc Bộ, nơi nguyên liệu từ ruộng đồng được nâng lên thành món ăn giàu tính cộng đồng và rất gần gũi. Món lẩu này vừa phù hợp trong bữa ăn gia đình, vừa phổ biến trong không gian hàng quán truyền thống. Nhờ hương vị dân dã, dễ ăn nhưng vẫn có chiều sâu, lẩu cua đồng đã trở thành một lựa chọn quen thuộc trong ẩm thực miền Bắc.',
    N'Lau cua dong is a hotpot favored by many people in Northern Vietnam, especially for family gatherings and shared meals with friends. Its broth is made from pounded and strained field crab, producing a natural sweetness and a very distinctive aroma. The accompanying ingredients are often abundant, including beef, tofu, Vietnamese pork products, greens, mushrooms, rice noodles, and rustic vegetables such as water spinach, Malabar spinach, or banana blossom. The crab roe clusters rising to the surface of the broth serve as both a visual and flavorful highlight, offering richness without heaviness.

Its appeal lies in the balance between the sweetness of crab, the mild acidity from tomatoes or rice vinegar, and the freshness of the vegetables cooked alongside it. The broth is usually moderately rich rather than overpowering, which makes it suitable for long, shared meals with many ingredients. Fried tofu, vegetables, and noodles create balance, while beef or pork products make the meal more substantial. Each component contributes to emphasizing the characteristic crab-based flavor.

Lau cua dong clearly reflects the countryside identity of Northern Vietnam, where ingredients from fields and village life are transformed into a communal and comforting dish. It fits naturally into both home meals and traditional restaurants. Because of its rustic flavor, approachable taste, and layered character, field crab hotpot has become a familiar and much-loved choice in Northern cuisine.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'BAC_BO'),
    NULL,
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KINH'),
    N'https://cdn2.fptshop.com.vn/unsafe/1920x0/filters:format(webp):quality(75)/2023_12_12_638380074532719171_lau-cua-dong-hai-san-0.jpg'
),
(
    'BUN_CHA',
    N'Bún Chả',
    N'Bun Cha',
    N'Món khô',
    N'Grilled pork with noodles',
    N'Món đặc trưng Hà Nội.',
    N'A signature dish of Hanoi.',
    N'Bún chả là một trong những món ăn tiêu biểu nhất của ẩm thực Hà Nội, nổi bật với sự kết hợp hài hòa giữa bún tươi, thịt heo nướng và nước chấm pha theo kiểu chua ngọt nhẹ. Thành phần chính của món ăn thường gồm chả viên làm từ thịt heo xay và chả miếng từ thịt ba chỉ hoặc thịt vai thái mỏng, được tẩm ướp kỹ rồi nướng trên than hoa. Quá trình nướng giúp thịt có màu vàng nâu đẹp mắt, dậy mùi thơm đặc trưng và giữ được vị ngọt tự nhiên của thịt. Khi ăn, phần thịt nướng được cho vào bát nước chấm ấm cùng đu đủ xanh hoặc cà rốt ngâm chua nhẹ, sau đó dùng kèm với bún và nhiều loại rau sống như xà lách, rau mùi, kinh giới, húng và tía tô.

Điểm đặc sắc của bún chả không chỉ nằm ở phần thịt nướng mà còn ở bát nước chấm, yếu tố giữ vai trò kết nối toàn bộ các thành phần của món ăn. Nước chấm thường được pha từ nước mắm, đường, giấm hoặc chanh, tỏi và ớt theo tỷ lệ hài hòa để tạo vị mặn, ngọt, chua vừa phải. Không giống nhiều món bún nước khác, bún chả thiên về kiểu ăn kết hợp từng phần, giúp thực khách tự điều chỉnh lượng bún, thịt, rau và nước chấm theo sở thích riêng. Chính cách thưởng thức này tạo nên cảm giác linh hoạt, gần gũi nhưng vẫn rất chỉn chu và đặc trưng.

Trong đời sống ẩm thực miền Bắc, đặc biệt là ở Hà Nội, bún chả là món ăn phổ biến vào bữa trưa nhưng ngày nay có thể dùng vào nhiều thời điểm khác nhau trong ngày. Món ăn thể hiện rõ phong cách ẩm thực Bắc Bộ với xu hướng nêm nếm cân bằng, không quá cay, không quá ngọt nhưng vẫn đủ chiều sâu hương vị. Bún chả không chỉ là món ăn quen thuộc trong sinh hoạt hàng ngày mà còn là một trong những đại diện nổi bật của ẩm thực thủ đô, thường được giới thiệu đến du khách như một món ăn mang đậm bản sắc địa phương và giá trị truyền thống.',
    N'Bun cha is one of the most representative dishes of Hanoi cuisine, known for its harmonious combination of fresh rice vermicelli, grilled pork, and a lightly sweet-and-sour dipping sauce. The main protein components usually include minced pork patties and thin slices of pork belly or shoulder, both carefully marinated and grilled over charcoal. This grilling process gives the meat an appealing brown color, a smoky aroma, and preserves its natural sweetness. When served, the grilled pork is placed in a warm bowl of dipping sauce together with lightly pickled green papaya or carrot, and eaten with vermicelli and a variety of herbs such as lettuce, cilantro, Vietnamese balm, mint, and perilla.

The uniqueness of bun cha lies not only in the grilled pork but also in the dipping sauce, which acts as the central element that brings the whole dish together. The sauce is typically made from fish sauce, sugar, vinegar or lime, garlic, and chili, balanced carefully to create a gentle salty, sweet, and tangy taste. Unlike many Vietnamese noodle soups, bun cha is eaten by combining separate components, allowing diners to adjust the ratio of noodles, meat, herbs, and sauce according to personal preference. This style of eating makes the dish feel both flexible and refined.

In Northern Vietnamese food culture, especially in Hanoi, bun cha has traditionally been associated with lunch, though it is now enjoyed at many times of the day. The dish clearly reflects the culinary character of the North, where seasoning tends to be balanced, restrained, and layered rather than overly spicy or sweet. Bun cha is not only a familiar everyday food but also one of the most recognizable symbols of Hanoi cuisine, frequently recommended to visitors as a dish that embodies local identity and traditional value.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'BAC_BO'),
    (SELECT TinhThanhID FROM dbo.TinhThanh WHERE MaTinh = 'HA_NOI'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KINH'),
    N'https://i-giadinh.vnecdn.net/2023/04/16/Buoc-11-Thanh-pham-11-7068-1681636164.jpg'
),
(
    'BANH_MI',
    N'Bánh Mì',
    N'Vietnamese Baguette',
    N'Món bánh',
    N'Sandwich',
    N'Món ăn đường phố phổ biến và tiện lợi.',
    N'A popular and convenient street food.',
    N'Bánh mì là một trong những món ăn phổ biến nhất của Việt Nam, được yêu thích bởi tính tiện lợi, đa dạng và khả năng thích nghi với nhiều khẩu vị khác nhau. Về hình thức, bánh mì Việt Nam sử dụng ổ bánh vỏ mỏng, giòn, ruột xốp nhẹ, có nguồn gốc từ baguette nhưng đã được biến đổi để phù hợp với thói quen ăn uống trong nước. Phần nhân bên trong rất phong phú, có thể bao gồm pate, chả lụa, thịt nguội, thịt nướng, gà xé, trứng, dưa leo, rau mùi, đồ chua và các loại nước sốt. Sự kết hợp giữa lớp vỏ giòn, phần nhân đậm đà và rau củ tươi tạo nên một món ăn vừa nhanh gọn vừa giàu hương vị.

Điểm đặc sắc của bánh mì nằm ở tính linh hoạt trong cách chế biến. Mỗi địa phương, mỗi hàng quán và thậm chí mỗi gia đình có thể có một công thức nhân và cách nêm khác nhau. Có loại thiên về vị béo của pate và bơ, có loại nhấn mạnh hương thơm của thịt nướng, cũng có loại đơn giản chỉ gồm trứng, rau và nước sốt nhưng vẫn rất hấp dẫn. Đồ chua làm từ cà rốt và củ cải trắng, cùng rau mùi và ớt, thường đóng vai trò cân bằng vị giác, giúp món ăn không bị nặng mà vẫn giữ được sự tươi mát.

Bánh mì không chỉ là món ăn sáng quen thuộc mà còn là lựa chọn phổ biến cho bữa trưa, bữa xế hoặc những bữa ăn nhanh trong nhịp sống hiện đại. Trong bối cảnh ẩm thực Việt Nam, bánh mì thể hiện rõ khả năng tiếp biến văn hóa và sáng tạo trong sử dụng nguyên liệu. Từ một dạng bánh có ảnh hưởng ngoại lai, người Việt đã biến bánh mì thành món ăn mang đậm bản sắc riêng, đủ sức hiện diện trong đời sống hàng ngày lẫn trên bản đồ ẩm thực quốc tế như một đại diện tiêu biểu của ẩm thực đường phố Việt Nam.',
    N'Banh mi is one of the most popular foods in Vietnam, appreciated for its convenience, variety, and adaptability to different tastes. In form, Vietnamese banh mi uses a loaf with a thin, crisp crust and a light, airy interior, derived from the baguette but adapted to local eating habits. The filling is highly diverse and may include pate, Vietnamese pork sausage, cold cuts, grilled meat, shredded chicken, egg, cucumber, cilantro, pickled vegetables, and various sauces. The contrast between the crispy bread, savory fillings, and fresh vegetables creates a meal that is both practical and rich in flavor.

One of the defining features of banh mi is its flexibility in preparation. Each region, shop, and even household may have its own filling combinations and seasoning style. Some versions emphasize the richness of pate and butter, others highlight the aroma of grilled meats, and some remain simple with only egg, herbs, and sauce while still being highly satisfying. Pickled carrot and daikon, together with cilantro and chili, often help balance the richness and keep the overall taste fresh and lively.

Banh mi is not only a common breakfast item but also a popular choice for lunch, afternoon meals, or quick food in the rhythm of modern life. Within Vietnamese food culture, it clearly demonstrates the country’s ability to adapt outside influences and create something distinctly local. What began as a bread form inspired by foreign tradition has been transformed into a dish with a strong Vietnamese identity, recognized both in daily life and internationally as one of the most iconic expressions of Vietnamese street food.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'BAC_BO'),
    NULL,
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KINH'),
    N'https://luxuo.vn/wp-content/uploads/2024/03/banhmivietnam.jpeg'
),
(
    'BUN_BO_HUE',
    N'Bún Bò Huế',
    N'Hue Beef Noodle Soup',
    N'Món nước',
    N'Noodle soup',
    N'Đậm đà hương vị miền Trung, phổ biến trên cả nước.',
    N'A rich Central Vietnamese noodle soup enjoyed nationwide.',
    N'Bún bò Huế là món ăn nổi tiếng có nguồn gốc từ miền Trung Việt Nam, đặc biệt gắn liền với vùng đất cố đô Huế, nhưng ngày nay được ưa chuộng rộng rãi ở nhiều nơi, trong đó có miền Bắc. Món ăn nổi bật với nước dùng đậm đà, thơm mùi sả, có vị ngọt tự nhiên từ xương hầm và độ cay đặc trưng từ ớt. So với nhiều món bún nước khác, bún bò Huế thường tạo ấn tượng mạnh hơn về hương vị nhờ sự kết hợp giữa vị ngọt, vị cay, mùi thơm của sả và chiều sâu vị mắm ruốc được sử dụng với lượng vừa phải. Phần nước dùng có màu sắc hấp dẫn, thường ánh đỏ nhẹ từ dầu điều hoặc sa tế, tạo nên vẻ ngoài bắt mắt và giàu cảm giác ẩm thực.

Thành phần chính của bún bò Huế thường bao gồm sợi bún to, thịt bò, giò heo, chả cua hoặc chả Huế, ăn kèm với hành lá, rau thơm, giá đỗ, bắp chuối bào và các loại rau sống tùy nơi. Sợi bún to giúp món ăn có kết cấu rõ ràng hơn, phù hợp với nước dùng đậm vị. Thịt bò và giò heo mang lại độ ngọt, độ béo và cảm giác đầy đặn, trong khi rau sống giúp cân bằng vị giác. Từng thành phần trong tô bún đều có vai trò riêng, góp phần tạo nên tổng thể phong phú cả về hương vị lẫn cấu trúc.

Dù không phải món gốc của miền Bắc, bún bò Huế đã trở thành một phần quen thuộc trong đời sống ẩm thực đô thị trên cả nước. Món ăn thể hiện rõ sự đa dạng của ẩm thực Việt Nam, nơi các đặc sản vùng miền có thể lan tỏa mạnh mẽ và được tiếp nhận trong nhiều bối cảnh khác nhau. Với hương vị mạnh mẽ, đậm đà nhưng vẫn cân bằng, bún bò Huế thường được đánh giá là một trong những món bún tiêu biểu nhất của ẩm thực Việt Nam hiện đại.',
    N'Bun bo Hue is a famous Vietnamese dish originating from Central Vietnam, especially associated with the former imperial city of Hue, but it is now widely enjoyed throughout the country, including in the North. The dish is known for its rich broth scented with lemongrass, its natural sweetness from simmered bones, and its characteristic chili heat. Compared with many other Vietnamese noodle soups, bun bo Hue often makes a stronger impression because of the interplay between sweetness, spiciness, aromatic lemongrass, and the depth provided by a measured amount of fermented shrimp paste. The broth usually has an attractive reddish color from annatto oil or chili oil, giving the dish a vibrant and appetizing appearance.

The main components of bun bo Hue typically include thick round rice noodles, beef, pork hock, crab cake or Hue-style sausage, along with scallions, herbs, bean sprouts, shredded banana blossom, and other fresh vegetables depending on local custom. The thick noodles give the dish a more substantial texture that matches the strength of the broth. Beef and pork hock contribute sweetness, richness, and body, while the fresh vegetables help balance the overall taste. Each component plays a distinct role in creating a bowl that is both flavorful and texturally varied.

Although bun bo Hue is not originally a Northern dish, it has become a familiar part of urban food culture across Vietnam. It clearly reflects the diversity of Vietnamese cuisine, in which regional specialties can spread widely and find a place in many different settings. With its bold yet balanced flavor, bun bo Hue is often regarded as one of the most representative noodle soups in modern Vietnamese cuisine.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'TRUNG_BO'),
    (SELECT TinhThanhID FROM dbo.TinhThanh WHERE MaTinh = 'HUE'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KINH'),
    N'https://i.ytimg.com/vi/CSI9ildGX9s/maxresdefault.jpg'
),
(
    'BANH_CHUNG',
    N'Bánh Chưng',
    N'Square Sticky Rice Cake',
    N'Món bánh',
    N'Rice cake',
    N'Món bánh truyền thống gắn liền với Tết cổ truyền miền Bắc.',
    N'A traditional Northern Tet rice cake.',
    N'Bánh chưng là một trong những món ăn truyền thống tiêu biểu nhất của miền Bắc Việt Nam, đặc biệt gắn liền với Tết Nguyên Đán và các giá trị văn hóa gia đình. Bánh thường được làm từ gạo nếp, đỗ xanh và thịt heo, gói trong lá dong thành hình vuông rồi luộc trong nhiều giờ. Hình vuông của bánh chưng theo quan niệm dân gian tượng trưng cho đất, đồng thời cũng gắn với câu chuyện truyền thuyết về nguồn gốc bánh chưng bánh giầy trong kho tàng văn hóa Việt. Không chỉ là một món ăn, bánh chưng còn mang ý nghĩa biểu tượng về sự biết ơn tổ tiên, sự sum họp và niềm mong ước một năm mới đủ đầy.

Điểm đặc trưng của bánh chưng nằm ở cấu trúc chặt chẽ và sự hòa quyện giữa các lớp nguyên liệu. Lớp gạo nếp bên ngoài khi nấu chín trở nên dẻo mềm và thơm, phần đỗ xanh bên trong bùi và mịn, còn thịt heo mang lại vị béo đậm đà. Việc gói bánh đòi hỏi sự cẩn thận để bánh có hình vuông đều, chắc tay và không bị bục trong quá trình luộc. Luộc bánh là công đoạn kéo dài, yêu cầu canh lửa và nước liên tục để bánh chín kỹ, kết cấu ổn định và hương vị đạt độ hài hòa cao nhất.

Trong đời sống văn hóa miền Bắc, bánh chưng không thể thiếu trong mâm cỗ Tết, trên bàn thờ gia tiên và trong nhiều hoạt động chuẩn bị năm mới của gia đình. Việc cùng nhau rửa lá, vo gạo, gói bánh và thức đêm trông nồi bánh đã trở thành một phần ký ức tập thể của nhiều thế hệ. Bánh chưng vì vậy vừa là món ăn mang giá trị dinh dưỡng và hương vị, vừa là một biểu tượng sâu sắc của truyền thống, tình thân và bản sắc văn hóa Việt Nam.',
    N'Banh chung is one of the most representative traditional foods of Northern Vietnam, especially associated with the Lunar New Year and family cultural values. It is typically made from glutinous rice, mung beans, and pork, wrapped in dong leaves into a square shape and boiled for many hours. In traditional belief, its square form symbolizes the earth, and it is also connected to the legendary origin story of banh chung and banh day in Vietnamese cultural memory. More than just food, banh chung represents gratitude to ancestors, family reunion, and the hope for abundance in the new year.

Its distinctive quality lies in its compact structure and the harmony of its layers. The outer glutinous rice becomes soft, sticky, and fragrant after cooking, the mung bean filling is rich and smooth, and the pork provides a deep savory richness. Wrapping the cake requires precision so that it becomes evenly square, firm, and able to withstand long boiling without breaking apart. Boiling is a lengthy process that demands continuous attention to heat and water, ensuring the cake cooks thoroughly and achieves the proper texture and balance.

In Northern Vietnamese cultural life, banh chung is indispensable on Tet trays, ancestral altars, and in many family preparations for the new year. The process of washing leaves, rinsing rice, wrapping cakes, and staying up to watch the pot overnight has become part of the shared memory of many generations. For this reason, banh chung is valued not only for its flavor and nourishment but also as a powerful symbol of tradition, kinship, and Vietnamese cultural identity.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'BAC_BO'),
    NULL,
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KINH'),
    N'https://cdn.xanhsm.com/2025/01/62eda6b7-banh-chung-1.jpg'
),
(
    'BANH_TET',
    N'Bánh Tét',
    N'Cylindrical Sticky Rice Cake',
    N'Món bánh',
    N'Rice cake',
    N'Món bánh truyền thống phổ biến trong dịp lễ tết.',
    N'A traditional festive sticky rice cake.',
    N'Bánh tét là món bánh truyền thống phổ biến trong dịp lễ tết ở nhiều vùng của Việt Nam, có cấu trúc tương tự bánh chưng nhưng được gói theo hình trụ dài. Thành phần cơ bản thường gồm gạo nếp, đỗ xanh và thịt heo, gói trong lá chuối rồi luộc chín trong nhiều giờ. Khi cắt ra, bánh tạo thành các khoanh tròn đẹp mắt với lớp nếp bao quanh phần nhân ở giữa. Về hương vị, bánh tét có độ dẻo, bùi và béo tương tự các loại bánh nếp truyền thống khác, đồng thời mang cảm giác chắc tay, no lâu và phù hợp với không khí sum họp trong những ngày đặc biệt.

So với bánh chưng, bánh tét khác biệt chủ yếu ở hình thức và cách gói, nhưng cả hai đều phản ánh truyền thống sử dụng gạo nếp, đỗ xanh và thịt trong ẩm thực lễ nghi của người Việt. Một số phiên bản bánh tét có thể biến tấu với nhân chuối, đậu ngọt hoặc các thành phần khác, tuy nhiên phiên bản mặn với đỗ xanh và thịt vẫn là hình thức phổ biến nhất khi đưa vào hệ thống dữ liệu ẩm thực truyền thống. Việc gói bánh đòi hỏi kỹ thuật để bánh tròn đều, chắc, không bị bung khi luộc và có tỷ lệ nhân cân đối.

Trong bối cảnh dữ liệu văn hóa ẩm thực, bánh tét là món bánh có ý nghĩa biểu tượng cao, gắn với tính cộng đồng, truyền thống gia đình và nhịp sinh hoạt mùa lễ hội. Dù thường được nhắc đến nhiều ở miền Trung và miền Nam, bánh tét vẫn có thể xuất hiện trong hệ thống món ăn Việt tổng thể như một đại diện quan trọng của nhóm bánh nếp truyền thống dùng trong dịp tết. Món ăn này thể hiện sự bền vững của nếp sống ẩm thực truyền thống qua nhiều thế hệ.',
    N'Banh tet is a traditional festive rice cake widely prepared during holiday seasons in many regions of Vietnam. It is structurally similar to banh chung but wrapped in a long cylindrical form instead of a square shape. Its basic ingredients usually include glutinous rice, mung beans, and pork, all wrapped in banana leaves and boiled for many hours. When sliced, the cake forms attractive round sections with the sticky rice surrounding the filling at the center. In terms of flavor, banh tet shares the chewy, rich, and filling qualities of other traditional sticky rice cakes and is especially suited to festive gatherings.

Compared with banh chung, the main difference of banh tet lies in its shape and wrapping style, though both reflect the Vietnamese tradition of using glutinous rice, mung bean, and pork in ritual and celebratory cuisine. Some versions may vary with banana, sweet bean, or other fillings, but the savory version with mung beans and pork remains the most common form for a traditional culinary database. Wrapping the cake requires skill so that it remains evenly round, tightly packed, and stable during the long boiling process.

Within the context of culinary heritage, banh tet carries strong symbolic meaning connected to family, community, and festive life. Although it is more frequently associated with Central and Southern Vietnam, it still belongs in a broader Vietnamese food database as an important representative of traditional sticky rice cakes used during Tet. The dish demonstrates the endurance of Vietnamese festive food traditions across generations.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'NAM_BO'),
    NULL,
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KINH'),
    N'https://cdn-media.sforum.vn/storage/app/media/cach-goi-banh-tet-thumbnail.jpg'
),
(
    'BUN_CA_HAI_PHONG',
    N'Bún Cá Hải Phòng',
    N'Hai Phong Fish Noodle Soup',
    N'Món nước',
    N'Noodle soup',
    N'Đặc sản vùng biển với vị thanh ngọt và đậm đà.',
    N'A coastal specialty with sweet and savory flavor.',
    N'Bún cá Hải Phòng là món ăn đặc trưng của thành phố cảng Hải Phòng, nổi bật với nước dùng thanh ngọt từ cá và phần cá chiên hoặc cá rán thơm giòn. Thành phần chính của món ăn thường bao gồm bún, cá rô phi, cá thu hoặc một số loại cá phù hợp khác, cùng với dọc mùng, cà chua, rau cần hoặc hành lá tùy cách nấu. Nước dùng được ninh từ xương cá hoặc đầu cá để tạo vị ngọt tự nhiên, sau đó điều vị sao cho giữ được sự thanh nhẹ nhưng vẫn đủ đậm đà. So với nhiều món bún cá ở địa phương khác, bún cá Hải Phòng có dấu ấn riêng ở cách cân bằng giữa vị biển, vị rau và độ giòn của phần cá chiên.

Điểm hấp dẫn của món ăn này nằm ở sự tương phản về kết cấu. Bún mềm và nước dùng trong tạo nền nhẹ nhàng, trong khi miếng cá chiên lại mang đến độ giòn bên ngoài và vị ngọt chắc của thịt cá bên trong. Dọc mùng và cà chua giúp món ăn có thêm độ thanh, vị chua nhẹ và cảm giác tươi mát. Một số cách phục vụ còn thêm chả cá, hành phi hoặc rau sống để tăng hương vị và chiều sâu cho món ăn. Từng yếu tố kết hợp lại tạo nên một tô bún có bản sắc rõ ràng, vừa dân dã vừa hấp dẫn.

Trong văn hóa ẩm thực vùng duyên hải Bắc Bộ, bún cá Hải Phòng là đại diện tiêu biểu cho khả năng khai thác nguyên liệu thủy sản theo cách gần gũi và tinh tế. Món ăn này phổ biến từ bữa sáng đến bữa trưa, được nhiều thực khách yêu thích bởi vị dễ ăn, không quá nặng nhưng vẫn giàu hương vị. Với giá trị địa phương rõ nét, bún cá Hải Phòng là một món ăn nên có trong nhóm đặc sản miền Bắc của cơ sở dữ liệu ẩm thực.',
    N'Hai Phong fish noodle soup is a specialty of the port city of Hai Phong, recognized for its naturally sweet fish broth and its fragrant, crispy fried fish. The dish usually includes rice vermicelli, fish such as tilapia, mackerel, or other suitable varieties, along with taro stems, tomatoes, celery, or scallions depending on the preparation style. The broth is made by simmering fish bones or fish heads to extract natural sweetness, then seasoned carefully to remain light yet flavorful. Compared with other fish noodle soups in Vietnam, the Hai Phong version stands out for the way it balances seafood flavor, vegetables, and the crispy texture of fried fish.

One of its most appealing qualities is the contrast in texture. The soft noodles and clear broth create a gentle base, while the fried fish adds a crisp exterior and firm, sweet flesh inside. Taro stems and tomatoes contribute freshness, mild acidity, and a cleaner overall taste. Some versions also include fish cake, fried shallots, or fresh herbs to deepen the flavor. Together, these elements create a bowl that is rustic, satisfying, and regionally distinctive.

In the culinary culture of Northern coastal Vietnam, Hai Phong fish noodle soup is a strong example of how seafood can be used in a simple yet refined way. It is commonly enjoyed from breakfast through lunch and is appreciated for being easy to eat, not overly heavy, yet still full of character. Because of its clear regional identity, it deserves a place among the notable Northern specialties in a Vietnamese food database.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'BAC_BO'),
    (SELECT TinhThanhID FROM dbo.TinhThanh WHERE MaTinh = 'HAI_PHONG'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KINH'),
    N'https://statics.vinpearl.com/bun-ca-hai-phong-10_1628521389.jpg'
),
(
    'THIT_DE_NUI',
    N'Thịt Dê Núi',
    N'Mountain Goat Meat',
    N'Món thịt',
    N'Meat dish',
    N'Đặc sản nổi tiếng của vùng núi đá vôi.',
    N'A famous specialty of limestone mountain regions.',
    N'Thịt dê núi là món ăn nổi tiếng gắn với các vùng núi đá vôi, đặc biệt được biết đến nhiều qua ẩm thực Ninh Bình. Dê được chăn thả trên địa hình đồi núi, vận động nhiều nên thịt thường săn chắc, ít mỡ và có hương vị đậm đà hơn so với dê nuôi nhốt thông thường. Từ nguyên liệu này, người ta có thể chế biến thành nhiều món như dê tái chanh, dê hấp, dê nướng, dê xào lăn hoặc dê nhúng mẻ. Mỗi cách chế biến làm nổi bật một khía cạnh khác nhau của thịt dê, nhưng nhìn chung đều hướng tới việc giữ độ ngọt, độ săn và mùi thơm tự nhiên của nguyên liệu.

Một trong những điểm đáng chú ý của thịt dê núi là khả năng kết hợp tốt với các loại gia vị và rau ăn kèm mang tính cân bằng, như gừng, sả, riềng, tía tô, lá mơ, chanh hoặc tương gừng. Do thịt dê có mùi đặc trưng, việc sơ chế và nêm nếm đòi hỏi kinh nghiệm để làm nổi bật ưu điểm mà không để mùi quá nồng. Trong nhiều nhà hàng và quán ăn đặc sản, thịt dê núi thường được phục vụ cùng cơm cháy, rau thơm và các loại nước chấm riêng, tạo thành một trải nghiệm ẩm thực khá hoàn chỉnh.

Trong cơ sở dữ liệu món ăn miền Bắc, thịt dê núi là một đại diện tiêu biểu cho nhóm món ăn từ nguyên liệu địa phương mang tính đặc sản vùng. Món ăn này không chỉ hấp dẫn bởi hương vị mà còn bởi sự gắn bó với điều kiện tự nhiên và phương thức chăn nuôi đặc trưng. Nhờ đó, thịt dê núi được xem là món ăn có giá trị nhận diện địa phương rõ rệt, đồng thời thể hiện sự phong phú của ẩm thực miền Bắc Việt Nam.',
    N'Mountain goat meat is a well-known dish associated with limestone mountain regions, especially recognized through the cuisine of Ninh Binh. Goats raised on rocky hillsides are more active, so their meat is often firmer, leaner, and more flavorful than that of stall-raised goats. From this ingredient, many dishes can be prepared, including lightly cooked goat with lime, steamed goat, grilled goat, stir-fried goat, or goat cooked in fermented rice broth. Each method highlights a different quality of the meat, but all generally aim to preserve its natural sweetness, firmness, and aroma.

One of the notable qualities of mountain goat meat is how well it pairs with balancing herbs and seasonings such as ginger, lemongrass, galangal, perilla, lime, and ginger-based dipping sauces. Because goat has a distinctive aroma, preparation and seasoning require experience in order to bring out its strengths without making the smell too strong. In many specialty restaurants, mountain goat is served with scorched rice, herbs, and dedicated dipping sauces, creating a more complete culinary experience.

In a Northern Vietnamese food database, mountain goat meat is a representative example of a regional specialty built around local ingredients. It is valued not only for its taste but also for its close connection to the natural landscape and traditional raising methods. For that reason, mountain goat meat stands as a dish with strong local identity and as an illustration of the diversity of Northern Vietnamese cuisine.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'BAC_BO'),
    (SELECT TinhThanhID FROM dbo.TinhThanh WHERE MaTinh = 'NINH_BINH'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KINH'),
    N'https://cdn.xanhsm.com/2025/03/f81a4c53-de-nui-chop-chai-1.jpg'
),
(
    'BUN_THANG',
    N'Bún Thang',
    N'Bun Thang',
    N'Món nước',
    N'Noodle soup',
    N'Món bún thanh nhã của Hà Nội.',
    N'A refined Hanoi noodle soup.',
    N'Bún thang là món ăn truyền thống nổi tiếng của Hà Nội, được biết đến như một đại diện tiêu biểu cho sự tinh tế và cầu kỳ trong ẩm thực miền Bắc. Một bát bún thang đúng kiểu thường được tạo nên từ nhiều thành phần được chuẩn bị kỹ lưỡng như bún sợi nhỏ, thịt gà xé, trứng gà tráng mỏng thái chỉ, giò lụa thái sợi, củ cải khô, nấm hương và rau thơm. Nước dùng của bún thang thường trong, ngọt thanh, được nấu từ xương gà hoặc xương heo, nêm nếm nhẹ để làm nổi bật vị tự nhiên của nguyên liệu. Điểm đặc biệt của món ăn không nằm ở sự đậm mạnh mà ở sự hài hòa, thanh tao và cân bằng trong từng thành phần.

Bún thang đòi hỏi sự chỉn chu ngay từ khâu sơ chế nguyên liệu. Trứng phải được tráng thật mỏng và thái thành sợi nhỏ đều, thịt gà xé vừa tay, giò lụa cắt gọn, các loại rau và gia vị đi kèm cũng phải được chuẩn bị cẩn thận. Trong một số cách chế biến truyền thống, bún thang còn được thêm một chút mắm tôm hoặc tinh dầu cà cuống để tăng chiều sâu hương vị, tuy nhiên lượng sử dụng thường rất tiết chế. Chính sự cầu kỳ và kỹ thuật chế biến này khiến bún thang thường được xem là món ăn thể hiện rõ phong cách thanh lịch của ẩm thực Tràng An.

Không chỉ có giá trị về mặt hương vị, bún thang còn phản ánh nếp sống ẩm thực coi trọng sự tinh xảo, gọn gàng và hài hòa của người Hà Nội xưa. Món ăn thường xuất hiện trong các dịp sum họp gia đình, những ngày sau Tết hoặc trong những bữa ăn cần sự trang nhã và đặc biệt. Ngày nay, bún thang vẫn được nhiều thực khách yêu thích bởi hương vị nhẹ nhàng, thanh sạch và chiều sâu văn hóa mà món ăn mang lại.',
    N'Bun thang is a traditional Hanoi dish often regarded as one of the clearest expressions of refinement in Northern Vietnamese cuisine. A proper bowl of bun thang is composed of many carefully prepared elements, including thin rice vermicelli, shredded chicken, very thin strips of fried egg, sliced Vietnamese pork sausage, dried radish, shiitake mushrooms, and fresh herbs. Its broth is light, clear, and naturally sweet, usually made from chicken or pork bones and seasoned gently so that the natural taste of the ingredients remains prominent. The defining quality of the dish is not intensity, but balance, elegance, and subtle harmony.

Preparing bun thang requires considerable attention to detail. The egg must be cooked into a very thin sheet and cut into delicate strips, the chicken must be finely shredded, the pork sausage sliced evenly, and the accompanying herbs and seasonings arranged with care. In some traditional versions, a small amount of fermented shrimp paste or the essence of ca cuong is added to deepen the aroma, though always in a restrained manner. This precision in preparation is one reason bun thang is often seen as a culinary symbol of old Hanoi’s sophistication.

Beyond its taste, bun thang reflects a food culture that values neatness, delicacy, and balance. It is commonly associated with family gatherings, post-Tet meals, or occasions that call for a graceful and special dish. Today, bun thang continues to be appreciated for its gentle flavor, clean finish, and the cultural depth it represents.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'BAC_BO'),
    (SELECT TinhThanhID FROM dbo.TinhThanh WHERE MaTinh = 'HA_NOI'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KINH'),
    N'https://i-giadinh.vnecdn.net/2023/02/02/Thanh-pham-1-1-5769-1675329999.jpg'
),
(
    'VIT_QUAY_LANG_SON',
    N'Vịt Quay Lạng Sơn',
    N'Lang Son Roasted Duck',
    N'Món quay',
    N'Roasted dish',
    N'Đặc sản vùng Đông Bắc với hương vị riêng biệt.',
    N'A Northeastern specialty with a distinctive flavor.',
    N'Vịt quay Lạng Sơn là món ăn nổi tiếng của vùng Đông Bắc Việt Nam, đặc biệt được biết đến nhờ hương vị đậm đà và mùi thơm rất riêng từ lá mắc mật. Vịt sau khi làm sạch được tẩm ướp kỹ với gia vị, trong đó mắc mật là thành phần quan trọng tạo nên bản sắc đặc trưng. Sau khi ướp, vịt được quay cho đến khi da vàng nâu, bóng đẹp và giòn nhẹ, trong khi phần thịt bên trong vẫn giữ được độ mềm, ngọt và không bị khô. Món ăn thường được dùng nguyên con hoặc chặt miếng, phù hợp trong bữa cơm gia đình lẫn các dịp tiếp khách.

Điểm khác biệt của vịt quay Lạng Sơn so với nhiều kiểu vịt quay khác nằm ở mùi hương của mắc mật và cách xử lý gia vị để tạo nên hương vị vừa đậm đà vừa thanh thoát. Mắc mật không chỉ làm tăng mùi thơm mà còn giúp át bớt mùi đặc trưng của vịt, đồng thời để lại hậu vị dễ nhận biết. Phần nước tiết ra từ vịt trong quá trình quay cũng thường được giữ lại làm nước chấm hoặc chan nhẹ khi ăn, góp phần tăng chiều sâu hương vị. Món ăn thường được dùng kèm bánh bao chiên, dưa góp hoặc rau sống tùy nơi.

Trong văn hóa ẩm thực miền núi phía Bắc, vịt quay Lạng Sơn là đại diện rõ nét cho cách sử dụng nguyên liệu địa phương để tạo nên món ăn mang bản sắc vùng miền rất mạnh. Món ăn này vừa có giá trị ẩm thực, vừa có tính nhận diện địa phương cao, thường được nhắc đến như một đặc sản tiêu biểu khi nói về ẩm thực Lạng Sơn. Với hương vị đặc trưng, hình thức hấp dẫn và chiều sâu văn hóa vùng miền, vịt quay Lạng Sơn là món ăn rất phù hợp để đưa vào nhóm đặc sản miền Bắc.',
    N'Lang Son roasted duck is a famous dish from Northeastern Vietnam, especially known for its rich flavor and the distinctive aroma of mac mat leaves. After cleaning, the duck is carefully marinated with seasonings, among which mac mat is the key ingredient that creates its characteristic identity. The duck is then roasted until the skin becomes glossy, brown, and lightly crisp, while the meat remains tender, juicy, and flavorful inside. It may be served whole or chopped into pieces, making it suitable for both family meals and special occasions.

What sets Lang Son roasted duck apart from other roasted duck styles is the fragrance of mac mat and the way the seasoning is handled to produce a flavor that is both rich and elegant. Mac mat not only enhances aroma but also softens the gamey character of duck and leaves a memorable aftertaste. The juices released during roasting are often retained as a dipping sauce or drizzled lightly when serving, adding further depth. Depending on local custom, the dish may be accompanied by fried buns, pickled vegetables, or fresh herbs.

In the culinary culture of Northern mountain regions, Lang Son roasted duck is a strong example of how local ingredients are used to create food with powerful regional identity. The dish has both gastronomic value and strong local recognition, often mentioned as one of the leading specialties of Lang Son. Because of its distinctive taste, appealing appearance, and cultural depth, it is highly suitable for inclusion among Northern Vietnamese specialties.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'BAC_BO'),
    (SELECT TinhThanhID FROM dbo.TinhThanh WHERE MaTinh = 'LANG_SON'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KINH'),
    N'https://media-cdn-v2.laodong.vn/storage/newsportal/2024/1/23/1296243/Vit-Quay.jpg'
),
(
    'BANH_TAM_GIAC_MACH',
    N'Bánh Tam Giác Mạch',
    N'Buckwheat Cake',
    N'Món bánh',
    N'Cake',
    N'Đặc sản vùng cao gắn với hạt tam giác mạch.',
    N'A highland specialty made from buckwheat.',
    N'Bánh tam giác mạch là món ăn đặc trưng của vùng núi phía Bắc, đặc biệt gắn với những nơi trồng nhiều cây tam giác mạch như Hà Giang. Nguyên liệu chính của món ăn là hạt tam giác mạch sau khi thu hoạch được xay thành bột, nhào và tạo thành bánh. Bánh có thể được nướng trên than, áp chảo hoặc hấp tùy cách chế biến, tạo nên kết cấu mềm hoặc hơi giòn nhẹ bên ngoài. Hương vị của bánh thường bùi, thơm, có vị ngọt nhẹ tự nhiên và gợi cảm giác mộc mạc, gần gũi với đời sống vùng cao.

Khác với nhiều loại bánh làm từ gạo hoặc bột mì, bánh tam giác mạch mang dấu ấn rất riêng của nguyên liệu bản địa. Hạt tam giác mạch vốn được trồng ở vùng núi đá với khí hậu đặc thù, vì vậy món bánh làm ra không chỉ mang giá trị dinh dưỡng mà còn phản ánh điều kiện tự nhiên và tập quán canh tác của cư dân miền núi. Một số phiên bản có thể thêm đường, mật hoặc kết hợp với các nguyên liệu khác, nhưng bản chất của món ăn vẫn là sự mộc mạc và nhấn mạnh hương vị nguyên liệu gốc.

Trong bối cảnh văn hóa ẩm thực, bánh tam giác mạch không chỉ là món ăn mà còn là một phần của hình ảnh du lịch và bản sắc vùng cao phía Bắc. Món bánh thường được nhắc đến cùng với mùa hoa tam giác mạch, chợ phiên và sinh hoạt đời thường của đồng bào địa phương. Nhờ vẻ giản dị nhưng có tính biểu tượng cao, bánh tam giác mạch là một đại diện phù hợp cho nhóm món ăn mang đậm dấu ấn miền núi phía Bắc trong cơ sở dữ liệu ẩm thực.',
    N'Buckwheat cake is a specialty of Northern highland regions, especially associated with areas where buckwheat is widely grown, such as Ha Giang. Its main ingredient is buckwheat seed, which is harvested, ground into flour, kneaded, and shaped into cakes. The cakes may be grilled over charcoal, pan-cooked, or steamed depending on local preparation, resulting in textures that range from soft to lightly crisp on the outside. Their flavor is typically nutty, aromatic, mildly sweet, and strongly connected to the rustic character of mountain life.

Unlike many cakes made from rice or wheat flour, buckwheat cake carries the distinct identity of a local highland crop. Buckwheat is cultivated in rocky mountain areas with specific climate conditions, so the cake reflects not only nutritional value but also the environment and agricultural practices of mountain communities. Some versions may include sugar, syrup, or other ingredients, but the essence of the dish remains its simplicity and its emphasis on the natural taste of the grain.

In culinary and cultural context, buckwheat cake is more than just food; it is also part of the tourism image and cultural identity of Northern upland regions. The cake is often associated with buckwheat flower season, local markets, and the everyday life of ethnic communities. Because of its simple form yet symbolic value, buckwheat cake is a fitting representative of Northern mountain cuisine in a Vietnamese culinary database.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'BAC_BO'),
    (SELECT TinhThanhID FROM dbo.TinhThanh WHERE MaTinh = 'LAO_CAI'), -- Đã sửa theo list 34 tỉnh
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'HMONG'),
    N'https://images.baodantoc.vn/uploads/2021/Th%C3%A1ng_12/Ng%C3%A0y_22/Oanh/banh%20tam%20giac%20mach/Banh-tam-giac-mach-nuong.jpg'
),
(
    'XOI_NGU_SAC',
    N'Xôi Ngũ Sắc',
    N'Five-color Sticky Rice',
    N'Món xôi',
    N'Sticky rice',
    N'Món xôi truyền thống của đồng bào miền núi phía Bắc.',
    N'A traditional sticky rice dish of Northern highland communities.',
    N'Xôi ngũ sắc là món ăn truyền thống phổ biến trong nhiều cộng đồng dân tộc ở miền núi phía Bắc. Món xôi được làm từ gạo nếp, nhuộm màu bằng các loại lá, củ và cây rừng tự nhiên để tạo nên năm màu đặc trưng như đỏ, vàng, tím, xanh và trắng. Mỗi màu sắc thường gắn với quan niệm về ngũ hành, mùa màng hoặc những lời chúc tốt lành trong đời sống tinh thần của người dân địa phương. Không chỉ gây ấn tượng về mặt thị giác, xôi ngũ sắc còn mang đậm ý nghĩa văn hóa, thể hiện mối liên hệ giữa ẩm thực, thiên nhiên và tín ngưỡng dân gian.

Điểm đặc biệt của xôi ngũ sắc nằm ở cách tạo màu hoàn toàn từ nguyên liệu tự nhiên. Tùy từng cộng đồng và vùng cư trú, các loại lá và củ được sử dụng có thể khác nhau, nhưng đều hướng đến việc tạo màu đẹp mà vẫn an toàn, thơm và giữ được hương vị nếp. Gạo nếp sau khi ngâm màu được đồ chín riêng từng phần hoặc phối hợp theo cách truyền thống để khi hoàn thành, xôi có màu sắc rõ ràng, hạt dẻo, thơm và không bị lẫn màu quá mức. Nhờ kỹ thuật này, món ăn vừa đẹp mắt vừa giữ được chất lượng ẩm thực.

Xôi ngũ sắc thường xuất hiện trong các dịp lễ tết, cưới hỏi, lễ hội và những sự kiện quan trọng của cộng đồng. Đây không chỉ là món ăn để dùng trong bữa ăn mà còn là biểu hiện của sự khéo léo, tinh thần cộng đồng và quan niệm thẩm mỹ truyền thống. Trong cơ sở dữ liệu món ăn miền Bắc, xôi ngũ sắc là một món rất có giá trị đại diện cho nhóm ẩm thực dân tộc vùng cao, vừa giàu bản sắc vừa có chiều sâu văn hóa.',
    N'Five-color sticky rice is a traditional dish commonly found among many ethnic communities in the Northern highlands of Vietnam. It is made from glutinous rice dyed with natural leaves, roots, and forest plants to produce five characteristic colors such as red, yellow, purple, green, and white. Each color is often associated with ideas about the five elements, agricultural hopes, or wishes for good fortune in local spiritual life. Beyond its visual appeal, the dish carries strong cultural meaning and reflects the connection between food, nature, and folk belief.

Its special feature lies in the fact that the colors are created entirely from natural ingredients. Depending on the community and region, the leaves and roots used may vary, but all are selected to produce attractive colors while remaining safe, fragrant, and compatible with the flavor of the rice. The glutinous rice is soaked separately in these natural color extracts and steamed according to traditional methods so that each color remains distinct, the grains stay glossy and sticky, and the final dish is both beautiful and appetizing. This technique allows the dish to combine aesthetics with culinary quality.

Five-color sticky rice is commonly prepared for festivals, weddings, New Year celebrations, and other important community events. It is not only a food item but also an expression of skill, community identity, and traditional aesthetics. In a Northern Vietnamese food database, it serves as a highly representative dish of highland ethnic cuisine, valued for both its cultural depth and distinctive appearance.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'BAC_BO'),
    (SELECT TinhThanhID FROM dbo.TinhThanh WHERE MaTinh = 'LAO_CAI'), -- Gán về Lào Cai (Số thứ tự 19 trong list 34 tỉnh)
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'TAY'),
    N'https://bcp.cdnchinhphu.vn/334894974524682240/2023/12/29/xoi-ngu-sac-17038345960721295567211.jpg'
),
(
    'BUN_THANG_LUON_PHO_HIEN',
    N'Bún Thang Lươn Phố Hiến',
    N'Pho Hien Eel Bun Thang',
    N'Món nước',
    N'Noodle soup',
    N'Đặc sản Hưng Yên với hương vị thanh mà đậm.',
    N'A Hung Yen specialty with a clear yet rich flavor.',
    N'Bún thang lươn Phố Hiến là một món ăn đặc sản gắn với vùng Phố Hiến, Hưng Yên, thường được nhắc đến như một biến thể riêng giàu bản sắc của bún thang miền Bắc. Nếu bún thang Hà Nội nổi tiếng bởi sự cầu kỳ, thanh nhã và tinh tế trong từng thành phần, thì bún thang lươn Phố Hiến lại tạo dấu ấn bằng cách kết hợp cấu trúc thanh trong của món bún thang với vị đậm đà, thơm ngọt và có phần dân dã hơn từ lươn. Theo nhiều mô tả ẩm thực, món ăn này sử dụng bún, nước dùng trong, cùng nhiều thành phần ăn kèm như lươn, trứng thái sợi, chả hoặc các topping quen thuộc của bún thang, tạo nên một tổng thể vừa quen vừa lạ, vừa có nét thanh tao vừa mang sắc thái đồng quê rõ rệt.

Điểm làm nên bản sắc riêng của bún thang lươn Phố Hiến nằm ở phần lươn và cách tổ chức hương vị. Lươn thường là nguyên liệu trung tâm, được sơ chế kỹ để giữ độ thơm, độ chắc của thịt và hạn chế mùi tanh, sau đó có thể được xào, làm chín kỹ hoặc chế biến theo hướng tạo độ đậm cho tô bún. Một số mô tả về món ăn còn cho thấy bún thang lươn Phố Hiến có thể kết hợp thêm trứng thái chỉ, bún sợi nhỏ, chả, thậm chí có nơi nhắc tới cua bể như một thành phần làm tăng độ phong phú cho tô bún. Nước dùng thường được đánh giá là trong, ngọt thanh nhưng vẫn có chiều sâu, giúp cân bằng phần topping khá đậm vị. Chính sự hòa quyện giữa nước dùng nhẹ, bún mềm và phần lươn giàu hương vị đã khiến món ăn này trở nên khác biệt so với nhiều món bún nước khác.

Về mặt trải nghiệm ẩm thực, bún thang lươn Phố Hiến mang lại cảm giác nhiều tầng vị. Người ăn có thể cảm nhận độ thanh đầu tiên từ nước dùng, sau đó là vị ngọt và thơm của lươn, rồi đến sự mềm mượt của bún cùng các thành phần phụ trợ như trứng, chả và rau thơm. Đây là kiểu món ăn vừa có sự chỉn chu trong cấu trúc, vừa giữ được chất gần gũi của ẩm thực địa phương. Món ăn thường được nhắc đến như một đại diện thú vị của ẩm thực Hưng Yên, cho thấy khả năng tiếp nhận, biến đổi và làm giàu thêm từ một món ăn vốn đã rất nổi tiếng là bún thang.

Trong cơ sở dữ liệu ẩm thực miền Bắc, bún thang lươn Phố Hiến là món ăn có giá trị nhận diện địa phương khá rõ. Nó không chỉ phản ánh đặc trưng ẩm thực của Hưng Yên mà còn cho thấy cách một món ăn truyền thống có thể được biến tấu để mang bản sắc vùng miền riêng mà vẫn giữ được nền tảng văn hóa gốc. Với sự kết hợp giữa tính cầu kỳ, hương vị đậm đà và dấu ấn địa phương, bún thang lươn Phố Hiến là một món ăn phù hợp để xếp vào nhóm đặc sản miền Bắc có chiều sâu văn hóa và khả năng ghi nhớ cao đối với thực khách.',
    N'Pho Hien eel bun thang is a specialty associated with Pho Hien in Hung Yen Province and is often described as a distinctive regional variation of Northern Vietnamese bun thang. While Hanoi bun thang is widely known for its refinement, delicate balance, and carefully prepared toppings, the Pho Hien eel version stands out by combining that elegant structure with the richer, sweeter, and more rustic character of eel. Descriptions of the dish commonly mention fine rice noodles, a clear broth, and assorted toppings such as eel, thin strips of egg, sausage or other traditional bun thang components, creating a bowl that feels both familiar and unique, refined yet strongly rooted in the countryside character of the Red River Delta.

Its defining identity lies in the eel and the way the flavors are arranged. Eel serves as the central ingredient and is typically prepared with care so that the flesh remains fragrant, firm, and free of any undesirable smell. It may be stir-fried, cooked thoroughly, or otherwise seasoned to contribute a deeper savory note to the bowl. Some culinary descriptions also indicate that Pho Hien eel bun thang may include thin egg strips, small rice noodles, Vietnamese sausage, and in certain versions even crab as an added topping, making the bowl more layered and substantial. The broth is usually described as clear and naturally sweet, yet deep enough in flavor to support the richer toppings. This balance between a light broth, soft noodles, and flavorful eel is what sets the dish apart from many other Vietnamese noodle soups.

In terms of eating experience, Pho Hien eel bun thang offers several layers of taste. The first impression often comes from the clean and gentle broth, followed by the sweetness and aroma of eel, then the smooth texture of the noodles and the supporting elements such as egg, sausage, and herbs. It is a dish that combines structural care with local warmth. For that reason, it is frequently mentioned as an interesting representative of Hung Yen cuisine, showing how a well-known traditional dish like bun thang can be adapted and enriched through regional culinary identity.

Within a Northern Vietnamese food database, Pho Hien eel bun thang has strong local recognition value. It reflects not only the food character of Hung Yen but also the broader Vietnamese ability to reinterpret traditional dishes while preserving their cultural foundation. With its combination of refinement, savory depth, and clear regional personality, Pho Hien eel bun thang is well suited to be classified among Northern specialties that carry both cultural depth and memorable culinary character.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'BAC_BO'),
    (SELECT TinhThanhID FROM dbo.TinhThanh WHERE MaTinh = 'HUNG_YEN'), -- Chuẩn mã số 26
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KINH'),
    N'https://luhanhvietnam.com.vn/du-lich/vnt_upload/news/02_2021/bun-thang-luon-hht.jpg'
),
(
    'NEM_CHUA_THANH_HOA',
    N'Nem Chua Thanh Hóa',
    N'Thanh Hoa Fermented Pork Roll',
    N'Món lên men',
    N'Fermented dish',
    N'Đặc sản nổi tiếng với vị chua dịu, dai giòn và hương thơm đặc trưng.',
    N'A famous fermented delicacy with mild sourness, chewy texture, and distinctive aroma.',
    N'Nem chua Thanh Hóa là một trong những đặc sản nổi tiếng và có tính nhận diện cao của ẩm thực Việt Nam, đặc biệt gắn liền với vùng đất Thanh Hóa. Món ăn này được chế biến chủ yếu từ thịt heo nạc, bì heo thái sợi, thính hoặc các thành phần hỗ trợ lên men, kết hợp với tỏi, ớt và một số gia vị truyền thống khác. Sau khi trộn đều, hỗn hợp được gói chặt trong nhiều lớp lá, phổ biến nhất là lá chuối, rồi để lên men tự nhiên trong một khoảng thời gian nhất định. Chính quá trình lên men này tạo nên hương vị đặc trưng cho nem chua, với vị chua nhẹ, mùi thơm riêng và độ kết dính đặc trưng của sản phẩm hoàn chỉnh.

Về cảm quan, nem chua Thanh Hóa có cấu trúc chắc, độ dai nhẹ nhưng không cứng, xen lẫn độ giòn của sợi bì heo. Khi ăn, thực khách thường cảm nhận rõ vị chua thanh xuất hiện đầu tiên, tiếp theo là vị ngọt nhẹ của thịt, mùi thơm của tỏi, độ cay của ớt và hương lá gói thấm vào sản phẩm trong quá trình ủ. Món ăn thường được dùng trực tiếp mà không cần qua chế biến nhiệt, vì vậy chất lượng nguyên liệu, kỹ thuật sơ chế và quy trình lên men là những yếu tố có ý nghĩa quyết định. Nem đạt chuẩn phải có màu sắc tươi, mùi thơm dễ chịu, vị hài hòa và không có dấu hiệu quá chua hoặc lên men gắt.

Không chỉ đơn thuần là một món ăn, nem chua Thanh Hóa còn là một sản phẩm mang tính quà tặng và biểu tượng địa phương. Món này thường xuất hiện trong các dịp gặp gỡ, lễ tết, tiệc nhẹ hoặc được mua làm quà khi nhắc đến đặc sản xứ Thanh. Trong bối cảnh văn hóa ẩm thực, nem chua thể hiện rõ kỹ thuật chế biến thực phẩm truyền thống dựa trên quá trình lên men tự nhiên, đồng thời phản ánh thói quen sử dụng món ăn nhỏ nhưng giàu hương vị trong đời sống người Việt. Nhờ sự cân bằng giữa vị chua, vị cay, vị ngọt và kết cấu dai giòn đặc trưng, nem chua Thanh Hóa đã vượt khỏi phạm vi địa phương để trở thành một trong những món đặc sản được biết đến rộng rãi trên cả nước.',
    N'Thanh Hoa fermented pork roll is one of the most recognizable specialties in Vietnamese cuisine and is strongly associated with Thanh Hoa Province. The dish is mainly made from lean pork, shredded pork skin, toasted rice powder or fermentation-supporting ingredients, combined with garlic, chili, and traditional seasonings. After thorough mixing, the mixture is wrapped tightly in several layers of leaves, most commonly banana leaves, and left to ferment naturally for a specific period of time. It is this fermentation process that gives the dish its distinctive character, producing a gentle sourness, a unique aroma, and the slightly firm, cohesive texture of the finished product.

In terms of sensory qualities, Thanh Hoa fermented pork has a compact structure, a mild chewiness without being tough, and a slight crispness from the pork skin strands. When eaten, the first impression is usually a light natural sourness, followed by the subtle sweetness of pork, the fragrance of garlic, the heat of chili, and the leafy aroma absorbed during fermentation. The dish is generally consumed without further cooking, which makes ingredient quality, hygienic preparation, and fermentation control especially important. A well-made product should have a fresh appearance, a pleasant aroma, a balanced flavor, and no overly sharp or harsh fermented taste.

Beyond its culinary role, Thanh Hoa fermented pork is also a regional gift item and a strong symbol of local identity. It is commonly served at gatherings, festive occasions, casual drinking meals, or purchased as a specialty gift associated with Thanh Hoa. In the context of Vietnamese food culture, it reflects traditional fermentation techniques and the preference for small but flavorful dishes in everyday life. Because of its balance of sourness, heat, sweetness, and its signature chewy-crisp texture, Thanh Hoa fermented pork has become widely recognized far beyond its place of origin.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'TRUNG_BO'),
    (SELECT TinhThanhID FROM dbo.TinhThanh WHERE MaTinh = 'THANH_HOA'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KINH'),
    N'https://cdn2.fptshop.com.vn/unsafe/1920x0/filters:format(webp):quality(75)/2024_1_9_638404130081431753_cach-lam-nem-chua-thumb.jpg'
),
(
    'TUONG_NAM_DAN',
    N'Tương Nam Đàn',
    N'Nam Dan Fermented Soybean Paste',
    N'Gia vị',
    N'Condiment',
    N'Loại tương lên men truyền thống với vị mặn ngọt hài hòa và mùi thơm đậm đà.',
    N'A traditional fermented soybean condiment with a balanced savory-sweet taste and rich aroma.',
    N'Tương Nam Đàn là một sản phẩm ẩm thực truyền thống đặc trưng của vùng Nam Đàn, Nghệ An, được biết đến như một loại tương lên men có hương vị đậm đà và giá trị sử dụng rộng rãi trong bữa ăn thường ngày. Nguyên liệu cơ bản để làm tương thường gồm đậu nành, gạo nếp hoặc ngô tùy cách làm, muối và nước, trong đó từng công đoạn như rang đậu, làm mốc, ủ tương và phơi nắng đều ảnh hưởng trực tiếp đến chất lượng thành phẩm. Quá trình chế biến tương đòi hỏi thời gian, sự kiên nhẫn và kinh nghiệm gia truyền để tạo ra hỗn hợp có độ sánh vừa phải, màu nâu cánh gián đặc trưng và mùi thơm lên men dễ chịu.

Về hương vị, tương Nam Đàn có sự hòa quyện giữa vị mặn, vị ngọt nhẹ và mùi thơm bùi của đậu nành lên men. Không giống những loại nước chấm có vị mạnh theo hướng gắt hoặc cay, tương thiên về độ đằm, sâu và tròn vị, thích hợp với nhiều món ăn dân dã của miền Trung và Bắc Trung Bộ. Tương thường được dùng để chấm rau luộc, cà muối, thịt luộc, bánh đúc, hoặc dùng làm gia vị nêm nếm trong một số món kho và món rim. Khi kết hợp với thực phẩm đơn giản, tương phát huy rõ nhất vai trò làm nổi bật vị nguyên liệu mà không che lấp bản chất món ăn.

Trong đời sống ẩm thực địa phương, tương Nam Đàn không chỉ là một loại gia vị mà còn là một phần của ký ức gia đình và truyền thống nông nghiệp. Việc làm tương thường gắn với nhịp sinh hoạt theo mùa, với khoảng sân phơi nắng và những chum tương được chăm chút trong thời gian dài. Món này phản ánh rõ nét văn hóa ẩm thực tiết kiệm, bền bỉ và coi trọng sự tích lũy kinh nghiệm qua nhiều thế hệ. Trong cơ sở dữ liệu món ăn và đặc sản Việt Nam, tương Nam Đàn nên được xem như một đại diện tiêu biểu của nhóm gia vị truyền thống lên men, vừa mang giá trị sử dụng thực tế, vừa có chiều sâu văn hóa vùng miền.',
    N'Nam Dan fermented soybean paste is a traditional culinary product of Nam Dan District in Nghe An Province, known as a richly flavored fermented condiment with broad everyday use. Its basic ingredients usually include soybeans, glutinous rice or sometimes corn depending on the recipe, along with salt and water. Each stage of production, from roasting soybeans and preparing the starter to fermenting the mixture and drying it under sunlight, has a direct impact on the final quality. Making this paste requires time, patience, and inherited experience in order to achieve the proper thickness, the characteristic amber-brown color, and the pleasant aroma of controlled fermentation.

In terms of flavor, Nam Dan soybean paste offers a balanced combination of savory saltiness, mild sweetness, and the nutty fragrance of fermented soybeans. Unlike dipping sauces that rely on sharpness or chili heat, this paste is valued for its depth, roundness, and mellow character, making it suitable for many rustic dishes from Central and North Central Vietnam. It is commonly used as a dip for boiled vegetables, pickled eggplant, boiled meat, and rice cakes, and it may also serve as a seasoning ingredient in braised or simmered dishes. When paired with simple foods, it is especially effective in enhancing the natural taste of the ingredients without overpowering them.

In local food culture, Nam Dan soybean paste is more than a condiment; it is also part of household memory and agricultural tradition. The process of making it is often tied to seasonal rhythms, sunny courtyards, and jars of paste tended over time. It reflects a culinary culture shaped by thrift, patience, and the accumulation of practical knowledge across generations. In a Vietnamese food database, Nam Dan soybean paste should be treated as a representative example of traditional fermented condiments, valued both for its practical function and for its strong regional cultural identity.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'TRUNG_BO'),
    (SELECT TinhThanhID FROM dbo.TinhThanh WHERE MaTinh = 'NGHE_AN'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KINH'),
    N'https://statics.vinpearl.com/tuong-nam-dan-03_1632205513.jpg'
),
(
    'KEO_CU_DO',
    N'Kẹo Cu Đơ',
    N'Cu Do Peanut Candy',
    N'Món ngọt',
    N'Dessert',
    N'Loại kẹo truyền thống giòn, ngọt và bùi làm từ lạc, mật mía và bánh tráng.',
    N'A traditional crisp, sweet, and nutty candy made from peanuts, molasses, and rice paper.',
    N'Kẹo cu đơ là một đặc sản nổi tiếng của Hà Tĩnh, gắn với đời sống dân dã của miền Trung và được nhiều người biết đến như một món quà quê mang đậm bản sắc địa phương. Thành phần chính của kẹo gồm lạc rang, mật mía, gừng và bánh tráng. Khi chế biến, mật được nấu đến độ keo nhất định rồi trộn với lạc rang để tạo thành phần nhân dẻo giòn, sau đó kẹp giữa hai lớp bánh tráng mỏng. Sự kết hợp tưởng chừng đơn giản này lại tạo nên một sản phẩm có cấu trúc và hương vị rất đặc trưng, vừa mộc mạc vừa khó nhầm lẫn với các loại kẹo khác.

Về cảm giác khi thưởng thức, kẹo cu đơ có độ giòn của bánh tráng, vị bùi béo của lạc, độ ngọt đậm của mật và chút cay ấm từ gừng. Các yếu tố này hòa quyện tạo nên tổng thể hài hòa, giúp kẹo không chỉ ngọt mà còn có chiều sâu hương vị. Kẹo thường được dùng cùng trà nóng, bởi vị chát nhẹ của trà có thể làm dịu độ ngọt và giúp người ăn cảm nhận rõ hơn mùi thơm của lạc và gừng. Chính cách kết hợp này khiến kẹo cu đơ không chỉ là món ăn vặt mà còn gắn với nếp tiếp khách, trò chuyện và nhịp sống chậm của vùng quê miền Trung.

Trong ý nghĩa văn hóa, kẹo cu đơ phản ánh rõ đặc điểm ẩm thực của vùng đất có khí hậu khắc nghiệt nhưng giàu tính tiết kiệm và sáng tạo trong cách sử dụng nguyên liệu sẵn có. Từ những thành phần quen thuộc như lạc, mật mía và bánh tráng, người dân địa phương đã tạo ra một món quà có giá trị thương mại, giá trị biểu tượng và khả năng lưu giữ lâu hơn so với nhiều loại bánh trái tươi. Trong cơ sở dữ liệu đặc sản Việt Nam, kẹo cu đơ là đại diện phù hợp cho nhóm món ngọt truyền thống miền Trung, vừa có giá trị tiêu dùng, vừa có sức gợi mạnh về vùng đất và con người Hà Tĩnh.',
    N'Cu do peanut candy is a well-known specialty of Ha Tinh Province, closely tied to the rustic life of Central Vietnam and widely recognized as a local gift with strong regional identity. Its main ingredients are roasted peanuts, molasses, ginger, and thin rice paper. During preparation, the molasses is cooked to a sticky stage and mixed with roasted peanuts to form a chewy-crisp filling, which is then pressed between two thin sheets of rice paper. Although the composition appears simple, it creates a product with a highly distinctive structure and flavor, rustic yet difficult to confuse with any other sweet.

When eaten, cu do candy offers the crispness of rice paper, the rich nuttiness of peanuts, the deep sweetness of molasses, and a warm spicy note from ginger. These elements blend into a balanced whole, making the candy more than simply sweet. It is often enjoyed with hot tea, because the slight bitterness of tea softens the sweetness and allows the aroma of peanuts and ginger to stand out more clearly. For this reason, cu do is not just a snack but also part of the traditional style of offering food to guests, drinking tea, and sharing conversation in Central Vietnamese daily life.

Culturally, cu do reflects the culinary character of a region shaped by a harsh climate, where thrift and creativity in the use of available ingredients are especially valued. From familiar materials such as peanuts, molasses, and rice paper, local people created a product with commercial value, symbolic meaning, and a longer shelf life than many fresh sweets. In a Vietnamese specialty database, cu do candy is a strong representative of traditional Central Vietnamese sweets, carrying both practical value and a vivid sense of place connected to Ha Tinh and its people.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'TRUNG_BO'),
    (SELECT TinhThanhID FROM dbo.TinhThanh WHERE MaTinh = 'HA_TINH'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KINH'),
    N'https://statics.vinpearl.com/keo-cu-do-ha-tinh-0_1632386223.png'
),
(
    'MI_QUANG',
    N'Mì Quảng',
    N'Mi Quang',
    N'Món mì',
    N'Noodle dish',
    N'Món mì đặc trưng miền Trung với sợi mì bản to, nước dùng ít và hương vị đậm đà.',
    N'A signature Central Vietnamese noodle dish with broad rice noodles, a small amount of broth, and rich flavor.',
    N'Mì Quảng là một trong những món ăn tiêu biểu nhất của ẩm thực miền Trung Việt Nam, đặc biệt gắn với tỉnh Quảng Nam và khu vực lân cận. Khác với nhiều món bún hay mì nước có lượng nước dùng nhiều, mì Quảng chỉ sử dụng một lượng nước vừa phải, đủ để áo quanh sợi mì và các thành phần ăn kèm. Sợi mì thường có bản to, mềm nhưng vẫn giữ được độ dai nhất định, được làm từ gạo và đôi khi được nhuộm màu vàng nhạt bằng nghệ. Thành phần đi kèm rất đa dạng, có thể gồm tôm, thịt heo, gà, trứng cút, đậu phộng rang, rau sống, bánh tráng nướng và các loại rau thơm, tạo nên tổng thể phong phú cả về màu sắc lẫn hương vị.

Điểm đặc sắc của mì Quảng nằm ở sự cân bằng giữa phần mì, phần nhân và phần nước dùng cô đọng. Nước dùng thường được nấu từ xương hoặc từ chính nguyên liệu chính của món như tôm, thịt hoặc gà, có vị đậm nhưng không quá nặng. Rau sống ăn kèm đóng vai trò rất quan trọng, giúp tạo độ tươi, độ giòn và cân bằng lại phần nhân giàu vị. Đậu phộng rang và bánh tráng nướng bẻ vụn góp phần bổ sung độ bùi và kết cấu giòn, khiến món ăn có nhiều tầng cảm giác khi thưởng thức. Thực khách thường trộn đều trước khi ăn để các thành phần quyện vào nhau, tạo nên hương vị đặc trưng khó nhầm lẫn.

Không chỉ là món ăn thường ngày, mì Quảng còn là biểu tượng ẩm thực của vùng đất Quảng Nam, phản ánh phong cách ăn uống mộc mạc nhưng sâu vị của miền Trung. Món ăn thể hiện rõ tính linh hoạt trong việc sử dụng nguyên liệu địa phương và khả năng kết hợp nhiều thành phần trong một tô ăn mà vẫn giữ được sự hài hòa. Trong hệ thống dữ liệu ẩm thực Việt Nam, mì Quảng là món đại diện rất mạnh cho nhóm món mì vùng miền, vừa có giá trị phổ biến rộng rãi, vừa mang đậm dấu ấn địa phương và chiều sâu văn hóa ẩm thực.',
    N'Mi Quang is one of the most representative dishes of Central Vietnamese cuisine, especially associated with Quang Nam Province and nearby areas. Unlike many Vietnamese noodle soups that contain a large amount of broth, mi Quang uses only a modest quantity, just enough to coat the noodles and accompanying ingredients. The noodles are usually broad, soft, and slightly chewy, made from rice and sometimes lightly colored with turmeric. The toppings are highly diverse and may include shrimp, pork, chicken, quail eggs, roasted peanuts, fresh herbs, grilled rice crackers, and assorted greens, resulting in a dish that is rich in both flavor and visual appeal.

Its defining feature lies in the balance between noodles, toppings, and concentrated broth. The broth is commonly made from bones or from the main protein itself, such as shrimp, pork, or chicken, giving it a rich but not overly heavy flavor. The fresh herbs served alongside are essential, adding freshness, crunch, and contrast to the savory toppings. Roasted peanuts and broken grilled rice crackers contribute nuttiness and crisp texture, giving the dish multiple sensory layers. Diners often mix everything together before eating so that the ingredients combine into the distinctive overall taste of mi Quang.

More than an everyday meal, mi Quang is a culinary symbol of Quang Nam and reflects the rustic yet deeply flavored character of Central Vietnam. The dish demonstrates flexible use of local ingredients and the ability to combine many elements in a single bowl while preserving harmony. In a Vietnamese food database, mi Quang is a particularly strong representative of regional noodle dishes, valued both for its broad popularity and its clear local identity and cultural depth.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'TRUNG_BO'),
    (SELECT TinhThanhID FROM dbo.TinhThanh WHERE MaTinh = 'QUANG_NAM'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KINH'),
    N'https://cdn.tgdd.vn/2021/01/CookProduct/MIQUANGSUONNONVATOMCachNauMiQuangChinhGocMienTrungThomNgonBepCuiTV14-14screenshot1200-1200x676.jpg'
),
(
    'COM_GA_HOI_AN',
    N'Cơm Gà Hội An',
    N'Hoi An Chicken Rice',
    N'Món cơm',
    N'Rice dish',
    N'Món cơm nổi tiếng với hạt cơm vàng thơm, thịt gà mềm và phong vị riêng của phố Hội.',
    N'A famous rice dish with golden fragrant rice, tender chicken, and the distinctive flavor of Hoi An.',
    N'Cơm gà Hội An là một trong những món ăn nổi bật của ẩm thực phố cổ Hội An, được nhiều thực khách biết đến nhờ hương vị hài hòa, cách trình bày đẹp mắt và dấu ấn địa phương rõ nét. Món ăn thường sử dụng gà ta luộc chín tới để giữ độ mềm và vị ngọt tự nhiên của thịt. Phần cơm được nấu từ nước luộc gà hoặc nước dùng có gia vị, đôi khi kết hợp thêm nghệ hoặc các thành phần tạo màu để hạt cơm có sắc vàng nhẹ, bóng, tơi và thơm. Thịt gà sau khi luộc có thể được xé nhỏ hoặc chặt miếng, trộn hoặc ăn kèm với rau răm, hành tây, đồ chua và nước mắm pha hoặc nước sốt riêng tùy phong cách quán.

Điểm hấp dẫn của cơm gà Hội An nằm ở sự chỉn chu trong từng thành phần chứ không dựa vào sự cầu kỳ quá mức. Hạt cơm phải rời, không khô, có độ béo vừa phải và thấm hương từ nước nấu. Thịt gà phải giữ được độ săn nhẹ, không bở, đồng thời có vị ngọt rõ. Rau răm, hành tây và các thành phần phụ giúp tạo độ thơm, giảm cảm giác ngấy và làm món ăn trở nên cân bằng hơn. Một số phiên bản còn dùng thêm nước luộc gà hoặc canh đi kèm để món ăn trọn vẹn hơn về mặt cảm giác.

Trong văn hóa ẩm thực Hội An, cơm gà là món ăn vừa quen thuộc với cư dân địa phương, vừa có sức hấp dẫn lớn đối với du khách. Món này phản ánh rõ phong cách ẩm thực phố Hội: không quá nặng vị nhưng tinh tế, gọn gàng và giàu tính bản địa. Từ nguyên liệu rất cơ bản như gạo, gà và rau gia vị, người nấu đã tạo nên một món ăn có khả năng nhận diện cao và vị thế riêng trong hệ thống đặc sản miền Trung. Trong cơ sở dữ liệu món ăn Việt Nam, cơm gà Hội An là đại diện tiêu biểu cho nhóm món cơm địa phương có chiều sâu văn hóa và giá trị du lịch ẩm thực rõ rệt.',
    N'Hoi An chicken rice is one of the standout dishes of Hoi An’s culinary heritage, widely recognized for its balanced flavor, attractive presentation, and strong local identity. The dish usually uses free-range chicken that is poached just enough to keep the meat tender and naturally sweet. The rice is cooked in chicken broth or seasoned stock, sometimes with turmeric or other coloring ingredients, so that the grains become lightly golden, glossy, separate, and fragrant. The chicken may be shredded or chopped and is commonly served or mixed with Vietnamese coriander, onion, pickled vegetables, and seasoned fish sauce or a house-style dressing depending on the restaurant.

The appeal of Hoi An chicken rice lies in the care devoted to each component rather than in excessive complexity. The rice should be fluffy without being dry, lightly rich, and infused with the aroma of the cooking liquid. The chicken must remain slightly firm, never mushy, while preserving a clear natural sweetness. Vietnamese coriander, onion, and side ingredients help add fragrance, cut through richness, and bring the dish into balance. Some versions also include a small bowl of chicken broth or soup on the side to complete the meal.

In the food culture of Hoi An, chicken rice is both a familiar local meal and a dish of strong appeal to visitors. It clearly reflects the culinary character of the ancient town: not overly heavy, but refined, neat, and rooted in place. From basic ingredients such as rice, chicken, and aromatic herbs, local cooks have created a dish with high recognizability and a distinct place among Central Vietnamese specialties. In a Vietnamese culinary database, Hoi An chicken rice is a representative example of a regional rice dish with clear cultural depth and tourism value.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'TRUNG_BO'),
    (SELECT TinhThanhID FROM dbo.TinhThanh WHERE MaTinh = 'QUANG_NAM'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KINH'),
    N'https://i-giadinh.vnecdn.net/2023/04/22/Buoc-11-thanh-pham-1-11-9981-1682135995.jpg'
),
(
    'BANH_LOC_SAN',
    N'Bánh Lọc Sắn',
    N'Tapioca Dumpling (Cassava-based)',
    N'Món bánh',
    N'Dumpling',
    N'Món bánh dân dã làm từ sắn với nhân đậm đà và kết cấu dẻo dai.',
    N'A rustic dumpling made from cassava with savory filling and chewy texture.',
    N'Bánh lọc sắn là một biến thể dân dã của bánh lọc truyền thống, sử dụng nguyên liệu chính là sắn (khoai mì) thay vì bột năng tinh luyện. Món ăn thường xuất hiện ở các vùng nông thôn miền Trung, nơi sắn là nguyên liệu phổ biến và dễ tiếp cận. Sau khi được sơ chế, sắn được giã hoặc xay nhuyễn, vắt bớt nước rồi trộn lại để tạo thành khối bột có độ dẻo tự nhiên. Phần bột này sau đó được gói cùng nhân, thường là tôm, thịt hoặc kết hợp cả hai, rồi đem hấp chín.

Đặc điểm nổi bật của bánh lọc sắn nằm ở kết cấu dẻo nhưng có phần thô hơn so với bánh làm từ bột năng, mang lại cảm giác mộc mạc và gần gũi. Khi ăn, bánh có vị ngọt nhẹ tự nhiên của sắn, hòa quyện với vị mặn đậm đà của nhân. Nước chấm thường là nước mắm pha tỏi ớt, đóng vai trò làm nổi bật tổng thể hương vị. So với các loại bánh lọc khác, bánh lọc sắn ít bóng và trong hơn, nhưng lại tạo ấn tượng bởi sự chân chất và đặc trưng nguyên liệu.

Trong bối cảnh văn hóa ẩm thực, bánh lọc sắn phản ánh rõ cách người dân tận dụng nguyên liệu địa phương để tạo ra món ăn phù hợp với điều kiện sống. Món ăn không cầu kỳ nhưng giàu tính bản địa, thể hiện sự thích nghi và sáng tạo trong ẩm thực miền Trung. Đây là một đại diện tiêu biểu cho nhóm món bánh dân dã sử dụng nguyên liệu thay thế nhưng vẫn giữ được tinh thần của món gốc.',
    N'Cassava-based tapioca dumplings are a rustic variation of the traditional Vietnamese “banh loc,” using cassava instead of refined tapioca starch. This dish is commonly found in rural areas of Central Vietnam, where cassava is widely available. The cassava is peeled, grated or ground, then squeezed to remove excess water and formed into a naturally elastic dough. This dough is then wrapped around a savory filling, typically shrimp, pork, or a combination of both, and steamed until cooked.

The defining feature of this version lies in its texture, which is chewy but slightly coarser than that of tapioca-based dumplings, giving it a more rustic feel. When eaten, it offers a mild natural sweetness from the cassava, balanced by the savory filling inside. It is usually served with a fish sauce dipping mixture with garlic and chili, which enhances the overall flavor. Compared to standard banh loc, cassava dumplings are less translucent but more earthy in character.

From a cultural perspective, this dish illustrates how local communities adapt traditional recipes using available ingredients. It represents a practical and creative approach to cooking, preserving the essence of the original dish while introducing regional identity. As such, cassava dumplings are a valuable example of rural Central Vietnamese culinary adaptation.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'TRUNG_BO'),
    (SELECT TinhThanhID FROM dbo.TinhThanh WHERE MaTinh = 'QUANG_NAM'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KINH'),
    N'https://statics.vinpearl.com/banh-bot-loc-hue-1_1628661597.png'
),
(
    'BANH_LOC_MY_CHANH',
    N'Bánh Lọc Mỹ Chánh',
    N'My Chanh Tapioca Dumpling',
    N'Món bánh',
    N'Dumpling',
    N'Đặc sản bánh lọc nổi tiếng với lớp vỏ trong dai và nhân đậm đà.',
    N'A famous translucent dumpling with chewy texture and rich filling.',
    N'Bánh lọc Mỹ Chánh là một đặc sản nổi tiếng của vùng Quảng Trị, được biết đến với lớp vỏ trong suốt, dẻo dai và phần nhân đậm đà. Bánh được làm từ bột năng, tạo nên lớp vỏ có độ trong và đàn hồi cao sau khi hấp. Nhân bánh thường gồm tôm và thịt heo được tẩm ướp kỹ, mang lại hương vị mặn ngọt hài hòa. Sau khi gói trong lá chuối, bánh được hấp chín, giúp giữ nguyên mùi thơm và độ ẩm của sản phẩm.

Khi thưởng thức, bánh có lớp vỏ mềm, dai, hơi dính nhưng không bở, kết hợp với nhân bên trong đậm đà. Nước chấm đi kèm thường là nước mắm pha chua ngọt, đôi khi thêm ớt để tăng độ cay. Món ăn mang lại sự cân bằng giữa kết cấu và hương vị, tạo cảm giác vừa tinh tế vừa gần gũi.

Trong hệ thống ẩm thực miền Trung, bánh lọc Mỹ Chánh là một trong những biến thể tiêu biểu nhất của dòng bánh lọc, thể hiện rõ sự tinh chỉnh kỹ thuật và bản sắc địa phương. Món ăn không chỉ phổ biến trong đời sống hàng ngày mà còn được xem như một đặc sản tiêu biểu khi nhắc đến vùng đất Quảng Trị.',
    N'My Chanh tapioca dumplings are a well-known specialty from Quang Tri Province, recognized for their translucent, chewy outer layer and richly seasoned filling. Made primarily from tapioca starch, the dough forms a clear and elastic wrapper once steamed. The filling usually consists of shrimp and pork, carefully seasoned to achieve a balanced savory and slightly sweet taste. The dumplings are wrapped in banana leaves before steaming, which helps preserve moisture and aroma.

When eaten, the dumpling offers a soft, chewy texture with a slightly sticky surface, complemented by the flavorful filling inside. It is typically served with a sweet-and-sour fish sauce dipping mixture, sometimes enhanced with chili for heat. The dish achieves a balance between texture and flavor, delivering both refinement and comfort.

Within Central Vietnamese cuisine, My Chanh dumplings stand out as one of the most representative versions of banh loc, showcasing both technical precision and regional identity. It is commonly enjoyed as a daily dish and is also regarded as a signature specialty of Quang Tri.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'TRUNG_BO'),
    (SELECT TinhThanhID FROM dbo.TinhThanh WHERE MaTinh = 'QUANG_TRI'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KINH'),
    N'https://quangtrimart.vn/wp-content/uploads/2023/07/banh-bot-loc-hue_1636708755.jpg'
),
(
    'BANH_XEO',
    N'Bánh Xèo',
    N'Vietnamese Savory Pancake',
    N'Món bánh',
    N'Savory pancake',
    N'Món bánh giòn với nhân tôm thịt và rau sống ăn kèm.',
    N'A crispy pancake filled with shrimp, pork, and fresh herbs.',
    N'Bánh xèo là một trong những món ăn phổ biến trên khắp Việt Nam, đặc biệt nổi bật ở miền Trung và miền Nam. Bánh được làm từ bột gạo pha loãng, có thể thêm nghệ để tạo màu vàng đặc trưng, sau đó đổ vào chảo nóng để tạo lớp vỏ mỏng, giòn. Nhân bánh thường gồm tôm, thịt heo, giá đỗ và đôi khi thêm các nguyên liệu khác tùy vùng. Khi chiên, bánh được gập đôi lại, giữ phần nhân bên trong và tạo hình bán nguyệt đặc trưng.

Điểm hấp dẫn của bánh xèo nằm ở sự tương phản giữa lớp vỏ giòn rụm và phần nhân mềm, đậm đà bên trong. Khi ăn, bánh thường được cắt nhỏ, cuốn cùng rau sống trong bánh tráng và chấm với nước mắm pha. Rau sống đóng vai trò quan trọng trong việc cân bằng vị béo và tăng độ tươi mát cho món ăn.

Bánh xèo không chỉ là món ăn phổ biến mà còn là biểu tượng của ẩm thực đường phố Việt Nam. Mỗi vùng miền có cách chế biến và biến thể riêng, tạo nên sự đa dạng nhưng vẫn giữ được bản chất chung của món bánh chiên giòn với nhân phong phú.',
    N'Banh xeo is a widely popular Vietnamese dish, especially prominent in Central and Southern regions. It is made from a thin rice batter, sometimes colored with turmeric, which is poured into a hot pan to form a crispy crepe. The filling typically includes shrimp, pork, bean sprouts, and occasionally other ingredients depending on the region. The pancake is folded in half during cooking, enclosing the filling and forming its characteristic half-moon shape.

The appeal of banh xeo lies in the contrast between its crispy exterior and its savory, tender filling. It is usually cut into pieces, wrapped in rice paper with fresh herbs, and dipped into a fish sauce mixture. The herbs are essential for balancing the richness and adding freshness.

Banh xeo is not only a common dish but also a symbol of Vietnamese street food culture. Regional variations contribute to its diversity while maintaining the core identity of a crispy savory pancake filled with flavorful ingredients.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'TRUNG_BO'),
    (SELECT TinhThanhID FROM dbo.TinhThanh WHERE MaTinh = 'DA_NANG'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KINH'),
    N'https://i.ytimg.com/vi/uFBb5sB-2Uc/hq720.jpg?sqp=-oaymwEhCK4FEIIDSFryq4qpAxMIARUAAAAAGAElAADIQj0AgKJD&rs=AOn4CLCAAr4Gm6lahMJUQKJ-lGmETeGDaQ'
),
(
    'GOI_CA_NAM_O',
    N'Gỏi Cá Nam Ô',
    N'Nam O Raw Fish Salad',
    N'Món gỏi',
    N'Salad',
    N'Món gỏi cá nổi tiếng với hương vị tươi và đậm đà miền biển.',
    N'A famous coastal raw fish salad with fresh and bold flavors.',
    N'Gỏi cá Nam Ô là đặc sản nổi tiếng của vùng biển Đà Nẵng, đặc biệt là khu vực Nam Ô. Món ăn được làm từ cá tươi, thường là cá trích, được làm sạch và chế biến kỹ để đảm bảo độ an toàn và giữ được vị tươi. Cá sau đó được trộn với thính, gia vị và các loại rau thơm, tạo nên món ăn có hương vị đặc trưng của biển.

Điểm nổi bật của gỏi cá Nam Ô là sự kết hợp giữa vị tươi của cá, vị bùi của thính, vị cay của ớt và mùi thơm của rau sống. Món ăn thường được ăn kèm bánh tráng và nước chấm đặc biệt làm từ mắm, tạo nên trải nghiệm đa dạng về hương vị và kết cấu.

Đây là món ăn mang đậm dấu ấn vùng biển, thể hiện rõ nét văn hóa ẩm thực miền Trung với cách khai thác nguyên liệu tươi sống và chế biến tinh tế.',
    N'Nam O raw fish salad is a well-known coastal specialty from Da Nang, particularly the Nam O area. It is made from fresh fish, typically herring, which is carefully prepared to ensure safety while preserving freshness. The fish is mixed with toasted rice powder, spices, and herbs, creating a dish that highlights the flavors of the sea.

Its defining characteristic lies in the combination of fresh fish, nutty rice powder, chili heat, and aromatic herbs. It is often served with rice paper and a special fermented dipping sauce, offering a layered and complex eating experience.

This dish reflects the coastal culinary tradition of Central Vietnam, emphasizing freshness and careful preparation of raw ingredients.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'TRUNG_BO'),
    (SELECT TinhThanhID FROM dbo.TinhThanh WHERE MaTinh = 'DA_NANG'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KINH'),
    N'https://cdn2.fptshop.com.vn/unsafe/1920x0/filters:format(webp):quality(75)/goi_ca_nam_o_d78f920049.jpg'
),
(
    'BUN_SUA_NHA_TRANG',
    N'Bún Sứa Nha Trang',
    N'Nha Trang Jellyfish Noodle Soup',
    N'Món nước',
    N'Noodle soup',
    N'Món bún đặc trưng với sứa giòn và nước dùng thanh.',
    N'A distinctive noodle soup with crunchy jellyfish and clear broth.',
    N'Bún sứa Nha Trang là một món ăn đặc trưng của vùng biển Nha Trang, nổi bật với nguyên liệu chính là sứa biển có độ giòn tự nhiên. Sứa được sơ chế kỹ để loại bỏ vị tanh và giữ lại độ trong, giòn đặc trưng. Nước dùng thường được nấu từ cá, tạo vị ngọt thanh nhẹ, không quá đậm nhưng đủ để làm nổi bật nguyên liệu chính.

Món ăn thường được phục vụ cùng bún, chả cá, rau sống và các loại gia vị như ớt, chanh. Sự kết hợp giữa sứa giòn, bún mềm và nước dùng thanh tạo nên cảm giác nhẹ nhàng nhưng vẫn đầy đủ hương vị.

Bún sứa là đại diện tiêu biểu cho ẩm thực biển miền Trung, thể hiện cách tận dụng nguyên liệu tự nhiên để tạo nên món ăn độc đáo và khác biệt.',
    N'Nha Trang jellyfish noodle soup is a coastal specialty known for its use of jellyfish, which provides a naturally crunchy texture. The jellyfish is carefully processed to remove any unwanted taste while preserving its clarity and crispness. The broth is typically made from fish, resulting in a light, naturally sweet flavor that highlights the main ingredient.

The dish is served with rice vermicelli, fish cakes, fresh herbs, and condiments such as chili and lime. The combination of crunchy jellyfish, soft noodles, and clear broth creates a light yet satisfying experience.

This dish represents Central Vietnam’s coastal cuisine, showcasing how fresh marine ingredients can be transformed into a unique and refreshing noodle dish.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'TRUNG_BO'),
    (SELECT TinhThanhID FROM dbo.TinhThanh WHERE MaTinh = 'KHANH_HOA'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KINH'),
    N'https://statics.vinpearl.com/bun-sua-nha-trang-1_1632704947.jpg'
),
(
    'NEM_NUONG_NINH_HOA',
    N'Nem Nướng Ninh Hòa',
    N'Ninh Hoa Grilled Pork',
    N'Món nướng',
    N'Grilled dish',
    N'Đặc sản nổi tiếng với nem nướng thơm và cách ăn cuốn độc đáo.',
    N'A famous grilled pork specialty served with a unique wrapping style.',
    N'Nem nướng Ninh Hòa là một trong những đặc sản nổi bật của tỉnh Khánh Hòa, gắn liền với vùng đất Ninh Hòa và được nhiều thực khách biết đến nhờ hương vị đặc trưng cùng cách thưởng thức mang tính trải nghiệm cao. Nguyên liệu chính của món ăn là thịt heo xay nhuyễn, được trộn với gia vị, có thể bổ sung thêm mỡ để tăng độ mềm và độ béo, sau đó vo thành từng thanh dài và nướng trên than hoa. Quá trình nướng giúp nem có lớp ngoài xém nhẹ, dậy mùi thơm đặc trưng, trong khi bên trong vẫn giữ được độ mềm và vị ngọt của thịt.

Một phần nem nướng thường được phục vụ kèm bánh tráng, bún, rau sống và đặc biệt là nước chấm đặc trưng làm từ gan, đậu phộng và các gia vị khác, tạo nên độ sánh và vị béo đặc biệt. Khi ăn, thực khách cuốn nem cùng rau và bún trong bánh tráng rồi chấm nước sốt, tạo nên sự kết hợp hài hòa giữa vị nướng, vị tươi và vị béo. Chính cách ăn này khiến món không chỉ là thực phẩm mà còn là một trải nghiệm ẩm thực trọn vẹn.

Trong hệ thống ẩm thực miền Trung, nem nướng Ninh Hòa là đại diện tiêu biểu cho nhóm món nướng kết hợp cuốn, thể hiện rõ sự tinh tế trong cách tổ chức món ăn và phối hợp nguyên liệu. Món ăn không chỉ phổ biến trong đời sống thường ngày mà còn mang giá trị du lịch cao, thường được giới thiệu như một đặc sản đặc trưng của Khánh Hòa.',
    N'Ninh Hoa grilled pork is a well-known specialty of Khanh Hoa Province, closely associated with the Ninh Hoa region and widely appreciated for its distinctive flavor and interactive eating style. The main ingredient is finely ground pork mixed with seasonings, sometimes combined with fat to enhance tenderness and richness, then shaped into elongated pieces and grilled over charcoal. This grilling process creates a lightly charred exterior with a fragrant aroma while keeping the inside soft and naturally sweet.

A typical serving includes rice paper, vermicelli, fresh herbs, and most importantly, a signature dipping sauce made from liver, peanuts, and other ingredients, giving it a rich and slightly thick consistency. Diners wrap the grilled pork with herbs and noodles in rice paper and dip it into the sauce, creating a balanced combination of smoky, fresh, and savory flavors. This method of eating transforms the dish into a full culinary experience.

Within Central Vietnamese cuisine, Ninh Hoa grilled pork represents a classic example of grilled dishes served with wrapping elements, highlighting the thoughtful combination of textures and flavors. It is both an everyday favorite and a popular dish for visitors, carrying strong regional identity and tourism value.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'TRUNG_BO'),
    (SELECT TinhThanhID FROM dbo.TinhThanh WHERE MaTinh = 'KHANH_HOA'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KINH'),
    N'https://giadinh.mediacdn.vn/296230595582509056/2022/10/26/anh-1-bep-xua-16666587857231810068360-1666740539313-16667405394181263381511.jpg'
),
(
    'HU_TIEU_GO',
    N'Hủ Tiếu Gõ',
    N'Street Cart Hu Tieu',
    N'Món nước',
    N'Noodle soup',
    N'Món hủ tiếu đường phố giản dị, quen thuộc về đêm.',
    N'A simple street-style noodle soup commonly found at night.',
    N'Hủ tiếu gõ là một hình ảnh quen thuộc trong đời sống ẩm thực đường phố miền Nam, đặc biệt ở các đô thị lớn. Tên gọi “gõ” xuất phát từ âm thanh đặc trưng khi người bán dùng thanh kim loại gõ vào xe đẩy để báo hiệu sự xuất hiện. Món ăn thường được bán vào buổi tối hoặc khuya, phục vụ nhu cầu ăn nhanh, tiện lợi nhưng vẫn đảm bảo hương vị đậm đà. Thành phần cơ bản gồm hủ tiếu, nước dùng, thịt heo, lòng, trứng cút và đôi khi có thêm xương hoặc hải sản tùy quán.

Nước dùng của hủ tiếu gõ thường được nấu đơn giản nhưng giữ được vị ngọt tự nhiên từ xương và gia vị. Sợi hủ tiếu mềm, dễ ăn, kết hợp với các topping tạo nên một món ăn vừa đủ no, phù hợp với nhịp sống nhanh. Dù không cầu kỳ, món ăn vẫn mang lại cảm giác thân thuộc và ấm áp, đặc biệt trong không gian đường phố về đêm.

Trong văn hóa ẩm thực, hủ tiếu gõ không chỉ là món ăn mà còn là một phần của nhịp sống đô thị, gắn liền với ký ức và sinh hoạt hàng ngày của nhiều người dân. Đây là đại diện tiêu biểu cho ẩm thực bình dân, nơi giá trị không nằm ở sự sang trọng mà ở tính tiện dụng và sự gần gũi.',
    N'Street cart hu tieu is a familiar part of Southern Vietnamese street food culture, especially in large cities. The name “go” comes from the distinctive sound made when the vendor taps a metal object to announce their presence. This dish is typically sold at night, serving as a quick and convenient meal while still offering satisfying flavor. The basic components include rice noodles, broth, pork, offal, quail eggs, and sometimes bones or seafood depending on the vendor.

The broth is usually simple but retains a natural sweetness from bones and seasoning. The noodles are soft and easy to eat, combined with toppings to create a balanced and filling meal. Despite its simplicity, the dish provides a sense of comfort, especially when enjoyed in the atmosphere of nighttime streets.

In culinary culture, street cart hu tieu represents more than just food; it reflects the rhythm of urban life and everyday experiences. It stands as a symbol of humble street cuisine, where value lies in accessibility, warmth, and familiarity rather than complexity.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'NAM_BO'),
    (SELECT TinhThanhID FROM dbo.TinhThanh WHERE MaTinh = 'HO_CHI_MINH'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KINH'),
    N'https://media-cdn-v2.laodong.vn/Storage/NewsPortal/2023/3/30/1173840/2.jpg'
),
(
    'LAU_GA_LA_E',
    N'Lẩu Gà Lá É',
    N'Chicken Hotpot with Basil Leaves',
    N'Món lẩu',
    N'Hotpot',
    N'Món lẩu đặc trưng với vị chua nhẹ và hương thơm lá é.',
    N'A distinctive hotpot with light sourness and aromatic basil leaves.',
    N'Lẩu gà lá é là món ăn đặc trưng của khu vực Tây Nguyên và Nam Trung Bộ, nổi bật với sự kết hợp giữa thịt gà và lá é – một loại lá có mùi thơm đặc trưng gần giống húng quế nhưng có vị riêng biệt. Nước lẩu thường được nấu từ gà, kết hợp với các gia vị tạo vị chua nhẹ và thanh, giúp món ăn không bị ngấy. Thịt gà được chặt miếng vừa ăn, giữ được độ mềm và ngọt tự nhiên.

Khi thưởng thức, thực khách nhúng gà và rau vào nồi lẩu nóng, ăn kèm bún hoặc mì. Lá é đóng vai trò quan trọng, vừa tạo mùi thơm vừa làm tăng độ tươi mát cho món ăn. Sự kết hợp giữa vị chua, vị ngọt và hương thơm tạo nên trải nghiệm cân bằng và dễ ăn.

Trong hệ thống món lẩu Việt Nam, lẩu gà lá é là một biến thể đặc sắc, mang đậm dấu ấn vùng miền và cách sử dụng nguyên liệu bản địa. Món ăn thể hiện rõ nét văn hóa ẩm thực cộng đồng, thường xuất hiện trong các bữa ăn tụ họp.',
    N'Chicken hotpot with basil leaves is a specialty of the Central Highlands and South Central Vietnam, known for its combination of chicken and “la e” leaves, a herb with a distinctive aroma similar to basil but uniquely different. The broth is typically made from chicken and seasoned to create a light, slightly sour taste that prevents the dish from feeling heavy. The chicken is cut into bite-sized pieces, maintaining its natural tenderness and sweetness.

When eating, diners cook the chicken and vegetables directly in the hotpot, usually served with noodles. The basil-like leaves play a key role, adding fragrance and freshness to the dish. The combination of sourness, sweetness, and herbal aroma creates a well-balanced and enjoyable flavor profile.

In Vietnamese hotpot cuisine, this dish stands out as a regional variation that highlights local ingredients. It reflects communal dining culture and is commonly enjoyed during gatherings and shared meals.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'TRUNG_BO'),
    (SELECT TinhThanhID FROM dbo.TinhThanh WHERE MaTinh = 'LAM_DONG'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KINH'),
    N'https://kalite.vn/wp-content/uploads/2024/12/402598452_7004207222975681_6403554273470642148_n-2.jpg'
),
(
    'BUN_DO',
    N'Bún Đỏ',
    N'Red Noodle Soup',
    N'Món nước',
    N'Noodle soup',
    N'Món bún đặc trưng với màu nước dùng đỏ và hương vị đậm.',
    N'A distinctive noodle soup with a red-colored broth and rich flavor.',
    N'Bún đỏ là một món ăn đặc trưng của vùng Buôn Ma Thuột, nổi bật với màu đỏ đặc trưng của nước dùng và hương vị đậm đà. Màu đỏ thường đến từ dầu điều hoặc gia vị tạo màu, giúp món ăn trở nên hấp dẫn về mặt thị giác. Thành phần của bún đỏ khá phong phú, có thể gồm chả, trứng, thịt và rau, tạo nên một tô bún đầy đặn.

Nước dùng được nấu từ xương và gia vị, có vị ngọt và hơi đậm, phù hợp với khẩu vị của vùng cao nguyên. Sợi bún mềm kết hợp với topping đa dạng tạo nên trải nghiệm phong phú. Món ăn thường được ăn kèm rau sống để cân bằng vị.

Bún đỏ là một ví dụ điển hình cho sự giao thoa giữa ẩm thực miền Trung và Tây Nguyên, thể hiện sự sáng tạo trong cách biến tấu món ăn quen thuộc thành phiên bản riêng biệt.',
    N'Red noodle soup is a specialty from Buon Ma Thuot, known for its distinctive red-colored broth and bold flavor. The red color typically comes from annatto oil or spices, making the dish visually appealing. The toppings are varied, often including sausage, eggs, meat, and vegetables, creating a hearty bowl.

The broth is made from bones and seasoning, offering a rich and slightly strong taste that suits highland preferences. The soft noodles combined with diverse toppings provide a layered eating experience. Fresh herbs are usually served alongside to balance the flavors.

This dish represents a fusion between Central Vietnamese and Central Highlands cuisine, showcasing how familiar noodle dishes can be adapted into unique regional versions.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'TRUNG_BO'),
    (SELECT TinhThanhID FROM dbo.TinhThanh WHERE MaTinh = 'DAK_LAK'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KINH'),
    N'https://cdn.dealtoday.vn/ac26ab6730674779bc7e73a3d0f7e6ea.jpg'
),
(
    'GA_NUONG_BAN_DON',
    N'Gà Nướng Bản Đôn',
    N'Ban Don Grilled Chicken',
    N'Món nướng',
    N'Grilled dish',
    N'Món gà nướng đặc trưng Tây Nguyên với hương vị đậm đà.',
    N'A Central Highlands grilled chicken with bold flavors.',
    N'Gà nướng Bản Đôn là món ăn đặc trưng của vùng Tây Nguyên, gắn liền với văn hóa ẩm thực của người dân tộc tại khu vực này. Gà thường là gà thả vườn, có thịt chắc và ít mỡ. Trước khi nướng, gà được tẩm ướp với các loại gia vị như muối, ớt, sả và các loại lá rừng, sau đó nướng trên than hoa để tạo mùi thơm đặc trưng.

Khi chín, gà có lớp da vàng giòn, phần thịt bên trong mềm, ngọt và đậm vị. Món ăn thường được ăn kèm muối ớt hoặc muối chấm đặc trưng của vùng Tây Nguyên. Hương vị của món ăn mang đậm dấu ấn núi rừng, vừa mạnh mẽ vừa tự nhiên.

Trong văn hóa ẩm thực Tây Nguyên, gà nướng Bản Đôn là món ăn gắn với các dịp lễ hội, tụ họp và sinh hoạt cộng đồng. Đây là đại diện tiêu biểu cho phong cách nướng truyền thống và cách sử dụng gia vị bản địa.',
    N'Ban Don grilled chicken is a signature dish of the Central Highlands, closely tied to the culinary traditions of local ethnic communities. The chicken is typically free-range, resulting in firm meat with low fat content. Before grilling, it is marinated with salt, chili, lemongrass, and various forest herbs, then cooked over charcoal to develop a distinctive aroma.

When finished, the chicken has a crispy golden skin while the meat remains tender, juicy, and flavorful. It is often served with chili salt or regional dipping mixtures. The flavor reflects the bold and natural characteristics of the highland environment.

In Central Highlands cuisine, this dish is associated with festivals, gatherings, and communal meals. It represents traditional grilling techniques and the use of indigenous ingredients, making it a strong symbol of regional identity.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'TRUNG_BO'),
    (SELECT TinhThanhID FROM dbo.TinhThanh WHERE MaTinh = 'DAK_LAK'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KHMER'),
    N'https://file.hstatic.net/200000700229/article/ga-nuong-ban-don-1_e5dc25c4955e48f2817a8cd2c14eee91.jpg'
),
(
    'CA_LANG_SONG_SEREPOK',
    N'Cá Lăng Sông Sêrêpốk',
    N'Serepok River Catfish',
    N'Món cá',
    N'Fish dish',
    N'Đặc sản sông nước Tây Nguyên với thịt cá chắc, ngọt và ít xương dăm.',
    N'A Central Highlands river specialty with firm, sweet flesh and few small bones.',
    N'Cá lăng sông Sêrêpốk là một đặc sản nổi bật của khu vực Tây Nguyên, đặc biệt gắn với hệ sinh thái sông Sêrêpốk chảy qua các vùng có cảnh quan hoang sơ và nguồn thủy sản phong phú. Cá lăng là loài cá da trơn nước ngọt có kích thước khá lớn, phần thịt săn chắc, ít xương dăm, vị ngọt tự nhiên và độ béo vừa phải. Nhờ môi trường sống đặc thù với dòng nước chảy mạnh và điều kiện tự nhiên tương đối sạch, cá lăng sông Sêrêpốk thường được đánh giá cao về chất lượng thịt, khác biệt so với nhiều loại cá nuôi thông thường.

Từ nguyên liệu này, người ta có thể chế biến thành nhiều món như nướng, om, lẩu, hấp hoặc nấu canh chua, trong đó các hình thức nướng và lẩu thường được ưa chuộng vì làm nổi bật rõ nhất độ chắc và vị ngọt của thịt cá. Khi nướng, cá thường được tẩm ướp vừa phải để không lấn át hương vị tự nhiên, còn khi làm lẩu, phần đầu và xương cá giúp tạo nước dùng ngọt đậm mà vẫn thanh. Thịt cá lăng có cấu trúc mềm nhưng không bở, ít tanh nếu được sơ chế đúng cách, nên phù hợp với nhiều phong cách chế biến khác nhau. Các loại rau rừng, măng, lá chua hoặc gia vị bản địa thường được kết hợp để tăng dấu ấn vùng miền.

Trong bối cảnh ẩm thực địa phương, cá lăng sông Sêrêpốk không chỉ là một món ăn ngon mà còn mang ý nghĩa gắn với tài nguyên thiên nhiên và đời sống của cư dân vùng sông nước Tây Nguyên. Món ăn phản ánh cách người dân khai thác nguồn nguyên liệu bản địa một cách linh hoạt, đồng thời thể hiện sự trân trọng đối với những sản vật đặc thù của tự nhiên. Trong cơ sở dữ liệu món ăn Việt Nam, cá lăng sông Sêrêpốk là đại diện tiêu biểu cho nhóm món cá đặc sản vùng cao nguyên, vừa có giá trị ẩm thực, vừa có tính nhận diện địa lý rõ ràng.',
    N'Serepok River catfish is a notable specialty of the Central Highlands, especially associated with the Serepok River system, which runs through areas known for their wild landscapes and rich freshwater resources. This species of catfish is a large freshwater fish with firm flesh, very few small bones, natural sweetness, and moderate richness. Because it lives in a distinctive environment with flowing water and relatively clean natural conditions, catfish from the Serepok River is often regarded as superior in texture and flavor compared with many farm-raised fish.

This ingredient can be prepared in many ways, including grilling, braising, hotpot, steaming, or sour soup. Grilled and hotpot versions are especially popular because they best highlight the firmness and sweetness of the fish. When grilled, the fish is usually seasoned in a restrained manner so its natural flavor remains dominant, while in hotpot, the head and bones help produce a broth that is deeply sweet yet still clean-tasting. The flesh is tender without being mushy and has little unpleasant odor when prepared properly, making it suitable for a wide range of cooking methods. Forest herbs, bamboo shoots, sour leaves, or local seasonings are often used to strengthen its regional identity.

In local culinary context, Serepok River catfish is not only a delicious dish but also one connected to the natural resources and daily life of river communities in the Central Highlands. It reflects the way local people make flexible use of native ingredients while respecting the value of distinctive regional produce. In a Vietnamese food database, Serepok River catfish is an excellent representative of highland fish specialties, valued both for its culinary quality and its strong geographic identity.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'TRUNG_BO'),
    (SELECT TinhThanhID FROM dbo.TinhThanh WHERE MaTinh = 'DAK_LAK'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KHMER'),
    N'https://cly.1cdn.vn/2021/11/01/dantoctongiao.congly.vn-upload-2021-1101-_anh_5.jpg'
),
(
    'COM_TAM_SUON_BI_CHA',
    N'Cơm Tấm Sườn Bì Chả',
    N'Broken Rice with Grilled Pork, Shredded Pork Skin, and Egg Meatloaf',
    N'Món cơm',
    N'Rice dish',
    N'Món cơm đặc trưng miền Nam với hương vị đậm đà, đầy đặn và quen thuộc.',
    N'A signature Southern rice dish that is flavorful, hearty, and familiar.',
    N'Cơm tấm sườn bì chả là một trong những món ăn tiêu biểu nhất của ẩm thực miền Nam, đặc biệt gắn bó với đời sống đô thị tại Thành phố Hồ Chí Minh và nhiều tỉnh lân cận. Thành phần chính của món ăn gồm cơm nấu từ gạo tấm, ăn cùng sườn heo nướng, bì heo trộn thính và chả trứng hấp. Từ những nguyên liệu có vẻ bình dân, món ăn đã được phát triển thành một phần rất đặc sắc của văn hóa ẩm thực miền Nam, nhờ sự phối hợp hài hòa giữa vị mặn, ngọt, béo và thơm trong cùng một đĩa ăn.

Phần cơm tấm thường mềm, tơi và có mùi thơm riêng do được nấu từ hạt gạo vỡ. Sườn heo được tẩm ướp với gia vị, đôi khi có thêm mật ong hoặc đường để tạo màu đẹp và vị ngọt nhẹ, sau đó nướng trên lửa than hoặc nhiệt cao để tạo lớp mặt xém thơm. Bì heo được thái sợi nhỏ, trộn với thính gạo rang tạo độ dai và mùi bùi đặc trưng. Chả trứng thường được làm từ trứng, thịt xay, miến và mộc nhĩ, hấp chín đến độ mềm vừa phải. Khi ăn, món cơm thường đi kèm nước mắm pha, đồ chua, mỡ hành và đôi khi thêm trứng ốp la, giúp tăng độ tròn vị và cân bằng cảm giác béo.

Cơm tấm sườn bì chả không chỉ phổ biến vào bữa sáng mà còn được dùng vào mọi thời điểm trong ngày, từ bữa trưa đến bữa tối. Món ăn phản ánh rõ nét phong cách ẩm thực miền Nam: đậm đà, phong phú và gần gũi. Trong cơ sở dữ liệu món ăn Việt Nam, đây là đại diện tiêu biểu cho nhóm món cơm bình dân nhưng có bản sắc rất mạnh, cho thấy khả năng biến những nguyên liệu quen thuộc thành một món ăn có tính nhận diện cao và sức sống bền bỉ trong đời sống hiện đại.',
    N'Broken rice with grilled pork, shredded pork skin, and egg meatloaf is one of the most representative dishes of Southern Vietnamese cuisine, especially tied to urban food culture in Ho Chi Minh City and nearby provinces. Its main components are broken rice served with grilled pork chop, shredded pork skin mixed with toasted rice powder, and steamed egg meatloaf. Although the ingredients may seem modest, the dish has developed into a highly distinctive part of Southern culinary identity through the harmonious balance of salty, sweet, rich, and aromatic elements on a single plate.

The rice is usually soft, fluffy, and slightly fragrant due to being cooked from broken grains. The pork chop is marinated with seasonings, sometimes including honey or sugar for color and light sweetness, then grilled over charcoal or high heat to develop a smoky surface. The shredded pork skin is cut into thin strips and mixed with roasted rice powder, giving it chewiness and a nutty aroma. The egg meatloaf is commonly made from egg, minced pork, glass noodles, and wood ear mushrooms, then steamed until gently firm. The plate is often served with fish sauce, pickled vegetables, scallion oil, and sometimes a fried egg, which complete the dish and balance its richness.

This dish is enjoyed not only for breakfast but throughout the day, from lunch to dinner. It clearly reflects the character of Southern Vietnamese cuisine: rich, generous, and approachable. In a Vietnamese food database, it stands as a representative example of an everyday rice dish with very strong identity, demonstrating how familiar ingredients can be transformed into a meal that is both highly recognizable and enduringly popular.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'NAM_BO'),
    (SELECT TinhThanhID FROM dbo.TinhThanh WHERE MaTinh = 'HO_CHI_MINH'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KINH'),
    N'https://media-cdn-v2.laodong.vn/storage/newsportal/2023/11/29/1273358/Com-Tam-2-01.jpeg'
),
(
    'BANH_TRANG_PHOI_SUONG_TRANG_BANG',
    N'Bánh Tráng Phơi Sương Trảng Bàng',
    N'Trang Bang Dew-softened Rice Paper',
    N'Món bánh',
    N'Rice paper specialty',
    N'Đặc sản Tây Ninh nổi tiếng với lớp bánh dẻo mềm, thơm nhẹ và phù hợp cho các món cuốn.',
    N'A famous Tay Ninh specialty known for its soft, supple texture and suitability for wrapping dishes.',
    N'Bánh tráng phơi sương Trảng Bàng là một đặc sản nổi tiếng của Tây Ninh, gắn liền với vùng Trảng Bàng và được xem là một trong những sản phẩm ẩm thực có tính thủ công, kỹ thuật và bản sắc địa phương rất rõ rệt. Loại bánh tráng này được làm từ bột gạo, tráng thành từng lớp mỏng, sau đó phơi nắng rồi tiếp tục phơi sương vào ban đêm để tạo nên độ mềm dẻo đặc trưng. Chính công đoạn “phơi sương” là điểm tạo nên sự khác biệt rõ nhất, giúp bánh không quá khô giòn như bánh tráng nướng, cũng không quá ướt, mà đạt trạng thái mềm, dẻo và có thể dùng ngay để cuốn.

Về cảm quan, bánh tráng phơi sương có độ dai nhẹ, bề mặt mềm, mùi thơm của gạo và vị thanh dịu. Nhờ kết cấu đặc biệt này, bánh rất phù hợp để ăn kèm thịt luộc, rau sống, bún và các loại nước chấm, đặc biệt trong món bánh tráng cuốn thịt heo nổi tiếng. Khi sử dụng, bánh giữ được độ đàn hồi đủ để cuốn chắc tay mà không dễ rách, đồng thời không che lấp hương vị của các thành phần đi kèm. Món này thể hiện rõ vai trò của một nguyên liệu nền, tuy đơn giản nhưng quyết định nhiều đến chất lượng tổng thể của trải nghiệm ăn cuốn.

Trong bối cảnh văn hóa ẩm thực Nam Bộ và Đông Nam Bộ, bánh tráng phơi sương Trảng Bàng là ví dụ điển hình cho một sản phẩm thủ công địa phương có giá trị vượt ra ngoài vai trò nguyên liệu thông thường. Nó không chỉ phục vụ nhu cầu ăn uống hàng ngày mà còn trở thành biểu tượng ẩm thực gắn với du lịch, quà tặng và nhận diện vùng. Trong cơ sở dữ liệu món ăn và đặc sản Việt Nam, món này nên được xếp vào nhóm đặc sản nguyên liệu truyền thống có kỹ thuật chế biến đặc thù và giá trị văn hóa địa phương rõ nét.',
    N'Trang Bang dew-softened rice paper is a famous specialty of Tay Ninh Province, closely associated with the Trang Bang area and regarded as one of the clearest examples of local food craftsmanship. This rice paper is made from rice batter, steamed into thin sheets, dried under sunlight, and then exposed to night dew to achieve its signature soft and supple texture. The “dew-softening” stage is what distinguishes it most strongly, allowing the finished product to remain flexible and ready to wrap without becoming brittle like toasted rice paper or too moist to handle.

In terms of texture and flavor, this rice paper has light chewiness, a soft surface, a gentle rice aroma, and a clean taste. Because of these qualities, it is especially suitable for wrapping boiled pork, fresh herbs, noodles, and dipping sauces, most notably in the well-known Trang Bang pork wrapping dish. It remains elastic enough to wrap tightly without tearing, while still subtle enough not to overpower the ingredients inside. In this sense, it is a foundational component: simple in appearance, but highly influential in the overall quality of the eating experience.

Within the culinary culture of Southern and Southeastern Vietnam, Trang Bang dew-softened rice paper is a strong example of a local handmade product whose value extends beyond that of an ordinary ingredient. It serves not only daily meals but also local tourism, gift culture, and regional identity. In a Vietnamese food and specialty database, it should be classified as a traditional crafted food product with distinctive processing technique and clear cultural significance.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'NAM_BO'),
    (SELECT TinhThanhID FROM dbo.TinhThanh WHERE MaTinh = 'TAY_NINH'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KINH'),
    N'https://vanhoatinnguong.vn/Uploads/images/banh-trang-phoi-suong-tay-ninh-21.jpg'
),
(
    'BO_TO',
    N'Bò Tơ',
    N'Young Veal',
    N'Món thịt',
    N'Meat dish',
    N'Đặc sản nổi tiếng với thịt mềm, ngọt và có thể chế biến thành nhiều món phong phú.',
    N'A famous specialty featuring tender, naturally sweet young beef prepared in many ways.',
    N'Bò tơ là tên gọi dùng để chỉ thịt bò còn non, thường được đánh giá cao bởi độ mềm, vị ngọt tự nhiên và khả năng chế biến đa dạng. Trong ẩm thực miền Nam, đặc biệt là các khu vực như Tây Ninh, bò tơ đã trở thành một đặc sản nổi tiếng và được phát triển thành nhiều món ăn khác nhau như bò hấp, bò nướng, bò cuốn bánh tráng, bò nhúng giấm, cháo bò hoặc lẩu bò. Nhờ đặc tính thịt mềm và ít dai hơn bò trưởng thành, nguyên liệu này phù hợp với cả những cách chế biến nhẹ nhằm giữ vị ngọt lẫn những món có gia vị đậm hơn.

Điểm nổi bật của bò tơ nằm ở chất lượng thịt. Phần nạc thường mềm, không quá thô sợi, trong khi phần gân và da nếu có cũng có độ giòn vừa phải, tạo ra cảm giác ăn phong phú. Tùy món cụ thể, bò có thể được thái mỏng để nhúng, cuốn, nướng hoặc chế biến thành các món chín kỹ hơn. Khi kết hợp cùng rau sống, bánh tráng, nước chấm hoặc các loại gia vị địa phương, bò tơ tạo nên một hệ món ăn khá linh hoạt, vừa phù hợp với bữa ăn gia đình, vừa thích hợp cho các bữa tụ họp đông người.

Trong hệ thống dữ liệu ẩm thực, bò tơ không chỉ là tên một nguyên liệu mà còn là một nhóm món đặc sản gắn với thương hiệu vùng miền, đặc biệt trong ẩm thực Đông Nam Bộ. Nó phản ánh xu hướng khai thác lợi thế nguyên liệu chăn nuôi địa phương, đồng thời cho thấy khả năng xây dựng bản sắc ẩm thực từ một nguyên liệu nền. Với mức độ phổ biến cao, giá trị thương mại rõ và khả năng chế biến phong phú, bò tơ là một đại diện phù hợp cho nhóm đặc sản thịt có tính nhận diện mạnh của miền Nam.',
    N'Young veal refers to meat from young cattle and is highly valued for its tenderness, natural sweetness, and versatility in cooking. In Southern Vietnamese cuisine, especially in areas such as Tay Ninh, young veal has become a famous specialty and is used in a wide range of dishes including steamed veal, grilled veal, veal wrapped with rice paper, veal dipped in vinegar broth, veal porridge, and hotpot. Because the meat is softer and less fibrous than fully matured beef, it works well both in light preparations that preserve its sweetness and in stronger-flavored dishes.

Its main appeal lies in the quality of the meat itself. Lean portions are tender and smooth rather than coarse, while connective tissue or skin, when present, can offer a pleasant crispness or chew. Depending on the dish, the veal may be sliced thin for dipping, wrapping, or grilling, or prepared in more fully cooked forms. When paired with fresh herbs, rice paper, dipping sauces, and regional seasonings, young veal becomes the basis for a highly flexible and social style of eating suitable for family meals as well as larger gatherings.

In a culinary database, young veal is not merely an ingredient name but also a category of regional specialties, especially associated with Southeastern Vietnam. It reflects the use of local livestock advantages and demonstrates how a strong culinary identity can be built around a core ingredient. Because of its popularity, commercial value, and wide culinary adaptability, young veal is a fitting representative of Southern meat specialties with strong regional recognition.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'NAM_BO'),
    (SELECT TinhThanhID FROM dbo.TinhThanh WHERE MaTinh = 'TAY_NINH'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KINH'),
    N'https://luhanhvietnam.com.vn/du-lich/vnt_upload/news/05_2022/quan-to-ngon-o-tay-ninh.jpg'
),
(
    'MUOI_TOM_TAY_NINH',
    N'Muối Tôm Tây Ninh',
    N'Tay Ninh Shrimp Salt',
    N'Gia vị',
    N'Condiment',
    N'Loại gia vị nổi tiếng với vị mặn, cay, ngọt hài hòa và hương thơm đặc trưng.',
    N'A famous seasoning with a balanced salty, spicy, and slightly sweet flavor.',
    N'Muối tôm Tây Ninh là một đặc sản gia vị nổi tiếng của vùng Đông Nam Bộ, đặc biệt gắn với tỉnh Tây Ninh. Dù có tên gọi là “muối tôm”, sản phẩm này không đơn thuần chỉ là muối pha tôm mà là một hỗn hợp gia vị được phối trộn từ muối, tôm khô, ớt, tỏi và một số thành phần khác theo công thức riêng. Sau khi xay, trộn và sấy hoặc rang đến độ khô thích hợp, gia vị có màu cam đỏ đặc trưng, mùi thơm đậm và vị rất hài hòa giữa mặn, cay, ngọt. Đây là một trong những loại gia vị có sức lan tỏa rộng rãi, được sử dụng cả trong ăn vặt lẫn trong chế biến món ăn.

Muối tôm Tây Ninh thường được dùng để chấm trái cây như xoài, cóc, ổi, dứa hoặc làm gia vị ăn kèm bánh tráng, đặc biệt là bánh tráng trộn và các món ăn vặt đường phố. Ngoài ra, nó còn có thể dùng để ướp hoặc rắc lên món nướng, món chiên hay món luộc nhằm tăng độ đậm đà. Điểm đặc biệt của loại gia vị này là dù có vị mạnh, nó vẫn giữ được độ cân bằng đủ để làm nổi bật nguyên liệu chính thay vì lấn át hoàn toàn. Hương thơm của tôm khô và tỏi tạo chiều sâu riêng, khiến sản phẩm trở nên dễ nhận biết và khác biệt so với các loại muối chấm thông thường.

Trong văn hóa ẩm thực hiện đại, muối tôm Tây Ninh là ví dụ rõ ràng cho việc một loại gia vị địa phương có thể vượt khỏi phạm vi sử dụng truyền thống để trở thành sản phẩm phổ biến trên toàn quốc. Nó gắn với thói quen ăn trái cây chấm gia vị, với văn hóa quà vặt và với hình ảnh ẩm thực Tây Ninh nói riêng. Trong cơ sở dữ liệu món ăn và đặc sản Việt Nam, muối tôm Tây Ninh nên được xếp vào nhóm gia vị đặc sản có giá trị nhận diện thương hiệu vùng cao, vừa thực dụng, vừa có sức ảnh hưởng lớn đến khẩu vị đại chúng.',
    N'Tay Ninh shrimp salt is a famous specialty seasoning from Southeastern Vietnam, especially associated with Tay Ninh Province. Although its name literally suggests “shrimp salt,” the product is more than simply salt mixed with shrimp. It is a blended seasoning typically made from salt, dried shrimp, chili, garlic, and other ingredients prepared according to local formulas. After grinding, mixing, and drying or roasting to the proper level, the seasoning develops a characteristic orange-red color, a strong aroma, and a well-balanced salty, spicy, and slightly sweet flavor. It is one of the regional condiments that has spread most widely beyond its place of origin and is now used in both snacks and cooked dishes.

Tay Ninh shrimp salt is commonly used as a dip for fruits such as green mango, ambarella, guava, or pineapple, and as a seasoning for rice paper snacks, especially mixed rice paper and other street foods. It can also be used in marinades or sprinkled on grilled, fried, or boiled dishes to intensify flavor. One of its strengths is that even though it is bold, it often remains balanced enough to enhance rather than completely overwhelm the main ingredient. The aroma of dried shrimp and garlic gives it a recognizable depth that sets it apart from ordinary chili salt blends.

In modern food culture, Tay Ninh shrimp salt is a clear example of how a local seasoning can move beyond traditional regional use and become popular nationwide. It is closely connected to fruit-dipping habits, snack culture, and the broader culinary image of Tay Ninh. In a Vietnamese food and specialty database, it should be classified as a regional condiment with strong brand identity, practical value, and wide influence on popular taste.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'NAM_BO'),
    (SELECT TinhThanhID FROM dbo.TinhThanh WHERE MaTinh = 'TAY_NINH'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KINH'),
    N'https://statics.vinpearl.com/muoi-tom-tay-ninh-7_1631532984.png'
),
(
    'GOI_CA_BIEN_HOA',
    N'Gỏi Cá Biên Hòa',
    N'Bien Hoa Raw Fish Salad',
    N'Món gỏi',
    N'Salad',
    N'Món gỏi cá đặc trưng với vị tươi, chua nhẹ và đậm đà.',
    N'A regional raw fish salad with fresh, slightly sour, and rich flavors.',
    N'Gỏi cá Biên Hòa là một món ăn đặc trưng của vùng Đồng Nai, nổi bật với cách chế biến cá tươi kết hợp cùng các gia vị và rau sống tạo nên hương vị hài hòa và đặc sắc. Cá được sử dụng thường là các loại cá nước ngọt tươi, được làm sạch kỹ, thái lát mỏng và xử lý để giảm mùi tanh. Sau đó cá được trộn với các loại gia vị như thính, hành, tỏi, ớt và nước cốt chanh hoặc giấm để tạo độ chua nhẹ, giúp cân bằng hương vị.

Khi thưởng thức, gỏi cá thường được ăn kèm với rau sống, bánh tráng và nước chấm đậm đà. Người ăn cuốn cá cùng rau rồi chấm, tạo nên sự kết hợp giữa vị tươi, vị chua, vị cay và vị béo. Món ăn mang lại cảm giác nhẹ nhưng vẫn đậm vị, phù hợp với khẩu vị miền Nam.

Trong văn hóa ẩm thực địa phương, gỏi cá Biên Hòa thể hiện rõ cách sử dụng nguyên liệu tươi sống và kỹ thuật xử lý để đảm bảo an toàn và hương vị. Đây là đại diện tiêu biểu cho nhóm món gỏi cá miền Nam, mang tính đặc trưng vùng sông nước.',
    N'Bien Hoa raw fish salad is a regional specialty from Dong Nai, known for its preparation of fresh fish combined with herbs and seasonings to create a balanced and distinctive flavor. Freshwater fish is typically used, carefully cleaned, thinly sliced, and treated to reduce any fishy odor. It is then mixed with roasted rice powder, garlic, chili, and acidic elements such as lime juice or vinegar to create a mild sourness.

The dish is usually served with fresh herbs, rice paper, and a flavorful dipping sauce. Diners wrap the fish with herbs and dip it, creating a combination of fresh, sour, spicy, and rich flavors. The result is a dish that feels light yet flavorful.

This dish reflects Southern Vietnamese culinary practices of using fresh ingredients and careful preparation. It stands as a representative of raw fish salads in riverine regions.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'NAM_BO'),
    (SELECT TinhThanhID FROM dbo.TinhThanh WHERE MaTinh = 'DONG_NAI'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KINH'),
    N'https://timtour.vn/files/images/AnGiNgon/goi-ca-bien-hoa-2.jpg'
),
(
    'BUOI_TAN_TRIEU',
    N'Bưởi Tân Triều',
    N'Tan Trieu Pomelo',
    N'Trái cây',
    N'Fruit',
    N'Đặc sản trái cây nổi tiếng với vị ngọt thanh và múi mọng nước.',
    N'A famous pomelo known for its sweet, refreshing taste and juicy segments.',
    N'Bưởi Tân Triều là một đặc sản nổi tiếng của vùng Đồng Nai, đặc biệt là khu vực cù lao Tân Triều, nơi có điều kiện đất đai và khí hậu phù hợp để phát triển loại cây này. Trái bưởi có kích thước vừa phải, vỏ mỏng, múi to, mọng nước và có vị ngọt thanh đặc trưng. Một số giống còn có hương thơm nhẹ và ít hạt, làm tăng giá trị sử dụng và trải nghiệm thưởng thức.

Bưởi thường được ăn tươi, dùng làm món tráng miệng hoặc chế biến thành các món gỏi, salad. Nhờ vị ngọt dịu và độ mọng nước cao, bưởi Tân Triều mang lại cảm giác thanh mát, phù hợp với khí hậu nóng của miền Nam. Ngoài ra, phần vỏ và cùi bưởi cũng có thể được tận dụng để làm mứt hoặc món ăn khác.

Trong hệ thống đặc sản Việt Nam, bưởi Tân Triều là đại diện tiêu biểu cho nhóm trái cây vùng Đông Nam Bộ, thể hiện rõ sự kết hợp giữa điều kiện tự nhiên và kỹ thuật trồng trọt địa phương. Món này không chỉ có giá trị dinh dưỡng mà còn mang ý nghĩa kinh tế và du lịch.',
    N'Tan Trieu pomelo is a well-known fruit specialty from Dong Nai Province, especially the Tan Trieu islet area, where soil and climate conditions are ideal for cultivation. The fruit is medium-sized with a thin peel, large segments, and juicy flesh that offers a naturally sweet and refreshing taste. Some varieties also have a subtle fragrance and fewer seeds, enhancing the eating experience.

It is commonly consumed fresh as a dessert or used in salads and other dishes. Its mild sweetness and high juiciness make it especially suitable for hot climates. Additionally, the peel and pith can be used to make candied products or other preparations.

In a Vietnamese specialty database, Tan Trieu pomelo represents fruit products from Southeastern Vietnam, highlighting the link between natural conditions and local agricultural expertise. It holds both nutritional and economic value.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'NAM_BO'),
    (SELECT TinhThanhID FROM dbo.TinhThanh WHERE MaTinh = 'DONG_NAI'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KINH'),
    N'https://ik.imagekit.io/tvlk/blog/2022/08/buoi-tan-trieu-la-dac-san-dia-danh-nao.jpeg'
),
(
    'DOI_XAO_LAN',
    N'Dơi Xào Lăn',
    N'Stir-fried Bat with Curry',
    N'Món xào',
    N'Stir-fried dish',
    N'Món ăn đặc trưng với hương vị đậm đà, mang tính địa phương cao.',
    N'A unique regional stir-fried dish with bold and distinctive flavor.',
    N'Dơi xào lăn là một món ăn đặc trưng xuất hiện ở một số vùng miền Nam, thường gắn với các khu vực có nguồn nguyên liệu đặc biệt và tập quán ẩm thực riêng. Nguyên liệu chính là thịt dơi, được sơ chế kỹ để loại bỏ mùi đặc trưng, sau đó thái nhỏ và xào với các loại gia vị như sả, ớt, nước cốt dừa và bột cà ri. Cách chế biến này tạo nên món ăn có hương vị đậm đà, béo nhẹ và thơm đặc trưng.

Khi hoàn thành, món ăn có màu vàng hấp dẫn, thịt mềm và thấm gia vị. Vị béo của nước cốt dừa kết hợp với mùi thơm của sả và vị cay nhẹ của ớt tạo nên tổng thể hài hòa. Món thường được ăn nóng, kèm rau hoặc bánh mì để tăng trải nghiệm.

Trong văn hóa ẩm thực, dơi xào lăn là một ví dụ điển hình cho sự đa dạng và tính đặc thù của ẩm thực địa phương Việt Nam. Món ăn phản ánh sự thích nghi và khai thác nguồn nguyên liệu đặc biệt, đồng thời thể hiện sự phong phú trong khẩu vị vùng miền.',
    N'Stir-fried bat with curry is a unique dish found in certain Southern Vietnamese regions, often associated with local culinary traditions and specific ingredient availability. The main ingredient is bat meat, which is carefully cleaned to remove its strong odor, then cut into pieces and stir-fried with lemongrass, chili, coconut milk, and curry powder. This method produces a rich and aromatic dish.

The finished dish has an appealing golden color, tender meat, and well-infused seasoning. The richness of coconut milk combines with the fragrance of lemongrass and mild chili heat to create a balanced flavor. It is typically served hot, sometimes accompanied by herbs or bread.

In culinary culture, this dish illustrates the diversity and specificity of regional Vietnamese cuisine, reflecting adaptation to available ingredients and varied local tastes.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'NAM_BO'),
    (SELECT TinhThanhID FROM dbo.TinhThanh WHERE MaTinh = 'DONG_NAI'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KINH'),
    N'https://icdn.dantri.com.vn/thumb_w/960/2017/doi-dong-nai-3-1495771577560.jpg'
),
(
    'BANH_KHOT',
    N'Bánh Khọt',
    N'Banh Khot',
    N'Món bánh',
    N'Savory mini pancake',
    N'Món bánh nhỏ giòn, béo với nhân tôm đặc trưng.',
    N'A small crispy pancake with shrimp topping.',
    N'Bánh khọt là một món ăn nổi tiếng của vùng Bà Rịa – Vũng Tàu, được biết đến với hình dạng nhỏ, tròn và lớp vỏ giòn. Bánh được làm từ bột gạo pha loãng, đổ vào khuôn nhỏ và chiên trong dầu. Nhân bánh thường là tôm, đôi khi có thêm hành hoặc đậu xanh. Khi chín, bánh có lớp vỏ vàng giòn, bên trong mềm và thơm.

Bánh khọt thường được ăn kèm với rau sống, đồ chua và nước mắm pha. Khi ăn, bánh được cuốn với rau rồi chấm, tạo sự cân bằng giữa vị béo và vị tươi. Sự kết hợp này làm cho món ăn không bị ngấy và trở nên hấp dẫn hơn.

Trong ẩm thực miền Nam, bánh khọt là một biến thể tiêu biểu của các món bánh chiên, thể hiện sự sáng tạo trong cách chế biến và phục vụ. Đây là món ăn vừa mang tính đường phố vừa có giá trị đặc sản vùng.',
    N'Banh khot is a well-known dish from Ba Ria – Vung Tau, recognized for its small, round shape and crispy texture. It is made from rice batter poured into small molds and fried in oil. The topping is typically shrimp, sometimes accompanied by scallions or mung beans. When cooked, the pancake has a golden crispy exterior and a soft interior.

It is usually served with fresh herbs, pickled vegetables, and dipping fish sauce. Diners wrap the pancakes with herbs and dip them, creating a balance between richness and freshness.

In Southern cuisine, banh khot represents a creative variation of fried pancakes, combining street food appeal with regional specialty value.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'NAM_BO'),
    (SELECT TinhThanhID FROM dbo.TinhThanh WHERE MaTinh = 'HO_CHI_MINH'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KINH'),
    N'https://cdn2.fptshop.com.vn/unsafe/1920x0/filters:format(webp):quality(75)/banh_khot_mien_tay_81cb79bfd8.png'
),
(
    'GOI_CA_MAI',
    N'Gỏi Cá Mai',
    N'Mai Fish Salad',
    N'Món gỏi',
    N'Salad',
    N'Món gỏi cá nổi tiếng với vị tươi, chua nhẹ và kết cấu mềm.',
    N'A fresh fish salad with light sourness and delicate texture.',
    N'Gỏi cá mai là một đặc sản nổi tiếng của vùng biển Nam Trung Bộ, đặc biệt tại các tỉnh như Ninh Thuận và Khánh Hòa. Cá mai là loại cá nhỏ, thịt trắng, ít tanh, rất phù hợp để chế biến món gỏi. Cá được làm sạch, rút xương, sau đó trộn với nước cốt chanh hoặc giấm để tạo độ chua nhẹ và làm tái thịt cá.

Món gỏi thường được kết hợp với hành, tỏi, ớt, đậu phộng và các loại rau sống, tạo nên hương vị hài hòa giữa chua, cay và bùi. Khi ăn, cá có độ mềm, tươi và không bị nặng mùi. Món ăn thường đi kèm bánh tráng và nước chấm đặc trưng.

Gỏi cá mai thể hiện rõ nét ẩm thực biển với cách tận dụng nguyên liệu tươi và chế biến tinh tế. Đây là một trong những món gỏi cá tiêu biểu của Việt Nam.',
    N'Mai fish salad is a well-known specialty from South Central coastal regions such as Ninh Thuan and Khanh Hoa. Mai fish are small, white-fleshed fish with minimal odor, making them ideal for raw-style preparation. The fish is cleaned, deboned, and mixed with lime juice or vinegar to lightly cure the flesh.

The salad is combined with garlic, chili, peanuts, and herbs, creating a balance of sour, spicy, and nutty flavors. The fish remains soft and fresh-tasting without a strong smell. It is typically served with rice paper and dipping sauce.

This dish represents coastal Vietnamese cuisine, emphasizing freshness and careful preparation of seafood. It is considered one of the representative raw fish salads in Vietnam.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'TRUNG_BO'),
    (SELECT TinhThanhID FROM dbo.TinhThanh WHERE MaTinh = 'DONG_NAI'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KINH'),
    N'https://cdn2.fptshop.com.vn/unsafe/1920x0/filters:format(webp):quality(75)/2023_12_21_638387951937457298_goi-ca-mai-avt.jpg'
),
(
    'TIET_CANH_TOM_HUM',
    N'Tiết Canh Tôm Hùm',
    N'Lobster Blood Pudding',
    N'Món đặc sản',
    N'Specialty dish',
    N'Món ăn đặc biệt với nguyên liệu quý, mang tính trải nghiệm và nhận diện vùng biển.',
    N'A distinctive specialty made from premium seafood, known for its experiential and regional character.',
    N'Tiết canh tôm hùm là một món ăn được nhắc đến như một đặc sản đặc biệt trong một số vùng biển, gây chú ý bởi tên gọi khác lạ, nguyên liệu cao cấp và tính trải nghiệm rất mạnh. Không giống các món hải sản quen thuộc như hấp, nướng hay cháo, món này thường được xem như một biến thể ẩm thực hiếm gặp, gắn với thói quen thưởng thức đặc sản địa phương hơn là một món ăn phổ biến đại trà. Chính vì vậy, trong ngữ cảnh dữ liệu ẩm thực, đây là món mang tính nhận diện cao, thường được xếp vào nhóm món đặc sản độc đáo hơn là nhóm món ăn thông dụng.

Về bản chất cảm quan, món ăn này thường được mô tả theo hướng nhấn mạnh sự tươi, độ ngọt của nguyên liệu biển và kết cấu mềm, mát đặc trưng của dạng tiết canh. Các thành phần ăn kèm có thể bao gồm gia vị, rau thơm, lạc rang hoặc các yếu tố hỗ trợ tạo mùi và tạo độ cân bằng vị giác, tùy theo cách trình bày ở từng nơi. So với những món tôm hùm chế biến bằng nhiệt, món này tạo ấn tượng theo hướng khác hẳn: không đặt trọng tâm vào độ săn chắc của thịt, mà thiên về cảm giác lạ miệng, tính hiếm và sự tò mò của người thưởng thức.

Trong bối cảnh văn hóa ẩm thực, tiết canh tôm hùm phản ánh một nhánh rất đặc thù của việc khai thác nguyên liệu biển trong đời sống địa phương, nơi giá trị món ăn không chỉ nằm ở độ ngon thông thường mà còn ở sự độc đáo và khả năng gợi nhớ. Tuy nhiên, do tính chất không phổ biến và sự khác biệt giữa các nơi trong cách mô tả hay phục vụ, món này phù hợp được ghi nhận trong cơ sở dữ liệu như một món đặc sản vùng biển có tính hiếm, với nội dung giới thiệu theo hướng mô tả trung tính và nhấn mạnh bản sắc thay vì đóng khung vào một công thức duy nhất.',
    N'Lobster blood pudding is sometimes mentioned as a highly unusual coastal specialty, attracting attention because of its striking name, premium seafood ingredient, and strong experiential character. Unlike more familiar lobster dishes such as steaming, grilling, or porridge, this dish is better understood as a rare local specialty associated with regional food culture rather than as a widely consumed everyday item. For this reason, in a culinary database it is best classified as a distinctive specialty dish with strong recognition value rather than a common seafood preparation.

In sensory terms, the dish is generally described through its emphasis on freshness, the natural sweetness of marine ingredients, and the cool, soft texture typical of blood-based preparations. Accompanying ingredients may include herbs, roasted peanuts, and seasoning elements that add fragrance and balance, although presentation can vary from place to place. Compared with heat-cooked lobster dishes, this one creates an entirely different impression: it is less about the firm texture of lobster meat and more about novelty, rarity, and culinary curiosity.

Within food culture, lobster blood pudding reflects a very specialized branch of coastal cuisine, where the value of a dish lies not only in taste but also in distinctiveness and memorability. Because it is not widely standardized and may differ in description or serving style depending on locality, it is most appropriate in a database as a rare coastal specialty introduced in neutral terms that emphasize identity rather than a fixed canonical recipe.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'NAM_BO'),
    (SELECT TinhThanhID FROM dbo.TinhThanh WHERE MaTinh = 'DONG_NAI'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KINH'),
    N'https://danviet.ex-cdn.com/resize/800x450/files/f1/296231569849192448/2022/12/16/-pha-mon-tiet-canh-tom-hum-dac-san-vung-tau-ngon-nuc-tieng-hinh-3-155610919317152071518520221215235254-1671183118257284627202-21-0-359-540-crop-1671183246913778944048.jpg'
),
(
    'LAU_SUNG_PHUOC_HAI',
    N'Lẩu Súng Phước Hải',
    N'Phuoc Hai Water Mimosa Hotpot',
    N'Món lẩu',
    N'Hotpot',
    N'Món lẩu vùng biển kết hợp vị thanh của rau súng với hương vị đậm đà của nước dùng.',
    N'A coastal hotpot combining the delicate taste of water mimosa with a rich broth.',
    N'Lẩu súng Phước Hải là món ăn mang dấu ấn địa phương, gắn với vùng biển Phước Hải và được nhận diện qua việc sử dụng rau súng như một thành phần nổi bật trong nồi lẩu. Rau súng là nguyên liệu quen thuộc ở nhiều vùng sông nước miền Nam, có độ giòn nhẹ, vị thanh và khả năng tạo cảm giác tươi mát khi ăn kèm với nước dùng nóng. Khi xuất hiện trong món lẩu vùng biển, rau súng góp phần tạo nên một bản sắc khác biệt so với những loại lẩu chỉ nhấn mạnh vào hải sản hay vị chua cay thông thường.

Điểm đặc trưng của món ăn này nằm ở sự kết hợp giữa phần nước lẩu đậm vị và rau súng có tính chất mộc mạc, thanh nhẹ. Tùy từng cách nấu, nước dùng có thể được xây dựng theo hướng ngọt thanh từ hải sản hoặc theo hướng đậm đà hơn với các gia vị địa phương, nhưng nhìn chung món ăn thường tạo ấn tượng nhờ sự cân bằng giữa chất biển và chất đồng quê. Rau súng khi nhúng vừa chín tới sẽ giữ được độ giòn và góp phần làm nồi lẩu bớt nặng, đồng thời tạo thêm trải nghiệm kết cấu cho người ăn.

Trong cơ sở dữ liệu ẩm thực, lẩu súng Phước Hải có thể được xem là một đại diện thú vị cho nhóm món lẩu địa phương gắn với điều kiện tự nhiên bản địa. Món ăn cho thấy cách cộng đồng ven biển có thể kết hợp nguyên liệu quen thuộc của vùng sông nước và vùng biển để tạo ra một hình thức thưởng thức mang tính cộng đồng, phù hợp với bữa ăn đông người. Với yếu tố địa danh rõ ràng và nguyên liệu nhận diện mạnh, đây là món đáng ghi nhận như một đặc sản vùng ven biển Nam Bộ.',
    N'Phuoc Hai water mimosa hotpot is a locally identified dish associated with the coastal area of Phuoc Hai and recognized for the prominent use of water mimosa as a defining ingredient. Water mimosa is familiar in many river-based food traditions of Southern Vietnam, valued for its light crunch, delicate taste, and ability to add freshness when served in hot broth. When used in a coastal-style hotpot, it gives the dish a distinct identity that differs from hotpots focused only on seafood or on sharply sour and spicy flavors.

The defining character of this dish lies in the contrast between a flavorful broth and the rustic, delicate nature of water mimosa. Depending on the cooking style, the broth may lean toward a clean natural sweetness from seafood or toward a more seasoned and robust local profile, but the dish generally stands out because it balances marine richness with the freshness of a countryside vegetable. When lightly cooked in the broth, the water mimosa retains a gentle crunch that keeps the hotpot from feeling too heavy and adds textural interest.

In a culinary database, Phuoc Hai water mimosa hotpot can be considered an interesting example of a regional hotpot rooted in local natural conditions. It shows how coastal communities can combine familiar ingredients from both riverine and marine food culture to create a communal dish suited to shared meals. With its clear place-name identity and its distinctive key ingredient, it is a strong candidate for classification as a Southern coastal specialty.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'NAM_BO'),
    NULL,
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KINH'),
    N'https://bariavungtautourism.com.vn/wp-content/uploads/2024/04/lau-sung-phuoc-hai-vung-tau-10.jpg'
),
(
    'LAU_MAM',
    N'Lẩu Mắm',
    N'Fermented Fish Hotpot',
    N'Món lẩu',
    N'Hotpot',
    N'Món lẩu đậm đà đặc trưng miền Tây với nền mắm, rau đồng và nhiều loại nguyên liệu ăn kèm.',
    N'A signature Mekong Delta hotpot built on fermented fish broth, local vegetables, and varied ingredients.',
    N'Lẩu mắm là một trong những món ăn tiêu biểu nhất của miền Tây Nam Bộ, nổi bật với nước lẩu được xây dựng trên nền mắm và sự phong phú của nguyên liệu ăn kèm. Món ăn thường được nhắc đến như một đại diện rõ nét cho khẩu vị đậm đà, nhiều tầng hương và giàu tính cộng đồng của ẩm thực miền sông nước. Nước lẩu thường có mùi thơm đặc trưng của mắm đã được xử lý và nấu kỹ để tạo độ sâu vị, sau đó kết hợp với nước dùng, sả, tỏi, ớt và các gia vị khác để đạt được trạng thái đậm nhưng vẫn dễ ăn. Đây là kiểu món ăn đòi hỏi kỹ thuật cân bằng mùi vị rất tốt, vì nếu nêm thiếu sẽ nhạt và nếu nêm quá tay sẽ gắt.

Điểm hấp dẫn nhất của lẩu mắm nằm ở phần nguyên liệu nhúng rất đa dạng. Tùy địa phương và cách phục vụ, nồi lẩu có thể đi kèm cá, tôm, mực, thịt heo quay, cà tím, bông súng, rau nhút, bông điên điển, rau đắng, cải xanh, kèo nèo và nhiều loại rau đồng khác. Chính sự đa dạng này khiến lẩu mắm không chỉ là một món lẩu mà còn là một bức tranh thu nhỏ của hệ sinh thái ẩm thực miền Tây. Người ăn có thể cảm nhận rõ độ đậm của nước lẩu, vị ngọt của hải sản hoặc cá thịt, độ tươi của rau và sự phong phú về kết cấu khi nhiều thành phần cùng xuất hiện trong một nồi ăn.

Trong đời sống văn hóa ẩm thực, lẩu mắm là món ăn gắn rất chặt với tính cộng đồng và tính chia sẻ. Đây là món thường phù hợp với bữa ăn gia đình, bạn bè hoặc dịp tụ họp đông người, nơi mọi người cùng nhúng, cùng ăn và cùng điều chỉnh khẩu vị theo sở thích. Trong cơ sở dữ liệu món ăn Việt Nam, lẩu mắm là một đại diện có tính biểu tượng rất cao của miền Tây Nam Bộ, phản ánh rõ đặc trưng sử dụng mắm, rau đồng và tư duy kết hợp phong phú của ẩm thực vùng sông nước. :contentReference[oaicite:1]{index=1}',
    N'Fermented fish hotpot is one of the most representative dishes of the Mekong Delta, known for a broth built on fermented fish and for the remarkable variety of accompanying ingredients. It is often regarded as a clear expression of the bold, layered, and communal character of Southwestern Vietnamese cuisine. The broth typically carries the characteristic aroma of fermented fish that has been carefully cooked and refined, then combined with stock, lemongrass, garlic, chili, and other seasonings to achieve a deep flavor that remains approachable. This is a dish that requires excellent balance, because too little seasoning makes it flat, while too much can make it overly sharp.

One of its most appealing aspects is the diversity of ingredients cooked in the hotpot. Depending on locality and serving style, the pot may include fish, shrimp, squid, roasted pork belly, eggplant, water lily stems, water mimosa, sesbania flowers, bitter herbs, mustard greens, and many other vegetables typical of the Mekong Delta. This variety makes fermented fish hotpot more than just a hotpot dish; it becomes a compact reflection of the region’s culinary ecosystem. Diners experience the deep broth, the sweetness of seafood or meat, the freshness of herbs and vegetables, and a wide range of textures in a single shared meal.

In culinary culture, fermented fish hotpot is strongly associated with communal eating and shared dining. It is especially suited to family meals, gatherings of friends, and occasions where people cook and eat together at the table. In a Vietnamese food database, it should be treated as a highly symbolic dish of the Mekong Delta, clearly reflecting the region’s use of fermented fish, wild vegetables, and its generous approach to combining ingredients in one meal. :contentReference[oaicite:2]{index=2}',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'NAM_BO'),
    (SELECT TinhThanhID FROM dbo.TinhThanh WHERE MaTinh = 'CAN_THO'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KINH'),
    N'https://product.hstatic.net/1000093072/product/lau_mam_u_minh_a0247bf5e2af4c4bb0e9fe366c3c7ec7_master.jpg'
),
(
    'BUN_NUOC_LEO',
    N'Bún Nước Lèo',
    N'Bun Nuoc Leo',
    N'Món nước',
    N'Noodle soup',
    N'Món bún đặc trưng miền Tây với nước lèo đậm vị, gắn mạnh với Sóc Trăng và ảnh hưởng Khmer.',
    N'A Mekong noodle soup with a distinctive broth, strongly associated with Soc Trang and Khmer culinary influence.',
    N'Bún nước lèo là một món ăn rất đặc trưng của miền Tây Nam Bộ, thường được nhắc đến nhiều nhất khi nói về Sóc Trăng và dấu ấn ẩm thực Khmer trong khu vực. Tên gọi của món ăn đến từ phần “nước lèo”, tức nước dùng có bản sắc rất riêng, thường được mô tả là đậm vị, thơm và có chiều sâu hơn so với nhiều món bún nước thông thường. Đây là món ăn thể hiện rõ sự giao thoa văn hóa giữa các cộng đồng cư dân Nam Bộ, trong đó yếu tố địa phương và yếu tố dân tộc hòa trộn để hình thành nên một bản sắc ẩm thực riêng biệt. :contentReference[oaicite:3]{index=3}

Một tô bún nước lèo thường gồm bún, nước dùng, cùng các thành phần ăn kèm có thể thay đổi theo địa phương và cách bán, chẳng hạn như cá, tôm, thịt quay, rau sống hoặc rau thơm. Điều quan trọng nhất vẫn là phần nước lèo, bởi đây là yếu tố quyết định tính nhận diện của món ăn. Nước dùng phải đạt được sự cân bằng giữa mùi thơm đặc trưng và độ ngọt vừa phải, đồng thời đủ đậm để tạo dấu ấn nhưng không quá nặng khiến người ăn cảm thấy gắt. Nhờ vậy, bún nước lèo thường mang cảm giác vừa lạ vừa quen, dễ làm người ăn nhớ lâu dù nguyên liệu đi kèm có thể khá giản dị.

Trong hệ thống món ăn miền Tây, bún nước lèo là đại diện tiêu biểu cho kiểu món nước vừa mang tính dân dã vừa chứa chiều sâu văn hóa. Nó không chỉ là món ăn để no mà còn là một biểu hiện của lịch sử giao thoa ẩm thực trong vùng. Trong cơ sở dữ liệu món ăn Việt Nam, bún nước lèo nên được ghi nhận như một đặc sản có tính vùng rõ rệt, mang giá trị đại diện mạnh cho Sóc Trăng và cho phong cách ẩm thực Nam Bộ giàu tính tổng hợp. :contentReference[oaicite:4]{index=4}',
    N'Bun nuoc leo is a highly distinctive noodle soup of the Mekong Delta and is most strongly associated with Soc Trang and the Khmer culinary imprint in the region. The name refers to the “nuoc leo,” or broth, which is widely recognized as the defining element of the dish and is often described as deep, aromatic, and more distinctive than the broths of many ordinary noodle soups. The dish clearly reflects cultural exchange among Southern Vietnamese communities, where local and ethnic influences combine to form a recognizable regional food identity. :contentReference[oaicite:5]{index=5}

A bowl of bun nuoc leo usually includes rice noodles, broth, and toppings that may vary by locality and vendor, such as fish, shrimp, roasted pork, fresh vegetables, or herbs. Even with these variations, the broth remains the most important part because it determines the identity of the dish. A good broth needs to balance its distinctive aroma with moderate sweetness and enough depth to be memorable without becoming overpowering. As a result, bun nuoc leo often feels both rustic and special, leaving a lasting impression even when the ingredients themselves are relatively simple.

Within Mekong Delta cuisine, bun nuoc leo is a representative noodle dish that combines everyday accessibility with strong cultural depth. It is not merely a filling meal but also a reflection of the region’s layered culinary history. In a Vietnamese food database, it should be recognized as a specialty with clear regional identity and strong representative value for Soc Trang as well as for the broader mixed culinary traditions of Southern Vietnam. :contentReference[oaicite:6]{index=6}',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'NAM_BO'),
    (SELECT TinhThanhID FROM dbo.TinhThanh WHERE MaTinh = 'SOC_TRANG'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KINH'),
    N'https://cdn2.fptshop.com.vn/unsafe/1920x0/filters:format(webp):quality(75)/2024_4_22_638493802727484365_bun-nuoc-leo-1.jpg'
),
(
    'CANH_CHUA_CA_CHOT',
    N'Canh Chua Cá Chốt',
    N'Sour Soup with Catfish',
    N'Món canh',
    N'Soup',
    N'Món canh chua dân dã miền Tây với vị chua thanh, ngọt cá và rau đi kèm phong phú.',
    N'A rustic Mekong sour soup with gentle acidity, sweet fish flavor, and varied vegetables.',
    N'Canh chua cá chốt là một món ăn dân dã đặc trưng của miền Tây Nam Bộ, gắn với môi trường sông ngòi, kênh rạch và nguồn cá đồng phong phú của vùng. Cá chốt là loại cá nước ngọt nhỏ, thịt mềm, vị ngọt và thường được dùng trong các món canh chua vì cho cảm giác gần gũi, dễ ăn. Trong món này, cá chốt thường được nấu cùng các nguyên liệu tạo vị chua như me hoặc những thành phần chua quen thuộc khác, kết hợp với rau, giá, bạc hà, cà chua hoặc các loại rau thơm tùy theo phong cách nấu. Tổng thể món ăn hướng đến sự thanh mát, dịu vị nhưng vẫn đậm tính sông nước.

Điểm hấp dẫn của canh chua cá chốt nằm ở sự cân bằng giữa vị chua, vị ngọt và hương thơm của rau gia vị. Nước canh không quá đặc hay quá nặng, mà thiên về độ trong và vị chua dịu, giúp làm nổi bật vị ngọt của cá. Cá chốt tuy nhỏ nhưng nếu chế biến khéo sẽ giữ được độ mềm của thịt mà không bị nát, đồng thời tạo chiều sâu hương vị cho nồi canh. Khi ăn cùng cơm nóng, món canh này mang lại cảm giác nhẹ bụng, dễ chịu và rất đúng tinh thần bữa cơm gia đình miền Tây.

Trong cơ sở dữ liệu ẩm thực, canh chua cá chốt là một đại diện phù hợp cho nhóm món canh chua Nam Bộ sử dụng cá đồng hoặc cá nước ngọt địa phương. Món ăn không cầu kỳ nhưng phản ánh rõ lối sống gắn với thiên nhiên và khả năng nấu nướng dựa trên nguyên liệu sẵn có của cư dân miền sông nước. Với tính phổ biến, mộc mạc và giàu bản sắc vùng, đây là món nên được ghi nhận như một món ăn nền tảng của ẩm thực miền Tây.',
    N'Sour soup with catfish is a rustic dish of the Mekong Delta, closely associated with the region’s rivers, canals, and abundant freshwater fish. Catfish of this type is a small freshwater species with tender flesh and natural sweetness, making it well suited to sour soup preparations. In this dish, the fish is typically cooked with souring ingredients such as tamarind or other familiar acidic elements, together with vegetables, bean sprouts, taro stem, tomatoes, and herbs depending on local cooking style. The overall character of the soup is light, refreshing, and clearly rooted in river-based cuisine.

Its appeal lies in the balance between acidity, sweetness, and herbal fragrance. The broth is not meant to be thick or heavy; instead, it is usually fairly clear with a gentle sourness that highlights the sweetness of the fish. Although the fish is small, careful preparation can keep the flesh tender without falling apart, while still giving the soup notable depth of flavor. Served with hot rice, the dish creates a comforting and easy-to-eat meal strongly associated with Southern family cooking.

In a culinary database, sour soup with catfish is an appropriate representative of Southern Vietnamese sour soups that rely on local freshwater fish. It is simple rather than elaborate, yet it clearly reflects a way of life tied to nature and a cooking tradition shaped by available ingredients. Because of its familiarity, rustic quality, and strong regional identity, it deserves recognition as one of the foundation dishes of Mekong Delta cuisine.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'NAM_BO'),
    NULL,
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KINH'),
    N'https://cdn.tgdd.vn/2020/12/CookProduct/canh-chua-ca-chot-thumbnail-8-1200x676.jpg'
),
(
    'LAP_XUONG_CAN_DUOC',
    N'Lạp Xưởng Cần Đước',
    N'Can Duoc Fresh Chinese Sausage',
    N'Món đặc sản',
    N'Specialty sausage',
    N'Đặc sản Long An nổi tiếng với vị ngọt mặn hài hòa, thơm mùi thịt và gia vị.',
    N'A Long An specialty known for its balanced sweet-savory flavor and fragrant seasoning.',
    N'Lạp xưởng Cần Đước là một trong những đặc sản nổi tiếng của tỉnh Long An, thường được nhắc đến cùng với dòng lạp xưởng tươi của khu vực Cần Đước – Cần Giuộc. Món ăn này được làm chủ yếu từ thịt heo, mỡ heo và gia vị, phối trộn theo tỷ lệ riêng để tạo nên hương vị đặc trưng. Không giống một số loại lạp xưởng khô thiên về độ rắn và mặn, lạp xưởng Cần Đước thường được biết đến ở dạng tươi, có độ mềm nhất định, phần nhân thịt rõ cấu trúc và mùi thơm đậm khi chế biến. Chính đặc điểm này khiến món ăn vừa phù hợp để dùng trong bữa cơm gia đình, vừa thích hợp làm quà biếu gắn với địa danh.

Về cảm quan, lạp xưởng Cần Đước có vị mặn ngọt hài hòa, độ béo vừa phải và mùi thơm đặc trưng của thịt ướp gia vị. Khi chiên, nướng hoặc áp chảo, lớp vỏ ngoài se lại, hơi bóng và dậy mùi hấp dẫn, trong khi phần nhân bên trong vẫn giữ được độ mềm, mọng và vị ngọt thịt rõ rệt. Món ăn có thể dùng kèm cơm, xôi, dưa chua hoặc ăn riêng như một món mặn. Nhờ đặc tính dễ chế biến và hương vị gần gũi, lạp xưởng Cần Đước có sức phổ biến cao hơn nhiều so với các món đặc sản chỉ dùng trong dịp riêng biệt.

Trong bối cảnh ẩm thực địa phương, lạp xưởng Cần Đước phản ánh rõ truyền thống chế biến thực phẩm của vùng Nam Bộ, nơi các sản phẩm từ thịt được phát triển thành mặt hàng vừa phục vụ đời sống thường nhật vừa có giá trị thương mại. Đây là món ăn cho thấy khả năng xây dựng thương hiệu vùng từ một sản phẩm tưởng như quen thuộc, thông qua kỹ thuật ướp, tỷ lệ nguyên liệu và thói quen sử dụng địa phương. Trong cơ sở dữ liệu món ăn Việt Nam, lạp xưởng Cần Đước là đại diện phù hợp cho nhóm đặc sản chế biến từ thịt có tính nhận diện địa phương rõ rệt.',
    N'Can Duoc fresh Chinese sausage is one of the best-known specialties of Long An Province and is often mentioned together with the fresh sausage tradition of the Can Duoc and Can Giuoc area. It is mainly made from pork, pork fat, and seasonings, blended in characteristic proportions to create a recognizable regional flavor. Unlike some dry sausages that are firmer and saltier, Can Duoc sausage is commonly known in its fresh form, with a softer texture, visible meat structure, and a rich aroma when cooked. These qualities make it suitable both as part of everyday family meals and as a regional gift item.

In sensory terms, Can Duoc sausage offers a balanced sweet-savory taste, moderate richness, and the fragrant character of seasoned pork. When pan-fried, grilled, or roasted, the outer casing tightens slightly, becomes glossy, and releases an appetizing aroma, while the filling remains soft, juicy, and naturally sweet. It can be eaten with rice, sticky rice, pickled vegetables, or on its own as a savory dish. Because it is easy to prepare and broadly appealing in flavor, it is more adaptable in daily life than specialties reserved only for special occasions.

Within local culinary culture, Can Duoc sausage reflects Southern Vietnamese traditions of preserving and seasoning meat in ways that serve both household use and commercial production. It shows how a familiar food item can become a regional brand through local technique, ingredient balance, and culinary habit. In a Vietnamese food database, it is a fitting representative of regionally distinctive meat specialties.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'NAM_BO'),
    NULL,
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KINH'),
    N'https://tuyhoafoods.vn/wp-content/uploads/2024/03/image-260.png'
),
(
    'HU_TIEU_MY_THO',
    N'Hủ Tiếu Mỹ Tho',
    N'My Tho Hu Tieu',
    N'Món nước',
    N'Noodle soup',
    N'Đặc sản Tiền Giang nổi tiếng với sợi hủ tiếu dai trong và nước dùng ngọt thanh.',
    N'A Tien Giang specialty known for its springy translucent noodles and clear sweet broth.',
    N'Hủ tiếu Mỹ Tho là một trong những món ăn tiêu biểu nhất của Tiền Giang và cũng là một thương hiệu ẩm thực rất quen thuộc của miền Nam. Món ăn này nổi bật trước hết ở phần sợi hủ tiếu, vốn thường được nhắc đến với đặc điểm dai, trong, ít bở và có độ tơi riêng khi trụng chín. Nhiều mô tả về hủ tiếu Mỹ Tho đều nhấn mạnh mối liên hệ giữa chất lượng sợi và nguồn gạo dùng để làm hủ tiếu, trong đó gạo Gò Cát thường được nhắc như một yếu tố tạo nên danh tiếng cho món ăn. Bên cạnh đó, nước dùng cũng là thành phần quan trọng, thường được nấu để đạt độ ngọt thanh, thơm nhưng không quá nặng. :contentReference[oaicite:0]{index=0}

Một tô hủ tiếu Mỹ Tho thường có sự kết hợp của sợi hủ tiếu, nước dùng và các loại topping như thịt heo, tôm, gan, trứng cút, giá, hẹ hoặc các thành phần quen thuộc khác tùy quán. Món ăn có thể được phục vụ theo kiểu nước hoặc khô, nhưng dù ở hình thức nào, yếu tố cốt lõi vẫn là sự cân bằng giữa sợi, nước dùng và phần ăn kèm. Nước lèo phải đủ trong và ngọt để làm nền, còn sợi hủ tiếu phải giữ được độ dai nhẹ đặc trưng mà không bị nhũn. Nhờ vậy, món ăn vừa mang cảm giác đầy đặn, vừa có sự thanh thoát dễ ăn, phù hợp với nhịp sống hàng ngày của cư dân đồng bằng sông Cửu Long. :contentReference[oaicite:1]{index=1}

Trong cơ sở dữ liệu ẩm thực Việt Nam, hủ tiếu Mỹ Tho là một đại diện rất mạnh cho nhóm món nước miền Nam có tính thương hiệu vùng rõ rệt. Món ăn không chỉ gắn với địa danh Mỹ Tho mà còn phản ánh truyền thống chế biến hủ tiếu và khẩu vị ưa sự cân bằng giữa độ ngọt, độ thơm và sự đa dạng nguyên liệu trong ẩm thực miền Tây. Đây là món phù hợp để xếp vào nhóm đặc sản cấp vùng với mức độ nhận diện cao trên toàn quốc. :contentReference[oaicite:2]{index=2}',
    N'My Tho hu tieu is one of the most representative dishes of Tien Giang Province and one of the most familiar regional noodle brands in Southern Vietnam. Its most notable feature is the noodle itself, which is commonly described as springy, slightly translucent, resilient, and pleasantly separate after blanching. Many descriptions of the dish emphasize the connection between noodle quality and the rice used to make it, with Go Cat rice often mentioned as part of the dish’s reputation. The broth is equally important and is generally prepared to be clear, naturally sweet, and aromatic without becoming too heavy. :contentReference[oaicite:3]{index=3}

A typical bowl of My Tho hu tieu combines noodles with broth and toppings such as pork, shrimp, liver, quail eggs, bean sprouts, garlic chives, or other familiar ingredients depending on the vendor. The dish may be served as a soup or in a dry mixed form, but in either version the essential quality lies in the balance between noodles, broth, and toppings. The broth should be clean and gently sweet, while the noodles must maintain their distinctive light chew without turning soft or mushy. This creates a meal that feels substantial yet still refined and approachable, well suited to the rhythm of daily life in the Mekong Delta. :contentReference[oaicite:4]{index=4}

In a Vietnamese food database, My Tho hu tieu is a particularly strong representative of Southern noodle dishes with clear regional branding. It is tied not only to the place name My Tho but also to local noodle-making traditions and a culinary preference for balancing sweetness, aroma, and varied ingredients. It deserves classification as a high-recognition regional specialty on a national level. :contentReference[oaicite:5]{index=5}',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'NAM_BO'),
    (SELECT TinhThanhID FROM dbo.TinhThanh WHERE MaTinh = 'DONG_THAP'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KINH'),
    N'https://thamvanphapluat.vn/wp-content/uploads/2025/04/z6508413422688_4fdced683ac22b05c781c17abe3b8bea.jpg'
),
(
    'CHUOI_QUET_DUA',
    N'Chuối Quết Dừa',
    N'Mashed Banana with Coconut',
    N'Món ăn dân dã',
    N'Rustic dish',
    N'Món dân dã Tiền Giang với chuối, dừa và vị béo ngọt đặc trưng miền Tây.',
    N'A rustic Tien Giang dish featuring banana and coconut with a sweet, rich Mekong character.',
    N'Chuối quết dừa là một món ăn dân dã gắn với Tiền Giang, thường được nhắc đến như một đặc sản mang đậm chất miền sông nước. Các mô tả phổ biến về món này đều cho thấy nguyên liệu chính là chuối, dừa nạo và thường có thêm đậu phộng, trong đó chuối được chọn kỹ để vừa giữ độ dẻo vừa không bị bở sau chế biến. Quá trình làm món ăn nhìn bề ngoài không quá cầu kỳ nhưng đòi hỏi sự khéo léo để chuối đạt đúng độ mềm, dẻo và quyện với phần dừa mà không bị nhão hoặc quá khô. Một số mô tả còn cho biết món có thể ăn kèm rau sống và nước chấm, tạo nên sự kết hợp vừa lạ vừa rất riêng của ẩm thực miền Tây. :contentReference[oaicite:6]{index=6}

Điểm đặc biệt của chuối quết dừa nằm ở chỗ món ăn được xây dựng từ những nguyên liệu rất gần gũi nhưng lại cho cảm giác hương vị khá đầy đặn. Chuối mang độ dẻo và vị ngọt nền, dừa tạo độ béo và mùi thơm, còn đậu phộng nếu có sẽ bổ sung vị bùi và chiều sâu kết cấu. Khi được làm đúng cách, món ăn cho cảm giác mềm, dẻo, béo nhưng không quá nặng, phù hợp với khẩu vị miền Tây vốn ưa sự hài hòa giữa chất ngọt, chất béo và tính mộc mạc. Đây là kiểu món ăn khiến người thưởng thức dễ liên tưởng đến bếp nhà, đến món quê hơn là một món nhà hàng theo nghĩa thông thường. :contentReference[oaicite:7]{index=7}

Trong cơ sở dữ liệu ẩm thực Việt Nam, chuối quết dừa là đại diện phù hợp cho nhóm món ăn dân dã miền Tây có nguồn gốc từ nguyên liệu vườn nhà và kỹ năng nấu nướng truyền thống. Món ăn phản ánh rõ cách cư dân đồng bằng tận dụng sản vật địa phương để tạo ra hương vị riêng mà không cần dựa vào những nguyên liệu đắt tiền. Đây là món nên được ghi nhận không chỉ vì giá trị ẩm thực mà còn vì tính biểu tượng đối với ký ức và đời sống thường nhật của miền Tây Nam Bộ. :contentReference[oaicite:8]{index=8}',
    N'Mashed banana with coconut is a rustic dish associated with Tien Giang and is often described as a specialty deeply rooted in Mekong Delta food culture. Common descriptions indicate that its main ingredients are banana and grated coconut, often with the addition of peanuts, while the banana must be chosen carefully so it remains pleasantly chewy rather than breaking down during preparation. Although the method may appear simple, making the dish well requires skill so that the banana reaches the right level of softness and elasticity and blends with the coconut without becoming too wet or too dry. Some descriptions also note that it may be eaten with fresh herbs and dipping sauce, giving the dish a combination that is unusual yet very characteristic of Southern Vietnamese cuisine. :contentReference[oaicite:9]{index=9}

What makes the dish distinctive is that it is built from very familiar ingredients yet still delivers a full and memorable flavor. The banana provides a chewy body and natural sweetness, the coconut adds richness and fragrance, and peanuts, when included, contribute nuttiness and extra textural depth. When prepared properly, the dish feels soft, elastic, rich, and comforting without being overly heavy, matching the Mekong Delta preference for a rustic balance of sweetness, richness, and simplicity. It is the kind of food that evokes home kitchens and rural memory more than restaurant-style presentation. :contentReference[oaicite:10]{index=10}

In a Vietnamese food database, mashed banana with coconut is an appropriate representative of rustic Mekong dishes that arise from garden ingredients and traditional kitchen techniques. It clearly reflects the way Delta communities make use of local produce to create distinctive flavor without relying on expensive materials. It deserves recognition not only for culinary value but also for its symbolic connection to the everyday life and food memory of Southern river communities. :contentReference[oaicite:11]{index=11}',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'NAM_BO'),
    (SELECT TinhThanhID FROM dbo.TinhThanh WHERE MaTinh = 'DONG_THAP'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KINH'),
    N'https://mia.vn/media/uploads/blog-du-lich/chuoi-quet-dua-tien-giang-dac-san-doc-nhat-vo-nhi-cua-vung-song-nuoc-1650966813.jpg'
),
(
    'VU_SUA_LO_REN',
    N'Vú Sữa Lò Rèn',
    N'Lo Ren Star Apple',
    N'Trái cây',
    N'Fruit',
    N'Đặc sản trứ danh của vùng Vĩnh Kim với vị ngọt thanh, thơm nhẹ và giá trị thương hiệu cao.',
    N'A renowned Vinh Kim specialty with delicate sweetness, light aroma, and strong regional branding.',
    N'Vú sữa Lò Rèn là một trong những thương phẩm trái cây nổi tiếng nhất gắn với vùng Vĩnh Kim của Tiền Giang trước đây, nay vẫn được nhắc đến như một biểu tượng trái cây đặc sản của khu vực. Nhiều tài liệu du lịch và giới thiệu địa phương đều nhấn mạnh danh tiếng lâu năm của loại quả này, đồng thời gắn nó với vùng Vĩnh Kim và câu chuyện nguồn gốc liên quan đến tên gọi “Lò Rèn”. Các mô tả phổ biến cũng cho thấy đây là loại trái cây có giá trị thương hiệu cao, được xem như một trong những biểu tượng nông sản nổi bật của vùng. :contentReference[oaicite:12]{index=12}

Về đặc điểm cảm quan, vú sữa Lò Rèn thường được biết đến với lớp vỏ mỏng tương đối, phần thịt quả mềm, mọng, vị ngọt thanh và hương thơm nhẹ. Khi ăn đúng độ chín, quả cho cảm giác mát, dịu và ít gắt, phù hợp với vai trò món trái cây tráng miệng hoặc quà biếu đặc sản. So với nhiều loại trái cây phổ thông khác, giá trị của vú sữa Lò Rèn không chỉ nằm ở vị ngon mà còn ở sự gắn bó chặt chẽ với tên đất, tên vùng và truyền thống canh tác đã tạo nên danh tiếng cho sản phẩm trong thời gian dài. :contentReference[oaicite:13]{index=13}

Trong cơ sở dữ liệu ẩm thực và đặc sản Việt Nam, vú sữa Lò Rèn là đại diện rất phù hợp cho nhóm trái cây đặc sản có yếu tố thương hiệu vùng mạnh. Sản phẩm này phản ánh rõ mối liên hệ giữa điều kiện thổ nhưỡng, kinh nghiệm trồng trọt và quá trình xây dựng tên tuổi nông sản địa phương. Đồng thời, nó cũng cho thấy trái cây trong ẩm thực Việt Nam không chỉ mang giá trị ăn tươi mà còn đóng vai trò như một phần của bản sắc kinh tế và văn hóa vùng miền. :contentReference[oaicite:14]{index=14}',
    N'Lo Ren star apple is one of the best-known fruit products associated with the Vinh Kim area of what was historically Tien Giang, and it continues to be recognized as a signature specialty of the region. Travel materials and local descriptions repeatedly emphasize the long-standing reputation of this fruit and connect it closely to Vinh Kim as well as to the origin story behind the name “Lo Ren,” or “blacksmith’s forge.” These descriptions also indicate that it is regarded as a fruit with strong branding value and as one of the most representative agricultural products of the area. :contentReference[oaicite:15]{index=15}

In sensory terms, Lo Ren star apple is commonly known for having a relatively thin skin, soft juicy flesh, delicate sweetness, and a light fragrance. When eaten at proper ripeness, it gives a cooling, gentle impression and works well as a dessert fruit or as a regional gift item. Compared with many ordinary fruits, its value lies not only in taste but also in the strong connection between the fruit and the place-name, local growing tradition, and long-developed reputation that define it. :contentReference[oaicite:16]{index=16}

In a Vietnamese food and specialty database, Lo Ren star apple is a highly suitable representative of fruits with strong regional branding. It clearly reflects the relationship between soil conditions, cultivation experience, and the building of local agricultural identity. At the same time, it shows that fruit in Vietnamese food culture is valued not only for fresh consumption but also as part of the economic and cultural identity of a region. :contentReference[oaicite:17]{index=17}',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'NAM_BO'),
    (SELECT TinhThanhID FROM dbo.TinhThanh WHERE MaTinh = 'DONG_THAP'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KINH'),
    N'https://file.hstatic.net/200000377165/article/phan-biet-cac-loai-vu-sua_2b798baf29d945c99579a0e6e198924a.jpg'
),
(
    'CHUOI_DAP',
    N'Chuối Đập',
    N'Grilled Pressed Banana',
    N'Món ăn vặt',
    N'Snack',
    N'Món ăn dân dã xứ dừa với chuối nướng ép dẹt, ăn cùng nước cốt dừa béo thơm.',
    N'A rustic coconut-land snack made from grilled pressed banana served with rich coconut sauce.',
    N'Chuối đập là một món ăn vặt dân dã rất quen thuộc ở Bến Tre, thường được nhắc đến cùng với hình ảnh xứ dừa và những món ngon làm từ chuối, dừa trong đời sống miền Tây Nam Bộ. Các mô tả phổ biến đều cho thấy món ăn này sử dụng chuối Xiêm vừa chín tới, được nướng sơ trên lửa than, sau đó ép dẹt rồi nướng lại để tạo độ dẻo, thơm và hơi xém mặt ngoài. Chính thao tác “đập” sau lần nướng đầu là chi tiết tạo nên tên gọi và bản sắc riêng của món. Chuối đập thường được dùng kèm nước cốt dừa nấu cùng bột năng, đường và đôi khi có thêm chút muối hoặc mè để tạo vị béo ngọt hài hòa. :contentReference[oaicite:0]{index=0}

Về cảm giác thưởng thức, chuối đập có sự kết hợp rõ rệt giữa độ dẻo của chuối chín, mùi thơm của lớp mặt nướng và vị béo của nước cốt dừa. Khi làm đúng cách, phần chuối không bị nhão mà vẫn giữ được thớ mềm, dẻo và vị ngọt tự nhiên. Nước cốt dừa đóng vai trò hoàn thiện món ăn, giúp tăng độ đậm đà và làm nổi bật chất quê của nguyên liệu. Đây là kiểu món ăn không cầu kỳ về kỹ thuật nhưng rất phụ thuộc vào độ chín của chuối, độ lửa khi nướng và cách nấu nước cốt sao cho sánh vừa phải mà không quá gắt vị ngọt.

Trong cơ sở dữ liệu ẩm thực Việt Nam, chuối đập là đại diện phù hợp cho nhóm món ăn vặt dân dã miền Tây, đặc biệt ở Bến Tre, nơi chuối và dừa là hai nguyên liệu rất phổ biến trong đời sống thường nhật. Món ăn phản ánh rõ tinh thần tận dụng sản vật địa phương để tạo nên những hương vị đơn giản nhưng giàu tính gợi nhớ. Không chỉ là món ăn chơi, chuối đập còn mang giá trị biểu tượng đối với ký ức quê nhà, nhịp sống chợ chiều và văn hóa ẩm thực bình dị của vùng sông nước. :contentReference[oaicite:1]{index=1}',
    N'Grilled pressed banana is a rustic snack closely associated with Ben Tre and often mentioned alongside the coconut-rich food culture of the Mekong Delta. Common descriptions indicate that the dish uses half-ripe Siam bananas, which are first grilled over charcoal, then flattened, and grilled again to create a fragrant, chewy texture with lightly charred surfaces. This pressing step after the first grilling is what gives the dish both its name and its distinctive identity. It is typically served with coconut sauce cooked with starch, sugar, and sometimes a little salt or sesame to create a rich yet balanced flavor. :contentReference[oaicite:2]{index=2}

In terms of eating experience, the dish offers a clear combination of banana chewiness, the aroma of grilled fruit, and the richness of coconut sauce. When prepared properly, the banana remains soft and elastic without turning mushy, while preserving its natural sweetness. The coconut sauce completes the dish by adding fullness and highlighting the rustic quality of the ingredients. Although the preparation is not highly complex, the final result depends greatly on banana ripeness, the grilling heat, and the consistency of the coconut sauce.

In a Vietnamese food database, grilled pressed banana is an appropriate representative of rustic Mekong Delta snack culture, especially in Ben Tre, where both banana and coconut are deeply embedded in daily life. The dish reflects the regional habit of transforming familiar local produce into memorable flavors. More than a simple snack, it also carries symbolic value tied to rural memory, market life, and the everyday culinary identity of Southern river communities. :contentReference[oaicite:3]{index=3}',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'NAM_BO'),
    (SELECT TinhThanhID FROM dbo.TinhThanh WHERE MaTinh = 'VINH_LONG'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KINH'),
    N'https://vcdn1-dulich.vnecdn.net/2020/04/03/hinh-4-2-1585888159-1560-1585889586.jpg?w=1200&h=0&q=100&dpr=1&fit=crop&s=KmE9MqDoT87t602el29_9Q'
),
(
    'KEO_DUA',
    N'Kẹo Dừa',
    N'Coconut Candy',
    N'Món ngọt',
    N'Dessert',
    N'Đặc sản biểu tượng của Bến Tre với vị ngọt béo, thơm mùi dừa và giá trị quà tặng cao.',
    N'An iconic Ben Tre specialty known for its sweet, rich coconut flavor and gift value.',
    N'Kẹo dừa là một trong những đặc sản có tính biểu tượng cao nhất của Bến Tre, gắn liền với hình ảnh “xứ dừa” và nghề chế biến dừa truyền thống của địa phương. Nhiều nguồn mô tả đều nhấn mạnh rằng kẹo dừa không chỉ là món ăn vặt phổ biến mà còn là sản phẩm mang giá trị văn hóa và thương mại rõ rệt của tỉnh. Thành phần cơ bản của kẹo thường gồm nước cốt dừa, mạch nha và đường, được nấu đến độ dẻo đặc rồi cắt thành từng viên nhỏ, bọc giấy hoặc đóng gói để bảo quản và làm quà. Bến Tre cũng được nhắc đến như nơi có nghề làm kẹo dừa phát triển lâu năm, tạo nên danh tiếng cho món này trên phạm vi toàn quốc. :contentReference[oaicite:4]{index=4}

Về hương vị, kẹo dừa nổi bật ở độ ngọt béo và mùi thơm rõ của dừa. Tùy công thức, sản phẩm có thể có thêm đậu phộng, sầu riêng, cacao hoặc lá dứa để tạo biến thể, nhưng phần cốt lõi vẫn là vị dừa đậm đà và độ dẻo đặc trưng. Khi ăn, kẹo cho cảm giác dai nhẹ hoặc mềm tùy loại, tan chậm trong miệng và để lại dư vị béo ngọt kéo dài. Chính tính dễ bảo quản, dễ vận chuyển và hương vị dễ nhận biết khiến kẹo dừa trở thành một trong những đặc sản quà biếu phổ biến nhất khi nhắc đến Bến Tre.

Trong cơ sở dữ liệu ẩm thực Việt Nam, kẹo dừa là đại diện rất tiêu biểu cho nhóm đặc sản chế biến từ dừa và cho thấy cách một sản phẩm địa phương có thể phát triển thành thương hiệu vùng mạnh. Món này không chỉ mang giá trị ẩm thực mà còn phản ánh nghề thủ công, tư duy tận dụng nguyên liệu bản địa và quá trình thương mại hóa đặc sản. Với mức độ phổ biến cao và tính nhận diện rất mạnh, kẹo dừa là một mục dữ liệu gần như không thể thiếu khi xây dựng nhóm đặc sản Bến Tre. :contentReference[oaicite:5]{index=5}',
    N'Coconut candy is one of the most iconic specialties of Ben Tre, closely associated with the image of the “land of coconuts” and with the province’s long-standing coconut-processing tradition. Multiple descriptions emphasize that coconut candy is not only a common sweet snack but also a product with clear cultural and commercial value. Its basic ingredients generally include coconut milk, malt syrup, and sugar, which are cooked down into a thick chewy mass before being cut into small pieces and wrapped for storage and gifting. Ben Tre is widely recognized as the place where coconut candy production developed into a well-known regional craft with national reputation. :contentReference[oaicite:6]{index=6}

In flavor, coconut candy stands out for its sweetness, richness, and unmistakable coconut aroma. Depending on the recipe, variations may include peanuts, durian, cocoa, or pandan, but the essential identity remains the deep coconut taste and the characteristic chewy texture. When eaten, the candy may feel soft or slightly firm depending on the style, dissolving slowly and leaving a lingering sweet-rich finish. Its portability, shelf stability, and easily recognizable flavor are major reasons why it has become one of the most common gift specialties associated with Ben Tre.

In a Vietnamese food database, coconut candy is a highly representative example of processed coconut specialties and shows how a local product can develop into a strong regional brand. It reflects not only culinary taste but also handicraft tradition, the efficient use of local ingredients, and the commercialization of local specialties. Because of its popularity and strong recognition value, coconut candy is an essential entry in any specialty-food dataset for Ben Tre. :contentReference[oaicite:7]{index=7}',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'NAM_BO'),
    (SELECT TinhThanhID FROM dbo.TinhThanh WHERE MaTinh = 'VINH_LONG'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KINH'),
    N'https://media-cdn-v2.laodong.vn/storage/newsportal/2024/9/10/1392248/Keo-Dua-Ben-Tre-O-Ho.jpeg'
),
(
    'CA_LOC_NUONG_TRUI',
    N'Cá Lóc Nướng Trui',
    N'Straight-fire Grilled Snakehead Fish',
    N'Món nướng',
    N'Grilled dish',
    N'Món cá nướng dân dã miền Tây với hương thơm khói rơm, thịt ngọt và cách ăn cuốn đặc trưng.',
    N'A rustic Mekong grilled fish dish with straw-smoked aroma, sweet flesh, and a characteristic wrapping style.',
    N'Cá lóc nướng trui là một trong những món ăn dân dã tiêu biểu nhất của miền Tây Nam Bộ, gắn với hình ảnh đồng ruộng, bờ mương và nhịp sống sông nước. Cách chế biến truyền thống của món này tương đối mộc mạc: cá lóc được làm sạch ở mức vừa đủ hoặc để nguyên theo lối nướng cổ truyền, xiên qua thân rồi nướng trực tiếp trên rơm hoặc than để tạo lớp da cháy xém bên ngoài và giữ độ ngọt tự nhiên của thịt bên trong. Chính kỹ thuật “nướng trui” này tạo nên dấu ấn khác biệt rõ ràng cho món ăn, bởi nó không dựa vào tẩm ướp cầu kỳ mà chủ yếu khai thác hương vị nguyên bản của cá cùng mùi thơm đặc trưng từ lửa rơm.

Khi chín, lớp da ngoài của cá thường khô và cháy sém, trong khi phần thịt bên trong trắng, mềm và vẫn giữ được độ mọng. Cá lóc nướng trui thường được ăn theo kiểu cuốn cùng bánh tráng, bún, rau sống, khế, chuối chát, dưa leo và chấm với nước mắm me hoặc nước chấm pha đậm vị. Chính sự kết hợp giữa thịt cá ngọt, rau tươi, vị chua nhẹ và chút chát của rau trái đi kèm khiến món ăn trở nên rất hài hòa, không hề đơn điệu dù nguyên liệu chính khá giản dị. Đây là kiểu món ăn càng thể hiện rõ khi dùng trong không khí quây quần, nơi việc gỡ cá, cuốn bánh tráng và chấm nước mắm trở thành một phần của trải nghiệm.

Trong bức tranh ẩm thực miền Tây, cá lóc nướng trui là đại diện rất rõ cho kiểu món ăn gắn với điều kiện tự nhiên và lối sống nông nghiệp. Món này không chỉ phản ánh sự phong phú của nguồn cá đồng mà còn cho thấy khả năng tạo nên hương vị đáng nhớ từ những nguyên liệu sẵn có quanh nhà. Với giá trị biểu tượng cao, tính dân dã mạnh và mức độ nhận diện rộng, cá lóc nướng trui là một trong những món nên có mặt khi xây dựng nhóm đặc sản sông nước Nam Bộ.',
    N'Straight-fire grilled snakehead fish is one of the most representative rustic dishes of the Mekong Delta, closely associated with rice fields, canals, and river-based rural life. Its traditional preparation is remarkably simple: the fish is cleaned only as much as needed or sometimes kept closer to its original form, skewered, and grilled directly over straw or charcoal so that the outside becomes charred while the inside retains its natural sweetness. This “nướng trui” technique is what gives the dish its distinctive identity, because it relies less on heavy seasoning and more on the original flavor of the fish together with the smoky aroma created by open fire and straw.

When cooked, the outer skin becomes dry and lightly burnt, while the flesh inside remains white, tender, and juicy. The fish is usually eaten wrapped with rice paper, fresh noodles, herbs, starfruit, green banana, cucumber, and dipped into tamarind fish sauce or another strong local sauce. The combination of sweet fish, fresh herbs, mild acidity, and slight bitterness from accompanying fruits creates a balanced and memorable flavor despite the simplicity of the main ingredient. This is the kind of dish whose appeal grows even stronger in a shared setting, where deboning the fish, wrapping it, and dipping it become part of the communal experience.

Within the broader landscape of Mekong Delta cuisine, straight-fire grilled snakehead fish is a clear representative of food rooted in natural surroundings and agricultural life. It reflects both the abundance of freshwater fish and the ability of local communities to create memorable flavor from readily available ingredients. Because of its symbolic value, rustic character, and broad recognition, it is one of the essential dishes in any collection of Southern river-region specialties.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'NAM_BO'),
    (SELECT TinhThanhID FROM dbo.TinhThanh WHERE MaTinh = 'CAN_THO'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KINH'),
    N'https://cdn.hstatic.net/files/200000700229/article/cach-lam-ca-loc-nuong-1_9b6e2c6db9e245f3b8668646238415de.jpg'
),
(
    'NEM_LAI_VUNG',
    N'Nem Lai Vung',
    N'Lai Vung Fermented Pork Roll',
    N'Món lên men',
    N'Fermented dish',
    N'Đặc sản Đồng Tháp nổi tiếng với vị chua dịu, thơm lá gói và kỹ thuật làm nem truyền thống.',
    N'A famous Dong Thap specialty known for its mild sourness, leaf aroma, and traditional fermentation craft.',
    N'Nem Lai Vung là một trong những đặc sản nổi bật nhất của Đồng Tháp, gắn mạnh với huyện Lai Vung và đã trở thành một thương hiệu ẩm thực được nhiều người nhận biết. Theo nhiều mô tả phổ biến, món nem này có nguồn gốc lâu đời tại địa phương và được biết đến không chỉ như một món ăn ngon mà còn như một nghề truyền thống mang tính nhận diện vùng. Thành phần cơ bản thường gồm thịt heo nạc, bì heo thái sợi, tỏi, ớt và các yếu tố hỗ trợ lên men, sau đó được gói kỹ trong lá để ủ trong thời gian nhất định. Quá trình lên men tạo nên vị chua dịu đặc trưng, mùi thơm riêng và độ kết dính đặc biệt của sản phẩm. :contentReference[oaicite:1]{index=1}

Về cảm quan, nem Lai Vung thường có cấu trúc chắc nhưng không cứng, vị chua nhẹ, xen lẫn độ giòn của bì và mùi thơm của tỏi, ớt, lá gói. So với các loại nem chua khác, món này thường được nhắc tới nhờ sự hài hòa trong hương vị và kiểu gói mang tính thẩm mỹ cao. Khi ăn, nem có thể dùng trực tiếp như món nhắm, món khai vị hoặc món quà biếu. Nhờ đặc tính gọn, dễ bảo quản trong thời gian ngắn và dễ chia phần, nem Lai Vung vừa phù hợp với đời sống thường nhật vừa phù hợp với chức năng đặc sản địa phương có giá trị quà tặng.

Trong hệ thống ẩm thực miền Tây, nem Lai Vung là một ví dụ tiêu biểu cho việc một món ăn truyền thống có thể phát triển thành biểu tượng vùng. Món này không chỉ phản ánh kỹ thuật lên men và bảo quản thực phẩm của cư dân địa phương, mà còn cho thấy cách một sản phẩm gắn với tập quán tiệc cưới, giỗ chạp, gặp gỡ có thể trở thành thương hiệu mạnh. Với tính nhận diện cao, câu chuyện nguồn gốc rõ và bản sắc hương vị riêng, nem Lai Vung là một mục dữ liệu rất phù hợp trong nhóm đặc sản Đồng Tháp.',
    N'Lai Vung fermented pork roll is one of the most prominent specialties of Dong Thap Province, strongly associated with Lai Vung District and widely recognized as a regional food brand. According to common descriptions, this fermented pork has a long-standing local origin and is known not only as a tasty dish but also as a traditional craft with clear place-based identity. Its basic ingredients usually include lean pork, shredded pork skin, garlic, chili, and fermentation-supporting elements, all wrapped carefully in leaves and left to ferment for a certain period. That fermentation process creates the signature mild sourness, the characteristic aroma, and the cohesive texture of the final product. :contentReference[oaicite:2]{index=2}

In sensory terms, Lai Vung fermented pork usually has a compact but not hard structure, a gentle sourness, a slight crunch from the pork skin, and the aroma of garlic, chili, and wrapping leaves. Compared with other Vietnamese fermented pork varieties, it is often noted for its balanced flavor and its neatly wrapped presentation. It can be eaten directly as a snack, appetizer, drinking dish, or gift specialty. Because it is compact, easy to portion, and practical to handle for short-term keeping, it fits both everyday use and the role of a regional gift item.

Within the culinary system of the Mekong Delta, Lai Vung fermented pork is a clear example of how a traditional food can grow into a regional symbol. It reflects local knowledge of fermentation and preservation, while also showing how a dish associated with weddings, gatherings, and household celebrations can develop into a strong specialty brand. With its high recognizability, clear origin story, and distinctive flavor identity, it is a very suitable entry in any specialty-food dataset for Dong Thap.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'NAM_BO'),
    (SELECT TinhThanhID FROM dbo.TinhThanh WHERE MaTinh = 'DONG_THAP'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KINH'),
    N'https://media.thuonghieucongluan.vn/uploads/2025/04/13/sc238a92bd9314eeabcd125defbcc1552j-1-1744524834.jpg'
),
(
    'LAU_CA_LINH_BONG_DIEN_DIEN',
    N'Lẩu Cá Linh Bông Điên Điển',
    N'Hotpot with Young Mudfish and Sesbania Flowers',
    N'Món lẩu',
    N'Hotpot',
    N'Món lẩu mùa nước nổi với vị ngọt thanh của cá linh non và sắc vàng đặc trưng của bông điên điển.',
    N'A flood-season hotpot featuring tender young mudfish and the distinctive yellow sesbania flowers.',
    N'Lẩu cá linh bông điên điển là một món ăn gắn rất mạnh với mùa nước nổi miền Tây Nam Bộ, khi hai nguyên liệu chính là cá linh non và bông điên điển cùng vào thời điểm đẹp nhất. Nhiều mô tả ẩm thực đều xem đây là món ăn tiêu biểu cho tính mùa vụ của miền Tây, bởi cá linh đầu mùa thường nhỏ, thịt mềm, xương chưa cứng, trong khi bông điên điển nở rực và có vị thanh nhẹ rất đặc trưng. Chính sự gặp nhau của hai sản vật này đã tạo nên một món lẩu mang đậm hương đồng nội và cảm giác rất riêng của mùa nước. :contentReference[oaicite:3]{index=3}

Nước lẩu của món này thường được xây dựng theo hướng chua thanh, ngọt nhẹ và không quá nặng, để làm nổi bật độ mềm của cá linh cùng sắc thái tươi non của bông điên điển. Ngoài hai thành phần chính, món ăn còn có thể đi kèm nhiều loại rau dân dã khác của miền Tây, góp phần làm nồi lẩu thêm phong phú mà vẫn giữ được tinh thần đồng quê. Khi ăn, cá linh non cho cảm giác mềm, béo nhẹ, trong khi bông điên điển mang đến độ giòn mềm và vị thanh, giúp món ăn vừa đậm đà vừa nhẹ bụng. Đây là kiểu món lẩu không đặt trọng tâm vào sự nặng vị mà thiên về sự tươi mới và bản sắc mùa vụ.

Xét trong bối cảnh ẩm thực vùng sông nước, lẩu cá linh bông điên điển là món ăn tiêu biểu cho khả năng biến những sản vật theo mùa thành một biểu tượng ẩm thực. Nó không chỉ phản ánh điều kiện tự nhiên của miền Tây mà còn cho thấy cách cư dân địa phương gắn nhịp ăn uống với con nước, với mùa bông, mùa cá. Trong hệ thống món ăn Việt Nam, đây là đại diện giàu giá trị văn hóa cho nhóm món lẩu theo mùa của đồng bằng sông Cửu Long. :contentReference[oaicite:4]{index=4}',
    N'Hotpot with young mudfish and sesbania flowers is a dish strongly associated with the flood season in the Mekong Delta, when its two core ingredients appear at their best. Many culinary descriptions treat it as one of the clearest expressions of the region’s seasonal food culture, because early-season young mudfish are small, tender, and not yet bony, while sesbania flowers bloom brightly and carry a distinctive delicate taste. The meeting of these two seasonal ingredients gives rise to a hotpot that feels deeply tied to the countryside and to the rhythm of rising waters. :contentReference[oaicite:5]{index=5}

The broth is usually built toward a light sourness and gentle sweetness rather than excessive intensity, allowing the softness of the fish and the freshness of the flowers to remain central. Besides the two main ingredients, the hotpot may include other rustic vegetables of the delta, making the pot more varied while preserving its rural spirit. When eaten, the young fish is tender with light richness, while the sesbania flowers add a soft-crisp texture and delicate taste that keep the dish flavorful without heaviness. This is a hotpot that emphasizes freshness and seasonal identity more than sheer boldness.

In the context of river-region cuisine, this dish is a representative example of how seasonal produce can become a culinary symbol. It reflects not only the natural conditions of the Mekong Delta but also the way local communities align their eating habits with water levels, fish runs, and flower seasons. In the broader system of Vietnamese food, it is a culturally rich representative of seasonal hotpot dishes from the delta. :contentReference[oaicite:6]{index=6}',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'NAM_BO'),
    (SELECT TinhThanhID FROM dbo.TinhThanh WHERE MaTinh = 'DONG_THAP'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KINH'),
    N'https://cdn2.fptshop.com.vn/unsafe/lau_ca_linh_bong_dien_dien_3_f95116f6ef.jpg'
),
(
    'CHUOT_DONG_QUAY_LU',
    N'Chuột Đồng Quay Lu',
    N'Clay-jar Roasted Field Rat',
    N'Món quay',
    N'Roasted dish',
    N'Món đặc sản đồng quê với thịt săn chắc, thơm và cách chế biến mang dấu ấn địa phương rõ rệt.',
    N'A rustic specialty with firm, fragrant meat and a strongly regional roasting style.',
    N'Chuột đồng quay lu là một món ăn rất đặc trưng của Đồng Tháp và nhiều mô tả du lịch đều xem đây là nét độc đáo riêng của ẩm thực đồng quê miền Tây. Loại chuột dùng cho món này thường là chuột đồng ăn lúa, vì vậy thịt được mô tả là chắc, thơm và không mang tính “lạ” theo hướng khó ăn như nhiều người hình dung ban đầu. Trước khi quay, chuột được làm sạch, ướp gia vị rồi nướng hoặc quay chín trong lu có than hồng. Cách quay trong lu là yếu tố quan trọng tạo nên tên gọi và bản sắc riêng cho món, đồng thời giúp nhiệt lan đều để da bên ngoài se lại trong khi thịt bên trong vẫn giữ được độ ngọt. :contentReference[oaicite:7]{index=7}

Khi hoàn thành, món ăn thường có mùi thơm rõ, phần da chín vàng và phần thịt săn chắc. Một số mô tả cho biết món này thường được ăn cùng rau răm, dưa leo hoặc các thành phần tươi mát khác để cân bằng vị giác. Nhờ độ chắc thịt và mùi thơm sau khi quay, món tạo ấn tượng khá mạnh với người ăn, nhất là khi được thưởng thức nóng. So với những món quay phổ biến từ gia cầm hay heo, chuột đồng quay lu có tính trải nghiệm cao hơn, nhưng chính điều đó lại làm nên sức hút đặc sản của nó trong du lịch ẩm thực địa phương. :contentReference[oaicite:8]{index=8}

Trong bức tranh ẩm thực Đồng Tháp, chuột đồng quay lu phản ánh rất rõ mối liên hệ giữa đời sống đồng ruộng và cách khai thác nguyên liệu trong sinh hoạt vùng nông nghiệp. Đây là món ăn cho thấy khẩu vị miền Tây không chỉ phong phú mà còn gắn chặt với môi trường sống, mùa màng và kinh nghiệm chế biến của cư dân địa phương. Trong hệ thống món ăn Việt Nam, món này phù hợp được ghi nhận như một đặc sản vùng có tính bản địa mạnh, độc đáo và dễ tạo ấn tượng.',
    N'Clay-jar roasted field rat is a highly distinctive dish of Dong Thap, and many travel descriptions regard it as one of the unique features of rustic Mekong Delta cuisine. The rats used for this dish are typically field rats that feed on rice, which is why their meat is often described as firm, fragrant, and more approachable than many first-time diners might expect. Before roasting, the meat is cleaned thoroughly, seasoned, and then cooked inside a clay jar heated with charcoal. This roasting-in-jar technique is the defining element behind both the name and the dish’s identity, helping heat circulate evenly so that the outer skin tightens while the meat inside stays sweet and moist. :contentReference[oaicite:9]{index=9}

Once finished, the dish is usually aromatic, with browned skin and firm flesh. Some descriptions note that it is often served with Vietnamese coriander, cucumber, or other fresh accompaniments to balance the flavor. Because of its firm texture and strong roasted aroma, it tends to leave a vivid impression, especially when eaten hot. Compared with more common roasted meats such as poultry or pork, clay-jar roasted field rat has a stronger experiential character, and that is precisely part of its attraction as a local specialty. :contentReference[oaicite:10]{index=10}

Within the culinary landscape of Dong Thap, this dish clearly reflects the close relationship between rice-field life and the use of ingredients drawn from an agricultural environment. It shows that Mekong Delta food culture is not only diverse but also deeply connected to landscape, harvest cycles, and local cooking knowledge. In the broader system of Vietnamese cuisine, it deserves recognition as a regionally rooted specialty with strong local character and memorable distinctiveness.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'NAM_BO'),
    (SELECT TinhThanhID FROM dbo.TinhThanh WHERE MaTinh = 'DONG_THAP'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KINH'),
    N'https://vanhoamientay.com/wp-content/uploads/2021/08/30039-chuot-quay-lu-670x446-1.jpg'
),
(
    'CA_TAI_TUONG_CHIEN_XU',
    N'Cá Tai Tượng Chiên Xù',
    N'Crispy Fried Giant Gourami',
    N'Món cá',
    N'Fish dish',
    N'Món cá đồng quê nổi tiếng với lớp da chiên giòn dựng đứng và cách ăn cuốn rất đặc trưng.',
    N'A well-known countryside fish dish with an upright crispy skin and a characteristic wrapping style.',
    N'Cá tai tượng chiên xù là một món ăn rất nổi tiếng ở miền Tây Nam Bộ và thường được nhắc đến như một đặc sản tiêu biểu của Vĩnh Long. Nhiều mô tả du lịch nhấn mạnh rằng món ăn này mang đậm hương vị đồng quê, trong đó hình ảnh con cá được chiên nguyên con, lớp da và vảy dựng giòn lên sau khi chiên là dấu ấn thị giác rất dễ nhận biết. Cá tai tượng sau khi sơ chế được chiên trong dầu ở nhiệt độ phù hợp để lớp ngoài giòn đều, trong khi thịt bên trong vẫn giữ được độ mềm và vị ngọt tự nhiên. Kỹ thuật chiên giữ vai trò rất quan trọng, bởi chỉ cần lửa không chuẩn hoặc thao tác không đều, món ăn dễ bị khô hoặc mất đi hình thức đặc trưng. :contentReference[oaicite:11]{index=11}

Khi thưởng thức, cá tai tượng chiên xù thường không ăn đơn lẻ mà đi kèm bánh tráng, bún, rau sống và nước chấm. Người ăn gỡ thịt cá, cuốn cùng rau rồi chấm, tạo nên tổ hợp rất quen thuộc của ẩm thực miền Tây: một món chính có vị đậm và kết cấu rõ rệt, kết hợp với rau tươi và cách ăn cuốn để tạo sự cân bằng. Nhờ lớp ngoài giòn và phần thịt cá bên trong thơm, món ăn vừa hấp dẫn về hình thức, vừa dễ tạo cảm giác ngon miệng. Đây là kiểu món ăn phù hợp với bữa ăn gia đình, tiệc bạn bè hoặc các dịp tiếp khách bởi vừa có tính trình bày đẹp vừa có tính chia sẻ cao. :contentReference[oaicite:12]{index=12}

Trong hệ thống ẩm thực Nam Bộ, cá tai tượng chiên xù là đại diện rất rõ cho nhóm món cá nước ngọt được nâng lên thành đặc sản vùng. Món ăn phản ánh cả nguồn nguyên liệu sông nước phong phú lẫn kỹ thuật bếp của cư dân địa phương trong việc biến một loại cá quen thuộc thành món có giá trị trình bày và tính thương hiệu. Với mức độ phổ biến cao và dấu ấn rất đặc trưng, đây là món rất phù hợp để ghi nhận trong nhóm đặc sản tiêu biểu của Vĩnh Long. :contentReference[oaicite:13]{index=13}',
    N'Crispy fried giant gourami is a very well-known dish in the Mekong Delta and is often cited as a representative specialty of Vinh Long. Travel descriptions frequently emphasize its strong countryside character, especially the visual image of the whole fish being deep-fried until the skin and scales rise into a crisp golden structure. After cleaning, the fish is fried at the proper temperature so that the exterior becomes evenly crisp while the inside remains tender and naturally sweet. Frying technique is essential, because if the heat is not properly controlled or the handling is uneven, the dish can become dry or lose its signature appearance. :contentReference[oaicite:14]{index=14}

When eaten, crispy giant gourami is usually not served alone. It is commonly accompanied by rice paper, vermicelli, fresh herbs, and dipping sauce. Diners separate the flesh, wrap it with herbs, and dip it, creating a style of eating very typical of Southern cuisine: a main dish with strong flavor and clear texture balanced by fresh vegetables and a wrapping format. Because of its crisp outer layer and fragrant fish meat inside, the dish is attractive both visually and in taste. It works well for family meals, group dining, or entertaining guests because it combines good presentation with shared eating.

Within Southern Vietnamese cuisine, crispy fried giant gourami is a clear representative of freshwater fish transformed into a regional specialty. It reflects both the abundance of river-based ingredients and the culinary skill of local cooks in turning a familiar fish into a dish with strong visual identity and specialty status. Given its popularity and distinctive character, it is very well suited for inclusion among the signature specialties of Vinh Long. :contentReference[oaicite:15]{index=15}',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'NAM_BO'),
    (SELECT TinhThanhID FROM dbo.TinhThanh WHERE MaTinh = 'VINH_LONG'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KINH'),
    N'https://cdn2.fptshop.com.vn/unsafe/1920x0/filters:format(webp):quality(75)/2024_2_23_638442867717478714_cach-lam-ca-tai-tuong-chien-xu.jpg'
),
(
    'KHOAI_LANG_BINH_TAN',
    N'Khoai Lang Bình Tân',
    N'Binh Tan Sweet Potato',
    N'Nông sản',
    N'Agricultural specialty',
    N'Đặc sản Vĩnh Long nổi tiếng với vị ngọt bùi, chất lượng cao và giá trị thương hiệu vùng.',
    N'A well-known Vinh Long specialty prized for its natural sweetness, quality, and regional brand value.',
    N'Khoai lang Bình Tân là một trong những nông sản nổi bật nhất của tỉnh Vĩnh Long, gắn với huyện Bình Tân và được biết đến rộng rãi như một đặc sản tiêu biểu của vùng đồng bằng sông Cửu Long. Nhiều tài liệu giới thiệu du lịch và nông sản địa phương đều nhấn mạnh danh tiếng của loại khoai này, đặc biệt ở khía cạnh chất lượng ổn định, năng suất cao và khả năng trở thành sản phẩm đại diện cho địa phương. Trong số các giống khoai được trồng, khoai lang tím Nhật thường được nhắc đến nhiều nhất khi nói về thương hiệu Bình Tân, tuy nhiên giá trị chung của “khoai lang Bình Tân” còn nằm ở điều kiện canh tác, kinh nghiệm trồng trọt và sự gắn bó lâu dài giữa cây khoai với đời sống kinh tế của người dân địa phương.

Về cảm quan, khoai lang Bình Tân thường được đánh giá cao bởi độ bùi, vị ngọt tự nhiên và kết cấu ruột chắc nhưng không quá khô. Khi luộc, hấp hoặc nướng, khoai có thể cho mùi thơm rõ, màu sắc đẹp và độ dẻo vừa phải, phù hợp với cả nhu cầu ăn tươi lẫn chế biến thành các sản phẩm khác. Khoai lang không chỉ là món ăn dân dã quen thuộc mà còn có thể đi vào nhiều hình thức sử dụng như nguyên liệu cho món ngọt, món ăn nhẹ, bột thực phẩm hoặc sản phẩm sấy. Chính tính linh hoạt này góp phần làm cho khoai lang Bình Tân không chỉ là một nông sản mà còn là một phần của bức tranh ẩm thực và kinh tế địa phương.

Trong hệ thống đặc sản Việt Nam, khoai lang Bình Tân là đại diện rất rõ cho nhóm nông sản mang tính thương hiệu vùng. Giá trị của sản phẩm không chỉ nằm ở hương vị và chất lượng, mà còn ở khả năng phản ánh thổ nhưỡng, điều kiện canh tác và lao động nông nghiệp của cư dân miền Tây. Đây là một mục dữ liệu phù hợp để thể hiện mối liên hệ giữa ẩm thực, nông nghiệp và nhận diện địa phương trong hệ thống đặc sản vùng miền.',
    N'Binh Tan sweet potato is one of the most prominent agricultural products of Vinh Long Province, closely associated with Binh Tan District and widely recognized as a representative specialty of the Mekong Delta. Local tourism and agricultural materials frequently emphasize its reputation, particularly in terms of stable quality, strong productivity, and its role as a signature regional product. Among the varieties grown there, Japanese purple sweet potato is especially well known, but the broader value of “Binh Tan sweet potato” also lies in the local growing conditions, farming experience, and the long-term connection between sweet potato cultivation and the local economy.

In sensory terms, Binh Tan sweet potato is commonly appreciated for its nutty quality, natural sweetness, and flesh that is firm without becoming overly dry. When boiled, steamed, or roasted, it can produce a clear aroma, an attractive color, and a pleasantly soft texture, making it suitable both for direct consumption and for further processing. Sweet potato is not only a familiar rustic food but also an ingredient that can be used in sweets, snacks, flour products, or dried goods. This versatility helps position Binh Tan sweet potato as more than just a crop; it is also part of the local culinary and economic identity.

Within the broader system of Vietnamese specialties, Binh Tan sweet potato is a strong representative of regional agricultural branding. Its value lies not only in flavor and quality, but also in how clearly it reflects soil conditions, cultivation practices, and the agricultural labor of Mekong Delta communities. It is therefore a fitting database entry for showing the relationship between food, farming, and place-based identity in Vietnamese regional specialties.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'NAM_BO'),
    (SELECT TinhThanhID FROM dbo.TinhThanh WHERE MaTinh = 'VINH_LONG'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KINH'),
    N'https://mia.vn/media/uploads/blog-du-lich/khoai-lang-binh-tan-loai-cu-dac-trung-cua-vung-nuoc-noi-03-1662699530.jpeg'
),
(
    'VIT_NAU_CHAO',
    N'Vịt Nấu Chao',
    N'Duck Cooked in Fermented Bean Curd',
    N'Món lẩu',
    N'Hotpot / stew',
    N'Món ăn đặc trưng miền Tây với vị béo, thơm và đậm đà từ chao.',
    N'A Mekong Delta specialty with rich, aromatic flavor from fermented bean curd.',
    N'Vịt nấu chao là một món ăn rất đặc trưng của miền Tây Nam Bộ, đặc biệt phổ biến ở Cần Thơ và nhiều tỉnh lân cận. Món này thường được xem là một trong những đại diện tiêu biểu cho kiểu ăn uống đậm đà, thiên về sự sum họp và chia sẻ của ẩm thực Nam Bộ. Thành phần chính là thịt vịt kết hợp với chao – một loại đậu phụ lên men có mùi thơm và vị béo mặn đặc trưng. Khi nấu, chao không chỉ đóng vai trò gia vị mà còn tạo nên bản sắc rất riêng cho nước dùng, khiến món ăn khác biệt rõ ràng so với các món vịt hầm hoặc vịt nấu thông thường.

Về hương vị, vịt nấu chao thường có nước dùng béo, thơm, đậm và hơi ngậy, nhưng nếu nấu đúng cách vẫn giữ được độ cân bằng nhờ các thành phần đi kèm như khoai môn, rau xanh, bún hoặc mì. Thịt vịt sau khi nấu chín tới phải mềm nhưng không bở, thấm gia vị và không còn mùi nồng. Chao giúp tạo chiều sâu vị giác với sắc thái vừa mặn, vừa béo, vừa thơm rất dễ nhận biết. Đây là món ăn mà người thưởng thức thường nhớ rất lâu chính nhờ mùi vị đặc trưng ấy. Khi ăn nóng trong không khí quây quần, món càng phát huy rõ tính chất “món tụ họp” của ẩm thực miền Tây.

Trong bức tranh ẩm thực Nam Bộ, vịt nấu chao là một món có bản sắc rất mạnh nhờ sự kết hợp giữa nguyên liệu quen thuộc và một gia vị lên men đặc trưng. Món này phản ánh rõ xu hướng ưa vị đậm, thích những món ăn dùng chung và khả năng biến tấu nguyên liệu trong bếp miền Tây. Với giá trị nhận diện cao, hương vị riêng biệt và mức độ phổ biến rộng, vịt nấu chao là món rất phù hợp để ghi nhận trong nhóm đặc sản tiêu biểu của Cần Thơ và miền Tây Nam Bộ.',
    N'Duck cooked in fermented bean curd is a highly characteristic dish of the Mekong Delta, especially common in Can Tho and surrounding provinces. It is often regarded as a representative example of Southern Vietnamese cuisine, where shared meals and full-bodied flavors are especially valued. The main ingredients are duck and fermented bean curd, a preserved tofu product known for its rich aroma and savory depth. In this dish, fermented bean curd is more than just seasoning; it becomes the defining flavor foundation of the broth and gives the dish an identity clearly different from ordinary duck stews or braises.

In terms of flavor, duck cooked in fermented bean curd usually has a broth that is rich, aromatic, and deeply savory, but when properly balanced it remains pleasant rather than overwhelming thanks to accompanying ingredients such as taro, greens, noodles, or vermicelli. The duck meat should be tender without falling apart, well infused with seasoning, and free from any strong odor. The fermented bean curd provides a recognizable combination of saltiness, richness, and fragrance that gives the dish its memorable character. It is the kind of meal that tends to stay in diners’ memory precisely because of this distinctive flavor profile. Served hot in a shared setting, it fully expresses the communal spirit of Mekong Delta cooking.

Within the landscape of Southern Vietnamese cuisine, duck cooked in fermented bean curd stands out for its strong identity, built from familiar ingredients and a highly characteristic fermented seasoning. It reflects the Southern preference for robust flavor, shared dishes, and flexible use of local cooking ingredients. Because of its strong recognizability, distinctive taste, and broad popularity, it is a very suitable entry among the notable specialties of Can Tho and the Mekong Delta.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'NAM_BO'),
    (SELECT TinhThanhID FROM dbo.TinhThanh WHERE MaTinh = 'CAN_THO'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KINH'),
    N'https://i.ytimg.com/vi/_U4q2HshZJo/hq720.jpg?sqp=-oaymwEhCK4FEIIDSFryq4qpAxMIARUAAAAAGAElAADIQj0AgKJD&rs=AOn4CLC02N88lXav9mXfpWVpSUIZImFQZQ'
),
(
    'BANH_CONG',
    N'Bánh Cống',
    N'Banh Cong',
    N'Món bánh',
    N'Fried savory cake',
    N'Món bánh chiên miền Tây với lớp vỏ giòn, nhân đậu và tôm nguyên con đặc trưng.',
    N'A Mekong fried savory cake with a crispy shell, mung bean filling, and whole shrimp topping.',
    N'Bánh cống là một món ăn nổi tiếng của miền Tây Nam Bộ, đặc biệt gắn mạnh với Sóc Trăng nhưng cũng rất quen thuộc trong đời sống ẩm thực Cần Thơ và khu vực lân cận. Tên gọi của món bắt nguồn từ loại khuôn kim loại hình trụ dùng để chiên bánh, từ đó tạo ra hình dáng cao, tròn và khá đặc trưng cho thành phẩm. Món ăn được làm từ bột gạo hoặc hỗn hợp bột, kết hợp với đậu xanh, thịt băm và thường có một con tôm đặt trên mặt trước khi chiên. Chính cách trình bày này khiến bánh cống vừa mang tính dân dã, vừa có hình thức dễ nhận biết trong hệ thống các món bánh chiên Nam Bộ.

Khi chiên đúng kỹ thuật, bánh cống có lớp vỏ ngoài vàng giòn, bên trong vẫn giữ được độ mềm và vị bùi của đậu xanh. Tôm trên mặt bánh thường giữ vai trò như một điểm nhấn thị giác và đồng thời bổ sung vị ngọt hải sản cho món ăn. Bánh thường được ăn kèm rau sống, cải xanh hoặc các loại rau thơm, sau đó chấm nước mắm pha để cân bằng lại độ béo của món chiên. Nhờ cách ăn cuốn hoặc ăn kèm rau, món bánh không bị ngấy mà trở nên hài hòa hơn, đúng với đặc trưng nhiều món ăn miền Tây: giàu hương vị nhưng luôn có yếu tố rau tươi để điều chỉnh cảm giác.

Trong hệ thống món bánh Nam Bộ, bánh cống là một đại diện tiêu biểu cho nhóm món chiên có kết cấu phong phú và giá trị địa phương rõ rệt. Món ăn cho thấy sự khéo léo trong việc kết hợp bột, đậu, thịt và tôm thành một cấu trúc tròn đầy cả về vị lẫn hình thức. Với mức độ phổ biến cao ở miền Tây và dấu ấn mạnh trong văn hóa ẩm thực đường phố cũng như bữa ăn gia đình, bánh cống là món rất đáng được ghi nhận trong nhóm đặc sản vùng sông nước.',
    N'Banh cong is a well-known dish of the Mekong Delta, especially strongly associated with Soc Trang but also very familiar in the food culture of Can Tho and nearby areas. The name comes from the cylindrical metal mold used to fry the cakes, which gives them their distinctive tall, round shape. The cake is made from rice batter or a mixed flour batter, combined with mung bean, minced meat, and usually topped with a whole shrimp before frying. This method of presentation gives banh cong both a rustic identity and a highly recognizable appearance among the fried cakes of Southern Vietnam.

When fried properly, banh cong develops a golden crisp outer layer while the inside remains soft and retains the nutty flavor of mung bean. The shrimp on top acts as both a visual focal point and a source of seafood sweetness. The cakes are usually eaten with fresh greens, mustard leaves, or herbs, then dipped into fish sauce to balance the richness of the fried batter. Because they are often wrapped with vegetables before eating, the dish avoids becoming overly greasy and instead achieves the familiar Southern balance of bold flavor and fresh accompaniment.

Within the category of Southern Vietnamese cakes, banh cong is a representative example of a fried savory cake with strong local identity and layered texture. It demonstrates the skillful combination of batter, bean, meat, and shrimp into a dish that feels complete in both flavor and form. With its popularity across the Mekong Delta and its strong role in both street food culture and family meals, banh cong deserves recognition among the notable specialties of river-region cuisine.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'NAM_BO'),
    (SELECT TinhThanhID FROM dbo.TinhThanh WHERE MaTinh = 'CAN_THO'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KINH'),
    N'https://cdn2.fptshop.com.vn/unsafe/1920x0/filters:format(webp):quality(75)/2023_10_24_638337646202212260_banh-cong-0.jpg'
),
(
    'NEM_NUONG_CAI_RANG',
    N'Nem Nướng Cái Răng',
    N'Cai Rang Grilled Pork',
    N'Món nướng',
    N'Grilled dish',
    N'Đặc sản Cần Thơ với nem nướng thơm, cách ăn cuốn và nước chấm đậm đà.',
    N'A Can Tho specialty featuring fragrant grilled pork, wrapping style, and savory dipping sauce.',
    N'Nem nướng Cái Răng là một món ăn gắn với quận Cái Răng của Cần Thơ, được nhiều người nhắc đến như một biến thể có bản sắc riêng trong nhóm món nem nướng miền Nam. Cũng giống như các món nem nướng khác, thành phần cốt lõi vẫn là thịt heo xay nhuyễn, trộn gia vị và tạo hình trước khi nướng. Tuy nhiên, dấu ấn của nem nướng Cái Răng nằm ở cách phối hợp với rau sống, bánh tráng, bún và nước chấm, tạo nên kiểu ăn cuốn rất đặc trưng và phù hợp với khẩu vị miền Tây: đậm đà nhưng vẫn có độ tươi, béo nhưng không nặng.

Khi nướng, nem phải đạt được lớp ngoài hơi xém, mùi thơm rõ và phần trong vẫn giữ độ mềm, ngọt thịt. Món ăn thường được bày cùng nhiều loại rau tươi và các thành phần ăn kèm để người dùng tự cuốn theo sở thích. Chính yếu tố “tự cuốn” này làm món ăn trở nên linh hoạt, gần gũi và mang tính tương tác cao. Nước chấm, tùy nơi, có thể thiên về độ béo, độ mặn ngọt hoặc sự sánh đậm, đóng vai trò quan trọng trong việc kết nối toàn bộ các thành phần thành một trải nghiệm thống nhất.

Trong bức tranh ẩm thực Cần Thơ, nem nướng Cái Răng là đại diện phù hợp cho kiểu món ăn vừa gắn với đời sống thường nhật vừa có sức hút du lịch. Món ăn cho thấy cách ẩm thực địa phương tiếp nhận một dạng món phổ biến rồi tạo nên sắc thái riêng nhờ phương thức phục vụ, khẩu vị và thói quen ăn cuốn của người miền Tây. Với tính chia sẻ, tính cộng đồng và khả năng tạo trải nghiệm tại bàn, món này rất xứng đáng được ghi nhận như một đặc sản tiêu biểu của Cần Thơ.',
    N'Cai Rang grilled pork is a dish associated with Cai Rang District in Can Tho and is often mentioned as a regional variation within the broader category of Southern Vietnamese grilled pork specialties. Like similar dishes, its core element is seasoned ground pork shaped and grilled. However, what gives the Cai Rang version its local identity is the way it is combined with fresh herbs, rice paper, vermicelli, and dipping sauce, creating a wrapping-style meal that fits Mekong Delta taste very well: bold yet fresh, rich yet not heavy.

When grilled properly, the pork develops a lightly charred surface, a clear smoky aroma, and a soft, naturally sweet interior. It is usually served with an assortment of greens and accompaniments so that diners can assemble wraps according to personal preference. This interactive “wrap-it-yourself” format gives the dish flexibility, familiarity, and a strong communal character. The dipping sauce, depending on the vendor, may emphasize richness, sweet-salty balance, or a thicker texture, and it plays a central role in unifying the whole dish.

Within the culinary landscape of Can Tho, Cai Rang grilled pork is a suitable representative of dishes that are rooted in everyday eating while also carrying tourism appeal. It shows how local cuisine can adapt a familiar dish into a distinct regional expression through serving style, flavor balance, and the wrapping habits characteristic of the Mekong Delta. Because of its shareable nature, social dining format, and memorable table experience, it deserves recognition as a notable specialty of Can Tho.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'NAM_BO'),
    (SELECT TinhThanhID FROM dbo.TinhThanh WHERE MaTinh = 'CAN_THO'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KINH'),
    N'https://mia.vn/media/uploads/blog-du-lich/nem-nuong-cai-rang-huong-vi-dam-da-cua-can-tho-2-1649231593.jpg'
),
(
    'BANH_XEO_MIEN_TAY',
    N'Bánh Xèo Miền Tây',
    N'Mekong Delta Savory Pancake',
    N'Món bánh',
    N'Savory pancake',
    N'Món bánh xèo cỡ lớn, giòn thơm, nhiều rau đồng và đậm chất sông nước miền Tây.',
    N'A large crispy pancake rich in herbs and strongly expressive of Mekong Delta cuisine.',
    N'Bánh xèo miền Tây là một biến thể rất đặc sắc của bánh xèo Việt Nam, nổi bật bởi kích thước thường lớn hơn, lớp vỏ giòn, phần nhân đầy đặn và sự hiện diện phong phú của rau đồng, rau vườn trong cách ăn kèm. So với nhiều phiên bản khác, bánh xèo miền Tây thường gắn chặt với đời sống sông nước, với không gian bếp gia đình hoặc quán vườn, nơi món ăn được đổ nóng tại chỗ và ăn ngay khi còn giòn. Bột bánh thường được pha từ gạo, đôi khi có thêm nghệ để tạo màu vàng, rồi đổ vào chảo nóng với nhân gồm tôm, thịt, giá và các thành phần khác tùy vùng.

Điểm quan trọng làm nên bản sắc của bánh xèo miền Tây không chỉ là chiếc bánh mà còn là hệ rau ăn kèm rất phong phú. Người ăn thường dùng cải xanh, xà lách, rau thơm, lá cách, lá lụa hoặc nhiều loại rau địa phương để cuốn bánh rồi chấm nước mắm pha. Nhờ lượng rau lớn và sự đa dạng của lá cuốn, món ăn vừa mang cảm giác nhiều tầng hương vị vừa giữ được sự cân bằng giữa độ béo của bánh chiên và sự tươi mát của rau. Khi bánh được đổ đúng kỹ thuật, lớp mép giòn rụm, phần giữa vừa chín tới và nhân thơm, tổng thể món ăn tạo ấn tượng rất rõ về sự hào sảng và phong phú của ẩm thực miền Tây.

Trong hệ thống món bánh Việt Nam, bánh xèo miền Tây là đại diện nổi bật cho cách một món ăn quen thuộc có thể phát triển thành một sắc thái vùng miền rất riêng. Món ăn phản ánh điều kiện nguyên liệu phong phú của vùng châu thổ, thói quen ăn rau đa dạng và tinh thần quây quần trong bữa ăn gia đình. Với độ phổ biến cao, giá trị trải nghiệm mạnh và bản sắc vùng rõ rệt, bánh xèo miền Tây là món rất phù hợp để ghi nhận như một đặc sản tiêu biểu của Cần Thơ và toàn vùng đồng bằng sông Cửu Long.',
    N'Mekong Delta savory pancake is a particularly distinctive regional form of Vietnamese banh xeo, recognized for its often larger size, crisp shell, generous filling, and the wide variety of local herbs and leaves served with it. Compared with other versions, the Mekong style is more closely tied to river-region life, to home kitchens, and to garden-style eateries where the pancake is cooked to order and eaten immediately while still crisp. The batter is usually made from rice and sometimes colored with turmeric, then poured into a hot pan with fillings such as shrimp, pork, bean sprouts, and other ingredients depending on locality.

What truly defines this regional version is not only the pancake itself but also the rich assortment of accompanying greens. Diners often use mustard greens, lettuce, herbs, wild leaves, and various local plants to wrap pieces of pancake before dipping them into fish sauce. Because of this abundance and diversity of greens, the dish gains multiple flavor layers while maintaining balance between the richness of fried batter and the freshness of vegetables. When the pancake is cooked properly, the edges become very crisp, the center remains well set, and the filling stays fragrant, creating a clear impression of the generosity and abundance typical of Mekong cuisine.

Within the wider category of Vietnamese pancakes, the Mekong Delta version is a strong example of how a familiar dish can develop a distinctly regional identity. It reflects the abundance of delta ingredients, the habit of eating with many greens, and the social spirit of shared family meals. Because of its popularity, strong experiential value, and clear regional character, it is highly suitable for recognition as a representative specialty of Can Tho and the Mekong Delta as a whole.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'NAM_BO'),
    (SELECT TinhThanhID FROM dbo.TinhThanh WHERE MaTinh = 'CAN_THO'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KINH'),
    N'https://i-giadinh.vnecdn.net/2023/09/19/Buoc-10-Thanh-pham-1-1-5225-1695107554.jpg'
),
(
    'CHAO_LONG_CAI_TAC',
    N'Cháo Lòng Cái Tắc',
    N'Cai Tac Pork Offal Porridge',
    N'Món cháo',
    N'Porridge',
    N'Đặc sản Hậu Giang nổi tiếng với cháo nóng, lòng heo và hương vị dân dã miền Tây.',
    N'A Hau Giang specialty known for hot porridge, pork offal, and rustic Mekong flavor.',
    N'Cháo lòng Cái Tắc là một trong những món ăn được nhắc đến nhiều nhất khi nói về ẩm thực Hậu Giang, đặc biệt gắn với khu vực Cái Tắc như một điểm nhận diện địa phương khá rõ. Nhiều mô tả du lịch xem đây là món dân dã nhưng nổi bật của vùng, phản ánh phong cách ăn uống quen thuộc của miền Tây Nam Bộ: nóng, đậm đà, đủ chất và gần gũi với đời sống thường nhật. Thành phần cốt lõi của món ăn gồm cháo nấu từ gạo, phần lòng heo được làm sạch kỹ và các bộ phận ăn kèm như gan, dồi, tim, phèo hoặc huyết tùy theo cách chuẩn bị của quán. Sự hấp dẫn của món không nằm ở nguyên liệu quý hiếm mà ở cách nấu sao cho cháo vừa sánh, lòng vừa chín tới và toàn bộ tô ăn mang cảm giác tròn vị. :contentReference[oaicite:1]{index=1}

Về cảm giác thưởng thức, cháo lòng Cái Tắc thường cho ấn tượng bởi phần cháo nóng, thơm, có độ sánh vừa phải và vị ngọt nhẹ từ nước ninh. Phần lòng nếu được xử lý tốt sẽ không còn mùi nồng, giữ được độ giòn, mềm hoặc béo tùy từng bộ phận, tạo nên trải nghiệm đa dạng về kết cấu. Món ăn thường đi kèm rau thơm, tiêu, ớt hoặc nước mắm để tăng độ đậm đà theo khẩu vị. Đây là kiểu món ăn rất phù hợp với bữa sáng hoặc những lúc cần một món nóng, dễ no và giàu cảm giác thân thuộc. Chính vì vậy, cháo lòng không chỉ là món ăn mà còn là một phần của nhịp sinh hoạt đời thường tại các đô thị nhỏ và vùng ven của đồng bằng. :contentReference[oaicite:2]{index=2}

Trong bức tranh ẩm thực Hậu Giang, cháo lòng Cái Tắc là đại diện rõ cho nhóm món ăn bình dân có sức sống lâu bền. Nó cho thấy cách những nguyên liệu quen thuộc, nếu được xử lý cẩn thận và nấu nướng đúng kiểu, có thể trở thành món ăn mang tính nhận diện địa phương mạnh. Món này không cầu kỳ về hình thức nhưng giàu giá trị văn hóa đời sống, rất phù hợp để ghi nhận như một đặc sản dân dã của vùng sông nước miền Tây.',
    N'Cai Tac pork offal porridge is one of the dishes most frequently mentioned when discussing the food culture of Hau Giang, especially in connection with Cai Tac as a clearly recognizable local place name. Many travel-oriented descriptions treat it as a rustic yet notable specialty of the province, reflecting a familiar Mekong Delta eating style: hot, savory, filling, and closely tied to everyday life. The core structure of the dish consists of rice porridge, carefully cleaned pork offal, and supporting ingredients such as liver, blood sausage, heart, intestines, or blood cubes depending on the preparation style of the vendor. Its appeal does not come from rare ingredients, but from the skill of cooking the porridge to the right consistency, preparing the offal properly, and making the whole bowl feel balanced and satisfying. :contentReference[oaicite:3]{index=3}

In eating experience, Cai Tac pork offal porridge is often appreciated for its hot, fragrant porridge with moderate thickness and gentle sweetness from the broth. When the offal is handled well, it loses any unpleasant odor while retaining the specific textures of each part, whether crisp, soft, or rich. The dish is commonly served with herbs, pepper, chili, and fish sauce so that diners can adjust intensity to taste. It is especially suitable for breakfast or for moments when a warm, substantial, and comforting meal is desired. For that reason, pork offal porridge is more than just a dish; it is part of the rhythm of everyday life in smaller towns and river-based communities of the Delta. :contentReference[oaicite:4]{index=4}

Within the culinary landscape of Hau Giang, Cai Tac pork offal porridge clearly represents the category of humble dishes with enduring local presence. It shows how familiar ingredients, when carefully cleaned and properly cooked, can become foods with strong place-based identity. Although simple in appearance, it carries substantial value as a food of daily life and deserves recognition as a rustic regional specialty of the Mekong Delta.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'NAM_BO'),
    (SELECT TinhThanhID FROM dbo.TinhThanh WHERE MaTinh = 'CAN_THO'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KINH'),
    N'https://cdn.tcdulichtphcm.vn/upload/2-2021/images/2021-06-26/1624678310-4.jpg'
),
(
    'CHA_CA_THAC_LAC_HAU_GIANG',
    N'Chả Cá Thác Lác Hậu Giang',
    N'Hau Giang Featherback Fish Cake',
    N'Món chả',
    N'Fish cake',
    N'Đặc sản nổi tiếng với chả cá dai, thơm và vị ngọt đặc trưng của cá thác lác.',
    N'A famous specialty known for its chewy fish cake, aroma, and natural sweetness.',
    N'Chả cá thác lác Hậu Giang là một trong những món đặc sản nổi bật của vùng Tây sông Hậu, thường được nhắc đến cùng với cá thác lác cườm – loại cá làm nên danh tiếng của địa phương. Nhiều mô tả ẩm thực cho biết cá thác lác Hậu Giang được đánh giá cao nhờ thịt chắc, trắng, dai và ngọt hơn so với cảm nhận thông thường ở một số nơi khác, từ đó tạo nền tảng rất tốt cho việc làm chả. Cá sau khi nạo lấy thịt sẽ được quết kỹ cùng gia vị, tiêu, hành, thì là hoặc các thành phần tạo mùi quen thuộc, rồi đem chiên, hấp hoặc nấu tùy món. Trong đó, dạng chả chiên là hình thức phổ biến và dễ nhận biết nhất vì làm nổi bật rõ độ dai và độ thơm của nguyên liệu chính. :contentReference[oaicite:5]{index=5}

Về cảm quan, chả cá thác lác Hậu Giang thường có bề mặt vàng đẹp nếu chiên, phần trong dai nhưng không khô, vị ngọt cá rõ và mùi thơm nổi bật từ tiêu, thì là hay hành lá. Điểm quan trọng của món nằm ở thao tác quết hoặc trộn thịt cá sao cho đạt độ kết dính và độ dai vừa phải mà vẫn giữ được cảm giác tự nhiên, không quá bột hay quá nặng gia vị. Khi ăn nóng, chả cá phát huy rõ nhất hương thơm và độ đàn hồi, có thể dùng riêng như món mặn, ăn với cơm, bún hoặc làm thành phần cho các món canh, lẩu và món nhúng. Chính tính linh hoạt này giúp chả cá không chỉ là một món độc lập mà còn là một nguyên liệu giá trị trong bếp miền Tây. :contentReference[oaicite:6]{index=6}

Xét trong bối cảnh ẩm thực Hậu Giang, chả cá thác lác là một đại diện rất tiêu biểu cho cách địa phương xây dựng thương hiệu món ăn từ nguồn thủy sản bản địa. Món ăn phản ánh rõ sự gắn bó giữa môi trường sông nước, kinh nghiệm xử lý cá và khẩu vị ưa sự dai ngọt tự nhiên của người miền Tây. Với giá trị đặc sản, khả năng ứng dụng rộng và mức độ nhận diện cao, chả cá thác lác Hậu Giang là một món rất phù hợp để xếp vào nhóm đặc sản tiêu biểu của vùng.',
    N'Hau Giang featherback fish cake is one of the standout specialties of the western Hau River region and is closely associated with the featherback fish for which the province is well known. Many food descriptions note that Hau Giang featherback is especially valued for flesh that is firm, white, springy, and naturally sweet, giving it excellent qualities for fish cake preparation. After the fish meat is carefully scraped out, it is pounded or mixed thoroughly with seasonings, pepper, scallions, dill, or other familiar aromatics, then cooked by frying, steaming, or inclusion in other dishes. Among these forms, fried fish cake is the most widely recognized because it best highlights the chewy texture and fragrance of the fish itself. :contentReference[oaicite:7]{index=7}

In sensory terms, Hau Giang featherback fish cake usually has a golden surface when fried, with an interior that is springy without being dry, distinctly sweet from the fish, and aromatic from herbs and spices. A key part of its quality lies in how the fish meat is worked so that it develops the right elasticity while still preserving a natural feel, without becoming too floury or overly seasoned. When eaten hot, the fish cake shows its fragrance and bounce most clearly. It may be served on its own as a savory dish, eaten with rice or noodles, or used in soups and hotpots. This versatility makes it not only a finished dish but also an important ingredient in Mekong Delta cooking. :contentReference[oaicite:8]{index=8}

Within the culinary setting of Hau Giang, featherback fish cake is a particularly strong example of how a locality can build a food identity around native aquatic resources. It reflects the close connection between river ecology, fish-handling technique, and Southern preferences for natural sweetness and elastic texture. Because of its specialty value, broad usefulness, and strong recognizability, Hau Giang featherback fish cake is a highly suitable entry among the province’s representative specialties.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'NAM_BO'),
    (SELECT TinhThanhID FROM dbo.TinhThanh WHERE MaTinh = 'CAN_THO'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KINH'),
    N'https://image.vietnamnews.vn/uploadvnnews/Article/2018/1/5/chacathaclachaugiang65431351PM.jpg'
),
(
    'BANH_PIA',
    N'Bánh Pía',
    N'Pia Cake',
    N'Món bánh',
    N'Pastry',
    N'Đặc sản Sóc Trăng nổi tiếng với lớp vỏ nhiều tầng, nhân ngọt béo và hương sầu riêng đặc trưng.',
    N'A famous Soc Trang pastry with layered crust, rich sweet filling, and distinctive durian aroma.',
    N'Bánh pía là một trong những đặc sản nổi tiếng nhất của Sóc Trăng và có thể xem là món bánh ngọt mang tính biểu tượng của địa phương này. Trên thực tế, khi nhắc tới Sóc Trăng, nhiều người thường nhớ ngay đến bánh pía cùng với lạp xưởng như hai dòng đặc sản có độ nhận diện rất cao. Các mô tả phổ biến đều cho thấy bánh pía có cấu trúc lớp vỏ mỏng nhiều tầng, phần nhân ngọt béo và mùi thơm đặc trưng, đặc biệt ở những phiên bản có sầu riêng. Theo thời gian, bánh pía đã phát triển thành nhiều biến thể về nhân như đậu xanh, khoai môn, sầu riêng và trứng muối, nhưng bản sắc chung vẫn là sự kết hợp giữa vỏ bánh nhiều lớp và nhân mềm đậm vị. :contentReference[oaicite:9]{index=9}

Về cảm giác thưởng thức, bánh pía thường có lớp vỏ mỏng, hơi vụn, mềm và tách lớp, trong khi phần nhân bên trong mịn, ngọt béo và khá đặc. Nếu dùng loại có sầu riêng, mùi hương của quả sẽ nổi bật rõ, tạo nên dấu ấn rất mạnh và cũng là lý do khiến bánh trở nên dễ nhận biết. Trứng muối, khi có mặt trong nhân, giúp cân bằng vị ngọt và tăng chiều sâu cho tổng thể. Bánh pía thường được dùng với trà nóng, vì vị chát nhẹ của trà giúp làm dịu cảm giác béo và làm rõ hơn hương thơm của bánh. Đây là kiểu món ngọt vừa phù hợp để ăn chơi, vừa rất phổ biến trong vai trò quà biếu và đặc sản mang về. :contentReference[oaicite:10]{index=10}

Trong hệ thống đặc sản miền Tây, bánh pía là đại diện rất rõ cho nhóm bánh ngọt địa phương đã phát triển thành thương hiệu vùng mạnh. Nó phản ánh sự giao thoa văn hóa ẩm thực, tay nghề làm bánh thủ công và khả năng thương mại hóa thành công của một sản phẩm truyền thống. Với mức độ phổ biến cao, hình thức dễ nhận biết và giá trị quà tặng mạnh, bánh pía là một món không thể thiếu khi xây dựng nhóm đặc sản tiêu biểu của Sóc Trăng.',
    N'Pia cake is one of the most famous specialties of Soc Trang and can be regarded as the province’s most iconic sweet pastry. In fact, when people mention Soc Trang, pia cake and sausage are often the first two specialties that come to mind because of their very strong recognition value. Common descriptions emphasize its thin multilayered crust, rich sweet filling, and distinctive aroma, especially in versions containing durian. Over time, pia cake has developed into many filling variations, including mung bean, taro, durian, and salted egg, yet its core identity remains the contrast between a flaky layered crust and a dense, flavorful filling. :contentReference[oaicite:11]{index=11}

In eating experience, pia cake usually has a thin, soft, flaky crust that separates into layers, while the filling inside is smooth, rich, and fairly dense. In durian versions, the fruit aroma is especially prominent and is one of the main reasons the pastry is so recognizable. Salted egg yolk, when included, helps balance sweetness and adds depth to the overall flavor. Pia cake is often enjoyed with hot tea, whose slight bitterness softens the richness and highlights the pastry’s fragrance more clearly. It functions both as a casual sweet and as one of the most common gift specialties associated with the province. :contentReference[oaicite:12]{index=12}

Within the system of Mekong Delta specialties, pia cake is a strong representative of regional pastries that have grown into powerful local brands. It reflects culinary exchange, artisanal pastry-making skill, and the successful commercialization of a traditional food product. Because of its popularity, recognizability, and gift value, pia cake is an essential item in any curated set of Soc Trang specialties.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'NAM_BO'),
    (SELECT TinhThanhID FROM dbo.TinhThanh WHERE MaTinh = 'SOC_TRANG'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KINH'),
    N'https://cdn2.fptshop.com.vn/unsafe/1920x0/filters:format(webp):quality(75)/2024_6_6_638532648263862187_banh-pia.jpeg'
),
(
    'BANH_ONG',
    N'Bánh Ống',
    N'Banh Ong',
    N'Món bánh',
    N'Steamed cake',
    N'Món bánh dân gian của người Khmer với hình ống đặc trưng, hương thơm lá dứa và dừa nạo.',
    N'A traditional Khmer tube-shaped cake with pandan aroma and grated coconut.',
    N'Bánh ống là một món bánh dân gian gắn với cộng đồng Khmer Nam Bộ và thường được xem là một nét đặc trưng trong văn hóa ẩm thực Sóc Trăng. Món ăn này gây ấn tượng trước hết ở hình dáng: bánh được làm thành dạng ống dài, thường nhờ khuôn hoặc ống hấp chuyên dụng, từ đó tạo nên tên gọi rất trực quan và dễ nhớ. Theo các mô tả phổ biến, nguyên liệu làm bánh thường gồm bột gạo hoặc bột nếp pha với đường, lá dứa để tạo màu và hương thơm, sau đó hấp chín rồi ăn kèm dừa nạo. Chính sự kết hợp giữa hình thức lạ mắt và hương vị mộc mạc đã giúp bánh ống trở thành một món ăn có bản sắc rõ, dù không phải là món quá cầu kỳ. :contentReference[oaicite:13]{index=13}

Về hương vị, bánh ống thiên về sự nhẹ nhàng, thơm dịu và mềm dẻo. Lá dứa thường tạo màu xanh và mùi thơm nền, trong khi dừa nạo giúp món ăn có thêm độ béo và cảm giác bùi nhẹ khi thưởng thức. Bánh không quá ngọt theo kiểu bánh kẹo hiện đại mà thiên về vị thanh, phù hợp với vai trò món quà vặt hoặc món bánh dân gian trong chợ, hội hoặc sinh hoạt đời thường. Nhờ kết cấu mềm, kích thước vừa tay và cách ăn đơn giản, bánh ống dễ tạo cảm giác gần gũi, đặc biệt với những ai yêu thích các món truyền thống mang màu sắc cộng đồng.

Trong bức tranh ẩm thực Sóc Trăng, bánh ống là đại diện phù hợp cho nhóm món bánh gắn với văn hóa Khmer và đời sống chợ quê miền Tây. Món ăn không chỉ có giá trị ẩm thực mà còn thể hiện rõ dấu ấn của cộng đồng cư dân trong việc lưu giữ kỹ thuật hấp bánh, sử dụng lá dứa, dừa và cách tạo hình riêng. Với tính biểu trưng cao về văn hóa hơn là sự cầu kỳ về nguyên liệu, bánh ống là một mục dữ liệu rất đáng có khi xây dựng nhóm món ăn dân gian đặc trưng của Sóc Trăng.',
    N'Banh ong is a traditional cake associated with the Khmer communities of Southern Vietnam and is often regarded as a characteristic element of Soc Trang’s food culture. The first thing that makes it memorable is its form: the cake is made into a long tube shape using a specialized steaming mold or tube, which is exactly what gives the dish its direct and memorable name. Common descriptions indicate that its ingredients usually include rice flour or glutinous flour mixed with sugar, pandan for color and aroma, then steamed and served with grated coconut. The combination of its unusual shape and its rustic flavor gives the cake a clear identity even though it is not an elaborate pastry. :contentReference[oaicite:14]{index=14}

In flavor, banh ong is gentle, fragrant, and softly chewy. Pandan contributes both its green color and its light aromatic base, while grated coconut adds richness and a mild nutty feel. The cake is not intensely sweet like modern confectionery; instead, it leans toward a lighter sweetness that suits its role as a snack or traditional market cake. Because of its soft texture, hand-sized form, and simple way of eating, it creates a strong sense of familiarity, especially for people who appreciate traditional community-based foods.

Within the culinary picture of Soc Trang, banh ong is a fitting representative of cakes associated with Khmer cultural identity and everyday market life in the Mekong Delta. It carries not only food value but also a strong imprint of community tradition through steaming technique, the use of pandan and coconut, and its distinctive molded shape. More significant for its cultural symbolism than for luxurious ingredients, banh ong is a highly worthwhile entry in a dataset of traditional folk foods from Soc Trang.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'NAM_BO'),
    (SELECT TinhThanhID FROM dbo.TinhThanh WHERE MaTinh = 'SOC_TRANG'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KHMER'),
    N'https://daylambanh.edu.vn/wp-content/uploads/2019/09/banh-ong-la-dua-600x400.jpg'
),
(
    'LAP_XUONG_VUNG_THOM',
    N'Lạp Xưởng Vũng Thơm',
    N'Vung Thom Sausage',
    N'Món đặc sản',
    N'Specialty sausage',
    N'Đặc sản Sóc Trăng nổi tiếng với nhiều biến thể và nghề làm lạp xưởng gia truyền.',
    N'A famous Soc Trang specialty with many variations and a long-standing family sausage craft.',
    N'Lạp xưởng Vũng Thơm là một đặc sản nổi bật của Sóc Trăng, gắn với vùng Vũng Thơm – nơi được nhắc đến như một cái nôi của nhiều nghề làm đặc sản, trong đó có cả bánh pía và lạp xưởng. Theo các mô tả về địa phương, nghề làm lạp xưởng ở đây mang tính gia truyền và phát triển thành nhiều dòng sản phẩm khác nhau để phù hợp với thị hiếu người dùng, như lạp xưởng thịt, lạp xưởng tôm hay các biến thể khác. Điều này cho thấy lạp xưởng Vũng Thơm không chỉ là một món ăn đơn lẻ, mà còn là cả một nhóm sản phẩm đặc sản gắn với kỹ thuật chế biến, kinh nghiệm gia đình và thương hiệu vùng. :contentReference[oaicite:15]{index=15}

Về đặc điểm cảm quan, lạp xưởng Vũng Thơm thường được hiểu là loại lạp xưởng có vị đậm đà, cân bằng giữa mặn, ngọt và độ béo, đồng thời có mùi thơm đặc trưng khi chiên hoặc nướng. Ở các biến thể có tôm, phần nhân có thêm sắc thái ngọt và mùi vị riêng của nguyên liệu biển, tạo ra một hướng phát triển khá khác biệt so với lạp xưởng thuần thịt. Dù ở loại nào, sản phẩm vẫn cần đạt độ khô hoặc độ săn vừa phải để khi chế biến không bị bở, đồng thời giữ được kết cấu hấp dẫn và độ đậm vị. Đây là kiểu đặc sản vừa có thể dùng trong bữa ăn hàng ngày, vừa rất phù hợp làm quà biếu nhờ khả năng bảo quản và tính nhận diện cao.

Trong hệ thống đặc sản Sóc Trăng, lạp xưởng Vũng Thơm là một mục rất quan trọng vì nó phản ánh rõ sự kết hợp giữa nghề thủ công thực phẩm, khẩu vị Nam Bộ và quá trình xây dựng thương hiệu địa phương. Món này không chỉ mang giá trị ẩm thực mà còn cho thấy cách một nghề gia truyền có thể phát triển thành sản phẩm nổi tiếng ngoài phạm vi địa phương. Với mức độ phổ biến, sự đa dạng biến thể và mối liên hệ rõ ràng với tên đất, lạp xưởng Vũng Thơm là đại diện rất phù hợp cho nhóm đặc sản chế biến từ thịt của miền Tây Nam Bộ.',
    N'Vung Thom sausage is a notable specialty of Soc Trang, closely associated with the Vung Thom area, which is described as a cradle of several local food crafts, including both pia cake and sausage making. Local descriptions indicate that sausage production there is based on family tradition and has developed into many product types to suit different tastes, including pork sausage, shrimp sausage, and other variations. This means that Vung Thom sausage is not merely a single dish, but rather a specialty category rooted in processing technique, inherited household knowledge, and place-based branding. :contentReference[oaicite:16]{index=16}

In sensory terms, Vung Thom sausage is generally understood as a richly flavored sausage with a balance of sweetness, saltiness, and moderate richness, together with a distinctive aroma when pan-fried or grilled. In versions containing shrimp, the filling gains an additional sweet marine note that sets it apart from ordinary pork sausage. Regardless of variation, the product is expected to reach a proper level of firmness or drying so that it keeps an appealing texture when cooked and remains strongly flavored without becoming crumbly. This makes it suitable both for everyday meals and for gift use, thanks to its portability and recognizability.

Within the specialty system of Soc Trang, Vung Thom sausage is an important entry because it clearly reflects the combination of food craft, Southern taste preference, and the development of regional branding. It shows how a family-based processing tradition can expand beyond its place of origin and become widely recognized. Because of its popularity, varied forms, and strong connection to a named locality, Vung Thom sausage is a highly suitable representative of Mekong Delta meat specialties.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'NAM_BO'),
    (SELECT TinhThanhID FROM dbo.TinhThanh WHERE MaTinh = 'SOC_TRANG'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KINH'),
    N'https://biolomix.vn/wp-content/uploads/2025/04/190409.jpg'
),
(
    'LAU_BON_BON',
    N'Lẩu Bồn Bồn',
    N'Water Lily Hotpot',
    N'Món lẩu',
    N'Hotpot',
    N'Món lẩu miền Tây với bồn bồn giòn, vị chua nhẹ và hương vị thanh mát.',
    N'A Mekong hotpot featuring crunchy water lily stems with a light sour and refreshing taste.',
    N'Lẩu bồn bồn là một món ăn đặc trưng của vùng Bạc Liêu và một số khu vực miền Tây Nam Bộ, nổi bật với nguyên liệu chính là bồn bồn – phần thân non của một loại cây thủy sinh thường xuất hiện ở vùng đất ngập nước. Bồn bồn có đặc điểm giòn, trắng, vị thanh và thường được sử dụng trong nhiều món ăn dân dã như dưa bồn bồn hoặc xào. Khi đưa vào món lẩu, nguyên liệu này trở thành yếu tố tạo nên sự khác biệt rõ rệt so với các loại lẩu khác.

Nước lẩu thường được nấu theo hướng chua nhẹ, ngọt thanh, kết hợp với cá, tôm hoặc thịt tùy cách chế biến. Bồn bồn khi nhúng vào nước lẩu sẽ giữ được độ giòn tự nhiên, đồng thời thấm nhẹ vị nước dùng, tạo cảm giác rất dễ ăn và không bị ngấy. Món ăn thường đi kèm rau sống, bún và nước chấm, tạo nên trải nghiệm cân bằng giữa vị chua, ngọt và tươi mát.

Trong hệ thống ẩm thực miền Tây, lẩu bồn bồn là đại diện tiêu biểu cho kiểu món ăn tận dụng nguyên liệu tự nhiên của vùng đất ngập nước. Món ăn phản ánh rõ mối liên hệ giữa môi trường sinh thái và thói quen ẩm thực địa phương, đồng thời cho thấy sự sáng tạo trong việc biến nguyên liệu dân dã thành một món ăn mang tính đặc sản.',
    N'Water lily hotpot is a regional specialty of Bac Lieu and other Mekong Delta areas, distinguished by its main ingredient—young stems of a wetland plant commonly found in flooded fields. These stems are crisp, pale, and mildly flavored, and are widely used in rustic dishes such as pickles or stir-fries. When incorporated into a hotpot, they create a distinct identity that sets the dish apart from more common styles.

The broth is typically light, slightly sour, and naturally sweet, often combined with fish, shrimp, or meat depending on the preparation. The water lily stems remain crisp when briefly cooked, absorbing just enough broth to enhance their flavor without losing their texture. The dish is usually served with fresh herbs, noodles, and dipping sauces, resulting in a balanced and refreshing dining experience.

Within Mekong Delta cuisine, water lily hotpot represents a class of dishes that make use of natural wetland ingredients. It reflects the strong relationship between ecological conditions and local food habits, as well as the creativity of transforming simple ingredients into regional specialties.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'NAM_BO'),
    (SELECT TinhThanhID FROM dbo.TinhThanh WHERE MaTinh = 'CA_MAU'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KINH'),
    N'https://i.ytimg.com/vi/XoHKSh-aInM/hq720.jpg?sqp=-oaymwEhCK4FEIIDSFryq4qpAxMIARUAAAAAGAElAADIQj0AgKJD&rs=AOn4CLDH3YFGjrHUiTtfZpDdiiRWspuBDg'
),
(
    'BANH_TAM_BI',
    N'Bánh Tằm Bì',
    N'Banh Tam Bi',
    N'Món bún',
    N'Noodle dish',
    N'Món ăn miền Tây với sợi bánh tằm, bì heo và nước cốt dừa béo thơm.',
    N'A Mekong noodle dish with thick rice noodles, pork skin, and rich coconut sauce.',
    N'Bánh tằm bì là một món ăn đặc trưng của Bạc Liêu và nhiều tỉnh miền Tây Nam Bộ, nổi bật với sự kết hợp giữa sợi bánh tằm, bì heo và nước cốt dừa. Sợi bánh tằm thường to, mềm và có độ dai nhẹ, khác biệt so với bún hay hủ tiếu. Thành phần “bì” là bì heo thái sợi trộn thính, tạo nên vị bùi và mùi thơm đặc trưng.

Món ăn thường được chan nước cốt dừa béo nhẹ, kết hợp với rau sống, dưa leo và nước mắm pha để cân bằng hương vị. Khi ăn, người thưởng thức cảm nhận rõ sự hòa quyện giữa vị béo, mặn, ngọt và độ mềm của sợi bánh. Đây là món ăn thể hiện rõ đặc trưng ẩm thực miền Tây: sử dụng nước cốt dừa và tạo sự cân bằng bằng rau tươi.

Trong bức tranh ẩm thực Nam Bộ, bánh tằm bì là đại diện tiêu biểu cho nhóm món ăn vừa dân dã vừa mang tính đặc sản. Món ăn phản ánh sự phong phú trong cách sử dụng gạo và dừa, hai nguyên liệu quen thuộc của vùng.',
    N'Banh tam bi is a traditional dish from Bac Lieu and other Mekong Delta provinces, characterized by its combination of thick rice noodles, shredded pork skin, and coconut milk. The noodles are larger and softer than vermicelli, offering a slightly chewy texture. The pork skin component is mixed with roasted rice powder, giving it a nutty aroma and distinctive taste.

The dish is usually topped with light coconut milk and served with fresh herbs, cucumber, and dipping fish sauce to balance the flavors. Diners experience a blend of richness, saltiness, sweetness, and soft texture in each bite. This reflects the Southern culinary style of using coconut milk and fresh vegetables to create balance.

In Southern Vietnamese cuisine, banh tam bi is a representative dish that combines rustic ingredients with regional identity. It highlights the use of rice and coconut, two key elements of Mekong Delta food culture.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'NAM_BO'),
    (SELECT TinhThanhID FROM dbo.TinhThanh WHERE MaTinh = 'CA_MAU'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KINH'),
    N'https://daylambanh.edu.vn/wp-content/uploads/2019/09/banh-tam-bi-mien-tay-600x400.jpg'
),
(
    'BA_KHIA_MUOI',
    N'Ba Khía Muối',
    N'Salted Three-striped Crab',
    N'Món mắm',
    N'Fermented seafood',
    N'Đặc sản miền Tây với vị mặn đậm, thường dùng làm món ăn kèm hoặc trộn gỏi.',
    N'A Mekong specialty with strong salty flavor, often used in salads or side dishes.',
    N'Ba khía muối là một món đặc sản nổi tiếng của vùng Cà Mau và Bạc Liêu, gắn liền với mùa ba khía và đời sống vùng rừng ngập mặn. Ba khía là một loại cua nhỏ sống trong rừng đước, được thu hoạch theo mùa và chế biến bằng cách muối để bảo quản và tạo hương vị đặc trưng.

Sau khi muối, ba khía có vị mặn đậm, thịt chắc và mùi đặc trưng của hải sản lên men. Món này thường được dùng trực tiếp với cơm hoặc chế biến thành gỏi, trộn với tỏi, ớt, chanh để tăng hương vị. Khi ăn, người ta cảm nhận rõ vị mặn, cay, chua và độ đậm đà đặc trưng.

Trong hệ thống ẩm thực miền Tây, ba khía muối là đại diện cho nhóm món mắm và thực phẩm lên men, phản ánh rõ cách cư dân vùng ven biển bảo quản và chế biến hải sản.',
    N'Salted three-striped crab is a well-known specialty from Ca Mau and Bac Lieu, closely linked to mangrove ecosystems and seasonal harvesting. The crabs are small and live in coastal forests, and are preserved through salting to develop their distinctive flavor.

Once fermented, the crabs have a strong salty taste, firm texture, and characteristic seafood aroma. They are often eaten with rice or used in salads mixed with garlic, chili, and lime. The flavor profile includes salty, spicy, sour, and rich elements.

Within Mekong Delta cuisine, salted three-striped crab represents fermented seafood traditions and reflects local methods of preserving coastal resources.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'NAM_BO'),
    (SELECT TinhThanhID FROM dbo.TinhThanh WHERE MaTinh = 'CA_MAU'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KINH'),
    N'https://cdnv2.tgdd.vn/bhx-static/bhx/News/Images/2019/07/19/1180464/4_202411051552556025.jpg'
),
(
    'CUA_CA_MAU',
    N'Cua Cà Mau',
    N'Ca Mau Crab',
    N'Hải sản',
    N'Seafood',
    N'Đặc sản nổi tiếng với thịt chắc, ngọt và chất lượng cao.',
    N'A famous seafood known for its firm, sweet, high-quality meat.',
    N'Cua Cà Mau là một trong những đặc sản hải sản nổi tiếng nhất của Việt Nam, gắn liền với hệ sinh thái rừng ngập mặn rộng lớn của tỉnh Cà Mau. Nhờ môi trường tự nhiên giàu dinh dưỡng, cua tại đây thường có kích thước lớn, thịt chắc, nhiều gạch và vị ngọt đậm đặc trưng.

Cua có thể được chế biến theo nhiều cách như hấp, rang muối, nấu lẩu hoặc làm gỏi. Dù chế biến theo cách nào, điểm nổi bật vẫn là độ tươi và chất lượng thịt. Đây là loại hải sản có giá trị cao, thường được dùng trong các bữa ăn quan trọng hoặc làm quà biếu.

Trong hệ thống ẩm thực Việt Nam, cua Cà Mau là đại diện tiêu biểu cho nhóm hải sản cao cấp của vùng biển Nam Bộ, thể hiện rõ giá trị tự nhiên và kinh tế của địa phương.',
    N'Ca Mau crab is one of Vietnam’s most famous seafood specialties, closely associated with the province’s vast mangrove ecosystem. Thanks to the nutrient-rich environment, these crabs are typically large, firm, and full of roe, with a naturally sweet taste.

They can be prepared in various ways such as steaming, salt roasting, hotpot, or salads. Regardless of the method, freshness and meat quality remain the key highlights. This seafood is considered premium and is often used for special occasions or as a valuable gift.

Within Vietnamese cuisine, Ca Mau crab represents high-quality coastal seafood and reflects the natural and economic value of the southern coastal region.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'NAM_BO'),
    (SELECT TinhThanhID FROM dbo.TinhThanh WHERE MaTinh = 'CA_MAU'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KINH'),
    N'https://cdn.zsoft.solutions/poseidon-web/app/media/Kham-pha-am-thuc/10.2022/251022-cua-ca-mau-buffet-poseidon-5.jpg'
),
(
    'VOP_NUONG_MO_HANH',
    N'Vọp Nướng Mỡ Hành',
    N'Grilled Clams with Scallion Oil',
    N'Hải sản',
    N'Seafood',
    N'Món hải sản nướng đơn giản nhưng đậm vị với mỡ hành và đậu phộng.',
    N'A simple grilled seafood dish enhanced by scallion oil and peanuts.',
    N'Vọp nướng mỡ hành là một món ăn hải sản dân dã phổ biến ở vùng ven biển miền Tây, đặc biệt tại Cà Mau. Vọp là một loại nhuyễn thể sống ở vùng nước lợ, có thịt dai và vị ngọt tự nhiên. Khi nướng, vọp được mở miệng, rưới mỡ hành lên trên để tạo hương thơm và độ béo đặc trưng.

Món ăn thường được rắc thêm đậu phộng rang và dùng nóng để giữ trọn hương vị. Sự kết hợp giữa vị ngọt của vọp, mùi thơm của hành và độ béo của dầu tạo nên một món ăn đơn giản nhưng rất hấp dẫn.

Trong ẩm thực miền biển Nam Bộ, vọp nướng mỡ hành là đại diện cho nhóm món nướng hải sản dân dã, thể hiện rõ phong cách chế biến nhanh, ít gia vị nhưng vẫn giữ được hương vị tự nhiên của nguyên liệu.',
    N'Grilled clams with scallion oil is a common rustic seafood dish in coastal Mekong areas, especially Ca Mau. Clams from brackish water have firm texture and natural sweetness. When grilled, they open slightly and are topped with scallion oil, adding aroma and richness.

The dish is often sprinkled with roasted peanuts and served hot to preserve flavor. The combination of sweet clam meat, fragrant scallions, and oily richness creates a simple yet appealing dish.

In Southern coastal cuisine, this dish represents rustic grilled seafood, highlighting quick preparation and minimal seasoning while preserving natural taste.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'NAM_BO'),
    (SELECT TinhThanhID FROM dbo.TinhThanh WHERE MaTinh = 'CA_MAU'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KINH'),
    N'https://mia.vn/media/uploads/blog-du-lich/vop-nuong-mo-hanh-ca-mau-thom-ngon-dam-da-huong-vi-mien-dat-mui-1-1663662483.jpg'
),
(
    'MAM_BA_KHIA_RACH_GOC',
    N'Mắm Ba Khía Rạch Gốc',
    N'Rach Goc Fermented Crab',
    N'Món mắm',
    N'Fermented seafood',
    N'Đặc sản Cà Mau nổi tiếng với vị mặn đậm, gắn với vùng Rạch Gốc.',
    N'A Ca Mau specialty known for its strong salty flavor and connection to Rach Goc.',
    N'Mắm ba khía Rạch Gốc là một trong những đặc sản nổi tiếng nhất của Cà Mau, gắn liền với vùng Rạch Gốc – nơi có hệ sinh thái rừng ngập mặn phong phú. Ba khía là loài cua nhỏ sống trong rừng đước, được người dân thu hoạch theo mùa và chế biến bằng cách muối để tạo ra sản phẩm đặc trưng. Nhờ điều kiện tự nhiên thuận lợi, ba khía tại khu vực này thường có chất lượng tốt, thịt chắc và đậm vị.

Sau khi muối, ba khía được ủ trong thời gian nhất định để phát triển hương vị lên men. Khi ăn, mắm ba khía thường được trộn với tỏi, ớt, đường và chanh để tạo sự cân bằng giữa vị mặn, chua, cay và ngọt. Món ăn có thể dùng kèm cơm trắng hoặc làm món trộn hấp dẫn trong các bữa ăn gia đình.

Trong bức tranh ẩm thực miền Tây, mắm ba khía Rạch Gốc là đại diện tiêu biểu cho nhóm món mắm ven biển, phản ánh rõ nét văn hóa bảo quản và chế biến hải sản của cư dân vùng đất ngập mặn.',
    N'Rach Goc fermented crab is one of the most famous specialties of Ca Mau, closely associated with the Rach Goc area and its mangrove ecosystem. The crabs are small species living in coastal forests, harvested seasonally and preserved through salting to create a distinctive fermented product.

After fermentation, the crabs develop a strong flavor and are often mixed with garlic, chili, sugar, and lime to balance salty, sour, spicy, and sweet tastes. The dish is typically eaten with rice or used in mixed seafood dishes.

Within Mekong Delta cuisine, Rach Goc fermented crab represents coastal fermentation traditions and highlights local methods of preserving seafood resources.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'NAM_BO'),
    (SELECT TinhThanhID FROM dbo.TinhThanh WHERE MaTinh = 'CA_MAU'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KINH'),
    N'https://biolomix.vn/wp-content/uploads/2025/04/150422.jpg'
),
(
    'LAU_CA_KEO',
    N'Lẩu Cá Kèo',
    N'Goby Fish Hotpot',
    N'Món lẩu',
    N'Hotpot',
    N'Món lẩu đặc trưng với cá kèo nhỏ, thịt mềm và vị chua cay nhẹ.',
    N'A hotpot featuring small goby fish with tender meat and light sour-spicy broth.',
    N'Lẩu cá kèo là một món ăn quen thuộc của miền Tây Nam Bộ, đặc biệt phổ biến ở các tỉnh như Cà Mau, Bạc Liêu và TP.HCM. Cá kèo là loại cá nhỏ sống ở vùng nước lợ, có thịt mềm và vị ngọt tự nhiên. Khi dùng trong lẩu, cá thường được để nguyên con và thả trực tiếp vào nồi nước dùng đang sôi.

Nước lẩu thường được nấu theo hướng chua nhẹ, kết hợp với rau đắng – một loại rau đặc trưng tạo nên vị hơi đắng và hậu ngọt rất riêng. Khi ăn, cá chín tới sẽ giữ được độ mềm, không bị nát, kết hợp với vị rau và nước lẩu tạo nên trải nghiệm cân bằng và thú vị.

Trong hệ thống ẩm thực miền Tây, lẩu cá kèo là đại diện tiêu biểu cho nhóm món lẩu dân dã, phản ánh sự phong phú của nguồn cá nước lợ và thói quen ăn uống mang tính cộng đồng.',
    N'Goby fish hotpot is a familiar dish in the Mekong Delta, especially popular in Ca Mau, Bac Lieu, and Ho Chi Minh City. Goby fish are small brackish-water fish with tender meat and natural sweetness. In hotpot preparation, they are typically cooked whole in boiling broth.

The broth is often slightly sour and paired with bitter herbs, which create a unique balance of bitterness and sweetness. The fish remains tender when cooked properly, blending well with the broth and vegetables.

Within Southern cuisine, goby fish hotpot represents rustic communal dishes and highlights the diversity of brackish-water seafood.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'NAM_BO'),
    (SELECT TinhThanhID FROM dbo.TinhThanh WHERE MaTinh = 'CA_MAU'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KINH'),
    N'https://cdn.tgdd.vn/2021/09/CookProduct/Anhbia-1200x676-8.jpg'
),
(
    'GOI_CA_TRICH_PHU_QUOC',
    N'Gỏi Cá Trích Phú Quốc',
    N'Phu Quoc Herring Salad',
    N'Món gỏi',
    N'Salad',
    N'Đặc sản Phú Quốc với cá trích tươi, dừa nạo và rau sống.',
    N'A Phu Quoc specialty made from fresh herring, coconut, and herbs.',
    N'Gỏi cá trích là một trong những món ăn đặc trưng nhất của đảo Phú Quốc, nổi bật với nguyên liệu cá trích tươi sống. Cá được làm sạch, thái mỏng và trộn với dừa nạo, hành tây, ớt và các loại rau thơm để tạo nên món gỏi hài hòa về hương vị.

Món ăn thường được cuốn với bánh tráng và chấm nước mắm Phú Quốc đậm đà. Vị ngọt của cá, béo của dừa và thơm của rau tạo nên trải nghiệm tươi mới và đặc trưng vùng biển.

Trong ẩm thực Việt Nam, gỏi cá trích Phú Quốc là đại diện tiêu biểu cho món gỏi hải sản, thể hiện rõ nét văn hóa ẩm thực biển đảo.',
    N'Phu Quoc herring salad is one of the most iconic dishes of Phu Quoc Island, featuring fresh raw herring. The fish is cleaned, thinly sliced, and mixed with grated coconut, onions, chili, and herbs.

It is typically wrapped in rice paper and dipped in rich Phu Quoc fish sauce. The combination of sweet fish, creamy coconut, and fresh herbs creates a refreshing coastal flavor.

In Vietnamese cuisine, this dish represents seafood salads and highlights island culinary culture.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'NAM_BO'),
    (SELECT TinhThanhID FROM dbo.TinhThanh WHERE MaTinh = 'CA_MAU'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KINH'),
    N'https://media-cdn-v2.laodong.vn/Storage/NewsPortal/2020/12/20/863882/Goicatrichphuquocxac.JPG'
),
(
    'BUN_QUAY',
    N'Bún Quậy',
    N'Bun Quay',
    N'Món nước',
    N'Noodle soup',
    N'Món bún đặc trưng Phú Quốc với cách ăn tự pha nước chấm độc đáo.',
    N'A Phu Quoc noodle dish known for its self-mixed dipping sauce style.',
    N'Bún quậy là một món ăn nổi tiếng của Phú Quốc, được biết đến không chỉ bởi hương vị mà còn bởi cách ăn độc đáo. Sợi bún tươi được làm tại chỗ, kết hợp với chả cá, tôm xay và nước dùng nóng.

Điểm đặc biệt của món là người ăn tự pha nước chấm từ muối, đường, quất và ớt, sau đó “quậy” đều trước khi ăn, tạo nên tên gọi đặc trưng. Món ăn mang lại trải nghiệm tương tác thú vị và hương vị linh hoạt theo khẩu vị từng người.

Trong hệ thống ẩm thực Việt Nam, bún quậy là đại diện cho sự sáng tạo trong cách phục vụ và trải nghiệm ăn uống.',
    N'Bun quay is a well-known dish from Phu Quoc, recognized for both its flavor and unique dining style. Fresh noodles are made on-site and served with fish cake, shrimp paste, and hot broth.

The highlight is the self-mixed dipping sauce made from salt, sugar, citrus, and chili, which diners stir together before eating. This interactive element gives the dish its name and a personalized flavor experience.

In Vietnamese cuisine, bun quay represents innovation in dining style and culinary interaction.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'NAM_BO'),
    (SELECT TinhThanhID FROM dbo.TinhThanh WHERE MaTinh = 'CA_MAU'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KINH'),
    N'https://ik.imagekit.io/tvlk/blog/2023/04/bun-quay-4-1024x682.jpg?tr=q-70,c-at_max,w-1000,h-600'
),
(
    'NAM_TRAM',
    N'Nấm Tràm',
    N'Tram Mushroom',
    N'Nông sản',
    N'Wild ingredient',
    N'Đặc sản Phú Quốc với vị đắng nhẹ đặc trưng và giá trị theo mùa.',
    N'A seasonal Phu Quoc specialty known for its slight bitterness and unique flavor.',
    N'Nấm tràm là một loại nấm đặc trưng của Phú Quốc và một số vùng miền Trung – Nam Bộ, thường mọc tự nhiên sau những cơn mưa đầu mùa. Nấm có màu tím nâu, vị đắng nhẹ và mùi thơm đặc trưng.

Nấm tràm thường được dùng để nấu canh với hải sản như tôm, mực hoặc nấu cháo. Khi chế biến đúng cách, vị đắng sẽ dịu lại và để lại hậu ngọt. Đây là nguyên liệu mang tính mùa vụ cao và được xem như đặc sản thiên nhiên.

Trong bức tranh ẩm thực Việt Nam, nấm tràm là đại diện cho nhóm nguyên liệu hoang dã, phản ánh sự gắn bó giữa con người và tự nhiên.',
    N'Tram mushroom is a unique ingredient found in Phu Quoc and some central-southern regions, typically growing after early seasonal rains. It has a brownish-purple color, slight bitterness, and distinctive aroma.

It is often used in soups or porridge with seafood such as shrimp or squid. When prepared properly, its bitterness softens into a pleasant aftertaste. This mushroom is highly seasonal and considered a natural specialty.

In Vietnamese cuisine, tram mushroom represents wild ingredients and the close relationship between people and nature.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'NAM_BO'),
    (SELECT TinhThanhID FROM dbo.TinhThanh WHERE MaTinh = 'CA_MAU'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KINH'),
    N'https://statics.vinpearl.com/nam-tram-phu-quoc-2_1628233768.jpg'
),
(
    'CA_KHO_LANG_VU_DAI',
    N'Cá kho làng Vũ Đại',
    N'Vu Dai braised fish',
    N'Món kho',
    N'Braised dish',
    N'Món cá kho nổi tiếng của vùng Bắc Bộ với hương vị đậm đà, màu sắc sẫm đẹp và cách chế biến công phu trong niêu đất.',
    N'A famous Northern Vietnamese braised fish dish known for its rich flavor, dark glossy color, and meticulous clay-pot cooking method.',
    N'Cá kho làng Vũ Đại là một trong những món ăn tiêu biểu cho sự cầu kỳ và chiều sâu trong ẩm thực truyền thống miền Bắc. Món ăn thường được chế biến từ cá trắm đen, cắt khúc lớn, ướp cùng nhiều loại gia vị như riềng, gừng, tiêu, nước mắm, nước cốt chanh hoặc nước hàng rồi kho liên tục trong niêu đất suốt nhiều giờ. Quá trình đun nhỏ lửa bằng củi giúp thịt cá săn chắc, thấm vị, xương mềm dần và nước kho sánh lại thành lớp màu nâu cánh gián đặc trưng. Điều làm nên giá trị của món ăn không chỉ nằm ở hương vị đậm đà mà còn ở kỹ thuật chế biến đòi hỏi sự kiên nhẫn, kinh nghiệm và cảm nhận tinh tế về lửa, nước và thời gian. Trong đời sống ẩm thực Việt, cá kho làng Vũ Đại thường được nhắc đến như một món ăn giàu bản sắc, gắn với không khí sum vầy, sự chăm chút trong bữa cơm và tinh thần gìn giữ nghề nấu truyền thống của người Việt.',
    N'Vu Dai braised fish is one of the most representative dishes of the depth and craftsmanship found in traditional Northern Vietnamese cuisine. It is commonly prepared with black carp cut into large pieces and marinated with ingredients such as galangal, ginger, pepper, fish sauce, caramelized sauce, and other seasonings before being slowly braised in a clay pot for many hours. The prolonged cooking process over low heat allows the fish to absorb flavor thoroughly, become firm yet tender, and develop softened bones and a thick dark glaze. What gives the dish its lasting reputation is not only its rich taste, but also the highly demanding cooking technique that requires patience, experience, and careful control of heat, moisture, and timing. In Vietnamese culinary culture, Vu Dai braised fish is often regarded as a dish that expresses heritage, family warmth, and the enduring value of traditional cooking practices.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'BAC_BO'),
    (SELECT TinhThanhID FROM dbo.TinhThanh WHERE MaTinh = 'NINH_BINH'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KINH'),
    N'https://cdn.hstatic.net/files/200000700229/article/ca-kho-lang-vu-dai-1_6d180fb370b54e52995655bdb467796d.jpg'
),
(
    'CANH_CUA',
    N'Canh cua',
    N'Crab soup',
    N'Món canh truyền thống',
    N'Traditional soup',
    N'Món canh đặc trưng của Bắc Bộ, thanh mát, dân dã và gắn chặt với bữa cơm gia đình Việt.',
    N'A signature Northern Vietnamese soup that is light, rustic, and closely tied to traditional family meals.',
    N'Canh cua là món ăn tiêu biểu của ẩm thực Bắc Bộ, thường gợi nhắc đến bữa cơm gia đình mùa hè với cảm giác thanh mát, gần gũi và đậm chất quê nhà. Món ăn thường được nấu từ cua đồng giã nhuyễn, lọc lấy nước rồi đun để tạo thành riêu cua nổi lên bề mặt, kết hợp với các loại rau như rau đay, mồng tơi, mướp hoặc đôi khi ăn kèm cà pháo. Vị ngọt tự nhiên của cua hòa cùng sự mềm mát của rau tạo nên một tổng thể hài hòa, nhẹ nhưng vẫn đủ chiều sâu. Canh cua không cầu kỳ trong hình thức, song lại phản ánh rất rõ tinh thần của ẩm thực Việt: tận dụng nguyên liệu dân dã, coi trọng tính mùa vụ, cân bằng dinh dưỡng và tạo ra những món ăn phù hợp với điều kiện khí hậu cũng như đời sống sinh hoạt thường ngày. Đối với nhiều người, đây còn là món ăn gợi ký ức mạnh mẽ về gia đình, làng quê và nếp sống truyền thống.',
    N'Crab soup is one of the defining dishes of Northern Vietnamese cuisine, often associated with summer family meals and a sense of comfort, simplicity, and home. It is typically made by pounding field crabs, straining the liquid, and gently heating it until delicate crab curds form on the surface, then combining it with vegetables such as jute leaves, malabar spinach, and sponge gourd, sometimes served alongside pickled eggplant. The natural sweetness of the crab blends with the softness and freshness of the greens to create a dish that is light yet deeply satisfying. Although modest in appearance, crab soup reflects many essential principles of Vietnamese cooking: the use of humble local ingredients, respect for seasonality, nutritional balance, and the creation of dishes suited to both climate and daily life. For many people, it also carries strong emotional associations with childhood, family, and the traditional rhythm of Vietnamese home cooking.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'BAC_BO'),
    (SELECT TinhThanhID FROM dbo.TinhThanh WHERE MaTinh = 'HA_NOI'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KINH'),
    N'https://cdn2.fptshop.com.vn/unsafe/1920x0/filters:format(webp):quality(75)/canh_cua_dong_5b6db99b7a.jpg'
),
(
    'GIO_CHA',
    N'Giò chả',
    N'Vietnamese pork sausage',
    N'Món giò chả truyền thống',
    N'Traditional pork sausage',
    N'Món ăn quen thuộc trong ẩm thực Việt, thường xuất hiện trong bữa cơm gia đình, dịp lễ Tết và các mâm cỗ truyền thống.',
    N'A familiar dish in Vietnamese cuisine, commonly found in family meals, festive occasions, and traditional ceremonial trays.',
    N'Giò chả là một trong những món ăn truyền thống phổ biến và bền vững nhất trong đời sống ẩm thực Việt Nam. Thành phần chính thường là thịt heo được xay hoặc quết nhuyễn để tạo độ dai mịn, sau đó gói trong lá chuối và đem luộc, hấp hoặc chế biến theo từng biến thể khác nhau. Từ giò lụa mềm mượt, thanh vị cho đến các dạng chả đậm đà hơn, món ăn này đều thể hiện rõ sự tinh tế trong kỹ thuật xử lý nguyên liệu, kiểm soát kết cấu và cân bằng gia vị. Giò chả không chỉ là thực phẩm quen thuộc trong bữa cơm hàng ngày mà còn gần như luôn có mặt trong dịp lễ Tết, cưới hỏi, cúng giỗ hay những bữa ăn mang tính sum họp. Sự hiện diện rộng rãi ấy cho thấy món ăn này đã vượt qua vai trò của một món ngon thông thường để trở thành một phần của ký ức, nghi lễ và văn hóa ẩm thực Việt.',
    N'Vietnamese pork sausage is one of the most enduring and widely recognized traditional foods in Vietnamese culinary life. It is typically made from finely ground or pounded pork that is processed until smooth and elastic, then wrapped in banana leaves and boiled, steamed, or adapted into different forms depending on the desired style. From the silky and delicate texture of steamed pork roll to richer and firmer variations, the dish demonstrates a refined understanding of ingredient preparation, texture control, and seasoning balance. Pork sausage is not only common in everyday meals, but is also almost indispensable during Lunar New Year, weddings, memorial offerings, and other gatherings centered on family and ritual. Its lasting presence in these contexts shows that it has become more than just a food item; it is part of memory, ceremony, and the broader cultural fabric of Vietnamese dining.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'BAC_BO'),
    (SELECT TinhThanhID FROM dbo.TinhThanh WHERE MaTinh = 'HA_NOI'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KINH'),
    N'https://resource.kinhtedothi.vn/2024/12/08/18.jpg'
),
(
    'GIO_SAO',
    N'Giò sào',
    N'Vietnamese head cheese',
    N'Món giò truyền thống miền Bắc',
    N'Traditional Northern cold cut',
    N'Món ăn đặc trưng của miền Bắc, có kết cấu giòn sần sật, đậm đà và thường xuất hiện trong mâm cỗ gia đình.',
    N'A distinctive Northern Vietnamese dish with a pleasantly crunchy texture, rich flavor, and a common place on traditional family feast trays.',
    N'Giò sào là món ăn truyền thống gắn với miền Bắc, đặc biệt quen thuộc trong các dịp lễ Tết và mâm cỗ gia đình. Món thường được làm từ các phần thịt như tai, má, lưỡi và đầu heo, kết hợp với mộc nhĩ, nấm hương cùng gia vị rồi đem xào chín trước khi ép khuôn hoặc gói chặt để định hình. Khi cắt ra, giò sào có phần thịt kết dính chắc, xen lẫn độ giòn sần sật đặc trưng, tạo nên cảm giác vừa mộc mạc vừa hấp dẫn. So với giò lụa mềm mịn, giò sào mang cá tính rõ hơn, thể hiện phong cách ẩm thực chuộng sự chân thực, đậm vị và tận dụng tối đa nguyên liệu. Món ăn này không chỉ được yêu thích vì hương vị mà còn bởi nó phản ánh nếp sinh hoạt truyền thống, tinh thần tề gia nội trợ và sự phong phú trong cách người Việt biến những nguyên liệu quen thuộc thành món ăn có bản sắc riêng.',
    N'Vietnamese head cheese is a traditional Northern dish especially familiar during festive seasons and family feasts. It is commonly made from parts such as pork ear, cheek, tongue, and head meat, combined with wood ear mushrooms, shiitake, and seasonings, then stir-cooked before being pressed or tightly wrapped into shape. Once sliced, the dish reveals a firm structure with a signature crunchy texture that makes it both rustic and appealing. Compared with the smooth softness of steamed pork roll, this dish has a stronger identity, expressing a culinary preference for texture, full flavor, and careful use of all parts of the ingredient. Its value lies not only in taste, but also in how it reflects traditional domestic cooking, household skill, and the Vietnamese ability to transform familiar materials into foods with lasting cultural character.',
    (SELECT VungID FROM dbo.VungVanHoa WHERE MaVung = 'BAC_BO'),
    (SELECT TinhThanhID FROM dbo.TinhThanh WHERE MaTinh = 'HA_NOI'),
    (SELECT DanTocID FROM dbo.DanToc WHERE MaDanToc = 'KINH'),
    N'https://i-giadinh.vnecdn.net/2024/01/18/Thnhphm11-1705554357-5916-1705554715.jpg'
);

-- =================================================== KIỂM TRA TÍNH TOÀN VẸN DỮ LIỆU ===================================================
PRINT N'Kiem tra orphan foreign keys...';
SELECT 'TinhThanh.VungID' AS CheckName, COUNT(*) AS OrphanCount
FROM dbo.TinhThanh t LEFT JOIN dbo.VungVanHoa v ON t.VungID = v.VungID
WHERE t.VungID IS NOT NULL AND v.VungID IS NULL
UNION ALL
SELECT 'LeHoi.VungID', COUNT(*)
FROM dbo.LeHoi x LEFT JOIN dbo.VungVanHoa v ON x.VungID = v.VungID
WHERE x.VungID IS NOT NULL AND v.VungID IS NULL
UNION ALL
SELECT 'LeHoi.TinhThanhID', COUNT(*)
FROM dbo.LeHoi x LEFT JOIN dbo.TinhThanh t ON x.TinhThanhID = t.TinhThanhID
WHERE x.TinhThanhID IS NOT NULL AND t.TinhThanhID IS NULL
UNION ALL
SELECT 'LeHoi.DanTocID', COUNT(*)
FROM dbo.LeHoi x LEFT JOIN dbo.DanToc d ON x.DanTocID = d.DanTocID
WHERE x.DanTocID IS NOT NULL AND d.DanTocID IS NULL
UNION ALL
SELECT 'VanHoa.VungID', COUNT(*)
FROM dbo.VanHoa x LEFT JOIN dbo.VungVanHoa v ON x.VungID = v.VungID
WHERE x.VungID IS NOT NULL AND v.VungID IS NULL
UNION ALL
SELECT 'VanHoa.DanTocID', COUNT(*)
FROM dbo.VanHoa x LEFT JOIN dbo.DanToc d ON x.DanTocID = d.DanTocID
WHERE x.DanTocID IS NOT NULL AND d.DanTocID IS NULL
UNION ALL
SELECT 'BaiViet.VanHoaID', COUNT(*)
FROM dbo.BaiViet x LEFT JOIN dbo.VanHoa v ON x.VanHoaID = v.VanHoaID
WHERE x.VanHoaID IS NOT NULL AND v.VanHoaID IS NULL
UNION ALL
SELECT 'AmThuc.TinhThanhID', COUNT(*)
FROM dbo.AmThuc x LEFT JOIN dbo.TinhThanh t ON x.TinhThanhID = t.TinhThanhID
WHERE x.TinhThanhID IS NOT NULL AND t.TinhThanhID IS NULL;

PRINT N'Kiem tra mau lien ket giua BaiViet va VanHoa...';
SELECT TOP 20 b.MaBaiViet, v.Ma AS MaVanHoa, v.TenVI AS TenVanHoa, vv.MaVung, d.MaDanToc
FROM dbo.BaiViet b
LEFT JOIN dbo.VanHoa v ON b.VanHoaID = v.VanHoaID
LEFT JOIN dbo.VungVanHoa vv ON b.VungID = vv.VungID
LEFT JOIN dbo.DanToc d ON b.DanTocID = d.DanTocID
ORDER BY b.BaiVietID;

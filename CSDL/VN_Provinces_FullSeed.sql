/* =========================================================
   FULL SEED - 63 TỈNH / THÀNH CẤP TỈNH VIỆT NAM
   - Chuẩn hóa dữ liệu tỉnh/thành cho API động
   - Giữ pattern idempotent, không chèn trùng
   - Deactivate các bản ghi mẫu không phải đơn vị cấp tỉnh hiện hành
   ========================================================= */

SET NOCOUNT ON;

UPDATE dbo.TinhThanh
SET HoatDong = 0
WHERE MaTinh IN ('da-lat', 'phu-quoc')
  AND HoatDong = 1;

DECLARE @ProvinceSeed TABLE (
    MaTinh VARCHAR(80) PRIMARY KEY,
    TenVI NVARCHAR(200) NOT NULL,
    TenEN NVARCHAR(200) NOT NULL,
    LoaiTinhVI NVARCHAR(100) NOT NULL,
    LoaiTinhEN NVARCHAR(100) NOT NULL,
    MaVung VARCHAR(50) NOT NULL,
    TieuVungVI NVARCHAR(200) NULL,
    TieuVungEN NVARCHAR(200) NULL,
    DienTichKm2 DECIMAL(12,2) NULL,
    DanSo BIGINT NULL,
    AreaDisplayVI NVARCHAR(100) NULL,
    AreaDisplayEN NVARCHAR(100) NULL,
    PopulationDisplayVI NVARCHAR(100) NULL,
    PopulationDisplayEN NVARCHAR(100) NULL,
    TagsJsonVI NVARCHAR(MAX) NULL,
    TagsJsonEN NVARCHAR(MAX) NULL,
    TagsTextVI NVARCHAR(1000) NULL,
    TagsTextEN NVARCHAR(1000) NULL,
    MaVungDienThoai NVARCHAR(20) NULL,
    ThuTuHienThi INT NOT NULL
);

INSERT INTO @ProvinceSeed (
    MaTinh, TenVI, TenEN, LoaiTinhVI, LoaiTinhEN, MaVung,
    TieuVungVI, TieuVungEN, DienTichKm2, DanSo,
    AreaDisplayVI, AreaDisplayEN, PopulationDisplayVI, PopulationDisplayEN,
    TagsJsonVI, TagsJsonEN, TagsTextVI, TagsTextEN,
    MaVungDienThoai, ThuTuHienThi
)
VALUES
    ('ha-noi', N'Hà Nội', N'Hanoi', N'Thành phố trực thuộc TW', N'Municipality', 'BAC_BO', N'Đồng bằng sông Hồng', N'Red River Delta', 3358.60, 8400000, N'3,358.6 km²', N'3,358.6 km²', N'8.4 triệu người', N'8.4 million people', N'["Thủ đô","Văn hiến","Hồ Gươm"]', N'["Capital","Heritage","Hoan Kiem Lake"]', N'Thủ đô, Văn hiến, Hồ Gươm', N'Capital, Heritage, Hoan Kiem Lake', N'024', 1),
    ('hai-phong', N'Hải Phòng', N'Hai Phong', N'Thành phố trực thuộc TW', N'Municipality', 'BAC_BO', N'Duyên hải Bắc Bộ', N'Northern Coast', 1526.40, 2100000, N'1,526.4 km²', N'1,526.4 km²', N'2.1 triệu người', N'2.1 million people', N'["Cảng biển","Đồ Sơn","Cát Bà"]', N'["Seaport","Do Son","Cat Ba"]', N'Cảng biển, Đồ Sơn, Cát Bà', N'Seaport, Do Son, Cat Ba', N'0225', 2),
    ('quang-ninh', N'Quảng Ninh', N'Quang Ninh', N'Tỉnh', N'Province', 'BAC_BO', N'Đông Bắc', N'Northeast', 6178.00, 1340000, N'6,178 km²', N'6,178 km²', N'1.34 triệu người', N'1.34 million people', N'["Vịnh Hạ Long","Yên Tử","Biển đảo"]', N'["Ha Long Bay","Yen Tu","Sea and islands"]', N'Vịnh Hạ Long, Yên Tử, Biển đảo', N'Ha Long Bay, Yen Tu, Sea and islands', N'0203', 3),
    ('bac-ninh', N'Bắc Ninh', N'Bac Ninh', N'Tỉnh', N'Province', 'BAC_BO', N'Đồng bằng sông Hồng', N'Red River Delta', 822.70, 1550000, N'822.7 km²', N'822.7 km²', N'1.55 triệu người', N'1.55 million people', N'["Quan họ","Kinh Bắc","Làng nghề"]', N'["Quan ho folk songs","Kinh Bac","Craft villages"]', N'Quan họ, Kinh Bắc, Làng nghề', N'Quan ho folk songs, Kinh Bac, Craft villages', N'0222', 4),
    ('hung-yen', N'Hưng Yên', N'Hung Yen', N'Tỉnh', N'Province', 'BAC_BO', N'Đồng bằng sông Hồng', N'Red River Delta', 930.20, 1300000, N'930.2 km²', N'930.2 km²', N'1.3 triệu người', N'1.3 million people', N'["Phố Hiến","Nhãn lồng","Đồng bằng"]', N'["Pho Hien","Longan","Delta plains"]', N'Phố Hiến, Nhãn lồng, Đồng bằng', N'Pho Hien, Longan, Delta plains', N'0221', 5),
    ('hai-duong', N'Hải Dương', N'Hai Duong', N'Tỉnh', N'Province', 'BAC_BO', N'Đồng bằng sông Hồng', N'Red River Delta', 1668.20, 1950000, N'1,668.2 km²', N'1,668.2 km²', N'1.95 triệu người', N'1.95 million people', N'["Côn Sơn - Kiếp Bạc","Bánh đậu xanh","Đồng bằng"]', N'["Con Son - Kiep Bac","Green bean cake","Delta plains"]', N'Côn Sơn - Kiếp Bạc, Bánh đậu xanh, Đồng bằng', N'Con Son - Kiep Bac, Green bean cake, Delta plains', N'0220', 6),
    ('vinh-phuc', N'Vĩnh Phúc', N'Vinh Phuc', N'Tỉnh', N'Province', 'BAC_BO', N'Trung du và miền núi Bắc Bộ', N'Northern Midlands and Mountains', 1235.20, 1200000, N'1,235.2 km²', N'1,235.2 km²', N'1.2 triệu người', N'1.2 million people', N'["Tam Đảo","Công nghiệp","Làng cổ"]', N'["Tam Dao","Industry","Ancient villages"]', N'Tam Đảo, Công nghiệp, Làng cổ', N'Tam Dao, Industry, Ancient villages', N'0211', 7),
    ('thai-binh', N'Thái Bình', N'Thai Binh', N'Tỉnh', N'Province', 'BAC_BO', N'Đồng bằng sông Hồng', N'Red River Delta', 1584.60, 1860000, N'1,584.6 km²', N'1,584.6 km²', N'1.86 triệu người', N'1.86 million people', N'["Lúa gạo","Biển Đồng Châu","Chèo"]', N'["Rice fields","Dong Chau coast","Cheo theatre"]', N'Lúa gạo, Biển Đồng Châu, Chèo', N'Rice fields, Dong Chau coast, Cheo theatre', N'0227', 8),
    ('nam-dinh', N'Nam Định', N'Nam Dinh', N'Tỉnh', N'Province', 'BAC_BO', N'Đồng bằng sông Hồng', N'Red River Delta', 1668.00, 1840000, N'1,668 km²', N'1,668 km²', N'1.84 triệu người', N'1.84 million people', N'["Phủ Dầy","Dệt may","Nhà thờ"]', N'["Phu Day","Textiles","Churches"]', N'Phủ Dầy, Dệt may, Nhà thờ', N'Phu Day, Textiles, Churches', N'0228', 9),
    ('ha-nam', N'Hà Nam', N'Ha Nam', N'Tỉnh', N'Province', 'BAC_BO', N'Đồng bằng sông Hồng', N'Red River Delta', 860.90, 950000, N'860.9 km²', N'860.9 km²', N'950 nghìn người', N'950 thousand people', N'["Tam Chúc","Núi đá vôi","Cửa ngõ phía Nam Hà Nội"]', N'["Tam Chuc","Limestone hills","Southern gateway of Hanoi"]', N'Tam Chúc, Núi đá vôi, Cửa ngõ phía Nam Hà Nội', N'Tam Chuc, Limestone hills, Southern gateway of Hanoi', N'0226', 10),
    ('ninh-binh', N'Ninh Bình', N'Ninh Binh', N'Tỉnh', N'Province', 'BAC_BO', N'Đồng bằng sông Hồng', N'Red River Delta', 1411.90, 1000000, N'1,411.9 km²', N'1,411.9 km²', N'1 triệu người', N'1 million people', N'["Tràng An","Hoa Lư","Tam Cốc"]', N'["Trang An","Hoa Lu","Tam Coc"]', N'Tràng An, Hoa Lư, Tam Cốc', N'Trang An, Hoa Lu, Tam Coc', N'0229', 11),
    ('phu-tho', N'Phú Thọ', N'Phu Tho', N'Tỉnh', N'Province', 'BAC_BO', N'Trung du và miền núi Bắc Bộ', N'Northern Midlands and Mountains', 3533.40, 1500000, N'3,533.4 km²', N'3,533.4 km²', N'1.5 triệu người', N'1.5 million people', N'["Đền Hùng","Xoan","Ngã ba sông"]', N'["Hung Kings Temple","Xoan singing","River confluence"]', N'Đền Hùng, Xoan, Ngã ba sông', N'Hung Kings Temple, Xoan singing, River confluence', N'0210', 12),
    ('thai-nguyen', N'Thái Nguyên', N'Thai Nguyen', N'Tỉnh', N'Province', 'BAC_BO', N'Trung du và miền núi Bắc Bộ', N'Northern Midlands and Mountains', 3521.90, 1360000, N'3,521.9 km²', N'3,521.9 km²', N'1.36 triệu người', N'1.36 million people', N'["Trà Tân Cương","ATK","Trung tâm giáo dục"]', N'["Tan Cuong tea","ATK base","Education hub"]', N'Trà Tân Cương, ATK, Trung tâm giáo dục', N'Tan Cuong tea, ATK base, Education hub', N'0208', 13),
    ('bac-giang', N'Bắc Giang', N'Bac Giang', N'Tỉnh', N'Province', 'BAC_BO', N'Trung du và miền núi Bắc Bộ', N'Northern Midlands and Mountains', 3895.90, 1900000, N'3,895.9 km²', N'3,895.9 km²', N'1.9 triệu người', N'1.9 million people', N'["Vải thiều","Tây Yên Tử","Công nghiệp"]', N'["Lychee","Tay Yen Tu","Industry"]', N'Vải thiều, Tây Yên Tử, Công nghiệp', N'Lychee, Tay Yen Tu, Industry', N'0204', 14),
    ('lang-son', N'Lạng Sơn', N'Lang Son', N'Tỉnh', N'Province', 'BAC_BO', N'Đông Bắc', N'Northeast', 8310.20, 800000, N'8,310.2 km²', N'8,310.2 km²', N'800 nghìn người', N'800 thousand people', N'["Cửa khẩu","Mẫu Sơn","Chợ biên giới"]', N'["Border gate","Mau Son","Border markets"]', N'Cửa khẩu, Mẫu Sơn, Chợ biên giới', N'Border gate, Mau Son, Border markets', N'0205', 15),
    ('cao-bang', N'Cao Bằng', N'Cao Bang', N'Tỉnh', N'Province', 'BAC_BO', N'Đông Bắc', N'Northeast', 6700.40, 540000, N'6,700.4 km²', N'6,700.4 km²', N'540 nghìn người', N'540 thousand people', N'["Thác Bản Giốc","Non nước","Biên giới"]', N'["Ban Gioc Waterfall","Karst landscapes","Border region"]', N'Thác Bản Giốc, Non nước, Biên giới', N'Ban Gioc Waterfall, Karst landscapes, Border region', N'0206', 16),
    ('bac-kan', N'Bắc Kạn', N'Bac Kan', N'Tỉnh', N'Province', 'BAC_BO', N'Đông Bắc', N'Northeast', 4860.00, 310000, N'4,860 km²', N'4,860 km²', N'310 nghìn người', N'310 thousand people', N'["Ba Bể","Rừng núi","Hồ tự nhiên"]', N'["Ba Be Lake","Mountains and forests","Natural lake"]', N'Ba Bể, Rừng núi, Hồ tự nhiên', N'Ba Be Lake, Mountains and forests, Natural lake', N'0209', 17),
    ('tuyen-quang', N'Tuyên Quang', N'Tuyen Quang', N'Tỉnh', N'Province', 'BAC_BO', N'Trung du và miền núi Bắc Bộ', N'Northern Midlands and Mountains', 5867.90, 790000, N'5,867.9 km²', N'5,867.9 km²', N'790 nghìn người', N'790 thousand people', N'["ATK Tân Trào","Lễ hội Thành Tuyên","Sông Lô"]', N'["Tan Trao historic base","Thanh Tuyen festival","Lo River"]', N'ATK Tân Trào, Lễ hội Thành Tuyên, Sông Lô', N'Tan Trao historic base, Thanh Tuyen festival, Lo River', N'0207', 18),
    ('ha-giang', N'Hà Giang', N'Ha Giang', N'Tỉnh', N'Province', 'BAC_BO', N'Đông Bắc', N'Northeast', 7929.50, 890000, N'7,929.5 km²', N'7,929.5 km²', N'890 nghìn người', N'890 thousand people', N'["Cao nguyên đá Đồng Văn","Mã Pí Lèng","Hoa tam giác mạch"]', N'["Dong Van Karst Plateau","Ma Pi Leng","Buckwheat flowers"]', N'Cao nguyên đá Đồng Văn, Mã Pí Lèng, Hoa tam giác mạch', N'Dong Van Karst Plateau, Ma Pi Leng, Buckwheat flowers', N'0219', 19),
    ('lao-cai', N'Lào Cai', N'Lao Cai', N'Tỉnh', N'Province', 'BAC_BO', N'Tây Bắc', N'Northwest', 6364.00, 780000, N'6,364 km²', N'6,364 km²', N'780 nghìn người', N'780 thousand people', N'["Sa Pa","Fansipan","Biên giới"]', N'["Sa Pa","Fansipan","Border region"]', N'Sa Pa, Fansipan, Biên giới', N'Sa Pa, Fansipan, Border region', N'0214', 20),
    ('yen-bai', N'Yên Bái', N'Yen Bai', N'Tỉnh', N'Province', 'BAC_BO', N'Tây Bắc', N'Northwest', 6892.70, 840000, N'6,892.7 km²', N'6,892.7 km²', N'840 nghìn người', N'840 thousand people', N'["Mù Cang Chải","Ruộng bậc thang","Suối khoáng"]', N'["Mu Cang Chai","Terraced fields","Hot springs"]', N'Mù Cang Chải, Ruộng bậc thang, Suối khoáng', N'Mu Cang Chai, Terraced fields, Hot springs', N'0216', 21),
    ('dien-bien', N'Điện Biên', N'Dien Bien', N'Tỉnh', N'Province', 'BAC_BO', N'Tây Bắc', N'Northwest', 9539.90, 650000, N'9,539.9 km²', N'9,539.9 km²', N'650 nghìn người', N'650 thousand people', N'["Điện Biên Phủ","Cánh đồng Mường Thanh","Biên giới"]', N'["Dien Bien Phu","Muong Thanh field","Border region"]', N'Điện Biên Phủ, Cánh đồng Mường Thanh, Biên giới', N'Dien Bien Phu, Muong Thanh field, Border region', N'0215', 22),
    ('lai-chau', N'Lai Châu', N'Lai Chau', N'Tỉnh', N'Province', 'BAC_BO', N'Tây Bắc', N'Northwest', 9068.80, 490000, N'9,068.8 km²', N'9,068.8 km²', N'490 nghìn người', N'490 thousand people', N'["Đèo cao","Bản làng","Sông Đà"]', N'["High passes","Villages","Da River"]', N'Đèo cao, Bản làng, Sông Đà', N'High passes, Villages, Da River', N'0213', 23),
    ('son-la', N'Sơn La', N'Son La', N'Tỉnh', N'Province', 'BAC_BO', N'Tây Bắc', N'Northwest', 14123.50, 1330000, N'14,123.5 km²', N'14,123.5 km²', N'1.33 triệu người', N'1.33 million people', N'["Mộc Châu","Cao nguyên","Thủy điện"]', N'["Moc Chau","Plateau","Hydropower"]', N'Mộc Châu, Cao nguyên, Thủy điện', N'Moc Chau, Plateau, Hydropower', N'0212', 24),
    ('hoa-binh', N'Hòa Bình', N'Hoa Binh', N'Tỉnh', N'Province', 'BAC_BO', N'Tây Bắc', N'Northwest', 4590.30, 880000, N'4,590.3 km²', N'4,590.3 km²', N'880 nghìn người', N'880 thousand people', N'["Mai Châu","Hồ Hòa Bình","Mường"]', N'["Mai Chau","Hoa Binh Lake","Muong culture"]', N'Mai Châu, Hồ Hòa Bình, Mường', N'Mai Chau, Hoa Binh Lake, Muong culture', N'0218', 25),

    ('thanh-hoa', N'Thanh Hóa', N'Thanh Hoa', N'Tỉnh', N'Province', 'TRUNG_BO', N'Bắc Trung Bộ', N'North Central Coast', 11114.70, 3700000, N'11,114.7 km²', N'11,114.7 km²', N'3.7 triệu người', N'3.7 million people', N'["Thành Nhà Hồ","Biển Sầm Sơn","Lam Kinh"]', N'["Ho Citadel","Sam Son Beach","Lam Kinh"]', N'Thành Nhà Hồ, Biển Sầm Sơn, Lam Kinh', N'Ho Citadel, Sam Son Beach, Lam Kinh', N'0237', 26),
    ('nghe-an', N'Nghệ An', N'Nghe An', N'Tỉnh', N'Province', 'TRUNG_BO', N'Bắc Trung Bộ', N'North Central Coast', 16490.30, 3400000, N'16,490.3 km²', N'16,490.3 km²', N'3.4 triệu người', N'3.4 million people', N'["Quê Bác","Cửa Lò","Miền Tây Nghệ An"]', N'["Ho Chi Minh hometown","Cua Lo","Western Nghe An"]', N'Quê Bác, Cửa Lò, Miền Tây Nghệ An', N'Ho Chi Minh hometown, Cua Lo, Western Nghe An', N'0238', 27),
    ('ha-tinh', N'Hà Tĩnh', N'Ha Tinh', N'Tỉnh', N'Province', 'TRUNG_BO', N'Bắc Trung Bộ', N'North Central Coast', 5990.70, 1300000, N'5,990.7 km²', N'5,990.7 km²', N'1.3 triệu người', N'1.3 million people', N'["Ngã ba Đồng Lộc","Thiên Cầm","Ví giặm"]', N'["Dong Loc Junction","Thien Cam","Vi Giam singing"]', N'Ngã ba Đồng Lộc, Thiên Cầm, Ví giặm', N'Dong Loc Junction, Thien Cam, Vi Giam singing', N'0239', 28),
    ('quang-binh', N'Quảng Bình', N'Quang Binh', N'Tỉnh', N'Province', 'TRUNG_BO', N'Bắc Trung Bộ', N'North Central Coast', 8065.80, 910000, N'8,065.8 km²', N'8,065.8 km²', N'910 nghìn người', N'910 thousand people', N'["Phong Nha - Kẻ Bàng","Hang động","Biển Nhật Lệ"]', N'["Phong Nha - Ke Bang","Caves","Nhat Le Beach"]', N'Phong Nha - Kẻ Bàng, Hang động, Biển Nhật Lệ', N'Phong Nha - Ke Bang, Caves, Nhat Le Beach', N'0232', 29),
    ('quang-tri', N'Quảng Trị', N'Quang Tri', N'Tỉnh', N'Province', 'TRUNG_BO', N'Bắc Trung Bộ', N'North Central Coast', 4740.50, 650000, N'4,740.5 km²', N'4,740.5 km²', N'650 nghìn người', N'650 thousand people', N'["Thành cổ","Cầu Hiền Lương","Biển Cửa Tùng"]', N'["Ancient citadel","Hien Luong Bridge","Cua Tung Beach"]', N'Thành cổ, Cầu Hiền Lương, Biển Cửa Tùng', N'Ancient citadel, Hien Luong Bridge, Cua Tung Beach', N'0233', 30),
    ('hue', N'Huế', N'Hue', N'Thành phố trực thuộc TW', N'Municipality', 'TRUNG_BO', N'Bắc Trung Bộ', N'North Central Coast', 4947.10, 1236000, N'4,947.1 km²', N'4,947.1 km²', N'1.24 triệu người', N'1.24 million people', N'["Cố đô","Sông Hương","Nhã nhạc"]', N'["Ancient capital","Perfume River","Royal court music"]', N'Cố đô, Sông Hương, Nhã nhạc', N'Ancient capital, Perfume River, Royal court music', N'0234', 31),
    ('da-nang', N'Đà Nẵng', N'Da Nang', N'Thành phố trực thuộc TW', N'Municipality', 'TRUNG_BO', N'Nam Trung Bộ', N'South Central Coast', 1285.00, 1160000, N'1,285 km²', N'1,285 km²', N'1.16 triệu người', N'1.16 million people', N'["Biển Mỹ Khê","Cầu Rồng","Bà Nà Hills"]', N'["My Khe Beach","Dragon Bridge","Ba Na Hills"]', N'Biển Mỹ Khê, Cầu Rồng, Bà Nà Hills', N'My Khe Beach, Dragon Bridge, Ba Na Hills', N'0236', 32),
    ('quang-nam', N'Quảng Nam', N'Quang Nam', N'Tỉnh', N'Province', 'TRUNG_BO', N'Nam Trung Bộ', N'South Central Coast', 10574.90, 1500000, N'10,574.9 km²', N'10,574.9 km²', N'1.5 triệu người', N'1.5 million people', N'["Hội An","Mỹ Sơn","Cù Lao Chàm"]', N'["Hoi An","My Son","Cu Lao Cham"]', N'Hội An, Mỹ Sơn, Cù Lao Chàm', N'Hoi An, My Son, Cu Lao Cham', N'0235', 33),
    ('quang-ngai', N'Quảng Ngãi', N'Quang Ngai', N'Tỉnh', N'Province', 'TRUNG_BO', N'Nam Trung Bộ', N'South Central Coast', 5135.20, 1250000, N'5,135.2 km²', N'5,135.2 km²', N'1.25 triệu người', N'1.25 million people', N'["Lý Sơn","Sa Huỳnh","Dung Quất"]', N'["Ly Son","Sa Huynh","Dung Quat"]', N'Lý Sơn, Sa Huỳnh, Dung Quất', N'Ly Son, Sa Huynh, Dung Quat', N'0255', 34),
    ('binh-dinh', N'Bình Định', N'Binh Dinh', N'Tỉnh', N'Province', 'TRUNG_BO', N'Nam Trung Bộ', N'South Central Coast', 6066.20, 1490000, N'6,066.2 km²', N'6,066.2 km²', N'1.49 triệu người', N'1.49 million people', N'["Quy Nhơn","Tây Sơn","Võ cổ truyền"]', N'["Quy Nhon","Tay Son","Traditional martial arts"]', N'Quy Nhơn, Tây Sơn, Võ cổ truyền', N'Quy Nhon, Tay Son, Traditional martial arts', N'0256', 35),
    ('phu-yen', N'Phú Yên', N'Phu Yen', N'Tỉnh', N'Province', 'TRUNG_BO', N'Nam Trung Bộ', N'South Central Coast', 5023.40, 880000, N'5,023.4 km²', N'5,023.4 km²', N'880 nghìn người', N'880 thousand people', N'["Gành Đá Đĩa","Tuy Hòa","Biển xanh"]', N'["Ganh Da Dia","Tuy Hoa","Blue coast"]', N'Gành Đá Đĩa, Tuy Hòa, Biển xanh', N'Ganh Da Dia, Tuy Hoa, Blue coast', N'0257', 36),
    ('khanh-hoa', N'Khánh Hòa', N'Khanh Hoa', N'Tỉnh', N'Province', 'TRUNG_BO', N'Nam Trung Bộ', N'South Central Coast', 5217.60, 1370000, N'5,217.6 km²', N'5,217.6 km²', N'1.37 triệu người', N'1.37 million people', N'["Nha Trang","Cam Ranh","Biển đảo"]', N'["Nha Trang","Cam Ranh","Sea and islands"]', N'Nha Trang, Cam Ranh, Biển đảo', N'Nha Trang, Cam Ranh, Sea and islands', N'0258', 37),
    ('ninh-thuan', N'Ninh Thuận', N'Ninh Thuan', N'Tỉnh', N'Province', 'TRUNG_BO', N'Nam Trung Bộ', N'South Central Coast', 3358.00, 610000, N'3,358 km²', N'3,358 km²', N'610 nghìn người', N'610 thousand people', N'["Nho","Tháp Chăm","Vịnh Vĩnh Hy"]', N'["Grapes","Cham towers","Vinh Hy Bay"]', N'Nho, Tháp Chăm, Vịnh Vĩnh Hy', N'Grapes, Cham towers, Vinh Hy Bay', N'0259', 38),
    ('binh-thuan', N'Bình Thuận', N'Binh Thuan', N'Tỉnh', N'Province', 'TRUNG_BO', N'Nam Trung Bộ', N'South Central Coast', 7812.80, 1270000, N'7,812.8 km²', N'7,812.8 km²', N'1.27 triệu người', N'1.27 million people', N'["Mũi Né","Thanh long","Biển gió"]', N'["Mui Ne","Dragon fruit","Windy coast"]', N'Mũi Né, Thanh long, Biển gió', N'Mui Ne, Dragon fruit, Windy coast', N'0252', 39),

    ('kon-tum', N'Kon Tum', N'Kon Tum', N'Tỉnh', N'Province', 'TAY_NGUYEN', N'Bắc Tây Nguyên', N'North Central Highlands', 9674.20, 580000, N'9,674.2 km²', N'9,674.2 km²', N'580 nghìn người', N'580 thousand people', N'["Nhà rông","Măng Đen","Ngã ba Đông Dương"]', N'["Communal houses","Mang Den","Indochina junction"]', N'Nhà rông, Măng Đen, Ngã ba Đông Dương', N'Communal houses, Mang Den, Indochina junction', N'0260', 40),
    ('gia-lai', N'Gia Lai', N'Gia Lai', N'Tỉnh', N'Province', 'TAY_NGUYEN', N'Bắc Tây Nguyên', N'North Central Highlands', 15510.10, 1600000, N'15,510.1 km²', N'15,510.1 km²', N'1.6 triệu người', N'1.6 million people', N'["Biển Hồ","Cồng chiêng","Cao nguyên"]', N'["Bien Ho Lake","Gong culture","Plateau"]', N'Biển Hồ, Cồng chiêng, Cao nguyên', N'Bien Ho Lake, Gong culture, Plateau', N'0269', 41),
    ('dak-lak', N'Đắk Lắk', N'Dak Lak', N'Tỉnh', N'Province', 'TAY_NGUYEN', N'Trung Tây Nguyên', N'Central Highlands', 13070.40, 1950000, N'13,070.4 km²', N'13,070.4 km²', N'1.95 triệu người', N'1.95 million people', N'["Buôn Ma Thuột","Cà phê","Voi và sử thi"]', N'["Buon Ma Thuot","Coffee","Elephants and epics"]', N'Buôn Ma Thuột, Cà phê, Voi và sử thi', N'Buon Ma Thuot, Coffee, Elephants and epics', N'0262', 42),
    ('dak-nong', N'Đắk Nông', N'Dak Nong', N'Tỉnh', N'Province', 'TAY_NGUYEN', N'Nam Tây Nguyên', N'Southern Highlands', 6509.30, 690000, N'6,509.3 km²', N'6,509.3 km²', N'690 nghìn người', N'690 thousand people', N'["Công viên địa chất","Hồ Tà Đùng","Cao nguyên"]', N'["Geopark","Ta Dung Lake","Highlands"]', N'Công viên địa chất, Hồ Tà Đùng, Cao nguyên', N'Geopark, Ta Dung Lake, Highlands', N'0261', 43),
    ('lam-dong', N'Lâm Đồng', N'Lam Dong', N'Tỉnh', N'Province', 'TAY_NGUYEN', N'Nam Tây Nguyên', N'Southern Highlands', 9781.20, 1350000, N'9,781.2 km²', N'9,781.2 km²', N'1.35 triệu người', N'1.35 million people', N'["Đà Lạt","Cao nguyên","Hoa và trà"]', N'["Da Lat","Plateau","Flowers and tea"]', N'Đà Lạt, Cao nguyên, Hoa và trà', N'Da Lat, Plateau, Flowers and tea', N'0263', 44),

    ('ho-chi-minh-city', N'TP. Hồ Chí Minh', N'Ho Chi Minh City', N'Thành phố trực thuộc TW', N'Municipality', 'NAM_BO', N'Đông Nam Bộ', N'Southeastern Vietnam', 2095.00, 9400000, N'2,095 km²', N'2,095 km²', N'9.4 triệu người', N'9.4 million people', N'["Đô thị lớn","Sài Gòn","Kinh tế năng động"]', N'["Metropolis","Sai Gon","Dynamic economy"]', N'Đô thị lớn, Sài Gòn, Kinh tế năng động', N'Metropolis, Sai Gon, Dynamic economy', N'028', 45),
    ('binh-duong', N'Bình Dương', N'Binh Duong', N'Tỉnh', N'Province', 'NAM_BO', N'Đông Nam Bộ', N'Southeastern Vietnam', 2694.70, 2800000, N'2,694.7 km²', N'2,694.7 km²', N'2.8 triệu người', N'2.8 million people', N'["Công nghiệp","Thủ Dầu Một","Làng sơn mài"]', N'["Industry","Thu Dau Mot","Lacquer craft"]', N'Công nghiệp, Thủ Dầu Một, Làng sơn mài', N'Industry, Thu Dau Mot, Lacquer craft', N'0274', 46),
    ('dong-nai', N'Đồng Nai', N'Dong Nai', N'Tỉnh', N'Province', 'NAM_BO', N'Đông Nam Bộ', N'Southeastern Vietnam', 5863.60, 3300000, N'5,863.6 km²', N'5,863.6 km²', N'3.3 triệu người', N'3.3 million people', N'["Biên Hòa","Công nghiệp","Rừng Nam Cát Tiên"]', N'["Bien Hoa","Industry","Nam Cat Tien forest"]', N'Biên Hòa, Công nghiệp, Rừng Nam Cát Tiên', N'Bien Hoa, Industry, Nam Cat Tien forest', N'0251', 47),
    ('tay-ninh', N'Tây Ninh', N'Tay Ninh', N'Tỉnh', N'Province', 'NAM_BO', N'Đông Nam Bộ', N'Southeastern Vietnam', 4041.70, 1200000, N'4,041.7 km²', N'4,041.7 km²', N'1.2 triệu người', N'1.2 million people', N'["Núi Bà Đen","Tòa Thánh","Biên giới"]', N'["Ba Den Mountain","Cao Dai Holy See","Border region"]', N'Núi Bà Đen, Tòa Thánh, Biên giới', N'Ba Den Mountain, Cao Dai Holy See, Border region', N'0276', 48),
    ('binh-phuoc', N'Bình Phước', N'Binh Phuoc', N'Tỉnh', N'Province', 'NAM_BO', N'Đông Nam Bộ', N'Southeastern Vietnam', 6876.60, 1050000, N'6,876.6 km²', N'6,876.6 km²', N'1.05 triệu người', N'1.05 million people', N'["Điều","Rừng cao su","Biên giới"]', N'["Cashew","Rubber forests","Border region"]', N'Điều, Rừng cao su, Biên giới', N'Cashew, Rubber forests, Border region', N'0271', 49),
    ('ba-ria-vung-tau', N'Bà Rịa - Vũng Tàu', N'Ba Ria - Vung Tau', N'Tỉnh', N'Province', 'NAM_BO', N'Đông Nam Bộ', N'Southeastern Vietnam', 1980.80, 1300000, N'1,980.8 km²', N'1,980.8 km²', N'1.3 triệu người', N'1.3 million people', N'["Biển","Dầu khí","Côn Đảo"]', N'["Sea","Petroleum","Con Dao"]', N'Biển, Dầu khí, Côn Đảo', N'Sea, Petroleum, Con Dao', N'0254', 50),

    ('long-an', N'Long An', N'Long An', N'Tỉnh', N'Province', 'DBSCL', N'Đồng bằng sông Cửu Long', N'Mekong Delta', 4494.90, 1750000, N'4,494.9 km²', N'4,494.9 km²', N'1.75 triệu người', N'1.75 million people', N'["Cửa ngõ miền Tây","Làng nổi Tân Lập","Sông Vàm Cỏ"]', N'["Gateway to Mekong Delta","Tan Lap floating village","Vam Co River"]', N'Cửa ngõ miền Tây, Làng nổi Tân Lập, Sông Vàm Cỏ', N'Gateway to Mekong Delta, Tan Lap floating village, Vam Co River', N'0272', 51),
    ('tien-giang', N'Tiền Giang', N'Tien Giang', N'Tỉnh', N'Province', 'DBSCL', N'Đồng bằng sông Cửu Long', N'Mekong Delta', 2510.50, 1800000, N'2,510.5 km²', N'2,510.5 km²', N'1.8 triệu người', N'1.8 million people', N'["Mỹ Tho","Cái Bè","Vườn trái cây"]', N'["My Tho","Cai Be","Orchards"]', N'Mỹ Tho, Cái Bè, Vườn trái cây', N'My Tho, Cai Be, Orchards', N'0273', 52),
    ('ben-tre', N'Bến Tre', N'Ben Tre', N'Tỉnh', N'Province', 'DBSCL', N'Đồng bằng sông Cửu Long', N'Mekong Delta', 2394.60, 1300000, N'2,394.6 km²', N'2,394.6 km²', N'1.3 triệu người', N'1.3 million people', N'["Xứ dừa","Sông nước","Làng nghề"]', N'["Coconut land","River life","Craft villages"]', N'Xứ dừa, Sông nước, Làng nghề', N'Coconut land, River life, Craft villages', N'0275', 53),
    ('tra-vinh', N'Trà Vinh', N'Tra Vinh', N'Tỉnh', N'Province', 'DBSCL', N'Đồng bằng sông Cửu Long', N'Mekong Delta', 2358.20, 1020000, N'2,358.2 km²', N'2,358.2 km²', N'1.02 triệu người', N'1.02 million people', N'["Văn hóa Khmer","Ao Bà Om","Biển Ba Động"]', N'["Khmer culture","Ba Om Pond","Ba Dong Beach"]', N'Văn hóa Khmer, Ao Bà Om, Biển Ba Động', N'Khmer culture, Ba Om Pond, Ba Dong Beach', N'0294', 54),
    ('vinh-long', N'Vĩnh Long', N'Vinh Long', N'Tỉnh', N'Province', 'DBSCL', N'Đồng bằng sông Cửu Long', N'Mekong Delta', 1525.70, 1030000, N'1,525.7 km²', N'1,525.7 km²', N'1.03 triệu người', N'1.03 million people', N'["Cù lao","Sông Tiền","Nhà cổ"]', N'["Islets","Tien River","Ancient houses"]', N'Cù lao, Sông Tiền, Nhà cổ', N'Islets, Tien River, Ancient houses', N'0270', 55),
    ('dong-thap', N'Đồng Tháp', N'Dong Thap', N'Tỉnh', N'Province', 'DBSCL', N'Đồng bằng sông Cửu Long', N'Mekong Delta', 3383.80, 1600000, N'3,383.8 km²', N'3,383.8 km²', N'1.6 triệu người', N'1.6 million people', N'["Đồng sen","Sa Đéc","Tràm Chim"]', N'["Lotus fields","Sa Dec","Tram Chim"]', N'Đồng sen, Sa Đéc, Tràm Chim', N'Lotus fields, Sa Dec, Tram Chim', N'0277', 56),
    ('an-giang', N'An Giang', N'An Giang', N'Tỉnh', N'Province', 'DBSCL', N'Đồng bằng sông Cửu Long', N'Mekong Delta', 3536.70, 2200000, N'3,536.7 km²', N'3,536.7 km²', N'2.2 triệu người', N'2.2 million people', N'["Châu Đốc","Thất Sơn","Văn hóa Chăm"]', N'["Chau Doc","Seven Mountains","Cham culture"]', N'Châu Đốc, Thất Sơn, Văn hóa Chăm', N'Chau Doc, Seven Mountains, Cham culture', N'0296', 57),
    ('kien-giang', N'Kiên Giang', N'Kien Giang', N'Tỉnh', N'Province', 'DBSCL', N'Đồng bằng sông Cửu Long', N'Mekong Delta', 6348.50, 1800000, N'6,348.5 km²', N'6,348.5 km²', N'1.8 triệu người', N'1.8 million people', N'["Rạch Giá","Hà Tiên","Biển đảo"]', N'["Rach Gia","Ha Tien","Sea and islands"]', N'Rạch Giá, Hà Tiên, Biển đảo', N'Rach Gia, Ha Tien, Sea and islands', N'0297', 58),
    ('can-tho', N'Cần Thơ', N'Can Tho', N'Thành phố trực thuộc TW', N'Municipality', 'DBSCL', N'Đồng bằng sông Cửu Long', N'Mekong Delta', 1438.96, 1240000, N'1,439 km²', N'1,439 km²', N'1.24 triệu người', N'1.24 million people', N'["Chợ nổi","Sông nước","Ẩm thực"]', N'["Floating market","River life","Cuisine"]', N'Chợ nổi, Sông nước, Ẩm thực', N'Floating market, River life, Cuisine', N'0292', 59),
    ('hau-giang', N'Hậu Giang', N'Hau Giang', N'Tỉnh', N'Province', 'DBSCL', N'Đồng bằng sông Cửu Long', N'Mekong Delta', 1621.70, 730000, N'1,621.7 km²', N'1,621.7 km²', N'730 nghìn người', N'730 thousand people', N'["Kênh xáng Xà No","Lúa gạo","Miệt vườn"]', N'["Xa No Canal","Rice fields","Orchard life"]', N'Kênh xáng Xà No, Lúa gạo, Miệt vườn', N'Xa No Canal, Rice fields, Orchard life', N'0293', 60),
    ('soc-trang', N'Sóc Trăng', N'Soc Trang', N'Tỉnh', N'Province', 'DBSCL', N'Đồng bằng sông Cửu Long', N'Mekong Delta', 3311.80, 1200000, N'3,311.8 km²', N'3,311.8 km²', N'1.2 triệu người', N'1.2 million people', N'["Chùa Khmer","Lễ hội Oóc Om Bóc","Bún nước lèo"]', N'["Khmer pagodas","Ok Om Bok festival","Bun nuoc leo"]', N'Chùa Khmer, Lễ hội Oóc Om Bóc, Bún nước lèo', N'Khmer pagodas, Ok Om Bok festival, Bun nuoc leo', N'0299', 61),
    ('bac-lieu', N'Bạc Liêu', N'Bac Lieu', N'Tỉnh', N'Province', 'DBSCL', N'Đồng bằng sông Cửu Long', N'Mekong Delta', 2669.00, 940000, N'2,669 km²', N'2,669 km²', N'940 nghìn người', N'940 thousand people', N'["Công tử Bạc Liêu","Điện gió","Đờn ca tài tử"]', N'["Bac Lieu prince","Wind farm","Don ca tai tu"]', N'Công tử Bạc Liêu, Điện gió, Đờn ca tài tử', N'Bac Lieu prince, Wind farm, Don ca tai tu', N'0291', 62),
    ('ca-mau', N'Cà Mau', N'Ca Mau', N'Tỉnh', N'Province', 'DBSCL', N'Đồng bằng sông Cửu Long', N'Mekong Delta', 5294.90, 1200000, N'5,294.9 km²', N'5,294.9 km²', N'1.2 triệu người', N'1.2 million people', N'["Đất mũi","Rừng ngập mặn","Hải sản"]', N'["Southern cape","Mangrove forests","Seafood"]', N'Đất mũi, Rừng ngập mặn, Hải sản', N'Southern cape, Mangrove forests, Seafood', N'0290', 63);

UPDATE tt
SET
    tt.TenVI = s.TenVI,
    tt.TenEN = s.TenEN,
    tt.LoaiTinhVI = s.LoaiTinhVI,
    tt.LoaiTinhEN = s.LoaiTinhEN,
    tt.VungID = vv.VungID,
    tt.TieuVungVI = s.TieuVungVI,
    tt.TieuVungEN = s.TieuVungEN,
    tt.DienTichKm2 = s.DienTichKm2,
    tt.DanSo = s.DanSo,
    tt.AreaDisplayVI = s.AreaDisplayVI,
    tt.AreaDisplayEN = s.AreaDisplayEN,
    tt.PopulationDisplayVI = s.PopulationDisplayVI,
    tt.PopulationDisplayEN = s.PopulationDisplayEN,
    tt.TagsJsonVI = s.TagsJsonVI,
    tt.TagsJsonEN = s.TagsJsonEN,
    tt.TagsTextVI = s.TagsTextVI,
    tt.TagsTextEN = s.TagsTextEN,
    tt.MaVungDienThoai = s.MaVungDienThoai,
    tt.ThuTuHienThi = s.ThuTuHienThi,
    tt.HoatDong = 1
FROM dbo.TinhThanh tt
JOIN @ProvinceSeed s ON s.MaTinh = tt.MaTinh
JOIN dbo.VungVanHoa vv ON vv.MaVung = s.MaVung;

UPDATE tt
SET
    tt.AnhDaiDienUrl = COALESCE(tt.AnhDaiDienUrl,
        CASE s.MaVung
            WHEN 'BAC_BO' THEN N'https://images.unsplash.com/photo-1605518215584-5ea1ebda40c0?auto=format&fit=crop&w=1200&q=80'
            WHEN 'TRUNG_BO' THEN N'https://images.unsplash.com/photo-1565967511849-76a60a516170?auto=format&fit=crop&w=1200&q=80'
            WHEN 'TAY_NGUYEN' THEN N'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=1200&q=80'
            WHEN 'NAM_BO' THEN N'https://images.unsplash.com/photo-1542362567-b07e54358753?auto=format&fit=crop&w=1200&q=80'
            WHEN 'DBSCL' THEN N'https://images.unsplash.com/photo-1604577844302-37f54c62bd16?auto=format&fit=crop&w=1200&q=80'
            ELSE N'https://images.unsplash.com/photo-1500530855697-b586d89ba3ee?auto=format&fit=crop&w=1200&q=80'
        END),
    tt.AnhDaiDienAltVI = COALESCE(tt.AnhDaiDienAltVI, N'Thắng cảnh tiêu biểu tại ' + s.TenVI),
    tt.AnhDaiDienAltEN = COALESCE(tt.AnhDaiDienAltEN, N'A representative landscape of ' + s.TenEN),
    tt.TieuDePhuVI = COALESCE(tt.TieuDePhuVI, N'Khám phá ' + s.TenVI + N' - ' + COALESCE(s.TieuVungVI, N'Việt Nam')),
    tt.TieuDePhuEN = COALESCE(tt.TieuDePhuEN, N'Explore ' + s.TenEN + N' - ' + COALESCE(s.TieuVungEN, N'Vietnam')),
    tt.TongQuanVI = COALESCE(tt.TongQuanVI, s.TenVI + N' là ' + LOWER(s.LoaiTinhVI) + N' thuộc ' + COALESCE(s.TieuVungVI, N'Việt Nam') + N'. Dữ liệu địa phương được chuẩn hóa để hỗ trợ khám phá văn hóa, du lịch và đời sống bản địa.'),
    tt.TongQuanEN = COALESCE(tt.TongQuanEN, s.TenEN + N' is a ' + LOWER(s.LoaiTinhEN) + N' in ' + COALESCE(s.TieuVungEN, N'Vietnam') + N'. The local dataset is standardized to support exploration of culture, travel, and daily life.'),
    tt.ThoiTietMacDinhVI = COALESCE(tt.ThoiTietMacDinhVI,
        CASE s.MaVung
            WHEN 'BAC_BO' THEN N'24°C - Ôn hòa'
            WHEN 'TRUNG_BO' THEN N'29°C - Nắng đẹp'
            WHEN 'TAY_NGUYEN' THEN N'21°C - Mát mẻ'
            WHEN 'NAM_BO' THEN N'30°C - Nắng ấm'
            WHEN 'DBSCL' THEN N'29°C - Gió sông'
            ELSE N'27°C - Thời tiết dễ chịu'
        END),
    tt.ThoiTietMacDinhEN = COALESCE(tt.ThoiTietMacDinhEN,
        CASE s.MaVung
            WHEN 'BAC_BO' THEN N'24°C - Mild'
            WHEN 'TRUNG_BO' THEN N'29°C - Sunny'
            WHEN 'TAY_NGUYEN' THEN N'21°C - Cool'
            WHEN 'NAM_BO' THEN N'30°C - Warm'
            WHEN 'DBSCL' THEN N'29°C - Riverside breeze'
            ELSE N'27°C - Pleasant weather'
        END),
    tt.ThoiDiemDepVI = COALESCE(tt.ThoiDiemDepVI,
        CASE s.MaVung
            WHEN 'BAC_BO' THEN N'Tháng 9 - Tháng 4'
            WHEN 'TRUNG_BO' THEN N'Tháng 1 - Tháng 8'
            WHEN 'TAY_NGUYEN' THEN N'Tháng 11 - Tháng 4'
            WHEN 'NAM_BO' THEN N'Tháng 12 - Tháng 4'
            WHEN 'DBSCL' THEN N'Tháng 12 - Tháng 4'
            ELSE N'Quanh năm'
        END),
    tt.ThoiDiemDepEN = COALESCE(tt.ThoiDiemDepEN,
        CASE s.MaVung
            WHEN 'BAC_BO' THEN N'September - April'
            WHEN 'TRUNG_BO' THEN N'January - August'
            WHEN 'TAY_NGUYEN' THEN N'November - April'
            WHEN 'NAM_BO' THEN N'December - April'
            WHEN 'DBSCL' THEN N'December - April'
            ELSE N'Year-round'
        END),
    tt.ThongTinThanhLapVI = COALESCE(tt.ThongTinThanhLapVI, N'Dữ liệu đang cập nhật'),
    tt.ThongTinThanhLapEN = COALESCE(tt.ThongTinThanhLapEN, N'Updating'),
    tt.ThongTinHanhChinhVI = COALESCE(tt.ThongTinHanhChinhVI, N'Dữ liệu hành chính đang được cập nhật'),
    tt.ThongTinHanhChinhEN = COALESCE(tt.ThongTinHanhChinhEN, N'Administrative details are being updated'),
    tt.MuiGio = COALESCE(tt.MuiGio, N'UTC+7'),
    tt.HeroImageUrl = COALESCE(tt.HeroImageUrl, tt.AnhDaiDienUrl),
    tt.HeroImageAltVI = COALESCE(tt.HeroImageAltVI, tt.AnhDaiDienAltVI),
    tt.HeroImageAltEN = COALESCE(tt.HeroImageAltEN, tt.AnhDaiDienAltEN),
    tt.SidebarImageUrl = COALESCE(tt.SidebarImageUrl, tt.AnhDaiDienUrl),
    tt.SidebarImageAltVI = COALESCE(tt.SidebarImageAltVI, tt.AnhDaiDienAltVI),
    tt.SidebarImageAltEN = COALESCE(tt.SidebarImageAltEN, tt.AnhDaiDienAltEN),
    tt.DiaDiemJsonVI = COALESCE(tt.DiaDiemJsonVI, N'[]'),
    tt.DiaDiemJsonEN = COALESCE(tt.DiaDiemJsonEN, N'[]'),
    tt.VanHoaJsonVI = COALESCE(tt.VanHoaJsonVI, N'[]'),
    tt.VanHoaJsonEN = COALESCE(tt.VanHoaJsonEN, N'[]'),
    tt.AmThucJsonVI = COALESCE(tt.AmThucJsonVI, N'[]'),
    tt.AmThucJsonEN = COALESCE(tt.AmThucJsonEN, N'[]'),
    tt.LichTrinhJsonVI = COALESCE(tt.LichTrinhJsonVI, N'[]'),
    tt.LichTrinhJsonEN = COALESCE(tt.LichTrinhJsonEN, N'[]')
FROM dbo.TinhThanh tt
JOIN @ProvinceSeed s ON s.MaTinh = tt.MaTinh;

INSERT INTO dbo.TinhThanh (
    MaTinh, TenVI, TenEN, LoaiTinhVI, LoaiTinhEN, VungID,
    TieuVungVI, TieuVungEN, DienTichKm2, DanSo,
    AreaDisplayVI, AreaDisplayEN, PopulationDisplayVI, PopulationDisplayEN,
    TagsJsonVI, TagsJsonEN, TagsTextVI, TagsTextEN,
    AnhDaiDienUrl, AnhDaiDienAltVI, AnhDaiDienAltEN,
    TieuDePhuVI, TieuDePhuEN, TongQuanVI, TongQuanEN,
    ThoiTietMacDinhVI, ThoiTietMacDinhEN, ThoiDiemDepVI, ThoiDiemDepEN,
    ThongTinThanhLapVI, ThongTinThanhLapEN, ThongTinHanhChinhVI, ThongTinHanhChinhEN,
    MuiGio, MaVungDienThoai,
    HeroImageUrl, HeroImageAltVI, HeroImageAltEN,
    SidebarImageUrl, SidebarImageAltVI, SidebarImageAltEN,
    DiaDiemJsonVI, DiaDiemJsonEN,
    VanHoaJsonVI, VanHoaJsonEN,
    AmThucJsonVI, AmThucJsonEN,
    LichTrinhJsonVI, LichTrinhJsonEN,
    HoatDong, ThuTuHienThi
)
SELECT
    s.MaTinh,
    s.TenVI,
    s.TenEN,
    s.LoaiTinhVI,
    s.LoaiTinhEN,
    vv.VungID,
    s.TieuVungVI,
    s.TieuVungEN,
    s.DienTichKm2,
    s.DanSo,
    s.AreaDisplayVI,
    s.AreaDisplayEN,
    s.PopulationDisplayVI,
    s.PopulationDisplayEN,
    s.TagsJsonVI,
    s.TagsJsonEN,
    s.TagsTextVI,
    s.TagsTextEN,
    CASE s.MaVung
        WHEN 'BAC_BO' THEN N'https://images.unsplash.com/photo-1605518215584-5ea1ebda40c0?auto=format&fit=crop&w=1200&q=80'
        WHEN 'TRUNG_BO' THEN N'https://images.unsplash.com/photo-1565967511849-76a60a516170?auto=format&fit=crop&w=1200&q=80'
        WHEN 'TAY_NGUYEN' THEN N'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=1200&q=80'
        WHEN 'NAM_BO' THEN N'https://images.unsplash.com/photo-1542362567-b07e54358753?auto=format&fit=crop&w=1200&q=80'
        WHEN 'DBSCL' THEN N'https://images.unsplash.com/photo-1604577844302-37f54c62bd16?auto=format&fit=crop&w=1200&q=80'
        ELSE N'https://images.unsplash.com/photo-1500530855697-b586d89ba3ee?auto=format&fit=crop&w=1200&q=80'
    END,
    N'Thắng cảnh tiêu biểu tại ' + s.TenVI,
    N'A representative landscape of ' + s.TenEN,
    N'Khám phá ' + s.TenVI + N' - ' + COALESCE(s.TieuVungVI, N'Việt Nam'),
    N'Explore ' + s.TenEN + N' - ' + COALESCE(s.TieuVungEN, N'Vietnam'),
    s.TenVI + N' là ' + LOWER(s.LoaiTinhVI) + N' thuộc ' + COALESCE(s.TieuVungVI, N'Việt Nam') + N'. Dữ liệu địa phương được chuẩn hóa để hỗ trợ khám phá văn hóa, du lịch và đời sống bản địa.',
    s.TenEN + N' is a ' + LOWER(s.LoaiTinhEN) + N' in ' + COALESCE(s.TieuVungEN, N'Vietnam') + N'. The local dataset is standardized to support exploration of culture, travel, and daily life.',
    CASE s.MaVung
        WHEN 'BAC_BO' THEN N'24°C - Ôn hòa'
        WHEN 'TRUNG_BO' THEN N'29°C - Nắng đẹp'
        WHEN 'TAY_NGUYEN' THEN N'21°C - Mát mẻ'
        WHEN 'NAM_BO' THEN N'30°C - Nắng ấm'
        WHEN 'DBSCL' THEN N'29°C - Gió sông'
        ELSE N'27°C - Thời tiết dễ chịu'
    END,
    CASE s.MaVung
        WHEN 'BAC_BO' THEN N'24°C - Mild'
        WHEN 'TRUNG_BO' THEN N'29°C - Sunny'
        WHEN 'TAY_NGUYEN' THEN N'21°C - Cool'
        WHEN 'NAM_BO' THEN N'30°C - Warm'
        WHEN 'DBSCL' THEN N'29°C - Riverside breeze'
        ELSE N'27°C - Pleasant weather'
    END,
    CASE s.MaVung
        WHEN 'BAC_BO' THEN N'Tháng 9 - Tháng 4'
        WHEN 'TRUNG_BO' THEN N'Tháng 1 - Tháng 8'
        WHEN 'TAY_NGUYEN' THEN N'Tháng 11 - Tháng 4'
        WHEN 'NAM_BO' THEN N'Tháng 12 - Tháng 4'
        WHEN 'DBSCL' THEN N'Tháng 12 - Tháng 4'
        ELSE N'Quanh năm'
    END,
    CASE s.MaVung
        WHEN 'BAC_BO' THEN N'September - April'
        WHEN 'TRUNG_BO' THEN N'January - August'
        WHEN 'TAY_NGUYEN' THEN N'November - April'
        WHEN 'NAM_BO' THEN N'December - April'
        WHEN 'DBSCL' THEN N'December - April'
        ELSE N'Year-round'
    END,
    N'Dữ liệu đang cập nhật',
    N'Updating',
    N'Dữ liệu hành chính đang được cập nhật',
    N'Administrative details are being updated',
    N'UTC+7',
    s.MaVungDienThoai,
    CASE s.MaVung
        WHEN 'BAC_BO' THEN N'https://images.unsplash.com/photo-1605518215584-5ea1ebda40c0?auto=format&fit=crop&w=1200&q=80'
        WHEN 'TRUNG_BO' THEN N'https://images.unsplash.com/photo-1565967511849-76a60a516170?auto=format&fit=crop&w=1200&q=80'
        WHEN 'TAY_NGUYEN' THEN N'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=1200&q=80'
        WHEN 'NAM_BO' THEN N'https://images.unsplash.com/photo-1542362567-b07e54358753?auto=format&fit=crop&w=1200&q=80'
        WHEN 'DBSCL' THEN N'https://images.unsplash.com/photo-1604577844302-37f54c62bd16?auto=format&fit=crop&w=1200&q=80'
        ELSE N'https://images.unsplash.com/photo-1500530855697-b586d89ba3ee?auto=format&fit=crop&w=1200&q=80'
    END,
    N'Thắng cảnh tiêu biểu tại ' + s.TenVI,
    N'A representative landscape of ' + s.TenEN,
    CASE s.MaVung
        WHEN 'BAC_BO' THEN N'https://images.unsplash.com/photo-1605518215584-5ea1ebda40c0?auto=format&fit=crop&w=1200&q=80'
        WHEN 'TRUNG_BO' THEN N'https://images.unsplash.com/photo-1565967511849-76a60a516170?auto=format&fit=crop&w=1200&q=80'
        WHEN 'TAY_NGUYEN' THEN N'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=1200&q=80'
        WHEN 'NAM_BO' THEN N'https://images.unsplash.com/photo-1542362567-b07e54358753?auto=format&fit=crop&w=1200&q=80'
        WHEN 'DBSCL' THEN N'https://images.unsplash.com/photo-1604577844302-37f54c62bd16?auto=format&fit=crop&w=1200&q=80'
        ELSE N'https://images.unsplash.com/photo-1500530855697-b586d89ba3ee?auto=format&fit=crop&w=1200&q=80'
    END,
    N'Thắng cảnh tiêu biểu tại ' + s.TenVI,
    N'A representative landscape of ' + s.TenEN,
    N'[]',
    N'[]',
    N'[]',
    N'[]',
    N'[]',
    N'[]',
    N'[]',
    N'[]',
    1,
    s.ThuTuHienThi
FROM @ProvinceSeed s
JOIN dbo.VungVanHoa vv ON vv.MaVung = s.MaVung
WHERE NOT EXISTS (
    SELECT 1 FROM dbo.TinhThanh tt WHERE tt.MaTinh = s.MaTinh
);

SELECT COUNT(*) AS ActiveProvinceCount
FROM dbo.TinhThanh
WHERE HoatDong = 1;
/* =========================================================
   FULL SEED - 34 TỈNH / THÀNH CẤP TỈNH VIỆT NAM
   - Chuẩn hóa dữ liệu tỉnh/thành cho API động
   - Chỉ giữ 34 tỉnh/thành mới ở trạng thái active
   ========================================================= */

SET NOCOUNT ON;

UPDATE dbo.TinhThanh
SET HoatDong = 0
WHERE MaTinh NOT IN (
  'ha-noi','hue','quang-ninh','cao-bang','lang-son','lai-chau','dien-bien','son-la','thanh-hoa','nghe-an','ha-tinh','tuyen-quang','lao-cai','thai-nguyen','phu-tho','bac-ninh','hung-yen','hai-phong','ninh-binh','quang-tri','da-nang','quang-ngai','gia-lai','khanh-hoa','lam-dong','dak-lak','ho-chi-minh-city','dong-nai','tay-ninh','can-tho','vinh-long','dong-thap','ca-mau','an-giang'
);

DELETE FROM dbo.TinhThanh
WHERE MaTinh IN ('da-lat', 'phu-quoc');

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
    ThuTuHienThi INT NOT NULL,
    GhiChuSapNhapVI NVARCHAR(500) NULL,
    GhiChuSapNhapEN NVARCHAR(500) NULL
);

INSERT INTO @ProvinceSeed (
    MaTinh, TenVI, TenEN, LoaiTinhVI, LoaiTinhEN, MaVung,
    TieuVungVI, TieuVungEN, DienTichKm2, DanSo,
    AreaDisplayVI, AreaDisplayEN, PopulationDisplayVI, PopulationDisplayEN,
    TagsJsonVI, TagsJsonEN, TagsTextVI, TagsTextEN,
    MaVungDienThoai, ThuTuHienThi, GhiChuSapNhapVI, GhiChuSapNhapEN
)
VALUES
    ('ha-noi', N'TP Hà Nội', N'Hanoi', N'Thành phố trực thuộc TW', N'Municipality', 'BAC_BO', N'Đồng bằng sông Hồng', N'Red River Delta', 3359.82, 8718000, N'3.359,82 km²', N'3,359.82 km²', N'8.718.000 người', N'8,718,000 people', N'["Thủ đô","Văn hiến","Hồ Gươm"]', N'["Capital","Heritage","Hoan Kiem Lake"]', N'Thủ đô, Văn hiến, Hồ Gươm', N'Capital, Heritage, Hoan Kiem Lake', N'024', 1, NULL, NULL),
    ('hue', N'TP Huế', N'Hue', N'Thành phố trực thuộc TW', N'Municipality', 'TRUNG_BO', N'Bắc Trung Bộ', N'North Central Coast', 4947.10, 1236393, N'4.947,1 km²', N'4,947.1 km²', N'1.236.393 người', N'1,236,393 people', N'["Cố đô","Sông Hương","Nhã nhạc"]', N'["Ancient capital","Perfume River","Royal court music"]', N'Cố đô, Sông Hương, Nhã nhạc', N'Ancient capital, Perfume River, Royal court music', N'0234', 2, NULL, NULL),
    ('quang-ninh', N'Quảng Ninh', N'Quang Ninh', N'Tỉnh', N'Province', 'BAC_BO', N'Đông Bắc', N'Northeast', 6207.90, 1429841, N'6.207,9 km²', N'6,207.9 km²', N'1.429.841 người', N'1,429,841 people', N'["Vịnh Hạ Long","Yên Tử","Biển đảo"]', N'["Ha Long Bay","Yen Tu","Sea and islands"]', N'Vịnh Hạ Long, Yên Tử, Biển đảo', N'Ha Long Bay, Yen Tu, Sea and islands', N'0203', 3, NULL, NULL),
    ('cao-bang', N'Cao Bằng', N'Cao Bang', N'Tỉnh', N'Province', 'BAC_BO', N'Đông Bắc', N'Northeast', 6700.40, 555809, N'6.700,4 km²', N'6,700.4 km²', N'555.809 người', N'555,809 people', N'["Thác Bản Giốc","Non nước","Biên giới"]', N'["Ban Gioc Waterfall","Karst landscapes","Border region"]', N'Thác Bản Giốc, Non nước, Biên giới', N'Ban Gioc Waterfall, Karst landscapes, Border region', N'0206', 4, NULL, NULL),
    ('lang-son', N'Lạng Sơn', N'Lang Son', N'Tỉnh', N'Province', 'BAC_BO', N'Đông Bắc', N'Northeast', 8310.20, 813978, N'8.310,2 km²', N'8,310.2 km²', N'813.978 người', N'813,978 people', N'["Cửa khẩu","Mẫu Sơn","Chợ biên giới"]', N'["Border gate","Mau Son","Border markets"]', N'Cửa khẩu, Mẫu Sơn, Chợ biên giới', N'Border gate, Mau Son, Border markets', N'0205', 5, NULL, NULL),
    ('lai-chau', N'Lai Châu', N'Lai Chau', N'Tỉnh', N'Province', 'BAC_BO', N'Tây Bắc', N'Northwest', 9068.70, 494626, N'9.068,7 km²', N'9,068.7 km²', N'494.626 người', N'494,626 people', N'["Đèo cao","Bản làng","Sông Đà"]', N'["High passes","Villages","Da River"]', N'Đèo cao, Bản làng, Sông Đà', N'High passes, Villages, Da River', N'0213', 6, NULL, NULL),
    ('dien-bien', N'Điện Biên', N'Dien Bien', N'Tỉnh', N'Province', 'BAC_BO', N'Tây Bắc', N'Northwest', 9539.90, 653422, N'9.539,9 km²', N'9,539.9 km²', N'653.422 người', N'653,422 people', N'["Điện Biên Phủ","Cánh đồng Mường Thanh","Biên giới"]', N'["Dien Bien Phu","Muong Thanh field","Border region"]', N'Điện Biên Phủ, Cánh đồng Mường Thanh, Biên giới', N'Dien Bien Phu, Muong Thanh field, Border region', N'0215', 7, NULL, NULL),
    ('son-la', N'Sơn La', N'Son La', N'Tỉnh', N'Province', 'BAC_BO', N'Tây Bắc', N'Northwest', 14109.80, 1327430, N'14.109,8 km²', N'14,109.8 km²', N'1.327.430 người', N'1,327,430 people', N'["Mộc Châu","Cao nguyên","Thủy điện"]', N'["Moc Chau","Plateau","Hydropower"]', N'Mộc Châu, Cao nguyên, Thủy điện', N'Moc Chau, Plateau, Hydropower', N'0212', 8, NULL, NULL),
    ('thanh-hoa', N'Thanh Hóa', N'Thanh Hoa', N'Tỉnh', N'Province', 'TRUNG_BO', N'Bắc Trung Bộ', N'North Central Coast', 11114.70, 3760650, N'11.114,7 km²', N'11,114.7 km²', N'3.760.650 người', N'3,760,650 people', N'["Thành Nhà Hồ","Biển Sầm Sơn","Lam Kinh"]', N'["Ho Citadel","Sam Son Beach","Lam Kinh"]', N'Thành Nhà Hồ, Biển Sầm Sơn, Lam Kinh', N'Ho Citadel, Sam Son Beach, Lam Kinh', N'0237', 9, NULL, NULL),
    ('nghe-an', N'Nghệ An', N'Nghe An', N'Tỉnh', N'Province', 'TRUNG_BO', N'Bắc Trung Bộ', N'North Central Coast', 16493.70, 3470988, N'16.493,7 km²', N'16,493.7 km²', N'3.470.988 người', N'3,470,988 people', N'["Quê Bác","Cửa Lò","Miền Tây Nghệ An"]', N'["Ho Chi Minh hometown","Cua Lo","Western Nghe An"]', N'Quê Bác, Cửa Lò, Miền Tây Nghệ An', N'Ho Chi Minh hometown, Cua Lo, Western Nghe An', N'0238', 10, NULL, NULL),
    ('ha-tinh', N'Hà Tĩnh', N'Ha Tinh', N'Tỉnh', N'Province', 'TRUNG_BO', N'Bắc Trung Bộ', N'North Central Coast', 5994.40, 1622901, N'5.994,4 km²', N'5,994.4 km²', N'1.622.901 người', N'1,622,901 people', N'["Ngã ba Đồng Lộc","Thiên Cầm","Ví giặm"]', N'["Dong Loc Junction","Thien Cam","Vi Giam singing"]', N'Ngã ba Đồng Lộc, Thiên Cầm, Ví giặm', N'Dong Loc Junction, Thien Cam, Vi Giam singing', N'0239', 11, NULL, NULL),
    ('tuyen-quang', N'Tuyên Quang', N'Tuyen Quang', N'Tỉnh', N'Province', 'BAC_BO', N'Trung du và miền núi Bắc Bộ', N'Northern Midlands and Mountains', 13795.50, 1865270, N'13.795,50 km²', N'13,795.50 km²', N'1.865.270 người', N'1,865,270 people', N'["ATK Tân Trào","Lễ hội Thành Tuyên","Sông Lô"]', N'["Tan Trao historic base","Thanh Tuyen festival","Lo River"]', N'ATK Tân Trào, Lễ hội Thành Tuyên, Sông Lô', N'Tan Trao historic base, Thanh Tuyen festival, Lo River', N'0207', 12, N'Sáp nhập Hà Giang và Tuyên Quang', N'Merged from Ha Giang and Tuyen Quang'),
    ('lao-cai', N'Lào Cai', N'Lao Cai', N'Tỉnh', N'Province', 'BAC_BO', N'Tây Bắc', N'Northwest', 13256.92, 1778785, N'13.256,92 km²', N'13,256.92 km²', N'1.778.785 người', N'1,778,785 people', N'["Sa Pa","Fansipan","Biên giới"]', N'["Sa Pa","Fansipan","Border region"]', N'Sa Pa, Fansipan, Biên giới', N'Sa Pa, Fansipan, Border region', N'0214', 13, N'Sáp nhập Lào Cai và Yên Bái', N'Merged from Lao Cai and Yen Bai'),
    ('thai-nguyen', N'Thái Nguyên', N'Thai Nguyen', N'Tỉnh', N'Province', 'BAC_BO', N'Trung du và miền núi Bắc Bộ', N'Northern Midlands and Mountains', 8375.21, 1799489, N'8.375,21 km²', N'8,375.21 km²', N'1.799.489 người', N'1,799,489 people', N'["Trà Tân Cương","ATK","Trung tâm giáo dục"]', N'["Tan Cuong tea","ATK base","Education hub"]', N'Trà Tân Cương, ATK, Trung tâm giáo dục', N'Tan Cuong tea, ATK base, Education hub', N'0208', 14, N'Sáp nhập Thái Nguyên và Bắc Kạn', N'Merged from Thai Nguyen and Bac Kan'),
    ('phu-tho', N'Phú Thọ', N'Phu Tho', N'Tỉnh', N'Province', 'BAC_BO', N'Trung du và miền núi Bắc Bộ', N'Northern Midlands and Mountains', 9361.38, 4022638, N'9.361,38 km²', N'9,361.38 km²', N'4.022.638 người', N'4,022,638 people', N'["Đền Hùng","Xoan","Ngã ba sông"]', N'["Hung Kings Temple","Xoan singing","River confluence"]', N'Đền Hùng, Xoan, Ngã ba sông', N'Hung Kings Temple, Xoan singing, River confluence', N'0210', 15, N'Sáp nhập Hòa Bình, Vĩnh Phúc, Phú Thọ', N'Merged from Hoa Binh, Vinh Phuc, Phu Tho'),
    ('bac-ninh', N'Bắc Ninh', N'Bac Ninh', N'Tỉnh', N'Province', 'BAC_BO', N'Đồng bằng sông Hồng', N'Red River Delta', 4718.60, 3619433, N'4.718,6 km²', N'4,718.6 km²', N'3.619.433 người', N'3,619,433 people', N'["Quan họ","Kinh Bắc","Làng nghề"]', N'["Quan ho folk songs","Kinh Bac","Craft villages"]', N'Quan họ, Kinh Bắc, Làng nghề', N'Quan ho folk songs, Kinh Bac, Craft villages', N'0222', 16, N'Sáp nhập Bắc Ninh và Bắc Giang', N'Merged from Bac Ninh and Bac Giang'),
    ('hung-yen', N'Hưng Yên', N'Hung Yen', N'Tỉnh', N'Province', 'BAC_BO', N'Đồng bằng sông Hồng', N'Red River Delta', 2514.81, 3567943, N'2.514,81 km²', N'2,514.81 km²', N'3.567.943 người', N'3,567,943 people', N'["Phố Hiến","Nhãn lồng","Đồng bằng"]', N'["Pho Hien","Longan","Delta plains"]', N'Phố Hiến, Nhãn lồng, Đồng bằng', N'Pho Hien, Longan, Delta plains', N'0221', 17, N'Sáp nhập Hưng Yên và Thái Bình', N'Merged from Hung Yen and Thai Binh'),
    ('hai-phong', N'TP Hải Phòng', N'Hai Phong', N'Thành phố trực thuộc TW', N'Municipality', 'BAC_BO', N'Duyên hải Bắc Bộ', N'Northern Coast', 3194.72, 4664124, N'3.194,72 km²', N'3,194.72 km²', N'4.664.124 người', N'4,664,124 people', N'["Cảng biển","Đồ Sơn","Cát Bà"]', N'["Seaport","Do Son","Cat Ba"]', N'Cảng biển, Đồ Sơn, Cát Bà', N'Seaport, Do Son, Cat Ba', N'0225', 18, N'Sáp nhập TP Hải Phòng và Hải Dương', N'Merged from Hai Phong and Hai Duong'),
    ('ninh-binh', N'Ninh Bình', N'Ninh Binh', N'Tỉnh', N'Province', 'BAC_BO', N'Đồng bằng sông Hồng', N'Red River Delta', 3942.62, 4412264, N'3.942,62 km²', N'3,942.62 km²', N'4.412.264 người', N'4,412,264 people', N'["Tràng An","Hoa Lư","Tam Cốc"]', N'["Trang An","Hoa Lu","Tam Coc"]', N'Tràng An, Hoa Lư, Tam Cốc', N'Trang An, Hoa Lu, Tam Coc', N'0229', 19, N'Sáp nhập Hà Nam, Nam Định và Ninh Bình', N'Merged from Ha Nam, Nam Dinh and Ninh Binh'),
    ('quang-tri', N'Quảng Trị', N'Quang Tri', N'Tỉnh', N'Province', 'TRUNG_BO', N'Bắc Trung Bộ', N'North Central Coast', 12700.00, 1870845, N'12.700 km²', N'12,700 km²', N'1.870.845 người', N'1,870,845 people', N'["Thành cổ","Cầu Hiền Lương","Biển Cửa Tùng"]', N'["Ancient citadel","Hien Luong Bridge","Cua Tung Beach"]', N'Thành cổ, Cầu Hiền Lương, Biển Cửa Tùng', N'Ancient citadel, Hien Luong Bridge, Cua Tung Beach', N'0233', 20, N'Sáp nhập Quảng Bình và Quảng Trị', N'Merged from Quang Binh and Quang Tri'),
    ('da-nang', N'TP Đà Nẵng', N'Da Nang', N'Thành phố trực thuộc TW', N'Municipality', 'TRUNG_BO', N'Nam Trung Bộ', N'South Central Coast', 11859.59, 3065628, N'11.859,59 km²', N'11,859.59 km²', N'3.065.628 người', N'3,065,628 people', N'["Biển Mỹ Khê","Cầu Rồng","Bà Nà Hills"]', N'["My Khe Beach","Dragon Bridge","Ba Na Hills"]', N'Biển Mỹ Khê, Cầu Rồng, Bà Nà Hills', N'My Khe Beach, Dragon Bridge, Ba Na Hills', N'0236', 21, N'Sáp nhập Quảng Nam và TP Đà Nẵng', N'Merged from Quang Nam and Da Nang'),
    ('quang-ngai', N'Quảng Ngãi', N'Quang Ngai', N'Tỉnh', N'Province', 'TRUNG_BO', N'Nam Trung Bộ', N'South Central Coast', 14832.55, 2161755, N'14.832,55 km²', N'14,832.55 km²', N'2.161.755 người', N'2,161,755 people', N'["Lý Sơn","Sa Huỳnh","Dung Quất"]', N'["Ly Son","Sa Huynh","Dung Quat"]', N'Lý Sơn, Sa Huỳnh, Dung Quất', N'Ly Son, Sa Huynh, Dung Quat', N'0255', 22, N'Sáp nhập Kon Tum và Quảng Ngãi', N'Merged from Kon Tum and Quang Ngai'),
    ('gia-lai', N'Gia Lai', N'Gia Lai', N'Tỉnh', N'Province', 'TRUNG_BO', N'Tây Nguyên - Duyên hải', N'Central Highlands - Coast', 21576.53, 3583693, N'21.576,53 km²', N'21,576.53 km²', N'3.583.693 người', N'3,583,693 people', N'["Biển Hồ","Cồng chiêng","Cao nguyên"]', N'["Bien Ho Lake","Gong culture","Plateau"]', N'Biển Hồ, Cồng chiêng, Cao nguyên', N'Bien Ho Lake, Gong culture, Plateau', N'0269', 23, N'Sáp nhập Gia Lai và Bình Định', N'Merged from Gia Lai and Binh Dinh'),
    ('khanh-hoa', N'Khánh Hòa', N'Khanh Hoa', N'Tỉnh', N'Province', 'TRUNG_BO', N'Nam Trung Bộ', N'South Central Coast', 8555.86, 2243554, N'8.555,86 km²', N'8,555.86 km²', N'2.243.554 người', N'2,243,554 people', N'["Nha Trang","Cam Ranh","Biển đảo"]', N'["Nha Trang","Cam Ranh","Sea and islands"]', N'Nha Trang, Cam Ranh, Biển đảo', N'Nha Trang, Cam Ranh, Sea and islands', N'0258', 24, N'Sáp nhập Ninh Thuận và Khánh Hòa', N'Merged from Ninh Thuan and Khanh Hoa'),
    ('lam-dong', N'Lâm Đồng', N'Lam Dong', N'Tỉnh', N'Province', 'TRUNG_BO', N'Tây Nguyên', N'Central Highlands', 24233.07, 3872999, N'24.233,07 km²', N'24,233.07 km²', N'3.872.999 người', N'3,872,999 people', N'["Đà Lạt","Cao nguyên","Hoa và trà"]', N'["Da Lat","Plateau","Flowers and tea"]', N'Đà Lạt, Cao nguyên, Hoa và trà', N'Da Lat, Plateau, Flowers and tea', N'0263', 25, N'Sáp nhập Đắk Nông, Bình Thuận và Lâm Đồng', N'Merged from Dak Nong, Binh Thuan and Lam Dong'),
    ('dak-lak', N'Đắk Lắk', N'Dak Lak', N'Tỉnh', N'Province', 'TRUNG_BO', N'Tây Nguyên', N'Central Highlands', 18096.40, 3346853, N'18.096,40 km²', N'18,096.40 km²', N'3.346.853 người', N'3,346,853 people', N'["Buôn Ma Thuột","Cà phê","Voi và sử thi"]', N'["Buon Ma Thuot","Coffee","Elephants and epics"]', N'Buôn Ma Thuột, Cà phê, Voi và sử thi', N'Buon Ma Thuot, Coffee, Elephants and epics', N'0262', 26, N'Sáp nhập Phú Yên và Đắk Lắk', N'Merged from Phu Yen and Dak Lak'),
    ('ho-chi-minh-city', N'TPHCM', N'Ho Chi Minh City', N'Thành phố trực thuộc TW', N'Municipality', 'NAM_BO', N'Đông Nam Bộ', N'Southeastern Vietnam', 6772.59, 14002598, N'6.772,59 km²', N'6,772.59 km²', N'14.002.598 người', N'14,002,598 people', N'["Đô thị lớn","Sài Gòn","Kinh tế năng động"]', N'["Metropolis","Sai Gon","Dynamic economy"]', N'Đô thị lớn, Sài Gòn, Kinh tế năng động', N'Metropolis, Sai Gon, Dynamic economy', N'028', 27, N'Sáp nhập Bà Rịa - Vũng Tàu, Bình Dương và TPHCM', N'Merged from Ba Ria - Vung Tau, Binh Duong and Ho Chi Minh City'),
    ('dong-nai', N'Đồng Nai', N'Dong Nai', N'Tỉnh', N'Province', 'NAM_BO', N'Đông Nam Bộ', N'Southeastern Vietnam', 12737.18, 4491408, N'12.737,18 km²', N'12,737.18 km²', N'4.491.408 người', N'4,491,408 people', N'["Biên Hòa","Công nghiệp","Rừng Nam Cát Tiên"]', N'["Bien Hoa","Industry","Nam Cat Tien forest"]', N'Biên Hòa, Công nghiệp, Rừng Nam Cát Tiên', N'Bien Hoa, Industry, Nam Cat Tien forest', N'0251', 28, N'Sáp nhập Bình Phước và Đồng Nai', N'Merged from Binh Phuoc and Dong Nai'),
    ('tay-ninh', N'Tây Ninh', N'Tay Ninh', N'Tỉnh', N'Province', 'NAM_BO', N'Đông Nam Bộ', N'Southeastern Vietnam', 8536.44, 3254170, N'8.536,44 km²', N'8,536.44 km²', N'3.254.170 người', N'3,254,170 people', N'["Núi Bà Đen","Tòa Thánh","Biên giới"]', N'["Ba Den Mountain","Cao Dai Holy See","Border region"]', N'Núi Bà Đen, Tòa Thánh, Biên giới', N'Ba Den Mountain, Cao Dai Holy See, Border region', N'0276', 29, N'Sáp nhập Tây Ninh và Long An', N'Merged from Tay Ninh and Long An'),
    ('can-tho', N'TP Cần Thơ', N'Can Tho', N'Thành phố trực thuộc TW', N'Municipality', 'NAM_BO', N'Đồng bằng sông Cửu Long', N'Mekong Delta', 6360.83, 4199824, N'6.360,83 km²', N'6,360.83 km²', N'4.199.824 người', N'4,199,824 people', N'["Chợ nổi","Sông nước","Ẩm thực"]', N'["Floating market","River life","Cuisine"]', N'Chợ nổi, Sông nước, Ẩm thực', N'Floating market, River life, Cuisine', N'0292', 30, N'Sáp nhập Sóc Trăng, Hậu Giang và TP Cần Thơ', N'Merged from Soc Trang, Hau Giang and Can Tho'),
    ('vinh-long', N'Vĩnh Long', N'Vinh Long', N'Tỉnh', N'Province', 'NAM_BO', N'Đồng bằng sông Cửu Long', N'Mekong Delta', 6296.20, 4257581, N'6.296,20 km²', N'6,296.20 km²', N'4.257.581 người', N'4,257,581 people', N'["Cù lao","Sông Tiền","Nhà cổ"]', N'["Islets","Tien River","Ancient houses"]', N'Cù lao, Sông Tiền, Nhà cổ', N'Islets, Tien River, Ancient houses', N'0270', 31, N'Sáp nhập Bến Tre, Vĩnh Long và Trà Vinh', N'Merged from Ben Tre, Vinh Long and Tra Vinh'),
    ('dong-thap', N'Đồng Tháp', N'Dong Thap', N'Tỉnh', N'Province', 'NAM_BO', N'Đồng bằng sông Cửu Long', N'Mekong Delta', 5938.64, 4370046, N'5.938,64 km²', N'5,938.64 km²', N'4.370.046 người', N'4,370,046 people', N'["Đồng sen","Sa Đéc","Tràm Chim"]', N'["Lotus fields","Sa Dec","Tram Chim"]', N'Đồng sen, Sa Đéc, Tràm Chim', N'Lotus fields, Sa Dec, Tram Chim', N'0277', 32, N'Sáp nhập Tiền Giang và Đồng Tháp', N'Merged from Tien Giang and Dong Thap'),
    ('ca-mau', N'Cà Mau', N'Ca Mau', N'Tỉnh', N'Province', 'NAM_BO', N'Đồng bằng sông Cửu Long', N'Mekong Delta', 7942.39, 2606672, N'7.942,39 km²', N'7,942.39 km²', N'2.606.672 người', N'2,606,672 people', N'["Đất mũi","Rừng ngập mặn","Hải sản"]', N'["Southern cape","Mangrove forests","Seafood"]', N'Đất mũi, Rừng ngập mặn, Hải sản', N'Southern cape, Mangrove forests, Seafood', N'0290', 33, N'Sáp nhập Bạc Liêu và Cà Mau', N'Merged from Bac Lieu and Ca Mau'),
    ('an-giang', N'An Giang', N'An Giang', N'Tỉnh', N'Province', 'NAM_BO', N'Đồng bằng sông Cửu Long', N'Mekong Delta', 9888.91, 4952238, N'9.888,91 km²', N'9,888.91 km²', N'4.952.238 người', N'4,952,238 people', N'["Châu Đốc","Thất Sơn","Văn hóa Chăm"]', N'["Chau Doc","Seven Mountains","Cham culture"]', N'Châu Đốc, Thất Sơn, Văn hóa Chăm', N'Chau Doc, Seven Mountains, Cham culture', N'0296', 34, N'Sáp nhập Kiên Giang và An Giang', N'Merged from Kien Giang and An Giang');

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
    tt.HoatDong = 1,
    tt.TieuDePhuVI = COALESCE(s.GhiChuSapNhapVI, N'Khám phá ' + s.TenVI + N' - ' + COALESCE(s.TieuVungVI, N'Việt Nam')),
    tt.TieuDePhuEN = COALESCE(s.GhiChuSapNhapEN, N'Explore ' + s.TenEN + N' - ' + COALESCE(s.TieuVungEN, N'Vietnam')),
    tt.TongQuanVI = COALESCE(s.GhiChuSapNhapVI + N'. ', N'') + s.TenVI + N' là ' + LOWER(s.LoaiTinhVI) + N' thuộc ' + COALESCE(s.TieuVungVI, N'Việt Nam') + N'. Dữ liệu địa phương được chuẩn hóa để hỗ trợ khám phá văn hóa, du lịch và đời sống bản địa.',
    tt.TongQuanEN = COALESCE(s.GhiChuSapNhapEN + N'. ', N'') + s.TenEN + N' is a ' + LOWER(s.LoaiTinhEN) + N' in ' + COALESCE(s.TieuVungEN, N'Vietnam') + N'. The local dataset is standardized to support exploration of culture, travel, and daily life.',
    tt.NgayCapNhat = SYSUTCDATETIME()
FROM dbo.TinhThanh tt
JOIN @ProvinceSeed s ON s.MaTinh = tt.MaTinh
JOIN dbo.VungVanHoa vv ON vv.MaVung = s.MaVung;

UPDATE tt
SET
    tt.AnhDaiDienUrl = COALESCE(tt.AnhDaiDienUrl,
        CASE s.MaVung
            WHEN 'BAC_BO' THEN N'https://images.unsplash.com/photo-1605518215584-5ea1ebda40c0?auto=format&fit=crop&w=1200&q=80'
            WHEN 'TRUNG_BO' THEN N'https://images.unsplash.com/photo-1565967511849-76a60a516170?auto=format&fit=crop&w=1200&q=80'
            WHEN 'NAM_BO' THEN N'https://images.unsplash.com/photo-1604577844302-37f54c62bd16?auto=format&fit=crop&w=1200&q=80'
            ELSE N'https://images.unsplash.com/photo-1500530855697-b586d89ba3ee?auto=format&fit=crop&w=1200&q=80'
        END),
    tt.AnhDaiDienAltVI = COALESCE(tt.AnhDaiDienAltVI, N'Thắng cảnh tiêu biểu tại ' + s.TenVI),
    tt.AnhDaiDienAltEN = COALESCE(tt.AnhDaiDienAltEN, N'A representative landscape of ' + s.TenEN),
    tt.ThoiTietMacDinhVI = COALESCE(tt.ThoiTietMacDinhVI,
        CASE s.MaVung
            WHEN 'BAC_BO' THEN N'24°C - Ôn hòa'
            WHEN 'TRUNG_BO' THEN N'29°C - Nắng đẹp'
            WHEN 'NAM_BO' THEN N'30°C - Nắng ấm'
            ELSE N'27°C - Thời tiết dễ chịu'
        END),
    tt.ThoiTietMacDinhEN = COALESCE(tt.ThoiTietMacDinhEN,
        CASE s.MaVung
            WHEN 'BAC_BO' THEN N'24°C - Mild'
            WHEN 'TRUNG_BO' THEN N'29°C - Sunny'
            WHEN 'NAM_BO' THEN N'30°C - Warm'
            ELSE N'27°C - Pleasant weather'
        END),
    tt.ThoiDiemDepVI = COALESCE(tt.ThoiDiemDepVI,
        CASE s.MaVung
            WHEN 'BAC_BO' THEN N'Tháng 9 - Tháng 4'
            WHEN 'TRUNG_BO' THEN N'Tháng 1 - Tháng 8'
            WHEN 'NAM_BO' THEN N'Tháng 12 - Tháng 4'
            ELSE N'Quanh năm'
        END),
    tt.ThoiDiemDepEN = COALESCE(tt.ThoiDiemDepEN,
        CASE s.MaVung
            WHEN 'BAC_BO' THEN N'September - April'
            WHEN 'TRUNG_BO' THEN N'January - August'
            WHEN 'NAM_BO' THEN N'December - April'
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
        WHEN 'NAM_BO' THEN N'https://images.unsplash.com/photo-1604577844302-37f54c62bd16?auto=format&fit=crop&w=1200&q=80'
        ELSE N'https://images.unsplash.com/photo-1500530855697-b586d89ba3ee?auto=format&fit=crop&w=1200&q=80'
    END,
    N'Thắng cảnh tiêu biểu tại ' + s.TenVI,
    N'A representative landscape of ' + s.TenEN,
    COALESCE(s.GhiChuSapNhapVI, N'Khám phá ' + s.TenVI + N' - ' + COALESCE(s.TieuVungVI, N'Việt Nam')),
    COALESCE(s.GhiChuSapNhapEN, N'Explore ' + s.TenEN + N' - ' + COALESCE(s.TieuVungEN, N'Vietnam')),
    COALESCE(s.GhiChuSapNhapVI + N'. ', N'') + s.TenVI + N' là ' + LOWER(s.LoaiTinhVI) + N' thuộc ' + COALESCE(s.TieuVungVI, N'Việt Nam') + N'. Dữ liệu địa phương được chuẩn hóa để hỗ trợ khám phá văn hóa, du lịch và đời sống bản địa.',
    COALESCE(s.GhiChuSapNhapEN + N'. ', N'') + s.TenEN + N' is a ' + LOWER(s.LoaiTinhEN) + N' in ' + COALESCE(s.TieuVungEN, N'Vietnam') + N'. The local dataset is standardized to support exploration of culture, travel, and daily life.',
    CASE s.MaVung WHEN 'BAC_BO' THEN N'24°C - Ôn hòa' WHEN 'TRUNG_BO' THEN N'29°C - Nắng đẹp' WHEN 'NAM_BO' THEN N'30°C - Nắng ấm' ELSE N'27°C - Thời tiết dễ chịu' END,
    CASE s.MaVung WHEN 'BAC_BO' THEN N'24°C - Mild' WHEN 'TRUNG_BO' THEN N'29°C - Sunny' WHEN 'NAM_BO' THEN N'30°C - Warm' ELSE N'27°C - Pleasant weather' END,
    CASE s.MaVung WHEN 'BAC_BO' THEN N'Tháng 9 - Tháng 4' WHEN 'TRUNG_BO' THEN N'Tháng 1 - Tháng 8' WHEN 'NAM_BO' THEN N'Tháng 12 - Tháng 4' ELSE N'Quanh năm' END,
    CASE s.MaVung WHEN 'BAC_BO' THEN N'September - April' WHEN 'TRUNG_BO' THEN N'January - August' WHEN 'NAM_BO' THEN N'December - April' ELSE N'Year-round' END,
    N'Dữ liệu đang cập nhật',
    N'Updating',
    N'Dữ liệu hành chính đang được cập nhật',
    N'Administrative details are being updated',
    N'UTC+7',
    s.MaVungDienThoai,
    CASE s.MaVung
        WHEN 'BAC_BO' THEN N'https://images.unsplash.com/photo-1605518215584-5ea1ebda40c0?auto=format&fit=crop&w=1200&q=80'
        WHEN 'TRUNG_BO' THEN N'https://images.unsplash.com/photo-1565967511849-76a60a516170?auto=format&fit=crop&w=1200&q=80'
        WHEN 'NAM_BO' THEN N'https://images.unsplash.com/photo-1604577844302-37f54c62bd16?auto=format&fit=crop&w=1200&q=80'
        ELSE N'https://images.unsplash.com/photo-1500530855697-b586d89ba3ee?auto=format&fit=crop&w=1200&q=80'
    END,
    N'Thắng cảnh tiêu biểu tại ' + s.TenVI,
    N'A representative landscape of ' + s.TenEN,
    CASE s.MaVung
        WHEN 'BAC_BO' THEN N'https://images.unsplash.com/photo-1605518215584-5ea1ebda40c0?auto=format&fit=crop&w=1200&q=80'
        WHEN 'TRUNG_BO' THEN N'https://images.unsplash.com/photo-1565967511849-76a60a516170?auto=format&fit=crop&w=1200&q=80'
        WHEN 'NAM_BO' THEN N'https://images.unsplash.com/photo-1604577844302-37f54c62bd16?auto=format&fit=crop&w=1200&q=80'
        ELSE N'https://images.unsplash.com/photo-1500530855697-b586d89ba3ee?auto=format&fit=crop&w=1200&q=80'
    END,
    N'Thắng cảnh tiêu biểu tại ' + s.TenVI,
    N'A representative landscape of ' + s.TenEN,
    N'[]', N'[]', N'[]', N'[]', N'[]', N'[]', N'[]', N'[]',
    1,
    s.ThuTuHienThi
FROM @ProvinceSeed s
JOIN dbo.VungVanHoa vv ON vv.MaVung = s.MaVung
WHERE NOT EXISTS (
    SELECT 1 FROM dbo.TinhThanh tt WHERE tt.MaTinh = s.MaTinh
);

UPDATE dbo.TinhThanh
SET TieuDePhuVI = CASE MaTinh
    WHEN 'ha-noi' THEN N'Thủ đô nghìn năm văn hiến với hồ Gươm, phố cổ và nhịp sống văn hóa đặc sắc'
    WHEN 'hue' THEN N'Cố đô trầm mặc nổi bật với di sản cung đình, sông Hương và nhã nhạc'
    WHEN 'quang-ninh' THEN N'Tâm điểm di sản biển đảo với vịnh Hạ Long và hành trình khám phá kỳ quan'
    WHEN 'cao-bang' THEN N'Vùng non nước biên cương nổi bật với thác Bản Giốc và cảnh quan karst'
    WHEN 'lang-son' THEN N'Cửa ngõ Đông Bắc với chợ biên giới, Mẫu Sơn và sắc màu xứ Lạng'
    WHEN 'lai-chau' THEN N'Miền đất Tây Bắc của đèo cao, bản làng và những cung đường hùng vĩ'
    WHEN 'dien-bien' THEN N'Vùng đất lịch sử gắn với Điện Biên Phủ và cánh đồng Mường Thanh'
    WHEN 'son-la' THEN N'Cao nguyên rộng lớn với Mộc Châu, lòng hồ và bản sắc Tây Bắc'
    WHEN 'thanh-hoa' THEN N'Xứ Thanh giàu chiều sâu lịch sử với Thành Nhà Hồ và biển Sầm Sơn'
    WHEN 'nghe-an' THEN N'Quê hương Chủ tịch Hồ Chí Minh với biển Cửa Lò và miền Tây xứ Nghệ'
    WHEN 'ha-tinh' THEN N'Vùng đất đậm chất Bắc Trung Bộ với ví giặm, Thiên Cầm và ký ức lịch sử'
    WHEN 'tuyen-quang' THEN N'Tỉnh mới sau sáp nhập, nổi bật với Tân Trào, sông Lô và lễ hội Thành Tuyên'
    WHEN 'lao-cai' THEN N'Tỉnh mới sau sáp nhập, kết nối Sa Pa, Fansipan và sắc màu vùng cao Tây Bắc'
    WHEN 'thai-nguyen' THEN N'Tỉnh mới sau sáp nhập, nổi tiếng với trà Tân Cương và không gian trung du'
    WHEN 'phu-tho' THEN N'Tỉnh mới sau sáp nhập, nơi hội tụ cội nguồn Đền Hùng và văn hóa trung du'
    WHEN 'bac-ninh' THEN N'Tỉnh mới sau sáp nhập, giàu truyền thống Kinh Bắc, quan họ và làng nghề'
    WHEN 'hung-yen' THEN N'Tỉnh mới sau sáp nhập, mang đậm dấu ấn Phố Hiến và văn hóa đồng bằng'
    WHEN 'hai-phong' THEN N'Thành phố cảng mới sau sáp nhập, kết nối biển đảo, công nghiệp và đô thị ven biển'
    WHEN 'ninh-binh' THEN N'Tỉnh mới sau sáp nhập, nổi bật với Tràng An, Hoa Lư và cảnh quan đá vôi'
    WHEN 'quang-tri' THEN N'Tỉnh mới sau sáp nhập, lưu giữ ký ức lịch sử và dải đất gió Lào cát trắng'
    WHEN 'da-nang' THEN N'Thành phố mới sau sáp nhập, giao thoa giữa biển, đô thị hiện đại và di sản miền Trung'
    WHEN 'quang-ngai' THEN N'Tỉnh mới sau sáp nhập, kết nối Lý Sơn, Sa Huỳnh và không gian miền Trung mở rộng'
    WHEN 'gia-lai' THEN N'Tỉnh mới sau sáp nhập, nối cao nguyên cồng chiêng với không gian duyên hải'
    WHEN 'khanh-hoa' THEN N'Tỉnh mới sau sáp nhập, quy tụ Nha Trang, Cam Ranh và biển trời Nam Trung Bộ'
    WHEN 'lam-dong' THEN N'Tỉnh mới sau sáp nhập, mở rộng từ Đà Lạt đến cao nguyên, biển và vùng bán khô hạn'
    WHEN 'dak-lak' THEN N'Tỉnh mới sau sáp nhập, kết nối Buôn Ma Thuột với cao nguyên và duyên hải miền Trung'
    WHEN 'ho-chi-minh-city' THEN N'Siêu đô thị mới sau sáp nhập, trung tâm kinh tế năng động bậc nhất cả nước'
    WHEN 'dong-nai' THEN N'Tỉnh mới sau sáp nhập, phát triển mạnh về công nghiệp, đô thị và sinh thái rừng'
    WHEN 'tay-ninh' THEN N'Tỉnh mới sau sáp nhập, nổi bật với Núi Bà Đen và không gian cửa ngõ Đông Nam Bộ'
    WHEN 'can-tho' THEN N'Thành phố trung tâm mới của miền Tây với chợ nổi, sông nước và nhịp sống đô thị'
    WHEN 'vinh-long' THEN N'Tỉnh mới sau sáp nhập, đậm chất miệt vườn, cù lao và văn hóa sông Tiền'
    WHEN 'dong-thap' THEN N'Tỉnh mới sau sáp nhập, nổi bật với đồng sen, Sa Đéc và hệ sinh thái ngập nước'
    WHEN 'ca-mau' THEN N'Tỉnh mới sau sáp nhập, nơi tận cùng Tổ quốc với rừng ngập mặn và biển trời phương Nam'
    WHEN 'an-giang' THEN N'Tỉnh mới sau sáp nhập, hội tụ Châu Đốc, Thất Sơn và văn hóa biên giới đặc sắc'
    ELSE TieuDePhuVI
END,
TieuDePhuEN = CASE MaTinh
    WHEN 'ha-noi' THEN N'The thousand-year capital with Hoan Kiem Lake, the Old Quarter, and vibrant culture'
    WHEN 'hue' THEN N'The former imperial capital known for royal heritage, the Perfume River, and court music'
    WHEN 'quang-ninh' THEN N'A coastal heritage province centered around Ha Long Bay and island journeys'
    WHEN 'cao-bang' THEN N'A northern borderland known for Ban Gioc Waterfall and dramatic karst scenery'
    WHEN 'lang-son' THEN N'The northeastern gateway of border markets, Mau Son, and mountain culture'
    WHEN 'lai-chau' THEN N'A rugged northwest land of high passes, villages, and epic landscapes'
    WHEN 'dien-bien' THEN N'A historic province tied to Dien Bien Phu and the Muong Thanh valley'
    WHEN 'son-la' THEN N'A broad highland province featuring Moc Chau and strong northwest identity'
    WHEN 'thanh-hoa' THEN N'A historic north-central province with the Ho Citadel and Sam Son coast'
    WHEN 'nghe-an' THEN N'The homeland of Ho Chi Minh, rich in coastal life and western uplands'
    WHEN 'ha-tinh' THEN N'A north-central province of Vi Giam folk songs, Thien Cam beach, and living history'
    WHEN 'tuyen-quang' THEN N'A newly merged province shaped by Tan Trao, the Lo River, and festival culture'
    WHEN 'lao-cai' THEN N'A newly merged province connecting Sa Pa, Fansipan, and northwest highland color'
    WHEN 'thai-nguyen' THEN N'A newly merged province known for tea culture and the northern midlands'
    WHEN 'phu-tho' THEN N'A newly merged province where Hung Kings heritage meets the midland landscape'
    WHEN 'bac-ninh' THEN N'A newly merged province rich in Quan Ho, Kinh Bac heritage, and craft villages'
    WHEN 'hung-yen' THEN N'A newly merged province carrying Pho Hien heritage and delta traditions'
    WHEN 'hai-phong' THEN N'A newly merged port city connecting islands, industry, and coastal urban life'
    WHEN 'ninh-binh' THEN N'A newly merged province highlighted by Trang An, Hoa Lu, and limestone scenery'
    WHEN 'quang-tri' THEN N'A newly merged province preserving wartime memory and central Vietnamese spirit'
    WHEN 'da-nang' THEN N'A newly merged city where beaches, modern energy, and heritage intersect'
    WHEN 'quang-ngai' THEN N'A newly merged province linking Ly Son, Sa Huynh, and a broader central coast'
    WHEN 'gia-lai' THEN N'A newly merged province connecting gong culture highlands with the coastal corridor'
    WHEN 'khanh-hoa' THEN N'A newly merged province centered on Nha Trang, Cam Ranh, and south-central seas'
    WHEN 'lam-dong' THEN N'A newly merged province stretching from Da Lat to highlands, coast, and drylands'
    WHEN 'dak-lak' THEN N'A newly merged province connecting Buon Ma Thuot with highland and coastal culture'
    WHEN 'ho-chi-minh-city' THEN N'A newly merged megacity and the country''s most dynamic economic hub'
    WHEN 'dong-nai' THEN N'A newly merged province strong in industry, urban growth, and forest ecology'
    WHEN 'tay-ninh' THEN N'A newly merged province marked by Ba Den Mountain and the southeastern gateway'
    WHEN 'can-tho' THEN N'The new urban heart of the Mekong Delta with floating markets and river life'
    WHEN 'vinh-long' THEN N'A newly merged province rich in orchards, islets, and Tien River culture'
    WHEN 'dong-thap' THEN N'A newly merged province of lotus fields, Sa Dec, and wetland ecosystems'
    WHEN 'ca-mau' THEN N'A newly merged southernmost province of mangroves, coastline, and frontier spirit'
    WHEN 'an-giang' THEN N'A newly merged province of Chau Doc, the Seven Mountains, and borderland culture'
    ELSE TieuDePhuEN
END,
NgayCapNhat = SYSUTCDATETIME()
WHERE HoatDong = 1;

SELECT COUNT(*) AS ActiveProvinceCount
FROM dbo.TinhThanh
WHERE HoatDong = 1;

/* =========================================================
   DỮ LIỆU MẪU CHI TIẾT - VNCultureBridgeAI
   Chỉ gồm dữ liệu mẫu, không tạo lại bảng
   Script có dùng NOT EXISTS để tránh chèn trùng
   ========================================================= */

SET NOCOUNT ON;

/* =========================================================
   1. NGƯỜI DÙNG QUẢN TRỊ
   ========================================================= */
INSERT INTO dbo.NguoiDung (HoTen, Email, MatKhauHash, VaiTro, TrangThai)
SELECT N'Quản trị viên Nguyễn Văn A', 'admin.vnculturebridge@gmail.com', '$2b$10$LMgvDe.HngByMtMZmcwjjO1FF6EU0lx0IHFkhQ1iy//LTOFV4Nwza', 'ADMIN', 'ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM dbo.NguoiDung WHERE Email = 'admin.vnculturebridge@gmail.com');

INSERT INTO dbo.KhachHang (HoTen, Email, MatKhauHash, TrangThai)
SELECT N'Nguyễn Thị Lan', 'khachhang.vnculturebridge@gmail.com', '$2b$10$fy2F2cDPNwhEQi3wli86tulJG2MtJvV/Z.W3ZUbsNJ2hu.XV/VT2i', 'ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM dbo.KhachHang WHERE Email = 'khachhang.vnculturebridge@gmail.com');

INSERT INTO dbo.NguoiDung (HoTen, Email, MatKhauHash, VaiTro, TrangThai)
SELECT N'Trần Minh Anh', 'content.vnculturebridge@gmail.com', 'HASH_CONTENT_123', 'CONTENT_MANAGER', 'ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM dbo.NguoiDung WHERE Email = 'content.vnculturebridge@gmail.com');

INSERT INTO dbo.NguoiDung (HoTen, Email, MatKhauHash, VaiTro, TrangThai)
SELECT N'Lê Hoàng Nam', 'reviewer.vnculturebridge@gmail.com', 'HASH_REVIEWER_123', 'REVIEWER', 'ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM dbo.NguoiDung WHERE Email = 'reviewer.vnculturebridge@gmail.com');

INSERT INTO dbo.NguoiDung (HoTen, Email, MatKhauHash, VaiTro, TrangThai)
SELECT N'Phạm Thu Hà', 'ai.vnculturebridge@gmail.com', 'HASH_AI_123', 'AI_MANAGER', 'ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM dbo.NguoiDung WHERE Email = 'ai.vnculturebridge@gmail.com');


/* =========================================================
   2. DANH MỤC TRI THỨC
   ========================================================= */
INSERT INTO dbo.DanhMuc (MaDanhMuc, TenVI, TenEN, MoTaVI, MoTaEN, HoatDong)
SELECT 'LE_HOI', N'Lễ hội', N'Festivals',
       N'Nhóm nội dung về các lễ hội truyền thống, nghi thức cộng đồng và sinh hoạt lễ hội.',
       N'Content group about traditional festivals, community rituals and ceremonial activities.',
       1
WHERE NOT EXISTS (SELECT 1 FROM dbo.DanhMuc WHERE MaDanhMuc = 'LE_HOI');

INSERT INTO dbo.DanhMuc (MaDanhMuc, TenVI, TenEN, MoTaVI, MoTaEN, HoatDong)
SELECT 'TIN_NGUONG', N'Tín ngưỡng', N'Beliefs',
       N'Nhóm nội dung về tín ngưỡng dân gian, thờ cúng, quan niệm tâm linh trong đời sống Việt.',
       N'Content about folk beliefs, worship practices and spiritual perspectives in Vietnamese life.',
       1
WHERE NOT EXISTS (SELECT 1 FROM dbo.DanhMuc WHERE MaDanhMuc = 'TIN_NGUONG');

INSERT INTO dbo.DanhMuc (MaDanhMuc, TenVI, TenEN, MoTaVI, MoTaEN, HoatDong)
SELECT 'AM_THUC', N'Ẩm thực', N'Cuisine',
       N'Nhóm nội dung về món ăn, tập quán ẩm thực và giá trị văn hóa gắn với ẩm thực.',
       N'Content about dishes, culinary habits and the cultural value of food.',
       1
WHERE NOT EXISTS (SELECT 1 FROM dbo.DanhMuc WHERE MaDanhMuc = 'AM_THUC');

INSERT INTO dbo.DanhMuc (MaDanhMuc, TenVI, TenEN, MoTaVI, MoTaEN, HoatDong)
SELECT 'TRANG_PHUC', N'Trang phục', N'Costumes',
       N'Nhóm nội dung về trang phục truyền thống, biểu tượng trang phục và ý nghĩa sử dụng.',
       N'Content about traditional costumes, symbolic dress and their cultural meanings.',
       1
WHERE NOT EXISTS (SELECT 1 FROM dbo.DanhMuc WHERE MaDanhMuc = 'TRANG_PHUC');

INSERT INTO dbo.DanhMuc (MaDanhMuc, TenVI, TenEN, MoTaVI, MoTaEN, HoatDong)
SELECT 'NGHE_THUAT_DAN_GIAN', N'Nghệ thuật dân gian', N'Folk Arts',
       N'Nhóm nội dung về âm nhạc, trình diễn, biểu tượng và di sản nghệ thuật dân gian.',
       N'Content about music, performance, symbols and folk art heritage.',
       1
WHERE NOT EXISTS (SELECT 1 FROM dbo.DanhMuc WHERE MaDanhMuc = 'NGHE_THUAT_DAN_GIAN');

/* =========================================================
   3. VÙNG VĂN HÓA
   ========================================================= */
INSERT INTO dbo.VungVanHoa (MaVung, TenVI, TenEN, LoaiVung, GeoJson, HoatDong)
SELECT 'BAC_BO', N'Bắc Bộ', N'Northern Vietnam', 'NORTH', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM dbo.VungVanHoa WHERE MaVung = 'BAC_BO');

INSERT INTO dbo.VungVanHoa (MaVung, TenVI, TenEN, LoaiVung, GeoJson, HoatDong)
SELECT 'TRUNG_BO', N'Trung Bộ', N'Central Vietnam', 'CENTRAL', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM dbo.VungVanHoa WHERE MaVung = 'TRUNG_BO');

INSERT INTO dbo.VungVanHoa (MaVung, TenVI, TenEN, LoaiVung, GeoJson, HoatDong)
SELECT 'NAM_BO', N'Nam Bộ', N'Southern Vietnam', 'SOUTH', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM dbo.VungVanHoa WHERE MaVung = 'NAM_BO');

INSERT INTO dbo.VungVanHoa (MaVung, TenVI, TenEN, LoaiVung, GeoJson, HoatDong)
SELECT 'TAY_NGUYEN', N'Tây Nguyên', N'Central Highlands', 'HIGHLAND', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM dbo.VungVanHoa WHERE MaVung = 'TAY_NGUYEN');

INSERT INTO dbo.VungVanHoa (MaVung, TenVI, TenEN, LoaiVung, GeoJson, HoatDong)
SELECT 'DBSCL', N'Đồng bằng sông Cửu Long', N'Mekong Delta', 'DELTA', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM dbo.VungVanHoa WHERE MaVung = 'DBSCL');

UPDATE dbo.VungVanHoa
SET HomepageEnabled = 1,
    HomepageDisplayOrder = 1,
    HomepageBadgeVI = N'Miền Bắc',
    HomepageTitleVI = N'Miền Bắc',
    HomepageDescriptionVI = N'Khám phá Hà Nội, Hạ Long và những ruộng bậc thang hùng vĩ của vùng núi phía Bắc.',
    HomepageHighlightsVI = N'["Hà Nội","Hạ Long","Sa Pa","Hà Giang"]',
    HomepageCtaVI = N'Khám phá Miền Bắc',
    HomepageImageUrl = N'https://images.unsplash.com/photo-1605518215584-5ea1ebda40c0?auto=format&fit=crop&w=1200&q=80',
    HomepageImageAltVI = N'Cảnh sắc ruộng bậc thang miền Bắc Việt Nam'
WHERE MaVung = 'BAC_BO';

UPDATE dbo.VungVanHoa
SET HomepageEnabled = 1,
    HomepageDisplayOrder = 2,
    HomepageBadgeVI = N'Miền Trung',
    HomepageTitleVI = N'Miền Trung',
    HomepageDescriptionVI = N'Từ Huế, Hội An đến Đà Nẵng, miền Trung mang vẻ đẹp giao hòa giữa lịch sử và thiên nhiên.',
    HomepageHighlightsVI = N'["Huế","Hội An","Đà Nẵng","Mỹ Sơn"]',
    HomepageCtaVI = N'Khám phá Miền Trung',
    HomepageImageUrl = N'https://images.unsplash.com/photo-1565967511849-76a60a516170?auto=format&fit=crop&w=1200&q=80',
    HomepageImageAltVI = N'Đèn lồng phố cổ Hội An về đêm'
WHERE MaVung = 'TRUNG_BO';

UPDATE dbo.VungVanHoa
SET HomepageEnabled = 1,
    HomepageDisplayOrder = 3,
    HomepageBadgeVI = N'Miền Nam',
    HomepageTitleVI = N'Miền Nam',
    HomepageDescriptionVI = N'Miền Nam nổi bật với TP.HCM, miền Tây sông nước và hành trình ẩm thực, chợ nổi, biển đảo.',
    HomepageHighlightsVI = N'["TP.HCM","Cần Thơ","Mekong","Phú Quốc"]',
    HomepageCtaVI = N'Khám phá Miền Nam',
    HomepageImageUrl = N'https://images.unsplash.com/photo-1604577844302-37f54c62bd16?auto=format&fit=crop&w=1200&q=80',
    HomepageImageAltVI = N'Khung cảnh sông nước miền Nam Việt Nam'
WHERE MaVung = 'NAM_BO';

UPDATE dbo.VungVanHoa
SET HomepageEnabled = 0,
    HomepageDisplayOrder = NULL,
    HomepageBadgeVI = NULL,
    HomepageTitleVI = NULL,
    HomepageDescriptionVI = NULL,
    HomepageHighlightsVI = NULL,
    HomepageCtaVI = NULL,
    HomepageImageUrl = NULL,
    HomepageImageAltVI = NULL
WHERE MaVung IN ('TAY_NGUYEN', 'DBSCL');

/* =========================================================
   4. DÂN TỘC
   ========================================================= */
INSERT INTO dbo.DanToc (MaDanToc, TenVI, TenEN, MoTaVI, MoTaEN, HoatDong)
SELECT 'KINH', N'Kinh', N'Kinh',
       N'Dân tộc chiếm đa số ở Việt Nam, có ảnh hưởng rộng trong đời sống văn hóa quốc gia.',
       N'The majority ethnic group in Vietnam, with wide influence on the country''s cultural life.',
       1
WHERE NOT EXISTS (SELECT 1 FROM dbo.DanToc WHERE MaDanToc = 'KINH');

INSERT INTO dbo.DanToc (MaDanToc, TenVI, TenEN, MoTaVI, MoTaEN, HoatDong)
SELECT 'TAY', N'Tày', N'Tay',
       N'Một trong các dân tộc thiểu số lớn ở miền núi phía Bắc, có nhiều lễ tục và văn nghệ dân gian đặc sắc.',
       N'One of the largest ethnic minorities in northern Vietnam, known for rich rituals and folk arts.',
       1
WHERE NOT EXISTS (SELECT 1 FROM dbo.DanToc WHERE MaDanToc = 'TAY');

INSERT INTO dbo.DanToc (MaDanToc, TenVI, TenEN, MoTaVI, MoTaEN, HoatDong)
SELECT 'HMONG', N'H''Mông', N'Hmong',
       N'Dân tộc có nhiều phong tục, trang phục và tập quán đặc trưng ở vùng núi phía Bắc.',
       N'An ethnic group known for distinctive customs, clothing and traditions in northern highlands.',
       1
WHERE NOT EXISTS (SELECT 1 FROM dbo.DanToc WHERE MaDanToc = 'HMONG');

INSERT INTO dbo.DanToc (MaDanToc, TenVI, TenEN, MoTaVI, MoTaEN, HoatDong)
SELECT 'EDE', N'Ê Đê', N'Ede',
       N'Dân tộc sinh sống chủ yếu ở Tây Nguyên, gắn với không gian văn hóa cồng chiêng.',
       N'An ethnic group living mainly in the Central Highlands, associated with gong culture.',
       1
WHERE NOT EXISTS (SELECT 1 FROM dbo.DanToc WHERE MaDanToc = 'EDE');

INSERT INTO dbo.DanToc (MaDanToc, TenVI, TenEN, MoTaVI, MoTaEN, HoatDong)
SELECT 'CHAM', N'Chăm', N'Cham',
       N'Cộng đồng có bề dày lịch sử ở miền Trung, nổi bật với kiến trúc tháp, dệt thổ cẩm và tín ngưỡng đặc sắc.',
       N'A long-established community in central Vietnam, known for tower architecture, weaving, and distinctive beliefs.',
       1
WHERE NOT EXISTS (SELECT 1 FROM dbo.DanToc WHERE MaDanToc = 'CHAM');

INSERT INTO dbo.DanToc (MaDanToc, TenVI, TenEN, MoTaVI, MoTaEN, HoatDong)
SELECT 'KHMER', N'Khmer', N'Khmer',
       N'Cộng đồng gắn với đồng bằng sông Cửu Long, Phật giáo Nam Tông và nghệ thuật sân khấu truyền thống.',
       N'A community associated with the Mekong Delta, Theravada Buddhism, and traditional performing arts.',
       1
WHERE NOT EXISTS (SELECT 1 FROM dbo.DanToc WHERE MaDanToc = 'KHMER');

INSERT INTO dbo.DanToc (MaDanToc, TenVI, TenEN, MoTaVI, MoTaEN, HoatDong)
SELECT 'DAO', N'Dao', N'Dao',
       N'Dân tộc nổi bật với thêu tay, nghi lễ cấp sắc và tri thức dân gian vùng núi phía Bắc.',
       N'An ethnic group known for embroidery, initiation rituals, and highland folk knowledge.',
       1
WHERE NOT EXISTS (SELECT 1 FROM dbo.DanToc WHERE MaDanToc = 'DAO');

INSERT INTO dbo.DanToc (MaDanToc, TenVI, TenEN, MoTaVI, MoTaEN, HoatDong)
SELECT 'BANA', N'Ba Na', N'Ba Na',
       N'Cộng đồng tiêu biểu của Tây Nguyên với sử thi, cồng chiêng và đời sống buôn làng đặc sắc.',
       N'An emblematic Central Highlands community with epics, gong culture, and distinctive village life.',
       1
WHERE NOT EXISTS (SELECT 1 FROM dbo.DanToc WHERE MaDanToc = 'BANA');

INSERT INTO dbo.DanToc (MaDanToc, TenVI, TenEN, MoTaVI, MoTaEN, HoatDong)
SELECT 'MUONG', N'Mường', N'Muong',
       N'Cộng đồng gắn bó với núi rừng và ruộng nước miền Bắc, giàu vốn sử thi, mo và âm nhạc dân gian.',
       N'A northern upland community tied to forests and rice fields, rich in epics, ritual chants, and folk music.',
       1
WHERE NOT EXISTS (SELECT 1 FROM dbo.DanToc WHERE MaDanToc = 'MUONG');

INSERT INTO dbo.DanToc (MaDanToc, TenVI, TenEN, MoTaVI, MoTaEN, HoatDong)
SELECT 'NUNG', N'Nùng', N'Nung',
       N'Cộng đồng vùng Đông Bắc nổi bật với chợ phiên, hát sli và nếp nhà sàn gắn với núi đồi.',
       N'An northeastern community known for market life, sli singing, and stilt houses in the hills.',
       1
WHERE NOT EXISTS (SELECT 1 FROM dbo.DanToc WHERE MaDanToc = 'NUNG');

INSERT INTO dbo.DanToc (MaDanToc, TenVI, TenEN, MoTaVI, MoTaEN, HoatDong)
SELECT 'GIAY', N'Giấy', N'Giay',
       N'Cộng đồng ở vùng núi phía Bắc, lưu giữ lễ hội cầu mùa, dân ca và tri thức canh tác ruộng nước.',
       N'A northern highland community preserving harvest rituals, folk songs, and wet-rice farming knowledge.',
       1
WHERE NOT EXISTS (SELECT 1 FROM dbo.DanToc WHERE MaDanToc = 'GIAY');

INSERT INTO dbo.DanToc (MaDanToc, TenVI, TenEN, MoTaVI, MoTaEN, HoatDong)
SELECT 'CHURU', N'Chu Ru', N'Chu Ru',
       N'Cộng đồng sống tại Lâm Đồng và Ninh Thuận, gắn với lễ mừng lúa mới, dệt thổ cẩm và nhà dài.',
       N'A community in Lam Dong and Ninh Thuan associated with new rice festivals, weaving, and longhouses.',
       1
WHERE NOT EXISTS (SELECT 1 FROM dbo.DanToc WHERE MaDanToc = 'CHURU');

/* =========================================================
   5. TỪ KHÓA
   ========================================================= */
INSERT INTO dbo.TuKhoa (MaTuKhoa, GiaTriVI, GiaTriEN, HoatDong)
SELECT 'TET', N'Tết Nguyên Đán', N'Lunar New Year', 1
WHERE NOT EXISTS (SELECT 1 FROM dbo.TuKhoa WHERE MaTuKhoa = 'TET');

INSERT INTO dbo.TuKhoa (MaTuKhoa, GiaTriVI, GiaTriEN, HoatDong)
SELECT 'AO_DAI', N'Áo dài', N'Ao Dai', 1
WHERE NOT EXISTS (SELECT 1 FROM dbo.TuKhoa WHERE MaTuKhoa = 'AO_DAI');

INSERT INTO dbo.TuKhoa (MaTuKhoa, GiaTriVI, GiaTriEN, HoatDong)
SELECT 'CONG_CHIENG', N'Cồng chiêng', N'Gong culture', 1
WHERE NOT EXISTS (SELECT 1 FROM dbo.TuKhoa WHERE MaTuKhoa = 'CONG_CHIENG');

INSERT INTO dbo.TuKhoa (MaTuKhoa, GiaTriVI, GiaTriEN, HoatDong)
SELECT 'THO_CUNG_TO_TIEN', N'Thờ cúng tổ tiên', N'Ancestor worship', 1
WHERE NOT EXISTS (SELECT 1 FROM dbo.TuKhoa WHERE MaTuKhoa = 'THO_CUNG_TO_TIEN');

INSERT INTO dbo.TuKhoa (MaTuKhoa, GiaTriVI, GiaTriEN, HoatDong)
SELECT 'DI_SAN', N'Di sản văn hóa', N'Cultural heritage', 1
WHERE NOT EXISTS (SELECT 1 FROM dbo.TuKhoa WHERE MaTuKhoa = 'DI_SAN');

/* =========================================================
   6. BÀI VIẾT VĂN HÓA
   ========================================================= */

-- Bài 1: Tết Nguyên Đán (đã duyệt, đã xuất bản, AI sẵn sàng)
INSERT INTO dbo.BaiViet (
    MaBaiViet,
    TieuDeVI, TieuDeEN,
    MoTaNganVI, MoTaNganEN,
    GioiThieuVI, GioiThieuEN,
    NguonGocVI, NguonGocEN,
    YNghiaVanHoaVI, YNghiaVanHoaEN,
    BoiCanhVI, BoiCanhEN,
    NoiDungChinhVI, NoiDungChinhEN,
    TrangThaiDuyet, TrangThaiXuatBan, MucDoNhayCam,
    TrangThaiDongBoAI, AIChoPhep, TomTatChoAIVI, TomTatChoAIEN, SanSangChoAI,
    NgayGuiDuyet, NgayDuyet, NgayXuatBan,
    TaoBoi, CapNhatBoi, DuyetBoi
)
SELECT
    'BV_TET_NGUYEN_DAN',
    N'Tết Nguyên Đán',
    N'Lunar New Year (Tet)',
    N'Lễ tết quan trọng nhất trong năm của người Việt, gắn với đoàn viên gia đình và khởi đầu năm mới.',
    N'The most important annual holiday in Vietnam, associated with family reunion and the beginning of a new year.',
    N'Tết Nguyên Đán là dịp chuyển giao giữa năm cũ và năm mới theo âm lịch, mang ý nghĩa mở đầu một chu kỳ sống mới.',
    N'Tet is the transition between the old and new lunar year, symbolizing the beginning of a new life cycle.',
    N'Tết có nguồn gốc lâu đời trong văn hóa nông nghiệp lúa nước, gắn với nhịp mùa vụ và niềm tin về sự tái sinh.',
    N'Tet has deep roots in wet-rice agricultural culture, linked to seasonal cycles and beliefs in renewal.',
    N'Tết thể hiện tinh thần đoàn tụ, lòng hiếu kính tổ tiên, ước vọng an lành và sự khởi đầu tốt đẹp.',
    N'Tet reflects family reunion, respect for ancestors, hopes for peace, and a good beginning.',
    N'Tết diễn ra trên phạm vi cả nước, nhưng mỗi vùng có cách chuẩn bị, món ăn và nghi lễ riêng.',
    N'Tet is celebrated nationwide, but each region has its own preparations, dishes, and rituals.',
    N'Các hoạt động phổ biến trong Tết gồm dọn dẹp nhà cửa, cúng ông Công ông Táo, gói bánh chưng hoặc bánh tét, chúc Tết, mừng tuổi, thăm họ hàng và đi lễ đầu năm. Trong bối cảnh hiện đại, nhiều nghi thức đã giản lược nhưng giá trị đoàn viên và tưởng nhớ tổ tiên vẫn được duy trì mạnh mẽ.',
    N'Common Tet activities include house cleaning, Kitchen Gods worship, making banh chung or banh tet, giving New Year greetings and lucky money, visiting relatives, and going to pagodas. In modern contexts, some rituals are simplified, but the values of reunion and ancestor remembrance remain strong.',
    'APPROVED',
    'PUBLISHED',
    1,
    'READY',
    1,
    N'Tết Nguyên Đán là lễ tết lớn nhất của người Việt, nhấn mạnh đoàn tụ gia đình, tưởng nhớ tổ tiên và chúc phúc đầu năm.',
    N'Tet is the most important Vietnamese holiday, emphasizing family reunion, ancestor remembrance and blessings for the new year.',
    1,
    DATEADD(DAY, -20, SYSUTCDATETIME()),
    DATEADD(DAY, -18, SYSUTCDATETIME()),
    DATEADD(DAY, -17, SYSUTCDATETIME()),
    (SELECT NguoiDungID FROM dbo.NguoiDung WHERE Email = 'content@vnculturebridge.ai'),
    (SELECT NguoiDungID FROM dbo.NguoiDung WHERE Email = 'content@vnculturebridge.ai'),
    (SELECT NguoiDungID FROM dbo.NguoiDung WHERE Email = 'reviewer@vnculturebridge.ai')
WHERE NOT EXISTS (SELECT 1 FROM dbo.BaiViet WHERE MaBaiViet = 'BV_TET_NGUYEN_DAN');

-- Bài 2: Áo dài (đã duyệt, đã xuất bản, AI đang chờ đồng bộ)
INSERT INTO dbo.BaiViet (
    MaBaiViet,
    TieuDeVI, TieuDeEN,
    MoTaNganVI, MoTaNganEN,
    GioiThieuVI, GioiThieuEN,
    NguonGocVI, NguonGocEN,
    YNghiaVanHoaVI, YNghiaVanHoaEN,
    BoiCanhVI, BoiCanhEN,
    NoiDungChinhVI, NoiDungChinhEN,
    TrangThaiDuyet, TrangThaiXuatBan, MucDoNhayCam,
    TrangThaiDongBoAI, AIChoPhep, TomTatChoAIVI, TomTatChoAIEN, SanSangChoAI,
    NgayGuiDuyet, NgayDuyet, NgayXuatBan,
    TaoBoi, CapNhatBoi, DuyetBoi
)
SELECT
    'BV_AO_DAI',
    N'Áo dài Việt Nam',
    N'Vietnamese Ao Dai',
    N'Trang phục truyền thống tiêu biểu của Việt Nam, mang giá trị thẩm mỹ và bản sắc văn hóa sâu sắc.',
    N'A representative traditional costume of Vietnam with strong aesthetic and cultural identity.',
    N'Áo dài là một biểu tượng văn hóa nổi bật, thường xuất hiện trong các dịp lễ, sự kiện chính thức và đời sống tinh thần.',
    N'Ao Dai is a prominent cultural symbol, commonly worn on festivals, formal events and in cultural life.',
    N'Áo dài hiện đại được hình thành qua nhiều giai đoạn phát triển, chịu ảnh hưởng từ trang phục ngũ thân và xu hướng cải biến thẩm mỹ.',
    N'The modern Ao Dai evolved over time, influenced by the five-panel gown and changing aesthetic trends.',
    N'Áo dài biểu trưng cho sự duyên dáng, thanh lịch và khả năng dung hòa giữa truyền thống và hiện đại.',
    N'Ao Dai symbolizes elegance, grace and the balance between tradition and modernity.',
    N'Áo dài được mặc phổ biến trong trường học, công sở, lễ cưới, lễ hội và hoạt động ngoại giao văn hóa.',
    N'Ao Dai is commonly worn in schools, workplaces, weddings, festivals and cultural diplomacy events.',
    N'Không chỉ là trang phục, áo dài còn là hình ảnh đại diện của Việt Nam trong nhiều bối cảnh quốc tế. Kiểu dáng, chất liệu và cách sử dụng áo dài thay đổi theo giới tính, độ tuổi, vùng miền và mục đích sử dụng, nhưng vẫn giữ được giá trị biểu tượng cốt lõi.',
    N'Ao Dai is more than clothing; it represents Vietnam in many international contexts. Its style, material and use vary by gender, age, region and purpose, yet its symbolic value remains consistent.',
    'APPROVED',
    'PUBLISHED',
    1,
    'PENDING',
    1,
    N'Áo dài là biểu tượng trang phục truyền thống của Việt Nam, thể hiện sự thanh lịch, duyên dáng và bản sắc dân tộc.',
    N'Ao Dai is a traditional Vietnamese costume symbolizing elegance, grace and national identity.',
    0,
    DATEADD(DAY, -12, SYSUTCDATETIME()),
    DATEADD(DAY, -10, SYSUTCDATETIME()),
    DATEADD(DAY, -9, SYSUTCDATETIME()),
    (SELECT NguoiDungID FROM dbo.NguoiDung WHERE Email = 'content@vnculturebridge.ai'),
    (SELECT NguoiDungID FROM dbo.NguoiDung WHERE Email = 'ai@vnculturebridge.ai'),
    (SELECT NguoiDungID FROM dbo.NguoiDung WHERE Email = 'reviewer@vnculturebridge.ai')
WHERE NOT EXISTS (SELECT 1 FROM dbo.BaiViet WHERE MaBaiViet = 'BV_AO_DAI');

-- Bài 3: Không gian văn hóa cồng chiêng Tây Nguyên (đang chờ duyệt)
INSERT INTO dbo.BaiViet (
    MaBaiViet,
    TieuDeVI, TieuDeEN,
    MoTaNganVI, MoTaNganEN,
    GioiThieuVI, GioiThieuEN,
    NguonGocVI, NguonGocEN,
    YNghiaVanHoaVI, YNghiaVanHoaEN,
    BoiCanhVI, BoiCanhEN,
    NoiDungChinhVI, NoiDungChinhEN,
    TrangThaiDuyet, TrangThaiXuatBan, MucDoNhayCam,
    TrangThaiDongBoAI, AIChoPhep, TomTatChoAIVI, TomTatChoAIEN, SanSangChoAI,
    NgayGuiDuyet, NgayDuyet, NgayXuatBan,
    TaoBoi, CapNhatBoi, DuyetBoi
)
SELECT
    'BV_CONG_CHIENG_TAY_NGUYEN',
    N'Không gian văn hóa cồng chiêng Tây Nguyên',
    N'The Cultural Space of Central Highlands Gongs',
    N'Di sản văn hóa đặc sắc gắn với nghi lễ, cộng đồng và đời sống tâm linh của các dân tộc Tây Nguyên.',
    N'A distinctive cultural heritage tied to rituals, community life and spirituality in the Central Highlands.',
    N'Cồng chiêng không chỉ là nhạc cụ mà còn là phương tiện biểu đạt đời sống tinh thần và cộng đồng.',
    N'Gongs are not merely instruments but also a medium for expressing spiritual and communal life.',
    N'Không gian văn hóa cồng chiêng hình thành từ lâu đời trong đời sống các dân tộc bản địa Tây Nguyên.',
    N'The gong cultural space emerged long ago within the life of indigenous Central Highlands communities.',
    N'Cồng chiêng phản ánh quan niệm về sự kết nối giữa con người, thần linh, thiên nhiên và cộng đồng.',
    N'Gongs reflect the relationship between humans, deities, nature and community.',
    N'Cồng chiêng xuất hiện trong lễ mừng lúa mới, lễ bỏ mả, lễ cưới, lễ cúng bến nước và nhiều nghi lễ vòng đời.',
    N'Gongs appear in new rice ceremonies, funerary rituals, weddings, water source rites and many life-cycle ceremonies.',
    N'Bài viết phân tích vai trò của cồng chiêng trong nghi lễ, sinh hoạt cộng đồng và giá trị di sản được bảo tồn trong bối cảnh hiện đại. Nội dung cũng nhấn mạnh rằng việc hiểu cồng chiêng cần đặt trong tổng thể không gian văn hóa, chứ không chỉ nhìn như một loại nhạc cụ biểu diễn.',
    N'This article analyzes the role of gongs in rituals, community life and heritage preservation in modern times. It also stresses that gongs should be understood as part of a full cultural space, not merely as performance instruments.',
    'PENDING_REVIEW',
    'PRIVATE',
    2,
    'PENDING',
    0,
    NULL,
    NULL,
    0,
    DATEADD(DAY, -3, SYSUTCDATETIME()),
    NULL,
    NULL,
    (SELECT NguoiDungID FROM dbo.NguoiDung WHERE Email = 'content@vnculturebridge.ai'),
    (SELECT NguoiDungID FROM dbo.NguoiDung WHERE Email = 'content@vnculturebridge.ai'),
    NULL
WHERE NOT EXISTS (SELECT 1 FROM dbo.BaiViet WHERE MaBaiViet = 'BV_CONG_CHIENG_TAY_NGUYEN');

-- Bài 4: Lễ hội đâm trâu (bị từ chối do cần duyệt kỹ hơn vì nhạy cảm)
INSERT INTO dbo.BaiViet (
    MaBaiViet,
    TieuDeVI, TieuDeEN,
    MoTaNganVI, MoTaNganEN,
    GioiThieuVI, GioiThieuEN,
    NguonGocVI, NguonGocEN,
    YNghiaVanHoaVI, YNghiaVanHoaEN,
    BoiCanhVI, BoiCanhEN,
    NoiDungChinhVI, NoiDungChinhEN,
    TrangThaiDuyet, TrangThaiXuatBan, MucDoNhayCam,
    TrangThaiDongBoAI, AIChoPhep, TomTatChoAIVI, TomTatChoAIEN, SanSangChoAI,
    NgayGuiDuyet, NgayDuyet, NgayXuatBan,
    TaoBoi, CapNhatBoi, DuyetBoi
)
SELECT
    'BV_DAM_TRAU',
    N'Lễ hội đâm trâu',
    N'Buffalo Stabbing Ritual',
    N'Nghi lễ truyền thống gắn với bối cảnh tín ngưỡng và sinh hoạt cộng đồng ở một số nhóm dân tộc Tây Nguyên.',
    N'A traditional ritual associated with belief systems and communal life among some Central Highlands groups.',
    N'Đây là nội dung cần diễn giải thận trọng để tránh hiểu sai hoặc nhìn nhận phiến diện.',
    N'This topic requires careful explanation to avoid misunderstanding or one-sided judgment.',
    N'Nghi lễ xuất phát từ bối cảnh tín ngưỡng, quan niệm hiến sinh và đời sống cộng đồng truyền thống.',
    N'The ritual originated from traditional beliefs, sacrificial concepts and communal life.',
    N'Ý nghĩa của nghi lễ cần được đặt trong bối cảnh lịch sử và văn hóa cụ thể thay vì tách rời khỏi không gian bản địa.',
    N'The meaning of this ritual should be understood within its specific historical and cultural context rather than isolated from indigenous life.',
    N'Nội dung nhạy cảm nên cần thêm nguồn kiểm chứng và cách diễn giải trung tính, tôn trọng văn hóa.',
    N'This sensitive content requires additional references and neutral, respectful explanation.',
    N'Bài viết hiện đang ở dạng bản thảo chuyên đề, cần được biên tập thêm để bảo đảm tính học thuật, trung tính và phù hợp với đối tượng người dùng quốc tế.',
    N'This article is still in draft form and needs further editing to ensure scholarly neutrality and suitability for international users.',
    'REJECTED',
    'PRIVATE',
    3,
    'FAILED',
    0,
    NULL,
    NULL,
    0,
    DATEADD(DAY, -8, SYSUTCDATETIME()),
    DATEADD(DAY, -6, SYSUTCDATETIME()),
    NULL,
    (SELECT NguoiDungID FROM dbo.NguoiDung WHERE Email = 'content@vnculturebridge.ai'),
    (SELECT NguoiDungID FROM dbo.NguoiDung WHERE Email = 'content@vnculturebridge.ai'),
    (SELECT NguoiDungID FROM dbo.NguoiDung WHERE Email = 'reviewer@vnculturebridge.ai')
WHERE NOT EXISTS (SELECT 1 FROM dbo.BaiViet WHERE MaBaiViet = 'BV_DAM_TRAU');

/* =========================================================
   7. BẢNG LIÊN KẾT NGHIỆP VỤ
   ========================================================= */

-- Tết -> Danh mục
INSERT INTO dbo.BaiViet_DanhMuc (BaiVietID, DanhMucID, LaDanhMucChinh)
SELECT bv.BaiVietID, dm.DanhMucID, 1
FROM dbo.BaiViet bv
JOIN dbo.DanhMuc dm ON dm.MaDanhMuc = 'LE_HOI'
WHERE bv.MaBaiViet = 'BV_TET_NGUYEN_DAN'
  AND NOT EXISTS (
      SELECT 1
      FROM dbo.BaiViet_DanhMuc x
      WHERE x.BaiVietID = bv.BaiVietID AND x.DanhMucID = dm.DanhMucID
  );

INSERT INTO dbo.BaiViet_DanhMuc (BaiVietID, DanhMucID, LaDanhMucChinh)
SELECT bv.BaiVietID, dm.DanhMucID, 0
FROM dbo.BaiViet bv
JOIN dbo.DanhMuc dm ON dm.MaDanhMuc = 'TIN_NGUONG'
WHERE bv.MaBaiViet = 'BV_TET_NGUYEN_DAN'
  AND NOT EXISTS (
      SELECT 1
      FROM dbo.BaiViet_DanhMuc x
      WHERE x.BaiVietID = bv.BaiVietID AND x.DanhMucID = dm.DanhMucID
  );

-- Áo dài -> Danh mục
INSERT INTO dbo.BaiViet_DanhMuc (BaiVietID, DanhMucID, LaDanhMucChinh)
SELECT bv.BaiVietID, dm.DanhMucID, 1
FROM dbo.BaiViet bv
JOIN dbo.DanhMuc dm ON dm.MaDanhMuc = 'TRANG_PHUC'
WHERE bv.MaBaiViet = 'BV_AO_DAI'
  AND NOT EXISTS (
      SELECT 1 FROM dbo.BaiViet_DanhMuc x
      WHERE x.BaiVietID = bv.BaiVietID AND x.DanhMucID = dm.DanhMucID
  );

-- Cồng chiêng -> Danh mục
INSERT INTO dbo.BaiViet_DanhMuc (BaiVietID, DanhMucID, LaDanhMucChinh)
SELECT bv.BaiVietID, dm.DanhMucID, 1
FROM dbo.BaiViet bv
JOIN dbo.DanhMuc dm ON dm.MaDanhMuc = 'NGHE_THUAT_DAN_GIAN'
WHERE bv.MaBaiViet = 'BV_CONG_CHIENG_TAY_NGUYEN'
  AND NOT EXISTS (
      SELECT 1 FROM dbo.BaiViet_DanhMuc x
      WHERE x.BaiVietID = bv.BaiVietID AND x.DanhMucID = dm.DanhMucID
  );

-- Đâm trâu -> Danh mục
INSERT INTO dbo.BaiViet_DanhMuc (BaiVietID, DanhMucID, LaDanhMucChinh)
SELECT bv.BaiVietID, dm.DanhMucID, 1
FROM dbo.BaiViet bv
JOIN dbo.DanhMuc dm ON dm.MaDanhMuc = 'LE_HOI'
WHERE bv.MaBaiViet = 'BV_DAM_TRAU'
  AND NOT EXISTS (
      SELECT 1 FROM dbo.BaiViet_DanhMuc x
      WHERE x.BaiVietID = bv.BaiVietID AND x.DanhMucID = dm.DanhMucID
  );

-- Vùng
INSERT INTO dbo.BaiViet_Vung (BaiVietID, VungID, LaVungChinh)
SELECT bv.BaiVietID, vv.VungID, 1
FROM dbo.BaiViet bv
JOIN dbo.VungVanHoa vv ON vv.MaVung = 'BAC_BO'
WHERE bv.MaBaiViet = 'BV_TET_NGUYEN_DAN'
  AND NOT EXISTS (
      SELECT 1 FROM dbo.BaiViet_Vung x
      WHERE x.BaiVietID = bv.BaiVietID AND x.VungID = vv.VungID
  );

INSERT INTO dbo.BaiViet_Vung (BaiVietID, VungID, LaVungChinh)
SELECT bv.BaiVietID, vv.VungID, 1
FROM dbo.BaiViet bv
JOIN dbo.VungVanHoa vv ON vv.MaVung = 'TRUNG_BO'
WHERE bv.MaBaiViet = 'BV_AO_DAI'
  AND NOT EXISTS (
      SELECT 1 FROM dbo.BaiViet_Vung x
      WHERE x.BaiVietID = bv.BaiVietID AND x.VungID = vv.VungID
  );

INSERT INTO dbo.BaiViet_Vung (BaiVietID, VungID, LaVungChinh)
SELECT bv.BaiVietID, vv.VungID, 1
FROM dbo.BaiViet bv
JOIN dbo.VungVanHoa vv ON vv.MaVung = 'TAY_NGUYEN'
WHERE bv.MaBaiViet IN ('BV_CONG_CHIENG_TAY_NGUYEN', 'BV_DAM_TRAU')
  AND NOT EXISTS (
      SELECT 1 FROM dbo.BaiViet_Vung x
      WHERE x.BaiVietID = bv.BaiVietID AND x.VungID = vv.VungID
  );

-- Dân tộc
INSERT INTO dbo.BaiViet_DanToc (BaiVietID, DanTocID, LaDanTocChinh)
SELECT bv.BaiVietID, dt.DanTocID, 1
FROM dbo.BaiViet bv
JOIN dbo.DanToc dt ON dt.MaDanToc = 'KINH'
WHERE bv.MaBaiViet IN ('BV_TET_NGUYEN_DAN', 'BV_AO_DAI')
  AND NOT EXISTS (
      SELECT 1 FROM dbo.BaiViet_DanToc x
      WHERE x.BaiVietID = bv.BaiVietID AND x.DanTocID = dt.DanTocID
  );

INSERT INTO dbo.BaiViet_DanToc (BaiVietID, DanTocID, LaDanTocChinh)
SELECT bv.BaiVietID, dt.DanTocID, 1
FROM dbo.BaiViet bv
JOIN dbo.DanToc dt ON dt.MaDanToc = 'EDE'
WHERE bv.MaBaiViet IN ('BV_CONG_CHIENG_TAY_NGUYEN', 'BV_DAM_TRAU')
  AND NOT EXISTS (
      SELECT 1 FROM dbo.BaiViet_DanToc x
      WHERE x.BaiVietID = bv.BaiVietID AND x.DanTocID = dt.DanTocID
  );

-- Từ khóa
INSERT INTO dbo.BaiViet_TuKhoa (BaiVietID, TuKhoaID)
SELECT bv.BaiVietID, tk.TuKhoaID
FROM dbo.BaiViet bv
JOIN dbo.TuKhoa tk ON tk.MaTuKhoa = 'TET'
WHERE bv.MaBaiViet = 'BV_TET_NGUYEN_DAN'
  AND NOT EXISTS (
      SELECT 1 FROM dbo.BaiViet_TuKhoa x
      WHERE x.BaiVietID = bv.BaiVietID AND x.TuKhoaID = tk.TuKhoaID
  );

INSERT INTO dbo.BaiViet_TuKhoa (BaiVietID, TuKhoaID)
SELECT bv.BaiVietID, tk.TuKhoaID
FROM dbo.BaiViet bv
JOIN dbo.TuKhoa tk ON tk.MaTuKhoa = 'THO_CUNG_TO_TIEN'
WHERE bv.MaBaiViet = 'BV_TET_NGUYEN_DAN'
  AND NOT EXISTS (
      SELECT 1 FROM dbo.BaiViet_TuKhoa x
      WHERE x.BaiVietID = bv.BaiVietID AND x.TuKhoaID = tk.TuKhoaID
  );

INSERT INTO dbo.BaiViet_TuKhoa (BaiVietID, TuKhoaID)
SELECT bv.BaiVietID, tk.TuKhoaID
FROM dbo.BaiViet bv
JOIN dbo.TuKhoa tk ON tk.MaTuKhoa = 'AO_DAI'
WHERE bv.MaBaiViet = 'BV_AO_DAI'
  AND NOT EXISTS (
      SELECT 1 FROM dbo.BaiViet_TuKhoa x
      WHERE x.BaiVietID = bv.BaiVietID AND x.TuKhoaID = tk.TuKhoaID
  );

INSERT INTO dbo.BaiViet_TuKhoa (BaiVietID, TuKhoaID)
SELECT bv.BaiVietID, tk.TuKhoaID
FROM dbo.BaiViet bv
JOIN dbo.TuKhoa tk ON tk.MaTuKhoa IN ('CONG_CHIENG', 'DI_SAN')
WHERE bv.MaBaiViet = 'BV_CONG_CHIENG_TAY_NGUYEN'
  AND NOT EXISTS (
      SELECT 1 FROM dbo.BaiViet_TuKhoa x
      WHERE x.BaiVietID = bv.BaiVietID AND x.TuKhoaID = tk.TuKhoaID
  );

-- Bài viết liên quan
INSERT INTO dbo.BaiViet_LienQuan (BaiVietID, BaiVietLienQuanID, LoaiLienQuan)
SELECT b1.BaiVietID, b2.BaiVietID, 'RELATED'
FROM dbo.BaiViet b1
JOIN dbo.BaiViet b2 ON b2.MaBaiViet = 'BV_AO_DAI'
WHERE b1.MaBaiViet = 'BV_TET_NGUYEN_DAN'
  AND NOT EXISTS (
      SELECT 1 FROM dbo.BaiViet_LienQuan x
      WHERE x.BaiVietID = b1.BaiVietID AND x.BaiVietLienQuanID = b2.BaiVietID
  );

INSERT INTO dbo.BaiViet_LienQuan (BaiVietID, BaiVietLienQuanID, LoaiLienQuan)
SELECT b1.BaiVietID, b2.BaiVietID, 'EXPAND'
FROM dbo.BaiViet b1
JOIN dbo.BaiViet b2 ON b2.MaBaiViet = 'BV_CONG_CHIENG_TAY_NGUYEN'
WHERE b1.MaBaiViet = 'BV_DAM_TRAU'
  AND NOT EXISTS (
      SELECT 1 FROM dbo.BaiViet_LienQuan x
      WHERE x.BaiVietID = b1.BaiVietID AND x.BaiVietLienQuanID = b2.BaiVietID
  );

/* =========================================================
   8. MEDIA
   ========================================================= */
INSERT INTO dbo.Media (
    BaiVietID, LoaiMedia, UrlFile,
    AltTextVI, AltTextEN, ChuThichVI, ChuThichEN,
    LaAnhChinh, ThuTuHienThi
)
SELECT
    bv.BaiVietID,
    'IMAGE',
    N'https://cdn.vnculturebridge.ai/media/tet/banh-chung.jpg',
    N'Bánh chưng ngày Tết',
    N'Banh Chung during Tet',
    N'Hình minh họa bánh chưng - món ăn biểu tượng trong dịp Tết cổ truyền.',
    N'Illustration of Banh Chung, a symbolic dish during Tet.',
    1, 1
FROM dbo.BaiViet bv
WHERE bv.MaBaiViet = 'BV_TET_NGUYEN_DAN'
  AND NOT EXISTS (
      SELECT 1 FROM dbo.Media x
      WHERE x.BaiVietID = bv.BaiVietID
        AND x.UrlFile = N'https://cdn.vnculturebridge.ai/media/tet/banh-chung.jpg'
  );

INSERT INTO dbo.Media (
    BaiVietID, LoaiMedia, UrlFile,
    AltTextVI, AltTextEN, ChuThichVI, ChuThichEN,
    LaAnhChinh, ThuTuHienThi
)
SELECT
    bv.BaiVietID,
    'IMAGE',
    N'https://cdn.vnculturebridge.ai/media/ao-dai/ao-dai-truyen-thong.jpg',
    N'Áo dài truyền thống màu xanh',
    N'Traditional blue Ao Dai',
    N'Hình ảnh áo dài truyền thống trong bối cảnh trình diễn văn hóa.',
    N'Image of a traditional Ao Dai in a cultural presentation setting.',
    1, 1
FROM dbo.BaiViet bv
WHERE bv.MaBaiViet = 'BV_AO_DAI'
  AND NOT EXISTS (
      SELECT 1 FROM dbo.Media x
      WHERE x.BaiVietID = bv.BaiVietID
        AND x.UrlFile = N'https://cdn.vnculturebridge.ai/media/ao-dai/ao-dai-truyen-thong.jpg'
  );

INSERT INTO dbo.Media (
    BaiVietID, LoaiMedia, UrlFile,
    AltTextVI, AltTextEN, ChuThichVI, ChuThichEN,
    LaAnhChinh, ThuTuHienThi
)
SELECT
    bv.BaiVietID,
    'VIDEO',
    N'https://cdn.vnculturebridge.ai/media/cong-chieng/cong-chieng-tay-nguyen.mp4',
    N'Biểu diễn cồng chiêng Tây Nguyên',
    N'Central Highlands gong performance',
    N'Video mô phỏng không gian biểu diễn cồng chiêng trong sinh hoạt cộng đồng.',
    N'Video simulating gong performance in community life.',
    0, 2
FROM dbo.BaiViet bv
WHERE bv.MaBaiViet = 'BV_CONG_CHIENG_TAY_NGUYEN'
  AND NOT EXISTS (
      SELECT 1 FROM dbo.Media x
      WHERE x.BaiVietID = bv.BaiVietID
        AND x.UrlFile = N'https://cdn.vnculturebridge.ai/media/cong-chieng/cong-chieng-tay-nguyen.mp4'
  );

INSERT INTO dbo.NgheThuatPage (
    MaTrang,
    HeroBadgeVI, HeroBadgeEN,
    HeroTitleLine1VI, HeroTitleLine1EN,
    HeroTitleAccentVI, HeroTitleAccentEN,
    HeroTitleLine3VI, HeroTitleLine3EN,
    HeroSubtitleVI, HeroSubtitleEN,
    HeroImageUrl, HeroImageAltVI, HeroImageAltEN,
    HeroImageBadgeVI, HeroImageBadgeEN, HeroImageBadgeIcon,
    StatsJsonVI, StatsJsonEN,
    HeritageTitleVI, HeritageTitleEN,
    HeritageSubtitleVI, HeritageSubtitleEN,
    HeritageCardsJsonVI, HeritageCardsJsonEN,
    FeaturedBadgeVI, FeaturedBadgeEN,
    FeaturedTitleVI, FeaturedTitleEN,
    FeaturedBodyJsonVI, FeaturedBodyJsonEN,
    FeaturedStatsJsonVI, FeaturedStatsJsonEN,
    FeaturedImageUrl, FeaturedImageAltVI, FeaturedImageAltEN,
    GalleryTitleVI, GalleryTitleEN,
    GallerySubtitleVI, GallerySubtitleEN,
    GalleryImagesJsonVI, GalleryImagesJsonEN,
    StoryBadgeVI, StoryBadgeEN,
    StoryTitleVI, StoryTitleEN,
    StoryBodyJsonVI, StoryBodyJsonEN,
    StoryFeaturesJsonVI, StoryFeaturesJsonEN,
    StoryImagesJsonVI, StoryImagesJsonEN,
    HoatDong
)
SELECT
    'NGHE_THUAT',
    N'Văn hoá · Di sản · Nghệ thuật', N'Culture · Heritage · Art',
    N'Nghệ Thuật', N'Vietnamese',
    N'& Di Sản', N'Arts & Heritage',
    N'Việt Nam', N'',
    N'Nơi truyền thống cổ xưa hòa quyện cùng biểu đạt hiện đại — mang theo câu chuyện ngàn năm trong từng nét vẽ, từng điệu múa.',
    N'Where ancient traditions weave through modern expression — carrying stories of a thousand years in every brushstroke and dance.',
    N'https://images.unsplash.com/photo-1579783901586-d88db74b4fe4?w=1600',
    N'Ruộng bậc thang Việt Nam',
    N'Vietnamese rice terraces',
    N'Ruộng bậc thang Tây Bắc',
    N'Northwestern Terraces',
    N'🏔️',
    N'[{"value":"4.000+","label":"Năm lịch sử"},{"value":"54","label":"Dân tộc anh em"},{"value":"8","label":"Di sản UNESCO"}]',
    N'[{"value":"4,000+","label":"Years of history"},{"value":"54","label":"Ethnic groups"},{"value":"8","label":"UNESCO heritages"}]',
    N'Khám Phá Di Sản', N'Explore Our Heritage',
    N'Khám phá vẻ đẹp vượt thời gian của tinh hoa thủ công Việt Nam',
    N'Discover the timeless beauty of Vietnamese craftsmanship',
    N'[{"img":"https://images.unsplash.com/photo-1567689265664-3bc6e1e4b07b?w=900","titleVi":"Nghệ Thuật Lụa","titleEn":"Silk Art","subVi":"Lụa Truyền Thống","subEn":"Traditional Silk"},{"img":"https://images.unsplash.com/photo-1619164601044-90e0e1d0e87b?w=900","titleVi":"Nghệ Thuật Gốm","titleEn":"Pottery","subVi":"Gốm Bát Tràng","subEn":"Bat Trang Pottery"},{"img":"https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=900","titleVi":"Tranh Dân Gian","titleEn":"Traditional Painting","subVi":"Tranh Dân Gian","subEn":"Traditional Painting"},{"img":"https://images.unsplash.com/photo-1579783901586-d88db74b4fe4?w=900","titleVi":"Điêu Khắc","titleEn":"Sculpture","subVi":"Điêu Khắc","subEn":"Sculpture"}]',
    N'[{"img":"https://images.unsplash.com/photo-1567689265664-3bc6e1e4b07b?w=900","titleVi":"Nghệ Thuật Lụa","titleEn":"Silk Art","subVi":"Lụa Truyền Thống","subEn":"Traditional Silk"},{"img":"https://images.unsplash.com/photo-1619164601044-90e0e1d0e87b?w=900","titleVi":"Nghệ Thuật Gốm","titleEn":"Pottery","subVi":"Gốm Bát Tràng","subEn":"Bat Trang Pottery"},{"img":"https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=900","titleVi":"Tranh Dân Gian","titleEn":"Traditional Painting","subVi":"Tranh Dân Gian","subEn":"Traditional Painting"},{"img":"https://images.unsplash.com/photo-1579783901586-d88db74b4fe4?w=900","titleVi":"Điêu Khắc","titleEn":"Sculpture","subVi":"Điêu Khắc","subEn":"Sculpture"}]',
    N'TÁC PHẨM NỔI BẬT', N'FEATURED ARTWORK',
    N'Nghệ thuật Sơn Mài', N'The Art of Sơn Mài',
    N'["Nghệ thuật sơn mài Việt Nam là một quá trình chế tác công phu đã được hoàn thiện qua nhiều thế kỷ. Mỗi tác phẩm đòi hỏi nhiều tháng tỉ mỉ sơn từng lớp, với sự khéo léo của nghệ nhân khi phủ lên đến 12 lớp nhựa từ cây sơn.","Giữa các lớp, bề mặt được chà nhám và đánh bóng cẩn thận, tạo ra độ sâu và độ sáng rực rỡ như phát quang từ bên trong. Các sắc tố tự nhiên cùng vật liệu như vỏ trứng, vàng lá và bạc tạo ra hiệu ứng lấp lánh tinh tế khiến mỗi tác phẩm đều là độc nhất."]',
    N'["Vietnamese lacquer art, known as Sơn Mài, is a painstaking craft that has been perfected over centuries. Each piece requires months of meticulous layering, with artisans applying up to twelve coats of resin derived from the sơn tree.","Between each layer, the surface is carefully sanded and polished, creating depth and luminosity that seems to glow from within. Natural pigments and materials like eggshell, gold leaf, and silver create the distinctive shimmer that makes each piece unique."]',
    N'[{"value":"12+","label":"Lớp sơn mài"},{"value":"3-6","label":"Tháng hoàn thiện"},{"value":"100+","label":"Năm truyền thống"}]',
    N'[{"value":"12+","label":"Layers of lacquer"},{"value":"3-6","label":"Months to complete"},{"value":"100+","label":"Years of tradition"}]',
    N'https://images.unsplash.com/photo-1579783901586-d88db74b4fe4?w=1200',
    N'Sơn Mài Art',
    N'Son Mai Art',
    N'Thư Viện Ảnh', N'Our Gallery',
    N'Hành trình thị giác qua di sản nghệ thuật Việt Nam',
    N'A visual journey through Vietnam''s artistic legacy',
    N'[{"url":"https://images.unsplash.com/photo-1567689265664-3bc6e1e4b07b?w=900","alt":"Vietnam Culture"},{"url":"https://images.unsplash.com/photo-1619164601044-90e0e1d0e87b?w=900","alt":"Vietnam Culture"},{"url":"https://images.unsplash.com/photo-1509722747041-616f39b57569?w=900","alt":"Vietnam Culture"},{"url":"https://images.unsplash.com/photo-1625944525533-473f1a3d54de?w=900","alt":"Vietnam Culture"},{"url":"https://images.unsplash.com/photo-1555939594-58d7cb561ad1?w=900","alt":"Vietnam Culture"},{"url":"https://images.unsplash.com/photo-1517486808906-6ca8b3f04846?w=900","alt":"Vietnam Culture"}]',
    N'[{"url":"https://images.unsplash.com/photo-1567689265664-3bc6e1e4b07b?w=900","alt":"Vietnam Culture"},{"url":"https://images.unsplash.com/photo-1619164601044-90e0e1d0e87b?w=900","alt":"Vietnam Culture"},{"url":"https://images.unsplash.com/photo-1509722747041-616f39b57569?w=900","alt":"Vietnam Culture"},{"url":"https://images.unsplash.com/photo-1625944525533-473f1a3d54de?w=900","alt":"Vietnam Culture"},{"url":"https://images.unsplash.com/photo-1555939594-58d7cb561ad1?w=900","alt":"Vietnam Culture"},{"url":"https://images.unsplash.com/photo-1517486808906-6ca8b3f04846?w=900","alt":"Vietnam Culture"}]',
    N'CÂU CHUYỆN CỦA CHÚNG TÔI', N'OUR STORY',
    N'Sợi Chỉ Thời Gian, Dệt Bằng Tâm Hồn', N'Threads of Time, Woven with Soul',
    N'["Trong hơn một thiên niên kỷ, các nghệ nhân Việt Nam đã gìn giữ và nâng tầm nghề thủ công của mình, truyền lại các kỹ thuật qua nhiều thế hệ như những di vật quý giá. Từ những dải lụa tinh xảo của Hà Đông đến vẻ đẹp mộc mạc của gốm sứ Bát Tràng, mỗi truyền thống đều mang trong mình linh hồn của đất nước.","Những bản khắc gỗ Đông Hồ rực rỡ kể những câu chuyện về sự thịnh vượng và may mắn, trong khi chiều sâu lung linh của các bức tranh sơn mài ghi lại những khoảnh khắc đóng băng trong thời gian. Những môn nghệ thuật này không chỉ đơn thuần là trang trí - chúng là chứng nhân sống động cho sự kiên cường, sáng tạo và tinh thần bền bỉ của Việt Nam."]',
    N'["For over a millennium, Vietnamese artisans have preserved and elevated their crafts, passing down techniques through generations like precious heirlooms. From the delicate silks of Hà Đông to the earthen beauty of Bat Trang ceramics, each tradition carries the soul of the land.","The vibrant Đông Hồ woodblock prints tell stories of prosperity and luck, while the shimmering depths of lacquer paintings capture moments frozen in time. These arts are not merely decorative—they are living testimonies to resilience, creativity, and the enduring spirit of Vietnam."]',
    N'[{"color":"#b91c1c","titleVi":"Bảo tồn di sản","titleEn":"Heritage Preservation","textVi":"Bảo vệ các kỹ thuật cổ xưa cho thế hệ tương lai","textEn":"Protecting ancient techniques for future generations"},{"color":"#f59e0b","titleVi":"Biểu đạt đương đại","titleEn":"Contemporary Expression","textVi":"Kết hợp truyền thống với tầm nhìn nghệ thuật hiện đại","textEn":"Blending tradition with modern artistic vision"},{"color":"#10b981","titleVi":"Kết nối văn hóa","titleEn":"Cultural Connection","textVi":"Chia sẻ di sản nghệ thuật của Việt Nam với thế giới","textEn":"Sharing Vietnam''s artistic legacy with the world"}]',
    N'[{"color":"#b91c1c","titleVi":"Bảo tồn di sản","titleEn":"Heritage Preservation","textVi":"Bảo vệ các kỹ thuật cổ xưa cho thế hệ tương lai","textEn":"Protecting ancient techniques for future generations"},{"color":"#f59e0b","titleVi":"Biểu đạt đương đại","titleEn":"Contemporary Expression","textVi":"Kết hợp truyền thống với tầm nhìn nghệ thuật hiện đại","textEn":"Blending tradition with modern artistic vision"},{"color":"#10b981","titleVi":"Kết nối văn hóa","titleEn":"Cultural Connection","textVi":"Chia sẻ di sản nghệ thuật của Việt Nam với thế giới","textEn":"Sharing Vietnam''s artistic legacy with the world"}]',
    N'[{"url":"https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=900","alt":"Heritage"},{"url":"https://images.unsplash.com/photo-1619164601044-90e0e1d0e87b?w=900","alt":"Heritage"},{"url":"https://images.unsplash.com/photo-1567689265664-3bc6e1e4b07b?w=900","alt":"Heritage"},{"url":"https://images.unsplash.com/photo-1625944525533-473f1a3d54de?w=900","alt":"Heritage"}]',
    N'[{"url":"https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=900","alt":"Heritage"},{"url":"https://images.unsplash.com/photo-1619164601044-90e0e1d0e87b?w=900","alt":"Heritage"},{"url":"https://images.unsplash.com/photo-1567689265664-3bc6e1e4b07b?w=900","alt":"Heritage"},{"url":"https://images.unsplash.com/photo-1625944525533-473f1a3d54de?w=900","alt":"Heritage"}]',
    1
WHERE NOT EXISTS (SELECT 1 FROM dbo.NgheThuatPage WHERE MaTrang = 'NGHE_THUAT');

/* =========================================================
   9. NGUỒN THAM KHẢO
   ========================================================= */
INSERT INTO dbo.NguonThamKhao (
    BaiVietID, TieuDeNguon, TacGia, LoaiNguon, UrlNguon, GhiChu, LaNguonChinh
)
SELECT
    bv.BaiVietID,
    N'Tìm hiểu Tết cổ truyền Việt Nam',
    N'Nhiều tác giả',
    'GOVERNMENT',
    N'https://moic.gov.vn/tet-co-truyen-viet-nam',
    N'Nguồn tham khảo khái quát về Tết truyền thống.',
    1
FROM dbo.BaiViet bv
WHERE bv.MaBaiViet = 'BV_TET_NGUYEN_DAN'
  AND NOT EXISTS (
      SELECT 1 FROM dbo.NguonThamKhao x
      WHERE x.BaiVietID = bv.BaiVietID
        AND x.TieuDeNguon = N'Tìm hiểu Tết cổ truyền Việt Nam'
  );

INSERT INTO dbo.NguonThamKhao (
    BaiVietID, TieuDeNguon, TacGia, LoaiNguon, UrlNguon, GhiChu, LaNguonChinh
)
SELECT
    bv.BaiVietID,
    N'Áo dài Việt Nam qua các thời kỳ',
    N'Nguyễn Thị Đức',
    'RESEARCH',
    N'https://example.org/ao-dai-viet-nam',
    N'Tài liệu nghiên cứu về lịch sử phát triển của áo dài.',
    1
FROM dbo.BaiViet bv
WHERE bv.MaBaiViet = 'BV_AO_DAI'
  AND NOT EXISTS (
      SELECT 1 FROM dbo.NguonThamKhao x
      WHERE x.BaiVietID = bv.BaiVietID
        AND x.TieuDeNguon = N'Áo dài Việt Nam qua các thời kỳ'
  );

INSERT INTO dbo.NguonThamKhao (
    BaiVietID, TieuDeNguon, TacGia, LoaiNguon, UrlNguon, GhiChu, LaNguonChinh
)
SELECT
    bv.BaiVietID,
    N'Không gian văn hóa cồng chiêng Tây Nguyên',
    N'UNESCO / nguồn tổng hợp',
    'WEBSITE',
    N'https://whc.unesco.org/',
    N'Tài liệu tham khảo về giá trị di sản và bối cảnh bảo tồn.',
    1
FROM dbo.BaiViet bv
WHERE bv.MaBaiViet = 'BV_CONG_CHIENG_TAY_NGUYEN'
  AND NOT EXISTS (
      SELECT 1 FROM dbo.NguonThamKhao x
      WHERE x.BaiVietID = bv.BaiVietID
        AND x.TieuDeNguon = N'Không gian văn hóa cồng chiêng Tây Nguyên'
  );

/* =========================================================
   10. MẪU PROMPT
   ========================================================= */
INSERT INTO dbo.MauPrompt (MaPrompt, LoaiPrompt, TenPrompt, NoiDungPrompt, HoatDong)
SELECT
    'PROMPT_DEFINE_VI',
    'CONCEPT_EXPLAIN',
    N'Giải thích khái niệm văn hóa bằng tiếng Việt',
    N'Bạn là trợ lý giải thích văn hóa Việt Nam cho người dùng. Hãy giải thích ngắn gọn, dễ hiểu, trung thực và chỉ dựa trên dữ liệu đã được cung cấp.',
    1
WHERE NOT EXISTS (SELECT 1 FROM dbo.MauPrompt WHERE MaPrompt = 'PROMPT_DEFINE_VI');

INSERT INTO dbo.MauPrompt (MaPrompt, LoaiPrompt, TenPrompt, NoiDungPrompt, HoatDong)
SELECT
    'PROMPT_MEANING_EN',
    'CULTURAL_MEANING',
    N'Explain cultural meaning in English',
    N'You are a cultural explanation assistant. Explain the cultural meaning clearly for international users and stay within the verified context only.',
    1
WHERE NOT EXISTS (SELECT 1 FROM dbo.MauPrompt WHERE MaPrompt = 'PROMPT_MEANING_EN');

INSERT INTO dbo.MauPrompt (MaPrompt, LoaiPrompt, TenPrompt, NoiDungPrompt, HoatDong)
SELECT
    'PROMPT_COMPARE_EN',
    'COMPARE_REGION',
    N'Compare regional cultural differences',
    N'Compare cultural practices across regions carefully, avoid exaggeration, and mention that differences may vary by locality.',
    1
WHERE NOT EXISTS (SELECT 1 FROM dbo.MauPrompt WHERE MaPrompt = 'PROMPT_COMPARE_EN');

INSERT INTO dbo.MauPrompt (MaPrompt, LoaiPrompt, TenPrompt, NoiDungPrompt, HoatDong)
SELECT
    'PROMPT_SOFT_REFUSAL_EN',
    'SOFT_REFUSAL',
    N'Soft refusal when data is insufficient',
    N'When the system lacks enough verified data, respond honestly, avoid making things up, and suggest a related article if available.',
    1
WHERE NOT EXISTS (SELECT 1 FROM dbo.MauPrompt WHERE MaPrompt = 'PROMPT_SOFT_REFUSAL_EN');

/* =========================================================
   11. TỈNH THÀNH / THÀNH PHỐ
   ========================================================= */

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
    'ha-noi', N'Hà Nội', N'Hanoi', N'Thành phố trực thuộc TW', N'Municipality', vv.VungID,
    N'Đồng bằng sông Hồng', N'Red River Delta', 3358.60, 8400000,
    N'3,358 km²', N'3,358 km²', N'8.4 triệu người', N'8.4 million people',
    N'["Thủ đô","Văn hiến","Hồ Gươm"]', N'["Capital","Heritage","Hoan Kiem Lake"]',
    N'Thủ đô, Văn hiến, Hồ Gươm', N'Capital, Heritage, Hoan Kiem Lake',
    N'https://images.unsplash.com/photo-1543783230-dc081f2163b2?ixlib=rb-4.0.3&auto=format&fit=crop&w=1200&q=800',
    N'Phố cổ Hà Nội nhìn từ trên cao',
    N'Aerial view of Hanoi Old Quarter',
    N'Thủ đô nghìn năm văn hiến',
    N'The thousand-year-old capital of culture',
    N'Hà Nội là trung tâm chính trị, văn hóa và giáo dục quan trọng bậc nhất Việt Nam. Thành phố lưu giữ vẻ đẹp cổ kính của phố cổ, hồ nước, di tích lịch sử và nhịp sống thanh lịch rất riêng.',
    N'Hanoi is Vietnam''s political, cultural, and educational center. The city preserves the charm of its old quarter, lakes, historical sites, and a distinctly elegant rhythm of life.',
    N'24°C - Có mây', N'24°C - Cloudy',
    N'Tháng 8 - Tháng 11', N'August - November',
    N'1010 (Lý Thái Tổ)', N'1010 (Ly Thai To)',
    N'12 quận, 17 huyện, 1 thị xã', N'12 urban districts, 17 rural districts, 1 town',
    N'UTC+7', N'024',
    N'https://images.unsplash.com/photo-1509030450996-dd1a26dda07a?auto=format&fit=crop&w=1400&q=80',
    N'Hoàng hôn bên hồ Gươm tại Hà Nội',
    N'Sunset by Hoan Kiem Lake in Hanoi',
    N'https://images.unsplash.com/photo-1543783230-dc081f2163b2?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&q=800',
    N'Góc nhìn hành trình tại Hà Nội',
    N'Hanoi travel moment',
    N'[{"title":"Hồ Hoàn Kiếm","desc":"Trái tim của thủ đô với Tháp Rùa, đền Ngọc Sơn và không gian đi bộ cuối tuần."},{"title":"Văn Miếu - Quốc Tử Giám","desc":"Biểu tượng của truyền thống hiếu học và là trường đại học đầu tiên của Việt Nam."},{"title":"Phố Cổ Hà Nội","desc":"Không gian lưu giữ nhịp sống, nghề thủ công và ẩm thực phố lâu đời."}]',
    N'[{"title":"Hoan Kiem Lake","desc":"The symbolic heart of Hanoi with Turtle Tower, Ngoc Son Temple, and a lively walking area."},{"title":"Temple of Literature","desc":"A symbol of learning and the first university of Vietnam."},{"title":"Hanoi Old Quarter","desc":"A historic maze of streets preserving crafts, food, and urban memory."}]',
    N'["🎭 Múa rối nước","📜 Thư pháp","🍶 Gốm Bát Tràng","🎻 Ca trù","👗 Áo dài"]',
    N'["🎭 Water puppetry","📜 Calligraphy","🍶 Bat Trang ceramics","🎻 Ca tru singing","👗 Ao Dai"]',
    N'[{"title":"Phở bò Hà Nội","imageUrl":"https://images.unsplash.com/photo-1582878826629-29b7ad1cb438?q=80&w=1964&auto=format&fit=crop"},{"title":"Bún chả","imageUrl":"https://images.unsplash.com/photo-1555126634-ba092c2ddf7f?q=80&w=2070&auto=format&fit=crop"},{"title":"Chả cá Lã Vọng","imageUrl":"https://images.unsplash.com/photo-1509722747041-616f39b57569?q=80&w=2070&auto=format&fit=crop"}]',
    N'[{"title":"Hanoi Beef Pho","imageUrl":"https://images.unsplash.com/photo-1582878826629-29b7ad1cb438?q=80&w=1964&auto=format&fit=crop"},{"title":"Bun Cha","imageUrl":"https://images.unsplash.com/photo-1555126634-ba092c2ddf7f?q=80&w=2070&auto=format&fit=crop"},{"title":"Cha Ca La Vong","imageUrl":"https://images.unsplash.com/photo-1509722747041-616f39b57569?q=80&w=2070&auto=format&fit=crop"}]',
    N'[{"time":"07:30","task":"Bắt đầu ngày mới với một bát phở Hà Nội nóng hổi tại khu Phố Cổ."},{"time":"09:00","task":"Tham quan Quảng trường Ba Đình, Lăng Chủ tịch Hồ Chí Minh và Chùa Một Cột."},{"time":"14:00","task":"Khám phá Văn Miếu - Quốc Tử Giám và thưởng thức cà phê trứng."},{"time":"17:00","task":"Dạo hồ Tây, ngắm hoàng hôn và thưởng thức ẩm thực đường phố."}]',
    N'[{"time":"07:30","task":"Start your morning with a bowl of Hanoi pho in the Old Quarter."},{"time":"09:00","task":"Visit Ba Dinh Square, Ho Chi Minh Mausoleum, and One Pillar Pagoda."},{"time":"14:00","task":"Explore the Temple of Literature and enjoy Vietnamese egg coffee."},{"time":"17:00","task":"Walk around West Lake, catch the sunset, and sample local street food."}]',
    1, 1
FROM dbo.VungVanHoa vv
WHERE vv.MaVung = 'BAC_BO'
  AND NOT EXISTS (SELECT 1 FROM dbo.TinhThanh WHERE MaTinh = 'ha-noi');

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
    'hue', N'Huế', N'Hue', N'Thành phố trực thuộc tỉnh', N'Provincial city', vv.VungID,
    N'Bắc Trung Bộ', N'North Central Coast', 265.99, 455000,
    N'266 km²', N'266 km²', N'455 nghìn người', N'455 thousand people',
    N'["Cố đô","Sông Hương","Nhã nhạc"]', N'["Ancient capital","Perfume River","Royal court music"]',
    N'Cố đô, Sông Hương, Nhã nhạc', N'Ancient capital, Perfume River, Royal court music',
    N'https://images.unsplash.com/photo-1528127269322-539801943592?auto=format&fit=crop&w=1200&q=80',
    N'Đại Nội Huế nhìn từ bên ngoài',
    N'Exterior view of Hue Imperial Citadel',
    N'Cố đô mộng mơ bên dòng Hương Giang',
    N'The poetic ancient capital by the Perfume River',
    N'Huế nổi bật với chiều sâu lịch sử, hệ thống cung điện, lăng tẩm và nhã nhạc cung đình. Thành phố mang nhịp sống chậm, trầm lắng và rất giàu chiều sâu văn hóa.',
    N'Hue stands out for its historical depth, imperial architecture, royal tombs, and court music heritage. The city has a calm rhythm and a deeply cultural atmosphere.',
    N'26°C - Nắng nhẹ', N'26°C - Light sun',
    N'Tháng 1 - Tháng 4', N'January - April',
    N'1802 (Kinh đô triều Nguyễn)', N'1802 (Nguyen dynasty capital)',
    N'2 quận, 4 huyện, 2 thị xã', N'2 districts, 4 rural districts, 2 towns',
    N'UTC+7', N'234',
    N'https://images.unsplash.com/photo-1528127269322-539801943592?auto=format&fit=crop&w=1400&q=80',
    N'Không gian di sản cố đô Huế',
    N'Hue heritage landscape',
    N'https://images.unsplash.com/photo-1565967511849-76a60a516170?auto=format&fit=crop&w=800&q=80',
    N'Sông Hương và cầu Trường Tiền',
    N'Perfume River and Truong Tien Bridge',
    N'[{"title":"Đại Nội Huế","desc":"Quần thể cung điện và tường thành mang dấu ấn triều Nguyễn."},{"title":"Lăng Khải Định","desc":"Công trình giao thoa kiến trúc Á - Âu độc đáo bậc nhất Huế."},{"title":"Chùa Thiên Mụ","desc":"Biểu tượng tâm linh bên dòng sông Hương thơ mộng."}]',
    N'[{"title":"Hue Imperial Citadel","desc":"The palace complex and walls reflecting the Nguyen dynasty legacy."},{"title":"Khai Dinh Tomb","desc":"A unique fusion of Asian and European architectural styles."},{"title":"Thien Mu Pagoda","desc":"A spiritual landmark by the poetic Perfume River."}]',
    N'["🎼 Nhã nhạc cung đình","🏯 Kiến trúc hoàng cung","🕯 Lễ nghi cung đình","👘 Áo dài Huế"]',
    N'["🎼 Royal court music","🏯 Imperial architecture","🕯 Court rituals","👘 Hue Ao Dai"]',
    N'[{"title":"Bún bò Huế","imageUrl":"https://images.unsplash.com/photo-1512058564366-18510be2db19?auto=format&fit=crop&w=1000&q=80"},{"title":"Cơm hến","imageUrl":"https://images.unsplash.com/photo-1547592166-23ac45744acd?q=80&w=2071&auto=format&fit=crop"},{"title":"Chè Huế","imageUrl":"https://images.unsplash.com/photo-1504754524776-8f4f37790ca0?auto=format&fit=crop&w=1000&q=80"}]',
    N'[{"title":"Hue beef noodle soup","imageUrl":"https://images.unsplash.com/photo-1512058564366-18510be2db19?auto=format&fit=crop&w=1000&q=80"},{"title":"Com Hen","imageUrl":"https://images.unsplash.com/photo-1547592166-23ac45744acd?q=80&w=2071&auto=format&fit=crop"},{"title":"Hue sweet soups","imageUrl":"https://images.unsplash.com/photo-1504754524776-8f4f37790ca0?auto=format&fit=crop&w=1000&q=80"}]',
    N'[{"time":"08:00","task":"Tham quan Đại Nội và tìm hiểu lịch sử triều Nguyễn."},{"time":"11:30","task":"Thưởng thức bún bò Huế và các món ăn cung đình."},{"time":"15:00","task":"Ghé lăng Khải Định hoặc lăng Minh Mạng."},{"time":"18:00","task":"Đi thuyền trên sông Hương và nghe ca Huế."}]',
    N'[{"time":"08:00","task":"Visit the Imperial Citadel and explore Nguyen dynasty history."},{"time":"11:30","task":"Enjoy bun bo Hue and refined royal cuisine."},{"time":"15:00","task":"Stop by Khai Dinh or Minh Mang Tomb."},{"time":"18:00","task":"Take a Perfume River boat ride and enjoy Hue traditional music."}]',
    1, 2
FROM dbo.VungVanHoa vv
WHERE vv.MaVung = 'TRUNG_BO'
  AND NOT EXISTS (SELECT 1 FROM dbo.TinhThanh WHERE MaTinh = 'hue');

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
    'can-tho', N'Cần Thơ', N'Can Tho', N'Thành phố trực thuộc TW', N'Municipality', vv.VungID,
    N'Đồng bằng sông Cửu Long', N'Mekong Delta', 1438.96, 1240000,
    N'1,439 km²', N'1,439 km²', N'1.24 triệu người', N'1.24 million people',
    N'["Chợ nổi","Sông nước","Ẩm thực"]', N'["Floating market","River life","Cuisine"]',
    N'Chợ nổi, Sông nước, Ẩm thực', N'Floating market, River life, Cuisine',
    N'https://images.unsplash.com/photo-1604577844302-37f54c62bd16?auto=format&fit=crop&w=1200&q=80',
    N'Chợ nổi miền Tây tại Cần Thơ',
    N'Floating market in Can Tho',
    N'Thủ phủ miền Tây sông nước',
    N'The lively heart of the Mekong Delta',
    N'Cần Thơ là trung tâm quan trọng của đồng bằng sông Cửu Long với hệ thống sông ngòi, chợ nổi và đời sống miệt vườn đặc trưng. Thành phố mang vẻ đẹp gần gũi, chan hòa và trù phú.',
    N'Can Tho is a key city of the Mekong Delta, known for its rivers, floating markets, and orchard life. It offers a warm, fertile, and welcoming atmosphere.',
    N'29°C - Nắng đẹp', N'29°C - Sunny',
    N'Tháng 12 - Tháng 4', N'December - April',
    N'2004 (trực thuộc TW)', N'2004 (municipality status)',
    N'5 quận, 4 huyện', N'5 urban districts, 4 rural districts',
    N'UTC+7', N'292',
    N'https://images.unsplash.com/photo-1604577844302-37f54c62bd16?auto=format&fit=crop&w=1400&q=80',
    N'Khung cảnh sông nước Cần Thơ',
    N'Can Tho river landscape',
    N'https://images.unsplash.com/photo-1582230842845-6f6eb3906385?auto=format&fit=crop&w=800&q=80',
    N'Trọng tâm đời sống sông nước miền Tây',
    N'Mekong riverside city life',
    N'[{"title":"Chợ nổi Cái Răng","desc":"Biểu tượng của văn hóa mua bán trên sông ở miền Tây Nam Bộ."},{"title":"Bến Ninh Kiều","desc":"Không gian ven sông thơ mộng, sôi động về đêm."},{"title":"Vườn trái cây Phong Điền","desc":"Trải nghiệm miệt vườn xanh mát và trái cây theo mùa."}]',
    N'[{"title":"Cai Rang Floating Market","desc":"A signature example of river-based trading culture in the Mekong Delta."},{"title":"Ninh Kieu Wharf","desc":"A lively and scenic riverside promenade, especially charming at night."},{"title":"Phong Dien Orchards","desc":"A green countryside escape with seasonal tropical fruits."}]',
    N'["🛶 Chợ nổi","🎶 Đờn ca tài tử","🌾 Miệt vườn","🍃 Đời sống ven sông"]',
    N'["🛶 Floating markets","🎶 Southern folk music","🌾 Orchard life","🍃 Riverside living"]',
    N'[{"title":"Lẩu mắm","imageUrl":"https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?auto=format&fit=crop&w=1000&q=80"},{"title":"Bánh xèo miền Tây","imageUrl":"https://images.unsplash.com/photo-1547592180-85f173990554?auto=format&fit=crop&w=1000&q=80"},{"title":"Trái cây miệt vườn","imageUrl":"https://images.unsplash.com/photo-1610832958506-aa56368176cf?auto=format&fit=crop&w=1000&q=80"}]',
    N'[{"title":"Fermented fish hotpot","imageUrl":"https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?auto=format&fit=crop&w=1000&q=80"},{"title":"Mekong-style banh xeo","imageUrl":"https://images.unsplash.com/photo-1547592180-85f173990554?auto=format&fit=crop&w=1000&q=80"},{"title":"Orchard fruits","imageUrl":"https://images.unsplash.com/photo-1610832958506-aa56368176cf?auto=format&fit=crop&w=1000&q=80"}]',
    N'[{"time":"06:00","task":"Đi thuyền ra chợ nổi Cái Răng để cảm nhận nhịp sống sông nước buổi sớm."},{"time":"09:30","task":"Tham quan vườn trái cây và thưởng thức đặc sản tại Phong Điền."},{"time":"15:00","task":"Dạo bến Ninh Kiều và ghé chợ đêm."},{"time":"18:30","task":"Thưởng thức đờn ca tài tử và ẩm thực miền Tây."}]',
    N'[{"time":"06:00","task":"Take a boat to Cai Rang Floating Market and experience the morning river trade."},{"time":"09:30","task":"Visit orchards in Phong Dien and taste local fruits."},{"time":"15:00","task":"Walk around Ninh Kieu Wharf and explore the night market."},{"time":"18:30","task":"Enjoy southern folk music and Mekong cuisine."}]',
    1, 3
FROM dbo.VungVanHoa vv
WHERE vv.MaVung = 'NAM_BO'
  AND NOT EXISTS (SELECT 1 FROM dbo.TinhThanh WHERE MaTinh = 'can-tho');

/* =========================================================
   12. NHẬT KÝ CÂU HỎI AI
   ========================================================= */
INSERT INTO dbo.NhatKyCauHoiAI (
    BaiVietNguCanhID, NgonNguCauHoi, NoiDungCauHoi, LoaiYDinh,
    CauTraLoi, TrangThaiTraLoi, DiemTinCay, MauPromptID, CanBoSungNoiDung
)
SELECT
    bv.BaiVietID,
    'EN',
    N'Why do Vietnamese people celebrate Tet?',
    'MEANING',
    N'Vietnamese people celebrate Tet to mark the lunar new year, reunite with family, honor ancestors, and express hopes for a fresh start.',
    'SUCCESS',
    0.95,
    mp.MauPromptID,
    0
FROM dbo.BaiViet bv
JOIN dbo.MauPrompt mp ON mp.MaPrompt = 'PROMPT_MEANING_EN'
WHERE bv.MaBaiViet = 'BV_TET_NGUYEN_DAN'
  AND NOT EXISTS (
      SELECT 1 FROM dbo.NhatKyCauHoiAI x
      WHERE x.NoiDungCauHoi = N'Why do Vietnamese people celebrate Tet?'
  );

INSERT INTO dbo.NhatKyCauHoiAI (
    BaiVietNguCanhID, NgonNguCauHoi, NoiDungCauHoi, LoaiYDinh,
    CauTraLoi, TrangThaiTraLoi, DiemTinCay, MauPromptID, CanBoSungNoiDung
)
SELECT
    bv.BaiVietID,
    'EN',
    N'What does Ao Dai symbolize in Vietnamese culture?',
    'MEANING',
    N'Ao Dai symbolizes elegance, cultural identity and the continuity between tradition and modern life in Vietnam.',
    'SUCCESS',
    0.92,
    mp.MauPromptID,
    0
FROM dbo.BaiViet bv
JOIN dbo.MauPrompt mp ON mp.MaPrompt = 'PROMPT_MEANING_EN'
WHERE bv.MaBaiViet = 'BV_AO_DAI'
  AND NOT EXISTS (
      SELECT 1 FROM dbo.NhatKyCauHoiAI x
      WHERE x.NoiDungCauHoi = N'What does Ao Dai symbolize in Vietnamese culture?'
  );

INSERT INTO dbo.NhatKyCauHoiAI (
    BaiVietNguCanhID, NgonNguCauHoi, NoiDungCauHoi, LoaiYDinh,
    CauTraLoi, TrangThaiTraLoi, DiemTinCay, MauPromptID, CanBoSungNoiDung
)
SELECT
    bv.BaiVietID,
    'VI',
    N'Cồng chiêng Tây Nguyên có ý nghĩa gì?',
    'MEANING',
    N'Cồng chiêng không chỉ là nhạc cụ mà còn gắn với đời sống tâm linh, nghi lễ và bản sắc cộng đồng của các dân tộc Tây Nguyên.',
    'LOW_CONFIDENCE',
    0.68,
    mp.MauPromptID,
    1
FROM dbo.BaiViet bv
JOIN dbo.MauPrompt mp ON mp.MaPrompt = 'PROMPT_DEFINE_VI'
WHERE bv.MaBaiViet = 'BV_CONG_CHIENG_TAY_NGUYEN'
  AND NOT EXISTS (
      SELECT 1 FROM dbo.NhatKyCauHoiAI x
      WHERE x.NoiDungCauHoi = N'Cồng chiêng Tây Nguyên có ý nghĩa gì?'
  );

INSERT INTO dbo.NhatKyCauHoiAI (
    BaiVietNguCanhID, NgonNguCauHoi, NoiDungCauHoi, LoaiYDinh,
    CauTraLoi, TrangThaiTraLoi, DiemTinCay, MauPromptID, CanBoSungNoiDung
)
SELECT
    NULL,
    'EN',
    N'Is every Vietnamese festival the same across all regions?',
    'COMPARE',
    N'Not necessarily. Many festivals share common themes, but rituals, foods, timing and local meanings can differ by region and community.',
    'SUCCESS',
    0.84,
    mp.MauPromptID,
    0
FROM dbo.MauPrompt mp
WHERE mp.MaPrompt = 'PROMPT_COMPARE_EN'
  AND NOT EXISTS (
      SELECT 1 FROM dbo.NhatKyCauHoiAI x
      WHERE x.NoiDungCauHoi = N'Is every Vietnamese festival the same across all regions?'
  );

/* =========================================================
   12. PHẢN HỒI NGƯỜI DÙNG
   ========================================================= */
INSERT INTO dbo.PhanHoiNguoiDung (
    BaiVietID, CauHoiID, DoiTuongPhanHoi, DiemDanhGia, HuuIch, NoiDungPhanHoi, TrangThaiXuLy
)
SELECT
    bv.BaiVietID,
    NULL,
    'ARTICLE',
    5,
    1,
    N'Bài viết dễ hiểu, có nội dung song ngữ rõ ràng và phù hợp với người nước ngoài.',
    'RESOLVED'
FROM dbo.BaiViet bv
WHERE bv.MaBaiViet = 'BV_TET_NGUYEN_DAN'
  AND NOT EXISTS (
      SELECT 1 FROM dbo.PhanHoiNguoiDung x
      WHERE x.BaiVietID = bv.BaiVietID
        AND x.DoiTuongPhanHoi = 'ARTICLE'
        AND x.NoiDungPhanHoi = N'Bài viết dễ hiểu, có nội dung song ngữ rõ ràng và phù hợp với người nước ngoài.'
  );

INSERT INTO dbo.PhanHoiNguoiDung (
    BaiVietID, CauHoiID, DoiTuongPhanHoi, DiemDanhGia, HuuIch, NoiDungPhanHoi, TrangThaiXuLy
)
SELECT
    NULL,
    q.CauHoiID,
    'AI_ANSWER',
    4,
    1,
    N'Câu trả lời ngắn gọn và đúng trọng tâm, nhưng có thể bổ sung thêm ví dụ vùng miền.',
    'OPEN'
FROM dbo.NhatKyCauHoiAI q
WHERE q.NoiDungCauHoi = N'Why do Vietnamese people celebrate Tet?'
  AND NOT EXISTS (
      SELECT 1 FROM dbo.PhanHoiNguoiDung x
      WHERE x.CauHoiID = q.CauHoiID
        AND x.DoiTuongPhanHoi = 'AI_ANSWER'
  );

INSERT INTO dbo.PhanHoiNguoiDung (
    BaiVietID, CauHoiID, DoiTuongPhanHoi, DiemDanhGia, HuuIch, NoiDungPhanHoi, TrangThaiXuLy
)
SELECT
    NULL,
    q.CauHoiID,
    'AI_ANSWER',
    3,
    0,
    N'Nội dung hữu ích nhưng tôi vẫn chưa hiểu rõ bối cảnh nghi lễ và vai trò cộng đồng.',
    'IN_PROGRESS'
FROM dbo.NhatKyCauHoiAI q
WHERE q.NoiDungCauHoi = N'Cồng chiêng Tây Nguyên có ý nghĩa gì?'
  AND NOT EXISTS (
      SELECT 1 FROM dbo.PhanHoiNguoiDung x
      WHERE x.CauHoiID = q.CauHoiID
        AND x.DoiTuongPhanHoi = 'AI_ANSWER'
  );

/* =========================================================
   13. NHẬT KÝ TÌM KIẾM
   ========================================================= */
INSERT INTO dbo.NhatKyTimKiem (TuKhoaTimKiem, NgonNguTimKiem, SoKetQua)
SELECT N'tet holiday vietnam', 'EN', 3
WHERE NOT EXISTS (
    SELECT 1 FROM dbo.NhatKyTimKiem
    WHERE TuKhoaTimKiem = N'tet holiday vietnam'
);

INSERT INTO dbo.NhatKyTimKiem (TuKhoaTimKiem, NgonNguTimKiem, SoKetQua)
SELECT N'áo dài có ý nghĩa gì', 'VI', 1
WHERE NOT EXISTS (
    SELECT 1 FROM dbo.NhatKyTimKiem
    WHERE TuKhoaTimKiem = N'áo dài có ý nghĩa gì'
);

INSERT INTO dbo.NhatKyTimKiem (TuKhoaTimKiem, NgonNguTimKiem, SoKetQua)
SELECT N'gong culture central highlands', 'EN', 1
WHERE NOT EXISTS (
    SELECT 1 FROM dbo.NhatKyTimKiem
    WHERE TuKhoaTimKiem = N'gong culture central highlands'
);

/* =========================================================
   14. NHẬT KÝ XEM BÀI VIẾT
   ========================================================= */
INSERT INTO dbo.NhatKyXemBaiViet (BaiVietID, NgonNguXem)
SELECT bv.BaiVietID, 'EN'
FROM dbo.BaiViet bv
WHERE bv.MaBaiViet = 'BV_TET_NGUYEN_DAN'
  AND NOT EXISTS (
      SELECT 1 FROM dbo.NhatKyXemBaiViet x
      WHERE x.BaiVietID = bv.BaiVietID AND x.NgonNguXem = 'EN'
  );

INSERT INTO dbo.NhatKyXemBaiViet (BaiVietID, NgonNguXem)
SELECT bv.BaiVietID, 'VI'
FROM dbo.BaiViet bv
WHERE bv.MaBaiViet = 'BV_AO_DAI'
  AND NOT EXISTS (
      SELECT 1 FROM dbo.NhatKyXemBaiViet x
      WHERE x.BaiVietID = bv.BaiVietID AND x.NgonNguXem = 'VI'
  );

INSERT INTO dbo.NhatKyXemBaiViet (BaiVietID, NgonNguXem)
SELECT bv.BaiVietID, 'EN'
FROM dbo.BaiViet bv
WHERE bv.MaBaiViet = 'BV_CONG_CHIENG_TAY_NGUYEN'
  AND NOT EXISTS (
      SELECT 1 FROM dbo.NhatKyXemBaiViet x
      WHERE x.BaiVietID = bv.BaiVietID AND x.NgonNguXem = 'EN'
  );

/* =========================================================
   15. LỊCH SỬ DUYỆT / TRUY VẾT
   ========================================================= */
INSERT INTO dbo.LichSuDuyetBaiViet (
    BaiVietID, HanhDong, TuTrangThai, DenTrangThai, GhiChu, ThucHienBoi
)
SELECT
    bv.BaiVietID, 'CREATE', NULL, 'DRAFT',
    N'Tạo bài viết ban đầu.',
    nd.NguoiDungID
FROM dbo.BaiViet bv
JOIN dbo.NguoiDung nd ON nd.Email = 'content@vnculturebridge.ai'
WHERE bv.MaBaiViet = 'BV_TET_NGUYEN_DAN'
  AND NOT EXISTS (
      SELECT 1 FROM dbo.LichSuDuyetBaiViet x
      WHERE x.BaiVietID = bv.BaiVietID AND x.HanhDong = 'CREATE'
  );

INSERT INTO dbo.LichSuDuyetBaiViet (
    BaiVietID, HanhDong, TuTrangThai, DenTrangThai, GhiChu, ThucHienBoi
)
SELECT
    bv.BaiVietID, 'SUBMIT_REVIEW', 'DRAFT', 'PENDING_REVIEW',
    N'Gửi bài viết sang bước kiểm duyệt.',
    nd.NguoiDungID
FROM dbo.BaiViet bv
JOIN dbo.NguoiDung nd ON nd.Email = 'content@vnculturebridge.ai'
WHERE bv.MaBaiViet IN ('BV_TET_NGUYEN_DAN', 'BV_AO_DAI', 'BV_CONG_CHIENG_TAY_NGUYEN', 'BV_DAM_TRAU')
  AND NOT EXISTS (
      SELECT 1 FROM dbo.LichSuDuyetBaiViet x
      WHERE x.BaiVietID = bv.BaiVietID AND x.HanhDong = 'SUBMIT_REVIEW'
  );

INSERT INTO dbo.LichSuDuyetBaiViet (
    BaiVietID, HanhDong, TuTrangThai, DenTrangThai, GhiChu, ThucHienBoi
)
SELECT
    bv.BaiVietID, 'APPROVE', 'PENDING_REVIEW', 'APPROVED',
    N'Bài viết đạt yêu cầu và được duyệt.',
    nd.NguoiDungID
FROM dbo.BaiViet bv
JOIN dbo.NguoiDung nd ON nd.Email = 'reviewer@vnculturebridge.ai'
WHERE bv.MaBaiViet IN ('BV_TET_NGUYEN_DAN', 'BV_AO_DAI')
  AND NOT EXISTS (
      SELECT 1 FROM dbo.LichSuDuyetBaiViet x
      WHERE x.BaiVietID = bv.BaiVietID AND x.HanhDong = 'APPROVE'
  );

INSERT INTO dbo.LichSuDuyetBaiViet (
    BaiVietID, HanhDong, TuTrangThai, DenTrangThai, GhiChu, ThucHienBoi
)
SELECT
    bv.BaiVietID, 'PUBLISH', 'APPROVED', 'PUBLISHED',
    N'Xuất bản bài viết ra hệ thống công khai.',
    nd.NguoiDungID
FROM dbo.BaiViet bv
JOIN dbo.NguoiDung nd ON nd.Email = 'reviewer@vnculturebridge.ai'
WHERE bv.MaBaiViet IN ('BV_TET_NGUYEN_DAN', 'BV_AO_DAI')
  AND NOT EXISTS (
      SELECT 1 FROM dbo.LichSuDuyetBaiViet x
      WHERE x.BaiVietID = bv.BaiVietID AND x.HanhDong = 'PUBLISH'
  );

INSERT INTO dbo.LichSuDuyetBaiViet (
    BaiVietID, HanhDong, TuTrangThai, DenTrangThai, GhiChu, ThucHienBoi
)
SELECT
    bv.BaiVietID, 'REJECT', 'PENDING_REVIEW', 'REJECTED',
    N'Nội dung nhạy cảm, cần bổ sung nguồn tham khảo và cách diễn giải trung tính hơn.',
    nd.NguoiDungID
FROM dbo.BaiViet bv
JOIN dbo.NguoiDung nd ON nd.Email = 'reviewer@vnculturebridge.ai'
WHERE bv.MaBaiViet = 'BV_DAM_TRAU'
  AND NOT EXISTS (
      SELECT 1 FROM dbo.LichSuDuyetBaiViet x
      WHERE x.BaiVietID = bv.BaiVietID AND x.HanhDong = 'REJECT'
  );

/* =========================================================
   16. DỮ LIỆU BỔ SUNG CHO HOMEPAGE PUBLIC
   ========================================================= */

INSERT INTO dbo.DanToc (MaDanToc, TenVI, TenEN, MoTaVI, MoTaEN, HoatDong)
SELECT 'KHMER', N'Khmer', N'Khmer',
       N'Cộng đồng Khmer tập trung nhiều ở Nam Bộ, nổi bật với chùa Phật giáo Nam tông, lễ hội và nghệ thuật sân khấu dân gian.',
       N'The Khmer community is concentrated in southern Vietnam and is known for Theravada Buddhist temples, festivals, and folk performance traditions.',
       1
WHERE NOT EXISTS (SELECT 1 FROM dbo.DanToc WHERE MaDanToc = 'KHMER');

INSERT INTO dbo.DanToc (MaDanToc, TenVI, TenEN, MoTaVI, MoTaEN, HoatDong)
SELECT 'CHAM', N'Chăm', N'Cham',
       N'Dân tộc Chăm có bề dày lịch sử ở miền Trung, gắn với di sản kiến trúc, tín ngưỡng và nghề dệt thủ công.',
       N'The Cham people have a long history in central Vietnam, associated with architecture, spirituality, and textile craftsmanship.',
       1
WHERE NOT EXISTS (SELECT 1 FROM dbo.DanToc WHERE MaDanToc = 'CHAM');

INSERT INTO dbo.DanToc (MaDanToc, TenVI, TenEN, MoTaVI, MoTaEN, HoatDong)
SELECT 'DAO', N'Dao', N'Dao',
       N'Dân tộc Dao nổi bật với trang phục thêu tay, nghi lễ cấp sắc và tri thức dân gian về dược liệu.',
       N'The Dao people are known for embroidered attire, initiation rituals, and traditional herbal knowledge.',
       1
WHERE NOT EXISTS (SELECT 1 FROM dbo.DanToc WHERE MaDanToc = 'DAO');

INSERT INTO dbo.TuKhoa (MaTuKhoa, GiaTriVI, GiaTriEN, HoatDong)
SELECT 'TRUNG_THU', N'Tết Trung Thu', N'Mid-Autumn Festival', 1
WHERE NOT EXISTS (SELECT 1 FROM dbo.TuKhoa WHERE MaTuKhoa = 'TRUNG_THU');

INSERT INTO dbo.TuKhoa (MaTuKhoa, GiaTriVI, GiaTriEN, HoatDong)
SELECT 'PHO', N'Phở', N'Pho', 1
WHERE NOT EXISTS (SELECT 1 FROM dbo.TuKhoa WHERE MaTuKhoa = 'PHO');

INSERT INTO dbo.TuKhoa (MaTuKhoa, GiaTriVI, GiaTriEN, HoatDong)
SELECT 'BANH_MI', N'Bánh mì', N'Banh Mi', 1
WHERE NOT EXISTS (SELECT 1 FROM dbo.TuKhoa WHERE MaTuKhoa = 'BANH_MI');

INSERT INTO dbo.TuKhoa (MaTuKhoa, GiaTriVI, GiaTriEN, HoatDong)
SELECT 'MUA_ROI_NUOC', N'Múa rối nước', N'Water Puppetry', 1
WHERE NOT EXISTS (SELECT 1 FROM dbo.TuKhoa WHERE MaTuKhoa = 'MUA_ROI_NUOC');

/* =========================================================
   6A. DỮ LIỆU TRANG LỄ HỘI ĐỘNG
   ========================================================= */
INSERT INTO dbo.LeHoi (
    MaLeHoi, LoaiBanGhi, ThuTuHienThi,
    PageBadgeVI, PageBadgeEN,
    PageTitleLine1VI, PageTitleLine1EN,
    PageTitleAccentVI, PageTitleAccentEN,
    PageTitleLine3VI, PageTitleLine3EN,
    PageSubtitleVI, PageSubtitleEN,
    PageStatsJsonVI, PageStatsJsonEN,
    TimelineItemsJsonVI, TimelineItemsJsonEN,
    GalleryImagesJsonVI, GalleryImagesJsonEN,
    PageHeroImageUrl, PageHeroImageAltVI, PageHeroImageAltEN,
    SearchPlaceholderVI, SearchPlaceholderEN,
    FilterButtonVI, FilterButtonEN,
    AllRegionsVI, AllRegionsEN,
    AllMonthsVI, AllMonthsEN,
    AllCategoriesVI, AllCategoriesEN,
    AllEthnicGroupsVI, AllEthnicGroupsEN,
    MajorBadgeVI, MajorBadgeEN,
    MajorTitleVI, MajorTitleEN,
    MajorSubtitleVI, MajorSubtitleEN,
    AllTitleVI, AllTitleEN,
    AllSubtitleVI, AllSubtitleEN,
    TimelineBadgeVI, TimelineBadgeEN,
    TimelineTitleVI, TimelineTitleEN,
    TimelineSubtitleVI, TimelineSubtitleEN,
    TimelineHintVI, TimelineHintEN,
    GalleryBadgeVI, GalleryBadgeEN,
    GalleryTitleVI, GalleryTitleEN,
    GallerySubtitleVI, GallerySubtitleEN,
    MeaningBadgeVI, MeaningBadgeEN,
    MeaningTitleVI, MeaningTitleEN,
    MeaningParagraphsJsonVI, MeaningParagraphsJsonEN,
    MeaningButtonVI, MeaningButtonEN, MeaningButtonHref,
    QuoteTitleVI, QuoteTitleEN,
    QuoteSubtitleVI, QuoteSubtitleEN,
    QuoteDescVI, QuoteDescEN,
    QuoteButtonVI, QuoteButtonEN,
    QuoteBackgroundImageUrl, QuoteBackgroundImageAltVI, QuoteBackgroundImageAltEN,
    HoatDong
)
SELECT
    'LE_HOI_PAGE', 'PAGE', 0,
    N'Lễ hội · Văn hóa · Truyền thống', N'Festivals · Culture · Traditions',
    N'Tinh hoa', N'Essence of',
    N'Lễ hội', N'Festivals',
    N'Việt Nam', N'Vietnam',
    N'Hàng nghìn năm truyền thống hội tụ trong từng lễ hội — nơi sắc màu, âm thanh và tâm hồn Việt hòa quyện thành một.',
    N'Thousands of years of tradition converge in every festival — where colors, sounds, and the Vietnamese spirit unite as one.',
    N'[{"value":"8.000+","label":"Lễ hội hàng năm"},{"value":"54","label":"Dân tộc anh em"},{"value":"63","label":"Tỉnh thành"}]',
    N'[{"value":"8,000+","label":"Annual festivals"},{"value":"54","label":"Ethnic groups"},{"value":"63","label":"Provinces"}]',
    N'[
      {"id":1,"month":"Tháng 1","title":"Tết Nguyên Đán","season":"Mùa xuân","color":"#e11d48","image":"/images/banner1.jpg"},
      {"id":2,"month":"Tháng 3","title":"Lễ hội Hoa Ban","season":"Mùa xuân","color":"#8b5cf6","image":"/images/festival_spring.png"},
      {"id":3,"month":"Tháng 4","title":"Giỗ Tổ Hùng Vương","season":"Mùa xuân","color":"#ea580c","image":"/images/giotohungvuong1.PNG"},
      {"id":4,"month":"Tháng 6","title":"Festival Huế","season":"Mùa hạ","color":"#10b981","image":"/images/festival_hue.png"},
      {"id":5,"month":"Tháng 9","title":"Tết Trung Thu","season":"Mùa thu","color":"#d946ef","image":"/images/banner2.jpg"},
      {"id":6,"month":"Tháng 10","title":"Lễ hội Katê","season":"Mùa thu","color":"#f59e0b","image":"/images/cham.jpg"},
      {"id":7,"month":"Tháng 12","title":"Nghinh Ông","season":"Mùa đông","color":"#6366f1","image":"/images/banner3.jpg"}
    ]',
    N'[]',
    N'[
      {"imageUrl":"/images/banner2.jpg","alt":"Khoảnh khắc lễ hội truyền thống Việt Nam"},
      {"imageUrl":"/images/banner1.jpg","alt":"Không gian lễ hội mùa xuân"},
      {"imageUrl":"/images/festival_banner.jpg","alt":"Hoạt động cộng đồng trong lễ hội"},
      {"imageUrl":"/images/banner3.jpg","alt":"Nghi thức truyền thống trong lễ hội"},
      {"imageUrl":"/images/festival_hue.png","alt":"Festival Huế"},
      {"imageUrl":"/images/giotohungvuong1.PNG","alt":"Giỗ Tổ Hùng Vương"},
      {"imageUrl":"/images/hmong_festival_gau_tao_1775575986843.png","alt":"Lễ hội Gầu Tào"},
      {"imageUrl":"/images/hat-quan-ho.png","alt":"Dân ca Quan họ"},
      {"imageUrl":"/images/cham.jpg","alt":"Không gian văn hóa Chăm trong lễ hội"}
    ]',
    N'[]',
    N'/images/festival_banner.jpg', N'Ảnh bìa trang lễ hội Việt Nam', N'Festival page hero image',
    N'Tìm kiếm lễ hội, nghi lễ và truyền thống...', N'Search festivals, rituals, and traditions...',
    N'Bộ lọc nâng cao', N'Advanced Filters',
    N'Tất cả khu vực', N'All regions',
    N'Tất cả tháng', N'All months',
    N'Tất cả loại hình', N'All categories',
    N'Tất cả nhóm trải nghiệm', N'All experience groups',
    N'Lễ hội nổi bật', N'Featured celebrations',
    N'Lễ hội tiêu biểu', N'Major festivals',
    N'Khám phá những lễ hội nổi bật và có sức lan tỏa mạnh mẽ trong văn hóa Việt Nam.',
    N'Discover Vietnam''s most important cultural celebrations.',
    N'Khám phá các lễ hội Việt Nam', N'Explore Vietnamese festivals',
    N'Mở từng trang để xem nội dung lễ hội tương ứng được tải động từ hệ thống.',
    N'Open each page to view festival content loaded dynamically from the system.',
    N'Lễ hội quanh năm', N'Year-round celebrations',
    N'Dòng thời gian lễ hội', N'Festival timeline',
    N'Khám phá nhịp điệu văn hóa Việt Nam qua từng mùa trong năm.',
    N'Experience the rhythm of Vietnamese culture throughout the year.',
    N'Cuộn ngang để xem thêm →', N'Scroll horizontally →',
    N'Hành trình thị giác', N'Visual journey',
    N'Khoảnh khắc lễ hội', N'Gallery of moments',
    N'Đắm mình trong bầu không khí và cảm xúc của những mùa lễ hội Việt Nam.',
    N'Immerse yourself in the atmosphere and emotion of Vietnamese festivals.',
    N'Ý nghĩa văn hóa', N'Cultural meaning',
    N'Linh hồn của lễ hội Việt', N'The soul of Vietnamese festivals',
    N'[
      "Lễ hội Việt Nam không chỉ là những ngày vui mà còn là nơi kết nối con người với cội nguồn, vùng đất và ký ức cộng đồng.",
      "Mỗi nghi thức, biểu tượng và hoạt động trong lễ hội đều phản ánh chiều sâu văn hóa, niềm tin và tinh thần gắn kết của người Việt.",
      "Khi tham gia lễ hội, chúng ta không chỉ quan sát mà còn trực tiếp cảm nhận nhịp sống văn hóa đang tiếp tục được lưu truyền qua nhiều thế hệ."
    ]',
    N'[]',
    N'Tìm hiểu thêm về văn hóa Việt', N'Learn more about Vietnamese culture', N'/articles',
    N'Uống nước nhớ nguồn', N'Remember the source',
    N'Nhớ về cội nguồn để gìn giữ giá trị văn hóa', N'Remembering the roots to preserve cultural values',
    N'Tinh thần biết ơn cội nguồn chính là nền tảng để các lễ hội Việt Nam tiếp tục sống động trong đời sống hôm nay.',
    N'The spirit of gratitude toward one''s roots is the foundation that keeps Vietnamese festivals alive today.',
    N'Khám phá văn hóa', N'Discover culture',
    N'/images/banner1.jpg', N'Ảnh nền trích dẫn trang lễ hội', N'Festival quote background',
    1
WHERE NOT EXISTS (SELECT 1 FROM dbo.LeHoi WHERE MaLeHoi = 'LE_HOI_PAGE');

INSERT INTO dbo.LeHoi (
    MaLeHoi, LoaiBanGhi, ThuTuHienThi,
    TieuDeVI, TieuDeEN, TieuDePhuVI, TieuDePhuEN,
    ShortTitleVI, ShortTitleEN,
    MoTaNganVI, MoTaNganEN,
    HeroDescVI, HeroDescEN,
    ViTriVI, ViTriEN,
    NgayLeVI, NgayLeEN,
    TagVI, TagEN, TagColor,
    ImageUrl, ImageAltVI, ImageAltEN,
    TimelineMonthVI, TimelineMonthEN,
    TimelineSeasonVI, TimelineSeasonEN,
    TimelineImageUrl, TimelineImageAltVI, TimelineImageAltEN,
    TimelineColor,
    NoiDungJsonVI, NoiDungJsonEN,
    HoatDong
)
SELECT * FROM (VALUES
(
    'tet-nguyen-dan','FESTIVAL',1,
    N'Tết Nguyên Đán',N'Lunar New Year',N'Tết cổ truyền Việt Nam',N'Vietnamese traditional Tet',
    N'Tết',N'Tet',
    N'Lễ tết quan trọng nhất trong năm của người Việt, gắn với đoàn viên gia đình và khởi đầu năm mới.',
    N'The most important annual holiday in Vietnam, associated with family reunion and the beginning of a new year.',
    N'Lễ hội lớn nhất trong năm, tôn vinh đoàn viên, tổ tiên và khởi đầu mới.',
    N'The largest annual festival celebrating reunion, ancestors, and new beginnings.',
    N'Toàn quốc',N'Nationwide',
    N'Tháng 1 - Tháng 2',N'January - February',
    N'Lễ hội lớn',N'Major festival','#ce112d',
    N'/images/banner1.jpg',N'Tết Nguyên Đán',N'Tet',
    N'Tháng 1',N'January',
    N'Mùa xuân',N'Spring',
    N'/images/banner1.jpg',N'Tết Nguyên Đán',N'Tet',
    '#e11d48',
    N'{
      "whatIsItContext":[
        "Tết Nguyên Đán là dịp chuyển giao giữa năm cũ và năm mới theo âm lịch, gắn với tinh thần đoàn viên, tưởng nhớ tổ tiên và khởi đầu một chu kỳ sống mới.",
        "Trong những ngày Tết, các gia đình dọn dẹp nhà cửa, chuẩn bị mâm cỗ, trang hoàng không gian sống và dành thời gian sum họp bên nhau."
      ],
      "quickFacts":{"date":"Cuối tháng Chạp đến đầu tháng Giêng âm lịch","location":"Toàn quốc","participants":"Mọi gia đình và cộng đồng"},
      "howItIsCelebrated":[
        {"phase":"Chuẩn bị","title":"Dọn dẹp và sắm Tết","desc":["Người Việt sửa soạn nhà cửa, mua hoa, gói bánh và chuẩn bị lễ vật cúng ông bà.","Không khí Tết bắt đầu từ những ngày cuối năm khi chợ hoa, phố phường và từng gia đình đều rộn ràng chuẩn bị."],"image":"/images/anhtet1.PNG","align":"left"},
        {"phase":"Giao thừa","title":"Khoảnh khắc chuyển năm","desc":["Đêm giao thừa là thời khắc linh thiêng để cúng tổ tiên, cầu bình an và chào đón năm mới.","Nhiều gia đình quây quần bên nhau, nghe lời chúc đầu năm và tận hưởng cảm giác mở đầu mới mẻ."],"image":"/images/banner2.jpg","align":"right"},
        {"phase":"Đầu xuân","title":"Chúc Tết và du xuân","desc":["Mọi người thăm hỏi họ hàng, lì xì trẻ em, đi lễ chùa và tham gia các hoạt động hội xuân.","Những nghi thức đầu năm thể hiện sự gắn kết gia đình, niềm tin vào may mắn và ước vọng tốt đẹp."],"image":"/images/banner3.jpg","align":"left"}
      ],
      "whatTetFeelsLike":{"leftText":["Đường phố: Ngập tràn sắc đỏ, đào, mai và không khí nô nức đón xuân.","Âm thanh: Tiếng chúc Tết, tiếng cười nói, tiếng nhạc xuân và nhịp điệu hội hè vang lên khắp nơi.","Nhịp sống: Từ tất bật chuẩn bị chuyển sang khoảnh khắc sum họp, ấm áp và đầy hy vọng."],"rightText":["Mái nhà: Được trang hoàng sạch đẹp với mâm ngũ quả, câu đối và bàn thờ tổ tiên tươm tất.","Cảm xúc: Là sự hòa quyện giữa hoài niệm, biết ơn và mong ước cho một năm bình an hơn.","Trải nghiệm: Dù ở thành thị hay nông thôn, Tết luôn tạo cảm giác thuộc về và gắn kết rất sâu sắc."],"image":"/images/festival_banner.jpg"},
      "keyTraditionsDocs":[{"image":"/images/banner2.jpg","title":"Lì xì đầu năm","desc":"Phong tục mừng tuổi mang lời chúc may mắn, sức khỏe và thành công."},{"image":"/images/banner3.jpg","title":"Bánh chưng - bánh tét","desc":"Món ăn biểu tượng của Tết, thể hiện sự biết ơn với đất trời và tổ tiên."},{"image":"/images/anhtet1.PNG","title":"Cúng gia tiên","desc":"Nghi thức quan trọng giúp kết nối các thế hệ trong gia đình."}],
      "traditionalFoods":[{"image":"/images/banner3.jpg","title":"Bánh chưng","desc":"Món bánh truyền thống gắn với Tết miền Bắc."},{"image":"/images/banner2.jpg","title":"Thịt kho trứng","desc":"Món ăn quen thuộc trong mâm cơm Tết nhiều gia đình."},{"image":"/images/festival_banner.jpg","title":"Mứt Tết","desc":"Hương vị ngọt ngào thường dùng để tiếp khách đầu xuân."}],
      "regionalFoods":{"north":[{"image":"/images/banner1.jpg","title":"Dưa hành","desc":"Món ăn giúp cân bằng hương vị trong mâm cỗ Tết."}],"central":[{"image":"/images/banner2.jpg","title":"Bánh tét","desc":"Hương vị đậm đà thường gặp ở miền Trung và miền Nam."}],"south":[{"image":"/images/banner3.jpg","title":"Canh khổ qua nhồi thịt","desc":"Món ăn gửi gắm mong muốn khó khăn qua đi."}]},
      "culturalMeaningsDocs":[{"icon":"✨","title":"Khởi đầu mới","desc":"Tết tượng trưng cho sự đổi mới, tái tạo và hy vọng.","colorClass":"highlight-red"},{"icon":"👨‍👩‍👧‍👦","title":"Đoàn viên gia đình","desc":"Đây là dịp sum họp thiêng liêng nhất trong năm của người Việt.","colorClass":"highlight-orange"},{"icon":"🙏","title":"Biết ơn tổ tiên","desc":"Tinh thần uống nước nhớ nguồn được thể hiện sâu sắc trong mỗi nghi thức đầu năm.","colorClass":"highlight-yellow"}],
      "interestingFactsDocs":[{"icon":"🧧","title":"Sắc đỏ may mắn","desc":"Màu đỏ xuất hiện dày đặc trong trang trí ngày Tết như biểu tượng của phúc lộc."},{"icon":"🎇","title":"Khoảnh khắc giao thừa","desc":"Nhiều người xem giao thừa là thời khắc quan trọng nhất để gửi gắm mong ước đầu năm."},{"icon":"🌸","title":"Hoa xuân ba miền","desc":"Miền Bắc chuộng hoa đào, miền Nam yêu hoa mai, tạo nên bản sắc xuân rất riêng."}],
      "galleryHero":"/images/festival_banner.jpg",
      "galleryGrid":["/images/banner1.jpg","/images/banner2.jpg","/images/banner3.jpg","/images/anhtet1.PNG","/images/banner1.jpg","/images/banner2.jpg"],
      "inShortText":"Tết Nguyên Đán là lát cắt rõ nét nhất của văn hóa Việt Nam — nơi gia đình, ký ức tổ tiên và niềm hy vọng đầu năm giao hòa trong cùng một không khí lễ hội.",
      "discoverMore":[{"image":"/images/banner3.jpg","title":"Món ăn ngày Tết","desc":"Tìm hiểu ý nghĩa văn hóa đằng sau các món ăn truyền thống trong dịp đầu năm."},{"image":"/images/anhtet1.PNG","title":"Phong tục đầu xuân","desc":"Khám phá những tập quán quen thuộc như lì xì, chúc Tết, xông đất và du xuân."},{"image":"/images/festival_banner.jpg","title":"Không khí đoàn viên","desc":"Cảm nhận chiều sâu cảm xúc và tinh thần gia đình trong những ngày Tết Việt."}],
      "labels":{"whatIsItTitle":"Tết Nguyên Đán là gì?","dateLabel":"Thời gian","locationLabel":"Địa điểm","participantsLabel":"Thành phần tham gia","celebrationTitle":"Tết Nguyên Đán được tổ chức như thế nào?","feelsLikeTitle":"Trải nghiệm không khí Tết","keyTraditionsTitle":"Những nét truyền thống nổi bật","traditionalFoodsTitle":"Ẩm thực gắn với Tết Nguyên Đán","traditionalFoodsSubtitle":"Những món ăn ngày Tết không chỉ ngon mà còn mang theo nhiều lớp ý nghĩa văn hóa.","northRegionLabel":"Miền Bắc","centralRegionLabel":"Miền Trung","southRegionLabel":"Miền Nam","culturalMeaningsTitle":"Ý nghĩa văn hóa","interestingFactsTitle":"Điều thú vị về Tết Nguyên Đán","galleryTitle":"Tết Nguyên Đán qua hình ảnh","inShortTitle":"Tóm lược","discoverMoreTitle":"Khám phá thêm về Tết Nguyên Đán"}
    }',
    N'{}',
    1
),
(
    'tet-trung-thu','FESTIVAL',2,
    N'Tết Trung Thu',N'Mid-Autumn Festival',N'Lễ hội trăng rằm',N'Mid-Autumn celebration',
    N'Trung Thu',N'Mid-Autumn',
    N'Lễ hội dành cho thiếu nhi với lồng đèn, múa lân, bánh trung thu và không khí sum họp gia đình.',
    N'A children-centered festival filled with lanterns, lion dances, mooncakes, and family togetherness.',
    N'Lễ hội trăng rằm gắn với ký ức tuổi thơ, lồng đèn và tinh thần đoàn viên.',
    N'A full-moon festival tied to childhood memory, lanterns, and reunion.',
    N'Toàn quốc',N'Nationwide',
    N'Tháng 8 âm lịch',N'September',
    N'Lễ hội lớn',N'Major festival','#d946ef',
    N'/images/banner2.jpg',N'Tết Trung Thu',N'Mid-Autumn Festival',
    N'Tháng 9',N'September',
    N'Mùa thu',N'Autumn',
    N'/images/banner2.jpg',N'Tết Trung Thu',N'Mid-Autumn Festival',
    '#d946ef',
    NULL, NULL, 1
),
(
    'gio-to-hung-vuong','FESTIVAL',3,
    N'Giỗ Tổ Hùng Vương',N'Hung Kings Commemoration',N'Lễ tưởng niệm các Vua Hùng',N'Commemoration of the Hung Kings',
    N'Đền Hùng',N'Hung Kings Temple',
    N'Ngày lễ lớn để tưởng nhớ các Vua Hùng, gắn với đạo lý uống nước nhớ nguồn và bản sắc dân tộc.',
    N'A major celebration honoring the Hung Kings and Vietnamese national identity.',
    N'Lễ hội tưởng niệm nguồn cội dân tộc với nghi thức dâng hương và sinh hoạt cộng đồng.',
    N'A commemoration centered on ancestral memory and community rituals.',
    N'Phú Thọ',N'Phu Tho',
    N'Mùng 10 tháng 3 âm lịch',N'The 10th day of the 3rd lunar month',
    N'Văn hóa',N'Cultural festival','#ea580c',
    N'/images/giotohungvuong1.PNG',N'Giỗ Tổ Hùng Vương',N'Hung Kings Festival',
    N'Tháng 4',N'April',
    N'Mùa xuân',N'Spring',
    N'/images/giotohungvuong1.PNG',N'Giỗ Tổ Hùng Vương',N'Hung Kings Festival',
    '#ea580c',
    NULL, NULL, 1
),
(
    'festival-hue','FESTIVAL',4,
    N'Festival Huế',N'Hue Festival',N'Lễ hội di sản cố đô',N'Imperial heritage festival',
    N'Huế',N'Hue',
    N'Sự kiện văn hóa quy mô lớn tái hiện vẻ đẹp cung đình, nghệ thuật trình diễn và di sản cố đô Huế.',
    N'A large cultural event celebrating Hue''s imperial heritage and performing arts.',
    N'Lễ hội văn hóa kết nối di sản cung đình, nghệ thuật đương đại và trải nghiệm cộng đồng.',
    N'A cultural festival connecting imperial heritage, contemporary art, and community experiences.',
    N'Huế',N'Hue',
    N'Tháng 6',N'June',
    N'Văn hóa',N'Cultural festival','#10b981',
    N'/images/festival_hue.png',N'Festival Huế',N'Hue Festival',
    N'Tháng 6',N'June',
    N'Mùa hạ',N'Summer',
    N'/images/festival_hue.png',N'Festival Huế',N'Hue Festival',
    '#10b981',
    NULL, NULL, 1
),
(
    'gau-tao','FESTIVAL',5,
    N'Lễ hội Gầu Tào',N'Gau Tao Festival',N'Lễ hội cầu phúc của người H''Mông',N'Hmong spring blessing festival',
    N'Gầu Tào',N'Gau Tao',
    N'Lễ hội mùa xuân của người H''Mông, cầu bình an, sức khỏe và mùa màng thuận lợi cho cộng đồng.',
    N'A Hmong spring festival praying for health, peace, and good harvests.',
    N'Lễ hội cộng đồng giàu bản sắc vùng cao, gắn với khèn, trò chơi dân gian và lời cầu chúc đầu năm.',
    N'A vibrant highland community festival with khen music and folk games.',
    N'Miền núi phía Bắc',N'Northern Highlands',
    N'Tháng 1',N'January',
    N'Dân tộc',N'Ethnic festival','#8b5cf6',
    N'/images/hmong_festival_gau_tao_1775575986843.png',N'Lễ hội Gầu Tào',N'Gau Tao Festival',
    N'Tháng 1',N'January',
    N'Mùa xuân',N'Spring',
    N'/images/hmong_festival_gau_tao_1775575986843.png',N'Lễ hội Gầu Tào',N'Gau Tao Festival',
    '#8b5cf6',
    NULL, NULL, 1
),
(
    'kate','FESTIVAL',6,
    N'Lễ hội Katê',N'Kate Festival',N'Lễ hội đặc sắc của người Chăm',N'Cham cultural festival',
    N'Katê',N'Kate',
    N'Lễ hội lớn của người Chăm nhằm tưởng nhớ tổ tiên, thần linh và tôn vinh bản sắc văn hóa cộng đồng.',
    N'A major Cham festival honoring ancestors, deities, and cultural identity.',
    N'Lễ hội gắn với đền tháp, âm nhạc, trang phục và nghi thức cộng đồng của người Chăm.',
    N'A festival connected to Cham towers, music, dress, and ritual life.',
    N'Ninh Thuận - Bình Thuận',N'Ninh Thuan - Binh Thuan',
    N'Tháng 10',N'October',
    N'Dân tộc',N'Ethnic festival','#f59e0b',
    N'/images/cham.jpg',N'Lễ hội Katê',N'Kate Festival',
    N'Tháng 10',N'October',
    N'Mùa thu',N'Autumn',
    N'/images/cham.jpg',N'Lễ hội Katê',N'Kate Festival',
    '#f59e0b',
    NULL, NULL, 1
),
(
    'nghinh-ong','FESTIVAL',7,
    N'Lễ hội Nghinh Ông',N'Nghinh Ong Festival',N'Lễ hội tín ngưỡng vùng biển',N'Coastal worship festival',
    N'Nghinh Ông',N'Nghinh Ong',
    N'Lễ hội của cư dân vùng biển nhằm cầu mong bình an, mưa thuận gió hòa và mùa đánh bắt thuận lợi.',
    N'A coastal community festival praying for safety and prosperous fishing seasons.',
    N'Lễ hội phản ánh đời sống tín ngưỡng của ngư dân và mối gắn bó giữa con người với biển cả.',
    N'A festival reflecting fishermen''s beliefs and their deep bond with the sea.',
    N'Nam Bộ ven biển',N'Southern coastal region',
    N'Tháng 12',N'December',
    N'Tín ngưỡng',N'Religious festival','#6366f1',
    N'/images/banner3.jpg',N'Lễ hội Nghinh Ông',N'Nghinh Ong Festival',
    N'Tháng 12',N'December',
    N'Mùa đông',N'Winter',
    N'/images/banner3.jpg',N'Lễ hội Nghinh Ông',N'Nghinh Ong Festival',
    '#6366f1',
    NULL, NULL, 1
)
) AS src(
    MaLeHoi, LoaiBanGhi, ThuTuHienThi,
    TieuDeVI, TieuDeEN, TieuDePhuVI, TieuDePhuEN,
    ShortTitleVI, ShortTitleEN,
    MoTaNganVI, MoTaNganEN,
    HeroDescVI, HeroDescEN,
    ViTriVI, ViTriEN,
    NgayLeVI, NgayLeEN,
    TagVI, TagEN, TagColor,
    ImageUrl, ImageAltVI, ImageAltEN,
    TimelineMonthVI, TimelineMonthEN,
    TimelineSeasonVI, TimelineSeasonEN,
    TimelineImageUrl, TimelineImageAltVI, TimelineImageAltEN,
    TimelineColor,
    NoiDungJsonVI, NoiDungJsonEN, HoatDong
)
WHERE NOT EXISTS (SELECT 1 FROM dbo.LeHoi l WHERE l.MaLeHoi = src.MaLeHoi);

INSERT INTO dbo.BaiViet (
    MaBaiViet,
    TieuDeVI, TieuDeEN,
    MoTaNganVI, MoTaNganEN,
    GioiThieuVI, GioiThieuEN,
    NguonGocVI, NguonGocEN,
    YNghiaVanHoaVI, YNghiaVanHoaEN,
    BoiCanhVI, BoiCanhEN,
    NoiDungChinhVI, NoiDungChinhEN,
    TrangThaiDuyet, TrangThaiXuatBan, MucDoNhayCam,
    TrangThaiDongBoAI, AIChoPhep, TomTatChoAIVI, TomTatChoAIEN, SanSangChoAI,
    NgayGuiDuyet, NgayDuyet, NgayXuatBan,
    TaoBoi, CapNhatBoi, DuyetBoi
)
SELECT
    'BV_TET_TRUNG_THU',
    N'Tết Trung Thu',
    N'Mid-Autumn Festival',
    N'Lễ hội dành cho thiếu nhi với lồng đèn, múa lân, bánh trung thu và không khí sum họp gia đình.',
    N'A children-centered festival filled with lanterns, lion dances, mooncakes, and family togetherness.',
    N'Tết Trung Thu là một trong những lễ hội được yêu thích nhất ở Việt Nam, đặc biệt gắn với ký ức tuổi thơ.',
    N'The Mid-Autumn Festival is one of Vietnam''s most beloved celebrations, especially tied to childhood memory.',
    N'Lễ hội phát triển từ truyền thống nông nghiệp, ngắm trăng và sinh hoạt cộng đồng theo mùa vụ.',
    N'The festival grew from agrarian traditions, moon appreciation, and seasonal community life.',
    N'Trung Thu nhấn mạnh niềm vui đoàn viên, sự chăm sóc dành cho trẻ em và vẻ đẹp của biểu tượng mặt trăng tròn.',
    N'The festival emphasizes family reunion, care for children, and the symbolism of the full moon.',
    N'Ngày nay, Trung Thu vừa là dịp văn hóa dân gian vừa là không gian sáng tạo của nghệ thuật lồng đèn và trình diễn đường phố.',
    N'Today, Mid-Autumn Festival is both a folk tradition and a creative space for lantern art and street performance.',
    N'Các hoạt động phổ biến gồm rước đèn, phá cỗ, múa lân, làm bánh trung thu và tổ chức sự kiện cho trẻ em tại trường học, phố cổ và khu dân cư.',
    N'Common activities include lantern parades, moon-viewing feasts, lion dances, mooncake making, and children''s events in schools, old quarters, and neighborhoods.',
    'APPROVED',
    'PUBLISHED',
    1,
    'READY',
    1,
    N'Tết Trung Thu là lễ hội ngắm trăng và dành cho thiếu nhi, gắn với lồng đèn, bánh trung thu và tinh thần sum họp.',
    N'Mid-Autumn Festival is a moon celebration centered on children, lanterns, mooncakes, and reunion.',
    1,
    DATEADD(DAY, -15, SYSUTCDATETIME()),
    DATEADD(DAY, -14, SYSUTCDATETIME()),
    DATEADD(DAY, -13, SYSUTCDATETIME()),
    (SELECT NguoiDungID FROM dbo.NguoiDung WHERE Email = 'content@vnculturebridge.ai'),
    (SELECT NguoiDungID FROM dbo.NguoiDung WHERE Email = 'content@vnculturebridge.ai'),
    (SELECT NguoiDungID FROM dbo.NguoiDung WHERE Email = 'reviewer@vnculturebridge.ai')
WHERE NOT EXISTS (SELECT 1 FROM dbo.BaiViet WHERE MaBaiViet = 'BV_TET_TRUNG_THU');

INSERT INTO dbo.BaiViet (
    MaBaiViet,
    TieuDeVI, TieuDeEN,
    MoTaNganVI, MoTaNganEN,
    GioiThieuVI, GioiThieuEN,
    NguonGocVI, NguonGocEN,
    YNghiaVanHoaVI, YNghiaVanHoaEN,
    BoiCanhVI, BoiCanhEN,
    NoiDungChinhVI, NoiDungChinhEN,
    TrangThaiDuyet, TrangThaiXuatBan, MucDoNhayCam,
    TrangThaiDongBoAI, AIChoPhep, TomTatChoAIVI, TomTatChoAIEN, SanSangChoAI,
    NgayGuiDuyet, NgayDuyet, NgayXuatBan,
    TaoBoi, CapNhatBoi, DuyetBoi
)
SELECT
    'BV_PHO_VIET_NAM',
    N'Phở Việt Nam',
    N'Vietnamese Pho',
    N'Món ăn biểu tượng của Việt Nam với nước dùng trong, bánh phở mềm và hương vị cân bằng.',
    N'An iconic Vietnamese dish known for clear broth, soft rice noodles, and balanced flavors.',
    N'Phở là một biểu tượng ẩm thực Việt Nam được yêu thích trong nước và quốc tế.',
    N'Pho is an emblematic Vietnamese dish beloved both domestically and internationally.',
    N'Phở được hình thành trong bối cảnh giao thoa ẩm thực Bắc Bộ đầu thế kỷ XX và nhanh chóng lan rộng khắp cả nước.',
    N'Pho emerged in early twentieth-century northern Vietnam through culinary exchange and quickly spread nationwide.',
    N'Phở thể hiện tinh thần tinh tế trong cách nấu nước dùng, kết hợp thảo mộc và khả năng thích nghi theo vùng miền.',
    N'Pho reflects culinary refinement through broth-making, herbs, and regional adaptation.',
    N'Ngày nay, phở xuất hiện từ gánh hàng rong đến nhà hàng hiện đại, trở thành cầu nối văn hóa trong trải nghiệm ẩm thực Việt.',
    N'Today, pho appears everywhere from street stalls to modern restaurants, becoming a cultural bridge in Vietnamese cuisine.',
    N'Phở thường được nhắc tới như món ăn đại diện của Việt Nam. Tuy nhiên, mỗi địa phương và mỗi quán lại có cách nêm nếm, chọn thịt và bày biện riêng, tạo nên nhiều lớp bản sắc trong cùng một món ăn quen thuộc.',
    N'Pho is often treated as Vietnam''s signature dish. Yet each locality and eatery brings its own seasoning, meat choices, and presentation, creating multiple identities within one familiar bowl.',
    'APPROVED',
    'PUBLISHED',
    1,
    'READY',
    1,
    N'Phở là món nước tiêu biểu của Việt Nam, nổi bật bởi nước dùng, thảo mộc tươi và dấu ấn vùng miền.',
    N'Pho is a signature Vietnamese noodle soup known for its broth, fresh herbs, and regional variations.',
    1,
    DATEADD(DAY, -11, SYSUTCDATETIME()),
    DATEADD(DAY, -10, SYSUTCDATETIME()),
    DATEADD(DAY, -9, SYSUTCDATETIME()),
    (SELECT NguoiDungID FROM dbo.NguoiDung WHERE Email = 'content@vnculturebridge.ai'),
    (SELECT NguoiDungID FROM dbo.NguoiDung WHERE Email = 'content@vnculturebridge.ai'),
    (SELECT NguoiDungID FROM dbo.NguoiDung WHERE Email = 'reviewer@vnculturebridge.ai')
WHERE NOT EXISTS (SELECT 1 FROM dbo.BaiViet WHERE MaBaiViet = 'BV_PHO_VIET_NAM');

INSERT INTO dbo.BaiViet (
    MaBaiViet,
    TieuDeVI, TieuDeEN,
    MoTaNganVI, MoTaNganEN,
    GioiThieuVI, GioiThieuEN,
    NguonGocVI, NguonGocEN,
    YNghiaVanHoaVI, YNghiaVanHoaEN,
    BoiCanhVI, BoiCanhEN,
    NoiDungChinhVI, NoiDungChinhEN,
    TrangThaiDuyet, TrangThaiXuatBan, MucDoNhayCam,
    TrangThaiDongBoAI, AIChoPhep, TomTatChoAIVI, TomTatChoAIEN, SanSangChoAI,
    NgayGuiDuyet, NgayDuyet, NgayXuatBan,
    TaoBoi, CapNhatBoi, DuyetBoi
)
SELECT
    'BV_BANH_MI',
    N'Bánh mì Việt Nam',
    N'Vietnamese Banh Mi',
    N'Món bánh mì kẹp nổi tiếng với sự giao thoa giữa baguette kiểu Pháp và nguyên liệu Việt Nam.',
    N'A famous sandwich born from the meeting of French baguette traditions and Vietnamese ingredients.',
    N'Bánh mì là ví dụ tiêu biểu cho khả năng biến đổi sáng tạo của ẩm thực Việt Nam trong bối cảnh đô thị hiện đại.',
    N'Banh mi is a strong example of Vietnamese creativity in adapting food within modern urban life.',
    N'Món ăn này phát triển từ thời kỳ thuộc địa nhưng dần mang bản sắc riêng nhờ nhân, rau thơm và nước sốt kiểu Việt.',
    N'The dish developed from colonial-era bread traditions but gradually became distinctly Vietnamese through fillings, herbs, and sauces.',
    N'Bánh mì thể hiện sự linh hoạt, nhanh gọn và khả năng kết hợp giữa địa phương với toàn cầu trong đời sống hàng ngày.',
    N'Banh mi represents flexibility, convenience, and the blending of local and global influences in everyday life.',
    N'Từ món ăn sáng, bữa trưa đến món mang đi cho du khách, bánh mì đã trở thành biểu tượng của ẩm thực đường phố Việt.',
    N'From breakfast to takeaway for travelers, banh mi has become a symbol of Vietnamese street food culture.',
    N'Bánh mì Việt Nam có rất nhiều biến thể: nhân thịt, chả lụa, pate, xíu mại, trứng hoặc chay. Điều làm nên sức hấp dẫn của món ăn là cảm giác hài hòa giữa lớp vỏ giòn, nhân đậm vị và rau dưa tươi mát.',
    N'Vietnamese banh mi comes in many forms: meat, sausage, pâté, meatballs, eggs, or vegetarian fillings. Its appeal lies in the harmony between crusty bread, savory fillings, and fresh pickled vegetables and herbs.',
    'APPROVED',
    'PUBLISHED',
    1,
    'READY',
    1,
    N'Bánh mì là món ăn đường phố nổi tiếng, thể hiện sự giao thoa ẩm thực và tinh thần sáng tạo của người Việt.',
    N'Banh mi is a famous street food that reflects culinary exchange and Vietnamese creativity.',
    1,
    DATEADD(DAY, -10, SYSUTCDATETIME()),
    DATEADD(DAY, -9, SYSUTCDATETIME()),
    DATEADD(DAY, -8, SYSUTCDATETIME()),
    (SELECT NguoiDungID FROM dbo.NguoiDung WHERE Email = 'content@vnculturebridge.ai'),
    (SELECT NguoiDungID FROM dbo.NguoiDung WHERE Email = 'content@vnculturebridge.ai'),
    (SELECT NguoiDungID FROM dbo.NguoiDung WHERE Email = 'reviewer@vnculturebridge.ai')
WHERE NOT EXISTS (SELECT 1 FROM dbo.BaiViet WHERE MaBaiViet = 'BV_BANH_MI');

UPDATE dbo.BaiViet
SET
    TieuDeVI = N'Phở Việt Nam',
    MoTaNganVI = N'Món ăn biểu tượng của Việt Nam với nước dùng trong, bánh phở mềm và hương vị cân bằng.',
    GioiThieuVI = N'Phở là một biểu tượng ẩm thực Việt Nam được yêu thích trong nước và quốc tế.',
    NguonGocVI = N'Phở được hình thành trong bối cảnh giao thoa ẩm thực Bắc Bộ đầu thế kỷ XX và nhanh chóng lan rộng khắp cả nước.',
    YNghiaVanHoaVI = N'Phở thể hiện tinh thần tinh tế trong cách nấu nước dùng, kết hợp thảo mộc và khả năng thích nghi theo vùng miền.',
    BoiCanhVI = N'Ngày nay, phở xuất hiện từ gánh hàng rong đến nhà hàng hiện đại, trở thành cầu nối văn hóa trong trải nghiệm ẩm thực Việt.',
    NoiDungChinhVI = N'Phở thường được nhắc tới như món ăn đại diện của Việt Nam. Tuy nhiên, mỗi địa phương và mỗi quán lại có cách nêm nếm, chọn thịt và bày biện riêng, tạo nên nhiều lớp bản sắc trong cùng một món ăn quen thuộc.',
    TomTatChoAIVI = N'Phở là món nước tiêu biểu của Việt Nam, nổi bật bởi nước dùng, thảo mộc tươi và dấu ấn vùng miền.'
WHERE MaBaiViet = 'BV_PHO_VIET_NAM';

UPDATE dbo.BaiViet
SET
    TieuDeVI = N'Bánh mì Việt Nam',
    MoTaNganVI = N'Món bánh mì kẹp nổi tiếng với sự giao thoa giữa baguette kiểu Pháp và nguyên liệu Việt Nam.',
    GioiThieuVI = N'Bánh mì là ví dụ tiêu biểu cho khả năng biến đổi sáng tạo của ẩm thực Việt Nam trong bối cảnh đô thị hiện đại.',
    NguonGocVI = N'Món ăn này phát triển từ thời kỳ thuộc địa nhưng dần mang bản sắc riêng nhờ nhân, rau thơm và nước sốt kiểu Việt.',
    YNghiaVanHoaVI = N'Bánh mì thể hiện sự linh hoạt, nhanh gọn và khả năng kết hợp giữa địa phương với toàn cầu trong đời sống hàng ngày.',
    BoiCanhVI = N'Từ món ăn sáng, bữa trưa đến món mang đi cho du khách, bánh mì đã trở thành biểu tượng của ẩm thực đường phố Việt.',
    NoiDungChinhVI = N'Bánh mì Việt Nam có rất nhiều biến thể: nhân thịt, chả lụa, pate, xíu mại, trứng hoặc chay. Điều làm nên sức hấp dẫn của món ăn là cảm giác hài hòa giữa lớp vỏ giòn, nhân đậm vị và rau dưa tươi mát.',
    TomTatChoAIVI = N'Bánh mì là món ăn đường phố nổi tiếng, thể hiện sự giao thoa ẩm thực và tinh thần sáng tạo của người Việt.'
WHERE MaBaiViet = 'BV_BANH_MI';

INSERT INTO dbo.BaiViet (
    MaBaiViet,
    TieuDeVI, TieuDeEN,
    MoTaNganVI, MoTaNganEN,
    GioiThieuVI, GioiThieuEN,
    NguonGocVI, NguonGocEN,
    YNghiaVanHoaVI, YNghiaVanHoaEN,
    BoiCanhVI, BoiCanhEN,
    NoiDungChinhVI, NoiDungChinhEN,
    TrangThaiDuyet, TrangThaiXuatBan, MucDoNhayCam,
    TrangThaiDongBoAI, AIChoPhep, TomTatChoAIVI, TomTatChoAIEN, SanSangChoAI,
    NgayGuiDuyet, NgayDuyet, NgayXuatBan,
    TaoBoi, CapNhatBoi, DuyetBoi
)
SELECT
    'BV_BUN_CHA_HA_NOI',
    N'Bún chả Hà Nội',
    N'Hanoi Bun Cha',
    N'Món bún chả nổi tiếng với thịt nướng thơm, nước chấm đậm vị và rau sống tươi mát.',
    N'A beloved Hanoi dish featuring grilled pork, savory dipping sauce, and fresh herbs.',
    N'Bún chả Hà Nội là món ăn gắn với nhịp sống phố cổ và văn hóa quán nhỏ của thủ đô.',
    N'Hanoi bun cha is closely tied to the capital''s old-quarter rhythm and small-eatery culture.',
    N'Món ăn hình thành từ thói quen dùng bún cùng thịt lợn nướng trên than hoa, dần trở thành đặc sản tiêu biểu của Hà Nội.',
    N'The dish grew from the habit of pairing rice vermicelli with charcoal-grilled pork and gradually became a signature specialty of Hanoi.',
    N'Bún chả thể hiện sự cân bằng giữa vị khói, vị ngọt thanh của nước chấm và sự tươi mát của rau sống trong bữa ăn Việt.',
    N'Bun cha reflects the Vietnamese balance of smoky flavors, light sweetness in the broth, and freshness from herbs.',
    N'Ngày nay, bún chả hiện diện từ quán gia truyền đến nhà hàng hiện đại, luôn gợi nhắc về không khí đời thường của Hà Nội.',
    N'Today, bun cha appears from family-run stalls to modern restaurants, always evoking everyday Hanoi life.',
    N'Một phần bún chả trọn vị thường gồm chả miếng, chả viên, bún tươi, rau sống và bát nước chấm pha hài hòa. Khi ăn, thực khách chấm từng gắp bún, thịt và rau vào nước chấm để cảm nhận độ nóng, thơm và cân bằng của món.',
    N'A full serving of bun cha usually includes sliced pork, grilled patties, fresh noodles, herbs, and a well-balanced dipping sauce. Diners combine noodles, pork, and greens in the bowl to enjoy its warmth and aroma.',
    'APPROVED',
    'PUBLISHED',
    1,
    'READY',
    1,
    N'Bún chả Hà Nội là món ăn đường phố tiêu biểu, nổi bật bởi thịt nướng than hoa và nước chấm thanh ngọt.',
    N'Hanoi bun cha is a signature street-food dish known for charcoal-grilled pork and a light savory dipping sauce.',
    1,
    DATEADD(DAY, -9, SYSUTCDATETIME()),
    DATEADD(DAY, -8, SYSUTCDATETIME()),
    DATEADD(DAY, -7, SYSUTCDATETIME()),
    (SELECT NguoiDungID FROM dbo.NguoiDung WHERE Email = 'content@vnculturebridge.ai'),
    (SELECT NguoiDungID FROM dbo.NguoiDung WHERE Email = 'content@vnculturebridge.ai'),
    (SELECT NguoiDungID FROM dbo.NguoiDung WHERE Email = 'reviewer@vnculturebridge.ai')
WHERE NOT EXISTS (SELECT 1 FROM dbo.BaiViet WHERE MaBaiViet = 'BV_BUN_CHA_HA_NOI');

INSERT INTO dbo.BaiViet (
    MaBaiViet,
    TieuDeVI, TieuDeEN,
    MoTaNganVI, MoTaNganEN,
    GioiThieuVI, GioiThieuEN,
    NguonGocVI, NguonGocEN,
    YNghiaVanHoaVI, YNghiaVanHoaEN,
    BoiCanhVI, BoiCanhEN,
    NoiDungChinhVI, NoiDungChinhEN,
    TrangThaiDuyet, TrangThaiXuatBan, MucDoNhayCam,
    TrangThaiDongBoAI, AIChoPhep, TomTatChoAIVI, TomTatChoAIEN, SanSangChoAI,
    NgayGuiDuyet, NgayDuyet, NgayXuatBan,
    TaoBoi, CapNhatBoi, DuyetBoi
)
SELECT
    'BV_BUN_BO_HUE',
    N'Bún bò Huế',
    N'Hue Beef Noodle Soup',
    N'Món bún nước đậm đà với sắc đỏ hấp dẫn, sả thơm và chiều sâu vị giác đặc trưng của Huế.',
    N'A bold noodle soup marked by fragrant lemongrass, a rich broth, and the distinct taste profile of Hue.',
    N'Bún bò Huế là món ăn nổi tiếng của miền Trung, gắn với nhịp sống cố đô và gu ẩm thực đậm vị.',
    N'Bun bo Hue is a celebrated central-Vietnamese dish tied to the imperial city and its bold palate.',
    N'Món ăn phát triển từ truyền thống ẩm thực Huế với sự kết hợp của bún sợi tròn, thịt bò, giò heo và nước dùng nêm sả mắm ruốc.',
    N'The dish grew from Hue culinary traditions, combining round noodles, beef, pork hock, and broth seasoned with lemongrass and fermented shrimp paste.',
    N'Bún bò Huế thể hiện chiều sâu khẩu vị miền Trung: đậm đà, cay nhẹ, thơm mùi sả và giàu tính nghi lễ trong cách nấu nướng.',
    N'Bun bo Hue reflects the depth of central Vietnamese taste: robust, mildly spicy, lemongrass-forward, and careful in preparation.',
    N'Ngày nay, món ăn này đã lan rộng khắp Việt Nam nhưng vẫn giữ dấu ấn của Huế qua màu sắc, hương vị và cách bày tô.',
    N'Today the dish is enjoyed nationwide yet still carries Hue''s identity through its color, aroma, and presentation.',
    N'Nước dùng bún bò Huế thường được ninh kỹ từ xương, thêm sả đập dập và mắm ruốc để tạo nên mùi thơm rất riêng. Khi ăn, tô bún được điểm thêm rau sống, chanh và sa tế để tăng tầng vị và cảm giác ấm nóng.',
    N'The broth is slowly simmered with bones, bruised lemongrass, and fermented shrimp paste to create its distinctive aroma. It is commonly finished with herbs, lime, and chili oil for extra layers of flavor and warmth.',
    'APPROVED',
    'PUBLISHED',
    1,
    'READY',
    1,
    N'Bún bò Huế là món bún nổi bật của miền Trung, giàu hương sả và sắc thái ẩm thực cố đô.',
    N'Bun bo Hue is a standout central noodle soup rich in lemongrass aroma and Hue culinary character.',
    1,
    DATEADD(DAY, -8, SYSUTCDATETIME()),
    DATEADD(DAY, -7, SYSUTCDATETIME()),
    DATEADD(DAY, -6, SYSUTCDATETIME()),
    (SELECT NguoiDungID FROM dbo.NguoiDung WHERE Email = 'content@vnculturebridge.ai'),
    (SELECT NguoiDungID FROM dbo.NguoiDung WHERE Email = 'content@vnculturebridge.ai'),
    (SELECT NguoiDungID FROM dbo.NguoiDung WHERE Email = 'reviewer@vnculturebridge.ai')
WHERE NOT EXISTS (SELECT 1 FROM dbo.BaiViet WHERE MaBaiViet = 'BV_BUN_BO_HUE');

INSERT INTO dbo.BaiViet (
    MaBaiViet,
    TieuDeVI, TieuDeEN,
    MoTaNganVI, MoTaNganEN,
    GioiThieuVI, GioiThieuEN,
    NguonGocVI, NguonGocEN,
    YNghiaVanHoaVI, YNghiaVanHoaEN,
    BoiCanhVI, BoiCanhEN,
    NoiDungChinhVI, NoiDungChinhEN,
    TrangThaiDuyet, TrangThaiXuatBan, MucDoNhayCam,
    TrangThaiDongBoAI, AIChoPhep, TomTatChoAIVI, TomTatChoAIEN, SanSangChoAI,
    NgayGuiDuyet, NgayDuyet, NgayXuatBan,
    TaoBoi, CapNhatBoi, DuyetBoi
)
SELECT
    'BV_MI_QUANG',
    N'Mì Quảng',
    N'Mi Quang',
    N'Món mì đặc trưng xứ Quảng với sợi mì vàng, nước dùng xâm xấp và nhiều loại rau thơm, đậu phộng.',
    N'A signature noodle dish from Quang Nam featuring yellow noodles, a small amount of broth, herbs, and peanuts.',
    N'Mì Quảng là món ăn tiêu biểu của miền Trung, gắn với sự mộc mạc nhưng tinh tế trong cách kết hợp nguyên liệu.',
    N'Mi Quang is a signature central-Vietnamese dish known for rustic yet refined ingredient pairing.',
    N'Món ăn xuất phát từ vùng Quảng Nam - Đà Nẵng, tận dụng nguyên liệu địa phương như tôm, thịt, trứng cút, bánh tráng và rau sống.',
    N'The dish comes from the Quang Nam - Da Nang area, drawing on local ingredients such as shrimp, pork, quail eggs, sesame rice crackers, and herbs.',
    N'Mì Quảng thể hiện nhịp sống miền Trung qua khẩu phần gọn gàng, màu sắc tươi sáng và cách ăn đề cao cảm giác giòn, bùi, thơm.',
    N'Mi Quang reflects central Vietnamese life through compact portions, vibrant colors, and a focus on crunchy, nutty, and fragrant textures.',
    N'Dù có nhiều biến thể với tôm thịt, gà, ếch hay chay, mì Quảng vẫn giữ tinh thần dung dị và gần gũi của bữa ăn quê nhà.',
    N'Although it has many versions with shrimp, pork, chicken, frog, or vegetarian fillings, Mi Quang retains the simple warmth of a home-style meal.',
    N'Một tô mì Quảng ngon thường có lượng nước dùng vừa đủ để áo sợi mì, ăn kèm rau sống, bánh tráng nướng và đậu phộng rang. Sự hài hòa giữa vị béo, vị ngọt và độ giòn tạo nên trải nghiệm rất riêng cho món ăn này.',
    N'A good bowl of Mi Quang uses just enough broth to coat the noodles and is served with herbs, toasted rice crackers, and roasted peanuts. The balance of richness, sweetness, and crunch defines its experience.',
    'APPROVED',
    'PUBLISHED',
    1,
    'READY',
    1,
    N'Mì Quảng là món mì đặc trưng của xứ Quảng, nổi bật bởi nước dùng xâm xấp và sự hòa quyện của nhiều kết cấu.',
    N'Mi Quang is a signature Quang-style noodle dish known for its light broth and layered textures.',
    1,
    DATEADD(DAY, -7, SYSUTCDATETIME()),
    DATEADD(DAY, -6, SYSUTCDATETIME()),
    DATEADD(DAY, -5, SYSUTCDATETIME()),
    (SELECT NguoiDungID FROM dbo.NguoiDung WHERE Email = 'content@vnculturebridge.ai'),
    (SELECT NguoiDungID FROM dbo.NguoiDung WHERE Email = 'content@vnculturebridge.ai'),
    (SELECT NguoiDungID FROM dbo.NguoiDung WHERE Email = 'reviewer@vnculturebridge.ai')
WHERE NOT EXISTS (SELECT 1 FROM dbo.BaiViet WHERE MaBaiViet = 'BV_MI_QUANG');

INSERT INTO dbo.BaiViet (
    MaBaiViet,
    TieuDeVI, TieuDeEN,
    MoTaNganVI, MoTaNganEN,
    GioiThieuVI, GioiThieuEN,
    NguonGocVI, NguonGocEN,
    YNghiaVanHoaVI, YNghiaVanHoaEN,
    BoiCanhVI, BoiCanhEN,
    NoiDungChinhVI, NoiDungChinhEN,
    TrangThaiDuyet, TrangThaiXuatBan, MucDoNhayCam,
    TrangThaiDongBoAI, AIChoPhep, TomTatChoAIVI, TomTatChoAIEN, SanSangChoAI,
    NgayGuiDuyet, NgayDuyet, NgayXuatBan,
    TaoBoi, CapNhatBoi, DuyetBoi
)
SELECT
    'BV_COM_TAM_SAI_GON',
    N'Cơm tấm Sài Gòn',
    N'Saigon Broken Rice',
    N'Món cơm tấm nổi tiếng với sườn nướng, bì, chả và nước mắm chua ngọt đặc trưng của Sài Gòn.',
    N'A famous Saigon dish centered on broken rice, grilled pork chop, shredded pork skin, egg loaf, and sweet-savory fish sauce.',
    N'Cơm tấm Sài Gòn là hình ảnh thân thuộc của đô thị phương Nam, vừa nhanh gọn vừa đậm đà.',
    N'Saigon broken rice is a familiar image of southern urban life: quick, filling, and full of flavor.',
    N'Món ăn bắt nguồn từ việc tận dụng hạt gạo vỡ, sau đó phát triển thành đặc sản nổi tiếng nhờ cách kết hợp sườn nướng, đồ chua và mỡ hành.',
    N'The dish began as a way to use broken rice grains and evolved into a famous specialty through its pairing with grilled pork, pickles, and scallion oil.',
    N'Cơm tấm thể hiện tinh thần cởi mở, thực tế và phong phú của ẩm thực Nam Bộ trong đời sống hàng ngày.',
    N'Com tam expresses the open, practical, and abundant spirit of southern cuisine in everyday life.',
    N'Từ quán vỉa hè đến hàng ăn lâu năm, cơm tấm vẫn giữ vị trí đặc biệt trong nhịp ăn uống của người Sài Gòn.',
    N'From sidewalk stalls to long-running eateries, com tam holds a special place in the eating rhythm of Saigon.',
    N'Một đĩa cơm tấm đầy đặn thường gồm sườn nướng, bì, chả trứng, trứng ốp la, đồ chua và nước mắm pha. Cảm giác hấp dẫn của món nằm ở sự đối lập giữa hạt cơm mềm, miếng thịt thơm lửa và vị chua ngọt hài hòa.',
    N'A generous plate of com tam often includes grilled pork, shredded pork skin, egg loaf, fried egg, pickles, and fish sauce. Its appeal lies in the contrast between soft rice, smoky meat, and balanced sweet-sour notes.',
    'APPROVED',
    'PUBLISHED',
    1,
    'READY',
    1,
    N'Cơm tấm Sài Gòn là món cơm nổi tiếng của miền Nam, mang tinh thần nhanh gọn mà đậm đà của đô thị phương Nam.',
    N'Saigon broken rice is a famous southern rice dish that captures the brisk yet flavorful spirit of the southern city.',
    1,
    DATEADD(DAY, -6, SYSUTCDATETIME()),
    DATEADD(DAY, -5, SYSUTCDATETIME()),
    DATEADD(DAY, -4, SYSUTCDATETIME()),
    (SELECT NguoiDungID FROM dbo.NguoiDung WHERE Email = 'content@vnculturebridge.ai'),
    (SELECT NguoiDungID FROM dbo.NguoiDung WHERE Email = 'content@vnculturebridge.ai'),
    (SELECT NguoiDungID FROM dbo.NguoiDung WHERE Email = 'reviewer@vnculturebridge.ai')
WHERE NOT EXISTS (SELECT 1 FROM dbo.BaiViet WHERE MaBaiViet = 'BV_COM_TAM_SAI_GON');

INSERT INTO dbo.BaiViet (
    MaBaiViet,
    TieuDeVI, TieuDeEN,
    MoTaNganVI, MoTaNganEN,
    GioiThieuVI, GioiThieuEN,
    NguonGocVI, NguonGocEN,
    YNghiaVanHoaVI, YNghiaVanHoaEN,
    BoiCanhVI, BoiCanhEN,
    NoiDungChinhVI, NoiDungChinhEN,
    TrangThaiDuyet, TrangThaiXuatBan, MucDoNhayCam,
    TrangThaiDongBoAI, AIChoPhep, TomTatChoAIVI, TomTatChoAIEN, SanSangChoAI,
    NgayGuiDuyet, NgayDuyet, NgayXuatBan,
    TaoBoi, CapNhatBoi, DuyetBoi
)
SELECT
    'BV_HU_TIEU_NAM_VANG',
    N'Hủ tiếu Nam Vang',
    N'Nam Vang Hu Tieu',
    N'Món hủ tiếu nổi bật với nước dùng ngọt thanh, sợi dai mềm và nhiều loại topping phong phú.',
    N'A noodle dish known for its light sweet broth, springy noodles, and plentiful toppings.',
    N'Hủ tiếu Nam Vang là món ăn phổ biến ở Nam Bộ, phản ánh giao thoa văn hóa Việt - Hoa - Khmer trong ẩm thực đô thị.',
    N'Nam Vang hu tieu is popular in southern Vietnam and reflects Vietnamese, Chinese, and Khmer culinary exchange.',
    N'Món ăn phát triển mạnh ở Sài Gòn và miền Tây với các biến thể nước hoặc khô, sử dụng thịt bằm, tôm, gan và rau hẹ.',
    N'The dish flourished in Saigon and the Mekong Delta in both soup and dry versions, using minced pork, shrimp, liver, and garlic chives.',
    N'Hủ tiếu Nam Vang thể hiện tính linh hoạt và cởi mở của ẩm thực Nam Bộ khi tiếp nhận rồi biến đổi nhiều ảnh hưởng khác nhau.',
    N'Nam Vang hu tieu shows the flexibility and openness of southern cuisine in absorbing and transforming multiple influences.',
    N'Ngày nay, hủ tiếu có mặt từ quán sáng bình dân đến hàng ăn khuya, là lựa chọn quen thuộc của nhiều thế hệ thực khách.',
    N'Today hu tieu appears from humble breakfast stalls to late-night eateries, remaining a familiar choice across generations.',
    N'Tô hủ tiếu thường gây ấn tượng bởi nước dùng trong, sợi mì dai, topping đa dạng và mùi thơm của hành phi. Phiên bản khô còn nhấn mạnh nước sốt sánh quyện và bát nước lèo đi kèm, tạo nên trải nghiệm rất riêng.',
    N'A bowl of hu tieu stands out for its clear broth, chewy noodles, varied toppings, and fried shallot aroma. The dry version adds a glossy sauce with a side bowl of broth, creating a distinctive experience.',
    'APPROVED',
    'PUBLISHED',
    1,
    'READY',
    1,
    N'Hủ tiếu Nam Vang là món hủ tiếu phổ biến của miền Nam, nổi bật bởi nước dùng thanh và topping phong phú.',
    N'Nam Vang hu tieu is a popular southern noodle dish known for its light broth and abundant toppings.',
    1,
    DATEADD(DAY, -5, SYSUTCDATETIME()),
    DATEADD(DAY, -4, SYSUTCDATETIME()),
    DATEADD(DAY, -3, SYSUTCDATETIME()),
    (SELECT NguoiDungID FROM dbo.NguoiDung WHERE Email = 'content@vnculturebridge.ai'),
    (SELECT NguoiDungID FROM dbo.NguoiDung WHERE Email = 'content@vnculturebridge.ai'),
    (SELECT NguoiDungID FROM dbo.NguoiDung WHERE Email = 'reviewer@vnculturebridge.ai')
WHERE NOT EXISTS (SELECT 1 FROM dbo.BaiViet WHERE MaBaiViet = 'BV_HU_TIEU_NAM_VANG');

INSERT INTO dbo.BaiViet (
    MaBaiViet,
    TieuDeVI, TieuDeEN,
    MoTaNganVI, MoTaNganEN,
    GioiThieuVI, GioiThieuEN,
    NguonGocVI, NguonGocEN,
    YNghiaVanHoaVI, YNghiaVanHoaEN,
    BoiCanhVI, BoiCanhEN,
    NoiDungChinhVI, NoiDungChinhEN,
    TrangThaiDuyet, TrangThaiXuatBan, MucDoNhayCam,
    TrangThaiDongBoAI, AIChoPhep, TomTatChoAIVI, TomTatChoAIEN, SanSangChoAI,
    NgayGuiDuyet, NgayDuyet, NgayXuatBan,
    TaoBoi, CapNhatBoi, DuyetBoi
)
SELECT
    'BV_MUA_ROI_NUOC',
    N'Múa rối nước',
    N'Water Puppetry',
    N'Loại hình nghệ thuật sân khấu độc đáo, nơi con rối gỗ được điều khiển trên mặt nước.',
    N'A distinctive performance art in which wooden puppets are controlled on water.',
    N'Múa rối nước là một trong những biểu tượng nghệ thuật dân gian Việt Nam được bạn bè quốc tế biết đến nhiều nhất.',
    N'Water puppetry is one of the Vietnamese folk arts most widely recognized by international audiences.',
    N'Loại hình này hình thành từ không gian làng quê đồng bằng Bắc Bộ, nơi mặt nước vừa là sân khấu vừa là chất liệu diễn xướng.',
    N'This form emerged from the villages of the Red River Delta, where water serves as both stage and expressive medium.',
    N'Múa rối nước phản ánh đời sống nông nghiệp, trí tưởng tượng dân gian và tinh thần kể chuyện cộng đồng.',
    N'Water puppetry reflects agrarian life, folk imagination, and communal storytelling.',
    N'Ngày nay, múa rối nước vừa là di sản biểu diễn vừa là cầu nối giới thiệu văn hóa Việt Nam tới du khách quốc tế.',
    N'Today, water puppetry is both a preserved performance heritage and a bridge introducing Vietnamese culture to international visitors.',
    N'Tiết mục múa rối nước thường tái hiện sinh hoạt nông thôn, truyền thuyết, lễ hội và các câu chuyện dân gian bằng âm nhạc, lời dẫn và chuyển động uyển chuyển của con rối trên mặt nước.',
    N'Water puppet shows often recreate rural life, legends, festivals, and folk tales through music, narration, and the graceful movement of puppets across the water surface.',
    'APPROVED',
    'PUBLISHED',
    1,
    'READY',
    1,
    N'Múa rối nước là nghệ thuật biểu diễn dân gian của đồng bằng Bắc Bộ, kết hợp con rối, âm nhạc và sân khấu mặt nước.',
    N'Water puppetry is a folk performance tradition from northern Vietnam that combines puppets, music, and a water stage.',
    1,
    DATEADD(DAY, -9, SYSUTCDATETIME()),
    DATEADD(DAY, -8, SYSUTCDATETIME()),
    DATEADD(DAY, -7, SYSUTCDATETIME()),
    (SELECT NguoiDungID FROM dbo.NguoiDung WHERE Email = 'content@vnculturebridge.ai'),
    (SELECT NguoiDungID FROM dbo.NguoiDung WHERE Email = 'content@vnculturebridge.ai'),
    (SELECT NguoiDungID FROM dbo.NguoiDung WHERE Email = 'reviewer@vnculturebridge.ai')
WHERE NOT EXISTS (SELECT 1 FROM dbo.BaiViet WHERE MaBaiViet = 'BV_MUA_ROI_NUOC');

INSERT INTO dbo.BaiViet (
    MaBaiViet,
    TieuDeVI, TieuDeEN,
    MoTaNganVI, MoTaNganEN,
    GioiThieuVI, GioiThieuEN,
    NguonGocVI, NguonGocEN,
    YNghiaVanHoaVI, YNghiaVanHoaEN,
    BoiCanhVI, BoiCanhEN,
    NoiDungChinhVI, NoiDungChinhEN,
    TrangThaiDuyet, TrangThaiXuatBan, MucDoNhayCam,
    TrangThaiDongBoAI, AIChoPhep, TomTatChoAIVI, TomTatChoAIEN, SanSangChoAI,
    NgayGuiDuyet, NgayDuyet, NgayXuatBan,
    TaoBoi, CapNhatBoi, DuyetBoi
)
SELECT
    'BV_HUE_FESTIVAL',
    N'Festival Huế',
    N'Hue Festival',
    N'Sự kiện văn hoá - nghệ thuật quy mô lớn tôn vinh di sản cố đô và nghệ thuật trình diễn đương đại.',
    N'A large-scale cultural event honoring Hue heritage and contemporary performance arts.',
    N'Festival Huế là không gian nơi di sản cung đình gặp gỡ nghệ thuật đương đại và giao lưu quốc tế.',
    N'Hue Festival is a space where imperial heritage meets contemporary performance and international exchange.',
    N'Sự kiện phát triển từ nhu cầu bảo tồn, làm sống lại và quảng bá di sản Huế trong đời sống hiện đại.',
    N'The event developed from the need to preserve, revitalize, and promote Hue heritage in modern life.',
    N'Festival Huế cho thấy di sản không chỉ thuộc về quá khứ mà còn có thể được tái diễn giải trong không gian đương đại.',
    N'Hue Festival shows that heritage belongs not only to the past but can be reinterpreted in contemporary settings.',
    N'Sự kiện quy tụ trình diễn áo dài, nhã nhạc, lễ hội đường phố, triển lãm và các chương trình giao lưu nghệ thuật quốc tế.',
    N'The event brings together Ao Dai showcases, royal court music, street performances, exhibitions, and international artistic exchange.',
    N'Festival Huế giúp du khách tiếp cận di sản cố đô theo cách sống động hơn thông qua chuỗi hoạt động trải dài trong thành phố và các không gian di tích.',
    N'Hue Festival helps visitors experience imperial heritage more vividly through activities spread across the city and historic sites.',
    'APPROVED',
    'PUBLISHED',
    1,
    'READY',
    1,
    N'Festival Huế là sự kiện văn hóa lớn tôn vinh di sản cố đô, nghệ thuật trình diễn và giao lưu quốc tế.',
    N'Hue Festival is a major cultural event celebrating imperial heritage, performance arts, and international exchange.',
    1,
    DATEADD(DAY, -8, SYSUTCDATETIME()),
    DATEADD(DAY, -7, SYSUTCDATETIME()),
    DATEADD(DAY, -6, SYSUTCDATETIME()),
    (SELECT NguoiDungID FROM dbo.NguoiDung WHERE Email = 'content@vnculturebridge.ai'),
    (SELECT NguoiDungID FROM dbo.NguoiDung WHERE Email = 'content@vnculturebridge.ai'),
    (SELECT NguoiDungID FROM dbo.NguoiDung WHERE Email = 'reviewer@vnculturebridge.ai')
WHERE NOT EXISTS (SELECT 1 FROM dbo.BaiViet WHERE MaBaiViet = 'BV_HUE_FESTIVAL');

INSERT INTO dbo.BaiViet_DanhMuc (BaiVietID, DanhMucID, LaDanhMucChinh)
SELECT bv.BaiVietID, dm.DanhMucID, 1
FROM dbo.BaiViet bv
JOIN dbo.DanhMuc dm ON dm.MaDanhMuc = 'LE_HOI'
WHERE bv.MaBaiViet IN ('BV_TET_TRUNG_THU', 'BV_HUE_FESTIVAL')
  AND NOT EXISTS (
      SELECT 1 FROM dbo.BaiViet_DanhMuc x
      WHERE x.BaiVietID = bv.BaiVietID AND x.DanhMucID = dm.DanhMucID
  );

INSERT INTO dbo.BaiViet_DanhMuc (BaiVietID, DanhMucID, LaDanhMucChinh)
SELECT bv.BaiVietID, dm.DanhMucID, 1
FROM dbo.BaiViet bv
JOIN dbo.DanhMuc dm ON dm.MaDanhMuc = 'AM_THUC'
WHERE bv.MaBaiViet IN ('BV_PHO_VIET_NAM', 'BV_BANH_MI', 'BV_BUN_CHA_HA_NOI', 'BV_BUN_BO_HUE', 'BV_MI_QUANG', 'BV_COM_TAM_SAI_GON', 'BV_HU_TIEU_NAM_VANG')
  AND NOT EXISTS (
      SELECT 1 FROM dbo.BaiViet_DanhMuc x
      WHERE x.BaiVietID = bv.BaiVietID AND x.DanhMucID = dm.DanhMucID
  );

INSERT INTO dbo.BaiViet_Vung (BaiVietID, VungID, LaVungChinh)
SELECT bv.BaiVietID, vv.VungID, 1
FROM dbo.BaiViet bv
JOIN dbo.VungVanHoa vv ON vv.MaVung = 'BAC_BO'
WHERE bv.MaBaiViet IN ('BV_PHO_VIET_NAM', 'BV_BUN_CHA_HA_NOI')
  AND NOT EXISTS (
      SELECT 1 FROM dbo.BaiViet_Vung x
      WHERE x.BaiVietID = bv.BaiVietID AND x.VungID = vv.VungID
  );

INSERT INTO dbo.BaiViet_Vung (BaiVietID, VungID, LaVungChinh)
SELECT bv.BaiVietID, vv.VungID, 1
FROM dbo.BaiViet bv
JOIN dbo.VungVanHoa vv ON vv.MaVung = 'NAM_BO'
WHERE bv.MaBaiViet = 'BV_BANH_MI'
  AND NOT EXISTS (
      SELECT 1 FROM dbo.BaiViet_Vung x
      WHERE x.BaiVietID = bv.BaiVietID AND x.VungID = vv.VungID
  );

INSERT INTO dbo.BaiViet_Vung (BaiVietID, VungID, LaVungChinh)
SELECT bv.BaiVietID, vv.VungID, 1
FROM dbo.BaiViet bv
JOIN dbo.VungVanHoa vv ON vv.MaVung = 'TRUNG_BO'
WHERE bv.MaBaiViet IN ('BV_BUN_BO_HUE', 'BV_MI_QUANG')
  AND NOT EXISTS (
      SELECT 1 FROM dbo.BaiViet_Vung x
      WHERE x.BaiVietID = bv.BaiVietID AND x.VungID = vv.VungID
  );

INSERT INTO dbo.BaiViet_Vung (BaiVietID, VungID, LaVungChinh)
SELECT bv.BaiVietID, vv.VungID, 1
FROM dbo.BaiViet bv
JOIN dbo.VungVanHoa vv ON vv.MaVung = 'NAM_BO'
WHERE bv.MaBaiViet IN ('BV_COM_TAM_SAI_GON', 'BV_HU_TIEU_NAM_VANG')
  AND NOT EXISTS (
      SELECT 1 FROM dbo.BaiViet_Vung x
      WHERE x.BaiVietID = bv.BaiVietID AND x.VungID = vv.VungID
  );

INSERT INTO dbo.BaiViet_DanToc (BaiVietID, DanTocID, LaDanTocChinh)
SELECT bv.BaiVietID, dt.DanTocID, 1
FROM dbo.BaiViet bv
JOIN dbo.DanToc dt ON dt.MaDanToc = 'KINH'
WHERE bv.MaBaiViet IN ('BV_BUN_CHA_HA_NOI', 'BV_BUN_BO_HUE', 'BV_MI_QUANG', 'BV_COM_TAM_SAI_GON', 'BV_HU_TIEU_NAM_VANG')
  AND NOT EXISTS (
      SELECT 1 FROM dbo.BaiViet_DanToc x
      WHERE x.BaiVietID = bv.BaiVietID AND x.DanTocID = dt.DanTocID
  );

INSERT INTO dbo.BaiViet_LienQuan (BaiVietID, BaiVietLienQuanID, LoaiLienQuan)
SELECT b1.BaiVietID, b2.BaiVietID, 'RELATED'
FROM dbo.BaiViet b1
JOIN dbo.BaiViet b2 ON b2.MaBaiViet = 'BV_BUN_CHA_HA_NOI'
WHERE b1.MaBaiViet = 'BV_PHO_VIET_NAM'
  AND NOT EXISTS (
      SELECT 1 FROM dbo.BaiViet_LienQuan x
      WHERE x.BaiVietID = b1.BaiVietID AND x.BaiVietLienQuanID = b2.BaiVietID
  );

INSERT INTO dbo.BaiViet_LienQuan (BaiVietID, BaiVietLienQuanID, LoaiLienQuan)
SELECT b1.BaiVietID, b2.BaiVietID, 'RELATED'
FROM dbo.BaiViet b1
JOIN dbo.BaiViet b2 ON b2.MaBaiViet = 'BV_BUN_BO_HUE'
WHERE b1.MaBaiViet = 'BV_PHO_VIET_NAM'
  AND NOT EXISTS (
      SELECT 1 FROM dbo.BaiViet_LienQuan x
      WHERE x.BaiVietID = b1.BaiVietID AND x.BaiVietLienQuanID = b2.BaiVietID
  );

INSERT INTO dbo.BaiViet_LienQuan (BaiVietID, BaiVietLienQuanID, LoaiLienQuan)
SELECT b1.BaiVietID, b2.BaiVietID, 'RELATED'
FROM dbo.BaiViet b1
JOIN dbo.BaiViet b2 ON b2.MaBaiViet = 'BV_MI_QUANG'
WHERE b1.MaBaiViet = 'BV_BUN_BO_HUE'
  AND NOT EXISTS (
      SELECT 1 FROM dbo.BaiViet_LienQuan x
      WHERE x.BaiVietID = b1.BaiVietID AND x.BaiVietLienQuanID = b2.BaiVietID
  );

INSERT INTO dbo.BaiViet_LienQuan (BaiVietID, BaiVietLienQuanID, LoaiLienQuan)
SELECT b1.BaiVietID, b2.BaiVietID, 'RELATED'
FROM dbo.BaiViet b1
JOIN dbo.BaiViet b2 ON b2.MaBaiViet = 'BV_COM_TAM_SAI_GON'
WHERE b1.MaBaiViet = 'BV_HU_TIEU_NAM_VANG'
  AND NOT EXISTS (
      SELECT 1 FROM dbo.BaiViet_LienQuan x
      WHERE x.BaiVietID = b1.BaiVietID AND x.BaiVietLienQuanID = b2.BaiVietID
  );

INSERT INTO dbo.BaiViet_LienQuan (BaiVietID, BaiVietLienQuanID, LoaiLienQuan)
SELECT b1.BaiVietID, b2.BaiVietID, 'RELATED'
FROM dbo.BaiViet b1
JOIN dbo.BaiViet b2 ON b2.MaBaiViet = 'BV_HU_TIEU_NAM_VANG'
WHERE b1.MaBaiViet = 'BV_BANH_MI'
  AND NOT EXISTS (
      SELECT 1 FROM dbo.BaiViet_LienQuan x
      WHERE x.BaiVietID = b1.BaiVietID AND x.BaiVietLienQuanID = b2.BaiVietID
  );

INSERT INTO dbo.Media (
    BaiVietID, LoaiMedia, UrlFile,
    AltTextVI, AltTextEN, ChuThichVI, ChuThichEN,
    LaAnhChinh, ThuTuHienThi
)
SELECT
    bv.BaiVietID,
    'IMAGE',
    N'https://images.unsplash.com/photo-1555126634-ba092c2ddf7f?auto=format&fit=crop&w=1200&q=80',
    N'Bún chả Hà Nội với thịt nướng và bún tươi',
    N'Hanoi bun cha with grilled pork and rice vermicelli',
    N'Hình ảnh bún chả Hà Nội với chả nướng than hoa và rau sống.',
    N'Image of Hanoi bun cha with charcoal-grilled pork and herbs.',
    1, 1
FROM dbo.BaiViet bv
WHERE bv.MaBaiViet = 'BV_BUN_CHA_HA_NOI'
  AND NOT EXISTS (
      SELECT 1 FROM dbo.Media x
      WHERE x.BaiVietID = bv.BaiVietID
        AND x.UrlFile = N'https://images.unsplash.com/photo-1555126634-ba092c2ddf7f?auto=format&fit=crop&w=1200&q=80'
  );

INSERT INTO dbo.Media (
    BaiVietID, LoaiMedia, UrlFile,
    AltTextVI, AltTextEN, ChuThichVI, ChuThichEN,
    LaAnhChinh, ThuTuHienThi
)
SELECT
    bv.BaiVietID,
    'IMAGE',
    N'https://images.unsplash.com/photo-1512058564366-18510be2db19?auto=format&fit=crop&w=1200&q=80',
    N'Bún bò Huế với nước dùng đỏ và rau thơm',
    N'Hue beef noodle soup with rich broth and herbs',
    N'Hình ảnh tô bún bò Huế đậm đà đặc trưng cố đô.',
    N'Image of Hue beef noodle soup with its rich imperial-city character.',
    1, 1
FROM dbo.BaiViet bv
WHERE bv.MaBaiViet = 'BV_BUN_BO_HUE'
  AND NOT EXISTS (
      SELECT 1 FROM dbo.Media x
      WHERE x.BaiVietID = bv.BaiVietID
        AND x.UrlFile = N'https://images.unsplash.com/photo-1512058564366-18510be2db19?auto=format&fit=crop&w=1200&q=80'
  );

INSERT INTO dbo.Media (
    BaiVietID, LoaiMedia, UrlFile,
    AltTextVI, AltTextEN, ChuThichVI, ChuThichEN,
    LaAnhChinh, ThuTuHienThi
)
SELECT
    bv.BaiVietID,
    'IMAGE',
    N'https://images.unsplash.com/photo-1555939594-58d7cb561ad1?auto=format&fit=crop&w=1200&q=80',
    N'Mì Quảng với đậu phộng và bánh tráng nướng',
    N'Mi Quang with peanuts and toasted rice cracker',
    N'Hình ảnh mì Quảng với sợi mì vàng và topping đặc trưng.',
    N'Image of Mi Quang with yellow noodles and signature toppings.',
    1, 1
FROM dbo.BaiViet bv
WHERE bv.MaBaiViet = 'BV_MI_QUANG'
  AND NOT EXISTS (
      SELECT 1 FROM dbo.Media x
      WHERE x.BaiVietID = bv.BaiVietID
        AND x.UrlFile = N'https://images.unsplash.com/photo-1555939594-58d7cb561ad1?auto=format&fit=crop&w=1200&q=80'
  );

INSERT INTO dbo.Media (
    BaiVietID, LoaiMedia, UrlFile,
    AltTextVI, AltTextEN, ChuThichVI, ChuThichEN,
    LaAnhChinh, ThuTuHienThi
)
SELECT
    bv.BaiVietID,
    'IMAGE',
    N'https://images.unsplash.com/photo-1625944525533-473f1a3d54de?auto=format&fit=crop&w=1200&q=80',
    N'Cơm tấm Sài Gòn với sườn nướng',
    N'Saigon broken rice with grilled pork chop',
    N'Hình ảnh đĩa cơm tấm với sườn nướng, bì và chả.',
    N'Image of broken rice with grilled pork, shredded pork skin, and egg loaf.',
    1, 1
FROM dbo.BaiViet bv
WHERE bv.MaBaiViet = 'BV_COM_TAM_SAI_GON'
  AND NOT EXISTS (
      SELECT 1 FROM dbo.Media x
      WHERE x.BaiVietID = bv.BaiVietID
        AND x.UrlFile = N'https://images.unsplash.com/photo-1625944525533-473f1a3d54de?auto=format&fit=crop&w=1200&q=80'
  );

INSERT INTO dbo.Media (
    BaiVietID, LoaiMedia, UrlFile,
    AltTextVI, AltTextEN, ChuThichVI, ChuThichEN,
    LaAnhChinh, ThuTuHienThi
)
SELECT
    bv.BaiVietID,
    'IMAGE',
    N'https://images.unsplash.com/photo-1626242372480-164c673ba718?auto=format&fit=crop&w=1200&q=80',
    N'Hủ tiếu Nam Vang với topping phong phú',
    N'Nam Vang hu tieu with abundant toppings',
    N'Hình ảnh hủ tiếu Nam Vang với nước dùng trong và topping đa dạng.',
    N'Image of Nam Vang hu tieu with clear broth and diverse toppings.',
    1, 1
FROM dbo.BaiViet bv
WHERE bv.MaBaiViet = 'BV_HU_TIEU_NAM_VANG'
  AND NOT EXISTS (
      SELECT 1 FROM dbo.Media x
      WHERE x.BaiVietID = bv.BaiVietID
        AND x.UrlFile = N'https://images.unsplash.com/photo-1626242372480-164c673ba718?auto=format&fit=crop&w=1200&q=80'
  );

INSERT INTO dbo.Media (
    BaiVietID, LoaiMedia, UrlFile,
    AltTextVI, AltTextEN, ChuThichVI, ChuThichEN,
    LaAnhChinh, ThuTuHienThi
)
SELECT
    bv.BaiVietID,
    'IMAGE',
    N'https://images.unsplash.com/photo-1504674900247-0877df9cc836?auto=format&fit=crop&w=1200&q=80',
    N'Phở với rau thơm và nước dùng nóng',
    N'Pho with fresh herbs and hot broth',
    N'Góc nhìn gần món phở Việt Nam với rau thơm tươi.',
    N'Close-up of Vietnamese pho with fresh herbs.',
    0, 2
FROM dbo.BaiViet bv
WHERE bv.MaBaiViet = 'BV_PHO_VIET_NAM'
  AND NOT EXISTS (
      SELECT 1 FROM dbo.Media x
      WHERE x.BaiVietID = bv.BaiVietID
        AND x.UrlFile = N'https://images.unsplash.com/photo-1504674900247-0877df9cc836?auto=format&fit=crop&w=1200&q=80'
  );

INSERT INTO dbo.Media (
    BaiVietID, LoaiMedia, UrlFile,
    AltTextVI, AltTextEN, ChuThichVI, ChuThichEN,
    LaAnhChinh, ThuTuHienThi
)
SELECT
    bv.BaiVietID,
    'IMAGE',
    N'https://images.unsplash.com/photo-1582878826629-29b7ad1cb431?auto=format&fit=crop&w=1200&q=80',
    N'Phở bò Hà Nội trong tô lớn',
    N'Hanoi beef pho in a large bowl',
    N'Hình ảnh phở bò với lát thịt và hành lá.',
    N'Image of beef pho with sliced meat and scallions.',
    0, 3
FROM dbo.BaiViet bv
WHERE bv.MaBaiViet = 'BV_PHO_VIET_NAM'
  AND NOT EXISTS (
      SELECT 1 FROM dbo.Media x
      WHERE x.BaiVietID = bv.BaiVietID
        AND x.UrlFile = N'https://images.unsplash.com/photo-1582878826629-29b7ad1cb431?auto=format&fit=crop&w=1200&q=80'
  );

INSERT INTO dbo.Media (
    BaiVietID, LoaiMedia, UrlFile,
    AltTextVI, AltTextEN, ChuThichVI, ChuThichEN,
    LaAnhChinh, ThuTuHienThi
)
SELECT
    bv.BaiVietID,
    'IMAGE',
    N'https://images.unsplash.com/photo-1547592166-23ac45744acd?auto=format&fit=crop&w=1200&q=80',
    N'Bún chả được dọn kèm rau sống',
    N'Bun cha served with fresh herbs',
    N'Góc nhìn món bún chả với thịt nướng và bát nước chấm.',
    N'View of bun cha with grilled pork and dipping sauce.',
    0, 2
FROM dbo.BaiViet bv
WHERE bv.MaBaiViet = 'BV_BUN_CHA_HA_NOI'
  AND NOT EXISTS (
      SELECT 1 FROM dbo.Media x
      WHERE x.BaiVietID = bv.BaiVietID
        AND x.UrlFile = N'https://images.unsplash.com/photo-1547592166-23ac45744acd?auto=format&fit=crop&w=1200&q=80'
  );

INSERT INTO dbo.Media (
    BaiVietID, LoaiMedia, UrlFile,
    AltTextVI, AltTextEN, ChuThichVI, ChuThichEN,
    LaAnhChinh, ThuTuHienThi
)
SELECT
    bv.BaiVietID,
    'IMAGE',
    N'https://images.unsplash.com/photo-1583096114844-06ce6a5f2171?auto=format&fit=crop&w=1200&q=80',
    N'Bún bò Huế cận cảnh',
    N'Close-up of bun bo Hue',
    N'Hình ảnh cận cảnh tô bún bò Huế với sắc đỏ đặc trưng.',
    N'Close-up image of bun bo Hue with its signature reddish broth.',
    0, 2
FROM dbo.BaiViet bv
WHERE bv.MaBaiViet = 'BV_BUN_BO_HUE'
  AND NOT EXISTS (
      SELECT 1 FROM dbo.Media x
      WHERE x.BaiVietID = bv.BaiVietID
        AND x.UrlFile = N'https://images.unsplash.com/photo-1583096114844-06ce6a5f2171?auto=format&fit=crop&w=1200&q=80'
  );

INSERT INTO dbo.Media (
    BaiVietID, LoaiMedia, UrlFile,
    AltTextVI, AltTextEN, ChuThichVI, ChuThichEN,
    LaAnhChinh, ThuTuHienThi
)
SELECT
    bv.BaiVietID,
    'IMAGE',
    N'https://images.unsplash.com/photo-1509722747041-616f39b57569?auto=format&fit=crop&w=1200&q=80',
    N'Bánh mì Việt Nam cắt đôi với phần nhân đầy đặn',
    N'Vietnamese banh mi cut open with fillings',
    N'Hình ảnh bánh mì Việt Nam với lớp vỏ giòn và phần nhân phong phú.',
    N'Image of Vietnamese banh mi with crispy crust and generous fillings.',
    0, 2
FROM dbo.BaiViet bv
WHERE bv.MaBaiViet = 'BV_BANH_MI'
  AND NOT EXISTS (
      SELECT 1 FROM dbo.Media x
      WHERE x.BaiVietID = bv.BaiVietID
        AND x.UrlFile = N'https://images.unsplash.com/photo-1509722747041-616f39b57569?auto=format&fit=crop&w=1200&q=80'
  );

INSERT INTO dbo.Media (
    BaiVietID, LoaiMedia, UrlFile,
    AltTextVI, AltTextEN, ChuThichVI, ChuThichEN,
    LaAnhChinh, ThuTuHienThi
)
SELECT
    bv.BaiVietID,
    'IMAGE',
    N'https://images.unsplash.com/photo-1555126634-323283e090fa?auto=format&fit=crop&w=1200&q=80',
    N'Mì Quảng với rau sống và bánh tráng',
    N'Mi Quang with herbs and sesame cracker',
    N'Hình ảnh mì Quảng ăn kèm rau sống, bánh tráng và đậu phộng.',
    N'Image of Mi Quang served with herbs, sesame cracker, and peanuts.',
    0, 2
FROM dbo.BaiViet bv
WHERE bv.MaBaiViet = 'BV_MI_QUANG'
  AND NOT EXISTS (
      SELECT 1 FROM dbo.Media x
      WHERE x.BaiVietID = bv.BaiVietID
        AND x.UrlFile = N'https://images.unsplash.com/photo-1555126634-323283e090fa?auto=format&fit=crop&w=1200&q=80'
  );

INSERT INTO dbo.Media (
    BaiVietID, LoaiMedia, UrlFile,
    AltTextVI, AltTextEN, ChuThichVI, ChuThichEN,
    LaAnhChinh, ThuTuHienThi
)
SELECT
    bv.BaiVietID,
    'IMAGE',
    N'https://images.unsplash.com/photo-1547592180-85f173990554?auto=format&fit=crop&w=1200&q=80',
    N'Cơm tấm với sườn nướng và đồ chua',
    N'Broken rice with grilled pork and pickles',
    N'Góc nhìn đĩa cơm tấm với mỡ hành và nước mắm.',
    N'View of broken rice with scallion oil and fish sauce.',
    0, 2
FROM dbo.BaiViet bv
WHERE bv.MaBaiViet = 'BV_COM_TAM_SAI_GON'
  AND NOT EXISTS (
      SELECT 1 FROM dbo.Media x
      WHERE x.BaiVietID = bv.BaiVietID
        AND x.UrlFile = N'https://images.unsplash.com/photo-1547592180-85f173990554?auto=format&fit=crop&w=1200&q=80'
  );

INSERT INTO dbo.Media (
    BaiVietID, LoaiMedia, UrlFile,
    AltTextVI, AltTextEN, ChuThichVI, ChuThichEN,
    LaAnhChinh, ThuTuHienThi
)
SELECT
    bv.BaiVietID,
    'IMAGE',
    N'https://images.unsplash.com/photo-1610832958506-aa56368176cf?auto=format&fit=crop&w=1200&q=80',
    N'Hủ tiếu Nam Vang phiên bản khô',
    N'Dry-style Nam Vang hu tieu',
    N'Hình ảnh hủ tiếu Nam Vang phiên bản khô với nước dùng riêng.',
    N'Image of dry-style Nam Vang hu tieu served with broth on the side.',
    0, 2
FROM dbo.BaiViet bv
WHERE bv.MaBaiViet = 'BV_HU_TIEU_NAM_VANG'
  AND NOT EXISTS (
      SELECT 1 FROM dbo.Media x
      WHERE x.BaiVietID = bv.BaiVietID
        AND x.UrlFile = N'https://images.unsplash.com/photo-1610832958506-aa56368176cf?auto=format&fit=crop&w=1200&q=80'
  );

INSERT INTO dbo.Media (
    BaiVietID, LoaiMedia, UrlFile,
    AltTextVI, AltTextEN, ChuThichVI, ChuThichEN,
    LaAnhChinh, ThuTuHienThi
)
SELECT
    bv.BaiVietID,
    'IMAGE',
    N'https://images.unsplash.com/photo-1626242372480-164c673ba718?auto=format&fit=crop&w=1200&q=80',
    N'Hủ tiếu Nam Vang với tôm và thịt',
    N'Nam Vang hu tieu with shrimp and pork',
    N'Góc nhìn tô hủ tiếu với topping tôm, thịt và rau hẹ.',
    N'View of hu tieu topped with shrimp, pork, and garlic chives.',
    0, 3
FROM dbo.BaiViet bv
WHERE bv.MaBaiViet = 'BV_HU_TIEU_NAM_VANG'
  AND NOT EXISTS (
      SELECT 1 FROM dbo.Media x
      WHERE x.BaiVietID = bv.BaiVietID
        AND x.UrlFile = N'https://images.unsplash.com/photo-1626242372480-164c673ba718?auto=format&fit=crop&w=1200&q=80'
  );

INSERT INTO dbo.Media (
    BaiVietID, LoaiMedia, UrlFile,
    AltTextVI, AltTextEN, ChuThichVI, ChuThichEN,
    LaAnhChinh, ThuTuHienThi
)
SELECT
    bv.BaiVietID,
    'IMAGE',
    N'https://images.unsplash.com/photo-1625944525533-473f1a3d54de?auto=format&fit=crop&w=1200&q=80',
    N'Cơm tấm Sài Gòn cận cảnh phần sườn nướng',
    N'Close-up of Saigon broken rice with grilled pork chop',
    N'Hình ảnh cận cảnh cơm tấm Sài Gòn với sườn nướng hấp dẫn.',
    N'Close-up image of Saigon broken rice with grilled pork chop.',
    0, 3
FROM dbo.BaiViet bv
WHERE bv.MaBaiViet = 'BV_COM_TAM_SAI_GON'
  AND NOT EXISTS (
      SELECT 1 FROM dbo.Media x
      WHERE x.BaiVietID = bv.BaiVietID
        AND x.UrlFile = N'https://images.unsplash.com/photo-1625944525533-473f1a3d54de?auto=format&fit=crop&w=1200&q=80'
  );

INSERT INTO dbo.Media (
    BaiVietID, LoaiMedia, UrlFile,
    AltTextVI, AltTextEN, ChuThichVI, ChuThichEN,
    LaAnhChinh, ThuTuHienThi
)
SELECT
    bv.BaiVietID,
    'IMAGE',
    N'https://images.unsplash.com/photo-1555939594-58d7cb561ad1?auto=format&fit=crop&w=1200&q=80',
    N'Mì Quảng cận cảnh sợi mì và topping',
    N'Close-up of Mi Quang noodles and toppings',
    N'Hình ảnh cận cảnh mì Quảng với tôm thịt và đậu phộng.',
    N'Close-up image of Mi Quang with shrimp, pork, and peanuts.',
    0, 3
FROM dbo.BaiViet bv
WHERE bv.MaBaiViet = 'BV_MI_QUANG'
  AND NOT EXISTS (
      SELECT 1 FROM dbo.Media x
      WHERE x.BaiVietID = bv.BaiVietID
        AND x.UrlFile = N'https://images.unsplash.com/photo-1555939594-58d7cb561ad1?auto=format&fit=crop&w=1200&q=80'
  );

INSERT INTO dbo.Media (
    BaiVietID, LoaiMedia, UrlFile,
    AltTextVI, AltTextEN, ChuThichVI, ChuThichEN,
    LaAnhChinh, ThuTuHienThi
)
SELECT
    bv.BaiVietID,
    'IMAGE',
    N'https://images.unsplash.com/photo-1504674900247-0877df9cc836?auto=format&fit=crop&w=1200&q=80',
    N'Bún chả Hà Nội với bún tươi và rau sống',
    N'Hanoi bun cha with vermicelli and herbs',
    N'Hình ảnh bún chả Hà Nội với bún, rau và chả nướng.',
    N'Image of Hanoi bun cha with noodles, herbs, and grilled pork.',
    0, 3
FROM dbo.BaiViet bv
WHERE bv.MaBaiViet = 'BV_BUN_CHA_HA_NOI'
  AND NOT EXISTS (
      SELECT 1 FROM dbo.Media x
      WHERE x.BaiVietID = bv.BaiVietID
        AND x.UrlFile = N'https://images.unsplash.com/photo-1504674900247-0877df9cc836?auto=format&fit=crop&w=1200&q=80'
  );

INSERT INTO dbo.Media (
    BaiVietID, LoaiMedia, UrlFile,
    AltTextVI, AltTextEN, ChuThichVI, ChuThichEN,
    LaAnhChinh, ThuTuHienThi
)
SELECT
    bv.BaiVietID,
    'IMAGE',
    N'https://images.unsplash.com/photo-1512058564366-18510be2db19?auto=format&fit=crop&w=1000&q=80',
    N'Bún bò Huế dùng kèm rau sống',
    N'Hue beef noodle soup served with herbs',
    N'Hình ảnh bún bò Huế cùng đĩa rau ăn kèm.',
    N'Image of bun bo Hue served with herbs.',
    0, 3
FROM dbo.BaiViet bv
WHERE bv.MaBaiViet = 'BV_BUN_BO_HUE'
  AND NOT EXISTS (
      SELECT 1 FROM dbo.Media x
      WHERE x.BaiVietID = bv.BaiVietID
        AND x.UrlFile = N'https://images.unsplash.com/photo-1512058564366-18510be2db19?auto=format&fit=crop&w=1000&q=80'
  );

INSERT INTO dbo.Media (
    BaiVietID, LoaiMedia, UrlFile,
    AltTextVI, AltTextEN, ChuThichVI, ChuThichEN,
    LaAnhChinh, ThuTuHienThi
)
SELECT
    bv.BaiVietID,
    'IMAGE',
    N'https://images.unsplash.com/photo-1604908812752-60b7c7d1d7ab?auto=format&fit=crop&w=1200&q=80',
    N'Bánh mì Việt Nam với pate và đồ chua',
    N'Vietnamese banh mi with pate and pickles',
    N'Hình ảnh bánh mì với pate, rau dưa và nhân đậm đà.',
    N'Image of banh mi with pate, pickles, and flavorful fillings.',
    0, 3
FROM dbo.BaiViet bv
WHERE bv.MaBaiViet = 'BV_BANH_MI'
  AND NOT EXISTS (
      SELECT 1 FROM dbo.Media x
      WHERE x.BaiVietID = bv.BaiVietID
        AND x.UrlFile = N'https://images.unsplash.com/photo-1604908812752-60b7c7d1d7ab?auto=format&fit=crop&w=1200&q=80'
  );

INSERT INTO dbo.BaiViet_Vung (BaiVietID, VungID, LaVungChinh)
SELECT bv.BaiVietID, vv.VungID, 1
FROM dbo.BaiViet bv
JOIN dbo.VungVanHoa vv ON vv.MaVung = 'BAC_BO'
WHERE bv.MaBaiViet IN ('BV_TET_TRUNG_THU', 'BV_PHO_VIET_NAM', 'BV_MUA_ROI_NUOC')
  AND NOT EXISTS (
      SELECT 1 FROM dbo.BaiViet_Vung x
      WHERE x.BaiVietID = bv.BaiVietID AND x.VungID = vv.VungID
  );

INSERT INTO dbo.BaiViet_DanhMuc (BaiVietID, DanhMucID, LaDanhMucChinh)
SELECT bv.BaiVietID, dm.DanhMucID, 1
FROM dbo.BaiViet bv
JOIN dbo.DanhMuc dm ON dm.MaDanhMuc = 'NGHE_THUAT_DAN_GIAN'
WHERE bv.MaBaiViet = 'BV_MUA_ROI_NUOC'
  AND NOT EXISTS (
      SELECT 1 FROM dbo.BaiViet_DanhMuc x
      WHERE x.BaiVietID = bv.BaiVietID AND x.DanhMucID = dm.DanhMucID
  );

INSERT INTO dbo.BaiViet_Vung (BaiVietID, VungID, LaVungChinh)
SELECT bv.BaiVietID, vv.VungID, 1
FROM dbo.BaiViet bv
JOIN dbo.VungVanHoa vv ON vv.MaVung = 'BAC_BO'
WHERE bv.MaBaiViet IN ('BV_TET_TRUNG_THU', 'BV_PHO_VIET_NAM', 'BV_MUA_ROI_NUOC')
  AND NOT EXISTS (
      SELECT 1 FROM dbo.BaiViet_Vung x
      WHERE x.BaiVietID = bv.BaiVietID AND x.VungID = vv.VungID
  );

INSERT INTO dbo.BaiViet_Vung (BaiVietID, VungID, LaVungChinh)
SELECT bv.BaiVietID, vv.VungID, 1
FROM dbo.BaiViet bv
JOIN dbo.VungVanHoa vv ON vv.MaVung = 'TRUNG_BO'
WHERE bv.MaBaiViet = 'BV_HUE_FESTIVAL'
  AND NOT EXISTS (
      SELECT 1 FROM dbo.BaiViet_Vung x
      WHERE x.BaiVietID = bv.BaiVietID AND x.VungID = vv.VungID
  );

INSERT INTO dbo.BaiViet_Vung (BaiVietID, VungID, LaVungChinh)
SELECT bv.BaiVietID, vv.VungID, 1
FROM dbo.BaiViet bv
JOIN dbo.VungVanHoa vv ON vv.MaVung = 'NAM_BO'
WHERE bv.MaBaiViet = 'BV_BANH_MI'
  AND NOT EXISTS (
      SELECT 1 FROM dbo.BaiViet_Vung x
      WHERE x.BaiVietID = bv.BaiVietID AND x.VungID = vv.VungID
  );

INSERT INTO dbo.BaiViet_DanToc (BaiVietID, DanTocID, LaDanTocChinh)
SELECT bv.BaiVietID, dt.DanTocID, 1
FROM dbo.BaiViet bv
JOIN dbo.DanToc dt ON dt.MaDanToc = 'KINH'
WHERE bv.MaBaiViet IN ('BV_TET_TRUNG_THU', 'BV_PHO_VIET_NAM', 'BV_BANH_MI', 'BV_MUA_ROI_NUOC', 'BV_HUE_FESTIVAL')
  AND NOT EXISTS (
      SELECT 1 FROM dbo.BaiViet_DanToc x
      WHERE x.BaiVietID = bv.BaiVietID AND x.DanTocID = dt.DanTocID
  );

INSERT INTO dbo.BaiViet_TuKhoa (BaiVietID, TuKhoaID)
SELECT bv.BaiVietID, tk.TuKhoaID
FROM dbo.BaiViet bv
JOIN dbo.TuKhoa tk ON tk.MaTuKhoa = 'TRUNG_THU'
WHERE bv.MaBaiViet = 'BV_TET_TRUNG_THU'
  AND NOT EXISTS (
      SELECT 1 FROM dbo.BaiViet_TuKhoa x
      WHERE x.BaiVietID = bv.BaiVietID AND x.TuKhoaID = tk.TuKhoaID
  );

INSERT INTO dbo.BaiViet_TuKhoa (BaiVietID, TuKhoaID)
SELECT bv.BaiVietID, tk.TuKhoaID
FROM dbo.BaiViet bv
JOIN dbo.TuKhoa tk ON tk.MaTuKhoa = 'PHO'
WHERE bv.MaBaiViet = 'BV_PHO_VIET_NAM'
  AND NOT EXISTS (
      SELECT 1 FROM dbo.BaiViet_TuKhoa x
      WHERE x.BaiVietID = bv.BaiVietID AND x.TuKhoaID = tk.TuKhoaID
  );

INSERT INTO dbo.BaiViet_TuKhoa (BaiVietID, TuKhoaID)
SELECT bv.BaiVietID, tk.TuKhoaID
FROM dbo.BaiViet bv
JOIN dbo.TuKhoa tk ON tk.MaTuKhoa = 'BANH_MI'
WHERE bv.MaBaiViet = 'BV_BANH_MI'
  AND NOT EXISTS (
      SELECT 1 FROM dbo.BaiViet_TuKhoa x
      WHERE x.BaiVietID = bv.BaiVietID AND x.TuKhoaID = tk.TuKhoaID
  );

INSERT INTO dbo.BaiViet_TuKhoa (BaiVietID, TuKhoaID)
SELECT bv.BaiVietID, tk.TuKhoaID
FROM dbo.BaiViet bv
JOIN dbo.TuKhoa tk ON tk.MaTuKhoa = 'MUA_ROI_NUOC'
WHERE bv.MaBaiViet = 'BV_MUA_ROI_NUOC'
  AND NOT EXISTS (
      SELECT 1 FROM dbo.BaiViet_TuKhoa x
      WHERE x.BaiVietID = bv.BaiVietID AND x.TuKhoaID = tk.TuKhoaID
  );

INSERT INTO dbo.BaiViet_LienQuan (BaiVietID, BaiVietLienQuanID, LoaiLienQuan)
SELECT b1.BaiVietID, b2.BaiVietID, 'RELATED'
FROM dbo.BaiViet b1
JOIN dbo.BaiViet b2 ON b2.MaBaiViet = 'BV_TET_TRUNG_THU'
WHERE b1.MaBaiViet = 'BV_TET_NGUYEN_DAN'
  AND NOT EXISTS (
      SELECT 1 FROM dbo.BaiViet_LienQuan x
      WHERE x.BaiVietID = b1.BaiVietID AND x.BaiVietLienQuanID = b2.BaiVietID
  );

INSERT INTO dbo.BaiViet_LienQuan (BaiVietID, BaiVietLienQuanID, LoaiLienQuan)
SELECT b1.BaiVietID, b2.BaiVietID, 'RELATED'
FROM dbo.BaiViet b1
JOIN dbo.BaiViet b2 ON b2.MaBaiViet = 'BV_BANH_MI'
WHERE b1.MaBaiViet = 'BV_PHO_VIET_NAM'
  AND NOT EXISTS (
      SELECT 1 FROM dbo.BaiViet_LienQuan x
      WHERE x.BaiVietID = b1.BaiVietID AND x.BaiVietLienQuanID = b2.BaiVietID
  );

INSERT INTO dbo.Media (
    BaiVietID, LoaiMedia, UrlFile,
    AltTextVI, AltTextEN, ChuThichVI, ChuThichEN,
    LaAnhChinh, ThuTuHienThi
)
SELECT
    bv.BaiVietID,
    'IMAGE',
    N'https://images.unsplash.com/photo-1513151233558-d860c5398176?auto=format&fit=crop&w=1200&q=80',
    N'Lồng đèn trong đêm Trung Thu',
    N'Lanterns during Mid-Autumn Festival',
    N'Hình ảnh đèn lồng và không khí lễ hội Trung Thu.',
    N'Lanterns and the festive atmosphere of Mid-Autumn Festival.',
    1, 1
FROM dbo.BaiViet bv
WHERE bv.MaBaiViet = 'BV_TET_TRUNG_THU'
  AND NOT EXISTS (
      SELECT 1 FROM dbo.Media x
      WHERE x.BaiVietID = bv.BaiVietID
        AND x.UrlFile = N'https://images.unsplash.com/photo-1513151233558-d860c5398176?auto=format&fit=crop&w=1200&q=80'
  );

INSERT INTO dbo.Media (
    BaiVietID, LoaiMedia, UrlFile,
    AltTextVI, AltTextEN, ChuThichVI, ChuThichEN,
    LaAnhChinh, ThuTuHienThi
)
SELECT
    bv.BaiVietID,
    'IMAGE',
    N'https://images.unsplash.com/photo-1504674900247-0877df9cc836?auto=format&fit=crop&w=1200&q=80',
    N'Tô phở với rau thơm tươi',
    N'Bowl of pho with fresh herbs',
    N'Hình ảnh món phở Việt Nam với nước dùng và rau thơm.',
    N'An image of Vietnamese pho with broth and fresh herbs.',
    1, 1
FROM dbo.BaiViet bv
WHERE bv.MaBaiViet = 'BV_PHO_VIET_NAM'
  AND NOT EXISTS (
      SELECT 1 FROM dbo.Media x
      WHERE x.BaiVietID = bv.BaiVietID
        AND x.UrlFile = N'https://images.unsplash.com/photo-1504674900247-0877df9cc836?auto=format&fit=crop&w=1200&q=80'
  );

INSERT INTO dbo.Media (
    BaiVietID, LoaiMedia, UrlFile,
    AltTextVI, AltTextEN, ChuThichVI, ChuThichEN,
    LaAnhChinh, ThuTuHienThi
)
SELECT
    bv.BaiVietID,
    'IMAGE',
    N'https://images.unsplash.com/photo-1604908812752-60b7c7d1d7ab?auto=format&fit=crop&w=1200&q=80',
    N'Bánh mì Việt Nam',
    N'Vietnamese banh mi',
    N'Hình ảnh bánh mì với nhân và rau dưa kiểu Việt.',
    N'Image of banh mi with Vietnamese fillings and pickles.',
    1, 1
FROM dbo.BaiViet bv
WHERE bv.MaBaiViet = 'BV_BANH_MI'
  AND NOT EXISTS (
      SELECT 1 FROM dbo.Media x
      WHERE x.BaiVietID = bv.BaiVietID
        AND x.UrlFile = N'https://images.unsplash.com/photo-1604908812752-60b7c7d1d7ab?auto=format&fit=crop&w=1200&q=80'
  );

INSERT INTO dbo.Media (
    BaiVietID, LoaiMedia, UrlFile,
    AltTextVI, AltTextEN, ChuThichVI, ChuThichEN,
    LaAnhChinh, ThuTuHienThi
)
SELECT
    bv.BaiVietID,
    'IMAGE',
    N'https://images.unsplash.com/photo-1517486808906-6ca8b3f04846?auto=format&fit=crop&w=1200&q=80',
    N'Múa rối nước trên sân khấu mặt nước',
    N'Water puppetry on a water stage',
    N'Hình ảnh trình diễn múa rối nước truyền thống.',
    N'An image of a traditional water puppetry performance.',
    1, 1
FROM dbo.BaiViet bv
WHERE bv.MaBaiViet = 'BV_MUA_ROI_NUOC'
  AND NOT EXISTS (
      SELECT 1 FROM dbo.Media x
      WHERE x.BaiVietID = bv.BaiVietID
        AND x.UrlFile = N'https://images.unsplash.com/photo-1517486808906-6ca8b3f04846?auto=format&fit=crop&w=1200&q=80'
  );

INSERT INTO dbo.Media (
    BaiVietID, LoaiMedia, UrlFile,
    AltTextVI, AltTextEN, ChuThichVI, ChuThichEN,
    LaAnhChinh, ThuTuHienThi
)
SELECT
    bv.BaiVietID,
    'IMAGE',
    N'https://images.unsplash.com/photo-1528127269322-539801943592?auto=format&fit=crop&w=1200&q=80',
    N'Không gian Festival Huế',
    N'Hue Festival scene',
    N'Hình ảnh không gian biểu diễn trong Festival Huế.',
    N'Image of a performance space during Hue Festival.',
    1, 1
FROM dbo.BaiViet bv
WHERE bv.MaBaiViet = 'BV_HUE_FESTIVAL'
  AND NOT EXISTS (
      SELECT 1 FROM dbo.Media x
      WHERE x.BaiVietID = bv.BaiVietID
        AND x.UrlFile = N'https://images.unsplash.com/photo-1528127269322-539801943592?auto=format&fit=crop&w=1200&q=80'
  );

INSERT INTO dbo.NguonThamKhao (
    BaiVietID, TieuDeNguon, TacGia, LoaiNguon, UrlNguon, GhiChu, LaNguonChinh
)
SELECT
    bv.BaiVietID,
    N'Lễ hội Trung Thu trong đời sống đô thị Việt Nam',
    N'Nhiều tác giả',
    'WEBSITE',
    N'https://example.org/trung-thu-viet-nam',
    N'Nguồn tham khảo tổng quan về Tết Trung Thu.',
    1
FROM dbo.BaiViet bv
WHERE bv.MaBaiViet = 'BV_TET_TRUNG_THU'
  AND NOT EXISTS (
      SELECT 1 FROM dbo.NguonThamKhao x
      WHERE x.BaiVietID = bv.BaiVietID
        AND x.TieuDeNguon = N'Lễ hội Trung Thu trong đời sống đô thị Việt Nam'
  );

INSERT INTO dbo.NguonThamKhao (
    BaiVietID, TieuDeNguon, TacGia, LoaiNguon, UrlNguon, GhiChu, LaNguonChinh
)
SELECT
    bv.BaiVietID,
    N'Pho and regional culinary identity',
    N'Food culture research notes',
    'RESEARCH',
    N'https://example.org/pho-regional-identity',
    N'Tài liệu tham khảo về phở và khác biệt vùng miền.',
    1
FROM dbo.BaiViet bv
WHERE bv.MaBaiViet = 'BV_PHO_VIET_NAM'
  AND NOT EXISTS (
      SELECT 1 FROM dbo.NguonThamKhao x
      WHERE x.BaiVietID = bv.BaiVietID
        AND x.TieuDeNguon = N'Pho and regional culinary identity'
  );

INSERT INTO dbo.NguonThamKhao (
    BaiVietID, TieuDeNguon, TacGia, LoaiNguon, UrlNguon, GhiChu, LaNguonChinh
)
SELECT
    bv.BaiVietID,
    N'Water puppetry and village performance traditions',
    N'Cultural heritage archive',
    'MUSEUM',
    N'https://example.org/water-puppetry-archive',
    N'Tài liệu giới thiệu lịch sử và giá trị nghệ thuật của múa rối nước.',
    1
FROM dbo.BaiViet bv
WHERE bv.MaBaiViet = 'BV_MUA_ROI_NUOC'
  AND NOT EXISTS (
      SELECT 1 FROM dbo.NguonThamKhao x
      WHERE x.BaiVietID = bv.BaiVietID
        AND x.TieuDeNguon = N'Water puppetry and village performance traditions'
  );

UPDATE dbo.BaiViet
SET
    TieuDeVI = N'Áo Dài: Linh Hồn Của Người Phụ Nữ Việt Nam',
    TieuDeEN = N'Ao Dai: The Soul of Vietnamese Women',
    MoTaNganVI = N'Tà áo dài thanh lịch không chỉ là trang phục truyền thống mà còn là biểu tượng văn hóa, sự duyên dáng và bản sắc riêng của người Việt.',
    MoTaNganEN = N'The elegant Ao Dai is not merely traditional attire but a cultural symbol of grace and the unique identity of Vietnamese people.',
    GioiThieuVI = N'Áo dài là biểu tượng văn hóa gắn liền với vẻ đẹp thanh lịch và tinh thần duyên dáng của người phụ nữ Việt Nam trong đời sống hiện đại lẫn truyền thống.',
    GioiThieuEN = N'Ao Dai is a cultural symbol closely tied to elegance and the graceful spirit of Vietnamese women in both modern and traditional life.',
    NguonGocVI = N'Áo dài hiện đại phát triển từ áo ngũ thân và nhiều dạng trang phục lịch sử, được cải biến để tôn dáng và phù hợp với nhịp sống mới.',
    NguonGocEN = N'The modern Ao Dai evolved from the five-panel gown and other historical garments, gradually refined to flatter the silhouette and fit contemporary life.',
    YNghiaVanHoaVI = N'Áo dài thể hiện sự kết nối giữa truyền thống và hiện đại, giữa bản sắc dân tộc và tinh thần thẩm mỹ tinh tế của người Việt.',
    YNghiaVanHoaEN = N'The Ao Dai expresses a bridge between tradition and modernity, between national identity and the refined aesthetic spirit of Vietnamese culture.',
    BoiCanhVI = N'Ngày nay, áo dài xuất hiện trong trường học, lễ cưới, sự kiện văn hóa, ngoại giao và thời trang, tiếp tục được tái diễn giải qua nhiều chất liệu và phong cách.',
    BoiCanhEN = N'Today, the Ao Dai appears in schools, weddings, cultural events, diplomacy, and fashion, continually reinterpreted through different materials and styles.',
    NoiDungChinhVI = N'Tà áo dài mềm mại đi cùng chiếc quần dài kín đáo đã trở thành hình ảnh gợi nhớ mạnh mẽ về Việt Nam. Qua từng giai đoạn, áo dài không chỉ thay đổi về phom dáng mà còn phản ánh quan niệm về vẻ đẹp, vai trò xã hội và niềm tự hào văn hóa. Chính khả năng thích ứng ấy giúp áo dài vừa trường tồn như di sản, vừa sống động trong đời sống đương đại.',
    NoiDungChinhEN = N'The flowing tunic paired with long trousers has become one of the most recognizable images of Vietnam. Across historical periods, the Ao Dai has changed in silhouette while continuing to reflect ideals of beauty, social roles, and cultural pride. That adaptability is what allows it to endure as heritage while remaining alive in contemporary life.',
    TomTatChoAIVI = N'Áo dài là biểu tượng trang phục Việt Nam, thể hiện sự thanh lịch, duyên dáng và khả năng dung hòa giữa truyền thống với hiện đại.',
    TomTatChoAIEN = N'The Ao Dai is a Vietnamese costume icon that embodies elegance, grace, and the harmony between tradition and modernity.'
WHERE MaBaiViet = 'BV_AO_DAI';

UPDATE dbo.BaiViet
SET
    TieuDeVI = N'Múa Rối Nước: Nghệ Thuật Độc Đáo Trên Mặt Nước',
    TieuDeEN = N'Water Puppetry: A Unique Art Form on the Water',
    MoTaNganVI = N'Xuất phát từ đồng bằng sông Hồng, múa rối nước là hình thức biểu diễn nghệ thuật truyền thống duy nhất trên thế giới dùng mặt nước làm sân khấu.',
    MoTaNganEN = N'Originating from the Red River Delta, water puppetry is the world''s only traditional art form using the water surface as its stage.',
    GioiThieuVI = N'Múa rối nước là loại hình sân khấu dân gian đặc sắc của Việt Nam, nơi con rối gỗ, âm nhạc và lời kể hòa quyện trên mặt nước để tái hiện nhịp sống làng quê.',
    GioiThieuEN = N'Water puppetry is a distinctive Vietnamese folk stage art where wooden puppets, music, and narration blend on the water to recreate village life.',
    NguonGocVI = N'Loại hình này hình thành từ các làng quê đồng bằng Bắc Bộ, nơi ao hồ và thủy đình trở thành không gian biểu diễn gắn với sinh hoạt nông nghiệp.',
    NguonGocEN = N'This art form emerged from villages in northern Vietnam, where ponds and water pavilions became performance spaces closely tied to agrarian life.',
    YNghiaVanHoaVI = N'Múa rối nước phản ánh trí tưởng tượng dân gian, tinh thần cộng đồng và khả năng kể chuyện sinh động bằng hình ảnh, âm thanh và chuyển động.',
    YNghiaVanHoaEN = N'Water puppetry reflects folk imagination, communal spirit, and the ability to tell vivid stories through image, sound, and movement.',
    BoiCanhVI = N'Ngày nay, múa rối nước vừa là di sản biểu diễn được bảo tồn, vừa là cầu nối đưa văn hóa Việt Nam đến với bạn bè quốc tế qua các chương trình sân khấu và du lịch.',
    BoiCanhEN = N'Today, water puppetry is both a preserved performance heritage and a bridge introducing Vietnamese culture to international audiences through theater and tourism.',
    NoiDungChinhVI = N'Từ những tích trò như chăn trâu, cấy lúa, múa rồng đến các truyền thuyết dân gian, múa rối nước mang đến một sân khấu giàu nhạc tính và sức gợi thị giác. Người nghệ nhân đứng sau phông thủy đình điều khiển con rối bằng hệ thống sào, dây tinh vi dưới mặt nước, tạo nên cảm giác kỳ ảo mà gần gũi. Chính sự hòa quyện giữa kỹ thuật, âm nhạc và đời sống dân gian đã làm nên sức hấp dẫn bền lâu của loại hình nghệ thuật này.',
    NoiDungChinhEN = N'From scenes of buffalo herding, rice planting, and dragon dances to folk legends, water puppetry creates a stage rich in music and visual charm. Hidden behind the water pavilion, puppeteers control the figures through sophisticated poles and strings beneath the water, producing a performance that feels both magical and familiar. This blend of technique, music, and everyday folk life is what gives the art form its lasting appeal.',
    TomTatChoAIVI = N'Múa rối nước là nghệ thuật biểu diễn dân gian độc đáo của đồng bằng Bắc Bộ, kết hợp sân khấu mặt nước, âm nhạc và con rối gỗ.',
    TomTatChoAIEN = N'Water puppetry is a unique folk performance tradition from northern Vietnam combining a water stage, music, and wooden puppets.'
WHERE MaBaiViet = 'BV_MUA_ROI_NUOC';

INSERT INTO dbo.BaiViet (
    MaBaiViet,
    TieuDeVI, TieuDeEN,
    MoTaNganVI, MoTaNganEN,
    GioiThieuVI, GioiThieuEN,
    NguonGocVI, NguonGocEN,
    YNghiaVanHoaVI, YNghiaVanHoaEN,
    BoiCanhVI, BoiCanhEN,
    NoiDungChinhVI, NoiDungChinhEN,
    TrangThaiDuyet, TrangThaiXuatBan, MucDoNhayCam,
    TrangThaiDongBoAI, AIChoPhep, TomTatChoAIVI, TomTatChoAIEN, SanSangChoAI,
    NgayGuiDuyet, NgayDuyet, NgayXuatBan,
    TaoBoi, CapNhatBoi, DuyetBoi
)
SELECT
    'BV_SON_MAI',
    N'Nghệ Thuật Sơn Mài: Tinh Hoa Hội Họa Việt Nam Nghìn Năm',
    N'Lacquer Art: A Thousand-Year Pinnacle of Vietnamese Painting',
    N'Khám phá bí mật đằng sau những lớp sơn huyền ảo, nơi vật liệu tự nhiên và bàn tay nghệ nhân tạo nên kiệt tác trường tồn theo thời gian.',
    N'Discover the secrets behind mysterious lacquer layers, where natural materials and artisan hands create masterpieces that stand the test of time.',
    N'Sơn mài là một trong những loại hình nghệ thuật độc đáo và tinh tế nhất của Việt Nam, bắt nguồn từ truyền thống sử dụng nhựa cây sơn để tạo ra những tác phẩm có vẻ đẹp lấp lánh, huyền bí và bền vững theo thời gian.',
    N'Lacquer art is one of the most unique and refined art forms in Vietnam, rooted in the tradition of using lacquer resin to create works of shimmering, mysterious, and enduring beauty.',
    N'Nghề sơn mài ở Việt Nam có lịch sử lâu đời, trải dài hơn 2.000 năm và gắn với các làng nghề truyền thống ở miền Bắc.',
    N'Lacquer craft in Vietnam has a long history spanning more than 2,000 years and is tied to traditional craft villages in the North.',
    N'Sơn mài thể hiện trí tuệ, sự kiên nhẫn và khả năng kết hợp thủ công với tư duy thẩm mỹ của người Việt.',
    N'Lacquer art expresses Vietnamese ingenuity, patience, and the ability to merge craftsmanship with aesthetic thinking.',
    N'Trong bối cảnh hiện đại, sơn mài tiếp tục được tái diễn giải qua các tác phẩm đương đại nhưng vẫn giữ được cốt lõi truyền thống.',
    N'In the modern era, lacquer art continues to be reinterpreted in contemporary works while preserving its traditional core.',
    N'Quy trình làm sơn mài đòi hỏi nhiều lớp phủ, mài và đánh bóng công phu. Mỗi tác phẩm là sự hòa quyện giữa kỹ thuật cổ truyền, vật liệu tự nhiên và cảm quan nghệ thuật sâu sắc.',
    N'The lacquer-making process requires many layers of coating, sanding, and polishing. Each work blends traditional technique, natural materials, and deep artistic sensibility.',
    'APPROVED',
    'PUBLISHED',
    1,
    'READY',
    1,
    N'Sơn mài là nghệ thuật thủ công hội họa đặc sắc của Việt Nam, nổi bật bởi chiều sâu thị giác và kỹ thuật nhiều lớp.',
    N'Lacquer art is a distinctive Vietnamese artistic craft known for visual depth and multilayered technique.',
    1,
    DATEADD(DAY, -16, SYSUTCDATETIME()),
    DATEADD(DAY, -15, SYSUTCDATETIME()),
    DATEADD(DAY, -14, SYSUTCDATETIME()),
    (SELECT NguoiDungID FROM dbo.NguoiDung WHERE Email = 'content@vnculturebridge.ai'),
    (SELECT NguoiDungID FROM dbo.NguoiDung WHERE Email = 'content@vnculturebridge.ai'),
    (SELECT NguoiDungID FROM dbo.NguoiDung WHERE Email = 'reviewer@vnculturebridge.ai')
WHERE NOT EXISTS (SELECT 1 FROM dbo.BaiViet WHERE MaBaiViet = 'BV_SON_MAI');

INSERT INTO dbo.BaiViet (
    MaBaiViet,
    TieuDeVI, TieuDeEN,
    MoTaNganVI, MoTaNganEN,
    GioiThieuVI, GioiThieuEN,
    NguonGocVI, NguonGocEN,
    YNghiaVanHoaVI, YNghiaVanHoaEN,
    BoiCanhVI, BoiCanhEN,
    NoiDungChinhVI, NoiDungChinhEN,
    TrangThaiDuyet, TrangThaiXuatBan, MucDoNhayCam,
    TrangThaiDongBoAI, AIChoPhep, TomTatChoAIVI, TomTatChoAIEN, SanSangChoAI,
    NgayGuiDuyet, NgayDuyet, NgayXuatBan,
    TaoBoi, CapNhatBoi, DuyetBoi
)
SELECT
    'BV_TRANH_DONG_HO',
    N'Tranh Đông Hồ: Nét Dân Gian Trong Từng Bức Khắc',
    N'Dong Ho Painting: Folk Art in Every Wood Block',
    N'Từ giấy điệp óng ánh đến màu sắc thiên nhiên, tranh Đông Hồ là lời kể chuyện đời sống làng quê Việt Nam qua những bản khắc gỗ độc đáo.',
    N'From shimmering do paper to natural colors, Dong Ho paintings narrate Vietnamese village life through unique woodblock prints.',
    N'Tranh Đông Hồ là dòng tranh dân gian nổi tiếng của Bắc Ninh, phản ánh đời sống, tín ngưỡng và ước vọng của người Việt.',
    N'Dong Ho painting is a famous folk painting tradition from Bac Ninh, reflecting Vietnamese life, beliefs, and aspirations.',
    N'Dòng tranh hình thành ở làng Đông Hồ với kỹ thuật in ván gỗ và sử dụng màu sắc từ nguyên liệu tự nhiên.',
    N'The painting tradition emerged in Dong Ho village through woodblock printing and natural pigments.',
    N'Tranh Đông Hồ thể hiện vẻ đẹp bình dị, tính biểu tượng và tinh thần lạc quan trong văn hóa dân gian.',
    N'Dong Ho painting expresses simplicity, symbolism, and optimism within folk culture.',
    N'Ngày nay, tranh Đông Hồ vừa là di sản thủ công vừa là nguồn cảm hứng cho giáo dục mỹ thuật và sáng tạo đương đại.',
    N'Today, Dong Ho painting is both a craft heritage and a source of inspiration for art education and contemporary creativity.',
    N'Những bức tranh thường tái hiện cảnh sinh hoạt, chúc phúc, phong tục và các biểu tượng quen thuộc của làng quê Việt Nam. Kỹ thuật in chồng màu tạo nên vẻ mộc mạc nhưng giàu sức gợi.',
    N'These paintings often depict daily life, blessings, customs, and familiar symbols of Vietnamese rural life. Layered block-printing creates a rustic yet evocative aesthetic.',
    'APPROVED',
    'PUBLISHED',
    1,
    'READY',
    1,
    N'Tranh Đông Hồ là dòng tranh dân gian tiêu biểu của Bắc Ninh, nổi bật bởi kỹ thuật in ván gỗ và màu sắc tự nhiên.',
    N'Dong Ho painting is a representative folk art from Bac Ninh known for woodblock printing and natural colors.',
    1,
    DATEADD(DAY, -15, SYSUTCDATETIME()),
    DATEADD(DAY, -14, SYSUTCDATETIME()),
    DATEADD(DAY, -13, SYSUTCDATETIME()),
    (SELECT NguoiDungID FROM dbo.NguoiDung WHERE Email = 'content@vnculturebridge.ai'),
    (SELECT NguoiDungID FROM dbo.NguoiDung WHERE Email = 'content@vnculturebridge.ai'),
    (SELECT NguoiDungID FROM dbo.NguoiDung WHERE Email = 'reviewer@vnculturebridge.ai')
WHERE NOT EXISTS (SELECT 1 FROM dbo.BaiViet WHERE MaBaiViet = 'BV_TRANH_DONG_HO');

INSERT INTO dbo.BaiViet (
    MaBaiViet,
    TieuDeVI, TieuDeEN,
    MoTaNganVI, MoTaNganEN,
    GioiThieuVI, GioiThieuEN,
    NguonGocVI, NguonGocEN,
    YNghiaVanHoaVI, YNghiaVanHoaEN,
    BoiCanhVI, BoiCanhEN,
    NoiDungChinhVI, NoiDungChinhEN,
    TrangThaiDuyet, TrangThaiXuatBan, MucDoNhayCam,
    TrangThaiDongBoAI, AIChoPhep, TomTatChoAIVI, TomTatChoAIEN, SanSangChoAI,
    NgayGuiDuyet, NgayDuyet, NgayXuatBan,
    TaoBoi, CapNhatBoi, DuyetBoi
)
SELECT
    'BV_GOM_BAT_TRANG',
    N'Gốm Bát Tràng: Di Sản 500 Năm Bên Dòng Sông Hồng',
    N'Bat Trang Pottery: 500-Year Heritage on Red River Bank',
    N'Làng gốm cổ nhất Việt Nam vẫn giữ nguyên bí quyết nung đất sét trắng làm nên những sản phẩm tinh xảo nổi tiếng khắp thế giới.',
    N'Vietnam''s oldest pottery village still preserves the secret of firing white clay into exquisitely crafted products famous worldwide.',
    N'Gốm Bát Tràng là biểu tượng của thủ công mỹ nghệ Việt Nam với lịch sử lâu đời và kỹ thuật tạo hình, nung gốm tinh xảo.',
    N'Bat Trang pottery symbolizes Vietnamese craftsmanship through its long history and refined forming and firing techniques.',
    N'Làng gốm phát triển bên sông Hồng, tận dụng nguồn đất sét tốt và vị trí giao thương thuận lợi để trở thành trung tâm gốm nổi bật.',
    N'The pottery village developed along the Red River, using quality clay and favorable trade access to become a major ceramic center.',
    N'Bát Tràng thể hiện khả năng dung hòa giữa công năng sử dụng, tính thẩm mỹ và bản sắc làng nghề truyền thống.',
    N'Bat Trang reflects the balance between utility, beauty, and traditional craft-village identity.',
    N'Ngày nay, gốm Bát Tràng vừa phục vụ đời sống hàng ngày vừa hiện diện trong du lịch trải nghiệm, sáng tạo quà tặng và thiết kế nội thất.',
    N'Today, Bat Trang pottery serves daily life while also appearing in experiential tourism, gift design, and interior decoration.',
    N'Từ đồ gia dụng đến tác phẩm trang trí, mỗi sản phẩm Bát Tràng đều mang dấu ấn của kỹ thuật vuốt, men và lò nung truyền thống. Đây là minh chứng sống động cho sức sống bền bỉ của nghề gốm Việt.',
    N'From household utensils to decorative works, each Bat Trang product bears the mark of shaping, glazing, and traditional kiln practices. It stands as vivid proof of the enduring vitality of Vietnamese pottery.',
    'APPROVED',
    'PUBLISHED',
    1,
    'READY',
    1,
    N'Gốm Bát Tràng là di sản thủ công nổi tiếng bên sông Hồng, tiêu biểu cho kỹ thuật tạo hình và men gốm Việt.',
    N'Bat Trang pottery is a renowned craft heritage on the Red River, celebrated for shaping and glazing techniques.',
    1,
    DATEADD(DAY, -14, SYSUTCDATETIME()),
    DATEADD(DAY, -13, SYSUTCDATETIME()),
    DATEADD(DAY, -12, SYSUTCDATETIME()),
    (SELECT NguoiDungID FROM dbo.NguoiDung WHERE Email = 'content@vnculturebridge.ai'),
    (SELECT NguoiDungID FROM dbo.NguoiDung WHERE Email = 'content@vnculturebridge.ai'),
    (SELECT NguoiDungID FROM dbo.NguoiDung WHERE Email = 'reviewer@vnculturebridge.ai')
WHERE NOT EXISTS (SELECT 1 FROM dbo.BaiViet WHERE MaBaiViet = 'BV_GOM_BAT_TRANG');

INSERT INTO dbo.BaiViet (
    MaBaiViet,
    TieuDeVI, TieuDeEN,
    MoTaNganVI, MoTaNganEN,
    GioiThieuVI, GioiThieuEN,
    NguonGocVI, NguonGocEN,
    YNghiaVanHoaVI, YNghiaVanHoaEN,
    BoiCanhVI, BoiCanhEN,
    NoiDungChinhVI, NoiDungChinhEN,
    TrangThaiDuyet, TrangThaiXuatBan, MucDoNhayCam,
    TrangThaiDongBoAI, AIChoPhep, TomTatChoAIVI, TomTatChoAIEN, SanSangChoAI,
    NgayGuiDuyet, NgayDuyet, NgayXuatBan,
    TaoBoi, CapNhatBoi, DuyetBoi
)
SELECT
    'BV_LUA_HA_DONG',
    N'Lụa Hà Đông: Tinh Hoa Bền Vững Qua Nghìn Năm',
    N'Ha Dong Silk: Enduring Craft Through A Millennium',
    N'Những sợi lụa mỏng manh từ làng Vạn Phúc mang theo cả nghìn năm tri thức dệt lụa, tạo nên vẻ đẹp sang trọng không thể nhầm lẫn.',
    N'Delicate silk threads from Van Phuc village carry a thousand years of weaving knowledge, creating unmistakably elegant beauty.',
    N'Lụa Hà Đông là biểu tượng của nghề dệt tơ lụa truyền thống, gắn với sự tinh tế trong chất liệu và kỹ thuật thủ công.',
    N'Ha Dong silk symbolizes the traditional silk-weaving craft, marked by refined materials and artisanal technique.',
    N'Làng Vạn Phúc nổi tiếng với nghề dệt lụa lâu đời, nơi kỹ thuật thủ công được gìn giữ và truyền lại qua nhiều thế hệ.',
    N'Van Phuc village is renowned for its long-standing silk weaving tradition, where artisanal techniques have been preserved across generations.',
    N'Lụa Hà Đông thể hiện vẻ đẹp thanh lịch, sự bền bỉ của nghề thủ công và niềm tự hào về sản phẩm tinh xảo của Việt Nam.',
    N'Ha Dong silk embodies elegance, the resilience of craftsmanship, and pride in Vietnamese fine products.',
    N'Ngày nay, lụa Hà Đông vừa hiện diện trong thời trang truyền thống vừa là chất liệu cho thiết kế hiện đại và quà tặng văn hóa.',
    N'Today, Ha Dong silk appears in both traditional fashion and contemporary design as well as cultural gifts.',
    N'Từng khung cửi, sợi tơ và hoa văn dệt nên câu chuyện về lao động, tay nghề và gu thẩm mỹ của người Việt. Lụa Hà Đông vì thế không chỉ là vật liệu mà còn là biểu tượng văn hóa sống động.',
    N'Each loom, silk thread, and woven motif tells a story of labor, skill, and Vietnamese aesthetic taste. Ha Dong silk is therefore not only a material but a vivid cultural symbol.',
    'APPROVED',
    'PUBLISHED',
    1,
    'READY',
    1,
    N'Lụa Hà Đông là tinh hoa dệt lụa truyền thống, nổi bật bởi độ mềm mại, thanh lịch và giá trị văn hóa lâu đời.',
    N'Ha Dong silk is a traditional weaving treasure known for softness, elegance, and long-standing cultural value.',
    1,
    DATEADD(DAY, -13, SYSUTCDATETIME()),
    DATEADD(DAY, -12, SYSUTCDATETIME()),
    DATEADD(DAY, -11, SYSUTCDATETIME()),
    (SELECT NguoiDungID FROM dbo.NguoiDung WHERE Email = 'content@vnculturebridge.ai'),
    (SELECT NguoiDungID FROM dbo.NguoiDung WHERE Email = 'content@vnculturebridge.ai'),
    (SELECT NguoiDungID FROM dbo.NguoiDung WHERE Email = 'reviewer@vnculturebridge.ai')
WHERE NOT EXISTS (SELECT 1 FROM dbo.BaiViet WHERE MaBaiViet = 'BV_LUA_HA_DONG');

INSERT INTO dbo.BaiViet (
    MaBaiViet,
    TieuDeVI, TieuDeEN,
    MoTaNganVI, MoTaNganEN,
    GioiThieuVI, GioiThieuEN,
    NguonGocVI, NguonGocEN,
    YNghiaVanHoaVI, YNghiaVanHoaEN,
    BoiCanhVI, BoiCanhEN,
    NoiDungChinhVI, NoiDungChinhEN,
    TrangThaiDuyet, TrangThaiXuatBan, MucDoNhayCam,
    TrangThaiDongBoAI, AIChoPhep, TomTatChoAIVI, TomTatChoAIEN, SanSangChoAI,
    NgayGuiDuyet, NgayDuyet, NgayXuatBan,
    TaoBoi, CapNhatBoi, DuyetBoi
)
SELECT
    'BV_NHA_NHAC_CUNG_DINH',
    N'Nhã Nhạc Cung Đình Huế: Di Sản Âm Nhạc UNESCO',
    N'Hue Royal Court Music: UNESCO Musical Heritage',
    N'Những giai điệu trang trọng từ cung đình Huế đã được UNESCO công nhận là di sản văn hóa phi vật thể, mang âm hưởng nghìn năm lịch sử.',
    N'The solemn melodies from Hue Imperial Palace have been recognized by UNESCO as intangible cultural heritage, resonating with a millennium of history.',
    N'Nhã nhạc cung đình Huế là hình thức âm nhạc lễ nghi gắn với đời sống cung đình và các nghi thức trang trọng của triều Nguyễn.',
    N'Hue royal court music is a ceremonial musical form tied to court life and formal rituals of the Nguyen dynasty.',
    N'Loại hình này hình thành và phát triển trong môi trường cung đình, nơi âm nhạc giữ vai trò thể hiện quyền uy, trật tự và mỹ cảm.',
    N'This form developed within the royal court, where music expressed authority, order, and aesthetic refinement.',
    N'Nhã nhạc thể hiện chiều sâu nghệ thuật trình diễn, tính trang nghiêm và vai trò của âm thanh trong nghi lễ truyền thống.',
    N'Royal court music expresses performative depth, solemnity, and the role of sound in traditional ritual.',
    N'Ngày nay, nhã nhạc được bảo tồn và trình diễn trong không gian di sản Huế, giúp công chúng tiếp cận gần hơn với nghệ thuật cung đình.',
    N'Today, royal court music is preserved and performed in Hue heritage spaces, bringing court art closer to the public.',
    N'Nhã nhạc không chỉ là giai điệu mà còn là tổng hòa của nghi thức, phục trang, không gian và nhịp điệu biểu đạt. Việc UNESCO ghi danh càng khẳng định giá trị của loại hình này trong kho tàng di sản Việt Nam.',
    N'Royal court music is not merely melody but a synthesis of ritual, costume, space, and expressive rhythm. UNESCO recognition further confirms its value in Vietnam''s heritage treasury.',
    'APPROVED',
    'PUBLISHED',
    1,
    'READY',
    1,
    N'Nhã nhạc cung đình Huế là di sản âm nhạc cung đình tiêu biểu, được UNESCO ghi danh và gắn với nghi lễ triều Nguyễn.',
    N'Hue royal court music is a representative ceremonial heritage recognized by UNESCO and linked to Nguyen dynasty ritual life.',
    1,
    DATEADD(DAY, -12, SYSUTCDATETIME()),
    DATEADD(DAY, -11, SYSUTCDATETIME()),
    DATEADD(DAY, -10, SYSUTCDATETIME()),
    (SELECT NguoiDungID FROM dbo.NguoiDung WHERE Email = 'content@vnculturebridge.ai'),
    (SELECT NguoiDungID FROM dbo.NguoiDung WHERE Email = 'content@vnculturebridge.ai'),
    (SELECT NguoiDungID FROM dbo.NguoiDung WHERE Email = 'reviewer@vnculturebridge.ai')
WHERE NOT EXISTS (SELECT 1 FROM dbo.BaiViet WHERE MaBaiViet = 'BV_NHA_NHAC_CUNG_DINH');

INSERT INTO dbo.BaiViet (
    MaBaiViet,
    TieuDeVI, TieuDeEN,
    MoTaNganVI, MoTaNganEN,
    GioiThieuVI, GioiThieuEN,
    NguonGocVI, NguonGocEN,
    YNghiaVanHoaVI, YNghiaVanHoaEN,
    BoiCanhVI, BoiCanhEN,
    NoiDungChinhVI, NoiDungChinhEN,
    TrangThaiDuyet, TrangThaiXuatBan, MucDoNhayCam,
    TrangThaiDongBoAI, AIChoPhep, TomTatChoAIVI, TomTatChoAIEN, SanSangChoAI,
    NgayGuiDuyet, NgayDuyet, NgayXuatBan,
    TaoBoi, CapNhatBoi, DuyetBoi
)
SELECT
    'BV_KIEN_TRUC_HOI_AN',
    N'Kiến Trúc Hội An: Giao Thoa Văn Hóa Đông-Tây',
    N'Hoi An Architecture: East-West Cultural Fusion',
    N'Phố cổ Hội An là minh chứng sống động cho sự giao thoa văn hóa Việt-Hoa-Nhật-Pháp, tạo nên một di sản kiến trúc độc đáo không nơi nào có.',
    N'Hoi An Ancient Town is a vivid testament to the cultural fusion of Vietnamese-Chinese-Japanese-French, creating a unique architectural heritage found nowhere else.',
    N'Kiến trúc Hội An phản ánh lịch sử thương cảng và sự gặp gỡ của nhiều cộng đồng cư dân trong cùng một không gian đô thị cổ.',
    N'Hoi An architecture reflects the history of a trading port and the encounter of many communities within one old urban space.',
    N'Phố cổ phát triển từ hoạt động giao thương quốc tế, hấp thụ nhiều ảnh hưởng nhưng vẫn gìn giữ hồn cốt bản địa.',
    N'The old town grew from international trade, absorbing many influences while preserving its local essence.',
    N'Kiến trúc Hội An thể hiện khả năng dung hòa văn hóa, thẩm mỹ đô thị và ký ức lịch sử trong cùng một quần thể.',
    N'Hoi An architecture demonstrates the ability to harmonize culture, urban aesthetics, and historical memory within one ensemble.',
    N'Ngày nay, Hội An là điểm đến di sản nổi bật, nơi kiến trúc cổ được bảo tồn song hành với đời sống du lịch và văn hóa đương đại.',
    N'Today, Hoi An is a prominent heritage destination where old architecture is preserved alongside tourism and contemporary cultural life.',
    N'Từ mái nhà, con phố đến hội quán và chùa cầu, mỗi chi tiết của Hội An đều kể một câu chuyện về trao đổi thương mại, di cư và sáng tạo bản địa. Đây là một trong những không gian kiến trúc giàu bản sắc nhất Việt Nam.',
    N'From rooftops and streets to assembly halls and the Japanese Bridge, every detail of Hoi An tells a story of trade, migration, and local creativity. It remains one of Vietnam''s most distinctive architectural environments.',
    'APPROVED',
    'PUBLISHED',
    1,
    'READY',
    1,
    N'Kiến trúc Hội An là di sản đô thị tiêu biểu, phản ánh sự giao thoa văn hóa và lịch sử thương cảng Việt Nam.',
    N'Hoi An architecture is a representative urban heritage reflecting cultural exchange and the history of Vietnam''s trading ports.',
    1,
    DATEADD(DAY, -11, SYSUTCDATETIME()),
    DATEADD(DAY, -10, SYSUTCDATETIME()),
    DATEADD(DAY, -9, SYSUTCDATETIME()),
    (SELECT NguoiDungID FROM dbo.NguoiDung WHERE Email = 'content@vnculturebridge.ai'),
    (SELECT NguoiDungID FROM dbo.NguoiDung WHERE Email = 'content@vnculturebridge.ai'),
    (SELECT NguoiDungID FROM dbo.NguoiDung WHERE Email = 'reviewer@vnculturebridge.ai')
WHERE NOT EXISTS (SELECT 1 FROM dbo.BaiViet WHERE MaBaiViet = 'BV_KIEN_TRUC_HOI_AN');

INSERT INTO dbo.BaiViet_DanhMuc (BaiVietID, DanhMucID, LaDanhMucChinh)
SELECT bv.BaiVietID, dm.DanhMucID, 1
FROM dbo.BaiViet bv
JOIN dbo.DanhMuc dm ON dm.MaDanhMuc = 'NGHE_THUAT_DAN_GIAN'
WHERE bv.MaBaiViet IN ('BV_SON_MAI', 'BV_TRANH_DONG_HO', 'BV_GOM_BAT_TRANG', 'BV_LUA_HA_DONG', 'BV_MUA_ROI_NUOC', 'BV_NHA_NHAC_CUNG_DINH', 'BV_KIEN_TRUC_HOI_AN')
  AND NOT EXISTS (
      SELECT 1 FROM dbo.BaiViet_DanhMuc x
      WHERE x.BaiVietID = bv.BaiVietID AND x.DanhMucID = dm.DanhMucID
  );

INSERT INTO dbo.BaiViet_DanhMuc (BaiVietID, DanhMucID, LaDanhMucChinh)
SELECT bv.BaiVietID, dm.DanhMucID, 0
FROM dbo.BaiViet bv
JOIN dbo.DanhMuc dm ON dm.MaDanhMuc = 'TRANG_PHUC'
WHERE bv.MaBaiViet = 'BV_AO_DAI'
  AND NOT EXISTS (
      SELECT 1 FROM dbo.BaiViet_DanhMuc x
      WHERE x.BaiVietID = bv.BaiVietID AND x.DanhMucID = dm.DanhMucID
  );

INSERT INTO dbo.BaiViet_Vung (BaiVietID, VungID, LaVungChinh)
SELECT bv.BaiVietID, vv.VungID, 1
FROM dbo.BaiViet bv
JOIN dbo.VungVanHoa vv ON vv.MaVung = 'BAC_BO'
WHERE bv.MaBaiViet IN ('BV_SON_MAI', 'BV_TRANH_DONG_HO', 'BV_GOM_BAT_TRANG', 'BV_LUA_HA_DONG', 'BV_MUA_ROI_NUOC')
  AND NOT EXISTS (
      SELECT 1 FROM dbo.BaiViet_Vung x
      WHERE x.BaiVietID = bv.BaiVietID AND x.VungID = vv.VungID
  );

INSERT INTO dbo.BaiViet_Vung (BaiVietID, VungID, LaVungChinh)
SELECT bv.BaiVietID, vv.VungID, 1
FROM dbo.BaiViet bv
JOIN dbo.VungVanHoa vv ON vv.MaVung = 'TRUNG_BO'
WHERE bv.MaBaiViet IN ('BV_NHA_NHAC_CUNG_DINH', 'BV_KIEN_TRUC_HOI_AN', 'BV_HUE_FESTIVAL', 'BV_AO_DAI')
  AND NOT EXISTS (
      SELECT 1 FROM dbo.BaiViet_Vung x
      WHERE x.BaiVietID = bv.BaiVietID AND x.VungID = vv.VungID
  );

INSERT INTO dbo.BaiViet_DanToc (BaiVietID, DanTocID, LaDanTocChinh)
SELECT bv.BaiVietID, dt.DanTocID, 1
FROM dbo.BaiViet bv
JOIN dbo.DanToc dt ON dt.MaDanToc = 'KINH'
WHERE bv.MaBaiViet IN ('BV_SON_MAI', 'BV_TRANH_DONG_HO', 'BV_GOM_BAT_TRANG', 'BV_LUA_HA_DONG', 'BV_AO_DAI', 'BV_MUA_ROI_NUOC', 'BV_NHA_NHAC_CUNG_DINH', 'BV_KIEN_TRUC_HOI_AN')
  AND NOT EXISTS (
      SELECT 1 FROM dbo.BaiViet_DanToc x
      WHERE x.BaiVietID = bv.BaiVietID AND x.DanTocID = dt.DanTocID
  );

INSERT INTO dbo.BaiViet_LienQuan (BaiVietID, BaiVietLienQuanID, LoaiLienQuan)
SELECT b1.BaiVietID, b2.BaiVietID, 'RELATED'
FROM dbo.BaiViet b1
JOIN dbo.BaiViet b2 ON b2.MaBaiViet = 'BV_TRANH_DONG_HO'
WHERE b1.MaBaiViet = 'BV_SON_MAI'
  AND NOT EXISTS (
      SELECT 1 FROM dbo.BaiViet_LienQuan x
      WHERE x.BaiVietID = b1.BaiVietID AND x.BaiVietLienQuanID = b2.BaiVietID
  );

INSERT INTO dbo.BaiViet_LienQuan (BaiVietID, BaiVietLienQuanID, LoaiLienQuan)
SELECT b1.BaiVietID, b2.BaiVietID, 'RELATED'
FROM dbo.BaiViet b1
JOIN dbo.BaiViet b2 ON b2.MaBaiViet = 'BV_GOM_BAT_TRANG'
WHERE b1.MaBaiViet = 'BV_TRANH_DONG_HO'
  AND NOT EXISTS (
      SELECT 1 FROM dbo.BaiViet_LienQuan x
      WHERE x.BaiVietID = b1.BaiVietID AND x.BaiVietLienQuanID = b2.BaiVietID
  );

INSERT INTO dbo.BaiViet_LienQuan (BaiVietID, BaiVietLienQuanID, LoaiLienQuan)
SELECT b1.BaiVietID, b2.BaiVietID, 'RELATED'
FROM dbo.BaiViet b1
JOIN dbo.BaiViet b2 ON b2.MaBaiViet = 'BV_LUA_HA_DONG'
WHERE b1.MaBaiViet = 'BV_GOM_BAT_TRANG'
  AND NOT EXISTS (
      SELECT 1 FROM dbo.BaiViet_LienQuan x
      WHERE x.BaiVietID = b1.BaiVietID AND x.BaiVietLienQuanID = b2.BaiVietID
  );

INSERT INTO dbo.BaiViet_LienQuan (BaiVietID, BaiVietLienQuanID, LoaiLienQuan)
SELECT b1.BaiVietID, b2.BaiVietID, 'RELATED'
FROM dbo.BaiViet b1
JOIN dbo.BaiViet b2 ON b2.MaBaiViet = 'BV_AO_DAI'
WHERE b1.MaBaiViet = 'BV_LUA_HA_DONG'
  AND NOT EXISTS (
      SELECT 1 FROM dbo.BaiViet_LienQuan x
      WHERE x.BaiVietID = b1.BaiVietID AND x.BaiVietLienQuanID = b2.BaiVietID
  );

INSERT INTO dbo.BaiViet_LienQuan (BaiVietID, BaiVietLienQuanID, LoaiLienQuan)
SELECT b1.BaiVietID, b2.BaiVietID, 'RELATED'
FROM dbo.BaiViet b1
JOIN dbo.BaiViet b2 ON b2.MaBaiViet = 'BV_NHA_NHAC_CUNG_DINH'
WHERE b1.MaBaiViet = 'BV_AO_DAI'
  AND NOT EXISTS (
      SELECT 1 FROM dbo.BaiViet_LienQuan x
      WHERE x.BaiVietID = b1.BaiVietID AND x.BaiVietLienQuanID = b2.BaiVietID
  );

INSERT INTO dbo.BaiViet_LienQuan (BaiVietID, BaiVietLienQuanID, LoaiLienQuan)
SELECT b1.BaiVietID, b2.BaiVietID, 'RELATED'
FROM dbo.BaiViet b1
JOIN dbo.BaiViet b2 ON b2.MaBaiViet = 'BV_KIEN_TRUC_HOI_AN'
WHERE b1.MaBaiViet = 'BV_NHA_NHAC_CUNG_DINH'
  AND NOT EXISTS (
      SELECT 1 FROM dbo.BaiViet_LienQuan x
      WHERE x.BaiVietID = b1.BaiVietID AND x.BaiVietLienQuanID = b2.BaiVietID
  );

UPDATE dbo.Media
SET
    AltTextVI = N'Tác phẩm sơn mài Việt Nam',
    AltTextEN = N'Vietnamese lacquer artwork',
    ChuThichVI = N'Hình ảnh tác phẩm sơn mài với nhiều lớp màu và độ bóng sâu.' ,
    ChuThichEN = N'Image of a lacquer artwork with layered color and deep shine.'
WHERE BaiVietID = (SELECT TOP 1 BaiVietID FROM dbo.BaiViet WHERE MaBaiViet = 'BV_SON_MAI')
  AND LaAnhChinh = 1;

UPDATE dbo.Media
SET
    AltTextVI = N'Tranh Đông Hồ dân gian',
    AltTextEN = N'Dong Ho folk painting',
    ChuThichVI = N'Hình ảnh tranh Đông Hồ với màu sắc tự nhiên và ván khắc.',
    ChuThichEN = N'Image of Dong Ho painting with natural pigments and carved woodblocks.'
WHERE BaiVietID = (SELECT TOP 1 BaiVietID FROM dbo.BaiViet WHERE MaBaiViet = 'BV_TRANH_DONG_HO')
  AND LaAnhChinh = 1;

UPDATE dbo.Media
SET
    AltTextVI = N'Gốm Bát Tràng truyền thống',
    AltTextEN = N'Bat Trang traditional pottery',
    ChuThichVI = N'Hình ảnh sản phẩm gốm Bát Tràng với men gốm đặc trưng.',
    ChuThichEN = N'Image of Bat Trang pottery with signature glaze.'
WHERE BaiVietID = (SELECT TOP 1 BaiVietID FROM dbo.BaiViet WHERE MaBaiViet = 'BV_GOM_BAT_TRANG')
  AND LaAnhChinh = 1;

UPDATE dbo.Media
SET
    AltTextVI = N'Lụa Hà Đông truyền thống',
    AltTextEN = N'Ha Dong traditional silk',
    ChuThichVI = N'Hình ảnh lụa Hà Đông với sắc độ mềm mại và tinh tế.',
    ChuThichEN = N'Image of Ha Dong silk with soft elegant tones.'
WHERE BaiVietID = (SELECT TOP 1 BaiVietID FROM dbo.BaiViet WHERE MaBaiViet = 'BV_LUA_HA_DONG')
  AND LaAnhChinh = 1;

UPDATE dbo.Media
SET
    AltTextVI = N'Áo dài truyền thống Việt Nam',
    AltTextEN = N'Traditional Vietnamese Ao Dai',
    ChuThichVI = N'Hình ảnh áo dài với phom dáng thanh lịch và biểu tượng văn hóa Việt.',
    ChuThichEN = N'Image of the Ao Dai with its elegant silhouette and Vietnamese cultural symbolism.'
WHERE BaiVietID = (SELECT TOP 1 BaiVietID FROM dbo.BaiViet WHERE MaBaiViet = 'BV_AO_DAI')
  AND LaAnhChinh = 1;

UPDATE dbo.Media
SET
    AltTextVI = N'Nhã nhạc cung đình Huế trong biểu diễn',
    AltTextEN = N'Hue royal court music performance',
    ChuThichVI = N'Hình ảnh nhã nhạc cung đình Huế trong không gian biểu diễn truyền thống.',
    ChuThichEN = N'Image of Hue royal court music in a traditional performance setting.'
WHERE BaiVietID = (SELECT TOP 1 BaiVietID FROM dbo.BaiViet WHERE MaBaiViet = 'BV_NHA_NHAC_CUNG_DINH')
  AND LaAnhChinh = 1;

UPDATE dbo.Media
SET
    AltTextVI = N'Múa rối nước trên sân khấu mặt nước',
    AltTextEN = N'Water puppetry on a water stage',
    ChuThichVI = N'Hình ảnh trình diễn múa rối nước truyền thống.',
    ChuThichEN = N'An image of a traditional water puppetry performance.'
WHERE BaiVietID = (SELECT TOP 1 BaiVietID FROM dbo.BaiViet WHERE MaBaiViet = 'BV_MUA_ROI_NUOC')
  AND LaAnhChinh = 1;

UPDATE dbo.Media
SET
    AltTextVI = N'Không gian kiến trúc Hội An cổ',
    AltTextEN = N'Historic architecture of Hoi An',
    ChuThichVI = N'Hình ảnh phố cổ Hội An với kiến trúc giao thoa văn hóa.',
    ChuThichEN = N'Image of Hoi An ancient town with cross-cultural architecture.'
WHERE BaiVietID = (SELECT TOP 1 BaiVietID FROM dbo.BaiViet WHERE MaBaiViet = 'BV_KIEN_TRUC_HOI_AN')
  AND LaAnhChinh = 1;

INSERT INTO dbo.Media (
    BaiVietID, LoaiMedia, UrlFile,
    AltTextVI, AltTextEN, ChuThichVI, ChuThichEN,
    LaAnhChinh, ThuTuHienThi
)
SELECT bv.BaiVietID, 'IMAGE', N'https://images.unsplash.com/photo-1579783901586-d88db74b4fe4?w=1200', N'Tác phẩm sơn mài Việt Nam', N'Vietnamese lacquer artwork', N'Hình ảnh tác phẩm sơn mài với nhiều lớp màu và độ bóng sâu.', N'Image of a lacquer artwork with layered color and deep shine.', 1, 1
FROM dbo.BaiViet bv
WHERE bv.MaBaiViet = 'BV_SON_MAI'
  AND NOT EXISTS (
      SELECT 1 FROM dbo.Media x
      WHERE x.BaiVietID = bv.BaiVietID AND x.LaAnhChinh = 1
  );

INSERT INTO dbo.Media (
    BaiVietID, LoaiMedia, UrlFile,
    AltTextVI, AltTextEN, ChuThichVI, ChuThichEN,
    LaAnhChinh, ThuTuHienThi
)
SELECT bv.BaiVietID, 'IMAGE', N'https://images.unsplash.com/photo-1567689265664-3bc6e1e4b07b?w=1200', N'Tranh Đông Hồ dân gian', N'Dong Ho folk painting', N'Hình ảnh tranh Đông Hồ với màu sắc tự nhiên và ván khắc.', N'Image of Dong Ho painting with natural pigments and carved woodblocks.', 1, 1
FROM dbo.BaiViet bv
WHERE bv.MaBaiViet = 'BV_TRANH_DONG_HO'
  AND NOT EXISTS (
      SELECT 1 FROM dbo.Media x
      WHERE x.BaiVietID = bv.BaiVietID AND x.LaAnhChinh = 1
  );

INSERT INTO dbo.Media (
    BaiVietID, LoaiMedia, UrlFile,
    AltTextVI, AltTextEN, ChuThichVI, ChuThichEN,
    LaAnhChinh, ThuTuHienThi
)
SELECT bv.BaiVietID, 'IMAGE', N'https://images.unsplash.com/photo-1619164601044-90e0e1d0e87b?w=1200', N'Gốm Bát Tràng truyền thống', N'Bat Trang traditional pottery', N'Hình ảnh sản phẩm gốm Bát Tràng với men gốm đặc trưng.', N'Image of Bat Trang pottery with signature glaze.', 1, 1
FROM dbo.BaiViet bv
WHERE bv.MaBaiViet = 'BV_GOM_BAT_TRANG'
  AND NOT EXISTS (
      SELECT 1 FROM dbo.Media x
      WHERE x.BaiVietID = bv.BaiVietID AND x.LaAnhChinh = 1
  );

INSERT INTO dbo.Media (
    BaiVietID, LoaiMedia, UrlFile,
    AltTextVI, AltTextEN, ChuThichVI, ChuThichEN,
    LaAnhChinh, ThuTuHienThi
)
SELECT bv.BaiVietID, 'IMAGE', N'https://images.unsplash.com/photo-1565958011703-44f9829ba187?w=1200', N'Lụa Hà Đông truyền thống', N'Ha Dong traditional silk', N'Hình ảnh lụa Hà Đông với sắc độ mềm mại và tinh tế.', N'Image of Ha Dong silk with soft elegant tones.', 1, 1
FROM dbo.BaiViet bv
WHERE bv.MaBaiViet = 'BV_LUA_HA_DONG'
  AND NOT EXISTS (
      SELECT 1 FROM dbo.Media x
      WHERE x.BaiVietID = bv.BaiVietID AND x.LaAnhChinh = 1
  );

INSERT INTO dbo.Media (
    BaiVietID, LoaiMedia, UrlFile,
    AltTextVI, AltTextEN, ChuThichVI, ChuThichEN,
    LaAnhChinh, ThuTuHienThi
)
SELECT bv.BaiVietID, 'IMAGE', N'https://cdn.vnculturebridge.ai/media/ao-dai/ao-dai-truyen-thong.jpg', N'Áo dài truyền thống Việt Nam', N'Traditional Vietnamese Ao Dai', N'Hình ảnh áo dài với phom dáng thanh lịch và biểu tượng văn hóa Việt.', N'Image of the Ao Dai with its elegant silhouette and Vietnamese cultural symbolism.', 1, 1
FROM dbo.BaiViet bv
WHERE bv.MaBaiViet = 'BV_AO_DAI'
  AND NOT EXISTS (
      SELECT 1 FROM dbo.Media x
      WHERE x.BaiVietID = bv.BaiVietID AND x.LaAnhChinh = 1
  );

INSERT INTO dbo.Media (
    BaiVietID, LoaiMedia, UrlFile,
    AltTextVI, AltTextEN, ChuThichVI, ChuThichEN,
    LaAnhChinh, ThuTuHienThi
)
SELECT bv.BaiVietID, 'IMAGE', N'https://images.unsplash.com/photo-1512058564366-18510be2db19?auto=format&fit=crop&w=1200&q=80', N'Nhã nhạc cung đình Huế trong biểu diễn', N'Hue royal court music performance', N'Hình ảnh nhã nhạc cung đình Huế trong không gian biểu diễn truyền thống.', N'Image of Hue royal court music in a traditional performance setting.', 1, 1
FROM dbo.BaiViet bv
WHERE bv.MaBaiViet = 'BV_NHA_NHAC_CUNG_DINH'
  AND NOT EXISTS (
      SELECT 1 FROM dbo.Media x
      WHERE x.BaiVietID = bv.BaiVietID AND x.LaAnhChinh = 1
  );

INSERT INTO dbo.Media (
    BaiVietID, LoaiMedia, UrlFile,
    AltTextVI, AltTextEN, ChuThichVI, ChuThichEN,
    LaAnhChinh, ThuTuHienThi
)
SELECT bv.BaiVietID, 'IMAGE', N'https://images.unsplash.com/photo-1517486808906-6ca8b3f04846?auto=format&fit=crop&w=1200&q=80', N'Múa rối nước trên sân khấu mặt nước', N'Water puppetry on a water stage', N'Hình ảnh trình diễn múa rối nước truyền thống.', N'An image of a traditional water puppetry performance.', 1, 1
FROM dbo.BaiViet bv
WHERE bv.MaBaiViet = 'BV_MUA_ROI_NUOC'
  AND NOT EXISTS (
      SELECT 1 FROM dbo.Media x
      WHERE x.BaiVietID = bv.BaiVietID AND x.LaAnhChinh = 1
  );

INSERT INTO dbo.Media (
    BaiVietID, LoaiMedia, UrlFile,
    AltTextVI, AltTextEN, ChuThichVI, ChuThichEN,
    LaAnhChinh, ThuTuHienThi
)
SELECT bv.BaiVietID, 'IMAGE', N'https://images.unsplash.com/photo-1500530855697-b586d89ba3ee?w=1200', N'Không gian kiến trúc Hội An cổ', N'Historic architecture of Hoi An', N'Hình ảnh phố cổ Hội An với kiến trúc giao thoa văn hóa.', N'Image of Hoi An ancient town with cross-cultural architecture.', 1, 1
FROM dbo.BaiViet bv
WHERE bv.MaBaiViet = 'BV_KIEN_TRUC_HOI_AN'
  AND NOT EXISTS (
      SELECT 1 FROM dbo.Media x
      WHERE x.BaiVietID = bv.BaiVietID AND x.LaAnhChinh = 1
  );

/* =========================================================
   17. KIỂM TRA NHANH KẾT QUẢ
   ========================================================= */
SELECT 'NguoiDung' AS Bang, COUNT(*) AS SoLuong FROM dbo.NguoiDung
UNION ALL
SELECT 'DanhMuc', COUNT(*) FROM dbo.DanhMuc
UNION ALL
SELECT 'VungVanHoa', COUNT(*) FROM dbo.VungVanHoa
UNION ALL
SELECT 'DanToc', COUNT(*) FROM dbo.DanToc
UNION ALL
SELECT 'TuKhoa', COUNT(*) FROM dbo.TuKhoa
UNION ALL
SELECT 'BaiViet', COUNT(*) FROM dbo.BaiViet
UNION ALL
SELECT 'Media', COUNT(*) FROM dbo.Media
UNION ALL
SELECT 'NguonThamKhao', COUNT(*) FROM dbo.NguonThamKhao
UNION ALL
SELECT 'MauPrompt', COUNT(*) FROM dbo.MauPrompt
UNION ALL
SELECT 'NhatKyCauHoiAI', COUNT(*) FROM dbo.NhatKyCauHoiAI
UNION ALL
SELECT 'PhanHoiNguoiDung', COUNT(*) FROM dbo.PhanHoiNguoiDung
UNION ALL
SELECT 'LichSuDuyetBaiViet', COUNT(*) FROM dbo.LichSuDuyetBaiViet;
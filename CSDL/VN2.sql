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
SELECT N'Quản trị viên hệ thống', 'admin@vnculturebridge.ai', 'HASH_ADMIN_123', 'ADMIN', 'ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM dbo.NguoiDung WHERE Email = 'admin@vnculturebridge.ai');

INSERT INTO dbo.NguoiDung (HoTen, Email, MatKhauHash, VaiTro, TrangThai)
SELECT N'Trần Minh Anh', 'content@vnculturebridge.ai', 'HASH_CONTENT_123', 'CONTENT_MANAGER', 'ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM dbo.NguoiDung WHERE Email = 'content@vnculturebridge.ai');

INSERT INTO dbo.NguoiDung (HoTen, Email, MatKhauHash, VaiTro, TrangThai)
SELECT N'Lê Hoàng Nam', 'reviewer@vnculturebridge.ai', 'HASH_REVIEWER_123', 'REVIEWER', 'ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM dbo.NguoiDung WHERE Email = 'reviewer@vnculturebridge.ai');

INSERT INTO dbo.NguoiDung (HoTen, Email, MatKhauHash, VaiTro, TrangThai)
SELECT N'Phạm Thu Hà', 'ai@vnculturebridge.ai', 'HASH_AI_123', 'AI_MANAGER', 'ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM dbo.NguoiDung WHERE Email = 'ai@vnculturebridge.ai');

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
WHERE bv.MaBaiViet IN ('BV_PHO_VIET_NAM', 'BV_BANH_MI')
  AND NOT EXISTS (
      SELECT 1 FROM dbo.BaiViet_DanhMuc x
      WHERE x.BaiVietID = bv.BaiVietID AND x.DanhMucID = dm.DanhMucID
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
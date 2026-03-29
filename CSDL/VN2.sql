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
   11. NHẬT KÝ CÂU HỎI AI
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
   16. KIỂM TRA NHANH KẾT QUẢ
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
-- SEED DATA CHO VN CULTURE BRIDGE AI (MSSQL) - VERSION 5.1 (FULL CONTENT - 3 PRIMARY REGIONS)
-- Nội dung: Dữ liệu văn hóa chi tiết cho 3 Miền, 10+ Dân tộc, 20+ Món ăn đặc trưng

-- 1. NGƯỜI DÙNG
INSERT INTO dbo.NguoiDung (TenDangNhap, MatKhau, HoTen, Email, VaiTro) VALUES
('quang.admin', 'hashed_password_123', N'Nguyễn Minh Quang', 'quang@vnculture.ai', 'ADMIN'),
('user.guest', 'guest_pass_456', N'Khách Tham Quan', 'guest@vnculture.ai', 'USER');

-- 2. VÙNG VĂN HÓA (3 Miền Chính)
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

-- 3. DÂN TỘC (10 Dân tộc tiêu biểu trên 3 miền)
INSERT INTO dbo.DanToc (MaDanToc, TenVI, TenEN, PhanLoaiVI, PhanLoaiEN, DanSo, OverviewVI, OverviewEN, ImageUrl, BannerUrl, ThuTuHienThi) VALUES
('KINH', N'Kinh', 'Kinh', N'Nam Á', 'Austroasiatic', '82M+', 
N'Dân tộc đa số cư trú khắp 63 tỉnh thành, đóng vai trò nòng cốt trong sự nghiệp phát triển đất nước.', 
'The majority ethnic group residing across all 63 provinces, playing a core role in national development.', 
'https://file.hstatic.net/200000503583/file/trang-phuc-dan-toc-kinh-cardina-2.jpg_840a0eba375b4aa48725bf626fff058d.jpg',
'https://ati.net.vn/wp-content/uploads/2023/05/trang-phuc-dan-toc-kinh.jpg', 1),
('HMONG', N'H''Mông', 'H''Mong', N'H''Mông - Dao', 'Hmong-Mien', '1.3M+', 
N'Cư trú chủ yếu ở vùng núi cao phía Bắc, nổi tiếng với kỹ năng canh tác ruộng bậc thang và thổ cẩm.', 
'Residing mainly in the northern highlands, famous for terraced farming skills and brocade weaving.', 
'https://dienbientv.vn/dataimages/201212/original/images799031_2.jpg',
'https://mia.vn/media/uploads/blog-du-lich/trang-phuc-dan-toc-hmong-hoa-1726418370.jpg', 2),
('TAY', N'Tày', 'Tay', N'Tày - Thái', 'Tai-Kadai', '1.8M+', 
N'Dân tộc thiểu số đông nhất Việt Nam, cư trú ở các thung lũng vùng núi phía Bắc.', 
'The most populous minority ethnic group in Vietnam, residing in northern mountain valleys.', 
'https://routine-db.s3.amazonaws.com/prod/media/trang-phuc-dan-toc-tay-nu-don-gian-diu-dang-jpg-klji.webp',
'https://media.baocaobang.vn/upload/image/202502/medium/133822_net_dep_trang_phuc_phu_nu_dan_toc_tay_09172024.jpg', 3),
('THAI', N'Thái', 'Thai', N'Tày - Thái', 'Tai-Kadai', '1.9M+', 
N'Sống tập trung ở vùng Tây Bắc với điệu múa xòe và nghệ thuật ẩm thực độc đáo.', 
'Concentrated in the Northwest region with the Xoe dance and unique culinary arts.', 
'https://file.hstatic.net/200000503583/file/trang-phuc-dan-toc-thai-1_281c6dad3a91431bba997c36321a0ec7.jpg',
'https://images.baodantoc.vn/uploads/2023/Thang-11/Ngay-5/Anh/untitled%20folder/untitled%20folder/untitled%20folder/5.jpg', 4),
('DAO', N'Dao', 'Dao', N'H''Mông - Dao', 'Hmong-Mien', '891K', 
N'Nổi tiếng với nghi lễ Cấp sắc và các tri thức dân gian về thảo dược.', 
'Famous for the Cap Sac ritual and folk knowledge of herbal medicine.', 
'https://images.baodantoc.vn/uploads/2021/Th%C3%A1ng%204/S%E1%BB%91%20gh%C3%A9p/T38-48/Dao%20do-%20Hoang%20Su%20Phi-%20Ha%20Giang.jpg',
'https://topasecolodge.com/wp-content/uploads/2022/07/dan-toc-dao-do-red-dao-minority-vietnam.jpeg', 5),
('CHAM', N'Chăm', 'Cham', N'Nam Đảo', 'Austronesian', '178K', 
N'Chủ nhân của nền văn minh Chăm-pa rực rỡ với hệ thống tháp gạch cổ kính miền Trung.', 
'Owners of the brilliant Champa civilization with a system of ancient brick towers in Central Vietnam.', 
'https://hellophanrang.com/wp-content/uploads/2023/07/69775996_481034999146749_7209348372954611712_n.jpg',
'https://files.bdttg.gov.vn/contentfolder/ubdt/source_files/2015/11/04/10261048_ng%C6%B0%E1%BB%9Di%20ch%C4%83m_15-11-04.jpg', 6),
('KHMER', N'Khmer', 'Khmer', N'Nam Á', 'Austroasiatic', '1.3M+', 
N'Sinh sống chủ yếu ở Nam Bộ, gắn liền với các ngôi chùa kiến trúc độc đáo.', 
'Residing mainly in the Southwest, associated with unique architectural pagodas.', 
'https://images.unsplash.com/photo-1585223126786-9316d5ba4b17?auto=format&fit=crop&w=1000&q=80',
'https://images.unsplash.com/photo-1455620611406-966ca6889d80?auto=format&fit=crop&w=1200&q=80', 7),
('EDE', N'Ê Đê', 'E De', N'Nam Đảo', 'Austronesian', '398K', 
N'Gia đình mẫu hệ, sống trong những ngôi nhà dài đặc trưng vùng Tây Nguyên.', 
'Matriarchal society, living in characteristic longhouses of the Central Highlands.', 
'https://images.unsplash.com/photo-1460661419201-fd4cecdf8a8b?auto=format&fit=crop&w=1000&q=80',
'https://images.unsplash.com/photo-1511739001486-6bfe10ce785f?auto=format&fit=crop&w=1200&q=80', 8),
('BANA', N'Ba Na', 'Ba Na', N'Nam Á', 'Austroasiatic', '286K', 
N'Cư trú lâu đời ở Tây Nguyên, nổi bật với văn hóa cồng chiêng và nhà rông.', 
'Long-time residents of the Central Highlands, prominent for gong culture and rong houses.', 
'https://images.unsplash.com/photo-1517487881594-2787fef5ebf7?auto=format&fit=crop&w=1000&q=80',
'https://images.unsplash.com/photo-1518115682977-bc68d87a48d8?auto=format&fit=crop&w=1200&q=80', 9);

-- 4. TỈNH THÀNH (Tiêu biểu cho 3 miền)
INSERT INTO dbo.TinhThanh (MaTinh, VungID, TenVI, TenEN, TieuDePhuVI, TongQuanVI, AnhDaiDienUrl, HeroImageUrl, ThuTuHienThi) VALUES
('HA_NOI', 1, N'Hà Nội', 'Hanoi', N'Thủ đô ngàn năm văn hiến', N'Trái Tim của cả nước.', 'https://cdn.vntrip.vn/cam-nang/wp-content/uploads/2017/07/ho-hoan-kiem-3.jpg', 'https://vcdn1-dulich.vnecdn.net/2022/05/12/Hanoi2-1652338755-3632-1652338809.jpg?w=0&h=0&q=100&dpr=2&fit=crop&s=NxMN93PTvOTnHNryMx3xJw', 1),
('HA_GIANG', 1, N'Hà Giang', 'Ha Giang', N'Vùng đất hoa tam giác mạch', N'Cổng trời phía Bắc.', 'https://images.unsplash.com/photo-1509030450996-dd1a26dda07a?auto=format&fit=crop&w=1000&q=80', 'https://images.unsplash.com/photo-1509030450996-dd1a26dda07a?auto=format&fit=crop&w=1200&q=80', 2),
('HUE', 2, N'Thừa Thiên Huế', 'Hue', N'Cố đô thơ mộng', N'Di sản văn hóa thế giới.', 'https://images.unsplash.com/photo-1585223126786-9316d5ba4b17?auto=format&fit=crop&w=1000&q=80', 'https://images.unsplash.com/photo-1585223126786-9316d5ba4b17?auto=format&fit=crop&w=1200&q=80', 3),
('DA_NANG', 2, N'Đà Nẵng', 'Da Nang', N'Thành phố đáng sống', N'Cửa ngõ miền Trung.', 'https://images.unsplash.com/photo-1559592443-7f87a79f6386?auto=format&fit=crop&w=1000&q=80', 'https://images.unsplash.com/photo-1559592443-7f87a79f6386?auto=format&fit=crop&w=1200&q=80', 4),
('TPHCM', 3, N'TP. Hồ Chí Minh', 'Ho Chi Minh City', N'Hòn ngọc Viễn Đông', N'Trung tâm kinh tế năng động.', 'https://images.unsplash.com/photo-1583417319070-4a69db38a482?auto=format&fit=crop&w=1000&q=80', 'https://images.unsplash.com/photo-1583417319070-4a69db38a482?auto=format&fit=crop&w=1200&q=80', 5),
('CAN_THO', 3, N'Cần Thơ', 'Can Tho', N'Tây Đô gạo trắng nước trong', N'Thanh bình miền sông nước.', 'https://images.unsplash.com/photo-1528127269322-539801943592?auto=format&fit=crop&w=1000&q=80', 'https://images.unsplash.com/photo-1528127269322-539801943592?auto=format&fit=crop&w=1200&q=80', 6);

-- 5. ẨM THỰC (20+ Món ăn đặc thù)
INSERT INTO dbo.AmThuc (MaMonAn, TenVI, TenEN, LoaiMonAnVI, MoTaNganVI, NoiDungChiTietVI, VungID, TinhThanhID, DanTocID, ImageUrl) VALUES
-- Miền Bắc
('PHO_BO', N'Phở Bò', 'Beef Pho', N'Món nước', N'Tinh hoa ẩm thực Việt.', N'Nước dùng thanh ngọt...', 1, 1, 1, 'https://images.unsplash.com/photo-1582878826629-29b7ad1cdc43?auto=format&fit=crop&w=1000&q=80'),
('BUN_CHA', N'Bún Chả', 'Bun Cha', N'Món khô', N'Món ngon đất Hà Thành.', N'Thịt nướng thơm lừng...', 1, 1, 1, 'https://file.hstatic.net/200000700229/article/lam-bun-cha-nuong-bang-noi-chien-khong-dau-1_fd1b7c37aa15432eafded154dea42763.jpeg'),
('BANH_DA_CUA', N'Bánh Đa Cua', 'Crab Noodle Soup', N'Món nước', N'Đặc sản Hải Phòng.', N'Vị cua đồng đậm đà...', 1, NULL, 1, 'https://media.anhp.vn/files/2023/11banh%20da%20cua.jpg'),
('THANG_CO', N'Thắng Cố', 'Thang Co', N'Món hầm', N'Hương vị núi rừng.', N'Đặc sản người H''Mông...', 1, 2, 2, 'https://dulichviet.com.vn/images/bandidau/am-thuc/thang-co-tay-bac-du-lich-viet-6.jpg'),
('XOI_NGU_SAC', N'Xôi Ngũ Sắc', 'Five-color Sticky Rice', N'Món xôi', N'Sắc màu núi rừng.', N'Nhuộm từ cây cỏ...', 1, NULL, 3, 'https://images.unsplash.com/photo-1518115682977-bc68d87a48d8?auto=format&fit=crop&w=1000&q=80'),

-- Miền Trung
('BUN_BO_HUE', N'Bún Bò Huế', 'Hue Beef Noodle', N'Món nước', N'Đậm đà vị Cố đô.', N'Mắm ruốc, sả, ớt...', 2, 3, 1, 'https://images.unsplash.com/photo-1599387342686-25867375267a?auto=format&fit=crop&w=1000&q=80'),
('CAO_LAU', N'Cao Lầu', 'Cao Lau', N'Món trộn', N'Đặc sản Hội An.', N'Hương vị riêng từ nước giếng Bá Lễ...', 2, NULL, 1, 'https://images.unsplash.com/photo-1555939594-58d7cb561ad1?auto=format&fit=crop&w=1000&q=80'),
('MI_QUANG', N'Mì Quảng', 'Quang Noodles', N'Món trộn', N'Sáng tạo của người Quảng.', N'Nhân đa dạng, bánh tráng giòn...', 2, 4, 1, 'https://images.unsplash.com/photo-1562607311-6644f107f975?auto=format&fit=crop&w=1000&q=80'),
('BANH_XEO_MT', N'Bánh Xèo Miền Trung', 'Central Rice Crepe', N'Món chiên', N'Nhỏ gọn, giòn rụm.', N'Nhân tôm thịt...', 2, NULL, 1, 'https://images.unsplash.com/photo-1591814468924-caf88d1232e1?auto=format&fit=crop&w=1000&q=80'),
('GA_NUONG_BD', N'Gà Nướng Bản Đôn', 'Ban Don Grilled Chicken', N'Món nướng', N'Phong vị Tây Nguyên.', N'Tẩm ướp mật ong...', 2, NULL, 8, 'https://images.unsplash.com/photo-1460661419201-fd4cecdf8a8b?auto=format&fit=crop&w=1000&q=80'),

-- Miền Nam
('COM_TAM', N'Cơm Tấm', 'Broken Rice', N'Món khô', N'Ẩm thực đường phố Sài Gòn.', N'Sườn, bì, chả, trứng...', 3, 5, 1, 'https://images.unsplash.com/photo-1590301157890-4810ed352733?auto=format&fit=crop&w=1000&q=80'),
('HU_TIU_NAM_VANG', N'Hủ Tiếu Nam Vang', 'Nam Vang Noodle', N'Món nước', N'Giao thoa văn hóa.', N'Nước dùng xương ống...', 3, 5, 1, 'https://images.unsplash.com/photo-1512058560366-cd242d45c50c?auto=format&fit=crop&w=1000&q=80'),
('LAU_MAM', N'Lẩu Mắm', 'Fermented Fish Hotpot', N'Lẩu', N'Đặc sản miền Tây.', N'Mắm linh, mắm sặc...', 3, 6, 1, 'https://images.unsplash.com/photo-1528612991054-9469db38a14b?auto=format&fit=crop&w=1000&q=80'),
('BANH_CANH_CUA', N'Bánh Canh Cua', 'Crab Thick Noodle', N'Món nước', N'Sánh mịn ngọt thanh.', N'Thịt cua tươi rói...', 3, 5, 1, 'https://images.unsplash.com/photo-1512058560366-cd242d45c50c?auto=format&fit=crop&w=1000&q=80');

-- 6. LỄ HỘI
INSERT INTO dbo.LeHoi (MaLeHoi, TenVI, TenEN, ThoiGianVI, DiaDiemVI, MoTaNganVI, NoiDungChiTietVI, VungID, TinhThanhID, DanTocID, ImageUrl) VALUES
('GIO_TO_HUNG_VUONG', N'Giỗ Tổ Hùng Vương', 'Hung Kings'' Festival', N'10/3 Âm lịch', N'Phú Thọ', N'Ngày hội non sông.', N'Hướ́ng về cội nguồn...', 1, NULL, 1, 'https://cdn.thuvienphapluat.vn/uploads/tintuc/2026/04/11/lich-nghi-gio-to-hung-vuong.jpg'),
('FESTIVAL_HUE', N'Festival Huế', 'Hue Festival', N'2 năm 1 lần', N'Huế', N'Tôn vinh di sản.', N'Đại nội rực rỡ...', 2, 3, 1, 'https://aeonmall-review-rikkei.cdn.vccloud.vn/website/21/articles/September2025/b846c7d7-81b3-416a-a765-8cd781d2b73d.jpg'),
('KATE_CHAM', N'Lễ hội Katê', 'Kate Festival', N'Tháng 7 lịch Chăm', N'Ninh Thuận', N'Lễ hội của người Chăm.', N'Bên chân tháp cổ...', 2, NULL, 6, 'https://images.baodantoc.vn/uploads/2024/Thang-9/Ngay-17/Anh/untitled%20folder/z3666171023314-cb39daf1ae3370337730751d83cf3b84-_1__1.jpg'),
('OK_OM_BOK', N'Lễ hội Ok Om Bok', 'Ok Om Bok Festival', N'Rằm tháng 10 âl', N'Sóc Trăng', N'Lễ cúng trăng.', N'Đua ghe Ngo náo nhiệt...', 3, NULL, 7, 'https://images.unsplash.com/photo-1585223126786-9316d5ba4b17?auto=format&fit=crop&w=1000&q=80');

-- 7. VĂN HÓA
INSERT INTO dbo.VanHoa (Ma, Loai, TenVI, TenEN, MoTaNganVI, NoiDungChiTietVI, VungID, DanTocID, ImageUrl) VALUES
('CONG_CHIENG', 'NGHE_THUAT', N'Không gian văn hóa Cồng chiêng', 'Gong Culture', N'Trái tim Tây Nguyên.', N'Di sản nhân loại...', 2, 8, 'https://images.unsplash.com/photo-1460661419201-fd4cecdf8a8b?auto=format&fit=crop&w=1000&q=80'),
('CA_TRU', 'NGHE_THUAT', N'Ca Trù', 'Ca Tru Singing', N'Nghệ thuật thâm thúy.', N'Tiếng phách nhịp nhàng...', 1, 1, 'https://images.unsplash.com/photo-1509030450996-dd1a26dda07a?auto=format&fit=crop&w=1000&q=80');

-- 8. BÀI VIẾT CONTENT CHÍNH
INSERT INTO dbo.BaiViet (MaBaiViet, TieuDeVI, TieuDeEN, MoTaNganVI, NoiDungVI, TacGia, ChuyenMuc, VungID, DanTocID, AmThucID, ImageUrl) VALUES
('BV_SON_MAI', N'Nghệ Thuật Sơn Mài: Tinh Hoa Hội Họa Việt Nam', 'Lacquer Art: A Pinnacle of Vietnamese Painting', 
N'Khám phá bí mật đằng sau những lớp sơn huyền ảo.', N'Nghệ thuật sơn mài Việt Nam là một quá trình chế tác công phu...', N'Trần Minh Khoa', 'NGHE_THUAT_DAN_GIAN', 1, 1, NULL, 'https://vnculture.ai/assets/son-mai.jpg'),
('BV_TRANH_DONG_HO', N'Tranh Đông Hồ: Nét Dân Gian Trong Từng Bức Khắc', 'Dong Ho Painting: Folk Art in Every Wood Block', 
N'Lời kể chuyện đời sống làng quê Việt Nam.', N'Từ giấy điệp óng ánh đến màu sắc thiên nhiên...', N'Nguyễn Hương Lan', 'NGHE_THUAT_DAN_GIAN', 1, 1, NULL, 'https://vnculture.ai/assets/dong-ho.jpg'),
('BV_GOM_BAT_TRANG', N'Gốm Bát Tràng: Di Sản 500 Năm Bên Dòng Sông Hồng', 'Bat Trang Pottery: 500-Year Heritage', 
N'Làng gốm cổ nhất Việt Nam vẫn giữ nguyên bí quyết.', N'Làng gốm cổ nhất Việt Nam vẫn giữ nguyên bí quyết nung đất sét trắng...', N'Phạm Đức Thành', 'NGHE_THUAT_DAN_GIAN', 1, 1, NULL, 'https://vnculture.ai/assets/bat-trang.jpg'),
('BV_LUA_HA_DONG', N'Lụa Hà Đông: Tinh Hoa Bền Vững Qua Nghìn Năm', 'Ha Dong Silk: Enduring Craft', 
N'Những sợi lụa mỏng manh mang theo nghìn năm tri thức.', N'Những sợi lụa mỏng manh từ làng Vạn Phúc mang theo cả nghìn năm tri thức...', N'Lê Thị Thu Hà', 'NGHE_THUAT_DAN_GIAN', 1, 1, NULL, 'https://vnculture.ai/assets/lua.jpg'),
('BV_AO_DAI', N'Áo dài Việt Nam: Linh Hồn Của Người Phụ Nữ', 'Vietnamese Ao Dai: The Soul of Women', 
N'Biểu tượng văn hóa và sự duyên dáng của người Việt.', N'Tà áo dài thanh lịch không chỉ là trang phục truyền thống...', N'Vũ Minh Châu', 'NGHE_THUAT_DAN_GIAN', NULL, 1, NULL, 'https://vnculture.ai/assets/ao-dai.jpg'),
('BV_NHA_NHAC_CUNG_DINH', N'Nhã Nhạc Cung Đình Huế: Di Sản UNESCO', 'Hue Royal Court Music: UNESCO Heritage', 
N'Giai điệu trang trọng từ cung đình Huế.', N'Những giai điệu trang trọng từ cung đình Huế đã được UNESCO công nhận...', N'Hoàng Văn Bình', 'NGHE_THUAT_DAN_GIAN', 2, 1, NULL, 'https://vnculture.ai/assets/nha-nhac.jpg'),
('BV_TET_CO_TRUYEN', N'Tết Cổ Truyền: Hồn Việt Trong Từng Khoảnh Khắc', 'Traditional Tet: The Vietnamese Soul', 
N'Khám phá ý nghĩa ngày Tết.', N'Tết không chỉ là kỳ nghỉ...', N'Admin', 'VAN_HOA', 1, 1, NULL, 'https://images.unsplash.com/photo-1579624538806-259837f4876b?auto=format&fit=crop&w=1000&q=80'),
('BV_AM_THUC_MIEN_TAY', N'Sông Nước Miền Tây: Nơi Ẩm Thực Kết Tinh Từ Phù Sa', 'West Side River: Culinary Essence', 
N'Hương vị đồng quê.', N'Mắm, cá, rau đồng...', N'Quang Nguyễn', 'AM_THUC', 3, 1, 13, 'https://images.unsplash.com/photo-1528612991054-9469db38a14b?auto=format&fit=crop&w=1000&q=80');

-- 9. HÌNH ẢNH (GALLERY)
INSERT INTO dbo.HinhAnh (Url, MoTaVI, BaiVietID, AmThucID) VALUES
('https://images.unsplash.com/photo-1582878826629-29b7ad1cdc43?auto=format&fit=crop&w=1000&q=80', N'Phở bò nóng hổi', NULL, 1),
('https://images.unsplash.com/photo-1593361427131-0164c09d5718?auto=format&fit=crop&w=1000&q=80', N'Bún chả Hà Nội', NULL, 2);

-- 10. MẪU PROMPT AI
INSERT INTO dbo.MauPrompt (MaPrompt, LoaiPrompt, TenPrompt, NoiDungPrompt) VALUES
('P1', 'EXPLORE', N'Tìm hiểu về văn hóa cồng chiêng', N'Hãy cho tôi biết về ý nghĩa và cách thức biểu diễn cồng chiêng Tây Nguyên.'),
('P2', 'TRAVEL', N'Gợi ý lộ trình du lịch Tây Bắc', N'Lên kế hoạch du lịch 5 ngày tại Hà Giang và Lào Cai.'),
('P3', 'CUISINE', N'Công thức phở bò truyền thống', N'Hướng dẫn cách nấu phở bò Hà Nội chuẩn vị xưa.');

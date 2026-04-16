-- Bổ sung 3 dân tộc còn thiếu
INSERT INTO dbo.DanToc (MaDanToc, TenVI, TenEN, PhanLoaiVI, PhanLoaiEN, DanSo, OverviewVI, OverviewEN, ImageUrl, BannerUrl, ThuTuHienThi) VALUES
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

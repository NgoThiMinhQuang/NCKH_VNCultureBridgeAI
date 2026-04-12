SET NOCOUNT ON;

DELETE item
FROM dbo.DanTocSectionItem item
JOIN dbo.DanToc dt ON dt.DanTocID = item.DanTocID
WHERE dt.MaDanToc IN ('HMONG','KHMER','CHAM','DAO','EDE','TAY','KINH');

DELETE profile
FROM dbo.DanTocProfile profile
JOIN dbo.DanToc dt ON dt.DanTocID = profile.DanTocID
WHERE dt.MaDanToc IN ('HMONG','KHMER','CHAM','DAO','EDE','TAY','KINH');

UPDATE dbo.DanToc SET
  TenVI = N'Kinh',
  MoTaVI = N'Dân tộc chiếm đa số ở Việt Nam, có ảnh hưởng rộng trong đời sống văn hóa quốc gia.'
WHERE MaDanToc = 'KINH';

UPDATE dbo.DanToc SET
  TenVI = N'Tày',
  MoTaVI = N'Một trong các dân tộc thiểu số lớn ở miền núi phía Bắc, có nhiều lễ tục và văn nghệ dân gian đặc sắc.'
WHERE MaDanToc = 'TAY';

UPDATE dbo.DanToc SET
  TenVI = N'H''Mông',
  MoTaVI = N'Dân tộc có nhiều phong tục, trang phục và tập quán đặc trưng ở vùng núi phía Bắc.'
WHERE MaDanToc = 'HMONG';

UPDATE dbo.DanToc SET
  TenVI = N'Ê Đê',
  MoTaVI = N'Dân tộc Ê Đê sinh sống chủ yếu ở Tây Nguyên, gắn với không gian văn hóa cồng chiêng và nhà dài.'
WHERE MaDanToc = 'EDE';

UPDATE dbo.DanToc SET
  TenVI = N'Khmer',
  MoTaVI = N'Cộng đồng Khmer tập trung nhiều ở Nam Bộ, nổi bật với chùa Phật giáo Nam tông, lễ hội và nghệ thuật sân khấu dân gian.'
WHERE MaDanToc = 'KHMER';

UPDATE dbo.DanToc SET
  TenVI = N'Chăm',
  MoTaVI = N'Dân tộc Chăm có bề dày lịch sử ở miền Trung, gắn với di sản kiến trúc, tín ngưỡng và nghề dệt thủ công.'
WHERE MaDanToc = 'CHAM';

UPDATE dbo.DanToc SET
  TenVI = N'Dao',
  MoTaVI = N'Dân tộc Dao nổi bật với trang phục thêu tay, nghi lễ cấp sắc và tri thức dân gian về dược liệu.'
WHERE MaDanToc = 'DAO';

SELECT COUNT(*) AS RemainingProfiles
FROM dbo.DanTocProfile profile
JOIN dbo.DanToc dt ON dt.DanTocID = profile.DanTocID
WHERE dt.MaDanToc IN ('HMONG','KHMER','CHAM','DAO','EDE','TAY','KINH');

SELECT COUNT(*) AS RemainingSectionItems
FROM dbo.DanTocSectionItem item
JOIN dbo.DanToc dt ON dt.DanTocID = item.DanTocID
WHERE dt.MaDanToc IN ('HMONG','KHMER','CHAM','DAO','EDE','TAY','KINH');

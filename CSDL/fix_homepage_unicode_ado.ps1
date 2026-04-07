$cs = 'Server=DESKTOP-4AI2SO6\SQLEXPRESS;Database=VNCultureBridgeAI;Integrated Security=true;Encrypt=true;TrustServerCertificate=true'
$cn = New-Object System.Data.SqlClient.SqlConnection $cs
$cn.Open()

$cmd = $cn.CreateCommand()
$cmd.CommandText = @'
UPDATE dbo.VungVanHoa SET HomepageBadgeVI=@b1, HomepageTitleVI=@t1, HomepageDescriptionVI=@d1, HomepageHighlightsVI=@h1, HomepageCtaVI=@c1, HomepageImageAltVI=@a1 WHERE MaVung='BAC_BO';
UPDATE dbo.VungVanHoa SET HomepageBadgeVI=@b2, HomepageTitleVI=@t2, HomepageDescriptionVI=@d2, HomepageHighlightsVI=@h2, HomepageCtaVI=@c2, HomepageImageAltVI=@a2 WHERE MaVung='TRUNG_BO';
UPDATE dbo.VungVanHoa SET HomepageBadgeVI=@b3, HomepageTitleVI=@t3, HomepageDescriptionVI=@d3, HomepageHighlightsVI=@h3, HomepageCtaVI=@c3, HomepageImageAltVI=@a3 WHERE MaVung='NAM_BO';
'@

$pairs = @{
  'b1'='Miền Bắc'; 't1'='Miền Bắc'; 'd1'='Khám phá Hà Nội, Hạ Long và những ruộng bậc thang hùng vĩ của vùng núi phía Bắc.'; 'h1'='["Hà Nội","Hạ Long","Sa Pa","Hà Giang"]'; 'c1'='Khám phá Miền Bắc'; 'a1'='Cảnh sắc ruộng bậc thang miền Bắc Việt Nam';
  'b2'='Miền Trung'; 't2'='Miền Trung'; 'd2'='Từ Huế, Hội An đến Đà Nẵng, miền Trung mang vẻ đẹp giao hòa giữa lịch sử và thiên nhiên.'; 'h2'='["Huế","Hội An","Đà Nẵng","Mỹ Sơn"]'; 'c2'='Khám phá Miền Trung'; 'a2'='Đèn lồng phố cổ Hội An về đêm';
  'b3'='Miền Nam'; 't3'='Miền Nam'; 'd3'='Miền Nam nổi bật với TP.HCM, miền Tây sông nước và hành trình ẩm thực, chợ nổi, biển đảo.'; 'h3'='["TP.HCM","Cần Thơ","Mekong","Phú Quốc"]'; 'c3'='Khám phá Miền Nam'; 'a3'='Khung cảnh sông nước miền Nam Việt Nam'
}

foreach ($k in $pairs.Keys) {
  $p = $cmd.Parameters.Add('@' + $k, [System.Data.SqlDbType]::NVarChar, -1)
  $p.Value = $pairs[$k]
}

[void]$cmd.ExecuteNonQuery()

$check = $cn.CreateCommand()
$check.CommandText = "SELECT MaVung, HomepageTitleVI, HomepageCtaVI FROM dbo.VungVanHoa WHERE MaVung IN ('BAC_BO','TRUNG_BO','NAM_BO') ORDER BY HomepageDisplayOrder"
$da = New-Object System.Data.SqlClient.SqlDataAdapter $check
$dt = New-Object System.Data.DataTable
[void]$da.Fill($dt)
$dt | ConvertTo-Json -Compress

$cn.Close()

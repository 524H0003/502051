-- Dữ liệu thử
INSERT INTO KhachHang VALUES
('KH001', N'Nguyễn Văn An', 'nam', '0901234567'),
('KH002', N'Trần Thị Bích', 'nu', '0912345678'),
('KH003', N'Lê Minh Cường', 'nam', '0923456789'),
('KH004', N'Phạm Thu Duyên', 'nu', '0934567890'),
('KH005', N'Hoàng Thanh Hải', 'nam', '0945678901');

INSERT INTO Phong VALUES
('P101', 1, 500000.00, 1),
('P102', 2, 850000.00, 0),
('P201', 2, 900000.00, 1),
('P202', 3, 1200000.00, 0),
('P301', 1, 650000.00, 0),
('P302', 2, 950000.00, 0),
('P401', 3, 1300000.00, 0);

MERGE ThoiGian AS Target
USING (SELECT 0 AS ID, '2025-12-11' AS ThoiGianHienTai) AS Source
ON (Target.ID = Source.ID)
WHEN MATCHED THEN
    UPDATE SET Target.giaTri = Source.ThoiGianHienTai
WHEN NOT MATCHED BY TARGET THEN
    INSERT (ID, giaTri) 
    VALUES (Source.ID, Source.ThoiGianHienTai);

-- Kiểm tra functions
-- kiểm tra fn_SoDemThue
SELECT 
    MoTa AS [Mô Tả Test Case],
    NgayNhan, 
    NgayTra,
    KetQuaMongDoi AS [KQ Mong Đợi],
    dbo.fn_SoDemThue(NgayNhan, NgayTra) AS [KQ Thực Tế],
    CASE 
        WHEN KetQuaMongDoi = dbo.fn_SoDemThue(NgayNhan, NgayTra) THEN N'✅ PASS (Đạt)'
        ELSE N'❌ FAIL (Không Đạt)'
    END AS [Trạng Thái Kiểm Tra]
FROM test_SoDemThue;

-- kiểm tra fn_TongTienThue
SELECT 
    TC.MoTa AS [Mô Tả Test Case],
    TC.MaPhong,
    TC.GiaPhong AS [Giá Phòng],
    dbo.fn_SoDemThue(TC.NgayNhan, TC.NgayTra) AS [Số Đêm Tính Toán],
    TC.KetQuaMongDoi AS [KQ Mong Đợi],
    dbo.fn_TongTienThue(TC.MaPhong, TC.NgayNhan, TC.NgayTra) AS [KQ Thực Tế],
    CASE 
        WHEN TC.KetQuaMongDoi = dbo.fn_TongTienThue(TC.MaPhong, TC.NgayNhan, TC.NgayTra) THEN N'✅ PASS'
        WHEN TC.KetQuaMongDoi IS NULL AND dbo.fn_TongTienThue(TC.MaPhong, TC.NgayNhan, TC.NgayTra) IS NULL THEN N'✅ PASS (NULL)'
        ELSE N'❌ FAIL'
    END AS [Trạng Thái Kiểm Tra]
FROM test_TongTienThue TC;

-- kiểm tra fn_SoLanDatPhong
select * from fn_SoLanDatPhong('KHT01');

-- kiểm tra procedures
-- kiểm tra sp_datPhong
EXEC sp_DatPhong @MaKH = 'KH999', @MaPhong = 'P101', @NgayNhan = '2025-12-01', @NgayTra = '2025-12-03';
EXEC sp_DatPhong @MaKH = 'KH001', @MaPhong = 'P999', @NgayNhan = '2025-12-01', @NgayTra = '2025-12-03';
EXEC sp_DatPhong @MaKH = 'KH001', @MaPhong = 'P101', @NgayNhan = '2025-12-05', @NgayTra = '2025-12-05';
EXEC sp_DatPhong @MaKH = 'KH001', @MaPhong = 'P101', @NgayNhan = '2027-01-10', @NgayTra = '2027-12-12';

-- kiểm tra sp_TaoHoaDonThanhToan
EXEC sp_TaoHoaDonThanhToan 
    @MaPhong = 'P101',
    @NgayNhan = '2025-12-10', 
    @SoTienThanhToan = 5000;

EXEC sp_TaoHoaDonThanhToan 
    @MaPhong = 'P101',
    @NgayNhan = '2025-12-10', 
    @SoTienThanhToan = 50000000000;

-- kiểm tra sp_doanhThuThang
EXEC sp_doanhThuThang

-- kiểm tra trg_CapNhatNgayTra
update 
  HoaDon
SET
  NgayTra = '2025-12-19'
WHERE 
  MaPhong = 'P101' and NgayNhan = '2025-12-10'
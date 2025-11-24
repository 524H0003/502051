-- Đặt phòng 1: KH001 thuê P101 (2 đêm)
EXEC sp_DatPhong @MaKH = 'KH001', @MaPhong = 'P101', @NgayNhan = '2025-12-01', @NgayTra = '2025-12-03';

-- Đặt phòng 2: KH002 thuê P102 (3 đêm)
EXEC sp_DatPhong @MaKH = 'KH002', @MaPhong = 'P102', @NgayNhan = '2025-12-01', @NgayTra = '2025-12-04';

-- Đặt phòng 3: KH003 thuê P201 (2 đêm)
EXEC sp_DatPhong @MaKH = 'KH003', @MaPhong = 'P201', @NgayNhan = '2025-12-05', @NgayTra = '2025-12-07';

-- Đặt phòng 4: KH004 thuê P202 (2 đêm)
EXEC sp_DatPhong @MaKH = 'KH004', @MaPhong = 'P202', @NgayNhan = '2025-12-08', @NgayTra = '2025-12-10';

-- Đặt phòng 5: KH005 thuê P301 (1 đêm)
EXEC sp_DatPhong @MaKH = 'KH005', @MaPhong = 'P301', @NgayNhan = '2025-12-10', @NgayTra = '2025-12-11';

-- Đặt phòng 6: KH001 thuê P302 (3 đêm)
EXEC sp_DatPhong @MaKH = 'KH001', @MaPhong = 'P302', @NgayNhan = '2025-12-15', @NgayTra = '2025-12-18';

-- Đặt phòng 7: KH002 thuê P401 (1 đêm)
EXEC sp_DatPhong @MaKH = 'KH002', @MaPhong = 'P401', @NgayNhan = '2025-12-16', @NgayTra = '2025-12-17';

-- Đặt phòng 8 (Tiếp nối P101): KH003 thuê P101 (2 đêm)
-- Bắt đầu ngay sau khi booking #1 kết thúc (2025-12-03)
EXEC sp_DatPhong @MaKH = 'KH003', @MaPhong = 'P101', @NgayNhan = '2025-12-03', @NgayTra = '2025-12-05';

-- Đặt phòng 9 (Tiếp nối P102): KH004 thuê P102 (2 đêm)
-- Bắt đầu ngay sau khi booking #2 kết thúc (2025-12-04)
EXEC sp_DatPhong @MaKH = 'KH004', @MaPhong = 'P102', @NgayNhan = '2025-12-04', @NgayTra = '2025-12-06';

-- Đặt phòng 10 (Tiếp nối P201): KH005 thuê P201 (3 đêm)
-- Bắt đầu ngay sau khi booking #3 kết thúc (2025-12-07)
EXEC sp_DatPhong @MaKH = 'KH005', @MaPhong = 'P201', @NgayNhan = '2025-12-07', @NgayTra = '2025-12-10';
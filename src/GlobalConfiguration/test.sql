-- Dữ liệu kiểm thử fn_SoDemThue
DROP table if exists test_SoDemThue;
create TABLE test_SoDemThue (
    MoTa NVARCHAR(100),
    NgayNhan date,
    NgayTra date,
    KetQuaMongDoi INT
);

INSERT INTO test_SoDemThue VALUES 
(N'Ở 2 đêm bình thường', '2023-11-01 14:00', '2023-11-03 12:00', 2),
(N'Ở trong ngày', '2023-11-01 08:00', '2023-11-01 17:00', 0),
(N'Qua đêm ngắn', '2023-11-01 23:00', '2023-11-02 01:00', 1),
(N'Lỗi: Ngày trả trước Ngày nhận', '2023-11-05', '2023-11-01', 0),
(N'Tròn 24h', '2023-11-01 14:00', '2023-11-02 14:00', 1);

-- Dữ liệu kiểm thử fn_TongTienThue
INSERT INTO Phong VALUES
('Test001', 2, 1000000.00, 0),
('Test002', 1, 500000.00, 0);

DROP TABLE if exists test_TongTienThue;
create TABLE test_TongTienThue(
    MaPhong CHAR(10),
    MoTa NVARCHAR(150),
    NgayNhan date,
    NgayTra date,
    GiaPhong FLOAT,
    SoDemMongDoi INT,
    KetQuaMongDoi FLOAT
);

INSERT INTO test_TongTienThue VALUES 
('Test001', N'Ở 3 đêm bình thường', 
 '2025-12-01 10:00', '2025-12-04 10:00', 1000000.00, 3, 3000000.00),
('Test002', N'Ở trong ngày', 
 '2025-12-05 08:00', '2025-12-05 18:00', 500000.00, 0, 0),
('Test001', N'Ngày sai', 
 '2025-12-07', '2025-12-06', 1000000.00, 0, 0.00),
('P999', N'Phòng không tồn tại', 
 '2025-12-08', '2025-12-09', NULL, 1, NULL);

-- Dữ liệu kiểm thử fn_SoLanDatPhong
INSERT INTO KhachHang VALUES
('KHT01', N'Nguyễn Văn An', 'nam', '0901234567');

INSERT INTO HoaDon (MaKH, MaPhong, NgayNhan, NgayTra, TongThanhToan) VALUES
('KHT01', 'Test001', '2027-11-20', '2027-11-22', 1),
('KHT01', 'Test001', '2025-12-01', '2025-12-04', 4);
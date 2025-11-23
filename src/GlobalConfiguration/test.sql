-- Dữ liệu kiểm thử fn_SoDemThue
create TABLE test_SoDemThue (
    MoTa NVARCHAR(100),
    NgayNhan SMALLDATETIME,
    NgayTra SMALLDATETIME,
    KetQuaMongDoi INT
);

INSERT INTO test_SoDemThue VALUES 
(N'1. Ở 2 đêm bình thường (01/11 14:00 -> 03/11 12:00)', '2023-11-01 14:00', '2023-11-03 12:00', 2),
(N'2. Ở trong ngày (Sáng đến - Chiều đi). DATEDIFF = 0 -> KQ = 1', '2023-11-01 08:00', '2023-11-01 17:00', 1),
(N'3. Qua đêm ngắn (23:00 -> 01:00 sáng hôm sau). DATEDIFF = 1', '2023-11-01 23:00', '2023-11-02 01:00', 1),
(N'4. Lỗi: Ngày trả trước Ngày nhận. DATEDIFF < 0 -> KQ = 0', '2023-11-05', '2023-11-01', 0),
(N'5. Tròn 24h (14:00 -> 14:00 hôm sau). DATEDIFF = 1', '2023-11-01 14:00', '2023-11-02 14:00', 1);

-- Dữ liệu kiểm thử fn_TongTienThue
INSERT INTO Phong (MaPhong, SoGiuong, GiaTien, DangSuDung) VALUES
('Test001', 2, 1000000.00, 0),
('Test002', 1, 500000.00, 0);

create TABLE test_TongTienThue(
    MaPhong CHAR(10),
    MoTa NVARCHAR(150),
    NgayNhan SMALLDATETIME,
    NgayTra SMALLDATETIME,
    GiaPhong FLOAT,
    SoDemMongDoi INT,
    KetQuaMongDoi FLOAT
);

INSERT INTO test_TongTienThue VALUES 
('Test001', N'1. Ở 3 đêm bình thường (Test001: 1tr/đêm)', 
 '2025-12-01 10:00', '2025-12-04 10:00', 1000000.00, 3, 3000000.00),
('Test002', N'2. Ở trong ngày (Test002: 500k/đêm)', 
 '2025-12-05 08:00', '2025-12-05 18:00', 500000.00, 1, 500000.00),
('Test001', N'3. Ngày sai (Ngày trả < Ngày nhận) -> Tổng tiền = 0', 
 '2025-12-07', '2025-12-06', 1000000.00, 0, 0.00),
('P999', N'4. Phòng không tồn tại -> Giá phòng NULL -> Tổng tiền NULL', 
 '2025-12-08', '2025-12-09', NULL, 1, NULL);
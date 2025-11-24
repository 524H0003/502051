-- 1. Thanh toán cho P101 (Booking 2025-12-01)
-- Giả sử tổng tiền là 1,000,000, thanh toán 5,000,000
EXEC sp_TaoHoaDonThanhToan 
    @MaPhong = 'P101', 
    @NgayNhan = '2025-12-01', 
    @SoTienThanhToanMoi = 5000000;

-- 2. Thanh toán ĐỦ cho P102 (Booking 2025-12-01)
-- Giả sử tổng tiền là 2,550,000, thanh toán đúng 2,550,000
EXEC sp_TaoHoaDonThanhToan 
    @MaPhong = 'P102', 
    @NgayNhan = '2025-12-01', 
    @SoTienThanhToanMoi = 2550000;

-- 3. Thanh toán VƯỢT MỨC cho P201 (Booking 2025-12-05)
-- Giả sử tổng tiền là 1,800,000, thanh toán 1,900,000 
EXEC sp_TaoHoaDonThanhToan 
    @MaPhong = 'P201', 
    @NgayNhan = '2025-12-05', 
    @SoTienThanhToanMoi = 1900000;

-- 4. Thanh toán cho P202 (Booking 2025-12-08)
-- Giả sử tổng tiền là 2,400,000, thanh toán 3,000,000
EXEC sp_TaoHoaDonThanhToan 
    @MaPhong = 'P202', 
    @NgayNhan = '2025-12-08', 
    @SoTienThanhToanMoi = 3000000;

-- 5. Thanh toán ĐỦ cho P301 (Booking 2025-12-10)
-- Giả sử tổng tiền là 650,000, thanh toán đúng 650,000
EXEC sp_TaoHoaDonThanhToan 
    @MaPhong = 'P301', 
    @NgayNhan = '2025-12-10', 
    @SoTienThanhToanMoi = 650000;
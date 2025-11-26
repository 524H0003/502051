-- Việt Anh
CREATE OR ALTER PROCEDURE sp_DatPhong
(
    @MaKH          char(10),
    @MaPhong       char(10),
    @NgayNhan      date,
    @NgayTra       date
)
AS
BEGIN
    IF NOT EXISTS (SELECT * FROM KhachHang WHERE MaKH = @MaKH)
        THROW 50000, N'Lỗi: Mã khách hàng không tồn tại.', 1;

    IF NOT EXISTS (SELECT * FROM Phong WHERE MaPhong = @MaPhong)
        THROW 50000, N'Lỗi: Mã phòng không tồn tại.', 1;

    INSERT INTO HoaDon(MaKH, MaPhong, NgayNhan, NgayTra, TongThanhToan)
    VALUES (@MaKH, @MaPhong, @NgayNhan, @NgayTra, 0);
END

-- Phú
create procedure sp_DoanhThuThang
AS
begin 
    select 
      FORMAT(HoaDon.NgayNhan, 'yyyy-MM') AS Thang,
        SUM(HoaDon.TongThanhToan) as DoanhThu
    From HoaDon 
    where HoaDon.NgayThanhToan is not null
    GROUP BY FORMAT(HoaDon.NgayNhan, 'yyyy-MM')
END;

-- Danh
CREATE OR ALTER PROCEDURE sp_TaoHoaDonThanhToan
(
    @MaPhong            char(10),
    @NgayNhan           date,
    @SoTienThanhToan    float
)
AS
BEGIN
    Declare @TongThanhToan float = (SELECT TongThanhToan 
                                    FROM HoaDon 
                                    WHERE 
                                      MaPhong = @MaPhong AND 
                                      NgayNhan = @NgayNhan and 
                                      SoTienThanhToan is null);

    IF (@TongThanhToan is null)
        THROW 50000, N'Lỗi: Không tìm thấy hóa đơn cần thanh toán.', 1;

    IF (@SoTienThanhToan < @TongThanhToan)
        Throw 50000, N'Cảnh báo: Khách hàng đã thanh toán chưa đủ tổng tiền hóa đơn.', 1;

    UPDATE HoaDon
    SET 
        SoTienThanhToan = @SoTienThanhToan, 
        NgayThanhToan = GETDATE() 
    WHERE 
        MaPhong = @MaPhong 
        AND NgayNhan = @NgayNhan;
END;

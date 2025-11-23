-- Việt Anh
CREATE OR ALTER PROCEDURE sp_DatPhong
(
    @MaKH          char(10),
    @MaPhong       char(10),
    @NgayNhan      smalldatetime,
    @NgayTra       smalldatetime
)
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM KhachHang WHERE MaKH = @MaKH)
    BEGIN
        THROW 50000, N'Lỗi: Mã khách hàng không tồn tại.', 1;
    END

    
    IF NOT EXISTS (SELECT 1 FROM Phong WHERE MaPhong = @MaPhong)
    BEGIN
        THROW 50000, N'Lỗi: Mã phòng không tồn tại.', 1;
    END

    INSERT INTO HoaDon(MaKH, MaPhong, NgayNhan, NgayTra, TongThanhToan)
    VALUES (@MaKH, @MaPhong, @NgayNhan, @NgayTra, dbo.fn_TongTienThue(@MaPhong, @NgayNhan, @NgayTra));
END

-- Phú
create procedure sp_DoanhThuThang
AS
begin 
    select 
        DATEPART(month, HoaDon.NgayNhan) as Thang,
        SUM(HoaDon.TongThanhToan) as DoanhThu
    From HoaDon 
    where HoaDon.NgayThanhToan is not null
    GROUP BY DATEPART(month, HoaDon.NgayNhan)
END;

-- Danh
CREATE OR ALTER PROCEDURE sp_TaoHoaDonThanhToan
(
    @MaPhong            char(10),
    @NgayNhan           smalldatetime,
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
    BEGIN
        THROW 50000, N'Lỗi: Không tìm thấy hóa đơn cần thanh toán.', 1;
    END

    IF (@SoTienThanhToan < @TongThanhToan)
    BEGIN
        Throw 50000, N'Cảnh báo: Khách hàng đã thanh toán chưa đủ tổng tiền hóa đơn.', 1;
    END

    UPDATE HoaDon
    SET 
        SoTienThanhToan = @SoTienThanhToan, 
        NgayThanhToan = GETDATE() 
    WHERE 
        MaPhong = @MaPhong 
        AND NgayNhan = @NgayNhan;
END;

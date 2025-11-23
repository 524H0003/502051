-- Danh
CREATE or alter FUNCTION fn_SoDemThue
(
    @NgayNhan smalldatetime,
    @NgayTra smalldatetime
)
RETURNS INT
AS
BEGIN
  DECLARE 
    @SoDem INT = DATEDIFF(day, @NgayNhan, @NgayTra),
    @SoGiay INT = DATEDIFF(second, @NgayNhan, @NgayTra);

  IF (@SoGiay <= 0)
    SET @SoDem = 0;
  ELSE IF (@SoDem = 0)
    SET @SoDem = 1;

  RETURN @SoDem;
END;

-- Phú
create or alter function fn_SoLanDatPhong(@Khach char(10) )
returns @T TABLE (KH char(10), SLDatPhong int)
AS
BEGIN
	insert into @T
    SELECT MaKH, Count(TongThanhToan)
    from HoaDon 
    where MaKH = @Khach
    GROUP BY MaKH
    
    return
END;

-- Việt Anh
create or alter function fn_TongTienThue(
  @MaPhong char(10),
  @NgayNhan smalldatetime,
  @NgayTra smalldatetime
)
returns float
AS
BEGIN
    DECLARE 
        @SoDem INT = dbo.fn_SoDemThue(@NgayNhan, @NgayTra),
        @GiaTien FLOAT = (SELECT GiaTien FROM Phong WHERE MaPhong = @MaPhong);

    return @SoDem * @GiaTien;
END;
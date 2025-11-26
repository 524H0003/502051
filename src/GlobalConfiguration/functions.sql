-- Danh
CREATE or alter FUNCTION fn_SoDemThue
(
    @NgayNhan date,
    @NgayTra  date
)
RETURNS INT
AS
BEGIN
  DECLARE @SoDem INT = DATEDIFF(day, @NgayNhan, @NgayTra);

  IF (@SoDem < 0)
    SET @SoDem = 0;

  RETURN @SoDem;
END;

-- Phú
create or alter function fn_SoLanDatPhong(@Khach char(10) )
returns @T TABLE (KH char(10), SLDatPhong int)
AS
BEGIN
	if (@Khach is not null)
    BEGIN
	insert into @T
        SELECT MaKH, COUNT(TongThanhToan)
    from HoaDon 
    where MaKH = @Khach
    GROUP BY MaKH
    END
    ELSE
    BEGIN
    	insert into @T
        SELECT MaKH, COUNT(TongThanhToan)
        from HoaDon 
        GROUP BY MaKH
   END
    
   return;
END;

-- Việt Anh
create or alter function fn_TongTienThue(
  @MaPhong  char(10),
  @NgayNhan date,
  @NgayTra  date
)
returns float
AS
BEGIN
    DECLARE 
        @SoDem INT = dbo.fn_SoDemThue(@NgayNhan, @NgayTra),
        @GiaTien FLOAT = (SELECT GiaTien FROM Phong WHERE MaPhong = @MaPhong);

    return @SoDem * @GiaTien;
END;
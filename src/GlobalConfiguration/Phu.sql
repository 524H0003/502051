CREATE view PhongTrong As(
  select 
  T.Ngay, 
  STRING_AGG(T.MaPhong,', ') as CacPhongTrong
  from(
    Select DISTINCT
    BTG.Ngay,
    MaPhong 
    FROM 
    ThoiGian CROSS APPLY BangThoiGian(ThoiGian.giaTri, 7) as BTG, HoaDon
    where 
    BTG.Ngay not BETWEEN HoaDon.NgayNhan and HoaDon.NgayTra
  ) AS T
  GROUP BY Ngay
);

create function BangThoiGian(@TG smalldatetime, @SoNgay int)
returns @T TABLE (Ngay date) 
AS
BEGIN
	DECLARE @count int = 0;
    declare @date date = @TG;

    while @count < @SoNgay
    begin
      insert into @T values (@date);

      SET @count = @count + 1;
      SET @date = DATEADD(day, 1, @date);
    END
  
    return;
END;
-- Phú
create or alter function BangThoiGian(@TG date, @SoNgay int)
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

    return
END;

CREATE or alter VIEW View_PhongTrongTheoNgay AS
SELECT
    Ngay,
    STRING_AGG(P.MaPhong,', ') as PhongTrong
FROM
    Phong P
CROSS JOIN
    (
      SELECT Ngay
      FROM dbo.BangThoiGian((SELECT giaTri FROM ThoiGian WHERE id = 0), 60)
    ) CNKT
LEFT JOIN
    HoaDon HD ON P.MaPhong = HD.MaPhong
             AND CNKT.Ngay between HD.NgayNhan and HD.NgayTra
WHERE
    HD.MaPhong IS NULL
GROUP BY Ngay;

-- Danh
CREATE or alter VIEW V_KhachDatPhongTheoThang AS
SELECT
    T.Nam,
    T.Thang,
    STRING_AGG(T.HoVaTen, ', ') AS KhachHang
FROM
    (
        SELECT DISTINCT
            DATEPART(YEAR, HD.NgayNhan) AS Nam,
            DATEPART(MONTH, HD.NgayNhan) AS Thang,
            KH.HoVaTen
        FROM
            KhachHang KH
        INNER JOIN
            HoaDon HD ON HD.MaKH = KH.MaKH
    ) T
GROUP BY
    T.Nam,
    T.Thang;

-- Việt Anh
CREATE OR ALTER VIEW V_Top5PhongDoanhThu AS
SELECT TOP 5
    P.MaPhong,
    SUM(HD.TongThanhToan) AS TongDoanhThu
FROM 
    HoaDon HD
INNER JOIN 
    Phong P ON HD.MaPhong = P.MaPhong
WHERE 
    HD.NgayThanhToan IS NOT NULL
GROUP BY 
    P.MaPhong
ORDER BY 
    TongDoanhThu DESC;
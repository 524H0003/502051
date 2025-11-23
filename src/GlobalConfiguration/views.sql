-- Phú
CREATE or alter VIEW View_PhongTrongTheoNgay AS
WITH DateRange AS (
    SELECT
        CAST(MIN(NgayNhan) AS DATE) AS CalendarDate,
        CAST(MAX(NgayTra) AS DATE) AS MaxDate
    FROM HoaDon
    UNION ALL
    SELECT
        DATEADD(day, 1, CalendarDate),
        MaxDate
    FROM DateRange
    WHERE DATEADD(day, 1, CalendarDate) <= MaxDate
),
AllRooms AS (
    SELECT MaPhong FROM Phong
),
OccupiedRooms AS (
    -- Ghép các phòng đang bị chiếm với các ngày nằm trong khoảng thời gian thuê
    SELECT DISTINCT
        P.MaPhong,
        CAST(D.CalendarDate AS SMALLDATETIME) AS Ngay
    FROM
        DateRange D
    INNER JOIN
        HoaDon H ON D.CalendarDate >= CAST(H.NgayNhan AS DATE)
                 AND D.CalendarDate < CAST(H.NgayTra AS DATE) -- Phòng bị chiếm từ NgayNhan đến NgayTra - 1
    INNER JOIN
        AllRooms P ON H.MaPhong = P.MaPhong
)
-- Tìm các tổ hợp (MaPhong, Ngay) KHÔNG tồn tại trong danh sách bị chiếm
SELECT
    CAST(DR.CalendarDate AS SMALLDATETIME) AS Ngay,
    STRING_AGG(AR.MaPhong,', ') as PhongTrong
FROM
    AllRooms AR
CROSS JOIN
    DateRange DR
LEFT JOIN
    OccupiedRooms ORM ON AR.MaPhong = ORM.MaPhong AND CAST(DR.CalendarDate AS SMALLDATETIME) = ORM.Ngay
WHERE
    ORM.MaPhong IS NULL
GROUP BY 
    CAST(DR.CalendarDate AS SMALLDATETIME);

-- Danh
CREATE or alter VIEW V_KhachDatPhong_TrongThang AS
select 
    DATEPART(year, hd.NgayNhan) as Nam,
    DATEPART(month, hd.NgayNhan) as Thang,
    STRING_AGG(kh.HoVaTen,', ') as KhachDatPhong
From HoaDon hd
join KhachHang kh on hd.MaKH = kh.MaKH
join Phong p on hd.MaPhong = p.MaPhong
where 1=1
GROUP BY DATEPART(month, hd.NgayNhan), DATEPART(year, hd.NgayNhan)
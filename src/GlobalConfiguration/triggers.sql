-- Danh
CREATE OR ALTER TRIGGER trg_KiemTraPhongTrungNgay
ON HoaDon
INSTEAD OF INSERT, UPDATE
AS
BEGIN  
  IF EXISTS (
    SELECT *
    FROM inserted I
    WHERE dbo.fn_SoDemThue(I.NgayNhan, I.NgayTra) = 0
  )
      THROW 50000, N'Lỗi: Ngày trả phải sau ngày nhận ít nhất 1 ngày.', 1;
  
  IF EXISTS (SELECT * FROM deleted) 
      DELETE HD
      FROM HoaDon HD
      INNER JOIN deleted D ON HD.MaPhong = D.MaPhong AND HD.NgayNhan = D.NgayNhan;
  
  IF EXISTS (
      SELECT *
      FROM inserted I
      INNER JOIN HoaDon HD ON I.MaPhong = HD.MaPhong
      WHERE 
          I.NgayNhan < HD.NgayTra
          AND I.NgayTra > HD.NgayNhan
  )
  BEGIN
      ROLLBACK TRANSACTION; 
      THROW 50000, N'Lỗi: Phòng đã được đặt trong khoảng thời gian yêu cầu bởi một hóa đơn khác.', 1;
  END

  INSERT INTO HoaDon
  SELECT
      I.MaKH,
      I.MaPhong,
      I.NgayNhan,
      I.NgayTra,
      dbo.fn_TongTienThue(I.MaPhong, I.NgayNhan, I.NgayTra) AS TongThanhToan,
      I.NgayThanhToan,
      I.SoTienThanhToan
  FROM inserted I;
END;

-- Việt Anh
Create or alter trigger trg_CapNhatThoiGian
ON ThoiGian
after insert, update
as begin
    DECLARE @thoiGian date =(SELECT giaTri
                             FROM inserted
                             WHERE id = 0);
    UPDATE Phong SET DangSuDung = 0;

    UPDATE P
    SET P.DangSuDung = 1
    FROM Phong P
    INNER JOIN HoaDon HD ON P.MaPhong = HD.MaPhong
    WHERE 
        @thoiGian >= HD.NgayNhan 
        AND @thoiGian < HD.NgayTra;
END;

-- Nâng cao
CREATE or alter TRIGGER trg_GioiHanBookingChuaTra
ON HoaDon
AFTER INSERT
AS BEGIN  
    IF EXISTS (
        SELECT 1
        FROM (
            SELECT MaKH, MaPhong, NgayNhan, NgayThanhToan FROM HoaDon
        ) AS T
        WHERE NgayThanhToan IS NULL
        GROUP BY MaKH
        HAVING COUNT(MaKH) > 3
    )
    BEGIN
        ROLLBACK TRANSACTION;
        THROW 50000, N'Lỗi: Khách hàng không được có từ 3 đơn đặt phòng chưa trả.', 1;
    END
END;
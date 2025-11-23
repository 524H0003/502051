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
  
  IF EXISTS (SELECT 1 FROM deleted) 
      DELETE HD
      FROM HoaDon HD
      INNER JOIN deleted D ON HD.MaPhong = D.MaPhong AND HD.NgayNhan = D.NgayNhan;
  
  IF EXISTS (
      SELECT 1
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
  
  INSERT INTO HoaDon SELECT * FROM inserted;
END;

-- Phú
CREATE or alter trigger trg_CapNhatNgayTra
ON HoaDon
AFTER UPDATE
AS
	IF UPDATE(NgayTra)
    BEGIN
    	DECLARE @Gia float = (SELECT DISTINCT GiaTien from Phong, inserted where Phong.MaPhong = inserted.MaPhong)
        
        UPDATE HoaDon
        Set HoaDon.TongThanhToan = HoaDon.TongThanhToan + @Gia * DATEDIFF(day, inserted.NgayTra, deleted.NgayTra)
        From HoaDon, inserted, deleted
        Where HoaDon.MaKH = inserted.MaKH and HoaDon.MaPhong = inserted.MaPhong
    END

-- Việt Anh
Create or alter trigger trg_CapNhatThoiGian
ON ThoiGian
after insert, update
as begin
    DECLARE @thoiGian smalldatetime =(SELECT giaTri
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
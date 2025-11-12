create database QuanLyPhongKhachSan;

use QuanLyPhongKhachSan;

create table KhachHang(
  MaKH        char(10)       not null,
  HoVaTen     nvarchar(128)  not null,
  Phai        char(3)        not null,
  SDT         char(10)       not null,

  constraint PK_KhachHang primary key (MaKh),
  constraint CK_KhachHang_Phai check (Phai = 'nam' or Phai = 'nu')  
);

create table Phong(
  MaPhong  char(10) not null,
  SoGiuong  int not null,
  GiaTien float not null,
  DangDat bit  not null,
  
  constraint PK_Phong primary key (MaPhong),
  constraint CK_Phong_SoGiuong check (SoGiuong > 0)
);

create table HoaDon(
  MaKH        char(10)       not null,
  MaPhong     char(10)       not null,
  NgayNhan    smalldatetime  not null,
  NgayTra     smalldatetime  not null,
  ThanhGia float not null,
  DaThanhToan BIT not null,

  constraint PK_HoaDon primary key (MaPhong, NgayNhan),
  constraint CK_HoaDon_NgayNhan check(DATEDIFF(NgayNhan, NgayTra) > 0)
);
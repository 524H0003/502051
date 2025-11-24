drop database QuanLyPhongKhachSan;
create database QuanLyPhongKhachSan;

drop TABLE if exists HoaDon;
drop TABLE if exists Phong;
drop TABLE if exists KhachHang;
drop TABLE if exists ThoiGian;
create table KhachHang(
  MaKH             char(10)            not null,
  HoVaTen          nvarchar(128)       not null,
  Phai             char(3)             not null,
  SDT              char(10)            not null,

  constraint PK_KhachHang primary key (MaKh),
  constraint CK_KhachHang_Phai check (Phai = 'nam' or Phai = 'nu')  
);

create table Phong(
  MaPhong          char(10)            not null,
  SoGiuong         int                 not null,
  GiaTien          float               not null,
  DangSuDung       bit                 not null,
  
  constraint PK_Phong primary key (MaPhong),
  constraint CK_Phong_SoGiuong check (SoGiuong > 0),
  constraint CK_Phong_GiaTien check (GiaTien > 0)
);

create table HoaDon(
  MaKH             char(10)            not null,
  MaPhong          char(10)            not null,
  NgayNhan         date                not null,
  NgayTra          date                not null,
  TongThanhToan    float               not null,
  NgayThanhToan    date         ,
  SoTienThanhToan  float,

  constraint PK_HoaDon primary key (MaPhong, NgayNhan),
  constraint CK_HoaDon_NgayNhan check(DATEDIFF(day, NgayNhan, NgayTra) > 0),
  constraint CK_HoaDon_TongThanhToan check(TongThanhToan > 0),
  constraint CK_HoaDon_SoTienThanhToan check (SoTienThanhToan >= TongThanhToan),
  constraint FK_HoaDon_KhachHang foreign key (MaKH) references KhachHang(MaKH),
  constraint FK_HoaDon_Phong foreign key (MaPhong) references Phong(MaPhong),
);

create table ThoiGian(
  id               bit                 not null,
  giaTri           date                not null,

  constraint PK_ThoiGian primary key (id),
  constraint CK_ThoiGian_id check(id = 0)
);
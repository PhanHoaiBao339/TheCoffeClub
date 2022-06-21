﻿use master
go
create database TheCoffeeShop2
go
use TheCoffeeShop2

	create table NHANVIEN(
		MaNV varchar(5) not null,
		TenNV nvarchar(50) not null,
		Hinh nvarchar(50),
		CMND varchar(12) not null,
		DiaChi nvarchar(150),
		GioiTinh nvarchar(5),
		Email varchar(50),
		DienThoai varchar(12),
		NgaySinh date not null,
		NgayVaoLam date,
		ViTri nvarchar(20) not null,
		DeleteNV bit not null,
		Primary key(MaNV)
	)

	create table ACCOUNT(
		UserName varchar(15) not null,
		Password varchar(15) not null, 
		VaiTro bit not null,
		MaNV varchar(5) not null,
		Primary key (UserName)
	)

	create table LOAIMON(
		MaLoai varchar(10) not null,
		TenLoai nvarchar(20) not null,
		DeleteL bit not null,
		Primary key(MaLoai)
	)

	create table MENU(
		MaMon varchar(10) not null,
		TenMon nvarchar(50) not null,
		Gia float,
		HinhAnh nvarchar(50),
		MaLoai varchar(10),
		DeleteMon bit not null,
		Primary key(MaMon)
	)


	create table KHUVUC(
		MaKV varchar(5) not null,
		TenKV nvarchar(20) not null,
		TienIch nvarchar(50),
		DeleteKV bit not null,
		Primary key(MaKV)
	)

	create table BAN(
		MaBan varchar(10) not null,
		TenBan nvarchar(8) not null,
		MaKV varchar(5) not null,
		GhepBan varchar(100) null,
		DeleteBan bit not null,
		Primary key(MaBan)
	) 

	create table HOADON(
		MaHD int identity not null,
		MaBan varchar(10) not null,
		MaNV varchar(5) not null,
		NgayHD date,
		Tongtien float,
		Trangthai bit,
		TenNV nvarchar(50) not null,
		Primary key(MaHD)
	)

	create table HOADONCT(
		MaHDCT int identity not null,
		MaHD int not null,
		MaMon varchar(10) not null,
		SoLuong int,
		DonGia float,
		TenMon nvarchar(50) not null,
		Primary key(MaHDCT,MaHD)
	)

	
	Alter table ACCOUNT
		ADD CONSTRAINT FK_NhanVien_Account
			FOREIGN KEY(MaNV) REFERENCES NHANVIEN(MaNV)
				ON UPDATE CASCADE ON DELETE CASCADE;

	/*Alter Table NHANVIEN
		Drop FK_NhanVien_Account*/


	Alter table MENU
		ADD CONSTRAINT FK_MaLoai_Menu
			FOREIGN KEY(MaLoai) REFERENCES LOAIMON(MaLoai) 
				ON UPDATE CASCADE ON DELETE CASCADE;
	
	/*Alter Table MENU
		Drop FK_MaLoai_Menu*/

	Alter table BAN
		ADD CONSTRAINT FK_MaNV_BAN
			FOREIGN KEY(MaKV) REFERENCES KHUVUC(MaKV)
				ON DELETE CASCADE;

	Alter table HOADON
		ADD CONSTRAINT FK_MaBan_HD
			FOREIGN KEY(MaBan) REFERENCES BAN(MaBan)
				ON DELETE CASCADE;

	Alter table HOADON
		ADD CONSTRAINT FK_MaNV_HD
			FOREIGN KEY(MaNV) REFERENCES NHANVIEN(MaNV)
				ON UPDATE CASCADE;

	/*Alter Table HOADON
		Drop FK_MaNV_HD*/
	
	Alter table HOADONCT
		ADD CONSTRAINT FK_MaHD_HDCT
			FOREIGN KEY(MaHD) REFERENCES HOADON(MaHD)
				ON DELETE CASCADE;

	Alter table HOADONCT
		ADD CONSTRAINT FK_MaMon_HDCT
			FOREIGN KEY(MaMon) REFERENCES MENU(MaMon);



	/*Insert*/
	Insert into NHANVIEN values
		('NV001', N'Nguyễn Chí Trung', 'm (1).jpg', 
		'278890906', N'xã Long Thọ, huyện Nhơn Trạch, tỉnh Đồng Nai', 'Nam',
		'trungcafe33@gmail.com', '0909677888', '1990-05-08', '2020-05-05', N'Pha chế',0),

		('NV002', N'Nguyễn Thúy Ngân', 'fm (1).jpg', 
		'277689800', N'xã Hiệp Phước, huyện Nhơn Trạch, tỉnh Đồng Nai', N'Nữ', 
		'ngancute020@gmail.com', '0866542559', '1990-08-20', '2020-05-05', N'Pha chế',0),

		('NV003', N'Nguyễn Công Nam', 'm (2).jpg', 
		'264884770', N'xã Phước Thiền, huyện Nhơn Trạch, tỉnh Đồng Nai', 'Nam',
		'nampt77@gmail.com', '0947385359', '1985-01-07', '2018-04-12', N'Pha chế',0),
	
		('NV004', N'Phạm Thùy Trang', 'fm (6).jpg', 
		'267889080', N'xã Hiệp Phước, huyện Nhơn Trạch, tỉnh Đồng Nai', N'Nữ',
		'trangpham0103@gmail.com', '0998979700', '1989-04-01', '2018-05-04', N'Thu ngân',0),

		('NV005', N'Nguyễn Hoàng Vy', 'fm (3).jpg', 
		'268239888', N'xã An Phước, huyện Long Thành, tỉnh Đồng Nai', N'Nữ',
		'hoangvy03@gmail.com', '0909268886', '2003-01-05', '2021-01-03', N'Thu ngân',0),
	
		('NV006', N'Phạm Hoàng Long', 'm (3).jpg', 
		'279008989', N'xã Long Thọ, huyện Nhơn Trạch, tỉnh Đồng Nai', 'Nam',
		'longvuive01@gmail.com', '0712367523', '2000-12-20', '2019-08-12', N'Phục vụ',0),

		('NV007', N'Lê Thanh Trúc', 'fm (4).jpg', 
		'267678009', N'xã Phước Thiền, huyện Nhơn Trạch, tỉnh Đồng Nai', N'Nữ',
		'tructhanh1407@gmail.com', '0925210669', '2001-07-14', '2018-08-12', N'Phục vụ',0),

		('NV008', N'Nguyễn Chí Tài', 'm (4).jpg', 
		'273695698', N'xã Thanh Sơn, huyện Định Quán, tỉnh Đồng Nai', N'Nam',
		'ChiTaidl@gmail.com', '0368032214', '2001-11-14', '2018-09-20', N'Phục vụ',0),

		('NV009', N'Nguyễn Ý Như', 'fm (5).jpg', 
		'371845217', N'xã Vĩnh Thạnh, huyện Giồng Riềng, tỉnh Kiên Giang', N'Nữ',
		'ynhu1511@gmail.com', '0822990450', '1998-10-26', '2018-05-10', N'Phục vụ',0),

		('NV010', N'Phan Thanh Tâm', 'm (5).jpg', 
		'248978088', N'xã Long Thọ, huyện Nhơn Trạch, tỉnh Đồng Nai', 'Nam',
		'tamthanh88@gmail.com', '0839818670', '1982-03-29', '2018-09-12', N'Bảo vệ',0),

		('NV011', N'Lê Thanh Tùng','m (9).jpg',
		'301735761', N'Cao Văn Lầu, tp Tân An, tỉnh Long An', 'Nam',
		'tunglt204@gmail.com','0941996062','2001-04-20','2019-12-27',N'Bảo vệ',0),

		('NV012', N'Lê Hữu Tài', 'm (7).jpg', 
		'246768980011', N'xã Phước Thiền, huyện Nhơn Trạch, tỉnh Đồng Nai', 'Nam',
		'baophps15317@fpt.edu.vn', '0992871278', '1982-02-09', '2018-08-12', N'Quản lý',0),

		('NV013', N'Nguyễn Liêm Khiết', 'm (8).jpg', 
		'268786008890', N'xã Long Thọ, huyện Nhơn Trạch, tỉnh Đồng Nai', 'Nam',
		'khietquanly90@gmail.com', '096678880', '1984-04-12', '2018-08-12', N'Quản lý',0)



	Insert into ACCOUNT values
		('trangpham','trang0103', 0, 'NV004'),
		('hoangvyfa','vyfa005', 0, 'NV005'),
		('taiquanly','huutai80', 1, 'NV012'),
		('lkquanly', 'lk01211', 1, 'NV013')


	Insert into LoaiMon values
		('CF', 'Phin Coffee',0), 
		('TEA', N'Trà',0), 
		('ECF','Espresso Coffee',0), 
		('BREAD', N'Bánh Mì',0),
		('PASTRY', N'Bánh',0),
		('DRINKS', N'Thức Uống',0)


	Insert into MENU values
		('CF01',N'PHIN Đen Đá',20000,'CF_PhinDenDa.jpg','CF',0),
		('CF02',N'PHIN Sữa Đá',25000,'CF_PhinSuaDa.jpg','CF',0),
		('CF03',N'Bạc Xỉu Đá',22000,'CF_BacXiuDa.jpg','CF',0),
		
		('TEA01',N'Trà Sen Vàng',30000,'TEA_TraSenVang.jpg','TEA',0),
		('TEA02',N'Trà Thạch Đào',25000,'TEA_TraDao.jpg','TEA',0),
		('TEA03',N'Trà Dâu',32000,'TEA_TraDau.jpg','TEA',0),
		('TEA04',N'Trà Thạch Vải',28000,'TEA_TraVai.jpg','TEA',0),
		('TEA05',N'Trà Đào Hạt Chia',25000,'TEA_TraDaoHatChia.jpg','TEA',0),
		
		('ECF01',N'Latte',35000,'ECF_Latte.jpg','ECF',0),
		('ECF02',N'Cappuccino',50000,'ECF_Cappuccio.jpg','ECF',0),
		('ECF03',N'Mocha',55000,'ECF_Mocha.jpg','ECF',0),
		
		('BREAD01',N'Bánh Mì Pate Thịt Nguội',18000,'BREAD_BanhMiPate.jpg','BREAD',0),
		('BREAD02',N'Bánh Mì Thịt Nướng',18000,'BREAD_BanhThitNuong.jpg','BREAD',0),
		('BREAD03',N'Bánh Mì Que',15000,'BREAD_BanhQue.jpg','BREAD',0),
		('BREAD04',N'Bánh Mì Xíu Mại',16000,'BREAD_BanhThitXiuMai.jpg','BREAD',0),
		
		('PASTRY01',N'Bánh Táo',18000,'PASTRY_BanhTao.jpg','PASTRY',0),
		('PASTRY02',N'Mousse Đào',29000,'PASTRY_MousseDao.jpg','PASTRY',0),
		('PASTRY03',N'Mousse Cacao',29000,'PASTRY_MousseCacao.jpg','PASTRY',0),
		('PASTRY04',N'Phô Mai Trà Xanh',25000,'PASTRY_PhoMaiTraXanh.jpg','PASTRY',0),
		('PASTRY05',N'Phô Mai Cà Phê',25000,'PASTRY_PhoMaiCafe.jpg','PASTRY',0),
		('PASTRY06',N'Phô Mai Caramel',25000,'PASTRY_PhoMaiCaramel.jpg','PASTRY',0),
		
		('Drink01',N'Chanh Đá Xay',39000,'DRINKS_ChanhDayDaXay.jpg','DRINKS',0),
		('Drink02',N'Chanh Dây Đá Viên',39000,'DRINKS_ChanhDayDaVien.jpg','DRINKS',0),
		('Drink03',N'Chocolate Đá Xay',52000,'DRINKS_ChocolateDaXay.jpg','DRINKS',0),
		('Drink04',N'Milo Đá Xay',52000,'DRINKS_MiloDaXay.jpg','DRINKS',0)


	Insert into KHUVUC values
		(N'KV01',N'Tầng trệt',N'Máy Lạnh, Wi-fi',0),
		(N'KV02',N'Tầng 01',N'Máy Lạnh, Wi-fi',0),
		(N'KV03',N'Ngoài trời',N'Không, Wi-fi',0)

	
	Insert into BAN values
		(N'KV01BAN01',N'Bàn 1',N'KV01','',0),
		(N'KV01BAN02',N'Bàn 2',N'KV01','',0),
		(N'KV01BAN03',N'Bàn 3',N'KV01','',0),
		(N'KV01BAN04',N'Bàn 4',N'KV01','',0),
		(N'KV01BAN05',N'Bàn 5',N'KV01','',0),
		(N'KV01BAN06',N'Bàn 6',N'KV01','',0),
		(N'KV02BAN01',N'Bàn 1',N'KV02','',0),
		(N'KV02BAN02',N'Bàn 2',N'KV02','',0),
		(N'KV02BAN03',N'Bàn 3',N'KV02','',0),
		(N'KV02BAN04',N'Bàn 4',N'KV02','',0),
		(N'KV02BAN05',N'Bàn 5',N'KV02','',0),
		(N'KV02BAN06',N'Bàn 6',N'KV02','',0),
		(N'KV03BAN01',N'Bàn 1',N'KV03','',0),
		(N'KV03BAN02',N'Bàn 2',N'KV03','',0),
		(N'KV03BAN03',N'Bàn 3',N'KV03','',0),
		(N'KV03BAN04',N'Bàn 4',N'KV03','',0),
		(N'KV03BAN05',N'Bàn 5',N'KV03','',0),
		(N'KV03BAN06',N'Bàn 6',N'KV03','',0)


GO
SET IDENTITY_INSERT [dbo].[HOADON] ON 
INSERT [dbo].[HOADON] ([MaHD], [MaBan], [MaNV], [NgayHD], [Tongtien], [Trangthai], [TenNV]) VALUES (2, N'KV03BAN01', N'NV005', CAST(N'2020-01-01' AS Date), 105000, 1, N'Nguyễn Hoàng Vy')
INSERT [dbo].[HOADON] ([MaHD], [MaBan], [MaNV], [NgayHD], [Tongtien], [Trangthai], [TenNV]) VALUES (3, N'KV01BAN02', N'NV005', CAST(N'2020-01-02' AS Date), 128000, 1, N'Nguyễn Hoàng Vy')
INSERT [dbo].[HOADON] ([MaHD], [MaBan], [MaNV], [NgayHD], [Tongtien], [Trangthai], [TenNV]) VALUES (4, N'KV02BAN05', N'NV012', CAST(N'2020-02-05' AS Date), 143000, 1, N'Lê Hữu Tài')
INSERT [dbo].[HOADON] ([MaHD], [MaBan], [MaNV], [NgayHD], [Tongtien], [Trangthai], [TenNV]) VALUES (5, N'KV01BAN06', N'NV012', CAST(N'2020-02-10' AS Date), 96000, 1, N'Lê Hữu Tài')
INSERT [dbo].[HOADON] ([MaHD], [MaBan], [MaNV], [NgayHD], [Tongtien], [Trangthai], [TenNV]) VALUES (6, N'KV02BAN01', N'NV012', CAST(N'2020-03-01' AS Date), 45000, 1, N'Lê Hữu Tài')
INSERT [dbo].[HOADON] ([MaHD], [MaBan], [MaNV], [NgayHD], [Tongtien], [Trangthai], [TenNV]) VALUES (7, N'KV03BAN01', N'NV005', CAST(N'2020-03-20' AS Date), 255000, 1, N'Nguyễn Hoàng Vy')
INSERT [dbo].[HOADON] ([MaHD], [MaBan], [MaNV], [NgayHD], [Tongtien], [Trangthai], [TenNV]) VALUES (8, N'KV03BAN04', N'NV005', CAST(N'2020-04-28' AS Date), 127000, 1, N'Nguyễn Hoàng Vy')
INSERT [dbo].[HOADON] ([MaHD], [MaBan], [MaNV], [NgayHD], [Tongtien], [Trangthai], [TenNV]) VALUES (9, N'KV03BAN05', N'NV012', CAST(N'2020-04-29' AS Date), 100000, 1, N'Lê Hữu Tài')
INSERT [dbo].[HOADON] ([MaHD], [MaBan], [MaNV], [NgayHD], [Tongtien], [Trangthai], [TenNV]) VALUES (10, N'KV03BAN03', N'NV012', CAST(N'2020-04-13' AS Date), 166000, 1, N'Lê Hữu Tài')
INSERT [dbo].[HOADON] ([MaHD], [MaBan], [MaNV], [NgayHD], [Tongtien], [Trangthai], [TenNV]) VALUES (11, N'KV01BAN05', N'NV012', CAST(N'2020-05-18' AS Date), 105000, 1, N'Lê Hữu Tài')
INSERT [dbo].[HOADON] ([MaHD], [MaBan], [MaNV], [NgayHD], [Tongtien], [Trangthai], [TenNV]) VALUES (12, N'KV02BAN06', N'NV012', CAST(N'2020-05-09' AS Date), 53000, 1, N'Lê Hữu Tài')
INSERT [dbo].[HOADON] ([MaHD], [MaBan], [MaNV], [NgayHD], [Tongtien], [Trangthai], [TenNV]) VALUES (13, N'KV02BAN05', N'NV005', CAST(N'2020-06-08' AS Date), 100000, 1, N'Nguyễn Hoàng Vy')
INSERT [dbo].[HOADON] ([MaHD], [MaBan], [MaNV], [NgayHD], [Tongtien], [Trangthai], [TenNV]) VALUES (14, N'KV02BAN04', N'NV005', CAST(N'2020-06-08' AS Date), 121000, 1, N'Nguyễn Hoàng Vy')
INSERT [dbo].[HOADON] ([MaHD], [MaBan], [MaNV], [NgayHD], [Tongtien], [Trangthai], [TenNV]) VALUES (15, N'KV03BAN01', N'NV005', CAST(N'2020-07-06' AS Date), 157000, 1, N'Nguyễn Hoàng Vy')
INSERT [dbo].[HOADON] ([MaHD], [MaBan], [MaNV], [NgayHD], [Tongtien], [Trangthai], [TenNV]) VALUES (16, N'KV03BAN01', N'NV005', CAST(N'2020-07-08' AS Date), 63000, 1, N'Nguyễn Hoàng Vy')
INSERT [dbo].[HOADON] ([MaHD], [MaBan], [MaNV], [NgayHD], [Tongtien], [Trangthai], [TenNV]) VALUES (17, N'KV01BAN01', N'NV012', CAST(N'2020-08-19' AS Date), 105000, 1, N'Lê Hữu Tài')
INSERT [dbo].[HOADON] ([MaHD], [MaBan], [MaNV], [NgayHD], [Tongtien], [Trangthai], [TenNV]) VALUES (18, N'KV01BAN02', N'NV012', CAST(N'2020-09-18' AS Date), 51000, 1, N'Lê Hữu Tài')
INSERT [dbo].[HOADON] ([MaHD], [MaBan], [MaNV], [NgayHD], [Tongtien], [Trangthai], [TenNV]) VALUES (19, N'KV01BAN03', N'NV004', CAST(N'2020-09-21' AS Date), 54000, 1, N'Phạm Thùy Trang')
INSERT [dbo].[HOADON] ([MaHD], [MaBan], [MaNV], [NgayHD], [Tongtien], [Trangthai], [TenNV]) VALUES (20, N'KV01BAN04', N'NV004', CAST(N'2020-10-27' AS Date), 63000, 1, N'Phạm Thùy Trang')
INSERT [dbo].[HOADON] ([MaHD], [MaBan], [MaNV], [NgayHD], [Tongtien], [Trangthai], [TenNV]) VALUES (21, N'KV01BAN05', N'NV004', CAST(N'2020-10-27' AS Date), 94000, 1, N'Phạm Thùy Trang')
INSERT [dbo].[HOADON] ([MaHD], [MaBan], [MaNV], [NgayHD], [Tongtien], [Trangthai], [TenNV]) VALUES (22, N'KV01BAN06', N'NV012', CAST(N'2020-11-19' AS Date), 107000, 1, N'Lê Hữu Tài')
INSERT [dbo].[HOADON] ([MaHD], [MaBan], [MaNV], [NgayHD], [Tongtien], [Trangthai], [TenNV]) VALUES (23, N'KV01BAN06', N'NV012', CAST(N'2020-12-20' AS Date), 409000, 1, N'Lê Hữu Tài')

INSERT [dbo].[HOADON] ([MaHD], [MaBan], [MaNV], [NgayHD], [Tongtien], [Trangthai], [TenNV]) VALUES (24, N'KV01BAN01', N'NV005', CAST(N'2020-12-06' AS Date), 78000, 1, N'Nguyễn Hoàng Vy')
INSERT [dbo].[HOADON] ([MaHD], [MaBan], [MaNV], [NgayHD], [Tongtien], [Trangthai], [TenNV]) VALUES (25, N'KV01BAN01', N'NV004', CAST(N'2020-12-08' AS Date), 280000, 1, N'Phạm Thùy Trang')
INSERT [dbo].[HOADON] ([MaHD], [MaBan], [MaNV], [NgayHD], [Tongtien], [Trangthai], [TenNV]) VALUES (26, N'KV01BAN03', N'NV005', CAST(N'2020-12-08' AS Date), 142000, 1, N'Nguyễn Hoàng Vy')
INSERT [dbo].[HOADON] ([MaHD], [MaBan], [MaNV], [NgayHD], [Tongtien], [Trangthai], [TenNV]) VALUES (27, N'KV01BAN06', N'NV005', CAST(N'2020-12-08' AS Date), 163000, 1, N'Nguyễn Hoàng Vy')
INSERT [dbo].[HOADON] ([MaHD], [MaBan], [MaNV], [NgayHD], [Tongtien], [Trangthai], [TenNV]) VALUES (28, N'KV01BAN04', N'NV004', CAST(N'2020-12-08' AS Date), 102000, 1, N'Phạm Thùy Trang')
INSERT [dbo].[HOADON] ([MaHD], [MaBan], [MaNV], [NgayHD], [Tongtien], [Trangthai], [TenNV]) VALUES (29, N'KV01BAN02', N'NV004', CAST(N'2020-11-08' AS Date), 91000, 1, N'Phạm Thùy Trang')
INSERT [dbo].[HOADON] ([MaHD], [MaBan], [MaNV], [NgayHD], [Tongtien], [Trangthai], [TenNV]) VALUES (30, N'KV01BAN06', N'NV012', CAST(N'2020-11-07' AS Date), 120000, 1, N'Lê Hữu Tài')
INSERT [dbo].[HOADON] ([MaHD], [MaBan], [MaNV], [NgayHD], [Tongtien], [Trangthai], [TenNV]) VALUES (31, N'KV01BAN01', N'NV012', CAST(N'2020-11-06' AS Date), 72000, 1, N'Lê Hữu Tài')
INSERT [dbo].[HOADON] ([MaHD], [MaBan], [MaNV], [NgayHD], [Tongtien], [Trangthai], [TenNV]) VALUES (32, N'KV01BAN02', N'NV004', CAST(N'2020-11-06' AS Date), 110000, 1, N'Phạm Thùy Trang')
INSERT [dbo].[HOADON] ([MaHD], [MaBan], [MaNV], [NgayHD], [Tongtien], [Trangthai], [TenNV]) VALUES (33, N'KV01BAN03', N'NV012', CAST(N'2020-11-05' AS Date), 139000, 1, N'Lê Hữu Tài')
INSERT [dbo].[HOADON] ([MaHD], [MaBan], [MaNV], [NgayHD], [Tongtien], [Trangthai], [TenNV]) VALUES (34, N'KV01BAN06', N'NV005', CAST(N'2020-11-05' AS Date), 112000, 1, N'Nguyễn Hoàng Vy')
INSERT [dbo].[HOADON] ([MaHD], [MaBan], [MaNV], [NgayHD], [Tongtien], [Trangthai], [TenNV]) VALUES (35, N'KV01BAN05', N'NV005', CAST(N'2020-11-04' AS Date), 105000, 1, N'Nguyễn Hoàng Vy')
INSERT [dbo].[HOADON] ([MaHD], [MaBan], [MaNV], [NgayHD], [Tongtien], [Trangthai], [TenNV]) VALUES (36, N'KV01BAN02', N'NV004', CAST(N'2020-10-15' AS Date), 120000, 1, N'Phạm Thùy Trang')
INSERT [dbo].[HOADON] ([MaHD], [MaBan], [MaNV], [NgayHD], [Tongtien], [Trangthai], [TenNV]) VALUES (37, N'KV01BAN03', N'NV004', CAST(N'2020-10-12' AS Date), 125000, 1, N'Phạm Thùy Trang')
INSERT [dbo].[HOADON] ([MaHD], [MaBan], [MaNV], [NgayHD], [Tongtien], [Trangthai], [TenNV]) VALUES (38, N'KV01BAN01', N'NV005', CAST(N'2020-09-11' AS Date), 154000, 1, N'Nguyễn Hoàng Vy')
INSERT [dbo].[HOADON] ([MaHD], [MaBan], [MaNV], [NgayHD], [Tongtien], [Trangthai], [TenNV]) VALUES (39, N'KV01BAN04', N'NV005', CAST(N'2020-08-08' AS Date), 63000, 1, N'Nguyễn Hoàng Vy')
INSERT [dbo].[HOADON] ([MaHD], [MaBan], [MaNV], [NgayHD], [Tongtien], [Trangthai], [TenNV]) VALUES (40, N'KV01BAN05', N'NV004', CAST(N'2020-07-21' AS Date), 113000, 1, N'Phạm Thùy Trang')
INSERT [dbo].[HOADON] ([MaHD], [MaBan], [MaNV], [NgayHD], [Tongtien], [Trangthai], [TenNV]) VALUES (41, N'KV01BAN06', N'NV005', CAST(N'2020-06-17' AS Date), 146000, 1, N'Nguyễn Hoàng Vy')
INSERT [dbo].[HOADON] ([MaHD], [MaBan], [MaNV], [NgayHD], [Tongtien], [Trangthai], [TenNV]) VALUES (42, N'KV01BAN03', N'NV005', CAST(N'2020-09-29' AS Date), 127000, 1, N'Nguyễn Hoàng Vy')
INSERT [dbo].[HOADON] ([MaHD], [MaBan], [MaNV], [NgayHD], [Tongtien], [Trangthai], [TenNV]) VALUES (43, N'KV01BAN06', N'NV012', CAST(N'2020-04-20' AS Date), 103000, 1, N'Lê Hữu Tài')
INSERT [dbo].[HOADON] ([MaHD], [MaBan], [MaNV], [NgayHD], [Tongtien], [Trangthai], [TenNV]) VALUES (44, N'KV01BAN03', N'NV004', CAST(N'2020-02-13' AS Date), 121000, 1, N'Phạm Thùy Trang')
INSERT [dbo].[HOADON] ([MaHD], [MaBan], [MaNV], [NgayHD], [Tongtien], [Trangthai], [TenNV]) VALUES (45, N'KV01BAN06', N'NV004', CAST(N'2020-07-07' AS Date), 154000, 1, N'Phạm Thùy Trang')

INSERT [dbo].[HOADON] ([MaHD], [MaBan], [MaNV], [NgayHD], [Tongtien], [Trangthai], [TenNV]) VALUES (46, N'KV01BAN04', N'NV005', CAST(N'2021-12-02' AS Date), 121000, 1, N'Nguyễn Hoàng Vy')
INSERT [dbo].[HOADON] ([MaHD], [MaBan], [MaNV], [NgayHD], [Tongtien], [Trangthai], [TenNV]) VALUES (47, N'KV02BAN02', N'NV005', CAST(N'2021-12-06' AS Date), 276000, 1, N'Nguyễn Hoàng Vy')
INSERT [dbo].[HOADON] ([MaHD], [MaBan], [MaNV], [NgayHD], [Tongtien], [Trangthai], [TenNV]) VALUES (48, N'KV03BAN05', N'NV013', CAST(N'2021-11-06' AS Date), 620000, 1, N'Nguyễn Liêm Khiết')
INSERT [dbo].[HOADON] ([MaHD], [MaBan], [MaNV], [NgayHD], [Tongtien], [Trangthai], [TenNV]) VALUES (49, N'KV02BAN05', N'NV004', CAST(N'2021-11-08' AS Date), 25000, 1, N'Phạm Thùy Trang')
INSERT [dbo].[HOADON] ([MaHD], [MaBan], [MaNV], [NgayHD], [Tongtien], [Trangthai], [TenNV]) VALUES (50, N'KV01BAN03', N'NV004', CAST(N'2021-11-15' AS Date), 25000, 1, N'Nguyễn Liêm Khiết')
INSERT [dbo].[HOADON] ([MaHD], [MaBan], [MaNV], [NgayHD], [Tongtien], [Trangthai], [TenNV]) VALUES (51, N'KV01BAN01', N'NV004', CAST(N'2021-11-14' AS Date), 103000, 1, N'Phạm Thùy Trang')
INSERT [dbo].[HOADON] ([MaHD], [MaBan], [MaNV], [NgayHD], [Tongtien], [Trangthai], [TenNV]) VALUES (52, N'KV01BAN03', N'NV004', CAST(N'2021-10-22' AS Date), 149000, 1, N'Phạm Thùy Trang')
INSERT [dbo].[HOADON] ([MaHD], [MaBan], [MaNV], [NgayHD], [Tongtien], [Trangthai], [TenNV]) VALUES (53, N'KV01BAN02', N'NV004', CAST(N'2021-08-09' AS Date), 127000, 1, N'Phạm Thùy Trang')
INSERT [dbo].[HOADON] ([MaHD], [MaBan], [MaNV], [NgayHD], [Tongtien], [Trangthai], [TenNV]) VALUES (54, N'KV02BAN03', N'NV012', CAST(N'2021-10-25' AS Date), 93000, 1, N'Nguyễn Hoàng Vy')
INSERT [dbo].[HOADON] ([MaHD], [MaBan], [MaNV], [NgayHD], [Tongtien], [Trangthai], [TenNV]) VALUES (55, N'KV01BAN04', N'NV005', CAST(N'2021-04-30' AS Date), 37000, 1, N'Nguyễn Hoàng Vy')
INSERT [dbo].[HOADON] ([MaHD], [MaBan], [MaNV], [NgayHD], [Tongtien], [Trangthai], [TenNV]) VALUES (56, N'KV01BAN02', N'NV005', CAST(N'2021-05-01' AS Date), 51000, 1, N'Nguyễn Hoàng Vy')
INSERT [dbo].[HOADON] ([MaHD], [MaBan], [MaNV], [NgayHD], [Tongtien], [Trangthai], [TenNV]) VALUES (57, N'KV01BAN01', N'NV005', CAST(N'2021-04-29' AS Date), 112000, 1, N'Nguyễn Hoàng Vy')
INSERT [dbo].[HOADON] ([MaHD], [MaBan], [MaNV], [NgayHD], [Tongtien], [Trangthai], [TenNV]) VALUES (58, N'KV01BAN04', N'NV004', CAST(N'2021-09-19' AS Date), 77000, 1, N'Phạm Thùy Trang')
INSERT [dbo].[HOADON] ([MaHD], [MaBan], [MaNV], [NgayHD], [Tongtien], [Trangthai], [TenNV]) VALUES (59, N'KV03BAN01', N'NV004', CAST(N'2021-09-30' AS Date), 98000, 1, N'Phạm Thùy Trang')
INSERT [dbo].[HOADON] ([MaHD], [MaBan], [MaNV], [NgayHD], [Tongtien], [Trangthai], [TenNV]) VALUES (60, N'KV03BAN02', N'NV005', CAST(N'2021-08-21' AS Date), 76000, 1, N'Nguyễn Hoàng Vy')
INSERT [dbo].[HOADON] ([MaHD], [MaBan], [MaNV], [NgayHD], [Tongtien], [Trangthai], [TenNV]) VALUES (61, N'KV01BAN04', N'NV005', CAST(N'2021-02-13' AS Date), 75000, 1, N'Nguyễn Hoàng Vy')
INSERT [dbo].[HOADON] ([MaHD], [MaBan], [MaNV], [NgayHD], [Tongtien], [Trangthai], [TenNV]) VALUES (62, N'KV01BAN03', N'NV004', CAST(N'2021-06-09' AS Date), 79000, 1, N'Phạm Thùy Trang')
INSERT [dbo].[HOADON] ([MaHD], [MaBan], [MaNV], [NgayHD], [Tongtien], [Trangthai], [TenNV]) VALUES (63, N'KV01BAN04', N'NV005', CAST(N'2021-07-11' AS Date), 87000, 1, N'Nguyễn Hoàng Vy')
INSERT [dbo].[HOADON] ([MaHD], [MaBan], [MaNV], [NgayHD], [Tongtien], [Trangthai], [TenNV]) VALUES (64, N'KV01BAN04', N'NV013', CAST(N'2021-06-26' AS Date), 30000, 1, N'Nguyễn Liêm Khiết')
INSERT [dbo].[HOADON] ([MaHD], [MaBan], [MaNV], [NgayHD], [Tongtien], [Trangthai], [TenNV]) VALUES (65, N'KV02BAN03', N'NV013', CAST(N'2021-11-20' AS Date), 50000, 1, N'Nguyễn Liêm Khiết')

INSERT [dbo].[HOADON] ([MaHD], [MaBan], [MaNV], [NgayHD], [Tongtien], [Trangthai], [TenNV]) VALUES (66, N'KV02BAN01', N'NV004', CAST(N'2021-01-08' AS Date), 66000, 1, N'Phạm Thùy Trang')
INSERT [dbo].[HOADON] ([MaHD], [MaBan], [MaNV], [NgayHD], [Tongtien], [Trangthai], [TenNV]) VALUES (67, N'KV02BAN03', N'NV004', CAST(N'2021-01-08' AS Date), 105000, 1, N'Phạm Thùy Trang')
INSERT [dbo].[HOADON] ([MaHD], [MaBan], [MaNV], [NgayHD], [Tongtien], [Trangthai], [TenNV]) VALUES (68, N'KV02BAN02', N'NV004', CAST(N'2021-02-08' AS Date), 130000, 1, N'Phạm Thùy Trang')
INSERT [dbo].[HOADON] ([MaHD], [MaBan], [MaNV], [NgayHD], [Tongtien], [Trangthai], [TenNV]) VALUES (69, N'KV02BAN04', N'NV004', CAST(N'2021-02-08' AS Date), 100000, 1, N'Phạm Thùy Trang')
INSERT [dbo].[HOADON] ([MaHD], [MaBan], [MaNV], [NgayHD], [Tongtien], [Trangthai], [TenNV]) VALUES (70, N'KV02BAN06', N'NV004', CAST(N'2021-03-08' AS Date), 134000, 1, N'Phạm Thùy Trang')
INSERT [dbo].[HOADON] ([MaHD], [MaBan], [MaNV], [NgayHD], [Tongtien], [Trangthai], [TenNV]) VALUES (71, N'KV02BAN05', N'NV004', CAST(N'2021-03-08' AS Date), 188000, 1, N'Phạm Thùy Trang')
INSERT [dbo].[HOADON] ([MaHD], [MaBan], [MaNV], [NgayHD], [Tongtien], [Trangthai], [TenNV]) VALUES (72, N'KV03BAN01', N'NV004', CAST(N'2021-04-08' AS Date), 160000, 1, N'Phạm Thùy Trang')
INSERT [dbo].[HOADON] ([MaHD], [MaBan], [MaNV], [NgayHD], [Tongtien], [Trangthai], [TenNV]) VALUES (73, N'KV03BAN03', N'NV004', CAST(N'2021-04-08' AS Date), 98000, 1, N'Phạm Thùy Trang')
INSERT [dbo].[HOADON] ([MaHD], [MaBan], [MaNV], [NgayHD], [Tongtien], [Trangthai], [TenNV]) VALUES (74, N'KV03BAN02', N'NV004', CAST(N'2021-05-08' AS Date), 210000, 1, N'Phạm Thùy Trang')
INSERT [dbo].[HOADON] ([MaHD], [MaBan], [MaNV], [NgayHD], [Tongtien], [Trangthai], [TenNV]) VALUES (75, N'KV03BAN06', N'NV004', CAST(N'2021-05-08' AS Date), 210000, 1, N'Phạm Thùy Trang')
INSERT [dbo].[HOADON] ([MaHD], [MaBan], [MaNV], [NgayHD], [Tongtien], [Trangthai], [TenNV]) VALUES (76, N'KV03BAN05', N'NV004', CAST(N'2021-06-08' AS Date), 210000, 1, N'Phạm Thùy Trang')
INSERT [dbo].[HOADON] ([MaHD], [MaBan], [MaNV], [NgayHD], [Tongtien], [Trangthai], [TenNV]) VALUES (77, N'KV03BAN04', N'NV004', CAST(N'2021-06-08' AS Date), 148000, 1, N'Phạm Thùy Trang')
INSERT [dbo].[HOADON] ([MaHD], [MaBan], [MaNV], [NgayHD], [Tongtien], [Trangthai], [TenNV]) VALUES (78, N'KV02BAN01', N'NV004', CAST(N'2021-07-08' AS Date), 79000, 1, N'Phạm Thùy Trang')
INSERT [dbo].[HOADON] ([MaHD], [MaBan], [MaNV], [NgayHD], [Tongtien], [Trangthai], [TenNV]) VALUES (79, N'KV02BAN03', N'NV004', CAST(N'2021-07-08' AS Date), 116000, 1, N'Phạm Thùy Trang')
INSERT [dbo].[HOADON] ([MaHD], [MaBan], [MaNV], [NgayHD], [Tongtien], [Trangthai], [TenNV]) VALUES (80, N'KV02BAN02', N'NV004', CAST(N'2021-08-08' AS Date), 127000, 1, N'Phạm Thùy Trang')
INSERT [dbo].[HOADON] ([MaHD], [MaBan], [MaNV], [NgayHD], [Tongtien], [Trangthai], [TenNV]) VALUES (81, N'KV03BAN02', N'NV004', CAST(N'2021-08-08' AS Date), 210000, 1, N'Phạm Thùy Trang')
INSERT [dbo].[HOADON] ([MaHD], [MaBan], [MaNV], [NgayHD], [Tongtien], [Trangthai], [TenNV]) VALUES (82, N'KV02BAN01', N'NV004', CAST(N'2021-09-08' AS Date), 90000, 1, N'Phạm Thùy Trang')
INSERT [dbo].[HOADON] ([MaHD], [MaBan], [MaNV], [NgayHD], [Tongtien], [Trangthai], [TenNV]) VALUES (83, N'KV02BAN03', N'NV004', CAST(N'2021-09-08' AS Date), 109000, 1, N'Phạm Thùy Trang')
INSERT [dbo].[HOADON] ([MaHD], [MaBan], [MaNV], [NgayHD], [Tongtien], [Trangthai], [TenNV]) VALUES (84, N'KV02BAN05', N'NV004', CAST(N'2021-10-08' AS Date), 75000, 1, N'Phạm Thùy Trang')
INSERT [dbo].[HOADON] ([MaHD], [MaBan], [MaNV], [NgayHD], [Tongtien], [Trangthai], [TenNV]) VALUES (85, N'KV03BAN04', N'NV004', CAST(N'2021-10-08' AS Date), 111000, 1, N'Phạm Thùy Trang')
INSERT [dbo].[HOADON] ([MaHD], [MaBan], [MaNV], [NgayHD], [Tongtien], [Trangthai], [TenNV]) VALUES (86, N'KV03BAN01', N'NV004', CAST(N'2021-11-08' AS Date), 85000, 1, N'Phạm Thùy Trang')
INSERT [dbo].[HOADON] ([MaHD], [MaBan], [MaNV], [NgayHD], [Tongtien], [Trangthai], [TenNV]) VALUES (87, N'KV03BAN05', N'NV004', CAST(N'2021-11-08' AS Date), 72000, 1, N'Phạm Thùy Trang')
INSERT [dbo].[HOADON] ([MaHD], [MaBan], [MaNV], [NgayHD], [Tongtien], [Trangthai], [TenNV]) VALUES (88, N'KV03BAN03', N'NV004', CAST(N'2021-12-08' AS Date), 69000, 1, N'Phạm Thùy Trang')
INSERT [dbo].[HOADON] ([MaHD], [MaBan], [MaNV], [NgayHD], [Tongtien], [Trangthai], [TenNV]) VALUES (89, N'KV02BAN05', N'NV004', CAST(N'2021-12-08' AS Date), 97000, 1, N'Phạm Thùy Trang')

INSERT [dbo].[HOADON] ([MaHD], [MaBan], [MaNV], [NgayHD], [Tongtien], [Trangthai], [TenNV]) VALUES (90, N'KV01BAN01', N'NV005', CAST(N'2021-01-06' AS Date), 36000, 1, N'Nguyễn Hoàng Vy')
INSERT [dbo].[HOADON] ([MaHD], [MaBan], [MaNV], [NgayHD], [Tongtien], [Trangthai], [TenNV]) VALUES (91, N'KV02BAN01', N'NV005', CAST(N'2021-01-06' AS Date), 442000, 1, N'Nguyễn Hoàng Vy')
INSERT [dbo].[HOADON] ([MaHD], [MaBan], [MaNV], [NgayHD], [Tongtien], [Trangthai], [TenNV]) VALUES (92, N'KV03BAN04', N'NV005', CAST(N'2021-02-06' AS Date), 55000, 1, N'Nguyễn Hoàng Vy')
INSERT [dbo].[HOADON] ([MaHD], [MaBan], [MaNV], [NgayHD], [Tongtien], [Trangthai], [TenNV]) VALUES (93, N'KV02BAN01', N'NV005', CAST(N'2021-04-08' AS Date), 185000, 1, N'Nguyễn Hoàng Vy')
INSERT [dbo].[HOADON] ([MaHD], [MaBan], [MaNV], [NgayHD], [Tongtien], [Trangthai], [TenNV]) VALUES (94, N'KV01BAN02', N'NV005', CAST(N'2021-03-08' AS Date), 264000, 1, N'Nguyễn Hoàng Vy')
INSERT [dbo].[HOADON] ([MaHD], [MaBan], [MaNV], [NgayHD], [Tongtien], [Trangthai], [TenNV]) VALUES (95, N'KV03BAN02', N'NV005', CAST(N'2021-04-08' AS Date), 42000, 1, N'Nguyễn Hoàng Vy')
INSERT [dbo].[HOADON] ([MaHD], [MaBan], [MaNV], [NgayHD], [Tongtien], [Trangthai], [TenNV]) VALUES (96, N'KV01BAN02', N'NV005', CAST(N'2021-05-08' AS Date), 113000, 1, N'Nguyễn Hoàng Vy')
INSERT [dbo].[HOADON] ([MaHD], [MaBan], [MaNV], [NgayHD], [Tongtien], [Trangthai], [TenNV]) VALUES (97, N'KV02BAN02', N'NV005', CAST(N'2021-05-08' AS Date), 22000, 1, N'Nguyễn Hoàng Vy')
INSERT [dbo].[HOADON] ([MaHD], [MaBan], [MaNV], [NgayHD], [Tongtien], [Trangthai], [TenNV]) VALUES (98, N'KV01BAN06', N'NV005', CAST(N'2021-06-08' AS Date), 103000, 1, N'Nguyễn Hoàng Vy')
INSERT [dbo].[HOADON] ([MaHD], [MaBan], [MaNV], [NgayHD], [Tongtien], [Trangthai], [TenNV]) VALUES (99, N'KV01BAN02', N'NV005', CAST(N'2021-07-08' AS Date), 55000, 1, N'Nguyễn Hoàng Vy')
INSERT [dbo].[HOADON] ([MaHD], [MaBan], [MaNV], [NgayHD], [Tongtien], [Trangthai], [TenNV]) VALUES (100, N'KV01BAN02', N'NV005', CAST(N'2021-08-08' AS Date), 82000, 1, N'Nguyễn Hoàng Vy')
INSERT [dbo].[HOADON] ([MaHD], [MaBan], [MaNV], [NgayHD], [Tongtien], [Trangthai], [TenNV]) VALUES (101, N'KV01BAN05', N'NV005', CAST(N'2021-08-08' AS Date), 172000, 1, N'Nguyễn Hoàng Vy')
INSERT [dbo].[HOADON] ([MaHD], [MaBan], [MaNV], [NgayHD], [Tongtien], [Trangthai], [TenNV]) VALUES (102, N'KV01BAN02', N'NV005', CAST(N'2021-09-08' AS Date), 57000, 1, N'Nguyễn Hoàng Vy')
INSERT [dbo].[HOADON] ([MaHD], [MaBan], [MaNV], [NgayHD], [Tongtien], [Trangthai], [TenNV]) VALUES (103, N'KV01BAN03', N'NV005', CAST(N'2021-10-08' AS Date), 47000, 1, N'Nguyễn Hoàng Vy')
INSERT [dbo].[HOADON] ([MaHD], [MaBan], [MaNV], [NgayHD], [Tongtien], [Trangthai], [TenNV]) VALUES (104, N'KV01BAN04', N'NV005', CAST(N'2021-10-08' AS Date), 111000, 1, N'Nguyễn Hoàng Vy')
INSERT [dbo].[HOADON] ([MaHD], [MaBan], [MaNV], [NgayHD], [Tongtien], [Trangthai], [TenNV]) VALUES (105, N'KV03BAN02', N'NV005', CAST(N'2021-11-08' AS Date), 166000, 1, N'Nguyễn Hoàng Vy')
SET IDENTITY_INSERT [dbo].[HOADON] OFF

SET IDENTITY_INSERT [dbo].[HOADON] OFF

GO
SET IDENTITY_INSERT [dbo].[HOADONCT] ON 
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (4, 2, N'CF03', 1, 22000, N'Bạc Xỉu Đá')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (5, 2, N'PASTRY05', 1, 25000, N'Phô Mai Cà Phê')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (6, 2, N'TEA04', 1, 28000, N'Trà Thạch Vải')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (7, 2, N'TEA01', 1, 30000, N'Trà Sen Vàng')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (8, 3, N'Drink02', 2, 39000, N'Chanh Dây Đá Viên')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (9, 3, N'PASTRY05', 2, 25000, N'Phô Mai Cà Phê')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (10, 4, N'PASTRY06', 2, 25000, N'Phô Mai Caramel')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (11, 4, N'TEA05', 3, 25000, N'Trà Đào Hạt Chia')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (12, 4, N'BREAD01', 1, 18000, N'Bánh Mì Pate Thịt Nguội')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (13, 5, N'TEA03', 3, 32000, N'Trà Dâu')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (14, 6, N'CF01', 1, 20000, N'PHIN Đen Đá')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (15, 6, N'CF02', 1, 25000, N'PHIN Sữa Đá')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (16, 7, N'BREAD01', 1, 18000, N'Bánh Mì Pate Thịt Nguội')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (17, 7, N'BREAD02', 1, 18000, N'Bánh Mì Thịt Nướng')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (18, 7, N'BREAD02', 2, 18000, N'Bánh Mì Thịt Nướng')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (19, 7, N'TEA02', 2, 25000, N'Trà Thạch Đào')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (20, 7, N'PASTRY03', 2, 29000, N'Mousse Cacao')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (21, 7, N'TEA05', 3, 25000, N'Trà Đào Hạt Chia')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (22, 8, N'CF02', 1, 25000, N'PHIN Sữa Đá')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (23, 8, N'CF03', 2, 22000, N'Bạc Xỉu Đá')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (24, 8, N'PASTRY02', 2, 29000, N'Mousse Đào')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (25, 9, N'PASTRY05', 1, 25000, N'Phô Mai Cà Phê')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (26, 9, N'PASTRY06', 1, 25000, N'Phô Mai Caramel')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (27, 9, N'TEA02', 2, 25000, N'Trà Thạch Đào')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (28, 10, N'Drink01', 1, 39000, N'Chanh Đá Xay')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (29, 10, N'ECF02', 1, 50000, N'Cappuccino')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (30, 10, N'Drink04', 1, 52000, N'Milo Đá Xay')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (31, 10, N'TEA02', 1, 25000, N'Trà Thạch Đào')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (32, 11, N'ECF03', 1, 55000, N'Mocha')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (33, 11, N'PASTRY04', 1, 25000, N'Phô Mai Trà Xanh')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (34, 11, N'TEA02', 1, 25000, N'Trà Thạch Đào')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (35, 12, N'TEA04', 1, 28000, N'Trà Thạch Vải')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (36, 12, N'TEA02', 1, 25000, N'Trà Thạch Đào')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (37, 14, N'PASTRY05', 1, 25000, N'Phô Mai Cà Phê')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (38, 14, N'TEA03', 1, 32000, N'Trà Dâu')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (39, 14, N'TEA03', 2, 32000, N'Trà Dâu')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (40, 13, N'PASTRY04', 1, 25000, N'Phô Mai Trà Xanh')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (41, 13, N'TEA05', 1, 25000, N'Trà Đào Hạt Chia')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (42, 13, N'ECF02', 1, 50000, N'Cappuccino')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (43, 15, N'Drink04', 1, 52000, N'Milo Đá Xay')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (44, 15, N'ECF03', 1, 55000, N'Mocha')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (45, 15, N'TEA02', 1, 25000, N'Trà Thạch Đào')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (46, 15, N'TEA05', 1, 25000, N'Trà Đào Hạt Chia')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (47, 16, N'BREAD02', 1, 18000, N'Bánh Mì Thịt Nướng')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (48, 16, N'CF01', 1, 20000, N'PHIN Đen Đá')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (49, 16, N'CF02', 1, 25000, N'PHIN Sữa Đá')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (50, 22, N'TEA05', 1, 25000, N'Trà Đào Hạt Chia')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (51, 22, N'TEA05', 2, 25000, N'Trà Đào Hạt Chia')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (52, 22, N'TEA03', 1, 32000, N'Trà Dâu')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (53, 21, N'ECF03', 1, 55000, N'Mocha')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (54, 21, N'Drink02', 1, 39000, N'Chanh Dây Đá Viên')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (55, 20, N'CF03', 1, 22000, N'Bạc Xỉu Đá')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (56, 20, N'BREAD04', 1, 16000, N'Bánh Mì Xíu Mại')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (57, 20, N'CF02', 1, 25000, N'PHIN Sữa Đá')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (58, 19, N'PASTRY06', 1, 25000, N'Phô Mai Caramel')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (59, 19, N'PASTRY02', 1, 29000, N'Mousse Đào')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (60, 18, N'BREAD03', 1, 15000, N'Bánh Mì Que')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (61, 18, N'BREAD02', 1, 18000, N'Bánh Mì Thịt Nướng')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (62, 18, N'BREAD01', 1, 18000, N'Bánh Mì Pate Thịt Nguội')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (63, 17, N'PASTRY06', 1, 25000, N'Phô Mai Caramel')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (64, 17, N'PASTRY05', 1, 25000, N'Phô Mai Cà Phê')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (65, 17, N'ECF03', 1, 55000, N'Mocha')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (66, 23, N'Drink01', 1, 39000, N'Chanh Đá Xay')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (67, 23, N'BREAD01', 1, 18000, N'Bánh Mì Pate Thịt Nguội')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (68, 23, N'BREAD02', 1, 18000, N'Bánh Mì Thịt Nướng')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (69, 23, N'BREAD03', 1, 15000, N'Bánh Mì Que')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (70, 23, N'BREAD04', 1, 16000, N'Bánh Mì Xíu Mại')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (71, 23, N'CF01', 1, 20000, N'PHIN Đen Đá')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (72, 23, N'CF02', 1, 25000, N'PHIN Sữa Đá')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (73, 23, N'CF03', 1, 22000, N'Bạc Xỉu Đá')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (74, 23, N'ECF01', 1, 35000, N'Latte')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (75, 23, N'ECF02', 1, 50000, N'Cappuccino')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (76, 23, N'ECF03', 1, 55000, N'Mocha')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (77, 23, N'PASTRY01', 1, 18000, N'Bánh Táo')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (78, 23, N'TEA05', 1, 25000, N'Trà Đào Hạt Chia')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (79, 23, N'TEA04', 1, 28000, N'Trà Thạch Vải')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (80, 23, N'TEA02', 1, 25000, N'Trà Thạch Đào')

INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (81, 24, N'CF02', 1, 25000, N'PHIN Sữa Đá')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (82, 24, N'ECF01', 1, 35000, N'Latte')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (83, 24, N'BREAD02', 1, 18000, N'Bánh Mì Thịt Nướng')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (84, 25, N'CF03', 1, 22000, N'Bạc Xỉu Đá')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (85, 25, N'CF02', 1, 25000, N'PHIN Sữa Đá')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (86, 25, N'BREAD01', 1, 18000, N'Bánh Mì Pate Thịt Nguội')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (87, 25, N'BREAD02', 1, 18000, N'Bánh Mì Thịt Nướng')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (88, 25, N'TEA02', 1, 25000, N'Trà Thạch Đào')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (89, 25, N'PASTRY03', 1, 29000, N'Mousse Cacao')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (90, 25, N'TEA03', 1, 32000, N'Trà Dâu')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (91, 25, N'TEA05', 1, 25000, N'Trà Đào Hạt Chia')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (92, 25, N'PASTRY02', 1, 29000, N'Mousse Đào')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (93, 25, N'PASTRY05', 1, 25000, N'Phô Mai Cà Phê')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (94, 25, N'TEA03', 1, 32000, N'Trà Dâu')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (95, 26, N'PASTRY03', 1, 29000, N'Mousse Cacao')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (96, 26, N'CF01', 1, 20000, N'PHIN Đen Đá')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (97, 26, N'BREAD01', 1, 18000, N'Bánh Mì Pate Thịt Nguội')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (98, 26, N'CF01', 1, 20000, N'PHIN Đen Đá')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (99, 26, N'ECF03', 1, 55000, N'Mocha')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (100, 27, N'TEA05', 1, 25000, N'Trà Đào Hạt Chia')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (101, 27, N'TEA01', 1, 30000, N'Trà Sen Vàng')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (102, 27, N'PASTRY03', 1, 29000, N'Mousse Cacao')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (103, 27, N'TEA02', 1, 25000, N'Trà Thạch Đào')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (104, 27, N'CF01', 1, 20000, N'PHIN Đen Đá')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (105, 27, N'BREAD02', 1, 18000, N'Bánh Mì Thịt Nướng')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (106, 27, N'BREAD04', 1, 16000, N'Bánh Mì Xíu Mại')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (107, 28, N'Drink01', 1, 39000, N'Chanh Đá Xay')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (108, 28, N'BREAD03', 1, 15000, N'Bánh Mì Que')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (109, 28, N'TEA01', 1, 30000, N'Trà Sen Vàng')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (110, 28, N'PASTRY01', 1, 18000, N'Bánh Táo')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (111, 29, N'PASTRY04', 1, 25000, N'Phô Mai Trà Xanh')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (112, 29, N'TEA03', 1, 32000, N'Trà Dâu')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (113, 29, N'BREAD04', 1, 16000, N'Bánh Mì Xíu Mại')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (114, 29, N'BREAD02', 1, 18000, N'Bánh Mì Thịt Nướng')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (115, 30, N'Drink03', 1, 52000, N'Chocolate Đá Xay')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (116, 30, N'CF02', 1, 25000, N'PHIN Sữa Đá')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (117, 30, N'PASTRY05', 1, 25000, N'Phô Mai Cà Phê')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (118, 30, N'BREAD02', 1, 18000, N'Bánh Mì Thịt Nướng')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (119, 31, N'ECF01', 1, 35000, N'Latte')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (120, 31, N'CF03', 1, 22000, N'Bạc Xỉu Đá')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (121, 31, N'BREAD03', 1, 15000, N'Bánh Mì Que')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (122, 32, N'TEA04', 1, 28000, N'Trà Thạch Vải')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (123, 32, N'TEA03', 1, 32000, N'Trà Dâu')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (124, 32, N'ECF02', 1, 50000, N'Cappuccino')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (125, 33, N'PASTRY04', 1, 25000, N'Phô Mai Trà Xanh')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (126, 33, N'ECF02', 1, 50000, N'Cappuccino')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (127, 33, N'TEA04', 1, 28000, N'Trà Thạch Vải')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (128, 33, N'BREAD02', 1, 18000, N'Bánh Mì Thịt Nướng')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (129, 33, N'BREAD01', 1, 18000, N'Bánh Mì Pate Thịt Nguội')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (130, 34, N'BREAD03', 1, 15000, N'Bánh Mì Que')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (131, 34, N'Drink04', 1, 52000, N'Milo Đá Xay')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (132, 34, N'CF01', 1, 20000, N'PHIN Đen Đá')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (133, 34, N'TEA05', 1, 25000, N'Trà Đào Hạt Chia')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (134, 35, N'BREAD04', 1, 16000, N'Bánh Mì Xíu Mại')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (135, 35, N'Drink02', 1, 39000, N'Chanh Dây Đá Viên')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (136, 35, N'TEA05', 1, 25000, N'Trà Đào Hạt Chia')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (137, 35, N'PASTRY06', 1, 25000, N'Phô Mai Caramel')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (138, 36, N'PASTRY02', 1, 29000, N'Mousse Đào')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (139, 36, N'BREAD04', 1, 16000, N'Bánh Mì Xíu Mại')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (140, 36, N'BREAD02', 1, 18000, N'Bánh Mì Thịt Nướng')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (141, 36, N'TEA05', 1, 25000, N'Trà Đào Hạt Chia')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (142, 36, N'TEA03', 1, 32000, N'Trà Dâu')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (143, 37, N'TEA02', 1, 25000, N'Trà Thạch Đào')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (144, 37, N'TEA05', 1, 25000, N'Trà Đào Hạt Chia')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (145, 37, N'ECF02', 1, 50000, N'Cappuccino')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (146, 37, N'PASTRY04', 1, 25000, N'Phô Mai Trà Xanh')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (147, 38, N'CF03', 1, 22000, N'Bạc Xỉu Đá')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (148, 38, N'Drink03', 1, 52000, N'Chocolate Đá Xay')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (149, 38, N'ECF03', 1, 55000, N'Mocha')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (150, 38, N'PASTRY05', 1, 25000, N'Phô Mai Cà Phê')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (151, 39, N'CF01', 1, 20000, N'PHIN Đen Đá')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (152, 39, N'BREAD01', 1, 18000, N'Bánh Mì Pate Thịt Nguội')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (153, 39, N'TEA02', 1, 25000, N'Trà Thạch Đào')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (154, 40, N'PASTRY03', 1, 29000, N'Mousse Cacao')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (155, 40, N'PASTRY02', 1, 29000, N'Mousse Đào')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (156, 40, N'TEA01', 1, 30000, N'Trà Sen Vàng')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (157, 40, N'TEA05', 1, 25000, N'Trà Đào Hạt Chia')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (158, 41, N'BREAD04', 1, 16000, N'Bánh Mì Xíu Mại')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (159, 41, N'Drink03', 1, 52000, N'Chocolate Đá Xay')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (160, 41, N'PASTRY05', 1, 25000, N'Phô Mai Cà Phê')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (161, 41, N'TEA04', 1, 28000, N'Trà Thạch Vải')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (162, 41, N'TEA02', 1, 25000, N'Trà Thạch Đào')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (163, 42, N'Drink04', 1, 52000, N'Milo Đá Xay')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (164, 42, N'TEA02', 1, 25000, N'Trà Thạch Đào')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (165, 42, N'PASTRY05', 1, 25000, N'Phô Mai Cà Phê')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (166, 42, N'TEA05', 1, 25000, N'Trà Đào Hạt Chia')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (167, 43, N'TEA01', 1, 30000, N'Trà Sen Vàng')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (168, 43, N'BREAD02', 1, 18000, N'Bánh Mì Thịt Nướng')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (169, 43, N'BREAD04', 1, 16000, N'Bánh Mì Xíu Mại')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (170, 43, N'Drink02', 1, 39000, N'Chanh Dây Đá Viên')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (171, 44, N'BREAD03', 1, 15000, N'Bánh Mì Que')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (172, 44, N'ECF01', 1, 35000, N'Latte')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (173, 44, N'Drink01', 1, 39000, N'Chanh Đá Xay')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (174, 44, N'TEA03', 1, 32000, N'Trà Dâu')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (175, 45, N'ECF02', 1, 50000, N'Cappuccino')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (176, 45, N'PASTRY03', 1, 29000, N'Mousse Cacao')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (177, 45, N'PASTRY06', 1, 25000, N'Phô Mai Caramel')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (178, 45, N'TEA03', 1, 32000, N'Trà Dâu')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (179, 45, N'PASTRY01', 1, 18000, N'Bánh Táo')

INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (180, 46, N'BREAD04', 1, 16000, N'Bánh Mì Xíu Mại')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (181, 46, N'CF02', 1, 25000, N'PHIN Sữa Đá')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (182, 46, N'CF01', 4, 20000, N'PHIN Đen Đá')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (183, 47, N'TEA02', 1, 25000, N'Trà Thạch Đào')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (184, 47, N'TEA03', 1, 32000, N'Trà Dâu')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (185, 47, N'TEA03', 1, 32000, N'Trà Dâu')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (186, 47, N'TEA03', 1, 32000, N'Trà Dâu')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (187, 47, N'TEA05', 1, 25000, N'Trà Đào Hạt Chia')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (188, 47, N'TEA05', 1, 25000, N'Trà Đào Hạt Chia')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (189, 47, N'TEA05', 1, 25000, N'Trà Đào Hạt Chia')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (190, 47, N'TEA05', 1, 25000, N'Trà Đào Hạt Chia')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (191, 47, N'ECF03', 1, 55000, N'Mocha')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (192, 48, N'CF01', 1, 20000, N'PHIN Đen Đá')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (193, 48, N'CF01', 1, 20000, N'PHIN Đen Đá')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (194, 48, N'Drink03', 1, 52000, N'Chocolate Đá Xay')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (195, 48, N'Drink03', 1, 52000, N'Chocolate Đá Xay')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (196, 48, N'Drink03', 1, 52000, N'Chocolate Đá Xay')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (197, 48, N'Drink03', 1, 52000, N'Chocolate Đá Xay')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (198, 48, N'Drink03', 1, 52000, N'Chocolate Đá Xay')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (199, 48, N'ECF03', 1, 55000, N'Mocha')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (200, 48, N'ECF03', 1, 55000, N'Mocha')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (201, 48, N'ECF03', 1, 55000, N'Mocha')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (202, 48, N'ECF03', 1, 55000, N'Mocha')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (203, 48, N'ECF02', 1, 50000, N'Cappuccino')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (204, 48, N'ECF02', 1, 50000, N'Cappuccino')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (205, 49, N'PASTRY04', 1, 25000, N'Phô Mai Trà Xanh')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (206, 50, N'CF01', 1, 20000, N'PHIN Đen Đá')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (207, 50, N'CF03', 1, 22000, N'Bạc Xỉu Đá')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (208, 50, N'PASTRY03', 1, 29000, N'Mousse Cacao')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (209, 50, N'TEA03', 1, 32000, N'Trà Dâu')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (210, 51, N'PASTRY05', 1, 25000, N'Phô Mai Cà Phê')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (211, 51, N'TEA04', 1, 28000, N'Trà Thạch Vải')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (212, 51, N'TEA03', 3, 32000, N'Trà Dâu')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (213, 52, N'PASTRY01', 1, 18000, N'Bánh Táo')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (214, 52, N'ECF03', 1, 55000, N'Mocha')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (215, 52, N'PASTRY03', 1, 29000, N'Mousse Cacao')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (216, 52, N'PASTRY04', 1, 25000, N'Phô Mai Trà Xanh')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (217, 53, N'PASTRY05', 1, 25000, N'Phô Mai Cà Phê')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (218, 53, N'PASTRY05', 1, 25000, N'Phô Mai Cà Phê')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (219, 53, N'PASTRY06', 1, 25000, N'Phô Mai Caramel')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (220, 53, N'BREAD02', 1, 18000, N'Bánh Mì Thịt Nướng')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (221, 54, N'CF03', 1, 22000, N'Bạc Xỉu Đá')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (222, 54, N'BREAD03', 1, 15000, N'Bánh Mì Que')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (223, 55, N'BREAD02', 1, 18000, N'Bánh Mì Thịt Nướng')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (224, 55, N'BREAD01', 1, 18000, N'Bánh Mì Pate Thịt Nguội')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (225, 55, N'BREAD03', 1, 15000, N'Bánh Mì Que')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (226, 56, N'Drink03', 1, 52000, N'Chocolate Đá Xay')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (227, 56, N'CF02', 1, 25000, N'PHIN Sữa Đá')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (228, 56, N'ECF01', 1, 35000, N'Latte')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (229, 57, N'BREAD04', 1, 16000, N'Bánh Mì Xíu Mại')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (230, 57, N'CF03', 1, 22000, N'Bạc Xỉu Đá')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (231, 57, N'Drink01', 1, 39000, N'Chanh Đá Xay')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (232, 58, N'CF02', 1, 25000, N'PHIN Sữa Đá')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (233, 58, N'BREAD04', 1, 16000, N'Bánh Mì Xíu Mại')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (234, 58, N'BREAD02', 1, 18000, N'Bánh Mì Thịt Nướng')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (235, 58, N'Drink02', 1, 39000, N'Chanh Dây Đá Viên')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (236, 59, N'BREAD01', 1, 18000, N'Bánh Mì Pate Thịt Nguội')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (237, 59, N'BREAD02', 1, 18000, N'Bánh Mì Thịt Nướng')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (238, 59, N'BREAD03', 1, 15000, N'Bánh Mì Que')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (239, 59, N'TEA02', 1, 25000, N'Trà Thạch Đào')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (240, 60, N'PASTRY01', 1, 18000, N'Bánh Táo')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (241, 60, N'TEA05', 1, 25000, N'Trà Đào Hạt Chia')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (242, 60, N'TEA03', 1, 32000, N'Trà Dâu')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (243, 61, N'PASTRY03', 1, 29000, N'Mousse Cacao')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (244, 61, N'PASTRY05', 1, 25000, N'Phô Mai Cà Phê')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (245, 61, N'TEA02', 1, 25000, N'Trà Thạch Đào')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (246, 62, N'PASTRY03', 1, 29000, N'Mousse Cacao')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (247, 62, N'PASTRY03', 1, 29000, N'Mousse Cacao')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (248, 62, N'PASTRY03', 1, 29000, N'Mousse Cacao')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (249, 63, N'TEA01', 1, 30000, N'Trà Sen Vàng')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (250, 65, N'PASTRY01', 1, 18000, N'Bánh Táo')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (251, 65, N'TEA03', 1, 32000, N'Trà Dâu')

INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (252, 66, N'BREAD04', 1, 16000, N'Bánh Mì Xíu Mại')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (253, 66, N'ECF02', 1, 50000, N'Cappuccino')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (254, 67, N'CF02', 1, 25000, N'PHIN Sữa Đá')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (255, 67, N'TEA02', 1, 25000, N'Trà Thạch Đào')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (256, 67, N'ECF03', 1, 55000, N'Mocha')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (257, 78, N'TEA02', 1, 25000, N'Trà Thạch Đào')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (258, 78, N'PASTRY05', 1, 25000, N'Phô Mai Cà Phê')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (259, 78, N'PASTRY03', 1, 29000, N'Mousse Cacao')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (260, 68, N'PASTRY04', 1, 25000, N'Phô Mai Trà Xanh')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (261, 68, N'TEA04', 1, 28000, N'Trà Thạch Vải')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (262, 68, N'CF02', 1, 25000, N'PHIN Sữa Đá')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (263, 68, N'Drink03', 1, 52000, N'Chocolate Đá Xay')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (264, 79, N'CF01', 1, 20000, N'PHIN Đen Đá')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (265, 79, N'ECF02', 1, 50000, N'Cappuccino')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (266, 79, N'BREAD04', 1, 16000, N'Bánh Mì Xíu Mại')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (267, 79, N'TEA01', 1, 30000, N'Trà Sen Vàng')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (268, 69, N'TEA03', 2, 32000, N'Trà Dâu')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (269, 69, N'PASTRY01', 2, 18000, N'Bánh Táo')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (270, 71, N'Drink01', 1, 39000, N'Chanh Đá Xay')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (271, 71, N'Drink01', 1, 39000, N'Chanh Đá Xay')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (272, 71, N'Drink02', 2, 39000, N'Chanh Dây Đá Viên')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (273, 71, N'BREAD04', 2, 16000, N'Bánh Mì Xíu Mại')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (274, 70, N'BREAD01', 3, 18000, N'Bánh Mì Pate Thịt Nguội')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (275, 70, N'TEA05', 2, 25000, N'Trà Đào Hạt Chia')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (276, 70, N'TEA01', 1, 30000, N'Trà Sen Vàng')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (277, 72, N'ECF03', 2, 55000, N'Mocha')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (278, 72, N'PASTRY06', 2, 25000, N'Phô Mai Caramel')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (279, 74, N'Drink03', 3, 52000, N'Chocolate Đá Xay')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (280, 74, N'PASTRY01', 3, 18000, N'Bánh Táo')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (281, 73, N'CF01', 2, 20000, N'PHIN Đen Đá')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (282, 73, N'PASTRY03', 2, 29000, N'Mousse Cacao')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (283, 77, N'PASTRY04', 2, 25000, N'Phô Mai Trà Xanh')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (284, 77, N'PASTRY01', 3, 18000, N'Bánh Táo')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (285, 77, N'CF03', 2, 22000, N'Bạc Xỉu Đá')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (286, 76, N'BREAD02', 3, 18000, N'Bánh Mì Thịt Nướng')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (287, 76, N'Drink03', 3, 52000, N'Chocolate Đá Xay')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (288, 75, N'Drink04', 1, 52000, N'Milo Đá Xay')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (289, 75, N'PASTRY01', 1, 18000, N'Bánh Táo')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (290, 75, N'PASTRY02', 1, 29000, N'Mousse Đào')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (291, 75, N'PASTRY03', 1, 29000, N'Mousse Cacao')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (292, 75, N'PASTRY05', 1, 25000, N'Phô Mai Cà Phê')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (293, 75, N'PASTRY06', 1, 25000, N'Phô Mai Caramel')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (294, 75, N'TEA03', 1, 32000, N'Trà Dâu')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (295, 80, N'Drink02', 1, 39000, N'Chanh Dây Đá Viên')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (296, 80, N'Drink03', 1, 52000, N'Chocolate Đá Xay')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (297, 80, N'BREAD01', 1, 18000, N'Bánh Mì Pate Thịt Nguội')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (298, 80, N'BREAD02', 1, 18000, N'Bánh Mì Thịt Nướng')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (299, 81, N'Drink03', 3, 52000, N'Chocolate Đá Xay')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (300, 81, N'PASTRY01', 3, 18000, N'Bánh Táo')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (301, 82, N'CF02', 1, 25000, N'PHIN Sữa Đá')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (302, 82, N'ECF02', 1, 50000, N'Cappuccino')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (303, 82, N'BREAD03', 1, 15000, N'Bánh Mì Que')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (304, 83, N'Drink04', 1, 52000, N'Milo Đá Xay')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (305, 83, N'CF03', 1, 22000, N'Bạc Xỉu Đá')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (306, 83, N'ECF01', 1, 35000, N'Latte')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (307, 84, N'BREAD03', 1, 15000, N'Bánh Mì Que')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (308, 84, N'ECF01', 1, 35000, N'Latte')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (309, 84, N'CF02', 1, 25000, N'PHIN Sữa Đá')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (310, 85, N'Drink01', 1, 39000, N'Chanh Đá Xay')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (311, 85, N'CF03', 1, 22000, N'Bạc Xỉu Đá')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (312, 85, N'ECF02', 1, 50000, N'Cappuccino')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (313, 86, N'Drink01', 1, 39000, N'Chanh Đá Xay')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (314, 86, N'BREAD02', 1, 18000, N'Bánh Mì Thịt Nướng')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (315, 86, N'TEA04', 1, 28000, N'Trà Thạch Vải')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (316, 87, N'PASTRY03', 1, 29000, N'Mousse Cacao')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (317, 87, N'TEA02', 1, 25000, N'Trà Thạch Đào')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (318, 87, N'PASTRY01', 1, 18000, N'Bánh Táo')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (319, 88, N'PASTRY03', 1, 29000, N'Mousse Cacao')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (320, 88, N'TEA02', 1, 25000, N'Trà Thạch Đào')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (321, 88, N'BREAD03', 1, 15000, N'Bánh Mì Que')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (322, 89, N'CF02', 1, 25000, N'PHIN Sữa Đá')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (323, 89, N'Drink04', 1, 52000, N'Milo Đá Xay')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (324, 89, N'CF01', 1, 20000, N'PHIN Đen Đá')

INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (324, 90, N'BREAD04', 1, 16000, N'Bánh Mì Xíu Mại')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (325, 90, N'CF01', 1, 20000, N'PHIN Đen Đá')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (326, 91, N'Drink03', 1, 52000, N'Chocolate Đá Xay')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (327, 91, N'Drink03', 1, 52000, N'Chocolate Đá Xay')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (328, 91, N'Drink01', 2, 39000, N'Chanh Đá Xay')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (329, 91, N'Drink03', 1, 52000, N'Chocolate Đá Xay')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (330, 91, N'Drink03', 1, 52000, N'Chocolate Đá Xay')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (331, 91, N'Drink03', 1, 52000, N'Chocolate Đá Xay')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (332, 91, N'Drink03', 1, 52000, N'Chocolate Đá Xay')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (333, 91, N'Drink03', 1, 52000, N'Chocolate Đá Xay')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (334, 92, N'BREAD03', 1, 15000, N'Bánh Mì Que')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (335, 92, N'BREAD03', 1, 15000, N'Bánh Mì Que')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (336, 92, N'TEA05', 1, 25000, N'Trà Đào Hạt Chia')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (337, 93, N'CF02', 2, 25000, N'PHIN Sữa Đá')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (338, 93, N'Drink04', 1, 52000, N'Milo Đá Xay')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (339, 93, N'BREAD02', 1, 18000, N'Bánh Mì Thịt Nướng')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (340, 93, N'BREAD03', 1, 15000, N'Bánh Mì Que')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (341, 93, N'ECF02', 1, 50000, N'Cappuccino')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (342, 94, N'Drink02', 2, 39000, N'Chanh Dây Đá Viên')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (343, 94, N'CF02', 2, 25000, N'PHIN Sữa Đá')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (344, 94, N'Drink03', 1, 52000, N'Chocolate Đá Xay')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (345, 94, N'CF03', 1, 22000, N'Bạc Xỉu Đá')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (346, 94, N'TEA03', 1, 32000, N'Trà Dâu')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (347, 94, N'TEA01', 1, 30000, N'Trà Sen Vàng')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (348, 95, N'CF03', 1, 22000, N'Bạc Xỉu Đá')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (349, 95, N'CF01', 1, 20000, N'PHIN Đen Đá')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (350, 96, N'Drink02', 1, 39000, N'Chanh Dây Đá Viên')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (351, 96, N'Drink01', 1, 39000, N'Chanh Đá Xay')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (352, 96, N'ECF01', 1, 35000, N'Latte')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (353, 97, N'CF03', 1, 22000, N'Bạc Xỉu Đá')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (354, 98, N'PASTRY04', 1, 25000, N'Phô Mai Trà Xanh')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (355, 98, N'TEA05', 1, 25000, N'Trà Đào Hạt Chia')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (356, 98, N'TEA04', 1, 28000, N'Trà Thạch Vải')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (357, 98, N'TEA02', 1, 25000, N'Trà Thạch Đào')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (358, 99, N'TEA01', 1, 30000, N'Trà Sen Vàng')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (359, 99, N'PASTRY05', 1, 25000, N'Phô Mai Cà Phê')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (360, 97, N'CF03', 1, 22000, N'Bạc Xỉu Đá')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (361, 97, N'CF02', 1, 25000, N'PHIN Sữa Đá')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (362, 97, N'ECF01', 1, 35000, N'Latte')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (363, 98, N'Drink03', 1, 52000, N'Chocolate Đá Xay')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (364, 98, N'BREAD03', 1, 15000, N'Bánh Mì Que')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (365, 98, N'ECF02', 1, 50000, N'Cappuccino')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (366, 98, N'ECF03', 1, 55000, N'Mocha')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (367, 99, N'TEA02', 1, 25000, N'Trà Thạch Đào')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (368, 99, N'TEA03', 1, 32000, N'Trà Dâu')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (369, 100, N'PASTRY04', 1, 25000, N'Phô Mai Trà Xanh')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (370, 100, N'CF03', 1, 22000, N'Bạc Xỉu Đá')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (371, 101, N'BREAD03', 1, 15000, N'Bánh Mì Que')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (372, 101, N'Drink02', 1, 39000, N'Chanh Dây Đá Viên')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (373, 101, N'ECF01', 1, 35000, N'Latte')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (374, 101, N'CF03', 1, 22000, N'Bạc Xỉu Đá')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (375, 102, N'Drink04', 1, 52000, N'Milo Đá Xay')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (376, 102, N'ECF02', 1, 50000, N'Cappuccino')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (377, 102, N'Drink02', 1, 39000, N'Chanh Dây Đá Viên')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (378, 102, N'PASTRY05', 1, 25000, N'Phô Mai Cà Phê')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (379, 103, N'Drink02', 1, 39000, N'Chanh Dây Đá Viên')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (380, 103, N'ECF02', 1, 50000, N'Cappuccino')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (381, 103, N'CF02', 1, 25000, N'PHIN Sữa Đá')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (382, 103, N'Drink01', 1, 39000, N'Chanh Đá Xay')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (383, 103, N'Drink03', 1, 52000, N'Chocolate Đá Xay')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (384, 104, N'TEA02', 1, 25000, N'Trà Thạch Đào')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (385, 104, N'PASTRY03', 1, 29000, N'Mousse Cacao')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (386, 105, N'TEA01', 1, 30000, N'Trà Sen Vàng')
INSERT [dbo].[HOADONCT] ([MaHDCT], [MaHD], [MaMon], [SoLuong], [DonGia], [TenMon]) VALUES (387, 105, N'PASTRY02', 1, 29000, N'Mousse Đào')
SET IDENTITY_INSERT [dbo].[HOADONCT] OFF


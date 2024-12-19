create database SXHoaThucPham
use SXHoaThucPham

CREATE TABLE PhongBan (
    MAPB INT IDENTITY(1,1) PRIMARY KEY,
    TENPB NVARCHAR(100)
);

CREATE TABLE NhanVien (
	MANV INT IDENTITY(1,1) PRIMARY KEY,
	TENNV NVARCHAR(100),
	DIACHI NVARCHAR(100),
	CHUCVU NVARCHAR(100),
	LUONG FLOAT,
	SDT VARCHAR(10),
	NGAYVAOLAM DATE,
	MAPB INT, 
    FOREIGN KEY (MAPB) REFERENCES PhongBan(MAPB) ON DELETE SET NULL
);


CREATE TABLE KeHoach (
	MAKH INT IDENTITY(1,1) PRIMARY KEY,
	TENKH NVARCHAR(100),
	NGAYBD DATE,
	NGAYKT DATE,
	MANV INT,
	TRANGTHAI NVARCHAR(50),
    FOREIGN KEY (MANV) REFERENCES NhanVien(MANV) 
);


CREATE TABLE NhaCungCap (
    MANCC INT IDENTITY(1,1) PRIMARY KEY,
    TENNCC NVARCHAR(100),
    THONGTINLIENHE NVARCHAR(255),
    DIACHI NVARCHAR(255)
);




CREATE TABLE KiemTraChatLuong (
    MAKT INT IDENTITY(1,1) PRIMARY KEY,
    NgayKTRA DATE,
    KETQUA NVARCHAR(255),
    GHICHU NVARCHAR(255),
);

CREATE TABLE QLNguyenLieu (
	MANL INT  IDENTITY(1,1) PRIMARY KEY,
	LOAINL NVARCHAR(50),
	LUONG FLOAT,
	DONVI VARCHAR(20),
	GIAMOIDONVI FLOAT,
	MANCC INT,
	MAKT INT,
	FOREIGN KEY (MANCC) REFERENCES NhaCungCap(MANCC) ON DELETE SET NULL,
	FOREIGN KEY (MAKT) REFERENCES KiemTraChatLuong(MAKT) ON DELETE SET NULL
);

CREATE TABLE QuyTrinh (
    MAQT INT IDENTITY(1,1) PRIMARY KEY,
    MAKH INT,
    MOTA NVARCHAR(255),
    NGAYBD DATE,
    NGAYKT DATE,
	MANL INT,
	MANV int,
	FOREIGN KEY (MANL) REFERENCES QLNguyenLieu(MANL) ON DELETE CASCADE,
    FOREIGN KEY (MAKH) REFERENCES KeHoach(MAKH) ON DELETE CASCADE,
    FOREIGN KEY (MANV) REFERENCES NhanVien(MANV) ON DELETE CASCADE
);

CREATE TABLE SanPham (
    MASP INT IDENTITY(1,1) PRIMARY KEY,  
    TENSP NVARCHAR(100),         
    GIA FLOAT ,                  
    SOLUONG INT ,              
    NGAYSANXUAT DATE,                     
    HANSD DATE,     
	MAQT INT,
    FOREIGN KEY (MAQT) REFERENCES QuyTrinh(MAQT),
);

CREATE TABLE ThietBi (
    MATB INT IDENTITY(1,1) PRIMARY KEY,
	MANV INT,
    TENTB NVARCHAR(100),
    LOAITB NVARCHAR(100),
    LICHBAOTRI NVARCHAR(255),
    TRANGTHAI NVARCHAR(50),
    NGAYBAOTRITRUOC DATE,
	FOREIGN KEY (MANV) REFERENCES NhanVien(MANV) ON DELETE SET NULL
);

CREATE TABLE NganSach (
    MACP INT IDENTITY(1,1) PRIMARY KEY,
    MAKH INT,
    Type NVARCHAR(100),
    SOLUONG FLOAT,
    NGAYTAO DATE,
    PHEDUYET INT,
    FOREIGN KEY (MAKH) REFERENCES KeHoach(MAKH) ON DELETE CASCADE,
    FOREIGN KEY (PHEDUYET) REFERENCES NhanVien(MANV) ON DELETE SET NULL
);

CREATE TABLE QLRuiRo (
    MARR INT IDENTITY(1,1) PRIMARY KEY,
    MOTA NVARCHAR(255),
    MAKH INT,
    KHANANG NVARCHAR(50),
    ANHHUONG NVARCHAR(50),
    KEHOACHGIAMTHIEU NVARCHAR(255),
    FOREIGN KEY (MAKH) REFERENCES KeHoach(MAKH) ON DELETE CASCADE
);

CREATE TABLE HieuQua (
    MAHQ INT IDENTITY(1,1) PRIMARY KEY,
    MAKH INT,
    MUCTIEU FLOAT,
    SANLUONG FLOAT,
    HIEUSUAT FLOAT,
    NGAYDANHGIA DATE,
    FOREIGN KEY (MAKH) REFERENCES KeHoach(MAKH) ON DELETE CASCADE
);

CREATE TABLE Users (
    UserId INT PRIMARY KEY IDENTITY(1,1), 
    UserName NVARCHAR(50) NOT NULL UNIQUE, 
    Password NVARCHAR(50) NOT NULL, 
    Role NVARCHAR(20) NOT NULL 
);

INSERT INTO Users (UserName, Password, Role)
VALUES 
('admin', 'admin123', 'Admin'),
('manager1', 'manager1', 'Manager'),
('manager2', 'manager2', 'Manager');

INSERT INTO PhongBan (TENPB) VALUES 
(N'Sản xuất'),
(N'Kiểm tra chất lượng'),
(N'Kế hoạch sản xuất'),
(N'Bảo trì thiết bị');

INSERT INTO NhanVien (TENNV, DIACHI , CHUCVU, LUONG, SDT, NGAYVAOLAM, MAPB) VALUES 
(N'Nguyễn Văn An',N'Tân Phú,TPHCM' ,N'Trưởng phòng sản xuất', 20000000, '0914162689', '2021-01-15', 1),
(N'Trần Thị Bình',N'Tân Phú,TPHCM', N'Quản lý sản xuất', 15000000, '0978178764', '2021-02-10', 1),
(N'Phạm Văn Cường',N'Tân Bình,TPHCM', N'Quản lý nhân viên', 15000000, '0979809204', '2021-03-05', 2),
(N'Hoàng Thị Dung',N'Thuận An,Bình Dương', N'Nhân viên bảo trì', 14000000, '0982725726', '2021-04-01', 4),
(N'Lê Thanh Liêm',N'Tân Bình,TPHCM', N'Trưởng phòng kế hoạch', 11000000, '0937303282', '2020-12-10', 3),
(N'Phan Văn Trường',N'Đồng Xoài,Bình Phước', N'Nhân viên kế hoạch', 8000000, '0974131489', '2021-06-15', 3),
(N'Ngô Thị Ngọc',N'Thủ Dầu Một,Bình Dương', N'Nhân viên bảo trì', 7000000, '0984084034', '2021-08-20', 4),
(N'Đoàn Văn Hậu',N'Bình Thạnh,TPHCM', N'Nhân viên sản xuất', 7000000, '0977557349', '2021-09-25', 1),
(N'Lý Thu Trâm',N'Tân Phú,TPHCM', N'Trưởng phòng kiểm tra chất lượng', 22000000, '0976096113', '2020-11-12', 2),
(N'Huỳnh Thủy Tiên',N'Quận 12,TPHCM', N'Nhân viên sản xuất', 15000000, '0912992158', '2021-10-01', 1);

INSERT INTO KeHoach (TENKH, NGAYBD, NGAYKT, MANV, TRANGTHAI) VALUES 
(N'Sản xuất hương liệu trái cây', '2023-01-01', '2023-12-31', 2, N'Đang tiến hành'),
(N'Sản xuất hương liệu thực phẩm tự nhiên', '2023-02-01', '2023-11-30', 2, N'Đang tiến hành'),
(N'Nghiên cứu hương liệu mới', '2023-03-01', '2023-12-15', 1, N'Chưa bắt đầu'),
(N'Sản xuất hương liệu tổng hợp', '2023-04-01', '2023-10-31', 3, N'Đang tiến hành'),
(N'Khảo sát thị trường cho hương liệu mới', '2023-05-01', '2023-09-30', 6, N'Đang tiến hành'),
(N'Triển khai kế hoạch tiếp thị hương liệu', '2023-06-01', '2023-12-01', 6, N'Chưa bắt đầu'),
(N'Phân tích hiệu quả sản xuất hương liệu', '2023-07-01', '2023-12-30', 9, N'Đang tiến hành'),
(N'Thu thập phản hồi từ khách hàng', '2023-08-01', '2023-12-31', 5, N'Đang tiến hành'),
(N'Đánh giá quy trình sản xuất', '2023-09-01', '2023-12-15', 1, N'Chưa bắt đầu'),
(N'Marketting cho sản phẩm', '2023-10-01', '2023-11-30', 5, N'Đang tiến hành');

INSERT INTO NhaCungCap (TENNCC, THONGTINLIENHE, DIACHI) VALUES
(N'Fufeng Group', N'0933102662', N'Tế Nam ,huyện Sơn Đông,Trung Quốc'),
(N'KonSon Konjac', N'0961231599', N'huyện Huarong, thành phố Ngạc Châu, tỉnh Hồ Bắc,Trung Quốc'),
(N'Công Ty Deosen', N'0936440298', N'Khu công nghiệp Sanshangliang, Dalate, Ordos, Nội Mông, Trung Quốc'),
(N'Công ty ZhenPai', N'0596855989', N'Đường Puhui, Quận Song Giang, Thượng Hải,Trung Quốc'),
(N'Công Ty Yongsan Chemicals', N'0935234567', N'Hangang-daero, Yongsan-gu, Seoul,Hàn Quốc'),
(N'Công ty LBG Sicilia', N'0983123128', N'97100 Ragusa,thành phố Ragusa, Italy'),
(N'Công ty AHJ Sweet ', N'0963532339', N'85/37 Hồ Văn Long, KP3,Tân Tạo, Bình Tân,TP.Hồ Chí Minh'),
(N'Công ty Kalisel', N'0913915533', N'172 Khu Giãn Dân X2A, Yên Sở, Hoàng Mai, Hà Nội'),
(N'Công ty Ajinomoto', N'0934234567',N'Nguyễn Thị Minh Khai - Quận 3 - TP. Hồ Chí Minh'),
(N'Công Ty ADM', N'0934034268',N'65 Lê Lợi, Phường Bến Nghé, Quận 1, TP.Hồ Chí Minh.');

INSERT INTO QLNguyenLieu (LOAINL, LUONG, DONVI, GIAMOIDONVI, MANCC, MAKT) VALUES 
(N'Gelatine', 1000, 'kg', 50, 1, 1),
(N'Xanthan gum ', 500, 'lit', 30000.0, 2, 2),
(N'Lecithin', 200, N'kg', 400000.0, 9, 4),
(N'Konjac gum', 250, N'kg', 350000.0, 7, 2),
(N'Sodium Alginate', 150, N'kg', 15000.0, 4, 3),
(N'Bột carob', 100, N'kg', 180000.0,3, 8),
(N'Carrageenan', 120, N'kg', 320000.0, 6, 4),
(N'Chất bảo quản', 80, N'kg', 600000.0, 9, 7),
(N'Chất tạo màu', 60, N'kg', 500000.0, 9,10),
(N'Chất tạo hương', 135, N'kg', 200000.0, 10, 10);


INSERT INTO QuyTrinh (MAKH, MOTA, NGAYBD, NGAYKT, MANL, MANV) VALUES 
(1, N'Quy trình sản xuất sương sáo', '2021-05-01', '2021-09-01', 11, 1),
(2, N'Quy trình sản xuất các loại thạch', '2021-11-01', '2022-01-15', 2, 2),
(3, N'Quy trình kiểm tra thử nghiệm nguyên liệu mới', '2021-11-01', '2022-01-15', 3, 3),
(2, N'Quy trình sản xuất ngũ cốc', '2021-11-01', '2022-01-15', 4, 4),
(2, N'Gia công sản phẩm ', '2021-11-01', '2022-01-15', 5, 5),
(2, N'Quy trình sản xuất thạch', '2021-11-01', '2022-01-15', 6, 4),
(2, N'Gia công sản phẩm ', '2021-11-01', '2022-01-15', 7, 5),
(2, N'Quy trình sản xuất thử nghiệm', '2021-11-01', '2022-01-15', 8, 4),
(2, N'Gia công sản phẩm ', '2021-11-01', '2022-01-15', 9, 10),
(4, N'Đóng gói sản phẩm B', '2024-10-10', '2024-10-15', 10, 3);

INSERT INTO SanPham (TENSP, GIA, SOLUONG, NGAYSANXUAT, HANSD, MAQT)
VALUES 
('Sương sáo Grass Jelly', 1000.0, 500, '2024-01-01', '2025-01-01', 1),
('Thạch dừa', 1500.0, 300, '2024-03-01', '2026-03-01', 2),
('Gạo lật', 2000.0, 400, '2023-05-01', '2024-12-31', 3),
('Ngũ cốc', 1200.0, 150, '2024-06-15', '2025-06-15', 3),
('Ngũ cốc khoai mỡ', 1800.0, 200, '2024-07-01', '2026-07-01', 4),
('Rau câu', 1800.0, 200, '2024-07-01', '2026-07-01', 6);


INSERT INTO KiemTraChatLuong (NgayKTRA, KETQUA, GHICHU) VALUES 
('2021-08-15', N'Đạt yêu cầu', N'Đủ tiêu chuẩn'),
('2022-01-10', N'Chưa đạt', N'Cần kiểm tra lại'),
('2021-08-15', N'Đạt yêu cầu', N'Đủ tiêu chuẩn'),
('2022-01-10', N'Chưa đạt', N'Cần kiểm tra lại'),
('2021-08-15', N'Đạt yêu cầu', N'Đủ tiêu chuẩn'),
('2022-01-10', N'Chưa đạt', N'Cần kiểm tra lại'),
('2021-08-15', N'Đạt yêu cầu', N'Đủ tiêu chuẩn'),
('2022-01-10', N'Chưa đạt', N'Đủ tiêu chuẩn'),
('2022-01-10', N'Chưa đạt', N'Cần kiểm tra lại'),
('2022-01-10', N'Chưa đạt', N'Cần kiểm tra lại');

INSERT INTO ThietBi (MANV, TENTB, LOAITB, LICHBAOTRI, TRANGTHAI, NGAYBAOTRITRUOC) VALUES 
(4, N'Máy đóng hộp', N'Bảo trì định kỳ', N'Mỗi 3 tháng', N'Hoạt động', '2022-01-01'),
(4, N'Thiết bị gia công', N'Bảo trì đột xuất', N'Khi cần', N'Hoạt động', '2021-12-10'),
(1, N'Máy chiết rót tự động', N'Thiết bị đóng gói', N'3 tháng/lần', N'Hoạt động', '2024-07-01'),
(10, N'Tủ cấp đông nhanh', N'Thiết bị làm lạnh', N'6 tháng/lần', N'Hoạt động', '2024-04-22'),
(3, N'Máy lọc nước RO', N'Thiết bị xử lý nước', N'12 tháng/lần', N'Hoạt động', '2024-08-30'),
(1, N'Máy đóng gói chân không', N'Thiết bị đóng gói', N'9 tháng/lần', N'Hoạt động', '2023-11-12'),
(5, N'Băng tải vận chuyển', N'Thiết bị vận chuyển', N'6 tháng/lần', N'Hoạt động', '2024-03-20'),
(7, N'Máy phân loại sản phẩm', N'Máy móc sản xuất', N'4 tháng/lần', N'Hoạt động', '2024-06-10'),
(6, N'Bồn chứa nguyên liệu', N'Thiết bị chứa', N'8 tháng/lần', N'Hoạt động', '2024-02-14'),
(9, N'Quạt thông gió công nghiệp', N'Thiết bị phụ trợ', N'12 tháng/lần', N'Hoạt động', '2023-10-05');

INSERT INTO NganSach (MAKH, Type, SOLUONG, NGAYTAO, PHEDUYET) VALUES
(1, N'Nguyên liệu', 5000, '2024-01-15', 1),
(2, N'Nhân công', 2000, '2024-01-20', 1),
(3, N'Bảo trì máy móc', 1500, '2024-02-01', 7),
(4, N'Chi phí vận chuyển', 3000, '2024-02-05', 6),
(5, N'Mua thiết bị mới', 10000, '2024-02-10', 5),
(6, N'Đào tạo nhân viên', 2000, '2024-02-15', 3),
(7, N'Nghiên cứu và phát triển', 5000, '2024-03-01', 1),
(8, N'Chi phí bảo hiểm', 1000, '2024-03-05', 3),
(9, N'Nguyên liệu', 7000, '2024-03-10', 2),
(10, N'Chi phí marketing', 3000, '2024-03-15', 10);

INSERT INTO QLRuiRo (MOTA, MAKH, KHANANG, ANHHUONG, KEHOACHGIAMTHIEU) VALUES 
(N'Sự cố về nguyên liệu', 1, N'Cao', N'Làm chậm tiến độ', N'Dự phòng thêm nhiên liệu'),
(N'Sự cố thiết bị', 2, N'Thấp', N'Ảnh hưởng không đáng kể', N'Sẵn sàng thiết bị thay thế'),
(N'Chất lượng nguyên liệu kém',3, N'Thấp', N'Trung bình', N'Kiểm tra chất lượng nguyên liệu trước khi nhập kho'),
(N'Thiếu nhân lực trong kỳ cao điểm', 4, N'Cao', N'Cao', N'Thuê thêm lao động thời vụ, tăng ca cho nhân viên'),
(N'Biến động giá nguyên liệu', 5, N'Trung bình', N'Cao', N'Ký hợp đồng dài hạn với nhà cung cấp'),
(N'Sự cố an toàn thực phẩm', 6, N'Thấp', N'Rất cao', N'Tuân thủ quy định vệ sinh an toàn thực phẩm, kiểm tra định kỳ'),
(N'Thời tiết bất lợi ảnh hưởng đến vận chuyển', 7, N'Trung bình', N'Trung bình', N'Ký hợp đồng với nhiều đối tác vận chuyển'),
(N'Nhu cầu thị trường không ổn định', 8, N'Cao', N'Trung bình', N'Dự đoán nhu cầu chính xác hơn, điều chỉnh kế hoạch sản xuất linh hoạt'),
(N'Hết hạn giấy phép sản xuất', 9, N'Thấp', N'Cao', N'Theo dõi thời hạn giấy phép và làm mới đúng hạn');

INSERT INTO HieuQua (MAKH, MUCTIEU, SANLUONG, HIEUSUAT, NGAYDANHGIA) VALUES 
(1, 5000, 4800, 96.00, '2021-10-02'),
(2, 2000, 1800, 90.00, '2022-02-02'),
(3, 4500, 4200, 93.33, '2024-12-31'),
(4, 10000, 9500, 95.0, '2025-02-15'),
(5, 8000, 7900, 98.75, '2024-08-31'),
(6, 4000, 3900, 97.5, '2024-09-30'),
(7, 1500, 1400, 93.33, '2024-10-20'),
(8, 3500, 3450, 98.57, '2024-07-31'),
(9, 7000, 6800, 97.14, '2025-01-15'),
(10, 5000, 4800, 96.0, '2025-01-31');




select * from QLNguyenLieu
select * from Users
select * from PhongBan
select * from NhanVien
select * from KeHoach 
select * from NhaCungCap
select * from QuyTrinh
select * from ThietBi
select * from NganSach
select * from QLRuiRo
select * from HieuQua
select * from KiemTraChatLuong

SELECT *
FROM INFORMATION_SCHEMA.TABLES 
WHERE TABLE_TYPE = 'BASE TABLE';


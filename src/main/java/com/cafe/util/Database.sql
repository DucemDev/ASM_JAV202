USE master
GO


ALTER DATABASE PolyCafe_JAV202
    SET SINGLE_USER
    WITH ROLLBACK IMMEDIATE
GO

DROP DATABASE PolyCafe_JAV202
GO

CREATE DATABASE PolyCafe_JAV202
GO

USE PolyCafe_JAV202
GO


/* =========================
   CATEGORIES
========================= */
CREATE TABLE categories (
                            id INT PRIMARY KEY IDENTITY,
                            name NVARCHAR(250) NOT NULL,
                            active BIT DEFAULT 1
)


/* =========================
   DRINKS
========================= */
CREATE TABLE drinks (
                        id INT PRIMARY KEY IDENTITY,
                        category_id INT NOT NULL,
                        name NVARCHAR(250) NOT NULL,
                        price INT NOT NULL,
                        image NVARCHAR(250),
                        description NVARCHAR(MAX),
                        active BIT DEFAULT 1,

                        FOREIGN KEY (category_id) REFERENCES categories(id)
)


/* =========================
   TABLES (BÀN)
========================= */
CREATE TABLE tables (
                        id INT PRIMARY KEY IDENTITY,
                        name NVARCHAR(50) NOT NULL,
                        status VARCHAR(20), -- empty / using
                        active BIT DEFAULT 1
)


/* =========================
   USERS (NHÂN VIÊN)
========================= */
CREATE TABLE users (
                       id INT PRIMARY KEY IDENTITY,
                       email VARCHAR(100) NOT NULL UNIQUE,
                       password VARCHAR(255) NOT NULL,
                       full_name NVARCHAR(60),
                       phone VARCHAR(10),
                       role INT NOT NULL DEFAULT 0, /* 0=customer,1=staff,2=admin*/
                       active BIT DEFAULT 1
)


/* =========================
   BILLS (HÓA ĐƠN)
========================= */


CREATE TABLE bills (
                       id INT PRIMARY KEY IDENTITY,
                       table_id INT NULL,
                       user_id INT NULL,
                       code VARCHAR(10) NOT NULL,
                       created_at DATETIME DEFAULT GETDATE(),
                       total INT,
                       status VARCHAR(20),
                       type VARCHAR(20) DEFAULT 'pos',
                       customer_name NVARCHAR(100),
                       customer_phone VARCHAR(10),
                       address NVARCHAR(255),
                       note NVARCHAR(255),
                       FOREIGN KEY (table_id) REFERENCES tables(id),
                       FOREIGN KEY (user_id) REFERENCES users(id)
)


/* =========================
   BILL DETAILS
========================= */
CREATE TABLE bill_details (
                              id INT PRIMARY KEY IDENTITY,
                              bill_id INT NOT NULL,
                              drink_id INT NOT NULL,
                              quantity INT,
                              price INT,
                              FOREIGN KEY (bill_id) REFERENCES bills(id),
                              FOREIGN KEY (drink_id) REFERENCES drinks(id)
)



/* =========================
   INSERT CATEGORIES
========================= */
    INSERT INTO categories (name) VALUES
                                  (N'Cà phê'),
                                  (N'Trà sữa'),
                                  (N'Nước ép'),
                                  (N'Sinh tố')



/* =========================
   INSERT DRINKS
========================= */
INSERT INTO drinks (category_id, name, price, image, description) VALUES
                                                                      (1, N'Cà phê đen', 20000, 'cf_den.jpg', N'Cà phê đen truyền thống'),
                                                                      (1, N'Cà phê sữa', 25000, 'cf_sua.jpg', N'Cà phê sữa đá'),
                                                                      (1, N'Bạc xỉu', 30000, 'bacxiu.jpg', N'Bạc xỉu ngọt béo'),

                                                                      (2, N'Trà sữa trân châu', 35000, 'ts_tc.jpg', N'Trà sữa truyền thống'),
                                                                      (2, N'Trà sữa matcha', 38000, 'ts_matcha.jpg', N'Trà sữa matcha Nhật'),

                                                                      (3, N'Nước ép cam', 30000, 'cam.jpg', N'Nước ép cam tươi'),
                                                                      (3, N'Nước ép dưa hấu', 28000, 'duahau.jpg', N'Nước ép dưa hấu mát lạnh'),

                                                                      (4, N'Sinh tố bơ', 35000, 'bo.jpg', N'Sinh tố bơ béo ngậy'),
                                                                      (4, N'Sinh tố dâu', 33000, 'dau.jpg', N'Sinh tố dâu tươi')



/* =========================
   INSERT TABLES
========================= */
INSERT INTO tables (name,  status) VALUES
                                       (N'Bàn 1',  'empty'),
                                       (N'Bàn 2',  'empty'),
                                       (N'Bàn 3',  'empty'),
                                       (N'Bàn 4',  'empty'),
                                       (N'Bàn 5',  'empty')



/* =========================
   INSERT USERS
========================= */
INSERT INTO users (email, password, full_name, phone, role) VALUES
                                                                ('anhhldts02418@gmail.com', '123', N'Huỳnh Lê Đức Anh', '0813716449', 2),
                                                                ('truongmk@gmail.com', '123', N'Mai Phiến Chi', '0908070605', 2),
                                                                ('ngoctm@gmail.com', '123', N'Trần Mỹ Ngọc', '0900000003', 1),
                                                                ('halvt@gmail.com', '123', N'Lê Thanh Vân Hà', '0908070876', 2),
                                                                ('anhct@gmail.com', '123', N'Chế Trâm Anh', '0908070986', 1),
                                                                ('thangtv@gmail.com', '123', N'Trần Việt Thắng', '0918970605', 0)



/* =========================
   INSERT BILLS
========================= */
INSERT INTO bills (table_id, user_id, code, total, status) VALUES
                                                               (1, 2, 'B001', 70000, 'finish'),
                                                               (2, 2, 'B002', 55000, 'finish'),
                                                               (3, 3, 'B003', 90000, 'finish'),
                                                               (4, 3, 'B004', 30000, 'waiting')



/* =========================
   INSERT BILL DETAILS
========================= */
INSERT INTO bill_details (bill_id, drink_id, quantity, price) VALUES
                                                                  (1, 1, 2, 20000),
                                                                  (1, 2, 1, 25000),

                                                                  (2, 3, 1, 30000),
                                                                  (2, 4, 1, 35000),

                                                                  (3, 4, 2, 35000),
                                                                  (3, 5, 1, 38000),

                                                                  (4, 6, 1, 30000)



/* =========================
   TEST SELECT
========================= */

SELECT * FROM categories
SELECT * FROM drinks
SELECT * FROM tables
SELECT * FROM users
SELECT * FROM bills
SELECT * FROM bill_details




drop database if exists MobileStore;
CREATE DATABASE MobileStore;
USE MobileStore;

CREATE TABLE Brand (
    brand_id INT AUTO_INCREMENT PRIMARY KEY,
    brand_name VARCHAR(100) NOT NULL UNIQUE,
    country VARCHAR(100),
    image_url VARCHAR(255),
    website VARCHAR(255)
);
INSERT INTO Brand (brand_name, country, website, image_url) VALUES
('Apple', 'USA', 'https://www.apple.com', 'https://cdn.tgdd.vn/Files/2023/08/21/1543753/appleinsidercopy-210823-160539.jpg'),
('Samsung', 'South Korea', 'https://www.samsung.com','https://images.samsung.com/is/image/samsung/assets/vn/about-us/brand/logo/mo/360_197_1.png?$720_N_PNG$'),
('Xiaomi', 'China', 'https://www.mi.com','https://1000logos.net/wp-content/uploads/2018/10/Xiaomi-Logo-2019.png');

CREATE TABLE Category (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL,
    description TEXT
);
INSERT INTO Category (category_name, description) VALUES
('Điện thoại thông minh', 'Các dòng smartphone từ nhiều thương hiệu khác nhau'),
('Máy tính bảng', 'Tablet phục vụ nhu cầu học tập và giải trí'),
('Phụ kiện', 'Tai nghe, sạc, ốp lưng, cáp kết nối...'),
('Đồng hồ thông minh', 'Smartwatch hỗ trợ theo dõi sức khỏe và kết nối di động');


CREATE TABLE Product (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(200) NOT NULL,
    brand_id int,
    description TEXT,
    price DECIMAL(10,2),
    stock_quantity INT,
    category_id INT,
    image_url VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES Categories(category_id),
    FOREIGN KEY (brand_id) REFERENCES Brands(brand_id)
);
INSERT INTO Product (product_name, description, price, stock_quantity, category_id, image_url, brand_id) VALUES
-- Smartphone
('iPhone 14 Pro Max 128GB', 'iPhone 14 Pro Max với chip A16 Bionic, màn hình Super Retina XDR', 32990000, 50, 1, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/i/p/iphone-14-pro-max-256gb.png', 1),
('Samsung Galaxy S23 Ultra', 'Flagship của Samsung với camera 200MP và S-Pen', 29990000, 40, 1, 'https://azmobile.net/files/product/2025/01/18/678b63651943a.jpg', 2),
('Xiaomi 13T Pro', 'Điện thoại cao cấp với chip Snapdragon 8 Gen 2', 17990000, 60, 1, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRAsOw4HYa6BDM7c7_OEA43LUWrCI4B7JgtXQ&s', 3),

-- Máy tính bảng
('iPad Pro 11 inch (M2)', 'Tablet cao cấp chạy chip M2, hỗ trợ Apple Pencil 2', 25990000, 30, 2, 'https://product.hstatic.net/200000275073/product/1715087752_1826704_432a7ffe208c464a9e8a2df13618ed61_large.jpg', 1),
('Samsung Galaxy Tab S9', 'Máy tính bảng Android hiệu năng cao, màn hình AMOLED', 18990000, 25, 2, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR8YgcUOifSWRbluMGqlFPzP_AZ7HIg8HOqQw&s', 2),

-- Phụ kiện
('AirPods Pro 2', 'Tai nghe chống ồn chủ động, chip H2 mới nhất', 5990000, 100, 3, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRs2XoDERwsBuV_mFYrjIaHR2jxQb5pO1RgrQ&s', 1),
('Sạc nhanh 45W Samsung', 'Sạc nhanh cho điện thoại và máy tính bảng Samsung', 850000, 200, 3, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTsin4HvWkU2kh3pJ70tS1rbB44YPzRpqvl6w&s', 2),

-- Đồng hồ thông minh
('Apple Watch Series 9', 'Smartwatch cao cấp với tính năng đo điện tâm đồ, SPO2', 11990000, 35, 4, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRzqK7AR-y1DArmdxqsuELok6tM39tfpdjKKQ&s', 1),
('Xiaomi Watch S1 Active', 'Đồng hồ thông minh giá tốt, nhiều tính năng thể thao', 3490000, 80, 4, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRQeLYIGihzbT3AXYnOidRHuRELa_t78rOUbA&s', 3);

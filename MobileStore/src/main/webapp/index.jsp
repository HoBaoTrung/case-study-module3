<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Mobile Store</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <!-- Font Awesome (icon đẹp) -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            padding-top: 70px;
        }

        footer {
            background-color: #f8f9fa;
            padding: 30px 0;
            margin-top: 50px;
        }
    </style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
    <div class="container">
        <a class="navbar-brand" href="#">MobileStore</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                data-bs-target="#navbarNav" aria-controls="navbarNav"
                aria-expanded="false" aria-label="Chuyển đổi điều hướng">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item"><a class="nav-link active" href="index.jsp">Trang chủ</a></li>
                <li class="nav-item"><a class="nav-link" href="products.jsp">Sản phẩm</a></li>
                <li class="nav-item"><a class="nav-link" href="cart.jsp"><i class="fa fa-shopping-cart"></i> Giỏ
                    hàng</a></li>
                <li class="nav-item"><a class="nav-link" href="login.jsp">Đăng nhập</a></li>
            </ul>
        </div>
    </div>
</nav>

<!-- Nội dung chính -->
<div class="container">
    <div class="row">
        <!-- Phần chính sẽ thay đổi tùy trang -->
        <div class="col-12">
            <h1 class="mt-4 mb-4">Chào mừng đến với MobileStore</h1>

            <!-- Bạn có thể thay bằng include file ở đây -->
            <p>Trang web bán thiết bị di động với nhiều sản phẩm hấp dẫn!</p>
        </div>
    </div>
</div>

<!-- Footer -->
<footer class="text-center">
    <div class="container">
        <p>&copy; 2025 MobileStore. All rights reserved.</p>
        <p>
            <a href="#"><i class="fab fa-facebook me-2"></i></a>
            <a href="#"><i class="fab fa-instagram me-2"></i></a>
            <a href="#"><i class="fab fa-twitter"></i></a>
        </p>
    </div>
</footer>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
        crossorigin="anonymous"></script>
</body>
</html>

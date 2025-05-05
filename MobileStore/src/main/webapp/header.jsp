<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>Mobile Store</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
  <style>
    body { padding-top: 70px; }
    footer { background-color: #f8f9fa; padding: 30px 0; margin-top: 50px; }
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
      <!-- Danh sách các mục căn trái -->
      <ul class="navbar-nav me-auto">
        <li class="nav-item"><a class="nav-link active" href="index.jsp?page=home">Trang chủ</a></li>
        <li class="nav-item"><a class="nav-link" href="index.jsp?page=products">Sản phẩm</a></li>
        <li class="nav-item"><a class="nav-link" href="index.jsp?page=cart"><i class="fa fa-shopping-cart"></i> Giỏ hàng</a></li>
      </ul>
      <!-- Danh sách các mục căn phải -->
      <ul class="navbar-nav ms-auto">
        <li class="nav-item"><a class="nav-link" href="index.jsp?page=login">Đăng nhập</a></li>
      </ul>
    </div>
  </div>
</nav>
<div class="container">
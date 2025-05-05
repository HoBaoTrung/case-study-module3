<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    <style>
        body {
            margin-top: 50px;
            padding: 20px;
            padding-top: 70px;
            background-color: #f5f5f5;
        }

        footer {
            background-color: #f8f9fa;
            padding: 30px 0;
            margin-top: 50px;
        }

        .product-item {
            margin-bottom: 20px;
            transition: transform 0.3s ease;
            background-color: white;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            height: 100%;
            display: flex;
            flex-direction: column;
        }

        .product-item:hover {
            transform: scale(1.03);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.15);
        }

        .image-container {
            position: relative;
            width: 100%;
            padding-top: 75%; /* 4:3 Aspect Ratio */
            overflow: hidden;
        }

        .product-image {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.3s ease;
        }

        .product-item:hover .gallery-image {
            transform: scale(1.05);
        }

        .gallery-caption h3 {
            margin-bottom: 5px;
            color: #333;
            font-size: 1.1rem;
            font-weight: 600;
        }

        .gallery-caption p {
            color: #666;
            font-size: 0.9rem;
            margin-bottom: 0;
        }

        h1 {
            text-align: center;
            margin-bottom: 30px;
            color: #333;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .range-slider-container {
            width: 100%;
            margin-top: 20px;
        }

        .price-labels {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
        }

        .price-label {
            font-weight: 500;
            color: #495057;
            padding: 5px 10px;
            background: #f8f9fa;
            border-radius: 4px;
        }

        .range-slider {
            position: relative;
            width: 100%;
            height: 6px;
            margin: 25px 0;
        }

        .range-slider input[type="range"] {
            position: absolute;
            width: 100%;
            height: 100%;
            background: none;
            pointer-events: none;
            -webkit-appearance: none;
            z-index: 2;
        }

        .range-slider input[type="range"]::-webkit-slider-thumb {
            pointer-events: auto;
            -webkit-appearance: none;
            width: 24px;
            height: 24px;
            border-radius: 50%;
            background: #0d6efd;
            cursor: pointer;
            border: 3px solid white;
            box-shadow: 0 0 5px rgba(0, 0, 0, 0.2);
            transform: translateY(-50%);
        }

        .range-slider input[type="range"]::-moz-range-thumb {
            pointer-events: auto;
            width: 24px;
            height: 24px;
            border-radius: 50%;
            background: #0d6efd;
            cursor: pointer;
            border: 3px solid white;
            box-shadow: 0 0 5px rgba(0, 0, 0, 0.2);
        }

        .slider-track {
            position: absolute;
            width: 100%;
            height: 100%;
            background: #dee2e6;
            border-radius: 5px;
            z-index: 1;
        }

        /* Tooltip style for labels */
        .min-label::after, .max-label::after {
            content: '';
            position: absolute;
            top: 100%;
            left: 50%;
            transform: translateX(-50%);
            border-width: 5px;
            border-style: solid;
            border-color: #f8f9fa transparent transparent transparent;
        }

        .form-check-label {
            display: flex;
            align-items: center;
            padding: 10px 15px;
            border-radius: 8px;
            transition: all 0.3s;
            cursor: pointer;
        }

        .form-check-input:checked + .form-check-label {
            background-color: #e9f5ff;
            border-left: 4px solid #0d6efd;
        }

        .form-check-input {
            width: 1.2em;
            height: 1.2em;
            margin-right: 10px;
        }

        .small-container {
            border: 1px solid #dee2e6;
            border-radius: 10px;
            padding: 15px;
            max-width: 400px;
            margin: 20px auto;
        }

        .form-check {
            margin-bottom: 8px;
        }

        .form-check:last-child {
            margin-bottom: 0;
        }

        /* Responsive styles */
        @media (max-width: 576px) {
            .col-12 {
                padding-left: 5px;
                padding-right: 5px;
            }

            .gallery-caption h3 {
                font-size: 1rem;
            }

            .gallery-caption p {
                font-size: 0.8rem;
            }
        }
    </style>
</head>

<body>
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
                <li class="nav-item"><a class="nav-link active" href="/">Trang chủ</a></li>
                <li class="nav-item"><a class="nav-link" href="/products">Sản phẩm</a></li>
                <li class="nav-item position-relative">
                    <a class="nav-link" href="/carts">
                        <i class="fa fa-shopping-cart"></i> Giỏ hàng

                    </a>
                </li>
            </ul>
            <!-- Danh sách các mục căn phải -->
            <ul class="navbar-nav ms-auto">
                <li class="nav-item"><a class="nav-link" href="index.jsp?page=login">Đăng nhập</a></li>
            </ul>
        </div>
    </div>
</nav>

<div class="container mt-5">
    <div class="row">

        <!-- Cột lọc sản phẩm bên trái -->
        <div class="col-md-3 mb-4">
            <h2 class="mb-4 text-center">Bộ lọc</h2>
            <div class="card shadow-sm">
                <div class="card-header bg-primary text-white">
                    Bộ lọc
                </div>
                <div class="card-body">
                    <form method="get" action="/products">

                        <div class="mb-3">
                            <label for="keyword" class="form-label">Tìm kiếm</label>
                            <input type="text" class="form-control" id="keyword" name="keyword"
                                   placeholder="Nhập tên sản phẩm..." value="${param.keyword}">
                        </div>

                        <div class="small-container">
                            <h5 class="mb-3">Danh mục:</h5>
                            <c:forEach items="${categories}" var="cate">
                                <c:set var="isCheckedCate" value="" />
                                <c:forEach var="selectedId" items="${paramValues.cateID}">
                                    <c:if test="${selectedId == cate.categoryId}">
                                        <c:set var="isCheckedCate" value="checked" />
                                    </c:if>
                                </c:forEach>

                                <div class="form-check">
                                    <input class="form-check-input"
                                           type="checkbox"
                                           id="${cate.categoryName}"
                                           name="cateID"
                                           value="${cate.categoryId}"
                                           ${isCheckedCate}
                                    >
                                    <label class="form-check-label" for="${cate.categoryName}">${cate.categoryName}</label>
                                </div>
                            </c:forEach>
                        </div>

                        <div class="small-container">
                            <label class="form-label">Chọn khoảng giá:</label>
                            <div class="range-slider-container">
                                <div class="price-labels">
                                    <span class="price-label min-label" id="minPriceLabel">${minPrice}</span>
                                    <span class="price-label max-label" id="maxPriceLabel">${maxPrice}</span>
                                </div>
                                <div class="range-slider">
                                    <input type="range" class="form-range" min="${minPrice}" max="${maxPrice}"
                                           step="10000"
                                           id="minPrice" name="minPrice"
                                           value="${param.minPrice != null ? param.minPrice : minPrice}">

                                    <input type="range" class="form-range" min="${minPrice}" max="${maxPrice}"
                                           step="10000"
                                           id="maxPrice" name="maxPrice"
                                           value="${param.maxPrice != null ? param.maxPrice : maxPrice}">
                                    <div class="slider-track"></div>
                                </div>
                            </div>

                        </div>

                        <div class="small-container">
                            <h5 class="mb-3">Hãng:</h5>
                            <c:forEach items="${brands}" var="brand">

                                <c:set var="isCheckedBrand" value="" />
                                <c:forEach var="selectedId" items="${paramValues.brandID}">
                                    <c:if test="${selectedId == brand.brandId}">
                                        <c:set var="isCheckedBrand" value="checked" />
                                    </c:if>
                                </c:forEach>

                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" id="${brand.brandName}"
                                           name="brandID" value="${brand.brandId}" ${isCheckedBrand}>
                                    <label class="form-check-label"
                                           for="${brand.brandName}">${brand.brandName}</label>
                                </div>
                            </c:forEach>
                        </div>

                        <div class="d-grid">
                            <button type="submit" class="btn btn-primary">Áp dụng</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Cột danh sách sản phẩm bên phải -->
        <div class="col-md-9">
            <h2 class="mb-4 text-center">Danh sách sản phẩm</h2>
            <div class="row row-cols-1 row-cols-md-3 g-4">
                <fmt:setLocale value="vi_VN"/>
                <c:forEach items="${products}" var="p">
                    <div class="col-12 col-sm-6 col-lg-4">
                        <div class="product-item">
                            <div class="card h-100 shadow-sm">
                                <div class="image-container">
                                    <img src="${p.imageUrl}" class="card-img-top product-image" alt="${p.productName}"
                                         onerror="this.src='https://via.placeholder.com/300x200'">
                                </div>
                                <div class="card-body">
                                    <h5 class="card-title">${p.productName}</h5>

                                    <p class="card-text text-danger fw-bold">
                                        <fmt:formatNumber value="${p.price}" type="currency"/>
                                    </p>

                                    <h6 class="text">Số lượng: ${p.stockQuantity}</h6>


                                    <a href="#" class="btn btn-primary w-100 mb-3">Xem chi tiết</a>
                                    <c:if test="${p.stockQuantity > 0}">
                                        <button class="btn btn-danger w-100 add-to-cart" data-id="${p.productId}"
                                                data-name="${p.productName}">
                                            <i class="fa fa-shopping-cart"></i> Thêm vào giỏ
                                        </button>
                                    </c:if>

                                    <c:if test="${p.stockQuantity == 0}">
                                        <h6 class="text-danger text-center">(Hết hàng)</h6>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>


            <c:if test="${totalPages > 0}">
                <nav class="mt-4">
                    <ul class="pagination">

                        <!-- Previous -->
                        <c:url var="prevUrl" value="products">
                            <c:param name="page" value="${currentPage - 1}" />
                            <%@ include file="urlForPage.jsp" %>
                        </c:url>
                        <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                            <a class="page-link" href="${prevUrl}">Previous</a>
                        </li>

                        <!-- Page numbers -->
                        <c:forEach begin="1" end="${totalPages}" var="i">
                            <c:url var="pageUrl" value="products">
                                <c:param name="page" value="${i}" />
                                <%@ include file="urlForPage.jsp" %>
                            </c:url>
                            <li class="page-item ${i == currentPage ? 'active' : ''}">
                                <a class="page-link" href="${pageUrl}">${i}</a>
                            </li>
                        </c:forEach>

                        <!-- Next -->
                        <c:url var="nextUrl" value="products">
                            <c:param name="page" value="${currentPage + 1}" />
                            <%@ include file="urlForPage.jsp" %>
                        </c:url>
                        <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                            <a class="page-link" href="${nextUrl}">Next</a>
                        </li>

                    </ul>
                </nav>
            </c:if>

        </div>
    </div>
</div>

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
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>

<script>

    $(document).ready(function () {
        $('.add-to-cart').click(function () {
            const productId = $(this).data('id');
            const productName = $(this).data('name');
            $.ajax({
                url: '/carts',
                type: 'POST',
                data: {
                    action: 'add',
                    id: productId
                },
                success: function (response) {
                    swal({
                        title: "Thêm thành công",
                        text: productName,
                        icon: "success"
                    });
                },
                error: function () {
                    alert('Thêm thất bại. Vui lòng thử lại.');
                }
            });
        });
    });

    document.addEventListener('DOMContentLoaded', function () {
        // DOM Elements
        const minPrice = document.getElementById('minPrice');
        const maxPrice = document.getElementById('maxPrice');
        const minPriceLabel = document.getElementById('minPriceLabel');
        const maxPriceLabel = document.getElementById('maxPriceLabel');
        const sliderTrack = document.querySelector('.slider-track');

        // Format currency (VND)
        function formatCurrency(value) {
            return parseInt(value).toLocaleString('vi-VN') + '₫';
        }

        // Update slider appearance and labels
        function updateSlider() {
            // Update labels
            minPriceLabel.textContent = formatCurrency(minPrice.value);
            maxPriceLabel.textContent = formatCurrency(maxPrice.value);

            // Calculate percentages
            const minPercent = (minPrice.value / minPrice.max) * 100;
            const maxPercent = (maxPrice.value / maxPrice.max) * 100;

            // Position labels above thumbs
            minPriceLabel.style.left = `calc(${minPercent}% - 30px)`;
            maxPriceLabel.style.left = `calc(${maxPercent}% - 30px)`;

            // Update track color
            sliderTrack.style.background = `linear-gradient(to right,
            #dee2e6 ${minPercent}%,
            #0d6efd ${minPercent}%,
            #0d6efd ${maxPercent}%,
            #dee2e6 ${maxPercent}%)`;
        }

        // Event listeners
        minPrice.addEventListener('input', function () {
            if (parseInt(minPrice.value) > parseInt(maxPrice.value)) {
                minPrice.value = maxPrice.value;
            }
            updateSlider();
        });

        maxPrice.addEventListener('input', function () {
            if (parseInt(maxPrice.value) < parseInt(minPrice.value)) {
                maxPrice.value = minPrice.value;
            }
            updateSlider();
        });

        // Initialize slider
        updateSlider();
    });
</script>

</body>
</html>

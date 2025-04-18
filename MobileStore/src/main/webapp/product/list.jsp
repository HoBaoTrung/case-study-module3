<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../index.jsp" %>

<%--<style>--%>
<%--    .product-image {--%>
<%--        width: 100%;--%>
<%--        height: 220px;--%>
<%--        object-fit: cover; /* Cắt ảnh vừa khung */--%>
<%--        border-radius: 0.5rem;--%>
<%--    }--%>
<%--</style>--%>


<style>
    body {
        padding: 20px;
        background-color: #f5f5f5;
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

    .gallery-caption {
        padding: 15px;
        text-align: center;
        flex-grow: 1;
        background-color: white;
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

<body>

<div class="container mt-5">
    <h2 class="mb-4">Danh sách sản phẩm</h2>
    <div class="row row-cols-1 row-cols-md-3 g-4">

        <c:forEach items="${products}" var="p">
            <div class="col-12 col-sm-6 col-lg-3">
                <div class="product-item">
                    <div class="card h-100 shadow-sm">
                        <div class="image-container">
                            <img src="${p.imageUrl}" class="card-img-top product-image" alt="${p.productName}"
                                 onerror="this.src='https://via.placeholder.com/300x200'">
                        </div>
                        <div class="card-body">
                            <h5 class="card-title">${p.productName}
                            </h5>
                            <p class="card-text text-danger fw-bold"> ${p.price} ₫</p>
                            <a href="#"
                               class="btn btn-primary w-100 mb-3">
                                Xem chi tiết
                            </a>
                            <a href="#"
                               class="btn btn-danger w-100">
                                <i class="fa fa-shopping-cart"></i>
                                Thêm vào giỏ
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>

    </div>
</div>
</body>
</html>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Cảm ơn bạn đã mua hàng!</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            padding: 30px;
            text-align: center;
        }

        .invoice {
            background: #fff;
            padding: 20px;
            margin: auto;
            display: inline-block;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            border-radius: 12px;
        }

        .table-container {
            overflow-x: auto;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            border-radius: 10px;
            background: #fff;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            min-width: 600px;
        }

        thead {
            background-color: #0d6efd;
            color: white;
        }

        th, td {
            padding: 12px 16px;
            text-align: left;
            border-bottom: 1px solid #dee2e6;
        }

        tr:hover {
            background-color: #f1f3f5;
        }

        th:first-child, td:first-child {
            border-top-left-radius: 10px;
        }

        th:last-child, td:last-child {
            border-top-right-radius: 10px;
        }

        .avatar {
            width: 48px;
            height: 48px;
            object-fit: cover;
            box-shadow: 0 0 4px rgba(0,0,0,0.2);
        }

        @media (max-width: 768px) {
            th, td {
                padding: 10px 12px;
            }
        }

        .total {
            font-weight: bold;
            font-size: 1.2em;
            margin-top: 10px;
        }
    </style>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
</head>
<body>

<div class="invoice">
    <fmt:setLocale value="vi_VN"/>
    <h2>Cảm ơn bạn đã mua hàng!</h2>
    <p><strong>Mã đơn hàng:</strong> ${order.id}</p>
    <p><strong>Khách hàng:</strong> ${customer.customerName}</p>
    <p><strong>Số điện thoại:</strong> ${customer.customerPhone}</p>
    <p><strong>Địa chỉ giao hàng:</strong> ${customer.customerAddress}</p>
    <p><strong>Ngày tạo:</strong> ${createdAt}</p>
    <div class="table-container">
    <table>
        <tr>
            <th>Ảnh</th>
            <th>Sản phẩm</th>
            <th>Số lượng</th>
            <th>Giá</th>
            <th>Thành tiền</th>
        </tr>
        <c:forEach var="item" items="${orderDetailList}">
            <tr>
                <td><img class="avatar" src="${item.getProduct().imageUrl}" /></td>
                <td>${item.getProduct().productName}</td>
                <td>${item.quantity}</td>
                <td><fmt:formatNumber value="${item.getProduct().price}" type="currency"/></td>
                <td><fmt:formatNumber value="${item.getProduct().price * item.quantity}" type="currency"/></td>
            </tr>
        </c:forEach>
    </table>
    </div>
    <p class="total">Tổng cộng: <fmt:formatNumber value="${order.totalPrice}" type="currency"/></p>
    <button class="btn-print btn btn-danger" onclick="window.print()">🖨️ In hóa đơn</button>
    <a href="/products" class="btn-primary btn">Tiếp tục mua sắm</a>
</div>

<!-- Confetti.js -->
<script src="https://cdn.jsdelivr.net/npm/canvas-confetti@1.6.0/dist/confetti.browser.min.js"></script>
<script>
    confetti({
        particleCount: 200,
        spread: 100,
        origin: { y: 0.6 }
    });
</script>

</body>
</html>

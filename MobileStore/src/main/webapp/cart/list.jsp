<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    <meta charset="UTF-8">
    <title>Giỏ hàng của bạn</title>
    <style>
        table {
            border-collapse: collapse;
            margin: 20px auto;
        }

        th, td {
            border: 1px solid #ccc;
            padding: 10px;
            text-align: center;
        }

        th {
            background-color: #f2f2f2;
        }

        .total {
            font-weight: bold;
        }
    </style>
</head>
<body>
<h2 style="text-align:center;">Giỏ hàng của bạn</h2>
<c:if test="${sessionScope.cart.isEmpty()}">
    <p style="text-align:center;">Giỏ hàng đang trống.</p>
</c:if>

<div class="container">
    <a class="btn btn-success" href="/products">Quay lại trang Product</a>

    <table>
        <tr>
            <th></th>
            <th>Tên sản phẩm</th>
            <th>Đơn giá</th>
            <th>Số lượng</th>
            <th>Thành tiền</th>
        </tr>
        <c:set var="totalPrice" value="${0}"/>
        <fmt:setLocale value="vi_VN"/> <!-- Đặt locale cho Việt Nam (VND) -->
        <c:forEach var="item" items="${sessionScope.cart}">
            <tr>
                <td>
                    <img style="width: 70px; height: auto;" src="${item.getProduct().imageUrl}">
                </td>
                <td><p><c:out value="${item.getProduct().getProductName().toString()}"/></p></td>
                <td>
                    <p><fmt:formatNumber value="${item.getProduct().getPrice().toString()}" type="currency"/></p>
                </td>
                <td>

                    <form action="/carts" method="post" style="display: inline-block; width: 30%;">
                        <input type="hidden" name="action" value="update">
                        <input type="hidden" name="type" value="sub">
                        <input type="hidden" name="id" value="${item.getProduct().productId}">
                        <button class="btn btn-danger w-100" type="submit">-</button>
                    </form>

                    <input type="number" min="0" id="quantity" name="quantity" disabled
                           value="${item.getQuantity().toString()}"
                           style="width: 30%; text-align: center; display: inline-block;">

                    <form action="/carts" method="post" style="display: inline-block; width: 30%;">
                        <input type="hidden" name="action" value="update">
                        <input type="hidden" name="type" value="add">
                        <input type="hidden" name="id" value="${item.getProduct().productId}">
                        <button class="btn btn-success w-100" type="submit">+</button>
                    </form>

                    <form action="carts" method="post" id="delete">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="id" value="${item.getProduct().getProductId()}">
                        <button data-name="${item.getProduct().getProductName()}" class="btn-delete" type="button">Xóa</button>
                    </form>
                </td>
                <td>
                    <p>
                        <fmt:formatNumber value="${item.getQuantity() * item.getProduct().getPrice()}" type="currency"/>
                    </p>
                </td>
            </tr>
            <c:set var="totalPrice"
                   value="${totalPrice + (item.getQuantity() * item.getProduct().getPrice())}"/>
        </c:forEach>
        <tr>
            <td colspan="4" class="text-end total">Tổng tiền:</td>
            <td><fmt:formatNumber value="${totalPrice}" type="currency"/></td>
        </tr>
        <tr>
            <td colspan="5" class="text-end">
                <a href="/checkout" class="btn btn-success mt-3 me-2">Thanh toán</a>
            </td>
        </tr>
    </table>
</div>

<c:if test="${checkoutError!=null}">
    <script>
        swal("Lỗi", "${checkoutError}", "error");
    </script>
</c:if>

<script>
    $(document).ready(function() {
        $('.btn-delete').click(function (e) {
            e.preventDefault(); // chặn hành động submit mặc định
            const form = $('#delete'); // lấy form theo id
            const productName = $(this).data('name');
            swal({
                title: "Xóa sản phẩm ra khỏi giỏ hàng",
                text: productName,
                icon: "warning",
                buttons: ["Hủy", "Xóa"],
                dangerMode: true,
            }).then((willDelete) => {
                if (willDelete) {
                    form.submit(); // nếu đồng ý thì submit form
                } else {
                    // không làm gì nếu bấm "Hủy"
                }
            });
        });
    });
</script>

</body>
</html>

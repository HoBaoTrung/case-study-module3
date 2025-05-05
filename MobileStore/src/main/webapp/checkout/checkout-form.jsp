<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thông tin giao hàng</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #eef;
            padding: 50px;
        }

        .form-container {
            background-color: white;
            padding: 30px;
            margin: auto;
            width: 400px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.2);
        }

        h2 {
            text-align: center;
        }

        label {
            display: block;
            margin-top: 10px;
        }

        input, select {
            width: 100%;
            padding: 8px;
            margin-top: 5px;
        }

        button {
            margin-top: 20px;
            width: 100%;
            padding: 10px;
            background-color: #28a745;
            color: white;
            border: none;
            border-radius: 5px;
            font-weight: bold;
        }
    </style>
</head>
<body>
<div class="form-container">
    <h2>Thông tin giao hàng</h2>
    <form action="checkout" method="post">
        <label for="customerName">Họ tên:</label>
        <input id="customerName" type="text" name="customerName" required>

        <label for="phone">Số điện thoại:</label>
        <input id="phone" type="text" name="phone" required>

        <label for="address">Địa chỉ:</label>
        <input id="address" type="text" name="address" required>

        <label>Phương thức thanh toán:</label>
        <select name="paymentMethod" required>
            <option value="COD">Thanh toán khi nhận hàng (COD)</option>
            <option value="Momo">Ví MoMo</option>
            <option value="ZaloPay">ZaloPay</option>
            <option value="Banking">Chuyển khoản ngân hàng</option>
        </select>

        <button type="submit">Xác nhận</button>
    </form>
</div>
</body>
</html>

package com.codegym.mobilestore.service;

import com.codegym.mobilestore.model.Item;
import com.codegym.mobilestore.model.Order;
import com.codegym.mobilestore.model.OrderDetail;
import com.codegym.mobilestore.model.Product;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.*;


public class OrderDAO implements GeneralDAO<Order>, ReadAllDAO<Order> {
    CustomerDAO customerDAO = new CustomerDAO();
    ProductDAO productDAO = new ProductDAO();
    public int checkOut(List<Item> cart, Map customer) throws SQLException {
        Connection conn = null;

        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false);

            // Kiểm tra tồn kho
            checkAllProductQuantities(cart, conn);

            // Trừ tồn kho
            updateProductQuantities(cart, conn);

            // Lưu thông tin khách hàng
            int customerID = insertCustomerInfo(customer, conn);

            // Tính tổng tiền
            double totalPrice = calculateTotalPrice(cart);

            // Insert Order và lấy orderId
            int orderId = insertOrder(customerID, totalPrice, (String) customer.get("paymentMethod"),conn);

            // Insert chi tiết đơn hàng
            insertOrderDetails(orderId, cart, conn);

            conn.commit();

            return orderId;

        } catch (SQLException e) {
            if (conn != null) conn.rollback();
            throw e;
        } finally {
            if (conn != null) conn.close();
        }
    }

    private int insertCustomerInfo(Map customer, Connection conn) throws SQLException {
        String query = "{CALL sp_insert_customer_info(?,?,?,?,?)}";
        try (CallableStatement stmt = conn.prepareCall(query)) {
            stmt.setString(1, (String) customer.get("customerName"));
            stmt.setString(2, (String) customer.get("phone"));
            stmt.setString(3, (String) customer.get("address"));
            stmt.setString(4, (String) customer.get("paymentMethod"));
            stmt.registerOutParameter(5, Types.INTEGER);
            stmt.execute();
            return stmt.getInt(5);
        }
    }

    public void checkAllProductQuantities(List<Item> cart, Connection conn) throws SQLException {
        String query = "{CALL sp_check_product_quantity(?,?,?)}";

        for (Item item : cart) {
            try (CallableStatement stmt = conn.prepareCall(query)) {
                stmt.setInt(1, item.getProduct().getProductId());
                stmt.setInt(2, item.getQuantity());
                stmt.registerOutParameter(3, Types.BOOLEAN);

                stmt.execute();
                boolean enough = stmt.getBoolean(3);
                System.out.println(item.getProduct().getStockQuantity());
                if (!enough) {
                    Product p = productDAO.findById(item.getProduct().getProductId());
                    throw new SQLException("'" + item.getProduct().getProductName() + "' chỉ còn " +
                            p.getStockQuantity() + " sản phẩm.");
                }
            }
        }
    }

    private double calculateTotalPrice(List<Item> cart) {
        return cart.stream()
                .mapToDouble(item -> item.getProduct().getPrice() * item.getQuantity())
                .sum();
    }

    private int insertOrder(int customerID, double totalPrice, String paymentMethod,Connection conn) throws SQLException {
        String query = "{CALL sp_insert_orders(?,?,?,?)}";

        try (CallableStatement stmt = conn.prepareCall(query)) {
            stmt.setInt(1, customerID);
            stmt.setDouble(2, totalPrice);
            stmt.setString(3, paymentMethod);
            stmt.registerOutParameter(4, Types.INTEGER);
            stmt.execute();
            return stmt.getInt(4);
        }
    }

    private void insertOrderDetails(int orderId, List<Item> cart, Connection conn) throws SQLException {
        String query = "{CALL sp_insert_order_detail(?,?,?)}";

        try (CallableStatement stmt = conn.prepareCall(query)) {
            for (Item item : cart) {
                stmt.setInt(1, orderId);
                stmt.setInt(2, item.getProduct().getProductId());
                stmt.setInt(3, item.getQuantity());
                stmt.executeUpdate();
            }
        }
    }

    private void updateProductQuantities(List<Item> cart, Connection conn) throws SQLException {
        String query = "{CALL sp_update_product_quantity(?,?)}";

        try (CallableStatement stmt = conn.prepareCall(query)) {
            for (Item item : cart) {
                stmt.setInt(1, item.getProduct().getProductId());
                stmt.setInt(2, item.getQuantity());
                stmt.executeUpdate();
            }
        }
    }

    @Override
    public List<Order> findAll() {
        List<Order> orders = new ArrayList<Order>();
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement("Select * from orders");) {

            ResultSet rs = preparedStatement.executeQuery();

            while (rs.next()) {
                double totalPrice = rs.getDouble("total_price");
                LocalDateTime orderDate = rs.getTimestamp("order_date").toLocalDateTime();
                int customerID = rs.getInt("customer_id");
                int id = rs.getInt("id");
                String paymentMethod = rs.getString("payment_method");
                orders.add(new Order(id, totalPrice, orderDate, paymentMethod,customerDAO.findById(customerID)));
            }
            rs.close();
        } catch (SQLException e) {
            DBConnection.printSQLException(e);
        }
        return orders;
    }

    @Override
    public List<Order> findAllWithStoreProcedure() {
        return Collections.emptyList();
    }

    @Override
    public Order findById(int id) {
        Order order = null;
        String sql = "SELECT * FROM orders WHERE id = ?";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql);) {
            preparedStatement.setInt(1, id);
            ResultSet rs = preparedStatement.executeQuery();

            while (rs.next()) {
                double totalPrice = rs.getDouble("total_price");
                System.out.println(rs.getTimestamp("order_date"));
                LocalDateTime orderDate = rs.getTimestamp("order_date").toLocalDateTime();
                int customerID = rs.getInt("customer_id");
                String paymentMethod = rs.getString("payment_method");
                order = new Order(id, totalPrice, orderDate, paymentMethod,customerDAO.findById(customerID));
            }
            rs.close();
        } catch (SQLException e) {
            DBConnection.printSQLException(e);
        }
        return order;
    }

    public List<OrderDetail> getOrderDetails(int orderId) {
        List<OrderDetail> list = new ArrayList<>();
        String sql = "{call sp_get_order_detail(?)}";

        try (Connection connection = DBConnection.getConnection();
                CallableStatement ps = connection.prepareCall(sql)) {
            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Product product = productDAO.findById(rs.getInt("product_id"));

                OrderDetail detail = new OrderDetail();
                detail.setQuantity(rs.getInt("quantity"));
                detail.setProduct(product);
                detail.setOrder(findById(rs.getInt("order_id")));

                list.add(detail);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}

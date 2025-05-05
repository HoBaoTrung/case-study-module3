package com.codegym.mobilestore.service;

import com.codegym.mobilestore.model.Product;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ProductDAO implements GeneralDAO<Product>, PageableDAO<Product> {

    private static final String SELECT_ALL_PRODUCT = "SELECT * FROM Product LIMIT ?, ?";
    private static final String COUNT_PRODUCT = "SELECT COUNT(*) FROM product";
    private static final String SELECT_PRODUCT_BY_ID = "SELECT * FROM Product WHERE product_id = ?";
    private static final String SELECT_RANGE_PRICE = "SELECT MIN(price) as 'min', MAX(price) as 'max' FROM Product";

    private void addProductToList(ResultSet resultSet, List<Product> products) throws SQLException {
        Product product = new Product();
        product.setProductId(resultSet.getInt("product_id"));
        product.setProductName(resultSet.getString("product_name"));
        product.setDescription(resultSet.getString("description"));
        product.setPrice(resultSet.getDouble("price"));
        product.setStockQuantity(resultSet.getInt("stock_quantity"));
        product.setImageUrl(resultSet.getString("image_url"));
        products.add(product);
    }

    @Override
    public Product findById(int id) {
        Product product = null;
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_PRODUCT_BY_ID)) {
            preparedStatement.setInt(1, id);
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                String name = rs.getString("product_name");
                double price = rs.getDouble("price");
                String imageUrl = rs.getString("image_url");
                String description = rs.getString("description");
                int stockQuantity = rs.getInt("stock_quantity");
                product = new Product();
                product.setProductId(id);
                product.setProductName(name);
                product.setDescription(description);
                product.setPrice(price);
                product.setImageUrl(imageUrl);
                product.setStockQuantity(stockQuantity);
            }
            rs.close();
        } catch (SQLException e) {
            DBConnection.printSQLException(e);
        }
        return product;
    }

    public Map searchProduct(Map filters) {
        String query = "{CALL sp_search_products(?,?,?,?,?,?,?)}";
        List<Product> products = new ArrayList<Product>();
        int total = 0;

        try (Connection connection = DBConnection.getConnection();
             CallableStatement callableStatement = connection.prepareCall(query);) {

            // Lấy tham số từ Map
            String keyword = (String) filters.get("keyword");
            Double minPrice = (Double) filters.get("minPrice");
            Double maxPrice = (Double) filters.get("maxPrice");

            String[] categories = (String[]) filters.get("categories");
            String[] brands = (String[]) filters.get("brands");

            String categoryIds = (categories != null) ? String.join(",", categories) : null;
            String brandIds = (brands != null) ? String.join(",", brands) : null;

            // Set tham số cho procedure
            if (keyword != null && !keyword.isEmpty()) {
                callableStatement.setString(1, keyword);
            } else {
                callableStatement.setNull(1, Types.VARCHAR);
            }

            if (minPrice != null) {
                callableStatement.setDouble(2, minPrice);
            } else {
                callableStatement.setNull(2, Types.DOUBLE);
            }

            if (maxPrice != null) {
                callableStatement.setDouble(3, maxPrice);
            } else {
                callableStatement.setNull(3, Types.DOUBLE);
            }

            if (categoryIds != null && !categoryIds.isEmpty()) {
                callableStatement.setString(4, categoryIds);
            } else {
                callableStatement.setNull(4, Types.VARCHAR);
            }

            if (brandIds != null && !brandIds.isEmpty()) {
                callableStatement.setString(5, brandIds);
            } else {
                callableStatement.setNull(5, Types.VARCHAR);
            }

            callableStatement.setInt(6, (Integer) filters.get("start"));
            callableStatement.setInt(7, (Integer) filters.get("recordsPerPage"));

            boolean hasResults = callableStatement.execute();
            if (hasResults) {

                try (ResultSet rs = callableStatement.getResultSet()) {
                // đọc danh sách sản phẩm
                while (rs.next()) {
                    addProductToList(rs, products);
                }}

                if (callableStatement.getMoreResults()) {
                    try (ResultSet countRs = callableStatement.getResultSet()) {
                        if (countRs.next()) {
                            total = countRs.getInt("total");
                        }
                    }
                }
            }


        } catch (SQLException e) {
            DBConnection.printSQLException(e);
        }
        Map<String, Object> result = new HashMap<>();
        result.put("total", total);
        result.put("products", products);
        return result;
    }

    public String[] getRangePrice() {
        String[] rangePrice = new String[2];
        try (Connection con = DBConnection.getConnection();
             PreparedStatement preparedStatement = con.prepareStatement(SELECT_RANGE_PRICE);
             ResultSet resultSet = preparedStatement.executeQuery();
        ) {
            while (resultSet.next()) {
                rangePrice[0] = resultSet.getString("min");
                rangePrice[1] = resultSet.getString("max");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rangePrice;
    }

    @Override
    public List<Product> findByPage(int offset, int limit) {
        List<Product> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(SELECT_ALL_PRODUCT);) {
            ps.setInt(1, offset);
            ps.setInt(2, limit);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                addProductToList(rs, list);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public int countTotalRecords() {
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(COUNT_PRODUCT);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
}

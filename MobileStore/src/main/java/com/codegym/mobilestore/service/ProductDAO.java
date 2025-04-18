package com.codegym.mobilestore.service;

import com.codegym.mobilestore.model.Product;

import java.sql.*;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class ProductDAO implements GeneralDAO<Product> {

    private static final String SELECT_ALL_PRODUCT = "SELECT * FROM Product";

    @Override
    public List<Product> findAll() {
        List<Product> products = new ArrayList<Product>();
        try(Connection con = DBConnection.getConnection();
            PreparedStatement preparedStatement = con.prepareStatement(SELECT_ALL_PRODUCT)) {
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                Product product = new Product();
                product.setProductId(resultSet.getInt("product_id"));
                product.setProductName(resultSet.getString("product_name"));
                product.setDescription(resultSet.getString("description"));
                product.setPrice(resultSet.getBigDecimal("price"));
                product.setStockQuantity(resultSet.getInt("stock_quantity"));
                product.setImageUrl(resultSet.getString("image_url"));
                products.add(product);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

       return products;
    }

    @Override
    public List<Product> findAllWithStoreProcedure() {
        List<Product> products = new ArrayList<Product>();
        String query = "{CALL sp_get_all_products()}";
        try(Connection con = DBConnection.getConnection();
            CallableStatement callableStatement = con.prepareCall(query)) {
            ResultSet resultSet = callableStatement.executeQuery();
            while (resultSet.next()) {
                Product product = new Product();
                product.setProductId(resultSet.getInt("product_id"));
                product.setProductName(resultSet.getString("product_name"));
                product.setDescription(resultSet.getString("description"));
                product.setPrice(resultSet.getBigDecimal("price"));
                product.setStockQuantity(resultSet.getInt("stock_quantity"));
                product.setImageUrl(resultSet.getString("image_url"));
                products.add(product);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return products;
    }
}

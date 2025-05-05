package com.codegym.mobilestore.service;

import com.codegym.mobilestore.model.Customer;
import com.codegym.mobilestore.model.Order;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.Collections;
import java.util.List;

public class CustomerDAO implements GeneralDAO<Customer> {

    @Override
    public Customer findById(int id) {
        Customer customer = null;
        String sql = "SELECT * FROM customer_info WHERE id = ?";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql);) {
            preparedStatement.setInt(1, id);
            ResultSet rs = preparedStatement.executeQuery();

            while (rs.next()) {
                String name = rs.getString("name"),
                address = rs.getString("address"),
                phone = rs.getString("phone");
                customer = new Customer(id,name,address,phone);
            }
            rs.close();
        } catch (SQLException e) {
            DBConnection.printSQLException(e);
        }
        return customer;
    }
}

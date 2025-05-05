package com.codegym.mobilestore.service;

import com.codegym.mobilestore.model.Category;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class CategoryDAO implements GeneralDAO<Category>, ReadAllDAO<Category> {
    private static final String SELECT_ALL_CATEGORY = "SELECT * FROM Category";
    private static final String SELECT_CATEGORY_BY_ID = "SELECT * FROM Category WHERE category_id = ?";

    @Override
    public List findAll() {
        List<Category> categories = new ArrayList<Category>();
        try (Connection con = DBConnection.getConnection();
             PreparedStatement preparedStatement = con.prepareStatement(SELECT_ALL_CATEGORY)) {
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                Category category = new Category();
                category.setCategoryId(resultSet.getInt("category_id"));
                category.setCategoryName(resultSet.getString("category_name"));
                category.setDescription(resultSet.getString("description"));
                categories.add(category);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return categories;
    }

    @Override
    public List findAllWithStoreProcedure() {
        return Collections.emptyList();
    }

    @Override
    public Category findById(int id) {
        Category category = null;
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_CATEGORY_BY_ID)) {
            preparedStatement.setInt(1, id);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                category.setCategoryId(resultSet.getInt("category_id"));
                category.setCategoryName(resultSet.getString("category_name"));
                category.setDescription(resultSet.getString("description"));
            }
        } catch (SQLException e) {
            DBConnection.printSQLException(e);
        }
        return category;
    }
}


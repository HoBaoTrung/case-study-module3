package com.codegym.mobilestore.service;

import com.codegym.mobilestore.model.Brand;
import com.codegym.mobilestore.model.Category;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class BrandDAO implements GeneralDAO<Brand>, ReadAllDAO<Brand> {
    private static final String SELECT_ALL_BRAND = "SELECT * FROM Brand";
    private static final String SELECT_BRAND_BY_ID = "SELECT * FROM Brand WHERE brand_id = ?";

    @Override
    public List findAll() {
        List<Brand> brands = new ArrayList<Brand>();
        try (Connection con = DBConnection.getConnection();
             PreparedStatement preparedStatement = con.prepareStatement(SELECT_ALL_BRAND)) {
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                Brand brand = new Brand();
                brand.setBrandId(resultSet.getInt("brand_id"));
                brand.setBrandName(resultSet.getString("brand_name"));
                brand.setImageUrl(resultSet.getString("image_url"));
                brand.setCountry(resultSet.getString("country"));
                brand.setWebsite(resultSet.getString("website"));
                brands.add(brand);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return brands;
    }

    @Override
    public List findAllWithStoreProcedure() {
        return Collections.emptyList();
    }

    @Override
    public Brand findById(int id) {
        Brand brand = null;
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_BRAND_BY_ID)) {
            preparedStatement.setInt(1, id);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                brand.setBrandId(resultSet.getInt("brand_id"));
                brand.setBrandName(resultSet.getString("brand_name"));
                brand.setImageUrl(resultSet.getString("image_url"));
                brand.setCountry(resultSet.getString("country"));
                brand.setWebsite(resultSet.getString("website"));
            }
        } catch (SQLException e) {
            DBConnection.printSQLException(e);
        }
        return brand;
    }
}


package com.cafe.dao;


import com.cafe.entity.Category;
import com.cafe.util.DBConnect;

import java.sql.ResultSet;
import java.util.ArrayList;

import java.util.List;

import com.cafe.entity.Category;

public class CategoryDAOImpl implements CategoryDAO {
    @Override
    public List<Category> findAll() {
        List<Category> list = new ArrayList<Category>();
        String sql = "SELECT * FROM categories";
        try {
            ResultSet resultSet = DBConnect.executeQuery(sql);
            while (resultSet.next()) {
                int id = resultSet.getInt("id");
                String name = resultSet.getString("name");
                boolean active = resultSet.getBoolean("active");
                Category category = new Category(id, name, active);
                list.add(category);
            }
        } catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public Category findById(int id) {
        Category category = null;
        String sql = "SELECT * FROM categories WHERE id = ?";
        try {
            ResultSet resultSet = DBConnect.executeQuery(sql, id);
            while (resultSet.next()) {
                String name = resultSet.getString("name");
                boolean active = resultSet.getBoolean("active");
                category = new Category(id, name, active);
            }
        } catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
        }
        return category;
    }

    @Override
    public int deleteByID(int id) {
        String sql = "DELETE FROM categories WHERE id = ?";
        try {
            return DBConnect.executeUpdate(sql, id);
        } catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
        }
        return 0;
    }

    @Override
    public int create(Category category) {
        String sql = "INSERT INTO categories(name, active) values (?, ?)";
        try {
            return DBConnect.executeUpdate(sql, category.getName(), category.isActive());
        } catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
        }
        return 1;
    }

    @Override
    public int update(Category category) {
        String sql = "UPDATE categories SET name = ?, active = ? WHERE id = ?";
        try {
            return DBConnect.executeUpdate(sql, category.getName(), category.isActive(), category.getId());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;

    }

    @Override
    public int delete(int id) {
        // TODO Auto-generated method stub
        String sql = "DELETE FROM categories WHERE id = ?";
        try {
            return DBConnect.executeUpdate(sql, id);
        } catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
        }
        return 0;
    }

    @Override
    public int countDrinkInCategory(int categoryId) {
        int rs = 0;
        String sql = "select count(id) as num_drink from drinks where category_id = ?";
        try {
            ResultSet resultSet = DBConnect.executeQuery(sql, categoryId);

            while (resultSet.next()) {
                rs = resultSet.getInt("num_drink");
            }
        } catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
        }
        return rs;


    }
}

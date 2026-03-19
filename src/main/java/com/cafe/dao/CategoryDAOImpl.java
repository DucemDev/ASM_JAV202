package com.cafe.dao;

import com.cafe.entity.Category;
import com.cafe.util.DBConnect;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CategoryDAOImpl implements CategoryDAO {

    @Override
    public List<Category> findAll() {

        List<Category> list = new ArrayList<>();

        try {
            Connection conn = DBConnect.getConnection();

            String sql = "SELECT * FROM categories WHERE active = 1";

            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Category c = new Category();

                c.setId(rs.getInt("id"));
                c.setName(rs.getString("name"));

                list.add(c);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    @Override
    public Category findById(int id) {

        try {
            Connection conn = DBConnect.getConnection();

            String sql = "SELECT * FROM categories WHERE id = ?";

            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                Category c = new Category();

                c.setId(rs.getInt("id"));
                c.setName(rs.getString("name"));

                return c;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    @Override
    public void deleteByID(int id) {

        try {
            Connection conn = DBConnect.getConnection();

            String sql = "DELETE FROM categories WHERE id = ?";

            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void create(Category category) {

        try {
            Connection conn = DBConnect.getConnection();

            String sql = "INSERT INTO categories(name, active) VALUES (?, 1)";

            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, category.getName());

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void update(Category category) {

        try {
            Connection conn = DBConnect.getConnection();

            String sql = "UPDATE categories SET name=? WHERE id=?";

            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setString(1, category.getName());
            ps.setInt(2, category.getId());

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
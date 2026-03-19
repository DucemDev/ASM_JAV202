package com.cafe.dao;

import com.cafe.entity.Drink;
import com.cafe.util.DBConnect;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DrinkDAOImpl implements DrinkDAO {

    @Override
    public List<Drink> findAll() {

        List<Drink> list = new ArrayList<>();

        try {
            Connection conn = DBConnect.getConnection();

            String sql = "SELECT * FROM drinks WHERE active = 1";

            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Drink d = new Drink();

                d.setId(rs.getInt("id"));
                d.setName(rs.getString("name"));
                d.setPrice(rs.getInt("price"));
                d.setImage(rs.getString("image"));
                d.setDescription(rs.getString("description"));

                list.add(d);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    @Override
    public Drink findById(int id) {

        try {
            Connection conn = DBConnect.getConnection();

            String sql = "SELECT * FROM drinks WHERE id = ?";

            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                Drink d = new Drink();

                d.setId(rs.getInt("id"));
                d.setName(rs.getString("name"));
                d.setPrice(rs.getInt("price"));
                d.setImage(rs.getString("image"));
                d.setDescription(rs.getString("description"));

                return d;
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

            String sql = "DELETE FROM drinks WHERE id = ?";

            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public List<Drink> findByCategory(int categoryId) {

        List<Drink> list = new ArrayList<>();

        try {
            Connection conn = DBConnect.getConnection();

            String sql = "SELECT * FROM drinks WHERE category_id = ? AND active = 1";

            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, categoryId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Drink d = new Drink();

                d.setId(rs.getInt("id"));
                d.setName(rs.getString("name"));
                d.setPrice(rs.getInt("price"));
                d.setImage(rs.getString("image"));
                d.setDescription(rs.getString("description"));

                list.add(d);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    @Override
    public void create(Drink drink) {
        // để sau
    }

    @Override
    public void update(Drink drink) {
        // để sau
    }
}
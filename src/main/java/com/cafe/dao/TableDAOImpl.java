package com.cafe.dao;

import com.cafe.entity.Table;
import com.cafe.util.DBConnect;


import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TableDAOImpl implements TableDAO {

    @Override
    public List<Table> findAll() {
        List<Table> list = new ArrayList<>();

        String sql = "SELECT * FROM tables";

        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Table t = new Table();
                t.setId(rs.getInt("id"));
                t.setName(rs.getString("name"));
                t.setStatus(rs.getString("status"));
                t.setActive(rs.getBoolean("active"));

                list.add(t);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    @Override
    public void create(Table t) {

        String sql = "INSERT INTO tables(name, status, active) VALUES (?, ?, ?)";

        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, t.getName());
            ps.setString(2, t.getStatus());
            ps.setBoolean(3, t.isActive());

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void updateStatus(int id, String status) {

        String sql = "UPDATE tables SET status=? WHERE id=?";

        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, status);
            ps.setInt(2, id);

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
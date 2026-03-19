package com.cafe.dao;

import com.cafe.entity.Table;
import com.cafe.util.DBConnect; // sửa đúng class kết nối của bạn

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TableDAOImpl implements TableDAO {

    @Override
    public List<Table> findAll() {

        List<Table> list = new ArrayList<>();

        try {

            Connection conn = DBConnect.getConnection();

            String sql = "SELECT * FROM tables WHERE active = 1";

            PreparedStatement ps = conn.prepareStatement(sql);

            ResultSet rs = ps.executeQuery();

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
}
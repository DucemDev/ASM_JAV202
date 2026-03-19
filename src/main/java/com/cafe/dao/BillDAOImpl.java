package com.cafe.dao;

import com.cafe.entity.Bill;
import com.cafe.util.DBConnect;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BillDAOImpl implements BillDAO {

    @Override
    public List<Bill> findAll() {

        List<Bill> list = new ArrayList<>();

        try {
            Connection conn = DBConnect.getConnection();

            String sql = "SELECT * FROM bills";

            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Bill b = new Bill();

                b.setId(rs.getInt("id"));
                b.setTableId(rs.getInt("table_id"));
                b.setUserId(rs.getInt("user_id"));
                b.setCode(rs.getString("code"));
                b.setTotal(rs.getInt("total"));
                b.setStatus(rs.getString("status"));

                list.add(b);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    @Override
    public Bill findById(int id) {

        try {
            Connection conn = DBConnect.getConnection();

            String sql = "SELECT * FROM bills WHERE id = ?";

            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                Bill b = new Bill();

                b.setId(rs.getInt("id"));
                b.setTableId(rs.getInt("table_id"));
                b.setUserId(rs.getInt("user_id"));
                b.setCode(rs.getString("code"));
                b.setTotal(rs.getInt("total"));
                b.setStatus(rs.getString("status"));

                return b;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    @Override
    public Bill findByTableId(int tableId) {

        try {
            Connection conn = DBConnect.getConnection();

            String sql = "SELECT * FROM bills WHERE table_id = ? AND status = 'waiting'";

            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, tableId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                Bill b = new Bill();

                b.setId(rs.getInt("id"));
                b.setTableId(rs.getInt("table_id"));
                b.setUserId(rs.getInt("user_id"));
                b.setCode(rs.getString("code"));
                b.setTotal(rs.getInt("total"));
                b.setStatus(rs.getString("status"));

                return b;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    @Override
    public void create(Bill bill) {

        try {
            Connection conn = DBConnect.getConnection();

            String sql = "INSERT INTO bills(table_id, user_id, code, total, status) VALUES (?, ?, ?, ?, ?)";

            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setInt(1, bill.getTableId());
            ps.setInt(2, bill.getUserId());
            ps.setString(3, bill.getCode());
            ps.setInt(4, bill.getTotal());
            ps.setString(5, bill.getStatus());

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void update(Bill bill) {

        try {
            Connection conn = DBConnect.getConnection();

            String sql = "UPDATE bills SET total=?, status=? WHERE id=?";

            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setInt(1, bill.getTotal());
            ps.setString(2, bill.getStatus());
            ps.setInt(3, bill.getId());

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void deleteByID(int id) {

        try {
            Connection conn = DBConnect.getConnection();

            String sql = "DELETE FROM bills WHERE id = ?";

            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
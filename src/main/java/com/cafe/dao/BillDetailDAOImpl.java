package com.cafe.dao;

import com.cafe.entity.BillDetail;
import com.cafe.util.DBConnect;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BillDetailDAOImpl implements BillDetailDAO {

    @Override
    public List<BillDetail> findByBillId(int billId) {

        List<BillDetail> list = new ArrayList<>();

        try {
            Connection conn = DBConnect.getConnection();

            String sql = "SELECT * FROM bill_details WHERE bill_id = ?";

            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, billId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                BillDetail bd = new BillDetail();

                bd.setId(rs.getInt("id"));
                bd.setBillId(rs.getInt("bill_id"));
                bd.setDrinkId(rs.getInt("drink_id"));
                bd.setQuantity(rs.getInt("quantity"));
                bd.setPrice(rs.getInt("price"));

                list.add(bd);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    @Override
    public void insert(BillDetail bd) {

        try {
            Connection conn = DBConnect.getConnection();

            String sql = "INSERT INTO bill_details(bill_id, drink_id, quantity, price) VALUES (?, ?, ?, ?)";

            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setInt(1, bd.getBillId());
            ps.setInt(2, bd.getDrinkId());
            ps.setInt(3, bd.getQuantity());
            ps.setInt(4, bd.getPrice());

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
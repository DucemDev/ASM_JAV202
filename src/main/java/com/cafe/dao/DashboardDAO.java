package com.cafe.dao;

import com.cafe.util.DBConnect;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class DashboardDAO {

    Connection conn;

    public DashboardDAO() throws Exception {
        conn = DBConnect.getConnection();
    }

    // 1. Tổng doanh thu
    public int getTotalRevenue(String from, String to) throws Exception {

        String sql = "SELECT ISNULL(SUM(total),0) FROM bills WHERE status='finish'";

        if (from != null && !from.isEmpty() && to != null && !to.isEmpty()) {
            sql += " AND CAST(created_at AS DATE) BETWEEN ? AND ?";
        }

        PreparedStatement ps = conn.prepareStatement(sql);

        if (from != null && !from.isEmpty() && to != null && !to.isEmpty()) {
            ps.setString(1, from);
            ps.setString(2, to);
        }

        ResultSet rs = ps.executeQuery();
        if (rs.next()) return rs.getInt(1);

        return 0;
    }

    // 2. Doanh thu hôm nay
    public int getTodayRevenue() throws Exception {

        String sql = """
            SELECT ISNULL(SUM(total),0)
            FROM bills
            WHERE status='finish'
            AND CAST(created_at AS DATE) = CAST(GETDATE() AS DATE)
        """;

        PreparedStatement ps = conn.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) return rs.getInt(1);

        return 0;
    }

    // 3. Số hóa đơn (có filter)
    public int getBillCount(String from, String to) throws Exception {

        String sql = "SELECT COUNT(*) FROM bills WHERE status='finish'";

        if (from != null && !from.isEmpty() && to != null && !to.isEmpty()) {
            sql += " AND CAST(created_at AS DATE) BETWEEN ? AND ?";
        }

        PreparedStatement ps = conn.prepareStatement(sql);

        if (from != null && !from.isEmpty() && to != null && !to.isEmpty()) {
            ps.setString(1, from);
            ps.setString(2, to);
        }

        ResultSet rs = ps.executeQuery();

        if (rs.next()) return rs.getInt(1);

        return 0;
    }

    // 4. Bàn đang dùng
    public int getUsingTables() throws Exception {

        String sql = "SELECT COUNT(*) FROM tables WHERE status='using'";

        PreparedStatement ps = conn.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) return rs.getInt(1);

        return 0;
    }
}
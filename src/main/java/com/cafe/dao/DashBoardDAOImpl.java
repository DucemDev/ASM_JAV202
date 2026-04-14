package com.cafe.dao;

import com.cafe.dto.TopDrinkDTO;
import com.cafe.util.DBConnect;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DashBoardDAOImpl implements DashBoardDAO {

    // ===== TOP DRINK =====
    @Override
    public List<TopDrinkDTO> getTop5Drinks() {
        String sql = """
            SELECT TOP 5 d.name, SUM(bd.quantity) AS total
            FROM bill_details bd
            JOIN drinks d ON bd.drink_id = d.id
            GROUP BY d.name
            ORDER BY total DESC
        """;

        List<TopDrinkDTO> list = new ArrayList<>();

        try (
                Connection conn = DBConnect.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()
        ) {
            while (rs.next()) {
                list.add(new TopDrinkDTO(
                        rs.getString("name"),
                        rs.getInt("total")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // ===== REVENUE CHART =====
    @Override
    public List<Object[]> getRevenueByDate(int days) {
        String sql = """
            SELECT 
                CAST(created_at AS DATE) AS day,
                SUM(total) AS revenue
            FROM bills
            WHERE status = 'finish'
            AND created_at >= DATEADD(DAY, ?, GETDATE())
            GROUP BY CAST(created_at AS DATE)
            ORDER BY day
        """;

        List<Object[]> list = new ArrayList<>();

        try (
                Connection conn = DBConnect.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)
        ) {
            ps.setInt(1, -days);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                list.add(new Object[]{
                        rs.getDate("day"),
                        rs.getInt("revenue")
                });
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // ===== TOTAL REVENUE =====
    @Override
    public int getTotalRevenue(String from, String to) {
        String sql = "SELECT ISNULL(SUM(total),0) FROM bills WHERE status='finish'";

        List<Object> params = new ArrayList<>();

        if (from != null && !from.isEmpty() && to != null && !to.isEmpty()) {
            sql += " AND CAST(created_at AS DATE) BETWEEN ? AND ?";
            params.add(from);
            params.add(to);
        }

        try (
                Connection conn = DBConnect.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)
        ) {
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);

        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }

    // ===== TODAY REVENUE =====
    @Override
    public int getTodayRevenue() {
        String sql = """
            SELECT ISNULL(SUM(total),0)
            FROM bills
            WHERE status='finish'
            AND CAST(created_at AS DATE) = CAST(GETDATE() AS DATE)
        """;

        try (
                Connection conn = DBConnect.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()
        ) {
            if (rs.next()) return rs.getInt(1);

        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }

    // ===== BILL COUNT =====
    @Override
    public int getBillCount(String from, String to) {
        String sql = "SELECT COUNT(*) FROM bills WHERE status='finish'";

        List<Object> params = new ArrayList<>();

        if (from != null && !from.isEmpty() && to != null && !to.isEmpty()) {
            sql += " AND CAST(created_at AS DATE) BETWEEN ? AND ?";
            params.add(from);
            params.add(to);
        }

        try (
                Connection conn = DBConnect.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)
        ) {
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);

        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }

    // ===== USING TABLE =====
    @Override
    public int getUsingTables() {
        String sql = "SELECT COUNT(*) FROM tables WHERE status='using'";

        try (
                Connection conn = DBConnect.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()
        ) {
            if (rs.next()) return rs.getInt(1);

        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }
}
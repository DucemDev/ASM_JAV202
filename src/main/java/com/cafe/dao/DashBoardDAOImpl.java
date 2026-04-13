package com.cafe.dao;

import com.cafe.dto.TopDrinkDTO;
import com.cafe.util.DBConnect;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class DashBoardDAOImpl implements DashBoardDAO{
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
}

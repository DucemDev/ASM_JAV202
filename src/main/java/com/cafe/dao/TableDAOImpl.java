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

        // 🔥 CHỈ LOAD bàn active
        String sql = "SELECT * FROM tables ORDER BY id";


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
            ps.setBoolean(3, true);

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


    @Override
    public void hide(int id) {
        String sql = "UPDATE tables SET active = 0, status = 'hidden' WHERE id = ? AND status = 'empty'";

        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            int rows = ps.executeUpdate();

            if (rows == 0) {
                System.out.println("Không thể ẩn bàn vì bàn không ở trạng thái empty.");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void show(int id) {
        String sql = "UPDATE tables SET active = 1, status = 'empty' WHERE id = ?";

        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public boolean existsByName(String name) {
        String sql = "SELECT COUNT(*) FROM tables WHERE name = ? AND active = 1";

        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, name);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

@Override
public boolean existsByNameExceptId(String name, int id) {
    String sql = "SELECT COUNT(*) FROM tables WHERE name = ? AND id <> ? AND active = 1";

    try (Connection conn = DBConnect.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {

        ps.setString(1, name);
        ps.setInt(2, id);

        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        }

    } catch (Exception e) {
        e.printStackTrace();
    }

    return false;
}

    @Override
    public List<Table> search(String status, String keyword) {
        List<Table> list = new ArrayList<>();

        StringBuilder sql = new StringBuilder("SELECT * FROM tables WHERE active = 1");

        if (status != null && !status.isEmpty()) {
            sql.append(" AND status = ?");
        }

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append(" AND name LIKE ?");
        }

        sql.append(" ORDER BY id");

        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {

            int index = 1;

            if (status != null && !status.isEmpty()) {
                ps.setString(index++, status);
            }

            if (keyword != null && !keyword.trim().isEmpty()) {
                ps.setString(index++, "%" + keyword.trim() + "%");
            }

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


@Override
public void update(Table t) {
    String sql = "UPDATE tables SET name = ?, status = ? WHERE id = ?";

    try (Connection conn = DBConnect.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {

        ps.setString(1, t.getName());
        ps.setString(2, t.getStatus());
        ps.setInt(3, t.getId());

        ps.executeUpdate();

    } catch (Exception e) {
        e.printStackTrace();
    }
}


    @Override
    public Table findById(int id) {
        String sql = "SELECT * FROM tables WHERE id = ?";

        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Table t = new Table();
                    t.setId(rs.getInt("id"));
                    t.setName(rs.getString("name"));
                    t.setStatus(rs.getString("status"));
                    t.setActive(rs.getBoolean("active"));
                    return t;
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
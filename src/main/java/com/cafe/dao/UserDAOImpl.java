package com.cafe.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.cafe.entity.User;
import com.cafe.util.DBConnect;

public class UserDAOImpl implements UserDAO {

    // ===== FIND BY ID =====
    @Override
    public User findById(int id) {
        String sql = "SELECT * FROM users WHERE id = ?";
        try (
                Connection conn = DBConnect.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)
        ) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return new User(
                        rs.getInt("id"),
                        rs.getString("full_name"),
                        rs.getString("email"),
                        rs.getString("password"),
                        rs.getString("phone"),
                        rs.getInt("role"),
                        rs.getBoolean("active")
                );
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    @Override
    public List<User> findByKeyword(String keyword) {
        String sql = "SELECT * FROM users WHERE email LIKE ?";
        return findBySql(sql, "%" + keyword + "%");
    }
    // ===== FIND BY EMAIL =====
    public User findByEmail(String email) {
        String sql = "SELECT * FROM users WHERE email = ? AND active = 1";
        try (
                Connection conn = DBConnect.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)
        ) {
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return new User(
                        rs.getInt("id"),
                        rs.getString("full_name"),
                        rs.getString("email"),
                        rs.getString("password"),
                        rs.getString("phone"),
                        rs.getInt("role"),
                        rs.getBoolean("active")
                );
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // ===== LOGIN =====
    @Override
    public User login(String email, String password) {
        String sql = "SELECT * FROM users WHERE email = ? AND password = ? AND active = 1";
        try (
                Connection conn = DBConnect.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)
        ) {
            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return new User(
                        rs.getInt("id"),
                        rs.getString("full_name"),
                        rs.getString("email"),
                        rs.getString("password"),
                        rs.getString("phone"),
                        rs.getInt("role"),
                        rs.getBoolean("active")
                );
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    // ===== CREATE =====
    @Override
    public int create(User user) {
        String sql = "INSERT INTO users(email, password, full_name, phone, role, active) VALUES (?, ?, ?, ?, ?, ?)";
        try {
            return DBConnect.executeUpdate(sql,
                    user.getEmail(),
                    user.getPassword(),
                    user.getFullname(),
                    user.getPhone(),
                    user.getRole(),
                    user.isActive()
            );
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    // ===== UPDATE =====
    @Override
    public int update(User user) {
        String sql = "UPDATE users SET email=?, password=?, full_name=?, phone=?, role=?, active=? WHERE id=?";
        try {
            return DBConnect.executeUpdate(sql,
                    user.getEmail(),
                    user.getPassword(),
                    user.getFullname(),
                    user.getPhone(),
                    user.getRole(),
                    user.isActive(),
                    user.getId()
            );
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    // ===== UPDATE STATUS =====
    @Override
    public int updateStatus(Integer id, boolean active) {
        String sql = "UPDATE users SET active = ? WHERE id = ?";
        try {
            return DBConnect.executeUpdate(sql, active, id);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    // ===== UPDATE USER INFO =====
    @Override
    public int updateUserInfo(User entity) {
        String sql = "UPDATE users SET full_name = ?, phone = ? WHERE id = ?";
        try {
            return DBConnect.executeUpdate(sql,
                    entity.getFullname(),
                    entity.getPhone(),
                    entity.getId()
            );
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
    // ===== UPDATE PASSWORD =====
    @Override
    public void updatePassword(String email, String password) {
        String sql = "UPDATE users SET password=? WHERE email=?";
        try {
            DBConnect.executeUpdate(sql, password, email);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // ===== UPDATE CHANGE INFORMATION =====
    @Override
    public void updateChangeInformation(User user) {
        String sql = "UPDATE users SET full_name = ?, email = ?, phone = ? WHERE id = ?";
        try {
            DBConnect.executeUpdate(sql,
                    user.getFullname(),
                    user.getEmail(),
                    user.getPhone(),
                    user.getId()
            );
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    // ===== FIND BY ROLE =====
    public List<User> findByRole(int role) {
        String sql = "SELECT * FROM users WHERE role = ?";
        return findBySql(sql, role);
    }

    // ===== FIND ALL =====
    public List<User> findAll() {
        String sql = "SELECT * FROM users";
        return findBySql(sql);
    }

    // ===== CORE QUERY =====
    @Override
    public List<User> findBySql(String sql, Object... values) {
        List<User> list = new ArrayList<>();

        try (
                Connection conn = DBConnect.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)
        ) {

            for (int i = 0; i < values.length; i++) {
                ps.setObject(i + 1, values[i]);
            }

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                User u = new User(
                        rs.getInt("id"),
                        rs.getString("full_name"),
                        rs.getString("email"),
                        rs.getString("password"),
                        rs.getString("phone"),
                        rs.getInt("role"),
                        rs.getBoolean("active")
                );
                list.add(u);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}
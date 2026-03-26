package com.cafe.dao;

import com.cafe.entity.User;
import com.cafe.util.DBConnect;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;

public class UserDAOImpl implements UserDAO {
    @Override
    public User findByEmail(String email) {
        User user = null;
        String sql = "select * from users where active = 1 and email = ?";
        try {
            ResultSet rs = DBConnect.executeQuery(sql, email);
            while (rs.next()) {
                int id = rs.getInt("id");
                String password = rs.getString("password");
                String fullName = rs.getString("full_name");
                String phone = rs.getString("phone");
                boolean role = rs.getBoolean("role");
                boolean active = rs.getBoolean("active");
                user = new User(id, email, password, fullName, phone, role, active);
            }
        } catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
        }
        return user;
    }

    @Override
    public List<User> findBySql(String sql, Object... value) {
        return null;
    }

    public List<User> findByRole(boolean role) {
        String sql = "SELECT * FROM users WHERE role = ?";
        try {
            return findBySql(sql, role);
        } catch (Exception e) {
        }
        return null;
    }

    @Override
    public int create(User user) {
        String sql = "INSERT INTO users(email, password, full_name, phone, role, active) values (?, ?, ?, ?, ?, ?)";
        try {
            return DBConnect.executeUpdate(sql, user.getEmail(), user.getPassword(), user.getFullname(),
                    user.getPhone(), user.isRole(), user.isActive());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    @Override
    public int update(User user) {
        String sql = "UPDATE users SET email = ?, password = ?, full_name = ?, phone = ?, role = ?, active = ? WHERE id = ?";
        try {
            return DBConnect.executeUpdate(sql, user.getEmail(), user.getPassword(), user.getFullname(),
                    user.getPhone(), user.isRole(), user.isActive(), user.getId());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    @Override
    public User login(String email, String password) {

        String sql = "SELECT * FROM users WHERE email = ? AND password = ? AND active = 1";

        try (Connection conn = DBConnect.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                return new User(rs.getInt("id"), rs.getString("full_name"), rs.getString("email"),
                        rs.getString("password"), rs.getString("phone"), rs.getBoolean("role"),
                        rs.getBoolean("active"));

            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    @Override
    public int updateStatus(Integer id, boolean active) {
        String sql = "UPDATE users SET active = ? WHERE id = ?";
        try {
            return DBConnect.executeUpdate(sql, active, id);
        } catch (Exception e) {

        }
        return 0;
    }

    @Override
    public int updateUserInfo(User entity) {
        String sql = "UPDATE users SET full_name = ?, phone = ? WHERE id = ?";
        try {
            return DBConnect.executeUpdate(sql, entity.getFullname(), entity.getPhone(), entity.getId());
        } catch (Exception e) {
            // TODO: handle exception
        }

        return 0;
    }

}

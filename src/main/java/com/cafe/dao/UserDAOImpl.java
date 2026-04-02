package com.cafe.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;

import com.cafe.entity.User;
import com.cafe.util.DBConnect;

public class UserDAOImpl implements UserDAO {

//    @Override
//    public List<User> findAll(User user) {
//        return null;
//    }
//
//    @Override
//    public User findById(int id) {
//        return null;
//    }

    // ===== FIND BY EMAIL =====
    public User findByEmail(String email) {
        String sql = "SELECT * FROM users WHERE active = 1 AND email = ?";
        try {
            ResultSet rs = DBConnect.executeQuery(sql, email);
            while (rs.next()) {
                return new User(
                        rs.getInt("id"),
                        rs.getString("full_name"),
                        rs.getString("email"),
                        rs.getString("password"),
                        rs.getString("phone"),
                        rs.getBoolean("role"),
                        rs.getBoolean("admin"),
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
                        rs.getString("full_name"),  // ✅ fullname
                        rs.getString("email"),      // ✅ email
                        rs.getString("password"),   // ✅ password
                        rs.getString("phone"),
                        rs.getBoolean("role"),
                        rs.getBoolean("admin"),
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
                    user.isRole(),
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
                    user.isRole(),
                    user.isActive(),
                    user.getId()
            );
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
//
//    // ===== DELETE =====
//    @Override
//    public void deleteByID(int id) {
//        String sql = "DELETE FROM users WHERE id = ?";
//        try {
//            DBConnect.executeUpdate(sql, id);
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//    }

    // ===== UPDATE PASSWORD =====
    public void updatePassword(String email, String password) {
        String sql = "UPDATE users SET password=? WHERE email=?";
        try {
            DBConnect.executeUpdate(sql, password, email);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // ===== UPDATE PROFILE (HEAD giữ lại) =====
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

    // ===== OPTIONAL =====
//    @Override
//    public List<User> findBySql(String sql, Object... value) {
//        return null;
//    }
//

    public List<User> findByRole(boolean role) {
        String sql = "SELECT * FROM users WHERE role = ?";
        try {
            return findBySql(sql, role);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<User> findAll() {
        String sql = "SELECT * FROM users";
        return findBySql(sql);
    }

    @Override
    public List<User> findBySql(String sql, Object... values) {

        List<User> list = new java.util.ArrayList<>();

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
                        rs.getBoolean("role"),
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
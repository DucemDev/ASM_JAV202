package com.cafe.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;

import com.cafe.entity.User;
import com.cafe.util.DBConnect;

public class UserDAOImpl implements UserDAO {
    @Override
	public List<User> findAll(User user) {
        return null;
    }

    @Override
	public User findById(int id) {
        return null;
    }

    @Override
	public User findByEmail(String email) {
        return null;
    }

    @Override
	public void deleteByID(int id) {
    }

    @Override
	public void create(User user) {
    }

    @Override
	public void update(User user) {
    }

    @Override
	public User login(String email, String password) {

        String sql = "SELECT * FROM users WHERE email = ? AND password = ? AND active = 1";

        try (
                Connection conn = DBConnect.getConnection();
                
        ) {
        	
        	System.out.println("CONNECTION = " + conn);
        	PreparedStatement ps = conn.prepareStatement(sql);
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
                        rs.getBoolean("role"),
                        rs.getBoolean("active")
                );

            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }
    public void updatePassword(String email, String password) {
        try {
            Connection con = DBConnect.getConnection();
            String sql = "UPDATE users SET password=? WHERE email=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, password);
            ps.setString(2, email);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void updateChangeInformation(User user) {
        String sql = "UPDATE users SET full_name = ?, email = ?, phone = ? WHERE id = ?";

        try (
                Connection conn = DBConnect.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)
        ) {

            ps.setString(1, user.getFullname());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPhone());
            ps.setInt(4, user.getId());

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

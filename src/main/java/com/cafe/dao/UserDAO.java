package com.cafe.dao;

import com.cafe.entity.User;

import java.util.List;

public interface UserDAO {
    public User findByEmail(String email);
    public List<User> findBySql(String sql, Object... value);
    public List<User> findByRole(boolean role);
    public int create(User user);
    public int update(User user);
    User login(String email,String password);
    public int updateStatus(Integer id, boolean active);
    public int updateUserInfo(User entity);

}

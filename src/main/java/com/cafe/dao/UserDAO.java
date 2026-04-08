package com.cafe.dao;

import java.util.List;

import com.cafe.entity.User;

public interface UserDAO {
    public User findByEmail(String email);
    public User findById(int id);
    List<User> findByKeyword(String keyword);
    public List<User> findBySql(String sql, Object... value);
    List<User> findByRole(int role);
    public int create(User user);
    public int update(User user);
    User login(String email,String password);
    void updatePassword(String email, String password);
    void updateChangeInformation(User user);
    public int updateStatus(Integer id, boolean active);
    public int updateUserInfo(User entity);


}

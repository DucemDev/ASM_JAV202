package com.cafe.dao;

import java.util.List;

import com.cafe.entity.User;

public interface UserDAO {
    List<User> findAll(User user);
    User findById(int id);
    User findByEmail(String email);
    void deleteByID(int id);
    void create(User user);
    void update(User user);
    User login(String email,String password);
}

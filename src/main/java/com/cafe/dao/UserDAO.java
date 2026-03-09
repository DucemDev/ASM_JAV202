package com.cafe.dao;

import com.cafe.entity.User;

import java.util.List;

public interface UserDAO {
    List<User> findAll(User user);
    User findById(int id);
    User findByEmail(String email);
    void deleteByID(int id);
    void create(User user);
    void update(User user);
}

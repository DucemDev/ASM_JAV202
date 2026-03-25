package com.cafe.dao;

import java.util.List;

import com.cafe.entity.Category;

public interface CategoryDAO {
    List<Category> findAll(Category category);
    Category findById(int id);
    void deleteByID(int id);
    void create(Category category);
    void update(Category category);
}

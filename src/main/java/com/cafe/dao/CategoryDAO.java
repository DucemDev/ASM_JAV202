package com.cafe.dao;

import com.cafe.entity.Category;
import com.cafe.entity.Drink;

import java.util.List;

public interface CategoryDAO {
    List<Category> findAll();

    Category findById(int id);

    void deleteByID(int id);

    void create(Category category);

    void update(Category category);
}

package com.cafe.dao;

import com.cafe.entity.Category;
import com.cafe.entity.Drink;

import java.util.List;

public interface CategoryDAO {
    public List<Category> findAll();
    public Category findById(int id);
    public int deleteByID(int id);
    public int create(Category category);
    public int update(Category category);
    public int delete(int id);
    public int countDrinkInCategory(int categoryId);
}

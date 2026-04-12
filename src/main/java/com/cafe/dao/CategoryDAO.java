package com.cafe.dao;

import java.util.List;

import com.cafe.entity.Category;

public interface CategoryDAO {
    public List<Category> findAll();
    public Category findById(int id);
    public int deleteByID(int id);
    public int create(Category category);
    public int update(Category category);
    public int delete(int id);
    public int countDrinkInCategory(int categoryId);
    public boolean existsByName(String name);
    public boolean existsByNameExceptId(String name, int id);
    public List<Category> search(String keyword, String active);
}

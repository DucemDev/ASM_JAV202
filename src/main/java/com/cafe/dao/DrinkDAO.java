package com.cafe.dao;

import java.util.List;

import com.cafe.entity.Drink;

public interface DrinkDAO {
    public List<Drink> findAll();
    public List<Drink> findPage(int page, int pageSize);
    public int countActive();
    public List<Drink> findPageAll(int page, int pageSize);
    public int countAllDrinks();
    public List<Drink> findFilteredPage(int page, int pageSize, String keyword, Integer categoryId, Boolean active);
    public int countFiltered(String keyword, Integer categoryId, Boolean active);
    public List<Drink> findFiltered(String keyword, Integer categoryId, Boolean active);

    public Drink findById(int id);

    public int delete(int id);

    public int create(Drink drink);

    public int update(Drink drink);

    public List<Drink> findBySql(String sql, Object... value);

    
}

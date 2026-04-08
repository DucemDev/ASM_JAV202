package com.cafe.dao;

import java.util.List;

import com.cafe.entity.Drink;

public interface DrinkDAO {
    public List<Drink> findAll();

    public Drink findById(int id);

    public int delete(int id);

    public int create(Drink drink);

    public int update(Drink drink);

    public List<Drink> findBySql(String sql, Object... value);

    
}

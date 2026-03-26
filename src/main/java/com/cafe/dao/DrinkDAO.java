package com.cafe.dao;

import com.cafe.entity.Drink;
import com.cafe.entity.User;

import java.util.List;

public interface DrinkDAO {
    public List<Drink> findAll();
    public Drink findById(int id);
    public int delete(int id);
    public int create(Drink drink);
    public int update(Drink drink);
    public List<Drink> findBySql(String sql, Object... value);
}

package com.cafe.dao;

import java.util.List;

import com.cafe.entity.Drink;

public interface DrinkDAO {
    List<Drink> findAll(Drink drink);
    Drink findById(int id);
    void deleteByID(int id);
    void create(Drink drink);
    void update(Drink drink);
}

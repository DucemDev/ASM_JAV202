package com.cafe.dao;

import com.cafe.entity.Drink;
import com.cafe.entity.User;

import java.util.List;

public interface DrinkDAO {
    List<Drink> findAll(Drink drink);
    Drink findById(int id);
    void deleteByID(int id);
    void create(Drink drink);
    void update(Drink drink);
}

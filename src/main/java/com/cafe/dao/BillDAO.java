package com.cafe.dao;

import com.cafe.entity.Bill;
import com.cafe.entity.Drink;

import java.util.List;

public interface BillDAO {
    List<Bill> findAll(Bill bill);
    Bill findById(int id);
    void deleteByID(int id);
    void create(Bill bill);
    void update(Bill bill);
}

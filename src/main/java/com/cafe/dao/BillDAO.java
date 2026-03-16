package com.cafe.dao;

import java.util.List;

import com.cafe.entity.Bill;

public interface BillDAO {
    List<Bill> findAll(Bill bill);
    Bill findById(int id);
    void deleteByID(int id);
    void create(Bill bill);
    void update(Bill bill);
}

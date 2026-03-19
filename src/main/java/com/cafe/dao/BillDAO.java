package com.cafe.dao;

import com.cafe.entity.Bill;
import com.cafe.entity.Drink;

import java.util.List;

public interface BillDAO {

    List<Bill> findAll(); // ❌ bỏ tham số

    Bill findById(int id);

    Bill findByTableId(int tableId);

    void create(Bill bill);

    void update(Bill bill);

    void deleteByID(int id);
}

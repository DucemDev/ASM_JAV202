package com.cafe.dao;

import com.cafe.entity.BillDetail;

import java.util.List;

public interface BillDetailDAO {
    List<BillDetail> findAll(BillDetail billDetail);
    BillDetail findById(int id);
    BillDetail findByName(String name);
    BillDetail findByPrice(int drinkId);
    void delete(BillDetail billDetail);

}

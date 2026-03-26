package com.cafe.dao;

import com.cafe.entity.BillDetail;

import java.util.List;

public interface BillDetailDAO {
    public List<BillDetail> findByBillId(int billId);
    public int addDrinkToBill(int billId, int drinkId);
    public int updateQuantity(int billId, int drinkId, int quantity);
    public int create(BillDetail billdetail);
    public int update(BillDetail billdetail);
    public BillDetail findById(Integer id);
    public List<BillDetail> findBySql(String sql, Object... value);
}

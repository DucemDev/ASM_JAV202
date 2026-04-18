package com.cafe.dao;


import com.cafe.entity.Bill;
import com.cafe.entity.BillDetail;
import com.cafe.entity.Drink;


import java.util.List;

import com.cafe.entity.Bill;

public interface BillDAO {
    public int create(Bill bill);

    public int update(Bill bill);

    public Bill findByIdAndUserId(int id, int userId);

    public int createWithBillDetails(Bill bill, List<BillDetail> billDetails);

    public int updateStatus(int billId, String status);

    public int updateTotal(int billId);

    public List<Bill> findByUserId(int userId);

    public List<Bill> findBySql(String sql, Object... value);
    public int countBySql(String sql, Object... params);
    public Bill findById(int id);
    public void expireOldOrders();
    public Bill findOpenByTableId(int tableId);
    Bill findOpenByUserId(int userId);
    List<Bill> findPendingOnlineOrders();
    public static final String STATUS_WAITING = "waiting";
    public static final String STATUS_FINISH = "finish";
    public static final String STATUS_CANCEL = "cancel";
    public static final String STATUS_PENDING_VERIFY = "pending_verify";
}

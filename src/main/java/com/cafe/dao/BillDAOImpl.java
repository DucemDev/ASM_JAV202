package com.cafe.dao;

import com.cafe.entity.Bill;
import com.cafe.entity.BillDetail;
import com.cafe.entity.Drink;
import com.cafe.util.DBConnect;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class BillDAOImpl implements BillDAO {
    BillDetailDAO billDetailDAO = new BillDetailDAOImpl();
    @Override
    public int create(Bill bill) {
        String sql = "INSERT INTO bills(user_id, code, created_at, total, status) values (?, ?, ?, ?, ?)";
        try {
            return DBConnect.executeUpdate(sql, bill.getUserId(), bill.getCode(), bill.getCreatedAt(),
                    bill.getTotal(), bill.getStatus());
        } catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
        }
        return 0;
    }
    @Override
    public int update(Bill bill) {
        String sql = "UPDATE bills SET user_id = ?, code = ?, created_at = ?, total = ?, status = ? WHERE id = ?";
        try {
            return DBConnect.executeUpdate(sql, bill.getUserId(), bill.getCode(), bill.getCreatedAt(),
                    bill.getTotal(), bill.getStatus(), bill.getId());
        } catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
        }
        return 0;
    }


    @Override
    public Bill findByIdAndUserId(int id, int userId) {
        String sql = "SELECT * FROM bills WHERE id = ? AND user_id = ?";
        try {
            List<Bill> bills = this.findBySql(sql, id, userId);
            if (!bills.isEmpty()) {
                return bills.get(0);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
@Override
    public int createWithBillDetails(Bill bill, List<BillDetail> billDetails){
        String sqlBill = "INSERT INTO bills(user_id, code, created_at, total, status) values (?, ?, ?, ?, ?)";
        try {
            PreparedStatement stmt = DBConnect.createPreStmt(sqlBill, bill.getUserId(), bill.getCode(),
                    bill.getCreatedAt(), bill.getTotal(), bill.getStatus());
            int rs = stmt.executeUpdate();
            if (rs > 0) {
                ResultSet generatedKeys = stmt.getGeneratedKeys();
                if (generatedKeys.next()) {
                    int billId = generatedKeys.getInt(1);
                    for (BillDetail billDetail : billDetails) {
                        billDetail.setBillId(billId);
                        billDetailDAO.create(billDetail);
                    }
                    updateTotal(billId);
                    return billId;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
@Override
    public int updateStatus(int billId, String status){
        Bill bill = this.findById(billId);
        if (bill.getStatus().equals(BillDAOImpl.STATUS_WAITING)) {
            if (status.equals(BillDAOImpl.STATUS_FINISH) || status.equals(BillDAOImpl.STATUS_CANCEL)) {
                String sql = "UPDATE bills SET status = ? WHERE id = ?";
                try {
                    return DBConnect.executeUpdate(sql, status, billId);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        } else if (bill.getStatus().equals(BillDAOImpl.STATUS_FINISH)) {
            if (status.equals(BillDAOImpl.STATUS_CANCEL)) {
                String sql = "UPDATE bills SET status = ? WHERE id = ?";
                try {
                    return DBConnect.executeUpdate(sql, status, billId);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
        return 0;
    }
@Override
    public int updateTotal(int billId){
    List<BillDetail> billDetails = billDetailDAO.findByBillId(billId);
    int total = 0;
    for (BillDetail billDetail : billDetails) {
        total += billDetail.getPrice() * billDetail.getQuantity();
    }
    String sql = "UPDATE bills SET total = ? WHERE id = ?";
    try {
        return DBConnect.executeUpdate(sql, total, billId);
    } catch (Exception e) {
        e.printStackTrace();
    }
    return 0;
}
    public List<Bill> findByUserId(int userId) {
        String sql = "SELECT * FROM bills WHERE user_id = ? ORDER BY CASE status WHEN 'waiting' THEN 1 WHEN 'finish' THEN 2 WHEN 'cancel' THEN 3 END";
        try {
            return this.findBySql(sql, userId);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return new ArrayList<Bill>();
    }
@Override
public List<Bill> findBySql(String sql, Object... value) {
    // TODO Auto-generated method stub
    return null;
}
@Override
public Bill findById(int id) {
    // TODO Auto-generated method stub
    return null;
}

}

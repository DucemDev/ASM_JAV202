package com.cafe.dao;

import com.cafe.entity.Bill;
import com.cafe.entity.BillDetail;
import com.cafe.entity.Drink;
import com.cafe.util.DBConnect;

import java.util.ArrayList;
import java.util.List;

public class BillDetailDAOImpl implements BillDetailDAO {
    BillDAO billDAO = new BillDAOImpl();
    DrinkDAO drinkDAO = new DrinkDAOImpl();
    @Override
    public List<BillDetail> findByBillId(int billId) {
        String sql = "SELECT * FROM bill_details WHERE bill_id = ?";
        try {
            return this.findBySql(sql, billId);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return new ArrayList<BillDetail>();
    }
    @Override
    public int addDrinkToBill(int billId, int drinkId) {
        Bill bill = billDAO.findById(billId);
        if (bill == null || !bill.getStatus().equals(BillDAO.STATUS_WAITING)) {
            return 0;
        }
        String sqlCheck = "SELECT * FROM bill_details WHERE bill_id = ? AND drink_id = ?";
        try {
            List<BillDetail> list = this.findBySql(sqlCheck, billId, drinkId);
            if (list.size() > 0) {
                BillDetail billDetail = list.get(0);
                return this.updateQuantity(billId, drinkId, billDetail.getQuantity() + 1);
            } else {
                Drink drink = drinkDAO.findById(drinkId);
                String sqlInsert = "INSERT INTO bill_details(bill_id, drink_id, quantity, price) VALUES(?, ?, ?, ?)";
                int rs = DBConnect.executeUpdate(sqlInsert, billId, drinkId, 1, drink.getPrice());
                if (rs > 0) {
                    billDAO.updateTotal(billId);
                }
                return rs;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
    @Override
    public int updateQuantity(int billId, int drinkId, int quantity) {
        Bill bill = billDAO.findById(billId);
        if (bill != null && bill.getStatus().equals(BillDAO.STATUS_WAITING)) {
            if (quantity <= 0) {
                String sql = "DELETE FROM bill_details WHERE bill_id = ? AND drink_id = ?";
                try {
                    int rs = DBConnect.executeUpdate(sql, billId, drinkId);
                    if (rs > 0) {
                        billDAO.updateTotal(billId);
                    }
                    return rs;
                } catch (Exception e) {
                    e.printStackTrace();
                }
            } else {
                String sql = "UPDATE bill_details SET quantity = ? WHERE bill_id = ? AND drink_id = ?";
                try {
                    int rs = DBConnect.executeUpdate(sql, quantity, billId, drinkId);
                    if (rs > 0) {
                        billDAO.updateTotal(billId);
                    }
                    return rs;
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
        return 0;
    }
    @Override
    public int create(BillDetail billdetail) {
        String sql = "INSERT INTO bill_details(bill_id, drink_id, quantity, price) values(?, ?, ?, ?)";
        try {
            return DBConnect.executeUpdate(sql, billdetail.getBillId(), billdetail.getDrinkId(), billdetail.getQuantity(),
                    billdetail.getPrice());
        } catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
        }
        return 0;
    }
    @Override
    public int update(BillDetail billdetail) {
        String sql = "UPDATE bill_details SET bill_id = ?, drink_id = ?, quantity = ?, price = ? WHERE id = ?";
        try {
            return DBConnect.executeUpdate(sql, billdetail.getBillId(), billdetail.getDrinkId(), billdetail.getQuantity(),
                    billdetail.getPrice(), billdetail.getId());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    @Override
    public BillDetail findById(Integer id) {
        return null;
    }
        @Override
        public List<BillDetail> findBySql(String sql, Object... value) {
            return null;
        }
    }


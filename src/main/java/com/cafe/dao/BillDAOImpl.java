package com.cafe.dao;

import com.cafe.entity.Bill;
import com.cafe.entity.BillDetail;
import com.cafe.util.DBConnect;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class BillDAOImpl implements BillDAO {

    @Override
    public int create(Bill bill) {

        String sql = "INSERT INTO bills(table_id, user_id, code, total, status, type) VALUES (?, ?, ?, ?, ?, ?)";

        try {
            return DBConnect.executeUpdate(sql,
                    bill.getTableId(),
                    bill.getUserId(),
                    bill.getCode(),
                    0,
                    bill.getStatus(),
                    bill.getType()
            );
        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }

    @Override
    public int update(Bill bill) {
        String sql = "UPDATE bills SET user_id = ?, code = ?, created_at = ?, total = ?, status = ?, type = ? WHERE id = ?";
        try {
            return DBConnect.executeUpdate(sql,
                    bill.getUserId(),
                    bill.getCode(),
                    bill.getCreatedAt(),
                    bill.getTotal(),
                    bill.getStatus(),
                    bill.getType(),
                    bill.getId()
            );
        } catch (Exception e) {
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
    public int createWithBillDetails(Bill bill, List<BillDetail> billDetails) {

        String sqlBill = "INSERT INTO bills(user_id, code, created_at, total, status, type) VALUES (?, ?, ?, ?, ?, ?)";

        try {
            PreparedStatement stmt = DBConnect.createPreStmt(
                    sqlBill,
                    bill.getUserId(),
                    bill.getCode(),
                    bill.getCreatedAt(),
                    bill.getTotal(),
                    bill.getStatus(),
                    bill.getType()
            );

            int rs = stmt.executeUpdate();

            if (rs > 0) {

                ResultSet generatedKeys = stmt.getGeneratedKeys();

                if (generatedKeys.next()) {

                    int billId = generatedKeys.getInt(1);

                    BillDetailDAO billDetailDAO = new BillDetailDAOImpl();

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
    public int updateStatus(int billId, String status) {

        Bill bill = this.findById(billId);

        if (bill == null) {
            return 0;
        }

        String currentStatus = bill.getStatus();

        // waiting -> pending_verify / finish / cancel
        if (currentStatus.equals(BillDAOImpl.STATUS_WAITING)) {

            if (status.equals("pending_verify")
                    || status.equals(BillDAOImpl.STATUS_FINISH)
                    || status.equals(BillDAOImpl.STATUS_CANCEL)) {

                String sql = "UPDATE bills SET status = ? WHERE id = ?";
                try {
                    return DBConnect.executeUpdate(sql, status, billId);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }

        // pending_verify -> finish / cancel
        else if (currentStatus.equals("pending_verify")) {

            if (status.equals(BillDAOImpl.STATUS_FINISH)
                    || status.equals(BillDAOImpl.STATUS_CANCEL)) {

                String sql = "UPDATE bills SET status = ? WHERE id = ?";
                try {
                    return DBConnect.executeUpdate(sql, status, billId);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }

        // finish -> cancel
        else if (currentStatus.equals(BillDAOImpl.STATUS_FINISH)) {

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
    public int updateTotal(int billId) {

        BillDetailDAO billDetailDAO = new BillDetailDAOImpl();
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
        String sql = """
                SELECT * FROM bills 
                WHERE user_id = ? 
                ORDER BY CASE status
                    WHEN 'waiting' THEN 1
                    WHEN 'pending_verify' THEN 2
                    WHEN 'finish' THEN 3
                    WHEN 'cancel' THEN 4
                END
                """;

        try {
            return this.findBySql(sql, userId);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return new ArrayList<>();
    }

    @Override
    public List<Bill> findBySql(String sql, Object... value) {

        List<Bill> list = new ArrayList<>();

        try {
            ResultSet rs = DBConnect.executeQuery(sql, value);

            while (rs.next()) {
                Bill b = new Bill();
                b.setId(rs.getInt("id"));
                b.setTableId(rs.getInt("table_id"));
                b.setUserId(rs.getInt("user_id"));
                b.setCode(rs.getString("code"));
                b.setStatus(rs.getString("status"));
                b.setTotal(rs.getInt("total"));
                b.setType(rs.getString("type"));

                java.sql.Date createdDate = rs.getDate("created_at");
                b.setCreatedAt(createdDate != null ? createdDate.toLocalDate() : null);

                try {
                    b.setUserFullName(rs.getString("user_fullname"));
                } catch (Exception ignore) {
                    b.setUserFullName(null);
                }

                list.add(b);
            }

    } catch (Exception e) {
        System.out.println("SQL lỗi tại BillDAOImpl.findBySql: " + sql);
        e.printStackTrace();
    }

        return list;
    }

    @Override
    public Bill findById(int id) {
        String sql = "SELECT * FROM bills WHERE id = ?";
        List<Bill> list = this.findBySql(sql, id);
        return list.isEmpty() ? null : list.get(0);
    }

    @Override
    public Bill findOpenByTableId(int tableId) {

        String sql = "SELECT * FROM bills WHERE table_id=? AND status='waiting'";
        

        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, tableId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Bill b = new Bill();
                b.setId(rs.getInt("id"));
                b.setTableId(rs.getInt("table_id"));
                b.setUserId(rs.getInt("user_id"));
                b.setCode(rs.getString("code"));
                b.setStatus(rs.getString("status"));
                b.setTotal(rs.getInt("total"));
                b.setType(rs.getString("type"));
                return b;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    @Override
    public Bill findOpenByUserId(int userId) {

        String sql = "SELECT TOP 1 * FROM bills WHERE user_id=? AND status='waiting' ORDER BY id DESC";

        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Bill b = new Bill();
                b.setId(rs.getInt("id"));
                b.setTableId(rs.getInt("table_id"));
                b.setUserId(rs.getInt("user_id"));
                b.setCode(rs.getString("code"));
                b.setStatus(rs.getString("status"));
                b.setTotal(rs.getInt("total"));
                b.setType(rs.getString("type"));
                return b;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<Bill> findPendingOnlineOrders() {

        String sql = "SELECT * FROM bills WHERE type='online' AND status='pending_verify' ORDER BY id DESC";

        return findBySql(sql);
    }
}

        package com.cafe.servlet.CRUD;

import com.cafe.dao.BillDAO;
import com.cafe.dao.BillDAOImpl;
import com.cafe.entity.Bill;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/manager/bill")
public class BillServlet extends HttpServlet {

    private BillDAO billDAO = new BillDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // ✅ Lấy tất cả bill
        String keyword = req.getParameter("keyword");
        String status = req.getParameter("status");
        String fromDate = req.getParameter("fromDate");
        String toDate = req.getParameter("toDate");

        StringBuilder sql = new StringBuilder("SELECT * FROM bills WHERE 1=1");
        java.util.List<Object> params = new java.util.ArrayList<>();

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append(" AND CAST(id AS VARCHAR(20)) LIKE ?");
            params.add("%" + keyword.trim() + "%");
        }

        if (status != null && !status.trim().isEmpty()) {
            sql.append(" AND status = ?");
            params.add(status.trim());
        }

        if (fromDate != null && !fromDate.trim().isEmpty()) {
            sql.append(" AND CAST(created_at AS DATE) >= ?");
            params.add(fromDate.trim());
        }

        if (toDate != null && !toDate.trim().isEmpty()) {
            sql.append(" AND CAST(created_at AS DATE) <= ?");
            params.add(toDate.trim());
        }

        sql.append(" ORDER BY id DESC");
        List<Bill> list = billDAO.findBySql(sql.toString(), params.toArray());

        req.setAttribute("billList", list);
        req.setAttribute("keyword", keyword);
        req.setAttribute("status", status);
        req.setAttribute("fromDate", fromDate);
        req.setAttribute("toDate", toDate);

        req.getRequestDispatcher("/WEB-INF/admin/bill-management.jsp")
                .forward(req, resp);
    }
}


package com.cafe.servlet;

import com.cafe.dao.BillDAO;
import com.cafe.dao.BillDAOImpl;
import com.cafe.entity.Bill;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/manager/bill")
public class BillServlet extends HttpServlet {

    private BillDAO billDAO = new BillDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String keyword = req.getParameter("keyword");
        String status = req.getParameter("status");
        String fromDate = req.getParameter("fromDate");
        String toDate = req.getParameter("toDate");

        int page = 1;
        int pageSize = 10;

        try {
            page = Integer.parseInt(req.getParameter("page"));
        } catch (Exception ignored) {}

        int offset = (page - 1) * pageSize;

        // ===== BUILD SQL =====
        StringBuilder sql = new StringBuilder("""
            SELECT b.*, u.full_name AS user_fullname
            FROM bills b
            LEFT JOIN users u ON b.user_id = u.id
            WHERE 1=1
        """);

        List<Object> params = new ArrayList<>();

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append(" AND CAST(b.id AS VARCHAR(20)) LIKE ?");
            params.add("%" + keyword.trim() + "%");
        }

        if (status != null && !status.trim().isEmpty()) {
            sql.append(" AND b.status = ?");
            params.add(status.trim());
        }

        if (fromDate != null && !fromDate.trim().isEmpty()) {
            sql.append(" AND CAST(b.created_at AS DATE) >= ?");
            params.add(fromDate.trim());
        }

        if (toDate != null && !toDate.trim().isEmpty()) {
            sql.append(" AND CAST(b.created_at AS DATE) <= ?");
            params.add(toDate.trim());
        }

        // ===== COUNT =====
        String countSql = "SELECT COUNT(*) FROM (" + sql.toString() + ") AS total";
        int totalRecords = billDAO.countBySql(countSql, params.toArray());
        int totalPages = (int) Math.ceil((double) totalRecords / pageSize);

        // ===== PAGINATION =====
        sql.append(" ORDER BY b.id DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        params.add(offset);
        params.add(pageSize);

        List<Bill> list = billDAO.findBySql(sql.toString(), params.toArray());

        // ===== SET ATTR =====
        req.setAttribute("billList", list);
        req.setAttribute("currentPage", page);
        req.setAttribute("totalPages", totalPages);
        req.setAttribute("totalRecords", totalRecords);

        req.setAttribute("keyword", keyword);
        req.setAttribute("status", status);
        req.setAttribute("fromDate", fromDate);
        req.setAttribute("toDate", toDate);

        req.getRequestDispatcher("/WEB-INF/admin/bill-management.jsp")
                .forward(req, resp);
    }
}
package com.cafe.servlet;

import com.cafe.dao.BillDAO;
import com.cafe.dao.BillDAOImpl;
import com.cafe.entity.Bill;
import com.cafe.entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/personal-bill")
public class PersonalBillServlet extends HttpServlet {

    private final BillDAO billDAO = new BillDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        if (user.getRole() != User.ROLE_CUSTOMER && user.getRole() != User.ROLE_STAFF) {
            resp.sendError(HttpServletResponse.SC_FORBIDDEN, "Admin không được truy cập /personal-bill");
            return;
        }

        String keyword = req.getParameter("keyword");
        String status = req.getParameter("status");
        String fromDate = req.getParameter("fromDate");
        String toDate = req.getParameter("toDate");

        StringBuilder sql = new StringBuilder("""
                SELECT b.*, u.full_name AS user_fullname
                FROM bills b
                LEFT JOIN users u ON b.user_id = u.id
                WHERE b.user_id = ?
                """);

        List<Object> params = new ArrayList<>();
        params.add(user.getId());

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

        sql.append(" ORDER BY b.id DESC");

        List<Bill> billList = billDAO.findBySql(sql.toString(), params.toArray());

        req.setAttribute("billList", billList);
        req.setAttribute("keyword", keyword);
        req.setAttribute("status", status);
        req.setAttribute("fromDate", fromDate);
        req.setAttribute("toDate", toDate);

        req.getRequestDispatcher("/WEB-INF/public/personal-bill.jsp").forward(req, resp);
    }
}

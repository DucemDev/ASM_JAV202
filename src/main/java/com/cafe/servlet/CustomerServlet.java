package com.cafe.servlet;

import com.cafe.dao.BillDAO;
import com.cafe.dao.BillDAOImpl;
import com.cafe.entity.Bill;
import com.cafe.entity.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/customer")
public class CustomerServlet extends HttpServlet {

    private BillDAO billDAO = new BillDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        // chưa login thì quay về login
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // lấy lịch sử đơn hàng
        List<Bill> orders = billDAO.findByUserId(user.getId());

        req.setAttribute("orders", orders);

        req.getRequestDispatcher("/WEB-INF/public/index-customer.jsp")
                .forward(req, resp);
    }
}

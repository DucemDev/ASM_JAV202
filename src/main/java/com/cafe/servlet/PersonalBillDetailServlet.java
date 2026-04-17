package com.cafe.servlet;

import com.cafe.dao.BillDAO;
import com.cafe.dao.BillDAOImpl;
import com.cafe.dao.BillDetailDAO;
import com.cafe.dao.BillDetailDAOImpl;
import com.cafe.dao.DrinkDAO;
import com.cafe.dao.DrinkDAOImpl;
import com.cafe.entity.Bill;
import com.cafe.entity.BillDetail;
import com.cafe.entity.Drink;
import com.cafe.entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/personal-bill/detail")
public class PersonalBillDetailServlet extends HttpServlet {

    private final BillDAO billDAO = new BillDAOImpl();
    private final BillDetailDAO billDetailDAO = new BillDetailDAOImpl();
    private final DrinkDAO drinkDAO = new DrinkDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        if (user.getRole() != User.ROLE_CUSTOMER && user.getRole() != User.ROLE_STAFF) {
            resp.sendError(HttpServletResponse.SC_FORBIDDEN, "Admin không được truy cập /personal-bill/detail");
            return;
        }

        int billId;
        try {
            billId = Integer.parseInt(req.getParameter("id"));
        } catch (Exception e) {
            resp.sendRedirect(req.getContextPath() + "/personal-bill");
            return;
        }

        Bill bill = billDAO.findByIdAndUserId(billId, user.getId());
        if (bill == null) {
            resp.sendError(HttpServletResponse.SC_FORBIDDEN, "Không được xem hóa đơn của user khác");
            return;
        }

        List<BillDetail> billItems = billDetailDAO.findByBillId(billId);
        List<Drink> drinks = drinkDAO.findAll();

        req.setAttribute("bill", bill);
        req.setAttribute("billItems", billItems);
        req.setAttribute("drinks", drinks);

        req.getRequestDispatcher("/WEB-INF/public/personal-bill-detail.jsp").forward(req, resp);
    }
}

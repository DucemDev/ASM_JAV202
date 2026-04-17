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
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/seller/online-orders/detail")
public class OnlineOrderDetailServlet extends HttpServlet {

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

        // Chỉ Staff(1) và Admin(2) được xem
        if (user.getRole() != 1 && user.getRole() != 2) {
            resp.sendError(HttpServletResponse.SC_FORBIDDEN, "Bạn không có quyền xem chi tiết đơn online");
            return;
        }

        int billId;
        try {
            billId = Integer.parseInt(req.getParameter("id"));
        } catch (Exception e) {
            resp.sendRedirect(req.getContextPath() + "/seller/online-orders");
            return;
        }

        Bill bill = billDAO.findById(billId);
        if (bill == null) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Không tìm thấy hóa đơn");
            return;
        }

        if (bill.getType() == null || !bill.getType().equalsIgnoreCase("online")) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Đây không phải đơn online");
            return;
        }

        List<BillDetail> billItems = billDetailDAO.findByBillId(billId);
        List<Drink> drinks = drinkDAO.findAll();

        req.setAttribute("bill", bill);
        req.setAttribute("billItems", billItems);
        req.setAttribute("drinks", drinks);

        req.getRequestDispatcher("/WEB-INF/public/online-order-detail.jsp").forward(req, resp);
    }
}

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
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/manager/bill-detail")
public class BillDetailServlet extends HttpServlet {

    private final BillDetailDAO billDetailDAO = new BillDetailDAOImpl();
    private final BillDAO billDAO = new BillDAOImpl();
    private final DrinkDAO drinkDAO = new DrinkDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String idParam = req.getParameter("id");
        int billId;
        try {
            billId = Integer.parseInt(idParam);
        } catch (Exception e) {
            resp.sendRedirect(req.getContextPath() + "/manager/bill");
            return;
        }

        List<Bill> bills = billDAO.findBySql("""
            SELECT b.*, u.full_name AS user_fullname
            FROM bills b
            LEFT JOIN users u ON b.user_id = u.id
            WHERE b.id = ?
            """, billId);

        Bill bill = bills.isEmpty() ? null : bills.get(0);
        if (bill == null) {
            resp.sendRedirect(req.getContextPath() + "/manager/bill");
            return;
        }

        List<BillDetail> list = billDetailDAO.findByBillId(billId);
        List<Drink> drinks = drinkDAO.findAll();

        req.setAttribute("bill", bill);
        req.setAttribute("billItems", list);
        req.setAttribute("drinks", drinks);

        req.getRequestDispatcher("/WEB-INF/admin/bill-detail.jsp")
                .forward(req, resp);
    }
}

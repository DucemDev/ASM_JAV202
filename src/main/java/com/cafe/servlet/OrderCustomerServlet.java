package com.cafe.servlet;

import com.cafe.dao.*;
import com.cafe.entity.Bill;
import com.cafe.entity.BillDetail;
import com.cafe.entity.Category;
import com.cafe.entity.Drink;
import com.cafe.entity.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet({
        "/customer/order",
        "/customer/order/pay",
        "/customer/order/confirm-payment"
})
public class OrderCustomerServlet extends HttpServlet {

    private BillDAO billDAO = new BillDAOImpl();
    private DrinkDAO drinkDAO = new DrinkDAOImpl();
    private CategoryDAO categoryDAO = new CategoryDAOImpl();

    private static final int ONLINE_TABLE_ID = 6;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        String keyword = req.getParameter("keyword");
        Integer categoryId = parseInteger(req.getParameter("categoryId"));

        // Nếu chưa login
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // Tìm bill đang mở
        Bill bill = billDAO.findOpenByUserId(user.getId());

        // Nếu chưa có bill thì tạo mới
        if (bill == null) {
            Bill newBill = new Bill();
            newBill.setTableId(ONLINE_TABLE_ID);
            newBill.setUserId(user.getId());
            newBill.setCode("B" + (System.currentTimeMillis() % 100000));
            newBill.setStatus("waiting");
            newBill.setType("online");

            billDAO.create(newBill);

            bill = billDAO.findOpenByUserId(user.getId());

            // kiểm tra nếu tạo thất bại
            if (bill == null) {
                throw new RuntimeException("Không tạo được bill online");
            }
        }

        List<Drink> drinks = drinkDAO.findFiltered(keyword, categoryId, true);
        List<Category> categories = categoryDAO.findAll();

        BillDetailDAO dao = new BillDetailDAOImpl();
        List<BillDetail> billDetails = dao.findByBillId(bill.getId());

        int total = 0;
        for (BillDetail bd : billDetails) {
            total += bd.getPrice() * bd.getQuantity();
        }

        req.setAttribute("bill", bill);
        req.setAttribute("drinks", drinks);
        req.setAttribute("categories", categories);
        req.setAttribute("billDetails", billDetails);
        req.setAttribute("total", total);
        req.setAttribute("keyword", keyword);
        req.setAttribute("filterCategoryId", categoryId);

        req.getRequestDispatcher("/WEB-INF/public/order-customer.jsp")
                .forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws IOException, ServletException {

        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        // Nếu chưa login
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String uri = req.getRequestURI();
        String action = req.getParameter("action");

        Bill bill = billDAO.findOpenByUserId(user.getId());

        // Nếu chưa có bill
        if (bill == null) {
            resp.sendRedirect(req.getContextPath() + "/customer/order");
            return;
        }

        BillDetailDAO dao = new BillDetailDAOImpl();

        // ================= UPDATE QUANTITY =================
        if ("update".equals(action)) {

            int billId = Integer.parseInt(req.getParameter("billId"));
            int drinkId = Integer.parseInt(req.getParameter("drinkId"));
            int quantity = Integer.parseInt(req.getParameter("quantity"));

            dao.updateQuantity(billId, drinkId, quantity);

            resp.setStatus(HttpServletResponse.SC_OK);
            return;
        }

        // ================= CONFIRM PAYMENT =================
        if (uri.contains("/confirm-payment")) {

            int billId = Integer.parseInt(req.getParameter("billId"));

            // đổi trạng thái sang chờ xác nhận
            billDAO.updateStatus(billId, "pending_verify");

            resp.sendRedirect(req.getContextPath() + "/customer/payment-waiting");
            return;
        }

        // ================= PAY =================
        if (uri.contains("/pay")) {

            List<BillDetail> list = dao.findByBillId(bill.getId());

            if (list == null || list.isEmpty()) {
                resp.sendRedirect(req.getContextPath() + "/customer/order?error=empty");
                return;
            }

            // cập nhật total
            billDAO.updateTotal(bill.getId());

            // load bill mới nhất
            bill = billDAO.findById(bill.getId());

            List<Drink> drinks = drinkDAO.findAll();

            int total = 0;
            for (BillDetail bd : list) {
                total += bd.getPrice() * bd.getQuantity();
            }

            req.setAttribute("bill", bill);
            req.setAttribute("billDetails", list);
            req.setAttribute("drinks", drinks);
            req.setAttribute("total", total);

            // chuyển sang trang QR thanh toán
            req.getRequestDispatcher("/WEB-INF/public/payment.jsp")
                    .forward(req, resp);

            return;
        }

        // ================= ADD DRINK =================
        int drinkId = Integer.parseInt(req.getParameter("drinkId"));
        dao.addDrinkToBill(bill.getId(), drinkId);

        resp.setStatus(HttpServletResponse.SC_OK);
    }

    private Integer parseInteger(String value) {
        try {
            int parsed = Integer.parseInt(value);
            return parsed > 0 ? parsed : null;
        } catch (Exception e) {
            return null;
        }
    }
}

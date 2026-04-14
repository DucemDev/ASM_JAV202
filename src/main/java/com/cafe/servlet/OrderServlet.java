package com.cafe.servlet;

import com.cafe.dao.*;
import com.cafe.entity.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet({
        "/seller/order",
        "/seller/order/pay",
        "/seller/order/cancel"
})
public class OrderServlet extends HttpServlet {
    private static final int PAGE_SIZE = 10;

    private BillDAO billDAO = new BillDAOImpl();
    private TableDAO tableDAO = new TableDAOImpl();
    private DrinkDAO drinkDAO = new DrinkDAOImpl();
    private CategoryDAO categoryDAO = new CategoryDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        try {
            String tableIdParam = req.getParameter("tableId");
            String keyword = req.getParameter("keyword");
            Integer categoryId = parseInteger(req.getParameter("categoryId"));

            if (tableIdParam == null || tableIdParam.isEmpty()) {
                resp.sendRedirect(req.getContextPath() + "/seller/tables");
                return;
            }

            int tableId = Integer.parseInt(tableIdParam);
            int page = parsePage(req.getParameter("page"));
            req.setAttribute("tableId", tableId);

            Bill bill = billDAO.findOpenByTableId(tableId);

            // 🔥 tạo bill nếu chưa có
            if (bill == null) {
                HttpSession session = req.getSession(false);
                User currentUser = (session != null) ? (User) session.getAttribute("user") : null;

                if (currentUser == null) {
                    resp.sendRedirect(req.getContextPath() + "/login");
                    return;
                }

                Bill newBill = new Bill();
                newBill.setTableId(tableId);
                newBill.setUserId(currentUser.getId());
                newBill.setCode("B" + (System.currentTimeMillis() % 100000));
                newBill.setStatus("waiting");
                newBill.setType("pos");

                int rs = billDAO.create(newBill);

                if (rs <= 0) throw new RuntimeException("Tạo bill thất bại");

                tableDAO.updateStatus(tableId, "using");

                bill = billDAO.findOpenByTableId(tableId);
            }

            int totalDrinks = drinkDAO.countFiltered(keyword, categoryId, true);
            int totalPages = Math.max(1, (int) Math.ceil((double) totalDrinks / PAGE_SIZE));
            if (page > totalPages) {
                page = totalPages;
            }
            List<Drink> drinks = drinkDAO.findFilteredPage(page, PAGE_SIZE, keyword, categoryId, true);
            List<Category> categories = categoryDAO.findAll();

            BillDetailDAO billDetailDAO = new BillDetailDAOImpl();
            List<BillDetail> billDetails = billDetailDAO.findByBillId(bill.getId());

            int total = 0;
            for (BillDetail bd : billDetails) {
                total += bd.getPrice() * bd.getQuantity();
            }

            req.setAttribute("bill", bill);
            req.setAttribute("drinks", drinks);
            req.setAttribute("categories", categories);
            req.setAttribute("billDetails", billDetails);
            req.setAttribute("total", total);
            req.setAttribute("currentPage", page);
            req.setAttribute("totalPages", totalPages);
            req.setAttribute("keyword", keyword);
            req.setAttribute("filterCategoryId", categoryId);

            req.getRequestDispatcher("/WEB-INF/public/seller/order.jsp")
                    .forward(req, resp);

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/seller/tables");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        try {
            String uri = req.getRequestURI();
            int tableId = Integer.parseInt(req.getParameter("tableId"));

            // ================= UPDATE QUANTITY =================
            String action = req.getParameter("action");

            if ("update".equals(action)) {

                int billId = Integer.parseInt(req.getParameter("billId"));
                int drinkId = Integer.parseInt(req.getParameter("drinkId"));
                int quantity = Integer.parseInt(req.getParameter("quantity"));

                BillDetailDAO dao = new BillDetailDAOImpl();
                dao.updateQuantity(billId, drinkId, quantity);

                resp.setStatus(HttpServletResponse.SC_OK);
                return;
            }

            // ================= CANCEL =================
            if (uri.contains("/cancel")) {

                Bill bill = billDAO.findOpenByTableId(tableId);

                if (bill != null) {
                    BillDetailDAO dao = new BillDetailDAOImpl();
                    List<BillDetail> list = dao.findByBillId(bill.getId());

                    for (BillDetail bd : list) {
                        dao.updateQuantity(bill.getId(), bd.getDrinkId(), 0);
                    }

                    billDAO.updateStatus(bill.getId(), "cancel");
                }

                tableDAO.updateStatus(tableId, "empty");

                resp.sendRedirect(req.getContextPath() + "/seller/tables");
                return;
            }

            // ================= PAY =================
            if (uri.contains("/pay")) {

                int billId = Integer.parseInt(req.getParameter("billId"));

                BillDetailDAO dao = new BillDetailDAOImpl();
                List<BillDetail> list = dao.findByBillId(billId);

                if (list == null || list.isEmpty()) {
                    resp.sendRedirect(req.getContextPath() + "/seller/order?tableId=" + tableId + "&error=empty");
                    return;
                }

                Bill bill = billDAO.findById(billId);

                List<Drink> drinks = drinkDAO.findAll();

                billDAO.updateStatus(billId, "finish");
                tableDAO.updateStatus(tableId, "empty");

                req.setAttribute("bill", bill);
                req.setAttribute("billDetails", list);
                req.setAttribute("drinks", drinks);
                req.setAttribute("total", bill.getTotal());

                req.getRequestDispatcher("/WEB-INF/public/seller/payment-success.jsp")
                        .forward(req, resp);

                return;
            }

            // ================= ADD =================
            int drinkId = Integer.parseInt(req.getParameter("drinkId"));

            Bill bill = billDAO.findOpenByTableId(tableId);

            int billId = bill.getId();

            BillDetailDAO dao = new BillDetailDAOImpl();
            dao.addDrinkToBill(billId, drinkId);

            resp.setStatus(HttpServletResponse.SC_OK);

        } catch (Exception e) {
            e.printStackTrace();
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    private int parsePage(String pageParam) {
        try {
            int page = Integer.parseInt(pageParam);
            return Math.max(page, 1);
        } catch (Exception e) {
            return 1;
        }
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

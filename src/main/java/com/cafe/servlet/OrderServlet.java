package com.cafe.servlet;

import com.cafe.dao.*;
import com.cafe.entity.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/seller/order")
public class OrderServlet extends HttpServlet {

    private BillDAO billDAO = new BillDAOImpl();
    private TableDAO tableDAO = new TableDAOImpl();
    private DrinkDAO drinkDAO = new DrinkDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        try {
            String tableIdParam = req.getParameter("tableId");

            if (tableIdParam == null || tableIdParam.isEmpty()) {
                resp.sendRedirect(req.getContextPath() + "/seller/tables");
                return;
            }

            int tableId = Integer.parseInt(tableIdParam);
            req.setAttribute("tableId", tableId);

            // ===== LẤY BILL =====
            Bill bill = billDAO.findOpenByTableId(tableId);

            // ===== TẠO BILL NẾU CHƯA CÓ =====
            if (bill == null) {

                Bill newBill = new Bill();
                newBill.setTableId(tableId);
                newBill.setUserId(1);
                newBill.setCode("B" + (System.currentTimeMillis() % 100000));
                newBill.setStatus("waiting");

                int result = billDAO.create(newBill);

                if (result <= 0) {
                    throw new RuntimeException("Không tạo được bill");
                }

                tableDAO.updateStatus(tableId, "using");

                bill = billDAO.findOpenByTableId(tableId);

                if (bill == null) {
                    throw new RuntimeException("Không lấy được bill sau khi tạo");
                }
            }

            // ===== LOAD DRINK =====
            List<Drink> drinks = drinkDAO.findAll();

            // ===== LOAD BILL DETAIL =====
            BillDetailDAO billDetailDAO = new BillDetailDAOImpl();
            List<BillDetail> billDetails = billDetailDAO.findByBillId(bill.getId());

            // ===== TÍNH TOTAL =====
            int total = 0;
            for (BillDetail bd : billDetails) {
                total += bd.getPrice() * bd.getQuantity();
            }

            // ===== SET DATA =====
            req.setAttribute("bill", bill);
            req.setAttribute("drinks", drinks);
            req.setAttribute("billDetails", billDetails);
            req.setAttribute("total", total);

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
            String billIdParam = req.getParameter("billId");
            String drinkIdParam = req.getParameter("drinkId");
            String tableIdParam = req.getParameter("tableId");

            if (billIdParam == null || drinkIdParam == null || tableIdParam == null
                    || billIdParam.isEmpty() || drinkIdParam.isEmpty() || tableIdParam.isEmpty()) {

                throw new RuntimeException("Thiếu param");
            }

            int billId = Integer.parseInt(billIdParam);
            int drinkId = Integer.parseInt(drinkIdParam);
            int tableId = Integer.parseInt(tableIdParam);

            BillDetailDAO billDetailDAO = new BillDetailDAOImpl();
            int rs = billDetailDAO.addDrinkToBill(billId, drinkId);

            if (rs <= 0) {
                throw new RuntimeException("Thêm món thất bại");
            }

            resp.sendRedirect(req.getContextPath() + "/seller/order?tableId=" + tableId);

        } catch (Exception e) {
            e.printStackTrace();

            // ❗ KHÔNG redirect về tables nữa
            resp.sendRedirect(req.getContextPath() + "/seller/order?tableId=" + req.getParameter("tableId"));
        }
    }
}
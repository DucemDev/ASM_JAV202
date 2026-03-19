package com.cafe.servlet;

import com.cafe.dao.*;
import com.cafe.entity.*;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/sell")
public class SellerServlet extends HttpServlet {

    CategoryDAO categoryDAO = new CategoryDAOImpl();
    DrinkDAO drinkDAO = new DrinkDAOImpl();
    BillDAO billDAO = new BillDAOImpl();
    BillDetailDAO billDetailDAO = new BillDetailDAOImpl();
    TableDAO tableDAO = new TableDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String tableParam = req.getParameter("tableId");

        // 🔥 CASE 1: CHƯA CHỌN BÀN → HIỂN THỊ GRID
        if (tableParam == null || tableParam.isEmpty()) {

            List<Table> tables = tableDAO.findAll();

            req.setAttribute("tables", tables);

            req.getRequestDispatcher("/WEB-INF/public/seller/seller.jsp")
                    .forward(req, resp);

            return;
        }

        // 🔥 CASE 2: ĐÃ CHỌN BÀN → POS
        int tableId = Integer.parseInt(tableParam);

        // CATEGORY
        List<Category> categories = categoryDAO.findAll();

        // FILTER CATEGORY
        String categoryParam = req.getParameter("categoryId");

        List<Drink> drinks;

        if (categoryParam != null && !categoryParam.isEmpty()) {
            drinks = drinkDAO.findByCategory(Integer.parseInt(categoryParam));
        } else {
            drinks = drinkDAO.findAll();
        }

        // BILL
        Bill bill = billDAO.findByTableId(tableId);

        List<BillDetail> billDetails = null;

        if (bill != null) {
            billDetails = billDetailDAO.findByBillId(bill.getId());
        }

        // SET DATA
        req.setAttribute("categories", categories);
        req.setAttribute("drinks", drinks);
        req.setAttribute("billDetails", billDetails);
        req.setAttribute("tableId", tableId);

        req.getRequestDispatcher("/WEB-INF/public/seller/pos.jsp")
                .forward(req, resp);
    }
}
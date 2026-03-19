package com.cafe.servlet;

import com.cafe.dao.*;
import com.cafe.entity.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/add-to-cart")
public class AddToCartServlet extends HttpServlet {

    BillDAO billDAO = new BillDAOImpl();
    BillDetailDAO billDetailDAO = new BillDetailDAOImpl();
    DrinkDAO drinkDAO = new DrinkDAOImpl();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        int tableId = Integer.parseInt(req.getParameter("tableId"));
        int drinkId = Integer.parseInt(req.getParameter("drinkId"));

        // 🔥 1. tìm bill đang mở
        Bill bill = billDAO.findByTableId(tableId);

        // 🔥 2. nếu chưa có → tạo bill
        if (bill == null) {

            bill = new Bill();
            bill.setTableId(tableId);
            bill.setUserId(1); // tạm (sau lấy từ session)
            bill.setTotal(0);
            bill.setStatus("waiting");

            billDAO.create(bill);

            // load lại bill vừa tạo
            bill = billDAO.findByTableId(tableId);
        }

        // 🔥 3. lấy drink
        Drink drink = drinkDAO.findById(drinkId);

        // 🔥 4. insert bill_detail
        BillDetail bd = new BillDetail();
        bd.setBillId(bill.getId());
        bd.setDrinkId(drinkId);
        bd.setQuantity(1);
        bd.setPrice(drink.getPrice());

        billDetailDAO.insert(bd);

        // 🔥 5. update total bill
        bill.setTotal(bill.getTotal() + drink.getPrice());
        billDAO.update(bill);

        // 🔥 6. quay lại POS
        resp.sendRedirect("sell?tableId=" + tableId);
    }
}
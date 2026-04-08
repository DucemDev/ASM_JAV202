
        package com.cafe.servlet.CRUD;

import com.cafe.dao.BillDAO;
import com.cafe.dao.BillDAOImpl;
import com.cafe.entity.Bill;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/manager/bill")
public class BillServlet extends HttpServlet {

    private BillDAO billDAO = new BillDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // ✅ Lấy tất cả bill
        String sql = "SELECT * FROM bills ORDER BY id DESC";
        List<Bill> list = billDAO.findBySql(sql);

        req.setAttribute("billList", list);

        req.getRequestDispatcher("/WEB-INF/admin/bill-management.jsp")
                .forward(req, resp);
    }
}


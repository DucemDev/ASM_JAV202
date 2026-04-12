package com.cafe.servlet;

import com.cafe.dao.BillDAO;
import com.cafe.dao.BillDAOImpl;
import com.cafe.entity.Bill;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet({
        "/seller/online-orders",
        "/seller/online-orders/confirm"
})
public class OnlineOrderServlet extends HttpServlet {

    private BillDAO billDAO = new BillDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        List<Bill> list = billDAO.findPendingOnlineOrders();

        req.setAttribute("orders", list);

        req.getRequestDispatcher("/WEB-INF/public/online-order.jsp")
                .forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        String uri = req.getRequestURI();

        if (uri.contains("/confirm")) {

            int billId = Integer.parseInt(req.getParameter("billId"));

            billDAO.updateStatus(billId, "finish");
        }

        resp.sendRedirect(req.getContextPath() + "/seller/online-orders");
    }
}
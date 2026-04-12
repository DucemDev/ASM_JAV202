package com.cafe.servlet.CRUD;
import com.cafe.dao.BillDetailDAO;
import com.cafe.dao.BillDetailDAOImpl;
import com.cafe.entity.BillDetail;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/manager/bill-detail")
public class BillDetailServlet extends HttpServlet {

    private BillDetailDAO billDetailDAO = new BillDetailDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        int billId = Integer.parseInt(req.getParameter("id"));

        // ✅ đúng method của mày
        List<BillDetail> list = billDetailDAO.findByBillId(billId);

        req.setAttribute("detailList", list);
        req.setAttribute("billId", billId);

        req.getRequestDispatcher("/WEB-INF/admin/bill-detail.jsp")
                .forward(req, resp);
    }
}


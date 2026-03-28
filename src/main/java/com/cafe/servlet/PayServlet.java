package com.cafe.servlet;

import com.cafe.dao.BillDAO;
import com.cafe.dao.BillDAOImpl;
import com.cafe.dao.TableDAO;
import com.cafe.dao.TableDAOImpl;
import com.cafe.entity.Bill;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/seller/order/pay")
public class PayServlet extends HttpServlet {

    private BillDAO billDAO = new BillDAOImpl();
    private TableDAO tableDAO = new TableDAOImpl();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        try {

            // ===== 1. Lấy billId =====
            String billIdParam = req.getParameter("billId");

            if (billIdParam == null || billIdParam.isEmpty()) {
                resp.sendRedirect(req.getContextPath() + "/seller/tables");
                return;
            }

            int billId = Integer.parseInt(billIdParam);

            // ===== 2. Lấy bill =====
            Bill bill = billDAO.findById(billId);

            if (bill == null) {
                resp.sendRedirect(req.getContextPath() + "/seller/tables");
                return;
            }

            // ===== 3. Update bill → finish =====
            billDAO.updateStatus(billId, BillDAO.STATUS_FINISH);

            // ===== 4. Update bàn → empty =====
            tableDAO.updateStatus(bill.getTableId(), "empty");

            // ===== 5. Redirect về tables =====
            resp.sendRedirect(req.getContextPath() + "/seller/tables");

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/seller/tables");
        }
    }
}
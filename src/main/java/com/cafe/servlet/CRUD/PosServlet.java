package com.cafe.servlet.CRUD;

import com.cafe.dao.BillDAO;
import com.cafe.dao.BillDAOImpl;
import com.cafe.dao.BillDetailDAOImpl;
import com.cafe.dao.DrinkDAOImpl;
import com.cafe.entity.Bill;
import com.cafe.entity.BillDetail;
import com.cafe.entity.Drink;
import com.cafe.util.AuthUtil;
import com.cafe.util.ParamUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.Date;
import java.util.List;

@WebServlet({ "/employee/pos", "/employee/pos/init", "/employee/pos/add-item", "/employee/pos/update-quantity",
        "/employee/pos/checkout", "/employee/pos/cancel" })
public class PosServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private DrinkDAOImpl drinkDAO = new DrinkDAOImpl();
    private BillDAOImpl billDAO = new BillDAOImpl();
    private BillDetailDAOImpl billDetailDAO = new BillDetailDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String sql = "SELECT * FROM drinks WHERE active = ?";
        List<Drink> drinks = drinkDAO.findBySql(sql, 1);

        int billId = ParamUtil.getInt(req, "billId");
        int userId = AuthUtil.getUser(req).getId();

        if (billId != 0) {
            Bill bill = billDAO.findByIdAndUserId(billId, userId);
            if (bill != null) {
                List<BillDetail> billDetail = billDetailDAO.findByBillId(billId);
            }
        }


        req.getRequestDispatcher("/views/pos/view.jsp").forward(req, resp);
    }


    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    }
    public void create(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        int billId = ParamUtil.getInt(req, "billId");
        int userId = AuthUtil.getUser(req).getId();
        int drinkId = ParamUtil.getInt(req, "drinkId");
        Drink drink = drinkDAO.findById(drinkId);

        if (billId == 0) {
            Date now = new Date();
            LocalDate localDate = now.toInstant()
                    .atZone(ZoneId.systemDefault())
                    .toLocalDate();
            Bill bill = new Bill();
            bill.setUserId(userId);
            bill.setCode("BILL-" + now.getTime());
            bill.setCreatedAt(localDate);
            bill.setTotal(String.valueOf(drink.getPrice()));
            bill.setStatus(BillDAO.STATUS_WAITING);

            List<BillDetail> billDetails = List.of(new BillDetail(0, 0, drinkId, 1, drink.getPrice()));

            int billIdDB = billDAO.createWithBillDetails(bill, billDetails);
            if (billIdDB > 0) {
                resp.sendRedirect(req.getContextPath() + "/employee/pos?billId=" + billIdDB);
            }
        } else {
            int rs = billDetailDAO.addDrinkToBill(billId, drinkId);
            if (rs > 0) {
                resp.sendRedirect(req.getContextPath() + "/employee/pos?billId=" + billId);
            }
        }

    }

    public void updateOrder(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        int billId = ParamUtil.getInt(req, "billId");
        Integer billDetailId = ParamUtil.getInt(req, "billDetailId");
        String action = ParamUtil.getString(req, "action");

        if (action.equals("increase")) {
            BillDetail billDetail = billDetailDAO.findById(billDetailId);
            if (billDetail != null) {
                billDetailDAO.updateQuantity(billId, billDetail.getDrinkId(), billDetail.getQuantity() + 1);
            }
        } else if (action.equals("decrease")) {
            BillDetail billDetail = billDetailDAO.findById(billDetailId);
            if (billDetail != null) {
                billDetailDAO.updateQuantity(billId, billDetail.getDrinkId(), billDetail.getQuantity() - 1);
            }
        } else if (action.equals("remove")) {
            BillDetail billDetail = billDetailDAO.findById(billDetailId);
            if (billDetail != null) {
                billDetailDAO.updateQuantity(billId, billDetail.getDrinkId(), 0);
            }
        }
        resp.sendRedirect(req.getContextPath() + "/employee/pos?billId=" + billId);
    }

    public void checkout(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int billId = ParamUtil.getInt(req, "billId");
        int userId = AuthUtil.getUser(req).getId();

        Bill bill = billDAO.findByIdAndUserId(billId, userId);
        if (bill != null) {
            billDAO.updateStatus(billId, BillDAO.STATUS_FINISH);
            resp.sendRedirect(req.getContextPath() + "/employee/pos");
        }
    }

    public void cancel(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int billId = ParamUtil.getInt(req, "billId");
        int userId = AuthUtil.getUser(req).getId();

        Bill bill = billDAO.findByIdAndUserId(billId, userId);
        if (bill != null) {
            billDAO.updateStatus(billId, BillDAO.STATUS_CANCEL);
            resp.sendRedirect(req.getContextPath() + "/employee/pos");
        }
    }

}
